Return-Path: <stable+bounces-169590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6AB26C59
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ECDAC4C0B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E7229B02;
	Thu, 14 Aug 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/3XM3g6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0292FA0C9
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187775; cv=none; b=puv5bLwit0bFFeX4EEnpDFmaWfXQYlLfUG80dAqjE9VULp1bShtc7uI7/ILClev62j7/8ciK8dQhkFQRgWIAcUAUH1vnu8apaYF3omHv/tUE+R2kpnSgF2nLZyli2aETDYCwSJJA3JAQigBoW2YzLBZZ6T6Wzs0wgtT7HcnUOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187775; c=relaxed/simple;
	bh=exv6JyGxmaXRmCJQtekZer9WTHnHk3FPtECoW+GN1P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFaOH+Zsk43Aq/VwJRActC6ekmEVQSBQH43eWury83V+P264QheD9pLzTk43PWSsEJ8eiu5cQAHoCeK1d0TyLSutrHKqcJ5PunGHV//EjWss8FLMEyrWxxlQuzg1vzy+kgSl1M4ANoi7xi3Rrq7GgrRob8c3pqYFAD6uaMMgVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/3XM3g6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7aea37cso145843366b.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755187772; x=1755792572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6F4gZG80wRhJNQ9wS+eRVIii/Kdl9b719nM5kirayc=;
        b=B/3XM3g6UQo6xTeDKuyuxFxapXSYunFfFFWRGtiSvJg5GECbKg7fzk7/UozBrZHwTV
         I93tipmxxV8PFJCS7X+norc6b07EGkFAX6aZFdHKisz6TOTJrvJZYyA9FRzEBAWBm5Ib
         /c+8m1BejmhgyjI6R1HfMsoDQaBOo5ct9n3uk58jHwymiNbyDvU66xHvg8UcoK524oPF
         4UAwuof158dmvc9i3AAp7l0fi3pvs8jojxCcByYNb1TfN+b0zVqz3omG+Ez5cA+0BN7E
         hpaE4va+B08RrPXCB2OQayGRyGPNH78fMwmLhbjoAa1vJux+l4dNiIDd5wcyFA1i2VkN
         wTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187772; x=1755792572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6F4gZG80wRhJNQ9wS+eRVIii/Kdl9b719nM5kirayc=;
        b=vvJIbAY8l49i58NlFMX9jaueSpmfKcqcZN+GJJCtBDGriteRIF7tcv+pvsFB0DzI/o
         8VwMWDZuGpvzwToCBVg9mJ2RD+Z7IcrDxDZ/83Q/8H+FbQm1YF2YNuh+m8qmcWsPb+kt
         2+D+lBzEsDnCFfwLAQSwTWFEZhXyaxLfmSu3MapWnVhTLfP4wJYmrM/mF0DZdhOTHXjp
         8O4PFGf0Zgd++D6ZsLi2nCTKQm6rbsSD0jTKnB5a+AtZwwlVq34VSbnf7PTGLozIfHRy
         GLwhAqvLTQ8/xTCs5fsK+1E3JrSUtV7F/82uUkGURBFqxgbMzYAS1kPB9wRb8iH9x1qw
         Z21A==
X-Forwarded-Encrypted: i=1; AJvYcCXe5NGKNB938ukTblGQmRy3zyNFZIasKKOgEyr6vozAYX2I2iYDJJQjx3BWX5i5Xc8wb6YGwiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWKD6Jz5HDGooZTD9tpWJnthM1ezBt8kQ66yuzckEBK8mxrnI
	2beLpQ+l4HtzHgGLq05bZPKUEf8clrvlwGUcnjlHaj0q/A98xKnzx5u/LbgT/lNA
X-Gm-Gg: ASbGnctI5Mo8Kz2pCebUy6q4ULs5o9WT2Np8A202CTB0JcqsGU3qigN6qmdqEF2ja6j
	w9LyyzuRk+WRM21GtZmZoPrPPcdl3InTbMj9uDWua6lzlaB/zmU4zNKxDfMNWPC0qaa93jNlm3v
	JJdpRJPsGpDQuP1nWT4hyRY+MuCMscd7HlUpfEc6EjC0cSRaiDXxUsJAM2jevJotkgvQa2lXxYz
	eXukeTpenAajDZt7VCARe8EL9ZdQDWSs9IRWO8XOo6eI81nbmrafu4YL2mXy+ir/VzltSlVf8C0
	UcVvo4F6uZfYlTgimMQ0lvx/tG4cWHAtC0/iX0fNDhNpOEfQHacNT6SY1e3DNZ0UvsjDptGx08s
	egm1JBkB3TQOECu0bswDEmxX5HAV5II0TY54grcyMov605xoq+mlkuwfSwR3qdUyQcTdfj5GACK
	B1oda3x6Zeh/rM7I/2kJAX
X-Google-Smtp-Source: AGHT+IF+4i6Xe0/623prUJrgOpKTuy6ylwRs3oUrf46079HzUabrEEBt8yAVUYy33wMELk/SincZrA==
X-Received: by 2002:a17:907:720d:b0:af6:361a:eac0 with SMTP id a640c23a62f3a-afcb996e8famr378741766b.32.1755187771585;
        Thu, 14 Aug 2025 09:09:31 -0700 (PDT)
Received: from fedora (2a02-8389-2240-6380-b418-985e-6bb5-99d0.cable.dynamic.v6.surfer.at. [2a02:8389:2240:6380:b418:985e:6bb5:99d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c06bsm2602268766b.119.2025.08.14.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:09:31 -0700 (PDT)
From: Dennis Beier <nanovim@gmail.com>
To: nanovim@gmail.com
Cc: Jialin Wang <wjl.linux@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] proc: proc_maps_open allow proc_mem_open to return NULL
Date: Thu, 14 Aug 2025 18:09:15 +0200
Message-ID: <20250814160926.792548-1-nanovim@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jialin Wang <wjl.linux@gmail.com>

The commit 65c66047259f ("proc: fix the issue of proc_mem_open returning
NULL") caused proc_maps_open() to return -ESRCH when proc_mem_open()
returns NULL.  This breaks legitimate /proc/<pid>/maps access for kernel
threads since kernel threads have NULL mm_struct.

The regression causes perf to fail and exit when profiling a kernel
thread:

  # perf record -v -g -p $(pgrep kswapd0)
  ...
  couldn't open /proc/65/task/65/maps

This patch partially reverts the commit to fix it.

Link: https://lkml.kernel.org/r/20250807165455.73656-1-wjl.linux@gmail.com
Fixes: 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")
Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
Cc: Penglei Jiang <superman.xpt@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ee1e4ccd33bd..29cca0e6d0ff 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -340,8 +340,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	if (IS_ERR(priv->mm)) {
+		int err = PTR_ERR(priv->mm);
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.50.1


