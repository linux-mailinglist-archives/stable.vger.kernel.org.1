Return-Path: <stable+bounces-4891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B633807E23
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF52824FE
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A415B9;
	Thu,  7 Dec 2023 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wyWvBpnM"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2451A5
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 17:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cisT+qkwv1RXTJ3oo9U4OyEjagWb0J0boY6A14yKR1BpRSw9aI32F2xHBejSwBfh/vzY7svnLEBnyPh0YV3ep17rgQ5CGCqc619V+8PrZKnNU2SCeuevPSJxFhlF0Paqrfb376S4BuqBO4h3LV8jH8D2arXrpJOirwIT5mQRJzdJgUghmPwjnTfIoN9kU95pS7Sk07g53KoAmlQW0KCedSXv7ykAE8WCMwDrhGzcN8NVmVrzJ7CSEcUURIWpC87Ql+SGwS3ltRD+pkQKF46zp2+ybV4xsEAcI0rQnTMHwUTgdbhTa1oE9zZiohJrGGRqaVTVnL0W6ogJ0lSbSHjgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxtYan6AoyVXnlOPMnT/8gGQM3Jm9kcpjcO+TYzKF+E=;
 b=HInpJWMqb2zPx4u2OoVlk+jHiPNMjpwX0cYKGDJduMUP48kg7IL9ij0y6D1kUTgexfqQPMqU9qc8utBukgPXzqIa9l1S9DWFblwLa8FQB1d6e++8CJXuPO9bl0CtjijM6ZW0FcoyE6Xis8SOMgVBC34IO1SaGAC+SXHrCFTuUqkjq8N1aDNX6P7Tv5cu0ScuN/tr/WNW820cDPV5nA/3j9eQANsWW1cUSFBP384/PPsWmmCD485YwDL03OFv0b5smsSR3p1S7iiYBsj+nYKJMimOHcSvaNoyEDdbFDEDCboLP5Y7PWaF4kjcEdKAMEzkSP8Np3H1NHrX5BKt8j89/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxtYan6AoyVXnlOPMnT/8gGQM3Jm9kcpjcO+TYzKF+E=;
 b=wyWvBpnMKtetjnGEcz04Awg2sR/Ae+wv947Ns7bQLhq2/war3gJP+Wm7dp1sdyhnzorBeFifvvw1BJrx27xRrH+FhQgOnoK9kvsxGQ6ua/+Qh03J0kDw85Y0+CVkv69MikcDg6MzamYauPYIEABHoljBLTiBNXu//4wgrEDIKks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 01:56:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 01:56:59 +0000
