Return-Path: <stable+bounces-124745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19EA660E6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C9817A92A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CFD1FFC44;
	Mon, 17 Mar 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lRNBuS8f"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BB1AA1E0;
	Mon, 17 Mar 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247928; cv=none; b=c1b3aIctbLcLjmkQB0irNJVsneShbVIf78akMe+1Wpl4CrnM+7QP4Isz4XD0KSyyqBBU18fYR7lZmJPPW9XYZ/T5dV0Sxbfn5nACXKwLYNCIYLLMUNNYvfpLjlLAAry0ygKelj5bTg5ZJpFl1T26osyzOT2eH400/kOc5eYS+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247928; c=relaxed/simple;
	bh=tpsNpdXEKf/jfB7M7l2LCZkOZT7KSHSdNZGHnKbYjAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wci32AQ4K7/71ONQHX0PpjK69Kc7vehbso1MM6bEeRLF243MO5aulzqZS36NrcshszsiOAGtfKAwoNoXNN8sQdpfOIESYtyl830SV304Iw5906Dk6GVST9GlcBnUov/SoxeJu8+nH0CfvJN57Diy3V1hPP0GgPr5ByYJ9dNGwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lRNBuS8f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cimavf3sMRsYWDFKe3ZJqoyZgwa++PoNxw8BG9zOMVg=; b=lR
	NBuS8fdNObpHVWNU0CSvAq+QTCguS8lfm33fQFPwF/Bb3F6xGKWCyOnIJxMepH1dijNwzDnlWImd4
	c0FcX9hZEVr69KloCzXh64UUoBlGX0V3ELmPS5fl68jzfFR/n1c9E0OgHZuHK0cMMdRJ4a24ox52k
	XRtrDJwD6/cfSsU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIGw-006BYL-Gm; Mon, 17 Mar 2025 22:45:22 +0100
Date: Mon, 17 Mar 2025 22:45:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 7/7] net: dsa: mv88e6xxx: workaround RGMII
 transmit delay erratum for 6320 family
Message-ID: <d4b45e70-261e-43ff-9ceb-6e2a517f77e2@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-8-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-8-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:50PM +0100, Marek Behún wrote:
> Implement the workaround for erratum
>   3.3 RGMII timing may be out of spec when transmit delay is enabled
> for the 6320 family, which says:
> 
>   When transmit delay is enabled via Port register 1 bit 14 = 1, duty
>   cycle may be out of spec. Under very rare conditions this may cause
>   the attached device receive CRC errors.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.4.x

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

