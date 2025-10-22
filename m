Return-Path: <stable+bounces-188944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03925BFB1E1
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C083AFCDC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D9313539;
	Wed, 22 Oct 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTSMm5h3"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBC26CE2D
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124575; cv=none; b=ZGXb5v/eqlQYFSa5q9o6sDWGdrRpV1zPUeIyrmdwgBZARWDQw3S1cAYXgVnb8l2yy+F2Wh0gQsXynTsqCDerWzW4PlPRDmbYV0HKuS46kcm1FQL6EfhEEal7S8YPpReeXqKFKZxe0yrss2rK9UCDxkGga4FfwpbzsZpytXPM5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124575; c=relaxed/simple;
	bh=lvFw5Nk+qH+yvB6NQFEi2D6wt9AdFQ4KBlgZ5RunyW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enJM7UkFLhGaf9TF2HMSvhj3DSp9CPyt1RlGQ/oNF/JCFFFV9C6csPGbnohRw0ptz+TCZtikpZ8on/8DhGojbcLa1phdoIqiHXjakp4CHT9tnHD6IIFGjyX2ugs714rSgAYpUTgFC6REA/YMHgsS7K5OkrnEPVA5D2W3FAfV4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTSMm5h3; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 22 Oct 2025 02:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761124569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCr2v8NiGCG3OxJPegbScRx7+QI9iQUtCm6vrXFxJv4=;
	b=UTSMm5h37kNKIcefL/GrgyqwwYY3qvZFp+9X/VsGTruaCqg1eKxjKIv1AUpmp/5dxC40SF
	PFf785to9H+mNsOrT8zN4vvS3BxHkioHnMjTjKhhPMnRE+01kaTRMjqgB8MzKcEfODNHBd
	1s55RS46i/dDUc/1uLEoelkF9+E7baY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.12 006/136] KVM: arm64: Prevent access to vCPU events
 before init
Message-ID: <aPigtSKzinCqc8R6@linux.dev>
References: <20251021195035.953989698@linuxfoundation.org>
 <20251021195036.111716876@linuxfoundation.org>
 <aPiVtgLCCbQ9igWp@linux.dev>
 <2025102247-delighted-cycling-61c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102247-delighted-cycling-61c4@gregkh>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 22, 2025 at 11:03:28AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 22, 2025 at 01:28:38AM -0700, Oliver Upton wrote:
> > Hey,
> > 
> > Can you please drop this patch from all but 6.17?
> > 
> > On Tue, Oct 21, 2025 at 09:49:54PM +0200, Greg Kroah-Hartman wrote:
> > 
> > [...]
> > 
> > > Cc: stable@vger.kernel.org # 6.17
> > 
> > FWIW, I called this out here.
> > 
> > Thanks,
> > Oliver
> > 
> > > Fixes: b7b27facc7b5 ("arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS")
> 
> Ok, but note that this Fixes: tag references a much much older kernel
> release, hence my confusion as to where this should be backported to :)

Yeah, this is a bit confusing. The blame is correct, 6.17 added some
(correct) fireworks to the situation.

> I'll go drop it from older queues now, thanks.

Appreciated!

-- 
Oliver

