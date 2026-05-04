Return-Path: <stable+bounces-243920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJpjFNIR+Wmz5AIAu9opvQ
	(envelope-from <stable+bounces-243920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:38:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DF4C4285
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019213016EFE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693B35F199;
	Mon,  4 May 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VejVHC+z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347F35F170
	for <stable@vger.kernel.org>; Mon,  4 May 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930702; cv=fail; b=SrxHukkuCRZ/MqD82FElHKN2/BSD8Lhyis8qunWx7s2oWN2+C6P/EjGqIkdW1LJqQaiCHPze8+eF95fLRMAlsdbRZ+JkNnlsUHyi3aSlSwoe5IVQY67ke0ZyzztJmlrP9VmGWu26FW9PXbIxkjtPghsgBkzB2LMyzehsSZWw4vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930702; c=relaxed/simple;
	bh=7Dw0mtjIEi/0vHy6amiqBhBhX+uXxHdCpbZ37/SJZfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dh/QrdNoFj+nU79P/I+Eqhv2U7GXup8q4RH8iKoTFABR38p4cXzcoUrUzcK8HP/tRunAR/SBAILVLX+AUZU91DPpbsjAk+tIiu5RZIDCEjvT4FJWDR5YQ2cWKldqu+triEEWgA4QlGgPncCLDPBea84kg5Sjy5BjjzYZl+hJJsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VejVHC+z; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777930701; x=1809466701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7Dw0mtjIEi/0vHy6amiqBhBhX+uXxHdCpbZ37/SJZfU=;
  b=VejVHC+zIWj6oFV7JV7mhWyH/2aWzQpda8Fpz8oIPG50iROdH6+oT/Ri
   as2lNSEvuKH69kdEv7MKYl366DQZBUB3ShfKXmr7EBd+wp+/gmd7RsKD2
   ZYaqWgzI9j4wPNn9ziKpWK3NMox6zxGTKfC+w2YJdknEfVcs0h5Gu0UVY
   dbVUc6KLUR0+gd5WwJexhRC8HIqJUgvRC5SwUrjUttS/SJ8qJeoSFMmfR
   HANwmEtRIvTXyhE33KL//ckmf1wOZo6Hr1EWb2ilfIJcQLNMnLSVdbDLl
   qI8aLi2KEh6TqxiOn1msN2eS9Vy+5gvOp9hm3BsZ9nHk3w/L+y5TrVdEP
   w==;
X-CSE-ConnectionGUID: geSaVY3zT5eh5PbU5eqXug==
X-CSE-MsgGUID: DBPdPJvWSfKxhiRg7Uzc/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90254163"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="90254163"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 14:38:20 -0700
X-CSE-ConnectionGUID: pGiWcOJfRbCTdIy4RYEDhw==
X-CSE-MsgGUID: kw8DCdGER+SkIct7lNhMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="235501617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 14:38:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 14:38:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 14:38:20 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 14:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6Ujb0mAZLLL7KXU+eYuhV5eHTZ8SXaWGEoGBoQXiONrivoCzXq2r6nobYIIwH+8ADlAUVb8Y8Yy1+egzJOFCQb1mrG9krblOFRelcwvVcStYI9qFg6U7Bw764Uhs2W/dmGLX0JMIlQ98fHWZqKO7pPrhAC7P8wsqJqKj8DSwGUS7hivm2C9SLQRhrDe9pyhPai7lBhwSBTQ03Qkg/o4YvwmNFFbwN02US5VvOWv1UIE6Cq1oUvfaGdR/rgFl5EFNpq0YB9+MA19eFXBQ2SK3k1DzXE2TXzcq4qFAOtatSry05EGNvZ6AnOR+VR7O6d6k8PymS7mOeOwCK1sU3I71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Dw0mtjIEi/0vHy6amiqBhBhX+uXxHdCpbZ37/SJZfU=;
 b=BqH8f2YRqLB53ddIEAenznmjbwb+NItWuj/8k0YMZXaFlO/5qD4bC3RQT+4UJKscdJzcdtvpD5TOfRjZFId5GGeizKgFblnNmL1KmL7Dcne/efW0IVHa2tZkAxDZasasE7Rofb3LHA47uE+2dcjtgpYcyk3IVHH/aYHHkSosO4jWSeMOy2Ux9ogNZlRW6PluTzgNQ6wX3UAG858XK8tV0hZmp8M2n++HOOuScJ8sO5P2FydUNRbqrNjdLpwCCrJseLOiXwPp1xChvL97iz+3xePCRUx4iaBT4xmBJx3CZk+PHQ2HwnL3rLUVjFXpN9M9MXZHe9utSjttOhiau1Sq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 21:38:17 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:38:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "tglx@kernel.org" <tglx@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] x86/shstk: Prevent deadlock during shstk
 sigreturn" failed to apply to 6.6-stable tree
