Return-Path: <stable+bounces-254641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O+YITItF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:43:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E875E86A9
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF67301F9E1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D13E9F95;
	Wed, 27 May 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GWDkpU7r"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B93A8741;
	Wed, 27 May 2026 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903478; cv=fail; b=nuKcDpCG1arKvzXcaNqnRd5bw6bF2ITmo8hGIgnIZym/+LIXnwJ4y2ujQrgDsxpWwH2wct/FIzp1auCGcN3LsdyslxWe5yh6oTxkQRhuCwH3fdaczX38aA3z6Lil0USaFsoFCod97DCiXaCQ2Cs10t+FMioVYh1Umo2XnaocC0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903478; c=relaxed/simple;
	bh=gTwdOdOEiolWfZbJotlhngMOltrAmxI4KBWD0lUWoXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkriLCa9d8cRfynGDEuCG/mH+g3PMKfKtH2+AvblTefAJcr7zZ6zADARx4ibl9kEJHzhu9oJjyMMlfyo+xmMQTKDsZoQ+e4PPyZfjzjf2SsGybeuW3pQ46WrNy7Fo5SkVnPE4Uh6H+OjL9mlOW26XRAbtWGKhyv5S9VoMmXDxNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GWDkpU7r; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPVF3nJuHhDljf64i2zV3M9PejlVmwZXYmxa30eIJfUZyf5NTKiDbitBzFzNdKwkQ34ZLnTZ6KavLmROEefGdCBavo+XA1Fcq6e23X+PNy2Bm2pwFE1yYhoR3AG7zukMsIITEbLlfYiUgf3fVwq3UfIHU8ntXQhYFYOUjnxd18hFKkX4RPJYEI6tpRGvzLp9Vj95yCrUIZRuPnM5NM3nSnl9bxj5JG/mdepA6c+dl8TJKy6KJU9r4rg/nbtFsBOtSJxm40tOTf2bDo+vHcG9puX3PLEfM7TrAz3Aty3rZxuc/x9AIMx7UgJpeRDnyfqeSQDWexQftAETqLr0eL9oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNz2+ON2KIyvNwaGi8FamJl2dXoPiAUdz+FbSB8J2aY=;
 b=CNxBSOOnpNQchXGSeSgAXROmBmWOLAQRivap/nYgYMBDqftJIRx7Vcol8lcsy1eNDGk+/Ndq3fbrPuHYPGBaVvtglXvhYmJRRV/FbSkFqizST3Rpx70UeFaeyekSsLFvu6rdDhH9q9JFUT3GoDM8UzCBAuEfhfqePx/7wZXgg7WlnHneidl13XdJcLzX0dFejrcO+xVQBVNVxBxNK/KjIVUQK859MQi0HQveGxpCtertjfuR+rsftk5QIjRSxi7FBmjICgjgVrI6VcsxfXLgOcD9t6PggJImImcxnMEy0onUR+psokXah2fvQpvaK2C1PA2w2ddcdP2zWW/a49feLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNz2+ON2KIyvNwaGi8FamJl2dXoPiAUdz+FbSB8J2aY=;
 b=GWDkpU7r8rZKBIHCGPBF1uY+UsKKZI5mqAnv+djLWv3yPAxe6UE1AjJgJMmFkOSv+ghKMCfm7qcDtwz57AsD9hIMsEOiRorDS+R1mtbJaWglDZAMl+aYJwAGrFQLM04VpAG26gZm3l6CpJPBbsY/0iYeeS/iWeyMqn1BLImJhJk=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by PH0PR10MB5682.namprd10.prod.outlook.com (2603:10b6:510:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 17:37:49 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::73) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Wed, 27
 May 2026 17:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:37:48 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:37:46 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:37:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:37:46 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHbhIa364003;
	Wed, 27 May 2026 12:37:44 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <miquel.raynal@bootlin.com>, <xtydtc@gmail.com>,
	<vigneshr@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<s-k6@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH] spi: spi-mem: avoid mutating op template in spi_mem_supports_op()
