Return-Path: <stable+bounces-192202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C5C2BD27
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFE318970FF
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5212E62C0;
	Mon,  3 Nov 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LoKaGIqG"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435D2D23B1
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174130; cv=none; b=R61sV+542djreGwtR4ScGj54ROTK5YlRjK5RFcWcu6uC7aRCKCcMx0lIYUpENQuuBXsLM80PITUJdwwxRtubnlrlXSX0LOAdVoLqm9HvcqSVtL1kPyOJ+/EAgV3PW71Tg5dSzw5v/qnscdYUYsoGd9JRTklgGl+8qT/LtGPd9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174130; c=relaxed/simple;
	bh=3pLVMmOEgVZAPVwKKjVt2XZ1jILtKXzJ2lYNXe960dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFDk+8xf+xNO9w/duiGr3wmdk4CsPxCHEtbh4ZlZ6bBjWDEXTb9sjxagLNM1/Oh/Jy9T/0Y3nMkDctx6AU8TjFz+Dj1DPqJ6En0Z0n9JzhW7VF1GTnnOks0yW6TGKh+UwHEhMPdHuVdZfOHbJK4yBOkd/QEBMKUXrOPxgDLjXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LoKaGIqG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1B0F740E00DA;
	Mon,  3 Nov 2025 12:48:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WpYUeF_sjlqm; Mon,  3 Nov 2025 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762174122; bh=jPd0k/uQmC8di7yQp/ORGNojPuAG7aUR5YyWD+vFaMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoKaGIqGmxsWkyN5rpLcA0k2eptZgB6rknwST8bzxSl7SCMNlsV0u/UCCMuph8Sf4
	 vaX3D/IzegXvlMbgftJp4vtYGR1SdLYFtnHGeE1x0JEzutZEk8S+XwnZTKmMSq2vIb
	 nCYL9AQ4ha860eqh2W1UgpD6L3N5RHDKrXCu7Jp9bX6+hEHghmnvq8o8PQLjRIP+gN
	 mm1kueuBQcN1UWd04vXDQ49Os9R6z9YB6rTMXWilInBgNRiJG9xtioRlhqdMvvg2PM
	 HyDEQe0L1GsJuoBOQigvp15rhPrzsTJFAY+G/T25jgU1SBEDXPR/ARWZ7eI0BTWKoU
	 joXYDsc6M0t58xRwsffwvhGL2RBSaTy6tywlvTHLTzpMyH/TsipXDNYXaxgXMDzxqY
	 DK2bRsv/AmJFOhWGZdUKXvyUSypVFX2QLhJWvw21P3jr3ERYB8koVUA25V57aoYTp5
	 j/onhSZhD08DAg6ls5C1vWDHG2D8gqQdYN2sOXD9KVZm5p5+HEtpXSw1vvn79mRPdf
	 MrOv4PgNQ43jho0+0U42ayH0QXESikfY8NStI3G6rQuWt56LVE+Op38iqcF5Sh0Rbu
	 Y+y/yKqgOnq8OFcPvJE7zEhqg6XV7KBEVHSJnH2l6cLMlEbTfcBqAd45r/9xIudx+n
	 Qnlok5H0mkVKBDzCmkab4TQ8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6CD2B40E01A5;
	Mon,  3 Nov 2025 12:48:39 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:48:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gourry@gourry.net, stable@vger.kernel.org
Subject: [PATCH 6.12] x86/CPU/AMD: Add RDSEED fix for Zen5
Message-ID: <20251103124838.GDaQikpkmcuOfdkylJ@fat_crate.local>
References: <2025110202-attendant-curtain-cd04@gregkh>
 <20251102173101.GBaQeVVeAvolV0UMAv@fat_crate.local>
 <2025110330-algorithm-sixfold-607b@gregkh>
 <20251103120550.GBaQianhX2N2SEKwzz@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103120550.GBaQianhX2N2SEKwzz@fat_crate.local>

From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5

Commit 607b9fb2ce248cc5b633c5949e0153838992c152 upstream.

There's an issue with RDSEED's 16-bit and 32-bit register output
variants on Zen5 which return a random value of 0 "at a rate inconsistent
with randomness while incorrectly signaling success (CF=1)". Search the
web for AMD-SB-7055 for more detail.

Add a fix glue which checks microcode revisions.

  [ bp: Add microcode revisions checking, rewrite. ]
  [ bp: 6.12 backport: use the alternative microcode version checking. ]

Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.net
---
 arch/x86/kernel/cpu/amd.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4810271302d0..437c1db652e9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1018,8 +1018,43 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 	}
 }
 
+static bool check_rdseed_microcode(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	union zen_patch_rev p;
+	u32 min_rev = 0;
+
+	p.ext_fam	= c->x86 - 0xf;
+	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
+	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
+
+	if (cpu_has(c, X86_FEATURE_ZEN5)) {
+		switch (p.ucode_rev >> 8) {
+		case 0xb0021:	min_rev = 0xb00215a; break;
+		case 0xb1010:	min_rev = 0xb101054; break;
+		default:
+			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+				 __func__, p.ucode_rev, c->microcode);
+			return false;
+		}
+	}
+
+	if (!min_rev)
+		return false;
+
+	return c->microcode >= min_rev;
+}
+
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
+	if (!check_rdseed_microcode()) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
+	}
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

