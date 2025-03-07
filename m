Return-Path: <stable+bounces-121335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFAA55D2D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 02:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9453B1FC9
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 01:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9021519BC;
	Fri,  7 Mar 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pji9CmSn"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAE66BB5B;
	Fri,  7 Mar 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311475; cv=fail; b=prGjn7+P/PTzdyfmTogbXiBNVmvhaT/bIurSK/uzkPJed1zw+iind0PyFeRMGbpch4Xh0jHZrO7g/yKfDkCbwwhRJReFgX/kvvLoFDo0kgrcKpGZbkk0T2+bsirvD83x6/EBF3frRaURVGQ/DZCWOc3hvsO42MLU5hiIBpW8vLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311475; c=relaxed/simple;
	bh=RquRjK7P/tEtVjiSAgomrt8rWbCR6y4/9Fu2Sk3ZpSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXu/fOw9Ze3chQsrCS2FzzQOtmihi8lD17OBAR4HrgwfzeswrfAGO0m/cpT0SImhFfrH0LPzpyKFu8uLyGlkzQnpO1EW/f4r4ofBR07a10tPtqJxcdXBojTaMxs1RnV2CJPiTcZYvYhu0t4D5h3bvribW9NQ52z2yV4V0SAutEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pji9CmSn; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhNK3DF4Wv4f24R4Or/FTZxor5EDKmoYYlhgGSO1SaMZnghfeH5WvoI+LEmIOZW/6YAYnxRVs2VQTC4QaYhvvQDsKBO/e1uXqI9MDn41eNF4NQOydb9KGYrzWIjLdd+VSkJsCvuxMtr+PNkOpYVeOdLom/3bgRQoJIxNinN7Cx57s3W0yboD1XdXsBcvJEn/yy/WZmCDFj18Y1aqPkiaMMaOn/CPjvjVTBjh4gIpx4p0weKufY33xlV5el9VEDYO90ks+xjWSG9CvUNzqljPSbMmf+XbyQYvIWDU61+RphQ4r8UpG0EsWusO3yB4UiWIOpfVO/FcbOBhWBgXqi4NzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOIfJhfX3mdR5A0gXzFBpu9OxA1L4tXhUL3eMX5fK60=;
 b=mAIbWw61RxiYhFRG2lHRJTZARoZ5CbXoqENZlq6ZcvT7MRciU2H3bc1lG75Pv+dySnDDxT5gvY1PlSIKRMTQcsLbzKNlOmNDWns8s+jfhLs75+PE9uU+rLsNZa0d9j9exg0joA9j+Au0O2ar7nUbkYHHVX2UUpxrnP2gcXCHf0XnZ6UkniJtaIdGRhCIsvORrqn3Vs1+5OoeYBXwG5iQjF+2Q/IFXOxZVP6HX7U/TIh0B9lbChrvoDhjMq4xjb2KpZyYJj8qI3v69RPPSEmv4GtKeURcD16jzmjSFBIY4y072HYQRNMIBdnvGA5MEJrmO+cYMf21pYEgPugKiVEcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOIfJhfX3mdR5A0gXzFBpu9OxA1L4tXhUL3eMX5fK60=;
 b=pji9CmSn7nwa1j07LqozwNjqp2jxf/IJunARb+0R49k/nkND8ugrJTkSI/yPYr6voeQNsAhJgzb2XkQnba+S+JlPvwlUJeA7q8uI+QnkU1hLUSyfKZoVpBP0qD7Xm+MvtMp5TmYWbxR8fG0vocEAAj9mjfBzTS5YJIGVKP0k14E=
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 01:37:49 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::8a) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 01:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 01:37:48 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 19:37:43 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Ard Biesheuvel
	<ardb@kernel.org>, Pavan Kumar Paluri <papaluri@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth
	<michael.roth@amd.com>, Kevin Loughlin <kevinloughlin@google.com>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
	<liam.merwick@oracle.com>, "Alexey Kardashevskiy" <aik@amd.com>,
	<stable@vger.kernel.org>, <andreas.stuehrk@yaxi.tech>
