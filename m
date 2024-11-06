Return-Path: <stable+bounces-91686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84199BF375
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1A1F21621
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFB20408D;
	Wed,  6 Nov 2024 16:42:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816013C67C
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911357; cv=none; b=HMfTDnPAVMUJDkeTAdJ9vcKb+qrspPg9Q4HzFvfxzkaykq6M2XtKMyYsi60RfcgSfcSWeJuE/WzGRbvUpFETL3Az5aVrEtVzuA3szOYVj+enezP00b8qvOU4XHeNvII6+1outMT9UOYXV8Kk+p1xJO/8Z0R1d0YpgPRoobC+278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911357; c=relaxed/simple;
	bh=J05UC5jAyhKIHR89QRoV6TOinAB1UBpSuX8cAseNo8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odfF9zq9GXwJHzxk19lKDalDYhGYe7kYkdUEUt2PMSL8bvZz7pJwbyeemGK6lyNx1AKmqn76Tkh3Xl9AUlAcAZRG8fRkTE+5KkVWLl4gOFxuUpZS241FR4dJwX8jgb6ZQFou9kIBKh8TWztLgv3g8/6ZuLANv6H6s9PEwapo4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87D131063;
	Wed,  6 Nov 2024 08:43:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F4673F528;
	Wed,  6 Nov 2024 08:42:33 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ardb@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH] arm64: Kconfig: Make SME depend on BROKEN for now
Date: Wed,  6 Nov 2024 16:42:20 +0000
Message-Id: <20241106164220.2789279-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although support for SME was merged in v5.19, we've since uncovered a
number of issues with the implementation, including issues which might
corrupt the FPSIMD/SVE/SME state of arbitrary tasks. While there are
patches to address some of these issues, ongoing review has highlighted
additional functional problems, and more time is necessary to analyse
and fix these.

For now, mark SME as BROKEN in the hope that we can fix things properly
in the near future. As SME is an OPTIONAL part of ARMv9.2+, and there is
very little extant hardware, this should not adversely affect the vast
majority of users.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Catalin, Will, if we take this, the minimal set of other fixes necessary
for now is:

* "arm64/sve: Discard stale CPU state when handling SVE traps"
  https://lore.kernel.org/linux-arm-kernel/20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org/
  https://lore.kernel.org/linux-arm-kernel/ZypuQNhWHKut8mLl@J2N7QTR9R3.cambridge.arm.com/
  (already queued by Will in for-next/fixes)

* "arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint"
  https://lore.kernel.org/linux-arm-kernel/20241106160448.2712997-1-mark.rutland@arm.com/

Mark.

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e29b44d2d7bd..14cc81e154ee2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2213,6 +2213,7 @@ config ARM64_SME
 	bool "ARM Scalable Matrix Extension support"
 	default y
 	depends on ARM64_SVE
+	depends on BROKEN
 	help
 	  The Scalable Matrix Extension (SME) is an extension to the AArch64
 	  execution state which utilises a substantial subset of the SVE
-- 
2.30.2


