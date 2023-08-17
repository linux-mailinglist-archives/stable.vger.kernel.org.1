Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022ED77F7F2
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbjHQNlY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351567AbjHQNk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:40:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CC2D63
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j17FBQ5fisb7/AKPuYb7SlFHInAfP5/LSd2UzxLIPZGepWgKN5zfaIL8y6PGBC9bMP+s/9dU4268naKya+aAhsfDhkS6t5XXSiUvIYD5ZNMloAwU8VNMNWmzdKERRrJXzemP4bqdT5171MVm/4+ZwiF9nnAX2YkY2IMqTkAcK4RpVhoCwIKPslp4gy0rZkpHXi9mekFG6jZYN7w1qeLDoFG0gaZyXScLrTcaK1ixSO2ENLrM8Jz9Djx/0gKP1KSs/gudXnENEoywZid9RdyyhAgGWZZCwX5WYeUSSwtgtSwBoFQB3sJHH5EmlFR3B8sBpNIn2HGpPak21grGH36jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PScsoAksGTZJdL1AfS5M/XjhsNVYC1RRQ5Uo8DjP/Y=;
 b=QgydvnJ+SdQQgchqLBf8/j8ZVMA8rJMvMAvztRmlaPMtJv9zaLdpFQVzBQMbD9l3nQLdX9G369ny2IcvFt/n2QUkuvgBNcUOPhXhO/bkdOAl4jHgs84DesDKbD6w376U16joc5QUxhdOXtR2U1xt9zkYw/YAJgr4jLH7jvick2a5f8ttRafdy1CFQZI0UbWmPzJ9o+qun0Lz7Q5r7mmmRJuXJL2aI+czI8fKdds5WaeP1pUeFTSRHHgiBJ8iT4Lqsk+JR8kBzFCc1iE9tsQflY34ugAPjX8XgcjgNtl8JgGa10y6KMd+3WHnYhgmzE365fE4PseqciS5O8BxIOvp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PScsoAksGTZJdL1AfS5M/XjhsNVYC1RRQ5Uo8DjP/Y=;
 b=uxzTvQvonTuBJKFgxWLQLU5elV0zokRnpML36Sx4Ok8Dwv7onOj5GjVg/ITuusM9efE1r3a+5Es8t+rQKiJehy99i8l2cEmVxTUrKPg6HEjNLRSN8UqIbqpADpsFMEhdQHSnRwnEMNMpfcYVrFeKVfBZso0ytP9WBsD1MY3PVXA=
Received: from SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) by BY5PR12MB5015.namprd12.prod.outlook.com
 (2603:10b6:a03:1db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:40:52 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::cb) by SN4PR0501CA0029.outlook.office365.com
 (2603:10b6:803:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 17 Aug 2023 13:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:40:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 08:40:51 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC:     Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: keep irq count in amdgpu_irq_disable_all
Date:   Thu, 17 Aug 2023 09:40:37 -0400
Message-ID: <20230817134037.1535484-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817134037.1535484-1-alexander.deucher@amd.com>
References: <20230817134037.1535484-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 283f111f-454e-48a1-914a-08db9f279343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7j/Uf9Byr+qTBMaxIjSZOeTadejxNHkpzLHZG4M6szCze5YndMjwr7J7Mhy6vaFSK8zo06W5NnX5PdSNCSyFKCcNlUordyP405h9RC4PxFX/40kmqhYWismcUV3srjjOUiabjSevA3sigXd4saFoVnxdLSfAo/OKsFtJJgtIaI0Ppq1gzMvs4zPMf3ZmU75XqMvZOqGpWsNUlsL7IcaXUboCfHZsQpMDq4Mouammf6jsDgWEYOUKfC/c4/E1sNpbakhWts+5TJm80IAzGDy3dmwfyaulBMJUJtoJhMqfFPiNVK8HEueor++NcFaxbdoimgAQhaUUzwe2lUHQjk4HkR3bu8ayBb+i5zqSwYT2WVnsQoCPJLc74I6xPEUDvsY1LhFJxhK499DV3T13pHoW+Mr2/BD37FXWdH7v9A6AXEj1rEq8GVsV54RXJdjzy2tXnBIdSAEXl/b9l4ZMs8wSCvEMr3A1lmtS2zMfF3kJJqxvQAJuY7EmW8hTc15iYmKpjYcgdol6HiqUA0xeiT2YGT3nVfvRcDTUQqW70fBe+ofGxv1hPcRXH6KA3hifTUBrbd35WbkZHHleeW92kQ0Y8y4ZH684BR0ij8rKHicSHgacK0sLrjfDNQv6lRFGfUKrEVCvDjA26FH+FwLCz3c9hIFodW9Rg6WxEg96w2NUQObkisbunDs7Bpx53/6Bp5ePt5TL6SFXFWbxct7iEItta7j5dIOtN19TV3xjq6zZbTTKR7iri1BOb48ZMRKVhqE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(66574015)(47076005)(426003)(83380400001)(2906002)(336012)(36860700001)(70586007)(478600001)(70206006)(7696005)(54906003)(316002)(6666004)(966005)(110136005)(16526019)(5660300002)(2616005)(1076003)(8676002)(8936002)(41300700001)(4326008)(26005)(36756003)(86362001)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:40:52.5651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f111f-454e-48a1-914a-08db9f279343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

This can clean up all irq warnings because of unbalanced
amdgpu_irq_get/put when unplugging/unbinding device, and leave
irq count decrease in each ip fini function.

Fixes warnings on module unload.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2792
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8ffd6f0442674f32c048ec8dffdbc5ec67829beb)
Cc: stable@vger.kernel.org # 6.4.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index fafebec5b7b6..9581c020d815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -124,7 +124,6 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 				continue;
 
 			for (k = 0; k < src->num_types; ++k) {
-				atomic_set(&src->enabled_types[k], 0);
 				r = src->funcs->set(adev, src, k,
 						    AMDGPU_IRQ_STATE_DISABLE);
 				if (r)
-- 
2.41.0

