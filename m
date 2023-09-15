Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AC7A1939
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjIOIyK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOIyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 04:54:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A42715
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 01:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJTQa4GC/6WRhkzuxGjJW3DKnNUxIRNpcf9MGccVfU8Yci+ax/eDDxPsRwfLTDBOUE2VH83y4m3+v8hy1P9cDoQmU5584i6d2mMnWjlbUqJA77wRRemyUfkSRCvlrfxTv7X3iOzmBhY20Iva2p3mAWbDmcSoCciyvgF0POcohzN2AV3akmWEtmciGjjjdt5PB163G5OLw4ERe5R3jkMOavHyPckl50fzjbePLWHk/aZqoIiO9lU2SnKNYO+zoTx+XsP7HQt7O3rgo9M1g8exFJ090mWt7SU2WTGQzwqnVMUZjD86gaASeZJZdAyCU3h3nSqaF/wdvEQvM6gvTSOPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28aS58c5R6gDFoohf46C/eaU6Z3Wb/cSALBuljSYgd4=;
 b=lLqn7yxsJlefpp6IiYE2rDAtT3ub1vbJLJxSGuvN1VBB6jd5QRCQLdxXdjRSfSYRv1N0d1IkAdXYYWVUo7xAojstsCLAYSBHLVFotkbZxICHhv+d14kTPiLHW2NXIfhKHx2RQdECD9Q7mMGyEonYCCL4v29we8wDlwuXvTUr06EjyZLCTrRIpaDtTdXAPGjkIIt75rnb1fhKYqk3ZXbfJUJWFFR4648rzEnmGh23fHr2HHmcbsIia9+4XGXU+dEIxKqdkGs7Sh8jXzCZClmP9xW6wHYLJbsy82t6kD2xXd/n4W6t5uZ0M1iWlzIEnAWGrXSbp1lHIid/qAkrz8WvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28aS58c5R6gDFoohf46C/eaU6Z3Wb/cSALBuljSYgd4=;
 b=UmuPVYASJZP5cWoh5UtWGlztJSwmzimyutnBedAioIzNK4bYlFGehEF4T1m+O6F9u6+9dbSor7MBwB7jcrz9nmrv/30xzd4zYaBDmVYFuY7ht6pvLQebFi2kyZ5lph1lrfLUSlLHo8esACoi+QrKdkdc8DmbFyi95f4MiGzj/h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 08:53:59 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.041; Fri, 15 Sep 2023
 08:53:58 +0000
