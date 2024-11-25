Return-Path: <stable+bounces-95427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BB9D8C8B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F50166DAB
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028041B983F;
	Mon, 25 Nov 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVzOyoFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D472500CC
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561196; cv=none; b=MCV5c4+ntR80vEgnxHkZstCYXQuq6p6LINDwZo1ZHNtk2JE4p7RhkM6cNNURx1BJQcA/DnC3Cxb09VjS7ytD+EQyASG8mThdGEyjRXZtRkFiCxVjmaMKqRw+UmuHnW2kpBQE/AEURv5LZEO7uGXiWy6yGQx+8nhMf1BZoqV0wLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561196; c=relaxed/simple;
	bh=XO+6jkZi52+dZ7h3zjkA04nygMrZzw5xBZvwiHhWR28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyzch82jkTHCaHpG/2rvzyI4WtMC1Zh+7gJM+1qZ/SALf5c2PedFaxhKfbejIpSX/FumW0JAsgOuDnHr7jedwsEYuqXrimOjDFy15zja/TCvA1GHDEkoJC6MAeZTofXkWchE3CmgtUOAOC/oLPX/HftgQtKpA+dGsvbIORloECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVzOyoFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F364CC4CECE;
	Mon, 25 Nov 2024 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732561196;
	bh=XO+6jkZi52+dZ7h3zjkA04nygMrZzw5xBZvwiHhWR28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVzOyoFbuM1hM6C49gyGyzTHmdMgTrNSvyaFIKbUKdlPX1Kp4qWP/6uFskCplFE/t
	 CWqrrc1p624xeddP5gqI0R26iSzepgHRUQ9CyP3dGUQiNZeChB8ER0ZNrWHgHXzs5G
	 Sigh7iktaJk/6xSVcLs8331FiKMUXxS0g8xwtSUXiHqrp9ttUqXmTbPJgbNWwln57g
	 BQZxOrWeflfPKoX+QZXKYHEjDizkbiEq9oRQOE3q8EMGzefWVmDWcp6P+zaBDB4A4t
	 Ezjf9J8m4qDROAAZ3muLogJaDnmgO5Y9s9TprX6XgIdskI9Lpp0aX30/cSePEohLzv
	 djC4mNbn7H2FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Date: Mon, 25 Nov 2024 13:59:54 -0500
Message-ID: <20241125135724-7d3e355c4a822ec7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125180729.13148-1-dsterba@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 69313850dce33ce8c24b38576a279421f4c60996

WARNING: Author mismatch between patch and found commit:
Backport author: David Sterba <dsterba@suse.com>
Commit author: Luca Stefani <luca.stefani.ge1@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: fba6544ff4bf)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 13:53:18.073145886 -0500
+++ /tmp/tmp.ws7hjJgxh2	2024-11-25 13:53:18.068806643 -0500
@@ -17,14 +17,14 @@
 ---
  fs/btrfs/extent-tree.c      | 7 ++++++-
  fs/btrfs/free-space-cache.c | 4 ++--
- fs/btrfs/free-space-cache.h | 6 ++++++
- 3 files changed, 14 insertions(+), 3 deletions(-)
+ fs/btrfs/free-space-cache.h | 7 +++++++
+ 3 files changed, 15 insertions(+), 3 deletions(-)
 
 diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
-index ad70548d1f722..d9f511babd89a 100644
+index b3680e1c7054..599407120513 100644
 --- a/fs/btrfs/extent-tree.c
 +++ b/fs/btrfs/extent-tree.c
-@@ -1316,6 +1316,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
+@@ -1319,6 +1319,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
  		start += bytes_to_discard;
  		bytes_left -= bytes_to_discard;
  		*discarded_bytes += bytes_to_discard;
@@ -36,7 +36,7 @@
  	}
  
  	return ret;
-@@ -6470,7 +6475,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
+@@ -6094,7 +6099,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
  		start += len;
  		*trimmed += bytes;
  
@@ -46,10 +46,10 @@
  			break;
  		}
 diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
-index eaa1dbd313528..f4bcb25306606 100644
+index 3bcf4a30cad7..9a6ec9344c3e 100644
 --- a/fs/btrfs/free-space-cache.c
 +++ b/fs/btrfs/free-space-cache.c
-@@ -3809,7 +3809,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
+@@ -3808,7 +3808,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
  		if (async && *total_trimmed)
  			break;
  
@@ -58,7 +58,7 @@
  			ret = -ERESTARTSYS;
  			break;
  		}
-@@ -4000,7 +4000,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
+@@ -3999,7 +3999,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
  		}
  		block_group->discard_cursor = start;
  
@@ -68,18 +68,19 @@
  				reset_trimming_bitmap(ctl, offset);
  			ret = -ERESTARTSYS;
 diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
-index 83774bfd7b3bb..9f1dbfdee8cab 100644
+index 33b4da3271b1..bd80c7b2af96 100644
 --- a/fs/btrfs/free-space-cache.h
 +++ b/fs/btrfs/free-space-cache.h
-@@ -10,6 +10,7 @@
- #include <linux/list.h>
- #include <linux/spinlock.h>
- #include <linux/mutex.h>
-+#include <linux/freezer.h>
- #include "fs.h"
+@@ -6,6 +6,8 @@
+ #ifndef BTRFS_FREE_SPACE_CACHE_H
+ #define BTRFS_FREE_SPACE_CACHE_H
  
- struct inode;
-@@ -56,6 +57,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
++#include <linux/freezer.h>
++
+ /*
+  * This is the trim state of an extent or bitmap.
+  *
+@@ -43,6 +45,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
  	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
  }
  
@@ -91,3 +92,6 @@
  /*
   * Deltas are an effective way to populate global statistics.  Give macro names
   * to make it clear what we're doing.  An example is discard_extents in
+-- 
+2.45.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

