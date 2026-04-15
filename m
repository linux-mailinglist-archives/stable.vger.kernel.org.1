Return-Path: <stable+bounces-238212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOyQD/j732ntbAAAu9opvQ
	(envelope-from <stable+bounces-238212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:58:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7019407CA4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14BE5303CE3E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16138C437;
	Wed, 15 Apr 2026 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWYvVT7v"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78338C410;
	Wed, 15 Apr 2026 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286701; cv=fail; b=BXKAR137hWRB0eohfjV1dxnT3LW2gMyBw3E0QlKyicNGdyK1wPvLDesk4eNx/SzX7o8P/zWdkZdWY9qTQBEY2YumbXEQD4OITh8sKRxRPdGR8n/MskDNd4nQZTNxMp0z2JDvV/vTi+DuEQcd8QJToHrLOVKvsKJpIWB1lhzVIAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286701; c=relaxed/simple;
	bh=Bcpm6is8V+qOlvjAOv4NmDLpgdO9Bh8dHrFhSsJZyx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g25JaQix3tRQvbPhgedLZYtKZgdAGwsCivD0Zn5NA+Tns3B8H4Stqmb+wy3HOYMTSpj8FfkvwXrZS06apKNaIbLH+ZQgiSPtQFQo7w9fzFJHvPmTgHHxe7LWzoQ1Kf6UcoLU5BSQrK2iyU+mDqF+KxRnprFXzx3dgikBYcRjH1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWYvVT7v; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfk4ELNQFyt2a9AHDcK5ahVcOUhga0hJXeFOJiJBztQ2J49fO99VRDBNyHH4rxKo6UIJat6E58uJokF+5OHIF5EsBbl2lXoWIVKrSW55GFcvVVEq11QSXTx8IjjoI7LvNnQNmzACqOvMDVPzAFMJMlaLncrF+8RH+1fjzDwcef8J+OvXC48KCoSCUAUE5b+cDQTv2wcfKwJ48Eduimi532cfZWYmLnHoTvGk3Y3WwlD54FYQ0Oe4p3U8uMyj7rHPqLg6SEZfHEHoEymUIxW34juDj5JGqp0lqj9ijINDmC2f3WRJ9eDeYL8T6BKzRAhu978lh9/3UdHZXaeNKQZhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+bfc2+8Hc2NimyZMAaU/n9eO1y9TQTxtnr/WOjHM8E=;
 b=Lj4C0KzgPpcqTK6EkqDoifj80GhP8xer6kcQXWagdbU9U/fPBCVRgICl3i2nOi8GXyeb6wg6xlOmKXuCXjNtM96E/zz6+rJG0KiVjOFCkCoF/HKaar403ySd0t5kJZjVACyAgTlSAA8O9aaiinOY3awxOc2rbZldiTogT+M9SYgX1NI//Cr5O1RjUmP1xhk3GpiUba5XmagRDM3kUzfWRvp+lsJJ202qux3XWejtol4OAFZRv+ETqYdc7N11ptXKeJ1yTiYkoNsJNSTVA8uq9IjuOoZ4Gje86i5cPVzCyTpZPttySlBd9NIzpiAhL7xo/9D8ZnQlUbekMxTWaNOuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+bfc2+8Hc2NimyZMAaU/n9eO1y9TQTxtnr/WOjHM8E=;
 b=bWYvVT7vU3UvqBqRdfyqPFYa8YO5M6G94xXcwc2QhgpH4HKDckPPkrgQQi3ovnEIoQAE0crkMYPbnjmm1IY+Ek448e0VKEqIicTKh9ikQXOxRjeCdhDCx7s3JGVnXf2CW2ZhaiDKoBA2du4x7uMgqKRdIGHDfOgxQkwES49KwXW3yecmrSJIC4bx4qT8KMCV/yrmrgXP4+6P0DtR6JDwapOC2piij37t6gcqSGG+Hb2UO0M339dTfdauY0dW7x/EpG3LVUQ+XwhxkdJuTSOrGYDY38zTHaC7vamVW8l5GyEningQsX5wAzzGbSLKHwim/pOn/Dgt8AttQ8I6i6I2vQ==
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 20:58:16 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::49) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 20:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 20:58:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 13:58:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Apr 2026 13:57:59 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 13:57:59 -0700
Date: Wed, 15 Apr 2026 13:57:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab()
 for kdump
