Return-Path: <stable+bounces-4769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA1805F70
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E9C281F08
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503B69286;
	Tue,  5 Dec 2023 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uab3VGB9"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648CF181
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 12:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+m4Oq1UlaWhPdOuZMQlGymWvfdi5+Nwgj1I8d84RVCsYjWb69lD6bF7sueq6h8aAZaaZrB071P/79Wp86yTjypMX9+y3zVouupDKO8yqgJeHfiQG9P+eXRx+Q0Hyqou+wtS8U7pyzpevwpKd29U8CNXcnt/YeknX3dtf6c7eeDflx2ZKIURoPk/TQzqkWPNb3VmxzhWL7y2NkMehnH7LKhWH3aE++qkVg8SowMBlOost4y3m7YuIKOVadVPIf6nz5afyrZIn3A5b0J8nGIOT5SPQS6lb3JDx1OUrB47keSAngjFerNfTvXFSkECd5wOV+j/WVrUS2KTU5/32LYU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai8rZkfQ3iGzH43vJ5aGbGANGSlGG5naBjk0ztNVfYA=;
 b=kggwEZvFBnHxZBt9z4VFxNXSUr1zpHvTUCfdAWoWWfrBWWY0gHV68lQ51Qy119nNAaLNFMI26YJeABYpi+AU3WjaFNdrT4qaZWsoCwZ+RoTQ8IeqiVo+tsh3jNSDhKiHhU3Kvedk84F+EtGPOiDSSkonZbRN6eQ3i1fOJ2DZJ4wWavjor03jnk6McQfqdjUIv4q35pgLEaX5QiuQjmRy2KrYzBob2AcgS8AQLRzl64zs5jjYyZGVyL8FF4g5z9kMYEgX38a6+F9ad6BZzU46fhdEtK6BJrcwinBNVPUmPRP0NCN/17mXelBco19tmDtbPhzApLgGis8mlSEEEpcheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai8rZkfQ3iGzH43vJ5aGbGANGSlGG5naBjk0ztNVfYA=;
 b=uab3VGB94iBVhB/eu05E4qyVWo3ABSiNotX2BRCPItHmYyJZqg11U74n56GXnYKzEhFXohNo5RQrW3tnpRBaU0b+QJ9E7GJ/7rsZ89LN2vKW6z+Ur3gVC8nUnQqeITwKKuntbV2xRpCyhbi6d4ZFZkpr47zlJE0EY+9sdnifR1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:29:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 20:29:59 +0000
