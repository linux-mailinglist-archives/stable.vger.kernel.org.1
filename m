Return-Path: <stable+bounces-235502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AybCH2QC2Gm/WAgAu9opvQ
	(envelope-from <stable+bounces-235502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F231C3CF19D
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6FF9301E7E0
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB733B970;
	Thu,  9 Apr 2026 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CwlSTwS5"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CE330B30;
	Thu,  9 Apr 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764055; cv=fail; b=TO93LWWKaJHKthqPaxQ3AoeLSx1kE1L8pnGXcy39/YYfzk3vUEgQw6zK6beI9zHRjlvqrAPBpfzmWnAwn2zyR/ZBA6bgGaT7K2SgN3Mpjo1XhWG04bXqgWxnTSazcEww4g0DmQpjByOa2/4+yZ++/zlfXc0P8KzEfNnqOelX30w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764055; c=relaxed/simple;
	bh=d6vhIDd0KdDWLIHpM6MWQMbORjS/zi9LMZNjvCOHV+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqR0egcdAh1zKSG0LG8eu1G+/wKYkuEND0d6bKAVW3detiCsfNJkyv+HgQviekHPRTKR0pgdnYFU1HIPJAkLLnUX10VpGmMYxqz8q9JNf6nB6rypEiqsN250paNLngSbitMR0OsqRbyjv2frm7B1p8kvqHe80F3v06YvUtB5xUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CwlSTwS5; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY5PXt6UqBznL0Za3Thp17/eG/ZxLAixKDgm0ug370rBKp+VyYTyr5/M5tn+Tny/t53/iV3gfP32Z5/XwDO3ws+nnbicn85003uZpsE9sAR0DfQ8QUYlSquPwSFOsTVyoJ8BiBJABuEn/pMUeEMbsJMHb/yMljndF6XHhbt28455Dg3KC3s6mSUq+gelLHBs3f21EKads7gD0XY9LUIKZzSn83gh6rX5LkXiA43liPZilR2gAbSV0wJ6hlq1o1Q+u5HYlsVFTj/++uY3eGKVysO8kk3z9zAou69gkPT0m9mxS6+H5E+J1kpEpL8AGUX49qOcIhosT841Q1ktB6mjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrtBs7yjCIeMjPtje0NeFu9exxBOzwCyBfPzLck28TM=;
 b=hwAG3HDECx465Y8f6paufQyf89VyckCkoIy7DSCzRXrLU41cvPyiiGWdzZEZ8TWXh90yC3sHSGbD9EP1xI7xdsf65SxLadol9E0ClErP6ZLc/08OXBt94o6VpGPfV4+9g3pWw30Kjm9oBN/4ykDBOpriiHIy42rP3XT4gqbrYoBYn0Qh7yB5Djv1AKWzYtav6N/s5Qkv+9MgWDR50CT61+YBeNq8GRqJh03lS7tDovB8CwuC8gFJr1JMac5IXuhsnQ2KdJU55bVetnIUjjh5+mfOSAb5ywrAHyMqZJaf4j6yHf/kF3x4y5XrckrwaPCLsVQCdfT2bbaDS6R0EpKs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrtBs7yjCIeMjPtje0NeFu9exxBOzwCyBfPzLck28TM=;
 b=CwlSTwS5uVfDuD0rYBiIP27EEUDgj5ngEFYt3DKsv6MsokTY9XcVLrUKFtr7xcirndIbdzwBDNr8SVnQReEK1c7hxvS8MPlptVOzdYWpNYDLyH3TmnA8WQzRIL33dpaGgrp1u0SvlOSIyeg0mTzEjQctXECgOZx9K9U9PHGcfjI5HI2iggSP9YkP2UshiVAKv4IHZ4yS3GKi3iAMjZie1Pp8Rd+WfJcD1rextpFgOwYcAO/Er1CYZmG2VOWxn2TpAIrzkcDPwrIRhO5+r5wdsFG9NIdevir2J87AR8p2j3+pA8+PaRg3SsTuAn3ybOPL5cGU27bG0dX7ET5EYI5NaQ==
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 19:47:29 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::5d) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 19:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 19:47:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 12:47:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH rc v1 4/4] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP in arm_smmu_device_hw_probe()
Date: Thu, 9 Apr 2026 12:46:53 -0700
Message-ID: <2572aa7fdd3b32eefe48693668c146f4a68ce50c.1775763475.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775763475.git.nicolinc@nvidia.com>
References: <cover.1775763475.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1fa18b-42cb-43e1-338f-08de9670d532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Ul9oX0RW+aZ2xTASnIzEDIJIoTOAy0oKiLioOmEkEvQYR9aLs6gRB2vu3USoRXXDmOTaPKfZzTtE8D059TxGQ2jt7UrNKb5Qe6jZfmhCT2pZmcfsMAF6UlgpOdnYJX3YsrcmH0cAUhMFTQ3uOpyA9lHNCO2X8h+jFs91kxFCoEzNVSxJNj/0jXn9890TxtY0C/6Br6p7YC2SduYfs9vHRnhNC4KJcHFIFQZ/AUR1Hx8u3dNJiAtS1xMYzcOwfJZki7Kd0q/06kx/cXQgo7WquTRQ7150BvTf/P67JZeXUON/XsaLeqPa29Wyd/cQaDA+0oR/yk5P5SnU6k5+Cbm8OBCiQt/XERQz+4Im67QyEd5EKMEFTYT5RGqJPZDQNBqkGc4EYQhuX43QgW8c19min88XliW/u6GWBZWkIcOSDlHR6JzEhGjMQP3N4ALcQo6Fim7PPc6Wm6AZuftEJ/iwFdAdaENj4GJZCPaUSsYfUJYP9YJ7lycoxef5uoQS+fCHei2OACU24fnuAfoDySoO2LI/2ri1enF/42wWVmvlHA5/pnR94w98kJ978iyW2z4KpyAhqbSKCgJHChQkg2lebEL/jPKk5rPAd0KQCFOw+8S6+jJD+WUQvooZMDyFM9P+TVYvM2RYUE/6BIVYL8LMZZwqasy9u9dDZAZHo+aapfbmWqDZnv7a9YQPesT0pmesm1zl4LJP2L3HmDTfDxdD15mwea/WmpDbiJRMMgzm1zGn+D9LEnZr9ciU2nAE4cQQj/PvJR1000jdjfXn75Z+w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kIvgX4r0TTNBVy4P6sP/K3w75/ks9Jzoq0Ehi1P3hvsdM489SN/ITyLj40wtQ4q3TCMVUwCcPaUFQDuH3XEKNsUmpfaBUzwX4RR8faUAtBizwOubKrKNWPg0LDCxvvygXsuxHfyRjGOh4HxKvPP5ShVh66pIWM5IkHR9CRepmpqTiXNmD0vv+RUBLeDFhfs7toF3xW+yOaOsgO4Rn/51niNapCSQfLTVUZOZbJYRWfnMrQPHfcZORRWnPhbfOMvpPjY7w/Wg6ZsupmLe+QCzyQuOLh7igjR+j99tBnwZAuCSgNPBtWr946vXNI4Q0PCVb9GzDIChhgBaz0nGehXV8ZTDn2DNu7ed2WtC0nzc5Zh7S+YYn5UWT2orPZU8DcGz0khoPgPJLF5qbeSzxYBCnUg7PuSPXcOaNR3TdtWpkOc/R09SHoFoq3x0D/Ojq+52
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:47:29.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1fa18b-42cb-43e1-338f-08de9670d532
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235502-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F231C3CF19D
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d0ef8fb876978..d92b5fa4bac17 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5376,6 +5376,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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
+	if (is_kdump_kernel() && coherent &&
+	    (readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		smmu->options |= ARM_SMMU_OPT_KDUMP;
+
 	return 0;
 }
 
-- 
2.43.0


