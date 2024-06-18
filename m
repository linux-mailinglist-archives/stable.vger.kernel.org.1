Return-Path: <stable+bounces-53476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86490D1CC
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D691F279D0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2731A38F6;
	Tue, 18 Jun 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/O22w/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69C1A38F5;
	Tue, 18 Jun 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716438; cv=none; b=IMDIALkV1dWiCb57Bhb1L8/xZaZSKvQ9MKWm1CzulSg25x5ueOTuB9N5XJhl26gxqPN/Q3+1JnwGWutLCS3oe2nqYxcqueZsJn4ipEKkFO3iOiHS/7WeuNtWM4KBHFYOyMJawBIFYlJVg5F63/dpSJuKmILP7/DlvaFXCXPv7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716438; c=relaxed/simple;
	bh=S66cH+2PHbTifQJYiRCpiSy0umhJSlzSbOW9Vol5TQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRP25ePawTdXHmOvehhGny24URxnB7mKghMKuzt9I3KBS8A8agbaS9FUw0xhXgKbdauj1Exur2EQK1p3e5aAbI3zArHAZncdmRx3PqP/+Y5mCNjUU6VPvbh9NVyjVOabjUnwQVd3H+X14c47zHPTTm9dTnihOKyRj92HQ3NHP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/O22w/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73885C3277B;
	Tue, 18 Jun 2024 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716437;
	bh=S66cH+2PHbTifQJYiRCpiSy0umhJSlzSbOW9Vol5TQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/O22w/iYKWR1i60XEMjX0FeDIrxFMaaQWU34z+8qjv69vhXnacDHvKJv5Ha6vwxp
	 TH9vtfafScJhGQgkUaduelWDg91JLRVMa3K+EVoVrSnYqYWEoiVRC+jW3ed5lNfXUi
	 3Kv2y//lefVXkjub9MogQRwWSHrtVWuReKkbS960=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Mammedov <imammedo@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 645/770] NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
Date: Tue, 18 Jun 2024 14:38:18 +0200
Message-ID: <20240618123432.185333800@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 68c522afd0b1936b48a03a4c8b81261e7597c62d ]

nfsd_rename() can kick off a CB_RECALL (via
vfs_rename() -> leases_conflict()) if a delegation is present.
Before returning NFS4ERR_DELAY, give the client holding that
delegation a chance to return it and then retry the nfsd_rename()
again, once.

This version of the patch handles renaming an existing file,
but does not deal with renaming onto an existing file. That
case will still always trigger an NFS4ERR_DELAY.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Tested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index dc79db261d6a2..5684845d95119 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1711,7 +1711,15 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			.new_dir	= tdir,
 			.new_dentry	= ndentry,
 		};
-		host_err = vfs_rename(&rd);
+		int retries;
+
+		for (retries = 1;;) {
+			host_err = vfs_rename(&rd);
+			if (host_err != -EAGAIN || !retries--)
+				break;
+			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(odentry)))
+				break;
+		}
 		if (!host_err) {
 			host_err = commit_metadata(tfhp);
 			if (!host_err)
-- 
2.43.0




