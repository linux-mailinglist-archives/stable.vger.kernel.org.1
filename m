Return-Path: <stable+bounces-75869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5E97585A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0EF28B69E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3421AE86D;
	Wed, 11 Sep 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KZK2nwML"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0E1AE058
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071954; cv=fail; b=lRryHX+DKlv4pWChUIJh0B8U6VFfxHb9stBcUoUzO/JhkTy582VqvzAZLjxYIxg6CRK9jMZoB6k+UZaXzEcELzzMVlUSdBjqhT5+c8cTJg44LrhcFKrtVHuYBQHcy2sghhx5GT7XCh1PoFiEKndEwfrwp8QCxM+WW8MeHL5Ddyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071954; c=relaxed/simple;
	bh=PTWCAc6/RJG63Z4dZASz3hqw/Ebq0gH6mcevMdJRWZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otwGkqPYNOcP895tlxri7KnuiMNMwXcEsQQDkNa3xoD3oiOyXUfZk9zXpzSq3OeGM2YQNmLDTJjNhaUJb8rvLFGv6GPS9KOgwO7NIfqO5Z34fXff/DrC2c0r7/Csv6dIIxCFPH5lW6dDMWowOjuKkA4X+axAtoLvtNoVwh0rxNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KZK2nwML; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4knLm3wHe9pF0dJgDJnnAINv7OOQiXXWCzUCsOCKKqHl3WCEPsAms++FOcv0/lgt3FkZ+5FxOJXCg/UYlOhR9sSeWQdLTGv3U1yvUzwXZ4HjlZOImGnjbR5gDXM1RtAE8/tqErFqbappkLObWhGGQVUyavi5d4G04g9rkgDLNX26/qvaNJhy/niN009kBMdNLF7lgTbzN70Zw0cU+GsrctOAtu0cUnS4CvTjrQlu59FJfthPgMnqr0+lJ2bMu6HyqW6BKHBR6c/sCmmPg2vgQ2hCBWMO8mQ5OC/Zj+FU7EqDuN4JWqQ9owOA52MweIE13Vr6BfIDIGd8hAo1qcZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecaz9NoiV+ZpRN55uTSnu5JNbMJNSeeIshSfjbSBYtU=;
 b=QN/KFi9g9hgfdL3rzq/N8BJZuXljSQMK0Q0nA0edi0DtVl6RnJMusTR+tOXgXFzRaLeIRMeJwNbQSau5Jh8yL3d9DNR6md1tAg18QZ6yf1kYgP0lwAjlIX77yDhI80vOCR1zZRgd1zeFLv0LK25212oRXh8s56WYnpYTCdok7Ft3PDtwJBgBg6CkymYudydf9ELA8fYbDnx6mW371OZ1umw+WzRqJg4eZzC8r7gymNaNdhRiQxn1BSSoQMEwhGUBhx7vvxG4nw/lD17abuovtuMLf3vg331odLugdlLtWSG2eAf+QDcRKzlOrewPru9RlajK875ep0j8VNVhacBRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecaz9NoiV+ZpRN55uTSnu5JNbMJNSeeIshSfjbSBYtU=;
 b=KZK2nwMLROO+lhuvrdFLd9pNTm3S1GUYfwiuXkaTb5qrwaBGUQ3f5FUNV5UwbdcxQHJM3LD1xD9Nn4n+2mj4Eji0kcua1mJbM80LdDn7XuUfQ8FGx8w8zPwKAvP4cNWZ4+CqKh/PxBKaedW6kjn07nQUHaSnEdLCgvEPeCDAqLc=
Received: from CH2PR07CA0040.namprd07.prod.outlook.com (2603:10b6:610:5b::14)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:25:48 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::63) by CH2PR07CA0040.outlook.office365.com
 (2603:10b6:610:5b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:25:48 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:25:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Dillon
 Varone <dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 18/23] drm/amd/display: Fix underflow when setting underscan on DCN401
