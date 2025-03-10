Return-Path: <stable+bounces-122952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4DA5A230
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E1E3ACDA5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9E235BFB;
	Mon, 10 Mar 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfGPTqSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F12356CC;
	Mon, 10 Mar 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630615; cv=none; b=LEBf5m89W/nFdvRFZLk1dm+SujypX/dsZ97/3TaTe5YEYKhBFgLPQyb5kfBbS50mZNF5Oz+9T06wWU0VB/jBXxGPsxyn17rzCJqzJBKu6Yg2iGs27CgR2llvc/5TMZPtzvsufwdY3AQXRVGdrxC3aVB05Hlm3jSWCOMxctx2QeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630615; c=relaxed/simple;
	bh=1MZMPWzCMZWrdo32MdzpveWwwuxpTSzeuKI8I27CGyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gN/JU25yev7ZNX0BoVfZPWHIqy+C8mXjsWcmDRvi+MqhhK6owG1eqeQemkEmQQqSjGcdLdv7iQ+6F0p66wO0RmSqUtOA4aXDE32HTlft7JDTT4Qb1rqvtD9bP2p0CQQRNQkBD74w45QqsWdg/ZXJnhlrHOO0rLp4mmkgx/2jPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfGPTqSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C9C4CEE5;
	Mon, 10 Mar 2025 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630614;
	bh=1MZMPWzCMZWrdo32MdzpveWwwuxpTSzeuKI8I27CGyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfGPTqSKShdFlOApgmV5zQ9Z7i0iZeMWEHffz4XT0pxD39B+PLAUWto+DctEEVgAp
	 YZH7VpBuv+SVbjt0gizatg3dTLigGRaDzQlsXxpsA0My8xLECgU62r01+ZfYUqCIU4
	 2gi71sjscX6hMX/mu6tbCW03EQZx+1GE3bmgRIm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yan Zhai <yan@cloudflare.com>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 475/620] bpf: skip non exist keys in generic_map_lookup_batch
Date: Mon, 10 Mar 2025 18:05:21 +0100
Message-ID: <20250310170604.327067846@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 5644c6b50ffee0a56c1e01430a8c88e34decb120 ]

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

Rather, do not retry in generic_map_lookup_batch. If it finds a non
existing element, skip to the next key. This simple solution comes with
a price that transient errors may not be recovered, and the iteration
might cycle back to the first key under parallel deletion. For example,
Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:

For LPM trie map:
(1) ->map_get_next_key(map, prev_key, key) returns a valid key

(2) bpf_map_copy_value() return -ENOMENT
It means the key must be deleted concurrently.

(3) goto next_key
It swaps the prev_key and key

(4) ->map_get_next_key(map, prev_key, key) again
prev_key points to a non-existing key, for LPM trie it will treat just
like prev_key=NULL case, the returned key will be duplicated.

With the retry logic, the iteration can continue to the key next to the
deleted one. But if we directly skip to the next key, the iteration loop
would restart from the first key for the lpm_trie type.

However, not all races may be recovered. For example, if current key is
deleted after instead of before bpf_map_copy_value, or if the prev_key
also gets deleted, then the loop will still restart from the first key
for lpm_tire anyway. For generic lookup it might be better to stay
simple, i.e. just skip to the next key. To guarantee that the output
keys are not duplicated, it is better to implement map type specific
batch operations, which can properly lock the trie and synchronize with
concurrent mutators.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 37aa1e319165f..7fce461eae102 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1435,8 +1435,6 @@ int generic_map_update_batch(struct bpf_map *map,
 	return err;
 }
 
-#define MAP_LOOKUP_RETRIES 3
-
 int generic_map_lookup_batch(struct bpf_map *map,
 				    const union bpf_attr *attr,
 				    union bpf_attr __user *uattr)
@@ -1446,8 +1444,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -1493,14 +1491,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -1515,12 +1507,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
-- 
2.39.5




