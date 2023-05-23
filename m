Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428C70D3D7
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjEWGTd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjEWGTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 02:19:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C0198
        for <stable@vger.kernel.org>; Mon, 22 May 2023 23:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itFOKmB2w7cI48gLWorLKuWN3Q9Fpnns+CRTjAyxWEE4F3SeeqGu7+2at0POFdfDpcJ3tCJsxHGlJJReIlYBit4gpxOfTT4Qxmka786ckiI/SUi2xBUQdknod5aZC/HhOwrtE0OB+MOj/VsTZCtzxYwkNuTYCcFXy411kQUhiVZ3B+2NXoHQHmLql2bEKeknbRFIfKHVxdhLkvpnlRfIGKIEwa73d8taDRhQe/yLEKiStAbvauc6h7Epuy+so0xl3t+clO0b/VwZVBf47dN1/0sMOW0ww35iRQ8r+R3a9T47MJwkIL1TWk5/MSFJYYSKKr1v2OKhhlvcBWGeSz4tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIMreg0qE+bxp9Pny0DnOoxoDCMI4M+wh9azbqOpYjg=;
 b=blZi8JX6k5WBL5rZettGNU80PN1LTDBkkt3gnqgHrbHy1suNwrf8TUURtYhvy1wVKUTrXYf8ICTQVnucu3Q1SpIUHlltdVgoXREm4YaeUJMcwR9l5YzN/q7wLwgXKf95ZsRhy6GGrv5ScZRmdWP/2GN9ODM+riIiUHL8v6h2MF0Lk8rsa5EZSoy69R34TboI2Lg7uXXnr5LhEoj1yK/XOP2dJ/f5//ucohHOUaSHGWSZEhKH+c9uUsp6pteaYY80t2k9JJ4YZz+u4ZQ68aiq4U6O6Ju4leXnh8BYMrlexjUwppfzGSX0xKZbGY2WzNfUFeKoIfWcxW8k1p8e1E4uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIMreg0qE+bxp9Pny0DnOoxoDCMI4M+wh9azbqOpYjg=;
 b=eZghznVC6cwqrTue2aAZeB4kNR4GsjdZaszE7kf6gRHZgfiS8I7ZsxGwRB6CQB3vwP45dDAW8iMtJ1hZUBvuGKEJ1QyMldGF7wmB0xFK29xv8IkUwRrKHIjd6gZE0tAATIExxkd0zl0dN/k1pGnFfyEgSWwQZ8TcBLw+vy/wx3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:19:23 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:19:23 +0000
Message-ID: <19e04104-0ff3-c33a-3649-0b6f1f32c2c9@amd.com>
Date:   Tue, 23 May 2023 08:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FAILED: patch "[PATCH] dt-bindings: ata: ahci-ceva: Cover all 4
 iommus entries" failed to apply to 5.15-stable tree
