Return-Path: <stable+bounces-192855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A875C444C7
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB941188904D
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532821FF25;
	Sun,  9 Nov 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKFSODqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2561FF7C8;
	Sun,  9 Nov 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711567; cv=none; b=YUtDDIVPXmVjpvf29aGBai7m7xqTG7MRLtpNhzXuGyCcsPfn/PFlN/1i9C8mF8l/BBERQL+m37B8y6kq4VL3JfLYIgYaOb5PN6KeRpxYDsuZBQZtjzIuo5pjoT5xhf+ORR45V30/Z2VdbYXRHZ+qmwfA1Gzw4ghiQ4SX+n8okTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711567; c=relaxed/simple;
	bh=Rv5rj91RamEanT2fugz7Olj75634AA1cClCMNmzZM78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HwlOrWmwSaJwm134nuEP7nLZaext2ep9qPSd0BV27oiiGC0DRdMdfqn6xW0xC85XGqSnX/pdktysVHDRfSRRwozBUitEVuSzFkGgCGreVbnSI9F2uG8q2bORKPJv+gRaXhL+Dg8Ah2c6ke+pdLmCJHYAZM6Dz7ytVJ4Tc0N9Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKFSODqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A6A3C4CEFB;
	Sun,  9 Nov 2025 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711565;
	bh=Rv5rj91RamEanT2fugz7Olj75634AA1cClCMNmzZM78=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CKFSODqkHQ7lajblVBiiunadMTS7FxkMrl1FUVEvYMWbPrVewMnYvqw8Faz3HSOHO
	 wYK0mqHj+P2DdQ3JWU7IW/l/lQv80/cz4hMzJDLxS4C5PeWLUnY0mEKaq1a7+sIXVn
	 EjGCP/7Y/yBMCHwbqMyCahOB+JqzGM62GNRR1Upx/hRUyHPFUxZhPCtGyNavZ9A22A
	 gh56UNc9kT501DhHTzC6x5HwA137NrxgsCmANUK2SpLPWKfvhF9zmOUWHuVkJd/6OB
	 TjT1USFaxAkDaiX2NXDcq/tHsexW4Zh3Z3pN5fD87c1sBohbGazNj0magcn8QZ/8MJ
	 NqJVH4OMboX3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F4CCF9F8;
	Sun,  9 Nov 2025 18:06:05 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 10 Nov 2025 02:06:03 +0800
Subject: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
X-B4-Tracking: v=1; b=H4sIAArYEGkC/x2MQQqAIBAAvxJ7TnAtSftKdNBaay8WGhGEf086D
 szMC5kSU4axeSHRzZmPWAHbBpbdxY0Er5VBSaURpRVVonSJwWjVe6kDuk7I3qGy2lMwDmp5Jgr
 8/NdpLuUDy1WRSmUAAAA=
X-Change-ID: 20251109-revert-78524b05f1a3-04a1295bef8a
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762711563; l=4133;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=alE+X02rbk4jwNfT7auzmxmmmbItfQDo8i+kaNeAHjY=;
 b=y+ozs+sm7ni2QmqCYkgxfgsn49ITpx52INQ0Dq+5Kq9kcCBk7gA/JGdd6qZOmhRbyTjalAn2s
 R3zWuGKIM3zBS6pl2r1pQbcyZsst8HOxUqBN0/qrRpv0I1JrjRU40Ny
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

From: Kairui Song <kasong@tencent.com>

This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.

While reviewing recent leaf entry changes, I noticed that commit
78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
correct. It's true that most all callers of __read_swap_cache_async are
already holding a swap entry reference, so the repeated swap device
pinning isn't needed on the same swap device, but it is possible that
VMA readahead (swap_vma_readahead()) may encounter swap entries from a
different swap device when there are multiple swap devices, and call
__read_swap_cache_async without holding a reference to that swap device.

So it is possible to cause a UAF if swapoff of device A raced with
swapin on device B, and VMA readahead tries to read swap entries from
device A. It's not easy to trigger but in theory possible to cause real
issues. And besides, that commit made swap more vulnerable to issues
like corrupted page tables.

Just revert it. __read_swap_cache_async isn't that sensitive to
performance after all, as it's mostly used for SSD/HDD swap devices with
readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
1 entries, but very soon we will have a new helper and routine for
such devices, so they will never touch this helper or have redundant
swap device reference overhead.

Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 14 ++++++--------
 mm/zswap.c      |  8 +-------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3f85a1c4cfd9..0c25675de977 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -406,13 +406,17 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	struct swap_info_struct *si;
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
+
 	for (;;) {
 		int err;
 
@@ -499,6 +503,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	put_swap_folio(new_folio, entry);
 	folio_unlock(new_folio);
 put_and_return:
+	put_swap_device(si);
 	if (!(*new_page_allocated) && new_folio)
 		folio_put(new_folio);
 	return result;
@@ -518,16 +523,11 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug)
 {
-	struct swap_info_struct *si;
 	bool page_allocated;
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
 
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
-
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
@@ -535,8 +535,6 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	if (page_allocated)
 		swap_read_folio(folio, plug);
-
-	put_swap_device(si);
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 5d0f8b13a958..aefe71fd160c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1005,18 +1005,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
-	struct swap_info_struct *si;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
-	si = get_swap_device(swpentry);
-	if (!si)
-		return -EEXIST;
-
 	mpol = get_task_policy(current);
 	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
-			NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
-	put_swap_device(si);
+				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
 	if (!folio)
 		return -ENOMEM;
 

---
base-commit: 02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
change-id: 20251109-revert-78524b05f1a3-04a1295bef8a

Best regards,
-- 
Kairui Song <kasong@tencent.com>



