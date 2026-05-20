Return-Path: <stable+bounces-250927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J6SHArrDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:10:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09289593078
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127D130C1007
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C33F23CC;
	Wed, 20 May 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULgD6hg2"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1573F65EA;
	Wed, 20 May 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296658; cv=fail; b=Onw2plnlXW0F+BBER05jWrdOpDqzFwrkvFKtvI6Il972Pz2CQaV99DYPRcss5QjhVK/LRRpN+vtWjNVIpPTyZxhuk/blEiM+QxrKm8D3gdqBd4o1soIFFGE95cMkZpdfHJaUcbYBYyhJswqQzAhA4XNirl8ohjVKR6w+xu8w+mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296658; c=relaxed/simple;
	bh=e9y/NkLpSLnD1LfL3rbLON74NQ9duPVJQPauaObVSck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpp6n0doXXuvn3TTU0QwcMr5E6mgEHaqqEM62ToEbsQtd8I+IYen0b9sfy53beg1Fig0AdYgCSwfo1NCsej16pNiRAlA0F2lMh+1vYHDOuMEn4dXfnN1P9S3h0oQ457LvYnE32zMSEmSkOYy5cCazpfYcuCCn3fjuOMDDhz7k7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULgD6hg2; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g58L/tcAJHTgfViUi+LzBtEO+jkWkF2LHShtNY4mrBKxRgcmSqVzD0KKF+E5yeF5tTdkf7ro3zqiS8RytMmjPnOAZtalQjeAqn7vzfC84ZOdZf16qN+cBIZ8O4l2pUb5JSpoQvsUwaodfrkCVRUtLO0F8SF+ygrIbNBTR+adGpVG2oqYVtE2KzyCT1LwyI05waCCE6eYwjUbYVPrgc9yA3qhNfubcP7R+lROzVH/e/2f9N904FvbOIpgd/ACsGRmq94hUO6o2oVzJWpFBRfJJwvrLGWqKIlyURXrqQz0rJ0nyjFB5bDy+GoKgttHhbTEZH0iCh2wj7XXXuyusO4tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjCFc/eOsYiHP6CGzZnlON/0G1ap8/Lr1L58erICpPs=;
 b=Jehb0QnTTH5pK05bgAMCGwhCC9ppnWEKjwfz/paRJfcESvCIbYP8Am5XR2XHJSD9Dn7kVL0VZ3+2wE4vAneOTrFXdebA0Wj05jtUCWEc0LYNw+YxvIKir9FXHJC7lyTOhxc0l2nw3yZ+Fz5aFRp4A1NsSkIJqHWHDqdY7cD3wB9+s3ZG1NEEyqo7YPlsSKAeYZKrsMuAJRAItPXg5BKDrRFUZtIFHqquiff2YPfnwNxQ3+7xlrl1e82K06gRTgaKLXZC3L5DAluJpHOTIB7Y3fDBBTyixrbVdhph5NJ6D6Wn67euEZAR/x2ytzVczfcHBZbetVBFIhQ3puD5DfDm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjCFc/eOsYiHP6CGzZnlON/0G1ap8/Lr1L58erICpPs=;
 b=ULgD6hg2+IiWiJDE5nZmXANU/OHyS98rzWAUW03Ygt8QEAv8KNuhxxvQXNl7zegCsck4ogZGK+l+6hSZrvttzwrq9FmIGXoG6uutJEE7QxuNl7cvBB7uGvJEJP+Q7Gg6uDJ8sOE+UxQfEOkMgjkMF+QZPECmT6JrLZxIIaKnHVwop1XdRwwde7uq0yxkq9LvL8BFqf463pqPsR5KN85mosQGa0Nw50nKUIeR2/tMQi380lwvWS0ZofTCr5C3eQoyjO1Fzt8KYM6dAYz4nPu90/4UjCwhe8ojSGjpKRQcjE4gYOyfO9LN/IGByql9pSFekzOW0RV60lU6ywroT6utHA==
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:04:08 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e2) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Wed, 20 May 2026 10:03:21 -0700
Message-ID: <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 54abf67c-08f9-4864-51cf-08deb691ce94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|18002099003|22082099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BbZoYjoFnrLPOCxdRvndrEn5jrH5ooCnpFTTmMsqhAGdiQ9VvqqbN63lkIx8F4eIu/GSHZhccJRfTnXb8Hk3b7I0TxzA3aQR+FoASA/xVLh59ut8CFOYnd/ncO8zvahNQfxsIlXw1tUjPHHUR7esfs/fThUxQBb3HCfjF3os0HIQ8zXbDdrQCeiWg9PQQAt/CWwDbBlFGjHdSv+ujf/Dzppxl4BRHSIy6yVT+fqgAeeICCzZZwhonx90v0KSbXixOAw0y4it8eu7jF2JBqsnx4Hw6VpGQ1MLQOad6/qw8m/BfWA9KG5lUqGOW5i5msKH34fleOMyqmm/qUVPcjiF6kJXY2oF1GY8YREZF86e9EYnt4KhWjI8pJzXLnUqGdgpkOg7N6/JP1j4/wZNhWl1hzyzsGYRaxkuIO3tfYxxPhZAoo8Gu3hGhJ4JhV3VYTEJfUUNps4s/CDQFmXex1fQvNR2bjQrPQjdgMIup/31Q53JJOQib4hbushRODCCS5WpuqaX+cZLnAd+JRRsGZmB3piSnTSB3LribGV5v2g++oOMpOE71NazQrSwS6i5+S46m+AKA99FIkC1vUNlGCpdA+7Q3q8VMdAtczH8Eou3IoxFZdbVO0LuiD3SOS/2wGZ+73F9/8ZlVn+qyFfz+nnMZA/hWFx/+R79rnVr0WyKEwYM/LC8m+fFMpGyxxTbU1rEkrBlIcFfdkxru1xlNcqCsceO1+qgZo/E/GOwz7MxuRc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nbjWK6XJTUmMrl9xLgbNsW1ypXi7OU/3ZZC0Wj+I0gk/t2tDonmwYj9bD02W4q0H5v1rA9u7TZG6kXGLv3Alb3omNEB3YEyrKEBKtu7I7cKV802JsUXA/K0CMu94IsNYqOVq0ssf+5B3OraHexG2u0ShZb8g8uZShw8Dq1otEwA/MJPVT0Xxefo5Z+gB8W9zEiuacJbv9zqKxt0ha17jIY8Uajy3sSQ8FvHYFq3d44ACFuPnkVm4akZFsmfhDBQPP45H/rK3aZjavyIJEA7aMDEwbgV5R00cGdwMmHHDiHqQBk4eCrjhgwKdzwkFrrAgGMhVD2Q37ZDI8y9GnFqEa4cjE31629CQ7nqZXWYWScjLZV2clURzX3S/+DYA0a0forK/0lp+AIiFQUQinYRjlj1Y1aV3uG50+JdgrfXwO1RmU8Xe4hyKNFPrIX7SaT3U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:08.5211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54abf67c-08f9-4864-51cf-08deb691ce94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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
	TAGGED_FROM(0.00)[bounces-250927-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 09289593078
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Also add some inline comments explaining that.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e00b28e36f9c4..3f22949391c82 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5161,21 +5161,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 
-	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	/*
+	 * Event queue
+	 *
+	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
+	 * tables might be corrupted, triggering event spamming.
+	 */
+	if (!is_kdump_kernel()) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
-	/* PRI queue */
-	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+	/*
+	 * PRI queue
+	 *
+	 * Do not enable in a kdump case, as we cannot serve page requests.
+	 */
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
@@ -5208,9 +5222,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
2.43.0


