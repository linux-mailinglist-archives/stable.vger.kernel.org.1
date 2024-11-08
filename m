Return-Path: <stable+bounces-91910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 936829C196E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259B61F243E3
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A31E130D;
	Fri,  8 Nov 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="RGO7uzB9"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021097.outbound.protection.outlook.com [52.101.129.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2219259F;
	Fri,  8 Nov 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059014; cv=fail; b=GJ93701S11pXVXEn/QnSvATeWvU+p+92aX546RMmrJhDd+sIEIkqXH2NJgFRJT7SjTgn8M+S7qYvFqum2XjAcM09ahMaWz3gU6nEaFEZsJbxrZwy9SPR47ByUzBCBSuwZuhrpLcR+PCA04zUyqiGY+9AH8t1Hc45cIj/nvoG8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059014; c=relaxed/simple;
	bh=58oMrU8k7+lMiUYFm2l4X8ULOOv0bt7+DT7rM5/Wgks=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LClJs2YHXLfLkSYLaMV4EyfCaynuvuekPDg5oyM/2Cci/jv872jFCjBAFfs3kRNGbyhp9njQBOrckvdQESn5FGHT9P+bis85lWO12Pn8LYca/VVCzPResYP6mneeOh6i6azCYTDHhs7bv2YOGo3WZ3RgPk02yuDTenzJOP7rYWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=RGO7uzB9; arc=fail smtp.client-ip=52.101.129.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpnM2nJbBY7hMOR3qt+2sBV23hha9jO529jO4Iz1kr/r465mk3dsrFpdNKKz8iHRBGFyzQFffXuTdl2cWuIcplHVMVPLAox4gBTRwoynMR+73VDm9CwHpaBjTf63YVT0f2Kj84KqPfeQFfbMal4ntA9W4LENoOY1tYU1wK/tr31oeDRWcnMMrcWJj0x1UFbrZTtCjurizibU3XKCI5d4AMDyP2mXyAajSqk0ZL8e+ccwPheTzTrTuCcSl85iphICt/owwUmh96rKVUujafHZVqDL2TPxh+Gv9UWVwQCysqpgEbWFCWOjowdZnJo4lWSpn9lm1iYWBB3EU2M0YRMAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l43zYyZTj1cDtEQYDefaWyfOSzDF7u7bOiidmzzcZ0E=;
 b=v/2LHB48d+7hPm6a/nS5T3HErjjhoDofvWAWEtPgIbd+x/pWbhLhPgAEJvsyCwtkXX2frQq/z6mlhjxC16DjKfcUSxW/lq4w7v6KI8IHaHyHg2n3GQUydfCp999PLhlh35wn2EB6nb3EMz2J3kw+WOfBEitOJabd24jucGcNA49+sa3p6x09G98G1nMhUCh5tp25mm6B2jKWnbzC9v5mi7F3crZfKJBnRHn8hZ6WC5IZUy0iu9JCmIQ98HbQmthlevx1mdrJqQWJ61sSr87qfeXnX0zBLEcAlHbYGhRv5F3ffoQj2HS1ssS3USeEk9I6UneuHE3Jr/ZTieA4vIWc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l43zYyZTj1cDtEQYDefaWyfOSzDF7u7bOiidmzzcZ0E=;
 b=RGO7uzB9xUKn4Kw7Df69IE+J4lXNxrMnnjcgG5OvfcwsuNlOfbXF4I4Ju4Cw2H+NFu8bE5eM/nEBEfsUxSmLeQrtZMSl8sxmcL9JHTRCjnPrf10mLwhDLbwvC5YatWAYZxkPTu+VqEekEgENF+aGncnnm+T8nxeCRsp3hkAv6xTPF3Vm3h/FPZxC3X/MAzZkxrIR6F7wK2P4iXY4dpj7CW2BRmMHewFrBHeLuqs00W5IHtp7wOtT1pnvWmz1rJeA4d2j9CeyQkh/6wNNlJwgi2XV82wjU7TuqnhHnBHl6/QqmPn53o4Tai7WAE2uYbDJyvM5I2hdlZ1pBWQ9S68sfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYUPR06MB6121.apcprd06.prod.outlook.com
 (2603:1096:400:351::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 8 Nov
 2024 09:43:25 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:43:25 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	stable@vger.kernel.org,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH] USB: core: remove dead code in do_proc_bulk()
Date: Fri,  8 Nov 2024 17:42:55 +0800
Message-Id: <20241108094255.2133-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|TYUPR06MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: de7ba735-2059-42e2-9250-08dcffd9ca4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yD/SFXW+/TURzNbhYpMJ/LYgBKFHEMYH+I4lxWD52z4WpfjcHvK0GwQWO5wk?=
 =?us-ascii?Q?ZdhFjL4GFUpEghLnYLpKsteDce1KJdHWVzRmt22kYoVMIK9e36aFm8GodMpG?=
 =?us-ascii?Q?O/3DE1OTlsLlHrV5PyHGpYiM46XBRyq9Zv1U0Su5bYpVIXnLzLVjqYj1KA9N?=
 =?us-ascii?Q?am+P2gRxq9hNjUm8wLwK6GkyTUQrcM2nS4zUHkbUQLZOgiP6qdnFv0BH2XwS?=
 =?us-ascii?Q?chcR2nlZSTMDglQPGkeTFguhn3NPSUg4CKW6m8F1GhKjlptDaTbz5G7FAPiZ?=
 =?us-ascii?Q?hyJmnZuLKcz915Nwlna1MjcOSjElA12hZqiePpVy8e6T+0tr0gIog0YcucOX?=
 =?us-ascii?Q?MbjKBEhVevpLfdp49ICxQlHb03RfL61cHOM9Ozx5XqYDq2BQmbBtPAc1aC4k?=
 =?us-ascii?Q?JdOgqfXg8n+IG5G5IT0fCVYDgeZz9992GgD4JpdbiOH2EGRprwTH23RSmIf3?=
 =?us-ascii?Q?GH4NQXX1lytl7Z4T1SH3sxe7kbJJSisJHqrxK6gibqwKFR4tMYIz1tQJi3JB?=
 =?us-ascii?Q?gCtSVyjZoSfsR4HGIN/Txp21jVwwCElIN9ja6OrzZyBx6t+DyPA+SlniiuQL?=
 =?us-ascii?Q?aLmvnl+L+3SHqw4myelbBul9TH8mCoXG3z+1LnThn3i3en7AB7cVZuxMJV91?=
 =?us-ascii?Q?yo0zuLS6SCxurj8My1Bf4ar9cqwSrGRQjDCIg0cgX1zIo2jlu+0wJdK/VsSV?=
 =?us-ascii?Q?7w9dKS/eZQ4hxe7ROcTFEFo84c9yMKeCD5rlOEtS2aC3JaC0HMwKeBwxo/v8?=
 =?us-ascii?Q?8EOxSI0h9yMQekuO7Yx4B2h1b0/xTX3thRt8Q+vRuduQnG7OwLc/thjxz4cE?=
 =?us-ascii?Q?a8pI54u8ce7s8zStw5oH4MTmlpsMcDhfDUHFy9x96X5vciKgROcUFvCRGx5N?=
 =?us-ascii?Q?eDGxJiQvhQ3jAP5BN7f/HDDg0h2h3qKYSEXTVhjgVsxXgL71Gg9yyHVJsgU7?=
 =?us-ascii?Q?U/vdGZMOeC2xQR0j042s/4xQ9TkPT/6tcr/DPJcz9hsgHl30wZfrkZoC/9pL?=
 =?us-ascii?Q?xVJcEap1EDZ8j1rl3+NRUl3m7XaWDsMTScuhm7k0AnTrQjuw87JAQIDDBITl?=
 =?us-ascii?Q?R3X9tCH0xrihr6CMEBrGg3wFD7ZpD+ETL3btRNyTmdytBGB5FxzwTHokgJCm?=
 =?us-ascii?Q?rWtma7hkD9tX1a+jrjtOFERSGlDhdVAGUyoIViN86JPLXOcSZOLB57lfsFQ3?=
 =?us-ascii?Q?DvMcgJiTaos71O6ZZKHN693LpBGE4pLVebF6l9+WPTxk3c32riwMgIi5Y+dE?=
 =?us-ascii?Q?lL4aaCwXM8e6041iGvzWIkaqZ2h2Jq++ipaLSur4PpXrhs6qask5edhqMQuJ?=
 =?us-ascii?Q?tJ9FO1yATtqLnUUXYy1/QMGIPhEaH19GunMTHqB2FWE/DjvHQrQ2iZFjmFkD?=
 =?us-ascii?Q?5ja2bws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GI7Pa1jhhotAZ+bSjSDam9OL8sp72ojSrfIIXPA+hSUuLdqKn//kTODq4gfp?=
 =?us-ascii?Q?FwAoMrlWjV0iPJb8cy3i5aAUaQQ/juFo2TILz+T/I74Cvph5TLdTk50CKzYB?=
 =?us-ascii?Q?9ucKqxVUcQwVKrSWzRg/PXu3GBl2BQIm3GtyKecoMdCp9V3dU3hCmjL9t20s?=
 =?us-ascii?Q?/+EC3FHcldHvK4sCl+gwXi929sKkekMi2IKjEZc9fhEX3cdTk5rWBOHfCMkC?=
 =?us-ascii?Q?WL+sd/4zc9L2DR36pLoLI4xsx4QNqYyZ/336tysOzVQmdlz6k9Nru8OiwgEV?=
 =?us-ascii?Q?2BS5PWGjnN4Ma6BLeu91aARzkIRMSIIbWC95MHazECoQlHWY6CUarAhojW1X?=
 =?us-ascii?Q?l9UdQD09mCsc2kFRU5Q++jsZUa4erzMlYt1x/JgDe9SM3R6YtSDH9kDKa5Ib?=
 =?us-ascii?Q?ORtx8ESo4n6Bp4RQiTugWCxAKj89GCvJjLW9v4kIcnofH8UXGDtkHARYaHym?=
 =?us-ascii?Q?vRwmLgHitgCXXgX7uR4BDxS1yHIDLleh7D8FzDY9aox7/NcH9JB+64jcyvGH?=
 =?us-ascii?Q?B6Xx1KcXCNLr0tUvLW+YLh3mOfOGZ4jE9+k1FhDWqJnDdV4OSvmFEgbnxDzf?=
 =?us-ascii?Q?RO/6M9Q9fR1tV0jCd7Evdj1wRG0eN96EIUbiP94Vw2LKraCKQWotu+li26bU?=
 =?us-ascii?Q?eW9H2iTRjQWtSgbT4IUKAicqqqOzC+PVIj38Coe3UyvHOnEctHLr2TqrhgSI?=
 =?us-ascii?Q?daBwMCvslE4bjeKfJYMTAsD+sudsqinIjB3yj43tvVNf3keNU0RraIq0qLaN?=
 =?us-ascii?Q?s3+XAjrCMI4hmZ47qpiAccrZeXmi5qq/IKom3DIeXYUYoda1V+k/KhE+Zbv7?=
 =?us-ascii?Q?KrWt2tWVoubX0/j7gfR7s3Rca5dnhSRLmTiDtXrhG4n52+SLfrGEGKIFxana?=
 =?us-ascii?Q?3Fw1H1Pgf5hVs43HAC70OmEfRe5bWFUyQ3GkidhDpjFoDk4SZuvvJkPD7Wap?=
 =?us-ascii?Q?slTrxmXLVqmEojVKYiJO7Fn9pKI2HJZUs0CFJVjaJ6K8bABL744QgcETdh8K?=
 =?us-ascii?Q?T8SpKYzI/4BDbc8HZbVNj5i9tsaNnP/Pkq3aU6C3Y78nmSnah9ArepbJC/HN?=
 =?us-ascii?Q?FVkGpnrKd748lxrQTWVL0ISiqSssiAScUy8LMGRlDFC5mqZ+fDhiPj36q6OP?=
 =?us-ascii?Q?UVlAp8o/DdaFrQUcO+fu+HlugSLdsW6l9eiFHggeoi465lKoZLxWp/8dU4TH?=
 =?us-ascii?Q?el2bSJwpuArt5GMuZAyDH4Ze9GWdM9kTtjLQbG9N8jhzOR5FZvq1b8tK44Am?=
 =?us-ascii?Q?JAId3Ee7GEuioczYr5nR9atbO0eAfm9qAV4/i5Mu/fw00l/FXwWwv4ARtqIe?=
 =?us-ascii?Q?KBJ5NRTVHnDanqSTRHYW2lm5b1SZlWKGW53nG9I7PaO4k36C9v7vsxFTsf76?=
 =?us-ascii?Q?5e1qLW3nKfQalGgvQjAj22z07W95b41IdXAdN13SeqUGQJ7Oytjl9+q25wem?=
 =?us-ascii?Q?GPpM+XoMWTasaH0w83arSC1yw6GNc88P8qFWpdh7f1DOBSeFaCS+3L0ZE9Ic?=
 =?us-ascii?Q?T5cJpDnpA6ILADcJdvE9/tstOrH7oYMhUJKF8jOEI3S/z7j3KQULrcI1LPGW?=
 =?us-ascii?Q?pxs7f3cyiPICJ0zS8OKudnJHJ18boQufatbyONGLB0EPIoZ5GNrd0DXJgrxc?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7ba735-2059-42e2-9250-08dcffd9ca4e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:43:24.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rCBXEf2pb1DaqjV6m9vsotVJ8eb/gIzDXHiLZGqVBsa0IsJY6mEQsHG7/vh8eBBIvz6IktNbHTOExzENk32KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6121

Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
simple.

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 drivers/usb/core/devio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..712e290bab04 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1295,7 +1295,7 @@ static int do_proc_bulk(struct usb_dev_state *ps,
 		return ret;
 
 	len1 = bulk->len;
-	if (len1 < 0 || len1 >= (INT_MAX - sizeof(struct urb)))
+	if (len1 >= (INT_MAX - sizeof(struct urb)))
 		return -EINVAL;
 
 	if (bulk->ep & USB_DIR_IN)
-- 
2.17.1


