Return-Path: <stable+bounces-238218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF+AHMEC4GltbgAAu9opvQ
	(envelope-from <stable+bounces-238218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAE40828E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB19B3148719
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0338F635;
	Wed, 15 Apr 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxRPNvS7"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E973191BD;
	Wed, 15 Apr 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287906; cv=fail; b=uPRnPDmUgwvAqw+p+4MauP5clX3Ua9AH1z28IWlgXjULkgL47pSVNuvUxKvi+ZD4mcc/QU5tU2xOYdgGSnSwWVQRVfncAMsNUldMPFSP1sPzxgAA66DAgsg6sKlSFTHAgkNVjm9XSlg4cui+CqkjTm07ZRoe4iWMMoUZOWJmwVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287906; c=relaxed/simple;
	bh=Ovy/aHwEFHUWSLrSoVaVfFeaqek39fy70T0Aj9297uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF9iosXzboR6jj2N2ry9Ch+6DBXdewRGszJOfH8oxXHQ+z0g+ry8x20Ioo0QSyuaGvZ7FwVD4kHxRcZyclc9PNHdQdaHz+Lcn/etjKNreFDDRwb95cVRHjzg5AgrN/aNCAZOxZ1SHrLcO1hA+sQ6B3b3IBUrbR92JfpBsUe2cIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxRPNvS7; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbSmipKtS6VNlhQAlxhS2FU4Liap8xYCdkt/lGMe0tq8lZekhG8cLBr9/s/9ua2HrulypJys+MqMBmnBGQ6t/OQk5/+fUaFU8IgGCLhHouz6Nyl1hC2AwdclmQ25vNT6Ql7LJQpTdXCxhzSUe7eaQHdgYXyZyP2eJ2rY1CUPLlu6IAU6Idyz3mnmfQNQGe8rnNFAUJt5CaVLfi0Rvo7Xefgt0T3QQnlltRGBshuRuymJ4vYdFeUfCJP1osCv2q0MvUdCgVVfkcMZXhPVY3FhQbnQ2iGnuWcjOC/mvY8mtTvzeLkNpY96UdFRJGe0su+AefwgdUo5sX5x2FkSLpQzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XcP1hOR0fcNpQwXBtm5TxfOkz+uHZDImYaq76ICR6Q=;
 b=KcvVO+KVku77EC5Tkka13wWH4KXo+EZ228QnsNs71Zpvnsx8RI0trfYi5eO2w8sQ41nkxazvzbo+IcPEdSm/76XXD1fAUADCIzHQva1xYP+wYlqHMi0OxyZFoWbxWzGZhHenVxIa6yGLalETodV6U+aHbavp1d8gHDUSJg+/lU5DyEbmF+XhYoCkBixI2ug+vVhU6CiG86De+5PYoNzmR7FlASnrUgrjnZ+SOPA4iY17SbIFXGOJQVpQHeJX+OwSlQJQ8Zhhn7ZtvPZxP2+rW1Q38tzULQtAKPvMzu/9cm5rQEbh9ew3rhivBVrW0HeGPDCaF+dBmGtNJyyE037wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XcP1hOR0fcNpQwXBtm5TxfOkz+uHZDImYaq76ICR6Q=;
 b=pxRPNvS7a4iAHkUWdrBB187JEwj7/8lYpRbXnBJLDCX277vn5E8YZSE2CovA1qnCWOkxsjClAYev2QSKQKf5YkXEwFlK711LITByQ3aH2thFYTznuWQrDBLZJwweZWBzO2GZLyhwhtmyVIPwlNSzh4roI1fuvelZ8cVyJ0QMYtkzyIZq0D0ZQmOw9yc5hUWV9j6ADwyRMXlofrR0yuAG0EMP+TEtQss1zNi33YgzK6BUVQaVgeVIqSrU2l+Wz6uT8I2q/Jq84/Po2gJaO5dDX3KelzSjNAIXoQ5xZLU1/u7rpFt7a6rC95+7RTyhEYu6Y3lYKc6ph4are0KbbxnBpA==
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Wed, 15 Apr
 2026 21:18:15 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::90) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 21:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 21:18:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 14:17:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v2 5/5] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP in arm_smmu_device_hw_probe()
