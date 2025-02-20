Return-Path: <stable+bounces-118408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639B6A3D656
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286B23A5C22
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146E1F03EB;
	Thu, 20 Feb 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="My9NZkj/"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6261A7264
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046796; cv=fail; b=FjB3T+N4mkixymReJDVCuZ+zC1zZOpcwNUnekTDAYWyWi91PZmYRognNEL/c/doU83FbAcC8Q8lS6FtI/gm0QRynb83dl3YKR99Ir6jVnj1pigjh5cRGeCeYZ9x44Q5E8RT0Et6Gy+r8IvaGGwdVcyWn8pCoaYlJVVk3rbBc+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046796; c=relaxed/simple;
	bh=j4h5yJ/rTw3keOTrMwj1BKRgFqO2c+oDxC4OfikEj+I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mVkdTu7ppni0OsjKrYp/kKr5o5ZTAHdDE+mCGgqlhfa1O0PIk0NrLhZ94L6W90AikH4lnrBI+JUmODzEtKxtm1EV8dKozUFZKeth/mfgD6/XqA7YOpsf+Vhk9VmvozBogvlfg1DFInZ8it9B+XTe3xKeMObMo/XZLAVkEXzgQ/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=My9NZkj/; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCCDG0yeBu6Y+hsEUqlSwkPn23FVYSBFDR8Tr6ukTPafv8CVFdSPSUeQoNWm4eTt+pDuE6YttHhhgOkmYEI6/blIhhLgHiIPC5/jTrRX4Bgrstw74VILSWJdmwfHjFVeJF5OlhV+Qtj3UmXZkcnVrg1mwJp9zYaulJPDRPRYss4GXIDGBnAicsG3Hw88o3p8PvSsnFZeV9NkNJwlJahoeR0KyeNukCxsRJkdXdRnALY5p0RsTdWal6s7M3vj/67mBzlZtQUp7C5mB5Ih58BFsirltCM8nZVAGcPaHXSkEmkM+ECP/aLzdS5ifoT5oqjonCPZawMFXW/hNIZXpNJtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WggZMQRGMvBLLN/l4OKVk+UOI5pIZTPre3FttS2cZJU=;
 b=nNsERymTGaoqJrJtrP/dOtPsbC4MQmSJ7Xdl2XLAcbRKq0HixLfCXTTEywZ9FJ1kc1SiY3BLnQXASLvGijQ71t1HjIIbj+xrXd+DGm1ZmOgcysfGqGiNifrL6/oih6HrDcJxS02nIVIXzc2HP5CITxWNZMF7oY5b9liiw/2b8wQaqaaqySyxbEQEGIf1GURq8qX8pmz72pQmlOJb+9b526s4we0FZPFs6KQZe289HeyY538J1aNIxNEsN+WDbs2e4BU58Up1uCBqcchXN5noS3lE257qBeaV+eWeo8BaqJiKHJmAJ9+E8RxVpSwry0AHn0NGGxbot6l//3X1yxUypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WggZMQRGMvBLLN/l4OKVk+UOI5pIZTPre3FttS2cZJU=;
 b=My9NZkj/9z7d4xWizM6sU/lflsHjy9y1Sh9MZbXrER41ySgkRQQ5XyQRJkiuczF9Wy2ii0u/QLbLkZAfUPhunMIHiZtm1eGAmZ9Vu7j/DvTut0lD3SrQLNNBUCwGt8nKcAes1n93uWONeVIB554yW01wR209ExNL4q3C0KXtuStVo4CUjBEKbE5l7RC9ev34BbTVF7Q7cGEEFyFeSBbSQMzM4nSCznirJWSQE9/r+TKDUtuP9Lmh4Al3YG1QrLs0E6TYo7uF4OG6GRzX7pfxfiBpyFjNW2o9eaaL4xoiqp7jMaW6inyRkvG2SeHoHFqd9NSexqpC0rphxZTulbLThg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB7039.namprd03.prod.outlook.com (2603:10b6:510:292::11)
 by SA1PR03MB8030.namprd03.prod.outlook.com (2603:10b6:806:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 10:19:52 +0000
Received: from PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55]) by PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55%3]) with mapi id 15.20.8445.015; Thu, 20 Feb 2025
 10:19:52 +0000
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: linux-drivers-review@altera.com
Cc: tanmay.kathpalia@altera.com,
	stable@vger.kernel.org,
	Chiau Ee Chew <chiau.ee.chew@intel.com>
