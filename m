Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11271546C
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 06:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjE3EMw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 00:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjE3EMv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 00:12:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C9E4;
        Mon, 29 May 2023 21:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Ma9vaKQOof82ut4dzq8HmiS7BPL+l2WrKTcWIAm7Ysj9bV3BARxi+lJW8OdCDBydxnGaFdrFrfU3wM1h8OakqkRCFxemtOxiqXf0sADZ/QFjGLTohmrzeTBCoTmfif0ICP8FtQF1JEh9I7TuJmOMGNVx+Vny9E0MGomi8R9VDK8T7TJCBcmZNHbw900TVIubOb5RLp9kr4PwG66BmcVK8NCK4p6Yg1OiiTXfw68YjKVbr4D0FdTsF9U7GwyefU/HquDwTjo/MwjkUkVU4vAprPJXP0DvpU6MxT6VlyiOp3D1SHiUCAHGL3JkzisNP4qMGYrarZ+rc+1CYQudTChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaONbUQvDR+cf5a9btgdaLYowa1jbnre8fv+e4JWGas=;
 b=PwiMEQKnE5vHIameO5SxSNs1eRNwlSbdVDFNMXjufTvLYEH129osAF9wtM6drLOR/Axv0TKxJX6QcjpScCm8FP9ol4NvxKEVLSAWQXeRcnCFK+aLDdAGihOGYBSV0CK0Ec+uAB6cCdBtlxYOVVWUMBIyQb6d/PHTxoMD5B8myHG01sDg1MV652Xu5+i14WrHGsusWh/1x5zruz7zoMTWiP+yM44kTkJZDP0MyGoSuXE0k+qgU9MaTcA/ih7hn0511TwRWs4wkOw1HzDSkNs/5EJ8gIKyjJ0cO6YgpXRTOLCrjsXtACUYtajvtntemBtKjqc0NPLpkD4LsJ9KL66EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaONbUQvDR+cf5a9btgdaLYowa1jbnre8fv+e4JWGas=;
 b=owIAnoDPMf3+aQrRFcW+W/2FgGe/xJa+HsYyuHTZ/vZ4ZTT+O+WeCCWVVw763EGDAGlsdoq3x/MjNcDHahi3QidoleOziNcrpRROPKnhCiYALUoC9QSorma3jwA6DhpHHpFiELNXuRZarehtPds9NwAvtcH6+IVdKjyNqf6RDYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 04:12:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 04:12:48 +0000
