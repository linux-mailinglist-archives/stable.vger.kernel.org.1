Return-Path: <stable+bounces-235426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CtsBAXA12mdSQgAu9opvQ
	(envelope-from <stable+bounces-235426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:04:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A63CC5CF
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6CCC3006B77
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5653BADAB;
	Thu,  9 Apr 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xK1lL8Wj"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847A346E6C
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747071; cv=fail; b=UCXfY0PUIPKyg3kUZKvJQVwQfS8eGsen94y9P2B4+ynWzneH5B0L8s/TVxO73pFID/q9lHDeAOWDOP/UgCL4jxvOOow7J8VCFXzxZvHbIFadsnnUImAIzYdFxmfGmcDqSk6zqj0G/mhUxL7VaGujUdXSweD5mT4dDtMGd3WyH1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747071; c=relaxed/simple;
	bh=lv3+4N4IhV8jWcfGLr+ZSePROiQx0k82F55Ck283ruE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRiW3P6kNcG5ODaEcTrcrD6/12QPaXj4cvICaxtH1qNrClb5KWwi/PU4PyjZd0bxOPal5jSv9lT+ToW3mNP8Ekat5XmdVzqMQfnb7nXuv78Boj7qf6t9/g+lIMfxXOE8thyahDvpVa87L5NksZBN72qkkWwshlNNZXO+XsIdvZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xK1lL8Wj; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSScazgzSeXwmNlww/qZxIRWhG4oJVCSbQzT4fn2XPf5psi3cDqrew1s4ikableCnPCiv59Ql5D65TJzijFx1aR5AEjDQYh5exWt5exQ41+OVR0dQHg8do6M92fpkdny+L8NuN4UaQ/wgEndgyte41ykOYtp3HACHEbFywB0lHD66ndz0eC4qABV4uHArVtPPu31zACJbZ4VcREOJW1stuljJuC0o9NqJFcucCRrzNWuxT0LSIUrTUYugFpHYQyjfIU9Ig1UFm1D2I5wetpYLUDmd1ryXdmys3JZ8tRepO0wEq8ZgNEgwoSSSEHGcHDeN+tfbIAZq54acD63m3rfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLPWFCtcO8oAN8Kn1bgv2s50En4GYZLQUZjXWv3u2H4=;
 b=aIfJjq8ZEN4ZsACeSohmDDgvcZi8LgKRmBJ0KlS3liBOPHdxkctYE1QCl9xt3YcprzzQE7YqKZV6wi/EC9BsTGz350cF4BR509EwXNJY8kDNCXxhJaYCL/m/lf8pPksSHFpEj2r59hefHaoDLbbYFxfGgGFJEB0nE/kAshsHQaSRimtbFWNORgIpRkdG+N9sT7yelmcqcHOG+eNkslLElfYEGaMNO+AnPtZK9UDAdm/alOKD9wOT4kIWQGjKwm6Puw6csHqHMt9PYnv3Ef0ZQqBjri78tDTcwknYBygVytaKJZTOvEtxkxqkK3a2/ku37/z00+LHqkNS2jkQ8YOVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLPWFCtcO8oAN8Kn1bgv2s50En4GYZLQUZjXWv3u2H4=;
 b=xK1lL8WjStSYzBte9AUBwPZsYsDsF/k83nHn48Rw2BXYjC8H5pkMZKmyNpknl8kkKXIushjNopUj+GvNSkgyGBkH5HAysTbbOQKFJSW9jFzu/NqXJ3/1eAkTBViYMjpdlQPQlujHNC+hCFjg5FDoUDkvScUowNVc49Pybu6rMQs=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 15:04:21 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a7) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 15:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:16 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Dillon Varone
	<dillon.varone@amd.com>
