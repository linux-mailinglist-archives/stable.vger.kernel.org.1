Return-Path: <stable+bounces-179671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9FB58B99
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 03:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9286C3B5236
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 01:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F91222566;
	Tue, 16 Sep 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZUH3vCn"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BBAEEAB
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987970; cv=fail; b=DelcdfNwr1E4d2ftgjfTT4ZTSuo9EhC/2HtnlQ5Sy4foRd7xQTtvnzMaG4wBCO9H8yWy/N+vxQBbGkwggY/AS478iyWc891ViOq1FPgg8ORP8QPvOsfYRS6pqchKJj+0OApsxw70nyk2x/YM6fuSZqJf1iCSKU4iXx+rl+D753A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987970; c=relaxed/simple;
	bh=Ap9k4M77S80FhTze/2p0/gUa1z1YRSOEBgffwCxEpzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0wfies5nSgk4LUZcgY0CpDfFu+8mjb9oM/zap3RrVyJfHpg0KrrEdQW1oArXlSJQcgAi+0LYHJpYTZX6c0azG15O2sVCUD9Yz3pFt8/1BSx7juG6LG6fSLKb+IqdKWRVePI5d0vXnF05ZfTamSxeKbj4vGfYXpHGBJnSRYft90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZUH3vCn; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q093+aY5gNgT+upSR93Ko0czzCWcHn0OQeh4KCoy8z+lEHoxdnBpNtQafASu7BQI6SLh6H7fAr1ckiLXXMN8LMY2UHGaC6cR3csBkGZ4GRUqC8Y2eIomQcuA7VF7ikUBSGF7ST2Ygw6Q//eJZMdzSfOIilLEzKgnhgFb49KKACgsVQnQJscK2JbAKfqfWFQQcBUecnzD0KzfFnW6Ju7quKHTcZ9KQcnXRJOg5gLTuPXAPdmFDsjZQ3gapNbsNfeWGupnD2ILM2Yawrm4NjC/Z/G6bm8EfiHmfq7N3VVs3MVcqdVKtckNWxFUsE8pNp0q4Mui42XXfd7hczBD9MUoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtpM5GmgAOvvR5LsvKZs9cN+YRUM2AHYnPsfzAlq4pU=;
 b=WHCVq5g9ml8sTVfeTgA6gEXBDDW8pdGRmsoauucpUvgGQJl6otCj6n4Bvr2YY3Cblm9FR3idPtUme3LIapGBMGCBDwpZ1rcBoQoEt8LIO3eiVxceNJgbkkwrJ30dVaORNonMIZxrhZVAIp922gYrUiBf7dUTn1qnKc6UmrY01IjtlPkBxScD4jQ3HcG/0pCKmTdIoFFgL8VaiEnHhV9WuGJ92MyUOvM9E08B0DoHnkBpdHKUO4Vn7drh1xIeTkEI559zK89zS0hZh2vQ7b130w1wD7mgLx82w8G4X7nqtvhU89fbQryzuZlbKdaZLFFgebC4h4nAp8Yijwm8c5DIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtpM5GmgAOvvR5LsvKZs9cN+YRUM2AHYnPsfzAlq4pU=;
 b=dZUH3vCn2tQpOI8dIXa3AKHv6DyP7PFpu9jzQHsDfd0V3oWA/7YCZJytGmIpurXXajkVzcHpXv8cGUbMLUSfRjUV1kcwWIe3qGfxi8H49N/IrKL1yz1rwtWf1xGj1vBdpnVVEdHGpnz8jlONuaeCi75rN3eXqcQS+tXD2etuyvo=
