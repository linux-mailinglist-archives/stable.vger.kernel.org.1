Return-Path: <stable+bounces-225421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t64bF6hWtWkMzgAAu9opvQ
	(envelope-from <stable+bounces-225421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:38:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC328D2AC
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 656193016EC8
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E425F96B;
	Sat, 14 Mar 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR3DcV50"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72926F46E
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773491876; cv=none; b=n+KNZWgGb4L853EIZlCaLdx83F+TpG+uidD970wMtMLG26duC0XruIG9MdOnp3sUsbWZCEgRmZ67DqhSPn3NQhD0C8uTkJTvgT3EX4inGp3V7Bb4qmThQBiGEVFfFxeCW9v2BksQRVzCZBOSRpLm77MZMUxlfjOKr7323oZJFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773491876; c=relaxed/simple;
	bh=z5AD4JniElssw7dAZ3Z2sfNgq0aQO8sOOb3qGgHe3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iapTJRcaK/dGERxzoZJAq2xQXCGVfXQoiF8YKi21OY0Q18sUCQxZ697ZZPIgwFToDR4BXO8xX8zub2TOu/WmV4PUo3AxzjM81QqDJL+P8GrINbt6Wupe5dN8z+dmXgkALAbzVr2UgsfTn/XBVM/wnRUT3sKFR+9kfGJpn9tZhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR3DcV50; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab232cc803so14812165ad.3
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773491875; x=1774096675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch0eaxVQ4/ts2cf46sQ450Wifko7pmpNDC0czkFsQbk=;
        b=XR3DcV50O2XxLiQpqzCAMkbgY8hoGrNVcoru0cycEVQuzkUynVoJFkIWyRjP/71eil
         oO0nB6b1Glb4h+ZZ4Yn2BV7jx3kqjTzA1eRR8+y83tuP8Q34bhnXA6ujG8eGte+AOnXg
         l2laMb3cnQUvDXJfWEFuBA8LXRdxOF/HnIAjoZyoUGNj0FUl5lFRm2nkDh2PYDvknJI0
         g0w3RJoCPEhkaWaq5HqQSt29CgeuO3Xe7SyXoXgLgkFBVrYCLYh+YeXWjuAP5qy0KXT0
         5SUIjzuqEdXSKPuP70Nk0MsNk48oKZhZM8aTO8SRjx7JW7nDTUnYtBhKllOdjbhsKnDN
         MWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773491875; x=1774096675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ch0eaxVQ4/ts2cf46sQ450Wifko7pmpNDC0czkFsQbk=;
        b=GE2FxS9/ou91ggHwJjsudPjaoeOqM95zKhxo/byHFZSiFS6XuMFLMWeZhhdZ+7+Xml
         TAzWqjZWft1yjWtXg9QZbIvUoerzxICmmJSf298Xhu8KksACR45fAfnXJD7oSRKnblou
         9P/W6I+/eqWpy8ixsHDZTxCkBI3XHFLAEnMz5fVxOFL9crAnlMATMfOtpFC/01fVF3NL
         AgQDy3HyD02Fmqt9+K4VsOsWqfcPFj4bYoBCUwLkaGPHbttA6ua0jv0Q1pq6p9LFLs/s
         Tcmwi4s/xy0IHj+pcopPz8RkTqAN7xRfyerTjpHPvFen9x9ePE9LtZI4haWGad5B1uVG
         Kfkw==
X-Forwarded-Encrypted: i=1; AJvYcCWdskTMV3pKGSni+7glC7jbmxU6WUGWskTPExuGjB+MR66o7y/poixrPXlDylaCSjzFWmG+UE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/S9FezCvCNJHzWeKxGg+esiMsp8jgnyzZPh9WLpo1PCq21kD2
	nxzHtMiZqvMZ00rvDcKC1P637cia9ipk0wewjW0ggG3KHnDAaXJMkwrL
X-Gm-Gg: ATEYQzy8g0AvUobHLF/nLaIARyoj1Ysb9jab8Uynry/UH+G4zGxIA7rWb8QLUN2X4Wb
	Lgr9A8JOiWRYRi3UKnE931TNtyt1uhwBpliagJrXWyQjo4KvwDkTBuOpDJ0Q7gIGFvCvlG9qlnk
	5ZolRFdgv0kjht1hvBJTeHwUCsjlquBsNVw0wG/EQp+24DJx4RYtBaydHmN3ZapnITykPHMmGEg
	cUsHhon5LZyGjS2tIzZhy/dLaRxlKbjLFmJYBXgOhWhdze775hl3fcEX2qTY45j2XuImrzdYZr6
	smg1+0Gu9yFOqb32ONghsqAlI12WI0vV21Pio9YeDCq6RFJYZEjguKmslmZ6e94tQ9jn6b7GyyU
	t0juQfRZ1bmg8aJjFgmFu3cUfdnxI/rK5ttT/5SEf4OYnpaDI1dNyaWNOWUOzFJ9DWekRjW5iII
	AhLV7695wH6d0kPwQPu0dUsiUGtnvbmrOebnK37DTbe4AK2mRz4328nJyUv9WTW45cI0+9P5E=
X-Received: by 2002:a17:903:20ce:b0:2ae:6031:bc59 with SMTP id d9443c01a7336-2aecaa1504emr50150105ad.30.1773491874677;
        Sat, 14 Mar 2026 05:37:54 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.183.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56e0b8sm63561935ad.16.2026.03.14.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 05:37:54 -0700 (PDT)
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
Subject: [PATCH v2 1/3] btrfs: balance: fix null-ptr-deref in chunk_usage_filter
Date: Sat, 14 Mar 2026 20:37:39 +0800
Message-ID: <20260314123741.1439792-2-gality369@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,fb.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ECFC328D2AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
Running btrfs balance with a usage filter (-dusage=N) can trigger a
null-ptr-deref when metadata corruption causes a chunk to have no
corresponding block group in the in-memory cache:

  KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
  RIP: 0010:chunk_usage_filter fs/btrfs/volumes.c:3874 [inline]
  RIP: 0010:should_balance_chunk fs/btrfs/volumes.c:4018 [inline]
  RIP: 0010:__btrfs_balance fs/btrfs/volumes.c:4172 [inline]
  RIP: 0010:btrfs_balance+0x2024/0x42b0 fs/btrfs/volumes.c:4604
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
   usage filter queries.

On a well-formed filesystem, these two are kept in 1:1 correspondence.
However, btrfs_read_block_groups() builds the cache from block group
items in the extent tree, not directly from the chunk tree. A corrupted
image can therefore contain a chunk item in the chunk tree whose
corresponding block group item is absent from the extent tree; that
chunk's block group is then never inserted into the in-memory cache.

When balance iterates the chunk tree and reaches such an orphaned chunk,
should_balance_chunk() calls chunk_usage_filter(), which queries the block
group cache:

  cache = btrfs_lookup_block_group(fs_info, chunk_offset);
  chunk_used = cache->used;   /* cache may be NULL */

btrfs_lookup_block_group() returns NULL silently when no cached entry
covers chunk_offset. chunk_usage_filter() does not check the return value,
so the immediately following dereference of cache->used triggers the crash.

[FIX]
Add a NULL check after btrfs_lookup_block_group() in chunk_usage_filter().
When the lookup fails, emit a btrfs_err() message identifying the
affected bytenr and return -EUCLEAN to indicate filesystem corruption.

Since the filter function now has an error return path, change its
return type from bool to int (negative = error, 0 = do not balance,
positive = balance). Update should_balance_chunk() accordingly (bool ->
int, with the same convention) and add error propagation for the usage
filter path. Finally, handle the new negative return in __btrfs_balance()
by jumping to the existing error path, which aborts the balance
operation and reports the error to userspace.

After the fix, the same corruption is correctly detected and reported
by the filter, and the null-ptr-deref is no longer triggered.

Fixes: 5ce5b3c0916b ("Btrfs: usage filter")
Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..7c21ac249383 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3863,14 +3863,20 @@ static bool chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_of
 	return ret;
 }
 
