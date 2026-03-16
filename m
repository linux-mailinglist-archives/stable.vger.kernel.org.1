Return-Path: <stable+bounces-225543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPFVNowKuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:50:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782829ABD8
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86ABD3069019
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C138E5D6;
	Mon, 16 Mar 2026 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWciS++s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A12874FF
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668811; cv=none; b=Ec/Q/VmqVEzq6QKrY1l5HJve9NlJ1BnTLInEHa985eZKcMWBo1WUriaoQbJ0K01Ss30ZT6CyOJ9oYCCjupub7bIcxX0fgX4U6cElB//ij/97hgJYQo0cu+nYHhRt7EL8vApYH7rsaEF8eIGV4q1bhsTlKOgIiRIuk8OZk/aVFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668811; c=relaxed/simple;
	bh=breDB+00djj9jhqac1wBzBjoA2b5kvIH5MdmzZDEYws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fa97w40VpmL/fQyDE0lx66eFPRF0VkZygPERIK2OMvoRXQBinrwIQNGIOhemLBm1qppTN2Qgzz+3X0OwA+QLu9XbZUIaOp4VYbrTJgmUXbQ337wR5o6BQ207zpUK1lo38zowTPDOLQFlHkDpdP489psWs6SFCEdnfpuKqNcVJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWciS++s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b048527825so10502245ad.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773668810; x=1774273610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sFGbjk8Rr0qu9K/p0VmFfHdyoMlcL5YQ+B7+8Owpfw=;
        b=iWciS++s8DKcrC/tTnIb6FymswINft1+owJ4HYvZZZC4a3imZ3DE7AFbbQSwiMzQoO
         pWHbIFJBOU8PV13NFlU3nF1KlAX+2Maqi+FZp+MSkQWW94g3BGtVY2ho4larq5WnC8DT
         jRf3gEh9USOEkvM9h5O4s97OOCGqcLfy5LMfrvef6Wjt0wQOlQq2gtnu71Q+bwOktbvs
         R6VHpzebEqh4E/slk+2G19HzYixr45Y9nR8Fm22wKx/OxB08xOP2YX341hgnEAJcYbYd
         9sNcmJ4PLXUJYKakqJ0+E2FqOUm67kHH/KAEL534d091lE3g+jxtq0AQtVxhhsSjDSQL
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668810; x=1774273610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sFGbjk8Rr0qu9K/p0VmFfHdyoMlcL5YQ+B7+8Owpfw=;
        b=H9lXz0XBQM2f+UsGFV5OT9On8OAN7NnGYfK+bVEUxo3vLUowoEciBvI2uTsKhNbr0L
         2aFW3pVbMo1M8Mq5E7BxyJg01bow5YgPxRCo1zS83l991L25SZZ3Uxu0r77jcIsMB+o8
         ntW+MyMyMG6bpbXP3hpmS3lOtnwTKbaSKxf4r2gBiEVNIfy7BnT77mhNFFWDRgm3MhSu
         DUSi5hTYm0Jmm9mLYQMEw3GQPbNdG+VDafANBiqaH8U/RJ1xCPudhq2s14ts6Z60elgu
         Bu7PJYu4PNB9ZR2PwOGKVxpFLsRQHigXDXGsRSKKxnxdHgMBYlmik6brzoIoN7s2flb+
         EAIw==
X-Forwarded-Encrypted: i=1; AJvYcCVkLGw6xPyckMXlzzJOjb0MgfQfcdy68NiYVQVclyTu4KayPbHtcupsFyyd99CHbsogrT+XFWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKMiB350HAafrbE9syxkPwmzGbR3jdkZbqj+2fCitgQkEvpic
	oNwzb1Cib2b/7ocyJGieyStjb60cHXt2MJivJVS+a9+PdXUm60Vc6ycW
