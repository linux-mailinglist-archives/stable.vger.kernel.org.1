Return-Path: <stable+bounces-4974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6F809CCB
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A030B1C20AEA
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D9D289;
	Fri,  8 Dec 2023 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="lXuCKsVa"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF33198E;
	Thu,  7 Dec 2023 23:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaaLdgTYjWFLJKcNv7xux4LeAny/aBa5YtNL0ZfWZiWN9OcLE/BgofCS4qVL2NgC7ov01vVAbi8C25FntoWnwbuUBCfx8YHhD2tYVjyO2QvHfBNdR5Jekc64bqWspamdNaf8MZ82ttHSZijsDF70rcpDuV9v5Q5gm7Zxrf69QVhmclze6kAehktE4vu1DjZW3rtOBsaieFdpPfoKlmHVu/47ijnQFiJD5/9Cmrx8LwtQfgwX1N/cJ96cCjAZ0khadkFK43GBDDb3kZNDR8ePtkmL3+h0tK4l1YJ+upQQQ6ktHVZwVrFD6CNPVmgTkQCznvkj6LWai1UQogc56aTo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfZIFzmKtPdCedii0sdoysKC9m0s8CvbZr9z6MSLOnA=;
 b=MQQ5/2AEtJPmONq9VcjqZYQziBVFe8EKPjYZfqrz8skDzis6Dk2VJDPA8bI2iijxzOdbAwsmGYsZiGuAV8g4NkPHgr2DXFAHdVptoibOkGv7tGMSy8dOpdpy42csbFOBN6TUrDibE4SmezQ7igYWQzqqHHhOVaCCscldyuaTvnl17v/seS3tWkUAVUkPcxVgrgw2t1qK+I4zHi0It2F5K5xofvn/cXgcsFFfqybe3zJ8MA/qGovzZ4lPX9rSRVNv/DYDs9YSfr3Rtz6pueYQmRQpRHFuXxvQk53eks3OfpNN+xiHxZfgpt1GoG63NO3RbN697I/yLyBGWqKN5wWU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfZIFzmKtPdCedii0sdoysKC9m0s8CvbZr9z6MSLOnA=;
 b=lXuCKsVaWclcAORwRI5xA2mtn6yPgVeJGAXoTlW12vXMJPbvmYp+DSGHWsVEcS/GS4vXfea8VUtf6k/maoQPuek3E6Zu8V+lkib9oSY/xxpBCr1dfk78rN/YebzzUj0fZNCSFM5uauZterGxDjhcQpLth3B6dUYwE1/R7aLVysI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Fri, 8 Dec
 2023 07:00:28 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 07:00:28 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 2/2] nfp: flower: fix hardware offload for the transfer layer port
