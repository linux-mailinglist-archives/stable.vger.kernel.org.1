Return-Path: <stable+bounces-65985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFC94B4C5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB21B21237
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4EBA37;
	Thu,  8 Aug 2024 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t6buMSz8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33708F40
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081711; cv=none; b=j7JbVNx1bFlJdmrVXxbLsSGORPbZN9BKhWA9EmMhYJLj93sjdUxkueArTMK/3yA7P5urcumzg7mtXT/ykXzMVS9g4GckZCNWNHbU0b+wELQqSGuErMA1zJqBPXZQE3WID5oqenlIV5MpR3dldN7t+dffiCsGrwnNarbBrW1KjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081711; c=relaxed/simple;
	bh=PFAoFW7oMR2Idvj6SJZby2kp8GCB06WLnCnGFRsccRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiYWzN/WOCl/utwJw5G/ARzGtgmcdRM2/8f2nJo3KMPTI9MmwFVgyFyC0jszk/qKp4mQvHdb61yNP877YBvNNnS7iSjoYqHJR3Hht+Qf7aBKrWyDS3HRqguDWRNbDQnv+A8yVh9d8vq0/LFrjpSnXxqeLoO06e5PFcPBEbImgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t6buMSz8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cdba9c71ebso91910a91.2
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723081709; x=1723686509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKTARnTjGZ+ji2YsLWEYUgv99KOMEs/vXXuNntX+GhQ=;
        b=t6buMSz8+7AyGJEUG765cpttwds9USlS3WNzIOWLUuYFZncKm159pRZAD7rWaSKt20
         q9SCiFpSocbFH69Aedobuie2GkyJlS7SVzVNL14/Ott41znQOt8UD9W5EfP5JxElWiXW
         s4T62QTdo/X2n/OksmxsWFNH3AcnJ6CBGbExt+f3DXAE4OhvPOLPjJ9znYSN7aRYvILo
         11mwtl6P+KDMS34B0LbrLMdPoAODhX8xMWUGqpJAQlTgN9KEGJcRqHCfMv5CqVY3Lso/
         3rkWxG+KhWKfbncJ+DWAG49BJ87rbwh6PxJPvqlLqcVHSPMHX2xSqTet1ImJx2hu+Mmd
         Afyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081709; x=1723686509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKTARnTjGZ+ji2YsLWEYUgv99KOMEs/vXXuNntX+GhQ=;
        b=W2igaWfybVXJ5cnAwOG99Jnb/zG0hhPGgSQNp1mbzykFH6LHAbS03XQc35vXxbfqMm
         D4cRNhKJloOGlQgv6X+1P+OVMamXrIFXLaHmjVg/jV8JdXVVjEA9yUEFMLdOvhQ2e2yM
         z8esYjP2GpLVKtqktEAcm8kHOvAoufRymFxFQxCPme5ZMpZYr9sb0amlP3HC0e/op9dW
         MiSL+ECahmgVqGPXI9pUBqXelZqgb8gHPDTEeXDl6uBcJ1zi4XMEW/Ll7nGu6+v93T2a
         7dlQxlaCjFr/95l4n5UoImoDGyixBPclU+g/REQIYvLMeghb8tKXXkjjdFKFMwkCnO2U
         WmuA==
X-Forwarded-Encrypted: i=1; AJvYcCW27HHIMCEzMwD0GIv9ZlBF9Gh2dlOWIRvcHWQhR3bVzeZ0oTSFGk1S/uftVT4KYBMA/w9sHyl8SViWNbTgaIe079c5O5AE
X-Gm-Message-State: AOJu0Yz9a3HFDUUE2ae+ho7Wkqc+ETs5/GxO8KRNRl9/87fG4zg/Gpp7
	1huzCKcqC8GoTi92f20ktTba3WSHFgrKd7/u8RN6+cmTHFKyLBO/gM3D9r4dhKW4BKhX6GPqNKY
	4
X-Google-Smtp-Source: AGHT+IFU9HmrxHI7Fux7WSDeBe+TVG0pfJIsSOB4Hr35Hmvb9Qdnjf+zoaYf+gE+nvbA4o1ITk4Wbw==
X-Received: by 2002:a05:6a20:6a1a:b0:1c6:a62a:9773 with SMTP id adf61e73a8af0-1c6fcf80146mr208842637.5.1723081708994;
        Wed, 07 Aug 2024 18:48:28 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a104sm150771b3a.21.2024.08.07.18.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:48:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] io_uring/net: ensure expanded bundle send gets marked for cleanup
Date: Wed,  7 Aug 2024 19:47:28 -0600
Message-ID: <20240808014823.272751-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808014823.272751-1-axboe@kernel.dk>
References: <20240808014823.272751-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the iovec inside the kmsg isn't already allocated AND one gets
expanded beyond the fixed size, then the request may not already have
been marked for cleanup. Ensure that it is.

Cc: stable@vger.kernel.org
Fixes: a05d1f625c7a ("io_uring/net: support bundles for send")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index 97a48408cec3..050bea5e7256 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -623,6 +623,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 		if (arg.iovs != &kmsg->fast_iov && arg.iovs != kmsg->free_iov) {
 			kmsg->free_iov_nr = ret;
 			kmsg->free_iov = arg.iovs;
+			req->flags |= REQ_F_NEED_CLEANUP;
 		}
 	}
 
-- 
2.43.0


