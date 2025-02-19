Return-Path: <stable+bounces-118275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D6A3BFEB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A03A728E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AF1E2853;
	Wed, 19 Feb 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bbfqwaou"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025D1DFE36
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971583; cv=fail; b=kcMK0ehfJS55jz8k1hR3bpAehJckH+DW3jpq1TIcDSmaxsRmH+na74asgcvKWcFu4PFtBVaAzhwTnQ60zIMXH0RyP8h2STgkOVsjL05BCFkGIj2dZDZyaxEpKLLqpvUarZQa/mo6fJ5JmKJTAttWpWPhKAQJvuwQEB59SErX+ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971583; c=relaxed/simple;
	bh=Yjza1PQthzsZXjt0GCISDg04pGULCV8GH3NTETr+Nvw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RqlqRP1xvQvXdDQ6+Wsytv83hiAKhbjkaFgmQXdMxj6Jmjz5qlKKPZIi0q93DpopSLLWdV+whKjywGA0umr2oIVAJ4R3ygLtsKNwKAeKlf2oxLQks/yO/z0c2SNEQLi9yUwuf+kcz8YuKzBxpTntwLVxRp8LZzhsk6D2dY2TxNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bbfqwaou; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y40HX+pUOir178vOYordpApuxOsMhjLKSKYoEgY4dNWV7idG+cVAp2A0HyVsYuG2UNf5hy8brg+a+tG0yJFnLpCDtVjVuOesI/KtsVMMHETKFbhddjzObE9iisxwbAu7MnsStPdnGtgXFKvrjW6LISf97tcH6co5dkJ5F8vyya2Rx1e0W5X7UBEVKldfEhzf9ZbR8b1IwNPDGtLNi8XPlkCP6iUezOY0OaSByQ/Hr6abDUrcf2e82wihLqIY0pKfkQlBgN39MGGQ/7+eXNYAmLPwwSHiExEmuIZR3QSDsYaONcVmtX/m/QQrYwjhL5RLMWiUZsQwVZm5X8DLzg5kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KEeSmQP+A2IgxU1LuA3SalaaQg1pJu6DJGKpS7xN4M=;
 b=QelWRUP0s2fDGfYskrUOsGxSrWBRhD6lkuY5ZphrmVKvlN23l2qhB57VB4p5xYjJ2kIWd58rcF9iq7oGPkP4FKew0EF0x+r3nfdkIolQQQzcrjSJIpYo42WojX+7jEzIz8fV70HYZtuhIC/GcBTgN0qe3VIW1/+votmNNvJ5TnpPRAaDot2L7lwBe4PJppadsszExhRH4Y9H2TM7owxNmNDB8tYfaiW+PabjfCwrPbT5ioByCwo0OWKgeoWx1i3DFVaFHRmO9Rf9c4p+2/+I849lna5sRnCRz57JL5IRJiT+IV/nMYPulauPZdaW8eBauBuuPE7tsDN2GAAoBof/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KEeSmQP+A2IgxU1LuA3SalaaQg1pJu6DJGKpS7xN4M=;
 b=BbfqwaouFlzADP2yEKaSDF2+ozG14J4YvNu3qxXO3jRHc4dCsEpkmw+IxOLezp8fUwn6daqSJy3yQIS0XYXksp+AeHYlDIMGrV6yWad3DwT3MRs/IB3IIBeErugpKgj63mbmMYBThRR/qQf1b/V+SdOHvgve/FMSxPmFH6qLMZI=
