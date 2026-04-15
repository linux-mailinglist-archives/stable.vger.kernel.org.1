Return-Path: <stable+bounces-238215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFw4CyQC4GltbgAAu9opvQ
	(envelope-from <stable+bounces-238215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC29408251
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AD03064882
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA338B7C4;
	Wed, 15 Apr 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g7stfxmW"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1C19D8BC;
	Wed, 15 Apr 2026 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287900; cv=fail; b=CfVKHT0A48UEh2xnSTcx+LdwOBLu2jcRC5wzsjb560ox1ioRiYwTeotXgX6Z+ZJIAgfUp4y4+Bz/W3YNQvFN65hVfceSdSmlDeUti8MDLBxYGhBiri/jCVcz7P02Zo3XEcCzSOo9Cfy2ObVoG4uqvRkk3jmXz/o1KbRZJdTNylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287900; c=relaxed/simple;
	bh=sjbPqbJVLRjg082kPrpfLJsgO52rFWnXK/ZEockxY1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hfb0CQgvTv3UhZLK14FQfMy+G37U9Cq4OuC0VPtAY0UdaNB9c2RVm7UEgeqOXITjr/4GoNMaEnR93ScLJxffo7Js1cuN27YBnugz0CVM8whs3UAb3syG+KXHYztWVr950r2GFTGN3WWw+2U+mUtLgiYI3DltMsTwgClk91ZAB34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g7stfxmW; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3JAqvpGdYvVim/Xs12WRdEzIS3nQYwtMp0D5Cn66ehni3+AFxXJg+li7osYfoRhJsYSKLmgT+SEkMqpHanecOuYctLZ/T/r7kBoZEs5m3e3iTtVf8rPdIHBs2AdXAjiNLks4Kq+v/ili3SYzXPHJmn/TtwiusV+vCWTDFsDqqz7RujGPG/rbEBb4DJDYtiJqd/rNHu+OGSe5DisrbGVnYrXadnccyJteQBSrKzwVymKchfwPo+BPO8G6bOeLW0NLsC4SEWNzSe3NWs6KDdrnfZH2QuGS5UN8R8eIbH5txe+G18mfL6WbB7qRIq8c7JhAOyzwbhnlthwiLzcgqriVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0B1Y4j0K8ZXETbhR3KC8Q7NgXYzHcnmUxWMuQs4JX8=;
 b=jlNuwD8dq6zN2mZ7Cjif1eDjQ0DsfNFa7RNGEhWvdLwflXPEcc1LCob9PE1VYRpzIOKwSmtGA1LUZGX1QZGW08m8XlYRieOY3dJwNTJSLog1zIWgaRFi9DJxvFT6Y8nx4nA9gVVkUFSRQkWIVQOf6xpTN2D1YD/pLEGWlNAQoE4Ha426kS+5eidkh9RlryEon5ZHGi3pUk3D9VaY4v7hfY10XmpYMregrbH2PJdkm5/W6U+UZje9m8kFiXAdel5r5Lf6X9aY7D2xz94l4cE3dZGfCLEUt7H59lYXUnHiHY9XgG73teEbXkKA4mE6o/kxbh3T3J0hYkgZySuNjxqZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0B1Y4j0K8ZXETbhR3KC8Q7NgXYzHcnmUxWMuQs4JX8=;
 b=g7stfxmWyfGIxn01LZDJ7e7fphtG7tMOTurHqGSP1SLWuaiYKmTZgjUI3qV1JJJWKSjI6Je+Oa1Tma0VC4b7W4+VCJt3U8lPsNUl9NR18ZBQmlaPE07Jb13KCLoTBKYN/DZWGr75TsvrY/9mjta7k2zVjmdZsQ5AK7ikT2bUqEMA5xiSAgJTRH0kxwzZ/me0Eo+9XYa6lBCiahJ0TsITJLFQBcBOky+qi4/RzyAY2Y7Cws+JIGVSdsElsCTJW63umJ4Jdua6IsdV/LMRiZ23v6BTWN4AVFh54siAniy+0Mpz7pqGdTN46FEoxD+XhDsRLL6dnFfjcXtcAEf0ujub4g==
Received: from BL1PR13CA0300.namprd13.prod.outlook.com (2603:10b6:208:2bc::35)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 21:18:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::d3) by BL1PR13CA0300.outlook.office365.com
 (2603:10b6:208:2bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 21:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 21:18:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 14:17:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Wed, 15 Apr 2026 14:17:35 -0700
Message-ID: <cover.1776286352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: c8983f1a-c0fc-4e97-393a-08de9b3480ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MtgEEttvLKPVB9b1bFS5UU7IynRQryBrugutGv+zr/liPa9hb3uUeU06S6oeHlDAUBCLw5tqYH8XI4vrGU2LehOa6QaQBHdNpcOW2UQu9tE2UWXHISMIRee1GTSkYbCPkfxvC/h4cGA7NY+aNdShXPMAyHX9ERL8f3uPVeBeo7T9jm3KPXnoDRH1K7stA65gEKnSweWg6UkeAkJCeTudEqhjGaFosHnAhKXHfiVKTK/G2eacpnEhTBngrsz3q/X5D0RS9ihoNzl3wCuMMWV2XlGWqtsISCohLxlFLelwW8lkKwHr0dojKl6ZYhTIueS5fUtJoyqB4pcpTqNTdm/K1fxujAzaAquELQ7bZBVNIv+AMq1tGyCfXWH58VX6rUcK9wrWSxslKXSajmMUiyAE4a16M3nlqMZOyOEdrRQt77NZH0cO1Ktt2NpU16R7IomCnVfOVCcILkuJnijoGqx48ihETCQfxVWQY4DHsbIZS1jCjpa27IGKiGLabcJeCHw9y180yH24dv8BxNA8eUxWix9fue6iN875cdv2tvIdxvGjM9wkuZ3A0N1vJGEwir/9SQfb+Wl2hHZUtzAg3CmS7bFDDzD/1dw8rLk2PH8KNSy/wJ6Bj1sF6QiuAwqYf3obC20x2embP7wUt0/5Lq5r9tE0qdWgoPa8rBk7nI1BQuttNeE9fQdZyJzQXv0MRckgObEPitZKnMGgW7poWMHbXBLjuWnLdiQjS20ICJDoTdc9V4DDytMZ3Q58vBeJPbd+sH996pG3wYB8vspeC1HicA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0n9V1WUj6IMPzuvTd/4DJKXYiODzJReegtKJ0UlRKODaTdCl7WarRFxCTE6KOqJeZYshtvaWxLEOLQfSbmOsrUDKGykg6cklBs/eOUGj7bFIb39FkkBRs136L30OGJRMquYozhx38kNVIKYCAYoqA+s3s464QmGm81wPP0DMjm2fbSMnudiEprte07k8AgtSXsk0TQrc8GNCZFwDCIpH7xZXWJadvwhqr5GfwXgVllObWiT3TtIjADS33wpi/HiOhk0LJnZGSsEJS2a+6OTN7JFAOGV/zfauKGWdQMavcJgSB9H0y3KaMwRN+PFMNYGcmzdG2s4aXcNCtHC3sVc3b73ZklyQiu0YxyVjFOPJsiY8LxGNigAloVSxfnPIPiuFiPaZBTcTajJhBDjyhvVX7KlhWfLsGEkR2P3Nm+Hzic2tQQBcoYKFPOs3tjw5i9e2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:18:13.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8983f1a-c0fc-4e97-393a-08de9b3480ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238215-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AAC29408251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

In this series:
 - Introduce an ARM_SMMU_OPT_KDUMP
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Map the crashed kernel's stream tables into the kdump kernel [*]
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.

[*] This is implemented via memremap, which only works on a coherent SMMU.

Note that the entire series requires Jason's work that was merged in v6.12:
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
I have a backported version that is verified with a v6.8 kernel. I can send
if we see a strong need after this version is accepted.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v2

Changelog
v2
 * Add warning in non-coherent SMMU cases
 * Keep eventq/priq disabled v.s. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (5):
  iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP in
    arm_smmu_device_hw_probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 225 ++++++++++++++++++--
 2 files changed, 207 insertions(+), 19 deletions(-)

-- 
2.43.0


