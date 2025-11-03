Return-Path: <stable+bounces-192150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE4C2A6C8
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 08:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DA1892139
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A52BE64C;
	Mon,  3 Nov 2025 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="P02YbIPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F72C0283
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156376; cv=none; b=tWrheOkrOjJdOch+3Xw17oRxnH76/iuFHTKyRBnc7K8L47puqpjfoNIwdXJHw+ic548riniPoOqcUdDRP+H5K73NDdr66d+3A4535tUspDmgyul/UIYYo55DHQbVvUKsSvYD3EYmyHq3pYlfc9yU500EdDnHvwe6wByJIXJkJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156376; c=relaxed/simple;
	bh=CpM3LvhKwcp4J4lDv8ipejSSGm/KKdsoaJfd2VI7DlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVhEI9i0hLqLHEMnON4L70qrvyOjhXX4NQ/wfoHz/hk94zy+k6nt9VT+AkTq3SlfThlC3Oag8rvLLKdWvMkyJqHpy0kaDn1nL8hyDFokZCmnXonsnNQ3StOtHrbOpT8rxMiI4SIbzldA+ep7Qf0c0NvLyJdmbQSKl51v/h63F90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=P02YbIPl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33255011eafso3460336a91.1
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156374; x=1762761174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLkzhtoF4Ahv1FKwU/tjbCnsdl0esqhckJcQdc+yB8A=;
        b=P02YbIPl/Elwc5XdXXFspjWAfPg6E4vbH9mgSZge3KREFOcZr/MNJA82NKKJyS338Z
         LEnkiaHbasz2Fplbs+EoUKBUJrqt1Bi2+dcsHy/Dyz7TaULvbCiBj4rsUhsLH7XA++Hh
         YBP7YOFusXY/eEKcUjF3IVm0eFRtUA1cOiFN9pXBhDLIZYj57IyTsonh86wS2FtdBQJK
         HbBfMT1shzBp08qQc+LJZiNr9A1TeSy2uaOnkKH3x8YkfdLHiry7MGlcErQ1FZXAQ4RK
         Q63kHw12o0VeSBnmWop/HSU5j06e2oXuBqUQUo1hfBDBxaMLAWdtDX+LvIU1O+Bu9FHC
         yjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156374; x=1762761174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLkzhtoF4Ahv1FKwU/tjbCnsdl0esqhckJcQdc+yB8A=;
        b=vUurazhR2DcGWXTWsuP2Wvo/JLZe69yQnnjHT/oPta/BUtb7fFPAawba0icS0U+ciy
         jFmOQfdL8FVR8C7hWV4n8/lo8JAVdOmOL+pWYTcto/GP9gXGokjJyjTtmn6DyOWUA2tn
         FAY+0t33K39qfeB9FuQ50yn3cUynf0b3KqgJnSBSyTfWHTOgGW69wHRxoWHxV7VCKxwg
         qhO6zxqf7UjYLRQgOHSPB3EiWO4YOjnUuRfj2Akyu2k5zZVl4I4H5JAnM+AT9e146qIJ
         edec8qjNx8X8WT/dTmvqM7VuCySS2Csw6gxDf1A+SL5b18MiNGjZbDpbTHpy7MDrvDHZ
         vaWg==
X-Gm-Message-State: AOJu0YywgsXuy+DVb9iIXCEnT1nt26C1aCJmkYtsgTE8U4kRimKbL/Ak
	olwL3PCCzbFTpeN2Y8+g7GcIeEyQJd/lLXJemJs3+MXTzcarLtaxOnT5pKjVFY3B4K6I2Q8nbYv
	k19fJjovFwSOzcf70Gw42BUJ5b8bGlpGB+0ZR9edu6vQrhtp+K3jKzLPqmViWY/+1/uB2pFIyTk
	aFF7Ir66LWtwAeWmALl4p9QYzlKg4eGEw3XVyP/6gED7ujG3M1xxw=
X-Gm-Gg: ASbGncsxehhmf204mVG5TNxr7HHP33tuQEWQqc7NV0sVMEQxPJpSM78FlZqxaKs9mso
	WLAt1q5xPIBvx2j4Qnsm/lBui4iM6tbgzPQDTlfeOmJqBqnDktHu8pxfMFJp1BGZ6TqJY6hCQu/
	gyRTYD9XtYFTDjUJJjuW06a9fndXFoyffABPivSaTSQ2STi646F8odf8mQVaF4QUBootIzLMVpg
	PnbCZ/L8/9aj7SFzjtSAlPaR9Das9N4pTViXEVBmNqDy0VUc5I67cHzJEAHJWJTRhu9sl08WjP0
	NR/qWWaYS4QWY6XUjTuEtAziXnCwGoqbzCzwW9KhAIQXugcUoMjBTN4YHZzTw4eellZBconP/56
	DBMQ1RLkQ4uyPala9VfHJZxYlBDLzZIHngB/lDeO9judW5M/xqB7ueB3rObSvtejPaQtAVd8VlI
	SVVBJo23pztLCdN01K0LK/xEN9
