Return-Path: <stable+bounces-164902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB89B138C4
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151B01711B5
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2C25DAFC;
	Mon, 28 Jul 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R1m79JI1"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBE2586EC;
	Mon, 28 Jul 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697836; cv=none; b=OBCnSmcshxO7X789a6xIZUEVXyyB3pjMHVw42B4D1NUt9MqIVEqmseALHEi+szgVtX2NKnQ366yoX7RULxQzb9YDlBrbaRskkvJLNDg1IUOoBLzNMbplmmXjNtcjPoB0Jn/DqmjZNeZygtrYspHYpgSCOMfBV+2H7U/B3zyWGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697836; c=relaxed/simple;
	bh=TZmEsefxyY0xGF4MKLPq59pNiOpozRzRUKbRxdk+psI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AQYbzLog+MqkzPHdBjUSkFS/EsZeT90zVLqoeTuyq5qpJy16BVuXMG4JG6RHFskFvEe9NLPgPyuJo5ssfnnOzQjSwQzcqYkqQy6RCNx+4iFuSQzcvBle88gcc+pBkTkbhLmencDM0MbWUk/uF65wylmJyHJjM0gPFIZaxAgjn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R1m79JI1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7512431FF;
	Mon, 28 Jul 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6Z+Z6Ihro2Vvf1ko6ncjYpOQCSv1nCFxoBgIgd+GJg=;
	b=R1m79JI1SGaeAfFCTyg4t8XnXnmjOiGBLC07lmLpS4FOrmIBZbqMtM6mYS9MuWPxOY4m6g
	IqV1bimS1WcruMsW+8RkiU782hmnOHZFWNF7yT5FbHuClu/JseugmE6ifHFreU2dE/wWEg
	wikesA4HWd723havLjdjgXEXU8BYJrmDGfWht+7ILF0G9hRg8GfDMoYSxgeY0PajDhEJn7
	+dqp81tNRXfcLAqg/FSDa9A4mRkp4yrYnvMFbKk7/bdKrjjO2LAqfzXih9VUmAkfY3hmB1
	iqTOsT4PKbIYA8KwvtKEpvXXbT1ZrCvZRXZOcykHvbflB5KKG4eePy8y1kXlPg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Alexander Dahl <ada@thorsis.com>, Boris Brezillon <bbrezillon@kernel.org>, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702064515.18145-2-fourier.thomas@gmail.com>
References: <20250702064515.18145-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error()
 address
Message-Id: <175369782562.102528.1752000425924545922.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:05 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtp
 hhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrght
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 02 Jul 2025 08:45:11 +0200, Thomas Fourier wrote:
> It seems like what was intended is to test if the dma_map of the
> previous line failed but the wrong dma address was passed.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: atmel: Fix dma_mapping_error() address
      commit: 9e2e2576bc49c3bc352d402963f7ba8774c3d95f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