Subject: [PATCH 1/2] virt: sev-guest: Allocate request data dynamically
Date: Fri, 7 Mar 2025 12:36:59 +1100
Message-ID: <20250307013700.437505-2-aik@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307013700.437505-1-aik@amd.com>
References: <20250307013700.437505-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 02455609-68f9-4bbf-8fcd-08dd5d18ab2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBGFb1oTBem4+1VhHTCxzLU0lN2VusEGvQr2yFvBgbqTR8kCWHNSDLfHnZol?=
 =?us-ascii?Q?dQlwiJBb7cbChRrqUA4jCK7RVKB60HQOMq7hbmJTcGLJZOsn4xsgWukFkXsR?=
 =?us-ascii?Q?tYsO7/3QvdafZixot5N1Jq8SJFalCJeoYreHJewgbSIRHvl65iaPIyWxW9Jv?=
 =?us-ascii?Q?zw4itdSDfXRVz2OsdxzYlFvl+JDUSK/Sr1MQJjhN9kQAoPUTznlA79VPVvcN?=
 =?us-ascii?Q?5fJC2eLD+FwSXd51E6epIvn8LYQUq6gQMUWeKVbuXUuWMs7IZM65YUD6S2Wk?=
 =?us-ascii?Q?1HrzgndHu58W+2kJxSdy+DUL+3xmUwII8MKymeItyJMXXWwJWLrKXfIbzST8?=
 =?us-ascii?Q?Zl79cPlpUlr7SC6hjSPuCvoPpm6FcZrgeJYzX3xCPAkbanCSLQLe93yR0B/y?=
 =?us-ascii?Q?optJpFcfd3KFIRdUmeOP9a5FSC+l4CyRf+4vZV/FJdoTYwdkAaAhl2n9KwtC?=
 =?us-ascii?Q?9GpFVkTHjuI/TwA3wsNwuuI4TdiWRkGN6NoHu9NwK8DcWwlEaUYHjJMMD07B?=
 =?us-ascii?Q?p/e9ZlrfYxDtAp6B1OxGQmVUWVK5Kr0wP1byfjju8EbPGQIwyHNPnNLzL9md?=
 =?us-ascii?Q?EFZedSxCgvEOaIBzjCEI8CFYIvCEu3/nCmjghC+fo/+3fogwmhU4boQvaiIn?=
 =?us-ascii?Q?ATaB2VrqSLdEtwndRN70dOeCzIwaulxeT4EWskQbsa+0FPB3Gdpw7CF1X3hB?=
 =?us-ascii?Q?reh+0cej9AhC71c9kPsdhY2Dt+wkTwvcSeKvQ0r9I428cDV7rk66rREc577i?=
 =?us-ascii?Q?E5okuYvOC218c8cLXzuKm2rSJVA0tzh9da4aMb7Mhm5k8O8UxPlREW5bgJfb?=
 =?us-ascii?Q?e9DRAu3SN1DTVsrF5r5bPByHWHWRNUuwOdy6HcMwP0L2sZtSff8onFjBZQ/+?=
 =?us-ascii?Q?2zNU2e2o0aXTprtc9PR2SbB6ZFbLGRUZ4T5Kblv20VZpDQe7WTzEP4NpQHW/?=
 =?us-ascii?Q?4zwN6NRGnApSjE62pdUs6GA7awTDEIioRnTQuywX74jhGMDJfWaM2xTfO5WO?=
 =?us-ascii?Q?ZPLNt/bSH81U/EaH41DeusOH82yuJS8KlskKnJTwb55WJWoaDERTs++TyqXM?=
 =?us-ascii?Q?ANTzOWHY4qblGNf+PbVXALra5upleaVwRJCeCyTwJ8YaeM7BZlZiLea2NmVm?=
 =?us-ascii?Q?g58gCUkmZtQnuU4vYRTQPaJNU1g1CzAYIyzWFKzDPA+LVqaixAKNbgTOWGu4?=
 =?us-ascii?Q?W7b+5cBoh3hdimVMPgyOsRD4Ir9QA+/2R5MSuAOGHbJSC8bfGdWoCaSef5bW?=
 =?us-ascii?Q?GWvoz2J5RwTbF4IJArRSDQYMWqEAbPlu2MjwJE6+IjZX85NZHH3oGwxU9E70?=
 =?us-ascii?Q?iXzMX507DV4ceKuGuxHX9U2I5ySkTwCfGp8H/iqtxZHTXnlAc9qOrksqaqcX?=
 =?us-ascii?Q?86t8WNyS1U/4SkWLVKXt3sk74f5O0MPL0K9eEl2DUQMgeK4sNH3xXBITa6WD?=
 =?us-ascii?Q?sza0qF40NjRI+UE+k3L5+swHbnZETEGQLjfkAGFg8iyy006V4+pGQsS9cf3g?=
 =?us-ascii?Q?O6bjTzxApIHUR/U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 01:37:48.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02455609-68f9-4bbf-8fcd-08dd5d18ab2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

From: Nikunj A Dadhania <nikunj@amd.com>

Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
mutex") narrowed the command mutex scope to snp_send_guest_request.
However, GET_REPORT, GET_DERIVED_KEY, and GET_EXT_REPORT share the req
structure in snp_guest_dev. Without the mutex protection, concurrent
requests can overwrite each other's data. Fix it by dynamically allocating
the request structure.

Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
Cc: stable@vger.kernel.org
Reported-by: andreas.stuehrk@yaxi.tech
Closes: https://github.com/AMDESE/AMDSEV/issues/265
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 24 ++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index ddec5677e247..4699fdc9ed44 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -39,12 +39,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -72,7 +66,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -81,6 +75,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -117,7 +115,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -137,6 +135,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -169,7 +171,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -179,6 +181,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
-- 
2.47.1