X-Google-Smtp-Source: AGHT+IFmmflmrHgmAEotptMvyKECeXV6WQu6qDa1mCLOci2pV13NrALFzKLJadVhnxzhUmSBh4pxng==
X-Received: by 2002:a17:90b:1c06:b0:341:2150:4856 with SMTP id 98e67ed59e1d1-341215049b9mr3820496a91.17.1762156373781;
        Sun, 02 Nov 2025 23:52:53 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:52:53 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 0/7] mm: memcg: subtree stats flushing and thresholds
Date: Mon,  3 Nov 2025 15:51:28 +0800
Message-ID: <20251103075135.20254-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed failures in the 'memcontrol02' test case from the Linux Test
Project (LTP) [1] when running on a 256-core server with the 6.6.y kernel.
The test fails due to stale memory.stat values being returned, which is
caused by the current stats flushing implementation's limitations with large
core counts.

This series backports the memcg subtree stats flushing improvements from
Linux 6.8 to 6.6.y to address the issue. The main goal is to restore
per-memcg stats flushing with dynamic thresholds, which improves both
accuracy and performance of memory cgroup statistics, especially on
high-core-count systems.

Background
==========

The current stats flushing in 6.6.y flushes the entire memcg hierarchy with
a global threshold. This is not efficient and can cause stale stats when read
'memory.stat'.

Dependency Patches
==================

Patches 1-2 are dependencies required for clean application of the main
series:

Patch 1: 811244a501b9 "mm: memcg: add THP swap out info for anonymous reclaim"

  This patch adds THP_SWPOUT and THP_SWPOUT_FALLBACK entries to the
  memcg_vm_event_stat[] array. It is needed because patch 4 (e0bf1dc859fd)
  moves the vmstats struct definitions, including this array. Without this
  patch, the array structure would not match between 6.6.y and 6.8, causing
  context conflicts during cherry-pick.

  The patch is already in mainline (merged in v6.7) but was not included in
  the stable 6.6.y branch.

Patch 2: 7108cc3f765c "mm: memcg: add per-memcg zswap writeback stat"

  This patch adds the ZSWPWB entry to the memcg_vm_event_stat[] array. Like
  patch 1, it is required for patch 4 to apply cleanly. The array structure
  must match the 6.8 state for the code movement to succeed without
  conflicts.

  This patch is also in mainline (merged in v6.8) but was not backported to
  6.6.y.

Main Series
===========

Patches 3-7 are the core memcg stats flushing improvements:

- Patch 3: Renames flush_next_time to flush_last_time for clarity
- Patch 4: Moves vmstats struct definitions for better code organization
- Patch 5: Implements per-memcg stats flushing thresholds (key change)
- Patch 6: Moves stats flush into workingset_test_recent()
- Patch 7: Restores subtree stats flushing (main feature)

Cherry-Pick Notes for Patch 7
==============================

Patch 7 (7d7ef0a4686a) requires manual conflict resolution in mm/zswap.c:

The conflict occurs because this patch includes changes to zswap shrinker
code that was introduced in Linux 6.8. Since this new shrinker
infrastructure does not exist in 6.6.y, the conflicting code should be
removed during cherry-pick.

Resolution: Keep the 6.6.y (HEAD) version of mm/zswap.c and discard the
new shrinker code from the patch. The conflict markers will show:

  <<<<<<< HEAD
  // existing 6.6.y code
  =======
  // new 6.8 shrinker code (shrink_memcg_cb, zswap_shrinker_scan, etc.)
  >>>>>>> 7d7ef0a4686a

Simply keep the HEAD version and remove everything between the "======="
and ">>>>>>>" markers. This is safe because the zswap shrinker is a
separate new feature, not a dependency for the memcg stats changes.

Additionally, if you encounter a conflict in mm/workingset.c, it may be
due to commit 417dbd7be383 ("mm: ratelimit stat flush from workingset
shrinker") which was backported to 6.6.y. The resolution is to use:
  mem_cgroup_flush_stats_ratelimited(sc->memcg)
which preserves the performance optimization while using the new API.

Testing
=======

This series has been extensively tested upstream with:
- 5000 concurrent workers in 500 cgroups doing allocations and reclaim
- 250k threads reading stats every 100ms in 50k cgroups
- No performance regressions observed with per-memcg thresholds

The changes improve both stats accuracy and reduce unnecessary flushing
overhead.

References
==========

[1] Linux Test Project (LTP): https://github.com/linux-test-project/ltp

Domenico Cerasuolo (1):
  mm: memcg: add per-memcg zswap writeback stat

Xin Hao (1):
  mm: memcg: add THP swap out info for anonymous reclaim

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 Documentation/admin-guide/cgroup-v2.rst |   9 +
 include/linux/memcontrol.h              |   8 +-
 include/linux/vm_event_item.h           |   1 +
 mm/memcontrol.c                         | 266 +++++++++++++-----------
 mm/page_io.c                            |   8 +-
 mm/vmscan.c                             |   3 +-
 mm/vmstat.c                             |   1 +
 mm/workingset.c                         |  42 ++--
 mm/zswap.c                              |   4 +
 9 files changed, 203 insertions(+), 139 deletions(-)

--
2.50.1

