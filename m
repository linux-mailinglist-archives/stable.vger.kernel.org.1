Return-Path: <stable+bounces-114493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46768A2E76D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1F3A5135
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787341474CC;
	Mon, 10 Feb 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="eI85ncXs"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2123.outbound.protection.outlook.com [40.107.20.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6522097
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178977; cv=fail; b=hEG4/LcA0llSjWt3rshYk9F9e8XftBS8hGJ0L3qdcarhuleplHEmGORks7cRIXksifgBKufrvsbJY9BIww/cWN9A6B21baDQJKDzHWW9VVlZ9U28yh4ZXs9Orglja8Zlp2LIrPGWYKMKduX0/1xitq97KAioUY6D1WtavTSGPLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178977; c=relaxed/simple;
	bh=Y59WEOQCTPgFtk72pUyUNTr7Nub3UZfgk0QTi8QhrQg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nwqpMbBhGJ8tYmBj1bjIZqVZ5y2n4SVoBuml++9Y57rSJUKAIRhuAW+YjtenpDYtaT+Q7EV7dMiZ1eKch2zRi33am7o99armCHVhWRXDcTTllhPVLy80VvIp/YzB/mpelBPlbjSG8NGg7PvutPmNMZWOHNIEzlT+l9CLkY62D6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=eI85ncXs; arc=fail smtp.client-ip=40.107.20.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLNUqsAP0jhotqPj3x58OzF6lS6LVxPvwV0+OXFym4oyzcwJ7++EpeZ0TTALM6wL1/ZR3OYTGV4BO5u2/aRSgOYJRKpPtadR+42MgoA/NunuB5rG5wIEW9ygEWns+sP+LRSoLIwXrLz2OUsJoE0fX69xQCy88iR1jGGjre4HpNDvUwEH/ZJJ1CkA6hZf5c72I0TuE41s5MiDdegAe+oCONqhewnBNiaMwlMXE0Hb5Q8cE9Oi9zKKAeTTfayXHz/JmCTQQkZ7a4NNfDQ/ezA2AvRmsCJAHOe8yGSHlz832Ywt64mmNvoHsjPWorKRbmqAm5sxS6S/q8Gruby9YR3nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I7qIVdJr60gnXSMrdghUCb5IqWedXkSYvuy+hIjXEs=;
 b=dloEHKviRo/fwq5oi2bdBu3RzU2x4ibiYEmffOznlxQkm1FzVE6GUmBQZk8XSmmulL5BPulusL6yBR9XjZFbUBgjLZtDrPo7gAIlS6EIdWRx0kOkmgTC0NRGAUlb2DahjX3FoMrfO0oc4TY/F/EdSHA7tiuxVji/SQ440lPEqp36HabcmUYXSFXcZyy8S14iTmjwMSEtjUt3E3Zj9Wcz4rFHL6o7G/1KmOtwy9hNK7rSjhqHCVwKv4AEJ6KQKymGjBV5fDAixUjbh1ibLuUpbIDZ4mk8rvySQW/L5zLPrtCg8yyeK4muoh4Lwp3mUGA6cHeurhk0ULX6vIhiz5QiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I7qIVdJr60gnXSMrdghUCb5IqWedXkSYvuy+hIjXEs=;
 b=eI85ncXsUxWoWWIG6avlVB6IZWjw3g8HGdBSrID/aZLR6k/iWg22XBYR2I6IDc48mzOCGm/Le4XqwYFN5PsraZnd4o8ihpAutplBCYYhDKGwmQ/QTYEQEkpFH3o8VRXHlzY98yjU28SoXqQCVfY1t6mjp5MM2rzAv+1lmPfsQWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS1P192MB1542.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 09:16:10 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:16:10 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.15-v5.4] lib/generic-radix-tree.c: Don't overflow in peek()
