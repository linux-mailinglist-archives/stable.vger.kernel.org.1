Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E084735992
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFSOcN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFSOcN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 10:32:13 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA83A0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/AVHpfOjD4cAEyzJPtjJMORdtI71InI4/NFQrYnn0LGz9LV5r/052h8u+z6hVyrmX+LYgRSiz5m4OCjh19D1vNhSedUswfZwuib7H7VvUr5bL2OxIfBhGJ5WLccrhq3iCXV5OcOGgj1C/+bJn9AZIIY8g9egL+E2/iHycnvmcRklhhRGWd4h8OiL6S/Bk/vVmN9Gwbd1B2tAjXrR+YXz69cVTUJeeT3EDt996+MVH8VRQBTNRUw0TsI//wxbwW3ZRDVS3/3owxn8kZDxMy58YBU1aJiZvGgTWJDRe2OLHFAtBZdgnyoQ9J3ZSKneepTAdmAiHWYe1bOP4cLsiU+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZc9+N7Hm9Vmla8GqnmjTOx+uI0JpYRbtq5EfVEllTs=;
 b=oXQbC0o78xWrh+M2F0JoRbdmAoLoTIXSzInZAqBKIs90NReRgXTtsklVUqEcBN8dBwUP/HWxtC/PBFpuIdSWLgDhE8h43UX1Fec3Jyl5yNMJBeDN6aSEmzyWmmQPcGGFKc6UtnF6FQaQsNw85erxPcem+odKjsSNXL4L8GXG0WmA1EER9M7p4Kzwjt211sYoR3IqDjwfdkjIMbzRNELKC3zlt0p1nz7byuDq096PScmyEUbdArXe2y1DpaXgzbE92MCKAZPTqS3hifMGD/XOP4CQHYf95TNheeV14JeCWM+BrJBeXrWzkj24RBeBV4Q70j6m+lMpKLZ38Ufb+A5EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZc9+N7Hm9Vmla8GqnmjTOx+uI0JpYRbtq5EfVEllTs=;
 b=Vg2BMe20B181deNZVtYEXErMVS8AqPIEYXTIez+DFOh79VBLwiv801FVDFp51LW3gv/NblVWqNy1SiHY+RfINykTsFVTkWF+aNHZnC/fdhAPGWoR2MPNHw5m8mEwJWxFdNh3aiwlIMHK7x9I9K/ooIGqiiaYgyuGci17+bOBbg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PA4PR04MB7983.eurprd04.prod.outlook.com (2603:10a6:102:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 14:32:06 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:32:06 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     vladimir.oltean@nxp.com
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        stable@vger.kernel.org
Subject: [PATCH] net: phy: nxp-c45-tja11xx: fix EXTTS flags checks
Date:   Mon, 19 Jun 2023 17:31:54 +0300
Message-Id: <20230619143154.240282-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PA4PR04MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9838f996-a007-477d-f230-08db70d1f528
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eliiXhkdVFXC/P1A8jV//e1pEO/4VKF0YBo70kChN5Z3SqrIOvBwJiIOz5kNnc8F1qKKBE5mL1QBH/fq18vngFM7By0VkWtvUlfB2fbl1JU1jhq27kr01G5CUMJxno3anrl7CVYqkQv5gJ9lLLikcqCt0m9ITt6tYMp1llj+5/lkf74HDeTDnlPy5CXGts7LxTFxhs/Nzpk2rhveTZovT4eQNWw+ef/UGKjHaFnXmLHzn/KhWpd8DiZRyE2Jv1pSqADm+81Hmdg4+lx1fZgB5S8ACEIbons5xPAWJZigOXDtcMwSxZ4LDjU1jNMfC8Vd0SMM61IWRzc+yDBsPWyP0UkLGkLh8R0F4eb+JvUd9JTSkWPylxc1gZ8SQggVVSGKxtB1sebB6ZzQG+S9GjHXFUTHAHQzldZmz5+f0cLShNrAURm5iujWN3vWwn/hfQ7OFXLBzB2fsBOf+K266Z5sfhsfoAWRLgKt0tONgV8+bj7Wrqjhcg/0vkNfp629/tGpk8ntfWiHrrYWzYigTZlOOpAtBXqI/j/E1H5hICjug0aMCgbRCkJBTVNkSJJl+GStv95mJ71619gEAew3UsE8f+pu/0bkzBGkFbe2+qMZB68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:ro;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(2906002)(478600001)(5660300002)(1076003)(41300700001)(4326008)(66946007)(66556008)(66476007)(316002)(186003)(6486002)(34206002)(6666004)(8936002)(8676002)(6506007)(6512007)(26005)(83380400001)(2616005)(66574015)(38350700002)(38100700002)(52116002)(966005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0F6U01tODU1ZzVMQ0dBUHFmZUdaQ3BteTlzei9hUmVWbnl4cU1RNjRpYk9u?=
 =?utf-8?B?VUEzSEJvWkc4NllMeXVCc0FyZXpHbUQvUnY2THJrcWlSZUhvMUZoeUtlY3NU?=
 =?utf-8?B?c1pjTkNjcFBDTldxQkN4Y2kvWjYvWTZRUSs5dTlaVkVYUEF2V1BMNFdrM09q?=
 =?utf-8?B?MUVWaTVCb2hsWENsdUZjOUFid3QzeHA4WVVleGxyUng3Yklna21UVmN2NGM5?=
 =?utf-8?B?RVlCdzc2YXl5dmxINmxpcTRrOFZuZGRnZkpTdWVjMkIrWnZ5YnZJQTNycnkx?=
 =?utf-8?B?MUdFdEpsS04rVjdVOGdDZXRDMU51OWorRjIxRjFncXBMbW1EaWwyRHFqM3ov?=
 =?utf-8?B?SzZmNEZEZnp6SW9hUFhqSjYxTXRBZjdHQjZTMWZBd3MvT1ExZG1rY0FrMlJE?=
 =?utf-8?B?VzlwclBDcTVsU2MzSDFKT1F2RFZoemFrZ3Y3VmlRTW54N3R6enlnamFaS2My?=
 =?utf-8?B?dVFhZEhuTi9KbitJMEVtOHlyYjI3VjJwM1diNjl4YTBsQUI0aTZCNkpXUko3?=
 =?utf-8?B?ZERwc1JNRlJiZkJzai9oQVIreTN2TXAyUTN4aXRLS0Z5MWFiT1ZCWkk0cmda?=
 =?utf-8?B?NlFsNGdqSVlWVlZ0RFIva1dBUlN0SUVFSno5MHplaFRySFJmTnkxemJHTlc3?=
 =?utf-8?B?MlBCa1cycFNQU3RmeWRvZXNvT2pwTjg3ZTZtVTVDWkd5cCtEZnFGNERmL1Nz?=
 =?utf-8?B?WFhGWTlnYUVLMkIzZ2Y2TDM4RjFoVERIVHNvOTYzV1BMdzFrbm9iY1ByalNm?=
 =?utf-8?B?d0Rac1VUaEpvRUpQdnRxcTI4eThnZHZaaER5VUJRTC9KR09GdzVzTlp0YTlY?=
 =?utf-8?B?dUpaRStaekdKdndKZ1JxUmlRdk1yRTliQVRSUXFENXhucEZ3NitWdGQrS25h?=
 =?utf-8?B?dXFkcXRuVk16WVFDazJwcFZmZk8zODZNTWo1N0JEMXNzb3JsVW1xdHlBekdV?=
 =?utf-8?B?em15VVA5UkxIZW9hZEFBYVBuVlZDcjI4L3lWQ0NWUjh3QlNTL1pXdnpDTkIx?=
 =?utf-8?B?NkpLcHBPQ3Ezc1cvdThNRndyRGZWOTMweTMvZk5KanNSZFJxVjVQV1JFU2VT?=
 =?utf-8?B?ajZOcENDUDVWV2xNc2llckhwek4rUG1odFlRUk40dHpzZk43V2dETDdMMEw0?=
 =?utf-8?B?YmtoVTBMK3A1enpHYklDeUtqYThPZk1JMlQrZTJwU1B0YnlETW5uUVl3MWdt?=
 =?utf-8?B?Z0JybWg5dEI4Rlc2bnRoUDJKcDBPQU9NbUdPMTZLSm5qVlduemdwZk5xUHM3?=
 =?utf-8?B?blNjdVZyNEF5VDh5S2VFMHBzMnI0Vy9HQ2RwOHdmYzBUK3BMVVBzQXJmUGRt?=
 =?utf-8?B?WGlEUjhNa3lzTFUzV0dUQm5CU3p0Um9BUkFSVUtWbW5XWHlRWWpiU1NkWUh0?=
 =?utf-8?B?WFNwaDAvZWRPMkNTRkN2UlJaTnBkQjJEbGZUWXN3U3hTNFZMWnJKaEFBcUNY?=
 =?utf-8?B?WWkycCsyelJoSmY0MVZ3b1FVRkJXT2VhdG1ENjZmc3NkcTJCaGtQcmpodGhR?=
 =?utf-8?B?c0xtbEdMZ0NTUFhSd25odndvUmwvVXRhcUdwZk5hTXl1OVZwcmtjSEVrOEhh?=
 =?utf-8?B?cW5iYUFFbTJxUkVUcldXb0dIaExSUXM0bzFzWVlGRGd5NGsrckFRQ0xTdzBw?=
 =?utf-8?B?ejlIa0ZaVkFyWXQ3QTJuS1BsQUFsT09BMWJCTkh6V0RLS0VYb3F2b0RLV3Zz?=
 =?utf-8?B?NmM5clJXaFhYM0tubXdwTUtpUS9HQlFOdnRMeEdXb2N1a1NVemxWZ3ExcVpr?=
 =?utf-8?B?ZEYzbDE5YUp5bHpxK2FWU0U3cEpZa1ZwZk5tNWpJeGxnYTVDVHVXdG1aUC9U?=
 =?utf-8?B?ZzA1ZUhqY0R1K3ZLbm5TMjQxa3kyNlpPdkZmeldwWjU2bkJ5RlJOVUFtZWVl?=
 =?utf-8?B?UGphTGY2dWo0MTJIenpRUlMrSkZzMzZTSnBWWXl4bUV0dXY4dmpYaGorc2tR?=
 =?utf-8?B?a1Z0UVRZT0x2ZXpsVS9GdVN6UEhOa3VRc1daa3NuUXZnV2VCcWxHN0l5UWxD?=
 =?utf-8?B?bnR0cGhEcG9OZUFkTHhTTnVPZnIrdk9SRGZPUGVFdi9MVHJoOVZrYmRVNXFE?=
 =?utf-8?B?ekQwUk9BQzRTdW9uait6TnV0WjZXd3JMMUJudjVVSGpxSlAxOCtHRlEzSXVH?=
 =?utf-8?B?VHdTbWFYOWlna3pGMXJFSFVub0J5cThqeUdNL0VRZ2dEck1zemZSbjkyS2pQ?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9838f996-a007-477d-f230-08db70d1f528
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:32:06.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRIps73tB9pC2zMsW1TaSSzzQ+5hJiKWSqPtgKupJayyat2Aa4JSJW2Pv3jW8fxOgEJBq3R1NiU1uYP3/t1WmAH3HGqGqhl6xUyzfJ9BbnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7983
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Mi-am dat seama că parsam flag.urile prost.
In primul rând, mi se pare gresit să enablezi ceva dacă
PTP_ENABLE_FEATURE nu e setat.

În al 2lea rând, dacă nu se specifica nici falling edge, nici rising
edge, functiona cu ce se găsea în registre, ceea ce era greșit.

Zi-mi dacă au sens modificările.

Link de unde m-am inspirat pentru flag.uri:
https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/ptp/testptp.c#L65

Fixes 7a71c8aa0a75c ("phy: nxp-c45-tja11xx: add extts and perout support")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f0d047019f33..ef4acb8eb0e4 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -595,7 +595,11 @@ static int nxp_c45_extts_enable(struct nxp_c45_phy *priv,
 		return 0;
 	}
 
-	if (extts->flags & PTP_RISING_EDGE)
+	if (!(extts->flags & PTP_ENABLE_FEATURE))
+		return -EINVAL;
+
+	if ((extts->flags == PTP_ENABLE_FEATURE) ||
+	    (extts->flags & PTP_RISING_EDGE))
 		phy_clear_bits_mmd(priv->phydev, MDIO_MMD_VEND1,
 				   VEND1_PTP_CONFIG, EXT_TRG_EDGE);
 
-- 
2.34.1

