Return-Path: <stable+bounces-240363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FrhL0D56GnLSQIAu9opvQ
	(envelope-from <stable+bounces-240363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:37:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAB448C29
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21190303AA8D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20553612EE;
	Wed, 22 Apr 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1aSfU/N"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2837CD28
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875451; cv=fail; b=bpbIaLBAaLzMt2tXL8sTw9/hIGyGueCqz38/cmJNLac2njyvjCvW4hXXRVK4YqBKfbEfMmQpdganYVzcCHX+rdXG92+lDcHy+g+up7hG3eMOY6ft2SmNO8ILxIdsA2Umtc8N0sgILd2c2gDtcmjH0B0ibrdnozjpotVHE28Jl8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875451; c=relaxed/simple;
	bh=GEHZ/nCH9XfNugaWvgc1tm74FvV6VL4RsuuiaFF1bcU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lHV6Huhcmy0camTUWWMkghqJ9I+g3qQ7+15z4vudxPxRkstHJLFgfojoGO0WQWA6tSNPznBpJWqMoOPBmtwpZcnF7RMjNhovbXnviXLan+/0SWB+RqHmT0ZEhY7gqxljwCbOKEj9hJX0jNq/bduHHc5lvBBZUr1FTZggIe+QrwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1aSfU/N; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzJQmGZ6YuRp7r8VwrcnD0uMTjmRArU860OMTyNWZnDCzLMhzSi0COBGHNlNgFjFUTgSlZTlT8F1PJ1B1jvCNL17puyL7zyZkOwYaJ/GYjPNTX5gvProcPq7ZxtpjurFZZ5eJ4cDU99vWhlS4s4E9nBv2bsRRQrhupFA8TOLaxtZKRCjNZ2w8Fgu/z1KiIBsjmf+0gBT9eJFjCtOhn1sRBYqmHcu8rpWdrI5ftmJlKbEmhdDLnF63lEheCWcOWSRugTymlspOcu0HtE1sxyWFxalhvoagTEvBdz6WcftAZVF/Q+9GVHwbC6Z1Mrd7xotWRBNwpKqaXMRv1DMJEHWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBXvf8EQrNy/d+7omVEDK9dRi+m87zRlKgAVKpwqEOY=;
 b=ETMpOeNeNXooZyMlcEV9TPEAUXLvAjyKksQJDnj7w/BDyRugFpshQ1mcJ1iEFz0bneWVakkZukwkCztmPJozGiueKIramtFkXPNdbyxzaBNpI5/ASrL4Air3xI8VRt661JSBBF+tCVc8OgMc05lXMueCMPDcnOyLbu1F/+3hnVS9VJ5SGppi0fe6Ra9FhlMeiIkuB0F6iKM/WHEAienWPFCCPDfvJ67w5PdHvRcwkqzPE/8edYGO3ZsPp186M7cpp1YzYIdmoV/y30BQ2H5wDhGgQ+097ymK00hssOI8KCm92OlydYplZfC2EISHD0MJ9unxe5n5ZCkR5bpe7XLwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBXvf8EQrNy/d+7omVEDK9dRi+m87zRlKgAVKpwqEOY=;
 b=p1aSfU/NpBNkTNON1xB2RGVuRcvfDjw8jJEBJAc2J2zrKegqCzYgMyDJKC0tMA8vL2Zz2vfk6GJpb4Ux4Ay320xX7oKKSzuiUpiX38WELUVFnOAVlHRQ3YBjR/Dfr1+dgfiTPKaxT83AskVzkCiY8aX7+yOKL4sm+VISP8mcyNE=
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 16:30:43 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::86) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Wed,
 22 Apr 2026 16:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 16:30:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 11:30:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 09:30:42 -0700
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport; Wed, 22
 Apr 2026 11:30:41 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Aurabindo.Pillai@amd.com>,
	<mario.limonciello@amd.com>, <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>,
	<stable@vger.kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
