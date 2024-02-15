Return-Path: <stable+bounces-20272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBD8563E1
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824FCB24E3F
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBBF12DDB6;
	Thu, 15 Feb 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z8fBaZPo"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6D12BF3D
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001895; cv=fail; b=Dmj2ghk24EtyEh36oHL0ywhaZ5ifwMiLJnbw3R4SdhE1zVgYrERKsTmFB99KOGZw6n4PwbFBBQQDV188+MSMiu5kfOFz25nDzu29H1jhRXHZtFO0aZMSXaYAQCVT8047QWAd9722qX2cswhJF+MJjhBWD35zovsmYfyz4BzMoS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001895; c=relaxed/simple;
	bh=ijqiJaCXO2ObCoddifvVxFcOsXUFr/z8XN7uArP4Ycw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMFXoxvvGvpIqaOCmpluBpStwx1YqjWSNPhbyRie9h1Wg04s3jbF+JoUB1QduGAC54fOE2uuEbrioxci6V4yqyxKs/SbLoaS+NPuejrjCqnETb6FaNdccg2NIy9//gwP9YQtDMo+qmydUgtJtTaeJEs2DDZnDik3A9FvHUk+9SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z8fBaZPo; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQYR21kfMTxCps64BM7fqt2JTFAzpYaUNnASKhsdmeK/M2CZKscnKH+4PlqFWHOGbG+a4XyWqp3fuS9x5D8iWgHuaevmwLX4MrhKrdU66wLpzSaEh+fZ1RIHICoLy5hMhxlQvS0ocM3v+Zf9iQfyGfgdckV7sC6eyVykF6em5A0zIfNPaKuT9n6jD7mWtAxZdPRXb6IU2j9d/i6msaNyiWZwH2+031yLvfaobakjIoDHbHzwBh5C6YL6m2hb7Ni8XeymtW/VCeM/+bC+FR1MTDB0p3jaMClaoF++4TRGxYxbVlyu6CPTFsB4wJ8qHHK6PIER3LOrT/lSOL+wAHXtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/xMMthJao8Gd8OCYGQTZHZrmXuL0LNzVRZYe5S3kGM=;
 b=h5jmt61b3tit9yInj0DQbmlmrHJMINWaLleBe8R7VND9NEyJxitqkMkKKevSH5dDx1/C9ylmoQVQpvt/e1et3HH4Rr/9rmxZjDr2nEeJWinTk8cP5Cy1SnYvaEuiHzg0O0yhLg6ePC9ZaAsGpMygMJdhAYVQfOVKkadII/UhfLY6lq+PQ2fOLVBQiEUEs5Nd/CEKlQTjqCeUatHr+o70awer3nv7mN2Hqc5km7KDFjkUf3BPzyuUgeQ2tm0N1iSHDZlaVCZ4/qwtPK06gdbcWsMH6a92uUi0QIwQ/giB9WIBk31uzzitBZ2sSs2spSmVKWhUU1yiX8Pbxh6rA02KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/xMMthJao8Gd8OCYGQTZHZrmXuL0LNzVRZYe5S3kGM=;
 b=Z8fBaZPoO1mwDN7KMquOUv/rfeNz0m3RWpzm+Ka14+9XoFGKLjxIAgWEK4MMlKkTs715VmDc+Ft1t40d5pPISO/voG5UGeIVqpnei9w9dQZnmZC4lM8atDyd8N0c7hgFg1+zcst9cXSpMsB1Fo8m94G38YNuQWwmSAC5xHPBDX0=
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 12:58:09 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::92) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 12:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 12:58:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 06:58:06 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu/display: Address kdoc for 'is_psr_su' in 'fill_dc_dirty_rects'
Date: Thu, 15 Feb 2024 18:27:54 +0530
Message-ID: <20240215125754.2333021-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: f328b3c7-3327-46fe-b5df-08dc2e25c293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZvxewD56keVjQ/1S+GeX1emcG903KyiPYbhE3bbn0nQ6KfjOs56XAbWnMO2Y64w+KT5u6HxNnLs7sSF4RR/gmw6Tig2EJHdsbz7hrfKvTbWIshWayTcYOju27I5KEGR3dmBLMJpqRj4dbJVi4W3LG9TywRztaBvht0zFNkfqlVl9UzA2F71iynZkr86ZBShNB8wJ4vd89TCP0BAXzw4bA1rzJc6xZFFrkGoytVx4yc8a8gCePvMnPMesdMnsZMS61TKnPm7v7hm2hvnVzmX38DEWml55N88vJemr9dbah3ixGiKQnh3fP0p89qqiLoFxQlNPe3kA6IHEsJ0Zt5PoBRp/h3yfLWeZ7P9ArWqEPVpXaZE3VVZZx5l7/SBX059eCHX+ixtcX9p6hvgK6D/8ZP9JTe5EHqAy64tSf2T1XsxDLNSjuQCpvSlsZhdNp/DsRvBNcm3z8WR8ChZczp/s6EAuKdxc1PvX8qJ6EnZ0NmHHwR10kQnYgJ+XsvbOQ+GXYOr0Yv/bRyLay2FDZRFVj7G0Fly1T/5kbZUJgkGdOnkvxrrY3U5F8YCP8h7jaGJsI4yGLJQRGBry8bhsri8JlmrFUglDmKm04PuKbIupne5AhYrWLO7W4tQW4jNA1b8Gnu5NSnCzPCGe1MZgGmPzLNWxEfYnu6x57zlMJMcQ30M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230273577357003)(230922051799003)(64100799003)(451199024)(36860700004)(1800799012)(186009)(82310400011)(40470700004)(46966006)(2906002)(6666004)(70586007)(7696005)(36756003)(26005)(478600001)(2616005)(82740400003)(356005)(81166007)(426003)(336012)(1076003)(16526019)(83380400001)(86362001)(8676002)(8936002)(70206006)(4326008)(5660300002)(44832011)(6636002)(54906003)(316002)(110136005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:58:09.2583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f328b3c7-3327-46fe-b5df-08dc2e25c293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

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
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b9ac3d2f8029..1b51f7fb48ea 100644
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


