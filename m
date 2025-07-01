Return-Path: <stable+bounces-159151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF220AEFBCF
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C61D3AC7B4
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931F275B1E;
	Tue,  1 Jul 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMPeiDZw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FB275872;
	Tue,  1 Jul 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379187; cv=none; b=cqLLuE9+KiasWQT5UsHCM7Ea+mGIpT68Pkdv1vVE44IuAPHvp0HYtGr0xZRBcQebtrgrUUw8xf6vdHbB14qj3fJN0soq3uo+7in85pfUqET0Sjr5jhk2B9zp0fTsQZXIDMk7mAiw+MLpmy17s44Yllnu20w97wa/EeDSP7Z1Dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379187; c=relaxed/simple;
	bh=9M0xpRMMUDO10GmTj8Q2uDokp5+yvybmx8wNOiGURkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7UfuijIAwEK2pbF5hsRT3XXO6mrndiD/iGustRYS9FPPv0XMC7ABCpQC2gRsAHnY0rymlXoXD+/q0iNFPQj85FEQbOd2ChDVKfRfIOJQNs8HPBiFKoKzNcW/Ra4OKhJR9IpTnaAPEuDZj6V+z4SrRhWRGQBjgu+zptfVE/RSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMPeiDZw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so5434432a12.3;
        Tue, 01 Jul 2025 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379184; x=1751983984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9M0xpRMMUDO10GmTj8Q2uDokp5+yvybmx8wNOiGURkY=;
        b=QMPeiDZwDKmtIQdgB+Aet4U8hEQA+kuW+KhZMSdl1EA4gtwNTAxKCnpRgV/lPfQUra
         uytkUf+E3PtBixWbs1Xyba767uxfY6zlU2ZV7LSr/VGE9DpZlaER4XDA6S0e82UqMDkB
         P/KWns5gllgLhINZXVLjfQUqcF6zmc2lKP7z8X32WLzuQ+tMwuTBdmx4Z/Ajc+rEyL/H
         zkysdKjK55LkYTATHQjg6uNcGDaj60/q9Bi2WaTFe2bb0JtWM2yA9tiWHd4+Rb6Tw6wz
         tlFnqGR9MxhIDbG9tAAST22o1UJXb9LLMvjyEqkNNbNmBqT+tXiOKAiWNNVFecanbIzy
         VLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379184; x=1751983984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9M0xpRMMUDO10GmTj8Q2uDokp5+yvybmx8wNOiGURkY=;
        b=qJNtttZGYblDPZFcim4eqE3043UuT46/Te5MPc24m6kfh57Jg+b9rCYrlmaiyr7cpm
         SoxjCnx9FhLUyplyFJokw3m9oVw96RdydYoV+r32KI5Ro9/hy1jo1nmm3HJQQdhdAZRt
         5GSktyrAPltFnv8EH03hSoK8VbFjq39VwKxbCJo5pdWc+G5vIfnVsrkwsFvDph2Ayudw
         BXmJpPB9HSVKnCADbgxKzEAzwpDOEkOjqVZ97nITUFC6Zv77NNIkJu3mKWma4CiPCvrF
         sLVog0mnGyaVn0UWZ0idNhf6DHoAAStsBGwNr294HGugkj/63hb0T2Nnkvx01U6gKLBO
         fhDg==
X-Forwarded-Encrypted: i=1; AJvYcCVCvyNYYKdsUv6vK6uxuc17PQaejdpQkKrgnXBofIUQUPfAzTxLvhWxNV4laW9RF5vd4NeA4Usy14q7qfZU@vger.kernel.org, AJvYcCWnlqc8HUkukeyMgErvAvoG/9+2Wa0qzBKX/hmCQKf7VUrC5WI+gzjb7DLYSu6WwqYxVTTapF8SeINd@vger.kernel.org, AJvYcCXfGaQv0uy3fwv9mBZTqc6LMEkv9jfGA+HWCpVdyFjddsgOjhWL0cGdRghI8uJ5iJIoXoFUimMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hNba4LbS0bcq0SLg6EmW7Jxi1kYDXClU4FcnTABgphDGqB60
	3TK6XG1vM9hYDTezax7+Nrjf2h2tBdV3R6GXa3mylZsV4ylMq+4TN22e
X-Gm-Gg: ASbGncvEfBbGdBwWjWwMBou5kPYuHG5OH/jbQzFBBOTVoD8REBlnRUnLC2OzwrgBF6s
	7I16f3kXGD7rWYjygsUnjGng7Hmgh73x8rFNJIRLSA83R/yQ6Hc1dxy5+IzmdxFWSAY//W+2RpB
	xjPClL0E1LJq7HUqlWyvaqHGMllxSOEpDJwSy62Zl9aR9gBW8K9RcYmuFdlI2/0ucLBpn+DvBkF
	28VM995J/JqiDKsP2tDNMBHEW50OHGfOp3GLtqFuwdx1a0pkBkYMj9B5wRa4CZlVBQvgt7LlJ3n
	WCvZ4re3V2VR/hnwXfIPAfgQRQ5FveW7RSsM5rSL3W8yE19pSp5p6gJKA+uI+EIsmOMirISkqC8
	4V/9Mcw==
X-Google-Smtp-Source: AGHT+IF1tB069kz6JY0KWxXptDNGH10wBVEBZiS6dvHv1zIbhdSfAx48xUxQ0wRn7sog+hmz8X53ww==
X-Received: by 2002:a17:906:6a1a:b0:adb:2a66:85bc with SMTP id a640c23a62f3a-ae3500b8e5amr1624415066b.34.1751379183619;
        Tue, 01 Jul 2025 07:13:03 -0700 (PDT)
Received: from giga-mm-8.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b369sm879228866b.3.2025.07.01.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:13:03 -0700 (PDT)
Message-ID: <b986b184f2a29bb549daeff5c84547d64341f796.camel@gmail.com>
Subject: Re: [PATCH net] dt-bindings: net: sophgo,sg2044-dwmac: Drop status
 from the example
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen
 Wang	 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Tue, 01 Jul 2025 16:13:06 +0200
In-Reply-To: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
References: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 08:36 +0200, Krzysztof Kozlowski wrote:
> Examples should be complete and should not have a 'status' property,
> especially a disabled one because this disables the dt_binding_check of
> the example against the schema.=C2=A0 Dropping 'status' property shows
> missing other properties - phy-mode and phy-handle.
>=20
> Fixes: 114508a89ddc ("dt-bindings: net: Add support for Sophgo SG2044 dwm=
ac")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml | 3 =
++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.ya=
ml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> index 4dd2dc9c678b..8afbd9ebd73f 100644
> --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -80,6 +80,8 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&intc>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <296 IRQ_TYPE_LEVEL_H=
IGH>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-names =3D "macirq";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-handle =3D <&phy0>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-mode =3D "rgmii-id";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&rst 30>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names =3D "stmmaceth";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,multicast-filter-bins =3D <0>;
> @@ -91,7 +93,6 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,mtl-rx-config =3D <&gmac0_mtl_r=
x_setup>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,mtl-tx-config =3D <&gmac0_mtl_t=
x_setup>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,axi-config =3D <&gmac0_stmmac_a=
xi_setup>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "disabled";
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmac0_mtl_rx_setup: rx-queues-config=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snps,rx-queues-to-use =
=3D <8>;

--=20
Alexander Sverdlin.

