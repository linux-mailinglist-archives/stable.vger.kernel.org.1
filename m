Return-Path: <stable+bounces-223855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNmiHn/xr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF059249534
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77517303EFD2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200544DB85;
	Tue, 10 Mar 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnKjV65Y"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192953E95B5;
	Tue, 10 Mar 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138265; cv=fail; b=kU2eq8tqIuA4nQej2NZghaNr4V91S127SM0eLUrkv5txDFO6xxDtajqAyU3V4pV4lhV1tXSNYXMCyh7xUGarajkw0cUP5wO1wGMpKTEL26SLz0mBLPg0CKQuWmeN8wRj6aVH+YOmlPhO0R/jKKMjJlXn0Pr4kBW5gFNwwmFRLmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138265; c=relaxed/simple;
	bh=T1IONWk0UhE3eU6oYuLQxIVDm/XVaqsaTRmYPiwGTxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIfHNq3mQfOvYWhjEzbsnC9IKJzJp5X8EU3Olif/2qaax78XjgThihSJE4D4tDNDp5uDvNhgk/gCxdK+irvvnfB+rpEO/mX2AjzPbprnS6XHITKr+3TsuG/KcQkaoO/1peLrbuFRDgMRCC8uWD90hL26DqomT7ODdK/+4Cv0+3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnKjV65Y; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7uZMxguOxBO311Lg+X7pSGZrYLZ0g9ObDF9vyX2g+ptMuX9Ni4L1SoezDJACe/ZU+SmFaE36o2QAuHu71uwEDDN5jBF84j5xFtxEQxP9wYOKmhy0qPnGYn7dZaWufxTTlPEucoKY/KSvOKarqVLk+xObkH4Qkm0t5Tv4U94VH5EcYIvmvG2OTbJG+NoyNe5/OHNsgnJYHuArmQCjVWtnwWek43t5d1fEbsKPix4dbsZ5u5wyufpfFO2Hsyh4dYCCiLkXJpfxzlBCJ+qIiLbGNFoXpeW1liE7GovAhcT1FHj2Q6Um6Qc66MTsEMryOPITyJMoLExpMWFgmiNn6Qf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH4hdhGj3t2o8U5gr9X3Wl338oY0NdZR2Cux9BcQKhM=;
 b=G2WUUhiOqzph/cTyPl83LQPdt6cUPZGyfzSDxmTUyWkKmOOqGxvpMM6gsPyuhiwLCyvn4TXtPjdBOxPENz7X5EQb2k9NJR49xNJo3HmF13LxRBkjGQx3qsDr5OmBplus6cfzluArlto+1mryiXWWishGxMQ5cglHJFDbjGMH9SpXa0hQutulqo7UbHXXnuFKe4kPHqa7n7nMlvasJHpLwi5x69sxMwLcuvmgmQjZ2nPWufCrMK0yGMpBh5vKGMJ4G/Mydqt5dechYFqUmJK9l+vjdyF04/lSm1RqT0Jny2XB8fAsGdgvZd2kytskBX+SLpMkUbc1OnsZMPCxa3IVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH4hdhGj3t2o8U5gr9X3Wl338oY0NdZR2Cux9BcQKhM=;
 b=cnKjV65YLYcPbgHKs49vHVR+dRvqKP1SiHvHah5LIHz1167FX7Ttmy+ZHcf4re5JesrhMF40Kxsb5Ld3s97s1YKFxcf5jpQlCShCGhfBcURDa324+mRbdguzYijQ3O9dT0aLLEboZ9aVoZG/wN9Ljas7Jp0xfd4lvGSNB0tWBF+qJ5ImdZuUjxXaAlPqorrxz+IprMqc+7BZFREJ5w7ZSN7RiDfr2NScLYENXoNcOOco0up+DGJucHQ/J9Smnqscj4FuJyx7tMMyDGlwpULMBOVAxu2sThvwZ93wdnNZro1YHCkxPW7hcSBEGHm6LDRTQwJ6IfX/gZbjGsTQtzUjOQ==
