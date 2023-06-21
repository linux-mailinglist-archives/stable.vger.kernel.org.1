Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7539739296
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFUWez (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUWey (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 18:34:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B0210E
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 15:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWGx4tZQiyi1Txuj+8rdpwdAsbEEGtcf8MVgxtlgASZelv/rIjv6Arz3w4P35b9F53wIhB8bRvkgYSNNFk5Lw9XAdgmpGd44e4uo5N4UgtOZB0cAzdDdsF5FfPDNwdmztixyl+5WgaPehAECNqznF0DkTO/C8Smx1yk+rJ0HAH4O355UxCh4quoqB666m+3PSwizF1EmtofFUY04tNiAr6mMU6q8Fswk6TaXjfD622nCLeq4OhY2yCvHVDTmBQPRectfUfqzXnlEfmjwxx8jv9gesGhQvHTtvuzuVLOtY2psIyYye9CBwY96EzDR7Z+qC40Kk94A+GO6yaKtQHBL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAjbEeLw6F9xM3DgGIWX/G78DBwjQcfRkRnWYF1v0dg=;
 b=EZPwbd3x20M3ynZKX9YnJbJmDQTYwofAE1Fppl6+CiX+s7y+anOKlg8XEWiXiJ1Vha4UUpNAybLYMvKQbAw9qV/A2H96Nni+Q7sxlvGbwN/BazW11p1MwNF7CqvngQoDUf89epGzCTFea7BpNqn4vkHxnbf0qpHWBfJYGLKLmuKWZ+6UmjfJK2EMLcG8hOB9mGrv5wA+qIPvTac9MHBU2LbeKd6gGm5BE9R4XKSZsJjf4oWqIv3mR4fP4Utmrfg8U81RnvsYrfLUE2czIsyhh3qYrtstC7oWfvv9ApSJ/t0MX+3ZiRdNidUZEucWxIbAaKG4FBDkG2pEZuywx216Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAjbEeLw6F9xM3DgGIWX/G78DBwjQcfRkRnWYF1v0dg=;
 b=ycn07+hyD0llB6N973UBCLqpXovXDjFNDs2snH5BweAdmIuL/yL/Lii4CJhQvwwl8YnzrHiH0MT0daUxFcFYkEcDe1Ml4fDva5DPkAVYh50IRPtm/yrivJrc8Zz//KLNlJuVKOXMfBBXD47zUtTVzfMIDY4qXGZvQDN+DUd6NKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 22:33:48 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 22:33:46 +0000
Message-ID: <4493f01f-ab2e-8a7d-e93a-9a84c3955d4b@amd.com>
Date:   Wed, 21 Jun 2023 18:33:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: perform a bounds check before filling
 dirty rectangles
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
References: <20230621215711.133803-1-hamza.mahfooz@amd.com>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230621215711.133803-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::9) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d5aee1-e620-45e3-2d4b-08db72a79366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4q47CTm0S8W2MNEGk6Uh+EMV8J+z3BNcoRJpA1vpUupIU/0lAaZmpuE5bveZ9iOUSz05LShs/xhMklEMHHJs1I+qXoFd5trBOHm6k43gw2hl0YM/TOA2pHRVP5brex8S7gGQkQGjsNbFyYOdNwMKPnI7IvW5mAW1sir0sKlB21jDwiRMOPlt7KzA81K2VvM8mGOg6o8btDGLX5dx/QGiKjkD0LvkBCFVeO5rqGsRN3NqddZ+kIjfr/4KUQ5Pv3R3cjG8yMKjDpPbfztAQFrNzDP1izq9gByTYuuj7umn0uotfMTOfFkJO735Mxygyrjp47pM7Nxjd4FrYo0hzsb1YbzHU4IcRHb/sQdn94w85wOaNMBPsVh8Po7W4Dt/uJWZfmq0K562CQol8BJPexr5Lfe7xHtGN0bqe6lC5ASH0rQ3GDcWIqym+5evU2wdPEdjOOnYFpsC8Rmd7ojGGz1xdFrso+cg5KPBAfQ3FOGTsxQ1PeroqZhPZopC90H177ULYRrRaWcxWfGS+/ALwuswb0qkeP7L+L1xglA5egaMbQOnHMaXXL3kNRUZabtJy+TqYzkM3gsQzWVtXxHqQiFiaYam53MGLmnvjf+Xucom83hPkweWBfPQf7BeB4kSVob/HdRZAJWq7mLG/2nMqc9yDNZhw2mxk8IugYWnSiOIqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(2906002)(5660300002)(41300700001)(8936002)(36756003)(8676002)(31696002)(86362001)(53546011)(478600001)(6512007)(6506007)(26005)(186003)(54906003)(6666004)(6486002)(66946007)(66556008)(66476007)(4326008)(2616005)(38100700002)(31686004)(316002)(83380400001)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFWZWpDZTA2YTJlVjRURGthajNFZkszT2pIS2tQclQxeWlKQ1Y2SGFGekh2?=
 =?utf-8?B?eEp1TGlhOWlrMUxXcUxqWDVmUUp6aUpQaTluUFV2Qm8rUEtlMk1hSTB0NmNZ?=
 =?utf-8?B?NkE1Y3ZKZ2JIMmtLNThDQUs0WWxacCtiWURhOWZrR0h2MFdaU216SFhudTN4?=
 =?utf-8?B?ZzV4UkZuNlBWeGlUcXhnR252NnZqbFdnTXcrVEFOQklmTlRiZFEvWUM5aWpR?=
 =?utf-8?B?QTlvSllGOXNlRTZKVUdNazVJcUE1U25mYTNlUFdvd2xueXFaVkxWV09LVFhF?=
 =?utf-8?B?QUtPVFZ5dE9YSSszbm9FSnlyR3JHS2d2SndGNlNjSTFtTENMY3dWMTVERm82?=
 =?utf-8?B?Q2JvVHFTanFsbEk4Mk9aZkE5VE5vanBCMkxISmNaQ0lzT1lwR0FRdDVid0xr?=
 =?utf-8?B?WVpSNVR1WWlPdzR2QVBOOUwrNWlUSEVSQUtVUFEwL1JwZC9kK011MDk4Y3JV?=
 =?utf-8?B?M2FZSk9iQTh2Si9IVmkxbmV1MyttUDREcUFEVVh1M3V6T3lzZWNLUnNQQlRP?=
 =?utf-8?B?NHBiYWRTRXBTZVlpWFNlM2wwVWt1d3UxLzNQRmQ0Q2dIQXMvbjdKaURIVlIy?=
 =?utf-8?B?TFNBWDIrNWlpdDF2SnVrWjIxMWl5L2NLc0F5N2VEMGFhZmI0clFSYzBlT3Vo?=
 =?utf-8?B?b29DbE1TTVdKc0grOVZzQ0lPdE5Iajd5UjZBaE9CaS9wdlRjZ1MwdmFoM093?=
 =?utf-8?B?dm1tSGl4UzZXRTJldGFXTXh4V09XOVlyQnlYMGVpYU44OGdnYWZ3REZoV1dm?=
 =?utf-8?B?WnNFOEc3a01hVXpQa0NSM3pLb0haYS9telU0TUVmTUNKd2pieUdCYk1md3hQ?=
 =?utf-8?B?cm94bXZTcERpdmErdmI5VUh0UFE1UWtiMTRLS3dmS2NKaEYrMzVneUN4M3M2?=
 =?utf-8?B?UzY0UEd3UzZzUVFvcFRXaHNjdVc0VnduRzQ2T3hHcmdvOWEvRVNRZDhzVndD?=
 =?utf-8?B?aWp4VzU4SHVSdFVteXVBZ2hiS2NmbXNrMWNucVJGaDA2Y3lSNWdRNS84a1pE?=
 =?utf-8?B?QU1SV2dTOFlEbFF6YisweURteW1Zd1o2ZjdwTjJkRUYwTDQ0OFVnZS81Ly9D?=
 =?utf-8?B?RlM5ZCthY3NBbnpDTFFxUEtWYzZ1QzUxUEEwTXdreEpKbHhVbmY2VzVIaUNI?=
 =?utf-8?B?QzJBOFV2d1RUSjN0d3lNUnRiaDV3dUY4a1JpNkZ6Q3FLbnVKcy9TekRwYnRm?=
 =?utf-8?B?OEpOUURjWHdFQllDT0F4SG1BRFZDQS9nSTU2UkllNU1CNzlBaHFkYUFRQ0Ny?=
 =?utf-8?B?TURCUFJUWlJqdS83TjVURUdYZU9sWUlFWm45NEdmN0RueXNoc002SDlhNi9u?=
 =?utf-8?B?bGZDNnhEb0xLc1FRLzVSOTN6VldwR2E1Y3ZPZnc4cEhaR3prL3ZBcmd0TWpF?=
 =?utf-8?B?NzMvWXpFV0M5VWprQUV5aFZEM2hRQWpNNmF2a2kvQkIyc3o2djVadTVaZ0Z1?=
 =?utf-8?B?RTIrUE01OUhsTFo1T3ZhQ1NDQU5ZM0JsVVh3T215dG5nS1JXYWpaeDJMODdw?=
 =?utf-8?B?a2JFYjZyYWE0RHR4YXZRVDN0TVZ5R0tRQ3NXMGFpM0FjUE1oZUo4S0UvM3hy?=
 =?utf-8?B?N3lOY3dBNWxEK1pxMWhCajVpUmxoT1NtUmVBdVVEaWVWT2dWemVUUEk3dlln?=
 =?utf-8?B?TDFCY2JLWXVIQ0hPU1h4b1MzZkJpNGNKVTQ2dDRXKzhLck9vWkRqZlZ4RXIr?=
 =?utf-8?B?QlFrYU9hTlc1UnduWVlWRXhCME5JWTQydDl0c3hkWThpTzROQythSWNCY2VF?=
 =?utf-8?B?QzRvVXA5TW5oNXg5ZTVYaXFJVXp4OHZNd254VTN6VkJsb0tac1dBdWxLOUc0?=
 =?utf-8?B?YUk4OHI1cFFtSlhBOEx6eElPbGEvaU5YemdlNzNNTkNsb2l3WG5sdFd0SkZD?=
 =?utf-8?B?b0pIaTZ3dVFON2wvNmZ1U0dvaTltUVpXWHdLQU1WZUFYRDlqRXFiaHRDZHF2?=
 =?utf-8?B?K2pyZ3ZoNUtiUVJEcFkrdVBTcDUwWUlzSWFYN2xKR3U5a3NNMWM5WFpaci83?=
 =?utf-8?B?RmNnMVVZdEUvWXFtV0VjVUVIYm5xSUZ6NHUwRy9rd0NZNndsVHFhMC9JSlJH?=
 =?utf-8?B?d001czg2SjFxTVZtYk8vcjduNHo3N3NYQ1B3czNhVDNZNnZxSUxHRithekF4?=
 =?utf-8?Q?B8FR/K4ZZoV94/YfV8jvD3l3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d5aee1-e620-45e3-2d4b-08db72a79366
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:33:46.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud6uy609vWtUS9aTFshK/+7P2D+rpELD+h2JLb5oI8tQ2sAVH3eYMP5TL67y8IGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 6/21/23 17:57, Hamza Mahfooz wrote:
> Currently, it is possible for us to access memory that we shouldn't.
> Since, we acquire (possibly dangling) pointers to dirty rectangles
> before doing a bounds check to make sure we can actually accommodate the
> number of dirty rectangles userspace has requested to fill. This issue
> is especially evident if a compositor requests both MPO and damage clips
> at the same time, in which case I have observed a soft-hang. So, to
> avoid this issue, perform the bounds check before filling a single dirty
> rectangle and WARN() about it, if it is ever attempted in
> fill_dc_dirty_rect().
> 
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 64b8dcf8dbda..66bb03d503ea 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5065,11 +5065,7 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
>   				      s32 y, s32 width, s32 height,
>   				      int *i, bool ffu)
>   {
> -	if (*i > DC_MAX_DIRTY_RECTS)
> -		return;
> -
> -	if (*i == DC_MAX_DIRTY_RECTS)
> -		goto out;
> +	WARN_ON(*i >= DC_MAX_DIRTY_RECTS);
>   
>   	dirty_rect->x = x;
>   	dirty_rect->y = y;
> @@ -5085,7 +5081,6 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
>   			"[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)",
>   			plane->base.id, x, y, width, height);
>   
> -out:
>   	(*i)++;
>   }
>   
> @@ -5172,6 +5167,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   
>   	*dirty_regions_changed = bb_changed;
>   
> +	if ((num_clips + (bb_changed ? 2 : 0)) > DC_MAX_DIRTY_RECTS)
> +		goto ffu;
> +
>   	if (bb_changed) {
>   		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
>   				   new_plane_state->crtc_x,
> @@ -5201,9 +5199,6 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>   				   new_plane_state->crtc_h, &i, false);
>   	}
>   
> -	if (i > DC_MAX_DIRTY_RECTS)
> -		goto ffu;
> -
>   	flip_addrs->dirty_rect_count = i;
>   	return;
>   
