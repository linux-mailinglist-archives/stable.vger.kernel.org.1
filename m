Return-Path: <stable+bounces-44251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868AA8C51F0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05BFB224D2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB67D3F0;
	Tue, 14 May 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8KaJoEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26966D1A1;
	Tue, 14 May 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685239; cv=none; b=L5Q3EkQSjlHBzjCW4OUxAhwac/cVjwjttzYlZYSpZx3lPsA7SjlNKTStdsTtXiFAArcpB1tB88Lt8oHdkxWpAA1JKYT+Awu1F68vbQnaktbfrrmJbpmHU/lwhATVssA9DD0zQZQZMB23gvjfGMK7QvCCuoW4/bL++fM+TCcV80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685239; c=relaxed/simple;
	bh=FVOqczHbeTZdsNheUYaJvj2L/cfn4+1PXDqhHwgeo84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oayd+TBAWoaI8Fy/l21xbvuXE2FVXeKphBqxWsmZXMOQvzBTcudcTaLAAhhrRv0OgpGiZzlBpMKnErXFwK/qRqaOJ0NGAz5FcYv9g61isKBVUJfu0AvY9mjaxBkRv2e0hE7CZL1kwvkAmzIc3dBkDjJoibZ9/HE/jcBTXqP6vWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8KaJoEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4CC2BD10;
	Tue, 14 May 2024 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685239;
	bh=FVOqczHbeTZdsNheUYaJvj2L/cfn4+1PXDqhHwgeo84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8KaJoEKIc1St4fYmQ1PGAE/aHn7VfGm3Ox/Aao9kT9xBDGgjsH/O4uwcTua/cId+
	 KYscvkoQ1sJ5KSWtZvJrJvYJwAoKqrU84ZTvNbZks80ijYWFy7HBcBm8F4Y4UKFeg7
	 LMVH4Bx4hX9FIsBexmVPs/YrhaoV1w9js051bilY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 156/301] smb3: fix broken reconnect when password changing on the server by allowing password rotation
Date: Tue, 14 May 2024 12:17:07 +0200
Message-ID: <20240514101038.146778724@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 35f834265e0dc78b003aa0d1af65cafb89666b76 ]

There are various use cases that are becoming more common in which password
changes are scheduled on a server(s) periodically but the clients connected
to this server need to stay connected (even in the face of brief network
reconnects) due to mounts which can not be easily unmounted and mounted at
will, and servers that do password rotation do not always have the ability
to tell the clients exactly when to the new password will be effective,
so add support for an alt password ("password2=") on mount (and also
remount) so that we can anticipate the upcoming change to the server
without risking breaking existing mounts.

An alternative would have been to use the kernel keyring for this but the
processes doing the reconnect do not have access to the keyring but do
have access to the ses structure.

Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/connect.c    |  8 ++++++++
 fs/smb/client/fs_context.c | 21 +++++++++++++++++++++
 fs/smb/client/fs_context.h |  2 ++
 fs/smb/client/misc.c       |  1 +
 fs/smb/client/smb2pdu.c    | 11 +++++++++++
 6 files changed, 44 insertions(+)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 12a48e1d80c3f..b598c7ed497bb 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1049,6 +1049,7 @@ struct cifs_ses {
 				   and after mount option parsing we fill it */
 	char *domainName;
 	char *password;
+	char *password2; /* When key rotation used, new password may be set before it expires */
 	char workstation_name[CIFS_MAX_WORKSTATION_LEN];
 	struct session_key auth_key;
 	struct ntlmssp_auth *ntlmssp; /* ciphertext, flags, server challenge */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c5705de7f9de2..cb3bed8364e07 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2178,6 +2178,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	}
 
 	++delim;
+	/* BB consider adding support for password2 (Key Rotation) for multiuser in future */
 	ctx->password = kstrndup(delim, len, GFP_KERNEL);
 	if (!ctx->password) {
 		cifs_dbg(FYI, "Unable to allocate %zd bytes for password\n",
@@ -2201,6 +2202,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 			kfree(ctx->username);
 			ctx->username = NULL;
 			kfree_sensitive(ctx->password);
+			/* no need to free ctx->password2 since not allocated in this path */
 			ctx->password = NULL;
 			goto out_key_put;
 		}
@@ -2312,6 +2314,12 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 		if (!ses->password)
 			goto get_ses_fail;
 	}
