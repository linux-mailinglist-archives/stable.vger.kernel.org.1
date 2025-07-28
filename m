Return-Path: <stable+bounces-164900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEFB138B9
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E0188F663
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92E255F57;
	Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gfNVx2aE"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746D220F38;
	Mon, 28 Jul 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697833; cv=none; b=F8HEFtGDKOknbs2s33nkiks28oMgU4iaCYOVe8SgI8FLSObQIUMaH4n9vpqvmtV7LRAiyOgsY7I2GvQDlm8ZgDVkK+gyhy7vww4jWdpvPd5Kl4sRCJhVgbiYO/8d5/vfC8u0bvveLx19D2gdCnoS0xlXYQUIKkvHkqKlU54OsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697833; c=relaxed/simple;
	bh=93OUSAsdiEU+Lbz5o5xq9Ulb4QwpwChWYeReHfx1RA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HEVFWFp3o+Ehj6KI7cBMBSnXgE5n+DNk+04S+uveZtQU7SBUv0Fc7Tx2E3ZG8Mo9buq1frParqinhn/B1NELv0WwzMYSbOmM3hmgzmPeBY4m0nJBulB/DUcvbHRnq5Kqs1/bDJ98M7McAImn2KkwzIaW3YOc1V6CuDMJm2BADJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gfNVx2aE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E11B44329A;
	Mon, 28 Jul 2025 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pboHQ9RcvBOP/wjmFACMKjqT7sFHUCrx35OKtpXAyO8=;
	b=gfNVx2aEAmhGmeroxZz0+RRhTArWPK2eT7Ya6u47qy0KW7qlHfusv5OsGxUFx3yi+MSu/w
	EM+wJBA9CzO5Zrgkbqr4pwjjufn3PNhodvxuyG9hhaJNZvrsPs38OlzsTJ82xXv6hpfRr7
	GEj0Dd6lhPpHTv94mXav7aE/0viAE7qBGD+FWvo2Z1VYWqarWj1B8y9Elf3Qa7ezoXk7CP
	M5ryeRD7UbO2ZaPfIym+2gxjPZWmYvZR6LaAyodXBtCXD+5xlrx4GXG3SU/5xCMqS2ZyI9
	E811zNKaPML2vdCFV6uzOXvKn5c3oVMt/ezVBQyzCVb8YnLs1f9zfYpDX+QgZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250708-spinand-propagate-wait-timeout-v1-1-76f8c14ea2d7@gmail.com>
References: <20250708-spinand-propagate-wait-timeout-v1-1-76f8c14ea2d7@gmail.com>
Subject: Re: [PATCH] mtd: spinand: propagate spinand_wait() errors from
 spinand_write_page()
Message-Id: <175369782886.102528.14496009254436108539.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehjgehgkeihjeesghhmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 08 Jul 2025 15:11:00 +0200, Gabor Juhos wrote:
> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
> logic") the spinand_write_page() function ignores the errors returned
> by spinand_wait(). Change the code to propagate those up to the stack
> as it was done before the offending change.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: spinand: propagate spinand_wait() errors from spinand_write_page()
      commit: e4c896ce424a4aa248c1784c5cef9ddd0e4900fb

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


