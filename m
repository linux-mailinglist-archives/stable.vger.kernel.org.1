Return-Path: <stable+bounces-111212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E88A2242D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE517A23E8
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDA14F9FF;
	Wed, 29 Jan 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfp17bwU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42301E0DDF
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176454; cv=none; b=h5LqOZAHAuYmBGLhdBs77zFwmqsBwzU9aw327FX6HfmYkKQp82A/sYnSG/ZEk/ohicWUu1zyiK1ctuZFGo39SLOGpK/ljUELvWmy0jgezFJbVdTgE6zUB7tNxA5CGnI26kjluB8xeo028ffToXYsKasFBVgb6FsPw7nfh4ytMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176454; c=relaxed/simple;
	bh=hUFs2oBVgGDcuPCc21vLNq6bTVZ/j+WnX8LML5jRYRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/+dGt0iMiSx3PY04NB9jsT9U+y27TnlrNxmXHM/mh093TJwGDd54ChqaT9W89uhhN7cT6tdice8xBT6lnf0FT4zzHCF6GF7E2Ca9MLUqHY6uQW/z9W/v4BN+eRHpxYGd7/ORhtRRlPvHLZS5t2sKgyTs7O3mK/BX1Fe+517VNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfp17bwU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so21177555ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176452; x=1738781252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcFQ2H4xSHibS+1TW2DWE8NYoohOksF90h9ceCvjsa8=;
        b=kfp17bwUQJ1vj0h4cpUrsnYhJ3UIwTPtQjxs0n1yRvSn+a9mwnlzqf4TNBuWe9TBy4
         yvNI9nvzy2/iZeaiY1uXKH7adiFLTxI6eFf99+w38xq/ijcA8rjEv4dm+AeNUAtnQMm0
         PhAL7J/1F93kS0J0saQ7u5gZR7QLNirKRV58aVcvMrsfiJWHbyllB7boQ1RKTBb895qR
         uG3nu4Ysc8sEzMP+nOVkz4GYpL1wJ5z+Dsf1gzChykqv279H5fNLSHniBL0uxfD/AurY
         bsHDPfd7GXD3cs4CwfkbQW1nVr5Veyl1fFj9+6y+QUwxEYqL3ud8NqP1xH+mtc0jWXLk
         PnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176452; x=1738781252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcFQ2H4xSHibS+1TW2DWE8NYoohOksF90h9ceCvjsa8=;
        b=hxH1LkJp/tjMjGW+nP7V98JN+5TiQd6Qw/QFCNo+L+I/3+RPZw3wNaBNNNFoOei7QI
         17ULM3AIMyFVd3TswYelICFpIYXIWQeOjtTSC4f74sYkJqV5WvvmLsyVEI3PFncMbq+6
         qSCwLFpQEIsQcYGpw0wPXiedUWibhYJBs7BUhhx93cu+WX2iMU6fZrQ21bMwT6rsxi3E
         W7q1H7j0Fl65udTdw0vxTq2m42Qk2VBvbkKZm+3zHTCiWJoRpgwdYeMG/ElViDJsjy1s
         yp2CfR1TrrwUW2cPjpDYpG58tK1rfRgnjZqVI0iQcySPo/CTLCX2sD+DduRyvaOxxS0T
         rZhw==
X-Gm-Message-State: AOJu0YxhzkVub0IhKppYsnKveBBbaaDuqpCDOz6gcHGX1xSjCb+fyhtM
	vIcYJPCwlCFtbJlb5z97AosG/YIuzFSy/8VqZPNEnxP5HqodVAUAgrezHA==
X-Gm-Gg: ASbGnctKMA4Lm//nYUYh/y2+GTX6a6oPkMaXVrhSNtJ3paiOKJiKea1INgoE5h7maTj
	A2CpYpiTjxOAMTYUmrI86TLR8y7ogdjhG0GdOxX69cIv6L99MsdvnoIdpbYWe6ET4AjYsL9bDac
	uWdXMBtpumdFqy705lS4ppK2gDpsuZGvTphPX4omuRqTgMJtjfuYMKwR4K1wEZPT8CUKZCHckKv
	wPGdUGawS2NecC4U+gXqwuFiZcB38j1O/dBzxUoog8qqJvozIeMQUlIksaMEwpmqZ8UIqsWA1aa
	KRqAvxsJzPUgnxVU2lA6/x1GGQIhVNv20n2Au9DpEwk=
