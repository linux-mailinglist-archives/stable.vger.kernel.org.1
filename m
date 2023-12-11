Return-Path: <stable+bounces-5318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C3A80CA28
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65DDB20F12
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3953BB42;
	Mon, 11 Dec 2023 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GquP0KnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604673C066
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64DEC433C7;
	Mon, 11 Dec 2023 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702298865;
	bh=nYdMIdYF40lPNFycLycHRz+ho4Isqtnf6JkTcmkVI9o=;
	h=Subject:To:Cc:From:Date:From;
	b=GquP0KnMQYEyskKgKwo5ecf5qPgnGqqDdcIQhhweZ9O1q0U4tx58W6QU/XYpdoCN5
	 Cjf7pj3FBAarUYjOdoB6I9K+gjUeb7ewp4fmH17KQ2Sc4GwW1n4SioE+5sMCuhqKo3
	 WA/SWmVrYQXQPqLkGGlV+CoH20nfmeduR63YKNpE=
Subject: FAILED: patch "[PATCH] smb: client: fix potential NULL deref in" failed to apply to 5.10-stable tree
To: pc@manguebit.com,rtm@csail.mit.edu,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:47:39 +0100
Message-ID: <2023121139-gully-bulge-51cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 92414333eb375ed64f4ae92d34d579e826936480
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121139-gully-bulge-51cb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

92414333eb37 ("smb: client: fix potential NULL deref in parse_dfs_referrals()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92414333eb375ed64f4ae92d34d579e826936480 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Tue, 5 Dec 2023 21:49:29 -0300
Subject: [PATCH] smb: client: fix potential NULL deref in
 parse_dfs_referrals()

If server returned no data for FSCTL_DFS_GET_REFERRALS, @dfs_rsp will
remain NULL and then parse_dfs_referrals() will dereference it.

Fix this by returning -EIO when no output data is returned.

Besides, we can't fix it in SMB2_ioctl() as some FSCTLs are allowed to
return no data as per MS-SMB2 2.2.32.

Fixes: 9d49640a21bf ("CIFS: implement get_dfs_refer for SMB2+")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 45931115f475..fcfb6566b899 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2836,6 +2836,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 		usleep_range(512, 2048);
 	} while (++retry_count < 5);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if (!is_retryable_error(rc) && rc != -ENOENT && rc != -EOPNOTSUPP)
 			cifs_tcon_dbg(VFS, "%s: ioctl error: rc=%d\n", __func__, rc);


