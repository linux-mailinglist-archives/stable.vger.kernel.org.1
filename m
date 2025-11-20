Return-Path: <stable+bounces-195425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A1C7666C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 22:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73A574E2285
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9D2E9EBB;
	Thu, 20 Nov 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wYB2li8M"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458E239E8B;
	Thu, 20 Nov 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674922; cv=fail; b=EIEcdMbmYM1IqhZfkIkWMFoa2FFhrj6/BGDBpwNTq0aniWDvsBVQL2onBq7fmVnM/DkiXgd2PZmk97yR9nKAdsIZm+TB+jK/EXkZc+99Muy+Y++0HEzExOyxKSWK7BO7ehOyMksjl2ox5DwKHApLp0qVmzWEnBHVnaFZAJuHkME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674922; c=relaxed/simple;
	bh=UMeCf11ZR2MVACE6u8P0fxlNQEnrSNFubc017CEMviw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SR/x1vcyotI4/uDE2DgSKcz26bh2jHvYnCep+vSiVRjEUEufOYSAatScD1Hni4/Q8oyJlrZ5BlqKzaDIR6K5JAKgZpKoq+rGWNOxLit/KL4Uxvcc8gelwlPmHt6lUSN+vyUBrhg0Dw63Ht54Rhq9dB+E1v0RBNrg843Y5sGM0BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wYB2li8M; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShnNV4enkjDRUNWDFqIaZChc+4Olph//59F4VIz7o06G32Xs4HojSVZMefK4hs8KynWsfW/zOqIEriVxth/AqDqkG/iMN/Xtx3sPTW4DAks8wkGb7qEER55aZKnjNSAXt/OgJB9Rrt+WYVIbG5WxTLPvM10dph6upnlJPlYU0zZbjg8sGsx5fo209wwVOWCOCiTbQTH2T3E7a3QVkzgVB2ycEb/J3SvcX7pcIrdWa2aFD8ajOqdsGcAUXXoKqrmtQKDx+XLBBdwaupQ3m4vBHL9/Szp56J+WjCnmBNK4tPwKkrnlnH4ap8muGSIi0KGn3IVs0ymhj67a4bbNVtO3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/ERDym35WJk7eK/B4r65pzEhT/L8/KM81Q0tkXOddo=;
 b=ddXtXRs2T+7tk1NyxT6GRjxptvhEhzlh/4atqJMWcvTDGjyVSXE7E/g2c0oZRymhtuEQn7+/ARO7d3mPq/9JsEDyX2FX/2T/exjd49fDCuEHuy3VLCrZO5ESbYx6g66zYrUpldcA3nia9QvUMFMjeAtDbRk0Art9dvXB7Bsz7pCxwiRHwGtEp4ft/xX4XIthGo9hdTbaNLy4Ktys3KpyF/RhRNj2CyljI9DqqIQna0StV+7dKgrQXLyYc9+gpd4eVA82MPMGWGxP9J8/Qr2gorBtQVhHgF3cPpJjDaNb4lZuyoREnrpGyOyXJPCGPo87PI2VWEIC46t7doNp6TtzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/ERDym35WJk7eK/B4r65pzEhT/L8/KM81Q0tkXOddo=;
 b=wYB2li8MAgcCjtZ83u7iF65ZRiqAH0qwstWUDkquDtrDYvapyLvAFM0Hg7wwk/pKC3rXHQnt6QZU+1Dz7aQbuqk7hvuRildUAdi46oT5JTj+jCul3KyiqPWvczxHqW79XjoJXgT0oR+HPDU7w/ZCigjK/A3d7EWChnVTm5KkJAA=
