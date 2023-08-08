Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794297744E9
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjHHSb2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHHSbL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:31:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E0CB4F0E
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxVhlgde4xzL0Ww+4+gBSlLTFkDsl4AS6R8RDKL2y98W3ZJwm0gqUv4tktQNP7uKVlryeLY6B1XZZg7UyCWyxvf5xsQe+QQ7JmKjFcgdJBUjRh8sCf9bZ6ztKMdXO75+UvVeyNTQwJiR8mR2X+WN7TJCys8vOeglLRgSjPJ4JoqVEp3DKySi6799aao++wQ/hVc5AHVZfd4iZiFttqURdxl6Ho6Pic+xXW83tSVxxL7EO8gnbhf5CG9FGbLUtwtaCbH3XWqlvYYvMUtn27bVKx/rS38nitlGuvuro2qcovkwFu3PWTCqQueFHyaWHTwtcRjtFDHVoBICmdevOscipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdrgut9DdXM/UXZcoJO4SUNJu5eJUC/6/NVpnnxmo3Q=;
 b=B625AomB1O2Uwa1evKBHa8FnYTnWTNDrF08DqKT8FdSWQU7BezMuaC+7JpKrYFBkHaWD98kjTcwPSbg3ZjVSTExBhJ8DKpXTZJCitqO4pqT53tL7Qy3tvC2PLzmoyTMKvxajOvgPwBVTSQz2Kdrw7fS3kpxsbMvuT4OllWTg5aUfFvnJs3/eHjAmyEBNXViL3qbXgFCUcLyoZulXwY7HZKWEGsn0n52wnDHPaNSsZTpjy+aMkU871r6kwTO92QYNSd0fGbU/JujWuf3ai76Eh9PNmVdDpW8Fo0vRjvUths0LvwZwj/zv1ojoaQKSR80VJwI9uGunv6VEHY8H4O0y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdrgut9DdXM/UXZcoJO4SUNJu5eJUC/6/NVpnnxmo3Q=;
 b=bnJ0MknnOLXIgvV/q7wm+n6DSAQAgduuaSfg6npQtTSMt/s1ZA3g1qHN3V798TXYAgwfRLFftQIowk10UvsBMls5//Iv2uAjDrKCN0F/hRqdrxZhKjNGtFX7Nk0fK92UpT8sVLp+PVeEqcMq2Ra2944Dt46DESlyZ27ekgcLWcU=
Received: from CYXPR03CA0061.namprd03.prod.outlook.com (2603:10b6:930:d1::26)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:51:09 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::cb) by CYXPR03CA0061.outlook.office365.com
 (2603:10b6:930:d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 17:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 17:51:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 12:51:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
Subject: [PATCH 6.1.y 0/3] Fix accessing IP discovery from debugfs
Date:   Tue, 8 Aug 2023 12:50:52 -0500
Message-ID: <20230808175055.3761-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e896faf-e875-4e81-2bc9-08db98380c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHvFdfnp7iEI3Ruky9xFRS1W7sp6DJmp7MwodaMiFCkv1PKVdt/hUYJWl+6LQWVmDUfnjlJtx2JlKFrpE1yxL/ZUVP6WmXYjpZvgI0e8t7Cy1zsQzpB5OY33H6tdvr+MYNrz88WA5OLGdYIxnnZcZZza9yu9fwsdlsFS0nKQw+EIoubO4VcYGOWlZiLOKNjLAbnWgzu5vTnnFvuRXlD1wmHnMd1CExmSHtdOOcbAh/cHFfLzHVbYWKlp+ceheZ0vC6QWcb73ZMkPvKLQaC8htsXSc3sBpM7qDvD8pLg2FSlMi5RDA6Lr4SW0yFkamE+MNxAcY4WKIhZtOZRJg0xAgHIZrTuUwTz0t5VN6pqOutl40BAGOPMcWFq8L3F07twUE77BRXEbBvSA1Gw75vnONOOPA3jQbWdvqkOcUJgF7U7wZ9PTmK3SX5lo4Cb7h4J4DxuB+quYLMZbU17TSU/7XsItpoi8Us50LYsMuKJftgy3jdf6+jd5UENLGSjPLsDCbQ0hzCm7zTFTgCuxm6KiIy7XF7se5cfSbdftt4uG4BH/PD39wPeHUo3bwftrVvVED5QgKYPaowXKw6z8pOtiXs9b/IftLDfrW0pmrzVtAR/K2CRQ0yk6omOOx5UgmXxf0+jUEcLnhF/+qvfAFP885U1nNjb6krPdAqBIQW2yfqWYxbw/1QFprsc4O0kK32DX11Ee4teVujAC3e9bxfZf4TeNdT8n3RcGR7YHIiUclWqnsqdyMg5PhRniGTRfLKio
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(1800799003)(186006)(46966006)(36840700001)(40470700004)(44832011)(8936002)(8676002)(5660300002)(6916009)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(4744005)(40460700003)(36860700001)(2906002)(6666004)(966005)(2616005)(336012)(26005)(16526019)(7696005)(36756003)(1076003)(70206006)(70586007)(356005)(478600001)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:51:09.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e896faf-e875-4e81-2bc9-08db98380c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

As part of debugging https://gitlab.freedesktop.org/drm/amd/-/issues/2748
one issue that was noticed was that debugfs access for the IP discovery
blob wasn't working in 6.1.y.  It worked in 6.5-rc1 though.

This series fixes this issue for 6.1.y.

Lijo Lazar (1):
  drm/amdgpu: Use apt name for FW reserved region

Luben Tuikov (1):
  drm/amdgpu: Remove unnecessary domain argument

Tong Liu01 (1):
  drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2

 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 104 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  89 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   1 -
 drivers/gpu/drm/amd/include/atomfirmware.h    |  63 +++++++++--
 7 files changed, 217 insertions(+), 60 deletions(-)

-- 
2.34.1

