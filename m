Return-Path: <stable+bounces-210944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBFbLQMycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 324985CD3F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80775AFEE9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518E3ACA6F;
	Wed, 21 Jan 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="peJfQvGc"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801E3A8FED
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019910; cv=fail; b=ZH6y0lnA3hc1FzTNQ6DeM/dSHwdPVD3p2VtUdf4yMzPOV5nuMIbPn+7H0gSTV64L5WjkBMWmGivR7KSzznpusgA6w4RQPujvTHDPQm3UuRWQqdIVQAvVR4Fw9Qerc68iwD6TAMqs2R5civhnMQyf41yx5tw4qEfihdUuZXo6Vsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019910; c=relaxed/simple;
	bh=NmXvOF5X04e1ISEAQz/RlTMrxp7Iai0sq3fz8aqImQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIkNkdB/BcnZX4XBhNWcng7u4WjReIF4J7FEYvXoZhjfHsCe+HFS2Vw8GfkWpBDljvyMX9J5C1f1VDpeLvrHs87XGxPe1AMPqZN7euBGJcGWwtxa/9VyvA8krCuDAy+JPrPa4SNpxkLTF9f54G7tt26stapgHvEyHtbW2W34UEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=peJfQvGc; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgdAfK3u1E/Xd7vCbRNQlGp+zEc67wekdlGNawq3gNcnZm6SD/28C5PQ7S0jKuWDUKH8MBEujm8gag1sOsoMKMhiaL2lfBPgHO0vp3egVUH6UDcb4PHkL11qtz8xdo93KaHdMKmTy2LU/ozd+QqtGmbi/1pBLrhVlBvKeQOYCJ1/7sTex2qJxDU+FmPUZMDPmh4MJsqizjs5+t8EhUZMFqdzRvAob5xL3ICmCT5KzEyuUp50fQyqdqna3kxZvk66FGgAmrvD58JHBstM/gVLTTEoLJw3iOEQz3UsWrUlJZToCkUBeHH1wT8lEHHvjnQiox6NjepmpV5ZXMi62S44eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH9YHgN9lD5HFV2Oi2iFawNUKAAxcT2kbxtrLJkBhqo=;
 b=CEZjro/TaGhTtWIoI5cc3kiqVe4uJBBhyTpx0w1H6EGp51Y9L/eG0jefTXx/4eGOGEtMl965pQ8Gdp3bLcCocqh867eG3Cd3Q5/AFZ4UjEgxMElZ6AfcGkWBxZ8JWAb2DvRydnIXXtJxyEZaGofm60ZFFfwNxDZYzhzWBmk+kGNJ8RxYwU2jti4NNqCIZhjJSl21NW2iuEKwKoD2RDqzikNmZ3Su+HpkmDOkkxkHfh+j4mm7FbW0I1gV1li2EaAQPv6RISbPuQyWTcL9BZ5WMVtfU0296RSgw4yKn+lmBbb1deXG1k8kNaVQW776LIudDSBzwZHH25JQJRX2YMYGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH9YHgN9lD5HFV2Oi2iFawNUKAAxcT2kbxtrLJkBhqo=;
 b=peJfQvGckl1UDpaKewPcf3wxb5yR9Snl5inlenBhsgvFYKNKIko905PmIRrxsPx+uENvZrQMoY/A9xpcWR76GMniCgnfv4kVwUOqT//gdTCiV8+I+zCaIf9uv/iO7WYGQQCdYS/xZ4jsgqdIS22O4mUMYNJqEfXUdd+DvA9p7g0=
