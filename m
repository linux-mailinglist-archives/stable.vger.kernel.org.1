Return-Path: <stable+bounces-3888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E380376D
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F711B20B4F
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725C28DB9;
	Mon,  4 Dec 2023 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQJd/Bl3"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCDC4;
	Mon,  4 Dec 2023 06:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mplkG5eu25L+/Nng3eAIkYkcgD5KyUuH7Sj6R8R0DzOg7+J6ChHLGwFzVu8BVx+txdqODEGTd48XEYKbFsgi1kos+0JmyNJ7y+gkPjHRFOcOrNyiLH4rP6eaXgvLLw+VLXZ0l5IEUvqvA1tnxCT8c6pD0TlIpEVv9LkR/pa1BKMDG7dz5x7D6vWipSPFek9yNpUEIRHonWClU8H6hewAJ/gDk2Ygo1pjlrjBcCHx+Qz/4oItEKPaLroB62BXqHZD9RS+ZU2ojUXZK1h1gBhfax+6E8CNIoVn5XnNJim80PZO0L0DbxBmrY/99E2hUl8QIMv5JwZyMp23Mz2jjhRggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feEKl5vdzfQpMvr20kitHFBqS2GeVUpbpocERgAokag=;
 b=G2SxlyUCDhKSJb3O2nuDL91Two1uX3oKj2mTvMenpdmKdcXkO+YcY8ZXmeSMBKzLHPaM0qBcLAjvLS3jUuujLaD2c07wV3CtCF7g3ycRDDjdVKwMYe5vwwNMoMh4JuwIUTmZ7bmQ5rIJm/708myu37D/r9Wlc1v7qbMSm11Lm+cTiGQSW+Lc8og7CoWD/DuXwjsDdzbw3d+9AS498LYmWlrjMEIyKFen0mA2UWWrDxl8vUteFXyyh97N60eoi/4eWKPWX5/I49ZDC+dEbo2pKnb+45xXBNAWMq53vPRIAU6TRY3kpLwt++kLHc0varnELVhNjjWM/+lZ4MYYbz+4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feEKl5vdzfQpMvr20kitHFBqS2GeVUpbpocERgAokag=;
 b=hQJd/Bl32szsyjPTec0F2cxfqRxIBrezeQnrtSQfR+SbeNH7uFgays+LHmTELs3rwWNmen7k5/Dg5NOk+onmNUWfM9WdXw2ckQQqVtMbDJ43+9qEbGJMAy4l6oT9PZSCoPv32/gvisq/A4seryJ0UwHgxYK+PZ7qeNKmVaYODiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:49:19 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 14:49:18 +0000
