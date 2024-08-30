Return-Path: <stable+bounces-71570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED5965A59
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C34728D788
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38516CD08;
	Fri, 30 Aug 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="P7Ae7Awe"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2094.outbound.protection.outlook.com [40.107.247.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBF16CD33
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006645; cv=fail; b=XtwflHVC6WikLPaYXODgaul/5UC+YEGnHja+PWp88jAkDrYbg66BYXWr9SgtV2nXMpLOcEA6ZrU2ZkM+MeCts3KFPW5iLf61kB0NvBCTQ2IACf/d8qYaIdXT9pGt3604WlmVSIRd3a87nuSlt1V5ObH3gATHGQbfYyz4yyvMycI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006645; c=relaxed/simple;
	bh=vuxTubis5XUJnWM6oHEFqoDU98bVBGA1JPZ5BrIawDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk5NTbMl1B7lOYx0+urH7d2g3nqoVV0Kmoi/RYoGmCXrDrn/oebZB0hoaMqTf1cVVNqR+ZVChWKiOoayJmscq6NcA8a65kafjYlsaYd5n6vmG9JRjxMWV3UGU9OeAmtsGRJ14fIxuybYLlTG4BHD5vol73QSWAIjFA9QGzAowaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=P7Ae7Awe; arc=fail smtp.client-ip=40.107.247.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLLkD370IdZ4EdeEPDOgIKvxsVLzEzxqjOLINR1XzAbVet3CC2LOrf0gTcZvJ7j9am+EaJD/bi7F7q5eTIfFKj3oLawZpatLrTJ0XvHSus7/Xbjz5WUBMmv3F3n6F4jrxqwGfO4spJu7aJgUsWqraHd6MFwNW5afip37TJTebCQFCie1li2dUi/2oTInhrVCIJ/tKCZmojjg2NuHDGKxFy1Fb9hDXZGWtRmKSuFBKiNwmWzcBx8+kPTQU0cPX3c3neWpwWOrSpVhE82EuR+wa7OB5iEYGh4NvIUK5TxTYGB7KOyv2LzqkBMGDWWAye+BNiT3ysNf31om/TVLkD/kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFrktDiwOIL8ClzpoqdrAvA2iHDT3C5OGU5vzmwda7g=;
 b=KTHRCLDbgrYZq5nSnNHS6f20bgTc0whYMbYdSjOR51vGLpKI8HmvOHIbgODT1MU+8uhzZwMaBxMH27zyCo+xAraf1HEY4oGDJfpilbhaDxttaJeWa4K8hca+VJHUq9dwDbE8k1LzEeHr4Nnt6pEhmzcBajuVwMcMopl6WzpBAB0n+uHvcDxX8u6sGLWRSr9q9sXjTk3jRCq+xyYsHOjN7/6x9T0+VEa8QNIrANF/ysFjBTx0yYTJsn7ulPcCX4g6gpWreOZNWakyM+BRZO130UJQDbGTOS0OI5vxLK95PdQ3kUYMuVKu2/nbMk/fkcO8a02ilOnWCYOKGQ0JMWtmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFrktDiwOIL8ClzpoqdrAvA2iHDT3C5OGU5vzmwda7g=;
 b=P7Ae7Awe7SrWEnRzao+V09lLeaKBkYAoNhC6IGC5UDtGXyB+zzRuMYktn6MuKtyEVz4eJ2Xe6kHVHUG/DLT7vIxM2v4GV7Vko6ptEqj2dyGp1c6KDq8pjHbY1eKiZrdVyMb04QxZnzTi2ZHBdIBwd05RjczIC/SF+u+cmxr03sAyq7NotxyOM6/S8F4G48kINRBqTfvRnKiBdwJKHGHZDlHUbJpxGnj54pvP4vsTWQX1ipQRoEiAl/hwvslSnHJ9ilv/IxlHIL40JlSIDdCY6L7TGzLM72aY81Ff9uTOLka6W63y2GFk79d31n9dniQxV+yzXKjyECgALryblsj0IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB2068.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 08:30:37 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:30:37 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zhenghan Wang <wzhmmmmm@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/1] ida: Fix crash in ida_free when the bitmap is empty
