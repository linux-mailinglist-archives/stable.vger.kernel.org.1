Return-Path: <stable+bounces-114699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D8A2F53A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69F1168B4F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75024BD0C;
	Mon, 10 Feb 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAG3eu/f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6624F5A0
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208421; cv=none; b=XWoXgbkE4EbliXqG8k/t+pSfE6SXO5EAhFbfBpRkPMI/DF9k07A+aJNss7ocU2+8oDBeeBv5SW2f4DtYiTz0QxFU7sFhch+PYKoFFJ7DfbYaAUqBeU/IzF2JeNOQ/uPujE/ng1ZSMU1cGXtKdy5vC4kRznOjUhH2Bc4ZTaZWd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208421; c=relaxed/simple;
	bh=ivF54Z9NlSMSG06cyJXKyEJ+NtNMkYwdlP5wqyUWQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyoCBraftzQaiA5tzDhIkwoXhOqd5S+C30lx7ZFF8rfC1CaT2cEdLNR4EcsovUP4KhXultAo3fp6Gh7HyhweLCeuRYPDR8IsG0fcuLHdKLWuQ/5T58zUgBG7ZnhhK81Li7dJGfIjWmLyyfcG/CtBDWTysLg1EZ8FuPsj8jxwjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAG3eu/f; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de84c2f62aso2008749a12.2
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208417; x=1739813217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfzLs4ey6SvXdxcR2wnL8l08PR4+xjbpRkwS1EJJj70=;
        b=WAG3eu/fsMs3fwPq0n2diaErkwEhvqWopwWg02fG+yvR2pXYNy3rBp2bM01aqIEH7/
         TR/z11U0KWkzmIY6OFUKwLRAV/FPgJq2SkICRC3HgrUJWP+dsbSRHGRUZ8k3rmYMLnTj
         WuQt5lvqEDZMvlKIfmbXH/6nF0FNwzo1yV/P4DNGHK/1ROEbPiDvqK8iqltzX/XjfDrg
         9o2540dPz/ChyE4FAuuj5/9/afJk4BxsMJt4GYgZ7/rzty6Kx9aUYhiYn5E7492dJ/ya
         3h4MLIqyLtRjc5BJz+isAogz6w0FwsopTLLy2zy/hGXH0lPAXn9wZmutT1l6NdfSGB2A
         Xcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208417; x=1739813217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfzLs4ey6SvXdxcR2wnL8l08PR4+xjbpRkwS1EJJj70=;
        b=s3O4hch6orqm8k1kW1Fy7v9aJHDp88/yrVI5VdDRlWecbNAIClKsXUtj1WXO9/FhdV
         W2oDjgx0+hVmtYgvhXW5s32BpdcDps3RceleBaRyCeLXKEiQDK2b7iYDy3pAihRfo3iR
         wNDRpPJDHVHYQXsDCVYU63WmfPTCyld3nUB/uQgCSn744T7t9bwtIlgYI1CC9TtpOdsN
         thnvkCRY6NAvWJxCmEwtd2Jl1KnlDsO2To8AqSKoapYMurR2Z8KUMt/SBTeYfMvPN0fT
         j54tc+4EpnfWHNl/he6f97actA8xFOqkNgXQS9Op2+WeLwS4ayMg49UUoiY7at9xSX7U
         fZWg==
X-Gm-Message-State: AOJu0YwNUhUMCljJMypQLv1g+IrQj8HII5Dm/9vW0a+QWCUZMdFXBysg
	QngmSnOcszY7V7febHcdjWtF6u3WWiK6476i6aHFy4YLUmvARYMtMy8Aiw==
X-Gm-Gg: ASbGncvCTXgy+kQnx2CUwtKcQsYEQIs1eZu+iUnOzIh7e4bjy+Pd8GpxqS1L2WB0002
	RO1HtD/2QnyYtRh5z7b9HUbJ5r2JzlVUIb80zbEldXgnKBvfuoTe/bckd7xv04MqP0dcdQKi81f
	pVmSqvZlyEWAcaocAVwAyS1qAQBNPabjGZCVNgM0OYMt3z8wIQoPL/VtKYgWgK5iTjKwL1SKm1J
	q+9rolYzv/pYZxOiWQsMDytOuM2ezabMcypf2Ya7N4+DvCiAXwi98iCXFf6P672pCsLDUDtfvk=
X-Google-Smtp-Source: AGHT+IHpa2ehfokGtwdjh8lYgX0YGJEZsNYDbq1XiJxjW0rd3AL/1sopPQEbVbikNh3r1AZp4+IFGg==
X-Received: by 2002:a05:6402:1e91:b0:5d0:81af:4a43 with SMTP id 4fb4d7f45d1cf-5de44e5f276mr17650116a12.0.1739208416205;
        Mon, 10 Feb 2025 09:26:56 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:cac5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4ba95a32sm6931723a12.40.2025.02.10.09.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:26:55 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.1 1/3] io_uring: fix multishots with selected buffers
Date: Mon, 10 Feb 2025 17:27:54 +0000
Message-ID: <2c95a69708e1e7f94acedc6286160160b7650bbb.1739208415.git.asml.silence@gmail.com>
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
index a4084acaff91..ab27a627fd4c 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -305,6 +305,8 @@ static int io_poll_check_events(struct io_kiocb *req, bool *locked)
 			}
 		} else {
 			int ret = io_poll_issue(req, locked);
+			io_kbuf_recycle(req, 0);
+
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			if (ret < 0)
-- 
2.48.1


