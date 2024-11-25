Return-Path: <stable+bounces-95417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF49D8A2B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C7BB28A70
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544631B4125;
	Mon, 25 Nov 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="YFctEpNH"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2139.outbound.protection.outlook.com [40.107.105.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7331B412E
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551022; cv=fail; b=N+6oB92lI0OGPbccIi3+2Cqa6/SvP5nwjLsbHMco+DdPdtxf3lEXBTRzpoPRywv5TRQwTIRX3Ns7NEpRgJu1PokQYo6IyHd+3OTAJoJRjX3rpsCzTKZmljcUCz9ftgdGeOOpAUVEOkTVNrE3Fd3dG6l+7w7/P9CW6YmfC2gLmZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551022; c=relaxed/simple;
	bh=BckLWYrzY8mGHnyg6zgrhuQmRjj/RXJKHC73umEZETM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jiyWJxsG8dTRPq4woo9Vr2fuxlEnfr56txRvPbz776P1JgG29rCOVAg9ixN/53BWRu6IprSftoR5jV69tS8aDGSy7UNIdesZhnyDgagsrHkl2LTf5bi/aQNpNd62eKDjfoOYkFvqF0aQUrKDFMw91smmLSvvo9vFFDfCpGrCjcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=YFctEpNH; arc=fail smtp.client-ip=40.107.105.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeNE32PchbIrvffBBv0Hj11+EksdvYX2z5gRJN8njFuAlYDcU/NqJ1LvxDrwwnsUhuy9x4v3z32Yql0JNAd0LnBHFHlij6CYUQKiCjyupe89AzJCL8c6PJ0s2Tz4hdI524gkf3jKquUx4BURvOK+a2w/tps2VqoSRxpoJRzTk6ls+6J84cpLnTaMrkWWoiUXQuUGah28CzA8p1LgooocP+rL866Yp1dbz/caCIokGrI9uOHmOHPr7IIoJorJJwQwJWhxqvLBK9h0AwwOTQkplRBvFIZAU22kdp6Fqk0su90mxHZB9DyeW6soHn9gbXo/BIx6eICvkTS/4302AhUh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gejPB0In/6sKgdyuGsVtzDsOxOMB8+0t+VxTU2IiH/E=;
 b=Rx6NnXkkMN/zVdn6cuhYhbzKePBbyLp+xQ0PYg53kpJkAG1KZyMiBSotCzQtAnG1A1wMfub1rq1wclBks+uapa1uJd38T0Yv884oc2LMvTPljlXPGRASvSvi4YalQ1PYF9HeiV0QH5Zty7XAE5QovguTDvgCwmX7IKJsCd1xe4OTCZqt1Neg8iHGkDPujRGlzRTPYXPtS/Dw+uezJm5dQ0UOkrvr4vS51QMfIq9g8TskeIuG8Ktnl/BXrOAIG6pQx+K7prKpNXTDm9ry4Fvw8TrIiT0CrKLSMvLVHfSEgqbO8rOdHsVU3+UqIGGBC0KtKKfMlwZsuJLtLKEafia32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gejPB0In/6sKgdyuGsVtzDsOxOMB8+0t+VxTU2IiH/E=;
 b=YFctEpNHpUTMe+IMrTnABAVO+m2J5n5tKb9zkDy3sLmqxfaNSChi2wiLjOUEV1FIwi46P1ew0Jwy6pQvBKOzXYYAwQwIbHdBrffxW0Cuc/sAtvLEOuRx50z11AVz3ntFh1byRMpg4xwPwQ/NM+cV2a3K38K/9+wFijt1dUMdSWuIHcCnvdEkpDS4maslPYmQb0SA1aIiSN9b5V47pGOxOce8zn2f75aY/8jXP5SN4o6Hx+vunaOhVTdsGFdIRonTfpzrzUK+uhJpkvKgJzAf8TRqxO7PRHCHyow7isa6qALmJn7wOzWt5oGWf0sV5OOquxmaJVVrnXUa5ce2Or2/8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::14)
 by AS4P192MB1480.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 16:10:09 +0000
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9]) by AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9%7]) with mapi id 15.20.8158.023; Mon, 25 Nov 2024
 16:10:08 +0000
