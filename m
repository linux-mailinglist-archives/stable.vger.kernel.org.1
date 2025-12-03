Return-Path: <stable+bounces-199926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E2CA1A74
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 22:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB3A630198F9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A52C0283;
	Wed,  3 Dec 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fjqoo4cp"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1042848AD;
	Wed,  3 Dec 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796722; cv=none; b=lhBR8MbORkqesWJ7jFeHXQSuj3I4gis7lzvNrHESSzeVVlGiyuI5fy6+hIAHxKscKGzboSaT7ovrmER3XNTkv1MLXyUFbi4omIZUXVviXa3EITjyXUWvjpJPGbCukB4jYn+7U+QbC0DceYFbpO9GwE0JEJ2WsXwDJ8VhTPvwnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796722; c=relaxed/simple;
	bh=TodscpDeSL6dHqDMao5wwjqcte+Efqy0o2XR9COlkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzd/XXR5F+YM9K0bRdNTOYmdiUhgf5X4bX8/qIGY53rrz264GST+tRHZ4Uwh1Ogf+USmjeIh3mZQMQQ8hctCGIf75p7SuGQw3rYkFQZEU1QjAFLODP7qdgPTwNpb1c6QmF85EZA8r0qauRDaOCknqSpvD80jKiETNNUIEuMhZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fjqoo4cp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B9AC040E01A5;
	Wed,  3 Dec 2025 21:18:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t2qRcb7eZXDN; Wed,  3 Dec 2025 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764796707; bh=doge+n1/w0KJxVolORg0+iRoO5BKEx4F7T01FhpWZdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fjqoo4cpvIcMr/CNGivtvaWrZ1i/JJ7VlyxCit5kHDyk/DSpdQcC9vsEtmJjM+tK1
	 LSIk3/2L+K3T01YQXaPfY95GuoO68Fd9G5Lxx5OkSOln52wSoQmP7+3DC5eWzRi+wJ
	 HZbv6DIc4zT/PFOt2d+o8k82OthIrjT3Ej80UclUcOHpRkcWTxKvgHd8K10Td9d67a
	 VvyYUHq/nKvnodhPNd9lo6+xuk2JpeT4MUqkXAhTpRLiHB1swTtmcqhWKANon59k2g
	 lF70nhAcO1ZGJ6nCK5vmOxIIx3AMGFRxPCEu09XojjcGnsr3HMAIK1Qpc5KV46CGVY
	 01SbZGzsSLCkQF/p6D0LqYK1nqadkameMQBng2PaXJVCarutg1WpUaaiWLwIQOleAY
	 dvQOtmMf51qesB1RV5bDMeXhNh3noFXpNZonod3rrTjatOKYhZ2lJoQ+LIpR960/c9
	 hhFlby2zRJSptvWNUHHUMEWong+7C7x3Q4Udo+LIo2gjeYUb311ITKs5hFHLD2y/TI
	 w+5WMGCrw/50TWQXnwNcgQjkxYKgB+cscH7BZzcd2oNcyoMHmoeQVH2X2zUvVtv7Ek
	 EbmoA4SCOQBmc941vJOvvnyi6R4PZxa97sfI78ntkOxUmjL6Z6vwrelH1govS+364S
	 M3sHHJ4dul2wTj5wR89juGmc=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EA85140E0173;
	Wed,  3 Dec 2025 21:18:20 +0000 (UTC)
Date: Wed, 3 Dec 2025 22:18:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Steven Noonan <steven@uplinklabs.net>
Cc: linux-kernel@vger.kernel.org, Ariadne Conill <ariadne@ariadne.space>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <20251203211813.GAaTCpFeDir7jXkEPf@fat_crate.local>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114195730.1503879-1-steven@uplinklabs.net>

On Fri, Nov 14, 2025 at 07:57:35PM +0000, Steven Noonan wrote:
> On a Xen dom0 boot, this feature does not behave, and we end up
> calculating:
> 
>     num_roots = 1
>     num_nodes = 2
>     roots_per_node = 0
> 
> This causes a divide-by-zero in the modulus inside the loop.
> 
> This change adds a couple of guards for invalid states where we might
> get a divide-by-zero.
> 
> Signed-off-by: Steven Noonan <steven@uplinklabs.net>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> CC: Yazen Ghannam <yazen.ghannam@amd.com>
> CC: x86@vger.kernel.org
> CC: stable@vger.kernel.org
> ---
>  arch/x86/kernel/amd_node.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 3d0a4768d603c..cdc6ba224d4ad 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -282,6 +282,17 @@ static int __init amd_smn_init(void)

That better not be loading at all on a X86_FEATURE_HYPERVISOR configuration.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

