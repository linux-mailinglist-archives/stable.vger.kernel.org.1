Return-Path: <stable+bounces-161680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512EB022DD
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304031C286AC
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40792F0059;
	Fri, 11 Jul 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YN3s5fne"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43C2F5E
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255728; cv=none; b=IAHxQ4orROKo1CD+wiYpn/ab+rbCTVDNUdCKL2a+qOWyG1NisLHf2zP9zQbN/d08y0pRC0SgnkOhMo2B5tYS7dHkxf5siM8Vy1VxKloB+bOWwYWO8+P1sbje/Pn7Rr+jdTpgaJR78DW2PXC5YS4YOpacANRhbubGFxP8Qi/Klvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255728; c=relaxed/simple;
	bh=vW9RB+CLtsW8i/YBz2x7SXXa56vKbHWSPhRowt9tAGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNx3vrM+IgSJSnPM3pk5MUyBHsrWI+vPjJaNEsSQEUr7kdmqNyMNFC88OyEIPv17Pv6iolfLSuhVC7ZPz6oqa9eQWujfdc7L8oi/l0JAI+WZJsgf/z+aKdAaaIuFDkU3dwAJT9rgeNoru7b/uONHk77HBLlj7HjPXIs7TI4ZSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YN3s5fne; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B58FE40E0218;
	Fri, 11 Jul 2025 17:42:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SDR9MHovWMiG; Fri, 11 Jul 2025 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752255721; bh=9gO1doysETNpwp16K83QpiAJ0YTibbezf8Szr/Weg08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YN3s5fneU2f4rRe6RZrmz9de16AoqKrOCy3nsGWUNaV6u947L3YP68bKY/TR7hJA+
	 DyR8Eh9qt8SJYigcXm5gUGWnI9MCWZDnWXWcArgvh1eW7XzmBFB/hsfGmFxB4hYxnI
	 x8ygfSAoDXTzEhYL4h0uZiuYp7rUzfJaKujEoHYCzUd5S8hscfh/7LFCGx89uNR+PJ
	 t6pjvy2cjaCOyNU03jmBUWAmrH5A/N0gikvn1nw+KBEuS/NrDzfvzYHEx6uPvY4qn7
	 9ovcL1MwazO45KCg8OXFhLQd2n5RVk/PfDqOy+EZK42WAoZwImshVHC2c4FP1dui/3
	 YixrMogD4MizLkwy/WoQtYezGttquznpvgK0q1gasCa4i9eNjrTIzyY8VzRHhfEDLG
	 FOD6JbASWKvcLP6tnhUdRTVIve1mtod5Duth/wV2f1dWO/GslY5zM/DMc4R9OKQl0l
	 hjq1Yz3wwPHX422GojbnEwrATCHrYNJj5Pl/RAyqsV2FbgMVrt4e4OAFm7+ONPQ5g+
	 Bm8e8T9+me19YB9TGgNOhWA79IECI6mJfoToRXHsccuQ9a6zQlyToQX1GQoJNK6Gdn
	 F5A9t38U1SDmkqh14Vs4odSPXvNqbylXYJnp4xkKXbOV+zmGyNNYaSEIPbceiUnx66
	 +D1Z4nZXby3flyY/rtHveI84=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B00D40E0202;
	Fri, 11 Jul 2025 17:41:58 +0000 (UTC)
Date: Fri, 11 Jul 2025 19:41:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, kim.phillips@amd.com
Subject: Re: TSA mitigation doesn't work on 6.6.y
Message-ID: <20250711174157.GFaHFM5VNp1OynrF7E@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
 <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
 <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
 <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>
 <20250711164410.GDaHE_Wrs5lCnxegVz@fat_crate.local>
 <bd209368-4098-df9b-e80d-8dd3521a83ba@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd209368-4098-df9b-e80d-8dd3521a83ba@lio96.de>

On Fri, Jul 11, 2025 at 06:56:18PM +0200, Thomas Voegtle wrote:
> And then I tried 5.15.187, patch applies, but doesn't work.

Pff, try this:

---

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d409ba7fba85..8b9753d4822d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -590,6 +590,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (c->x86 == 0x19) {
@@ -611,12 +612,15 @@ static bool amd_check_tsa_microcode(void)
 		case 0xa70c0:	min_rev = 0x0a70c008; break;
 		case 0xaa002:	min_rev = 0x0aa00216; break;
 		default:
-			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+			pr_info("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
 				 __func__, p.ucode_rev, c->microcode);
 			return false;
 		}
 	}
 
+	pr_info("c->microcode: 0x%x, min_rev: 0x%x, ucode_rev: 0x%x\n",
+		c->microcode, min_rev, p.ucode_rev);
+
 	if (!min_rev)
 		return false;
 
@@ -704,6 +708,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -743,8 +749,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			goto clear_sev;
 
 
-	tsa_init(c);
-
 		return;
 
 clear_all:


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

