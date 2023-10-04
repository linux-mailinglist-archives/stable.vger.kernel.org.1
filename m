Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AF7B7C04
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjJDJZA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbjJDJY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:24:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B203BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 02:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxi3G+loWz/09YaxseI7hvNeU9WJTNuQVstbqVDbWKpO3JtmdXYldfeV4Boers2DnXx7Iwk5ekaZSr9aOgHbZ7LJqt2CImGr+Me1hsCZYLAScGnlz9VoS6lXzPeoFmLz0brkrs6N2B9dJEnpgzJPWO0gxsSnNep9sxpDGOK39A59xoDLZCKsbYMNyOp1YlHLTRTVKEr3b//d2ENdjFeT9Ngamz2/03OIP4i160gO8RqdCbHVVdKYhr0LnIcYjeebtOOrVugctNLHINvc7+NIsByWdxFdqM2CPuyU8f2WmdaMLgPy2xtm1SIv9SZgu+q2SkXIlyh99wpRbXcGHONpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrVUZFnxL1xfZV42m50yAMnHRHRFiLlS2QriQFSHXOw=;
 b=fs6PnbmQ8ehXZ47A+deQ5GyT7hxsOiURTHaHNYkXFEMDlcr8CygPn8sarWRtj9lkh/bZH5uMH3/GNDdLYE+bTBx14a6LHGJKxRmka3wHzfmg6mTwgRk/Wwuk4hZuE7dXx1khHrBLdPfzZFgz7Os8LQobCodDuHFYtRT8x/zVKPXg8gBHHux1pPjr6ju9vz/U/wm/DWnG1NsfKXmOQHMI+6xy72FsRzg+SkejYhKzlnIQcQ9tyk7tPJ//SD1bRAjgciKYOk/yT/a3K27Yf2DXLbFX3LpOQP/OZ74NlRtGBQKeEeRZrQG1GxSlVu12+v5Z2duPKBeCiOj9qnfytrOX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrVUZFnxL1xfZV42m50yAMnHRHRFiLlS2QriQFSHXOw=;
 b=kp+QnmJqc3mZ2Rv1G3n0UeLFf02kn8cJnhaxbUlSC9KhRwoxp6zU7+Qiy8o0f85wyoHUm0PLaaMVJcJ1grM69/IN3C2KkncyXEipggXjuCpCrQR7OYR1OEVLthUpKHzOqbij4xmzpAq6yN8VhchTNrJI9s60lPnzJoSgYAgJbNE=
Received: from BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::28)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:24:52 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::ad) by BLAP220CA0023.outlook.office365.com
 (2603:10b6:208:32c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:24:39 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:33 -0500
From:   Tom Chung <chiahsuan.chung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 13/16] drm/amd/display: Don't set dpms_off for seamless boot
Date:   Wed, 4 Oct 2023 17:22:58 +0800
Message-ID: <20231004092301.2371458-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: feb25371-7e7e-45b8-6acd-08dbc4bbc3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSss5VlYdyQh/19LW2THagZ0lrnKk5J2lJoRDUn7LRzhXYg7TJg6WUS3KuQxc28eRj0uU+SeNj/59Ubxj+u6Ol4WstaiTSW2MsZCgFioTMF6tAHMrGzM8zq2KJ1tCQrBHTga4lDqd1U4yMsinzhUciqLFKV0OSCQHz02+uS5PkhNYajHFRpIOihgc9Fn3xjV8hvLI7Q58n2OM1yJE6M/9VJTOqO93eFv72nHV2JpMHZHqKZ5MLHyvu0AQscLE1XRlw9+AXHkFnT4HiPR6b2Co0m+VckhN/zwFQK07nWCDk80ak1712KNmNIaSGccDOxrjzvdWfdiCX3amjvCDwY6k3DJInVz/HALIyu3NZ3d69S99AyyyZfAh7TEABjem3zh+UQanvB5rvsuC/eObkse2kekDP0b+9tadZvWvQYMQyCiJvXxKTTg9FCxgAEPBVTtRU33rINMBOUr8CTCp7z20HYuz1kFJ4DdMSGgvFMoARIg7BWPhdIgbcIt/m9CQqBWAPglapWkrKbssrU5pxES0wHwIhVEhTqJ/kt1uvraZnUdV1dzlbE8ZctYLxeyBgn97Td4mJ6xx+2/YIdH5xZrKvwl9NbLO6a7CHlFNqXEEwCBjjtULe+o4UXWAE3tMW2kD6rPE32OFfthUPyXHxsxvxKNkilHQFfEl46x6NzXBlgAeWgu4rjtOAo+6hIWoZ4tgFaV7RI2lg5VR2FO3wf7diHZBcBrL5wPhiuJc9rFGSSRcKrIFhREWeb3zECMIRtcgsjAkgMhDpepU3pZcZ8OQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(426003)(1076003)(336012)(41300700001)(26005)(2616005)(2906002)(6916009)(54906003)(70206006)(5660300002)(4326008)(8676002)(8936002)(70586007)(36756003)(316002)(36860700001)(47076005)(86362001)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:52.7961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb25371-7e7e-45b8-6acd-08dbc4bbc3f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Miess <daniel.miess@amd.com>

[Why]
eDPs fail to light up with seamless boot enabled

[How]
When seamless boot is enabled don't configure dpms_off
in disable_vbios_mode_if_required.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bd4834f921c1..88d41bf6d53a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1230,6 +1230,9 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;
-- 
2.25.1

