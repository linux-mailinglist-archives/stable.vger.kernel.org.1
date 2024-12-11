Return-Path: <stable+bounces-100624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325949ECE87
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83BE287C45
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346084964F;
	Wed, 11 Dec 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="G+KUYqmV"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080C15A858
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927134; cv=fail; b=BmeuYOwLcqZxNKqX+1JJBLK0FfUJCk4xoL3N2oo++rzJgfd7MGjHo1ZTIDyH1SqAWuYx7UKXTCapzwvhgp67iIysDSyOFxq6JIS2fCv8hHBP0lBogrBKllR5GPhf7TRhRPu/6G6efQUNhlZP1mDlhyvT1lno6Gf1npMxsDryh2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927134; c=relaxed/simple;
	bh=6ZrY8COCsgiSs0EDk4H2C/3yTe+lXkUl/ji2tU68ieI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p7bP6DGER/OyXlsG6R+cAwvO5belbeiDm6moFPyvbYq9FNi+MI8mPzHCnNpzVg905elKdNyeN03Dz9qRc9RVcElsLnbMf1BbQB3eS2jLpUcLqVPMZqAkNN3/ULu2/n1pFMYiOHfCC7IWX9ksl8TwrB0Nq9S688+AyaPJEqWoYeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=G+KUYqmV; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41]) by mx-outbound42-176.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n09i47T5QPOg+LL5fbnwQ+iK2PqOScdC2BfxQdzI7FTFDtlx6KL2jBzrfvVc5MDnKPALkmAOQ9f9AfFpOV4pDRRA77HqTbwebAPbi1YH7KMbNGcOB+bfFpQhUT8P09YmM1uwE7ajceoo0FzW7HwXhfYL5jk33ZfV+jCfrchpZmn9K5Lp31HCgwtsz59HMO1TP/BPzWeXAIqdtRB2cG3/d/EIbeEUhTJdqO2RaGT0eqy/Z0qeY7iYG3PSc8rU0CUE2VbxmHcbG/h5CMcf1s7Zks7MJJPaLL/Kx9Oot38TpX/APARWfd18jeldrFnYSicoq1NltaqVSCREwpb+WfAUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ3g/p5j2bga8CvamwAWtisJi4WUmr1gv+FBHgmwVBM=;
 b=ugB6M2NpD3DmIdxXzA6qVHu5jFhwf9Wu7SE/0BGaG3rIw8jtfrTkt5e3q6HZkEGXYlPm3R7rLv9xXQV/O+xjrgzAtCLnrwTlhk1+llSfx/eRPCIBerS90G6G1MlDYFo5NAshxQ8mXWM8wSgCzCMwc6i+AwQ8OlZIESCaI87+avEg4bsCLZA5bkgyRTi/u8fy+OZirpfkUBDI6S4+9/10xF3F+1UghHl7rXmLsYprKrZPpGj/0IQyCRoVgYUwdUr940ip2eF6wRSMfALfPzhzwI+A8kwbGgEGp3FVLhHpi7bkfGnITEjbvlmubE3Mv2c5ZXmVvnstaGyzB+E0lLB0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ3g/p5j2bga8CvamwAWtisJi4WUmr1gv+FBHgmwVBM=;
 b=G+KUYqmVVVpRyHJDLA9mM2ys63cd0FSxcWLwqdjQaT1ya2i/4qi0UQTgftv/JVNcIHHpInY1HNYYfvFBfKKzpZbM1Dt2dCMiguSP3IcQ0iqqDJta00HLDawjmYZ9/rb+RCHvxyM2cmNR9xedYOVHCNppWIIYPp8kC9ZVT2/v9YmrbSG5OCwnFAeoQAw1Nfr8lRQROP7UsFu2lYbtlKEma46M4b+f4JngPYAvC4r5phU24hNJPg9nnLE9Vh5hQy49YmTmyMVx+CgSju7TWaua62h024V4YFy6zI4Z6fgOYEDVmN7WHPSqlSD33RKm9qbm2bOMkDZ+wcc9JeoXcI/ztA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 14:25:26 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:25:26 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: hodrob84@gmail.com
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 15:25:10 +0100
Message-ID: <20241211142510.1407635-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|PH8PR10MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d582b14-2eec-4931-0aed-08dd19efa7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxlKM6lTU4HhqoRFx+B8QiOAZ7SWXcimbTpFc9TiEWAkgsAcxSLSdVxlUpee?=
 =?us-ascii?Q?TtHEBiHZinDxCYDE85l2OxoGAX/FiG0ssdymUPZPq21qwVTxvY/jEeZ4ks1b?=
 =?us-ascii?Q?dRTyE9TS+v+W+moesm6Rk7kovdXHm1Clgm4/kkf+TidZL52ucYhiW2BvExkX?=
 =?us-ascii?Q?w6r2osvZm6Syb9X1Jj/WbK77QlINIE5O604FUymLQhMUzFSu6xOQL1sBrnS7?=
 =?us-ascii?Q?cWxPd1H+VMeGcNM2n6H25vgZBEGItr0jrYb/6X1WDGejyhuROtD7lE8/ZTAR?=
 =?us-ascii?Q?I2qidgjLwvzJ+XcX3h8oWuMsBkXnA2ynLGsSHlOSZkhRn6rU2lKDgrwWE0LM?=
 =?us-ascii?Q?aveEAo50T9NzUOMGIteGIOYudLdGVFF9XKmPXooyj33OilCHd/ShEPPnAJ4i?=
 =?us-ascii?Q?hqcfWrsaXWjVVqQhogE6rkoj3e0oy6DeIkgF2C9WkjveLQXVrkFAzRBx3MvD?=
 =?us-ascii?Q?briL0kab8xS7l0DYeQhzENtqXJUTVKx1A9EqEZ5rm4an0HLNWv+iRFcsMueN?=
 =?us-ascii?Q?rUHXQg6yOh+agL3KtbF2CNDeHWdIS5YMPkklzQS51Z0EnlRwNs54qhA4/xt6?=
 =?us-ascii?Q?cLf0xLO1lGHx0rbP8wjKDbTG0OjNOpUYJ8vRNpOyh9En0JhAlIJpTobTnTzl?=
 =?us-ascii?Q?HD9KCi1WSCHwbhle/KlfCCBJkHK+tH1J/wo8ndmw/GZrmhtma3UivP5R/MvQ?=
 =?us-ascii?Q?WB4M/DKFszWpSQix3rotZ8ujIG767DcMKeIPbXXf44NQ4y1mqgDhIL5CuziJ?=
 =?us-ascii?Q?Q+WyrmIn23/baIEH94+NsPQWgoVnR3x1pZddNh6z1fNM/zE+9razDlh/KDD8?=
 =?us-ascii?Q?WlJucO2T/DuuvxZP8KPitGbpnEc7LCmuo1k02Zz2gRnxe8pRnWuWirK8nt1Y?=
 =?us-ascii?Q?qAQaD/OWjgCF+ELjyC4hDa0O65FZiV4vAhD8wByK3YQ2SCJ/YM2HjIbQ7WW6?=
 =?us-ascii?Q?ySK7idcaPM4C0aaoScj9owkw/bn4G8KGe2InP8MG/Y/OrfycslJhhL6aUevu?=
 =?us-ascii?Q?poRbw2XfJ9x9PoZ0JEN7IpcrziYO9e5Zx6AemDNKfPcx+FXGdKB8TZc9Dp15?=
 =?us-ascii?Q?7AeKogzNidPHxWteY1wZQVCcANNWj4fAnfd+B3lkxau24257Kc+79cVNUW/B?=
 =?us-ascii?Q?SaZHir5kmtQf9nQKJqpPyrUyj2EOc8f1beCWmtIKB4f1tfD0PkiU2sMOsCGT?=
 =?us-ascii?Q?YRbrG1TpaXZuGrZiYrDaKWzszbZrJOAFrN7O00nXzL04EPvodqPQ/1/8025C?=
 =?us-ascii?Q?z4KrPCMEd1U/0gG5tVwRSZWnua19EGjyX0Sn4LDefPsRsKsGKoOV973MSt3W?=
 =?us-ascii?Q?ZNl1LT4rVSizWfG64a7hZX9F5Y++iSPdZNeHP4CRSWPMbbiyk1ctQGmCbbot?=
 =?us-ascii?Q?MhME3A1qkB/U/KVqGldJ/ftUcfbhaKYpHqpru+tLnrgp5qhqvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pk3RmrAVLb028R/lhDjNj25zY+f8C+8EykNOOg0hMpGXh9+JI9DthO+FxqxS?=
 =?us-ascii?Q?vY9FNvny9jea7A5RXXuWaiWkfmxh3mk1ykW3dD6r8mPQJ9sdbcUDbOmkbeZv?=
 =?us-ascii?Q?s/4953S4D51SQWvQR5Kg3EkW3YpaShvBsKn8HB0UmVsbeUUnJbuylzQPF+p7?=
 =?us-ascii?Q?f9unTUJrTrw6bZN/JmGk612NSDKGCH+yrvCCdJ+jrbZV1MWHPlboa79Ayi/l?=
 =?us-ascii?Q?ig/+rSkIBwWh7NMiX8WUDbdTg+AHpd3gqektRRavdRjfrBTMArDYU9+d2aTR?=
 =?us-ascii?Q?K3fUAh4ZMNS31+wDbTYnGFvf3eTpH+ZIX1e6B7rCyqNGyRukpjDQ1vi/WDz+?=
 =?us-ascii?Q?Yn48I/GGUt2akl/e8p1Mo7byEGST/EUkIGzcy1WQ34U2Ejob8Sqc511/e+le?=
 =?us-ascii?Q?ftsQo5Z1GjYctLW+prQd+E70r1mq6P7RIzA1hxS8eIadtZVp16WBf5ofcFgt?=
 =?us-ascii?Q?fTOmVXCKtYvDGFiOuFkGFUe5fZApt0OZ/m9XGbRQoC/ewVO70FQsRIvZXQaU?=
 =?us-ascii?Q?W+iZ/7aw8qthzMtWbZcWXsr7Y19N2dRDAM2ucy90cGbg3DTJIlR/6l4Mtent?=
 =?us-ascii?Q?J/wdSr59BL2gWZ7A8QTiiSz1erolzzWGx4U3lueAJQ9gmUF6ZX30FO+9gG9q?=
 =?us-ascii?Q?YwbYB+WDfRuimLtq9G45I6c2RTMWQdCelsMuhF+jgfuRLcHV/CF1aCo+A0cc?=
 =?us-ascii?Q?Mo+X7OZ+ETq+TZd1tjcmyiauzAppfERL3GA/Tdvx/6DGNIoUjb94gqAxOIQM?=
 =?us-ascii?Q?fQK4TMrd74nCinYfjQbStVBK2e5Of3P4dh1bAtJa6lMi9f0x44yMTiWBjHtJ?=
 =?us-ascii?Q?tKG8mgW+tJTmNAn0lJQwK6Xzo8elPQpFewJyvqn/lvaw9uFhYfqn6PziF95I?=
 =?us-ascii?Q?M2i6vIBFAZ5MCDrNLn9x75yFqzg8r8tFekOTh8bMMfggg392CBNOwdlZc+as?=
 =?us-ascii?Q?upeZKXwzvsrrq7CAFZets7mQQalI5xBWP0HD5ezu9x2fB3ctjyIYJ22yU1cC?=
 =?us-ascii?Q?C5TZKlimb7WvdlkAPdlPQFMmwkiXDX2mX6O6TCw9zwEuXBMo/uMyg5Sm+BIA?=
 =?us-ascii?Q?XDmB8B4FtX9Fd0sA7TYhK/1d0iH4/ZtTUBvXQwZDqgQ0Deq1fi1JeGlMzQss?=
 =?us-ascii?Q?MyZpGK/g5+itH2zySdTDyHtMAlBXRo/ggd4Z5Zxvm5Z/KJWrkbetz0qL5vd6?=
 =?us-ascii?Q?5dJbPhrMwq4+iz5/26uRLUYAoimxXPGABz9Ztzt8IYHXWYfhGdWEI74Tkmdb?=
 =?us-ascii?Q?Ffd6P095ZRI/ZErRUP6HxtRBTPj9fQDjOdxCZ3E2sAx8WMEVTP+WqbQGJtux?=
 =?us-ascii?Q?xR3sreYEhNAHgLWQObx7NuYJxpXXqS/MBANCWKqz3VViwOTPKB8Kr7LesAY7?=
 =?us-ascii?Q?rckrHOXudzbHbFGGdWdBTL9XOdYLx6C4vuPOVo7aLaOHRrV8fG7LZjI33xVa?=
 =?us-ascii?Q?4p1hjKrR1xahG7WT4CoDY7qckS+jPZMU7Ls81gRrKpC9t4CpFz6bHtJJ7pW3?=
 =?us-ascii?Q?Hhs5Ajc3trLjAYjvyKZR94agCoZSgGBNZin9e7AylqXwKyNmzLp9szLfLd3E?=
 =?us-ascii?Q?hJDsmCvnoYoGro5iS4dAUoBihURN4CbHyEdYIB6Q?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d582b14-2eec-4931-0aed-08dd19efa7be
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:25:25.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6P8WA14kIZCIgSLwBcExd+gCeRgcjZm+6mxkH/70kwgW4gDzNsI+pfe9zQoxmqYjDMxbGs5w1yZPm8ySZqBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-BESS-ID: 1733927130-110928-13346-2845-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobG5mZAVgZQ0MzYLNE0MdHSNN
	nA1DIpMdHCPNU4OdHMIjnNODENKKhUGwsAblmrlEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan9-233.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
absorb logic for not overwriting precise info into dsa_8021q_rcv()")
added support to let the DSA switch driver set source_port and
switch_id. tag_8021q's logic overrides the previously set source_port
and switch_id only if they are marked as "invalid" (-1). sja1105 and
vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
initialize those variables. That causes dsa_8021q_rcv() doesn't set
them, and they remain unassigned.

Initialize them as invalid to so dsa_8021q_rcv() can return with the
proper values.

Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
Cc: stable@vger.kernel.org
---
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 8e8b1bef6af6..11ea8cfd6266 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 				  struct net_device *netdev)
 {
-	int src_port, switch_id;
+	int src_port = -1, switch_id = -1;
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
-- 
2.43.0


