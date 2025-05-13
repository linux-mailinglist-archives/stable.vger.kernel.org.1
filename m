Return-Path: <stable+bounces-144101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80EAB4AED
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E41B40C69
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC41E51E3;
	Tue, 13 May 2025 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="k8KXkrqW"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD851E5B9D
	for <stable@vger.kernel.org>; Tue, 13 May 2025 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113729; cv=fail; b=dIzM+IUME6xFmY2LheMz4rFt5zAliD/XBQB8bmE3I4v565OCVTNIamj4XAk0HUDVIjMfDwiJIV/NJHLYBBsE2TEUirmYXy/r3Sa93b5D4BNPnRI4y+6NACx4BDPuwmu00F+/Y2rPjDYLLUDMINN3LRJxtpvj4n1iiNHhCnEymqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113729; c=relaxed/simple;
	bh=jXnaf6Bdkv1ZPNSTkDGuiouLZl8vDAfuxsitC7V5znU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiVkm6YVJtz9ZWOECA9cq+ZsoOfRPokyIWutZMwruUcbH0hxavaLlC22eVOJ42HlpFS959YRlOyrAkkuxgCNa8bHEPed1GtiiXeF3OAXkB+/u69X+I6tPg1jKeILJOoRkoh9U7uCbSQ4yULgrBLshGra7lCdSVceRyzZPihlFZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=k8KXkrqW; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGooBS7iJqEg3uXFVrMIE3xgnx8fcyhRSAltjH9Qe3RRqEXekJFwSI0s0bcZVS4UqhEomNpS5j9EPUg0J/XSeuyaqTPiZx/5/4pfzh+vkid9rlkjBGHNJmnjfWjPF1SN/O0+gK+JeIU0JHJd4zEPfq8FGSO2WJ/NLBNb0HHb2dxqTu7JYwtH3WY4C4Js+fVkjM4hsXshDAAYdGUsrN9+h1EsC6MmTY+zBB/cCPOfLJZFHd55/p5cSgd5aj0htqqoH/6Dw5MFDgomLtFNqOyt7D20YLQUo6+Quk2lzBEcGW6Wa+LZmK2zW065l1I3WXkf8GHTK1GJFMNM+KE2ZNJoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLUo47scQI6NPciUYZoQX4bCuElSvH46Xoo19lnh18o=;
 b=iDPkeI54+F3DXCL+j0mHPRtO7xUN6AJs7sOM8ckyXI8MNhHXrIFr584r5GhGknst333nOqlq08qANZUfGDtVr+br35qmkeBZ5wId8U03/NiCB9tH315E0lyG4to6PX0kxiHFpOjA+4FKKOQJObaqpfXmdjY+rx1Epd2lwfobbdnL8vVF6uOgviLoKavqNTMozYKp8drs9MVhy8jQunnExIfqk21NwCzUI6xxImfxJ71Ny77WPccY4haEo3lRNptGieAixJX/BYPq5gy3rw+BwxTFwcE5XXGS4Z8zAhBy4UDfdieiQq/M81B9TLHvRFDrbRhdQqNRC4eA9pM5/BtkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLUo47scQI6NPciUYZoQX4bCuElSvH46Xoo19lnh18o=;
 b=k8KXkrqWcEDC1FGetfESiexNwmZc8Rrx0vbNvERPwbiQWV//dqVhtpPH41GW2eUGXtIZ8PskQCoi/kQchrRW1Z8ZvZcgNChz7Cvk+PfeVg7EAeFp7Scux+tWZdBgfLwV1Nv/3oeGL33jltnm6OiN4xTW+Sc5gmenz4sffj0YPHYaLqyZHK80+hkD2ZOfpAZkb3mBdhmddIbNGWM7kxp/tyT6XzSSFI0md95snpnuvEaZBFVQFWi4Fpjg5aCaq+OGtsFUdUl2GBk9my/ZkWi7CNeXOf2zr84Ka3jZuON7m6VNDb7qak0+evjugOEM2S5LYWdpnXh3fiH2g7uy4P/gxw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 05:22:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 05:22:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: gregkh@linuxfoundation.org
Cc: dmitry.torokhov@gmail.com,
	kernel.hias@eilert.tech,
	enopatch@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND 2/2] Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5
