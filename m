Return-Path: <stable+bounces-41625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2188B55E9
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3813F285C62
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF23A8FF;
	Mon, 29 Apr 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZinP82u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE513A28E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388359; cv=none; b=tN4E5ofPOObodburQrZUda10R3BoznM+d+87fKLEK75rWQ/GGtawUxBKMR+F5ho1qz1T/bitgTjj824KengqnDXepVHyus7ix8Z2sC1hm8Ob9BWjqoKEjPFu1ZwfJtSx+Glk24tb4EIZDeNWaKN36EYo8TinpSiRuLJ0yB7IERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388359; c=relaxed/simple;
	bh=fpegKsluG3NaYfdhInhesD6K+QSWQNNMwXh/8jDbNiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUIPZZxz882JdBFT1Dt57ASAFQizaPnKp+ghv+oGct6IoWQEaTtuep/e9ogBzeLWfgWlaHtF2Lj1Jjp+MdFNEnL8NXNdkEmSHit+t9zBWIL7wnhoQaqOgWnUx7RVe+1eufGgwVaDnZIJDolm2XvJqbNeD0Rvzr9GEFnS+yLOZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZinP82u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2225C113CD;
	Mon, 29 Apr 2024 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714388359;
	bh=fpegKsluG3NaYfdhInhesD6K+QSWQNNMwXh/8jDbNiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZinP82uh50iFZL1TXxB1uvJ2FTfV+wX+NXdeiycNXq6AHqa3+wJ0zSa8+Mn/7Vnj
	 5e3PVLZts5WOJpiyh/We4LMcsL4aWk5E3M3hOvj/DFOtyXa9WjTQTmg54qEzAIdd9G
	 ZN36venGxJ6+o5rVPw1vs3kGzZj2t1lbsdF9fAh8=
Date: Mon, 29 Apr 2024 12:59:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geliang Tang <geliang@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [6.6.y] "selftests/bpf: Add netkit to tc_redirect selftest"
 needs to be reverted
Message-ID: <2024042959-steering-periscope-a87b@gregkh>
References: <ea05dcf2a0417aa2068a4dfa61bd562a6e8127d6.camel@kernel.org>
 <2024042610-tiring-overdue-a6b5@gregkh>
 <e890da3e6b47059a496f743623800223282d7984.camel@kernel.org>
 <2024042648-dweeb-serotonin-f76f@gregkh>
 <0d29b3a324d851402f247a33ef89efe6103e90da.camel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d29b3a324d851402f247a33ef89efe6103e90da.camel@kernel.org>

On Fri, Apr 26, 2024 at 06:22:53PM +0800, Geliang Tang wrote:
> On Fri, 2024-04-26 at 12:21 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 26, 2024 at 06:12:22PM +0800, Geliang Tang wrote:
> > > cc stable@vger.kernel.org
> > 
> > I'm confused, where is the original message here?  You just forwarded
> > my
> > bot response to the list.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> I'm writing to inform you that the commit adfeae2d243d ("selftests/bpf:
> Add netkit to tc_redirect selftest") on linux-stable should be reverted
> from linux-6.6.y. It depends on bpf netkit series [1] which isn't on
> linux-6.6.y branch yet. Otherwise, a bpf selftests building error
> "netlink_helpers.h: No such file or directory" occurs.
> 
> [1]
> https://lore.kernel.org/all/20231024214904.29825-1-daniel@iogearbox.net/

It does not revert cleanly, so can you provide a working revert for us
to queue up?

thanks,

greg k-h

