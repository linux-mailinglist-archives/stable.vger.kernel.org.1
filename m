Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA37794E3
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjHKQkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjHKQkc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:40:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E1E65
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnE/28DKMsJpcFfYCGmEsCGaKn3F2OiXSm1Nic4vcn3u1aQT+mtPbgLyRtI/wsk985eiKGm+BJKZDDgH7YYYuWW1nUy8jGYrVJFzUVlLUXHqKOZS0Mvrp1CEOBitWCWxequRLb1zvTGwHIOUA3APgW0LG5x18mTLO5Hh7AQzTO55u46fRYFVoy8j5f1MZTWY7Oz4je5P1/Vo1cupp/FG4SF0NAaZhZAL3TNPcHuv0HL+07yP5VX3Y+Tf1zFi8GtYowVTa/MYeszFYs8yTryjAherpRRX2clwpNsbvhmHmqe8GxO11zSTOz+czIRzsBWK1OQv0i5wxV2zzSNc1gDcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hUPTHOb482UEsSrCHDHpbX291EpYs3Vx7toipaA9xg=;
 b=KGBo6NbwHuTLAXMF8ebCek4AsQUBiceRNAolFhiUdCNxuRnpoIyQJaOhAqNnvRbqsSxMcMGdaLgIt2XuR39Uq23G6Dh16qIvJvwgIBgVYoaAytYjMQ0SLgfjYIbUjhaBXKeFQj/Rx5Tkp4UlB4pzf4F+zsC3xInn1DrbKvQfAz7hHNcVfCQJZFM9F36961I4/G6amYq3Ar0Y0M9Rpr2we9M6YBICWqQDvFMUQG3zpBrV+vb6vQYbkft+IiknkPvfy5riy1+irXRK5j3tB+S0H/IKlrBXwH7lXUwS1QZDJWtTs+NNa3NJyS1b0m/7Y+bQs6CEhiSHdBlRiqC5YiAohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hUPTHOb482UEsSrCHDHpbX291EpYs3Vx7toipaA9xg=;
 b=Ki067YOQgxaZWx9XdrMDdCmpXNAQIEv7UOJY21oZ2lbpLyBeBAJdvAEZssZBz3LU296zBZQ1Qdk4RTupC5NqHAxg0cPZaIvt66UmHRLlnpXHV+jPcLwibqTOJWQS+WrZobi9DFqo1ZQsDSVWZMlXHt6WM7gwMTOriERo3I75J2o=
Received: from SN7PR04CA0075.namprd04.prod.outlook.com (2603:10b6:806:121::20)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:40:27 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::c0) by SN7PR04CA0075.outlook.office365.com
 (2603:10b6:806:121::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 16:40:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
Subject: [PATCH 6.4.y 0/2] Solve abrupt shutdowns from momentarily fluctuations
Date:   Fri, 11 Aug 2023 11:39:49 -0500
Message-ID: <20230811163951.24631-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c61ca0-9c2e-47c8-905b-08db9a89aac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTp9ywFgCauIcWLyD4XFjOx1XS13Pf2FaXTNqm89/sNuLE/ih5ajBJgp/6I0Pas3+LB9GyFh/nLp69r95hDr4iEirbqCe2aPvvy7dTyZ4Bfq63yHksSdlppW1LcQT1pw/PKOq1l+O7N8UKrU6u83D/sws5H+Z8Xdf2z7wWT0/e9pOanpod55N1PLBhLfo5bjV0PLMqLxekAaJlto7LRQX8cwfRBwz6Zt7Ff/zdj86eF8pkUtVpFhnQLmZ84k1ZZEW2IUW9oQCOxiNcxUQLR54DGUOFd+NyqiUCd6dXSRAqBJya4dIqraSwujxCMefWYzG1pOrWij7/4R17pRgsBVKrVHHDpbCvuYerhfiWX4/cNQCoUsbLYYfnS7zZSfqYVogQqpjseHJ517psDR6cu6Xf2/FLZoeCbf8cEhwEkTPju7qUKeiw+YHo2imUVb4LZVqQ5Tr47YAC0nq1ChEo0ti0/sk+oA9sToVWOfBapjznqFUGZvf+T3kU7/XmvOUZE255ITRDThemP+5wzjZgjyHEI5st/9pA/zrBD3W2C2RZ5vkxkt9ZMkyh0qeFQVRXbkNaiStICEMRDcW274ZgbN9xeGWc7fMF203g2vVzF9Rr1JJq9DD2EMgMqEm3F0q92RqHUVzZQ0JNRH9laoEs0jGUHS3HwfG0cHTEn2Vv580CfckwzSWEaQnJdlnrDVSV1Sk9b5tGxV4XzYjNZYhnsqo1RCeWjysALO51iJ3Pyy0m8TAs1wyzyJBVjwGY9pBGnjdwExP6RfKzt1sUhdcCCx0GvPQyVI3R4CPc9Bn86WZ0U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(1800799006)(451199021)(186006)(40470700004)(46966006)(36840700001)(5660300002)(8676002)(8936002)(41300700001)(44832011)(316002)(70586007)(6916009)(70206006)(966005)(36860700001)(86362001)(478600001)(2906002)(6666004)(81166007)(7696005)(356005)(82740400003)(1076003)(16526019)(36756003)(47076005)(336012)(26005)(83380400001)(426003)(40460700003)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:26.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c61ca0-9c2e-47c8-905b-08db9a89aac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Users have been reporting that momentary fluctuations can trigger a
shutdown.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2779

This behavior has been fixed in kernel 6.5, and this series brings the
solution to the stable kernel.

Evan Quan (2):
  drm/amd/pm: expose swctf threshold setting for legacy powerplay
  drm/amd/pm: avoid unintentional shutdown due to temperature momentary
    fluctuation

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48 +++++++++++++++++++
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  4 +-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  2 +
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 10 ++++
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  4 ++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  4 ++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
 .../drm/amd/pm/powerplay/inc/power_state.h    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
 15 files changed, 128 insertions(+), 33 deletions(-)

-- 
2.34.1