Date: Wed, 27 May 2026 23:07:36 +0530
Message-ID: <20260527173736.2243004-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH0PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: b51ad160-33c7-45bf-9ec0-08debc16abc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+rYLx3tXOBQ/bfll1I/UqXPguhGzQYExp/8Ml6KyK02Sg5iB9EsQ4fHDXDxquk/5TWrukXxcKQwmwaLTuP0EEu9HUl/+IdAvEnIdpUJuR/TDNHojim1nlB9A7vUmHX7JDE4JdEyNBJp8Ht5rEujeUZfsy/liWl7AxaGCy7YjSYT73vHwyLBLvZwhVMeDp2KEfMwg4t3P+buabxE4KYecSfAUl78eAbsVq4Qv5QeEWCTbgCwHOiozNnS1PGJw7Ofou540rfiXU6KbxefN5oStG8RPpkuv9h6ld9n8kBuJlSLDNG5Ra/jfBT+SSuSeoNeQzyE5ZPZ+XZ7ORxeASHJ2F1F55gS9plKZq0dVVppPI6yvXfc0Ac6AqPqYY94jhxgrAQds7zg09UZeAlh8x5gz0+RenqQlNf56eZZcUXVOoMCvv2dV5sKYudRI4jFUJ6ledhDwWO7wPqDoXhczss5eo8wY3TGno7SvzhvITbKV92NasoYFNzSMpO7lllwczUON4LCRQDCHo8Du628HCT1LISCYZhtU7jtHPoJ2KleH1UyVnHrLDsRmo+4yIjdo0jVA7Id+HxByv5bRhFmgPAQB9Zav2SYnnium3otwOjZ+sH/I9EmPXshNUU3k3rhedjYli3v0FovBJxdFxxUJkkvzP17If0VXFNCb8d0IBCCSEpicB6wCwDmcMBgqB2w8p5K5
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kkP1KKx3wybg1eFfqABsDMb1wXOkso9StL/zVQjxFhrbxfQq+OxG5NfE4KyNGjsXZez9eWzNEO0TV94OOh2mlz7War8OyDb5MyzEKcKMYGGx+dlfOgV3OwCZgGkKFj8ViXWDGwuOhCaB+VHKx2K9DB+nctR3M91DHroECvPv5GsXOHTVmGIUIsPRYZU5Wz21f+RLa9DkDwxSrZ8HKwr0VpBz3P3up7slNRIEn6YRnFoc/+D2dEVoxUZzZoa25GUwtLlHAkk575LVEe80hYNWfkF+hAh9iTlfuVl776ZJnZif5xk8KRVm71ryYdEU7tpyKPKJZ8+VJ7XQ6L7uOxCI6RRX6+iFbj73PQPS3itCKR20FOJaY2VFP2ZrYJcT4sj0iWxth97pjJgwv3Ksq1SpS277xgNBfG7hnHXRp9rPbKEHwDLboyzGGiOX0uM+0uMj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:37:48.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51ad160-33c7-45bf-9ec0-08debc16abc6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5682
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FREEMAIL_TO(0.00)[kernel.org,bootlin.com,gmail.com,ti.com];
	TAGGED_FROM(0.00)[bounces-254641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email,ti.com:mid,ti.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-k6@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 19E875E86A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

spi_mem_supports_op() accepts a const struct spi_mem_op pointer but
casts away const internally to call spi_mem_adjust_op_freq(). This
mutates the caller's op template, which causes stale max_freq values
when callers reuse persistent templates - subsequent calls won't
re-apply the device frequency cap since spi_mem_adjust_op_freq()
skips non-zero values.

Fix by operating on a stack-local copy instead.

Fixes: a4f8e70d75dd ("spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()")
Cc: Tianyu Xu <xtydtc@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---

This patch was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash.

log: https://gist.github.com/santhosh21/1747d197b12635bfaed741fca650a173

---
 drivers/spi/spi-mem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index f64eda9bbd9f..a88b9f038356 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -279,13 +279,20 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
  */
 bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	/* Make sure the operation frequency is correct before going futher */
-	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+	struct spi_mem_op eval_op = *op;
+
+	/*
+	 * Work on a local copy; this is a pure capability check and must
+	 * not modify the caller's op. Stored templates with max_freq == 0
+	 * must remain unset so their frequency is always re-capped to the
+	 * current device maximum at execution time.
+	 */
+	spi_mem_adjust_op_freq(mem, &eval_op);
 
-	if (spi_mem_check_op(op))
+	if (spi_mem_check_op(&eval_op))
 		return false;
 
-	return spi_mem_internal_supports_op(mem, op);
+	return spi_mem_internal_supports_op(mem, &eval_op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
-- 
2.34.1


