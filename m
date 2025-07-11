Return-Path: <stable+bounces-161683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE1B0246D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 21:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A804A2504
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061B2F3624;
	Fri, 11 Jul 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="INvkQXxn"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7041D6DB9
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261543; cv=none; b=s614G4NK44dImI96GuTv6mn0NQjUj6seR/4BROBteYuuTZ9rhelS+BfIa4PV7sc9D2Kywi08Df9hXhnLGpNVsmrpSpOlMZw0nOsyuDhrfeaTrWJqspqYl13etmKEIHybbtkUX81RaPVgpj0wXMyURyqXF6AnK7u6N+hOfbISsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261543; c=relaxed/simple;
	bh=ikfF1pLIFhvk4RV0O0Zcy3ccpTSW9rpB1ZK/ujlWv8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmP0Pl0nP8ceJ0oJ0UDoE6f1cWf8Gtk5UfpbWOjK4W46ZEx5VYIow1MFwxEfTjGYjkQyMCmQKyTxo5GO4elP38sRQSOhiIkReXdfurorJb1jDX5b56XMVRVC79IACqNMxRiw/xCZ7t8dcq4dj5dFpepzJU/nQbQji5X8zhcGQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=INvkQXxn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5807440E021F;
	Fri, 11 Jul 2025 19:18:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hyggb9I8vn24; Fri, 11 Jul 2025 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752261533; bh=3Z8qKzSmCS05blOxnaDp598xbLY3FI+wTGI/plycgRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INvkQXxnoN0mH5Hr/qciDJe6rvKk1a1J7/GOWvqZiUqBQACAIYIgTzUiW9w9cYv8G
	 UFd2w8XGfAgnDIsVrmwHJKISit2sVZnyNhqyqQIhuwh0y6bhWMF2zou5ih1M2OfE62
	 VB76WXEcrDvBSQybIbvexbyJmHfYLAj4RuOcG75niHGC0eb3+66+SCRTr7xA8MsUzV
	 tmVtFqisg1WFgaTdZSGMDs3jlwRAUkUgmV29ceZ7TIfkUGHel9OiC/8lbXbEUSSpLt
	 LI/pTM0mxzfnHC9bMzUQ0tUogWfpUq5L0m+mb6XduXyes/EX9ly8vxPQwH3nU0LFYj
	 prH4Lr8HjNIXb6sUGhepBJ/KO1/TJKR30i055MxYZCQ5c+ThBApgKuu6/4kK1/ClPX
	 AoKWa0bk0zlIQ1cG0MxIFNWMcNJMVagzRxsI7UMAARTmBci9KAKIi3MDKxsHkSn5T+
	 mBE4CwWscibwrjjtHGlsUEobZNSyY2busDO+2uTpOPkdpNUIJZqonnJWzO+fjUju2x
	 x9sRUEQko6C523S7iQZKiUvp2r7MWOz9h59iXsBVPPyeEeFWFRH8G/XGTW1FcDyfU/
	 OFzr3QAaJ7R7O1k8BNYay1jtdPNJFfYdNG8ZJxqJlTnBoHKYP+kiS4aPtgG4ZQvE3Q
	 RTy/ZzTgq7ng3zFwKnT3AzZw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D0540E0218;
	Fri, 11 Jul 2025 19:18:50 +0000 (UTC)
Date: Fri, 11 Jul 2025 21:18:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: stable@vger.kernel.org
Cc: Thomas Voegtle <tv@lio96.de>, kim.phillips@amd.com
Subject: [PATCH 6.12-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250711191844.GIaHFjlJiQi_HxyyWG@fat_crate.local>
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

From 619edb968458b6c558abfa1062c8e27a90eae662 Mon Sep 17 00:00:00 2001
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

Fixes: 7a0395f6607a ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Thomas Voegtle <tv@lio96.de>
Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8a740e92e483..b42307200e98 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -376,6 +376,7 @@ static bool amd_check_tsa_microcode(void)
 
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

