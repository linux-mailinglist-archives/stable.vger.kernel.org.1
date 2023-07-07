Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891BC74B3B6
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjGGPIL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGGPIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD2826AA
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMbphijCn2SsJPNQlj4yBvMqpRW2JmNsP+ClVhbO0y3sCf6Ty5WMjZoKmC5ADz0rJ0d1WKsDU4yorOjzcJthrspsQ9p5sHYU79jaBFe0cplyiVB4s4Q+U+xvTYjUZSbscGsSego4+v0n+N0XrqzGB+k8zzhJg1UeXYW6DBrZV0wjXWZUozF9IriON6kL5K8nDTXSVD7U1d+vf7YHroqsvmiHORnnfjzBEOpDZ84NpAMJLrXyeuTHiLoatTzZ7nWI4zdMmpxc26QZmU79901GZKD3ABcJRjTIy/tc4v//+wNXEm2uTCnL8AuXLVxcS6RR1ZBxbbXkx/U+d7Jvkd4v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6uwwbgO/jZE0cV3zx6Q9OlfzgMD0msDX9JHPl8MEN4=;
 b=kxUTSAuBmA5J4W7aYri4qBD5brduqjzhvR4EJm5jt6nF93fr8VLvzSwFq7VrbCyU2uvczQ3MAe9TKurvMQzn/AJD9vS6VuiJG0G1hpNj+qLyavJ4SX3RttyGukuCNJcrkfU3KQRgyHPKdJ8cFTQAE2fWZtLwmv0M3X+V6NJbIkdhDF7dtTOSJozf0RrFp/y0Vta51eu40KisFsB2ZNqgJm1HmRUi4xEhNZwWJ4J37s1Bz/Io5hrOEVd4MTdApwO78ueg5e0Zy2FI+Dpj406e0hckW7JyEPqkZol7IWIZ5pVcqWNRwkEylx1UFX2AnVDNE3fpuHCJI2pEAGsPhgLYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6uwwbgO/jZE0cV3zx6Q9OlfzgMD0msDX9JHPl8MEN4=;
 b=GBzspJI4v1sSvx6DjxZ2VfQfgm8nB8kg4AktofkRtM8NLbtTorMF9i8+Brepxdk+9eQ586WVonSlC1dCTb4AggrtGJmjKu2NJRptTr40lsh5kPxCJNYJzuGXiZBWixzfc9jH8c8RdYbm+PgQi5vwDDGhcdzYbRZbz2bo033BgT4=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 15:07:51 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::a3) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:49 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: Skip mark offset for high priority rings
Date:   Fri, 7 Jul 2023 11:07:28 -0400
Message-ID: <20230707150734.746135-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ece0cd-7f34-4771-07bd-08db7efbee94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hFNYR2hUq6d31yiXDqquiONbDLdfI/+1S5vg8XOtaXTxiEJZJP+oUxSPzHimg94u0W/W2CO4PgHcIx2HrzSKbweL/wwU3ZsQb7IJi5ZnH9UombzIRy3eifS6OpVf7DSjHPhvYzHoH+pN5XM4VG8Rwg7apdRzdeHpWmFsWtkWNCbKLmYifpCT2PGur9cFX88l8W6Z/Q3Mvp6zWSnkkAaZT6pXQI5dwu66yQnSp9wSKv0stHUQUoqORIuEBoBZ/o0b+LLQsIdGsSA/ggdG1uWsB4UxmOkw7BXqjpvB+5sIU5y5gElxfTTz+GX96dPM3ATj3RWLp6R/+akdpYcciI1F1Kj5tFsvFKUWfBJj4wcOwr1btG7ZkiiR1rq5Q20W+crg5iBMhPidRyRgtB9enNu+suvDUH+Qrwg8paJRQatRjiOKmu0NWBKcUTNLxnEQBNOi4h2vMBLxyjf+17umMB2sJ4vqxmrDl7luLTMvH1dZ6C+Y3+TLHDiAvFXzEJKghpBYj1fXjiYUbzb/gNUWQA8qbhMJRZe8m92ENegNOCrACV7L1AL5w5dzFUpKHjohrBcxVmxaQV2LNdIVE7vs1RIu74/IG1Nk4+4/7C2P4s3cbvjWNY/ZujKT47RUA09StunPv2kfm8T6+KDLevu0XnGMgIEE02QvIkINuV9WtrHtXBKe4S+1o4C1QnxLO7ymi2mtbeogUasNSPqmfgS8oWpvn8JjO4fT2jRhsT4bL9oVABN4HQGY+89ubaZDs1wLtvkParXutn9fewvAYYxUPWWFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(2906002)(54906003)(478600001)(36756003)(4326008)(41300700001)(8936002)(70206006)(70586007)(316002)(6916009)(6666004)(426003)(336012)(47076005)(81166007)(356005)(82740400003)(7696005)(40460700003)(5660300002)(1076003)(86362001)(8676002)(186003)(36860700001)(40480700001)(16526019)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:50.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ece0cd-7f34-4771-07bd-08db7efbee94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Only low priority rings are using chunks to save the offset.
Bypass the mark offset callings from high priority rings.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ef3c36a6e025e9b16ca3321479ba016841fa17a0)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 73516abef662..b779ee4bbaa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -423,6 +423,9 @@ void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mu
 	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
 	unsigned offset;
 
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		return;
+
 	offset = ring->wptr & ring->buf_mask;
 
 	amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type);
-- 
2.41.0

