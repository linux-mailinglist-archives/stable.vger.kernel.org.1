Return-Path: <stable+bounces-179689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33181B58F57
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EE01BC4379
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF032E974E;
	Tue, 16 Sep 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="jf6QV1Kx"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2127.outbound.protection.outlook.com [40.107.95.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1823507B
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008375; cv=fail; b=ppp1MR/mEhjaEnG0fsWOOF+6UatkG/1TPzjubLIjoLLr+8EX0Ign5kP5RFPnF7r4eB0DRjSTnAfwgVjQ7wCexoJZA78iCWuYTkXbat1mTtNjV0hwp5SZ8m4wBvnsyJ7lHzWCkmp0w6FDkotSSbi4/ZF5OansPfmav8v8p5LqHmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008375; c=relaxed/simple;
	bh=usZ6cIyPQ8B9xUrCrVBkgETMAd1Vn8HHur8N+Uw1Jbg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tc1GpD1zFqmMvHzgXcHWQ3kIWBAoL2L6btyANaMslhuXycPF9FCkixluslooDgzynhvKbyVDRvdKG+ucLGxljXqcVtbOKtt9C7zlp13sXTDCeknK+HO5lNeS7CxLOMpwYeBfozNie6o30Iph6f8w5jsi8hN7w+HRueBgHXsYTrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=jf6QV1Kx; arc=fail smtp.client-ip=40.107.95.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmxi8DMeR1u3DZZGDAqO99CRB9e1V/IOLKFXgO5EI53mfgqYqKP2HzeJlQJrjiEApJbEyZsjo/LIV0QDxdjJ+1YhRgKmkhI1PFrJxwMQ0ucP/lLL/3OIQ8u6JRKgmyzQRA6GbGsnir0CbZjsIn95cCTTSVZ0jnHe6iuPfJuDE97fqUP4ImRfhwxJ3BeTkGWl6CLbGfy1hlE9rtkLL0xiQrx2QxmZtn5eb5QjseD0TBbz+hpnL+qhRF4X3Qkccf01prisDJVXpwIm7Xc7YbG+X1UqYjzcGqDf6wm0ZExS5wRCyPQ4idmsqY/1tBCntCUPl9U9nzsr4R6kNYKq7YDyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgI7qK9PWJJ8FHN/WuWrnwzuRYIchhyaF+IcVtt0eZs=;
 b=DZYUcqi9MBTkNRZTzrQzTkq0KNDpASkVqjiKUVwjvmdmnjb9bnSjCAHBZxEmRheql4jd+Td25ixbCE66qO2xRIpd75ZR+NSmofJCrmIc2smKxLXvP2M5ta3KxHIrskkVHwoaKJEPRVctmw5WcjG6UVDc1uGcj0XzxzQCNsEntoY4PmjaXZdsoTts09i9z2FSsH2wA6G/9zb1h/fC7uhvZlWz87fcSw4gdqadTQ7Fzcc7Mks0CR61kfSvBDwrJswhBRq5DGtcVHmFjXHIOYz47TAUHGqKPwurzKu0Py2/lMDfRcwLixS2lvh/TfsQnn3yk6qA1Q+0lJXCAhb3CLXjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgI7qK9PWJJ8FHN/WuWrnwzuRYIchhyaF+IcVtt0eZs=;
 b=jf6QV1KxEJzscWUwy6x5sgIzFHJa3kOFOUxvwcTA6qhmA+PDXapYSb47f3864gu3XYV69e0ayOmeTC+Hxa5XNBQ11NLf2+amGaox5ZtiUrXzcOPxpjyZtfWETon/noL6kVKT3mZsT/dhQDSof0+8DKx3A7qjL25vaqntNkunjjqeyJGWVDPLFhmrskNIR1ZkGeHeraY/Jf5q7R2gaIxhcWRwX3yr8t5W8KwOR1P4wL80PkgDmlAD9Ce6GvyuTtMI0ID3gtLu33DSjGjV5V01uHw1CDZST5Twsb+VDHXpp7x8lilf35GROyMAei4L/62L51Fq+Fi8lFjG7ScpMnmcjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from MN2PR18MB2605.namprd18.prod.outlook.com (2603:10b6:208:106::33)
 by DM4PR18MB4160.namprd18.prod.outlook.com (2603:10b6:5:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 07:39:30 +0000
Received: from MN2PR18MB2605.namprd18.prod.outlook.com
 ([fe80::e620:d653:8268:5542]) by MN2PR18MB2605.namprd18.prod.outlook.com
 ([fe80::e620:d653:8268:5542%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:39:30 +0000
From: PetarStepanvoic <axiado-2557@axiado.com>
To: stepanovicpetar@gmail.com
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Petar Stepanovic <axiado-2557@axiado.com>
Subject: [PATCH] net: usb: asix_devices: add phy_mask for ax88772 mdio bus
Date: Tue, 16 Sep 2025 00:39:05 -0700
Message-Id: <20250916073905.253979-1-axiado-2557@axiado.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To MN2PR18MB2605.namprd18.prod.outlook.com
 (2603:10b6:208:106::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR18MB2605:EE_|DM4PR18MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae8123-c1f1-4de2-c549-08ddf4f42b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60rC00qrNoPwrNrYoQm1aWETE2SL3+Y1U4XJu4F13E6+sG+QveMMnujI+5v0?=
 =?us-ascii?Q?hZIUCO+3OI9uPE2IrJhMbwYFmAAzc/z8j27biQLC4+6Qs+QDvwK/qHRLqPYy?=
 =?us-ascii?Q?NODY/0W2fCku6ChFCTxRiG/yuRJQksPvTJiN6ebpJXMhwCzA/h1egftFBmVF?=
 =?us-ascii?Q?q9LgJ4rTDCWUxpE6xVWm1amlrV0Vm3ile5wZuq+lD7TYLcQp7hid1qgq2yC5?=
 =?us-ascii?Q?TYLzYLYYnnN+dKT7TJqdZFxlWC4KeRApbpSc3M8+8Ta9NdQ9nEXp+yPGQuum?=
 =?us-ascii?Q?Cgwz0yuou3Rnrtdj0bojb/c1t/eTAwQhV10zLSFqNqApka0okXGXFSaFgCy5?=
 =?us-ascii?Q?9a8cnVg32z6ob6jr1ofpOorV1eGNN/9Oh/Y/O40Q37BJqh4JKv3XReyVA9fp?=
 =?us-ascii?Q?PH2r9vNcd392ZCnHoMAyQ6qEl6FTIq39QMLz7yYvND0rUS4Ds6tLEyi5/URn?=
 =?us-ascii?Q?mDH/m4YVCz5IQUcjhORkcbbRhlbc9alkHpjN/XMEIxonjseSA5HuYkCu4j1K?=
 =?us-ascii?Q?/oSf5pVMDcWK2QQZgbvd93h8owY0dXyxvhBGoeXf7IhWWvUKNu2284VrW+yO?=
 =?us-ascii?Q?G3o6/Ur/e1W/dPe9VMFvlBRp8zJgbsub6ZIaPvft3Ix7RjM474cOPj95nE9o?=
 =?us-ascii?Q?58BJkrbuSNH/BrZIDJWGE/M43AIArmZN1MphuMfVdCarj52/rKTumK1464NC?=
 =?us-ascii?Q?2yFW+zZvBOPqORdejVwe86oVSFCjjiXGYbPGiemVyD9qy1WkTtm4Js8Ch3Se?=
 =?us-ascii?Q?vTFufYOyush040Bu2Lrt6eN5S7NdFHy+Ob5ff4mi9gsmHnevukrnf7ZqzWNu?=
 =?us-ascii?Q?lugLfiC6uQHCgEQ967ddynijdD4iy/tPf4CyEFCCSELwf3YHBtn5pFuSX/Kq?=
 =?us-ascii?Q?TCFK1lLmzI72tCqIx6QwTllXw6BWhWsY6myDwMKT5hj6nJOTKBmZ5rUFQxTU?=
 =?us-ascii?Q?gPtknK2szJqvmUDrdW3XA6O9VNvWnrDzwshNixrSGXSCF0eeG/hl38Rg/Ph0?=
 =?us-ascii?Q?R1Dr6kJWFocLoTWy4rato0wnBnm6uHOTS0iR2//YOP86/BuELoix4rmH/tXe?=
 =?us-ascii?Q?QjNVKTeqb4HTMXDkaIwR/MwPrGmWXb8M/yslj7V2776+X8Tyh0ZTNjbbsyRn?=
 =?us-ascii?Q?Qe84ts2s7G6mygfbXr1s/6ExmPPxOp1SeM68ed4PowhP8NanyplAmT7H1P1j?=
 =?us-ascii?Q?ZQlAlPT67QcFbdVhZO2LMnLwrFho62gByKrMSNoSWxo1VJHVQX2rQrpJqvPT?=
 =?us-ascii?Q?E4+oaZ6cbq7WZZ+o6Gw4I1C+pdE3rGCefZD3j9XkQqDBNAfLJ3qx9cc+3ElP?=
 =?us-ascii?Q?L7AWxJGY28BA2QOD5G2CHqm6tmvbwCbAO6H8Gx9MYKuJoWxM+N6MhK6lpYGt?=
 =?us-ascii?Q?08M08cCpn0uByMeSvjCEZBpwdq0MT162U0cf2O24iy8D+tKGpdl2kL0GD6EF?=
 =?us-ascii?Q?TFCyGWIbEFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2605.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONzivZv43mhDiZHsG+p7d5sy2qYi5nbUPMRKziAmbzm4Xr6txPV6kkx53pQC?=
 =?us-ascii?Q?1PK+WdRJXjyckvJ4CjH85pljdBH/lnQbBSvDlWiHz1M0r8Tu4rPXmGDKuuOj?=
 =?us-ascii?Q?kBUG9rOQZRZHMD21AqW4nw1Rj2f3oj9I6iAqhnAwB/LTiXD7+FthHHfDTfBu?=
 =?us-ascii?Q?777myxiVnGHsJyqKXGiAMinShAVmIlSDp3EK2M7rrniy9FOgair55iP13XfS?=
 =?us-ascii?Q?0rI7tTRQEJekEXqYlBupEuMkfuQXCVtuhHVBYAHoohJsBmRYC/Zq/NR10obB?=
 =?us-ascii?Q?dJA0c5m6kh8O2TNfPNys26joD7cxrhUipINDAJX/trdxsjl+haplGhcGq7ah?=
 =?us-ascii?Q?dfJ/OeRrz37HH3V7sauP2rYpL1TrNi0r3ZLshT4HGx88dDdkCBJzOWMkm4+F?=
 =?us-ascii?Q?AE4jYdNPdsfbkZKMgAqDMimqwlbYRIzEzw09irE3fENWARILe3zhvV59VZXq?=
 =?us-ascii?Q?oV0icfj0cNYqib6yv4VKwRLs1US2ZIrGsY5t4jzZ2FxdehlNQxPQQcVLPCLk?=
 =?us-ascii?Q?+G46oFzeCBYEq/RdTSkJhBC7kUOmYlooGibN0pmGPLzsoaTNuz94CtkmAAyq?=
 =?us-ascii?Q?AsvKUbNXNBQ1HDHMd5a8pNlwgYNG5ab4TOsWPxV64jctVca+Gub80Qz79fnx?=
 =?us-ascii?Q?stXQXeup5iaWjJXqi5MqkENaZmqyj0NV5V25PkWN/pW9YWUJmE3TEiDNSQQn?=
 =?us-ascii?Q?R41QayJCO+Ef9bkdzwxQbnQYZKQLKH6mzaimZICFbzl5/ucplIbxaG5BRPCt?=
 =?us-ascii?Q?eqivuI2t8a5AktEI9ohOfcny0/H8epHKcWF/RQdUm01tENId8iz9yP+MitsR?=
 =?us-ascii?Q?KxddEubdIbDITIRhptag+WdJWcZWMbZEgu0qmM5dLgXkKF3v0zNUL4sxi9CT?=
 =?us-ascii?Q?1wv9UW+zOlSf+EcJItFJib4Bz3xww4YIufaEE+wSf3bhaZqO+7XfydTNJM46?=
 =?us-ascii?Q?UTnBStJ2WNET5Ek/eiMTP9AagwU6ilZk/3NSDygIq0M9JdPn19fhN2paXmIf?=
 =?us-ascii?Q?AIzYXrBHUbZ8PZxy1h8Ud6Xo51C7xtlwlPBkvcdp1c4IJ8leO1vEZwPKU5mQ?=
 =?us-ascii?Q?kigGacLOL4fMMkcf9c0Kj7tM+LMvTyzRl3Kn4RMeaAoiWnErGVQ/c4xKr1gh?=
 =?us-ascii?Q?otxm0JKegxXUDtRao3+QkKyKmR/2uTPRiD3loP0t8xxaB+HlALocYsjzDr0E?=
 =?us-ascii?Q?cPnTupRgxysB4CClAIsoHwKB/QsMR/TEc/ZH3NGLZvf2CW5JMFLdLL3v+S1W?=
 =?us-ascii?Q?RrqK3DJpvnNhENAJkiAhdUxSe4jgO9TBYyxRtGkEegpO9/+nUdSnPCjQ3MPw?=
 =?us-ascii?Q?aVDDN676al4IkdCeOGrhCHjAyFp2DwdJV8a2s3L+3kvCrgjmArkVCvPgSUxy?=
 =?us-ascii?Q?2BE/8rDMSjR/k8OjbB6Us8AXeZPnBcII1gF2R/7lnXi7ljWew9+faejpUjdT?=
 =?us-ascii?Q?o+ficDkaIqFcGiARMbonb1AZFu83VYuJ07uwArLs04fg/beNruMy5iakOnR4?=
 =?us-ascii?Q?8TbuXU+O4L3HtWlepjZMED1LmgHxoFjyTSJUkEcmpX/PsNTKKhgX3fUl2+Xo?=
 =?us-ascii?Q?LN6VYaPT2msxnUznA1dQXNrUzsVqi9dfHz7i2CmKThWepvsulKDW6z0V6ddC?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae8123-c1f1-4de2-c549-08ddf4f42b75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB2605.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:39:30.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDPoJPgMIxqr7wXgMjv8JsqfAcTIAOY29NNBD52e/8pmHV3zvJ1TQeSzBXWAzJWqSU6SKZ0IiMPaS6FxJ7IueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4160

From: Xu Yang <xu.yang_2@nxp.com>

Without setting phy_mask for ax88772 mdio bus, current driver may create
at most 32 mdio phy devices with phy address range from 0x00 ~ 0x1f.
DLink DUB-E100 H/W Ver B1 is such a device. However, only one main phy
device will bind to net phy driver. This is creating issue during system
suspend/resume since phy_polling_mode() in phy_state_machine() will
directly deference member of phydev->drv for non-main phy devices. Then
NULL pointer dereference issue will occur. Due to only external phy or
internal phy is necessary, add phy_mask for ax88772 mdio bus to workarnoud
the issue.

Closes: https://lore.kernel.org/netdev/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250811092931.860333-1-xu.yang_2@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Petar Stepanovic <axiado-2557@axiado.com>
---
 drivers/net/usb/asix_devices.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9b0318fb50b5..d9f5942ccc44 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
-- 
2.25.1


