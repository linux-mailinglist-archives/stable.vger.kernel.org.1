Return-Path: <stable+bounces-164265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F276B0DE35
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F90E7B70F4
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9B2EA485;
	Tue, 22 Jul 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V4g9zK7b"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAD2BE045;
	Tue, 22 Jul 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194080; cv=none; b=A37kQX4GTC5Qddvt37BufUGPYF9CbxpwAgwRaSKIMIqbrJ5wVyDeCpX8uuV883itQ1s4ulCJYX9ni8NI/PxjkATj/40o0ppYvRzpTFk7LQItIa+y7WPJzaaANq/HshnskX6t93Amwr5oLHXeK8wrlN0Y6b+M0p8WtK4S8Fm6Ev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194080; c=relaxed/simple;
	bh=c4Hfuep6V/m0YxeQR3WbKYkqUiAZDaY00w0YeOziUc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNdSD7wzreDbVZG03Ndd0NvbD/JilgY/VLELJKAhxVnbaVrT39Ql7q5SOjCNQgrJR0EEdo9QzYr8I1/12kPedgn9CUyzBEwV+HTu0M0Uu8HZqa8bTKEp7xk8bchUhvNJhUHtrc01Zcr613wao/IDsxhtBl/hvE4eSvc+d5mkYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V4g9zK7b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94A3540E0268;
	Tue, 22 Jul 2025 14:21:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1n529-wzSz3w; Tue, 22 Jul 2025 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753194063; bh=8yCRXxenRxqYzn5Gdaq3yWn9Oudb2WG37Lz5ZmLh34U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4g9zK7bJKmGodh/Nn+zRfCdtW1tVRX5jWmO/yOlRlVWnwr96CuCGNpfxm42y1i1h
	 Sc0HUDn700m7+YvVqNZveem0iqCPE1X4hiQqWien1/n17Va6DXMnDL2wdWBe/WTENi
	 +f1PQKK0krB8Dsr3O0tdVgmjvQrXrvN32Xinjm8WrLikTaxHRtILp9lxaAvb44/YBD
	 cRxOukGn8gqEGR7HhovG2ELghbwhamiZZGjRpo8npcHjJ4dxZz8SeA+4bShS6xcQSV
	 esuWMb6aTvqfMsZSI5iGPw8CMFr+tZlfhGxSts4DQL3sOCBGZNFET+yPfR2+XrLO4r
	 kjA1SxbfZSOBpbcaAY+x5msOU1wWCXOE0KNSyXBz7qlOeDIqu9AIeQaeCw27Td/plX
	 zJGhnPbO4B0ILQf3cJka/x73HagzwRE0aJwqf0ZVsnwxVezeljLpvP4UkPzOvAvsFi
	 BdhXHB0k1cSvMKUM80LduJwBtfm8oJc+M3rBdbGCsGzypjcqmpYU4m0NROdN1joxCL
	 p3VoCYyJH/dxCWH+FI2GB8dgDKF1e3tysxhaQvYDE75robaKCWc+uXZStgHxGoy/JV
	 h9p1aOdptRD82ZF2/hk+uQEs0Nr0ImnijPUnORbK+VGfLa/folP7vmElbKfqXdxzrY
	 f6qXwJvHw7Xz2y8Qf/ufnOeA=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9295040E00CE;
	Tue, 22 Jul 2025 14:20:54 +0000 (UTC)
Date: Tue, 22 Jul 2025 16:22:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Zhivich <mzhivich@akamai.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <20250722142254.GAaH-evk-BqchvvIaZ@renoirsky.local>
References: <20250722122844.2199661-1-mzhivich@akamai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722122844.2199661-1-mzhivich@akamai.com>

On Tue, Jul 22, 2025 at 08:28:44AM -0400, Michael Zhivich wrote:
> For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
> field in zen_patch_rev union on the stack may be garbage.  If so, it will
> prevent correct microcode check when consulting p.ucode_rev, resulting in
> incorrect mitigation selection.

"This is a stable-only fix." so that the AI is happy. :-P

> Cc: <stable@vger.kernel.org>
> Signed-off-by:  Michael Zhivich <mzhivich@akamai.com>

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

> Fixes: 7a0395f6607a5 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

That commit in Fixes: is the 6.12 stable one.

The 6.6 one is:

Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

The 6.1 is:

Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

The 5.15 one:

Fixes: f2b75f1368af ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

and the 5.10 one is

Fixes: 78192f511f40 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

and since all stable kernels above have INIT_STACK_NONE, that same
one-liner should be applied to all of them.

Greg, I'm thinking this one-liner should apply to all of the above with
some fuzz. Can you simply add it to each stable version with a different
Fixes: tag each?

Or do you prefer separate submissions?

Thx.

>  arch/x86/kernel/cpu/amd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index efd42ee9d1cc..289ff197b1b3 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -378,6 +378,8 @@ static bool amd_check_tsa_microcode(void)
>  	p.model		= c->x86_model;
>  	p.ext_model	= c->x86_model >> 4;
>  	p.stepping	= c->x86_stepping;
> +	/* reserved bits are expected to be 0 in test below */
> +	p.__reserved    = 0;
>  
>  	if (cpu_has(c, X86_FEATURE_ZEN3) ||
>  	    cpu_has(c, X86_FEATURE_ZEN4)) {
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