Date: Mon, 10 Feb 2025 10:15:46 +0100
Message-ID: <20250210091546.208211-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0073.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::18) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS1P192MB1542:EE_
X-MS-Office365-Filtering-Correlation-Id: 380d1892-84fc-4536-ab08-08dd49b38e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6XZbWc8CU6A1bX46/LSizL+twR7Xf26CxNs0HnyUVwzb38Dx9u3IvH7iiRr?=
 =?us-ascii?Q?KCfKJgl6ThmFumqkt9+FNCuXNU6voZh4oxiZy0G1zWWCePKJLEyEYxOoGgq8?=
 =?us-ascii?Q?RHYcYehZfOJDSPD7gkU5lDXg8Mh+UR3d0JqrRcS/gzXgaKPz1dM8i9QBXOy2?=
 =?us-ascii?Q?GAJ6Ws1h7iKB+Gsn0VZ2L2Ebnzqw+pZPvccZrKQyu/kRkQV60rMYiK2szMRD?=
 =?us-ascii?Q?I7QXhZInRSNGio76zhtTG4kCIKvKEXrwJEctywxdrfCFxnMzZEhVKpDOxC9c?=
 =?us-ascii?Q?sQSBcjU4htHM1Kt/tFdIx7EBS5iFtiTbW2hiwTFSawjOpQbhLmZhelf0pdB8?=
 =?us-ascii?Q?VaygB7w88V+8SBO/nvmIYUeqlyTgZuh3eYO29plL6ZFe7UgpMtQq7FOy46jd?=
 =?us-ascii?Q?jq9dV3eSl4cnt2A/TPTsyj0paK2NT4SaJHhVWjnD0JIh5PVXGy5Ak9xbMZGI?=
 =?us-ascii?Q?ZVr8wNFZmv94yX8UvWsFUUxk3BUcB6SAn4hkGSngukGmAa9iOLCSHWEaoFAv?=
 =?us-ascii?Q?SeBqAFTqh5lB9KdIbPOBZK/voGGpI7LvIdT1fW/XQYrzwBZwmQrv4iMBZ3Bv?=
 =?us-ascii?Q?yhJNhVOvk8+gzFR8TFEgKyCozpO+Mb71SmUN5pQeNGbyPUtmXXo4kEWRhqTk?=
 =?us-ascii?Q?Ug/y1pfLnlTcb1wIALgdrhxusJjYLM636H70gunPbbZsowzWETMqcrhHpooE?=
 =?us-ascii?Q?idbwnC8aQqoP/i6KnrcXBy9Y0sFw4gcuKks8Aq6KMEHRvT6OoXgzUc8WZqvb?=
 =?us-ascii?Q?Yt2ubUH4M/fbh1fjSwnzT+6/gfRzLmvE8jIX9gX4360pkVpJrFIoHynHkrMa?=
 =?us-ascii?Q?k8UXqoREfwM58fJATnKJ9mnCJugKqrAfbG229y2zTZpaKo/gvH0m7IcDdlnk?=
 =?us-ascii?Q?m+h6lM0PLBGz48+fwcS1eK4j9U2YZlJo5WpDwhz/TWVy2bJ/wGlI7XhIquAp?=
 =?us-ascii?Q?HVuMByU3B/sIvhl8JB3ZzZF9yktF4iPstaXZsspLNvRqCLXAmkiCqrtq+SVF?=
 =?us-ascii?Q?14yLVTsdrtHZxig+Vang16b71PpB3L5QH2o9BlpS2azP64PzFAGSy2KRrsM8?=
 =?us-ascii?Q?sNVHbMKOMVdNq8bjgHamDa3oCbG6Gt3RuKUTir0jglYAvEMHCgjFjJ8BO6kd?=
 =?us-ascii?Q?oGYCz6KLYhJkUoPQ9LAh+hqlohq+4SePTyH+xxM3xQ8vY+NnTqlRP0sQk7K3?=
 =?us-ascii?Q?T8HodNS6Du0+TL1f93mdWLqdAFWLT6Pya/V/sQuCSbHqtS/c9MssP/oLdY/Z?=
 =?us-ascii?Q?zjcO2wDZjzgNMBK3COMq05UjqhDY/UhsGT0QOTZwWYNz53zYDWs8eeBp3Y83?=
 =?us-ascii?Q?eeyIgaLKir4kzFF9g6iMgqq3xCvhxJoMkZq2C1usNumgXKlDSS+6uvzWU6VC?=
 =?us-ascii?Q?OnjbIzrAEp+7eR5xPeNHyR3Teq6WVkoyKOFq/QM0n+LemQvcNEzK/qG9IThq?=
 =?us-ascii?Q?mbW7pgyfrIPf3J+mx3Pt0UGn602lBMMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoRIwg94XMLUSgRwlhPHIE5qrvp8gjfseWZklE2CWT+zdeEzz3EenRpgN5sd?=
 =?us-ascii?Q?4tzi20Wbbn0JbLqSAb/D3QKe1fyfXE2rjxp6XkZGFjJbcVfvzWbnZUuEEa3b?=
 =?us-ascii?Q?BgImul0UfXSsswYbZaKzbmgHYPionLtzNoG31n4uF6kFvnLk3HOM5sWijB0Z?=
 =?us-ascii?Q?ZCSj+aSta5/DYbClqXPEU24fb/frI+H5ojS1vwXpx6fzOV0Dr6WfW3dFxjjg?=
 =?us-ascii?Q?UQVO0un4CXs63IhL7xbK0FyEcso/Z89Nt1YgPOxEEjXeMFYMU8qah3clTSuj?=
 =?us-ascii?Q?5D+A0BJuj/KJwdItztwLSNxKBG98cRDjFxWRMQAlCwlVP6Vkw75tKI1jX+hW?=
 =?us-ascii?Q?vyEPRpT7FOD1a+e+t8fH5Tm96nFlVTCswgSg80LDfYGZk89aaGyOocWYAtoi?=
 =?us-ascii?Q?rK6Ew0cneDChJDtLaCnEoJ7frBmRuJZNAWNf4p5RdWlstYFIr60+KqYIHcwP?=
 =?us-ascii?Q?upvWZU+wv/Xa1E8oyW8gEnixetsEXkUk/DvPgHvSnKImwkqJa56EVUzkPBXb?=
 =?us-ascii?Q?xkXrefy5tkFULh7uqHfmvODowrvyQ7Ht8OCrUkTlcZ5CWrQ9bvq2Cfp1lkUk?=
 =?us-ascii?Q?Edd527LZ2A0PMrClIqU+HjtKB7LltgYUZV6dWO9geA/1QUzTazYJ4FFirdeb?=
 =?us-ascii?Q?gyNCnuGICUCN6b1bIa/qEQ1rrQOLUzDScHwWQi+5bAHetNIwGsGb2vadNN/Z?=
 =?us-ascii?Q?bRyyKXOtabbt+NX5+9advZ3ttazi/1g0CqzTigNgU+7IJl/6p4JHrU2T/k9V?=
 =?us-ascii?Q?Odc1YRgTtlAxkJfBAIQ8uo6JKViHnX28n2IiPaD40oAZwxHKGbmK7aDmArV8?=
 =?us-ascii?Q?8rdWrMMVCMsKFeO2eAG0hcSCs0F18IABn5iwj3eGSpblvQgAryiZtqAzcYjK?=
 =?us-ascii?Q?AAKKMkrmKMgAj25vjv75LpD9GnBbWjZcj8ys20VhpgpM/Yj1tW73u6yoOFr3?=
 =?us-ascii?Q?XT9VT2Eewv18846GpOJA/TdmfFTp/shc0TgwRE1v1M6WVF3VlQUWfjLNwqyZ?=
 =?us-ascii?Q?MC17CNgZNJ4aFFoA/cFCL+eaKlhpN/5Kh2/UiRc2xhwozaHRyunbv+FFkLbr?=
 =?us-ascii?Q?vNaPpq5QsYL4ENXW5YVwratfllFZlr1ewrXLM9i0lVw2xBLSTAzk1UW1E6BC?=
 =?us-ascii?Q?LFMtXjL5Bs/IzQZJEm18Ps6xMr5UdpYUctnFwQYhy3KnLDpYGQilq+P7F4Y8?=
 =?us-ascii?Q?EPTItWWJXpU1LuwVwvnMMe+y1b1SJWFZJhXR2t9sz2zBNjEva9J9ZnUETCFU?=
 =?us-ascii?Q?7SSyMSSp9gWyfOukV8HNjKfxcz75WKKyFB9DUDo/uHfmepcrYLxuABEPt96B?=
 =?us-ascii?Q?/D+aBIu6UXNzpThqh7PdhaOGFFi4dTzTUBFUMavMpttGkJNZqISsDmc/C7dB?=
 =?us-ascii?Q?/gzCK1Y3oFtN0XcOAK6DdF2jqkoUPaI29+Gk9wDfgdGB0BT/s7VRoQqcum24?=
 =?us-ascii?Q?0vp3/QnwE5XqgWsVRBBcQ2aSMLHTM8S9ZUfadSU/CzjiYHOG4SihlbmeOkic?=
 =?us-ascii?Q?+load6rlkPXYy181f67HkBA3iav6qe1lgZoxTDa3K0B05BAwNYzOSoYpfX+C?=
 =?us-ascii?Q?St0O/WdY8P6kyo5tmSbpJDiH7DJzrlVmEaJxujLJuObZJx7KlPHEErA67TfM?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380d1892-84fc-4536-ab08-08dd49b38e75
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:16:10.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpmmAKakYqYafD3AXKgRkpVunYsaskBaUx58JnN/N6CbZc6bIRW4cpZNEPYLhSDD/Caq+EQXYada1+J7zvVBaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P192MB1542

