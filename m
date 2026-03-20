Return-Path: <stable+bounces-227523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APe6KtMwvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:34:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263782D9A7D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F043084AE5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFCD3AC0D6;
	Fri, 20 Mar 2026 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWFmlISx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E793A759D
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006266; cv=none; b=ocah50m9CqdbTgSi5m4GMQf6OzOZVBji2Ed7oTjsg4zxuMdLxFWiFibTQYna+4Y7zF02kiu44/xSntMHnoP895FJvx9Jf6QN0T97+INduW4lkXsjXLsqJIBUrsn8bAUgn/R0gxd+lilxyHXKyfpbmhQXZnCg6dQIzL0JfMxek6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006266; c=relaxed/simple;
	bh=1tOeyqZYtOVZMgL6rtfBgjI0Fs7mG95dZldD/yZ0cZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4/HHqG6jFDShl3aiCCKY1fEH2al6SzYVKndmK5mNC1Az4zwNASQRw5/YeNJAmV9/QYsQsxXdfIsPdaH3f83HqVllk1oN2c6+E8YxI3eIaE3834fp/1N+ys4BPTQ1jdX7h/YN5+scOn40RzzXaUcVLQvW6o7/W0KJYOoV1zHjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWFmlISx; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1294615a91.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774006259; x=1774611059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEVxMvU1gGa8q35I1aiel0gWVBZz6xlYQzbFkoU47LE=;
        b=MWFmlISxhOJHPszS9t4aMT+L0p+970mJnJ9piTFnCxkzBicsTK+9ASL38MIWo/2MIZ
         sw8Pj0G7Dv0gC6ekr9NS953JYqwiqMoUmwVa1+l/szkMbjw1I0gZg7DAokVmkdCgzvfn
         MiMdO38D1UhD6BfgF8P4cI7kopUHJaPQ1/s5XIMuxBjlW2bYxmf7b/kGhVNjTK1vplFx
         5xeDXLIo96yA+M2v0u/8ILqU1Uz2adPOW7urbL7z/KbkxO1pKRfrUoMgCsioFe0fmUtU
         GOaBR/j8aB5Kr/8OeTEzTcA+OmR+Qu1zTZJCMEj/iYZk/35v6XiPMpKSGMpqi9uOf/yN
         tGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006259; x=1774611059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jEVxMvU1gGa8q35I1aiel0gWVBZz6xlYQzbFkoU47LE=;
        b=lCsoevQ7Ibk2aj4rfGnIuTC+cIfF8xTmRMeIXE66p7VHUwkPTl6ppTpz0I/KUZk2Hz
         iZOO80i+XuWK+lBBcKEAQRHZlj/t6J0AQfCem1GpF5lRf3Nq9ZLLrWv9cP40nhpSMWCC
         nbHNapwHE/PtWFkdpJ9DKkmM8FNUBUZjPPX+BXjl6Tqv+u1bkK7ZhOtEnL1VkxkuXUf0
         eL9zpMq6VHK0bv7EDNQ/nbf4wEykKwx0/fQEw7Nhz12OwRWxY0Q/tACLj8tbCrGxv7pc
         1u6zfdCZVFSv2uVEDXXL3361rWSZL/ap8Da2D54UvMywj56tIuGwXC8wZqwgsKQ2DUe3
         Bq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSDJFTHRuqws7XzjxA4jFs9TeBQ/xXr/57/xGtlicSOOigAuzXhoBbUhjvtyUvkhNni+Lm3yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx4w6MenC4WTA9G+ZSyDmZCnGN7q/U+sISPwr/pfPUEJB7ap/
	t0CdpwGo4xRVDnkQ4EPwvfztECktINL5y/o+BKCqQjyyBtJLuwuxyJU5
X-Gm-Gg: ATEYQzzah8TTl6f30ECnFXUhASg+dALxTF1s4xKReMohs2C10I/wCkswjk8IIC7Mvrj
	F6v3PIaisT2i95cEtVQzb9eKDLRuiiCQWDxoWtaXjGuPFm+1U3HhGNjXHRQ/rulf3BePM6DYgo5
	AhViici33ZlyP8ZdamDvR7iMfrCca0OzKU3hVEbk6P2HhIt/YDIJIDptWGCOjjjiSIJ3KcBZo/j
	PKHIqf8rvLIXFLYPYZca07xZkZ/5D6f3nHKExFBus05Owtl2Tk+q5nSnP5I+X6PEf662gN2o6uC
	IaUCgoxIuhwU6cOKAR0cgHXO/L7hhBlwYg0qTg3Wo6Dj0PYv/tfw2Lr2/wG0hq7dxxxbQJjOqig
	a4ZJOmm8SUlK8wXcbODJDtpWhYYhrrYTdO+XXe4M174St9q0yV0XfiP/Ctuh0I3XsAx3SDJbvyw
	ZHvt94feKZWUBExVT7RzTk8GGdNA63O6Oa35ZJYzI+tVj9ZkZlki1n5N5i101qxxffU7liN17fx
	itwsmxDeWQUFICLCD/3FiKk4zK4zwTqQhI=
