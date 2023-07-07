Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA574AB73
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 08:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGGG5K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGGG5J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 02:57:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E1130
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 23:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7In3txfkHm9FrY9njW/E9kgHLNCEkL+KCX/hlY4nhnoAatyNZffw3zIDha9XS9LYwJtwzvL/nHl67pTFdeO+h37uq3mdf7wFyJAKpErtpEsY7jSOBtZdKADMA6l8kX080IcBS4yhs3sCAKzYRY9b0C6LZ6WDzQgNY61bPNYzzUGlIFxvlJ97RbepRKsvi+bwFRaEmbBnoBJd3hVuxKfX8Tyw9A5n0ZXfNo37qUmvBAnjqDHhHbVZVUXoVOMs3wLNbcz7U7d03+npyjtRS00xb94hVmJLCVQBixUtmXOkR9euP9Rz1NQYZrp4DKvi/gxNFNcyIg2NrI7EUDOYm/O7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIMz8ExivfOKSfIQo59fFVw20FlYSPZf79HFoiNhrW0=;
 b=fTxcLvv72Wy+eaIup7VSVLQx+RUGCKT9q7cUCW1S0CoJ4zRmsd7TVcT4DuLWOdmOUjjiz/wwplOoUszn7xVK9oE0KHe/iYVTNmgxSQWEad17Ur48xQX2K0PTOtpyl7Peuf0LDh9MqboSWO9cewohSYwuzdnPbBTGAj0VLeRl/4wEPf9DPgZR41vg0MM8ggIhrz1+xul/ueLZQedqwMvrFYsfaMZkTijsAdzrN7pVMR+wDXvll/8SAZJs48tBrvXjcsr4siZUvi2IX683eSpG6QUHxgPqDruG069drcpQaSz3+6i6OhlRzhNICGqvuXExG1mmMfspprq6ojkPkJ1eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIMz8ExivfOKSfIQo59fFVw20FlYSPZf79HFoiNhrW0=;
 b=RWQj8ySKwTyFkGKtTer10Pksz6Un9tH66SinM2k3BhWu3T+jPToVBa5Dqa2dul0Cr6ObE3GowJgexLAWY7crPvUVf1hhxOuCPk5lUU0h059EKC26N+2zVokucvcw4KGxXtyycqt8BvgAIsiGFN1B9Hggoxm8RnTxdL8uVQtKK2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 06:57:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 06:57:04 +0000
Message-ID: <a625bd04-1ae6-536d-d255-c3efa6351312@amd.com>
Date:   Fri, 7 Jul 2023 08:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Always emit GDS switch when GDS/GWS/OA is
 used
Content-Language: en-US
To:     Friedrich Vock <friedrich.vock@gmx.de>,
        amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
