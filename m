Return-Path: <stable+bounces-124532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF553A6348A
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021797A7BDF
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C818BC20;
	Sun, 16 Mar 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yunNOFZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8D5228
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110888; cv=none; b=oDjX7GnRrOtm6Ye1sM5pCOhcsevMsmT0u3CEQX7IAbeKCq8arUZVGHrCJTymJ2gwZL0BGQq4MJKJX/VFrCsNhqEZg1Vkqlpy5PbIjzlERvdAC+hNvn82Z1MTD6sdGnBob68jAHWC1NbRUQy++jath1U3K92WglCsmp1ds1IKYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110888; c=relaxed/simple;
	bh=Tnr7krwRbn9+J4bmR1Qn0MsZ/PjRO7KYZ7C4GGc3kUg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NvvfO0KcwPDFMbrc2w7ogd82A7SmrBzOjgMMhJuTtdrnziAxCm4R7dAERcG/DdOe99X52UIVBQu1IfFqBh9x1GFfFoyfCq+CBjuRaCfYcjlBnazWblpeFz+P7c5IMLLzyuvLFnP94FoHWzCdTUsb2dDwqTcG7khBrtcW9zlVUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yunNOFZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76745C4CEDD;
	Sun, 16 Mar 2025 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742110887;
	bh=Tnr7krwRbn9+J4bmR1Qn0MsZ/PjRO7KYZ7C4GGc3kUg=;
	h=Subject:To:Cc:From:Date:From;
	b=yunNOFZb/Db0EYDk1T/iD8Sh7mz4K5kND8rL5pTfdxKW0+pRIgn0MQ5kL2AepZMDE
	 hxJ4EiNmsAwY58WSxTkSQFaQ8+lvGWtsGc8LmwoblfERq5SO57nZxQd8Yh6WEvi/2W
	 VeErOTgL84WRL8bRPF0CvPkLgF0m7/ETOFsuzlz8=
Subject: FAILED: patch "[PATCH] smb: client: Fix match_session bug preventing session reuse" failed to apply to 5.4-stable tree
To: henrique.carvalho@suse.com,ematsumiya@suse.de,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:39:55 +0100
Message-ID: <2025031655-santa-shoptalk-2d45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 605b249ea96770ac4fac4b8510a99e0f8442be5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031655-santa-shoptalk-2d45@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 605b249ea96770ac4fac4b8510a99e0f8442be5e Mon Sep 17 00:00:00 2001
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Tue, 11 Mar 2025 15:23:59 -0300
Subject: [PATCH] smb: client: Fix match_session bug preventing session reuse

Fix a bug in match_session() that can causes the session to not be
reused in some cases.

Reproduction steps:

mount.cifs //server/share /mnt/a -o credentials=creds
mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
cat /proc/fs/cifs/DebugData | grep SessionId | wc -l

mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
mount.cifs //server/share /mnt/a -o credentials=creds
cat /proc/fs/cifs/DebugData | grep SessionId | wc -l

Cc: stable@vger.kernel.org
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index f917de020dd5..73f93a35eedd 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1825,9 +1825,8 @@ static int match_session(struct cifs_ses *ses,
 			 struct smb3_fs_context *ctx,
 			 bool match_super)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	if (!match_super && ctx->dfs_root_ses != ses->dfs_root_ses)
 		return 0;
@@ -1839,11 +1838,20 @@ static int match_session(struct cifs_ses *ses,
 	if (ses->chan_max < ctx->max_channels)
 		return 0;
 
-	switch (ses->sectype) {
+	ctx_sec = server->ops->select_sectype(server, ctx->sectype);
+	ses_sec = server->ops->select_sectype(server, ses->sectype);
+
+	if (ctx_sec != ses_sec)
+		return 0;
+
+	switch (ctx_sec) {
+	case IAKerb:
 	case Kerberos:
 		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
 			return 0;
 		break;
+	case NTLMv2:
+	case RawNTLMSSP:
 	default:
 		/* NULL username means anonymous session */
 		if (ses->user_name == NULL) {


