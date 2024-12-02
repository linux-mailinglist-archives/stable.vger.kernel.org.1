Return-Path: <stable+bounces-95954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ABE9DFDD0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C5163229
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0101FBC8B;
	Mon,  2 Dec 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZXLZOVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84B1F949;
	Mon,  2 Dec 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133167; cv=none; b=Qz8oGSDFnmtbxuNJnhGLL3dA2CyXoniuAja7fhM68QtLbQHUk26ELe/e1ndyaQaRtpmrQF02Yl/XkNexFeruoZxCvrhsjT/uiE+KlfMBHZPN/QZdTqgdfcVYD8hgqIOfNYnzJW27wwVkHGFmxiSTYzar0h1Yyq64QVhbDmjmMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133167; c=relaxed/simple;
	bh=JAI2xqnP4FAe3gEaZyTgNl5jMmsLkg7O96Ry7GlofNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDbgLtPT0Z/wqyXap+xUPTmltklSeFbizJ7mySlB/n+pIzXmahBo6XwqEAmjSj8ucDkoCXUJPonftRKNGDsMXd9frzVXiCTwvJwEnB9cbaGs6wXdnr/edX7HS0gMrIY7QAVt/mQOAIN1t/G0r6TPxUV0JNR+iJl1EOsMg0yeqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZXLZOVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAFEC4CED2;
	Mon,  2 Dec 2024 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733133166;
	bh=JAI2xqnP4FAe3gEaZyTgNl5jMmsLkg7O96Ry7GlofNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZXLZOVxuZN6ps5kQDNriwjPf1NjdrEgv1BiSKzIezEcAneOCmRZDscBrmcSNDUdD
	 /qWR/1+s61FzUz/ohMveaN24agvrDozfSwETqfk0Pzgg6Tr1zswwoE/6fM34UqPJk/
	 LG/dl/M14rPY72sSRBNPEwvd70HUzxDOerogpgfw=
Date: Mon, 2 Dec 2024 10:52:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 6.6 0/3] Fix PPS channel routing
Message-ID: <2024120204-footer-riverbed-0daa@gregkh>
References: <20241125091639.2729916-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125091639.2729916-1-csokas.bence@prolan.hu>

On Mon, Nov 25, 2024 at 10:16:36AM +0100, Csókás, Bence wrote:
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

We can't take patches only for older stable kernels, and not newer ones
for obvious reasons (i.e. you will upgrade and have a regression.)  So
please provide backports for all active kernels and we will be glad to
review them then.

thanks,

greg k-h