Received: from CY5P221CA0135.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::27)
 by SJ5PPF6D27E3EA3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::998) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 01:59:24 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::5b) by CY5P221CA0135.outlook.office365.com
 (2603:10b6:930:1f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 01:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 01:59:24 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 18:59:23 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, =?UTF-8?q?J=C3=A9r=C3=B4me=20L=C3=A9cuyer?=
	<jerome.4a4c@gmail.com>
Subject: [PATCH] drm/amd: Only restore cached manual clock settings in restore if OD enabled
Date: Mon, 15 Sep 2025 20:59:02 -0500
Message-ID: <20250916015902.77242-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ5PPF6D27E3EA3:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c832957-14e8-414e-611c-08ddf4c4a8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZldTekgyeWRZcEFOT2FSbElhaGpFSmRya0lyTG9TRitLaGY1SmoyYm1MRStw?=
 =?utf-8?B?STJXNzg1Y1hJQUFCMlRiRUxDVE42OFN6amZ5UXIxbndNREQ0OFNYMGZ5MUNQ?=
 =?utf-8?B?RCtnU2QvUXpnTjJvZVg1dnRFUmdiZU53bFZ3V3J0ZlpSNG1pRmp3SDNJRWVa?=
 =?utf-8?B?MWg2NlZ1NllPa005WnRWNVhhRFp6NjB6ZGpRR3VjSEZ5QzlDL05uVXlqZjB2?=
 =?utf-8?B?MlpZcmJuVVhTc3RMZWluNDFGQ21XZ1dUTFhMeUpOMGFHSU94TXBIWkFYQ0Zy?=
 =?utf-8?B?RUVLdW5yS0dieTVKR0ZWRm9JZlgya25rczI4VnNRV1ZJNzNQNGRWVVZJRTZI?=
 =?utf-8?B?WGxremVFZnArcEc1b1RleUc3SVpoc0hzb3NPMXduZ1o1aGU2SW1SZnRLZVlw?=
 =?utf-8?B?ZzZvN0lwdlloQ3hRdVFkdmhwV01UVGJ4Sit6T0lhK0U3ZGtMTThhRm1BTlFY?=
 =?utf-8?B?L0RaeE44STdpdjlXSG1EeE45YzBmTGJlM3paS0g1WWZCL0Z4R0NCT3ZYL3dM?=
 =?utf-8?B?aWVZK0hPMzZEeXZMejZuNWtxck5qVE5rc2p3TkhiZXhiQlBRMkxjaHpIRDFv?=
 =?utf-8?B?Kyt2TXVveWxXTnJqYWNLa3Zha3pYQmtackdIMmhxT09IV05qVDNUeE9CSXIw?=
 =?utf-8?B?cGx1b2FaNVdYNXhkWUN2RTRnbFc5b2xDMlJSanpNU0xiMUlqZ2k1eW5nUDJi?=
 =?utf-8?B?SnNCSkRwQ3ZPMFFVUGNPcVU0VysveUFXNXdTR0VTbXJpVURaS2VOTGEzWElR?=
 =?utf-8?B?QW4rUkRZTXlNKzg3bm1CRjI2QldCelRLd3Erb1hjVzBEcTlRR0VXWjZOa3N0?=
 =?utf-8?B?WXRHMXNyWHI5NUdqNWtJZFZyTllKaTVKQWZoaXBDWThWSmc3ellUNGc2RUlT?=
 =?utf-8?B?eUhaNHVNazZhbmU4MzRmL24rUkNSdkFmMzVtQ3YrY3ZuWFA2aGZGUlNZNWRE?=
 =?utf-8?B?Nkk3RkxNOUpKa2M4Z0lIVUJjcDBEQ3BUelpHK1c0MjN0VjRMYU1BdzNtcnJB?=
 =?utf-8?B?d3p0SldnQkswWFZvQmwrVmhES1BaOGh4dEpDNGt0R0hHV0t1RWxVOXVGY3Bw?=
 =?utf-8?B?QVYxS1U2d2pZTGlsQ0tqZVBDVzk1U09iYXgwbkxBMUQxdCtLTmZpemJ5RlFZ?=
 =?utf-8?B?ZllDa21TRWtMbnV1NUhaOHFjTWdCQUJ1bllNN09vOWlWWXg5Vms1bStvcy9I?=
 =?utf-8?B?SmVQL3M2SmZiZE54SVdKZnJ2bDAydDRxVmRxYnVNOUl3SmxNSm1XZGlVYldL?=
 =?utf-8?B?U3NkUlozcXc0TktoTVIxL1h5ekY3UnM0ZFFOTHZuNU8zdThDME41YXN2bXdV?=
 =?utf-8?B?OXdDd1dZSjNiMWcxNXpudnJiNVd4OFhnZEFWNjc5cXZlR1Nua1pNQXZIYm5D?=
 =?utf-8?B?N05EWFJsa0xuckdaUzFOTVB1cklpUDd3eGxXbmhVbmxubzFUTHMrUlc5YUoy?=
 =?utf-8?B?bnRrckF4RlRja1ZCUFNhNUZJdllod0xxVjNtaGJKdGdNb3Z1blE2cldLNHlH?=
 =?utf-8?B?YklnYXdmbGhzL3UxanVuWDJVVm82M1B6YTJRdWFjbVhvd2ZVanVLSktlbDJO?=
 =?utf-8?B?QWkwMnlIUW5XdWVGMGxtL1BJVldNZmFIUi9UaGsxL25ERmVjaDc3MEl6Z3VW?=
 =?utf-8?B?QkZGNkdyWEMzRFVYRDhYbWRsbUlMVnR0WmQ4L1c1TjJSc0JQQk1mb28zTGZI?=
 =?utf-8?B?L3VhbkVvbjl0ODZkd0ZXcVRTMnY4eGsvTGdhYXVER08zeGczeTY0UGlDZDBv?=
 =?utf-8?B?LzhVVDRBaVZEU2lCT3lrbllRR2RkTjR0aDFxZ1VkV0ZJdDdxZUtmbko0Rkla?=
 =?utf-8?B?d0I0cS80WFA0SzlpOGowZjd0SlFwZE5TTzVNV3pIbzgzS0NvblZHanBHTkZY?=
 =?utf-8?B?UEJDa09hYWZiSVZQclZndmtZVE1HQWJmbnhYNEZFc1NPZDF0ZFkzc3ZlckpY?=
 =?utf-8?B?V0RVNEJIR1c2L2xUWm9RODZkZ0hscGZld2trSGRUMlZtVlJ4d1o1NXFrZ256?=
 =?utf-8?B?ajNLU0NaRDN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 01:59:24.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c832957-14e8-414e-611c-08ddf4c4a8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6D27E3EA3

If OD is not enabled then restoring cached clock settings doesn't make
sense and actually leads to errors in resume.

Check if enabled before restoring settings.

Fixes: 796ff8a7e01bd ("drm/amd: Restore cached manual clock settings during resume")
Cc: stable@vger.kernel.org
Reported-by: Jérôme Lécuyer <jerome.4a4c@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/0ffe2692-7bfa-4821-856e-dd0f18e2c32b@amd.com/T/#me6db8ddb192626360c462b7570ed7eba0c6c9733
Suggested-by: Jérôme Lécuyer <jerome.4a4c@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bf2b38dd7e25..fb8086859857 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2263,7 +2263,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 			return ret;
 	}
 
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
 		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
 		if (ret)
 			return ret;
-- 
2.49.0