Message-ID: <ad/71ZSRFgm+x3p5@Asurada-Nvidia>
References: <cover.1775763475.git.nicolinc@nvidia.com>
 <30c7c51c8771722813a9cf54dae7a1b5d0aeb65d.1775763475.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <30c7c51c8771722813a9cf54dae7a1b5d0aeb65d.1775763475.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1773d3-6bcd-48e0-7eb4-08de9b31b73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ju5VZTcHOUzUd8oaDloOzaEqaZJ2iHnVhO0w65wLD7/PpptK+FS6gFSebX7QTfDaZVyzKe8FgOxVRz8ToyzqkZYYDgbC8vj7xy0yaJpkWIyd8w88G959A9ynDeAZZcuoyYPKSNpEGIJZQszSA2Bs62idSyd2cEQujT/SZ0Ic53auldzA0Ha7trRVhQj7deZ3NQfOxI4iiaNTASrMoKjQt81xOt4uWi2MkR8Ho58R7ZIkoM625sdXHWhN0HE4A6rbgZfBOco01Gmb7653BUnnmzLsWT4emta/i8lVJa95ECajOHOwehd3e98s23VQMBBXZKGDbyE9D2Kyk20cOXUJzFYBsJg116Sk21apXLaFpdYl8SBWmyEEfO26zRLmsAFFeZuXFSJUdtt7nkK+UR5Zw6geuwhYh6H0ku3Sc4L43hB2WpofaaRxdaPoSMWmCOCFdPH3fqRxNMhl0lbFrmuD/tZCaO6CmKrzpvFkhSidMUtdWMwWyCIiCfrLHlVYKhFvdDSD8sKkxLPEM2ryuZSX9K+iMjEh2MV080elxxgSHzwkJkfdzFbI/nXY2Pr4sONH4KNO6ith5gDQdCyCA5fw3Py9k/M77e8KIrVZgpdGbwI6m5AEjCYFzWV1SNvruPTGOGlyxKt+b2cm8slUjHxVvv/moGZ5udMz4CU4vObh9smEqHCryJ9Rk/eq33gnRGXSE2GRIi0LO+urnAiSveDZP4dSEoG+5D+ZYEfdISikCTEGHla2BHXsWt+7vMJlPHOVCIKsTcVQWhzzeckQsT1Dew==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LpexONwVAsVVOD33vxeOXL0BZ9GhXU2IeJUTA4PInDYBXOjDX6ZnGUgWXL+vEbj6S8SYj5v8fDDyPHKfoVfLjtKV/b/Zv/A1zOk/xpgofwmbiRoZkQasiG82eObfcGXr4FC7oz1ELpLmiTDvOKJzHL/fYqtlys5VvIZmbpAo3CNep0DQbaWqOBtuAHjwAhX+eQfzzjfm7zBwNfXVhIMobd+eSfGtv4PRAnx+clYDL68hLcO4XlaPWnqpLImwQuoqktn9Ts4BBkltTQFu0CJdYvhQZKyLr22YrgiFE3BewyR2TcTBHu6OVApQGcyz54RIcSzckpQBRhwb9ncylQR2k60C+UCEyrkWtO7yyvsVS8tAbCTvMO/J6h5NyjvJUsRpy08a9j5wcPzpzAKsziikFK0G3Bcp+mmQiLNHKpYfxMbScFhGoP32YaCBsUH7okvz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 20:58:16.1421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1773d3-6bcd-48e0-7eb4-08de9b31b73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238212-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B7019407CA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 12:46:50PM -0700, Nicolin Chen wrote:
> +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> +		/* Enforce 2-level feature flag to match the adopted table */
> +		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
> +		ret = arm_smmu_adopt_strtab_2lvl(smmu, cfg_reg, dma);
> +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> +		/* Force linear feature flag to match the adopted table */
> +		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> +		ret = arm_smmu_adopt_strtab_linear(smmu, cfg_reg, dma);

Made a small fix here. Including it in v2.

@@ -4662,11 +4662,18 @@ static int arm_smmu_adopt_strtab(struct arm_smmu_device *smmu)
        dev_info(smmu->dev, "kdump: adopting crashed kernel's stream table\n");

        if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
-               /* Enforce 2-level feature flag to match the adopted table */
-               smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+               /*
+                * Both kernels run on the same hardware, so it's impossible for
+                * kdump kernel to see the support for linear stream table only.
+                */
+               if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
+                       return -EINVAL;
                ret = arm_smmu_adopt_strtab_2lvl(smmu, cfg_reg, dma);
        } else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
-               /* Force linear feature flag to match the adopted table */
+               /*
+                * In case that the old kernel for some reason used the linear
+                * format, enforce the same format to match the adopted table.
+                */
                smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
                ret = arm_smmu_adopt_strtab_linear(smmu, cfg_reg, dma);
        } else {

Nicolin

