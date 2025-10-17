Return-Path: <stable+bounces-187680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B69BEB096
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2511AE445D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE92FE56A;
	Fri, 17 Oct 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="EyJ3Ritd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5OJjiMU"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C32F7AA4;
	Fri, 17 Oct 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721303; cv=none; b=T/YAj7WrxQHzimeYYISRaM5+uZE21blDsGHsXQq0ZQylCXi656rlpwWfSPdJD6A9qD3YAkrDTyiFZyjTP92sSBHhlgzzGGpLsMtUx0svTEVXSBVa7vD5koXUdCZmUDrJTt/prCUGiLqAOqNdwHgL8Enr7zlO/pNwEVzXaQ8wR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721303; c=relaxed/simple;
	bh=4bICVGavWChlDZg37T7ku/ExiWs07y59S0fSQ/6DfP0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=L8SwjhNrmXh4hG4ipW1EhK93+zRBFHEU9AdHYrMF+DVzER1hcXof/usnNnNAF4R9F3EivOp/1fPUwoY599IJNBLh4hkHQpRPsWNmU9GRb5AfoTpi9ky9CkL4MabfayqFKershyEg9mZORsnMYeDmBaCjDh+Lqqgrd9F0BVFtI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=EyJ3Ritd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5OJjiMU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D84741400129;
	Fri, 17 Oct 2025 13:14:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Oct 2025 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1760721299; x=1760807699; bh=yJmVJ+OLzQYoiPZM+TzxD
	SB3PlWcNp/ysew4LoWAjMU=; b=EyJ3Ritd1m1hm/Jct7eksIJi/QPhkY+1QcdW2
	XkgluYjULgkHvpds3XDQJUwZ94HjMqs+aLhUlGLt7XZ/uKsy3axuR0qojvAXgtn3
	zQ3DNI2oSBcD9w/u+JpRlKW6jSi3d3eVDWPdAdpr6OCsZxNy3edotDEo3eszSW0O
	DqEXRcNlmN14szwqOCudH5XlH030BX139C5GFohLbfOsQ+AXRlUP67o155PcvRCU
	Yx2J3vN+XQtO4nNZFDuMQLFXY7VzSYDfY+rbR54z/4i0kCiVSqu4wPpGI1LoDFUt
	b7wq7ZPgUEr9G775+5g+JobeqbyZrDDasmlL3n+Yt6WHOdNnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760721299; x=1760807699; bh=yJmVJ+OLzQYoiPZM+TzxDSB3PlWcNp/ysew
	4LoWAjMU=; b=G5OJjiMUjtQgrwNAKyIunjRPCBnMygCTUvVrcH2ovMpt+ZR7Q0a
	n++O4+zvs7wT9VwynfhBp9hhvPfXTAgspaJaDdbO9WAnPQvawC6WODz9f/vaFyvC
	FQ10CJdhCyb05aAxCTftFpT81LqYvXwGJKvryCyvFl1E7P0D6iztSMbp6OMzvdyQ
	Jp5OgM+rT33g2rK3XzPlYLSHtn7FTlZ3olVTXTSd1pzspvrlE9JB4j367FgbFmQZ
	VZr/NyY5ej2i+2uwwo6+SvosO/JuQRkIpslNoRI/qRLzsd4BrX0uySyaFNJLZhT2
	L/OjSFNWkg/6eMiQXQ8+dG+J9U38VVLsetA==
X-ME-Sender: <xms:knnyaIe9MW-PLxnGK7cMRamfDjYk5I2BnGszxrzw9dBY_FrsmVSjXA>
    <xme:knnyaAucVjjUJS2Hyf1YVB37cyUBmwaAaHfUthZkpXBMSVqJS390h5bCziND9212M
    8Zn7nS3FRGfqKiAHXEZ5tzqx3DCI0i2KNJhWoiqT56YoDuZrZ1eA3w>
X-ME-Received: <xmr:knnyaHhdIMqL0JGqXWeQwyqonkO5oH6Jc48DM1M5Pm6vXwOP8WgiGpLT4wPG856NfN8wqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhngh
    hhrghosegsrghmrghitghlohhuugdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgr
    tghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:knnyaAvoC2yhvEoSPw0yjbkHcevpaasXFGmpGg7nCw1YyJiokrI5UA>
    <xmx:knnyaK-RnaGu3tKA2k2XUhz89VEgu8gieD_NQpW_cPgwvVxTxvn6yQ>
    <xmx:knnyaOY0FA5_K8IbP_Wq036NoQpq_5fuwCV3gyHecOjV41q2Vxky2w>
    <xmx:knnyaIp3oCXJO5Sz9tv9BQ9gfXPeXClsbNwDBfwb-lVQNCu5jT_7oQ>
    <xmx:k3nyaFmESaXLd_7o-_HMmkfrO_EKmB5avrTyXO4a6XEgKLwBwR65yEMm>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 13:14:58 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id F0FCA9FC61; Fri, 17 Oct 2025 10:14:56 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id EDCDD9FB78;
	Fri, 17 Oct 2025 10:14:56 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: bonding: update the slave array for broadcast
 mode
In-reply-to: <20251016125136.16568-1-tonghao@bamaicloud.com>
References: <20251016125136.16568-1-tonghao@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Thu, 16 Oct 2025 20:51:36 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <775229.1760721296.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Oct 2025 10:14:56 -0700
Message-ID: <775230.1760721296@famine>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor opti=
on for 802.3ad").
>Before this commit, on the broadcast mode, all devices were traversed usi=
ng the
>bond_for_each_slave_rcu. This patch supports traversing devices by using =
all_slaves.
>Therefore, we need to update the slave array when enslave or release slav=
e.
>
>Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802=
.3ad")
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>Cc: Nikolay Aleksandrov <razor@blackwall.org>
>Cc: Hangbin Liu <liuhangbin@gmail.com>
>Cc: Jiri Slaby <jirislaby@kernel.org>
>Cc: <stable@vger.kernel.org>
>Reported-by: Jiri Slaby <jirislaby@kernel.org>
>Tested-by: Jiri Slaby <jirislaby@kernel.org>
>Link: https://lore.kernel.org/all/a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@ke=
rnel.org/
>Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

>---
>v2:
>- fix the typo in the comments, salve -> slave
>- add the target repo in the subject
>---
> drivers/net/bonding/bond_main.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 17c7542be6a5..2d6883296e32 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 		unblock_netpoll_tx();
> 	}
> =

>-	if (bond_mode_can_use_xmit_hash(bond))
>+	/* broadcast mode uses the all_slaves to loop through slaves. */
>+	if (bond_mode_can_use_xmit_hash(bond) ||
>+	    BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
> 		bond_update_slave_arr(bond, NULL);
> =

> 	if (!slave_dev->netdev_ops->ndo_bpf ||
>@@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device *bo=
nd_dev,
> =

> 	bond_upper_dev_unlink(bond, slave);
> =

>-	if (bond_mode_can_use_xmit_hash(bond))
>+	if (bond_mode_can_use_xmit_hash(bond) ||
>+	    BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
> 		bond_update_slave_arr(bond, slave);
> =

> 	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
>-- =

>2.34.1
>

