Return-Path: <stable+bounces-116967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB2A3B142
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FD418975EA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1A1C54BB;
	Wed, 19 Feb 2025 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dpUmCS5R"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013055.outbound.protection.outlook.com [52.101.67.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D11C57B2;
	Wed, 19 Feb 2025 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944813; cv=fail; b=UE7T7JcQRSUGKzEf8zQZXEGrng4BI8Oyi2pOaz1pUH6zLLZ7oa/O0vkWEn92tCldQWGjIJAT+QQIhHloMdNSbBu+x7JaQSHU/+U2/cB8v07pdARCSmh6wEV4XH1a5ETbmnnAL0vbSQc3IhGs4TUGOwmP3r0g+LmW46+FMFX5EQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944813; c=relaxed/simple;
	bh=5MnM/6kY39xfyQfR88shuGDgRKevii//WFJWT4riTmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mehIr+seEo9RUtzeDGWrHtKtWt1guQgXM0OPh5KFa5n271frBLLDVsXRGNdkvIlkSIqsyDYD58tL0V4m3Jx2kUozwRxm2RsbCWyCTJxX+qkaM9cOLtUk9SCMt97MX4MFec6bLLTJbsT/Y9dUkkgYwLaN2SVLszmUqLGaoPv8oRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dpUmCS5R; arc=fail smtp.client-ip=52.101.67.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJyvnsNiUmhjQZEGoSnvRKD+mM6k4EoV0SIU2oIzYYTcIR2X9m76Au9jCFczXXPlaUw+ni1h0l7jT7sSTrDYUKAmiuxbmgCJGf0eex2AQygKN++tp21HYLoajCRvrwI/gLakSUC+lWJBnbpvIjrK+/ZnsB9eyleNfnF4iFxuyqfZkE0fV8klwI4JVNFuYc/KQm7WymAJ4sI9b7/4rWEHXYmdot1/8ujbs5dlD3yndG05XfXHCUD+Eodlg1B7Box6DEZtAz7rs5GS4OGgRukdsZ4pgprfXZQpU8Ty0xf/fuADBEWJz4w0etx8GrSttDXFPmXts6cMfExH75WCB1cQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mts7h/NE85NxW0BUBEO7sI2ocZVGTZ87AHxJVV1pqmY=;
 b=B42JYkI3+7US2+2alIfSPbTxyDIcZemwONti9f3SbO0NqaqLQboIfmMW656ioDxmuHoXWsCmJz50PlnhLfMdxupTRpNsjdl1EYSMuDwApneIXQ2X1yyaAoPK7jcv3xF8iZhI6Sjlz2uOIF9bOy9D4RKJF49IcssqyqsfMJR3aVZs5zAoZBQIDwr1e/igPyIUt8zClzT3BVz7gY9/ENHISpZGvvayrcsnPLWlzhFUZgfZX7gj/RbxTtlWbaFDydk/ZMA8EeBNyQN3nXvHkiJeunukdyCgeUoG/SvoomhOQ97M0P6s7Tz3jFCVT7WOGYOlQENVxHEeYdJZrkDxt4ZYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mts7h/NE85NxW0BUBEO7sI2ocZVGTZ87AHxJVV1pqmY=;
 b=dpUmCS5RjEgqDknkd1nZZRKWuItn0fsCrGNRcN/5UFxz861qsAuefnTyw/+uS79zK/eImbi32XXN7h6zeCuAhiajCWb/jZ27lK0cdkWE3TTVUv3qm+XaJ4ikovPE2fcq1WXUP/NdYjUyarLzqNXHS0MTgDsHp50mn7xevXjrF4l1/yvQE7JAe/5OWL3YCKOYMH36MJ5LKQfFV3BEZRBdLZqhHT8YJ4xfQVHkRmNfgl1nRXRypOXdb66fwDPAGQw2Gc6DmP/COWYzEmg5bt6Rynjkm8j+z6K3qYVaQC888w9Jg7OA7upRa12R4lJE3uQWIUmIjKS1PHNYGHGvtlIyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 net 5/9] net: enetc: update UDP checksum when updating originTimestamp field
