Return-Path: <stable+bounces-54863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A8E913304
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E00B22881
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562614C586;
	Sat, 22 Jun 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="JaRhq48u"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAA2904;
	Sat, 22 Jun 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719052723; cv=none; b=UVorRo5Hoc2163ZLmTjpps+9OyXpBpmeVLhrQRKlHRO0L7qxLS2cQFK0oUCrJhyGyrwMHb/v3x2X9eDTSeftiTOMHQ6BbhGt7jeQ7CuQftYZBI99FvLhMqZv57cLEcstEBSqPTvYg4jVxikS6Uc/p04sGE31+lh+0FbcCjVMIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719052723; c=relaxed/simple;
	bh=qTOdE4y2/U88BQz4TGUQzDIn5dUSVYCYoDEAoKcfkGM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qg+sjculoltxtMF7JGuaFGcp9yB4SQwLH7/vYZTc5xhEOCRNLSmq8UitsvMKxK7H1nmNlTHx3CIcqttovGpzM45D2UhaEktgtjiimtEkH1DZbRvj/Eg3pxHukpRpHaZNOeQWwjhreJJzuEf7j7xALSKz2kqvD6KXbx0vSpNfr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=JaRhq48u; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1719052716; bh=qTOdE4y2/U88BQz4TGUQzDIn5dUSVYCYoDEAoKcfkGM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JaRhq48uKXWk85Ki60Kv3iRfjprZElu/MT6jOHYh+X71my/1p1es+BaHYnZKt9wW5
	 OX4Q0OF1RulY6DCgrdpp20WDhesnG07k/aL5IZZ1PwhMtVNajTG1CnLmdZmVFw1Mg3
	 YY/f1j8xdY5IGMv5zQZdFF/LeAgqSC3VyJ6S8g+M=
Date: Sat, 22 Jun 2024 12:38:34 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <8d8387d3-e0a2-4fc7-ab46-d099c43935f0@t-8ch.de>
In-Reply-To: <9af37f6c-cd44-4a57-8a34-969e23b0342f@linaro.org>
References: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net> <9af37f6c-cd44-4a57-8a34-969e23b0342f@linaro.org>
Subject: Re: [PATCH] nvmem: core: limit cell sysfs permissions to main
 attribute ones
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8d8387d3-e0a2-4fc7-ab46-d099c43935f0@t-8ch.de>

Jun 22, 2024 12:11:04 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:

>
>
> On 19/06/2024 19:09, Thomas Wei=C3=9Fschuh wrote:
>> The cell sysfs attribute should not provide more access to the nvmem
>> data than the main attribute itself.
>> For example if nvme_config::root_only was set, the cell attribute
>> would still provide read access to everybody.
>> Mask out permissions not available on the main attribute.
>> Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> This was also discussed as part of
>> "[PATCH] nvmem: core: add sysfs cell write support" [0].
>> But there haven't been updates to that patch and this is arguably a
>> standalone bugfix.
>> [0] https://lore.kernel.org/lkml/20240223154129.1902905-1-m.felsch@pengu=
tronix.de/
>> ---
>> =C2=A0 drivers/nvmem/core.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index e1ec3b7200d7..acfea1e56849 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -463,7 +463,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_d=
evice *nvmem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "%s@%x,%x", entry->name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 entry->offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 entry->bit_offset);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs[i].attr.mode =3D 0444;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs[i].attr.mode =3D 0444 & nvme=
m_bin_attr_get_umode(nvmem);
> Why not just
> attrs[i].attr.mode =3D nvmem_bin_attr_get_umode(nvmem);

Because nvmem_bin_attr_get_umode() will include write permissions
if the base nvmem device is writable.

But (for now) the cell sysfs attributes do not implement writes.


> ?
>
> --srini
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs[i].size =3D entry->byte=
s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs[i].read =3D &nvmem_cell=
_attr_read;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs[i].private =3D entry;
>> ---
>> base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
>> change-id: 20240619-nvmem-cell-sysfs-perm-156fde0d7460
>> Best regards,


