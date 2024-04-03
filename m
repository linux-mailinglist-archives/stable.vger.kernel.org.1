Return-Path: <stable+bounces-35868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F506897939
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82C828797E
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF51553A1;
	Wed,  3 Apr 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hnb9f02I"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA115539B
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173898; cv=fail; b=UYO6UoKiV3RkC/VRHOVXJaH7CZSTiJ5wTDf4lgekZ2alzT8XuhOvqyTFP0bsY18DZqJlJ06dCchFyj0u347dnte5dxgTyDFTcdg5tHDqNLJArgrAQgdQre5R61tvgE/Lh5qveLA0kzvje45XY2Ran07xGRlhytIPUxGv+S8Z5PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173898; c=relaxed/simple;
	bh=IEDJCG/tAI93293STrVVma16Qr+9RFUMUksTgY9pdG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlVGWCjiTDNQJGIqvrjv9i7PrQ6xNt4nh18nFbrkQTthvrb7Vwqh55XjjLdg53y4D+hKGCDL+RIPGUGPpJ7keW38GAX236tiszLyLYmJFN+O2HVmphicgnx0ZuFmo5+UdZN/IJEacN88eNcHaUKLs0cXt3xG/MiirbDV/1K0yZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hnb9f02I; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4cNssEv1gifJxUbkUSuM7iHeBLY5rC9nLbdeXjq2a2hID9bYbbyAhufLKTEfSCqO44400haNNBbrkqQUEVRe29Xz2/zesvtaFnkO3hV8+D9pmxlO2J7vgsQuj8NzYUpt8f9xS8z62ViXEmEao+BmDHdUbwZN74M+dJLat71rPma0zO83wblrmur/5pCbRwE/fxRiO3wmegDKN7bqAM5vOh393tzbEH5a7kPE5CGNXfEokbqnuQ4DDNvYovCPjtpvRsq2QgZNaKyGClrWMJD10Oc0gELoJPsAhFLR9vSiU2TYiTxGUQ7VXQmNT5E5WmB1DRRKAwb34n/hYtXMaYolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKC2M6+NJhGWuQnOJnwoolEw9Do6fSGtyz2WTMt8fDQ=;
 b=FMQvGznMNlx28CvrRpmqMo0Hz01GIIXD8zISP0rcKaIdVmaXPE09U3nlJsbAtYbmFp940WcHaAVwAX3cFIK9qcQ9xcAu6pY3BZ1vF161tSbo+8kBgWzTxm1H9nprB3VrzaqCqxiwgmT4UrOD1LLDYn9ZBDxoyCO0UjqZBJrOfR3TxEumrBFQferS7EekN1nSYLS7P3++Qtqecp14S1MbsZFPgxKIBEB7I6YbDvTFq8A8ZoOYa4WUP56RelXAC7oQQV2+ptuOe4UKLpjvVkoi/dE4nrH/lQaMukBgEzYcQSJ1bK6R+R1JI0OHerA1CcRGPsCECqq1LPb9rLJ8XQKIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKC2M6+NJhGWuQnOJnwoolEw9Do6fSGtyz2WTMt8fDQ=;
 b=Hnb9f02IcQFen7ClKAE73VL6uyIYt9HvtjLH287e2lWIQ4tHFFc/iU1jfMs2jPvmmWKFNJzquKRFnFmtfHWeL0jJTmYQ1aLPW5NQpO873Tzk8oy80Pp0y3u/m6cSrRziMtvG+jFVHH5VEllgKH1PSTNQuNUjjL00bbTqhgacYQs=
Received: from CH2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:610:60::11)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:33 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::26) by CH2PR14CA0001.outlook.office365.com
 (2603:10b6:610:60::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:33 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
	<stable@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, "Hamza
 Mahfooz" <hamza.mahfooz@amd.com>
Subject: [PATCH 02/28] drm/amd/display: Return max resolution supported by DWB
Date: Wed, 3 Apr 2024 15:48:52 -0400
Message-ID: <20240403195116.25221-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 27affc6a-7030-4c49-5c2c-08dc541776b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPJtTy+rflV7HVp7QrpALyVLePvg+loHL8hmwa3b8ajhrQqejAohijFKQbjPMIEnzZGNn84lrq/wDL4tsQBrr2wPfuNTwqqZe6utSaSbUM0ypVQkKeWPADzd/BgW4GK6YSFq2eZ+froR4xRDifRkaEsjznIYyygtBUFYgMDmcJukNA4yKZIVnbCx95soU+9k3NwER7nFzJaXaN6zjLVZHny3bto8+arZ7IHX4q5Dgh271D+ZhVqiPDF1pIFI7GsinAUhvFcVWtuEX7GV1YCKvdPptlN5QvC3zeocjfctq5jgCNy2RDCQB24PJMYZ3NyiUCWo7oecaQ/LEXC9l3ilOLl90tXWRdjelEeiNelcC0wQh0tr6c5N5x1MtcqqJcPJ8zPaEzkrojF7Ly2oIDO6GGiK69DNuhuHufdG7vjjQBnfxsT6kJvETMVf5OvB1Kk10V0BzAZTMEvGzdbDuGB3BpZeChppHX8Ko4DWrilwAoVBgbGnpFRXKS1S4fUr+LjGcGZtIpKJP+L51XIzdfD06+BoSzA9vLnp5EsozExn7oNVjvUqsBDmw9XWg6MSKmfDfHmg0bF5fTeKNwWvQ9wx5neFvr2q+FBXpXb2bCPrfnlsP1HT6GlusFiRuLgYcSLyqFb60qG63RToPHexmrEs/30tKj1GAy6V+sESqhBLsH0bWW1ymqXZRx5p3pRCFyQjkHHY3EMfRI0BSjJWzjUQdHWft2x6NMQ2weiCYseVI9Kb4+8e7DnedFf2gA2HJ4+t
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:33.1368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27affc6a-7030-4c49-5c2c-08dc541776b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

From: Alex Hung <alex.hung@amd.com>

mode_config's max width x height is 4096x2160 and is higher than DWB's
max resolution 3840x2160 which is returned instead.

Cc: stable@vger.kernel.org
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 16e72d623630..08c494a7a21b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -76,10 +76,8 @@ static int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 
 static int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
 {
-	struct drm_device *dev = connector->dev;
-
-	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
-				    dev->mode_config.max_height);
+	/* Maximum resolution supported by DWB */
+	return drm_add_modes_noedid(connector, 3840, 2160);
 }
 
 static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
-- 
2.44.0


