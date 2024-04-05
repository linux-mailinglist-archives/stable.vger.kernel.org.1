Return-Path: <stable+bounces-36113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11F899F70
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8561EB2382E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98E6CDB7;
	Fri,  5 Apr 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ipFy4wX8"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B21BDDB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326851; cv=none; b=X660g9lOyoBF4NfnCAnh8VEH1I5TSY6gyM7rLlEaHQrGxSznOYrmJPpmWJBNKUemlU4CThVi9eno8D56XaY8hTa/JWvpK3GFAUTdKzcPtzTZ7b4NGiw7BaMRpPoo3Abz6R+7pF4I7xZ0JLCBuV5ncht7UnB3uEtWMgJxnSd9ryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326851; c=relaxed/simple;
	bh=SzssGsNqFVHsUNi9eFWkdxTeVVCSYUS5LUqlRWsaxRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ/dhx+wETvY3QpzP35z+X1GgnCwQXd/S3VjXzhXtU8l5WgPptvWJ/5x9HVPSC969M4ZTkdQliBcF8Y6u4v+LE/noGe0fyO7VoOmXXdjtxoG//i16K07tM4uwOIM4BwI8q3WmMuWok1MOisqKPpx4Ontkk9xXjCC1ZBi88qNjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ipFy4wX8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5178940E019C;
	Fri,  5 Apr 2024 14:20:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kdte1afM0shl; Fri,  5 Apr 2024 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712326840; bh=rcFTE27tUXQdQF4rCGE2HGBNsiKwYhLN2Xk/HZGeyLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipFy4wX8I21pIfK9ICrCPZVKd1qoJyz7Gt2Y+ZXNQfPlX/D3kEpbDLi2H0lUihNA/
	 Eq3/siCegQw9nC1WuWW1r90xL0jsCReuv//VTCKerQdFgHfTsbgE/E6v4jsLJKL7FQ
	 OigfdHd9e5NdG5bII2VAM20LZsjM207GkuJUbEC2j55kLjVuEe6MqbEXY2XR7f69Nn
	 nlVaRn2HDgqA6evsSQce+mCGXaWjXcmmLcN2Ytv5tANzWblxHTfQFwUdCUgMXsQKSN
	 dDrIVYCrEAef9fTKqzSA9M08cFkDlq48rnVeT+gxL0M9727AFjHB7o42BJF39cg8w5
	 2c48xVSSan/xhB1gQL0EGUMt4y3ynmEnbz1W86x76Yo670tc1G4QguqfGSZo2KIPyE
	 bfV8lvVnWxcpYqezl9b44Pz/ZO5rHHM6XSZoijdFxGj5C/8z4+PtN9NrpuppjeQ1p8
	 4D7FxrRDq3gNEIkNFWTHK7ApXyM5z8eAW5DnzpnwtQzoSQalW6lxY4WRoYKBrF200D
	 LEJj+qxyToKKsnai54Zn7uX8+lkRPTZMEDlvA4tjKzCyWnc8HyM1NBYArlMk2KvZJ4
	 YEXpVzX81AEbZdoqCY8wfXfwm2xJ/GvdoxTVengY3bih8T5TUmPtJDLLkMmG35+5w9
	 MVl1QPVXXfYKT8qctOXJpMUY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE00C40E022F;
	Fri,  5 Apr 2024 14:20:36 +0000 (UTC)
Date: Fri, 5 Apr 2024 16:20:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 2/2] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO
Message-ID: <20240405142035.GDZhAIs8LmOTRIpM3U@fat_crate.local>
References: <2024033032-confess-monument-a6db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033032-confess-monument-a6db@gregkh>

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
index 8acafe60220a..019096b66eff 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -108,6 +108,7 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
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

