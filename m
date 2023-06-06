Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E1723E42
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjFFJuW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjFFJuU (ORCPT
        <rfc822;Stable@vger.kernel.org>); Tue, 6 Jun 2023 05:50:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF390
        for <Stable@vger.kernel.org>; Tue,  6 Jun 2023 02:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHNTkZqpFF/Qj0stJ46XuuoqJp0Z8E7slyDf6djhrn6+rMzMHpMmlRL6UBFqd8iDMK+PWaH7j9rgXZ0VWLYfRq5eTKFGAGQB3KT/r+O2ZZP6G3B97q8YK/VEj7Vplx8KyO7uj4mO5TSKxVzi6J3KIs0wWC6+UBfps/O7MuaUQYhA2BD19L+2SCW9ka1VUzrtofgQ5x7lmAj9JDiV6hJ2ou9UCmcxDwIoYoQrSQLaoUEkkEux3bfHIVyG8NYdwp6Ct7t7jvrzyrxjIXqoLWV+RAS+5FRa52Qjn6lBAOwuc2Bz7rBJUXjQwCtIw8tzvObkiAu6GTZlHn13rShvWPmY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clPEQaZ2aU6XCsSKKV7+nkf2g8xO7Ro9i1E8zImkw2Y=;
 b=kDxis3g4jdtIyvXtYxt8frYhWO77Wn5dc7Jv46PzfgzokcudEpXuuJxjdxKmWsfP2O6wvzkJKR+omtcXeen8kY1IyY75DeH7vRCwd9+298xysZppkRZsLHD/YBvEVySzgfQNHn5ofhxjzbQrdg3QrseU46+SCNKIiIvTjN5ez0VhDT9Y9CI3RlGrggYBmxUIpRAgRuunpfv/Vt1HKhSZQgCB5ffZ9pLuBUCDkZFI2Utgz6sPIKHwEgYmHaeH2G5LahkTgfts/4zFioOiTt8fFhlqyhZDzP5wgS6u+38jcjq8X7Enc6hfKXdFYeyQLGJwRaA4YQJyJTu07RkyGmQpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clPEQaZ2aU6XCsSKKV7+nkf2g8xO7Ro9i1E8zImkw2Y=;
 b=1gBWVXgOqinynldvorzQAjT+p8dhYGYwc4zNACfnSz5o2u990GtdBkld9dRdW8zixwWdnO1t04NRuhhgKXIP+jfB8604D0PYuX+ogKknS29olNTpW3XamdjDsVyH39crZAj6bs3Fn349aWAEt17VNhS10O6MFbCTa357AB1Qp1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:50:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:50:16 +0000
Message-ID: <eca0323c-b2aa-ab29-b706-8f60af94b41a@amd.com>
Date:   Tue, 6 Jun 2023 15:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: FAILED: patch "[PATCH] iommu/amd/pgtbl_v2: Fix domain max
 address" failed to apply to 6.3-stable tree
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>, gregkh@linuxfoundation.org
Cc:     Stable@vger.kernel.org, jroedel@suse.de,
        suravee.suthikulpanit@amd.com