Date: Fri, 30 Aug 2024 10:29:55 +0200
Message-ID: <20240830083010.25451-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830083010.25451-1-hsimeliere.opensource@witekio.com>
References: <20240830083010.25451-1-hsimeliere.opensource@witekio.com>
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
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB2068:EE_
X-MS-Office365-Filtering-Correlation-Id: 879750ff-de6e-4c87-675e-08dcc8ce0645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84XUpcUvXDyrcrQfEbt2BkSitrt0ienw8eKru+0wudAIvO3FdOtcJITAXhHk?=
 =?us-ascii?Q?icvv1imSFYCPS4WhBX+vxmnKv2Ns2J+HhKKm2NFoetAIB9TFHPHMKeZoV0M4?=
 =?us-ascii?Q?vUNpcLglSnwAqNJbiB+cQTgFCo8yr54mVg76LNufFQxhJxN9vqqXp50T0ooZ?=
 =?us-ascii?Q?ukpEJXTE1C6FTLzJSoUmrHqgmxGPEHE/WsvRKjDyClAw1VrDJgNGxSVxBs9k?=
 =?us-ascii?Q?0zFxdcr2j2Z9m4HzcIytuyfs9YSXkTCyRfYMQrSDYFHpDXDfeiKIVgQwnpBW?=
 =?us-ascii?Q?tt9V5IHjnWWjrpiqdrwRekx+wsKN7Qhmwqd8O5MKycmfNgRxkyt0UsX79HRk?=
 =?us-ascii?Q?HY48OZa17GZHG10BfB8wMhTN8E6O2K3tMonJjaCzHsiplF8ZinxJh8XEdbsi?=
 =?us-ascii?Q?B5GuhRPaPeZhS1fWOUxq0OEXW0M0w97lEo8AWEA0ZFNr/JiHtaW/D0yutuMN?=
 =?us-ascii?Q?8D9+rAuys2sdjtiq+TRFj8GrPG2n+DkJL6lQJFvBP5puP/sL8LOlvaDoKBN2?=
 =?us-ascii?Q?syWmI0whsxzEa/1xceE1c8LLf055mR29VZ3ajObdJTfupqRzHPS1JC+Gf5WB?=
 =?us-ascii?Q?u8gImPD/AP/Xq4goE9f1HiGk21+S6Gyx6EdVA5d9V2qKPYsIUqFOgY8zi4hV?=
 =?us-ascii?Q?1gNP+6NOV7S+Ne3Mi7MEMLU+wuNyIXfPVuw4MAvp+uUvfALQfhQsowve1AEO?=
 =?us-ascii?Q?BV9Z9ev7eOja1rsuK54ESF4hk13HVJ3xGoPlBbh0Oqenvi4ZrPHd0lU0rZ5J?=
 =?us-ascii?Q?6vnjRd3Q64fFlqAzVQwhaCkJeCQypsjenjgTLnJKEmBO4JoMDqyoGCisSuqk?=
 =?us-ascii?Q?lEecRXo+xJRslAIgMl9OykhTOTjJoC8YuqrcOs2Gwmeb6bYoF9Yp/DAi/eMm?=
 =?us-ascii?Q?SrEZlvtZ6swRjdzibbQG6VIpNFsz7H1h0jkHUlqK5YpV0lyGnHHU2iRCb8QK?=
 =?us-ascii?Q?HmY+l2K+uK37auC66P7npveOgehVA62uW03iBZcF/xOM96ARkep8fTdQDQ1k?=
 =?us-ascii?Q?HEb23UQvo+LNuaErLdcSmBfRTzTPaYR1NlsE/JZAv/5Dh3eivGfJhhtz7trU?=
 =?us-ascii?Q?xtuRRgPpf0rVUTv6ZNwQyRgK4L+QEpa6YEdLixaRKGSLyGfzDGHsAibBFKoo?=
 =?us-ascii?Q?8bWbeYTnzTJJ4uIwYtcfEmxEm8G/YXWHNUuLmGt+rsmf0UU1OlxH3ttI6V1S?=
 =?us-ascii?Q?L6fcH4peYIKWaYGY7Kq3KFdNIn2Ke+efoY7rU3GmegIYm9mRTwgrgJEJRGUc?=
 =?us-ascii?Q?+Dvt1iuu+CVydKpL++B9nXzknGYkq/wlpn5gE89PZh7G3SQZ8FR0iavenXkp?=
 =?us-ascii?Q?9dtZYinSxt24PWxsaVU0hWpkIK6oAGb6RLYvqKUNlcNx8kfYA3/cV3mfMu2X?=
 =?us-ascii?Q?wfXLHc5pzLuogad/6cUJVL8XRljxEXiUBYVVWmWedPB/J/AoGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iI7eaSoaKqDvTCsv4++uD814KQmdGCI82eNiFiEhyj1JxeXS+VhTf1G1d4s2?=
 =?us-ascii?Q?JjqAoKZAkRdf0d/aUYbGDbN/zbfxg/5O5QUSmt3s1GuyBaTeb8XxA2czHWMf?=
 =?us-ascii?Q?NiUkmgwD6vh/RrGkphzGfjI9NLxsm0vrkTGlojuUj6+JtAqaJeL2IhytvhB/?=
 =?us-ascii?Q?sNE9VXBDGl2Z8LRVVWNxhnRvvbWPt8fckRlq+vQ8It9z2VsDiOQG5hc+L83/?=
 =?us-ascii?Q?npmBZKanbWb/8znuzoRSB6NkBPx0u/A5XKE4URtaqqpF3CEegaGfle0P2gPB?=
 =?us-ascii?Q?0Rr0jx41na0xUP0wbhk3IkP/fkNqMe9KUtLqSLN+XFWVjS81bH4wVIFUTcRi?=
 =?us-ascii?Q?BWuIC2kfGoRY5Z6flA6ZOGzI5kKxbezniO6KxweRjEP0Q1/8Xp8DhnzxszfB?=
 =?us-ascii?Q?WNflTZNSlzqx++2ZDToHK8RSoERbMUScG28oVea4uZx3bXmiGn7tn6aPA9+W?=
 =?us-ascii?Q?iYg0fSLbes+hr/cDzJgxWD/lFWwr13auZjyOFCL29IJ8CeMoxTEJa8yhjwCl?=
 =?us-ascii?Q?dKipHplxp1RzxDRSEqgnzBfUn/acWYZdSQP8484+ALz9POHeJtVKik/C8DW7?=
 =?us-ascii?Q?I8OfbgU3QQYiITLVoYKgyFa+7DEmSkxKF++1Dxc9ZSVLEytJ5pvXYbaXzBRJ?=
 =?us-ascii?Q?CLa6WazbTYa8xUK9U+4IMIxdOu55MD9pMJ51ciaorwzm5O/V7A9sv/t62T93?=
 =?us-ascii?Q?j9ByNPEpKwONMOA56kmBn9kOMu/zwIpsWIU/futJ7zLGOgzwfO4agZvkdlaS?=
 =?us-ascii?Q?1SgeCLyTBV0CNRNpnofXBhMrqqLl2m77sPSflFH2d0G28peUNUlOom91O+Ye?=
 =?us-ascii?Q?FEcxFSvVQT4IuMyUBwgyLo4j+/XtBocs2NiqNt6TStTmWBKTGdyivs/n1qSO?=
 =?us-ascii?Q?dCh0dCrfZyXG3g0fqV0sCRVbndoK25PrjZ8FkSd+SC3jVu54YXEZUzEvLNV5?=
 =?us-ascii?Q?nKWB9n29Fz8K7NovDUuvWxIal0p/KsKUHgIlUBhyR//bCb9aVtoNEdZ4qs0F?=
 =?us-ascii?Q?sYJLbl/JLKBCXAjII1T02YJbgo4H0moyogZNQI7kC3rU6Het8JvYRaNY522X?=
 =?us-ascii?Q?1CgAionbPUgQ3/qIsTjyocmJNLovBdgt23doBs9jpLlpDbjOJ90BIzbznjw/?=
 =?us-ascii?Q?ho5Vwql6HVA5rMgGxayHTJO8NoSKxaOiV5KfAsaNW6WIHmUmFVHacdWIUgFP?=
 =?us-ascii?Q?cVsikGSM2C1ShlMmQn4mlr9YSkhXVSLetqZ6UeHN5kbhJUtEDLReRIXXA1ju?=
 =?us-ascii?Q?sr/ziaaz3/j+d/I4JmNyuTrVAo/A4TdjRMQLQMlIFj40+wdlDz1+4pUKnWkY?=
 =?us-ascii?Q?r7uR7jOQLIpH4o63P/yBym0/7ijL0QeY7NWEO6r3yYLJStLJgPg4S9qTWYaN?=
 =?us-ascii?Q?EUNlHNxOCi/jpevM+QUDU8TgoGP7yN7QgwSMO4JChB2QYvYLBVQE8zaJx/Xb?=
 =?us-ascii?Q?FOTRf1Mo1P60GOhWNiF1SHx9PMlhpfiiW4AqKsqV56+bvIgOkb93ikk9BZaG?=
 =?us-ascii?Q?vQdNDSAHsU1RQVSc5kvKwcrwCmyHMH7kv1pfAJTkRClfG+gw5KIqZfffbJkT?=
 =?us-ascii?Q?N2ZgIrJsTjhg3njWa+U8fcgaJNd3QRnwtHCcE9tiaZD3braCL/aNA9puR6Ci?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879750ff-de6e-4c87-675e-08dcc8ce0645
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:30:37.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTXVnRSAMBhA/kTD+UaZJ9mYyUR1Dpgakfq/iksf8nQIOfV3t+9QT/gsWE8ZpOztBXKUQE6IHZgd/JIkNK9s5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2068

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a upstream.

