Return-Path: <stable+bounces-76637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49597B836
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 08:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0414328132E
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796113BAF1;
	Wed, 18 Sep 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC9/ZG17"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91A3C3C;
	Wed, 18 Sep 2024 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642484; cv=fail; b=VPo79u59hJ9gyg0TQQqKFnvfRl3ETnsvz6DrfulUcaMjXwD3GdrhwKUV3HhwCX+WyHn66zJRn/ZQAMjrczECEL7wx1jYqhNEEYlsqh1qI+TDXcd+tAGqFosU+MhOJWpcYiQvZPRcm9Kdoct3fBNIkge+YJUeiKeaOL1mcW3XC8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642484; c=relaxed/simple;
	bh=/w+s8pdmzdm0G7UV9cb8DThupSEL9fa2/h6Vyq4d2ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iS+P07P5/WhDqyP0KpJhCEIBdfEGpoV9YvfwcldNOwIQNBPJg1CJ//zJMjrrL+psDMlTR+QvvgoSGSSXrL0bRtgGCCw3BIFClA8Kkev7m/JRcDmYcqlzy63D2hFs1nzjxLZ24wR2Xs5U+twbD+cTHP0PJkQEs8Ytr40Vd+yJObg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC9/ZG17; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726642482; x=1758178482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/w+s8pdmzdm0G7UV9cb8DThupSEL9fa2/h6Vyq4d2ww=;
  b=DC9/ZG17JHveIjgPkIYI6E7IrDEhivc1hDb2QIFY4NlBltyqUjr+LRCp
   d0XApTANwiNug24xiXdZ5x29eSqlMXtm1+biBYMh5KtZTV2f3VhjdoM7Z
   p4rcYXo3fgddo6RSQNPPpnrYSPO1pSotSmo5vlnwOmqXjroUMiHUqE/4g
   xxTvtFapssvPfBVQ0XkM5CDnKs0rfwud34GO/4jymT2nP2Ra4S7cnjeYI
   5iGsEoSne3PlN1ahOuYicedA/YEUrmW4O0CJ/NUDdvJgNp0kgzXBoHdbu
   0/PomgAZ8kHOcy+lGn95IlBPdi3auMVO72SJihV+rtT40X4vgtN2DlKDt
   g==;
