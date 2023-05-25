Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70B9710212
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEYApx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEYApw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 20:45:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE3E2
        for <stable@vger.kernel.org>; Wed, 24 May 2023 17:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OekN1c5JNBrF9oxKuJeCnXWS1NAtY97wnsTCzAukchYBlslt9vHVBu74amjplP+cb1iR3FOFfOvWtl4eLmrBerWMnJf1qGnUl5PAoHGpoyJymEjNKIgOhiQZKzaFOQVfAoOlg3sfTGwbCa4MmOQzWz1BR8VvOyEtMWt+53qD+VtnJDxuZk2e+e8BTGe1wfmj7BUzHS62wa3g2uO86ar/Y+TtLSlaFQZMIOYCndmmPD1KJaT8jmUQTdCmcmL8LaJgL4DSlVZCE8FM8POf7ud0GSHM08g0ZKiReWEXE5EjgokvjKHF97oeWdW2coTjWdd9otYgJCH+JGc6q7pkZOfLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrRsZNjsGtb0tuqT5RIAD5XpS+CnaJukx4LDzQblTas=;
 b=oHql80BnANlc7+hvHkYGzgTqhdhOeuz/EbBKkH3SzU3WlsAdbV8AtaBLP6V6l9mpTPTXzDLX82/x+qKDhz0hx7xIRHYfa9onTDxjkR07sN1Tt0Pxv8d/Xxs1AFC2cTtx34GcwpJx2xMHrbLXKST8stfiJ6VNMOAJwX0H2XdaYkJQA0GfGczno49WucUJiRDAVCwdneHbpzVRoyRUN2+Ruk0XsCgdbMOSGkanOY4/g5av0lew2Y9Yv4O3fg+h3dCmHw3Qp1S4xNBMLBE+28cnlyTT9VL+bwjbbg0rc+sy6kC81rbclZ/6TQ+EhDgF9SAQaqECKbNS2q6vwe9GQVrFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrRsZNjsGtb0tuqT5RIAD5XpS+CnaJukx4LDzQblTas=;
 b=bkddOV0mKkPabLb0WF/7JOy+IBGrGusyKbZqyB7jPn9kMHEixVMSALw3kXZdXMUHMku4Fs26MRc7kP5z13gq4XzOMgT+IyXFY8TBGg47wJuwBhDGgZuhIexjN15W3aMWy11pDxtcBH5jvKFkSYTmNcsEXm5I8WO0mCdtQGn90gc=
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 00:45:42 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::8a) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 00:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 00:45:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 19:45:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: hpd rx irq not working with eDP interface
Date:   Wed, 24 May 2023 19:22:01 -0500
Message-ID: <20230525002201.23804-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: e93b944f-6026-442d-3e27-08db5cb95e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gADmn7GXq6B4g4u6ATz/8h+Bzyke0bnOvTJQDnfGzB1m/2wOO5s9OYLfDtqFfMf/ASKV6DZKiYesXi92w95hGwXIbu3Hfd9ElkrxU2qm+Sk5GMq/+e0VxeybHyy6X4/6IqeLPCOQz5FO1U87ndhI+/39HoHCjNyYkbR26EIO78DXdwId9Y1pAPhIF2aPfPCNuehYhRSFEiSaANmYvMccJZijzE/XSLThLlpJR6SaNOwCPcQAwyv22tARSqdLi/j3Ty406NjFuo5lg00SNgfI/ahj1nytuNl8G1nqjEwjRfyH14Ml919ZmPKjw/ECehFEErQAypeyghWj4yGBESxMzY2cyaS8JZbcpxKPS5kmZneuLcI1LN0KIQnjwf9iusCx7TGukJp/sxvIJgfGjGWxYZ5s734HAgW5RFhWxIkbS4THGkvLhvgfTqCnj+2xPm5qBYoEWGTzfSnxIQn18ujxZAUoV0mon/xMO7f2pnFxI7ZXn8njHYy+m2bF5kH8LnMGx60h2K/k6ZvWbw8hyrAxWqiz5KpuEKSciluW4ezwQMV/MQqfT+LDO7qald9L3buSCthIsCJPihzsbIe38Q8RrcYIBfdM+vJ6bGBs+jK9ANTMFLbzxCEIiw2WMyBnhzXuxS8caBn2z7ymBaB0LD45ZPMBH/Ri4Gb9OcQ5K5XoeLFfqReSs+J5zcpA/D72tmhP9UUttjt4fl8qDGruGQSWKo1Ofbs4htLMcCVP/W0eiZ2k2EKRYtfHPW4n+ZyIINdUQa6+v7Vf8r5iRQnjasuUTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(336012)(426003)(82310400005)(2616005)(4326008)(6916009)(82740400003)(5660300002)(356005)(81166007)(8936002)(8676002)(86362001)(40480700001)(2906002)(44832011)(83380400001)(40460700003)(316002)(47076005)(41300700001)(36860700001)(36756003)(7696005)(6666004)(478600001)(16526019)(186003)(70586007)(70206006)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 00:45:42.2299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93b944f-6026-442d-3e27-08db5cb95e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

From: Robin Chen <robin.chen@amd.com>

[Why]
This is the fix for the defect of commit ab144f0b4ad6
("drm/amd/display: Allow individual control of eDP hotplug support").

[How]
To revise the default eDP hotplug setting and use the enum to git rid
of the magic number for different options.

Fixes: ab144f0b4ad6 ("drm/amd/display: Allow individual control of eDP hotplug support")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit eeefe7c4820b6baa0462a8b723ea0a3b5846ccae)
Hand modified for missing file rename changes and symbol moves in 6.1.y.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This will help some unhandled interrupts that are related to MST
and eDP use.
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6299130663a3..5d53e54ebe90 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1634,14 +1634,18 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 
 			switch (link->dc->config.allow_edp_hotplug_detection) {
-			case 1: // only the 1st eDP handles hotplug
+			case HPD_EN_FOR_ALL_EDP:
+				link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				break;
+			case HPD_EN_FOR_PRIMARY_EDP_ONLY:
 				if (link->link_index == 0)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
 				else
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
-			case 2: // only the 2nd eDP handles hotplug
+			case HPD_EN_FOR_SECONDARY_EDP_ONLY:
 				if (link->link_index == 1)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
@@ -1649,6 +1653,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			default:
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ad9041472cca..6050a3469a57 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -993,4 +993,10 @@ struct display_endpoint_id {
 	enum display_endpoint_type ep_type;
 };
 
+enum dc_hpd_enable_select {
+	HPD_EN_FOR_ALL_EDP = 0,
+	HPD_EN_FOR_PRIMARY_EDP_ONLY,
+	HPD_EN_FOR_SECONDARY_EDP_ONLY,
+};
+
 #endif /* DC_TYPES_H_ */
-- 
2.34.1

