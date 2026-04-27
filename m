Return-Path: <stable+bounces-241421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIYfLrii72kcDgEAu9opvQ
	(envelope-from <stable+bounces-241421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2D477EFF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6823025910
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3F3DCD99;
	Mon, 27 Apr 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sTrGgXOM"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E4364EA4;
	Mon, 27 Apr 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312403; cv=fail; b=OKmoHymxqtmlJVrfn4ROTiF6S0Z0LB9pOJ37EDgFYAVzWn2omQCSJ5l4a77yXXufHRSuestwavFurZW2yhxOunuOh2OTqI/0ih7ds9rXCY1BZPKD2VfevNZ2ppbw4vlmMz4Qy3LBfBYy212I7w86DBMKmUewo6SNK7i/9kDem+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312403; c=relaxed/simple;
	bh=tH9KC/TGCIq5rP8Dut/9CdDocjGCwVvb2v2isVNlByw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oHns2SHPC9z9jNvb/lqjwPSCG66iI+z3uSM2k1jsUtQBqOqcrNqHT5LojWTzcno0aTDsLx8A2N58kYU986cK8Od+l9xHhcXGrlMEBtbHqDDcC0jpYNgPUqEHqqRMpMoIWNQ/Kq1HZWB4BFS3I0nqp5TJAmOFn0ZgLCne1MWnzw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sTrGgXOM; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH2lFfitse24NMexf02hTh7GHwh9JYGwakmBa7gnHCa3acfumBckkphz1ggIBVVuf4cZIdNzVHcKdZj/QCO+Wb+jEI6lH/zTlvr/JCkAsNaablNJWKykXlGRGDtqV1hF4GCH1IW2ybvHrEHznLZGP1yhcSJUCjzV6HC6w7zEhRYJPxchmYxcTmG3fXg8M86SdWofM2c+xUvSqMr4E+iUqSUp5xW3jAoG2m25ciCrkqp1KyKShzXWouD5VzUir2pOqOEr7mmqks+ckTgl3jmRJSC1t4V/AtFk2UnjPkISlKBl46/lQMEF/D2UQnglV5BPJj/jZbCHwcZWVYgM507WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d656+IBRHCC9v3A6/hXVTAvRqGUGREA+E+p+KijAyUs=;
 b=JARtU1w2sWzU+hUisJXF3dmc2gAsPqXRYZpl6uFeyEJQvqNbxXmQKERUr75iXjTXfF22ID/66zijumuJXOhWRDu/RUrL52avD+I1D0RfA/+Ra6xh6xxnFtuqKM/GTX75sx9V+KYdM+a5PaXsnVLmsIvzmWoGC0V9Jzgwq8GiRrh/jM1kRrOt+0warc9nKxUVlXvrjuMSstcHREXSAh48o5Cbf+FgotCrtjsSsfd6OeLY7pGMZJ61HS5/ZIuBLXctZMJnrqttTW3x3a0wrETfSX0Q5BjJEVE7+qJFAeaGVqpoEgTLhiVpvE4jz1Tfjeqmd8TlmenryUaAuTW6cIw4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d656+IBRHCC9v3A6/hXVTAvRqGUGREA+E+p+KijAyUs=;
 b=sTrGgXOMtSV9vZPqnahJaZ2aNY97esXj3EJT4rskBi0hvgTqvIOktIHcPS5YGDGDGVCYhXIJonOMt+yYoLN4JiWFcAEmSuSN+b0L1l7tPqHoJd08k7hA+Q89dA2qWN/5uUff0AXThVeScFXSwB+/GYb9IJb4w01UGOmqjjUOXKcv5ohG1b2lYMKSYDXPqa+ljmjXOgbhSFtYKG1zCvfeNrxE+TImuk+kgQkO/o3RSpSjTb6/sQ1MZGbKTzAnPcHDuo8uZdSbAcinRdQPzkQlaQyOnCcwEQYWPxGjNWryd4CwtKdFOHpDJlmPOyX6UNTv0/ITh0fCsA73khgy4FoAKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by CH7PR03MB7785.namprd03.prod.outlook.com (2603:10b6:610:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:53:17 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 17:53:17 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	ley.foon.tan@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH] PCI: altera: Fix resource leaks on probe failure
Date: Mon, 27 Apr 2026 10:53:02 -0700
Message-Id: <20260427175302.570671-1-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|CH7PR03MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f031d3-c7b1-43f1-cc6b-08dea485dc3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KjFBDKsf98Sz2U3Xh0KByxQIxWJ2T+pCtpyr+b3+r8xvn7jynTEB1BBoIESgGG6a2kngSQc01fuwPSldoO1XLvZT3hphv662r5eJD3IF5eHIQTvdDnwXXNUB8+dxOE72acp8LeG+pgFgFoh0eehsPadJcHoJrbs/t9sVxxLv4tB3iE/W5YbbL6LpPyEtmG7rPPGs8CQEZxmG8jXcAqVvzklETxWyUGFKQ78QvqUhJTGEsesHp2ZfZisoNVnbwrhqsQblDgyoTDQESF3Wq2laqDFihigHoPQZJZIGGBzOs3717ZXzJcu3deONAIXIA7Oh8GHpDCeB4r05ljMPNg+VnrAByQXj0f16JkQWRNhvETD4bE4PGcSr3XCCnYB3HuvFFmIe/YeMFTlSvGnHBTgnhvfMDJlZLmAKqTDNxTdaOTYQhL9h8/njAtvpyi64kuimp+hDydxj6NpeVtB79kRLBh0DO5deZ6edntmxsNB9D6Y9IiVWMoTBl9f8JBVbHL7SUJinqnoAxWvYlqP8WihJV59Mc4DSbozg99v2dMyfbngzRLOqVRIN5RzIZJ27YGXbLqS2FXml26GA7PGefoeV6lEeOWPq4j9ax24m6lUJEukAhMhy//SVcnOhj6wif8rQNQLg9tjJqx3IEZkB5Znl70jcns0vF8WIvt9LemFyuYsmjW550+GO3kOFG0Xb+rR3XQ9pk3ep9YTAliIuJOA76UapasZDpV1v2ke2iwXsBiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EX74bxf9K7zcUtL8ttleUvxLcYeylx9B2DffFnQzc8m5YHCIzr7/AMqOMQ1k?=
 =?us-ascii?Q?tzJD5zziMI9zo+dyYCNLbEUXJCBY2QJKNR3WREl7MtgI2R/b0HqAWROwTPWj?=
 =?us-ascii?Q?GX6GiGgMA06S2VtuqSj+Hd+QjboHJbyfUMDUzGhlnVx0QyrCCyTXps77WLCu?=
 =?us-ascii?Q?fus0UgDm9SedPPWXtoytVSuotB5dkmaTja+IbRaTtLlwvK1MH+/+zr0yeS0o?=
 =?us-ascii?Q?cK7bOnfuzJOJCm1u9dhtps/qN8LTwpEsM8ILELmS2KdKUrSRPRd811iBKOti?=
 =?us-ascii?Q?LsBuAel4DSNvuzIKvTYNPhFFP6zf2zt7S5rOixabVcx63/fJGt4jW9eaXH3R?=
 =?us-ascii?Q?AoHmWWQcnCa4cJFsHG8DRkclxAluNjHLgVVkWareCco800UK32XEcbadhq71?=
 =?us-ascii?Q?Oa08SG9bFZIf0epnEtJwTOng78DVVb6lbqEck3z28Eu5i4C5p+Bh0188O+BM?=
 =?us-ascii?Q?o+XkKsJgOPLTEuHop/3PRaXC2Z/OqNTnWALzuKdFKkGRHvwd6e4Z4Amd15nA?=
 =?us-ascii?Q?zcFUrtwQMFPdkahCWa2IrII7663yxqoo+uRnprg0pmzr9qXa1NbUFHuA5iZx?=
 =?us-ascii?Q?gppOw1jQ+fVB4s8Ie67aEH/N1BWeOxe1qaN9n/cCBDVQKRsqc0HTUMpEjon3?=
 =?us-ascii?Q?ZzSJ7tt9bU3VAeQva3llClsDyydkzdwZXNBH0jJoBylZJkcUWABpzAq7i2VX?=
 =?us-ascii?Q?CRMlps2J0goIpVFjCuP7w+qYRWbm7HXfwXI2Es6btTSxfVS1+yetzAJ9K1/p?=
 =?us-ascii?Q?co5Om/qs2sZaxR8BBzb6ow8ajfGFJpOfvXGs4lSs81y0BKQs6SZbdXw3+7tC?=
 =?us-ascii?Q?oH3pKh2WcU4z+QF+COX9O51n3f5j8Aer4u6C5tjExXjreyBZ1wMcRIFI5R6x?=
 =?us-ascii?Q?RARNG/AuE0oWUqval2KIUMNCYEmXttO50h51ldE6xExpU8WLAhIXeUNbR0OK?=
 =?us-ascii?Q?WHNZr+BfOvjpICCbzj/70HBKuYL/Cvd4B7kjTrL73Dg/Sfz834iGVx+USyRs?=
 =?us-ascii?Q?zAo+44XR3zns4yHMH6l38Mp9YJqMqe7IwRS0vSck9Zn5QOFR7EdX9Ws6dO78?=
 =?us-ascii?Q?xvTs6lRlVwthiFlx2Ygfvp3zP2w/2pcBelZGGWsLxUu+RyFfx4EAkjSWQNue?=
 =?us-ascii?Q?D+Dgpw7RHmFreC3lQQrJhOsn1hBFCZ7Hqi1P8MrixqznwnrN9TRXt5vsSvJa?=
 =?us-ascii?Q?fi7O0Vi0hTQPvCQBDp7MYIJGmQIbjcKtGFHiKbJwqKhJZxYOM3mFWwsiwAmO?=
 =?us-ascii?Q?WE5pus36oBqqw/E9pokE2iA4BXrigRjrGnNeklmOrx9dIqFZ+VLKz63y89lY?=
 =?us-ascii?Q?8j/oVmBS9bLZArPdQ9q+JMwCDzIQVoI0wl6O7Em7V5mhFFBM56R5zxcE4Jai?=
 =?us-ascii?Q?X9Y9epWpYgqoxLFW5rvt2c8tgNk5CW75dFIuIBPLOhE6NXXUO4Lq8Sa801aQ?=
 =?us-ascii?Q?MvE/BD3y7oEyuLeiqa7KIulbtnyb09w+CuQVboAf6hOQ3UJyM0yGovzA8QhB?=
 =?us-ascii?Q?cdf0F+v0WC5xxBvl7DbIvoaTd9Q5C9u2DTIJD8Hjdg3Hw6j9eTxMgGyvni7B?=
 =?us-ascii?Q?lvg574GaSRDy8f8letg4HPNG1lYBDKd90WrrMDvITiLg0tihrFK0FCXUxesm?=
 =?us-ascii?Q?dU2RwMD2DDM5mIKsBbRjUi379YpmIdzw+Tp+iDdYqTDiD39Qey472WFeoIiu?=
 =?us-ascii?Q?3asHYIOzzao69IfEFQsmZONq8OxyPfq8AfQsgnsXsY7OFG3Yi2s5m2Qa42QV?=
 =?us-ascii?Q?hGad+K30xk8Ism8wobpFVH46eVzESwQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f031d3-c7b1-43f1-cc6b-08dea485dc3e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:53:16.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmuN56xhdjSMsmWv0/yQzaJ44nWBaAPn5wauLkoNoHoYfXE0hzAI4XMKdLllT/8Ly56dFyUdJHk02XzMYU/nwrG2nhTq1QJhnLrugkAfOR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7785
X-Rspamd-Queue-Id: 5DA2D477EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahesh.vaidya@altera.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid]

The chained IRQ handler is installed during probe but is only
removed from the remove path. If pci_host_probe() fails, the
handler and INTx IRQ domain remain installed even though
devm-managed probe data is released, leaving the handler with
a stale data pointer.

Install the chained handler only after the INTx domain is
created, and tear both down if pci_host_probe() fails.

Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..a18e287b8614 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -891,7 +891,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1020,6 +1019,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so install it
+	 * only after the INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1037,7 +1044,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)

base-commit: 4224e91fea5695a89843b4c38283016616946307
-- 
2.34.1