Message-ID: <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
Date: Tue, 5 Dec 2023 14:29:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231205201749.213912-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9438af-751c-4d72-27f1-08dbf5d0f3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LfTBy1N56NA2YqmzgoKdeLKG9xw4pXXgl79nJOrnWMxJYcF6lYCHMmPtbybOfeaHbglGLoA4UmlgwpMOPXDaiS3RR0SynVzbS+Kv2hLTJ+p2LyGDGZLT7B1anTBaaLZjCC+3UuzeZWhtOfbIIUjXs0PCigsfPa+Tm4NTIrhYVuZC6tbpwx/sx73yey0vnkuFeLbgQbqCSREoMpWPhOVDedtIoG23kqgh957Mqohcl4Absi5XBIFYY3JhvngbHQoqLwQR8e8K3v9YHOiMxWugnEt4aSkQgrKddoV//YzjnjB8ZJo2d97wHdKG2BO7Rafp3pcRkRoxJs8lKAeCjE2vKP2FQSYY2IRSFp8l1lGnDd2PlkSV53BC9nseMZC4/pEw/qk2dr4AErNTBIxuFud123u3oBttUK86tr3lOuvV1/nmyGgARsQ1s9Rki16IDxhWjjmpgZOqqbI/ISW6LoNLDh2M2KdJX2qjcnN6e1oOL1yGKFhb6B4jlTMh2Lf2hg6qGiE2wqGSPDtddh8oJ79MONyMQAMjD0WDSrXmH8raRskF0JXZEjl6MSNHRYauBx89rVxtZUhNlcUt2UbNwgQZ8z5wM1uf5Ms/vJzJabgPPwvyiJ2J4t1A/l9GuOvIsLf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(86362001)(44832011)(31696002)(5660300002)(2906002)(41300700001)(6512007)(53546011)(6506007)(26005)(2616005)(966005)(6486002)(478600001)(83380400001)(8936002)(8676002)(4326008)(316002)(66556008)(66476007)(54906003)(31686004)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3FQRlVDSTUwbm5ZU3kvdnNxNjdTeVlKVkhtTjdaaWE5MmtnUGpnL3pvai9s?=
 =?utf-8?B?bXlKNHNEdE9RMlZ3QkkzQUxKZEd3Z1o1OERoSThPdnk1K3ZOQlU4VVpEY3Fx?=
 =?utf-8?B?SytVcVdhV1Y3MlRnRXp5b2JmbEhQcjdoaEZIZWRTRGwwdDNudFdwazhnRVhE?=
 =?utf-8?B?WENET2ZwdnVYY2pBRFYwaUFocW95cThOazBSU2RXTHF6YlVQcUp1UTk0bzUv?=
 =?utf-8?B?YTZWdU5jK2FidExOdkhyL1o0N3g5OXJTZlN5OWNRL3pMZjUxMFFBUUdIcXdx?=
 =?utf-8?B?WnJXSmZvdE9sYTFXalJ6VHdVY0lpUUV0VUtwN3NBT1VFclBDdWl1Yll5ZVRX?=
 =?utf-8?B?UTVFRXdOWnJiZmc3MzU2eVBnM1dVN3MrTnVDekl5UkQ5Q05iUTRBc1RPRjll?=
 =?utf-8?B?UEc5Zk1sRitFZi9pNStkcDZPY3R2NktHUk11Y1RxbERWeDYzZ3M0eTFJSGta?=
 =?utf-8?B?bFJmSFlGWTVrSk4wYlFZRnk3Vk5vbE1FdzBIVHpTSURXMER6elVFODlsa0F0?=
 =?utf-8?B?ZkxaSlZTMUc2MEV2ME9rODVlZTJpVlN5cUhkVWNlV0J5L1BPb2JsVmhLRWlC?=
 =?utf-8?B?cEhFaGF1NlN4TE1sUzR0blpPUjNvQXd5NnBORnltYUpwdUZzdXNRdk1YNlBw?=
 =?utf-8?B?MjJxS2tpZ0xwWmNpU090SGgzRmg1M1o2UENobVpnVDVqY0c5ZlR2ZllYenB6?=
 =?utf-8?B?Mi83U0R4aXp0eUZweEQwbHJ5U1JoVG5pOFNXUzhaVXlzLzExS1l1MjVZRVpa?=
 =?utf-8?B?aElBYmswR0U1Z21ROEQ3M1A5WWgrSHFwTENtdDZFUjl1enc4UFdiaW5XZEow?=
 =?utf-8?B?R1JQL2cvRk95d0pGRFdUYnpWL0c1TDlESmNYWVBCSTFkSmg3WTRCaG1wa204?=
 =?utf-8?B?eStJUWd0c0tLa2pLZy9JV25wbmtQUjZiT1RneXlmRzJJYWgyb3c0LytKTnRH?=
 =?utf-8?B?TDMwRCtSK1ovbXlvbjNHUUhXUDdiZTZsL29rRDAwRVR3bFZ6dXVKbk9TZi9r?=
 =?utf-8?B?OUs4TGNIRmdxemxpeEIrRnlEVEErc2NwVWUzT2llMmoyamFaQysrbWNwVUJv?=
 =?utf-8?B?amZPR1JVRmtlTGcvcXZWdGI4UVlndG9NL0hzSXNYODg2N1NjK3ZCSURaWmNW?=
 =?utf-8?B?WGorZElsVXRYc2wxcFB4Mm5IdWxuR3VLeWkwQmFWMUErbTYvRVd0eE0rTUsx?=
 =?utf-8?B?aXpXWkFJR0pmaU4yVGYxTEZpRjFjNU5YM0J5cTZqTnJMUDBwK2VkVW55eCs2?=
 =?utf-8?B?NDRZcG9teXJ0dFJWRWlXL2NpVGIydWZtSHI5ZStvaXkrSzVnK1VZdjVKWXBi?=
 =?utf-8?B?ajM1V1RadUJGQkNkMUdJdXlMN2wzekp2TGROcEdMZzBrNjBpWjhEb2RSYzYx?=
 =?utf-8?B?b0lIajBSMHlNVU82UEpkeWJPNVhjTjhVZXhyc3p3RGJ5ang2T0VxcHRDSHI0?=
 =?utf-8?B?bjFYR0dqdzhtZnNTQTV3ZDF6U0dGSUlRZy9PUEJ0MkNhSHMyZXZZMjJyU255?=
 =?utf-8?B?eUtYaXllcHV2dWxITDlRWTFmb2gzUktSZGpaWEVXZGppdEVrVkNQS242RWNk?=
 =?utf-8?B?WVFzQ2h2djlHWGNkQ3Rtd0pTRjR2R3oxOHRPMk9GbEVuZEVkTzRwVU5YKzlk?=
 =?utf-8?B?ZnhQMVNNbkJhRTBVRnVzVFp3K2IweWpyZkRJSnZvaHJYV2h3M1ZLbkc1TGxL?=
 =?utf-8?B?eUV0RklSQys1L1pKRFkwb3N0ajRKcC9IY0M1NWpzZ3d1Y0ozR0hlQWNTd0hx?=
 =?utf-8?B?MFp4M1YrZ2ZPRXQ1amFLbnd6SldxYklsU2k1ZDI2dFlKZ0JXQkt3aWxxWU5W?=
 =?utf-8?B?TDNEeEdraExVN2RFS3A5UWY3YSt3NlNkemFaVG1ZSjFhbHpBMEF0WHdCQVlz?=
 =?utf-8?B?aVhualdDR28rS3B3VHZ5Q0xTL09LeFFaa0R3Z1AxbGNTQWxYSjBoYXFlOERO?=
 =?utf-8?B?ZkEvN2xpbkwvcThFRlU4M0pHRnRDbjRFdHZaQXVkNFA0WHBUMzNXakI3aDlF?=
 =?utf-8?B?UVczWC9jSThtdVEzcWcrblMreVdHMDdER29jRWs2bU5jcmdTQVJWMzZtMlF2?=
 =?utf-8?B?RUtYTmlLR24yWVBGeUVUS080VCtYYW9lQkpadllCbENPT3g5SmtyVE8vRWZi?=
 =?utf-8?Q?ji/HcjXvSmD9gkq5EkbDpu649?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9438af-751c-4d72-27f1-08dbf5d0f3ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:29:59.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W82WjeZiVfmnyagKrH2hem+44U38snQ/slut29MnktKJA/qarkUbITL5bTEoxeyqKC4y4Y+dmTDwebGU400IgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

