Return-Path: <stable+bounces-11855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51118309A8
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDBE1C216E4
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3BA2136A;
	Wed, 17 Jan 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NJ340xrf"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAE219F1
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505034; cv=fail; b=U+E/LdSEZdMJdIgA0e8zhR0x6mOjVjs7KgT7RfygmTnahysqc1kIDp9MUn0PXEb9M62XoGw1Hpkc5Vsdk3q8aqqeIjJdmU8c+oDNK07zNc7BYJAIm4ZXYcY8sqsM9eNB0TudV2Wf4xmY6iMtMJu+ihVuXIa+1yq0XpeFdEwSjEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505034; c=relaxed/simple;
	bh=j7Wq5fXRRGPpRWF3PH64me3yRgXckqZINze1yDcZbjA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WS9w1FVfYkJndk9upWDbgrhCfeF2ysCEZZZSGitJV2s37v8mkvlCyQXlM3CftegydrJgPz9TrlM03OEbfnHbMz8hUwP+5o/7qhJlnSz6E7Vh18r6ri7NrYFi0YuLBqxWkQ/augir9nT8WD3DL8R+GPV44zmPvTE2IPmP9RLL3gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NJ340xrf; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNADAnsTS6cwBLcS8klE8u7qZaeTlzBA5sg89iyg/gq+U0z0j7TUXKPeW5l26ZZtNpPWDwS8UMee1dXK8j0c1ZaQCANmP29bawSs9HSeYcNEwwcSSq0bQstged2H042ZUjZiC6I7K6EVvb5neTkuUHcG5klIQz6eKlBrv4JgZ5QBLOx9N9QoKKbkMZ7Mc0ZzlyvNpoFYvZDywF1eWvi3h+KHrsgV/7WKKh61ldOLmfQdweykG/QwrKkR+n2402FhC/p8Hdharncj4ikebwL6Jv8KiL+1Ypl8F/5Tm1bvWWTKG9SLWI1vBUcY7JXSPy7lejuDEpHls9o2j0JdOBXW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSJu+H0ULyyokOMdJ58fvOujrP4M3uaUrg9lX7vGboo=;
 b=WJGE+qZ/r/iUpluHnSDwdCQUId9txdqfM+uYpb3XCppZsZWjzxZQRFVSfxFRfN+9a1sIMvUH7o6fCJ1avU09aiGHrWMk8XJv1zRiZbOkYhGwjN+PQR1rZvjfHOEUNB7Cmz15gNKCvgr+o8jrRcJK24uc9sGa5EAaP83Rg0UTOE9Euf2839rWSow1TJP1kXDqlZd8PztAFy9CMh6/BoWsuXaV3OKawQ6p34v5q0T88bdMUFbcAQH7XdwhXUeeekudgwwWr8vDeg/Suf9Elp/4HoadNc1lABjRbmNHg62PuRl0AU1v/M+b5m9eEIu6AUf735JpX0qD7vzsNd9wRqRldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSJu+H0ULyyokOMdJ58fvOujrP4M3uaUrg9lX7vGboo=;
 b=NJ340xrfjRjM/MQHH71fM4T5JcSz67xDAtwkClaDcvD45+FcFjUaYm+McNHDZeG8zAlJqpqZ82z7I1ko8acpZlyesHrYASwl7W5bKLmvAp9nncWV1tAoCv2R62yXmHScitXK5i/dLC9sJbIHxjbqJYOhihhPfmdBIpFKMjWRkLk=
Received: from BL1PR13CA0231.namprd13.prod.outlook.com (2603:10b6:208:2bf::26)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Wed, 17 Jan 2024 15:23:49 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::fd) by BL1PR13CA0231.outlook.office365.com
 (2603:10b6:208:2bf::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Wed, 17 Jan 2024 15:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:23:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 09:23:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Jerry Zuo
	<jerry.zuo@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions
Date: Wed, 17 Jan 2024 20:53:27 +0530
Message-ID: <20240117152327.204465-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117032354.20794-1-srinivasan.shanmugam@amd.com>
References: <20240117032354.20794-1-srinivasan.shanmugam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: ed09e3ff-513b-4db3-342f-08dc17704d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lc04oa8nNQ4bAEgVeHAKjRz/waY7aYhebSPQFbaru7dHAlkiUh2UapSps8AqgzGfX2yZXSptBuuHlPpnsJTSLdAiZEN4SMQBd41RqmqX6Y7rsEyPgPC3OznTcZ9oJfQ1fo3Oxmpg5pS9rwyYQ91cESyoiOluF236sD5+r90EKVolo5xqhoC90iDDOvrosL8ZQuSSnHVZQfluiQSRjwP93NlkwfX9tkfBhCTJ3/Qh+yHVzvB4f26mGZaQ1gZYb+xvL5DqiQvOC87f6QUQ6/Ik1kjtNvtl4VBoqptOfviQsBwlxe7LaVEmQGnPu5emYWrO+e3doyj/Ooo9vgspib1mDWC/sBTufGF/8ANbTtMVWp3ePa+p6xt+7TMSumZXWcRr0iPnyUAXcbkcviOAhec5eafd3xjviV4O+XPEnLiXTJqcKra78nGYm+QguZuuSMJfTzeWfiyOKqcsupV8rpi6ZrpXN+OM4op24IIB1Op1rDUCu0jPCrbCpcgqNPqcMLfD1BTbQFP3bFMxM+DKRxfzwa17lqDmTJseS8VId5NnM1aG4O3g44rA/2hzHgmBSoCptKiCAnBywJzalD8cUuFiBcj099gs4PmBwjXksxDMp66TK3NGyVBqx1fNft5uigJVqEO6vNNh15ErSwLQPFo1u4hRULcX3/cmYpdeI0gU7Rq8qKq61eum+o3uweNxBdCJ2DigVYw8MJb+bXiLaF/zLRhRZqfH/KGt1iB35vX2PePFCl7tepNfWvmwVwSBry8xyCjOBUp5VYrB064nXsRzZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(7696005)(6636002)(70206006)(70586007)(316002)(54906003)(110136005)(8676002)(8936002)(41300700001)(82740400003)(86362001)(47076005)(36860700001)(81166007)(40480700001)(40460700003)(356005)(83380400001)(2616005)(426003)(336012)(16526019)(36756003)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:23:47.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed09e3ff-513b-4db3-342f-08dc17704d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962

The 'status' variable in 'core_link_read_dpcd()' &
'core_link_write_dpcd()' was uninitialized.

Thus, initializing 'status' variable to 'DC_ERROR_UNEXPECTED' by default.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:226 core_link_read_dpcd() error: uninitialized symbol 'status'.
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:248 core_link_write_dpcd() error: uninitialized symbol 'status'.

Cc: stable@vger.kernel.org
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - Initialized status variable to 'DC_ERROR_UNEXPECTED' default.
  - Added Jerry to Cc

 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index 5c9a30211c10..fc50931c2aec 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -205,7 +205,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -234,7 +234,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
-- 
2.34.1


