Return-Path: <stable+bounces-35723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533948971C6
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09688282D45
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EA148FEA;
	Wed,  3 Apr 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ckKe8nfK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56136148FF1
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152576; cv=none; b=TwFPtqdB8A/JWt6fPlwxA/v3pn68RdvcBFSKAardvXOG6+yKkdSlrkTveOdSfzMYENKdwlPorgVxrp88vLlAjBJxKj9nDIPAivV89KMgyk8fce25hq6JoJp0Bsx7X03qdAzu58EjaevwDmDs89+F35uzFwBKoNzfNpAsaZ3cg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152576; c=relaxed/simple;
	bh=xBW+RidIDSaDi5t9YoWxK8yP48UNn3X5QEgKFKpA+hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2ouP+ZkbKEumpHLhWPKDxZTUPDOJMNDIFNAuW9oCkVqp2mu0KFPK+GHSk0eNztwGFVb/zhxkhkf3c4K43BEhJIK75wtDjFscOVM2wdd2hVfy8v5DaMtHOoRIi9C0vhkZCYp93OB8HrUakfPFVEaBJaueniPXkfLkaik9yRae00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ckKe8nfK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3688f1b7848so3848485ab.0
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712152574; x=1712757374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyjiacDLhmmFlItH/f0t7RHBaXaSqUN8QHctrPBrOeE=;
        b=ckKe8nfKxnLIImX85CR/HuwNn2tKRo1UU+XcZmsur3R0MJ5Bqe6+r1kujDPogTODVi
         2CDLJ5kMDHuwH06X1jzZxcbLwDvYBHBuv0NJQ2XODfy5vbCiyv/vN80wKglQJ4GiKJct
         8qlXs9jYT9GxFTBpAHxIra2b7Zscf23IjHF/kq1jzEUOa915nVhy0yfhsA4OotPmtJfS
         8sQGPYWM1CN/jZnrAG0yDS+kZXHHDGxjaZvXexh29yK3hE0MxPQUo/EEcz6ICw9K5qsu
         zH9u5r5alU+Di9gJmUvDNbKax4+9Fx+Rl5EMXSJHtwRvwT544YkK9TYZ2YnOqsa4z/+T
         rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152574; x=1712757374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyjiacDLhmmFlItH/f0t7RHBaXaSqUN8QHctrPBrOeE=;
        b=dnyJ4iWT21Qd63d1qbZghfAQB+t1giBlSU1c72XaseB1yPzk9LrxamVvgADN47tlbS
         15BRcNeOfNCUVKEMdvl/T1qcUhtTPSygJqnzPe2iO1CQwQwvLSHIjDKSktNCOMaJ/T0H
         6c+eLbjLOMs2FATbLnaUOYCWTZyXXJOSj0D6PnQuNML7TS1Mhjbm5o2LNpnd5Pa9X3HH
         86AoslsMs7TVbcCfS9TR9UhBeIij4RsY/6wQ0n+ilcOWDzUWfS5BN6BALHPIk4DROMxR
         MB4hFdDuuZtiPyJ75xBpQtGB4Yj6/2km6GMwU5R7L+rVo52MBMOUuHvc61v6xGktUJcb
         I2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWvHztAQWWFqyTegBAE53hFV1DWGC6wEaGnfNkYAsVRwd2rpRyit3S5o1D5Sh3xOmQeBPQN9FqnfMpx4J2qj3RDla214GGE
X-Gm-Message-State: AOJu0Yy4q+GTFiIt8x2RuadZoHVYDLm0ZF1CajIV+sRhd6+4GgjBZGxS
	J9sL897VWAL2BdxSlkUzi8N/7Q5MJOxeTYX6b6HTczHV3AuiB9/P8qQQVnRoW3s=
X-Google-Smtp-Source: AGHT+IGYgQYm7nodhPxgrPIWI3m469yFPtVR9OSIwyCmRhjwkKXK+ZGyKgjdmmaaK+nKZ4WkMSFK2g==
X-Received: by 2002:a5e:9914:0:b0:7d3:433a:d33d with SMTP id t20-20020a5e9914000000b007d3433ad33dmr2951968ioj.2.1712152574556;
        Wed, 03 Apr 2024 06:56:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a02ccee000000b0047ec296d3c1sm3839460jaq.19.2024.04.03.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:56:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] io_uring/kbuf: hold io_buffer_list reference over mmap
