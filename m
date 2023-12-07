Return-Path: <stable+bounces-4893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75883807E3A
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F18C1C20C56
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C715C9;
	Thu,  7 Dec 2023 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRxtbPKW"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC34D4B
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 18:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su9tzxVx+xJHeICkQsbSICcEU6HwW4tn7voRsHcV/2+t4WCHZF42tL4O1ZpsqWMTxLcfyD0aJV9QFM238WTrFdjfnwU8bXpKHigRIPsKr74HCs1eE0EDKWwLYLFDI7+Dvq3Xjp+GNKLpQzvRZ0adyxdbWCZTaRekrMg2Wy+MD5NnZhUPNDYm+IDYHKBjEyW4f8eB7mdm5CYID1gLwFXYXUouHUgJhL1/o6nspuzQ5Ag5I3wxF2EEuD5rD+54jDzQehzLal8vBHrcYxY5+c5lHSLLMLVWL4hEIlYROO1f+svp6CFxBzLAGDLLOPixRJbarYNvejK7Ch+yv0AHtPmS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fHvzJoZabbaf2xBgHB1CvjMCB+8fS6MqgVwZpzeTXI=;
 b=lptFoHzQXlkmm+gRG3avdDnpQHuL1qIwzRAP0rCqVvr4in36hi1utNBo5WYWnC0PqlEqD7W4GWddYj6RXnYpFNnxKhklo1DSjPRGBMmyzPBuhSR4DqUaRjUXBBp7qSPxOnwREDL4PdRedAhp6NRKhe12bNoI19/fC0hyZfO8VSZcGZTsbHRjRsENTTkYu6VZhxTK86Uj5IbFbJc6Dl+amwX/AKMTmTMO5IwBOZkBWPc4WBrtc1gr4ZcOus47n+uKM6EhwrepHvY/HlivniK5kiO3Yd2MuAksS/zfiBsukHgMRwijy/HVHL6nfhaE8IYgtDhru0UIMEOlXJi3LkslUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fHvzJoZabbaf2xBgHB1CvjMCB+8fS6MqgVwZpzeTXI=;
 b=cRxtbPKWm0TWS6cG08SLEOrRDEXoTGQ9fAhGKaDBtK2vD6Hj25+4zcnYzQmb6kGNoL+wuzOevDUkHU4j3V5oeVoMUcMEHMh4kgvmHVG/VJObPBUVaTNBIDY77qXlPZ/2X+EPnZpTwgAkCguh01/eqMirfhEqI50qI/LUJgJ+hFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 02:10:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 02:10:17 +0000
