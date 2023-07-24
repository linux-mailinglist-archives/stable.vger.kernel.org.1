Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E273D76023E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGXW0w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXW0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC510CB
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVTW6MyZAZX2lLuT4jn7xbFjAxZ8vmY34mRsdDZ6IiUAhZDDhozzGlss2ijQL+E1Aueeoq+zoTDhnmmcRGsaPwj5L6Q7VtA2+qNkVN2JK6k6m1X2G2tJe7Iz+U6jLWEzTW9W8+wuM31PzCcBq51jsIKWjnSQtmm/HuyA8xvIdkjmCzQ6ygcdm6dm/SG5GXd4NaXBf5w2Znh52sUo7R6iRko50hvzr3sPy0bVBnYPOBXnITB3WGO1slBb+DOwqaajGweKVS6IgYqCKjl8Ac1KR/vC5EZqeWdQZsueso70Xaux7wq+09Z4WAi6fSvxX5hzDHp8tR9ST6yXx7JiLr5AJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj+aJr9Qd+XsppY1R8oU8dURzZaOtqBb6s8kkBJVBgk=;
 b=oZVLfsLakYr2ANEdUh+jRWbZ7QBI78JaLzvYdzGvPsKHCE/cfArH5rTdRun5OXB9uN0mB6HULRpWFyXjSlWTX1obk2frHEJ/xuRMj60vBSa9RzO+ytZ12xdSvy3yHcN+tyrMNHKOW1tp1KfnUqas6W4h5nzJ4FnBRzpCT17JHHwqBb7FdDv1333vZ7M86QYYS0uDcD2p43U4NwXiJtewdKzxj3zknJ4PbB5U3EQGGXNKfhKH9CWvAqriCOVYgtSIlpgcM1OW1Y+A9VwRNlqkN6oefydQXqOIenfp7H6LfEKwNmOCa2Tw1C2C+WjeAperIw4Y4FjdaknuwphHh4MRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj+aJr9Qd+XsppY1R8oU8dURzZaOtqBb6s8kkBJVBgk=;
 b=fdFB3Y2x5K+4fWXkoHiakJR9wkxNcIewG4fCpvBUkKSv22ydiA0+qbsBVcRgL2gRPCH5GmlpuCfc2bTn0tIGWeWjucrV0/1w/6+rHewUpBmeNaIZMEz+Uu3hr9ZmteAsoVhY2A7X1Uisj3Z1AzBy7g0yfr0C2Hz5CC+pj+vs5GE=
Received: from BN0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:408:ea::25)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 22:26:48 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::9b) by BN0PR04CA0080.outlook.office365.com
 (2603:10b6:408:ea::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 6/7] drm/amd/display: fix linux dp link lost handled only one time
Date:   Mon, 24 Jul 2023 17:26:37 -0500
Message-ID: <20230724222638.1477-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724222638.1477-1-mario.limonciello@amd.com>
References: <20230724222638.1477-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: fef120c1-a2a8-4a03-37d3-08db8c9511bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8o0+kGy/AZIpFOCvFiV8gPHTrw5mZANyiUyZRuZ+rJ7WlGRjke6mgK5kkH2DMShXL4yZ/bqyEH6m5Ymwq3+9LgAPRMcUPStLzjI3H3hNaB9BUZSO4q0L04M942lGFtBm5NSVimag+hSPUeMdDcruBZMMZQIE5dw30zLL858YwvXk4mjCKn9tpG1Fmglodpf+e/IliV3saZgN7SsBr/pQlphgAQylpmGo/O38YYBrG0a8GCE0R6ivcgFKf6QHgIMUzb9hot1DA6aSgfHb67BPY0JZJv8UkNPeg5gQnxfPVpcxcyovnztold8gZczakJTrCEQAgmWw03KI/V3nPqsCKRNvGfbxoEEdeBa5F1zyFo49o/rMTDKRdUVvVTI49iW89/iRKNasBm5sQMg9jP/EOo91I2++GZ3/5kJWJl8CUAP/lEXgwCBcw659UXMMrYLnWLW8I3lb2OX52dkDy7zI+R1/p9NFCOqvMXyBWJSmyW1aV9OCK3S0D68TyuTNcxAnxahN8a1HrkuM6CKSKOmV1iUUBPT7vgS5rT2CZ3wefSkFKgyihgeqiRvlvIpxXx/b0w91XrirHQwzZ2UWHvH2j1O2gsG/qGbI1kfetrksrET/IRElvoL6OQM8C8+Q/DKfrfgDw9oPt2UltUUvvlwOG2ztLWMYTKQgFLXogAZ7FJFo19BuGz06uFSwPPc5dByUf9rX4wOgAsUd8nRcdw9B8piuuc1H2TeBktYOLJvI6RWeg6H9wjIENp/mG35L/1/ORRwgpfwpyjeJX4h91dymQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(81166007)(40460700003)(40480700001)(356005)(36860700001)(36756003)(2616005)(426003)(47076005)(83380400001)(8676002)(8936002)(44832011)(5660300002)(6916009)(478600001)(4326008)(70206006)(316002)(70586007)(41300700001)(16526019)(336012)(186003)(26005)(1076003)(7696005)(6666004)(2906002)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:47.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef120c1-a2a8-4a03-37d3-08db8c9511bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
linux amdgpu defer handle link lost irq. dm add handle
request to irq work queue for the first irq of link lost.
if link training fails for link lost handle, link will not
be enabled anymore.

[How]
allow adding handle request of link lost to work queue
before running dp link training for link lost.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e322843e5e33e72ff218d661f3d15ff9c9f2f1b5)
Modified due to not having
c5a31f178e352 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
until kernel 6.3-rc1.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  4 ++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ccd39b4fed14..e64e1ed46faa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1346,10 +1346,28 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		dc_link_dp_handle_link_loss(dc_link);
+		/* offload_work->data is from handle_hpd_rx_irq->
+		 * schedule_hpd_rx_offload_work.this is defer handle
+		 * for hpd short pulse. upon here, link status may be
+		 * changed, need get latest link status from dpcd
+		 * registers. if link status is good, skip run link
+		 * training again.
+		 */
+		union hpd_irq_data irq_data;
+
+		memset(&irq_data, 0, sizeof(irq_data));
+
+		/* before dc_link_dp_handle_link_loss, allow new link lost handle
+		 * request be added to work queue if link lost at end of dc_link_
+		 * dp_handle_link_loss
+		 */
 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
 		offload_work->offload_wq->is_handling_link_loss = false;
 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+
+		if ((read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
+			hpd_rx_irq_check_link_loss_status(dc_link, &irq_data))
+			dc_link_dp_handle_link_loss(dc_link);
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -3324,7 +3342,7 @@ static void handle_hpd_rx_irq(void *param)
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
-	int idx = aconnector->base.index;
+	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
@@ -3466,7 +3484,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					(void *) aconnector);
 
 			if (adev->dm.hpd_rx_offload_wq)
-				adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+				adev->dm.hpd_rx_offload_wq[dc_link->link_index].aconnector =
 					aconnector;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c86d10e45b55..82b747c0ed69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3115,7 +3115,7 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	return max_link_cap;
 }
 
-static enum dc_status read_hpd_rx_irq_data(
+enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b304d450b038..d60d93ed7df0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -82,6 +82,10 @@ bool perform_link_training_with_retries(
 	enum signal_type signal,
 	bool do_fallback);
 
+enum dc_status read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
+
 bool hpd_rx_irq_check_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data);
-- 
2.34.1