From: Kent Overstreet <kent.overstreet@gmail.com>

[ Upstream commit 9492261ff2460252cf2d8de89cdf854c7e2b28a0 ]

When we started spreading new inode numbers throughout most of the 64
bit inode space, that triggered some corner case bugs, in particular
some integer overflows related to the radix tree code. Oops.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 include/linux/generic-radix-tree.h |  7 +++++++
 lib/generic-radix-tree.c           | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index bfd00320c7f3..0e7abc635e5f 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -39,6 +39,7 @@
 #include <asm/page.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/log2.h>
 
 struct genradix_root;
@@ -183,6 +184,12 @@ void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 static inline void __genradix_iter_advance(struct genradix_iter *iter,
 					   size_t obj_size)
 {
+	if (iter->offset + obj_size < iter->offset) {
+		iter->offset	= SIZE_MAX;
+		iter->pos	= SIZE_MAX;
+		return;
+	}
+
 	iter->offset += obj_size;
 
 	if (!is_power_of_2(obj_size) &&
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 34d3ac52de89..78f081d695d0 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -168,6 +168,10 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	struct genradix_root *r;
 	struct genradix_node *n;
 	unsigned level, i;
+
+	if (iter->offset == SIZE_MAX)
+		return NULL;
+
 restart:
 	r = READ_ONCE(radix->root);
 	if (!r)
@@ -186,10 +190,17 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 			(GENRADIX_ARY - 1);
 
 		while (!n->children[i]) {
+			size_t objs_per_ptr = genradix_depth_size(level);
+
+			if (iter->offset + objs_per_ptr < iter->offset) {
+				iter->offset	= SIZE_MAX;
+				iter->pos	= SIZE_MAX;
+				return NULL;
+			}
+
 			i++;
-			iter->offset = round_down(iter->offset +
-					   genradix_depth_size(level),
-					   genradix_depth_size(level));
+			iter->offset = round_down(iter->offset + objs_per_ptr,
+						  objs_per_ptr);
 			iter->pos = (iter->offset >> PAGE_SHIFT) *
 				objs_per_page;
 			if (i == GENRADIX_ARY)
-- 
2.43.0


