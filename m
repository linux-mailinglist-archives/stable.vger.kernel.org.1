Return-Path: <stable+bounces-242203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDsKBw6/82mw6gEAu9opvQ
	(envelope-from <stable+bounces-242203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443D4A7DD0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68F633017042
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB43A7F6E;
	Thu, 30 Apr 2026 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pl6FDo/m"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A03A255F;
	Thu, 30 Apr 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581835; cv=fail; b=C3dMNRJDJfFXpfNx11dPtfRKlQ2OYV2/ZxQmcvEXe8VBGzc2Ivm12FdszvSZeiyvD54rI9URqCIYXRmpMm9gaQeLK7TlYVs9NPvKECbZgTSOf/AfBZENEutfJRY/dwRptdjSfzu2m8Y1mLwNrwUHXKvf0YJgQIy0j5uoXIBkRzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581835; c=relaxed/simple;
	bh=pTzZBWsYTSzYwd0IzoOtI2GFzfLlAmuLnkj996rJZpY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CoMe7AyMUiweqRbg8Apd/eOug2paBy2SsduMKzdTaEdLF2x8ldAMtOxJ/ZyjRq4bXVtgLstCkJGGWkWLd99w95VLglMmjkdE493I/CrpJSaxWRixvotvebRcHjYZuBGfbNMgQnqnZQlYYLEdykbEL7uhcUcx3DFCoV8/wFZKYYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pl6FDo/m; arc=fail smtp.client-ip=52.101.56.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2uhkHNzyg57fZPQAIKrtpQ/isGF1bTuTkIOiheWpUsuOG+d44IYZv61j2dsFXg6zh7JdAtfnPNBm7Lfswk9mmXaFTbNj7Mn58wnDV5jSHkXiU7tKg/sWgM7vhPrW07KvGnHahoJB50t36g5jZW1jE2DjNEVUkq1eHPwdH4kqxuvTQ5tBnBz2eWxhMBxDcicHmre+VFcAQTdxc1cyjUQO3aZ1HIPc58h8+5JVjPzXBQ2VNPRy3SCE2dfcma/pZX5v+bFtL7jBx0PWQbpjNImvQBaTPq3a+ppJqqjmrMlBnQ/sjudACLdGKNgg8KZzXlqqzRoqBaPuDdhr3rHbtGu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE1gzyGIbhYrl6+Hvt8qPsHPjS8Xld+xWt8YNmq8UTo=;
 b=Q5ti27WJ/bLK1Qr7ISlQfqjF4L4VOy9RxujuADf/mPL9qjjChTgWyVEI1x/I+VXxb+j6N73OtxBx1xptiXlK3OlshiAejaIZpBe7FK0gbzwWzmwGRpVyVazxn/RBSLvt6XtwR3Wj2jvxnPWmc5+LvU0hibe0LkSjfxRmdVHzcPI3qjkbWphmqTECQ0+CBmbsCEjORzi3Qs3KF7ZDDBn4OaUm5p9SUXJDfdSXGhQrxXuSZ3MmXQFVBWv6UQigRhEUtPNxuBonSRfU2uOFvcY/YrCN4VQoGh5UWrcluz3HiX7NfR9i2bDP7UrXOutcMbpZufCR4izBuyQ0y3M6Fly0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE1gzyGIbhYrl6+Hvt8qPsHPjS8Xld+xWt8YNmq8UTo=;
 b=pl6FDo/mbeo9FMw0jy/blM6ZmowmkuJuPjO8v48Hu/d759KvwLHBh2SRB4ULS+DVhhWU9OyqeN4cCG7wlVPt4QPoUqCo2ExbtLQ0kwFXkxczqvqUevJsf8S85Q/r0uYbr44MX76B5GcoHPoavahNIxRTy0IDzY+ZiofaTzj/82BFR0AplwnNRB6KMDCboCG5k/OoA+YPCDGPQf03Dtm5WYfj8AveKrgiVFELMTI+5CWbf5a/lpGR3Jy0+CnSmZPwArE1UMVrXCs5WAyjN4/0UJEp8qfgCqEUpJpX7WNU7hLmi1Tk2Tm/ngxo2M10gL7vQbPoN/u+72Qg2D9tHy0HKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 20:43:47 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 20:43:46 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	ley.foon.tan@intel.com,
	dinguyen@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	preetam.narayan@altera.com,
	cheryl.bansal@altera.com,
	stable@vger.kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH v2 0/2] PCI: altera: Fix IRQ cleanup on probe failure
