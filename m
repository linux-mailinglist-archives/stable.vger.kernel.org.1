Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277027DCE1C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbjJaNou (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjJaNot (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 09:44:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A0E6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 06:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQpC64GKu905rtnjnGqCcrW7BQNYNUTqQ4fEkjWbOW6T+zWrY/6CdbbsStEFLktSq0fn9P+EeUJmPFNQifmdHMsqgXMRb2p9XlE4ntK7FJT+eCYrDS32m/QQzoKaWer4uL1cvrKMejP/Tc5aIFulKxxMy2MlqaYsa7qx2MkYhFTIS2BOw6Hh1xLNcnDVA0/QZ0Myxd2CNPGas2g6P6oWVyaCP2GVkuph4Mu1I6mcfTS1GMx3kdOcjPcDxlXMoQQs61K+oJj8K08XS1ZUzuRo+CBypNfCMRfxauS2r82k2hGw193v4L6EfacPXFkFSCE6xR8pFw59QRjBRksGrI/0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or0kOKZyoeW2wkxPknCtTlFP6kxu7XqHjgmC3luZMGE=;
 b=Mq2WH/61ClnPCkJo9vJDuf5+ungGt4ulY4NAiudsKDBaVEHlrKaqAsHEKqqPl5o+QeD7XTcmivQajkF2598li2nGCNnnmn0LkRVmFNWbkxnzH8EP2mp+n22DY//9VqB3J3dBGhC+AzB9FHyQdOye7plbEdDuiY24JbPlz1fHeUFdq8OCr0vp1qhldlLh96tEi7pq3hG0Rv/T3bbzbdo8M+tpAPfa006A1SmjgWeeacGdF7kv0TSAWdRxbRb9cnP1N38h1vVK2QTMLAwWFzJ+YRvh2o3zKOXVms7y2mXMfI6820enYjyw4eTwqtmv06DPRWDJYzIF1bH2DLxd5eRFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or0kOKZyoeW2wkxPknCtTlFP6kxu7XqHjgmC3luZMGE=;
 b=Ah3hdbmStBW/fQZtKyvrWBCZNCB3PW34eNOHB0+t77vVA4eqm/P7zTxf186y3b0pcD4Y3cMjnuLBpUbAwOKInrpLmqdUXtt7sXTo3ZgrqpSEY2/t2MjFTmARonCZCkqVBc+/2qJlPf0LGwyro9KPXbasUN0wcaIaCFnAwGXF3oU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 13:44:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 13:44:44 +0000
Message-ID: <571daf65-0f07-4b45-acbb-0613d724c742@amd.com>
Date:   Tue, 31 Oct 2023 08:44:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 1/2] drm/amd: Move helper for dynamic speed switch
 check out of smu13
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
References: <20231027083958.38445-1-mario.limonciello@amd.com>
 <2023103102-antihero-gumming-5788@gregkh>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023103102-antihero-gumming-5788@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:5:15b::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e177f4b-9c84-47cf-85f7-08dbda178a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHh4YMnIcfb3q9tHihXL+7lC1MoOxqVz7udvnkPVi4Rhayje2NIIx34jJnJ6okdzG0yVXIxYJ8xssH6+zDLcMjReHgHN83nYPtN5THhiavxAUwqzkt22zESFTuTvfKnFM6QXp7K3syGCECpeFVF4Iu0IbKWmtW1g/JIgxKObhI4IpFbXTtoAIYCWd+0iubMBZ/3/Z74+oIaldY+vy4y7B/GXAQwtE+YN3JCJgovfo1cskegWUphoxqrxmAkoyTadVeFafhz+PuTHXddeTjBQTcY7OOKurcULShYEDLhyR7aheEzKfdPBgAdsRCjmFkEho34tpuBNCDPLx1dTwWwH0QDQb+OcKaUzMpxatN1aWQ9sbr1xFp07SoVU0+bO7lAAHU8LrsvUoD654q2thK/EYFkdELEj6lw6HZYvLH2qaMfOnufrihWNtu60H84ZH4BeI5BaXxLyWReq1ig2NYzOH+SJQU/qImApTfnkjAOyoK4ssUBdyqNelbYrOSqwttLO73jaVsqVySCH41JDPVjcqyG6jvu97jbuzvbiR7MmPscmEXDNHEKineIe6iHBgycfXVFJdqpvhjMN1PhQghDGZW+WoTAhcg7iTDqSffIxzPOSa/VMifHGzqw8TI0zSZGjnEnuG+Vecba27doTluTR5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(53546011)(6506007)(36756003)(26005)(31696002)(86362001)(2616005)(38100700002)(83380400001)(6486002)(2906002)(478600001)(31686004)(66476007)(66556008)(41300700001)(316002)(6916009)(44832011)(66946007)(4326008)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy82QU1IWHRXbnpPR040SERmRmZCQ0RIRHRBeHBBdW51aHR3TGNnVHZmVkc5?=
 =?utf-8?B?ZHhtY1ZBM3BhQmJHY2JOUmYyK1F4VzBDeExaNzVrcEpjZnVMYkUzalNsMVZ1?=
 =?utf-8?B?TEdnTjRNVk9TOVN6UWxGVkZrUG10dThkRFBUQk4wWFJEdG5Jek9pdXlQaERw?=
 =?utf-8?B?bDhmVEd5VTZMTHJsd3BSK2Zsc1MxNjZuOGtsdk54eSt6S3lKdXJ1YnBoNGRH?=
 =?utf-8?B?b1d1czc5SWxibDVUaUNTTHlueDRCY1k3dGdFNVFJZGFIRWhKZktWcUNDTDBu?=
 =?utf-8?B?U2dndFZZL0FrYWNTQXJld1hZeGEyL294Z2VvVmd2Q05SMWUzNDZEMlE2cUVl?=
 =?utf-8?B?c1FxRkVxbjZ0RDQ5MGNGc055L0JtVU1VdmFIYjgrVXVFVDZsQWNld3IvZHJQ?=
 =?utf-8?B?b29BRU1GK05RZnZwMnNGdGJ6T1Jhcld5U0NnWFMxUkFJUFIyd1FNVFdOeFVz?=
 =?utf-8?B?MTkrLzVyM3hGS0NHSE80MER6SENjbDZNU0lQR1E5RjgxRzVtSzNicUsvWWty?=
 =?utf-8?B?UUpSd3kwcGhrbTB0dU55TmR2TlNsczBaTkpUUlVydEQ0WXR4Q3VYWUp2R1JT?=
 =?utf-8?B?UGgybWQxeEtSeEpDclU1am91ejk1WndHZHRYNzE5YkNHbTZ4MktGWnVRdDlz?=
 =?utf-8?B?cVBVb0dhZ3dDTTlRTm8rNVNnRkMrNDdCMEc0Vm1YYnRTSDJrdEtCcVFMNG9n?=
 =?utf-8?B?VmhHaXhJQldOWjRGRFFpQnlOQURTQ0FsTTAybFVGeDZkc3F6bXY4UFlIQVY4?=
 =?utf-8?B?VGVDWXZnZ1Fzc2QwZkNlUHdDMTZYVkswenliblJ3UnNoMnlaOVZrMXl5V0RY?=
 =?utf-8?B?UDBUODBxakJxblNOanJrM0NHZzNoWmw5Tk1yRGVHTDg3MGhUSTdqUThSWVNa?=
 =?utf-8?B?M0dDZ0FSUVN3QXJVSUYvODFxL05iZVRFaUNscU1kRXE2NEw3Y0I1enNaTkhx?=
 =?utf-8?B?dUZoN0xMdDlmbVM1c1VlYWxvV2xkN1FxaG1FTi9ZaWwxRGQrdXJ2L0Z4Q3NU?=
 =?utf-8?B?S3VkRi9rMU56aVhwU3g4c1BIMEVxVmpIS2RiZVJxaENVby9IWUhLZ0ZDbkpN?=
 =?utf-8?B?WFRmamp0RzFmbncxNWdjMXNBNlB3QlZteFU4Mmp1TDlBK09DMVE2RXlqYWJ2?=
 =?utf-8?B?Q2gzVzJpMEsyS28yd1lJUjJiNDFEVlJIeEFpNFp1dnNZT1hQd0xZeGQzREVQ?=
 =?utf-8?B?amVjWjQ0b2pDUnpBbm5KeURXRWZ0TFdXaklQVGhEVTFoSkdoMDBJWC9xblox?=
 =?utf-8?B?MzBVR3hJZzdhRFJiMzhBZC8xSkdGN1B0VjkwSERaL3kzRnM4bU4yMmJ1aG1v?=
 =?utf-8?B?Mm5WNmV1SnN6RDN5Y1l6amJpZjhxSVFCRGNlR0JlR1g1Yzc2U3hicXFEcXFs?=
 =?utf-8?B?aU1aM1BhNEVuSUtEa3FXVEhSK1dyRUFYMUZOUW5lMmROVUxiejQ3MFNtU2oy?=
 =?utf-8?B?UnA0M2xMKzlHMENHMTJJdStJUkJneitMSDVxVnJmRlJBbXBJcXBPaWN2MlFE?=
 =?utf-8?B?anZ4QzVPWmpROWVQcmVFdW44czNPUUdFYmx2c3NVK3BvYnVZblVwWU8xanE5?=
 =?utf-8?B?dVA3WFRaeXRZRjJZeXhpMkFUbmVPcXU5bElOd2ZYM3FZOHFGZU85czhENmtH?=
 =?utf-8?B?anhnbmtIa2tJV2VFODQ3SDdjM29qaFRNelNTZUYxK3UrR0FjN3dhV3h5djN3?=
 =?utf-8?B?UUhaT2p5cmpRZlBXT3ZJdUs0S3RMdG1RN2hKZThaa1BWekFEbzhCbFByTVpL?=
 =?utf-8?B?eWhBVXVaSWxVaHN3bWxUaWUySWd3eFdGVFhqcy91OGUvNTRRNXc5dytOaEZz?=
 =?utf-8?B?T3o1dk9kVXdxN2szNDBwc1l2UzAwQ1ZibWpNSE0vVUMwdWFkNXZyaTdSUGlk?=
 =?utf-8?B?ZkdreU1LT1Q5aWtaNFAwNlpyQ2RQMGJUREVaWlo3VEVxc05xZm12dDNkdExN?=
 =?utf-8?B?THhFR29IWk1MR3hWV0l6dFNwU1lmb2pZd1VFRDJwUmc0VEFKdUdmZzIyb00w?=
 =?utf-8?B?MHNuenBwS0IvbS9yVlM0NmtHWUtPNnFDZHlOcjlDZmJYTEhCUHA2dFAyNEwv?=
 =?utf-8?B?aStMNUp4Y2t0RC9RanpKTy84ZlZqWEp6dFQxOEJUK1lDalpZRGplYWlHdm45?=
 =?utf-8?Q?wOiZZG5jUEsrWZQ0O9aU87ToJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e177f4b-9c84-47cf-85f7-08dbda178a31
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:44:44.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUWeb0GqqTEJ3ZrDaklNPo/FCyr4yiWTpG+YxnOcdgITqXgTy/9VyLSjX65dHG9DQWBiF45dp31m/udEEny3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/2023 06:50, Greg KH wrote:
> On Fri, Oct 27, 2023 at 03:39:57AM -0500, Mario Limonciello wrote:
>> This helper is used for checking if the connected host supports
>> the feature, it can be moved into generic code to be used by other
>> smu implementations as well.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Reviewed-by: Evan Quan <evan.quan@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit 5d1eb4c4c872b55664f5754cc16827beff8630a7)
>>
>> The original problematic dGPU is not supported in 5.15.
>>
>> Just introduce new function for 5.15 as a dependency for fixing
>> unrelated dGPU that uses this symbol as well.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
> 
> What about 6.5 and 6.1 for this commit?  We can't have someone upgrade
> and have a regression, right?
> 
> thanks
> 
> greg k-h

Kernel 6.5-rc2 introduced this commit.

Kernel 6.1.y already has this commit.  Here's the hash:

32631ac27c91 ("drm/amd: Move helper for dynamic speed switch check out 
of smu13")

