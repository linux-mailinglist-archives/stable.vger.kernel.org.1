Return-Path: <stable+bounces-92837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7079C61FA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CE61F2454B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031FF219C82;
	Tue, 12 Nov 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zjetUkD1"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C121894F
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441506; cv=fail; b=Ubcrc+HIsNZaL6eZTM6twSUY+Cb86ed6uKsr2pTMuJo25wokutbGUuutLtP6CZxrF4IpnR//9ZKzg1EyyUfDa2i6XNuvGY1QV+W0+sQex8WmRVu+1aOrluU1hGyojPPLWmTqj8VB1Qip+9SbdEDjL5yp0d9f5Jg3GVN8mJ+Ea9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441506; c=relaxed/simple;
	bh=mMi4U80veW89dqmiuShBkRw1Vc234HXdXWIBT+CQmmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtBC3y3EzGAWeFfE3eySDHEUqqUK+OeQsFuK0RS9OR8Zxf8c0GKxAHgRbnVB0bNtSGFMHEjo9o1XZn5CNDDukOy//aIHT+u1GbWUDQWFr359sjihNXHCIsz7kcobU1H7JOmIadG4Ux3q1MNpBn9sZj8UGMY6mXwt/M/P2x8gvVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zjetUkD1; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIu1Hf7+c5f8zR/dmRqWEfcqauXXLz4gcJJ/BBmWxy6YCYuM4dnUiI1JTI0eOdFU4mV/kRvCASBcCBUU8bH/6VVwLnIUXZ/w55f5pK+Qshzk3KmdqQE/oieZ63VBvq5wCHJUTxueqPeGTdsAlBfKGhYZdQqy8xcqpLGaD7kxW8t4wa+LGXHw60tQHmx6PfOBC1npgjHgZfRj6iZZLcEzcgp2XUbQu7YGKgsApvR/J8DMCYy2mkoIHEqK7sFx426es3iKh8/h/P1Q4KW/8H0cNlDgEg3Rq3JMuNSMf7tI6tn9iiIx2ev6qk6eth5e0ZHaXhqJjFNXqQbN4ZZtPM8hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdDTL48v4hINXB1Ld2kNS3YHPidBP8Mo1gSm/ZgS2xc=;
 b=DVK1j9Qo1ZbmWXJBgCwC0pw7mtlEkp1xLsKLrbJhyD0I+IV35UQBMFY7EWBdQtkwT18AGGbSdwVKXARRbFuaROaUHfvnjz/cEqX+sDfPAZuTIMCqbnbiHvwQ0EV52Qqim6M0+Khrk+UWk62r0tZ78bBHCPeZtCTMsWyPI6RI8DK1Th5N/OXJoKvVjDIjnBxtvLx0Cj4EFRldgKvEfJtK1sUrJNum8J5SmEz6ZHOtgn8PAul3NGBYPBkqogX72w+cINKwxdYyQSoe71DzrN8BBKmScXDqrBHHtqJsB2SflCShASgyR0LiEsnIrtPulbx2r3ziCaYdPYFfOHTLb1ZkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdDTL48v4hINXB1Ld2kNS3YHPidBP8Mo1gSm/ZgS2xc=;
 b=zjetUkD1fBMbBaZthlCT/WmCF6CeWEOVLN0ph0QizzkAgKYyKnM1EKpmZQscp54/FCEdqMZUvqZqWehMSLWuYHDHV3SLwigJzFXH86OXNcHZ/p/d3Aoz/igbpy1shp5ZYAMAVPS4NTyOUrLw54urDW5A1SQKwwLD6kPRpd6+OKA=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:58:21 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::4e) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:18 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Joshua Aberback <joshua.aberback@amd.com>,
	<stable@vger.kernel.org>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Fix handling of plane refcount