Date: Fri,  8 Dec 2023 08:59:56 +0200
Message-Id: <20231208065956.11917-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208065956.11917-1-louis.peens@corigine.com>
References: <20231208065956.11917-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB3702:EE_
X-MS-Office365-Filtering-Correlation-Id: 93efa8a2-7133-4e1f-0b10-08dbf7bb5c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6LAsqmD4i9bc5SNAbzVmV2Twccy1q0kx2vueOUoyAKRl+08+FFY9ep/HVuhE+JcLVPbDvpVxdEa25nKdl+kjrarrHoYfte5uG5jYdK5C0q6IE5UwwS8+VCGIT6GbC7jhUKVKHvtKJQOn1QRxo+UhzzwkpQ0ubcdVIb7GzKuqNdT0QHVsraxlbudhaeRo2MYKOjWtLdaZpVG9iavNzGdhxxtNzzFriXalGu7dvIsdvlbYg00uu2geTakXa26asKmh7CQfPoUbEdkutPIFO2qIMmlLYcyb9rVBGTqHQzuegFgPLgrm64NeukCAxmowQrpC7ydWWNtcrFDf30aqGqq91C1EZ11DO6oxjfTh3eENQUZS8PZFDRX67Rso0OSQLA4ofQf5vTuGl59CUCAAqj1Mw4F7snPSCYCD7NL4VdRxvJa1Xpo5s/c7d41ruaSVHu/f60L9TtfU8w+XzLIUopN5fh02QwrBlDOrd4DVT3xlgF9eRCtz84jUCqPHp1/52UweeyW+6baxlWnxBoDqzDTpTVGHTBqC87rw08oQ/h05mVBB+xidz55kSWn9sOWrL8LZzPGYvxUp640hxF4N1ziNzz/hBKGghhJwcc+kL6/rGSnC6OJXb3vJdIJ03pWGzZGkurV9y1YSOASGRN6g+YLtc9QFScB9BTDu+KjcoWXtmGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(1076003)(107886003)(2616005)(2906002)(66946007)(86362001)(44832011)(38100700002)(8936002)(4326008)(5660300002)(8676002)(110136005)(66556008)(66476007)(316002)(6512007)(6506007)(52116002)(36756003)(38350700005)(478600001)(6486002)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qr40p76c3KZ+EYE3CfpEj8503uEaM5L6gxFuvnEuNwP6QjdRsiQG92Dey8X5?=
 =?us-ascii?Q?tvp7qvFYGkCg40vptVR1UY658YmFj7w8KFJWz3nt+uZ6RvHjIUr8d3Zf29kg?=
 =?us-ascii?Q?tQdKTy8uGgNR02xtm9nSpZug1sORIHhjJXcHthLBa9DEuTw+OVefpSn6IrZ1?=
 =?us-ascii?Q?SYkZMbhWfck5CxrxM6PYU7cjN2+i3c2gBlik4Lx36Xs4Z2Hb1AjXIY577enH?=
 =?us-ascii?Q?aoQRxfqJea9lptv3VYqjE06OfFlx550DTGwZ5eaZ8ed6JNET7PWOSiVpzFmm?=
 =?us-ascii?Q?bXGsGzGuElhXO/SHxbeZW+MxhS0b9SYpAbCQdXrxZBHzIqm/1Aey9suSpZyu?=
 =?us-ascii?Q?SvuvGJO6rZb+DZBfMXRpC7vIIucw5y3EhKQZsEGVMvRO5/PWvSkNkLirrHds?=
 =?us-ascii?Q?xUzno1HCpWzwNKvTDIGvkTFX+xjpn2qbhDgoyiaR3Sn+Bb248DZ89jHYgVOv?=
 =?us-ascii?Q?A20q1u+ZFzp1L/gPaL6xeX7MiAPi4Q3vI1S8gGWMKDodnW8Z+t14jrPQ0KM3?=
 =?us-ascii?Q?F2ZJejFQg08qgRwubT7CEPXOolFeLn0B9QOoYhZnCdPWKCCpqzh2CJ6C8yqm?=
 =?us-ascii?Q?Y1VnqT1SFgzgop/I4YDxt44AcWMHUxccSlYYAJy3pvjFMTysq1ixmq79dgMy?=
 =?us-ascii?Q?QfAABruVtKI52DyFnR1rStWFq3wXy6SHkxOgOISy5BcYO13FyhC4hGt+mbwe?=
 =?us-ascii?Q?ciYuSaY+BzNow3c5vbEXonCfrrSH57UpNcDAM2zvH3deLjkWsa0FMx8WgP0G?=
 =?us-ascii?Q?4F/cu6/D5ZfrAnNP9PRnG5ntCIzYtjtCeO+UyZ2MikqOmlnqfeWpdZangNA5?=
 =?us-ascii?Q?rpItr9ZdWKzeN4PmC/Dzd8X6FwiIwyj38TIRRGdo/g5rovPX5LLRQ/bGVz6n?=
 =?us-ascii?Q?+Z4XW6QiJY3wCV6+uKjqBQ29bjwaQ4zmJkpEM3Sf/ZRy4ZWG30BeY/h4qh3i?=
 =?us-ascii?Q?Ri/+YJ4OZYc41mgYkLHkf45mHVazXFu83y3LOISaFIYny6AvusBtAIp6potf?=
 =?us-ascii?Q?AdT8BWhjrESSrvJADaqyGyPtr+hBXKLrUTw4QG05zGrCSsY7DFg6S4p5uHDr?=
 =?us-ascii?Q?i0tTSNrHW1OX8cVvVn0l+6ueMCx6VK0/Ia5stxr1Na/r7nClgejmYTRUE+Ep?=
 =?us-ascii?Q?IkoF9NTcEnj/TH0/DfUWyrO0OUnLyR8ZuXmMyyPohzlw7CABttfZxrJOtLiz?=
 =?us-ascii?Q?mYiGCFeK0L9wSeyh1VlRWtOIiPofl9MqCL+ZujmMiW/aHkFQN1QskWKsGfir?=
 =?us-ascii?Q?ENOfrp57PJ2pXn3NTAsnpyJC5FfPWeg92yeZkZag8/TGkLMzCVE8GQEozcZp?=
 =?us-ascii?Q?ZCE606cLC6Wqf3ehBIQoVgZPg8Xu4DmP34UkT7sKy7lPFvCHneL/Ls7rTBi8?=
 =?us-ascii?Q?RkI8+KRg4uNAfBI3GAX2Py31U2ShD/5dUcrT2zsY1FI4ooGk0/VFTV5pCNzG?=
 =?us-ascii?Q?6BGzwnVE+nHN8aQg7H2L0R998lq55xSuBeAHpi5loBbyFnYy1J5mSrsOKSCi?=
 =?us-ascii?Q?WcKDfjS7F4hePXUeX9N401URh837FAYw4xM0cyJwWNbFSMRGu44HqvKQ3hrF?=
 =?us-ascii?Q?S+9/t9t9amfhd1fOhVq8HCs0sdOQq88idFdECTbthJ/lhdgMDFLm+5DXe0/J?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93efa8a2-7133-4e1f-0b10-08dbf7bb5c4c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 07:00:28.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAD5gyTQT86UdLNAjt22di2q2EJrZL/nWKkMh21V/bozsw0vokLLQpFBzJWkfIAuUBamKJ/HmHLHVUTsRufqTL2cKXOz0h+KdYQlgfOplxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3702

