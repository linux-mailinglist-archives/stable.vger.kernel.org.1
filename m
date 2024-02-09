Return-Path: <stable+bounces-19383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A584F879
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C641C1C235DF
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D891745C8;
	Fri,  9 Feb 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xelX3b4w"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468238388
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492406; cv=fail; b=Rx5G1Ym7Y+LG+1l4dAXjMuXDBRPVCYgP8F5E/dUIsMxAMnFRx8lEfirOlqe0Bhl+b00/uemHMF/P3/TU3UHEevHi5e7Ykl+ICFAhgmXL3aEc/zUraJDFQBs3pvNTDrETkShw82W5DavuBo+zEmYjN+cLjrGiEMy0ycjfna6nWSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492406; c=relaxed/simple;
	bh=I9L9dFEN2GI5kkTAhy1A/XFV86+KNHi7FrMoFfJ7vOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k4lzNWAbtrB9jhPqA9CB4FWitqkvqpKA8532gbBBhHAnQ8GINmiD56q7CdT6IJ3m2/4OvzlSb3t1vbzRE4z3ZNhU6Da/desF2i80lcnMEA4w4EyN2XbTqaPxpjRuPK5C78TApHvWa9Cjx/MX8rgMax4g+o91Pg5IemMTvTI1tSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xelX3b4w; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5TvbVGNQt9MrJMrAUBAnyQ8pgmDHIVqkx05Xx7OZ7WczkRwwdqf6PJkc8N/raR4SjEOp0VzbwtkvBugM/RAT+F3XcU0T37Q7bbzxlP4PA2cJBuVYXge7pPiNa4fzeqFOz7WumliPmUxjVK3wDOrBvkLtiitkAz2bKDeWfbCX+ZXU3ysXBP1xrKMksbJGQPmd7w90dZ0+IFP2h6kczit4RtRyooAm+q/wOcH6Gap3SzN1ip6vbpsRE+f53RCrhVH7jc6OHzVkJKTJ7Xx8jQ1LQ4ubKDsOf8pX8sq2W3C8L9HSATQF0pU/bqgj1AGYQNQfjbluCgayC/ghVEOCiI8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WprhPH2oMW4hzapOsWZZuhOuIs1yNfrWG1gg0eP9qg=;
 b=PS7kvgEck92Yk69tZm0xL36BN/x5P5xWXofuH5ztxat6P66Ye+0p51M4SudJFeeOfsJjfESfy5K7h1VpBObq9P4+iG80b+50+j9qMTgC4yqm/yilKMprhNz3UjaCvIp+8I2ju/n+XNDJfs2iqnh1ckRdfqQinPte0N3gC1r6rru4vTikPeyfdLGkexG47o2QNcSqxbvU/235/XBBlWxMISg1O7Nw30ovVBfslamou9gCF9JSM594Va40PxZ0lPu/icpO457SEXTfbDHB+oxPxugPILGzq8REbtV7kiBa3QTAzOQ9WwFy5eGVhnmuIqUdTqFbt10vdX0VRjLGPg9WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WprhPH2oMW4hzapOsWZZuhOuIs1yNfrWG1gg0eP9qg=;
 b=xelX3b4wTLnEBROCek01JJdBxKYD2KyLdk95Nu6SRSaDEM/sXIJCo9B9NX+n8zGPiuc3WEMGCMPog8wDDOCSM6dz4rjRyHqgNe4J4Md303zjRJfO1jDQ2XSkNEdUC9lWBp2F3hgNkfXh4hTRwhLXGipGj9uap9ap3nPaRHugeZA=
Received: from BLAPR03CA0044.namprd03.prod.outlook.com (2603:10b6:208:32d::19)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 15:26:42 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::33) by BLAPR03CA0044.outlook.office365.com
 (2603:10b6:208:32d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 15:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 15:26:41 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 9 Feb 2024 09:26:38 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
	<matthew.auld@intel.com>, <mario.limonciello@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/buddy: Fix alloc_range() error handling code
Date: Fri, 9 Feb 2024 20:56:24 +0530
Message-ID: <20240209152624.1970-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: ad44a66c-96a4-429c-a579-08dc29838433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xq5h2kfhr0ScQtYiyLYgeCyqd6M60qi7bT/diY/1kcS6QnHIFMMS/F7KIdTRLeLTWmuzw1eStHShx3MYsy2B66rlOkaBtEAHMp3sfLGc9PuJqlCejatT/gDaVVJkcvWKgOBlavsrX8ZEMg39tx5x4dEUIAasQJTSx6W2N2eTxSdjB+1K30pvBUGId5UYFLwjG459hFu9Ran6zcZ2XdazpDXslvrO1z/fTitU8EPuCR9yQdxvgRmozhCOcMLlEKmwpJnyOtXNsViD4vB2GHLrlNHmHjZy/4mjJgzqL08bthnQ8MsxOixosf+GotFkE/tlY9YvuD7D4PkDlfmK+FmTQwl9Ur+/HT5yUGWGfgMb0vOGY4ikHNPVfxoeIRW8P9wFR0E/pPc3f3GaeTssujtTc7LeHGBhuX8YV7ZYr/F0NV/CPom+fr7xUjEBKlZ0Smyy4JCLZ/30Ha6knyIJc6U7KzEATavL2ulYwVu/itCWzLMq0Fq1j5XvqAhMRa2WVTXoAdCkLqTUYB3ORJLTY3RToIayQYAr+jeKFmNaii+D9s7UNleIA3iUxQSBppGqAucB21oQtliT+kqBUU57ABWjPH3wV3VrX3RiI4fTqB8eXoF8P3SHZxVGnRDAEwRJHhW7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(54906003)(2906002)(4326008)(83380400001)(110136005)(356005)(336012)(6666004)(5660300002)(16526019)(26005)(86362001)(1076003)(2616005)(426003)(316002)(966005)(8676002)(70586007)(70206006)(478600001)(8936002)(7696005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:26:41.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad44a66c-96a4-429c-a579-08dc29838433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

Few users have observed display corruption when they boot
the machine to KDE Plasma or playing games. We have root
caused the problem that whenever alloc_range() couldn't
find the required memory blocks the function was returning
SUCCESS in some of the corner cases.

The right approach would be if the total allocated size
is less than the required size, the function should
return -ENOSPC.

Cc:  <stable@vger.kernel.org> # 6.7+
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3097
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240207174456.341121-1-Arunpravin.PaneerSelvam@amd.com/
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/drm_buddy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index f57e6d74fb0e..c1a99bf4dffd 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -539,6 +539,12 @@ static int __alloc_range(struct drm_buddy *mm,
 	} while (1);
 
 	list_splice_tail(&allocated, blocks);
+
+	if (total_allocated < size) {
+		err = -ENOSPC;
+		goto err_free;
+	}
+
 	return 0;
 
 err_undo:
-- 
2.25.1


