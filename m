Return-Path: <stable+bounces-109493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B51A162D4
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCA31649F3
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75C1DF745;
	Sun, 19 Jan 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aHA1jJ79"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658AC2ED;
	Sun, 19 Jan 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737302765; cv=none; b=RoIKEfyELjMWzPG2E2IcUcvNaJal92tGFZd52nA3fJmjUk6X0GZI9STCr9JIgJnIy9OyeEG9GVqlk+eXLClmnvKX4LsIonxB6N/5i9OSrR9M4V4ItWT9/fnLPlGodFehfM4r/6nEa/FmREhz4baP7yh4v7pacbGvsOvTJRfYYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737302765; c=relaxed/simple;
	bh=z4N+A58lblOVQ4yOqbmrYwW0T/rTLlH9V0lt/vjsuo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dORq28g6QVwrme9yhFI82gAUqV0Yj4do3SLDNHqmaN7kjJae5/SPYdG97xmdAUV+66ObSOw8mo1f9zFPi93NQs/gLMxwNHZWShY1ProVZ7BOgog7sjzWJGc56C/K0R8K5C6JLwtfg+wRgW6TMO9ktUI3uUMbm3XDLImTZQSFelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aHA1jJ79; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Giu0ODHWMA2AFv3pUJiCKz05nk6XvcYFDXOiLwnTS5c=; b=aHA1jJ79Gvxky/aJD5M67levLe
	KTFNETW0FC/OOT2v8vBo5FYAWHuNQioxqs/cu2rnNU9uB4wSGHNOECYudX0uXqqeNIzbjX3dyQ8zM
	CXz8xt3tiE/VYj00PFHPqL1Oueb0KBCj+IC47TqwRVI2maMHesT+ZGv7FdwI6pDzSXrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZXo6-006547-1U; Sun, 19 Jan 2025 17:05:50 +0100
Date: Sun, 19 Jan 2025 17:05:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id
 for orangepi r1 plus lts
Message-ID: <5ce312f4-f496-4a62-bcda-5e6fbefde376@lunn.ch>
References: <20250119091154.1110762-1-cnsztl@gmail.com>
 <ce15f141688c4c537ac3307b6fbed283@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce15f141688c4c537ac3307b6fbed283@manjaro.org>

> >  &gmac2io {
> >  	phy-handle = <&yt8531c>;
> > -	tx_delay = <0x19>;
> > -	rx_delay = <0x05>;
> > +	phy-mode = "rgmii-id";
> 
> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" parameters,
> respectively, so the Motorcomm PHY driver can pick them up and
> actually configure the internal PHY delays?

Maybe.

One problem is that tx_delay and rx_delay are really bad DT
bindings. They are basically values to be poked into a registers, with
no explanation of what they mean. Maybe 0x19 means 2ns? If so, that is
exactly what the PHY will do with rgmii-id, and you don't need any
additional properties.

The fact testing suggests this works does suggest these delay values
are around 2ns, so there is probably no need for
{rt}x-internal-delay-ps.

In general, i always suggest the PHY does the delay, just so that we
try to make all boards act in the same way. The fact this also removes
the use of these terrible tx_delay and rx_delay makes this patch even
better, if it can be shown to be reliable.

	Andrew


