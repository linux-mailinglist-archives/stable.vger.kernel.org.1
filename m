Return-Path: <stable+bounces-114679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD1A2F1B2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4557167CCF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B423F26C;
	Mon, 10 Feb 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GBziaNKF"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE824BD00;
	Mon, 10 Feb 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201225; cv=none; b=sn6QAbu0j27JWqQihJgNuGAjyNSYXJ5XBap8g54T8cg9TljUgq63NIRH7PoMY4aYa1QlnoP7EM/HnKkPPKQIFqy/5xbYOx3XSgHiC+LfycTFzZiowlz1gTZFIlZfLN1WQtE3q9yrGruTIRLZZ06Vw0bLfzRiTgiqegkL28euCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201225; c=relaxed/simple;
	bh=8nO+xL0xvAUxQXLyv8lbUUhQKgTEHzCCFPQaA3a+aUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGHV0AZ6mCH/fpevbPdLoRlcZqOeUr0jY43QnIHLNi20TCpQw0OOSY9EegFQJyPggbofER8GMdI1hWVM5H1rqKZwSN87XuaXwyrOwXYkqtxJPoVrKtAEavmBAaGST3/CbisSkreN1X8A5/rZku8SUMRCsoKmaUqbSUqnOFobbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GBziaNKF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF459204A1;
	Mon, 10 Feb 2025 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739201221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfteH80PM3ST7bvqhv9G7FOT+Y/mpIyoF6NjchenmzY=;
	b=GBziaNKFwVWu+pN3NcdtktbCzUqKd/a2TjDy7/Y0bwj6Qj8RVV25qG74q1Yef/oo3wNPUX
	lmBtuKV3O/vjATJvuwo30PFzKTbxX68Ctwn4s4efgfoLQyRDyhukIn0lYHD930GFFd5DZS
	Wgq1kw/pI4CIw5HVPALE/xb/0VFT4nWTUD3DHbq6j1aiEREr9KFtg22LhIy2bx+DVCnwr/
	qNz1Pi+OExJ6Jq5Y8IiUBb8204pLhpRrmQrCdsYNOGyfu/tfbuwomMun0GpVKyja9hL6yV
	R4a5RnNEg1W0qLgOk7cjWrVmiOyIwQ2PPhCfCBefNH+vhWkEo0HxCScv1lT6NQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	nirav.rabara@altera.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	niravkumar.l.rabara@intel.com
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mtd: rawnand: cadence: improvement and fixes
Date: Mon, 10 Feb 2025 16:26:53 +0100
Message-ID: <173920118908.61047.14353398163992295945.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
References: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugfdvffefhfduhfetfffgieeiudeugeffvdehvddvledujeejvedvgfdtvefgnecukfhppeelvddrudekgedrleekrdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedrleekrdekgedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtohepshhhvghnlhhitghhuhgrnhesvhhivhhordgtohhmpdhrtghpthhtoheprhhurghnjhhinhhjihgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehurdhklhgvi
 hhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehnihhrrghvrdhrrggsrghrrgesrghlthgvrhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 10 Feb 2025 13:35:48 +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> This patchset introduces improvements and fixes for cadence nand driver.
> The changes include:
> 
> 1. Replace dma_request_channel() with dma_request_chan_by_mask() and use
>    helper functions to return proper error code instead of fixed -EBUSY.
> 2. Remap the slave DMA I/O resources to enhance driver portability.
> 3. Fixed dma_unmap_single to use correct physical/bus device.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/3] mtd: rawnand: cadence: fix error code in cadence_nand_init()
      commit: 2b9df00cded911e2ca2cfae5c45082166b24f8aa
[2/3] mtd: rawnand: cadence: use dma_map_resource for sdma address
      commit: d76d22b5096c5b05208fd982b153b3f182350b19
[3/3] mtd: rawnand: cadence: fix incorrect device in dma_unmap_single
      commit: f37d135b42cb484bdecee93f56b9f483214ede78

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

