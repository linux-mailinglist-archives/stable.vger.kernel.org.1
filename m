Return-Path: <stable+bounces-108631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A879A10E29
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7807A1888A6B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409C1EE7AC;
	Tue, 14 Jan 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WKTnpll"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82D16F265
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876957; cv=none; b=KXGwsWGMvL11lX/sZufBzBK5tgBTOmp0BAa6mHDqHg+vpjhH1fuFSGYTTSa84twP69WreWG4a/2Gbd+U7TjrPdDD664PHH31vRKgvuKNjdSyvqa3ZakjdGKKHJ+v2i6W5YXIPgErbx8RlP90mL2VsdzZddq0uO1L4Jl4ptygDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876957; c=relaxed/simple;
	bh=+z7ZnXqzo+JwTlyzEMh+aCsl6hsl7DxqJLFJMsWnKp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ji1canmDkxnzkS0XAEV02Cbao2GS+WbtxfAr74lfqPkpdJ9xhGk8z87njM+P0GwHAtygJTDozj14O5+b8NbgNuXG/cw4lH0dFlNkIVlMrDgmHYvoKcFEo5g/rWJKSd1flJPx7/63l3gL3HSE7NLTlutJkno41m8/cpQip10qwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WKTnpll; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso69775e9.0
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736876954; x=1737481754; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/EhUj+Z89V6RZrUYPhJfVMhULBGhnCEDRDY/TBf0Dc=;
        b=1WKTnpllxHYy9OCIJZeUAvXCuCLQWGMUHrC2mkU10FGafHBRZnVpdxREume+4AkVzU
         UOWZAoxjSZZwd5jEa0uuUwZp4iXzlF7cGQL1fm0JX0Ar2N7a2iZO+BKRywd6QfpMyI9e
         NkphNXdhLBo8EVL5J8gegaDwIOkPgSRFa0Ia48U1ZMCjyUeOr2TJ4ini0P12HVVktzoe
         3nbtK4OulmZVg7OaOgfqhF8kH4y+Hu8ySGC5pb+L6vpYBPz3edVTBefzUD7EoB8zHr9O
         dWkdmg7hug1BiLJvJeb+kyMyYocQVm1h5uLsYft1L9SOLh6su4BeeiqQh0CbHvYzPX34
         4gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736876954; x=1737481754;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/EhUj+Z89V6RZrUYPhJfVMhULBGhnCEDRDY/TBf0Dc=;
        b=j/wdRS559pqib77UlXnxAX+nNqS5OzqiccoS6hdeLYiTc+1kE44tUriNlMlTpIli72
         njFFXmqpINauCeN0ckYKCW+Pr3o9sudGmamj9guws1JRb5xmuHddKTfhetU5IlChnqM8
         BqVWo4LLtA28m+3ZJhPXsWnaujJdhZh5+TyLNcUX/lbRBU8a/zu7mV4AecO2Q9PhLNV/
         Xjx7VLmh0K3gLrHhmAFJVrP1bJI/LxL13YCSkLAWXw9Aol0wIRuajIPgG6vyAdqSWwpY
         sPxUnXsJMKQl+GT4sZjgsArhcSU8AQsclmB/IAGyZLEUMCorrqRMBXwI7F5ip/Ys93Qj
         sfow==
X-Forwarded-Encrypted: i=1; AJvYcCVCFJlbOoafjDpQLVqwNmDImAQM8vE4J5b2HehgZcwRI0gjaEIydttFN1evBoxuFvgcMqZItG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeQGzCDNzIxDgeILqfgSl5MHfI7ucwTqT9FEvxluGjtr/UaPb
	lnMCUNyl2qvzi3UTWcGLPzxIXlqsCYZmijCfTNDys1PLrXeIv2SO7qnxqzZlDA==