References: <20230707062908.9470-2-friedrich.vock@gmx.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230707062908.9470-2-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0c294e-d5bd-41ed-b523-08db7eb75e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9Hkjai3wNEgDpnK26A7x7nIi9ZuUp9W9WwsWT3m8hhPaAUhIArzHgpwm27nwVymXegE8Zyr8l044DCO9wfWBNooKGdgCi/xd4wnlpnyiyiEUARUi/OwhkA8WAI0WvcWrYWXK6COPoEadLH8NQ6ca49s1pArgiuG+HmeqCB0VLL92cOMKx68bSkpwSFGVf6beUbACCZoJSIbWwtjtPUKuWbgVAN4QhgWaQ3xRq5KeMbrCWJyxfrbsywi7TdYTRyjO1Ys6Di5kUcQpC42pUhW1ynHnzUmLDqnww1jEkLGd+b9nsUVGl36rIbbljWTcqXXpgxsAia7Flm/ek91RUCOABQodzS4wXG7lb4rm0cZwHWagmKtIBvY2Do4KGbMNhk4X4400Y/ldCmCH2l4IA91Bf5gFAS8RcRzkXkEvt69OwBXiSBj9RCni5xlsTf0wJxcSRbTpyFJSE7yv9nbjIC/FCeJGHyJM30VHySpHW+QV+xzi+v14DKZtYmpisN7AInXLm94SKh3o6cUa2RdjWCosjg5iGx/mU21lqalSUWaue/8qgmIXtuOfrjPtqb0o09qrzCnZb+UjEYwObeddOMNfldUr70n7FAc65l6JBWzOcW+oMBDm6mYo2JEk/jizlZ9U1ddVCa8PtVfzJTLSWyzxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(31686004)(6486002)(478600001)(6666004)(2616005)(83380400001)(36756003)(86362001)(31696002)(2906002)(186003)(6506007)(6512007)(966005)(38100700002)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkYweStpMTZiR0FrcHBaNzdXS2VaK0dLTDJmdjhXUzZBUmRoTUswSEtlMkVq?=
 =?utf-8?B?R2tLRTJnMGY3bXhMUjRCOW1zMklFbC9mZmsvTS9naWU3Z3p2TUs1SW1aYWFi?=
 =?utf-8?B?Nmo2bTRIMjNkcC82T1gxbEQ3QlZiRmRnYkhPN0kxcUFpUFdGRUNYZzBVcTZ4?=
 =?utf-8?B?cnZJT0M2cmNqZ20wQ2hLMW16U090UmNTWkRPVGtkUFp1STMvYWJ3QWRNV3ZY?=
 =?utf-8?B?TEhhQ09sV3ZxMms3UGF4cmRUTG8yc1h1QzkrZElOOGZEbWNQUEVpWXNnaVM4?=
 =?utf-8?B?Qjl5QS9OazAwWXYydnNpR1QvZVVjZE5tWjEzakNvdmpWSGRXcjVOZS9PTXhp?=
 =?utf-8?B?RTU4akoxVlUya042YnBEZGNjeE5rS2RhZW1kYnpLb3I0R1N1c1VOSmpnNnBC?=
 =?utf-8?B?NS9HL2pQSitMWER4Z2xSNlR6UjhsREJWSmhOZVdPSTZ4SW16RGRaTnh1QURo?=
 =?utf-8?B?bDNHOEw4L2JHV09lenVEK0d1VnFUY2d5ZVZyOFJsWlFkZ0c2YmxNN05XaHVO?=
 =?utf-8?B?bnZhL3hPdTBwZEh6dFMvSFhpcU9jS3dmdE1MWk9Ma2MwVUxsQ3RUcTRSSUZt?=
 =?utf-8?B?OEoxZjdYRUYrTU9HTUdvZFpZbDczc2N6TDIzMFI3SVBlOXcraDVxaDE3bTRP?=
 =?utf-8?B?NS9tWkZjUzhScFJwdk9xR3hqTUZEYm1sSGlWVXF1UmRDOXljVUZSZXp5eGRu?=
 =?utf-8?B?VHQvbHE1ZnZHZkJKZU5Pb20wYmlwUERObXJtSityWWtCUFVTaHlUSldWMmR4?=
 =?utf-8?B?UXY3VzFhUjFaQ1lkU2lJRGFXZEdLRU96Wk1wUFJNSDg4OHI5aFlyNERQTkFs?=
 =?utf-8?B?ZWMvU3pWb2p4TEhpZlovZWlaSVljcG1Hc1FNcDlxNm9WdUpvaGI5WWp0V2cz?=
 =?utf-8?B?OFZPN2Z1STFRT2xYb1N6dGJkdmhwak8rRFIwZVlUbVJnL2NkQkJranorRjBO?=
 =?utf-8?B?TlVtc1JZMUJtU21Kdmd5cDVTQUlja2IxTnhaazJHalNxSEk0NlZicWJnalR2?=
 =?utf-8?B?TUkyN0FuS2x4QjF5MXBEK1UxNzdjNG5tbmRTTXFneDhGOTkyRm05NTNXa3RL?=
 =?utf-8?B?VWZhSFAyKyt2TzdETm1laWg1MmhaL0lCOEtNVElRWXIwQ1V1dXhRay9QbVVi?=
 =?utf-8?B?aXhBQVYxTjg1ejZ5ZjgyaUw2a2lQQlpmQTdqTy9rWWFVZFNrSnZwWDJHbm91?=
 =?utf-8?B?TWhlRkxkejQ0cEFTTkMvNGpNR1NHUHhaajQxTERubFBRRDRrL0l6VzZUYUts?=
 =?utf-8?B?MEpDcC9OalN2cThsbC8vYkZOS0lBbWVuV0pGV3hvOHNmdnR5b3NtNnY4eGEy?=
 =?utf-8?B?OG1zdm9EWE8yS2RmblRaaVQxb1d5QmViMS9KWFJTWmRTMStCbjFDemV4M3BY?=
 =?utf-8?B?QlpGVVZxbzhrajgyN2NWS1lVR0dkd0txVVFtQjIrS2pXL2NHN25DWDZDSlVp?=
 =?utf-8?B?Ynp4RlRrOXA3cGo0R3VVWkxrZDBpd1FoaWRKeHBrQ2JNMk1mZjNBWU1rYjdY?=
 =?utf-8?B?Sm1YZjY5WkxDSE5DdlRvTTNOSzZQQUFUZjgwbXI4Ly9CaVJISXpBUWZEY2tn?=
 =?utf-8?B?T2FvME1ZZ3drU21BblZuMzdrNmVkRngwZDlCbWEzUjhFSTBDMXVsSFZ1bW5j?=
 =?utf-8?B?TldicXBnN2ZpOG9jR2k3NHJMbUNxQ2tQK3V0NVVvK2k4T1NIMERvQ1QwdVo5?=
 =?utf-8?B?R2VWOVZaeENkbWpwU3RBajlOVVc5VjlFbFIvVE0wQWZWdVJmQU9LM0NvM3Vj?=
 =?utf-8?B?UVRIUjZyZUNhMnZDRURPKzNaZ0dheitiRERSYnMyZ0FYUUhkcVdaZkdnSUVW?=
 =?utf-8?B?c0hVRlV3ZUd2Yi95WkVJY3VNZkZRSHZtTUJ2WXEwTmo1WVhoWHlDejJiVTZW?=
 =?utf-8?B?SW5rdGgxZVNNVnNDVndxOGhOaTFNM3FCYitNQjh2MEZYdjBreTRIbSswOERi?=
 =?utf-8?B?RWtZQWNRdnVEcE4vRm1NTnBSY1ROZXRIQmFlTlU4dnlFcGRicWpjYmVBSlR5?=
 =?utf-8?B?U1IvM0h4aGRUckN2Ylhsdm9GOEJDNHdMRXhLYmNPUzVTUjVrTUdXNmRzbDRB?=
 =?utf-8?B?ZUhRQkk1dDVpZnlCTk9XOUhuejhkNWZWWUpHU1lBZDQ1dWdURGFJYUkydWo1?=
 =?utf-8?B?MHFtWk12OTRxbk5yNE1HekVyTUl3b2wyY1MwMFdGV1ZTbksrTHNsR240MXFw?=
 =?utf-8?Q?fXHQGMwlfvl8FEGElQ8sIVJUBOk8LiRmYPHJY7BDo5Oj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c294e-d5bd-41ed-b523-08db7eb75e81
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 06:57:03.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5y9gAmx2JuN6RxhpFVaI1Sg21T9AiHv5fr8bl+d/X2I0hSUsO0JVpvADkqKvKg0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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



