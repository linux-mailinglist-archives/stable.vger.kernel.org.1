Return-Path: <stable+bounces-9220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996582228A
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC43728479D
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1F16420;
	Tue,  2 Jan 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z969pk4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1316408
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f254d1a6daso14538337b3.2
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704227252; x=1704832052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57elgdniwVdc3+g3xt51kmk/wTKPZc8YGaxaPGZRMwk=;
        b=Z969pk4AdnIEpvflitk9KKfAimdqW9fThzt01sNA2EHuV2GYLAOWRbrlamfGhFAu+2
         Ow4GyfXhZViwPmQKHgxnphWuvPZCy570DYP36rDAq1hVFu6xGn3dn3HYUOjpbd3JgeFN
         UQq9RQhTFCyz3rPXwwmp5Wj1yYaHbKUiwFpsV2BJ2UtAQupe+ohqz6nkVrYzUwmvBIom
         pO6hqermPO8c8BPR/nn9xvEAr68d9115/1kZ6ZH+uQNX/3Jke8YmXXOZA4Z6Y+9xpakl
         KuXvNb3lSJU5Ti+da6rHZI4V4h+pcMzP1F5KnGX/nwyogF02Rj3pF3XMoNiPKYAjdfSF
         nyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227252; x=1704832052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57elgdniwVdc3+g3xt51kmk/wTKPZc8YGaxaPGZRMwk=;
        b=SB8sBdhp+H9TQC+oslTZOiWPy0gSQgUNtkVNG/4XAs0v5RoS0/uvqWyokY+uWcn+ub
         q70+yXFaQjHL6/2NwY/VMgfF00+iT72zT9a/+QxMgmZi6dbW/HaJ4msyTe21JhJkRvYx
         eveKpYo+t64zVsGhAlFGC+J//Er1ZNDK9MoJG5Bnbd7K6lybul0rd5vm4FqtCjg7Jy3w
         x3HZ0JWqiCOXzAQz7wAORC7x/arlQksozBgtsub8sG9Sf5aJqFwohpowPXcsYix71U6i
         QtoLdET6EGK4rs7RhqYU+s6sn1q5LkIA7SZuYHVgee50f9LuEeeabCmn4LgazmtoTBgi
         U9qA==
X-Gm-Message-State: AOJu0YwgPAjh3w08TVb1tzMNh6SVViEwJj/Mk7+PvqQMPvaWqiux5qpU
	8NRaDdQBGyU35TiUuaDRlYVmkZtHbb7qWTKeej7rBgLaZ1/Whw==
X-Google-Smtp-Source: AGHT+IHp2RSa0VuvVG8Klk0YQDjmzxq+0RHbKjArLq+EvbeQ8IFgiQjcRQG4mPxnAXnuBN5nttuR970iOInU5esWrKM=
X-Received: by 2002:a81:ae62:0:b0:5ea:5340:fb1d with SMTP id
 g34-20020a81ae62000000b005ea5340fb1dmr8848683ywk.53.1704227251901; Tue, 02
 Jan 2024 12:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102162718.268271-1-romain.gantois@bootlin.com> <20240102162718.268271-2-romain.gantois@bootlin.com>
In-Reply-To: <20240102162718.268271-2-romain.gantois@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2024 21:27:20 +0100
Message-ID: <CACRpkdZjOBpD6HoobgMBA27dS+uz5pqb8otL+fGtMvsywYBTPA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking
 COE on stmmac
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder <rtresidd@electromag.com.au>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Romain,

overall this patch makes sense.

On Tue, Jan 2, 2024 at 5:27=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:

> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagg=
ed
> frames are ignored by the checksum offload engine and IP header checker o=
f
> some stmmac cores.
>
> On RX, the stmmac driver wrongly assumes that checksums have been compute=
d
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
>
> Add an additional check in the stmmac tx and rx hotpaths so that COE is
> deactivated for packets with ethertypes that will not trigger the COE and
> ip header checks.
>
> Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617=
c2@electromag.com.au/
> Reported-by: Romain Gantois <romain.gantois@bootlin.com>
> Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c544=
95@bootlin.com/
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
(...)

> +static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
> +{
> +       __be16 proto =3D eth_header_parse_protocol(skb);

I made a new function for this in my patch
https://lore.kernel.org/netdev/20231222-new-gemini-ethernet-regression-v4-2=
-a36e71b0f32b@linaro.org/

I was careful to add if (!pskb_may_pull(skb, ETH_HLEN)) because Eric
was very specific about this, I suppose you could get fragment frames that
are smaller than an ethernet header.

I should use eth_header_parse_protocol() instead of reimplementing it
though. :/

Should we add an if (!pskb_may_pull(skb, ETH_HLEN)) to
eth_header_parse_protocol()?

Yours,
Linus Walleij

