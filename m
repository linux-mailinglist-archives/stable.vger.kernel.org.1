Return-Path: <stable+bounces-172264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF9B30CA0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91991BA33AC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09C2580CF;
	Fri, 22 Aug 2025 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCa5Wwpw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2C22172C
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833732; cv=none; b=vDyXcjYx7W9rZCnUj+6VbUVvKdooFb1W90T7UomFwECT12e9HaT/ltZXVF+3sX3DNWbLT3E/l1XaVxkGxzqb0nh0S3UsOayBK/Pm9uaZ83XEvPrCHRHVm76+2WrT9txw+sX2SIEFyPoWE5+qYsh06qRo2yx7ebo0N66BXgmltZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833732; c=relaxed/simple;
	bh=dVbLlph9G0KOlaSMTzOX4KGj/hkOEL0sKQ4UxG6EYLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJpVYRmvt9wN69BSi/EbDovS8j9c5P8RNn/WJg7XJ02WacgBEo4fZL2yxrT/DB7stg9LYQEmJMHmmkzHrtWtJI8mNHo3wwjUJK8Poj3g0jy+SMLkFcNhUQcdepbgopkAH2F4q/y74G307LwoNu+im7pUcClLHRMgq9nxbTSQMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCa5Wwpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6ECC4CEEB;
	Fri, 22 Aug 2025 03:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755833732;
	bh=dVbLlph9G0KOlaSMTzOX4KGj/hkOEL0sKQ4UxG6EYLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCa5WwpwpwsVIITdxfEEjIoeRQXAnY87xGhak8X8wjXkmaz9fEye+sX8++QFGOzm/
	 LmkMjnUrDJOOu2M9PAMqMq6fGfRL52bynmkmc5Km1V4mTk4yN5gUm3nFYi84xb9HQ0
	 Xwbv5oHkwjLDvBLouZ1btkcklOjR8ah1bcymcdOJgqZwci+dv3X90y4a1wZGv+wqK2
	 qLKWaCP6Ut8+DaSZMHBuui8pJeP9fXl4tTMF2ruEITtgQZvuMyvsjK6xqNYO7lYRgU
	 7ZBPuYvSOoE/AGadHVQw37w0ywD5wK/YAHoxhpn1Nwn0tpz4PtMORTjxb/Srm6hMdW
	 eXKKwJl/hgGNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/3] btrfs: add comments on the extra btrfs specific subpage bitmaps
Date: Thu, 21 Aug 2025 23:35:15 -0400
Message-ID: <20250822033527.1065200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082101-survive-mannish-1c90@gregkh>
References: <2025082101-survive-mannish-1c90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1e17738d6b76cdc76d240d64de87fa66ba2365f7 ]

Unlike the iomap_folio_state structure, the btrfs_subpage structure has a
lot of extra sub-bitmaps, namely:

- writeback sub-bitmap
- locked sub-bitmap
  iomap_folio_state uses an atomic for writeback tracking, while it has
  no per-block locked tracking.

  This is because iomap always locks a single folio, and submits dirty
  blocks with that folio locked.

  But btrfs has async delalloc ranges (for compression), which are queued
  with their range locked, until the compression is done, then marks the
  involved range writeback and unlocked.

  This means a range can be unlocked and marked writeback at seemingly
  random timing, thus it needs the extra tracking.

  This needs a huge rework on the lifespan of async delalloc range
  before we can remove/simplify these two sub-bitmaps.

- ordered sub-bitmap
- checked sub-bitmap
  These are for COW-fixup, but as I mentioned in the past, the COW-fixup
  is not really needed anymore and these two flags are already marked
  deprecated, and will be removed in the near future after comprehensive
  tests.

Add related comments to indicate we're actively trying to align the
sub-bitmaps to the iomap ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: b1511360c8ac ("btrfs: subpage: keep TOWRITE tag until folio is cleaned")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/subpage.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 3042c5ea840a..52546e0e97ce 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -33,8 +33,22 @@ enum {
 	btrfs_bitmap_nr_uptodate = 0,
 	btrfs_bitmap_nr_dirty,
 	btrfs_bitmap_nr_writeback,
+	/*
+	 * The ordered and checked flags are for COW fixup, already marked
+	 * deprecated, and will be removed eventually.
+	 */
 	btrfs_bitmap_nr_ordered,
 	btrfs_bitmap_nr_checked,
+
+	/*
+	 * The locked bit is for async delalloc range (compression), currently
+	 * async extent is queued with the range locked, until the compression
+	 * is done.
+	 * So an async extent can unlock the range at any random timing.
+	 *
+	 * This will need a rework on the async extent lifespan (mark writeback
+	 * and do compression) before deprecating this flag.
+	 */
 	btrfs_bitmap_nr_locked,
 	btrfs_bitmap_nr_max
 };
-- 
2.50.1