Date: Tue, 13 May 2025 05:19:50 +0000
Message-ID:
 <PN3PR01MB959722F0D276D1E717B69275B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A25E7A73E2034C4C07C0B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A25E7A73E2034C4C07C0B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250513052135.7997-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 432c7bfc-03f0-41d0-302a-08dd91de160e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|7092599006|8060799009|8022599003|15080799009|5072599009|1602099012|3412199025|4302099013|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19imop1R0cylpbu6qsptRRYhFTWQqAUuAV6rcnjuGQBiINO8lkdO/2umUxnl?=
 =?us-ascii?Q?2NTRHZSAO5rLPA4VODnUE0C6FMmcAg9VMice8elv9mOe3oJcWmbMlfL7EL4X?=
 =?us-ascii?Q?VaWary6bVtayIO06aimH7z3jpjndy5myBEWMkNVP9Yge7KbYQFyIL7hLCdqI?=
 =?us-ascii?Q?e9JO3sQ1CnqWcSY+/ujICTOonZvLlT75ErhpQY7+qY6mQmxMDb2gF/Zvd7LB?=
 =?us-ascii?Q?BTRiCzC3lcfABa6fLFN578VsKZbXv8z8hRQZjsGsJlH2gazoiUzb7e5cbEa/?=
 =?us-ascii?Q?/YbywJ8KTcRKGRN7rFIo3UfAMLl7VxLQHslIlPsEERNlDplb8wb4uZNtQ0RT?=
 =?us-ascii?Q?99rN6UdwwDSmo4k2TTRYdh2KKBQTYaum2jo/cLDvu0yhT69IxLlEiXPclwxY?=
 =?us-ascii?Q?ZlgXOCM+UTiSQq3ZAHumma84j/ubrIsKGIjr5g9J+hU5ni0fneYS83NfmmzL?=
 =?us-ascii?Q?drATNKfjmSUP5M+L8DzFp/kr8aYj5wdAhp3sJHcKcDEvrNfE4XbAQpEdLIFe?=
 =?us-ascii?Q?DfIEKPb/T6AfQrF9E1DhlaFbBuZLul9vlqtyvMB/oIuqGbH5URrMvbPgRV3U?=
 =?us-ascii?Q?EApcbEbOMvTiOupOBO35VuoaGK0FJMjkf1DJaLLzEQhE+9u5BiowUORRAfl1?=
 =?us-ascii?Q?34PGqJWFs/1l/GxboR98B2txW0Prgmhg3IpxtA8qseipFjkj5aeReZaf3t42?=
 =?us-ascii?Q?jZC6qf+Qx5J/t2wgh9MNMM11tfxzbBSLbOJtg190s01F61BfvCxWB3CSsCuA?=
 =?us-ascii?Q?Ux0YqCXQo1qnp4UYV3cXzv50a0JsgC7t6+liPwibvyxUXQDgUEMzbQxJPER+?=
 =?us-ascii?Q?AUYrVS7Us4uwG2u+V7Mpaw8U3H2+RkbSussjJQWk1owJx3bdbk8G9/kOYGrf?=
 =?us-ascii?Q?nyacyaBgq1DHbQPF09uuM30IqR+BphStbFlae+YraDA7dAjdf1YCgXeNMhjv?=
 =?us-ascii?Q?o2+J6vwFsilW1tXBdLuEzFX4l2kR9y0Ikw11C/ZFjdTj5SYSvmFY2ficdaeE?=
 =?us-ascii?Q?tqJO4btyHupxONNfMUnHMaC6ho0NQ5aDlIvdAPa33oEzInlpB5yc8mLjl6/S?=
 =?us-ascii?Q?p7cSKAWRmCoPMcOYYfUhyiZwO/230WpgR5hl+a2nF8PxSoKiMVSdahJYrSDt?=
 =?us-ascii?Q?9kKXnIfA1LLyI9QkPEYyVqsZ7hZmDQqCZZ7gZ+0gbMXrJdPamF9p781J1Xa6?=
 =?us-ascii?Q?5QvR+vZ0I4lcMF2QCVh0h39YquPIFEKC/KBJhHgfrT3f/LMYXhHAAo5SnC6F?=
 =?us-ascii?Q?pUlmp8/cUu72HtHnr+rDzQodXhsmmT1o8FVEgEDpMDlbemFvyTx7rHtXD22E?=
 =?us-ascii?Q?eYOg/mP1atnPvfwT5D7fPfFC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jq9wvrfdXYnvbP1yb9lih1pKZHqRviiOcRqir3PfeereIc2eBTjhy2sCWakp?=
 =?us-ascii?Q?U+lGMh56ETGFovu6JD+vYIVNq7Jaw8nVenTnTzGWxUSn/YqF56OtdJu1uMMY?=
 =?us-ascii?Q?1/euWtWGpvi/CAk3ozOHdSuB3U9oX6ZcUySB75lBZ9DI+O+/j8kSz5yJMTz3?=
 =?us-ascii?Q?5Huzf+gqx7Yo9SF6atTYpiBfXPhbHMiAiK9venIvhk76nsYVLpEVzJMGGLzN?=
 =?us-ascii?Q?9QB49lR7qfST3JrqRORIJRxs8pWkIjz/Cs17o9RmiQXFVFGz3d38l7AtQLlM?=
 =?us-ascii?Q?NaO5ork8wbzjC1722TsfieF0w6sdXpG4d0rgdA31GMD7s9smo0YYxrQn6dKK?=
 =?us-ascii?Q?1ajAQqxKwN3FPgxmUWGBr8zD7B2ZGOMZ5f6j7nkiSZN6GG+L1sjgOeS9+bmM?=
 =?us-ascii?Q?o6e/VhlMFsZdEkrVBdPNm+2BL4ADbswlnP7m5pbx2o7VVNchRKOsTcevhztC?=
 =?us-ascii?Q?PQPBj3jwgEEtH/TDbMmRK2bpisw8vaCIWtCIH15gbIzNeoLvvMb//CsYtYId?=
 =?us-ascii?Q?4Gydc/f2BlgIevcdAU9Asohe9slckTU7mZIotzYxltqcN/UW4wK3SQMuhjk0?=
 =?us-ascii?Q?vr8HVbC93H0AcA7co53/N+kt1uehCMdBOpCNnjPuQDudUCAyw0WVwD2f8tOj?=
 =?us-ascii?Q?HpvjNS8/loPznholqcT3iHbDnTipPqfdmqgAaGIzo2Q+GWXHvIAnpYkwQuYi?=
 =?us-ascii?Q?EXvtQohcqh0FZaq5titKI5g54OSeSwlHN6SN4Wz3T81szhllv0bjCVdH1EwG?=
 =?us-ascii?Q?svmI4q3W1b5VL2t05bYdN+thRFL2lnJBr7BHoxqycZXpeFIerS56k/uteJx1?=
 =?us-ascii?Q?6+36urVIBVaXpQRsQwDpOtk6VrLVyTl/dwT4xaaiiBKYE7mtoV+p+dLNol8x?=
 =?us-ascii?Q?Cr0oObprmujNQXyZYN9cn0LuXB0scfb3O+wBKfBucWJNtbFPo8pdNfnMjCjO?=
 =?us-ascii?Q?DLOF4Joz+AQEw8w8d2fHB6or3sb0Xc2wlmAXu0LqUchpIhRE+V2UyAUNdCua?=
 =?us-ascii?Q?XMFQd4oVF0Sr5pJyMKTm5389mxfmvSc4voL/3A+0rsNGH9OL2V0aJBi0111j?=
 =?us-ascii?Q?dese0dqIxtT9G5bZYqRwO+luAB6/c5oWHrbIYHvxu0g3s7A+SKmj60tBLBRy?=
 =?us-ascii?Q?7/GWnbXI58JQKusQFA50bsPfMHUMhCUPcIU8Kn7qoZlXAmHlDtpp/kB9JZoO?=
 =?us-ascii?Q?J2H4piHe4PkuM49WZ8ZFqtkG1IbX/GkXtRD4371vRM0INetpKvPxYo1xlLE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c7bfc-03f0-41d0-302a-08dd91de160e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 05:22:00.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10258

commit 2abc698ac77314e0de5b33a6d96a39c5159d88e4 upstream.

Enable InterTouch mode on TUXEDO InfinityBook Pro 14 v5 by adding
"SYN1221" to the list of SMBus-enabled variants.

Add support for InterTouch on SYN1221 by adding it to the list of
SMBus-enabled variants.

Reported-by: Matthias Eilert <kernel.hias@eilert.tech>
Tested-by: Matthias Eilert <kernel.hias@eilert.tech>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Link: https://lore.kernel.org/r/PN3PR01MB9597C033C4BC20EE2A0C4543B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b1adc0f3d..c0d6b262c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -185,6 +185,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
-- 
2.49.0