Date: Wed, 22 Apr 2026 12:29:56 -0400
Message-ID: <20260422162956.620362-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2f334a-5195-492f-d20d-08dea08c7fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|376014|32650700020|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5c3e0Cee2zqTCAKLid/DC6odNhzGTySRXVOyGuIQhC6uuFpb+bAIfGElkRiLN1LyKOA3V/Cjeye99t5x4ass5zv8y1b7M+9PCzHZWw+bnwyg/62VWCcic5rllC15bD7hXVc3bWL7Xu/WiM522Jr4h+ZqOlZQ4VNg0YnATZ4H2GsSv79h+y4UUDiX7zCPM4qS4II150/FaNJwz+D0hBI2L2i29px0BIkoOGUZFwesNly1dVN/zf9jbo8FcG1yrmto+VHWxijVybbGdFvwLcDUwGbHicduYXDQyUJWBklK6SKY6zj3H/Drg1QxxOBpMmsaTg/cX63a5vMNRjZQNpHJCuYMvY6/VPJn6gQGZWjBvnd2sWe1Uyh0FDi4jRynd6J05r3aPp0OCTJS+PDvGKk+6mAAn82AXZUuf3Pe+C8SGsNm/gQHbM399JnlHHwX7Hh1qlh8YWR2BgYe2qhtz3UHbBf/w4lrPEf2DCvwO1vMxVb2pZRvpY1kVDEFNMuMJyiT+9E8iR7dHqsgsx4vY816FzjYCibD2zYTWN8Fuv5DDE9fSNo7VxCIZbtP4nb8Hh1epGShX3JjHyqnsUoNsezi8aB5yIES1otsZNpV26nIq86//sM8pZRSArvczqlEDlV4uBnumxkaXLrTmj/dnYaak3fNHPHV66W+u/1aTHUYvYBxAzfzlD8NGCvYA3Ijtjy+hhOisJV4tOG+008QvkoTmBnVwnT/C6YScSnUne1I8bY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(376014)(32650700020)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mlq+I/AQ7NejQI+GKXZmg/km406/YiW13xj5IAGI9coS7J5c6qIAcfG0LmZwKZwKvTosqXlgd0eFFZgLgdwsR5G1myXYmbeNfh9OSPH1khI7iYHUCkgSh77PVNNBMwJMs445Bqn9TP0F3kt09KJRhXdr9eJc3si2IRXB3oRM+Q9+zKNpZRJgzNomwwi6+XiGWzYEoad7Nl8e/a5Z8lNkb8IckWipk046Y+dniDJ4/iMyBiXtZuyby/N/9vfyOzfn2pzZEgXMX4BXacwUoY71+m/iZ4Ou8ShqiQjoKDT0jWDhaoprjwlqU1gCnDtNDp4Zanb1jVsWQDSK2DpkWsjRTRnkLFXxI+ODpzm3rg5XNedhyAfs6vcTdOMMIE6LKYm6SQn/9gUDBv3lgt6Ai9jfZ1VMLQXzusyE6WrcEFCVCyP+R881ppU+vS/DHf/Womi5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:30:43.4031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2f334a-5195-492f-d20d-08dea08c7fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,outlook.com,m1k.cloud,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240363-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m1k.cloud:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunpeng.li@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 10DAB448C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leo Li <sunpeng.li@amd.com>

[Why]

Rapid vblank off is causing flip-done timeouts for NV3x and newer
family of GPUs that support more idle optimization features.

A proper fix requires further investigation. In lieu of it, let's
workaround it for now.

[How]

For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.

Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517c..ce5063928413c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			   IP_VERSION(3, 5, 0) ||
-			   !(adev->flags & AMD_IS_APU)) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
+		      IP_VERSION(3, 2, 0) &&
+		      !(adev->flags & AMD_IS_APU)) {
+			/*
+			 * DGPUs NV3x and newer that support idle optimizations
+			 * experience intermittent flip-done timeouts on cursor
+			 * updates. Restore 5s offdelay behavior for now.
+			 *
+			 * Discussion on the issue:
+			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
+			 */
+			config.offdelay_ms = 5000;
+			config.disable_immediate = false;
+		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			     IP_VERSION(3, 5, 0)) {
 			/*
 			 * Older HW and DGPU have issues with instant off;
 			 * use a 2 frame offdelay.
-- 
2.53.0


