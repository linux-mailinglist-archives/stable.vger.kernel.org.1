Return-Path: <stable+bounces-118627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32AEA3FE61
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF0420302
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97450250C15;
	Fri, 21 Feb 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rAwSUPZg"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1EA250C02
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161365; cv=fail; b=nRpX4k7qIQg1t0JZoLZBC5A3uMb3dhHQAVHR5EugtCt9ftUwQXWzkuvXaznuObBI10lBUdHaKOZBV5sQjUtxTXrrg/2N66mvhXdm+EEd9ayEzY6hJ817jkgNQjcvvxEa7Fd2OdNgfM5ooNIB15Uy8qUhePHmJL++bx01OzHzMwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161365; c=relaxed/simple;
	bh=6BSg4xvUOH3E4PKTsgAPXnnGFy+MFV9RMDnPNA+vpfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYiDUzri6/KyjLJzHyZ6COA7bVRpnv376wNq6JKQrfDVBhBJTzGV4Z/UzCNjekbdVb/bm8Bv1zE5A4IlRCJ4lKdZEpDRTV6Mfc4NYAJQ3QaZs5pgvq1TqfYtxDc/DHTtBQGvURtDcodsVpcTurL2Y4GGP01zrybYAMcMCbcmSi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rAwSUPZg; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwIl7XJPDZFAzo9L9BrNGJVRiadV38CHsAry9EsyAquqTM1dYa2gCN+qI1+otHgSACwNJrcPolykr94XVbdkw6x8Axw/Uiv71hj6cCQA6B9sW+qE1Nn3RW2ThVcuaUxU/SMP2MuUzWHzfDquSsftoHWMptY4z+BGars1NUgBv+FsCY+CstZ2zXyZJGm90i/W9nNWzWW95heJ4pqjIutrA8W/KpiwB8V6CbiXk5fK8xBn+gfWvrm5tE6yJ8CoxdFYpMDpjvSI6pqg5EdwzChnww8kTrUChm+SPiLzV5Mm0BeaqVNj24/hCVgVLN0BnRcDF5pN5Amg9xE9/R6TaEGSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSdbSVWzWEfTOe3b1rYQXHBT7ii0rvV8fSpNanQlwhI=;
 b=kTF9j8xxElY/enHgPAzOjZXU6P860SVB/G2TIkLSeY/deQvz8hOmA9zy6VdJq1KxelFL1fNafVnTLW4FsKwQYzd5WJjDHdvnh7CWHIeqW8ngJdXyZdjhQISWpoKWbiQ0BLdqodGvA8mvnCO0PSHMr+FhY69xnB807Vzi9PsgHPuM+JTuEXKk9iqqNPrQsJi5H2ItF2obuD8p6TnaNcz4Hjj+/pmA0xGfD9WmIA3hwc90Ha0nO9mJSOLcYf9pDPjN/U1VvbIhgN+VNgWvrriyIl7wKAMMMsefvg3TJ8CyXGU9uesAl2Fop2Z6FRu68ephqivobNODRA4fyulkxBowlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSdbSVWzWEfTOe3b1rYQXHBT7ii0rvV8fSpNanQlwhI=;
 b=rAwSUPZgwvC4qIkydBdWmWgR5LRxCoNIshaFHj35dpKo8yiYz/iyDGXcydrstnUet5fPxofyQl6usP0PAhftVSuNu4rHLn0krc+dV5ZCUMFEivJYI4w9EAMxAHza5zLJ1UsESG73iAItvZ/UdxjkGRhAev2xwm6sdNp+vaB9CMc=
