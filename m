Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A879FEA0
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjINInG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 04:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjINInF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 04:43:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC642106
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 01:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIqIhlcMQ94PqAU7H9MId/L/JddCUtRObGDJFjNdm6QLrQiTwQ2wz3Yfz+HrTPBXJNUp4B2IaeIn0NadQgRxKgUI2P/kcSZIFWj2lTi9N88LKlKBOmwyb8PMNROgIVDg8KMu68iIl0nIZP7vzx+zwun/Kje7DTRgOf/GObi7D92qm209lm6sECn6XvMaFqaZ4nNnWL0asSXkhfSl3ebIaDqxwA2DvJZYMqRO7Ok95ONvasOSeoP1THtarVw91RDE4UmQTlgTfHu0HqR83kgy/WX1HT+rSkOnyWiBomDsz0xXdLlKkl1ABAJQr3huVqvnWX5aMnoXHkpCPwwXq4f/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I75ipq//7Eluz7AvoWU7OiObSTRvrnXOu7j9iUU9ng8=;
 b=Lims10gLTuYDStiF9EvbAvpI20dmPTX7k1+Gq4waUvbWJjuiqDHacvWi1MsXuJrlYaAldAhF37M9TJ9NkOMdkkwxUnnUkDI8wQ8oqK3hG5XMZCD4yDPA767PdvGHMXHrezGar0The7p2AS618H01hiLTTSh8mZFs7hlcCAS+ypaAjqlUo2nFgEvOsJkl62NhTctuJACRQmabKdNlf4lxsPXMHzVrBPcOim3FcN7iS2F3o2Ex1HZZc/1cdroFc8aJKe3zp5cNn01repg9/DyNELo9pVXEle4xTdQRkqnmzPZZ2wqKZEE2MgclsOnmuZuF6C4osC5K4uw0oUo+3Cgsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I75ipq//7Eluz7AvoWU7OiObSTRvrnXOu7j9iUU9ng8=;
 b=TUWFuaBtsSFn5hkozmWNA0YDROFCGSacK3oKssh1K+Lg6jUoDZy4fgqnZKjaxX1jpFPpPwgEC8lRE2+mgrecxDqmB/37lmAOQJs4DXZ2LJjpa1uV4gVvAA/SLS5jqZ1vznmy2HKea3BM4w7fAiLXht56T+rgd23XIigfzj4RDrw=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 08:42:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:42:57 +0000
