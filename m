Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F27275315F
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGNFkl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 01:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjGNFkj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 01:40:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F02D40
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689313237; x=1720849237;
  h=from:cc:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=S6zHYnxokSci/982cxSiakSsW3toWufhP/G7XL+DanQ=;
  b=AmnQkZiQv0QD+TSVaHlhbaeD38nXiRwhpNWca8NLYBN8AwPPAVZE1Q0I
   VOaek1a7NMHIr3bksp7RxCF+LgcNc8SECBUfQtKyYU4RONO5/8Hz+O7IE
   68OPob47AytksEBk1CPUAtqNd0AxpytC4JBbF08rerUWkZG2kKqXpKJMx
   hJbqro6iTuwgaB8b7Lh3hFkjOqdJY6+SYXdjv/lByGSDWOZmyQ7vZiWlF
   8NUHiPSKZeNfYdwo2xexcvXxUcFXwn9gWJf0mOXvNDmbhTFqG2bwdZWG3
   bldf3MdNJpf2nr+QmIXdPAXYXZ9TWMndgjHD+jeF2yQALSWtCFPMqDq/3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451760642"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="451760642"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896289838"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896289838"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 22:40:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:40:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:40:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 22:40:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 22:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIH19V1eCG3Nx7FBKE1Eli4mhEVsZ3O5gxbAReCc7sfKTOAuDOHWdvmyXwKHvVPMYgIRNYgCaJEmKxaUEz3LkH7eZN8dbQV+L9jj+iftUSTGpOmoagObaPnRb5REB0YF6+AZQGqGjs3fQrcBvxikAi7BMvjJ9gvdm+JADoMquYN6fRk1//0HVlbzp9hfACZwL72WQwHByFQs/Vy8+u0rZKnhQ0tA4J9U/r4E4KJcpI4rj5R79D+7x9JTffSkKafQRTQP7Vp6hQcS3UYxLjud/ruOL6QKLHMmqQ7rojvjRbhfIPJ7qvLyHMiCOsh0XdEE3YatcyK3ZvDkTG2pvn5iLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaDO0Qdd/GOKOew+pFlvHZP4JZgl1ZLsC3MJuWsv3LA=;
 b=H+kdKJt6SVG7btpNpwKCKLUQTGdFFiZuyGaKY+XuZ4nAgvzquXYNg7uFpXJUX9ow/XkrYitAdF+HCSjz16Jwlcgf50mY6MPfNKnmsC6BYE9J+9Gx2Z2tWNpdhF1HgrFdd84s0EPTg0I0UfGYostYRNcMVwjYzvNqs/Zv1uqgzttY4y35j+3ziCBl7+tApY4cS+njPWx5neltWXTmh6LhUopdFcT4oFWfBdm5UKExOrJQ1c8kCoc9A4HJfaioC+yjGZh/inskCeTtBXlkKIYmD6F5m1OCZbEzeqFnQmhEdz8DBKxwoF+tXuWP0bZjsQWzRceCi4A+/i4V/vxM4253/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5735.namprd11.prod.outlook.com (2603:10b6:8:10::7) by
 CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:40:33 +0000
Received: from DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00]) by DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 05:40:26 +0000
From:   "Ang, Tien Sung" <tien.sung.ang@intel.com>
CC:     Gavin Shan <gshan@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Shuai Hu <hshuai@redhat.com>,
        Zhenyu Zhang <zhenyzha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH 1/2] KVM: Avoid illegal stage2 mapping on invalid memory
 slot
Thread-Topic: [PATCH 1/2] KVM: Avoid illegal stage2 mapping on invalid memory
 slot
Thread-Index: AQHZtgRGDfQiHCctvESakl0B3qG2La+4vy1w
Date:   Fri, 14 Jul 2023 05:40:26 +0000
Message-ID: <DM8PR11MB57350FFC0CFDF46F183779AFBE34A@DM8PR11MB5735.namprd11.prod.outlook.com>
References: <cover.1689305655.git.tien.sung.ang@intel.com>
 <2230f9e1171a2e9731422a14d1bbc313c0b719d1.1689305655.git.tien.sung.ang@intel.com>
