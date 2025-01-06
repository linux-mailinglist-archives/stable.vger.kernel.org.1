Return-Path: <stable+bounces-106887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F6A02928
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CE23A4D9A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29B149C7B;
	Mon,  6 Jan 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVIg1kzP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56562200A3;
	Mon,  6 Jan 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176807; cv=none; b=rfsWpf7h35ddHVoxw7y05k5Nlj4kS3/TxFfYdnUlf/OkowCyBwA05Zd/3dalr9TVASKF0Ie7yuBtro/iV7ZzdckrrvbUN4HN5VwwfKGblZzjzRgbaPvOcHyvFSTF1oVyGSnTOQSJ1krJ+5kddsdn1RiQy/tGuPXb4i9na6HCXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176807; c=relaxed/simple;
	bh=rTlFC/tfDeyQX8/LjON9ooYgnwLDwXJQaADAKgqQHd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAyEDn58i50u8k8UU9UqEtBy+1f1gTOO/dgquZ1c6fzlX1tGgbpAAkBqndCW2tUWLwfJ+klt1DVysFd8oiIiuItKj4baGhARBbKkMN4by/A42Jr08KuabF+BxlEgf8ZOqfHb91XT9IpR4r6e5H7RPmxw1F9LY2B21jRZfnViJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nVIg1kzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A300C4CED2;
	Mon,  6 Jan 2025 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176807;
	bh=rTlFC/tfDeyQX8/LjON9ooYgnwLDwXJQaADAKgqQHd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVIg1kzPjLUTesFTEJoqXAQRhv2d1BTiqCicu5jlMI1BYx5kjxGxvn++T8NQriUA2
	 GwHMtUnhhA0IFHm5OcUtYMvsA/EvdZXK2u+4bMjLERm95dSJjjJWr7arEt3ZdDB1Gw
	 nRLN3VlHyiTe+6IcYAPKRrLtQ19aPDsMCP1b4XIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 38/81] netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext
Date: Mon,  6 Jan 2025 16:16:10 +0100
Message-ID: <20250106151130.876187789@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 542ed8145e6f9392e3d0a86a0e9027d2ffd183e4 ]

Access to genmask field in struct nft_set_ext results in unaligned
atomic read:

[   72.130109] Unable to handle kernel paging request at virtual address ffff0000c2bb708c
[   72.131036] Mem abort info:
[   72.131213]   ESR = 0x0000000096000021
[   72.131446]   EC = 0x25: DABT (current EL), IL = 32 bits
[   72.132209]   SET = 0, FnV = 0
[   72.133216]   EA = 0, S1PTW = 0
[   72.134080]   FSC = 0x21: alignment fault
[   72.135593] Data abort info:
[   72.137194]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[   72.142351]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   72.145989]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   72.150115] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000237d27000
[   72.154893] [ffff0000c2bb708c] pgd=0000000000000000, p4d=180000023ffff403, pud=180000023f84b403, pmd=180000023f835403,
+pte=0068000102bb7707
[   72.163021] Internal error: Oops: 0000000096000021 [#1] SMP
[...]
[   72.170041] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G            E      6.13.0-rc3+ #2
[   72.170509] Tainted: [E]=UNSIGNED_MODULE
[   72.170720] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202302-for-qemu 03/01/2023
[   72.171192] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
[   72.171552] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   72.171915] pc : nft_rhash_gc+0x200/0x2d8 [nf_tables]
[   72.172166] lr : nft_rhash_gc+0x128/0x2d8 [nf_tables]
[   72.172546] sp : ffff800081f2bce0
[   72.172724] x29: ffff800081f2bd40 x28: ffff0000c2bb708c x27: 0000000000000038
[   72.173078] x26: ffff0000c6780ef0 x25: ffff0000c643df00 x24: ffff0000c6778f78
[   72.173431] x23: 000000000000001a x22: ffff0000c4b1f000 x21: ffff0000c6780f78
[   72.173782] x20: ffff0000c2bb70dc x19: ffff0000c2bb7080 x18: 0000000000000000
[   72.174135] x17: ffff0000c0a4e1c0 x16: 0000000000003000 x15: 0000ac26d173b978
[   72.174485] x14: ffffffffffffffff x13: 0000000000000030 x12: ffff0000c6780ef0
[   72.174841] x11: 0000000000000000 x10: ffff800081f2bcf8 x9 : ffff0000c3000000
[   72.175193] x8 : 00000000000004be x7 : 0000000000000000 x6 : 0000000000000000
[   72.175544] x5 : 0000000000000040 x4 : ffff0000c3000010 x3 : 0000000000000000
[   72.175871] x2 : 0000000000003a98 x1 : ffff0000c2bb708c x0 : 0000000000000004
[   72.176207] Call trace:
[   72.176316]  nft_rhash_gc+0x200/0x2d8 [nf_tables] (P)
[   72.176653]  process_one_work+0x178/0x3d0
[   72.176831]  worker_thread+0x200/0x3f0
[   72.176995]  kthread+0xe8/0xf8
[   72.177130]  ret_from_fork+0x10/0x20
[   72.177289] Code: 54fff984 d503201f d2800080 91003261 (f820303f)
[   72.177557] ---[ end trace 0000000000000000 ]---

Align struct nft_set_ext to word size to address this and
documentation it.

pahole reports that this increases the size of elements for rhash and
pipapo in 8 bytes on x86_64.

Fixes: 7ffc7481153b ("netfilter: nft_set_hash: skip duplicated elements pending gc run")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index c24b04235d91..d11398aa642e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -706,15 +706,18 @@ struct nft_set_ext_tmpl {
 /**
  *	struct nft_set_ext - set extensions
  *
- *	@genmask: generation mask
+ *	@genmask: generation mask, but also flags (see NFT_SET_ELEM_DEAD_BIT)
  *	@offset: offsets of individual extension types
  *	@data: beginning of extension data
+ *
+ *	This structure must be aligned to word size, otherwise atomic bitops
+ *	on genmask field can cause alignment failure on some archs.
  */
 struct nft_set_ext {
 	u8	genmask;
 	u8	offset[NFT_SET_EXT_NUM];
 	char	data[];
-};
+} __aligned(BITS_PER_LONG / 8);
 
 static inline void nft_set_ext_prepare(struct nft_set_ext_tmpl *tmpl)
 {
-- 
2.39.5




