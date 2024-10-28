Return-Path: <stable+bounces-89103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1289B3767
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D38281921
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334B1DF252;
	Mon, 28 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISoeuTHA"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98C1DF725
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135582; cv=none; b=HRRkFAOY1wkiw/hl4qhsWOvKBWPhNGChDJIq7jrPnrr0XWkraSni52CyPZ0S0pMUSfsWORPoVFA2/1UKLdp5DZoQT+exEpwLj6mytjdi7HayVAMAHeZN5L2ZYN5Z34n1Y1EolFWUOOTna0eeYNhtOzRZekmXRTJ3Y2fE6hydrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135582; c=relaxed/simple;
	bh=9bYoCIsnrgKl6DpNAORtUU0H6P5iGPO4aZKZIFs2FaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuTsB22XjbMVat1ItlHfgnjJ/HLbVMXqhGDIiSk+kqiC6pxW4m7eU1WbXh8xMsEdydHSxr9WtQ+w88AwXO3o5Xeeh/URMvYOMiKTonSjtjHBT8z8rOetNuy0wYeqA60110qmrCvP4mBIDie4IwBcjv5gamtj4iYfOv6b/OShS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISoeuTHA; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 28 Oct 2024 10:12:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730135573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJZPIUyASHKIZLcZxFmHyTQ9c7DQ9IIhScA6QACGQKE=;
	b=ISoeuTHAKwgwBa2kBiuaCcAGs7PdxTWGaWY/mOQZ9bZkhdCOVcSRoidFFrOLPrTdVkuGrV
	dzVigfMa+dOk0U+4Wokxm7lP7150WrsL30abwP2Oe6nC8YZw/zchsSxzefQykjeM7+Q5B6
	JaC3dxU+91EV66rlqx4xWmYmItFxONM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] KVM: arm64: Mark the VM as dead for failed
 initializations
Message-ID: <Zx_GDqLO4lBQHnxL@linux.dev>
References: <20241025221220.2985227-1-rananta@google.com>
 <Zxx_X9-MdmAFzHUO@linux.dev>
 <87ttcztili.wl-maz@kernel.org>
 <Zx0CT1gdSWVyKLuD@linux.dev>
 <CAJHc60wn=vA9j421FhVkMqYc0w8u2ZYuc-9TJ+rvriSXjseKHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60wn=vA9j421FhVkMqYc0w8u2ZYuc-9TJ+rvriSXjseKHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 28, 2024 at 09:43:45AM -0700, Raghavendra Rao Ananta wrote:
> On Sat, Oct 26, 2024 at 7:53 AM Oliver Upton <oliver.upton@linux.dev> wrote:
> > On Sat, Oct 26, 2024 at 08:43:21AM +0100, Marc Zyngier wrote:
> > > I think this would fix the problem you're seeing without changing the
> > > userspace view of an erroneous configuration. It would also pave the
> > > way for the complete removal of the interrupt notification to
> > > userspace, which I claim has no user and is just a shit idea.
> >
> > Yeah, looks like this ought to get it done.
> >
> > Even with a fix for this particular issue I do wonder if we should
> > categorically harden against late initialization failures and un-init
> > the vCPU (or bug VM, where necessary) to avoid dealing with half-baked
> > vCPUs/VMs across our UAPI surfaces.
> >
> > A sane userspace will probably crash when KVM_RUN returns EINVAL anyway.
> 
> Thanks for the suggestion. Sure, I'll take another look at the
> possible things that we can uninitialize and try to re-spin the patch.
> 
> Marc,
> 
> If you feel userspace_irqchip_in_use is not necessary anymore, and as
> a quick fix to this issue, we can get rid of that independent of the
> un-init effort.

It's a good cleanup to begin with, even better that it fixes a genuine
bug.

Raghu, could you please test Marc's diff and send it as a patch (w/
correct attribution) if it works? I'm willing to bet that we have more
init/uninit bugs lurking, so we can still follow up w/ robustness
improvements once we're happy w/ the shape of them.

-- 
Thanks,
Oliver

