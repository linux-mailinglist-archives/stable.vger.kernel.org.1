Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737D79FF3C
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjINI6g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjINI6f (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 04:58:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8898CF3
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 01:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doLn1QrVwhcZQOFl7IxtJrKveW+3spdnA4zzdmBWe9t/BIbPD16UzEet+4M1BF1GT9+i7SIjkuTxB5Z2wd7xkbkE+v1afEBZqgcS5FlVbIrX3dqg+L8vxzJpI25NwBwbxFpRfqz018FajRO0CGe2uElhf16724YLrkF579rWS/cxNu+1H2lIHdl0dI5D7fmMhFbbYoKOeBMQmx6jQplzO5sPJSDIJefFSmpLarLxWUJAJlBAhtzYBQPISaFbUcXnvJVWnPI/nBeNqMgR6KTaoOcyaOos5LW2avIC/JpuXWlTsngGakuVORwxwPFLK6egxJUJbBJZEc76N+CbQEfD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw2X+UMGNt6hNpQpxt6ALKuEMKDQlI0SdS7Ypl7SLdU=;
 b=TyaGRo+RvyGjuAHYrOBh4r+DxyruyBjlrhdAs9VUlb91SDJ05QNCQVYMfN39Prq/FLFlE2ytYrf08aTMIlOtj58rfc9HXBFdH1D2UyR+mLaYb/8EAkiZwXmBVbeKmCj3FHI3T8rGS3bceInJrSdrFJ9+b2VR5NiaZcIy/ikO1ZOtQ4RFXDAdhBmoFEVvQMQaBKvvstkgThfc9YT/o39KLhFWyNbgEOsH+1YAQQZJlZIfDQEbFAyZ65TaqVYZafca4YCz7XNtX3nvf7ukLbw7Z9pSJjs/Kol7Xqgy/t9ADMNJkP5cO01h60XUl8xNVRzK8vWDzqgs3eUzhEGcWVu+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw2X+UMGNt6hNpQpxt6ALKuEMKDQlI0SdS7Ypl7SLdU=;
 b=i9w+2ctVJELeW6sfiB/dliMMcxvacR9353NRzjBivIpixvzNuCU7Nyi5jEjDoIzMaS5vaej21QE+cThspwrBijRtAmFCCCazk3jS/lEO4ukNqIRIoyOyRIZMqOvs5OcYjq4p6JAzzDZMMkObIv7DmDdGC/OZBPS2Kdk7vdciyPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 08:58:28 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.041; Thu, 14 Sep 2023
 08:58:28 +0000
Date:   Thu, 14 Sep 2023 16:58:18 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
Message-ID: <ZQLLKgWZ0bugI4TD@lang-desktop>
References: <20230914065945.3508261-1-Lang.Yu@amd.com>
 <CY5PR12MB636949A47321FC9F16898B9DC1F7A@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB636949A47321FC9F16898B9DC1F7A@CY5PR12MB6369.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce2b6cf-5d54-49f7-4411-08dbb500c300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7cE7qfcyRjqIP2lgUgo9etXoxx4iKmlp14jIDYR+7D1KCKS1zP9i0/L2xMl6HvqVXNvTz0qrZAHAz0mVaQ8dHXuhf+d2tWe3kMBtBysUhpeIIMP6IOcx1Mt8RTCMbmcwpBkmhbujxBDChFHDZAPijHO4BTH/f39jC17H+xAnxdO9PVNgPtseebWnGlT+xUFOL2KDCLQw7bWLM81PoUS3Fi8VJqfjWAlr524yxDYtChAHzCaS6uf9daDk0VfHtucrJ93Gt8xpGOQ1oRAmflPngHci4sS9i4gZpjCdSb+V8ted90AsAeHnU9QVNUvO4Kv755ofEGGvU0EVHsLMdLcroTzrO2aREejHJTlllbktfbsQLdVfxIPi5PicpPm9ItEOrnDh5efGRwz2L/MdtwcTg5opFlb3y66zsgp5LQk64Du0JX/3YvaxXOrw1pEWV8JVibmv0h5VURAO1+VJbqlDyNdZkAQZ/gmj9iNv2IvkyBnSTDh9z1Pwd+qk7YPTyaivBJnGrcK1PHANxEQDuMVakrzfJUpQUOVQrA7cXIwHI2yicCntjMBjjiu195l38g7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199024)(1800799009)(186009)(478600001)(6506007)(6486002)(6666004)(83380400001)(6512007)(2906002)(26005)(33716001)(9686003)(66556008)(66476007)(66946007)(316002)(54906003)(4326008)(8676002)(53546011)(41300700001)(5660300002)(6862004)(6636002)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uq+umaiu2XMSDQkW4w5DJiZiu4HRNcphWiBCwMdZY6u9o3soo1U3nlK/zcgv?=
 =?us-ascii?Q?Sp2x5EgMfXKjz7HIigIN5Poht+5YZf8nPdPf+FeXoiNWyRgiQJAp+fiwSnvC?=
 =?us-ascii?Q?hfLoKAHs9lunH3khAWWs6w2swrNLzrZsYMHkNBhshzTVag0wkar14HIm/fb8?=
 =?us-ascii?Q?RKRtLCf8Abp4kP+gNAaXLQ18FgPb+dj71BfQbKYv03RjdvJqqkNDQD2Db6oA?=
 =?us-ascii?Q?9ITEvyRNWvcJpI85YpwOWD/OCpkShEFLK6D7IZS1pZxHkReDEevD3rBBng76?=
 =?us-ascii?Q?qayf+ZTEfOjFs2rb/ffadRgnsgVEa92ELPUuqvnh2+mFyUZ+UFtoxOtzMX2A?=
 =?us-ascii?Q?lz8k5nGh1hO05rmN/Fttlb7hKcokutZtG3K3YY/RC7FQXim3NToVH/IsplfM?=
 =?us-ascii?Q?cIhu9icbpF1kvhB4WInXBi1ZXlflcGhO9TQPlSnieg4etaJilU6E72RPyvb5?=
 =?us-ascii?Q?qQwEkgQri4Pg/u2yRyRDvV/Z7rw6nn7fJb6kbKi+i6ecdVAiurbKD+tdBQl4?=
 =?us-ascii?Q?p9qIC8x4DiytbI1L3+sh0FpD7D/dDF/H8GgGUkIPpzmU1sTu7sWMkUpNM8bR?=
 =?us-ascii?Q?SisFGrhosJn+zUJotYdNqJpxeaIOBdVcCJamsE/RZwmOAn0eGsbE+r8RAuM2?=
 =?us-ascii?Q?M2hyd156Fj05zKn0kiV4xqzjdIKZ8RWOLHRLQPUo0/YC2locrsHkJr+1M8Mq?=
 =?us-ascii?Q?nfhqf69XOynOj0aili1U5oxPLHpIk3nvIIMiELW2BBsqaVl9JLbE3BiXcNOr?=
 =?us-ascii?Q?iFkswJCdmC0BvHqWRrVOFpFfEenOEEIqVReHYiCsY1i5CkFyidKc4WLLmgqZ?=
 =?us-ascii?Q?3mQXkjBu+wn0C4KSQ4upBV6037ZSvITDf66LDInbFkjSlSG1ANFYN0F5l0jB?=
 =?us-ascii?Q?zIBJhuDjG9LXEZXNWVBskTSjLl0SlhoNLgpJUe6JVHOq3GOfbwIkvmGi85WQ?=
 =?us-ascii?Q?/5+UppCiYjOn3+eYxeMv0wPO8TY4np1Z4cvLs6B5DZL1D55W1VTKhNgCxXBw?=
 =?us-ascii?Q?V1Xr8ki4CyMAAivh87rzo1U8KQAnFqEDqZdBXaOeE1ms+lxUM8O+BMIC4afi?=
 =?us-ascii?Q?fQAxcfYs21L6HA/hWuYYZ/tjGIMFh5PXMMXECGa+RHjtVtHwbzyu1zK59KRz?=
 =?us-ascii?Q?qVzPNrI7HoDBtPqjDS0hSdP2CbtbCRwAek9naIGM6Mmi9WVBx86Sv3bZD+2R?=
 =?us-ascii?Q?7BJpastbiZ/W40sItkfbHAOCvq37jvTAAO3L+3V7ZguViQI8MxftarlKP5wW?=
 =?us-ascii?Q?mlwz37yMy9mFHl2hWKxg4jJq/VzDALpScb/YmWvKWSK0QT8VQxjPf4yDrva8?=
 =?us-ascii?Q?hoe15n5oF0kkOG7YWiiwau8nujyJuuhbS+a9mIlbJN2JHQ3yMM3vKCsn+jUI?=
 =?us-ascii?Q?M8O8iwIDdEMBTDbpq/dGRwh1t05aLu8PM8pxb6OmO1x7DSh/YdjlEekYT4GT?=
 =?us-ascii?Q?0zkwxOG9sri5djJvj6ZFMazxFOaA4+SH3Bqmp3tN0YVEPhc9Eqt8i0JI0nhd?=
 =?us-ascii?Q?RmiJOcUn6dSkidEvX1xdRteBB+ceFwbqdIqGOPn+7QGeUQRGVuUbjg4K7VcU?=
 =?us-ascii?Q?hHBDdmKxd/PXl5mUdgLccaRm1WO5Z4uaP/PejIrG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce2b6cf-5d54-49f7-4411-08dbb500c300
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:58:28.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWfZf2+iQ+ZgHv7qb2nz0x96ixv3eX9w0v9w7p7RW7pU3EUEMGg9tLeD0xbSauM/36IKvLnCNcY5b/Z/Bns6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 09/14/ , Zhang, Yifan wrote:
> [Public]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
> Sent: Thursday, September 14, 2023 3:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
> 
> cyan_skilfish has problems with other flush types.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d3da13f4c80e..27504ac21653 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,  {
>         bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>         struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> -       u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
> +       u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
> +                     (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0);
>         u32 tmp;
>         /* Use register 17 for GART */
>         const unsigned int eng = 17;
> @@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> 
>         int r;
> 
> +       flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? : 0;
> Should be flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0; here ?
> +
>         /* flush hdp cache */
>         adev->hdp.funcs->flush_hdp(adev, NULL);
> 
> @@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>         struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> 
> +       flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? : 0;
> Should be flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0; here ?

Yes, thank you! Will fix it.

Regards,
Lang

>         if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>                 spin_lock(&adev->gfx.kiq[0].ring_lock);
>                 /* 2 dwords flush + 8 dwords fence */
> --
> 2.25.1
> 