Message-ID: <f28b4e98-dd9b-458e-8a72-a9da3c0727cd@amd.com>
Date: Mon, 4 Dec 2023 20:19:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 mario.limonciello@amd.com, regressions@lists.linux.dev,
 regressions@leemhuis.info, Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de,
 bugs-a21@moonlit-rail.com, stable@vger.kernel.org
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
 <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
 <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0774e284-55fd-4ae4-5d72-08dbf4d83199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XbmxEJ4S49YF7mKi7KtYCK2uvQrlk7IX6EIUJDkNr2lbIe/ut9puHypS+8rzAXJu7J5+gsZHbdfIgXvc8N3Or0SiTKDkZL8jwYbDPa57yVD71/3Z7UvjFjYch2yHiO2SP7JgSrswyaxeCpWdFNjBRhVy9kRf+ABOWQ1xUTXouGXOUrR/4AD2D/htF4LfQakc7ysf/HhyLGCirPujCQg67AscH7p8qmyG5cAGjB20hTTl4kH6zDHVqVaj+Kj2GlfIDAEpyIzVfdr/ottjvpnLIz8oDSHcYnP63PsGFxjtTsMaepZMnWcKg+pYzhlhPS+aHVRd35Ts0a00//ZUEnjTZHh7bUdY3EZDtXPMmJVu/tI/IuI1zHYNTIQZ4xg3mhhcIdpC8r2FgcoVaT8nae00QLOZ0W7edTec2F3waRyYC65oPvfAqy2cDDczr4Wcsx8nKEx9PR8Ayxp845gjwN+T+I0ZLqeEM5OR5EDSmPtHU5vcTH100ZWuWDwSwmpuZ9lRpuKPrA5wFxNPmjCJ2YMp/AOVNJNhya8Eda5nTarogI8jLOhVmgxjYDHYH2oy4TFdZohaVynVK9LPlH4W+K8GYhUhs2F8ecJ0GkjHQNs48liGhS/gRKVcv68Tr19beIc92xh1Erf1nV/tOU9M63rJ7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2616005)(4326008)(8676002)(8936002)(6512007)(6506007)(53546011)(26005)(966005)(6486002)(478600001)(6666004)(66476007)(66946007)(66556008)(316002)(2906002)(36756003)(41300700001)(38100700002)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhoVmo5aFBjQ3RTdVQzczl2TFpXSTA1Z0ZOY3hZQmtYNXo1ZGp1Rm9iQm12?=
 =?utf-8?B?cDdaQ1p5T1pob0NwZlh5Ti9ZdUtvUEtaNTkySlBQMU42L0hsZVQvMUUrblRO?=
 =?utf-8?B?QzhkclNKVC9nVUx2NXUzRDdwclJieUR6YWpLTVNhdlFEbk5tQWEzalE5Qitl?=
 =?utf-8?B?VStrNkZQaklucUIwUEJ0QXhzNS9aNnZ5clMxRHVlaTFxL2ExSjhnK3RINExl?=
 =?utf-8?B?OHZNbm5ha1E4Mm5BNDFFRG94dXhCQXV1cXZIRHI1Mm5sYWpXRktHWElHSG1x?=
 =?utf-8?B?M0EyNFVrY2dGRDJudnpmUWVPVnpVb004TjBYTEtIRHg5NFkxbXZyYmF2SGJY?=
 =?utf-8?B?NkVsK0RUQmFpWnRHcjF1MmY5bXYwdU1aT1IxL054R2YxeE1hSGVQZFdxbE9q?=
 =?utf-8?B?U2FrdDE0eFJDWUdnRVd2d1ZyWXppNTAyL1k3SEJ6VDdWL3MxVFN1TkkvbVhq?=
 =?utf-8?B?U1BrZWpDenpPdGI0anEvL2dkT0VzdGlYVlJLSENpUktPWGZaT1liTHRaMGMx?=
 =?utf-8?B?dVJicE5LZEVQNm9NNjVrMko1cnhWSHRydzFBYWtRYUZZaXZCSXF2dG1jL0Yz?=
 =?utf-8?B?S3U0Z05FaW81Y2crd1BRcy9xUFpKdnRRVThyVTJQWWZYT1BqRi9IcThTU1d5?=
 =?utf-8?B?NEJGMjNxN0NITDBWbEh6dzhrYWxEN1d1L2xQRjcvTjVCNlRwUWhXS1o2K3R0?=
 =?utf-8?B?UWdwSmFUOFY4OUhXNG1KUjFlNlNFZW55ZnpLTFd1bDVSM1JKaFRtN0hGZWtl?=
 =?utf-8?B?U01qYnh6VXgzUkxHeFJ3ZHhwdjZWanJXeGFlekwvRXR5L2o0ejEyU0xhRHU3?=
 =?utf-8?B?SjRTb1hDK3NWK2NYMkFKNmRtWFhUL2JkZWRPRlZKcG00eVFrRm95MmgrWFBv?=
 =?utf-8?B?MlJ5RDJKQzFXTjVGdFhvZEhPZVU1TkNVNjlSZzd2UGtocXFsN3ZJZi9SVE9t?=
 =?utf-8?B?aFF5SFQ1Snk0bW1Dbmx3ZWpFdTBielEvRzJnS2FwT25nNHUzZk1sMnArQUtF?=
 =?utf-8?B?Zm1UZFUwd1lRMTZldS9rR05jS1NWemRaU3R5UzZydFhMb3hkMXZFTWYrU3Rk?=
 =?utf-8?B?UXQzZWV2aVN1V2ZReEk2cGlOR1Q4WnlaYVM3WTBHNmRibXVvRU5VOVh1S3FP?=
 =?utf-8?B?Qlk1OFJBc29DNEV0bVU1aXlhVy8wOXRscms4Z3J6SU1aeUlmZWFGekdReXhF?=
 =?utf-8?B?REg2MFR1cjhtL05CbWxpRWZ4T2xRY3pZWWR5ZFZtQk8zU1Exd3JGVGZzOWhn?=
 =?utf-8?B?QXRjSVliZk14a1h3bVB6dWV5TFR1VWp0c3hLNjlITFV6Vm5YL0pYaGE4dS9U?=
 =?utf-8?B?MGlHdVhlK0JxSURqQWEyNWtQZlROV2NUd2ZORkhhRFNGZXFib3lBT24zV1o2?=
 =?utf-8?B?UHIzd08yOWJVVHNxTUV5NjY3cDc4eTMvbnF3Q0F1djJ2SzBVSFoxOHZIbUE4?=
 =?utf-8?B?SUlKUjhIdjArTHRJUkVaSERJb1dLRmdKSm5NS29rbExUM1lhOUhCTG9lUkEz?=
 =?utf-8?B?U3BWZldhUHNkd0F3U2g0SmJoVkhBRGtNQThHWkFmYXFnSVJ1S0dDaFZZMERN?=
 =?utf-8?B?K1p6Z0NFS2Vndm52aEo3aENIaE1qNEVzblE3dXEweFQ3czlnTXJPOWRRcEZY?=
 =?utf-8?B?N0JHNzA5OTdTU3YvQmdzcnFqbW0yR0pjMjlER0N2OXdMbUY4d0xQaEkrNWRS?=
 =?utf-8?B?NUF0SHBROHVUUmk3bUY0aFRnand5OVFmTDFyQ1dyTHJhOU0xUFYra1dyRWgy?=
 =?utf-8?B?WUp1NHNWbkhDWmV4QWhtcGJtNC9IS0FySHhYQngxa1NKMVBqUUdMM1BEWmJ1?=
 =?utf-8?B?UEVnYkxtdTZwNHczRit3TTBKdWNJcFZXS3FEWEF4bHJ0T2Vnd1UvQ0JBWmMy?=
 =?utf-8?B?WHYycDdKbzJicmx0M3F0UUNPcGVzRTNTUXBWMW1jT3ZMZzVqeUhTd1BsdEh6?=
 =?utf-8?B?dXB2MzVHQXdVUXZteHVlR3pqWFZQc0ZNZlNoQ0pBejFuaDZZYS9yaWIvL2pM?=
 =?utf-8?B?OUZCWktvc2JCWnpOYlViYklRMi8vQjlCbHhJSTBUMk5nK0kzSGJROEtkZm9t?=
 =?utf-8?B?Y1l6bmd1Q240R05rZXM2Q0xmOXhEaHlPbll4a2NuNVBmYVZBR0FmWjB2YlNQ?=
 =?utf-8?Q?diBQmn1j8grZllHgrG5oO3dal?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0774e284-55fd-4ae4-5d72-08dbf4d83199
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:49:18.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AGq68xEz0Xxj/iSBUXm0ARo9yqsL+EO8SJmbFSkRyEmFVoMoeItnCgNa4LhrFq0zKiLP8xEmgWgxyLYkRQeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920


