Return-Path: <stable+bounces-164877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CEB1336B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5993B392E
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F311F3BA4;
	Mon, 28 Jul 2025 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A54JLMjh"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DE2E36E6;
	Mon, 28 Jul 2025 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673372; cv=none; b=V/g5DfoRh1TGJHLZxj7hPeipwNfgniCl4zaa77JJ6H+3CVl6lwkeR9P3cIGm2HHIDG5eIkIM5D+jGSpfaMB7y/tQpp0NvnUQG5CcGwiF1NfgorkGqg0dVacDJdkraIw/LChgixCcvG1LZCr4h1IaJqiJ8LknoUs5mW7MplZo8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673372; c=relaxed/simple;
	bh=7Tykp5+D7210kt5AoNLzasEErVKT9EUVncJwUtfhhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwDfKB9cvVyrBBg/Udbf2khE1Ld+VDUSmTzWMR81CsA6qiuC7x2QF1C+d/hIwRolHeGayH79ZTs1faH1gNQYf3HyFzvd1DCkd70I24cvnjfk7Vb7jX5BGs5mMqTWIX0CTtj8Id7Hkb82pDmAGYVl6DVG9R1L+wMrmZteKZMN3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A54JLMjh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=U38WBbQd9E59rA3tDIm22NEKq3lI4YsOojYMeyWppNY=; b=A54JLMjhNhTRGSAERKE/77OhSa
	a9ZrhSHuQ1VMdbt08xH4mZn8l+DM8UOq5jrln0e5FvaaxKLNGzwoQigE/xgk2UfFdo8a9UVV0hkql
	PcNwsfuyl98rI9bYR7omqAsErouMTmIco5qC5vXhklGqjAa3GaLzUtF9hswYviI4+FAIurPxD06a8
	k8H2Ka6ow5VJiWfw6FX6tb/YZq745PZhCZjSBtIIYkpZEn5TLbMpY5HgPjusgeJtyCVmuoML5Rwe3
	QDM5/fYlYSjvcLYth5sJkQxEvs/d1ykXd5x1PXz8KLGN+BbnZyE+g5Vf+bHHakOIW6WTLDyU86YBW
	/DJX08CA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugEYE-000000040Bx-1YVw;
	Mon, 28 Jul 2025 03:29:22 +0000
Date: Mon, 28 Jul 2025 04:29:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: liqiong <liqiong@nfschina.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aIbuks-8-FOckIjo@casper.infradead.org>
References: <aIQMhSlOMREOTLyl@hyeyoo>
 <e6f14d8a-5d32-473e-ba2d-1064ab8ef8fe@nfschina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6f14d8a-5d32-473e-ba2d-1064ab8ef8fe@nfschina.com>

On Mon, Jul 28, 2025 at 10:06:42AM +0800, liqiong wrote:
> >> In this case it's an object pointer, not a freelist pointer.
> >> Or am I misunderstanding something?
> > Actually, in alloc_debug_processing() the pointer came from slab->freelist,
> > so I think saying either "invalid freelist pointer" or
> > "invalid object pointer" make sense...
> 
> free_consistency_checks()  has 
>  'slab_err(s, slab, "Invalid object pointer 0x%p", object);'
> Maybe  it is better, alloc_consisency_checks() has the same  message.

No.  Think about it.

