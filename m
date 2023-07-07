Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0805B74B3B8
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjGGPIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGGPIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255926B5
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOEEBLoQ6ouVJi2QvYuJErZtLS0nUY3xwliVwlQe/YswK2N2/x38YkAXOe0gIF2uqyqhDhz0XmS4xjQvd3q7IirXSh8KHXQUjHaLeobquZXG5Pomu/JJO5rAuc16sSzEJWPwzu3+2BFPO9WGfol0285CO+GrCn9Vct7c1oywZzcEEem6acycpTr9SlLcH0zbP7PI46ogu3NWIK3rPqyBy6M+R2mUzeqaNqq1WlUAeoKRJqXrHl0z8aePHGt74y0suKQFVaiU3W1dbwKaBx+UFNUbnyZzuq2ebIwpo/rchc7cSQ829E5DbRGgTlqKg5Z8b72TYXNnWAQzA2rE1ZptmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUMUj/ZdvmG3uLI6dM7UKBUOAAH5+PK2P8B+m1pC7ac=;
 b=Z+wpcVlh4OVSQAHXynwM3o4ikXJdZjqtSh9U9MtKMJch18ycGhxGSMNCJ/UDVGx/cOVMYPBWc8G3407vXIhvFQB+MzcbZN4hEC03eCazDzVyyeR6n9wMi7fe/ylo7dZnrXEy81UbXRsSnqugBOqh7rxEeNfhmMbnUPC6VICzVbPB02gxaF6Ywmd8K4qSWhOhaYZ9+gqNz5Sd5cauvHtQWQpkNXi5KIS+km3gcUOMxzkUv5hG9FL5JYCMW3h5x/sv2Tv7ojUe5BpY5kJ6+osYRAnJLVJ5mP45rxxG/M1u1fRnWmTzKgB/Uvqy/ObCEiGJjHQArfxa62oi0nXOgEwgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUMUj/ZdvmG3uLI6dM7UKBUOAAH5+PK2P8B+m1pC7ac=;
 b=b1atD0WcFKFN2rTXVg+V2aRQQPCVTg4AhkefJ4BKc4wC3ukDK7xWdKdynvOKGeImDMA4BtuBnbZcpfltRaScNe7xDCWBOxbwXAEeRAX+RljwvhGtS8ORTCpRytrHK+Iau/f5diLFknNNfUGMmCSwbFcy2ZQHQIYtBA1Lnd8DEq0=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:07:52 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e2) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:50 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/sdma4: set align mask to 255
Date:   Fri, 7 Jul 2023 11:07:30 -0400
Message-ID: <20230707150734.746135-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e8e970-f7cd-4b74-0ca7-08db7efbef80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Enhcsrq4jIeGsQXEaLfwNA0nTn3NWU1d2njEzzWNUrj692gtl3H6KzSBF4xdhUE35J30aBVYl+ciezTIkQ7xg7nvvNysaW9qB9R/k3KcrNGoNscE9xVty/ZelJ5o/izorWkv11CNVGcq1mtrYoi9A6OTZU2LV1CiHDkXZUx5mUXvFkqiBCSjRdtX1PlKhXEk3ovIaHcYJTsXZdMcJmvSDROKRvbf82cBkviMembq67i5TMM1Ifjfi4AbaTZFzaWo+MBzFncz5PGZg5fKYwm9lZE5ecJiYFbgYPckVLeJZfsDsHTb67LVtfYEteBaaZpuG5UHnlRC/z6VKNRMxWLJ+ZddR+6+J3DCm8IC9bIznyu4xGziXtOQtsk5Gi5MKBs+SYDVOTuK6J12sIObDoIRWljqLQ/jVj/sExTHAOSNh2CvzH4dXTPrpkVWMAa5SZ2bO68IsV7ZTWt7OdcvOn/g9jNh0/E69ifEH55YowlqTpH6I7rM2TWmR7CMF5vy34yy4Wbm0hxkQNRI8vcL0R+WFMHfZ5fprwIiIUpol9cqSMUMbOvafKnC9ckV8Eel1ihQHOkS2+KD9KpNfDrtPwcLMW/YD7LaM5ChiL8B9Mtzc9H6kUVBgUi8lTaTzyoMUU5QPV8CVW8LFjbqaOLqtIRk61RDof7olGJ/U/KsqdXrNqS3IWPXvUlbahgB8QbvwKO1gHm9W4NL1At9Jekv6R5HT2b5bdGmna6L6LGxXLksYG8RPFjDyqz+YgRa3IrNdFCuTcTo7AT1FT/IR/Nm1UieQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(7696005)(6666004)(54906003)(26005)(1076003)(186003)(70586007)(16526019)(2906002)(70206006)(82310400005)(6916009)(41300700001)(5660300002)(4326008)(8936002)(8676002)(82740400003)(81166007)(316002)(426003)(36756003)(86362001)(36860700001)(47076005)(336012)(2616005)(83380400001)(40480700001)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:52.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e8e970-f7cd-4b74-0ca7-08db7efbef80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The wptr needs to be incremented at at least 64 dword intervals,
use 256 to align with windows.  This should fix potential hangs
with unaligned updates.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e5df16d9428f5c6d2d0b1eff244d6c330ba9ef3a)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 9295ac7edd56..d35c8a33d06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2306,7 +2306,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
@@ -2338,7 +2338,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64dcaa2670dd..ac7aa8631f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1740,7 +1740,7 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
@@ -1771,7 +1771,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
-- 
2.41.0

