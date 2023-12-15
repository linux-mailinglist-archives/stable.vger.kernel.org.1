Return-Path: <stable+bounces-6814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F481483D
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9551F23A94
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365102C6A7;
	Fri, 15 Dec 2023 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VptOXuHk"
X-Original-To: stable@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67A2C6A8
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 86F81C28B2
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:32:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B87791BF20F;
	Fri, 15 Dec 2023 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702643538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlO9c0S5HZPIZWQNNP4CRaSyaJKuJjI07FGIgD70qWE=;
	b=VptOXuHkGakzoUqE2KXejehznM+5B5rf+jb6yOVW597wY1OH/v/pveyeK8LI4FfRuWBSQU
	bQNPEjBSbJUTeC1i9/U3c4HhgN9eCtQZfGHx0NpDj4NYTIe2a5L5v7KUcQUoqPmuYKlvfE
	7BfJBo2Me+H540h1LoUAIkuophB6KxoqYQ0lr0ZFT5uppCjh23DmTjqj7VtEHHIJ5VSxc9
	3YN6aQrpulkkNf4nNqlgfUmMbdJXIIaKeqZ6dcXANaikTlEaubeccr/PxurBlhFaDhza6m
	Kfu9+dTvDuUKp1r9ycAtEqbkgjN+U0c3PzA9BaqmvJms39pOCwHR4m9o+rBfNQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] mtd: rawnand: Prevent sequential reads with on-die ECC engines
Date: Fri, 15 Dec 2023 13:32:07 +0100
Message-Id: <20231215123208.516590-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-1-miquel.raynal@bootlin.com>
References: <20231215123208.516590-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Some devices support sequential reads when using the on-die ECC engines,
some others do not. It is a bit hard to know which ones will break other
than experimentally, so in order to avoid such a difficult and painful
task, let's just pretend all devices should avoid using this
optimization when configured like this.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 1b0a984d181d..139fdf3e58c0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5170,6 +5170,14 @@ static void rawnand_late_check_supported_ops(struct nand_chip *chip)
 	/* The supported_op fields should not be set by individual drivers */
 	WARN_ON_ONCE(chip->controller->supported_op.cont_read);
 
+	/*
+	 * Too many devices do not support sequential cached reads with on-die
+	 * ECC correction enabled, so in this case refuse to perform the
+	 * automation.
+	 */
+	if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE)
+		return;
+
 	if (!nand_has_exec_op(chip))
 		return;
 
-- 
2.34.1


