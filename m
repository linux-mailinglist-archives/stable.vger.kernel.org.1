Return-Path: <stable+bounces-62373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862293EED3
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2E0281F47
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369512D210;
	Mon, 29 Jul 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLh/o5cq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913412D1FF
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239083; cv=none; b=lYmtvtsHmCxzex7DY+arc97/sX6xksiUm7ohMgWZWr9tfZRDFhDur8MuGQ4arLdiwtd7YIim6o+3PbdYUvrXi9MBtbi27Za+KIkbEjpeQmQ7tbEYFInA9v3Q0oq6Tm5j/6iPoOCV4L8HAg4kVWf0B9CiPXg1fTAjgrpz5LYk9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239083; c=relaxed/simple;
	bh=Y1Xo+pGw0ZeXq6KFnuYOxx+i2rjGNSeqgzLgBspnnvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dd1btZ2bwE6QOF5g9XSEzThRy6Or4kI1CK5Tt+XpujkuriiM4IyA6xFkonkIP5zBGRboP7n1Ju6QSrgtmanoBTAYIwS2xhQro+bk1AHrHlgR13Y/GtNb6wEwwhrAbeI9jdYIuR+zb+NZBqar1XEhchUc+yszsJCLyvr34iitjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLh/o5cq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66480c1a6b5so63167367b3.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722239081; x=1722843881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtnIlo46Yx7gbFBIWgbWoFxOI+eJWpQC7yDRn8YW96Q=;
        b=tLh/o5cquaG1vpK8rSwHytn3+TAaUphkm8MZTAfpc0xmvYGNxCs6/S7SAohzJo8xJp
         5YgsmPO/MOZ8FeT5XFOxrsWnIjv1j5KHckdakJ0w29gzNx9fIver3wOqAS1XnyrQFRSB
         Ix5SSK0398A8FytRjsgxAjrWhPa9SVNOFWvjsIZnUAaqH17rQ06ki5CPCvIzVUi4u6nY
         5OLQLpJwU4gyuaWN6oC/9dTUN6BHP4K2FqXl6yFOXQj3vPOlbDgQawZJQbbhLDLA/9hn
         NN0SEFsKX6mXdv7c8kfKdn9j9QOnMxyAesa7V/l9uxDhFAoWUH7P3Uf1qfGFuYVcQZD0
         iwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239081; x=1722843881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtnIlo46Yx7gbFBIWgbWoFxOI+eJWpQC7yDRn8YW96Q=;
        b=T2dk/xwsgzjXeSVZb8EoqY6g162Cz9YmNud4fdZkN825hwtv0AA7ZT/kChAD/5GoKA
         PlbuRE+JWFybsVQBwHEDgqiDIoEpcfJs0FkixIynS0MWSq2KCVyAR/tb07bgog7pS4z9
         +ZfMF4Jx1qDHcUVSuxc7Sz2j4L+6dlBekr84eN6WRxlP1T5gls8Bqgc76JAZ+EDOu+E0
         9doGbYMo9cOQTDFcKG1ZfEF/0dxgJ2ObrHDTXz4dQ79MCuvk9m4j1jEB42KN9M1rr5Lo
         8dYpGbgfaurG/u/C/GJTE3rKXfNYYwI0LUPT/gKFk79Brju+xmhhfaHnbjhOho5/o64z
         t7iQ==
X-Gm-Message-State: AOJu0YzbqVLLP+/lB62udjcIPWEyCrVbk9hRKCxi1d7GkMzGrEwShipc
	pPkPZhlxS4ZaV2Mkf45EcRb3gl4N54abX8AbVZByNrV/hKumxGKW28b1i9/qsUHARhxpebPhw7v
	DLSmCSUljz3Py2MNRmpMQkVq8iQHB96WI0yc0dLJbhlFOCF9zrQx+eiQDHwQLmfMtuvaht1eQVF
	WXoprHUs9wUvIURNIlrLdSkC3J2KXJMWfs
X-Google-Smtp-Source: AGHT+IEilHbVie8dcXc0ozids4g2MbIbd28UaFfsysUp80ffuUTEq4qh2eL/0PVBaiiQTa9bjQRZHl6QXnI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:33d8:464b:83b0:a265])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:1002:b0:e05:6961:6db3 with SMTP id
 3f1490d57ef6-e0b54503b59mr13495276.9.1722239081120; Mon, 29 Jul 2024 00:44:41
 -0700 (PDT)
Date: Mon, 29 Jul 2024 01:44:33 -0600
In-Reply-To: <20240729074434.1223587-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024072912-during-vitalize-fe0c@gregkh> <20240729074434.1223587-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729074434.1223587-2-yuzhao@google.com>
Subject: [PATCH 6.6.y 2/3] mm/mglru: fix overshooting shrinker memory
From: Yu Zhao <yuzhao@google.com>
To: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>, Alexander Motin <mav@ixsystems.com>, Wei Xu <weixugc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

set_initial_priority() tries to jump-start global reclaim by estimating
the priority based on cold/hot LRU pages.  The estimation does not account
for shrinker objects, and it cannot do so because their sizes can be in
different units other than page.

If shrinker objects are the majority, e.g., on TrueNAS SCALE 24.04.0 where
ZFS ARC can use almost all system memory, set_initial_priority() can
vastly underestimate how much memory ARC shrinker can evict and assign
extreme low values to scan_control->priority, resulting in overshoots of
shrinker objects.

To reproduce the problem, using TrueNAS SCALE 24.04.0 with 32GB DRAM, a
test ZFS pool and the following commands:

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

Link: https://lkml.kernel.org/r/20240711191957.939105-2-yuzhao@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Alexander Motin <mav@ixsystems.com>
Cc: Wei Xu <weixugc@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3f74e6bd3b84a8b6bb3cc51609c89e5b9d58eed7)
---
 mm/vmscan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0fea816d9946..94b001b1c4c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5585,7 +5585,11 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
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
@@ -7350,6 +7354,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 {
 	struct zone *zone;
 	int z;
+	unsigned long nr_reclaimed = sc->nr_reclaimed;
 
 	/* Reclaim a number of pages proportional to the number of zones */
 	sc->nr_to_reclaim = 0;
@@ -7377,7 +7382,8 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	if (sc->order && sc->nr_reclaimed >= compact_gap(sc->order))
 		sc->order = 0;
 
-	return sc->nr_scanned >= sc->nr_to_reclaim;
+	/* account for progress from mm_account_reclaimed_pages() */
+	return max(sc->nr_scanned, sc->nr_reclaimed - nr_reclaimed) >= sc->nr_to_reclaim;
 }
 
 /* Page allocator PCP high watermark is lowered if reclaim is active. */
-- 
2.46.0.rc1.232.g9752f9e123-goog


