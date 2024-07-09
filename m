Return-Path: <stable+bounces-58758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AF92BC8A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3491C20E0A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641918FC60;
	Tue,  9 Jul 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N0n0Yu/w"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100E1591F1;
	Tue,  9 Jul 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534382; cv=none; b=AcnI/supfoGv97qvlvuK2fpZmHt4kMba/cmdLxRU1m5TLGFB38pYNnOmcwuekN1C7Juodx6T84b0IrZFq+qoCClAcjMlBOTgsILLEZLySXnTpej1fAJTU1KPdiya+nKkbonoJwmQ/umBqDEtMkr6A8bVIyOOR1DdbGJR/YjBg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534382; c=relaxed/simple;
	bh=GxCbFSpRXr64YpzKYWZI94Ttfcr28x+E1SDBHeAOR+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrjpxLkRzUktOR7aSQMJBDsPfJDKZlXz0XmEe+/tf6UGn+TR3j8dXsVhOXQKBrdTfoOk30ThPPd4bGBnfQFaQ6KLjxSvg+orkv9ZkphyRRmVUIN6a+EdI7mI9mxMgVHKT+GGc4fPp7IK2NXV+pmyxApyEj29OniPNsKCYFVt8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N0n0Yu/w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D601340E019D;
	Tue,  9 Jul 2024 14:12:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RmGZsl2mVGvi; Tue,  9 Jul 2024 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720534370; bh=d6Y0klRaJpMwWQ/ZJWm/uK8e91UNmkVpoE3tOQ0KROI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0n0Yu/wx44luhZ60gTCJ9YsMWqFT8zATOMCpfYpDGpuTXM9s2/gKSSDFPzxEHOoJ
	 TZ7Wq0ONcVgET4UY0ClKYaQBdRMOzr3ISeuXpczYpFtwsEUX9pP0JNRQCLI/1bc0fl
	 m2Zpaxrj2TL4YrVnkKDLY8TsAIS2TBHBLjwlAcPcS/xfEWjBuVUy9Zk94RYPNQ97Qb
	 2J0Kp89kol2NQpEE/Qpf91g2TDrugnnCYhThZ+pxq5XLdj0uvlRdSE2/Cddds0A+Zb
	 EaS2aVD7+vAWZBIn7g9PPQMS1esvsaT6OjwUFg3eqxWJPVZa0tbL92mQ1QTmcwPXdI
	 wwOoFAGlLOA6w9IZeRxQO7AqbRHy04QQeHNT7291BayJRbr+yJghZWxSnwZ/lMgV4Z
	 hw+VRBFP4EVhbogH3kD/aekZJQfMjeucfDb7zd0P6YU5BWUncTu+QYGLdDvwiA+WIg
	 fH33fJFBMoJCDhxCgTSAdE8Ufe6z+/lERMza0op64D9F27/Cd1dMxfy04ze1NiOVF1
	 dIKw/p2THA2GIKfvu7JcYVC2hoM1At5anFU2TjBYQL7Omr5hWPE4L36VEnyBgtl0Bs
	 wL1CBRBJ8CrL5F5d3FCNsKgNGyMPRwcx0W/NPiu1vBRZgz4KDon7ApIhZDcistYNfV
	 LiLcNcxhYMJNldaV1aBLgNHE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79DFE40E0185;
	Tue,  9 Jul 2024 14:12:43 +0000 (UTC)
Date: Tue, 9 Jul 2024 16:12:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Mattson <jmattson@google.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: [PATCH 6.1] x86/retpoline: Move a NOENDBR annotation to the SRSO
 dummy return thunk
Message-ID: <20240709141238.GJZo1FVpZU0jRganFu@fat_crate.local>
References: <20240709132058.227930-1-jmattson@google.com>
 <2024070930-monument-cola-a36e@gregkh>
 <20240709135545.GIZo1BYUeDD6UrvZNd@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240709135545.GIZo1BYUeDD6UrvZNd@fat_crate.local>

From: Jim Mattson <jmattson@google.com>
Subject: [PATCH] x86/retpoline: Move a NOENDBR annotation to the SRSO dummy return thunk

The linux-6.1-y backport of commit b377c66ae350 ("x86/retpoline: Add
NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
NOENDBR annotation, repeating the annotation on __x86_return_thunk,
rather than adding the annotation to the !CONFIG_CPU_SRSO version of
srso_alias_untrain_ret, as intended.

Move the annotation to the right place.

Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 055955c9bfcb..7880e2a7ec6a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -107,6 +107,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
@@ -261,7 +262,6 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
-	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

