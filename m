Return-Path: <stable+bounces-76108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B99788F4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 21:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2871C21D85
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738791474A5;
	Fri, 13 Sep 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3s/5Lffk"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483212C526;
	Fri, 13 Sep 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255667; cv=none; b=iIKC8oV1BL2eJe2er4cLrlGC+YvmnYRUPoAuV8qonwUIggd2ZOUcGjne3my5wyDSC2ZoTsqb5idKfpwG+DC4Urpcb3PxjohVEvKKWIMQqy5r3MFzuvP0zTQ1QGABiF47q4B6TZNTdrXEcTXWf8u6d8phQDx5iRZbSue7k59dh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255667; c=relaxed/simple;
	bh=Uzy0WKo0zVSTsnIqoRl2P0vXxeopPBlGtqFbKaNB4x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsPRSfq06ABSxdwLqom9E0lhmG8gMnaSWvJ2oj4KcCLnouI6JlhAagZN0ZQrEqDSeootPs7FfEZLbVk/oh6QYjPYlWCvdnxVirem1R3K2F/1Y1LujwCQtlO7DDVLUmztqCuAVeB8Vv4SYNnmkG1LQEAE7S3mMxvkvpYRWgnKLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3s/5Lffk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V/fJdEFiVV1xIWs3tBqysiFVv3X6oa6gDDk7YeJVw8s=; b=3s/5LffkanL6JgKJdCkpMVN4mA
	gvWbJIwLXl8SJgWI2e05xTlPRuVo02f26hMdxNDCq1K/0UM+dKCgrnRS5RSztGn0G7endKpcSNkVK
	CWv9lipO+ZXgG68QJje6llHwbX++Tsc8PqQgyr3rll+5m1jDJwpxUCuWUvea+uKXgiSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spBwx-007Q0o-Hv; Fri, 13 Sep 2024 21:27:23 +0200
Date: Fri, 13 Sep 2024 21:27:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org,
	=?iso-8859-1?Q?Ar1n=E7_=DCNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-mediatek@lists.infradead.org, bridge@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Message-ID: <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
 <20240913190326.xv5qkxt7b3sjuroz@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913190326.xv5qkxt7b3sjuroz@skbuf>

> >  drivers/net/dsa/mt7530.c                    |   3 +-
> >  drivers/net/dsa/ocelot/felix.c              |   3 +-
> >  drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
> >  drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
> >  drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
> >  drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
> >  include/linux/netdevice.h                   |   2 +-
> >  include/net/dsa.h                           |  36 +++++--
> >  include/net/dsa_stubs.h                     |   6 +-
> >  net/bridge/br_input.c                       |   2 +-
> >  net/core/dev.c                              |   3 +-
> >  net/core/flow_dissector.c                   |  19 ++--
> >  net/dsa/conduit.c                           |  66 ++++++++-----
> >  net/dsa/dsa.c                               |  19 ++--
> >  net/dsa/port.c                              |   3 +-
> >  net/dsa/tag.c                               |   3 +-
> >  net/dsa/tag.h                               |  19 ++--
> >  net/dsa/tag_8021q.c                         |  10 +-
> >  net/dsa/tag_brcm.c                          |   2 +-
> >  net/dsa/tag_dsa.c                           |   8 +-
> >  net/dsa/tag_qca.c                           |  10 +-
> >  net/dsa/tag_sja1105.c                       |  22 +++--
> >  net/dsa/user.c                              | 104 +++++++++++---------
> >  net/ethernet/eth.c                          |   2 +-
> >  25 files changed, 240 insertions(+), 152 deletions(-)
> 
> Thank you for the patch, and I would like you to not give up on it, even
> if we will go for a different bug fix for 'stable'.
> 
> It's just that it makes me a bit uneasy to have this as the bug fix.

+1

We should try for a minimal fix for stable, and keep this for
net-next, given its size.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

* It must be obviously correct and tested.
* It cannot be bigger than 100 lines, with context.

	Andrew

