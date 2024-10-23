Return-Path: <stable+bounces-87801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B49ABD84
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 06:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2A284BD0
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6912C475;
	Wed, 23 Oct 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="prjWVxG+"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1C13CABC
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729659251; cv=fail; b=CzYpUPXwgzUr6hgotNhRyRkhDqwwiAr4UHcnbNRINw03cdL5PBKs1XoZKSWk972eKD51AV5/qCy4zLpYJ12aMtAH7frf41OV55+yyvCYf2ZYd9ou1hpC4Y/Oh9XZrK1ShDy4yx0I8fZ69k4XgNogaNWUy6/Hm2aZ8+bm/jwzosQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729659251; c=relaxed/simple;
	bh=+9TBO80QTFfA0LVLrnDG5h3k7iTaEl4YyqV3mtCNboY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KArejUIO0tOpz8KSVrvtYGj2jPo78l39QERw82YcJb1eeHWbYOtSam5M18ZJYyspqJahyiMGe+iBnKbWqsQyOUdw1Jc3Iwpk2KkXJsr9qKj7nNktOA2URuQ/6rl0uBeNDn6J5iJ/SMKr4/i7BRM+aYIDTyqKAiuAx8WwlstY8ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=prjWVxG+; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WErhnjaUKLbVhwU+C3Gevz1fMCFfX7D+7hJfbFEsnLLpWU5diPOF3ST93aoysnhDwYvm2706lWqZitst7xwavJm+L4mhPtOdnVsYzAegM1bDBdui1l4Z1Fz+Q/8k0Y9883JB1WSvRpTX1lmivBt/YaMhWlzTGOCpxDXnskqermRxITEUDMyRntTrwle0svOpQZENmB5YaCFb2t2vSkFF3D9Qpc6Ijhyed44tle7daPMSkki1fIufQZRFDlrg0Q4n6R9fbqH9+PXvCuYQOgvmpCD/MXSb6v46xkqyxIx0Qgnja3a7dU/5lU6P/SvrelXyjGC2IM8Z5Y58/3v0Oo9zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM6dccyTc5VOO3Iyk+WZk9Wt+tHaf3nlqxyCIdYdw9k=;
 b=YqogdjL9yCh8vbRfkgV5HRPWmhNOudqF6xmac7gUdZZz9EkAMSj0uifd0xmb1NpkNeu1O+JHGghaSuYqEx5eBFSr1C4D4rbZbqqDJ/Z3jL9mrWjNQVTczBLQAaX0nhhSsJVY0CSAiuVdO4o/WD4cslgW3zgma3JBkgrCEx97JLo+ZwpvWypsEFdklK0T2XayJfBsSpj2YT8HWFkJmge/o9MnkHR8DocCcNb3SC8+G+wUqvhe8nza40GUYi5ticnRB3Kfc9/UiEV6hfXnyKmBwU7cXLVXgxcCgV8YffWqxS2YX583Mgj68wNc1GQ9featz+1fyvfPqPIs9D/4jToeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM6dccyTc5VOO3Iyk+WZk9Wt+tHaf3nlqxyCIdYdw9k=;
 b=prjWVxG+ngbx4FdU154tkv4mK/ozNCsU3Xfnc4RMNlIKp1nt1VzxpKIrbmKixjJtqz5x+TRn5M4rvBIHtcbkXBBI70QSXXpZ9nFCuWXrDsdltDYZKHlsf6QkVmdc/9DloyzFweQ1butDy4xzBM0Fe+JD7ypve9qtxO8esz6KpYY=
