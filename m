Return-Path: <stable+bounces-34488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09529893F8E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2628284DD3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B544596E;
	Mon,  1 Apr 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YdPoSMrc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFE1DFFC;
	Mon,  1 Apr 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988289; cv=none; b=CIpXB6nWwkvP4p3B9F4C+7Yy31BW2/MnHVhlAXJiuGUDWuPY6pzCiE8ekWULvtR8WGgDe8IbiZMQ0zzCIKoysi9ElZZmNs+OFWjv4CRbCQdYsu93Gdpw68JHZEIabn361/alCcyozAoQ7SLvbMKAJKiDJJ8IOrE32Aqj6aywDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988289; c=relaxed/simple;
	bh=dF29pIBx3WU3kjqwGae6QJlW0OMrXjSktm38Rb08VdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1/LAINtgZ4LMAEgKJ1PHdkvG+2UyMYbWOnfyaxWjvexkHzl3X2jF6nrdN24EYeqB28BboN2Tk94j3ICerV6zeD26BmDoC1R15gRvabewo+aCOyumKgBEB7FlpX+kxHnG5n4uIfNzZEfWOo2OP1rxzTcUfJqn0hmOfoBTTx+H+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YdPoSMrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476F0C433F1;
	Mon,  1 Apr 2024 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988288;
	bh=dF29pIBx3WU3kjqwGae6QJlW0OMrXjSktm38Rb08VdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdPoSMrcWqOuMzUke3lkjpUGd7ns1Z/nkg4kWHiGuQC7eot5SxF6EHtgOMNpVBuwJ
	 DCFAl3r70+at3bnravKlnl1+WswoeBT8nviszrytWimwwrP+HuSI3gaLnV6jW4GWFF
	 QMPAXW7PyGhWuJYCiTTZbOKf/9BGAlDtQgTyrqE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 141/432] cifs: allow changing password during remount
Date: Mon,  1 Apr 2024 17:42:08 +0200
Message-ID: <20240401152557.342875094@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit c1eb537bf4560b3ad4df606c266c665624f3b502 ]

There are cases where a session is disconnected and password has changed
on the server (or expired) for this user and this currently can not
be fixed without unmount and mounting again.  This patch allows
remount to change the password (for the non Kerberos case, Kerberos
ticket refresh is handled differently) when the session is disconnected
and the user can not reconnect due to still using old password.

Future patches should also allow us to setup the keyring (cifscreds)
to have an "alternate password" so we would be able to change
the password before the session drops (without the risk of races
between when the password changes and the disconnect occurs -
ie cases where the old password is still needed because the new
password has not fully rolled out to all servers yet).

Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_debug.c |  2 ++
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/fs_context.c | 27 ++++++++++++++++++++++-----
 fs/smb/client/smb2pdu.c    |  5 +++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 60027f5aebe87..04a6351a9295b 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -488,6 +488,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				ses->ses_count, ses->serverOS, ses->serverNOS,
 				ses->capabilities, ses->ses_status);
 			}
+			if (ses->expired_pwd)
+				seq_puts(m, "password no longer valid ");
 			spin_unlock(&ses->ses_lock);
 
 			seq_printf(m, "\n\tSecurity type: %s ",
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 57bf6b406c590..91a4061233f1a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1052,6 +1052,7 @@ struct cifs_ses {
 	enum securityEnum sectype; /* what security flavor was specified? */
 	bool sign;		/* is signing required? */
 	bool domainAuto:1;
+	bool expired_pwd;  /* track if access denied or expired pwd so can know if need to update */
 	unsigned int flags;
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 6ecbf48d0f0c6..e4a6b240d2263 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -771,7 +771,7 @@ static void smb3_fs_context_free(struct fs_context *fc)
  */
 static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 				       struct smb3_fs_context *new_ctx,
-				       struct smb3_fs_context *old_ctx)
+				       struct smb3_fs_context *old_ctx, bool need_recon)
 {
 	if (new_ctx->posix_paths != old_ctx->posix_paths) {
 		cifs_errorf(fc, "can not change posixpaths during remount\n");
@@ -797,8 +797,15 @@ static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 	}
 	if (new_ctx->password &&
 	    (!old_ctx->password || strcmp(new_ctx->password, old_ctx->password))) {
-		cifs_errorf(fc, "can not change password during remount\n");
-		return -EINVAL;
+		if (need_recon == false) {
+			cifs_errorf(fc,
+				    "can not change password of active session during remount\n");
+			return -EINVAL;
+		} else if (old_ctx->sectype == Kerberos) {
+			cifs_errorf(fc,
+				    "can not change password for Kerberos via remount\n");
+			return -EINVAL;
+		}
 	}
 	if (new_ctx->domainname &&
 	    (!old_ctx->domainname || strcmp(new_ctx->domainname, old_ctx->domainname))) {
@@ -842,9 +849,14 @@ static int smb3_reconfigure(struct fs_context *fc)
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
 	struct dentry *root = fc->root;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(root->d_sb);
+	struct cifs_ses *ses = cifs_sb_master_tcon(cifs_sb)->ses;
+	bool need_recon = false;
 	int rc;
 
-	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx);
+	if (ses->expired_pwd)
+		need_recon = true;
+
+	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx, need_recon);
 	if (rc)
 		return rc;
 
@@ -857,7 +869,12 @@ static int smb3_reconfigure(struct fs_context *fc)
 	STEAL_STRING(cifs_sb, ctx, UNC);
 	STEAL_STRING(cifs_sb, ctx, source);
 	STEAL_STRING(cifs_sb, ctx, username);
-	STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	if (need_recon == false)
+		STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	else  {
+		kfree_sensitive(ses->password);
+		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
 	STEAL_STRING(cifs_sb, ctx, iocharset);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9d34a55fdb5e4..fca55702b51ad 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1536,6 +1536,11 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 			    &sess_data->buf0_type,
 			    CIFS_LOG_ERROR | CIFS_SESS_OP, &rsp_iov);
 	cifs_small_buf_release(sess_data->iov[0].iov_base);
+	if (rc == 0)
+		sess_data->ses->expired_pwd = false;
+	else if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED))
+		sess_data->ses->expired_pwd = true;
+
 	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
 
 	return rc;
-- 
2.43.0




