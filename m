Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8074D321
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjGJKRI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjGJKQx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 06:16:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51EE79
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 03:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGvkFuFgiV8CV3St4a4U1qguuEj0xHNcqTpYBVuGnc+dYn7L61hJiq5x5a417t/0oX6x+u/T7TtiudDabe3QKh+0IEMNVBcHfS+DXneE5vl8UpiPtyExONocA9mjLpEXvH9X6ckSDR66VYn3Jf+HXNg7KUFwWS342HTI7+0khicoZ8SEO0cdEGksMb1WGpbG2e6TlNL20M3G77X2uLOiNF1mS34FDdl5LsfGJmrvyRAZ5YnBY3sFGEBtCzNBFeHO5lS9wNW4fhs16ErDBgsBbzrO4z5iihKLtFkojU7c1+aKw4Omh2fvXz8dJyxdLdFceN1mPbOCFpwIhvO4hrWk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RybCK6969t055K2lYAWTZ12fsRiHPokV6Yt4/GVJZqU=;
 b=WOyaRvouww/w1imY7ztwfTwhCpMQTaEHPyjAaNu4tKgZAeU2w+uZPee/eMYra1fSI18XhuisdYS3pcBuGnixVMlFMKyge6BFiqXhKZWsvCiMHFeSmEzwpVCDp/7uQPWUrjJaJ4gttjduaXSJkClApcdOaDkaNYQhrJYSqurm9YdDQ2mtX0xjh8ZJmSFhdoQvLEVuLHuKycIRSPEqSvkYPgRSlOO1iVBSWRgNvwmo4IQ0ZlKnQpfgjpYpQ4RZKqRqGpwwTWK5tkVN4gcJ6amOk2Q4xCdIcmJy+EaJqAU1LQB3JziZLAKhC+fBvLaGJW0Imn3w+aFfpUbwg27tXXyw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RybCK6969t055K2lYAWTZ12fsRiHPokV6Yt4/GVJZqU=;
 b=Mt94GlXF7RkniaHZ11LiNaQMUryQbIiqXqPrgHX1XYZPPrlH/H/8/fZnmkjW3pskH2wD9VwLYU+MNodApKtWv/IJ9FvobHlEe/LMXw2gf7IqJZONQEHTM4wWIAmolzYuicnUACCPv7A401G+AJRIol5YA4Te5I1efkywc+e6AKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:16:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:16:19 +0000
Message-ID: <0f034282-240d-684b-6677-a351e98d557e@amd.com>
Date:   Mon, 10 Jul 2023 12:16:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Content-Language: en-US
To:     Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, hawking.zhang@amd.com,
        dusica.milinkovic@amd.com, nikola.prica@amd.com, flora.cui@amd.com