Date: Wed, 19 Feb 2025 13:42:43 +0800
Message-Id: <20250219054247.733243-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219054247.733243-1-wei.fang@nxp.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 14760c2b-be06-4afe-ca56-08dd50aaaa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9l0CZjPZ0QmOAb/DihMs7g2mBdWxWzWTOl44DJPWMg2tcW0lbC7/5LaUpsO?=
 =?us-ascii?Q?vduyVDVDPckKhNDoOhah+d87oPmM+OnF5S9jTh4BXSk0CTjaCd0ZiWx8jLQj?=
 =?us-ascii?Q?i4xZqxTTJHLtLTmTHfOjc+avehWS7odMxpsmb/0zxZrtBu2awObO7dRbBrnW?=
 =?us-ascii?Q?m4NJmvF7qYx8/q6JTdtWEnmJ/HKZPJ5jFjb5KLS50ceF+MBMGz5Rf2couBeL?=
 =?us-ascii?Q?IZbvnKX9kfIETtcMctAaigSAuuCn4Esx2Z62lsf714yVCTc/xaPY4ynfZflc?=
 =?us-ascii?Q?q7hvtQnW9qJgVRRNz2tOpN/sFGWHQhJg2LtyO30aX8tyiQ+X93fW/gq4unul?=
 =?us-ascii?Q?4sWBYenLEKVT0/DBV0Za0wrgVkILZ3ARcI3CykRQVwhS1YnmYdW8Kb6iK5xy?=
 =?us-ascii?Q?gw4FNKRMotHWROeAEKEOykH3shkFM4cGGI4/Bfrr4FYSo79d8dudY+K2y9Ps?=
 =?us-ascii?Q?myIv+qtvnoXEQTL5OT/205DZup/RKAks3cfF7ANXbzTSweRuZuLPOsIp4HDt?=
 =?us-ascii?Q?JyRWt9KdtuRXYC7SSl9JGmvmGc21IiRNtYRO0iVDR/XUBiZtcdIwDg1c8LfP?=
 =?us-ascii?Q?lkNfr/i3uYmZdQNdfCtuDbbCnJFuzE6EAz3xLTjOoybISob1GO+sDikWcM0K?=
 =?us-ascii?Q?Vc6Bf0OZp//EP0R7j6Ml5GQVHty/v55cyCcCIx3AAaMPztxrJyKr1E63JEAt?=
 =?us-ascii?Q?NTFNu7l2LffpN6IVbvg/4kv2dqRDm63O/9iVk/OhySplLl2a6bAbnbtaU5my?=
 =?us-ascii?Q?BZQG0clfy8kLNFIjWHO6OZ7YzdMmmDhOo0KLt6+jFvOWXrSnu7X2vvX33wAX?=
 =?us-ascii?Q?YzZvaPalxwDKXBazFpwZYdy5OK0TF6TG+CerL3dyQC8SgINL/Di8bi2TML/y?=
 =?us-ascii?Q?2OM/QFppuW0hDsbpgSSV0jJ15KFbJ/kWx0f6pOLTTH4RYz+g8NbDGtrQUFR6?=
 =?us-ascii?Q?/Anq/1clsBMwHIXBmn4KzoZYoZ46Uczevz9sI1Z16Xr0xOJ1ApgstGzBmdZj?=
 =?us-ascii?Q?L3RI5Y+HVo/TJFENlsGkInAC6b27wEmc7UdL+j8/ZA4b5waud3Ma1GKoRucP?=
 =?us-ascii?Q?WxRtPJx6mUh+hiChMc2nTJrWh+rOr1YYPgEue+wTCQdwjUwoVyMRrfwLOlr7?=
 =?us-ascii?Q?MkqZuE2mOfec2Gw1zpeXepbl4j4QlEVmQi6lJumAYOALsY610H4lXSc6HEGi?=
 =?us-ascii?Q?+9nS/EAcJ7Ns09xhbPngzQF3zVSqFSMK+SLU/jmbHzSj3UWbeOwtqHNawUPL?=
 =?us-ascii?Q?YKFpjNQZK2iE3nok4JgOedCTNqw0DpeB2D96kO3X/+ab2GMpbCKTp35Nebge?=
 =?us-ascii?Q?77TglgaQIdGywAc/eiXioBNaiUGY4phE0hQpyMGMZ38rBcBp2iAtOU1jiJRA?=
 =?us-ascii?Q?HFnDiQ7oGz2bIdzSHWF93VTNRCqiZ09OcrVZKQdDLBzIBPjFnYhfxKDdYXFF?=
 =?us-ascii?Q?eXQrzkC+OpCnlpNdMp2F1u4D/OPnhjLJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pSy10byADmMBRJByVznYZBrlUpNXCwtJ6WZWMOA1nHaThl41fJhOOaVcyjK?=
 =?us-ascii?Q?BJ1wju25mCAD2NYrgbX4MnedDdohXcFaj5UzEQM5sh0W5JvywrQvrcWRf5t4?=
 =?us-ascii?Q?33MhsGDZds+W2By6lCqXXU4nm7FLpCE89YIMLbJedGZP/1o476ORxY2zhKpj?=
 =?us-ascii?Q?WTT0HenrV+6LHtuyWpObVmE/hbywuV4ctm6GzYRvLLike2juW9DcwEY5rUZA?=
 =?us-ascii?Q?dxli9x69x6lCTKDKWCH6zFvEt76t2duX9j/REhKCxj5BzRWwzrMl1MPk+Hls?=
 =?us-ascii?Q?aI9keeiwqvGzYVb9SJ2xypxssOB0ewafdj02cSUYIgiaG/42R2YuIWiJUobF?=
 =?us-ascii?Q?nL1LAYRz0st0kvV1QPKaVYqlJl4EOlklb4KpywCy5zwb4tgVPJIgLOOTQ8lq?=
 =?us-ascii?Q?UEBDmVA8bWMKrt+tTzj3yLM6mxxN1PGY2ub17ItN/AlVVK1x/G5S6fcZ0HLo?=
 =?us-ascii?Q?oW8QOCc8EKpi2ol8bk3cpx/j0LcejEdHnGvpjHbIgH1uNicUZ2uiO8FUncYP?=
 =?us-ascii?Q?/KagkmcuN+j3YzXsY+mB0yeDcmlbjWfSDENe6XnRlcM0RHr8EGiJi14Z3+bi?=
 =?us-ascii?Q?hYD052TfOHRDnrXl0aCI9HeJL/tAe6HPV5HhoKCeZY7tskxkg40PYhQrWvxQ?=
 =?us-ascii?Q?AeFcb2DvtRn6XMQYdt1RiJ2hqnw96VpDBtra1kww06Ug/ZEyWLrs2zkEjlsj?=
 =?us-ascii?Q?loqVTtGbs8lvVS9GYCd4LTNq/ZPb/tmw9HiZ7n1WsEZui5tCHMWp/L6EX6/8?=
 =?us-ascii?Q?ZJ2PDMz9zLcS0oYa6d8vchgTq9w8+BLsQdscg/9pSPKX2HBgt4gSQn5yOisI?=
 =?us-ascii?Q?LFQloK1eZOQW4OWExrhc/8v8h6EoxcNpckwUIEZxA5rmehMs/xK73wend/zj?=
 =?us-ascii?Q?+GDYZNS5bG3zKiUl8uP0hamlwUEkzH5ps7rXERDAlemZ+EB12vE+dEUJl7UP?=
 =?us-ascii?Q?mr+XeIEx3g03Zhz/gxYA3NV6JNfFoyeUWdqh3QbTOEn+oFM45hz6l7dybEmm?=
 =?us-ascii?Q?POEfDrgcRi3Lkhwaf14yUh6HvUpvyLvS4+kYXZl6k6yK6Z6p1qrkzUNt406R?=
 =?us-ascii?Q?zzJt6zzd619/3tUNntUN9EUc0k6VUDO0dQwdrHuTWmjie93TXoPuvzkWCQcM?=
 =?us-ascii?Q?FQGZnKAbQkglb6dvukwM+X0YllsnbmaimHxEKcNxqdNqwvn8Bnt7LRnl5L1Q?=
 =?us-ascii?Q?hizhIXDDxP/siObeEkWMR7ZHfLXbsuQ+q8PdIW9aqYtWJ3YMlViPMtwXulUb?=
 =?us-ascii?Q?Tfw/JY96krIkTjAe8oA7OqL19gjsS/vBLbZLMi7GdYyLEfrhLGMELhHQvqyj?=
 =?us-ascii?Q?cTYJnMKPp8TIDUqIGmcVoTZq6oLASLaDZa76okjEW/mPGrArsUDb6Vd9pK0z?=
 =?us-ascii?Q?nmggdM+RD+d5Q4a/OhOI2+BC6tPRzvDTzyIcROg2WqZM4zEofIa3ZFcqNhNW?=
 =?us-ascii?Q?SIkkYZDZC2thEbIoMSyjgK0F0lUU7xX5vUjWxzsWfk1pI+zqQu1bHfEPRalg?=
 =?us-ascii?Q?FMF0BhsNLwYlnRdVxyc6yMHDLxCtQCWHTnX4bth+DWKNHR5puWcabIfx7N5S?=
 =?us-ascii?Q?PPEQ1Z2ZTOI7l3kXO/ejvv1UhvcPHTr/15r0Uolj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14760c2b-be06-4afe-ca56-08dd50aaaa51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:09.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0brZ66XEOGCF0tfw8E/Qxe4SjBGVdg7sYA5qZkked9WyXuJ6V5p9E/vTnaLqrinJrThxta3BYPTiZhTq0uFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

