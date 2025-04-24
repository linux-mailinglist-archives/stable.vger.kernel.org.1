Return-Path: <stable+bounces-136628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA92A9BA40
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04371BA3586
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81728935D;
	Thu, 24 Apr 2025 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G51kwE5I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596E27CB0D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531859; cv=none; b=qPNJblGjeu+K9TVAq9vOASgh+4zNp0XpzhN/PW3aoajdPZQZzgDaLVY0G785QNmIC1IxwLlfbm2qBDVgNCmWfiCeNNxeNY3XtBA3tNRNBHsLyh7+kLmFiSXqOaSIXu8j6A9146/rh8O8ktG7tqWeo8M7rlDLXiWtEJ6MQyrELrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531859; c=relaxed/simple;
	bh=PMYkCLShuFgSxRLbR/YgPDJEhWhNuc+fzDPLNqysXgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI1Im1Rb7D01p/4fnHm/7JImHKKopep+8VW2IgtvgKOxMsDCet/57qk/TiWkniiqB730hkow7ArYFqagvtMoEQF5DsU45cAofL/5QyhKkh9IJmfiZhJit2n6uPlxaw/YWL0WStLol8pRbFtF5uZ0yiM2cp/zehJbKJHuLRSef2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G51kwE5I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745531857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/P/wUaBAruINwfJFucR06lbEXL7rTIXf+J016W0OcU=;
	b=G51kwE5IyJYIVa2G5io14ndF9r3UNRBubRQ/H4Q0ayZ71ZgFyF6xrcTqdCxwZ8TFaMHaIA
	roOid+jSGLSwgeaX2+8P82PVSaSt3QFRb9ijqJUFriVaNn3baAVwwIZ0B9j61fPHb1lvo+
	4BQLOx3PzdLE5TPRx7rVb0oBN9/wUvo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-YZClarcGN3q_m9VeByhnDQ-1; Thu, 24 Apr 2025 17:57:35 -0400
X-MC-Unique: YZClarcGN3q_m9VeByhnDQ-1
X-Mimecast-MFC-AGG-ID: YZClarcGN3q_m9VeByhnDQ_1745531855
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c95e424b62so91743185a.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 14:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531855; x=1746136655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/P/wUaBAruINwfJFucR06lbEXL7rTIXf+J016W0OcU=;
        b=qhjLfYdZZRedzs2H5Qq/j5mfY7DYhPt3LaV1pWpZUvNZoAaMPZjxAdKJEBU3j2b0WX
         F/PKwe/BaUwCLLmAo7XEjlrAoYhz/NPQh8o0rocqPgA/KCuzF1XyQ6HtF6/cDy53b5FD
         34lvilhEAUGmgE3xzOL9RwnnlOiWp4na+LtgdfgLtj7mKy7/09iU7IIbs6oVaG0at2ss
         ZsfpPEvbCBYxeeoZDvpzfyg2Hz4uPKkIaK9ugghF6M8Tam1YlfVeR34dnZH/NrXFE0is
         +zzBT2TkNVRi873vlnQs1dckPkGn/58oEstMPCr2jADZE8UANaPRNwuwPXdvhMkdzw1l
         20Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU0dRG/1ZCyqV8SPD2fRIP4VwQd7swDSUMBuvZrZKrqrtOcmRGc3Bg9Kyl/L0HCH9IhFeEY+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IevMgEAD126ucFRhPKaglSmPiQEf6Fn72wyCQwwAHxxHgk50
	VoFIoVMExw7Cf2xEXneCf2KveZN60ERRASHxI/GzkPZgRhlSv11z79GjS2idUQTJMU7tUc4Y+Db
	u2ywSoxj2tBPgbYN/+7mKuGqlbZlPY1rS6WnI+zu+GYsaYRRFiVCu2A==
