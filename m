Return-Path: <stable+bounces-7927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2A818C3A
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71572846C9
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BB1D556;
	Tue, 19 Dec 2023 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RCHicHBz"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0692032A;
	Tue, 19 Dec 2023 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2335FF80E;
	Tue, 19 Dec 2023 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703003377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mydg9L5el80VY7v9/6lf4HQRiOoVruSebSkvtjIIK5k=;
	b=RCHicHBzkk3ecasHwejetnetySEUJUky9lvEoJtH/vUPUx6Yn9tNxp/18WFnh09muHFpYi
	SQTiKFzzBN7pXkJFKD1bgvWojqGdmEP1rLtncaH6q5pZL9Z6gBz4jIQB07QVIL7gmwWCiP
	cJFtcT8KfMkZr+pKueN9wHOeUEFleE9XHkV9zezXFOJ6meDmK01+ajJ7HIZrRuOXr5LOdn
	0QHM8U6yKMRvmoOoXCnGHEOo9v0aH80DkeRjvbg7WL/PaR6+br7nzCuAeq3Xb80BuRPcXt
	9l07cd2tSKDMseQ+TXsT01bpXVEKNUwWqCMimiD+VinTn5Ls8MljFBiBscv7BQ==
Date: Tue, 19 Dec 2023 17:29:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, Pascal
 EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
Message-ID: <20231219172932.13f4b0c3@device-28.home>
In-Reply-To: <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
	<20231218162326.173127-2-romain.gantois@bootlin.com>
	<20231219122034.pg2djgrosa4irubh@skbuf>
	<20231219140754.7a7a8dbd@device-28.home>
	<CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Linus,

On Tue, 19 Dec 2023 15:19:45 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Dec 19, 2023 at 2:07=E2=80=AFPM Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
>=20
> > So it looks like an acceptable solution would be something along the
> > lines of what Linus is suggesting here :
> >
> > https://lore.kernel.org/netdev/20231216-new-gemini-ethernet-regression-=
v2-2-64c269413dfa@linaro.org/
> >
> > If so, maybe it's worth adding a new helper for that check ? =20
>=20
> Yeah it's a bit annoying when skb->protocol is not =3D=3D ethertype of bu=
ffer.
>=20
> I can certainly add a helper such as skb_eth_raw_ethertype()
> to <linux/if_ether.h> that will inspect the actual ethertype in
> skb->data.
>=20
> It's the most straight-forward approach.

Agreed :)

> We could also add something like bool custom_ethertype; to
> struct sk_buff and set that to true if the tagger adds a custom
> ethertype. But I don't know how the network developers feel about
> that.

I don't think this would be OK, first because sk_buff is pretty
sensitive when it comes to cache alignment, adding things for this kind
of use-cases isn't necessarily a good idea. Moreover, populating this
flag isn't going to be straightforward as well. I guess some ethertype
would be compatible with checksum engines, while other wouldn't, so
probably what 'custom_ethertype' means will depend on the MAC driver.

=46rom my point of view the first approach would indeed be better.

Thanks,

Maxime

