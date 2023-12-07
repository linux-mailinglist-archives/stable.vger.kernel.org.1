Return-Path: <stable+bounces-4924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967E808AE3
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F21F2150B
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A22D7A4;
	Thu,  7 Dec 2023 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AuxmTkao"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C279C6
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 06:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8oNbU2ubb1df5687dGmvgFCZqMxBqcHX0YrmqKZh4d2k9yMgjYxTW7soZshCmD0SFk6xcykKmrwtA+kFdXPl5lpyBW4iQJD0eRmeSkPxaQFvZmSybOM0cq7LCZaNsVKf7ULq9mUghBwHIdKayv+i9nKzvIe9S3Rq0vehbtjJF4CoD2JaJIuJFkAhrNLnR5wcKjow5/yYqEoaOKtqtTq8czF8uKnY8571GNKnSYARghipszi+Mc7CF1fC6/lcnIpcVVFfNrhU3An8Wocsc1u2fdmzvb/7rKgcsIhHerwF2eF3nEnlchLQKWYYgOAZJVZBscTQQPDmHlGDOat7TmpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNnG3kNVFysmBY0CwYmhsMOGesqTdNfjrgD+wnZpaLE=;
 b=GqjpPvQA/u5s9tH5fJywQJO2qu9D8cT1S1r0lR9VGMA4ZRjAf8swv4MdooC3PJNX1p2NAOzEAlG48RkiyOcMUcgRAGgXQ2SkOZb/R6xFxcFEsu8mpLd8XhHzmLP52s+z8PJM14sHB/G2YIWRHBXRtrarnESMWchKUFp0MnWo/2QOM0FsFPXm3f0sl7yXQKY24HfkaCU/Djpgm2N94NPzrMSLc9GpCkE9X8Bg113JEDot7w+gVGUM/wU58I+U7IBDmIwMh2zh87yOtpEnWT8vxnmeA5Y+4nQOCmalw/BDteXuMdJ3xcjpUxa7niRfnenD9+PkE9tt/gp9x3qbskAJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNnG3kNVFysmBY0CwYmhsMOGesqTdNfjrgD+wnZpaLE=;
 b=AuxmTkaoRxcEifeZcmvF/YTDyDs+1dthCPwP56pTSQlDIekgPKWAXfRRSpY9ohqT69qo9XXaaR5mfNm7KrzPHCeCHJk7NEBfZywvLnZ/1ohpEXGDYIapXQssGYzuW1mVxblbn5/ne7bV8/9bIP17NmseB27XfJOa/xClojfqnTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:42:55 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 14:42:55 +0000
