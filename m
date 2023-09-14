Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CE7A0641
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjINNkj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjINNk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 09:40:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EE26B0
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2YWpbA3JU7fiZGNu5SitE1e8VQzwz9/579APCmwU4TADI9hXXTzaQklbfwuBhEKQd9I6piHHYTqv+iHbCJhYsqfLOZPPuoQbahyWZSbAqtscpBZd971Df5JONLfIZxk7pQBE0MPMPkjb3vFWFCkZbTer5/hgSZ4opEBVOSSk7x5NwGIq9sm2LEBsgHfXbI2mh/jWAe9k1Qtr18TlWUqkOZfOs3u5QHn8p4PShFhrGOY/wFW0vbC5sQOgp9hep9s1GW/e2vUtuFWp1xa2RnnmSMmhsTyM0a547urmfj1Jtq7/rJzj3WS4ej9GxWxJOdNLIG/z3MNeBWP+tONJSwBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5esnbIAU1ID8ldAw3SiWhWZkP5WXwXO30oc82rBgAg0=;
 b=APRufkHLMX6hyiY7UiWxCPgjKeyu+DbYXsHz+PwIES8W0BseCaTi2pj397SI3peUf3FJ4MVMTJlqEJ2VEfZoDltX2E0zihbNc+ZS0Z6QclbQCvcyifVdx20nxmdF24y6OXJwYs2a0KCovcX7Tgf9kDcB5nrpz5mK01L9aj838yeESbKwdB91GK0AJBzqExs7zMsGd6Lyb2CHgbL4I1CULy1E1pBC/GLAlxXkImvqggRB+XEbj7vNGgT+69K8PRvSJFFfAt+gXb4Ethnm0+lBfQHybOnJZGW2XEL87zg89J2Q6yqFxBd+9alheK4fFH7MQU6FTIWa7eIa6PwYnQD+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5esnbIAU1ID8ldAw3SiWhWZkP5WXwXO30oc82rBgAg0=;
 b=vAtfn0nR59rIrvYSpY2wLaPZiKXBI4+ZjJOk6ytmo2qP7/Nw8DPUj/VogyKAiF6jjpK4Uylo1DdOF1aA1AgUltq4amZDtDLtzPlrSelUhQ00vLTlgcvlro1a8w7DDsurnaDph5WtuQ/IZIrfJjtHz0yH1GWqB1HzeS71DdePGUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 13:40:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 13:40:06 +0000
