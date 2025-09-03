Return-Path: <stable+bounces-177562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F67B4128F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 04:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC156052C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92807221721;
	Wed,  3 Sep 2025 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xFCRTbyx"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7D75809;
	Wed,  3 Sep 2025 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867947; cv=fail; b=jn98GILz83hzA9q4huliRKkbSass3qT4zojLY9T7fp8JtnMEeg+qq46mvJd1RPngTM5p3KDy5q8AVPy2/+Am6ThzRmBTyhKVQA8XwIdIMKTd5N9GGY0Ogtw6QL/r7euuxqeKx/PUuepvmH8jymPlddFKyaIgL9WjlqvdgO+9IZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867947; c=relaxed/simple;
	bh=gBj1v7uFTMKELLxb9i1wrGbe94ri2xOul3tsjc0aBdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjwI+29uWv1gRVsYd70cdqwntRXL8b0mQgnudhfDelfWKXmee4etE1Vi3i5AWADyICDQUAPrQKo5nSx1WJPbTT52o86d8SxV3PScfxZZULBkK47pVzXQGvVsocUKqkw9dG92qGGZwfTxfpFZjim0d2TWcCFH1W/qdFUPqgWP2tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xFCRTbyx; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+B3dow1bQ8Eyve5H0ESpyTbiVExNcQz+uVJwjMvQYDcBumuYJyAipHzVpls8tLcQqCq/p2Z+F6hKtfUb1+hdx/Wmw6RsFyxiQP1/jR5tJKIssfsYmYHJTblmB2pn8Nb+oDTXZwXz7abbZ3K5dhuZC10m1MlAGRi+UTUxQmfZYHl1UdzcZH8Napz1ufoH2JfqWMNfWTmUdDmSz9WayEjaj+rcr2KmVVFEPLvCxbZnZ5svORFxb1p+QK8W+PrmQZ6WQPWkWPQIVcmJGIrk0wbbDL+FPS2LFFpS74sFNDy43F6F2/m/jayF5OMUxbpwgFTtTYahmjFG6go0zvI3GSGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA95Zq7rl/NCLUdnHujVQox2i1928iT5DrNtfvO7KZQ=;
 b=KINZHoKKKnIanDzmLNE06DFWMzxfqUpWe9UO0Et0a5RWJsguhhjypq8hgjos5kC/PGm7r3IwEeKYH2eRT+8Tp3I/t1WMLHcsisED9L7ve6VgwQ3iXxqsxEbAgotEAnblUJujFX/yte2GmdtqxU8AKduJ8TRjvMwO1QJ0TwvU4ZwSH/7t25uO0u3U8ErXPMNrimqRPYZDnr07YjQtJh7fN1S95z6aIeDEt7AytQH6y9IOi7fmEB8lXD1vAWj7QAAon2TUeE2Oi1VRv5hB3IHFx1Y5XL5MhxMU+4dYeQ0yxT7cwxMDxLju4LxPRAmo27wMwLrTjbhZ1IxC6KVSmi60hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA95Zq7rl/NCLUdnHujVQox2i1928iT5DrNtfvO7KZQ=;
 b=xFCRTbyxPT08dSMHGCI91ojMtDT7vDCEbN40BzoqAnrPtv6n11yEoH6kIs124kyk4PWEEBFSNykMv1eF/pdRTLw4WyplKbIBOHO248R2WnO4F2cCUXe3bOHICJMDxTvw89ck/bTf0N0BwtfDf2u75vDYed89pSSJn0QYReCtoPY=
Received: from BY3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:254::26)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:52:21 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::e6) by BY3PR05CA0021.outlook.office365.com
 (2603:10b6:a03:254::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 02:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 02:52:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 21:52:17 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 21:52:14 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH net v3] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval
