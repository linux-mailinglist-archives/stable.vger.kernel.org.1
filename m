Return-Path: <stable+bounces-47809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643708D6743
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BA728A880
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3C176AD7;
	Fri, 31 May 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fwlWT/OV"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5366176220;
	Fri, 31 May 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174244; cv=fail; b=WBvJXTwOt1H/4y7UpfIxTzUb1V1MOpZnzUwzgnhifqwiWdX07QEyEQg4lEy5erV+8oBloZbL69PdNNAXJhKJzkEdUOEwGCAHm00v792g5oOKwsaKD+YqUNz3wlnoLg2rMVG7jaVKTHOKzkoAWMlOmsFuKPl9+9whq2Q/jL0X0dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174244; c=relaxed/simple;
	bh=0K2ngxY90rYCqbqMZNurw8oLJ9D39JP+SMdsqQRMKxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5y5/qal34IIfoTPFMgwMjQkAHDalEhcAFWiDjt9EEBTynaZo9IOxp9PkwmZXuV+xFtRwhChzMytrXGpPRTLNcd+V+XfdTZ+2HCBKYrPS0pcof6rtH6j7MoXVbuxXaWJ4a4qY3TlOn6XDl1PTrhDUY+d57XFSpz7EV9bP5NL1zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fwlWT/OV; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Cl22wIT+WhAnVNbdI8kaHlAZM4Ax2C/HYduN0lnF5DW5FxK4Pchm3PMJx7gHaG9Bz2nzuf+7hwp5fVpMplbKcf1jOi3iJ4md3BBpt3N5hIMHl1ElnyVXG3gyyKPqbN0a/8Cpk9r969PV9xz+TuOJthkcqMu5V8KhrTnm0GRVWaUZuOqqKIgPD9j4OUtauy4DloyXTCpF4XAGS/s177gk/Pk6ie6kmTXU3aniHxhdvYjRBknaAzZkKuD3FjOxSaGjosddr9jr/e/cLmRAo9NY44jVl6G0iilDHuRQdD1wBXeUAhZ9KansD0rifC91MOBnUKWc+LbuRqxK9h1j0g6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1GLL22PJtQ9uo6lVy0+SUqwdLR5lFOu5hKmhM+Dzrk=;
 b=gqbVz/fCB9SOaRlYKYfv+2fFtnjwfY5GebK0DHxbqghHwrNvAeGAxRdy1FFAd2nHjASaS9TwUeD0jeDVJ/WOgWjjYR3TUfQTfRsUQvfO6oZ43qvoncO6v8RXO1n0ZEwlD/sds/EI2cqZtaEXRZPiQrTsY+McrTMEof05VuyX3Z2VxTByYIywcQ6YEf4377CfXy6eAbCNcGj/y+R9LAOI0HPgJOSBuLiha/y5fJ54rVm6l4qr6q0zdCwosqRZ5/MjHWIiJ5AwERcMli+F/S5FZHXqUKIaNcXkd7m43TyvU1WoVBIALg7lYBTvCCTUapJezYM6TjGcHBJdTWYYIQGKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1GLL22PJtQ9uo6lVy0+SUqwdLR5lFOu5hKmhM+Dzrk=;
 b=fwlWT/OVECIGKlBGy0uIHTep8ilytyyzOL5s+b2m4GuIsOHPjLayn0q1MW8Fd5QyJvAvj3TDMbfw3egEkcBPLLp+c7tZxKEPXjBS5WSy2BJ3PqEMIn75RZceeZkUJW4P/aro5O5vhsjB/NDLI9XPCX7t4AKi1DgQzYC4az7+0FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:50:36 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 16:50:36 +0000
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
Subject: [PATCH stable-5.15.y 2/2] net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
Date: Fri, 31 May 2024 19:50:16 +0300
Message-Id: <20240531165016.3021154-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59850258-b716-455b-bbde-08dc8191cb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f89sr7RxieAuSJKmNEe2eiIZhVQgvw7OZUQ/GQX1wIsrgpy8gkGU7sgV3ErM?=
 =?us-ascii?Q?kzW11v5PhvSlIDsBkpb6X+RVaScNhdOTkYeQVKmURfQJrclGGjkHqyYBW5sQ?=
 =?us-ascii?Q?8emtlKNIjWkAmB2FiT3yqzaEvc12+Vb0pkfP5nIiVI1rFbuHSFaJzbAhwaOc?=
 =?us-ascii?Q?6K7rBcXg2b1FIGS8/DeHQG83UJxejp5iFOL73kuk5RYwtJcfJ5sN+uVsatXb?=
 =?us-ascii?Q?9s5AhXnwHWiPO9lLxIrCbTsLN5l/8HvCPpTFTuaSdfnwTQfnZOFVwT/kBVWh?=
 =?us-ascii?Q?muGE0F6kNWk02ECH3JG/aAowoQlI3f/ONLyCJO71OtZ47iHbOubEBiGVbGe7?=
 =?us-ascii?Q?Md4xUWuk5kcLn3a63eKE8G4MorbMHlizT+J3Zs5FTLNMJWr6XJfTnu1dREek?=
 =?us-ascii?Q?ms+WjBadmLRYjG8+0nPZd47VsOg753o1NN73RRTVbHBNlZcckaIq8ula5nlv?=
 =?us-ascii?Q?49C1DJkCkq+tFj6+rU2Crb6MoLil5sGoCAjyob+12HcJCO9QN6Bjc1mS5uW/?=
 =?us-ascii?Q?1/8jJCdFA8J/GwWWpbgkWCdW5Lhvs8lo1sLKxjwK9UXCrlrytu/a277peTOS?=
 =?us-ascii?Q?U9g6up8VCjNmAl+OqlL6D87b0IYH28+1akapLsiUi5uv18k0HIS6wdMFOuK2?=
 =?us-ascii?Q?VZziVJAbMe3b+HnePqCNa74QvXSI1tNvyxzm09J4wuTrslMoLTSTirjwtQ6S?=
 =?us-ascii?Q?Qz1uEkCslm+gX+9V0odegwiTN32/5mjX/yxgC273YxXfcDhqaMsfSMkx6cq5?=
 =?us-ascii?Q?d0TuZSgoHtYgOj3gyCcLiIJFPts+pPC3UZrRn2G0g2WLso7dfh0C5oD88Sqq?=
 =?us-ascii?Q?tWSJHMTcuq3cXpRRvogf0JDoZ1sO0eQJtbvFXl6cMMxxKwjalUB9nssijN0A?=
 =?us-ascii?Q?N035Vjks/SlITF9W50WeG1kVSO1yNf18hJFGxTOTBNMr9+BI0Ry/muid587/?=
 =?us-ascii?Q?D5hy7QEees0pbbR4p8JD5Dt7ZGr0ib7jZTSlzdg4yvqUh2v0PAIWQ2JiCnuZ?=
 =?us-ascii?Q?d9PSpo5povZEVWY46IPo2KJR4eIUOPiiMBE2FOf7ahWfvHiJWhZsy8VbaiY4?=
 =?us-ascii?Q?/7r5VMRCjJTpX/WBkPrUVWAWqkPdqVLtpYWk9BjieoAZ2BOHm4HhsC0YmPfe?=
 =?us-ascii?Q?O0vi9zFiqRF+nyQ/bxSjNKgmnhUSzs4acgKRpfcPg2s70WCUTeISf06IGrxy?=
 =?us-ascii?Q?LFAkglK/S6WgbtvD8pPF3Dc0nrrzJ8o/b7EUb1YwjdvjbLT0sXZK1OF7pQAu?=
 =?us-ascii?Q?jdaFgsUf4GfHxcrvZiLKVGXPoZhMsVjGiamRSX/4gW0a+x46Xa5qoZC++oly?=
 =?us-ascii?Q?G2ByzL7omo/wWlrwGFjBbeY78OnBWUOR2KFPL+TxYoMgkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQ4Sgc8LXnbUYhnv2d7kyz6y5HOJEM9aofsUmWPb306YVz/15PlAhMNRPWFe?=
 =?us-ascii?Q?+/Es1PXG1CZS0B+YApNBhvlp+rKEOnshATQQ05wFPHEGVobOn1utNei+tvV3?=
 =?us-ascii?Q?pbAEHO6hEwnZvFVRwTk9uoeR/luZL7cSKLTdvQxnp3pWgrsfh/tshrPeTDUT?=
 =?us-ascii?Q?cNlzXlQiw2RqYYD2c2gI0qHjz/6R+esZixBQYklBqvNvW3mbGKo7vV5ST2KE?=
 =?us-ascii?Q?3FFFhw+azWZAcWe0aCWCMNVs+5cjzLcMpC1uvN9kGNuebMv8PXfjpfD3Z4kd?=
 =?us-ascii?Q?HlwPmOLsZMxKK3z60WVzNEmoiJT/192rD643YK68hmUHdPX0tcxSEAuc1IhT?=
 =?us-ascii?Q?6keZn3EM00D8eF/hH5gwxlA48i1gIxNJgjL1WzLmah8cipvkNbtQuxcf2Br6?=
 =?us-ascii?Q?OtTXVlPfzmnoWnoamjzyxE0TwTHSdfjlj1k2JE/V8sCpoZxRUtQtTHEWELj+?=
 =?us-ascii?Q?kpMCRyjbA3hhuLogZXq8DdCxsHCDZRF1RL49fd7NmAN3WBuDNHdCKFKedeZ9?=
 =?us-ascii?Q?aNRaCS7pG8ypqE1LzPwhePhkEyNfODeiETR/acXX11loCqEoowdKzY7J1LGb?=
 =?us-ascii?Q?rpIo+CM+SZQV+ZQscW53woG0kH7am0xDRM9QaoXxBEo3fZk2Sr8rC6ndraZ7?=
 =?us-ascii?Q?uTh0dLMla1jAsdgDD3ayc4PaXyUYqwVuO2VvoQ/+PEaT0KBuRRNo4NmleY77?=
 =?us-ascii?Q?M2QqhYbE/2Gazt6qTMj/Hdnga+y9ZT9MCDNbVqn+7ZwzQtlLdy9plRJ2Ybob?=
 =?us-ascii?Q?5HcjV2HbO2OD5dZ5zajeBNqPgli0V6wt2BRet2yogAVF05PRtyxy5s8Ciiz3?=
 =?us-ascii?Q?Tr0JHNdRcRgIZPresbQkSDJxzESg+ZFNzjfJjKk5faU88rNoOqn/1VTuS763?=
 =?us-ascii?Q?HgVZsdFoO6XqjpKnm3It7CDtrDWsSvW53Hwye7Fcbw/Ng5S8Val3TflQkOZE?=
 =?us-ascii?Q?UBD5udBiAsooQll0WTlitVxCOz1cBTEOpvGAiPBR6c25ewor8zjbvsOCI9YZ?=
 =?us-ascii?Q?jRglDJSMjCQ0VOBBhIYu2SgZskNOZlHMxftEhZPgwM7Bka4r+m3vS9VPhCoW?=
 =?us-ascii?Q?8UCB5Bi2dN9LNkY8PoEmhINbCAPRpzqyalcAw7RPt7FR2uMlYzROGNfp22Z3?=
 =?us-ascii?Q?q6LpHVW28wF3x+xY9BwVc1m3MjAw/iaGqw4oSHP1I1RyEryLizfwf6r4jWsB?=
 =?us-ascii?Q?JXCriUUDdp6xqIno0936m2g5WV3bC/EbUDzpN1N6HA/PPwSsAwivxugUrDzy?=
 =?us-ascii?Q?ZEGMuSWLpRqMuS7bvPafLf8sow1DU611W5+8G/HZXofF0OCsfMO0Oe+gsyqX?=
 =?us-ascii?Q?iRHU1qpLb+ndWEbqFwCtVi8TqA6GFwkCzoYlcFSjQsfMCuv1qZXIDesx6GfP?=
 =?us-ascii?Q?jIOkHX2X/X3a1+zmFV03yh3fEMJ5G3P/YGw4ujlp2wBfwQUxgqieAy7PEilO?=
 =?us-ascii?Q?MRqKgva/Rwqg6T9s0oWRCrT9gyFh14EkeeN0G3Pglfo8ZXG2kysyEQGc6O3Q?=
 =?us-ascii?Q?70WgYTyH8nXUIiBje5LEj0KhIAiTKc5ASmbLk6SoFMetdrNg22rNc4zfx6Lz?=
 =?us-ascii?Q?K+THuItxuheTABFXB+SjQEjVZwySwOrQhwoBBz3QFJFrQpt+IiddP+RYS2Ei?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59850258-b716-455b-bbde-08dc8191cb8f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:50:36.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ4qPEqZ8lFofsQdZ2QI4NPZGT1+jhHBLeFATFeewSlNOCkOsD9QL4q2LC8b2m9lk6WjOkvmQAyK15k4bcvx9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

