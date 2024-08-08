Return-Path: <stable+bounces-65986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B919594B4C6
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CF5283BDA
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD54BE65;
	Thu,  8 Aug 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Oo8MyIGW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF6B672
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081713; cv=none; b=ZYAlTHZXoS1bAe6vc2AVTm29cgDpwytqKnNbsNYICSjFoTE95/EKoW42gxheELVOwV7lpi/+jcD3sf9xcgbT9H3p3V8G8EHtlIOCd5itc376H/QJaZRCOeL9jASdJzhBxGYb/wM4evmRIEURK4ppaoD41ycid0oCP5oTLNauKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081713; c=relaxed/simple;
	bh=Olz8+B8JExXtrS6yDdKY4FVncYtOGs9iB4C9qeHIJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSnVkBY8BoQSTRkQIob0j55ippl+FfHvosXsuxc8Nkt6zzo/rQg2a1ILJBVkNiFAQfj9+Fx2srptLW71DyaH/07yZetyRVoWYh91cFpwRw2hHmaRQwWQJaGqUWo8yggGyxeaHQ1XZ0HA2BwVpHTjS9Hrr7SivLkGQov17uni+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Oo8MyIGW; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db111a08c3so46874b6e.2
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723081711; x=1723686511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEsA/NppsdV/3COw8KfaFKbZSK5vL24oUW1cM/bymMg=;
        b=Oo8MyIGWTFXIqQHxBa7X+caSv1t4Jrtdve83Qy6kZuLNGtTX9HWmm0bX8vHUwBlYmj
         +jG6WDKTWOMeQGEZTx41fy0B5nzTpXn3o+Kok4bGQhV16IZIED6+ea9RrrAWz1Yr2tQ/
         W2oYfAjQM0O63OXeTZLZWF24MYh8bboedaR0P+A1vU5cV9FryKIsHPP2qwHbjPOTdEZ8
         jAu3VJmV3DUG37O604YpuncTYjyzzIbMILlVOYgTKYLbvs3MRwKAsnRgwjUxhGNypLgd
         ys79EkZTmkW2L1wt6KwKOMuzITFVt0Asu6yFNAiJszhbZYi1eSsMCqMIoPMmpR1HhD3d
         cH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081711; x=1723686511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEsA/NppsdV/3COw8KfaFKbZSK5vL24oUW1cM/bymMg=;
        b=QkvCGmcbeJ83rdEyt35/Rs8fC2bd01SjQX5rcSA5PHIbeuUNvmZcuUcwKTfIQwTeio
         4Dy01d06u2CW7dKJ35MiFtcJ+0Z85fNFdiNc4eLWOMU0tYu+mmkyvAg0JUXNtmPaH69g
         kS5qnHeTMA7n6wsPQazwpOoIvwk9XtiNns/LrHAFT1jRrWot1yY0Y/HrAsj9y4R0z2/Y
         qsTeAcmBLO5M7L1OOewGt7q/1NSL9OUW6sXANfdg4AkDG/6pC8NEPGVRN5qOjMeHgRIe
         JY7tV4CAZ3B9tfarnFjyaYWxNaIZYFLbCQizxmSnhyy7+nIzCMoOZdI3PZDIEJAFXFU6
         d/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFWrLuJ8dEdbZEKT1OVxfE1v+BFSBaoNGA28uDqMFx6TlcEQvxlp1ps8b+mwzuwWvGy+9RwiZnqnobjmPPmwDCfE90NHsg
X-Gm-Message-State: AOJu0Yx6J1ZKYUAKqu/7JhgsxqQ4KWXPkV2Zts98jHeGUHQ3VWNO4SbL
	lxDuUWWTH5Tax4ziXlRfmENvZFYgsaQLAPuDIsKiEm3cJvZ7NTKLybf4O5nEs9p0NfJFUlAulG2
	g
X-Google-Smtp-Source: AGHT+IGw6CzHlEF3KWib4NI1xrULkrIxi9F/79yXLk6ouOiEL0cJSpes0zwqcCwz3YxbRtUO00ebuA==
X-Received: by 2002:a05:6870:568e:b0:268:2075:a41d with SMTP id 586e51a60fabf-2692b7a4561mr280377fac.6.1723081710693;
        Wed, 07 Aug 2024 18:48:30 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a104sm150771b3a.21.2024.08.07.18.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:48:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] io_uring/net: don't pick multiple buffers for non-bundle send
Date: Wed,  7 Aug 2024 19:47:29 -0600
Message-ID: <20240808014823.272751-4-axboe@kernel.dk>
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

If a send is issued marked with IOSQE_BUFFER_SELECT for selecting a
buffer, unless it's a bundle, it should not select multiple buffers.

Cc: stable@vger.kernel.org
Fixes: a05d1f625c7a ("io_uring/net: support bundles for send")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 050bea5e7256..d08abcca89cc 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -601,17 +601,18 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 			.iovs = &kmsg->fast_iov,
 			.max_len = INT_MAX,
 			.nr_iovs = 1,
-			.mode = KBUF_MODE_EXPAND,
 		};
 
 		if (kmsg->free_iov) {
 			arg.nr_iovs = kmsg->free_iov_nr;
 			arg.iovs = kmsg->free_iov;
-			arg.mode |= KBUF_MODE_FREE;
+			arg.mode = KBUF_MODE_FREE;
 		}
 
 		if (!(sr->flags & IORING_RECVSEND_BUNDLE))
 			arg.nr_iovs = 1;
+		else
+			arg.mode |= KBUF_MODE_EXPAND;
 
 		ret = io_buffers_select(req, &arg, issue_flags);
 		if (unlikely(ret < 0))
-- 
2.43.0