Date: Wed,  3 Apr 2024 07:52:37 -0600
Message-ID: <20240403135602.1623312-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403135602.1623312-1-axboe@kernel.dk>
References: <20240403135602.1623312-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we look up the kbuf, ensure that it doesn't get unregistered until
after we're done with it. Since we're inside mmap, we cannot safely use
the io_uring lock. Rely on the fact that we can lookup the buffer list
under RCU now and grab a reference to it, preventing it from being
unregistered until we're done with it. The lookup returns the
io_buffer_list directly with it referenced.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 5cf4f52e6d8a ("io_uring: free io_buffer_list entries via RCU")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 11 ++++++-----
 io_uring/kbuf.c     | 35 +++++++++++++++++++++++++++--------
 io_uring/kbuf.h     |  4 +++-
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bc730f59265f..4521c2b66b98 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3447,14 +3447,15 @@ static void *io_uring_validate_mmap_request(struct file *file,
 		ptr = ctx->sq_sqes;
 		break;
 	case IORING_OFF_PBUF_RING: {
+		struct io_buffer_list *bl;
 		unsigned int bgid;
 
 		bgid = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
-		rcu_read_lock();
-		ptr = io_pbuf_get_address(ctx, bgid);
-		rcu_read_unlock();
-		if (!ptr)
-			return ERR_PTR(-EINVAL);
+		bl = io_pbuf_get_bl(ctx, bgid);
+		if (IS_ERR(bl))
+			return bl;
+		ptr = bl->buf_ring;
+		io_put_bl(ctx, bl);
 		break;
 		}
 	default:
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 2edc6854f6f3..3aa16e27f509 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -266,7 +266,7 @@ static int __io_remove_buffers(struct io_ring_ctx *ctx,
 	return i;
 }
 
-static void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
+void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
 {
 	if (atomic_dec_and_test(&bl->refs)) {
 		__io_remove_buffers(ctx, bl, -1U);
@@ -719,16 +719,35 @@ int io_register_pbuf_status(struct io_ring_ctx *ctx, void __user *arg)
 	return 0;
 }
 
-void *io_pbuf_get_address(struct io_ring_ctx *ctx, unsigned long bgid)
+struct io_buffer_list *io_pbuf_get_bl(struct io_ring_ctx *ctx,
+				      unsigned long bgid)
 {
 	struct io_buffer_list *bl;
+	bool ret;
 
-	bl = __io_buffer_get_list(ctx, bgid);
-
-	if (!bl || !bl->is_mmap)
-		return NULL;
-
-	return bl->buf_ring;
+	/*
+	 * We have to be a bit careful here - we're inside mmap and cannot grab
+	 * the uring_lock. This means the buffer_list could be simultaneously
+	 * going away, if someone is trying to be sneaky. Look it up under rcu
+	 * so we know it's not going away, and attempt to grab a reference to
+	 * it. If the ref is already zero, then fail the mapping. If successful,
+	 * the caller will call io_put_bl() to drop the the reference at at the
+	 * end. This may then safely free the buffer_list (and drop the pages)
+	 * at that point, vm_insert_pages() would've already grabbed the
+	 * necessary vma references.
+	 */
+	rcu_read_lock();
+	bl = xa_load(&ctx->io_bl_xa, bgid);
+	/* must be a mmap'able buffer ring and have pages */
+	ret = false;
+	if (bl && bl->is_mmap)
+		ret = atomic_inc_not_zero(&bl->refs);
+	rcu_read_unlock();
+
+	if (ret)
+		return bl;
+
+	return ERR_PTR(-EINVAL);
 }
 
 /*
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 8b868a1744e2..df365b8860cf 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -61,7 +61,9 @@ void __io_put_kbuf(struct io_kiocb *req, unsigned issue_flags);
 
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);
 
-void *io_pbuf_get_address(struct io_ring_ctx *ctx, unsigned long bgid);
+void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl);
+struct io_buffer_list *io_pbuf_get_bl(struct io_ring_ctx *ctx,
+				      unsigned long bgid);
 
 static inline bool io_kbuf_recycle_ring(struct io_kiocb *req)
 {
-- 
2.43.0


