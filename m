Return-Path: <stable+bounces-36057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441F899995
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DAC283487
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF41DFED;
	Fri,  5 Apr 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a3t5Cxze"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BE142E73
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309832; cv=none; b=GEQEj9AEGA3J15vpDPnnCFD9hBRhSvD0J2Jpfook1NSI2uv/nUVm7HOeH+48t9Z1/hqsEsXyekfywmgxahWIMewpW7IN177gr1CEEwEe++ZOn39Fd/H/mMasmJ/HUd+87p+VKYIkG/HD4p+6IU4Rpts3UqGo2Uq+WiSHmpGAfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309832; c=relaxed/simple;
	bh=aTS4txhtplo9NsFBGmMNVJW8h/o8NYkzFJxcyg2QfAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjOPBUdtWDurnZgXfbqHFSr9fxVTSQuz0dCG3cdHIpL3SEQHgEG6WBUBg/faaa61dEmEi3o+/BQA5F3D5NfPRdcwxP5+H2rkIVoRFiRMrV9TPi3oVNcv0encu+aCp7PiFcmqXlgC3xkgRrT99UXL5WSy9dJJQwyE62RANo7//tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a3t5Cxze; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FA2940E0202;
	Fri,  5 Apr 2024 09:37:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bKlcNK67cj0n; Fri,  5 Apr 2024 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712309821; bh=wSVD1itqhYwpO89y4cttISniUCW/2NaybzHE6N2CFfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3t5CxzezbqXpL+qgvdWA+1RMPD3TWdM2zK7YdPFAcMg3ygT9/m9cNWlMnZwooDMR
	 KKrJeGQSHaPNp1j9CfFswZEAQIgrzNE2Kw6OBOkILbTTTmkK3lEJCcFMXgLzOSljkT
	 2wjG+/zIr6pVzv3b/P0rWRlcHYClIPKI2sdTBNOYw6dUWOGwFjCaDfcwPX9K87pYAR
	 N/SL/kO1r9ThoJDqU9Ic0r2xPi14CeO/SMkh6VJyfHmDBqDFxKIJbb/tQ+zFKcUshn
	 Oui98BJFVmoKKJK+634rmBquGisJi3QDievJTGXEK9g5cEPIQMBHJD6MdHOyoShK5l
	 3UJTjLDhoyPObjnKB6OyYu9H0dxBNPrrvp1WZpG+95PvDa4wXmIn4MmE9McjagZZtu
	 UbOuSGsfG03wBjGTnO7GonPGDLpxd9+Z4Zc0UtA8506o8/gi55dLMO47vtBKGgDo9Q
	 PHLLh7xzfP+rHC5AHyvN+3PsHnC8xbe2eWiXs4r4UohFXwTIkcHSHv42pIFCgD0azr
	 vvut0XCOpOFL04w78LminHUlm4Kgp737CHrBk7+Sx+52B4vnBwQupsxxcCm/iKzUFW
	 rpHdWLRLZeewq4NW+f03vwoA4plDA4KPBMgvhiciwJgcaF/8QCPWmfndJ8iU40TC5S
	 eSfURf0kqjlBvEJ8OU6By/pA=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AA2F40E0192;
	Fri,  5 Apr 2024 09:36:57 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:36:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO (was: Re: FAILED: patch "[PATCH] x86/bugs: Fix the
 SRSO mitigation on Zen3/4" failed to apply to 6.8-stable tree)
Message-ID: <20240405093651.GAZg_GM7n1rcbfxdGj@fat_crate.local>
References: <2024033027-tapered-curly-3516@gregkh>
 <20240330224026.GAZgiU2jlEEovxGO2y@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240330224026.GAZgiU2jlEEovxGO2y@fat_crate.local>

On Sat, Mar 30, 2024 at 11:40:26PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 28 Mar 2024 13:59:05 +0100
> Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4
> 
> Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.

One more ontop because one is clearly not enough and I'm a moron. :-\

From 20ff7c032fae1f6c78bc6bf06ea9a3f2bc3cb207 Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 2 Apr 2024 16:05:49 +0200
Subject: [PATCH] x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Commit 0e110732473e14d6520e49d75d2c88ef7d46fe67 upstream.

The srso_alias_untrain_ret() dummy thunk in the !CONFIG_MITIGATION_SRSO
case is there only for the altenative in CALL_UNTRAIN_RET to have
a symbol to resolve.

However, testing with kernels which don't have CONFIG_MITIGATION_SRSO
enabled, leads to the warning in patch_return() to fire:

  missing return thunk: srso_alias_untrain_ret+0x0/0x10-0x0: eb 0e 66 66 2e
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:826 apply_returns (arch/x86/kernel/alternative.c:826

Put in a plain "ret" there so that gcc doesn't put a return thunk in
in its place which special and gets checked.

In addition:

  ERROR: modpost: "srso_alias_untrain_ret" [arch/x86/kvm/kvm-amd.ko] undefined!
  make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Chyba 1
  make[1]: *** [/usr/src/linux-6.8.3/Makefile:1873: modpost] Chyba 2
  make: *** [Makefile:240: __sub-make] Chyba 2

since !SRSO builds would use the dummy return thunk as reported by
petr.pisar@atlas.cz, https://bugzilla.kernel.org/show_bug.cgi?id=218679.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404020901.da75a60f-oliver.sang@intel.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/202404020901.da75a60f-oliver.sang@intel.com/
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/lib/retpoline.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 1e59367b4681..7c51a5323eca 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -229,8 +229,11 @@ SYM_CODE_END(srso_return_thunk)
 #define JMP_SRSO_UNTRAIN_RET "ud2"
 /* Dummy for the alternative in CALL_UNTRAIN_RET. */
 SYM_CODE_START(srso_alias_untrain_ret)
-	RET
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 #endif /* CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

