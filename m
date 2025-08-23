Return-Path: <stable+bounces-172582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6EB32884
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA15A7A67C1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2523C2594AA;
	Sat, 23 Aug 2025 12:24:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72C242D8D;
	Sat, 23 Aug 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951894; cv=none; b=O9IkNI6Z6PTStsbH+P3n/IrG09SWVJ0I+qEkp5PTCDVbSwO6qBqloe0Pzf3E58buOCHt/4iFuoIxOG2qOIHWeOXSxg4joIfEghuSoP0XpHR1YYQYDJPbtJSMDXK8GMT4kyjXSFU6t/jqfGC1A4MenISkZXcnYXxH8ymNtkvjN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951894; c=relaxed/simple;
	bh=c7VGgCZa6f+HzVnoJzeCjnygZt875/U69l5XA+/hQEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME62g+HtBaep0bWZacx6hps0Qy9LWRjdBpmPGJXSDTiHFhkcm7vQmUcrvZ+IVJRtq+yO3ZwBnqGlGstaUy3cenXO0jBT2grcA2+WZa3F9QC0uXU/+z0/VYNWuR0TncODOx15BE8WKAvXHxwWvBXoGuhbCwooqufutDKdF2hODCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Sat, 23 Aug 2025 14:24:39 +0200
From: Brett Sheffield <brett@librecast.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	oscmaes92@gmail.com
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <aKmzB57MKbpXh-_Z@karahi.gladserv.com>
References: <20250822165231.4353-4-bacs@librecast.net>
 <20250822183250.2a9cb92c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822183250.2a9cb92c@kernel.org>

On 2025-08-22 18:32, Jakub Kicinski wrote:
> Thanks for bisecting and fixing!
> 
> > The broadcast_pmtu.sh selftest provided with the original patch still
> > passes with this patch applied.
> 
> Hm, yes, AFACT we're losing PMTU discovery but perhaps original commit
> wasn't concerned with that. Hopefully Oscar can comment.

Indeed. This takes it back to the previous behaviour.

> On Fri, 22 Aug 2025 16:50:51 +0000 Brett A C Sheffield wrote:
> > +		if (type == RTN_BROADCAST) {
> > +			/* ensure MTU value for broadcast routes is retained */
> > +			ip_dst_init_metrics(&rth->dst, res->fi->fib_metrics);
> 
> You need to check if res->fi is actually set before using it

Ah, yes.  Fixed.

> Could you add a selftest / test case for the scenario we broke?
> selftests can be in C / bash / Python. If bash hopefully socat
> can be used to repro, cause it looks like wakeonlan is not very
> widely packaged.

Self-test added using socat as requested. If you want this wrapped in namespaces
etc. let me know. I started doing that, but decided a simpler test without
requiring root was better and cleaner.

Thanks for the review Jakub.  v2 patches sent.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

