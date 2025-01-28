Return-Path: <stable+bounces-111053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B987A211FA
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6343D3A5900
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E41C5F2C;
	Tue, 28 Jan 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOz4U0gw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB213BADF
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091354; cv=fail; b=q1FwypkfSlwE6jNA0sbSrZP+ia9YW2urRIZgNDXHQfl1nPYBW5Denh/m18nIeTH57iwkOsXwYRXbtu8rxM/D0iApP4fBEeyoZbhL1YgdkeUgADQR4ftW8UOtVKOY7Xfc1xbGORZ/XrgHyzMEkIN+zbcllM4GgutLGSduMNy4VNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091354; c=relaxed/simple;
	bh=a+zqcFC6qUpMxg41BE5Up9a1HkyzQXU2EJUY3XCyJ0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnHO/yyaNNbHJFm7mV6xeeydeLHdHe0NvnAicEhlHUW2HRHkXp3wRqCq6BKLiKrqcHTjvWqhiXBIeHHhlkmmfhcnLeWWMkiqjOX9SXTut9u7Cnuuy4dWBx6acH5kSKMUfHUnYZKtn52CEJuOpwuM2SeRR973eiDEiuEn/eY9mF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOz4U0gw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738091353; x=1769627353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a+zqcFC6qUpMxg41BE5Up9a1HkyzQXU2EJUY3XCyJ0k=;
  b=OOz4U0gwZTfILHjSBWfnH5D4gFzgiOFw1bkWi9vHk+7X1CYWAKQCd3hq
   Ar20mU3KY+ah5HQ1WM8lPPNhj0Ii/CA8pGtgcgIpervAz5Idsw7ZyR/Nj
   E+aLtmk9KYopJCuekShelq4xBpT0y+oZMuwvnBIaUWjhhYth5cJ85Gztb
   lOvA16E0KnizUGyc9SaaOn+KwJXspzqap1bMID9ogxEFerxLgfwQlEUTY
   WsbjOR8NyCztRyMfJTSxTwm9Xk7N0wne9cabTYH16LOm4UfmClDN/i7bM
   X0jg0eOFktjeB6/Io9L1n1LDknnAJz8eDmqc0DEU8i6OdXMpV0OqzlEeI
   Q==;
X-CSE-ConnectionGUID: rU6yDIcxRDOb12R8MW7Cew==
X-CSE-MsgGUID: s2oJOEzKRpaT5wmYI5B0CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38845879"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="38845879"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 11:09:11 -0800
X-CSE-ConnectionGUID: o926ctETTz6nhDJH5NFH5g==
X-CSE-MsgGUID: N9CXpM9GTDyqS37neDHNGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139694553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 11:09:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 11:09:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 11:09:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 11:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDT8ptdnw9gy8tMKGhi+o09pxuXPnWGtLe+0GzaSp8UHBYXF92fQZJkMQ49jo4rVSGO0rB7t2DtgkfRLhXTRdRF6axYsOUZPAx3yqi9DPIu6t2FAZFRZjKGrEej+02fad9pqalI8tYIBmNoGLRdOzWaDeW+GMzWfmQiCT9tFe4kBORzJJjhnCc+8jAcrBCJ+xmNPOvWHixr2jKtzTLuwDDthJ06ZTOe2zEEP5R/kbHlyK1ERjkcs5KzVuL6Lcj+PT3U9GuyFCLVPqlA7eakXqt8pojxEp/ilBX6/lK/6r2jOBkT5L4Lp36rEcC1zV5DnZ6DN9x6XX/dwVqPeR3Kwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2pCg1Q5lQJGx+DB80cJbtUFUYsIrglXhePl2iJwoNE=;
 b=DkK3pjaR808ciTO/s3PD/qUZ3sLvgzFcfcykuoEip98qoO/n1h1+Yl3/WOsFWs1EOYzvO5UDb3xu0nilNJDgf8kYIF7Gt3C90GfNwP97rtUhMFCAaXdSzs4zlxWWh+xJElxXJ4GZvDqjM3ED9I2usNRB8noCnqH9OJvjxQN+fW42ywRieemj4CbBBH70wzwfmR1+TTA++yPyBxNFjaHsXBA8JfcTCzF8VNuHNE7PK6DUguWHgTzyy6GLA9qaxF04IkCSXZVT7L5/6z1TIRALHI+hRFy3kaaX7/aeQGOHqKe9wgKQ1uheL+uoAhVo+IKFIN7Ep9Y3dulHedRvvV7E5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7)
 by SJ2PR11MB7547.namprd11.prod.outlook.com (2603:10b6:a03:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 19:09:05 +0000
Received: from SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c]) by SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:09:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Chengming
 Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Topic: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Index: AQHbcWrWrMuYujkV70ixrrCNNvf9Y7Msinzw
