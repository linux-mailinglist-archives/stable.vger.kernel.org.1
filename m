Return-Path: <stable+bounces-37983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B304A89FAC4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A71C1F311F4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F1172BBA;
	Wed, 10 Apr 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJjOxpNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EC16D9D0;
	Wed, 10 Apr 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760918; cv=none; b=lgh1s7itqOMYwF8ibt59TyEyfX4HOMDxZVVBRP3t11rAWHr1a8QKH/+Qq4o3Tq13vQAPkBhzBuLrM6e1R+PhDDO5HAGSCEyNdr4jOcJWKhrs8ysB+6yP+1lmwl3MFBy5dxrt6GrTcE1oCALNkje1iAGL+crMg4CseqgFTux1QIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760918; c=relaxed/simple;
	bh=2DXWRdM4JWN1yquezudUA2x+3OsG7lc1uBx3OGxBfiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KraL9PAEng0fmTkRQgKHL/ZFapFkre0HBls3MG5vlGPhniDjozRyEXhE0tffEXvVLqvj+ltSA7tsH1sd96aMAmzEGKehU46zM3idCyPVkJAx4yJaJN6VCow9mrKpeVsRPOS4qQ7ZnFL+hWsZbdR9q4eYuvz3THm3DyRykvqpYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJjOxpNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89B1C433F1;
	Wed, 10 Apr 2024 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712760918;
	bh=2DXWRdM4JWN1yquezudUA2x+3OsG7lc1uBx3OGxBfiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJjOxpNdU/V9lCLjYi/bMtnmMMg4VywlzrHK8TPgtQkzruD33U9ckrWSA+EwWrtuw
	 +VZS2YnfNYKDYLAim0grruqn8r2vWLb0c2c2WxXGVFvojJ6XN9h3c4YsVJdj1//uvi
	 qPBULd2OqeGF35vR8gV4l3Sooh87+mNlhDS8fCUQ=
Date: Wed, 10 Apr 2024 16:55:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, xu <xu.xin.sc@gmail.com>,
	stable@vger.kernel.org, vladimir.oltean@nxp.com,
	LinoSanfilippo@gmx.de, andrew@lunn.ch, daniel.klauer@gin.de,
	davem@davemloft.net, f.fainelli@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, rafael.richter@gin.de,
	vivien.didelot@gmail.com, xu.xin16@zte.com.cn
Subject: Re: Some questions Re: [PATCH net] net: dsa: fix panic when DSA
 master device unbinds on shutdown
Message-ID: <2024041011-kindness-clumsy-3f7b@gregkh>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
 <20240410090644.130032-1-xu.xin16@zte.com.cn>
 <09f0fc793f5fe808341e034dadc958dbfe21be8c.camel@redhat.com>
 <20240410143419.ptupie3hyivjuzqf@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410143419.ptupie3hyivjuzqf@skbuf>

On Wed, Apr 10, 2024 at 05:34:19PM +0300, Vladimir Oltean wrote:
> On Wed, Apr 10, 2024 at 11:14:09AM +0200, Paolo Abeni wrote:
> > On Wed, 2024-04-10 at 09:06 +0000, xu wrote:
> > > Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 stable branch.
> > 
> > Because it lacked the CC: stable tag?
> > 
> > You can still ask (or do) an explicit backport, please have a look at:
> > 
> > Documentation/process/stable-kernel-rules.rst
> > 
> > Cheers,
> > 
> > Paolo
> > 
> 
> My email records say that it was backported to 5.16:
> https://lore.kernel.org/lkml/20220214092515.419944498@linuxfoundation.org/
> On 5.15 I have no idea why not (no email).
> 
> Anyway, on linux-5.15.y, "git cherry-pick -xs ee534378f00561207656663d93907583958339ae"
> does apply (it says "auto-merging"), so maybe Greg can just pick up the fix with one command?
> 

Now queued up, thanks.

greg k-h

