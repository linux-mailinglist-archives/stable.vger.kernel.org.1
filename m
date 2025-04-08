Return-Path: <stable+bounces-128865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD9A7FA29
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B4188612B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADD266B7D;
	Tue,  8 Apr 2025 09:39:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09041264FB0
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105151; cv=none; b=CwInnViCjzJ+LpCrZ+Yfk6z+TDK3XDEqr3/WP7fUkNTqeWneJdopSL6pHgPc7qQZnO3GcEIyWC4D4TMHK+6sJv4OYusNdt6OP6iA5jcZBvnS9NnbWvLdXf3tt2dNJuu/5JCL4QZXZNCHow5crRQ3CN8vF+mIjnZtcxD+XGUF7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105151; c=relaxed/simple;
	bh=ZBSpHawUZqkViNwmas0ZWrllrs/sVUSAx3gAfLYngNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFS3+D2Bz4o6/GB7iOJ2ePupmQV/zW7ujpHxRyJVx9oojYbHI1VXMo1fx5dTRDWWroYcYoRvx3FuuwG65kTmmgUXeLfFYM+KWjvae9Dvba/8958FNfeYITY5oVPiS66oBU87Hi2l86ufRDHSRheJ//QHp4QrcuvnjnsnGzV6ENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A54B1691;
	Tue,  8 Apr 2025 02:39:09 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D6DC3F59E;
	Tue,  8 Apr 2025 02:39:05 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH 6.13.y 1/7] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Tue,  8 Apr 2025 15:08:53 +0530
Message-Id: <20250408093859.1205615-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408093859.1205615-1-anshuman.khandual@arm.com>
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates ID_AA64MMFR0_EL1 register fields as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705]
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b081b54d6d22..a6cbe0dcd63b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1591,6 +1591,7 @@ EndEnum
 UnsignedEnum	59:56	FGT
 	0b0000	NI
 	0b0001	IMP
+	0b0010	FGT2
 EndEnum
 Res0	55:48
 UnsignedEnum	47:44	EXS
@@ -1652,6 +1653,7 @@ Enum	3:0	PARANGE
 	0b0100	44
 	0b0101	48
 	0b0110	52
+	0b0111	56
 EndEnum
 EndSysreg
 
-- 
2.30.2


