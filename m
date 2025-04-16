Return-Path: <stable+bounces-132831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D1A8B2DD
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0C61904B62
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254922E3F1;
	Wed, 16 Apr 2025 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7y9R6jB"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFB22E406;
	Wed, 16 Apr 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790380; cv=none; b=Xoj5P9D7xWLMFdF6WK38eIzA9f9gFrMnWXztTZ8GrUZaAOvqABIvRU8kuQTLkqucx0a4sCsDMz5xaBygcH8RiDM5YIFXUPi2bPso1iJzCLEuZEfox+NIvT2OTlSAQ6ppKe0VlNhimKuazcHqMs+EmlRZWJ6ndNRGNbw1UioL2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790380; c=relaxed/simple;
	bh=MkWy35MldUfbFDDapHrCdQRMkls14h+ATBdsggGtBv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDZp3XB9QiZd21CWhvCfrP6u8xCNa8OYKe43DtwVFCESMdseIUmUOCFsEZxqPDI76tLxxmRfSDyNYZy+Ji2WowcZo1hfXeghlyVFi1Gx+/QRnqF8aT/rk9K4ikBOpjJ8lJYFO4HhcTELPzZ5Iw5JDfdaIjYFnjpOIgWQ+Te4hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G7y9R6jB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yB4wmD74MiBKWLxUyjjkBFJ9xMt+iqwI8peAkwBlB74=; b=G7y9R6jBnX5I8JvtMu+x4Or/TJ
	g1Xifo64oGj+hZluL5QLP2UvgBJI8qSSDlV8632AS3xOSiIifL7Qak2aDLyen43Koyo+htLlk1uvc
	zPioYTpzUdonTeOuMSywXK7GdOwFmHji2GTYQlmWShiLXczJl+3IB9dUtTr2KtAWStN1d19qTHseO
	w+QsDhma6+j9PSMRuI7txGeGK/huQkj3d1u3YIx2YsOGsJ8fsYD2InGTHXbbBwzYfQhmi8Zjj4Typ
	9WRiA6PsX8jvqL5DRzrVAck8atFHtgxhVF7Xudm8aq9H2R2A2fW9myfn96Rv22GvFdrBDTh1EGorF
	rtFWlEag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4xg6-0000000A4BX-2FGW;
	Wed, 16 Apr 2025 07:59:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9F493007A4; Wed, 16 Apr 2025 09:59:25 +0200 (CEST)
Date: Wed, 16 Apr 2025 09:59:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Rik van Riel <riel@surriel.com>, Pat Cody <pat@patcody.io>,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patcody@meta.com, kernel-team@meta.com, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250416075925.GB6580@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
 <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
 <20250409152703.GL9833@noisy.programming.kicks-ass.net>
 <20250411105134.1f316982@fangorn>
 <20250414090823.GB5600@noisy.programming.kicks-ass.net>
 <0049c6a0-8802-416c-9618-9d714c22af49@meta.com>
 <20250415100705.GL5600@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415100705.GL5600@noisy.programming.kicks-ass.net>

On Tue, Apr 15, 2025 at 12:07:05PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 14, 2025 at 11:38:15AM -0400, Chris Mason wrote:
> > 
> > 
> > On 4/14/25 5:08 AM, Peter Zijlstra wrote:
> > 
> > [ math and such ]
> > 
> > 
> > > The zero_vruntime patch I gave earlier should avoid this particular
> > > issue.
> > 
> > Here's a crash with the zero runtime patch. 
> 
> And indeed it doesn't have these massive (negative) avg_vruntime values.
> 
> > I'm trying to reproduce
> > this outside of prod so we can crank up the iteration speed a bit.
> 
> Thanks.
> 
> Could you add which pick went boom for the next dump?
> 
> 
> 
> I am however, slightly confused by this output format.
> 
> It looks like it dumps the cfs_rq the first time it encounters it,
> either through curr or through the tree.
> 
> So if I read this correct the root is something like:
> 
> > nr_running = 2
> > zero_vruntime = 19194347104893960
> > avg_vruntime = 6044054790
> > avg_load = 2
> > curr = {
> >   cgroup urgent
> >   vruntime = 24498183812106172
> >   weight = 3561684 => 3478
> > }
> > tasks_timeline = [
> >   {
> >     cgroup optional
> >     vruntime = 19194350126921355
> >     weight = 1168 => 2
> >   },
> > ]
> 
> group  19194347104893960
> curr   24498183812106172 3561684
> entity 19194350126921355 1168
> 
> But if I run those numbers, I get avg_load == 1, seeing how 1168/1024 =
> 1. But the thing says it should be 2.

N/m, late last night I remembered we have a max(2, ..) in there. So
yeah, your numbers seem right.



