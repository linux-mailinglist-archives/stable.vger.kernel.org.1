Return-Path: <stable+bounces-161686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D8B024C4
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4699561F67
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA81E521E;
	Fri, 11 Jul 2025 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SLtdscP7"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B38F7D
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263175; cv=none; b=lXZyfUC2lUA9CJQepFfCFoOwuZotKS8c7O989Y3uOA8ii6jYARWZNKNvdrq+19XIwPB472G87LyBDexjXHZG8Gkv0UzKKQS2eRvDlTFFF4ofd52CGQp4XDFznqav15TWUvTas0pEkX6Zpm1VhUsao5p6RuWF3GCPM7S1IgNFPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263175; c=relaxed/simple;
	bh=rVsWLDfF7bN5xsDhd2LzOUvvv4tRQU5COCvQm6oxUxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orw1nwjwVmrDKRigSao705nyzpnYZUl/ktmqRzimeacYNi6R2TFL1HNRPP0p+ikA+TV/YE3+LAfkuNhxp5tMl6nHlYLMgS8vlPNsTGur6BRUdBrd0EDFrrjhSm9bzhHcsD69qH6bF/aBKM1PDKz3R6onJqI073E2g+uaZ/6j0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SLtdscP7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E84A240E0218;
	Fri, 11 Jul 2025 19:46:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fOho075tlNRJ; Fri, 11 Jul 2025 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752263168; bh=Tr8ebBDdnvbUwhFZCNfYvwaP/0LI7fFXQd5cizmPzpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLtdscP7iz2uKWbgcNyfjNVriPZbEILUzvCpDaVPSwzzz7b9a3zaHxP+eIU7seAAF
	 l02dxvhJXxA1vIG1js1TPBGvqyt7fskfxEE8/lGOA36BJ7aExrfep9J+u4NfQqFlcc
	 oqcoB1u6qL8vBaN3W/W9IxTHBsXXE1CINY9DjLQjLKNncXTLhsDYWMQB4IA35PsJcq
	 BooQADF+aJGKkmtIdITCufFYqDz8zTSBPmaiQ4ZzAjmb3K9b178Ed0aRJsX3gGFNzM
	 4WeX9afpOtxMqCfQYFNVPFoAphNcWLyKW/hIF/G2ylsKCF27tBzEvQ48LhNV7S9ByR
	 j6WK7eKII1J+Q4owGICXRE58odHshisc5EbnI7/73pJR0mh7qtRR4eKn14gA0HNLpx
	 2ruve/5JQ4bxMq1SJXjBjjZQmaQFF1BVFxOBFQyuCQ/tWkBCwQTNJyWXZ0mzyp+yF4
	 mmxif9w1p+NjSXa+N5sYELRvWLHSfcrn6KPj+4DnAKsiCb24q3SYDpJgkop33GBcW1
	 t78bWSqFdQfarNQ2+nyGiz0LVmTTDMMXV19qzb8u6VrEptvBGtt4T1MDZR77nrEtYD
	 rlVTh/m59khqrblp64YvBEv6sI4aUKV3wi7BpcGL9GjgYx/RegzhFu9JegYafpIP9b
	 Bf/UqFumt8ViwaTCjvUg2aQc=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D812240E0205;
	Fri, 11 Jul 2025 19:46:04 +0000 (UTC)
Date: Fri, 11 Jul 2025 21:45:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: stable@vger.kernel.org
Cc: Thomas Voegtle <tv@lio96.de>, kim.phillips@amd.com
Subject: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
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
Tested-by: Thomas Voegtle <tv@lio96.de>
Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
---
 arch/x86/kernel/cpu/amd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d409ba7fba85..04ac18ff022f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -590,6 +590,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (c->x86 == 0x19) {
@@ -704,6 +705,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -743,8 +746,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
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

