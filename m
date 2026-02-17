Return-Path: <stable+bounces-216983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFEzOxvTlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5181502C5
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D773B304F225
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF93783CF;
	Tue, 17 Feb 2026 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MogRBIex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262C376BFF;
	Tue, 17 Feb 2026 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361025; cv=none; b=CNSdij4wXVh74vjf2dBvKLHMVNGNCHlpI4sPibZM3bKVtdTbVoldNmEjhhUOu6l+AImK+CruRbnWwnp8z9sFYxTd4hNtWkAhfM2WwLFzv+TJT+j4eOy1DwRmu2T4QAybMMyfhzI8uXMv/ATK/XbKRO/ChbA3pfh2eCJEBl8KBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361025; c=relaxed/simple;
	bh=SbNrgn0GypH+qitRaYQIDxdlyYv8Fv7Wl6D0ToXVPjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1JdE+cuJxwMesxPh46pHEdSN+hUAfuHxCaP7kBUBM8ydgURW0l+VTFG+NQBFfq4vIyKEip8+1WetjOefPwsYZfC4tvsmurV4ceHiyX1loYrD5P5YvvMTbizTyyqWLRb8l8Txwkle1NV1WKX1lSf8RISxGrcU1scbkV2y1I25AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MogRBIex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66329C4CEF7;
	Tue, 17 Feb 2026 20:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361024;
	bh=SbNrgn0GypH+qitRaYQIDxdlyYv8Fv7Wl6D0ToXVPjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MogRBIexhIOEtF8iMat4P9PBrt9RueBjBUEvU4+9cy0bcRqqA4ixbQt4quXh5Wtgw
	 /F3rZzAROsE1Uzr2Y0Ql6RidRAwEnpl2Vo39EkbWpATOwXy7tfOUu0rOBXgSMKJ0I4
	 8s83IuV92zirssBT4TD9gP1o6Zm7wyBHWeLiugJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shane Nehring <snehring@iastate.edu>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15 19/39] smb: client: set correct id, uid and cruid for multiuser automounts
Date: Tue, 17 Feb 2026 21:31:28 +0100
Message-ID: <20260217200003.669919410@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200002.929083107@linuxfoundation.org>
References: <20260217200002.929083107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216983-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iastate.edu,manguebit.com,microsoft.com,163.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iastate.edu:email,manguebit.com:email]
X-Rspamd-Queue-Id: 3B5181502C5
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 4508ec17357094e2075f334948393ddedbb75157 ]

When uid, gid and cruid are not specified, we need to dynamically
set them into the filesystem context used for automounting otherwise
they'll end up reusing the values from the parent mount.

Fixes: 9fd29a5bae6e ("cifs: use fs_context for automounts")
Reported-by: Shane Nehring <snehring@iastate.edu>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2259257
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ The context change is due to the commit 561f82a3a24c
("smb: client: rename cifs_dfs_ref.c to namespace.c") and the commit
0a049935e47e ("smb: client: get rid of dfs naming in automount code")
in v6.6 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifs_dfs_ref.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -258,6 +258,21 @@ compose_mount_options_err:
 	goto compose_mount_options_out;
 }
 
+static void fs_context_set_ids(struct smb3_fs_context *ctx)
+{
+	kuid_t uid = current_fsuid();
+	kgid_t gid = current_fsgid();
+
+	if (ctx->multiuser) {
+		if (!ctx->uid_specified)
+			ctx->linux_uid = uid;
+		if (!ctx->gid_specified)
+			ctx->linux_gid = gid;
+	}
+	if (!ctx->cruid_specified)
+		ctx->cred_uid = uid;
+}
+
 /*
  * Create a vfsmount that we can automount
  */
@@ -309,6 +324,7 @@ static struct vfsmount *cifs_dfs_do_auto
 	tmp.source = full_path;
 	tmp.UNC = tmp.prepath = NULL;
 
+	fs_context_set_ids(&tmp);
 	rc = smb3_fs_context_dup(ctx, &tmp);
 	if (rc) {
 		mnt = ERR_PTR(rc);