Date: Tue, 28 Jan 2025 19:09:05 +0000
Message-ID: <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
References: <20250128185507.2176-1-42.hyeyoo@gmail.com>
In-Reply-To: <20250128185507.2176-1-42.hyeyoo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8120:EE_|SJ2PR11MB7547:EE_
x-ms-office365-filtering-correlation-id: 284a61ba-0f5e-4052-8046-08dd3fcf3be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?6QEeMiTj+EY9cTVyKVOJInAJeHwoF4OIQAeM45F3RV4ury65GMyU3vY8mgE+?=
 =?us-ascii?Q?QunmN4sSsgKE2AAmeBLwbyQ6WAtRnw7zs7zHrBhjWrQL34LHeLbsRl8Rf7VS?=
 =?us-ascii?Q?D3O5Q7hJSc2WgamuQrha0qG/BCzX3ZgTdZLfCQMhPD4uPn4eFge/ASHhUxej?=
 =?us-ascii?Q?8DarjHiWlgdADsKE2GvoS/Ubyj205ntWo6Y8Sf5KZ4k2RgfyEUH37gKsJq6I?=
 =?us-ascii?Q?33UFSgO7bCQR/IA4y7Lv9oc0flU/WpcVlWQe4Z57NriADxDi64ga/GhCPPKO?=
 =?us-ascii?Q?A+nMY4S3trehKXEv+kx175unbwuTvHxNUlv8dYVJSu2s5lH/Hq4l2CX8OvD8?=
 =?us-ascii?Q?+MGHfP8sD10fbcFrK/5pmobO1lAaqV1cDuFO24S3bmtlNN1rpjFN8h5l4lJu?=
 =?us-ascii?Q?Qu5b7+NegAwSoUQ/sF74ZH5Uz6Oxrr7jM9S6IEvpvitUc8uuTp5fJ1yEdPUE?=
 =?us-ascii?Q?M64GPEqv4fpQQxAN9BjHUIc0/jJkdjl7HOlz/k94ilwsLUz63a+q1gzE0XpN?=
 =?us-ascii?Q?47X9GOawO6XucE3A0v3h0Eb/YYvepRUXpzhl9SKI6Ou6b4S1U/NpodxvptC9?=
 =?us-ascii?Q?nPY2D3EOUvQ/SBA2mjEJkkTIoMz3eL5JA264PbPI5S5pAqnf+g4N1Cbe8ePh?=
 =?us-ascii?Q?1s+XrrNerBKmBOLrNdxfzMHK42ZnvZEf4SZHRygOgpAkJcCTMfbzAmcSEV3P?=
 =?us-ascii?Q?qbiRkNSBtxHcMWX+b79MNItylp7uhcxTKaG2cJntqo5k8W22pnigoUTfNNg8?=
 =?us-ascii?Q?ifhMeo2h7we46CX1YDeH6qkj2dGVnVhCot1W+EAaBeFZDRNF8EilWXxOvIE0?=
 =?us-ascii?Q?v3MILlBsdqT8cFSbckSyFV8gxstdRzvbEjZ2p79cnBzJQcFm6cjNI9pJtYe1?=
 =?us-ascii?Q?ivc/zP7cCc0oMO0at2Zb7jisvh810LGtZsuGnziyn5Fnky+WpCWkQFgKcZfU?=
 =?us-ascii?Q?WxE4CVOutt/eLglkor3HEsihmCdcRjATwfzG9WLmGiCbLeKFLG4zVPIPnUCD?=
 =?us-ascii?Q?cjBMGKX2KsdCVfBcLWgJ3a4qzlKextcJUBEGglJdHH8Xm0ba5PloA6DWPaVP?=
 =?us-ascii?Q?BFfY25RDqu97FR/XVfPJkGD6wwCGjY5F3XfRdFR8SJYNAdR3yqPFwDCJklcx?=
 =?us-ascii?Q?q6g5dPZFV4V5sPB4G+v+LdYN9W5F4AFEIZqGl3v3zmknjmh5umga2znJwORx?=
 =?us-ascii?Q?YsTInoKGphESXXanIMIPCMiHFss0txwi6S/H3l3H9IDFNtIGlQQYMAttdh6L?=
 =?us-ascii?Q?oYA3uaNooFXPENV5Q43pQnDB3v3FsF2HWrQwY8VmI6LwPiCTf/4lPt0RoMXi?=
 =?us-ascii?Q?qjBYeChSxbG6R66igpbG2xWXIk2NKGH1xZ7wra96ZzrqMrWERrCxVvAZjiC3?=
 =?us-ascii?Q?6toBOSRc8LkO4+eSmxHb+D8mDhRaltGOt3Vsthl1//Hk59rpc0AM+K4OCXTQ?=
 =?us-ascii?Q?/Cmmfn3+8z+WgLXX0ddFtHGRzFwvDnaM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQydeA6CWurViWBBYBEt5SrImPz1dSuHzGiXfbznwKJiLLp6XaPNnIMNsEAL?=
 =?us-ascii?Q?wQ4xKyw2iKVv8nOnRMYNcdjq4L0qERp3IfnVIbBMB3UA4/LsyeHXXn34Btiv?=
 =?us-ascii?Q?ZfJ7Uhdx58BsqtF2SfalpCkt7dxbxFmIz7hWhbx7FuxLp60MRo6FNsVTY4nw?=
 =?us-ascii?Q?VriEFnMG8txDHAFVFGoEI3bd2CgYk5hsQD+1VPrw3noylDNXY3oyOoOdf7Us?=
 =?us-ascii?Q?4hhlsIn5grOlvrdtT4knB+5Bu835JKLAmbQetgoxudlKZAJfnp636Jic2Sza?=
 =?us-ascii?Q?CuSErMF66ztP/nKdgAh/lfaNSqP42S/uzKQIfxLgQP+bGgkeQNPp32ouNRJZ?=
 =?us-ascii?Q?EsBLuv+fnwvdTij9EIo6Zm3zQ5Vjiyq4R595VGB4fxhV545T4dh/AhP5ItCL?=
 =?us-ascii?Q?ielHZ1i8BoC5zH/vCrk9GPypdE0QjZJeXnaX99zTXbfRggbpHIpttYVFOxLJ?=
 =?us-ascii?Q?2+2YmpWr80w9uaKxnn1otS/0vY5V3x3e7lWIrJcJeZk6PFy69rcrMSP94S1+?=
 =?us-ascii?Q?CSTWBs1iy4Bpgncn1YnRNncP7+N1J2jD/7F3g7zS7bCY9020kJx+a3YzqVs9?=
 =?us-ascii?Q?XIy/EizcmIqAFpkQF8AHBvwed4AOiC+htO+XjfOGVhkPkW6V6+lxQ+DUM91a?=
 =?us-ascii?Q?3vw10QrC8UqhMR+zlWNxhZuXzhY6HK8AhxRNjWq5K79yx4lkFX1ZocSy7WCa?=
 =?us-ascii?Q?hcol7jr/fAdwZn3uV0MHY6VGwKxrlTa6c/rHyRifbjh2krhk2mFAsJz/ofOF?=
 =?us-ascii?Q?FN1i1rCGmU2R1Gop50Sj7APYQkCx8j1mEZTlzyMIm8PLABkZVBJHMUkm1kFk?=
 =?us-ascii?Q?/26u//GvTqJKGv3pzW/53muX0/KFAKsa9nRAHR9NxJrewpKEoU0YOkjfbfVL?=
 =?us-ascii?Q?vfgwTNL1+4xc//SdGPzi1oH41jcXttbZ5jwPXLWAhM7eicTJsRKQWkiEmiUM?=
 =?us-ascii?Q?EQ0sqQBws3YcsV8XyF5W0mAHxqGMBW3mOPiu8/nvE7NpP2ALAHm/NTTS3rjZ?=
 =?us-ascii?Q?XO5KsD2zC3Z4l3xKOQU46rssC0JdX4qbKHAdxHka4H9LEpnXy60fWUVe3uO8?=
 =?us-ascii?Q?2JJ6M4GMt03VT8D8ykN5Y7k/HxeIuerf2CENcBGKuroEkLBnnK++vGqygr1p?=
 =?us-ascii?Q?/yGHtTJhjeO5Mo6ZbvA0G1U8FDbKfGXDKEb9zfjdM0e5OEAvt+TbUQTqkGr/?=
 =?us-ascii?Q?4cIi0IDuHrLxVa/b4JTX0SjgwXKiIlWtWwgRdiFwWpDkU85pAlVJb7jv3aTy?=
 =?us-ascii?Q?irVkzDGC8YF9WjktPTs4My+xTYPHM5nPIZLI9+9Oo39kJeTW8wpSNqnFyH44?=
 =?us-ascii?Q?B8ID3hd8m6wqQm1Hqehr+LOQhuRatPgxwSTEG2GQsA1nLzs99Vbaj5ZGW0Ov?=
 =?us-ascii?Q?QWK3RFrZXUJkY5EzHn72aJkf3dY/fVedDrmxwZE6JJqhRIXt9E/ZYscl7BOd?=
 =?us-ascii?Q?sakbh53jUvLHCdVpZp1jNCzhpi/onxfjd1dD5C6sNlR1jS5MxDQJVImY08g0?=
 =?us-ascii?Q?YkWxSgANydn4dtFH+zi1sjfPgLHxzfYSahlZxTCWjA/cfsKkPE2gR7OPNOni?=
 =?us-ascii?Q?UnS3tmxJcU4NzZYEDzULEua9YMl6lGwQQPl24HOvYFVCKt0OGMT5nx+H7/Tt?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284a61ba-0f5e-4052-8046-08dd3fcf3be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 19:09:05.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: le8GR3k1Q0yg93P58dugOPiQJNWb7bPKBlV4QY4IzG76a6jY5oWfSb0XlJYzDs/NJW23csxIO6IZbdnUeuk++DbqjG48KWgsTqgkJtnZOi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7547
