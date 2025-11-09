Return-Path: <stable+bounces-192840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB9C43E22
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 13:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70124E604A
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EC2459EA;
	Sun,  9 Nov 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dHgEs1xz"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA8200C2
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692653; cv=none; b=RcVneCb9S05dk38Rvrc+eQtgt4cjc3xzvlSNIOwiy1w98eYTqOJRaVWXaGPjetBqfi0lgQq82BaIUxB9OGuit/rTyw0BFIW0l0lgaBAF4rv4Pt3qpd/Bh8v8fP6NdLOBnuSbvXMZ84gl3zSL7bNUrW7+WLWqhNIH/oC0hOVMvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692653; c=relaxed/simple;
	bh=3+eCSIJebndjJaTRAnvjUhtxBWMBuVLg/zcAVRwkD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHzx3FYPG0gIO37JrqOqa2fuEj3nK6YubWy1rkg4IuwVCxzaBHZv9d4M1wJLUNIoDpjiuUHO290ykwIV+rleXdu5oBwK+ItH5Pggbrlz66TI0+M3g6XavekYzmHxruwDNaJo1jd+09W4onrt5uPWZ/lJkNjX3Z7zegNjZean1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dHgEs1xz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A384940E01A5;
	Sun,  9 Nov 2025 12:50:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x6tOSQpmtv46; Sun,  9 Nov 2025 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762692640; bh=ZzMumuc6B8Ne+FAzcfk1GubYVm3w0Dm/pitWyyyKY5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHgEs1xz++HEvHJoFNws+zzbpdObjgzkpIT79hiJeTSIwT9+IArBryCaMjJtHYUkH
	 iZ0ocTHsR2r6IvsbwkZEVEfpuyWS5BedyBT76FeG3qFxsfyYT+aqEktieXDo6MGGjd
	 NYXDCDgXeOtu8SHtLYgSk/OV1RyMrukQf33DToM7bNJ9gnLLSwir9YX42Q55hmFlAl
	 E+UFBcS0AFIM4lUCSqUPFHS1WG+KLJj0Z6LbKcnwJDfjVkTAyDFxbRwigF3ZdBVpHV
	 KhFdNvaDHEnKex+6AATwsMVOAyPHJ6rCZm8TuWekogq9sVfiX3W0u3NyImWHwW/usy
	 f8YTxMjcHWtik83oeFFOIKUHgk3zoKIJjU+pISWwnPG6VUMymg/vxEzRH+J/dnGOQg
	 svd1z091QA8a3CxBoau5eD1GlSLPi6IJGBYehABCZCuzFf5zRciU/3TKJN36w4eo64
	 oy0BbbZErOkIu5tEczGkWIdAAjMeSi7qbtIZpCJS8pRkn4K5qOJEpfixDfjAsLEWsW
	 dEQgJRlnOMHZTekjC0afm7RmwhNmGVbxUHd4cW0CLIgi/w/yuGEsF/iyqLjJXBuqVp
	 iRLLoYuz63fiJZ6a4j/WOGZd7fXU8uyNMwEF4u02OQsGiw4caxM65DXCFVVoBqyKPV
	 fiF6yOvSvXr7hS6Zk7JMuBec=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1679540E00DA;
	Sun,  9 Nov 2025 12:50:37 +0000 (UTC)
Date: Sun, 9 Nov 2025 13:50:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Add missing terminator for
 zen5_rdseed_microcode" failed to apply to 6.12-stable tree
Message-ID: <20251109125029.GAaRCOFWPArcysoy5j@fat_crate.local>
References: <2025110944-strenuous-hydrant-ea0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025110944-strenuous-hydrant-ea0b@gregkh>

On Sun, Nov 09, 2025 at 12:12:44PM +0900, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x f1fdffe0afea02ba783acfe815b6a60e7180df40
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110944-strenuous-hydrant-ea0b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From f1fdffe0afea02ba783acfe815b6a60e7180df40 Mon Sep 17 00:00:00 2001
> From: Mario Limonciello <mario.limonciello@amd.com>
> Date: Tue, 4 Nov 2025 10:10:06 -0600
> Subject: [PATCH] x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode
> 
> Running x86_match_min_microcode_rev() on a Zen5 CPU trips up KASAN for an out
> of bounds access.
> 
> Fixes: 607b9fb2ce248 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20251104161007.269885-1-mario.limonciello@amd.com
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 8e36964a7721..2ba9f2d42d8c 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1038,6 +1038,7 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
>  static const struct x86_cpu_id zen5_rdseed_microcode[] = {
>  	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
>  	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
> +	{},
>  };
>  
>  static void init_amd_zen5(struct cpuinfo_x86 *c)

Yeah, this one is not needed for 6.12. You have this one queued there:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/queue-6.12/x86-cpu-amd-add-rdseed-fix-for-zen5.patch?id=a45420df6b86929e1029eab70190e3c90e488de3

and that version doesn't need the empty element termination fix.

So you can drop this one for 6.12.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

