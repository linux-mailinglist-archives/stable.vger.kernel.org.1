Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119676456D
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjG0FZk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0FZi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 01:25:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5411D
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690435537; x=1721971537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K19THsIDnohe3hB5hZXuYY3Nqs6sfkjzTn6r9Mqjq28=;
  b=aHa8Fssc4wC5eZHV+sJdza2wiOWr6kp78787rIY5NoCvA7nPygXGmrM5
   fklHfmZQcfAoSOyKVho4SgzKPUW1ZK4nSzv6O20OzSq+xwvgfHKDHD1co
   wFNQIuJZrVkOI8P/GhllOY14b2NzSB2MRLrd5I/xPrpskzAcVjLoKGgXp
   8IEb1HnSUVfPvlLlfHBzBKt6/XMzOPd1yb/VrQ7UCJInAEBUjIewfU3Qj
   PCxpuObm9pwbDClS3MbSABQcq9x17hackYZDr8Lc+FnTARSVf6bGy9Nic
   LJPSNTzXC1pcQWp7O0/E8YsX9ae7ETFEFYZFb/DZjTUuGjamrtmXLAfQa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367082444"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367082444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792176759"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="792176759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 22:25:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:25:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:25:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:25:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHqIYQVqqyipkIeLz461P6tHdnY4u7RPkChx9i3yk354WfHx++6Xav6IPxvwTwik3UE+XwgbxQ9qi2vPVALJJUrnb5Yr7ChM+F7sfFD5JMaUFsZCXIOzXuw3TD/IR8dXXtsTt/53YiHnqgTb+vY5I365nzT4+VlQWytnfZmWUYIVkOLpVvqgYdiWby8GAOaOXku8MNAsSHBPacZzcUOcZFZTRPUaKMv5EuP/C/zHsjg+Y/L3zovpGaHSg/5inqjcI431I/MxPHLrZ2mUd6lSOjMIColTGuu36J7ZTXwmuQdvNDB4CRxrCYUOY3fgMS+rYdbcu5g79nW0W2mEOcpG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwGmcjvxqEGXhA3xJn1lwK1jufpL4wXdujwsjXMBFZc=;
 b=fWfbB/LPTYzLI4WmLsHDe8Ftss+5liV2bbPqwnVh9k7ZCo3LR8aLIXqpXntbesKytaoy9XHFkAHVUI/pm1ZfLfpiSIaw9CB34kBnIYy3FA/iURmqFUnJJvo7qqqp9IWehAA0swAWn3vNIJ0SGsy1KpWncBcZQPp8tZ8iV6GlmPIcZhFYuO6QDejhxdPfRc2HZTz+bCbFbfTBeV1nU+JomTXK+ok3Xb/p0Lmt4mGbUmm7bf38WscTV1h1kbjCVtaODXzZHK0XovS8liKDWws41+1Zib/2nl8Ty+151V1dr3jOLBXQRYmKm2jnOXynon7+5FCvxgpgnQekBwrTJ6sPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:25:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:25:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+7574ebfe589049630608@syzkaller.appspotmail.com" 
        <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH rc 2/3] iommufd: IOMMUFD_DESTROY should not increase the
 refcount
Thread-Topic: [PATCH rc 2/3] iommufd: IOMMUFD_DESTROY should not increase the
 refcount