Date: Thu, 30 Apr 2026 13:43:28 -0700
Message-Id: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|BY5PR03MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc0eaec-9b13-459b-55cb-08dea6f92c93
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	OxYeVkoZB2zH3wSP75efGQAdiOG6vbgPhPWPhkMjI7U4jrdrNdZC67E437KsYLR1lqdFk2gVBr84rsLPiexkoixz9gCa4baZaaJX6mtx598XoAEr8Sd8j8H/ovZhsl80H37FViXJRiFmS6jGhM/yFVZixCumTcQFvcvVRq+JP59DQ8IvOihek6po9ZgRMM9CFSxlUJL0dnEjLBuzM/hcxOelpJjOlgWq9s/Dws+WilJsVWJGys3pmaIbc307YnBlwwtFMBHY5hlx3sWoJfiiR8zGuRALh9/0kbCUNTJnmCFja2N/vqaPk6QwQ/96cp68vcEG2lLSFwRdq1tJakgUyS7CbvBsVds6EJfZYJRZRFDhUWWSZ7APYe5C8EzI86M0E+fb8xC1zI2LlEIRYBqWS8qc8aRztIgN81fVwo4DQ5l935/kervx6pTSE5fllIpQrmIpScfqd7lMjY4UCAZpYNE5F3mcNT5P8UfOAsp4CKMxJIZSTfJQ1FrLf+7TvFlJmAekjGXsOl6LjxqKGd4JXdemM1dylWlQPkqeOm+UzBM1R5brWHgeEmvLkZcOeyaRU86EQN6qDmbf7CVHz5DhZF9rCDmXVbl0h6s7fVm5c2+J/y/h6riUjecsA+7S1ii1y4IeQSd6BMS0ISgjmO2gEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/Lwm9utSb4fs0Ckl6wjv/Y05WiblWKEzUQDOiYa49d8Oh6Ph0Tuw7mU0IAM?=
 =?us-ascii?Q?m+9JhlsZlm1IVN71sTTq/f/IEGpCL+cHV9uUIlGr1KPixYJGLK+W1tVW8A2G?=
 =?us-ascii?Q?4QBXA2bA5J5QsBQGFbnNCXWbUTEpGgqbn5pVM9tcImMjPsD0H3AItXZCXFyf?=
 =?us-ascii?Q?NDSimWRVq19DEcKZBfC1tYm8KXJAUHASeVtPkkfRfg+ZjjlRLWRf/IL1Cv/v?=
 =?us-ascii?Q?4Y24bj51lMU1UiLsd/ciMspMP7S0vYfLjHJSwwUlZZtkQQkmhLx0XQyol0o9?=
 =?us-ascii?Q?bQVcBzYQpIi/kWMhsyV2zsnxJFcU6TXXKjzFjQedJZRKp2Sw3PIix/1euR1m?=
 =?us-ascii?Q?b6sR++dM5fySTcwWWRKsM6xwcIfKXSw2Rly2sgfQAu6/TJXHXekm6y2kSvEm?=
 =?us-ascii?Q?DJmcz3gyEXGTkcPZASp221pB1t6tcwIxLbtKJWtETB+/epEC/ZOB1CDJ1qj3?=
 =?us-ascii?Q?izhRatgLKhi5uLTY9qIVueBkOiNuHOrSO1UwY7E8Fuc9w8nulfSLIMEFrRPM?=
 =?us-ascii?Q?hH264rsyBBhG6IE7hqPmr6gGpKoVm3wX8m+SnweHwAlFbijz30AYwkMaboko?=
 =?us-ascii?Q?Qh+sX0WH93ejGCaRiiTSif/maKPGeAQlL6TNrqY3pITKmO/Y2lUgbdKg3xIW?=
 =?us-ascii?Q?/tbBXzLErtCqSPfvn0EAeJziib0p28+Y/8N4qrOnPKVGzs24MlhfuOxNA2V3?=
 =?us-ascii?Q?Mmi8t/sWKTj+gNnL7i1/83UDdJuN3DdmD5rNngVxgnUphtkLN2QGgOEV8LNu?=
 =?us-ascii?Q?JDiicKApR2TJRJi9yiM4ocZma85cMIrDZtiYn8b6D944dbUr58Gdg16Qvk7o?=
 =?us-ascii?Q?OCdiR5cjLE6SlqrchL/lks1QgcaPuUrYGFuciC1FKqgnP6VigDooWTIqhJRQ?=
 =?us-ascii?Q?trWG9WM2xm9HrdGk/hCkg1Dn7ykhONZCp2q3ZDDjWMgOnq3CfKvsEl7ogPIV?=
 =?us-ascii?Q?qupRCXcUFYvuRwW1NGgkiZCfBROXYLg9dCrwWUcxPZEXdxMTN7kbR2S8U6Xj?=
 =?us-ascii?Q?oyhGQR9Z2INoc9JEibCCLEyt2MLsAaGJyM1ezGjkiqeyih7uxb4uBXkV/X8s?=
 =?us-ascii?Q?7WlU9+1m1fRponFxKFKNcEOpKRMbHiREO4Xb0S7iP0+MNZowdKfc16Kl9Bt9?=
 =?us-ascii?Q?GKI3gv+ICZtznvwdGbzWEt3vpj+CJHO/LVGoY+DI1avqp0uBH7gTT94rnLMm?=
 =?us-ascii?Q?KOYipyRbfcA79r2A9M+ClFzXZG4VwrPqBvZe45i94j/JvgVZFBMQzYPmK4mY?=
 =?us-ascii?Q?9N2gJHKNZl5r8Qge2D7kLWGiyxjIDDzydvfpvqkLJEwptoWwyjYFxhA9wlA/?=
 =?us-ascii?Q?bf3A2RyyLPu+om6xivskndo/2MVlkbAfujwo56SqEaUczbc9h/j7FxclPsbK?=
 =?us-ascii?Q?U4dacNS0Jqs6Oodq5KW0yLLmz4gxGpczSggd5Rp19mxFWoB9AYkXPaZPej7x?=
 =?us-ascii?Q?lMNLLO86Zw/DUUDMSdrC/wCkU181j9HUI5nZRGJcLio7qBQkHCQ7xLkTH5Bs?=
 =?us-ascii?Q?OGGxtChgHT69JSXxHJ7GolxWMkZ0FIi/aUeJifOPpbfK4ExtIDVGmetnN4OM?=
 =?us-ascii?Q?A6ZgZWeBcDWR7rGLsafUOd5TpnpBTiLJmZTHp7154mJdJNplUz/kqRDK9GyB?=
 =?us-ascii?Q?l7WyRIvayIOoYLvJMFvowYx59nILI48c55unld4mLwMW/zVr3R10zWs0xsmM?=
 =?us-ascii?Q?hLQiH1Mv5izkyLZxYQeac5BVQbejx09kL+boEWXY40LxPH3IZJahcFqfxOtm?=
 =?us-ascii?Q?qT1xsExPPCOosrQ5SJcVdC5/qyDzd5A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0eaec-9b13-459b-55cb-08dea6f92c93
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:43:46.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moc32F+6gKW+0s5aInuT/wGjKaum5RaSzY/bIixsSEUxb4VtSUzoLNZC88HY4lCdjjfNmZGcpDIdSILPtvmX+PJj/nq4uf7Xhng92KCJNXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-Rspamd-Queue-Id: 8443D4A7DD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahesh.vaidya@altera.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series addresses review feedback from v1 of the Altera PCIe probe
failure cleanup fix.

