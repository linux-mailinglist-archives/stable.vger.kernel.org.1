Return-Path: <stable+bounces-119972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF1A4A0B8
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C8F160ED0
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA22702A5;
	Fri, 28 Feb 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fk9sbzBJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102221F09BF;
	Fri, 28 Feb 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764687; cv=none; b=SE0jz85GNnqWwY9GpnlAcF3XYEA1evhR/cMHtnKTalXZIf0Xr7BawXLaxI4fxkW3L/wWxaGAk6HHaoCoGz8h6yGwGJimKKrN3uMLdIaSG9KsMl45B1PCtmDc20k+oK0Q2fx91HMjAZkKElBStAcLLfzJU28Z3bjMG3dZhwmBu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764687; c=relaxed/simple;
	bh=ZRCj/8TAJAuJJJ0i17Nh93VZ/UIjIMRuizn2fdB09cA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZBK6UbFK1wr8B67YcaZNQ6Yktx6LSs+ew332nccpQ6bOiFMZBaqWGThLaZ53nPz3fusyDQm4+CXfby7FEi29VCOp/94k8X/E6K/GFYEMm0amSrzJCIP66+DtqoubDE4KKn5MRiMCCtbNFYNIjx7J81PLgeaW90mmN1AaWEjX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fk9sbzBJ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740764682; x=1741023882;
	bh=ZRCj/8TAJAuJJJ0i17Nh93VZ/UIjIMRuizn2fdB09cA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fk9sbzBJMBVZrv7z3GCpRvHpsWTvPCNjq+XIfPVndaeg1kWMHvmDQL3CYq+tX3i0q
	 T9tHtYfm1uvQqnoHlWSPR5XNRIIgppZI+KXKCblrafxV+OmOSGTT1Ufo/pWAtwj1VT
	 I7S6DnOkDMieOkOxQTMGa0sFEp05wlJqyg1PWl/N5MX2SRPPFMP36zvlMauBKWKQc0
	 15yXL3S/xqbl1bR++2sc8rhrqKkaRdi0h0JI7Jp2bJst58tF8Z/bZsUwNM1/Pkv8Qx
	 MfsW4p+rDi8F/jhkO13BcMiabRZsjTkQuYw2VtI+G7Rw/4B9fR8WIJmUU5clFIfD/b
	 RJNf6S4oJQnDg==
Date: Fri, 28 Feb 2025 17:44:38 +0000
To: Peter Seiderer <ps.report@gmx.net>
From: fossben@pm.me
Cc: Christian Heusel <christian@heusel.eu>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925 wifi throughput halved with 6.13.2
Message-ID: <JZIl1iVcv9U3s8KnXJqR-ZKFBUzbVvbqR3NN0LO4as5_yXxPPS4yIfzGK22Z6rNZOyOysBzWPZGQgL-8eychueJtr7TvC3A0I-s3CVHHDUo=@pm.me>
In-Reply-To: <20250228161420.11ac4696@gmx.net>
References: <b994a256-ee2f-4831-ad61-288ae7bc864b@heusel.eu> <20250228161420.11ac4696@gmx.net>
Feedback-ID: 134317997:user:proton
X-Pm-Message-ID: a944d88e39b523d475fe769a680d961766ce4442
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all!

Christian provided me with a linux-mainline-6.14rc4-1-x86_64 package to tes=
t with today and I am still experiencing the issue, so I am assuming that r=
evert did not happen yet.

To give some additional context for the performance regression, I have an A=
T&T 500/500 fiber line. As of this morning on kernel 6.13.1, I get 550 down=
 / 470 up over Wifi 6 on speedtest.net. Testing immediately afterwards with=
 Christian's mainline package, I got a result of 170 down / 75 up, which is=
 similar to the results that I got for all the other bisection kernels Chri=
stian gave me to test.

Thanks!
Ben


On Friday, February 28th, 2025 at 9:14 AM, Peter Seiderer <ps.report@gmx.ne=
t> wrote:

>=20
>=20
> Hello Christian,
>=20
> On Fri, 28 Feb 2025 11:19:52 +0100, Christian Heusel christian@heusel.eu =
wrote:
>=20
> > Hello everyone,
> >=20
> > on the Arch Linux Bugtracker1 Benjamin (also added in CC) reported
> > that his MT7925 wifi card has halved it's throughput when updating from
> > the v6.13.1 to the v6.13.2 stable kernel. The problem is still present
> > in the 6.13.5 stable kernel.
> >=20
> > We have bisected this issue together and found the backporting of the
> > following commit responsible for this issue:
> >=20
> > 4cf9f08632c0 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for=
 MLO")
>=20
>=20
> Seems there is already a suggested revert of the mentioned commit, see
>=20
> [PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_=
ba for MLO"
> https://lore.kernel.org/linux-wireless/20250226025647.102904-1-sean.wang@=
kernel.org/#r
>=20
> Regards,
> Peter
>=20
> > We unfortunately didn't have a chance to test the mainline releases as
> > the reporter uses the (out of tree) nvidia modules that were not
> > compatible with mainline release at the time of testing. We will soon
> > test against Mainline aswell.
> >=20
> > I have attached dmesg outputs of a good and a bad boot aswell as his
> > other hardware specs and will be available to debug this further.
> >=20
> > Cheers,
> > Christian

