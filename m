Return-Path: <stable+bounces-250925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EBTIAP2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E73594F9B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5674730E2ED2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565233F8704;
	Wed, 20 May 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PllL2kuT"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C13F65E0;
	Wed, 20 May 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296658; cv=fail; b=SIIBEA2OgUBDxPVx29+b1w1sLfL1jZazmCSM2eAeq3eSaDmLuFzNFg8l259/EMxXQmt3C82QVBeejjfblKBYsOrU4VUSpD50NDxdOFdEDhvg3h/iavfUMBIBXTE5/tcXxCfybUkMWqdUahtul0jW0zM8y7Hv1nycOR2wicadL9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296658; c=relaxed/simple;
	bh=Rl1EDL2FkDInefp/b0A1+Jx2EumMsxz2ZQseb04j9gM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX/oZ2xAeQueBWGyOEa3g4RTaqZU6KmBmNC2HVGk/bqHGiaiVIyS4pmpkBG11f3C3dgl1s68URAPF8J1tNENMmSd3oS8M+71RypNNyJiJH0Fs26F4NxhtjMJauEFZ9zJSt0Q/bDDXBnBcb0lK+1aT1Kx0rlfUmvGwn1H2czp0KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PllL2kuT; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnM5y+wae9d8s+zAeOirZw+YCLPGlTqcSq+k/hlqS1ycWVmnonp4liI4xCdGje1UsWf+0ecC6Ym9CHs/7DDqEbjdxBXcLpx0KG8tFgEV/klgu1kxUZXDouiZCOeM8wjeuDcEDvDPcCo6G257lgS4W/VNvqpUORGIZzChYOfZFhPUALOy97WZzbRY3eGXpVAi3KCSJm57xlgym7i+dT0p6Np2RKsjdduz8OVeLrr3qdf/JDS67CVEi/36PStY0aCUwvvldMerN9ax0U6kH99ZeXW2qwGjgT9tkZG1ALMUA3eHWwRp+g8GPfJF5ocSx/Os73STfVvWQcO4i5BMHwpt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvOavTmLsxbLCzi/JCd40p2NDYk9BHp9kQutDBNisiI=;
 b=fL3bq6QvxTQTrXbkD0nHD6h3/A7oZDiZun9ZVy54KDSCH5nHodugtc3KrlkaDAvToZ+SvpZGw3+5nnoizJ9tjGw4Lqv7wvb3+3pXzMrTE35ttr+uEuGxozKFXtobRL3sFcWRvCJtd3oqS1dJPmnOo5I3zinQqLQaqpkJBjMGiR9aqwW3S67O1ZFSLtIZwCn6UJLBQo05n8PWHBMFvO/PepzAWdkC+J9o0TT+nv4DTZOVxpWESRPQYnkPGqTcHxz1YvsoDraIxrky6SnpusZgYLIKvcWm8LjmENTtoqQipF6RRwKppoBTxipg6Usxkm65DFCAQFKAKN8NeOZgPAHxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvOavTmLsxbLCzi/JCd40p2NDYk9BHp9kQutDBNisiI=;
 b=PllL2kuTGo4d0egqoEDlTQ/1HyDHL2wTnKJFZusyu7LBVFvHMdkbI56RgpGhhwy6ud9huu5ic1beblUFQZfGcObNWpTr8LwtikSrsmK6NdzOOGwC47C11gcjlzDVKVXWwIk9UEKd0ITcvAH6/mUD0+gZihrYbFJNkMBwEDXpQuVi6n3aHt3dvDoJTZOW7NKIHYGuXqMS+C2tViqP/ye6bTi0CXrE/vmW7LZqHHJKLzXmVQm6sCGjhohixIX1RB8TV/U4jx3GTP7Q/Et/w8xzpWu16ef1R0nv56mqtdzsf1aPBc3ahKY9QQkZtSByD1scg/SJozxWpOeMQHE1LxmIxg==
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 17:04:10 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::46) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 6/7] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Wed, 20 May 2026 10:03:23 -0700
Message-ID: <88e75018e94adc2eb3db8c1fd97c3cc738c170bb.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: d8917b4b-8cbe-4119-8e97-08deb691cfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	W0YqxzuF2M8P7OIUIdVYf2H01xEFNH/a3DP7OfZnO8KbkcH7sd7wBrG1/hZj4NpLd4RNejDmTaamhNiaXIuHG0lwtcrdu4lB0upjmbeYvW+4h+A1YjAIFH9w4iNQuXtEjDgQuxCOxRC0WB2UygFgVBWmkCaVSqifWMDEKZgp/3ZHHxXOH9xKUKS4kPbRF+HtAk3eBe/tGKfLKgrsbdSABkZOic46QMKFQ3dFKsi8SqvrPSYcduALWjPvjcSvfK2DGUFkH/CeaAhIzdstl2HRf18XEgBZ8O9TiFMhgXZYOJpgD1ItdcQst7XPjKRTBCcjAWmlKw30jepv/Zw1F5jALbVaRTad1eN1crA3Z61poQLXgkOEstDqL/qsNcPO+lBMtcEpneQ3iugIiWM8nesRS8IEtuQjJrV//e//2U+0KFJ5VD9UYPxzbZtc+62WBy533wraUGqQncRc9keDdcR5IdYU2ntL4ghEVVG4ixyRN6djlaumKxun3qKMlsdxYVwgraV2B4qPdYhM8zprLj4eGkC1sUxMm0i0mqFACU9oTlDIjGXAIHNHRPeL2IFTcUTRCZvZHEkH7XjzKPnbzF09gD8PAD5QDsgLfcSC3T3daA0hCWVa9JdEDiB4SBHX81QqGL/EastQuL5C2sCqBWngx6ouE+Gp8kz2lIB6PeqUcZULIYgLsBRVrMWm62vdte6ZHk3ZpQHTGW142P9RbntvxnHmmU+Ncleg/ieq9tTVnSk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZcX64FyAz3bUbtUPlUM52DBZrOWfEpWrXg3OnmDGeG4DyqKxSa2N6btPdnpVmACzuPgyx2PLrbvufhJ5jC0560m+3/8wD08Gig69mPrhJs6QFZyV0e+6s5ZxaNYeXXvk4eQbPU6QipnNOwi4NBN2h/iAbVLdW2xscBpk0wb2A6CPS1xpjhIi2oWriWJW0lWt4+n7jqhgGj+AEPutFJvDrupqAtyAZMI/VL4g6D85rAiMczi0wTY8Wxyj/vZ27WiCLqqgMJHlg4xBRi4b30aXM27P94WTRZ7Nlk9mVTAHnHHLyRee58QS+8zR6cWnYXd/pLIoH7DhTjrzdysEZZP1kKc2RBXpRteRWL0HOsknJpZyVgQIIg3WqV1T6FHE7xbLrWk/1I9dcEAOebPqC2ejhsliho6xSiIFzXF4hTDyRmZljis5Apky05xy5D2N/wn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:10.7976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8917b4b-8cbe-4119-8e97-08deb691cfed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250925-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 85E73594F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
IORT RMR nodes. A normal boot switches the driver to a fresh stream table
whose initial STEs abort, so those RMR SIDs need bypass entries before it
becomes live. This preserves firmware/guest-owned traffic, including vSMMU
guest MSI cases built around RMR-described SIDs.

ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
and adopts the crashed kernel's stream table, so RMR SIDs already have the
only translation state known to be safe for active in-flight DMA. Replacing
an adopted STE with bypass can turn translated DMA into physical DMA, then
point it at the wrong memory.

arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
first. While the table is live, a concurrent hardware STE fetch can observe
V=0 or mixed old/new state.

Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
kernel's translation. That gives the endpoint driver a chance to probe and
quiesce the device.

If the old STE was already abort or invalid, installing bypass would create
new DMA permission; leaving it alone is a safer failure mode. Later domain
setup still gets the RMR direct mappings through the reserved-region path.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: Codex:gpt-5.5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9220c007ad25..851bcebfdb3d4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5731,6 +5731,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5747,10 +5755,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			/*
-			 * STE table is not programmed to HW, see
-			 * arm_smmu_initial_bypass_stes()
-			 */
+			/* The fresh stream table is not yet live. */
 			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
-- 
2.43.0


