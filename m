Return-Path: <stable+bounces-114304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B90A2CCA9
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16671886008
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5818E02A;
	Fri,  7 Feb 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKJZFKkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725161624C9;
	Fri,  7 Feb 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956936; cv=none; b=GclCJGAPK6wS60WO0A1z/8ozdKmkmWo/ub1MafRxsHL9EGk+7kHp5G3xkVF0hsoh/NOmNhGaYUDKQdbNfAx+dltIK3dhK1fVPXGa1qBWcMUsq5vEdCa+CAMOyYm2+ax9Eb+lnV65LJ+u8Gc3KDEfDjaKUsrE8UKSCk+U3HUBa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956936; c=relaxed/simple;
	bh=JpQJ6Fk868A97/uqUZKj3hzBdO8O/htUHtHnkbDpILI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qss6ah7+iP/q+ceSA6Xo9z4XfS6oAQODJOla1tJQF1P1U7MfqOCzWPdwU9Otv6Bky7WvSLqz73COSEXyF1azHtIX3X3gmZEUI5Og8z0Xr8SdKf+PO8Lxy/1xU1Jgx9VBW9DBUtdykWPUVF6RqpV59S4AoCgAN0ZA+9ujwliRCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKJZFKkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79CFC4CED1;
	Fri,  7 Feb 2025 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956935;
	bh=JpQJ6Fk868A97/uqUZKj3hzBdO8O/htUHtHnkbDpILI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKJZFKkJx2tCoCAzMHxMz1k1o7aHnZh7NArFz1THhfkT1I6O7qQvmE5eyz0u2qSQA
	 rgfeK5VIO27i3AEmRjRvKQApOPBgboqmsQD1l9QGMKofyzXpO58xyL9dDe4MFW0TxR
	 mBSsMX+moD4BJv7x4ta1vIbLoRSs4yAGuocZE3vLOcZ3hisfC/wwxzMaKv9uBhucsI
	 B2N7tSANaGZTN1s/SuxNEs59rwBesfKsXDApFX1lM8e4qxZNPbMqtNpe7vSQNeOSjz
	 Zdp1lTt7RJRnYVfXU4FZP2/TYP/enJZpkYqhPjaEgXD6d17Y/fgster9SWu1ED2XF3
	 cH/viK1sLYlcg==
Date: Fri, 7 Feb 2025 11:35:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: advertise 'netns local' property via
 netlink
Message-ID: <20250207113534.15136b7a@kernel.org>
In-Reply-To: <f052190e-f81e-491b-aaed-60eaa01fd968@6wind.com>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
	<20250206165132.2898347-2-nicolas.dichtel@6wind.com>
	<20250206153951.41fbcb84@kernel.org>
	<f052190e-f81e-491b-aaed-60eaa01fd968@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 10:10:49 +0100 Nicolas Dichtel wrote:
> Le 07/02/2025 =C3=A0 00:39, Jakub Kicinski a =C3=A9crit=C2=A0:
> > On Thu,  6 Feb 2025 17:50:26 +0100 Nicolas Dichtel wrote: =20
> >> Since the below commit, there is no way to see if the netns_local prop=
erty
> >> is set on a device. Let's add a netlink attribute to advertise it. =20
> >=20
> > I think the motivation for the change may be worth elaborating on.
> > It's a bit unclear to me what user space would care about this
> > information, a bit of a "story" on how you hit the issue could
> > be useful perhaps? The uAPI is new but the stable tag indicates
> > regression.. =20
> To make it short: we were trying a new NIC with a custom distro provided =
by a
> vendor (with out of tree drivers). We were unable to move the interface in
> another netns. Thanks to ethtool we were able to confirm that the 'netns-=
local'
> flag was set. Having this information helps debugging.

Thanks, makes sense. Still a bit unsure if this is a stable candidate,
if you don't mind net-next that'd be my preference. If you do mind,
I'll live with it :)

> >> @@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >>  		       netif_running(dev) ? READ_ONCE(dev->operstate) :
> >>  					    IF_OPER_DOWN) ||
> >>  	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
> >> +	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) || =20
> >=20
> > Maybe nla_put_flag() ? Or do you really care about false being there? =
=20
> It depends if the commit is backported or not. If it won't be backported,=
 having
> the false value helps to know that the kernel support this attribute (and=
 so
> that the property is not set).

Wish we had a good solution for this, it's always the argument against
flags :(

