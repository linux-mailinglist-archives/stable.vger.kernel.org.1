Return-Path: <stable+bounces-23756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFFD86811A
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B67CB223EB
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EB12F5A1;
	Mon, 26 Feb 2024 19:32:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112812F588
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975963; cv=none; b=nMeI0p44Vg2BlA4HyXxyTh+hNgdjx4QcuTFu/rNg8IO2iCyBkN5hfME6Mm5BNFMNbyEnEm/aPvo3tuqfon2fxmSUI6IVQ5H9k/orGbrY5k01QO5DSldXcoDyuDf7Ux9ZFPNdHKya4EF8uHIuO9sBnzzHNJR9N/HhJ5FKNPmhPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975963; c=relaxed/simple;
	bh=sc/rnAvuXTpi5Z0g9g4tDTbi5MOYpG4nD0+hI60VVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDFNaFgXdbY/U4PxNTsZTfac5WLWe0OvYkqUKMvu7KnMLSTKoSGMWBJxS46ffixg4jq7rJjHCeshk8bL5T4LPtqaFQss/Gjl0CKbHX3Q0t2J8LDb6vleufZ433PNRyRM+zbtitnS9HSycgp+kE8VVIxe7Ks+Y0LDEXzoStLQLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc13fb0133so25457665ad.3
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975961; x=1709580761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+stZri2hBEpjJaJkaOlHzLaLUHdTwc5gxxhzsXAmI9Y=;
        b=f5chENx0WcS4GLrljvDhxLCi36ATq0YON6heJ7VXByceQ+uQDsMg+5Dc6RwAVsKpnB
         ROeYPHxunQ4l+O5xNmdj+6RkUtBprxD9SMznIUQlTV2BJCsKMIQqhtV2ISJEqQ3Dpajg
         zaolchaHfWovzavENk4SVNxXN7F7MeNSeUER4/60NiDxQhBW/A+auDYLnR9hcVSM4RyD
         LzyxTEYEbRCF0SZqzXCW7YVvxCSgf3Hcnc17NH5YLHpJt0Tz7UUCTVaE+1mOxXljyPUQ
         /bltj55m8f98Q+lkvFU4ikTDMr9QMlD3su1yWBLuEL/PTK71GbXbSOV0YY9NIidZY3Ya
         Mpgw==
X-Gm-Message-State: AOJu0YxmLpMXsyVigPNhWTe00nm7jEa28cN6eLNUGzTI+FA3CUSwUdAX
	OWPq/VOlTEj35cmzJdJIoOIbb7df6VoL/r5R+xacns3utWGWe33SytKQhdM0
X-Google-Smtp-Source: AGHT+IFhUvimVogkVu6PqL57buHnm/Y4eYmljtKGmqUIKnH5HamhB2gms5CefkyBRCwJR/Xlo+sapg==
X-Received: by 2002:a17:902:7793:b0:1dc:42da:bad with SMTP id o19-20020a170902779300b001dc42da0badmr7063406pll.62.1708975961283;
        Mon, 26 Feb 2024 11:32:41 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9150:3974:b45e:e425])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001dca9b21267sm50355ply.186.2024.02.26.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:32:40 -0800 (PST)
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
Subject: [PATCH 5.15.y] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Mon, 26 Feb 2024 11:32:33 -0800
Message-ID: <20240226193234.4177638-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <2024022653-schedule-unloaded-e4ed@gregkh>
References: <2024022653-schedule-unloaded-e4ed@gregkh>
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
index e88fd9b58f3f..e24eb82b2b58 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -568,6 +568,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
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
 
@@ -1453,7 +1460,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_flags = iocb_flags(req->ki_filp) | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6f287fac0ece..f32723d937fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -322,6 +322,8 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 struct kiocb {
 	struct file		*ki_filp;

