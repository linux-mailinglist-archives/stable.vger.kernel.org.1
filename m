Return-Path: <stable+bounces-56055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7F91B736
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452C2B2135A
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7E6F2FB;
	Fri, 28 Jun 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RyEUpc8g"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7697F476;
	Fri, 28 Jun 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556509; cv=none; b=L8jENI8od5/9Do9epeX6avJj/e4FgEnfWAvzjXB2PSKbNM4mit7Hv0CUMKIZFPKcM2B6EB+KAJlk71Tkm4aMKlQzkR/kk0U77HCKD/NqRJVQJXFZl2rQkGt26ghcLWs0mGHwvDYNEo3PupC6lqnRrdoHVtq+51620rHsqXC81iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556509; c=relaxed/simple;
	bh=HF2hpNavT5/PWUBKPkhv6MgJWRsukVAVBQWMHhh2bek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne6VrGu+3ToiKeTGtfn9UtRoPyiW3ecCQqAO9Fj03aDTOEyRUIIFE7MXq483W36flscrKFstqJgDUUlnLqgw+xvehRAytRQIPgkH/awu3Asp7WnMy3uGsjIWrLcM0whDV5Xn05F+PvgJAkc9D+ChWpE+sX0ZKuP7BvY/P3aSPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RyEUpc8g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwNI65z26hXlFy+OIdCDf7Sa2Aso/XRCklEBUbwFvB4=; b=RyEUpc8gQpSYQKjpaexcSEGw/v
	XzLp5Ajau1d9GVG28Z/ICBVyHsKlrNol4Qeqv2D1YprwnCXW4McPb/grZerR4cCNucFa774EJcLXV
	rhf8t2Ona4bkIOLvlGxezf5SOXtuTMZ9efGtg/k1oJ7+GHaoEuPphNRNqgVJfN5/kfFJDQXnV5ZsK
	zop4UFnl++iNEewNJUJ6kf+4QZiisImjt1+UcEyqwCIeShPs96L6fcZB8Ofmqxn44kfKh5+LDhjzJ
	2REh9vnJuyL0oawT9o+Zna4vXUQIlMX2qUxBMjmSfP3TxQbWqNCK1LKHDxWqFr6uXhmFNGCsDRmBn
	O9HgFJZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN5CK-0000000CmIb-1BG1;
	Fri, 28 Jun 2024 06:35:04 +0000
Date: Thu, 27 Jun 2024 23:35:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: peterx@redhat.com, yangge1116@126.com, david@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <Zn5ZmPQCdvHTCwAn@infradead.org>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627221413.671680-1-yang@os.amperecomputing.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +int __must_check try_grab_folio(struct folio *folio, int refs, unsigned int flags)

Overly long line (same for the external declaration)

> +	struct page *page = &folio->page;

Page is only used for is_pci_p2pdma_page and is_zero_page, and for
the latter a is_zero_folio already exist.  Maybe remove the local
variable, use is_zero_folio and just open code the dereference in the
is_pci_p2pdma_page call?

> +		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr, fast);

Overly lone line.

> +		folio_ref_add(folio,
> +				refs * (GUP_PIN_COUNTING_BIAS - 1));

Nit: this easily fits onto a single line.

>  			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
> -				       PMD_SHIFT, next, flags, pages, nr) != 1)
> +				       PMD_SHIFT, next, flags, pages, nr, true) != 1)

Overly long lin (same in the similar calls below)


