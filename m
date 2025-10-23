Return-Path: <stable+bounces-189052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D22BFF062
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 05:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 526054EC1B3
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 03:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36812BD013;
	Thu, 23 Oct 2025 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nGyk9e9q"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41813D2B2;
	Thu, 23 Oct 2025 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190455; cv=fail; b=LzXONL9cw/47fvBhUXSw7NBRkGAydeDQyeNL88T3TPDKXMbrx9VnQGsvR6nl80Wb0t/fDy6vZtqfKYeC+qJHAuCW0tUmIdY+VXGkYW8pid5sX3ZoP1qYrS8DOZ4CVhHJTasxzZrn63UlELHCBzCnDpggyFNasunWGiwI5XLXPtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190455; c=relaxed/simple;
	bh=lKaasXfSzzU/mAkS7I1Dq8aQUkoxIav1h6J3hgssB1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FdgWSOz26MJgBOBeohVvOJaYk8/E/IlbPRqhMaHc6bFpxs4BWa31uSXnHKDRKpGpNkA4TxNnuXyHGq0PJT4eA2Vr5s9uGWhBcgWhQVfFEiDAVp7wyQUFcH9VwuwbE7weEck95yrjjE3zCUmSShAtJ2U48dXo33vOxW2XCfHqwfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nGyk9e9q; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKmA6WBovhG/olPc3ka91q262XtrL6i21NA11KJxFKjBJxiANV8PmYGi8+dpsujqSkUMVMgEabRsacd5ty/VmYTYx0FDsMAuwJoQPhfRDUqAwMiZkk74+vcMkIQzKQXbtI/XQYHW2q3ilDagX0d0DV0mQm7B9bITFE6RZ2v7oJgyfaIuvdh4dfMWiGZda1MNi9f/FaLjgYw6zQt5UnVA1hbjiIOyPoNo2JqtED9xPp8cuYmQFhnyLGgjjWVWtMWflC05vDt65xG2KThPdJOahzVMCClAtLNVIGxsEbcF6l0+X/8NJ2eO93Ocsw4wJBdF8+DdiPKVrAHn7JUzhjCe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggPNp4EuR+acxkZM50RjJf1lfUdyHAHOWZwDaqcTK2w=;
 b=szETlM/44pLYqPwmw29MEVMUPqmirEvwUawhBlqWiBvAunzr2O3clgOIwEvH6UurtOB+iTLvIffHtfGcYDF/Dhc1RqhTttMm0KGoMesa24icp+UFzEP+QXSl5ActBUASP0mhzG7GskM9CTOVCvHnYf5anoOl7pDIf3IWo6rDWIan9T+Lq61PTS2uosO3pUUUZ+O/V1nL6dYq2sFbWB8kpwDIDPoK5I39uPGyNwZZc6wZYaw2WhfUKCfSL0mq0eSrwwX4GXTBRqoI5jxYeWI28w2cfblkoDAURNxbB5M1JikaPJhaYaQS5yGAoGq5VNBYmCAQetcHcR6mOhEtkt/HTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggPNp4EuR+acxkZM50RjJf1lfUdyHAHOWZwDaqcTK2w=;
 b=nGyk9e9qVod81SFa8hznDeWWfP1lKu8m6lBf8kP+Gh8DUT+hSzAFzRY9TcCzFIobnYiVPVMuA9yHoWVWD5pLNscon12dqu3wSW3NgaKq72yKXrhZaB5DSM2T60sOoPVDsyPg6h5BNGVwN6CEPgrDv6VvV5+A9q+2Hm/QeZwdEz7f57QLK1FyE46/fWTn77G/0oGig4oIhYnMykb1K73uUJmhPb/Br+FGCMf2Tp/AuVlQBHHxg/JLQ6JU4QZsG8HQJHWpbFk3Cl8oUClXpV1z8nExmHcL4fECDgytbHcfMlb6f2O0gmXlUF/lTdUXFM+FFvx/RrCUVwOEHcpVRwZmqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CO1PR03MB5811.namprd03.prod.outlook.com (2603:10b6:303:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 03:34:08 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9228.015; Thu, 23 Oct 2025
 03:34:08 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: cadence: fix DMA device NULL pointer dereference
Date: Thu, 23 Oct 2025 11:32:01 +0800
Message-Id: <20251023033201.2182-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0067.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::18) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CO1PR03MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 33398008-413a-4100-7a52-08de11e5060c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XD2en/RwqYukAeXqI5I39p/175R0Dej+gftGcmvi9yUbdprpsuPmGTyfb6oo?=
 =?us-ascii?Q?JdDrI6SjY7oT8sVny01Gh0uJ1c6u83slD2pYKHiSvGiu5l3QZw/04iDbc1BL?=
 =?us-ascii?Q?qkV4FP3JZ6Pxti3Ypo8n8XiRlOjG/l5Y79rm+U2XsrQR7sfO79M8lguUlVrs?=
 =?us-ascii?Q?yweVmM9YVzttXVVXKDDUSirwBSN0sww9DgAiN5qM7YkVdNr5ZzTpLZD0BRGK?=
 =?us-ascii?Q?ftPM/kjBiKoT1RVvTBpROJBj14kROrUO06iC4SIYYd9W6HJ5p4KqdFvvS2An?=
 =?us-ascii?Q?t1/4ILyMm+LjBjxdoGpUMQ4MIYqu09IBE4A8Me2NihBoo2LK6NtSTcuiJFN+?=
 =?us-ascii?Q?tlOiCjV6Z1yaVIhuNefS46HMDDzwgdpbPaZNwQu7AlQQ9HRHSxDRpqzFmLA+?=
 =?us-ascii?Q?6YuPBSsEbM9+jQjxvVJ/dMbNWhmjGACaeYYbnqY09+rVaEAfc7UTh3AvjadN?=
 =?us-ascii?Q?Hv2o/MkomPnCjXH0q5ooF2u5xcD0FUt5fuefXGZrX391zj1D3jZJ24JnXEOp?=
 =?us-ascii?Q?JOWAMEelmFwREl75FpxCrv5leI/BYA+0ixVvuuINBbxNIzAtW9rOESOpsO3j?=
 =?us-ascii?Q?VNiHqsiOMxNa/YH3TqKHTP4IrOgS7m8hi/qo9Mdl/76yGxFnqQ2m8Nr/BDNC?=
 =?us-ascii?Q?EXRh6GuMjsfsosBN6qMyC/FZkTdR4bckTFzvmEBKFgWdrrzcrEM4dBkfPBKX?=
 =?us-ascii?Q?ZHSgy3He4AFALdrtB3h9Bu0sDsGfhygo+zuuSETfpQpWYeqlg3+Q+UTvKSig?=
 =?us-ascii?Q?HS4RSmsdqBaG+I9TvINDulcr/TLSqPbe8AsjTBf7ocWa/c25eHqVeVSe8BOW?=
 =?us-ascii?Q?pJ2l0OelzAJRwANXLOTlccvxOIQcUrz1slMTBqC1VE62BNOJwccXw6hYlgWN?=
 =?us-ascii?Q?huhqD9nf3753EHhX45l4O9It4Ybth5lbeKNC8aCfeNkZNvf0ua0smIqaOCs/?=
 =?us-ascii?Q?c2KFaaXmIEq9jQLfxmUQWU417uy3Z78EP7PKUHB9mYUmHPxplrGTNZQAiUAP?=
 =?us-ascii?Q?mn3I13lDbLn5KOLbOgXAT9QeUW+8FDjaBnv/hvN0h/kCW7us7rJfkwEErir0?=
 =?us-ascii?Q?LgMDN+v+YqL+RZfN+rnzBNf9Kaf3j0dlL5mpGhNVNoglq0E457KZSyZpMCyf?=
 =?us-ascii?Q?rW1RauxjZn3hyQkuaqWuaROSM5Wmfv9c6SZsYIj4+FLcb20PoESQGlMj5Vb3?=
 =?us-ascii?Q?ZVzV/kyeljV1pKPfdkRXM2EDExOrdcBdh5lIZgGzFf2DiSQ12SueDpha2JJG?=
 =?us-ascii?Q?9Bm3As36dFK/pTNMpr1hsK8Xyl06H12+ZI08YF0OGJ2Csypye2Rp5ow9lBUu?=
 =?us-ascii?Q?ccgHLHaLB9GfTIg4r05gyyhwbe72FkACXQQgzK2EJuyS+0cSBwMuH3npcVZG?=
 =?us-ascii?Q?xkipUq/0f0N7pD9uKl5Y+Z0Kkb6DoN3clXXUpKf4x3pJ678Syu2mLT+hzRsc?=
 =?us-ascii?Q?TlraX0pRUdVmssIDLbOGdJ3IeThex8+u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+8ysbvZB0wOoL0wjpTdXS9d9dqQK1HhgxwSBU+hJaDvH8SPzf+1958v+bfW?=
 =?us-ascii?Q?Do1wPSHUCPaWGU06L7mhbYYWI5rPPYUQW0n4veyj70+IV83M06/yOfvyBJLo?=
 =?us-ascii?Q?PW5TeCAcMmDAfp2XfQ5gRIBWjLx8fbX95kcUbfYxRnDgmoqDIIu4ZJzf+5tS?=
 =?us-ascii?Q?ofivLHAcm2atLFt1Rf9KwXGP+PaYNiGNWo+ZELLcSibpqkemyiOYb0OJDSxf?=
 =?us-ascii?Q?KVJ64PhSbhhb0wVv6FRYTQ9oZZiq6FdyxjuixO3G07Yf7Y3/GJmyJORLeRwX?=
 =?us-ascii?Q?6TSRfYy2uFkdERtRWGMm7EftUEiJQ8hXbEIelp7B623LAtSDD8eo65m0riD5?=
 =?us-ascii?Q?kfiiP+QhL/lnfeEpjx6iO8MznWa7fXAkp1x2Iowqt7QJCWMgZdD11h7KxY6l?=
 =?us-ascii?Q?Kt2zfUrClOqRxgR3kLULCL5KzHDWJrMelfyUqFbT/H9Cqn2sHLzN0GiVy2nb?=
 =?us-ascii?Q?sIJ64Oc/z0/CLfwdsHup++FsqgP4GeBOIXkV6hv1ht3szzwW37PibO6iKKVu?=
 =?us-ascii?Q?yaIlZUr7ML85/FWmIM2tbmrDMnZUT7RLXUSqO/eFZwQaRFUuhROu2K50XO+5?=
 =?us-ascii?Q?PwzFXoRCrVCz/6lBYNn4gkChusb9hy7PFomElUykatYRNDpbe5+5jggwCKsb?=
 =?us-ascii?Q?CP4yCNsv2ySHWjh5z/34qozU+h4G9Ga1MPHUM5pKOMiSFhSWSYNfhzICVmuP?=
 =?us-ascii?Q?1sTrYQRAH7VNsJZ0TXplsmKkaMk3KNEPK4pzVIKm1UpQdjMn52tClsk/BKW+?=
 =?us-ascii?Q?83AcDWyriN5LR9uOWvqFRz4YV3xaCWizeT+ogSoGzYZP8IuiCf1Qe+Sj27hQ?=
 =?us-ascii?Q?Cf9+hCJPZ1MMiQAKHZ5cZodIOoDisCiUo+lFJbCPd3rUFts4Rj1UUHWiPDJs?=
 =?us-ascii?Q?1q+9dLXw9eYRkMgPj/GbtW2N8wPrR0csyZlE0BytKcEJS4NflwYyddQIdQs6?=
 =?us-ascii?Q?NrwiG2Wde4/Yfc+ZIjuU2WlomN8dM+jPus0/f3oUvvLiC7P+2tSrjII63UTx?=
 =?us-ascii?Q?qa8T6AEO3AuVl2A4r2neOjD+x3JykLIwrhd6YQVpYjyV/R5SXJTNjARtjGKZ?=
 =?us-ascii?Q?uQ9OtF7RhL1Pd1+q+wlohcniwgauaqcj9nq2I1q15rnAaHnZfvTTsngZfKFS?=
 =?us-ascii?Q?PenhX4tMtmwuhAnhZJSD41Wddk3qol6TUTCbsD2avLal0xPwRu3sy4fB23Iw?=
 =?us-ascii?Q?6R8W6XGnvj6AGrkcwStgtzTONJtCqv0PAktAvVIISlTxauHYcMZJtWUpvbg+?=
 =?us-ascii?Q?eSaJ+DErAeOYz8gd0pBDQGPHr23xGMGdU7Wldu3PEycm+x5QrevhbHsINfL7?=
 =?us-ascii?Q?TASNIFBjFQZ+bnNydSgFxdlMJtU/djfm6aFs7GKSxrVw91E3qH5bJkhlN8s9?=
 =?us-ascii?Q?Gvo+mDJDcvufdwlSpnLULT+Qc0aFmCrNB9l0TICCGW2+Co7XEpBHfN20Bey/?=
 =?us-ascii?Q?9JAzT5lcL6/w1KMggIMdXlvi2fT3tc9ba/vm0WkvugXFdRqFZek3BBkJT+UU?=
 =?us-ascii?Q?FItqwtSHcckJ+C5hUb7QjE6yJnG2GJs13JLdHGWzwyDY1pcja8OthO74vCHd?=
 =?us-ascii?Q?/GzCbOoh6pGKG1ZnYo06IqsiMFHRLhOe1Xi2xjw39v8O2/koghaptA6ddCFr?=
 =?us-ascii?Q?qDRzl2SnX6TjFhH9XJ0eFc8zaVVruxqORFEO4OWLYyLS?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33398008-413a-4100-7a52-08de11e5060c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 03:34:08.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1If7SCYS2beigGO2LiIOOcPNKysVl0A1fQd5wZJsvUxub65rqfEp8xHC86ZVb0gw13+EvDuKGu+LKwglfzAaexOSPx08fhdBK/sy6Xvg2BThOJQ8AOZFnFrLvdQqagm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5811

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

