Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0307550EB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGPTWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGPTWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:22:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537898
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1dbu3iQ9xtH6YvhTis19AWkK58Ox2i9NOtAeFoX/J4Ry8nPu6mZChRRnAFqW72lToZ8Tyq24osqIo7bEOureCZKOM7KebT/7KNxielKHmM11Yl505d7VuKxBw1XMW/VLCNITNRSWub6uuXUiM2kJRXDpUsnlVTtEuLAbT/hpkzM2W2E9A3PdsPvlhbqZlBYK74Ydmgf20wMZTFdU3/B1iR8hhqvVyBxEAU6IHcGBwv2p3P9TBzHBnZ5LsD6RTWzp8nrKKZPrWMCzi+uhxh1kK2Yk09jE2ltT9kDzj1kJCiX6GA22ZQEqPUc9lGoNiBpouRXNVy6tE9W1W9mDFyYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTCX3I8atx6zD7EDUvZmkOjqZV6CpAxz9LoMQSy3ur4=;
 b=IbC0ur8Znk3lHJouJ7IGbvPZttDI+HTaiC0jTahAFxFy/YzTVB7HxC8EGlzhSm089vzWJkACH5iWfdWGvpbOqQcr7zj1rovh4ehMykkXYK0RaltWO5SnQP29/TU4NWm+6Ipy4tv+RZFnZcRyHZBp8ASTyuZm3foi4DPH9G78ieN/PIkuFKCWRhn87VujfSivJ/ZU3K0etpWZxJPkdW0f5k7MrHLIUx+3Dg01zGI/FFIn2jgZOtfmkrRWY+Er4/XqhDaM+vdCsgU/wtZK92tSekSqkbhS5X3G6wTKFnDK3mwYMw3zpc6ZIzy+QguwQg3EN7yLsSye7jgAMTnRiizMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTCX3I8atx6zD7EDUvZmkOjqZV6CpAxz9LoMQSy3ur4=;
 b=bbZdiWr/66AHPTrbrh0xhty6wSTfs1s0U2PGBo7GnHpVal+zXJzVaLmXszPf0w6Afxq9tVMe8hxKu+UpzRMK9QHRoWES+a4XLnoIPhqq40l+Jan3CdzeV8MrJsA5AN5P/BHsi6IE6sEMT0fP8H1mMfGHp2LC7RXb+r0RkjdeYHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sun, 16 Jul
 2023 19:22:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 19:22:39 +0000
