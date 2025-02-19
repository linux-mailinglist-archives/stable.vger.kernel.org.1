Return-Path: <stable+bounces-116943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00401A3AEE8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E433AD68F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C11A315A;
	Wed, 19 Feb 2025 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGUlhN5t"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290214B092
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928439; cv=none; b=ngV00EUbeJfWmAO2cOfDuefzj2aIfRZSPEOvSBFimYK+yaZ6QeyIq1mexEVcduhRHLZ1DXfpCu8f3kUY4uOCPdij6PtdLj/xGAeiPcrm2Tu5v9SbzwvmqvXZQRwnQ4YnvATdPW90Ei/FPAtJsPBDYxsS0bhhfCVdU2Dn+f/EG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928439; c=relaxed/simple;
	bh=82yuxgXO8qs2fxiGh2bdbxJlhzYnhXK5v3xf3em8kXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM8ae3ceOBQ4/GZRp4/Ow1UblrmgxaWksar/xjItVzMSoe68VPG6M/YBzkG1U+BbuEuUpURlQwlZBxd+X9xW9PY6g6U5qKcJPDlVcrfFJbYvbtIHJBsMN+wzdEIv0p1C7WcDOQK+ws9Z1fEGj1q/wCpqthumtvPNifbdLY9BL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGUlhN5t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43971025798so22048255e9.1
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739928435; x=1740533235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BUjdn2tGFIk74tzT0ftd+YfZs0/RiDrpHYlW+CKkVk=;
        b=OGUlhN5tJN82ceN5P4T2Q9eahsziAXNxGqVw4IbGJI4Hh+CVxpDT9kaWroTsq6lquO
         t1CvIEYNigY3IaVPSBMZcdSrSKrTOlzegq/Uc5m+dD/xzCJ87FufbdHo8tI8MnSCam5x
         NjRWd5DhMxvNfFf5Su/DjAhSbFcCms7xUbAzPk23zrwjX68Q5W8qwSt5DhtWNqlTWMIM
         61cRr+mo/Vpy3w6O2qDfAppU5DpR7JdZtMyKdtisAc07QKBNCIQ+BhXBg1byk+hINuBG
         PwRVy09STgD6pfdAQ98A3oH38XFSE2uO7f/0SzRJ8Nu5Zl1c93CChYJz2F5La6QrboAW
         5rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928435; x=1740533235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BUjdn2tGFIk74tzT0ftd+YfZs0/RiDrpHYlW+CKkVk=;
        b=Uou3HsV7h3O0GEJIPDW/5EhyAaXcCvrASJZ3TSDm+2WMyS5IlbmvmA8T6zq4f0h08l
         m9IHgCFYqwOtuO2MO3Sd6/Pc2U0TYrjAKquHIOhgvQV3ZCBusc06AP36dik4qn1D2ECq
         KoFWea3QCKQh/QrtR6+Jj42yAvEz3GvvCbaM1OrWiB1FT3ezSmESMdglKJDeNhaJ4dKp
         speQDFDCrprjonuXngicTfOH6BxamLHDOBOGBTkG9pQbRuNtHS1u1fTCF8UN7Ur7X4Me
         TOtE3m8Q/BgdzydPDueYpzAFignNjYtNoAp4QtH9beKegaddqHtcrXLfdZVxmksSsEhv
         Hi1A==
X-Gm-Message-State: AOJu0YwW6fJZ3Jp3iKUkBm4XLq9TiEu9mQa/fBNe/MrGeZ808rxsIdSo
	KwFQJhGM0EdSGbhEpvQx+r9+58S4MD1+Zs08RXsNNv7IDoaLQqtvu78TwA==
X-Gm-Gg: ASbGncvNegFxSrcBqhgJQOAom/hDrt0QQAHIBv63Jm7hq+gr6BkI82B1qwCk2FKAWgd
	zyr45c94QVDqGdgIcjXanFKw1fL0Ga0TYZ/Zsw61ktJKEg0bybavDerUQ+u2Top1o6//lanqiCj
	2CpwlhU4zhTMqZ63sVla3sCialdSA1hjU7MTuvvqlbVY8yX6gZi+wn3eoqqEltxrb7I1lUvuvNh
	CHtlqQbe9pnFlO3mDyH82fG1qE38GKm7xR1jYxRKKJDRMiu/4qa26tHrO7IQIAIYilbvrUU8s7m
	uhqcXgprtLQOUfBTwgRtNI5mFge1
X-Google-Smtp-Source: AGHT+IH1SxSV2zMwPEMpjfY9KZRl/18o3crYFXPVza+hPYCcvpdZaEWC63Trv5kZJGPIicRl87rYUQ==
X-Received: by 2002:a05:600c:154e:b0:439:8c80:6b02 with SMTP id 5b1f17b1804b1-4398c806e08mr76075885e9.31.1739928435087;
        Tue, 18 Feb 2025 17:27:15 -0800 (PST)
Received: from 127.0.0.1localhost ([185.69.145.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm16106847f8f.41.2025.02.18.17.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:27:13 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Pumpkin Chang <pumpkin@devco.re>
Subject: [PATCH 6.12.y 6.13.y] io_uring/kbuf: reallocate buf lists on upgrade
Date: Wed, 19 Feb 2025 01:28:06 +0000
Message-ID: <df02f3ce337d92947f14bdd4617b769265098e29.1739926925.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021855-snugly-hacked-a8fa@gregkh>
References: <2025021855-snugly-hacked-a8fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ upstream commit 8802766324e1f5d414a81ac43365c20142e85603 ]

IORING_REGISTER_PBUF_RING can reuse an old struct io_buffer_list if it
was created for legacy selected buffer and has been emptied. It violates
the requirement that most of the field should stay stable after publish.
Always reallocate it instead.

Cc: stable@vger.kernel.org
Reported-by: Pumpkin Chang <pumpkin@devco.re>
Fixes: 2fcabce2d7d34 ("io_uring: disallow mixed provided buffer group registrations")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index eec5eb7de843..e1895952066e 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -420,6 +420,12 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_destroy_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
+{
+	xa_erase(&ctx->io_bl_xa, bl->bgid);
+	io_put_bl(ctx, bl);
+}
+
 int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_provide_buf *p = io_kiocb_to_cmd(req, struct io_provide_buf);
@@ -717,12 +723,13 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		/* if mapped buffer ring OR classic exists, don't allow */
 		if (bl->flags & IOBL_BUF_RING || !list_empty(&bl->buf_list))
 			return -EEXIST;
-	} else {
-		free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
-		if (!bl)
-			return -ENOMEM;
+		io_destroy_bl(ctx, bl);
 	}
 
+	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
 	if (!(reg.flags & IOU_PBUF_RING_MMAP))
 		ret = io_pin_pbuf_ring(&reg, bl);
 	else
-- 
2.48.1


