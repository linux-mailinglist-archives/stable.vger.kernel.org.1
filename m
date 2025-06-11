Return-Path: <stable+bounces-152454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2CAD6087
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709533AA6D8
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BD2417C8;
	Wed, 11 Jun 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvwx0D5F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6D1EB39
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675695; cv=none; b=XsCdpXtTXcNdYOiLNRx0TegHJuQXJ02u1wbkiCnyqRSWXHofoXmt/v+jbT582EErhZFfY/GiD9hTkaK4ZYnEOYvSPVjkVIlClDM45c5M6ptJ+S0KxqH8Yf256ta9U15QLariSxdgOolwSD9SOA1zqikCIb0Q37KhPrHDmrqYdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675695; c=relaxed/simple;
	bh=QIZ14O/av9Hh6a8aEZhwwdgkmJmeVpxMbJqCgjePWZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5MS64tQJpbb0QYHXmydPNpZBC0P8YH45g4dHa4HofZyYJYQqloRZ03SvRVbL1JWMq20d0KL7hP5ZKOZb+Majww+fXKzvSynKztR9GVKS9Jd6nw6toVBtCobE1DTbEvXeHA2Rj979WNH4obcp6vm+qYR4R6tf0gBYBtyouyEQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvwx0D5F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2360ff7ac1bso2352405ad.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675693; x=1750280493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEvOqs/DY9yH+N4DXxBYqNiYhglU+EygkNV2dP+EJqk=;
        b=Kvwx0D5FoL4+dZzf0gX09+qZpPe3NR1eQOn7xmE0e7lyAToYlMQeG32rcMk1yryxvn
         k9eMmOerb9BOkfIEMA5kAghGk3YI7Klc7l8rxCU+AaJvTNkVHJHMyD2r2vv4bXUBo271
         YwVlFJ6XzIMH+LsPEJh/gCOJoep5nqYJG2ghkl/Q1DwAg4GakFyEtjWRA2kYl3fA2cyF
         GHvIX9sjE+tPYO+dZYQ2+U5B92wwr5BybZaMyRxDvKgQ1UCCv1AtOvalhCkzjA2UDkeU
         x95sT/bv9ItxnV3Gly+m7YpUBLS6vu3I4e8JnRVk/KaM8qKzm30FYFB9z/1Z/McCqEc6
         qCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675693; x=1750280493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEvOqs/DY9yH+N4DXxBYqNiYhglU+EygkNV2dP+EJqk=;
        b=Nrngi1Nsu83Iws+jZCp6T9jcFJ35cGsAyibLLBGCqv6OB+bbg12Nv8a3u3fzHYsqcI
         HiOktvRiGfjgzjOAgZAnxE2Ocg/gQ7wKUKp+Ge94pHc2b8T+L9Bdhlx3Iuj5bjPf/mGN
         VNiiWuX/xCQLSoAX2CGuakApvwARInNmYhDwUNEmOxLOvVSveoxqnA9GkE3MazH1Jz75
         /Gf13E2BgjzgTeJYGQiIhHPv328gk0BVXI1PF/8CN5ahkrs+4oaqMiaorrVesjcJ65BG
         gCMwjebabYQpqyBExyfxW7AwvaBiVNwSVTjs5bkjx7MzeYDwj7uRedLj9nLXdaLfKVEZ
         H13Q==
X-Gm-Message-State: AOJu0YygcMcjdtD5/GkCJoT3CSMVdUS/QGx77v5ctTNU4fO79ih+1h6t
	H9udKd4FxO1NNSQlS2IoGF2Pq53YPbD+6lV/zS0KsdXm87frsD7N0ZlZkexa4x3H
X-Gm-Gg: ASbGncvYHpzr/awzAx7pm/Xdeo3O1lkqcsm3+PEO3r+E58V9y2Yx9XaW7mYbiK21xvq
	5EXoqGU19vSfGlIOC3q6xqZAiyB5UgcqWRKfKGuXwl6e48HZNsFpIgZMINXLCATmHu/KxO/vAkV
	89/TrmwJE/4KX6JUHEQa7Z2s6ExJfjNjjJunFQ4EWW7nXuMG/Ur3T5TZD3Bn6EBxtSbPypSkYSh
	hfbKlKX5TrczLRnb131bgSOU9k9f0uj6jxOif9nB0053XvYW5+HLEbMIh+zeoGCWibtVs/RgzLN
	ODXAOaEu7vg0z/MmN37/z9xKt+LTrWww27pZjpqSWFZApUZnPFvwBZ/suzXnhYcEwzhilc6vI1i
	J138gKyLts3E=
X-Google-Smtp-Source: AGHT+IHVhA2GCNEkxpyiyhYQYf/ZyiE30le+QRamMDd1/aHYruG4Bxb7puPlHAoO7e52YO+tvMZ6Lw==
X-Received: by 2002:a17:902:fc4b:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23641abe7d9mr68059805ad.21.1749675692880;
        Wed, 11 Jun 2025 14:01:32 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:32 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 00/23] fixes from 6.11 for 6.1.y
Date: Wed, 11 Jun 2025 14:01:04 -0700
Message-ID: <20250611210128.67687-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again,

This is a series for 6.1.y for fixes from 6.11. It corresponds to the
6.6.y series here:
https://lore.kernel.org/linux-xfs/20241218191725.63098-1-catherine.hoang@oracle.com/

During porting, I noticed 6.1.y was missing a fix series from 6.5
that is a dependency of the fixes from 6.11 so I included those
first.

These were tested via the auto group on 9 configs with no regressions
seen. These were also already ack'd on the xfs-stable mailing list.