Date:   Fri, 15 Sep 2023 16:53:45 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Message-ID: <ZQQbmfuivo/F+b9o@lang-desktop>
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
 <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 970c632f-990d-4ab7-75a2-08dbb5c94c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXxlEfIhSNXI/FfcfpmOCBJvCv0qhqn1BPdmJODGy3RbNdo4BZAZx4wsm2O/uKsS5TldqDI4iDMQ7hgo9c++bGdXHAzGPFFZFbRg9lvwXFc324m05x+I+gq4aqouxq2liCTxdBZXcPXgiE4YsPVsOdvwpFcM1ITcJ/URnDXFBBC+tq8anXPE3xzA22c41n2GiWB1U7vP9NxTSQkn5NVr97CZrbhBQqke0hghSfWNVirA0bRXvAC6TGCFHWZrQHEyQM2h9GazIelJoRTzOAP+wW0OWKwRhDfaoHgyPBLJjM0hBWKwKjI/Xi/kfn03EfyRpTukQUpIbt1PLdBeXgaoUjCw//2AMNs8qu/wSoXuJCLEj+kM/nhWGT0bnBMu8tzv8UXnUxPIh/+mEBscv9S6nVBsmjcnIVpDdznCLVAPJa/tZi4UmAzG8eJ+6EiQ8YFQb15PW2y2QlwBcBimx0NypTvQdfO2J2znvJ0p/9rEHss3c6wMBWyzxyYrEtniFh0+C3vqYSDs/NjGsZubqjFO4gtOyerSgVD1kFUCWa2ZXosrHU8HKQn25lQ96o1eX1io
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199024)(1800799009)(186009)(66899024)(6486002)(53546011)(6666004)(6506007)(38100700002)(86362001)(54906003)(2906002)(5660300002)(9686003)(83380400001)(478600001)(41300700001)(66476007)(6862004)(26005)(66574015)(6512007)(4326008)(66946007)(66556008)(8936002)(316002)(33716001)(6636002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JeMV+Rhh1iGdqGExFBg5LeCPhV0JcL3Fbi807jvc+N9Dzb0+qVZWPaKH9U?=
 =?iso-8859-1?Q?ASAhnBmEeMauM7dU2Bji2D7wLfBYLp5EtKEuzd6Oc73aYlq5M5QWcNU4Gt?=
 =?iso-8859-1?Q?NgL2flOPRa9K62ZAqHVs8Hzaj7W+iylvj20PSuF066UG3HytM5Ut/1CZuW?=
 =?iso-8859-1?Q?ArPgZalhiw4VgZ6Z3766Uc25kgYaxznMknQgWq0F+SpEA86QPhTZzPfP5k?=
 =?iso-8859-1?Q?85fXMBa7ikotAhHyHeXl5enoIXP2Ppyknj7qPMzB+ruBjECTd3HM2Q5XYf?=
 =?iso-8859-1?Q?56gkmFVyrd6cOyGofDe3+l3mFTnD+HrpSuqn/ZixVEoKl7euIw4qvdTfoz?=
 =?iso-8859-1?Q?TDRp+jA3eTlPrTO7gwLGBPxYI353FeMg1mHtotzDOFm/dcrTtYs5Drmqo1?=
 =?iso-8859-1?Q?xcn8HOqGBpIW/1E5ArbNr+2n7KIMYQS2uAfmNeyi4HIu7C1H0Y+kkrO4xA?=
 =?iso-8859-1?Q?WOMzMyCOwaGJ1t9dtezdKU4vz9zlRXezc17/oJa1ZfSZh4Zeg84C8vxe/L?=
 =?iso-8859-1?Q?s2pn2WGC9USF8bcB28k7OBFVq1WcCeI3kmQnUOvsOv/p4Wc1GKfmBo/y2h?=
 =?iso-8859-1?Q?Pz3JZyHYdEdPlwyEg6Gl0Rvu4urA9iDH+izvv7IUCeBSJAEhYqKR4jmArw?=
 =?iso-8859-1?Q?3s/5dyfsgKxUWTc/KD73l7GhK+H6vHvE2rtk8SrCl3E0CL0tEI7HrD1CZr?=
 =?iso-8859-1?Q?D7TC0dJhF0rR6+ZdT/g1mTyHtGocEwSatkHgAJEHiClkcbeEOfN5CzTse6?=
 =?iso-8859-1?Q?MeHYpIkHT7pBMNy2YHHq845c5HPZ5hvpz70Q8GhOFhNUw7EaMt9+r6NCpU?=
 =?iso-8859-1?Q?iWkY/xQtpgv71PDawETwmiY84sIYHovz565ghhtulVhDEMeVBLCPO0jVf/?=
 =?iso-8859-1?Q?WpkGalwxopSxYE+Lr2MQrFOOBfnfkWxljiz27VASDezPqbys4LKHHGMH8/?=
 =?iso-8859-1?Q?U3u6oBQkPqYXRKoff+eCPl668yrzGRax3RYOm/lFiqNmh21LSdUQunwvs4?=
 =?iso-8859-1?Q?VZMw1UpwFyGdx5maaWOelEU8LVR0MXOqTEA2yLXbnGLemEgi/nkePWZKgC?=
 =?iso-8859-1?Q?f+k/Ij4fZd8KGoH7HabFVr2l25NnGOwNCMKX39hWVeb09WRMm4JDeix4VG?=
 =?iso-8859-1?Q?Cp5mYt5C31JJUjYPrBADHaWGJRR1JerMMr9lLJDZRgUkWWcEAW/FZPy7u1?=
 =?iso-8859-1?Q?0jr0TEjoC9LSx0pKcFp9O4ziozc8fkEplXaZD2oF11H8oIOIdBY7Hw9H7r?=
 =?iso-8859-1?Q?tw7kxLWhN+FrBz2lzhKL8lI43wd9Xmnx3WhScy9LXdZE1MLLbhO+6VwIdM?=
 =?iso-8859-1?Q?26hkLrHAih57pifnvfI1AcMGqscfp5T+JLretOINqpQ6ByDEcrI25mWurR?=
 =?iso-8859-1?Q?qL+m3qhBuxuXwFjAUutoKseACUxvb1emYC+BUDZ1r3LZggjGqZaLLCOmHN?=
 =?iso-8859-1?Q?01e1Tyn9Zq/+7JWtDtsHEl7AwSahBOqyTca1TxGZFd/112pOR3yrec1xdi?=
 =?iso-8859-1?Q?DqnG9vHbKstsGrZRVwhn1DLHCux5VPWfaxD1YzM+w43sQKuEF7Z4YcLBt0?=
 =?iso-8859-1?Q?vzJeCMUvQgZTdrh1zPSWEbt6VKJDIXKAh3d/Em4hVRibqgiw2s0FIIgGqF?=
 =?iso-8859-1?Q?YZa6BRrpznkE5Skqb+PfTgbITHWGJi4Zno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c632f-990d-4ab7-75a2-08dbb5c94c51
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:53:58.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6JWn08UIdZOo0ye6G42u7VsQRr1l5yd90+KIL9Re3hpsGgxTI2t84otW0smHQEBvfogo+NjygzjhsVBej7T4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 09/14/ , Felix Kuehling wrote:
> On 2023-09-14 10:02, Christian König wrote:

Do we still need to use legacy flush to emulate heavyweight flush
if we don't use SVM? And can I push this now?

Regards,
Lang


> > 
> > Am 14.09.23 um 15:59 schrieb Felix Kuehling:
> > > 
> > > On 2023-09-14 9:39, Christian König wrote:
> > > > Is a single legacy flush sufficient to emulate an heavyweight
> > > > flush as well?
> > > > 
> > > > On previous generations we needed to issue at least two legacy
> > > > flushes for this.
> > > I assume you are referring to the Vega20 XGMI workaround. That is a
> > > very different issue. Because PTEs would be cached in L2, we had to
> > > always use a heavy-weight flush that would also flush the L2 cache
> > > as well, and follow that with another legacy flush to deal with race
> > > conditions where stale PTEs could be re-fetched from L2 before the
> > > L2 flush was complete.
> > 
> > No, we also have another (badly documented) workaround which issues a
> > legacy flush before each heavy weight on some hw generations. See the my
> > TLB flush cleanup patches.
> > 
> > > 
> > > A heavy-weight flush guarantees that there are no more possible
> > > memory accesses using the old PTEs. With physically addressed caches
> > > on GFXv9 that includes a cache flush because the address translation
> > > happened before putting data into the cache. I think the address
> > > translation and cache architecture works differently on GFXv10. So
> > > maybe the cache-flush is not required here.
> > > 
> > > But even then a legacy flush probably allows for in-flight memory
> > > accesses with old physical addresses to complete after the TLB
> > > flush. So there is a small risk of memory corruption that was
> > > assumed to not be accessed by the GPU any more. Or when using IOMMU
> > > device isolation it would result in IOMMU faults if the DMA mappings
> > > are invalidated slightly too early.
> > 
> > Mhm, that's quite bad. Any idea how to avoid that?
> 
> A few ideas
> 
>  * Add an arbitrary delay and hope that it is longer than the FIFOs in
>    the HW
>  * Execute an atomic operation to memory on some GPU engine that could
>    act as a fence, maybe just a RELEASE_MEM on the CP to some writeback
>    location would do the job
>  * If needed, RELEASE_MEM could also perform a cache flush
> 
> Regards,
>   Felix
> 
> 
> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > Regards,
> > >   Felix
> > > 
> > > 
> > > > 
> > > > And please don't push before getting an rb from Felix as well.
> > > > 
> > > > Regards,
> > > > Christian.
> > > > 
> > > > 
> > > > Am 14.09.23 um 11:23 schrieb Lang Yu:
> > > > > cyan_skilfish has problems with other flush types.
> > > > > 
> > > > > v2: fix incorrect ternary conditional operator usage.(Yifan)
> > > > > 
> > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > Cc: <stable@vger.kernel.org> # v5.15+
> > > > > ---
> > > > >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
> > > > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > > index d3da13f4c80e..c6d11047169a 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > > > > @@ -236,7 +236,8 @@ static void
> > > > > gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
> > > > > vmid,
> > > > >   {
> > > > >       bool use_semaphore =
> > > > > gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
> > > > >       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
> > > > > -    u32 inv_req =
> > > > > hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
> > > > > +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
> > > > > +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ?
> > > > > flush_type : 0);
> > > > >       u32 tmp;
> > > > >       /* Use register 17 for GART */
> > > > >       const unsigned int eng = 17;
> > > > > @@ -331,6 +332,8 @@ static void
> > > > > gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
> > > > > vmid,
> > > > >         int r;
> > > > >   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
> > > > > ? flush_type : 0;
> > > > > +
> > > > >       /* flush hdp cache */
> > > > >       adev->hdp.funcs->flush_hdp(adev, NULL);
> > > > >   @@ -426,6 +429,8 @@ static int
> > > > > gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> > > > >       struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
> > > > >       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> > > > >   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
> > > > > ? flush_type : 0;
> > > > > +
> > > > >       if (amdgpu_emu_mode == 0 && ring->sched.ready) {
> > > > >           spin_lock(&adev->gfx.kiq[0].ring_lock);
> > > > >           /* 2 dwords flush + 8 dwords fence */
> > > > 
> > 
