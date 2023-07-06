Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791EE749A8C
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGFLZH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 07:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGFLZF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 07:25:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA381727
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 04:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9mx/79nw8wja0WQfhYuZ2DFxXMXeWudqq/gO1fTI9RdRTPbzyQ2LN5lByjbWpdPrKxQ5RKrGJAMV/Rw7pPpcodMX6Tyws1IbxpsVN1J7jwg8QAwfTF51Hd1ANelL/lrKJq3QYL4ccmDSmB+/mmWvmr3gKNxZkwVz954Sil40iZWItvHr9fOmk31DMkzxaPjlc7jjiRsk11pwE1lj+NTgyBotN4YMq+rcv8wkNczh4T0LPh39FqD1AZfmnh+J2DsjESskiaViSww49poK3cU5ulKoAMR9pFR+rgm6ml/nC7Hz/P91PuzlnrvPyG+eKmDi0Ws9srcpRiz8AbSAaYDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDd//e4FkTndI1i40OSa61BbdphVeB9Hw21J9licZJ8=;
 b=JkocwQxu559KONIDFiHGvXu6Vl6aQIIHJLhdQWes/1iI211UQczCBnABmVsneG37QRjh3drgHdRup0fkT4d0SUMjavvAZNhdnBb8kws70xr9awLmeOUBKurED/nIUpdHhxcLBWFrSgtrrSgYNDbbdCKwVMYFbcuXFHCd5pUnIi7ad8IRx8bfGrz+dBkkvw7SujdhHcNWe+7xhpLgdYk4dMT0w6N96R+oz0+NwiIULaTA8+MTpB4KSbifdq9dbjMHKITU6qute+a2VhLKQyBCTvJtyXX4kYjWS4rLwwFsC6cTEkbhFfRCnVrr89geRMOgxXhj+EYUmXOp4+/dAh3Ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDd//e4FkTndI1i40OSa61BbdphVeB9Hw21J9licZJ8=;
 b=qQIpATbcO7HWe5U52SAZIym87rHnh+vOrSi5OE8xwdEgoAiAwJNOYMusz94cqo6C06gh0tI8mywEMo47G2fSiLAZN/u1KxPKtO8zjEJa2HghVaTCGLM/f/eb+e6FTzDA68exknopMIyJz3w9y/JgUHm3gS7JKVDqnvls6yRCPiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:24:56 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:24:56 +0000
Message-ID: <c2f4bf79-c41f-38b4-8843-28ad520f24a7@amd.com>
Date:   Thu, 6 Jul 2023 13:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Content-Language: en-US
To:     Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, hawking.zhang@amd.com,
        dusica.milinkovic@amd.com, nikola.prica@amd.com, flora.cui@amd.com
