Return-Path: <stable+bounces-114700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D3A2F53F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DA73A3F89
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26039255E4F;
	Mon, 10 Feb 2025 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2u11GPC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA42500D4
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208422; cv=none; b=Wnc7snpQ3B1YuXjNOL4vtsxD7Ljxncms8AhcSU8cBU7Zm5dx01STN/lSbLoUuNx0lx+api1E9DA74/G/GWNQtP1gJD9fBRe11unuf9QV2bVoCeAZu6hDQTtOGNigyM5tIefXBtZ/rVlyQ/NiuK9+Tjb2cChvHN6MQh4noBhYQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208422; c=relaxed/simple;
	bh=KZfyTR80BiQDuhuWH26jA6G/Je8ozvq9ZzroGVKTwrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghT2BeEbqSEuIT4c7YS7z5JQ1EScCQbtRjo2bFFxQzF4njMH4+LX5iRZv3KCFRjWvvph0zCOd133jmxC+0LVOWIrjIgcYpGuBkPosnN/d3yNwrXgiPMJHMuYGFr6a1EKxRpEYgw4PWL1MgUPQEspRKHYixBd2rNxVIpJnfLaoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2u11GPC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de7531434fso2728308a12.0
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208419; x=1739813219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+LQrnD6kkpMjWCSzjDSgH4Y5m5OpemQC2BnOXGpnw=;
        b=m2u11GPCar8jHdIMkoflp4rM1MwB7QEnhrzUjH39OJ0rDpaTr8djWYTR3IL6My9GJd
         BrqbobSLH69B10ooNopH96+TpPka13LF1Oyo9+MXAjb7soxoixBJRmJI09AfpKpxTH++
         1Ih1TzfU9D1VN9EBrCU7u4Tp4p/eDcEY7wbnuF4hh3zjOXXrxsp0uP75B6/K2c3UqOAd
         kdKZ+K15HnUftGX1EDnJ8K7DUaK2Gasar076h37yQoJVDjK2o6xJ6N5kU1Y6HEYllg1d
         MMjU1H2mFvNJHsTof5w8tmV6WD5Yk8J5NG7d3hhRO2waMOVlBUyg+QyWRSBUciPyf9Lg
         W5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208419; x=1739813219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7+LQrnD6kkpMjWCSzjDSgH4Y5m5OpemQC2BnOXGpnw=;
        b=Ym7Cz2pddARV8pIWX8kkjd3eTVOuUh+GC60iXk1usdcj1muMs/vU2TuNiAVfRmM+MD
         j0ABECHpm3vnxNkWkh+KiejvRVNSvDX2C1lpvRSfEYANbpFpwrTy43ZyvgbhPUrMcQTx
         epfAKVy3k37D+eNupr8k+EIX/53t9+4VJMoYEhU3fO6N97HMiuxW/+vLNIx5gbWeelI3
         BBFbQpVIzl5TX4rGiFxECG3gzPVCk99vwrG9U1XptHGOI59OWuV9TPXV/dpdKVbyrxKw
         IO6+OlSAtNpDaHCl2RexU88OhCywnwRpvfoBKgtIqLZsKjPNbUnTnH0SobEBcO0G4RfX
         byyA==
X-Gm-Message-State: AOJu0YwmV71H8hYhhyRfsHHfkvA8TYpzSlhnUUq6OpYMgtr5B2PlTXkr
	vGG5zk9dn4V4RuqiBaxq3bZMpKqOsKgPa3fzMqswa/nPDN2UU9f1bcYsCA==
X-Gm-Gg: ASbGncsIFKQNVMWOD11LbMeEmhZpAEXgcqoZG7/Tzd5zW9xhmrEU029r0IFbLZARDWb
	oC9Luz0CaoBy9ID7pOXrECOKGwHbQtaS9iBL6+v9Be9cUczPxMtsIEwcqTfiEktUjh3ArRrJw2r
	ofcr0X9yfaoJcg6xvNLKFmBI5xISp4acmRuRTO2cJ2fzchKXsmyKlQV8ZESUtp5fLjGOhbIEdCU
	PNLS7ZtCjzcsMSVPGkC7dZkNS7liDPC/ZQI9bXab/FWN98QjNodEsNRIBUBAePRBPDhmGB89ZE=
X-Google-Smtp-Source: AGHT+IE2Gam3G95+STVb9bU7dcuhnSM2fcoaFImxTZf6EJ+jvlU2Rbm7gv167GOqHko+cBhCeuhhdQ==
X-Received: by 2002:a05:6402:210e:b0:5dc:ebf3:b967 with SMTP id 4fb4d7f45d1cf-5de451074f3mr15745467a12.23.1739208418870;
        Mon, 10 Feb 2025 09:26:58 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:cac5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4ba95a32sm6931723a12.40.2025.02.10.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:26:57 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.1 3/3] io_uring/rw: commit provided buffer state on async
Date: Mon, 10 Feb 2025 17:27:56 +0000
Message-ID: <71404cdcc823638709aa44ee2137cd444fc708ad.1739208415.git.asml.silence@gmail.com>
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

When we get -EIOCBQUEUED, we need to ensure that the buffer is consumed
from the provided buffer ring, which can be done with io_kbuf_recycle()
+ REQ_F_PARTIAL_IO.

Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
Fixes: c7fb19428d67d ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 692663bd864f..b75f62dccce6 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -772,6 +772,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 			goto done;
 		ret = 0;
 	} else if (ret == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
 		if (iovec)
 			kfree(iovec);
 		return IOU_ISSUE_SKIP_COMPLETE;
@@ -795,6 +797,9 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 		goto done;
 	}
 
+	req->flags |= REQ_F_PARTIAL_IO;
+	io_kbuf_recycle(req, issue_flags);
+
 	io = req->async_data;
 	s = &io->s;
 	/*
@@ -935,6 +940,11 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		ret2 = -EINVAL;
 
+	if (ret2 == -EIOCBQUEUED) {
+		req->flags |= REQ_F_PARTIAL_IO;
+		io_kbuf_recycle(req, issue_flags);
+	}
+
 	if (req->flags & REQ_F_REISSUE) {
 		req->flags &= ~REQ_F_REISSUE;
 		ret2 = -EAGAIN;
-- 
2.48.1


