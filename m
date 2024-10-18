Return-Path: <stable+bounces-86825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971C9A3F13
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAF8287025
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15924206E;
	Fri, 18 Oct 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="ZooNiBRs"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061F1CD2B
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256559; cv=fail; b=OBlihvl3DSdSWeTwuFAKLOUqdCGVn0ZkObxpJnid+blIT0vgl/Pqi+gh/IM/zHcp569RBABFhcuh5KjF2kGASvG8RmLdBWmkix2xof6XM9ofrJgcW3cJ8qdev2qH9ljbhyBarPV/5NfXQEHstEZimLqgy1ZNCgGP6h2vaS3mC08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256559; c=relaxed/simple;
	bh=X/KTw6KYNYRrVs6pCTSofN14KClRrXUDuZs+c1MKBg8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y8Tjrdt6yBIcBhvDzOvxt9i5hfjnTb0C7qAQEeLZ3k56R5aNZmk1xG6gaeZ228i5S9caniTiykzHXXYzSkLItkDPUtWoyVJKdMv38w3A+BbJI12N6kWUYbUhXL6e0I8L3gWG+ipz5NNX0AV5cPzNyH1VEZvJDiPnLR+20TQwyjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=ZooNiBRs; arc=fail smtp.client-ip=40.107.22.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv1aBRGP/Wu2efJnXQd022QGENIYBk+37J7LmBSL4UPXdHMRklnCA2Vjeonok5ksMb36kYAUZH6Y2T1a2nku7VwYgpvVAVRTJAwe24BS0/nbrQHPe+vvVM0zwhHvtwB3OgpAmYwvdkmiPDhSVY3+JS09F0QgGAgbItsBHhnFsr2W6jdCuvwwzMq0vZjWvgD+fII8vQSx+dBUjHE88SptfFnCSRpghZLYibInvndQHFT8hkN+uLOw+0BvhCsRRKGETRRzK7uPlRyEIH2TMta3L25WPpjyQ0UZzPr39uXIA0Dd38UTizf4ZI0b56qWkg8BKUCoxInYaeeApeRXuopAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4IBkMott2H7UUhrVdA4DueX2CSb6726Z8Z2WBs1eJE=;
 b=u2K9PsHEfEIRbqGNma8HKVtI1w3q9PcDKeypkLt2Bvzw6KI+36gCmZiUp4JJz2NF59J3oom3FuFekCvGJmJy5oCziH8o7Fh2BqaaAnDjesG/oIgdChzK4Xx5XUMr8I412BvsrRRFUY/X4AqR6fSrjuDsBmkLN1RkRVphx/eprQsiqQUrVPpVwqBcIkA24UfLTNlh5fLg6o9num79a+Ofrs6WapvWWNesZd0lHClFA9fkDj2CF7STVz+ZZ+cgSGa19OI6oSYAmEwkX6aGCBpqMM5fvneoC7d+acUimSkEoRzfhJ4GmOM5T0ZPEHXd0uRyYeUQx0MLGWoel6sM5jQCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4IBkMott2H7UUhrVdA4DueX2CSb6726Z8Z2WBs1eJE=;
 b=ZooNiBRsnnVxcF76eDyCMwjUzXJ0Fmac8pm1pm9jLLcxi8sW0CfBi6cpRBFNBPBTchoPHR6N8ZacCqmaiQnrP5m60kbiaq765eEFgGO1DuS3APavwyAVvOCx0h3dZHU59FKMSBavQ57xq1iYTkwvS/Lci1JczFBiiPz5BhF2HqJbV8hwTCCV+P5xXXAL/o0p9PXFNjvQfhIj+pyKvQ8kvEyh0byvmBgwsdrqiOIzAPKN8LYol9yURRWWY8iISqQJnxmQZCBO6mWcKeU4Qd5h/U6ishbleZTQE2N+uhf6Ylrz+d9iPaRZ1zwmMMkYG8M1mb8D6PsYLkjWorIns6PtWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2069.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 13:02:31 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:02:30 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19] net: dsa: mv88e6xxx: Fix out-of-bound access
