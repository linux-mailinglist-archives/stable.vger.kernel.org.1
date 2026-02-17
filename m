Return-Path: <stable+bounces-216836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPqSEUN4lGkDFAIAu9opvQ
	(envelope-from <stable+bounces-216836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:16:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995FC14D121
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9718D300B9E1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47E31986F;
	Tue, 17 Feb 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFLPoTTS"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F20296E
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337786; cv=fail; b=siSQ0eNSv/Mg8HXP3sC6d9jaSbwdQlZxR13EEKwCVcg5Xbe34ZcfCro28y/cDFjfDN6bJ5QU6K/WOSpmaZWEC/HhFIzXweW4wrRrQyK1OuLY4zxXEE3o6yox6yESQvzivcKplFaouwsfRNGUqRV6AIifUaRAd2fMxxXR3l7YCoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337786; c=relaxed/simple;
	bh=iAHIFMnARzLJT8Vx72fBQKs8tsCd6YaSCcCjvtwHfB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkYPq+YZ2kHJnjR78z0GOYWPytV2IZNGjmHcNP1Tek0Pn6O6xHYuwOECbLTUegK4FhdQ8HwIhalrtPBl7sCLNWz4gn/kreTNJtBhhz+R6zAPTMzhZJ6XU8BQqBBWQZr8o+3/at47wz9svO9OKYCGDwmZBfsdCGpHWJlzA8Lv3BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFLPoTTS; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP/KiqcwBtvkieQwiwqPpjABTnJSksusBVYPbY7AwigJr595+h+eIcWzkbsZb0VDsltro+ZNtdrv87vjUtjh1WdnyX9drQsVsCH47LpDVZtNKMAW43HJAJy05xa5mwq6kezMKXpnZVspjU+fAz16971pqCqO2PIOaFwGO3pUZKNA7/Ci5LVbbKQa6BKtZDVTkO46rHr9CPrX+nvn+YkB76iZAVJdbFj6LKt4CUF+9qU6NHdCl1n2nWHlGLJFBcLw42kiUL2rMb/9XhgMP1N0G1IXxXfYVDPizcnBjJ8StVFuFCTSR1ntyMtj5ZiudyUx6i/FErrS+ECDJjMy53fNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wup0bnMyqhoztO/dn6k6taZ/1rE6ucM8rKm2YsM8gTU=;
 b=fDMiyfR8YuyhIN2TU8NBVF/aSwABBx4kKK2QwzsOfm6w9y3xr4CxKp8gOpqL8sLW5AiiqtdBU+U5bGRk/rLYfX71yEWYQwIDR3Lj6dvHKMQTurM1+RZ6rJkf6N2YpvBjxzcB84HvKyIb7ChzoleIeVHiF3UiwwFfCktxab7/u2FHCjhklForHk67zt21EbXMFpAHfrR4G/RQ7cYcjyw/43TMrz8kvSFnX1lP5Xa++03W4h5vxu0SGHcl/VvlfCliZPRwbj7QZazGNgdOgfsT3qqsHKx99axRZ6KMcyOHXrnjw6K1BPsZBwMhEFCIYD5140Fz6HzwnDrc68YzFyfuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wup0bnMyqhoztO/dn6k6taZ/1rE6ucM8rKm2YsM8gTU=;
 b=nFLPoTTSIkPKpInS9+FAclY0IaNX6UQ1lzqPLi/5Fz35BljMKJXcmsewz/JZ0mUTMCd7bNH6mMXSahVMAzWOvT/ZzYVbP/gi+f5pQn43vV93EpqAcsQVBXJ347OhS6SFCDmW9KuXL54chpPQxOjoCgVmEM+dEf/g41zc/lOZ2us=
Received: from BYAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:74::24)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 14:16:20 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::5a) by BYAPR05CA0047.outlook.office365.com
 (2603:10b6:a03:74::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 14:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 14:16:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 08:16:19 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 06:16:19 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Feb 2026 08:16:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Kleiner
	<mario.kleiner.de@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: keep vga memory on MacBooks with switchable graphics
Date: Tue, 17 Feb 2026 09:16:10 -0500
Message-ID: <20260217141610.38444-1-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4f55ea-5813-4928-18f0-08de6e2f1f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hkE8U773QPy3G5vN4NDAyaV9prD0xndeOxOArcVaGjhG6udTrbv60faJvRv?=
 =?us-ascii?Q?HlZ/L97NKgSBeHSqVstfOzMr6bbpUqIcvS/zDM2Qq1jt5eUT0ZxNhKSuHFVq?=
 =?us-ascii?Q?rbAYP2MQwydqTMh9f5ub1S77ra4o4JXFTp7jwPiO7+uKt6dksqOPzof+lQQo?=
 =?us-ascii?Q?KR+PU4qkhfYy++QJsnvX//zRi7DPZClDjFsWV4GZiaviBFr4A7OIJrXwX7+I?=
 =?us-ascii?Q?AIqjeuFow2RBc+Rqz/COEGe2OUVRbKO8iv9QNuYmEF/cgZN9cDwt2Sm2Zb+G?=
 =?us-ascii?Q?aCZ8ke4SuEsRrzkqglAjM3FKt6my5gHP1SDjCC/l3QB6qwa88/UKlxLKf3gv?=
 =?us-ascii?Q?iTmpNB/YMXluEGA93fins3uRoqky9A8jNUlbc9dBAZF2ri/KNouxir8n++Xr?=
 =?us-ascii?Q?VxQpil5/HmyBsaCXyL+jWLlWpl6zoOYKDfYSUZTL8WaOHR6q7ECO3NzB2WQ/?=
 =?us-ascii?Q?crcNier0xgSCW1FOtcvS3GbRJdOiRMGNJbSFL7+VGWAJMe1EvMYtKfr2QV5Z?=
 =?us-ascii?Q?u/RHwG3myvz3A8ord0p1EwxmN3R4HTUeOfEYGeU6bDZsXTPDeUv+ygZvuFXN?=
 =?us-ascii?Q?BIwfxG+2XVNtPv2NymKfewWUqcn3Z/MThm6V4Lbt8WLaGnlhxBbwQyoRAUcQ?=
 =?us-ascii?Q?tVtKXXlPV3WCMUOVgNZPdhwkOJeLtlY2GCVu6Dl2+bs0pLUJKbkMxRhES4BP?=
 =?us-ascii?Q?62QbMlQuaVsnMyKPTDgd/uoXSJtpitk4i3FcEMUJ/tEFpvDlyHy/Qz1WMJeO?=
 =?us-ascii?Q?M7718dcV1CPnMLbjGxyw+xpZYNbrn9F7wQNnYgiw2nCsPmAUCFGxq25QAdW6?=
 =?us-ascii?Q?xJK5SHEz7Gm7Vzx0IZhLDMjPqRQ18lAVjXdY2iuYoWl5ETx1T0jdZSrfscvc?=
 =?us-ascii?Q?c3XU72l4VWhZxSjaMCbs2jwCrVsfL9FZT3/+jJnmOwftJG835T5olRCPgxx0?=
 =?us-ascii?Q?G8cdGtz9ujILWg04HB5haVnOKJ0J3rLMxc7AxeTa+kagH8wh/ACaojxDsn14?=
 =?us-ascii?Q?PG2lltU6cIjxUCAqsdpgxQK5ZLeqOZgSODV3bgQ4FrJkajGlfEKjbmBXMoo9?=
 =?us-ascii?Q?oR95UNKXHHIXYzNpWndfB/AI5F/+RhtNsFeWJAEjTqicGilRwpQ0j+nbYPsh?=
 =?us-ascii?Q?xaOMwfVvFKAIvpAsnopw/jilmDiihKIgdq0BrgbXHeiJ50X4Q5A3C4EvPgNV?=
 =?us-ascii?Q?s/9Fvu8RVTbe6AZBQ/u5wngZec8AiGphluZcHps17NQedqR7pKwgZneRKaT6?=
 =?us-ascii?Q?ijeoeTwoXOr/7HKJtUXZUbQjTO8+9mq8BiRj+BgaStwNQwY/YoqZG3BTP3rw?=
 =?us-ascii?Q?iafCQ8STQiNmxT29OBK/iAUlyEMAKgfPfwEG2Dc4GctLIvK/zDDL0Prxcw6K?=
 =?us-ascii?Q?O3JPHlZvLFI9+WEp2UAkIkmTZk5xiQNDSc0XgQ4DxYGcx0a+HEfKLoDOPpN4?=
 =?us-ascii?Q?10DZQzt2DFG9kWyRJw6wh7n89guFYkoRegpNIKa4HfCT8+JnAgooa+J6H0AN?=
 =?us-ascii?Q?7Yq7lf4HGxtOTyEapHd/5oxq60x8p8MxZOVo2LLSdlGBVNcaE7LTTFRiHNdj?=
 =?us-ascii?Q?P2vUKpaWeFjc58+fk7+CDKw5vJuk3hLTjjP1VT9RuAW5P+xxVSD5wm8FiBUZ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GVR0VVw7zc7YlXQmrTWAovK7m7y7ip/ocojk6xDd9/1xK8TBObMRG2KLkRtUw0fANzGMeTyvXtHchcbbWgRbFeynD657/0ILNJ/Oq9kmfKko/CmLkfV/obsjhA+BqQhSzM4LtVVpw//jsC1piECn7TQJGLS84yXs2remNoSUYI21XP4ieUgHt/xjbshGBPJTITk3QAco4wkGN3/DRJucnxalpm+gVCdAxwI6HlsU4ccdUnfIEFCT759YdDg6wI9HbRQEEKQjzl7j0aPKA5294bVGMvmQDvBnvZv6x9pTgUEJIv9a9lsiD1NkMPSjb7Ln5rJV9yiWazvS8De5Z0cYBiaWnPJRuS4XyBdcN3H9jQHHRYRcjxBmD7k8hvOZGxQy7J2FAtfkM/MiZIN9aLYhXavlg1bUIlbwoNx3e0QelKdzcooro2W+oj3sIIO2A4vF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:16:19.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4f55ea-5813-4928-18f0-08de6e2f1f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216836-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[alexander.deucher@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,gitlab.freedesktop.org:url];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 995FC14D121
X-Rspamd-Action: no action

On Intel MacBookPros with switchable graphics, when the iGPU
is enabled, the address of VRAM gets put at 0 in the dGPU's
virtual address space.  This is non-standard and seems to cause
issues with the cursor if it ends up at 0.  We have the framework
to reserve memory at 0 in the address space, so enable it here if
the vram start address is 0.

Reviewed-and-tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4302
Cc: stable@vger.kernel.org
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 56e46238e6723..44ff800a57155 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1067,6 +1067,16 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+		/* MacBookPros with switchable graphics put VRAM at 0 when
+		 * the iGPU is enabled which results in cursor issues if
+		 * the cursor ends up at 0.  Reserve vram at 0 in that case.
+		 */
+		if (adev->gmc.vram_start == 0)
+			adev->mman.keep_stolen_vga_memory = true;
+		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
-- 
2.53.0


