Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42653779930
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHKVIt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjHKVIs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96610DE
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI+hqHSGD/B3ex/ir9EtUv1865kfGETJlZGvkFx0meYvPpe7tuiqMFUxveuYM873e3jJE+vyilse9KVkc2x3MrESHvHT974Ezr0lsReBMPgXtCtufFCB0Au0l+M2IdjSVN/uOjobFC8nauCKtyhWd+cmb6z5W9wpV9ee8p4QRcCNr9wJZqWW5ISj4Y5Qi3qLCuJedYMBwUhqnDl1U/+PsZjD2/Tza546vfAC93lB9FcAhtET9rPPpFjLkyt+KPiJIEbqvv9FKi0CfTJTsZRaOwY9sus2c26tGtvUEWfKwTw9VJLgEJbPwbAOvgZrIky1Msn8LEYlPTCzD4fkX0KV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pJ5byhaC2kJTTzQWTWR0+Du1mof5TIu2TIU3Z4ID5s=;
 b=CesebLa19ZBHtWtK3QbMwUgQubtoyOI7h/GUD+cVnYpinXww6DKfft5iuCtTCbHrLsVrfxsrpphr16EMnD5UmF5Zkt7zzHY6RkNZ6Nh9syoMWzVph+0P/BxuZ5M0gBAPCGlDJ+OQBZvtpmrsKYVN9r8Y6ansNzAoKBMB4Z9Iv/a9+7fVLQN07x8Drk7RcbcO8vIWLsfWxhCAu57wbPH5ULXX4oX0syKN/9A6wQx8DKs5/CwBdsfHRDLNlea4I/GquRAi1ply/r+VypBRBCNukp+Zab4uNcDaUE2+CqhrL/NLjTxMWZ7h/rI97hwTpoSnhvEMcOLabYwA9DpgN0tAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pJ5byhaC2kJTTzQWTWR0+Du1mof5TIu2TIU3Z4ID5s=;
 b=PBXAmCz/aO8s23gUaFyPrD9dV4+RI4M+AeNKRzm1TgkPeD1bittGIMlTogYUzfttmrBRU9D6be/LwQat3lcUjzyNAPsHFAwsIYXMV3IS39zNDRIUZjEY6OFQvK0LG3AaKz9lL9sUhmqokEHRfmhjdN/Wy+uInZRxMM1boiRlBx0=
Received: from MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::33)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 21:08:44 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::37) by MW4P222CA0028.outlook.office365.com
 (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:40 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>
Subject: [PATCH 6.1.y 00/10] Fixups for some navi3x hangs
Date:   Fri, 11 Aug 2023 16:06:58 -0500
Message-ID: <20230811210708.14512-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BY5PR12MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: d621d5fc-2f52-429c-fab8-08db9aaf25eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycPz1vP1Rdf/YaG5s78fBMgrTD68nRkashhmOvceaqS6LPpyUneml6i0rnn8LmgLZJqPrtHLu9qURe8tvnuVu/i3d7jmhKM7jQTka4mqVsQth5BvGNsDU9VeC4TjkwZF8NWVKZApFk6jm053pvDb29BkZG8VFYaozdAD8/WAqUNM3rX5xNeV9VqiiC7ZQFpuXYgvYI/3N9AYt2WH4bQ6bvUSYtgs1TbNXuLpOIPFyl5UgE3rOeNj1Em8TU1zd/WEhAeGY0itFaa0NIu29Y9VNrIUCjM4jzNk3acM0R6dCFShYRqd1RpVg1GuXheLcxQDAt32dXN/XJ1f4s4lOy74xHcSmRWwjPr+dmWGao63y8t7zJ9JkmrjUHowiLUqJXSJjyRkf+xYTzOKD2Tf8JUKyTPm1YY/CzF2dg0/+ZuYga+YyUwOhhrY6gPQ3Pu4K2xsI2v+mn5cbAzUBwPR8ReIm8zQdXsYNAxANo8hpiNbTYfMAAls4Z8nbH6/EB3wOr7JWGI03HoHpQGAHsHQ+BCl1zFMQc3JWrwyjUAZz6eu3zssXxk40aTqW2TmZFASs7QZDn8EMG65FKW6Il1L+4WGH94cY0i88f2q8AM+9L6qjzd4CcLWAJmltxrnnLz7SEwjRd7LOhKB8TAG9oeShpY+2bM7PrXiGPf960GuGpfJXoB+wZ5e2ROk1Xh0P3PnorSqiwqXSnquo1kg2YgHweAqOLtWpCPwBSCzYw7kfzS2qS17Lq2fDpZIiI+qXL3TUzMd0weOcZvOZ6PHiFp991FVjCuwK4lSPCrcMyhO12si3L/mJSnB4nRsd79z1grMyY0cIcJm5FTbHfk5wX4MA+InyS6AAFH1zwnRzLOID4a5rYg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(186006)(1800799006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(966005)(36756003)(356005)(40460700003)(86362001)(40480700001)(82740400003)(81166007)(36860700001)(1076003)(26005)(83380400001)(16526019)(47076005)(336012)(2616005)(478600001)(6666004)(426003)(54906003)(2906002)(7696005)(41300700001)(8936002)(316002)(4326008)(6916009)(70206006)(8676002)(70586007)(44832011)(5660300002)(42413004)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:44.7671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d621d5fc-2f52-429c-fab8-08db9aaf25eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Rico tried to send out some fixups recently for some navi3x hangs, but
made some process mistakes with the series.  It's an important series
as it has a variety of people indicating problems, even as recently as
6.1.45 that it confirms to fix.

Some of Rico's selected patches were already merged, so they're dropped
from the series.

Link: https://lore.kernel.org/stable/20230807022055.2798020-1-tianci.yin@amd.com/
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2760

Thanks!

Alex Deucher (1):
  drm/amd/display: fix the build when DRM_AMD_DC_DCN is not set

Alvin Lee (2):
  drm/amd/display: Disable phantom OTG after enable for plane disable
  drm/amd/display: Retain phantom plane/stream if validation fails

Aurabindo Pillai (1):
  drm/amd/display: trigger timing sync only if TG is running

Rodrigo Siqueira (6):
  drm/amd/display: Handle virtual hardware detect
  drm/amd/display: Add function for validate and update new stream
  drm/amd/display: Handle seamless boot stream
  drm/amd/display: Update OTG instance in the commit stream
  drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
  drm/amd/display: Use update plane and stream routine for DCN32x

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  74 +++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 234 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   8 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  22 ++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   3 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 10 files changed, 341 insertions(+), 15 deletions(-)

-- 
2.34.1

