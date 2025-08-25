Return-Path: <stable+bounces-172854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5BBB33FBD
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8B1189C33C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E315624D;
	Mon, 25 Aug 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FS/r42Ov"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A91494D9;
	Mon, 25 Aug 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125621; cv=none; b=S89BPqRNzKWgKxgB5diY8Aaz1/+dcQRfA4rO0Sb1ZgJFbnPdZ6aluz8Bt5ageZYBEe4+ma8+Q9dRXAntRN3/j3U01FZm7FIDkGaVZErDPNtr5lISt0D6Hru5a1K7ksLSyIitid2rLTgzhu9bODtjpRAxY+RfClE3pVnkW9TFAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125621; c=relaxed/simple;
	bh=uitKs38zSaKsACMqL/VBCSaoOH5sQqG5ek7vhydclZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFd9L7JnHb6yB5TIdBFmr/X5Tuw1yAJnllY7lRqZI/ePF2ptLogP7qBaP4J9fW5Wf6mCCBd80l1woqcUjvP5kYnbL9W78nSEUPqMtRpTG1c7SlbDcp4y3MrPJ1oh2TApjv2fk6p606CwP/GaBvlpu/OMfJPN/lRZEgWKdFbbpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FS/r42Ov; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SV07zR4F1l/OSOnyqjvj3Wbmda/ishTOLR/wNk9yGwA=; b=FS/r42OvitRP7F7YpcelzC+BCl
	A0kN2vM014Ycmx6Vcazxtd8GKa0pMdQ0vjix6z9aenEjIU46o1CHDekhl21Am4ZciyjNJXdmo8hvw
	JhBf+48BDzDCRT/1lGsgYh1SLVkhIykBEiTPgVJtFC2VxLtbF5hwDKaiA0PAg/prvnS2xeqU2e2gr
	XMc6RlozPj5jQ4y/HV3LwAIN3X+RGR7SuYU6amyXISkN49xSxcljtvUItZzcAJQ6fpNE+6pHHzyOm
	NRYhk0zMcvtkbK6KO5vsFwGrLyT7RhcTLqnyPY/p5IpW+yJJxTukercU/ogHDo+YnBkW1wx/ij2v2
	fj6m861Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqWUZ-0000000DqjD-1and;
	Mon, 25 Aug 2025 12:40:07 +0000
Date: Mon, 25 Aug 2025 13:40:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: yangshiguang1011@163.com
Cc: harry.yoo@oracle.com, vbabka@suse.cz, akpm@linux-foundation.org,
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
	glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: slub: avoid wake up kswapd in set_track_prepare
Message-ID: <aKxZp_GgYVzp8Uvt@casper.infradead.org>
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825121737.2535732-1-yangshiguang1011@163.com>

On Mon, Aug 25, 2025 at 08:17:37PM +0800, yangshiguang1011@163.com wrote:
> Avoid deadlock caused by implicitly waking up kswapd by
> passing in allocation flags.
[...]
> +	/* Preemption is disabled in ___slab_alloc() */
> +	gfp_flags &= ~(__GFP_DIRECT_RECLAIM);

If you don't mean __GFP_KSWAPD_RECLAIM here, the explanation needs to
be better.

