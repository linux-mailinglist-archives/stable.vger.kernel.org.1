Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6887063FE
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjEQJVU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEQJVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 05:21:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BC4212
        for <stable@vger.kernel.org>; Wed, 17 May 2023 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684315277; x=1715851277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m+sXRYSCJ2x9RDr0wsqHS3mGGEK7ssytlvY1etfmurw=;
  b=GYkH4DBP0hB0NyOFjzPo72zFU8f8FzERVQbwWCnmDAxs+2V6ligQE01l
   5SCUHC5CCU2D9CvnGZ86q0xm7v56sO//v23yeHF5Ss46uevHDbXD1mCH8
   mbF48FdfjrnNxRCEfZVh6EO891I64yphZZmKYpScxb7OI6CpIWAs4LqT8
   lzgLHaK6U9RXOoozdnnTIAPbWhPOdYH5b2a3an8O+NHYUJ+slwAR0dyrY
   eiVyKFvg1JQ7oAuzF8JNMTgOUWQRYNht5UCUji+DNRaeSFGMHEJK5a+2G
   XkIcrfco93Tru5b/Qfc5a2oFmqRYwXoIAxx2uO/FMVk0+uGK/vkwk6syH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438054409"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="438054409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 02:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766702735"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="766702735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2023 02:21:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 02:21:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 02:21:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 02:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfgjcoGildVjSLP0j/tAwlwNxZFxaiH03UoFGwpjH+FY8pODhprY03q/ji5zOmQxoFwbqpQAjloKHKjXJS2eBaNu4pyUtSNDPmmjSZL4TC9vIwf8JFzjg/Z4RvvtHt84tlh9PNW3WTgPoPu4w/jNa1fnh6SDl05NjFNlMnWrBSOIu39ZQtcvQHKj25K1i90wDbzd8Fug0vM/UFS4UDmHbJP78tguV+l6ZLcXcXCl1EhTX888+ypULb/Ccx6Bx3jRqPFOzs9sIDGfBM7QOdq3Aipzi8pmbzi8YMkQ4UAubO8KMA4dAzI2Tsp26YvSRmPUz7ciWnojER60BtCwzFlTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+sXRYSCJ2x9RDr0wsqHS3mGGEK7ssytlvY1etfmurw=;
 b=UFs2M2cQ7sW70tGpkPDAda+QbkcSFwbRsGYd8OGhsGeHU7ZJ1rPQqcQ5A/fFK7sYrw9nAmG4ebWxCNj+xaK7JakfGOoMBBNFumMCa8LZDc48s6u1pMTZoKwp4xZhoXbr6iBOMSZCH5niPWVOHa1RF9Gd67+VV2dGLmHkJzzn+iXjFeUrDH/2/kmp3vcU20V+0APx1QeP4zSNwvDaDglkeliWbR1GHEBI5nehCz6uLjxl8XiTNdOWdYv9B3Rsg42MqDEMaL02zyI8PYftoazlf3rbdslDpXgjQIQURQ0sMJAz2cXHl31Rem7iP5+PRkF2UanTzxm3IIwmp9SaLY4zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 PH8PR11MB6901.namprd11.prod.outlook.com (2603:10b6:510:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 09:21:14 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::2796:34e3:dbb9:fe97]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::2796:34e3:dbb9:fe97%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 09:21:13 +0000