Subject: [PATCH] fpga: bridge: incorrect set to clear freeze_illegal_request register
Date: Thu, 20 Feb 2025 02:19:37 -0800
Message-Id: <20250220101936.19163-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:510:f::26) To PH0PR03MB7039.namprd03.prod.outlook.com
 (2603:10b6:510:292::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB7039:EE_|SA1PR03MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: c218e065-c296-4c0f-ba77-08dd51981d0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6IYx0DHrfjgYMF2puKUUC2pGoGdha4ysY0aFB9q6S4MR3dMqZbQJTsbJ5Zc?=
 =?us-ascii?Q?wrtkiJ4FvlPqwCD0hWftlX9Be1hrYZy4C9xNvChu/s0kAtYZ6EQYzitkmbd8?=
 =?us-ascii?Q?KN7boHLpp1X63WFEayuoIjI0eo3SYN6h8FKKNNQlzJnfTRca90Z0G02aYVqC?=
 =?us-ascii?Q?P7tS3yWOAofC61Je+dEya5CGl05YcQ/onOszUtnocwLjKoQ0wCrk2gkh8vFz?=
 =?us-ascii?Q?TEvPtPn18RGdB/5TKTinMVsn0EUhhPIUWmyPC9jWc/GQX+VU60mm0b/hsWWn?=
 =?us-ascii?Q?jV2Cje7yQufsFHdVGoghbe67F/iwQjTAvxrOv/2po2YtTNLKLPXOlW/+EN72?=
 =?us-ascii?Q?+YDSIDRDhlEKSIelpyXqQNgaWj0jBTvB6ZTivSAtduBokjgjQMojiPt9amHJ?=
 =?us-ascii?Q?kQnX+qbjRo2b+SRFLryvu3dKdTtvG23zczvlaUEk+jgbmjKGa/PPM8uup96b?=
 =?us-ascii?Q?RMrWlMIYBBtEXUX7UiWEjtaE2LoK/VIlKse/Agxx4cWAsxm4Crf5cIJj1xvX?=
 =?us-ascii?Q?P9gyP3r6cQfSvFoFmBgv4VbdIWeJ7cWd6ZsnJrWbyraGB5rkkfTFnAhyvbvD?=
 =?us-ascii?Q?ZnhGJQAeKO+D1+cldSOSlTG7XQk3MVdoXWantenv02FfogRauc7Z8TgGo5b7?=
 =?us-ascii?Q?7jM3GxUmIta5egU+ksUhICvx1UyeZagUayTLyTWVbCGMqpUwC8+Nzull/sfU?=
 =?us-ascii?Q?1uudBDgusquVPQ7Vn/AzuF20al4Iem3FLHmpY7QrLb0X/WlQpHBZaLnF0x7n?=
 =?us-ascii?Q?LkBvi8DXbFbFBigoQGDmMcuopyjPerA1IFEL7UTsVV13mPexujrjm2coBs8G?=
 =?us-ascii?Q?BIFfSn+gpn4vzxxFh9WGnTIQrUzpDagQieMGJp8Ad0htSL0FECzU0SalHW9Z?=
 =?us-ascii?Q?3IgN6qfnalJhB7zm4WWiwFW1x7z1Pkw1hVLd2DNK1I9H45GTyvIq1xXagsDb?=
 =?us-ascii?Q?hFu4kSUlx3f/YuRyTpCcLUhbQbDmhPacNamhsOrwLxSuYCEAZ/XvUexts/Tj?=
 =?us-ascii?Q?DzFbvgVGBn1OQkU7bqh6otcGbJyERULePaVry+7SdKofLbU/R+vikyAcygXp?=
 =?us-ascii?Q?J66DRu2rhqqhdqVWVAruK3oFV4wBlRx3xy5O7Q63XLzckyPIB3FLeZ8OdLK/?=
 =?us-ascii?Q?lzrdk49/FtFjcBATeOKkPbMrBrTtRI0UhPP3NVD3lSRcyrbkuoFNc7l0+zLj?=
 =?us-ascii?Q?XD3O7gp7n1T27e/1jERyJPr4CxBMOd3gPeCf5MhEP0Yoe2L+wLuy5xbgibBV?=
 =?us-ascii?Q?a0IvUOzbymMXssydkzrOuCcWXn3CZFXr0irPSjxc3PWWJ0xHpwStxfqVVwRs?=
 =?us-ascii?Q?nB+dR+IuO4MUksUdlcriydGhkKwGLMhjIkeIvZ9+r7MU21RsAZgToSvwx4lc?=
 =?us-ascii?Q?ZXKYyR6UUY7VU33X71eMYyewARwZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7039.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QE69Emk8Bp9HnQT0z4WgOhq3MHb3I/UK/riSNOcRqvgIhAa9yro2CfJSpUfN?=
 =?us-ascii?Q?9Ao0EU0xW3HysJkS66kXaAZQ4je2ByoxgngxgjQQ0hMri5n9GOSlM/4B7kGH?=
 =?us-ascii?Q?LoQ5Ea96QvsEwlwacJJVgog7kQQ/cDocivvOciDqSfDhB9T9Dy9y19kPC3vB?=
 =?us-ascii?Q?5zmsIN7nJMGGRzn0vLiq9+fcdLQW7AX+RyNoU9nDA3taigfcT2LwXFRuf62C?=
 =?us-ascii?Q?Jb2lPUkyHUo0Zww2ht4f5cpfr6xV3xPMIA81nNe2DAuIKWPPOocPBfWz6CJ4?=
 =?us-ascii?Q?pRMvU8qkS8j9A9/+3+JS6bJoJC4IgtLvdwezd5cszeGlFF+LrHpPI7D5zS59?=
 =?us-ascii?Q?OzYzQicF2QA40c/P8D8+bwh/qqu5sMnEgfXQ19xw8pphSn24u+05O73NpYPR?=
 =?us-ascii?Q?Zc4uZy1TXbvB+cnXb1ukpAl0n+d8QDhNLks0o+m2R/OxW4twhfx4vP5DnIEC?=
 =?us-ascii?Q?ULgisZFhU5d6i7H7jFSUtoR6U0Qp8CtwGOKcYmRxeN6WN0YVXyVEw5CAZHOe?=
 =?us-ascii?Q?CC5oSnVF+W/DRYjCS3CkaDhRMUKhzWRNFOqUus25azIuq6Wtd7KVWgk6IiV3?=
 =?us-ascii?Q?gyEKK51c13d4io65s8A9YuoMJP3Yl8QX+ZM1G4VyIroBg3IKcUqUu93t9TAJ?=
 =?us-ascii?Q?JZE7Ctoh4b8bNhhJpSTwjHJ75GmenChVflexCiRvaNIu3J8+wZnP12Y+vN2J?=
 =?us-ascii?Q?v7tAr9IFtIIDXlwcuBxsc5wFgQ0osbzVrDlMf/F1foWhvpTaod0AloIHNtVa?=
 =?us-ascii?Q?gClDr7kW6HQpFvFAW8iY/YuhnX2bNzyJT7UA4ODmY2+iUshmkuG+GvBgSUej?=
 =?us-ascii?Q?Zt2gAoK6o15Wdee5G2TkbVnvHX2x35Vt9AbHBeEKoMGDCbZ/BIc+DjEk7ty0?=
 =?us-ascii?Q?xuB//Uq3/WimV2atGxU5zjh/FtrUC4AkjnSG7cG8TnvcSWa+5AmXzMR9Vbn9?=
 =?us-ascii?Q?R4I6EPRQtoM4DtA9IQgxyQgpM0Wj38cNJ3hBW7LUJDz7nCcnxGoiRO004l93?=
 =?us-ascii?Q?kev1XcLU/EhFTd82FOSgC9Q0chmaY70OfR3SQ4KfJ6PmSUZRXjvSKiA7MbbC?=
 =?us-ascii?Q?2YGuc8uRd3I7asz94SM4Cx6K8b2FsEqL+RmVAbPrqAmO8V+3kNReLBQVkOg/?=
 =?us-ascii?Q?/BViwabsAKsVGGRrZ8DBApqWuR3JLpfzPV5kH+TgnESNc4bnsCSvXjU7BbXv?=
 =?us-ascii?Q?/4F+IAjcSWAfqdv/iYT/unhk9j4tXoeUO6DZH2+U6ew2m3cVbM5v3KPVt5QQ?=
 =?us-ascii?Q?LtNC9q8ATju4gcpXCo33D4pv0u0K72jSbHxmTQHsOM/7+TSc1C8/O8ixLPcr?=
 =?us-ascii?Q?XcK6G9PyWKsVe0iIRAuSsTBawfVy/wWOAJHxgKlvWlWwgceffWLzhWXbRnSU?=
 =?us-ascii?Q?vXYrbgQsgnshR6jIc5G5r2J9y7339EWaM9DyiOysAQ4XYHy6ayAa+9mG3nA9?=
 =?us-ascii?Q?4Lw7OlI2xmT6ndMbylfmsRPQOLDWSebZwxeyMfnLcPf6Y0+7S1hfugORGzmx?=
 =?us-ascii?Q?W9sUVYS07zyE3HJVMFJ9ZVSAm5bvdbHj44bGLPpaj7iUs+YUUKu0Cxv8XZSA?=
 =?us-ascii?Q?7noFXhJtGERGh7VwutSKXWu7zNUStcRCGjBotN+E51YbSFIj1YzVNN/h7ndJ?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c218e065-c296-4c0f-ba77-08dd51981d0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 10:19:52.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0qJprwMdC10qr5/10g8t0ptCPoYzJm5TKrqaubE9z3B92MWDzbUXpf16h00mRV6bRhyEYfqIgSHc0jmXaa/svFwqDk/HAbWXy+th7dyiVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8030

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

A Partial Region Controller can be connected to one or more
Freeze Bridge. Each Freeze Bridge has an illegal_request
bit represented in the freeze_illegal_request register.
Thus, instead of just set to clear the illegal_request bit
for first Freeze Bridge, we need to ensure the set to clear
action is applied to which ever Freeze Bridge that has
occurrence of illegal request.

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Cc: stable@vger.kernel.org

Signed-off-by: Chiau Ee Chew <chiau.ee.chew@intel.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/fpga/altera-freeze-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 594693ff786e..23e8b2b54355 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -52,7 +52,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
 		if (illegal) {
 			dev_err(dev, "illegal request detected 0x%x", illegal);
 
-			writel(1, csr_illegal_req_addr);
+			writel(illegal, csr_illegal_req_addr);
 
 			illegal = readl(csr_illegal_req_addr);
 			if (illegal)
-- 
2.35.3