Date: Fri, 18 Oct 2024 15:02:07 +0200
Message-ID: <20241018130207.6507-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::23) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2069:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea61128-674e-4762-4a03-08dcef751fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqcSb0Xr3go03MmF/6yNncbcALptq4wGHR9tSA4AHaoj+oLCJXHPiK4hcK+t?=
 =?us-ascii?Q?uvQEUd4em7xaELsFNvHNrgPYakSmCmIqAai430DFZA9ZlqYsrgyXWDD9cPpj?=
 =?us-ascii?Q?sJYytxBhgCUdVBBe9ss4EHbCzMhibl6nMUgjhBMrBJvsEC77Onq8JmDFYRVU?=
 =?us-ascii?Q?hAay0YEQ7Q85eZeyfLb8LpX8Ph20jYV9LT1CTMl7E4RQYizAlFgz7L6Mv3hs?=
 =?us-ascii?Q?LU1CYQ3CjvjucNF9d9lMCs+4U/D4ZIHHcupqInGEw1STL1TlSmLVX0UskLHX?=
 =?us-ascii?Q?hiCkrRZ/etJSg8eUrna/RSLgkHuouhzaBdzNyCbI/qW52ES+mbPPQ5odH3q7?=
 =?us-ascii?Q?bM/jCNxG+pnxL8W2dezFN1epJfskCm7oIZDr0BdwSsX4KFeokh/pjQ/EUipT?=
 =?us-ascii?Q?OGo8ciIFChg8OFlrORFnOqFDGoaaCtzyxCuv8wFj5e6+xFAos1fEfH1LyIGK?=
 =?us-ascii?Q?uQ2/jTUfNmaTZZQ2f2cZuWpVC3NbthvMpjMXdetKKQsOx51LSlfzIrRHslxh?=
 =?us-ascii?Q?ZfaCTQ6OkXCN5XYGQ7xw6wa1mN2pUAluU4NzJBr1zzZc5dGGlxN3RP3B8lPx?=
 =?us-ascii?Q?pWXIlhTydiFzeYkJls+40h7FEH279oHDUOwCa09qhqDifycvywKGyWObX7sk?=
 =?us-ascii?Q?CprYuoz+4x2x/rUN9jHip/sMjYXvfrgnd3K+F4SXa7XE/nwBbVt41Mr6XfvQ?=
 =?us-ascii?Q?XY/Y1zpe0ct3X7/pyNwPd4vKter8hg8f0tSJgCLR2rDHoFnrho5GxAciJpJ2?=
 =?us-ascii?Q?b/p/whRtZslbXzpUBHtPZQ7jTQKIyAkfxfcYCIPy77JB3DCSw0RCDvKVgfWv?=
 =?us-ascii?Q?N7Vppdtk1+VT+xuueK1TvnWUAltCC6ytBSUmiFq31cbKSDT8Sul55Z6YGiLK?=
 =?us-ascii?Q?t/UY3aW+KvTspyPwyAj9ewa6CVvqnRMWORhxhK0/LD4TLcVkbd293NSe4W00?=
 =?us-ascii?Q?eBfOMYaQ5ufjFKkkbBSFfXPQDNIoH7j2uaso0KFynoBLZkH8TRnZ6G7weSIl?=
 =?us-ascii?Q?1yQFZWyzYF76TmVgOPlSbdwqwokzopsp3M6eDjsA1qR65fY4XJtT4fSrVbEL?=
 =?us-ascii?Q?VQnf1es1Ekeyi7iCOVvCHgzXurqnduCHI/RGfIgtfp7gRcE0uLkSoLD+iOzS?=
 =?us-ascii?Q?e7w64kUaTNYzVPfsDkT5fzGYmMBTzS7S12kZBWrmJ2v5A254BqrhvJUSxVc5?=
 =?us-ascii?Q?i+cGjib9YX2qgUK7kamT8ryVbFpzPBvKsTmW/LwH9K2GgPAiCsw7YSj8l6wR?=
 =?us-ascii?Q?NzG5abfhkQI0Xx4T3cKFzPu3zxzgYRGkFxz6FDp8V0HKj2WLrmYFIKyHsWuO?=
 =?us-ascii?Q?ov5q99+BsdSe5rxxu5lm2qCN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/0cyZiI2of4OHASrLlHhTkrdQk18jKNSxq56Q4of25mvG1MueXYRt/I5s5g?=
 =?us-ascii?Q?CFL7GFy3K9ix1ua0Bmhyi0F3m+iwEYzr3FlKTf+4o6Ls5nMbV56YsGH6taVo?=
 =?us-ascii?Q?bhMCfBmcz3hvQ4B61i1QzR62FhQegzhnOV2Jcxi2NWJhhVM5cKThuGjJXtH6?=
 =?us-ascii?Q?9EXQyCLrtPpWJM23YYKBgAXGaJo4a7X2i123y0FpkktDeiuJVH/m5TRf5RbB?=
 =?us-ascii?Q?76uURPkCiAADNoZ1EG2XlvWzM/f/O3Fpj9jhaFXsmqa9fVNvVeLDh3n/hqaE?=
 =?us-ascii?Q?Zje2wuV1wQ2n4biueoF4PeVEz0pNPnUjJFplaYnLerFM7NxgnsTURTG2SVf5?=
 =?us-ascii?Q?cnCLEF/bFat+5xmCzrt606ep3vebKvnx7vMNRJD+gRLrT+D7eNEUJ9sanXJ/?=
 =?us-ascii?Q?JD8oarwER5u97HgQDrraH3DbgIEOrFS/GafemFeht946rX2AGD6Zx6njksxp?=
 =?us-ascii?Q?kEVglvDjJsa0CTEMsQoU3IFq2OFcOg6GCWhij/VzE+Xc1TVymIeFRhPzCkG+?=
 =?us-ascii?Q?HdrjAFaVscmCFt5lhlh4zJLCWLXdu16JGPzbij1bs3iKJfH+GMEl/y213EuM?=
 =?us-ascii?Q?GaWa7BUkXNgApjRLue0mOU6LSsE/TBs/mCFxctqi3oiaZP5WFrHiXLrwuNqR?=
 =?us-ascii?Q?1ivongDLIFsGO0VHcJP6KJp/cQPgt/v4nPbjHMA7Vc7q6pM0j50ykhMwJxya?=
 =?us-ascii?Q?MFjHM6/8XhhbZjB6ekfb22Tpv7x49kvwMKy+fbNH3pspRyjASkFe53psDupk?=
 =?us-ascii?Q?tB4XHhQfryb2PFn+peiPcy/kRBC/TzPYxrBY8LX+K5EHtQF9iVAqhs5cvcu+?=
 =?us-ascii?Q?ow+2Kv1Li8/0rCjdSkO2ufZPopYt/5uZifrZDUWQTkypwrnFDMzH3ur579V8?=
 =?us-ascii?Q?XoBODrozQQcCEdI7hblQe/SAlAxyHbCWUZvylUqsGVj5e/rdFdPa+rhAKjg/?=
 =?us-ascii?Q?xy966aY4Q/xCaPkbpNB4VmFPUPUF2JVuOoKWBvY07Nm41yb2lwx672S/Jnaa?=
 =?us-ascii?Q?ndgoOevJKM+gKhrq+LwztU5oBnQ+zAO7SyPpnWhRTnwHPhTYR/OAd55VXKNR?=
 =?us-ascii?Q?bLGaG2ZWLpBQ4EKTWUXqFzklrRjGqfqXXmXR2wlBO73YBRzv4DprXcMMHa4t?=
 =?us-ascii?Q?1Upe9bm7fS/YvYx0advOPGVvCCEReCC1p+xBANDR/EqrnV0sik4tBQO5O9CH?=
 =?us-ascii?Q?iH3T5kV28gu/YvQ3AXajvMAPyJy4vxoiyINK8rSvGMWXf5j8DvYAkvbZ08ok?=
 =?us-ascii?Q?psG0t+d7hBhOD1Eb7UQoT/bS4euM140Uw7EO3GqLUEjHYa97FmItJxVj/oMm?=
 =?us-ascii?Q?BxCMWO/nRHkZ+JGJr94g3pA/AF/1ogeR3KomQDaTk73n37/6cwiig9y0ggkZ?=
 =?us-ascii?Q?EOxT/RNZEEe4dePjzxKs2uZGomdPJW0/h6SM/9XTQC/VPNUHEPfAKk/sZoBi?=
 =?us-ascii?Q?+z50otn++ritMXNoaExWf/jERyQUWvUlFFTQGCFZEfw0HcEPr4BMijaI30fb?=
 =?us-ascii?Q?pLLjJmjDspcRYGOfBxFFpl1zujqfAQlZhJe7C0arJLbw8s4/euHY+4VHyUHN?=
 =?us-ascii?Q?Sup6FDMcTbiyAPNydQCuhh1RtAZ1wOSux3BOLAUl?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea61128-674e-4762-4a03-08dcef751fbc
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:02:30.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI/yTyP013Xk+Eo4Fo/C8V/7rl8TPWQUmNTM7V9cP3Ku2qDV9vJ0fcvaP5KvWhm3TbYqukl2wev5ubgse3FoZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2069

From: Joseph Huang <Joseph.Huang@garmin.com>

commit 528876d867a23b5198022baf2e388052ca67c952 upstream.

If an ATU violation was caused by a CPU Load operation, the SPID could
be larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[] array).

Fixes: 75c05a74e745 ("net: dsa: mv88e6xxx: Fix counting of ATU violations")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240819235251.1331763-1-Joseph.Huang@garmin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ea243840ee0f..aca35c9d9fbd 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -363,7 +363,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 		dev_err_ratelimited(chip->dev,
 				    "ATU full violation for %pM portvec %x spid %d\n",
 				    entry.mac, entry.portvec, spid);
-		chip->ports[spid].atu_full_violation++;
+		if (spid < ARRAY_SIZE(chip->ports))
+			chip->ports[spid].atu_full_violation++;
 	}
 	mutex_unlock(&chip->reg_lock);
 
-- 
2.43.0


