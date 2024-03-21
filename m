Return-Path: <stable+bounces-28571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075988607C
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143141F22291
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA4E133408;
	Thu, 21 Mar 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3Oz0Jh9K"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA18132C16
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045541; cv=none; b=O/lQUN3cJ799zF4OdKYZk5gAK1HEYaMZd9Md43HpBUaCcQDNyPhSZ8qukIGQbMkO12G8fE1KNwW5ka8z09G5NCvVI6n4BjmNgosbQZXB5ZLSI9s/pc+l11HFs4ZzCNWoZpDI1gQprmCjjumsjOvI/KLseg8/8AFNadFMKDfGbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045541; c=relaxed/simple;
	bh=mNt8c5Ewt8XiMxXkYYMi5yG5P2mD0bXKMZlcrOkYoJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUdNG+ehzsnWJgLzc7CZr5NV7HQyO09tQjvHPXf0hrHamxw8HFX3VraL7i3fIz4KxiiHEulyV/RGIRbIovaj+uPDtnztKgKcv4fULXYU1aa61+mAxa8zuNd75d6IrMDGXJB2GUnTmet7SMnF2km5/OG1U7KgSMLWKmMrN9Dy0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3Oz0Jh9K; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690cffa8a0bso8201426d6.0
        for <stable@vger.kernel.org>; Thu, 21 Mar 2024 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711045537; x=1711650337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/N8O7+oWMYcfdby+p0lm0Df2Q9f94VlAjnDmiCzjw4E=;
        b=3Oz0Jh9KMV3q8IF5CF+lz1LfUPGVUfovz34pkY7Jyx3nSO2QU2Yicj+l3jYYBGkrNt
         O5ziOG5JXGxUzYf5TF0CFes2YJTjzBLuSlf1ujkm7pMDDTIco015iyIVdL72ZrB2KmeS
         pAkEgN32krPAGummz0bs6eKLPPKqEAhM42ZGd0HwgE29Ka8a/OGa4+Td0EYzAnxtXbkD
         d7m0b88ebZ1C9+JWxUyTlnXUzG9FuEfuAyUl2Y3brIGQwgdmReXL9DmMRt1b7fWtevwa
         WqpuqPckNmuAVX5JhWjqtUu5TCnxyjD4fCHJY6Z6L4yEyIah9H5wq/DOJu+veirNhx5G
         uOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711045537; x=1711650337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/N8O7+oWMYcfdby+p0lm0Df2Q9f94VlAjnDmiCzjw4E=;
        b=viQGQCDyqrIF3vpx8E2EtMaioUVsmfjexCD4c03lQAElYBVuiE1xsGgUj+v5+mVnMX
         ViUsKGHwvo704hPzd51e3l4AqoGAxAKkN+fY9oe9yXWV70W16tSfj/hC8wOxRwZUm+R0
         X1s43WGnI/KVqNMrAKoVNkFo1kXcCl33Ndu89Aw0mZpi0GSVpBSUHPgHCLI+uYh79fK0
         0jjw0mEmFJHet9K4LURgt9p5ccZrqCvrPw/SiuNhDoASJKadEXBO4YGT2pqbjddzpR6e
         ZMtVl7t5vRG1gT7/cSuWuXLiC7KxNxnrgE2tDutztdSPyqXiyen8fQnLNV7FNbL97/OJ
         MxPw==
X-Forwarded-Encrypted: i=1; AJvYcCU8HBlNUykK9gnV7oHSXcoEbytbXj4Dh0WEp/PlOvubsA77K1GYYDZe4JddoQ/gYSOUa/+TiktJowzmsm2peS0BkKkSh0uU
X-Gm-Message-State: AOJu0YxGH0Lg8ay+E/wkMJzZnJGqTRFH++Xf9Pg4z88q9Q5bFyvzs9dV
	KcNTCTz2KgyGMpW74kjJyi/qnbwVHKpwafmAwh9jdAqWahwuzEUOjLGABg4xM3U=
