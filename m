Return-Path: <stable+bounces-108141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE0A07E49
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BDE7A2A74
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BED1850B5;
	Thu,  9 Jan 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kV7xB6JJ"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5E18732E;
	Thu,  9 Jan 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442218; cv=none; b=b/wxlrthCpaKsNgpohB3dW0nQ/Wa92/2yl7dtKMwW0e3n4Q0yeOEXdH1WsKUSDsjGRcyDgUT61iKz3yYgWBWz88SOAmnZRalkWGKn7Wp5+AUA3xo2UcYbQkGTmYCRtRaJyL4HhlEbTmWecoqjp/Tdv1AgDKU1DsCym6fHtzXJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442218; c=relaxed/simple;
	bh=SUejWQaCCQ6UOnlEIF8Y+gc/yElELSYPKQtYJBlFtf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzwUyPYchO3xlgwGGRSzKJ69kCFGW5Pc7+u6vTYcxpSGWsCeFwEuuLKlBbzhagFE5Ur7GGr7l/G6uW+VQPsGSjPF24mBxGeTA7Ackcr113x/zPNgEJtG4+3PP+iERcR8QT8J6dSzd7k+YQJKErJ+YxoSHOMpcUmGFOFdqvBVzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kV7xB6JJ; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CE6ACC0000E8;
	Thu,  9 Jan 2025 08:54:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CE6ACC0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1736441662;
	bh=SUejWQaCCQ6UOnlEIF8Y+gc/yElELSYPKQtYJBlFtf4=;
	h=From:To:Cc:Subject:Date:From;
	b=kV7xB6JJuMPSScCf/QhQbMLjsitXPYL4hv+kABwyIm1cbIjg6l+/kb1Vd092YWPb8
	 Vu+vKfwY8tJ3QhT8fb20fa/174LzSo4n2E8OaYlJYXBOg7gX+BRfolIyu+RnbqNDcp
	 5yqNNviGmgn9Xoq8WBKv7s81grk41SYj0QZypt/s=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 63D2418041CAC6;
	Thu,  9 Jan 2025 08:54:22 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Petr Tesarik <ptesarik@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.4] arm64: mm: account for hotplug memory when randomizing the linear region
Date: Thu,  9 Jan 2025 08:54:16 -0800
Message-ID: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream

As a hardening measure, we currently randomize the placement of
physical memory inside the linear region when KASLR is in effect.
Since the random offset at which to place the available physical
memory inside the linear region is chosen early at boot, it is
based on the memblock description of memory, which does not cover
hotplug memory. The consequence of this is that the randomization
offset may be chosen such that any hotplugged memory located above
memblock_end_of_DRAM() that appears later is pushed off the end of
the linear region, where it cannot be accessed.

So let's limit this randomization of the linear region to ensure
that this can no longer happen, by using the CPU's addressable PA
range instead. As it is guaranteed that no hotpluggable memory will
appear that falls outside of that range, we can safely put this PA
range sized window anywhere in the linear region.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/mm/init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index cbcac03c0e0d..a6034645d6f7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -392,15 +392,18 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-		u64 range = linear_region_size -
-			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+		int parange = cpuid_feature_extract_unsigned_field(
+					mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
+		s64 range = linear_region_size -
+			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
 
 		/*
 		 * If the size of the linear region exceeds, by a sufficient
-		 * margin, the size of the region that the available physical
-		 * memory spans, randomize the linear region as well.
+		 * margin, the size of the region that the physical memory can
+		 * span, randomize the linear region as well.
 		 */
-		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
+		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
 			range /= ARM64_MEMSTART_ALIGN;
 			memstart_addr -= ARM64_MEMSTART_ALIGN *
 					 ((range * memstart_offset_seed) >> 16);
-- 
2.43.0


