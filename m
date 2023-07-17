Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F5755908
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGQBXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGQBXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 21:23:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42D198
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 18:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqUXTsH1qqQzOYId9doy54HbZ8qYBiTcHFPYMTyp8ibK1AwSu0CjRHaHHo04wyJOPGO7dlQGEudI2O5IBgYdSxTzV+qDw4nrMuLLAGJHeaCW/l3M/I9kt/zrUQlOX7h0yk0vYf0EpOv6RDqL0sB6/hg5skE+XytukVNXrl78XDKxnHeL2aFNxlLZGHyF4btHSBd+E4jd/0/DUv0FovFeu55Y9W1dAFs7JdB0DLQ+iB2ZgZdInfKZHqrYPkzeLLa2xqjWIKVKqXMORFCiD1nCn5oKiLEq6d/AnIpJf3dqH8w3oDTVCOt5W4jMaNhyoBn85/x59TnSAuQoc2PRRjHGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYSqdbH+JyKFZd6qB5o4vJBpDKu+V/Mrsd2JtlzqzIk=;
 b=A8FKt1e1iHai+R3hOV4dAP9xiOiequEgvFMSXJP+bjQyxj/iu9I+MFqWliYweDXtMv9dKhBxLAPUvPKAZW+1pSQPDf5fE/C3ILo45NEhj2V39AJQUfLftZxX8wDYDTS0Kx5OiDditLPMWf5dKsHCBwcfE8iZKCyXXeZFJ2FM4VAkyVxTzXM0GV80/iIrrtukO58WwEv9xazpNnlWF9z4MpCNpOnzpiQp2ZAxIiz+9Iu7tym7Efrwck4a2bjxZds6oyytgIP/2UUsTdvetPYsLGSWnunjxKWA87ET/pW/inArrdYN2a6TCY5r7cqIc0f9OPz052/YGljqhrhc9NBWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYSqdbH+JyKFZd6qB5o4vJBpDKu+V/Mrsd2JtlzqzIk=;
 b=r9cRMXQwinTNGjinh2hv0A559J8Na9RrF6gy2zQPNFzOBlqVqXkJLLzDpiGdEEShLEUQZ4mKylAHtBnK3BKzW/vzwkYCIzvYq4QhqrMjb35STcGs64KGEksfWq/EbkhVvc7L3/2y3ED7G2HzZ60nyp2lZDratQJDHJiu7W1MBLk=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 01:23:12 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6d) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 01:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 01:23:11 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 16 Jul
 2023 20:23:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 6.1] drm/amdgpu/sdma4: set align mask to 255
Date:   Sun, 16 Jul 2023 20:22:56 -0500
Message-ID: <20230717012256.1374-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df237a7-db4b-4472-0628-08db8664630c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2/A1J3UWwg9UkH1ln9QdL/z+GT5dWvP1R1NBBy29HOkG8v2tdlzmUi6w1JRa8twZtBIKjR5ijstbjf036UFKMGIXTKAvS4DKgbXXNlM+xBkaDlVp2XRFnKUrg+XZGdNhJcVPwnyDVDFqwnhLbzKsVtnomeasqyYwFFnPzKKL7PIZRmyfSaKxPoLuS1O+3VJgVNG0qBO3WLLUJ22+Vr6hTZslCk3vc3c9fqZ0d99Ljedz+MBsoT+pf0lTFpdVsGIXndfkN5yJfFJBEdkYJEFxbpAnCmYeJvkdix11elU0MEL/pByYi6jNVTHhcAVDfvTkPBQ7c/d3rxXSBWBnqggi6PlRoPyzpgG5E/1VMt01eKo1EQUw2GzE+9IASlUTkoZ88etg6xWbXzC+g/RQSGWtfPU8N0pqIkNw++1Ti6/Pe1rZkrTHJMARP2TAlOk6aJDrehGukO6GBoXKpc3e2smbBBFoqwA1ABFBZcmqThTHHsuGVyl12YZcYe3YikGrT6q4JQEEAI2Eoj0MrGsXjSS2BHRuh0S1Spx9arTZVfcwJR0HvHKb/oP4ZG467fmrgFVRltwZpHCLxiHC/4uHD4CMkdWdSejh4IaXrE2K8eaWGqA+LiCpPw+2KA/za1Y5exFPhAqAjfMVYlxIXjymhz/D4kUK0zP4DduRUX/ao8+NSecjZhcY7o3X78uKsAx2UcbVhQpOedQTe2Z4aocmlKvrkZdNgj+3EnvbS30Qy00hAp+2714UwghzmZyeLyZ4m029qy+vw2M6dC5oXYNKz40wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(26005)(1076003)(36756003)(36860700001)(47076005)(2616005)(426003)(336012)(83380400001)(86362001)(356005)(82740400003)(16526019)(186003)(81166007)(40480700001)(8676002)(8936002)(2906002)(41300700001)(478600001)(44832011)(5660300002)(4326008)(6916009)(316002)(70586007)(70206006)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 01:23:11.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df237a7-db4b-4472-0628-08db8664630c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

The wptr needs to be incremented at at least 64 dword intervals,
use 256 to align with windows.  This should fix potential hangs
with unaligned updates.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e5df16d9428f5c6d2d0b1eff244d6c330ba9ef3a)
The path `drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c` doesn't exist in
6.1.y, only modify the file that does exist.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 5b251d009467..97b033dfe9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2330,7 +2330,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
@@ -2400,7 +2400,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs_2nd_mmhub = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-- 
2.34.1

