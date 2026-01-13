Return-Path: <stable+bounces-208233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D2D16D5B
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6FF30463A9
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B422366571;
	Tue, 13 Jan 2026 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fVS8phZ5"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0053019DA
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285293; cv=none; b=ceJ4A3R7wkqVG7nw1u9XdOpcjxH59I5y/nru8we+2uvyisyKlARwSuoQfT5dubZTo+mbDzLRBsg073Mdy87m5bInD021/2F2J3qpaHf+O8sy0HwDV9D3YfAz5ouqMH4q4dhT+iBtb74lHV3LdfUobhnIrYlr8NhJNbgZyJLnFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285293; c=relaxed/simple;
	bh=FPXvZxJy1O3mBqOg/RS0gIvA+yt7jWWckDqSmVQNODo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkO/UabtTc2ycFOfGywjwYoQiPllbMQluGd3tq5tqgcSuApAqDi7j9Jh1mLF+SOX6wQZpjUu7wM60bWPSLq9yyDPEqAs0LVDP1QKmqyc3c8xBbSVzBp8DuoTD/sMUclK+a4aLNxb8Aiu3CDuhsnlQJau3XGtAHcUsU8acnm7d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVS8phZ5; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Jan 2026 01:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768285289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gXT7qGutk2+DH5bBJ+2xc0xFxb2K2z/7JsHBuzHDaE=;
	b=fVS8phZ57LxSX6RL7Yux2hI9sPdOkO9C01cKiSMeEubdUqRpJ82UEPK3CsfdDNvCXG02VM
	TeVb48/nTKaJVui1Cdg5yG3UVaxrxR7vLzR+SbHjxaCFyClpf6sRx+6MSGl4X4yyWiZBtA
	HM94lg7C9kZ/Da/ztaZISqtj7qV7sOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Coly Li <colyli@fnnas.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	zhangshida@kylinos.cn
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <aWXjf13_fMiaGBxB@moria.home.lan>
References: <20260112172345.800703-1-sashal@kernel.org>
 <aWU2mO5v6RezmIpZ@moria.home.lan>
 <aWXgStXQyV38uz7o@studio.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWXgStXQyV38uz7o@studio.local>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 13, 2026 at 02:08:27PM +0800, Coly Li wrote:
> On Mon, Jan 12, 2026 at 01:01:52PM +0800, Kent Overstreet wrote:
> > On Mon, Jan 12, 2026 at 12:23:45PM -0500, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     bcache: fix improper use of bi_end_io
> > > 
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      bcache-fix-improper-use-of-bi_end_io.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Yeah, this is broken.
> > 
> > Coly, please revert this.
> >
> 
> Yes, let me do it.
> 
> Although I didn’t ack this patch, I read the patch and thought it was
> fine, yes my fault too.
> 
> This faulty patch didn’t trigger issue on my testing machine, I guess
> it was because on simple bcache setup, re-enter bio_endio() happenly
> didn't actually redo things other than calling bio->bi_end_io().

Yeah, re-entering bio_endio() will work on simple setups - but it'll
explode as soon as bio splitting starts happening.

You really want to be going over anything Christoph does with a fine
toothed comb.

