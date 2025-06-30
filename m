Return-Path: <stable+bounces-158923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4AAED9C6
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F31E3A8436
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FA246BAF;
	Mon, 30 Jun 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EyiCFW90"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D123D28D
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279165; cv=fail; b=UEr1ueBKQ9T3+/zpADPpA5EGIvL9rFIVQuh+4k4XfDH7cx50qyk/24PZ4RxHd9LlE6zWoPSf/HBG6R1IgJIbTjOL4JFwN3rgzyLYwVl5tUjaGVIquYAcxoqVrUMuU49LwOfTuR1FNNEuGpQwflbQiTY3FzEmbUNaacCylvWZfF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279165; c=relaxed/simple;
	bh=YeHsIXer9m0Wzikg5H+j7WJyeZkTG3F6SXu7vy5ofxI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNLvwMnF4yJ8R70QlDfxvt3K/RNmPs4g2rbsazc2Zf40Hq5x/opHPzOUrqIWRCYYodxSW5Wvj8jwQFuQnULgeBKKzCMfannPGQeqFsha0EXsPjrGlZpz54rsA0x8hYbExM5AUeTeYPWFivbJ/P/m+JhVao0HJrw/afW2QIg4hVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EyiCFW90; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL9tMEUsuE5SNMa/JD5RlJXlDmFw6gUv3ySQI0T9fUqhOHbQrs0Wrjr9v4p9exL9nzlQP+g7s0pSY0lfKT6vTbS9JehvRc0YgVVB9yyrbzJZTtNWtSDnoH2HdbwopPs1LV3ni7USgHX1zfJwxBbjPcHbEkxnZSaaQiO8EkcatR4CgvrrzUzbyyOroZZRiFGjKKwrXEgZgmhCTwYlY2EZjDCAu9hJivNDaLGm9UGHqh3OrFNr15JwaTXPJ2ng5aM+UWPoyODhi6AX4QbAtiA0PIVAxuZyei0oXJjo+jprL8D5ocDbv5GgvKiTos9qaHsfQuQHFvrSq1PUdpdJRN4TKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2MDhG8DpdKESgALwoaSOZ/85ticawG5rW0WTniz+uE=;
 b=cFMxA6V1EGHFKd9Fy55LEaJRBaXVu/AUJlgweTPxEeypGbNVnaFZPgpohZ732S97dmhb8g33cxDBC4ap9mTBx4eZVuho9o/TQxMhuQe1Sa0/3EvrRAy3M56KGPaQxy2+8UERvdBiCGOIs1ig6SpYCXU+KUTAKSS0UIOBT16PrP5o0Ojqq6vC1Kn4aclajJ7QnWBP9gbWZ6KVcj8EbALf6T7ntzEqoBkl74eb349U19NRl2acLeHKxhlgfq5U2TL+FSnlbo2WMskdvdBYINvKI/ZcI7pbfJYO7H71Y0UzLWnLoAZ2NQH72eFnCQdJr+PPv5paN3ErBG6CtqWrw6tqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2MDhG8DpdKESgALwoaSOZ/85ticawG5rW0WTniz+uE=;
 b=EyiCFW90b/hpJsGaaIB6wDHPcbR8TDNwIh53MnjoZmZqxm+QrvAE8mo4OgK/NWsknJq93o6oDR6wninaOaf+/cRa/SeRKP3Pswou0iu4L60ZSTfO/F9xfU4ha99I1W+u7NTuAHxkD+i52tpYVMT6mkgSy14sJm84JFEi2BeQi5ZE8e/tbwOwsrnWlrLMxkUVxzbFe9uU1yBNwNoroc35CwwnMTNQGGzbyhSSd5MFOtUi7/Tx5J0JbPw/udF87wT9XboG/U8ymi4pm8O5mub++u95sWNFP49I2cegmMSF42fLu43ltLa10ossE4u/WGXE8KyouDz/7unncgk1gtVj8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by MN6PR03MB7550.namprd03.prod.outlook.com (2603:10b6:208:4f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 10:25:59 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 10:25:59 +0000
From: khairul.anuar.romli@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Date: Mon, 30 Jun 2025 18:25:55 +0800
Message-Id: <20250630102555.16552-1-khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <2025063006-expose-blandness-ffd5@gregkh>
References: <2025063006-expose-blandness-ffd5@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|MN6PR03MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0a7a3a-031a-483d-9e17-08ddb7c0815e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHuQij1ybUVwRht1zWn6UpUYHxleEMJqKyrU6t/qSdscOm24qMFxkAfrCgpi?=
 =?us-ascii?Q?ok/MixDDbFGebSTk3NrKCsGcuZvkU1OuewckZP6SZqGHaoF3vEkaOBfkevLS?=
 =?us-ascii?Q?UvzewuKU1qLc1wBHY6q03LaA59VOe86fJGmz1hnWaQZLoRpsY3nxVIpz52Q5?=
 =?us-ascii?Q?jxmutTEBBjmoDUglHc2B4EIk1I/nN95X/sqMsuUb2rJQ6wZBFe2CQjVvrGJ8?=
 =?us-ascii?Q?EStBRBfTcC9PnIdRjPq3RlD3/+AUOtWzzNmPU3JKUQuR/6w7o4golJT3JG6s?=
 =?us-ascii?Q?7pAt/ALFQiCx5uKtBBYbxo3Az8ym4DT3PAzp1deEsFgWezbmep10h7sD0h6M?=
 =?us-ascii?Q?YxFMqwmYf1hTLh1yg++o68pE8j+cY0SKeZ8fg+2ExWpeitwej+1myVy9DqbM?=
 =?us-ascii?Q?ogf/gs2VQVKEnrzt5zTak+Qy9N6Qxa48/BU6TacJvm3kcoUo6oBp/HZzuqz0?=
 =?us-ascii?Q?R6BjY7X3GvutQrS0g5Soxb29BTUkJYW48ybHDAFmcHcN3rUYujJc9Jt/B7DX?=
 =?us-ascii?Q?By+jgfICICRSvgYz7UITfhNogJ2ILDI1qFFnMuJ8GYYt+8HDKUolPFyoutMM?=
 =?us-ascii?Q?wivkE643kOdVgs+Cm4JdoTwx4shaHTNDNqW6dWWpVafmdfkIoZlmmcM1cPjt?=
 =?us-ascii?Q?o88xjbfprco7nGUFEdSyUKChUXjAOYmPqXH3blThYRq/NO6Kd6R/esuslPPs?=
 =?us-ascii?Q?Xn6E1l2mSTV8rcQhw+1fJg9XryBOKl8lgT89NsY7GwVMkDuqDmTe8CxtQEWR?=
 =?us-ascii?Q?O0WMerMxZuoHlJ4KVN6ULWPc44Z8BJM7ZgW9mU9JBQOZE4Cv3FYfFqjkaXP3?=
 =?us-ascii?Q?WG1MRQSIMMDaMJJXCCkeUkv3hPWAXd/J6akBkq2hlr76yqOqEFQcf2qOV+lJ?=
 =?us-ascii?Q?4d5Ppr0FYA8XOP99YgoMHPDETYLEeW/xEugknnXy+5AN1SoY1//Z4XZeXxfR?=
 =?us-ascii?Q?wIXnuNE2TskkCoJvHe7JnxPnOUcXznIfhjiJW6C1NfbzbxyK8uzr0dDl2Oox?=
 =?us-ascii?Q?tD/bX1eLV/VoHGS0yyJ9pwWl+9oQVpWvzL8quDCNiU+tCd+O73DG03QhS2sn?=
 =?us-ascii?Q?JqRodN5xTCUSFSMKSNAlN/6PmEDp2941K0Dl7M0gInxpcypuB6+Wt3UGm3Zv?=
 =?us-ascii?Q?gu5MxgHUkskuC3ZuTO8bQV7BNxzdVod3KgB3ZswnDzAAh64ybPuTeuMB5wWP?=
 =?us-ascii?Q?t28Y9HGx3TsluBpb6BxUlVAF83A5bY43CCH6ZfQvkgE0BF1ywtg2N60JuzVb?=
 =?us-ascii?Q?9ULoYpPPoNo7bhYB1Uh/N9i5PfqDZeSlH9k7l5LVY+CeS1KzdDwI4Gt7mSEV?=
 =?us-ascii?Q?rOxJAu4iEy3alDpCQLtqAZ5Y2m+hEDKSNbGiA/aJADUIjaClnI5BD2o0W8AV?=
 =?us-ascii?Q?m34sZLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFj+H0hA9Q6mw/RtvjMm8O2F7XozLR6pjXjLN5/XJr/U3YEE1ITmjYsk67le?=
 =?us-ascii?Q?pCpOrh/NjR8+6dwp/TcsJGpN9FCPwecTVi7VVJV0YG1n2kf2TjQ6PglxluIC?=
 =?us-ascii?Q?GQ8McBeov5Y+Sfjl9cMZ13vIx3nCFjs3a1Ju0uv9yEdezJZ0rgpXqEc9a6kx?=
 =?us-ascii?Q?TyIWGnV2o48nSu0ewSrYoz4/GlXoJjlxjTT6tTGYSphOhFGjTZn7HPwU5rQM?=
 =?us-ascii?Q?7MoZMv9++8F+c+EqZDs12iJaeT80vxzD+CTVDxe3FWkeVTYRZHNdSbmc/gXM?=
 =?us-ascii?Q?BJ795G6twJ66jYeUcr6M3+GxfqZuOQGD6EW4uFHzZk7iCzk4dQBjumcYgfOG?=
 =?us-ascii?Q?63evgwwvIzmjTsqGxYdcB+RBQ7CtJvSDqviiAPYhY0NMXLk4qNFmsrGU/pL/?=
 =?us-ascii?Q?PAwD9wGIDGAm2zlU7jAP6Wz9GTbLSmo0gB7og/dUYGwyzqR+Eb7BgBl7X40C?=
 =?us-ascii?Q?MrLsGPecB51nGHTYZ+TVaRe9OhlhDAdj/uK4mgu2JmRtvs0Vr2MBcfd5zBts?=
 =?us-ascii?Q?+LR9VXjyS6g7tQRi3g6kW3oIjFuUMqE9o9bj5T88QvtsCRdS23to8cai5kN1?=
 =?us-ascii?Q?d90osNaorYomUC0TgAa8wDkOcWSDl/mK7EiAC2EtIZ82qVZ4yx9r2C2sHvQz?=
 =?us-ascii?Q?e/83wyRr5XTgrEtUMKh6qxvtUfK+wYNaXhf71gNUg5lkLTGrvq63RSUoiemY?=
 =?us-ascii?Q?tftO0z3KXvZat/d+obUoA4CQtAvEz47+rxAbO9OVN6acDlpI3ltt9aPf75ty?=
 =?us-ascii?Q?1A0nxgYfLAttdZ1MY9g9CeS0r5ws4van8x8RDIt42+TSg7VGpcIrgbc0M9/t?=
 =?us-ascii?Q?G6AX2qGCwAFR94H8djEMMFCo53VXgCrPrvRZCqMhHH9VXGO0iQB6MYiDbZas?=
 =?us-ascii?Q?WfGLmRRcVgS3+w909VtN0lT1ySaMFFNGM2CV5uGfwKhwz4setq0WVao5MxM4?=
 =?us-ascii?Q?fswbSNj6mQ9xK3P125s+peEUyXcsVFJHCGJ3ZiVOFS2wlxeb8ABy2OqsWJsR?=
 =?us-ascii?Q?ML4hOQQJvAmh6j5EfXCrusTEGbhfd0eAIS/vYo/khu9yp2dfMy3g/iHfnCJg?=
 =?us-ascii?Q?/9s7kPjtSjpVt6SLfXO30lURQuZ6P/Ad27ri+GqW6uXL63qVIKy/fga2uY2a?=
 =?us-ascii?Q?UzSpaUfE1kEgLd5vKS4N62wPQlEprwNpzTBkoP/ddfVE/JuNClnfZWtGEwub?=
 =?us-ascii?Q?C8+DTfQSFpyDTyow8UhzqoM+38eEShVBFh41WXPGbLVEei/Fo53UwHxZwkFz?=
 =?us-ascii?Q?sQfpgH4E20a7et/bxXUJzQjEtl3jgc3Xu4a9HWzzJ6P2BUS+hjOHIbm/xNup?=
 =?us-ascii?Q?2ZXGru07aqxhXQXCQNoM6HFtLei8HYX4pw7aZuNeyxRrThBb7aEqNCw21iQ0?=
 =?us-ascii?Q?9P9QDQpropd6eBPNrv99lVt8LOakBa+UXFklHBs+gH/yw0PYOGLZGQ4xF9GI?=
 =?us-ascii?Q?BCSKly7QgKfBltyx3UMbhM9/3GvkTy50rjyCdbOPCANqz+p8SshQw6UB+DcN?=
 =?us-ascii?Q?OsMmYBz4XLj7fWujKCbS0b6LQiBVkB7LsUthWwREt2UPa+jt2pah8xflPm+p?=
 =?us-ascii?Q?/Nw3w7jN33JoVjlLCjKspvKoGX2wI8VOwEYM170MoR8omsC4DWNZ7xM0t0lM?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0a7a3a-031a-483d-9e17-08ddb7c0815e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 10:25:59.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsIA3m3/r5dL8XwAgL3ZHCpTw369E56UH4lN9tdoz0WYzeq84+wiZ1oQo/PgH4ndojpkoPnZvl/1bfFC6noxR50Ny5nQudp0byslDPIIb1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7550

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Having PM put sync in remove function is causing PM underflow during
remove operation. This is caused by the function, runtime_pm_get_sync,
not being called anywhere during the op. Ensure that calls to
pm_runtime_enable()/pm_runtime_disable() and
pm_runtime_get_sync()/pm_runtime_put_sync() match.

echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
[   49.644256] Deleting MTD partitions on "108d2000.spi.0":
[   49.649575] Deleting u-boot MTD partition
[   49.684087] Deleting root MTD partition
[   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!

Continuous bind/unbind will result in an "Unbalanced pm_runtime_enable" error.
Subsequent unbind attempts will return a "No such device" error, while bind
attempts will return a "Resource temporarily unavailable" error.

[   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
[  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1

Also, change clk_disable_unprepare() to clk_disable() since continuous
bind and unbind operations will trigger a warning indicating that the clock is
already unprepared.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Link: https://patch.msgid.link/4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit b07f349d1864abe29436f45e3047da2bdd476462)
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index bf9b816637d0..9285a683324f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1868,6 +1868,13 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
+	pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
+		goto probe_setup_failed;
+	}
+
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
@@ -1877,6 +1884,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1898,7 +1906,8 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.35.3


