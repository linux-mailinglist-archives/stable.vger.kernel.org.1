Return-Path: <stable+bounces-124357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A6A60287
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6311519C5775
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA851F3B83;
	Thu, 13 Mar 2025 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+krOPyX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F81F3FEE
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897565; cv=none; b=XBGyD3UWRErDk9sbVC13dQEYDHc7OsSOlk+Fheo52/x3K99+OmF0EqWM1K/xcHAsa47MrAgwXweFufWJIsWLuWCtY/H2+T8GTJdxOWmMmDSQ0D85GrX61M/4gfoQhT/QBUYQ1LRih5im1Rqk9WEZKVpGFt1Hr3OC2kvO+QKRz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897565; c=relaxed/simple;
	bh=n65w63Pn8a8ZPvvRmbbA3lVs68WJb1VMw7ze3lEDbu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WM8/cNnq2mZdzkssZTJArTS0dYWJKJq5J2HCazlQBu0ZhC/lCPqi4kA1NwVO6j+7mszf7/g3oVuj2isb29yBSdqoaah4Kh/wASFStgfwMrPBR9qOosg3EllhHgCQwClIS8RnuwGGq9+shkdDGQjoduGPWd0nyQlZsp669uUV35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+krOPyX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225b5448519so27101545ad.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897563; x=1742502363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwptnSzti0LHBS1myyqGDwkapJcuW3ZTYCe93oWXXaI=;
        b=m+krOPyX7D052VpFWA3D1krzo+5KWvo56lFwb5aKoGA/YRZ6g2g2oIHHiyowbkC3c7
         qDTuOjwP4t1VCO6nmVjcoZVD43/xFvbXmonz88JYVN3tRepH/VxZaw8UV+DeJiETG/fN
         2PksNQLTYc1jBu/G9bfjGktHZ4xHQ6nO4bcuwwm3b/UpJjszF+PKx4GUqT+bmJq8SOZ3
         uWzDskX4nWzWorOfjysIze4sj4TOuM/3Nm+nzWssO8pzChG+HOzeTVpal7VoPvHGLQs8
         bBZMl6d8bljhOrmJkKKDGqhFPKZaByh/IDHmSvLqSyyeoC87ZgajdIVyC05D8w72CriM
         CGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897563; x=1742502363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwptnSzti0LHBS1myyqGDwkapJcuW3ZTYCe93oWXXaI=;
        b=GmRzaj6iVP+YKMALiWA153mNzNbquxP2/9YtV7EVkVqYtF7vaLl9KHhWsA6teomh1V
         RZ7o6s1Mz3UNAsE7q6bDopb32ImIwJlCpwoehKo23HzqktJ/lpuJ8eQwTqrp0Ig1/mpX
         bbV8afqT51aCDGRttmVHFFM43++/VE1MA4tGKBvgCaaoEdDXc8GDmvotULOxvRtG04ZM
         jfDj32vB2zfxPj3YM/gsertHhp+ThEsvffD6+3SElAvEh62jEJR/ggyovlqHn0uxHkZh
         LwFBb60MFeejfXfzKSgqdg4NFYvH/LSVYmfYbwYWX32HFi3hOGliNIT+kxQTQ2uXtMUv
         VMeQ==
X-Gm-Message-State: AOJu0Ywprg1ih30YAN0FA4UviNaEzlGRta9x6bDMXOI2TdhqQREe31Z2
	NqSZWD2XhRdEBSVCecwOHPTzZ+UHF5P3Oq99dNa2UqYPR/xzgOZP/MToWg==
X-Gm-Gg: ASbGnct88Kb+RrCbggjB+FQthRdAgYRnnGyaKx6HbQJAb1g/GbODbncHx+rXdck9nU5
	UR/Sq8Nu2994QSRuE0pfyuaqrFhviYqmKHa8t5/n3nIASuNht7CKpHdKEHpiQlmXXuOTHJ6EsFf
	AdcgDBLHWxAVQhkBBemwPBw3hMoocEZjy/39xkMyfDKsFN58P2v28T4eOFat+1q3tyfBtTpJA2G
	fte2UxE14/c5tdA0wHmA5rz1ym3x7RJVk6OD9mEfeH4ghf0WLYYrmK0jceKXjLtiJ5/t2A3CI69
	6R97oSrcLH240P6BR23y+TOUZJ2W+ltpSxcR1runG8+a3/459LjV9wCMDPbIrRwS03w1rfA=
