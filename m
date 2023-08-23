Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572747862BB
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbjHWVr4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjHWVrw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 17:47:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3578E51
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 14:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxBFto8GaA/JejKDaKmVuViajypLi5KdThbsEW1zmyAnTA02gJDeMud1xZxjVClF31ze4MSRwZ7p6Bk4+txQWj/sYdYXiwnODT94sj9N1tfOapTXqfKPnOlGebFjgjL0KfjnbgZ61dlrXRfQp4qhsytAMW8hgatNRRW0ykVYKJcLZup1izF3oOEVuBOqMKsjtJaE6l797fSNAzOCm6bUh4fwnmfnOyP+bOX9j8/EzeNVb4NqVOOCsoKh0ZqH8+z3s4teIisiVIfjxMZ8GSZd3mIc4WckPAh3rVr5HpAb2zWwMtU+eI3XqMtGqB5lV41426AAM4JuEAiCW02OPCDVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/96UVp0xD9xgYEJO3A71IUQPfRbl5bXvEVNC43AHvc=;
 b=G5si0HcxBCPBG5Qpno6k/ppAEfVEUVq+m0OlR4Nbc2zqW77rhQ0al0rcGKPcs1eB8t1BDvHNrvvXylPwLbZ6tJGhy0KIoxqwmF8FbtxBBLLdpz5Iv05mjcOKbKSw8LigRQhoIIvx5iFzLf1claaUk0Z/Fo9G7Lo2k1GILACjc9TxwvOAhH0zxJ28jlqN55HgTjJh/6W9pSxAQ7sTkxrOlgN35P7t2Iq9qa8cEBlRkFXXKpIwbt8wulMYxBkJgmFD+cs3ELlxHx4USHunvRTxdD/ucCig1j+q87b70o7aoIT8GgBy5sMun1pDdc4Fe4rI/xYNLwrq82Vwp+9NWJlmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/96UVp0xD9xgYEJO3A71IUQPfRbl5bXvEVNC43AHvc=;
 b=QnWuHAw0BdVeErdx0ZHURK2rNkjknNPPV5vH8lCUusWaNZUElOcG4Oufsqhm49AUINSW6aYgBRfnxZ4kR/8PBL0Jr+PqdmGqUO6n1N2MpGTLr6uozDkUvylZywe42LYOHh6+ktPEiKAfNMd+dsrVVe00EVAGJoIKMQ03nQxsJUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 21:47:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 21:47:48 +0000