X-Gm-Gg: ATEYQzxtsU1pYGOGZJ45CY9s9zds7RtCGUYqbL9WzP0sDiHana+04kswJDhTFEoMXr1
	UTrrxSwzjFP4Ch3f90j5C9ZMPM2phUdcC87XA4H1dhQLRARgfPRK0gZsWNut+J8PDEMV5Ag4Q38
	+lJKBNuzz+L47vf2LyXPLGLc1eoKwLxeko1X7kXTMe2efOwpUUSghXPYYdSabX+H4eDDBbvN731
	ZPUq2Cul8O+JolWuy5PxvRJSitQuB3FrzWy57LuAwMyv/aEHntVMZVqDkmPzVMGsnPadKXQ1f9W
	Rxp+L/D1LeXZvwIstgliKqDy5NFeBHIBCiONDyqStSkEqcxJwJT5jB+uF4Msw+qepVR+5UOkair
	76DgFl5SxLgoHIpLEcih/bKiwzpdKAPVsROA3GbnTiv89J6+6MHoImA+SzfGigi4AQnc/30JETh
	8WiZwv3yZJATnKUzr7rLDQ4Z3SyhYJ8qRtAM+DOTB0zRFW0f1eMP5rM8ZhsCQlHzIAdfcMDWg=
X-Received: by 2002:a17:903:19cf:b0:2b0:4eeb:f800 with SMTP id d9443c01a7336-2b04eebfb1bmr59113245ad.33.1773668809726;
        Mon, 16 Mar 2026 06:46:49 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.183.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05b4ca68csm25859945ad.79.2026.03.16.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:46:49 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com,
	bo.li.liu@oracle.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: balance: fix null-ptr-deref in btrfs_may_alloc_data_chunk
Date: Mon, 16 Mar 2026 21:46:40 +0800
Message-ID: <20260316134640.2605237-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225543-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6782829ABD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
Running btrfs balance can trigger a null-ptr-deref before relocating a
data chunk when metadata corruption leaves a chunk in the chunk tree
without a corresponding block group in the in-memory cache:

  KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
  RIP: 0010:btrfs_may_alloc_data_chunk+0x40/0x1c0 fs/btrfs/volumes.c:3601
  Call Trace:
    __btrfs_balance fs/btrfs/volumes.c:4217 [inline]
    btrfs_balance+0x2516/0x42b0 fs/btrfs/volumes.c:4604
    btrfs_ioctl_balance fs/btrfs/ioctl.c:3577 [inline]
    btrfs_ioctl+0x25cf/0x5b90 fs/btrfs/ioctl.c:5313
    ...

[CAUSE]
__btrfs_balance() iterates the on-disk chunk tree and passes the chunk
logical bytenr to btrfs_may_alloc_data_chunk() before relocating a data
chunk. That helper then queries the in-memory block group cache:

  cache = btrfs_lookup_block_group(fs_info, chunk_offset);
  chunk_type = cache->flags;   /* cache may be NULL */

On a corrupt image can contain a chunk item whose matching block group
item is missing, so no block group is ever inserted into the cache. In
that case btrfs_lookup_block_group() returns NULL.

The code only guards this with ASSERT(cache), which becomes a no-op when
CONFIG_BTRFS_ASSERT is disabled. The subsequent dereference of
cache->flags therefore crashes the kernel.

[FIX]
Add a NULL check after btrfs_lookup_block_group() in
btrfs_may_alloc_data_chunk(). If the lookup fails, emit a btrfs_err()
message identifying the affected bytenr and return -EUCLEAN to report
filesystem corruption instead of dereferencing NULL.

The caller already treats negative returns from
btrfs_may_alloc_data_chunk() as fatal errors, so balance aborts cleanly
and reports the corruption to userspace.

Fixes: a6f93c71d412 ("Btrfs: avoid losing data raid profile when deleting a device")
Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4958e074d420..4657b826b48b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3597,7 +3597,12 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 	u64 bytes_used;
 	u64 chunk_type;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
-	ASSERT(cache);
+	if (!cache) {
+		btrfs_err(fs_info,
+			  "balance: chunk at bytenr %llu has no corresponding block group",
+			  chunk_offset);
+		return -EUCLEAN;
+	}
 	chunk_type = cache->flags;
 	btrfs_put_block_group(cache);
 
-- 
2.43.0

