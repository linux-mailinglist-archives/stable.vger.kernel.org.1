Return-Path: <stable+bounces-23755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C1868119
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5883EB2AF58
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E912FB39;
	Mon, 26 Feb 2024 19:29:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13212FF61
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975798; cv=none; b=Qu+jB7qqSN6yXMS3MdDzjMRgiam3D/nSZdSvKavIdm9GqPSAutLopxzDOCnhnF/eqEMgeN8lTereEpe4+ATbyuoz9VTC+mymYsI2dS6Whgx2rkmh0sBYuKlzHWVqJrH7KCwtscnoXqXKSlFG995xm+2roYTfKoHD99jnhCDdQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975798; c=relaxed/simple;
	bh=1TptQ2/QuTbXYR4FLgrU1xRQAqKivUhaJW1B94TmSm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffACXUAAYSTUr/YbQj00Vvt5WTF0JywPMbRVYHG8sOkHQPLB6qDDeZACzDRZ8o/8JTVHFxhTfqcayk48n0QAsXDalI83yDrys9C+ehzmKAinP1AzMBhcCT7xQTA12TAz0PpAV2Z762XjU7FD2zBIDLHqJFc/OzIZ7qAwJ4fDjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29acdf99d5aso639487a91.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975796; x=1709580596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlzKFXJoEIb6QxSD0s+PZnE3DQxTQrXdtu1hyvZlGlI=;
        b=MlLL3aP3CcxlV3jsPvYTOdAI8ySwHwstq6leXziI2A9/kcCIP47TEEFpaIA/vDWkh/
         8SCXJhwbwlJFFXngGlfIhA0R89HRM9Ihj8RBM1Cpk+3lh3btV/eWZ9w5MAloouQ6WHgt
         pRLUQrlz7LOiaT+76SVbrtHQV63jqSe9xLWT/9DesMmYROJPRpIksVKCrDdYINQr+STt
         W5F0c/6M6/trK7D4ubLaOgyoLqPdJGnKyDEZlTcQUYCeqh3VybemFr6d+ShDsxlq4syk
         YLoqZJzB7zTe02czvP9k2SWGdRfY6ybx9L2hVgi2QH7mH4yrywHrY3GcMThCdtjlZD/v
         1ZkA==
X-Gm-Message-State: AOJu0YwxbqzBSjgte5yDhbjZ+N2vEktPZO4UIrufcB2RrZCIwOfMOkdP
	IBPzvQb0balfGAdv/witiB28Z3fvAgE7XMm1MpN8MVSQC29lrNPTLGhz2RZ0
X-Google-Smtp-Source: AGHT+IFcCTDW+Q1qjvaP+4RLzdzbptkj2CZbk1b2Og/4QlfrUXVVL8xRKsNRKvRYe8TnDsK5thtTIQ==
X-Received: by 2002:a17:90a:f682:b0:29a:a3e1:7ab4 with SMTP id cl2-20020a17090af68200b0029aa3e17ab4mr4087470pjb.20.1708975796119;
        Mon, 26 Feb 2024 11:29:56 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9150:3974:b45e:e425])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0c0200b0029abb8b1265sm3145877pjs.49.2024.02.26.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:29:55 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Mon, 26 Feb 2024 11:29:50 -0800
Message-ID: <20240226192950.4136472-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <2024022651-shrimp-freezing-6b17@gregkh>
References: <2024022651-shrimp-freezing-6b17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
following kernel warning appears:

WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
Call trace:
 kiocb_set_cancel_fn+0x9c/0xa8
 ffs_epfile_read_iter+0x144/0x1d0
 io_read+0x19c/0x498
 io_issue_sqe+0x118/0x27c
 io_submit_sqes+0x25c/0x5fc
 __arm64_sys_io_uring_enter+0x104/0xab0
 invoke_syscall+0x58/0x11c
 el0_svc_common+0xb4/0xf4
 do_el0_svc+0x2c/0xb0
 el0_svc+0x2c/0xa4
 el0t_64_sync_handler+0x68/0xb4
 el0t_64_sync+0x1a4/0x1a8

Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
submitted by libaio.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240215204739.2677806-2-bvanassche@acm.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit b820de741ae48ccf50dd95e297889c286ff4f760)
[ bvanassche: resolved a merge conflict in include/linux/fs.h ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c           | 9 ++++++++-
 include/linux/fs.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index e85ba0b77f59..849c3e3ed558 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -595,6 +595,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1476,7 +1483,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
+	req->ki_flags = req->ki_filp->f_iocb_flags | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a1911dcf834..67313881f8ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -337,6 +337,8 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;

