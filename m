Return-Path: <stable+bounces-59157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CCA92EF88
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 21:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC3B287955
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080C16F0CF;
	Thu, 11 Jul 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKBi94R7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463231EA85
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725607; cv=none; b=n5BMF01KzkgvJPiL0lumyRmHdq9VKav42GxIRsu1V0MkIHyAzOb46Z1JXSAYrcsKKSfCbuNCCe349ZXyc669i+vlHMHGtP9yu9/nx4UADbcvBmiQbKKg8JFfPI+khPK5+aSqvaBQG04nxijNY6cVLxtZicD71aBT0pd3h1BDVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725607; c=relaxed/simple;
	bh=nf9cOxiu8EFTnlD4vdbKRn9iAdK5IAhbikgz3BZy3u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYBd7G5kaJfB0rkyuJyjjyIay9xgGBCvx7d6Ep+tCi4M86jb7DCJRjGdbesJ20m2J7On6tkzve6czmPIh4I9fLPaxyc7On5+oW0koBF9T5CvUOgarY3E+q/cJFCPGAA2aCO8gFdg/ZzLn6S+ObVi73pe8NY3ngm+GqHcgDUQGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKBi94R7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a59172dbso2028231276.3
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720725603; x=1721330403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5p4SaaO+7UoZgcm+e1C8dGPnGJXML0RCKN69AHh9/8=;
        b=uKBi94R7I2FNWp+5opc8mDI4zAK8glG2CjngbSQKTVl4xM6qle22lUhWR5cgIms7EM
         dobBVoPEdR7I76jr8z6fzH/5KMoMtgOz0G/orK6YDL/2yO9n58Qig4v5uMANX6/2VfJ/
         Ga93R8CkdNlqCytFaUjGIgJyqV5mhT+y+6WoCmHfhT06JUxul3mLDlFg0HZKHVBOoA0A
         yQLTAS2Thp2KkpsIallBVdrbZXRVl4l5ydyiMx04hHsbRJI8PJkfrnXuNy8Mg3RORSO6
         9L2T2epT1H3uuNkmE/IGAMmTsOvQmJippv+pNSEFjS1eLyz84YCND3JqfrOiQUVc1oZM
         uwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725603; x=1721330403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5p4SaaO+7UoZgcm+e1C8dGPnGJXML0RCKN69AHh9/8=;
        b=SrqE90k6bg5Y9k92tX23n3828X4MpvrEDeTb/8ntHfyLL8mjr27fgFm+L2C5CIyVXZ
         4FSlBY7qE9Z6k280d3rHjdfDq9cEWRTB2rne+Qafh9ROsQZRJwDDkO5oalA2mX4SORPo
         UuaaJHG0uvc9joz5v7s/pVMl1ewVeu2rbxtJB60u6YExQ4xYBqRlsXl5ljws+xMZGJH3
         wforbcLD6SmNkcwBGY/SQ3pW95P18rg/5uY6EQVvxRH+y9y9fFanDYbCnRu58jbsmITN
         SoKuJqEx5At5OgMGSjhIK6soGSwMTIMwLubRpRdEuYYIDDItA6WJuy883qvTqsbRW08C
         mctw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6K3dBfnLSY2LfuM7xiE65ssRpr9LxJqfJhOKTcBjgtuCAKKYzk5LD4/DD3Lyfartjk03WzUtRuSTZeWc6o2Z/FQxc6RJ
X-Gm-Message-State: AOJu0YyeHXUGua5Dt2KQMSLHTaUrWldOguXhzbgJlkw66jTTdbmkdYMD
	LA/t6fkOhCabnp73qZqXbH9Brm0kwqAwieyWS3lnXu1UC+gOzvSiEAu+/3U7KS6N/ouC4+f7S1V
	xtw==
X-Google-Smtp-Source: AGHT+IFwZuZdGnTKPExljm8Tw+4jIU2FhrH6S3OcLgO05bDExtd9/3IrHUiiKpVcYyY1Saivv4UkxyKDxXU=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:7f87:3390:5055:fce9])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2e0d:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e041b14c989mr615371276.11.1720725603316; Thu, 11 Jul 2024
 12:20:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:19:57 -0600
In-Reply-To: <20240711191957.939105-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711191957.939105-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711191957.939105-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/2] mm/mglru: fix overshooting shrinker memory
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Alexander Motin <mav@ixsystems.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

set_initial_priority() tries to jump-start global reclaim by
estimating the priority based on cold/hot LRU pages. The estimation
does not account for shrinker objects, and it cannot do so because
their sizes can be in different units other than page.

If shrinker objects are the majority, e.g., on TrueNAS SCALE 24.04.0
where ZFS ARC can use almost all system memory,
set_initial_priority() can vastly underestimate how much memory ARC
shrinker can evict and assign extreme low values to
scan_control->priority, resulting in overshoots of shrinker objects.

To reproduce the problem, using TrueNAS SCALE 24.04.0 with 32GB DRAM,
a test ZFS pool and the following commands:

  fio --name=mglru.file --numjobs=36 --ioengine=io_uring \
      --directory=/root/test-zfs-pool/ --size=1024m --buffered=1 \
      --rw=randread --random_distribution=random \
      --time_based --runtime=1h &

  for ((i = 0; i < 20; i++))
  do
    sleep 120
    fio --name=mglru.anon --numjobs=16 --ioengine=mmap \
      --filename=/dev/zero --size=1024m --fadvise_hint=0 \
      --rw=randrw --random_distribution=random \
      --time_based --runtime=1m
  done

To fix the problem:
1. Cap scan_control->priority at or above DEF_PRIORITY/2, to prevent
   the jump-start from being overly aggressive.
2. Account for the progress from mm_account_reclaimed_pages(), to
   prevent kswapd_shrink_node() from raising the priority
   unnecessarily.

Reported-by: Alexander Motin <mav@ixsystems.com>
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6403038c776e..6216d79edb7f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4930,7 +4930,11 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 	/* round down reclaimable and round up sc->nr_to_reclaim */
 	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
 
-	sc->priority = clamp(priority, 0, DEF_PRIORITY);
+	/*
+	 * The estimation is based on LRU pages only, so cap it to prevent
+	 * overshoots of shrinker objects by large margins.
+	 */
+	sc->priority = clamp(priority, DEF_PRIORITY / 2, DEF_PRIORITY);
 }
 
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
@@ -6754,6 +6758,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 {
 	struct zone *zone;
 	int z;
+	unsigned long nr_reclaimed = sc->nr_reclaimed;
 
 	/* Reclaim a number of pages proportional to the number of zones */
 	sc->nr_to_reclaim = 0;
@@ -6781,7 +6786,8 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	if (sc->order && sc->nr_reclaimed >= compact_gap(sc->order))
 		sc->order = 0;
 
-	return sc->nr_scanned >= sc->nr_to_reclaim;
+	/* account for progress from mm_account_reclaimed_pages() */
+	return max(sc->nr_scanned, sc->nr_reclaimed - nr_reclaimed) >= sc->nr_to_reclaim;
 }
 
 /* Page allocator PCP high watermark is lowered if reclaim is active. */
-- 
2.45.2.993.g49e7a77208-goog


