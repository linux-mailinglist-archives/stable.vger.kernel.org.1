Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51777501B0
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGLIgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGLIf5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 04:35:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2E4ED1
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 01:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNftarJMsD7WGclFnQ3FgGuLmsgEKitahAPQDWIpVoBOXhmAlrvl0AkBGzc6+Y70TBF4ZM6rdEhfd35Buz82fnjTnren8ErQqes6fu4vO6bVLMx18CvwQQ7kU23YrSvw1KhpWSJTnnWxm9M2+6hIKRp9CnjGz0zXDHonIDQvrRvz3Es6fba5hoB1qJmiPKuoShhZ1gFxg+i6GetkJ5rZdPbs9URR/VeEKs6ofCEarf7ghEr5uCXozcFqioqPOqIMwcl7HyrYjXYNTWBkxKzWL+qsXMwZYD/35arBVWEQUa97ZmkdEbNrwHQYJZmwNVocB8Bk8jxTo0KV9ls10WQ5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp3TKNkRwHaJZHoBWReO1LbSkt2efEvzZ4iAnK3CsDA=;
 b=EMjopN8ZnRwDnJBDYLWCjLkYzVSOHMWRqv/91w8Js/EaIdI2TyR+w/SG3K/MmpDUyBcbtdQN6vnl/qpksJ+PB8VirUkq9jnu0vtwnl7lpuyRas52CH3Ek078w1QzOwHLhnDZkEaT/PTfWj0QcgZMN1w2Z++b2iECByvPRma9ZUnblxNHdKf/linUSZvV7Hv6wC7TdQeKVeGa1yHwJ3WwwSSe72y8JwUtWIgBub80iVMjztA6JAZB5BFfMYHeHW9/LIp9bpqHPtGbkO0Tg+wwiIVLVDmiubl6kpq++cUSlhT/nI8RsN+VLLW0kTl+PzR4cUfSl2IFc1eFM3WjJpHWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp3TKNkRwHaJZHoBWReO1LbSkt2efEvzZ4iAnK3CsDA=;
 b=YPHxruX7xNBHGsjizaqKX1Gm1tGwVaan8W0uAMvHYYONzxaXXFvsawP7nJsMsIl2okTE9XCo/yY+Zv6L4n9MZs0SOdUhOn/CYhAHKkrW1MpXY1DA3y0vHz+H6ss1SXXTVqiSChQxzZbBUD+4/gzNAGI+eg7hQDHtxFrMUjs8A3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 08:32:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 08:32:41 +0000
Message-ID: <1195051a-cf51-7dc9-7055-5e139202b4ae@amd.com>
Date:   Wed, 12 Jul 2023 10:32:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Content-Language: en-US
To:     Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, hawking.zhang@amd.com,
        dusica.milinkovic@amd.com, nikola.prica@amd.com, flora.cui@amd.com
