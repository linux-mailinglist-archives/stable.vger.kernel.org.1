Return-Path: <stable+bounces-18869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CB84A8C1
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170A829B974
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D14F206;
	Mon,  5 Feb 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XeItxSot"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C75A105
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169391; cv=fail; b=UQxYhQ+IhO1MacOAPiDF83mFeuXyOSURxnM2gDL7BKa8JLP7qu9wG31dhfRCpEbeSSVDXsMWL6W13P/qrlnDBlCUsjybxEhdwJ5rFXCg9tz2cRdYMU0eQqwNj3xO56eZe+nutMIQ9YEnbs1p5sj1K59+BAp2AkfW9tMgZ2JAbJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169391; c=relaxed/simple;
	bh=ifLUXBl22GdjntkIWTEgrwYGSo6MbhOopL8SDKFO6FY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILd1p2z1J9cfpvz8GUtJBuG/k8C9psyYkNeAU9UVqKlVNL1ClA2/XYMAvbYhVGATDYq6DPGDg62X23Faq7xZnx/7pbGlsnOFqsOBpC5VmqJowhj7yKbk8KU8h/wjTiXs//VOUczqVFkjzLjsXI1n0QxKp3Bvzb32YSJkStk2L4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XeItxSot; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5sD2O9OB85pkt3UXBV1v4BMKYsfbNd8/KR2uLspkxmAiLX9Ax2NcO3MBnYXkfdfo9LACDbXqNekQhUivwfw7YGFX0YqHsc5YNx0noHWJ6vCrYloCPYnJ2SJDiwm9fAJYSvguGqlFdCqDLf7IV9O1RWwz1J2rbH1FufkstnqJRFbbAnHPD3Y6kuMA0JE330Ar3ko8NSNNA7vqoooaDtHW+/MwrOaPx251NWmkj9DF44I9wxScsmoS03/v/Rw1V8FgwN4mfVcV+PAfd1N/p27bamfFIHNf31Y2bFkVZFkwSxVkbfuL9dLdQpOtmCexvIl4N+kwCpjTQdNKzxaFIjHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuT0nD89Uw4+/p2EyVf45YPND3/9Ga/TdCf+IRTMQXs=;
 b=WfXhkpLTqGuQOyY6IqbVvMkaOi08iFsrx/XUohJRFzPsD56eUCPEvr98KWnKsEv4OEmu+b68gOon02bGMrR4CA23SR4hwXSJleCjFpJSvAsqpY/sfucgXEnQ0Jg6QIQxS4qCaEv4Ar8/HU6qTZMBmCd95yCTmCJ8l+VpSjGH+wIx56e9G2nKJSS1E1cIIbbDj0fwb2mYi0+B+0kvmtOPDU/BQWUJtrOQn7IKeJbIhuQO+98zcBiB6I+yTb16cIsCvcwXn+y57EK/wl3Qy7InL4R2fM3DPgJVms4SQ5Iu2w0tP4CRb2ZBFvMcgl1lEtuqZZ8F1EA4muo02CBFVBseMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuT0nD89Uw4+/p2EyVf45YPND3/9Ga/TdCf+IRTMQXs=;
 b=XeItxSotogUL018r6uHdwkjzZSi96JIVPwcHilEh4FGgj4t87pbztSMzFW3oPjD8Q1NAk6zuPuGQN6HeZBgxtmcnRcRIvqhGEs7xZVNmildCRNAt/5OSRZbfqmEC4Ne7j0qYAu+w0EsU7sgtdrFAnunzvnfIuHzAAK7M+7km//0=
Received: from BY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:a03:1a0::16)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Mon, 5 Feb
 2024 21:43:05 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::a4) by BY5PR16CA0003.outlook.office365.com
 (2603:10b6:a03:1a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 21:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Mon, 5 Feb 2024 21:43:04 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 15:43:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	Marc Rossi <Marc.Rossi@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Date: Mon, 5 Feb 2024 15:12:33 -0600
Message-ID: <20240205211233.2601-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3284fc5b-388f-4e98-e996-08dc26936ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4lvTLLKVUH9/nJ5Ju7gdqov3MfhqVBaPMzV4I/6xe0wKP5uVZK27DrAQ9WY8UFkmQlyQBer6LDIi7BOZdoq45at/7zV0or2Lpt6Bxx4Xgpp+YQLC9MG5NHWyEYWZ4B+FUY1XggmduzdRHbIU3io6aPGO4iUETwuOlVC1mNyMN6szZnZgDdsstbHvXXNUXm2Gh1QfpGvNSGkqGPj3GhoyE8QwWv8G4i5E4n9gHTot68H2eHXqpDRef4Lsnwu5ANmxVmPeXqFJRNwi+dV7z4MwqCJXkcn2j2OgS9Z2nCAfS/w5Rqedtr67/t6iyO6ma8Mr8fvw5BGRrwe3vS9EaFFHYrx4dctVWjRTQxczzY0kpSdbVFrCzTiS1RDYOMBbYVmq6PGOlTqWffBhW/AgO2kWBEeGeUSyZRoq+Fxf9mYeCQcGORNRMR7Vm6pce5DH1l8PBvLj+dIyVOJg7FEaHLxgX2dRkKLk8+OrhBzHWWuwD3SYYHDMNv2MGyCka10KmGMR9pKXIQnVWv4OyAKV5SnTb3QXZyZH3RV/2kZRqwH5yR6YL+zwde1wegyHeQsv+aYForvtYw88LggmdRNi9Tzx/wj4hKShdfRPmBhN/JSrb1+BysMzvJPblucrgg2E8Iy6S4rSMbtma0hBRieuDoULGMqrzG1VgQGXRKViTwg9eEd+pr5Lwc3dNC+rX9SYEQEn4YKoW4871tE0uVRND76bdv/N3SQVmSLLYyTb+koMehNDvJqZVved/GSWp5kbjHL5RBoRyZ3zbjQeo3KdI6ngyOdsb6lCFL8WmEEKW2guy88=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(54906003)(336012)(44832011)(36860700001)(36756003)(8936002)(41300700001)(82740400003)(47076005)(86362001)(6666004)(70206006)(8676002)(6916009)(316002)(16526019)(4326008)(1076003)(7696005)(356005)(2616005)(2906002)(5660300002)(81166007)(70586007)(426003)(26005)(966005)(478600001)(83380400001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 21:43:04.0864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3284fc5b-388f-4e98-e996-08dc26936ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

Stuart Hayhurst has found that both at bootup and fullscreen VA-API video
is leading to black screens for around 1 second and kernel WARNING [1] traces
when calling dmub_psr_enable() with Parade 08-01 TCON.

These symptoms all go away with PSR-SU disabled for this TCON, so disable
it for now while DMUB traces [2] from the failure can be analyzed and the failure
state properly root caused.

Cc: stable@vger.kernel.org
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/uploads/a832dd515b571ee171b3e3b566e99a13/dmesg.log [1]
Link: https://gitlab.freedesktop.org/drm/amd/uploads/8f13ff3b00963c833e23e68aa8116959/output.log [2]
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2645
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e304e8435fb8..477289846a0a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -841,6 +841,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.34.1


