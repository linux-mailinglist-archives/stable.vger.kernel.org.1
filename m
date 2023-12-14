Return-Path: <stable+bounces-6724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71A812C35
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8111F21A22
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0383235EE6;
	Thu, 14 Dec 2023 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tg7oLTkk"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B57BD
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 01:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlvOzBKsnjvzb2yi0zw9uYnQREhboju5KnuiPFzb84njpGY5Ju4SuVnAvTtY/MDVDnS71LRw8jJJs0x3jKP0dtm3qxVHMj5nJj0/KlyvqYHpPyTR7/wY0j8yxSh9Ah4LPWV/in10rYArzZkOgRXIa97pa9jKVZCz21nAEq6dAxEd9HuJgppuAj4+341JDWjfcvAP3PekwI66E1FbPmMUs4jQujWuJ60m8MesBuEKHwmwZV/6mPCJO9dtDqdiVX2HGN6bfqi/W0eUhCjJNayob8UXsgsohW8Ly5K2NaJHFSjOSlxutEm/8YTFSVRtimap/5NR6U1tIKCLtQj1aD/utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ZSDRnewRIiIJhV+7sIYbodc095hxMwN2TOY5zEUvs=;
 b=V+e20pEsuKalPF7DDbZQz/9GwVL0eAy6gK+rcxlV99tt62gO/m/5mwm/ztOGVlxv673A3QD8iTtQw5/14+IETX+rJi8W3c/iEuZJ2Gj32zph5zvjyn7AmFGa3El/erz6QcrVEpqTGsEAPMsoTCnACoTbS0Ernwml01hWDkj72obaADuNE20I+2MOzHXO0ZxolvigqqB0xENPIQC4IblNRIiuVomrTpHmjz2ck9ZOllusssWf8oDbvXMdECjBvVNhiKUR6LU1YYuW0A0e6EfB1aRGA42XAgb4aRJw2tAauQwD4kIDA8OJA1t56rLe/nFVPvdqziTj5LoHQso3HEG9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ZSDRnewRIiIJhV+7sIYbodc095hxMwN2TOY5zEUvs=;
 b=Tg7oLTkkJ/KKiS92xdFmxoJpD6z6yIlqnNXLx5rx4dgTscpU4v3DzHh+IQUIoFgyR4C9d9qUyKjUW+mddLWa8yKaYDYRBfEPagHwzx0gnEpEpLFzYTlMOYx/m9jXee4O7UK9Ff4g6XRpwQkIiP14TWw7KJOLq01GhHuCGaX2waw=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 09:53:30 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::d443:2ced:8a5e:87b2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::d443:2ced:8a5e:87b2%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 09:53:29 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail
 to flush TLB
Thread-Topic: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail
 to flush TLB
Thread-Index: AQHaLgNdOkHoov/9PEOsB7ggkTMe67CohaLA
Date: Thu, 14 Dec 2023 09:53:29 +0000
Message-ID:
 <BY5PR12MB387371C0360A45B00A7CE838F68CA@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20231213203118.6428-1-mario.limonciello@amd.com>
