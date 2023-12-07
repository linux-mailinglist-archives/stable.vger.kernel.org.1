Return-Path: <stable+bounces-4929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF25808B34
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC14328345C
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15F44378;
	Thu,  7 Dec 2023 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="By0pUFnh"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B112128
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 06:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW9t9VKDivqwvjPotA2hlsz14YEedSSNrlrmM74pRYkPZox4wkfqurxJwqfqGcObbu+oH7HsyiF/d1f5VIEE2OuyKCv+gau9EWPcxmjzB1Tf7RfQ+JsQO6D3dAwZFiw9/7e7QYP62/P/ZA+79BlASVhrQDezHgngpdmSsqMa14AydaFH7qHhidFCMQZbe2hJoaIflEdcvUIaXqbLhx9HFu8r05F9YWD9uM+u0Q5MN9NYuevJXgHTcaA/xSkOO2oHWt3Qh0ABtmUA4DYu4SsmnDNfKEEwtuVc5FO3TdpQxaxnxAcm6WvTqXFekghncBhomAVhmeJt5LSlsZcPf/ZV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiFg0Ry24a3q5mL1ZehG1ar4JfKtGSr35Ak5sypKK+c=;
 b=EKUzoNwmHHYTc8MQHjg1WBGGAD3KEiVGE95GbOLDdaqBrUgxb8A+/fkdsuV8h9TaS1ZfdIulHV76OdvZqrMNOeARc01AX1X4P5EmckGcInehX/6aOXhN+8yr6m5UmR+/qLhEvleaJ90BB/uk6LsnKEU4tj5E/BjunJrLXGUc1w55ps73gPfEuT1IgvAG3xQJQcBMhgor70Sqif1XhVJgzeVwGw2dkaW4tsp/gTc2pSzl+AkFpuncDm1+CDWV5lUHy5XxX8PbfCKMs8YqV3I2kuiZlS2dAFR+vrqkyeYjG+ToxF5Z1G5x418cT7qdHZq6Oj1DM8OnuEWXe7ziI6QLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiFg0Ry24a3q5mL1ZehG1ar4JfKtGSr35Ak5sypKK+c=;
 b=By0pUFnhkbi+NSOER2S+Ny+c7ax1eCHMfV+X79kPvO60UcuUW8oqmYEWnmw+vSeDTgZSryXWRDF40jkB6E26eSoOVMvFboJxDUamuhXFQTayl42cT6pBxwzf9/EnEzK05N+J30AiApAFaKRi2qKexm0HIXaEi/BCU2zK4Fdo1TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 14:57:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 14:57:40 +0000
