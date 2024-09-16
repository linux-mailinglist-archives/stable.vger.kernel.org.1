Return-Path: <stable+bounces-76182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECB979C1C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FAA1F23B49
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61E3E47B;
	Mon, 16 Sep 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jazc38fw"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BC23A9
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472234; cv=none; b=kMZ6jZYQFX6EGDH+Spmip9DrOelB138CyquOE1gb7nMzJQ1f9qDbnOfND4WryHzi55Rr8m7SAR1j6x1mXd/APtozKCXxWhU0GMYQL4E5rJHPNLXdxpXOUNODZKkdwI0P0mHbqke6JwFJ/KBG12J2QXq1KF6z5PW2m3LyQ1ZELZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472234; c=relaxed/simple;
	bh=Sjf08PRYXtgkIv9NQ0v4ETz3t7ZhXERBTQnmQ4ghrVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6iknsfktsKS/QnWzcmE2rhLs2gPV8Jj1LrAQLdq+T6KCRb28jYUbFvf958x9UfhjMCPiNfxNkm7i/4LkmHyYef33JSxhea2Wg5cQ1StlCLJKmaHeDyCaqjTNMHNDc1y5byNzx1aoOxK8lu/n9w5IXMAFqd1mydjsKPTbPvRFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jazc38fw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gju9XBeCOro1y93nA5waVyVrbX5nWYeDFXoNrraZEsk=; b=jazc38fw1Kh+LNx9gSWOMO22Uy
	MM3h6EiwAwxcdUMkuErVz1aregLWF5DHESZ+q9zuakvOu/jVvxmkNXbgYIPq7xz4yL5JtTCeEabZ+
	hWeE0eWeI4rydIgD43gTdxHDw/fo7eJQ1p0Sr7Ffv6Xog6cr13f0lkpZAzn8gk0mVVAp4wmGeV6NW
	hsl3XsG/NwVC2d8ZTy582+ZkpBX6fr6epOnyKhKOmwNCIMgLDxlLwEsKlVJuEXtBl0ebNvLNyz1Pm
	ECbYkBWhDHZr82ysQtk5zKsUhVg3OGPYilMFKfj7g19a3Yb8MogwJI8BT5ZrYRjRxiStmsYmGGzUd
	28lNN+QQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sq6IF-00000003Kd9-3lbI;
	Mon, 16 Sep 2024 07:37:07 +0000
Date: Mon, 16 Sep 2024 00:37:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
	stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Message-ID: <ZufgI6gw1kA8v4OD@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
 <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
 <ZuK6xcmAE4sngFqk@infradead.org>
 <874j6g9ifp.wl-tiwai@suse.de>
 <ZufdOjFCdqQQX7tz@infradead.org>
 <87wmjc8398.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmjc8398.wl-tiwai@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 16, 2024 at 09:30:11AM +0200, Takashi Iwai wrote:
> On Mon, 16 Sep 2024 09:24:42 +0200,
> Christoph Hellwig wrote:
> > 
> > On Mon, Sep 16, 2024 at 09:16:58AM +0200, Takashi Iwai wrote:
> > > Yes, all those are really ugly hacks and have been already removed for
> > > 6.12.  Let's hope everything works as expected with it.
> > 
> > The code currently in linux-next will not work as explained in my
> > previous mail, because it tries to side step the DMA API and abuses
> > get_dma_ops in an unsupported way.
> 
> Those should have been removed since the last week.
> Could you check the today's linux-next tree?

Ok, looks like the Thursday updates fix the dma_get_ops abuse.

They introduce new bugs at least for architectures with virtuall
indexed caches by combining vmap and dma mappings without
mainintaining the cache coherency using the proper helpers.

What confuses my about this is the need to set the DMAable memory
to write combinable.  How does that improve things over the default
writeback cached memory on x86?  We could trivially add support for
WC mappings for cache coherent DMA, but someone needs to explain
how that actually makes sense first.

