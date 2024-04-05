Return-Path: <stable+bounces-36111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15122899EF3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C355E283F3E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054ED16DEAC;
	Fri,  5 Apr 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H+VRS/+l"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86A6CDB7
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325921; cv=none; b=cRDxBDmMoXEYeHnulf1GK6Tu/ut2ajpH6/wIvyvFLjMMuSJ1iH1KfXHWregF9a7f7zfpO25cnP+DuqNrRMQgnjChI9IxQZP5D7HK6VvVLdl4w6fFOysE/vid9KA+OjwIgMMKFu+Lk1PSzhKbOAx5XQXLBjrgm3IQuN9Yr3vto60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325921; c=relaxed/simple;
	bh=SzssGsNqFVHsUNi9eFWkdxTeVVCSYUS5LUqlRWsaxRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGGLjeKbmDEa9YdCn5F2GpGE3mSLwxVKFqT5qHeQVeqws9KwWe3+49irt+iKKo/goew7SacUFg/87JSQxkpJAMMmGQRuqm8OP+0sEo3I4WOPx1uhM2UfU5Vc9/dzl+KWKPCO5lPqTAVN0bZF2Inab8iM8g0LnuphjP18KgF5ibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H+VRS/+l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 128F540E022F;
	Fri,  5 Apr 2024 14:05:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bt98ifEITiX2; Fri,  5 Apr 2024 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712325914; bh=rcFTE27tUXQdQF4rCGE2HGBNsiKwYhLN2Xk/HZGeyLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+VRS/+lBWs5zNAAhQ3g0WGDThPjUrEy0YjYcG3cDtRVnWk1zuatsFETWbc4Tvrbu
	 XLS+ylU286DNxnk9msLhyqZRuX4Yq8bFcgOqLrrIw/KQX4YNPTQ3VBelZQBqjEtufg
	 VJtRM2ZD06i96MDorXgQNmYcrEPSBtps8p7nn5oy50s0/u+DyjQFbyPIjm5j2GrAIS
	 5feJatXIl4DoOkJOBmSMYRiB+Ie183841Hxxv/fWfgE4fUaS+qYUJLuL6ObgxaZ+a6
	 eEGQ/GkeUoKo174F5aGM2DoLbYsNBE1VKqKG3KVS1QIEEBPS5xgm6KwwnfzX1t4V5g
	 /5pQFszjEPdhjHIizosiw9ldLZd2ve+HZesv0jgS+1bMABKpwD8AmWNOs5CotuGABF
	 h3n2tKwDKS6UJ6BA+3oIFPbYuoR5eOpXjzgUfkwNlQaKEMXNjV9y1Uo5BzqujhmOQF
	 dc/DYKaqSu1/Dyw9oaZt5lb7M0RQg1IWtVA13/Ypmhnrz0/JIPgMVNIV36iibGxM5u
	 kClwgMBv4bvRODwHgc8YCD8WG7SjHY4K/Az6ptQzofgtDI9/W/UbYFOxRLt2JEbJ7Z
	 tg4mTClTK/EliQ584m4jakc8+49+Po99VpofIPbEAn/9E4TYgBEMxWmBu3Mpzhw6w1
	 dpm81ZaEaxVnJXign+ma66ec=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D27D40E0202;
	Fri,  5 Apr 2024 14:05:09 +0000 (UTC)
Date: Fri, 5 Apr 2024 16:05:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH 2/2] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO
Message-ID: <20240405140509.GBZhAFFZd2X47gW62r@fat_crate.local>
References: <2024033031-efficient-gallows-6872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024033031-efficient-gallows-6872@gregkh>

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

