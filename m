Return-Path: <stable+bounces-45295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE28C7756
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765821F2166E
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C4146A81;
	Thu, 16 May 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BNhn/lCC"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08792143862
	for <stable@vger.kernel.org>; Thu, 16 May 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865205; cv=none; b=QErVlDzCEGo8533lhIJk72IgZvf/dNZWSiFowahZfHOetASEyPTeMXU95mRLA4KUAzXfFvRW++DP5nqYZFNxrpHHB+l28p9xKWW/P32EovB90+Jt7bk72G/iUDFwzl8XUbT1X4a2qaAbkx5H4VM22TAZnIxmFb1zSG6/8CpURzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865205; c=relaxed/simple;
	bh=Flet5N2+BZpB5VU+M4wsxXd04MzwkjagLrk02sh0OGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkAeUFN2n31QaO1V/K76U0wTfQTFrwuu53cpAMpqZOdsMVA/KE3moz2vkI4xeQFJzR4u0DKRBzUwkdaoqG6xMrSOIZPi/91EVQW+X2T2FILLRjWYyytqu00Q48idWOTMCnFJJKKDwQF5l6EdgdN/a8uuNcyx6D/uxVpx6a4tLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BNhn/lCC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD3544000B;
	Thu, 16 May 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak/aV2tldKV4rYtA3xMMWb1+NUwGzTfz+Q6IEq3kc3A=;
	b=BNhn/lCCdeGEKrzctEQnSgwXaG/yLRksP30BC7iRCHpWaePQ50n0hX7B0BBtFGtk/FfUmz
	6I7zilHVl4yubEeAUsAQSFOhav5wTfFBddVFhTP61syTpv+f8PN+311dNoYl1YOyFhDGuA
	6SZFUibnTKocasU2knGTLQ3ihgamzlEABxY/Gj+QbDgw3NsO5Em5KnwQTgtXiPegWwzkSJ
	EQJKJ7ux9Li9nkcrhQhhoh1oC8OBJXlMczIsl00LK4rXzQMLpoLQE3uonGo6rSQeBhBQNH
	pYlq3HGFU7J8l65oTGBxb0dQMmuUhCHM16ckuBkl4EXRZyN1fE+7cZDZD8JBwQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: rawnand: Fix the nand_read_data_op() early check
Date: Thu, 16 May 2024 15:13:19 +0200
Message-Id: <20240516131320.579822-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131320.579822-1-miquel.raynal@bootlin.com>
References: <20240516131320.579822-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Alexander Dahl <ada@thorsis.com>
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