Message-ID: <f11b3b38-16ef-494b-a87c-20ac611bb751@amd.com>
Date: Thu, 7 Dec 2023 08:57:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Alex Hung <alex.hung@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, stable@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Bin Li <binli@gnome.org>
References: <20231207145144.7961-1-hamza.mahfooz@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231207145144.7961-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 964923eb-7104-49da-e296-08dbf734dbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXn2FYfmT89Lv47B2naT/lAGIVrVGsZx1jzJboycVa3K+JMMvumg7rEbjWbLNbn4t35x4AtgN8bGseyTwhsRLxKb3Xa/DXs6P4tz5L4RaObQuOOlhcO/H9CHODKl64nbiPiIjvEOVmBsQSjxmf9aQU4G0rQddX2IjZH6O+MpcCP8b2GJlUs0uWLwVlU9OKGPoxdks3NBZ92ktq04H1af433OXJahDmoF2mFX/Mo3O5fOtfKwNOZal7y+lcm8akbv106pMt45q1gDkwwT5NMObGF2Ad6AWfYGDYvqpeCUf2RFt9qFpF6MH7J1qePo9pARdk14qPePeFPkPUa8wuVRDUGQ4wsKdQ3UPvYzRy3VY5zfEdfj9ywL5JbQp6TEacRKLYMwuI7VatGMruDyFLKqccXWCO1j16B0/d9HX8WSKhBFuS0z6xqrrG51+xri4PjKiLcL+oJ5uS5SnW1nP6ZXMMC3q2k088JMNDLm0Q3akGVQEEhme+enWqJDCNDXsffiARLzFhbXAsCONgIPrs7KrVWCJeiRqkZBVjpGOeA0Cdck0+jsjuOj+ZxzpJkBBHlJn097JasMklSgcU4XYDgl9A+A0OQQ5/b/7ShUcZ3h7qGnHpmgvgvi7fZEvSqeNX9D8RBvrALIcqdRUVw4tZs6jA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(5660300002)(2906002)(36756003)(44832011)(53546011)(6506007)(6512007)(26005)(2616005)(478600001)(6486002)(83380400001)(966005)(6666004)(8936002)(8676002)(86362001)(4326008)(31686004)(31696002)(54906003)(66556008)(66946007)(66476007)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0twa3JDUkg2SGtLV0ZmOWxidEVCbDlWKzZKeWxBZTFkM3pISy95citmZmdI?=
 =?utf-8?B?aEhQWWpQL1pPZDhCdmJVdkNKckNLaHlNNU9HaU9zTmpEMzhsWG0wMkVBT2Vm?=
 =?utf-8?B?Tm9CRUM0Zy9pdjhjMnIyNzZzVEdkMFExZi9wMWVBanJQTGVRNzBBUWtrNC9t?=
 =?utf-8?B?NEJhczJ1TTNub2xuclRaaWJ1Wk02VDd1Mlc0QUhoTlVnWTE4OG1YTmJtOGsz?=
 =?utf-8?B?RHNLREllMHhtOVJCYmIzYnhTeWFwaTlTM1ZmbnZ1ZnNQRGtpaXNBSDhUVTJq?=
 =?utf-8?B?c2swWlZhVllzL0ZTWFdodUIxYk1OZkdiTk00UXM0ZUh3dVNCclowamw1NkR2?=
 =?utf-8?B?TDA1ekx6M01UK1k1enkzR2pnd0tOaURLWCtOdjZyR09lUkdxRXk5RmVGMzYy?=
 =?utf-8?B?d3Z0YUNDWUxQNGFEQmRFcXB3MVl0RW1YMklESDBINGZnMGNYL2ttSmFyVWhI?=
 =?utf-8?B?Nkc4N0M4Z0cwWFpTdHVVSWFsQlNKZXJ0M3RvVXdmN2N3OGh6cHp5NW1YOExM?=
 =?utf-8?B?b2w5Q3FuZWJoWC9weG4rQTlyVGltei9JR2J4ajU1RVB3N1dYa1dETkVwWnMv?=
 =?utf-8?B?cm9KQXN6L0lSeU9VMVVyU0p3blpXdzFwckdKNXZ2OVFydzhZUUpaSEhTSTZv?=
 =?utf-8?B?T0ZYcDJFRFRkZVJ5TEh6Mmk1YUx2OVI2Y2JhUkMxSkNVc2NiMld2NVdUdUJH?=
 =?utf-8?B?S09iRUQrMnBTL1VFVGFVdWVpMWFGbURUWHpmaGZ2OERIaHhKMUh2RFBnTzNV?=
 =?utf-8?B?NkhjTkFLVFVHaUlsdmZSb0UrNTJRamp5bWVGTWhVellVR1VFYVJYbS9QQkhZ?=
 =?utf-8?B?QnR0NGJLZG9taCtBaDhHYWpaWkpaUEtsYjBhTWtNRThsQjE3bjBwR2FkcVYx?=
 =?utf-8?B?Rlk0Um1vc2lTUHNZYjR4S3h2U0NUUWZBNFhlYVVpSUZ2dkdOSCtCRE1mbjdy?=
 =?utf-8?B?QmVjd21zYmNUczZ1dVZPb0J2S1ZPZmVyd2x1Y2NDMVlGOGNlRnQxU3YwWlB1?=
 =?utf-8?B?cnNweDIwTkRvbFVNR1BUU3pwODdOMHFhU3ZNZ3p1c3l5Kyt1WEk5SGRienQ1?=
 =?utf-8?B?bi9TZW8yb0ZBYStneFYyNk9LTEdnZ1ViUkw2SUlOc3NxeWVmNTBUMnJjWmFs?=
 =?utf-8?B?UTBKY0FCZVlmd1oyT205QWZQZmpicnNHQmtFMHFhaGhISld0bmpoK2tTWFJs?=
 =?utf-8?B?MitPNWFYWXBsVXNPT3M5M3pGMWhmVDRidmdFdGp0V2txc1ZLTFVnOFNsbFRN?=
 =?utf-8?B?ejRxQkptcVByYkh0UGhhRFNZNUh1S2JreisrZ1BRbkFrYUlhRWM0UXVKTHcz?=
 =?utf-8?B?aGFwWlduU0xPVXFiMFVLanRBVng4Mkk3enZkaS9VeWRCeGZPZCs1WHJKSXpL?=
 =?utf-8?B?MjJWV1hQczNXTmFkZkt5VWsrd0Q2WWNKV0RXLzZ6QkM0Wkt6UXN3dzc0QU43?=
 =?utf-8?B?bnNLd0lKQXRVblBrWGkxd1VwSklEU0h4dGxueWJpc1BaSFZIUzdTazZDNmtx?=
 =?utf-8?B?Vnp1dEFSVXRQaTlDQXErNlVQK2k4aFlzRkxuYkxHZmxHaEtEME5kbWZIT3Nx?=
 =?utf-8?B?U3FhRnhPc0ZITWFTQmdSUERtVFJ5ckd5QjNuODBsOWR1NlhXZzhmc0wwaEZZ?=
 =?utf-8?B?NUdWSUd2dnhkY0FOOUNnYlFxVFFzaXhVMVErOEJ5bk9PVC9aNXN6YTBVSXRq?=
 =?utf-8?B?RGd2bFN1OEJrMHkvZk5lamF3TW5vM0JUMURQd0U5bHBOUEpYY2FhRG15c1dO?=
 =?utf-8?B?OXR0MFdoNUpDUWNXWUVTNmg5YjFsdEJWMDY2K09jTEhWZDBUSEJ1R3RjT1Yw?=
 =?utf-8?B?OUw4bUVvcmxLRHhqeTJWQ2pKT1hscW55MDloT3RFbC8zU2RyYisvNlh6UWJ4?=
 =?utf-8?B?WE1xQnIyb1l3ZFEvWFBDUCtUZ2Fsdm1XRE5zYTlUdGJ4emd6TmVGdS92dlRS?=
 =?utf-8?B?c1gzQXc2UExZYk1vUXMzcW5EOUYwTE5QaXpSL1YzNW94TmdjeFZVdVNRU0RW?=
 =?utf-8?B?azJGRzFkWFZldmljMk40ZzhWYWlPdHcrS0hUNU5IUDhDZEF5SUs0R3BQdDRq?=
 =?utf-8?B?RUR4TlBiR0s5RjloZjFpeU4yWVFuaEhCc29zTkJ6NHNTbnB5TDRtc09iNkRp?=
 =?utf-8?Q?7xn1bqzrssENxr6lJUfcqME+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964923eb-7104-49da-e296-08dbf734dbbc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:57:40.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fveuFSXJzTlN7m9gDuexoHScYMuBvXSE30M4lEslzF8jkRdoNMqQ6aOwqO5q1tBO+yhUpv6DjU7Qvpi1pTejrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

On 12/7/2023 08:51, Hamza Mahfooz wrote:
> We currently don't support dirty rectangles on hardware rotated modes.
> So, if a user is using hardware rotated modes with PSR-SU enabled,
> use PSR-SU FFU for all rotated planes (including cursor planes).
> 
> Cc: stable@vger.kernel.org
> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Bin Li <binli@gnome.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2: fix style issues and add tags
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
>   drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
>   .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
>   4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c146dc9cba92..3cd1d6a8fbdf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5217,6 +5217,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   	if (plane->type == DRM_PLANE_TYPE_CURSOR)
>   		return;
>   
> +	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
> +		goto ffu;
> +
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
> index 2b8b8366538e..cdb903116eb7 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>   		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
>   		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
>   		.rotation = pipe_ctx->plane_state->rotation,
> -		.mirror = pipe_ctx->plane_state->horizontal_mirror
> +		.mirror = pipe_ctx->plane_state->horizontal_mirror,
> +		.stream = pipe_ctx->stream,
>   	};
>   	bool pipe_split_on = false;
>   	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||


