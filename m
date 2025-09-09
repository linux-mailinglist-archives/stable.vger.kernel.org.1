Return-Path: <stable+bounces-179130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6EB505C7
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 21:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4459E5E2BF4
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23E3002BD;
	Tue,  9 Sep 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FqbAnY7/"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1C24BCF5
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444568; cv=none; b=WrfBpNNghQ2mNnrCsQXKxxAKr+Rg1dzMFlo8Rv5/fhHNarr2VGw9eQGoEpLzVuiK8Tkkp6Pv3gKXPkfSqylb0+Dfu6OdPnyYYJuqfuCdunAvWc/W110zEG1240vnzGTzp5UsSVFp8fOosBvnOv27OW51+HQWgMeGpdmjXPDNFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444568; c=relaxed/simple;
	bh=X8wJTRgJGLcEi9EtsflCMYhUpaaTBt8jRFbpTb/kMqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRAjbfVOOfu6bQ255gs+2Ga85xv7XtNQXUAMbW7FVWaeaZ5szA8hfQe2ULSzUWrKsmNBuRm7ZQpS/2bJw5nxp2uwRaZY2F3n/bUh5h72wDNGs/FN9RnmSGaTcHYBW9JDs/ZNosC2PjT1ynLo2qdJB3Ds/goOzcz6kX+GBpqWa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FqbAnY7/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 15:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757444554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYkMx8WK7lNjK14p/mD7ZsSlCCvdjLO/g0ftEbN00Ho=;
	b=FqbAnY7/cSsNsdhVXzuR+mxDtHEbOopdB0fMwWrrxDIES6D63rfoHQWMSSXbZWbdSN4Egw
	pRxy7NJRo3xJmJE39gu7rSxVx7X4znt0sgNZtqNKSHMS24/iWyImwifoUq2e8Yz5ya8yTS
	3eT+8Ilj6QecDDEIjp1F+XC87lgKEHQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
	fthain@linux-m68k.org, geert@linux-m68k.org, ioworker0@gmail.com, 
	joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, longman@redhat.com, 
	mhiramat@kernel.org, mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-ID: <z7652ickjbgkcdtxcmr35yjmk3c3yokwnstfs5ym4vtqar56tz@c4lcrvzjashs>
References: <20250909145243.17119-1-lance.yang@linux.dev>
 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 06:55:42PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2025-09-09 at 12:46 -0400, Kent Overstreet wrote:
> > On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > > 
> > > The blocker tracking mechanism assumes that lock pointers are at least
> > > 4-byte aligned to use their lower bits for type encoding.
> > > 
> > > However, as reported by Eero Tamminen, some architectures like m68k
> > > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > > assumption and causes two related WARN_ON_ONCE checks to trigger.
> > 
> > Isn't m68k the only architecture that's weird like this?
> 
> Yes, and it does this on Linux only. I have been trying to change it upstream
> though as the official SysV ELF ABI for m68k requires a 4-byte natural alignment [1].

Better to make it an explicit ifdef on the architecture, then...

