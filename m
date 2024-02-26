Return-Path: <stable+bounces-23757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D957C86811C
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C84B2288C
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387212F5A6;
	Mon, 26 Feb 2024 19:34:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21B12B165
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976070; cv=none; b=jIgCURLy5eiCOEVmcD4j7ceKpcGC6VKVQVMhXdeX6Hys+bnyOenOJGmbyUi0qXgDN5HdqFWRhJ5We3Z9mU2/RQ75vgt4ez7sJoBsQlykoLgYhAdw1ACbMifrr6Ikj7qEYU6T/TyhKSRIUaQL2QpLeuGVb4TFtX21NWoE+2/+iRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976070; c=relaxed/simple;
	bh=0sgyTHAe+RVQP5AKGrYts+uqCmon0r/fOrNl6LFqwBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8se97OTWV6MyrhuGXYiNUmeCWFNYURX/BTECp3p7LMJGQnpQvRdhQwsC7nmeDzucmxxqLD9wivFN5s1Fi6poV19bk1S87y23hRCt9OWQRltBq/xSxPJwef9G9PshM/UMaU6gqQ7wA+BO77Y2OtgzvGVDEoJcgPWXB93RQzoBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59ffbff2841so1639657eaf.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976067; x=1709580867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMMDrkP7m1wOhjF4IESaho0H4YF1+DhoKgEedsEq7cE=;
        b=APgBcUswezgCVRk2ReyZQWV7ijRRpKArQbAdhI1SQduVEieGTLtNXkQ0W2V62dxSqz
         pirh5p0ZjFkDxI0al2ra8621n34xZTSQ/HpDSfiaccbXq7TneOQ9eIBdtIOI5MRjaTpn
         j7eX93rP+XyofBzwhl8lXFks0tZwOtoFirUsLO+N1ajx908trzFQr1/Sc3qTUzJpWKLg
         vDyC4PufVzkQVMi4trRuuhsd2r9930LHBS3I3oVS1Y3vbf64c5iWrJY1IQ4cV7hgiQ6j
         QdZQUUiuizgqEKiHQ+wbduYK8JqRICp4EeAoxBjM5TwLUFm5a1wOSelDWRRMRQU2O7cx
         Iz+w==
X-Gm-Message-State: AOJu0Yw25A6r4nt5hSFhBNFmw6eqRBuiaw0L7DKN2nCpyYnz3zqPNENi
	25O4Mg1YarqeY/cXAYJ8+CPaGVw15w7toQvkC3BG0l1s+4zg9VpiwyMq+Dd7
X-Google-Smtp-Source: AGHT+IHGMlgfHLpXvd82YR8asFLwZ2jpzcHOXfrLGZMiAGG3L1c7OEAJfdPM8aVupsLNHreq73hrdA==
X-Received: by 2002:a05:6358:6495:b0:179:1a1:ca9b with SMTP id g21-20020a056358649500b0017901a1ca9bmr11452582rwh.24.1708976067011;
        Mon, 26 Feb 2024 11:34:27 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9150:3974:b45e:e425])
        by smtp.gmail.com with ESMTPSA id e17-20020a635451000000b005dc8c301b9dsm4471139pgm.2.2024.02.26.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:34:26 -0800 (PST)
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
Subject: [PATCH 5.10.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Mon, 26 Feb 2024 11:34:21 -0800
Message-ID: <20240226193421.16169-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <2024022654-stainless-aground-196f@gregkh>
References: <2024022654-stainless-aground-196f@gregkh>
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
index 5934ea84b499..900ed5207540 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -569,6 +569,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
 
@@ -1454,7 +1461,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82316863c71f..6de70634e547 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -316,6 +316,8 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;

