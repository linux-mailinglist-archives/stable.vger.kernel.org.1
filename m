Return-Path: <stable+bounces-104022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B89F0B6E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4C71887D86
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A21DE4FF;
	Fri, 13 Dec 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UN6S053N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88F175AB
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090075; cv=none; b=uuDlo3XbDB1ov/HU2lVajXoqHr0piKibMi3wcb9LgjIxs0mX9ZJg/r1+qWQt8LcDnT+98UMp3NbMWHolTpFLYNaOAfpcy91GzEOWJQvdrs7Cvg8OLRNt+XPCmXK//ccdnUw/4bcvsToqhCxioSmfVhG7McGFPc5tr0NqCnxHXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090075; c=relaxed/simple;
	bh=7GZBX68j2IfcqOpZUYGFeFoRISUMcfclRmdMk75E8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrUHQz1y9e1V5x+Hi30I7u+JxE+UyNe6/tm4rpWyPr5f9wujAS4/5rmziv+iaFMhGLWC4meuqHf1pUYa+vCOZD005qvfhQ4Kn3OT1/CGuwn3zuyeEw1+J5p70WjPszatyBj32Vx3IfHIdOaoN+BGvC8Kd//hnJAC371we1hyBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UN6S053N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB476C4CED0;
	Fri, 13 Dec 2024 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734090075;
	bh=7GZBX68j2IfcqOpZUYGFeFoRISUMcfclRmdMk75E8ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UN6S053NceIHgmxSQ5e4lP8jHN92MjDGGevA9iJtZNCcn6wL6P5bBLyRduDqy9nu6
	 Ls+X+dEz/gf+r6rH68xJQ3tpMktD496mWtsHmqSb5IpDJThNLI7VfQ4xP5hDkOYHpi
	 FpWgJ3ZXzx3ahes0DbCi+Lz/9GOjEEgAm4Vq0whg=
Date: Fri, 13 Dec 2024 12:41:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
Message-ID: <2024121346-omission-regulate-89c3@gregkh>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213112926.44468-1-csokas.bence@prolan.hu>

On Fri, Dec 13, 2024 at 12:29:18PM +0100, Csókás, Bence wrote:
> On certain i.MX8 series parts [1], the PPS channel 0
> is routed internally to eDMA, and the external PPS
> pin is available on channel 1. In addition, on
> certain boards, the PPS may be wired on the PCB to
> an EVENTOUTn pin other than 0. On these systems
> it is necessary that the PPS channel be able
> to be configured from the Device Tree.
> 
> [1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/
> 
> Francesco Dolcini (3):
>   dt-bindings: net: fec: add pps channel property
>   net: fec: refactor PPS channel configuration
>   net: fec: make PPS channel configurable
> 
>  Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
>  drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)

This series is really totally confusing.  Here's what it looks like in
my mbox:

   1   C Dec 13 Csókás, Bence   (0.8K) [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
   2   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
   3   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
   4   C Dec 13 Csókás, Bence   (1.4K) ├─>[PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
   5   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.6 resubmit 2/3] net: fec: refactor PPS channel configuration
   6   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.6 resubmit 3/3] net: fec: make PPS channel configurable
   7   C Dec 13 Csókás, Bence   (0.9K) ├─>[PATCH 6.11 v4 0/3] Fix PPS channel routing
   8   C Dec 13 Csókás, Bence   (1.4K) └─>[PATCH 6.6 resubmit 1/3] dt-bindings: net: fec: add pps channel property

I see some 6.11 patches (which make no sense as 6.11 is long
end-of-life), and a "resubmit?" for 6.6, but no explaination as to _why_
this is being resubmitted here, or in the patches themselves.

Two different branches in the same series is also really really hard for
any type of tooling to tease apart, making this a manual effort on our
side if we want to deal with them.

What would you do if you got a series that looked like this and had to
handle it?  Would you do what I'm doing now and ask, "What in the world
is going on?"   :)

Please be kind to those on the other side of your emails, make it
blindingly obvious, as to what they need to do with them, AND make it
simple for them to handle the patches.

Series is now deleted from my review queue, sorry.

greg k-h

