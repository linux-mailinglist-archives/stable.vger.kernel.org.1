Return-Path: <stable+bounces-112125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C26A26E02
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853363A815D
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5F207E0B;
	Tue,  4 Feb 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JmN3oXND"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100EE207DF3;
	Tue,  4 Feb 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660632; cv=none; b=cpgHMXWU6CVdfZlUnsCdqUgKmL7Xh6MaNQ4cSSyLqR3bdFbtCZ1dJNb+Up0uuT6E1fScLwLDhhhxUO8drwFxumdavu+cfMHT7eQpBLED4iBkUkx3wf98g5zqfoZkApRGfTr+yYQRAvWKfIP42PO21nf4TK/lgJT2/1b2mWUdADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660632; c=relaxed/simple;
	bh=y9GGHVMrT+wr9M3JQKeJwZtW6ZJrbYAOXJSnkKp+/7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdWBZ3jdfsKSrvXNbbjoY3pyFxKBLAQ1Ap5Xn4xR3FTNwuZgyQn3AV14KgIl0lv6gN9iOcZEjV+jlLuQNDsJ4MXQvvqRnAPMocfc5DjhBuAz/aJSvYrNubAxsT/4kMQ6w0YBccZYaHgw6uF8zK55YO8d+gRJbNixUcJc6loBQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JmN3oXND; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C70A433EE;
	Tue,  4 Feb 2025 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738660628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Pf++fNZ1y9QMLFR6ETO34MAg1FfYx4Pu5f8G7fuOM=;
	b=JmN3oXNDLKbEPH2wPN7l6KyhmKxUJUkMe0agLNer0Od+ffjgyCjaBAQ5InH4bCM6hFNWFT
	dVJdrad0rCVH53cEkcfrJGcNHAFYM5OKRAzhtrCaegXPMUS2Clq+d2rl5vedUhj9cVzOPz
	oBY3CMu0sx00S5iZiaLW47YyDfKCGnr4iRBsaSM/hwS0LtMB95uTOUWCY7/oEyEtV1brgs
	z8vukh291L6GcDbg7vn+LdU3LYLIhNApEcwTgEETh2mguj0QIPlbp1t/L1gzDVkSb+R/k7
	dgUbsHm4FM4zekKsshDTKf2oQqRl5sB6kIbNU8B2FvMyojalRtHOTd1tTf87WA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: christophe.jaillet@wanadoo.fr,  gmpy.liaowx@gmail.com,  kees@kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  richard@nod.at,  vigneshr@ti.com,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
In-Reply-To: <20250204023323.14213-1-jiashengjiangcool@gmail.com> (Jiasheng
	Jiang's message of "Tue, 4 Feb 2025 02:33:23 +0000")
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
	<20250204023323.14213-1-jiashengjiangcool@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Feb 2025 10:17:07 +0100
Message-ID: <87wme683xo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepjhhirghshhgvnhhgjhhirghnghgtohholhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtohepghhmphihrdhlihgrohifgiesghhmrghilhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhin
 hhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> --- a/drivers/mtd/mtdpstore.c
> +++ b/drivers/mtd/mtdpstore.c
> @@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct mtd_info *m=
td)
>=20=20
>  	longcnt =3D BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
>  	cxt->rmmap =3D kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->rmmap)
> +		goto end;

We prefer to return immediately in this case.

Also, any reasons not to use devm_kcalloc()? This would be the correct
approach as of today as long as the lifetime of the device is known.

Thanks,
Miqu=C3=A8l