The DMA device pointer `dma_dev` was being dereferenced before ensuring
that `cdns_ctrl->dmac` is properly initialized.

Move the assignment of `dma_dev` after successfully acquiring the DMA
channel to ensure the pointer is valid before use.

Fixes: d76d22b5096c ("mtd: rawnand: cadence: use dma_map_resource for sdma address")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

This patch fixes below kernel Oops:
...
[    1.469661] cadence-nand-controller 10b80000.nand-controller: IRQ: nr 21
[    1.476591] Unable to handle kernel paging request at virtual address fffffffffffffff8
[    1.484493] Mem abort info:
[    1.487280]   ESR = 0x0000000096000004
[    1.491019]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.496318]   SET = 0, FnV = 0
[    1.499366]   EA = 0, S1PTW = 0
[    1.502499]   FSC = 0x04: level 0 translation fault
[    1.507363] Data abort info:
[    1.510237]   ISV = 0, ISS = 0x00000004
[    1.514062]   CM = 0, WnR = 0
[    1.517024] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000087a0a000
[    1.523706] [fffffffffffffff8] pgd=0000000000000000, p4d=0000000000000000
[    1.530490] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
...

 drivers/mtd/nand/raw/cadence-nand-controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 6667eea95597..32ed38b89394 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2871,7 +2871,7 @@ cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	dma_cap_mask_t mask;
-	struct dma_device *dma_dev = cdns_ctrl->dmac->device;
+	struct dma_device *dma_dev;
 	int ret;
 
 	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
@@ -2915,6 +2915,7 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		}
 	}
 
+	dma_dev = cdns_ctrl->dmac->device;
 	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
 						  cdns_ctrl->io.size,
 						  DMA_BIDIRECTIONAL, 0);
-- 
2.25.1


