Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157037A2585
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjIOSVn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjIOSVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 14:21:39 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011009.outbound.protection.outlook.com [52.101.47.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3D1FCC;
        Fri, 15 Sep 2023 11:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZWpOaCrVu+F4fKTkitI+I+bnHyExZ+3GdItUCghPUBKy4oRrsErqWLG8LFDuujbq/sVDH1EmmHmy4GLc7G4hBqs445aKqwW+bNN4W9rQ1vvuyr4M+MMyTenURagxq+QWjptFokOMZUuDp3Y5rqbtMcreRvmoixHc04tod7XOPDcTr1orYq0aeH2Mzz+vTAdNfxz+kSedNXyd+/mUdoS6WZRMm4zpuRPuROzRgOlEd1j7Q+srPivk1dMaO6jjhQs0jdHfhESSbuN9zrf9rZzSjLbJZ9rQy25fa7bvKG4JVkKtR07cn52xTJ2wve3ZJk5ZhGXJ5ZoHvSXQvDIVRHchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gpuol7i9B+wrAAh/QYulUU49oIJcic4VVqUilMPcaA=;
 b=hWSLwBwSWfdfkDGm0famYVF4ErMCpX4jeSYZ2xGe2ZSUcarWvi15MzkEhY4JQ69+aFnMF84NHSqKpB1rbsHAoL+1T1GyYHURHyPOkr1HtVbncz4NUy7O3Ee+XOJDZmbxR9boBHlttW5gCVmlKoQUKXwCs7TR0fS8U8R/zsCY17Q3/K30M9TpOce9Itpnt8/P77C+UbiGmNzzgB33QESOVw4hHBu4lp773yLCdm7RK8E3iWk5Reyhn/Pw4VLEQZc2IZWvcCPJdQ5+bgnodJCpTHsyVvOOJ6rdo6mAvWKoqeDpmIEOWJnWtwZfcSa+7uRlJUiXInWnKQNvc3YES86w1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gpuol7i9B+wrAAh/QYulUU49oIJcic4VVqUilMPcaA=;
 b=TW72/PyFlPNavToxUqsBcysz/HlluLDWZ0BHLVNc5jPiYmtb4lYKH5ED/sNcC0D7zedDljT85mn4Qvt99tBibkJ439rvTJDDajIwy0WFvdSCu91n2q4XjiLp59n43muv1GHPiN+OavbgxuUTvlxB73TXDjH7cASAvcsrAwlituo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8238.namprd05.prod.outlook.com (2603:10b6:510:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 18:21:31 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 18:21:30 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     stable@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexanderduyck@fb.com, soheil@google.com,
        netdev@vger.kernel.org, namit@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, er.ajay.kaher@gmail.com, akaher@vmware.com
Subject: [PATCH 0/4 v6.1.y] net: fix roundup issue in kmalloc_reserve()
Date:   Fri, 15 Sep 2023 23:51:01 +0530
Message-Id: <1694802065-1821-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa4db99-5122-4b8b-364b-08dbb6189580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfV385BtIt20Yf5+PbymirE5wUf5zMj1WLJulnkQ3dcDQroGmJtQu6pMBWtAnb5v0nEFGaAthk+gvkzCkrw8NsMQG+dV3pi3NqNJHIx+29pVO3mtiAX0h790Fsh1IuwWm7zg3sWn+2dM9+qAAL4fSIfh523NjRrFxa6c3Yvrg6IOuDHoYY4D7kI/5l+ZShFBuxgzh7g+/HPTsqpJ+6vL6zl6EYnUH6n2y+WbXmiEphHPmtyoxpkNNf3SCGYiZ/+wyFcAvJQdN7AimatFQec6YxkEWd65yzFIW+Q6PoZOYFNsYc6m0ap4RMi630oLffqutoffcfQUgC0RtX5qtJi5JO+1yPnFTis5p+2CHlLqvEUcoHUuAR9lwBr8FxboFXJqjmcr9i3Gg+xIEFHIQJiW2LyWoujTwMrVjM5vqNJaa2G3US/aG/rpEbf+FYRbCQQBUneC1G0fbd3ZyhnKqddDnWnGF/KVQ2u1T/KEF8M7IoIAvRPSNgTu+5CTC0R2u0wMixdTgP7WtQNFOcgAzeK8Hs2zZ/6ScbGAvkaX8P4olDJ/EawGJI9wWrFxtmaLB8pA8/YQHclyeqImPGOZnYABB1csgNONRRvXiLtcP0vZc4aLQ2xFMCBSf2Y5pWEja0QA8UJMAesaUpDF4fc0CBRAl8Do1lI703pmUfBkPcnZOXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(38100700002)(107886003)(38350700002)(6486002)(52116002)(2616005)(66946007)(6666004)(478600001)(83380400001)(86362001)(26005)(66556008)(66899024)(41300700001)(2906002)(5660300002)(6512007)(8936002)(6506007)(66476007)(36756003)(4326008)(316002)(8676002)(6916009)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBcKyWCXL7AMUci5KWsW3l5satLPPe8sQKOOYqaZq4KYUpJYc5AWhqJOC93t?=
 =?us-ascii?Q?ALepcgzpy8qzac45DMmpURypYn62wPXJoN3XBl0INJ6DlbDHGaNDBLzDL1HR?=
 =?us-ascii?Q?Z3qoNP8rMqD7AX0ySNxuGOoIQwW46R6ykKimS62Q7/AkX6txoBKqdxo5BjhJ?=
 =?us-ascii?Q?Ykoq7wjN96C/gQhANv5MtRDc3iV7jdci4m9ewbqYJq3FfgjLLtAbPuFq9zLK?=
 =?us-ascii?Q?mXB+FB4dcs/MVG0fLQq5Mi4pQpNEVxciYIRctQ/26kFs9NVvWi8sQTpJZuYI?=
 =?us-ascii?Q?VSXHa9z5pMRfvFIZDU91KGiHvFQF2wg1kdn4WxdTozWPOR2JV71cQStBpiqB?=
 =?us-ascii?Q?F8qwHqbK7NwJpAGObdXcCmyECc9TR/XWUQda36WDREq+1r+CdRCdPy7AStv9?=
 =?us-ascii?Q?vk6Yw2IvOEOZKcoVnSKC1IAu0w5/fRXpDISsH+F+vNFGTB3n8Pz9LLyGWXWy?=
 =?us-ascii?Q?e+p8SG6g0M1f+AA2fneqAeoYmbkN9ZowSx6puqH5xJktD5v7F9hJ1I4mxoC4?=
 =?us-ascii?Q?ZCnmXxTcqxKmB4mnB6F1XX5NCQp5Qfxo3X1/jo083Qy23J7l0SJobkdd2L0G?=
 =?us-ascii?Q?x+LT2vqV8MHshidqyj5BZLatu+PSuZg3mINLOzxsgCaj4RuS8grsDCI0+Tjo?=
 =?us-ascii?Q?k2BWkiGH/Z7zSm2otlYztUy75NxThZO+ji82pVy4nrqvvmERQ6xrFdJ9DdPp?=
 =?us-ascii?Q?ed3Mgm4FGxN77F0RGcL6Ig/5VDIqFM/EdPTH719QJ2C2w/XJYzqdCh/Q9grK?=
 =?us-ascii?Q?Z/Dkcg4G7uZOQ6YKKA5R2iEX4ctItkza0bmDEE+usB996d6hzesNthymOOv0?=
 =?us-ascii?Q?AYKymLvzSAJkpeROPeeqrU8jeE7OiT1feMQewCL2ul6jEk3X+q6/58mF3Y7g?=
 =?us-ascii?Q?/jO3GAPVP7yo1+nXnVVCmwtV9zbMCvhk1x1pSQZnMsi8Rsa/jWQjEWYsfvWL?=
 =?us-ascii?Q?qV25GqENJK1+xQYC/KmXfTPDOFoUIOg/Q9UXyM0D2s6vrUSmFtQmmMgHREQ4?=
 =?us-ascii?Q?/xONo3EKsrYdNneBLGO0299ru6GCeQgL1eaQbLeUX7nTXwDUBSHK1CfflWx9?=
 =?us-ascii?Q?b1Lj67jsGREeNU1K5GxWPsBvvUcoNMvNgV1JEUTc+wISJXUlCAi9ka/7U8Dx?=
 =?us-ascii?Q?m0vkmoVld41EzzYcmHbanfX8WXDH/fyfwCnCRRB/g5jhLBYzdQr7fqhImxiO?=
 =?us-ascii?Q?IGNACeCOo3H6Rxvg/P9Tf63rtf7oknZp8gcu0D7pICovouFlG5aWoFkxxnPl?=
 =?us-ascii?Q?15WJL5Nedg9XJ51bXi4FS5IolzT473byqA1ARXLsDT+xzEaG7BMF7nmAhBhW?=
 =?us-ascii?Q?qOwovzPyGdlBA3M3f5Ib01aEW0JNojrLjHz63CYkPWmpaTB/aEa4B+zNfgFl?=
 =?us-ascii?Q?mQ/XUVyZ5GrFoscv04QuTWFqav8pihsQgU5GCJKrSRPWSMGM0F/aPOs1tkVx?=
 =?us-ascii?Q?Kw9W4RLSUgjdJezSkFQDDWOhdoZM1Tsd46YMX0N1tLXRcmbjtZyvsRVvHJXm?=
 =?us-ascii?Q?qoOwkVCWiWxixLTOw1BlVXajVJYdAViKuB2vBfbZ4HaZb/lAV6YzrCaijsPg?=
 =?us-ascii?Q?Uxinu5jmUh8voJ+qS0zr0qng/itAwqvBIN9RXdvc?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa4db99-5122-4b8b-364b-08dbb6189580
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:21:30.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/SHWyGVAQHuzF7qTwEWE2nxniXr9Vj7RB/SDKzmB8wMPSP7qAnEGuOybxuXyE8AYaaEFYUy3wuW7IIg/PSxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

This patch series is to backport upstream commit:
915d975b2ffa: net: deal with integer overflows in kmalloc_reserve()

patch 1-3/4 backport requires to apply patch 4/4 to fix roundup issue
in kmalloc_reserve()

1/4 net: add SKB_HEAD_ALIGN() helper
2/4 net: remove osize variable in __alloc_skb()
3/4 net: factorize code in kmalloc_reserve()
4/4 net: deal with integer overflows in kmalloc_reserve()

 include/linux/skbuff.h |  8 ++++++++
 net/core/skbuff.c      | 49 +++++++++++++++++++++----------------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.7.4

