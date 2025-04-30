Return-Path: <stable+bounces-139227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168FEAA5759
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF09A11E6
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCF2D028C;
	Wed, 30 Apr 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb42baxz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE272C10B8
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048433; cv=none; b=mbZjXm+AhhJ9fKEaiZFi0CnmHsDAlEYUD/ZHohkpy8szo3cdBXRsz8NkByBiKAJ/17QpoakSe+7JRZGULLX2jybX7XVwGvy9kiaddErR/KlsMtDzW+dtjbUZJQd7KrN6xp1hXFW5eZ6M1pauQC8/ie5GGm0botw2ifcLe4pnIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048433; c=relaxed/simple;
	bh=2VmxR8DUk4bg3leBrmAV8n+g/b89RP52nhbhS3PsfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNiHKHh2MHekFzhS/LwYLzjIMWUMpaEc2i6mIWfy9xAJFhmiCHDGNGSDrrxQvtawSrVeqjeeShkiJT12igu7ctiVG0HZL5ySGFa274tDqXgjeH1vE13tz6Hekqstjy+pXMoYBOc+heInGGpT8B6b6pzW+noW139S3G2GB3BdRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb42baxz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so556926b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048430; x=1746653230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIOI8XJKO+wrAR2bc03MegjZ/Yan8y7FrHM3XesABs0=;
        b=Xb42baxz/021Ryj3DFTmdbXHJtv0I75Qdb7bkwKUSbtIAFswp+TPbQYV5d2BKW/MMH
         jQRcXwd483cMvLWsu7jYpcxsD0ZqFDuD9Tnng2qtWVfeK3I7eR8g76BtQmGxpXcTjBLU
         r/IUKgZRu4hSgohP3QI1X2QTqbwLgzbfivmQ7jegmFAvIHT4OqCh5/Bv3VAfPw9jKY2C
         JKZIKxui/XULSCZdcRs4jzhE3eLWT9qfL6HVzwj2dqagAP5TV5glne3Z7z9PpehhONeG
         /d6qDicPGCLHYLTVCd1n3PQW2KXSkziVSU464iiLEvdVk4/cumzS9UccKE1vAjuKILZm
         /xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048430; x=1746653230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIOI8XJKO+wrAR2bc03MegjZ/Yan8y7FrHM3XesABs0=;
        b=kZjnKFI95i5bZORB9O6rIg6UT4zWqMrttI6duY7Rh78ah8P+c/8Phd6YBURtjyouKh
         FOKDd80AfAKtIFK/NkFubyusnKkWXeVQ4B/2z4tZMdMrxshhZs7V8ZgLbL82RWCt/BYa
         HeTdmaTN8olRjMMfAZLr1VIkjABzH55OG0JpLek7cwivNObdVkUvfxvqhOtIjbtAFgdz
         4LQzkfWccTgcXWOUKzbwd540pA6TNxV2Mulg6NcH2UAWS9OzTmz98tW1cExqepS3fYWg
         0USgvFK0V2Q+uM8Wn9bljwTDT23wZ9xZKHWlM+vmXpRPewTxLJgHJwlILXRG7kbQXYDG
         tObw==
X-Gm-Message-State: AOJu0Ywu5RrXPLRIF6G78rKBaMqZma2CneUfI/FRJ+DsMZCnzSK5HPz1
	GMRVCFG0OIZ7ZwxbfAccpfnF5mvVLfzhEtCSRovKQrkUb6ACEwKMEXp0vQ==
X-Gm-Gg: ASbGncthgBrlFmtGe100syu4WPSIZSc+hXpJjxx0FhUiEF6YI946NThUf/7YRBd4h72
	g0PAfQESCpjCNoVCEMzU1y/bnXgWjZpGST2Oii1iPTP6Pt7PYVftP58T3XvlhlSRFpuohvVTziA
	gf+eUNWAcyklXhPT3mZLmSCm1ZwTFJIjp/oJ2Wxp4LiizYkDX+uUCPmWiXupgU8JI5pol0Qb1ed
	pC2aFARx7bBv3Ue+6Pq2LtiahaOmvfMojW+SCnK1kZMzLXPz/vMH8ICmDWKGRbwYPrr95/JBNoT
	K/bFr62clOfJDvUIIHISIGY6NGTHu7qqI3tBSjCYvwbr24ULSgFlB2OzjFoBQGhV7gFo
