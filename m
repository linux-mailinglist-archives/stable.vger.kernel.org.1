Return-Path: <stable+bounces-161684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CAAB02482
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 21:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FD189C15D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9921DF751;
	Fri, 11 Jul 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FKznPd+K"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876ED1DDA14
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261850; cv=none; b=MEoVaoO0olwHc+WhIgFMnX82/Auectw62PsGoMRcEVFfAhZ8U3GlJCq06hRg7o91GZhUQ9sdwuBb/EoZ1LmX1md3uabphtK7OT1xCMz9cBq9seFi12AV+iFngcOb+vfUUA7AzjBJbTefBz/uZvg3YKHh+n90QMpxfRCpCExmTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261850; c=relaxed/simple;
	bh=45ciwg7WzjkYlJAH1eAwteqLNP++zw1qAxVexagPOPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5cm2jqieq5YR0YfOoREKeOTjKSEZVddooAZ6YRynj6Z/eaSpkQUTXBziL4tPBvG6AOEGWYYoammXx6mPXgNhSBDWII4tYIOOk+r59cFqh+/OIybrtEPZWLjpVCEbEszBnTxkwBWCOb+XHQMp8ngk6B/53aAyIh/By3GUaHpT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FKznPd+K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7538740E020E;
	Fri, 11 Jul 2025 19:24:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EZ__DWNgWtba; Fri, 11 Jul 2025 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752261842; bh=LmQBQ/35IVlvHcyOrAIVu+n80qban/AE5xgmwLVembA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKznPd+K2Wyw4PJxZbkYXpPSlY5ki2NgKa8RJVu3V+DY9erE5QXBV4T58E653N/1c
	 xZXv8Kbm5S3Iwgk2DpLw8c/csXHL6LNsqZ2+6rCqNOE+1mV5ZOt2qvHAIWyMgXMFWi
	 pgb0V4nkF3fIM+g5611c61G95Wv9xXO/pq8vBQdMnp3b3AXJS4l88wIro3kNGFMhXn
	 u6iqaoCtxVHzUAxh5l6iR60aww3/LFqnALPsdgyqdAwf4YDJPg6XwgJvpccFPgnBnM
	 vkVrE6nnJbL9Imjv1ov5FMGyy4woYTUvZkxrDsfulRcV21EheHUr8Q6uRPTqCNScd1
	 Fq8zmHEmfJk1iyfwXz0u8wkAn6a6JCwu08h+JyAQH86Pocyg2fqj7w2cSZw/9EFD67
	 TZs3DGZthcW1rONaW4fJL+HCsmmgE/vywsODlIu0n1AJG5oT6kwI8DFsMB3TzLznp4
	 7MdFJLX9446ORj5J3B0lqto0EHIDI/HVhoPI3671d/3znuZqkkCWL4D9OxSaqegPdg
	 EDhT3wZ6hEN+NQI6cWuN/F4P+cC0Z1h7M6aR2GFlZ/+l3F9DmQBs0qL1gxGvSTfLG8
	 6CSwZVhhmwm01H/aVwAT+4F8nAox1x3uy/FpibhRECoa2Hgp3+9nqwux5DOXZhbz74
	 DCZywK/ZTou5DLEu4hO4oQ64=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89D9740E0205;
	Fri, 11 Jul 2025 19:23:59 +0000 (UTC)
Date: Fri, 11 Jul 2025 21:23:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: stable@vger.kernel.org
Cc: Thomas Voegtle <tv@lio96.de>, kim.phillips@amd.com
Subject: [PATCH 6.6-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250711192358.GJaHFkzpM1GPcNQz6v@fat_crate.local>
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

This is a stable-only fix and the preference is to do it this way
because it is a lot simpler. Also, the Fixes: tag below points to the
respective stable patch.

Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Thomas Voegtle <tv@lio96.de>
Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1180689a2390..f6690df70b43 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -547,6 +547,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