From: jguittet.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Joel Guittet <jguittet@witekio.com>,
	Joel Guittet <jguittet.opensource@witekio.com>
Subject: [PATCH 5.15] Revert "drivers: clk: zynqmp: update divider round rate logic"
Date: Mon, 25 Nov 2024 17:09:59 +0100
Message-Id: <20241125160959.3522094-1-jguittet.opensource@witekio.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:3af::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB1316:EE_|AS4P192MB1480:EE_
X-MS-Office365-Filtering-Correlation-Id: 355268b4-f658-4f24-39e1-08dd0d6ba184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMvsgTX+CnDx58RbT4nhl/DrYFwFnfHe4wLtww6XLDq1sS66xB4XH12HKB3E?=
 =?us-ascii?Q?CC5op6o+T6Iz89y1VrBTwKIItcaxWAXLhikm5LKDqYLIdUr0IAqgSRG6lJKh?=
 =?us-ascii?Q?U+i7rFMSSVrPtAMK5p0vs0FikgsWckWv3qAOLML5gB9sIXv6WBqUx2+Vsj0u?=
 =?us-ascii?Q?rDDl0mOH9j4chLTp67wfe/Tj71adfCLB728uGLtdslXlwh6DtQV1k/52Oxow?=
 =?us-ascii?Q?gu5e6B1Ko5kVnDBWDlflNqYjoxLvLLZ/sn1GOdo4+IWXXQKd8+VxJVwhDxLH?=
 =?us-ascii?Q?2ZNPvppBfuQ0PMryAP+rsKfTcUET8n0/EQuD6uNFahlD1EAWScUZkf0oTFzO?=
 =?us-ascii?Q?aIc4C84f0ROcijJBlLrool5WncWKjOKMHMpLfO0thIFju8xQPe+4c7IkqCQF?=
 =?us-ascii?Q?unXQjjHX3vA4iNPvVGbuih1B5B2hv/4RNcRpkv3i46jrcyFAFP8Y4zMLB9mh?=
 =?us-ascii?Q?OIHfbxBNc5/gTEVIDvzKkaMZzZXARDxWp7CiJe6DemIoJMv5Vxg2BKx9Ahve?=
 =?us-ascii?Q?2fTi+58V2PYHLgtj9ZYu2tfUsU5JGrHJ74p5TgixRRdUc6bnLR3ZLLcS0Re1?=
 =?us-ascii?Q?wTNQZuvBQZttx/G0MYPbfj+zsq7sDcrQIdfT29QvnRMlaaNZ/i74BEyHxjwc?=
 =?us-ascii?Q?QIhggmy03wODyXomOysP+84mxlc41YBCflqkVs8HRn9aPuDPottdNr/XxIGX?=
 =?us-ascii?Q?2MNSBUiw6Exrv5HSNdbimpADYhEeH9fmhBfotbnV4AJN6AkCgrVia+wyyxd9?=
 =?us-ascii?Q?6fo++1RaPtj7Jn4YY3LHiBy5HPVd8q5qkPyJOBNp2YmFuBWGgLJdqYYKJSm5?=
 =?us-ascii?Q?ttXXr4jEMLYLB+yvqgiKnVI2cWP3E0GXAbDOyUoQB3Yflt8RqhvbL57YZjwC?=
 =?us-ascii?Q?9tUJgdCyoiiVwKlju/RwD5/0hA1SE1pOop1CzHd0OSVO45NBrBI1p12n9Zbf?=
 =?us-ascii?Q?Qv940NrIh2fsI/nx7AEPrri6Fa5u5TMuI+romhvy9c5HCFt1KY36UvM5mDVG?=
 =?us-ascii?Q?tnvcEMR1/0mfKCbxOV7kPuABDko7M0yQd2VCjQEQumtjVR7Wq4fK6LRYvHee?=
 =?us-ascii?Q?MtJwK3UqmPazhEddMyWsvpJKhdOh7ZnSTV4a/H4XzZhDnwt9j9bU6dRvBI+V?=
 =?us-ascii?Q?UWpiz/BSXyvHylEnRRv1oS2SBMjUTNw8/aAb6qKFRVxmJTR9TX5z7FJRl4ck?=
 =?us-ascii?Q?+bsNQjV5zOSEnqQst5oDe2XRqJdTqjbQ9GsfMUtKVF5dWaG4o6Qfg39mmPJF?=
 =?us-ascii?Q?kFf+ug5/IoxLwWzHeIPlis+Rykvfr43Vn+ZV689UIDnDjveVEDQiDFkO5GWG?=
 =?us-ascii?Q?aH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1316.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(52116014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOm/sgL05eVwqJRgLV+McANcLyg9rDCOUhk0osQ7Wt4KLVLER067lwAO7JRL?=
 =?us-ascii?Q?KD41vv+uOIaG0f5JUPDrrxvk8yes5rwt7/OXkUbUNcly8IKk6Jt/xi0zrkKq?=
 =?us-ascii?Q?oPJ5gGFHMX9wZEgwaP16k/r/I9vQFRB+byTxQC9kpMEzZaMs0OJn5s0kOO/R?=
 =?us-ascii?Q?GJse8I+QFfv0Z8iIKotWI6sPRY+IMxQiQP0iwrvkLcrvVqB9aS+6J3AYJiRi?=
 =?us-ascii?Q?CHCkjrgo+59rPFXTf4v5ASm07wnkdBDj8/IYuCCIp2swigtpxTjBQFlcGul2?=
 =?us-ascii?Q?/l9MfHqfAgAbEFtQl/6TAM2+VOZu7SynRx6OV5N8vptEjPyua/MWEuN1m0ag?=
 =?us-ascii?Q?V0qGbdtjZjc6Y0Z05SFfStEy5JWbkNF0vaDP30pJKmeGut/XzSfUeqbDE7ma?=
 =?us-ascii?Q?qAiqBUkQhoqarjF2L1akq6wWm9zHQgerfo0Gdo0r8JMghrwKrUvqs4dbSb7f?=
 =?us-ascii?Q?H13Yc1OzJOtFp2D3uv7aOdIgv416+92cflq1QFEILtUUqdtlRQJ9KGkRYw/W?=
 =?us-ascii?Q?iZDlTkgYjTItigkPkQUkLfhnPcBbqLMkIBYfM61T4RpcCIo0WZEu0zAqFwor?=
 =?us-ascii?Q?ClHGpVGStf+qyU4rUqX5k6yiIGAfTluUn5pd9wOuExwo9SN3qiLvU2HjGBvD?=
 =?us-ascii?Q?qy19+Lzy+9BwyPGixCEwxWtkIfB0m6yNimtnplqgxOsC0fL9GZPQ/v+Ndypc?=
 =?us-ascii?Q?9qrCwht81RYOW6fjDhJxd7QbPdzPSN2u66m1UmRutNcAJ6tqK9iyhPaNjbKl?=
 =?us-ascii?Q?5djKkcQEt0Bi7k3idnxLE8GcDIQn8qYdTd9vVbZDadOzM7pskwhp+3DQTEr7?=
 =?us-ascii?Q?GFX/BMNPLxujWKzh4+2zPEyudyJWI6V7cKcYcz0AaZxL6a5AFTssqA1l638j?=
 =?us-ascii?Q?gWL1Pc0X/VrLd86K3VoU/DqEz51dVkPr2HREYwFgYjvtRqEXcDeSipvRJdSc?=
 =?us-ascii?Q?d2HdaBE0RO7M3q0i2j1zbVa9Wvr/x47faMDnAbtmZRBjYzWMZbQOjGi0LGz3?=
 =?us-ascii?Q?ltYAWCeYr1tvzvhcemn+0J3TiUSgsINpjFYBoYCC1PaP7iPkdMo97mUBZYMv?=
 =?us-ascii?Q?4RhaPHIu5PqUgSSPe04M/cSo2DhowBj1CqdM21duQqZ4scZiDvsT5m9cnof5?=
 =?us-ascii?Q?BSqrpn06frSPNl9SCpjePPX9OPeCNaXzViJ/G6Xr2NimRN5dZG9Ue/e+wahG?=
 =?us-ascii?Q?9+yapjZUf2Wg2PKDy0w3Yv/+feGcllLIY26mlMJ7EhSKlWeyCG0nCFFEy4kq?=
 =?us-ascii?Q?kWrHae13et8WMt5KfLdLOhe2Qtz8Kl6VbYphAa+31oL1RUw599FF3cMaJW0U?=
 =?us-ascii?Q?S6o6QlxVTrdHbReHEzooSuEqnhgUmCGG8JPxGPDxSraYOAU/ltGuuyoQVZ/0?=
 =?us-ascii?Q?TW7tNpG7Ruuf9p3pCYJkczcXo6L1vx4ZF3KEEqfgZTKGrthodnC29qHcSJkI?=
 =?us-ascii?Q?Bc3/arGVjjmbFPatpNWP3pqed/c1gHNHOl5ce7WVXi6FK5vfPcWGT6YhPabt?=
 =?us-ascii?Q?YjA1I78nZX4SypmQ1kjGUCvaeA9/+JTpfeu7GJ89M+zPdmc0/ZtEkiDN7M+E?=
 =?us-ascii?Q?DpS1hoaB59kXoK5aeskda5rF2L560nUa/amFVl4kjLBE01nODqtoPsRz+xc4?=
 =?us-ascii?Q?pwq96Xyh/WR6agyXOK3deCUNRK+f+gDTth4bFHwqA8/k?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355268b4-f658-4f24-39e1-08dd0d6ba184
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:10:08.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq1mZh+wyeefMe4yCBtENrZLRimpoU8EzMkbRRGfo8RE657qDVjS+tX5PfXBuKM+61cWvWWmt61zDTyJ5slG3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1480

From: Joel Guittet <jguittet@witekio.com>

This reverts commit 9117fc44fd3a9538261e530ba5a022dfc9519620 which is
commit 1fe15be1fb613534ecbac5f8c3f8744f757d237d upstream.

It is reported to cause regressions in the 5.15.y tree, so revert it for
now.

Link: https://www.spinics.net/lists/kernel/msg5397998.html
Signed-off-by: Joel Guittet <jguittet.opensource@witekio.com>
---
 drivers/clk/zynqmp/divider.c | 66 +++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index e25c76ff2739..47a199346ddf 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -110,6 +110,52 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
+static void zynqmp_get_divider2_val(struct clk_hw *hw,
+				    unsigned long rate,
+				    struct zynqmp_clk_divider *divider,
+				    u32 *bestdiv)
+{
+	int div1;
+	int div2;
+	long error = LONG_MAX;
+	unsigned long div1_prate;
+	struct clk_hw *div1_parent_hw;
+	struct zynqmp_clk_divider *pdivider;
+	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
+
+	if (!div2_parent_hw)
+		return;
+
+	pdivider = to_zynqmp_clk_divider(div2_parent_hw);
+	if (!pdivider)
+		return;
+
+	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
+	if (!div1_parent_hw)
+		return;
+
+	div1_prate = clk_hw_get_rate(div1_parent_hw);
+	*bestdiv = 1;
+	for (div1 = 1; div1 <= pdivider->max_div;) {
+		for (div2 = 1; div2 <= divider->max_div;) {
+			long new_error = ((div1_prate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*bestdiv = div2;
+				error = new_error;
+			}
+			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+				div2 = div2 << 1;
+			else
+				div2++;
+		}
+		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
+			div1 = div1 << 1;
+		else
+			div1++;
+	}
+}
+
 /**
  * zynqmp_clk_divider_round_rate() - Round rate of divider clock
  * @hw:			handle between common and hardware-specific interfaces
@@ -128,7 +174,6 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
-	u8 width;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -148,12 +193,23 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	width = fls(divider->max_div);
+	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
+
+	/*
+	 * In case of two divisors, compute best divider values and return
+	 * divider2 value based on compute value. div1 will  be automatically
+	 * set to optimum based on required total divider value.
+	 */
+	if (div_type == TYPE_DIV2 &&
+	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
+	}
 
-	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
+	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
+		bestdiv = rate % *prate ? 1 : bestdiv;
 
-	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
-		*prate = rate;
+	bestdiv = min_t(u32, bestdiv, divider->max_div);
+	*prate = rate * bestdiv;
 
 	return rate;
 }
-- 
2.25.1


