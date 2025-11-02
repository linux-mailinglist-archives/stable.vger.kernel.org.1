Return-Path: <stable+bounces-192073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD60C293DF
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 18:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E793AC520
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35C15CD7E;
	Sun,  2 Nov 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sz1X+gWU"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9B34D38C
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762104684; cv=none; b=juZFomLvxsVhV7zOtR3xtVS7TAJbCO7d2Kt/00AisUT9Ue6xaKWMd3DuuSjm8ZCeeXCutaKp7js6vk08wQVaN7cPhhIXOu09djmk+v/SqbQFv//9dj7MDmSqR77DuFiUy+dcATqfbvlodX7QixbB1L7oGwR9FVBlZagX8Aa0yuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762104684; c=relaxed/simple;
	bh=KT+3xNmmXkZfE+QOZ5X/kJmwpHaC64dSt4rtqNBTnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts6InPDD189+t01822PNNYgpoYba1JTxajKnB0pstOkCHU8rwPruxsfJRNceztr099V2nR5+LFYVKX3UtQoWvh7jRg5kXzwex0dF+T/FNARoOYwbGHY5YPucx16fGcuY2XgYmHYEoOgkzKtW4PpPEyv8P2bNFnF1UQz+34Ir3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sz1X+gWU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54F8340E0191;
	Sun,  2 Nov 2025 17:31:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UOVUPol9Id_l; Sun,  2 Nov 2025 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762104673; bh=SHbeK0pLv0ak7cNQHtPxB5NLTpO8b2wH4YlVVbUzvZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz1X+gWU7EtYCry8/KLkXjOSg9uMZIm/QdsG1KR8xRV+reqYA4uOfilMbaySpapVe
	 a9oonH68yqrVElUCshxDxu0klFzvHuELWsgRWVBlMMvMKqHW/ZNcJk07zdHZzkbg8g
	 xm90H7Oq4OiIsfvlHewsoKqPNr6MOaQ9BK+LAg+m5mTcf1fhBX3F9MZeV+9hHhGcNr
	 N1X6B4B1kT2TSfbcodYoKLGW57GuOYhkHTIoIJKHKQSHwmbCf8G66TxNkYJMRC/bKK
	 kkS7JQiW2CZyioV9bZZYwncCN+jKtSfwNKcVkTfd0/HvMnNBCMDF1lHPGF4v9CG0hr
	 AH2dxivIu21yme2eq/VCgfCJBnaK1MueH2hdoybvkDksnU57VGTCP5+eU05MwyXflC
	 7AuaN+15b8E1nTWzeoFwwxdjHN8PzzmlTQEdrQkg88klDajkTXltRfuDpSYyfknT8Q
	 +gm25uLLogTUmQW2usYNCJS4AQLLlpZBdnJDwcn9ENOUy546XgdPmL6kENQBWYD8/l
	 FKSTMqRCCdQURegi32IUFeHzxDxZ8pXaLEKvng3a1fGTWAPafs5qV/NFCf0QEC6bKS
	 WLD0jE4yEG9kjIglC6UxQ/QkgocTbOYSpziM0+OU6Fi5aWaF6IVTYgqLVx0KDeNS7H
	 A4NqQdzis+iW2+xX8RY8Gp5c=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4058140E00DA;
	Sun,  2 Nov 2025 17:31:10 +0000 (UTC)
Date: Sun, 2 Nov 2025 18:31:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: gourry@gourry.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5"
 failed to apply to 6.12-stable tree
Message-ID: <20251102173101.GBaQeVVeAvolV0UMAv@fat_crate.local>
References: <2025110202-attendant-curtain-cd04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025110202-attendant-curtain-cd04@gregkh>

On Sun, Nov 02, 2025 at 11:19:02PM +0900, gregkh@linuxfoundation.org wrote:
> +static const struct x86_cpu_id zen5_rdseed_microcode[] = {
> +	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
> +	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
> +};

Yeah, we don't have that min microcode gunk with the device_id match so we'll
have to do something like we did for TSA. I.e., below.

I'll test it tomorrow to make sure it doesn't do any cat incinerations :-P

---

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 18518a481016..437c1db652e9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1018,14 +1018,39 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 	}
 }
 
-static const struct x86_cpu_id zen5_rdseed_microcode[] = {
-	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
-	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
-};
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
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
-	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
+	if (!check_rdseed_microcode()) {
 		clear_cpu_cap(c, X86_FEATURE_RDSEED);
 		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