In-Reply-To: <2230f9e1171a2e9731422a14d1bbc313c0b719d1.1689305655.git.tien.sung.ang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5735:EE_|CH0PR11MB8215:EE_
x-ms-office365-filtering-correlation-id: ad1e8f02-507a-44e2-a8cf-08db842cd3bb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hm+X7XslNVwRlFHQjwW/uhrZjmkqotW4q+DVGWdAMvz1V5cOpkqYW+vjkmICUwVPR6KyivMVaxBnDKU3SMa2fKjFjCjjHlLMRRl+KLS0pYunCmpfdYnJX2oBs5gW3T8M8HdE1BELGuHXI5xou8vblQmdw+lQJDVHNp+tqTHMFRjNsiTNGXuHbDgIWLQkSYLDgnf2wZgwBDnouXGN+/Hbj3HH7OZ6hQmRFoNg82lMxdTWDawBb2i0wfbkRyciovEP40Q0A1OrwUaPSMw3i4eXch4cp0ovs3QCIFL1mkoSKk96tKB2IfFKMMwDreAhZMmy5wOhYSYBev67TuOjszZPiU5kOLcfZXuVzuPnBAj2oNbv4t7vQd8aqbns7jW/ZiYV/IVBTXNs6Tfb8HGtABqey4SxtoHjruUCTC37+AsMBydC/dVlFOZgbv2VD39ithiQUR4KNgzYqaGoCyy4g5WxDDKHPOZ38bVEb1w8ITy1HNi4P7a7MLnxj8z4OODyg4cFmxL639XgupiIxN3NgSffXdj+EMPneiv2940nynBX4RGG2bJRdxKuBmoNIZxMvHKO5qTzr6EIODdUDKZRr+jOQtb3pGO+QCQr9z1xisc0z1QkhxjeyJAjtLhwwt24udcx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(109986019)(55016003)(83380400001)(41300700001)(38070700005)(71200400001)(7696005)(86362001)(2906002)(26005)(6506007)(53546011)(186003)(33656002)(9686003)(5660300002)(8936002)(8676002)(7416002)(52536014)(66556008)(66476007)(64756008)(66446008)(4326008)(38100700002)(66946007)(76116006)(122000001)(54906003)(478600001)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hUcU8CaUf8NMqhbwH4cFqC1wXx76u6WW9EYZWVvs4ldmiRIaKq0EPzCqmY7B?=
 =?us-ascii?Q?56v4lpNElRcVjBJrpdTJpJllWP1HZ46nUGMidu9bMvsWWQlNIBN+lmqDPByS?=
 =?us-ascii?Q?Ju59vic+I+0/iC+zPvfC/6K8ZVvf/S6TqEWtfF8ksQFGwAnG5Q2u2KChN3/u?=
 =?us-ascii?Q?BFxIB4hVCO2HF3ZXr0ctEPWlbPxDxk4J1721E9Pi3IbivxDAQjBdmF2PqOb5?=
 =?us-ascii?Q?0qhz+ht36xNMjeUn8a0vUF6kpZbeffb6x0FGtOwaIgDcbfaUT4CbPNdUMIXF?=
 =?us-ascii?Q?tAs1WCGB9qOc8Af4m4Z/HCaRRXadiL2JuJGpzYC9HR+w9ptp3hSDbrzipaKU?=
 =?us-ascii?Q?AtGlwPfBVQ387DUgK4qHb+ezBw37Dr42OOjxHKJuGxEQK67VBHqAdCEr61aG?=
 =?us-ascii?Q?iIFpGOlKhLQ13BCCuoWsSjnX3IFfPFuH2wrwFYSi2rypM/CO+g98U/MpMQpX?=
 =?us-ascii?Q?+I6LwSftDHU1MIJ4veANSrb76GtTPBw5LyZ74XLaVa7Sc1TT+C3qa9ISmkb/?=
 =?us-ascii?Q?+U+EKBqikHQgI7ZNMosFo5WYhyEbhulWZVgICbMa4VgcS9B9oqOg/kqFVUJl?=
 =?us-ascii?Q?+xQEDMmDjt01xOrUHwIxSETccBb+W3ne3QNLB6G4ZPgVVqJHYB6RrH5UREi8?=
 =?us-ascii?Q?/vFWAQgQxtf0eRh8j8wIbrMhFIkf91WmSkW53ocSeqEg0lNdBnqtHkFgnwlz?=
 =?us-ascii?Q?BfZ6KLUsaYjrG3pVODB0OsLdd7gCt/whmpwhK5gau7s8fjBPBa25ptKBpYSC?=
 =?us-ascii?Q?w/k37w2oHOwx0LNhL8Hv1KQ8xD+De+BaBEiUmJ3DY9fEe5+olbbGCLLn8IZh?=
 =?us-ascii?Q?CHbWt8olZEm3FxqoRmBK12shss4uzH/iJ7Kh0b39Ip0hOS3i9Tles72c9STN?=
 =?us-ascii?Q?i7WQlDrwMk/8Sij7LQJNvCVUlf9GSlWhgwVIHsAs0nvCqA7nc0Hp9gJR5fsV?=
 =?us-ascii?Q?RZ89H2d8fmPeD7BGQmpPmRX4V/jrzkdXCM0zO5chzR6C2kXCvgsCQbTA4MlK?=
 =?us-ascii?Q?9oxFY7ZjLG3H31fLBr7Sx6ZBl3k+qRKLulxUBSxrfxMRkw5Vim1HjrZgnXQY?=
 =?us-ascii?Q?7VmJvn8DWP7i9DFfhgaD3E/7aynmXnb5Fl1SO/ZMMiHkciM4S6KkQBkOlEe3?=
 =?us-ascii?Q?gQ51HG2VKnoq08pW7wB7q3dOoFdBgoMewv0gGosR1hrknvzvjLRfZEC/LC3c?=
 =?us-ascii?Q?6lnPLQrPLwYoPHO8+XsF0kJIXBiF+CftshttAIq+SogwEqzyWlY2No8mNtgN?=
 =?us-ascii?Q?YKvlBuhvcsRBpThGJVTcEqchqxcycPUQpbOq6Oqf7bScFX00KhEEnrSJi/aj?=
 =?us-ascii?Q?n6Vow4yhF713Jct6XkyPlxtq1WEBPgtk0Dc+4P1Vi4JEq1z/p7UAZ7AU4OXn?=
 =?us-ascii?Q?WzVJSOwsx7c0YGn+zKI7Rjlx4juL3vyTFjJ9dNZynIA7a86ngkEu2oh9jEyy?=
 =?us-ascii?Q?lsCbFn0O8m/BEO0hG6ekXJJVwIhq4FRs8B0bEJ9Me6umRe90FfQF7z+seO6O?=
 =?us-ascii?Q?Ph7K6hlPcyKxeLwR5tgT+SSrt9YN41BnEVSVv4z1xdGyzgCTPMX18pyezvga?=
 =?us-ascii?Q?1dtvi33VG0uIx8NiYX6j0SVfCMo71Gy7/8mgmZjk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e8f02-507a-44e2-a8cf-08db842cd3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 05:40:26.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75zihRpixKS74vehdgbyG9YeIrvhNjC4kSEf0409XCxfhWtzy169v4wei+4Byg8mV1tjU622J9DfzKqtOAAx5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please ignore this email.  It was sent as a mistake.=20

