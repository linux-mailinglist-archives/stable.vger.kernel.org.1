Return-Path: <stable+bounces-58245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27392A914
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93971F21B50
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508F14A4F0;
	Mon,  8 Jul 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M+zlEjg5"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB315A8;
	Mon,  8 Jul 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464100; cv=fail; b=YBRUTUx4/Emb7znXtwVowMz6Kbz85gUlIUzM8+h0mWOwnAuPQgnfo830xL9oon5TzZQJ9QSKSfc359gQCCNFikarljU7QpcIf36BdrMqNclLKxIMW44/KN8RG/If2P2vuF0GFLZzcBCCXajTZhfbyoESOolOsLBQTl8cx9Ov1mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464100; c=relaxed/simple;
	bh=2WZgdKNtpW+OneTpr/XXQ2vXPaQ/z07eBoAWoBv/r5o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=um6XdMboMxKDvWGfV/vl3w5qL/vvY3ktzEjLUpi0rwGvc0QCr7+gi+tqGHT3T8czTElv0GCi+BaF4VC/zxh4p7PwlM8qf8hCkTuW1LeMFRY2XgbePHfXl2f/G1jDGHLtNPXRzuHySuQeXEkOiszbDVZKQ0i09/9umC6vp7UYDdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=M+zlEjg5; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llIPk+xVJHo6tI5E3lE2ZbavwqfMvjdPy4234lDTkY6HSOm/3ZLFEWN7+FKf0UaPxg275GLxX3+Q0i4+bsTDkHJkSbP7bQdG2oDFeQa9bii6OzhLpxS4al9OQ+Lh51NvFefRtoIjuFj5bn2orNKbUHt31q28+l9mCJxv02J244pLtzc6JfvjtnUeGUUnhE/7RVLZH/dtVC2RRZAvjA4J8bZIcI5waDGcHz0LKW4/HjR8qw/e9so0Zyl49TpDFXrZzPCzpPHhIrZLCz9+HLZfjsjOi2JBFKUvJmy5x/kzzhhi7s/71rmEQuDLfzmTuUS6mXAc/md62JLHP8jCKcucVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhM3jk0nTtrM1qoyGwtf/AwVRYhob+LTEmey53LszAQ=;
 b=xY2aGPot/jtFUTaaA9SBrkXdvA4OwuQioUwU61fFO6flgpmJT5IywyKXjtr7Er3oYLW2oVA/8OlGDkysu9VzhI0p8hNsLgYjmf1WTFDNVyzS5KAXweRP69hWx5d8UPC5HxtGcDBPl3wjDiBhJNcicfRaOxIH8KlIJrJa48/DDmSoCFQU+gNNMd/GM6Ocj2rwOIijLiSWndefCOEZRDl47fUNkyShGx4paPXwwv5kCO1zZYXHeVr0AMx4yHB8TM1/axYCaT5WMyAawT0iB6LmAB6CLTQtZzvIGCpYVDLQ6f1hpd1D8ECj/8EIhezTN6ppUpLCNlngN1Kw7Dch2YgDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhM3jk0nTtrM1qoyGwtf/AwVRYhob+LTEmey53LszAQ=;
 b=M+zlEjg5fRtMowmTYQruLxVV1PGd0MxCf7+OXuEBGKDRBpjhx/lvw92bHuof/3dvpzlaRdbpV8XyXYrRItJQqHlz9U70rxbnhQD3R/GXOjntJnjIG/viIInF8LT9PHkJ2+DTo4HqDzPOav0shJSLe0XxA0zVzaRRlZdwa79+sxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by MW4PR21MB2060.namprd21.prod.outlook.com (2603:10b6:303:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.3; Mon, 8 Jul
 2024 18:41:35 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::d498:7336:91d0:7372]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::d498:7336:91d0:7372%3]) with mapi id 15.20.7784.001; Mon, 8 Jul 2024
 18:41:35 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev (open list:X86 TRUST DOMAIN EXTENSIONS (TDX)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date: Mon,  8 Jul 2024 18:39:45 +0000
Message-Id: <20240708183946.3991-1-decui@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:930:8::19) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|MW4PR21MB2060:EE_
X-MS-Office365-Filtering-Correlation-Id: 86679cd6-df82-4101-4225-08dc9f7d9764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5HV5p+Ip+h43SwdMQbqh7ezsuFyIb5/64aSK/YD1j/Ht8Y+fycrzTeHyZltJ?=
 =?us-ascii?Q?faW2p2xar3w9BL+ZNzpSwqOnO6SGx9Oyhrgwesf8r+I5+wXDZ7IDQH8V4cO6?=
 =?us-ascii?Q?KYu8OxyapTPneKYjF8jKMdngoAV3zVA8GUmHZBjpoGcN1nosEIijOauTFOVz?=
 =?us-ascii?Q?0zglvzvfPK8bUnZe3INSs4t8ULtf+hKd1w5qvRICg/3m9+guYraEB3I79S2j?=
 =?us-ascii?Q?QKNP1XrsjCECzKyJj7pJGk3hds+YSA7wuLzUPLH8oS9ZndJ2O3fAU4T27UXL?=
 =?us-ascii?Q?RTvbBUi7D/NY5UpMJiytijxa7GF79LR36RokM8F1jB6Ms4KE83u5boTNwbPJ?=
 =?us-ascii?Q?PVmjkW4WnewBXvF76ABEuw5xDHQYkspautbuvFX6OkHO/p4Ihm8DbwTyJrql?=
 =?us-ascii?Q?9A5I+uSUBOS59ZhMNYK92OvCCBRS5J9dpe4YIYtgrfwJ7v5kEE+UzvgwKMyq?=
 =?us-ascii?Q?Fi3MG8iJ5qXqs6svauu/oYwgSngPQETymFX77+toJgI+n3NvrwQntoFMZKm9?=
 =?us-ascii?Q?OE2K+P8yctROmsKhN3zNkS2VvY2v3+2+/TZ0yVpsmLI0WgWuIN5gE/yqmtov?=
 =?us-ascii?Q?mbREJVqfUBwd/qVtdplHL3+6w1fsIjboLNVynWnPnqelfVFqU1dIQUW88Yo+?=
 =?us-ascii?Q?hsPM8a+lFfrLh4f8GLS5CXtCJsJCtQf7LU0tZelu+3iozTl5cPYJZIWxi7NQ?=
 =?us-ascii?Q?6PG+2ijZIPKIPIyz9zYLVTwmOxFKXb6CgkHnhcpJIcRqCcmFFCjJx51rtxDc?=
 =?us-ascii?Q?YjDZvyx5roo2YRJ920v6Xi4tj0KT5xoESrzZ5bmby3ONlDrC54K7dBhcsPEd?=
 =?us-ascii?Q?SJbfYt1A9b7mgFmbztw7mz2J3qgvekuwJRE8LC0MQO5jePqDKcXpAAdGNgeL?=
 =?us-ascii?Q?cjr3ETkh+GplYiBx2kOpvoyTMPmTqofp0UygfvkOctKTrQbAyjqwdECrIwz4?=
 =?us-ascii?Q?scPcdbz8KSAvQ4Lqa/N6v6vq1HsFzQn1uE8j018vDqX/Zq2eTzLBiFToT5eE?=
 =?us-ascii?Q?q3RGAqFCOIFcvT+kJsBqAj6osDt1QnwwY0ua1VcD/hh1E3gP/XohyXvyYpEe?=
 =?us-ascii?Q?hjuScpaCF09val8XW2uqabzZt0rUnPuH9TuJ5uI7d+Ia76rNLgDqHtOBHx2T?=
 =?us-ascii?Q?HKCU/w5YX2kNcIs6GBKLgcVADxnmlrMQBvUiTrwhJ2fENhpCIXjhylahOFLt?=
 =?us-ascii?Q?ecQlWFd7bhCP/51tikEUprPSiAuvxfbghJGB1KedYk5StGvm34KX1kQvi891?=
 =?us-ascii?Q?QwEhPOnHbDFe3e6WxKcBucHvd4MuIb9KdNDeUFEWPYglVPJdYW3lzZPvHb+U?=
 =?us-ascii?Q?0dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EkLfwItuQQeL81EekhoUHVT15GQi4Rz0P6eYK1YEZratuq8DbGh4o9anjPnC?=
 =?us-ascii?Q?CqM4F2f1tINWdUbgFTAjxcRMU3XC1mlpsFf6JuFsd0JfBACrv1dyMN1ZrCJf?=
 =?us-ascii?Q?3llN96RBnyr2k0Z4dacIKFRMssbmleo6sJN9seT0wJBZ2sXQf4++CRSXw/h9?=
 =?us-ascii?Q?wv87PQFib9pcb9wmgXykvmuzHPkFFutit0Fk6G0g5rdbhYd0PF3/kVp8k6+V?=
 =?us-ascii?Q?0HMKqeJFyJeyPvr2cqHmM+CpbUrtq2ddYIYgdLMXWyh/gNSRKy9x4BHRC5wF?=
 =?us-ascii?Q?iUetbmRbPUINfoe1hDaKCdUteYg//nXo1U65nOIX4wIGpD46es3OyN0UkiOK?=
 =?us-ascii?Q?57Gu8QbzsVJTWor1MqlU4OSKWjUg8qmlE5wKQTmvZ1f7MPBDR5z6zp9alGI1?=
 =?us-ascii?Q?e89QKPqqh8M+9cZ/YT7SOXa5PO/oAOPtoPWvJudpz177TRg30Ts+N193VvwI?=
 =?us-ascii?Q?DG0um5tvibKH91Sw+hz7/i0/EI6cL1FIVTv/TzVYmTp3eerAIqfyjprCgJhf?=
 =?us-ascii?Q?OGG/KMvulXSfR6h8kxlcgeBIQVv4iq91VeGOimh3cUoia+sj98f3b6p7LHJK?=
 =?us-ascii?Q?OdJaANA8ZXbYiDPh0cr13mNgbIaNA2sHSLuhsL2jZzefl6X066sgWNFeXuzQ?=
 =?us-ascii?Q?oeZBn/SaRPw+a5uQACBRQYc60svE9Ilt6bBEfhLuBIoplvT+EjnAetKx20qo?=
 =?us-ascii?Q?RhEvme5FYpfLoh8nC6M9EIkHaWlo2pkJsiK3m2Gcuz2UOq7jeSck5b6Ye2k4?=
 =?us-ascii?Q?e2yW5wIhISJc2JZRN+nPepN8TF396IduxuexRuH56Q23aRbAB8K2uiGb+2JT?=
 =?us-ascii?Q?fVHuP9/VtgGbiGRSyzORgnNvZFHAt+dYa3Kf3T6ms991hXg6DgSxJYE9kiS5?=
 =?us-ascii?Q?VJBsbZE42q5XQxoi+tzNPopKbIpTf29M/7stAaE+/K1RXSR8VEp9f9cYuEJG?=
 =?us-ascii?Q?xNHD966fPbtBJwEAOIu+vRsX5wmjK1Gx9zzb9rYiZiSPOFlYyHLSHc+HGbRv?=
 =?us-ascii?Q?6+7rHAzzM4XuRFQ8hTzcde+i0O1Q6Ch1uTmb3CdagH+70GzRPlW1mjasqWCo?=
 =?us-ascii?Q?6TksFtIfzKr+M5Cktmf+fYo3RypYFSwyGIHGVPsUbRsXBrDJgj8B9bCzVL9B?=
 =?us-ascii?Q?5/YUwiFj7x7j2caDbHfgAl2uYAuQnyqdZQEoITIb0/qO010F6Yv1uDOTt231?=
 =?us-ascii?Q?uxtPT4fhu54ESB5kDACc8cYHLUlh4WlW3pQp/oWu8NBTP77QF9DzJkljWpj0?=
 =?us-ascii?Q?A8g9IXLIPmCbJ6bKChdHHhgttuH+LebRob2zyRYJvcXprqynnTUv1eekCR0D?=
 =?us-ascii?Q?f2E3lNOUV+Rxw3UvNmHG7yl9kT1KnnO6oajG8otx+kLNCr+P5wy/kXEPqSQ5?=
 =?us-ascii?Q?R5dZO9SpI3i4pzVeOQoMuZQLC5Ow3kfVNo6+qsoe01zswRhqnWPpk0V/q1x0?=
 =?us-ascii?Q?r8PIrcZrH/YQeOROSprU/sryZ33+uInc4jP9xDBS1+ZIY6NAggCROSTLM1xP?=
 =?us-ascii?Q?bTx5h8N+KSDacX0xKCA5j4dPOecwrINB/R9lmxiz14l5kgM2rFASj4q3fY0p?=
 =?us-ascii?Q?hsdJNVqNhxo0PIlpeJnis0NquyBk5WN9NBMP4rNhy6ZeHuhCbxM335+NxY/y?=
 =?us-ascii?Q?1zBVpoD7QHL5DZ8NTdSuimXLlxNWgncs7RdF2zxkKZer?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86679cd6-df82-4101-4225-08dc9f7d9764
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:41:34.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JbH6trWvxRRIQPEy7vpnQ8rrgwDc2GOAko/NCBHPaz8B6z1Ioj2idaH7VTPUAlZoLZtcDRypDIIp9E8fqeICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2060

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: stable@vger.kernel.org
---

