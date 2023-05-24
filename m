Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8EF70F055
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjEXIL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbjEXILz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 04:11:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2062.outbound.protection.outlook.com [40.92.18.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978DFA
        for <stable@vger.kernel.org>; Wed, 24 May 2023 01:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuAUZpef4aVynnxU/mrkM2yX2ntBNNdnYXFDSNJ92s9cS7GLufhbjFeD7TOluhoiloIFYLRIdCxAr1b23ToFZ74tRTlvdGKonfajq/zy+UJrONibO6IA52Yh2cv5/XNxX8nm3rYH6Y+abeZu7gIWL60aXxRLCV1v7qF5oTCCXqgeDeuVuExsCWGvtaU3yE+hRiTcwuqFkibwgtrS8OgKrTtdrIA/BUNqg0OjNbvl3TcT5KHKCSefTcs2/4n8AsIeanvdexQbDsvJt3AOG0SFHOOW4B9cYHPFxSoRInvt+MWPNs/Eo9Nhg1m8doR02tY/H3bPI12yC+7aKTBBZ4RJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=VttyuiVrfZVO7cG9FSbelIP7pH0TLiuR5Pl2egHj1IyKZmTJA8VjDDfb4QXP1kZQvqjeIIULUUjQfPBzN63BmGsWQPF0Gb6foI4/aLFaacP7Csbct6k7eQp+Z3JH4VWn1YFtPHEe0ADdLX4qPy5ugSWROJZv0+Ld0NASDZCwm6iH0bLumpR8tLr+AzKJDdXKLEuQqJUEfVeJYBURdVRkRRJZs0pKYoqfKa6g00nxNKOFQpiuuwgkOifSf9/bP+v0lJGRTFcXZSnQw/M4XYkLLq/DvK4oC+M1yZfECt2dIq3ymLimAE8/vJPGZOBk9y/4juh/CFnaHm7CNXF86Z8xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=uRWVNE8gzKnLCAUzF+zjFzKO/cf8YEvza2CNaMUcwseIVYVaqtHu2+luS6DI+fOvCL+web0B5cJYhNQatar+5k9zgYGH4S7xwJLsFFIT+VUhR9oXPYCA4A2DumBxVYkQkM0Zpo7eDeJsbS+1ibHMXFWJvRlUqdAN3LZpqPujsAGC+piuZ6ZkzagZ4C+OfCoUiKmvfx0prqf82Srol6CDdNm0h9Ch0u4ZGCAtvggi99LdV5JffoVZaIaFltfVJso6l+fh8XeXWaj0k2pluAX3pE7nyKQBHCwu3v/jN96PCnsGzL5XT2TtfuoZb7wTpaoZSUV8TvVkKXikAQEPQxV4jQ==
Received: from DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12)
 by CY8PR11MB7922.namprd11.prod.outlook.com (2603:10b6:930:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:11:52 +0000
Received: from DM4PR11MB7375.namprd11.prod.outlook.com
 ([fe80::592a:da21:cfaf:af53]) by DM4PR11MB7375.namprd11.prod.outlook.com
 ([fe80::592a:da21:cfaf:af53%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:11:52 +0000
Content-Type: text/plain
From:   <fbavtn@hotmail.com>
To:     Undisclosed recipients:;
Date:   Wed, 24 May 2023 08:11:51 +0000
X-TMN:  [v0hut87Vm0OgMZVKK3sNmsm2RZESfKpSYpxT/YQotIU=]
X-ClientProxiedBy: PS2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:300:55::16) To DM4PR11MB7375.namprd11.prod.outlook.com
 (2603:10b6:8:101::12)
Message-ID: <DM4PR11MB7375C47D0D8D1041AFA69CE9C6419@DM4PR11MB7375.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7375:EE_|CY8PR11MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3dbd0b-a98d-45c0-5438-08db5c2e8825
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR7+REW8Nv/fXkZeDyLG74Uk9vVNmvejiH4fGm9AdTaQ/XxpLcP1BfFilsyBk3nGTyYt75HjgguPJX6nWLPDGmYAMAcK+9a/w/Ma9Ml2ZLLEN15DD/0nS5O3ft8KKqntB47viQrYXjziKLF9UfQy9oO7IxZDY3V2AGLMrb6i26XIZiKODjbjKz1e13shC5XvIigwFVHMU099u29a44gYpc3zmoC6XvQ9TaQUgaDZ4BbG1AOu/JRN4r3qNF9jRmRDS0XnU0pmpSNMdwesTNy5Qojjg95SksmY9jEaJPqLBSo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UFzjyT0LhQfzfko0IBC5Twedp78fb0YaSS1eV/6c9Ge2ylsyj6I95ka0WK8c?=
 =?us-ascii?Q?gf9596aVmcjsp/y/kb2KBim49gOaJKnrJKnxmaQ1CWjIhFq52vJ6dAsSkUYf?=
 =?us-ascii?Q?Iou4aPrpCnzeZXpVdzy6t6RHSRVMcfMMfEV0g6uXDTkZ1Cgkx4NIBeXBB8BU?=
 =?us-ascii?Q?J8aqVofC6Y/YUrSoOtUALjm8PnNjfT9tIttol3TjmurWLhOFr8IJMzEx5Hz3?=
 =?us-ascii?Q?Y1LjwIZpvborP6MeM4kIlTl6oSd1z6IoTeQ2gQveVdLyvZTU6CZRRVqNOvp1?=
 =?us-ascii?Q?gHKt40zdKbvBt3JLnxcq7uBqV5AkI/FkJfDxaYsk9Z2/ZlBNb8HDAxxgafQ5?=
 =?us-ascii?Q?tkaFzQz1sA0jpt06TlYIMIr9oQG1IlxSlo31J5EzLWrM5b+R5z3KnMg/aTzO?=
 =?us-ascii?Q?wp1Tdpuuy06u6hn+YUdah7Ckz5+Rly5pLF4AtuiLwZw11ua3AK5K6i8ya5cL?=
 =?us-ascii?Q?Zu2nIYRf+Lpi/h0gsmxoOryw0sgnt7UWH8extkGzDKUW76SblWl7ifqSINx4?=
 =?us-ascii?Q?37UQIMcbBtmlQ4r11u9TyZs77wVH4er/SMhKLa63pksjWPYQbLY4XdHu5+0e?=
 =?us-ascii?Q?p8KGX0bANalFmDRmftk59FEnGvWB0YKW3q+ufqvg4xJYAW1BdXMYbKlmdZ0Y?=
 =?us-ascii?Q?Lg03/TNxuRoc+6ccCP/w67J6eG5no79N3neBPyFhAfSp0dRPhIWEEJTIyybO?=
 =?us-ascii?Q?P27mH8J3KIB/Zq9TQ+tBxmT9amShQsapAvSiyYedNX0mOCQV02P2fcqPImMi?=
 =?us-ascii?Q?PuJ0sITz75nGn5Kg1xnsyYnmZ71AEfdjHgNkaLIaNC6JqlJ2saxq/VmYPn1z?=
 =?us-ascii?Q?K2ds4l9Y2lm20WWMBdQknSNcipCncaBOu3BNJkFCyAe/nEUe3Hmbd0hSnR+x?=
 =?us-ascii?Q?GLH1PgM+ApH+UGeLvl3T3/HjqhigYTb7e1R7pQYtDuf+vUSJvV3/o1UnZBSg?=
 =?us-ascii?Q?If5C7qOvL2DqbDR0eNhNqON1/pQCPII2Rto3ACAjwsdkfSGvqnblZbELIqDm?=
 =?us-ascii?Q?8vanSt0jWXwm95nxYCeEQOGdi7rjN/BkbYzqoAn4VDpgmnzRxYW4DAP4OOz+?=
 =?us-ascii?Q?4gDE2W9GzreE9q6MEP86ftPev9RddgEriSEN7vFa4W7bzvYBwYpMLg41d2AH?=
 =?us-ascii?Q?a9/BEdigEAULw7P0ocNYgO8cgCYRMAE4dY4wGGEvUHitSpegeE8jdwMh7bpi?=
 =?us-ascii?Q?HDUVxAV94lvGr/wydU6r4ehmypr3N0yfu0B2fw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3dbd0b-a98d-45c0-5438-08db5c2e8825
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:11:52.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7922
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        MISSING_SUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