Date: Wed, 11 Sep 2024 10:21:00 -0600
Message-ID: <20240911162105.3567133-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: ba647f8d-70e9-402b-d70c-08dcd27e651b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7K7axmgDiWPFa+HJftfJD6eT01kAyatd3lv1Koq6SzzrzYkfmveeAwlIWth?=
 =?us-ascii?Q?cMTiLDx6I+scfvJyKjgeQeHH0I7+zNfeQ7/e51ZfWPF24xD0VLela7mzbkzx?=
 =?us-ascii?Q?o5L2c4rzW8p+4fF+NTQaT50o9qBwRy3nFUs2U8zviA/oCo/E4hsS3FoWntsd?=
 =?us-ascii?Q?Cu3kc+Hx27qE+5hJN5mewXCz4asl1AU0ddQb986GEnoS8+dkbWh00XK7nF1C?=
 =?us-ascii?Q?4oe9V7MgLcmBjCLy1YCqxZIeCwt1aUueylBdaNxmgZ4F2WoT1Z2jyap2+THz?=
 =?us-ascii?Q?WCu6l25pCGDZ5e62i3XOwZYjOo1nVcWHb8Vk2Jp61c1sxwzzCWK68/bC7Nfw?=
 =?us-ascii?Q?cgwORZTrgpgGkiFStTyzI8XJGgCpdbVCmPEBXjzpNvIVfwbxxz03Wm3JIW8Z?=
 =?us-ascii?Q?VMc8YzWRN0SN0x2mHzxhcPEaDFl7C1OJUPtjoOHSMcuq75lhc3gEnjobLviH?=
 =?us-ascii?Q?MpWijVvtpJm1qIWnkGGqiUt+kHK4u0VhIYoL+ewrhSLWfiGiuEhfpCAa8vga?=
 =?us-ascii?Q?oRI6oi+/1hQzygaqXNg6OQ7tzQv5u8EDxeQELCASKR+Usq0rZ/JBApWet8eP?=
 =?us-ascii?Q?Oq/CR7IqhiwoaPDEuzS0PZfOjWGTVjgay6tIKhh97mPksD73CrukZ06/UOmc?=
 =?us-ascii?Q?+QlbIoEgzRlCA1O32/CztSP92Ecj15Z+bqqMwf1ySYZA3TUNM5jmpsyZpcI5?=
 =?us-ascii?Q?OQMoHhf432r4oSHVee/9FHUN2oPFeJEbSsZ4NyEZZ6NmL5QWJ4rP4RDrZ7Na?=
 =?us-ascii?Q?VBdBOcZnnKjMtSB6avzabSO9UDvatqw/R6pd1NWYgG+ZUQxmN5GYx2gr6mv9?=
 =?us-ascii?Q?BRVToEOO6NNM8bT35V3D9osO6jcVlYfunGYSXBTUAJjPoc20KFIZpclfpekY?=
 =?us-ascii?Q?qxiqISofoxYIxUMZKQ47ygCIIU2br2wClNvuqJiNk/Wto0zPD9BUxyaHXppj?=
 =?us-ascii?Q?uuCga4RXuVr8amXOo22S78sYMK4FCJCT+U1OkFrxj2agU46VBjtX2GLzfxpH?=
 =?us-ascii?Q?jbNBbNM/oQnmFBZDRNwE4/hNMn47c3vE7b8J9I6Df7zKiLMHAOCAvB29pL+v?=
 =?us-ascii?Q?ifnyCWf5nRUfejnhzTLe/q+2SLDp95MjYl3iDjMqBgWzjUOFImCr+JM2/PfB?=
 =?us-ascii?Q?klRBPLWrohz1q8j/JgukOvoXqQ0CwBUsiiS6foYl0T3Rk3TKiWYn0xOmEd1c?=
 =?us-ascii?Q?NySuRBmTjZrcNc6KUQEOS3LU7W5MUMzmu54BHJdtUojcnlka5VnfqFsYEcae?=
 =?us-ascii?Q?Km1ir0xn5S6DuCi9QcqsWjOp7Ggq6KNlvGLQpg+/TZff7h4NFzxboA8moKbS?=
 =?us-ascii?Q?xXlpf3VTjOBAq53riqIXhtg1bh6BvcQd/7dF3g8f4h2NKlHNR4YUP+dCl5Gr?=
 =?us-ascii?Q?Fe+eqYsB3eumpatHxQ35brtj4VOOIQNtSE7c7aD5sX5xcixIIwGR8OJaFapf?=
 =?us-ascii?Q?zTVYhov5IpkvFAWo9I1gkRibCGyFvvK9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:25:48.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba647f8d-70e9-402b-d70c-08dcd27e651b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHY & HOW]
When underscan is set through xrandr, it causes the stream destination
rect to change in a way it becomes complicated to handle the calculations
for subvp. Since this is a corner case, disable subvp when underscan is
set.

Fix the existing check that is supposed to catch this corner case by
adding a check based on the parameters in the stream

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index b0d9aed0f265..8697eac1e1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -858,7 +858,9 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 
 	plane->immediate_flip = plane_state->flip_immediate;
 
-	plane->composition.rect_out_height_spans_vactive = plane_state->dst_rect.height >= stream->timing.v_addressable;
+	plane->composition.rect_out_height_spans_vactive =
+		plane_state->dst_rect.height >= stream->timing.v_addressable &&
+		stream->dst.height >= stream->timing.v_addressable;
 }
 
 //TODO : Could be possibly moved to a common helper layer.
-- 
2.34.1


