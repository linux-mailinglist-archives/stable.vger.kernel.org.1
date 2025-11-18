Return-Path: <stable+bounces-195120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD1C6AB91
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17DA73A7BD4
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3E3A79B5;
	Tue, 18 Nov 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f9vwQNyQ"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84F393DD1;
	Tue, 18 Nov 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483556; cv=none; b=I1socQx1eBUj2C6SVh5psSsPQTZNQH1e6mqbIZr81i7UM9TOz9KqbOhIaOPNW5amPlHQkTInfBSzJygPMovhBNVOaQ6KUfprzQDnIx1zg2LkMB+Gh1/sSUCk6jh1A1CS8mG92Dbt+6ycRF8SPmastsPNLhGTuXrcR7wGAr67MDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483556; c=relaxed/simple;
	bh=vFo7r0XdnaRLl/OJtbQ6R9qQ2Bv/a+jVHUjiqFqRBqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA+4e2obWOJEZiGZ8qfHKmmfe4Dp9rWNmqTY5pNbBO0L9SJ5w+29jsha9ygiUDDRYCk3q4U0m2a2GDkjUVI+mSgu7Rl30pdbI7pHajo8+naGHZh2FZXP34CfUTeU07tYRDipQ+J05vRG3CF0MQZITGPboWK0CY/6KOb+lAkaIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f9vwQNyQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nyu4wcuTtWYOJHnjMQ7lXCj5/noswXstfWWmMH5QKEc=; b=f9vwQNyQfdoMJNE4azz4WFej8L
	RvgrgB13p9zf4FQQqqHsORjKjsTc9oE+Og77RCz2uwiMfdFlWma43ODCDQ7Q9OCPBQb7q56QHYZgP
	TFESffn6pZpMmp2tDOJF9Ag4q8HeU6wwa47l4vCJYeYrkC4Rg1AH4yBMQjwQyx1AoGgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLOcr-00ENEA-RC; Tue, 18 Nov 2025 17:32:17 +0100
Date: Tue, 18 Nov 2025 17:32:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v5 5/5] net: dsa: microchip: Fix symetry in
 ksz_ptp_msg_irq_{setup/free}()
Message-ID: <d87f3e67-fc99-4076-8e9e-0a20ce387f1b@lunn.ch>
References: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
 <20251118-ksz-fix-v5-5-8e9c7f56618d@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118-ksz-fix-v5-5-8e9c7f56618d@bootlin.com>

On Tue, Nov 18, 2025 at 05:13:26PM +0100, Bastien Curutchet (Schneider Electric) wrote:
> The IRQ numbers created through irq_create_mapping() are only assigned
> to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
> between their creation and their assignment (for instance during the
> request_threaded_irq() step), we enter the error path and fail to
> release the newly created virtual IRQs because they aren't yet assigned
> to ptpmsg_irq[n].num.
> 
> Move the mapping creation to ksz_ptp_msg_irq_setup() to ensure symetry
> with what's released by ksz_ptp_msg_irq_free().
> In the error path, move the irq_dispose_mapping to the out_ptp_msg label
> so it will be called only on created IRQs.
> 
> Cc: stable@vger.kernel.org
> Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

