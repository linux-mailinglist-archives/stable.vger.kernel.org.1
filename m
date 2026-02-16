Return-Path: <stable+bounces-216681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAVpObrpkmlSzwEAu9opvQ
	(envelope-from <stable+bounces-216681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:56:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4D142249
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD895305A41F
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE82F067E;
	Mon, 16 Feb 2026 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FT6BEkj0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC92EF64F;
	Mon, 16 Feb 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235531; cv=none; b=tv3CsLSbHpHxMgREX2OvZeEZH97vn15dGe/ZiCMDJQN9U8lMTnb1kJJ55p3BhoAlX8ORBITqZcqgAN84CsCsLjf3KGyUo+s8Ap0kceyg8UI5SJ4RLGpP7ISv/34m4P1cT/LsQXzUoE7jQXKYBCXceF7jqfKnRtrR4zI2zm5Dd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235531; c=relaxed/simple;
	bh=sIGdx8mX9ScmiwW4cj0jA42fQyDS7P82HBU3mo3hBsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUwQTgoegz2nFppZOzUBSIeZr6T3n0jNTvFejMrLh2+N8L/b1Dnyw6P4+GwCzs6inYDLJIPHixNFq+I5HksMUHPqsc5TPATs3ejdufzNV4awbops5Hw41lT2xKtmKCRbjpSP6Tdr/U8EAf3NPPhprnHW4hKJbYpCxoFdOXPr4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FT6BEkj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE04C19424;
	Mon, 16 Feb 2026 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771235531;
	bh=sIGdx8mX9ScmiwW4cj0jA42fQyDS7P82HBU3mo3hBsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FT6BEkj0wqDLLyITZEN6SGDO7xN3AHI49SV/55StDGGuQGhW28C+WLzwcXB4Q7HKw
	 N8Prsgn2qSCbw8DKWg8mG5bmYdc4iFazPFc9d26Ah8X04lkyUFQbYdi/6rQtEmRhBw
	 nwdw/U+CqFq0QqhGwM9DzctdB6Ts9/XOzFbGnqg8=
Date: Mon, 16 Feb 2026 10:52:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH for 6.6 & 6.12] LoongArch: Rework KASAN initialization
 for PTW-enabled systems
Message-ID: <2026021631-sabbath-wrangle-3496@gregkh>
References: <20260215140953.1224579-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215140953.1224579-1-chenhuacai@loongson.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216681-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 49D4D142249
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 10:09:53PM +0800, Huacai Chen wrote:
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> 
> "kasan_early_stage = false" indicates that kasan is fully initialized,
> so it should be put at end of kasan_init().
> 
> Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
> on PTW-enabled systems, here are the call chains:
> 
>     kernel_entry()
>       start_kernel()
>         setup_arch()
>           kasan_init()
>             kasan_early_stage = false
> 
> The reason is PTW-enabled systems have speculative accesses which means
> memory accesses to the shadow memory after kasan_init() may be executed
> by hardware before. However, accessing shadow memory is safe only after
> kasan fully initialized because kasan_init() uses a temporary PGD table
> until we have populated all levels of shadow page tables and writen the
> PGD register. Moving "kasan_early_stage = false" later can defer the
> occasion of kasan_arch_is_ready(), so as to avoid speculative accesses
> on shadow pages.
> 
> After moving "kasan_early_stage = false" to the end, kasan_init() can no
> longer call kasan_mem_to_shadow() for shadow address conversion because
> it will always return kasan_early_shadow_page. On the other hand, we
> should keep the current logic of kasan_mem_to_shadow() for both the early
> and final stage because there may be instrumentation before kasan_init().
> 
> To solve this, we factor out a new mem_to_shadow() function from current
> kasan_mem_to_shadow() for the shadow address conversion in kasan_init().

The subject line AND the commit text here do not match the upstream
commit AND the diff is different and you did not explain what changed or
why :(

So as-is, I can't take this, sorry.

thanks,

greg k-h

