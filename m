Return-Path: <stable+bounces-23296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96D85F278
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20E1B25771
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36617BA2;
	Thu, 22 Feb 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V57Ymmam"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A52A47
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589292; cv=fail; b=snZiov2yTmZVJv1uHwPRSnl5VZF1+P8StFWcQclb+qLTvl+3TRqOJ92/qtzEDRI5D6qsdktZZ7f61gc0z1Mg7KvVr49VHb5b8/wngEngBUdHLODZ1DwH2fVnVYr6KnWLSbp9RuUQLjIMwEQym4E3C2fR/CDkX2ns4aSXRn+S6rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589292; c=relaxed/simple;
	bh=UzgMzQ9MpP7tu6hrPjmpyHdg1rdYQpdwtYTpKycB9/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBcjVzbVPQ79u1DZ09u/R0AdoNF+A3TxsnlN/NOZN3viR5axVhnfxMXY4d1+8lYIH0DkNyKd2pT1sPlwLLr6HtkYGhKi/JRMqxyy8AXsuC52OErnegDx3REXpSF2rAUiDJMTeuIDpNPhT28FAa0n82H4IAOMFPpQ7xwwbIU8+Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V57Ymmam; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyWD+nRHpHNXTW9MDFSuTimeG1V4uuVUr+Nk/EBu0dXMPWARmi0DX/n/L+bQ19GW2GpBTtpFjRl0v1yd2efDQU5QfsW6QbO34MzIUz2eJqa2kowvikiZsbpGOfmyK/1OA+vNeifwMsGzBbA646qTY02ZrUIXKZSHTcwEyFyrzP8y6Db5PTN2aKx8JOqlpFGzoaeSH8qlQVNBLB7tcV12DSe61TnCn/2RPL1S1JTdmmxWHyXwlbLzfWrRXxUwFN/Zj/jFpxNRpXFM/wAd/v6qS73vlOVL3srXgibu2XOVoFKQIVAItwbgIAIjm2ovkdqBaTi/AOQ9Su2ZkYyK1ZwjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg5HlhxEHXKDB/eE3FIOxcYFKOLW+847Rq6NbCM4IaM=;
 b=fnQf3BfpslE2EXgsWsrDehYTc+LOyXqdnueRqThVcefmiTLrwJI7LFdMJ+uMcxPyBsPTFNsruOBcT3qxAg7rJGTlTaKVDcBOX1cpA9NNtCJ3RZakzvTyG63JtvPqZKDnik4wEFhNCHp+ApizAAKm68IWe72mF/M81wCFl0Ey45nO/rgcPGcdsOUz1+LcU50RLBe29/O2n1+FQoR3TmL3GdMqNE7a7OmqHBVncNeU3saO33eUax8s5UJS7reyfdJY+1Dl1aFaZSBlO/VqVyJAbmQ/5gQw/4GUFlm9i9UCCoWuy/sN4E0KpqngE0+mEvBNZGGZVuATKNUWwlJegl1hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg5HlhxEHXKDB/eE3FIOxcYFKOLW+847Rq6NbCM4IaM=;
 b=V57Ymmamsbyd1hPxn0XWGxpZ4BARsOuwdgIMR4ul9ZNzSc6z0CtzVkNRU00ZV+lGy7qfLIFiWskpIg0sIQjREMM9lP/4RFp5Vk2tQJKioDpcOdxl/85PIVGyGphwJ8yrWf6ojtts068fmvtkEH1pu+IcGmeDHejYJY7D9OYgIqE=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Thu, 22 Feb
 2024 08:08:07 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::86) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 08:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 08:08:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 02:08:04 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Sunil Khatri <sunil.khatri@amd.com>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>
CC: <stable@vger.kernel.org>, Hamza Mahfooz <hamza.mahfooz@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Rodrigo Siqueira
	<Rodrigo.Siqueira@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/display: Address kdoc for 'is_psr_su' in 'fill_dc_dirty_rects'
Date: Thu, 22 Feb 2024 13:37:46 +0530
Message-ID: <20240222080746.732628-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222080746.732628-1-srinivasan.shanmugam@amd.com>
References: <20240222080746.732628-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1ebf9e-1c5b-48c0-d88a-08dc337d66f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mgz/SjO26bwvrmj92PfjyC2q41GW8s9e5FrmkpWnFv1B3mHZ8/VRdonhK4LgBCa1PnIus+N8i/s4z96VJlmwT64Zwbs4IENixXiz8eBlj8fM5g77M7ncYtdWtX9tQj76lh2m9ICD6zxKmJ2wxNK9inOnIGntC1DHXjpGx6VDR2wy9l07m5LS93hqS8+JwMWg//JUqCzQG095oWQF0bgFaU6X1yGONCVktuH+3iHhB5ctPWtDdMGkXjqWvJveVEr98setzi3d1Fl11CoOn4gQ8ss66eqvXgIsK9N8x5+xCN7vFfFtohMiaePOAxNd0emugGME38BzVsxGpdp12Yda3GpEQw+r41cWnpxLqA9OfkaLuFbOZ0Qbp3DGMPGJPHBagd7UQ/GuFsc7zAKKwsf/lXnD1/i7kO9nr8sMtsWecXNWyH+3wNhJR87nLlK0wxWPPojCznL6BHgQnpBX0hGLc9HN39VhRxncnVXrMHqvY+5oR1MMLEftGhfytX1qGIvlww51AM1035tgPNFi8yIGg/4D7VBvC7PUK6YlppyQStZ99mjD9FjxH58DzxqmiZ+8ttZgA6MBkYjFJa2Q8ZOEfWFegFjrc6I37WvnDaThVdbQWjTevCzj/BFQ487Gab+OuP0iQREQQXtlDJmLu/7HXZLbmoQm/3PDQjSx2bryVU4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:08:07.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1ebf9e-1c5b-48c0-d88a-08dc337d66f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

The is_psr_su parameter is a boolean flag indicating whether the Panel
Self Refresh Selective Update (PSR SU) feature is enabled which is a
power-saving feature that allows only the updated regions of the screen
to be refreshed, reducing the amount of data that needs to be sent to
the display.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5257: warning: Function parameter or member 'is_psr_su' not described in 'fill_dc_dirty_rects'

Fixes: 13d6b0812e58 ("drm/amdgpu: make damage clips support configurable")
Cc: stable@vger.kernel.org
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ed4873060da7..379836383ea9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5234,6 +5234,10 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
  * @new_plane_state: New state of @plane
  * @crtc_state: New state of CRTC connected to the @plane
  * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
+ * @is_psr_su: Flag indicating whether Panel Self Refresh Selective Update (PSR SU) is enabled.
+ *             If PSR SU is enabled and damage clips are available, only the regions of the screen
+ *             that have changed will be updated. If PSR SU is not enabled,
+ *             or if damage clips are not available, the entire screen will be updated.
  * @dirty_regions_changed: dirty regions changed
  *
  * For PSR SU, DC informs the DMUB uController of dirty rectangle regions
-- 
2.34.1


