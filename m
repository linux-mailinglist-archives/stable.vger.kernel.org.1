Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFA70433A
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 04:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEPCFi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjEPCFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 22:05:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E652103
        for <stable@vger.kernel.org>; Mon, 15 May 2023 19:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684202729; x=1715738729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHQHYbmku9Mh1E5nX+bbruipaadytumuuRWv+SRvDeU=;
  b=ho87908dFpQ2aRaUZVWlMNt3SJeIWPB3+EwO0aBGU6s6pUju+iwJMM+/
   1kFjevgPv4PsjZhqQYxQZstplDMeVxSYBcAZJCJXV5TNZfJqZSBK7vCde
   byC2mnIhA1yfpxJrLcc0SzYVzqC0Heoo/wQZ82xAxQmhzClRTcC2AdVNj
   Ojyt/tkEKeMo5U5FCWI9b9CbZhHyyTK/SbD10XLg84FHEjc/cQdxcV0kj
   4r/svJtPQ2jYjfl/nV5SOxwpSSq6svSn/ZkO0WMgWfq/l3VNLj+HYQS48
   EJh/N1PprmsB1mVkaLXTjzk5cE31LhxUNB1zaxGicRM/p8VBkBqQAvykQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="335904438"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="335904438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 19:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="766180386"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="766180386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2023 19:05:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 19:05:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 19:05:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 19:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwEft8VbJKxZ7YraF+LZBKr9ua7+tu4JIF48lxBUyp5l/EbMs/C+UuHFPeCFW1zZHXpUUsOvXlhwefykqU+iKcVvNJoNWV87FOoT09LakO1LIx6ndTcfJYQjrzMdvRGNvO2Ypjb2uouXsQlcG3lac9uJgfbh7rRgFMMkIapAQP6czxrWdM6LjgN2N05VJEoeOPu8usYzpMWXUy1+e9Sq0PCQQ0OMHxGyLNBvjKgV0h4qQzStO72YUj0WvDRB4vS7TRyuYheHaubcwfV/yA7JD8CCxMU2f1IwvMPqelWiR4FN5SJsljE20hUKPFmbI8wtdmlMJDGtkPYsUnM8SJyqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHQHYbmku9Mh1E5nX+bbruipaadytumuuRWv+SRvDeU=;
 b=J1hHCzOL6meSy7GpldwvVxm9xfq4dF8e9W5cvJaJA72DVMcgmfh0WDO9OBWZ0NCpx2UQeT/dSxSDYUKtm8uiFrkU+hk6SHbr6PkEOoNzxutFpxdYpTpqBZgScTr/krgPOqm04aoJnfMgp7Gcq0XZZ2BkI935vPwbzrlCoq4G+fL0DJDvOy4J/jv2XzY1mUu7EYS0m2qEU2pkq1Wq+PgBHzqMfr3pfZ11Ugi3gxNT8RnOsAgAaWgHfGaZA7dSi7Xziu5BPFYAuviXYW9jQ+BDncl07fvAhx0oLueHXEL6wR9EgvPMseYOSLGE6rqdM2+DFr+Bi5kvuu5/UBZPZF1UYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by MW4PR11MB7078.namprd11.prod.outlook.com (2603:10b6:303:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:05:05 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%3]) with mapi id 15.20.6387.027; Tue, 16 May 2023
 02:05:05 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "florian@bezdeka.de" <florian@bezdeka.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Brouer, Jesper" <brouer@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "naamax.meir@linux.intel.com" <naamax.meir@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] igc: read before write to SRRCTL register"
 failed to apply to 6.1-stable tree
Thread-Topic: FAILED: patch "[PATCH] igc: read before write to SRRCTL
 register" failed to apply to 6.1-stable tree