X-Google-Smtp-Source: AGHT+IEhHMACOdqNVU1QOqPRC3PGJ5whIXRaITeVCp40NGYya0z9HoBW7mP2wfnYoIlbXoW4dSgJCw==
X-Received: by 2002:a17:902:c946:b0:216:14fb:d277 with SMTP id d9443c01a7336-21de196fb0amr5827195ad.22.1738176450344;
        Wed, 29 Jan 2025 10:47:30 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:30 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 00/19] xfs 6.1.y fixes from 6.7
Date: Wed, 29 Jan 2025 10:46:58 -0800
Message-ID: <20250129184717.80816-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning to focus on 6.1, here is the 6.1 set from the corresponding
6.6 set:

https://lore.kernel.org/all/20240208232054.15778-1-catherine.hoang@oracle.com/

Two patches are missing from the original set:
[01/21] MAINTAINERS: add Catherine as xfs maintainer for 6.6.y
  6.6.y-only change
[16/21] xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS
  XFS_ONLINE_SCRUB_STATS didn't show up till 6.6

The auto group was run on 10 configs and no regressions were seen.
This has been ack'd on the xfs-stable mailing list.

Thanks,
Leah

Catherine Hoang (1):
  xfs: allow read IO and FICLONE to run concurrently

Cheng Lin (1):
  xfs: introduce protection for drop nlink

Christoph Hellwig (4):
  xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
  xfs: only remap the written blocks in xfs_reflink_end_cow_extent
  xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
  xfs: respect the stable writes flag on the RT device

Darrick J. Wong (8):
  xfs: bump max fsgeom struct version
  xfs: hoist freeing of rt data fork extent mappings
  xfs: prevent rt growfs when quota is enabled
  xfs: rt stubs should return negative errnos when rt disabled
  xfs: fix units conversion error in xfs_bmap_del_extent_delay
  xfs: make sure maxlen is still congruent with prod when rounding down
  xfs: clean up dqblk extraction
  xfs: dquot recovery does not validate the recovered dquot

Dave Chinner (1):
  xfs: inode recovery does not validate the recovered inode

Leah Rumancik (1):
  xfs: up(ic_sema) if flushing data device fails

Long Li (2):
  xfs: factor out xfs_defer_pending_abort
  xfs: abort intent items when recovery intents fail

Omar Sandoval (1):
  xfs: fix internal error from AGFL exhaustion

 fs/xfs/libxfs/xfs_alloc.c       | 27 ++++++++++++--
 fs/xfs/libxfs/xfs_bmap.c        | 21 +++--------
 fs/xfs/libxfs/xfs_defer.c       | 28 +++++++++------
 fs/xfs/libxfs/xfs_defer.h       |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |  3 ++
 fs/xfs/libxfs/xfs_rtbitmap.c    | 33 +++++++++++++++++
 fs/xfs/libxfs/xfs_sb.h          |  2 +-
 fs/xfs/xfs_bmap_util.c          | 24 +++++++------
 fs/xfs/xfs_dquot.c              |  5 +--
 fs/xfs/xfs_dquot_item_recover.c | 21 +++++++++--
 fs/xfs/xfs_file.c               | 63 ++++++++++++++++++++++++++-------
 fs/xfs/xfs_inode.c              | 24 +++++++++++++
 fs/xfs/xfs_inode.h              | 17 +++++++++
 fs/xfs/xfs_inode_item_recover.c | 14 +++++++-
 fs/xfs/xfs_ioctl.c              | 30 ++++++++++------
 fs/xfs/xfs_iops.c               |  7 ++++
 fs/xfs/xfs_log.c                | 23 ++++++------
 fs/xfs/xfs_log_recover.c        |  2 +-
 fs/xfs/xfs_reflink.c            |  5 +++
 fs/xfs/xfs_rtalloc.c            | 33 +++++++++++++----
 fs/xfs/xfs_rtalloc.h            | 27 ++++++++------
 21 files changed, 310 insertions(+), 101 deletions(-)

-- 
2.48.1.362.g079036d154-goog