The IDA usually detects double-frees, but that detection failed to
consider the case when there are no nearby IDs allocated and so we have a
NULL bitmap rather than simply having a clear bit.  Add some tests to the
test-suite to be sure we don't inadvertently reintroduce this problem.
Unfortunately they're quite noisy so include a message to disregard
the warnings.

Reported-by: Zhenghan Wang <wzhmmmmm@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 lib/idr.c      |  2 +-
 lib/test_ida.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 432a985bf772..3e4035fa89dd 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -471,7 +471,7 @@ static void ida_remove(struct ida *ida, int id)
 	} else {
 		btmp = bitmap->bitmap;
 	}
-	if (!test_bit(offset, btmp))
+	if (!bitmap || !test_bit(offset, btmp))
 		goto err;
 
 	__clear_bit(offset, btmp);
diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..55105baa19da 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,6 +150,45 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check various situations where we attempt to free an ID we don't own.
+ */
+static void ida_check_bad_free(struct ida *ida)
+{
+	unsigned long i;
+
+	printk("vvv Ignore \"not allocated\" warnings\n");
+	/* IDA is empty; all of these will fail */
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single value entry */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 20) - 1);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+	printk("^^^ \"not allocated\" warnings over\n");
+
+	ida_free(ida, 3);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static DEFINE_IDA(ida);
 
 static int ida_checks(void)
@@ -162,6 +201,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
 	ida_check_conv(&ida);
+	ida_check_bad_free(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
-- 
2.43.0