Subject: [PATCH 3/6] drm/amd/display: fix math_mod() using arg1 instead of arg2
Date: Thu, 9 Apr 2026 11:03:11 -0400
Message-ID: <20260409150413.34779-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb01720-b42d-41fe-d687-08de964947f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TNszhk14xTbaAOWeVv3ZYamR7q+NsSWv8V0Y4LhK6X7n+DW+qzohb9OoDM+NhyDo3w7DOi/WnWgtNtjBj38j8QQ9Vj7DJSwVLCEEmoJ/rFKY8CPFx6v1uc3sc0l7/B81aJ8AyiDe3gHuxs5/Pymnam+wut3LZM2THJ3gezsUrcZeYD2dmQ3Sf6qOdQxdjI6Tor9UxbOgPg4fVcf48sT9BOYD6faX2dCIrAnunxV1wWN21/Ts+m7u98VL0XmU0weXhyD32hci+Mjwl9Y9hKOz/g954sxb4myAapO2jC5NrcDhv6IgEXzxFFh0FHgEOgwo0kk2n0bYbDlhg69ssfN0wq4h3rMgNwnWUgayQSFwmLHqYxqb4367bAKTuuhRAjboTSGOXPYaSJuG2d1AjxAWppiJLSS2UKAPblTmruqqkL9CC3LBuYELC0R9i38frfVT4RMMx7FqypWAWMJQWs4dkK5a0MR2Sr6L/djP88T9sXHX4vEuDbnyX4hDM3AuzFoxMctxWqvMgH3eAxfbdh4/jeFjfDRJPhr/8z1f9oY3Z9oY3IGA/yjfYp1zN03qDSH1fwIlzCgWtWA0wTfYDw621+lz2poNQon1u3xM3Mse87H+wI4w5VJSnNgj/hCTl2rHVzWvBJH3LK3Om4dkZuxF50bxXVw7Ps0uk8NWmaIWelKrkkFsO3JEdXCxryOn3gQIsZb3g4tENDReOW2xXLxhmtMMeD0iOLbDPtwsaVAFPKn78K7pUSTXx46CBZCWins0duZSXJjmc3xtYuPR8/nuvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KWEiBKqgfNUGPYWA3z4ftnYzx5KNa9J1mLlf5bV5ve5gVwNoUHrFA0m94r/wIaPkKurzZI25eR2lDzKMEPEP1yHnl3iL2GVTSOZ+ooUvdXGdIordsXqirpor+HfM0LZDO8TWFKfBNWj0WaVqeAi9JkGpcUeL8cypoe0aCK2xQFG1QS73uoRPfSiaGr16/RR0AJDhW/0C/ANupv1/qt/GILNPOC6CLs8x6gZXX4vJy7p3h5gIVORVlLELeqHVpRx6JQmf89w78u3ExtWkvJC6q9aAcdNgmBN7ivGHkCSV0ZbJE/abmd6ysozRN66PruG49PnbKHnZ3inxba3aUaBznPQFn7YAfIi+u8GHRGZB3cu5Rb5oTZqFVbx3re6qvAAFswPpju80/wu1QpEo0bhCGb09DpmQ8KbHrJSvNT0t/sXsvWi+qkPkU2vp5Z+NoCAJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:21.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb01720-b42d-41fe-d687-08de964947f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235426-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NEQ_ENVFROM(0.00)[aurabindo.pillai@amd.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 811A63CC5CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
math_mod() multiplied by arg1 instead of arg2, returning a wrong
result for any non-trivial modulo operation.

[How]
Replace arg1 with arg2 in the subtraction term to correctly
implement fmod(arg1, arg2).

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
index e17b5ceba447..dc5bc649f3ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
@@ -23,7 +23,7 @@ double math_mod(const double arg1, const double arg2)
 		return arg2;
 	if (isNaN(arg2))
 		return arg1;
-	return arg1 - arg1 * ((int)(arg1 / arg2));
+	return arg1 - arg2 * ((int)(arg1 / arg2));
 }
 
 double math_min2(const double arg1, const double arg2)
-- 
2.53.0


