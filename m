Return-Path: <stable+bounces-7922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7C8189A4
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751CF1C20399
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042511B290;
	Tue, 19 Dec 2023 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMmMQ3EF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D391B291
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbcdec51ed9so3305820276.0
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702995597; x=1703600397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udO5JdiwtE99JnEZ5ly9pAA3TWaydCoVrlitP8BJQG4=;
        b=zMmMQ3EFRQbba6WfrsJejz0W+ryy3XLjenI7zihuzFFJJhERbxrGu+H2phVdTiM6Kq
         JDjM6ntiHQx5sM134cGXoK2drEiCEOklX0e4tzKyLqNB2ARj4QUNUdYv7/5/7R3d2tvZ
         /SxpF0OxDHdYqq3Ot+wckg7tHilm/Tftm++2mh/qELSjVH0Wqr3To9TGmnZ6zXa0dybO
         OkIudwFxgwAzcxQczrFD3yue/qmLQ5/8CEEenAwwFXJAqDDo2ZfX4ryypZUv/TQdnnTq
         rJvnw3oT7tmpkw/9OYDWxu5UBHhkIU678+y1PAeDTTo68NtewrHV07clWpu5hBgUs35X
         BWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995597; x=1703600397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udO5JdiwtE99JnEZ5ly9pAA3TWaydCoVrlitP8BJQG4=;
        b=rc03umCaaBWOSkZc6t0Q1oFFT6lzkq3fkIncsR/qWXVn45kwFGHODELSyGXKiCR7TT
         30btMQeNyGB/2S9fUp3ppjr8dkiJB6OZNGOwYZNyFEhgSXN1NoweQT7tWsjz9XhznZwC
         b0dQBhFk2FEGnJIelh+0ZTv5r0j80PGuAmG3DPm2fUDVu8G7LbMzXvtzZqBAjIJNA1ML
         dFXbZwUnviIIKe6QqfLV9Ltm4G3oJX/YLDqID1kwtGVOMaEZnaB1F4XeezpqPsqvEIdk
         bogdFYgAnAnBSLQZw7Xu8b7sYGaDLa8f9gL4AAKeIxcrSSLO2YPDVUx89s34WGHsySrp
         GYNQ==
X-Gm-Message-State: AOJu0YwmXclum8a0lDNn+Ve/wXcId1m3IL9xlsdDvYYUrP15noTrtvY+
	arf+tK+NxMPjPBQ3VlQyl4Kzi7DjmcpB4yUBx74vSQ==
X-Google-Smtp-Source: AGHT+IHaONPPt0yp11P4xWjwUfRR430BJRxfeWYtV2bqNtIe/9eVYDMx97tuw/H4MF1jSSyV3o2q+8Nyj6JP8FiXw+Y=
X-Received: by 2002:a25:230e:0:b0:dbd:5ccd:f197 with SMTP id
 j14-20020a25230e000000b00dbd5ccdf197mr357230ybj.121.1702995596901; Tue, 19
 Dec 2023 06:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com> <20231219122034.pg2djgrosa4irubh@skbuf>
 <20231219140754.7a7a8dbd@device-28.home>
In-Reply-To: <20231219140754.7a7a8dbd@device-28.home>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Dec 2023 15:19:45 +0100
Message-ID: <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sylvain Girard <sylvain.girard@se.com>, Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:07=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:

> So it looks like an acceptable solution would be something along the
> lines of what Linus is suggesting here :
>
> https://lore.kernel.org/netdev/20231216-new-gemini-ethernet-regression-v2=
-2-64c269413dfa@linaro.org/
>
> If so, maybe it's worth adding a new helper for that check ?

Yeah it's a bit annoying when skb->protocol is not =3D=3D ethertype of buff=
er.

I can certainly add a helper such as skb_eth_raw_ethertype()
to <linux/if_ether.h> that will inspect the actual ethertype in
skb->data.

It's the most straight-forward approach.

We could also add something like bool custom_ethertype; to
struct sk_buff and set that to true if the tagger adds a custom
ethertype. But I don't know how the network developers feel about
that.

Yours,
Linus Walleij

