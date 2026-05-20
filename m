Return-Path: <stable+bounces-250933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNbHNZztDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E935936B4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DC1431D5009
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA13FC5B5;
	Wed, 20 May 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlZtPGoQ"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F93F8EC0;
	Wed, 20 May 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296670; cv=fail; b=dYbrreyoVwBnEgzsuOItUUXfLdsSjTendy2j4sa4iTlYtMALvoGTpeLqjboS3LEeGSyA8WiFEielvIgQfsZN+qFfQ9iBMS4htWHncqAha23Ug6mEbrxf+WpLB22FTzSjiCOozvdmgC1Jvs/37EBY2qC6+u5NCzXHR4kvqcnyRrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296670; c=relaxed/simple;
	bh=D4V6ZpQNHf5SgkYkP65hVPIjj+b9ChTcs9kK9E5UaL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axqIDc+iCIRr74APdByd0Jup8vKVUiMVlavzjtynFe3pay4pUDXJitahjTyrXUTP81/Pp6VaYq3a88OpY0tUbXeLK3ei0LdRdFUKrR1qS0ism+cXJELVY7GoyQCnJ34YP8+oqrd5EzukKM8hABYGWOCiGFxoAu8v1x4TGPD1tIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlZtPGoQ; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6Bejf92KBQxDZ0oAax8T9tF37iLZFN1iK5kLs0TiHSE71Jlkd4ip3z0xZXVv9N511rymaVCKGkmRWuOcHLvHA+pLR+y7knOjGVCMVr3AAuEYJxnilsQu/RjUkB5wrYoXUFzLl6AwYOS7KYCW/YOOAo8DDzIgxVNaG2Uf2+Qk1GgxnjKlPY/ZuAag+36KVeYugmQMzJ4oM39k6O/Wf5dy6HSaNHT6MzhmouJ7zY331RD33ZPOba9uQPpDkeo89isTH8hNJhd+qxpBUaPLDyvTqOz7I0yTlKUtj89q7tGUC++eWgdtuYV3X+WxJ02zDa7qJpxyMPR3DeldLXqv5d9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0v/ELbiHxcc7C2bZUxfmHCe9IwyyYCKx0HNBNIdOtw=;
 b=Gt1EYz6eB9ER0/i5Z4tnNKrFcgerz2Vm0ACUqwaNjNcTM/cT6PU1lNj42b5cqPm51z54c8RmDvDyZHEP2QHzC7x8Sg1fqOz14phfTOKQCXtNq00lAW2hVJUP2A6OfMm/R4FlO8UJhI/ZAbgUJAm6FLzWkUmSI8MDueDAKifC2Al0fvxvVCKIRaDFo8XddFY8MlhsWAmznZG8/o10NtvnA7dK74eBtz/4xScL9bJYNs3A7pPQxWl93gnmw53VJi5dY6ZEQWk9zHZxKv5AKSZWe6tb6ITrv6HWXm1ckm8Z6otm2uK22kAkDMk/cwDL2OTTkERwEzmJev5d7zhFMB8E4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0v/ELbiHxcc7C2bZUxfmHCe9IwyyYCKx0HNBNIdOtw=;
 b=PlZtPGoQcd+Wo3V66yyFYaaWcuV9e7/543WoUWgwzLwVHU+4ZkRSzY8irf+3ZtWvS+TJ5NzYEhW0EozgFy7mttXKkE5RcZaulUEFOrlCq2Lqp4GN4FzDYack3T/DL+wajYdKWNsX+C63vXVaAbYx8rujaDP52KLt0zHi+Drmody3/A6WrorsbmpCVcNjqYJj1o0OVoAvZA9OkWSsOL8WOnVaTg5GcbjD9k4Ibb5szmNzw/3Zgwa7VE77siibxd3tYnU0Qh51fSTZmieE/XpBR9kNFxOhvAYXyYRQoVcxIjy3qND3njph5tS6qY/ELJloQEF+DeSPQmAip4nvxmZEgA==
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:04:20 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::40) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 17:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 7/7] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Wed, 20 May 2026 10:03:24 -0700
Message-ID: <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779265413.git.nicolinc@nvidia.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dc8ccd-06e9-454b-e971-08deb691d4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	G/NFFMudHpsWwkYF885t4W577hx3HhQsvaCysNfMsZmpXxQHz005xBN9E5I8WsBKkw4wMr0eYieZQNBuSFcalZv92woLhhCwd0oMhYq8DSzEIPwnr0ogN5X6vairNy+I1eZxa07J0KoVTjb86C0D4UPQn7NJpQpCyEmlHKWze9sIrUz9q7ar5I2g6P/JifI/gPf/Dha9ilvzfSxzlP0aIkBE+sIBaH9I6DhDCPDiKNiYxkyfMsvuNUbEllerKzPq9uJFjBzj+zMqEr2k8Sv+dXjZL+mVPJs+FRfVUz168AW+qyX8HxqgTxmzKN26XKEmY8KcTx2lh0GTIM/cIq+Oer8ha8NZx5qahZMqTG1shlxpafNW4fg25Jhu9yT/LwuVp5hi1Xm/FIpteSWzhsg32gZg3d4m7/yF8TdjF+wjt8Id8yf6oNEZLXwg13sNG/L/a7fgBSt7lYOPko8OaAdfDagn3Z5E3Ns5Zi4rOLUYRsEsiAHpUhML6zYr3gJvwpCekd7epgvhTwepW+1FGv5fZrxWfwh77XaD4Im3fz7H8aniai9ZGPrVP5xUHL97ZKBrNO1VVaPP0fv05wSrGsQiT7riJVpq/ODuLl45Sexy2aIjalZ4EaROoxx2KhwsVEPAWN1jV8Ff4JsHOXcZofTr3qbdP+JSokU0ggaqErxjUG8uaWsEqXVwNbP7ZxoAVYlRvYvEH4jwjiq/jwL8ntJt/6EAsuaPUH66v+Fc8Wyz9jI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gM6nluXhgQ8dJxyGq1DnD0LJWJ3MSD7TdyH9FyfciguTi0cvQIMEMhJDlvGU7bVBYqvmsTfrMUExGr5TB1HQR5zJzv8Pd0QNxyKAQOzWKHSnFUXuZXVOXqtA3b0O2YmhKjq3wEHlP9qSEYFsGQhtMTxOOow/IVYzMEkqIpkrbf0D3CZwUgjP2B3yeUFXlQ0Sej/3Wdwtrb6vqaYQ8CMNCqLaNXGIsK7ezq43Sa6IRg9v8giYNg/4q/AJn3mmYQL5jlFRlqCNh9ZCnxG5b0dWlWWCDt92hwkEVVlzn20o04mx3ZSz+MzHROoaMiFTSOeAx1W+Wq96fIlQvumpMXv7v0Wjm87UbHQlDsneeE8Hus4RNzKphI4/OKahY0c7pizvM6Ei2c9e5cc4GCFd8a0fo1jUcS3bjPlRZkbG6StYfjGjgFmCqG5Ib9auXd2Tglah
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:18.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dc8ccd-06e9-454b-e971-08deb691d4d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250933-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A7E935936B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 851bcebfdb3d4..fb34c3ffee9fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5353,6 +5353,33 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 			  hw_features, fw_features);
 }
 
+static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "kdump: SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -5567,6 +5594,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_hw_probe_kdump(smmu);
+
 	return 0;
 }
 
-- 
2.43.0


