Return-Path: <stable+bounces-47808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019558D6740
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815041F253E4
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6A17618C;
	Fri, 31 May 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cD4TE2vr"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344616A360;
	Fri, 31 May 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174241; cv=fail; b=XVO8l8oXQ6nqJuri4xvor5363AsOiYGYtKyNFeU/ul1ygi+hhRTPwrBELkAmJ/8XC3aCF/Zn/IQDSuQYUbiomsFUJBUiHH3g1qF8agGJcw14XpSMT3BKeR2mUeOQflNMWtxpWmkpWrbr4uvllDoY05UCqCKqdYZTHMVngEmRhz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174241; c=relaxed/simple;
	bh=znHkGDGAd2wKa/zwhgRsuq4KoHrinPDFQ3gAC8Iedew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0dgVz27lT+4jfffASTZSTwJuSHQoRT/lTtqwi0Lhb3B8eKFSW58Y7mSXehA9yoyfZgSaRAtv1u09oJu0/i3DHOoUHtlSBzucSDrOz+92/mWPvwtSLeLGGAclQylywp/SPD8EwqJ2NzsO0lWo9D8UHWpXD3xw8+8I5mxQ5cwPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cD4TE2vr; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYckeTFKa0YJrB9tNrZjLgyPSh78OHEFZfDoe3tRKbsTkMFKjt8hEDwJs+sQE+UXecR6kgYU5pzA5TI+1fvnjsro0PNy3ocJHxaYfDS83Y6gzAbqzLBrZQShVGvnDH4YnXV8DdRGCb7QGq5sgTj3v+o0m3YriWtdVid0uZw5U5VYpVnuHY2eyhYq2XOVrzW6ARutitVD+5z+3NAnuFB0vrRh/1vbzMbKi3jEe5u7Wg6/lkwu/NgnvbFPIyf0ZPmuQE2S17bjfY0SDPzVVTXo5ll6qAyxxaDcy5AnacvPSObi4SGf/aotDN2wJZiWkMuePU2X1WQVojrOqi3phnWwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmY1o+LEREUeqyvixFHgYYetL1+HS65155+MSCAYiNM=;
 b=I1NhbWb2cZPwOEUeiu8EZZv+tf2Cfy+B3TQL/LKIUAeyVwOs7ksjvDpOWbjUYX5U4xiL4nNSabU597i05utblgsD0MuSQlzFz6pTqXfReSMMtYLY69SpC/45dbol0izKJoTMrcZ+BcyM0p8VvVpJIj4kMbZ3tZGpObO1FqkCTQOe3E5q8aKK8r8zC0+HXTXBSbaHGwwavQnqRqfbdgA5I4C2Iqzs+qT1gOsDGvlaUwKIST7wNGie0wcPig+ob6I5CUWGga0dwKOK6EJGRNtmbLfIdZDOadwzRUVPYLFxtxnlOHbKGk2V/EjI5GapxbiWghWX2uBtKE78ufLF3QYS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmY1o+LEREUeqyvixFHgYYetL1+HS65155+MSCAYiNM=;
 b=cD4TE2vr1224uf8QVEWZWEr7fASwW3uL2vg8jZhQfiM7uVIzr2CjfGks+r//T74kvvIdvbR4OZhxbmr0K5GB+36X840QrCEXGA/nE6IerSkYdX8WiBV8uD42rbHfKD6y1w5ZjBz+4oRsdp6MaF6DNBctgUbNOxxcgpKKzdEId/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:50:35 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 16:50:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH stable-5.15.y 1/2] net: dsa: sja1105: always enable the INCL_SRCPT option