Message-ID: <b1acb1bc-33de-4f0b-8213-2a075578242b@amd.com>
Date: Thu, 7 Dec 2023 09:42:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Taimur Hassan <syed.hassan@amd.com>, stable@vger.kernel.org
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::11) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bbf940-e714-4d2e-7c5a-08dbf732cc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mLn8nIgph5aeirYTozbJ8q5Lnfu50OKjKZt6vi3jZvG+Yy1KiRnFbE3G9TB7yOq7lDXhfSjsDl4/VHqJsZC7dttdciasJf/nuYqNrZRsi7vmbayO4Q5dYH3SGwxB8MI81dpSigbnU8JAUDfWEmbBS0yfOW6oqxmWEPPezLXdqvXICSUNUPfcTPcIpQW3h9QO10PFsisF4HqrpmuVgTdvWKYnbYfgvgnhG2B67vwbAQq7mlnxJ8oq65IKZevzA3ZDt4XIOCo1+18RNw4K7HjJ9W2ceAEnRTF/GV3PVEZb9+GtJKThsRpurECCoRUYFBnusZRZKLOpGBzb2nkfTacMM0H2AkNNiO0YArz+1Fl3aiL+UdKtZmzMPRGOnhffqoXzDgjgZeA3H3Ecn5FATJWqN3eEvKB84t1iAl2PNWlAa2yfpT2ruEp+1b8llculEzQ6rEj+1OcQAzOnU942jnulWmLEk0gpN7mdxHcmioSKcbA9xZIR7vffC65l5k50itjIwK0WYKqnrzRgCjrJ0atrv0pBzhwFg/SNZty4JrkJxCNVjGi97jD+E0y940lpUQLw1U5pcyn0sYNyeXC1BMeecupJjSU2kdQ+yuCyD0pcKYF7SBNN5d5TkpSudzF0WowRN9YuRr0tUU9j2v9CY8PfgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38100700002)(41300700001)(5660300002)(2906002)(36756003)(8676002)(316002)(4326008)(478600001)(53546011)(6666004)(6512007)(6506007)(2616005)(54906003)(86362001)(66476007)(31696002)(66556008)(26005)(66946007)(8936002)(44832011)(966005)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJQVGJBZHc2dlR0MGY2ZnNaZmMzRThYcTlmSXc1eHhWcCtNa2t6YjRvTXhL?=
 =?utf-8?B?cDUvcm9COVJTRnRVbm8wWGErSnFMaW52bWFKZWFTZXBPQUtPMndlazNCdk52?=
 =?utf-8?B?aUJ1QTRCMUNNMmU2WUVMQWpxWFBFaW9sZ1hGQ0ZOcXdSc2JpUmY0ZWNiSHc4?=
 =?utf-8?B?eFdWMVJjMzlCNG5hMFlRNnlVbGJEN3RVZW9PSHREZnNIb2NhYndibFM4SVVO?=
 =?utf-8?B?Z2tMQzFMVWQrWGRRdVZmOFFKV3FObUhPVllPMk9zcGRzWnp1ajJFczk2Q0tq?=
 =?utf-8?B?NThvMTBIVHd4SFdoVWllbkUwaWR4UHRKSDRPVzQ3alZEQ2paSitMUkRQWG40?=
 =?utf-8?B?Y003enV2c0RjdUlkanVyaHdsVTZQaGx0OTB1bU9CbkFQTFR6WFF6c0Y3UTE0?=
 =?utf-8?B?NWNrZ2RWY29UNSt5dGpVV1BweGw5aVNOa0JCRVlYS1JFQWptVG1leElubEZ1?=
 =?utf-8?B?UFZ2dlVIM0pNNXJIQ3BIWVliZExpQmx1SFlEeW8xR1U0TXh4N1dVM3RVWW44?=
 =?utf-8?B?bFU4SWxtV2RDc0thM1dSODFybG1WeTFhTHdnRCtUS05Rd3JlVDlMcWV5ZWU1?=
 =?utf-8?B?SW96ZHArL2NvN2pKTCtCbVR2Q3NOWXUvOUt5WXdnUEU1QUQxNmVZNktiVFlu?=
 =?utf-8?B?dVlWczFMZmdhNUhXcGY0NzhONU5KYjNZY2NpWklobVpGdmw3QVFNMURLbUla?=
 =?utf-8?B?TVJZMEEzS1d2Z2d5bkNQN2JyT2lxK09TQnhSUzdBazNZRHFCY21TM2luWFZP?=
 =?utf-8?B?WWJKOTR2cmNVeXJuR1lYbi95NzYza2hTUVFINXBORUtBMkpzc1V3MWd0cjdj?=
 =?utf-8?B?dUR1bDVvMEw5WUdtN3V6cDdyanQxaFJ5Z3BFV09aT3JGUW0rRk42Vm44dW4z?=
 =?utf-8?B?NFk3Q2kzck8zYnY0V2RSTWhucUtIZWFNTkNodStjTTNWNURlRi9TNVdEM1Jv?=
 =?utf-8?B?dEhhaTlaVC9xbXl0YmpwTDJGWHFYc2k1TVFKaStFamhQQ0IyK29BeUxhSi9y?=
 =?utf-8?B?Z1RJK2FURW4vTzVMWXNTcDY3cnZVWVBGV3ExVDdmSHQ2bXE4azFXdGc5SmJ5?=
 =?utf-8?B?R09wbGRVMzlIa1d2dzkrVkkreVY0bE0vaFBqeDVBWTJsRXp0NEhNdGJEb0hq?=
 =?utf-8?B?RmJJWUYxUnJRTkhvMlRJL2xXMldRWWRrVDRQenVwTFFtaGk5Mm5yQUJXMWVB?=
 =?utf-8?B?Z2hkemNEeVN4U0VSQmhvbEwwMm84TUxzTnJHaXNhN2pjVEIwN2JpSXgwR2FS?=
 =?utf-8?B?Y2VoTDlHeGozZlozU293V2JuSVBma2tNZCtpWmhtb2lna3J6UEdldlZ3ZGNZ?=
 =?utf-8?B?WGFzK0QxcGJpUlQ4bC9ZelYrYUNrVU90WnErcHFUOGUyUkNScHdXM0hsRS9F?=
 =?utf-8?B?cGRaYm1YWTd6cTM0ZXdtMzNWVlRTays0QUQrelNsUXhPcGdBdzJKUFVORWZZ?=
 =?utf-8?B?MHVDc3ZXbEZIOGxHaUtabm1pSE1QRFl3QjgvV1AxWFRmN3JCam45MU5wT1Qz?=
 =?utf-8?B?SGtlT1RIMU5iSXF1YXM0emQ2ZkZPTjNicHdITTdWbTFSbHZBWlRERjc4US96?=
 =?utf-8?B?Z3BXcE9WNnpDQS9LK0t3M1BMUXBqMEkrVlJmWVNSZy9wU3NoQjR4ZldHNTNP?=
 =?utf-8?B?bnNwZFdMTzc4ckdvRVgwTUpRZjFJRCtmQlExdVJvVlEwaUVFRjVreUd5dXRi?=
 =?utf-8?B?dUh3REg3T24wTTVVYllWNUJPYWxZVzhxMXVPSEdSSmQ5V1dlNWxMQisxMnhV?=
 =?utf-8?B?ZXR0QWJnM2gyV09hdzRzejFmVnJWekJMVDVtSFRkZzMyUXBOVlFxSGZTWHZv?=
 =?utf-8?B?UURiWlJtaStxY0hwdmNuTGdzODNvMzFKbzJnUlIzRTdaUTdFSGVNcmU2d0hk?=
 =?utf-8?B?T24zSHMvVUhuK0E0QW1CbXk4a0g4SE1HNUFNQnFLOG1WYVA2SklNbjRybk1O?=
 =?utf-8?B?cS8xS0QyaUx1dk1IejdKT21JMU5VZzhESjBPQUxFVkVaYkNQcyswTEtGTlBo?=
 =?utf-8?B?a29Gb21yaDA3OU45dFdqK29LVmFDUENvM0MyaG1WVVRBVlZHUitPSUFaS0RJ?=
 =?utf-8?B?REFzVEFaUXVvajBqRFdkSXM5Z2ROZHgrRUd1UElobDBNU1FEY2hOaVBZSUpy?=
 =?utf-8?Q?e6s8cnhTTSNa2aYSWWJk7wiaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bbf940-e714-4d2e-7c5a-08dbf732cc92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:42:55.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W2QsypRxIoVbE8X6tGIHHBvDOvEJyPJrMwEWdM2AWZ0o+QjGTEQITH1buFOrmnwhooLGk3yiC8sftOKONvb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