References: <2023060548-rake-strongman-fdbe@gregkh>
 <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdc2902-a7ae-423b-884a-08db66736e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpCQeU97g2h0SM+jMBEW5UGsYca1+t+m9qYTfkg2w1DzmjYQDQPY/Gw81WISuWGpYqPbGj3mPvn8EJAQVzQwjsgCBY3GAYJZ/5AeG11dJ2aUHDtMi/QjTlN3+SWAtfzkzfpgSKVE8L95OWArIN/CGlff5dcVsnNC+RIvMxWHCZpDxbt4V8FtfYwgwfKe2+sm8UBxTmrRbnGWq1m9w/ImVIMNmN7anwme5DhBKjIq+Xlzqyhpzw0XFPgbBoP2VrUjdnL1i1WVUdiSAobMOazwxacnqzC8CkRrSPlrxjwbD8VQkd9BQz3rblmkmAuSIhg5OSPbmQOGJilhvdb2q4vdwylYX0QlmTaxb7Bk435bMcH1FNW27bpYLN7lE2ASDQB8F83FTLwKUvZcGfoyNhDTRuSiR5UQZoMWHKTdUsD1HbHBYiJtZ2vzyLFnyjp9ZwvN6ETotLdMOOOjts4FbKTtWGCxe7JsureWbHnNXSR85sPNZ6+mgxE46l11OPu3kTNTpQQHZgMOvo2BIYkdofsNmzD433Zaa0L/3kgUJ1uE/Gi0VR7eN/gCYFWFpHwTQgfiYseBcDwZ9EmcGaBYIG7CNt8Ht0PaC0VKRJT/4Gr3T4uGqNcx0HAYkVMqv1/WBx5dxr2D86gT17UN/bI5p4bSXsSp1CzKj9geMIQZqNHGk2dd+TdyOHiXUmy0Rmu3j6wA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(6506007)(6512007)(53546011)(26005)(966005)(36756003)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(41300700001)(5660300002)(44832011)(478600001)(66946007)(2906002)(8936002)(4326008)(8676002)(31686004)(316002)(6486002)(66476007)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRNcFM0Q0FXYi9EeGZSdjBIRGVldTRQTDF1d1YzRWd0cmM4VmpiTnJsUHBt?=
 =?utf-8?B?Sm1qcDE5eGZEb1F4ejl2ZWhpNjUzRjVqaTJudXpTZ2RlYjJlUXFDWXErb3do?=
 =?utf-8?B?cVczUVgwMmRLT00zZ1piNUp2WEVKQVozREJiM1IzSnEyY3RFQ0VzMU1sYjk5?=
 =?utf-8?B?TWJGTzBqNm1HTlJmUzMyK1BuMUZMNEZyOW5oQTl5TUZwSjc0dndhQ1c1aE1r?=
 =?utf-8?B?MWNnSkRER0hQcU1EUWdIVGI2ZjloUy9OMXhBRzdmM2xRYnA0QXNBZHR3eks3?=
 =?utf-8?B?UkNzUW5GcVdNQmVYdGhqK09jZnNQR01KZFBsNzBlWUxTU2p2SStQR2RxRHJ0?=
 =?utf-8?B?T3Avc2U2dHNUUUUxaUd0VUF5cTkvTkFQYm9lNjFKZTJWcnFOTXdMem9tM3kz?=
 =?utf-8?B?ZVZiUWVyMW0zT09LeUhwcU94SU43UTJMQkJ3TXhkakdLcWVCSVY0SVdGZlpE?=
 =?utf-8?B?dGdwSW5EdnBXL0pJek9wMG9tallHNHlaNzV1VlI1WE9XdVVFa0plOGZWMnlZ?=
 =?utf-8?B?WTNUUE9OOEdxWk1aTlVrYndoWTFqYSt2eW1LVS9yV2lNZUNjNWJ6bVR6cEZK?=
 =?utf-8?B?bXpnYUU0QnlxL3ZRb2xpUko0MUNrbkFwM09xZlFFRVNMREVoRGtEOURxc0xz?=
 =?utf-8?B?QkxJQXN5aEh0dldPSWFDZ09UbHA2Z2RnU21haUZOamlwMDBLSjJsN2NVYkFZ?=
 =?utf-8?B?VDZpRGNldDFrTkd4bmVjOUxEQmp6Q1hveExDVE92L041a2xlZm4wUHBFL0wx?=
 =?utf-8?B?TGxwbWFEekZaQzZwdWRCVE1TeHQvc1RsTkMrQ3FwdjUyY3BBb1R4dHJkUEY5?=
 =?utf-8?B?dU1FTDlZR0l2Mzd6VzBFVEJLcytPUUhlcWc5T2pqL1dmQnF2TDdmclgxL0hy?=
 =?utf-8?B?a3NOa0xHSmUrQjZyU0pBSk90cUhQRHQ3WVRESWJNNTBoZlhRT0REOHBCNkxY?=
 =?utf-8?B?VGpZbGZtWTZGemxVT2FoeHJsbnkwcWJ3Wk9rUUNVRTBMQjlnbUIwZFRTQzJp?=
 =?utf-8?B?a3lheWFtRjBZZUVnL29LNUM4d3RVVmJUb1IvQzBaNHdVMFhrd25mYW9aK0w3?=
 =?utf-8?B?VWJWSHQxRzhmSUY3eXhaV2NjZ1FLUnNQbDNBQ2Zteko5U3ZVaFQ3dW10clVJ?=
 =?utf-8?B?WDQ5WEQzUm1Qci9PcElGK3IxK1h0Y05tVnV1SHRpODJZRlVXc2NQTXNmTkxp?=
 =?utf-8?B?VTFPTUF0bzJ6c3I1WmNNQjJBYWJpM3BLeHlIY3NzVm9DWTd2bVdhOWtFU29E?=
 =?utf-8?B?dVNrZHpodUhqWGdkeXVlK21POUpEQnhsMXVURE9qd2dXcGVhT0JsZU1rUWZJ?=
 =?utf-8?B?M0xOSUQ4U3V2bUtzZ2t3WDVxdVZMeGJEVWt2WGs1L3l3b1cvM2dnYkR1T1Jr?=
 =?utf-8?B?enIzMU43d2ZnTHJUUW5QVHVSMU8vdFZkTkFMdHc5RXdhMDVTaUo2cHNRM3Bw?=
 =?utf-8?B?T3FvVENNbVpKYVBFSTh0NnBNVFhwdDA2SHcxL2RKNXpRMSs1V1ZsODByREhw?=
 =?utf-8?B?aTRzVVlHRzcwejNtd2dkLzJhdThtd3c4NnltWUpNQU5MK09WajhzZFNvY1Vq?=
 =?utf-8?B?c2pGRlhjN0J4eUFpVlRJOEF4TW50WndrNG5peEFmR1FBMEd6ZGMwak1LMHRk?=
 =?utf-8?B?d0kvQlRUdE9hNEdudHNLeUNZUlh4Qzl6Q3lsaDlsYWZwLzJJUG9NWDh3MS8x?=
 =?utf-8?B?NysxK3F2a3VmS1MxVVQ1SnZVRE5KRURSeC9LUGo5L2svNmM2Smpyb0wrUXNR?=
 =?utf-8?B?cFU2UmhvSE1FMXQycHVYNXlzaGtVRTdnVWs5cEhpc1RHbUFIVkZIUFVlMFFJ?=
 =?utf-8?B?WUVpZGN3Skx2dzlWaVVCQU11Szl1TXZ4Y25VSjFrQWVEalRSRzN2UkIzMVV0?=
 =?utf-8?B?RjAyTlRuSU5Xd3dDK2ljWXo1bERBcFlMcVVNM2tocUJpQktFbjBEUExWNWY2?=
 =?utf-8?B?a0VjSG5EWjZJaHF3d0RnUEcwZUh3MVhhUXZab3I4R2JOTENuYmlCZ3B2MWc0?=
 =?utf-8?B?WU9KT011ZGY5RWtoUHJ6NkdKQVpGdTU0dHFhd2FXaVgxZTk0OHowSU1vZ0ZR?=
 =?utf-8?B?RCtSai9nQUNmMytKYnBHSVFEbVc2OXlqNWVSTW1YVEgrdFg5UXJrZytpb0M4?=
 =?utf-8?Q?rxM9BuEug4W58h3y354DYz0Ez?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdc2902-a7ae-423b-884a-08db66736e06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:50:15.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjCqq+UQMyaNNnewyUwtGHZMtkjzVOwk9VTMxE64PfDa683i70dy3qW0yTP0HIcDv8IS9vJ0UB18quwQgDZcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,


