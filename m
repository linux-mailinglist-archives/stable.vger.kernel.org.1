Return-Path: <stable+bounces-23758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DADC86811F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581D0289A2D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C212F586;
	Mon, 26 Feb 2024 19:36:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0591947E
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976174; cv=none; b=PMNu6jZe/KSJWPfJdXIWooZIvONZM4PPzcJpT+Bp74rjBDwb+hm7hfNUwNn2XBy0CdHkofgCur5EArM6w+dyrZJPeMm4fLpht3dCf8+jK/JuBGCH/o744R0abcYVwKyizI06FuW8MXcqN9gTAdUQsczqpqloyOhR5uHdZHvzEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976174; c=relaxed/simple;
	bh=otY6vsUl8Xa5aWZcJ0n6DE5m6wDGBtX+NOcpuCgUAYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+shCbyjpydF9ll/02hzwE1VrDaKhd2AQ8qpPScnSH1jY+rl3dwYpkzH9rDKRhnEc7sPdaDcEScnYSTsZoreYVm5DETcwllfeoQqvTemtWhse+kjUuxWpC95uYj+s2FmYDt1lpzWj9s2EcHt8NU5LjbEA+CWrt2bZQ5qfHXLf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e54451edc6so306240b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976172; x=1709580972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlKSMrmJD5FaTy/qPxfW725zb7MJHFj8m43jsS7f1fc=;
        b=sEm04vjY/w2MrHdWDqRwzPFQUHRUOLa3HoWTQBlNzHprVVLPaPoR8kk183JZv3CKFZ
         GxZ3giWesXX7kwGiEGcp1NfrMCqmiIY3onET9OoBQAKiXqRPgl2ztNyFzj8Vi9tm5+gW
         YkgI1OOgzNMO7IjbgZ267Tm6noiN23ce4Q1rW8tdFp3i78XX5gitpvdRJbTEo+XLN4VD
         a9r8pa8tBCWowI+PYe8KuI8jhLfA+1hhydVAF7NSbizglod4hOqu2mxqtdeWDtGmMoqX
         xol7mkQxcMh8i4yk+7q8tTx+P1A1+X5GLnWdcnpW84gkrqshJi2EdZRs4qkWvyzZiVoq
         fr2w==
X-Gm-Message-State: AOJu0YxL3seFWkJDUUBi02FLGMv2u+dCgV4XIVXlik0T9gzhRR70bJho
	8p+fN9mErrkzCGnpYjrhKFjHqz3o4YAOuNgGlrNeb10B2/CsFLXt7vvPmIeu
X-Google-Smtp-Source: AGHT+IGWoX1xeqTRRxGMa59NL55NY8KMJfPGEbVwjpDcNG0hjrqPslgmewhni4cwxp6BvnrNBoR0bQ==
X-Received: by 2002:a05:6a00:178b:b0:6e4:fe2c:d766 with SMTP id s11-20020a056a00178b00b006e4fe2cd766mr8556311pfg.17.1708976171641;
        Mon, 26 Feb 2024 11:36:11 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9150:3974:b45e:e425])
        by smtp.gmail.com with ESMTPSA id p21-20020a631e55000000b005cfbf96c733sm4384085pgm.30.2024.02.26.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:36:11 -0800 (PST)
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
Subject: [PATCH 5.4.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Mon, 26 Feb 2024 11:36:04 -0800
Message-ID: <20240226193604.59623-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <2024022601-stem-comfort-1bb5@gregkh>
References: <2024022601-stem-comfort-1bb5@gregkh>
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
[ bvanassche: resolved merge conflicts ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c           | 9 ++++++++-
 include/linux/fs.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 1ec5a773d09c..7a50c97cffc0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -570,6 +570,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
 
@@ -1455,7 +1462,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d9b97ccd65e5..e009b52ab6b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,8 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;

