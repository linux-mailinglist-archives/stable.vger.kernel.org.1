Return-Path: <stable+bounces-109595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E51A17A82
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493B63A3877
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3731CCEDB;
	Tue, 21 Jan 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WhyGUd9p"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5673BBE5;
	Tue, 21 Jan 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453137; cv=none; b=Bzyh/A53UlBzQeDRSlsQByiINpyHaji0+gG3dmP+Cz3zeC8s2so8wOKOjcWmNLchIka7OUEAz7HJpU5oySDZJ/RWbUpgIKdVLAK2x5htV6ePIgc7jxeJSMv3n1qka7HHfnsGfYbLXp9FLjneHZSXlSicYjSKzKp6eVaYXoVdX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453137; c=relaxed/simple;
	bh=Lk1w2u4KYqJsaUdscUcT+4KuliipN+w8wBdBQaHNcvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6GynUUouKAW6JXMVj7Jgivs4Uk2Hl5oKTw4uIKbhP6ts916quR7wjgPkz4cXvUyNdzxLrxVv50lH/XcyquMzpSvrgEyXLWP1ZyHsJ/aETyx7M+BXyP+Q6ornM2E3Y5txahcn9fW5718CB5jGks/LsM0pOAON6bXChsFXj2CSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WhyGUd9p; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67045240006;
	Tue, 21 Jan 2025 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737453133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzx+ima533i2B3erww6sRd4ZFqiY2yLhURObUkbr6UU=;
	b=WhyGUd9pED86l/r/qroagh42SkZ9qL03kPmieYraxWCFxgoqAZ+RHerMhqZFJLLOcD0olG
	jJM6Twy1SXSNSFQcOaMiOxdWSTbjWLF+KwBotiudW92Vwzm/x9Dsbh1SlP6t0UVmMjNjWD
	rm4LoCEUkgJjQXSCRiOTMmrPOXmh9ui9nLY6RiENucE0TikhuQ305/Mvvdb8xcic3sOArF
	drixxfnjJ0WhWHeXl8+BWDWannzonCsBZeu8b6h2Qt34/soktE0qHMf6llG6nWGkGLc+hd
	XIVaXlkxxNkwbiTDwDHsilmyEg0JaTFwhPf18xbXXacloU2ZJbb/IbVzNDPuBQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumar.l.rabara@intel.com
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux@treblig.org,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  u.kleine-koenig@baylibre.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob
 when DMA is not ready
In-Reply-To: <20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	(niravkumar l. rabara's message of "Thu, 16 Jan 2025 11:21:52 +0800")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 10:52:11 +0100
Message-ID: <87plkgpk8k.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 16/01/2025 at 11:21:52 +08, niravkumar.l.rabara@intel.com wrote:

Typo (prob) in the title.

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Use deferred driver probe in case the DMA driver is not probed.

Only devices are probed, not drivers.

> When ARM SMMU is enabled, all peripheral device drivers, including NAND,
> are probed earlier than the DMA driver.
>
> Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD su=
bsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd=
/nand/raw/cadence-nand-controller.c
> index 8d1d710e439d..5e27f5546f1b 100644
> --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
> +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> @@ -2908,7 +2908,7 @@ static int cadence_nand_init(struct cdns_nand_ctrl =
*cdns_ctrl)
>  		if (!cdns_ctrl->dmac) {
>  			dev_err(cdns_ctrl->dev,
>  				"Unable to get a DMA channel\n");
> -			ret =3D -EBUSY;
> +			ret =3D -EPROBE_DEFER;

Does it work if there is no DMA channel provided? The bindings do not
mention DMA channels as mandatory.

Also, wouldn't it be more pleasant to use another helper from the DMA
core that returns a proper return code? So we now which one among
-EBUSY, -ENODEV or -EPROBE_DEFER we get?

Thanks,
Miqu=C3=A8l

