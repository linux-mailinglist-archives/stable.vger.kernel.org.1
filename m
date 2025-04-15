Return-Path: <stable+bounces-132688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443AA89323
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 06:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F380A1896CD9
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C223D29F;
	Tue, 15 Apr 2025 04:57:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B2AD2C
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693070; cv=none; b=fsI7Ae9gKG/yPLTDMCwNazymbDUbsNlORn5ZKWn2VgpUe2WujSnTmiNxqzb8Bw82zvL2YgZyGwpbs8FMYR8DW8iI0ITdKiZtaRKhtJPHtshKvktQjVmHEHGiKWCR7Guk0bVu1yfkMMn1Qyg7hCVSnACpQUMe8nkjErBCzPa9OMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693070; c=relaxed/simple;
	bh=XsMY9dy/4bkYOVIymG2+3LBlv3ff5zchf7hBj0Hzq68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7nTvE/I96paORFk/3Q8rK3tC/NeGAnA19I+XA3q4GHN5/4kg0QSxW448KUPBDjVwD6QDJ6Z5zp0l1Unl5auil6KWknssXkdXuZaWRd1JjpjDqjmiAN1cqhy8ow1H6kUZaxOAzTGHLldRj5oy1nh3rrFfGEegZoOn/QcP2E5KsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 377B915A1;
	Mon, 14 Apr 2025 21:57:47 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.49.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 100ED3F66E;
	Mon, 14 Apr 2025 21:57:45 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH V2 6.12.y 4/7] arm64/sysreg: Add register fields for HFGITR2_EL2
Date: Tue, 15 Apr 2025 10:27:25 +0530
Message-Id: <20250415045728.2248935-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415045728.2248935-1-anshuman.khandual@arm.com>
References: <20250415045728.2248935-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HFGITR2_EL2 as per the definitions based
on DDI0601 2024-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250203050828.1049370-5-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 9401476f17747586a8bfb29abfdf5ade7a8bceef)
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b46738690d4a..85b93c1f74d3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2694,6 +2694,12 @@ Field	1	AMEVCNTR00_EL0
 Field	0	AMCNTEN0
 EndSysreg
 
+Sysreg	HFGITR2_EL2	3	4	3	1	7
+Res0	63:2
+Field	1	nDCCIVAPS
+Field	0	TSBCSYNC
+EndSysreg
+
 Sysreg	ZCR_EL2	3	4	1	2	0
 Fields	ZCR_ELx
 EndSysreg
-- 
2.30.2


