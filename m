Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48F775B89
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHILSa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjHILS3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:18:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF8ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGn6JkspNR2kd7ou4jXEnOSU4BotUO2zFI1BDJOzmlLQQLv+fe3iY5038WTY6cRvQTjyfbsq8poUDpi9Bt1JgaQBACPJoF+9vKIqnZQQKQghJtInYiuI81lwr26B7Q/JqwY+VKvDf3RuEITBKN3fY81n6oju5eTdFmzZM5BWcIAs9tyKw4Ny5V0p1ETj6jxpgUB0eD+3wzTDORdNA17PRctbX4cA9n+bTayFDF1gBbtc3LloGXWQCNG96KNnLY48C6aAiRKNTJiQcsZgxanX5rnjqbl5qChwD2xbZKM2p9NmiWZoCBtJ2NU8cWovifyzGcZCVjN5xc22zV918kj8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d69qtEVHbyhwU18w2pkm90zR2kdUNSk9suZfw/K1T8=;
 b=fsxhxhmwMPPJNHvyiKbAkM1rcMfIltABwHpdVvbEORR1U9KkuMBQ4di0b5YEFEQkf+xBdaiRRCm3KGRuhbpDXWxzPAYjdQnYAWeCLJ+zlc90Z3jo3gNIJQQ2nMGaAT6+SVaWPYMRMAywi/UR/wO2mpzBQGRjlvk70zIFXZxUwJ3lJqqkCJkbGknOTFsaJpogZmEYZGwOv3hAjGo9noma5Ipjk0ZHF5WjtKM6qDBnoB/2mfxb+RIJHVwNY1LyAKnouCKVFZNQRtuK5FAPapobZEdVWSVE9OVzqA3H+uHN+uVvGGBCKRd+8JiZWFiZ7yWu5P8SQjb3TOY/7yieFGYwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d69qtEVHbyhwU18w2pkm90zR2kdUNSk9suZfw/K1T8=;
 b=CiezWAwBPAGj2L1uu8bx5rxsWYhY5KJorK7L54J9Lj+bkGJ281f5y1RA4nJW7v8yuJSgwWb7eHipWZxA+o8ezKZYMyF8vR3Xsk3c3Fy7xB7dMwjTbUCw9Qi2y6hiM1q+0evVMcwfyMv29unwuQDbOICYCRcFb3ss8Kn7wwBxo7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 9 Aug
 2023 11:18:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 11:18:26 +0000
