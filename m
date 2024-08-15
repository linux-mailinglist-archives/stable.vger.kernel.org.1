Return-Path: <stable+bounces-68286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB395317F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22D61F216EF
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633119DF58;
	Thu, 15 Aug 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFMaYIJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5618D630;
	Thu, 15 Aug 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730087; cv=none; b=ABuyIkHpIJtr4VCQDAY86i25UpVE1wWzgfNZgeK7z6noem03jCdXTnjrWk6ljoKcG2J6aMwmIkTFgGifwRKM542m0Cisuk3qzMS0uDILMYjPmEInZVEZldKUdQNK406unqGumvv66iU+LElUsy3KJQMaJ30tPmmnm2013FTjmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730087; c=relaxed/simple;
	bh=IbozPNPm2WIjulk4lJL74GM1+MxMCM2E57o7xWQte9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu6T6PGw37LEgQzkimfxWtsx8qYpapwGdLD7MfSzLnna/0ecIox3c5MprSTAyhqLyLGlT4/PU4/CLT9IrizG1b1Tzwalu+U6a27U3tpo6F4Ah6II6QWnRnWVQ79IeDFjLROR3EGyJghOf+1Fs0T7RBIJr7a+xoJBXzeSMRWYBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFMaYIJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B79C32786;
	Thu, 15 Aug 2024 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730087;
	bh=IbozPNPm2WIjulk4lJL74GM1+MxMCM2E57o7xWQte9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFMaYIJGFVkiM/iT9lB27OYlBiOGOE2cOWCaqYC6ics+xG0qjYW7tpEGIlecXXyIp
	 IFbKAMc7morLrZp35H4ty8RnPWE5BlimTZlWkTyPy3SAlHw045+FiHxK4o2HYkl4Kf
	 qZrLTmPMulPOmNbQS56VV++jytLfguOmXMbsBjEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 270/484] MIPS: SMP-CPS: Fix address for GCR_ACCESS register for CM3 and later
Date: Thu, 15 Aug 2024 15:22:08 +0200
Message-ID: <20240815131951.832627565@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit a263e5f309f32301e1f3ad113293f4e68a82a646 ]

When the CM block migrated from CM2.5 to CM3.0, the address offset for
the Global CSR Access Privilege register was modified. We saw this in
the "MIPS64 I6500 Multiprocessing System Programmer's Guide," it is
stated that "the Global CSR Access Privilege register is located at
offset 0x0120" in section 5.4. It is at least the same for I6400.

This fix allows to use the VP cores in SMP mode if the reset values
were modified by the bootloader.

Based on the work of Vladimir Kondratiev
<vladimir.kondratiev@mobileye.com> and the feedback from Jiaxun Yang
<jiaxun.yang@flygoat.com>.

Fixes: 197e89e0984a ("MIPS: mips-cm: Implement mips_cm_revision")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mips-cm.h | 4 ++++
 arch/mips/kernel/smp-cps.c      | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b17..696b40beb774f 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -228,6 +228,10 @@ GCR_ACCESSOR_RO(32, 0x0d0, gic_status)
 GCR_ACCESSOR_RO(32, 0x0f0, cpc_status)
 #define CM_GCR_CPC_STATUS_EX			BIT(0)
 
+/* GCR_ACCESS - Controls core/IOCU access to GCRs */
+GCR_ACCESSOR_RW(32, 0x120, access_cm3)
+#define CM_GCR_ACCESS_ACCESSEN			GENMASK(7, 0)
+
 /* GCR_L2_CONFIG - Indicates L2 cache configuration when Config5.L2C=1 */
 GCR_ACCESSOR_RW(32, 0x130, l2_config)
 #define CM_GCR_L2_CONFIG_BYPASS			BIT(20)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index f2df0cae1b4d9..7409d46ce31a8 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -230,7 +230,10 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
 	/* Ensure the core can access the GCRs */
-	set_gcr_access(1 << core);
+	if (mips_cm_revision() < CM_REV_CM3)
+		set_gcr_access(1 << core);
+	else
+		set_gcr_access_cm3(1 << core);
 
 	if (mips_cpc_present()) {
 		/* Reset the core */
-- 
2.43.0




