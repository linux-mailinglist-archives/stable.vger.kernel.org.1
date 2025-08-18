Return-Path: <stable+bounces-171613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D6B2ABEE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A49205D02
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B5233735;
	Mon, 18 Aug 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qA4iSU4D"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2512080C8
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528884; cv=fail; b=Rka7apN0pZa+zjlu+TuZ117QFE9Jg8CxOLVfCwMAtPFT1lt7Bg3uniAKkgeEGskvJf0+zW5qBNM/pal8b9ciX93fF0h7DnRgfH8dosp1POizm1AKWHc8Abr4m+xKqyKHZqSp5+6M5lT7QZzn5IhRnLMwiPstykSa+vuZK8wfU0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528884; c=relaxed/simple;
	bh=hgkrra6oARtqaYu38RI1fca3Y+yg9V8yJuxMYEMMOAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZUq7TKm2cW/QqPu5F3Bscup2lLK+xWnB4b6eNfwAxpvKHeq/Q4dAsnOBrCD1mQmTz+UaCUxZYJkJZVH77chKuOAW6GsjYm+ZPisJAFWgJhhQFa7lfHY8zO+c/bD7fJhcJLK/RopkZb8GWjmeOYP5HfVvd4fndtq9HQYRTI5+ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qA4iSU4D; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3sSpge6j1NEsf7UugIQ5/vmppLsmNwncMp0FjHExUnXhc+IMEsEO3a3SqtBKepK5UEx09IvNRMuNOCqvOt1FZxdY4jmLA32Zz6To/UrWaU3fSik9TacqxT/FigSV7Pt9uKdSjJcSkptbBW7CsVylNP0jmUIl7ObZxh0GY9bww9DJK7NF0xRelQA3V6brWwBbpYgfYzONB6Ae87l1NjQNpAXN1Nu5FHrEtN0yPL8Mb4QQSWU9X9Rm202BcAWLOYqFJZxEtl2aUjb5/mbGNSswA97bJUXJSINF1iHDPUCx6i9TBhVYsVOy2tv3FKcrIDLnNPSr/1QWBTU2YOCrs8Y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHMMLEljRMbzi4qM84liTkfiT7ZYOJnMphVUwX7S4+Q=;
 b=V2+mc/8JuEnnwW1pH9kBSKIgN62qiiFpObxRXq7YyldnUMBofGe5Kn5SQ8zWy6Mlsgh/5Xw9mT0UIaG2aVP743mBuF+6RulQF/j2fu92Cd0zHvqggqtQlgdx/WNMzAVYRQW/QCa86OXnQqwesevtYyOB3Ri+mDGSvesdRWeAX1A2aoeKLjwBHbZz45PMIHa44pV92nPvZsR20/wgZU2jqoPnlQac9udH6yv7KhqtfFFnKbF4rb/Dpk1O7g7vbyaRYfd2AWEoFuW+crS3ejSO0R1+ffMr1wYG3/tAJB4lX8f/zKvLC4tQsaQXrjpoZKhxJmx9OJVaI+vvukYFRa2lOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHMMLEljRMbzi4qM84liTkfiT7ZYOJnMphVUwX7S4+Q=;
 b=qA4iSU4DehrJchteftCZpMQ0RwGqFzvC4m+mfeNiQaxTURoOUKJBFwEAn7OHSuvvngu7TG4DgTgtejz//ZYE58frfbSNtynxPaaT694jaEV1ifwS2ROBKSMld4E9gluCf1MQZTPu49glONBOfWyZwwGX0AHHnThBO36lvIN2wXo=