+	/* ctx->password freed at unmount */
+	if (ctx->password2) {
+		ses->password2 = kstrdup(ctx->password2, GFP_KERNEL);
+		if (!ses->password2)
+			goto get_ses_fail;
+	}
 	if (ctx->domainname) {
 		ses->domainName = kstrdup(ctx->domainname, GFP_KERNEL);
 		if (!ses->domainName)
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 103421791bb5d..4d9e57be84dbc 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -161,6 +161,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_string("username", Opt_user),
 	fsparam_string("pass", Opt_pass),
 	fsparam_string("password", Opt_pass),
+	fsparam_string("password2", Opt_pass2),
 	fsparam_string("ip", Opt_ip),
 	fsparam_string("addr", Opt_ip),
 	fsparam_string("domain", Opt_domain),
@@ -314,6 +315,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	new_ctx->nodename = NULL;
 	new_ctx->username = NULL;
 	new_ctx->password = NULL;
+	new_ctx->password2 = NULL;
 	new_ctx->server_hostname = NULL;
 	new_ctx->domainname = NULL;
 	new_ctx->UNC = NULL;
@@ -326,6 +328,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	DUP_CTX_STR(prepath);
 	DUP_CTX_STR(username);
 	DUP_CTX_STR(password);
+	DUP_CTX_STR(password2);
 	DUP_CTX_STR(server_hostname);
 	DUP_CTX_STR(UNC);
 	DUP_CTX_STR(source);
@@ -884,6 +887,8 @@ static int smb3_reconfigure(struct fs_context *fc)
 	else  {
 		kfree_sensitive(ses->password);
 		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+		kfree_sensitive(ses->password2);
+		ses->password2 = kstrdup(ctx->password2, GFP_KERNEL);
 	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
@@ -1283,6 +1288,18 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			goto cifs_parse_mount_err;
 		}
 		break;
+	case Opt_pass2:
+		kfree_sensitive(ctx->password2);
+		ctx->password2 = NULL;
+		if (strlen(param->string) == 0)
+			break;
+
+		ctx->password2 = kstrdup(param->string, GFP_KERNEL);
+		if (ctx->password2 == NULL) {
+			cifs_errorf(fc, "OOM when copying password2 string\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
 	case Opt_ip:
 		if (strlen(param->string) == 0) {
 			ctx->got_ip = false;
@@ -1582,6 +1599,8 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
  cifs_parse_mount_err:
 	kfree_sensitive(ctx->password);
 	ctx->password = NULL;
+	kfree_sensitive(ctx->password2);
+	ctx->password2 = NULL;
 	return -EINVAL;
 }
 
@@ -1684,6 +1703,8 @@ smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx)
 	ctx->username = NULL;
 	kfree_sensitive(ctx->password);
 	ctx->password = NULL;
+	kfree_sensitive(ctx->password2);
+	ctx->password2 = NULL;
 	kfree(ctx->server_hostname);
 	ctx->server_hostname = NULL;
 	kfree(ctx->UNC);
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index 4e409238fe8f7..d7c090dbe75db 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -137,6 +137,7 @@ enum cifs_param {
 	Opt_source,
 	Opt_user,
 	Opt_pass,
+	Opt_pass2,
 	Opt_ip,
 	Opt_domain,
 	Opt_srcaddr,
@@ -170,6 +171,7 @@ struct smb3_fs_context {
 
 	char *username;
 	char *password;
+	char *password2;
 	char *domainname;
 	char *source;
 	char *server_hostname;
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 0d13db80e67c9..d56959d02e36d 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -101,6 +101,7 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 	kfree(buf_to_free->serverDomain);
 	kfree(buf_to_free->serverNOS);
 	kfree_sensitive(buf_to_free->password);
+	kfree_sensitive(buf_to_free->password2);
 	kfree(buf_to_free->user_name);
 	kfree(buf_to_free->domainName);
 	kfree_sensitive(buf_to_free->auth_key.response);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 94bd4c6d2d682..70530108b9bb9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -367,6 +367,17 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		}
 
 		rc = cifs_setup_session(0, ses, server, nls_codepage);
+		if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED)) {
+			/*
+			 * Try alternate password for next reconnect (key rotation
+			 * could be enabled on the server e.g.) if an alternate
+			 * password is available and the current password is expired,
+			 * but do not swap on non pwd related errors like host down
+			 */
+			if (ses->password2)
+				swap(ses->password2, ses->password);
+		}
+
 		if ((rc == -EACCES) && !tcon->retry) {
 			mutex_unlock(&ses->session_mutex);
 			rc = -EHOSTDOWN;
-- 
2.43.0




