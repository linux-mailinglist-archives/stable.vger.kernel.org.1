Return-Path: <stable+bounces-242946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA1TL6le+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:54:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCC4BA9AA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1A2A30157F3
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337D31960A;
	Mon,  4 May 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQ84hwCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D2318EEE
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884695; cv=none; b=rO4A/qkp0rScBII97Y5ZVRuBx/KfzUkkWe1DMJKRoankvOfbQ+7zTGN8jtHrJPJTG2G3DLYkEcjy9H8FDEJeZrgzJlQPaxIMVx256lWmed1nix31KQwcMHcN+lwbFHnXbeMZ8uhZpr6zfTTBIhWEwjfjpSkID2OrmZbAVuBu6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884695; c=relaxed/simple;
	bh=ToIEbnasGGAx3ZnRGtsdTfcperCZz4oO+sBSedQ7OLA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ukf2xN0Jypn1lLLf2Ryfor7NRKwWCD5HT8AixL8hQf2X7cdo90rE4ya7o8JWM48bAkdsub8phqxxamlE9XZJxM8S3PyvisrB7dmkTMAydatn4FXgLsLvyGahX/w/2boS9wzcD2tt0X3v0iv0FhGKxQ9CxI7z2bKKLGzSjYzp6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQ84hwCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B55C2BCB8;
	Mon,  4 May 2026 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884695;
	bh=ToIEbnasGGAx3ZnRGtsdTfcperCZz4oO+sBSedQ7OLA=;
	h=Subject:To:Cc:From:Date:From;
	b=eQ84hwCCLg/Det/kGbY1YqiJgNxrOZO+ddsda8+k+dBwwqJJkG1ROtXTglR7xMYaR
	 8EkScL78zz/JWVZtFWv8nzyNgsWqaE0IrXC3zFJp7ulG2GNho2rwPkdmeIOfpWeFE3
	 XyfC9tTIQw8YVBQvCMeTcABZ2DPXfyWOdbKEE2dU=
Subject: FAILED: patch "[PATCH] NFSv4.1: Apply session size limits on clone path" failed to apply to 6.6-stable tree
To: tushar.97@hotmail.com,trond.myklebust@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:51:22 +0200
Message-ID: <2026050422-defrost-overrule-3e84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7CCC4BA9AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242946-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[hotmail.com,hammerspace.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8c787b286f39c7584440b97b92f87cbe934c13ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050422-defrost-overrule-3e84@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c787b286f39c7584440b97b92f87cbe934c13ff Mon Sep 17 00:00:00 2001
From: Tushar Sariya <tushar.97@hotmail.com>
Date: Sat, 4 Apr 2026 11:58:03 -0230
Subject: [PATCH] NFSv4.1: Apply session size limits on clone path

nfs4_clone_server() builds a child nfs_server for same-server
automounted submounts but never calls nfs4_session_limit_rwsize()
or nfs4_session_limit_xasize() after nfs_clone_server(). This means
the child mount can end up with rsize/wsize values that exceed the
negotiated session channel limits, causing NFS4ERR_REQ_TOO_BIG and
EIO on servers that enforce tight max_request_size budgets.

Top-level mounts go through nfs4_server_common_setup() which calls
these limiters after nfs_probe_server(). Apply the same clamping on
the clone path for consistency.

Fixes: 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Sariya <tushar.97@hotmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..0338603e9674 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -253,6 +253,8 @@ extern struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 					     u32 minor_version);
 extern struct rpc_clnt *nfs4_find_or_create_ds_client(struct nfs_client *,
 						struct inode *);
+extern void nfs4_session_limit_rwsize(struct nfs_server *server);
+extern void nfs4_session_limit_xasize(struct nfs_server *server);
 extern struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 			const struct sockaddr_storage *ds_addr, int ds_addrlen,
 			int ds_proto, unsigned int ds_timeo,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index c211639949c2..71c271a1700a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -855,7 +855,7 @@ EXPORT_SYMBOL_GPL(nfs4_set_ds_client);
  * Limit the mount rsize, wsize and dtsize using negotiated fore
  * channel attributes.
  */
-static void nfs4_session_limit_rwsize(struct nfs_server *server)
+void nfs4_session_limit_rwsize(struct nfs_server *server)
 {
 	struct nfs4_session *sess;
 	u32 server_resp_sz;
@@ -878,7 +878,7 @@ static void nfs4_session_limit_rwsize(struct nfs_server *server)
 /*
  * Limit xattr sizes using the channel attributes.
  */
-static void nfs4_session_limit_xasize(struct nfs_server *server)
+void nfs4_session_limit_xasize(struct nfs_server *server)
 {
 #ifdef CONFIG_NFS_V4_2
 	struct nfs4_session *sess;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c2078545242e..7225b4cfa6c2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10637,6 +10637,9 @@ static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
 	if (IS_ERR(server))
 		return server;
 
+	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
+
 	error = nfs4_delegation_hash_alloc(server);
 	if (error) {
 		nfs_free_server(server);


