Return-Path: <stable+bounces-219710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AFaBolkn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:07:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C244519D9CE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449A93042D7C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EC31076D;
	Wed, 25 Feb 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tC92aA5+"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8930F53C;
	Wed, 25 Feb 2026 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053626; cv=fail; b=nRBDYtH3hIrPm4ePqSFh6+Oso+lEvoAQv+LGmR+Jps5bxjvkXDCeASvB0LDHjkV/Jz3k0RJMdjjvHmMBRxtGCyV4opOgaV2Uqtb7BjjsIkqXut7bucR4zPUhgcjf/oXQJKoEL5oENi4wz3d8rSj11ZC+ybq1WHamBa0hJgbYrlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053626; c=relaxed/simple;
	bh=YpoL+0/q767793zzyz2Q9Sh4rd3ejmq/8CFYiolGyXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SHjdYs1MaZF0VDj4POp8r/29U7JwSfyOBlBAOgHD15siNmtyvNrK3C7TfKSFlw5rLX7THjgaeiefKypsWtvRL3DtIhF4GWcuQ3jhAEJK7MYHhk3FtNxEIN/+q9nECYTWQ2XEIx72kkmcPOwAGGESiQB9LFMYu2mEY+FIgFryIXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tC92aA5+; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR0VpjER7CPT6i+CWWPABj2AyyDY4ZQO4VFWKl5r89Vnj6Mo/7ov040hc/Pgcco9RBoOaHVjKWEBn/gg5By2GmbR1EZ8rA3kdvtr8NWdU77kXtYNYqLkNcxhzHMtvIboQsLz061UmaMCZCAIQ3DNaLuSeF3UADnRhEyGnS0GJqZM9S86hPuvOGARsWSjmns8Xo9x/QyLTnFx0QwAUk+X7QTi0W8myO2m82TNLbCqG4P3Z/hUSXlvny3cZwmFMXDl9YEfDAAbtP3o6ZK6u+TnP/qv8HU4QWMqaZJf0JumBGMe/Izbw/VjdSTBptRIC89w43y8tqRyvZITYu3kedGtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53VIzc1K8fwU/UyHe/dSXtq0mYwKPo85msdmUVwt8b4=;
 b=lf1Ks1FoGkFlnTj+/DDlcVtRyr8DpfyS+XchCTrpRHsykdf2+rbY4qcfaNfXeZYxadd8kb8iQ3rNQmWrDH5Y7A2cirLdv5I60uVlT4njgl6jnnda2DIwvtY6sfV1S9Mpc93BFzn/ydvN0mKh08Sq9mgG/7CGd06Xecl/wA3WQxAGUpkx2P+wm1sv9NyGBRhorlBuQ0ootPhxwp3BcLWZBV/F96VYrWPyzNWD6zXEWR6+Al+qRsd75Diusr8NFSBAqy0JO8KLRqbeG4HposJGHH8hG9q4s6AH9zqkZQ+Ueg6xE5sUxk+LN80eZMYHrV/NJDqn/85FnBLPEET3Fh4A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hp.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53VIzc1K8fwU/UyHe/dSXtq0mYwKPo85msdmUVwt8b4=;
 b=tC92aA5+76GARLX1BkO723xQ3Vrd+byw/Jxb9acnhr6R1MH4U7HlCqha48ciaMD9UmelT1J5C7opOR3xq0y1N6OFdMoZtPxgdd08Ew5oOzYXvJdoJh5gwKQg9uj9qk/IqoSnqzY3Dfk22ZovjZbN/TsagAx8j2qtJgOZdgbDGQo=
