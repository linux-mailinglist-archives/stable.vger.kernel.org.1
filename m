Return-Path: <stable+bounces-192584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C52C399B4
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 09:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28DB74E3589
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BC308F28;
	Thu,  6 Nov 2025 08:40:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123213019A3;
	Thu,  6 Nov 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418407; cv=none; b=rfyjFOHnOVDoWriFWSbEXutfsZ26FYPFaxowC/noUHACzJn3fO8un215+U9fLWzU8UIApvFGL8XhXSe8TJy4AIfqjiu/3WMPb3FgV/emDr0qjSVKurfcrO1UiNS36MSKseKDg9p5LuovHVfQAwIyLIn5v5PnljUr2MMbb8MJ+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418407; c=relaxed/simple;
	bh=CoMHpoUt4t3B8Wg7YF44ApjLkEw8IhP7xtMxZIucOQ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=a7fv1KFtEIf2w2jEVybRd7N0a3uExd9DrIppdcxt90d1CHjX15B2h1DodQE6tAaEL6bxEDiKjtfOkHtqfhHJ2+zPYfajUyYlVyaPUyXc+joTfHnXQK4QUVgFdkIzP9cQRS8RaSqS9d33iqwlh/H4Zj4GLOQZTDy8h7NBI3v+HNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 579487D6;
	Thu,  6 Nov 2025 09:30:08 +0100 (CET)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 09:30:08 +0100
Message-Id: <DE1GYZRTAAD7.1VHWUNF8N9RBZ@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
Subject: Re: [PATCH 0/6] Hello,
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Steam Lin"
 <STLin2@winbond.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>

On Wed Nov 5, 2025 at 6:26 PM CET, Miquel Raynal wrote:
> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
> these chips is needed otherwise the block protection feature is not
> available. Everything else looks fine otherwise.
>
> In practice I am only adding 6 very similar IDs but I split the commits
> because the amount of meta data to show proof that all the chips have
> been tested and work is pretty big.
>
> As the commits simply add an ID, I am Cc'ing stable with the hope to
> get these backported to LTS kernels as allowed by the stable rules (see
> link below, but I hope I am doing this right).
>
> Link: https://elixir.bootlin.com/linux/v6.17.7/source/Documentation/proce=
ss/stable-kernel-rules.rst#L15
>
> Thanks,
> Miqu=C3=A8l
>
> ---
> Miquel Raynal (6):
>       mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ chips
>       mtd: spi-nor: winbond: Add support for W25Q01NWxxIM chips
>       mtd: spi-nor: winbond: Add support for W25Q02NWxxIM chips
>       mtd: spi-nor: winbond: Add support for W25H512NWxxAM chips
>       mtd: spi-nor: winbond: Add support for W25H01NWxxAM chips
>       mtd: spi-nor: winbond: Add support for W25H02NWxxAM chips

Nice, for the whole series:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