Date: Wed, 3 Sep 2025 08:22:13 +0530
Message-ID: <20250903025213.3120181-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f119b35-ac78-4318-788a-08ddea94e646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ebRinl5rj4UK2XNxZCmbr2oaPg9Zmd6WUdWgfQ9GXLEfvdC+4/dSGIdwNh4?=
 =?us-ascii?Q?Y1rApgdN+1+vIiJBUgdaPzrk85ZX6X2dNa+r2tpZ7mCggOr8czzblZn/lJgJ?=
 =?us-ascii?Q?+OMpHJki6xK+qmdpzmJpCL74ud6vvSnGvIDX/Qg0DTNXj//56hlT9+vygtv0?=
 =?us-ascii?Q?rXw0HKOc5VD6NOyaw+7aWu5bThv80QqE9e4x8JHKVJqG4ikVpaMis+I7EVjd?=
 =?us-ascii?Q?ginwSvI0jbpJe80/PtKXdrZFjNU7pphI7O+Qynkf03WMoZoFPkpvIIfEAt+r?=
 =?us-ascii?Q?gRKF8pkAL2PGug1fCVx5dKzsUmWM4hBr6fnNXaEblB0DtynqMGGnWi5VGtAu?=
 =?us-ascii?Q?Rjr3HekkgB223WRG4jh+cFIakrc6lu0AM/+KmZqpd9XAN9ELiyV7Bl22fBcV?=
 =?us-ascii?Q?biJDEXf+L3Ft8ewu6zOaDWBScq39KHuKBwbeMfcAJ/4JAenYz5oroX+mQi0M?=
 =?us-ascii?Q?fTM+J+bjH2grVV7C1fXlionykMdl/YSt64Ia6or5LvNgEyNVvJTVljNeUZDe?=
 =?us-ascii?Q?yiJxbhuIM392h/YBHRtfUTJ27tOf9MWMf/h785ulQwyAYff/zQIFentlwzsV?=
 =?us-ascii?Q?nT1hvrBOHSCIgzuOHphhCJfXs2HFJyBo3E9o0zoIEBxfQ5da+a0r3NHZuny/?=
 =?us-ascii?Q?IJ3GmaN7CNVDjxVsBiRl2PLGOSTrJAcmAnVBpxGZTUPUqEjLY2RE4sZpI1q7?=
 =?us-ascii?Q?IetWytScFZ5fye1KDODCmick/pa7ItX+tbwpfYRiIxCJl4FEwOw7IvNm9YKH?=
 =?us-ascii?Q?cWly6ALenWgzcNlP/iu2RNwCCDrX5fOOgQEe6OTPGWw/QYYuiMc9LoA/wg1d?=
 =?us-ascii?Q?nVhDGwI827qlhUD9ztEh2ov4/q6VnLTOHCzPxO8weH+6f1KvlvKz029sAlv6?=
 =?us-ascii?Q?uenpA+5HjsbnY35wrmaPEaV7I9bKjU7xYM7WY4O2qquQIlGgOywQ3Skz4Yoh?=
 =?us-ascii?Q?s3vEfSdUbKDKbmaLQ2c7QIgUSnqy/utrMligxw0e5CgrjwwNhFHHFUrdsrFj?=
 =?us-ascii?Q?oHf10kGocw5uWwS6Do7XaNa1SPUqekFhK/H7dgOeU725loYgybZxy4TY7Ac+?=
 =?us-ascii?Q?lNaxwHXSMTVCKF0A9O23zYGlH1+G9GrTJ2nk8DfSmXobjxRXpSFyFDky7tb1?=
 =?us-ascii?Q?iJWuGuSIdkW510ULZzrs/9k4nBUH8IPibBe96gcuO0rshBO4BJEy/Hh3XdCb?=
 =?us-ascii?Q?36IyeIiL4WPBBMeb3tFulOZgvFMkUYEraugOMmni6oNb+A4od2Ht7TiEtvrC?=
 =?us-ascii?Q?iTjCFAKyPqVCvof+bmjN3uq9KJjqJqCgTEExg2x3jLoF63eSZP5OWtQd2HSJ?=
 =?us-ascii?Q?ImBouq8DGFA0fzvSnTFMbdWatGPjGyMO7u5PaJ+yFYH/hnyxckec8xolLmF3?=
 =?us-ascii?Q?XZmQHaAs0wdXBl2sGmreao9760MdltVqR46d4D770M3VDvF1yjPMX/5eKHqi?=
 =?us-ascii?Q?tweEeEbyuEYaPRY6jN2DgIczbd1kSIx1kyGhndGKE87XRavSROEdlq5wc+Xx?=
 =?us-ascii?Q?GvvAvXqcZkFRHc0b5b9rSpTcnIV2i01TF64j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:52:19.4555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f119b35-ac78-4318-788a-08ddea94e646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

Add proper error checking for dmaengine_desc_get_metadata_ptr() which
can return an error pointer and lead to potential crashes or undefined
behaviour if the pointer retrieval fails.

Properly handle the error by unmapping DMA buffer, freeing the skb and
returning early to prevent further processing with invalid data.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com> 
---

Changes in v2:
Fix the alias to net

Changes in v3:
Remove unwanted space 
Add reviewed by tag

---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0d8a05fe541a..ec6d47dc984a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1168,6 +1168,15 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+
+	if (IS_ERR(app_metadata)) {
+		if (net_ratelimit())
+			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
+		dev_kfree_skb_any(skb);
+		lp->ndev->stats.rx_dropped++;
+		goto rx_submit;
+	}
+
 	/* TODO: Derive app word index programmatically */
 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
 	skb_put(skb, rx_len);
@@ -1180,6 +1189,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
 
+rx_submit:
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
-- 
2.34.1