On 6/6/2023 4:13 AM, Jerry Snitselaar wrote:
> On Mon, Jun 05, 2023 at 10:38:48PM +0200, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.3-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060548-rake-strongman-fdbe@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
>>
>> Possible dependencies:
>>
>>
>>
>> thanks,
>>
>> greg k-h
>>
> 
> I'm not sure what happened, but it works for me:

You are right. This applies cleanly on 6.3 stable branch. But it won't build. We
have dependency on below commit:

f594496403fa ("iommu/amd: Add 5 level guest page table support")

-Vasant



> 
> # git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>  * branch                      linux-6.3.y -> FETCH_HEAD
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> # git co FETCH_HEAD
> Note: switching to 'FETCH_HEAD'.
> 
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by switching back to a branch.
> 
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -c with the switch command. Example:
> 
>   git switch -c <new-branch-name>
> 
> Or undo this operation with:
> 
>   git switch -
> 
> Turn off this advice by setting config variable advice.detachedHead to false
> 
> HEAD is now at abfd9cf1c3d4 Linux 6.3.6
> # git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
> Auto-merging drivers/iommu/amd/iommu.c
> [detached HEAD 20a7d8fdd693] iommu/amd/pgtbl_v2: Fix domain max address
>  Author: Vasant Hegde <vasant.hegde@amd.com>
>  Date: Thu May 18 05:43:51 2023 +0000
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> It also worked with 6.1.y:
> 
> # git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>  * branch                      linux-6.1.y -> FETCH_HEAD
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> # git co FETCH_HEAD                                                                      
> Note: switching to 'FETCH_HEAD'.
> 
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by switching back to a branch.
> 
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -c with the switch command. Example:
> 
>   git switch -c <new-branch-name>
> 
> Or undo this operation with:
> 
>   git switch -
> 
> Turn off this advice by setting config variable advice.detachedHead to false
> 
> HEAD is now at 76ba310227d2 Linux 6.1.32
> # git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9                            
> Auto-merging drivers/iommu/amd/iommu.c
> [detached HEAD 75eead6b6b81] iommu/amd/pgtbl_v2: Fix domain max address
>  Author: Vasant Hegde <vasant.hegde@amd.com>
>  Date: Thu May 18 05:43:51 2023 +0000
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> 
> Regards,
> Jerry
> 
> 
>> ------------------ original commit in Linus's tree ------------------
>>
>> From 11c439a19466e7feaccdbce148a75372fddaf4e9 Mon Sep 17 00:00:00 2001
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Date: Thu, 18 May 2023 05:43:51 +0000
>> Subject: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
>>
>> IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
>> address space. Current code assumes it can support 64bit IOVA address
>> space. If IOVA allocator allocates virtual address > 47/56 bit (depending
>> on page table level) then it will do wrong mapping and cause invalid
>> translation.
>>
>> Hence adjust aperture size to use max address supported by the page table.
>>
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
>> Cc: <Stable@vger.kernel.org>  # v6.0+
>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Link: https://lore.kernel.org/r/20230518054351.9626-1-vasant.hegde@amd.com
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 0f3ac4b489d6..dc1ec6849775 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2129,6 +2129,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>>  	return NULL;
>>  }
>>  
>> +static inline u64 dma_max_address(void)
>> +{
>> +	if (amd_iommu_pgtable == AMD_IOMMU_V1)
>> +		return ~0ULL;
>> +
>> +	/* V2 with 4/5 level page table */
>> +	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
>> +}
>> +
>>  static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>>  {
>>  	struct protection_domain *domain;
>> @@ -2145,7 +2154,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>>  		return NULL;
>>  
>>  	domain->domain.geometry.aperture_start = 0;
>> -	domain->domain.geometry.aperture_end   = ~0ULL;
>> +	domain->domain.geometry.aperture_end   = dma_max_address();
>>  	domain->domain.geometry.force_aperture = true;
>>  
>>  	return &domain->domain;
>>
> 