There is an issue with one-step timestamp based on UDP/IP. The peer will
discard the sync packet because of the wrong UDP checksum. For ENETC v1,
the software needs to update the UDP checksum when updating the
originTimestamp field, so that the hardware can correctly update the UDP
checksum when updating the correction field. Otherwise, the UDP checksum
in the sync packet will be wrong.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 41 ++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 77f8ef5358b6..9a24d1176479 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -279,9 +279,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 lo, hi, val;
-			u64 sec, nsec;
+			__be32 new_sec_l, new_nsec;
+			u32 lo, hi, nsec, val;
+			__be16 new_sec_h;
 			u8 *data;
+			u64 sec;
 
 			lo = enetc_rd_hot(hw, ENETC_SICTR0);
 			hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -295,13 +297,38 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			/* Update originTimestamp field of Sync packet
 			 * - 48 bits seconds field
 			 * - 32 bits nanseconds field
+			 *
+			 * In addition, the UDP checksum needs to be updated
+			 * by software after updating originTimestamp field,
+			 * otherwise the hardware will calculate the wrong
+			 * checksum when updating the correction field and
+			 * update it to the packet.
 			 */
 			data = skb_mac_header(skb);
-			*(__be16 *)(data + offset2) =
-				htons((sec >> 32) & 0xffff);
-			*(__be32 *)(data + offset2 + 2) =
-				htonl(sec & 0xffffffff);
-			*(__be32 *)(data + offset2 + 6) = htonl(nsec);
+			new_sec_h = htons((sec >> 32) & 0xffff);
+			new_sec_l = htonl(sec & 0xffffffff);
+			new_nsec = htonl(nsec);
+			if (udp) {
+				struct udphdr *uh = udp_hdr(skb);
+				__be32 old_sec_l, old_nsec;
+				__be16 old_sec_h;
+
+				old_sec_h = *(__be16 *)(data + offset2);
+				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+							 new_sec_h, false);
+
+				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+							 new_sec_l, false);
+
+				old_nsec = *(__be32 *)(data + offset2 + 6);
+				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+							 new_nsec, false);
+			}
+
+			*(__be16 *)(data + offset2) = new_sec_h;
+			*(__be32 *)(data + offset2 + 2) = new_sec_l;
+			*(__be32 *)(data + offset2 + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-- 
2.34.1


