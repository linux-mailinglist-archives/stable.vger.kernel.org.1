Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3C771844
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjHGCVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjHGCVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB934171E
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W54cuW6XpKTHwz3tncjhkdv34sMwLQxkMSxRqhJ5/mEp6rzvxxOr50i3UFwVKR9xVZ4FhrrLawXR6I75pmCzPzSsYXGQ2BhWHxAWA2+UsEIRu3sbe0XOKpQOSeaZXZM+WbjHnc5Ny3aqk9HUGVF/1CP263+IGM5eRJI33aUMGy5dtn6Nb8HUWesRiAVvGkVz0Zb98G5YzgHdCBUUSrJghZy/dGpbJjb38f8ukL5QokYNAZnaA7/wSkyvONPfGirLZwZ315xvGQX3pYpGYqSgcCw0tOOj+M0YL1jQwQEb3FJMKSQpVdbQTi3Enp65vwHXyLepH/2Ht/K8AREEK7O7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+hpsoGy99Fc+x/51vBCYcYkIlz0Xz3zw0eUPG90FUs=;
 b=HZ+Xh+WjAGSZSqpaIgHPy7ZoZBo5L03yzuLJe2t4+V2XQBpFQppK93OF4sPDcZy4ESg07u5Leot0a1V7I25JQiEG9vnHbHnGgLNLwfjrxOeKPBUQvZ3wPOZXSSm7pcoieBIcqsPzr5FAvZRc/Wl21zKWTtKbjXfQWXtMZ1KzivvzbCBgE5HIkiHTPP5/jNODtCBeurL6e+3pGMoUM8sv4aq89VhRDjrAokcOyTMmfVZbKG2kzEcQb1oR0aRKqfhfnghev2uZUsZh2TfvwyBSBcsetDYN+lOyzYg5E/sBROOexB8aqpjtnAvD83fuReK+UjMx8YGJOdzM2Vcfz0ZFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+hpsoGy99Fc+x/51vBCYcYkIlz0Xz3zw0eUPG90FUs=;
 b=yaYOz69X2ICM502hWQCsgVgw8g47h7coCUg75EaPtMfPJL4o1gFAwBIstdh612BR12StqF+B3B0R1wnKQoB4RT+BcMDpJu3PT+aPmHw2HJVUg3vu1wOAEuCagTsIGJkTEfRi5VCtWI1SnskdQgo3SAtvzPnx3r2jGZggPYeRA/E=
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Mon, 7 Aug
 2023 02:21:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::81) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 19:21:34 -0700
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:33 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y 05/10] drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
Date:   Mon, 7 Aug 2023 10:20:50 +0800
Message-ID: <20230807022055.2798020-5-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f31441f-a027-442d-11a6-08db96ed077f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yidksy5KlPItHW146KYxm0zRz2j3dJv7jXc1aPK+IafaJtXN+hwwARa/49gfds2189jPXrn/xcyQvgSTdSv2j2rHsg7ky4My76QRAFyAZAE8VTc3k+nMW3FpcOhUfoI2Viy+0ZNJ4yfINZ406ujnDzuFeUuayQ3bsLR0HkwtXPlNvdAbIlVaGVlwUjcemQlTmA7yGV3NWLSamdRfjl8O0z41DJqIqNkz0BYJxdtPGgD4FIT5v9BBbZur3ax5L+EGYxe58KWeHaaYn+qD+pKfvfLTdX48XhTz7wYgys+BP7WvxtgtiaednqpV2j6bIq3qAUJfLmucC16jYuMKlUxJ6OWbGE05++gVorWJU3pKFZcESNKociaR8NIeVg9dGetQB+dwL6RZ4mGGTGkdPnyJ8LTbDJ3JVOq88GxTO+qTr16rnsHjTevN6y3pMhw/CFrSikpoApGZZsIi7SWRes3lH3gyX6Mn0fD0BKgvTWBuw5CFhQkk+xKOfpJ3fgJnC9f463HfqWilJl+qZGYIYNa7Rdns+MfoyABO51m4RVs8N1OIXLshT5tSfkUxgtc0ubaKwxaY4QS/8KPeHjW5Kdp6rwfjfkd0chgcu83nDhPaKVKNAAdfQADvh+fGbLWjgazEFd0oVORI8RxeQRKakhgjiBHPUJqiN9A97yPwbYueOkVjl3WDEP1v+ywTMZwUn/SRJ/HG3W/3Ct8VxOGqLZk7n0wHZ4ZGZZlq0nbYE2ee+sEu979E7CJj51nKSxLzEWHPCXu16V07gOLWZHcagKW+C2uxphYaXsf9i4YHxVISnzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400008)(451199021)(186006)(1800799003)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(41300700001)(336012)(478600001)(40460700003)(1076003)(8936002)(8676002)(26005)(7696005)(6666004)(426003)(2616005)(5660300002)(47076005)(83380400001)(36756003)(2906002)(54906003)(36860700001)(316002)(356005)(70206006)(70586007)(6916009)(4326008)(82740400003)(81166007)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:37.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f31441f-a027-442d-11a6-08db96ed077f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

ODM to combine on the eDP panel with ABM causes the color difference to
the panel since the ABM module only sets one pipe. Hence, this commit
blocks ABM in case of ODM combined on eDP.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d0a44e2ef90..8c9843009176 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1996,9 +1996,19 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	res = dc_commit_state_no_check(dc, context);
 
 	for (i = 0; i < stream_count; i++) {
-		for (j = 0; j < context->stream_count; j++)
+		for (j = 0; j < context->stream_count; j++) {
 			if (streams[i]->stream_id == context->streams[j]->stream_id)
 				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+
+			if (dc_is_embedded_signal(streams[i]->signal)) {
+				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
+
+				if (dc->hwss.is_abm_supported)
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+				else
+					status->is_abm_supported = true;
+			}
+		}
 	}
 
 fail:
-- 
2.34.1

