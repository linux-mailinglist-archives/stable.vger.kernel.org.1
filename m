Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6D7E5E24
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKHTFa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjKHTFN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:05:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0910211F
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:05:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUSApi3CMs865kd8Cnyw08hAYt5kvT4co9M9klyHYYFIE33CkcOdKR+F9J0jeycDZIW1+sCHzIm1BzYs+ahpgXO72EJbnugysmFwoBDH/frVYWG4ujrkDs0q/6Qi2R2crTdQyy5iFZDxLK67c2lvBu2MCzo8nYYe2Arh5JDM0Le+48sLK65ZkJ/b63H+BhRtaRzZtHtppNG9O5r7K8zNEh+EWQrF4R3RnhyEFhPUQPbizSYNekEHCaFNazGSzWW6sWpRIEjzdCxtsYB+m5ub2JeGoYoIkDjRDgknCImYOJz4EVDi06wzWJaWLLmQKFyrgffStt/FR3zIMetND7v9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8FDRptqoo7W0qffIjZhdS6oIUALKOTcHtqzKelX6X4=;
 b=X5c/vr1QBQCEy6LLyH9XsDs+Sj/H+8i0Wt3ph+Sdy6GGpFnjIGpnEVOrn6nnFW2BQYwH8KfyWDxStrqqQJN8pcjCLhIKeSLbo0cPas6f1WBX156PNE24R3oREqdugU7/u44K656k7wmAjoUrAy96YhyTJdqeYhyyLWiyPB+XP2FehwePv1GZXY6/LQUtX4XzGYmq6I+QRRpU1lAkZbSsfe2WakiJUdGoVrBft57EiqDgmqYFDTWU7rZF6kb2GOESloTB6FFzLN3cNbKN78T5TwHGmTaAlsqv2rfOoyZAC6vGYnX0ND5rVSnJcyM4AWMc4JVkqJ9yGHIIjG8KLJKORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8FDRptqoo7W0qffIjZhdS6oIUALKOTcHtqzKelX6X4=;
 b=f7UIsPn3T3Kgf1IyUdCqmL54SA3euycER8ZZHE25arp24TdC8K7z0uKpvz1QzougBw+jTHUUrC2gWPJf50bP4Ct8vPnp/0NX+0/bMaqXU9wqqLmlqXWR7W8vxoHvi9/5Q3YwpefgHtO/oTwXXKZ6tM0q/57dAVqTqIueX6hS1n8=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 8 Nov
 2023 19:05:09 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::fb) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:05:08 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:05:00 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Tianci Yin" <tianci.yin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/20] drm/amd/display: Enable fast plane updates on DCN3.2 and above
Date:   Wed, 8 Nov 2023 11:44:22 -0700
Message-ID: <20231108185501.45359-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8f71e6-1030-4583-ef6f-08dbe08da037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UguNE9JhgzNQFJ0tpqdOm83rIGHXwLxyw+FL/osc3pnKOWMYKWlxWHSK60XG3iTEstzP3ZZ9QVPQQ2xikJoF8EUJf/mjIyA414k160z7fXfAZmGi8e054vXdRW7jC4j8WQVGo8jXdR7lhlGWPY/AANd0/68SbYlsRKW5jwGrihtaVkRWOYAOChwRb3098Lo4c5YRwvghK5l5QSI+VrPuja5pfjRdVJuUxm+FQVown1r2E6KNpJfzfDSYEM0wlI5SBPaMqUIvZjjN4YF6RRWwqMOwShgqxePLjCcOK9n7Sc/wipoX5buLtQxBYBUqatQsL0ZFydtKZH1fhx675IY9Gdfd79AWvK9WEosJczGfqs5fe0y3BLjuXNvWhdTIoC13uwb+QWpXu9Rhov6Hy0Sic54y0VmaMhB3yyHMF4xli22W1zZXhaUtNEFB8/XYcPDhlab5nQqk/hIMMP4xk7a3FBZeJ6qgD7FKKq2eX9pyhy3RHnI5c6f/fCeMDNmD/CwaxsL6jk8xvwV0vUK8+eKhZdzTj3MZMUyEa8leJr7sm1uTW1Ypo7yZcGMc8yFpYd6L+8TS7sA4uogSx4p89rE38tKmqgW3VXD86GFq06QDytl8iY3OjT3IcQJGhmYv+ZZBh9AB/hPc3y4IAOdUBK+3fP6+GQuJ7COTX3HVv4vYWb9RXy2eTkU4QWRK/D+4HUNoMHNSdUbI9bHRRCf0x8TAAmMv4flxmGjA4cWhS5tw0NV8LyTL39Leumcuf5OP25X+X4JLnTgEjxbfn+0wFTtqzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(81166007)(6666004)(426003)(86362001)(2616005)(336012)(36860700001)(15650500001)(356005)(83380400001)(41300700001)(47076005)(82740400003)(36756003)(7696005)(26005)(478600001)(1076003)(16526019)(70206006)(54906003)(6916009)(44832011)(316002)(70586007)(8676002)(4326008)(8936002)(40480700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:05:08.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8f71e6-1030-4583-ef6f-08dbe08da037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tianci Yin <tianci.yin@amd.com>

[WHY]
When cursor moves across screen boarder, lag cursor observed,
since subvp settings need to sync up with vblank that causes
cursor updates being delayed.

[HOW]
Enable fast plane updates on DCN3.2 to fix it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tianci Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..8ebdbfbbb691 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9585,14 +9585,14 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	struct drm_plane *other;
 	struct drm_plane_state *old_other_state, *new_other_state;
 	struct drm_crtc_state *new_crtc_state;
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	int i;
 
 	/*
-	 * TODO: Remove this hack once the checks below are sufficient
-	 * enough to determine when we need to reset all the planes on
-	 * the stream.
+	 * TODO: Remove this hack for all asics once it proves that the
+	 * fast updates works fine on DCN3.2+.
 	 */
-	if (state->allow_modeset)
+	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
 		return true;
 
 	/* Exit early if we know that we're adding or removing the plane. */
-- 
2.42.0

