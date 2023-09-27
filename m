Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3187B0C4B
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjI0TA1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjI0TA0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 15:00:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE59F9
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 12:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5r+bFQK5ZaL+oOLkZ8w+Dy6Gfh1BMCC2oHqzbxfiyMhYTLMNsNNB+wfy2OueWNHZD7092lFsWHdlahR9XuJvRpzA7FFb62qDVyiZhce5sbmMfQYYXultX6KeoHqqD0qcoPSSeWePCe3FvbWPpKn2xwx/0y9S/M80C8Rec2PRuXzbtxoU5YIPueGf2PAq7NAxc4D8N71vNKIguPHT3LhW0JLkx4w4V1MZXPgN7kLdbhge578QKq+Z9Wkwq9cFWvyxADGtFPpnBuObPReCnIvrkHjN8ih/qb861DnEdBIEw8WhToEgTdycqJrfmrR2rIiC0gkF6jjce/2uyIs/EhEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExCZo9ppJKrOukOVJJjOGQehudZzpwI42xXeAuLihfs=;
 b=RpXzTPtNbIXV1xyWCoZhPeaM+h9SfYVhMyzf/OnSMxG/mqt4pAb5KSpJt3QcR7YqtMN/tGeF8W6Svd1prD+kysJIdbKCP/nS2hAKhqyCjG0oxRhFiym3EvDK94xJYS/SYHwdvSSyg3pM/4JGn/9D+6ARunP7JXuvNx0lK2gz24tS6PxQ66caOTMRjg576vlD8ninD7AMlsK5BvOhzw4lT1WkCIrhqAhTCTB+nLLBh1Fh7f/2+OzOBuFvIfLwmGpVgrgancKx2r6yT9R/rwmcRNCsLpH/+5O0IUMKbUI6K42hLjV110uny9iUi2ELVmtWs32Th72Yr5bqdkATU2XOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExCZo9ppJKrOukOVJJjOGQehudZzpwI42xXeAuLihfs=;
 b=cR6+kPp7ZF5PNLFwQ1fkVyRtPtfT71gw+0kjht80fJetTiuW3RCEbFJ06smRZ8WPl82iitUU64a5uTaYihgveK+W5CQr14uGVO/h8IsPgU0oZv/5DhfQpblw4n5LSKWvVv8PYBo0I4Ueq4MIX09FfzQOkzHUQYYyv8JoXPwhMss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 19:00:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 19:00:18 +0000
