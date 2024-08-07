Return-Path: <stable+bounces-65525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE094A239
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177631C2233A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA41C8220;
	Wed,  7 Aug 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzooSM7L"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7D1C4610
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017460; cv=fail; b=APwSsUeWIRTBN7eDYrOoM2FZuj++NZv5HArxPkVJ7VtcAMRuWSfIfDCIE09k9i2ktboxK2J8AqN+Ad5cgMi7yvIsoyOi4RaJJFVgIO230XRzQf0exXISmYI5ASnWpTNc/2ne78U97pULSoqnaE/QKuL7cutKAusOiJZzbt2MCQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017460; c=relaxed/simple;
	bh=Lkf5Dn2OB/ej4MC//603lVIULdGSL015+6xoCDbH+no=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSsWYRMLNgn++nn67XEkieIKkCCkduMqu+xxeLBf08wjcqQwOcpmjApBhCQ/oWSpxtg3YKxlsHvhp+Zj1mwG+rqRbXyayj0MnoZFI7C1AgY2olj2Q0DS8NHj5a6tDB1NM1DWnjEKOP4kni2CrVbSfY0jeNp5HjyMwfnMUv8VDZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzooSM7L; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuWMsr6C4OdTJf6Wep2tPUZ+7OW/6Bkm+YqWgraFvMEji9jlFFxF9mcO08WjRcwADS4q008aTFM8ERws20cGmEo2QjTKvLUXa4GJQ6QQqds//1vBjpRPMRUX/3W9nP85i5rrGPYqPjX5hMK+F57w+3xmxiQo+DrCH5dNL8ijE9H2vaX80iTLyTmt7sFRx1AaltQtcX4k96hTAAwpB0TTGlGATNBaS9CPMEFczWhJHo3yIIfrJXEXLKCXNGequdaoBFRZg8OrsoQyzqqXiXLgrACSo9LXCQqtOYZer9OQd7yWUdUOnom4ebtNz0p+otUDCTiu2bVFVw1O01uWENyF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPRy7vaPIJvodnJqLK/sFAFZpW3eKLAz1cemkVaKGUk=;
 b=IUVoBGtXY68ru1ZFLbKo5Uy1GjJecsDficmfOz7QOHuvcOg0b1Pts4F4AxWqE9KpnPP2CvH6kfg2yx7gzWhxbdAhtSU65vQHEAEvdAlMRwLNxR5TtP5+DqYqilrm1bcQos9qpQaKuxWeiyTjCnR+eZUa4XqVhJ46lrUeCQHOinEy+6KP5C/Kg0X8TQl997g44850hvdp5rHhap+TY0xTf3xCHN40zoyd1BdRYBx0Z+9EqYQluGLQAy/KvpOA6HPm3XxT6n1aZF3Ogqj/Ach/sAW3AdJmtIPoTdvbjn9iVsUsUlH8zxR+G2CFVX2y+qWNW7oRtn2EIS7PQPNu3w5oUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPRy7vaPIJvodnJqLK/sFAFZpW3eKLAz1cemkVaKGUk=;
 b=mzooSM7LsOpbOatZijVYgLrf4gvKNHZHxKonXKIz4ThzMszTUHZEMx82LPFVkbeLEN/SN17yEceIfJ0PXIVGkRrqjP94hn13orY31xdcOVN0fXkdaJzN764boScWV7ZihmH39sIW09thecxi3Rwe1Cx551LERgf5TJ6mcBCM5QQ=
Received: from BN9PR03CA0798.namprd03.prod.outlook.com (2603:10b6:408:13f::23)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:57:34 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::7a) by BN9PR03CA0798.outlook.office365.com
 (2603:10b6:408:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:33 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Melissa Wen <mwen@igalia.com>,
	Xaver Hugl <xaver.hugl@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 21/24] drm/amd/display: fix cursor offset on rotation 180
