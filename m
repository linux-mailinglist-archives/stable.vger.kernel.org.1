Return-Path: <stable+bounces-172389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF14B31919
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8431CC48EC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCE304BAA;
	Fri, 22 Aug 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CydOrFPe"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9422302CB1
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868566; cv=none; b=rsIGdjJrLROO1WqR9Sy6kb8YM8cEaYT0tOfa6MNSwz9wZJOZjsA/rBRzhDtfPkkUUfixTviHgZRaeecSs2XFMsn2j5kkOxJvmNASpgB26xplDldfdO08iSqmL+iH5ew9DUUUR5JNWPUhM6XVjOLQNQkiOsYBBkaWZyOEaOEuw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868566; c=relaxed/simple;
	bh=lCsro4CJBMF+D3264rl3CNoPtUXoImd/BPkzVlHunKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9fVEofw6lE3UwUh+aUDkPMrdxvRD/s7exnRPhsJBMKQmIhU5uSf3UeT222DqmbyO9ElpC1e9OItU5RJpj/aX/AnzteyO2KKblMEOI2dq5Up+zGqWNiTW+BEM1Ql9Q7QvYLBP0/N0UKaDdOsFlg2iwJR8CMGYzd2Erwc51n+KOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CydOrFPe; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432e91223so52909339f.3
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755868562; x=1756473362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AKAb0qEkHWYZZg+YlLBlMjnmdIz5QWZ/OiVNDXJAIQ=;
        b=CydOrFPeOQ+0BSMZr30hcUvwt+yUY6P0+BkAZHPB4krN7NugIakvyIauuati9q7Qly
         8aTd7Eevg9YbZJ9xQ4TgUs0F+pPmHEvgGXNn/UyFsmGarO23ZnXHoF4C9MyCb7gPz/zQ
         cCiYLL+0cTvrUUxiDpMRdrEJfq4xEMqcEpdiEWcSzeHW29FYW996xDZz1tua+/M2L/Q5
         cb9/pDqXk9pKkeKS9TIKWzpuOv/fjdo5JDKkA7UXq8HKC17BLMp7XyaXFiLpYM8SmoiK
         x7BqPhm+Vtz+hBrrE5CRjqDg4nUSuqPpZrCCoRTjxTpvBTeOFjlWHcT49EBbDJ9UrCtT
         ET8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868562; x=1756473362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AKAb0qEkHWYZZg+YlLBlMjnmdIz5QWZ/OiVNDXJAIQ=;
        b=VUmDNBX1a/NbNcz9qs7cbPCRZjls2nONv9APTwUinsHxyHQIkwNaXNQZ4k+Q9NA0EF
         258xqawEWJFuh9Y39I6JY/ei2Wyg57I9bdsW+KcCP8BgEq6tmijZKSy2eNlpHymAG4Uz
         abGZzGB3np+qJsZX8aKDZT4eeJDHg93pFmXL8KN1pv/yitcCgBq27XXc41V7i1u2gbdU
         02W6jpuQ/L1FZOQRrObmTw0ffi6hN7YH90bUfyQx0iA41ipzX36ZHg4Dq+AgEKY7/IOo
         XMvxuepzgIntrJyllEAlt9R4BTX9HTcwzouI9FYXAhz7Tb+rvu1DNe3qeBXZlZtcqm1p
         khxg==
X-Forwarded-Encrypted: i=1; AJvYcCW79yzAuQs/IhcbKnG1dk0jhZjWwfuS9bp3GZO7rAcAflREWPcSwKcSID+RX1UL3o6pY1aVzy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeKwZjNvwgrL4r0GfIDs3nwJx114vcdplym4zRrLT4gYf0KyN
	FqZmitlBGeCLBNVmYRUYqRzBQjLJWE2ZVFyvrwe0oVsJ81trUzO1lzAwGulYxmuRwRA=
X-Gm-Gg: ASbGncvHe4xsFMN0XUDmNcoD7P0lJtc/gpp/VYF5O748ixY48Q6vYhTSi86kg/kFaP3
	aAtlswpcSE6pWIGdEK8ik+ep315evFThYj94wbOLEgqrxhmqn9T/7v/sNi4yWxxW3zJt9VmjxYA
	R+Jy/c3jsI43bbRsSdxFzeRePN9uH9NPPj4OxXIjMjtz2YEnG242h/x+iEqLcay4YDNvZ3Lkxr2
	zpN5z5TyLFudBgMu+utnvhSlwn/dJmGPsaAlbYw8Dx3opbdgk5+EaJ9mimsJZsAIJQDqEvrPnUL
	/FFqnaYQBcfrFdrTwtTrdOp2Lu3/C5orHqtlpByTSSEycsOSQn1AASq2+GOcpSs3z66qEkxbTEr
	r7Vkkkw==
X-Google-Smtp-Source: AGHT+IHZ5YQhjejrPhudiZOgQaijyjtdhk+xq2EPlLZOIVAxl150S4/CKW7qPcD+okX5qetQN5C0cA==
X-Received: by 2002:a05:6e02:228b:b0:3e9:eec4:9b74 with SMTP id e9e14a558f8ab-3e9eec49f44mr11692415ab.31.1755868561112;
        Fri, 22 Aug 2025 06:16:01 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e679121sm89355595ab.30.2025.08.22.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:16:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/futex: ensure io_futex_wait() cleans up properly on failure
Date: Fri, 22 Aug 2025 07:14:46 -0600
Message-ID: <20250822131557.891602-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822131557.891602-1-axboe@kernel.dk>
References: <20250822131557.891602-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The io_futex_data is allocated upfront and assigned to the io_kiocb
async_data field, but the request isn't marked with REQ_F_ASYNC_DATA
at that point. Those two should always go together, as the flag tells
io_uring whether the field is valid or not.

Additionally, on failure cleanup, the futex handler frees the data but
does not clear ->async_data. Clear the data and the flag in the error
path as well.

Thanks to Trend Micro Zero Day Initiative and particularly ReDress for
reporting this.

Cc: stable@vger.kernel.org
Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/futex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 692462d50c8c..9113a44984f3 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -288,6 +288,7 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 		goto done_unlock;
 	}
 
+	req->flags |= REQ_F_ASYNC_DATA;
 	req->async_data = ifd;
 	ifd->q = futex_q_init;
 	ifd->q.bitset = iof->futex_mask;
@@ -309,6 +310,8 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
+	req->async_data = NULL;
+	req->flags &= ~REQ_F_ASYNC_DATA;
 	kfree(ifd);
 	return IOU_COMPLETE;
 }
-- 
2.50.1


