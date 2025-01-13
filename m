Return-Path: <stable+bounces-108533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C8A0C388
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A9A3A5E8A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E11CACF3;
	Mon, 13 Jan 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2XlSY3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9C240233;
	Mon, 13 Jan 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803176; cv=none; b=i0Z9+LWjUtXKf+CeathzRwJaXfRNaG4gNpzOW8VP3dH2VEsIFNSBqiJi4iJciHklwn/7xoY8ulPavA+1SOHq8zPK2MlxrYGbUQa+NoEEPZuLypJimAw8H6sgQC6aznYv9xDqlW+5PEvJWtpS9y4XHQPQgjDNTtNOavLAWj2r0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803176; c=relaxed/simple;
	bh=6wQ9vMFsf6ItQpJy9k9Wqdx180ffkZRpQUOG+839358=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q28HabeLIthQpJvcMM9mynJKcHmPZyyHvN+WRcpJG1LPZz+mAvPS8md4nsA8hca6cbA6g8+k39zIkOtvLyOr418pUvA+szTtdpqx7/vxZsSBSKkdF2wmgO8AKy75d0zbWSg2YabjfgXk11ZpXPeWxXrPPtJJ6qWxFyELq2z1QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2XlSY3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708EC4CED6;
	Mon, 13 Jan 2025 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736803175;
	bh=6wQ9vMFsf6ItQpJy9k9Wqdx180ffkZRpQUOG+839358=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2XlSY3iqQYtFQOjDG046jPOjuxrPK47hFAH8eSKIRb/1nEs+MagnYKILcvF1K/B4
	 Rzirwd9/LOVLwA5ZgrZAejVVFdDZf2Tr+9l3h98Nfut4LZ9YZQEkw28oVDTdIz899l
	 uq+63nRn5vZV0Di9Mvhlv83GsgCndry7ZAPdMW64SS5uUtCo545BaJoXwvyggyBEZD
	 yFhSazQgua4dix4jLjYcMm5uBPhdHNzHIDVSnZRZMyVUt6H9fmtN9ovN93geZC8KuV
	 H8CDNKl3say2o8sNDJCQWcRdPd6vaRrrv276vtvLo0IZIo2iXEg0gVEY19LAnR/IHA
	 hTrL56/RtKYiQ==
Date: Mon, 13 Jan 2025 13:19:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Paul Fertser <fercerpav@gmail.com>, "Potin Lai (=?UTF-8?B?6LO05p+P5bu3?=
 )" <Potin.Lai@quantatw.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Cosmo Chou (
 =?UTF-8?B?5ZGo5qW35Z+5?=)" <Cosmo.Chou@quantatw.com>, "patrick@stwcx.xyz"
 <patrick@stwcx.xyz>, Cosmo Chou <chou.cosmo@gmail.com>
Subject: Re: =?UTF-8?B?5Zue6KaGOg==?= [External] Re: [PATCH] net/ncsi: fix
 locking in Get MAC Address handling
Message-ID: <20250113131934.5566be67@kernel.org>
In-Reply-To: <CAGfYmwVECrisZMhWAddmnczcLqFfNZ2boNAD5=p2HHuOhLy75w@mail.gmail.com>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<20250109145054.30925-1-fercerpav@gmail.com>
	<20250109083311.20f5f802@kernel.org>
	<TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
	<20250110181841.61a5bb33@kernel.org>
	<CAGfYmwVECrisZMhWAddmnczcLqFfNZ2boNAD5=p2HHuOhLy75w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jan 2025 19:12:51 +0800 Potin Lai wrote:
> > > Thanks for the new patch.
> > > I am currently tied up with other tasks, but I=E2=80=99ll make sure t=
o test
> > > it as soon as possible and share the results with you. =20
> >
> > Understood, would you be able to test it by January 13th?
> > Depending on how long we need to wait we may be better off
> > applying the patch already or waiting with committing.. =20
>=20
> Hi Jakub & Paul,
>=20
> I had a test yesterday, the patch is working and the kernel panic does
> not happen any more, but we notice sometimes the config_apply_mac
> state runs before the gma command is handled.
>=20
> Cosmo helped me to find a potential state handling issue, and I
> submitted the v2 version.
> Please kindly have a look at v2 version with the link below.
> v2: https://lore.kernel.org/all/20250111-fix-ncsi-mac-v2-0-838e0a1a233a@g=
mail.com/

Is there any reason why you reposted Paul's patch?
Patch 2 looks like a fix for a separate issue (but for the same=20
use case), am I wrong?

Also one thing you have not done is to provide the Tested-by: tag=20
on Paul's patch :)

