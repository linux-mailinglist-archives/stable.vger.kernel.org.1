Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8044E7BEA0B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjJISuR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJISuR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:50:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5EF9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSwsaQSSCJ3ygizTo23ZvhzgEjlN/hJILX63i3m+8YOGeUSjoLFqpfSFOe+ZveUbdFSB6iKyEwrAaBcbCa2ZaW8UviRsOd6q0T4pV+/9AXlXVp5WlJOgnas+U1WCfBtXFtgzRkJeel9ChTVQ2vbf9XSGeeiiTJnfgr6tDRavivUF0GX1t0KzFFp65kIJC1EE0UHK3B6rFnWhK6Ku+YkfJzZxRNMpstzIK0xGU3QXZGoiiOw6Lt6fcry4fWIEe8o49IBrXO6DtO34QI2hG2lxV/yN6+b/Q8Fp7kdQmZ8yM4OdF33ClWfCpx7oA/DWc1EjmVzS3RqLB6Gy4RDMONOdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkPi0sOEXSwDkqkOUuEkFdILLP9adCEK+q/3+VzeDLg=;
 b=c+N/KTjkjF/ICQj7CBqLXdqjHZsktWfI68D5TJAQTayp9jfVrD3j63L0GBl3T+as87hc2An7FbSxwoCGeAKsca4OKbFzVOAEJuFV7wMVq860+Ri074y6tDU4RSdwB8fx1nk60drmIr+v0LILOZIdMENYc1+l6uQBUfO/rhEJR39iW8mnamHmain5HIdVy9WxIuBjaeNH7GRgL8NillLqGqxJa1lE6BSlPeZHNC6g1sBzZHpcB/DbD1G3EVRhsWnMUWbZtSia1JIaJsovlNJWP5ksvS6NWy34xJqRpauiwfjdSqBJAFzV7aS4NDUwL7IXYJzgVjHQMH8sj/SdPpuHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkPi0sOEXSwDkqkOUuEkFdILLP9adCEK+q/3+VzeDLg=;
 b=BeYKTob2aPAeTeNz1t6m1sgstcxU6UfJPE3pP4SNdGNuk9RqSlTTs9sinP1gjFGoDV9IolY/umpoHmEIporF7RDdLe3wcJU+zsuJAXJ++8Fp034KEJNuaoV3sriuM4wG1Ac43b4Lxdwx71Wd9++DO4y4RXGghiTcySaqt29dVsA=
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 18:50:13 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::e) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 18:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:50:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:50:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.5.y 0/2] Fixup for drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only
Date:   Mon, 9 Oct 2023 13:20:35 -0500
Message-ID: <20231009182037.124395-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd469a1-73c3-4459-0f83-08dbc8f891f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxIiP/EgBxJimt3DTb5PRhbxMYRDsaHKgGKjxoYDtuyT3SXX1CX/tItQPNjGpV6gfhKVTGE61ZGAbsLSTVzvdmyBN/117SXtdo48GftLVlosJYOBWVsxq7xkIZwKylSTHl9yjHY01LyasBnapRoiZzf0I0XSIGHP0pj2PpqRiW/SHpDxO1krlcycSzqMG4E7qapzizJxEz59VEyoAgJCQY5n3xeYROpapqWQHbnfwig0dt40mNSyxUCfvrtdzNK9+iQ3NKz2cZAFkQ6sEuvhgrti5daLfWXE9NTZDK9bERtJqnF7Lj9VIgM7IK7hnO1WQGGbNeYdOUG1MzDk6u4YntEfegU0tTf2IUdEhdxISbEBSwWzz2p0aoWqF7IWDaOmSrXCRqwYYULAhhTNx4/XtKE01guHhCkze2PxUqPkpEVXHMg348LVYygajhkJgX2TsXEh+lPK24MPK7KELJfmRMk1tzAvC6pknytnQ55g1emuyialH+kXmSwLfi3g4mysttbdSu5gWG4jtaewkZJM8iLNPFCIQx5ogJgLQsDGkhzoNHvoKy3+AHgZsuIK9LbFIvrkgDZnjMNS2Al3yhhn0rC6wouBEqmczk3k6tPV6/c9ogV3v2gnN1GsQ9Q9aonfyNeCnLwg1M4eCkPrX7gEaNP6Ite0F8PLg28jy3yPkAAs0dyPliQUsVefDvdM54fMw5+nEcYdV704YiytQKixHebVV7WM1MPB96Smzh+Yw+75Lu63fufTfjUeiAMNe+eypG+t9wt8c2ayM6nG/SBYnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(7696005)(478600001)(4326008)(16526019)(8676002)(4744005)(2616005)(47076005)(83380400001)(426003)(336012)(2906002)(5660300002)(44832011)(70206006)(8936002)(70586007)(316002)(41300700001)(6916009)(40480700001)(26005)(36860700001)(81166007)(82740400003)(356005)(86362001)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:50:12.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd469a1-73c3-4459-0f83-08dbc8f891f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit b206011bf050 ("drm/amd/display: apply edge-case DISPCLK WDIVIDER
changes to master OTG pipes only") was tagged to stable but fails to
apply to 6.5.y because resource_is_pipe_type() isn't in 6.5.y.

The commit that adds it is way too big to be stable, but the new symbol
from that commit is viable.  Backport just the new symbol and enum to fix
the backport.

Mario Limonciello (1):
  drm/amd/display: implement pipe type definition and adding accessors

Samson Tam (1):
  drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master
    OTG pipes only

 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  35 ++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 106 ++++++++++++++++++
 4 files changed, 145 insertions(+), 4 deletions(-)

-- 
2.34.1