X-Received: by 2002:a17:90b:5584:b0:359:fd50:e733 with SMTP id 98e67ed59e1d1-35bd2d34ae3mr1942896a91.31.1774006259038;
        Fri, 20 Mar 2026 04:30:59 -0700 (PDT)
Received: from CN4GKQDX76.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd356d29esm1052261a91.4.2026.03.20.04.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 04:30:58 -0700 (PDT)
From: Zile Xiong <xiongzile99@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zile Xiong <xiongzile99@gmail.com>
Subject: [PATCH v3] media: vb2: use ssize_t for vb2_read/vb2_write
Date: Fri, 20 Mar 2026 19:30:52 +0800
Message-ID: <20260320113052.46989-1-xiongzile99@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320081545.4624-1-xiongzile99@gmail.com>
References: <20260320081545.4624-1-xiongzile99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227523-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiongzile99@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 263782D9A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vb2_read() and vb2_write() return size_t, but propagate
negative errno values from __vb2_perform_fileio() via
implicit signed/unsigned conversions in callers
(e.g. vb2_fop_read()), which is not obvious.

vb2_fop_read() and vb2_fop_write() already return ssize_t, so
using size_t for vb2_read(), vb2_write(), and
__vb2_perform_fileio() is inconsistent.

Switch these helpers to ssize_t so they can return either a byte
count or a negative error code.

Fixes: b25748fe6126 ("[media] v4l: videobuf2: add read() and write() emulator")
Cc: stable@vger.kernel.org
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Zile Xiong <xiongzile99@gmail.com>
---
v3:
- add Cc: stable@vger.kernel.org
- fix function argument alignment

v2:
- add Fixes tag
- clarify type consistency with vb2_fop_read/write
---
 drivers/media/common/videobuf2/videobuf2-core.c | 13 +++++++------
 include/media/videobuf2-core.h                  |  8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index adf668b213c2..d5c3d4d939aa 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2990,8 +2990,9 @@ static int __vb2_cleanup_fileio(struct vb2_queue *q)
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  * @read:	access mode selector (1 means read, 0 means write)
  */
-static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblock, int read)
+static ssize_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data,
+				    size_t count, loff_t *ppos,
+				    int nonblock, int read)
 {
 	struct vb2_fileio_data *fileio;
 	struct vb2_fileio_buf *buf;
@@ -3154,15 +3155,15 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 	return ret;
 }
 
-size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblocking)
+ssize_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
+		 loff_t *ppos, int nonblocking)
 {
 	return __vb2_perform_fileio(q, data, count, ppos, nonblocking, 1);
 }
 EXPORT_SYMBOL_GPL(vb2_read);
 
-size_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
-		loff_t *ppos, int nonblocking)
+ssize_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
+		  loff_t *ppos, int nonblocking)
 {
 	return __vb2_perform_fileio(q, (char __user *) data, count,
 							ppos, nonblocking, 0);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4424d481d7f7..4b4f4c15c53a 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1093,8 +1093,8 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
  * @ppos:	file handle position tracking pointer
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  */
-size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
-		loff_t *ppos, int nonblock);
+ssize_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
+		 loff_t *ppos, int nonblock);
 /**
  * vb2_write() - implements write() syscall logic.
  * @q:		pointer to &struct vb2_queue with videobuf2 queue.
@@ -1103,8 +1103,8 @@ size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
  * @ppos:	file handle position tracking pointer
  * @nonblock:	mode selector (1 means blocking calls, 0 means nonblocking)
  */
-size_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
-		loff_t *ppos, int nonblock);
+ssize_t vb2_write(struct vb2_queue *q, const char __user *data, size_t count,
+		  loff_t *ppos, int nonblock);
 
 /**
  * typedef vb2_thread_fnc - callback function for use with vb2_thread.
-- 
2.39.5


