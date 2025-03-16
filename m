Return-Path: <stable+bounces-124527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06376A63485
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7851891ECA
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369918BC20;
	Sun, 16 Mar 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0XnS2XhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30805228
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110875; cv=none; b=OPv+HpT2iFll+6lxcf7h60e3qDuhv2hWHMVV4A5FZ9pqqMr03jFyl2RcacIIiXJg4zhKeYQyTcnDTwEQt0gHLihDQ0SbSjg4p+OV5yWybehRoE5X+wt1CfpZHFgWOLd3JBGxyNp1+ua5f1PbkCeDDelBFUKfhSI5x0zjvVzhfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110875; c=relaxed/simple;
	bh=gwXi+CDxuw5VIvELzSSjXIPrrJd753UNBsCtoNCtv+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pwan2tAVH38lLgq+tgM694+upr7O5OkLjSOTu9qjYVfHvN43oo3pfNsti2XpydEWU9L2eJe600c5lQbWk5D8nCaqu9CAaQP5UDE1LsEpJTFbh9BPM0R2IFCcXh8f8TS+9M4E9pdt2fRPcEGG0r3AKAC3rrVxLhVsaQc0eXb1Z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0XnS2XhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D7C4CEDD;
	Sun, 16 Mar 2025 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742110874;
	bh=gwXi+CDxuw5VIvELzSSjXIPrrJd753UNBsCtoNCtv+E=;
	h=Subject:To:Cc:From:Date:From;
	b=0XnS2XhMDNN5HqxywQTbnauDACTbFig2GyVzfJ7L4zSiOsH1OV/t105qIfCy9SWjQ
	 5V8hS6DJvxRA10qp7MtPR2BckQUZFNTk186CnCtFF6D8m91dTWVQ7jQ69MJRxW0P0U
	 JeV/C8C9lJ//qsRBPVp3ojTCWmvyfVTItf9WAJk8=
Subject: FAILED: patch "[PATCH] smb: client: Fix match_session bug preventing session reuse" failed to apply to 6.6-stable tree
To: henrique.carvalho@suse.com,ematsumiya@suse.de,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:39:53 +0100
Message-ID: <2025031653-guide-earthen-3c35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 605b249ea96770ac4fac4b8510a99e0f8442be5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031653-guide-earthen-3c35@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