commit c1ae02d876898b1b8ca1e12c6f84d7b406263800 upstream.

Currently the sja1105 tagging protocol prefers using the source port
information from the VLAN header if that is available, falling back to
the INCL_SRCPT option if it isn't. The VLAN header is available for all
frames except for META frames initiated by the switch (containing RX
timestamps), and thus, the "if (is_link_local)" branch is practically
dead.

The tag_8021q source port identification has become more loose
("imprecise") and will report a plausible rather than exact bridge port,
when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
traffic always needs to know the precise source port. With incorrect
source port reporting, for example PTP traffic over 2 bridged ports will
all be seen on sockets opened on the first such port, which is incorrect.

Now that the tagging protocol has been changed to make link-local frames
always contain source port information, we can reverse the order of the
checks so that we always give precedence to that information (which is
always precise) in lieu of the tag_8021q VID which is only precise for a
standalone port.

Fixes: 884be12f8566 ("net: dsa: sja1105: add support for imprecise RX")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
[ Replaced the 2 original Fixes: tags with the correct one.
  Respun the change around the lack of a "vbid", corresponding to DSA
  FDB isolation, which appeared only in v5.18. ]
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_sja1105.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index a163f535697e..aa5d234b634d 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -489,10 +489,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	is_link_local = sja1105_is_link_local(skb);
 	is_meta = sja1105_is_meta_frame(skb);
 
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		/* Normal traffic path. */
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vid);
-	} else if (is_link_local) {
+	if (is_link_local) {
 		/* Management traffic path. Switch embeds the switch ID and
 		 * port ID into bytes of the destination MAC, courtesy of
 		 * the incl_srcpt options.
@@ -506,14 +503,35 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
 		switch_id = meta.switch_id;
-	} else {
+	}
+
+	/* Normal data plane traffic and link-local frames are tagged with
+	 * a tag_8021q VLAN which we have to strip
+	 */
+	if (sja1105_skb_has_tag_8021q(skb)) {
+		int tmp_source_port = -1, tmp_switch_id = -1;
+
+		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vid);
+		/* Preserve the source information from the INCL_SRCPT option,
+		 * if available. This allows us to not overwrite a valid source
+		 * port and switch ID with zeroes when receiving link-local
+		 * frames from a VLAN-aware bridged port (non-zero vid).
+		 */
+		if (source_port == -1)
+			source_port = tmp_source_port;
+		if (switch_id == -1)
+			switch_id = tmp_switch_id;
+	} else if (source_port == -1 && switch_id == -1) {
+		/* Packets with no source information have no chance of
+		 * getting accepted, drop them straight away.
+		 */
 		return NULL;
 	}
 
-	if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
-	else
+	if (source_port != -1 && switch_id != -1)
 		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+	else
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


