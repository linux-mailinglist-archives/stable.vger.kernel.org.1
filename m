Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048F77A57A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjHMHvR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMHvQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 03:51:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03DA10EA;
        Sun, 13 Aug 2023 00:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezaj1+AN6vy+duTlpsoQYQMmEoEJ8L/N4Est1MNYfON+bG/b2+b5gdwZvxFR7wF2Q3ag8SY+3EU3oICybUbUbdqx94jW6QMcRlTQqGNUMaXdcfjej+ktnNSwxVdS+4bOm/9HPrDiL4sNUN2VHBy46TVcp1v8G6Z5FsvB5Ln7kidHWHNFmTzY98P+E62H6BNrz8Yfs8BcIPrN5Wkfv5nGDN66IdDajQNIOTQ95orTImWWFK+7TN+vt4KhdLTnBHkpNlpsEkxC1035Rl9pGVmeW4BXkrEvPrGjtSRsFVqdg0SKy7T0FApi13vfT/07xRNMLCgniDXJPoqAA0WMBR2raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW0iYJn5y0kh3ENucPWS+msqp5gSkERI3VcvmuOWqZI=;
 b=iHmzUu1xLd9qiKf/i7cabcY7HLyH+E39i26jXpK4SQytIKyraCE8fA7wqs0vA5iEajhgJmdsIafjjB0R513Pz2nCxN4eEXHlDAj13pQoWVw6eJYBCF1+iK+8e88B2XgNuR3KJ7o3ujE9zV4+FElE5UkoYQxZAtwqskiL48Fn4H/Hae7hxiYufuEtpPaMT+5s+tH69oKp1mxkSxuIGSze9etREPF77wbvRdH5WWtTGN9AsndJOI3XYq4S2lDhoCBg6Op+F79IrHIjHpWTWnpyumfkcIX8kuNy0q1LytnbeFZjcrhUbwtTbGjgvzJrrYIU0PRbD1OaQHnVyWbNi3dOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW0iYJn5y0kh3ENucPWS+msqp5gSkERI3VcvmuOWqZI=;
 b=By5DzOG0xQt/oWqSe28dzZBaYxTijJkMo7/peetKJemfQhEghW1szmk4laycqvsmTmMOYfAy4MhqebBGUyysIA+wpWs+jjvgVkYeouyQqd+Ho+P/bb35jFs6Me8YxdLBLeHrN6ZeX2W+Ulhtxp0Q729dullA1lTmcCiwZNr2xLceZRXlytYBqudL+gA/4Dkn1tafbpeWJijzMJ3g3yL9JfgOFJtCarVHp4CTP8F9TXnkxzkKMk9vIlXBGkKL5iRKVrGdAnV0qzcZwvXXKkvamv6a1V2ndjMhG8uX+HoivGqVsPEbOMwKLMHHea0aoNtjwseKUv3dgc0tXLwf/1M86Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Sun, 13 Aug
 2023 07:51:14 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::e8:f321:8a83:9a0c%6]) with mapi id 15.20.6678.019; Sun, 13 Aug 2023
 07:51:14 +0000
Date:   Sun, 13 Aug 2023 10:48:56 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     kuba@kernel.org, vladbu@nvidia.com, stable-commits@vger.kernel.org
Subject: Re: Patch "vlan: Fix VLAN 0 memory leak" has been added to the
 6.4-stable tree
