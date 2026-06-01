Return-Path: <stable+bounces-259637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOSJL2THHWrgdwkAu9opvQ
	(envelope-from <stable+bounces-259637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 19:54:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AD623888
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16C033038121
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 17:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D33E0C46;
	Mon,  1 Jun 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KwF7uc1C"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530983314B7
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336375; cv=none; b=RYhKbrp8CutdCq4Zj0yRQwu5bnkti88Oz9RD+J0wpZbN6uh6LzQg6tWHcZvAN8pll4id3Zh4QsWMZgtP7AbbnZO7vs5fQuAdz2t+nnRyqmsffzZjHM0f07yyURSP0WcPFi/TJ3rjomLSoSz4cxVXeLxVE9snGIv/8qAQSX0ehCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336375; c=relaxed/simple;
	bh=xCSmiTgW2gp0UZZcRgch+bSYZxNYHdqPa15p3QyPPNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvfUTi6fZ7OnIUEusMMJ0bHtOfN9BZ7+I6JOeQgGjDdfm0Ohw6tpCG44aByaiof2ApyLO/lT27jeWEL9txHLKNlwNEerN8fhKqgUqeQdD0SN8F5KpY6+tLPbF8U7PEEX6ngzxr5MEk8WVYZCRYq7ekF2YJRy5seWZxzl2rAz8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KwF7uc1C; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9155183b42cso195004585a.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336373; x=1780941173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
        b=KwF7uc1C0EDYQ61nhF93rVhA0bqtAx73msjzRBzrBDEbe81L/xHDF6f+VW6dSE3Ufg
         Vl0XmTuNjXehaCS9SjnZW4f2xAZeKtIdE6lcbq806hV/aoV49126yyXWFoFy2ZxEWm8R
         9uXcFVpdp2UJ1U+EKyESL5NFk2JwVwzM/9+sKVzWF0aZOm/ikyeOaiBsqSvsc84Coojl
         5jxAkApUh/Z5ZoDFUWZ0l/P98cuu2TXGAnyMEdqCR9MkeT30KMyV9OxxyQTkregpkh1z
         lq/9AHebWG9oCOLfvj495dYXOyrvbEb9pfqTtzewdXD/w+zxf6UTvm4GCOYtsxbqYW4J
         6u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336373; x=1780941173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajzqlQYEAeycmyed8yu6upDmFOo140vP8s+rqI6MeM4=;
        b=jYRiPeYv+In3qX3baQstQ6yRDa/bFXkMnVR32nQyJRs4xAh5q0H0L/WrU+DWnWvOJV
         2GwW7YbAzYp49OftBQBFQBOvlA1i+x8l1O7eMUtvefbigtVMisfBPR1QEGpuQRBgIGoT
         1uxxKRQWH911hTMg2SfcwGeV86RKBB9ojl9Lr4I+sBtyXOAfdM05mF6MYUipHgnEvDP4
         PKqWCXXVlOtq+t6PMm53hFDkXbMgTuHG3ItKUGdIj+qn57wHha1icJIbXq4/V+u0TrzF
         PcuV64R2iOfsWXOPtauSx9o4AFwNG1PnmBBWGDAbRUB2xHeB1pzi4lwjloTR28GULSWA
         UR2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9GlHRBsuznKqSNotKcGqJ77CHSRFSPF9xYQtWTay6wWcnuduGpG94j18E/hX1Bl+JsDVNvfcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMoNl01OoLCEaxtW/olUULYLB22x7v92UDwdT5/SFCeiRezIv
	tiQ9h3PLeykA+dAmADbNFBWI7is/DTqxKsYspvibR+AsAkozSSYFzRhoDH5Xl9g+kD0=
X-Gm-Gg: Acq92OFqAQhMLGXQb6+hnytsaJKrCtpW8zlrxpoeimHUsf1bvcmB85Hu1T/K9TQ5tAT
	JBMAYKDKECo8DTlr1kUgqagYIYeHKEW7mnNy5ZkKy726hn+N/nHI3mpXRDQyoiUsf+4OjosiDPV
	Xi0T+hDtcMS4AYqK+4C0akhtE1+62EWJ+A2xnr69ioaJJhxQJT2tmrkuU2YXDds1uFWSACX2rhM
	vsq4tWYY/3GXuP66Qz6e6A6Ad+n6Bnvqz1dlCAmxZxcQ3r/X/dH4T4CYJ4iYns0hzJRvJW6b54k
	8tJEi1V79jLM3t/WHjGojQX5tcwanaEvcuVJxs5ywy7+VWhTnP4XU1Nk3Un17x8/nu2hrB/tE4o
	bMqTnb2MVGPrIYiBO0dg1r79vt/Ye9QhAIYXTZuPXQdO+vtlqRII0887B87k4CrIsSdgfJGCxNA
	zUf9uSOdfWDn8lbo12k0NSH5ZrXWBz8qsOh/R4+3S+gUI9m+LrF9tg3THMPq7pQoRxY7SbhDfsV
	MbBCFi2yHyLmstx
X-Received: by 2002:a05:620a:2202:b0:915:4c9b:4120 with SMTP id af79cd13be357-91578006ac3mr63386685a.37.1780336373342;
        Mon, 01 Jun 2026 10:52:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265126asm1064337685a.45.2026.06.01.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:52:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6om-000000027gs-1lLx;
	Mon, 01 Jun 2026 14:52:52 -0300
Date: Mon, 1 Jun 2026 14:52:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com,
	stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
Message-ID: <20260601175252.GD2487554@ziepe.ca>
References: <20260528191658.2506362-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528191658.2506362-1-xuehaohu@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259637-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 3A0AD623888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 07:16:58PM +0000, David Hu wrote:
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..1aabc0ee70bb 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
>  					 dma_addr_t addr)
>  {
>  	unsigned int len, nents;
> -	int i;
> +	unsigned int i;
>  
>  	nents = DIV_ROUND_UP(length, UINT_MAX);
>  	for (i = 0; i < nents; i++) {
> @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  				  struct phys_vec *phys_vec, size_t nr_ranges,
>  				  size_t size)
>  {
> -	unsigned int nents = 0;
> +	size_t nents = 0;
>  	size_t i;
>  
>  	if (!state || !dma_use_iova(state)) {
> @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
>  		nents = DIV_ROUND_UP(size, UINT_MAX);
>  	}
>  
> +	if (WARN_ON_ONCE(nents > UINT_MAX))
> +		return 0;

The WARN seems a bit much, but if you have it then it should be
arranged so the caller ultimately fails.

But otherwise I think correcting the types is a good idea

Jason