On 12/5/23 15:29, Mario Limonciello wrote:
> On 12/5/2023 14:17, Hamza Mahfooz wrote:
>> We currently don't support dirty rectangles on hardware rotated modes.
>> So, if a user is using hardware rotated modes with PSR-SU enabled,
>> use PSR-SU FFU for all rotated planes (including cursor planes).
>>
> 
> Here is the email for the original reporter to give an attribution tag.
> 
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
>> Cc: stable@vger.kernel.org
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
>>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>>   .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>>   4 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c146dc9cba92..79f8102d2601 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane 
>> *plane,
>>       bool bb_changed;
>>       bool fb_changed;
>>       u32 i = 0;
>> +
> 
> Looks like a spurious newline here.
> 
>>       *dirty_regions_changed = false;
>>       /*
>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane 
>> *plane,
>>       if (plane->type == DRM_PLANE_TYPE_CURSOR)
>>           return;
>> +    if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
>> +        goto ffu;
>> +
> 
> I noticed that the original report was specifically on 180°.  Since 
> you're also covering 90° and 270° with this check it sounds like it's 
> actually problematic on those too?

Ya it's problematic for 90 and 270 as well, though most mainstream
compositors don't use hardware rotation for those cases under any
circumstances. So, I doubt that many people would encounter this issue in
the wild for them.

> 
>>       num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>>       clips = drm_plane_get_damage_clips(new_plane_state);
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h 
>> b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>> index 9649934ea186..e2a3aa8812df 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>>       struct fixed31_32 v_scale_ratio;
>>       enum dc_rotation_angle rotation;
>>       bool mirror;
>> +    struct dc_stream_state *stream;
>>   };
>>   /* IPP related types */
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c 
>> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> index 139cf31d2e45..89c3bf0fe0c9 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>>       if (src_y_offset < 0)
>>           src_y_offset = 0;
>>       /* Save necessary cursor info x, y position. w, h is saved in 
>> attribute func. */
>> -    hubp->cur_rect.x = src_x_offset + param->viewport.x;
>> -    hubp->cur_rect.y = src_y_offset + param->viewport.y;
>> +    if (param->stream->link->psr_settings.psr_version >= 
>> DC_PSR_VERSION_SU_1 &&
>> +        param->rotation != ROTATION_ANGLE_0) {
> 
> Ditto on above about 90° and 270°.
> 
>> +        hubp->cur_rect.x = 0;
>> +        hubp->cur_rect.y = 0;
>> +        hubp->cur_rect.w = param->stream->timing.h_addressable;
>> +        hubp->cur_rect.h = param->stream->timing.v_addressable;
>> +    } else {
>> +        hubp->cur_rect.x = src_x_offset + param->viewport.x;
>> +        hubp->cur_rect.y = src_y_offset + param->viewport.y;
>> +    }
>>   }
>>   void hubp2_clk_cntl(struct hubp *hubp, bool enable)
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> index 2b8b8366538e..ce5613a76267 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx 
>> *pipe_ctx)
>>           .h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>>           .v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>>           .rotation = pipe_ctx->plane_state->rotation,
>> -        .mirror = pipe_ctx->plane_state->horizontal_mirror
>> +        .mirror = pipe_ctx->plane_state->horizontal_mirror,
>> +        .stream = pipe_ctx->stream
> 
> As a nit; I think it's worth leaving a harmless trailing ',' so that 
> there is less ping pong in the future when adding new members to a struct.
> 
>>       };
>>       bool pipe_split_on = false;
>>       bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
> 
-- 
Hamza


