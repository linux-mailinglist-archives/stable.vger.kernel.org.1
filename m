Return-Path: <stable+bounces-89175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05E9B4582
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D51F21242
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B971E0DD8;
	Tue, 29 Oct 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fkZZG+rY"
X-Original-To: stable@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205D20402C
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193563; cv=none; b=k5tJasqArzo+DBUoGiAuCdUuDd1Janev4a+r2mONVQDMFNOWY1MZ/DUFoKaIV3GmNwxxvcreB+txaH6yJ9cGmb3t2WK80UE4pmg+6DisZqOQwblsjUrYHlNJCn0A8tMYzFgMDafW8NeqQEdOzfrh9B+Tnpl3I0CBgF0Z57U2ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193563; c=relaxed/simple;
	bh=1T+xcrsVhKkjKI6y4WYMaS68MhKN33QdqsculeNcOjE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAdByK0KM2IzlRV85/4EWATqrfFsfQYsgxdDgiPMGChJeGG2ttiTx8WJtjMjhIZ93UFtnfe9agkUzra1isbuHS4g9Yapw/kiw18T3IbNgonnK8qaXgDlsYejCYklRTdjDj6+EGrTHOjHdzqcnF3DZXusYy8+GYYL5DNae5ewJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fkZZG+rY; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730193552; x=1730452752;
	bh=1T+xcrsVhKkjKI6y4WYMaS68MhKN33QdqsculeNcOjE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fkZZG+rY4B0XSK7K3Wvn0ZmPfxerX29mzPKd+YbAlXtt2OiXPq8JDCPlXzlJTt6tR
	 +s6krUiLLfJ+wAy16bUmf2OFj1JZzOh4i08AepizUaToAUkGgXFtlVXETb2/vX0/Op
	 VsZLW0FC/k6Hsa9aN/KIsggaTwKJt5F5dm4ADCzUjOYghk+ylk5raSbJxPhKHC3xpV
	 P9FLm2qVCOrgc+EJBw6qdvSDdtJLbN4Lnc4VBq+w22WO8WRh4yh0nLUoLuuZINXqc6
	 DT8UI8saTz/w2CsU4nEDjniv+8He9EL7SlZiXBq7feD4nmifki6aDWe4jleA/kJVFn
	 Po7Js34ha/i7w==
Date: Tue, 29 Oct 2024 09:19:07 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux1394-devel@lists.sourceforge.net
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH] firewire: core: fix invalid port index for parent device
Message-ID: <c017238b0af2a81b5636bc89f195e809ab9a9d72.camel@proton.me>
In-Reply-To: <20241025034137.99317-1-o-takashi@sakamocchi.jp>
References: <20241025034137.99317-1-o-takashi@sakamocchi.jp>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 0207c9aa3ef9ed22d7cccd3fcf2f56d483efb8ed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> In a commit 24b7f8e5cd65 ("firewire: core: use helper functions for
> self
> ID sequence"), the enumeration over self ID sequence was refactored
> with
> some helper functions with KUnit tests. These helper functions are
> guaranteed to work expectedly by the KUnit tests, however their
> application
> includes a mistake to assign invalid value to the index of port
> connected
> to parent device.
>=20
> This bug affects the case that any extra node devices which has three
> or
> more ports are connected to 1394 OHCI controller. In the case, the
> path
> to update the tree cache could hits WARN_ON(), and gets general
> protection
> fault due to the access to invalid address computed by the invalid
> value.
>=20
> This commit fixes the bug to assign correct port index.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Edmund Raile <edmund.raile@proton.me>
> Closes:
> https://lore.kernel.org/lkml/8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.cam=
el@proton.me/
> Fixes: 24b7f8e5cd65 ("firewire: core: use helper functions for self
> ID sequence")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
> =C2=A0drivers/firewire/core-topology.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firewire/core-topology.c
> b/drivers/firewire/core-topology.c
> index 6adadb11962e..892b94cfd626 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -204,7 +204,7 @@ static struct fw_node *build_tree(struct fw_card
> *card, const u32 *sid, int self
> =C2=A0 // the node->ports array where the parent node should be.=C2=A0 La=
ter,
> =C2=A0 // when we handle the parent node, we fix up the reference.
> =C2=A0 ++parent_count;
> - node->color =3D i;
> + node->color =3D port_index;
> =C2=A0 break;
>=20
> =C2=A0 case PHY_PACKET_SELF_ID_PORT_STATUS_CHILD:
> --
> 2.45.2
Your patch is identical to my original proposals except for the line
numbers.


I've been using it since, no issues.

Thank you!

Tested-by: Edmund Raile <edmund.raile@proton.me>


