Return-Path: <stable+bounces-227764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM6PAkSHvmkOSQMAu9opvQ
	(envelope-from <stable+bounces-227764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 12:55:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE02E513C
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 12:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8273006107
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF938B145;
	Sat, 21 Mar 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTYMN1tp"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41272E093A
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094137; cv=fail; b=fHGdFbw9NZF33nqhw5OaloSDNrdzp/i/SxSIL/sDyUWBe4Ylie2LDf7d3peIr86Dne0HNVCSBBhace5DKYtIqTKinWFRWsdxy/yg4P5MDZbwN+Qs4UP/woD1sKByGu3VGWVLXQ9LREcvEnOT12jYwC0g5Z4G8zJhATg9YUixQzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094137; c=relaxed/simple;
	bh=9hfjwrA6VR9A3SHt36+90rqeIf8TXh0pJKOCYxo48cI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDUhqEd9hpTK5dbUTvRAXiBOhR8zGUxFyqUdV+0uzRbjHNGQz+MqqLcurdXpSqbSh6Hbrh2Cdk+2z6AhR4EgoyJ9f4nB4wJ/JSkDQ4P4gpWFd58b7Igi3lUtrEVGlVmDmt2jKDLRgeyZMw7pNx1JsjBp48gGP3ZpZz/DFpXp45A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTYMN1tp; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzGBsiFf3xB6n1bRMEQNROtZbOQ0w5wBbMrgmCcxxd7gPv+Fl3zjnTyQAwKsW0e1V5UW2jejPPWl2619+d+roQsWjpg+122tMItsklx3Oq/XVxKDvpWhKe/ottUHBPcc2Ef/wGQEadbZPKa1IU8EFBTxPh/usG4IGJRnovFmb/lEK/NTDzCnMN8+aFeIqilJu4g2ML7Nj0GAF4QJsBX9848xTNTWxgvN3t3Lysxg1pUHZ9CcVvjqCKLPijsJ6MTFj/WraD4kLDz4beHuDe20AQOZwOwmVWmCjfdqCheGouBko+7qVVpKv+y8Q/D99MyuI6UvGqL85adNW8AqULDfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM8FOBmU6i/UAKUOBKqWhGr+WwXePDBJobfoXbh4il0=;
 b=p5Mxjy2SryInM0r0uW9kZmTeobwi6vnTQW+Wt4T2xenRfvKL+53ld8afC+x/PxHqLAdNQrsUvnoDfc0fCmBsQ56lnhOMxmcc2usevhEwN1YkABY9wtXvE+47TGKt4jjLuPdUm9FjcIXSZQdXS1In4ZViwvkq6D3W345K0wsDWAXSjQcc8sKIOvL8mLGREZrGO0Kp1u+ebhBZgRIw+wSuBokDrkgk51iv53qgs2V/cedv8bNFo9VksHrJXwril2+5YokX5Y8trS3CAl3lDKDnPJS8KRQewM4g6JDdIgj//nCPA54eR0AfvjSd07WTpM32kV8G/704z+5IEP94/Xagsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM8FOBmU6i/UAKUOBKqWhGr+WwXePDBJobfoXbh4il0=;
 b=vTYMN1tpdS2hd/EX6Y5fGDK5iFoiF5maGDkXcQnmqUJobb5akXaPvtt8AIld8B2jNV6WVkgeq5jxs68wb4Z45b9EH8N+FqfxGz8jh9XhTuQApr0+OWU0NNIZ9MiqPN25bwfNMDaJWDRE8PYxxojQ/LSZK9+YYyc0xTWWabJrW4U=
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Sat, 21 Mar
 2026 11:55:31 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::42) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Sat,
 21 Mar 2026 11:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 11:55:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 21 Mar 2026 06:55:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Daniel Sa
	<Daniel.Sa@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Roman Li
	<roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()
