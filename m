Return-Path: <stable+bounces-124744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B979A660E2
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241FA3A8CE0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838C204590;
	Mon, 17 Mar 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cfY89N/s"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E21F790C;
	Mon, 17 Mar 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247883; cv=none; b=A/7XcqzPdtdhppO5fLlgCd3PVJ3AtSbei5uXCxBHw5CzFWvFlVDfjo1z+L1pR2bTGJxrO5WxUBNd3tVakw+SdxsNBtiUOWTFB/CDiUl5lhH20a5zGVjkN5N9NQIfUAdR8AOSS+eh3OhV1dI/xScrpoueG3nc0S7ds2yI3LWCAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247883; c=relaxed/simple;
	bh=ta9lIfz+bunOKeBRxphlF0bBBYX2Jm4BR08z+j4xxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khn3IxiiNAruhJBFdFZWL8NetNH3wpnZmhtImHlH+SdKLcXxCDO1fcFaVenw2AZY2EDjVoA/LUInl7fNQ+hmBr5nfq0E6fP25iAB4jYvQmcb+PRcQHv4Oojs2Xoxoi67+51YMz4HP6ZGJpocqsCRvb0M5YHpMgYiW7Mzg15MWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cfY89N/s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=UA1PK+I0yk37nAoKEeuqeq7B5dN0jlxZ7pzrkbomFdE=; b=cf
	Y89N/sq+/mryqS6BH9IqlwrCEYHwCMWijZTKPgdFMjtI5+sYNzLNYquHzkaKn2aWrkyyeIcAfQyGK
	dvHsYZsSCThAATcc/VpdbqoI2dG6yXSRrHvWagvUsk2asz4zlxpaF5uzvSvfbcTL230yCeCqFtt2X
	6CZ1VX6MsQoiXN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIGD-006BXg-Ch; Mon, 17 Mar 2025 22:44:37 +0100
Date: Mon, 17 Mar 2025 22:44:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 6/7] net: dsa: mv88e6xxx: fix internal PHYs for
 6320 family
Message-ID: <e4aa56ac-5a62-4754-8feb-6c1c5e81a1ab@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-7-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:49PM +0100, Marek Behún wrote:
> Fix internal PHYs definition for the 6320 family, which has only 2
> internal PHYs (on ports 3 and 4).
> 
> Fixes: bc3931557d1d ("net: dsa: mv88e6xxx: Add number of internal PHYs")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.6.x

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

