Return-Path: <stable+bounces-10621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195F82CAB5
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F73B23081
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409177E8;
	Sat, 13 Jan 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgFtrSB8"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B1655
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJbvp0QacMlSC9q50coLO2iIt0ZBMYDP/8cifX9w98gh//ReFVXNxN7WkiTxxmNURZ7l17n9yE5h/TVh4Xk7oOXKkeWU9wejuCV0hxZA+BJajWYNEQ0RZUIje6lM2ylK5KXtjod5bmWDTnKB1zzPu4A2mkbP/qtGcGJseoY/+PbZHFCr+J0HY+eHVAPUKIzxdxmmO5qig3Q238FwKp0ptwI7bS8xIBcuIYeLSrLaLaBhPTKet4f3Le0au33hEsSocQ5HEqp800xKtczCDc4mXbvOAzxYSFA8EWjGCSrH1IB+8zqUMunGDMUHJCTtIz0Jv7GBvsNiXfSmBpz5SVvQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90WadjHoPJk4pgzI9QMyCGTmWv7kOr6NSJsQnBMTeJM=;
 b=DrWc54swckJg9/cH0Zzckr/z3IPiCedoEIL/SpVfFgGvpN57isEgE1EH+SMQ6gnUDAJkqp8IowsG7gSf4Fxy+1DV2MTaFOcrcYXwRFLeySue1JGAVPu4PNnhlOb065nr2VtGn60C468C4hwyqZb8P5G/L3DUyJwM2ePrNolzrsUMaoQSgNHFirgueZRxq4/zrzzxCkYhiWbdN89sw3EJ+sqa1ZpTaMHyM6Us6guNJn3fjBd2vuCWmbKqNKmzNJEh5Vm+DCXrHgBlZ17kKyNSr9dRYVZUZsd2Pdm97ZaS/bkSOODTJmqhU+B91phQ6dUwMM3QCc292+IZB3zbfbh+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90WadjHoPJk4pgzI9QMyCGTmWv7kOr6NSJsQnBMTeJM=;
 b=cgFtrSB8sb+/oOC1DAe0/cGke1Ufdn+5t9h2wDlTOvNeqe3pJzpSbfBMuE+Y1U3TGPxIfW7DwlWG+PRK//nmOS/JGUYN8rQKGRj9Evtf1C7ovyY9KzIisGt3BPIx1+8n4Go3kcaltmhxDiCvExdz3FNj5nL72tBuq3lahTllbGA=
Received: from BL1PR13CA0414.namprd13.prod.outlook.com (2603:10b6:208:2c2::29)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Sat, 13 Jan
 2024 09:11:18 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ec) by BL1PR13CA0414.outlook.office365.com
 (2603:10b6:208:2c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Sat, 13 Jan 2024 09:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Sat, 13 Jan 2024 09:11:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 13 Jan 2024 03:11:14 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests.
Date: Sat, 13 Jan 2024 14:41:01 +0530
Message-ID: <20240113091101.3428373-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4075ea-3bd8-4396-b808-08dc141799f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MKjvMvMCnmF0xpwoAKse1HWfB7RMGFN4e8i07LTJXwUSRgcIKtVSG14wjDZD3aWD7FsiIqEJmNUqL+x95aQoXNFH4dzjy3aObMeLHLLWkYGti2FzKLn43shL92YrD3rVQeka3Riypg76iNRNgAbVuiuiuxk6IuTZacjhrZp11re0ghl1b5yl5ZwzO/6hHc+Qf9vE6yb1vEOWYyZkb2IcHzNYr5sq14lx5VIRgqyuNj8ycJCrRNjrwuHf/8jOzcJZubwUwUrMmZa2gUSk2idPN+W2fNJ+ofkOhi9QJ2AJhRD2N5tiNfsHHAYaETSxvBnw1ladyAmaUgm0TNzjrUo4MzFGn2S4KQNLUf8u//B/STG9is8q9qfyZAqPBgdpaJtfJ/JTaCd9txHrhanTCq4TVl70HQp9AqMpM2NOqydoGYGw22r3xO/RBNvxcR2wtYvxHxRcfW6gKhnHCINwY9Q4Cduglq8Ak/ox1DfgiHU45L84NBLr2ZLkR2cJqRXJoJSvGmwSlIITz9dm6SZ/U9ewuchIO5hSuRI2PqqqLMr1+TgeC9OO4zdV+0ICfL7n4T9Z62Qc38UxiTTGXJrBGo+N1udAlCtjbIiB0h3YP3QQgXWEgp072L+mnTSR5myjik72TkRhC3IjkLTFAYo80MuBi5RpHQx7vczyF0ArVXA6OxgOIBqZtlhVVSqxUPRWznm+rJ+H7GkXyWUSl64cBPgQBK+qyx2cXW9/n0QOzFHaxDi+/fAv79uKkjf9rqP49VxtwwfZkL9CAs1vsyPzW1hs/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(82740400003)(36860700001)(336012)(1076003)(16526019)(2616005)(426003)(83380400001)(26005)(2906002)(47076005)(6666004)(8936002)(8676002)(44832011)(316002)(7696005)(70586007)(110136005)(54906003)(6636002)(70206006)(478600001)(4326008)(41300700001)(356005)(86362001)(81166007)(36756003)(5660300002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 09:11:17.8857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4075ea-3bd8-4396-b808-08dc141799f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

Return value of 'to_amdgpu_crtc' which is container_of(...) can't be
null, so it's null check 'acrtc' is dropped.

Fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9302 amdgpu_dm_atomic_commit_tail() error: we previously assumed 'acrtc' could be null (see line 9299)

Add 'new_crtc_state'NULL check for function
'drm_atomic_get_new_crtc_state' that retrieves the new state for a CRTC,
while enabling writeback requests.

Cc: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 95ff3800fc87..8eb381d5f6b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9294,10 +9294,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (!new_con_state->writeback_job)
 			continue;
 
-		new_crtc_state = NULL;
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 
-		if (acrtc)
-			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+		if (!new_crtc_state)
+			continue;
 
 		if (acrtc->wb_enabled)
 			continue;
-- 
2.34.1


