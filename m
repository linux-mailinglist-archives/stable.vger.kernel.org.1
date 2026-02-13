Return-Path: <stable+bounces-216100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC6POmYsj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B166136902
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08773079FC6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9FE34F24E;
	Fri, 13 Feb 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nL8xR8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E534CFC3;
	Fri, 13 Feb 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990634; cv=none; b=fDaosA2U+gjE0j4hZBGkGmSZ069n3x1H1rrEM0N9BfnU/D1P1FEMKOzBoofyCphO2Tmjb6fVe1vIwwh+6KxtPJWVh74EkHpU6pnlsoE7XsLlhD1MwA4cL+lfurrSOesb22wGAyvG03SS53RDeA43hXdVzhEMoqK3lHncaDyUeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990634; c=relaxed/simple;
	bh=o+oAVr7uovE1foT/n55gEAOORUIiZ81pWE8eeAj7/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNrZ+YVbZ3Qumcc8NPE1NojkRxvvDsoZvdpHH61AohCMaRMeBCC6f2lu3GNInt0carIJk4OTfk7PRJIpwzKccReqkarzjAqlX2/wZP5d9zCcKG6itCgCjKxB2N/PudIle5VdlU8+j85fNmM2nnIE52SWWMvUd+fjUjagx24hEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nL8xR8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45131C116C6;
	Fri, 13 Feb 2026 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990634;
	bh=o+oAVr7uovE1foT/n55gEAOORUIiZ81pWE8eeAj7/n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0nL8xR8+gH7qNUplNhmRcWPltEbIjLjpZDVZ1wec0JW3X49AXls7417HWqk0bulJb
	 Phv896HOrcF5rF5Z4YvTrTdVThHTFcKJQFz6ozSIizFVDw9MsdOqxRh72hHpdCYsw+
	 84rOBLa36fXeQqqCueprls5+sR0n3Ybg0BSnZIzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Stepansky <igor.stepansky@orca.security>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 05/49] ksmbd: add chann_lock to protect ksmbd_chann_list xarray
Date: Fri, 13 Feb 2026 14:47:24 +0100
Message-ID: <20260213134708.923682208@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216100-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4B166136902
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 4f3a06cc57976cafa8c6f716646be6c79a99e485 upstream.

ksmbd_chann_list xarray lacks synchronization, allowing use-after-free in
multi-channel sessions (between lookup_chann_list() and ksmbd_chann_del).

Adds rw_semaphore chann_lock to struct ksmbd_session and protects
all xa_load/xa_store/xa_erase accesses.

Cc: stable@vger.kernel.org
Reported-by: Igor Stepansky <igor.stepansky@orca.security>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/mgmt/user_session.c |    5 +++++
 fs/smb/server/mgmt/user_session.h |    1 +
 fs/smb/server/smb2pdu.c           |   12 +++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -32,12 +32,14 @@ static void free_channel_list(struct ksm
 	struct channel *chann;
 	unsigned long index;
 
+	down_write(&sess->chann_lock);
 	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
 		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
 
 	xa_destroy(&sess->ksmbd_chann_list);
+	up_write(&sess->chann_lock);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -220,7 +222,9 @@ static int ksmbd_chann_del(struct ksmbd_
 {
 	struct channel *chann;
 
+	down_write(&sess->chann_lock);
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	up_write(&sess->chann_lock);
 	if (!chann)
 		return -ENOENT;
 
@@ -454,6 +458,7 @@ static struct ksmbd_session *__session_c
 	rwlock_init(&sess->tree_conns_lock);
 	atomic_set(&sess->refcnt, 2);
 	init_rwsem(&sess->rpc_lock);
+	init_rwsem(&sess->chann_lock);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -49,6 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
+	struct rw_semaphore		chann_lock;
 	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -79,7 +79,13 @@ static inline bool check_session_id(stru
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	return xa_load(&sess->ksmbd_chann_list, (long)conn);
+	struct channel *chann;
+
+	down_read(&sess->chann_lock);
+	chann = xa_load(&sess->ksmbd_chann_list, (long)conn);
+	up_read(&sess->chann_lock);
+
+	return chann;
 }
 
 /**
@@ -1558,8 +1564,10 @@ binding_session:
 				return -ENOMEM;
 
 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			old = xa_store(&sess->ksmbd_chann_list, (long)conn, chann,
 					KSMBD_DEFAULT_GFP);
+			up_write(&sess->chann_lock);
 			if (xa_is_err(old)) {
 				kfree(chann);
 				return xa_err(old);
@@ -1651,8 +1659,10 @@ binding_session:
 				return -ENOMEM;
 
 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			old = xa_store(&sess->ksmbd_chann_list, (long)conn,
 					chann, KSMBD_DEFAULT_GFP);
+			up_write(&sess->chann_lock);
 			if (xa_is_err(old)) {
 				kfree(chann);
 				return xa_err(old);