Received: from BYAPR02CA0059.namprd02.prod.outlook.com (2603:10b6:a03:54::36)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 21:41:53 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::df) by BYAPR02CA0059.outlook.office365.com
 (2603:10b6:a03:54::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 21:41:53 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 20 Nov 2025 13:41:50 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, "Qiuxu
 Zhuo" <qiuxu.zhuo@intel.com>
Subject: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Date: Thu, 20 Nov 2025 21:41:24 +0000
Message-ID: <20251120214139.1721338-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 08910fb0-0dc1-474a-6630-08de287d9ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a54wWhNxz/lS/P0dkxVxVaHe6QqDRO05trdfYJeO5rX9MoVQ0g6ekx3LU/oW?=
 =?us-ascii?Q?anL1oADat0pwZrQ6DTn8BMuR8FvYlFe2prjQmv28lisoorElJgV0uAEFCe4j?=
 =?us-ascii?Q?FJ7XittU6PVCP727T7cZ0sPWvUj1HrMd33RoUjs6xCwa1gsAMA6ueHoft89U?=
 =?us-ascii?Q?BMhlRlso47ldAi9ywFnmVgdVP3iQE3yu3HKKT9xoVtbgwfO94ObF/e7mxaEq?=
 =?us-ascii?Q?mRRlI2NbRCOVYvCOXqixcBeXCxIsfV/qCgtipzZtfSzWo2zbsrXQWEIw8XcG?=
 =?us-ascii?Q?x/F6oV0q+UdTWlmjAqymUPygyQ2ruSNNPUKh9ZbvdQ94umSI76lTit0ybRZQ?=
 =?us-ascii?Q?pAiTvePKynFF8bDVyxeJrUyKeteVQunk3psMes7gWfzN0q+auv2pCxfPZrDJ?=
 =?us-ascii?Q?0KwQUzqmpQsdqSfXm3ya19q3fdMzgfYjamZyt+x9+0uxOhZwXlQFhiQ5Vhdc?=
 =?us-ascii?Q?0UTyKdy/KxHWr9DGd0JDdaCL/yTUlYEOHrS6aARhD2eM/p5O5fimZVdAccNQ?=
 =?us-ascii?Q?AvLaMT6gtkxEcLlTvCv/nGYI/N1faZ0Mlt/Q6Sx/bVkK4ig3D423VXMjr86/?=
 =?us-ascii?Q?UhrC/p0NdQ+yA9yWEq/BnvzLeRyASoynsNySSm2l40oZgYM399uBIYH/1vX4?=
 =?us-ascii?Q?ji6DlmvWCJBso1BloeZ8gud8cs0tjGNAjMpJPD3WWrvuPXzDtdYSHzmi9mP0?=
 =?us-ascii?Q?iRevOClOepTGY2Y0rJ2iuE9FcEWMiac8V68B2KshhxQqiEaeDIcsAbvAOBNG?=
 =?us-ascii?Q?tvSdZ/jT0aejeWMNFv0+FLwPYF10mIZBptZJIIFWSAXtz8Yf04H3Q56Ub5Di?=
 =?us-ascii?Q?RF45NG+mKCzcj44NGtM65Ns61KVItkFo8rvuoHdEK346OwVwoyy8RQiIKSdZ?=
 =?us-ascii?Q?ZvD8wvSNt62zJom+kN77jgUcroOKPS+D2itENoYf9Arhfm3c8Flqhient6Wc?=
 =?us-ascii?Q?tf/5RRy169Yhh7aTLK0bV1+PVG3wH73xUczlHSwhOmgx4gAc4oKhPXoT/mil?=
 =?us-ascii?Q?e0h0T8AJbTw3fgnQMlNtFuEawLXhO3nZzRvDXF2LUqIdbZla1nEhZCjclcf9?=
 =?us-ascii?Q?t3kwdsCWzY5kGVjc09JnL+Xd+e0zEeWQ7UuKGQMoiWYKloXVMb3h5YZIIewS?=
 =?us-ascii?Q?r4xYqThSHQkByUId5G7uslzgbFVugaFjF4J35Y6oqZhQgLueqWoTn9QjbEWP?=
 =?us-ascii?Q?Xe6STZCMF1beGbIRi5m2rRRDWBPmusK2HrntGPYHLxMaC4cAC8SKwC++H0n+?=
 =?us-ascii?Q?Ws9SqPubgt1XkjkXvKlthr10xe0aVH13Wo2a2kLsdwJyuox9lM9V25YkHJkE?=
 =?us-ascii?Q?/gsolQA5xR1eWXuENlktRGAibXuOo1vO3Y1kDF6/WNYAnsgEnhvpu//bZvEF?=
 =?us-ascii?Q?X0qv9Tmmtdfvh2XaJf7Knpaj06pQ2Uv9cxekRDti1T5YgYPgpIgOC615n3fK?=
 =?us-ascii?Q?qNKiMHJoI+YZRqzP+DyRzglvxdS/U2mD5K77zywGMU5mhXXO1HdGbCGmrsPY?=
 =?us-ascii?Q?rACFzzb8Ariz+ZnQN0+O1W3CSsMGgPnJgz2EJCeKYhF/aO266Ct/JWTgOqtl?=
 =?us-ascii?Q?UNuPDUSNAWntFlFUU5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:41:53.2801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08910fb0-0dc1-474a-6630-08de287d9ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per CPU and
per bank. But, unlike CMCI, do not set thresholds and reduce interrupt rate on
a storm. Rather, disable the interrupt on the corresponding CPU and bank.
Re-enable back the interrupts if enough consecutive polls of the bank show no
corrected errors (30, as programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD systems
as other error severities will still be handled even if the threshold
interrupts are disabled.

Also, AMD systems currently allow banks to be managed by both polling and
interrupts. So don't modify the polling banks set after a storm ends.

  [Tony: Small tweak because mce_handle_storm() isn't a pointer now]
  [Yazen: Rebase and simplify]

Stable backport notes:
1. Currently, when a Machine check interrupt storm is detected, the bank's
corresponding bit in mce_poll_banks per-CPU variable is cleared by
cmci_storm_end(). As a result, on AMD's SMCA systems, errors injected or
encountered after the storm subsides are not logged since polling on that
bank has been disabled. Polling banks set on AMD systems should not be
modified when a storm subsides.

2. This patch is a snippet from the CMCI storm handling patch (link below)
that has been accepted into tip for v6.19. While backporting the patch
would have been the preferred way, the same cannot be undertaken since
its part of a larger set. As such, this fix will be temporary. When the
original patch and its set is integrated into stable, this patch should be
reverted.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
This is somewhat of a new scenario for me. Not really sure about the
procedure. Hence, haven't modified the commit message and removed the
tags. If required, will rework both.
Also, while this issue can be encountered on AMD systems using v6.8 and
later stable kernels, we would specifically prefer for this fix to be
backported to v6.12 since its LTS.
---
 arch/x86/kernel/cpu/mce/threshold.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index f4a007616468..61eaa1774931 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -85,7 +85,8 @@ void cmci_storm_end(unsigned int bank)
 {
 	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
 
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	if (!mce_flags.amd_threshold)
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	storm->banks[bank].history = 0;
 	storm->banks[bank].in_storm_mode = false;
 

base-commit: 8b690556d8fe074b4f9835075050fba3fb180e93
-- 
2.43.0