Received: from BLAPR03CA0096.namprd03.prod.outlook.com (2603:10b6:208:32a::11)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 10:24:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::e) by BLAPR03CA0096.outlook.office365.com
 (2603:10b6:208:32a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 10:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:24:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 03:24:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 03:24:05 -0700
Received: from arpithk-kernel.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 03:24:05 -0700
From: Arpith Kalaginanavoor <arpithk@nvidia.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <stable@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Arpith Kalaginanavoor <arpithk@nvidia.com>
Subject: [PATCH] fs/qnx6: fix pointer arithmetic in directory iteration
Date: Tue, 10 Mar 2026 03:22:33 -0700
Message-ID: <20260310102233.391113-1-arpithk@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1871a21c-6154-47a8-5314-08de7e8f2fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	57X5WfHu3JvuANPXL93OpIsv3tWOtd8RonnLVFiVz0v18L0AeH+ovGwvwOgDItxQKa4A/yCHrm5lesjPbflyCs1ok1n/PjyUv1tgN40xfJeqwktzO5JkHjLyCvIsBj1h2AkcRUVLpgnW807X4Gh7j7moCOztFGzrYsapTxeuveyVptwQdynz52pFOP8fCimCeF9hfrJZROIuFSGKp9vcS83sLEFEDFkwRHR4p8VMfIuuk/hn/ecgekTtureQVVGuhwMXapvW+ojaoBXVORMdwkVCzxSs/Me39NRT9SHNMA+3fWtr6Q+kPfr1U64X66JDpEFY2hqOa6kZNxfqIt3vzQGzwEQ1SNpEtWa6eyfaroQ6rnygW3gmdTHzl/QN03yIq2eM4vzSp8se4SDmlin4qQlwGejA7qMr9WpMOsCitlh1GrkLs11L+SurAPTJRzu31C+HvZxjqeRfRuAk+lxSevFvmplwJSohbH/dIgMYrmldgBgNQEGEuz08UqiMir7IFSGoTVoPMn1xyvn4MLyHxBQKxeB6ob0o1MnWx1CFjiXtBX+1kcLp2Pfn1wiIvdcn00AFqKS3/N65UtzGNsDERTjtJeegxG21MZJ1x0B3nZe9fZGCKYNmkZzYdM+hHXnzEnurSmNyc3ndvuFI7R2XvxaeFdkPUOGt1GjmXVk6qi3fHoaq/uJTo3YQEOLD5F/i6MiiMzwhLVDNKEroltPF2Gq8CxDcusaqz5W3g14NUcgaDNg89LRW9b0Bk7Z+jKkezVty2ZTbVEU8CUeO9mibUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5HaM113Z/EotAJnEFS1Nyh9SM5oedOs0cWDcFwRbvMSVpYytDivhTztEeT0DipgHa7qcbGe5bsiY2kp842wWR8ci+C+RKW6NSckMDYan1meigewim6TkPaKMQ/ktMMaRFv0GmXETvSH7yn4eFnyRntgQoQezogpSGiTWLhuh4Qqy2eJaC0PC9UzkM4WGEiQmTebfCNUk01+zBMNcZjI1TImRofVDSotAUJnCXnBYQnzAHGm+5Q47qCXO/POL7AzOrV4qM/KQCWcXHBAciC1RpghXt1d9WWkMnvrjVq0Ju4hQlqlKYnE8XokHRVEx6osPjJIRCziK9AWRdkHOyCpmWpTAR22WvAJ4Ow9XKGJuzewmQ93z+XRYji2sSgtdp59cjM762hpcU13o5fsDFpApRErpVT209LErgoP4YHlj0poy1ZXfZvLceI9OPxv6Bciz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:24:18.2424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1871a21c-6154-47a8-5314-08de7e8f2fff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096
X-Rspamd-Queue-Id: EF059249534
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arpithk@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The conversion to qnx6_get_folio() in commit b2aa61556fcf
("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
introduced a regression in directory iteration. The pointer 'de'
and the 'limit' address were calculated using byte offsets from
a char pointer without scaling by the size of a QNX6 directory
entry.

This causes the driver to read from incorrect memory offsets,
leading to "invalid direntry size" errors and premature
termination of directory scans.

Fix this by explicitly scaling the offset and limit calculations
by QNX6_DIR_ENTRY_SIZE to ensure the directory entry pointers
align with the intended 32-byte structures.

Fixes: b2aa61556fcf ("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
Cc: stable@vger.kernel.org
Signed-off-by: Arpith Kalaginanavoor <arpithk@nvidia.com>
---
 fs/qnx6/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index ae0c9846833d..ba5cae49ad1d 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -139,8 +139,8 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos = (n + 1) << PAGE_SHIFT;
 			return PTR_ERR(kaddr);
 		}
-		de = (struct qnx6_dir_entry *)(kaddr + offset);
-		limit = kaddr + last_entry(inode, n);
+		de = (struct qnx6_dir_entry *)(kaddr + (offset * QNX6_DIR_ENTRY_SIZE));
+		limit = kaddr + (last_entry(inode, n) * QNX6_DIR_ENTRY_SIZE);
 		for (; (char *)de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
 			int size = de->de_size;
 			u32 no_inode = fs32_to_cpu(sbi, de->de_inode);
-- 
2.43.0


