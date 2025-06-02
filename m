Return-Path: <stable+bounces-149691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17CDACB304
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21AD7A133B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA6226556;
	Mon,  2 Jun 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdWQH/Mt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857B22652D;
	Mon,  2 Jun 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874732; cv=none; b=Bkuu1VRG0ZQeY6HynQZUwHrqaCvBOKSskz3q/7NYVWCJanR84iSd0tYsYx8ni123nYyBTLzK9vOsrHMzePjOlvp5pkHeR9+fvLwW66KGxiQJmnKI4FCxLAewKuNWvqM5pmYiVpGCBdGPcwqyqmL31rZN7WdkgGXr7zj9uQ+UrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874732; c=relaxed/simple;
	bh=Utr3J9NOjwpsRwL/je6NjDQx/h9x2M5C5Lj68vOIW3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXJRVJNpS4eWvRso3mrFrufjWW3n4hta55oCK/HO6Uyf3x+2DJIR8i8tBl7pLyiCsu32EwQEdu16+8J38hGazobnN59mIBr5C/jKHm1UXU02Djh/Kt0QhXMQubmojtoKBhWaQLsz+uNPfyaqnFofuJegEHVlAK/ALERRolQzfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdWQH/Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA9C4CEEB;
	Mon,  2 Jun 2025 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874731;
	bh=Utr3J9NOjwpsRwL/je6NjDQx/h9x2M5C5Lj68vOIW3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdWQH/Mtdwa+/n1jD7P1Eqw4riy25KKCqgAFDzBdsgD1tsNd74VtPbeM1oKqNzusr
	 3stEuz4ey47/vbgxt4prMhglTzvo7KK28djZrkoDoENfXTBmVK7JASgA8ZkhHX2TrM
	 BF8P6N/4uSbh97R0H/IRwKxx7DfSCG7K5wKWg0ss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/204] dm cache: prevent BUG_ON by blocking retries on failed device resumes
Date: Mon,  2 Jun 2025 15:47:32 +0200
Message-ID: <20250602134300.331623874@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming-Hung Tsai <mtsai@redhat.com>

[ Upstream commit 5da692e2262b8f81993baa9592f57d12c2703dea ]

A cache device failing to resume due to mapping errors should not be
retried, as the failure leaves a partially initialized policy object.
Repeating the resume operation risks triggering BUG_ON when reloading
cache mappings into the incomplete policy object.

Reproduce steps:

1. create a cache metadata consisting of 512 or more cache blocks,
   with some mappings stored in the first array block of the mapping
   array. Here we use cache_restore v1.0 to build the metadata.

cat <<EOF >> cmeta.xml
<superblock uuid="" block_size="128" nr_cache_blocks="512" \
policy="smq" hint_width="4">
  <mappings>
    <mapping cache_block="0" origin_block="0" dirty="false"/>
  </mappings>
</superblock>
EOF
dmsetup create cmeta --table "0 8192 linear /dev/sdc 0"
cache_restore -i cmeta.xml -o /dev/mapper/cmeta --metadata-version=2
dmsetup remove cmeta

2. wipe the second array block of the mapping array to simulate
   data degradations.

mapping_root=$(dd if=/dev/sdc bs=1c count=8 skip=192 \
2>/dev/null | hexdump -e '1/8 "%u\n"')
ablock=$(dd if=/dev/sdc bs=1c count=8 skip=$((4096*mapping_root+2056)) \
2>/dev/null | hexdump -e '1/8 "%u\n"')
dd if=/dev/zero of=/dev/sdc bs=4k count=1 seek=$ablock

3. try bringing up the cache device. The resume is expected to fail
   due to the broken array block.

dmsetup create cmeta --table "0 8192 linear /dev/sdc 0"
dmsetup create cdata --table "0 65536 linear /dev/sdc 8192"
dmsetup create corig --table "0 524288 linear /dev/sdc 262144"
dmsetup create cache --notable
dmsetup load cache --table "0 524288 cache /dev/mapper/cmeta \
/dev/mapper/cdata /dev/mapper/corig 128 2 metadata2 writethrough smq 0"
dmsetup resume cache

4. try resuming the cache again. An unexpected BUG_ON is triggered
   while loading cache mappings.

dmsetup resume cache

Kernel logs:

(snip)
------------[ cut here ]------------
kernel BUG at drivers/md/dm-cache-policy-smq.c:752!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 332 Comm: dmsetup Not tainted 6.13.4 #3
RIP: 0010:smq_load_mapping+0x3e5/0x570

Fix by disallowing resume operations for devices that failed the
initial attempt.

Signed-off-by: Ming-Hung Tsai <mtsai@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index c1d2e3376afcd..0aa22a994c86a 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2996,6 +2996,27 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
 	return to_cblock(size);
 }
 
+static bool can_resume(struct cache *cache)
+{
+	/*
+	 * Disallow retrying the resume operation for devices that failed the
+	 * first resume attempt, as the failure leaves the policy object partially
+	 * initialized. Retrying could trigger BUG_ON when loading cache mappings
+	 * into the incomplete policy object.
+	 */
+	if (cache->sized && !cache->loaded_mappings) {
+		if (get_cache_mode(cache) != CM_WRITE)
+			DMERR("%s: unable to resume a failed-loaded cache, please check metadata.",
+			      cache_device_name(cache));
+		else
+			DMERR("%s: unable to resume cache due to missing proper cache table reload",
+			      cache_device_name(cache));
+		return false;
+	}
+
+	return true;
+}
+
 static bool can_resize(struct cache *cache, dm_cblock_t new_size)
 {
 	if (from_cblock(new_size) > from_cblock(cache->cache_size)) {
@@ -3044,6 +3065,9 @@ static int cache_preresume(struct dm_target *ti)
 	struct cache *cache = ti->private;
 	dm_cblock_t csize = get_cache_dev_size(cache);
 
+	if (!can_resume(cache))
+		return -EINVAL;
+
 	/*
 	 * Check to see if the cache has resized.
 	 */
-- 
2.39.5




