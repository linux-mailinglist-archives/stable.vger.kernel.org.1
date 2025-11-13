Return-Path: <stable+bounces-194670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D119C56A94
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF153346A43
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680722D63E8;
	Thu, 13 Nov 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qRdW/brx"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0142D7DC4;
	Thu, 13 Nov 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026946; cv=none; b=WgoM9qgf4N4vm2RBZ96RtK5rNpv/Lff2cBaSsdoKkJ252VJLNUfqIMHmmjTC2i6XpotNpdr/tm1FEEqlBhxe2dm+uMx7W+SpsC43Evpdgiz99Kp7P3ohdJWbe+G5P+r568UJVNpCSy7p6XUNMtP4smuyRxmH9S3LTiuo+mD1f1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026946; c=relaxed/simple;
	bh=sNqs3FP+z5pIzH1Qj0HoESAdOO4RLvu2LM8P11JAub0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooRoOLvAMmZ5BTBSt/0lZWzuQuJ4lQhyI5407pIE8R3Mli2bvmKdLbr6dZJYXNBZU+KbN9MnOG99XQUV3dEgbmLPUE34cJqIR1JKcA0jL/c1WMtxijPRplLWBCuN7dBg0OKtmQCgScdg4C0+IUYh9tP9HMxhgkku0eUQLP8jLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qRdW/brx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8DEBF4E4167F;
	Thu, 13 Nov 2025 09:42:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B66B6068C;
	Thu, 13 Nov 2025 09:42:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3A54102F21A5;
	Thu, 13 Nov 2025 10:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763026940; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sNqs3FP+z5pIzH1Qj0HoESAdOO4RLvu2LM8P11JAub0=;
	b=qRdW/brxLaDrAAX5eLMUKNF0WYNOIVPrQnukcfi2R01MsrsycSX4IxT1g9P+4hVrIp1ZJc
	Zv2F/1W3JvJZBM4YGP/okOFx/vEKRY0XN4xZosiCk4mTtt8OHdoqA0PU72yBEs85//qAbO
	P/BOAYfgu3tOGWlHnJCMBMu55DIxiwp5awYgJOi1mc5j8Ea4sJ3eI3Dy/kVN1Q0R6NAPuN
	M8el5J554pldmuFjEKZ4azBrbseLsAinXffXJVi3PKzHwcwrS2RRrbShAk2PN/arlgjdSJ
	kWLPCB19+v0aRhrg10+e4TiB72R/nfXt832xjqfR3ADu2igz0/cFiDUJW60mQQ==
Date: Thu, 13 Nov 2025 10:42:15 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Davis <afd@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones
 <lee@kernel.org>, Shree Ramamoorthy <s-ramamoorthy@ti.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] mfd: tps65219: Implement LOCK register handling
 for TPS65214
Message-ID: <20251113104215.7da3b846@kmaincent-XPS-13-7390>
In-Reply-To: <454220b7-81cc-4450-812c-06bfbe527ee2@ti.com>
References: <20251112-fix_tps65219-v4-0-696a0f55d5d8@bootlin.com>
	<20251112-fix_tps65219-v4-1-696a0f55d5d8@bootlin.com>
	<454220b7-81cc-4450-812c-06bfbe527ee2@ti.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 12 Nov 2025 13:03:22 -0600
Andrew Davis <afd@ti.com> wrote:

> On 11/12/25 9:14 AM, Kory Maincent (TI.com) wrote:
> > The TPS65214 PMIC variant has a LOCK_REG register that prevents writes =
to
> > nearly all registers when locked. Unlock the registers at probe time and
> > leave them unlocked permanently.
> >=20
> > This approach is justified because:
> > - Register locking is very uncommon in typical system operation
> > - No code path is expected to lock the registers during runtime =20
>=20
> Any other entity in the system that could re-lock these registers?
> How about low power modes or other PM handling?

No there is no reason to re-lock these registers. It will be locked again o=
nly
if the PMIC is reset.
In any case, if one case appears that needs to lock these register (even
if I think it is unlikely) we could come back to the regmap custom write
design.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

