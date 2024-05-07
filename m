Return-Path: <stable+bounces-43194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6788BE855
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE21F2DCB9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2216ABC7;
	Tue,  7 May 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a21jvZOq"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465E168B0F
	for <stable@vger.kernel.org>; Tue,  7 May 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097955; cv=none; b=XxJiCiszyRZE3RUkfjfYPlXP4PpW9Czt8dGjrXLPneAxWpWLpMzfi0Wn/220I4EPqQvgWuDPPekTQ7aEZpd+d5zHgu/Uan6FvaarzRV7voSNXzFpYS8x7wDWJamdvM/A0YM+qci5DeK2WmCBvdR+bb8HD1JNeUOvl468WVYf/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097955; c=relaxed/simple;
	bh=0MBXDHux6QsGPGLdElZwVyyHOwfI3U3HGlGrcn7c1MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=af3DkvNp24fmNv0sRnkclCbkI6+FSG2DOVtikYTvJQDQ5FxqFBMMarRaKPlQAFjE5zxYdO3C9nZyAxKAQ3wY9SLPEXhz+7v8euJ0HuBqF6bryI9PN/e7iN6SGtJQ3SGbDfzCouqdkHEhpnbIkwFx3vI4bkuOMq8tCsu6IjdGbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a21jvZOq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F253C000A;
	Tue,  7 May 2024 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715097949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUiREoZxMWf/CCR7ayPhlx2AOXCj5xYQ5c1EZwZhtqM=;
	b=a21jvZOqr53j9NlFYWqWL3JNKEg5NbdDXImcCwTIPhKPmzeU/9j0M5+uKnyMtsxRkCIbjy
	vjRFBGD672Ipha/BviPj9gI7UmyWcw87Mt8z28rxfTwzIFsOst47084t0kgtgLxOQpEX13
	cZJWcOL5xDG3BACvLs+An9PuB5RHB6DumlzAmHNQ1IY3IR1dicSFR2pQyHqFxY+BwDdAP8
	izl5RUs8XHoMtuiqE1GypYTPTfRuJr8PZV9rTvZvu4L91E347kcfeYpj1/d/3GQ8Lu623H
	HdstrnyaA0kObOvdbM7rPVkFZlJ4Duw1c4p+ohh6dx4t+xS6dIQ8p89SCy3TgQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>
Subject: [PATCH 1/2] mtd: rawnand: Fix the nand_read_data_op() early check
Date: Tue,  7 May 2024 18:05:45 +0200
Message-Id: <20240507160546.130255-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507160546.130255-1-miquel.raynal@bootlin.com>
References: <20240507160546.130255-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The nand_read_data_op() operation, which only consists in DATA_IN
cycles, is sadly not supported by all controllers despite being very
basic. The core, for some time, supposed all drivers would support
it. An improvement to this situation for supporting more constrained
controller added a check to verify if the operation was supported before
attempting it by running the function with the check_only boolean set
first, and then possibly falling back to another (possibly slightly less
optimized) alternative.

An even newer addition moved that check very early and probe time, in
order to perform the check only once. The content of the operation was
not so important, as long as the controller driver would tell whether
such operation on the NAND bus would be possible or not. In practice, no
buffer was provided (no fake buffer or whatever) as it is anyway not
relevant for the "check_only" condition. Unfortunately, early in the
function, there is an if statement verifying that the input parameters
are right for normal use, making the early check always unsuccessful.

Fixes: 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only once")
Cc: stable@vger.kernel.org
Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index acd137dd0957..248e654ecefd 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2173,7 +2173,7 @@ EXPORT_SYMBOL_GPL(nand_reset_op);
 int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		      bool force_8bit, bool check_only)
 {
-	if (!len || !buf)
+	if (!len || (!check_only && !buf))
 		return -EINVAL;
 
 	if (nand_has_exec_op(chip)) {
-- 
2.40.1


