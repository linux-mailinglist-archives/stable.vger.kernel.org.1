Return-Path: <stable+bounces-146335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE0AC3CEF
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28F11760F6
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CEB1EDA12;
	Mon, 26 May 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aPapo4hO"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0BC1DF97C;
	Mon, 26 May 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251916; cv=none; b=ip6oQHnYj13gm0e6kpyIwOrxrwtw4U16G19MIzUxBtdxJEW0tw0q5QqvZu3xvejpcq5I3pW+bTBIPF9VTiT4R+no9vGoT19JonGaqYJvstNHDbp29v1fGTUaOCyAweGZRyMR2vNFg+AuVeS24QqHAqf2sxPoqIXcjeOv6t2jZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251916; c=relaxed/simple;
	bh=nEnZXS21luBxBukdlYNpkDBZ/dd9/QrJOo9L6XL2dJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFlu0cxO9idasFGjSgd+uVJXYoaiZW3R6SKrc4qQervRQrVGGLdyBbnUzxe0GiEPlDVBp9UubqIa5pQE4cE7Dn+8jXKz8qpdqTDMYUVzRSZFS9YcHACRQAASmQ5+kclkCxJojTdlRml8/dnwyLWIqLDfnAnO7o6keblft88BjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aPapo4hO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 406AD433B6;
	Mon, 26 May 2025 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748251906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/ZZTG2q7hLM3GZrcupIxllRxvC3z0wIhPiqMbFVFDg=;
	b=aPapo4hOvLjoEd66BIkA1dN4XiHOGFqdSVXpM3loHuOVl3pSD0unXcrWWA3fVyjd/4bUYi
	Lop5M09S/nBAzIH7xe+RPoFfpRXaInKFiPKzvhd0bawG3B+uoMMxZ0d9TqT73I5LTtnD2u
	9ziR6MYLBMB59L83vuLT3V11TJqiZCt8d6gk38yJlwz0l/TV/yFrNBTdqQyznw7fRuClVY
	F1Y5nmyQp78/YVeEwhhWIilpyJD7IoeoIMFH5kmq+mbOHuVe8XNgePIv7xz03qy/hRK/vx
	NWG43ivHn85uB3NbW3MrdP/zX/wg6ujySE0ttHMWcTFRTbgvKHHnpohQlefNyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, wens@csie.org, 
 jernej.skrabec@gmail.com, samuel@sholland.org, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: ruanjinjie@huawei.com, u.kleine-koenig@baylibre.com, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20250526034344.517-1-vulab@iscas.ac.cn>
References: <20250526034344.517-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: nand: sunxi: Add randomizer configuration in
 sunxi_nfc_hw_ecc_write_chunk
Message-Id: <174825190312.1028286.17391612651322284901.b4-ty@bootlin.com>
Date: Mon, 26 May 2025 11:31:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeduieculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepvhhulhgrsgesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrght
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 26 May 2025 11:43:44 +0800, Wentao Liang wrote:
> The function sunxi_nfc_hw_ecc_write_chunk() calls the
> sunxi_nfc_hw_ecc_write_chunk(), but does not call the configuration
> function sunxi_nfc_randomizer_config(). Consequently, the randomization
> might not conduct correctly, which will affect the lifespan of NAND flash.
> A proper implementation can be found in sunxi_nfc_hw_ecc_write_page_dma().
> 
> Add the sunxi_nfc_randomizer_config() to config randomizer.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: sunxi: Add randomizer configuration in sunxi_nfc_hw_ecc_write_chunk
      (no commit info)

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


