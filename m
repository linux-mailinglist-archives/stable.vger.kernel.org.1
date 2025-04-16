Return-Path: <stable+bounces-132824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBAA8AEC6
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 05:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2E443661
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0A22A1D1;
	Wed, 16 Apr 2025 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxtXUTiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2852227EB2;
	Wed, 16 Apr 2025 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775811; cv=none; b=Spzwv3o7K53BLTwHXRWG7FXcuGABVOrLVPIZCQVMwDUJKT83TAebz3KIDTpVsa5Cf0cdjYPfTuZsC8SRlRFoAOuM5A2BQuK2rqLoJK1NB1obuDPXn09+f47ySch2lR/Ga6vbC/UrR6roAnl33BC58T5adriXeZLLzZ46FHWcSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775811; c=relaxed/simple;
	bh=srYclNAF6hwGXM90kzTLH+JNUxLwQVKujXYqQkal3Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtPjunLx9D6ysvXF1LsgYLCIHh6/YVAxCBbN5qgO7kky+kguKPJ4MjN0Ls7Siv3DGPQIxlRjbwntP5cIcn2BI4LX70p51DIBKCzhwHBTsEjuP9F7h04RM5Fu2IdM0eInBGHxsbgJ6hOQfEEFRQp5qegHLnoRXc7l0Y1gpOpVoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxtXUTiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7199C4CEE2;
	Wed, 16 Apr 2025 03:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744775810;
	bh=srYclNAF6hwGXM90kzTLH+JNUxLwQVKujXYqQkal3Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jxtXUTiEjkmm9XCs6bB73TMkMX6Q59nAHZdi2EqXeAKDvADK/395w8sM8BEhDj77F
	 mhZHU2Ncp4Xo8BKwnmjiAWAMJnBXigVNFStxY7EJOINx030L+K7aCRyqrcbAMCOHoG
	 vc62WRUD8Fp12X1F4J5u+Ffyo57F69ZYyC4AHTPtP4qIjnH1IODA/xuK4bYoxIZ13K
	 t7VgOBrUhm0WgAdl623qWo1FQhesf2c4vLx0l/0Dyecnj3oDhJvP5xyWS5X5LZVt2c
	 YrRezHfNjhRqHOhdn4or1UkyG+EIZmPgyoXlpDcQmEBsOkbJYIomb0h4XnQlF9GUM3
	 uTiYBViafUJhg==
Date: Tue, 15 Apr 2025 20:56:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Qasim Ijaz <qasdev00@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <20250415205648.4aa937c9@kernel.org>
In-Reply-To: <20250415205230.01f56679@kernel.org>
References: <20250412183829.41342-1-qasdev00@gmail.com>
	<20250412183829.41342-6-qasdev00@gmail.com>
	<b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
	<20250415205230.01f56679@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 20:52:30 -0700 Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 03:35:07 +0200 Andrew Lunn wrote:
> > > @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
> > >  		   __func__, phy_id, loc);
> > >  
> > >  	if (phy_id != 0)
> > > -		return -ENODEV;
> > > +		return 0;    
> > 
> > An actually MDIO bus would return 0xffff is asked to read from a PHY
> > which is not on the bus. But i've no idea how the ancient mii code
> > handles this.
> > 
> > If this code every gets updated to using phylib, many of the changes
> > you are making will need reverting because phylib actually wants to
> > see the errors. So i'm somewhat reluctant to make changes like this.  
> 
> Right.
> 
> I mean most of the patches seem to be adding error checking, unlike
> this one, but since Qasim doesn't have access to this HW they are
> more likely to break stuff than fix. I'm going to apply the first
> patch, Qasim if you'd like to clean up the rest I think it should
> be done separately without the Fixes tags, if at all.

Ah, no, patch 1 also does return 0. Hm. Maybe let's propagate the real
error to silence the syzbot error and if someone with access to the HW
comes along they can try to move this driver to more modern infra?

