Return-Path: <stable+bounces-118900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A35A41DD5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD697A05B1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C98266196;
	Mon, 24 Feb 2025 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmZAodlv"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3A265CA1;
	Mon, 24 Feb 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396612; cv=fail; b=E3B8EEcbfRDRP0RuOYodzOt8MuyV74L/q4+/5KZyIfI/+dFTVYbn+Dc01Yw4Qsy2ApMyq0GWEeWuTFXknC/97TqeDkuRL53QHaZmDh6fu8B3icC7aRFUK1Kd6tdSaMAzD6+NsW2jZUhikhwYGRdYPmD3YDNtMfWM6YGSU7sJr7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396612; c=relaxed/simple;
	bh=9o8FKHeSGr6vgEztE1GG51oMr3iFaTMfwNNh6t/6yMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMOIxGOSoePUzy8RwMZuiKcry1vBSLhPZjyAzsydid8Ssj4uv0LoThwLn8G2ZddDczgPb54V6EiMbrsGdQFfNHil/QKFCVy9Z3NLQqCjTRRDQP/snzciWWs0gkJ/0ev1ctph5e7KudAARhdT3jJPeOAUw0fnoyNQ2fGAs2McRiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XmZAodlv; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5j+HAUL/PC5RIfIZBqlKT9r8eAqpLhab92u+lIFOdcOVdJqQ6DxC3wYZiWuacBcN3s3OvxN2HBnJaESMVtDt2pdsTSWZxlJzG9Zm3pb/tcXUvdwNkvtdfgWrqOrGNHyQ1G8L1HlqU6S8JUPt7wymat2Q78UhJCmnTRM2XrJZgWCF6G27BBBCvtlyEJ/RfEPgWWTMCKR9UCOfFcp+lW3qPnKPQtUZibkkxNxAbNIQboENFWQmo9j8aSg7VukxTTpRKDggGpXM9xKaU1ESh6QgIJ9YiMp1das0iqw9obD8tP6e8vi6mtfDD+pg66CcJYtW2Yc9+ECdp3jTX4Dd7q3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c4W3rUmG8bmvkYkxIZHDtDHwzuBGlmU9NFFMnlI0pE=;
 b=eOOkuQwacRSFbqk/MYp4Sfo20Lb0s4nrhWktlWtNF2d6G1eFkwtfnPsiNlPJUtwcq5et8Bj4Wf2TUivR06naN1eMNMJzY+SPhBU47sS7IauWJEzcK+S2Mc7T3yUMNhCFESuxAyP55xHoO2vrMhd+4YhtxZq35QciCFBsx4UuAUqaXj6KamFLBcczX0pGlDUPO74cYGZP25vsh5/+Uhe2+UUlm0Rq5Za+EUSL3L/08Q714kgdGHmV6zL4gnLOqTGP6dJp6rZZtCpq9n/t+XWWqCKnLma3EZCYmuVKScNkTz2Q8G6q3e+wyIzV1K7Nk+CBb0Hft33Bk2Lk9mro3SgGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c4W3rUmG8bmvkYkxIZHDtDHwzuBGlmU9NFFMnlI0pE=;
 b=XmZAodlvqVgc70t4t6OOQD9OCrCDAv/96xLqx4rWbqCJxGfi3SlrDJz9Ab2kVTC5CT5uVI9Ki6h2xmEwNUNpS034fAH/+q/t8OBzJ2NsbTJ+PCCZMBwkqSDndBZOK1tthnmQqUmCMP9GWx/LCWsL4NrM7DTf4LQuiwKpAY60Yw7T0L2Tcd4TAdHUdoEkCaHuXmTDmGPSGstT9hiRqMBnRgGohxp6LNU8bQ35H48NmT0eo9PNYXHNasG3Q6Ub/Sx93bXBIGGrjdIdzTXklQYQ9wnsBXLWCo4n2Lg7Rvrt/hwnqeiFkOvVe01ghbfQgIhZLdcJApcf/ZhJyeXL3YXO3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:08 +0000
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
Subject: [PATCH v3 net 3/8] net: enetc: correct the xdp_tx statistics
Date: Mon, 24 Feb 2025 19:12:46 +0800
Message-Id: <20250224111251.1061098-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10979:EE_
X-MS-Office365-Filtering-Correlation-Id: f54e2eda-f881-4fd0-6b2a-08dd54c69762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qX0CkKlWcrJZG6fJKq/AXWPxAnOjN9s6zUZc7dgIyVckDKiKMXSZVxmMtwPW?=
 =?us-ascii?Q?dwYoScfsghm+ItBbNslT0gE4nPL55gWTmAmqhQ0e6tK68SjfsEAF5bzojrHU?=
 =?us-ascii?Q?k2oRVCTtzr0FOe2vpS/pRcYw4Cbk/LU++xNPEdS9xjnnRXbjdt4xM7v6s7Ih?=
 =?us-ascii?Q?k6ejPbKnwAAaj12MEHxYbJkfhluvrOrEJsrKtvqrO18zIZaVDhtestwZ2S/v?=
 =?us-ascii?Q?grO1RIAmKG8VZm2PQeuUxyRMGYoNZfkxY0yUZJ5+n3Nd/I4bWKe42kAvHcHC?=
 =?us-ascii?Q?YSWiOFsHi0/dK5dyfB9IiV7zFUL5KC6lljNVfr//TD8/pPvVHQmSUyEsC50x?=
 =?us-ascii?Q?Y8grx5vNYb4YoS+VNqjbAxrhZgyjYzxKVYX7tIqIQpdm9ybiZhU566lwwnz9?=
 =?us-ascii?Q?+zDnkwX0efm8HSc6y4pMT4GV5OfIxV7ildUs+64UGTCNDrMqLIo1dYwZYlqM?=
 =?us-ascii?Q?zZwMiMpPen1QsLKM+fj5s+svnt56bDuo0aHeH/LjsXgy1awKDNuxHsW7tfFV?=
 =?us-ascii?Q?m4WYQTrZPaAFA6+OYIbmjdDk74sNvtbj/pL3z/2BIcxkTD6DUmtpHtFjZvfj?=
 =?us-ascii?Q?kXxiKUMO4YwxZB3Y8rNuaA18uiT4IDGoMmoxk4QJZ66ezNFKRQhL70pnUFv1?=
 =?us-ascii?Q?3D/J8D1C4jJI+SRpenoSJWcdT6DplgLifgY/RYhnWSIu0bk8Oc/NgLEBSegC?=
 =?us-ascii?Q?a5628Vq3ZJF9Epz3I7OFCroXYthF4UOXWIcoyiGYBZsRZSBWxJtUUsEVS/5I?=
 =?us-ascii?Q?S3BlKWWASE38msIlelJTgIhViWIxy3GdBv44Djq6XJ0sQLTGH/PwFsixmoYS?=
 =?us-ascii?Q?uM6MfagfTj4U7gvzRyi2XIUCq83HE40rj+hi44C4SWI5Sv3sMbaaepgJPkK9?=
 =?us-ascii?Q?XUNmrPaUUJjELQuo7l5aFIMdrz2y86h2Xqd+Srsaqu0AA38PkDzaXMUnsGHu?=
 =?us-ascii?Q?7RNglwxADmLV6ea+nJPLjPBUTJyKFJbazG9GyEbpjEDMxP3wDO9QqW3pTLFa?=
 =?us-ascii?Q?ci/S4AR0BhGCuHu44NLMAeGq4XD2iGUJyIca7gIiD8NM4j3afx3Uv813QDgn?=
 =?us-ascii?Q?h9V7oa0DtMMIzwb4o9JM4KoSPXAXB+YJVsmuuod/erlxtcxXPqEc8agNaOfX?=
 =?us-ascii?Q?INKEXAGqX7uCRzsNl+o3DBaeG6ODV4JKS8R86tPC29oVPtEdWMQQ2qtKLZQr?=
 =?us-ascii?Q?RR5LgdChRljy5IwZI6fmg9TBdria821T8A+zSi6aGfklV65v+I9uvOeU5vQu?=
 =?us-ascii?Q?WLCDh0QdkJqi5+Ud5CDWyQ7fvMNcGLFGeZ3X0LDXhivtLqdBQ6p2V0hgnyWN?=
 =?us-ascii?Q?rxvnYM7PK8OhzyeHlnfFJvW7QoJc4MVsL8pYOr+SrlADGQX8GuMKOJQgcMde?=
 =?us-ascii?Q?+bUZ6YHBHssQuranV2c13SqudpndLtThVZ9rsoyrQe4L9oV5Jb+jnGvNBPut?=
 =?us-ascii?Q?BKnYZdV/Bs1yEWctbotgLGLi6JwN/icJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qRIo7H/eOjLuFqGbzJkCWZezDUehAWeydNe2bEoJRuV9uQUlRj2zMUtgqdZp?=
 =?us-ascii?Q?51MApb+oGYi9omqMORp49ak8oDXJtManv/+p7NmFFOZTmvNIPWtvATTD9JQ4?=
 =?us-ascii?Q?N2AKLUL+cTSQL4HbNWvhgZcwUh/4eXe6hDWQV5JQXv0XabF2o9dQqHx2uwX2?=
 =?us-ascii?Q?tgU0mrqa+ex0uEGqucJJm0QJJyIW+xmKl64jeFz3v1wBJ2H+sXbtue4C8zRH?=
 =?us-ascii?Q?uNV9sQ07puOM+0e+17ti/KXi6pp3AvKJJq4FsoO2l3YE4K4fFf+etii8Ffjt?=
 =?us-ascii?Q?SO1u7UKTs6i2GsJPJYNTZ8WxUydkFd9n+TW0MTDbMdeVubluLggJTKyzCJjx?=
 =?us-ascii?Q?P3PCJ8PRK0/nUbKvPOyllUQkCmTd6G+E7jxDQr6uvSnSm6rr24uF1mI8348s?=
 =?us-ascii?Q?ZEFI56/dozfagl3OzM2BT7a47t+AKksEtv8Uj2NyHHic2mNc429INe2GJtBO?=
 =?us-ascii?Q?y7jD08BgNDe9quJrXpxj4c9XNM1iyxzp1QFjOYTEtLE0ET4TKCjKrK/7L0aV?=
 =?us-ascii?Q?+GLs9ZznklBRsCvAll19F/ikeEf5oY9bVmSuqpgmWTkeyYfcU+9QDKqW18Xa?=
 =?us-ascii?Q?ggl+kwB5YS4ZAsjTqPvamW8jDa9GuDCi3oc2tVLznWTwgmIYIFiBGDAFECCG?=
 =?us-ascii?Q?cxZ3x16pHKIjLfBGuSFiuUkZZFO0XkcZWXUulkxiBxd04T+QtIHC87SkO0qH?=
 =?us-ascii?Q?NnTdVoWEbkZfJWF3AWOTk1C2apxx4AGssZaynhfplLoEYPvReo8bpzQr6IbC?=
 =?us-ascii?Q?y7LZ1cPkPTHOJH5hUxJ08CMm1Wg+ArFWcFhjA5S/aJgvz/Nz4KV9uCAaap6F?=
 =?us-ascii?Q?W8eUyw+sty6RfKtnI4Zo+Gg+jIN4Da5TN2U9kKFc2AHWlo5YDR7ekp0KI9KJ?=
 =?us-ascii?Q?z9a4wFoNTtZhhyslLMOO0imw83/zJgtAtCXwo+ahlKnLdXPJmANbsgOXgcBO?=
 =?us-ascii?Q?NsICKBu3y/CWsqFMkWenEl2xuZdd/1HESEPF3KTnrXvRWOjBc9KMIQRiVY7f?=
 =?us-ascii?Q?9RyDX1fjRkFrPpJgstTnFXG2OESQHN+7CXWAoMtLt2CLyp210txVQy5mh887?=
 =?us-ascii?Q?nH/93wkew7ichfhxI2mP/yXpsbZPbsx00bBCu1pPaj9QH/rwtWCasBNwpv66?=
 =?us-ascii?Q?ZlPa64cZDvRxljutoAw8XkCnx8cAp/KCb3sTz5tqO4QVEsKyagWbm543U61v?=
 =?us-ascii?Q?dKpomibGG8Glzd4IJhDel40JL9GdOigILs4Pal27TPhbAOmPD66NPJRTrt2l?=
 =?us-ascii?Q?7usiOFQzWdiuxPrSiB6jxIT9x2iQULTL2VlXvOIusiwqlGLBsb9YFqFH3O8N?=
 =?us-ascii?Q?u1kVw7bFiTip5yLHFcn+kM0eWvAzawA5duPvbJ2r96ssGZeOOqBYValyiSTv?=
 =?us-ascii?Q?CEZ2Ftdu0Z/Stnu0USLR4WDmFkfzUI5PXJRBQlQwYe3DvuzjDind7f3RrQ8Q?=
 =?us-ascii?Q?QMqOLorgc9GqzpMtUUeDqb0wCLqKI/8VpJu8qddty4zUHomw2hbL+LN9Qu0U?=
 =?us-ascii?Q?f/kwTvz/cQPHZT3Pk3d8+G3oCJ8oiNpklid51zQUlpXKay/YfgNACE4PlsYm?=
 =?us-ascii?Q?PZc75H/CyJ+9m2c3derxpQcPKFXe265iLBnG7Nyw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54e2eda-f881-4fd0-6b2a-08dd54c69762
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:07.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rarq1EUiH61j/rA9+pRVLUAkD0uTPq9sfUivVKORirhQRcfZlVu3MO7e/Ova+fBPGM81VO6OGJTwV/1qJ/pToA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979

The 'xdp_tx' is used to count the number of XDP_TX frames sent, not the
number of Tx BDs.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 174db9e2ce81..3cb9ebb13b19 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1917,7 +1917,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
 			} else {
-				tx_ring->stats.xdp_tx += xdp_tx_bd_cnt;
+				tx_ring->stats.xdp_tx++;
 				rx_ring->xdp.xdp_tx_in_flight += xdp_tx_bd_cnt;
 				xdp_tx_frm_cnt++;
 				/* The XDP_TX enqueue was successful, so we
-- 
2.34.1