Am 07.07.23 um 08:28 schrieb Friedrich Vock:
> During gfxoff, the per-VMID GDS registers are reset and not restored
> afterwards.

Hui? Since when? Those registers should be part of the saved ones.

Have you found that by observation?

Thanks,
Christian.


>   The kernel needs to emit a GDS switch to manually update the
> GWS registers in this case. Since gfxoff can happen between any two
> submissions and the kernel has no way of knowing, emit the GDS switch
> before every submission.
>
> Fixes: 56b0989e29 ("drm/amdgpu: fix GDS/GWS/OA switch handling")
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2530
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 22 +++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 ++++++++--
>   3 files changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index ff1ea99292fb..de73797e9279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -165,24 +165,17 @@ bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>   		atomic_read(&adev->gpu_reset_counter);
>   }
>
> -/* Check if we need to switch to another set of resources */
> -static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
> -					  struct amdgpu_job *job)
> -{
> -	return id->gds_base != job->gds_base ||
> -		id->gds_size != job->gds_size ||
> -		id->gws_base != job->gws_base ||
> -		id->gws_size != job->gws_size ||
> -		id->oa_base != job->oa_base ||
> -		id->oa_size != job->oa_size;
> -}
> -
>   /* Check if the id is compatible with the job */
>   static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>   				   struct amdgpu_job *job)
>   {
>   	return  id->pd_gpu_addr == job->vm_pd_addr &&
> -		!amdgpu_vmid_gds_switch_needed(id, job);
> +		id->gds_base == job->gds_base &&
> +		id->gds_size == job->gds_size &&
> +		id->gws_base == job->gws_base &&
> +		id->gws_size == job->gws_size &&
> +		id->oa_base == job->oa_base &&
> +		id->oa_size == job->oa_size;
>   }
>
>   /**
> @@ -434,7 +427,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   		list_move_tail(&id->list, &id_mgr->ids_lru);
>   	}
>
> -	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
>   	if (job->vm_needs_flush) {
>   		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
>   		dma_fence_put(id->last_flush);
> @@ -503,7 +495,7 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
>    * @vmhub: vmhub type
>    * @vmid: vmid number to use
>    *
> - * Reset saved GDW, GWS and OA to force switch on next flush.
> + * Reset saved GDS, GWS and OA data.
>    */
>   void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
>   		       unsigned vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index a963a25ddd62..2898508b1ce4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -53,7 +53,6 @@ struct amdgpu_job {
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	bool                    vm_needs_flush;
> -	bool			gds_switch_needed;
>   	bool			spm_update_needed;
>   	uint64_t		vm_pd_addr;
>   	unsigned		vmid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 291977b93b1d..61856040cae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -557,6 +557,12 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>
> +/* Check if the job needs a GDS switch */
> +static bool amdgpu_vm_need_gds_switch(struct amdgpu_job *job)
> +{
> +	return job->gds_size || job->gws_size || job->oa_size;
> +}
> +
>   /**
>    * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>    *
> @@ -579,7 +585,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   	if (job->vm_needs_flush || ring->has_compute_vm_bug)
>   		return true;
>
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> +	if (ring->funcs->emit_gds_switch && amdgpu_vm_need_gds_switch(job))
>   		return true;
>
>   	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> @@ -609,7 +615,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>   	bool spm_update_needed = job->spm_update_needed;
>   	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> +		amdgpu_vm_need_gds_switch(job);
>   	bool vm_flush_needed = job->vm_needs_flush;
>   	struct dma_fence *fence = NULL;
>   	bool pasid_mapping_needed = false;
> --
> 2.41.0
>