Date: Tue, 12 Nov 2024 14:55:58 -0500
Message-ID: <20241112195752.127546-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4dee02-0cd2-4371-4b49-08dd03545bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7t6wQh5vj6XrKSwemxbT2LdJ5I1aTyz3C4M62GbF4CoNTtGtE/v/TmovJiEo?=
 =?us-ascii?Q?OK2K6x55P/3dT4f8pnvsN99Ml+XR1PSqNioR0gOdbbz9bvnPSn3RFib63prB?=
 =?us-ascii?Q?Ks/jKh5xDB+B/SwAcCzM527IjFKvXD48MxTD/aCbCa4vePOYlPZmESElpM7V?=
 =?us-ascii?Q?1HTdXQTJDhCILfbMgwqdG992i/kN3wsZmPe0OJDzVJmMQhoYiykEAkG70YLl?=
 =?us-ascii?Q?1RaXMq0ofTonkD5Voyo1L13csSoUYct8F7XRxWBgAx7VoqxbMP3OCmRpdRkx?=
 =?us-ascii?Q?r8Md7zTXv9akjf/rInRqDeZncToqOaQG5YB/97o4R3/IsgKQBn5c9wpXU6Xh?=
 =?us-ascii?Q?f2XGcKO3Tq04suHvq9mn1UpDcTGRaHYy7ffWI9HQUMzCqs+TnAHOlqS3NPFi?=
 =?us-ascii?Q?Er7nld14JjfGQc51kJ6HhfAaKIOBtDkWukNNFL+QYCKPkJgd6Ubzt5Qy7mnX?=
 =?us-ascii?Q?38X9180zXdc+Dxz4Fm60y82BDcDfZD4ghFAlG0rupVnqXA+AE4F2yW/1/KWS?=
 =?us-ascii?Q?Nc5U5WvQKWh1sDGRBVKiAtffxJxyL8qwZwZHcZUY1BoCSWD0idTUrQoWkr46?=
 =?us-ascii?Q?Pe5iLA5IoZp1yoP56lS4ck3xQNaFs07T7QBpJ0Vnvi0owLh5rgjRTjOpFb7W?=
 =?us-ascii?Q?gXmrimVt/fWBxdgjbKNdA64vVh29ocN2PtHXOcmHpABJmeDFJK/UwgbFvP4A?=
 =?us-ascii?Q?GwFBOnmXryIJlyLrzR8i1TKvQlrkBRqtsiwugv1FPpRYkbJhldIGo8qeYitA?=
 =?us-ascii?Q?8yl+BxMOcmmekXiI4NKn/Jc7l3jw2iVgJfnN95fYtCw0/YjjT8zojeD4PiNL?=
 =?us-ascii?Q?CzzJGgeGyCwsSC0XZdpRDU0R/IBbtNOJ+C1/DD44H5fo+clkzDAbdPl1pAiA?=
 =?us-ascii?Q?gjmSLcLOctdXMN8utiwsZ6CwXGScFBLOL/rYNSh3LRxswZLgJmRtUiwGM4GA?=
 =?us-ascii?Q?p760jH2raABWWVZYjVU0VeAngdyB0zx5knFqaRCXnSwT93FWuCcLp5k6D5+t?=
 =?us-ascii?Q?/ith88PUXgBo0Izsjk7vLc3WviIxXf/l+xDGhs2bxBNU5QPYRZoaFB+bfNep?=
 =?us-ascii?Q?oeFCY3rqjnm/nvx4aeYTtzUPv+gPvQ4NueUrbga/hXTkxfIvjsgjbWJ3NKva?=
 =?us-ascii?Q?fSHU+XsRye490QAyxhdJX94VMDs00LY8AePx1MVXvjvWNkAVFkeAp1GsfiAi?=
 =?us-ascii?Q?NeM2mi9SrqHN/xazFgAQ0kVDmt4iekSRnbIQ0GD0Gj5/dGOp0cACKtNXcB93?=
 =?us-ascii?Q?EMdfyeHYOTtlc8i8WrGmLKXZaIpJCMVgNo7YKOENQ9T1vEuthnJlgCIE5+Di?=
 =?us-ascii?Q?IScycyyWUqo7EATMT+TfzFHtXqRyI3vnTBUBURVPqOD/aC8cKOp0CwbWEdHg?=
 =?us-ascii?Q?WIlGEn47H/vI0u8ZS2rbpP1zi3MNq7Z5GV1CZuzBtXmEOZSH+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:20.4944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4dee02-0cd2-4371-4b49-08dd03545bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The mechanism to backup and restore plane states doesn't maintain
refcount, which can cause issues if the refcount of the plane changes
in between backup and restore operations, such as memory leaks if the
refcount was supposed to go down, or double frees / invalid memory
accesses if the refcount was supposed to go up.

[How]
Cache and re-apply current refcount when restoring plane states.

Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7872c6cabb14..0c1875d35a95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3141,7 +3141,10 @@ static void restore_planes_and_stream_state(
 		return;
 
 	for (i = 0; i < status->plane_count; i++) {
+		/* refcount will always be valid, restore everything else */
+		struct kref refcount = status->plane_states[i]->refcount;
 		*status->plane_states[i] = scratch->plane_states[i];
+		status->plane_states[i]->refcount = refcount;
 	}
 	*stream = scratch->stream_state;
 }
-- 
2.46.1


