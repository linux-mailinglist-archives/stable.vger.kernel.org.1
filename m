Return-Path: <stable+bounces-144516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B0AB851F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85395172DC7
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064BB298241;
	Thu, 15 May 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="geJHtel/"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4626AD0;
	Thu, 15 May 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309450; cv=none; b=fATB9+YNk/lZdWH7MsdSVL7jl/xgZkOpU5lmAXrSqsGUC1GtTXuMLKMKUGsiZ+cdwpN0WcveBsc6R/LZPCOkh9vUgGTEDCnkFZ/dRyA3WjLTRjAsUZt/9C9hNAcGTOCGmlKy+Qw1X8S1TZwkqSUz5PiGJz0Jc5m64sPeV3ZpTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309450; c=relaxed/simple;
	bh=2H5KIqNQmBmyDV57fqFZKvELSZdXowmg5XqoG7ZDEIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkatl/wiUWH/JPOGID4arqTs7HP10wOP3dZA53dUg7RhBlTkg6g1JZVF3QkyMhy0MAziDabtzVq4TA2fJRyZUnIwaMlOkN0amrQIDJGE8ElsBEENxMFOoOkezrj3tHJ0o4hADGOe4BxuZdT+GT8T/CeRRLdnWnLKlqBzlMS1J2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=geJHtel/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4EIg5oOs7ULbz83N09ZfXxoK0Xg+DnktC4ZDSGogzJ0=; b=geJHtel/NTEFLCETukj4rEru8f
	DTcZfviPipN15Ne5XDBQH8OUbGglWEzeo30JTmc/NxYBd8B2Jwg8Z/YMY2mo32dq6LSJbjG4ZHShg
	zAYen0uU7oRU1wdt+XxzqVn9F3dQhLqF8lGawb/3OV2F7wpAXttMVVieGreabNCKeuB/UlmrUrGKG
	rTkkNogBaE54a2XY0j95OxPeMmyOxcdC4Cueiy5aSACulINIA2cd2msTbgKF7YcSPRVfpVvBcNqmD
	a04Hn7lckIgU5AdmUTdV7BGlD6jNOOkwCsI4NacH0Mk0v7WF42ooxarWhvnl0/fc5TUjl5i1S4D5e
	wiQIqPUg==;
Received: from i53875a50.versanet.de ([83.135.90.80] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uFX0K-0003eK-ND; Thu, 15 May 2025 13:44:00 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH v2 2/5] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Date: Thu, 15 May 2025 13:43:59 +0200
Message-ID: <3784948.RUnXabflUD@diego>
In-Reply-To: <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>
References:
 <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
 <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 25. April 2025, 17:18:07 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Lukasz Czechowski:
> The Cypress HX3 hubs use different default PID value depending
> on the variant. Update compatibles list.
> Becasuse all hub variants use the same driver data, allow the
> dt node to have two compatibles: leftmost which matches the HW
> exactly, and the second one as fallback.
>=20
> Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3=
=2E0 family")
> Cc: stable@vger.kernel.org # 6.6
> Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: us=
b-device: relax compatible pattern to a contains") from list: https://lore.=
kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f=
14e800@cherry.de/
> Cc: stable@vger.kernel.org # Backport of the patch in this series fixing =
product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c dr=
iver
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Looking at linux-next, it seems like patch1 of this series was applied [0].
The general convention would be for the binding (this patch) also going
through a driver tree.

I guess I _could_ apply it together with the board-level patches, but
for that would need an Ack from Greg .

@Greg, do you want to merge this patch ?


Thanks a lot
Heiko



[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D9f657a92805cfc98e11cf5da9e8f4e02ecff2260

> ---
>  .../devicetree/bindings/usb/cypress,hx3.yaml          | 19 +++++++++++++=
+++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Doc=
umentation/devicetree/bindings/usb/cypress,hx3.yaml
> index 1033b7a4b8f953424cc3d31d561992c17f3594b2..d6eac1213228d2acb50ebc959=
d1ff15134c5a91c 100644
> --- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
> @@ -14,9 +14,22 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - usb4b4,6504
> -      - usb4b4,6506
> +    oneOf:
> +      - enum:
> +          - usb4b4,6504
> +          - usb4b4,6506
> +      - items:
> +          - enum:
> +              - usb4b4,6500
> +              - usb4b4,6508
> +          - const: usb4b4,6504
> +      - items:
> +          - enum:
> +              - usb4b4,6502
> +              - usb4b4,6503
> +              - usb4b4,6507
> +              - usb4b4,650a
> +          - const: usb4b4,6506
> =20
>    reg: true
> =20
>=20
>=20





