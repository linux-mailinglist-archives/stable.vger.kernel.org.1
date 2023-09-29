Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF737B2C26
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjI2GEo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 02:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GEn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 02:04:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81B92
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 23:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4/UjZdr7CYNi9JoS1Szfhfb6KW7xg2dvXPx7whAxF5a4gLSf9SS2G3wWDEEnlmSBDSsDAop+e90PltynkJvaBotaVnmkuFI2nd3hbmTvplZ209LJZuozCZtiXympcXC6d4rumUK2O5nNFuAxbuYedPwMy5PaWN02OlJdDqI+NVB2mNmLnyPBBqLDJylcmAkK9pjqGnZnF9jVlNdDn2siEUKaqfx7fxEG/tWsvfyxBRIkhdAHHgNRiUoezzv1YgYB22dD7cjtTdukIlRNKXYVtq69SNsgZubwOa88wUSl7XzbVHWe6wzijqGTo8de8pGVTmnbBUGB8ZGfZsFFwYAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pdjoMTwbjmc0fYkdq63DRpA/5eGnFVp3orrfiW+fPc=;
 b=Lhlzwo842v//aeL3kj1GaS1nPcfHD05g5nCCtn0hqi/MhTmngYuzEcHLgmN1MI78v1kKofWKw28bf+ylSWQb9l6kE/9iIWfRgb733pykYfIU/4X1wSArh9lS6eJs9Cgq03V4vwp0cDV2gEhr6OKtQh7qkrdpawmEn7qn5Oyhm0veIp2BbKBUiFVgze3QC3GOHpvhDr+VMlXOYY/F/qq0813p02R0y6HOpKP+fFgNFLfTY5p6A9+Pt67qR7aAhpiksACRFvewpi6QC8M4948AnkxiA7qaeYa93/F4J7qstwNV8AdHQYO3WPdbljJkD6ubsvjVF95bYGxxz/Fze1au6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pdjoMTwbjmc0fYkdq63DRpA/5eGnFVp3orrfiW+fPc=;
 b=g0q2KHLW6HKAl/lbFjNlEY6CGQjHOicbRTJj0LlUZ9On27XBuyE9IlHBd/LyulpWnRiHVPotJElmxEqWd5W2qMO5Q/ubaR8fCI/DqjHlR2JLdY+nmm1vn9V1rg74eVZnNV4ZhS/6lHFp0kJFlDpSQ2cPqTBCa3A/CUrDCU1C+Wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 29 Sep
 2023 06:04:37 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6%4]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 06:04:37 +0000
Message-ID: <80d66581-79fa-51ea-83b2-387bf8ebf704@amd.com>
Date:   Fri, 29 Sep 2023 11:34:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] tee: amdtee: fix use-after-free vulnerability in
 amdtee_close_session
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        op-tee@lists.trustedfirmware.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>, stable@vger.kernel.org
References: <6a829fb24c6b680275a08edf883ee458a9cab011.1695365438.git.Rijo-john.Thomas@amd.com>
 <CAFA6WYOk3M1EH1KPf4w=qYaQRF6Y_cnNWimJGTyiAdEokiNMKQ@mail.gmail.com>
