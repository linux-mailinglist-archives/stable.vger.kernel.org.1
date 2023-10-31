Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F107DCE16
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjJaNmp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 09:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbjJaNmo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 09:42:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B129F
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 06:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhV0Wquobzur28qXNjb3y0HbSRfK8YWT0VX9Km30hRVx9AXiODEyLRXlqKSWTDxLPtMaxzRZnAEmUB509/MTCE0ctP7t/36OW6p0NRva/VZE4Q95iHPdF8AZkuIk2D6AUNagwAgsIbNhFMJ7Md4C0cwIh3LSuBQLQzcN0i6UDKmCjSTD59AnyGSVw5PJILNaxMnvvBEDQRQFZpy0NVmuz8Kprmp6nUpK7AGsxY2T6titRUZlwTq0K1PBVl42kC+DT7YZkuHraX37ecRBITxpmbniKWntX4IA1i8rHVfQfyjxsvP9jL5IjtIcUT+b0U13n/Xp265GGh934ABkiO/VNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+qCbEHVNLlt8z8Q4RZIQFjsngyZs8/WsRrC/iLAG38=;
 b=h91Mp6Srucdcd6tUkzKDzp5hwgrYBF7mAl9cG7Ih3snQgFVE5QYNUhBrxMbt/EZjxX6w6UKQNQusMRT8qv8weKc3OxjNbZzt4Tf1qUHG0pRgyrD5HJruZZCCYNx+IzQQcOF/x5d4v4DoKgpRiNu8oLcZUwh7e6uwNNyZ6G/s/0iZirr6uaWBHOlyDxtwpHrfu/iMKW7B73ZKRMLmYRxYxHbvrwZ6XSldssD/tfdSfzGqi5VUqRd7SqXxxk/GYdLj3e79Yewb+V72NVTwlzKsK4bcCTQEKhK3ARekzHDYyOXXT8Umvjlp91BJLlCf8p+g+Co3YrXLOVsYjleFuABqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+qCbEHVNLlt8z8Q4RZIQFjsngyZs8/WsRrC/iLAG38=;
 b=PxCk9zD/GX5zQnxZcH3iBMAnOZAdPTF5DHaTorbVbHBensKMsNWVmtVxEHQVQuMd44CvldkKWxx5k4pvhGPLrHZTY9LFQbqqkp8lcdSo2vt85r9XzDKOIdHFYdZR1s9sNACCaZmKIi/xYABGtijp95JHCmHmrxPwrqZbPTIiQFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Tue, 31 Oct
 2023 13:42:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 13:42:39 +0000
