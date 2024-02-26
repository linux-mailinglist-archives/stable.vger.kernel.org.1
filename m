Return-Path: <stable+bounces-23759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECEC86812D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F045B1F28801
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D812FB35;
	Mon, 26 Feb 2024 19:37:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB853E1A
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976255; cv=none; b=gUmJAyrzH7Ri4UkvlcU9JjLGjvnB950ZJdud6c0rpkXOMFoNQZTgA9Wuqr/dQ/JaYbXbmBfjIHj4139aLTbUqL1OldAL1L/Luh0MuMBLs5hdBDELPKrBlSvv7+FHltwlVX0g+tw8K3PbfRI2+XJhdEypLyrFFkGs1cdbw3jk+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976255; c=relaxed/simple;
	bh=AYwyscdHu41jHzfdcIsd1uDMxA6dCl84KIpQ+3WHn9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMcmoK99xf4J/MpXOdsGJuoKr3RA5wiEWf5QMg8aLbcIFndosK/czm1eE+6Ze2OKqZEvN7G0nQROJ0op/lxP/h54seNGQeExxcqhM2BoUJy3q4pwPb/YCV7sN6yNMfUVPcczclkvAsmLlKteBUIQnAneq3urcRRP6/XsQKZo45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2578579a12.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976253; x=1709581053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtLnv811+466YkRd5M187FKuobG3m/wh5e9wX8L3iu4=;
        b=jKAaKnSPzzAXeuUiLHSczgU4T+NWwf003P1EoaESyExkQ8Bx2oxNHv7PTbhjceLY9w
         qTmjMCitfJcE2de4rDLDYK1PCcXG+IKzknYFe6+QoS1JfODEUtKPmrZeghCmlRmDBA5y
         OmpcwMgRO5B2B1bspFyJvSB3QUR6N9E/ZQFG1u/N4ILvySZGmaNdyVNED2IlJqqiPEO9
         5iQcr8vIZRwO3fA7UhTGjCsp5TJx06vRNWt0185lkl9+K+9+KVrlddFhQ49emsgi0t4P
         VaA2ql7CTL2O/k/k8mscA0JqGruptRXuWtDWQiCYGInH12PtuglHRCCmEsGwpqRbfbJT
         1axg==
X-Gm-Message-State: AOJu0YzeLAI/WeRyBUeI/A5ClBInEoZslVXAtV8OitHQpu8vYzXEOjbv
	Dute7jUtsV7BG0atwuL2mVSjE9jtELQftFKCp6iijspn5poVFyeBCoRF/zoN
X-Google-Smtp-Source: AGHT+IFvhqSDt1wt8r3agJaAS7SpWTCM7o2yV/pzclBiF7nO0JrBGRR3i9LcLnEXojC+xXxKBVDwrw==
X-Received: by 2002:a05:6a20:9f4a:b0:1a0:ee90:7790 with SMTP id ml10-20020a056a209f4a00b001a0ee907790mr154694pzb.48.1708976253159;
        Mon, 26 Feb 2024 11:37:33 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9150:3974:b45e:e425])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7858d000000b006e488553f09sm4411157pfn.81.2024.02.26.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:37:32 -0800 (PST)
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
Subject: [PATCH 4.19.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Mon, 26 Feb 2024 11:37:26 -0800
Message-ID: <20240226193726.93631-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <2024022602-unwrapped-haggler-daae@gregkh>
References: <2024022602-unwrapped-haggler-daae@gregkh>
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
index 1bd934eccbf6..8ad748dd3e48 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -566,6 +566,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
 
@@ -1446,7 +1453,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f89748aac8c3..e2c87c056742 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -304,6 +304,8 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;

