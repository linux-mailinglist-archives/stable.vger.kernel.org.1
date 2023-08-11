Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBF7794E9
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjHKQlB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjHKQlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:41:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076D18F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtpnO8SCHC8zzKMh5AeysnwKU48uUTwCyxOCdD7iqeDcfjL1fyWOJQWUpgZg9ijhNNt3k0GBNwk+dgJoFcSUNfZrpyqYl6lnzQWkk0FQacDuQp8lCQU2noh6GwIdwo10e5RqzVbcC3oJJgzkIt7Rn9g4JFE4cuOwr70MLVU6y4TokV2F/7lz3Y04tnhbO5YaXJCclfolytsD2otHLv/VGCU54vLO7B0WzHz/wkzaj70tBwAqaBZ48CwSSvu0xGniUZUFj+HaTIchm5fvERY/IJ1uJFGcmEHbndOJZfhRAJIVpHLGCR+ritSJZzgSkBy9KwwIpTXuHneA/pzEP1X0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX4J4lbCxzTzhhR+TeqpV39Qh41ml0ww8EoSt2RiGnk=;
 b=LCffAeghCygF33hZx6xbuAZlO6kt7BuNA7HeMdvTZwf4fIca5pBCenosk86f3NhSgO10Tq7Mdy8HqrhWUQ5La17C8pfGESu8PGjSLjs9huAPkyKLQIXBNYn5vchYzd8ef+cTMqh4HOfndrR4IDPk+KgOOWpaIEQ8DWWk6ER9hn7806cCYbONwHjvOZzZM2sfsYPtaCggId7i33AEOmvTIdOljdnoax0bSUxCdc/2VER57cn6GUICLizDcbpNsgHB03x/WmZSEFynUdh4410Hweiy3p+ZgBadrUZLKbsGI5LQ6QXihdHgymnrYcltco5UuIIuW7058IXZCIOloonKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX4J4lbCxzTzhhR+TeqpV39Qh41ml0ww8EoSt2RiGnk=;
 b=erKSRBUWk0NfFFa0l8HP3gcX3n7xkqM0p1JoADj5iGRFCJFJ4ZshQXnjnUMVge1xHoOe17K4QIdh/8Ai1KmARxeNBN4O4OVk6Zk7S7/027uimULkDdEwGefvB9l1PvDvy0cv75lQM1YJ+7n3OvhWuYvLwlABb2ZPIrvPakfLsi8=
Received: from BN8PR16CA0022.namprd16.prod.outlook.com (2603:10b6:408:4c::35)
 by DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 16:40:56 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::d2) by BN8PR16CA0022.outlook.office365.com
 (2603:10b6:408:4c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:40:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
Subject: [PATCH 6.1.y 0/4] Solve abrupt shutdowns from momentarily fluctuations
Date:   Fri, 11 Aug 2023 11:40:27 -0500
Message-ID: <20230811164031.24687-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM6PR12MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a4ebd8-7ad9-4b78-ca7c-08db9a89bab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILGAxsaylX32jzt1EVQ45ETKx5g8bvI/YwfzQhB2qnp0Uh5jYX5vTL29QM8C49h9rUujjxu/P4pC2zCQjCLoBYIX+W0bulQoQsIvYUhoaaGN6rb0haoHrrNNiqLCq5zNdM1nZh3gBh71Wc3Ze410sgdJ0UVKahzbDbxUjEWTbq9hYt+ytR6/q5vfB6FI+F7WmdiqILQQGF4aBD57BMlRNl228tEMoaDtvrMbBOxXhcgAUJdFpr3DpRUC20CbdBoah3n2uqhY70uXEhw1Ma1h+p6gcHATqxqMip1dFphO5KRUYmPp+jKqyU/DvFnK/22KEKH9fsg0XdUspj93u1x+HDOG0bs9yRwz1kD8d/Uy4J0MBZdpiybMrHKweTxcXqeXVes12T9fhgGsjZWvl/CoKoSOI3TmyOHK099SCHtzQqi4upsh04cNRwlQbPbXFqEYPgkYN1unqDXzAiTBx6Rq97/EIAIJLZMrbO/Ml6/v72LjimYaUoijOCSgd7IWEBXqD7fJ4UTRwcikbDVlMPxIr28g/uL17nsAYqSTnBSNHH1cCxOKj98S8IzonF9Tj3eyMMeMrMlXXsQy2wpQ1p1FCjPfN/1Mku/ymkbUJt0FlgaU6RMa6A3FJozV6DnAUwTNp+vBYQrDbI7exSIymK9+u630et4rwkFwGXJrrL2nSJDTkODWs2zXwWAgd93w+JZvKm2bBII45qNPXGVmsUS5e3xpp37CxBD0HV9XbzXVraxlGD9I5RJxE7J+VLO+fgznVKYk3WQBJf+El9skWRq6TAkdnESJMEOr3OxOpCdkbmQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(1800799006)(186006)(40470700004)(46966006)(36840700001)(2906002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(316002)(82740400003)(6916009)(70586007)(70206006)(40460700003)(478600001)(7696005)(6666004)(36756003)(966005)(83380400001)(47076005)(26005)(2616005)(16526019)(426003)(1076003)(336012)(36860700001)(81166007)(356005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:53.6039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4ebd8-7ad9-4b78-ca7c-08db9a89bab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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

This behavior has been fixed in kernel 6.5, and this series brings
the solution to the LTS kernel.

Evan Quan (4):
  drm/amd/pm: fulfill swsmu peak profiling mode shader/memory clock
    settings
  drm/amd/pm: expose swctf threshold setting for legacy powerplay
  drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock
    settings
  drm/amd/pm: avoid unintentional shutdown due to temperature momentary
    fluctuation

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 58 +++++++++++++-
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  4 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 78 +++++++++++++++----
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 +++----
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 41 ++++++++--
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 26 +++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 24 +++---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  4 +
 .../drm/amd/pm/powerplay/inc/power_state.h    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 42 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +--
 18 files changed, 293 insertions(+), 71 deletions(-)

-- 
2.34.1

