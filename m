Return-Path: <stable+bounces-108138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D6A07E35
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB44168F76
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA0189915;
	Thu,  9 Jan 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GafJDr1M"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0518C00B;
	Thu,  9 Jan 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442019; cv=none; b=olC9LPlp85NjyZJT0cW4Zykkbf58qTjtHZErEhyk7+YVjrdMDDYxjWF0bcrRsPE3L5dg94LKbvVfUnXxLVMw5W+Q3lUu/gsvxi4jJyydr+5H1rVT3maGcfIOxp0dKX01u2IadmX+q+I0OMrBCgsYwSsN/egNmBgqMhqf7oyIM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442019; c=relaxed/simple;
	bh=gDEC6eC+hE/3rES1P+/GSapucTV+adxfwsIx2MfNOTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA+6RlZKKePg7W/GwAZ1fL5TGj0MsXskudLhOiqiouFXC+0lZ2Swbkx5g4TKRF+DU8DkETuPkIz0gpfp4eG3gRnjQVii+ipPRQB4wCCqnIuFg+BWQKvstMqBSgcMdryhkOELH0Gh/ynIS7mbXEq3c4l8fhzYULxORALTFix1YDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GafJDr1M; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A74E0C003ACE;
	Thu,  9 Jan 2025 08:54:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A74E0C003ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1736441663;
	bh=gDEC6eC+hE/3rES1P+/GSapucTV+adxfwsIx2MfNOTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GafJDr1M7LLL8Re1WOBG//t/CK5O5LXkj23wghl1l1b2R3G0f2PhuavAuM1HotAKR
	 nEgGHP2iSD8mzeWz7oP7acYTGpe3VPk3voOV6b/h3DgwjQbZ+JvXYu+bJmEuAVazrj
	 ud2oKTCWavkpWEmmikeDeoyTHRAWFohBeAmh1Xuc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3F51018041CAC6;
	Thu,  9 Jan 2025 08:54:23 -0800 (PST)
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
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: mm: account for hotplug memory when randomizing the linear region
Date: Thu,  9 Jan 2025 08:54:17 -0800
Message-ID: <20250109165419.1623683-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
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
index 80cc79760e8e..09c219aa9d78 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -401,15 +401,18 @@ void __init arm64_memblock_init(void)
 
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