Received: from SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::7) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 18:25:01 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::f7) by SA9P221CA0002.outlook.office365.com
 (2603:10b6:806:25::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 18:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 18:25:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 12:25:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 12:24:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 21 Jan 2026 12:24:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jon Doron <jond@wiz.io>, <stable@vger.kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove
Date: Wed, 21 Jan 2026 13:24:47 -0500
Message-ID: <20260121182447.2434085-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e8b1af-5d0a-4dce-7945-08de591a635f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dr33kPgjKXtfjM/5mLxBkrESdjIG79Q8xID1O9NxBNm/TnsA6YTm7/KnsFMa?=
 =?us-ascii?Q?n10sMiXV2INOBbJd6EOM/CdPUm80YJvzE5HtHieSL/A0OVEk1iPJeI8qzBZp?=
 =?us-ascii?Q?ZO/qsO6wJPZVYBEs8lLdmo+hlqLT8MdgvR2uFf1gTFH05rF/cv+GMFqisGF2?=
 =?us-ascii?Q?gPrQPvxaRGTCO9GKj9RHAuGS/S9uHIgDw5TwZytVEEEBptILWy/s6Hbz03lz?=
 =?us-ascii?Q?w1+W5r+GILzzrhPt6JE8xO8SMoXYuj+RYJ4rpbuyOj7IkgOHbpXE1DZ4WenV?=
 =?us-ascii?Q?qf3EuaWER6UxrpkV00X9VA4CIqz4xQTaFyJFf486zpfueJWS9bBjueBTjDyI?=
 =?us-ascii?Q?TPR3mqE3TbY6tZbxnHQdXQ6SBkXgya6l4ko1e9DL8J523/lHxevz0ygmm8mH?=
 =?us-ascii?Q?+72DznxnQGQh3XIxA8cVAzQ2HYYRO/HnaO2mQECFpSKLV0Sh1ZUSehrVch0c?=
 =?us-ascii?Q?0ag9mOA7gKVmEiUxdPSOWZ1+dveGHAOzgZwFFqYVaziFu68oWpP5sfnUNbjG?=
 =?us-ascii?Q?FXFB32YeG0aabG8xpkpzMhfQZK/dQQSHoOR1mc+agrKkQFhlICFpx9CvE+mk?=
 =?us-ascii?Q?yrm9em1/iR6Mh55qX9rT1WHJn8d81LDmJTs+FdYXpPvSpD2gbmvL3VzhM8ca?=
 =?us-ascii?Q?vD7QRG8WyqOWbLwpOBh+IIcnsYKCzkQ7yCHb6r+In+nlpDggskwfoVsPGKrA?=
 =?us-ascii?Q?4gf35yObhefaSBXWAuShGpU7OgaL7GpdBLOHHcrZAEC8hJzcN7lAjvzI5U9W?=
 =?us-ascii?Q?aLLUzb32u8NInhxogVk89qwcRYJ0PJ21UBGdVPg63X5iGSTbLeXAszFU3emk?=
 =?us-ascii?Q?l7dkhkHBaj69FSEgAdvptqdPvTBfASncSZNXXEVOQxoD4KOhYmCMI7GtlaOd?=
 =?us-ascii?Q?t/KDoIztFg3dnuRmZgKGEosFN5tXgheQppptyKTSemyKfS6iOepSpap12tF3?=
 =?us-ascii?Q?52NPxWk3A3B5Zom7GUqHgqZwJCASpjfZd67fkfpN2Pe4O12wkDCcnd2zCK9g?=
 =?us-ascii?Q?YADpXRJikYAFclN+AxILIM+7+S+0XjUgqSKVMr/2r5cUxLBeM+151vpelleO?=
 =?us-ascii?Q?ffxEHCFCxqdM3kJmAVA3tE9Uo9c385NpJPADdfR6uFykQ4AHwAvRToqHdwjC?=
 =?us-ascii?Q?2eTYw/MquQcUtZxJrrt3eqGvAVECgVNaRxz8/uxJ41L8S4lLPI0Ej5/8XApD?=
 =?us-ascii?Q?OuvtKCihrYoB8/Hd+pWIAPeVzpeM0jton/UuN1IkCBXAZo7MuGYU3phUDM/1?=
 =?us-ascii?Q?vtu/lIBFZvoBkgerCAV1Kk4pdlSMHxMbxku+Hkq9iQLPgzyUa5cBfTQNu+WV?=
 =?us-ascii?Q?t4+8BbtCBIqkuEkZBe3scEFMfJBc/iT8SI6UCXIGt55DBnqSB9hSozR/YRdA?=
 =?us-ascii?Q?PYydhH1QpOJDmPXQgGhUP26F68/X3Z+CqhDVnQODDiRw1sqTg9vFMBCh+zcC?=
 =?us-ascii?Q?IgltEkPI219qZBBzlAPUBVPBIVgaF2gDhREc/ftaTkSduPiF3HS828XvH4LP?=
 =?us-ascii?Q?ctJf2+3anTwYIylkNh5rBgEUuxKJoSESDH44qPQsK1N77EXzLYXlvYJQDqjp?=
 =?us-ascii?Q?KSJxilIr9NRUCxZRQRZ4Omh8CNK5dxLWsPVPpXKF3tStN7LrY3SUWpBt5foz?=
 =?us-ascii?Q?Ca5+8W9rQMWTvrXh3qXRP7cO9HR5dMbsfe4T/hOc78/k2MPPBaxY+HUOJ6Zv?=
 =?us-ascii?Q?aQ3OWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:25:00.4097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e8b1af-5d0a-4dce-7945-08de591a635f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210944-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.deucher@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,gitlab.freedesktop.org:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,wiz.io:email];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 324985CD3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jon Doron <jond@wiz.io>

On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
ih2 interrupt ring buffers are not initialized. This is by design, as
these secondary IH rings are only available on discrete GPUs. See
vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
AMD_IS_APU is set.

However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
get the timestamp of the last interrupt entry. When retry faults are
enabled on APUs (noretry=0), this function is called from the SVM page
fault recovery path, resulting in a NULL pointer dereference when
amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].

The crash manifests as:

  BUG: kernel NULL pointer dereference, address: 0000000000000004
  RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
  Call Trace:
   amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
   svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
   amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
   gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
   amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
   amdgpu_ih_process+0x84/0x100 [amdgpu]

This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
noretry=1 to noretry=0, enabling retry fault handling and thus
exercising the buggy code path.

Fix this by adding a check for ih1.ring_size before attempting to use
it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgpu:
Rework retry fault removal").  This is needed if the hardware doesn't
support secondary HW IH rings.

v2: additional updates (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Doron <jond@wiz.io>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8e65fec9f534e..243d75917458a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 
 	if (adev->irq.retry_cam_enabled)
 		return;
+	else if (adev->irq.ih1.ring_size)
+		ih = &adev->irq.ih1;
+	else if (adev->irq.ih_soft.enabled)
+		ih = &adev->irq.ih_soft;
+	else
+		return;
 
-	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */
-- 
2.52.0


