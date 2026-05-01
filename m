Return-Path: <stable+bounces-242544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DdlI6wu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 092704B018F
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE4D3020ABB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E137C112;
	Fri,  1 May 2026 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEKCZymA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610737CD5F
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675920; cv=none; b=ZNvJ+m4/anPuE93k/kivghz4ssk/C//z6sfwwY6A3BxN4Rtmf1xP8dVZFn5Zcx6OUpg+vIK7sRjnSd1+ijrG+mihb3MgqKPxhlsOHk3aJtxACBV+qf9QfAJdNQBsW5Z97mkZNYd9AsAKjLSUidUGj4Zf9qTB2jENPJ2kqnnrEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675920; c=relaxed/simple;
	bh=FJP6RLOefwTF8JWnGy5sNvBTTBntXVJzRuLhtI0f/H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqiXUmBfeuEOWiD5VL3zTkOk5u1F2M8/uB5gndq+P67MDWQbYHMigkj/xa8OtxN3mzq+9qvXYhI5q1Sq31QgV0NU1pILUedrOXgLl4t55/GRQRsnyOOxh/ErQj5pmfRfMJPlr55VFgCajPbAJGKfRnydhRw83AnomTyc17ejCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEKCZymA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d734223e4so1378769f8f.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675918; x=1778280718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIwxaX7mlPOok/JTlWqcYtodZX36XvL0iKcCG4pk4DA=;
        b=VEKCZymAk3VwNKxBEfQNJ3iMRuk35EMzmshfU6R2v2UyDS3ydveuDn0LZBMHb0+lBL
         Ysskw4dn0RNUj6UyZ6WxxX6wTENZVGtrL4MzodXQefdrsuvGakKOCh1zac2nth8z8eee
         nm0AoFkaixvCynmFiB4rlWUg+q3Snq2cTT+4WZX126nD4ljLUQLJ7hdX4Ee9+4XzS5hl
         34thIYEOHnWNTXgDJEvOBDzT2WMcSFGOWxTRqeZDhTVU/k1LHa+XIvT8s17Dcov/Ap4S
         t3kdmIMYrMp+1PeDrB0olRHXQDaqio1skD201LUjhp7nLBFYxCy2zEEi/ETpCBXkR0dw
         DAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675918; x=1778280718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIwxaX7mlPOok/JTlWqcYtodZX36XvL0iKcCG4pk4DA=;
        b=j9Tv6BUT68mFfxoRt3BEbfpA5jXNB3Cr4xTtwecGuxIDG/1ovku4C5emxPFl8si286
         jlpUaiVzCl4cXUC40o+dgkwUO6agsOuLJeu7dYnyu3zogQOW8KtOOfqaxhEEkPw+mXF5
         x2Vij1e7Kr8nmC+Pt4GnEOXAsTlIX4fIrDRkZsGCwgo2FR4KJTTDZL2o3tQHQ8KGb2IK
         iCMp+PVogAZGIUjayQZ4l0VQMUJ7rwjTRuEiUsf2cWidrYXpYtFXIySS6kzX06+vod/v
         dPj0oAQm5XZeZ7pzhOeC6uRp6DIr5jYlrhhZg7zvG3kpoNgxQAXklQAgYmO5KcXlZavv
         kh5A==
X-Gm-Message-State: AOJu0YwoS2GcAHx7fLOmpzmakLlWak6IJppU/IFfJFF4us3mEKY4iYQO
	5IC0VqGYRRvQn37fFRM8UmbbbVP+qQPWabWR52SIs01grU15zvI5sN+HC/ZR+w9w
X-Gm-Gg: AeBDieupoqkXloTouKXzrfYROiFds+NTqESQ+PthaQwTR9ikkpQYaLCCfIM8u1vvig4
	j5uQIWzAIyQh+HUP6YZXsEZW4b4+OWelXkvJVGwCRWglf6rA+AK08t5hRzrmkLNqPECzP2Erond
	Sj4Q0BWvjwYpsGJ4aAzLR22PuEIWgu0rYNMABIkmKDMEOIhRRc8xAw0f4DlZzMJk86w5RUtaXpI
	cIMfT+5AvdqqlWgJ7wuDWwecawf41ODLgouJAu8h6kIt97VRt+/Lu82KsdfMWc0sIqutfbaFj0z
	SzY8drPOKcDnsMJrNuSq5RhtB5snB+drlsNTuf1ar0cxT1YoIvL5PPKtb3FogTFGAJyfxiLSBCx
	a005cK3g7bfgqXxCHRIDVKlQyMmPkfgo30cwVBIZjVeRO5dWOZM2Ff3i4kmrki7l9AbpzEB4/bA
	l4KLEh1OuTpHxV8fQEVFJ/RYxAPSF6+E5d/k9WQ87HSDHqNElpdqC1sUHTrj5xvkilEHOYHtwjL
	8uSldjOdQFyfjv98Em78vq9KQ==
X-Received: by 2002:a5d:648d:0:b0:43f:e571:184d with SMTP id ffacd0b85a97d-44951508317mr9228565f8f.28.1777675917540;
        Fri, 01 May 2026 15:51:57 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76fd0sm8040341f8f.35.2026.05.01.15.51.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:51:57 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH 5.15.y] ksmbd: add chann_lock to protect ksmbd_chann_list xarray
Date: Sat,  2 May 2026 01:51:52 +0300
Message-ID: <20260501225152.90136-3-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225152.90136-1-kai.aizen.dev@gmail.com>
References: <20260501225152.90136-1-kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 092704B018F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-242544-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orca.security:email]

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 4f3a06cc57976cafa8c6f716646be6c79a99e485 ]

ksmbd_chann_list xarray lacks synchronization, allowing use-after-free in
multi-channel sessions (between lookup_chann_list() and ksmbd_chann_del).

Adds rw_semaphore chann_lock to struct ksmbd_session and protects
all xa_load/xa_store/xa_erase accesses.

Backport notes for linux-5.15.y:
  - 5.15 still uses fs/ksmbd/ paths (the smb client/server consolidation
    landed in 6.1).
  - struct ksmbd_session does not yet have rpc_lock; init_rwsem for
    chann_lock is added directly after the refcnt initialisation.
  - Function bodies for free_channel_list, ksmbd_chann_del,
    lookup_chann_list, and the two xa_store sites in
    ntlm_authenticate / krb5_authenticate are byte-identical to
    mainline at the time of the fix.

CVE: CVE-2026-23226
Cc: stable@vger.kernel.org # 5.15.y
Reported-by: Igor Stepansky <igor.stepansky@orca.security>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[backport for linux-5.15.y, verified 2026-05-01]
---
 fs/ksmbd/mgmt/user_session.c |  5 +++++
 fs/ksmbd/mgmt/user_session.h |  1 +
 fs/ksmbd/smb2pdu.c           | 12 +++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,12 +30,14 @@ static void free_channel_list(struct ksmbd_session *sess)
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
@@ -201,7 +203,9 @@ static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
 	struct channel *chann;

+	down_write(&sess->chann_lock);
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	up_write(&sess->chann_lock);
 	if (!chann)
 		return -ENOENT;

@@ -395,6 +399,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
 	atomic_set(&sess->refcnt, 1);
+	init_rwsem(&sess->chann_lock);

 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -48,6 +48,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];

 	struct hlist_node		hlist;
+	struct rw_semaphore		chann_lock;
 	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -78,7 +78,13 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)

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
@@ -1570,7 +1576,9 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

@@ -1667,7 +1675,9 @@ static int krb5_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

--
2.43.0


