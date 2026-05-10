Return-Path: <stable+bounces-245079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM9cDH/3AGoFPAEAu9opvQ
	(envelope-from <stable+bounces-245079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:24:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF11506782
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04D9C3016029
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D734572B;
	Sun, 10 May 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SOnHDhOv"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D733F8C2;
	Sun, 10 May 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448213; cv=fail; b=M2uTxThKT6qfQlEginiL0Qi660j/58eKJvk0o5XrpL05BtYFGbD54E6SQ1dcynb6iv0VhM361LLEz9IExhCbKi/a4VgxsiS0rxK7avXiIWHGPCX5P8ieePastRq1uN5B5wbNWrfsONmI37cBXpcNfumd9dHxKDfGFDcYMdE9UHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448213; c=relaxed/simple;
	bh=4Qekp1PND/w5qCenvFlByU2a57ayiyHrpbk6zw1iXYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Slj8yk4XFWAygH5iFw5EtS85MJGvYq6dRF4CssjmqmPuEZIzLFebwdkk6bS72jUCOHHXRTFrjwYv/E5Zmz+9ic9+j6DLqx3YKBzk/7HchaAuw0P4WnorJJyRLGKDnw9iE2hV74w/V5epqCLSFh2aJ/J1bPll5E0RRhPYEDYbJFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SOnHDhOv; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOpQt9k8ha7d6POmMq5j8yFxN633aGkOmQht2/LIwLKrCxMLOkdALq5lM+hvJHvoaKCCXqWxol2ZBmfeWD4a4LVaUb1VGN4D/xNp5HQx/JTey3ZnwjBWxy9CKz+DVgquQ1BMAlEvSE0jK3mtIzzcZlhXKbHssTovdOZ3XKDIHbHFc560noEJhq/nIczlv66wR5WhkAQaAmwaoGSWFGHmYzAEwDT3N1Boyt3eeFBE21JFmBO3qc7snUyu/pjpGyfEJLhGOrRvaZ18ZBVeDDWcLTQ6ko//M8v+hxXiydl0GrAayTEbxZotzgS51u0tKv4oZH1u87NzihX9EwEmwuMD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+PLeyt9yrgu5C0v2ywIPiuc8/SmETPwin3T8AhJz8c=;
 b=fTjnzvRI7SLBmYatY9ZkYDvLOke12ELEng/dhCtZTmpjv4215LSXa9E4W1+2FsXPIHSFeE6mkoTDv9V9lKny6eqPVqcuiuugMNln/xUC3moIILc+/RfcALOYYxvySuZZasVHMSVneQ+G4tFUeF8iu+LTrwqOFDN7aaz5QNcFCXJ1hfjLbp6lpId6jF0cJPtnDBTeQIkLri31GypsezS8O2i91fkuruWL+vcz8vMh6gDs58t29Z5sJRQDK8ltgD0TS9RtLkk9oP35hK6PbmeoO08QSRRhrfkIp0YECJLDamCARGViY+67UJ72WoGg/M99C/1wSNHM2LTANeQYLR/WDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+PLeyt9yrgu5C0v2ywIPiuc8/SmETPwin3T8AhJz8c=;
 b=SOnHDhOvq805N/N47oX4qYX+acofsphxO2WFxFi5QrgYavoZPBOyjOV2hZJ2f/6mlPPe01WusSnDqt1BNxWroacg7FtuI+hkw4yyRIf/dHrky3psRUqCybw769pVll2bZGyZGF8Jg4iChnED9akAK1wXKUx3MJeQCKhSLpeFmNugZzFsNKGz//V/Zp0OHUITvtN2mD0oE3CjCUh+aokwZBs3I0IoCCVPw4XiRJJAeohqQ7Dyqr+roIkaeFhWXXnlMa90cc2AZaNx4aekTlxH1iK9kzrDMqPsVJV4mxyaTVJe+FLSrqGBZZjCRiPmxL+lwWbYgaRs+kB+/ZqhUynU3w==
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:22 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::a5) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Sun, 10
 May 2026 21:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 2/6] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Sun, 10 May 2026 14:23:01 -0700
Message-ID: <43fd9986b085cf5bfba2c9bc06c0411693a361e5.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: b48cfe74-11f9-4544-9f81-08deaeda5d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8Lw6ER5hxZPN5Ixo/gPsVciuF2WiOe8ZdQ4vUfnIjtzqiZvWp/BFwve6wQqB0+GSYyi2fAS939aDCKlPqlOfDXFNQ3Hh1WZGHz/1VL6jhPNDu2EURWKU4uW27zwRJOtOkMCuBOVyHZy3bTOspa/JHT3lgpqbpfdGEHbsB9ekPfTmdYWVsJ1w9wOdla3RNUQWsDL+xcGX9yO64HE53l9zpfgOyyH6AlhOTgcUQb5NShKXU/91scbF14AG//xPSaieZzJapfL70mvKiWUhaI72FPRUW4WqYoFhAJKbPDH8f/f6ETiGTQROa6+Oyc2Udu/tFWBkUBb1kyi5iCYhz8SZ8mZY1fzFgCG3OH4RqlLSyAQF2pcb9RAv/MusfvJ4ZHauek5Pn0Mwhut4N9lqDNqiGBUrWYwlnypA8youku4kUFNvqGVWA9KjQMZlsqSY7Kn/HG8EVOFL56iaPF7vctRD3kb2FdHK1NKtEVHI0nuyjvmhcWqp2Iqa9f7RCwDReJFaQEgfOKZfEh3zKyYZMMkmWxVe2rS3yjDwPIRPx/9ZPPvHtGiEb13e/E5/oAb4ftfnUmnBQT9wmYTQYjnDoXDyfMjdd2STvLQNbavZ2GN8N2QeGcJH+EwCukQm7YUr7VR8ZyV9d75DX8D4X9v2xeVe7JdK7+5FYHwtVZHRV0mHALyv0pf/1Dt26HbMHIGCZ16J8/AxQvK25PHtzxXw/UpoP8IV+t/r+nCXxu8WzZbESjw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xvbEVTVBYcFp6Vn1FebD2Z2xPfqC8Hm/nkaw3xdBCSJEuHXWDZTRbMXG5SYuFmk/Eej13SzAIT6a9jBnoxFcCGNGeEWAbhBzXKYzMSdq7li/MFYwPJmyd1T2/chrGwpCh1fS4Pf0/4s9Al+uXVZrQ6cgtMmv/RbP9te3p/1D58Wv6j4shDEvkw45/fBtdXW6f9t6KwnfBOwTe2lQydureJYmBfE6WWL4ehRvY+1Z1AVvKoFdHw2PrG9iAKUurrdt95Z9ru3cLOUnLzmy7rRyduJaKEAnpm3WS5bns84DdzC9zYDO+LULE3nORH0LPF/5JrH8ME0ylA5jD3H6N//wtrUf9PYX87sSLP4mCz0lGmxmAGjhEnNmDeMflz8tUIjWnzJBr0UR2uz/zfR9FQ9c41wHU0Ij/qSwVKp64mq44JOgkNCVqISAkkATsl8kOH1r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:22.2305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cfe74-11f9-4544-9f81-08deaeda5d48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Rspamd-Queue-Id: ABF11506782
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245079-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bab60e4b91716..579c8af82d6b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4310,6 +4310,29 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
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
@@ -4472,6 +4495,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0