Thread-Topic: FAILED: patch "[PATCH] x86/shstk: Prevent deadlock during shstk
 sigreturn" failed to apply to 6.6-stable tree
Thread-Index: AQHc26IPENqHDzoVu0ems3On3uu7crX+ZVyA
Date: Mon, 4 May 2026 21:38:16 +0000
Message-ID: <42948c0bf8e894a77378c25082e6eb38505c58eb.camel@intel.com>
References: <2026050437-throat-unrivaled-2769@gregkh>
In-Reply-To: <2026050437-throat-unrivaled-2769@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|DM4PR11MB7207:EE_
x-ms-office365-filtering-correlation-id: 7379b221-13ce-4384-fd0d-08deaa25740b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|38070700021|18002099003;
x-microsoft-antispam-message-info: TStjGosC2k2h3fl72MVlX8LdZDElPA2ISlFqBqhw/gOtCNDyiOSAXlQQsRXmNEpO6O8zvAwoYtI+xJsmHoXJKPrf4oB3BomXLT9ydnH/BUKV3M+aAeIw6LJM1ok4tMhvVzlH7LXHGB+d++20Xe5pD1VPNQwcbMPu/DkrwAd+fwDL/lIcZyYANYXCbG+PCySD796u+eE8bwkpr0MbqOBcQvHJJRsvhrcAizD7D2N1C+KixmUOIqJOADBbwYoAovlivWPsdu++veuxltKGCBKjMSBonjrZCtHIoStccduCOIg7hUbdISennF8DigMilmSsfGI7RNQRPazDG6Ja2yqwX6uj9/tygCj0dQLTYfevQQRc/MKNs4+XBg2ar57H7anfqQTf7V4tlY4ZLgMfBRT/C8puUohB/s6waKsRcba606hjce/AEV1v1LeeGetCXeUin2/nxcMJB88Sr5fQKgOw2Zax1aWMR+eUjbH5Yb0+iaHxdgHPxyS/7i+vHvM38kEBZOBqty8blUapV8GYUKLxOGHzoyFkw//gotfX1JyWYQjRXFVKAMmFPXnwg3t6NWGLJV75GjaSGHVzTLFeynk46Xj0WI4Y/YZm3V71hcVCSkKoCojdyWj/BXyEv/yAPCPRS7wkgzhWmLi3xX+6oBsImCRqb80KTCRxTi4BeeeeB/lbURCP6hL1I9xreeRXhM0HY3UiIqBZC5YpQi9R7RolEKedYqP5QoZ6M0ulEK7PSK6FsCEWWLnEQ253yhS8Ln7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0trRGJoTzIyaENiK2pac0hsT296c3c1aDhobmczRWVCdG1uQkJRb291Q1l1?=
 =?utf-8?B?M2lXQjE5dHh4dDJKa0FMV05vTnNmZGI2WkVtTTJoNUU4aUZJRmF0clFDQ0Yy?=
 =?utf-8?B?OGcyUFc5Y2RrbWUvZG9ZbGdPVHA4SWRRejZOY0dIaDBDNWlzZlQ2WmZzZVhR?=
 =?utf-8?B?cS94UkM4bkRsOUVjQURodnlxcWI0SEIwQVJvU0VoUjZ1c0NDanhXbnNZN21S?=
 =?utf-8?B?NVNsR3BIVDJ5NnRLNXppY1ZiVGw3QkVhWUQ1aFZSbzQ4dWw0N2tpb3NmVGhr?=
 =?utf-8?B?a1p4YW9DVjZDVW0yREliaWFybVJGSnhFVVNtLzM3MVpldEdJbGxETXlDNXJr?=
 =?utf-8?B?cGlVVnBMQWgwaWU1bGhwUElsb3d4dmdNdmF1alJ0dUVHQVNqVXdmV0Z4MTVX?=
 =?utf-8?B?VU51T0UrSzRBYXhRTW9jN1VZWXUydDJWSCtWcWNpYVpkenpTRW9hYTQzS3JD?=
 =?utf-8?B?bDRtNXhpNXpacG8zdzF3ZW85QWVoYTkzUEUzV2FBNTRUMEh4VVV5MUVyM3RB?=
 =?utf-8?B?R3YyOFozMVErckE2KzQwZ1dmVlFTWFpDK1RtUFU4KzVZQnlRNng2ZDVpYk92?=
 =?utf-8?B?TGhURmlOZSsxUC9iY0JMVXplZHE4c0R3R3ZkTlpUVlU3OUhLL2oyMVlYMkhk?=
 =?utf-8?B?aFRHZjNodE4vWkdqT2cwc2UreFlQT1ZZUFdyYXZwS3c4YWJPdHlvNzFlQ3p3?=
 =?utf-8?B?VnI1UjM3YVdiRFExaG15OEVyWmlySHgxc21zR045VkNrck9rVExMQ3NEUDFG?=
 =?utf-8?B?K1FOakZPRFBJL0dZNVVOS0QyaU5XOFF0L3BuVmJYWlcrUGFvdGdSZlZJaFNs?=
 =?utf-8?B?OTZ3NVllTmVnOEVRZEVMTVJ2K0V3RWd0Sm5WQlVMNmtPWlJIOWVDV3M2NkpZ?=
 =?utf-8?B?NXFETFJPQ3VhcmFsUGVpRjIySTNGalJCMG53QTdhWmFlbDl4bmNjdHZyM0l2?=
 =?utf-8?B?bEZEaHVwdXJJUmhjcjQ4THc5K25CMmNhaTNGU2Mwd2dEelZYcWM3d3VJYVla?=
 =?utf-8?B?bjFPbitJRVZEUURoVENGTjI3RmhCeGZ6UEY3ODdrZEV1c3ZpelRmRDc0VlZa?=
 =?utf-8?B?aThDaW13RnltTDZQVHVHSFlLaWp5REQvUTRObEg5T3VZTmFzSDd6WVorS2p5?=
 =?utf-8?B?anJHZytBZllhNytKWnc0NDZJTUVnZDd2R2x4N2E5ZWtVODZqK3ZyUjQyOFlq?=
 =?utf-8?B?NzhiOHVTOU9zeXZXdFJ5UGpMWW1PcnpoV2JFUER3VXcwazN4T285dktrUWhz?=
 =?utf-8?B?czBWTGdzdG9sM3h5aSt5SXdBWEtwVlRVM1hKS1BySzVEUG1pQkJWTXFTMS9q?=
 =?utf-8?B?cjAzOFV6V3RySjZYay9MZDNuVWNqc24vbUE1N2QyNzEzTEk3ajl6bmFvNG5W?=
 =?utf-8?B?RnhuMDNuM25MSTB6T1VMdEJGaGIxT2FoajQ0Q3FEOGVKK0RhTzJFendvcGdw?=
 =?utf-8?B?QXQ3L3N2YnhPbnUyYU50endqaVY1clpqQ3lWOHdyUUwzZEZKc2JBaUZLdEtJ?=
 =?utf-8?B?UmFiSVU0S2s1ZnYrOUpKWVQ3b281SXMwSmYrS1hlRUhuaUxxU1dsbTNrSTh3?=
 =?utf-8?B?MVhRMytkN0N1cEZCUGZaYkZnZ3lYWld2SEMwajlERG9DREJWVEozbXhJRXBl?=
 =?utf-8?B?cUtNVmg1SWJXenVvSzNSdldBc2oweU1QNWJxNlgySmJDaVJaLzdoQzNUOE15?=
 =?utf-8?B?TTN1WEFhZk5qY2huaE5Ub1dVZmxlTkRxdkpzckJORU9KVTYxc3YxVStZcUNX?=
 =?utf-8?B?a1Awc2J3c2wzUlR4RXljZVcwNHpPb0NnNFQrUk83a0hKUi9TbFJTQ2VJZk4z?=
 =?utf-8?B?TENPSnJ4QS9GTWVkUm9udGs3RG8ydVQxd3Y3VDVTa1NjNStlOEhaaEdLZEVV?=
 =?utf-8?B?bkJTSGtuODVUd3h4ckg5TlBaZnZaTlRCa09IKzZudDhwZENiUkM3SU03WVIy?=
 =?utf-8?B?cFB6eG9Yc2pVRllLSkVIK1B1cVROU0Q5LzdmTDN0d1pYbzBWa28wTlh6c2VG?=
 =?utf-8?B?a2xBNHJydWUzVitPdytVYjRwMk9Calk4eHpBOTFrcVhNc0xMaWFKTnFyNHBH?=
 =?utf-8?B?VTZsVWdoK0RCcHcwSEttbjdiQmx4dS92RWhYcEkzWk9lNm1wMWloeUd5dzE4?=
 =?utf-8?B?YXBrdzYxeXJEeTdYbHJFRjQxd2JObEJGYzl0cTJ4QzJseWx3WU1iRTJuTDNW?=
 =?utf-8?B?Y004My9haWdnVWVZM1h1eG50Rk96cVV2TVVlTEZVT3c3U3dFekpvUG5VOS9r?=
 =?utf-8?B?aU1wNlNIV0czZzNRV00wUjRsRFV0MVJkWkdPcG5VZkU2d0dUWlAwc1RaQ1VH?=
 =?utf-8?B?MVFpYi93Q2RJN1JPdFRVcHVobWczcVF0d2IzWE16cnQrdVBBL1krbWh5VGFo?=
 =?utf-8?Q?Scw15X+CHP1W7uvU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79E3E8A41B09B940909527E534E6576B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dcUsHjJUFza1U0r5Tialnjrg/toKca4Hm2aUqNpYP6gNRowXQfFNpzk7ciTwVFtJb9wqcZUU6F2D+xCmchIYv2skEhtJj12mLTMug9sM4Tni5n3mh4uENekTHvGGmGJEyFBdfu8wQLdzalEh1JEuZFlF/2sD2/HMWTku4ldikkZaGIz/g71zrQgNWSjRdZc/XGKGs/HDVcobXXC5qcEE2Q0F3d7obAHxKcm8oV4wC/a+m5olkZs4LnEDdMHvL7BN+wkXUWP+zuW+KwRzoX11/Ev4g6wpF/qnY/2lyNV7s5YN7j914M+GAbGtJbd6BzKBkWMJaDwNfZ8DE5O7Ox7Y2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7379b221-13ce-4384-fd0d-08deaa25740b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 21:38:17.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfgSbFK5fsqWadYuPigZcXkoJu4FDxLk9Nv1nWnkWZlAW9d+toJLx52HMdcSS1Nq+LFWIfvO2nrA6KPRtGK1yRyJ3ix2cHy7hIp8t2NBEfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AD8DF4C4285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243920-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,linuxfoundation.org:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