Message-ID: <ff4f3163-8d3f-4dae-9bd8-1b1d22bbd61a@amd.com>
Date:   Wed, 27 Sep 2023 14:00:15 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: 6.5 pre-emption hangs
Cc:     "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f257295-1a02-44e6-2cc8-08dbbf8bfdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCo2mPpbVAVx0UbH5KxCeAcUKls4rev7U9CAsxjnsUV1GyNVfMUWBJFuX21urPZPqmc+yCPc6munW7/IuQ1/FeuhjCGG6M1TeYm38ad09cyMkUFegYjE3jpiqCy4Fuh3WnOZYxrtICao6x/A7y7SDMAftleTHDmlUMCQ834zSvqc+NO2G63cfik8+3r1XrmDtDEahEMxE9i/ocpMar0oNPf4oPEcFCdXWdxKgf/Hxiy3HV6eLruGghdhjcGjaVStwxS52/6eiPFe85NLsUYLbMaIGqxvJU0pW/QbD8df+oOaW70S1NUv4IK4tj/CRNW/hZUDDCNoqETMMzoJ8mcdMvtACUry8Znba7AoU4uNgqSImCFRzVQmxC78UfS1lOB35lvGz15y7eW5SIXlmTeXyD1YVzQMLUbmLH8MD4sNFTX1KRCN7rK0OhvfjDDvtfmmzIFcz6+92Y4kSjmzLWmZhRg9mqMujpxTYdEIj6EWnuD4i4eWqeOKkZRgwqZ1f0W8cflyTB+LqBzNSIPSS+wxZcvYnTM1NXEy7BVPSDZKHNv1B01rfABbDWjrQHsPok3m2GBvpvE/y9wYgTwspvvWgF45FrEEh+Y0IyY1Vq7T4nfQjL/9yS+aK1F6neDxcRGC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(41300700001)(44832011)(31686004)(5660300002)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(6916009)(4744005)(38100700002)(2906002)(26005)(478600001)(966005)(6486002)(6666004)(6512007)(2616005)(6506007)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdKVFpjUkhuYytENlpkbmZDNmdxTndMR3lvcUlLNWh3M2FobmQrWDl6STk4?=
 =?utf-8?B?VEYrc2xKaUdOdVJ5QTlqcG5qa2VDWEpUZ3ltVll4bUZCZG9aOG9jL1BaQllP?=
 =?utf-8?B?c2hBTzY2WGd3dmlsTlVNL0hLdEZXb0xlSjlVMlhRMFYvdWtzMktUMmpLNHBS?=
 =?utf-8?B?dmFMalpsVDVpQmVGTlo4K1FFTFZJOFpPTUowMVoyUHdsYUg5R3RkMFhYNGNR?=
 =?utf-8?B?NksrREVvNjFjNGF3TjgvdGh6OWc0bHNNNi9CTGgxekVZWjM5YUZFVVluNXhB?=
 =?utf-8?B?ZHF2SVQxR1FFU1RUSG1kN2FuTkhhTWRvN2Q5ejVGTHg2Qk00dVBubXo0RFFH?=
 =?utf-8?B?NHNreDVxS3kzZmZwRUswWFFGVVVSSTV2VzdDTlNlTTgra1lUWlZUR3hNY3l4?=
 =?utf-8?B?NmJZU3pSa2M0Z25KdThoeEFzWEkwZkpIUmhqcHlZWkRDNzRTUUh0TC8renNa?=
 =?utf-8?B?bktPUyt3RXYyUlA2cmI4S2M3WDNac2tNRk13V3NlblpZcjRwNDgxYjYzVFdn?=
 =?utf-8?B?WVB2WUlNZ1kwNVQ5TmVUdDBTVFJaYnVoYmgzaVNYaHhoS0pPRVEyUlNhZThw?=
 =?utf-8?B?WUgwUDdUdXQvOVRwV2d0YmE4ZC9LT3YvQ0o3d1FJeTltOUplVzJzSlZHaDV2?=
 =?utf-8?B?dlVrd0pwaHNYQ0swZWJDc3VQVGc3OS8xUE1qSWpqSlBvM0RLMURoVXFHREFT?=
 =?utf-8?B?c09NSGlTTitSRG04K2h5ajdDV3BRLzhyR1dTMkNoaTd4WVlIZ0RML3QvcW95?=
 =?utf-8?B?OUZiTzdFVUFnRUZQbGtIQW05YmZwMGRFMllJNHRMaUxyNVR1YW1VVGNyT0x4?=
 =?utf-8?B?aXQvM2d1MWtCRGhGeWNhbUdwR2NObHlDMldGT0pEUUZicUx1UFgxSm9qanVE?=
 =?utf-8?B?Zk0rTHlOS051dU9aVU9DVUp4dm5PUExFMGJ5VzFhNVFNY0E0OG5td1JJZk9r?=
 =?utf-8?B?RmFuMDRtM3hpTzd4b3VkaW9BZlpGaitvdkx4eXlrU2YxQlVMVGxPNnAvbkRB?=
 =?utf-8?B?OEl1OTNHZ2FNU2ZNcU5WekQrRk1keTZRanZkMVhSdlpLRWtzZkhHSGluL1gw?=
 =?utf-8?B?MzlNcURSQWgzMWlRWFF2YTEwWTN6SlcrU2NsVVdvNFRXakNPRTBJdi9NM094?=
 =?utf-8?B?QmVKVHNuc2UzWkhCcytyVE4raW01c2ZhL3RoZWVlTTRSdEVvdU9RRitXVHNW?=
 =?utf-8?B?NEZnd1B6bjdyaDNUY2tLUVpsSXBpOVFnTzFEYXI2T21JN2MrYkJFd3ZGL2d4?=
 =?utf-8?B?aW1sa3VpNVpnRU9KS1ZOem1xM1djTXdRMFVtK3NzcjMyRmFuUlcwSjZQQTVJ?=
 =?utf-8?B?OTQ1akV2ck5VRExHbEZGSTUrQzlhTU1vKzdNVTVGWC9ZaE4yZUVqc1NDYkFB?=
 =?utf-8?B?NFY3bWgzZkZTQkhNUEU2Wm1RRUp2ZXBGZHczaThpckJGQllJREZaNUxQaUdW?=
 =?utf-8?B?SmdTa0NvNk5HRDRVdzJLWmRLcjJOcnlMdG9HZC9JSmpzWHZIanJvMGsrbWdM?=
 =?utf-8?B?cXNvT0R2TVBuZVF3QllQa2FXTW85TVowR1Zhenl3UDBXZnNOVngzZHpOWmlr?=
 =?utf-8?B?T0hSL2RyVmFMalFlREdGMGwvS1hEb0d3N0pseUZJVnpiU2pjb2dCUWxOdHRz?=
 =?utf-8?B?Vi9renozNzdvdXBRK2JCa2p4Nk1Sc3NxamZaU0ZpeWJvQUdaUGYzUW1TL1oy?=
 =?utf-8?B?TkF6YVlwUHFvMUs5dUlIV0pBUHVtcitKUStWZjJzN3NxY1grVEJQb0hITTlm?=
 =?utf-8?B?S3ZNWDBqRzI2UVpQcVpzVmdldW9RYWw4TU9IemRuVnB5cnZqUU5nTG4xa292?=
 =?utf-8?B?MTNoOHg1VWV1M0N6NjJLWm1lcUR4SVBUM1VMcTVVL3FISzVpQnVHbDlkTHpX?=
 =?utf-8?B?T2tqRHZlUjhlWGI4NlV2aFhZNmlRNGhwZEVqdEVRYXY4QWRZWW9iYWdXK2pu?=
 =?utf-8?B?RzR1RmF3bTNncTZmWFBEaXNiNTFmMCtBWUxhMDJsTXZZUFBCd1ljOUNlZk1V?=
 =?utf-8?B?ZU5TM0RBWGkySTBOVTVjYUt5MXVUTWJIR01URWprMkYyeEZJbDZZWkhkckJ6?=
 =?utf-8?B?RjVPN3JtNjY4QnkvZmhvWkUzYWNOUU1xbTdZa2tvMFlWS1BkczZOdVJMTFc0?=
 =?utf-8?Q?dy7CxxDSKD4OSNJi5QsddWUAb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f257295-1a02-44e6-2cc8-08dbbf8bfdc4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 19:00:18.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgi44pvGdsy8lw4i+x/OKkRsLSxbD5E4TELrZ5hntU/ZaZ4rkZOohMEaeaERYGNwj6thSpVgvm4axC0hTIl79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Some hangs are reported on GFX9 hardware related to pre-emption.  The 
hangs that are root caused to this are fixed by this commit from 6.6:

8cbbd11547f6 ("drm/amdgpu: set completion status as preempted for the 
resubmission")

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2447#note_2100975

Can you please bring this back to 6.5.y?

Thanks,
