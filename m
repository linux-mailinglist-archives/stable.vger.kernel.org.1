Return-Path: <stable+bounces-233289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HuVAiIg0WnGFgcAu9opvQ
	(envelope-from <stable+bounces-233289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 16:28:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2639B5FB
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C94E53006122
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB1282F3F;
	Sat,  4 Apr 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggOZHdBH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51B27A47F
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312926; cv=none; b=tTxdXm8X3aJmj5eG9fOCqiTmMkp+tlQ2GOpYDBoh7f8/xkwYWUXFWnqJWOXXp8unZ5o9eg6KVy3JUXjwNoDzLk+UO+UCVAdnd3smxi92F6zNhSM/Mz2T2+dcJGLLswbprNy7mRUi5Txh90mK6l7CHSqn1w2eeFLdH4zKWmcFhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312926; c=relaxed/simple;
	bh=xwE5t0LG/3F20TNNrUtGY613jux+lpvRpheRVJYPn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTHgeoRa4010CBCMt4wfpDtovSmoQzstTWuPFu2i7+BFpUkx6KWU3I1sN60BAVyyfIiWRBSMuiMg0HtwY55bxpWZ9SrOQoVpKVElBDnXAhE8aoKnihqmxVbR2FxIlmO1Zhz2isC02zImogWH0mnH4TwW2DbSXdfjj1Pki7IRpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggOZHdBH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d0288d24f6so395114585a.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775312924; x=1775917724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=ggOZHdBHrDjcOv7oaJE0ZTbBuKP9Ksy+k0L9Vz5jaPVXvWawfl1xauTAiYdREEu/it
         9s3p5cMhrlQnYnX7BjXNzukv7mpT/8oDCtLbUz5R4CXBuvzrdlynKnicNTtpfDim8cgq
         DyvokGNBcVgYlFU9qA/g+f6XEXjbGpr2NzFMwaahmIzn2AWVRoXnWx6TQqPvqws8ERdU
         FjR5LHFeGo//VjdIe9fKksc84F9jUmnK4yf2dFq86wm/PGIqssKSBpYr/Ea3wjhgZ8UN
         hdtZ63Qfgp5LTEnUnLoQ+w2XlCLj+DAga+L+6Ss3p+URTBjeqNzEfz5OwabeCnX4UYqg
         HWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775312924; x=1775917724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=XqZoQUhGHw0bJZWwHR0d+UzDdav9kppGgYccQM/f2h07fPm9cxby3aiTafmhetNHK/
         2bkuGMG/h68prQk12C2SBws3UdhnrOLQ0+lMVJNXG2tnG+vESTq+ITzOeCtg1S7jsdo+
         aOOxJr52U4kKyh9P+uTruw2M2gtHRwP18jxlpm4RyNSqcdxykl7EiObvUtyH3IgWoQ3f
         kvTDafxY4ArmWZn03lIV3BWUkjQwM8Ih3lO+tJ921s3J84Y9bS8VtAEjymUOVHcyX1XL
         3adSFjnjok6u4YtSYXUpqOPLZhWXmMYH2osigYCKP6jIoFYDqLD46OdAY8gvH71q+7SY
         R17Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+mRaOiEV16j0gkkAODhxg1KPYkoJF/BynZrXatE12+DS/ccaaYRTg7FLa7C5zbfes4whjvN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiJ+LvHSHm3l5hiSlIABYBLDuKc9uVtb9o3awSWS4Bqx7oFfY
	RY/hMPETg6OjNz6f8nY7y1vSEtjM6Lda5z0WWaW+AQ5qxlBg/GwjRvWn
X-Gm-Gg: AeBDietQ1w48TPcX9P0SU2oWCs42yh8SNVR7Or0qOO/J1rSL3sWqzFIvVCTP3y3GEjk
	pDHf4ve0keeHJ9X2Yj2hNeYN8KGyB99t9r4si4i0rFIQ2kfEOlkA1aNBjhn1+LQ081CLaa2Mb9V
	6ggFOXK9RGVKUyZVfFa0KE2n34I4c+bCb6hDh0EiN+4b1JG6AYcMwu1PFlXiQ2XnYabFJEbzWtG
	vyOFGYHZSrzYQ6upcn+n7XxEeA9y4XBpmbOCv4mJHVcOqtiTIk77cV2Efp10AFeMuLvN6K7dmyb
	YXpAosA1AIN8RACoEz3Qw+q0fei+2pqr7IGIT4pm/uM3kP7BoPlyuw+IOMtSfubmMUGrNjKit3g
	ojniRZITJLqDcuVMtoOZkvZImYjEgnHtPuLPNxlnus5Xy2ZEfmdB8fwDfGHFN9XlMOWP8oIzxX3
	UzInGOqzTiAitg6XJ5JAJljXl3HXqRBnT6hOTHQbhu4ak=
X-Received: by 2002:a05:620a:4147:b0:8cd:b317:d69f with SMTP id af79cd13be357-8d301d90232mr1129492085a.17.1775312924148;
        Sat, 04 Apr 2026 07:28:44 -0700 (PDT)
Received: from desktop.. ([2607:fea8:d681:2400:e8ee:54ba:50d9:dea6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d4b24ea458sm299111085a.9.2026.04.04.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:28:43 -0700 (PDT)
From: Tushar Sariya <tushar.sariya77@gmail.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	carnil@debian.org,
	maik.nergert@uni-hamburg.de,
	valentin.samir@magellium.fr,
	regressions@lists.linux.dev,
	Tushar Sariya <tushar.97@hotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.1: Apply session size limits on clone path
Date: Sat,  4 Apr 2026 11:58:03 -0230
Message-ID: <20260404142831.3341498-2-tushar.sariya77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404142831.3341498-1-tushar.sariya77@gmail.com>
References: <177349021750.3039212.10211295677877269201@eldamar.lan>
 <20260404142831.3341498-1-tushar.sariya77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,debian.org,uni-hamburg.de,magellium.fr,lists.linux.dev,hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233289-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tusharsariya77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97E2639B5FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tushar Sariya <tushar.97@hotmail.com>

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
---
 fs/nfs/internal.h   | 2 ++
 fs/nfs/nfs4client.c | 4 ++--
 fs/nfs/nfs4proc.c   | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index 91bcf67bd743..655617ffca8d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10618,6 +10618,9 @@ static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
 	if (IS_ERR(server))
 		return server;
 
+	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
+
 	error = nfs4_delegation_hash_alloc(server);
 	if (error) {
 		nfs_free_server(server);
-- 
2.43.0


