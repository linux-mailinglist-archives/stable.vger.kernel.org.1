Return-Path: <stable+bounces-250975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFkJJsDtDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06A593716
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2F9031282C1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD83D6CB7;
	Wed, 20 May 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPLBIl/E"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE428DC4;
	Wed, 20 May 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296778; cv=fail; b=twInLU9XBvTB+wmtIthIObP+x/uuOmph6n2xLD6aNRq0L+E/+2uuoHLsA+Rmi9YoufuvWPQZK0jQRMzFkqvTw1h7TVrGd+gr6790YtGGab+YMpYtakVSIKVtQOnNfCqIObtc2J7CV3hyeh0H6qCDr2F6ekqRrp3fRIfCfWbsBV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296778; c=relaxed/simple;
	bh=0a6Kfe7ifd5nwj6tl9ZZX8vbObvlBJbGpjhsT6j2PYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YscPycDnfZdBDleqaMFB8kLGBqjvgOxaOjIoHn1dBYiMErYGI13iUh/HCCjSIOloYl+rn1jZEImexKL5MFWsPxn5fhwtbCyZCps8W2s/ajYW11bpRdz+VVgaV7oOOFgA1M33d2jjXDIEJ04j92BxlTxtZtCfrZFZVi8+Ucz7ecs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPLBIl/E; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxWQr5zyG+g3QeIqNpIeruNRzkWBkcqEUMDAS6pgEMYQpp6IF11MDUVw2c5pmnotWr6LmoPoRsgv1meuNyIBuMjf/nJ+bNzv1J6gOPZmt+oo4TScGGSaETX82We+gKe5EIUcfEeJ7NKPA2BADbx2pVSBVvRRvgnxh+CVntrekoprL101WixLvtUtCj2GJpgQStFw4g4ofqro7Ne9shSqz/3O12Zam4IyJws5QSXoApxjOmYAkmtxKKSBKzZ4K3KBAGiyLkxJXH43rCnFgRM+K0sjy+D6rE6U5PZwa/wQfGLbS0mPPZuaossRUdGMSYiXibP0L7Gdn1lVPXXaPSBIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw9X+/BT5rBWodt7LOlxqB6eHLcBfu7vwEtWtNrp3EQ=;
 b=JAQ4iN8qlXvNZDmGbygfGdpB2uBMVQ9yJlmYEktDDmctL5ZpPFZm/HyN8lWP7bOv/YYJTTUKG4XhWH2gB6tCAPxNATjf+J95dEObXhgxReQ1f+M2Sxv5M5W2e+bj3EfQf2+gVydPbBcY5sgHFPK7VglvA+lXnzkdXPS+ECJLaQut0gDCcARqWpfH7RMr7ejhMf+Rfhn1b6yCEnMxuL8i3wZeaCV/42Xgyly1X7CeATWEWnkeT0LZYClWQtSPFPOHYpZAlrt+wSNA0ykIhzSpwg1xdvxix3SePQomr1gXb5pxSmiu4hKHY0bQioXQn9As66JVyANLxue9SwP4Tywr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw9X+/BT5rBWodt7LOlxqB6eHLcBfu7vwEtWtNrp3EQ=;
 b=YPLBIl/ESmfsUo9V8Lr+hHpyDbW02/CVVYEmp/taMOKJh5Y3LmZH2FIRQNFQV0JzVV4rxMKKpEJGFS8J6YEwPjs4qu9BWR0VeghHes4leBfpxUEBypcfMNOUc/IEszj4UPVlYCmDBaoErOzfTnP/lKuobOLbcDoqipXi4YxgAbtLL6M5Rx0KSi2BJOX/jSs/uTUOQuxANq3e0ipVcbEAsN/CXL7WdtZR32+njSOzV+V3tMMTYHesvnyiM6XJrLYgPzzBrAlhsSzI9aipdFp/l6C2PsE+2i9ZCFOOEBnw3AP6F9Du59mOs5Ir/ZchEw+fhZO3icUisRaVrSi75TId+w==
