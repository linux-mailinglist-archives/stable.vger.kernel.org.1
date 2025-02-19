Return-Path: <stable+bounces-118336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C0A3CA46
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 21:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529373A53EA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8323C8B2;
	Wed, 19 Feb 2025 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r1dP4bEL"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC721516A;
	Wed, 19 Feb 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997757; cv=none; b=NMCLAMIVfqahzK4CYVCVb2US3CC5ry/TrD15V3ahf5z9nDzw72bdFloHAl5WzyL6W91SPu66xJESgNMQLCNZgMK2N+uVY91sKeCOPepjUoZwILkCinErwt0BFKMj+lQmVgjMTPT1rk+lIg9jMkxNo26zYk6oOuYWqaak7ipEi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997757; c=relaxed/simple;
	bh=rIHiiJyUz1iYyZLTnyvClQJ1jWf6pFqwKsA46EDaHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSQveJ7w76WqOB4EKVU/XoAb8eBwmvY6qdeIfAtKm9Tw+TdAV2F90RfritT+qu8gDqRW2xdEND+yDfOxFoNnFCz1fqkG/7ct8p7aKCy9qX9P0q6v8dTk73hvP0RYjcAm2zInXB8bdgp7bGSJg+/7OQsz0LQljIXyd4DVDTs04Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r1dP4bEL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ftta+Mc6Pupl8QpbRC1xuQpxe/1w+NCOFRaih1qjFU=; b=r1dP4bELxRpeutIC2q7wzdmcoz
	WuiY3I2nM7HWAI1GGTjw4MIZpF/EzadWSU6ejzGohQrmJ6HKQk7V5+AoZGcZf4BtulwWGWoMo4Vwy
	7WKSayVvn5cMmWqYQtCCThBl7p/q4/3Ygr2Gi4ft1zk+sdXz22vLAAjRs8X22IYm6wjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkqti-00Fk50-3i; Wed, 19 Feb 2025 21:42:22 +0100
Date: Wed, 19 Feb 2025 21:42:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com, michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 net 8/9] net: enetc: correct the EMDIO base offset for
 ENETC v4
Message-ID: <abe49f9e-a1c4-424a-a96f-0793c0fab57f@lunn.ch>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-9-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-9-wei.fang@nxp.com>

On Wed, Feb 19, 2025 at 01:42:46PM +0800, Wei Fang wrote:
> In addition to centrally managing external PHYs through EMIDO device,
> each ENETC has a set of EMDIO registers to access and manage its own
> external PHY. When adding i.MX95 ENETC support, the EMDIO base offset
> was forgot to be updated, which will result in ENETC being unable to
> manage its external PHY through its own EMDIO registers.

So this never worked?

If it never worked, does it actually bother anybody?

Stable rules say:

  It must either fix a real bug that bothers people or just add a device ID.

	Andrew