Message-ID: <c85fa930-65e8-47e2-ade6-001566fe9f88@amd.com>
Date:   Wed, 9 Aug 2023 06:18:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] drm/amd/display: limit DPIA link rate to HBR3
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Peichen Huang <peichen.huang@amd.com>
References: <20230807140047.9410-1-mario.limonciello@amd.com>
 <2023080911-shortage-slicing-6ef8@gregkh>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023080911-shortage-slicing-6ef8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:5:134::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e63a048-1d51-4d0b-91af-08db98ca59bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NR04yVw6uHT0St1934kK7dnUCZAu/3DfSTLivdZsaVtsS9lrOaQadQ9iM/62GiPA98oHmjNlFVg1Gm3PqWG7e9cSEFzduBljEN0mBCbkK0kavxFq0Qn3OGsfXcfwZQWxYdVcguURcPBpwAa8oMBSXqY+ArgPDf+QKgDig4pQ0ZbfUoopTXxSaStHQRPnI60xorCkH0yuo3oEFSiAtqUCHw0FfIPYOOYHHOOE0XndMP18sbhw74RwVkfRIyRiACuIXXAbjxb9JrKNq/Ykpbum2ES3Zfrvso0yVFRWz7ex0FHSPszgkUL1p03Kyjfwi/QPQ7S5Gy174o0gIURMmDkYsj0NKeFWD34Jr/dcmyB5O8hzWS4tzsB4+H5SDZpFOFBpXH/WT2DIv0aACsgWn7jNhY4O0L2MO7NBhMwaLxGUVvJ6e21oDtuAcV7LZebcDwICjxj1L3JpwkBYQS1ItTiYxLpW/tX07zwctOiblJO3W8JCx8Up+3N4iE4kc5+fwsPbptJJZ9SJPQ546cfbNRg0mhmfsu6eebanaD1EAl/lRvhoQdy5oEUJKVgoZK9BgXk+Q3+AwuJgKsbIkDhG58g3ShZFJHPSlND6G3HbCYly8AdKmA1jDWi2MRzaxEYhHgh8Zd/hi0lfv7cJlH0QzRjmaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(1800799006)(451199021)(186006)(31686004)(2616005)(8676002)(8936002)(44832011)(86362001)(2906002)(83380400001)(31696002)(5660300002)(66556008)(66946007)(66476007)(36756003)(41300700001)(4326008)(6916009)(316002)(53546011)(478600001)(6506007)(6512007)(6666004)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpyZVJTWlRMdUMzRFJSS3E1MFNKTGtUVlRvN2ZIcUxFVGhOR3hwRUJZSDJw?=
 =?utf-8?B?NEVKNmIzRU1tam14UXVNcHBLOTB3dGZtenBBZXlxczFGbEJFSmx6QzZNdVFK?=
 =?utf-8?B?N3dENWNEenpLdmJIZ3o2QXVCaWdqelBuWUZEdE8xQ1Q1eGtmQ2NDNGtsRXRR?=
 =?utf-8?B?a0o5YTVrbnRMOU03eFN5YWRuSG9LL3JVUDFBMDlNQkIvNFg1aWlJM0VSNk91?=
 =?utf-8?B?dk4zamViaVk4OG9NVkY0eWxpcGNZOEJSM045RlZtYTN6dmRjUks1angrMUxG?=
 =?utf-8?B?Qm9PRVI3c1QyVWczeXJma3l1SkR3VURWTm5wSTZtaTZyNUhpV0RrbzZMOUhM?=
 =?utf-8?B?dlNxeVlrdW5uVjFFUjFOYnBQT3ZEdEpLYk5uWS9yekVtd1JON2hQMlRLaGV6?=
 =?utf-8?B?cHI5VWxLU3NRc2lOT21NeWMyRVZNK0YzZERhVyt4WEVZQXk2ZktGQmM1NkpJ?=
 =?utf-8?B?OG1ad2VrL0t6QmxKM21sNDJhSTlZaG1ValgyZEthMm5DclNjeUdybm4zZnRZ?=
 =?utf-8?B?a016ai96b3BaZmwxSG0vazZvRXZBV0pKZmM0S3lXUW9YYTl0MHc3aHVBSVhs?=
 =?utf-8?B?czdOUTM3RXMzdVVBK2JaR0Jram16dGN6VTlnY3c4bU0zcnB5THFNL1FwUVhw?=
 =?utf-8?B?enlWaFFBT2Zway9XdElVMkMvcFdkSytPdUlFb1NMcEdvOGE1aDdMNFJZVzdh?=
 =?utf-8?B?bU9lQW5aRTBDa2FkUzdBSTZjT3NCN0c2QzlFaHhZZFdLZFVNdVR4T08xZzJu?=
 =?utf-8?B?TFBMeElkZ0FrQkRXb0JibzlXT2RDc21rTFpjT2grTHp3WDdYdDZUZjF1WlZm?=
 =?utf-8?B?VzV0Vms3MVU2Q2wxcVcxbnU2elp2OUsvZmhrUXl6ZExERjFGejNSR1BmMHpz?=
 =?utf-8?B?a3ZXa25zd2dHbkY3aTBBQ0NCYVVKUTNhZE5ENnA2V2pCbC9pcGtMaEhmamFp?=
 =?utf-8?B?cDVkbzBrbTlPK3FBUDRPV0l6bjVEOWVRb2I5bGt0ZmlPdHZ6U2dxM3dTZ2F5?=
 =?utf-8?B?dElGL01RdEVrZUpGMG4rT1Z4UjRtT0FkNlYvSCt2UEN0aysxMUJiRFZGWVBh?=
 =?utf-8?B?WDZSRkI2Wjc4Z3c1Q1hiekFhUG9ubFFOcDhBVHB1UUhXVEVDNC9qUEM2YWxu?=
 =?utf-8?B?MFRLRWQvRmw0ZUxRekdjV2RrQW5KdUl4N3JwVFNWZll3Q0ZKekdSaTd3Z1lh?=
 =?utf-8?B?SnFRamZSUWxDRUJUUTAySVVkY0RvcXpQVzZEcHNPMUZkK3M3VzRENkNrS2Y5?=
 =?utf-8?B?SktiTE96S1NtNTVTUmxFSXR1MHdPNXFKc0F4dTl1c3dFdGh1M3FyZjk1TUlu?=
 =?utf-8?B?ZU9mY3h0Q0ttdEpQYmxBZS81N294d0N6OGhJWE15dVVheXdPL3VsSzl5Y1Bt?=
 =?utf-8?B?WXl6NXEzOEpPTzE5ZVpCbTdDcHVSMUtaVWFMTWlrN3JxSFJQNzM3WnF2aTdt?=
 =?utf-8?B?N0FQQm5NRG5NRVJSQ2ZUeFBQdzNrMnZtMkFaNjVmaWdFZVlLUUZMWDdHYmxt?=
 =?utf-8?B?ZkRUSXd5eHFRMk4vaC84WXlscVdmTUZrTWlld3VUdTZmeDdtanpsNUdxRHlr?=
 =?utf-8?B?OVlISnFHNmpacStDK3hYOFhaS0JGY0FlcGJTMHVqS2w5aFJzNEhhRWlReXpy?=
 =?utf-8?B?QVp2SWJTTVloK1lpbWxsZUVoclJEZmExVVo4UGJFVVpNZzRCeDVlMk5aOWdm?=
 =?utf-8?B?WGJBT09vRzU4cmIvcXgrbGhFVk94N1htd1YyM2cwZFdVNDhSRmZhMVIwVStx?=
 =?utf-8?B?VGVybUdXWVFtTExLOXBzL2FCZGFERXltQmVML2JVSjhwTHpFOGJZM2tVTXZ3?=
 =?utf-8?B?dWYzRUJaZTFvVjJVWFdWTVlZRlZRRFkwQmRLOUtDYzA3ZEtRem5CZnNnQjly?=
 =?utf-8?B?bTNtbit4RVNFdllxREhUNk54N1d1WnUxeDlvUGlSRmZIaTNEV04wUnk2clNB?=
 =?utf-8?B?OUNpczQybE90SkczcllVZysyaTV0Q0ZzbUc2eVRETmFGSU9UVWcrRzNVTjFM?=
 =?utf-8?B?cUZLS3phdUZNb1kxY3FDa1pCaHNLSkhWcFBvT3BtQXlYVXhZQ2NqWG1qSll3?=
 =?utf-8?B?WTIrQjYxZXAwMFhTZFB1bGNOd3FDRjAwNXpJWEtUY1JDZlFYMHNHSmJrQWdW?=
 =?utf-8?B?ZTZ2Vmc3d0lCcitBRlQwZzZoNFlHamMzWEl1UlVyQW85aDEyZ0tIYjlnejhM?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e63a048-1d51-4d0b-91af-08db98ca59bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:18:26.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C/yFcK7EaeIryN6xWQFz9Hf4/q8rrRxkKGrKDxbbXrDKPc0rdeTeF+BPDGFLQbH5zhSIq62RpgWFR0iRPFtIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/9/23 04:05, Greg KH wrote:
> On Mon, Aug 07, 2023 at 09:00:47AM -0500, Mario Limonciello wrote:
>> From: Peichen Huang <peichen.huang@amd.com>
>>
>> [Why]
>> DPIA doesn't support UHBR, driver should not enable UHBR
>> for dp tunneling
>>
>> [How]
>> limit DPIA link rate to HBR3
>>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>> Acked-by: Stylon Wang <stylon.wang@amd.com>
>> Signed-off-by: Peichen Huang <peichen.huang@amd.com>
>> Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit 0e69ef6ea82e8eece7d2b2b45a0da9670eaaefff)
>> This was CC to stable, but failed to apply because the file was
>> renamed in 6.3-rc1 as part of
>> 54618888d1ea ("drm/amd/display: break down dc_link.c")
> 
> It also is not in 6.4.y, why not?  I can't take it for 6.1.y only,
> otherwise people will have a regression when they move to a new kernel.
> 
> thanks,
> 
> greg k-h

This is one of those cases that the same commit landed in the tree twice 
as two hashes.

Here's the 6.4 hash (which is identical):

$ git describe --contains 7c5835bcb9176df94683396f1c0e5df6bf5094b3
v6.4-rc7~9^2~2^2