Message-ID: <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
Date:   Thu, 14 Sep 2023 15:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To:     Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230914092350.3512016-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 851f335b-5a8e-4268-8ff8-08dbb5281b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ap5hB4dJGneVgOLRP9TVgEPHug8ttc+pe5pSzV+9MuT9Jl1+HkIe3ApNWMTYKSghMYsdG7QAlrJxWyT1DrSKe3e6LoySfI0B8pZ6tqdUPqe5qeBj8bMOE7LT51R1jfIYodZF2L4Gcrhz5yDfBxncSZwzR5VoXU7vKGwlzoGr3O/AKiSWR9IqTmjcKBwhEeSRbnXjcYahSzltgsfyBe2cx38fztKUvLD+6QWCEm9jdIrGNkHlsOyGYOB7NbxPx95BIlrQjcXi75KDX5DiUxHNImlVWOsNi6Pg4oLz/aJEdajvNOu7/ARXe+kvHIgFklyZ0TR7g2L9zcSAf5Sa0Aoa0NLxs/DLnmjbWHehl72qisStxltLzKOxavhF+rqyx7AHdMe5XJWbxdPuGnwRYT3ePKseyb7zycHMiV+ZyOXaVFKCF+iHLY5d6E9Rnbp+LvaGiiJyzgAznRbg9tG3MwHUd4D5h2FAzuBdyTRAgyKLwJTT2Kr3cQwfBodRAET8+gBM+1K0HeCjrqV67k8+ZIPwK0gKdBaqet4DTgMy4NMK94eNY9VCB2IyoGJChOZSpHrfM7+DoF3NdkfhhX7mjrcPulJ1b6+jHgpMl86PoRCa7baEGsCIqTw6f+grTbUJ4zopmeUuMczwZCTCxNHZkUg1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(1800799009)(186009)(451199024)(31696002)(86362001)(5660300002)(8936002)(8676002)(4326008)(2906002)(36756003)(6506007)(6666004)(6486002)(6512007)(26005)(38100700002)(478600001)(2616005)(83380400001)(31686004)(110136005)(66946007)(66556008)(41300700001)(66476007)(54906003)(6636002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhLK3JPNE1QMHUvU3lLVTNVaDNrUFRkT3JqTFhCQlk4cVMyQy8wMjJ0U2tH?=
 =?utf-8?B?bDFwWkl4bTVkRm9KMWxwRUVnN25RaWowbHpDaFlxRGgwWXFOdmpwR1JsVlhW?=
 =?utf-8?B?QXBWKzRIcEtkY25SdlNZZmx6cnhUYnRqVkQvRDF2bjdSbVZaYWlCYzArdkJw?=
 =?utf-8?B?Z3VNNEFjTXRoWkh0UHc2Qnl6Q1k1L1pWblg1cFpRcmY2OTJPbW9kdFF4SzlV?=
 =?utf-8?B?bjMwb3daUWFiSTlIZGZtWVJtSm05dnlQMjVMemcvMWZwemNRa0RvQStKWTRW?=
 =?utf-8?B?MFhUb0pDcFdqMzJ3STR6a0JzTTg2Q0YzdklvTnVSYU1yVUR2TC9aNDZldkpR?=
 =?utf-8?B?RjcxanJZYTEvVGNZUGpsL0g3ek9DTUZSbHRtdWtCdllaZG0wcVJ3czgvUm0y?=
 =?utf-8?B?S0RvQXlKOE0zTTd4NFprVkk3WmxkaDRaUTFRdDNWWjJ6bVV0RnNIWExCaXdy?=
 =?utf-8?B?a1ZaWlI5WDdPWFRmL28rcDNlayt5clEzZXV6bnhpa1FPbWp4SUlLMzBiVzUw?=
 =?utf-8?B?WkxYMmNrVGNDOGNlTHl5NWE0dE9VQ0VQamlZbFBiL0R5TlZtVTg0M3M0QU95?=
 =?utf-8?B?ZmZXaW1OajU2MlRVZHBUL05pTHR1ZmtyS0pHZE1lVittK0k3eDNHVkJpZHZs?=
 =?utf-8?B?NnJrM1psQzVnMUd1SXlvTjdBdUxKVGpmMVV4RENsdm85Ulh6aXFuS3VLNUZZ?=
 =?utf-8?B?MHlkSmxUcE96VktFT013c1ZDSnhCRi9KQlF1YVROemtaL0p4L3VPY2JxRGh2?=
 =?utf-8?B?eVU3cUYyc0RrS0FlSG1aVkNtamhwWFV2azdRVjFCWDRYdjhPc1FNRE1CMSsv?=
 =?utf-8?B?enN1YkNuSWVQNDMzVnNKTytTUlNPNE5tdVZMbXVLdDFxMmJva3Q1N2FITXU2?=
 =?utf-8?B?KzFid3N1bEFhK01jWnlZcXk3T0dvektOR3R1YUFNZHRjYmRIRFBUdHFSOEZJ?=
 =?utf-8?B?RVArVmlMVmVCVEV6VGU0Ry9USkRSbEZydGdCS2tlVGZzc1dYajFCczhjaXFN?=
 =?utf-8?B?am9WRnYvbzBFRElOT3VqNzV0aXF5alZlODE2RWNJMzVCV2lqaDFzajVLMGZI?=
 =?utf-8?B?YzNFN1pPZzdWQmRmeXBDRlJmbjhjNTFHR05zaVlMUXdYOE9CYzdQdWlSUTFB?=
 =?utf-8?B?NzYyVjBFZkk5MmhxOTJOYnlHcFM4aXBraEJ2Um5mVThBRSs3c3ZOYkJ4dStq?=
 =?utf-8?B?OXB4SmRNZHNEZnQzNmRTNCtuWFFqV1YyVjhyOC81ZGRkaXROeitOcDVDVWNL?=
 =?utf-8?B?NlcyNkE1aUdKeEJDM1VDR3Fzc3ppcXdPTEVHcHZra2EzYTFUL2hMK3hNREpp?=
 =?utf-8?B?SUU4dTlSaFNORDM3L1U0QTVFWkEwMm5GN0laREt1WXdnNjk2WlJhV0Vkdm4r?=
 =?utf-8?B?dE1MOG52UDRiRXZzTTZ6d3J1ck54VmlPVTd1M2xyeEN3cldLTnpaT1MveXVa?=
 =?utf-8?B?VzNsQTRUYXRYTXFzcGtTeEs0b1FZSytyWUhBWXBudmpYK3lpUDhqV1dDWmxl?=
 =?utf-8?B?MzQ1K0JIMnMvTkdsNmV5VkYvbGc3RlMveHR5dE5iWUxtNWFjczE0Y0RqSTRQ?=
 =?utf-8?B?OXBCUS9pOTd5cG5nckoyWTZoK1hHdUp6aVpGWnptMVYvMEIvekdjVGtaM0Zr?=
 =?utf-8?B?ckdrNCtuSCtZOS9GN3lnbktHbis1alpkQTFqZ1NUVEpZTnNUYUYwZTJzK09i?=
 =?utf-8?B?U2dXcHk0dGxoOVROR3JJMm13Q2tmb1FvM29IaU1ITWlhUGRwcDg3S1RFdXhS?=
 =?utf-8?B?M0RXeFpKRWtOT0RJcTVyUGkzaE91S0VKUjdNQ1ZSZWgxK2Z2V2xzUzhIMFVJ?=
 =?utf-8?B?NDZ3aUNYTUJXb2FUSVVVM3d5RFRWT1VLb3VPdHByK3VMdnpsZjBaY1cwcHRy?=
 =?utf-8?B?eTlxSmhvL29YMmUrSEVkeTBld3VObG9MRERQQmJ4Vmg5WnRKaWpQMmd1VitJ?=
 =?utf-8?B?ZjBLbTVqVEMzY2h3NnhFUlVZeGVRZnJwajh3ZW0rU2w4ZUFJUU9EWS9ZaitN?=
 =?utf-8?B?MHZBejlhUVE3OG16QVpOZjdSQjNxRWRqNTZVRWx3blB1M29UcHVXcWpOVFI2?=
 =?utf-8?B?U0ZtQUs4NHNNdXlnYWF3bGNDV1E2NGw2Zk8zMTZZQUQ0QW5jNTFiNmdNeDVn?=
 =?utf-8?Q?7Pn3Y0dDPZea+0bwtauGAzval?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f335b-5a8e-4268-8ff8-08dbb5281b63
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:40:06.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8vbZuWixkkKMhlQV2cSER1M7LtVQDuVFAPXnoVmyQyWEGQcV8n2qjG+PoNO+FXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Is a single legacy flush sufficient to emulate an heavyweight flush as well?

On previous generations we needed to issue at least two legacy flushes 
for this.

And please don't push before getting an rb from Felix as well.

Regards,
Christian.


Am 14.09.23 um 11:23 schrieb Lang Yu:
> cyan_skilfish has problems with other flush types.
>
> v2: fix incorrect ternary conditional operator usage.(Yifan)
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d3da13f4c80e..c6d11047169a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   {
>   	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> -	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
> +	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
> +		      (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0);
>   	u32 tmp;
>   	/* Use register 17 for GART */
>   	const unsigned int eng = 17;
> @@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	int r;
>   
> +	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0;
> +
>   	/* flush hdp cache */
>   	adev->hdp.funcs->flush_hdp(adev, NULL);
>   
> @@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>   
> +	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0;
> +
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>   		spin_lock(&adev->gfx.kiq[0].ring_lock);
>   		/* 2 dwords flush + 8 dwords fence */

