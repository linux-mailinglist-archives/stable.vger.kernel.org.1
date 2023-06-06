Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070C72463B
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjFFOej (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbjFFOef (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 10:34:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB310C3
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 07:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5yV31MlbeVpzPDmuOmYdN5/aowHzz5X3Ak22RDxeWLSxuxnjkCBQzjrVvcqzH94xV/TkSsZr5vtX0iukMQscLXTJNsQyQvu74EGvjB1q94s22Y/TbaK65nxZq/ur7XoTmE5jRsLCCpm4lN3jSXs7g1gACWLJDbTi5/8vRzQ0xPnthXz+M8bqNyn/+6mhROJ8EUHKtApBzotnqFQLD6VOyDBG+4l6EydE53goy48+r3nT15SSpqytqaQhtVn8PMExg8Ap+oZXzqw4wt5WUFbTWmDn4DkPkDlTGY4Hjp9ZuAi44tKRQm4iWA96OeCjAN4zfIykCeyv7Hi06Z/PTbA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdY8snO39ljpN314w97AVxjBLZZLH0UjQcgbU8n7LA0=;
 b=HUHcarKjg8wgaqd3E2mGFCnUmenGVEIRyLV1DapU9c7OCo17Lld+m4TmCzBstIvS8j6yruxy/dAFddn5qVnKAg7n8n3VTtYN7ffE8a9DkK8QyfsWvaJcAK9AFzTDiV248Y1Dchqh8GKZzl6XspYjMh909hzErvgwYZQpDfeTCN1giPIk55eQwsZpCNy1dInfHhUyh0h4JAFo1V0NUFaNpbLC/jahCU5NchpcSmWQ16Tt5veRT/2vSWoSKlhvGhywjaiCIpP2Z8YXlU/S8l16YDTfRq8JmOB4Gg5He0KvSsuNDexSW35plu7biGhD0TotNjRgcad3lG/DXJCKkWu6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdY8snO39ljpN314w97AVxjBLZZLH0UjQcgbU8n7LA0=;
 b=17NGBT93Y9gMmgzw/ARqvq4dk2iJCWZuukQcYUAql1r5FwPXw6TC3ERXZgsWyPrtgdilU6WZQ5OC8tcAkfh7Vu7wSfk/i3XXjl5oLNlupE7RKQkZAhppuZfSWusS1kp/L1nYP8rIhTTj4ytlwkqvaaFYBCSJsLS37DmKL+ukBHM=
Received: from CY5PR19CA0126.namprd19.prod.outlook.com (2603:10b6:930:64::15)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 14:33:53 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::90) by CY5PR19CA0126.outlook.office365.com
 (2603:10b6:930:64::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 14:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 14:33:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 09:33:51 -0500
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     <stable@vger.kernel.org>
CC:     Vasant Hegde <vasant.hegde@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        <Stable@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.3.y] iommu/amd/pgtbl_v2: Fix domain max address
Date:   Tue, 6 Jun 2023 14:33:38 +0000
Message-ID: <20230606143338.5730-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023060548-rake-strongman-fdbe@gregkh>
References: <2023060548-rake-strongman-fdbe@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c9aa7e-20e2-4b06-c000-08db669b0d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85ADp9b9fCXi/o1+O7CWQUKqazRonpU93UfPc9ERYHjJ90t1Y1syUr6tAgjXKeYWuGr1DnAOVmw0E3wfHC9AuEeQmjxhf91D9UYVQq8sDZr4lXa6TLJGZlTvRCyGWpMhmRk4m6sm+GO5e/KsYqZnhAfQYZFs4Gcr3ECbdB4tIW89/+dYoPh0HQEoZaIgdumToo+96qozzONLJ3UQCkXe1cXDCa/+5v+k+hDQP+dQ7m6zQKd4meCKZYohKATqzLPDV3pE598R2KK7UGaRNG1PxFA/SJhMaWCidIJ7E/5mtayWQ1070PH9FZYx76TatcZflbIWqfrOgYlKke+dLX81wi5Y5IjgkjLub/IE4WeqSHlS8nBTkDQAkynqmPF7Uas+XbhRJKt0sT8ECN0pV+xLCId6nhRnjZrlxFge6dQTLSYMIch0uM+ntCnFjbMhgrqSK/hy9kqyqjreVX+qyRA2CQSZvM2bFCh5ItGfqA+OAopZwwx9mJB1C2FabOtz1q2HwpZD/1PEHl+0KJSQU2Dgvsw7O91VYiZ6J4HRHDtcGVqhwLRsnRkxI57bFyGBWFpFTImq28zgvKI4hbV5TNhrkjg1iKas+YP5m721FgfyqMtXUPWu6C19iD8ZNsdqXg11ft2JjP7dlOIS8IXVu23w9gsQkGezyHEwgcYR1sZuTS5COmlt7DLnadplvQFccFsfgB08TiZTDhXj8oZNGMH7tm9EhjDeWcfFhoB9waEjJagaT0HDj/m9f1oyJrGLapMm/oCAQ6oVBOHPyJhByVpVMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(47076005)(426003)(336012)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(966005)(8676002)(8936002)(7696005)(478600001)(54906003)(6916009)(70586007)(70206006)(4326008)(26005)(1076003)(16526019)(186003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:33:53.4363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9aa7e-20e2-4b06-c000-08db669b0d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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
index 167da5b1a5e3..7fe62558d24f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2107,6 +2107,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
@@ -2123,7 +2132,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	return &domain->domain;
-- 
2.31.1

