Return-Path: <stable+bounces-246692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEsmFMCoA2oO8wEAu9opvQ
	(envelope-from <stable+bounces-246692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:25:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE752AD37
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BAFE3062C00
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCA3A0B24;
	Tue, 12 May 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQuwavwK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BC3672BB;
	Tue, 12 May 2026 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624697; cv=fail; b=h1SAqvlDO9EJ0xVjuzaOT/F+M80qhto8LQFfKt7VwGnhmAONXP4ZTWb877ZPYoRw9T+SHnCZaUqItQR2vaiCjHTp1p+B3FB/BhaE9awraPTFwhLUe00sEa2bgYL00cXC9jc5SBueSOTuhWiZbupdlk8HqNcFAwXE/Ux2m4flD/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624697; c=relaxed/simple;
	bh=Sm/QIYceOXoWAkiINCnbvuS9IARnHcFYyXLSmbbJLJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnTPlVn06Lqe6K+5nXvwxnfMUvWYv0pitPtjeehSPTQyMyFALPu0JDbjeQxnMFzjRfSqRqn9aDbenZ/Oga7pgJVCVjAt+rOnrQD5VeXJuMTgt3PheKDpnPNuT4965Hw7mvfq2bnbjwTjyAMQnZPRVX3EOGX8MWEttMgcCPaeLU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQuwavwK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778624696; x=1810160696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sm/QIYceOXoWAkiINCnbvuS9IARnHcFYyXLSmbbJLJY=;
  b=IQuwavwKz9e74LHu4ShQtEt/O7bKVFO7PwaXrFFwlineYzDqdjv+AQ83
   8kILcpipvpdrsCKllGWEktJXsbXI6M7osWWbYdKj/g80mknPw8lrBmZOW
   wdwpNnxj1QK4wnRjxpKxG9UVVRabtAIiB6KLouuVCGq/FQFP7LtUO+FQo
   S04Qa47A1RRrCHH/nQgx+W3tZ+8kLcOsecmXiUM0g6XoepDQDifJunwcj
   Y68Mlf1suNMzvzXizxjFc7eYhSx6U62jk7IachbQAQTyx0SJf6kJhdElk
   vcRQQcFUKaBYlNGztNaR1+swy58Oq3D2tQELXZr+pRq1bCFL020/GTJjt
   Q==;
X-CSE-ConnectionGUID: j/1+j99AS2aVRjuJYgTzEg==
X-CSE-MsgGUID: ReyaKsSgTOqWABEZqqrfCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78689669"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78689669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 15:24:55 -0700
X-CSE-ConnectionGUID: I4N+SMXyTe+KUbt/d2zzqw==
X-CSE-MsgGUID: SmQzck7ET9us7r/VgD1Yow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="261639654"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 15:24:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 15:24:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 15:24:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 15:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j50XKN6eRmk8a2XmsYjAsPjy8tem/bUdYL6o473kBIkMLT1T6OWrwaSCpN+aZMrdt34bH2iwlSd6DKM7HCzZEQIi2VkYUQqnXm5CEuY+v05rqTS9ZJ25NTp0dpz+yxWaCL2HLL0CoI92jIr+CoeM1WJDADBdBRnWoIEpyG9mgC+fJc39Btu/MLK2onVwFhMCJtjyYDi4y/dbfFpc1QTdc/tGRqe4zXKi3azzScdK6W6qhkhKTuz57qUK57NLH3PxQycio6vfY5PjGb9eWqCdEfig3c5ApNCFStZP1MCpGcj03bKH/RJrAY5A8OmZrXeNorAVxdLVNj753oK0KBCrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm/QIYceOXoWAkiINCnbvuS9IARnHcFYyXLSmbbJLJY=;
 b=j3w4To2fdWYKwaurgSkEim1vFffdh2tJwAhyIKnbyOSOde6nrNS8SjyEBKHGxJewx3YwCvrhyCjJ8nF0QB5JFhfre6So3LB3kMsHcBzuzddy9O355ek1U5eIFzEgC7Zj54DJoWhctfKkY2yTm7d3ZO05iDSK05mkHVprwvO+OxDorlYM3mnA4I+vyvqPTl6X8EqWozg6g/R4Wa766yqo6q3ShnrtY08Yo44H1ZYLH6IVeZ8SKDvNrc7fQjP724qaJATo5d2rRpFlb2fxg1r9lERiAp3G36tSIpyb4GEWD+wSa+Db8fw+hBkhvysPk4KtaohvzFlXsMVrJgSv3fJqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 22:24:51 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 22:24:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Hansen, Dave"
	<dave.hansen@intel.com>, "clopez@suse.de" <clopez@suse.de>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Thread-Topic: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Thread-Index: AQHc4leZtVFzGNxN3EuH83/xEfDKtLYK7ZEAgAAHRACAAALHAA==
Date: Tue, 12 May 2026 22:24:51 +0000
Message-ID: <43a913a1b4721c752443416a685631478bee2f10.camel@intel.com>
References: <20260512213719.20974-1-clopez@suse.de>
	 <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
	 <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
In-Reply-To: <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|LV2PR11MB5974:EE_
x-ms-office365-filtering-correlation-id: 6aaa393d-f99c-4323-4f7a-08deb07548cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|38070700021|22082099003|18002099003|3023799003|11063799003;
x-microsoft-antispam-message-info: FpV+qFEMVHSQTuG5Vy3bBeFtqRLbe+H93HlQSOltX/wqyVYnaVb5fv3C0G3EXUDvZhwyb3+ErE3dNXYKlqWMR5wgfvt3OTUxvAOMbEYhdbi+bmZrYJVlr5XWrMTXd4D6JR/Yu20x6HA8ShOHqkEZqx1h699W1w7SmInGyU0khDLt0vjInebd0r4p3yx5JYsG01J4mQqjWhj5pUxNYOKJpKxC/rfhXJSoGK4qM75+T1PA0WqvsQdf59DvONEKdOArHe9Cj4XDXhk6S/70b+XAHpMdQ2UOMVEcwTpryWc/N35JPSbhSIFHywTFbSWBZH5kV0SqKkj/SBp48UIYgRwCGNH53xBYlZzVAt7u52mDOGNuOMcMbh207Eajc/VUn8pqUkO1nCBr86o3WEmJxufvIkA2qlkAIKsQE9Bq8kfDE7YnjN/qoefk0yz5VpPOsUhD+rj8NemHaWvFPvq5fn8dGxPS6enLykoqQgIk+QcgDO2T4qr7vCA+t5oCaicOh65GKRNAPkzvqphSOdplirlyDheHqlZg5aSH5XksBzNg+w/0Jq9LACDpAzbyu++QxsKE3LcCc8pzazLL9NA8cJreD1htLxpXOfUf6DABiA2MV5Kf7uxNJzmpqDWFb+dnYEMwZ7NHuhiT31AQgSJr01lg2KwxS8onsH4d9u2amyDiS9m7zsLqE2SkmuTu8aJcEE6HYg1CZr5q+RPopupeON3ItMHQLWXNtSenrKKzH8cdSz7cTpB+IjyXrEuyyMFa4XQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(38070700021)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymk2enpPLzlEMm5kZkZPR1NZdXNrTG5sNEI2NkRaM0tCTmlPSDdQZkV4RlM0?=
 =?utf-8?B?WUtHVEhHQkRTcUEzdEJkSHkyb0tVdDJleHYvbjFOK0o0MitLMnJCdzE1L05D?=
 =?utf-8?B?SWl3SE1WVmlvSFpmeW5mUzU0ZklqMTlkM2VkWFpDUzUxOElVOTZZNnVCeFFi?=
 =?utf-8?B?djBoaDRHUldRKy9CYzlqcHR6ZUtoeno4ekttM05lK21lbUc5SERhaXJ1T0pY?=
 =?utf-8?B?OGNXREhGUnZPU21mRnJLeXM3ZFRxNUdCRGhHUFNrcWZlbVhWOVpJdnd1T01S?=
 =?utf-8?B?NmdsOG9vN0p1NE9HMSswS24rak0yTkhvNVh0VHk3TXN4YjNQUm5Ub0dsSnlG?=
 =?utf-8?B?K25BdzBidWtYdG1WWWFSaHFwQkhmVkptZ05BaG5FWkJTdDJTdTJJNXBVWEx0?=
 =?utf-8?B?ek5YRzdvbUpUa1ZuTFJLUGJCMnI5UDNnUlFxVmsxNW5hSWVmTnRQNC9SY253?=
 =?utf-8?B?YjUxV0xlSTQydzVYaTNiNXNVOGN3dzFlVENpampvLy9qb0VnS3pnYUdaOGpn?=
 =?utf-8?B?WUw0SnM0TFBJTG1GYTJSR3VTZk9iQWVPQ256QW5UQUdaVDFmc0xrelR5R0Jy?=
 =?utf-8?B?alcvdHJ2aTRwcE9NVmZPaDZFRC9aRVJyU2oreDFhRGV5Qm9oWHRlV0ZibFpC?=
 =?utf-8?B?R0wyVVN6RzJteG9RVFRtQTZGNG0xK3hOeVJvWHAyNllpdm9NYTVMbkRZVHI5?=
 =?utf-8?B?d2l4b3BaMEl6TVZaTVVRaXREYVB3eENTL2prS0dXbis2aHdtOU03QUVycG1Y?=
 =?utf-8?B?ZnhhQjR2UHM1MWtjdTc3d3NwaDZiaGhOMVRxZjhqa0R0b1BMYTk0NTJMZDNq?=
 =?utf-8?B?NmFsUjltd09VOTJOZ0ZYeS9QdlM3SFM2NnVJRFZOVmUxUHBHMzFvYndaa0k3?=
 =?utf-8?B?ZE5Oa2xHNm5CWFh4U1Z3NWZKVUtrcFlISGZHU0QwSUpWV1VUMCtWWGNjK2Vn?=
 =?utf-8?B?QURqaXgwL3JGYWpwc3k3VnFvazZtQ045NGp6TDUwekNoWStGWHJvUVFTbGFJ?=
 =?utf-8?B?L1g4aElIZ2RuT0lEOGZtckJnRGJYMmpjNzRrbTNvbU5PWXhLbzIxTEtNVVhh?=
 =?utf-8?B?RWlvUThVNjhBWXYyd0daSEhWMlVpVG5JNVZveWM3UTN2eVJOV2JIUEw5RGN2?=
 =?utf-8?B?Sjc0ZFJDcE5ZaUJFSnRrY05EeVovYzc1WVVST2NKKzA5K3FkZ25OMk1lTlgv?=
 =?utf-8?B?d0lhL0Jlb3ZXbDlBSmw1Vnh4U0NCQjllU1hTM1Eyc1FPQkh6WUR0bDc2Qkl6?=
 =?utf-8?B?QmluZ0I3b2VVYzNEVHd2T3NVSlZ4RTN0czdqQS9pUm50OVVSRE1CbjNwYml0?=
 =?utf-8?B?YktOMVdZVnFGUE90WWRzeXJWV1pISG5UN3UrSEVzc3l6SWVqV1NTWGZWL1RW?=
 =?utf-8?B?ajI0eTRRQWdmR2MrMWJIQmdRUzdHdGF1aFRFcHJpamdGQXBJQnFwTyt4QUlN?=
 =?utf-8?B?TmpNOVlxb3BvNVNKV0RLWlMzUnhQZEhLaXRSS2NUOTZOSWVNTmxvVTRTcnpw?=
 =?utf-8?B?d1kwTEpUTU1yOVcrb0orWkxzYnV6dHJKaFZIUmNWNE5PN21EdFRsZGNWQVRQ?=
 =?utf-8?B?eHhIRnpxY29LeDNrVkN6eEE5bC9KSnhBZ1AxOVFmSk9Ud0JYR0RKQlVLWHRB?=
 =?utf-8?B?OG9EWUVrelJ6RXkybHIrWVJMWW1wRzV0REYzWHJuY1BwcStFVUEvY3VVb2pu?=
 =?utf-8?B?WHQvaHhaVXRCSlZyMWMzUWtFRGErak01QnRrZ1FMak1nb0hyNlROa2FYd2l0?=
 =?utf-8?B?cDJBT3pzSGt4RTl0dkZEcjhERkVHSEpGU2xCcTRaMXdnblZTd1praXpxcDU2?=
 =?utf-8?B?ZnZhK2hZSTNrbzhhWTVhKzcyTndPbTJQMm8xSTBEcTVpazJsamhxTDZCUjZE?=
 =?utf-8?B?cWFDbldranJ3Q1A1N1VWR21GYzZwNWptU3Z0WU4xQjBMRDZsVmRGODJnVndQ?=
 =?utf-8?B?bCtZeFBGYlR0d2F5TUI3amM5MWkwVmJGbnI3Q0VwUmE2MWFkNk5XMGptcDhM?=
 =?utf-8?B?OGlVQitaMmlEU0wrWXJraTM1Q1pibnN4TDIwdDVCdHlyNk5URHpoMUViNEVl?=
 =?utf-8?B?cld6eU1PemcvbVNCU0kxY3lMYzJlRm9wVnpFL2kxcEpoUTdreHF2Z3FRK3hW?=
 =?utf-8?B?UHdUY2IvamFyTW5zYzVSTEhKKzJER3YwNk54dmRhMHlYbVBQMVJYOCtoTVRB?=
 =?utf-8?B?Y1RQa1k4VC95VldRc3RXUWs1VlhmSDJTZHoybm9PU2tKVHBIR1Q5MS94aVBC?=
 =?utf-8?B?Z0YzMEpTZWYwYWxJN2FzZC9rOS9xSFhtaDNEVW1kK21qcXVpdkl6NEtiMGJz?=
 =?utf-8?B?RHdyWG1FWGxqeGYrV3BhWDZjRkJ4d1NRdFdYVCtJMkY0RGpxcHBFVHlESGZM?=
 =?utf-8?Q?VdbbANU9ssGg+GLw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DFD2C99767B064C949616BFC42F28C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OPUVOcu+J6fnlsJ3FtDT4h8eAPVovWIxVryHK4njmeXf3UUJcocC65X0H9BHCmvBqIe/UjCjwv6OKSP0YNAOi7iWu3x59RMGqMqPD0/NJbEJWLzX1hXhCST2pfnLHYwoZVzL1L5IBGIeKi/c3aLrFF/JlzSDUHf2gXq34d0++Tn0FaGql6bUL0wV4qHAsE2kqWxXNkjti8xOdBJNTz1sm6V9S3ZyCi7C8OUP4ZSxR78CCbFaiDAx4r3uXWdDbnFB+LhcInQu2PWO2cnTXQW92C32zaBKLVu2SHJSaynHzm0kCqpb138HnfAiiR1Mv/gxiioAPxsk5/dyvVQFPnkSIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaa393d-f99c-4323-4f7a-08deb07548cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 22:24:51.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXw6NRIl87KBo44n7HEswrxHemTIZ2Qor9LuIlzgvgX/YVmeD/p++9+wmPRRcYgWfL0r6hX0qJBBSFcrn+9/2IcifPwhE7Mr0T2W9fqKZAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A8BE752AD37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDE1OjE0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
VGhlIGVuZCByZXN1bHQgaXMgdGhhdCBhIFREWCBndWVzdCBjYW4gdXNlIENQVUlEIGFuZCBlbmQg
dXAgaGF2aW5nIGJpdHMNCj4gc2V0IGluIHJheC9yYngvcmN4L3JkeCB0aGF0IGFyZSBhcmNoaXRl
Y3R1cmFsbHkgaW1wb3NzaWJsZS4gVGhpcyBwYXRjaA0KPiBpcyBlZmZlY3RpdmVseSBmaXhpbmcg
dXAgdGhlIFZNTSBuYXVnaHRpbmVzcyBiZWZvcmUgdGhlIGd1ZXN0IENQVUlEDQo+IGluc3RhbmNl
IGNhbiBzZWUgaXQuDQoNCkEgbmF1Z2h0eSBWTU0gY291bGQgbWVzcyB3aXRoIHRoZSBndWVzdCBp
biBhIG51bWJlciBvZiB3YXlzIHRob3VnaC4gRm9yIGV4YW1wbGUNCnNldHRpbmcgaW1wb3NzaWJs
ZSBiaXRzIGluIHNwZWNpZmljIGxlYWZzIGluIHRoZSBsb3dlciAzMiBiaXRzLiBUaGlzIHBhdGNo
IGlzIGENCnJlbGF0aXZlbHkgc2ltcGxlIHNhbml0eSBjaGVjayBjb21wYXJlZCB0byBhIGNvbXBs
ZXRlIGNoZWNrIG9mIENQVUlEIGFyY2gNCm1hdGNoaW5nIChvciBNU1IsIGV0Yykgb2YgY291cnNl
Lg0KDQo+IA0KPiBEb2VzIGFueWJvZHkgZGlzYWdyZWUgd2l0aCBhbnkgb2YgdGhhdD8NCj4gDQo+
IERvIHdlICp3YW50KiB0byBmaXggdGhpcyB1cCBzaWxlbnRseT8gSWYgd2UgY2F0Y2ggYSBtYWxp
Y2lvdXMgVk1NIHRyeWluZw0KPiB0byBzdHVmZiBnYXJiYWdlIGludG8gdGhlIGd1ZXN0LCBzaG91
bGRuJ3Qgd2UgYmUgYSBiaXQgbW9yZSB1cHNldCB0aGFuDQo+IHNpbGVudGx5IHBhcGVyaW5nIG92
ZXIgaXQ/DQoNCkkgYWdyZWUgYSB3YXJuaW5nIHdvdWxkIGJlIGFwcHJvcHJpYXRlLiBUaGlzIHNo
b3VsZCBwcm9iYWJseSB0cmlnZ2VyIGEgYnVnIGZpeA0KaW4gdGhlIFZNTS4gRm9yIGV4YW1wbGUs
IEJJT1MgbWlnaHQgaGl0IGl0IHRvby4gU28gSSBraW5kIG9mIHdvbmRlciwgaG93DQp2YWx1YWJs
ZSBpcyBjYXRjaGluZyB0aGlzIHNwZWNpZmljIGJ1ZyBpbiB0aGUgZ3Vlc3Q/IERvIHdlIG5lZWQg
dG8gd29ycnkgYWJvdXQNCnRoZSBzcGVjaWZpYyBpc3N1ZSBmb3Igc29tZSByZWFzb24/DQoNCk9u
IHRoZSBvdGhlciBoYW5kLCB0aGUgI1ZFIGhhbmRsZXIgaXMgc3VwcG9zZWQgdG8gZG8gdGhlIGVt
dWxhdGlvbiBvZiB0aGUNCmluc3RydWN0aW9uLCB3aXRoIHRoZSBoZWxwIG9mIHRoZSBURFZNQ0FM
TCwgc28gbWF5YmUgdGhlIGNvcnJlY3RuZXNzIHNob3VsZCBiZQ0KaW4gdGhlIGd1ZXN0Li4uIEht
bS4uLg0K

