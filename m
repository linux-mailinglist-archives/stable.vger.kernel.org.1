Return-Path: <stable+bounces-161685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4FB0249F
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 21:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3231CA7400
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831E2EF2BE;
	Fri, 11 Jul 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PfF6HKhg"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA46195B1A
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262252; cv=none; b=JJF+DoOkCm4f9uD7ty/mLuR8hSo+sCiUwi+5Sfm63KamnDT3jfDqpAE20G+HQ3Vs2fmd7Irx3POyGQ1S3P/GjRyr1mRPwhfHUDhrQuMv0corCns+QmlqNuq/uoWOjqH07ZCyoqd3Way+KLpmICH82VCp4ASLsbSTWnhxQ5UM9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262252; c=relaxed/simple;
	bh=CLKvuZC0AXI357NFWfkJCOmQczp/9e0+dlunDLAekPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdff2HdGR/ZA3l1vVFAQFuJ9URVKC381DuKxrtq4sainu5/TyZX5HXiUgJ46SLSACJla9NHkigQ05RZAxhMTngnNQfA+D4gdIvIp2z9xKNgdxsHyHecCccGGLWekDVkZVBSVv4y223tZk1bdXOlLYILUYbim9M6FV5ukzNe90QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PfF6HKhg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7392040E0218;
	Fri, 11 Jul 2025 19:30:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kUwYtr8JNEDD; Fri, 11 Jul 2025 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752262243; bh=COjHzyzgxgi99RFYXuH9Ofd9RVeNooPidwXbnJ/u7eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfF6HKhgmYQkvgL3ArgkgBGOHMUo1fEeadAcF29HITUqIALps/XwkVC8KNzYmjqZI
	 b9l1YBLO+4JvTy435lZsrKn2YaHEf4jkNy3j2ixDmPGRB/4GOBl9UdKG3BAPKtac8i
	 LkCXJA3oQ0+cz8Jpr7ItJ0E+diBiZurgVAJDP+UgLTs1wIJYPMCBjEvOpzmo4BcSoP
	 61XuIe4IcQYc+GvMgWlehdy65cmxpLyG2wCXv9tqaUrlv+8GGszAe+Jsy1HSmYbUeZ
	 Tfc9aJ+CoSU/cdnfSZnovrXNgnKlVuwrNe6RVdNCZz98xfAkqdG6wAZP8zY358KH16
	 KdvSjEzjkUlFdw5BobAnUJrd6K2JLfK4bmNuQFhhhHiqrR639kYTublOvDhBVbrr26
	 PD6VcddsYDo+UxjPar93OvM+K86Un5Rb4EyENTn26c1zR8H3dHARFTeWU6WySMCQ4m
	 knWD6wurtKHYULFGpuqQarIgn7EPeX1M7iQBiWneH5aL+o+z79x6/vl2ZkffkCqCEP
	 amamKPlU3xacAvHnZ8s7o5ibPiWCl8Nb9Pxye3sP1Xid/eV6eDMBqCr5LPKvfB/xHl
	 vLWNWSuJBwAh8aXOqV+xoMduxJ/1UG8scwO4oxfu+a+9Xpe+UKTwjrO3GYqPVEm8TP
	 iCYVphumydUT0nwjaj1rAMf0=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07DEF40E0205;
	Fri, 11 Jul 2025 19:30:40 +0000 (UTC)
Date: Fri, 11 Jul 2025 21:30:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: stable@vger.kernel.org
Cc: Thomas Voegtle <tv@lio96.de>, kim.phillips@amd.com
Subject: [PATCH 6.1-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250711193039.GKaHFmX8215MRwSR_z@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
 <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
 <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
 <3e198176-90c4-4759-84c7-16d79d368ccd@lio96.de>
 <20250711164410.GDaHE_Wrs5lCnxegVz@fat_crate.local>
 <bd209368-4098-df9b-e80d-8dd3521a83ba@lio96.de>
 <20250711174157.GFaHFM5VNp1OynrF7E@fat_crate.local>
 <1a655339-cf7d-d711-f8a9-a5a689422be5@lio96.de>
 <20250711181517.GHaHFUtblXgUqlf-ym@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711181517.GHaHFUtblXgUqlf-ym@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 11 Jul 2025 17:40:18 +0200

In order to simplify backports, I resorted to an older version of the
microcode revision checking which didn't pull in the whole struct
x86_cpu_id matching machinery.

My simpler method, however, forgot to add the extended CPU model to the
patch revision, which lead to mismatches when determining whether TSA
mitigation support is present.

So add that forgotten extended model.

Also, fix a backport mismerge which put tsa_init() where it doesn't
belong.

This is a stable-only fix and the preference is to do it this way
because it is a lot simpler. Also, the Fixes: tag below points to the
respective stable patch.

Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
---
 arch/x86/kernel/cpu/amd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3e3679709e90..4785d41558d6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -561,6 +561,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (c->x86 == 0x19) {
@@ -675,6 +676,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -719,8 +722,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			goto clear_sev;
 
 
-	tsa_init(c);
-
 		return;
 
 clear_all:
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

