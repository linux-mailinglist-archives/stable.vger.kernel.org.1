Return-Path: <stable+bounces-13150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF6837AB1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929C01C25568
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD48130E3E;
	Tue, 23 Jan 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUuajNMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B512FF86;
	Tue, 23 Jan 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969059; cv=none; b=dXRYC1QgP+K5k+rcVH1MQVNMBzOca75ViOQlWnCMQ6qWfCg18PfrWyQYYDCgS0EO6DsNgL+EvLfTQMpabUhxNMLPKWzcZ2z3d+hT5UsftEzS9pZ6acKu9gqmwvvxJ+uvC6oYo266kgpCEVkYa/nkTuQ/DB8PnDKrXXwcCsS9pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969059; c=relaxed/simple;
	bh=/t/knAq6OKAu9gT+72C5z/53mNexMv6pbHnmh3H0Gr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha6gHQT8Z/K1dakKVRX41C8Ywhjf+JRnJsiFl8wLRX8Zw9jcUSUHwQJL4EgLYLMu8KBDzvgmiWxsbOFI/sW941nEkfVv1oK5Tu99QKwETIokBfXLOAMOfqS3jzqkS6COhtzmAyBA3L55ryBYIewd7G7NWtkf9OOJwcObWVjT1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xUuajNMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4973C43390;
	Tue, 23 Jan 2024 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969058;
	bh=/t/knAq6OKAu9gT+72C5z/53mNexMv6pbHnmh3H0Gr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xUuajNMl9pYOawzGwJ+PfgjTBSXHkoCNZkPCMy5KmuvjyulFbgBJcQd4AY9t7Xa48
	 uv5v5jETghNaF874mMzXYOUmeh+3Po5OFGZ2X2vpbPRN5ChcMaD06ZrccXyaag76Wr
	 8ccJxJzpSL/sV5hV0MvQp2ivNv3AXKl59Tm/tMR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 163/194] mips: Fix incorrect max_low_pfn adjustment
Date: Mon, 22 Jan 2024 15:58:13 -0800
Message-ID: <20240122235726.185528021@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 0f5cc249ff73552d3bd864e62f85841dafaa107d ]

max_low_pfn variable is incorrectly adjusted if the kernel is built with
high memory support and the later is detected in a running system, so the
memory which actually can be directly mapped is getting into the highmem
zone. See the ZONE_NORMAL range on my MIPS32r5 system:

> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   Normal   [mem 0x0000000001000000-0x0000000007ffffff]
>   HighMem  [mem 0x0000000008000000-0x000000020fffffff]

while the zones are supposed to look as follows:

> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   Normal   [mem 0x0000000001000000-0x000000001fffffff]
>   HighMem  [mem 0x0000000020000000-0x000000020fffffff]

Even though the physical memory within the range [0x08000000;0x20000000]
belongs to MMIO on our system, we don't really want it to be considered as
high memory since on MIPS32 that range still can be directly mapped.

Note there might be other problems caused by the max_low_pfn variable
misconfiguration. For instance high_memory variable is initialize with
virtual address corresponding to the max_low_pfn PFN, and by design it
must define the upper bound on direct map memory, then end of the normal
zone. That in its turn potentially may cause problems in accessing the
memory by means of the /dev/mem and /dev/kmem devices.

Let's fix the discovered misconfiguration then. It turns out the commit
a94e4f24ec83 ("MIPS: init: Drop boot_mem_map") didn't introduce the
max_low_pfn adjustment quite correct. If the kernel is built with high
memory support and the system is equipped with high memory, the
max_low_pfn variable will need to be initialized with PFN of the most
upper directly reachable memory address so the zone normal would be
correctly setup. On MIPS that PFN corresponds to PFN_DOWN(HIGHMEM_START).
If the system is built with no high memory support and one is detected in
the running system, we'll just need to adjust the max_pfn variable to
discard the found high memory from the system and leave the max_low_pfn as
is, since the later will be less than PFN_DOWN(HIGHMEM_START) anyway by
design of the for_each_memblock() loop performed a bit early in the
bootmem_init() method.

Fixes: a94e4f24ec83 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1c4114f8f9aa..0419629aee60 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -362,11 +362,11 @@ static void __init bootmem_init(void)
 		panic("Incorrect memory mapping !!!");
 
 	if (max_pfn > PFN_DOWN(HIGHMEM_START)) {
+		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 #ifdef CONFIG_HIGHMEM
-		highstart_pfn = PFN_DOWN(HIGHMEM_START);
+		highstart_pfn = max_low_pfn;
 		highend_pfn = max_pfn;
 #else
-		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 		max_pfn = max_low_pfn;
 #endif
 	}
-- 
2.43.0




