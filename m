Return-Path: <stable+bounces-145683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72FABDF34
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01573B0E1F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DF254AE9;
	Tue, 20 May 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XhrodVPK"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297825178D;
	Tue, 20 May 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755306; cv=none; b=q1vj9KYT+nMn/d0FFvFgByw1NUR3Yng1hAous2FFsLmCGpfMeEnk+FUeXwCgl8dgsufiuhjcIkCyzD6t+YlFtLMBaPsqUmseS5oiSUCXP1l5QEsk9GXrEC2wnBys/3RAN9IeBRYVckR+MlhQTur3OztoDoHxUd7ay/S25pZ6adg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755306; c=relaxed/simple;
	bh=gUNOhEGntnSAatTzlVRx2gBmPImDzhBCIlG3OB0w+dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oDy43HhK1GgxVHn9CGtafSOYOzpNTAO7XzFQ1MknVJ95XsV7Eb15w3kz3cUcsmeZREhQM4yTVd3qmoXqtYQ9eK0ZqyBTIK+0hnNrilAwTloOqzUJYKRsDR6GtZj+cOoCkZ7F0YjLUGX5qIvYVTYkNtJ89IJx/WFShPHcfuoUiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XhrodVPK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB11A432FA;
	Tue, 20 May 2025 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747755303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtli7qrKdDqJDEKpaUtEPgLih8RTCPqJd1HrwnUKnAs=;
	b=XhrodVPKe2Da9aIjEgLFROZaIR+dwQscLhUZdqThMEllrC+kwxvD/y1Ytxkw22DIKBtpTz
	tcwo6aIfjMlt3QLRhhq6b3/9Ywaw5w4uP2D1XY2coO245jfBFW8oAWFNhgZppstOgIDOEj
	CXqtM1lv5TzvzC9XHKLtzGR0/mo3YgITipMR8XBuFzEg5yS4R+zMoTLS/Rx6N23vGFUklY
	UzUnfAbv49s8IJwrPyRh2QusLZaoJC+y0JpahMcQyvrh1RZ/xYEgcVTvZmZTpYbTCIxU/p
	fvEGxxolSE4tbmX1icEJcTcnjhjv7SHw0CsGnePan6FDrAglZREa0z3B6Rt1Uw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, wens@csie.org, 
 jernej.skrabec@gmail.com, samuel@sholland.org, ruanjinjie@huawei.com, 
 u.kleine-koenig@baylibre.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250519154225.2928-1-vulab@iscas.ac.cn>
References: <20250519154225.2928-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: nand: sunxi: Add randomizer configuration before
 randomizer enable
Message-Id: <174775530075.689292.3024700439135563644.b4-ty@bootlin.com>
Date: Tue, 20 May 2025 17:35:00 +0200
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnf
 hhrrgguvggrugdrohhrghdprhgtphhtthhopeifvghnshestghsihgvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhunhigiheslhhishhtshdrlhhinhhugidruggvvh
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 19 May 2025 23:42:24 +0800, Wentao Liang wrote:
> In sunxi_nfc_hw_ecc_read_chunk(), the sunxi_nfc_randomizer_enable() is
> called without the config of randomizer. A proper implementation can be
> found in sunxi_nfc_hw_ecc_read_chunks_dma().
> 
> Add sunxi_nfc_randomizer_config() before the start of randomization.
> 
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: sunxi: Add randomizer configuration before randomizer enable
      commit: 4a5a99bc79cdc4be63933653682b0261a67a0c9f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


