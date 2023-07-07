Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019F74B531
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGGQqF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGGQqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 12:46:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF351FEF
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 09:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJLQrLQjpjyYmeBroDoOk359Aw9iMSK/DYvczOy8hqhyyqnRnvs9nDGpQ/0Vvyqr/q6vEqSQdwgRltVoSd8vYseW1IwfHvenJvi/PGaKWh8eodQlVtbHh8A82bIoI4Eu4QFoxpWOEr24n3QghgWc13XKxtQO3wq3jAFHbv50ZCa2UQI/EWU/lW3T6t+K3Sj1HBszj4zi0dlfa+G/QW7e8f8EvbtHKRjYW5Oqt/UW5u5ld2cd2Jhql0oA+KA4nheCIkHWxIyw9nVCc6XcFBIMJrvYD5j1j4Zhf+z9o3ioZIpD4q+5vj2EAft9UijpiWspeUzLPHiDKSbD80BYzFhHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHGdvvHDFmFZGVinWQo1O68qe/VnRwCGfwTmQxvS/mk=;
 b=YNiD9mBcwupyP4ktJSNDZN0oZFp1QgMEF7OZlLkduHH9m1DAVWXnlelXwvGmqHe0hr5z5VecH1CDZIB5FqGQzQiB2aNQjknP4RhNqVZCEO9F5pkaRN+nQD5QWwlaCRWxh6fP5Bh9tGhYRTq9/jgRkmEa1zRFOTkvDvhwMsHiSGbxCxQmNzPORKQx0x6dacuGmZYNPY9AJ8LEvMIRnSqtPQQUDtfEKXQdXLkYevfkDbZh9VzvZ6IGvzBJdIACdKunDshF2rlN6m/02A43y2nPHSTMaeiRUuMEvoFKI6PmgfI+riuNuLJn0xhq5kF2rXySkIFdW2O9QJDSMgd4cGKR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHGdvvHDFmFZGVinWQo1O68qe/VnRwCGfwTmQxvS/mk=;
 b=fsDZvkwalL+AP7gp8cZW8J1hYwMamB9/1Yyi3OBH5AXJT/Voet5ME0MyyLCRogeYCbPr3nuA1/sxCzchBySi3sxtVhEpbX2yGBjTGnxkWkMfgWvb2gLearpvRvM0TIYVS/rkm53cKaMjmSMAL1vzSmrAIkCHceGHMAqIq1beS8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:45:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 16:45:59 +0000
