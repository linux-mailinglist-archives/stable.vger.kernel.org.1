Return-Path: <stable+bounces-75976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB5976622
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F99A1F275F8
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7AD19DFAC;
	Thu, 12 Sep 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fHMCmL+p"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AB19E990
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134987; cv=none; b=e2z5wTAcw8Tx7GP+Zwq0xvymBajGYQqsVaFVbB950ABOu3ja1Bp/TIyiO9hR18j6jctAoPoptOsFZcbBP1YS2haiZDozUvV590HasL4k6yhjceHUuJUK4LKSyyF4gvTrhCI+ZQENmU6V+TvsU2gmk6/RVCHbITQR1I0jonyLn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134987; c=relaxed/simple;
	bh=/TleOWHZP4whem8IIAIpC+gQ6k0D0xz6bxVum5AFqms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVsdnubbtneHb2o477EzczdgezGZ3QwhzvSm36xwnA1OWaSq9j1zN0cYZ86mh9SPOti6fKMZ44hORfdQjI6wtYDi4qRSrHTr8leE3KMcVFLVIo81pIvANjGQVfr6+KBtPaS1XE9yIF5u+6FJZYf2kLZqH/RRVcgKaU8fF39flX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fHMCmL+p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Af3UiaSTtvVMACXrK0RDN/VWI8LBjfOwA+0RWsQXywA=; b=fHMCmL+pKkST2F0FEKk/v7OOnu
	Bm48g9MMpH1gSWUkkXNGRh5k3O+rIGF2s8OAE2hKBo0g8airQVuEy61YSkhOuZuQyvgFYNsDHMYGv
	2p0hR4owi+Z2Qif4yYLar44mrEkdEVxExkPJAd/C9f37trPokE8zd1QPQ8udfLjkUEwLLxAqvP2rl
	/Qde/eks7Q581sLcIVgyMvx2sjeLbAdoAqAsz6I5zzkyYzIk2hDd6tqE4uoHsj7Ak6Q3OZ2PYMOB0
	DL9zBeN+bv1kYjMtr7LaESfVxQSOp+nnDXOR0br8XurQdFgVuvEvbrDlJ43y7DqLwDQvhF6ccwziq
	UoMLHNPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogYn-0000000Cc97-3iuE;
	Thu, 12 Sep 2024 09:56:21 +0000
Date: Thu, 12 Sep 2024 02:56:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
	stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Message-ID: <ZuK6xcmAE4sngFqk@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
 <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 07, 2024 at 11:38:50AM +0100, Andrew Cooper wrote:
> Individual subsystems ought not to know or care about XENPV; it's a
> layering violation.

Agreed.

> If the main APIs don't behave properly, then it probably means we've got
> a bug at a lower level (e.g. Xen SWIOTLB is a constant source of fun)
> which is probably affecting other subsystems too.
> 
> I think we need to re-analyse the original bug.  Right now, the
> behaviour resulting from 53466ebde is worse than what it was trying to fix.

53466ebde looks bogus to me, and the commit message doesn't even
try to explain what bad behavior it works around.  I'd also like to
state once again that if you think something is broken about dma
allocation or mapping helpers please Cc me and the iommu list.

Most of the time it's actually the drivers doing something invalid, but
sometimes it is a core dma layer bug or something that needs a proper
API.

Also while looking at the above commit I noticed the broken fallback
code in snd_dma_noncontig_alloc - get_dma_ops is not for driver use,
and starting with the code queued up for 6.12 will also return NULL
when using dma-iommu for example.

