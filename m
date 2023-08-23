Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D807862BD
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjHWVtd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjHWVtT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 17:49:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E86CEA
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOo82vrj7n1f/YtnhsAoJX/wb6ogKapmuXnBPIv1R48XUH8IjsIsg3wYD5qJNjwesuP7u5tG0UX8unmcJJu2wTZYypIcK7wvf3ofnk7xdDahlQFF/RmsO6LcWziathKHbyeD+755j2Nf75SqKOwlYZLa2G2mEcrlt0euKZr+nKTpHSyCqBuoUjG5YRUToxXTLsoqG+mtl0yGcxQCcooLujSmllDp0zEEtC2jsmW5TVusd++0h3ifH4irYnz4JiM95qzzNnwt7u2gMfseG4YUo5QlqPPTSu6c9i329PKCSb7Xl/dno5UbKM1VIOFeLCHQ+JrPuTZGLS4pAUC21CDzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOY3MHdovxgIrd6oRg8q8DQF1iDcnqzhNTDoJmBsfvk=;
 b=HyPDkA0JAf+r151nF1ogOq6bBkWIvwTAJfyf/HkXRV8186EOGTGTmYyR0hbxCYd42PUeqsbmktE23YkjuIv1PIz9yx9pyOfT6SKgFamVxA3bvaKuXt23yXyS6ybeTBd7fyi/AbzNib6rjRnsEOpLd9Z9DFSZWEQKW8mfLJeE4ulCUwc7Z4H0LGAqmu1IkJXxcXFGbYeqdCAWaOypO1E1UCJCMqh83+CKZJ9OOJJusN9Sr0zAn9YnIjHRU5CN1tkSHdhwgGPFeFo67b7NnZafSKC2v3gywb0dRVpGWkhaSSstnHmdGssbfDOKUxnD5upBOkN70oUpFVqI80dnooStMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOY3MHdovxgIrd6oRg8q8DQF1iDcnqzhNTDoJmBsfvk=;
 b=uRdw6s5j2ml8z7CapNa/ZykfN12hzs+b2ggWXLY/HiswAw5UJ+esNACmh1IYiHPsVB56uoVS9LsPkEuHH/PkdpwwTaGA50ZuS6nCDqCMEv5NyVYmj2Fv1mSWO1Tnp0z7CU93MrXQCudsGJCbFrajcTL2mRc7HwvzYhkqUNs0lq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.26; Wed, 23 Aug 2023 21:49:13 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 21:49:13 +0000