X-OriginatorOrg: intel.com

Hi Hyeonggon,

> -----Original Message-----
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Sent: Tuesday, January 28, 2025 10:55 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Weiner
> <hannes@cmpxchg.org>; Yosry Ahmed <yosryahmed@google.com>; Nhat
> Pham <nphamcs@gmail.com>; Chengming Zhou
> <chengming.zhou@linux.dev>; Andrew Morton <akpm@linux-
> foundation.org>
> Cc: linux-mm@kvack.org; Hyeonggon Yoo <42.hyeyoo@gmail.com>;
> stable@vger.kernel.org
> Subject: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
> zswap_store_page() fails
>=20
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> skips charging any zswapped base pages when it failed to zswap the entire
> folio.
>=20
> However, when some base pages are zswapped but it failed to zswap
> the entire folio, the zswap operation is rolled back.
> When freeing zswap entries for those pages, zswap_entry_free() uncharges
> the pages that were not previously charged, causing zswap charging to
> become inconsistent.
>=20
> This inconsistency triggers two warnings with following steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
>=20
>   Two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>=20
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld
> nr_pages=3D%lu\n",
> 	  new, nr_pages))
>=20
> While objcg events should only be accounted for when the entire folio is
> zswapped, objcg charging should be performed regardlessly.
> Fix accordingly.
>=20
> After resolving the inconsistency, these warnings disappear.
>=20
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>=20
> v1->v2:
>=20
>  Fixed objcg events being accounted for on zswap failure.
>=20
>  Fixed the incorrect description. I misunderstood that the base pages are
>  going to be stored in zswap, but their zswap entries are freed immediate=
ly.
>=20
>  Added a comment on why it charges pages that are going to be removed
>  from zswap.
>=20
>  mm/zswap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6504174fbc6a..10b30ac46deb 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
>=20
>  		bytes =3D zswap_store_page(page, objcg, pool);
>  		if (bytes < 0)
> -			goto put_pool;
> +			goto charge_zswap;
>  		compressed_bytes +=3D bytes;
>  	}
>=20
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +	if (objcg)
>  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> -	}
>=20
>  	atomic_long_add(nr_pages, &zswap_stored_pages);
>  	count_vm_events(ZSWPOUT, nr_pages);
>=20
>  	ret =3D true;
>=20
> +charge_zswap:
> +	/*
> +	 * Charge zswapped pages even when it failed to zswap the entire
> folio,
> +	 * because zswap_entry_free() will uncharge them anyway.
> +	 * Otherwise zswap charging will become inconsistent.
> +	 */
> +	if (objcg)
> +		obj_cgroup_charge_zswap(objcg, compressed_bytes);

