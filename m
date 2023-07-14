Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B6753160
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 07:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjGNFlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 01:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGNFlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 01:41:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDD2735
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689313266; x=1720849266;
  h=from:cc:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=nbt2xB3nICF+tdN8IoRAFK57dDGebnUek5vnnc0ZcOY=;
  b=iQPGblxdcgs5RKsUrBSMGjLGkAiJIQ6SICeGcVHXGn0fesJI+7ZB9B7M
   LqG3frjxY/NnHLPj/wDkVCfbViq8p/Z414iH1MPaSYMXrZWeQ7Pzu8cpf
   ogZIWof1JBjpsgo8jJQEfkJ0jQOlK2PB9R1ps7u/omF9b5U6Mk0gPZm7S
   Gra+BpTNyH8JxnM+Ka2BzLUa3axmgKQZMzrfdn7LxFEy+1NcXokudrNnk
   MyW5MaDV+0wrknHRZMEbwKkl2+f/rB41VM/uTCCjNyypFiezz9KeHQy7c
   4jy2gqRBWh7wdb/QvGMhpKXvzsqBZOE2LOlVR607Rpeo6jZjYNR1BMxKf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429161351"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429161351"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812301006"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812301006"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2023 22:41:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 22:41:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 22:41:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 22:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZinC8hPmlauAQFnMGaQy9l9fShSkqlCSuILVlVrn+NIrR5z/s5jXFcpSNWzKzcKevXJizA+9tlxr1NNOIjJKa5iotb2h2+C5ps8Kp+xRSAiX3A9iHJRdpFwzdRcEdmEFybyb6hrZBnFLGd6X7W+wLNvW10NKqmi5P2dvVCgdM0Kr5E30sxVgNydY4cQwubJitmuhAMjVYIkMyoWXYb+MnP9BG858Fpte6DHPndTDX27lzilzoxuDgCvRNCVixbNloK1ffqlTqAzzH2axsEndG7T/fR2s86yIK5MSGUSzMhp492nwIh8lesI2wCZVOlZ3DVusynytl3Ml+kxNIMmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDEc0uFiyzcJkzJ3D1rJ1JRsItgCveNs6nJ+9MbPI40=;
 b=ceuEWO/Q8BURkuZOhU5539zD52oFsgvme6RbHpcFgq62vrRGRxEiEAKYXWqOzEiQAf61n7wiVlAVsNkH7GbLDTln2WFcX0u25mdw/Z+qOeyia3xqDn+fs+dCfNsZaTI9YpqtibH5xGkfz65TM3MuL5jMu+EzyCdBMUg+5CagToSabAwLLUGHMkyzAjOco4PXCFldbNEScTJwqMD8Nv5toXyuSCzkQHoGl8TXIi7imLTuRzDKynnSIP7hn74vTQXPJJPWFzz/6WpImcRUITHrXA+HMIdzR7Ss7pt5R5JTtDPAxkonWk1pXBHrX4RZJDy0kNhWYqieQapbb7oOSHAFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5735.namprd11.prod.outlook.com (2603:10b6:8:10::7) by
 CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 05:41:02 +0000
Received: from DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00]) by DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 05:41:01 +0000
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
Thread-Index: AQHZtgQJfVAfqpmvRkmPzaGXlj1uOK+4v3FA
Date:   Fri, 14 Jul 2023 05:41:01 +0000
Message-ID: <DM8PR11MB5735F63BD618492370EB8223BE34A@DM8PR11MB5735.namprd11.prod.outlook.com>
References: <20230714033247.3791879-1-tien.sung.ang@intel.com>
 <20230714033247.3791879-2-tien.sung.ang@intel.com>