Message-ID: <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com>
Date: Wed, 6 Dec 2023 19:56:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, binli@gnome.org
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 96450f7c-ef2f-4f7a-b5d4-08dbf6c7cc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HCtyEhs/BlyORYA2DUTzGchAguH1w+5cbNWhX8R3+SVpMajVkbnSUcJCKOlR4+zNcNkqq6ftl4zPsQcQ1a/tQRK0E1+FH9gKYT4H625Z7DZ138EfRm+GTtDp9RpZCCmrG1K1v1IRXLphImdBms5OzJwHCP+l5LGeWGac0pGBHJMmm3zvalHhO9b3aJ/H7wjDrM3AdjceNPfW1iwb5xrIIokg9DBe0LohG3JfY8mIxNNdyNdljG1lvHJwA9Y2NF9E260+1cGEEyPYkgiZv+RvNw2MuzbTh2tNyxdwrFSBGz6B2JVahMwhCoUTDUERRHEE5x6Ecnjkn/xXBGzn5C5YV63Bx57o8GXwLWqWSZMHnhp3ofMI2mwTz6ItkbvUQ9BGQUAvdPxYEfuVPfPnhrcd4SW5A+tKZBBZqw24PZRLcPINS7D38q+U8tqNVR+rwSbxJLy/6F5GZbNzYhUkuyYWqnKxN+Pb2F1Z5+niBuqKcikPimgs3JjtsC8/bcLKLSZADF4NL3orFUX1hNIcdsmmt9lEKEpDt5IUZX2SZjuSiLNktorfBKbiYVVa0LgeP46R3Xwr2ZEE5iEZRRl+dQMmS93niUMH/dtrML5wnUn3LE511qZpXFoj54Q1xy7OsfQq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(31686004)(31696002)(26005)(83380400001)(38100700002)(86362001)(6506007)(36756003)(6666004)(6512007)(2616005)(4326008)(8676002)(8936002)(5660300002)(53546011)(44832011)(41300700001)(6486002)(966005)(478600001)(54906003)(66946007)(66556008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWk3ekZBUHQ2bFk2WWxJSjRwU0IycVFhYnc3TjkvbDcycy9SZVM2cExuVi9H?=
 =?utf-8?B?UU42SFlUQVJoSjg1VEtSQmdwdTYrb1J5a1hIN1dsdWI3TnNJY3JWRXhURWVH?=
 =?utf-8?B?SVlXWCtEbHNvdG9sNTBKYXhqZXJFNlZPZnJ5RHJXd1RKNldjcWE4YzkyZkNU?=
 =?utf-8?B?NkIyb2hqRzkyVDFjKzBGSG16QmEyblc3c1FoYzBpOXYweHBHWFJrYWtleVo3?=
 =?utf-8?B?bGRaRVFOaXF6eGRHbDllTWs0emgrK3lFMFo3SlkzYVRXRWMrQVBNdUlwWEZk?=
 =?utf-8?B?K0k0NUQrbUl5TDJ4akpNU29uSFN2Nys4RzZIcm9QalVYdFpGbWdiWGI4NFZt?=
 =?utf-8?B?VGt4YVptYW1sK3VKdWxQRXUvQnE3eVFkbzdWSENiVzh1aVBZSDI1djJMcVpq?=
 =?utf-8?B?bHB4VmhCQXFTL0kvNnpIb0FRV3lZb3RBN0RBZUg5Mkthd3lFcW51OVE1dE9Q?=
 =?utf-8?B?a2pwL3A3aHhYUTQyZXZRaXRBR2p1ZE41RWZpTmpKdzB5MVh3VjBucGltNHlU?=
 =?utf-8?B?REVLbXBBYWdhNjgreUZpN0tJNElXK01LdGFIbllNaTFzdmw3Qi8vazBWd1Na?=
 =?utf-8?B?WGc4NGRKcENyWTVNbG85a2wxVUZna015ZU1qZ1UrZFphS3lpTUhHbUpUL2Mr?=
 =?utf-8?B?NjhKN3diWXVudDFjRzdDQ2FoSjhBVmMwWHhPZjFnQmVUZzJUdDVWY1hZM055?=
 =?utf-8?B?cUtDWXJqaTltWW82T1Vlc2JHazIxTnRmUWphM05wWklwSHFqOGtZM2NpbVJL?=
 =?utf-8?B?N3BhVXFCUjBKMjBVT0QyUkt1NXVENjdRRzdQYWlyN00zaC9ONUczaWpvMTVw?=
 =?utf-8?B?bU5IOVArOTlmd3lWbEg3S0pLdmtSUGovU0JDb3ZCU25reEdPK2tTVG1LK3l2?=
 =?utf-8?B?UHF3SHNGVWlKRzdva3I1azIvUTBBeVdtRkVMejdCQ28va0ZYb1pUL2RwTjRu?=
 =?utf-8?B?Tm91NFdKMUp4Zkxja0xqSTRlakdsZUZ5WWpZSzArK01GNGMwZzNwL0FMVlJw?=
 =?utf-8?B?eGYwMWtnaXkzcnlhd1luOHFqV3NmbFovdlVXdkNYQjVaSkRPM1I1Ynp0MW1N?=
 =?utf-8?B?cWRnNUE0R0U5Y3dCQUpYSGFZTVkvZXpIZmw2VkM3Ujl3QnNjSmJMZ2prQzdi?=
 =?utf-8?B?TElFeXJmUU5zdFdBbm9qWWliV3prUzFkVEEyQ2ZqbjhLektlcUZSQmczMnhv?=
 =?utf-8?B?Yk5EaXR6Qk1uaVZWNjgrRWJKY3ZBM0FFcWRycXFQbnZDcEk2SGJKK25LWURO?=
 =?utf-8?B?MkVFSUMxK1BHVENBaHE1NisrMWhpWlJNWGxuemR6RFl5cDI0cVBHbW94KzYz?=
 =?utf-8?B?ejVxT0pCN3BUQWMyazdnd29lMisrZTZ0ZGJJQllsV0hEeWtkK1JRUVVSVGFP?=
 =?utf-8?B?R3JuZTdEK2hlZkxkSitWM2JsWFk1b3RpclNNRWJuR2crb3ZLb2lMWW1nN0E0?=
 =?utf-8?B?TGNlNTFya0NtZ01hTVFoNXlZWTJLOTNIaXh0cXh5d01OMGN5SzhzSSsvNks2?=
 =?utf-8?B?UGZ6UUFReE9tMWp3dFJKdnExRUdmeUxwK2FnNFNXcyt4WFFaVnRIOVVFZVJC?=
 =?utf-8?B?ZGFUNENxVmVheTVKOEFIOWY4cmxsdmlua21BZG55NlMvTldsTlJ0VUFZSVpt?=
 =?utf-8?B?T09xM0lGZjRPRTJVT0htTkxySEtQaHFvVGxtMXZvTkxyUVpxSjYwKzJ0R0JQ?=
 =?utf-8?B?QS9GUlEwbk5tVkdKdVNrSlArRUpUbnFmSGVIT3JEOFpMbUlaWEgyWkUyY0ZO?=
 =?utf-8?B?Ti9xRTlsTU44SGx6L1VqNXR5RnBVWjVvbmxhWEZJWkp1ZHRmZ3VIQnVqWm5P?=
 =?utf-8?B?ZGY2Mld6SmJwK1pXMnpNays0aVBVck1Fdm41NEJFaEZESytxcmZxa0hsWEdW?=
 =?utf-8?B?YloxdWlmdm1YS0hmZklreHArMklFUUJrc0dZbHFqN2V2NUc1bkViOXBraGtZ?=
 =?utf-8?B?UnM5UHJJczA5aWhDdlBXL0VjWE5MYnpYdmRDQTZRY21rUmtOS3hEdENKRElH?=
 =?utf-8?B?QndEY3NPcTQ0UXI3U1JkUGpBQzl5MVU4QXdxQjVta3NWWE5iVjlRd08xUEdk?=
 =?utf-8?B?OW9TN0RrNXZBWjA0b1BHN3pXSG52bmw3NldpMURPemRqamQ0NGNQWHRycjll?=
 =?utf-8?Q?maNF+SQ0VE4BefRVA17/E54Ml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96450f7c-ef2f-4f7a-b5d4-08dbf6c7cc39
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 01:56:59.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWclnKFl383/XDroCeuAzjoLvafhnFOhuGZHQnfJ0KQVAXnGnLeDo9Rj3SNUV6lf44zq0rkrcOAjzNamEKIHjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

On 12/6/2023 19:23, Kai-Heng Feng wrote:
> On Wed, Dec 6, 2023 at 4:29 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/5/2023 14:17, Hamza Mahfooz wrote:
>>> We currently don't support dirty rectangles on hardware rotated modes.
>>> So, if a user is using hardware rotated modes with PSR-SU enabled,
>>> use PSR-SU FFU for all rotated planes (including cursor planes).
>>>
>>
>> Here is the email for the original reporter to give an attribution tag.
>>
>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> For this particular issue,
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Can you confirm what kernel base you tested issue against?

I ask because Bin Li (+CC) also tested it against 6.1 based LTS kernel 
but ran into problems.

I wonder if it's because of other dependency patches.  If that's the 
case it would be good to call them out in the Cc: @stable as 
dependencies so when Greg or Sasha backport this 6.1 doesn't get broken.

Bin,

Could you run ./scripts/decode_stacktrace.sh on your kernel trace to 
give us a specific line number on the issue you hit?

Thanks!
> 
>>
>>> Cc: stable@vger.kernel.org
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
>>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
>>>    drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>>>    drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>>>    .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>>>    4 files changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index c146dc9cba92..79f8102d2601 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>        bool bb_changed;
>>>        bool fb_changed;
>>>        u32 i = 0;
>>> +
>>
>> Looks like a spurious newline here.
>>
>>>        *dirty_regions_changed = false;
>>>
>>>        /*
>>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>>>        if (plane->type == DRM_PLANE_TYPE_CURSOR)
>>>                return;
>>>
>>> +     if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
>>> +             goto ffu;
>>> +
>>
>> I noticed that the original report was specifically on 180°.  Since
>> you're also covering 90° and 270° with this check it sounds like it's
>> actually problematic on those too?
> 
> 90 & 270 are problematic too. But from what I observed the issue is
> much more than just cursors.

Got it; thanks.

> 
> Kai-Heng
> 
>>
>>>        num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>>>        clips = drm_plane_get_damage_clips(new_plane_state);
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>> index 9649934ea186..e2a3aa8812df 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>>>        struct fixed31_32 v_scale_ratio;
>>>        enum dc_rotation_angle rotation;
>>>        bool mirror;
>>> +     struct dc_stream_state *stream;
>>>    };
>>>
>>>    /* IPP related types */
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>> index 139cf31d2e45..89c3bf0fe0c9 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>>>        if (src_y_offset < 0)
>>>                src_y_offset = 0;
>>>        /* Save necessary cursor info x, y position. w, h is saved in attribute func. */
>>> -     hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>> -     hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>> +     if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
>>> +         param->rotation != ROTATION_ANGLE_0) {
>>
>> Ditto on above about 90° and 270°.
>>
>>> +             hubp->cur_rect.x = 0;
>>> +             hubp->cur_rect.y = 0;
>>> +             hubp->cur_rect.w = param->stream->timing.h_addressable;
>>> +             hubp->cur_rect.h = param->stream->timing.v_addressable;
>>> +     } else {
>>> +             hubp->cur_rect.x = src_x_offset + param->viewport.x;
>>> +             hubp->cur_rect.y = src_y_offset + param->viewport.y;
>>> +     }
>>>    }
>>>
>>>    void hubp2_clk_cntl(struct hubp *hubp, bool enable)
>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>> index 2b8b8366538e..ce5613a76267 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>>>                .h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>>>                .v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>>>                .rotation = pipe_ctx->plane_state->rotation,
>>> -             .mirror = pipe_ctx->plane_state->horizontal_mirror
>>> +             .mirror = pipe_ctx->plane_state->horizontal_mirror,
>>> +             .stream = pipe_ctx->stream
>>
>> As a nit; I think it's worth leaving a harmless trailing ',' so that
>> there is less ping pong in the future when adding new members to a struct.
>>
>>>        };
>>>        bool pipe_split_on = false;
>>>        bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
>>
>>


