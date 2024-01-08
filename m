Return-Path: <stable+bounces-10017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF2826FCF
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B8282C97
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165544C8A;
	Mon,  8 Jan 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPEyp9PK"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F644C7A;
	Mon,  8 Jan 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FFE1240008;
	Mon,  8 Jan 2024 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704720586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfQYkI24IKxSDWmoC0/qvQq6SNd6yUAhqqt111/kkzo=;
	b=GPEyp9PKlB8UzvwG6GITJdcl1GNaZ4PVmzWbdUEbT4EtUip/7WFDrRpenAfxbGz3P758wq
	iHKvXGFmmv7luyI5l93cLBqGz24eaSalQz6SebnFOz8AdEdGuMnxyrxXPLlXwotjHigKAM
	sdYGcN7nEyC57wPUgg/1Y+sQxrHCwqP/VXFABTgv6N9JYFUbQcCj+ii2To20JOFAdrRlS6
	VkFvpZUJ/4SFMpJ6Gkd248R5nIIEWBxU/Sn8gdFMksSPA9Qp51/R/YnE2GSKdoBQrynOoG
	sBQC/7iRDL3ZNW5yAtqll8vPm7t1EeLgv7/TQ2juc2RU+jEv7D27z/gCwZIhHw==
Date: Mon, 8 Jan 2024 14:29:41 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder
 <rtresidd@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: stmmac: Prevent DSA tags from breaking
 COE
Message-ID: <20240108142941.2b14f90e@xps-13>
In-Reply-To: <20240108130238.j2denbdj3ifasbqi@skbuf>
References: <20240108111747.73872-2-romain.gantois@bootlin.com>
	<20240108130238.j2denbdj3ifasbqi@skbuf>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Romain,

> > +/* Check if ethertype will trigger IP
> > + * header checks/COE in hardware
> > + */ =20
>=20
> Nitpick: you could render this in kernel-doc format.
> https://docs.kernel.org/doc-guide/kernel-doc.html
>=20
> > +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb) =20
>=20
> Nitpick: in netdev it is preferred not to use the "inline" keyword at
> all in C files, only "static inline" in headers, and to let the compiler
> decide by itself when it is appropriate to inline the code (which it
> does by itself even without the "inline" keyword). For a bit more
> background why, you can view Documentation/process/4.Coding.rst, section
> "Inline functions".
>=20
> > +{
> > +	int depth =3D 0;
> > +	__be16 proto;
> > +
> > +	proto =3D __vlan_get_protocol(skb, eth_header_parse_protocol(skb), &d=
epth);
> > +
> > +	return depth <=3D ETH_HLEN && (proto =3D=3D htons(ETH_P_IP) || proto =
=3D=3D htons(ETH_P_IPV6));

I also want to nitpick a bit :) If you are to send a v4, maybe you can
enclose the first condition within parenthesis to further clarify the
return logic.

Cheers,
Miqu=C3=A8l