Received: from PH8P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::9)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 21:07:02 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::12) by PH8P220CA0001.outlook.office365.com
 (2603:10b6:510:345::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 21:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 21:07:01 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Feb 2026 15:07:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <jorge.lopez2@hp.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux@weissschuh.net>
CC: <stable@vger.kernel.org>, Paul Kerry <p.kerry@sheffield.ac.uk>, "Ben
 Hutchings" <ben@decadent.org.uk>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2] platform/x86: hp-bioscfg: Support allocations of larger data
Date: Wed, 25 Feb 2026 15:06:46 -0600
Message-ID: <20260225210646.59381-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: e989c3d0-1b6e-436e-0547-08de74b1d218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	FXpyvL9XkIZe871Tj9pke2ZVIMyYiMAALY74QslmG9VnGLTWY5SlHuDmyeuQ3rrsdavosvjkrLJBSIL4PWNxdVkRK4PY3RBhVm+HpMJAe8V7tQPK4HvNmpSMvGFwhSj6sOUja3zZ3hDDdVThdtosFcVIVBTI2M2a0CRLcXiR99ahlI1goTbgtl5R08wY9fMuYbD/ckEN9OKQgMI0RSWPGp6eELMqscztkREvXe2X5Pe0LN0Nx9IV2BtBGlv36ahrQaXzAHq2ufFanyFsew+GPy3dDoTgPm4elfVUg0cjC8S9xj6eCWdjb4rZF8lYkTFbmfHp9zoJ3qbm6APJ/vWvShSYlUkcvLX7TG6WSKfU8y2+gWY2s2tu0QUCpQjtBLOQKpoiuCVDR+f7CytX/oDJx3hf8cAVPlIJe/Lz2Y10Ti1PBPCFvE7Odtvik/g8TSdMmE0To5cMpvyLCFiB2V3OuJ0VGWFUNNmWkRtGKHnJkHNE0gFICjrxucJrU3pXjT0WiNtA1bqGzT+Pn4+AgjEVVZGY4joS/+AuKH1z/7uuxouls5hNoUoHXpulugknwn9Ocih3m1yG4QVBosQvt38vAO/sCpx1TUcy/iXu515dOv6VeU3PIDpwcTH4zIrNbonj3m/tJeqsKqCxt26fAaGFIGGsXHVS7rsIrpP/tDMH3V2lqkco8HfP1HCSQ48dFtjjSk/4f/JUsN7cWBWcH8VdcJ3h7Ei2QBcBNOKzEoN9SzAGKgKaRV0ycBdkHbD4IZUDF66kw6n3MR5amC4dGR8GFn3mlbAB4CFP39XPArAgdX8D+M8fsQBAG488f6mT7xoJXgveOnh5R/NDYnX6kAiZpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GYayAQ4m6ao+POwAsG2IQiJSs8NgO1MTbE8d10n9OfDPFWJ/tRhPRaVoS7JZ/5FfBhOJegkT8+lPfBGhW1BCEA+WY4EhpfBdaIGqiOL/KMLMeBzgKtrhzcTVK9uYBxqDsA9WuDFbVngejFfwkGjkoi/oma1kJ4Iga6ORdWjLuGymKQjD2nJpnjm9XLzsCIAGqghDPAL3ieTUV3G1ZJuLQw0CZsVEUh0wfOUK8HFh5CWTQmaiz5JY6Y1Yqar/mpECgEavSSesH9NYEiDdO+OipSrn2xzS8sAalTx+1oudfqJ6ZtMVMHRBnSn+OprLWSmAFQlcZlYXPXusAFIclPl17y41mGaWi/9uQSrUfoo5OapSF0tHANwzuynYvNEm5xZFbZHgsb0M9IZhlQfYRedanUNhMNBiiPTC2tD8PPsN3ogizrJ83nj4xQnErvdfZloJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:07:01.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e989c3d0-1b6e-436e-0547-08de74b1d218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219710-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:query timed out,10.180.168.240:query timed out,2603:10b6:510:345:cafe::12:query timed out,2603:10b6:510:345::9:query timed out,165.204.84.17:query timed out,2600:3c04:e001:36c::12fc:5321:query timed out,52.101.46.12:query timed out];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C244519D9CE
X-Rspamd-Action: no action

Some systems have much larger amounts of enumeration attributes
than have been previously encountered. This can lead to page allocation
failures when using kcalloc().  Switch over to using kvcalloc() to
allow larger allocations.

Fixes: 6b2770bfd6f92 ("platform/x86: hp-bioscfg: enum-attributes")
Cc: stable@vger.kernel.org
Reported-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Tested-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Closes: https://bugs.debian.org/1127612
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Ben Hutchings <ben@decadent.org.uk>
v2: Add matching kvfree() (Ben)
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 470b9f44ed7aa..af4d1920d4880 100644
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
@@ -444,6 +447,6 @@ void hp_exit_enumeration_attributes(void)
 	}
 	bioscfg_drv.enumeration_instances_count = 0;
 
-	kfree(bioscfg_drv.enumeration_data);
+	kvfree(bioscfg_drv.enumeration_data);
 	bioscfg_drv.enumeration_data = NULL;
 }
-- 
2.53.0