Thread-Index: AQHZvysRd1Wn/AxLAUigh/TQFxqEJK/NFFGg
Date:   Thu, 27 Jul 2023 05:25:33 +0000
Message-ID: <BN9PR11MB5276133645CE4B8FDAFD22638C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <2-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
In-Reply-To: <2-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7638:EE_
x-ms-office365-filtering-correlation-id: 46e33579-43d0-4419-e768-08db8e61e6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zJqUjegFsxih1JgHMK6sT02gYmFlh2/uVwrA48yZA6F6TbWfxbjqAO0tc5ODlT0AwYgGDCu3g0Mx7SVCrOaJLf2o1rPIA2Wr2Xf/OkfmOiYcjQuKRAWclK9QVCDa36H3fH3fHg9iEe8uDYXEvWAbXfelhFuWlNhkncrpDChK03W6fH+2fbqTx+1IPjH6L5oxDvJ/sMUPLGkVoW4THnB7aNR6ASdVgw/GHWXeRLlfCEm9M4lgp4Kz7yWcx342wPaSMuNzDW72ewUCwwCa/gAn55qyUFL3+aqA4XGs6axzkLvzqK5NJQaArSt72dcxDnCaDmlpcoNeSObbW3HFQcpOGgLnuHaUgWAKj4VuK7Ny/POvBs3pxGIRovrCEjRsRpMY2EkIFXxtQKgS17cPqEL/pjcfBIKsCTSgmGUPLaLUjuomP3Sh1+vZF3jdKCUrNbmaW86l4iKSqxReTyy3r2FHz+AP0IIZIfLCx86URrOuEP1mJDHt7T2Uy1DMHVluEsJHI/xt/Xlew6xUwF5TTyYDMO1zy/5IKdOyXATfmYVFnd1pICKg3pUU/yRkuIAalbsuOFdfpNIBsXDlG+xAffwIJiPUiaMmITeZWVSyZHyU/+2zUuOfjzxHd7xQzj+E5j9Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(38070700005)(86362001)(122000001)(33656002)(55016003)(2906002)(110136005)(478600001)(54906003)(38100700002)(82960400001)(186003)(26005)(6506007)(71200400001)(41300700001)(52536014)(5660300002)(7696005)(45080400002)(9686003)(8676002)(316002)(66946007)(66556008)(66446008)(64756008)(83380400001)(4326008)(76116006)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HC1flj2hcxkz70OECHtn9GN3zc4Z9fPju7AzmCV+04cydW42gg5ynnOF0kjI?=
 =?us-ascii?Q?wlVN75PMkdXiTcOwytvsQSj/YqcBSjjiDPigdxGkrTJXVVZMyuSIH7w1ETme?=
 =?us-ascii?Q?Kw6953gdcTWFLiD1vO2CE3eJVAbA4AAspBUIoNSpM9D7OrNDjBjlgIMYE+Zi?=
 =?us-ascii?Q?xhFx1qqL22TThKd8VLwoZYVNOMT0lG2730lWsZiIvaehWmxAY/nITEAQH4wk?=
 =?us-ascii?Q?PB1z3AqNRc57sPMFjFxz/lTB13MoeUvsq9oNpGowHMpU7oDHzu5k7pDU+chg?=
 =?us-ascii?Q?HRe0wnG5rCgV6GaY+rvNwEy5cAz6kz1NBG02N8iQfzaml06y9MQ7MDtGdPZw?=
 =?us-ascii?Q?pBgNRCJiDylrXDR+RKLoHTWDv9CFkE5UwwKpEwZwgo6WPxvFpfjEMMa1xvFe?=
 =?us-ascii?Q?DOJAtxbQ1OkRPCsYRtzqfabaukfPePmKf2rOczO4FwHZOY0ViIgGP2dw1lIA?=
 =?us-ascii?Q?LVd7hvSi9vopRTCcT4IWIx7k1WQl2eTBzYYo2NnJNHzO4VRNaYtJoVAw9K25?=
 =?us-ascii?Q?rogHyQ1nhNq5udD2hzFWWVGhkI9tiklf0VRAowy4rMJKZgS9fNnFZ9G/FfCt?=
 =?us-ascii?Q?x+WAd3wVjKLu4Qczhfihg+SryicSgSm6P2fqdwr9HFKgakcoHvwBlqJHmM6I?=
 =?us-ascii?Q?iJ+G8Y8GLRMenJYb40VamLbQQS4oylXEo87/YBOgJcjsOQpHSM+laHC8NuqE?=
 =?us-ascii?Q?vsdrEXBMetifCMEvKtEoK+d9UcXAoq10X4P0KF4eatrBeJCuHpdvd7IVOpB0?=
 =?us-ascii?Q?QvFl7zj55yBzV7KsbTVita3mbgjkPd1OhjMkIvXL2Ui6crcfI3LMF33PL3ix?=
 =?us-ascii?Q?BqRfM2WFThZxyHPRW6GvVaUigzSCtkltDn3pMyvQY2AWBVFiYzTZo4GhsTNA?=
 =?us-ascii?Q?sm0nnKyjaaqMMrxrHVls5nCzHGJXcifp+oO2imO1Vcn2MrRwbnjlaDhB6KWT?=
 =?us-ascii?Q?ZgLIiXk4sGxWPR8GSabgZrBk3zqM9IuJQvP3SnOiam8G4s5W10QzZEACGqWc?=
 =?us-ascii?Q?tKmiROIga46W+NubFN7+F2gO/BMo1aTe0pHIEKwe+u70lDpar+MlYqQIhHUy?=
 =?us-ascii?Q?vucSFKWmLxUeSwf4523SH3gnJRHB+RzAZtw8cZH0dNF8WRSZBjHgHSTrA/Ye?=
 =?us-ascii?Q?Gu6N6pRg+8ni73EqDKCgVVUhTpYTysbQstOISbFrjxZKXVEPzmaIrtbFPRkW?=
 =?us-ascii?Q?tsprNuTVindebFnBVKKH3OR4JsgxRxHj/U3IgjjJCcGIkCP04Gy/gcpUNmVc?=
 =?us-ascii?Q?t/nptjk664dL49Av2A0fiA1JDGvja80c0cx6JC8h+oh8KhubD+srQWxA1019?=
 =?us-ascii?Q?UcWFRdKh6qlMQc2JJ14Z1dwSPv+Zte+gSLxtrbpTRTpDRWZmjyjwtDkFragU?=
 =?us-ascii?Q?B3P2LJeLJwDw22/AHPpmX4rcFYJBKLs9j/1CMBqiAW6isjigdSvLwJNotuxG?=
 =?us-ascii?Q?2wOtpb3fJAeAOsl3tSQZcyLdeX5lzakzEOYqQtpiPkm5CAumTdMbVlIchUPU?=
 =?us-ascii?Q?6qBHz6HTGySHtA8/7UdVubAduQOZ335H4ZtozPKsCJoILNNxgqxY/ibMvPPg?=
 =?us-ascii?Q?elRY7gwxn78WRw44V9/uWyYW0rAtaoon68920D6u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e33579-43d0-4419-e768-08db8e61e6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:25:33.8739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fL7D6+RefdZJZIdUsPK0McFJ8kBcCvQ/Af3CnA27iXaz5T7BpxSCk+eOt+vJQ9gcIieb6A8RxgmDaMYE5lhjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 26, 2023 3:06 AM
