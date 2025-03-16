Return-Path: <stable+bounces-124526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007CA63484
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB3B1708F0
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B918BC20;
	Sun, 16 Mar 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gc1YAxKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB25228
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110871; cv=none; b=C1fPEKy+i8UCJaLi9u8GHbhmF1l/4zIgOw6duC8yKC/AcP4lZ3//VigGDiCycDN48lNDWp+u6wDLG5QDjErLRYSK/SHbourD6N2YX35cc9bMxF3fJZ+dJsEjNwwPJlKKBibK+ii19JgBVY7sV+RSK0n2J1q5c9+9uahtI/StpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110871; c=relaxed/simple;
	bh=sc6r9uva3cgqWf42NH1cm4YKlmE7CY48XqoFO39DUCQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dbo6xOWMxKjheXNhI1SvqeAjSnd4TFPTPdt56yHgEp3Gyp55omvoN+nKYk14JZdX17nQirpxFbVVjZfAML5+gl5ZLWaYTxFQ1W84c5DbO4iYjJoiagtq6Rb76mnxSY6Fmg09JrigNWgwU2wuWDlZ3LWDHYkjoSWcytHRsYEGDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gc1YAxKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3573C4CEDD;
	Sun, 16 Mar 2025 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742110871;
	bh=sc6r9uva3cgqWf42NH1cm4YKlmE7CY48XqoFO39DUCQ=;
	h=Subject:To:Cc:From:Date:From;
	b=gc1YAxKYKDD0oCZ32+6PaxfzZY8e4/7FdHxTIz8G+HHQn4uruwUvJ7oBpnOZOlg3r
	 V+J2QVi4QtWumJcvPO5smsP9Hipk2/+jmEaUQrvijduEPnVEx1WbtAZ41wkPZTzJnj
	 R7txZIt69oU0DbMr9rNl1annP4UEO3p/guVSKB+U=
Subject: FAILED: patch "[PATCH] smb: client: Fix match_session bug preventing session reuse" failed to apply to 6.13-stable tree
To: henrique.carvalho@suse.com,ematsumiya@suse.de,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:39:52 +0100
Message-ID: <2025031652-spider-flying-c68b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 605b249ea96770ac4fac4b8510a99e0f8442be5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031652-spider-flying-c68b@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

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


