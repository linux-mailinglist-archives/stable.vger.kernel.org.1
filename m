Return-Path: <stable+bounces-245081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BYuHpr3AGoFPAEAu9opvQ
	(envelope-from <stable+bounces-245081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:24:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA150678B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B49CC30080B8
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6C348440;
	Sun, 10 May 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GERZJeVA"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB7344D9D;
	Sun, 10 May 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448214; cv=fail; b=FExRZRJ91Gjymu+zGE0RbfcdWVn1AR2oHuuOv5rqnhoBT28Uda7K/NyvfflZ4lcvlhblTR6I6iPNBmSvVnXmvrF8Bocf/c6WRsqvCi0gd6OWRQ7/G8kg1P6EhghNekkWjiQ/UC5PjrKAFJkAMX9U3aDoBAiaEzcRwbktc9OeBxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448214; c=relaxed/simple;
	bh=5XeqrT4GtCW6kphtIbKT+nnTM2978whb/fMMJF4XAj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paHQFvw8zAWynOwXTitfUk/9LFLnQOXabxMrtAJk/stYKZikNbmLYFyKeZXtsxQm/4NM6g/eDCb2f/5gj+bBt7Tnj0DTMbp851ooyN3Zqy5uku3YG2WZ1dKwHEH1dltphRLPpGBjhZTvPvJzGVhuEnmimOmD8eH9wKvfgXxddYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GERZJeVA; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3+Xp8bSvyVHno/gJ2TE45ktlNnjN1sxaMg+PNJtvnc2jCylV8cHKgS9c88GV2wPRzIUvZcyeiJTJdeg3QpPCDXCFpgjvi3oeLn/TTZZ3qmcdxORSrRSDKcqBZDzKgJl2Np4AYqhGt0rtK6W3GrTbssK1Zo2ZMxzQle62neEY0EPnD/ztwqA4mVw4FAtOxtzDxY2Bd+Onjpx8/zqJsJzPBcuYMOnULEJ7Eh5CyJxQxXacG/ANwMkxKMo4EmbXYWnyFZLg+6Iu/j1tYdHDB3Qi61/sl94qQofTqV+w2Cx6f0hWKe3nc0t5n+G9N90x5XAGJK9oQjmnWvXGK2rHWpmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXaUEigxttoOcE3GtT2/Sbyvf4celqLCuXorv2INiDo=;
 b=HjNpt8kv/dopwP1ajcZtVd3vDMQce1wXJNMTZ69mHqN4db/mVpmESLWPSgW/bPTYEmZGeTWJ59HkcPUXusXz1x3wIm5PEDbd5Y/jgpj+ThH/udE+1RjCUaGNVlxrJoTxRNfj7leZzfFaRdBXjTu+oPv1wEtZ6EvznN70rOejQREFj9FJARe5Og561LHtYi+oA+pb1XFEqi4c1G8kF5OJN3+c4+KVosJDpt/Ofpfu52qF8puaq0sjrUkZvdQz8Q0CWU4fvWUQrU4ydRZZqdCYw9yJgaaVbDDnGC3S2VKjedF1qsj+HejkAeAQdienpnJQ2sVukfrnrHr/NI/HbY2N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXaUEigxttoOcE3GtT2/Sbyvf4celqLCuXorv2INiDo=;
 b=GERZJeVAo043u1z7buuWZzeTvub3pYt6NpNO6KyODMkzhAH2K1VLp59qj366xiGbl15j9yV3Zc+46sGmHdspLY3i9Ogs6WDtqyEcWsVcnHM8TmRUk14HZMtjR6Fj/AwjGncCdSV+9VIUrn2pDExGUV26eVskGuKfrCfCTw16KQCT7YbI9aYv6XuYQEoY2PYBrB+Uo9W+eJvD4ipgCRT4m1JtDdxt8E8fW1RFS0Ijh1J2vR/jqHTD3DJxWVTz1LH8su5zkLbtH8PWqLv8bIlvQ/uMI80poHMVOacGScjbN+/9bicy1MLAiaSmkNP2u0rRYSmGNUU7jVjmRD6YU/xyuQ==
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:27 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::12) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 21:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 6/6] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Sun, 10 May 2026 14:23:05 -0700
Message-ID: <69abcccc388952b2ba0ab4b50c31fcbdac59184a.1778416609.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778416609.git.nicolinc@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: a4011c61-843e-4d9e-6d1d-08deaeda6008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6lmJsnvONCDdKVpCjWwF2E2bY7bC6NNO0xa437FH+XOrB3aqY9/BMdG1BOYp7qh4vNRCE4yG05qM2R3QAGdGZqMPqgohk/Edvtodp3/TgDK4KkEKJ/QO+UU7fT1YLTnLp+McKPUfYfq2QDUtrq5uJ9L4AUgbY0nTwS+nwxS+A6F9XBjHWYyDcwtahCfc1o565wraUREpVGf42c0NABq4EvI160mCkBBsIIOyO2pOtFA2X4hAqyZ2gOkZqMSXg6JULkGir1uY9/NLbk/wT6Ha72BvtuJpclBK1DNIh/HYczdxvlM2On99BmTb+EyookYBwGf1TsmVG4eiQGpHgy2YKXYSHKGcJDtQzJ65E49L/PZ2pEaP9vIZL/0W1RQN/yK08vM2W1Vtnpz0rCIN+rZ40tXSY+4UOErI56UBxxfIkOEG6BPjhXI9U/6h4LU2WH7plsVv4tHwofIJp0whoz15VsjZ+TIFZ4x4Awr9JxjkH3V0/m6C5sdabWB7msewCQO6SLvUXfl3fXbFr8C2+GULnQosmUSE6/hzCC+MiQS6cyg/X7zqjjOpL0SL/kBlispIMCTV3T0PXizLxJqDNqsaxSzLn5+SMNwkWwyODVLYQ42ZdWCHFQkknQ5b3M4FpzGpUVDo1tCv0MgDiVZz4xu7J93QPs58t38rcbOM5vpkz1dM2grEkj00k2XDvrBC6Tr2edA3ERqaqMFDQwB8JmGmqW2IxwO4Z/GEoYgYgjnouj0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vX3CDdOL/JqCDsxTeZz0evg3i5ahSfop3+VToRo2qIU9CdjSTUgkOC3PCjRASZWoAmQ7KzhLL3e8+JsiQwdHDRtyhB7G6Eeh/rilq9pwTJk3dY2MNvnRHi6o2o9Kq/9CDnNZGpko7aFqiEvZlyNmVhsUpG8ixb44XjoHCiYdZ7rfnafB6pQgkNMqFEcnUhUmi4RidGgBAXLDR2PFuCms6W8XAzW9pau/Gdv3TFNL1O4PItduco531kTsw2sK8+7xMVE5xha/lTF+IeOTvQ7BAG9daeL8hgVrMGJN2QqgOjhZlVa5Qph0PwLWy/lvvHa6wZE/ATXpoHCPLytTdv5xP+4tjDd/cExWTUmsKnAlbJ9k55wefD3AQCprx8ZWYnBPKkwEao4nq0aa8HZqN7Gwyb9Ae9Ss2SfFYjqFSi9Iiv8Je3gTQAS2qgERdoPM5z2A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:26.9398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4011c61-843e-4d9e-6d1d-08deaeda6008
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
X-Rspamd-Queue-Id: E6CA150678B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245081-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bb8cc580e7ad8..310f9cf7e5577 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5403,6 +5403,33 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
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
@@ -5617,6 +5644,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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