X-CSE-ConnectionGUID: CUv4BnUnQS+SgBSc83zmjw==
X-CSE-MsgGUID: P1krdHn0TDOnmW1ytzSGRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="13570068"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="13570068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 23:54:42 -0700
X-CSE-ConnectionGUID: zIt1aJW5Rn6yV3VV/rt+cQ==
X-CSE-MsgGUID: wXTCxbmJTVOKzfaj60KPTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="106914209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 23:54:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 23:54:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 23:54:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 23:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFFQYKrV8Q0Cr7c0+TkcANSGG8DGoj9mzyhtq0IJjwNh39zdlLaGfEAJIZh+qQc6DG5nIGKJ5a5abgobM1gPSgzt4GSDtK0wYtFq8F60g0a19TDuGsSz9i0GdTyCqftHb/OhRoz9KsyMUYmuGWjY4XlqhUrtVJdYHCjic9r1NmL0d8xEdVbGG6q6p2WE83Y2Zzms2eutHFGflZoLsDZqtYHAWiSI+bmzJanq5/9X14QwMIAbxT6sz5zm+YjjAautZ7hDWhrdT/uwkKEkRE6YHmjN6DAhquvM+uTZGnTqX5DE9ybg39scm38/0r3qviN+X2P1PSDueoC1z0/xqGPtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w+s8pdmzdm0G7UV9cb8DThupSEL9fa2/h6Vyq4d2ww=;
 b=ZaScN04FoCn3K4fdc9grWGjltVwFjGa7Y3SURU65emQPE70iQ9hni6wzOBE1jJRhI4T4A92qCYsWMo3GrsDdFqvt61yEzm9fbApKfVbPbVPABUDKs+6kHnY3euxyksjrqAvvw8h3xqFhktAN6Jw7/O2CXuhDn8JuZVmN5cjc4aPfHNeujykSpo5Eeu1tNKYSqLoTGHjNHdpJaw7eW6u9qa9K8oUkziTYXKmbE+aidQw6MFk4rz/tLViDX3sw2b1UFhU9Wqg4L/63g990tiA14ZlPz5BEM+dZRpaAbMsqdyNCQD9yXqEYZ0WCsehyQmASc0FruPS8kUD4pblevnkXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7664.namprd11.prod.outlook.com (2603:10b6:510:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 06:54:33 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.7962.021; Wed, 18 Sep 2024
 06:54:33 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "regressions@leemhuis.info" <regressions@leemhuis.info>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Neri, Ricardo" <ricardo.neri@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gupta, Pawan
 Kumar" <pawan.kumar.gupta@intel.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"thomas.lindroth@gmail.com" <thomas.lindroth@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Thread-Topic: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Thread-Index: AQHbCZedKtdANIzIo0qy/xfgvzT5FA==
Date: Wed, 18 Sep 2024 06:54:33 +0000
Message-ID: <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
	 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
	 <2024081217-putt-conform-4b53@gregkh>
In-Reply-To: <2024081217-putt-conform-4b53@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7664:EE_
x-ms-office365-filtering-correlation-id: c14d6ff4-1fb1-44e3-06c5-08dcd7aec062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXBqS3c3UFZ3d1pMUiszVlVGdjk3cThST2NwbFhFV2dheTJySFMyY1lSZUpJ?=
 =?utf-8?B?R2xRenFOWHZZQWhRb01QVHRLTC9lWk9Jb25hZ1F1SjdwdEVBR1BpRGNodXc0?=
 =?utf-8?B?cGhFTmd6UjU0RS9teVpHTHpocU1LL0hWNEdMZnNjd3NMZUs3c3ZqM1NpeUJX?=
 =?utf-8?B?WnRpUjVGYjlmbWJoS01vRGtrd3MrMjVKdXpSd3F6enZxNjdhdHpMeUgvVWQ3?=
 =?utf-8?B?bVh6cllBcDJNenJzTjFGTnZhYVJ2Zjkwa1R3Zmg4UzBySlhiZDgwd1AxWUhr?=
 =?utf-8?B?MDZGYStsemZweVVlUGlOWjZQYkFBS3FvbW03U0hTbmR1S2x0cVhMZ0JFVkt6?=
 =?utf-8?B?VHVpcXVGYkE0NGZZR2V6MGtYUnkrZER5KytnZWNVVTRjUGM2OTZ0MVpUL2Iz?=
 =?utf-8?B?eGZhVGlrQ3E3TCtBQksyRWUvVjdHZi93Y2xzSWllRUNrYzNMaU1rQ1NmYWVm?=
 =?utf-8?B?eTFsWVE3TTZRSjk0N2l0MmtpNU9yV1J6NzdEZnhNV0tPcVlhMmQrNnNPdDJa?=
 =?utf-8?B?REdyYUlZWjNsNXRmeWxmdWR4cDZzY1BmeFYyWnh5bHloSGlQc1J0RkxObEha?=
 =?utf-8?B?eFNpVzB4YnQxNGJsOXNQOUxuWDA0NlluVUx5RlJjY25sOU5MWGtaa0JxT0lp?=
 =?utf-8?B?aXd6a2JrMFhEWk9JWXo4UmJmVUdjUUtscklBQ2N6V2x1M0Q3cXlvMlRMOTBx?=
 =?utf-8?B?K1NCSFEzcjdDbHNoVGVFMlpnNy92Q2RpU0tqVWR0YjY0Q3k2eE5YeENybk1n?=
 =?utf-8?B?NmFYR3lrRGg3L1drbVM5U2ZCYlJPQjd1SUFKTzhMaStWRllTU1BTTVg2WE1S?=
 =?utf-8?B?WDRCSVptU1BVbzB3bjZuVTRhTnNnelM4Tk9uQWtqb2UvWEt5TE9mL3htNjNa?=
 =?utf-8?B?eHlmZERvWDVMWWpBWnFSd1c5Z0hzL1VpQ2JpMC83aC9ZNG5ZSWdCYzMxL2VU?=
 =?utf-8?B?cWpXK1dvRXk1eEdPSmsxcWpGVHpWR082dyt2ZEQyVlpaTWZRMTY2bjROZkhD?=
 =?utf-8?B?UmJCYjR1RmdGU1BUeHM5THlYaFZxT2ExaTJ3anM0NW91bkhuMTdCUm5RR1lK?=
 =?utf-8?B?ZHVZOXNNS1owa3hYa25NLzJuNUIvM2ZTY2FWUEFSWU96N3N5aFFIK3RBZisw?=
 =?utf-8?B?ZVA2K2ZGWGJZbzVVS3RnZ2JkV0E2WTA2NFpIdHhKYmZ5WHB6OWZxZjR0ODc2?=
 =?utf-8?B?NFI3TmtFNjIxQ0JXQ21qYUJrdExmZmUxNUdiS1FGT2lMRFYvaDZDNHFoZ2hJ?=
 =?utf-8?B?K2NOZWpTZzJBQU1qdUgwT3RwbUZGd2JxajAzTHZWTlhRVkF0ZThSaWFrai9Q?=
 =?utf-8?B?dWludTVwQUlWeVhMOERtbVMrR1JlSlE1RlVSQ0R2dHZSY2g0WENEaUJxME9y?=
 =?utf-8?B?Z1RZOXI0QWRkeVFpaVkzMHJzWFB2VmZEek50K0tHbStFNThnZGdKS3VIMFQw?=
 =?utf-8?B?RS9kME1mZnRjYzFwN09kcG0xcHNkZkJ0OE9ReTR4Y0txV0hUQjcxV1l1T0x6?=
 =?utf-8?B?NjAwVHQwZkc2cXBYSDJ1SDlSWDNsTHNRK0ZPZjVuWkR1MlZDQWpyRHBLeFV4?=
 =?utf-8?B?V3dQZC8yQWVZd0ZyTWRPK25yREFHMzlRY2pNakRZaGpKeTJTVllNT1Q2TGdU?=
 =?utf-8?B?blh2alZ2Mll1cXRWM0s4Y01mNS8xeHdiME56Y3VORkF6VFRUTE5PcmZqZ2Vp?=
 =?utf-8?B?eGZ2Ykowc3MyMldMTGIxVStVcG5VbHpoMnhxdzdCL0JYYmRaVjVoWjhJQm9U?=
 =?utf-8?B?YkpFY2F1NnJpM2krdTJLTEJ0VmdVRGJFZnN3VU1vVmJEdEgwWW9wWDhQWGpy?=
 =?utf-8?B?VHdvbE9IZlRWSE5uaXpTK1pINWNWY3NSbDZkQlYxRkhVbzRzQVhzQTVXMldU?=
 =?utf-8?B?UEZhaFV4Y1U0MC9sK0NUclFpNHErUmg3YTF6emRHaStUQWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk94VWNDdXB4Ukp5TWx0Y04rb3VjSFkyb2l4alhTR2hTMUZwMTFQOHoxRlFo?=
 =?utf-8?B?ZnV1ZDdqMGh2dFFCT0xKK2lHZkJ5T1lIVjlyVjhLcVF5RnEwMDJRUHZHcUMy?=
 =?utf-8?B?YVVzRlc0bUtaTjVxZkhzalVSeTh3MVB5NGNha0NRSHpnWnVOTWZ1VWs1aFhx?=
 =?utf-8?B?eEFPTW15WWF2N25jZU1HY25obER3eWVWdEI2WW15T0p5bWpOUG1UNU1uY1FL?=
 =?utf-8?B?ZVJJOFBjYUIxZjdoUXR4bU5IZ0RYNTBQclhjb2E3SlYrbE44NmZCcFJzYnBP?=
 =?utf-8?B?MUdscmhySW1PY1FrSlU4UEtUWUNhNmFSZzIrN1BST01JZjdBT0xaUUNFQXUw?=
 =?utf-8?B?OWRjYUN6R2hxaktEMVEvNm0wOTMxWnRSWENYMUpHdnBYajBmMlJHK3B4THVr?=
 =?utf-8?B?L1BqZkNKV0M5eWFuR200Vzd4a3BJS2F4S21OaU1WZ25LbmZXWE5xK3M3dlRw?=
 =?utf-8?B?M2ZqSHF2dG10RmJLSzY3dTUvYmlDcSsxNHE5YXU5WlBNTjRwbXRMT3VINEVo?=
 =?utf-8?B?ckZ1T3RlOUJMV2Ixam91SHJCMUZPSVNmcHZHSEUrZ2dBNTFiVWhLbFVJYnBu?=
 =?utf-8?B?MTJ3NjNiQ3Y4d0xaS3pma0ZUQSthOFc5S2Vwdm0rRjgyRmN3cHh5RjBXUVVo?=
 =?utf-8?B?alAxck8wbUtWbk5STXErd0hEbmpsWUFDUGhGaWk1MW1mQlhtT3l2VWY4TE8z?=
 =?utf-8?B?MWVWRjk5RVBNL2pjL3NRU0g4RE1LZDRTN2JvbG1qK000VUU3WU9mTjhXQUVG?=
 =?utf-8?B?SCs4czNwcWtibXJqUkNjMUdVYVNybXNvSUZTMUtMQzJIQXlSWnpXS2ovM01k?=
 =?utf-8?B?czNubU8wWE1ZMGNocURBMjgwSW05VVZsQ2Nodm1EYmpqbkRRdGtFNUhVY1Qv?=
 =?utf-8?B?U3BZajZFbVk5RjhaeVI4QzdoYmxQY25wS0RYR3Z0L25MalhodEFqWTR5WVZu?=
 =?utf-8?B?MVFHT3hrUjgxUjNUcjNVcGtUNkw3Q0JsZ2NXUmpoMFdGSjU3a1FNM29vZXpo?=
 =?utf-8?B?clRIdE9xdVhYWkFtbVdvWVBsSVVyZ3ExUzNFaUdKLzJOVlVabzd1VmZWMlov?=
 =?utf-8?B?ZEY0RTlnaktrZUJFNEl0UUUvZVptbXcwTHhwT0tDMHUzWE1uSTkyTFg2ZFRP?=
 =?utf-8?B?NUp4b25VWlJJc1pIdVlxUm1OUE1MZ2dhZlY4ODNJTUxXMUhCOWFRYnJDcVJ4?=
 =?utf-8?B?d1huOEgvUDZsOFFNVnZaeStzWi9SUks2OVpRZVFMWnA5bWkxNnYrV01Yd245?=
 =?utf-8?B?MGZOM3NNSmFaUDRlSmlieCtKSnZWelFUTWN6UldJcVdPK09iNzhpWkhwNkp3?=
 =?utf-8?B?bk9Ta0Q0emtOdmxZSWhITXk3WFFhV081bUNIS3VNMEM1R0V4d0tXVFZkK2Y2?=
 =?utf-8?B?bG1XZDg4WGhQdjNHbWtFVis4UE5YZkFZMlpiOUozKy9yMWZ5a2dKN3ZYYm55?=
 =?utf-8?B?a1hzeGRCYnVXd3plVzF5azFSTEQwSkdtdVpSLzZmVDQwdCtPUTExMWVzT0FF?=
 =?utf-8?B?RHZEbGh6VXQ1ajNLZDNTRURudjFNZFVOMms4SEd2YVkyOUVScTk3VWQxTmpV?=
 =?utf-8?B?N3Jkai8wYnJwekpNSDRNY254eHV5L29hdGdDZnpCNDBmUXNUZm5aVkVGaE9k?=
 =?utf-8?B?WlhwSlhnWE55T01LRXBrd0lBNGEwRWkzTFk3ZWdMWERjKzJnZFRiTEhxdVZY?=
 =?utf-8?B?OXB2ZjZtU09TS0tZSjN5QnkwZFZQMHNWSEJZQ2h2MVEzR25DdFIwdkRMTkhw?=
 =?utf-8?B?SVNkWmVJZ2hzMTlvellwREtpV0hFcUdhUUd0Y2JkaDJST3E1ditwcHZ6Ykpa?=
 =?utf-8?B?YVpXRjJoRzRIRHZZc0NyUkF4VGVSdjNYenI5SjNQK3Q4MnV1SW5CTTlEV3VK?=
 =?utf-8?B?a2wzTkx6bHR5RmswUktPNVdSSER3TW5hZUtudVcycUxwUzYwYjEzNWVqSmMv?=
 =?utf-8?B?ZldvZTlQbkw1ZlczWDFCL1Z3MHhwcmdjbUFDTGw4RmJVdThBTkdaOEt5Vkp5?=
 =?utf-8?B?dlJwY2tiQmE0bFVDQVJJWndzbStDOWR5RTRpQ2JCS1BXYXNCR0lxWm5RQ3Z1?=
 =?utf-8?B?a1dQZFpiTzZ0RXJQbFJzUDRBWDdaelQwbVhyc05CcUR2bXNVc01ZVWxwWloy?=
 =?utf-8?Q?2ho/Ocvt/gQQ+Dy4gzDagF6Vr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C69CE0E43984F64D8969F726856DA359@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14d6ff4-1fb1-44e3-06c5-08dcd7aec062
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 06:54:33.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AotMSNHwnjL/qnZwk0UIzoHCdoPdSO9G80kM0utZyH3KwlsSev4maiHvP/NLcc5TXwO+J0aNQfdl0bWAXdbGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7664
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDE0OjExICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBX
ZWQsIEF1ZyAwNywgMjAyNCBhdCAxMDoxNToyM0FNICswMjAwLCBUaG9yc3RlbiBMZWVtaHVpcyB3
cm90ZToNCj4gPiBbQ0NpbmcgdGhlIHg4NiBmb2xrcywgR3JlZywgYW5kIHRoZSByZWdyZXNzaW9u
cyBsaXN0XQ0KPiA+IA0KPiA+IEhpLCBUaG9yc3RlbiBoZXJlLCB0aGUgTGludXgga2VybmVsJ3Mg
cmVncmVzc2lvbiB0cmFja2VyLg0KPiA+IA0KPiA+IE9uIDMwLjA3LjI0IDE4OjQxLCBUaG9tYXMg
TGluZHJvdGggd3JvdGU6DQo+ID4gPiBJIHVwZ3JhZGVkIGZyb20ga2VybmVsIDYuMS45NCB0byA2
LjEuOTkgb24gb25lIG9mIG15IG1hY2hpbmVzIGFuZA0KPiA+ID4gbm90aWNlZCB0aGF0DQo+ID4g
PiB0aGUgZG1lc2cgbGluZSAiSW5jb21wbGV0ZSBnbG9iYWwgZmx1c2hlcywgZGlzYWJsaW5nIFBD
SUQiIGhhZA0KPiA+ID4gZGlzYXBwZWFyZWQgZnJvbQ0KPiA+ID4gdGhlIGxvZy4NCj4gPiANCj4g
PiBUaG9tYXMsIHRoeCBmb3IgdGhlIHJlcG9ydC4gRldJVywgbWFpbmxpbmUgZGV2ZWxvcGVycyBs
aWtlIHRoZSB4ODYNCj4gPiBmb2xrcw0KPiA+IG9yIFRvbnkgYXJlIGZyZWUgdG8gZm9jdXMgb24g
bWFpbmxpbmUgYW5kIGxlYXZlIHN0YWJsZS9sb25ndGVybQ0KPiA+IHNlcmllcw0KPiA+IHRvIG90
aGVyIHBlb3BsZSAtLSBzb21lIG5ldmVydGhlbGVzcyBoZWxwIG91dCByZWd1bGFybHkgb3INCj4g
PiBvY2Nhc2lvbmFsbHkuDQo+ID4gU28gd2l0aCBhIGJpdCBvZiBsdWNrIHRoaXMgbWFpbCB3aWxs
IG1ha2Ugb25lIG9mIHRoZW0gY2FyZSBlbm91Z2gNCj4gPiB0bw0KPiA+IHByb3ZpZGUgYSA2LjEg
dmVyc2lvbiBvZiB3aGF0IHlvdSBhZmFpY3MgY2FsbGVkIHRoZSAiZXhpc3RpbmcgZml4Ig0KPiA+
IGluDQo+ID4gbWFpbmxpbmUgKDJlZGEzNzRlODgzYWQyICgieDg2L21tOiBTd2l0Y2ggdG8gbmV3
IEludGVsIENQVSBtb2RlbA0KPiA+IGRlZmluZXMiKSBbdjYuMTAtcmMxXSkgdGhhdCBzZWVtcyB0
byBiZSBtaXNzaW5nIGluIDYuMS55LiBCdXQgaWYNCj4gPiBub3QgSQ0KPiA+IHN1c3BlY3QgaXQg
bWlnaHQgYmUgdXAgdG8geW91IHRvIHByZXBhcmUgYW5kIHN1Ym1pdCBhIDYuMS55IHZhcmlhbnQN
Cj4gPiBvZg0KPiA+IHRoYXQgZml4LCBhcyB5b3Ugc2VlbSB0byBjYXJlIGFuZCBhcmUgYWJsZSB0
byB0ZXN0IHRoZSBwYXRjaC4NCj4gDQo+IE5lZWRzIHRvIGdvIHRvIDYuNi55IGZpcnN0LCByaWdo
dD/CoCBCdXQgZXZlbiB0aGVuLCBpdCBkb2VzIG5vdCBhcHBseQ0KPiB0bw0KPiA2LjEueSBjbGVh
bmx5LCBzbyBzb21lb25lIG5lZWRzIHRvIHNlbmQgYSBiYWNrcG9ydGVkIChhbmQgdGVzdGVkKQ0K
PiBzZXJpZXMNCj4gdG8gdXMgYXQgc3RhYmxlQHZnZXIua2VybmVsLm9yZ8KgYW5kIHdlIHdpbGwg
YmUgZ2xhZCB0byBxdWV1ZSB0aGVtIHVwDQo+IHRoZW4uDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBn
cmVnIGstaA0KDQpUaGVyZSBhcmUgdGhyZWUgY29tbWl0cyBpbnZvbHZlZC4NCg0KY29tbWl0IEE6
DQogICA0ZGI2NDI3OWJjMmIgKCIieDg2L2NwdTogU3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUgbW9k
ZWwgZGVmaW5lcyIiKSANCiAgIFRoaXMgY29tbWl0IHJlcGxhY2VzDQogICAgICBYODZfTUFUQ0hf
SU5URUxfRkFNNl9NT0RFTChBTlksIDEpLCAgICAgICAgICAgICAvKiBTTkMgKi8NCiAgIHdpdGgN
CiAgICAgIFg4Nl9NQVRDSF9WRk0oSU5URUxfQU5ZLCAgICAgICAgIDEpLCAgICAvKiBTTkMgKi8N
CiAgIFRoaXMgaXMgYSBmdW5jdGlvbmFsIGNoYW5nZSBiZWNhdXNlIHRoZSBmYW1pbHkgaW5mbyBp
cyByZXBsYWNlZCB3aXRoDQowLiBBbmQgdGhpcyBleHBvc2VzIGEgeDg2X21hdGNoX2NwdSgpIHBy
b2JsZW0gdGhhdCBpdCBicmVha3Mgd2hlbiB0aGUNCnZlbmRvci9mYW1pbHkvbW9kZWwvc3RlcHBp
bmcvZmVhdHVyZSBmaWVsZHMgYXJlIGFsbCB6ZXJvcy4NCg0KY29tbWl0IEI6DQogICA5MzAyMjQ4
MmIyOTQgKCJ4ODYvY3B1OiBGaXggeDg2X21hdGNoX2NwdSgpIHRvIG1hdGNoIGp1c3QNClg4Nl9W
RU5ET1JfSU5URUwiKQ0KICAgSXQgYWRkcmVzc2VzIHRoZSB4ODZfbWF0Y2hfY3B1KCkgcHJvYmxl
bSBieSBpbnRyb2R1Y2luZyBhIHZhbGlkIGZsYWcNCmFuZCBzZXQgdGhlIGZsYWcgaW4gdGhlIElu
dGVsIENQVSBtb2RlbCBkZWZpbmVzLg0KICAgVGhpcyBmaXhlcyBjb21taXQgQSwgYnV0IGl0IGFj
dHVhbGx5IGJyZWFrcyB0aGUgeDg2X2NwdV9pZA0Kc3RydWN0dXJlcyB0aGF0IGFyZSBjb25zdHJ1
Y3RlZCB3aXRob3V0IHVzaW5nIHRoZSBJbnRlbCBDUFUgbW9kZWwNCmRlZmluZXMsIGxpa2UgYXJj
aC94ODYvbW0vaW5pdC5jLg0KDQpjb21taXQgQzoNCiAgIDJlZGEzNzRlODgzYSAoIng4Ni9tbTog
U3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUgbW9kZWwgZGVmaW5lcyIpDQogICBhcmNoL3g4Ni9tbS9p
bml0LmM6IGJyb2tlIGJ5IGNvbW1pdCBCIGJ1dCBmaXhlZCBieSB1c2luZyB0aGUgbmV3DQpJbnRl
bCBDUFUgbW9kZWwgZGVmaW5lcw0KDQpJbiA2LjEuOTksDQpjb21taXQgQSBpcyBtaXNzaW5nDQpj
b21taXQgQiBpcyB0aGVyZQ0KY29tbWl0IEMgaXMgbWlzc2luZw0KDQpJbiA2LjYuNTAsDQpjb21t
aXQgQSBpcyBtaXNzaW5nDQpjb21taXQgQiBpcyB0aGVyZQ0KY29tbWl0IEMgaXMgbWlzc2luZw0K
DQpOb3cgd2UgY2FuIGZpeCB0aGUgcHJvYmxlbSBpbiBzdGFibGUga2VybmVsLCBieSBjb252ZXJ0
aW5nDQphcmNoL3g4Ni9tbS9pbml0LmMgdG8gdXNlIHRoZSBDUFUgbW9kZWwgZGVmaW5lcyAoZXZl
biB0aGUgb2xkIHN0eWxlDQpvbmVzKS4gQnV0IGJlZm9yZSB0aGF0LCBJJ20gd29uZGVyaW5nIGlm
IHdlIG5lZWQgdG8gYmFja3BvcnQgY29tbWl0IEINCmluIDYuMSBhbmQgNi42IHN0YWJsZSBrZXJu
ZWwgYmVjYXVzZSBvbmx5IGNvbW1pdCBBIGNhbiBleHBvc2UgdGhpcw0KcHJvYmxlbS4NCg0KdGhh
bmtzLA0KcnVpDQoNCg==