To:     Damien Le Moal <dlemoal@kernel.org>, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org
Cc:     stable@vger.kernel.org
References: <2023052249-duplex-pampered-89cb@gregkh>
 <5450bd82-6a2a-7147-1b99-8c0e1efc724f@kernel.org>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <5450bd82-6a2a-7147-1b99-8c0e1efc724f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: f51603ec-292f-4fd1-073c-08db5b55a66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJphNG1oweGt1VriFWsUH10Cn22W8RBd2XZhKWDakSbR/JbRcHyWnOVtxqtRt03Pu8n7SzALDcdEOO2Pyto6dxFoyWkS10+7BzG+EnOi73iSIhteITQAXDUF7c8NLGdHdtpx3nH7zn8voBGCs/2SCj1d2n6UVV8AyKIkE5wxnZ58BywbLGT7EPYyRPj7bQw9+aaKV2xmi/Y3+Qnv+l63ReYhJIlCs/PKX6aL3nq6pXfg+U/S+s7sx5cpcpY01tFMLc9yIWczz01BmiJuNMy50VCMtXhUYPOyuVnFggFkhkQOxcS7iOQ5p+5awTwLIR83BB/oMpD04AhM146SDyOxgYFYlhB7F6CmyjNu9+vCArsbt72bIxaGT38neZQ7VQbURkDt3ko5JDxhYuhU962BSV2OBnXfAvLOpx6+iHuU3CxOmndBFppe8PogOO9joAT7UMPwVx0sFptDogSYbbucLzFtajoL8uwCAvVRYk7Zbi11LBoBlVg2c04Dg7hpMrlO+N04s9MkbmxAeyNfpFIO6GO7GlMgnE63gGNaKsc5j9UU0CpCRuYzVa58VJ+aFj7VHRxpa8Ibp/ggZ9io7Lc0SlQrVTMJkBDAkKL159loggDkUX9QcjCyiiTheijzVvah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(31686004)(66556008)(6506007)(26005)(6512007)(966005)(66476007)(66946007)(2906002)(316002)(186003)(4326008)(478600001)(38100700002)(6666004)(2616005)(6486002)(86362001)(41300700001)(53546011)(31696002)(44832011)(8936002)(8676002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BSN1NzUmNQT2d5aW4ybjVJYjFlbkdVeDV5ZVZEK2FvMFUzSEppUTg2L3Bl?=
 =?utf-8?B?UzRMN1lRSVFFaFBMaFFFSmJKYVB6U0pzczB1SnlCaXBIa3VXT2V6WnRZQjRt?=
 =?utf-8?B?U2J3UXBtb0ZQQWRJSXllVEFrZDE2Q3dwZ3JTSmo5TUJKNjFKVGR2d215d1lj?=
 =?utf-8?B?bERoaFFlQnRRZFJwRnNSK1NHZFdIaUl1aDlnbHdDOWNWdW1FUVAyeFRjT3Nm?=
 =?utf-8?B?MCtrZnVZYXQvUW1GZ3ZFb1dQeS9UODlLc080NGI2c2JYc1pVTmVrYzIyckw2?=
 =?utf-8?B?eTRjaDdXdmszaXNBRXd1QkxjSFZvN3k1aWJUSFRzcmhLOGhoemFaMHIvNGVX?=
 =?utf-8?B?a3N1Z1JoNGJUSGVtRitValpGVmpsK0FDdWNpQW1QQWMyRU5HbTJuTmlxUGJH?=
 =?utf-8?B?dXA3cUlyTlA2L242WHE4cll5VDNKK3lnUWh1T0REQUhLM0ZpR1dtdkJBazkz?=
 =?utf-8?B?MjZPWjB4Vk1jWFV1YStVYmNvRGRwNjltUUdvcXpqRmRGKzJEWlY5WHp2bGJ4?=
 =?utf-8?B?Zk8zbm40d2FkbE1UU0JqWVNDd2hpNzdBcTF1OXVEb1kvbFBNNE15L3c2c1lQ?=
 =?utf-8?B?M0NuV282RXFRMHJFOEtic2RSVXpVSTJySUcxSnlLT0dCTVBueXVGSndvS2RQ?=
 =?utf-8?B?OGlWR0l1cGtsRVJIRXgzZndmSzY1U09MRjllbC9Za0ZFWWk5QVAzaUF1bmJY?=
 =?utf-8?B?UHBUV2FyVWJkb1lDWDhvS2Y2MW04NFI3RTRFc3Z2MWNoY0FEMDFBUHZ2dWhq?=
 =?utf-8?B?ZGxNYnU3TkkySXlwaWZlWkFXdXdETjZQRkQwaDJNYWw1NE5BOG53eU1wSU1V?=
 =?utf-8?B?Z1M5ZjFPK0xCN2hUQmtFcWNjVWc3SGpHeHZBN0l2Q1gvbkVQeGJEaDd3TGs2?=
 =?utf-8?B?VjdjQmR1dENYbHNFVGRJc0huYXIzODJkNnRuUVc0dGkyemdUQks2TTgySEMy?=
 =?utf-8?B?cXJhMmp5akVpTTZpN3FNc3lxZkJrYkFSUkJhSXBPODZKRUQ0dnpxTUwrenRO?=
 =?utf-8?B?ZGpzV1pZS2NzZXMzMlpFaVhoaEdZMk50NGVLQnYwYWpvMWUwN0FndmdnRmdI?=
 =?utf-8?B?Y0RJcFhUU2Z3VjM3UjZ1WUE4Z09WN2NCb1RWanhhNVorYytwaG5pbEd2bVlH?=
 =?utf-8?B?T0NtZFEvaUprbllQM1BIOW9rci9oMWp6N3V2a0hMNTF1OXN3UWJpNi9qd3dJ?=
 =?utf-8?B?MFpGUjR1Wlpua280em5qVmloT2l2cmNPZ0YxZ25NaTdDczVqZVoyU3RmVTBK?=
 =?utf-8?B?ekNZeVYvWjk5dGxlWjFqVUc3WkxlSzNrdjVIMlZUYVREZFJZdkxhdUszSlRB?=
 =?utf-8?B?M0FPMDR0Mk56VGc4UFd3dzNWSXZHMjRCQjNVRDdPaUkvNW8vMm9JU200Qzdw?=
 =?utf-8?B?TzZYRC9NSWZ4b2xaNkNXdGZzSHFXUEVTUllIemhCWjNpVyt1Ymc2bXF4TTBQ?=
 =?utf-8?B?YlFUVkttTThtK0UycTVTU1hrSHdxdXlsbXh6TnNGblpVbDUyUytUZGphUlNy?=
 =?utf-8?B?NndwVi9zWnBNRmI5YVlNN1BSTEgvdzNXMURraWNZZ2w3TVBiditNWVcwRC96?=
 =?utf-8?B?N0FYSXdkQUFRMG5CWVduc3Fic2tra251UjRzRzdqUkJJbW04L3NEREpxRlZh?=
 =?utf-8?B?WjNkeVA2NlZsRmFPenlCUkhWTnBFNXlXMUFpcnNZVG13RWExQ2htaHg5ajVt?=
 =?utf-8?B?ZDFkUHV1V3V6TzBEVkFxR0dPeG9nd3NmWW1oa0VkRy80TUZia3lGRlRyOUd1?=
 =?utf-8?B?bVhUWGZZWnI3YTAwbzI0TDdNVm5JNDhDWG5lMGg5SlZzbm02Y25iTEloMHha?=
 =?utf-8?B?aUdNQU5WZEJyOThXckdHbmJhV3hxN2tmRG9tVWdBS2V0ek1JNUZPZEtFVXRP?=
 =?utf-8?B?WGZybnpoeEIwZy9BRFhYUnVra1IrZ2Fna2JHdlgvWFg0ak91Tmp6K29KSElG?=
 =?utf-8?B?YXNEcGg2SjVkTjZ4Y3Fta2NFdlo5R0RNTkUzTUJWaW1yVk9Gb0o1Nk1QNHBB?=
 =?utf-8?B?cW04b2ZLSkRhZDUvRXM5aDJwRkNhQm4rL1FISjBxRlRPS2M2M3NUV3JFWkJk?=
 =?utf-8?B?eExVRFM5aEg2eWtrT2V2ckYzUXppVjljMG01OEdRaEc4OW9jUjRzTDJndU9s?=
 =?utf-8?Q?mgvW152W1VolkjxNv0agUhJBQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51603ec-292f-4fd1-073c-08db5b55a66d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:19:22.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9466SOGUAO+DkH48XGUh7HYJK/eeGS0QzEWQkQ8iPxgCRw3Z8I7xQKdbVGEagWew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 5/23/23 04:25, Damien Le Moal wrote:
> On 5/23/23 02:58, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 5.15-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x a7844528722619d2f97740ae5ec747afff18c4be
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052249-duplex-pampered-89cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>
>> Possible dependencies:
>>
>> a78445287226 ("dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries")
>> f2fb1b50fbac ("dt-bindings: ata: ahci-ceva: convert to yaml")
> 
> Mikal,
> 
> Do you need this patch added to 5.15 stable as well ? If yes, then please send a
> backport. I think the issue is that the bindings file in 5.15 is not yaml format.

I am fine with not going to 5.15 and earlier.

Thanks,
Michal
