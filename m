Return-Path: <stable+bounces-76125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65F978E20
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E8287E99
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A444376;
	Sat, 14 Sep 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oiKgM+gD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTvhx3KG"
X-Original-To: stable@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42E175BF;
	Sat, 14 Sep 2024 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293419; cv=none; b=iybXmU6Iz9MmiLDTfK/oKRpbSbA/50x2c8e0aB+pHJ9VLxXn1jNeErtER7IpoBLMyjL5jw2NgYwYPaJDxibx/wrJ5FiH6Palrnt5icpb0J7S47EQMkwO7P31gfC6lcAHPoHVUq25PMpUCpEiMFJ+2cDWrR0lQNveGuad8lN+Fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293419; c=relaxed/simple;
	bh=MyCryc9nsFpXYN6b1j3UQJHUPrg2LOTyuy5q5J1ZkLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK6HbA9BRoGpcerS5F3vw8vdUhM8WqZLVdopOR0jD7pEjJiemGXfTAxJ809Ur2BUwgZWALBkCcFnJ581UFDGO5B+1Rlc0SZTbwKK+X5+boloWNcP54pscc3qpEw4rVV9ecVDpXfEuMwkgaaAv7WTUxmKQbIdirKA44i7/AQofMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oiKgM+gD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTvhx3KG; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 946DF2000B1;
	Sat, 14 Sep 2024 01:56:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 14 Sep 2024 01:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726293416; x=1726300616; bh=r1M7ruRNRU
	YjRohbwuaCuLvbF8h8qL/m91LCjTsa0pY=; b=oiKgM+gD3RT2ib83IZzlMUM41J
	1QbbZbmqBdJBHGGq2WpIaVCB+Ge+quoKsOMtuTLjJU5FPrpf3AWVOSXUWufjkobc
	Ux0gg/ailm0C6haQPKngJlphanol8xtASqkbxiRNz99xBSdrvitByIwdSb21ynUP
	KjVrk8hB3bAQpmUgemoRUpsK+bKiiAIPPDWPapZSagCdKMQ5ge1AW/XrsWFQTwMP
	F4RDYSkfDl+Wcd9dVsnrVtym0x6XIZOrwiCRwgvpIx5h5j55RnWUnbhFUG9s3cog
	fjUNDG1LVo+t1N5W4dgZuvH1AcytA0fLz8imKR9A7wp7OTVZzKxu1ycFvz5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726293416; x=1726300616; bh=r1M7ruRNRUYjRohbwuaCuLvbF8h8
	qL/m91LCjTsa0pY=; b=dTvhx3KGz7lzodcLtN7FWvG6iRBbtM/oQwdQbCu5H/2C
	jj8ghPZhTT6JIuj2tIKfeGxBj2IkfRK80+ExL484EeqmZrhVsLg2l5vPGtYnwfZl
	EVZXr9lnXwWosTTY/s9V1mZvmdv8K7qvLZPitDJgcFCDukmM9kHRZIi5FSJjIJRA
	mIi6qaWZGknB3hgZRpwuTqTJmdERu+HLupSUz6isZMqog5g5W0OhIwa7l05Btgp4
	w8+NRO/8sdktwMl7uD2jW1PioE3Cm4rp/uFIAP80+aDpYxZIPnGhlRCDMOyX0zlh
	CtLZcLuqnQHFPbX/qEDrcG1yXxIikp/CeVIlURxUQA==
X-ME-Sender: <xms:pyXlZo0ykIxWD-4xYHvIY8eHb8ErwcjcJqz8nEN6qGnQDD666ZKqzA>
    <xme:pyXlZjFQwo4CElZ8_eq9qnVJabBqGqA7P5ZN70N1B-o4yxzh64J8yLDgtIt349CEW
    ShDLB750snMgg>
X-ME-Received: <xmr:pyXlZg6DVL-59vM29UlEnostWe8LhObGPwQ0ImNW3zzeSuwEgVOTX6MYjnCPYFq_07wWuALjworwc3bgLKYrESsBxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeef
    leevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopeehgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdr
    tghomhdprhgtphhtthhopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesshhivghmvg
    hnshdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrhhinhgtrdhunhgrlhesrghrihhntgelrdgtohhmpdhrtghpth
    htohepuggrnhhivghlsehmrghkrhhothhophhirgdrohhrghdprhgtphhtthhopeguqhhf
    vgigthesghhmrghilhdrtghomhdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguih
    grthgvkhdrtghomhdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:pyXlZh3NhZ47W8ot1yzi438QqhshqQMC_t9XFoqvfNOTSMt5VhKiEw>
    <xmx:pyXlZrEnQC7yKvdjSbHpNdDdDCFjizNJ7TGZIjnSiciYgqbskDAwaA>
    <xmx:pyXlZq-IDOu97cyMH9awHz4QyfjAFCflPRcJso-FJKiv2wBdSj1ksw>
    <xmx:pyXlZgn-FI0AoKPDAFRSg9cIKczVtuMSzJNK60Ux6G4dAS_2JdCfYw>
    <xmx:qCXlZlD-5VlMMQYk06m3uJiE1IpLx5akx0bxavQG_4jtn2jPM_iELKKW>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 01:56:54 -0400 (EDT)
Date: Sat, 14 Sep 2024 07:56:52 +0200
From: Greg KH <greg@kroah.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"A. Sverdlin" <alexander.sverdlin@siemens.com>,	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Ar1n=E7_=DCNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-mediatek@lists.infradead.org, bridge@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Message-ID: <2024091436-gas-phonebook-0018@gregkh>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
 <20240913190326.xv5qkxt7b3sjuroz@skbuf>
 <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>

On Fri, Sep 13, 2024 at 09:27:23PM +0200, Andrew Lunn wrote:
> > >  drivers/net/dsa/mt7530.c                    |   3 +-
> > >  drivers/net/dsa/ocelot/felix.c              |   3 +-
> > >  drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
> > >  drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
> > >  drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
> > >  drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
> > >  include/linux/netdevice.h                   |   2 +-
> > >  include/net/dsa.h                           |  36 +++++--
> > >  include/net/dsa_stubs.h                     |   6 +-
> > >  net/bridge/br_input.c                       |   2 +-
> > >  net/core/dev.c                              |   3 +-
> > >  net/core/flow_dissector.c                   |  19 ++--
> > >  net/dsa/conduit.c                           |  66 ++++++++-----
> > >  net/dsa/dsa.c                               |  19 ++--
> > >  net/dsa/port.c                              |   3 +-
> > >  net/dsa/tag.c                               |   3 +-
> > >  net/dsa/tag.h                               |  19 ++--
> > >  net/dsa/tag_8021q.c                         |  10 +-
> > >  net/dsa/tag_brcm.c                          |   2 +-
> > >  net/dsa/tag_dsa.c                           |   8 +-
> > >  net/dsa/tag_qca.c                           |  10 +-
> > >  net/dsa/tag_sja1105.c                       |  22 +++--
> > >  net/dsa/user.c                              | 104 +++++++++++---------
> > >  net/ethernet/eth.c                          |   2 +-
> > >  25 files changed, 240 insertions(+), 152 deletions(-)
> > 
> > Thank you for the patch, and I would like you to not give up on it, even
> > if we will go for a different bug fix for 'stable'.
> > 
> > It's just that it makes me a bit uneasy to have this as the bug fix.
> 
> +1
> 
> We should try for a minimal fix for stable, and keep this for
> net-next, given its size.
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> * It must be obviously correct and tested.
> * It cannot be bigger than 100 lines, with context.

It's fine if it fixes something properly, to go over those limits.