-static bool chunk_usage_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
-			       struct btrfs_balance_args *bargs)
+static int chunk_usage_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+			      struct btrfs_balance_args *bargs)
 {
 	struct btrfs_block_group *cache;
 	u64 chunk_used, user_thresh;
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
@@ -3986,8 +3992,8 @@ static bool chunk_soft_convert_filter(u64 chunk_type, struct btrfs_balance_args
 	return false;
 }
 
-static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
-				 u64 chunk_offset)
+static int should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
+				u64 chunk_offset)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
@@ -4014,9 +4020,13 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
 	}
 
 	/* usage filter */
-	if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE) &&
-	    chunk_usage_filter(fs_info, chunk_offset, bargs)) {
-		return false;
+	if (bargs->flags & BTRFS_BALANCE_ARGS_USAGE) {
+		int filter_ret = chunk_usage_filter(fs_info, chunk_offset, bargs);
+
+		if (filter_ret < 0)
+			return filter_ret;
+		if (filter_ret)
+			return false;
 	} else if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) &&
 	    chunk_usage_range_filter(fs_info, chunk_offset, bargs)) {
 		return false;
@@ -4172,6 +4182,10 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		ret = should_balance_chunk(leaf, chunk, found_key.offset);
 
 		btrfs_release_path(path);
+		if (ret < 0) {
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+			goto error;
+		}
 		if (!ret) {
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto loop;
-- 
2.43.0