X-Gm-Gg: ASbGnct3ffGCIiRo0Yy9Toe9iNSMXSQfYRLRKxRPIbVyIGwTlzYPlvmkaOFbmCFgczO
	ENPb7DP0Wx5ElRIdOtgJsg/d7VTOH4DryPKRVr6tXnHrUa7YuKTPFb2cq/AWtyen0Lo2fH/hN6Z
	oAjfEUQOOFgRKdMpqcjcHke6burdcpPfaAte4CEQVU5k2ZHhdJ8oc+4p+o/zGFenvM1GGwWMQAI
	AJQm2am2XMP8qS6piZ7Rw+UrwfUN5SMucxnls73UOyNFyRtxJKD4JsPi5AFaa4mwEhhgmcecsTR
X-Received: by 2002:a05:620a:414c:b0:7c9:574d:a344 with SMTP id af79cd13be357-7c958659e5amr515885885a.25.1745531854721;
        Thu, 24 Apr 2025 14:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1iex2yj7RJMZCAOmnWtzoov0phuvCk1qVkZv1VYXxZqfMBp7AortWZytLmA8d5ROfiO8xYQ==
X-Received: by 2002:a05:620a:414c:b0:7c9:574d:a344 with SMTP id af79cd13be357-7c958659e5amr515882385a.25.1745531854314;
        Thu, 24 Apr 2025 14:57:34 -0700 (PDT)
Received: from x1.com ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea2a6dsm138737085a.106.2025.04.24.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 14:57:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	linux-stable <stable@vger.kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 1/2] mm/userfaultfd: Fix uninitialized output field for -EAGAIN race
Date: Thu, 24 Apr 2025 17:57:28 -0400
Message-ID: <20250424215729.194656-2-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424215729.194656-1-peterx@redhat.com>
References: <20250424215729.194656-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While discussing some userfaultfd relevant issues recently, Andrea noticed
a potential ABI breakage with -EAGAIN on almost all userfaultfd ioctl()s.

Quote from Andrea, explaining how -EAGAIN was processed, and how this
should fix it (taking example of UFFDIO_COPY ioctl):

  The "mmap_changing" and "stale pmd" conditions are already reported as
  -EAGAIN written in the copy field, this does not change it. This change
  removes the subnormal case that left copy.copy uninitialized and required
  apps to explicitly set the copy field to get deterministic
  behavior (which is a requirement contrary to the documentation in both
  the manpage and source code). In turn there's no alteration to backwards
  compatibility as result of this change because userland will find the
  copy field consistently set to -EAGAIN, and not anymore sometime -EAGAIN
  and sometime uninitialized.

  Even then the change only can make a difference to non cooperative users
  of userfaultfd, so when UFFD_FEATURE_EVENT_* is enabled, which is not
  true for the vast majority of apps using userfaultfd or this unintended
  uninitialized field may have been noticed sooner.

Meanwhile, since this bug existed for years, it also almost affects all
ioctl()s that was introduced later.  Besides UFFDIO_ZEROPAGE, these also
get affected in the same way:

  - UFFDIO_CONTINUE
  - UFFDIO_POISON
  - UFFDIO_MOVE

This patch should have fixed all of them.

Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Cc: linux-stable <stable@vger.kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d80f94346199..22f4bf956ba1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1585,8 +1585,11 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_copy, user_uffdio_copy,
@@ -1641,8 +1644,11 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_zeropage->zeropage)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_zeropage, user_uffdio_zeropage,
@@ -1744,8 +1750,11 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_continue->mapped)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_continue, user_uffdio_continue,
@@ -1801,8 +1810,11 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 	user_uffdio_poison = (struct uffdio_poison __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_poison, user_uffdio_poison,
@@ -1870,8 +1882,12 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 
 	user_uffdio_move = (struct uffdio_move __user *) arg;
 
-	if (atomic_read(&ctx->mmap_changing))
-		return -EAGAIN;
+	ret = -EAGAIN;
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_move->move)))
+			return -EFAULT;
+		goto out;
+	}
 
 	if (copy_from_user(&uffdio_move, user_uffdio_move,
 			   /* don't copy "move" last field */
-- 
2.48.1


