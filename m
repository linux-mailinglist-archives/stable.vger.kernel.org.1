Return-Path: <stable+bounces-114675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EAFA2F15D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F67166D14
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F22397B0;
	Mon, 10 Feb 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymt5kHJ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8023643C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200917; cv=none; b=dlrY3Qau+HdDSK3B7O3o/EFiVoCztTG9fDhcX2x55eL1wsu7DVV5us/L2+SsTeEjPQ/cIz7Zq4TwOAKtMpIeCMTOlJw45L5udnXCDA78lZhhf90g3u6QY2GlF9e90BUG6YfVQCAckTS8MwtHPZdxS9i9c5scRBGxPMa/S1Hufzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200917; c=relaxed/simple;
	bh=qhBRAaTr7DGqFW3TcsBH2ngvp1AYdiGCdX06cAJdVCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vseu1xlCeOUukQiIE4Q5WcfcG6qGyEURCGBztBNsfKoEYXSsYrZOWBJgxfd1E0r/VMCyGo7CUbGMcZkIU8CiWmVG1U6fXpapYkir7AtcYxwCnAnNB+JUDETJM+Ffr9QHO3GO9q+H61rA7X1drlyuGDq4wTmy8MaJevaeo+S6oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymt5kHJ7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so7238435a12.0
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 07:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200913; x=1739805713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1UPBHqUeStTdtfccSVuTuKJaj8dXv34BM3XspvqPL4=;
        b=Ymt5kHJ7/fFlEOu9jnEXYvxrgYQEiKanpNMsakUyHvWAVeLZzwbsNFX6TExjXrtwTG
         aZ4/SUjb6GObiTMI2itlV2SwmJaVt2YN0UTINijMYmB30AZXNTPJ3PTb+dMX6NVth4op
         66Do9Rmh/WOHRhqZ/aUBMRBP2+D75NQI1UD+P0fRU1p6OTnSkmXWn2tQnPYQ5nz7OyXh
         YYNvkRNQH6hXoB2a797fUcaX3veZHrJqj23F6sBFxByZNxAA+tk5jF5+che2/PGThn30
         WYTTwRz4xmPkfiWzeNDt2SREP+yNMm8whbYATnr7sAb6rtl+yaHRwcnfFh42JG+6Yrkw
         ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200913; x=1739805713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1UPBHqUeStTdtfccSVuTuKJaj8dXv34BM3XspvqPL4=;
        b=sKijoAoQ5a16htgq43dIlExUVGApJ9YHQiwtBwFLmKJ+cE3k9owinivZlXgZpVvgR5
         34O68AplvGagum4lA4lWVVW+DAxaQ+4LDqA2h2mSVwBiW0z8c33C/rJkGHaq8FtrUEfu
         lke84DdmkOxsgBO5XyiepvCi3kE1IyDnzdXdiJ+U69AlJk9QlG0A7vlvdlVF0N7paFxH
         HCdxnv3PFNS0T6gAZV7DOQCZc5Zjy4VFrWqFmqnZWKPDM7BvadMrWwtfyVQqIHrMxsuW
         +fwsLmNJqJv00fNHGtSRj9/8IyNvsREKIRl+violfWxg6Koq+61a3H3qLDeXtZVBY5El
         Mg6w==
X-Gm-Message-State: AOJu0Yyom1RE9fkV2noP2WGQZtSGTui8OQQAefzQcdJTXdLI5Ybwvuqy
	pZXUfyXux6BTkproS38/Yw56Wj/6ZHJDOVO1lborTCiXHzZcIB0yxcH9mQ==
X-Gm-Gg: ASbGncvjJ9ImU4xlNC6AP4BwVfJI42AZIiZjIZIyWOL4mW1cSzizKF3SUbRALuaR7uC
	8UABCrsuHQj4lBhae6xnZhVPtG90DerImXuCv950nxObv51sk67w15GpmqUTTRF1/7t68ID0HkY
	OH0OrJPxG/RYWfgG0h8bj6dDWgSBTNRVf2muf80UU0EEKX5R0w3jpoJfd+bXSm17lbOMKBLTeKw
	0B9M8bNyFo/2xqfFQS6JkgCZO4DtnSd7zxJ+FjD9CHf7HtmXzM/y3uLFozbx6XCSWTWkj0HyO4=
X-Google-Smtp-Source: AGHT+IHmnR60kKzERDfSiPcb+fAbdSxYh2ewv7q8jh84y3Wcy7LQNuRLj7iXgYss6asDliUGidKvsw==
X-Received: by 2002:a05:6402:1ecf:b0:5dc:caab:9447 with SMTP id 4fb4d7f45d1cf-5de450198eemr36599116a12.18.1739200913357;
        Mon, 10 Feb 2025 07:21:53 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:e0cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d2c1797asm69587166b.22.2025.02.10.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:21:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.6 1/3] io_uring: fix multishots with selected buffers
Date: Mon, 10 Feb 2025 15:21:36 +0000
Message-ID: <7f1d8d30db7f5b304893917da8f9d22a38edb965.1738772087.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738772087.git.asml.silence@gmail.com>
References: <cover.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]

We do io_kbuf_recycle() when arming a poll but every iteration of a
multishot can grab more buffers, which is why we need to flush the kbuf
ring state before continuing with waiting.

Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/1bfc9990fe435f1fc6152ca9efeba5eb3e68339c.1738025570.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 5cf4fffe8b6c..2824a3560245 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -350,8 +350,10 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 
 	ret = io_poll_check_events(req, ts);
 	if (ret == IOU_POLL_NO_ACTION) {
+		io_kbuf_recycle(req, 0);
 		return;
 	} else if (ret == IOU_POLL_REQUEUE) {
+		io_kbuf_recycle(req, 0);
 		__io_poll_execute(req, 0);
 		return;
 	}
-- 
2.47.1