In-Reply-To: <20231213203118.6428-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4755ebeb-76f3-45af-ac91-34244a1bc7a1;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-14T09:53:10Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DS0PR12MB6560:EE_
x-ms-office365-filtering-correlation-id: 6845ef1c-e766-40d4-92bc-08dbfc8a8692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CEUdlQuhg4VjAKM8r9tgPxtVqC8r9Oiz5VkJuWBxfvlBWIQpK7Gge+Lzan+th1GqMVLgH8n4y/+ymeOt7SvzzTVacFlhjEAoTZLNhzrjK0zyKo9+ISyvq4SsUgpQYc9S79V/TbqXa5UzG5eRLUE3PbfdEqEaKgkoGcz8o0xEKkpQz+XS4JBOLtuYsbEhOKnpsfWo0cz2SN4s1cH8wnCUAmIuItqcOnD2E7e/B381So5PnvblCFPARzXDCs6OF+UjRzu5FDJ8+5mKmCn9+cuCDz/NT6UcJlMi85JpJOZBNv/AL2Tr9pNMNWzTJ6dO/c7YZIZGbeX9wYRB/MSW6wVZgUP5Xfua3Nvc+FFPpThYMJE7pK7N610dsFw4Smv7yvmPlztdffu9mKSct70xw8XOBFOtMlz1L8DikVV3jZ86TPwS4Ag3s00m9pszHpPkmPYzhbPzciDI59HmEx3QA8UG1IdFjOsI6bAymD4ktfhocLtoF6pztxchPJWIV+BQgAWWsOoy6c9ESqDMWTW70EBaXAWwYg2tXKFkM6VFz0C7Ey1xdtsqb+wZChGyw5LLDEBI/0McWEibtvDBDg56+UTlWXDjT55oXF4mzcuFTEZCo+w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(2906002)(38100700002)(33656002)(38070700009)(41300700001)(86362001)(4326008)(8676002)(8936002)(9686003)(71200400001)(966005)(478600001)(83380400001)(66446008)(66476007)(66556008)(64756008)(76116006)(66946007)(316002)(110136005)(7696005)(6506007)(5660300002)(53546011)(55016003)(52536014)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zSpKtn5LHI8ZhhBC9HnAJPDD7A4Pze7jzMMmr0e64y98dTWCQDMNXNe1DKEW?=
 =?us-ascii?Q?65fZr3CKmW/f0+z2yleCn8B+JFr6K2FKzj8jI1xftxatKwOow+cmCxhn8NHh?=
 =?us-ascii?Q?vAy/gtmP7mUgX0T7rBAPo93XBXJ7pARshzWc2M5pe6dLpttw3wUKLYF2iK2q?=
 =?us-ascii?Q?k+1njeZaO06WJA+Lvnlpr4EVOkoDMZomjE0jSQhwdix6x/J9M62dvlBDSXZf?=
 =?us-ascii?Q?QS2G0ODI2qIxKPLbjCMxGKE/N07oAyEKUvVfahd5YkEsW8yeeIuD6UBQUCQU?=
 =?us-ascii?Q?m93+WV9hTRSI5b/ZBNflXuPHJP1eonBEaRvM7OQvHbkcdHeQdJY0KPsFzz3j?=
 =?us-ascii?Q?IpBVFwIVa9nZzR8OD5jWvt7yCOt1TXbVMo9ayhyho+7C4dHKMdfDn1HrH0kw?=
 =?us-ascii?Q?P/bb+6BwbzFO6F/BqGUBbBwpPsGL2mqSM0kyY/S22DXY27tiQMNI1fY+5Nfv?=
 =?us-ascii?Q?wyJTVyA6ujYvTda48x8TOJjsFB4L+7esSxJX70s4gUE0unrxmH7yS0burzw4?=
 =?us-ascii?Q?sR5yJxne8aL5Oy4oddJiT1bhC+heQgeX3NpmJ9NnJLlG6LHWzr+MpRdL9fS/?=
 =?us-ascii?Q?N80LuH5TKAsjSvgkbMmXIQ+RbqlFh2GveWS42DpPc9o4c01GygzmDS3NqUfP?=
 =?us-ascii?Q?2cdKSKyrvOZWqeSbCYlgQyYKXPZcpgMTD7G/wVWyUel9Y5wXYVmocC2ja1Hr?=
 =?us-ascii?Q?Kp3tw9hLjZc6NNORIqApQUeCdK9Gz1grM0pzHCb+VrwxiAS70l0zDZBWyrAE?=
 =?us-ascii?Q?43lpJ7c9wPyTrVKa0ghjgDaR8SdqPsJUsPRe81cp2GANgqtb+TVS3GgOVJVN?=
 =?us-ascii?Q?fw0+pa0bwY2Yf8kz0KZ0++qA3EgUV0sQQE7R0JBPDAwPAcZWf2BCMgVqpTH9?=
 =?us-ascii?Q?4KvQGqfd4migVGIrcg6kg5eCJDfBzYIHNOYTt0gnxkPzkiOw5ErpFGN5rO8p?=
 =?us-ascii?Q?K6gJcxy34CbTaK6nFbOrG+PZkcUKGYjQgqikgJw6V3q1Rl8ILiHd2nHdWJMY?=
 =?us-ascii?Q?z9Vz6IVjkk+X1F5+Env5cRI9ol4ZVZqcnJtcbFaU5UIftifoRAn/AS0qGy2t?=
 =?us-ascii?Q?s2wWyd0Ou2LNeohd56KVJDx2KPOw9JUHrzlM2AZXmn9DGy684gmsTIO1Ak70?=
 =?us-ascii?Q?p/vzwYor3MiUEuwWxIWGGAcr3qfycW/D08DlRputyEYuJQyiMu+J6xShiCWs?=
 =?us-ascii?Q?e/z5AxRotp6JSk77wWOFvdkqV4nC4chd4iEMETp0V6CdRsAM3OFtc6WNtNaI?=
 =?us-ascii?Q?RPrZ9ILy+4cem4nzW484bHxPtkseCWUKGuN0TiwJ+t86jlobm+OfBCTxZ5QJ?=
 =?us-ascii?Q?RtIqDCir4FIw0eNEx2hOazSSfxVulYr9gfYksjyzcC/ZB7GFExGHlVkgWPEE?=
 =?us-ascii?Q?9k4dwlhz4azuxUm5HflUAVwPC1oSYGsJTkqe31NYq0Odh6NI1m/RUqEpxisD?=
 =?us-ascii?Q?T/TTRogo3Ogu3OWPC+9xOLnEkrZdby8rG9r7+vbT1pQYvBGi9UhJyFsKyIqp?=
 =?us-ascii?Q?heyercRcfTSthm/8FCmZL5OhjDy9hzJdwU3tKJWZtxlXmi9HQv+8oGmQPs8p?=
 =?us-ascii?Q?7mDqUkG7u8INV8M27Ag=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6845ef1c-e766-40d4-92bc-08dbfc8a8692
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:53:29.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TVMX0iomTV92LxFf5WVw6FDsqdACFQ4k7NFKLchKEMB98syKpaFneomrqSRUxTQWLFYrH0yIPJVWMJxTRNwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

