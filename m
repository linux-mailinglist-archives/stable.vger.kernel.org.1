Return-Path: <stable+bounces-210613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGt8HBAOcGlyUwAAu9opvQ
	(envelope-from <stable+bounces-210613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 00:21:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAF4DB63
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC934B2E6DA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCE3ED121;
	Tue, 20 Jan 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oiV0B0UE"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFB44DB62
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947985; cv=fail; b=aJQgYpNn6JRLQWw9pzNUWTIY01ryyYPteEMDKCsq27zUg5pPaYtQDQp4OQyJfZe0xJXA2y1FgrzJstLp925Y8eHJ60oB6ODWJnpeOgxhPCGaHxB8PvLPn9MJLqdYoBFue6MaRnk2mHxn2Adn/DP1P6cFIgUNHQDmYqW7KE1XuK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947985; c=relaxed/simple;
	bh=mFp5/vUKw7WuqWRZCSw8cT0KL4ui45F6gQVYhZI4XBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnwRTi+70ThKrhB8ffH1Wbz2d5nMc/3455aLZUD8bzrCX2ZeHHOHiWOQiDsQtFSJW3zDvdoI9ytYfVK7z9cZwH12sPjuUWm6RsxIDDS3H4AUKX5O+rkwBMTegpcl5IzNof01EP93a6HqMTn8q+HfDAjdVe5bEsc58H1ornro97E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oiV0B0UE; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM6zDsogtNIvVIRFqfqWe6NiBeXNbFPTbxCMLyTRj3vnqvRtpAlCWBCILkUdEREAbV5AUxxPC4vTH0GcPy4H3709VQL5koshcmauBfvtp2ZTfz4RcIS8/s4tB8fLrAjAMUKopCrsivBnNl4E2wiZ0Yl8djuGR+1IPLVz7Tn5mM03pBJ49cDMh8HrlTdYbzNX2njLM6u4YDxPOeDwwVBklenihojlqe07G9VMNm8KHdSfkl/HS+xqVLzInJRZW40kT2HZlWLhw9laVnVGVyHxevQbGGB2PjPjrRF67bFAc8iEp4IhScdxRWyDE0Ivm/YFWTqh/wJvuQBKz04ouLrxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MPIU5P/L0oviEyipS8qXH1kHMO/uXnINi+HIub8Asg=;
 b=IVw49CDpvG85WWegubgOqmPz9rRN8gNuCFvM4v1rXbGs/5Tv/4hrDo6Lg3W+GDxCoJ+kX4eOPTYCu6VHrzpvfQ7nRCp28f7LRmrDuyXbUU6iwzescHJ8J4W/fo3VorIdbfclu70enRhfhNk00OV9YqZhPcQw/yN+YGpJv+p+4taryKTsPaaTOlGW/0wUfOdm12ChCuxCI2dRCiIhS+GzNtppjapq6SRf1OC7nhjj+DENpNFRkaBS8n2pkUcGdBSnw0z5AzMeM5TH9VpEc+p1OyUQhy4Wf26oL7oH01ko2b3r3uNs7QPG6mQAkl5ZNhhXGEKfKO38mKEhKkHJbKV1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MPIU5P/L0oviEyipS8qXH1kHMO/uXnINi+HIub8Asg=;
 b=oiV0B0UEMr7PPejrZC62/OPuRTy5PDBaIAhcV3YmANSe9PoJNwoMGElU06E9EYUnlN5MdhilhKLPUc8kqj/GYp43Xh5wyyKP88l1oynXJ8wvBEnT0nq4kmaDrVpcodP6hHdux2MyuoDshwzxzjOGOgzewKSsRe3LpIpCew0ta3Y=
Received: from CH0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:610:cc::12)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Tue, 20 Jan
 2026 22:26:15 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::f1) by CH0PR03CA0067.outlook.office365.com
 (2603:10b6:610:cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:26:15 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 16:26:14 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, Oak Zeng <Oak.Zeng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15.y] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Tue, 20 Jan 2026 17:25:56 -0500
