Return-Path: <stable+bounces-200943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634FCBA280
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 02:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CEE130B1D88
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32B2010EE;
	Sat, 13 Dec 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNpl1/aS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA971DE885
	for <stable@vger.kernel.org>; Sat, 13 Dec 2025 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589359; cv=none; b=qphATEQdH1El7nhrHTwNuHb2ufxAkErqhcy23e159/7/fBx2SMBbrxIlzW2XPyhY81G5h2bddUobERzqf5HITHqvP5v3Y6J0xwog7Utcvb+VMWJMER5yMa0H3FLBHFV3SaNAv/skgL8pbvOGsRkTyaOEokDSwN6IvhTE5E0OOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589359; c=relaxed/simple;
	bh=Q/BnWKrddUCa21vqQ0fyH/iLAaKmHYd+0zEE+INzCdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcqDkgo+pDLiWS26jRKDi0K6VV7Y91Gobc5QEjQ4txOSgsZFdsKXeDrGEvXJjmR7v+Qv1EGlEr8kGiuQqi0qHRkPv6Tnvhjh+bqTYVS4jnxITcYxHzfhrJs8aHGCyV07hMFzLGsGbmu134v+Gf7JyzifIPbnfPXgwWkH9Lt7C40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNpl1/aS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c32700f38so33816a91.2
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589357; x=1766194157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=QNpl1/aSjjIszVUEeeu/E0BXJJDs5CqtTKVNskrDbdaqhFT5h02pZddplzz9uOXGhJ
         VHPwsJ45twAIaqaCLyoNyuNh/FWxW0azobrWJoz7246c9zv1P1ODIWTuW8tUxwue0Pzz
         cvTXvgcgbwBBIUBI3zH6coSfnk8WYk7bwURh1G+euFxIBTD+99DjcVUAQot4JRZciJC3
         tsIdxPlTJc9ZeSRwfL2sbBKPxMdZmTtNjQ8Y38keciKdu/WPL/TDUgGSOum5XfisY4h+
         cPvzyP3ZcG9bUsuXQOrf1X1Iox12+WKzyxzt3jTUiw7czS/eK1hz5gYQ2s3DoQxoKHk0
         jsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589357; x=1766194157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cln0tpkwGaPX83TGznuKujQwit6sD5kTkWZGVuQGa7E=;
        b=W2gs3Q68qp4iyUqWzHyM/Hku9dlyfZ8TlisnYaROx//SuII/hYAR5YHC+fQYovWKBG
         +3cPCCdK8nw1ZoUCiga0O2LYhxmzAPN5xyirFzBSM7xWxS9Hiug0xj2MWaXzD/ZcTObv
         CwjG7nNOHGx5mDKuhHhppEJezKdoYMBG8xk2i20n8tL3JFK349Q+9PMbyBOSxtNxwrBy
         dleJrCK+lEiULohmOQMLZqgNWkz+TpIhznUnrKx3EjWjzLjDZJzlVs/Clbnd2Xz9grZ3
         XV0QLOu5C+dGJWn5weTKqEUfR2O0RU6ekA3ZJKp6PYeO4YJNVAzS3q2eIcs0xM0mLvkb
         k5kg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4dGUln77FDvyQ+R/4ZOEwB/rKmDE3vO1zOjOMY391jXC4bEIuK091Rg3IOVdqQzMKFbiRIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIAtNuNAaNnpc/ft2CUd13bfSCwJLXOfCht9IbcyA+Pnqen/J
	9fOeiCG6PDLkHbzbfsBipQPqZ0r7t37RLtgtFPwFLMtJUtb3P1skmwT5
X-Gm-Gg: AY/fxX5qXfVQoB1VYhrIAtMMExubKLcitSnytHim2tij3H9Vc6DVHpMt7jcppHzRK3w
	iZIe5e9HDEOYQpYuTCYrsvTjUrGBIgvZdajovb0vcOW0yY0w4LsHqsf5fSVGA+eBmIVjR7Djf8i
	tZl+vfNWUfJzv6dCjQBidEEuTQRUC2xN4fuWpUoEBBXUW7e2vLzXu61rfdSpL+6pJUc5/UBNrbv
	uztu0vcbsKC5krPSlUTFnEYbpibXvlFpePcb0EFE72ZNvVoMjOe2lDf2G58sIIELqXnjoQzYw8o
	+ddlri69BclvceCqut5OLvEUT8slV/Vx7r7S/HyhC+V+n16VO7P8/KxKpEtgYIhGMZTl7uU7R1S
	w4P0ECQ8ZNYQRJstB3bPSjtyEGC/g80fhsGi3ojYcIVDT4eSVIxAlEgfXblvFjbJ8ZQm+PsmqBu
	psrsqHasHRoRxJJ+L0pUmN2BwRFB2aLl3XPv0ow9E6oZ9yZKiDLnDsCVv/woqChNTkCKA1Gfpp
X-Google-Smtp-Source: AGHT+IE2FNluVs7vDa7N2km+hccJ4M70DEuxxCelM+kxINda5gMkw26py8jFfb68ATt4fxnqeEdPGQ==
X-Received: by 2002:a17:90b:2692:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-34abd5c1d75mr2654608a91.0.1765589356670;
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm6370008a12.17.2025.12.12.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 17:29:16 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtiofs: fix NULL dereference in virtio_fs_add_queues_sysfs()
Date: Sat, 13 Dec 2025 10:28:29 +0900
Message-Id: <20251213012829.685605-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_fs_add_queues_sysfs() creates per-queue sysfs kobjects via
kobject_create_and_add(). The current code checks the wrong variable
after the allocation:

- kobject_create_and_add() may return NULL on failure.
- The code incorrectly checks fs->mqs_kobj (the parent kobject), which is
  expected to be non-NULL at this point.
- If kobject_create_and_add() fails, fsvq->kobj is NULL but the code can
  still call sysfs_create_group(fsvq->kobj, ...), leading to a NULL pointer
  dereference and kernel panic (DoS).

Fix by validating fsvq->kobj immediately after kobject_create_and_add()
and aborting on failure, so sysfs_create_group() is never called with a
NULL kobject.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b0..b2f6486fe 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -373,7 +373,7 @@ static int virtio_fs_add_queues_sysfs(struct virtio_fs *fs)
 
 		sprintf(buff, "%d", i);
 		fsvq->kobj = kobject_create_and_add(buff, fs->mqs_kobj);
-		if (!fs->mqs_kobj) {
+		if (!fsvq->kobj) {
 			ret = -ENOMEM;
 			goto out_del;
 		}
-- 
2.34.1


