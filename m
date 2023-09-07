Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B77973C4
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjIGP3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbjIGP2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:28:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042B1FDC
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSRaNZbadXABLASGSCD97ljDgDEd+YYOXpeARDwtQ+kfOS0LqX004kn+lzk03vQ0G/CJu72Xnnsu9ZTpS21AM1AlWvRXChecs7dFCr427cHPcD6ul1CNSO9+G2ChYEkrDQPobtnV1afgRX2SRA1pOT15DV3ckIBBlQk2oQRsRfDtYdfl7nqyphy4VY0Xk6nvpYWW3R/ehT/9nyNzpSesj54h7Jo8obr8oHMPvHF2SEt1Efhe2zbhZsIew3qVNaNe66V2NOpwnaRUrYcOlCOr+O85jS+Q5c2XB4mgxhUHFzgP1K5l0EPNYORsTbJTWyoX7tjgfVWDO7LAuN20JIeO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9SKKhqt3a5mGjZ1qAtSLbalV8ZkI0DtLNJJs9IwDSM=;
 b=JnIp/QQXaSBppJ4Em3qNBwHoDbaKexbL7Gwu4i4KrdspLPDrHY0CK2H6BEhERtIhA+aModqZcfsNWhos+my9JlWZen4VfBeCq1RtAOK1EDp7YZhainaTaj3NDqqBVNQypebdqgjn/RgkqfJhSg7Z63YNvIRfikBK3RCf0bnkrqoAsCc1axQ6UHlJnprImGX4CiMThE6CI/nhY/4F1GgqHbzJgf64L8h3UKyGRbSKkodzWkkHHe6xcpDApi0gYDplUYpLuUc1SiVneGSUoRsICQZZaFUtfpfm6Qf2ucbxL+0mVQB1xItY9LGrtqHYPF9XVb20ZJPdWSMhf5kvj9p9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9SKKhqt3a5mGjZ1qAtSLbalV8ZkI0DtLNJJs9IwDSM=;
 b=jZwVeLU7SWaeuC7ppmqnia732IK87VQIG4u2ncsZPYGTQjx1UYDgiomYj04SOAtduz+NPai846kHRJWwEALxdqOUcxo+MSvJ2gxKBwzkUvFAF8ySYGtMrTfZ3zwUUO+l8nhyZ4xe8E1HNOZmBZc92w/vbywljdnhISwEoDWt918=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 7 Sep
 2023 14:06:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:06:18 +0000
