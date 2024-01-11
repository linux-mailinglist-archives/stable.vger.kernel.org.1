Return-Path: <stable+bounces-10530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D2982B462
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E82872E6
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93852F6A;
	Thu, 11 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQ/Do+bf"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBB4F8AB
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjM4Z6BsAUQbYES4OLiAxe1S8/M7ZfsfsH3LjeMa/tlpTcjcqX0O64U3sdWzyZl0MfLgqVqVzki3g33YDI8NtPvOKkbTzCEtQPntU02SAyLYVbjccGGzVFXPh/ZJqgAIkxlj6uA6rGU1JMIM4m4+oMcg2kWRjvninX50KvNYDX8XLJFzzDfh4KjLB4DmCBxw4YRU7KBCQ0WJqMuNxYHuIs4ykBIRpXSuVlnzfvuR55hm1oindCUQpkgCG86GBWqzp8U2nuFCE2n971Y4R6n/tBwPQHFH817WCFVTZPf7Yy3Rd8YOYcvBkrvjErpDd5jyFMSXpmZ6BHNtoUJbesCmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3Ys5FVwyy8G3gtU240yxyJ3Jai5DfeF0Jb4Uf4Wwfg=;
 b=exuX4EfgnliC/BFVxueqYWyAmsgbM1XcW6DyVOfVOWu11AZC3ni3/vvY4jOpgxhI/zkg32yHFmXptItdJMKrTWp3WHQp2aQ4JsgihLSLCukxrluatTyJQJI2IEzy1S0abbqu2lmJMNu43fOHnLyW6kURICZyhl+dXbousKG5YVgrJ2USu/CrOU6urWccYolb/9+/dgUInlEIN9jAs8xAp6afwcZ/161mzxyA0IeZfBJSFwIotT6k21mJe+91Go6HfUSaFo+amIjTtjsXFndgT3KX9eK8Ygwwpx9xn9u7WAXBy+CC+E5//luK00HjPx7sRfqzNyDykXtiK+1lJ32yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3Ys5FVwyy8G3gtU240yxyJ3Jai5DfeF0Jb4Uf4Wwfg=;
 b=JQ/Do+bfmXgqh7UHpspND2o9+3xFuQ+1L41TSdC7aOk9m6ifUNkqqrWchzZrFS67XLZYiNDXnWtNEPEi+63bLbkTJTC8kpLLmsbYIIcaCX2KAuJ2enam/WXHNUG0xyOBMel/AbuOwzUQO7Zx/6ZT+AgKAyJ8SqlzrUelqgRW/+8=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 11 Jan
 2024 17:57:39 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::44) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 17:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Thu, 11 Jan 2024 17:57:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 11 Jan 2024 11:57:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Qingqing Zhuo
	<qingqing.zhuo@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'
Date: Thu, 11 Jan 2024 23:27:23 +0530
Message-ID: <20240111175723.2807563-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b64f43-6ce2-429b-11bc-08dc12cecd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hv7vPGeZ887VZtt9ju79OIFDsGaLPobgIm97qmrnW58AnGTOeODMQOTflPsiOcWyEJ4Ei9Y0x/oOUEVrlFNZZXRU0gUNm5SmMosRpxxxsrTrJ/eIOWJ5G51pVjtl9NSTPhwo+84+Z22rkDoktzTLKfjucK8bPmOftoWoLfaLlMMqzoCsaJnELvE5NMgzIRz93Eqx0W62qmot5qWo+qQAsK26srDhow9tbI1L0ZogYOzjrd8H5YFkL/ZmqczXhY59miFc6qvBR4FdOl4CWiohTMJ9vmzvqYFlRIsMvWhsZEzi4db4sgu89ZQTq6GPoidcxyUfC3KNy7LLddEkE4Qj9GXjVaP5XPweX5iOg6r7D8AK3D4dOSWk26HL6FWyuy45wkEcjFGadpBk6BIaqwu6SnLiKOHZiyvOYSc24f0rWXv6dWCH5D98NfQGvuiAPRsPdT4cSMIvywCr9HDGUke71o8gyeBrbn31JJVJ4t6ocelFLnX/wXBOraaXD2or/7XFTvnTFua0UCk45rwIeeNpuYqZg4N8zgrXxSD6WNdB6VEm9Qu+IbekHW7JMUflaQxfSZz66AcMJXZc3nfSGl9q6AMJEnl+QiDp5wY40erqeI/H56mNzMtIUibDaiSPX5GNSF/8RTukWdHrY7rJU69SN//QlzkrgnTCaM1aqv44eE7+E3jU6kwJaZoomf/+R+W1VeOpQH9cfH6hE+oI8bhihUGpP/sDDp+QhGtE0aCY7Nc0f3uw3D5bsrKKwVAtkrFAcf5nDNkgo7Dd0gsSlOtdjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(36756003)(1076003)(26005)(4326008)(2616005)(16526019)(336012)(426003)(44832011)(7696005)(8676002)(8936002)(40480700001)(47076005)(36860700001)(83380400001)(5660300002)(2906002)(478600001)(54906003)(316002)(6636002)(70206006)(70586007)(6666004)(110136005)(41300700001)(86362001)(82740400003)(40460700003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:57:39.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b64f43-6ce2-429b-11bc-08dc12cecd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190

In link_set_dsc_pps_packet(), 'struct display_stream_compressor *dsc'
was dereferenced in a DC_LOGGER_INIT(dsc->ctx->logger); before the 'dsc'
NULL pointer check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:905 link_set_dsc_pps_packet() warn: variable dereferenced before check 'dsc' (see line 903)

Cc: stable@vger.kernel.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Corrected the logic when !pipe_ctx->stream->timing.flags.DSC is true,
   still skipping the !dsc NULL check

 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 3de148004c06..d084ac0d30b2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -900,11 +900,15 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	DC_LOGGER_INIT(dsc->ctx->logger);
 
-	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
+	if (!pipe_ctx->stream->timing.flags.DSC)
+		return false;
+
+	if(!dsc)
 		return false;
 
+	DC_LOGGER_INIT(dsc->ctx->logger);
+
 	if (enable) {
 		struct dsc_config dsc_cfg;
 		uint8_t dsc_packed_pps[128];
-- 
2.34.1


