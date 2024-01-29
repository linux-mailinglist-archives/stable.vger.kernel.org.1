Return-Path: <stable+bounces-17352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85F84145B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 21:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9921C2410A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57A241E9;
	Mon, 29 Jan 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2ObtooWg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44288A21
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560237; cv=none; b=GImk44SUfJ2uioj70XNe1yOon99sJNO2vsLwb5TS/5nTqzgFWXyLbpP03WQr9Vc2E41L3utCwC/UxlQHdHBTa8llOEdiJ2Ro9xqQqlxpTXhF/R1UXg36p7qhsk4bJP4fE47dmMbXjYPpnbOcnWgiDzGhgWtDyU1fdlVDP0wLlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560237; c=relaxed/simple;
	bh=F0L6R3HMTsvU5QrGV1jKpmdDPnL8PDZ9XptAIhf9OaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqx2GtQDbZotJIClDeGGG0Air9knBprLXoX8ejmMLDXH0wyl8KR6kT83zlATmM84IE+kXgDREUZUUmq8vcxEXQJK/omUUsLxU1VyFvGJBVKdMZriUEuzJpdQ2ySt7TtMZE7PgrJhlZ78gfgYPBOL5Pu+7KnTfgghCerL9UyMLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2ObtooWg; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bffe53850eso10266239f.1
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706560234; x=1707165034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDZQtmapdAhbbStZz6bk8XOpRhvQFEopwTej5qLfkwg=;
        b=2ObtooWgTYxq3GyuCs0QVPrKGTuq2T/IPJUIFQfdFb3+n14JJ6iMoPXw8k4Sfg97nk
         IMoGdoXDwSN7m2nL0/4dKzYfRUGHvRksmXG/3vCtuGUo2RYOiqId8e8ItFBtQBSETUQ7
         iLelrvfBja4rBbYZbWH5dB2cK0SyL8SS6Sq+8ZWB3RRec3EUJMXrftuPQIAlvpePi2T1
         Mtb4Wc1rJ114f4j4ciLdto4QYaJbsuZJUIbrGVLS4kYP/mtsjXA2Y0750hJWKMiCY53l
         /HQiGsrRy15VbnLc4WmyyOebh55nifbeaAKych9mipHGm7l02AEMzAdFGWDxVsXo9a2Y
         9htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560234; x=1707165034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDZQtmapdAhbbStZz6bk8XOpRhvQFEopwTej5qLfkwg=;
        b=etELj0FEWWijpIDklu/Hrv/sWvrE/siPDOQ2crEksgtaC+y2STUAjpqQpEu5AgbTUj
         9pjUn6ogy7eL4D4LNOupZ44BrAv24QFmEHVf/Br2SAs7jsCc4gBlXwtPnuPj0nnyU3Ae
         K4466UE8M+odmi9VY2C7fs31YfD8UVcUgIQApTKY/j2CjTIsqnXlb0JyvUdXHnO4pszd
         dhWyYigKX2q0/sWPK/WUWc+MtNcUu0z0Xf2aAmJJygeY281oYsIwfjbnhp1qxFn0kPmN
         uhR3ib7VeMX7D1UXzWL0/c82tylbd+CKbTAjqqhJ3GYS1/+ZhP8jrdpgwWagGDQcuUMC
         6JRg==
X-Gm-Message-State: AOJu0YzJTyotlPIiXEzHEpj4xOQgTPDFh058GfzAa53gqrU2ovmFTe1y
	+HmZa2F2FsW5kGQ11luuGYRJ5uI5EKOYk2ZnpJcYAa1EtehM1HnydzhsmOm9CIk=
X-Google-Smtp-Source: AGHT+IEzuwIW8l3BA3QcrZVmR/kStX9HAjIfJYx53Es5wNkmu14HVNKS5mUQJ4BxrwCQX+uFFhnTqQ==
X-Received: by 2002:a6b:f814:0:b0:7bf:4758:2a12 with SMTP id o20-20020a6bf814000000b007bf47582a12mr7198091ioh.0.1706560233931;
        Mon, 29 Jan 2024 12:30:33 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i8-20020a05663815c800b0046e6a6482d2sm1952510jat.97.2024.01.29.12.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:30:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] io_uring/net: limit inline multishot retries
Date: Mon, 29 Jan 2024 13:23:47 -0700
Message-ID: <20240129203025.3214152-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129203025.3214152-1-axboe@kernel.dk>
References: <20240129203025.3214152-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we have multiple clients and some/all are flooding the receives to
such an extent that we can retry a LOT handling multishot receives, then
we can be starving some clients and hence serving traffic in an
imbalanced fashion.

Limit multishot retry attempts to some arbitrary value, whose only
purpose serves to ensure that we don't keep serving a single connection
for way too long. We default to 32 retries, which should be more than
enough to provide fairness, yet not so small that we'll spend too much
time requeuing rather than handling traffic.

Cc: stable@vger.kernel.org
Depends-on: 704ea888d646 ("io_uring/poll: add requeue return code from poll multishot handling")
Depends-on: 1e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
Depends-on: e84b01a880f6 ("io_uring/poll: move poll execution helpers higher up")
Fixes: b3fdea6ecb55 ("io_uring: multishot recv")
Fixes: 9bb66906f23e ("io_uring: support multishot in recvmsg")
Link: https://github.com/axboe/liburing/issues/1043
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 740c6bfa5b59..a12ff69e6843 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -60,6 +60,7 @@ struct io_sr_msg {
 	unsigned			len;
 	unsigned			done_io;
 	unsigned			msg_flags;
+	unsigned			nr_multishot_loops;
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				addr_len;
@@ -70,6 +71,13 @@ struct io_sr_msg {
 	struct io_kiocb 		*notif;
 };
 
+/*
+ * Number of times we'll try and do receives if there's more data. If we
+ * exceed this limit, then add us to the back of the queue and retry from
+ * there. This helps fairness between flooding clients.
+ */
+#define MULTISHOT_MAX_RETRY	32
+
 static inline bool io_check_multishot(struct io_kiocb *req,
 				      unsigned int issue_flags)
 {
@@ -611,6 +619,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		sr->msg_flags |= MSG_CMSG_COMPAT;
 #endif
 	sr->done_io = 0;
+	sr->nr_multishot_loops = 0;
 	return 0;
 }
 
@@ -654,12 +663,20 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 	 */
 	if (io_fill_cqe_req_aux(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
 				*ret, cflags | IORING_CQE_F_MORE)) {
+		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+		int mshot_retry_ret = IOU_ISSUE_SKIP_COMPLETE;
+
 		io_recv_prep_retry(req);
 		/* Known not-empty or unknown state, retry */
-		if (cflags & IORING_CQE_F_SOCK_NONEMPTY || msg->msg_inq == -1)
-			return false;
+		if (cflags & IORING_CQE_F_SOCK_NONEMPTY || msg->msg_inq == -1) {
+			if (sr->nr_multishot_loops++ < MULTISHOT_MAX_RETRY)
+				return false;
+			/* mshot retries exceeded, force a requeue */
+			sr->nr_multishot_loops = 0;
+			mshot_retry_ret = IOU_REQUEUE;
+		}
 		if (issue_flags & IO_URING_F_MULTISHOT)
-			*ret = IOU_ISSUE_SKIP_COMPLETE;
+			*ret = mshot_retry_ret;
 		else
 			*ret = -EAGAIN;
 		return true;
-- 
2.43.0


