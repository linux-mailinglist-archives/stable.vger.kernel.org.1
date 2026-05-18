Return-Path: <stable+bounces-249228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCdAI0LSCmo78gQAu9opvQ
	(envelope-from <stable+bounces-249228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:48:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165156917E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7100030038D8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1A3E3155;
	Mon, 18 May 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="HzMGiasL"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550B372B56
	for <stable@vger.kernel.org>; Mon, 18 May 2026 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093891; cv=none; b=YeX4HDsLBoRNireQ/n+UoV5jFjYlZ7tJRVO84JFBfmIq2ibzSBZf/bGynY0bLfVpeweZDCst44DYLLjiL5hP0EFeF2xn77ZS5M4JLXOOVXRkc0klvHgaIHZud1IgSCKyOsqlSUVQLEyFOXb33J7au05/2cHvo1r5zTCrjE9PZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093891; c=relaxed/simple;
	bh=we1xnXX8MUtA6FfqKhG1wNOnLPLMBgN2q7Nal2yqL4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxz6p2z2gZ9Qx4vnVptGrel2I+OXrHpWWlbBQf9l4hAb+y6trdnfeN1l/VhruFQSGXKyv+r9LC4fiE4wJNjs6gA6kzLTRNLnokiD9F8rj2dc8lqmYOep6tTKrKqqVppSXkou+N/36Czct+EhCWlnZMtDhakcMtYvAx9jx+lNXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=HzMGiasL; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202605180834359e6ded99eb000207b2
        for <stable@vger.kernel.org>;
        Mon, 18 May 2026 10:34:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=pfjQVAg4y4PH7Vz3fwwpIZnd2n5nYb+HdAus0R/Y2+M=;
 b=HzMGiasLfFBoRVmeuDGtoKkuCoX1HtCJaVZjpRm2oSUQIwIKUDjMyBl5tFC0+Kq/mgjPl+
 krhm/KxpvvLyVdQsyXMG6t+8E32eqwjMKQwAJ7Z7ZmRrJdW8R3f/ca22THoELih4nuxirD2B
 CVldqgEhA81DOZI3alwAZWITEnraRf6r8oqFtLLv6mnrni10zZUMjiZhTEP5tEsJy0UByV1m
 3sXkAAFV1x/caoeiTPxKpC9ChLlDjJ7n7XOiNaGhL4kXbujXc5UFsiN0rlIZ7OL5zYqqzoMY
 0aefwxQZq7ulUWFIe8vJ6+hC3vi6ytkF1unc1sQUEX+yaCrsrVqWg7Pg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] regulator: tps65219: fix irq_data.rdev not being assigned
Date: Mon, 18 May 2026 10:31:11 +0200
Message-ID: <20260518083113.2063368-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-Rspamd-Queue-Id: 0165156917E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[siemens.com,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,gmail.com,ti.com,dolcini.it,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.sverdlin@siemens.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:mid,siemens.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dolcini.it:email]
X-Rspamd-Action: no action

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Commit 64a6b577490c ("regulator: tps65219: Remove debugging helper
function") removed the tps65219_get_rdev_by_name() helper along with
the irq_data.rdev assignment that depended on it. This left
irq_data.rdev uninitialized for all IRQs, causing undefined behavior
when regulator_notifier_call_chain() is called from the IRQ handler:

  Internal error: Oops: 0000000096000004
  pc : regulator_notifier_call_chain
  lr : tps65219_regulator_irq_handler
  Call trace:
   regulator_notifier_call_chain
   tps65219_regulator_irq_handler
   handle_nested_irq
   regmap_irq_thread
   irq_thread_fn
   irq_thread
   kthread
   ret_from_fork

Instead of restoring a dedicated lookup array, restructure the probe
function to combine regulator registration with IRQ registration in
the same loop. This way the rdev returned by devm_regulator_register()
is naturally available for assigning to irq_data.rdev without any
auxiliary data structure.

Non-regulator IRQs (SENSOR, TIMEOUT) that don't correspond to any
registered regulator are registered with rdev=NULL, and the IRQ handler
is protected with a NULL check to avoid crashing.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/aBDSTxALaOc-PD7X@gaggiata.pivistrello.it/
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Fixes: 64a6b577490c ("regulator: tps65219: Remove debugging helper function")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- added "Reported-by:"; "Closes:" instead of "Link:"; Cc: stable@...

 drivers/regulator/tps65219-regulator.c | 135 +++++++++++++++++--------
 1 file changed, 95 insertions(+), 40 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index d77ca486879fd..324c3a33af8a4 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -346,8 +346,9 @@ static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	regulator_notifier_call_chain(irq_data->rdev,
-				      irq_data->type->event, NULL);
+	if (irq_data->rdev)
+		regulator_notifier_call_chain(irq_data->rdev,
+					      irq_data->type->event, NULL);
 
 	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
 		irq_data->type->event_name, irq_data->type->regulator_name);
@@ -398,14 +399,65 @@ static struct tps65219_chip_data chip_info_table[] = {
 	},
 };
 
