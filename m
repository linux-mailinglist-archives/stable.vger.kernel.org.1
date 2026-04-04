Return-Path: <stable+bounces-233255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFE8BeNx0Gmo7gYAu9opvQ
	(envelope-from <stable+bounces-233255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:05:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8039997C
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EF63055805
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18484279792;
	Sat,  4 Apr 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWLRJ/EX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA322D792
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775268043; cv=none; b=UGgZcOu37bemPO+O/SbmnHBGb+UsqnKi8S5LaElNd64rrwEgVikNNOMertFzdkH3P0BXu8ZTRdAgPkvd0RAfayp/PeNSmGWxN8KCNSr9ZWjSUitw//LIQ7NW/mlvgWU8zNMV5uPryvYAMLjiRkHK8Mp3v/zlMZKMfAHQzTIwt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775268043; c=relaxed/simple;
	bh=xwE5t0LG/3F20TNNrUtGY613jux+lpvRpheRVJYPn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsLEOsAzWHSM0jqRKvpub2n6SSk83G3keixDCPlwQbWtz67T6eL+Lr4DljxcFdkS3uAAey690ptEs1EfLainIME6p0ZoYBYhevlApikoM222S3rqpuCge/nye5rX6YAdSqhfp4HkWp0OFvvVMurUc928xHFpDAJp4huB6PMUfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWLRJ/EX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89f87257904so21372096d6.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775268041; x=1775872841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=hWLRJ/EXn/1tAjQOg963jjsfgHXbWzeWHQTQPL7bqmcId7VWgX9EXYesozgO3/iGPY
         ZslA9wfKXPv2YTVzfmxlM7sZLMHm6+EnYwcLflRcazi5scOIbJ2wWkh9FkAXNqwEokIh
         4bFl+r9PkRDarA/4mavR78vnFYABDtxVkmx4fqSKwDgZAY9ngi2sjeMm6vEWzHO0dxSx
         qJbHEu6BKYsOXmiNmBZXF5hZrXiSIaHejkzZNuXXQqbRi9bO026js3zKcPd6DYSygvNx
         xovUJuccHspS5bC0ruwopIoVG+f4HIkqTJ0/GDAhpZGeVAe5jE/4+mUuuEzfHUJLBqa3
         9oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775268041; x=1775872841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=ovvu3wR+4a4xByLgOj5HK2BbeorfaX2nEcrezUqQHBvv7RK/vYv5F1zLBOmLn7KwG8
         TpqBNkBxFdISClm5hi2RIkcL175D5NpjYoBGMrPegm28fnrPa//gNQUcQEyoQlYo7kQ6
         JQGNLzuYTtKKNFLNArLpWs3uavP/pB5wxwy+Fc7bXzWjb7TDHZzlCaC+mbjupmR98jj3
         x4LIncN6Z1/qHD+Wm0P7D1J3mg6oG53YBkOkyQfCylCd3A3ISBKK9LJPSQeDQQZMsYv2
         Msovu+pm9HdD2H63Qefa2iKY9OERMM9+Vtj2w8PXmbe7IuCSwTFoC5/kIFuAFYAl7RmD
         uM2g==
X-Forwarded-Encrypted: i=1; AJvYcCUT9rkk+vpqyR0crPdgGDvfw5VyVIDpLoBqPspPBwnLpm9OL5ODXGUzoemq602NzrSPIxCdegw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRDG/qbTfl58TAP86usBvKyRnKDRVLf5lHhXX06+zQEJvIQWS
	0QsQXztUCAebFsVeORq4pEVtTSo1F/tsBXsEdJTRwrBkczGmNZyYM34o
X-Gm-Gg: AeBDiesiGQt0+vBxFJFtX2mohYJfPc131KzASOrLyQKnglPiBEtGi2pdvYDEkpZBZIt
	BTGbHsC6cuCm/7IX48oxnTe9F4jzclLq2ivjK2+C2QBd1iGjB2vFUpNSV+kF3CYLXHeaAcqDwf9
	hwnwkXcfjFro2BZLEkat9nlzo3tKJc300tyf6IEYRqdiC5XZzBy/M8p80VBrDusVNbwD7kVvLoT
	svCJsnsgq2maUsAIcmZe0SGK/fC7Rt78y8/Pe0+ZZIkq9TG1hELZlNgppvEsWuyqKSBtFdRai64
	zbIt1ELjWDBhUGfEDus7DTTb0oKpSsaZ09in879DuZWrGBbTOzgCKeYE2TKZmnwHLbjsyOuXv5u
	jtOneMiEIePEipVLh1edAvnzQZ+Po5Ekl2+nhD3+6KuAFngukGbpKVdY9KT/ERXZP/8clmxbPCJ
	P/7rKsOI0QX9fSAoki2yh0FQwp/XLvdjhomJYZgKQWZy4=
X-Received: by 2002:ac8:7dc2:0:b0:4ee:13d0:d02b with SMTP id d75a77b69052e-50d62c8a32cmr75557921cf.50.1775268041390;
        Fri, 03 Apr 2026 19:00:41 -0700 (PDT)
Received: from desktop.. ([2607:fea8:d681:2400:aac2:af07:379d:ffaa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8a8f38sm57316941cf.24.2026.04.03.19.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 19:00:40 -0700 (PDT)
From: Tushar Sariya <tushar.sariya77@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tushar Sariya <tushar.97@hotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: Apply session size limits on clone path
Date: Fri,  3 Apr 2026 23:30:25 -0230
Message-ID: <20260404020027.3327248-2-tushar.sariya77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
References: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tusharsariya77@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64F8039997C
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


