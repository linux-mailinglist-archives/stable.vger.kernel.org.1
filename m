Return-Path: <stable+bounces-123147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76613A5B8AB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B6A3AAF8F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA71E3DF9;
	Tue, 11 Mar 2025 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2PLNdwx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DC1E5711
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672350; cv=none; b=fuoworDCdrSpTAWv8QSYzXgTayMUKZOqbYLV3kLp+chMewAv1y7jDgk4QuSIzFe4lhM8wgyxR0i2u1tLHnQFEjufTSd4f2JN5SO8I8Qts/kqZe0yeSPAF4i4jNih2llkvsshne1yBMuRB+HVbeJW+5TZv0/t8XO9fy5Ca/ubR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672350; c=relaxed/simple;
	bh=9jIh1Wyi30pmEBp9BoWmxxJ0GYh1HzKxRLFX4UCd7Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CRNXdV/R2P6Yt9GOKWBhBN3/e5f/IOyPY7TE4+Z9h9hAkkCODCTkIMz1DI9Bk/cSeRcWWH7vH8ge6d0zQLDjTP+f8m883ncFV6NIgDFu95gkhz4oPfbt3e3jjiDgFuJBI0UXZKti8Z1aeTMVP9NZelh78cJNaw8z9PXGdTrgSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2PLNdwx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so1412168a91.2
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 22:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741672347; x=1742277147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JulbF52Nzw24BwpCt4Ixlc53AouAB03xm9qoZqBqETw=;
        b=Z2PLNdwxLcaNeMLe9UNBVb5g/NYpDtcn+dxgpSd/2zW6wdfjelcBccV1yM6ioqDibz
         czXeOKSbMRSRQws5ODYh76HEhyjjvqK2hw/Ullw7Fbrkh/vG8RblyunFlwcxc8VpfpPt
         DKPwgPtZgUeBrbOEFlm621bh3NaJc4ITX8p5iEfkEQNeJu+dPG/sP4D2Jeqqy+KGRqiL
         GomJFrmABz9x/oyGrcg7qhpTHxuNykbKy8rKbNm24CKiCtzfQAdSWfDx8MTLEHBe4nlK
         +G4X8j6xbs/C3KecK+6iAZgvOUCP12giXnmyx/0z+6nXj7f+cb6a3TGJ2hI17aLa/IWQ
         KCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672347; x=1742277147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JulbF52Nzw24BwpCt4Ixlc53AouAB03xm9qoZqBqETw=;
        b=YBIJokIEwBr7i3KfDMOzgoJXOHmvFKuZ24Ug9nwB22eBweqT9OgvVJfJXCHHkTAo8x
         JAlHsJ1FgStkyl7MVfnrKfatDiJqbo+1QWEX1v8t3ecxd/HGElbXKcfhY7NKuHtEaB2m
         e6RHT5/7lwOYMiKO+dfMuGYM4H4+eeN1EXXkXnyq0GzEOQW/MR2dneoz4ud3A6A+ZpZ+
         jbQqBpuBXgj76mPOK8iqpqpTorx+ICSzF4zXcwh90ScdzVGfg1nQVprT2wTxL7Q/1XgP
         Lz4naVtY/+5MsoOBF2GwXdGUGHax7DMKA9Tm8P1908LE4HcXt5fQAE+OSMqZCbF8y62A
         I9iA==
X-Gm-Message-State: AOJu0Yy8c7oo0nu6vA5dqlcu8oTjkZijP9LbuYOOUw0T0XZ7OkwixjWi
	8Kc7/hn7U9fUvaas/iG3h95A9ianNQsv0Aka1JJkHCU9hz64TP7I
X-Gm-Gg: ASbGncuGaDaCJjIzNw8BmggnHBfhpRl8mtOERzdDR7HTCOboCDP66cy/UcJz7O5fvZ8
	VEhzNR9yiQnG53DgPuZ30NGmlLY9ChaQG/CHAca/PnaJ+LFYyJ+Z8/RBd6Fd9ZRjOd/xEJtRaxa
	4YnFxTKMhh6ReEx1s8w7UwFxbls2sICXetcMKffWQBtmtNJyznfrGyMyhP/uY4Cwx39iWIzJ6QX
	3gG6rrE5ASxYiAdd/SSNQQSen1yAmnvwkf2TLWGw2TY+qwrvvZvxJKcq1iIJeUFTdL6TOxQmrS7
	hRU4JKKGPAEOCMC2FjXB994hVKreBxjg19uxM7QYaXewBFEFi/BYh+5hBsA1mQ==
X-Google-Smtp-Source: AGHT+IHUgDnX80hvrJrre9FreWNNeJbZOnPl2jbbYVyM38bRMrRARnKmY6i9MwOlHc7Hfx0zxXULDw==
X-Received: by 2002:a05:6a20:7488:b0:1f5:52fe:dd03 with SMTP id adf61e73a8af0-1f58cbcb57cmr1434151637.6.1741672347319;
        Mon, 10 Mar 2025 22:52:27 -0700 (PDT)
Received: from localhost.localdomain ([182.148.13.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bd2b6a35sm5990598b3a.22.2025.03.10.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:52:26 -0700 (PDT)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: liuqianyi125@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH V4] drm/sched: Fix fence reference count leak
Date: Tue, 11 Mar 2025 13:52:22 +0800
Message-Id: <20250311055222.4036465-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianyi liu <liuqianyi125@gmail.com>

The last_scheduled fence leaks when an entity is being killed and adding
the cleanup callback fails.

Decrement the reference count of prev when dma_fence_add_callback()
fails, ensuring proper balance.

Cc: stable@vger.kernel.org
Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
v3 -> v4: Improve commit message and add code comments (Philipp)
v2 -> v3: Rework commit message (Markus)
v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp and Matthew)
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..da00572d7d42 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,16 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			/*
+			 * Adding callback above failed.
+			 * dma_fence_put() checks for NULL.
+			 */
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


