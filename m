Return-Path: <stable+bounces-247637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCRhFlnyBmpZpQIAu9opvQ
	(envelope-from <stable+bounces-247637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:15:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E884C54D252
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CB9C300FAB8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2044102A;
	Fri, 15 May 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUIawnuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F03FAE0E;
	Fri, 15 May 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839787; cv=none; b=Z3a52sqYrgUu4kQnApgkowuytegBij6d18+jOaa3cwdEE8sdXiiihoLQSOLM09RCwha5RYjyc9hGSTiL8xLLMU/oM8LUtC18nuQgNzASovRv3nUtUWPpm71abkl6aOqWMnxZhBQ3GhOgbdNFmfjrsUtuRSsIj4As+fNzuZQ3xAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839787; c=relaxed/simple;
	bh=R9f2vsfoSywFN0uuV0X/eI9CS3kavsgTJMQlK4T4Fac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3Aqcue1/F2iHi77C957g7S0BXFdkF6pwPz5Q6urJTyK/nKUWFXEGs0bWU+sLdeQFkI0qF7D9AlC45HppqJ3OaAAixPj0OoVYXCGpgufE8IIwVisM8BXPSkOr/LdSp2qpVr6LXSbfpZSyx/IQYibgCV5/U/4sw0ljyvJjUsBha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUIawnuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B0CC2BCB0;
	Fri, 15 May 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778839787;
	bh=R9f2vsfoSywFN0uuV0X/eI9CS3kavsgTJMQlK4T4Fac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUIawnujPnQJG8s9kylDi4mU+GCnQX+8quj7ttifZ1iBf1TcuNprVNYqmnO/KGKCZ
	 DFgngLghAzSb0mqLkx8MaqCWLVjYGV7CldrnKDWyC7vzxMKJtbY0ir72b0z2pMK/gj
	 UyViZK0bmpduP9RODfuKBOqwHfBmUUpIS8GqZ8NM=
Date: Fri, 15 May 2026 12:09:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH for 6.12] LoongArch: KVM: Compile switch.S directly into
 the kernel
Message-ID: <2026051542-acclaim-grew-bd5a@gregkh>
References: <20260513031224.2122119-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513031224.2122119-1-chenhuacai@loongson.cn>
X-Rspamd-Queue-Id: E884C54D252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:12:24AM +0800, Huacai Chen wrote:
> From: Xianglai Li <lixianglai@loongson.cn>
> 
> commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> 
> If we directly compile the switch.S file into the kernel, the address of
> the kvm_exc_entry function will definitely be within the DMW memory area.
> Therefore, we will no longer need to perform a copy relocation of the
> kvm_exc_entry.
> 
> So this patch compiles switch.S directly into the kernel, and then remove
> the copy relocation execution logic for the kvm_exc_entry function.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Kbuild                       |  2 +-
>  arch/loongarch/include/asm/asm-prototypes.h | 20 ++++++++++++
>  arch/loongarch/include/asm/kvm_host.h       |  3 --
>  arch/loongarch/kvm/Makefile                 |  3 +-
>  arch/loongarch/kvm/main.c                   | 35 ++-------------------
>  arch/loongarch/kvm/switch.S                 | 19 ++++++++---
>  6 files changed, 40 insertions(+), 42 deletions(-)

Does not apply properly to the 6.12.y tree :(