Message-ID: <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
Date:   Mon, 29 May 2023 23:12:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230529113813.GZ45886@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:5:80::45) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 90904920-f074-4e76-e016-08db60c420b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3cM7fT1y/43vkMHQLQHAEMa1Tccq8hjfdCsfv3qJEPS9HgconF9nt7UwcCNVGEgY3zT+DiGOVTEpOSo+twCiW6SgyemiqdpZyjTZyIXYQ3ZiQu//lHnO+vf0377ezte9WPQJmV+Igkj/ouI+nlz0wB1R/HplipulslLZ3nAU5I24TwRtlCOryip4t7Zl3HuGgg8gKse6Gm0l3V5cDF0eh/WAbBDl26ao5GvZdXbv2uESVo1dMcr2HwOj8ol9hsEkj2XKcMbQyayvgVnb+RhS8ZR8KVPi8yNl7eR27+CeElIXQKgJ/UPMI3hQaXSrpC+8RlgqcY5HA27tDyshjTADLPjXYEbQBy9+cU2CtqXfEVrd2klIPGMk7fqS3cbyST/udTB4zF5UqoFIPsE0E+5I6EoPYfmQBiSG5G7rKlbZLqEtdXcGSd/LLzdQ5R8p9VYV+gXwBczfxS7SXHGrZxMxMhhMAoQAqcn+uXe4+08QXJO0h0JPEbfl+Ll/A80da0+MJUl6ZoNqMHvy71ikvcOeGg2SFSoRsGwPKCBqHB7M/g9vhTZ/3zoftoNp5HhNOQP+MYv6I0BswrL4zfZDfof72goxF2gnBsE4e1o75UEGMkrC3XUVzxUr5sSLo8jetdSKWxCekZNEiTBS5wJP0xnrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(54906003)(478600001)(8676002)(44832011)(8936002)(5660300002)(36756003)(2906002)(31696002)(86362001)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(53546011)(6506007)(6512007)(6486002)(6666004)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhjWWN3TnY2bnl1SFNuM0I0VXVHMHQ3YS9kOXlMU0h2UTR4YzNySFAxR3k3?=
 =?utf-8?B?eWFLQ2lteFFCdUZTaVl4a25wK1B4RHpKRXF4dm1vQXNhWnNpTm5VNmpPclMv?=
 =?utf-8?B?T3JINnNqRGFuaDJEUUJzTFBZYm1PckpmWXkrK09UTXlraGRINVUwSGUyNGJu?=
 =?utf-8?B?bkhHUXcwMCttRCt1Ry9KQ21YM0xpTkVabkp1SlNoVHdFK3pRSVI3eUgzb3cy?=
 =?utf-8?B?dEEwREtKblJDbnJLR2dLalMrM2paWHd2TUxRMlUxZ3NBbldPNzdZMytoalhr?=
 =?utf-8?B?bHRnUlZnTk5TMTJaZTVWVVhrNVhNU3Ria0x4TExYTVpySTBHUzhpOFFqQXU2?=
 =?utf-8?B?WTBybkg4bWN2dTRmQ2Z6bDhDMHRSMDVIeGh5cHVQV2tlV1dtbndOTXIyMUll?=
 =?utf-8?B?USs2SW1GMkUwU2tyVjZkRDVyOGdDbFROeXVqNHhscE5IMnB6Tk9RZTdmczA2?=
 =?utf-8?B?NDROcUt2aE5SWG9URUJvMk1kNUJlZkJTYk1HZ0dkWXhqL2NSeC9RdHZnZWFV?=
 =?utf-8?B?UFRxVHZxQnpRUFdmOFQxcjhRS3dKTVV4QllteUJybDJZbkovZ3FHelJyVmw4?=
 =?utf-8?B?QVBMRG5kRGhaQ294SzNrMEQxZHNpbnVjR28vcFRxYXVhR3N4TVU4SkY5L1g1?=
 =?utf-8?B?TVVnaTdmSVE2L2xWODdjOE9kaGtpM3JqMzZDcWJPOEFnYnFCN3lZMzNVV0VW?=
 =?utf-8?B?WWhxNXAxdFlEOGRXYVBUeE1OMEY3NWJlZGdKT2xlTkhjSXlJdUVEWnhqUnJ2?=
 =?utf-8?B?cm9EaEZyTHJVTHJGTFlFT3pWUDVOTHp5bmcyOHBicjJvcU1tNEZGN2l4NWRD?=
 =?utf-8?B?RzhGS3U4TEtKL1RSSDRvWDN2cmdpeUMvbXpWNGUwM1ZHTWFlUGZTVjFXcGpE?=
 =?utf-8?B?WFJLU1p3NDJYbWtRZTMyOTJpYzU3MmFLWUlkQ211TXh6VWtzRDY2YVVOUFlR?=
 =?utf-8?B?cThwV2lrNWZ5TVJ5aitCN0VQUWZsK3JoOXo1d1BEQy91bWRHUEl5R212Sjhx?=
 =?utf-8?B?Q29YSzlSbkpzdXNSTnNEdENwUWFUam5sNWUvcGZCa2EwMmI5YjltUmYzQTMw?=
 =?utf-8?B?c2ZCVlFIQ2cxS0JPUWNtM1dHL0pQcXVkQlh6MXp2elhqWVZmZ2FIU0x6M3pC?=
 =?utf-8?B?bStQZ3U2UnFhemx0YUVEWVJ1TzVZVTNiSEJDN0loSjA5d3FxaDhuZi92b0Rj?=
 =?utf-8?B?Q2R5OW9qYWo4WEwwaEEvQlpGVDBYN21hOWpvYzA2M0xqV29ySWpqbnI2a3RY?=
 =?utf-8?B?Ykp2UHVoTmxTazN4U05iNjBDK2dHTkVyZjFIM0NWUDF5SmlIWkVVVVk1WkpZ?=
 =?utf-8?B?STBCNHJ4RDdPWXFBM3MxeW94Rkc5bWNPcmE5WTRGYkZ2cDZZK0tzZHl3REpH?=
 =?utf-8?B?bFRxc2FrZjRwVnArMGVyVWZZWHJEWi9aemo0eFZnR2lTMUV3NWZ0V3pLYnFZ?=
 =?utf-8?B?MDYwTTdYNElZb04vN2xWVkxHSVljRW94ZWNJQzVVQVRndHVxMUFBdllTd3Bk?=
 =?utf-8?B?N1pDQmh0a1M1eU5QQm1CUHBBOVZYUXVoVm80NXhMMDBtUndUck1KdllsUVk5?=
 =?utf-8?B?aHFmSEovaDMzNENHMmVvbWJYSXpBTk5jcEJhT1pRenc3NTVxZkRQbUhVMnJR?=
 =?utf-8?B?NHpyRC9TcTZHUENWeXJOS3k3bTlUWkg5RTNqWnpYY2Y5VWx6VlVXWmdhb0Fr?=
 =?utf-8?B?NUV6WlcvNDBxVXkyKythdlN5aEF1WDVmUHVRSzBwbWZrYkxnSFl0U0JvcXhy?=
 =?utf-8?B?WENSb2c5OFR4a1YxN0lzcE5yOUgzbzlHUDBaQ09wZXpXOG1UK3hEVDR5ZEEy?=
 =?utf-8?B?RWxVWnNROUhRbkJUVSs1VTVmQTFZaXNkSXR5Z2hBV3F1Y0NUZ0REY2VONzZu?=
 =?utf-8?B?UGtnbG80OW1Ma212M3hFU0ZZayt2THUvVk9xZXlXRkZ6QmlBdklXdENRY05w?=
 =?utf-8?B?ZTdqQ3RnUzAvb2diNHRBZTI5OXpYckFHVG5PSmtzVEFmTFAyQm0wdWlSVUIz?=
 =?utf-8?B?bXJzZjdpOUkxTjRFVzJZR0JsRXNPQlUvNjEyWFFWY2pabFVDbUpvcmVkcEVO?=
 =?utf-8?B?cjJXRUNKZjBNT3JDV2NYSFkzMEZnbkt3RGpiU3hFZzA1WHhRc1BENGxTVUFj?=
 =?utf-8?B?ckpRQUZNZUVWWnl2YmhWME5HNGxpUEJEQnlKWisva2Mzc3I3NFBkL2U1K01M?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90904920-f074-4e76-e016-08db60c420b7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 04:12:48.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcWz8PWl/GcdEPlFtTmk02KaGazRtyya21RMxp85edNwODHNsjvd35f8m5lkNh1Kv+8/r+XvuoHNEAhJQwjwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/29/23 06:38, Mika Westerberg wrote:
> On Sun, May 28, 2023 at 07:55:39AM -0500, Mario Limonciello wrote:
>> On 5/27/23 18:48, Bagas Sanjaya wrote:
>>> On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
>>>> Upgrade to 6.1.30, got crash message after resume, but looks still
>>>> running normally
>>
>> This is specific resuming from s2idle, doesn't happen at boot?
>>
>> Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock too?
> 
> Happens also when device is connected and do
> 
>    # rmmod thunderbolt
>    # modprobe thunderbolt
> 
> I think it is because nhi_mask_interrupt() does not mask interrupt on
> Intel now.
> 
> Can you try the patch below? I'm unable to try myself because my test
> system has some booting issues at the moment.
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 4c9f2811d20d..a11650da40f9 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -60,9 +60,12 @@ static int ring_interrupt_index(const struct tb_ring *ring)
>   
>   static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
>   {
> -	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> -		return;
> -	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
> +	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
> +		u32 val = ioread32(nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
> +		iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
> +	} else {
> +		iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
> +	}
>   }
>   
>   static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)

Mika, that looks good for the issue, thanks!

You can add:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

When you submit it.
