Return-Path: <stable+bounces-62423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4484893F0BB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDB1287680
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395213CFB8;
	Mon, 29 Jul 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KkbuKX86"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E06653
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244544; cv=none; b=ut3ik8rkxb2BeW5J+Ep/kfR2sUEAKSt6qaVPvcZoKzVeNZMmnaqYmoC2HSYClxLaAYc7Y1iMRgcr/gVB/pAGBmNIHv6dGh7W+B8gycd1/YA933ecm8Bk0jvahxN5bnR6POKi6PShAFhLWzseQrphTooriK2txxdZIkTG8rF6pXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244544; c=relaxed/simple;
	bh=mHdMb4uqSscRN/Tip3/54Iu6r0nk1kOJ5P6qkYeb0e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZ3xNGk33fdmX0JAWV6T4CMhK0KsaqEHHctm2AZt8I8mVkOZrm9ZrSoIxekNA7Sib2oRScECJMqr7TsnRhzJrp3th4t9P8VIPyXPHda9IQO3vKYki4TcP5krFsstaJy8ks1xuQriraWajwlUaUoDcr184hhAR8nAiJKsMaPYprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KkbuKX86; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso301084066b.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722244540; x=1722849340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdiQxCkWwp+hFDxutmf14Vsm7xCXMxujKP43iJ/OMmI=;
        b=KkbuKX86oO2hlHlfkhn1j70nB6mZNDZkN9pnPiPSNurlwBteQcacpWaSQTJcVSYxTw
         aqRPsoJSUNsjM90RaCBzNuSSOkAjgL+pdYJOQ8zoOlfyjPgyM1qtzfT2vEqx0W7JqbvY
         Dk99z02+kjhehH4n2w7NmgsQv72NKy2IXDl/6mPWyCLturtVTKsrMtOE1kaZSnT9JBn0
         vXsUuiZdJogAkHwaNXs1ZwM/nLTkkBsh+LybXT7HlEkOIcqLGcqpYx0o2uqUN2p/Zzj4
         IPWVzapDwqLuczhCZ3fyppdIRRmu6/m1Xgw2V55HaKjxVWzgszTBqEwhgScc8MLsch1q
         Tqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244540; x=1722849340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdiQxCkWwp+hFDxutmf14Vsm7xCXMxujKP43iJ/OMmI=;
        b=tU5J1dJl1GH7RYf1I2DnmKDly49/sDk58zq9ce/uFiBsbvALUrLkP5Gu5BjoPJ5/sS
         BInrg1cVoL65RrpVZHnkLUAq+/IdFAK2c0xxjkMz55/Jf7ppaPaRKrgGglxCKEHFsMSB
         xOeK0QlnAao+ejU8os1LMJgg2vjqQZPKi1gV5wQNKKlgwo4cDA33lJJGk5niG5cQLniT
         Jr7CTWvp+LDb7aw1dnnTITP1J+wu0b5EGYUyZf3Ec9pZqIdGJf6sOQFiAcbqco8ST/OE
         59PORU8ILUZkRsbKCXLx3BBQzopTALM6Aftgz356KIRZX+qwN4Hff1SGy5m5Dqi8J52k
         GrAA==
X-Forwarded-Encrypted: i=1; AJvYcCW3fXBAMS72f/LunI6aJcRGFf9jFUgvycnP2dWtdPbl7L9jonD9RVgDISG2txZm4M3bKdBHClEm5kSvb7dizZAR9ckHAdrC
X-Gm-Message-State: AOJu0YyXyqEO70AS0Euna0aPqBFfpS0GDpTDvcOBpje2VF2yq/5ldPWt
	1ENC5t0lffYCx++jWyqGjmmqBybI0hyBixuqsLrH/ULuJ3wvxEA/1i4yBFChH+I=
X-Google-Smtp-Source: AGHT+IEcPfb19O/OYEPQjEprDetsHWEg3ZtvJdriFsoPjibeMrfZkdibA76IDihNFvQmehWB0nqtRg==
X-Received: by 2002:a17:907:3f29:b0:a77:da14:83fe with SMTP id a640c23a62f3a-a7d401bc352mr479254166b.64.1722244540280;
        Mon, 29 Jul 2024 02:15:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f03cd00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f03:cd00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4160bsm479009166b.98.2024.07.29.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:15:40 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	jlayton@kernel.org
Cc: willy@infradead.org,
	linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