Content-Language: en-US
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <CAFA6WYOk3M1EH1KPf4w=qYaQRF6Y_cnNWimJGTyiAdEokiNMKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::20) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e99088-9c16-42eb-f1bf-08dbc0b1f5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxCaY2MjwheAuhw22AVU2cxuV2Z595AkhI7t7vOgT0b7IkJ1B3HF4dhtzF8ZSsDTP5tLgKNGW1C0WfHKy7uHgXLxHJ+o+VDv9/sRegXDaQLmduYOyP+ur6I53pKm7UJclJqI9xIfgBGKAGMT4+kLMr3PQILBCa00hVxJXv9ipC4y8ENBfSW/jJp8yS5hbeeok2lG8AHzQ4ow6oE5Kj7k7Ws983ASIcqTuiyrbLbKcdGXUiHE+EWe9hDCoJPe9ybP453J4+kz8KvEnQ8gfKZufNKlTbyje81VWNFZtiGzq6WYE4xM5NQW1tIhJyQUzrRTsbACT54+zvIXlOUuderEZZ0FOscQUDxdv655trZ0RCR8Ln4dxAV3BxlTqE1UHpW3Ku/61Km5CPOuHB9Caq3VFEphyYLWyK5qd9kppx14SjLxfZ51dKBovupuDcDT7I12c8fVtOaVKBs6/yVl9uoV9XhwmJtjQYdHA2y3nsSPQ/R1LarmwC5uf4R9TiTrpTFxkv7w9bRdaMftFoU1o/mbIh5wuDuqMI3Gv0G/IMyb50J/nrA7Vgx2nwqy1GrzwKOSq5S+V8hxvFhKAbh76S369wWTsZ14SNJiEInj5y4XrefUaHlI4kVvZYT/o9wPc2rWpbSOq/cOSDQJi/4pnK2YJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6666004)(478600001)(83380400001)(31686004)(2616005)(26005)(6512007)(6506007)(53546011)(55236004)(6486002)(38100700002)(8676002)(86362001)(2906002)(8936002)(36756003)(4326008)(5660300002)(66946007)(54906003)(316002)(66476007)(66556008)(6916009)(41300700001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFvTWh6MzZxdTZNOHZYaExXM24vUjFtWlRka1Q3ZGhNTENyT0Q1anYvczFa?=
 =?utf-8?B?b2JWZnNBYUhGc3dLQXpRcjZwdTVBSHNzV0pZcWRJTld4STVaYngzS3VJRjVL?=
 =?utf-8?B?MDU1NHo0SmxVVDA5MU1wYXpkK0tDYm9kWCtYWms3RTJxNW53WHZyN0VnSC9k?=
 =?utf-8?B?T1liRjBUZDBlbEZqUitmaEJ1RU1QWEpwWUxDTCtjZXdtSUJmT3l2Y2RQRkNG?=
 =?utf-8?B?dlcyTExyNy95SnVSWnNZTXBQbzR2KzcxMFFYTWN5QlFpdkZQekx4ZDM4UjZN?=
 =?utf-8?B?cmRGc2JsVWcxLzlaT1RKK2xwVFphQ1VHSlhHMjlwbjdRTTRJWWd1VTVYTUwz?=
 =?utf-8?B?SjFWcWhkMGdyUTMvWGViYWdZdlFQaVlBUkRXbDRFTDhtNFEwTHlpdlFyTDZR?=
 =?utf-8?B?ZG9FcXJGR0V0UWxRTlBHaEc4b2MzWTM0VTFKdGQyTHNOWTliV044RjFveTNE?=
 =?utf-8?B?MGhsUkJrMnlrdTExOW5uT3VNMTJVd2dtV1BDOXd2eS9lbUtoMFVrNkxzY1Jo?=
 =?utf-8?B?KzdSK0hwVkpJNGVPSXRYbkFUaWxiOGlVUkdqbW9kNDZINEhZdXNHUHhwZnk4?=
 =?utf-8?B?dXgxSVlLRzUwQjEzVHllbHRBMXlzNG51Y2JxK2lBWlBGcnBFSlhuZmF0bkhr?=
 =?utf-8?B?eTE1bkhjbDBVRmpya0o3VVZBa25VSkF5dlByTE1pcml4M205NGlPV1ZNUWEx?=
 =?utf-8?B?MjV3Y3RpZnpwTkZBeThWc2dmZnpXeUEwK3JwRGcrV2FJUG15S3RwWkFaQVlJ?=
 =?utf-8?B?ZmEwNWt3Q1FQUzVhdmlTbi9ockcrWmhXbHhEK0xnT0ZxTlNIVngwcDMxY2xV?=
 =?utf-8?B?VHloZ0lFVjIvSGg5eDIxZDUrNTBmVEE5WEtkN0UrM0J2N3Y4NXhnSzRDQ0o4?=
 =?utf-8?B?SWdGQVNxS2hHdVI4VEZJY1dmWENicE9VY2tmMTNmZmVDRTFLaUFNYmJiai9S?=
 =?utf-8?B?RFFVdDVrVnRXb1c1ZlRHeitweTBMUHpOdUlQRVhFNXVHZVRXR2R1NE5OTlVq?=
 =?utf-8?B?aDdqMCtCVWdRMTcwSVBzZzE2STRsR0hSWGpLM0hHTzBkKythb0VEcTZCMEU1?=
 =?utf-8?B?WHd5NDlSUjNYQ1N4dmZHR3VDbWROSWpOTzBaUUwzS2pZMFpCbGFnWFpJdG9u?=
 =?utf-8?B?ZjNNNTVjdExFV3RmOXdjZWY0aWpZVDBqTlBieklHb1ZLcm5HMllIQUZoUm11?=
 =?utf-8?B?elUyM3FxeWs3R3VrVk5uWHhtbVhGYmN0TEk5dk05T2hoN0luRDBUU3g4a3Zr?=
 =?utf-8?B?VUtHK0o3eFFUN3ZveEVYb05IZER2YUpUL3VrUFp1WjZWK3daZ2puQVltMy9s?=
 =?utf-8?B?QUhCY0pUQVNKczFhc1grNDVBenpZM3doUzB0anJqcm8yUUNVNllaWVNybE9v?=
 =?utf-8?B?cWhHS1FnR20rNnZzZ3l1ZVpmNE9XNWx0UzRTK0Q0U01tb0dzTmhIVjNYaUo2?=
 =?utf-8?B?bWpLZ2ZLRSs1dHJBbWlPa0VnVHF0WGwxcElTbDk1WU9vRG9DRGRaWjJ2cjZE?=
 =?utf-8?B?Qk1ibkx1eEtIVkhOVlNzNEY2VnRBd1owTVdCcmtpQ2hyR2VRTTZ5bitqKzg2?=
 =?utf-8?B?OVNmandmSEpoejF0MXQ5OFlwUnF2M2d3SmxkYXdxSHNxZVpYR01mS2FoQ2VF?=
 =?utf-8?B?WjZQV3dhNmI3clZBNzRTY1hqUld1Rjh4K3Z0cDFvb0Z1OEIvelhkTTgzVWpD?=
 =?utf-8?B?cDFRVkdMWjRjdkRsck5LSjliUGxjRDg4UFJrQWZtM0Z6emtlSzlBc3R1SlpW?=
 =?utf-8?B?MUUrZWVGRjFRQUorenJMMk1HS0R6d0ZhWjQ0bm1nc09OZWZQRHdBUGwzb01i?=
 =?utf-8?B?QUdLYmdKOTcvUVRoNm8yeVNWVDdaSm1keHlYOVh6aHM2Y1Jla2ZlYXJQb1dv?=
 =?utf-8?B?NWpYQk1KczEvNWtiQURKTmdxYXJjVUlJZkFlZVEyNGVXNnZqUE02Q2hRY0h1?=
 =?utf-8?B?TkZ3am1lbHovYk1nZXk0ODM0V0VRclkrYkowQzRnY0lKV3g0UndjbEo2VjZJ?=
 =?utf-8?B?ajVrRXFFZ2ZvOFNUOEU1c253RHBlak5tMGhvSFp4Y3BkUzNUcG82a2lQTzhK?=
 =?utf-8?B?SExWSFRDSmVnRExmc1o4cXlURHZ6cUtmZnBiNnp0TCtWcEdkbEI2MlNIU3Ft?=
 =?utf-8?Q?88cYmmLAOFWi8uhCTuDOkHAz2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e99088-9c16-42eb-f1bf-08dbc0b1f5e4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:04:37.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpqx1G9IvaCBxrWVn1fXiXI5sp8qpX8Srl6v/AOJf8B3YETIYP3umoOGSMMbxqop8KVzx2gR81U7TRSso+gm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 9/28/2023 8:35 PM, Sumit Garg wrote:
> Hi Rijo,
> 
> On Fri, 22 Sept 2023 at 12:26, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>> There is a potential race condition in amdtee_close_session that may
>> cause use-after-free in amdtee_open_session. For instance, if a session
>> has refcount == 1, and one thread tries to free this session via:
>>
>>     kref_put(&sess->refcount, destroy_session);
>>
>> the reference count will get decremented, and the next step would be to
>> call destroy_session(). However, if in another thread,
>> amdtee_open_session() is called before destroy_session() has completed
>> execution, alloc_session() may return 'sess' that will be freed up
>> later in destroy_session() leading to use-after-free in
>> amdtee_open_session.
>>
>> To fix this issue, treat decrement of sess->refcount and invocation of
>> destroy_session() as a single critical section, so that it is executed
>> atomically.
>>
>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>  drivers/tee/amdtee/core.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> index 372d64756ed6..04cee03bec9d 100644
>> --- a/drivers/tee/amdtee/core.c
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -217,14 +217,13 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
>>         return rc;
>>  }
>>
>> +/* mutex must be held by caller */
>>  static void destroy_session(struct kref *ref)
>>  {
>>         struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>>                                                    refcount);
>>
>> -       mutex_lock(&session_list_mutex);
>>         list_del(&sess->list_node);
>> -       mutex_unlock(&session_list_mutex);
>>         kfree(sess);
>>  }
>>
>> @@ -272,7 +271,9 @@ int amdtee_open_session(struct tee_context *ctx,
>>         if (arg->ret != TEEC_SUCCESS) {
>>                 pr_err("open_session failed %d\n", arg->ret);
>>                 handle_unload_ta(ta_handle);
>> +               mutex_lock(&session_list_mutex);
>>                 kref_put(&sess->refcount, destroy_session);
> 
> How about you rather use kref_put_mutex() here and then keep the
> mutex_unlock() within the destroy_session()?
> 

Sure. I can do that. I will post v2 of this patch.

Thanks,
Rijo

>> +               mutex_unlock(&session_list_mutex);
>>                 goto out;
>>         }
>>
>> @@ -290,7 +291,9 @@ int amdtee_open_session(struct tee_context *ctx,
>>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
>>                 handle_close_session(ta_handle, session_info);
>>                 handle_unload_ta(ta_handle);
>> +               mutex_lock(&session_list_mutex);
>>                 kref_put(&sess->refcount, destroy_session);
> 
> Ditto.
> 
>> +               mutex_unlock(&session_list_mutex);
>>                 rc = -ENOMEM;
>>                 goto out;
>>         }
>> @@ -331,7 +334,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>>         handle_close_session(ta_handle, session_info);
>>         handle_unload_ta(ta_handle);
>>
>> +       mutex_lock(&session_list_mutex);
>>         kref_put(&sess->refcount, destroy_session);
> 
> Ditto.
> 
> -Sumit
> 
>> +       mutex_unlock(&session_list_mutex);
>>
>>         return 0;
>>  }
>> --
>> 2.25.1
>>
