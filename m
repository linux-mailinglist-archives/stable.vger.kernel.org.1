Return-Path: <stable+bounces-4923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098C8089DA
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A024B21509
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEAB4123F;
	Thu,  7 Dec 2023 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VJ2TVBaj"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A810CA
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 06:09:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifjJ2FywTolcSNEsMP+mifOptBpXkqkeA3H68bpsBdp4AeJVGX9H7c4ON6dS1z6FEbtGDnvDLpPKVRaM1gwd/P/bExUFuHGSwVXlsq3TvI6xfLpABy4ld6rjJe+GyI2Ag0isBRCgnVmtn7QtG/MG4Dc+Eo/hHWbYTyVdk8SF8LBFCum28769EtOLjR26xANUMMjKf2iWjWGlaGk7+m0EqS5GfKIGpIa0j4tMmDOAxvvY9Uqdjxao6YXG4tud2dlq1fJ+S5KzvEZOUNJh2I+jZfyT95SrQVCBGoy5fuBF7EKqsXUbAK5DEUN+OlTDV1REDDUmcmBkg2meLHBXCv5KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBPk9teej8l4N4hBw2GXRHA4BhhBIPSAZsmQzLi6dO4=;
 b=Z1a8EqwxgD5lVhDgOoJ28qiivOARepWeIbhgsd3kjr6imocQY4r3tZ/b1WyugKrFv0NVfva4BPpSjqS3LsxmLXaL1wLqPdSwTCZK6Mv79WxN9EWlLrRJg0C44PiDdqvtggeN81gh3s3WRnwpjlNC8QTjkCbIQBtWziNjZZ81oahqFdMkkCSRDf8LiJ3E/QjP3k7pccFTpXlAyBcqvnd0Sr5371LNCgCzTtrWaO9FwVKnfTy+QQ6rnMNLFD5fOqSzzfpHxLVnoyITy8DmktLVeluVJ7LLpdx/JHpi7pYcfx3xMJb1QINcN3G0iOcDNXIgsLKQxXk/G+JI4DbAjL9OyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBPk9teej8l4N4hBw2GXRHA4BhhBIPSAZsmQzLi6dO4=;
 b=VJ2TVBaj4+K7M14dHzqHSvqDuU2SnOnKfOROyAUYufh2kTLd489s0/DVrO3h3uxSzBBbNC3e2iNm2mHOxJq2lTH5B/p5VF8eH2w0umHRtsVbpqX/SbcPRLyFRzb/dWGSGE2RRNV8qc0Aw5y9nOvV1K3Ie3KFquP/2nLdIHQlNUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:09:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 14:09:20 +0000
