Return-Path: <stable+bounces-42063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1208B713B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DDBB207EB
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3B12C487;
	Tue, 30 Apr 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06qxiD53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87C12C54B;
	Tue, 30 Apr 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474447; cv=none; b=SPJqUfX3du9BhSTQVPVj11OEowk463+CwXN2yVCAV+NvTf/MfjpxenXCiNvfgPGvFOxcVKB9jKqnOgF0IhUCnZCtTYvfaCLMvtlLc0U1cmq3yYpdopyLbTxMP3oItIDHLVRFJlDWUldXgb0tB37IDSXO6Hne7xx/JP15Ne9Wnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474447; c=relaxed/simple;
	bh=2cPD6GRFh0DWQ7+V0kzlp7IPtwHfOjhWantctrmrfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0kSWnr6LYEbet2snF80NJTMgTdDD1RlESJbtmEReTgDEAAsU4HdYPGqsf/7sho41sqrIHsnNzOQW0MYw6yH1lE4leyYEdYelkLOtFoeS7yyeTP5WeHvdbYpbCnj7ZUkHV+1IdlTNXGbg2G4v3xGPwvzo3fuGc6S0gbxNS9vNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06qxiD53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC869C4AF19;
	Tue, 30 Apr 2024 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474447;
	bh=2cPD6GRFh0DWQ7+V0kzlp7IPtwHfOjhWantctrmrfq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=06qxiD53BcerE+qvPuzSa5qU7KTlHLTsrWbBviKsNMc6kuai7Yf8WVygFHLFBjP5k
	 UX6uDfgc/zmN3TqnAtLXk9vUz4uhb6CC3vZ39+gRFbkr5yiBeuE0qbqKd3HLErOfas
	 NATtLdKlYRc0QN4rxm7f3xqO+SKQAPZ8mEbdfztY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.8 159/228] btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()
Date: Tue, 30 Apr 2024 12:38:57 +0200
Message-ID: <20240430103108.394495600@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit fe1c6c7acce10baf9521d6dccc17268d91ee2305 upstream.

[BUG]
During my extent_map cleanup/refactor, with extra sanity checks,
extent-map-tests::test_case_7() would not pass the checks.

The problem is, after btrfs_drop_extent_map_range(), the resulted
extent_map has a @block_start way too large.
Meanwhile my btrfs_file_extent_item based members are returning a
correct @disk_bytenr/@offset combination.

The extent map layout looks like this:

     0        16K    32K       48K
     | PINNED |      | Regular |

The regular em at [32K, 48K) also has 32K @block_start.

Then drop range [0, 36K), which should shrink the regular one to be
[36K, 48K).
However the @block_start is incorrect, we expect 32K + 4K, but got 52K.

[CAUSE]
Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
that covers the target range but is still beyond it, we need to split
that extent map into half:

	|<-- drop range -->|
		 |<----- existing extent_map --->|

And if the extent map is not compressed, we need to forward
extent_map::block_start by the difference between the end of drop range
and the extent map start.

However in that particular case, the difference is calculated using
(start + len - em->start).

The problem is @start can be modified if the drop range covers any
pinned extent.

This leads to wrong calculation, and would be caught by my later
extent_map sanity checks, which checks the em::block_start against
btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.

This is a regression caused by commit c962098ca4af ("btrfs: fix
incorrect splitting in btrfs_drop_extent_map_range"), which removed the
@len update for pinned extents.

[FIX]
Fix it by avoiding using @start completely, and use @end - em->start
instead, which @end is exclusive bytenr number.

And update the test case to verify the @block_start to prevent such
problem from happening.

Thankfully this is not going to lead to any data corruption, as IO path
does not utilize btrfs_drop_extent_map_range() with @skip_pinned set.

So this fix is only here for the sake of consistency/correctness.

CC: stable@vger.kernel.org # 6.5+
Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_map.c             |    2 +-
 fs/btrfs/tests/extent-map-tests.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -818,7 +818,7 @@ void btrfs_drop_extent_map_range(struct
 					split->block_len = em->block_len;
 					split->orig_start = em->orig_start;
 				} else {
-					const u64 diff = start + len - em->start;
+					const u64 diff = end - em->start;
 
 					split->block_len = split->len;
 					split->block_start += diff;
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -847,6 +847,11 @@ static int test_case_7(struct btrfs_fs_i
 		goto out;
 	}
 
+	if (em->block_start != SZ_32K + SZ_4K) {
+		test_err("em->block_start is %llu, expected 36K", em->block_start);
+		goto out;
+	}
+
 	free_extent_map(em);
 
 	read_lock(&em_tree->lock);



