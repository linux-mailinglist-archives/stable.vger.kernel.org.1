Return-Path: <stable+bounces-253472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAJmJKDEDmqzCAYAu9opvQ
	(envelope-from <stable+bounces-253472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:38:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC335A13D5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98ADF300BC71
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E035504D;
	Thu, 21 May 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mgUIjAjS"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50434BA53;
	Thu, 21 May 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352249; cv=fail; b=M1Yxsn4ywkZ9zb8ItudyYU/FjeC3nH5I47lJuTkEZkA0cyVZ9Ceu6lMBsvFH5UOx3Hgm/Xe86PeWsh+PhEEQ++KOGPcc1ihxBty2HK5gV1X7TK4uHMQjM5/4tInKmlQwNGuNKGNOBCHY9Jqqv12k/dtcS7CPJpqhbMBeY+gHNIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352249; c=relaxed/simple;
	bh=Y7dMkksMHgm7qTS87ddTE9+r83PMDqER+6yrPX/IdAw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NBb58fhMIHwZ/bg6D+0oVai4uIQx+hRBkbGo7QRyDBraMTI0G3FBIv8Nm4yUO4eULKLCyqWW2+dtJje7ZglEdDzvOD68fqBCyeBJlqoRzhxMAdgZ4uAE0NBJN+s/xd3ZvaITra5oekkU5NO+rVKjps+bq8ib65uZ8QLNLhQ4rxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mgUIjAjS; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwq0EbIzz4aQol6DWYNGrES2+wprhix8g1VkYNl6EUMqMetQQVtz5vbAKwnWVeQjoU8U67gNyaIOKWWI88Tup6fkkB8xpPlVZFFhSV64C9iIF3Cn/PeOslqKn2lVfTDiUXmV7seic5GxHJA7W1izYLzQB/sqXooD1Ldspw1cMDBi3HMXD8zSY2hq3CsUyGb8EAf18fOuQIGfkp+nmqO35+fZ5f3bJSLctSCZaOGedbfuG1euALLB+4Dm05uEAzRi5YEM7J8ulb+Low2SaD3jJG9Cu1aafgokRhhhvtUWbG+w9dybZzfBrnY8/je+gb+Mrx4ORVLIkN8kxo0SWSPa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XrCqenEtrWmJXzl142QM0SgsgE2/jHCz5mRFJ2Lr14=;
 b=Zg4W2+E8cvmmxHW42ihFCdWIIuCI/DjN/6ubM3yL6gdxwvm6N78iF0cMgmCp/dO8Bg4cFdGsA9Yc81tLzPhZFYjw0DizUvOzTa/78CHtLgAIovSlDG/7+AAnT1plMRjcWSCZ0Q//IpVonf+yYGAdC0rLj92qA9jMvDWJBSDm0FUMJvd4GcS1KBT6aEV1MKIzUktQOvpysEZnu9072EiZZcDFGb8thv23gHrRyWRxPQAYC2A+Y4wk8zYiX70W6in5uxzomwMrFGbSN2gna1riwNt1UBpdlxMEIsXVeRi0+xxrGvkD2fHYmSiTzwJ2pwTU7+wQJHNT2UD/kwJUE+UNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XrCqenEtrWmJXzl142QM0SgsgE2/jHCz5mRFJ2Lr14=;
 b=mgUIjAjSneXVchdbTFBV4hJn4AP1ryYyCqnpwES4F4oEdmPVBWqeu/9eaHqRgFOPdtBDzPV78dl4NxDHloIK9EsKbn7NTqyH21vbuYRiXlmrj3zGCrzQtk5LdGz+CQNM1pHrxmRaG5tHHLyPjCmrbajXZuR4CuI7agCGgTWecH8Qw9IRU43TqPl9KGFU0/gvmbCSjIxeL/JgUWWOB2yF2/mAnXlB+u9qUt5b40ro1uWWzQ4zWdOuKqkE6glQtNqD2AcLBMdUENxNksQXHz4KHngHNvO4+3OoGj5RLfNChjI1mo2CW82SdPwRaGoWN7+guxde4YGs/iYzGyX/cpRI/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 08:30:44 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 08:30:44 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	haibo.chen@nxp.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] i2c: imx: mark I2C adapter when hardware is powered down