Thanks for finding this bug! I am thinking it might make sense to charge
and increment the zswap_stored_pages counter in zswap_store_page().
Something like:

diff --git a/mm/zswap.c b/mm/zswap.c
index b84c20d889b1..fd2a72598a8a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *page,
 	entry->pool =3D pool;
 	entry->swpentry =3D page_swpentry;
 	entry->objcg =3D objcg;
+	if (objcg)
+		obj_cgroup_charge_zswap(objcg, entry->length);
 	entry->referenced =3D true;
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
 	}
+	atomic_long_inc(&zswap_stored_pages);
=20
 	return entry->length;
=20
@@ -1526,7 +1529,6 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg =3D NULL;
 	struct mem_cgroup *memcg =3D NULL;
 	struct zswap_pool *pool;
-	size_t compressed_bytes =3D 0;
 	bool ret =3D false;
 	long index;
=20
@@ -1569,15 +1571,11 @@ bool zswap_store(struct folio *folio)
 		bytes =3D zswap_store_page(page, objcg, pool);
 		if (bytes < 0)
 			goto put_pool;
-		compressed_bytes +=3D bytes;
 	}
=20
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+	if (objcg)
 		count_objcg_events(objcg, ZSWPOUT, nr_pages);
-	}
=20
-	atomic_long_add(nr_pages, &zswap_stored_pages);
 	count_vm_events(ZSWPOUT, nr_pages);
=20
 	ret =3D true;

What do you think?

Yosry, Nhat, Johannes, please let me know if this would be a cleaner
approach. If so, I don't think we would be losing a lot of performance
by not doing the one-time charge per folio, but please let me know
your thoughts as well.

Thanks,
Kanchana

>  put_pool:
>  	zswap_pool_put(pool);
>  put_objcg:
> --
> 2.47.1


