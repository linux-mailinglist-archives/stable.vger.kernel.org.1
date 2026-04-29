Return-Path: <stable+bounces-241829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OISzJlCy8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:25:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 079744906C6
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752A1306500C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F463A6417;
	Wed, 29 Apr 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+zTR/Zk"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B53A5444;
	Wed, 29 Apr 2026 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447334; cv=fail; b=Dlvq8VaIDAech2xY0EhbBAoaFJcYrg93ihpX7n6u6mkAnEPVWWUaKVUqwFcuJCjpUpH3TLxqXNYopdAvVRU775jBrhwRhL0qSHaY5HAVgwoN2bEpHIEtZHKeKrTOKNVnaKchrSVS7yg7iMJUX3bl4/GwXl0Y011k1kA8HnfBq4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447334; c=relaxed/simple;
	bh=YZR9RdKqg5sb8o0ABqLGH/e+SqZkAYwScBDbxrQLJQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFwM+cwKqpvJfluetZaRu/0cIOQpcTj/wqGbtBgqYzdGI2G+RqbHj+8r2z66xpcDBF2rdoPTOyp+CReorLyIsGg0XxbPXjDwbfeP0idV4fRsZ8VEnF6iVsoJaf9uubEukET4fv9geGBpDtgZBVTOnMELy40RwM0LkxmeQr34B8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+zTR/Zk; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEx/OMCaLIG60NY7Z8UJKiujvU7kLl2wdYLs4n2zHBz9lB3yEMovEcpXOlSprFuDXrhrnNPd56RRNAOB6TBfvB5BAVrNQRWJJ3w2In8AYVOT7K5ET1ayWW9jp1YyJ5PGP7GX34shII7144kYMJwyQXCDlwSWAAFpdqMxn3zNjGldOUXTfRn3N681JG7IvijmafqQHXpqbECVlsV2xy9tBm51qckONqFevKU/gPCKbMSrFLiNd5QWMiIHVzLBXEBh42gP9ZAPtDsv3rDbMxZ/s/Y1rJTNdRRdtX+Uy+t+RHQWI2zPDsOjLzjD/tW4PqHz56tdU4S42t1yOTjEg7OXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTyWdc15vo8meD1E5rtEMc0yaOYjkDdU7NC8Iq6dL7A=;
 b=SgKC8RqCsctVCj3VO0w1Vl6IyKjS3jLn1C5CUsBl+CtcwhQG1xDtsK6YHyvaXPQJm5H2F7PoEtReKZDbvkDs7kAjeY0vChW2nyrfW+usr1biGoheaHMj9vH52rQ2JeBc867DeRbczARZHDuQr6cEhJ0g2sK1hybVWweT+tDheurA+mQAxLs+fgBymqZamlyZingyOr02XEyLiuV7Ybtl4tOw0otnWY3yC9ebl1sZ+EpdnbEOSbGAS+xICrw3aYznl5q3tQBmWSUbxTqND9mmAKZcrSttHyGw+KDbNXhfD6gKa743+0oAhHvr3clW9PBhJkcYIuVh5vhmT/0RL9s5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTyWdc15vo8meD1E5rtEMc0yaOYjkDdU7NC8Iq6dL7A=;
 b=S+zTR/ZkXmwhGxN0Rzk3Xo3nAN8XGAv0auvQjg4YdWdHUS6nT+3RQCGgLktFFZKE+1CufJ2Xc5aFJ6f+/sKYEf3m2NRs57cXa5liOpuojrx43wxQUp6FeL/+JyTUqo4CYRETkv2eOvdqr6a0VZ7icAw5wMPgtdo6PWZ/lAz+urEm4V+wYCMVIm3t2Nzp2zCPmLRI64wADYoBCPDLhxltFZ7ooNRQD1ONzRF21Dg3KJokkN7eTV81ssbgCivhlzrByGPbknVMEGaTxulhokOGZJyKuqhj6tFy5wUewQgq0Pf5sB1bJYFG/y5bCn5TAtML8od4gd1gD9elCNu8EnU6lw==