-static int tps65219_regulator_probe(struct platform_device *pdev)
+static bool tps65219_is_regulator_name(const struct tps65219_chip_data *pmic,
+				       const char *name)
+{
+	int i;
+
+	for (i = 0; i < pmic->common_rdesc_size; i++)
+		if (!strcmp(pmic->common_rdesc[i].name, name))
+			return true;
+	for (i = 0; i < pmic->rdesc_size; i++)
+		if (!strcmp(pmic->rdesc[i].name, name))
+			return true;
+	return false;
+}
+
+static int tps65219_register_irqs(struct platform_device *pdev,
+				  struct tps65219 *tps,
+				  struct regulator_dev *rdev,
+				  struct tps65219_regulator_irq_type *irq_types,
+				  int nirqs,
+				  const char *regulator_name)
 {
 	struct tps65219_regulator_irq_data *irq_data;
+	int i, irq, error;
+
+	for (i = 0; i < nirqs; i++) {
+		if (strcmp(irq_types[i].regulator_name, regulator_name))
+			continue;
+
+		irq = platform_get_irq_byname(pdev, irq_types[i].irq_name);
+		if (irq < 0)
+			return -EINVAL;
+
+		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
+		if (!irq_data)
+			return -ENOMEM;
+
+		irq_data->dev = tps->dev;
+		irq_data->type = &irq_types[i];
+		irq_data->rdev = rdev;
+
+		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+						  tps65219_regulator_irq_handler,
+						  IRQF_ONESHOT,
+						  irq_types[i].irq_name,
+						  irq_data);
+		if (error)
+			return dev_err_probe(tps->dev, error,
+					     "Failed to request %s IRQ %d\n",
+					     irq_types[i].irq_name, irq);
+	}
+	return 0;
+}
+
+static int tps65219_regulator_probe(struct platform_device *pdev)
+{
 	struct tps65219_regulator_irq_type *irq_type;
 	struct tps65219_chip_data *pmic;
 	struct regulator_dev *rdev;
 	int error;
-	int irq;
 	int i;
 
 	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
@@ -425,6 +477,19 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
 					      "Failed to register %s regulator\n",
 					      pmic->common_rdesc[i].name);
+
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->common_irq_types,
+					       pmic->common_irq_size,
+					       pmic->common_rdesc[i].name);
+		if (error)
+			return error;
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->irq_types,
+					       pmic->dev_irq_size,
+					       pmic->common_rdesc[i].name);
+		if (error)
+			return error;
 	}
 
 	for (i = 0; i <  pmic->rdesc_size; i++) {
@@ -434,52 +499,42 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 			return dev_err_probe(tps->dev, PTR_ERR(rdev),
 					     "Failed to register %s regulator\n",
 					     pmic->rdesc[i].name);
+
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->common_irq_types,
+					       pmic->common_irq_size,
+					       pmic->rdesc[i].name);
+		if (error)
+			return error;
+		error = tps65219_register_irqs(pdev, tps, rdev,
+					       pmic->irq_types,
+					       pmic->dev_irq_size,
+					       pmic->rdesc[i].name);
+		if (error)
+			return error;
 	}
 
+	/* Register non-regulator IRQs (TIMEOUT, SENSOR) with rdev=NULL */
 	for (i = 0; i < pmic->common_irq_size; ++i) {
 		irq_type = &pmic->common_irq_types[i];
-		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
-		if (irq < 0)
-			return -EINVAL;
-
-		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
-		if (!irq_data)
-			return -ENOMEM;
-
-		irq_data->dev = tps->dev;
-		irq_data->type = irq_type;
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps65219_regulator_irq_handler,
-						  IRQF_ONESHOT,
-						  irq_type->irq_name,
-						  irq_data);
+		if (tps65219_is_regulator_name(pmic, irq_type->regulator_name))
+			continue;
+		error = tps65219_register_irqs(pdev, tps, NULL,
+					       irq_type, 1,
+					       irq_type->regulator_name);
 		if (error)
-			return dev_err_probe(tps->dev, error,
-					     "Failed to request %s IRQ %d\n",
-					     irq_type->irq_name, irq);
+			return error;
 	}
 
 	for (i = 0; i < pmic->dev_irq_size; ++i) {
 		irq_type = &pmic->irq_types[i];
-		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
-		if (irq < 0)
-			return -EINVAL;
-
-		irq_data = devm_kmalloc(tps->dev, sizeof(*irq_data), GFP_KERNEL);
-		if (!irq_data)
-			return -ENOMEM;
-
-		irq_data->dev = tps->dev;
-		irq_data->type = irq_type;
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
-						  tps65219_regulator_irq_handler,
-						  IRQF_ONESHOT,
-						  irq_type->irq_name,
-						  irq_data);
+		if (tps65219_is_regulator_name(pmic, irq_type->regulator_name))
+			continue;
+		error = tps65219_register_irqs(pdev, tps, NULL,
+					       irq_type, 1,
+					       irq_type->regulator_name);
 		if (error)
-			return dev_err_probe(tps->dev, error,
-					     "Failed to request %s IRQ %d\n",
-					     irq_type->irq_name, irq);
+			return error;
 	}
 
 	return 0;
-- 
2.52.0