From: Hui Zhou <hui.zhou@corigine.com>

The nfp driver will merge the tp source port and tp destination port
into one dword which the offset must be zero to do hardware offload, but
the mangle action for the tp source port and tp destination port is
separated for tc ct action. Modify the mangle action for the
FLOW_ACT_MANGLE_HDR_TYPE_TCP and FLOW_ACT_MANGLE_HDR_TYPE_UDP to satisfy
the nfp driver offload check for the tp port.

Fixes: 5cee92c6f57a ("nfp: flower: support hw offload for ct nat action")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/flower/conntrack.c | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 726d8cdf0b9c..8eaf3b1611a0 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1424,10 +1424,26 @@ static void nfp_nft_ct_translate_mangle_action(struct flow_action_entry *mangle_
 		mangle_action->mangle.mask = (__force u32)cpu_to_be32(mangle_action->mangle.mask);
 		return;
 
+	/* Both struct tcphdr and struct udphdr start with
+	 *	__be16 source;
+	 *	__be16 dest;
+	 * so we can use the same code for both.
+	 */
 	case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
 	case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
-		mangle_action->mangle.val = (__force u16)cpu_to_be16(mangle_action->mangle.val);
-		mangle_action->mangle.mask = (__force u16)cpu_to_be16(mangle_action->mangle.mask);
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, source)) {
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val << 16);
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask << 16 | 0xFFFF);
+		}
+		if (mangle_action->mangle.offset == offsetof(struct tcphdr, dest)) {
+			mangle_action->mangle.offset = 0;
+			mangle_action->mangle.val =
+				(__force u32)cpu_to_be32(mangle_action->mangle.val);
+			mangle_action->mangle.mask =
+				(__force u32)cpu_to_be32(mangle_action->mangle.mask);
+		}
 		return;
 
 	default:
-- 
2.34.1