Received: from SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::26)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 18:09:19 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::63) by SA1P222CA0149.outlook.office365.com
 (2603:10b6:806:3c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 18:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 18:09:16 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 12:09:15 -0600
From: Lancelot SIX <lancelot.six@amd.com>
To: <stable@vger.kernel.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Jay Cornwall <jay.cornwall@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler
Date: Fri, 21 Feb 2025 18:08:52 +0000
Message-ID: <20250221180852.465651-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021803-fondness-ship-dc72@gregkh>
References: <2025021803-fondness-ship-dc72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a60106-59fc-448b-26e2-08dd52a2db1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isP/DE3Gtgr7klM3QjxUUZqKPX86mF+j6UUU45Yn3T65c4/0iUTJgWbSA7kQ?=
 =?us-ascii?Q?DI/yVqhOOoJR3TlBzj4obXycr20DGp5ZcOSldCij/zLU0m6cRMJs1/OVfD4K?=
 =?us-ascii?Q?qRJhvht4Gy6hu1NuGCz5adWJqLs85Fd5AnDNuMo75D/96B1tVcbmYOjU+5QD?=
 =?us-ascii?Q?0MhERGnXJQDZiAI9RhG07RLicXVr0RimG1q6y6Ne2tHn9/ua/XC7pkAo4ad9?=
 =?us-ascii?Q?mLiAoj8Tz96wlcxEeMBI30SomyMYUzL7BZwlpUfUenju6AaIEYEaG/g15GEv?=
 =?us-ascii?Q?XODVHaev8NQtJJYB+qcX2Z3NAGff6T9WsnIz9mS1lZwgSHlmv+Stw8Y3VRfR?=
 =?us-ascii?Q?JWrbNFpEBAsFZINkxeSG9bplO+M39AHRF9H9Mv+T8sFusuvdklkA8Rq2uE47?=
 =?us-ascii?Q?YOl0E+MBVpO6jVIJzXxXFHhJPz5jz7qspRkfyBDq5mrECP9z5bMZierex4D+?=
 =?us-ascii?Q?Pps0coEX6FtdMHF2AeWgow9kO9znwpyf6BwmnXDGYhWFMQCKLAVvyTTeXYZG?=
 =?us-ascii?Q?Sa2tONfhDbJ7agYhYBjy2+ZUd+zclsNdSziFycnPB792bNg42IiFmuZb7pXj?=
 =?us-ascii?Q?9ebbh8zdTaFMSIo4hXcYd8uYGDS2KVJOvdE34buSlwjZVhnC7DpY2Xe5hmRK?=
 =?us-ascii?Q?uVfCx3VcNiMXr8nfnLZnl4BcIJWaV0bpV4DNTBQVSbF7PQWeA5Wh2G/NAJXz?=
 =?us-ascii?Q?jk0HGwOyY84uNQJdpGAo1cMyUO2NaclXOHaTheEowC/1ftoRTCqQgTTD70f0?=
 =?us-ascii?Q?AWNiYjFe6xHgEzMO6M6++UgB36qUhdyz+/G/B5At2LLZoz2By/BfTN0iHAUI?=
 =?us-ascii?Q?JFt1syop+s0MZMkdp7q25Krpgm4itGySAOtncRCOEIKlptSj7YHtPA4j0VTW?=
 =?us-ascii?Q?qnTbH086y4d6R/4klwlvbplH4V9m/FOW5NTsINLUzi6LjYhDwv4tC4I0IZYA?=
 =?us-ascii?Q?FyAlkFm7MyAlV/M4pTVfTBbScMN18KytdGkYPsY0z9rMFi05G/dn4j7txcX+?=
 =?us-ascii?Q?7TJq0dKF6wkgv6pjeh/EYI+bZ91WnUb6n7ldy6ub/Q5WLdwBi3i27wKRsc80?=
 =?us-ascii?Q?uRUZ2SonHR/8cCFSBUxDA8VfcVgta+9q2l8KkLVeC5IIlD38Zz50kD3L4MjJ?=
 =?us-ascii?Q?dduJcSvRtZy0EEb0pqdMQcBtyH6ohoxOxjVB1GRDQIHsPyDHyraiXGLwkq14?=
 =?us-ascii?Q?NDKL35nXIGRLDjuilzfOdVRWit/OM6UkUtSXRZ8xY2cY6FQEWoXgTVqcXbs5?=
 =?us-ascii?Q?XsxvVA2a/8LqrVstIqf8gMic66mYibncsun8BjyBT+sc4ZFZf0DoTyEhKeZD?=
 =?us-ascii?Q?HzFU/PpuoFs3tdsfIzBUzMglZyNWl4F4EPl3Fe28uD9juWHdD8ugx/lMFzfj?=
 =?us-ascii?Q?GrUJfNqMNMW0YlTQRkuboh5XlHB4UwZ/mUdivIwyoIrwM3Ph8vJTl0lk9wbd?=
 =?us-ascii?Q?GiGFKYjEzIHL73OTFomCSvYhfdJ6OIuiPnwR8Ube6yhD2emrqzvXLrTMd47g?=
 =?us-ascii?Q?EbB+n011cyAJGPI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:09:16.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a60106-59fc-448b-26e2-08dd52a2db1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

It is possible for some waves in a workgroup to finish their save
sequence before the group leader has had time to capture the workgroup
barrier state.  When this happens, having those waves exit do impact the
barrier state.  As a consequence, the state captured by the group leader
is invalid, and is eventually incorrectly restored.

This patch proposes to have all waves in a workgroup wait for each other
at the end of their save sequence (just before calling s_endpgm_saved).

This is a cherry-pick.  The cwsr_trap_handler.h part of the original
part was valid and applied cleanly.  The part of the patch that applied
to cwsr_trap_handler_gfx12.asm did not apply cleanly since
80ae55e6115ef "drm/amdkfd: Move gfx12 trap handler to separate file" is
not part of this branch.  Instead, I ported the change to
cwsr_trap_handler_gfx10.asm, and guarded it with "ASIC_FAMILY >=
CHIP_GFX12".

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x
(cherry picked from commit d584198a6fe4c51f4aa88ad72f258f8961a0f11c)
Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 3 ++-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 02f7ba8c93cd4..7062f12b5b751 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 44772eec9ef4d..3ef294ead56c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 

base-commit: 984391de59a1d6918ac9ba63c095decbcfc85c71
-- 
2.43.0