Cc:     stable@vger.kernel.org
References: <20230706083523.561741-1-guchun.chen@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706083523.561741-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f08571-72e7-462e-d495-08db7e13a067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FaVJRxoclET67UbVnRINXM2Puru9wMlIkPieiWD4yPBq5M/DQtwIFGOCaDI0FDmiqpCLbgadQ85Kdo5rzX8xmLGRgscDndVwm2vztVWD/EJrOQd/vV4d95WKhqccVstq3pN9dOOGr8BWcvRerRy+FzqFDIGX3Lo9YIoCQEdxMGeAmODlVMC+B+LulfgxBMHgjF+uQgmFlAIFxT37dlJLkwk196H+nQAcOSCTb4H5ZxioiPKpzEqQOJJhmLdH4ieYYUWhJmwlDQrQq9zvHLHix1Qn21K6KUlgwPL04xpBg/2/lwRMfUg0+kAHHxcMJ6++iM4KuZefhHfc0cJw1TGmcLSuIazQMoAgFCRBePJVdbDNGhRJJcrguI1zQIF8FbJLRNSai7ho0qB7PhlmIN9lWunmBUkv6xVbz84rmjB70txngj+oS5gvmEP6mcBTAowprQHk2aym2r26kDjEOJETJE2ROPsgDIw5g993Q2gASwqBbYTL3/Xkpio+J5AjQW5YikFZ4iu5tUBYQqL8qTxBqSn8enmcQxX6fYH56xTuPEz7YXboNzsppEIIh6RrkF/H3tIlB5efOcX8lX9KRto0TkVwc4LKFItmQm1OsMUUkFkhrs9vTebtduC6QRJNAkArXOLmVwk8CW5kwG1rqaNVqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(83380400001)(66946007)(6486002)(6666004)(478600001)(6506007)(6512007)(186003)(2906002)(66556008)(41300700001)(66476007)(8936002)(8676002)(5660300002)(4326008)(316002)(38100700002)(6636002)(31696002)(36756003)(2616005)(66574015)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBXbE0vOWZMSmNjSHJZcTIzYXZqWTNLSnZ0NDBuM2JhRTN0OGs2T2w4cldZ?=
 =?utf-8?B?NXJYUllDKzRLQW1GQU1rVmU5c2RCNGlkQjlKOW9OVXA1RzkvMGVDZXBxM3Na?=
 =?utf-8?B?enRIc25nMUJLaHBPRWVIcllkYnhmTXkraHd5WFpTajJUSHllNERLMlVBMkp4?=
 =?utf-8?B?MXdNbjNsaWhEbHBpOTZ4Rm5BOW9RRTYyQVBpYTlzL3pYZzlnbUY0T2F3THIr?=
 =?utf-8?B?azMzYXBJaDJaRy9IWFFmNGtFZlN1VHhweE9JMmRlejFxTmo4RjJOYTFRZGpo?=
 =?utf-8?B?NzhYNk5kYzR5cVBSQ1oyY01TSmNvM3hkSSs5K05nREM1SmtPTDd1Y3lvb2JC?=
 =?utf-8?B?NHlEbkpJOEtTS2YrOE56WHJXM2JQb2lsTTF3b1QyQWFQMjY3WDNTNERHQjNM?=
 =?utf-8?B?UkpPdTl2NnRGeU1IM2lKcG1maEJrRFlJRFpOYUZhWnl2Z0hNbTVmOHJ5NmYv?=
 =?utf-8?B?S2xOUm9aMURybzlYQTlaYWtwT2tkUmdsRHE5S2V1RDVMUzlYaVZwN25PUFkz?=
 =?utf-8?B?Nktpc0gxVGRVd1lYNTZwd1JJSVJKQmQyZlJ0eWtwQ1FvNUcrZVo2U1F6UGZW?=
 =?utf-8?B?ZkYyWjZqeWNmSHErNytUY2RtM3ZmcklSNzYyTUZHNDBJQk5OWGJiVGJwNWNk?=
 =?utf-8?B?R3gra2xya2NKOVdpY29jWmlJblUwdlJ4TmpKL041UTk5REhLTXhsc2JNQlBY?=
 =?utf-8?B?TU5UWGplNmZpTGRYUW0zQWFPc0RhR1gzeXloM2JVL0k3NkxROU5ybmthdGdE?=
 =?utf-8?B?NTJIUVNMV01EdFZYNDhoNlZDbG04TGhtSk83dytZa3FUM1V6akh1MllGZHI1?=
 =?utf-8?B?dUNqVXV5MStjQTJmVlV6ZmxINWN2ay9LU3l2V09ScGM4eWUrUVJMMjJNSDkv?=
 =?utf-8?B?S0pOa2o3UWpIaURTdzljd0Vzd2VDUDlVcEJqMGVMdUpXeW1BWEUyaWNNejgy?=
 =?utf-8?B?YkJIcVNTY0ljeEErcTFYcWt6eVZRcEwvSGhTaVZTQURwQTBXa1lOamdQWWM0?=
 =?utf-8?B?dzlpazZ2Uk1HVW5tMkg1SjNYL2RUSE9weXdWdUpYdnVzWUt0UXUyM25GZ0NL?=
 =?utf-8?B?ZEVwZHJpdG0xSWZLcHdGdzFvaGVTby9HWVdsY0V5d2pudlVCOVVsSEtydjVx?=
 =?utf-8?B?d0ROalRja0xHa2lKSWdtWkJuOVRXZUtpZmEwZkpoNzBDRWhjRzFELzdBRjdW?=
 =?utf-8?B?bHNla3p5RFlIMFpnSmhwaFFpRzhjV0pNN1VYU01pbmpvOXNObW9DeElFRlgv?=
 =?utf-8?B?L1FPS3MvQ2E3WWxxUmdlVkZVempGcGZMZGhsa01udkt4MERkUTJ2TklZVERY?=
 =?utf-8?B?aUpmdDJYZnFWTmhOa3lJUGU1clRKa3hUN2g5VmRHTE5ZK0lhajUzNnpTa0VI?=
 =?utf-8?B?SHQvTFRoSHhhbjNmd2ZDTUVQQmR3T1YxNzRPNkpCQ0lYaDlKaEhYSFFxbWtX?=
 =?utf-8?B?TkFrb2IzZzMzMWx6WXF1T2dXRU5sZmtaclk2eGNkaUtHTEVIUGZuRVZScHht?=
 =?utf-8?B?bXZtaktsYzNLTlg5UXpNYXV0TEQ1RFVYZmFiOHdkcVplTmVzdzdRVFBYTzBo?=
 =?utf-8?B?N2Z4Vk9JVXJWTWNsS1FTNVorNGRlNWZhYUQ0cVpsNDFSczBBY0J2TW4vRlRI?=
 =?utf-8?B?TlowTHpUTFVsbFJSSTVWaWxjTHNOMExSSmRrblhmWmdGbFpobXRZUTMwMUVt?=
 =?utf-8?B?clJoZjYveCtuVmlXSlFGMHRDM0tJbmdYN1grK1hVNU16dmp5bFpMOG1MckdX?=
 =?utf-8?B?RG9XbkhJSmgrYllEaUdWQ2N6cXhFUlZ4OW1MN3V6OHp4UDl0WTNWTkFCUU9W?=
 =?utf-8?B?eEY0eFVMU3FOQUErUlBXVGd4dE44dWs1MTA5eTdKQVU5cUxKRWZZSWp3eENp?=
 =?utf-8?B?cmdqdG5qMnlaSlJVamEzS2FvaXBPaEtOd1QraWdFOW9jUGt5Z0l6eDd6MkE0?=
 =?utf-8?B?eXVhWTI3R0xiTlFVMlpnQmFCbG9DR2d2QTh5SnJKdEV1Ym5vQVdVTTEzak5F?=
 =?utf-8?B?RzRKdVZNVklDRFZ5SHNQaWtVTFRQeXdlOGl0NWkvZzBqeDVabTkwcWVJQjhM?=
 =?utf-8?B?dFdJcFJRTjhQYUN1aVVEV3RrRmthdlJ5RmlEQW9QWklrZy82VWZXOE82anBO?=
 =?utf-8?B?Sjg5b00yOHJYazhrcW93bTNyemZrejRQWUFMTGlPOTJSeWk5WlNlczJ4ZlVj?=
 =?utf-8?Q?L3wferasP8OcnYOwESV8Ymc1uZlUincvZJfnCDtetI+j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f08571-72e7-462e-d495-08db7e13a067
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:24:56.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYzddVFSVzJWwxmd5DPLa4aRIUs+Tm3JznoFzHX5JdhMt258WwuExoVuO7lX+G4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 06.07.23 um 10:35 schrieb Guchun Chen:
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
> NMI watchdog: Watchdog detected hard LOCKUP on cpu 4
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
>                  hrtimer_cancel                                   grab dev->event_lock
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
> Cc: stable@vger.kernel.org
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 53ff91fc6cf6..70fb0df039e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -81,7 +81,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>   
> -	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
> +	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);

That's a first step, but not sufficient.

You also need to change the "return HRTIMER_RESTART;" in 
amdgpu_vkms_vblank_simulate() to only re-arm the interrupt when it is 
enabled.

Finally I strongly suggest to implement a amdgpu_vkms_destroy() function 
to make sure the HRTIMER is properly cleaned up.

Regards,
Christian.

>   }
>   
>   static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,