Date: Wed, 15 Apr 2026 14:17:40 -0700
Message-ID: <8738309953fc091464eaeb4b2b3d0bb8a70994e1.1776286352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776286352.git.nicolinc@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 66924be1-cf82-448b-e00d-08de9b3481a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3gEtc+qMErOkvLQ/N3tBojfmLwxnRKGukH5pb5KSVWCRy6Q5TvmtwPlL0/DZZMsdaQ9ztwUJ0Z9zj1T5VCUDfNpjJ2RqR85YLzM1e3bJs24/nP2DukEYucuwyk9Qw//SF0EOS6bJo+F9mkSDVtSR8AZBKQfwHlkRL+WycTNlUxlgvEyujUMlyzkUMEqsajPGE3WUrTo8tMyGA+g/ZTegd44Tu1AIUNHcR4+npmtrQBjSOlRQtqE+NizUslfmdLmzNZJKrf5Atic9L0S0tyR0/AmiMJeNWglC8AyWJQVkXpD+QMxHg13oW/Rs8orvaaRx+eGdK1T/tbBI1flMxzsbXwbb/s7ZZVEvxtqo0zSYX8SrV94dahCd73nUkOLcf1KGZknTDZwBtE7VEOYVk35B74eGJIjDqECeqW8tybIj3t75+vQtjgLZ9i6SSmoJaOW8KtSGP+SefbDx6dFCcEvLYaUUz2bgoeigpsTRb/+I2nK0iNZoX/ONXceyFtMTXjdPPMhCHikHwdbdokeEGJCCzbr/aI6l0s5iXwvE6En/bU+BKhdjQhyXMkzajshuwOoI6iDigHX5ENwN9LZz0SYrF2PEqOTXhwIJRSiNWFdrUzJWHJ96mWP8jIpFWZX2h9exM37Id1XUespAwSzqe7YUmyBTtjkk45wZohxrRLAEUpJpJKSMKrkwIoPCAyt5wKL02yKhMtfiUYFoqN4twQX37h833KmbL+FLr3fVnHQMHdbkQ6RVOw6pEmDL8mSYI7Ykdv3SU4v7/e/cUeP15hhd5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mYhVCnxttCfkT2TDdDRPMa/AcqBGCn5D6kNahrMBEf22QcviYj2KkGkU8DWEZyZ6ScwFe3jdPJww9rTuEJp1chNJ/6J1+vagq8rxeQ7UiRxGge2LAGQEJPgRQS4DztC5e+SdWl9FS66ZCkdGsSHjkkluX0bHiu4lef02OOyV/Zg5fB5jTazz6ZO1YvU7qlVVF8s37+NTCvdAkxOFJwDPJcE/UccvPy8bAGmPKSEyUVFC72N8V+2NRS6MKwZUoXxkPW9tsJEehi3wL4TwgyMjkPZ8pv3zNayn+5gEIS2/HUUNgaaZDhHDUQgMboPJ5PLLo+D2beeEYj4isBTFQ11wpw2bYjadg4wF+gWQB0IqKjCuSl7EjjimUItjJ/8iLXm7mjHsH/yZ94FyRzsmJTz6sQ3KhKGg0J1aivx/jS5FY5YbCz97dtMCUVjW7/4XO9nl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:18:14.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66924be1-cf82-448b-e00d-08de9b3481a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238218-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CBEAE40828E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 12cd148a99dc6..5a5e0f80bbfb3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5388,6 +5388,25 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	/*
+	 * If SMMU is already active in kdump case, there could be in-flight DMA
+	 * from devices initiated by the crashed kernel. Mark ARM_SMMU_OPT_KDUMP
+	 * to let the init functions adopt the crashed kernel's stream table.
+	 *
+	 * Note that arm_smmu_adopt_strtab() uses memremap that can only work on
+	 * a coherent SMMU. A non-coherent SMMU has no choice but to continue to
+	 * abort any in-flight DMA.
+	 */
+	if (is_kdump_kernel() &&
+	    (readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN)) {
+		if (coherent)
+			smmu->options |= ARM_SMMU_OPT_KDUMP;
+		else
+			dev_warn(smmu->dev,
+				 "kdump: in-flight DMA would be rejected\n");
+	}
+
 	return 0;
 }
 
-- 
2.43.0


