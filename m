Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32627CB289
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJPSah (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjJPSag (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 14:30:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF8E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697481030; x=1729017030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=02vYH80ejB5Zf4msJzrw0dX/XtcdSH2WyPNyPwNNUKY=;
  b=H36wNsrGfrZxI3TPMyIhC+v+sbNrbAcMdzovrjCeQTy5z/wpPxxAnxlP
   Z04UNKfVmFMVu7fr6DaYm7dUygrmyR6QtkREdyq2iYvZf/DDU6l058zqD
   /jfIrF744NTBxRmYSrO1tTcrj+YONhacDL6ckVcvt0x+WyHMZquffT8qd
   YfnUIET6EKnSy5sDq+gcfILDVCKQ2ZmZkb+yt1mdqqemuk+/afzU9adRf
   dhLnBzjvofn87mth9+JM3naaX57CWTKO23exT0tXIjziKelE6I0Q8prA9
   WbBNIZ+4DTW6awR3kYnImHVKfEWGhQDw5qjBoqA+Iqig+aryq/OPSZeFT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388470481"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="388470481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 11:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821664501"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="821664501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 11:30:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 11:30:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 11:30:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 11:30:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 11:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obdBRKgBdZoDFNlfacdslAUGKIxIdUOBKE1R7Y5MJOwERGyzBPhPXt6/sf5bvuUrlJOLRas4QVFrN7Zb56GZLdeT+wSTB4V1Ilh2pw/oTqIPg7+5wzHmt6Cba/DaCyvS8am5Ip20NgstReizzIf511EvDGYXo01WQc0j8eD8WZJVVFCQTnT6DiREFuA+FgvCzJeBQJ/eP3hilwJH5mP4g9ReIo8j8Qrc66XObibkCrlWLA78PSJSEb3dG40Dc65PREqNrZ3qhGWA0AUne/A5rN8OuCTsIXLG5vdc7LXH0CtJBkhl1RpAqS9NLuxzFtem6uYmGUp1hYWqfUbSQf0EDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7xQj5qkXYEg8UuCX5svszzzWoTEP/4235iKhq2vBU0=;
 b=AKhO9kOjwORaC0ytoR9AhQ+8I/BZ3sWas8OPCLWHz/WhUrWsWe9oJ6vW804BsUsQIsbUUOcUU+iGyG7Kaf5vvOTL3AbwcD1dbikvbTuE2m5jP5fWd/yELujMBZFGOKJctyWKYQTVDxJliueEIeFcaJcWmJeap0GQ73sDYFG2mWCUHJr/NamRS9cv0Rc03Du4oPYxpGfpQPMzhtX9N3j/5tgMLwlriRlGHD+WARaTJeyrfCG2UXPD3afMUkFeDKTYiGMOYRhVbsz+GUfn9YuN533aQiwis1+g8asfHpnnZPXWVSi1pbi6Gncjv+R2ecw8p36gTIVW31PUh2C5rPWGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2567.namprd11.prod.outlook.com (2603:10b6:a02:c5::32)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 18:30:25 +0000
Received: from BYAPR11MB2567.namprd11.prod.outlook.com
 ([fe80::c95e:8095:2c49:56cb]) by BYAPR11MB2567.namprd11.prod.outlook.com
 ([fe80::c95e:8095:2c49:56cb%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 18:30:25 +0000
From:   "Yang, Fei" <fei.yang@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/alternatives: Disable KASAN in
 apply_alternatives()
Thread-Topic: [PATCH 1/1] x86/alternatives: Disable KASAN in
 apply_alternatives()
Thread-Index: AQHaAEbWatELY5ySOUSsG2trukAnvbBMpLSAgAAXggA=
Date:   Mon, 16 Oct 2023 18:30:24 +0000
Message-ID: <BYAPR11MB25672563A4015B68BB9572759AD7A@BYAPR11MB2567.namprd11.prod.outlook.com>
References: <20231016154025.3358622-1-fei.yang@intel.com>
 <20231016154025.3358622-2-fei.yang@intel.com>
 <2023101650-monogamy-bobbing-33f9@gregkh>
In-Reply-To: <2023101650-monogamy-bobbing-33f9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2567:EE_|PH8PR11MB6856:EE_
x-ms-office365-filtering-correlation-id: 8d2e8fcd-aa69-45eb-5073-08dbce75f688
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFK6Z+uvct8BP4jJRBxqJSf7qYU/wXgUScWJlKBspFoeRwGtSJlAfTG5axevKTA81CNHvfMRR89E8Pem3PZcA+qtfe/Nh+kXeyUKXsBM7L5NVxztXHelYZ0ngYv0ETW4rXlrNZyF/amczGZ1pE3uFbXTZcFfijN1+CfWPWrecVz3e4qrEs5VM11D4S/fLjYhquliBWbPpHHu8JUq0zZdx1YfOX2mBcrCjpGFAimR+WenHr2SWkygu39WDNlN9iqb1ppOScuU4dxEjHnMZANk5b32j7898LycKaziaBZxfhYX2E7q12Uc4Dyjt5p1Z9rc0LowiZDbLY+hhDGdUuy63P9Hc/GtRvGZgO1+VnrXusuuxPWzOvJm0NdxPlMpBHpI+ACVdpn7Ko69GWHa/mPwOmC6+XRYDqeSFWAq/ZRUjCI0OPR+Bw0tZHaim3by7onBDh5KGSG0muZMyvBl1SDWX5B/zz8pW2z6zbr5lH94A8FhNMgpn8eyupAUwUjSsJG9HbfLOZFnGuqG/DDimnw71AJwXObGTJ/r9X7IZavv24D3ENgORbN3jsZZIITCyKUPNW+Z1JEX7WaRblh+3FThRaInsw8t/EBLkWVhssZM2EE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2567.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(52536014)(82960400001)(55016003)(26005)(38070700005)(8936002)(8676002)(4326008)(71200400001)(33656002)(5660300002)(38100700002)(122000001)(83380400001)(478600001)(41300700001)(86362001)(966005)(66946007)(2906002)(316002)(7696005)(6506007)(9686003)(76116006)(66446008)(66476007)(54906003)(64756008)(66556008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HPO3+DJJyfdB7TjB37Ub/Zj/9x5sZmA1gSy3fwo+jdaVwyi8pUrwqEkDWrpM?=
 =?us-ascii?Q?Qt8BZxJ79bMm2WV9mlx+mySWzmx8P1UIMq23YO1gEy4p1EmaEfM/sFfpEe6p?=
 =?us-ascii?Q?lyLfO17NXFMAXoiRD3mrG6GfgjNthAk6SXS+zRc+c/995EAW/BHIOTEfZUx1?=
 =?us-ascii?Q?hNIN4oJfj6ToEB3cT3UBuPL+JpEXEUfBZfluD4e83K9G9yjmN1gMS5uS3wfd?=
 =?us-ascii?Q?ycz6yG5+68RS06Msd3gJUwELGJgjDORemgxQTN62TKeuOnByUD9nGO91y9n4?=
 =?us-ascii?Q?c7IMw957t4u2oeWt0T9JzUb9mlHh8inVRlj4928BGu1oVGpzx1ieyT7ao95T?=
 =?us-ascii?Q?t9f6buCTtacN/4So13DpqNwI9exDtlfirf5isDLPTDgmYPScyF1U1Hnmaa6v?=
 =?us-ascii?Q?E7nfv/h1RPTwaKs6Ta65DeqgmB2b7JQyeDxLCaqx2DHr+bXh+Z/ZnULw3UCv?=
 =?us-ascii?Q?vtWWfCsMmq81Zw8/WVyw+auhpEri+cZnLmjl3CPbyLGao3YHvoO2KaactVWf?=
 =?us-ascii?Q?BBuRP4/QVGV3ZVET7X2cRTpcm+taGQYWdw+D6rRsEP8R4tbqKFf1vIUozEPp?=
 =?us-ascii?Q?xhXdPbNlV0whmljDeSJDQg14MjZzMQKJ/VErZ3GrUmanOwybEDYSFcQ89sKJ?=
 =?us-ascii?Q?sEvSO7O/Os3fl0Mj5w/u0wow8LPVUaOeHZjzJIDgbLKjYReN6IkTeJMl3Xb5?=
 =?us-ascii?Q?mM0DsxExja5HOW72U0ubrUOzzOXduIgv43n8J0V9NKbgtHSksUDSl6viXc/X?=
 =?us-ascii?Q?11H/FZmfRLMQ+BIQDF+gQ1XPmXAkc5Z4cPLwlEFN1crrhgImZs+j48gc/bVj?=
 =?us-ascii?Q?8DYBohPUX8H8GR1oh8q+ZlTflykkrdLmL78prRx4hf1Yxdp/JdOi8HCn+z3+?=
 =?us-ascii?Q?xBcFDHFbzZxPBihrSmJjCExUe6Oh68P7L7M709Q1+YJoNdyShnEXnDOEWDht?=
 =?us-ascii?Q?o/ScWVVkwZq0I+w27sgWfvY5Jvd1qCgU5NxRPp05x8V50dCuwpiTW9n4PzxT?=
 =?us-ascii?Q?V0BtZRV0l6LN6umLbc9v7TIkAPvbPcd8dQ37XBl4EyEbHaCFnA4rg1f1u8V5?=
 =?us-ascii?Q?HrR8oYzeiaNoJB9xTG8IbgYx5m5CyIu2/b8H9TQ9StuDl/Uqx+1V6Hwj6GZw?=
 =?us-ascii?Q?bKNRb9gTflYOY/zpL5kkfMSAx/YYjfBzCGqoL3LwUaq8MfZOz7yZdexfmG/A?=
 =?us-ascii?Q?gHn1EhQYE+IEc0z+2AQuleojvzLdz4Le0sESAnVYmj1XNp/66bZjOzEOEVts?=
 =?us-ascii?Q?YFBhtW8GVjXn9F92a8D1dcOnt2kGluAtV35/rbGxujt6OdzIFFQ/zwydfxi2?=
 =?us-ascii?Q?32DPr+gAlY5hCkbzjy/IzfSU5Munw3qmEU10t+1X8+FPfujsPH6aTEvaOYu/?=
 =?us-ascii?Q?gWKUaIVV8kGwq9k+X+8Dl8FJIx9NQygX7wLmqB4+Z8MBL5WknZ8ZQ+rTrjXm?=
 =?us-ascii?Q?INIfSZIbBsaEbNSd0Z2yGdjlVSacFoEXSsld0e9+7dAnSrP7aYHMX7JLPs/s?=
 =?us-ascii?Q?ObF69Romq1S1jpipfp78ggz7+9HE+jab2Bo3PorQ9K54AT0HllHaDpu9jrl+?=
 =?us-ascii?Q?O9yxc0jHrzwAD24XF2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2567.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2e8fcd-aa69-45eb-5073-08dbce75f688
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 18:30:24.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMqbVP22DLXbDj5CoFWUuAuqsH9u7+NRl/btcVCe6HsDOSrkeJYY0PaRjmH0hGsjzoeJL4FdHw96KSCtuJX8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> On Mon, Oct 16, 2023 at 08:40:24AM -0700, fei.yang@intel.com wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> Fei has reported that KASAN triggers during apply_alternatives() on a
>> 5-level paging machine:
>>
>>      BUG: KASAN: out-of-bounds in rcu_is_watching()
>>      Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
>>      ...
>>      __asan_load4()
>>      rcu_is_watching()
>>      trace_hardirqs_on()
>>      text_poke_early()
>>      apply_alternatives()
>>      ...
>>
>> On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
>> gets patched. It includes KASAN code, where KASAN_SHADOW_START depends
>> on __VIRTUAL_MASK_SHIFT, which is defined with cpu_feature_enabled().
>>
>> KASAN gets confused when apply_alternatives() patches the
>> KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
>> static, by replacing __VIRTUAL_MASK_SHIFT with 56, works around the issu=
e.
>>
>> Fix it for real by disabling KASAN while the kernel is patching alternat=
ives.
>>
>> [ mingo: updated the changelog ]
>>
>> Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if
>> CONFIG_X86_5LEVEL=3Dy")
>> Reported-by: Fei Yang <fei.yang@intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: stable@vger.kernel.org
>> Link:
>> https://lore.kernel.org/r/20231012100424.1456-1-kirill.shutemov@linux.
>> intel.com (cherry picked from commit
>> d35652a5fc9944784f6f50a5c979518ff8dacf61)
>> ---
>>  arch/x86/kernel/alternative.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>
> What stable tree(s) is this for?

Sorry for the noise, forgot to remove the Cc's. This is for our graphics CI=
.

> thanks,
>
> greg k-h
>