Patch 1 removes irq_dispose_mapping(pcie->irq) from the IRQ teardown
path. pcie->irq is the parent IRQ returned by platform_get_irq(), not an
IRQ created by the Altera INTx irq_domain, so the driver should detach
the chained handler but not dispose the parent IRQ mapping.

Patch 2 fixes the original probe failure issue. The chained handler is
now installed only after the INTx domain is created, controller interrupts
are disabled during teardown, and the IRQ setup is torn down if
pci_host_probe() fails.

Tested on Agilex 7 and Stratix 10:
- Boot and fio read/write through a PCIe endpoint.
- Probe-failure cleanup path by injecting a failure before
  pci_host_probe().

Changes since v1:
- Removed irq_dispose_mapping(pcie->irq), since pcie->irq is the parent
  IRQ returned by platform_get_irq().
- Added controller interrupt disable helper.
- Disabled controller interrupts before tearing down the chained handler
  and INTx domain.
- Reused the teardown path when pci_host_probe() fails.

v1:
https://lore.kernel.org/linux-pci/20260427175302.570671-1-mahesh.vaidya@altera.com/

Mahesh Vaidya (2):
  PCI: altera: Do not dispose parent IRQ mapping
  PCI: altera: Fix resource leaks on probe failure

 drivers/pci/controller/pcie-altera.c | 36 +++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)


base-commit: 4224e91fea5695a89843b4c38283016616946307
-- 
2.34.1


