Return-Path: <stable+bounces-216684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 96E2HmnvkmkQ0QEAu9opvQ
	(envelope-from <stable+bounces-216684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:20:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C2142481
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 056DD30143C8
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE62FF662;
	Mon, 16 Feb 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FAD0JWgZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B01E5B63;
	Mon, 16 Feb 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237218; cv=none; b=JCLl2JqFHMImEtd9IEC3r/mTvBXdq5Y/a8PUXc0o3V9z9cBf3rB0u5RV1taF2sSc10TzKHD6Y82jsl6iG6ZxKBKNoK1FHKoSohNxh9InKmZKCj7Cl5xSbHhHzv+G0+BT+HAToWVkqMe4ryvaGLraqZ+K+mj3efoMO45wy/V5w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237218; c=relaxed/simple;
	bh=9x/wEscj0b/VkFNgRUqs2ndAExbsHqVH9Mcdh31EbY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uACCfSYw2KCllyhZ7qLA556jXsUUokvlWFK7/+K65ofgKv1D4lMbS9ZidDqVSy1/5aDTI74aPh7iUMfc968ourIXId00K/CM0E6I1p98AuG9mXtsW2focLUrb5zzZpauMCTbXYQ0Yz7W6l8WmMXDuIPhtsuJ4D9ZLh1R5dtYQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FAD0JWgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C763AC116C6;
	Mon, 16 Feb 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771237218;
	bh=9x/wEscj0b/VkFNgRUqs2ndAExbsHqVH9Mcdh31EbY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAD0JWgZFZvwTzFNC9F1aj9DFBEdbeVmrpYqk4L7GZ5SkhQx4iRxQHsstZodDkjT/
	 cXsdzBEXZnY57tt9qbJ8audAb7rt1XxGomex2d0FXrWLP6k6Omu6rCfMIGWW+64UIr
	 9/+dL+99Y19jzjnxT/cnOWXlS/a7FinIQuEZFlpw=
Date: Mon, 16 Feb 2026 11:20:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH for 6.6 & 6.12] LoongArch: Rework KASAN initialization
 for PTW-enabled systems
Message-ID: <2026021602-unsalted-straining-edfb@gregkh>
References: <20260215140953.1224579-1-chenhuacai@loongson.cn>
 <2026021631-sabbath-wrangle-3496@gregkh>
 <CAAhV-H42+WuWpKqFc6MMv8cZ_U8Ve15qtb4DkOd9Yj6Z4ZFE_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H42+WuWpKqFc6MMv8cZ_U8Ve15qtb4DkOd9Yj6Z4ZFE_w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216684-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D70C2142481
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 06:09:31PM +0800, Huacai Chen wrote:
> Hi, Greg,
> 
> On Mon, Feb 16, 2026 at 5:52 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Feb 15, 2026 at 10:09:53PM +0800, Huacai Chen wrote:
> > > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> > >
> > > commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> > >
> > > "kasan_early_stage = false" indicates that kasan is fully initialized,
> > > so it should be put at end of kasan_init().
> > >
> > > Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
> > > on PTW-enabled systems, here are the call chains:
> > >
> > >     kernel_entry()
> > >       start_kernel()
> > >         setup_arch()
> > >           kasan_init()
> > >             kasan_early_stage = false
> > >
> > > The reason is PTW-enabled systems have speculative accesses which means
> > > memory accesses to the shadow memory after kasan_init() may be executed
> > > by hardware before. However, accessing shadow memory is safe only after
> > > kasan fully initialized because kasan_init() uses a temporary PGD table
> > > until we have populated all levels of shadow page tables and writen the
> > > PGD register. Moving "kasan_early_stage = false" later can defer the
> > > occasion of kasan_arch_is_ready(), so as to avoid speculative accesses
> > > on shadow pages.
> > >
> > > After moving "kasan_early_stage = false" to the end, kasan_init() can no
> > > longer call kasan_mem_to_shadow() for shadow address conversion because
> > > it will always return kasan_early_shadow_page. On the other hand, we
> > > should keep the current logic of kasan_mem_to_shadow() for both the early
> > > and final stage because there may be instrumentation before kasan_init().
> > >
> > > To solve this, we factor out a new mem_to_shadow() function from current
> > > kasan_mem_to_shadow() for the shadow address conversion in kasan_init().
> >
> > The subject line AND the commit text here do not match the upstream
> > commit AND the diff is different and you did not explain what changed or
> > why :(
> The subject line is exactly the same as the upstream commit (no difference).
> 
> The changes in the commit message is because the text of the patch has
> changed (this is why the upstream commit cannot be applied), and I
> think the commit message should exactly reflect the text.

No, the commit message should match exactly what is merged in Linus's
tree and then the comments before your new signed-off-by should describe
what is different here from what is in Linus's tree.  Don't rework
changelog text for stable backports, that only confuses everyone
involved and it makes it look like you are doing different things than
expected (i.e. attempting to get stuff that is NOT upstream merged.)

thanks,

greg k-h