>=20
> syzkaller found a race where IOMMUFD_DESTROY increments the refcount:
>=20
>        obj =3D iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
>        if (IS_ERR(obj))
>                return PTR_ERR(obj);
>        iommufd_ref_to_users(obj);
>        /* See iommufd_ref_to_users() */
>        if (!iommufd_object_destroy_user(ucmd->ictx, obj))
>=20
> As part of the sequence to join the two existing primitives together.
>=20
> Allowing the refcount the be elevated without holding the destroy_rwsem
> violates the assumption that all temporary refcoutn elevations are

s/refcoutn/refcount/

> protected by destroy_rwsem. Racing IOMMUFD_DESTROY with
> iommufd_object_destroy_user() will cause spurious failures:
>=20
>   WARNING: CPU: 0 PID: 3076 at drivers/iommu/iommufd/device.c:477
> iommufd_access_destroy+0x18/0x20 drivers/iommu/iommufd/device.c:478
>   Modules linked in:
>   CPU: 0 PID: 3076 Comm: syz-executor.0 Not tainted 6.3.0-rc1-syzkaller #=
0
>   Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 07/03/2023
>   RIP: 0010:iommufd_access_destroy+0x18/0x20
> drivers/iommu/iommufd/device.c:477
>   Code: e8 3d 4e 00 00 84 c0 74 01 c3 0f 0b c3 0f 1f 44 00 00 f3 0f 1e fa=
 48 89
> fe 48 8b bf a8 00 00 00 e8 1d 4e 00 00 84 c0 74 01 c3 <0f> 0b c3 0f 1f 44=
 00 00
> 41 57 41 56 41 55 4c 8d ae d0 00 00 00 41
>   RSP: 0018:ffffc90003067e08 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff888109ea0300 RCX: 0000000000000000
>   RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
>   RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88810bbb3500
>   R10: ffff88810bbb3e48 R11: 0000000000000000 R12: ffffc90003067e88
>   R13: ffffc90003067ea8 R14: ffff888101249800 R15: 00000000fffffffe
>   FS:  00007ff7254fe6c0(0000) GS:ffff888237c00000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000555557262da8 CR3: 000000010a6fd000 CR4: 0000000000350ef0
>   Call Trace:
>    <TASK>
>    iommufd_test_create_access drivers/iommu/iommufd/selftest.c:596
> [inline]
>    iommufd_test+0x71c/0xcf0 drivers/iommu/iommufd/selftest.c:813
>    iommufd_fops_ioctl+0x10f/0x1b0 drivers/iommu/iommufd/main.c:337
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:870 [inline]
>    __se_sys_ioctl fs/ioctl.c:856 [inline]
>    __x64_sys_ioctl+0x84/0xc0 fs/ioctl.c:856
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x38/0x80 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> The solution is to not increment the refcount on the IOMMUFD_DESTROY
> path
> at all. Instead use the xa_lock to serialize everything. The refcount
> check =3D=3D 1 and xa_erase can be done under a single critical region. T=
his
> avoids the need for any refcount incrementing.
>=20
> It has the downside that if userspace races destroy with other operations
> it will get an EBUSY instead of waiting, but this is kind of racing is
> already dangerous.

it's not a new downside. Even old code also returns -EBUSY if
iommufd_object_destroy_user() returns false.

> +
>  /*
>   * The caller holds a users refcount and wants to destroy the object. Re=
turns

s/users/user's/

> +
> +	/*
> +	 * If there is a bug and we couldn't destroy the object then we did put
> +	 * back the callers refcount and will eventually try to free it again

s/callers/caller's/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw,

> -	iommufd_ref_to_users(obj);
> -	/* See iommufd_ref_to_users() */
> -	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
> -		return -EBUSY;

I wonder whether there is any other reason to keep iommufd_ref_to_users().
Now the only invocation is in iommufd_access_attach(), but it could be
simply replaced by "get_object(); refcount_inc(); put_object()" as all othe=
r
places are doing.
