Return-Path: <stable+bounces-244615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbpKM3T/GlhTwAAu9opvQ
	(envelope-from <stable+bounces-244615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:02:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0997F4ED24B
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857023021E42
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FB423A82;
	Thu,  7 May 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="js1tFMjV"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D473264D2;
	Thu,  7 May 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176941; cv=fail; b=XtpcYXwdOQJn8h4poQphbjSjkA/o/hVMzdR0PJWQjjHhRp08QcmT2+jcsdxIQf4bsu3Om22Wi3ROhxp+mz75x+lHwOJ8OHmEN+o6R9JwlMuuWDxuAcYyqF+F9rbs81xSJ7YSdrUn0Gv7VQNhQYlsJM3rKkryfRiV+nzLFr8rp28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176941; c=relaxed/simple;
	bh=cD4cCUmoFjbEZtGcs3WRgtK/dzo8kKJkIRkUAnTNduA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oWR8Zx0jst6eYfT3vgxztBaNjIEiZTeeNu89BeofbijDzyIKGyd/xmsmXtUlTqForYtz3gLw2zeeihnmvEzQZXqYUExD3rLpwj/mDRWO78aCUC7HaHkEmRAQ2qxMlk5C6gCIogV7y6lc2zK5wYD5tiPYT7n4I3wPisaV2Y6uG18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=js1tFMjV; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElnMCvO1jMoPYOJS7kx4Wkqc6n9bvhyJ/bICxYx3MuOe0Iq+vvKIW5EL+nfYCfn4VRLxDEY6fgOKF9n2xMA4ayG9CDyk1b104IKiOKxd7kqBsO1fj202aFkP1m8eiOFP/4ar/ankj47VJ3JWMR4MKQstUq4fy0qxGQ+W+yh0MX4FP2UZYtzdUsrdIy/LI8j/N1sBow+ShdC5cAGhccH66lwTP9F1RjYvBpAWGTQOvgoxCF7MYIUdMOZ5WFQg2ht1fhB7kSiEYoT1OkLwbKKlU+DK+/xTo57150Tn/uvRzJSnaev6ov9Fw+h9yhXhpHoTU/felnrixtkfjeQ6/J6Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI75TcU5g+KOOCM2uFyeuWmbXNlzNKLxgi1ak808JDM=;
 b=XWmAwvzqSqu92zPiYv26uieMrgf7pYIqtdSZmdqAoAMKBUuP3Q3wAB5g4WjCLvmD2gqYtsvt+WEphWydRF40MujQAxmXFq1JpIVGyx/TI2aFvMb6vNiBj8JNb+LBj6Z4ziojIPmPTw8qPO3IKmn9gWYLR3gwuWYXw55p3YWgVMN38P1cPA2UZ/BbU1etT/wYmYT0a1+1vCoyUGX49FJVZI/fblJB5jXtj2taCZ4/7CAbBBfmq+MZvPLkJBfqcqazfXz5r2QZ1aoZmOBEQEUrRs5UlPG3HyBg1FgMWQQmNkxwD4reE8wVk95yHnGA/tdNREEkMiKg65IrwP1YEJ3vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI75TcU5g+KOOCM2uFyeuWmbXNlzNKLxgi1ak808JDM=;
 b=js1tFMjVfZgNZQ5LWnSbQiC3mOMl1pckAdWIR8Wu7NNQXXClWvcuwgiBc51CKJzyLO0nE028qN4ttcppEDZ9AA7pu1mzudXFYd1XghX0MXBvqX6PtC+j9040j5i357aR0+ZEkCP05HXQ2Dfzme33p6ZB6BRp8h7ue8TuGvYmrs8=
Received: from PH8PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:2cf::12)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 18:02:14 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::79) by PH8PR07CA0044.outlook.office365.com
 (2603:10b6:510:2cf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 18:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:02:12 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 13:02:10 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: Mark Brown <broonie@kernel.org>
CC: Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] spi: amd: Set correct bus number in ACPI probe path
Date: Thu, 7 May 2026 23:30:51 +0530
Message-ID: <20260507180051.4158674-1-krishnamoorthi.m@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c60c61-975d-4103-9378-08deac62c396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	WAIe19HD8M6LRNwRBeCyhpIvDmAgwHXT4RVixCfBp67lWM4kbyzibuyq2tocaPKTfSTNdBgBsCxkq0AnA0qBJd28tdOofx5eoryOf9PUM6ffFAuQ6yMudxBI0w1s7/FjwW0NGPqxGbGlr4Prk5wqRsQNYtuN5e+udMISIk7SxN59r1Ye3kFQsx/Dq0Izqf0bvFr8huRUoNQmu7HKyqD8p14NiwyE/XvkMLnP3DjyAubZRcAOO1VjWBTsgLADY8t+O/XcoeIbf381YfCZQXvdOQY8eRataOX6tpNAmkl7kLHrKOKFxILKMea0NkckMPAiQLgYBhfKpYNJtHKbPxPwpdMICNOAvYaHZhfI5RnGwool/dt+hyNbM7wCtixOWPHck5zorMZRm0N/q5vZyrA3d11bpeg8s55T3fVpZWMIl2z/sQ9yWw9Qt3Bs6XoTOKfgb3nAE5WtlTEUBlZklO5ZoxAmnYrEIz99kR4cR3NqfGPBchQYgCBGKlenZYuWPZtUAglLpedZnHAjitk/cBBevu2DNUTieu40j8lE1mvQqgbScMNDfH7jzBsaVsLtqVEU6RPNru9FIp3BcrDZ78lGXkE85ssmZHatlLTB50Gy0hMb9Rs9bzfcwl6Fcx99RCWTKA1+ES8dn1G51C1UhRnE6sWtBYqswqlE4bvyq2omOund2xiVbAOPW0HuyCzbyJHoItEwfFcNNOjM51eTcMzo4TAFhc+Wvn3F7Pg0q2jKNlo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6W3G9Ak+CpIYNO5eILVsOC9Y19mDN16hdkk7u1lb0Luv1JZu2wLFl0ZOFhQGdynXdCjAcZu7tOo+U7ZVd6xtMn5d0mnQNG+DOovdQJ+VNFObZCUPBsrW/ul7ratlM3p4U+8Xej+wxjjCTo/fQ2+q7cFVrvevEmSuwmStXT2uFqLly3WM5u+VGdo6tLZgon4Tzfh0YQXDtAABfzpQqcf85oKe6AowojWGdfX027IFn8qSd1fx+EaHazjPSzbc5Bok21y/fgM+rbecilhd0kV0+TTkEYdNrTaktgZBNRjLnRIva25WmFKsew02WiFt8hEXFLwB6haobHxdNzP50Gpl+CcuGvap8pEPSPMcESeN8gBRrmxxlfQvKIOOaLcv2dsduwYub3B9keL1hdofhq4uU9kDnBpQptwnqLHBrMMuPzZGxRJYdh5bes/V9uN6d3xj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:02:12.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c60c61-975d-4103-9378-08deac62c396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
X-Rspamd-Queue-Id: 0997F4ED24B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244615-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishnamoorthi.m@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On platforms where the HID2 SPI controller (AMDI0063) is enumerated via
ACPI instead of PCI, amd_spi_probe() unconditionally sets bus_num to 0,
while the PCI probe path assigns bus_num 2 for HID2 controller.

Align the ACPI probe path to use the same bus number so that userspace
and SPI client drivers see a consistent bus assignment regardless of the
enumeration method.

Fixes: b644c2776652 ("spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 4d1dce4f4974..71a6e5c475b0 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -868,7 +868,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
 	amd_spi->version = (uintptr_t)device_get_match_data(dev);
-	host->bus_num = 0;
+	host->bus_num = (amd_spi->version == AMD_HID2_SPI) ? 2 : 0;
 
 	return amd_spi_probe_common(dev, host);
 }
-- 
2.34.1


