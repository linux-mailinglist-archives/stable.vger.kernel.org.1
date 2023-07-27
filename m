Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254576456E
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjG0F1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 01:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0F1K (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 01:27:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469F19BF
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 22:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690435629; x=1721971629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WL4Pq2fmSa4QhGBmnOVidc929PbOo6tT4qI4TipT4HY=;
  b=SpywF3Nn0oIYUTJmBQqdUggSr+Lg13WSZ1RuXOFqGi0d4xMyDwefFZbK
   1e7Iqm80RERIn/DwdLGqkqJmb1IN+EwDs4BIOCyXzbFnbNhZ9UBpWmNl5
   MhrEXZQDMyTQlMyCU3v4qzdtFDpDscTiEnYgS/QoxH4ELxCTHSedL2uzT
   5VRRSYBnmY1IrLYPUi0gR49msIPBLDLs75L70eOMcUsrQHckvpDj778FJ
   o1llWypw/Sx2GZg/LBvoQ2QaPx5lBjXbo4iArR3nWEfFu4jq8xmvlFdZd
   W2hhWBtQnxqYwTmSgTqq1fxB7y1ZwH/NSs4uPNAF9MCtO485F97Yxus/y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="370884905"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="370884905"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720761068"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720761068"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2023 22:27:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:27:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:27:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 22:27:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 22:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzIJXvi2yoN+V7qp+PVjlwqwHPzIQPY/c5uscGWCL56r+ry+nidLufj1Ot4L6RDP3tVnGQpGDFz5AskT0o5U/bQTq4WWNyRnGED40lSozY9csD6i6GRBjYi91H1cjbMJsDIhPkVwCNdyjVDCm/MnZEla/k7Rdv/zKKZjmQGyy8CSpNl6LzejqSBuzYq5B1bakbUCmo1xuJd3j1scSAGJI7EcFvudg8dN64XQ2Gd/Bh/DnxzDESD/747bszMipHYSJ5JSRpAtq/cnzxEOi+x5eLg2G8e5mNpXsvst9mId2ohdaKdPBHclLa76FdC8k/Id7LH6VodUR4FGRsxH/gmjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4O6UkL/PLI0NXO8Wa98R5fxHy2pyMd2S5z3ZR39Zko=;
 b=hCFKPejvldIVDsK/dxOOKV+5KZVuUrcWtPd3x8nH5xYnd2FiBngGxI+nDDcTSF5Op7zLwGBtWoZd5H3i6GYOhirb6uI2/vCXSTebCv76ZPya2V5tecqVRxdQDSncDxhd7Ucpzwi3JgzTodrS7Zr5v1mWu7GSXUEd/+OA/ob0qkjsBdcgKJByHWqS4zS93wCU99kEwYP4T4rlhEJC15oDWApF/X3Ei1i5yLd6JYdUc890v7Pg3+HB92aYVaVSDPysD+kJOefwGNc7kBT7yJKD/8LXcaIbFDV5usX37dNhoiQR7Xovl4lajU2hl3YbO+lA7LgXMl8PDrnUCOGYC5yYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:26:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:26:57 +0000
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
Subject: RE: [PATCH rc 3/3] iommufd: Set end correctly when doing batch carry
Thread-Topic: [PATCH rc 3/3] iommufd: Set end correctly when doing batch carry
Thread-Index: AQHZvysNqdFgUNgHBEu/mprzSW5jsq/NF37A
Date:   Thu, 27 Jul 2023 05:26:57 +0000
Message-ID: <BN9PR11MB52765D0764B8A2993AEDD50A8C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
In-Reply-To: <3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7638:EE_
x-ms-office365-filtering-correlation-id: 3fe84c89-56d5-449e-1f41-08db8e6218d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcycQ6dJWH3RlmQlXppIWa8vNzgJ2vuY7lu2KD+ZQaKHeoMBepQu2Pcd1WKfK61W4xNVYx+HYygmHkbWRZMuSrAM9BJ/GU+jY/mg++zYCQnSgIoKlyrwe90DL2WKclwyTrUeEFLfhPfHWmC48Tex6m//ZPnf6KLhg3xuB4990ZCS/mmiC69drnk2ECqZhOGRJN95BlLyeyuFm7WD6yZbsPcyU+qivg9kdIgvUGzc3CtVa5KLLMGk4xVejIh69pEFRlWvC6t8WIVjM4/jkygNUJ0G/JgwZx28lwxtNbSH3LNmeEsk2EJstdJzevRvBQpfVmC0jBGqNblUpDT+MvG59leCnkmM4na2Oys+LOVJZrlXI3Oz2+O0/RHFtEeT5XKLaNm5b4SpHqR62ohqh59OWVFre+lKm3hQG+0hVby8+R1G3kYQDgvG5ae50hYQe6B9ioGk8jvacJUKUKVdwZpHJ0JBC7udfQlaHeBuDC7naJmz2Jj19zFzl1dsc/E+9hK8+apOWdZJYI7NLYebX26D+z/kIFzKTOdJkhXjCbq4G/S2k2n7RDb0lJMwKFl2DDh/7A1+WS4xF0PKraRsK7rBaRZ8SOtU6dvVyohSUMvbH4H2pvz6Ly+aLGbVjOLBAPZs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(38070700005)(86362001)(122000001)(33656002)(55016003)(2906002)(110136005)(478600001)(54906003)(38100700002)(82960400001)(186003)(26005)(6506007)(71200400001)(41300700001)(52536014)(5660300002)(7696005)(9686003)(8676002)(316002)(66946007)(66556008)(66446008)(64756008)(83380400001)(4326008)(76116006)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5kPqHgUlNHO6pU1ewjc9kyR4Z1HZUyDwfk8Gu4OArcaWQnw468pjtbOol4aY?=
 =?us-ascii?Q?UdkYnkdSDZCq9kZQkEjfXeuO4HGmrAIh+1d0hAgH7BoBM53NID0am3RA+9Ly?=
 =?us-ascii?Q?+eUiiQZMzBEG3C8rwutfHWoZHZZ1BtWSOELMZ8leXnuVG8GBkG5KUZ7m2NH6?=
 =?us-ascii?Q?F/7WCAk9CzpQqYX5VkP3kG9lNREK3+0thL7+6IXrd/hKwlJKwnMj8IFVqeyE?=
 =?us-ascii?Q?ZwFsixP66hPoULAVJRuL3WVdBLiZnx+IbFwDogXd24LBMM9TiLNpmuFZEARX?=
 =?us-ascii?Q?1z7mamOniwbFY0p47NZye8ikjtfxsozrjqKU+ODxyV+DthP0N7pmE+JA91dZ?=
 =?us-ascii?Q?4d2DxPCu3qlBueY1gY3gG36477mxZrPfNYBPCds7kSOpXbzN/DwExhJ1oFkR?=
 =?us-ascii?Q?Ouh/+ABYjz31qJb66TvCaDQHXDBpwesXGr5AnJUCBaUYAt4ZzFTktt3jfbrW?=
 =?us-ascii?Q?/IXDY3HYy9bliWADKYpT5akJW+kkMxWl9YHs/MW02IBS3UaYT9Xcq2LvB9JM?=
 =?us-ascii?Q?Qno16Dsm52nerHAqrXJQyQKrCF3Soh2OACqcjynO156JV5gu3E+38h/4dp21?=
 =?us-ascii?Q?KbR+dd1y0Hex4QwDZPAOBfCM5eGpJ4z9v9g0/CMiSJw0e86xnmaBzRtW83R9?=
 =?us-ascii?Q?JDvRCu7pJaHTg19ZrRrpJ9UGIHYs8RooLjoDuA2kCZ4wfPhI7dUsBFa3Q9CP?=
 =?us-ascii?Q?EMLF/w39zViZKeSd8UyuVH1Imp+oVSXt+K7zZGr4OE3f0egO90bGmj0jHZ1p?=
 =?us-ascii?Q?KNNjQO4rEvjCezQhGcudQVUE16Z+0obnueh6R42S7Q+lBoAr5YCBetBaHdfF?=
 =?us-ascii?Q?4hE4zupxScJajhID9oExaNgNqpWgXq9LpmaqJ4/jeGtIKaGsvC7Vr1w3D/7A?=
 =?us-ascii?Q?nRUIfmlk5QrW+5sNVO7AC3ePKQ1TvIvjmNp0Xl+gmn0A1oXWITTaNR2bQgVW?=
 =?us-ascii?Q?od/wVBAN5MpHPNThzHo5+ng9KnQ0vtJsMQv7W6XlsOs2LLcwYRPJ31t9K2/b?=
 =?us-ascii?Q?5TQA73g7EegU33CAXX2dlsNspac9L32UrIKcI+ek3WEVJws7nBYj/vbvVCBx?=
 =?us-ascii?Q?DMWOMBwzLvVJkWfyUliGzweKAYlZgcMnxgndO7E+O7jQj7in6JZqhH3P1j5+?=
 =?us-ascii?Q?5HG8u9F3pSNszfxTy0pQnV9HSF5YKx5R2P5HTUIglXriTPoEaK7Kc69o9QCf?=
 =?us-ascii?Q?TUEkB+72r9HfvaMikJGCA0FUQFRlzzT6EDU6j8xVB5koYgaYzKUkp50CJPTI?=
 =?us-ascii?Q?8hcu3ri8xtSwQ5ijI44QrNgP5lb/OOh6ytSwSGEAhHBGVSSPdGjt3Ho+Ev3R?=
 =?us-ascii?Q?W/DirIUpMOkHIGv4vkJ5R+UK4HpnyEABdSu7BoJl1GEYExL638cC/De6IamW?=
 =?us-ascii?Q?z5l6rfzU8U/h4G8kA6qAI60pGaqGTld/P/cWtvVvJfy35J7wGTUpo/AZahLM?=
 =?us-ascii?Q?F78oHu28iggGQR7IZDgHJ/2waeBvhKsftZnU9W/+zCkT4UiBFZzIYhfAmw15?=
 =?us-ascii?Q?oqhVA7/n0lSNoM5CV5W17ae8UcWlIVpge9zkRd8tc91ZMxbdzVF3vXrhFJPQ?=
 =?us-ascii?Q?GWQ6i+ChZtMwEGYFj9vR01W1G8kPjcbmM8+xZ7X5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe84c89-56d5-449e-1f41-08db8e6218d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:26:57.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKBxtunH9MJhhGdYrMxXa3GYl/PlwXMUyVwv9aoDPFLM2mIySIequj93kVsVs4o32QBEtsKW3cYpWGXAo5YJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 26, 2023 3:06 AM
>=20
> Even though the test suite covers this it somehow became obscured that
> this wasn't working.
>=20
> The test iommufd_ioas.mock_domain.access_domain_destory would blow
> up
> rarely.
>=20
> end should be set to 1 because this just pushed an item, the carry, to th=
e
> pfns list.
>=20
> Sometimes the test would blow up with:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 5 PID: 584 Comm: iommufd Not tainted 6.5.0-rc1-dirty #1236
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-
> gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:batch_unpin+0xa2/0x100 [iommufd]
>   Code: 17 48 81 fe ff ff 07 00 77 70 48 8b 15 b7 be 97 e2 48 85 d2 74 14=
 48 8b
> 14 fa 48 85 d2 74 0b 40 0f b6 f6 48 c1 e6 04 48 01 f2 <48> 8b 3a 48 c1 e0=
 06 89
> ca 48 89 de 48 83 e7 f0 48 01 c7 e8 96 dc
>   RSP: 0018:ffffc90001677a58 EFLAGS: 00010246
>   RAX: 00007f7e2646f000 RBX: 0000000000000000 RCX: 0000000000000001
>   RDX: 0000000000000000 RSI: 00000000fefc4c8d RDI: 0000000000fefc4c
>   RBP: ffffc90001677a80 R08: 0000000000000048 R09: 0000000000000200
>   R10: 0000000000030b98 R11: ffffffff81f3bb40 R12: 0000000000000001
>   R13: ffff888101f75800 R14: ffffc90001677ad0 R15: 00000000000001fe
>   FS:  00007f9323679740(0000) GS:ffff8881ba540000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000000105ede003 CR4: 00000000003706a0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    ? show_regs+0x5c/0x70
>    ? __die+0x1f/0x60
>    ? page_fault_oops+0x15d/0x440
>    ? lock_release+0xbc/0x240
>    ? exc_page_fault+0x4a4/0x970
>    ? asm_exc_page_fault+0x27/0x30
>    ? batch_unpin+0xa2/0x100 [iommufd]
>    ? batch_unpin+0xba/0x100 [iommufd]
>    __iopt_area_unfill_domain+0x198/0x430 [iommufd]
>    ? __mutex_lock+0x8c/0xb80
>    ? __mutex_lock+0x6aa/0xb80
>    ? xa_erase+0x28/0x30
>    ? iopt_table_remove_domain+0x162/0x320 [iommufd]
>    ? lock_release+0xbc/0x240
>    iopt_area_unfill_domain+0xd/0x10 [iommufd]
>    iopt_table_remove_domain+0x195/0x320 [iommufd]
>    iommufd_hw_pagetable_destroy+0xb3/0x110 [iommufd]
>    iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
>    iommufd_device_detach+0xc5/0x140 [iommufd]
>    iommufd_selftest_destroy+0x1f/0x70 [iommufd]
>    iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
>    iommufd_destroy+0x3a/0x50 [iommufd]
>    iommufd_fops_ioctl+0xfb/0x170 [iommufd]
>    __x64_sys_ioctl+0x40d/0x9a0
>    do_syscall_64+0x3c/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