Date: Thu, 21 May 2026 16:32:50 +0800
Message-ID: <20260521083250.2972328-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: c68b6e29-0f47-48a5-4aa7-08deb7134049
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ypy3nIOduYISLVqg+ZuweOIeobv3MW1u3+MC9QJ8iMTwimI8P8oSlqpKv0tlYbpV5+50b8Q7KR/yB2ErdeOoC8l2fmZVnlstoMbUTlIW63j/KfUc1KHD9a6TzOc0uxroILUb9T9jOk0mEL/G53A/CpRZ8AzghCfiw6YuGSyGdwWCKoMRyoVN6sW3c+9HxTRHrdpBnoKXU3tzUzQ0nqmj9dFhYYfbMSZdUlbU+DqEk6M7sUgTQ2LY4KTmyNwN+H1tl1mG9Vm8G/HUwQyIUInG+zossYW9YposvgMAPeqWiKOb5zYIAz6/pnQC2765bVNWRfStq3dEOOxDIQ7rVMbqbWNgIlvZxTVssmeEt9R/ZKpfCd8H4ErvAcWeFeyyN1BXnxw9fGEwEcQW0X0Kb73g/c14z80s81hlROoopFMzrL2u6zD7m19aTt5B38Fe4sCAS2gyFsos7rGOi3u78s+V6d/iuUbiFXLPMR84+3jIgTQGcD7EBq/d5ZY6Hdeqp0Suk7estSNkzIbR7lJSeNqLyWEBeTOIXd8ZBU7kVICip7e/LIGpN3gTX+hlZyc1vJMujVtkjCyBlRqzKTD61xSI8OtCR8xDY+oY8rwrsxIM3fj5OnmOi1M0rwdanioe7gFCO+bhEwCfTlG4oGn8No5rcJI9FmJoXX+A+Wn9AGqc9HV//jsHO6bQ2Y3ZSsZizGr7osBzZU4no6TiD7S2dD/uBEcONhAY0dGltNNPKHJa6sD+P/1P7SsK9U/OL9Yc+PHD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QL22qdnaNeWpwNl3N+3P8fnRj6Ix8U8QKtHY7zKmT0js2CAd0+VxVha1G/SN?=
 =?us-ascii?Q?JUShOYkgRoJP83aUEojjlOVILPdVI9Jm2nHmHinZGO6Ig04kKoplTil9c5dj?=
 =?us-ascii?Q?TSzXL7jYpLSlDOpMj3Pl79aPWZUEbC/JjEeRkEvzRiKR63fsX+bqtL4y4grm?=
 =?us-ascii?Q?6Loi3uBSlBIq3zUKgk2/cnwBv4egj9Hi2Ry/l/wB8L8bAG5KTWrlTV7kic+Y?=
 =?us-ascii?Q?Gq6tYGyqTB2x8NDcUoJ90cWqachqvmubI1sgC35MYcpVEoGuguL0Q4/Uz6Md?=
 =?us-ascii?Q?jC7zp3cVP1in7ijeK/24lp3UUU5yNaYKUS14xL4aPcrKBKfpkSzrreWX98LG?=
 =?us-ascii?Q?uid7xg43bMjuD5xidCueqHuvMaTMUeZ9cxlX/Odap8E4gG2eDP9LZOsXFAFX?=
 =?us-ascii?Q?+o/2LfA7S0BxkHSivffnj06zC6QuMkSKlYeDgr4Iy/sLtUbiMbu40UlKg4NY?=
 =?us-ascii?Q?6tYRDAHe3kmeitsJv53g6Tibo7QQGTCzoB0nLYkWIMi/2gIMNWvLypqdEhJD?=
 =?us-ascii?Q?3FdyzKdCU3Nz1zeiAx1euspCTmzoX8p4l/PfNIIMn2zyx1d9aezMjt6jGJMi?=
 =?us-ascii?Q?qdeMAL3AJ9aI21a1NBCcg2Q5UMnk5kSni+nKsPCeFYWWYuu5HIDC6UJBJeDm?=
 =?us-ascii?Q?FJ0zx+0rB6Pv5yB9NKvsh8uspapiYUwOIObWiLLNVP+dViKRNLddaWCIWUHR?=
 =?us-ascii?Q?WDjXWWluIQvt3UuOJhjoFviJkz+53e4gEr1PAtEo428cywW/ypJ2F0r7zeo+?=
 =?us-ascii?Q?bHEQZwgCs/aGEpH3dLHid9/yHSA0WQ+nRgdtLoJyTn/8K5twhxOayGFdzr9m?=
 =?us-ascii?Q?BwCn5+xhZxTQJc5l0Pwc205Umlfb4uQr9HSnqVj30ayhiS/V0/wCEDWcxa3k?=
 =?us-ascii?Q?YUP4Fpz/4YAYLlEZaRR2ZIUFlS1GK9E13c9/6HyNaVTtADCS1Zm3gzNHWDBO?=
 =?us-ascii?Q?1E3uuLmd3qzvDakpeHmWdZMCi58qVt+eKSAx0l5uCg0OY8awFJbxN0Beoqpd?=
 =?us-ascii?Q?hInjEYmAABbloRRfd79Umy3JwVKigYiysg+dSoVMqwv9LYz3OES9IrPloG5m?=
 =?us-ascii?Q?KahU5+OTCpyEUSBn3bcTqTIz3V4xejzo5WohZfu5e7/ny6x3yP1PMdzMXwLb?=
 =?us-ascii?Q?BQ9jdKFn5e/d7GnMFwiZdRv9R38v/cz4CJn8xw13Zth3dobQjMQz9ZlgbCyK?=
 =?us-ascii?Q?Qp6yUChTqbAuaS7J2+1/sDf04n7fS9eq3UQb7aq1OGF2noAxsFihxEAocKa8?=
 =?us-ascii?Q?n6Icd9vQfvVpwbYOYI56XYsAiUUoPM7LnlD5pu917WygSLlXfzLPJMCw+DY9?=
 =?us-ascii?Q?VFbKPn93Vs9Yw+I0auQDW0dR69H5mhhUW8lkNjFfsnkaP1U3bltSoMOqiBpf?=
 =?us-ascii?Q?E2zz/JY1olsTgTsN0ZdwmlTwMUsnGkN5XxVXpYvLULyDX/pJ3UsXc39YERVH?=
 =?us-ascii?Q?N3Pp6gf/toTeysylEaHQcEEZV+y2RNVATNKBgN0fO98pbB+c66iRh0yH2ckm?=
 =?us-ascii?Q?t4EL0vQz4UtbMHa+D2F81bqUVnjZ9xuUkeoRvsWh7zxmPEdQ6Lk6+OUhc7a4?=
 =?us-ascii?Q?eHKfWwWrvFJDliFkMQ2xbWzfHfAGLANdyhk+SYYlxaDai6iPiaXImlvHNp7l?=
 =?us-ascii?Q?By210vG+NvobU7yONTdGMDuQTytZ9EimHOojVsHooPjaSmRLhrHc8AYnaDJ3?=
 =?us-ascii?Q?HB1JB0Y3X1ifMMP1nNA8PyIKSbvC1Yn8DWDjvY39RzgU6LNFeJevJV0krgno?=
 =?us-ascii?Q?Iz9AawW8dw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68b6e29-0f47-48a5-4aa7-08deb7134049
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:30:44.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdKbtWYjNr5FP4Yv/PcBqMF7qG4h8YKcJZx+0+IjY+rYg2rmHF5O6XqA/meqyQlK7VXByGx+79k/SdQVipjBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253472-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 9AC335A13D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v4:
  - Restore hrtimer when pm_runtime_force_suspend failed when slave mode
    enabled.
Change for v3:
  - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
    safe suspend in i2c slave mode.
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx.c | 45 ++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..73317ddd5f02 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1922,6 +1922,47 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&i2c_imx->adapter);
+
+	/*
+	 * Cancel the slave timer before powering down to prevent
+	 * i2c_imx_slave_timeout() from accessing hardware registers
+	 * while the clock is disabled.
+	 */
+	hrtimer_cancel(&i2c_imx->slave_timer);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&i2c_imx->adapter);
+		if (i2c_imx->slave) {
+			hrtimer_forward_now(&i2c_imx->slave_timer, I2C_IMX_CHECK_DELAY);
+			hrtimer_restart(&i2c_imx->slave_timer);
+		}
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_resumed(&i2c_imx->adapter);
+
+	return 0;
+}
+
 static int i2c_imx_suspend(struct device *dev)
 {
 	/*
@@ -1955,8 +1996,8 @@ static int i2c_imx_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops i2c_imx_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				  pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
+				  i2c_imx_resume_noirq)
 	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
 	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
 };
-- 
2.43.0


