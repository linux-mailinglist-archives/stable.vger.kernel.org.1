Return-Path: <stable+bounces-8329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BAE81C949
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B4F28807E
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C601156D3;
	Fri, 22 Dec 2023 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oZ7CWD21"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9DC8E7
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 688F8FF809;
	Fri, 22 Dec 2023 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703245079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRjIQ33Y4rBKHEpM9iWKYgVmuHX6/2Ds55D32ZUzDJA=;
	b=oZ7CWD21HeokwA5Tbohc+ep66K+bxRxiuOJFmBxn3TAS7LWRtUORaAT1gBfX7mF1BVaLHg
	YG5pNTKux+LEyPhgAeno1Bj3kqTaIa2DozUOD5gqbq0jiFmdz53Ci+yI7eI23ZeYMbjGEW
	TEb+gqxH4kA8W5RSmpFnIo/od2teew6FfzsOiPa01bEpuUsU9DVH4EiV1TSOFlSmSUyCqa
	BKtDFWfa3uEzjrBVpUgWeDzDeMuaMmYCfo6FYOX5/0MixidnbspMBB5lfq2JQB6253LULW
	jZg+kVPe+R+TxdZsltiGRkKrtlxPjcnV8op1uQ5FFZXQLFsmtZEQF29B26nGFw==
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
Subject: Re: [PATCH 1/4] mtd: rawnand: Prevent crossing LUN boundaries during sequential reads
Date: Fri, 22 Dec 2023 12:37:53 +0100
Message-Id: <20231222113753.786809-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'acc796d0293a0aff51f543284156004d8a08bd9c'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-12-15 at 12:32:05 UTC, Miquel Raynal wrote:
> The ONFI specification states that devices do not need to support
> sequential reads across LUN boundaries. In order to prevent such event
> from happening and possibly failing, let's introduce the concept of
> "pause" in the sequential read to handle these cases. The first/last
> pages remain the same but any time we cross a LUN boundary we will end
> and restart (if relevant) the sequential read operation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel

