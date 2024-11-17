Return-Path: <stable+bounces-93707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C549D05A3
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6BC1F21B39
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316821DCB0D;
	Sun, 17 Nov 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="21U+wuwF"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D91DB53A;
	Sun, 17 Nov 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873989; cv=none; b=JNxrhK6nHjjRaELmGhhDt4l0obLZNCvcb3pEI1Hn6f+MRRBQyCmgSCUvXsX+BEb6XZlCPc0LJfKgQM18facop/hxGmR2V1dY4n6018ItbnhKOJn6qCwPAci0PF3I80FsT4tgZj5c0COEDNZTByBljkc5RzPpRLvhuw3lsB/BGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873989; c=relaxed/simple;
	bh=5R8x8u4RHqL9R/WudJoPXh5WUVqV0zIebiN38r36Lgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvktKa7XqALxdF9nXuzK2BUX2uGKtW/hmYgq+J6kXsrzAPoRNnyriS4HuQx6q4IwSgeXZqheIqvYOAlLlBk+svSCl/tOQph1sC7hE1minLJRmAyt946d5DbUk/YND/SX5VqRBuBSOSb12Q/QPqCDYSIHjtbiVg5XoB6v2oedKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=21U+wuwF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=n6cxG/zZp641/q+hYZRRTrOQqG5Xgl13FSXhfP9tpHQ=; b=21
	U+wuwFd3743A0QeYMjX6G0RHUhP4f7dA4yY9oNdlOscDp7pYteUrJm4U8xQtm+GpapDJENGzXZE/W
	RfPmCRKX9/+gjOJm9IPDmStpa4eEKp+mM4zvBwtD07kB/kmfYz6+3TEy6Ts8zzFAM3f0Y6XXPldG8
	1zqJkI/wx2p/4m4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tClXD-00DbFs-Lt; Sun, 17 Nov 2024 21:06:15 +0100
Date: Sun, 17 Nov 2024 21:06:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY ID
Message-ID: <90978892-2086-4c70-9698-0957cc71abb8@lunn.ch>
References: <20241004061541.1666280-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CABMQnVK_RUC84QQ5zb+ZpuMOZcFMNV6HzEYAfmX4bOrRm+rvTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABMQnVK_RUC84QQ5zb+ZpuMOZcFMNV6HzEYAfmX4bOrRm+rvTw@mail.gmail.com>

On Sun, Nov 17, 2024 at 05:53:51PM +0900, Nobuhiro Iwamatsu wrote:
> Hi Dinh,
> 
> Please check and apply this patch?
> 
> Thanks,
>   Nobuhiro
> 
> 2024年10月4日(金) 15:16 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
> >
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >
> > On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
> > found and the network device does not work.
> >
> > ```
> > stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > ```
> >
> > To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of the
> > mdio bus. Also the PHY ID connected to this board is 4. Therefore, change
> > to 4.

It is the address which is 4, not the ID.

	Andrew

