Return-Path: <stable+bounces-217791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D25RBN6CnGlwIwQAu9opvQ
	(envelope-from <stable+bounces-217791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:39:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FCB179F4B
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B8830A02C8
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E04314A67;
	Mon, 23 Feb 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YN7yIQXv"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723463148DA;
	Mon, 23 Feb 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864398; cv=fail; b=JuLVjBdAD49l8Nakn7ksLihAciYQgX0E/Z1zIyiScJboBFBlmvBIM+7VuceFD0JBay2Bl54/CSPF+0Uf6HH1V2i8//4I9YiP8uIl2CDf1bZ7GlewxW8Im1rIg61Pk7OjZDt0ZsV3zYmfoLB6omWCwKT/SySvGCZ9ooqt9lt7s5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864398; c=relaxed/simple;
	bh=AvrBDQJh4vYhzTR/p/Ovyl6R+2leAdfbyxOM7jJql9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0z91EhlERiIBkoOfmanJaqkice+dADhC5DKiojz7LjloQYkl8RW0LJxraeil0A/wf2bQDzzXKS+Y4q2mi5quDFT1S4ZXLJDLkMJxPJ/X5ANQiHDXBhWI1yhOdc8438XQD6mCUB/1w3eD4wyh6FDqCHI2hBjjsLe5FiA77eUiXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YN7yIQXv; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQWXOGJp/6zz24G6tMnL3PuSFfFHjGNEZnRWvqiUzjx4k/uKLwbEZeJAbjeNp8ecaqQFgK+Oo0rPQNE5P/3+gZEhApeNmGVzCYhcmpg3rmI5oV2KQYciy4r1vxcdH81w4zrW+SQro5OFKceSF5QqBWgEdgGWdmre2ZDQ9gL1kyIT8ZDHivQ/XgRY+oe7RLvMfNHEkaEDUqeZhMaryfWooHMI2HLK15VKMwEO1/FmDsAjQkQQxu3y+zcdoR4cIHJF8q3EdJuUSboTi5o5RaifADUXylLp79ZcYErJMAQfGs9yR8GZLeCKsOI0go7kMgAxvSgUEfxeiO1pbU4l5kXXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kni4uOcgxNe5e9RTxB8djc7/ZAvrR/gl8m4B2bZjmV0=;
 b=TbcOSpWOvhAm9kt4x+4lzrUBaylsUw+AIKm5e4xJfiOa1hiAOa9dCBXPZSnaOKs9d7u+XebpzvRW00E6o4Ec5Vt5jQJzYc6/q97i3iXC3eQHSg+52LZDmpkFhnsidr5HjcV2+FXVD3WmkClX7aSVxlLXEv5pirSv+FqXOxluUbsEeaIHfPTQW1GMpa9LNr5NKDfMkEUBG6SUrVCMdP+DgzmBNaRsBzRr0uVKf8Oywytl8i3wbOESS6q4cHbsw3BCxXm+up0MGwvqXDHFwV/xaNqBRzGShSP+mXNk90h1FFrVOYR9dpsDOGDpUMmty+AJj+srIqolv1bmoe0E14bS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hp.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kni4uOcgxNe5e9RTxB8djc7/ZAvrR/gl8m4B2bZjmV0=;
 b=YN7yIQXvJ3/aZZc7ePNllRIFt2VwHeLHkZ5/KTRWgadLfEGpDih8gMjSjm+d+P3Iw1ANiBoUylQXuf/9nArhER4EPRZg/2HZf5PDZqW1qX7leg4vey3SCrw6UnC2hz2nUWbyleVsPCFk24JbPrVlSbIds9VMYztLuBi1yBCB0b0=
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 16:33:12 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::6) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 16:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 16:33:11 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Feb 2026 10:33:10 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <jorge.lopez2@hp.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux@weissschuh.net>
CC: <stable@vger.kernel.org>, Paul Kerry <p.kerry@sheffield.ac.uk>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH] platform/x86: hp-bioscfg: Support allocations of larger data
Date: Mon, 23 Feb 2026 10:32:42 -0600
Message-ID: <20260223163245.3294630-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ae7f53-64e1-431f-e4d3-08de72f93c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ebc1RFX6bUKP65eVyRNCeN88XMu4Mv32HZYsurF+CjQq5aC/KjxrPr0GBRB?=
 =?us-ascii?Q?grxRU8GCU5B7BmI9KrFwLCVSpMk3T1HWXUIVS/yFtr5awEJ6p2gdNjAko0E/?=
 =?us-ascii?Q?+UxU9Cg42ND1v/ct9wfvixBG/U8VkaZMnY3juEzqu7xrQyukrS1b5eFI6RlZ?=
 =?us-ascii?Q?CSArZEN6aFOnD2QQvWS9jvhckwzjA7E3PnPSCQfeDsi9ooqLq84Og6T02RkB?=
 =?us-ascii?Q?Oh5L6rEVT8c4bJ8wJjgAfKooOogVkzPFJDPFLB06MpT1ZlTiyhr4SDA72Mi4?=
 =?us-ascii?Q?Dl7s22eh2at0EYikxTt4Cb5h+KVGmuleMnvWI9NJDJxwhq8WaEXRf3xSJ1k+?=
 =?us-ascii?Q?c1PQ/apVDDdg01/G3GjWihStAb3agmZDVpwsXnAs/7TjpiegvugSIOqoFLmu?=
 =?us-ascii?Q?zSVOPEs5KMqBrYi7OUoSNesE6dd8GZViOk/mV02URq87wWPznJjMqPtOpdjh?=
 =?us-ascii?Q?mQ/HBNaVoo/sAGLPhlp8Wsv9L5xB6OnoUXT2oVGm1CwobXtevqDR73CiZoSZ?=
 =?us-ascii?Q?iti3aVLADad1OS485dEWmP1ZAh/xEcbhAq8da73Gi9eOpk3QeqKVlInAaeZU?=
 =?us-ascii?Q?i/O6XklGH7oOBwC4emN/VwlJuvUrzuwyY1viBFDSi/Q9VR/BUfplcuK8PWg5?=
 =?us-ascii?Q?tmVsZmuf7DjdFhP9qj8UxYqOMaAQIeP1xa427pCdpmM9buirYJCUu5bgRs2C?=
 =?us-ascii?Q?FALrNNP4ebiSGMzFUUhaj4COxjDT3vcQklpbE1HeXl8W6Q8wfgwIa6NlrUYq?=
 =?us-ascii?Q?B2MdM4lKdwEq8tH+F4MpdWXx2CPUs3AAuP2zO1QqjOXV47rnv11QoiyUtvQC?=
 =?us-ascii?Q?J6v4nq/JgDcDJUtmA9ykXIVi+4RxGMTnNZS2wrwjpW976CIBTpkD7DhqnPm4?=
 =?us-ascii?Q?dz3U+UEjS/Uoe2U6htvbBpd/zopXc1twnOiG0h9B6zQJ+fTRTbUJKzDjTPn4?=
 =?us-ascii?Q?msBDHr7gmHspt7QoAK/dC4hxY3kXmH+GOmPf/jrkPFI4eHti0o7z9T7th2U9?=
 =?us-ascii?Q?Hy3kcOZmZUfDRIAWuTNnXpWbyL32udFSyXjqkGcwBtHxALRNXGnWPWfcsr56?=
 =?us-ascii?Q?bmx8QYuOcscEtzkvfBaLRWKSAtm3PZVEXkzCHrPWe+nX8cwPy6019h++DIXn?=
 =?us-ascii?Q?DWn20H8pGk/sygMor7IDJXY/So2P8IbFguSQQIEl4BtoiXTZpo16yFdiMEHz?=
 =?us-ascii?Q?cZ5yuP+H1TPAx0WkXHqdw/HYMoPAKXn47QloRdnUXpUjIrMpBVXxU+2eXcBp?=
 =?us-ascii?Q?TNPvT9aDVlJT9gpKHspIihaFndWr45PCV+itzWBG90WGltjqm8VpRR7MmATb?=
 =?us-ascii?Q?Jv9y6+i5SxdPpeaoRWykOGyVr7TxYghcZZs2LnOlSbkz0EZbbIc+BP8q1Yjc?=
 =?us-ascii?Q?T3y9DK3vh+KZqm0aZk/Zs0UZhnzooAzuJGs5ci3V0xQVCKFnAiH+Pd038gI5?=
 =?us-ascii?Q?mDOd43ar2Dk+E2xf4Q/t0+PoVf1C2blmMv0mXpNqttc42K14v088mSXMQU6g?=
 =?us-ascii?Q?lGoEGZqjSfJHIIg3t/T1qhcODaDwpvy1XpgQMfWqZ47p5D/yHapAu4Tj8z5Z?=
 =?us-ascii?Q?rNzozwyNgsFnnuccgIlFpVK7C4tO660w3Rdh0YKtnf8OSw4yjreZ+/D5WyDy?=
 =?us-ascii?Q?ZvgFPAWAVOz3CGrM326JK8Hh76FFDpFWSdnjeRrH5y7o0jY4krmVN+Mfh+3B?=
 =?us-ascii?Q?rYlWIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BfB+5gchryllL/e4qSOrR+npeQ7dTBLjCsOVn0H2eRojn+PJPWzFlzT2I6IMqxRMxk7Wz70YJAjS+oLnim6EYw4WEHotP23eaUXZZhgNQRfZggNO+7M96+6vrydarkDVgP3mqxIaikt1X4Kl6vfCSCswTZiS/wmkUjfRDesJHadmXmYwbIUT5lofvE+YDVwvYxqGnBfTBzhmpNWvV7NtfmVVr19XUcy990SVKANTVg5LW24wuw44cUmXgTTJMmBs7hHUbFSRHbndW36fZkto/7TO1C91rhoTpmjcbjVbG9BVyf6DkWIc/zVjH4hxpoODOlv1GOwgn0n4IJ7Y6UKQpxFLqc+EVXIqvF19RKjXH6cJLUKWOfLiQV3XcSfXEzGEzEWPU1M+6upCT+RWu/KYktj24wTG24OkLqn48CqiYcu/OTSy3lZM50EWB9ISRpj2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 16:33:11.8658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ae7f53-64e1-431f-e4d3-08de72f93c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217791-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,sheffield.ac.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 75FCB179F4B
X-Rspamd-Action: no action

Some systems have much larger amounts of enumeration attributes
than have been previously encountered. This can lead to page allocation
failures when using kcalloc().  Switch over to using kvcalloc() to
allow larger allocations.

Fixes: 6b2770bfd6f92 ("platform/x86: hp-bioscfg: enum-attributes")
Cc: stable@vger.kernel.org
Reported-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Closes: https://bugs.debian.org/1127612
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 470b9f44ed7aa..af24313d078db 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -94,8 +94,11 @@ int hp_alloc_enumeration_data(void)
 	bioscfg_drv.enumeration_instances_count =
 		hp_get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
 
-	bioscfg_drv.enumeration_data = kzalloc_objs(*bioscfg_drv.enumeration_data,
-						    bioscfg_drv.enumeration_instances_count);
+	if (!bioscfg_drv.enumeration_instances_count)
+		return -EINVAL;
+	bioscfg_drv.enumeration_data = kvcalloc(bioscfg_drv.enumeration_instances_count,
+						sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
+
 	if (!bioscfg_drv.enumeration_data) {
 		bioscfg_drv.enumeration_instances_count = 0;
 		return -ENOMEM;
-- 
2.53.0