Message-ID: <d8bbb3b4-25a3-418f-9ebf-545d1d826265@amd.com>
Date:   Tue, 31 Oct 2023 08:42:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 2/2] drm/amd: Disable ASPM for VI w/ all Intel
 systems
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
References: <20231027083958.38445-1-mario.limonciello@amd.com>
 <20231027083958.38445-2-mario.limonciello@amd.com>
 <2023103136-shanty-fancy-f3fa@gregkh>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023103136-shanty-fancy-f3fa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:5:100::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1a0fe1-6718-49af-2ddf-08dbda173fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pQ9HdmZZqDxRa/r6YaZ3GXWIfLtHF2V6880fEpcgD9Dm6yY+qkebdTBw6DAFqmX4JsqbSTAuiJdeVlbP6BZGgNvdx+gdQWqPRvwhpTbqNMVp1ZJTKwmjejGSn6ObTyJqkWlp+KDEpsUp5vSm+pBrWegMADLYvu5XwSD+sbowmhB+V34xQZRdf9OJOQbPK36MHyuHnhAcbOyl/VJMgo5EyDB99WSn9iwW2babyvYUmiLQCm84hRUG/Jljamjkhv7/PQIyGMLFkmd8sabLTIeS9irV/rgr7GwX67guqVeHSv5it2REHtmvZQs7Q23mrKKG67CzSjDcVX+ofcPk0LHagCumxp7WwfH58R0+7Gp+P/lyvNAFl9Ll5I4NSWi7umhNlJc7dwMxf02MoEsJW5KKTwmv3jZ42HG3yXemVOrXAhd7vH2G54fg+2ccnLt2K1qNA3BLZF+G95EEmL0tSw2p2erSY3QTQ6s6R4u9XFu9dqIcR2y6de8DoMYUTb0q2x4x3rGnr26g6D83f36gU2d+1gicnsJduoszAHHC1DPQ/gkMOZ3hBAv4Mg4zTanjjjs69Pll0VHM6RdqnSsWXUMePU66kPrxzmuRTRHantDpe6rMsuszSrCbVvs+Vs2rjNaQpXhh5X5WXw9O6Se5IpzqZqdJo6ejeWWqAH9zZm9lZIXDhi3ptTjlAT7Aq4ApTGs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(36756003)(26005)(83380400001)(5660300002)(6506007)(53546011)(2616005)(44832011)(8936002)(8676002)(66476007)(66556008)(316002)(6916009)(41300700001)(31686004)(66946007)(478600001)(86362001)(31696002)(966005)(2906002)(4326008)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhGeElmNTRPY2tPR1dNcGk5Mnkvb1MwSHJ3Y0c4RXlaUUpkb0EyRmNrazg4?=
 =?utf-8?B?T1U0NVZGYmJsR0p5SFdISGFBNUhpQUE5WnMrcmIrVVBPNnRsTnN3MXBPaTJm?=
 =?utf-8?B?QjJLdGVNREszOEM3T3ExT1krMnF5Qjg0bDE1WmlWTjI4amovcDFOVEJyTXJU?=
 =?utf-8?B?Vit5dW5FbmlObHNiMG0xaHM1L1dLdUVOUG9nejI4OGdMWE9WbEtGQXhPdnov?=
 =?utf-8?B?S3lMSjIwMWIvdTl0UHRiOC9UYmJoUWJGaEtsd2FZajhnRzFPdkpVK2FDK3Y1?=
 =?utf-8?B?TUU4V0QzL2ZHTVdBUUhLNWhrNUJMbmlKSjlqOUdDWURQZzFCNWlnTDBwR1F0?=
 =?utf-8?B?OHF4SHBaL1dURmhxVUJNeWx3VUtRZ2MvS0c4TU1UbW5WTEU1bmZzVG5MbGRX?=
 =?utf-8?B?SUZLZm9WMFNDUFdEb2ZrczQ1SzJVQk9mVDRlUlo3dEtWWHJKaFFUSFZDTzJS?=
 =?utf-8?B?ZHJjR2VSKzl2RTNnNW5xTERFVFVCbUdneEhIZHdhRHRIYVN6RFJSRDJlN1Zz?=
 =?utf-8?B?RlBSVzRmVy96cnpZZS9zOVZTNzRLbHRLREpMOHlJbDRpblRxenZ0RDlHdnZ0?=
 =?utf-8?B?QkNOaUgrZk9yN3ZvdXU0Wm9wNFBKemphWWZuenpJYnhsS1hGbHBiSnNqY2t0?=
 =?utf-8?B?d3RFOFFDcHYzSHZBQzQ4UER5QWd4L0tBcjU3NWVPQ2UzcmZId2o4OTJmSW1a?=
 =?utf-8?B?YjdLOThNZE5KdHJFY014RXozRWN2cXRrYm5vNnRWWng1VVhXelVidjE1Y2sv?=
 =?utf-8?B?a08ycnZEZ2pjeCt5SDYvUEd2TEp0WEsyYnhYcms3Q0pzdElLUnlFRDlac3Jh?=
 =?utf-8?B?bEd0ektoQ09CbFBNOXRod2QrelFmNWErazdEb0QrdjM2T0grZVozT3hPbFhP?=
 =?utf-8?B?aHU3TmRhaFVqTG1XVklxaXg4SDk0Vm40RUFOZEwwaVgyVk1UUURDeHFRQ3A1?=
 =?utf-8?B?QkR5ZWVJMVcxcnp3YVp0TUZnNVZHUUt4Y2ZLVm1WNUdSaTM5WE1scWYyM2Yy?=
 =?utf-8?B?c3ZlRWxndnRwUW9QUVB2bEtZRlVrNVVuQmFNQ2cwNEVQQWx1VzBBQUUwRWJ4?=
 =?utf-8?B?OGVlZFQ2cmJWUEp5MTFRc1VGSXM3TU1ybm94NVR2VEV1clhvTWl0RTRUQS9E?=
 =?utf-8?B?Uk5mektnbkRydmxqNnBxak52YXR1Qkk1NnlZNHZoUzRYT2tuUU1sbFVqWHVx?=
 =?utf-8?B?RnUxNUYwNE13Qk1FVnkrU016ZzhSMGNOY2ltQjZhU1lWN1dUbE5PdEtyTjFB?=
 =?utf-8?B?NFh4QWVMVCsrVUFpajRaNnhYdFJjRHBLT3RDUU5xZWhpZmw2NzEwT2tCOGJw?=
 =?utf-8?B?WWNZUmZRQ3N4OWcrNHA3WnN2K3NCam5aMXZpTWY0aDgrZkdidGNpMHFQTmlG?=
 =?utf-8?B?TWp4eDJSN3NndnMvSG1sS2ZjSjZhVXh4cnN6QlE0a0U2VTZ1L29HSUlJZjg0?=
 =?utf-8?B?OFFwa3Vya0RRTml0OWpTeld3VG8vSzlyZGZEQzF1aEpFd21mckY1T29teUFV?=
 =?utf-8?B?TXByQmFwRVIzMmwyWWFTWHBYemJsRWEwNm1uS1ErYjVXMTk3dzdKMUEvSjND?=
 =?utf-8?B?RXh6azE1UlhTdFFjeDN3NWVvVmdRMEcwNVU2VWNacXlWRXV1ay9td3IyaUJt?=
 =?utf-8?B?NVlGcDNlY1gwVVBYZWtXeTV2dHN0aU9ZMG5iUlFHTGxGYS9HZm1pOXZCUk5a?=
 =?utf-8?B?dDNlSnZiek9FZnNrK00rYzBVK1BJWnA3KzcwWkx2VzFZdnh6N1J1RGd4MFpF?=
 =?utf-8?B?aXhsWWVSSGZqdkdHWm5kVWZQYkZSUDhhVFlKaDIwb3ZGMGozdldjdXJweUN3?=
 =?utf-8?B?N3hxOVNUM2NTb1NhdkRRS0Q4MGFMY0dqQlc2OCtCMTY5eGkvbjRnMzZrWHRV?=
 =?utf-8?B?Y29WZ1NuY2NMenV4aEFwbDNUVnRBeEgvSTVNTThNanRIKzdReDhEa0pFYzY0?=
 =?utf-8?B?VUhUK2Z6ODRWMXJNQVAvUzRIN1hrL044dW01elRmQ2JCZTk2aGhERVhMeHVq?=
 =?utf-8?B?QjJ3bVFiVFhtcEwrekI5MXVSc3ZzNVM3R2M0UlZ2ZG9LbjNkbWxjVmpycnVL?=
 =?utf-8?B?amhwd1RoYjc0Z1gyWTRNRkJaWU93Q3h5SHdjT0c5bHhVQy81TjFjVjc3QzBn?=
 =?utf-8?Q?RnfIt0oOhnaMMwrGF8baW+z3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a0fe1-6718-49af-2ddf-08dbda173fc5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:42:39.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2zWZGfG98Dcl3BbbvRQvVnOnm4MHjX69bbDrWSin340XXniwMIQBQSD1Jas1jdi8QKVjVpUmyYVQ4bsUKfj+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/2023 06:51, Greg KH wrote:
> On Fri, Oct 27, 2023 at 03:39:58AM -0500, Mario Limonciello wrote:
>> Originally we were quirking ASPM disabled specifically for VI when
>> used with Alder Lake, but it appears to have problems with Rocket
>> Lake as well.
>>
>> Like we've done in the case of dpm for newer platforms, disable
>> ASPM for all Intel systems.
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
>> Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
>> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry-picked from 64ffd2f1d00c6235dabe9704bbb0d9ce3e28147f)
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Again, what about 6.1.y?

6.1 & 6.5 queue has it already:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.1/drm-amd-disable-aspm-for-vi-w-all-intel-systems.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.5/drm-amd-disable-aspm-for-vi-w-all-intel-systems.patch

> 
> And why aren't you cc:ing all of the original developers on this patch?

I was just looking to make less noise as they'll get it when it's added 
to the queue.  If it should be part of the submission to @stable as well 
I'll make a point to do that in the future.

> 
> I'll drop this series and wait for ones for all relevant trees.

Considering my above comment can you please restore?

> 
> thanks,
> 
> greg k-h