Cc:     stable@vger.kernel.org
References: <20230710063808.1684914-1-guchun.chen@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230710063808.1684914-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eafa7f-dae5-4f26-3f58-08db812eb3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3c6v839c4m0DutLTA8h7at3Q6o6XMXyNlg3iKdpC/4GovKwpwC03DOjM6yI3XWM0S+BlsZHa+v+lxs/pfgoz8PUsLaKoy6p+kbxYBOQtpLT5RK+GP5HURRjgOoUe4+RvvufQh9ZL1JXY7DE+zDehm1T1+O3MNGJEAXF4aq4A7BmTCP7IbWbsa892Oz/kZcVVyB8+oypn6EVInkAlYxLevF/lGIjgy1I3ZmnQJubYgrpBxyZfeYNDf9upejBZlM45vplVYljqHyIVSnWzt1O/L0ahWxji3zMOzCthIWmhmWnC7z7NKzWOuDAZ/s84Ffb1pXGj8sENRFfh27w7uu1KneVDLcWE7CML9viNDlmiuo3sIaQdzsVMErjz4KN3XvN4Gw+F5tB6UOBWzd7N4ZsEVa4RBfosmHxO3LJs/EzS+r8icCk2HIG0mUGqiKOJdfWQD8mha+Wfux2KawRG0t24S1QpcXEU8P400ybmv9tDhoDbd+0+n85mgLkeMGELVje5XoSN/8c8S54Ggn0QVvoZVzSf664AyvVQ1DoDCNRi1ZCcSnD35FF7qgWxHEnoE66r/Ilw8JBdNaWqvVeiogHMmFIgRfTw4F2IRLK++CwCzs/sTkqh/+xv7n8QiQzshLI8cRQJoAuyCaCww38bFqNfcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(6506007)(186003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(6636002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThBWjZJY1FWbDJHNzR5eEd6cGw5Q2tDVzZNdGZBaDJualN0alBRalRFUFpu?=
 =?utf-8?B?TEIrTnNJby95Q09GYVBtallrWkthZGh2WjExY3d3U3hXVkVDUkVocHpKOUhT?=
 =?utf-8?B?K2hDaTdhQ2tXcXRTYW05ZllOa3RhWmRub25RSjd6dWZrSk90ZjJGWGtjV01l?=
 =?utf-8?B?OHNLZCt0SWxuLzFldCt1ZDhONmJjOHVuRjd5cTRlc2xqRDJTbUpxTzlWSlpN?=
 =?utf-8?B?M3ZhV0RIUmowVldFYkQ1R1dCYktIV2hRSlMyUmlQb2pVaGtHVVhoUEZaTDE2?=
 =?utf-8?B?R3V5cGxnbGdxa0FxNVJ5NXRJSS9hZnh3UnRLN2QwTWx0Q05zVjBsY0ltRVJQ?=
 =?utf-8?B?dEx5WVN4TlJ1RWpUcUkwdnRzNXozYmVYRjVUbUxCYWRiSldhSS9mb0ZDb2d0?=
 =?utf-8?B?UkJnRzZ2c2EyeFFOV0sxdUdObjlqR1I4YzhZKysxTGRSeHQzV2dHOUhHbGhE?=
 =?utf-8?B?MmdqQUoxUTFJUHFYd3ptNXlVMWN0a2ZXbHR4TVhsdGNpaDFKc1lURDk0dlVC?=
 =?utf-8?B?SGYzRzU1U05QS0plSjM3ZW95emMveGluRWd3L3pobi8rWXBlQi9UbVp4clBC?=
 =?utf-8?B?VGlkMzNKZXNkY2IxbkdTRnNaWDVTcDNBMXI4YXRqblRXU2xITFhKb1lUVXJZ?=
 =?utf-8?B?SWtNUkxPY2hzT1g1MTVDMVJHNEdUVXVGVkJDdzVaaWcrR0dreUprM2RIcXFu?=
 =?utf-8?B?Mlh2azlTRzhlcURsSmt0M2YyR1AxRzVCL05WVkV4MzFDNVNEMmRQWnFuLzlB?=
 =?utf-8?B?cVFkY0Z5U3lOUEtqNkdZRFNtczdORTNDMStQRTlZcHpBMGZQSUZ2WDAyR0Ja?=
 =?utf-8?B?TXFWaUwyY2E5aW9LS2FiU0lHMGJEUzc0SXRkTDYyVUozOVd1b0plbGpSUFVG?=
 =?utf-8?B?cUNOdjZDT2M1Y1J0U0dKQXFoUUZOR1dsSUFMUTcxU1N1M1dNTWF1ZG1RTFdx?=
 =?utf-8?B?Q3ZMN3l3TTRYUlVyaitLNXR3bzVqRGJzVGZkeVkyNEZhSXRXN2JIVEhuN21p?=
 =?utf-8?B?amxRMk1oTXBtOXhOTjUrNUg5MnNJUEdCU1MwYkFPRGtLWDR2Sm9NQm51TVN6?=
 =?utf-8?B?WnQ5WlV1Z0tvMVNqWHNYZ3o0aUxEOGd6dVZxR3haY0wyc2tsQm40TFh0UGJ2?=
 =?utf-8?B?YjMwc1gyUU9iKzhVRnNlSnhRcFZNQnBsZlFWMVBQUlhYNk5peXB5VDFZdHRD?=
 =?utf-8?B?bG94NngrclNGWjl5cDY0U1U5TEJhRjRYUFkxVHhqbmVBcVY5a3VCV0JJTmpa?=
 =?utf-8?B?TG9kYzVNemoreG5Ea01HaVBTcWMwWXRHc2F6bGM2NHkxUXBiREZGendkQ0xZ?=
 =?utf-8?B?aEdOMlQyVlZHQVpRV1pIWHo2WEdLRm9XVUVoU1NOM3lKaFJMZ3JVRHYrL1NS?=
 =?utf-8?B?WWliZmhtUlBQUllWa0M3NjBCMzdiR0FDNDZQb2p3bWpCSGpqUXdIaWxIMDVL?=
 =?utf-8?B?bFFzRHJHNmllVFFVVWpiMURrd2orUTdqTzMxNWYyenBETEdNeFJZdFZWV0VS?=
 =?utf-8?B?THpxVWI2eXF0L2h4SXNqeU9QRGNBVml5Mk12U3pEZ2xUQ0VzVllLYXBubWRH?=
 =?utf-8?B?V2dNUHEzK0x1SWcrdzR4d3hmaDc3WUZCd2xCZmlVcWUxb0hmL1Bzc2RZWDF0?=
 =?utf-8?B?OEdpRlhzNGNnM0xKOGh1UWpPQnBNc2lISklJKzRDRXFCdVF3RTdVTkxncXNs?=
 =?utf-8?B?TkFwOVFROEoyaFFGa0FJUW4rMFhja1BZMnhxQlE0VllQb0E4RnJ6bm5vZG5u?=
 =?utf-8?B?NE4yRENOVnE1eG5mWTlZblRGb21zWm1makdkbWhNaXM1RHppWGEwQ1NjYjNz?=
 =?utf-8?B?K3k4dUo4U25MZXdpQnNKeDhjMkU5aERwRTg4TjNzM3FJMDhRb0E1V3RPaThR?=
 =?utf-8?B?VG9aY003QkcwV1BtWkxLVDBueHdiMDQvZURjaWpyK2VGZGpEdzV5ckFBTHYz?=
 =?utf-8?B?b0l5YTYvR2dXZWYxUEpCTXZhNG1wcWNhcVJ5QjFYTFQyci93eW9ITGNhVFZM?=
 =?utf-8?B?N3ZmTEQrVmNTTmVta0FBN2pabk1qYTdCWFhVRnhTdWdhRDBmamIzZ2VJcldI?=
 =?utf-8?B?V0RnQ3NOVEcyMi9FSnNHRTdsYXppSm9QUmtzYjVQS3FIMVYydytmOFFkTkpq?=
 =?utf-8?B?TCtyT0xsTm1oTmoyQWtaWTlwTWd5U1JjUEU5NEFuUDlWaDBpTzd3bENUSjZp?=
 =?utf-8?Q?ySjm9dpulIhxgGUuP2tQpLYmkDzSVtU8+NzyeQyNxo2E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eafa7f-dae5-4f26-3f58-08db812eb3f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:16:19.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNVAO/4aHY0p6FlK6naXlIDm0q20f0PYyEPskkU0JGnhC1ruHYv3bt5Dx0GpImuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



Am 10.07.23 um 08:38 schrieb Guchun Chen:
> In below thousands of screen rotation loop tests with virtual display
> enabled, a CPU hard lockup issue may happen, leading system to unresponsive
> and crash.
>
> do {
> 	xrandr --output Virtual --rotate inverted
> 	xrandr --output Virtual --rotate right
> 	xrandr --output Virtual --rotate left
> 	xrandr --output Virtual --rotate normal
> } while (1);
>
> NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
>
> ? hrtimer_run_softirq+0x140/0x140
> ? store_vblank+0xe0/0xe0 [drm]
> hrtimer_cancel+0x15/0x30
> amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
> drm_vblank_disable_and_save+0x185/0x1f0 [drm]
> drm_crtc_vblank_off+0x159/0x4c0 [drm]
> ? record_print_text.cold+0x11/0x11
> ? wait_for_completion_timeout+0x232/0x280
> ? drm_crtc_wait_one_vblank+0x40/0x40 [drm]
> ? bit_wait_io_timeout+0xe0/0xe0
> ? wait_for_completion_interruptible+0x1d7/0x320
> ? mutex_unlock+0x81/0xd0
> amdgpu_vkms_crtc_atomic_disable
>
> It's caused by a stuck in lock dependency in such scenario on different
> CPUs.
>
> CPU1                                             CPU2
> drm_crtc_vblank_off                              hrtimer_interrupt
>      grab event_lock (irq disabled)                   __hrtimer_run_queues
>          grab vbl_lock/vblank_time_block                  amdgpu_vkms_vblank_simulate
>              amdgpu_vkms_disable_vblank                       drm_handle_vblank
>                  hrtimer_cancel                                       grab dev->event_lock
>
> So CPU1 stucks in hrtimer_cancel as timer callback is running endless on
> current clock base, as that timer queue on CPU2 has no chance to finish it
> because of failing to hold the lock. So NMI watchdog will throw the errors
> after its threshold, and all later CPUs are impacted/blocked.
>
> So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
> does not need to wait the handler to finish. And also it's not necessary
> to check the return value of hrtimer_try_to_cancel, because even if it's
> -1 which means current timer callback is running, it will be reprogrammed
> in hrtimer_start with calling enable_vblank to make it works.
>
> v2: only re-arm timer when vblank is enabled (Christian) and add a Fixes
> tag as well
>
> Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
> Cc: stable@vger.kernel.org
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 53ff91fc6cf6..44d704306f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -46,7 +46,10 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>   	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
>   	struct drm_crtc *crtc = &amdgpu_crtc->base;
>   	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
> +	struct drm_vblank_crtc *vblank;
> +	struct drm_device *dev;
>   	u64 ret_overrun;
> +	unsigned int pipe;
>   	bool ret;
>   
>   	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
> @@ -54,9 +57,15 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>   	if (ret_overrun != 1)
>   		DRM_WARN("%s: vblank timer overrun\n", __func__);
>   
> +	dev = crtc->dev;
> +	pipe = drm_crtc_index(crtc);
> +	vblank = &dev->vblank[pipe];
>   	ret = drm_crtc_handle_vblank(crtc);
> -	if (!ret)
> -		DRM_ERROR("amdgpu_vkms failure on handling vblank");
> +	if (!ret && !READ_ONCE(vblank->enabled)) {
> +		/* Don't queue timer again when vblank is disabled. */
> +		DRM_WARN("amdgpu_vkms failure on handling vblank\n");

You should probably only print the warning when really an error happened.

Disabling the vblank and not firing the timer again is a perfectly 
normal operation.

Apart from that looks good to me,
Christian.

> +		return HRTIMER_NORESTART;
> +	}
>   
>   	return HRTIMER_RESTART;
>   }
> @@ -81,7 +90,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>   
> -	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
> +	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
>   }
>   
>   static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,

