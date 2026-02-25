Return-Path: <stable+bounces-219636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCToMMUJn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:40:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37E198D70
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E479309CC8A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91FF35B650;
	Wed, 25 Feb 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="p+DlPErt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufMRd0DA"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB387362
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030185; cv=none; b=fJHw6+7t22qkcGdthVKAp8MLgYHr7vlyReNFCErFUoWmt8NcnT8YQXGFWtIc5fg4x0nyJubelpGzob08dIK7SGHtoYFPdjJGpR0jxNRIiKnsX3wP8nzUgIH5AALAuBDWMRUbvyFr7vj1QGZm7T/oIuyB5iqcLyPq1YAJDed888U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030185; c=relaxed/simple;
	bh=eT1BU9sH5cfbu/WmGlOcD8Ari7sSL7zIaxeZQIMv+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1NWhDUGFEEvgWz9p7cCl+KYbrZRwzrJfrvqEyW6OmREUKNpGIxXSKfeRBm21yhbY7SSy3G+naNbYJvHKISwA/j1EC8WEomfj/yAE1AXe8ZB5R1Q+LDB5xGx5VZetLqI/EauNwOrfNtj5JHB+/ToJei3x+sDDvBSHdjFtuosIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=p+DlPErt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ufMRd0DA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C3707EC054B;
	Wed, 25 Feb 2026 09:36:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 25 Feb 2026 09:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772030182;
	 x=1772116582; bh=PLQj5cNmf+5zhj8ao+haRIwTMMaibwhvME5/ElqnN8w=; b=
	p+DlPErtQ3y60hyddX/PrPqtKGckJVYmyKRDg25nSzJNEJxBBaY+qHBZd9b2Eohy
	vVe1Bhfv9uJtMVLHeb85zaUNMQbPGxLxEM1px7oKG+IG9g2uZRX/t7tDJ8Y2rsoj
	/yYhhv+VVaQ2mrCvh+i0Glx3SC5LpRYDWOo/1lomFxV3i0aSIRyxCJVdJiKz4abN
	KOIPP9U2bpg2ewXJt5m2yJubpOX9ElTDHOrdexL6nEKG0KcUOtx1fkFi29oqqqIa
	ry4orwzYnzYDhGziy4E86N2iUvGPcsgUCb9zOb5xWrXLIFJCHgERNWPfkVJiz4o1
	FMc2emaOrLYHJoShBJAAIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772030182; x=
	1772116582; bh=PLQj5cNmf+5zhj8ao+haRIwTMMaibwhvME5/ElqnN8w=; b=u
	fMRd0DAUsaXWar4JrtFsCBLv/XXU+bzZNxNfAzsjumNHBUozu865/6gKeVjn8LL7
	J2UfiDfsEdDfa+d7qV0863v98BdKUcwDN5oiNnqheXbcFMextB/zzpNyqOfxplHs
	acRR39qBlZTwnWaT1UwbWCRWYYNnbu5scho9Twtci3VfYy84EF1hY+9gu8CSnVIH
	v45suFLfQ3dLWCz+o7AYDc9ow/HCgUWn00MYJXcbuPxSYdVAhShaz22vL6egwHrL
	smH7zhULkZkWNzkghq21ChbLTd0lcu6zBdV46a+MR19a0wrQBkgY1de5IjAVlzzG
	9boDUSBpV6VUdtJUpyp3g==
X-ME-Sender: <xms:5gifaU1OPGNdCHMAw9f01ORzBDvPID9_ugV65PqAxJJOMvMrjeS9uA>
    <xme:5gifaXSVdCYvbdBZpaKSeMCTnLX_mkfYqWA9MhUU144r3VV2HpYfEkskLb59gMXj2
    IBX8Rnxl3_MG3MJ_tGtSzBvJHtmFDr_KHs1FCjXx8DjG-IKow>
X-ME-Received: <xmr:5gifaYecVAYAhHG0iB36o-kKqwOqs-4lTiHZGnP1RTKq2c2OdVWniOkhmJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegveevte
    fgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdifvghishhssh
    gthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopegsvghnseguvggtrgguvghnthdrohhrghdruhhk
X-ME-Proxy: <xmx:5gifaYd1lHeaXV95iwqM67hB5O8bbQUBvbrlNC_NGdjDRLep-T4seg>
    <xmx:5gifaS2Yj60NFeQzPJBseruAkmSUBwUR5qgAhyUaKRM8J-lCwJEPbQ>
    <xmx:5gifaQ8MPS8UHOqxnFMZYRtcBXg7JSuJWGiSut6uUKI_aiZxzWHdRA>
    <xmx:5gifaX63cuUB6qJTagY8THAXCzG_tKTKX2mamVVIcXdmzrA2sY_QtQ>
    <xmx:5gifaTd28vlQ-uhqjBGtk9hsZS6PLJ8fxByJnhqReEapUYDpKXqGb3NU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 09:36:22 -0500 (EST)
Date: Wed, 25 Feb 2026 06:36:13 -0800
From: Greg KH <greg@kroah.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.18.y 6.19.y] ARM:
 clean up the memset64() C wrapper
Message-ID: <2026022546-sloping-proactive-d4f7@gregkh>
References: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219636-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: BC37E198D70
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:35:09PM +0100, Thomas Weiﬂschuh wrote:
> [ Upstream commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf ]
> 
> The current logic to split the 64-bit argument into its 32-bit halves is
> byte-order specific and a bit clunky.  Use a union instead which is
> easier to read and works in all cases.
> 
> GCC still generates the same machine code.
> 
> While at it, rename the arguments of the __memset64() prototype to
> actually reflect their semantics.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
> Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
> Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
> Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
> ---
> Hi stable team,
> 
> unfortunately the backports of commit 23ea2a4c7232 ("ARM: 9468/1: fix
> memset64() on big-endian") does not work on 5.10 and 5.15 as
> CONFIG_CPU_LITTLE_ENDIAN does not exist there, effectively breaking memset64()
> on little-endian. Please use this variant instead which always works.
> For consistency I prefer to have it backported to all versions.
> ---
>  arch/arm/include/asm/string.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
> index b5ad23acb303..369781ec5511 100644
> --- a/arch/arm/include/asm/string.h
> +++ b/arch/arm/include/asm/string.h
> @@ -33,13 +33,17 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
>  }
>  
>  #define __HAVE_ARCH_MEMSET64
> -extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
> +extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
>  static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
>  {
> -	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> -		return __memset64(p, v, n * 8, v >> 32);
> -	else
> -		return __memset64(p, v >> 32, n * 8, v);
> +	union {
> +		uint64_t val;
> +		struct {
> +			uint32_t first, second;
> +		};
> +	} word = { .val = v };
> +
> +	return __memset64(p, word.first, n * 8, word.second);
>  }
>  
>  #endif
> 
> ---

I don't understand, why is this patch needed at all?  What issue is it
fixing to require this?

thanks,

greg k-h