Message-ID: <44226172-b1b8-42ca-9e9f-0fe72399948e@amd.com>
Date:   Wed, 23 Aug 2023 16:47:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: register a dirty framebuffer callback for
 fbcon
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        stable@vger.kernel.org
References: <20230823214450.345994-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230823214450.345994-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0006.namprd05.prod.outlook.com
 (2603:10b6:803:40::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f051f4-f19a-4d4b-b2b3-08dba4229750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKhf4ejn57XB93bA4BtPn/vL9r7Gjs8BcWkqobdaD5UTeZWVxkrk1unbcj7l08m7XZHgRchN2xnlBAs0CD5dd5v+PETAHAfXIxsfdxg0/nXHTamYsPSO9Hk5Dup7vjOazHJcXV9jIpI0d5lCbC2xuLHfWnqi2RAW5LAif0PN+IUyLMkIOd5kiVMChNNnnSb6HvTNdS+LseDXCXaHI2dOACmv6svYHKzCF5r3xV1cmX4CQ7JY6fwfdWcpjzm95KFoHwS2CtENvbQcjQ4C47oV4/wFyW+PwdbBIhda/k59GIY6hlVCLTF4H1dm9UquOyncJmghj4tVFptGj3G/vn+4MIssDQDs0AtuliAayuveVtzUjfO2c+kdzeRejG166O4R/fmg8KPDPZMvsrv5kPl10tRdLLsJUVJQLV9aDI0hEBArSm9S/EfOM7Lktpwd+AjaJLZ+zx3ONfy+M3/gBLD6Y8UEL3I7jhpI2I+e7zbCOcn3G4V6qWCLq80vyeKA6UXYsOFhur1PArw+b4qApmA2CzxpZF8mEEMTVmm8Eu/vZSrOj6a59pYKe2rCXw9dTbkTU4lScxyUXpkzdvjSAt0m7KetykHKy+selxfv7x7tkZz/IpKUVUPQs3S3voxuyTTwVFkGNoNfwlmQ9h+M+o/5hW3nEnbikgk+wN+KYbwGG/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(186009)(1800799009)(83380400001)(8676002)(8936002)(4326008)(2906002)(316002)(5660300002)(31686004)(44832011)(41300700001)(66476007)(66556008)(66946007)(38100700002)(54906003)(966005)(86362001)(31696002)(26005)(2616005)(6486002)(53546011)(478600001)(6666004)(6506007)(6512007)(36756003)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdyVDNUVndjMmVJUkFnTEdoSDJ3RERqSTN5VStsdldGYlNxRXQwK1M0enlr?=
 =?utf-8?B?ZGdRczUwMVNlODB5RDRna1dIbjQ0M0UrQkMxRmw0aXI5Sldac095bGlIb2ds?=
 =?utf-8?B?Ykg3M3dnbFFUQXJQb0ZGOXdvUzk5eHhZK3AvTEZCaUtBMUhuNm1XVXM1cTFm?=
 =?utf-8?B?eXBoSC9OK0IwaUVjMXh2dGxrQ1h1YmJnVXVmVlRmWFZnQWhPQjRSWXFrNkZO?=
 =?utf-8?B?M1hhYW1SNzNHVXBlZzVVZjU5amRMOHFuZjUvbTJRSVNnRTRYVU5QU3FjOGFD?=
 =?utf-8?B?Y3A4bFplcjN4bVpZeE5SWEdnNjg5RUFwb2R4dll6YlJxczFRWDhaWVZlT0Rs?=
 =?utf-8?B?aGxTK1dwaG9oZ1plRUp5clZvc29xdHBPZnNtYy9SNWI3NjJSeWRYWWFSSG4x?=
 =?utf-8?B?L1FBZ3RWcE5BZk1oaWNiYTNsZm9MektjaUhNcG55SW1UVmYzUndlR1grMVJ3?=
 =?utf-8?B?ZlFVWkFMa2h5Wm5VOENCSWxHSVBaYTNZUm9URzVJcTBqNWV4MGNYMDlxNWFO?=
 =?utf-8?B?VFY4c255amJQT0FnSUlaK1NPeWRQdnIydm5MeDFFWU14b2s2WUM4MlZiMHp6?=
 =?utf-8?B?dVFjd1hQSGhEaEJEZDVxUzNKV0I0RnNwaG92bTduL0g2MVdpZW5zQTlRMk45?=
 =?utf-8?B?clcrUVNvSG9XWVZDR1VuVlpnNFpCWHhXUmJUTTlJSGtKWHRISWtuYmhHQzN5?=
 =?utf-8?B?eFVNL0J1ejl4dTNDVWdYRE5qQnpva21Nb1llU3pzRnhVZUhGZXpWeGhoUk9r?=
 =?utf-8?B?K3E3ZGxEMHNvR2dPU244TnRrNUtFMTJ2YW1wOFVCKzFTZzB2YklUZ3Q4TXFo?=
 =?utf-8?B?NVFWSm16d25TbDZMcHlVVlFEU1JrVkJSei9oT0syTmpvV1p0YUR0VnV6b3Jk?=
 =?utf-8?B?WWw4VkZwQ01reGZlU0d5dmZmQ0MrQWJOZkd2MFBCV09hbGVMeXhOUmxWRE1j?=
 =?utf-8?B?NWpuZzBsT1NRMVpPcWE1U1c1bmhxV2lHSGYvMHpMS2JJSUJOYVRuVTJOZngw?=
 =?utf-8?B?NU1GUEFNcVoybmxPZS9zZ3RpVkQvMHRwdjE4alNRcVc3YWh1QnpaV1gvYkdj?=
 =?utf-8?B?bUFuZ3hBRnFab3EyemlJUUVUb3VCSEVkeUI5YVFyd1RQMEpqdVN2SkwxcGRy?=
 =?utf-8?B?NnAwQTFCNE4weFJSdVAxQVdLa0FqdHk1d3lta2FiL2g3N0RHaEoyeXYvYSs5?=
 =?utf-8?B?V3ByanBCUHArN2RucWlIU2RNM0NzSTF5dExXVyt2UjAvT2tKUW43andhdFJv?=
 =?utf-8?B?STh2Q1J5RzlsSmYyYUNIb2JOeU5VbHhVclZSNFRVbzIvS0twMERvS2RvbXFO?=
 =?utf-8?B?UzgzS0F0SVZZZEkxcEtBMVZFVXg5TElVNUE1dlhmZDVJdENvdlZQV1RXVWx6?=
 =?utf-8?B?aWp6UUV6cVpNOW04Qk9TWWRJdHh0aDZsZmdmcHEyR3hGODJVZFNhL0pjMzkz?=
 =?utf-8?B?c21yTjdWaGZDcFNJK0IrdzJrTGptdSt4TWVLaVZqTnFVV0xaWStBbWVDRDNY?=
 =?utf-8?B?a3VmV0txandFVit1Rkx6S2ZhdGlZbWJxTVNtakpNbUNHeTA5RVZ1bVRGT0JM?=
 =?utf-8?B?WnlRdVZoMlJwRDEzdHBQeUZFTWJic2tjeU55UjN4d3ZOaG5oNk83S2k0Nmlv?=
 =?utf-8?B?ZkNnV01HeVJuTUFoblkwczhSVFNtdGdHV0RsQks5QytCTXYxeDBhUmJFbkFp?=
 =?utf-8?B?U0dHM1dOc3JrS09CZXIvSjJISjNQeGxpR2FWbkFjQUFmNFpldlRJT2JTbXNs?=
 =?utf-8?B?Yndta29aamw3eFU4TUtNQ1lpQ3JyY2JkbUl0VGFrSXR6QjViTVl2amhLYXNJ?=
 =?utf-8?B?YnNSVzhzc0s0Yk9FSWdub0dJWGtPbFZ6UUZDM2ZQV09zbUxmN2c0cUpsMEN4?=
 =?utf-8?B?d2dkeWRMTXdHc3QyeE1sU3g0RElhdTY3b0h1OEwxdWxWaGd6WXJGd1dpODlu?=
 =?utf-8?B?S3MxVkc4cTNTVUZUVDdnbnYrR2plTnZNVlJKZzlqOUxSek13M1pWRWVSZ0FB?=
 =?utf-8?B?T3ZlUTQ3RkY1QWxnYitibWsvSXQ1S2l2TkhNU0FHaWhpMHRkWFIzQ0VuS25Z?=
 =?utf-8?B?UGZwTkNZeUJXdFBnYVErOU9JUTNseWZFeXJzSk0wdkg3Rk9hSlpyRlRIMy9C?=
 =?utf-8?Q?N8p13RGW8cXs9PEVikDkTFFD0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f051f4-f19a-4d4b-b2b3-08dba4229750
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 21:47:47.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heZAbpFlZ/jzRwO8YxnrcsISaIuN/HrKpSRDxpvP10dIDMQaUbgjZUdtdytcz3u8ijdF5SQ39yL35aFH+LWAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/23/2023 16:44, Hamza Mahfooz wrote:
> fbcon requires that we implement &drm_framebuffer_funcs.dirty.
> Otherwise, the framebuffer might take a while to flush (which would
> manifest as noticeable lag). However, we can't enable this callback for
> non-fbcon cases since it may cause too many atomic commits to be made at
> once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
> framebuffers (we can use the "struct drm_file file" parameter in the
> callback to check for this since it is only NULL when called by fbcon,
> at least in the mainline kernel) on devices that support atomic KMS.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org # 6.1+
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

You probably meant to drop Alex's SoB as you bumped v2.  When committing 
this make sure you drop it.  He can add it when this is upstreamed.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> --
> v3: check if file is NULL instead of doing a strcmp() and make note of
>      it in the commit message
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26 ++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index d20dd3f852fc..363e6a2cad8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -38,6 +38,8 @@
>   #include <linux/pci.h>
>   #include <linux/pm_runtime.h>
>   #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
> @@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>   	return true;
>   }
>   
> +static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file *file,
> +			  unsigned int flags, unsigned int color,
> +			  struct drm_clip_rect *clips, unsigned int num_clips)
> +{
> +
> +	if (file)
> +		return -ENOSYS;
> +
> +	return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
> +					 num_clips);
> +}
> +
>   static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>   	.destroy = drm_gem_fb_destroy,
>   	.create_handle = drm_gem_fb_create_handle,
>   };
>   
> +static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
> +	.destroy = drm_gem_fb_destroy,
> +	.create_handle = drm_gem_fb_create_handle,
> +	.dirty = amdgpu_dirtyfb
> +};
> +
>   uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>   					  uint64_t bo_flags)
>   {
> @@ -1139,7 +1159,11 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
>   	if (ret)
>   		goto err;
>   
> -	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		ret = drm_framebuffer_init(dev, &rfb->base,
> +					   &amdgpu_fb_funcs_atomic);
> +	else
> +		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
>   
>   	if (ret)
>   		goto err;

