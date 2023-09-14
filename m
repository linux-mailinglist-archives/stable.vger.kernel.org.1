Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DF7A00D1
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjINJup (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjINJuk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 05:50:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C03ABF
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 02:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqJ1YxJMdoRQn99D5B3+3t/NbNynpfD/IbTFp+Hw6CrrO7fKSstnTTDY9FM4SJGK3XxD8uy4YIDw30e39o77JboaPkAY4/j7fBVGu9VwbxYU0oW5SqGX/K6ZKQCp11H3s56ECaN+FIupN5bLvK04RsPUfd8WGxqHIEZffMegUoAqsTzamV7gPuEm0ZsoUq1RVFmgaiG43vL3AyZwYNXjCTl6B7xiv/W2i1wRk3JxqOGVtxA/um6J90lWpCo55mfaSIM3P9IBGW4QFRe/EZt+SgLHKx/XatMmdOm6/O969DRg8pDvL/lRgLAJksr4+U9Mlx4HouvEh2AO+X4uIgF5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR2dCe6L73NohUVsuPDr9Tvi3NtJAl03cLzO2f7u1AQ=;
 b=l4TKjV+R5Nw9dvc/Z0w3THfjpujCuSQOjrzO+cPYKlVQCsPVv76+heGoGMiqSkpDTzDypAgwc21u4RoQLHv2lWcN4Itu3WEj7ZCMn5+mLd8wDvg/GTbsTYThAvcegxcNsbfWY3nhoYrnaek3IiZzBfNTgzdDP9kqEONrZu2wjKRYeSYeOe3rDnRj6lP/Rjueyp3tr+uHtUgCiv316k6UisuObCLWW/gowvxzALMS8NtFNbh2nF1gIUjCexLGgAzr67jo6JHGMwOvrjiJoRT2Gu6pTiJxmnvSuRI221YxrUsQY9vPK/vRqvoOfuyn3lOgWW9PR8V2W8H8utClpynN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR2dCe6L73NohUVsuPDr9Tvi3NtJAl03cLzO2f7u1AQ=;
 b=g7A/oSCxm5KKZHLuGls3q9/CR7QYP8Vk2SP9RNnpqpEjra+9qhIEhqFUAm8OVbx9rmrNMMEUDQuX/vy3vcFkdrvkDNIN8awJgaqOm2DGKMD+HWX/mv7ksA23txOvjXc5tNfGwRgjrqAbs3eLv7gXvczgxndv/Nxsgw1wNi/ESKU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 09:41:09 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 09:41:09 +0000
From:   "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To:     "Yu, Lang" <Lang.Yu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Thread-Topic: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Thread-Index: AQHZ5u09jJA3kZdmF06mMj5oA5NLIbAaEOnw
Date:   Thu, 14 Sep 2023 09:41:09 +0000
Message-ID: <CY5PR12MB63695BCCDFBB75A22866C7BBC1F7A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
In-Reply-To: <20230914092350.3512016-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=48ede218-a990-4d86-ba17-2acc2aa98def;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-14T09:39:39Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5945:EE_
x-ms-office365-filtering-correlation-id: 747f8f8a-23be-4d3a-da23-08dbb506b9ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eemlui+8uKKL/wZ17dBO/p0pY7U97Rnn6MhJt2vcfSgmL0WMZuztyYS3Tssgp9hQmtpIP0e6xth2gO2Vq+xmUhEMcG8Frqy545A5QpMiqd6SgF97b6/2Y4IVe79oJUp5dwbMLtglVouoh3cUjKV+RDKmgKcDcMM8npvb/+pO5vc1w8eqoYBDerJU3CF12sZHeKjOuvYNEDSLxGSzDFnitfkID+7zp977Ald4U1XIwZeHK7BAK19KCdUuTh5Wv5RlX2QppdR0OTTbjjoKcuPmoUkpTA4IIZ8bubnmIvl30903HtxOuhAY3O57JhJbmjPSKnJ6hBAs7/oyV3NAbPn/bBoXd3vlhS3TBeZ83JR1Hh/Vs2yZr5Rs3e72sFsBRJ8DL0ZRliwugHPtmc++KoKAHBxUhoPjivgbK4zyraNEFtA2BYKcYdTuTvoiZO1FvUNXPXyQNgUTF5SdWXMSOOZgxUW06AgAs80B5sc0BpUi2Jd+fuSlj22eguuJo3xTuTMAL7UaA0rm/PvNElAguRYbBtYvntWI6SyL6g8Hp/kO3fTvZYI/sjzVLgerb22tAHc24u4tT3sy4vBhaPdrcCStLqx6OxorwTLdr7N9VSHaghnO8GIGuy63pvQWCccvkMFv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(1800799009)(451199024)(186009)(5660300002)(122000001)(6506007)(71200400001)(7696005)(53546011)(83380400001)(2906002)(33656002)(55016003)(86362001)(38070700005)(66556008)(38100700002)(4326008)(9686003)(26005)(8676002)(478600001)(76116006)(66476007)(64756008)(66946007)(66446008)(110136005)(8936002)(41300700001)(52536014)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/kWjGQo01ghO39MTCCyT7vXDJ/D2fbbyNvkhu9F4xZB76uZqXPexsitxSJ1?=
 =?us-ascii?Q?bL4prre/RoFYGgQ/dRhUtAusLd6hAZbLECFMa2W5ZZHLPciX9t9X8B45ZfFr?=
 =?us-ascii?Q?VzC4fXetto1LYogaG/xUDAzm66LNH2QxGoTdeJDwf3VYn00HpznJUtzcReeE?=
 =?us-ascii?Q?ubO9zWE3h78I/h+S53RWaiPoeORpnDPcvU0Dajod/EI94DFacukzVL+Exu4n?=
 =?us-ascii?Q?27VD3LJwJZ6vTbAktQ7awYyzlrBL4h55rOMQa2gyjbp9W3L0fI4AUJOOVR6f?=
 =?us-ascii?Q?ySHq2tidwDIuAlrD8B7ERNJxmB9Qc4GD0m8pjGgH2yodpsdtjAwq5CmsYsM7?=
 =?us-ascii?Q?QPDZk+7Y3haGX0E8BgnNSH4EgLDtlMAb09G/Ew168QYYlxVXbCuFuCQFePYL?=
 =?us-ascii?Q?fBwB/nb8SX/hbDztdxn1ubVU3ChckUlpbcFc2Z5rwX19R7LHomRLBsv6jFTf?=
 =?us-ascii?Q?n1nGmCxipk7hsMQbEJw/5dhONA3Cqkvf7oZuKl8OOwQ85JkGDRwIcrDaNh9Z?=
 =?us-ascii?Q?wE0hSH6tNjNgAU6wOfG42dfoKbnwjzDruxITDP6Bsqwa4dox0hAvt8KgoGmT?=
 =?us-ascii?Q?lxly6dq1PsBwpPrLeRl8v4CXdjaEWMF1v/aBCeWv74XDTCvmIvsEzwUv/sXb?=
 =?us-ascii?Q?yygcdxtM4Jp6r7qtcEMK3Q/ll7S+Gtb5d2FEDdl8KduivqP1tv+uyFkZIo/R?=
 =?us-ascii?Q?w4ycwM+BtFDU2ntmehFpO5+4lVWQzRxacG7pwltOKdVgiI4+DI4I6dkg5cL2?=
 =?us-ascii?Q?dCQSj3V0EqwKFEBkLS/WcEePGWZp5x/f3K2/9oULDRESQxJ4i8MjOjM002Cm?=
 =?us-ascii?Q?kdYa5Nc+jtGYiYvQQ6LvJYx99sZaN/6pPB+KiMRWIDj+WKd5qCej5KNqHxbQ?=
 =?us-ascii?Q?vCDQzdzXgZ9t3m3q4oooCJ32lzYD2L/svuDrgjAcQI/9oSkBLhlGeeN3xBms?=
 =?us-ascii?Q?HVYDTtzb6BUDS7U+SUvCGjRmHyRlzKMB9KdsjJhbKFnzjE78j/DHkF1gYs9h?=
 =?us-ascii?Q?f21PJiHmjwNPQZSfZNdfid0jQlB4FllSjKlEiL4RMQHFP6+zWjiOnyF2dGdC?=
 =?us-ascii?Q?vu09i4zR8FXt6HNiJ5donjKM2GbRNfwSMn+ZZAKeOJkc9iC3ZRBrSMfCvnIt?=
 =?us-ascii?Q?IsDOVrQ1zOLzz28y1bU1+pl0S6B1yucSf6twm8flI1wnJRHHmf08VT26T2bC?=
 =?us-ascii?Q?/Y4gYIyQxVb/1vkALlV4hafjNu4isabz5DTv0bBLpxt6yocq/vShNCZTy5Sm?=
 =?us-ascii?Q?QHIV4sGrcrmWGtL9/oRQQeZLXbzm4FZ84sizIl9w5MBFwNvZmxPmoHNFGzAQ?=
 =?us-ascii?Q?x7kp/D0fqX2aw/nhbDG9hd5LPJxmCDhA43XQutsgCKRTb72ek0Cu6ylnE3iL?=
 =?us-ascii?Q?I1bu8DZ/QZ/Sr1JB2BfZVXysljFGu1r90Ec5Xx44cPqZzQVXfR/jaDBy2cPT?=
 =?us-ascii?Q?w4XtSEZ6SgmN/nDex4cEsPwclMY/LOycLsPDeWT+8oRgBYe+EaVKink7igr1?=
 =?us-ascii?Q?tc0z2xHfU9EkRouvaQyC7SV1ehn3DAZRaI4F+m4UulYLNpijVz97h0lGI00G?=
 =?us-ascii?Q?tIVuo8f2it0ZmB88hrU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747f8f8a-23be-4d3a-da23-08dbb506b9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:41:09.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVY4eeYFGZMCUEGmTgzmK+ha5REcVacMKZ76XUxVrX0X+wb4xqlWO+L6my/7IADj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[AMD Official Use Only - General]

This patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, September 14, 2023 5:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.=
Yu@amd.com>; stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: always use legacy tlb flush on cyan_skilfis=
h

cyan_skilfish has problems with other flush types.

v2: fix incorrect ternary conditional operator usage.(Yifan)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index d3da13f4c80e..c6d11047169a 100644
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

+       flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? flush_t=
ype :
+0;
+
        /* flush hdp cache */
        adev->hdp.funcs->flush_hdp(adev, NULL);

@@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
        struct amdgpu_ring *ring =3D &adev->gfx.kiq[0].ring;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];

+       flush_type =3D (adev->asic_type !=3D CHIP_CYAN_SKILLFISH) ? flush_t=
ype :
+0;
+
        if (amdgpu_emu_mode =3D=3D 0 && ring->sched.ready) {
                spin_lock(&adev->gfx.kiq[0].ring_lock);
                /* 2 dwords flush + 8 dwords fence */
--
2.25.1

