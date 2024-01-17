Return-Path: <stable+bounces-11812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115DD82FF47
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 04:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8509C28A5AA
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 03:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73261C05;
	Wed, 17 Jan 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fb2JbE7T"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A81864
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461868; cv=fail; b=ajj7MuiQyrEbKowTb0fJwwJGP5WpF08UODJ5Oyp87YpLKIuMLLhLinzN1khHGp1Ijqd/elEpyNuXE28ZKhpX61XDjDPt8DFR31OYC9aU+n1o+M31NIQpcM+CQUZeuvxya62tTA79OqQ5OWobrjvnlJmYCIzbrOQ2cxCSP5t/p0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461868; c=relaxed/simple;
	bh=x2OWN2sEEARaIpn7UL3WZ9+wMjfhx8T0QE0SBAonk9U=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=hK6FqRbh0EekG8G9+LF5j/VmTscf3UxTboaSQIG5SFPmlda7pHeI3jBXs23ynRfmzU6eDHvgEJUBSUeFfUbaeKZylalARFOuB5331I716wa+ekAob646gt82YrFNcEX4MGynCJCBVJJ/uWcQ8oWsG+HRcSNKiy7n/85h1vQuzCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fb2JbE7T; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2sYYvMz7RY4nlRKbM9mWQZ7FMu/+MjJveTrG1NBuY44sB9BgdhRi84/++z0/aUjX/FoMz5YT+Zz5q+8dJ8OUCMAb3jZytwV9HaTz4jlGvYXosVJCuM5BA8FxWxwl4fokbBuOB2TjV0kCkAhn0TNN6D+QQvCTIL2+CHEp1/lzjw7jY17fV9diQGMijSMU0HZ7WwOzuK5TiilRlPuif1X8cibdPax3P78oSHjb6Whb5EhjVPyYizgUwhvFQliLWofLEcjouIqhE+K77YBOi4/4TJrCTOxoW79rg5mUI/a/z/fFTWiJHVTIelymLaaStoOFBK25HpaEcKoL0FaEsNl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgZeBdNbwTsgNJxCq0Bv7tT4YxPFpNOsmI38+axLcQE=;
 b=JftxOvqrzZbjI9vGFOImFbyIXgLCqGvaNESn4FwnwO9+jVUps3ccC+j12J1qFOvcNZq9/qjo1zvxvShFyvIWjDSTCWj9y3opJi4hATgHRZvN1URN1UUUIF6GRnRzjU6JVLGsteOLuBFT6lFWolR/VwzUFY/KV79PqKYQR95sGc05egAwUyDD/xW6THpK42yDF5KH1+PhIswukOMnhHzXn8CpT9znI+9qzXstl9NmLH6KM0mmIsENKDhmAx2zjj9RQ172DuOlxOfHDDKm+Zszs5E619qPdyzMnBy0VHJkBET2EoD2L5TnglIC4Fj1jmyV0/bttHgVyRiRiRr5YApXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgZeBdNbwTsgNJxCq0Bv7tT4YxPFpNOsmI38+axLcQE=;
 b=Fb2JbE7TttNMZTBWh8xeN47SS1KCFe0HNuI5Mp64NOiKgySyFnGwIxXrGeZh7cwLs8yOoeO63nnpK/Q/br5YUA3fJODwloN5mkCEaRMPUPyusjQzr5FmbOSR9CSJYHghLgIg+Af6d8eNiSySCQxnt1NSTNgjtLtbeXbC6CzFcTU=
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 03:24:24 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4d) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 03:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 03:24:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 16 Jan 2024 21:24:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, <stable@vger.kernel.org>, Wesley Chalmers
	<Wesley.Chalmers@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions
Date: Wed, 17 Jan 2024 08:53:54 +0530
Message-ID: <20240117032354.20794-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2a7834-c7d0-4824-7e97-08dc170bcdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z2uJNCZdYRyvK2RvOwrVEV6HFimUEgXGKazyYkxsAqKQ6idnJ5wlS74d67VLMabp+v3I7qysQxOKEmoXpViX3Vbr4wLjW+o7f5Pt4rPIJoH8MbUDKIWAE+PTkz2q9QxOnYH6ZwJjeWzYbkRI0qWgLAiIpqjyyRUFd0Ehz68byt3xf+WWrVWIrvXBtVD0HAKv8PTlX6mBaJdG52niTbuidm3r2U/5Ga4A5d8zFB7a1y2gIGnvC1bC5xPHnNmUG1QyXnF+io4AGFX3H/kPx5+TRIcRsCB9GT/8afznv50Ok4NnYKG1O9STWgNHKSq9RKrsKJOyihHtME+t2j6v3bSNLVbqS2f/GlVrxEBQ8ILKbS395K0HZhQUGo7Bx4gvcZH8mKLTHm25lrGVWwpFy/itIfDGR/vh0Kukc8HkJthNgl1flXcNMU0aZJXpef2u5zrT7KYpI/1bf4fch9KvQNvAGBOQicRrMTx+bFAEQ8HHn+vFRykJjTVElnzTwYWZRWW4W6FXSxO/R4yj1XCmAYOAyDu8Heqmo6tO+/QI050zzagUqyeTCspWcXQ34d+EMfxaTiqigZTAzO8Tr925HsSWRphgY60CSMBKoDMgeEx2sHZpxyfdzkYxHHhlqA7MjGGdKoAYDa4251gcshmHIC0tOqMaBWHf+nNyH+gw16keU5PGGcVLUcd7tr3M2wTstgBbKbYAI/NnIRTomvxNgrSuuWUAhiyO4Vwfj6/03CohLeHecjfdfYnURnwLW2f8G852oWBmIZJ90KuJZ57r1AJfUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(26005)(1076003)(2616005)(44832011)(316002)(356005)(110136005)(54906003)(36756003)(6636002)(81166007)(70586007)(70206006)(36860700001)(7696005)(6666004)(478600001)(40460700003)(83380400001)(40480700001)(426003)(16526019)(336012)(8676002)(4326008)(8936002)(86362001)(47076005)(5660300002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:24:24.2672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2a7834-c7d0-4824-7e97-08dc170bcdc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

The 'status' variable in 'core_link_read_dpcd()' &
'core_link_write_dpcd()' was uninitialized for success scenarios.

Thus, initializing 'status' variable with appropriate enum value.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:226 core_link_read_dpcd() error: uninitialized symbol 'status'.
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:248 core_link_write_dpcd() error: uninitialized symbol 'status'.

Cc: stable@vger.kernel.org
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index 5c9a30211c10..2b2073dce389 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -205,7 +205,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_OK;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -234,7 +234,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_OK;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
-- 
2.34.1


