Return-Path: <stable+bounces-15583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4351839A6E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CDE285102
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B62116;
	Tue, 23 Jan 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4rm+Hn40"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBC20F1
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042497; cv=fail; b=PjoqE+UQH/86eYwqzFIfTB2vLYLn1H3PLcGYs/QCaqiMRdshY6GQV9ZCSOcqeh1h80zL3lJg2YhgOhPQHzsPbG/bF9hWM4pFfs7/3iXLP8iyWT5/1lxZgx/jDd66qkBuK+izXa483NYVyMty5H7hKexnsLdZ9r5U4hfKxzTm9Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042497; c=relaxed/simple;
	bh=ZafAvB68CwA6kWQYFMrViEBG5tyOMNpLDrn1A37MvSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7rsYGkcXE34MQw6iCXDND/qXpSpbA0bBHaZWPmJ4Q/8g+MnOGrJ6UJBKhHizTm2Wy4veOi20018yTFYjDJEzqyWJNxytDJBlVeF8vJWwGEDibcXC+mVmjebI+ao39wo7lt0IIGgcKp2HJ0VaTMiEq9wrc7i91W+3FjMbaZ8dCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4rm+Hn40; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1vrFYBtqYHIi7oa2Zts6bPPi9vbqyLQWv1qpwA9cbIZ74n7+Myd8HZXTGi6fHQ7Ee9vDsayNAwgSuwD12hFej+UJFqRDSEZuUGlHA78BnbYa0yOeS3gy3e5tG8nz/xWCfaiI46aKEWA/S+hVM5Y1h4JhWfGvuN2vZ4abtPNby/VmULF/9ZNkFYWYj12TpRxGGrxkOciVi2tCDSL86ia5QmXnzWPpGZaaQ/DtMFoqbFNM6aZE73mWfX31ienXWlPHOQSGckkzIRNSlGiZftMqca601mU/VTnuz81jBK6Q38oJl3tGXUmhNJcr7/+G8/DPhuP8Q2EKR/f+9Br4oyIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHJmJmy+GSxtbbinRCtqhdMmywGv4J8ojF+N7OeudWw=;
 b=fPcrhSEUpxuwi0IzfoiRHNFagmFT/+t0G7zWQVTWfOfoLlZGtPpet0TVRk5uPTZPMJaKBM66s21f9U04BiWakCf33gOrzU81EwyMKddKhtwCkMP+gLLSSeEErNADt7UhWRuuv1xcTXzVuxzXuUZsveNn4n/h6nzT5SIkUKChzrxvcV/UxhMN7CKFdlYEiz10QCDF2td1Th8uAXZ32OM+Han7nSclp8RT7HTSzmKha020oPmiuTwGlQ95Y3WXKG57J8rKIFTxPG0+1pGSuvhkN/pKZrNI8TTlu6Skz7e7U4dLPuhMGEhwV1hfYIVu0OvS5AvcClNB74y6YmEQars85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHJmJmy+GSxtbbinRCtqhdMmywGv4J8ojF+N7OeudWw=;
 b=4rm+Hn404hZYK5Wf70QqpsXgHYGuGtnFN0LMu1Xvra2iH2z+5OoJ2Hn7gxEGA9ZKrwSkEl/UCvi9UdVwduY1R6BS+//vTYEG9qlmsVBBBlWQSJZo3wGjpQGPCle/f6lshKarMc7W7bZz3HPAPS14uAlfoBy4bzQcvz3pGbIvL7k=
Received: from BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24) by
 SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Tue, 23 Jan 2024 20:41:34 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b) by BYAPR01CA0047.outlook.office365.com
 (2603:10b6:a03:94::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 20:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 20:41:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 14:41:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Wayne Lin <wayne.lin@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Wade Wang <wade.wang@hp.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: pbn_div need be updated for hotplug event
Date: Tue, 23 Jan 2024 15:41:06 -0500
Message-ID: <20240123204106.3602399-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c0d156-8fdd-4c7a-0e08-08dc1c53affa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7F0Tv2AY3zsTselnzV4WDq2xeZBu9QWnKlI8COclbkNgLAa2MRQRljZq4XtCPvw6JpblXwh98ulsbWaEDTJdCJ9p9pcyUa4oSHDIdljJNJYjJO68mliPQEztwO9qk6Can4mRX6Jqkce0gIKi/sYYET/+II+f+tH4WDD6q8mhMZhfa3UQqHm58YTW3bpBrbd/BOH9L4SovvvlbZ/h6bL0UPYWYR2zceNfOD/5v0qpRUM8+r77J4fdHX7Dk3zuhhcTxwqWlcQXNXwzpoWbLuI0/yT1LP45t8+ZfMJtmTWU/K0g0bHbMuJtQGVrEK9sIThKiLFx1YEzzxr+XR3RgvPPJr99tgKIGcOW95qFK+d8/RkOT1TiS5l+3qmsZxIDqH1t15rubVAqRmBOWx7rNJX1JOI4EgoOI9gQtrqFE9OetrLWF5dgRtklCakaaNcg0wh2QCSrgDOzcqDkmEfXR1GrnVEASaLJAJUsZK8zPVxXHzBgU0yO44jSpRqIcxYLIMc/7MQdELjpKDpWsl/g+0Zdl0s4F5Gyy7Y+czzAo7SJIFNZOwjJQgMYF/64ir4G633t10r1Gy0gYVDzn45/x4jr726q3sCXRWEjlTC0VkinTSo7RWXQdLvXbRclD1MpT0uIeHJxLHDwGiulIpAzBxU2HqYCYoBUFvqbuuk04e4L/SRFiFmA1UOK7H06lFFsGfjpnGoA6oLQzeGBW7e2fAuiGAAL6WBzKV87fveubpbsja9xedi8X84tQQHKGUkbI0RllkpmtO/5hFFqosHvvvX87sGKkv3TtjSmG8qTxMv1fP467jlfBsJ7PpEvk6Mcq7Y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(83380400001)(86362001)(356005)(36756003)(81166007)(336012)(7696005)(8676002)(8936002)(4326008)(47076005)(36860700001)(82740400003)(16526019)(26005)(1076003)(426003)(2616005)(54906003)(15650500001)(110136005)(316002)(70206006)(6666004)(70586007)(5660300002)(2906002)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 20:41:33.8625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c0d156-8fdd-4c7a-0e08-08dc1c53affa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

From: Wayne Lin <wayne.lin@amd.com>

link_rate sometime will be changed when DP MST connector hotplug, so
pbn_div also need be updated; otherwise, it will mismatch with
link_rate, causes no output in external monitor.

This is a backport of
commit 9cdef4f72037 ("drm/amd/display: pbn_div need be updated for hotplug event")
to 6.1.  This fixes a display light up failure on some docking stations.

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wade Wang <wade.wang@hp.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9cdef4f720376ef0fb0febce1ed2377c19e531f9)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 13e0b521e3db..f02e509d5fac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6677,8 +6677,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
 
-	if (!mst_state->pbn_div)
-		mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_port->dc_link);
+	mst_state->pbn_div = dm_mst_get_pbn_divider(aconnector->mst_port->dc_link);
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
-- 
2.42.0


