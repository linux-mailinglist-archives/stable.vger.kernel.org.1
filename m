Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D24724817
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjFFPod (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFFPob (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 11:44:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734893
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 08:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HthAwPeL4GgbNRII/RYSLrR6ywBDy1dueNKMeJawZnY6IlUtdCljPeOFICYYqf/J2u1uUuZ1We5nx5gaB1L20ysA4/lbqYVF9FeV4LGSI/+LYg/zLXvIPqzL9XWm2DsDl7V0b2RecL/3J1rXXDY4dY2tNtr1CySNB090iyGgymtCERHfxGgMHtwoHmXDgCDX7Xr1SVhqTkYAyaXwtsc+OB31a1hGt+L7Tsc9IAbVaV5hoG6och/mWBvDua7Qg+j4CJiaE/7FUR+j0k4I/RYmWyIR1o4Lnt5RkPMAOUNak1229wrhx9pF7dQwWaU969zXfkC3DXFNn9u0qX4DbFWIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pouir5/CIgGNTL6SIKLt4x1QANYMYQCF4uA3QxZ0pRI=;
 b=EgviZbaRgo9Ah645v3rLoqtJdTPcWSxqu2piv2qZPkC0qdX6znc/d0FgBd1sP8ckpjFjJliIb2qaMn2j1oTcaWrQUGYHZpAg28BbJx05b4ZItgx/hUYw9PuVSw4hhrl/vpeCGsNqnewxv1QMmcJv7o0yx63N5dt2Zbo555z5x3L3N7CNGaGBC3FcOKfPnG1ymEd6bgmK03ETY0mMgU+MlcGVqs4g+TslnafazKD1BMOSNQYoFXDHrXlsBEpJdLWEq0DdhTIFNG291UwIoOq3OeBi2qFSphBKfIKn9hS7P1IFUchM1aVl2yCKHpmu3US0n1Ag5i1Clf8oq8cYQqbZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pouir5/CIgGNTL6SIKLt4x1QANYMYQCF4uA3QxZ0pRI=;
 b=zgewdzquV9NhiKPUq37hMcJrCjuJ50cveguNQqOXJLvFtiGVzohMvXJhPOP+BQ6yHVp1Uza6yab+oE8qhUv/pmnyIL5xNz5WRIBSTqBW22q9Nx6P/8G0KZQxiTibx7acgW4B9bD7nbeNbaO5EDMfNOGqB6JUjstCc+7Q9povx7w=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 15:44:27 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::95) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 15:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 15:44:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 10:44:25 -0500
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <stable@vger.kernel.org>
CC:     Vasant Hegde <vasant.hegde@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        <Stable@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.1.y] iommu/amd/pgtbl_v2: Fix domain max address
Date:   Tue, 6 Jun 2023 15:43:49 +0000
Message-ID: <20230606154349.5631-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023060554-green-unshipped-c28a@gregkh>
References: <2023060554-green-unshipped-c28a@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d31034-daa3-43db-98f4-08db66a4e93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OykhbbySEN1JgTXC5KPkPLAPTZKEAZFUg8YepJrBA6SZLVDImtB1K3vYyvtBVQrcsd00wHFVhOiOoHab7trxVthDjmJ7kMudJT1uVpdGlgHxXJ7XZRJFSo6Kj37MFs1msOMlEDrVOit7164ehYgeOi7W70CQFCp3Xev7slP7xBjq4ChxJ+qiY1+zwETILmkEzEjcVWBPnHshm2yc0eXeajqL2clrLMqU/NBKhOh0dpfqFlL02ezMJ1Ox7e+0DE3Bo0mBNMYfh4RpLP+U3Bfdm6DsfYW7BD8ugwSmYE4Cyv59h4s/QsizehssS82WqdX+Ybx6TSIj6Jmw/nbxz+whkgKgyFkS5uWanP0H7f2iCmSxScEjRfYWyTidY3o6PhoTEMufzZIZe/u+oACXcZlyBjKYd6vIFzxTpN8lPQbhQ8JhCfhuCIZShmNsCxO5claRC25lSIaWzaHaWpXrm8QagRRKGquMaqxuJYd4yirQQGRpshaVmuXAkzM0BTwVO8Jni5V6dmfxMog3wkrT40YdtZsTl2YQGSLwSnbrLslmfXA7wuv72J22vn2IsuPtWz4sT0xbtfHZ8runXJCQeiuX16INZ2G8j+Gg2ez742woj7RKOR86dflNA0epGITkhSKbpy6YR3b6zGpHs1VMbnal1kD/gHeOtRhtmZQ2pgOEhfLhxolnDsrgXZKMwNQPhPB2Plkhin89or4v71K5LZTnDZ3D6bpoDQ+O9v+pzb68obn/HKZb1RnKVaePUkznZthbeeDWipaTWrmaDYDHbe6ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(82740400003)(478600001)(40480700001)(8936002)(8676002)(44832011)(5660300002)(36756003)(86362001)(2906002)(6916009)(4326008)(82310400005)(70206006)(70586007)(316002)(81166007)(356005)(40460700003)(1076003)(41300700001)(2616005)(26005)(36860700001)(16526019)(47076005)(83380400001)(966005)(186003)(7696005)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:44:27.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d31034-daa3-43db-98f4-08db66a4e93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 11c439a19466e7feaccdbce148a75372fddaf4e9 ]

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
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20230518054351.9626-1-vasant.hegde@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
[ Modified to work with "V2 with 4 level page table" only - Vasant ]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26fb78003889..67e6450f9e84 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,6 +2094,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
+static inline u64 dma_max_address(void)
+{
+	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+		return ~0ULL;
+
+	/* V2 with 4 level page table */
+	return ((1ULL << PM_LEVEL_SHIFT(PAGE_MODE_4_LEVEL)) - 1);
+}
+
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
@@ -2110,7 +2119,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	return &domain->domain;
-- 
2.31.1