Date: Fri, 31 May 2024 19:50:15 +0300
Message-Id: <20240531165016.3021154-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165016.3021154-1-vladimir.oltean@nxp.com>
References: <20240531165016.3021154-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0093.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::22) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: e037b366-8f13-4d19-10d7-08dc8191cad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5WshqA8wVFMZyOmU7NRGu4XWpgaK3JTNjsgtu6Uu9NFpQHqkD8gWSuNZ9Lm?=
 =?us-ascii?Q?5RVX0HD9mHGVInwO4IqX5ms505bv4RrZ4Fc3OzrMKrsDtgS3AQt4D5YUTgwg?=
 =?us-ascii?Q?yZ7/utRXDSXObC6WRhjW7Fs2V6yzg6lqQO13QnS55lH+3a/F1YynFqqR4ob9?=
 =?us-ascii?Q?B9qesrliuBzrBUp5MYKKnVu0iX3Jc+8CTrPjBqUTj7ylLxaSk23NA2d9Djy9?=
 =?us-ascii?Q?dUAkQa5fhVsBjrHSUgfdtwyKhUzTH3KmafJc/w8EEhn5b+o1PidUO7r7wKpp?=
 =?us-ascii?Q?ppEQGNtiBapn95RDXaLZXwK8SvFaxKYgKxH1CXyzT9dwLkRAIHR+aj77p4Y1?=
 =?us-ascii?Q?FY+6ReyC7qx3aL8t3az6BDT0IL/ERWZoiR6MpmXD8Xw27uId45095HOP077e?=
 =?us-ascii?Q?82nesB8WnsdIEuXf/BafOYMLkE9c/ZmB49xLih+PeaKopE/7ZJtio4qFWQae?=
 =?us-ascii?Q?L5u0J0TAaHbJym7J5vzOeVWXnSt9vz9/IVitfGXclxNDeEhL5HcgteKyCnvp?=
 =?us-ascii?Q?X6tIsS9N+Wx3i/o4ZvVggJPbGPqmfYt+xHU4MiICivslcMfQNv1DDcHiQlD3?=
 =?us-ascii?Q?3DS7W4Lht5I31UfwDEvyeSwEZbr3ZyCrdgH+74YyDNx6pzCWM7cOMSjHZkUV?=
 =?us-ascii?Q?1n9XiGUH/hN06zkbq7c8TAqZxmNYCpZeFuBoBSGMu6MtVrfCpCCNncWMb/+z?=
 =?us-ascii?Q?vdJ8iAqA5Q5zfHQJNwCVcwasn4+L6M9ng4Mehafg9oA26dmIrz8bUJQEYRjW?=
 =?us-ascii?Q?0sNp3lFlBnccUtH1hnVsrpr6yzJFu7FIyO2sK/LvzxqqbXI9lwK8aiAs1npe?=
 =?us-ascii?Q?fub+mwClWoahiqbyLpGKoDRB5kDou4mrb6Jx6nMpTXLA1o8nq2XVPKth4Jqd?=
 =?us-ascii?Q?eWqFp5Gxi9qhos9aIopHwhrt7A+2CBHm4wxhpD4yU69wc5g0F7Wj3jTOFamX?=
 =?us-ascii?Q?jUWeGaRiX4TeaX+Xp2O9DC41R02eTe1kHJdz4aIGeTHCMI3g87cujZjU4Lds?=
 =?us-ascii?Q?YeBLqDOXZ7Di5N18APXg8bT4s/PhP/6yww5OAa92yfS959hzTaXVr+539sK+?=
 =?us-ascii?Q?wrhmwTflghgBWx/Thj7zXJwKH1sqZMPTbsxz1hQYCydy1/N1gCK9Ilyf5Z2P?=
 =?us-ascii?Q?VOYegUajGjFD6khwjAnxgYb2YokDWT3lxPBz/0UieVY2jU2O2AjEEBkvRtfz?=
 =?us-ascii?Q?KcdADwy6Z+RW64ZksiXiU+G01xY1kOtZ1fJ4fdVpiDoPJapAQ5k2l+joPIQc?=
 =?us-ascii?Q?d6knMUaDZ696iJZAS3K1V7dD1Dl+gEIHExejrkIxUoMSh5zUpmOoNlPQBy47?=
 =?us-ascii?Q?13zEb+094LoOj91PEwzIDlH20B0lvHuXk+j3ecV2270gfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1e2arjndqCP6+L3I7jaFtf24UafDwA7GHdl9HOJYxF4KZkSI2FcUwkduyx1?=
 =?us-ascii?Q?zoX2Ma8OrfSLH0857F2qrwh9GR/GL/dJHmncSXrN5bdL1o9Mbdl9J/0dsz0N?=
 =?us-ascii?Q?jLwFZOSauTxv/ZhMCmeyejJx6nxc9S2Xrt4KwPqhQ6aBcCBc3Pcp1SrE6GsK?=
 =?us-ascii?Q?3MUm70gkqZMkmG7AKfl2uY9sp9vqn6YuU3G7pRqSoZHL9/I18IjPefEP597d?=
 =?us-ascii?Q?gRA6t9dFctB6yb6CdwObq39gebnfOuthj1MzJYg3KMziMvPPKmMd+tVgCJAL?=
 =?us-ascii?Q?CzEiboVNCDMINQV5E8zrzO+Ao8TE3hbZTa3B4zULUvRxx21u7jLOxqdPm2lR?=
 =?us-ascii?Q?a2sy2plLOJcLWv1mrq/RkxstMidXE3sTJky6FiQdX7R6HuHFn5Wm3JMvUOZl?=
 =?us-ascii?Q?nvJS2eV4ZFBjOCo1uRnAA14Edk1YylSVQNFbFY/KnpCN4K538RR1dLW66yb9?=
 =?us-ascii?Q?ww7ks+C4g2bUqtpI3VcSTtUPq18L9tocOvJAE6cAGtRNWGuNwCPCIUagg8ob?=
 =?us-ascii?Q?pAwmR/GG5L2mDCKyo0AQAN25zG692q6jC7SXFxgxdD4b7GUVrZifXYmux2/P?=
 =?us-ascii?Q?D7wvDNgJkARI3rqXLMW8xg5Prj2lIMsU8w49w/KxqfyVJ9xjhJbM5vxJEtWZ?=
 =?us-ascii?Q?q1gBFIWe8Em+N8F4QTsGPxSgY+HkB6ZctDFoQCc89EMz013pppse/DLJHsrW?=
 =?us-ascii?Q?XnCCVUu5b5eZwusKiFPalQGwDswkqwD1osJWq2P5nhxieeJwt6vyKQrat299?=
 =?us-ascii?Q?scX0nYhbYgghvwNuKzGcvbqGNBlRKfkpJZq5lauxpzd3G0CIeOXnWN0YMhkr?=
 =?us-ascii?Q?4ZYKlhEF+7avC3+ecRdMGqIbMDwiu76096Hs+dTuiiesz4LwPkc3FF35wrHy?=
 =?us-ascii?Q?ksrpVWYeqwwN77n+4MB8HSqTqzlqwOKWdFdPmlbs5Rfoi3gXMHn7iM99mRpv?=
 =?us-ascii?Q?t7l5PpZlyUQLfGerkbc5SmPJWvU3UkCYPN4LKBY0z7OYahEDfprgxGHjXLjj?=
 =?us-ascii?Q?+XzhiloR6uTVFiSMlw0EKVSQCDl0beHk9m2boaC6c3ZV2MOzGubG3prTzQtY?=
 =?us-ascii?Q?EZBebGIQK8IoS3aTAzIIguV8qRiU57Nqa0GuhpJSaLX0YNI34tBLZfUdjPWp?=
 =?us-ascii?Q?w+pSfHkUx6M4Qtv7Dl9ibQXQugFA1RSc3DPjh8SxzBlVyIihoWv5cybaLXId?=
 =?us-ascii?Q?+b+Gb7C4cRdBGmZR7n2J9FhZky52+fPNNqjgPQet8ZgClMjCEomc6MnUX1cK?=
 =?us-ascii?Q?OhGwZrd5eS2+IxIZj96RSoLwtXLHD1U88K/MiKGI3QdhJGvmZ1nsNzi7RJkn?=
 =?us-ascii?Q?+hL3r2q6zQ6+WJaLrYCSgv4V1Qzdj39/NQIUSLYYTfsfgXuR3axnnkg+pHH2?=
 =?us-ascii?Q?dpK9XV8sNU719GYok1pOpiP/8QnBuZidBbHs1umFtSZzGSu+iRVeKGqTZizL?=
 =?us-ascii?Q?pzrXwuzxro1sRyWOkyOaDgpbCz+SUdUogA5grtsgWofeDM6ntFZG5q6Tk8dJ?=
 =?us-ascii?Q?vnbIkA0zy+5MpphZ8A6W4ucluRwjLiufpbqFqYUGbeACpndUUl0t3S9iSc79?=
 =?us-ascii?Q?rXIVV8xfQObsCPN4NVHdAPro1OC8KtVmlzSsBI5l1cP3Z4QJ3EmEmeRNYnii?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e037b366-8f13-4d19-10d7-08dc8191cad5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:50:35.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T76d/Xm25i+Qn1m1GDMdLMhDG83tj5ZnPFWgfvBylX8JaeCZbE2gIw1wvby5Ap/J02F92YKiNdz4KFrpTjTh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

