Return-Path: <stable+bounces-90324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A29BE7BE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DAD283C46
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F521DF25E;
	Wed,  6 Nov 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwQCabKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29A1DE8B4;
	Wed,  6 Nov 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895436; cv=none; b=HMZVNgGbtcs+8OoDeGpksxsbo61t27nN6kpznUfpZPHLxg0/1Ky0qt4z18dmPXx9L7tShtRCp7bpnWWl+UTUTtHmNP7JorUGpOkv7lTHJc3hssVE0ug/DY1NiJ9VgBuRivXNFwol8eBaDYe37JCILagNvuoraFIw6nOH8JF2xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895436; c=relaxed/simple;
	bh=lucF8VKbiy+eXFQv03eGM43L4hVq+x2IWkPtrKpFe94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtblQCz+ZYpeadi177UcJE4xl9HpkeIL13u0kxw5EB+XFR6OqybsZt3V+90QbQthjY2PWE3g1PjpqsZSTnob836aXiMOt2657pF8tdXBr+n3NUAp3dLlLpGpG2+Ygdrr8StQEfPsnej65jC+fX2vc2nt4oSOqTssP6m2xiDTvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwQCabKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF88EC4CED6;
	Wed,  6 Nov 2024 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895436;
	bh=lucF8VKbiy+eXFQv03eGM43L4hVq+x2IWkPtrKpFe94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwQCabKjSufABQCDsgPVIMX+bX/3iBm5523FD5tKJQHx3YoAYBHIrALCamIHogkK5
	 2c/HGwiC66O1nyMorEu2GpLKZ7OLCr3yhSlwqD/1ZXajCSzOcf1wqu1QuHc3IYeAdf
	 PTJOrOo5WqEQrtf0tsYMyOp9di9lIdzGpCvL2aAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 218/350] arm64: cputype: Add Neoverse-N3 definitions
Date: Wed,  6 Nov 2024 13:02:26 +0100
Message-ID: <20241106120326.384709315@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 924725707d80bc2588cefafef76ff3f164d299bc ]

Add cputype definitions for Neoverse-N3. These will be used for errata
detection in subsequent patches.

These values can be found in Table A-261 ("MIDR_EL1 bit descriptions")
in issue 02 of the Neoverse-N3 TRM, which can be found at:

  https://developer.arm.com/documentation/107997/0000/?lang=en

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240930111705.3352047-2-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index e3df8b0c067bf..b8593cebb4ff4 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -98,6 +98,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -143,6 +144,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.43.0