Received: from SJ0PR13CA0088.namprd13.prod.outlook.com (2603:10b6:a03:2c4::33)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 17:04:07 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::eb) by SJ0PR13CA0088.outlook.office365.com
 (2603:10b6:a03:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 2/7] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Wed, 20 May 2026 10:03:19 -0700
Message-ID: <89cbd3760a13f11cf63f6ead12f44974511f308a.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: b04ac986-e3d9-4e87-2c45-08deb691cd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	EltdoGG8sXyQEwuG+NYOx3ivBCTNgi/pL1nT7wPTWtIdg89Mbp9c3wVixYHnIx4B4KJDCWHcs6C9WgkBJ6WAXS9gIv5qpB5VsvHj8OYE9jwNcL629gZ66H9DUeke0QCyidNuVr9AzCOhBYppaVBvqj9Q5ewk3obJmiVJP6/VyvCCX4ukWZJSFeMjpJ4eVvcBRrwTXd4UJY6rIN/wCyBGRSdmg3G8sPplFBVZllzYMPolQ0cQ0LP6briwvV2h3D6d69xbCVvUJLYDGklaHeHR4vK+NXLnPO3qbb6tni+eMdVHNBySG0TZFq6zzq+F8k8YvhgUercNRSt5YazTu9lGjHIQgFJjXS4iwgZzRtu1e8HfeWbi61GBSsyx1iMz64DIVzXxPtZfXL37PypFeXdn9ZpfCaJRaXTEnpfakNqiBpkVwCTIC9v4Y4h8KzcPpzmaSSqTMIBsZOgB/03nftFUGiag9D50/Oh/6AP0ELEjUwuXfN6Fi0Dku9PwnEit1jJsjhUJ8ZTFBXr/7Zeye+Y3y3qLjC0MIlGiM6eDFZssgFCXixz2Ld9K+QivtuKwdk5Ses+rqOyTXvdg01RytPOaBx4WimZbcEDfV0RvCkRdiXXmu8xZhjlGSsZ+Nhb/hrZ1MAYBUL0vYLjV9uL9K19VhyU3sSzPDtlV946Ktt4Kv1ewAXG9xCeCicb7srdQaTNbmzjrav7ELAMbh4lxgDMv8d43avqtDpcKI/XKFDpreb8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	19ZFkBompdYlpdjB+aorZ8gKkkP6Y248zZPuCWoqgcOxuks4W7nXTEC/OH59A8ILL6fb/ed5gX4tDPr1DF0EElesszFkPmtyyebpYn+qs9QH2PByjVshlOo/v9bRwtUP4bQIdT11dZrQdjj/2qytv6cst2n/zsUFQbXhuQCVDUSxMQ9St6zBgaveSLsmzikBBRoK7AC2+c7iRG5SGOsdIDYaIztCuRHv+4FBd4j1QOE+eCnJMl2JPqLkEOSqdJsBRiWswtlGwXBhaUX4yBezpSst1jo89Gbya480cmt+JqV+jnpyxLGqUBwLU39fgIqrmt0iQNkBrTFjIQv4imJc1RadMUuP3PXAm4uuUXU9JcJdIaP9VEr7lJQ96fivaHWtxNNMBz8qkLCNuncGhkzGAh6liApoJ3Vdby4V7GIO2gWVNAcmBFvD0FphF6fO4bk8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:06.3741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04ac986-e3d9-4e87-2c45-08deb691cd4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250975-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3D06A593716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aa6837a5daa88..2d7eb42449eaf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4268,6 +4268,29 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT))
+		return false;
+
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_ste *ste =
+			arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
+		u64 ent0 = le64_to_cpu(ste->data[0]);
+
+		/* Defer only when there might be in-flight DMAs */
+		if ((ent0 & STRTAB_STE_0_V) &&
+		    FIELD_GET(STRTAB_STE_0_CFG, ent0) != STRTAB_STE_0_CFG_ABORT)
+			return true;
+	}
+
+	return false;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4430,6 +4453,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0