From:   "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To:     "Yu, Lang" <Lang.Yu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Yu, Lang" <Lang.Yu@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
Thread-Topic: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
Thread-Index: AQHZ5tkaOp1gihH/jUm6k5l4Iew2FLAZ/vuw
Date:   Thu, 14 Sep 2023 08:42:57 +0000
Message-ID: <CY5PR12MB636949A47321FC9F16898B9DC1F7A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230914065945.3508261-1-Lang.Yu@amd.com>
In-Reply-To: <20230914065945.3508261-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4a6f00de-646a-4816-9c1d-1c3a7ece656c;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-14T08:37:36Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB8180:EE_
x-ms-office365-filtering-correlation-id: 99e8fa20-8263-4999-ee08-08dbb4fe9831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPGI0n64SIxIHxybso4uGPhxmHZ0eirQgUmk/oVVQ/YVLgGPqGdxzBJHw7iE0+slpMVCtXu5KjZJIG6C4Y5mwjHkXYZug7gmGudrEURw6i6Ns9PBMHwxCBQpDheQDip4gC4pwqQmMwjaEBz0fvZQCQvwBJXSM4usXEchdREk4rorNzi7m46UR0lxJKoIysC8rHzxTHmoGVbr4jWihAvSD4jVYQrxOs5Abi3CKHZ/HBu0vEYmQlbwRifiSm4+ymhVnweUaHMsGjhgzhmZfxF7apYW1BOsPL/ary1D+9Ge1U/sh8amAkCnTQWq4AN1tO4UN2HsoEzyPzWnri6WnX0v5jkolufOheGFlYzgn3J/3lMGZOtRNoTC61ojSkTwgwmMstos/ye+bN9zbyurkalV/x1huj42ZuxdUCXwRLHz/hvYrfKty6vYwCe7RZHQh9twxe/qino8L45JfwrTVT+Dcpx5ui10jb4A6f2pYSRZuHFu6ndakqzqVlpbpnrZv9exYbF2JqSV7HMZdQF6tdzSK+mhKQYHo+Hs5HX3RdGclvQo6gtagJhUhh3Ph1HuHY+I/fhyT95aMji2kqfoU7jBZQ5afyX2vfiLy+NL8+2iEPiV+XnUBle8fTNiyzO7yoBB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199024)(186009)(1800799009)(26005)(55016003)(83380400001)(38100700002)(38070700005)(2906002)(110136005)(8936002)(122000001)(33656002)(71200400001)(478600001)(86362001)(41300700001)(5660300002)(52536014)(8676002)(4326008)(316002)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(9686003)(54906003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTuKxPynDpMsMniZAvqSmjtG1oInb4c9VriUYBFcLKbI5brugMPoQfnCFz4K?=
 =?us-ascii?Q?wrYdooF6CIKmo9kN9eCj9ouETxBdENXAtidXJWpskh2AOZH/e0u9fjYwz+/Y?=
 =?us-ascii?Q?9VtToFleby3gQYg4r46sRhgZls8P0SPWHrntuCPsbeE56Mmphh7rNBRzasjq?=
 =?us-ascii?Q?acsqMechDw685hsAgwMRBmLGrP5+eLeMid9cjbppgyvIpMpmIevYDyxfHcnu?=
 =?us-ascii?Q?9WLfVhagBFoUY98pcdMoTCCmEmwsAENS0bP63jkBw6UcRaRqERcpmHpPZP5q?=
 =?us-ascii?Q?44wrHvT/bFDPCy1eenweTqf1PrFoPdXlAGF0C/dY6E6j80tbZfjjwKb30UWO?=
 =?us-ascii?Q?EWoXB1A425B848SWkTw+f76+Nnvi6PLIJ1ngmCDReV5oKwCCDmRmj3SIpsOT?=
 =?us-ascii?Q?T1Inxy6kNDJN/4vopNB0oCI3qfmx/CglH1aIX2kKZ+eUYkS5oWgPTku9mW/x?=
 =?us-ascii?Q?Agvn3Sy8ppVEJ3a0yDsVMmdOZk+7+PYBUctq8PLSfUUHbKSF5WJRPuPnx61L?=
 =?us-ascii?Q?+tmi+7QTxgereCofRt4RbJTA5TFFufzsUFvz+DCm0uOgJyXY16TX2rGdhF5B?=
 =?us-ascii?Q?Xqfeljc3XfeyocZhtmZSn0NYNLDK8y70Q8V29cM63wywvkcN754phlFmhw3q?=
 =?us-ascii?Q?uhL/S07rY7uGVc/nGREf2lmZWuFsyb4nE/BdF9Dr/psY3JaraDbty7x8K/oc?=
 =?us-ascii?Q?oXwYsPk95vk6nH41zzeup7E6Jyw+UIgHL1wGzJPeiA3IBGEL8T9KDny5vhOc?=
 =?us-ascii?Q?Xn5h0frD3SV/oCRc05p3IZ6UiOJs+tn14KWcH+IdDresVKP9J0W983315ySx?=
 =?us-ascii?Q?P9Yt0Jm6FpSturz4hVs1DjT72aNw10s3HjNMsTBaQY7mjP1Q/JwQOqex+dQc?=
 =?us-ascii?Q?prDykqZCgUP6jc/UptEB6/l0HWNLAhILwv9bvv0Z5bGz2tdKkVKUXziWUP3r?=
 =?us-ascii?Q?MdyC54sFgRvSSEmq7hXbpCshRVD6TyH5NgL0kvwARL0BQ9/LyBAJC9hvmAhv?=
 =?us-ascii?Q?bShTyvDLyftT0dvn9hQROa9ld/TujycJaqCfjoRrLHwJ7WQ/n4y3WnXDM0kW?=
 =?us-ascii?Q?cGqm9ceuQIhmrFPpGrJwwMrt5tR9X82AEjg8FopSg8QFcQE3wf7hBbDXtlrW?=
 =?us-ascii?Q?VqLDcL5mUu7kcpFW7MGeBZiTubUIg20rIu9PB2GzQRnJYZ53rxHXNpV466fX?=
 =?us-ascii?Q?wxbPH/WUUaxyzUzvkPXUN+EMGxrFHJESt977kY/rMcVQ9G4wKEkKUmHLKDEs?=
 =?us-ascii?Q?16WMQsVmBjTJEnf2c/xlTzeQB1g5BbL7CINJWBuhmHlWsbzi/8g3p2AWC55v?=
 =?us-ascii?Q?OgG/TcVbNvFm67gcPRNI5E77l8bQAs0RbUCcLe/Ss1XxeLP/I/sf2Y/L8VOn?=
 =?us-ascii?Q?Zl+sG1gSEjnD3ZN1J7U1G2llaRF35M+yTBjjtXjFjxOJLSJYFo6/QWvrt8eU?=
 =?us-ascii?Q?6HMND37OJ669k+PmcWQ/B3j9a5G0HF9BheoOG18d6a2ejyv5+NbH02XozPXf?=
 =?us-ascii?Q?et86ar+MStxLr/+KJzuPhTJQkYAagFws6j8TeJh3DftGO5BcbNmGlPff2Kxu?=
 =?us-ascii?Q?1d2+ClokWph9DLVqE4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e8fa20-8263-4999-ee08-08dbb4fe9831
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 08:42:57.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpdh4ikOXBU0BzvS3/yFbFH3EphPBbobwzHPlGWglNWtbdE9zz5c05WiB2bdBBX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[Public]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Thursday, September 14, 2023 3:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Koenig, Christian <Christian.Koenig@amd.com>; stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish

cyan_skilfish has problems with other flush types.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index d3da13f4c80e..27504ac21653 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device=
 *adev, uint32_t vmid,  {
        bool use_semaphore =3D gmc_v10_0_use_invalidate_semaphore(adev, vmh=
ub);
        struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
-       u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_ty=
pe);
+       u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid,
+                     (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? flush_ty=
pe : 0);
        u32 tmp;
        /* Use register 17 for GART */
        const unsigned int eng =3D 17;
@@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,

        int r;

+       flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? : 0;
Should be flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? flush=
_type : 0; here ?
+
        /* flush hdp cache */
        adev->hdp.funcs->flush_hdp(adev, NULL);

@@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
        struct amdgpu_ring *ring =3D &adev->gfx.kiq[0].ring;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];

+       flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? : 0;
Should be flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? flush=
_type : 0; here ?
+
        if (amdgpu_emu_mode =3D=3D 0 && ring->sched.ready) {
                spin_lock(&adev->gfx.kiq[0].ring_lock);
                /* 2 dwords flush + 8 dwords fence */
--
2.25.1

