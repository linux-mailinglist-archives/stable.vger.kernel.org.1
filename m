Return-Path: <stable+bounces-8327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EE81C947
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A963E1F270E3
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9611C156D3;
	Fri, 22 Dec 2023 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GMrQV5Cw"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA14168B6
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E74EF40008;
	Fri, 22 Dec 2023 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703245062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGvJdodaMoUH0kCV/D4eERpWVU5lmL4BMhIcgcPbJqc=;
	b=GMrQV5CwbYq2uD2Umx/e4P+DB8QzoBInUuHRVHk7bRXjrASUhUClJk/2KsobAx4Qbm85cr
	6wYzKL8ZeltE0b4nnv7kQXuL1Bhcv5Wd8iGjXjqSZ9RevGGKPJ0cmFp6XWLCZPVp0+UyKs
	PdHZEe9W0TK28Oavuj83m6Sc4AQbR4CA3bJBSqXAGTuTRwMPbq9bqTzzpPKQ8kCltv1hxA
	h/bd3dJSuNGBN01SQlvY1l6mjvCfY24MNj/xNlWeMoZgrtUhrVZBJ9IQ401RsDuyuoeMpc
	W2Moc88PH+Y5ojXJz1gsl+W9Wj5/vCgLydLjwwW80dBddJ4/omP0B4FmOjshbw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?utf-8?q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: rawnand: Prevent sequential reads with on-die ECC engines
Date: Fri, 22 Dec 2023 12:37:39 +0100
Message-Id: <20231222113739.786750-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-4-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'39eed454e35faeb235cd50765961f7955fd0a720'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-12-15 at 12:32:07 UTC, Miquel Raynal wrote:
> Some devices support sequential reads when using the on-die ECC engines,
> some others do not. It is a bit hard to know which ones will break other
> than experimentally, so in order to avoid such a difficult and painful
> task, let's just pretend all devices should avoid using this
> optimization when configured like this.
> 
> Cc: stable@vger.kernel.org
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel

