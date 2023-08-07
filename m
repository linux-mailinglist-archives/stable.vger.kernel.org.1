Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD577183E
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHGCVk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGCVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB01721
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+8P0Wye6wAwt40vrNifKBWEwygJTWZVBGUVsQqkvJ6aBo271qODaDBaH8keOviRHQG84Vl9xH8oIKyW/yE8IAgtEpgFGd1Nkd3k3548LuXP4vxNE3NMGZgnKOBVyFUKGJqyiO0sue0djiYrhXp8I9j9c3LnPLFWtaot+xlCR3acrkV+YUwss4WMEZexj/ajFx1zTMrOblGSzMIkpl8q0yGKcVFZ6hATKJ7SHoNHFGO2On3x6ifU7rv3jnnMDTILbnA8w9d3+Z4k4125gGeIiQzhQcRbqvnw16I3y9w/7TMdDXLymCgyn33dXbMHXCwAMjOQr0YP4vlRpbOqsM33ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h3OEAjS9ZdQ3fD+VvQ3LF6You2Jtl+84ImA5gsJGFQ=;
 b=cF3Vzdfz0/u33z7sFoORKkHB8TdmfbO2rpgJbF4DX+SEBb5qoDwHyyLDDPo6rSeEd95I3JnT8M8Mm3EujQE6NeCDQ1uNHL2d1/+VluW8Vy4SX89sMRJH9M2QOgzI8YhGJGySRmImtf/YRyr96Lllw585dDZTBg7EYTiQ3CoJpIyaOCl5Syo6qtykmU+ZEBjwwyMd37eD6xN8Os9hiftTFWdoidp7eAhE7Q4d0UKeSWwiyEKdQhZ4CZvmcx2hugjlMFeR9qAKQ/3CMZlLxp6o9K4W9lstEJxHbaIQ9Btqrq9kGzhevh7QJEHGDLKD2fxtFMOcZAjVc/Ut0e78Qt5BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h3OEAjS9ZdQ3fD+VvQ3LF6You2Jtl+84ImA5gsJGFQ=;
 b=naY099pBtvMdv/PqRkXPgqE4y6ke4ixjG4CxB/qLWMntBq01J5AX227hAXy/k2xSpTE8b/lPYlC8ZKlcxGisyQYuNlSahpVYJE4PcEvdX4JY3LgUJZhtjQKhoC0oWIEYuv+ua1zhrqUmi4IaD+jF2fsCpD0lPlbGkx7ksFYKFfY=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 02:21:32 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::34) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 19:21:30 -0700
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:28 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 03/10] drm/amd/display: Handle seamless boot stream
Date:   Mon, 7 Aug 2023 10:20:48 +0800
Message-ID: <20230807022055.2798020-3-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: c99cdbce-3b96-4155-b3f5-08db96ed03d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSECBZ6DyPX5N5T9jWzd5L9k6G9Gay5QMJVgls9FzQ4nU7djl1hbdi3hatmojU7hYIMrMBQu47XbyKUQHPfpPf1H+6s/X9JWbsoqO9nTE+aR8VRo2/yTCsJ/I8v6VGK129s6rMArYnx7DOM6aie01lHyQNGDZHvQx1hri5n3IuSigoMwt+ARS5Gs5zJeE6RAvCn+3eoXZkmLnXRlqNpRqJkpPV7jjdvbWMZDJyl7KYfrGMbXYBDD0faNJxSJeLVYInwI3xX5dn1DScHcIW/jlzTEdVXm32fJ55lBH8juLElxeodlCZqa846KkYr1aFBj28RqVx6iJURNPJf8jx0KS/J/Echwl4XivLJSAlSPNXZCFBbwjx/rCEMyYe0TvRavCyyocgEyPdwPh+Dm1/UuzTM8QpHXOR5UHeyIJAP4yCOAmjLn0tsqY9gLUlB59MJoaJGkR6NKLNHi1QyJTlD8ar3D/bjZI3OFC7TJUHjAzHnuS/BLf0klaMO72/zyHPkl1pCAXKGKimEuCrZDI3qtVIQBu/fom/tCG9qax4rY/v7uPtxlzHjkSQ44kCeZpBqB7baeL0Z1aLg3CSl1B5wKsJoyu/DOu4NLpBxtoDZe7OXanDBzvOJc0LI5AewqWQdtLxkAeV9oMHV9kN9Rrp5JTLao9tljYXVuOKg8y6Q9uBhcghzYaLKH+F2PP6U0jgJ8rcD/9xcWRo+jbH38CPEJkhHoKeceGO/vZHq6xmoyfOD/Pc1z+pWRQ0kzH6UAIM2/+/FWhp0EA1rer14kLQ3Le4CsXWPQvrNAvtDq4PkFtUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(186006)(1800799003)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(40460700003)(36860700001)(6916009)(26005)(336012)(70206006)(70586007)(316002)(4326008)(54906003)(47076005)(83380400001)(36756003)(86362001)(2906002)(5660300002)(40480700001)(82740400003)(356005)(81166007)(2616005)(1076003)(41300700001)(426003)(8676002)(8936002)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:31.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cdbce-3b96-4155-b3f5-08db96ed03d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

A seamless boot stream has hardware resources assigned to it, and adding
a new stream means rebuilding the current assignment. It is desirable to
avoid this situation since it may cause light-up issues on the VGA
monitor on USB-C. This commit swaps the seamless boot stream to pipe 0
(if necessary) to ensure that the pipe context matches.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 613db2da353a..66923f51037a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2788,6 +2788,21 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 			goto fail;
 	}
 
+	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx
+	 * matches. This may change in the future if seamless_boot_stream can be
+	 * multiple.
+	 */
+	for (i = 0; i < add_streams_count; i++) {
+		mark_seamless_boot_stream(dc, add_streams[i]);
+		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
+			struct dc_stream_state *temp = add_streams[0];
+
+			add_streams[0] = add_streams[i];
+			add_streams[i] = temp;
+			break;
+		}
+	}
+
 	/* Add new streams and then add all planes for the new stream */
 	for (i = 0; i < add_streams_count; i++) {
 		calculate_phy_pix_clks(add_streams[i]);
-- 
2.34.1