Date: Mon, 29 Jul 2024 11:15:32 +0200
Message-ID: <20240729091532.855688-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a crash bug caused by commit ae678317b95e ("netfs: Remove
deprecated use of PG_private_2 as a second writeback flag") by
removing a leftover folio_end_private_2() call after all calls to
folio_start_private_2() had been removed by the commit.

By calling folio_end_private_2() without folio_start_private_2(), the
folio refcounter breaks and causes trouble like RCU stalls and general
protection faults.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Fixes: ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a second writeback flag")
Link: https://lore.kernel.org/ceph-devel/CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c          |  2 +-
 fs/netfs/fscache_io.c   | 29 +----------------------------
 include/linux/fscache.h | 30 ++++--------------------------
 3 files changed, 6 insertions(+), 55 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c16bc5250ef..485cbd1730d1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -512,7 +512,7 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
 
 	fscache_write_to_cache(cookie, inode->i_mapping, off, len, i_size_read(inode),
-			       ceph_fscache_write_terminated, inode, true, caching);
+			       ceph_fscache_write_terminated, inode, caching);
 }
 #else
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..0d8f3f646598 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -166,30 +166,10 @@ struct fscache_write_request {
 	loff_t			start;
 	size_t			len;
 	bool			set_bits;
-	bool			using_pgpriv2;
 	netfs_io_terminated_t	term_func;
 	void			*term_func_priv;
 };
 
-void __fscache_clear_page_bits(struct address_space *mapping,
-			       loff_t start, size_t len)
-{
-	pgoff_t first = start / PAGE_SIZE;
-	pgoff_t last = (start + len - 1) / PAGE_SIZE;
-	struct page *page;
-
-	if (len) {
-		XA_STATE(xas, &mapping->i_pages, first);
-
-		rcu_read_lock();
-		xas_for_each(&xas, page, last) {
-			folio_end_private_2(page_folio(page));
-		}
-		rcu_read_unlock();
-	}
-}
-EXPORT_SYMBOL(__fscache_clear_page_bits);
-
 /*
  * Deal with the completion of writing the data to the cache.
  */
@@ -198,10 +178,6 @@ static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
 {
 	struct fscache_write_request *wreq = priv;
 
-	if (wreq->using_pgpriv2)
-		fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len,
-					wreq->set_bits);
-
 	if (wreq->term_func)
 		wreq->term_func(wreq->term_func_priv, transferred_or_error,
 				was_async);
@@ -214,7 +190,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 			      loff_t start, size_t len, loff_t i_size,
 			      netfs_io_terminated_t term_func,
 			      void *term_func_priv,
-			      bool using_pgpriv2, bool cond)
+			      bool cond)
 {
 	struct fscache_write_request *wreq;
 	struct netfs_cache_resources *cres;
@@ -232,7 +208,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	wreq->mapping		= mapping;
 	wreq->start		= start;
 	wreq->len		= len;
-	wreq->using_pgpriv2	= using_pgpriv2;
 	wreq->set_bits		= cond;
 	wreq->term_func		= term_func;
 	wreq->term_func_priv	= term_func_priv;
@@ -260,8 +235,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 abandon_free:
 	kfree(wreq);
 abandon:
-	if (using_pgpriv2)
-		fscache_clear_page_bits(mapping, start, len, cond);
 	if (term_func)
 		term_func(term_func_priv, ret, false);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9de27643607f..f8c52bddaa15 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -177,8 +177,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 			      loff_t start, size_t len, loff_t i_size,
 			      netfs_io_terminated_t term_func,
 			      void *term_func_priv,
-			      bool using_pgpriv2, bool cond);
-extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
+			      bool cond);
 
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
@@ -573,24 +572,6 @@ int fscache_write(struct netfs_cache_resources *cres,
 	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
 }
 
-/**
- * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
- * @mapping: The netfs inode to use as the source
- * @start: The start position in @mapping
- * @len: The amount of data to unlock
- * @caching: If PG_fscache has been set
- *
- * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
- * waiting.
- */
-static inline void fscache_clear_page_bits(struct address_space *mapping,
-					   loff_t start, size_t len,
-					   bool caching)
-{
-	if (caching)
-		__fscache_clear_page_bits(mapping, start, len);
-}
-
 /**
  * fscache_write_to_cache - Save a write to the cache and clear PG_fscache
  * @cookie: The cookie representing the cache object
@@ -600,7 +581,6 @@ static inline void fscache_clear_page_bits(struct address_space *mapping,
  * @i_size: The new size of the inode
  * @term_func: The function to call upon completion
  * @term_func_priv: The private data for @term_func
- * @using_pgpriv2: If we're using PG_private_2 to mark in-progress write
  * @caching: If we actually want to do the caching
  *
  * Helper function for a netfs to write dirty data from an inode into the cache
@@ -612,21 +592,19 @@ static inline void fscache_clear_page_bits(struct address_space *mapping,
  * marked with PG_fscache.
  *
  * If given, @term_func will be called upon completion and supplied with
- * @term_func_priv.  Note that if @using_pgpriv2 is set, the PG_private_2 flags
- * will have been cleared by this point, so the netfs must retain its own pin
- * on the mapping.
+ * @term_func_priv.
  */
 static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 					  struct address_space *mapping,
 					  loff_t start, size_t len, loff_t i_size,
 					  netfs_io_terminated_t term_func,
 					  void *term_func_priv,
-					  bool using_pgpriv2, bool caching)
+					  bool caching)
 {
 	if (caching)
 		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
 					 term_func, term_func_priv,
-					 using_pgpriv2, caching);
+					 caching);
 	else if (term_func)
 		term_func(term_func_priv, -ENOBUFS, false);
 
-- 
2.43.0


