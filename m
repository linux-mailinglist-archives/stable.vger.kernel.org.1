Return-Path: <stable+bounces-242542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMI1MqIu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332634B0179
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852AF301993E
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578037CD48;
	Fri,  1 May 2026 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVcdqueX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73A36D9F1
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675918; cv=none; b=puM1b5Zag3w3o1QHUwlSPNUFUNoOq79qoUOfkhCTxKNwM/kn0WI9rYXh185dKjtF7yPgx9YOZ11At1gAZl518alE0Qj4NdGeHgo6RYFyIb3vv6J9bxbdB2SOMXwCGwL5JhyKETT2WQPj10jucHrixc/xBeRLpuoRCeJwIkG4T8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675918; c=relaxed/simple;
	bh=tnJHWk4nf2mYfKUuV5x/4sxYrJMv68q5OStwMd5/TRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Famsu4E3efwzaUFSj5apENDMFrm0WvIaECgE9jNxHrIxwgFEOBgAIuyItvgg7mvaiYyDFpnslXKFTXBY7yXeSZgnmtF+5qnCMV0Xx1krHDQIkPpiAxwuuc/i7I9GdfC8xXawQ4Y0JLMwqVSizjbKd6G8TJwDBJtbZHJ8yAMTtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVcdqueX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d75312379so1939091f8f.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675915; x=1778280715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1+oq8yG/702XyhqprRUDciM6mgbO37f+hUJLoyTzWw=;
        b=AVcdqueXQRRyEptaEhBGt2KYkYPjwDLjylWfJ8GJj9H6p6z+y7n/mA0qSpgzRlX7/F
         XaeLHQ7r3sjvXRA20/Hkb1Ji7RdIqvii47c72B+NUuYfGSfmMgxZ0h3NuYRRDn56zprM
         qRLGbnEq08Sjcv0He0hxqcm6ofgXx8xQQyI/BBT06pKMkeMrlwNWEzxokZhvoWzoBWhX
         N/ApV4ioT2qWGwyK0gdiHxD4EPfin5WLLiCjewWAokR9tHLiTKJvnnqn50kRZkFD0gHg
         KUcr5jwpyd4s0OSVF8lGLxNFFhZVFgTmCqiI7GLoahpQqYj0e3Prl7Pthd5WDmNk1Swd
         Frzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675915; x=1778280715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1+oq8yG/702XyhqprRUDciM6mgbO37f+hUJLoyTzWw=;
        b=tZF5msznYm1VnIjg3YDFYgC2AufkV1I0p5N9rC/dQUtxDjyq357JA32k4UFjIz1I3G
         unCaz1vuQDAYEny8W/+MHaJsnkmZI1xBbpXVSze/rCFbbbIAiDO1WhjTkWySeC29rpQa
         T1YxSl10h9A1MhpHedpRQZwXdVg51vu6UPRNWcBOxsx062mw/45NYSeK9dgtEXP7COZt
         j63SU98AVyUT0mv1XfXIwfJz7KcIpz7E2ptOOY0m4lOEAekyd3s7HLerFb/BUdDXXdj1
         MoxcFVqwUiGzPNkFsl3Z9dUX0XIY2VYj/6HOoN6dNPFRSj00qSv4MeWAjeQlW/DNSs87
         Qfaw==
X-Gm-Message-State: AOJu0YwCLvIVnB6lhs/0iBFmk8NrG6QrgjabGNj8M/I5cADzuw//KvyK
	UMaDDAkp2VsOX2Mi/ngos0ntS+JJoPB5E/bVpwcHLWnZhMASHWAB+hwZfMNoNt3E
X-Gm-Gg: AeBDieuHkA01wBQ+j+WgO8sGfLUpkgEXWJd+P00UrF4ranMsrQ6AGjkeOaBnOsI6Kuc
	VzKKXxIGHpERfBJ4JaQHlZsQVGSB3uWU+OkPPiQ4zD35RV3G5OoFQTUMUWBhkRyIUVy3W6NMtSk
	fgZnkfPvFnCxj1c6QnIDzyNNiOZWH7oXJUmvhzNHZWh3RjMZorBaPe4zX9o8x/fBojC2Eu+GJhS
	Fbe7MFj+J46ukZg9z2RL93ISPx4eP2dbgY5yh0jnApDMz/9imVwYBHrcBHeMAwWxjffS/4Yr0S6
	bycLa4g+4hpDGfl6ScCeNWzfx3LgforiLwO9BSDdPZrrrw6mrL2Ho6WvRyKVwkiTrjvGuGpH51J
	UlnV+xxxQc0Xl0ezbz2K2EysK4IU1TE33eQyZbLDfwH0747+WfD3FTQhmDgwneeaRUhSeuQLquQ
	M2Q+kUHBa2GkbWaw5UenRVzJ9+oUNy+YpyQXgTeAB1Dgtm8uTMdn+xQC2v9mN+4aKxrpunm4A0I
	bkjuUTJK++cvyc3Rz4GEhUY3IKpSFHr207A
X-Received: by 2002:a05:6000:2103:b0:43e:ab40:28d with SMTP id ffacd0b85a97d-4494dc52adbmr8406170f8f.2.1777675915356;
        Fri, 01 May 2026 15:51:55 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76fd0sm8040341f8f.35.2026.05.01.15.51.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:51:55 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH 6.6.y] ksmbd: add chann_lock to protect ksmbd_chann_list xarray
Date: Sat,  2 May 2026 01:51:50 +0300
Message-ID: <20260501225152.90136-1-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 332634B0179
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
	TAGGED_FROM(0.00)[bounces-242542-lists,stable=lfdr.de];
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

Backport notes for linux-6.6.y:
  - File paths and surrounding context are identical to mainline at the
    time of the fix.  The xa_store call sites in
    ntlm_authenticate / krb5_authenticate use the older form
    `xa_store(..., GFP_KERNEL)` rather than the newer
    `old = xa_store(..., KSMBD_DEFAULT_GFP)`; the lock-wrap is
    structurally identical.

CVE: CVE-2026-23226
Cc: stable@vger.kernel.org # 6.6.y
Reported-by: Igor Stepansky <igor.stepansky@orca.security>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[backport for linux-6.6.y, verified 2026-05-01]
---
 fs/smb/server/mgmt/user_session.c |  5 +++++
 fs/smb/server/mgmt/user_session.h |  1 +
 fs/smb/server/smb2pdu.c           | 12 +++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
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
@@ -218,7 +220,9 @@ static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
 	struct channel *chann;

+	down_write(&sess->chann_lock);
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	up_write(&sess->chann_lock);
 	if (!chann)
 		return -ENOENT;

@@ -451,6 +455,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	rwlock_init(&sess->tree_conns_lock);
 	atomic_set(&sess->refcnt, 2);
 	init_rwsem(&sess->rpc_lock);
+	init_rwsem(&sess->chann_lock);

 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -48,6 +48,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];

 	struct hlist_node		hlist;
+	struct rw_semaphore		chann_lock;
 	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -80,7 +80,13 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)

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
@@ -1559,7 +1565,9 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

@@ -1652,7 +1660,9 @@ static int krb5_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

--
2.43.0


