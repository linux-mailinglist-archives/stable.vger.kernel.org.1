Return-Path: <stable+bounces-34119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04EE893DF7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF67B22B9F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC347A79;
	Mon,  1 Apr 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whiqKJkw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8B47A62;
	Mon,  1 Apr 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987060; cv=none; b=dwXteXqTFoB3jd7C4pjUPt0xoKo5xwzIIrr+JIjPaNIN3sX5kRYP7sYHsrZzoY1Gwd8dtcGdXl26uImNa6Z67FlNggN0kx78nFrs/iIEHbXjE5jnxrtapaASBoN9QI8nyUMLAzNFBC9AvIOBJaCkw9hldr+uxwlZw+swD7iqKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987060; c=relaxed/simple;
	bh=XYzzfruTys38wfYcRn+0Y641PUbhg1o4gpxVcUxZQes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWLvPgWzwI+kjBZch8Ruo495sDn9JAoPSKWegTZfPFjUsv05qhWfjEr6cgaovy3RES3nC4lZXyS8hkdPPWLhGGbDVijfMIwtBIuvjBJcPwR7o+hD5b4bkrw/ujS3t6Zg7pABjI2iXbyi8AajVRj+i6Ol8FNA2VmXETfy1+prm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whiqKJkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FAEC433C7;
	Mon,  1 Apr 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987060;
	bh=XYzzfruTys38wfYcRn+0Y641PUbhg1o4gpxVcUxZQes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whiqKJkw+5HOtUfXv/5S7MOWaOhXd2vGpK/4CWKqddzyOjvExJRf10ctelAsWA9qr
	 l9BN+3xHqT/A+CKjd/lW1ICGOcHsS41QAVv1Qm6pXJrkNZ1Ggrpku3yn8LW9h2FHJX
	 nLykTui1lHmRaKAOSBDk5tEgoH+UwNwytzgR63Ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Greear <greearb@candelatech.com>,
	Madhan Sai <madhan.singaraju@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 131/399] debugfs: fix wait/cancellation handling during remove
Date: Mon,  1 Apr 2024 17:41:37 +0200
Message-ID: <20240401152553.102311657@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 952c3fce297f12c7ff59380adb66b564e2bc9b64 ]

Ben Greear further reports deadlocks during concurrent debugfs
remove while files are being accessed, even though the code in
question now uses debugfs cancellations. Turns out that despite
all the review on the locking, we missed completely that the
logic is wrong: if the refcount hits zero we can finish (and
need not wait for the completion), but if it doesn't we have
to trigger all the cancellations. As written, we can _never_
get into the loop triggering the cancellations. Fix this, and
explain it better while at it.

Cc: stable@vger.kernel.org
Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancellation")
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/r/1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com
Tested-by: Madhan Sai <madhan.singaraju@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20240229153635.6bfab7eb34d3.I6c7aeff8c9d6628a8bc1ddcf332205a49d801f17@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5e..a40da00654336 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,28 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	/* if we hit zero, just wait for all to finish */
-	if (!refcount_dec_and_test(&fsd->active_users)) {
-		wait_for_completion(&fsd->active_users_drained);
+	/* if this was the last reference, we're done */
+	if (refcount_dec_and_test(&fsd->active_users))
 		return;
-	}
 
-	/* if we didn't hit zero, try to cancel any we can */
+	/*
+	 * If there's still a reference, the code that obtained it can
+	 * be in different states:
+	 *  - The common case of not using cancellations, or already
+	 *    after debugfs_leave_cancellation(), where we just need
+	 *    to wait for debugfs_file_put() which signals the completion;
+	 *  - inside a cancellation section, i.e. between
+	 *    debugfs_enter_cancellation() and debugfs_leave_cancellation(),
+	 *    in which case we need to trigger the ->cancel() function,
+	 *    and then wait for debugfs_file_put() just like in the
+	 *    previous case;
+	 *  - before debugfs_enter_cancellation() (but obviously after
+	 *    debugfs_file_get()), in which case we may not see the
+	 *    cancellation in the list on the first round of the loop,
+	 *    but debugfs_enter_cancellation() signals the completion
+	 *    after adding it, so this code gets woken up to call the
+	 *    ->cancel() function.
+	 */
 	while (refcount_read(&fsd->active_users)) {
 		struct debugfs_cancellation *c;
 
-- 
2.43.0