X-Google-Smtp-Source: AGHT+IHeZw9hW66HjaUJdvbp/lfHywTp4STi1jcmzObEKQBcA9OCnovfTfxT5TVkaKFGgKObWP0ztQ==
X-Received: by 2002:a05:6a20:a104:b0:1f5:8f65:a6f5 with SMTP id adf61e73a8af0-1f5c12d76d8mr62377637.30.1741897562571;
        Thu, 13 Mar 2025 13:26:02 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:02 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 00/29] patches for 6.1.y from 6.8
Date: Thu, 13 Mar 2025 13:25:20 -0700
Message-ID: <20250313202550.2257219-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

(This series has already been ack'd on the xfs-stable mailing list.)

Here is the 6.1.y series corresponding to the 6.6.y series for 6.8
(https://lore.kernel.org/all/20240325220724.42216-1-catherine.hoang@oracle.com/#r).

Descrepancies between the patch series are as follows...

The following were added as dependencies (9 patches):

0b11553ec54a6d88907e60d0595dbcef98539747
xfs: pass refcount intent directly through the log intent code
(v6.3-rc1~142^2~5)

72ba455599ad13d08c29dafa22a32360e07b1961
xfs: pass xfs_extent_free_item directly through the log intent code
(v6.3-rc1~142^2~9)

578c714b215d474c52949e65a914dae67924f0fe
xfs: fix confusing xfs_extent_item variable names
(v6.3-rc1~142^2~8)

ddccb81b26ec021ae1f3366aa996cc4c68dd75ce
xfs: pass the xfs_bmbt_irec directly through the log intent code
(v6.3-rc1~142^2~11)

b2ccab3199aa7cea9154d80ea2585312c5f6eba0
xfs: pass per-ag references to xfs_free_extent
(v6.4-rc1~80^2~22^2~3)

7dfee17b13e5024c5c0ab1911859ded4182de3e5
xfs: validate block number being freed before adding to xefi
(v6.4-rc6~19^2~1)

fix of 7dfee17b13e:
2bed0d82c2f78b91a0a9a5a73da57ee883a0c070
xfs: fix bounds check in xfs_defer_agfl_block()
(v6.5-rc1~44^2~10)

b742d7b4f0e03df25c2a772adcded35044b625ca
xfs: use deferred frees for btree block freeing
(v6.5-rc1~44^2~16)

3c919b0910906cc69d76dea214776f0eac73358b
xfs: reserve less log space when recovering log intent items
(v6.6-rc3~13^2~5^2)


And the following were skipped for 6.1.y (4 patches):

fb6e584e74710a1b7caee9dac59b494a37e07a62 (scrub)
xfs: make xchk_iget safer in the presence of corrupt inode btrees

c0e37f07d2bd3c1ee3fb5a650da7d8673557ed16 (scrub)
xfs: fix an off-by-one error in xreap_agextent_binval

b9358db0a811ff698b0a743bcfb80dfc44b88ebd (scrub)
xfs: add missing nrext64 inode flag check to scrub

84712492e6dab803bf595fb8494d11098b74a652 (already in 6.1.y)
xfs: short circuit xfs_growfs_data_private() if delta is zero


The auto group was run 1x on each of these configs:

xfs/4k
xfs/1k
xfs/logdev
xfs/realtime
xfs/quota
xfs/v4
xfs/dax
xfs/adv
xfs/dirblock_8k

and no regressions were seen.

Let me know if you see any issues. Thanks,
Leah


Andrey Albershteyn (1):
  xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Christoph Hellwig (1):
  xfs: consider minlen sized extents in xfs_rtallocate_extent_block

Darrick J. Wong (19):
  xfs: pass refcount intent directly through the log intent code
  xfs: pass xfs_extent_free_item directly through the log intent code
  xfs: fix confusing xfs_extent_item variable names
  xfs: pass the xfs_bmbt_irec directly through the log intent code
  xfs: pass per-ag references to xfs_free_extent
  xfs: reserve less log space when recovering log intent items
  xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
  xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
  xfs: don't leak recovered attri intent items
  xfs: use xfs_defer_pending objects to recover intent items
  xfs: pass the xfs_defer_pending object to iop_recover
  xfs: transfer recovered intent item ownership in ->iop_recover
  xfs: make rextslog computation consistent with mkfs
  xfs: fix 32-bit truncation in xfs_compute_rextslog
  xfs: don't allow overly small or large realtime volumes
  xfs: remove unused fields from struct xbtree_ifakeroot
  xfs: recompute growfsrtfree transaction reservation while growing rt
    volume
  xfs: force all buffers to be written during btree bulk load
  xfs: remove conditional building of rt geometry validator functions

Dave Chinner (4):
  xfs: validate block number being freed before adding to xefi
  xfs: fix bounds check in xfs_defer_agfl_block()
  xfs: use deferred frees for btree block freeing
  xfs: initialise di_crc in xfs_log_dinode

Jiachen Zhang (1):
  xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Long Li (2):
  xfs: add lock protection when remove perag from radix tree
  xfs: fix perag leak when growfs fails

Zhang Tianci (1):
  xfs: update dir3 leaf block metadata after swap

 fs/xfs/libxfs/xfs_ag.c             |  45 ++++++++---
 fs/xfs/libxfs/xfs_ag.h             |   3 +
 fs/xfs/libxfs/xfs_alloc.c          |  70 ++++++++++-------
 fs/xfs/libxfs/xfs_alloc.h          |  20 +++--
 fs/xfs/libxfs/xfs_attr.c           |   6 +-
 fs/xfs/libxfs/xfs_bmap.c           | 121 ++++++++++++++--------------
 fs/xfs/libxfs/xfs_bmap.h           |   5 +-
 fs/xfs/libxfs/xfs_bmap_btree.c     |   8 +-
 fs/xfs/libxfs/xfs_btree_staging.c  |   4 +-
 fs/xfs/libxfs/xfs_btree_staging.h  |   6 --
 fs/xfs/libxfs/xfs_da_btree.c       |   7 ++
 fs/xfs/libxfs/xfs_defer.c          | 103 +++++++++++++++++-------
 fs/xfs/libxfs/xfs_defer.h          |   5 ++
 fs/xfs/libxfs/xfs_format.h         |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c         |  24 ++++--
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   6 +-
 fs/xfs/libxfs/xfs_log_recover.h    |  27 +++++++
 fs/xfs/libxfs/xfs_refcount.c       | 116 +++++++++++++--------------
 fs/xfs/libxfs/xfs_refcount.h       |   4 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   9 +--
 fs/xfs/libxfs/xfs_rtbitmap.c       |   2 +
 fs/xfs/libxfs/xfs_rtbitmap.h       |  83 ++++++++++++++++++++
 fs/xfs/libxfs/xfs_sb.c             |  20 ++++-
 fs/xfs/libxfs/xfs_sb.h             |   2 +
 fs/xfs/libxfs/xfs_types.h          |  13 +++
 fs/xfs/scrub/repair.c              |   3 +-
 fs/xfs/scrub/rtbitmap.c            |   3 +-
 fs/xfs/xfs_attr_item.c             |  30 +++----
 fs/xfs/xfs_bmap_item.c             |  99 ++++++++++-------------
 fs/xfs/xfs_buf.c                   |  44 ++++++++++-
 fs/xfs/xfs_buf.h                   |   1 +
 fs/xfs/xfs_extfree_item.c          | 122 ++++++++++++++++-------------
 fs/xfs/xfs_fsmap.c                 |   2 +-
 fs/xfs/xfs_fsops.c                 |   5 +-
 fs/xfs/xfs_inode_item.c            |   3 +
 fs/xfs/xfs_log.c                   |   1 +
 fs/xfs/xfs_log_priv.h              |   1 +
 fs/xfs/xfs_log_recover.c           | 118 +++++++++++++++-------------
 fs/xfs/xfs_refcount_item.c         |  81 +++++++++----------
 fs/xfs/xfs_reflink.c               |   7 +-
 fs/xfs/xfs_rmap_item.c             |  20 ++---
 fs/xfs/xfs_rtalloc.c               |  14 +++-
 fs/xfs/xfs_rtalloc.h               |  73 -----------------
 fs/xfs/xfs_trace.h                 |  15 +---
 fs/xfs/xfs_trans.h                 |   4 +-
 45 files changed, 782 insertions(+), 575 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_rtbitmap.h

-- 
2.49.0.rc1.451.g8f38331e32-goog


