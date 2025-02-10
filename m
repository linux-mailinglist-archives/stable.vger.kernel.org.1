Return-Path: <stable+bounces-114677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B20A2F15F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86365163CB2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13123A572;
	Mon, 10 Feb 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIAzimpE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AF2397A8
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200918; cv=none; b=nHBX++xI/J8LmELhq2m4a8cQe2JdaAzq2N1lJwNDpuJqlYKs40OaqgW7aiVKYGxsXUXvfw0xMaeFNZwvEkOPIjbjPfDcfU9/4exhPU/hi/PaGmVBo0hzM36lrWk5jC+SB7HgUnggyzSugRkLF2atOLc1HYrDcBDlpOUmX5P838o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200918; c=relaxed/simple;
	bh=K3ldK+ULlgiXVrrv/iqhi7KdBlO6FX0OVS6xHBhuCgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYRBca4RpygTZlOhRskMf64L5vHPwukLB9S2mMUZWkH8/6U041H0TK+ZQQBLrTTcMbnK6dvPpqBObcpPycyc32Tcs0llKGdxhyd1bhHHjMmBWEdQCVZAmK6wvS3kgg9epZVukB7wuj3jlVaEaArpwWFN1TK0frYV+tmKqz9fdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIAzimpE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso787562666b.1
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200915; x=1739805715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RaXG561zbDpv9A9ytfOBmeVRZPZE90zIqGUHGt48Ls=;
        b=PIAzimpEdlsjXzd/bnIIw5cBCX8FdyY3VK7aWkMzhR0AnOtlsc7OnOTfaq1ZEcM5PI
         NbrH1qfW4/9bfWcKV/bt1tjn7LmSyD3fMfsOkGneTULdVgucIqeQY9X+wMhWyWIWZO2O
         +JnO7FsBO3qN/+QJRaUCxOYMvZwCrShNg/ii0js7ljQ7Lmqr4VbmOeviOP1Qe8bKnOYN
         V0Iku4oo07u8k+Z5O8CRkJNOyZRy1dyy00qMyqaz6iuo6J5aHiRV1LsN6IfpoapYVhHK
         PAuwz1O1UrpPcbVva7MwfImtplWiRuE+ZdStV3pRk4wANz+3H3OmyMlqmDiQ2iVPL/Q4
         hkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200915; x=1739805715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RaXG561zbDpv9A9ytfOBmeVRZPZE90zIqGUHGt48Ls=;
        b=C86adgpL5HDEMA8eyR480JBo9fkv6+N9fPf6o3lUPTMjFsamn1wTl0s6Wk9iwcMMsZ
         IaUNZpCNb3Ztwo5xBG0CHwzTufouD299ss0WO+mLoWmHVDyLOymWyWwYUj/U6orlfM/7
         pnI1KuvB8/d0oMx5gfGNG1CHOBU4diwZLiuGd7Vby6CUssEISHq0MaVyZtMJ6hvUbAaU
         DhPhzvFuf2db387RfVGA/gSC5KXn0vSUJeS5J23OUQkvAru2tmrwGFOn/nRDKnYJeLIx
         xIoZzvH3W5x2MjK1iGQ/zeAK/oHSV6Nrqcw3N4V4DYkS0GPPdF/rJYwO5Hs6YZ1TBFR3
         XApQ==
X-Gm-Message-State: AOJu0YxFzwlZ6xm5EFc4Kngt9sVWapuaQnhGCgSMI5bajFuP2Nb740c6
	IyTREYnQW0cXV5lYv2KJbXiZKpZvBkfzvu/dfwxkUJKaMvQwjGlRb0Hx6A==
X-Gm-Gg: ASbGncsCzgxbYbrdhipgkp0BRQ0QUcMxYxYPBrP6hnPYmswNOr8+/+ey08znxq1fpyS
	nHhjzBghOEBiTyzOUMX8UWZEfz8GtPXnrCuW4hrqO9ig+xwW04O52fTTXknRHxgpJiIcYCP//VN
	GmeYUnEkZmtlFvPt9aqv+IgFqXOD9RcoJmPaJC8kb7naGDbO9ssBLFNYnb4suNpnukx0Ori211n
	3MiHXnUy0R2OWJkcjDA2skz3boK+OsrUhliq/zl9YxdeF6U72yVQ+aVaOFq0RLS9MbIedJJLfY=
X-Google-Smtp-Source: AGHT+IETbWwobJArN9bnSGBQKEujcD5rUgTrX+YKl30HVrqulPkXdk+TULEnwWFszhYjXBJb2Psl1A==
X-Received: by 2002:a17:907:c1b:b0:ab6:36fd:942a with SMTP id a640c23a62f3a-ab789c6cedbmr1533198066b.50.1739200914491;
        Mon, 10 Feb 2025 07:21:54 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:e0cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d2c1797asm69587166b.22.2025.02.10.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:21:53 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.6 2/3] io_uring: fix io_req_prep_async with provided buffers
Date: Mon, 10 Feb 2025 15:21:37 +0000
Message-ID: <43e7344807e915edf9e7834275d1ff6e96bd376f.1738772087.git.asml.silence@gmail.com>
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
index c7198fbcf734..b61637dad442 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1779,6 +1779,7 @@ int io_req_prep_async(struct io_kiocb *req)
 {
 	const struct io_cold_def *cdef = &io_cold_defs[req->opcode];
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
+	int ret;
 
 	/* assign early for deferred execution for non-fixed file */
 	if (def->needs_file && !(req->flags & REQ_F_FIXED_FILE) && !req->file)
@@ -1791,7 +1792,9 @@ int io_req_prep_async(struct io_kiocb *req)
 		if (io_alloc_async_data(req))
 			return -EAGAIN;
 	}
-	return cdef->prep_async(req);
+	ret = cdef->prep_async(req);
+	io_kbuf_recycle(req, 0);
+	return ret;
 }
 
 static u32 io_get_sequence(struct io_kiocb *req)
-- 
2.47.1


