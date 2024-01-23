Return-Path: <stable+bounces-15473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 161A4838583
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38439B2E417
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E41FBF;
	Tue, 23 Jan 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gi1sSXSD"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCD2582
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975880; cv=none; b=bBBWdhY/aHNpSxLzYeTowFNdnFVcstPa4kIHrrTiTcEdgqD2Btb5l8IT5KGw8ulJBVZM0N75++m3wyVOAQTB2I9qQa52vpXXzEXkYEK6cMmk4cONNgJWs7FoeiJfTR+wOrt++egHE0vyDnWgTJopHyxe2vfy0M/+sUBcIiOXhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975880; c=relaxed/simple;
	bh=mxoa5LVz4K4kzi2nnn5dySC185n0QyPrxzXgMCBrPNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3/5PCAPZ2tIYrVldauG4HzTEgJzsdK1XcQ6AVEItFrpyDdWKw4hkyrpmRqeXdtlTYbuEZgiWTe7l0dczqIcrOENLqyZBsLacIkupEux84sRzVhOGyLvb30S1J8Jlyt33u5n6zJgyA6MQl7MgwTxu97mnI/kKcenJt1s16HOlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gi1sSXSD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iR4r96N/Cv/qi+D7PRootDjIiGx5kSy/8NGJ+5i0hCQ=; b=Gi1sSXSDDeYOD4e6G//NSHoG4H
	HXJg6d1YWslxmt5nvYrqdnFz68n90w1I9rh4xo9GwyKUszo3ZSlTzLO6HS21ESb1LMe0BW9ffi5ew
	GM1uXORrgD+ZSobDGezRv4lUHQhxYGDTvOlzJDHXnSN+t4A3NnqjmZP9wp8aMWgy+3jnFHvE2BSUI
	9kBC6Qrz4okM4oOKG5VUyugBIvqQLtDcZgTuvq/nf9wLXcz44IPQMRFwAn1Z82U+oYKb37OrNygg+
	2lflaWJeXym36PM/873DbvRjidAVL4zBabLk3MEvdbJzmVmjmWwo9dtV7AuiZRvNe5dKq0Wjgr8m8
	YABhyG9w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rS6Fp-00000001s12-2QQB;
	Tue, 23 Jan 2024 02:11:09 +0000
Date: Tue, 23 Jan 2024 02:11:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 6.1-stable tree
Message-ID: <Za8gPb03od34Vhgu@casper.infradead.org>
References: <2024012215-drainable-immortal-a01a@gregkh>
 <Za7rqt0I5VaLT6FU@casper.infradead.org>
 <2024012214-switch-caddie-5195@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012214-switch-caddie-5195@gregkh>

On Mon, Jan 22, 2024 at 03:23:23PM -0800, Greg KH wrote:
> On Mon, Jan 22, 2024 at 10:26:50PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 22, 2024 at 11:31:15AM -0800, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 6.1-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > 
> > Thanks.  Here's the fix (compile tested only)
> 
> Both now queued up, thanks!

Cheers.  The 5.15 one applies fine to 5.10 & 5.4 as well.  4.19 needs a
different patch ...