From:   "Hogander, Jouni" <jouni.hogander@intel.com>
To:     "eric.brunet@ens.fr" <eric.brunet@ens.fr>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>
CC:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression on drm/i915, with bisected commit
Thread-Topic: Regression on drm/i915, with bisected commit
Thread-Index: AQHZh/cW0ZNioEgrxEeZArV6FtqNB69dks4AgACfGQA=
Date:   Wed, 17 May 2023 09:21:12 +0000
Message-ID: <1514d06b59d8270455d47362aa85384b08682bcd.camel@intel.com>
References: <3236901.44csPzL39Z@skaro> <ZGQXELf3MSt4oUsR@debian.me>
In-Reply-To: <ZGQXELf3MSt4oUsR@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|PH8PR11MB6901:EE_
x-ms-office365-filtering-correlation-id: e2e97cb3-30f4-45c8-daeb-08db56b80ede
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/tcMDfXt1MnNdj7KuYyXjEdrC4nvOQvBJJgaalNCFefqgrRB8NWrfVgW3/GSAXZhVukcpKKEzxmBSfTeYdK6zgXS/ghjs60DMF646hsrMfKvuOMh8u02G51gMr0iRqYey75mPevImiCJlpjGde8xz3b/jkpjwdTWpqIhlLt8i5P6cflMKDtl+m5oYWtAeS2AoLZTSC8Idku8PvWqJqpdE1axwQS3kBOLhyTb0tr0+nwH9GG5JlHgvzS9uNbou2ZUkQL5MQk9L1KO+AyYeqjAAAEnWYaJpWxc6jhJaxf9svznE583TknCLdUriJJ4L2M95DTtF3+lBE6OrJqsF7PRDnCYznuRlQZFv3sLDgwC5FIcsWkgGCeswrsnSupLEeWWUSDY9/vnE1oQGrPW9vckef3EUNnvDsGps1xz8OEH0sbgvWwvMoQRosZs1wXsHUYTpI4KcSQ6zYyc+YzTBGN9cLJrvKfV+lYPJmREoXY33P4m7DMCJ6QKCSHoq6EZYXEfi8iVkn7pVOIlVccOk7DHxEx58MOKAGIOaTR9IT/ulMoPfUFWYxs6nxItBKW5DEQ99xIerW96WpAoYq5RTmN2k6RspVafuKxlOcxyVP+LfModHWGIKZ3dcIuVDw3cJNwCoqWC/9yU4kXZXxSBIJdKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(83380400001)(66574015)(91956017)(966005)(478600001)(6486002)(110136005)(71200400001)(54906003)(2616005)(6512007)(6506007)(26005)(186003)(2906002)(8936002)(8676002)(5660300002)(36756003)(122000001)(41300700001)(82960400001)(38100700002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(316002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1JSU0pQT2UrcUtZUVVqTjQ0d3Y4RUlqdGRWUWxNczFHQ3Q5dVJMWFQ3MVZX?=
 =?utf-8?B?WW9hT3dMOWhwNS9HN3lSeVJNa2JtTDI1cGdYTTY4TExRVGYxY0xLWUZFcEpt?=
 =?utf-8?B?SFlZWDVyTVdmNGtWSms3RXJJOFBnS21JUTc2TzcxSDNiMEkrSG1nZWg5ZHpp?=
 =?utf-8?B?NXJQT0tzejVJczFRUzQ4VVNITkJldzVNNEhrV1MycmZvTDNqd29uclVXMzNK?=
 =?utf-8?B?VEFwcm80TC9WZkNoS0hJTHJOaWdKY0JBZE4rT2FxY040bktyYitWSXF3MTNy?=
 =?utf-8?B?VjU1UnY5dkg1T0dJRUJHVXZ6cStHMnFFMElIeXNhVStGSmhHRk5DKzlJdEYy?=
 =?utf-8?B?Y0g4ZGVjK3JUQU9lN1FxVVZCZnIrM3U2QmNzVVZxdGhpRE0zQ2p1NnBRUWk4?=
 =?utf-8?B?STBaVUd0VjNSWTJ6NnJENTZBVjZleVNuRWRUdDhXdnAzdlhXVzlUWVFKRFJN?=
 =?utf-8?B?OXhSUGc5N0hIMm5TWFh0ajNLL0taQ1JXQ05nL1JyWlNJc1NLUk91KzdaYm1Y?=
 =?utf-8?B?Smd5aDlGTHR2SmNJRFFPRkFUSnBZdEZvdGdqSWZKZEhwdTFlRkpBcy9XVHEx?=
 =?utf-8?B?WisyWDRaNnczSjBjU0tFNUMxWjRmd0VHWS9pWm03TkZBYWkrVGZiOE9KYVNZ?=
 =?utf-8?B?MTZPYXdjQzdjbnRjTy9vMGVkclJUVzVueEROZFdjaDVuM3JtUm4velVLa05Q?=
 =?utf-8?B?K1lpSzdDZWx2VlI2MS8wa2s0RUNkUXNXOERIcnlYY2d0V21nRFBJekwxYndP?=
 =?utf-8?B?ZjNsT2Z6VG5ObEtTVERuUUgwTExlU0hhOVBROWptMVloeW1CbDh2ZUZmRCtU?=
 =?utf-8?B?SUxyL0lpcGUwVjdzdVp4R2pzeVFoWXp4Y3VCT2o2OVpWV1c5MEpsc0hBbXNh?=
 =?utf-8?B?MmFyY0NqeUV1TEJ1L1BlNUhDckp4RHdrVkJCdk1yckVrc2tsa3FjYTZyT2Ri?=
 =?utf-8?B?OU5OczVuaTQ1akRqMnpVQkdmVWgybjhnZFFKWWFrK0xZZVJzRDJaOUpMYWd6?=
 =?utf-8?B?NGpIbUNNSTFIbnBmRVBQZUk2eWZSc3RySVI0VjI2UlM1ZDRRQnlqcXRHcmVp?=
 =?utf-8?B?TFdvTnF6Uktzc3dLR0VHdmdCM0ZxYzY5T1YrZ1ErMGJMM0tUZ1R3ckNYQU52?=
 =?utf-8?B?azRQRHZLcWxrYmtpWWlLQzZvbmVwQVlmdGV3N1M4K0ltMi9nQ1JYalZBL05q?=
 =?utf-8?B?Zkc0Y0cvZkJKWTQ2Zk8zZlRudmZUS2JuSFM0cS95bURaZU5zWktiNHB2Wk84?=
 =?utf-8?B?Y21BNTNpNCtNbXh1SloyN3gxWE05MmZvUnJHOEpmZ1h6Qmp1SEJNSFk5THJU?=
 =?utf-8?B?aUtoN2NFT0ZVU1ZoMnNjMGttbEFkZHpRSFVxVURvRDk4aVlYV0tiZ2Q4QXRZ?=
 =?utf-8?B?S1FIYkhjZFJ2azZTSzE1S1pWT21tR3Bkcnc5UWRHUEdjTW5xaFBYSXdKOHA3?=
 =?utf-8?B?WFRFdVdyMHU5ZDNFaUZLT3dhTWZ1dFZWWU84THZiUTZhUjM3dVVkdUlPc1Aw?=
 =?utf-8?B?VEdLVmRJSGNFeC84UFlVeTduL05CaWhjZDFub1drM2gxR0hxeWtsa0ZYMjZm?=
 =?utf-8?B?WE1SWkVuelZQQjMzaFM4MTRidWsrR0NqODFEY0NrQURhekYySXVOb0RCdmlN?=
 =?utf-8?B?clZFSkdZZU5YeWZ4ZmdoclF3dDFWVklKWkV1bzdsdm9RSExhN29Nd2pySWto?=
 =?utf-8?B?R2EyM1BXN2RoWXNjWHcxRG5QeElYemdqd1FqQ2NSb1crcWZhdlFkMDBuVFlj?=
 =?utf-8?B?bndQZU40MSt2L3V4czMzVXhzUDhxU3k4c0dEblJ2T3ZWTHlTTFdJMHNvaXk4?=
 =?utf-8?B?ckpqc0Y5YVF1ZVl1UmdKeTNkekFuVGhudnZRemxPY2o5WEFCRS9QaG5QTTVo?=
 =?utf-8?B?cjlMTmNnYW91MDA3RHN5SG13bGNYcnNlMWwyckVZb24xN2pMSUgwMHFRVFY1?=
 =?utf-8?B?MGhWdVV5eWRoTEFFdnY3MXVLUVUvcVVqTHZMdGlwb2VRVVZMOGw5QithQ0Fz?=
 =?utf-8?B?bTRJZmVrT3ZZVS8vU3NmaDZJaUgxR2VLOUdjWHRTUEhCdHAydk9Db3pFRWw1?=
 =?utf-8?B?NlFIeHVhemcvZkR6ZG00Ni9LMHBpNEMwYURnR1gwWThaZm1wanl5V0o5ZFoy?=
 =?utf-8?B?STBpSWY2ZEZLOGloV1hGcjY5WlFPNnZrRnJtMWdYRXIyc3FCRmI0VUIvcFQv?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <173401CE9A814E4AB3C1AB991B919660@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e97cb3-30f4-45c8-daeb-08db56b80ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 09:21:12.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCCIjC6/3EOWHziay0JDp69OcSWEpktM4BKhEYnbckhEXlPcjIQ7gDP2YmWT5zUv8+dn26BpVLisK0qgR6zVKSZr5+rdtrxsHEzU1FSwZxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6901
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGVsbG8sDQoNCk9uIFdlZCwgMjAyMy0wNS0xNyBhdCAwNjo1MSArMDcwMCwgQmFnYXMgU2FuamF5
YSB3cm90ZToNCj4gT24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMDM6MDQ6NTNQTSArMDIwMCwgw4ly
aWMgQnJ1bmV0IHdyb3RlOg0KPiA+IEhlbGxvIGFsbCwNCj4gPiANCj4gPiBJIGhhdmUgYSBIUCBF
bGl0ZSB4MzYwIDEwNDkgRzkgMi1pbi0xIG5vdGVib29rIHJ1bm5pbmcgZmVkb3JhIDM4DQo+ID4g
d2l0aCBhbiBBZGxlciANCj4gPiBMYWtlIGludGVsIHZpZGVvIGNhcmQuDQo+ID4gDQo+ID4gQWZ0
ZXIgdXBncmFkaW5nIHRvIGtlcm5lbCA2LjIuMTMgKGFzIHBhY2thZ2VkIGJ5IGZlZG9yYSksIEkg
c3RhcnRlZA0KPiA+IHNlZWluZyANCj4gPiBzZXZlcmUgdmlkZW8gZ2xpdGNoZXMgbWFkZSBvZiBy
YW5kb20gcGl4ZWxzIGluIGEgdmVydGljYWwgYmFuZA0KPiA+IG9jY3VweWluZyBhYm91dCANCj4g
PiAyMCUgb2YgbXkgc2NyZWVuLCBvbiB0aGUgcmlnaHQuIFRoZSBnbGl0Y2hlcyB3b3VsZCBoYXBw
ZW4gYm90aCB3aXRoDQo+ID4gWC5vcmcgYW5kIA0KPiA+IHdheWxhbmQuDQo+ID4gDQo+ID4gSSBj
aGVja2VkIHRoYXQgdmFuaWxsYSA2LjIuMTIgZG9lcyBub3QgaGF2ZSB0aGUgYnVnIGFuZCB0aGF0
IGJvdGgNCj4gPiB2YW5pbGxhIA0KPiA+IDYuMi4xMyBhbmQgdmFuaWxsYSA2LjMuMiBkbyBoYXZl
IHRoZSBidWcuDQo+ID4gDQo+ID4gSSBiaXNlY3RlZCB0aGUgcHJvYmxlbSB0byBjb21taXQNCj4g
PiBlMmI3ODliYzNkYzM0ZWRjODdmZmI4NTYzNDk2N2QyNGVkMzUxYWNiIChpdCANCj4gPiBpcyBh
IG9uZS1saW5lciByZXByb2R1Y2VkIGF0IHRoZSBlbmQgb2YgdGhpcyBtZXNzYWdlKS4NCj4gPiAN
Cj4gPiBJIGNoZWNrZWQgdGhhdCB2YW5pbGxhIDYuMy4yIHdpdGggdGhpcyBjb21taXQgcmV2ZXJ0
ZWQgZG9lcyBub3QNCj4gPiBoYXZlIHRoZSBidWcuDQo+ID4gDQo+IA0KPiBDYW4geW91IGFsc28g
Y2hlY2sgdGhhdCBpdHMgbWFpbmxpbmUgY291bnRlcnBhcnQgKGUxYzcxZjhmOTE4MDQ3YykNCj4g
YWxzbw0KPiBleGhpYml0cyB0aGlzIHJlZ3Jlc3Npb24/DQo+IA0KPiA+IEkgYW0gQ0MtaW5nIGV2
ZXJ5IGUtbWFpbCBhcHBlYXJpbmcgaW4gdGhpcyBjb21taXQgLCBJIGhvcGUgdGhpcyBpcw0KPiA+
IG9rLCBhbmQgSSANCj4gPiBhcG9sb2dpemUgaWYgaXQgaXMgbm90Lg0KPiA+IA0KPiA+IEkgaGF2
ZSBmaWxsZWQgYSBmZWRvcmEgYnVnIHJlcG9ydCBhYm91dCB0aGlzLCBzZWUNCj4gPiBodHRwczov
L2J1Z3ppbGxhLnJlZGhhdC5jb20vDQo+ID4gc2hvd19idWcuY2dpP2lkPTIyMDM1NDkgLiBZb3Ug
d2lsbCBmaW5kIHRoZXJlIGEgc21hbGwgdmlkZW8gKG1hZGUNCj4gPiB3aXRoIGZlZG9yYSANCj4g
PiBrZXJuZWwgMi42LjE0KSBkZW1vbnN0cmF0aW5nIHRoZSBpc3N1ZS4NCj4gPiANCj4gPiBTb21l
IG1vcmUgZGV0YWlsczoNCj4gPiANCj4gPiAlIHN1ZG8gbHNwY2kgLXZrIC1zIDAwOjAyLjANCj4g
PiAwMDowMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEFs
ZGVyIExha2UtVVAzDQo+ID4gR1QyIFtJcmlzIA0KPiA+IFhlIEdyYXBoaWNzXSAocmV2IDBjKSAo
cHJvZy1pZiAwMCBbVkdBIGNvbnRyb2xsZXJdKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIERldmljZU5h
bWU6IE9uYm9hcmQgSUdEDQo+ID4gwqDCoMKgwqDCoMKgwqAgU3Vic3lzdGVtOiBIZXdsZXR0LVBh
Y2thcmQgQ29tcGFueSBEZXZpY2UgODk2ZA0KPiA+IMKgwqDCoMKgwqDCoMKgIEZsYWdzOiBidXMg
bWFzdGVyLCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTQzDQo+ID4gwqDCoMKgwqDCoMKg
wqAgTWVtb3J5IGF0IDYwM2MwMDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MTZNXQ0KPiA+IMKgwqDCoMKgwqDCoMKgIE1lbW9yeSBhdCA0MDAwMDAwMDAwICg2NC1iaXQsIHBy
ZWZldGNoYWJsZSkgW3NpemU9MjU2TV0NCj4gPiDCoMKgwqDCoMKgwqDCoCBJL08gcG9ydHMgYXQg
MzAwMCBbc2l6ZT02NF0NCj4gPiDCoMKgwqDCoMKgwqDCoCBFeHBhbnNpb24gUk9NIGF0IDAwMGMw
MDAwIFt2aXJ0dWFsXSBbZGlzYWJsZWRdIFtzaXplPTEyOEtdDQo+ID4gwqDCoMKgwqDCoMKgwqAg
Q2FwYWJpbGl0aWVzOiBbNDBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVuPTBjIDw/
Pg0KPiA+IMKgwqDCoMKgwqDCoMKgIENhcGFiaWxpdGllczogWzcwXSBFeHByZXNzIFJvb3QgQ29t
cGxleCBJbnRlZ3JhdGVkDQo+ID4gRW5kcG9pbnQsIE1TSSAwMA0KPiA+IMKgwqDCoMKgwqDCoMKg
IENhcGFiaWxpdGllczogW2FjXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlKyA2NGJp
dC0NCj4gPiDCoMKgwqDCoMKgwqDCoCBDYXBhYmlsaXRpZXM6IFtkMF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDINCj4gPiDCoMKgwqDCoMKgwqDCoCBDYXBhYmlsaXRpZXM6IFsxMDBdIFByb2Nl
c3MgQWRkcmVzcyBTcGFjZSBJRCAoUEFTSUQpDQo+ID4gwqDCoMKgwqDCoMKgwqAgQ2FwYWJpbGl0
aWVzOiBbMjAwXSBBZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2UgKEFUUykNCj4gPiDCoMKgwqDC
oMKgwqDCoCBDYXBhYmlsaXRpZXM6IFszMDBdIFBhZ2UgUmVxdWVzdCBJbnRlcmZhY2UgKFBSSSkN
Cj4gPiDCoMKgwqDCoMKgwqDCoCBDYXBhYmlsaXRpZXM6IFszMjBdIFNpbmdsZSBSb290IEkvTyBW
aXJ0dWFsaXphdGlvbiAoU1ItSU9WKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIEtlcm5lbCBkcml2ZXIg
aW4gdXNlOiBpOTE1DQo+ID4gwqDCoMKgwqDCoMKgwqAgS2VybmVsIG1vZHVsZXM6IGk5MTUNCj4g
PiANCj4gPiBSZWxldmFudCBrZXJuZWwgYm9vdCBtZXNzYWdlczogKGFwcGFydCBmcm9tIHRpbWVz
dGFtcHMsIHRoZXNlIGxpbmVzDQo+ID4gYXJlIA0KPiA+IGlkZW50aWNhbCBmb3IgNi4yLjEyIGFu
ZCA2LjIuMTQpOg0KPiA+IA0KPiA+IFvCoMKgwqAgMi43OTAwNDNdIGk5MTUgMDAwMDowMDowMi4w
OiB2Z2FhcmI6IGRlYWN0aXZhdGUgdmdhIGNvbnNvbGUNCj4gPiBbwqDCoMKgIDIuNzkwMDg5XSBp
OTE1IDAwMDA6MDA6MDIuMDogW2RybV0gVXNpbmcgVHJhbnNwYXJlbnQgSHVnZXBhZ2VzDQo+ID4g
W8KgwqDCoCAyLjc5MDQ5N10gaTkxNSAwMDAwOjAwOjAyLjA6IHZnYWFyYjogY2hhbmdlZCBWR0Eg
ZGVjb2RlczogDQo+ID4gb2xkZGVjb2Rlcz1pbyttZW0sZGVjb2Rlcz1pbyttZW06b3ducz1pbytt
ZW0NCj4gPiBbwqDCoMKgIDIuNzkzODEyXSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gRmluaXNo
ZWQgbG9hZGluZyBETUMNCj4gPiBmaXJtd2FyZSBpOTE1Lw0KPiA+IGFkbHBfZG1jX3ZlcjJfMTYu
YmluICh2Mi4xNikNCj4gPiBbwqDCoMKgIDIuODI1MDU4XSBpOTE1IDAwMDA6MDA6MDIuMDogW2Ry
bV0gR3VDIGZpcm13YXJlDQo+ID4gaTkxNS9hZGxwX2d1Y183MC5iaW4gDQo+ID4gdmVyc2lvbiA3
MC41LjENCj4gPiBbwqDCoMKgIDIuODI1MDYxXSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gSHVD
IGZpcm13YXJlDQo+ID4gaTkxNS90Z2xfaHVjLmJpbiB2ZXJzaW9uIA0KPiA+IDcuOS4zDQo+ID4g
W8KgwqDCoCAyLjg0MjkwNl0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEh1QyBhdXRoZW50aWNh
dGVkDQo+ID4gW8KgwqDCoCAyLjg0Mzc3OF0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEd1QyBz
dWJtaXNzaW9uIGVuYWJsZWQNCj4gPiBbwqDCoMKgIDIuODQzNzc5XSBpOTE1IDAwMDA6MDA6MDIu
MDogW2RybV0gR3VDIFNMUEMgZW5hYmxlZA0KPiA+IFvCoMKgwqAgMi44NDQyMDBdIGk5MTUgMDAw
MDowMDowMi4wOiBbZHJtXSBHdUMgUkM6IGVuYWJsZWQNCj4gPiBbwqDCoMKgIDIuODQ1MDEwXSBp
OTE1IDAwMDA6MDA6MDIuMDogW2RybV0gUHJvdGVjdGVkIFhlIFBhdGggKFBYUCkNCj4gPiBwcm90
ZWN0ZWQgDQo+ID4gY29udGVudCBzdXBwb3J0IGluaXRpYWxpemVkDQo+ID4gW8KgwqDCoCAzLjk2
NDc2Nl0gW2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDIwMTEwMyBmb3INCj4gPiAwMDAw
OjAwOjAyLjAgb24gbWlub3IgDQo+ID4gMQ0KPiA+IFvCoMKgwqAgMy45Njg0MDNdIEFDUEk6IHZp
ZGVvOiBWaWRlbyBEZXZpY2UgW0dGWDBdIChtdWx0aS1oZWFkOiB5ZXPCoA0KPiA+IHJvbTogbm/C
oCANCj4gPiBwb3N0OiBubykNCj4gPiBbwqDCoMKgIDMuOTY4OTgxXSBpbnB1dDogVmlkZW8gQnVz
IGFzDQo+ID4gL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvDQo+ID4gUE5QMEEwODow
MC9MTlhWSURFTzowMC9pbnB1dC9pbnB1dDE4DQo+ID4gW8KgwqDCoCAzLjk3Nzg5Ml0gZmJjb246
IGk5MTVkcm1mYiAoZmIwKSBpcyBwcmltYXJ5IGRldmljZQ0KPiA+IFvCoMKgwqAgMy45Nzc4OTld
IGZiY29uOiBEZWZlcnJpbmcgY29uc29sZSB0YWtlLW92ZXINCj4gPiBbwqDCoMKgIDMuOTc3OTA0
XSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gZmIwOiBpOTE1ZHJtZmIgZnJhbWUgYnVmZmVyDQo+
ID4gZGV2aWNlDQo+ID4gW8KgwqDCoCA0LjAyNjEyMF0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1d
IFNlbGVjdGl2ZSBmZXRjaCBhcmVhDQo+ID4gY2FsY3VsYXRpb24gDQo+ID4gZmFpbGVkIGluIHBp
cGUgQQ0KPiA+IA0KPiA+IElzIHRoZXJlIGFueXRoaW5nIGVsc2UgSSBzaG91bGQgcHJvdmlkZT8g
SSBhbSB3aWxsaW5nIHRvIHJ1biBzb21lDQo+ID4gdGVzdHMsIG9mIA0KPiA+IGNvdXJzZS4NCg0K
Q291cGxlIG9mIGV4cGVyaW1lbnQgeW91IGNvdWxkIGRvOg0KDQpUcnkgZGlzYWJsaW5nIFBTUiBj
b21wbGV0ZWx5IGJ5IGFkZGluZyAiaTkxNS5lbmFibGVfcHNyPTAiIGludG8geW91cg0Ka2VybmVs
IHBhcmFtZXRlcnMNCg0KaWYgdGhpcyBoZWxwcyBvbiB5b3VyIGlzc3VlIHJlbW92ZSAiaTkxNS5l
bmFibGVfcHNyPTAiIGZyb20ga2VybmVsDQpwYXJhbWV0ZXJzIGFuZCB0cnkgdXNpbmcgbW9yZSBs
b29zZSBQU1IgbGF0ZW5jeSBjb25maWd1cmF0aW9uIGJ5IGFkZGluZw0KImk5MTUucHNyX3NhZmVz
dF9wYXJhbXM9MSIgaW50byB5b3VyIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXJzLg0KDQpUaGFuayBZ
b3UgaW4gYWR2YW5jZSwNCg0KSm91bmkgSMO2Z2FuZGVyDQoNCj4gPiANCj4gDQo+IEFueXdheSwg
dGhhbmtzIGZvciByZWdyZXNzaW9uIHJlcG9ydC4gSSdtIGFkZGluZyBpdCB0byByZWd6Ym90Og0K
PiANCj4gI3JlZ3pib3QgXmludHJvZHVjZWQ6IGUyYjc4OWJjM2RjMzRlZA0KPiAjcmVnemJvdCB0
aXRsZTogU2VsZWN0aXZlIGZldGNoIGFyZWEgY2FsY3VsYXRpb24gcmVncmVzc2lvbiBvbiBBbGRl
cg0KPiBMYWtlIGNhcmQNCj4gI3JlZ3pib3QgbGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQu
Y29tL3Nob3dfYnVnLmNnaT9pZD0yMjAzNTQ5wqANCj4gDQoNCg==