Message-ID: <2c8e63ea-bf5d-4ecb-baba-e1df60b46cb5@amd.com>
Date:   Wed, 23 Aug 2023 17:49:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: register a dirty framebuffer callback for
 fbcon
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        stable@vger.kernel.org
References: <20230823214450.345994-1-hamza.mahfooz@amd.com>
 <44226172-b1b8-42ca-9e9f-0fe72399948e@amd.com>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <44226172-b1b8-42ca-9e9f-0fe72399948e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::28) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e16a20-20f9-429c-c3e3-08dba422ca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2rWIAYVNWbdov2gxCZFBBjIVW+UGi8LEXzx3gy/acM8ijlTocDtDduAULI7lCE04IGxtR34Ht4sbsxFf/4x2ZevKHTWJWWSU6GMXivwrzISRiGJqdRpJbxHh0OHM7r7xsvIbacgsaQkthFx0+o5m/Q2jefiFzXqBsThiYXnmS4Sz1X7QMNo4sPiOG6K2FsQuCXlueTrDkbvr8+lz65UWOYIAUnZ9GILuewotz9UAvxSGH7K6w/B2X5sJ3xpEgRHq/ERWbInWVETf5x4usEZh4DZHqJGd21XAuUYxJpaX53FAp0yYVORLuF9IDIX1CQMSQo6TOmG+Jy3tCFmCsCpvJGOo6XKBoFqaeOKNZCTcDHZkrWex1ShDlxRtK+z8WgKG9a3ULXNXDeJW0VR1U5XnCC9om5Xp7dSoj9IfFPHUHy/DLM5FsTjy6nQswob79RBZ31bPpfxfmXYg6859M0YWtKQP73BymO4l8+GZGe/ITuYp/db0oGmfh+eo073S3klBNfg5bQcCdnJqSRfeTVqVLIgCAw1s86HiRMlQprv4I/FIg3IYN5oB7NMzHwIpUpjpck2eb6TlcG5K9CO8yLS2NsvjWVuNcAAd9ASN/A1yldM3A2ULSOysAZ1nVIHrRX75SXpqsoxvnoXep6+jXKpaNBrJ8cNaLXeBUM7UeshChaPzJnWxzAJMvCA7C4+uV/x99K7z1xyJBg+6muDwNg3vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(6486002)(6666004)(53546011)(6512007)(83380400001)(86362001)(31696002)(38100700002)(36756003)(26005)(2616005)(2906002)(316002)(66946007)(66556008)(54906003)(41300700001)(66476007)(5660300002)(44832011)(8676002)(4326008)(31686004)(8936002)(478600001)(966005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hVWk4yUldDaGgwY1lXeHRzNlo5ZmIzMm1JNnhXQmoyWDBYbjAwODE0eDRN?=
 =?utf-8?B?aEwzMytuWE9EY3pzVng5aHVZMTNiQTh3cCtkbE8ydUx0Ym1nenpZdjIzUDVN?=
 =?utf-8?B?dlhvOXBVM1V1Qm5rR0pWa2RieGZ6UFFId2VHYnh5aHNRRS9DZ0QzQ2dIRjdo?=
 =?utf-8?B?NTlhRzRhWElQaTVkRTh5Rk55T0JKay9XMHhGQ2dnQisvOElNSm55RGRFSUNR?=
 =?utf-8?B?VmFFQ3F3Z2ZyUXVVa2UxdVNlVUpORGtSK3BieEFEVlJkTmJxUkd5VmtZU3pm?=
 =?utf-8?B?enc1T1B4dlhRL2NBZ2RlYVlQc1FuZkVGdElySU9yRjRXcDRRY095d1ZoNEhL?=
 =?utf-8?B?ekhVdVNkMnZ4cUsxb3FLc0FpMVB3Vm5UY0RuNnRSUFBFTy9wcklzNkhjWmkx?=
 =?utf-8?B?R21OeVFnVmJGRlVlZHdRQ3ltVXVDa29qTFpjbXZuODZHa3ZMVFArVFpyOUIv?=
 =?utf-8?B?ejBtMURHSnlaczEvQmtsVnRMNjlBREtXUElhNFh3QnlHNGd5WVpJb1BsWEJ2?=
 =?utf-8?B?MmZNVGVjUGJHTG9kMEluQWo1azU0cE5tUGpOeXlzN0JIQzRyaFJTQVBVaE1x?=
 =?utf-8?B?RVNQVGdDTGNWMlhQK1NmYlg4SEVPNC9LQThLVlRURHl5SFBHeFZmVWVuWDBs?=
 =?utf-8?B?Q01EbTk5S2VGek95YTlFNmpma3ZyeklmeWsyMnR0MEhuUkNGQnFYelJNcWFS?=
 =?utf-8?B?RndXY0RKYTh6T3oxaVZjQWk5cnp5dklENHNQdlJndkRUa09ON3ltZ2tRZS8x?=
 =?utf-8?B?Y3BmRTNzaGdhRlIwUlVuYW1EdmFhSzNRZElFRjJtbUFCZVpCV01FV3hhZFM0?=
 =?utf-8?B?Yk9BbGNENWl4bVcralpHOUZ1L0JDdVRYU3JZYU83NDNGZjY0UG90THZTQ21S?=
 =?utf-8?B?bE5xVy8vOXpUdzNFV0xaVkdUbXd6bG5VdVc2cyt2OVU2aXNPSGUxTmgzaUZz?=
 =?utf-8?B?OG1UcFFjWFZ2Zlg0MUl5RzNmWEx4Yk5ib3BvUVJUbTdvdFNpV1IyWnFJZTcx?=
 =?utf-8?B?WVRLZ3Y1eTRMSmpiSk9DNmlzVC9UNDZ1RDJURkVGTVZiODZCQUNVY1g5ZTN2?=
 =?utf-8?B?V29PMURlNDBKaG9pa2xoV2RmOVRVUkZwcFhIQmRxUzZ3dUNsd0NZVUgyTHZY?=
 =?utf-8?B?WXBPUCtxeEQ5UG5SQklJZ2JRektEYnB2b3hEbTNoekRtYWZ1UTFjemNkanBR?=
 =?utf-8?B?bndodFhSR2V4ZWRPa2N6NFZ3dW1KeUkrNWtReWhnVnJQZlVCby9FZzRZckpM?=
 =?utf-8?B?QzkvL3l5R1FrSmdHczEwNDhkdnBZdVl1TzJNRVpYbWoydDd5WjJ4K3lDeGFT?=
 =?utf-8?B?bUN3cFNnc25WbFFZM3lZSEtvVFRlU016M1ZOOUpPQjkzTE9SR3JjQTlGb2xC?=
 =?utf-8?B?ZW1RdDFYRFNyLzVKYXZKdTVSK1p5NVFkVmlaSjY4dmF3ZlAwSDJIQXhkeFFK?=
 =?utf-8?B?ckNGcGFrYWQzd1lBSk1TM3NCYi83QWtmV2RJbGdkL1ZkeTd0ZlpRNGpDbEFy?=
 =?utf-8?B?QVd5MW5lMWZlSElPcFJQTHZaUXFuVUtJaFNLQjRIdGFDTzlVM29IeU9mR2ZH?=
 =?utf-8?B?czFmOS9zemVSVjd5U2U3Um1Ob3Jsb3NlbU5iT1FXUHZmQm84OUZmeFF0VW5w?=
 =?utf-8?B?cC9pS3NDTm93VE1UUnAxSmpoVXpOTm1aeG80K0xjQWVxUmZnQVNWKzlQaWFm?=
 =?utf-8?B?d2ZTM01za05mR3dUQ01rYTRQSkFydW54WjRIZVRQQzIyZjYwaDgwYmZVKzkr?=
 =?utf-8?B?b29Edk1rVzh1OXVtaXpyL0FyVmthNDVoQllGUEdGOHRiTzFlZ1NoMmFjTEYv?=
 =?utf-8?B?VnZWSllWaDF5VmpGTzdkNDhIY1Z5VmxJek9aSUs3TCtQc1hPK3QrMkR5Wm1O?=
 =?utf-8?B?c2ZvdzlmY1BzZm9OQ24wRG1rSUY1cmNWUVF3dTR6eUM1aUNZSHpmSnlFeW9U?=
 =?utf-8?B?L0tCZ3NtZktkQ29yQ2ZZei8vWnNzMndsSnIybUo4NmdYYnR1T2p5NmoyOU8y?=
 =?utf-8?B?MVZKakxDenhIUnRhcjhSTEx1N3ZCa1JJZkdGN1hISG03bGppS2xGR0pJanIv?=
 =?utf-8?B?REM2dHZ6TEU5ZEd0L3J2ZCsxaGt6Wng1Rk1DS00rcTh4RGhSWEt3QXFETVJB?=
 =?utf-8?Q?EMlcwMEOz/nyA+8qG21gwhhOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e16a20-20f9-429c-c3e3-08dba422ca37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 21:49:13.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krhC3Q3BwFvD6tR9FHuNvfNp5fWk82/UfreKGzoZl3RVKpV1QeXpgV6fgLuTqMCf836HBz+aBCTy20TnaA+syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/23/23 17:47, Mario Limonciello wrote:
> On 8/23/2023 16:44, Hamza Mahfooz wrote:
>> fbcon requires that we implement &drm_framebuffer_funcs.dirty.
>> Otherwise, the framebuffer might take a while to flush (which would
>> manifest as noticeable lag). However, we can't enable this callback for
>> non-fbcon cases since it may cause too many atomic commits to be made at
>> once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
>> framebuffers (we can use the "struct drm_file file" parameter in the
>> callback to check for this since it is only NULL when called by fbcon,
>> at least in the mainline kernel) on devices that support atomic KMS.
>>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: stable@vger.kernel.org # 6.1+
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> You probably meant to drop Alex's SoB as you bumped v2.  When committing 
> this make sure you drop it.  He can add it when this is upstreamed.

Whoops, ya I'll be sure to drop it.

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> -- 
>> v3: check if file is NULL instead of doing a strcmp() and make note of
>>      it in the commit message
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26 ++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index d20dd3f852fc..363e6a2cad8c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -38,6 +38,8 @@
>>   #include <linux/pci.h>
>>   #include <linux/pm_runtime.h>
>>   #include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_damage_helper.h>
>> +#include <drm/drm_drv.h>
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_fb_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>> @@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct 
>> amdgpu_connector *amdgpu_connector,
>>       return true;
>>   }
>> +static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file 
>> *file,
>> +              unsigned int flags, unsigned int color,
>> +              struct drm_clip_rect *clips, unsigned int num_clips)
>> +{
>> +
>> +    if (file)
>> +        return -ENOSYS;
>> +
>> +    return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
>> +                     num_clips);
>> +}
>> +
>>   static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>>       .destroy = drm_gem_fb_destroy,
>>       .create_handle = drm_gem_fb_create_handle,
>>   };
>> +static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
>> +    .destroy = drm_gem_fb_destroy,
>> +    .create_handle = drm_gem_fb_create_handle,
>> +    .dirty = amdgpu_dirtyfb
>> +};
>> +
>>   uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>>                         uint64_t bo_flags)
>>   {
>> @@ -1139,7 +1159,11 @@ static int 
>> amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
>>       if (ret)
>>           goto err;
>> -    ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
>> +    if (drm_drv_uses_atomic_modeset(dev))
>> +        ret = drm_framebuffer_init(dev, &rfb->base,
>> +                       &amdgpu_fb_funcs_atomic);
>> +    else
>> +        ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
>>       if (ret)
>>           goto err;
> 
-- 
Hamza