Received: from DS7PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:3b7::11)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:54:40 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::30) by DS7PR03CA0096.outlook.office365.com
 (2603:10b6:5:3b7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 14:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:54:40 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:54:39 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <stable@vger.kernel.org>
CC: "Borislav Petkov (AMD)" <bp@alien8.de>, Joerg Roedel
	<joerg.roedel@amd.com>, <stable@kernel.org>
Subject: [PATCH 6.12.y] x86/sev: Ensure SVSM reserved fields in a page validation entry are initialized to zero
Date: Mon, 18 Aug 2025 09:54:28 -0500
Message-ID: <20250818145428.3774070-1-thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2025081852-debtless-penniless-395d@gregkh>
References: <2025081852-debtless-penniless-395d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 5509e677-adc4-4a05-a134-08ddde6728a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9tdUKXWDORbLVOMG5lIOc+a6DggMeU0MqKFXN4mUt3fFCxlmtTRGOWcdUs2?=
 =?us-ascii?Q?DwVbLJZBKElwD8Chu9/0wDMrH5NlTMSc2JSdflUgBY9irNnAxSCPlxnNyUr0?=
 =?us-ascii?Q?WLYii2eWQ+TSZGF/gReWlSoI9HkEu2GzqewhFoQz2UTnVRunsrIjo1Kt5ORY?=
 =?us-ascii?Q?xp98dfOuaEtfqJ3zVdGT4zTAFto12Uxy5ugsFeShS5tm5fQANeb/IZKC0Vdc?=
 =?us-ascii?Q?Z0FwOey6GWgnwL+U6+BsMqxDFLXjIWhU81sQiVbDIgc9Em6adWEkt5YyLybx?=
 =?us-ascii?Q?uR/mAv1lCIymiubmNMx/Grg4AGolH5lHnkcmaEIwiSvk8uvjd9gtr5RHMVlx?=
 =?us-ascii?Q?KHpzqTsPO5h1qtnWfytUwF0cUrf3rVHPDn0yZpddD0+L9HyvvO80dwtme0Kp?=
 =?us-ascii?Q?3/xlaB/vNp/CkRqD2Dg6KaXOSY/LB1Q628Uu4kncL8YpxTBioqNQ/fP0PnzV?=
 =?us-ascii?Q?1f0LNDJUeDLKaSoffWcKDpPBKiF9pWdgR6R3v4YQxL80hf1MUMeznBSwaoQS?=
 =?us-ascii?Q?ZobpGZtpCPFOTd0KHl/gBPe548M56sQSoqKylFC9G+J7l1fEB5Uwgm1Yi6rc?=
 =?us-ascii?Q?EigghM9RK7H52nL3vN1RWQ1he4Dw5d/g/2snvMBlpzNzChr/AsJ3dNPBSqpm?=
 =?us-ascii?Q?2Y1d5ttNZAks1HEJh42bLNE2Qp8p+eXFxN6JGYHm2PhgbV1jW19NF0sL+ZVp?=
 =?us-ascii?Q?eBLy72E9ZDpF/qETCX8XYKVduVDIW0yuaSWDYfX3Fo7a8ARePE8y50ZV15p1?=
 =?us-ascii?Q?dCBD0h4c5Jqozlpm/tkHrAdBw8mSumZnXpkTnXXCwOcF6ECRaQrm/4V7JNgG?=
 =?us-ascii?Q?CC1Zg1W/ZZgMnyBq3yqfhg1eFqqP/eSYqEQYBA+stpkhNlpSYn8mKLk6NKyW?=
 =?us-ascii?Q?N3MsHu3F/ZNRLktEp2NL27YU/3KWgtnYBphqw6b9zqOJjCybg6ngICDrZcro?=
 =?us-ascii?Q?AGegSh1wVIZKqnh14P/75QyIaKcjHum6p8sgFXu5Xb7PFvTyE2XfLTADmsvN?=
 =?us-ascii?Q?ne09hsXs7AzQYB1rE+5jY3juTrsMtb3g8Lc5bbNjYjyXcRc2LJcotfVuMvlt?=
 =?us-ascii?Q?9alXoX3R6EDjwFM0JFDlOOAExbYZSimgmwjQiAIwctfHraRv0HgZYXNvq088?=
 =?us-ascii?Q?Ek2rmsgmsbyDSLDeVfjcRt9N3b5IETbZWy2Z81A/bV5vcFk3mYCnHGINT+Ni?=
 =?us-ascii?Q?avyH+F4r0Wu4aOjR/bH67YrXX+xxh96kYgCQmMavyzmTc/AHgSgnUOPF0RmL?=
 =?us-ascii?Q?hZZbg89OXDWvPi5Yi/QU0NQ/nUqlAYi01MlVZSFHpPnfBAd1S58N1nA5L6SZ?=
 =?us-ascii?Q?9+0yBj+08beziaTVgGjyx/mgwy0+qyxyrNi9iFsoszAFs1UBWkuTQ4zn6UXF?=
 =?us-ascii?Q?/psa/DM2eOg78qyCQYb8fQupZ+haFmdfkDvko5aXh28gCOWeD1ZNg2NNu7L+?=
 =?us-ascii?Q?WXJToZvQJWBPIeaN5+CCqXyqhYvIoKqMuU4RAirF6fOfT7023hTGaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:54:40.0415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5509e677-adc4-4a05-a134-08ddde6728a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

commit 3ee9cebd0a5e7ea47eb35cec95eaa1a866af982d upstream.

In order to support future versions of the SVSM_CORE_PVALIDATE call, all
reserved fields within a PVALIDATE entry must be set to zero as an SVSM should
be ensuring all reserved fields are zero in order to support future usage of
reserved areas based on the protocol version.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com
---
 arch/x86/coco/sev/shared.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index f5936da235c7..16b799f37d6c 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1285,6 +1285,7 @@ static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 	pc->entry[0].page_size = RMP_PG_SIZE_4K;
 	pc->entry[0].action    = validate;
 	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].rsvd      = 0;
 	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
 
 	/* Protocol 0, Call ID 1 */
@@ -1373,6 +1374,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
 		pe->page_size = RMP_PG_SIZE_4K;
 		pe->action    = action;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = pfn;
 
 		pe++;
@@ -1403,6 +1405,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
 		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = e->gfn;
 
 		pe++;
-- 
2.46.2


