Return-Path: <stable+bounces-194810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A244C5EC1E
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08BEC4EA69A
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282552D3737;
	Fri, 14 Nov 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iIPnDU+P"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C902D0C79;
	Fri, 14 Nov 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143170; cv=none; b=JP6398TQVCBC3QEPvWhKPfH0qzMHOIbWNb+8ZUyGoxVBvAlqqKzUgx0vy6buNnqYlwkeJv0ec3KxCDwXhVs1+a86CSRpioRT6Utg/ypMSssK6E+mBTso+cF8fIpsU9jch0YYEk+3Th0G9783eUJbNBNWAhbaKRAMljugVmBNiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143170; c=relaxed/simple;
	bh=fxjWDAhiGHIrVKLLyLpbURlJYUa6BNAAgnVyv9OknRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHkoxfL1lWvKepo9Dsvg/p8UN0NWmmifMxknukJrQApQK76x7JInJOqpnhPclkLlblGOG6VleafW/4YYNrXD3KkxMTpMA5fVN9EoVug/c6JaZm9SSxC1rjVBOa6qpLUKe4KymKu3y6r+wFLXGh1eSQYGEQbJvpHlRbIV4neCKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iIPnDU+P; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ED8E44E416B7;
	Fri, 14 Nov 2025 17:59:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCADA6060E;
	Fri, 14 Nov 2025 17:59:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D669010371986;
	Fri, 14 Nov 2025 18:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763143165; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fxjWDAhiGHIrVKLLyLpbURlJYUa6BNAAgnVyv9OknRk=;
	b=iIPnDU+PQvTIZXo2LQIOxf7xD2nkQCD43UWa4+76C7nwGK9jKpu9ztiU2skBZ4QQ3EBY3L
	a7L7A8tUNUzvhWOg1679p7fkLJBh4GtW1Hc4o3ifz0LyPx38Ku0o8BDUfGw60sgW2wt5RB
	Ba2sm6xPkM6wsYA/231uV0Z5XfVQdRBSBjEk1xyZdCfSt+AzM0DG+gA/3hTpZcMVDQLkVs
	2paG4XG5sB3b85khCTa+WwhS6Af06d+PFtT82AXaS7B45RjljtQghrlNdGnlwzGcCca0fb
	Ix1AX/MURbJAR4FXTzHV3ikxya6QyaC2VxPaMxqN+GS6OwInmG6Vs/LjXjMThw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH 0/6] Hello,
In-Reply-To: <8a370764-e093-4987-9a5f-3a8c1d6d900c@linaro.org> (Tudor
	Ambarus's message of "Wed, 12 Nov 2025 11:37:38 +0200")
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
	<c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
	<87seej7fv6.fsf@bootlin.com>
	<8a370764-e093-4987-9a5f-3a8c1d6d900c@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 14 Nov 2025 18:59:21 +0100
Message-ID: <87a50ofqbq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>>>> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
>>>> these chips is needed otherwise the block protection feature is not
>>>> available. Everything else looks fine otherwise.
>>>
>>> I'm glad to see this, you're an locking expert now :). Do you care to
>>> extend the SPI NOR testing requirements [1] with steps on how to test t=
he
>>> locking? There's some testing proposed at [2], would you please check a=
nd
>>> review it?
>>=20
>> Good idea. Let me have a loot at what Sean proposed.
>
> I proposed to him as well to update the testing requirements if he cares,
> he said he'll take a look. Sync with him please.
>
> Cheers,
> ta
>
>>=20
>>> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing=
-requirements
>>> [2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff=
171@linux.dev/

For people who would like to follow, the proposal is here:

https://lore.kernel.org/linux-mtd/20251114-winbond-v6-18-rc1-spi-nor-swp-v1=
-0-487bc7129931@bootlin.com/T/#mbae8b874181eb0401b30142f423b73b6389a0c54

Thanks,
Miqu=C3=A8l

