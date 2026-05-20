Return-Path: <stable+bounces-250621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KXZNGjoDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47305592C1D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 368FB30C417A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95E30567F;
	Wed, 20 May 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGCZTQCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD582701C4;
	Wed, 20 May 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295890; cv=none; b=IUIXIGy/XBuZKlF8zeQr9apGcR+61lu+XJWVUEHoT1+1v5aL/ZWJTCw0dfun8o54UNBaTiORzp78mY5cRQOlNIp/CtZSJovhPgvXmG/WWKI2NlKoX4TRtk4qllkW7riTLcQIhLqneunGxEqEWpfCuTxnaoO6YcALIzOCh50i3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295890; c=relaxed/simple;
	bh=nRlok2kiLA0CbGFyHwBZpL/7Dry4KqdkDuuCgydbpcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW/mRQxoEVVx8dhzqEbJZoe23nb3h/MsmmNX7kyCup5iEbwow/CG0ur9+txb2n6PAN/7dMF0lkCQHrsPVBLygDVWOJ/7m/h9EPiP9E3xTK4fBaYPs7p+gcWCBjIR95xFzoGNaCC2K9tGdS19uiiyxfhiwbfQm37HwlRzXMP+GcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGCZTQCZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61231F00893;
	Wed, 20 May 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295889;
	bh=GuBCNX9yX5D54vnYj//oVkZFE4QY0cI64hpBt8TQo2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YGCZTQCZBmVvQ+Fd3QyA/28BTxUoNvZZ7VGYEDjVRxkug+rpQ5ezI6H4bu8ALQR5v
	 nlTSJT/EARhBQcJn6Obju4vkSggIx4cHxqxpo7IfbuTWsJtVuVXKlc7H8jeIkUGtJa
	 J1JaTgftTxDPa3jXuobfk5i+n1YNrZTqcXznLu2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0590/1146] power: supply: max77705: Free allocated workqueue and fix removal order
Date: Wed, 20 May 2026 18:14:00 +0200
Message-ID: <20260520162201.529538270@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250621-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,qualcomm.com:email,collabora.com:email,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47305592C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 1e668baadefb16e81269dbfebf3ffc2672e3a3bb ]

Use devm interface for allocating workqueue to fix two bugs at the same
time:

1. Driver leaks the memory on remove(), because the workqueue is not
   destroyed.

2. Driver allocates workqueue and then registers interrupt handlers
   with devm interface.  This means that probe error paths will not use a
   reversed order, but first destroy the workqueue and then, via devm
   release handlers, free the interrupt.

   The interrupt handler schedules work on this exact workqueue, thus if
   interrupt is hit in this short time window - after destroying
   workqueue, but before devm() frees the interrupt - the schedulled
   work will lead to use of freed memory.

Change is not equivalent in the workqueue itself: use non-legacy API
which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
used to update power supply (power_supply_changed()) status, thus there
is no point to run it for memory reclaim.  Note that dev_name() is not
directly used in second argument to prevent possible unlikely parsing
any "%" character in device name as format.

Fixes: 11741b8e382d ("power: supply: max77705: Fix workqueue error handling in probe")
Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260305-workqueue-devm-v2-4-66a38741c652@oss.qualcomm.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max77705_charger.c | 28 ++++++++-----------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 0dfe4ab10919f..63b0b4f0cd217 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -646,47 +646,37 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
-	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
+	chg->wqueue = devm_alloc_ordered_workqueue(dev, "%s", 0, dev_name(dev));
 	if (!chg->wqueue)
 		return -ENOMEM;
 
 	ret = devm_work_autocancel(dev, &chg->chgin_work, max77705_chgin_isr_work);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
-		goto destroy_wq;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
 
 	ret = max77705_charger_initialize(chg);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to initialize charger IC\n");
-		goto destroy_wq;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize charger IC\n");
 
 	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
 					NULL, max77705_chgin_irq,
 					IRQF_TRIGGER_NONE,
 					"chgin-irq", chg);
 	if (ret)
-		goto destroy_wq;
+		return ret;
 
 	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_AICL_I),
 					NULL, max77705_aicl_irq,
 					IRQF_TRIGGER_NONE,
 					"aicl-irq", chg);
 	if (ret)
-		goto destroy_wq;
+		return ret;
 
 	ret = max77705_charger_enable(chg);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to enable charge\n");
-		goto destroy_wq;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable charge\n");
 
 	return devm_add_action_or_reset(dev, max77705_charger_disable, chg);
-
-destroy_wq:
-	destroy_workqueue(chg->wqueue);
-	return ret;
 }
 
 static const struct of_device_id max77705_charger_of_match[] = {
-- 
2.53.0




