Return-Path: <stable+bounces-203386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C13CDD0FF
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 21:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5031E300EDD1
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9C2D7DE7;
	Wed, 24 Dec 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B74IU/gS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4223372C
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766609835; cv=none; b=YSL6Mb7TxpJ5f3iXyVJshRvErWKp5XdMu2iFC41+cyfwXOtS1OxKaXgTUdlU4OygUbLJd6W3ikFUJvunxoJnscoI96hZ32NI3FLeGMck/ppLqUdoDVVmgrY88zSNnGhMNpuQzEcy/Y67htkJG6HAQNgNldkVtk5Hs1+J56FXPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766609835; c=relaxed/simple;
	bh=rR+IqKZV2+yEt+beuh5Eb/n8EB8pgnm3N+CFdB1tJLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY5054KpMO9Bf5W4rui97cGhYMVyYdBe+yqJrCCTh9ZbmZymHSevJEfjbDflHSurE4+h263zD+UjNdZCFDgLb0W4ahjDUPeobmyxeSfSlpsKWVlVXwIuIxxjdHKPI1aVn4yIFzjBr2cp1EZh+wXu0h+dMQbkTzWKDAE7Szhioqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B74IU/gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFD3C19425
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 20:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766609834;
	bh=rR+IqKZV2+yEt+beuh5Eb/n8EB8pgnm3N+CFdB1tJLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B74IU/gSHmJH1Hmz057c/bhb4otoef4wtVCACPubrkCkgNDQzf5trsmEIM9UBYFyV
	 4Ub75f5XorN/9zHbW3BWGl1H6ghaFfsIrVjcCpmFOqaw6Tw7PwsESmqKZCBnS0waIW
	 5j2wbwGJMa0XeOLcO+OyUWQhKedRwCquv56WsdTKq9ORQXoG33N0AV7qD67hlKaSBu
	 WWPV+qdw7ny8M6s3dLClw+tEn8jHVA0MvrY33up1m7RudinlqRobaG3/SKAtGLtwNX
	 AKlnp4BVwQEO9M0DzRN18I+5zn0+svenyYazmNS0Y7v/o8Kgbp1Q5rGZud+F03BeWW
	 kRsg+5R9f+4iw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fc84772abso37286507b3.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 12:57:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGXeTp1Kpk1sYjF+ZCCWxWE+JD/bJHbBCia6EC3pt2///1vqO3qatQTwqHkH2Z6izp4IQsGQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbh+DMSuNOG50bsRwcICmydvXC6z4jQNgmpQl8JHFhzLT8SpOC
	Qo64N7V5NaonCIz4iq0mP5OsDsoMs3e76224+oaxSVS/Rj8zH4lK6EVPmzNf4J01pDUmqsNrK18
	3UcCBDKIkljWd+k6Wrsl97JFfXAO4uR8=
X-Google-Smtp-Source: AGHT+IHEpiYtEfh5uCgFo5PCRn5oYZ4PTGqB7Q7v0KfaxIHEA9IkOH/CVczmtklVCspfrNJwswMetaEUvQ9VmbcEId4=
X-Received: by 2002:a05:690c:3613:b0:78f:f329:db93 with SMTP id
 00721157ae682-790077109cdmr18280407b3.41.1766609833858; Wed, 24 Dec 2025
 12:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204164228.113587-1-visitorckw@gmail.com>
In-Reply-To: <20251204164228.113587-1-visitorckw@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 24 Dec 2025 21:57:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLneTBUyMDod_fbJbuy2Y4errGQpWM3H8uVdYbKZeUNEAw@mail.gmail.com>
X-Gm-Features: AQt7F2qA9XRNnTNTTvbjP3rZWDA-LIjuIfAQFySfGMJgCMAL1iMtQNPxxzDQBZg
Message-ID: <CAD++jLneTBUyMDod_fbJbuy2Y4errGQpWM3H8uVdYbKZeUNEAw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: integrator: Fix DMA ranges mismatch warning on IM-PD1
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, arnd@arndb.de, jserv@ccns.ncku.edu.tw, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:42=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:

> When compiling the device tree for the Integrator/AP with IM-PD1, the
> following warning is observed regarding the display controller node:
>
> arch/arm/boot/dts/arm/integratorap-im-pd1.dts:251.3-14: Warning
> (dma_ranges_format):
> /bus@c0000000/bus@c0000000/display@1000000:dma-ranges: empty
> "dma-ranges" property but its #address-cells (2) differs from
> /bus@c0000000/bus@c0000000 (1)
>
> The display node specifies an empty "dma-ranges" property, intended to
> describe a 1:1 identity mapping. However, the node lacks explicit
> "#address-cells" and "#size-cells" properties.

(...)
> +++ b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
> @@ -248,6 +248,8 @@ display@1000000 {
>                 /* 640x480 16bpp @ 25.175MHz is 36827428 bytes/s */
>                 max-memory-bandwidth =3D <40000000>;
>                 memory-region =3D <&impd1_ram>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
>                 dma-ranges;
>
>                 port@0 {

This is for the *port* node and not for the
stuff mentioned in the commit message, but the port is:

                port@0 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;

                        clcd_pads_vga_dac: endpoint@0 {
                                reg =3D <0>;
                                remote-endpoint =3D <&vga_bridge_in>;
                                arm,pl11x,tft-r0g0b0-pads =3D <0 8 16>;
                        };
                };

Devoid of any reg, so who cares?

Probably the empty dma-ranges should just be deleted again, it is
pointless for the port.

Yours,
Linus Walleij