Message-ID: <ZNiK6AVGEZX6Y04c@shredder>
References: <2023081245-ebony-gladly-b428@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081245-ebony-gladly-b428@gregkh>
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: d25474d8-2133-4498-a4b0-08db9bd2114c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1tVmuP25WygkluT4/GAL9biJ1SuTEDeSOHkJrA07nHxHYYghHYRzUX+9uUWBZCnvYNurDB2ga0Vsz6AHY4FqlsOBc/SIoazf3SDPPQzs2qmPmuDCNugE2YekH4eHinKtkh3rEN/DdOp6Gnrz6hiT0evdPu4zVpDpxbAYoWLvpQ9AJPvhLouS3CQMaHkJ3GpfgsiHKVmsqyEe5oSu0CgenMlCt2ybcx0dEPueRfxdzXV9Y2RE2zf9vwnZx1FJh+my2yl+2hFwnBUdDkV3yJZK8XA8q9vHWvPzFUfcGdpSijk3ifqL7lMqZivX5Jh4UjTgQzLqloqHc6BwLSllmRWJv1A5EMziZw9ck2xUYYeMYd7vhttiXyOXlgePkgdyiCVcK8NnsN9SX9fFXdPE6aDeAB0mwdN3kayKZRXt/THFt3tr5KyH+9u4MOUeQR6FgxnUcuboGxGJkhYZOj82xNN3QfvnGVRRM4JCJB65AgMkPb9ersD/FzFqfYAT8iXiOfYda4+t1WGW1mTpoPomUfU9N2BOvOd/9CPtl7wctlK5wUFnZyFFVSw6y4V5VCPY+FQnufZXxU4ccQgUpLQ1kxoZRn9wDQfcHXuRckKreTmkBFCtByFmDyJ/QwTbtje84pLU9MYzRJW1yrMk1LcJ0qmR2TUWHcBum8BA82LqqQeVU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(186006)(1800799006)(2906002)(8676002)(8936002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(4326008)(6486002)(33716001)(478600001)(83380400001)(9686003)(6666004)(6512007)(966005)(26005)(53546011)(6506007)(38100700002)(86362001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9ckPRbUFog+6V3Xm0YfaQzNC3IaS7roElCijwPa2CgMLsxnLcEg6jm/9oqJ?=
 =?us-ascii?Q?sxNgy2XPxtrZn+xnnmJjID304+Va+N59O3gWG2W2bSiiXKUWdRMLtD9b+3ff?=
 =?us-ascii?Q?+d8yvwIevSbgwXTOe3ahVeujQVKujffbgDi3LkhStR/6iEhWA7Sspe+IPU7F?=
 =?us-ascii?Q?4GV7fype3Lu4OjdiHjyk3BphOXAy32XaQ5vFIMjQ+Z/S6PEkfvaJYtZQf0db?=
 =?us-ascii?Q?Lc8KxOFY66CLgGDTAVaEHVbWa1YUuuHX0cLpyzaBqAhU6/BuIDLoUUB57KNO?=
 =?us-ascii?Q?F0nnQ4cUkcSX3Dp45G+5MZXevrIYosWapwseT4scZ7pIkBM/tOBZmMTnrkku?=
 =?us-ascii?Q?i1yWSfvhVYv2v1fGts15Mka1ROUS9O994hj0mcIFVRO1vlFJH71I81hXgtU7?=
 =?us-ascii?Q?rmaQNFSBy7TLKNTG0oebG284E6tQNxrPk1SXFrnjhOWgLa4ONF4WhoRdYUi9?=
 =?us-ascii?Q?cDms2uvvBFMZHyfLtTlRybbN9cUsU2Op8SznZwG1c18Ph/7VAPzdrL7AKknU?=
 =?us-ascii?Q?kUnLeEYahlMrH1t3OFtNhPGM1Z3XnFSSKkFrRyZJib9dcjoNxMyPVXl8/GMn?=
 =?us-ascii?Q?vse5r0gtlVWrxK9Jf/9SoB4Q448in9OfF2o6PYdEmZ+D7Pdi3eUSu42pAkY5?=
 =?us-ascii?Q?V11CYHT21B1vBevnaY9q3VssbrVcYDqlgZIupsOvKeQ7FjFjs9hSRyplIlfr?=
 =?us-ascii?Q?8gmWtJGQeMdw/mLpR38D54WwBENtTRNY2y6eRNy8BrpoVOjwU7CCX/GlDU92?=
 =?us-ascii?Q?eHqgKWJqyQPnWhWelWrBDui1jBcB+54du3vCRH8ZPbj3siqskL1d12c9LCVi?=
 =?us-ascii?Q?5x6DkRSH3IAlm8YPYFbIMfJe8vBP2gcNaopDV+IW1O6gl/ep7YjSVo50e0Gx?=
 =?us-ascii?Q?AnjEcIK2YkjM6EvSdtdfcX2gF+qkgmQkkSfvISajVz6Fxzqp7UBNSrGxIgpq?=
 =?us-ascii?Q?EhH1ZVipLb39itks8sR0fvXgxOR43vuvJaDxU5Q8SmGoP/W2HEKji/83GzHS?=
 =?us-ascii?Q?6z7+X2BfPL14JzAYuWhUM3q9uI7f11rg2s0skZjnzCcYcbuqIrdike/STpIp?=
 =?us-ascii?Q?CDSJBC4BXSQFtbqE3CZdTLDKYS6MsdcsCjZoQm4OjaOemV5uSsyqxNEy6p36?=
 =?us-ascii?Q?ApxxZE0FZjEMcuw6Hvpy6qo4TzrA1HEl+k4tCbiNPGC1+sCAhUAOV8seosMt?=
 =?us-ascii?Q?CxWldOjQ2PSgf46H7QFoA00GHYje7kigmvcA1DT+8XdxIqD84rp/I1oC5GjJ?=
 =?us-ascii?Q?lqkxU+/1XhwfNWSjO/3zdIVAT1+LdAVlQdCZ3SXshqI/9Yk85GGRC9YdJWxd?=
 =?us-ascii?Q?jbi6DPPEfkI9UyTmCvfxoYLc6D0ckYBnyBBNd5ZSkRXb9k6dA+3WglX38GJf?=
 =?us-ascii?Q?g/oR7MSEJNkwXklwsrsEatKURuUgiro5UV43CAy90+NOcxyhMWGEQwBn2Jbg?=
 =?us-ascii?Q?gYr4kq8KihrAQEbxl9y6qlCD6hzbrU7DI9ACA8XvppMgL0xMnEzIbX88l5Hp?=
 =?us-ascii?Q?KgkPNeuh5ehNCepKGj8hllSVm37GuFw0tLmecrALLXcs++Ncu/i8mK86D3qK?=
 =?us-ascii?Q?LdKtz7FiUE+3UtJiYeRQXHFPm4tigVOj4YtgXpTY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25474d8-2133-4498-a4b0-08db9bd2114c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 07:51:14.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11dv/VSZjPxoGf8/Y2aM8eiTPDckGcu7nV5ZY/AxrznBLdOEppTiHLf0PIYVqiTvuOs902SXVKUBf5yd5aFTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

+ stable

On Sat, Aug 12, 2023 at 08:02:46PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     vlan: Fix VLAN 0 memory leak
> 
> to the 6.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vlan-fix-vlan-0-memory-leak.patch
> and it can be found in the queue-6.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please do not add the patch to the stable tree. A problem was found and
a revert was posted:
https://patchwork.kernel.org/project/netdevbpf/patch/20230811154523.1877590-1-vladbu@nvidia.com/

In addition to 6.4, please do not apply to: 6.1, 5.15, 5.10, 5.4, 4.19,
4.14

Thanks

> 
> 
> From 718cb09aaa6fa78cc8124e9517efbc6c92665384 Mon Sep 17 00:00:00 2001
> From: Vlad Buslov <vladbu@nvidia.com>
> Date: Tue, 8 Aug 2023 11:35:21 +0200
> Subject: vlan: Fix VLAN 0 memory leak
> 
> From: Vlad Buslov <vladbu@nvidia.com>
> 
> commit 718cb09aaa6fa78cc8124e9517efbc6c92665384 upstream.
> 
> The referenced commit intended to fix memleak of VLAN 0 that is implicitly
> created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
> doesn't take into account that the feature can be re-set during the
> netdevice lifetime which will cause memory leak if feature is disabled
> during the device deletion as illustrated by [0]. Fix the leak by
> unconditionally deleting VLAN 0 on NETDEV_DOWN event.
> 
> [0]:
> > modprobe 8021q
> > ip l set dev eth2 up
> > ethtool -K eth2 rx-vlan-filter off
> > modprobe -r mlx5_ib
> > modprobe -r mlx5_core
> > cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888103dcd900 (size 256):
>   comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
>   hex dump (first 32 bytes):
>     00 80 5d 03 81 88 ff ff 00 00 00 00 00 00 00 00  ..].............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
>     [<000000002889a7a2>] vlan_vid_add+0xa0/0x210
>     [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
>     [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
>     [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
>     [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
>     [<00000000982807e9>] do_setlink+0x28d/0x10a0
>     [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
>     [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
>     [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
>     [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
>     [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
>     [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
>     [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
>     [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
>     [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0
> unreferenced object 0xffff88813354fde0 (size 32):
>   comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
>   hex dump (first 32 bytes):
>     a0 d9 dc 03 81 88 ff ff a0 d9 dc 03 81 88 ff ff  ................
>     81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
>     [<000000002da64724>] vlan_vid_add+0xdf/0x210
>     [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
>     [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
>     [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
>     [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
>     [<00000000982807e9>] do_setlink+0x28d/0x10a0
>     [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
>     [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
>     [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
>     [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
>     [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
>     [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
>     [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
>     [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
>     [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0
> 
> Fixes: efc73f4bbc23 ("net: Fix memory leak - vlan_info struct")
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
> Link: https://lore.kernel.org/r/20230808093521.1468929-1-vladbu@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/8021q/vlan.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -384,8 +384,7 @@ static int vlan_device_event(struct noti
>  			dev->name);
>  		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
>  	}
> -	if (event == NETDEV_DOWN &&
> -	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
> +	if (event == NETDEV_DOWN)
>  		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
>  
>  	vlan_info = rtnl_dereference(dev->vlan_info);
> 
> 
> Patches currently in stable-queue which might be from vladbu@nvidia.com are
> 
> queue-6.4/vlan-fix-vlan-0-memory-leak.patch