Received: from CY5P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::9) by
 DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 07:22:03 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:930:b:cafe::68) by CY5P221CA0018.outlook.office365.com
 (2603:10b6:930:b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:22:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 00:21:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 00:21:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 00:21:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v4 2/5] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Wed, 29 Apr 2026 00:20:50 -0700
Message-ID: <1d339a2353e9793c46853192a93d28fd7caac4a1.1777446969.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777446969.git.nicolinc@nvidia.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6596c07f-8b61-4937-5602-08dea5c00285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kcZ0dHdSD9WZUOkQ+/Tk8rIPlB9A77FkbbwBJys/nI1EKGsl3fiR+6RlaASSAX0v4XWIAXCCrQvIYr8RwmLcwdhUkhySs3HS/KSYMha+oGEhNkhDsK65woKtEJZyUZSOxVxogHL46lRAdfaruPajvxPN3pCmoUtolX7Vx50LU56Fx489cU52lVfb+PE+WtHrIb0na96H6n36jjjYOrti1Ax/grU5UO+KZe1E9mfOVjloaxmb1u1gxR4omStI6WIGHbjOOYKlIr2bZur7hHtw3D5aX+8DxGeLWJTPMwGTgjhgXDJVvYV15rQR7EVhL2SMLGjUP1p20z3vh3/qGL86sYv4U8I7COk7IFxbhSMMDBTvrjSLlghaDGXFWDhY+T7myHN2TGpHAMs1Zb3jt8JtnaNwmcdGL/oKg3gTOZGY+XvQ+0b2cwC/Aftw4mP1FofKI8mu6oq2hh9Q/RrE8eB6f2CUUFzWgOuKl54wP4V37zoP9uXmpBdxlX9RWdpxFFkauoU6f+bhOmNp2zdL2RWNPhe55o5i3zxqVAICNRgpDDSlufIUxJ9JkZ09m/OsgQL6fbZpQSpsSobLy+2Rp7KUt4KxpYcz7FvxNhSitnCoIEIt29cm9h+nl3mbQwPij8IKQVwRm+RnJjO6Y2hiT2xyefqzOXvCi7FuWguhC4KjI1DoigGBC069bxG068gRpRfixs5DD8uzPmSeLE9UWWD2WPEuNY7/vvpdgMGFC25HSK+cAbpuWJ/YIn0DwK7HvHEdTuTe7nCqug4Q5AaKEvgycw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BWCWMamkD0GlclcAeCi5YmGAWoF9TL0JHVP3c+wiyA8pke04gwF+3cu2tyPvuAwNLUOzmcGyUOAykv59T1bssdFaFZgL9dYIo7OF7wd3h/THW4nDNuYxN5KO44kBNaPg5mX1koDa3nn+nGt8T7QR2W6pys9N4dPwegDGwulQ1dTOZ/JpYq/cjIrOEkmBE8IGCTBMo/x6W3gv2CrLlBftjjzlSvK+LxA+EVgnpQnA61eZMEyTKPAT33Zg0p5WFrwOiOVXGAoGoLhRQAvqs+14yp7YJfQUyZ34kRDsKOnU7pVGdyr7S/zltHxczYua0iThIIj5DEuoYVHjg3EKk0nrkiPDifVxohAgcgikasaerOj7yWAISAaSdP0/N0tVsBzY2cqxMoNUqeTJpu5dd5ZtJdEnLaxXwb/BhyRNfqBe5g/FSfrfLQ6hT/69mz424bpz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:22:02.6398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6596c07f-8b61-4937-5602-08dea5c00285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
X-Rspamd-Queue-Id: 079744906C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241829-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fbc0fa6f182c6..27b84688bcc99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4309,6 +4309,29 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
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
@@ -4471,6 +4494,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0