[Public]

Hi Mario,


-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Thursday, December 14, 2023 4:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; stable@vger.kernel.org;=
 Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail t=
o flush TLB

Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that causes the=
 first MES packet after resume to fail. Typically this packet is used to fl=
ush the TLB when GART is enabled.

This issue is fixed in newer firmware, but as OEMs may not roll this out to=
 the field, introduce a workaround that will add an extra dummy read on res=
ume that the result is discarded.

Cc: stable@vger.kernel.org # 6.1+
Cc: Tim Huang <Tim.Huang@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a dummy read callback instead and use that.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++++  drivers/=
gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++  drivers/gpu/drm/amd/amdgpu/gmc_v1=
1_0.c  | 11 +++++++++++  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 +++++=
+--
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 9ddbf1494326..cd5e1a027bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -868,6 +868,25 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, ui=
nt32_t reg,
        return r;
 }

+void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev) {
+       struct mes_misc_op_input op_input =3D {
+               .op =3D MES_MISC_OP_READ_REG,
+               .read_reg.reg_offset =3D 0,
+               .read_reg.buffer_addr =3D adev->mes.read_val_gpu_addr,
+       };
+
+       if (!adev->mes.funcs->misc_op) {
+               DRM_ERROR("mes misc op is not supported!\n");
+               return;
+       }
+
+       adev->mes.silent_errors =3D true;
+       if (adev->mes.funcs->misc_op(&adev->mes, &op_input))
+               DRM_DEBUG("failed to amdgpu_mes_reg_dummy_read\n");
+       adev->mes.silent_errors =3D false;
+}
+
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
                                uint64_t process_context_addr,
                                uint32_t spi_gdbg_per_vmid_cntl,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index a27b424ffe00..d208e60c1d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -135,6 +135,8 @@ struct amdgpu_mes {

        /* ip specific functions */
        const struct amdgpu_mes_funcs   *funcs;
+
+       bool                            silent_errors;
 };

 struct amdgpu_mes_process {
@@ -356,6 +358,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device =
*adev,
                                  u64 gpu_addr, u64 seq);

 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
                    uint32_t reg, uint32_t val);
 int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg, diff --g=
it a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gm=
c_v11_0.c
index 23d7b548d13f..a2ba45f859ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -960,6 +960,17 @@ static int gmc_v11_0_resume(void *handle)
        int r;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 4):
+       case IP_VERSION(13, 0, 11):
+               /* avoid a lost packet @ first GFXOFF exit after resume */
+               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900 && adev=
->in_s0ix)
+                       amdgpu_mes_reg_dummy_read(adev);
+               break;
+       default:
+               break;
+       }
+

I tried this patch on my device, but it not working. The situation is this =
dummy reading not hit the MES timeout error but after that still hit the sa=
me error in the amdgpu_virt_kiq_reg_write_reg_wait. Maybe the failed case i=
s not just the first GFXOFF exit.

        r =3D gmc_v11_0_hw_init(adev);
        if (r)
                return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 4dfec56e1b7f..71df5cb65485 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(st=
ruct amdgpu_mes *mes,
        r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
                      timeout);
        if (r < 1) {
-               DRM_ERROR("MES failed to response msg=3D%d\n",
-                         x_pkt->header.opcode);
+               if (mes->silent_errors)
+                       DRM_DEBUG("MES failed to response msg=3D%d\n",
+                                 x_pkt->header.opcode);
+               else
+                       DRM_ERROR("MES failed to response msg=3D%d\n",
+                                 x_pkt->header.opcode);

                while (halt_if_hws_hang)
                        schedule();
--
2.34.1


