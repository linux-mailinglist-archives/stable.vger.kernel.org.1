Return-Path: <stable+bounces-270186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlb6F5YnRWq47woAu9opvQ
	(envelope-from <stable+bounces-270186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:43:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B016EEE68
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=gd7sCvkS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270186-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270186-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550FB302D08C
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C0D348C5C;
	Wed,  1 Jul 2026 14:32:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEB343887
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:32:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916368; cv=fail; b=laCA7XIZtdpxXufEpLr5d+8diNQDayAIWIjX4+obh8yfPRwYaUAOPiDq+MYcNg/ztg+SpiKmBzK3pxYCQxeJ/+oFJhi4LMJ0aKSBeFmil1SJs0HFyK1OFRVUyL/0Ev1ZkJheto6xO1BBkWJ5nLbngGWhHp8E2SHvYMN7x8dQnA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916368; c=relaxed/simple;
	bh=C6KwSR5H/WIAmIcpv/RdHDvN91dl9E+nRPBNDgtnvWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KhiYO15QCPwkXW2+gJoUCB78W3ErJRa4IssIrGg7xHXkIk54hJGJs5NLNcWp7Tv3eunr5dR6DXbufrFof5JwHPuYB92P725b/MAhhEuIo8/q3jMV7sW8wgPeXbfgEkYI3u+YMfNLz1Lc/ZndM1fdpIFulw0jXk7+90gzf6RP+CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gd7sCvkS; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RviWQHYDpUsbHFdH8yiMD1TgZDfCrmCmG9c5tJlZ7apYYMuwWxnN0dLL+yNDTFvKbOBnZYMkPx71xwReMi1dGEqVdByUNJsibJsEf3dy0ChARZmGe9M+afHOM8E8+mIaCLeUjeom549gcDIjzDvdoTy970VmPz/e67GfhfQDeyQVBplMSeCJVJ6w8Xnikdy7lT6fyIxoQpvnAKUVrWxjVeQdl+htQCVETuFsqkTxB8uQNqIe9VC+cdZqmICPSEzgRUmB1wY0ar7I+3I+GYjzooizSiw4qnA/1sjneYFlQ1av/AhhApu7PQUQZifRPJCyieCvGbseJRZgTVEBWEI1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmuy4r/LO/+UyyrA/vTbPgi+EZCCx4dyKpZlrrSIYK8=;
 b=clszG+JeKW37xaBonW2oEMMDXseq/+tHhGxKXaceTeBbuOEbts4XBYNRlJcNtyjINYin9O51VCQrv8ufXRndOrhc2XQd9XxiPmnq8UU59IJpQsFjkFQhB0QMvlAA0YL9Gg6aWGN9f58K/j5DCMuv49ydT6ezDC9ZfZED2pwJ0z/QF/Ghz9biVXqvDRLol4TtpMO7MNGZ4zgXG5oitDxxGDzxqN8RHMn96INUgxTBwMqokGE0enmikey6EvpT7H2B2DGJetMrhg8TELvknLJIVZs63+q6eZ4bbUUD4bB5sMiGZk5+7JbQ8p1yCGj5rZvFudtqmOqH3Ak4pPkoK+HRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmuy4r/LO/+UyyrA/vTbPgi+EZCCx4dyKpZlrrSIYK8=;
 b=gd7sCvkSNWjQfNLuTTfoQJzhH1hMQ5js8Zu8uvLiHx4cMjPVpi6wna9VcNV60YL/YmwjTFAeA28wOgTPT5cOQRoUbROI5Ic+f73yawTdxtcpu7392NeBPqiLf80dFpLN+OW9iHrGlEVxLbxBbiH3fVGQQjZi23ZW647KVFhmbxM=
Received: from DS7PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:3bb::24)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 14:32:32 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e) by DS7PR03CA0079.outlook.office365.com
 (2603:10b6:5:3bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 14:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 14:32:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 09:32:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 09:32:32 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 09:32:32 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <pankaj.gupta@amd.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
Date: Wed, 1 Jul 2026 09:32:31 -0500
Message-ID: <20260701143231.39553-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f69cbc-c872-474f-c9cc-08ded77d964a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KdqTg1M6gnJ2uw734VzjLFUoB/Nx4A9cR8GrLHfWmzvydLI8hd9RVua7wLLAB4iAcADTnE1Mc2heRv/sOF28MDuS9StxepCJeo9VQ43/huwUTapH9TnDUa61BYoviDI+w3PmaOXGicR6m2BcSfP250s2ZZfuwjlVYFRL6AyOaHTmO8Y2wIxKIJKOyhNtfJRpT5HD5tqa2icUCqn95OPExh7tBeMlg4e0+WKRTwig/lgPGrDfWfDMmrmW6VkE61SM7XcSZ7Ly3zS6WN3e/yP7BM8h/c8mFc03g3vPVkC0bQtZkVsBEC3LOjx2Pdk8qun9+Mrm22tydhvYxfPdo4pwgf9jfYhCSbOWitVlmajCLkQWOa0mkJWnalnjMcPopG6qizkl4kxlkR8+1wTajtdeg9J/7THmk3ZAYs8srW1xw+TBTCqxxl/1wZZkS6ytu2PV2O3TWPI9RlWEneNr9iq+BSc3VqZsiGdnzUNITa+5J0MqOA5+HKVDEmDHYz1u3sL5r5/77WHZTx7ZW9F3899l+JHfC1UsnRi6G/zMMDQbHQVDUrn33LWtf7VcPbE+afh5EHliOdRMLrih3scPbHL/7yZursgD8XE2hEC4nYKHVgDNjqIjjHYavjo8v5cKnJ+IDMwWJZvicUUp+KADQf1Sc3gNf5MW4zGFv0+HBYBlG4J4UrKdrvfaiiC4lHLt35dy6VQwfDeTeRt1tZc9FGboKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RWxuXqKGwRKF3xSCOJm/M1o08oggnVTDI2mt0WVIx/mw30DNSuGPmQHvSZsLpPXRBzbld4JEfI33nRMoDKa/ms3YAB0uA3i4inNSXGIIaTCJhMP2igwmX3VdXf3VEW2o10ep3ZbQNO3YVgytPtYMTfOulpo9ISBLfASL+zwECWEmAi3TSwHWLruV+5N+xIwlOVumZxrsdO6S6fy9aPuU2IrwUwL6vDTf7jqWPEi4oLYcRLBfDao5MT8bygHm+X1AQOclDpQYfOes6kmWbrnYN8Ge86N4wY/F7+3kCKqCLIl2zZCIMQL7nQ+mC7jrN6hENRmqmQ0zQgpIwI69pFP2Jscjhkmi/HcQ3kU4ecLU9XrcmH2xrF140BeKYTjVcxqVK1LYp8MetzTgSCXS1iQNAbWjERCdh0Ut/KHJsEYZ12IjUQfZXavAK5lnPD9+aNP0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:32:32.4932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f69cbc-c872-474f-c9cc-08ded77d964a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pankaj.gupta@amd.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pankaj.gupta@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-270186-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.gupta@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9B016EEE68

commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
FOLL_WRITE | FOLL_LONGTERM since:

commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").

Drop FOLL_LONGTERM when registering encrypted memory regions and restore
the previous behavior.

Fixes: 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
Cc: stable@vger.kernel.org

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..c4b53700f69e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2764,7 +2764,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 		return -ENOMEM;
 
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
-				       FOLL_WRITE | FOLL_LONGTERM);
+				       FOLL_WRITE);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
 		goto e_free;
-- 
2.34.1