Thread-Index: AQHZgK90R4Iqi5B9REqNJLUBAFYwIa9UFJsAgAAMRYCAAITTUIAHCuWAgAB/S3A=
Date:   Tue, 16 May 2023 02:05:04 +0000
Message-ID: <PH0PR11MB5830FD700C469B8AFE79A5CFD8799@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <2023050749-deskwork-snowboard-82cf@gregkh>
 <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
 <2023051115-width-squeeze-319b@gregkh>
 <PH0PR11MB58305CBB67488FC9D6945208D8749@PH0PR11MB5830.namprd11.prod.outlook.com>
 <e0737a0b779ff06b135dd63a0f2926df@bezdeka.de>
In-Reply-To: <e0737a0b779ff06b135dd63a0f2926df@bezdeka.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|MW4PR11MB7078:EE_
x-ms-office365-filtering-correlation-id: c10c5513-f3a7-4aac-eb1c-08db55b1f752
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umvLxkKFqxk5mOgh4uFBBtpQd7b9l59/+pmM4/Qhwj4bLJAjJ03Wz/UVSVm/2avpw2sfXSSgAl0fzy3d61TgkEmQxk26V1V2XdlVmAX0JEuXN2CCbjorngNVtvEodzyzBBUGhd+3bJI2Ti5CtmYsLoZB1qFhmhlCPFxzoSci8Z4ysxj/HxlcAm/jrdUAKeuaJx3tfP50ckPIn/jSO71uuJc3FOArvhJuv66C87O4UIyFNbwzhPViGx9XTs/iUIcLZ50nmYLCvTqUdH3Ez7egoBK056sVl2f5dtxXxhRF8hZbaPVNB3HwjoaPXp0BgOrqnxGp69aM/3wy/zR0K7ds6n/WNyHMBn6fsUd+KJk9pXsEMr3GxYWwvtDAQiOps7yKkmTfn20iRTl20kMqIeX8BpngDC9w8O+kAUJZP9Dqov933EMTbhIDcu4htiSLv788zMF1UlTv8eQByD3EZhGdyMvH6Q4F4W25OM1QEW5PB+GrFaSUIxVoL3SZCR7WbjOsw6WsytppPXIm7ER4IWEkHmPLwKOsES2GgfUr26BQUs0kwyvCgngyrIzVp9ao+wFqF7HNvXEVubqjkz9x5cFR2PVgG1r1NbBfhz5YqxcG9jexs/bUrH+lEUCeYDqd5lc9ykLEuPsmwSuX7yG3ISR29A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(966005)(186003)(41300700001)(38100700002)(7696005)(53546011)(55236004)(71200400001)(6506007)(9686003)(83380400001)(26005)(55016003)(478600001)(54906003)(66899021)(6916009)(4326008)(66446008)(66556008)(66476007)(64756008)(82960400001)(76116006)(316002)(66946007)(122000001)(5660300002)(8936002)(8676002)(86362001)(52536014)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2Fud29SWWFCWFp5SHVpSysya1l0Qm55ckxQc1pXUzZ0a2NtZENRRyt3ZCtM?=
 =?utf-8?B?Wk0vR29CVVB2ZU5XOTFEQjAxb1RCajE4ckYrWWRJSDJjVjNkYktSVW91NlVo?=
 =?utf-8?B?cVV6UGY3WjJxK2NSWkJBN0NNUDFnbHd3YWVyL2hObkRkU1NndXZIeG93dzBv?=
 =?utf-8?B?aDU1ZVBRQmU4UVJjb20yRWUwM3dRUXF6OTJDcXZwbGFWYmdVV1B3bWJmb1ZN?=
 =?utf-8?B?VExvdjI3RnpSNU82QkU3VjExSFB3ZE1PQjI0bEZMQWF3WXNXU2IxZGZSUm8r?=
 =?utf-8?B?eTR4U3kzY1drZkVGTWxsVXFuTzZYWTJ1TXdIcjZxMmlleFdWcGhrYmRlODRv?=
 =?utf-8?B?Z3lqWWNROFR0eVFxemF3Q1h5eGJ2RzZETnExcG0vbWlQUGZVaU9ZTnhwTFpw?=
 =?utf-8?B?ZHFNSjc2dVRRb3pWandNVUFIQm54OEI1Wk9rNUJOMXJGQ2ZKbVI1RXJlYVYr?=
 =?utf-8?B?WjBMcjNWa3RYYkV6dlA2dHRqb3ZnMjFSTEljVkZRQlpCN1pnOHJEQzlOTDF1?=
 =?utf-8?B?WHhrZVlmMERtZGVPWmE1aURidzk4WkdFVUYxV0x6MGRJU3RvcFMrZEptTU9J?=
 =?utf-8?B?Z1NQU1NWRnlrbVNxaWRnM0hzUlYzR081WGY1ZHZuaFZTYW9MK3MwY1pReXBM?=
 =?utf-8?B?aHAwb1dVcGdDbksvRWJ6MlloSTVIcEZodkpqYW9iM3NpRW5WbWlnZHFYeGln?=
 =?utf-8?B?ajdWLzRueGxqek80Q3I1aDFZSEUyLzVONnFyU21obUFKVHNXZlcxcVpQMXR0?=
 =?utf-8?B?ejR4V2R4dWQxK2ZHbTdKek9NK2RKdGNwcXRRLzc3RFI3R3VqeUlPdjBVajMw?=
 =?utf-8?B?YkNUeHNZNi9UK2ZlV0hkRVowYWIzdmx1RndvdDNuYnBNY1FtcTVnQXZCZkRH?=
 =?utf-8?B?QVVSV2RyOEw2bzREZyszbDVnVithMnVobGxuV3F2azR5SEJIdUFXYlpHVEpO?=
 =?utf-8?B?Zm0xRk1pbnRmSWlhY0sralN0Uk9ITEgyTzlLNEk0Z0kxUStpZnM1c0VGaHBY?=
 =?utf-8?B?YWlveUpxWlNGb3lqTDN0QWdvWlpNUEpwV3o3RitYTVNuZWl2L3pZN0dxZnll?=
 =?utf-8?B?NE9nSGNHazlYd05QY2c4ZXBnNHZmaDh4TVVhMWR0elNnaU1VQVkzYjBYSDFG?=
 =?utf-8?B?dGdMVk9oRnlVdmoxUHRLc05pT2M2RDVleVFtbzVzZFVtcG5HTXJBaWIzK1Jh?=
 =?utf-8?B?Q2NlUGdUSTEvSm1QQVUxQWJUOWdpbGs2c3ZoeFpxVmNmMk5yYmwxSURhc2FC?=
 =?utf-8?B?SENCa2p0S0IvbDM3akgzcWZoaEdzbndUN3V1b1dZdmtVOW1jK20vbzExUEdU?=
 =?utf-8?B?dTV6Z3h1cHhZclBBRWx0NnBhWnhWMzY4a1p1aU5SOUpuNWpMQXlPK0dQVWxx?=
 =?utf-8?B?Wkt2ckZwS3ZWMzl6NXI2SmUzeVN5L0FjcmV6cGF3T3lpQjBIQUZ3UTlEMnR6?=
 =?utf-8?B?REV1Z3pRQysyQlVmN1R5VjFocFVheDlIb3ZRcXNiZG1iSnowL1NtZ1JGMWxE?=
 =?utf-8?B?b1lDUm5rb29XTkRINnV6U3gxaFhJRVJETklha1Y5N1NsYnFwZnhzRHlYMkxv?=
 =?utf-8?B?K29iYTJJaHdEWGlEaEZOSE9za01LbWt0S2V1Tm51L3oyWFYwMEZxTElGRGJT?=
 =?utf-8?B?SW9XeVVMZ0pkeCsrUzRTNStzQ0k0V3R6VGp5NXVXR3VxT0ZuRm5sczZPeEwz?=
 =?utf-8?B?UXhDNFJIL1dQSUJ5bm9kemh3NlQwaHVLNmZTSG1ZK2phZGZIaktFSUlsUGxW?=
 =?utf-8?B?K1VucVF3QWQrdUhPQ1c1V25VL3poY2VudzF1UjM4QnhScGhYWWxxUUhYR0RO?=
 =?utf-8?B?UWNLZ0NPNDlIR0JEdzRKZ3RxUnBSRVVCM1R0L2JmYlRFeVlTT09HQlFHSDg3?=
 =?utf-8?B?VnNBQ29IdkVYTDhjUVYzZVNQMEZoUjZuSDk3Tkx6NHNMTCtFdXBTUm1YcGxi?=
 =?utf-8?B?NHpZNTUybjdIYU05bjNNa3hET1RENHV2RlBDRTZDaFhCdmFJWGpwODlUeGFE?=
 =?utf-8?B?MzNzZzBJOStwdnI5Y3Q4bWZUZTVOV0laNjJqMmlzSDRRSml2VVg3QXNUQ3Fx?=
 =?utf-8?B?WkMyK3IzWGw1YjFsOVRlUTZIVVEzREplLzBjdVBYQnNwTDVodG1NMUZ3dWZz?=
 =?utf-8?B?L3lEZ3JGVmp5aVhjL2VMckJuSllWbUNvRmR2cFA1RjBVRXVwVmpDZjllcjBa?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10c5513-f3a7-4aac-eb1c-08db55b1f752
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 02:05:04.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USdUet8grxiGRDfdt8C2kg89HsVzCLhueYAGLtk5zzVRomyTs9pMNbrTD7PxZctY4pL84RLxH7EK0+cYLCeqOdIqCpLFKNzXddI3aIMheW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlc2RheSwgTWF5IDE2LCAyMDIzIDI6MTQgQU0sIGZsb3JpYW5AYmV6ZGVrYS5kZSA8Zmxv
cmlhbkBiZXpkZWthLmRlPiB3cm90ZToNCj5BbSAyMDIzLTA1LTExIDA4OjU2LCBzY2hyaWViIFNv
bmcsIFlvb25nIFNpYW5nOg0KPj4gT24gVGh1cnNkYXksIE1heSAxMSwgMjAyMyA2OjQ2IEFNICwg
R3JlZyBLSA0KPj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+PiBPbiBU
aHUsIE1heSAxMSwgMjAyMyBhdCAxMjowMTozNkFNICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3Jv
dGU6DQo+Pj4+IEhpIGFsbCwNCj4+Pj4NCj4+Pj4gT24gMDcuMDUuMjMgMDg6NDQsIGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0KPj4+PiA+DQo+Pj4+ID4gVGhlIHBhdGNoIGJlbG93
IGRvZXMgbm90IGFwcGx5IHRvIHRoZSA2LjEtc3RhYmxlIHRyZWUuDQo+Pj4+ID4gSWYgc29tZW9u
ZSB3YW50cyBpdCBhcHBsaWVkIHRoZXJlLCBvciB0byBhbnkgb3RoZXIgc3RhYmxlIG9yDQo+Pj4+
ID4gbG9uZ3Rlcm0gdHJlZSwgdGhlbiBwbGVhc2UgZW1haWwgdGhlIGJhY2twb3J0LCBpbmNsdWRp
bmcgdGhlDQo+Pj4+ID4gb3JpZ2luYWwgZ2l0IGNvbW1pdCBpZCB0byA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4uDQo+Pj4+ID4NCj4+Pj4gPiBUbyByZXByb2R1Y2UgdGhlIGNvbmZsaWN0IGFuZCBy
ZXN1Ym1pdCwgeW91IG1heSB1c2UgdGhlIGZvbGxvd2luZw0KPmNvbW1hbmRzOg0KPj4+PiA+DQo+
Pj4+ID4gZ2l0IGZldGNoDQo+Pj4+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC8NCj4+Pj4gPiBsaW51eC02LjEueSBnaXQg
Y2hlY2tvdXQgRkVUQ0hfSEVBRCBnaXQgY2hlcnJ5LXBpY2sgLXgNCj4+Pj4gPiAzY2UyOWMxN2Rj
ODQ3YmY0MjQ1ZTE2YWFkNzhhNzYxN2FmYTk2Mjk3DQo+Pj4+ID4gIyA8cmVzb2x2ZSBjb25mbGlj
dHMsIGJ1aWxkLCB0ZXN0LCBldGMuPiBnaXQgY29tbWl0IC1zIGdpdA0KPj4+PiA+IHNlbmQtZW1h
aWwgLS10byAnPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+JyAtLWluLXJlcGx5LXRvDQo+Pj4+ID4g
JzIwMjMwNTA3NDktDQo+Pj4gZGVza3dvcmstc25vd2JvYXJkLTgyY2ZAZ3JlZ2toJyAtLXN1Ympl
Y3QtcHJlZml4ICdQQVRDSCA2LjEueScgSEVBRF4uLg0KPj4+Pg0KPj4+PiBJcyBzb21lb25lIGFs
cmVhZHkgd29ya2luZyBvbiB0aGF0PyBJIHdvdWxkIGxvdmUgdG8gc2VlIHRoaXMgcGF0Y2gNCj4+
Pj4gaW4gNi4xLiBJZiBubyBmdXJ0aGVyIGFjdGl2aXRpZXMgYXJlIHBsYW5uZWQgSSBtaWdodCBo
YXZlIHRoZQ0KPj4+PiBvcHRpb24vdGltZSB0byBzdXBwbHkgYSBiYWNrcG9ydCBhcyB3ZWxsLg0K
Pj4+DQo+Pj4gUGxlYXNlIHN1cHBseSBhIGJhY2twb3J0LCBJIGRvbid0IHRoaW5rIGFueW9uZSBp
cyB3b3JraW5nIG9uIGl0IDopDQo+Pg0KPj4gSGkgRmxvcmlhbiwNCj4+DQo+PiBJIG5vdCB5ZXQg
Z290IHBsYW4gdG8gYmFja3BvcnQgdGhlIHBhdGNoLCBzbyBJIGFtIG1vcmUgdGhhbiBoYXBweSBp
Zg0KPj4geW91IGNvdWxkIHN1cHBseSBhIGJhY2twb3J0Lg0KPj4NCj4+IE1vc3QgcHJvYmFibHkg
dGhlIGlzc3VlIGlzIGR1ZSB0byBtaXNzaW5nICIjaW5jbHVkZQ0KPj4gPGxpbnV4L2JpdGZpZWxk
Lmg+Ii4NCj4NCj5FeGFjdGx5Lg0KPg0KPlRoZSBidWlsZCBmYWlsdXJlOg0KPg0KPkluIGZpbGUg
aW5jbHVkZWQgZnJvbSBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2h3Lmg6MTcs
DQo+ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjLmg6MTcsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZ2MvaWdjX21haW4uYzoxOToNCj5kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjX21haW4uYzogSW4gZnVuY3Rpb24NCj7igJhpZ2NfY29uZmlndXJlX3J4X3JpbmfigJk6DQo+
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19iYXNlLmg6OTI6NDE6IGVycm9yOiBp
bXBsaWNpdCBkZWNsYXJhdGlvbiBvZg0KPmZ1bmN0aW9uIOKAmEZJRUxEX1BSRVDigJkNCj5bLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgOTIgfCAjZGVmaW5lIElH
Q19TUlJDVExfQlNJWkVIRFIoeCkNCj5GSUVMRF9QUkVQKElHQ19TUlJDVExfQlNJWkVIRFJfTUFT
SywgXA0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+DQo+ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmM6NjQ3
OjE5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj7igJhJR0NfU1JSQ1RMX0JTSVpFSERS
4oCZDQo+ICAgNjQ3IHwgICAgICAgICBzcnJjdGwgfD0gSUdDX1NSUkNUTF9CU0laRUhEUihJR0Nf
UlhfSERSX0xFTik7DQo+ICAgICAgIHwNCj4NCj4NCj5Gb3IgNi4zIG9uLXdhcmRzIHdlIGhhdmUg
dGhlIGZvbGxvd2luZyBpbmNsdWRlIGNoYWluOg0KPg0KPkluIGZpbGUgaW5jbHVkZWQgZnJvbSAu
L2luY2x1ZGUvbmV0L3hkcC5oOjExLA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRl
L2xpbnV4L25ldGRldmljZS5oOjQzLA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRl
L2xpbnV4L2lmX3ZsYW4uaDoxMCwNCj4gICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jOjY6DQo+DQo+SSB0aGluayA8bGludXgvYml0
ZmllbGQuaD4gaXMgYXZhaWxhYmxlICJieSBhY2NpZGVudCIgYW5kIHlvdXIgbWFpbmxpbmUgcGF0
Y2ggaXMNCj5mYXVsdHkuIGlnY19iYXNlLmggbm93IGRlcGVuZHMgb24gYml0ZmllbGQuaCBidXQg
eW91IGZvcmdvdCB0byBpbmNsdWRlIGl0Lg0KPg0KPkhvdyBkbyB3ZSBkZWFsIHdpdGggdGhhdD8g
SSB0aGluayBpdCBzaG91bGQgYmUgZml4ZWQgaW4gbWFpbmxpbmUgYXMgd2VsbC4NCj4NCj5JIGZl
YXIgdGhhdCBhZGRpbmcgdGhlIG1pc3NpbmcgaW5jbHVkZSBpbiBpZ2NfYmFzZS5oIHdpdGhpbiB0
aGUgYmFja3BvcnQgYnJlYWtzIGFueQ0KPmZ1cnRoZXIgYXV0by1iYWNrcG9ydGluZyBmb3IgdGhl
IGlnYyBkcml2ZXIgYXMgcGF0Y2hlcyBtaWdodCBub3QgYXBwbHkgY2xlYW5seQ0KPndoZW4gc3Rh
YmxlIGRpdmVyZ2VzIGZyb20gbWFpbmxpbmUuDQo+DQo+Rmxvcmlhbg0KDQpZZXMsIEkgYWdyZWUg
dGhhdCBwcm9wZXIgZml4IHNob3VsZCBiZSBhZGRpbmcgIiNpbmNsdWRlIDxsaW51eC9iaXRmaWVs
ZC5oPiINCmludG8gaWdjX2Jhc2UuaC4gRG8geW91IGdvdCBwbGFuIHRvIHN1Ym1pdCB0aGUgZml4
IHVwc3RyZWFtPw0KDQpSZWNlbnRseSwgdGhlcmUgaXMgYSBidWcgZml4IHBhdGNoIG1lcmdlZCBp
bnRvIGJwZi1uZXh0LiBUaGF0IHBhdGNoIHdpbGwgYWRkDQoiI2luY2x1ZGUgPGxpbnV4L2JpdGZp
ZWxkLmg+IiBpbnRvIGlnYy5oLCB3aGljaCBJIHRoaW5rIHNob3VsZCBpbmRpcmVjdGx5IHNvbHZl
DQp0aGUgcHJvYmxlbS4gVGh1cywgYmFja3BvcnQgdGhpcyBwYXRjaCB3aWxsIGJlIGFsdGVybmF0
ZSBzb2x1dGlvbjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNjgxODI0NjQyNzAuNjE2
MzU1LjExMzkxNjUyNjU0NDMwNjI2NTg0LnN0Z2l0QGZpcmVzb3VsLw0KDQpUaGFua3MgJiBSZWdh
cmRzDQpTaWFuZw0KDQo+DQo+Pg0KPj4gV2lsbCB5b3UgZG8gaXQgZm9yIDUuMTUgYW5kIDYuMiBh
cyB3ZWxsPw0KPj4NCj4+IFRoYW5rcyAmIFJlZ2FyZHMNCj4+IFNpYW5nDQo=
