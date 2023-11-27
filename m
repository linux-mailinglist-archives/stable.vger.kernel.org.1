Return-Path: <stable+bounces-2734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC837F9B69
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 09:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C630B20A54
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C311111A7;
	Mon, 27 Nov 2023 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hnWwTnG+"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025F138;
	Mon, 27 Nov 2023 00:13:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 904BAE000A;
	Mon, 27 Nov 2023 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701072798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gwtotMkyInHvaujAg6JsxkLZJLTKN68b8bnxHuv0oQ=;
	b=hnWwTnG+thPOUXHyN88he4IldYTntNd9L6f6v9L3Iks1J0WgsvXr8Ll6h+vfCa/fg9PnbI
	YExj33cc+qcfW/j0QNAY2xC1uTfrjghTxBAysOdZTzjZQ1GZ4/EcfSBj8Mv278IjTXsFWP
	bBlKBdsRNRJIU0AKjobDVrHDY2O1z9HiamQI5i4dB8w66D2l8cbslK1WQDVP5g9n2ah4x3
	11ZIG+ow+UBQjXq5Yrh/fmjHfUUzZIDDl1yUnZkvZCnIWX4fXs04nYMcP+sVHYi2AAVpFR
	UWJVERwmiCPzTHrpYTUFzr7rOqI8moZgy4ODFLrC17PwQyrrt80EfocAAV+7Dg==
Date: Mon, 27 Nov 2023 09:13:16 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, <linux-kernel@vger.kernel.org>, Michael
 Walle <michael@walle.cc>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: Do not expect fixed layouts to grab a layout
 driver
Message-ID: <20231127091316.5b56a224@booty>
In-Reply-To: <20231124193814.360552-1-miquel.raynal@bootlin.com>
References: <20231124193814.360552-1-miquel.raynal@bootlin.com>
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
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Miqu=C3=A8l,

On Fri, 24 Nov 2023 20:38:14 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two series lived in parallel for some time, which led to this situation:
> - The nvmem-layout container is used for dynamic layouts
> - We now expect fixed layouts to also use the nvmem-layout container but
> this does not require any additional driver, the support is built-in the
> nvmem core.
>=20
> Ensure we don't refuse to probe for wrong reasons.
>=20
> Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells *layout*")
> Cc: stable@vger.kernel.org
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

[fixes probing I2C EEPROMs using fixed-layout]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