Message-ID: <bcbd0e64-dd21-7d0e-7bcc-b700fe0674e3@amd.com>
Date:   Fri, 7 Jul 2023 11:45:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression in 6.1.35 / 6.3.9
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2023062808-mangy-vineyard-4f66@gregkh> <ZKLT2NnJu3aA0pqt@eldamar.lan>
 <4e04459c-3ff7-3945-b34f-dde687fad4be@amd.com> <ZKMcL6bG4RlnvHbi@eldamar.lan>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZKMcL6bG4RlnvHbi@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:5:40::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de5f665-0c19-419a-a230-08db7f09a47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGwQg3Ooqikv66xEUXNe616GYriAVNrs2Tmehgm+YOkvQ2YMV8YgswYV/5RrGyOKicEttdUm1iUBHgjDwYuoOszkDRdjBB5tutXryGX1WtgUiGP2Z17elfrJ3UDUVpl8F+M2MMSsxDkWs9vGUdknqEXhKiEsOUm8Axzwb41HVlSbr106xsJA0ZzRYgElidfUoLyDWRcycOqKjvoGNhzWDHFYic8abp9BEMosNHOFfiiQ7mqL+27d1OEAYoYFfLu7kqbfIrvr2CLWGivmzcNuBWkRpOkL1UUhAdOxa/eJTxgDPH3q2vhz3ES5zp3DbKdRwtP3Y8v9gryXqcj0y/LDxHk5qpDfvLeiuPYiA2tsObvkhvNkc6W9FVsD4Ab8Rt1nM+h/Tbjf65nfGn5dUHfYCmglIXZyVcGgkGY37KuOhOI490IA0FmyvjD9uZAFg6NuS0FIYp74IDir6jMRDZzy1BmgL0tXOnCpbIuqZwBITUE+9I7ORNgr2KECqlfj1TLMyeBlCvp7LGRPjy87zRcYBt+EqWEivErGo4XkWY7iuTFjT0cb5nnszqbow/xh2zZbQtVusS2m2eSUBRf7qijL0knT3UaWqSuQrNArdykkUThprSU9RiIPbYMMMoRhnZmuQ1q976rkGeH77L7OUT9trFMjw/sCfBuJm7SOaEHGQWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(66476007)(5660300002)(66556008)(4326008)(66946007)(6916009)(38100700002)(41300700001)(8936002)(316002)(8676002)(86362001)(31696002)(36756003)(2906002)(6486002)(31686004)(186003)(6506007)(53546011)(26005)(6512007)(966005)(2616005)(54906003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNIUEhMOC9lT3I0c0owZ0ZGUitnekJGaXlRQXMxaWd2UnpiWVJTVlZaSXEr?=
 =?utf-8?B?U0VCRFlHREtGWHAwUjR0UUk2dWlEeUF0YVRsWXZIcFQ3dkdadm1FeFdqKzNX?=
 =?utf-8?B?dGZOVTBDMGZjeTRHK3dPS1NiazFpN3lERVozS01LQllWSFpWR2VWSzliTlU1?=
 =?utf-8?B?aUJiekhReXdzT1ZmeUhmMmRjanFPWXhMRlZIMzgwZkp5QWVUdVZESXVWOWF1?=
 =?utf-8?B?RWpRa1hkTU9Zd01qaHVtem9tNDNsd21QWkNyM043eFhxVGt1bjdKTHduMVBC?=
 =?utf-8?B?OGxJa2F6QXFQbUFpdFNpc3FCaURLaW1RR3BaeG85SDExRDBNWHV5Unc4WDVM?=
 =?utf-8?B?S1pidG9OSmE3bXFFVXRYZkVJYUNUQkFUNWN4REVmbnpMQVlCZ0xYK3V4bVdr?=
 =?utf-8?B?aW1uaDg3VHNkYmt1NzJIVHk0dTIwb2oyQXhuTDhoMlRFbDZCRmtncDhzQnZw?=
 =?utf-8?B?TUtHOGRTdjlKeGpJTG1hb3dkcWJXKzRXYkU3YTNjNmtUSW0vNHFaYnNzdlJi?=
 =?utf-8?B?WkR1alQwWEw1bXU3aWI0VmRQSzNobXBsdU54MWI4Q3RkUFZvd2hhOU1nWGRU?=
 =?utf-8?B?VEJpc2ZWMkdiR1c4Ty9IWWt0YWFaNVMycDhBMnp1UHpTSTBxcTZoa1MzbWVN?=
 =?utf-8?B?ZnhYME9RM2g2ZEhtNkdNMEsyRlB1blZUMmdyTlRKV0Jqa2JKampWbWJBUHpS?=
 =?utf-8?B?L0RkRCsvUUY4b3NZQ05mUUR5b2YyTUJ6TUg4YTBxNzVHUXhmRDVjUUNuWEtL?=
 =?utf-8?B?d1kwMTZoc0NyYmlWK0wwc1hib0U5Rm1wSVdEN1VsTU45NkIycmtMUHFxRVN3?=
 =?utf-8?B?cUtyK2xqMkNBNEgwYlIwczUzY0J1bWxsUnNUK2wycXY3Z0hIUVlvdzNLNTNs?=
 =?utf-8?B?K3Bxc2R4LzJ2ZU9pZnVjQTFvTTNnTFM1WTF2WXRtNXZKTXYzZGE0SUpVWkhx?=
 =?utf-8?B?VDZkV3NzU0wvNUlFWmF2b2lQYnNldHJkZnRQZXpHVko4WUxQY2d6QjRtQVo2?=
 =?utf-8?B?K2ZtcFBqY3dlNFIxd0VuQnBrQTFtZTYvVXZlaVpURzViVHRoNDdPOU5FU3Rq?=
 =?utf-8?B?V2QzSFd1SXMySFgzVDJJS1Z4d0tyTWxNeGpRUWJaYk13WUFEaTZ0Z3g3OXVS?=
 =?utf-8?B?Qkw2VEpKZHVsSUg2Y0FUbk1DVFFWK1FoK3hjWFo5T29qbGt3bS8zdFlaWGcy?=
 =?utf-8?B?SldqU2xlZFhOSW02VXpRNWFTRGZ4cnJBQmJ2VjF3TU9nYXJ2OEpjUGFxdlVr?=
 =?utf-8?B?eXU3YUlwc1BUMHpoZmJnNUd5ZWMzdm1rcmtjQjhlM1MrS1lNeWFTbG1QVFRm?=
 =?utf-8?B?S3J2cVVwd2h3K0x4NitFeXZaODhKL2l3bjVEa2xNczM5Ykt5bXpYRHEyalor?=
 =?utf-8?B?MkhyZXhmdTBQTWZZU3BRcnVFS1JZaElYU3Z4Yis1clBJbmZhK292NmVvUHI4?=
 =?utf-8?B?RHY1SVlpMXk0QmdPSzZDSkRJOFhKYzNDOCtwRGhWUzY2RU5hME9kZmZ0QTlv?=
 =?utf-8?B?NUxEcHhZajBrbmRpcnJweThDSklaWmdFNTlKVXRJWXRXazNRRnF1c3UzKzJ4?=
 =?utf-8?B?Z1hEK2M2eUpiQTlUY0tsblQ5WmMrLzVhK3hPb3JjVnllRnZJYXkvc1VwRW04?=
 =?utf-8?B?VWx3N1owL29YMnRkL0FWOUlpSDd1cFEzRS9ZUnpMTWVCZ2swNXMrL2VoTGtt?=
 =?utf-8?B?NSszV0kwYjBXeldWQ05XNXpMeDVxMFZoR2JCVHVmckowaFlnM1h4WnVNcmUz?=
 =?utf-8?B?YmVOaFIzS00vWStubFoxaS9CWmdNZVdFUGh1c1Nub2kxYlhGeDBKa1NjRWZm?=
 =?utf-8?B?ZE1ja1FhVlRlRjYvY05SS21HZmtzVHlpT3NvQ1poNHZZcUNGVUFMUnQ5dzl2?=
 =?utf-8?B?M293aFhiaVVvTUZKampQNGVYbHE2MXFud2tqMTBNdW1KbVZRTnMyTUlGVjhF?=
 =?utf-8?B?YVM4VkRtQXk3d0srS1o1K01qam9RdzN1L2I1N24rTCtwSURpQzErU1p6Wklk?=
 =?utf-8?B?cmd5a1FGSG16VTI5NnM5NGxSNmtmaVBnWnRiU2l6UEtBNjljLzdJTDdMSmZJ?=
 =?utf-8?B?N0dES0Fxb2l3eUZhc21NMERjUE5wUVFFM1E3Z1dNYmpDNldrS1l0TDVESXJE?=
 =?utf-8?Q?YPf8+fyMS8cy32FQG+L0gcBrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de5f665-0c19-419a-a230-08db7f09a47b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:45:59.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBAbzGdmPwUsF7Zu9q/ejMxMWVzI8tFt5N0obdyYTGnaQf6oEvqSjnmI2orvKrHy0NmpfjdYtKDJU0WKSAi9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
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

On 7/3/2023 14:06, Salvatore Bonaccorso wrote:
> Hi Mario,
> 
> On Mon, Jul 03, 2023 at 12:43:06PM -0500, Mario Limonciello wrote:
>> On 7/3/23 08:57, Salvatore Bonaccorso wrote:
>>> Hi Mario,
>>>
>>> On Wed, Jun 28, 2023 at 08:16:25PM +0200, Greg KH wrote:
>>>> On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
>>>>> [Public]
>>>>>
>>>>> Hi,
>>>>>    A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
>>>>> e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
>>>>>
>>>>> After discussing it with the original author, they submitted a revert commit for review:
>>>>> https://patchwork.freedesktop.org/patch/544273/
>>>>>
>>>>> I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
>>>>> trees to avoid exposing the regression to more people?
>>>>
>>>> As the submitted patch had the wrong git id, it might be good to be able
>>>> to take a real one?  I can take it once it shows up in linux-next if
>>>> it's really going to be going into 6.5, but I need a stable git id for
>>>> it.
>>>
>>> Do you know, did that felt trough the cracks or is it still planned to
>>> do the revert?
>>>
>>> Regards,
>>> Salvatore
>>
>> Hi,
>>
>> It's part of the PR that was sent for 6.5-rc1 [1]. Unfortunately it's not
>> yet merged AFAICT to drm-next yet nor Linus' tree.
>>
>> d6149086b45e [2] is the specific commit ID.
>>
>> [1] https://patchwork.freedesktop.org/patch/545125/
>> [2] https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6149086b45e150c170beaa4546495fd1880724c
> 
> Ack, thanks!
> 
> Regards,
> Salvatore

The revert is in Linus' tree as of this morning.  Greg, can you take 
this back now?

d6149086b45e1 ("Revert "drm/amd/display: edp do not add non-edid timings"")

