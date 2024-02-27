Return-Path: <stable+bounces-25279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B603D869EFA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D201F25703
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C2814830F;
	Tue, 27 Feb 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HVOL2Krh"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980633D541
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058013; cv=fail; b=D3borxWRaGbCT9Dpoglwq4jAmRgu0w/o6x5untWeFHeGBREP7FQgmuOsdHtWbBeCGc98JLPESRyHOEx3TUa5CpolL9r1p/8AWIHZMGIo0Q4fek2j3UAogEco1UVa0tUM8GeV4pIYl7gHkw297MtaMBheQ8ogjPNFgs2+iPPr3G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058013; c=relaxed/simple;
	bh=87amdiyAgkGfUINCghUbV8CBpFErERqaMWPBeL9hQFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g28c7kZQ55rvTZYI3l5B0BfQs601zOtJ0nSnpJvSAnYT3Kt6KL8fxVqASEvoMU4IcQaJupiLdXgwxUWX6JME/0Zh/WGZVEv8Xrgp61UMff73AStwBSQQ8LZrjufLlgM3L0irIoD4EJMWwTMd0+oA3yA7lDDvU6vWZkyPajPC7rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HVOL2Krh; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxo90Iuk9VvXbg+gHnT/GJprYm5As9cPSmCo82kKkc6cWk/5+50ZB/VblMmcW/+bhoJGuqwYEqkCWmhVeRo0G8VTKC1BIq8U1g+XBo2GRFyOvKrmRm6GFZGjvmikqUNCTBx+1V+TLts1oofWxkOJpNyphPSQVXota3G7yIANaO0/ecreLJPJuNs8Mt3DZyROvVB4Z1JyvCHvi4bXd0Cw3OPoBhOJ0mtaRUyim7D8/eKxGApM+6ZkO9NwTsKjSmv8p2UJYUu6Qk11/FLKWAueKN2hiqaN7QGoAHYbE9t/071Ajc4WWxf81NKsfQjfsoAtRu2AdoIWB8zH8ESGuQP8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EKuyzd7XlOBaGDdbYLdHw83hKwPcPq8Mv8KekgJgH4=;
 b=Ld0igPGheMsgXmyF6RsBNONrpJPL8F2h0fGoaSSV9k0aVEvEZ4uwE766nVFEDy6H6vMFaPTX/2G1uIoiWdlFvMe945j+NLfrqyoqCh/6b0d15XVRvoJ4/7Wl3sh0xmR38f5sfO93qQymOIsCmxO2oUgKsJuW5cUTPn54zyhz+qDHmF+5dGkQC9fm+IMX4GLeXRUjpUzpIqFNqnLCEY2BpOsAo7S93bGb2HGUPLLfTXqUm/ZKxSFLF4ZjfFDTYsRjg21exoXu488jb/AT1w12JJ6Cr+4kzPjamFSLiNVwPirtI9ABxoxD0dyJoNtp9rMfDpX9cWVXc5blVgXevIZ1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EKuyzd7XlOBaGDdbYLdHw83hKwPcPq8Mv8KekgJgH4=;
 b=HVOL2KrhyhqmtG5XFwFXLh3jEbhIYw3+4IDsZt3jJOl0eZdOkmDXaeC7IPbE6AdwzkQS0w7x8hyZaT2gnEMEvFhxpi8oRsBE4zAB3IUnaSO6vEuvKyDhRzk5M8OCXl7/nU6uhq5D1xNfZJdZYmRN8KiRVkXXcPy1ogTl1BVMzyc=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:20:06 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5e) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15 via Frontend
 Transport; Tue, 27 Feb 2024 18:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:20:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 12:20:03 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>
CC: Ivan Lipski <ivlipski@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Tsung-hua Lin <tsung-hua.lin@amd.com>, Chris Chi <moukong.chi@amd.com>,
	"Harry Wentland" <Harry.Wentland@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<rodrigo.siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Add monitor patch for specific eDP
Date: Tue, 27 Feb 2024 11:18:44 -0700
Message-ID: <20240227181854.482773-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 8183b0fa-a49e-462b-b940-08dc37c0b914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RU/uVsPsimDyTNMXvsX69Ax0CIlFAhFkI4l6n01z1XptXUNDiI3xskIBkZLQjtZTGphEqOFvL+ldZBYvKa9reeo0Jj6uxq5v9Z8fskJCx87NfRcJ/iRNEpV/MG8fOudzu5SRH6NlOrOJjC5vAjfvKl9bbbwdpOmB56A+fzA8l361yT4tWifs1Bc0GJO0m2l4eudvmOXAdJIDvHgNFC1mkyFsjXsDusljJmlW1/PVhQ1ccKG/44SkCbC/tC8qGbOty6M8Qkz2tmqFnCTZIdl8kxAPKTvslO9/GOYQF2mJQ2OGKdylc8yalX7Sn+KsOMRWZirlK8+BL8GFYEHl/Q0VaUiiEPmo7Iow4MzGwWDKo/R3bIte8D5HWqBzpbJg8y0M+UZSiVZU3xQvQxcNGYNebzJL2oaKR7pg82iPpq56np8qzQNTytXtj5cG5hu9QQw6jVd+gRc0XIDgdBdVAUWVqcnFGq5mwIWVS+pyLNOFCtmJI5FtLYA1mxIHun2RM2ZQ53Ngb9doP8962JDO4P7pHkWmYTlsn3FEyjbZ0PCE6C89tUJoldns8zOLEIrVCB6URTeetQNGDjuXb98RX1rLI3MpyNc1uPIOHT7iJwfiUpmTfmiKVh701KgSl2IK/ZrmoRBkvdz4Zck+A7hGHJR/SayLCl2gnOQ4+8MPPHEB4ZxvZQPj7Rb3yiuZS/ghEs+3l+xKtMAGeQnvD6tUYAcvP53BzrfYZ+tq1rGx7uCsLzbH+PgYx5ESPkIBz41miJS+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:20:05.7065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8183b0fa-a49e-462b-b940-08dc37c0b914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Some eDP panels's ext caps don't write initial value cause the value of
dpcd_addr(0x317) is random.  It means that sometimes the eDP will
clarify it is OLED, miniLED...etc cause the backlight control interface
is incorrect.

[HOW]
Add a new panel patch to remove sink ext caps(HDR,OLED...etc)

Cc: stable@vger.kernel.org # 6.5.x
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Tsung-hua Lin <tsung-hua.lin@amd.com>
Cc: Chris Chi <moukong.chi@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d9a482908380..764dc3ffd91b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -63,6 +63,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
-- 
2.43.0


