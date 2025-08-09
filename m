Return-Path: <stable+bounces-166900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA9B1F1CD
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 03:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C49727ED0
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ADD24729A;
	Sat,  9 Aug 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="hB+iJ0h7"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020097.outbound.protection.outlook.com [52.101.84.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198726AC3
	for <stable@vger.kernel.org>; Sat,  9 Aug 2025 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754701533; cv=fail; b=kWOqUMlfGFLSCiwZxuDEB9M/4G1WvKQZuFQokh1GAyRHKCccIR7BSRb2lqq3Usp7pOUAMjJH2Nx+N5LiAK8QfemEhJas+kg3XCeJVekl6yjUIVPzaVv7WhDNtXpDJ2njz4jz8Jft44/CWABHepV8uz3MUDNaXUhxpMOzDyU5W+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754701533; c=relaxed/simple;
	bh=2YIhKBJ3doDQTaVyjfw5yYYzqlCagh4mxu3zOdX+Z3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eh6F5eOf7tFi7PNFVO+fpXsV/xocl/yIh4iCu86RIu/Xezn3Fo0i/vKY4VTC87wv4cX3LHVuXG2QA3a+mMMzKafPAiHlwYsqjO3Fi06O2dAVHCwgQ8A4ZmyPKxbJMydIbGgpHq8I8S7eufTsgkmrf9H/uDUwjRBpp54SFeYud+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=hB+iJ0h7; arc=fail smtp.client-ip=52.101.84.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juxk6YraWyHL7DbhSUu2lQFeiisu38EZwBEUP5QQY3DDwT6VJiW9iFTdUbxl96yubEEIkc38XSEc5J0pC6LcWz/izWBeJJiiHzyPVhsFy6ZL5twtfn7Rbu9pDXa1ifVvfIRCe7+blEr9G8Kbh2Ega1+qte6JCYxyv/e33WLI9timlhWNHIMLh7Wbq9jRX91+pRxHtf/1Jb+UgvhS5y2J0YXOgGFqnFX10P/Ol8Fi2aSamovU9nhrUX3f8Z7plzBcQvXypN1ySnseWA/HwQfWaMLB6lD/5+JLXpa+Oz1w6v1h1OwnSj+AoT2geYIynHCuKl2Sq3HrfLUVFjuSPcwMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1wUx/a0jn9m5CKUkwGSW63CS507JM2FkMcG2DTeb0A=;
 b=HAIf+1Qfa6pcTpph6zWZ9G94B+hGR1CkrJNHmROWmiJDmlc4/aso0x0uKfAmiViLk5O0TeSssxMG0V0qfSv2LrGvwBwGuWE3T9DgwxmLk7aY8irKrLFHUNhSan+czQhMF1eJRR1W4lJNZpDAu3YmVIvPp8HfNm+LmSrG788koNIKS1Qos4F5raW1tF4QaQ/zIB1yX6HGBstssOA57VOzL3L7bdLdAbOaK22BsH2t4GlunumfSVdzzwzZ4M1OTDsCE0mbe2u0JWMqcKj/EAHMmcxLJ8xgI0UGZzQEkos/NcZ4kCjNumFtx3s53COrDj+wHNSEo3GFRUwmjrY64hp/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1wUx/a0jn9m5CKUkwGSW63CS507JM2FkMcG2DTeb0A=;
 b=hB+iJ0h7Zs7Um7sVbMXXAHZk2uBBuWGgxED6stpJ6+j0Sg/LK3ndu1Icwsxls5Fc1uRYbNm4fv7/4d88ejCzmbmFPftuKghizGTz0FjqV01kVBDsjFG8akgIyX6QjxpKyFvgJioopJbEGTPrUoajT2axLNUdEx0Ykhg2p650K9KRT4CQIVuCpd4QJd+K/IH82iw3sOlp7dLsheuBgCJh6cGpUBeemC33RX/I6P8PLkLvaF+5QTTvmN07115f313rlKkF8xaTN8oTU5dFOlzQo5IxIlWOX9V7isKfrc+mJRhfT1FRYQeWzd6Nh8/38tdnzhVMGo1C2DW9AV1M77jHaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Alexander Dahl <ada@thorsis.com>,
	u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Gabor Juhos <j4g8y7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 19/24] mtd: spinand: propagate spinand_wait() errors from spinand_write_page()