X-Gm-Gg: ASbGncuWuzgCLGmfU0efcY7iZ5y9HbjpNHiVVcM61kFfNcoNczrDZTyIpDJrSkXp8DP
	Fgt0sW4QTVt0ZVQXcNnhdreG9u2ocjmRe/Ow8v/DBM1kFhekdm+JfI4o9SdLhK80IcFz0/G0h7u
	4NySzWdmUOTswNH6OZ/0RddM5a8iyUb06L2fCHGxeDWIxapib+0F9PnpLnuCsnWPRoACA1TwdFN
	Ni7IOY+wDtZCIj3xpDB4DVE4lPV/FsXlll5DVaH5qwing==
X-Google-Smtp-Source: AGHT+IHB5PEFMbygc74F/+oeDv4I6J+5PXKLGLeXGDUSZBKuRtqQ+Nu5FLfyHIAgxEZOSAQ6TxIaRQ==
X-Received: by 2002:a05:600c:1c26:b0:436:186e:13a6 with SMTP id 5b1f17b1804b1-437735f9974mr1504555e9.6.1736876953451;
        Tue, 14 Jan 2025 09:49:13 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:f0c9:ad9d:2327:39f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fd03sm188665915e9.6.2025.01.14.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:49:12 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Jan 2025 18:49:00 +0100
Subject: [PATCH] io_uring/rsrc: require cloned buffers to share accounting
 contexts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-uring-check-accounting-v1-1-42e4145aa743@google.com>
X-B4-Tracking: v=1; b=H4sIAIujhmcC/x2MWwqAIBAArxL7naC96yrRR22rLYGFVgTh3bM+Z
 2DmAU+OyUOXPODoYs+bjaDSBHAZrSHBc2TIZFZKpQpxOrZG4EK4ihFxO+3xiSIvK91MrcK8hhj
 vjjTf/7gfQngBZfYV3mgAAAA=
X-Change-ID: 20250114-uring-check-accounting-4356f8b91c37
To: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
 io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736876949; l=1948;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=+z7ZnXqzo+JwTlyzEMh+aCsl6hsl7DxqJLFJMsWnKp0=;
 b=rT6imj0L69M67jWPfzUa4j3r15LHqo9N/M1tgoPDIYs3PyYjjQaqkzUMEUM0rjLK+d71yUF7K
 VfBwaaiceztBH5kuBGGFABgLUxRisIXDO9iYv6BJm4AvG3e4CrZlc3M
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When IORING_REGISTER_CLONE_BUFFERS is used to clone buffers from uring
instance A to uring instance B, where A and B use different MMs for
accounting, the accounting can go wrong:
If uring instance A is closed before uring instance B, the pinned memory
counters for uring instance B will be decremented, even though the pinned
memory was originally accounted through uring instance A; so the MM of
uring instance B can end up with negative locked memory.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/CAG48ez1zez4bdhmeGLEFxtbFADY4Czn3CV0u9d_TMcbvRA01bg@mail.gmail.com
Fixes: 7cc2a6eadcd7 ("io_uring: add IORING_REGISTER_COPY_BUFFERS method")
Signed-off-by: Jann Horn <jannh@google.com>
---
To be clear, I think this is a very minor issue, feel free to take your
time landing it.

I put a stable marker on this, but I'm ambivalent about whether this
issue even warrants landing a fix in stable - feel free to remove the
Cc stable marker if you think it's unnecessary.
---
 io_uring/rsrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 077f84684c18a0b3f5e622adb4978b6a00353b2f..caecc18dd5be03054ae46179bc0918887bf609a4 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -931,6 +931,13 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 	int i, ret, off, nr;
 	unsigned int nbufs;
 
+	/*
+	 * Accounting state is shared between the two rings; that only works if
+	 * both rings are accounted towards the same counters.
+	 */
+	if (ctx->user != src_ctx->user || ctx->mm_account != src_ctx->mm_account)
+		return -EINVAL;
+
 	/* if offsets are given, must have nr specified too */
 	if (!arg->nr && (arg->dst_off || arg->src_off))
 		return -EINVAL;

---
base-commit: c45323b7560ec87c37c729b703c86ee65f136d75
change-id: 20250114-uring-check-accounting-4356f8b91c37

-- 
Jann Horn <jannh@google.com>