On 12/4/2023 7:52 PM, Mathias Nyman wrote:
> On 4.12.2023 12.49, Basavaraj Natikar wrote:
>>
>> On 12/4/2023 3:38 PM, Mathias Nyman wrote:
>>> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
>>>
>>> This patch was an attempt to solve issues seen when enabling runtime PM
>>> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
>>> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
>>
>> AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is
>> not regression
>> patch and its unrelated to AMD xHC 1.1.
>>
>> Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover
>> for AMD xHC 1.1"
>> alone in this series solves regression issues.
>>
>
> Patch a5d6264b638e ("xhci: Enable RPM on controllers that support
> low-power states")
> was originally not supposed to go to stable. It was added later as it
> solved some
> cases triggered by 4baf12181509 ("xhci: Loosen RPM as default policy
> to cover for AMD xHC 1.1")
> see:
> https://lore.kernel.org/linux-usb/5993222.lOV4Wx5bFT@natalenko.name/
>
> Turns out it wasn't enough.
>
> If we now revert 4baf12181509 "xhci: Loosen RPM as default policy to
> cover for AMD xHC 1.1"
> I still think it makes sense to also revert a5d6264b638e.
> Especially from the stable kernels.

Yes , a5d6264b638e still solves other issues if underlying hardware doesn't support RPM
if we revert a5d6264b638e on stable releases then new issues (not related to regression)
other than AMD xHC 1.1 controllers including xHC 1.2 will still exist on stable releases.
If revert then we can backport to stable release later if required.

Sure, will send a follow up patch to fix 4baf12181509 alone on mainline if revert on all releases.

>
> This way we roll back this whole issue to a known working state.

Sure, for at-least a5d6264b638e if not revert on mainline then will not resend the same patch.

Thanks,
--
Basavaraj

>
> Thanks
> Mathias