Date: Sat,  9 Aug 2025 04:04:51 +0300
Message-ID: <20250809010457.3125925-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: ae98965a-6de4-4403-ed7a-08ddd6e0d4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NhhpuTUkYSPpRJ5HmO5yavFWO84HXB6Pp2Sfxp0KBEm/wnboFXVFh7qPd2rx?=
 =?us-ascii?Q?7g9RdN9LDAXSbGz1SC4C7CpWfmr6o9diUXXzE5cDpONeh5l9SyDMV3bPf2IK?=
 =?us-ascii?Q?pJXWDMZ5gsK5MA2LTxRUkDTvSRkgz3mEnAD98ks92fJE/x9x3wq9xpyegkM2?=
 =?us-ascii?Q?rjvw0JOI+mG5igBghnSQ972qBN8s/HSiAMzpDROrEHxlejM9vITtv4+9uESt?=
 =?us-ascii?Q?fxNSnFYP8WHoM49Gkr/c5KX/iF5z90OOsMcbTlF7dmaLMjXztI+GP5dLMTe2?=
 =?us-ascii?Q?dKetpeaQG5rn25Q1bRvp73vWBXtaerDpdQ7aHrYx+5YvUmD8xoRhSrneqoe4?=
 =?us-ascii?Q?vudaVUsw7KZDiKVWCsbxk2p2WwRhOGc9ABc6dT5IDl1x0h5Ok3glbXpKA5ne?=
 =?us-ascii?Q?lDQ5Z5AJ6F4iQuG+KFmm8PuouDC+G7HSFNNxEzXyuErxr3Y3QlZ3yVSKp4tf?=
 =?us-ascii?Q?EUfKWS8vtLI4LHwVtXbmvhA4FCZMlBR7Nc0/xxf/FkRBsIM5Knus8w4MAgop?=
 =?us-ascii?Q?q95sotwRiMz4oAw0YoWmFU4f1SE4bI+KW7nPvJOQfooybbNstDD7EkCBD0py?=
 =?us-ascii?Q?i3ABEylgtW7IOv6VMoyH2/BHtThMkcyZ+Hk3zN6/EyGDiibi2oewfohy8cYW?=
 =?us-ascii?Q?/Vd/ZKKssA6YDtnlpyhlELrlRbX5WffOSRxtBq3+pQhkWXwA5PHTrrtZS6qj?=
 =?us-ascii?Q?8+n0oMCDizjpPUrXo7aqe5CpZTbYDxOJnqt72n5aLoy98zbgJZtVIITdtyq7?=
 =?us-ascii?Q?uWHfCyyCCRE3WqzgPAKX8ezua/aW5BP+bSGG3jRN3NWUnJ4kSDGF1rqe4R4D?=
 =?us-ascii?Q?zWXI8wydhyoSXqe37ZjeAZuJbaoruSUOBWuoGRt6tF7opdqFt6a58xcjjBAZ?=
 =?us-ascii?Q?0xEU95wjaxFvcS69U3hKV5qPf3Aq0f2NH44phCtjaYCSQ++BOo0heREIliNg?=
 =?us-ascii?Q?A7V5sK0FI+9VoUv3L2L2aiGwY081L9RMM+pDMTMT199HbsjIDLzH7qJq6P4C?=
 =?us-ascii?Q?+1R/4da+DIYsOYWAPGtSZ3uoGc+oPLT3xu4UXi6zGDBTSEi3WtpkicwYZ2l0?=
 =?us-ascii?Q?DzT/7DlkJ3AyM1/ZyjXmyrGHUzGa333swYl1NewWy0BfarXETz2c44UjcB0h?=
 =?us-ascii?Q?Sp7OqwVHMh5I/Txf9IvNrnqYMDUz9UZAcA9BQHq2MlS9umvzVRWaov+5uES2?=
 =?us-ascii?Q?ATRArofzoEw+60dFhXRL40gK4ppynlnynAyOOpz2c7Yi7/XP/DKr6Md0O+q3?=
 =?us-ascii?Q?sNBz4N8fwrRfkSElhhNGicrg8HWTSBejKykjfsqkgdfqs8+R48cmguVR9ZUQ?=
 =?us-ascii?Q?qg3axjA2IxmIAwaVsvBTf5cnpitvBEQ6vKbGA9+GGFWv/EPsM+Yoezttr1CB?=
 =?us-ascii?Q?X57gLjIjRSOrleNp+o6i4HH36E7VlvvWRtEfHztIbzzUDcrfrjT1pZgtaEo9?=
 =?us-ascii?Q?SS0A4oob5rAZ+QBlgkoQpJal/UpcbTrCHP4u4l9CRophNn5+tZcqyAyfVwym?=
 =?us-ascii?Q?90BvuGj0H/XkI1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GglbQxWfAxKYhFNSMWw2kFHLxCgO8DVwtY8aXgol7lFxRX9k8p8QLBQ3Ue8u?=
 =?us-ascii?Q?itF+z7xqYYIr0oKtsQN7QDYO/5gKzVkY4ke7WVAO9Al0kWlqYZgGu68up5Nv?=
 =?us-ascii?Q?Tol+aOAju8MGVc3dU899PGbXBf5uqRHnAd8fHLrwl/wl9W1ITaiiibtVe+0T?=
 =?us-ascii?Q?RKOT8z5RfEZgMPxdVLBx328KDhXMypG9tu2DK3aB9oxooNTHq7MtmVcRqRi1?=
 =?us-ascii?Q?Qy+ZjTwVWtzNhZPgj1H5B/KVg5piCkJbHQwNAVBPrFBu+/bSYa5zSPNbccVJ?=
 =?us-ascii?Q?kPjaZJE4poxV4b1HglcE7W75R0rJeNMfu21hMSHyo2ln26/4aKJR05ealVJQ?=
 =?us-ascii?Q?ii9Z4EhTpNXrNA1wmrTMKyd66zEI3ugtZujAInwqSVJyStyW0hC3CaReGRP0?=
 =?us-ascii?Q?rfucObLPrXtfnEHrMSEQDCBhkY4i07O38x9hUuhc7KHQx1PrM5OAMRbWzzfK?=
 =?us-ascii?Q?aL3C3+Pyijx/1D5tYzfwCzTF4Ryn9g+GI6Ez7Vf/PLRiuWMqn3E/kCvCwsiq?=
 =?us-ascii?Q?UAzM18jKA5syyWmb8X79Dl+0fYvD1TCd40yJ5SxeGMrsCY4JnhCl9V37QKQ9?=
 =?us-ascii?Q?gzQOq4iaqFO8g0e1SaJicbIlcpEKmgM1z3uCqlrFzBg2F7HFvh/moU2FVKrI?=
 =?us-ascii?Q?1RZ0AQBQEcpHZg7jIBWv8CnPA6V28PCQ7gIiwW9N3IvSZjGIIyzrsKHRTWIs?=
 =?us-ascii?Q?RhY0MW/EXOQMAhlpGBR3jsUkAzxTRw/FSmFclHxL5jRd3cMPxERttqM7vUIU?=
 =?us-ascii?Q?lpXZ2k1QsOYKm5BF560Njf/+qGbIDKoXMTr9Zwsv9K9DMpy+3Lo/X00oADNC?=
 =?us-ascii?Q?xJUlGEw+C6w/havqfmJN6n9ROnULt6CerAQ09ImEScNpyM+aEFp4i/ASH3ai?=
 =?us-ascii?Q?23YGSllGROemrlR690CQ4KFgxB+Gj0yfAYfsRYwigbtnvrAORVHARwFlgCLd?=
 =?us-ascii?Q?WzY2Jb6tSOEAZJcUZDXSnBCCcBmpT44cgW2owx8HqxWAlS5foa777lisbN3l?=
 =?us-ascii?Q?IxNK+1bD36ZGLrkQM8ZNhdDBuufDJkWQvVUciPV1VliDqVo6ZXj9ErsZDfUw?=
 =?us-ascii?Q?SLsq2hawFVarDBc7a6Mt0+DfEfwIu3EuUwzbu1ULhQbUoQCWwSxDycrbHQXz?=
 =?us-ascii?Q?TlWmIQNGyV5NkVYK69O7ZzRQDGivi2wz12RhesyKTyThNbISfuZ8CvC7fKH8?=
 =?us-ascii?Q?hdGRll5ya1fzuwlngG5UDPdmTSD4+XXnh8P3UyYG1UESqPq9CTi2dGgCdJj7?=
 =?us-ascii?Q?pPLeTENauRl+Ey0JaieWCHJlcypuaPbQ8fsANL4eAqp8ThCRlkNyQpppDTKh?=
 =?us-ascii?Q?RIJo1QbtzBMt44psjAmSz4V6mjWzSZwn6Z6taYF5kmuF0RrCSxzvKfAeTyL4?=
 =?us-ascii?Q?Bbey8WKq1KMGPnV6oF/QbQ6btjLxx8sayYLSmN5qivVxjIEBZyuvEgRinKOf?=
 =?us-ascii?Q?1kgCujxMRi/FZHOf4BSjbxNooT2LclBoeHfVy2CqNlRQu5AShTKupD0ETB9C?=
 =?us-ascii?Q?SUV9CfzwYjTWziu6uGv16QMTBhUbLhKI5FxudZ1HentNGcBGwpF2bcip2Cwz?=
 =?us-ascii?Q?ETbo1b7jjwmdeERCty8jubxXfsJmN+A2G5c1UL/kOHMZqhFIJUjFXI2k+DF2?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98965a-6de4-4403-ed7a-08ddd6e0d4f4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:29.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: env6rCzG9oOYcKp9ETq8sIQbMl7jElPcdP2gVSfqIa5k9Lg1c1Ymj+deQlAoD0vCtyhUcpnzM9E1TuIn+zCPWwgtvxpZxH2Y+nubhkfLCmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582

From: Gabor Juhos <j4g8y7@gmail.com>

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

Cc: stable@vger.kernel.org
Fixes: 3d1f08b032dc ("mtd: spinand: Use the external ECC engine logic")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..3e21a06dd0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
-- 
2.47.2


