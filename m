Return-Path: <stable+bounces-164586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6CB10781
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA91CE33B4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6C26059B;
	Thu, 24 Jul 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TE/4246A"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65743F9D2;
	Thu, 24 Jul 2025 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351981; cv=none; b=AMLOk1ORVo33VvFsplgAxs+bWVAVcn4AyYqSHpoNEFx4zCaLaFAMTiFEtfPRYGXDKG8Xb0IItwY+TpzKAE7fcnR7Z3AOi41l6LESRNZVjttFaeG+kCrMxcABtN5O8dfRbhLbGvd0VE/ef6HSZJOVAhgvoUJbjNNxHffWRrHlEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351981; c=relaxed/simple;
	bh=HOxL+KpNgulprG0Em3BSIkBd/TxigVHYURZKV823Cdc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=vDVnk1ceeYsyJ1nzwQ6dhA/pScuN4E+o9/aD8dyBUyjMlBbXJQiibccPUFhLT6VcHTOS+mLEk6LY9WmB+7ezAzFPax7gvLkTPJA2t1mTheMUrTy1gOqdq2v0VPU4cPpEQkIIisoRq/pFVnNrIAi+dzzLlJzIEdsj17mwYtMyX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TE/4246A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C93E840E0254;
	Thu, 24 Jul 2025 10:12:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dbV5xy0CTZCf; Thu, 24 Jul 2025 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753351972; bh=8YFuASkVWjvfbK2QQR8PnCFzwm+bIBInPkRN0aHGUiQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TE/4246ATbNvCH/YmHh0liyZvlQW7h/jW5XQ+xJfxlEIkMdTtrO6S5PMz75Xn1Gh0
	 5AkkYEYFi79YDNoAvdcFEM8Maak89GWIRUXp2PFpCFRy5iaEpKuDsdvZD4AhQw90nh
	 iUWJByyo7ccnyOYv8RAfOzqGRJmYpZ+slUtxuVAPHUUObOH4GJF64w1zoQ1i2xq9h8
	 ro2h+VrRF2VGWMcJj30fZj+47Tp6ZP4XG4xbxBXW+X51dx4INXEutxMSVAeuNIbzIV
	 dNBH9SfRVn+PmH0LFBiTEu6e2HKL1XPVbeo498bI/nh20xykk8cUR0BkVV5lV3BPqk
	 zSLtgLCsgqscY3Vm5x/EqgkaUiCTREOZdg71ZTpzkzaNg8PMKyfTUCtZ6CxCCNLLgC
	 QiOYmaOO+kIL68Q0l+APUu3Sh2WzDQcMLFVeyIeGblVukb8MiJjCdxGmE04D4er0Lz
	 bTDIAu91buMYXWAxUU3s9vXhpjClC+RTz7Y1qLabqJdkj1H0zcqFhnqDEsUzMAQSnn
	 jIQNZlQYRh4h6uvkRo4FMHM2+G4cs1NnKRa9xJ0EevWBT40MCWg1XqCRzBnGU8ybSO
	 FK2yIfPDbiZZqdt7SdZ7Ynca5ZsJPjv1VbOi2Imd7jnFaOWBn+2wrKMDagAxWZjRiP
	 /m40o0jRPSR7ApX8tzgbalyE=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3030:a60:70e0:1176:9e41:51e0:6730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F2B640E00DD;
	Thu, 24 Jul 2025 10:12:37 +0000 (UTC)
Date: Thu, 24 Jul 2025 13:12:33 +0300
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kyung Min Park <kyung.min.park@intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
CC: xin3.li@intel.com, maciej.wieczor-retman@intel.com,
 Farrah Chen <farrah.chen@intel.com>, stable@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
User-Agent: K-9 Mail for Android
In-Reply-To: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
Message-ID: <C723416D-E1C9-4E18-A3B2-D386B1CB2041@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 24, 2025 12:45:51 PM GMT+03:00, Maciej Wieczor-Retman <maciej=2Ewie=
czor-retman@intel=2Ecom> wrote:
>If some config options are disabled during compile time, they still are
>enumerated in macros that use the x86_capability bitmask - cpu_has() or
>this_cpu_has()=2E
>
>The features are also visible in /proc/cpuinfo even though they are not
>enabled - which is contrary to what the documentation states about the
>file=2E Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>split_lock_detect, user_shstk, avx_vnni and enqcmd=2E
>
>Add a DISABLED_MASK_INITIALIZER() macro that creates an initializer list

Where?

>filled with DISABLED_MASKx bitmasks=2E
>
>Initialize the cpu_caps_cleared array with the autogenerated disabled
>bitmask=2E
>
>Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpui=
nfo feature flags")
>Reported-by: Farrah Chen <farrah=2Echen@intel=2Ecom>
>Signed-off-by: Maciej Wieczor-Retman <maciej=2Ewieczor-retman@intel=2Ecom=
>
>Cc: <stable@vger=2Ekernel=2Eorg>
>---
>Changelog v3:
>- Remove Fixes: tags, keep only one at the point where the documentation
>  changed and promised feature bits wouldn't show up if they're not
>  enabled=2E

The behavior was there before=2E Why do you keep pointing at the patch whi=
ch documents it?

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

