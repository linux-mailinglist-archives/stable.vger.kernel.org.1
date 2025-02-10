Return-Path: <stable+bounces-114698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08049A2F539
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93821168978
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181A18E1A;
	Mon, 10 Feb 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wya8VrnR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD824BD0C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208420; cv=none; b=Wb+BaMu6Umz69YrjkuCpSZFpDQSPYON2VgEvgqqzRs4qnrQBatmh0BXS88Ikx0NLz6oiKscVerL2u/6wLV6ajuEICyj1aa3kUi9C+sJV8cLBZBRjBDVYoHaNYZC+/bF1JKyNL6PufsK1yx5dT0Vk/WIBsn9euN/64+XytM9TOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208420; c=relaxed/simple;
	bh=2Wl1hyqtZ0mXP3Lj0gnUvkPWlqlpcbfdEDRSmfqEKbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqnB+AJWYAhfxnpe1jJ1LbrBdeh/4GXlKue4TY29/M96ENIzB/OILQYoTYa8as2/04Vxd/nQQGHrDt1v23i/5cF8iZwE4RUJ7gG3lULDSuacdWUnTl7ildwwl9GrjmvShgTjn+Jcf+9n+olhhocgxB58b3p6donAIqpb0QcGQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wya8VrnR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de74599749so2233473a12.1
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208417; x=1739813217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtvCastSZ4Uyda7zLhO4e6Tlk2YD1RI3z2NLX7t7fWI=;
        b=Wya8VrnRnrZ3J37HK+NnV+szyjJX1RidBag0MxRCepvjzfHO+q117ZAA8pl5iEkdWx
         kkdjpPQxygxyt78+agrBpOcxOtIpIjW2jy961Eff1NXA6WLeo/uyU6X2XRlpJLAJMznj
         jc/d/BDyAVKRmZ2uE6UmF+04ZIGdPvtKP6EQ2rfQZO7E91BNDq4gVhHSevVsLMDoWlyh
         7EZ0F5LR8kRojFnzwcaj8sG7GbGxOdqwWfbhcFuYVuoPp2h4cZ3vfze6m78AMu+0RKg8
         2eRMCGHfZXmIKytltG+6lmDO8JretpEDzpGFCCEnTH/KwAc9VepVMEq0PL8WU9O3WIKi
         qN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208417; x=1739813217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtvCastSZ4Uyda7zLhO4e6Tlk2YD1RI3z2NLX7t7fWI=;
        b=xGphsRuzNVng6ioNnY3jluYaq99mt6rUX9qE0jByvF/f3jVTua8k1ML1cRRYpovOvM
         dgndbFVLGMqWngGRa59x+ly5R/EJe8pN9+jXhqn1Cla/rAPjomN6FPkzKLfJAFwimKwe
         nZkjustJiAKhwA5vHznc4QgjMoBPQNZNyXJzfV+4ZEXvlqkGTA2rtNgQTKIHG232MO6k
         lpANi7ygwU6sKCOwzOtHI4FmzHYf3rHPJ8ZbCTIB+NtJOvo8zMu3Q60YQmeJwzVzjrup
         1Q8SXDe3wiyLR+S3zCjDBpnIbf1FZ7uOxDoKVNljCCCSmADkgcwKVRkmvaDvVr/JIpBG
         xOsg==
X-Gm-Message-State: AOJu0YxHKbpfw6TB3oAMJkE6LZwouLFJzsASGSLRNlDFswghNvvjddU7
	Q1SCL1rwKJCvDHx/u6PXFxBb4vm903FoT2e6oO4BzWv4WfkIgdqPiomxZA==
X-Gm-Gg: ASbGncsV63QEf8FmuMb+9jds2gmvTuwoLyWNaPp2fImr7Y2oO3GQOdHGjzJYOZ4G0WO
	3VoycpxNo5M/Y16cqAebBmga7tATGK6c4Dwz1CZBuy5RRXlT0iChG0DcaFmo5ehqCqNsWIbAm6y
	RwruTXhQ0Aze2f35JJAbmUrDPia1hKDpfl58AIaUENy+02nQh1aTCP466BaXWqwY2KUi4oIM+zo
	f9S1VrR7WBQmjSmL2ZXLKufcXZVlFnw47udB4pqojoXoi/luFLAT5xCK8iqoxATH43FUR1vAE4=
X-Google-Smtp-Source: AGHT+IFf3kJgoNpjI/r1kctKA6HxkIjJ3KKC4wi1ghPV63l5jL8uXrZ2fndAezTgtPpdYw0h1cjB9w==
X-Received: by 2002:a05:6402:1e91:b0:5de:39fd:b2ff with SMTP id 4fb4d7f45d1cf-5de44e5da3bmr17214000a12.0.1739208417036;
        Mon, 10 Feb 2025 09:26:57 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:cac5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4ba95a32sm6931723a12.40.2025.02.10.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:26:56 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.1 2/3] io_uring: fix io_req_prep_async with provided buffers
Date: Mon, 10 Feb 2025 17:27:55 +0000
Message-ID: <ecfd2314f89e04f39eca1b5642e34de82d6907ba.1739208415.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739208415.git.asml.silence@gmail.com>
References: <cover.1739208415.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]

io_req_prep_async() can import provided buffers, commit the ring state
by giving up on that before, it'll be reimported later if needed.

Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
Fixes: c7fb19428d67d ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 64502323be5e..33597284e1cb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1624,6 +1624,7 @@ bool io_alloc_async_data(struct io_kiocb *req)
 int io_req_prep_async(struct io_kiocb *req)
 {
 	const struct io_op_def *def = &io_op_defs[req->opcode];
+	int ret;
 
 	/* assign early for deferred execution for non-fixed file */
 	if (def->needs_file && !(req->flags & REQ_F_FIXED_FILE) && !req->file)
@@ -1636,7 +1637,9 @@ int io_req_prep_async(struct io_kiocb *req)
 		if (io_alloc_async_data(req))
 			return -EAGAIN;
 	}
-	return def->prep_async(req);
+	ret = def->prep_async(req);
+	io_kbuf_recycle(req, 0);
+	return ret;
 }
 
 static u32 io_get_sequence(struct io_kiocb *req)
-- 
2.48.1