Message-ID: <2c350488-0110-4b29-bdf3-b2018e723b5b@amd.com>
Date: Wed, 6 Dec 2023 20:10:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: binli@gnome.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p6py2YdvaJBAgve3y4Xf2sayC7LqDE-JeLpQ_LNtFOj1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fb65b2-ee94-4179-231d-08dbf6c9a864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0MJ9TozyRIXHDYBL04ef4WX/7CYOUe7QbA/llXoJ8x3N7mRECiLtnn/OYDo5a81BdgjKftb8e2BtX2am6I8yLLSRaYcpB/+6JCcsic3ffZJ//1l4we76aG/Q2LIoznOENnka+y6cgX+rrMAiQP/XtbJieWNe5RyDw3LIVMVX99jradLIRwYpg2X5vHUp0E9Ca16ABb//ijyTCn/suwirn9E/Rr5GoqORw8wp+kaLdLdUANJwhC0fnC41kZzsxoH7g4lXqKC6ctkmBqGKLTJnlhNo86SWJt8TXmR93nryDs4HfxUKmt2N8oto0kBiWb04uv+sGmltdVYZQqExxJctzspKKrYI/eohLfxvqlfHL5ug0kJ737NZfRSr8YRWCTiuNIuIebFEI0tVNXtXK7blmHrelNzAAw/9Qahp8BX9KaPgiQpb4cWq7ij9IgEjyKM/JqGRPyrPh1BFZLeLcQMLBbRSRd5AlR75D46FeS/TSEMvVQDyKAvjEmVgR7OptFcxKOMZzIIhmiHrSegn6ekbkQOinq9CWVRRVHF+25flLkgFgSbqkIxpN0/bnomP1R2Pz620lg4aCyb1I5zZtDBdxy/ZOKmNbGYERirW8OhUfTkweoa/LzQUMPOveGFFQBHp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(478600001)(966005)(83380400001)(6512007)(53546011)(2616005)(6506007)(26005)(6666004)(8676002)(66476007)(66946007)(54906003)(316002)(66556008)(36756003)(6916009)(86362001)(8936002)(41300700001)(4326008)(44832011)(31696002)(2906002)(5660300002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNmc3RyMEI2cmdUM1ZKWWhNR1hJcmQzYzZWejF5R21lRzIrV0gzQVMrWjB2?=
 =?utf-8?B?aFRuVXhWbldKTXBoRkxubCtnZmFUT2s2ZjQyOE9pdWJsRWl0YjJrU3N0OUhV?=
 =?utf-8?B?ZzBTRW41VVpNejdoNUdYdUd3a1RSYTFReHVFN3VMRmt0RmZxRm85NnQ3aEJt?=
 =?utf-8?B?bUdwT0ZGd3ZNZFltOU83Y2hxSkV2NlhmZ1k0OXd6b0FZMDY5ZDltdU1hcTJU?=
 =?utf-8?B?dFVHb2FUeVZjRUpFdGszbzg5Z0VHMGcxQzdMRFVhckdmZ1A2d3U3TnRLcTFr?=
 =?utf-8?B?QlVxdzhrMUpFekNTSVl6WG8vRDBtbWg0WjkzamlVRld4OU9WRXY5d0o3TDcz?=
 =?utf-8?B?em9xMlJUZVUrRTB6dS9hb2NScE16emRrQ1RuTHBNVWRzWGJ5bjJtSE5yZUxo?=
 =?utf-8?B?YnAwU1phTHQrTjZ4QlFZSFYwMUZ4RFZyL3JONk5YYlNSbHVLVE1sbGNEZGVS?=
 =?utf-8?B?WXZKajJIdERaeDV4d0h3RG40R29LSHNQcHNweDIyVmF0empmeHc2NXp3Zlhw?=
 =?utf-8?B?Q0JTUWMvVHhWQVlCb0gyeHAvN1FXZW1JTXpWVUdoQWs3WE84N2lKemhyZ0ZT?=
 =?utf-8?B?Vk9BTTF1OVFDUk03ZW8yTVdCSHkxd29wb2dNK3NjL3ZQcGJyZ2FYbS9OZ3hi?=
 =?utf-8?B?WWRkTEw0MWZZckRTZWF2azhlUjZVRzhkWEU0OWp3YnFNYzZFbUpHWldrMmZQ?=
 =?utf-8?B?bWI2a3F1OU1sYzd3MDlGTGM3d2VneEhoN0FhdyttSXgwTzY4dkxSemlDUXg0?=
 =?utf-8?B?UUxoblErRk1wRzNIQW95M1kzRk9TUXFOUXNxRFlOdUx1KzdjcXdCWHFjZkdO?=
 =?utf-8?B?eitTOTJxTnE4dVVSZEJ6UkcvMktCeWZHQVlJV0YyWjlKVmUzV01DVCs5U0VF?=
 =?utf-8?B?K050eWlaQjlScGpNK2ZOQU42U0FLS2tQU2ZDdnhnOXhkVzZjTFZEbk1SdjI0?=
 =?utf-8?B?ZGJaTUVnWHJmb3Y5VFY1STk3QkdndmlwZG95R2ZSUXJlMDQyaXgxS2tHMnlL?=
 =?utf-8?B?ajVUUlRMYjU0YmcxZEszTTR4a0ZVMnI2eGZDWVNKTk9jNFhDbG9uOVB5OGhz?=
 =?utf-8?B?aTdXQmVGUWhweUNkYjdjbUUxNVBzYm5aVHAvOVU3OHdia3BwTGdQTy91aDhv?=
 =?utf-8?B?Uk1Sc2V6MlBBMGhQNVFqQy8rUHl5a3RCWW5WbzBySXk3SFdGY0M5cXI5Ymtr?=
 =?utf-8?B?TUNhVVJCeVRoU0JqR0pCS05DTytFcU5WS3NOZU0zZVZteU5LdjhBZmdVTnBv?=
 =?utf-8?B?Tk9Oak81OUs2UE1EU0MvWVowSjFDaWVkR1lyZGpLM2tWNURFRGFyZEFKdWdw?=
 =?utf-8?B?UEdTTkNpT00xY2lUcldpRFVnYUs0VFV6Q0diVFF4NUNTSTNKdGZyM1hOd2l2?=
 =?utf-8?B?aXNxQWl3L3B3T3ZURld6ODFNcGZ4YjJPV29nNTUrZm5zRk03NTIrZ1FBOEVZ?=
 =?utf-8?B?LzV5SVhmZEFDdzhTTDhWUEdNRlQ4UTNWWEpCT1U4ZWZvQkhHaUg4TU14LzFj?=
 =?utf-8?B?YStuNU10NldKdE8xZlU2VTI3UzJRQUpkdnhKZkhtV2JPbUhPQTVQYStuZ0pi?=
 =?utf-8?B?VG1Jd1NjWjNES09EZ3V0YkZnQ3ErRG5qOGVYeDRoN3dZSW0vMkkrZ0VlL3Jh?=
 =?utf-8?B?N3lUY3Y0cW1OUE5hZkVvbGdoSDZtem4vTEJNcjA0WW9yNDBMUkpRdE5uM2xa?=
 =?utf-8?B?R3lFb0ZxaWpldFdTOEhlTUVLVVZNSmgzQVlhRVYranJjNW1lOHA1UUJEblc0?=
 =?utf-8?B?YUJRVE1TZHhhQjIyOFFIQTYyVTBIM1BVR1JIYUVyK2lpRGpjVlpvTEZKK29k?=
 =?utf-8?B?ZElreWR2N1FDQUdVQ2dya2NlbjRFT3d3NXdTNTVKMjU4dGVXR1FqeTJSd1pX?=
 =?utf-8?B?MnJ4bm9yYUovK2lsMGkwZVJKdUJwaDBQYUQ2dm12cm0wMjNhTFU2bnMwekRy?=
 =?utf-8?B?Mmpka2tybWxkVXFCOWd1M3ZGYTFMZytTRVQ2ajRxQkNtTVVieTFldUFTTjN2?=
 =?utf-8?B?bWZNU3JNRytVeHFkNkMyVUlpUnZsczNSVkJJV3JrcTk5Qk9xVjd6ZUNVK2VD?=
 =?utf-8?B?S3JOZTMwa2pVbmNJYm9HZmVGTTVpSm1Ham5tMkhDU1dDaldwOWhPbFljUnBM?=
 =?utf-8?Q?XOOs8pU8+NbuETo7cKXx2Po3A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fb65b2-ee94-4179-231d-08dbf6c9a864
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 02:10:17.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGpoYOpkAYwbq3P2zfqY1x+GYRXx59+9pIKCNhakses5FplL6tIsR2SD78LKcALPnmft2b7tcxt08Ei/UIKDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

