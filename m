Return-Path: <stable+bounces-126628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDBA709EB
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020C3189DFC3
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF21ACEC9;
	Tue, 25 Mar 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxiEXghC"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CD19ABC3;
	Tue, 25 Mar 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929159; cv=none; b=I3jHlZ+Ar+qC4RvCuhon3oQyHaqvCUPwL37waBag65Z608cqbKBhav5CNz8rep+a8UqZ3DU/msptVeCvFWnpRcOdQbXHBmtAG62B1jZIWSU34AJwn0Bmj7TT+0e4DmxzxT6wUNgw4PeX4EVoEo1+q30lhgbkWXeglDaryqBKb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929159; c=relaxed/simple;
	bh=3SRmhjMkb1Jgd0rJ7w+EjGi3CoKrDexYIZbig8bkFhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5icvYrow+NCA3905gfn+kRGwZB02/W2dikLmgcMEeR70BwGsLr+mr9eRHLdEUPVRtijEZywvUoTkw9G2iXRNhGex5smhONulrSr6B2usj8v4wKXj2+jpSNJEdnLdWsp257Ne4pnio6Dr3DpvFrG01L+As3l6MsNGhCcgy4CYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pxiEXghC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2G/yfBn6d9OmLK3ab4K4caDrPZoiqKGqZEwV+WzWsD4=; b=pxiEXghCOLWIrHjgIKQ7tNb7aV
	VliuuKOH5C24u+FPO4cM5vbmR12RwPqoFUqVtlZvASScKMrgK5gUHAd1NQ1VSbdIhec2IB5el9QLY
	JydIlSghqaIOjU4PRD2obNUyw3sbGl0pQzoUawW2hvWSUKv56131U9h2v/E4Ry+ORmdflAdwKHqHX
	fSQ+LQhBztZWmGjohslak7cmNyscHwtHaCsyeOAUo1tmcr+8eRGAxarIKgkW1V+zEmCxoRTBPKdvR
	GBM/nqnq6BUiXDAV5+XSzOFkTqcTyr2YXTCWxLE1iGdk5EfQy9jAYxWAp3DvqueNo+wD+eiBOZXRo
	TTgUy0cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx9UR-00000005gGp-3cEY;
	Tue, 25 Mar 2025 18:59:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6DB363004AF; Tue, 25 Mar 2025 19:59:07 +0100 (CET)
Date: Tue, 25 Mar 2025 19:59:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pat Cody <pat@patcody.io>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250325185907.GC31413@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <Z+LH3k2RyXOg9fn4@devvm1948.rva0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+LH3k2RyXOg9fn4@devvm1948.rva0.facebook.com>

On Tue, Mar 25, 2025 at 08:12:30AM -0700, Pat Cody wrote:
> On Mon, Mar 24, 2025 at 12:56:13PM +0100, Peter Zijlstra wrote:
> > Does something like:
> > 
> >   https://lkml.kernel.org/r/20250128143949.GD7145@noisy.programming.kicks-ass.net
> > 
> > help?
> 
> To clarify- are you asking about if we've tried reverting 4423af84b297?
> We have not tried that yet.
> 
> Or if we've included "sched/fair: Adhere to place_entity() constraints",
> which we have already done- https://lore.kernel.org/all/20250207-tunneling-tested-koel-c59d33@leitao/

This; it seems it got lost. I'll try and get it queued up.

