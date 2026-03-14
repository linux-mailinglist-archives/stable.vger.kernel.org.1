Return-Path: <stable+bounces-225422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO4yD/BWtWkMzgAAu9opvQ
	(envelope-from <stable+bounces-225422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:39:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94A28D2E1
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6D030574AA
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340D26E702;
	Sat, 14 Mar 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaxia7Gx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8227B4FA
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773491881; cv=none; b=P2nknF6eutcETTe1Ie3/yty001vqFo1ycma4r15IE/ol7zyrRa601zE3oioYSIE688SV7ES21neX9zYKSsIcuSKd/vEwNK1u/Frx93F1ZUg/mH4SOwl83jQAw2jyOeZA+k1GBhUA9iboWMYr3VeUuYobD5phgT6Kpk3w0ZtPyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773491881; c=relaxed/simple;
	bh=mY0wN1Iv94QmwEBTkfV+F1YpjliEDVD6TkjX5Uyamic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQJeS+tK51GpqOqZSczQ5uloQJfWifc37D3s/QDSwV6rcVz9L7PAKgfOZruQRLBZA7meeV0zXWFve+OKUtLVZ3AYLJjxwlrp11LjbYneYbaRa8qsaGf7XNsq9Es2D2oyyTvB8nhUwmczckVMoGETkuhTMuhT/h2nIJMwXXfs9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaxia7Gx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso15570935ad.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773491879; x=1774096679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nzVhDf4BKtWklFTMhpHjd6JpAbDZy+t4Nj2UDjpxAI=;
        b=aaxia7GxtzqOf/jscziIrMKulAsL99B2RDJxQZQtirJHeUTzWvjMH+fa7vJKc5CzMH
         Ua33dj1B52ZMJLcVDJJ3GSlca+s2T0IS971hvrxiBqix04x19w0N7pTEaDUmuFgzntBZ
         6QX9/Slvdk/4aLZQWWeu/gE646EXp1A5YgHehWchMHJoXSPKUjcUCfT3d5ZHGZHySdzX
         xIW/kePSoMmktvydj9oxv5x5RX4L7m9BggaSUZXkA5j8fVFXiUupJCacEv5Si5Gr7Nks
         4kDBhikMtVs1S8BISQ4Aezk5gjPsRngevsmbhR2urS6UZClK6l914vbduOGED282J2PD
         AZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773491879; x=1774096679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nzVhDf4BKtWklFTMhpHjd6JpAbDZy+t4Nj2UDjpxAI=;
        b=cpfVhO9UtWbuVoW+9uyaR98xK4fA7HG0pLFCS0B4tTGPvhjfnZ8a02efxsnJoQEtRG
         h9hXt/kzhLzDLd8V7Ji6JUr24Xe6Uf6xowRQBTtelhPgm1l0hq2m3xKXo4kecZVn3JEp
         jydniJ8+4KIPRRgFzqxnI6j/sfa6V+AobJPZ/hDmfdI2FOj69awzeuYlzWXrjkt9K9mT
         ohNvUA4Py15uQueaWNcxSxAPZxELlwlrGDJMmnoPPrp9owuHAkaKVqRSynjzLZzANTKl
         aaU/pWnU/gVMrAaWpEY7RT5pjNKqGHDlvngHbB88ma3gZpNyFw5Z8nPcvfWhV70kF4FG
         dKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUNa7Oz3uvSIIw1YZiykNSp+yNndeHIrQ4OFizPvoTD8grg1LxbWBGbuvKY4INMKE65rnKjLzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YZq2kwdlx5YtqdaewggHLqRJ5Bw85hvpg9AFTEZiJzOEek43
	U+bLl0Kad+fr+fesQIYkoWppcqW89MWnk6D5Ic2G2Zg0OABqOAExaWQo
X-Gm-Gg: ATEYQzyNrQ/OYXNHkzw5p6f6ivSyx7P+b0GguTZW7C2s4G46se4vB0FtXwLM/6TEZe3
	iScqtju0LTPVD+E8Y4/t8PdW7Csra0n77E2Fpl5ntRTJJXhbfiZQGggqxPEFjBHbQezmw/L/SD/
	stvxh2siUONRtSns86hYlNbx7W+wlYzAFhOnNtq6WOTHww4y5sdULiWs7JZLMdfXqjhGYm/4sGz
	Uu9faUY+yfFi2aZ3U3P+9CrUv5WBfWS4wwv2cB/t1HwqfR6cwPcrkXqc+rDBySU5256dPdkc9Xi
	y9XyOr5Gtf8t4OE+JeTOrqXOpoh/8nP0av2+zxXfxzVYWCoAaNHPv473ke1gQUb97qKSj42lIJ9
	k0IWu6ZHhbKuGB1q306zYi+1B3LZ/2J3rCVtbvS+53iwEnhndCArymgRwwuGZL308ukn6oi6MqU
	Yd+UMxHm4prG/5urItide5D3HUWmOUn9w+NsdMvDPPG/qdJpbyrInVnpG+TBvPG3hBmJMZZhs=
X-Received: by 2002:a17:903:3d0f:b0:2a9:62ce:1c15 with SMTP id d9443c01a7336-2aeca796da3mr62614755ad.0.1773491878653;
        Sat, 14 Mar 2026 05:37:58 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.183.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56e0b8sm63561935ad.16.2026.03.14.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 05:37:58 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com,
	idryomov@gmail.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: balance: fix null-ptr-deref in chunk_usage_range_filter
Date: Sat, 14 Mar 2026 20:37:40 +0800
Message-ID: <20260314123741.1439792-3-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314123741.1439792-1-gality369@gmail.com>
References: <20260314123741.1439792-1-gality369@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225422-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fb.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC94A28D2E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
Running btrfs balance with a usage range filter (-dusage=min..max) can
trigger a null-ptr-deref when metadata corruption causes a chunk to have
no corresponding block group in the in-memory cache:

  KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
  RIP: 0010:chunk_usage_range_filter fs/btrfs/volumes.c:3845 [inline]
  RIP: 0010:should_balance_chunk fs/btrfs/volumes.c:4031 [inline]
  RIP: 0010:__btrfs_balance fs/btrfs/volumes.c:4182 [inline]
  RIP: 0010:btrfs_balance+0x249e/0x4320 fs/btrfs/volumes.c:4618
  ...
  Call Trace:
    btrfs_ioctl_balance fs/btrfs/ioctl.c:3577 [inline]
    btrfs_ioctl+0x25cf/0x5b90 fs/btrfs/ioctl.c:5313
    vfs_ioctl fs/ioctl.c:51 [inline]
    ...

The bug is reproducible on next-20260312 with our dynamic metadata
fuzzing tool, which corrupts btrfs metadata at runtime.

[CAUSE]
Two separate data structures are involved:

1. The on-disk chunk tree, which records every chunk (logical address
   space region) and is iterated by __btrfs_balance().
2. The in-memory block group cache (fs_info->block_group_cache_tree),
   which is built at mount time by btrfs_read_block_groups() and holds
   a struct btrfs_block_group for each chunk. This cache is what the
   usage range filter queries.

On a well-formed filesystem, these two are kept in 1:1 correspondence.
However, btrfs_read_block_groups() builds the cache from block group
items in the extent tree, not directly from the chunk tree. A corrupted
image can therefore contain a chunk item in the chunk tree whose
corresponding block group item is absent from the extent tree; that
chunk's block group is then never inserted into the in-memory cache.

When balance iterates the chunk tree and reaches such an orphaned chunk,
should_balance_chunk() calls chunk_usage_range_filter(), which queries
the block group cache:

  cache = btrfs_lookup_block_group(fs_info, chunk_offset);
  chunk_used = cache->used;   /* cache may be NULL */

btrfs_lookup_block_group() returns NULL silently when no cached entry
covers chunk_offset. chunk_usage_range_filter() does not check the return
value, so the immediately following dereference of cache->used triggers
the crash.

[FIX]
Add a NULL check after btrfs_lookup_block_group() in
chunk_usage_range_filter(). When the lookup fails, emit a btrfs_err()
message identifying the affected bytenr and return -EUCLEAN to indicate
filesystem corruption.

Since chunk_usage_range_filter() now has an error return path, change its
return type from bool to int (negative = error, 0 = do not balance,
positive = balance). Update the BTRFS_BALANCE_ARGS_USAGE_RANGE branch in
should_balance_chunk() to propagate negative errors instead of treating
them as a normal filter result.

After the fix, the same corruption is correctly detected and reported
by the filter, and the null-ptr-deref is no longer triggered.

Fixes: bc3094673f22 ("btrfs: extend balance filter usage to take minimum and maximum")
Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7c21ac249383..4958e074d420 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3832,8 +3832,8 @@ static bool chunk_profiles_filter(u64 chunk_type, struct btrfs_balance_args *bar
 	return true;
 }
 
-static bool chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
-				     struct btrfs_balance_args *bargs)
+static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+				    struct btrfs_balance_args *bargs)
 {
 	struct btrfs_block_group *cache;
 	u64 chunk_used;
@@ -3842,6 +3842,12 @@ static bool chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_of
 	bool ret = true;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
+	if (!cache) {
+		btrfs_err(fs_info,
+			  "balance: chunk at bytenr %llu has no corresponding block group",
+			  chunk_offset);
+		return -EUCLEAN;
+	}
 	chunk_used = cache->used;
 
 	if (bargs->usage_min == 0)
@@ -4027,9 +4033,13 @@ static int should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk *
 			return filter_ret;
 		if (filter_ret)
 			return false;
-	} else if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) &&
-	    chunk_usage_range_filter(fs_info, chunk_offset, bargs)) {
-		return false;
+	} else if (bargs->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) {
+		int filter_ret = chunk_usage_range_filter(fs_info, chunk_offset, bargs);
+
+		if (filter_ret < 0)
+			return filter_ret;
+		if (filter_ret)
+			return false;
 	}
 
 	/* devid filter */
-- 
2.43.0


