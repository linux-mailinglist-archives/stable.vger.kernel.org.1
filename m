Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573EF789B50
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 06:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjH0EIa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 00:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjH0EIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 00:08:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C17197
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 21:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1akS08ucsjQ6mtM5s/29Y7Ywov7ieIe7jkc5NAe864VnxAI1Jae+ZMc/q7tA0wZyL7n9OPObjbs91VaZi7Gxkl2KB3J+tpFdUp1JbfXQLnKvv+TOVzfHS7FCELWU6u9QKM7HuJfeKoutyX55izY79M3HZs6woNxIloo7J2cQ/XPd+rBjzcBEvG50NViABIYk/0VghYB1cbzbk0SSPzJw/oNVFaYNqa3yWbG4kco5GN1dr+ShK990xtM2gHS2mmBGJgEWdcyE6Yz7MCUheKFnSD/e0vsgRYQCxrTot8CIvbPwSuL9tC8i7dSBer6MzMoj+F50boAL2uJ+LHNyyfPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y1tboOksgbuWSoGBi46tfDSvt6W0t21t24p1SKgBEQ=;
 b=Go1IVSirFijBxe4XXdYg5Lb75y/kRker6a/JS9BEqKSNZnBUTJ+afpH/83PTiN4DE3Tq8YDMc69kArqwmkhXrYaUPiYVRBiHxBWCY3MSzOEo1LjNY1Lc/bXEblTVAtpT2NDSRdRHD+gbRrGVVupAU46kPdXSwbPOfn81GGfXGKE8iUp6y0ogGb42njliXF5Q7fAXGvcLAV/wLqp1CscWj377eiVwzP6i528y1Koe9ON540zZYiF68eGwLCH+XNtcK5efgcuYOLL6Xc2QZZCPTIjpCqJZB2GO9JdyE5DvUSuk2Lhx6JFo/Q2Cd63yRnqUPVhgdRYFySFTh72czA2Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y1tboOksgbuWSoGBi46tfDSvt6W0t21t24p1SKgBEQ=;
 b=ZTECU92wm9CJ68UlsYWmspYtlybhVmL0RZzEMGuNA1tUIUayhDP+TdDGEoetnwkKrBN7liDmtmy0NlJwZJgKGoJevJtscKwxAfeKStnMLEVnW36i+6brt1O25CB1wPsq6TKG+ODF4gEQyBiM1qQm/N8CrNMTAICgFeOf2LjIUxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sun, 27 Aug
 2023 04:08:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 04:08:08 +0000
Message-ID: <a715e893-733b-4ffe-8646-87af49998cc2@amd.com>
Date:   Sat, 26 Aug 2023 23:08:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [BISECTED] power button stopped working on lenovo
 ideapad 5 since a855724dc08b
To:     Luca Pigliacampo <lucapgl2001@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linus.walleij@linaro.org,
        Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
