Return-Path: <stable+bounces-243334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPaoCQyp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91AF4BEB87
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCE0300F5E1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2403DEAF7;
	Mon,  4 May 2026 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbSDXp62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0F1ADC83;
	Mon,  4 May 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903619; cv=none; b=BQ4iD8s321kaJnIHodV74uUqsaM8fktiNayDJM05RFqIuOMVaMQOZLx4ponNJfw85navfR38JMF3Nnt5/DVxhiGYtJ//t5tK11r9ybQRp1e7tFZHvToiQC1XzzQkXpGUhx9sTLapYlAHS9BEkq1egucruIzgk3RJP+DNBpR3yTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903619; c=relaxed/simple;
	bh=RLVDazTrm8lwvVjmhWB3NJTzkzB3kBBJsG28ckgdZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6mqF48BL3Jh3iqqRNsCemUjWnXv+a9obf63T81Bwm02vK47G0opA35xVVACMl9DHADZvcBTkPfAH5GnBBL5hujcZRdXSU4q1jYpjWokhv33i2qMuWErsjJBi2vWVyBYJ3ZP+rwj2JC15WmcqsAjbzo9pYivpRBsr1zfFxTx//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TbSDXp62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF62C2BCC4;
	Mon,  4 May 2026 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903618;
	bh=RLVDazTrm8lwvVjmhWB3NJTzkzB3kBBJsG28ckgdZ5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbSDXp62JUshNDi8Jg+PtkciL1HbHcnaKHA+UxBVsj5MZ64wGc7dG+mShWgt5UqGM
	 qdf+BJymCzfdiwvSETfAHBQnUTqh8VJa5AdDwlpfMU6Q3/O4E/SRQebgaiu1MvMXXh
	 hYq0twCxiHg98ABNEhtD/d7ROeKiDKthp48kDGrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tushar Sariya <tushar.97@hotmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 7.0 277/307] NFSv4.1: Apply session size limits on clone path
Date: Mon,  4 May 2026 15:52:42 +0200
Message-ID: <20260504135153.219771919@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B91AF4BEB87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243334-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,hammerspace.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tushar Sariya <tushar.97@hotmail.com>

commit 8c787b286f39c7584440b97b92f87cbe934c13ff upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/internal.h   |    2 ++
 fs/nfs/nfs4client.c |    4 ++--
 fs/nfs/nfs4proc.c   |    3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -253,6 +253,8 @@ extern struct nfs_client *nfs4_set_ds_cl
 					     u32 minor_version);
 extern struct rpc_clnt *nfs4_find_or_create_ds_client(struct nfs_client *,
 						struct inode *);
+extern void nfs4_session_limit_rwsize(struct nfs_server *server);
+extern void nfs4_session_limit_xasize(struct nfs_server *server);
 extern struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 			const struct sockaddr_storage *ds_addr, int ds_addrlen,
 			int ds_proto, unsigned int ds_timeo,
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
@@ -878,7 +878,7 @@ static void nfs4_session_limit_rwsize(st
 /*
  * Limit xattr sizes using the channel attributes.
  */
-static void nfs4_session_limit_xasize(struct nfs_server *server)
+void nfs4_session_limit_xasize(struct nfs_server *server)
 {
 #ifdef CONFIG_NFS_V4_2
 	struct nfs4_session *sess;
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10618,6 +10618,9 @@ static struct nfs_server *nfs4_clone_ser
 	if (IS_ERR(server))
 		return server;
 
+	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
+
 	error = nfs4_delegation_hash_alloc(server);
 	if (error) {
 		nfs_free_server(server);