In-Reply-To: <20230714033247.3791879-2-tien.sung.ang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5735:EE_|CH0PR11MB8215:EE_
x-ms-office365-filtering-correlation-id: 3fc5a96a-6b25-451f-12c7-08db842ce89c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VU8ULV0qOf6IzLK24jJ2uI5adbC0F9uVZs1WDLbyefCiUDuxL+iv9VbP2cy5uTGPzSRrXKRBRXsT9KDuFnn5MeLz4al1YRUhEwRt6lh8id2IL10tjffxHdbFZFDFxqJ7081NDph/qXnX/9BESAEu4Mc0QU/6+tFFXCMCiWpGOqgmbubPcoOR6vDm9Ov8HjXx0qQhDHMLb3FmpEpAUNItyA9kjogXxUUkKS2nMgzzPXkwWcl1RZxWNlgnPKb4aOEsJ/GGKlDmvNui7S0iXPxVsTqC6hJerwKZTwy3WXtVd7esEUcNKlnmHHp+P2jZVWv3bxvR526gTKB1Qfj5LMzaCDuR4xIUH8/RM7xFvUbH6VTLFYvz7t2Hea7kXmPuim+VnKkoZ1A2piMOh3ySRTer0CyH9eGad2XYQK6xTzyeYQw+L+7rp6FWpyEJODfFFwohaXrRSPoBF9qox2omd95j+8eVKgwt3ruFtk9xiR/ovnSvOgFXU6WvaXQH7GVgbUPKIoyjAyvvbWFRHHf1/o+lgWdMrb6ir6q92D13yKeIwH1giXOUm4lS0Vo2ykGkQwQkY1HTJmD7VP89eO6wcUP0uOTjwT99/A5g2AiOaCNjMWySsqvyfenP7vVyO6o4fKcu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(109986019)(55016003)(83380400001)(41300700001)(38070700005)(71200400001)(7696005)(86362001)(2906002)(26005)(6506007)(53546011)(186003)(33656002)(9686003)(5660300002)(8936002)(8676002)(7416002)(52536014)(66556008)(66476007)(64756008)(66446008)(4326008)(38100700002)(66946007)(76116006)(122000001)(54906003)(478600001)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VakBgapEv+21kr6RIRCEK7HL0GX36uLGeOQfTZhmRrpKyuDPxDqrxTlcADSd?=
 =?us-ascii?Q?a/CuJ6thOA9yZf1JYFWSohElmXztZ4wo4+vV6AyyOtMiLERcsc6sNyUMUTMZ?=
 =?us-ascii?Q?ZOFThZJu2MAj+TudnsjyPXorarq92qPxsSfY4TPXZJqDBLSZohs+U6zGU0/2?=
 =?us-ascii?Q?HukEtNtbmw4ZT3asAHDdaC4QWXxcfeEIxSR7ZlwCWaeENlAN+Yih+Xydms/n?=
 =?us-ascii?Q?ImNULZZl5jU8j8DXbKUO4tfVm2KVTIUDyYuDVREwNOHHejV6t7ZVX7dz5JTo?=
 =?us-ascii?Q?NTNZTP4j2HncZklcTnnPUS8BGmY3kYwvclSzLdfKQ3PTy5iHUhVnww1yVswb?=
 =?us-ascii?Q?7UdVT+mPXgJu7DYycBuDDrX5jEJwr+8N7ygcT3sYBlEQhSatL64/InCdlPzE?=
 =?us-ascii?Q?t+fEpKMhnewPQPXrSuzuk6Tcgsv63JXKDb7BbM9lQliuL0Jln00U2pFu7Ugs?=
 =?us-ascii?Q?R0VsuW1SrWp3dYeBVFLpVf2gyTYNSmhQ61MLX1aEjv3qE3J3CfnsIT3Wpp27?=
 =?us-ascii?Q?yGSRcQiJ8VG8MHvgKeoimAFOu/0ipK1h7jIhA0kIpzL4vs1g/mW0fRbJv068?=
 =?us-ascii?Q?uQ5OnRKfjgyHYc2sqM/mbsqr/BhiBDvq3hBAzI5aUuQpz5KYKV7DpA7Us+bR?=
 =?us-ascii?Q?C5Fzh8s0DXjuiCTmBgjuio01jWq94dhJCNGGpbMbyKbqQWhduOQACSa+0qaL?=
 =?us-ascii?Q?wOYkceyZX3dDrFElVT5xMSdT+IfINn2ClYawH1MFPDGLy1TSy3mdqcWvdH8k?=
 =?us-ascii?Q?kVR2rNMmvsQsCdk8V+5zWqXXZJZ7bSXUyG8ayh4FIb20Whm2h79nGwdi3IfG?=
 =?us-ascii?Q?V9m22sOxNlL2LkopREGEDlnkIk3YvYdRSsKQ9BKeEc9BU7kCIZk+JGj/Bmkt?=
 =?us-ascii?Q?IA/Le6rAa1cEvOdTxQaemvdOcFhAwNOeW9XiKVBMGDDrX8nIh+L7IlMHrlMZ?=
 =?us-ascii?Q?y48A4AmIvsBYAScqQU3Xbm2kLofn5Yuh68YntzDtb1t/lpA2W8VdWUJJ9YDK?=
 =?us-ascii?Q?Kfe/TImAglg/2JzOOlldaweKZKtp1GgNQ4aMQu/PQu+TAQ64eP9ueOZdkQju?=
 =?us-ascii?Q?UcLWIqEL9aftYJabv4NhjRdbgNva6OFC4RhTqFtQDWp/C8RuIiVXxe/5o8jm?=
 =?us-ascii?Q?gOMjvnxFc2uZaHG5EjQOVGh8WELnWFUQVhb6fZs4qebWHoHs06x668PNl43T?=
 =?us-ascii?Q?i/isL61mOuagz6hs9/GiERpTZ6t86ULQ6hu+ZomUAsgWB3gHUiSox6/N0/qH?=
 =?us-ascii?Q?/SjuHuTlYN+IAQcyezYBQn/LIT2FIEEwb1YilandQx5D3Jhr3ESYm7YBX5dF?=
 =?us-ascii?Q?Hpv+YpGTerY5o5YPpuIsdiIR4u5hXyLXvrozgwZAlPzYAW4JCiLo/qmKLMFi?=
 =?us-ascii?Q?50rQQNxlbS848KWVVejmELUlIilt2EOfc2QKtUY3JaU1w2GazlCyTnmE9a7d?=
 =?us-ascii?Q?aU+kBgS4yY7iQ7dlvqoC1bjZQu7sDLJKzTAxXlbEZscHgA5x2NhDIQulITmR?=
 =?us-ascii?Q?Iv15j6Rkkzy9g/aAXfnOh9gY6XJNVK9+RYw6Ycso4EVNNdhV8fQmnp9vl8sw?=
 =?us-ascii?Q?jUM2cx+4rvYwUKcMS6MflGD2Cz1K41RMux23+Pbk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc5a96a-6b25-451f-12c7-08db842ce89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 05:41:01.8459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TjDEB/UMA1ie4gezJctOu7V/UGvcHLFBejjYBGvwhQkfLhymmxtXQ7/KStL0UWssqHqjoRIv1RnPfKUMbS7fQ==
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

Please ignore this email. It was sent as a mistake.=20

> -----Original Message-----
> From: Ang, Tien Sung <tien.sung.ang@intel.com>
> Sent: Friday, 14 July, 2023 11:33 AM
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

