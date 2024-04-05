Return-Path: <stable+bounces-36066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D018999D1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A51B211C6
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D06160787;
	Fri,  5 Apr 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Su4S4bsP"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C215FD0D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310241; cv=none; b=jrB+mlqrAG7Z9YTSegeOvyV8jpoaetrMgNpS8aIJZ7w3p+ykWdRokoCGVKkPDGblVebBg+nNFb7/HgBZe8QXFzlJfG9DM5Y53eNSwK2WTVJGdAsfUaZnSgufXAxoaCQlFs2h/h6xCn4lKSGKa76d+L4LLjlntux3ToQFuRjafZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310241; c=relaxed/simple;
	bh=B5ecCd3JuH5rN9XTf8M4jVsDJrZOVGsqRWCW+EiNLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIh9cYDjhBy+BJR8jNJnfHFOI1EzxAudXbLS53ZTbpBnPFOm3sHqxpdlG5wiA8pN0RA1NMvmQlwmoR2htYEobRFgun3ZugYJm+0Zo5rkMpcjXL2uwAhu8yllMwkfxQvVFMBeEqMuuFZRsO039Y6NBce2Ci67kIrJMFb6N/yNpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Su4S4bsP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9CB5040E0202;
	Fri,  5 Apr 2024 09:43:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7wqan2geWHcH; Fri,  5 Apr 2024 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712310230; bh=LpQBJPbsxpz413+JE9maI7LWbt3OxJChn0heChTURk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Su4S4bsPwPJ7oB41IiEawOZNv1VV2WlYLSFCx1w5K6ecRfcGLNd4W+JnyYM176I0W
	 kLkrkkx0+JOVm9boNSciyaDPvLlpULm9OAU3KJxXTYew9Yoc2g+y4MOGvGeRDzbEMv
	 fjOIwG4MIe2MaFP876d5OJ0efg6HH/+tzqa7G0Ek7DlellCOYThwCVH4325kO62s9c
	 lMu48aNAyiSvrdPODWDv/8evHfSeh7RXPgG8ultAYR7SI/zcA5pVchuabI9tsn4jLu
	 nM9XyRU83XMOQ4r8WzSZSea49FNi4KDlZJutwTznRyS8h5UXpKP+PnXFdqeVqlEMrk
	 FSRsJB4CytE/rn1B1h7laEvqVj/UYLoP2S37pXASTKS5tXagNvAbA9CT5DdePpaAoM
	 XL/1YXDKwE6GlDtnQEuT1Jbw4yexacU2R7lwDIliwJpM0ROaMrwy0p7xesT2J0lEIF
	 iPP4Zzrb933SbHNcct4Gcn6T6CbgDi0hJcVY/gS3O2RuEHn4wDC45/gOHkmwXuPIQc
	 +Kx2twdVxShjCwnz7FB74IiAilKmgxpEAMcw88LeuT9xbh3k8m9TMV3Wu5b+dZevIl
	 h9cfERuT19o1byUcx455QCuDVNykaIXifH59xp99skqs5GCL4kzGvCGYfk8VPvok6M
	 IVQebgJqOtMGWzhQE2QBxSRw=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E2A840E019C;
	Fri,  5 Apr 2024 09:43:46 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:43:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO (was: Re: FAILED: patch "[PATCH] x86/bugs: Fix the
 SRSO mitigation on Zen3/4" failed to apply to 6.7-stable tree)
Message-ID: <20240405094345.GBZg_H0Ux-wihEMliP@fat_crate.local>
References: <2024033028-lumpiness-pouch-475f@gregkh>
 <20240331094945.GAZgkxuZYOCg8jwh82@fat_crate.local>
 <2024040138-pardon-recharger-a097@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024040138-pardon-recharger-a097@gregkh>

On Mon, Apr 01, 2024 at 12:44:47PM +0200, Greg KH wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > Date: Thu, 28 Mar 2024 13:59:05 +0100
> > Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4
> > 
> > Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.
> 
> Thanks, both now queued up.

aaand here:

From 4989d1bfae571dbca620a47d16d3d12991f14f16 Mon Sep 17 00:00:00 2001
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