X-Google-Smtp-Source: AGHT+IEse7B1NYDndrw9NXwdauLfoIqRPAn4cgINmWelWR7WD1qMnJ8xgQB+4hbQOKGMWCWUmWb7+w==
X-Received: by 2002:a05:6214:130f:b0:696:4771:e009 with SMTP id pn15-20020a056214130f00b006964771e009mr3328164qvb.4.1711045537648;
        Thu, 21 Mar 2024 11:25:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6036])
        by smtp.gmail.com with ESMTPSA id r5-20020ad45765000000b0069019c6eff1sm151086qvx.31.2024.03.21.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:25:36 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion
Date: Thu, 21 Mar 2024 14:25:32 -0400
Message-ID: <20240321182532.60000-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kent forwards this bug report of zswap re-entering the block layer
from an IO request allocation and locking up:

[10264.128242] sysrq: Show Blocked State
[10264.128268] task:kworker/20:0H   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
[10264.128271] Workqueue: bcachefs_io btree_write_submit [bcachefs]
[10264.128295] Call Trace:
[10264.128295]  <TASK>
[10264.128297]  __schedule+0x3e6/0x1520
[10264.128303]  schedule+0x32/0xd0
[10264.128304]  schedule_timeout+0x98/0x160
[10264.128308]  io_schedule_timeout+0x50/0x80
[10264.128309]  wait_for_completion_io_timeout+0x7f/0x180
[10264.128310]  submit_bio_wait+0x78/0xb0
[10264.128313]  swap_writepage_bdev_sync+0xf6/0x150
[10264.128317]  zswap_writeback_entry+0xf2/0x180
[10264.128319]  shrink_memcg_cb+0xe7/0x2f0
[10264.128322]  __list_lru_walk_one+0xb9/0x1d0
[10264.128325]  list_lru_walk_one+0x5d/0x90
[10264.128326]  zswap_shrinker_scan+0xc4/0x130
[10264.128327]  do_shrink_slab+0x13f/0x360
[10264.128328]  shrink_slab+0x28e/0x3c0
[10264.128329]  shrink_one+0x123/0x1b0
[10264.128331]  shrink_node+0x97e/0xbc0
[10264.128332]  do_try_to_free_pages+0xe7/0x5b0
[10264.128333]  try_to_free_pages+0xe1/0x200
[10264.128334]  __alloc_pages_slowpath.constprop.0+0x343/0xde0
[10264.128337]  __alloc_pages+0x32d/0x350
[10264.128338]  allocate_slab+0x400/0x460
[10264.128339]  ___slab_alloc+0x40d/0xa40
[10264.128345]  kmem_cache_alloc+0x2e7/0x330
[10264.128348]  mempool_alloc+0x86/0x1b0
[10264.128349]  bio_alloc_bioset+0x200/0x4f0
[10264.128352]  bio_alloc_clone+0x23/0x60
[10264.128354]  alloc_io+0x26/0xf0 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
[10264.128361]  dm_submit_bio+0xb8/0x580 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
[10264.128366]  __submit_bio+0xb0/0x170
[10264.128367]  submit_bio_noacct_nocheck+0x159/0x370
[10264.128368]  bch2_submit_wbio_replicas+0x21c/0x3a0 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
[10264.128391]  btree_write_submit+0x1cf/0x220 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
[10264.128406]  process_one_work+0x178/0x350
[10264.128408]  worker_thread+0x30f/0x450
[10264.128409]  kthread+0xe5/0x120

The zswap shrinker resumes the swap_writepage()s that were intercepted
by the zswap store. This will enter the block layer, and may even
enter the filesystem depending on the swap backing file.

Make it respect GFP_NOIO and GFP_NOFS.

Link: https://lore.kernel.org/linux-mm/rc4pk2r42oyvjo4dc62z6sovquyllq56i5cdgcaqbd7wy3hfzr@n4nbxido3fme/
Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Cc: stable@vger.kernel.org	[v6.8]
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9..535c907345e0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1303,6 +1303,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
 
+	/*
+	 * The shrinker resumes swap writeback, which will enter block
+	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
+	 * rules (may_enter_fs()), which apply on a per-folio basis.
+	 */
+	if (!gfp_has_io_fs(sc->gfp_mask))
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
 	mem_cgroup_flush_stats(memcg);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-- 
2.44.0


