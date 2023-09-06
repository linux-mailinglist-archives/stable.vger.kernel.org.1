Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F7793D08
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 14:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjIFMtr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjIFMtr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 08:49:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC8E64
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 05:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUDQgo6ihtHZ03RxydrpyT5uQ/m/E43M62M4SkarWo9Kcx9PHbFbI8XPVgvymKNRBsfSjgiRpVNEWxxkFgeBrvPjADd3j0Bsuap3rsx/JgOFUyJDCPmEII09MWZ/rlmu/MRtCx61v1Ed8Z3Zl3C5jzDh0FL3uyr6V9y0jVXwYsBZ3Rr4AS7kN3VALIq6fTRzl+ys+DDowbyo41tRhjmS3/tjFNhH04z9952PNY3WljSxiBrj3SSFgFUR/4sTDgPh9Wi39DA/NlAYzFwSfvSOdgKxiSeHAAlQMnUxRSmRIq98fZC/iX2BIqHozdHjPrESaDbKOb07Sz/htRTj1ZwV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts5Qgszp+2uCtkojC04kW7idZzIU7K1H0ztsHgURE1U=;
 b=k2C+Nh4QIHVwOXLPe+1xyAiKMUepmm0h1S5yoR2kXzmEzZy9BAqjgtw2v97X0g8A66N/hzKffQ8i3n9l0lgdiPHwv+tBlp7ofI7NsV4Mo8FZbjBodYYebhdRGIZq6sKDdDVrF9EFKpRHmIKu6o/mtFrMAv9qD/UCLBUPHL8Ip3oqw5KcJI9KftpnNjlxLXByrcGkTe6zWFJK70GnQIU+b3gzL0J6QImWBjAemYxbnIVWTtApTlERlU4sNImqJRxOinlfym2vSXXj49C3oBcbxm4jpbrxHWV/l41X8AB2TwKbTY5HsIk53yWxT5/vvN4zYz0iQaJQnDpFF1+mWAVDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts5Qgszp+2uCtkojC04kW7idZzIU7K1H0ztsHgURE1U=;
 b=BoNxtf8Y3S93NqpDVLBh+Mct6JgSb761o6jLeAYszuUcHR0vyg98YdQiYpCCNVQz3vKBQxHPjYUq00gCtX8OkUODTnCRtu3Kbr8JTwEgTCXO4XFKhFhgU4UcAQQuR6Qb8x60IoLhytRoCSGu8nKT4h09iK0bZnCVvVKJpiIbThw=
Received: from CYZPR14CA0025.namprd14.prod.outlook.com (2603:10b6:930:a0::27)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:39 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::e1) by CYZPR14CA0025.outlook.office365.com
 (2603:10b6:930:a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:39 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:34 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Mustapha Ghaddar <mghaddar@amd.com>,
        Cruise Hung <cruise.hung@amd.com>,
        "Meenakshikumar Somasundaram" <meenakshikumar.somasundaram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 09/28] drm/amd/display: Fix 2nd DPIA encoder Assignment
Date:   Wed, 6 Sep 2023 20:28:14 +0800
Message-ID: <20230906124915.586250-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2df4c7-85f6-4266-61e3-08dbaed7bbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw1DrW1YFH7tGg2JAFw/F6YYxU7KdtvC4F0PDsspMiKzRd2UuYaUCwlwIFE8yRBhQInD5G8vgr2513TGdeGYfjCH5q+rQ1GDfHy2oyzc0U/k6arjCKrkTO48GHgBMEZqfPH02oMKfkq5RPHJhEOR7xCdT17tvTTUmYmdb+HMHX/ODt3T9jS6NLBJ+1opHuW4BX9VQSaAKEPblCKtvbZhL2Jj/TOgxCsk6ugb+cT+vxUKY2nRKW80wC5++9cEzLQzQ81h8J4+hCO0Sy0w5bJsqw1PQrFYRlELmu2FXPtwjmrCaIczJmqESQWjDZhbFH6xpGZPrkg9VcadvoZwXnU+KulQvyqHyjpB5lBsLm4M/G7j1+PsNMEIgr2IS9o5mESBioTupXva0rNvEAb7UvOUAHrkRQCy9yUh36eqi/i/Jaj8fXITHopbBpTiue/fUyt5RDfRsi+XtuEjJSm6RnMrnnG7FSkUfGxaBJi6w8eW3ZNPhP01c7+t3Anegd4gZb41TNho20TDv6o2idZ434t+NArO5Tq9HRzuYYMpK+OGyfVBMTe+cJnekQFayKbhzh317rLZSmy+4rkddYmot6bq+s2L5tNe5+Gns/cEytgu98xzUvVtxM7xhza9QC/UKmEkTJNXUSpfi5zyhZ8AufnMek04F6k1ciIOxa3k5pu9Q302R1n4tIyrReKFmzJ25dAdkLYqClN2p6VAz8lm9MyDyrBCy1XfTcYsMyq4J9iehshv+UPFKVExPZNfDjTkxn6hzbFAR24JOaWit3T5BW3IrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(82740400003)(356005)(40480700001)(86362001)(36756003)(40460700003)(81166007)(478600001)(2906002)(316002)(7696005)(6666004)(8936002)(8676002)(44832011)(4326008)(5660300002)(41300700001)(6916009)(54906003)(70206006)(70586007)(83380400001)(47076005)(426003)(336012)(2616005)(16526019)(1076003)(26005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:39.5103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2df4c7-85f6-4266-61e3-08dbaed7bbdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mustapha Ghaddar <mghaddar@amd.com>

[HOW & Why]
There seems to be an issue with 2nd DPIA acquiring link encoder for tiled displays.
Solution is to remove check for eng_id before we get first dynamic encoder for it

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index b66eeac4d3d2..be5a6d008b29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -395,8 +395,7 @@ void link_enc_cfg_link_encs_assign(
 					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
 				eng_id_req = stream->link->dpia_preferred_eng_id;
 
-			if (eng_id == ENGINE_ID_UNKNOWN)
-				eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+			eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
 		}
 		else
 			eng_id =  link_enc->preferred_engine;
@@ -501,7 +500,6 @@ struct dc_link *link_enc_cfg_get_link_using_link_enc(
 	if (stream)
 		link = stream->link;
 
-	// dm_output_to_console("%s: No link using DIG(%d).\n", __func__, eng_id);
 	return link;
 }
 
-- 
2.42.0

