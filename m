Return-Path: <stable+bounces-116942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB6A3AEDB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3081708D4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E676025;
	Wed, 19 Feb 2025 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5aHjZJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8A1EA80
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928349; cv=none; b=YH3ddI7z/XX1KsvS0ppKZDY07MEFLQZYfmD+XdP4qjtiyu9bfyali1Ujn1iX1/qeeuJYMFNuNUPXiPwWS3QcTOLQXgITmxRMcChQdGpSpm+HDYiyhYpBGx5OhKkLKmaiMTcfknpxcV7schOqNkRRNj3BZIJSsg+iTPRFExRQ9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928349; c=relaxed/simple;
	bh=ZaL608RmExYRYmWAQbbVWRdII1oyaT3orbA/4msVZ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4oy3lLo6A+n4VBDQy1aoVU8IH3Dhna6LkbYPlnF6gSbtiyh3wUEQHMUEToo/wSpzCqEuonK+QAt4d/PPGKKcObKh1O8PPVH1J5jHLJwCYQc2HuLFeFygYJJI7mSDp3lVYTJJWN5nrOTl7rOOjLvsDfYj25Yc4dsm3pyCdDKGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5aHjZJt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4397dff185fso28987465e9.2
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 17:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739928345; x=1740533145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7CLLK88pA4CuKkXfbBmj/CUAX50RvOsqLUJHaTl0lo=;
        b=W5aHjZJts14EWfTB48mWCl3EOH5DQHCuqMEx7xVOU3UQH2wYPBGqE06yvP2mlZJBM7
         bOhc8VjSxYHCpkeqtb0Qb0Sn1W8KAuiYdGrD8caLCByn6zIAQo6Mn+hsSKEs6pzeI41V
         H9mWI1mLFFcfe9EN7a+MKCmizGNHN3csyyUSgoQsVOEsTng8fhhWAUq3Di4FsKU8U+Ad
         lj88xIoUksQLT71sx1mOHBZdQrcP4MSeNIG1dapBk5DhXo4SSOBSjdKawSxHP/tsCTCk
         J8izQG3QOHck3n6lQY1APtxjHOQ4QrwLXFKoGyQXrmTPSziU5bX7Pi7KV7mBU3tAOX/Y
         FEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928345; x=1740533145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7CLLK88pA4CuKkXfbBmj/CUAX50RvOsqLUJHaTl0lo=;
        b=uHBGCFPsFUAY8094g1JqirZgrc1vi1x8Nqj/0VZRxXSL3daZK5TFrlmJtlwBO31A0q
         c+vAC23wbAXNxJoF2ImN2XqG5vBwwpSJmDDhyVchXwD246bOgmee9U//t70MlvyR82w+
         iGhDB/vIYXVEQi79+WMCPQNhrliY6m8PvLd4ifeTo16tfq0E1FudamadlCye/vcGp8UQ
         5wxuy5/yrzNGGTqPvyqcrGkAGnbURaHXpufV4ahJXuwsrtuuuDhvkeR5tDtixo5OZ7w5
         5/O6nM9lbtCOafdXDi0pOKL419HQZfeu33k0/XPjs2mElmJux2HWPUgd/uMFUsnbKtyq
         JuKw==
X-Gm-Message-State: AOJu0YzZ0SO49X8QjPyvris+nFq1jF1KPJVJpdoRb1GTqw+5XQVFa1ww
	iUR7TOCwDmYPApfy2WxJmK/pZaHsZCrDjMriCLD3QkkS0Cpudz9XFqQkiw==
X-Gm-Gg: ASbGncstCcGjCtmS/0zdILS8pjMLM8fAxMwln8TZ4Aj4+zS5Gej/XEUybAjGK1XAYZ2
	yC9rymFlwv40zHOnorwc0J7CBspgZXllJnAApokiKb72q2nR8Ycxkb25A9vHdgFngN/VjwRKh8t
	qnrwcnZzjzOmsR4uLo0VaoVAOQnqw1iw6j0nAcID1CaX1NhlMdbSolFBliz9ot6sR+YtUQl4tBC
	KhVrt5SRdl/YRr9hV+VGytdiJ8dG4i9wy6BQ160RHutT2+ELJQum54qqn1h4O3FD+v+BWR43KZs
	IbW7tkitrfAkll/inZ7RDq76olQt
X-Google-Smtp-Source: AGHT+IEmH6+oInsL8UkcRx71DgdO5gZV3T4FBxTeNNF0gdC7nQJIM6dkfVtELS1RDlGtMSyKlgJStA==
X-Received: by 2002:a05:600c:1c8f:b0:439:6925:4d42 with SMTP id 5b1f17b1804b1-43999d72a62mr16986125e9.5.1739928344337;
        Tue, 18 Feb 2025 17:25:44 -0800 (PST)
Received: from 127.0.0.1localhost ([185.69.145.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm16218464f8f.49.2025.02.18.17.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:25:42 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Pumpkin Chang <pumpkin@devco.re>
Subject: [PATCH 6.6.y] io_uring/kbuf: reallocate buf lists on upgrade
Date: Wed, 19 Feb 2025 01:26:36 +0000
Message-ID: <03083d05f5d3f86b749f0adb15629270139b1e08.1739927943.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021855-fancy-trough-87ae@gregkh>
References: <2025021855-fancy-trough-87ae@gregkh>
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
index 702c08c26cd4..b6fbae874f27 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -301,6 +301,12 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
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
@@ -642,12 +648,13 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		/* if mapped buffer ring OR classic exists, don't allow */
 		if (bl->is_mapped || !list_empty(&bl->buf_list))
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