Date: Sat, 21 Mar 2026 17:25:14 +0530
Message-ID: <20260321115514.2008607-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdcaf1f-bd9d-4316-9991-08de8740c05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XBVlWo5lMrdXS8mtTjfeV4l6I4ABwFixImNTBsHuX5xt4lWJw+FtvU2L6NZldzqUMZAudhdhwnlJlQdsGug4Bei1kdTi18Vs7689Lc7u1XrJzHsNpZ5RfZRk2B+J5LEW+DUKG+acJsE7lmBefJQoIoetXt5DWdf0yLihf0ClJSfVI4kc2rnXDGrABETJylVIlPQuKBYOn8CFwunlzKBTuE5Br2vmamGw1VvB0kRG1zOH7ZhHJMD5RUazeXdZtmkjoUKexseF8fMao767EgtS50LYc4cg/DVGTxyjuhaQMvJXMqE36lVvEOaRZtBI2zcoa8bbK1WZ4Tob5knhb9CY2VIJdR1LASQtiXGinFo0rf95wwUEKLG2cZEOkctn+cc2Vj/vkUeyE9QUaqqCuYsKsqa/3BnWgvp9W7VhDHVHX1BirZJq3YFZF92Kj3+6KiPfYXNeVdPSwwLzzCuT2p9x5+4UNsQFuUqt2ed57k1tODXGqrXqE0SyOQdf4Y7Q3rZEb0I+xIuVfeXNxWHRkayrN3vOvAEP4GJTCjnwiHl9gvrHTygujWjw7ywubc3P0L/haQhV5l6rfgteHsxfPhHm87/gARXRizMWJra+86WGdCN/J+7ye8LbNCpCF6rXwzWjjgI4GQb3WRT1QitEAz+gkDWF0QHJ/W/jswQtjeJ0RzwnLf6IdeCXvS0AiIN0VhwG12oUHWYFQL2/uF8D8zjSMZp7vUFDykQik466nv/wDh7CZVOvNfRMNspR0MJOwrX0/2ZPnYKQrjcTBxjQiDZ1UA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iD6YnK6xppfMqGLuZYkhfeCxyCto+kkciy8HhlWON/O2ScmcPXH5uMnhIkpzu/cOiGX8Yl/s4EfYsFOJJpPlzpTMEa+Bxs2qde5g7VyY9CRA5TI5hzJSuf7/fYcjo124nimgTnh8FZVvEpHhCqZxeJLOPUZfaY6x6a7NIi5mkhckfyu7FdPYOS7jDFqXmgWydyeTcCQFiRbYoczbiPUIa15Q0zHZdGPZS7GE4ti5Fp0Mc6FK++5DCZ1hg5Nj9ZlS7Cowm7bY1Sup4JvZzpo+xoAbPwbf70OjzH7IsBqAQZyG9hK25SYHa3NGpHrodtcOwfPRTIdPdBRZppxJsIWZfserbNkZMbM/EIJwhxqhK2b1zPOk4hp2WlfcwP+nZlTwFgWlSkWurWLG786LjT/JPGxY+GsRpdveZ/sJn3K7fyrUjiE11uOTPutEidNbY596
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 11:55:30.7851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdcaf1f-bd9d-4316-9991-08de8740c05e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227764-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivasan.shanmugam@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 97DE02E513C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dcn401_init_hw() assumes that update_bw_bounding_box() is valid when
entering the update path. However, the existing condition:

  ((!fams2_enable && update_bw_bounding_box) || freq_changed)

does not guarantee this, as the freq_changed branch can evaluate to true
independently of the callback pointer.

This can result in calling update_bw_bounding_box() when it is NULL.

Fix this by separating the update condition from the pointer checks and
ensuring the callback, dc->clk_mgr, and bw_params are validated before
use.

Fixes the below:
../dc/hwss/dcn401/dcn401_hwseq.c:367 dcn401_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_bounding_box' could be null (see line 362)

Fixes: ca0fb243c3bb ("drm/amd/display: Underflow Seen on DCN401 eGPU")
Cc: stable@vger.kernel.org
Cc: Daniel Sa <Daniel.Sa@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a72284c3fa1c..53d70db372a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -143,6 +143,7 @@ void dcn401_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
+	bool dchub_ref_freq_changed;
 	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
@@ -357,14 +358,18 @@ void dcn401_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+
+		/* sw and fw FAMS versions must match for support */
 		dc->debug.fams2_config.bits.enable &=
-				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
-		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
-			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
+			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
+		dchub_ref_freq_changed =
+			res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq;
+		if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
+		    dc->res_pool->funcs->update_bw_bounding_box &&
+		    dc->clk_mgr && dc->clk_mgr->bw_params) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
-			if (dc->clk_mgr)
-				dc->res_pool->funcs->update_bw_bounding_box(dc,
-									    dc->clk_mgr->bw_params);
+			dc->res_pool->funcs->update_bw_bounding_box(dc,
+								    dc->clk_mgr->bw_params);
 		}
 	}
 }
-- 
2.34.1