Date: Wed, 7 Aug 2024 15:55:43 +0800
Message-ID: <20240807075546.831208-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: c17e5eb5-058a-4956-cbf7-08dcb6b6988f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivZKaQ2LNNs/eHdiHQQtiGZpZKdtjsTd3QoX72eEzzAXBkR4Gjhl/c6RUXS0?=
 =?us-ascii?Q?OUr9wTQBBJVHPvBPwpLyWgRWw+U2XSKsKAEH1IrzRlcNLR5IXB0YhlKnbkYy?=
 =?us-ascii?Q?uQk4NJBJjz1w+s/GRNbg5Iw7IFoH5EEKd49Y2m9hoY7vha0XFuadTVx6LLHv?=
 =?us-ascii?Q?BhopiNZuaCOnIudmN1W3cP7kmCEkGlkQsMLSzCLXsXpRCAWi/0zzrSvzgFRG?=
 =?us-ascii?Q?5MadSiA8J8Sex2vF+lq+xb3Bx2zVVbM6C1RLC6+mGM0i11eD3pY0g4lypZRy?=
 =?us-ascii?Q?xc2RFYtUMiNKhFGB94Z6WPhg6tPdQ253PPpFh3wN+ugY6AbDthoM1LhRed9g?=
 =?us-ascii?Q?sZkFijOuIwM63081vhutekIYOjMIL3l1S6Gy2/xN6tCJs12J2KfuZ92MFBld?=
 =?us-ascii?Q?VINZ4XEX8MQlRVc4VDCBMhQUDItfVLiIw31QuNR6qV9idQhzE+MMOy3jHAZq?=
 =?us-ascii?Q?FPXh0GkbzFahZXKdr39Xj6r024TYkKD+5IAtF2g6lxOCcv7vhfWw33ZEcw/6?=
 =?us-ascii?Q?viNWICfw7lgSO5h9t7Rod8t5d+MLXeBwCTmHaYq2GRtNcs7hVE47Sr1b4qiO?=
 =?us-ascii?Q?9VsW37OXREhssRfkuesW4m+ls7FWKDCa5RZIvnKkczNs17VqIiqAWNy0HlID?=
 =?us-ascii?Q?j9IeHsPWy9Sk1AybGT9AUAKDV9h5pq9cPmne2oLdbIPORkn/EoVVOSMSYj3d?=
 =?us-ascii?Q?1CGWYNQhV1q0n0Yn4HnF8airMILLDTE40vng9IYe44CorA7mo3w6L9xkHB2m?=
 =?us-ascii?Q?BFltGIUhNPTyeP3k5S8i/RirIpTsMQtXx52NCzwqpiA7d2IPymeapjPMJnt5?=
 =?us-ascii?Q?9LRfw32nPLF6FCjbTnxmBovPJc6OaQsy08MGOIrOl9jCDCHUW5E5FtZZeOq4?=
 =?us-ascii?Q?KF2z4XxlM0x4kQN72CwlqhB0B7hASVwoVIEVOdyplFccZFc5tc0yXwnYuCHi?=
 =?us-ascii?Q?Y4ikY4/hcKldQYfyjngiDNq9bkno1C56vGa1pMcIJhBuY3INdw/ZJNRQgRuZ?=
 =?us-ascii?Q?m5mAY9pfPlY8e9ZmSQaAEH3aP+SNX8FlZdpo2jQFZIrL/qbYtJeLF6T0nd3R?=
 =?us-ascii?Q?T7nIxxiRRvlEwjizR+idKocm5fPobkwQoI5hRxllCRE6WYMX8OpHopBzVxr4?=
 =?us-ascii?Q?0fEbq4P3Kf9GVFVoAruF5uDJo7ghxqjRo4Uemw7bkrMt/CpXCHcPEm/nJuX7?=
 =?us-ascii?Q?fAUhdX2SWfBPXxb2dqkJovb51hmY+HoRduAYP4rFurEu3m8bJLVP7t8QqQeE?=
 =?us-ascii?Q?GXN1mA/7th5Timoy1yCSBkiYqJUg4AoMb+QV7jAqogV+hItJF9tjwXyDLQkS?=
 =?us-ascii?Q?2yAWcR+fBBW9cRtE26k6eQpsZw4MuPT0c2wFuak5D+vingzxMhEJYxUT9Wg4?=
 =?us-ascii?Q?pzvCLjUoYZy6bVebDm+GTnTPCUssHry7CMpyhikj296RcwsXMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:33.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17e5eb5-058a-4956-cbf7-08dcb6b6988f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

From: Melissa Wen <mwen@igalia.com>

[why & how]
Cursor gets clipped off in the middle of the screen with hw
rotation 180. Fix a miscalculation of cursor offset when it's
placed near the edges in the pipe split case.

Cursor bugs with hw rotation were reported on AMD issue
tracker:
https://gitlab.freedesktop.org/drm/amd/-/issues/2247

The issues on rotation 270 was fixed by:
https://lore.kernel.org/amd-gfx/20221118125935.4013669-22-Brian.Chang@amd.com/
that partially addressed the rotation 180 too. So, this patch is the
final bits for rotation 180.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index a7b5b25e3f34..802902f54d09 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3594,7 +3594,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						(int)hubp->curs_attr.width || pos_cpy.x
 						<= (int)hubp->curs_attr.width +
 						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = temp_x + viewport_width;
+						pos_cpy.x = 2 * viewport_width - temp_x;
 					}
 				}
 			} else {
-- 
2.34.1