series from 6.5:
https://lore.kernel.org/linux-xfs/168506055189.3727958.722711918040129046.stgit@frogsfrogsfrogs/
63ef7a35912d xfs: fix interval filtering in multi-step fsmap queries
7975aba19cba xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
d898137d789c xfs: fix getfsmap reporting past the last rt extent
f045dd00328d xfs: clean up the rtbitmap fsmap backend
a949a1c2a198 xfs: fix logdev fsmap query result filtering
3ee9351e7490 xfs: validate fsmap offsets specified in the query keys
75dc03453122 xfs: fix xfs_btree_query_range callers to initialize btree rec fully

fix of 63ef7a35912dd ("xfs: fix interval filtering in multi-step fsmap queries")
https://lore.kernel.org/linux-xfs/169335025661.3518128.12423331693506002020.stgit@frogsfrogsfrogs/
cfa2df68b7ce xfs: fix an agbno overflow in __xfs_getfsmap_datadev

6.6 series for 6.11:
https://lore.kernel.org/linux-xfs/20241218191725.63098-1-catherine.hoang@oracle.com/
85d0947db262 xfs: fix the contact address for the sysfs ABI documentation
c08d03996cea xfs: verify buffer, inode, and dquot items every tx commit
ff627196ddc1 xfs: use consistent uid/gid when grabbing dquots for inodes
7531c9ab2e55 xfs: declare xfs_file.c symbols in xfs_file.h
c070b8802159 xfs: create a new helper to return a file's allocation unit
2e63ed9b0175 xfs: Fix xfs_flush_unmap_range() range for RT
fe962ab3c4f1 xfs: Fix xfs_prepare_shift() range for RT
ca96d83c9307 xfs: don't walk off the end of a directory data block
27336a327b40 xfs: remove unused parameter in macro XFS_DQUOT_LOGRES
b2dcbd8a928c xfs: attr forks require attr, not attr2
4a82db7a4b73 xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set
9fadc53d793c xfs: Fix the owner setting issue for rmap query in xfs fsmap
35bd108619c2 xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
29fcb5fef608 xfs: take m_growlock when running growfsrt
e5d1ae2d4d0b xfs: reset rootdir extent size hint after growfsrt
[skipped for 6.1 as scrub is not supported in 6.1:]
cb95cb2450e3 xfs: convert comma to semicolon
1bee32f33c0a xfs: fix file_path handling in tracepoints

- Leah


Christoph Hellwig (1):
  xfs: fix the contact address for the sysfs ABI documentation

Darrick J. Wong (17):
  xfs: fix interval filtering in multi-step fsmap queries
  xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
  xfs: fix getfsmap reporting past the last rt extent
  xfs: clean up the rtbitmap fsmap backend
  xfs: fix logdev fsmap query result filtering
  xfs: validate fsmap offsets specified in the query keys
  xfs: fix xfs_btree_query_range callers to initialize btree rec fully
  xfs: fix an agbno overflow in __xfs_getfsmap_datadev
  xfs: verify buffer, inode, and dquot items every tx commit
  xfs: use consistent uid/gid when grabbing dquots for inodes
  xfs: declare xfs_file.c symbols in xfs_file.h
  xfs: create a new helper to return a file's allocation unit
  xfs: attr forks require attr, not attr2
  xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set
  xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
  xfs: take m_growlock when running growfsrt
  xfs: reset rootdir extent size hint after growfsrt

John Garry (2):
  xfs: Fix xfs_flush_unmap_range() range for RT
  xfs: Fix xfs_prepare_shift() range for RT

Julian Sun (1):
  xfs: remove unused parameter in macro XFS_DQUOT_LOGRES

Zizhi Wo (1):
  xfs: Fix the owner setting issue for rmap query in xfs fsmap

lei lu (1):
  xfs: don't walk off the end of a directory data block

 Documentation/ABI/testing/sysfs-fs-xfs |   8 +-
 fs/xfs/Kconfig                         |  12 ++
 fs/xfs/libxfs/xfs_alloc.c              |  10 +-
 fs/xfs/libxfs/xfs_dir2_data.c          |  31 ++-
 fs/xfs/libxfs/xfs_dir2_priv.h          |   7 +
 fs/xfs/libxfs/xfs_quota_defs.h         |   2 +-
 fs/xfs/libxfs/xfs_refcount.c           |  13 +-
 fs/xfs/libxfs/xfs_rmap.c               |  10 +-
 fs/xfs/libxfs/xfs_trans_resv.c         |  28 +--
 fs/xfs/scrub/bmap.c                    |   8 +-
 fs/xfs/xfs.h                           |   4 +
 fs/xfs/xfs_bmap_util.c                 |  22 +-
 fs/xfs/xfs_buf_item.c                  |  32 +++
 fs/xfs/xfs_dquot_item.c                |  31 +++
 fs/xfs/xfs_file.c                      |  33 ++-
 fs/xfs/xfs_file.h                      |  15 ++
 fs/xfs/xfs_fsmap.c                     | 266 ++++++++++++++-----------
 fs/xfs/xfs_inode.c                     |  29 ++-
 fs/xfs/xfs_inode.h                     |   2 +
 fs/xfs/xfs_inode_item.c                |  32 +++
 fs/xfs/xfs_ioctl.c                     |  12 ++
 fs/xfs/xfs_iops.c                      |   1 +
 fs/xfs/xfs_iops.h                      |   3 -
 fs/xfs/xfs_rtalloc.c                   |  78 ++++++--
 fs/xfs/xfs_symlink.c                   |   8 +-
 fs/xfs/xfs_trace.h                     |  25 +++
 26 files changed, 505 insertions(+), 217 deletions(-)
 create mode 100644 fs/xfs/xfs_file.h

-- 
2.50.0.rc1.591.g9c95f17f64-goog