On 12/5/2023 14:17, Hamza Mahfooz wrote:
> We currently don't support dirty rectangles on hardware rotated modes.
> So, if a user is using hardware rotated modes with PSR-SU enabled,
> use PSR-SU FFU for all rotated planes (including cursor planes).
> 

Here is the email for the original reporter to give an attribution tag.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>   .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>   4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c146dc9cba92..79f8102d2601 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   	bool bb_changed;
>   	bool fb_changed;
>   	u32 i = 0;
> +

Looks like a spurious newline here.

>   	*dirty_regions_changed = false;
>   
>   	/*
> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   	if (plane->type == DRM_PLANE_TYPE_CURSOR)
>   		return;
>   
> +	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
> +		goto ffu;
> +

I noticed that the original report was specifically on 180°.  Since 
you're also covering 90° and 270° with this check it sounds like it's 
actually problematic on those too?

>   	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
>   	clips = drm_plane_get_damage_clips(new_plane_state);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> index 9649934ea186..e2a3aa8812df 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
>   	struct fixed31_32 v_scale_ratio;
>   	enum dc_rotation_angle rotation;
>   	bool mirror;
> +	struct dc_stream_state *stream;
>   };
>   
>   /* IPP related types */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> index 139cf31d2e45..89c3bf0fe0c9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
>   	if (src_y_offset < 0)
>   		src_y_offset = 0;
>   	/* Save necessary cursor info x, y position. w, h is saved in attribute func. */
> -	hubp->cur_rect.x = src_x_offset + param->viewport.x;
> -	hubp->cur_rect.y = src_y_offset + param->viewport.y;
> +	if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
> +	    param->rotation != ROTATION_ANGLE_0) {

Ditto on above about 90° and 270°.

> +		hubp->cur_rect.x = 0;
> +		hubp->cur_rect.y = 0;
> +		hubp->cur_rect.w = param->stream->timing.h_addressable;
> +		hubp->cur_rect.h = param->stream->timing.v_addressable;
> +	} else {
> +		hubp->cur_rect.x = src_x_offset + param->viewport.x;
> +		hubp->cur_rect.y = src_y_offset + param->viewport.y;
> +	}
>   }
>   
>   void hubp2_clk_cntl(struct hubp *hubp, bool enable)
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 2b8b8366538e..ce5613a76267 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>   		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>   		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>   		.rotation = pipe_ctx->plane_state->rotation,
> -		.mirror = pipe_ctx->plane_state->horizontal_mirror
> +		.mirror = pipe_ctx->plane_state->horizontal_mirror,
> +		.stream = pipe_ctx->stream

As a nit; I think it's worth leaving a harmless trailing ',' so that 
there is less ping pong in the future when adding new members to a struct.

>   	};
>   	bool pipe_split_on = false;
>   	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||