Message-ID: <20260120222556.3313679-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026012022-enunciate-obtrusive-362c@gregkh>
References: <2026012022-enunciate-obtrusive-362c@gregkh>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: ad959de2-199a-42fe-3a95-08de5872ec8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/cK7n+gkOkN4UFqz7N6PIwIk2ajSWcrdwNmnKJYKUy0r0LyIj9fRJpWbF+T?=
 =?us-ascii?Q?OE6FuNkD0XQvc2kMOANPL926BoirbBP6V5jBFQxj0n4afTRFKFpiJM8SB1Cj?=
 =?us-ascii?Q?ciQht+jLxcIrgOAkrQMzonpIxphgibYJrjeRU777L7eZKZyCijsccNb8kKcf?=
 =?us-ascii?Q?03TP6Mc5RMm/ayoC1+S/BKFD7PQ7hjxotlOcIGFRTPvnxgFKNQpQi3iezoxk?=
 =?us-ascii?Q?fiffTJPVRqk2tNNv9pnHsWDz2ChZYRvbBDqgU7UhPaXOuxIiwvewANEY6/r5?=
 =?us-ascii?Q?b3qgW9ayl3PBVrHztpW/Cbtd2vNxC5Zye6oGyi6s4OXCCNZasq49FvWz/yXr?=
 =?us-ascii?Q?1NSXVxh9617TfKIslxsd/6zmNdPqxkiLnhPYg8HrnoSXbImrUC442W0llQJl?=
 =?us-ascii?Q?0zhUMW4dMpGQFHg837THxI1dler2+qxsilsqe3hd4LFG5bC4ANRm3RqG2DNN?=
 =?us-ascii?Q?uTgKIU4NE0EFV/I7fcIuA/gtyk+2S4vR9ApM8Rlq/wzcQXwEUMbqveEpJFYw?=
 =?us-ascii?Q?X74S7wV7dCm7jfIU9VLh+RPpC04k1YChZk9bLSnPMlwL6LAOkz3uQVok/T4Y?=
 =?us-ascii?Q?/Fp3m9S6BF0ll79YrMk5k1lZnoJ/05gdcLptLg1YbGRpkdOLqkmnf9jIi1TA?=
 =?us-ascii?Q?OQ0DKxP/Qorlh2TYSrFbqaJ2eThfqTFwpPNzetINa803gfSLI/Wul16zbxEu?=
 =?us-ascii?Q?ennpuPtGsrwsehQwkSSQCjxFDIvriQhNEQVtv1ClQYfnkA3Rhp/O8hBYPXrl?=
 =?us-ascii?Q?AumgXU0/knTeN/VKmsRCTY42k65Zlsy8wzlKjOUw3ynevT5dIeZeuMsBvIf6?=
 =?us-ascii?Q?aY60qoR30nbDmG1b9ZAeu/ZE7vIYAh3zviJFu4lqbwrAIscg+HQe5K+48Hla?=
 =?us-ascii?Q?xq/4ZNkKk7BuMB1KS7tDxlTGJGa5fymu2j8r/BPQzsx8SWRKGyEEA78HQcym?=
 =?us-ascii?Q?tzwAtL7aacR8wguvk03/+8EO7f+1YBgPdA/D7VuwJtCxVW9FWGNmfkymb+wK?=
 =?us-ascii?Q?lpb26NTaVdoZUX9yH3LENO990Yz09HjvR1PVnUtsGFPYKVmn9xzk4NOPNgam?=
 =?us-ascii?Q?L8f3PjiIbldqTKJXbCmNxgB2xICpXbf4m8Pc5iaU8HMCIGRbZh6VPhRCwGDA?=
 =?us-ascii?Q?cpDjY9KiHjic07CRgC+HRKool75C8h9hmblkrIN1IGZIhxtNdwoUaMMZVTja?=
 =?us-ascii?Q?xgWGf4pjvPEi+5W60d9irLTVOwsZoQ22sZLyaYBD+PRBepHRORqAidILeb+H?=
 =?us-ascii?Q?qdu+DYY7chAppgx8LLl0QmGJvfHHxNkmgkqQn8ZpLS1PGYFG8HyP4aPK3ps+?=
 =?us-ascii?Q?P2G9q7zvAKrX0jySCXF3KyqH6bdbxwAzlVMZ84jns2T6kjNE5ZKXPInKOsoa?=
 =?us-ascii?Q?Zuz4LadGbhtf4DKAumDKC1bwr9m9Fn2Jl5PKB70/opjmEtx8nZFniwdeANwb?=
 =?us-ascii?Q?t/wnwNP2lpOYwh6gQeykzND9TmVOzK5uCasTLEO2iNbwLc+bZ0KfGwS2fHjz?=
 =?us-ascii?Q?F6B1XcVVM5M2eQbaxlR2jS4PoVG5686sFvivZcj7s5GjTXmua6jvcfr73KzT?=
 =?us-ascii?Q?snvGNW+TIau0Lw9y+ZkwpCq9rAlhfJNUB3AOmrAEiDNjxIupCr2TmovaMwB5?=
 =?us-ascii?Q?UYffXEEEzXWA5npmp8VtEeurRwjc8upedy/1W3u00lvgzQ+3WmrHA1GPV10R?=
 =?us-ascii?Q?6qVi6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:15.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad959de2-199a-42fe-3a95-08de5872ec8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210613-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A9CAF4DB63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

If dqm->ops.initialize() fails, add deallocate_hiq_sdma_mqd()
to release the memory allocated by allocate_hiq_sdma_mqd().
Move deallocate_hiq_sdma_mqd() up to ensure proper function
visibility at the point of use.

Fixes: 11614c36bc8f ("drm/amdkfd: Allocate MQD trunk for HIQ and SDMA")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b7cccc8286bb9919a0952c812872da1dcfe9d390)
Cc: stable@vger.kernel.org
(cherry picked from commit 80614c509810fc051312d1a7ccac8d0012d6b8d0)
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 442857f3bde77..26929ca5cb2d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1847,6 +1847,14 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
+				    struct kfd_mem_obj *mqd)
+{
+	WARN(!mqd, "No hiq sdma mqd trunk to free");
+
+	amdgpu_amdkfd_free_gtt_mem(dev->kgd, &mqd->gtt_mem);
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 {
 	struct device_queue_manager *dqm;
@@ -1980,19 +1988,13 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	if (!dqm->ops.initialize(dqm))
 		return dqm;
 
+	deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
+
 out_free:
 	kfree(dqm);
 	return NULL;
 }
 
-static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
-				    struct kfd_mem_obj *mqd)
-{
-	WARN(!mqd, "No hiq sdma mqd trunk to free");
-
-	amdgpu_amdkfd_free_gtt_mem(dev->kgd, mqd->gtt_mem);
-}
-
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.uninitialize(dqm);
-- 
2.34.1