Message-ID: <1de58b72-ce84-44f5-96a5-caf7fcc4fd52@amd.com>
Date: Thu, 7 Dec 2023 08:09:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
Content-Language: en-US
To: Bin Li <binli@gnome.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Taimur Hassan <syed.hassan@amd.com>, stable@vger.kernel.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
 <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
 <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com>
 <CAAd53p6py2YdvaJBAgve3y4Xf2sayC7LqDE-JeLpQ_LNtFOj1g@mail.gmail.com>
 <2c350488-0110-4b29-bdf3-b2018e723b5b@amd.com>
 <CAAd53p6WypOSURpcL=C9p2M5K4zai33pPhkSSa_EWvSf0QV-1A@mail.gmail.com>
 <CAGBH1r7Tn7vHbUeL4R1hBj-65yD+JWMho52nJ2WfK2R=9jhi0A@mail.gmail.com>
 <CAGBH1r6Y7cbNTw=Vekcq_iJOJ1Rmt2-Ot6=-WygXZb5kuzioSA@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGBH1r6Y7cbNTw=Vekcq_iJOJ1Rmt2-Ot6=-WygXZb5kuzioSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a8c305-0a80-4602-fed9-08dbf72e1b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XUDcfg0MdA0smUchinwyhlvvTaKn1J0VwB9SLwEU9fMDs6zxNy8VAR6AmQxBifeOOfXVeRIehvHN15KlNcTQu56NW2f2X1m9c+XDndIAELFmEpjvKs0DvvdLinHddTGUaZjoDss4GRAeR/3VVC53rIYqmb98jfRohYhINZ46ccoLa5vfbH91qJMv/Vf7+mPQwZ/LCV7Z2kpTL5gasQ+SsW9wIQBVQ0b+99rXc2jJ2hjQqO3AuSvpHdxMqoTCOoWP4MI0JYdZm2YNTeUqHbJPBdgMPCrVszvHeSEUN/dvKYMr21qgXPyX8JsnTO6Ovhepb2zZJ/6U94P6L/WTw8rN+J+/zrfRNv2cy7bLmAPF/Nzhbo+ljI2a5zxXoOVR5t1p6e3xFT8UEklmapkvwijl94yJPyVuSztKW0nHSx/2knLjptZQxoCvRUOxxA2MFdgqLAxvlXmS8yNaIumNQQD9sTXmZjPFdVeScV4v8c5Ftd9p6TlmKi+PFH0n1exjWkuVFYxbaIG8gZm47gL65Wll4RyUDDuPZU+vF/EO6JHxvXwjXGldaI5CAIRxh33CngMk4JKX7kAI4zNbc9N05VUHn2gkH/ngPPkkTqPsQfE042K3mraxEkt6d27qbh5w1vpV+hagrINas8aVekG17Dbsng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(2616005)(26005)(38100700002)(41300700001)(53546011)(6512007)(83380400001)(66946007)(316002)(66556008)(66476007)(54906003)(110136005)(6486002)(966005)(478600001)(31686004)(86362001)(44832011)(5660300002)(2906002)(4326008)(31696002)(8936002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdSOUpHNlZsQmI4MXVmTklUcS9NVXlUTlQ1MjJSWkI1RlFvcUFrWkJONnQr?=
 =?utf-8?B?TW5Nc24xU0tuVW5vaGZkTHBiTW9QaHoyeHgwN3huYnJZZE5wUUZkd3VQVUtF?=
 =?utf-8?B?NkV3UjJxei9OWGc5M1BPZ01jUURYd015alNJeXV0WXBzQ3UrVEI5YnRHcmpN?=
 =?utf-8?B?MlRYVnQxbWNraFdTVWJHbnh1dU4welFxZHJMKzhLY2k0clhnVkJLeFlGRU5X?=
 =?utf-8?B?ckpaQml3bnNDSTE0cXZxMXA2eDYrOEwyQzlTRHhGTzNPNmdTZG54WFRPZTRa?=
 =?utf-8?B?ekZhSllpbmxXTjB4NW8zbmNsM25ILzJMdk1jVVZaaXVWejI5Q0NReXJJczNw?=
 =?utf-8?B?SVU5KzU1cTVGSEJKY25oOTJZS2NFQzhKWXd6WmgxVWNjS2JIdHZialRHM2J0?=
 =?utf-8?B?R2REem5kMnFyS1dIVmc2ejdVWGR2OFJVQnUycThPeXZzWHVGVGhzK3p5R1ZG?=
 =?utf-8?B?VmVDVkhRMGNoVVEzNVN1UjR1cmM4QlVPVTArUjBCeklEZk9vbEgxTHd4MDJk?=
 =?utf-8?B?TkdMeVRCR2FiWHJqY3gwV3lDRnVoSlBFSmV4bXRnd1BXOGV6TkFkRDlBTkJ0?=
 =?utf-8?B?eDAvMmNZenM3akhmdzNSTGxYb2NjZFgzNzVXUG1GL3hJRjMwdUd5Ryt2VGMv?=
 =?utf-8?B?L0Q3QzVTMTc2dWgwWDViMFFsVG1MVU9rdENRcEhGNkpUdG85SXhEcG51UGtZ?=
 =?utf-8?B?NkM5dWRYendWMWN3cWdpNlVnclE2QVFORlJPR0hGRGdMaDd5RUh1dE5tekNh?=
 =?utf-8?B?V2h1T3dIUUUyZmprYnVhRjVZNE9pRGJhZmhNeGdqVXA3dEZHdXlhVmJXbmI5?=
 =?utf-8?B?UDFHRkhXVVdUdzlyd09jbFVCS25Ga0k2NTVnVFpNNmVTY290aUVkNDNGa3N4?=
 =?utf-8?B?STNSTFdTUEhJRnhIZDBpTDcraWtHaHFlQ2NQZFRLaENTSGpEOXVlcFlKanlF?=
 =?utf-8?B?ZWttOHppa1pMRkY3Vk1XS3BrQTlvMHNsNEFlZUlSNDVoTUlwREJIUjZqZU1B?=
 =?utf-8?B?alg4cGwyQUNiVjFyMTQ3NnRYWnVtMWp1bGxucExaTHdWMGZhcjBoOEw1OGtP?=
 =?utf-8?B?NGExZW9MMVJCS1NNU1BaY3czQ0NSMWhwa3duWlMwc3ZyODNGMGFBV25qRXJG?=
 =?utf-8?B?MTNCWlR3aWN0SnU0SERyMFN3dVFMOGZZQ0wrTXM5K0UyV2VwcFNPVDFnaWl5?=
 =?utf-8?B?R1YxcmdPYnRTQnRVOGNKa2dlWCttbk5YK0VuZkVtUURRYlRHU0NsM1NoYjZz?=
 =?utf-8?B?aE9yTjdPZGRFQ3c5aW8xSnVwcm81V3ZtdlZEcjdCU3NGd2tUdC9rcFpSZmkw?=
 =?utf-8?B?S2ZibnFFWG9VMmpkdVZBaElIZ1dlOUpJRTRsZVFuejEyOGpST2Rhd3FCRG1L?=
 =?utf-8?B?Zkd6WkYvdCtmaEs2YU9jQm1MMzdQRjd0cW9PTTRIUzFYTnlUNHp5NTFHWUFx?=
 =?utf-8?B?Y2VMR2FRZ0ZTTWFUQTJhS0V4SWlLalgxL0Z4YTF6T1pnNDdKWnVOZEduOEFS?=
 =?utf-8?B?ckhNQndNeUs0cy9sVldTRWVUKzJ0MEQ4THN6dWV1eS9Gaml2TTZuZXpkS050?=
 =?utf-8?B?dUFYVVBZWG1BNWNOamhQWWNTbStlcU5CRlkxU1NxcWo1WmlGNlhJZ0lmZ2xv?=
 =?utf-8?B?SkhJRGdYamJyY1h0VWxOWncxMDdwTFBVRHUxcytkNjFFQnl3Ykk2VFpaVmo4?=
 =?utf-8?B?ZnRFWng2NUREc2UzbXU2dGhYMit5MUNXN1BNL2Z5U0RXTlVpMFV5MzFYZjZC?=
 =?utf-8?B?RmtxSzR5MTBiMTYzcmhsVTlKck5hR2lzWlhHZVYrRWltMWZBREJYcVQrYTlC?=
 =?utf-8?B?VFRUU3RKZVdCRnBoYVhaZVR2MUg4NHYwcnFwVElieTROM1BidmNENUxGbTcx?=
 =?utf-8?B?S2tzWm9tcTlFYWJRcHdCVnE0QWQvQlRwc29FSFY0YlVsdXJwQzY3RVlZSDMy?=
 =?utf-8?B?dG0rV2pjblpSSlIyeVR3ZlBORjlIbkUrWTB1U0VuMm9EemNpMmlvU0Q0akov?=
 =?utf-8?B?NUM2TWt4emNLMStzcjFSQ0JwNlRQZmg4T3RoVWduYkpGMVFDQW5qd0YzQ2FL?=
 =?utf-8?B?SUNHK0dSMnpYMGxVSWJSOFNzMkJJZ0NxTnB4M0FIcWFaQUsvQmFwcUJYZy9G?=
 =?utf-8?Q?JC2zC0p+0ji0sm5nLW1JGXqbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a8c305-0a80-4602-fed9-08dbf72e1b6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:09:20.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5+AtPVjTxC4HBVUqFVE8XMLdxYK4R4XObRTxYkCsvOQXHKXaQ14Xw4f38itMtn0GAdgTfj9FYSTP8KgcvQ1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

Bin, KH,

Thanks for the confirmation!

Hamza,

I think you can add a Tested-by tag for Bin too.

On 12/7/2023 04:38, Bin Li wrote:
> Hi Mario,
> 
>   It's a false alarm from my side, after testing the 6.1.0-oem and
> 6.5.0-oem kernels, this patch works perfectly fine, sorry about that.
> 
> On Thu, Dec 7, 2023 at 3:47 PM Bin Li <binli@gnome.org> wrote:
>>
>> Hi Mario,
>>
>> I found I missed the part in drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c with kai.heng's review.
>> I will rebuild a new kernel and test it again, and reply later, sorry about that.
>>
>>
>>
>> On Thu, Dec 7, 2023 at 2:58 PM Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>
>>> On Thu, Dec 7, 2023 at 10:10 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 12/6/2023 20:07, Kai-Heng Feng wrote:
>>>>> On Thu, Dec 7, 2023 at 9:57 AM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>
>>>>>> On 12/6/2023 19:23, Kai-Heng Feng wrote:
>>>>>>> On Wed, Dec 6, 2023 at 4:29 AM Mario Limonciello
>>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>>
>>>>>>>> On 12/5/2023 14:17, Hamza Mahfooz wrote:
>>>>>>>>> We currently don't support dirty rectangles on hardware rotated modes.
>>>>>>>>> So, if a user is using hardware rotated modes with PSR-SU enabled,
>>>>>>>>> use PSR-SU FFU for all rotated planes (including cursor planes).
>>>>>>>>>
>>>>>>>>
>>>>>>>> Here is the email for the original reporter to give an attribution tag.
>>>>>>>>
>>>>>>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>
>>>>>>> For this particular issue,
>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>
>>>>>> Can you confirm what kernel base you tested issue against?
>>>>>>
>>>>>> I ask because Bin Li (+CC) also tested it against 6.1 based LTS kernel
>>>>>> but ran into problems.
>>>>>
>>>>> The patch was tested against ADSN.
>>>>>
>>>>>>
>>>>>> I wonder if it's because of other dependency patches.  If that's the
>>>>>> case it would be good to call them out in the Cc: @stable as
>>>>>> dependencies so when Greg or Sasha backport this 6.1 doesn't get broken.
>>>>>
>>>>> Probably. I haven't really tested any older kernel series.
>>>>
>>>> Since you've got a good environment to test it and reproduce it would
>>>> you mind double checking it against 6.7-rc, 6.5 and 6.1 trees?  If we
>>>> don't have confidence it works on the older trees I think we'll need to
>>>> drop the stable tag.
>>>
>>> Not seeing issues here when the patch is applied against 6.5 and 6.1
>>> (which needs to resolve a minor conflict).
>>>
>>> I am not sure what happened for Bin's case.
>>>
>>> Kai-Heng
>>>
>>>>>
>>>>> Kai-Heng
>>>>>
>>>>>>
>>>>>> Bin,
>>>>>>
>>>>>> Could you run ./scripts/decode_stacktrace.sh on your kernel trace to
>>>>>> give us a specific line number on the issue you hit?
>>>>>>
>>>>>> Thanks!
>>>>>>>
>>>>>>>>
>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
>>>>>>>>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
>>>>>>>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
>>>>>>>>>      drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>>>>>>>>>      drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>>>>>>>>>      .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>>>>>>>>>      4 files changed, 17 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>>>> index c146dc9cba92..79f8102d2601 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>>>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>>>>>>>          bool bb_changed;
>>>>>>>>>          bool fb_changed;
>>>>>>>>>          u32 i = 0;
>>>>>>>>> +
>>>>>>>>
>>>>>>>> Looks like a spurious newline here.
>>>>>>>>
>>>>>>>>>          *dirty_regions_changed = false;
>>>>>>>>>
>>>>>>>>>          /*
>>>>>>>>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>>>>>>>          if (plane->type == DRM_PLANE_TYPE_CURSOR)
>>>>>>>>>                  return;
>>>>>>>>>
>>>>>>>>> +     if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
>>>>>>>>> +             goto ffu;
>>>>>>>>> +
>>>>>>>>
>>>>>>>> I noticed that the original report was specifically on 180°.  Since
>>>>>>>> you're also covering 90° and 270° with this check it sounds like it's
>>>>>>>> actually problematic on those too?
>>>>>>>
>>>>>>> 90 & 270 are problematic too. But from what I observed the issue is
>>>>>>> much more than just cursors.
>>>>>>
>>>>>> Got it; thanks.
>>>>>>
>>>>>>>
>>>>>>> Kai-Heng
>>>>>>>
>>>>>>>>
>>>>>>>>>          num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>>>>>>>>>          clips = drm_plane_get_damage_clips(new_plane_state);
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>>>>>> index 9649934ea186..e2a3aa8812df 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>>>>>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>>>>>>>>>          struct fixed31_32 v_scale_ratio;
>>>>>>>>>          enum dc_rotation_angle rotation;
>>>>>>>>>          bool mirror;
>>>>>>>>> +     struct dc_stream_state *stream;
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>>      /* IPP related types */
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>>>>>> index 139cf31d2e45..89c3bf0fe0c9 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>>>>>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>>>>>>>>>          if (src_y_offset < 0)
>>>>>>>>>                  src_y_offset = 0;
>>>>>>>>>          /* Save necessary cursor info x, y position. w, h is saved in attribute func. */
>>>>>>>>> -     hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>>>>>>>> -     hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>>>>>>>> +     if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
>>>>>>>>> +         param->rotation != ROTATION_ANGLE_0) {
>>>>>>>>
>>>>>>>> Ditto on above about 90° and 270°.
>>>>>>>>
>>>>>>>>> +             hubp->cur_rect.x = 0;
>>>>>>>>> +             hubp->cur_rect.y = 0;
>>>>>>>>> +             hubp->cur_rect.w = param->stream->timing.h_addressable;
>>>>>>>>> +             hubp->cur_rect.h = param->stream->timing.v_addressable;
>>>>>>>>> +     } else {
>>>>>>>>> +             hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>>>>>>>> +             hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>>>>>>>> +     }
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>>      void hubp2_clk_cntl(struct hubp *hubp, bool enable)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>>>>>> index 2b8b8366538e..ce5613a76267 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>>>>>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>>>>>>>>>                  .h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>>>>>>>>>                  .v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>>>>>>>>>                  .rotation = pipe_ctx->plane_state->rotation,
>>>>>>>>> -             .mirror = pipe_ctx->plane_state->horizontal_mirror
>>>>>>>>> +             .mirror = pipe_ctx->plane_state->horizontal_mirror,
>>>>>>>>> +             .stream = pipe_ctx->stream
>>>>>>>>
>>>>>>>> As a nit; I think it's worth leaving a harmless trailing ',' so that
>>>>>>>> there is less ping pong in the future when adding new members to a struct.
>>>>>>>>
>>>>>>>>>          };
>>>>>>>>>          bool pipe_split_on = false;
>>>>>>>>>          bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>