X-Google-Smtp-Source: AGHT+IH1VwEirK4jGRF4mUw/Jkvtlrpq1n6aSr/D5YGPViVCC96OaN4GJPKvlSkwf3T55scvY9ndBg==
X-Received: by 2002:a05:6a00:3915:b0:736:3768:6d74 with SMTP id d2e1a72fcca58-740491c9454mr66782b3a.7.1746048430545;
        Wed, 30 Apr 2025 14:27:10 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:10 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 00/16] xfs backports for 6.1.y from 6.10
Date: Wed, 30 Apr 2025 14:26:47 -0700
Message-ID: <20250430212704.2905795-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again,

This is the 6.1.y backports set from 6.10 which corresponds to the 6.6.y
backports set from here:

https://lore.kernel.org/all/20241002174108.64615-1-catherine.hoang@oracle.com/


The following patches were included:

f43bd357fde0 xfs: fix error returns from xfs_bmapi_write
4bcef72d96b5 xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
c299188b443a xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
c13c21f77824 xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovey
0934046e3392 xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
9716cdcc2f9e xfs: validate recovered name buffers when recovering xattr items
20adb1e2f069 xfs: revert commit 44af6c7e59b12
f24ba2183148 xfs: match lock mode in xfs_buffered_write_iomap_begin()
0f726c17dfd8 xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
36081fd0ee37 xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
4c99f3026cf2 xfs: convert delayed extents to unwritten when zeroing post eof blocks
0aca73915dc1 xfs: allow symlinks with short remote targets
0e52b98bf041 xfs: make sure sb_fdblocks is non-negative
2bc2d49c36c2 xfs: fix freeing speculative preallocations for preallocated files
3eeac3311683 xfs: allow unlinked symlinks and dirs with zero size
9a0ab4fc28ed xfs: restrict when we try to align cow fork delalloc to cowextsz hints


The following patches were omitted:

cad051826d83 xfs: fix missing check for invalid attr flags
  scrub
db460c26f0b0 xfs: check shortform attr entry flags specifically
  scrub
5689d2345a01 xfs: enforce one namespace per attribute
  doesn't cherry pick cleanly, it is some refactoring and isn't a
  dependency for other patches, lets skip it for now
7c03b124353a xfs: use dontcache for grabbing inodes during scrub
  scrub
740a427e8f45 xfs: fix unlink vs cluster buffer instantiation race
  already in 6.1.y


No fixes were found on mainline for any of the patches being ported.

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

and no regressions were seen. This set has already been ack'd on the
xfs-stable list.

Let me know if you see any issues. Thanks,
Leah


Christoph Hellwig (4):
  xfs: fix error returns from xfs_bmapi_write
  xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
  xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
  xfs: fix freeing speculative preallocations for preallocated files

Darrick J. Wong (7):
  xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item
    recovery
  xfs: check opcode and iovec count match in
    xlog_recover_attri_commit_pass2
  xfs: validate recovered name buffers when recovering xattr items
  xfs: revert commit 44af6c7e59b12
  xfs: allow symlinks with short remote targets
  xfs: allow unlinked symlinks and dirs with zero size
  xfs: restrict when we try to align cow fork delalloc to cowextsz hints

Wengang Wang (1):
  xfs: make sure sb_fdblocks is non-negative

Zhang Yi (4):
  xfs: match lock mode in xfs_buffered_write_iomap_begin()
  xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
  xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
  xfs: convert delayed extents to unwritten when zeroing post eof blocks

 fs/xfs/libxfs/xfs_attr_remote.c |   1 -
 fs/xfs/libxfs/xfs_bmap.c        | 130 ++++++++++++++++++++++++++------
 fs/xfs/libxfs/xfs_da_btree.c    |  20 ++---
 fs/xfs/libxfs/xfs_inode_buf.c   |  47 ++++++++++--
 fs/xfs/libxfs/xfs_sb.c          |   7 +-
 fs/xfs/scrub/attr.c             |   5 ++
 fs/xfs/xfs_aops.c               |  54 ++++---------
 fs/xfs/xfs_attr_item.c          |  88 ++++++++++++++++++---
 fs/xfs/xfs_bmap_util.c          |  61 +++++++++------
 fs/xfs/xfs_bmap_util.h          |   2 +-
 fs/xfs/xfs_dquot.c              |   1 -
 fs/xfs/xfs_icache.c             |   2 +-
 fs/xfs/xfs_inode.c              |  14 +---
 fs/xfs/xfs_iomap.c              |  81 +++++++++++---------
 fs/xfs/xfs_reflink.c            |  20 -----
 fs/xfs/xfs_rtalloc.c            |   2 -
 16 files changed, 342 insertions(+), 193 deletions(-)

-- 
2.49.0.906.g1f30a19c02-goog


