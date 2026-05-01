Return-Path: <stable+bounces-242543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIRFKqgu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438074B0180
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 364C8301E599
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1537D13B;
	Fri,  1 May 2026 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcaDPRqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4237C924
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675919; cv=none; b=Ebb98vZFxYxXALviIvC92D2btO6xaAFDX+AbrJ2ZyFMH4b1bNVogXYY6Kvw2XPrj2VUPijZLDtrJdJALtOQE0CmmFLHee9CJUfCXRVpuTvUQDXTMTR7lfE1ehDjHMHcJhSRiqLyQVFegVuhBB4ZMWxww23WH/EZ9BZKHX10VdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675919; c=relaxed/simple;
	bh=sj+0TveqgFbria1WecUz8+lNLyXt3YQquh2jnrnlr9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV2h6lYJTCCqZnICj94PbJnKuWujsroK1xuEBA88uE8F+uxiQ0f+xMpFHqoAQM7O7KKx9mqhW6PtgMakyDyZ8Q5rCoQH6eqPPjZ+4JJFPxOTVuN2CaVrx/5Qtjl9wFtBypMPDwYcSzJJEt57QX704VGc9eE3B24uplq0WeNNiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcaDPRqA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso26293715e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675917; x=1778280717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwNDW+V2ZInjYz2679mwWIRItMIlkpJfBjr27qXLa8Y=;
        b=BcaDPRqAJprjabvBPa/5BvjjlFoy/dYedfKc7LRO7Wy3ok0CDJPqvZ7z7Wu97uVRUs
         DUAznbWzZ+VCo6032MIFtSi7ekTkYliIeb7FWGHKr9E8TDyj3XNg3FXE9u44AjFuGURI
         R90PmCWFtTYM5Q3ptKQWxxt9k6TXu0hwfCz3AzvR86mKds+3lCacZXWovfxfOHwLObQ2
         UqjkIO+PYAwFsxcTYWpvkEwKXsJoBAyddscHkVEIWx95+k9vWvw4Oi9ubAa2PYJLAXmd
         1dnowyhq3EztmjmKWm6c9lA3fWNE8Y2OdbjfZHtrFRCAX+7aK/b5wDwsToskcqGavj3j
         w4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675917; x=1778280717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gwNDW+V2ZInjYz2679mwWIRItMIlkpJfBjr27qXLa8Y=;
        b=NLx5ePbbKGllYLQAXMVqCSV2/eVQmH6e5lOTvrDToLRGi2NrcWrd4MCOXxvCcF1jKI
         D0aPjA4wSdyYo/MzpsOsPiT7Ix6RYZP9ITspTgooUBgMvdgoHL0OdjgY+Wp6Ovu2cMJS
         uND7SxlMSxCazYYV2nI/g4LnBgy+AGN2KxQ7hl9Hlf7V9MlLND1vriur2SeMNk6gbuKC
         FZ6htpwfPQTp79mPDeMSdE7eAnVj1oN+2PLRHbn7g2Vug2IMsETvI1b6X2YMI8iaBUa8
         dzECB1XtbfD1chTrqNH4XgvEzSvlPDaFvyP/aJK68uqJWbtXVflCxfb7LWQG+HvPHJoW
         lGAw==
X-Gm-Message-State: AOJu0Yxp0yQUyGzIw7aMegvTjNVWHejcBvjFfiHSNsAwgxkrVIgBsHc7
	LC7A2MdkNrUT2H0SC2BB4XQgelZFjEG6YUzwS6Ig1TL23rM6I6rCRpnN7ucrOY2L
X-Gm-Gg: AeBDietQAeaZKzq02H2egrvZQb84a4Bg2PQE/RyVT8TfV6OfAIPQMZU+HILY2IMNZtK
	4SrRBSM/OsRAKk1sT/eJr+MrVnUw2B8HoNf1fofCqXYYEWC1dSMQV+fSEwb1tycGYgTZ/Ug6eB+
	HX1j2BuYVUK9+GmOSmrQgHz0NOOrpx18kL20mt82EI12Q691aMAzENg6AAE4Ddincnlzufp3yVk
	TTOq8vngB4EvDHEJR8gvuREYUo4ZW4Y/thFqrhHIz7tptvYjGhEjHA1ojOMRxw3YFOCi+ouAtLr
	hVrb8yxBvc1E6BZYkU26uyY/CcCa/ahhB3aUSf4LMmck7d0w/0zvuY972N/lCzFvDNxGHIh8ymb
	7KXmNj7QCDdUAboHV1Wzp5PeA64XwYbhRUgBQnzA8annzff4fcXJ3DuCKdx2kk18fKqiyPXHrdB
	VY1/IJ5Bn53ssb1+4UUDP3mldYLcDjMO6UIQoPlcMNYqGh6qr4VGMSmBFlYROIkxiY+r9myJvdV
	hswAKMOzblhJGoeitL3eCDT4g==
X-Received: by 2002:a05:6000:40c7:b0:43d:6787:992f with SMTP id ffacd0b85a97d-44bb37c7fabmr1783295f8f.10.1777675916470;
        Fri, 01 May 2026 15:51:56 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76fd0sm8040341f8f.35.2026.05.01.15.51.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:51:56 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH 6.1.y] ksmbd: add chann_lock to protect ksmbd_chann_list xarray
Date: Sat,  2 May 2026 01:51:51 +0300
Message-ID: <20260501225152.90136-2-kai.aizen.dev@gmail.com>
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
X-Rspamd-Queue-Id: 438074B0180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-242543-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Backport notes for linux-6.1.y:
  - The smb client/server consolidation has already happened by 6.1.y;
    file paths are fs/smb/server/, identical to mainline.
  - The xa_store call sites use the older form
    `xa_store(..., GFP_KERNEL)` with no captured `old`, but the
    surrounding context for the lock-wrap is identical.

CVE: CVE-2026-23226
Cc: stable@vger.kernel.org # 6.1.y
Reported-by: Igor Stepansky <igor.stepansky@orca.security>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[backport for linux-6.1.y, verified 2026-05-01]
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

@@ -417,6 +421,7 @@ static struct ksmbd_session *__session_create(int protocol)
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
@@ -79,7 +79,13 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)

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
@@ -1567,7 +1573,9 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

@@ -1660,7 +1668,9 @@ static int krb5_authenticate(struct ksmbd_work *work,
 				return -ENOMEM;

 			chann->conn = conn;
+			down_write(&sess->chann_lock);
 			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			up_write(&sess->chann_lock);
 		}
 	}

--
2.43.0


