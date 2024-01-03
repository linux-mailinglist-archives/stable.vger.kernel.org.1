Return-Path: <stable+bounces-9619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CB823835
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F67B2486B
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DC208AB;
	Wed,  3 Jan 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAUmbm2V"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9B1EB2D
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdc7ff087fso6810981276.2
        for <stable@vger.kernel.org>; Wed, 03 Jan 2024 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704320741; x=1704925541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kmcqsMX8fQ3sLYeMRmJosc8oLB5bZGg3REIDOYybdk=;
        b=aAUmbm2Venzm7/HQlyvGH5EIujPQFP1YXVwI0YEJLeNM6YdTs4YXLsBnbvZqgZQmYB
         KdWIcpH12E0/Bxu5i2Tu1P51FpuD9rCrXG/JFBozLQ6LiZvUnvKZPIufLfVK8uXpw4wc
         p1YvD3BQpkngvXiioVQg3+/vKy2uXbgbTIxvgVdIl6UaT/tanNlT2XZ3L2ZhM0kacSBZ
         V510xsFq4UbJuSjyj3OVUMRVcizZt1qoCke5hFkeINGfxgam5XQP5crTUelEX3hCFw+3
         quo866jlGUy5vQF0pf7419TM787Bv4LljldvcLXTZakV+rndv0W+xUk2eA+BlLKHz3sb
         2/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320741; x=1704925541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kmcqsMX8fQ3sLYeMRmJosc8oLB5bZGg3REIDOYybdk=;
        b=MmFlx22aE7xWxhXsHoZeooSEbYIPVq9Nmt+3s32rMAzM2E8deWYIKqy330u4qvgTEO
         TY33l6xXbYpzJYLX8CJLvd6CCmoqn2c5Fse5aKQWrFFMu79iD3zra4vh+BuLHxw87Rdi
         0uhokWD9wQg624g9U/IHPsuPalrHF3dJcfMUWvB4RlnlVvI+EXFscBKVXX7q1qdYLr8G
         XH056JTrFwhUiF2j2x2qP9WcagIEcSbKPQlTc1E6oLJ7mS8o+nM1qDq4GCsvU14kRrmH
         e2e2VLn4YM/0YbyeIOLkIvSkvYk6q+l7kt7b5I0E38eyX7miUboatCUeelT1MFWkCJ9Z
         vj2A==
X-Gm-Message-State: AOJu0YzcswGyMpRdScVHsiFfZaXQ0cKZuwvd06JGCOe9/QUWTrx2089v
	tzjkkfcwSzvinX89Mwmw9jVb3blgUhPK1YHhAt4jTYYK8M8YNA==
X-Google-Smtp-Source: AGHT+IH3lN5EReu2g0Mi+oxqq6LxDhkZAcXvUANpBIfR+d/23nY/29IleV2lLkmHHtEwUYWNJ3aNAjkw6NRWH1Vyk6A=
X-Received: by 2002:a5b:ed0:0:b0:dbe:9fe3:9d24 with SMTP id
 a16-20020a5b0ed0000000b00dbe9fe39d24mr1147230ybs.111.1704320740768; Wed, 03
 Jan 2024 14:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102162718.268271-1-romain.gantois@bootlin.com>
 <20240102162718.268271-2-romain.gantois@bootlin.com> <20240103201021.2ixxndfqe622afnf@skbuf>
In-Reply-To: <20240103201021.2ixxndfqe622afnf@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jan 2024 23:25:29 +0100
Message-ID: <CACRpkdYAOReqhoXVc_D6eeW-MvWym3eL2T3KTePqZSx3WWsGEQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, 
	Andrew Lunn <andrew@lunn.ch>, Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:10=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Tue, Jan 02, 2024 at 05:27:15PM +0100, Romain Gantois wrote:
> > +/* Check if ethertype will trigger IP
> > + * header checks/COE in hardware
> > + */
> > +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> > +{
> > +     __be16 proto =3D eth_header_parse_protocol(skb);
> > +
> > +     return (proto =3D=3D htons(ETH_P_IP)) || (proto =3D=3D htons(ETH_=
P_IPV6)) ||
> > +             (proto =3D=3D htons(ETH_P_8021Q));
>
> proto =3D=3D htons(ETH_P_8021Q) means that the skb has an IP EtherType?
> What if an IP header does not follow after the VLAN header?

It's probably best to do like I do here:
https://lore.kernel.org/netdev/20240102-new-gemini-ethernet-regression-v5-2=
-cf61ab3aa8cd@linaro.org/

+ if (ethertype =3D=3D ETH_P_8021Q)
+   ethertype =3D ntohs(__vlan_get_protocol(skb, htons(ethertype), NULL));

Yours,
Linus Walleij

