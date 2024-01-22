Return-Path: <stable+bounces-12756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD216837247
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399C528AFB9
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD73985F;
	Mon, 22 Jan 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2b0URyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D01EF1A
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950974; cv=none; b=qWJMASEanhDIqmw7YoqWpqAmoPOMSdFtkOE5I7SD5Vnyhykoj2PZJfjcUleZneLtGiLUnbP8eaXcxzMLAwy0i0zLhNkqClAqaL0/1U4EFRvIV+zqCTR6wzbuCuvZEMylFfITUK9OTEhs+VC0YYNplI6icf9l6onyFYqTNovU7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950974; c=relaxed/simple;
	bh=aPlcKV9q0xnVchCMF4xultksB5Lj20ij4anwXTJLO68=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mJDL/DHozmCxKm3rKGEwrl0/ziOcZwn8LF/dg1sdtJIaLWx2e9oQFp6UbgZov2P5pWxoIjCtEYFb/BXnhNOhMJIEk0PeAQh5ZBqVTcZHPmwWzm1CYvYC6tw0un1Zm3XNbRYC/Azu2khjTQR80q1C3AhGgPFB3ALc2SjrIaXAHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2b0URyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7A5C433F1;
	Mon, 22 Jan 2024 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705950974;
	bh=aPlcKV9q0xnVchCMF4xultksB5Lj20ij4anwXTJLO68=;
	h=Subject:To:Cc:From:Date:From;
	b=X2b0URyIhQ9GrNoyO7jRDfiyDfolJZlkNlzVZn+T0gF05mpbB2GZ9fBUnoPSg7iZF
	 bhCTv5lxsb6oUvGOr70Ijee9rur3rdtKXyOrRvgmYh9UhO7yE2AIoUt0ns5sYIETP1
	 +AL9ul6dSpob5+UXqc1CLFtPwv7OFbKA1ozINaBk=
Subject: FAILED: patch "[PATCH] ksmbd: only v2 leases handle the directory" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:16:07 -0800
Message-ID: <2024012206-trash-casing-0d9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 77bebd186442a7d703b796784db7495129cc3e70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012206-trash-casing-0d9c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

77bebd186442 ("ksmbd: only v2 leases handle the directory")
18dd1c367c31 ("ksmbd: set v2 lease capability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77bebd186442a7d703b796784db7495129cc3e70 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 15 Jan 2024 10:24:54 +0900
Subject: [PATCH] ksmbd: only v2 leases handle the directory

When smb2 leases is disable, ksmbd can send oplock break notification
and cause wait oplock break ack timeout. It may appear like hang when
accessing a directory. This patch make only v2 leases handle the
directory.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 001926d3b348..53dfaac425c6 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1197,6 +1197,12 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
+	/* Only v2 leases handle the directory */
+	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
+		if (!lctx || lctx->version != 2)
+			return 0;
+	}
+
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;