Received: from PH3PEPF000040AE.namprd05.prod.outlook.com (2603:10b6:518:1::59)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 04:54:06 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH3PEPF000040AE.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:03 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:53:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/16] Revert "drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35"
Date: Wed, 23 Oct 2024 12:53:24 +0800
Message-ID: <20241023045336.1557443-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: c1217e47-ec64-4aee-c850-08dcf31eb93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUHDn2a3py0DamZ/t0imrEZ2CoiZKfyZYziJUrMwFx/PvkJTC6XqqQZe+Zmz?=
 =?us-ascii?Q?M2CJ1jucGBVZTme6YVlCHyhJMc7DIr3eOdS2eaWaHtlZ5l5UGu6kTcoPFq1r?=
 =?us-ascii?Q?uthLYR2Qhgpv3itA/wf7i468iVBwnEg2hJa8lW/5mR67ZhSuyZs9snva3W9e?=
 =?us-ascii?Q?b2proHlm5K8oK4eyZrL8tNBeW6VgwpASZop9QHvff9lklZOJiWD+2wlYVRN5?=
 =?us-ascii?Q?/ubsWduJnf37F3yNDGlxoZcuF6FjUZ4TuK1ox9DSQ1ORJdBvBaUj7olX4bKe?=
 =?us-ascii?Q?/E+qgUXMFxnSruayccN0E6xl4/idnN8BkdcTh40+0Vx4l7dF33lOVFVQa2Z0?=
 =?us-ascii?Q?7LTxdp+4FZ2t2HeHxe/MRMJS/k/S12SHL6tLqEmy3MO27lCe8qxnXqg6otqd?=
 =?us-ascii?Q?5sFAq+QplxTvj1uVCsXz6XigGpb4BoysFn0eWL37toa1l+GEGvHP9hiuVLWT?=
 =?us-ascii?Q?NwXTnLQWwgo90NuHHNYKhCG1HvZGh9i9pQ9dZfMtjkV4iaWMOEJ1v/Nff7MN?=
 =?us-ascii?Q?/56MVqmoR5s856OFQaDIHS9RdgSa+9KOzqqyIC4goULhvQ6oTmPEkiJwt7lo?=
 =?us-ascii?Q?+a18kF9HxCEvayZRAONP9k8KdoeYiF1Net3UKZNFfCG8puewYoZw/vMF9l7M?=
 =?us-ascii?Q?tYvaLWVRDQEsVZck3cQI154M9HiKQGdJ/OPc70ED5gEbh48nF9VveIQgy2PX?=
 =?us-ascii?Q?Wyk71PmcOY9XTZQFsBzB26yisSzd61yTLe80H4RiV5Mm7fwohTIZSFSXAWxZ?=
 =?us-ascii?Q?Lcv3u+pMbrmaXd7bl8lyxFdHQBPOLwcywa+tC0S+6cFsQUfH0mH06wGUiJsm?=
 =?us-ascii?Q?n4zIqQUsPejjn9W6MvIvINJL+3ydUUzMePT77tY8BGskJsJ2KMq8GiKIF1hF?=
 =?us-ascii?Q?YCm2DYNgUhS3p6yzgZ2qkpbf23OZDwue5qFZlWHLouAWhltcjASllrJNkzo1?=
 =?us-ascii?Q?1n+LwdxoFh2pj2Pjsi44CAJgYeFGrs6ceWEgFmXKCgbXfk48tPehBtqX481k?=
 =?us-ascii?Q?RqRpQznrfWyyCWI7rTa9bxNcL77bZFJC6E5jOrqfYFNZ0z1VRqrawvIAnSUg?=
 =?us-ascii?Q?Ln2OgpW7GI3Um3ejRBG7sIgGBAQeBhotHsIpscFz53S3u/C6slUBhCh1y2qf?=
 =?us-ascii?Q?0i3R89iE8GDsXlIvNDDyalQ+DYxk+7ZSZbFsMDej6pqiKXsnZEFwncLGfe+3?=
 =?us-ascii?Q?jbqu40pHJB4Do+loKIBDKAFxgJBd4qVcb8Q8Rh1+VV9WxMNEMoEtJT8AQm+7?=
 =?us-ascii?Q?baBac+DZRhJJYdFciAU+o9o+9GvT01R81EVbrjP+H6qsHFciC1hs10Y6grzd?=
 =?us-ascii?Q?4FGi6tmyR+NrYpnMFY+qcPluI5k8PHcbJAFN3Reixgo+I/jZvqmo0a2xZ2vU?=
 =?us-ascii?Q?Lc/+eTAsvq/avNrAVZtD8g6llt1ELCGb0AMeTXjRD5aPpURk2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:06.0542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1217e47-ec64-4aee-c850-08dcf31eb93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

This reverts commit
db88df35a509 ("drm/amd/display: update DML2 policy EnhancedPrefetchScheduleAccelerationFinal DCN35")

[why & how]
The offending commit exposes a hang with lid close/open behavior.
Both issues seem to be related to ODM 2:1 mode switching, so there
is another issue generic to that sequence that needs to be
investigated.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index 11c904ae2958..c4c52173ef22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -303,6 +303,7 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	if (project == dml_project_dcn35 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
+		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
 		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
 		policy->UseOnlyMaxPrefetchModes = 1;
 	}
-- 
2.34.1


