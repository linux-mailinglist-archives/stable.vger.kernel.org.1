Return-Path: <stable+bounces-194581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74064C517E5
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBF4FFBC1
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748052FF641;
	Wed, 12 Nov 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MHTwpDBM"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCC220F5C;
	Wed, 12 Nov 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940152; cv=none; b=TzKkVDuiCVNPZ5XqywHZO7sUxRf27d5QGmhj+DPpz7IDlQ5Hrwy2REmkK1Swek/KLNi73sQDmcKpsck0b63AVaLGlNccYK27auUHZIjuGrXidSG/6sscIzYsgf4bu2yvjM+yraOsFo/cjEQ5LShlmCrEshxfOAywSTY7gBpVJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940152; c=relaxed/simple;
	bh=mOhYAfyZJXObBAlUuqFf5cqWZP584nGbA1qnqY/jENo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jygoGmDlAh22plIelqIyUAfJ5Akac+TDUmVj518zr3r5ifGzSf3k3uMmJmGI+WfsghpiPiQtN+G1GgZxiZVD+ytVO7Iob/Qo2UXQ48ua4QBYzgZOc/ahUfB3Vto7T72imBXMVbAkCp8iEvuZbsX36ncqa+DYxaUtvq0garybRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MHTwpDBM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6FA6A4E41667;
	Wed, 12 Nov 2025 09:35:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C1826070B;
	Wed, 12 Nov 2025 09:35:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44CCF10371994;
	Wed, 12 Nov 2025 10:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762940145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mOhYAfyZJXObBAlUuqFf5cqWZP584nGbA1qnqY/jENo=;
	b=MHTwpDBMupQjAo0xVtrzcgSV2ZEjdgeU/HQTEmzFg2noc31N5zwmtWlnIxjO7o9aOIudkn
	hl4GsY8QHPAVfGu3EFqT9AatA+xLg7yCmGZBH9kadUPB6I1Nu+tUtWGGU5zsbShfPaUu+G
	1G+/32eSuyvuMyNdoclohz9VGa1Ni4FgjDz5MkPVBiJ2T50NYUr/yg2B9Tj+kc+xwrmdrG
	FJ4p6GK5eQuYtN9iuKXNg1MsUrwfzMGO1tbQcjpeSTuuU6NwkMxSlw68iGQ5na4KoxdV6P
	aL7gBbOnCruimGGFhEud53EQb6ud+4vNiLp5THrTgIvJHstFeGCIwqlruc8vkQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <STLin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH 0/6] Hello,
In-Reply-To: <c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org> (Tudor
	Ambarus's message of "Mon, 10 Nov 2025 08:54:24 +0200")
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
	<c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 12 Nov 2025 10:35:41 +0100
Message-ID: <87seej7fv6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 10/11/2025 at 08:54:24 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> Hi, Miquel,
>
> On 11/5/25 7:26 PM, Miquel Raynal wrote:
>> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
>> these chips is needed otherwise the block protection feature is not
>> available. Everything else looks fine otherwise.
>
> I'm glad to see this, you're an locking expert now :). Do you care to
> extend the SPI NOR testing requirements [1] with steps on how to test the
> locking? There's some testing proposed at [2], would you please check and
> review it?

Good idea. Let me have a loot at what Sean proposed.

> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-r=
equirements
> [2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff17=
1@linux.dev/

Thanks,
Miqu=C3=A8l