Message-ID: <bfb99ba9-8fb3-1af7-d0b2-c617bbd5c2b6@amd.com>
Date:   Sun, 16 Jul 2023 14:22:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     stable@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
 <2023071649-gradation-reckless-5db5@gregkh>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023071649-gradation-reckless-5db5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:5:15b::45) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: e160b998-c4b3-49ed-b0bc-08db86320467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4V+4Nw8PGjPGNnH503PvWQtIY85xYCOwChggoL65E+qAQjnU2FRXekc1tBrnGaSyYO97U/mvrkRu51cjFPMP2RB+EdKWCCd1z5M4ioEX1yHCOeNFM1kGUC3A4BOfP2dyHBeeOUX0LgUHmH//fJOcyJShPcEVG+Jdiq6B3Vz4YBzDPN+3PXBibEj+Y+MGKNwe9+95bDiFq8zTHcdKgy2HexwfSYeVZhJP1kAcmlHD/3CGhjTbgQXOVd7UFFyzlpL9wLHYU1WxeamzOg9E/fn0+Ilc6pmcXrrhwH5WXECXjTmqjIsYLKzBoOKt9g6mPkWdAHEeArJwCR8Ypcqm6lMqPa+O9Eqa6zv9hceLYi00/Fw1MxD1bfUt67ETn0mLBBRRwI7nNfs8bC8/IjWQoOKlZ7dSTxuV+f9lQM4phjwYnBxtD6jj3yPWiRjf0MU9MGfY7dswg963Wnclcto9R1K/adEnKDTbFhwXSc2lw2ZHSaraDoiSA/hQgSQ7b5TO1S2xNC2PCNyc0ZepIIe3oCz1TUrQSSi+G3wRTn4xR8N5wqV/qlwli11tXvXtdMA6qa304A2LRc39ni5T+QpSMcRnQKjlB6dVlz40dKOt6Au6SdAF5AvemcslAdgdXDfn3pu++BccXdf21klUa1nF2t3HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(478600001)(6486002)(110136005)(54906003)(6666004)(66574015)(2616005)(83380400001)(31696002)(86362001)(2906002)(6506007)(186003)(53546011)(36756003)(6512007)(38100700002)(66556008)(4326008)(44832011)(6636002)(66946007)(66476007)(41300700001)(8936002)(8676002)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXkzL2FzRjh4RFZTVTVwdHFDS0RlYUxud0VWMGl3NkN1c25JSUNKSDJOVkY2?=
 =?utf-8?B?SFcxWU44UDN2V2hSc0RMM3Y4SVpHa1ZSbjNpb1ZLTHp2VWRIbGpFYWgzNGJF?=
 =?utf-8?B?czI3djg3L2pnQUJrK3UyUURBV1NLWStQdmhWSGtvRUtEOVZzemVLTGtTMGkw?=
 =?utf-8?B?WVNFQUExUjdlR0ErL29jU3dBd1lJK0hnaXAwMkh0WUtDTEZodFhzUFR5bExh?=
 =?utf-8?B?K21nKzZleEp3NEFudlBJcXEwTHR2d2dwVG1YRDlRMkp3SjM3d3NueE9ia0VZ?=
 =?utf-8?B?aDBHUnhVL3lSQ1BJOGc3UVZvUVlrb1NtdUxEeWNKOVdNZFNmSmIrc25nNUFY?=
 =?utf-8?B?dEhUK28zM2hLRnVES2xzaVIvWnZDc1BpcjBMRkxJcWM2Y1lab2NBQlhUQTY1?=
 =?utf-8?B?cDB5NnRDeXUyQ2pCVzVSdnRlbTdHSzhuUGtYaFkreTNySTAyV2pscWYzRGVB?=
 =?utf-8?B?bTNKNWphWU1maS9WWU5tNXhQK1dURmE4VFI4SExvQlNKRnJ4ZU5HSWt4Snhu?=
 =?utf-8?B?Z2VhKzJ5K1NDV3JPdTJ4N3Y5RkdoRnlKRDV5QUJVbkdKRGJSR0tCWTlwQ2wv?=
 =?utf-8?B?NUxEQXUrYXlaaUNVU25zbVFEcHlNTG1sbXpkeGRPWEFkY0J4V2Q4NTBnWWFR?=
 =?utf-8?B?NzhuNkZKUUVYVytQcU5yKy83a25TSHZyREtReXhERmFYR1hRbWlpSE9wcHY0?=
 =?utf-8?B?a3VNQlRQZVRPb0IwcmhyeHRvck5XTExHd0lYS2pWdGJBSHFuZlBNZzhoUm0r?=
 =?utf-8?B?aDlmdXlvSndFdlFQQ2N2My9RSytiV3A4cGo1b0htQlY3VjZmcExYMm9PSXJL?=
 =?utf-8?B?N05oMWV3Yy9zbE9zZEFTa1hNbitwclQrOTZwajhqQm5PMkZXaG05UW41V2Y4?=
 =?utf-8?B?MGJBdU1FbFdxTFo5QVZicnpJZDFkbXNFVzNRSjJaMWNuMzhVWmtkdThlV3g4?=
 =?utf-8?B?dzJlY25Wdy9Nays0WFE0enYxS1lxa1NnajF1U080akN1RVFxQ0dxczUwZkJS?=
 =?utf-8?B?N2pTR1JNcFRnV3Jwdlh1VFE3MVlzZUpSUEJkVlBlU3hhRHlDNDNrbHVvNGU5?=
 =?utf-8?B?S3hydWlhZ25kZGNrblJKbkxGQzhLNzJldFZxM0NRKy9mM2ZKSmIyVVYrSUxs?=
 =?utf-8?B?djhtV0lWY0hIeVNxL0dYSnZPZXFmQk9MN1JDVnM1c2R4Kzlud21ZQ2MrVEQy?=
 =?utf-8?B?TDhGSzJkQ2NuRkNlZ3YxZmQ0eTJpb2lnVVBGWW5vKzNSbDBkeFpQZUZMTlBJ?=
 =?utf-8?B?OXpjQml6MHZtMXlCMmJHTzRTOXVaRGl1NktENnRnUnJpZ28zajlmQUpudE51?=
 =?utf-8?B?RHhPd2xvQUQ2MVZRMFIwdkF2SnRicUo5THJrSnkyR2Q2YURieWhDQ0Y1UTlT?=
 =?utf-8?B?ZFJJcHJyOEFTdUx6eVNOTDEvVWR5V3Q3Z2UreWltOTVMYUxpSmtINDhhYlpG?=
 =?utf-8?B?S0s0dkpjR0l1V2RMcHhGSTBrMWlQcjVPbHpTSFBvczhCZnFzZFNTK2FoRWMv?=
 =?utf-8?B?NVFmRkRRZ2pLZ0ZuSnQ4M0pWQnFSa2lZL3lZSzZ6VUF1SFZwZ0VtdHZJc2dk?=
 =?utf-8?B?RGlWOUtpeEIyKzVlbWNiZ2pHMUYrQ3dQRFoyUTlYdm9TU2k5emd3VDJrQy9l?=
 =?utf-8?B?ZWVXWDhjSE9rcFVsRWFDbFlkY1djNDZaQSthYVRXVmdhSzlqck1VOXFpVjdz?=
 =?utf-8?B?dHZzVnNOK2hORUNNSVZwSkNVYllIdlV3TldKdDdUVnVDbW9ySzROWCtybE1u?=
 =?utf-8?B?bFNvZ3RBdmVRZ2tpZGtycVVncWJrUE5qY2drS2NKc3R4Wkkvb1BiUUV5MzB4?=
 =?utf-8?B?V0ZVUWYwMGQ2djg2R3h5YW8vRkZENE1mU2pGMDVScDlSYytSczlGd1RxNFZ1?=
 =?utf-8?B?TDVMbkN6dTUzS1pLVm9lVlVhbTR5QktkTmI3b2RPS3ZvRG5VRHhxalAydlV1?=
 =?utf-8?B?LzIwVDJsUTlzWDJpdVo2Ly9QSHlBdVRFK2kxS3NhL0N2d3ZUVnc1VGZjYUhm?=
 =?utf-8?B?dHQxU090ZmJYSmZoYUZTRFY3Q3JrZm0vVWtxYkJXTU50M2xxRnErSDBqcFBi?=
 =?utf-8?B?bE9Bci9yNVo0dU54ZkZBR3IrYXppK3R0YW9Va2ZuSzY5TzQ1SXZyZXlreXNv?=
 =?utf-8?B?cFErNU1NMU5pVGJRZHpzT01QTWh4U1lqNEJmaEUzVU9RRG5IQmZXbWpLUVA0?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e160b998-c4b3-49ed-b0bc-08db86320467
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 19:22:38.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nK1ZMGn3dVHIpJNbvt6QFW+a0+UBBf+FqrkVQJmfK4t3hHyCxADuyT2LgqPgWxPJsyT1AE4LlI5L+GyyVme4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/16/23 14:16, Greg KH wrote:
> On Fri, Jul 07, 2023 at 11:07:26AM -0400, Alex Deucher wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> We need to grab the lock of the BO or otherwise can run into a crash
>> when we try to inspect the current location.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Guchun Chen <guchun.chen@amd.com>
>> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
>> Cc: stable@vger.kernel.org # 6.3.x
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
>>   1 file changed, 39 insertions(+), 30 deletions(-)
> 
> I've applied the first 7 patches here to 6.4.y, which I am guessing is
> where you want them applied to, yet you didn't really say?
> 
> The last 2 did not apply :(
> 
> And some of these should go into 6.1.y also?  Please send a patch series
> and give me a hint as to where they should be applied to next time so I
> don't have to guess...
> 
> thanks,
> 
> greg k-h

In this case the individual patches with specific requirements have:

Cc: stable@vger.kernel.org # version

They were sent before 6.3 went EOL, so here is the updated summary from 
them:
6.4.y:
1, 2, 3, 4, 5, 6, 7, 8, 9

6.1.y:
3, 4, 5, 6, 7, 8, 9

3 is particularly important for 6.1.y as we have active regressions 
reported related to it on 6.1.y.

So can you please take 3-7 to 6.1.y and I'll look more closely at what 
is wrong with 8 and 9 on 6.1.y and 6.4.y and resend them?