On 12/6/2023 20:07, Kai-Heng Feng wrote:
> On Thu, Dec 7, 2023 at 9:57 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/6/2023 19:23, Kai-Heng Feng wrote:
>>> On Wed, Dec 6, 2023 at 4:29 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 12/5/2023 14:17, Hamza Mahfooz wrote:
>>>>> We currently don't support dirty rectangles on hardware rotated modes.
>>>>> So, if a user is using hardware rotated modes with PSR-SU enabled,
>>>>> use PSR-SU FFU for all rotated planes (including cursor planes).
>>>>>
>>>>
>>>> Here is the email for the original reporter to give an attribution tag.
>>>>
>>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>
>>> For this particular issue,
>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> Can you confirm what kernel base you tested issue against?
>>
>> I ask because Bin Li (+CC) also tested it against 6.1 based LTS kernel
>> but ran into problems.
> 
> The patch was tested against ADSN.
> 
>>
>> I wonder if it's because of other dependency patches.  If that's the
>> case it would be good to call them out in the Cc: @stable as
>> dependencies so when Greg or Sasha backport this 6.1 doesn't get broken.
> 
> Probably. I haven't really tested any older kernel series.

Since you've got a good environment to test it and reproduce it would 
you mind double checking it against 6.7-rc, 6.5 and 6.1 trees?  If we 
don't have confidence it works on the older trees I think we'll need to 
drop the stable tag.
> 
> Kai-Heng
> 
>>
>> Bin,
>>
>> Could you run ./scripts/decode_stacktrace.sh on your kernel trace to
>> give us a specific line number on the issue you hit?
>>
>> Thanks!
>>>
>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
>>>>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
>>>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
>>>>>     drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>>>>>     drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>>>>>     .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>>>>>     4 files changed, 17 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index c146dc9cba92..79f8102d2601 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>>>         bool bb_changed;
>>>>>         bool fb_changed;
>>>>>         u32 i = 0;
>>>>> +
>>>>
>>>> Looks like a spurious newline here.
>>>>
>>>>>         *dirty_regions_changed = false;
>>>>>
>>>>>         /*
>>>>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>>>         if (plane->type == DRM_PLANE_TYPE_CURSOR)
>>>>>                 return;
>>>>>
>>>>> +     if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
>>>>> +             goto ffu;
>>>>> +
>>>>
>>>> I noticed that the original report was specifically on 180°.  Since
>>>> you're also covering 90° and 270° with this check it sounds like it's
>>>> actually problematic on those too?
>>>
>>> 90 & 270 are problematic too. But from what I observed the issue is
>>> much more than just cursors.
>>
>> Got it; thanks.
>>
>>>
>>> Kai-Heng
>>>
>>>>
>>>>>         num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>>>>>         clips = drm_plane_get_damage_clips(new_plane_state);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>> index 9649934ea186..e2a3aa8812df 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>>>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>>>>>         struct fixed31_32 v_scale_ratio;
>>>>>         enum dc_rotation_angle rotation;
>>>>>         bool mirror;
>>>>> +     struct dc_stream_state *stream;
>>>>>     };
>>>>>
>>>>>     /* IPP related types */
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>> index 139cf31d2e45..89c3bf0fe0c9 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>>>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>>>>>         if (src_y_offset < 0)
>>>>>                 src_y_offset = 0;
>>>>>         /* Save necessary cursor info x, y position. w, h is saved in attribute func. */
>>>>> -     hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>>>> -     hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>>>> +     if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
>>>>> +         param->rotation != ROTATION_ANGLE_0) {
>>>>
>>>> Ditto on above about 90° and 270°.
>>>>
>>>>> +             hubp->cur_rect.x = 0;
>>>>> +             hubp->cur_rect.y = 0;
>>>>> +             hubp->cur_rect.w = param->stream->timing.h_addressable;
>>>>> +             hubp->cur_rect.h = param->stream->timing.v_addressable;
>>>>> +     } else {
>>>>> +             hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>>>> +             hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>>>> +     }
>>>>>     }
>>>>>
>>>>>     void hubp2_clk_cntl(struct hubp *hubp, bool enable)
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>> index 2b8b8366538e..ce5613a76267 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>>>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>>>>>                 .h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>>>>>                 .v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>>>>>                 .rotation = pipe_ctx->plane_state->rotation,
>>>>> -             .mirror = pipe_ctx->plane_state->horizontal_mirror
>>>>> +             .mirror = pipe_ctx->plane_state->horizontal_mirror,
>>>>> +             .stream = pipe_ctx->stream
>>>>
>>>> As a nit; I think it's worth leaving a harmless trailing ',' so that
>>>> there is less ping pong in the future when adding new members to a struct.
>>>>
>>>>>         };
>>>>>         bool pipe_split_on = false;
>>>>>         bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
>>>>
>>>>
>>


