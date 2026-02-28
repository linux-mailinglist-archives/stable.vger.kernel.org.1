Return-Path: <stable+bounces-220851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HziIN1Go2li+wQAu9opvQ
	(envelope-from <stable+bounces-220851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:49:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B718C1C766A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EF8E31868CD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48541AB30;
	Sat, 28 Feb 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9K1gK8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A641AB26;
	Sat, 28 Feb 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300737; cv=none; b=VcI0AqDpyGuYA0Uau2+pZ4h0bPZWWuFbsR4lAudd7+cfT0J72aZJABtWyFVEyXfFianUuk0CkvzwJcryiaGD0gtleKoGjNJp5D/B1DQP62UTUzvL/dbiE9RvVRt4ius/3brbg1zwmYHuPHKqWtC76I9QOh76QgxE9ZQordcYTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300737; c=relaxed/simple;
	bh=+QmB+On8mef2rFA1QxU+2uPtpps85pIbmRUMtawkgk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVCK+PmBWYl/Y3PgYHF945vVAn7eVYuv1kHNdRnyeTeAogbDf1BS9N9jqFU1IPASoLYVYa9X/gOzkKw/xYfn36YVQttrvwihml2BWWQf1TWhT2tUyp2psFa07aZbvk/NnmDrJi/Sql15yEh5mUBK9T9qYtrLZcBunMAT2ZZzvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9K1gK8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1EFC2BC87;
	Sat, 28 Feb 2026 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300737;
	bh=+QmB+On8mef2rFA1QxU+2uPtpps85pIbmRUMtawkgk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9K1gK8h7b0mkB0y26mz3eAQ26w2SayD7CCyHEFa70lnJNAxUgJicJ7szoV64qX+Q
	 p/stI4Mqdtzk8Rl7z9fNj/RftJUz89QcuN+a8JXeGOaCv2nXbD2c8MDkEmbbjHW2A2
	 yTFEMzSz1EWAiU1QCFYQTq3QwskgH3AxME55bllz3DsqDm7pwfCiJ6SGfQkUqx1h+3
	 FnyjJq67u81v877gz6PBZSNx2hBRZqhRMZnOFTGDGuClY7y8fejtvE2b+ChirwtUx4
	 q3qrfbHMKcFp7BRX938CLIhNRvLbU0dJFHgr5h2dVdIy1QlZQYRbqNEUT2DdpxcPDK
	 wf6sbVmvSPF2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 772/844] LoongArch: Prefer top-down allocation after arch_mem_init()
Date: Sat, 28 Feb 2026 12:31:25 -0500
Message-ID: <20260228173244.1509663-773-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220851-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B718C1C766A
X-Rspamd-Action: no action

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 2172d6ebac9372eb01fe4505a53e18cb061e103b ]

Currently we use bottom-up allocation after sparse_init(), the reason is
sparse_init() need a lot of memory, and bottom-up allocation may exhaust
precious low memory (below 4GB). On the other hand, SWIOTLB and CMA need
low memories for DMA32, so swiotlb_init() and dma_contiguous_reserve()
need bottom-up allocation.

Since swiotlb_init() and dma_contiguous_reserve() are both called in
arch_mem_init(), we no longer need bottom-up allocation after that. So
we set the allocation policy to top-down at the end of arch_mem_init(),
in order to avoid later memory allocations (such as KASAN) exhaust low
memory.

This solve at least two problems:
1. Some buggy BIOSes use 0xfd000000~0xfe000000 for secondary CPUs, but
   didn't reserve this range, which causes smpboot failures.
2. Some DMA32 devices, such as Loongson-DRM and OHCI, cannot work with
   KASAN enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 20cb6f3064568..2b260d15b2e25 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -421,6 +421,7 @@ static void __init arch_mem_init(char **cmdline_p)
 				   PFN_UP(__pa_symbol(&__nosave_end)));
 
 	memblock_dump_all();
+	memblock_set_bottom_up(false);
 
 	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
 }
-- 
2.51.0


