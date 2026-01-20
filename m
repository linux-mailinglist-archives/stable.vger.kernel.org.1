Return-Path: <stable+bounces-210503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN/KGiV1cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:41:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 130595232F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81121667BE2
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F473E9F6E;
	Tue, 20 Jan 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWlHrxNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B33D668E;
	Tue, 20 Jan 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911290; cv=none; b=ON+Dr6LIiKyy307LKyEmGpy3Ig5LckZDb1mLjXq23kB57QT339aRt6y4BsX8qnzrcAwGufiA0vaO+9K+IY1uYpWyG6xX+hqtMAB8Hro+uvD7rk7RHlt72ewm8fR3Z74IZUzb3tTD3iHFtYm98g4vQpGKHflu90pTDjJijzRlD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911290; c=relaxed/simple;
	bh=IiflnQDxJs4RPcYs3sxwTdyuyK0ue/FTAVFF6cNAICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8Bo0H5JG/ulxEgzfrSR31Ss8G1eI8imt77zXOdfqI8xdtp6enFoxnq+eqJ7Ryqqx5ZwaA+E371vKCoD+Jb8t+Tlq5EwAjpm7G6x90y4UJeFmnWnc03M3WParvy+0ftxzjj+9IB2QCuOhbXQVVjYFDxNDM4VOqmTQeWgZQuSSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWlHrxNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF6EC19422;
	Tue, 20 Jan 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911288;
	bh=IiflnQDxJs4RPcYs3sxwTdyuyK0ue/FTAVFF6cNAICg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWlHrxNgWqnpPI+Z1vQZLBDmUo9Wlf6vxXq2teccxfLdid4tvBzqGTD3v3/gM1S0b
	 dMOL8fE7uBhRCT7Q8arm/7M9dWP2JUPE2sztXWnIIm/s2m1Ibl0ceuwf3oeKpHeh7L
	 wimFfhq1vH/am8BNvKU+hR3kLHQkgzS7iC968GPLDFcFn+Gb1Ip6nTsYu5ZawYOv/X
	 jsIv5x6Xh6UETvy9QdoVFr5qBWhfQOewc18u7kpYfxQlgnJCk7X1f6izLll+8W4CxR
	 qGxdO5/y7sKhfCVJpTQbtzk0x3JMRoZVUPf6SEHp8kWf8yrUxgCOAsylNvb9KgaqMU
	 qMGgqcqHyiMYQ==
Date: Tue, 20 Jan 2026 12:14:43 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Dawei Li <dawei.li@linux.dev>,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <aW9xs1ko3nWq5VbS@willie-the-truck>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
 <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
 <20260105185423.GI125261@ziepe.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105185423.GI125261@ziepe.ca>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,linux.dev,8bytes.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-210503-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 130595232F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 05, 2026 at 02:54:23PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 05, 2026 at 04:02:34PM +0000, Robin Murphy wrote:
> 
> > > It is reasonable that Linux will set the attributes properly based on
> > > what it is doing. Setting the wrong attributes and expecting the HW to
> > > ignore them seems like a hacky direction.
> > 
> > Oh, I'm not saying that we *shouldn't* set our attributes more exactly -
> > this would still be needed for doing things the "right" way too - I just
> > want to be very clear on the reasons why. 
> 
> At least I know of HW where the SMMU fetches covered by COHACC:
> 
>  * Translation table walks.
>  * Fetches of L1STD, STE, L1CD and CD.
>  * Command queue, Event queue and PRI queue access.
>  * GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported.
> 
> Have a mixture of coherency support. The SOC has multiple fabrics, one
> non-coherent one specifically for isochronous traffic.  In HW some
> SMMU sub-units (like the table walk) been wired to the isochronous
> fabric, while others are using the normal coherent fabric.
> 
> So when it comes to this statement:
> 
>  If either the SMMU or system cannot *fully* support IO-coherent
>  access to SMMU structures/queues/translations, this reads as 0.
> 
> The HW is "partially" IO-coherent, so COHACC is 0.
> 
> It has been lucky that so far the incorrect attributes haven't caused a
> problem, but the next spin of this HW may have issue here. I'd like to
> see it fixed.

I'm not against being more careful about the memory attributes used by
the non-coherent walker, but we shouldn't fool ourselves into thinking
that Linux can treat coherent devices as non-coherent and expect things
to work generally. The use of non-cacheable mappings in
dma_alloc_coherent() and cache invalidation in the streaming API when
transferring buffer ownership back to the CPU can both lead to DMA
corruption if the device can snoop the CPU caches.

I think we're all agreed on that, but just wanted to make sure as this
is something that has come up before when talking to hardware folks
who seem to think that the "dma-coherent" property is a hint.

Will