References: <aa1649b6-b7a8-4fbe-8356-2c856951e283@gmail.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aa1649b6-b7a8-4fbe-8356-2c856951e283@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:806:d1::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e30760-6525-4228-31fc-08dba6b33866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNL7D38nH1mUSVmSO+mlP98HHqp/DTyZr2IaKC9tYDxXoUtrlE5ehs7HgLIWkzDWs5wnPqdZfdM3+h8FVYUNEP2Ma2cL85QbfcPtRnaSEFDkjM7nsRpa8EzwXV73TSS5XcjYifoKL1o55ePMQuKsiJyc/6RNmn8oUHy37bUxVgig7Ljv4DSPmpCS7EnKs3e8oP6MWT1hwvbWow3ckotzbneFPQY1xdWS9HNzMrLwACNC804BoFLBYZuHyX5WuQmYzSDR+cJLCPD6BFKA7BD733TsenFRU5LJIXZQc5tXTIchPfbLnQNVuT6PF7NvGDrfd+rGhDMAVPsjDVKZ0X+KMMUUM5k6RA3AoU32sxzwG6WLInYBKOWM4dEzOMgH6yjjBxthfNtaeen8wYDIoBgS85LuATn+ODu/4t/PM3QbBBdceX4nCEr9lV5eXmGClSik9LL0gN9Erf75XzPWiOYfFDB33DA/30h0v9om8GxbOvKStyO7iCq6CJ/5C5XLUpGfqg1xrGWPQUkXvixodx/fYXS+Y1UXMfFmVBll6abLCnxFMdES5qvZPdjdMy8DHvt2BvzfFqj2fCGP/80cnip14HbaeYDkWLnjfcu5wJt7AOKkAenkte0nq2Do5gbwuy6IfGOg/vSC6xyWCwvh5cTuKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(1800799009)(186009)(451199024)(2616005)(5660300002)(8676002)(4326008)(8936002)(36756003)(83380400001)(26005)(6666004)(38100700002)(44832011)(66556008)(66476007)(66946007)(316002)(478600001)(31686004)(53546011)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHg2UVZUeVFGbTVZR3VwSDN5a1BkUjZianhRb2pDa0o2bllOcTBpcTlZMDZK?=
 =?utf-8?B?bHZYT2JlKzFGZzhPOWJ1K3BLU3FnbVM1ZzFCRk9GV25Jd0hVcmRCb0hUaTR5?=
 =?utf-8?B?Zm9xaEl0OXpTbUJHQTBtVXdEM25SNG1XVHVOUFROTGZ0TElES0dSTGJDb0pY?=
 =?utf-8?B?REVIVWdhVEFjaHpQOGRUMnRCTmIyM0laQjNkNGM4REEydHRxdU4vVC9FOXcw?=
 =?utf-8?B?WmFNdStQVW9BYVZrcWlJTEVFRXZLanY5bnFlREJUYzFkWUFJZjgyaDdER01U?=
 =?utf-8?B?alJNNSs3VVRNZHpmMU1lUGU2Q29oSDFwUXIzTzNubnN6QnhaeVkyQ2huRG82?=
 =?utf-8?B?Tm8xTDBjREFZSy92T2dsV3RFbGp5NnFMaDdYVTZZbEtmNHlpZHpxT3JSblp2?=
 =?utf-8?B?cTZsMzczZTVnaXVlY2YxUi9SWGxQUTdSV0xIaU0vQ0lxc0lPS2RqTEdMWElK?=
 =?utf-8?B?cHowdHFGK1J5VWcrUDE0MC9SY2NnbU1DVlBoYkk4NW8rN25NTXM0Z3VZR0tw?=
 =?utf-8?B?ZGZMUVJlTWJEMWpOcmVEbklsU0V6Y0VrV3BvMFVsZitNbmVFcDY1RW1XY1FN?=
 =?utf-8?B?Qms1SnNaaVp2OVJxUUcwdjRDcE9tVlpvU2FMNitaT3FjVHlHZThXN1Yvc3R5?=
 =?utf-8?B?NndZRnZjYnVWYXp4WHdyMWJrcTBTN2NIR3hmcXU4aUwzbWZFMktVNmp1VnB2?=
 =?utf-8?B?Yzh3RThzVWdiRjZtYmxuVlpvT3lLWHpkbGl4VzNpUm9yak1icUN4YS90SzYz?=
 =?utf-8?B?RXlaZi9aMlNLWjNBYWNPV3hFclZPdEZpNlpobWY2OUlCQ3BmZFVKYmJPbGZC?=
 =?utf-8?B?elFvZEJUekF2UmRmbFNUT3ZxMnNtQTZKZ1RBN0tUcDBEdTFSVldEb1oxMFlr?=
 =?utf-8?B?elpVY29FOFYxZnlOdysreFZUa2hqVHRNRzdzMUNyTTU3QVZ0UFBDTFVvcC9R?=
 =?utf-8?B?WmY2WGtnOWRManlQUmN5S0E4dkJKRGsyVFRYTjU1RWJuUmdHY0ZGdmhuWTFz?=
 =?utf-8?B?cUphSldEZnNudEwrTktwdDZ2cFloZ0RRS1NtVGNwMzF3UFg4elpLR0l3RTZR?=
 =?utf-8?B?b2JjNkhaUlA0cThkZ0JFTHZXWDk3Z3MxZ3k5Z3JnQjhLWHFuQjBnYVZQZktF?=
 =?utf-8?B?UDlSWTZvamZMZUNQUnZUS0Z1d2hhUWFBc290ZHZmdzZnYUlMajU1L0RKNDIr?=
 =?utf-8?B?T1dzRmYzY1dDOUhUeDdwN3drdEQ3TkptL0R2M1UzdDB4WnFzTnpOL0RrQkZx?=
 =?utf-8?B?dmxGSXQyb2owMTRUNjVBdzdEU2VyQVdqbktSekw3Vy9CRHBxMEVzZ01nTnJK?=
 =?utf-8?B?UGs5by84V0lTSEprNjdoVDhuUThxM1hMdThYbmZXcURleExxbXNLY1RweklX?=
 =?utf-8?B?NEQrZG1KVHI2T2wrVm5nN1cxTUZPRTBxYnE3S1VjYUZJWERqd0FUMnJhQ1ZU?=
 =?utf-8?B?Tk8zaHptdk5yS3ZYTkpjeS9BV0NjOUhoUmRrYkhsbTk4RklaeFBLd0dUOERz?=
 =?utf-8?B?WUgwM2cyd2FxaXl0ZkpXWnBDQWlHQkw0UmtISXpDZ0J3OHVHem96ZVpUMnZ3?=
 =?utf-8?B?Q1Vwdk5OVFU0K3dWRm1CS0htV2lQbnZWdVJvaDFHNm4yaFZJM0QralM1MnEw?=
 =?utf-8?B?TVF3ZHUvbnZzdzFtTmZiR3ZjeTRNMmdTSDdISmhlZW5OYngrVXlVRzNHRlFm?=
 =?utf-8?B?bFRFK1BtajZCemF2SGw3Qm5ZRXNUckhIQ0xZYlJ2OFg4SUxIQ0RyOFB5QjFr?=
 =?utf-8?B?NW15ZEFtSmxaTlJlckRvdGtjSXR3L1NjZ2hEVm03WVUrVFFzLzY2YlFJaGZz?=
 =?utf-8?B?NVRBbGNCQUwwU3dON3ZLMWh4Tm91eVB3TE4vRXhkamQ1clJmTmNYNGEyclNw?=
 =?utf-8?B?TUlPdXJvZzJTcFJ1QnN6RTlpcTVaeUlPQXdvTlhvVlkyVTZMaFBvUTNVdkln?=
 =?utf-8?B?UGlNRks3K2g4cDNldkNWeUMyTVlZb1g4UmF1SVBWUU1pRVVRTGJLWEIwUDUx?=
 =?utf-8?B?Y1ZDY2dINmU4Vlo4dXNBQmpHdytCSExNQ3RGQ1NjbnJ6WW0zMnFlcEhGVjdD?=
 =?utf-8?B?eUdKRXJINXNVSVdpeXdHM2dCUHNsMDV5VjBFOFFVMjlncXBnVTdFWEtyeVV6?=
 =?utf-8?Q?oLcY0Kl0oM+g87ybEZS0OfdbC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e30760-6525-4228-31fc-08dba6b33866
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 04:08:08.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RQRjD4USyNFeeopMm1sUF1EpPJCCrlV8WBkiRPbpzSHBwCCwBt6VNZ8ieaNClJeiLWLT8Tj6HUCti34Z9XW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/26/2023 15:33, Luca Pigliacampo wrote:
> since the commit
> 
> a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup
> 
> after boot, pressing power button is detected just once and ignored 
> afterwards.
> 
> 
> product: IdeaPad 5 14ALC05
> 
> cpu: AMD Ryzen 5 5500U with Radeon Graphics
> 
> bios version: G5CN16WW(V1.04)
> 
> distro: Arch Linux
> 
> desktop environment: KDE Plasma 5.27.7
> 
> 
> steps to reproduce:
> 
> boot the computer
> 
> log in
> 
> run sudo evtest
> 
> select event2
> 
>       (on my computer the power button is always represented by 
> /dev/input/event2,
> 
>       i don't know if it's the same on others)
> 
> press the power button multiple times
> 
>      (might have to close the log out dialog depending on the DE)
> 
> 
> expected behavior:
> 
> all the power button presses are recorded
> 
> 
> observed behavior:
> 
> only the first power button press is recorded
> 
> 
> i also have a desktop computer with a ryzen 5 2600x processor, but that 
> isn't affected
> 
> #regzbot introduced: a855724dc08b
> 

If it bisects down to that commit then it means that the debounce 
behavior wasn't working as intended for your system and is now adjusted 
to work properly.  That commit fixes it so that the "Master" GPIO 
controller register isn't inadvertently changed.

In a number of Lenovo designs I've found that GPIO0 is connected to the 
EC and the EC uses this BOTH for lid and power button.  I don't know if 
that's the case for your design, but if it is this might explain the 
difference.

Given it changes the debounce behavior, can you hold the power button a 
little longer to get the event you're looking for?

Also, can you please check if you can reproduce this with 6.5-rc8/6.5 
(whatever happens tomorrow)?

If so; can you please open a kernel Bugzilla with the following details:

1. The contents of /sys/kernel/debug/gpio on a kernel that doesn't have 
that series included/backported (the entire series of fixes - not just 
that one commit).  A good test point for this is kernel 6.4.5.
2. The contents of /sys/kernel/debug/gpio on kernel 6.5-rc8/6.5.
3. An acpidump for your system.
4. If you have a dual boot with Windows, I would like for your to 
capture some registers using RW Everything in Windows for comparison.
I'll provide your more steps on that bug report when you file it if 
necessary.

You can CC me directly to the bug report.