Hi Boris, Kirill and all,
This patch was posted on May 20, 2024:
Link: https://lore.kernel.org/all/20240521021238.1803-1-decui%40microsoft.com

The patch caused an issue to Kirill's kexec TDX patchset, so Kirill fixed it:
Link: https://lore.kernel.org/all/uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5/
Kirill agreed that I should repost the patch with his fix combined, hence I'm
posting this new version, which is based on tip's master today (at the moment,
it's commit aa9d8caba6e4 ("Merge timers/core into tip/master")).

I suppose the patch would go in the branch tip/master or x86/tdx.

Thanks,
Dexuan

 arch/x86/coco/tdx/tdx.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac25531..8f471260924f7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -782,6 +783,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -789,15 +803,30 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
+	unsigned long step = end - start;
+	unsigned long addr;
+
+	/* Step through page-by-page for vmalloc() mappings */
+	if (is_vmalloc_addr((void *)vaddr))
+		step = PAGE_SIZE;
+
+	for (addr = start; addr < end; addr += step) {
+		phys_addr_t start_pa;
+		phys_addr_t end_pa;
+
+		/* The check fails on vmalloc() mappings */
+		if (virt_addr_valid(addr))
+			start_pa = __pa(addr);
+		else
+			start_pa = slow_virt_to_phys((void *)addr);
 
-	if (!tdx_map_gpa(start, end, enc))
-		return false;
+		end_pa = start_pa + step;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
 
 	return true;
 }
-- 
2.25.1


