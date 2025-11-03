Return-Path: <stable+bounces-192210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB3C2C4B9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 15:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0929188AE9C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD173313E33;
	Mon,  3 Nov 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="GEfKXPQr"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DC313E09;
	Mon,  3 Nov 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178363; cv=none; b=bOR/htdYPQm0Vr+2Y7tLn8W1BMTx6zal/GTvhgR1oVEHo5yEx0OgnMOiKWJKvt2G/Kd/8mH5K2WK1sA2/t5ZDWMC35PTigc7Ow9t2ukM86l+LIpPM2OvnQoC3pl5jB7Dioh2331Q8VH8KPpPjRIzpd2hi4RPNdlC9RmtnHh4SdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178363; c=relaxed/simple;
	bh=M01mIC/VTNf5sx9PsqT/xkduCCmmcdT+VQitzYUK5xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JX9+tlC8YUfBBfik1AH1XruNhBLHKO9qJF1TwrPxFqsDuV2FUt6BIe/xe6QS+tnSzCd3g6YEDEO451QQzMfgrJJKeZ/dpfjbYdYnIJYaCKE1MzP1myi16iyc6a80tBFFMzhnZfqc/GXvc3eqkFMwwSovDWG2YuxappxKwfRSOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=GEfKXPQr; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2123284517;
	Mon,  3 Nov 2025 14:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1762178353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gle31eN9My17sC8D8ST/fOHC6I96gUMv9nuTZ5ksc/Y=;
	b=GEfKXPQrOj68YuHKsvQcSn2lxGj3ONIs3yYNF5MlmbOGWzoJ3D4QYjP6f/C+0MhW5z6X82
	Rqal6B/YZZJuSRnTppTvOCie2Ei6IjsLy3RXQi1vqR/gaPyrci/NdvL0CfwAdgB/OG3FfB
	h6qN+eTpfBUsXI6UtxjGJhr2ysTXquLOqM0BEemlmUjoP+WsJrHMgHxQpTV8Qx0jg9yE1C
	tCUoQcaHezjHRTWWl7JyTivYesSCfhQrs7j0ogEYArt8mD1lEe6UD2tV6DN8w0s4l5RPfS
	CsIXqtLiXWtEUziWPs+LF/2dwQJMCC4KGjc2v3AvSkveqvR+IXlwZSr6hvOjQg==
Message-ID: <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>
Date: Mon, 3 Nov 2025 14:59:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: stable@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/28/25 13:01, tip-bot2 for Gregory Price wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     607b9fb2ce248cc5b633c5949e0153838992c152
> Gitweb:https://git.kernel.org/tip/607b9fb2ce248cc5b633c5949e0153838992c152
> Author:        Gregory Price<gourry@gourry.net>
> AuthorDate:    Mon, 20 Oct 2025 11:13:55 +02:00
> Committer:     Borislav Petkov (AMD)<bp@alien8.de>
> CommitterDate: Tue, 28 Oct 2025 12:37:49 +01:00
> 
> x86/CPU/AMD: Add RDSEED fix for Zen5
> 
> There's an issue with RDSEED's 16-bit and 32-bit register output
> variants on Zen5 which return a random value of 0 "at a rate inconsistent
> with randomness while incorrectly signaling success (CF=1)". Search the
> web for AMD-SB-7055 for more detail.
> 
> Add a fix glue which checks microcode revisions.
> 
>    [ bp: Add microcode revisions checking, rewrite. ]
> 
> Cc:stable@vger.kernel.org
> Signed-off-by: Gregory Price<gourry@gourry.net>
> Signed-off-by: Borislav Petkov (AMD)<bp@alien8.de>
> Link:https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.net
> ---
>   arch/x86/kernel/cpu/amd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index ccaa51c..bc29be6 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1035,8 +1035,18 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
>   	}
>   }
>   
> +static const struct x86_cpu_id zen5_rdseed_microcode[] = {
> +	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
> +	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
> +};
> +
>   static void init_amd_zen5(struct cpuinfo_x86 *c)
>   {
> +	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
> +		clear_cpu_cap(c, X86_FEATURE_RDSEED);
> +		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
> +		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
> +	}
>   }
>   
>   static void init_amd(struct cpuinfo_x86 *c)
> 

Hi all,

This fix seems to break quite a bunch of users in CachyOS. There has 
been now several users reporting that there system can not get properly 
into the graphical interface.

CachyOS is compiling the packages with -march=znver5 and the GCC 
compiler currently does pass RDSEED.

This patch results into that also Client CPUs (Strix Point, Granite 
Ridge), can not execute this. There has been a microcode fix deployed in 
linux-firmware for Turin, but no other microcode changes seen yet.

I think it would be possible to exclude clients or providing a fix for this.


Example log:

Nov 03 13:37:33 hells drkonqi-coredump-processor[1073]: Incompatible 
processor. This Qt build requires the following features:
Nov 03 13:37:33 hells drkonqi-coredump-processor[1073]:     rdseed
Nov 03 13:37:33 hells systemd-coredump[1077]: Process 1073 
(drkonqi-coredum) of user 0 terminated abnormally with signal 6/ABRT, 
processing...
Nov 03 13:37:33 hells systemd[1]: Started Process Core Dump (PID 
1077/UID 0).
Nov 03 13:37:33 hells systemd[1]: Started Pass systemd-coredump journal 
entries to relevant user for potential DrKonqi handling.
Nov 03 13:37:33 hells drkonqi-coredump-processor[1079]: Incompatible 
processor. This Qt build requires the following features:
Nov 03 13:37:33 hells drkonqi-coredump-processor[1079]:     rdseed
Nov 03 13:37:33 hells systemd-coredump[1082]: Process 1079 
(drkonqi-coredum) of user 0 terminated abnormally with signal 6/ABRT, 
processing...
Nov 03 13:37:33 hells systemd-coredump[1071]: Process 1049 (sddm) of 
user 0 dumped core.


Best regards,

Peter


