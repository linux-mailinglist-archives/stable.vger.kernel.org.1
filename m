Return-Path: <stable+bounces-192213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4FC2C6D4
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8F63AC4E1
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDC31282A;
	Mon,  3 Nov 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DW3Hb58O"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AED3115A5;
	Mon,  3 Nov 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180101; cv=none; b=j2Qds3fSDqj2tU6UOMkM/uMWxuROeslehi9Uvsnc4/qciE0O3TcN9Ar6O8IBP2YDhczjLcberntuoSJhXbcUpVPCA5jYWRfzgpw2mykDuLsN5j+VhSQIan89+zVl37Lm9czy0XDNs8LIklphzVN+8NfMGOEfmOLFKuEtGt4wep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180101; c=relaxed/simple;
	bh=NEmLnCxweseSAXUrFNHIvk7MkUMBwh9+saonIoa8t3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1bK6e5x3mR1LWQi8C8huYOP1oisoEgNwZmUExKTGo5MzNK0y3uA15YhBJkX+0ksAbOgLjUQSYNNZP0lyUQuR4BHOWJxdv/iJpq/rRIdbgDL9W4CU6BqAPecCuOGmP37wqGqq5FpiNvEbacF8grTNYY6OuYYYhFYADQzg1Q2Mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DW3Hb58O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5ADA440E01A5;
	Mon,  3 Nov 2025 14:28:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Aar49mkZkxOI; Mon,  3 Nov 2025 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762180092; bh=z/fhKiHX76PNvIIe2VEepLKf3GmqcJpE4QLQk/h/lUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DW3Hb58OYGdV7uxPS34QauHPWufFKAMK4w8g6s2FJ/IvgRerUJEI0snlZRvLxivgf
	 IQ/KIIDaFwfYTQwl1ybKgeJgwsmATRRdkXFzX849eHaUFvjam3ZzBjdAOIxXnbIAy/
	 DE+IHdSDCV9CWeR2L5L5IGGn5JlUII6lU/L3jyGm/iTahyI/HBAJZjihNjsVxmhRGO
	 xavHT71gH8JGh48s4pNWICuPqjPro0hxGpYf01ghIvyzeTCSkdRtsutbVyx43lybXZ
	 cFkefpD8uExZtVDFKm2LIAMMvoVhWaJ1yBVCKUXia7RmGM1zojTG1GqoeguYRMRWS+
	 XexcoF7cwrpfxRDAMJDNeCJ1Zem3iJuSMWKgEhafetLwbrg7WzlQUuXEdjlzU8q3YZ
	 JdXTOLRCfMQ0CPR4PeJ/NgCtQniFwiK/gYsU/0n6NUo2X5nPVBKbCC4SGjt79HFobe
	 xAYFsZ7udgyXrthA4LKwXpS8B0/rRQ6aMexo6cXzqQZ2RfbswswAfxkWAi8TMIt8yn
	 mjE7t4WiNEQAw4r/yq2jqTPjoFbudeYFRec08BsQGmEfObeoHepddkOjeTyuki2bEo
	 k1QFCLQZ6+d/8T+4TrPzNo+Jpu6DTJPVb7SiyC+5LmheK66v/zgbz+a1XxrjJtXPHn
	 XrLyRmxSLGajlFOJiHokhoHg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AE9A340E019D;
	Mon,  3 Nov 2025 14:28:06 +0000 (UTC)
Date: Mon, 3 Nov 2025 15:28:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Jung <ptr1337@cachyos.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
Message-ID: <20251103142800.GFaQi78AgT-qjY30r3@fat_crate.local>
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
 <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>

On Mon, Nov 03, 2025 at 02:59:11PM +0100, Peter Jung wrote:
> CachyOS is compiling the packages with -march=znver5 and the GCC compiler
> currently does pass RDSEED.

Yah, the compiler should not *pass* RDSEED, but issue code which checks
whether RDSEED is there. Otherwise what's the point of CPUID flags?!

I guess this should make those boxes boot but damn, that ain't right:

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8e36964a7721..810be49dad31 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1044,8 +1044,7 @@ static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
 	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
 		clear_cpu_cap(c, X86_FEATURE_RDSEED);
-		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
-		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
+		WARN_ONCE(1, "RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
 	}
 }
 
> This patch results into that also Client CPUs (Strix Point, Granite Ridge),
> can not execute this. There has been a microcode fix deployed in
> linux-firmware for Turin, but no other microcode changes seen yet.
> 
> I think it would be possible to exclude clients or providing a fix for this.

Client fixes are getting ready but I can't tell you when they'll be there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

