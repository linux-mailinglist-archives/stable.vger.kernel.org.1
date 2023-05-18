Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D97079C0
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjERFob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERFo3 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 18 May 2023 01:44:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5432738
        for <Stable@vger.kernel.org>; Wed, 17 May 2023 22:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So7WPD/lRN8oj7BJxOaNKdZ4mZOVZW9ivmKT9hu2fQ7cNG45lLv/+Qn1Lz18qiuUkYl1x7Li/YiN5p1v4yUGgTY0SKN6Y+QWyORtG3yHcGEULmNyLOx9Sx8yQKI8ee6fSkeuik3QhLBd7Go6TMVDnFoqa33oCfXdpN85xH9JFJ15Ed5l78/721FHlTDhhdWnAeaeuMq7/zxYBusTACv/jOI3xELzPSflY34/pkTt+yI1pU+MSwv30iug0l92LTLvOxJ7W1Y27DewPulsjmo+7CVBjqHT48RyLcObp7tQqyA0GcipOjnQL2PiUQh7u62I0MKDp8hh66DCuwJBAGCyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5EJt2+oWJS7Sx0ocMWdV7uTBLtWo7AhPHsSqoGDgX8=;
 b=Oml59ysCPy6vkkhTK3Tjz1yc5CTOZ3NmyxZAZCA51Q0ku93HIPk00DhUPkTimzc9wKznv1lSMRyH5yuFd0BpjQT5sT8gclLWadj2zKC65fq8E/uzi+jxApV/P6g8xsPhXd9ZKElgryU6yGESE0NM/Mp8VfBbd6pVbFjQb7b7HpZmvakkGqF9v626IAbNhaAH2TjC5Ldw8JM3bHjhl08xFRDLDdMEgY2KIbSqQawr/ggB/F3RSjzbwBTrX11TZkfgrnRUngW+L7DN1nCfAtBp9I2RwULJtCLkrKF0SvlomCna3CxvqWEwqBLcjDig976FMm3lThPee21yNyH4mQKVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5EJt2+oWJS7Sx0ocMWdV7uTBLtWo7AhPHsSqoGDgX8=;
 b=d3WV2NOGbphwOWJH++YscSEdLEYHEj9b76JILjvYWwH5oblKC1KKb5edVzEogN4r+XNNzmuARFSM0lZWEsuauopSoeo28vBB5+iCy7shGM9virkyRgyF1znvIzo1htWD7LmGWwoqd7mpjEe+1sYMK80uC8em0V0Zy8lc8SwHW24=
Received: from BN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:e6::11)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Thu, 18 May
 2023 05:44:21 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::22) by BN0PR03CA0006.outlook.office365.com
 (2603:10b6:408:e6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 05:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 05:44:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 00:44:17 -0500
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <iommu@lists.linux.dev>, <joro@8bytes.org>
CC:     <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        <Stable@vger.kernel.org>
Subject: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Date:   Thu, 18 May 2023 05:43:51 +0000
Message-ID: <20230518054351.9626-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b291859-8ca3-4573-618e-08db5762edf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HzrwJ0JKYYtr1I/rvfMEF4kajxh0EvcaOU2/vPEmAg7ufMtDHBo098cwijtDoeaZmUy/zaoUeHU6nc24pD5Bf9Iyd7eOeUppuC8zRydCit+jJMhtszQAj13NPt/Y9/SXdz5ubUpvF2yXTuMdF+kTDTlj16NZcFPVSXizC3Rt86DyzdtMl/xeTk7e4NMYXgSlzk2MphuDqsQOtMft+PaqnmOhBwKb2hcvQoloVZGhDP0SJoVZ3S0kIkgX5lAXLX6x/lsTM7mqcwf4euYDZxdWKk+64XfjLinSAvvNrw02DVtGr9rekbbaVpj+bAdMm8wgEiXMv7h2j2rZ2jY1GpXV/QlW9J3mJce62oRrdtWNda4Wfay/rs1j7IJSYLFpJEzIx6UEUFhcOM/sYajW19ElZd+pYQA7Ch4Td3w8lrRn7NIiWvJdaTymhrB3hiWW2SbhST2jdCcM47fWCwp7DOcMMyMCL8r42q0kcHSU9RP9ef0vkIvMWe08Gn8Glvb3tgiKQptc4N/gpV8Foa/36ecOZIwDXbsg5Ed9FGomAfHZ8xgSdhoHNnYIqf4JVP1BWegWMLl36zbw4ZAd30h2UWbekK+z94MnFpdehAmO9sFdfcyAKfF1uZA4FPBmsayTmkVBxFtfHPZJ2vQikJtGoJWM3cRN6zBTKbjYYBpz3E9agbe6LrzuVCUUBNLtkxuOPMDrRw220lzSr7AuHxXexXNtfbrqBOBvwxb7CaWG9I2V1kVRgCvP4eYsNliDGrC0vTPhWlF/DjQmbY6E7LwSJVijg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(83380400001)(47076005)(336012)(426003)(36860700001)(316002)(82740400003)(41300700001)(2906002)(4326008)(81166007)(356005)(478600001)(40480700001)(54906003)(5660300002)(7696005)(70206006)(26005)(70586007)(2616005)(40460700003)(8676002)(86362001)(8936002)(16526019)(44832011)(36756003)(110136005)(1076003)(186003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 05:44:21.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b291859-8ca3-4573-618e-08db5762edf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
address space. Current code assumes it can support 64bit IOVA address
space. If IOVA allocator allocates virtual address > 47/56 bit (depending
on page table level) then it will do wrong mapping and cause invalid
translation.

Hence adjust aperture size to use max address supported by the page table.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
Cc: <Stable@vger.kernel.org>  # v6.0+
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5aaa4cf84506..e14c7c666745 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2128,6 +2128,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
+static inline u64 dma_max_address(void)
+{
+	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+		return ~0ULL;
+
+	/* V2 with 4/5 level page table */
+	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
+}
+
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
@@ -2144,7 +2153,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	return &domain->domain;
-- 
2.31.1