T24gTW9uLCAyMDI2LTA1LTA0IGF0IDEwOjQyICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gVGhlIHBhdGNoIGJlbG93IGRvZXMgbm90IGFwcGx5IHRvIHRoZSA2LjYt
c3RhYmxlIHRyZWUuDQo+IElmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8g
YW55IG90aGVyIHN0YWJsZSBvciBsb25ndGVybQ0KPiB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0
aGUgYmFja3BvcnQsIGluY2x1ZGluZyB0aGUgb3JpZ2luYWwgZ2l0IGNvbW1pdA0KPiBpZCB0byA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4uDQo+IA0KPiBUbyByZXByb2R1Y2UgdGhlIGNvbmZsaWN0
IGFuZCByZXN1Ym1pdCwgeW91IG1heSB1c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kczoNCj4gDQo+
IGdpdCBmZXRjaCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9zdGFibGUvbGludXguZ2l0L8KgbGludXgtNi42LnkNCj4gZ2l0IGNoZWNrb3V0IEZFVENIX0hF
QUQNCj4gZ2l0IGNoZXJyeS1waWNrIC14IDk4NzRiMjkxN2I5ZmJjMzA5NTZmZWUyMDlkM2M0YWE0
NzIwMWM2NGUNCj4gIyA8cmVzb2x2ZSBjb25mbGljdHMsIGJ1aWxkLCB0ZXN0LCBldGMuPg0KPiBn
aXQgY29tbWl0IC1zDQo+IGdpdCBzZW5kLWVtYWlsIC0tdG8gJzxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPicgLS1pbi1yZXBseS10byAnMjAyNjA1MDQzNy10aHJvYXQtdW5yaXZhbGVkLTI3NjlAZ3Jl
Z2toJyAtLXN1YmplY3QtcHJlZml4ICdQQVRDSCA2LjYueScgSEVBRF4uLg0KPiANCj4gUG9zc2li
bGUgZGVwZW5kZW5jaWVzOg0KDQpUaGlzIGRpZG4ndCBhcHBseSBiZWNhdXNlIG9mIHRoZSBvdGhl
ciByZWxhdGVkIGZpeCAieDg2OiBzaGFkb3cgc3RhY2tzOiBwcm9wZXINCmVycm9yIGhhbmRsaW5n
IGZvciBtbWFwIGxvY2siIHdhcyBtaXNzaW5nIGZyb20gdGhvc2Ugc3RhYmxlIHRyZWVzLiBCdXQg
aXQgYWxzbw0KZG9lc24ndCB3b3JrIGJlY2F1c2UgdGhlIHZtYSByZWZjb3VudCBpbmZyYXN0cnVj
dHVyZSB0aGUgcGF0Y2ggdXNlcyBpcyBtaXNzaW5nLiANCg0KSSBqdXN0IHNlbnQgb3V0IGJhY2tw
b3J0cyBmb3IgdGhlIG90aGVyIGZpeCwgYnV0IEknbSBzdGlsbCB3b3JraW5nIG9uIHdoYXQgdG8g
ZG8NCmFib3V0IHRoaXMgb25lLg0K

