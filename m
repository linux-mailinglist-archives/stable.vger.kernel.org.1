Return-Path: <stable+bounces-4592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573F804821
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3025E2817B6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF38C05;
	Tue,  5 Dec 2023 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGkYUBSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671016FB1;
	Tue,  5 Dec 2023 03:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB763C433C8;
	Tue,  5 Dec 2023 03:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747972;
	bh=lx6KNRpyi5pQZowc4EGw9rM2pLNyXCdhuchXJGiay5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGkYUBSAJaOf/8N2onCQBZEa2UoU0hzcg47LOpbr8UNv/XtAmHX3a4Jti+YjTdfTP
	 pma+dAnEtPSSsLIicPNINXdvNN49UCw3aLY8CElXmFPVRVYdsqhU6OpN8QIcqXm9cm
	 ow60UbVGwXxmAWaGNwBdAMR57RCsJ25qKD5S9X28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	David Sterba <dsterba@suse.com>,
	syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
Subject: [PATCH 5.4 65/94] btrfs: send: ensure send_fd is writable
Date: Tue,  5 Dec 2023 12:17:33 +0900
Message-ID: <20231205031526.485711136@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0ac1d13a55eb37d398b63e6ff6db4a09a2c9128c upstream.

kernel_write() requires the caller to ensure that the file is writable.
Let's do that directly after looking up the ->send_fd.

We don't need a separate bailout path because the "out" path already
does fput() if ->send_filp is non-NULL.

This has no security impact for two reasons:

 - the ioctl requires CAP_SYS_ADMIN
 - __kernel_write() bails out on read-only files - but only since 5.8,
   see commit a01ac27be472 ("fs: check FMODE_WRITE in __kernel_write")

Reported-and-tested-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
Fixes: 31db9f7c23fb ("Btrfs: introduce BTRFS_IOC_SEND for btrfs send/receive")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7381,7 +7381,7 @@ long btrfs_ioctl_send(struct file *mnt_f
 	sctx->flags = arg->flags;
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}



