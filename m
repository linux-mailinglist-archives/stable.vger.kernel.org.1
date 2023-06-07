Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F45725E94
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjFGMR2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjFGMR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:17:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365581BD7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIG/KMQe35O2rZJNsnlAL+z1K7E/fh81y1ujmYFsuwpzyK9KmRHXekVBonLH/gQOA6meRU/j4EkSIKqTLaUzfTZTUYWA1vFrDaANPIkEdJWnuHfXLBu3lSdJF8kqhphdhkm8snyILoNG+VgE6uUj+Gifkby6V4JAYT80ruaUlP7eVoiWDM3f6LoiPrMB84L3aN0TUORL4gg6Bx7zvB9PflwhAg5+yZKFHTKf36JeSWddyxu0AYTP9DMcuH/jDuuoKJ8zLTXU4CbrfzCc99WCmzrWrvFAS/FrxW4orM/NMBk7nffOmj4qMBFoJ6dvO1fh10mhg0bzX37iAqHgryIiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NU4rk+StqgNdU+q87/iMPxuXHtWf/Qz25peQrbko/4=;
 b=i5cEqSLJDbc4AoAnQBoDZ7+p1gUzk/lVbSwunNZjGF2VDZF4/EfbFa4+6Sikc7FdNbs2+cM7yuL8RD72cTBJRGolfyYZMt4CQO4SCNn/yvljkkHT2HLjwq+5YIN4fZLBqIgyVgPRW2fM4MetPXFdXEtUH72zyddCM8RQm95kkGjY994LcdfqEMPwGJOYI1KHuSFOlobaHInz5GboUJcW2tYwgp148S3cEksdecemfQ+bdZpl/Mep2nA9LZ3poIQagGndy7ZLEqU/NZ7xYCbI2UoV3heZHzbDfppnMrax0WvOR35H/0dvDNAzLZ3ZWOgoKfBpKOYRuozydQIL1I8wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NU4rk+StqgNdU+q87/iMPxuXHtWf/Qz25peQrbko/4=;
 b=qtTzlxTYSciSCJfGbUYiPB4UGrkBNiRMRIAHzlUeSPh2e3NA9FZvd12e6yVKE8bux3N8rhV9KJFb3xEH+5pw+FEO+JNHKbfoKTLr4pXp9gLRMGmIX4TPRI96lyIjOlq0zEsQi+L7LPj8B0/R0Sim09vXZEKeArSK8yZL/Chh52I=
Received: from DS7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::8) by
 BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:20 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::84) by DS7P222CA0016.outlook.office365.com
 (2603:10b6:8:2e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:19 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:15 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Peichen Huang <peichen.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        "Mustapha Ghaddar" <Mustapha.Ghaddar@amd.com>
Subject: [PATCH 17/20] drm/amd/display: limit DPIA link rate to HBR3
Date:   Wed, 7 Jun 2023 20:15:45 +0800
Message-ID: <20230607121548.1479290-18-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: eba5a271-5825-492d-612c-08db67512422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOoNjx7L9isQT8n0C8IL6kf1kfJUVME6x23G61aUQGMX7Oo+qoI/h9Z+pHh/HFmBixQ1Fpg8BnUNb/E14TFVewZP8N4IpFrynzP8vbwxodk4k6Fg+ZAEi42e2gilBDz9uC9fT7h6q0h6Al/We3nMC7kBWY/juu9E3vaZL8TF6RP49PjXsCN+fDrd2zFAWjMBPEWJ3W1FqnRMwOfjaHb+VWjRjH+Ek9sjiT0uxPMW3ylg7z9UOqUCl6SV5PxCYZDi9CG2l9SuBuYD5XhSe5OoMlyS/IzTPEz2cYaUNkxWD3VDqmEY2SfyC13wxB08+I/kDtTG/qn9QhMyZbt1e3dYebHkSJcsynxjfaapSM635ngOKhXsr3FJB3W/2s5GF16I2C1thNpLlX5zyWU11STgvhR61dP5XZ3saVNxeCvnmKSD7KfkIY90gSLJ4qokVocvODgpLfJOH9UHFqtOxmGBhLR51QnfoNpZDmYMedggkcGklzuwOsAioEc960zXXvk3L+UymInKaZomjbSEybgk7uT6+gEN/1YItsM7OYnBgPVY8YBv+c8Yo21O+8WWzY5XLUo3X2Rdvth1edIkdCTFaaaczLKof5bLQThnD8mA+BTYx2fbdU+h+/QUENcqM7KjC+ZJNNCQ4HwOPkBgUROJZxfci868M+qU8lkZHsGhenOqJCDZ1PJvG+HeXDsQmFM64enbMiujSwQPeeVUYAQOEeLrtR/WaTRxCE+bniBNsKH7rSNiqweV5OX4CYE5uJTF8+eoNA7EtTWtuOwG58PIgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(26005)(36860700001)(36756003)(81166007)(426003)(83380400001)(47076005)(82310400005)(86362001)(336012)(82740400003)(356005)(186003)(16526019)(40480700001)(2616005)(8676002)(41300700001)(44832011)(54906003)(5660300002)(4326008)(6916009)(478600001)(70586007)(2906002)(316002)(8936002)(70206006)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:19.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba5a271-5825-492d-612c-08db67512422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peichen Huang <peichen.huang@amd.com>

[Why]
DPIA doesn't support UHBR, driver should not enable UHBR
for dp tunneling

[How]
limit DPIA link rate to HBR3

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 17904de4f155..8041b8369e45 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -984,6 +984,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 					(link->dpcd_caps.dongle_type !=
 							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				converter_disable_audio = true;
+
+			/* limited link rate to HBR3 for DPIA until we implement USB4 V2 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
+				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
 			break;
 		}
 
-- 
2.40.1