commit b4638af8885af93cd70351081da1909c59342440 upstream.

Link-local traffic on bridged SJA1105 ports is sometimes tagged by the
hardware with source port information (when the port is under a VLAN
aware bridge).

The tag_8021q source port identification has become more loose
("imprecise") and will report a plausible rather than exact bridge port,
when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
traffic always needs to know the precise source port.

Modify the driver logic (and therefore: the tagging protocol itself) to
always include the source port information with link-local packets,
regardless of whether the port is standalone, under a VLAN-aware or
VLAN-unaware bridge. This makes it possible for the tagging driver to
give priority to that information over the tag_8021q VLAN header.

The big drawback with INCL_SRCPT is that it makes it impossible to
distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
with zeroes. Only if PTP RX timestamping is enabled, the switch will
generate a META follow-up frame containing the RX timestamp and the
original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
original packet. Nonetheless, in the absence of PTP RX timestamping, we
have to live with this limitation, since it is more important to have
the more precise source port information for link-local traffic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
[ dropped Fixes: tags for patches not in linux-5.15.y ]
Stable-dep-of: c1ae02d87689 ("net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 493192a8000c..888f10d93b9a 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -853,11 +853,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.hostprio = 7,
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
-		.incl_srcpt1 = false,
+		.incl_srcpt1 = true,
 		.send_meta1  = false,
 		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
 		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
-		.incl_srcpt0 = false,
+		.incl_srcpt0 = true,
 		.send_meta0  = false,
 		/* Default to an invalid value */
 		.mirr_port = priv->ds->num_ports,
@@ -2346,11 +2346,6 @@ int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 	general_params->tpid = tpid;
 	/* EtherType used to identify outer tagged (S-tag) VLAN traffic */
 	general_params->tpid2 = tpid2;
-	/* When VLAN filtering is on, we need to at least be able to
-	 * decode management traffic through the "backup plan".
-	 */
-	general_params->incl_srcpt1 = enabled;
-	general_params->incl_srcpt0 = enabled;
 
 	/* VLAN filtering => independent VLAN learning.
 	 * No VLAN filtering (or best effort) => shared VLAN learning.
-- 
2.34.1