Message-ID: <2b6d2117-b76d-4e86-87ba-48ebc6da11a9@amd.com>
Date:   Thu, 7 Sep 2023 09:06:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.5 black screen regression
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Michael Larabel <Michael@michaellarabel.com>
References: <074d84cd-e802-4900-ad70-b9402de43e64@amd.com>
 <2023090729-struggle-poison-4ebc@gregkh>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023090729-struggle-poison-4ebc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:6e::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 519580d6-c3b4-4fc6-c162-08dbafab9b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/DjuG2mBSYwaGld48K6VCS9y5HTGcdNcc+7wi1dz7T0DMoaCcVR3GHIwJASUiDxB5CCO5IlQIO7FeC/F+dsl3AzHsF0Q+vP5q7GgeV7c5U8WIHH7DVz2kXiaS7NVvE1r/1vp8VEubN6ul6Pd7E/cW26k0qx7EcZfBo8onWMreFbZge9TGW8wwj/kMXP7Q3bbyK91upTDJ2ZdLDmITBeJCG9hFlM+i2wxRgI+lf6oE9NtFY9sK/OgreCNpy120YEul/3FJBn0cTGC6rRRiiIfxpJxmhb0wh09FBV9Mf+ZMFy7/KDVLxezCR4HqkKufEL0U4zihHozR/681G1r3BFYVRiIohtH8BQX5A0gdW2XoBswmejlmWRQPu2+ApqXSAAh9Bbz6eyT7rZBeExuf60jdRMi2GTYH61fZpSMXzBJaGtL+UeAvTV3GJl7LHLjNtnoEXpIYdThmezoNo+D9DSxAIzkUUgvboxG8BgzJaUw5oOGQK529RdVikPysTs/bwl3qvmmTNGyYTPI2ilf/pSuJPXLvLkhLq45WfME9AoflzRX7EfopaMR0hfSvUhsL16Nt6tnGD3sC5cI18HZ5FSHF0L1mIjL66tbKYDOaMvu4YxBlCqm/fp48i5Purn2DQ1rwye14SaJ67BXcp7HfqVZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(6486002)(41300700001)(6666004)(478600001)(86362001)(31696002)(2616005)(83380400001)(38100700002)(6512007)(53546011)(6506007)(26005)(2906002)(66556008)(6916009)(66476007)(36756003)(66946007)(316002)(8676002)(8936002)(5660300002)(44832011)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVA5aCsyR0lCYzlLZGZBMW5SZlN6clhoVUhESTJ3dXo3VHlaSnF4WnJIMEl0?=
 =?utf-8?B?T3F5blEyMm4xTytwbHdnMXVlWGlBbExnSTJIZytQUnJYaXBIZ2xGSmR4TER6?=
 =?utf-8?B?MXRndE9sMVZJckgwZGZDSGkzcWpPOXQvdUxwWDZscGp4NU1HeXRQNHhsN0ti?=
 =?utf-8?B?YUJiQ25oVmtOdjdvdVhrMEExdW1LcklmNFNmRVYxZ2QyL01rOVZub2Q5VjNi?=
 =?utf-8?B?NDFTRU8zdnZtb2NCYUp4Y2d2bzl5OHRUckM1WS9ydGkrSzQyR2FkMXBlamZt?=
 =?utf-8?B?K2VnTDdaT256aTJ3MVhnckk1Y2RXaXE0T1dJcHVlN3BlVHpsTGZ0a0ZpZjMr?=
 =?utf-8?B?QVBjbC9LRFZGTVpML1ZZT3ZnRU9udGlHQWVoNld4M25zNllUYldvbWdHUDlU?=
 =?utf-8?B?K3FFdGtGeDhLajllWmgvMjA3YmhWVEdMb2RyWHM3U0dXL0xTRkRBcUxlYktZ?=
 =?utf-8?B?SWF6RTN3NjNTWi9SdWx2TUtCd0JPTEFiTXRZNE9Ca0oyWS9yK0lpc21TdXFs?=
 =?utf-8?B?NUQ5VjU4NytKYTVGMm90K0FCd0grbEhtZFB6U3VhcFdBLzZkSHJxRGw1Tmdp?=
 =?utf-8?B?UWtJVzRONVNhNVM4a0lYVjB5NGtKL0tpM1FWQ3dJbXZHYWFpU1hRV3loMGxz?=
 =?utf-8?B?UVpvN05UNHBpRUEybUhJTERnaStnTHBHRWVsMVNSQnhDTEJxWXRQRVFBN083?=
 =?utf-8?B?d3VhM1dkZUtCSE5nZms1SVd4amRZZzlvbGt6V2c1ZmxVem10bEFqMUZVeHV2?=
 =?utf-8?B?NXR2M0NjSVMrcVFTZXExOG1jN3grUDBHMDNsQUJRNzFIY24vbWJnbVZFZDYv?=
 =?utf-8?B?VnNmWmR0SjMrL2dsaDJ0SUNjaHcwVUtKYm5NY0V4bVZ6S1RRVElZRjVVV0FX?=
 =?utf-8?B?MU1zbE9hbzRHdDJUV2hzNU5NR2M2ZTVQTjQ1T0dMN0tzcHU1cVV2MUJsTnpB?=
 =?utf-8?B?NDRzbUJibWZwSHdhRmgxTmZvME5HYy9xa2hZZ3UwK09WOTZiWHRaYzNVTi9s?=
 =?utf-8?B?Q3hQd0dZKzJMK2IzSndUOSt5N2NsYjhON0RNSHVnbTVITlVhNzRFa2R6czFX?=
 =?utf-8?B?d1BpN1RpcnVKVHlJRmxxVXdpYmt1QXp6QXFQclRCTkIzNFA3TFJ2UFdJUzNo?=
 =?utf-8?B?M3pUdTNTTjJxUk1FSWt1M3h2YnRneW1USUJwSTdLakt1aFNSQ0xRS1dhOVVG?=
 =?utf-8?B?RjBOWkV6YmlnREJSWFMvcnB0eGNxNGxmV1k3RG93bzBNWm5WOXlHOE1pTmZF?=
 =?utf-8?B?VFVxMmhjMHZWOVVpcHNKNGd3SmtUK0VrTVNHQTY5UTZCWDc2Zko0UU5hN2VZ?=
 =?utf-8?B?bmg1SVRReWRZSGlNNTNhdnhRVjRWcWxUZURPYmNTV0JZYjF2TmtyZkpVSnJS?=
 =?utf-8?B?VFUwazhMNFpYRHVKd0EwUWhyYUJOTjlBdVVXZ25CbXR0MnNMNTBhYlRUZEpZ?=
 =?utf-8?B?QVpXRHJoejlTT3dGVjUramdGdDB3dGYwWGd6TzBIbHBwOXE4SHNaTjZYTk5y?=
 =?utf-8?B?ZWpCeEhEOElEdzl1R3ptWndWREJGTVRERzNwQzdYMk9qQjNXN0IwbW04T2Nz?=
 =?utf-8?B?ckpaVnlPazNwbGtrRWFyb0I0eG0wQ2FIL1lUZVArL1lxZ0tLYVBJUUs4cnZM?=
 =?utf-8?B?NUlKYkR5aFhPM3BkRnFnSG0zcklheGVybjY0YmtaK2tEZGxLNEpwMGp5QVF0?=
 =?utf-8?B?QkxYbUpRVm5mSGplN2ZYeHVRR3YyWG0wd2lvMGpTMFhDQ1ZJbUdVN2VDV0dT?=
 =?utf-8?B?LzFjY1ZrTm0xT0VDaGt4ZTFWWXhxeHEzalFGeVB2UWQ3dE9pc21USmhyQWZv?=
 =?utf-8?B?TTdaYkU5Q05CdTI4WlBlSElnT2xnM0ZwKyt1NmdaOEF5ZEdFRVJVSmZxSFhK?=
 =?utf-8?B?bzB6VnpGNE5sNzRsNitZRE5ReFArWGZiRUZZWDhUZS9kRUF3OTRSays2K0pX?=
 =?utf-8?B?RUZBSFJKQUQ1Y0o3ZFlEaVF2UjBPQ2NBS1YxTHNXTWxtMHJXaUtoQ1hrUzAr?=
 =?utf-8?B?enpEdkh2aHJlSUVNcjdsQjJtZEdITDQxU2R5anNTM1ZZUC85MTVxVDN5WjJ2?=
 =?utf-8?B?d2FZR0hYUy8wbVRXMkN1OXp3cWJDWjlwRVlnUjV0dHd0VFNkNE5ScCtna3pw?=
 =?utf-8?Q?UWIj0km17zEQYrnlDQcbdoYCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519580d6-c3b4-4fc6-c162-08dbafab9b32
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:06:18.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KPGMHsK/VsimEGzlB9KYw5aT4eA5R0ppPaw1DyhBut16Y5cNImJUCCPE+mZL4/3JZbiYupuRuex30zddINdig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/7/2023 05:13, Greg KH wrote:
> On Wed, Sep 06, 2023 at 12:55:29PM -0500, Mario Limonciello wrote:
>> Hi,
>>
>> The following patch fixes a regression reported by Michael Larabel on an
>> Acer Phoenix laptop where there is a black screen in GNOME with kernel 6.5.
>>
>> It's marked CC to stable, but I checked the stable queue and didn't see it
>> so I wanted to make sure it wasn't missed.
> 
> The fixes tag in that commit is odd, it says it fixes something that is
> NOT in 6.5, so are you sure about this?
> 

I believe it's one of those cases that the same commit landed twice. So 
the wrong SHA got added to the fixes tag.

This is the one it should have been:

1ca67aba8d11 ("drm/amd/display: only accept async flips for fast updates")

>> a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for
>> fast updates")
>>
>> Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
> 
> Ok, now queued up, thanks.

Thanks!

Seeing the correct sha1; I find the problematic one backported to:

* 6.4.7 as cd013a58cf64 ("drm/amd/display: only accept async flips for 
fast updates")

and

* 6.1.42 as 438542074174 ("drm/amd/display: only accept async flips for 
fast updates")

Did you only queue for 6.5.y?  If so, can you please add to 6.1.y and 
6.4.y as well?

Thanks!

