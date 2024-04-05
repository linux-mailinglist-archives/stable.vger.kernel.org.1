Return-Path: <stable+bounces-36073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58560899A64
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC15A1F23769
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A107161337;
	Fri,  5 Apr 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C8M420Rj"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556015FD0C
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311895; cv=none; b=OVn74PU3FSoYcvtaHGbRmjy1Q/wLSm/7A5vGOyVfy46u2a2dPLZZjZOVuMmUkv+NXFYeQ3fIBuQgLusAN2DEhiT/Jj5/z7l+dOwqQOMBy1ApeXJYm/fLaRkPVRHczMMQCB+Wze88/6bi7jqRNKpzDde8G66zqajHVaPs5hjdZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311895; c=relaxed/simple;
	bh=ioeKAreBNVwezFuuNwdIg/RC8FseWGJA+QqtnGauHKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIHC22TWqCJb1dOlb2xJ3PKZLhsGNVNds6e6yr6bBCKoqKpRUttaixE3oDk9F/ggyF2fw8Sq+nu8Y1XtWVGs31CH8acNCplBpXxJf3qiAyNzTS6yVRhq12nxVoCkBW+odbEcqHTb9h6agN6GlZt2hrOxFkC+UL4knVfR7eLoCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C8M420Rj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73D4340E0202;
	Fri,  5 Apr 2024 10:11:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JPFmdMySjPwN; Fri,  5 Apr 2024 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712311886; bh=koOjdICNWWMLI8WMBqhkJDwE5lhGccdli7LmBe9DhHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8M420RjvJ04n49eS7QUEIDIcPIFg3d6C57k1jRGERSZRFow2+ai5j1KHKpeCxz11
	 qyztiTKhpndUBVAes8OcMPAFuJA288yVouqB0RsSMPNbWQhJqTaL7PBB7t9XuXZobJ
	 USgVvthlc5/jahPUizRpXSnR0D3VCYnb88nRXJdv+doNiSLmV5Jq8tnlXkdNBiON0l
	 rC9YyPEwf40ocDVFKnYpuuOoXKhvNve0D3dfH9t/CIwOGepUWcw42KiVgA934fkHsB
	 NX165oSkdjRDqrhVXrtHzI3OU9vLEREMuL+FEuemcYrxsgp6yowpPQ+po32qdvXcJn
	 68V4Yg1DKvKntN+AxPQb3hPEwizxkRTeBtt7qg4TX8lS1mcm0qD9g3zTrzIr3H/Q76
	 Jd6qJV5YxrsqWPVAqIoDxwpgENrXZi7vMBGu15haIYG+zRL2QE59TOQJxKZlG3nE2V
	 i+vyQ/I6w7jNDqyTiwD/lpt4D1t1G8NPstXtjQACYl/8eXEG7PKS54d2IK1BqQxo4v
	 b5kdbJmiMRs1EnViLlL6SGT/BNzZybuHrFGmIAKmHwPP23PuTnBlUt2mVHEp9CKJRK
	 Sm7V37Qz2Ib+ww8pMvDf+4qIxPyAMKR9W0kUyIHKST6U7NdSxBbd7ALo3nI6uwGOX3
	 aNzHIp9aYND3R4/zBh46vOwA=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CF5240E0177;
	Fri,  5 Apr 2024 10:11:22 +0000 (UTC)
Date: Fri, 5 Apr 2024 12:11:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 2/2] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO
Message-ID: <20240405101121.GCZg_OSSCQgOPP1csR@fat_crate.local>
References: <2024033030-steam-implosion-5c12@gregkh>
 <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 2 Apr 2024 16:05:49 +0200

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
 arch/x86/lib/retpoline.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 24c850e1e239..a96e816e5ccd 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -110,6 +110,7 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 #endif
 
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

