Return-Path: <stable+bounces-108614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD3A10BD4
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F40D1681D9
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7491ACE12;
	Tue, 14 Jan 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6dO1bs7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD731CC177
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870865; cv=none; b=AxfDddU8/o/EC/7cH02rcGoE1/81Q+udyGzdcsDV2u+LjS4+0v9lrmrfsFllOcfjaoNpCm6PPj5X3H53M3nSbFenOdLbo4las7F2UUP9n4n3siZsKDGPxbqZPVzABi0LeJinWYttKLcryNf13+f2xJlBoXw+uKerrVDWWCcUGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870865; c=relaxed/simple;
	bh=DjA+1pRYEwCTzZYR4gdpRvobmLbRIgWTLuTl2zytbuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOVo0IkI7xXsxIA3LoaF5RYR1AGjN0Od9+rhNqz2OUzylHuXZ4ub4KivG9c7rijAWlvuHV7LAptGn4m+KW4ESJwxmw4tO35lGJL4zIxVzKiwU3Ux1tdxwJB6WsX6JnJN1VQucpWO8PsmCi3oG2SwXp6ss/870EscQKS7uVd3rCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6dO1bs7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so10952686a12.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736870861; x=1737475661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh3NaFzjRJ2XtEvEnIMGyzyfuLh5N2xTIHOpyoyF/88=;
        b=U6dO1bs7Sxl72khfvgDjJHiOijAMmnep0UNUmTleyxEMDEMUm3b2EFdQXL82aIl0Ti
         9AW+beKmOGn7pPd3F+7T46PpMkVKK8Os3kB7OVArGrWSZV7/lCOnJFt/OWmQct7ClQkn
         YIvx1qd/G3YBDIkooXiftGyOtO473hephAJOLksgA99H0E5F5AAnaeUsA+2GJ89g8FTX
         SoMvbhDjAA0vK99Zz0M/AZbfB0glD4cMPRhLMbTWdznvvDf1TnM5Is4B9fdTaDJSHb+n
         8wT0MBrsmrjEPSjr0xFGOJXbtldivvY+AKy8M1bsuwqcy4YXrZVRAHPGhqUb5d4yPkHP
         PcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870861; x=1737475661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh3NaFzjRJ2XtEvEnIMGyzyfuLh5N2xTIHOpyoyF/88=;
        b=VjBrK/Gpx67f88M4ZdDT5CIIrLPa++NXGJ9isovcb/ZXkLLilNhAjZkkof57vFElm8
         +QUfBXAhf8+I+PwvPIVUg594RIhnOKzXEHe7xYJeBWd3/crEI3ND3HlXy/E8Wsj/o+D7
         a90a2W6UMOYS85e4dsXhEv4wQ+0wBXnTuZhWF/5AWA976PCTWgc1u/ynujkHeLwWdSZu
         jPNfmr2dAoqZXm0KF5I4Lwd6AYjXjxadmXPxd4b1jDTF4mZ/g1D55V1fPpoe5+NNGmvv
         SNKmAa53g4pQDPLTJZT9/1Ewd8jNfdU7IJKlYiNWDSKGGa9tkB+dnWY13WL8BgpeGSUA
         tgoA==
X-Gm-Message-State: AOJu0YzKBOhr1CqdtwvNWQN0rr7pedlKtZ9Qujphx5BmPQzc2Zioc20B
	Mp/+J4hhuokfIVEU4M3AqKbpUSk1cLPZKVPpDZtgNUFWBsxKMq9QFPRMsA==
X-Gm-Gg: ASbGnctucQYMQA5eg14nV7z/+i+5NXxQ1sDeno80pOWTQ5OtgUJr5UwKSN2rFrlFCRP
	CYjKtrieTMAhMBy98cB24EwbWuc0/luAVFiezVrSAdTwrx46wDY1Lc2+XQ+V9J0sS17iq9HKDZh
	bXZzrXx96QEHAr22E88L1q4bdbBGrdbIehaqvaVXBp19VEoLBwFu/GlVKQRqe0HlcXqoShGCGlp
	gEj5+vRLxakGWWLOKuMUj6/B2FO4qtkPusfZTd+tKBWkI8mhp2x15fgaPV+FLCd0fuCsw==
X-Google-Smtp-Source: AGHT+IES1UhJob9AV0Y3LD9sZar5Wkaew9X4idTdIiF/Klx5sHJb1X2OMwhjIQH77ZVMu3RC+O4Jdw==
X-Received: by 2002:a05:6402:4023:b0:5d0:e2c8:dc8d with SMTP id 4fb4d7f45d1cf-5d972e1b962mr23227286a12.20.1736870861202;
        Tue, 14 Jan 2025 08:07:41 -0800 (PST)
Received: from 127.0.0.1localhost ([148.252.147.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c523sm6417210a12.8.2025.01.14.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:07:40 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH stable-6.12] io_uring: don't touch sqd->thread off tw add
Date: Tue, 14 Jan 2025 16:08:23 +0000
Message-ID: <2c7b8e078a984bfaa67bf2156c100a833e080b55.1736870725.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ upstream commit bd2703b42decebdcddf76e277ba76b4c4a142d73 ]

With IORING_SETUP_SQPOLL all requests are created by the SQPOLL task,
which means that req->task should always match sqd->thread. Since
accesses to sqd->thread should be separately protected, use req->task
in io_req_normal_work_add() instead.

Note, in the eyes of io_req_normal_work_add(), the SQPOLL task struct
is always pinned and alive, and sqd->thread can either be the task or
NULL. It's only problematic if the compiler decides to reload the value
after the null check, which is not so likely.

Cc: stable@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Reported-by: lizetao <lizetao1@huawei.com>
Fixes: 78f9b61bd8e54 ("io_uring: wake SQPOLL task when task_work is added to an empty queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/1cbbe72cf32c45a8fee96026463024cd8564a7d7.1736541357.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9849da128364..21f1bcba2f52 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1244,10 +1244,7 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 
 	/* SQPOLL doesn't need the task_work added, it'll run it itself */
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
-		struct io_sq_data *sqd = ctx->sq_data;
-
-		if (sqd->thread)
-			__set_notify_signal(sqd->thread);
+		__set_notify_signal(req->task);
 		return;
 	}
 
-- 
2.47.1


