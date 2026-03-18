Return-Path: <stable+bounces-227074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iECQBoytumlXagIAu9opvQ
	(envelope-from <stable+bounces-227074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:50:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797B2BC544
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1852930421D3
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCFA3D9056;
	Wed, 18 Mar 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yd26AuMj"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396A3D904C;
	Wed, 18 Mar 2026 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841511; cv=fail; b=WGb9K0EUpTNKKyQcEJ3Kv7R0+6+fCchLMkI5f05U7xPX/NUTMyWfx+CnhTm6EwLVtKMEye0VNRdHUek8C/MgRDHtI4fUdhq068ABa4igCqf3oBUQ6uStBrgE/u2pqhka9w1jPlbeLSmTYureN02+aEu/ZKnRJk/SBnaLAexOAi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841511; c=relaxed/simple;
	bh=kG69NmheqftKxlULSDflbiAY/QQIRuuA1gb9nCQQooo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYwZEWj+ehlVW1m0PQ46HJgLW1XKEDFiHpq1A008hq0P8mr5sx6eMC8G1wRsgiMX/ckT+FQOl/Khvu0uuEG0ho0TUudtztUrJshICssTCdk+SiIMZRD5ekj3qffhPHPRf9j6jJCVoRi2ku3HBvtiKSFI/Zp5zHoVS6rK3HwfNfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yd26AuMj; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNm2F+GyS0y4I9cnGudJmaO1Lq9pR0xP0e8GXcQ76e7tmDhoiEFXEE06pZOontDRmAOapsHUr56+//PyMp47E5OSlY49IDo0Q01rdtNwdVOkptOJgF5bNxFe4oNCYt/JLJmdqH9P6F5OxYw5XmkhF6CDwFDnNVA3shuXgO+xGedDWoTW4ZUp8Nn8jdnNLHErm7NbnLxsk5NAyGBPMOcnaVlJjMmUwqbNtPy+AF8cbSYhLl0PxvKPttPtA9j2N3/fbYPW6TpUDuwlc2rebvGrleJznX3QbnBbGljXG9Fq2APzbtMrcVkAliC0Q0o5rQQwJaJ9mvUymNb1NISaBnb6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PTZws1ad6xSx6y+Jk3xsrABMxJ40MjqBXu6jy8OGGc=;
 b=usAKgWnrK4+TTTqyfg8e8Gv1Ymv9oSp/mvoZIA/L9hRcURQmocWTsGoPN0JFm293OMJ0CFioX7NYgGLpWt/ecP2JhvVAtbzEzufzZLZQZbFST4iYD/PO+Z96Aj+syhES9OM14owzX7y8YKaoJu/qp7jiiTpDfKU6+7EDrX5zPjCY2LzDh5DbCuBQNoTaH1L7c7e4QRzS5UI8nNS5R5fBcxGKdCPmsciWRNl1xH+CMy1mGjwWShS2Rmt3wpv/VW3a2EH0WPt3clTOecPW33VGCmPQqFewsKWviwwsENYDH2cwKFduwGY9P3e3LQGhodZYZUXp6xcHOWgNN57by9qi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PTZws1ad6xSx6y+Jk3xsrABMxJ40MjqBXu6jy8OGGc=;
 b=yd26AuMjCD8Lecd0kVtNcd10GBCUTVZ82nwtLdH1b9KnNY13HyV+80h9CU0t18wY/CmoYyH68hm1/QpuRHjYFTAIGp7mrhKTH8oSpd3QhqAU5JHp6c5JD9qQ+LWSzHrm/zN3pVvsixGWFfa/KSimClov3JeuLP7VhWyesA3wH9k=
Received: from SJ0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:33b::23)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:44:59 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::bd) by SJ0PR05CA0018.outlook.office365.com
 (2603:10b6:a03:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 13:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 13:44:58 +0000
Received: from dcsm-trdripper1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 08:44:55 -0500
From: Akshay Gupta <Akshay.Gupta@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<naveenkrishna.chatradhi@amd.com>, <Anand.Umarji@amd.com>, Akshay Gupta
	<Akshay.Gupta@amd.com>, <stable@vger.kernel.org>, Prathima L K
	<Prathima.Lk@amd.com>
Subject: [PATCH v2] misc: amd-sbi: Address CPUID extended function bits
Date: Wed, 18 Mar 2026 19:14:42 +0530
Message-ID: <20260318134442.2778978-1-Akshay.Gupta@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d55a38-cc03-4298-e9bc-08de84f48bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uarC1b3TZu+zF88d29KR5xwvRNjc6VvSsf653m3iRz5tob4jVk4zRD+F0Grp84OaXCombmxw3R94k9CteGQuZzpMuZ/7oBUDhtnJLXhPsbrqJNV75vaKW1jM6UtUEMdfGVpjfawMcVW3Z9qh0a9NnNvgu/a/YchB38cZ1QgS2fbaa9jZJ9nE8brZw0yPxcNlnNgsnOzVmCZ+RS+CSTadKdI9SGSrVEooOvk3mlYMVttvXITEEqNM0D+c3lo5oiRuups+bj9/HBAj//rcdwKKdgZ3KfGYax9Ogg/Stg1UsohtLYzxxsyXBn84o6pGK9gmN2CVy4CDa8mY97s8YtyhzgA3mNrM5Cknw+K6hLUPX822UC00ffu8H9jewWu1P6ZdwsEQ5S2ErAe/tzvbi3AqtL47To1qAGvM7X/bdrf2jDy4iMFiFc7yT9CAq4PGMyDJLvEWLti3paYZ4o5AhFcOvafHcw82Yt9JQHGvxJjbs2GAJDxfB1u0KjJvO7gVxNOPWox4lwgb66Cf3OwPQEZ2diDWSjWa1fGSqCZM75JtdzP9OgYimgIDQ0rgqfcNJRN8cVaFTMubIp9y/gtxAjmuw8StbbtlF9epWS2oW4i61BHDtij1sXheVjRawZ5AmPNofCVvgiNSfbzxK+4rOap2hVTg5yV0i7QlSBP7H7R4Ykjyrgq5lrjel9qoGfOok8aSKQ6D9JCJw9OLzZSjaRVgHOr+eCbYx+Dl4LVnb/qamG/YC3cegSFKLwyq3reGhfycWjFdroel+Mzgk3ho7gbtpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kMwwo5q2TaiwzGneQ6yHN87ku5EYvH6gjitNSij88WaAiou9H8e8r1Eu9TWQYNjxc8MU5MFrY0tnDNItRwR0vByCEc9OaRvjefk9bKSCdhymLghZG/bN2HenZNthsJC9Kxl4shQl31onkzCAVivLQ7v0dV/bygOy5bhAqrWqZHHlbtITIXdVDLJuvSbcANgDYCOAFiIS8rhqTLqpw9f/RC914OJh8mkWXg4WchtA3GfZjjpMHBn4lGZN9YbZVYTFkKWtz5+G26HAaDzHQnKVYaxUA65NiJEnBT4v89+74gGVLcg6fb45Mg/pRCDjOhsub2qnzvTpqSV2or2w9e0HvVYOoaRauuxUZiyHSKSmtOwL9loxlSRSC4VDbW+q4iTYSikKWHHvGC/e1mnT1TPQ6UCrclkuC0BN7+VO+ZpLNMl8iEyZrZbtQvQiDVCWCi9s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:44:58.6964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d55a38-cc03-4298-e9bc-08de84f48bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227074-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Akshay.Gupta@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7797B2BC544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the UAPI header (amd-apml.h), the CPUID extended function
capability is indicated by bits [55:48], but the driver currently
checks bits [63:56]. Adjust the driver to use bits [55:48] so that
extended function capability is detected correctly.

Fixes: bb13a84ed6b7 ("misc: amd-sbi: Add support for CPUID protocol")
Cc: stable@vger.kernel.org
Tested-by: Prathima L K <Prathima.Lk@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
---
Changes since v1:
- Added Cc "stable@vger.kernel.org" in commit message

 drivers/misc/amd-sbi/rmi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 1d4933c69dd2..d4238ebad3c6 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -48,7 +48,7 @@
 /* CPUID MCAMSR mask & index */
 #define CPUID_MCA_THRD_INDEX	32
 #define CPUID_MCA_FUNC_MASK	GENMASK(31, 0)
-#define CPUID_EXT_FUNC_INDEX	56
+#define CPUID_EXT_FUNC_INDEX	48
 
 /* input for bulk write to CPUID protocol */
 struct cpu_msr_indata {
-- 
2.34.1