Received: from BY3PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:39b::33)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 13:26:16 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::78) by BY3PR05CA0058.outlook.office365.com
 (2603:10b6:a03:39b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Wed,
 19 Feb 2025 13:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:26:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 07:26:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>, "Sergey
 Kovalenko" <seryoga.engineering@gmail.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: manually control gfxoff for CS on RV
Date: Wed, 19 Feb 2025 08:25:58 -0500
Message-ID: <20250219132559.3940753-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: a22603d8-1a0b-411c-c7b1-08dd50e8fcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STBMK29rUDFHK2I3QmtqMlJHVTZFMTRCNmxoMXIrVDdlRXJ2YlVjNGNEczV0?=
 =?utf-8?B?ME1NNWhWOVB2SjN6YVdlakVJN3FmRVpOMEdCT1ZlYzNuell0MThocVU5eFhU?=
 =?utf-8?B?T1ZBRXpHNWtuYzFsV00yUCtqcTNHZ0t2QkFlZFRSQnI5Vk94RXhIclNrUHVM?=
 =?utf-8?B?Q2VNZVczVS93bCtKT0NoeXBPelVEb21SeTFjcEdmZThsNnVXVGFURmQ4VWVW?=
 =?utf-8?B?R2ZSQytCcFdJSHB6RE5tYkQ0YThVZThPcy9Na2RxMVJaeTJnSDZpK2VaeVAz?=
 =?utf-8?B?bHo4aFBSbDc1Z0Z6bGVnTVNrVGNIT0FpYUQxVWFkcWlPeUVzUWYwRENNYXZK?=
 =?utf-8?B?bXlkV3U2alhXSzhYRWw1ZzRSUXhwenFwZVhITHMwY0dCb0RGMFhzOWluQzF2?=
 =?utf-8?B?dEZDZ3pFRFV1cFdkUmhZZmNFZHBhTVNOcVZJTzVnZkUwNUxEdWlkUHJMU21s?=
 =?utf-8?B?K3p4bTNtN1lKZWtwUXloUUgxOHloL2NDQkZqWW15MDgwTWlpNHFqdUw2M3FB?=
 =?utf-8?B?LzhDRE1WS0Z2ak1yajgzdjNicFViOWd1UEhaQ1dsallpVnJySFBpSWwyTjR5?=
 =?utf-8?B?ZGFvMWcrMUdpbVF0UlBGbXBIdmNLdWhQejF4ZlYxd25sRlBwdXVuYXBCenZq?=
 =?utf-8?B?WHhIZGwrb1VMOFVSVGpraE9XYVc3TjlDK0tyemVQSWg4b1NleHZHSXkyeUw2?=
 =?utf-8?B?WExHdkhZbE9kOFlvWnF2c0ZjL3hnWk5aQ0RzVUJNZTJLLy9lUnNFRExHaEsv?=
 =?utf-8?B?MVFaOTBXL1BkaFFmcFVSVmVCN2RTSDdtYlVtSUZyZFIzcGVMZmx1WkxzdVlW?=
 =?utf-8?B?NTFiYjh2MEJJY21TNVpkUnNNRGNhZGduVUt2RGxiN3EyZjhTUk5rZVlwekpT?=
 =?utf-8?B?cVlaTFlFOHNVWllkbk9sVTYyWXg3S0VnOEFVc2tXNUJidU1WaHhXR2tqQ2Nt?=
 =?utf-8?B?Mm90SkFkaHRHcm5KLzlTOFNpb0VBR2N0Q0dvNncxeWtDck0yVjVwVndmR1hL?=
 =?utf-8?B?UlozTHd0ejN0MFM4czVzdmt6cXk4YUU1SEVaNW1tNVBoK2dpTWZwTnpxYk9j?=
 =?utf-8?B?Qk9rcXBlelpxR2xXaEhzSFV6UEo5b2o2bGUySGF0RHB4SThWZHZaMmhrcVhU?=
 =?utf-8?B?cGppZGI0eEhDam9sS0tHaHZaeWVzbzV5bi9uMFE0RE56TG1CUTlrMlh4K0hK?=
 =?utf-8?B?MUxxVyt0UThINVpVS3VDU016YTJOU3M1S1greVIxT3UwQ3FmNUxCcFY3RC9K?=
 =?utf-8?B?N0hLNHUvcDA4RHQxK29WWk5HMHZzaWVCQk1UL2JJbjhjRTBsVFJlUU1DK1lR?=
 =?utf-8?B?THZ5dzRvVm1hdkdPd0NwYVdhUXh1aHA5YzROQUEyVHY2OG5OVng2Z0hQa002?=
 =?utf-8?B?bmg1L1IzMmNnTE0wbmJzTUU4TzFOdEp0N3pLOEtuZ2JLQldoMFFicG42b0lh?=
 =?utf-8?B?OXlLZEV3bnVCRnp5OUs3VTlsQithbUpiYkNNeXZYYVMxQmU0eThhWlhTUjRV?=
 =?utf-8?B?YzIrWTU3OTVaYmVLUWVxd0Y3RGJpK2ZBWWtYQ1JmR2w2Y3BNUFNuaDlNclY2?=
 =?utf-8?B?YnVldm5mZUdabzgwUWlYQUFtQTlmdzJMbjlrWDRkYWZLUWU0cnptREhCTnBD?=
 =?utf-8?B?SkZ1ek1xMUNhRXpCK1pjMEFWQzl0cis0SFptbHRLVzc5bEZlbm5OR3kzeDJJ?=
 =?utf-8?B?N3Z0ZXgxR3J6Q2s5bXEvZGsvVTdOeG5jTWViMDVQVXUxZklWTEFMVWNJQ2xk?=
 =?utf-8?B?VmJ0cFpGSlkyZ2UxMk5QeHRIckt3aStZOTQ0cFJCSE9lT2pOeVVNYUgyUjAr?=
 =?utf-8?B?aTlQcDQrZmdlaGNXTDkwMVhlczhSZll1cVZSL1ZUMitCb1JncndNcmJiZXg4?=
 =?utf-8?B?ZjdUcXovL0k5aUJZcGhaMERzM2M0R0dPT09FUjdqbkZnNzZpWVp4NklpMGFM?=
 =?utf-8?Q?yxYj3T9hkJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:26:15.6445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22603d8-1a0b-411c-c7b1-08dd50e8fcaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993

When mesa started using compute queues more often
we started seeing additional hangs with compute queues.
Disabling gfxoff seems to mitigate that.  Manually
control gfxoff and gfx pg with command submissions to avoid
any issues related to gfxoff.  KFD already does the same
thing for these chips.

v2: limit to compute
v3: limit to APUs
v4: limit to Raven/PCO
v5: only update the compute ring_funcs
v6: Disable GFX PG
v7: adjust order

Backport the change to 6.13 and older kernels due to
a change in function signatures.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Suggested-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-January/119116.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x
(cherry picked from commit b35eb9128ebeec534eed1cefd6b9b1b7282cf5ba)
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 32 +++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0b6f09f2cc9b..d28258bb6d29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7439,6 +7439,34 @@ static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(adev, AMD_PG_STATE_UNGATE);
+}
+
+static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7615,8 +7643,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v9_0_ring_begin_use_compute,
+	.end_use = gfx_v9_0_ring_end_use_compute,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.48.1


