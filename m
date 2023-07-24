Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB076023B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGXW0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXW0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C410D
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaWEieTP0LFN2Ax7ez+Gq5idL8TmvWO5IkP2PX4ABKD5677xdtiF3BgQLpQdOJ3ijIum9VWOJPdXMoqNOnidlUDU8YRmcbRDHbc1A40Yv1vkG7XnrcdQsrKZHQnJAS+L9tenU0tw3S9bt+t7uZo7QQ7FcGmdzkkxnQuBzu+Ce8dSiP+uWHTQEJQASfR15Et9A5eq9FHKm1EKDTvfp7xNgRkXsiHpGqxyC3w2cQAeKhylOxAm6qADrBq/tv/CRFuMi3kWQa2uzKmFGVK5smwktPCCxewGcICo3nscfKo5ABMbvhBSNjYGBpMbBxkfnkLw+lunWEzeYQCLCpH9opCksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sAYsLpabHyxHbjDNxKdkcFtpfcTKHOPTWhV8VG+gp0=;
 b=LUJ7uUJweOHVUXbHPKE4p3kyXh5dXwpLL+TcbVb+VGVlAAIK+QRZ33IEf6PvS/ungC3wGNye7R4FVf8Ed7gKWxDcLFg2fRy7JLkQURzutKT7pLKKGNRb7d8rYuzcNBX7/XsW9y/eSKs5R/nYwcoBvAtF7iMttMEXplacr73hk0a/L1Nq0JJzWKH72CIGVi2tBOw7km0tkqfycREJ6Qm3ooDNs+164EmnCAQcLlM1wOCrFmbO5LJpeW8qcTXHiEnN2RVpG338BX5vQakL/KUSSI47fvhYZwbCmG+p6TYntUGTMuBTsqCOK3PGAWHaRXULG/L+pohAk+I7wvTJLe6Beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sAYsLpabHyxHbjDNxKdkcFtpfcTKHOPTWhV8VG+gp0=;
 b=yUBUY3klHzn0WOl9EACw7FA8LAQaLm3l9XTK9nh1DcpCtjjHIxPp7NAcI9OtRbrw8m80pegOgfmodrHLXEhmwuX9eAhtXKfnlAUtJp7pYTCBbwbipZBKYopM0DrxX3g7EQPFqvLckpUNPGLhAHKGrzHtTG7Sl/cVKM0SBVdRe/k=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Mon, 24 Jul
 2023 22:26:42 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::f8) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
Subject: [PATCH 6.1 0/7] Backports for "drm/amd/display: Add polling method to handle MST reply packet"
Date:   Mon, 24 Jul 2023 17:26:31 -0500
Message-ID: <20230724222638.1477-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dc6b9e-81c4-42d9-0ca8-08db8c950e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucupHPFXXQtoxC4H+80as4kNV4Vz6QVhdxP2ZsMveOJzLgos27e+2ieEa1+BIMdft3uXbloKIJZlC09pPE2LYdl2a0HehzByki5Vjo9McIoXI3z3+Umq+eyR+2RZrLK6fAVmNTEFp1RydU1hJv5VjxyOgnYqU40pMMCOfBh8ZqXWiFpBugbLAL/b5fBVOdmWKyPdB4R8To2/JM3NQwci+N6CUDztuVaTQxZphCQKJm4bvKMWhHBqaUEg4y9O3/IBn81pUb1kLuUDlTX9QLOrmggTyaQBvdodeFFRi6+DYS9ptZBNvzoPCXZnQEiepTXvWJGwwAI8vvt6EwrLve+pNg5Kr+wOvyS4Kf1ABbC82JKw5r3cHHIK0Ge4tWTvYQpmQ7grWoIAxpZ6tY8xHZtX8MAixE0GERspb6SnMeJwD0uXUn7tgXEqP/R060OANQf4bOOXOJAnIav0Vv+OrVZy2uSkmnzKvYj5RV23ZYCzI3ZHVUHyZ9QzehDxnq1VrPO6othKQ1EHE5u9no0SqVWWRUiCQGUnhxWYYyLZUmuy44iHX67HaYNpZqhP3ZIuchzdgk+yd1unGXX+GzY1EWr7eqEWgdQ4S+vw5bu2Q4fO2xBVJH1yEw318gEMOWM3XXkJaY6hhV4kb83rOZDJq0EmcfyPrznL2CGZ6jhv6GTGOa4O6YXP3WUOFyoFfeJUZl28xjUJbmVafRgFHNs3uF/6G6RzPX3n4ZAdfPOjHWzE+w0hR/n25gBCRSBtIQ5Y8my8DZwyNOn7duAqHqUMAhoMBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(426003)(7696005)(478600001)(1076003)(47076005)(8676002)(316002)(8936002)(26005)(5660300002)(2616005)(6666004)(186003)(41300700001)(2906002)(70586007)(6916009)(70206006)(44832011)(16526019)(336012)(36860700001)(86362001)(40460700003)(36756003)(40480700001)(82740400003)(83380400001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:42.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc6b9e-81c4-42d9-0ca8-08db8c950e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

"drm/amd/display: Add polling method to handle MST reply packet"
was intended to be backported to kernel 6.1 to solve usage of some
non-spec compliant MST hubs.

This series has a variety of dependencies across amdgpu_dm though,
so the backport requires several manual fixups to avoid hitting
file and symbol renames.

Details of individual changes are in the commit message for each
patch.

Hamza Mahfooz (1):
  drm/amd/display: use max_dsc_bpp in amdgpu_dm

Hersen Wu (1):
  drm/amd/display: fix linux dp link lost handled only one time

Qingqing Zhuo (1):
  drm/amd/display: force connector state when bpc changes during
    compliance

Srinivasan Shanmugam (2):
  drm/amd/display: fix some coding style issues
  drm/amd/display: Clean up errors & warnings in amdgpu_dm.c

Wayne Lin (2):
  drm/dp_mst: Clear MSG_RDY flag before sending new message
  drm/amd/display: Add polling method to handle MST reply packet

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 407 +++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 125 ++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 121 +++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 141 +-----
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   6 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   4 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c |  54 ++-
 drivers/gpu/drm/i915/display/intel_dp.c       |   7 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  12 +-
 include/drm/display/drm_dp_mst_helper.h       |   7 +-
 12 files changed, 571 insertions(+), 336 deletions(-)

-- 
2.34.1