Cc:     stable@vger.kernel.org
References: <20230712013455.2766365-1-guchun.chen@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230712013455.2766365-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9c3be9-a848-4934-201b-08db82b28e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocargJDXQxGuI9/v4nVHi4mCjvfkIP2v0LJOptNJq6iFJtbXCTjdAwtmiLoaWwXECVeUJ9oWnJyx26ohJa/8No6usg21TA28bob6KKElhJrQgv4yTOJUt6MmgoocOd+DUhZJ7SjYyUnmtNHVh0mEsyt/J3v6o+sloqMypJjhBZ8RZ01ic+QnQBDFOnBRGTq1MAXk0Oe4NXHNwxwqfKX3bPcI81zE6UifA5L670UWK5i/4wc/HwRFUqlWKAJH0dwx94ysTe19pR5Jq2e8B1muveJsM3ZX1KVYSWGUXu02hxuFCFO3GKAIdJ29gW/MJtg05uKzFwL9vE6Os8xoxjoa0/2CQ6uQBJBTmZ955XAXKiLChPzFScGuZuU9EL4RYAvYfL8ReBywC9qSn721jKYMsdPITJ8cr0QMnTX8oTfCYOyEt9LUHynjxsABUY+Oj9w56w4lSL97j9mzwhRegiz2InJLTW5B2LCny85L5tPT9qhMtV0Q7cttccTp7pPtC2Uwk4iHi+/vpRlaM9AvCgb4MR1TKlK1OOXXiHL9f4DXrSK58+T+nkIeGE+d/0pesgvQ+/KB2SEhxX7qkD43GtBYceXDKfein64qrlD5aRNw1+ls41tHwRDAHPtv0f/YsN2zaA8YXIZqw51OjGJ1xSht/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(8676002)(8936002)(5660300002)(186003)(31686004)(2616005)(66574015)(83380400001)(6506007)(86362001)(31696002)(41300700001)(6666004)(6486002)(316002)(6512007)(66556008)(66476007)(36756003)(2906002)(66946007)(4326008)(478600001)(6636002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZ3SWRmMzY2eTlYaG91QUpaQ09pREN2VXFTbTYwKytjUXJLWE5vSTJtbllI?=
 =?utf-8?B?Y1dRWmIyN2Z1YmRRWnJqcGdDMGF2YmVFYXI2RGQ2VnlhTEZoZ3ZQak5MSFJF?=
 =?utf-8?B?Unc4K3FleFpNamlkejQ1aW5aZTk4N1lDL3FBaU1YS2wwNitQZXF0Q2NiWWND?=
 =?utf-8?B?RHNxMGdXWVJhRllWYUIzRW1sNHFZanUvODg1ZXV0b1NsUWl6Q0RmSW5IQUM0?=
 =?utf-8?B?TERWRmNlZXpaZ2gvaEI5dWF4S01UUU1MRWF2V2g1NWJWSnI2NEl3YThPeFpi?=
 =?utf-8?B?cGNTcSs1UEI2aCsybCtxNDVaOGtXK01WMWJPWWdEMGhqSm92V3pFdU1lYUJF?=
 =?utf-8?B?NDhiQXdHL3dSeFhDK1lkY1haVy93WWxnRDlTY2xVLzBHMUE0djU1SGczVXpw?=
 =?utf-8?B?cmZRNmdMZk9UM2R3UDlZTk9kM2RNc003MEEwdFVMYWNWRnZlbnBxNi9sZFRw?=
 =?utf-8?B?SFBseHowRkgwYmIrdzJlSk9PNFdXak5sSFJjVXN3UW5ncjZWWkJrdXljZGYz?=
 =?utf-8?B?VDNqTDkweWZ6OVZQaVhvOUdOVU5aNkRVQktlTjhLL1dGMW1kOHBaZmhaQnJK?=
 =?utf-8?B?KzFGS2FPNkplUEtFWDNOanpMMlVHd0R6dVIyUEpRT1hmL3FVcDkxWlBpU3VR?=
 =?utf-8?B?UWhSak1JaEt6VmpYK05OaC9Bdlg0Sllwa2c0VWVYeVN5U3NSUitTVGR3b2Ni?=
 =?utf-8?B?RVR5Mk5hd2VYaVdtajlQWmtxSzJjODhGSzNjakNnbFd1aElpTWJIQlY5THZW?=
 =?utf-8?B?bW5PekFkdTFUR2lDd0FmVXNJNTdvN1h1Wi9uM1l2QjBCYllVNlNCZWJyU2FK?=
 =?utf-8?B?aTVUSytsQlRUVENwTU5rd1cxWkFBUXNlWDdxVk05RzBVZ0xoTCtZOUNXNExm?=
 =?utf-8?B?WmFJS0cvVHhPTzZjcHlmYjl5WU05SHh0OGk5bmdHQzlKTm03ZnFqeStqWDZW?=
 =?utf-8?B?NXZ4cUNVMGdiVmd4Ui8xdllYRXdXcnJnbGZpWGFaa3FCV1IvVUJvN3ZweTRM?=
 =?utf-8?B?cGh3YnBxeVlzRXl2eTFydWp1S0dZMFEwWFdwV2gwd2FUakdjRVNMYWdoS2s2?=
 =?utf-8?B?MnlidytFUHc5ZFRTYWFwNlhDUjRHL0hEaVJuWHJrNG5ZVFlkYVNzZC83cW9G?=
 =?utf-8?B?Zk5PZFBoRzA1YkFvR2wwNTBXS1NCYlM1OHZJWGM2Z3ZsMUxPL1k2bFh5ZmFo?=
 =?utf-8?B?aFIwTkI3SUlDQUh0QzNCZnhSMEw0MTFoaVZ0NHRtS1pCMUg5ZUlMa0N1TDR5?=
 =?utf-8?B?TWhyNW1RN2dVcEs2MmI2T3JlbVgyT1Y2NGJqak9vYnNUN01NVnBHRzY5M0xr?=
 =?utf-8?B?R3IrdjVhdDhYSnNkQXN6NEV6K2N1djBVckZLZUllYXlOcUVCRXIxZmU2REpJ?=
 =?utf-8?B?RFVQRkdkZXZtWlRmN21peENZc1g5UDdjeWFPT1h1SVVzVjJWTXp3UkdVRU5s?=
 =?utf-8?B?RkNkMGdPaHk5TFA5T1MvWjN2NDMvUUFzcTJ1cUxETWlUdFF5aERFazZ1N1po?=
 =?utf-8?B?UWIyK0ZubFhEL0tpaFBQKzRxVXh1WDlZMyt1a0pZNXp4by8rSVlsRXovSXRp?=
 =?utf-8?B?OFBkU1dkZHh3cVdXd2FoZFQrSUhaeldONE15UVNPU25RVHd1N2tmZHZEK0hs?=
 =?utf-8?B?bzlnZE00R3NsSTZDWDJ5VmxpSzBuMUl5UEF5YWc4cXZESC82YlVUbU9rRnQ1?=
 =?utf-8?B?RHA3ZzkwUFNIR045SmJWZW1iUXgyb1MwaUhMWUVzM2k2c0ZLTVVzcGFuRFEy?=
 =?utf-8?B?cTBibDZnZzJueC9SODdUV2JXZWE4b2FhTkdVK1JJZGtNYTlCTXRtSC96WUZr?=
 =?utf-8?B?aDdSeWNGa0lrcE85MGZNQ2xSMTk2d3BVVFI0R1RDNElkcHp0aHpMMHhlQ0ZI?=
 =?utf-8?B?TnFrc1phdm56TjAyMGRBNGlZZklveUdKNUYyMlpQMHFnQm5jcXlIcnBSUHIr?=
 =?utf-8?B?czdTSnR5aUQrMTZVNllOdnpOZktldlg2Sk9YaWZOWmo5N1piOHZDQkdUYWMv?=
 =?utf-8?B?T1lzT1J3R1ZGRFBCNnBETW1jNWh5SlUvQTNLTnRFNnlQdUF0U1lhdE93b3BH?=
 =?utf-8?B?Y1hhcWFNZ3Q1Z3J3RVUrb1B3N3I3elJ1REh5KzlGS0hTMHN6blRpVC8ybUFD?=
 =?utf-8?B?b1U1dnA1anM5NVR3L1pKZUQzZnQ0OUxXZGlxYlh4clVhQ3RTeU5ITVlhb1pD?=
 =?utf-8?Q?reX59koI6MaGVBfoexsDQZyUIRSnw1VL/BLPWauTA8Gp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9c3be9-a848-4934-201b-08db82b28e93
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:32:41.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeNpPUcFwTNEnm3mIx8eQKshgNDDr7FUGEn4FdYKvqf0f4TzEckH4VQnHvcXs4E2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 12.07.23 um 03:34 schrieb Guchun Chen:
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
>                  hrtimer_cancel                                         grab dev->event_lock
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
> v3: drop warn printing (Christian)
>
> v4: drop superfluous check of blank->enabled in timer function, as it's
> guaranteed in drm_handle_vblank (Christian)
>
> Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
> Cc: stable@vger.kernel.org
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 53ff91fc6cf6..d0748bcfad16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -55,8 +55,9 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>   		DRM_WARN("%s: vblank timer overrun\n", __func__);
>   
>   	ret = drm_crtc_handle_vblank(crtc);
> +	/* Don't queue timer again when vblank is disabled. */
>   	if (!ret)
> -		DRM_ERROR("amdgpu_vkms failure on handling vblank");
> +		return HRTIMER_NORESTART;
>   
>   	return HRTIMER_RESTART;
>   }
> @@ -81,7 +82,7 @@ static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>   
> -	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
> +	hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
>   }
>   
>   static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,