> -----Original Message-----
> From: Ang, Tien Sung <tien.sung.ang@intel.com>
> Sent: Friday, 14 July, 2023 11:35 AM
> To: Ang, Tien Sung <tien.sung.ang@intel.com>
> Cc: Gavin Shan <gshan@redhat.com>; stable@vger.kernel.org; Shuai Hu
> <hshuai@redhat.com>; Zhenyu Zhang <zhenyzha@redhat.com>; David
> Hildenbrand <david@redhat.com>; Oliver Upton <oliver.upton@linux.dev>;
> Peter Xu <peterx@redhat.com>; Christopherson,, Sean
> <seanjc@google.com>; Shaoqin Huang <shahuang@redhat.com>; Paolo
> Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/2] KVM: Avoid illegal stage2 mapping on invalid memory
> slot
>=20
> From: Gavin Shan <gshan@redhat.com>
>=20
> We run into guest hang in edk2 firmware when KSM is kept as running on th=
e
> host. The edk2 firmware is waiting for status 0x80 from QEMU's pflash dev=
ice
> (TYPE_PFLASH_CFI01) during the operation of sector erasing or buffered
> write. The status is returned by reading the memory region of the pflash
> device and the read request should have been forwarded to QEMU and
> emulated by it. Unfortunately, the read request is covered by an illegal
> stage2 mapping when the guest hang issue occurs. The read request is
> completed with QEMU bypassed and wrong status is fetched. The edk2
> firmware runs into an infinite loop with the wrong status.
>=20
> The illegal stage2 mapping is populated due to same page sharing by KSM a=
t
> (C) even the associated memory slot has been marked as invalid at (B) whe=
n
> the memory slot is requested to be deleted. It's notable that the active =
and
> inactive memory slots can't be swapped when we're in the middle of
> kvm_mmu_notifier_change_pte() because kvm-
> >mn_active_invalidate_count is elevated, and
> kvm_swap_active_memslots() will busy loop until it reaches to zero again.
> Besides, the swapping from the active to the inactive memory slots is als=
o
> avoided by holding &kvm->srcu in __kvm_handle_hva_range(),
> corresponding to synchronize_srcu_expedited() in
> kvm_swap_active_memslots().
>=20
>   CPU-A                    CPU-B
>   -----                    -----
>                            ioctl(kvm_fd, KVM_SET_USER_MEMORY_REGION)
>                            kvm_vm_ioctl_set_memory_region
>                            kvm_set_memory_region
>                            __kvm_set_memory_region
>                            kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE)
>                              kvm_invalidate_memslot
>                                kvm_copy_memslot
>                                kvm_replace_memslot
>                                kvm_swap_active_memslots        (A)
>                                kvm_arch_flush_shadow_memslot   (B)
>   same page sharing by KSM
>   kvm_mmu_notifier_invalidate_range_start
>         :
>   kvm_mmu_notifier_change_pte
>     kvm_handle_hva_range
>     __kvm_handle_hva_range
>     kvm_set_spte_gfn            (C)
>         :
>   kvm_mmu_notifier_invalidate_range_end
>=20
> Fix the issue by skipping the invalid memory slot at (C) to avoid the ill=
egal
> stage2 mapping so that the read request for the pflash's status is forwar=
ded
> to QEMU and emulated by it. In this way, the correct pflash's status can =
be
> returned from QEMU to break the infinite loop in the edk2 firmware.
>=20
> We tried a git-bisect and the first problematic commit is cd4c71835228 ("
> KVM: arm64: Convert to the gfn-based MMU notifier callbacks"). With this,
> clean_dcache_guest_page() is called after the memory slots are iterated i=
n
> kvm_mmu_notifier_change_pte(). clean_dcache_guest_page() is called
> before the iteration on the memory slots before this commit. This change
> literally enlarges the racy window between
> kvm_mmu_notifier_change_pte() and memory slot removal so that we're
> able to reproduce the issue in a practical test case. However, the issue =
exists
> since commit d5d8184d35c9
> ("KVM: ARM: Memory virtualization setup").
>=20
> Cc: stable@vger.kernel.org # v3.9+
> Fixes: d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
> Reported-by: Shuai Hu <hshuai@redhat.com>
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Message-Id: <20230615054259.14911-1-gshan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c index
> 479802a892d4..65f94f592ff8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -686,6 +686,24 @@ static __always_inline int
> kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
>=20
>  	return __kvm_handle_hva_range(kvm, &range);  }
> +
> +static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range
> +*range) {
> +	/*
> +	 * Skipping invalid memslots is correct if and only change_pte() is
> +	 * surrounded by invalidate_range_{start,end}(), which is currently
> +	 * guaranteed by the primary MMU.  If that ever changes, KVM
> needs to
> +	 * unmap the memslot instead of skipping the memslot to ensure
> that KVM
> +	 * doesn't hold references to the old PFN.
> +	 */
> +	WARN_ON_ONCE(!READ_ONCE(kvm-
> >mn_active_invalidate_count));
> +
> +	if (range->slot->flags & KVM_MEMSLOT_INVALID)
> +		return false;
> +
> +	return kvm_set_spte_gfn(kvm, range);
> +}
> +
>  static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>  					struct mm_struct *mm,
>  					unsigned long address,
> @@ -707,7 +725,7 @@ static void kvm_mmu_notifier_change_pte(struct
> mmu_notifier *mn,
>  	if (!READ_ONCE(kvm->mmu_invalidate_in_progress))
>  		return;
>=20
> -	kvm_handle_hva_range(mn, address, address + 1, pte,
> kvm_set_spte_gfn);
> +	kvm_handle_hva_range(mn, address, address + 1, pte,
> +kvm_change_spte_gfn);
>  }
>=20
>  void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> --
> 2.25.1

