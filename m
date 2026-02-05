Return-Path: <stable+bounces-214445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDtXGKKBhGl/3AMAu9opvQ
	(envelope-from <stable+bounces-214445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:40:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E797CF1F90
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BADD8303EA8A
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C93AEF31;
	Thu,  5 Feb 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJchazyq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73903B52F0;
	Thu,  5 Feb 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291552; cv=fail; b=kAI73UAPSvxrJrPiXAiw4GaoGCCrtDtybiv32TCJSx8dQsuq4GbsqyYjVq41NecJxboI/SpQC6Jjo6T8hXjCMZVmvJa2euKycxbyJaVjlz4B8KyanUW8kDxdHj0Hk+qWW39u2k346pfo5eoFmIWnQECgimUSA6wI9P9IaPjnIao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291552; c=relaxed/simple;
	bh=gBATVs34dZbT3QRbqqdDCKudX/Ue07uK/kcFGi4VG3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKAhyMdQp4woI4MyvATm6KVq+3+jBnKNgdtV7E1sq5ZYvNFzSLaa2vE14EpR8RWZYjLG3FTd8vWGYsQKAj/0to4UrIvAO4YPjHlvSeSgaXotx3xp2ySRyJInqySRGVeQ/5IqOTiV6mqkjrqRhxMOxkwJs8ykJx5o5F8lj7F0ark=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJchazyq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770291551; x=1801827551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gBATVs34dZbT3QRbqqdDCKudX/Ue07uK/kcFGi4VG3U=;
  b=EJchazyqOhpMMO8OTwrIXf23BjDTRH9pGLK/rCGS73ccq6BzxaWxL5Ls
   jmmC6RSQGA6bsWRHvlwYPeRSinCqgZSY0elm0yfiqvfJMXgckRRGsrXb+
   0fhj3ZE0IaIrUQTOm97NmkmEzZUovf/niNh15PjH4zcj6mHFzbhBVQILb
   FQU3qHZJ3VZWw6mECiXkekYeglhf7q7zQMp2kl3+mQbaXW0nSBKd6jH7W
   XEC7hY44fWhNeKzZCET3ketsdv/B2Ti6WkiszUZ3Kjv/hCIiZnd8ZGIba
   2owV1WBEvWJbMUb+ZAxqKm3hoOVYIceA40CqMDiEqBPCuYEn7iDibujOs
   w==;
X-CSE-ConnectionGUID: an2JTokIROO/7nFIYgfo5Q==
X-CSE-MsgGUID: MYT1EHwJTp+ha4R9G/mBmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74088528"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="74088528"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 03:39:10 -0800
X-CSE-ConnectionGUID: hPuDshxVQESKGolTTzpf7g==
X-CSE-MsgGUID: AhNSYiKTQX65DJYkJrpm1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215009678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 03:39:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 03:39:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 03:39:09 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 03:39:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhGUeobxrJmU55rGbyY/328Hte68+9bmsstd0bLrC105tP+0o9NsbRsLEz9LW2VD/nkC8EwnvcD+eeIEjQfIdb5MQCjPFxQNgBnjbDuUGVvZ7IunSvvAjzYrMXzp14M28JvThVhSrr6R0j9uH5YtSxA9ptHs/cgMiYT6C4OtQw+t1t/5wbwhs+yrkjNwWHjQ9s1uA2t8VnZIpw9b9llfWB69nLXWXYuqtva5Y2TYn2Sbnl+4CtrRBGTef4ccLyGtT1kV457NjOIDF+hOtJHGHtxvI8zdVkdt3FTjuj/aK/LP2Hnia6yVyyMMJBwy7CIyNH1KG7p7UG8c2BKsz8p04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFdU7ZicbL+bW+8ey2oI6J1i4CBf+LwdRymhkrE1Qx8=;
 b=lybpAZrI4nxMTs38FHm2oV8c2BhSET2KAHW27vcbtER8xitV52Gt7boEy8fD+v9ZeUb6ZZ7ajtLlq+aZO0j/jK81isCpsxPRdeJB6UvW/0kyFzsqxL6kVLvrNDSLQFM3x19WrwZcyv4IiZMD3KgfTab52HhAyeFAiWXow5WSonih0uvlGnwkLJ+kn/2feCnzOfC58UJ21dAa+rkyaPWPNPma9hl3Y06oC+WNnXuIlElx68FLUpkdf2lUAq2Joje45TuZw28a9+guG3cMmrj/VM+W99gNj94wzZlU4nhg2QK8pi3G7+KRfi9iAODNaTvPF4MPVKoSdwcBOwPfVQz3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 11:38:59 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 11:38:59 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ixgbevf: fix link setup
 issue
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ixgbevf: fix link setup
 issue
Thread-Index: AQHcactShLSTikFOkke2xEZ8/lju77V0VFgw
Date: Thu, 5 Feb 2026 11:38:59 +0000
Message-ID: <IA3PR11MB8985CFA7F1485BA2BBF190D18F99A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20251210112651.5556-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20251210112651.5556-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: 88fe6801-0593-47cc-48ad-08de64ab2768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ek6Rfbn/AliiCnq2v/bNT25o6JaYsqDRdRYvcYO09U/iwP9FS6wNJqhLS1mR?=
 =?us-ascii?Q?0Kd1twK7opORraaNFoLQWRtpWd0zYMXj1z8aI91pWP04Gu4d9MEoT9NvpRuW?=
 =?us-ascii?Q?pHZ+W2WoK/uRSM3XJZLuXK8q7wzuAaE7k5jhg2FTElQBv+pJZLTxEEw7ND5l?=
 =?us-ascii?Q?5XrYA78EUJ/p3Dm9a+uZPydqxADANiIt10sVuwkcXH6iDgDBWXzvJ82yASc4?=
 =?us-ascii?Q?INdoA/gtKOP9Auzy6SkPPDXipcNm0K9YiB+xXxK31GcjMZVS3I488ldtMaet?=
 =?us-ascii?Q?H3A6sdRGXuFe3pIQcUY0zrzWkW2h6b3TgMxqbsecKpNCJTG0NoI7/VcCWNFw?=
 =?us-ascii?Q?Waw4hX68d+qj1f3eNkY+8XrxcxKFNWss2louIdRrPreGaBiaK4CBuwN0Q0OA?=
 =?us-ascii?Q?9S0MqTr/sD6o3D57nfFR4Q3WMbZIfT/OFQZOxM2x3xzlZY/p8+yIrM8/26r0?=
 =?us-ascii?Q?i+uQD1vFdGCT8s8Jd2Bg4M6jFPFkXlUkRNXHrQXQySOlgg8wjUz8YhmB8yeK?=
 =?us-ascii?Q?bikJYv+k3aSVEZSkUvmKMVjRK0IvrEDfBk7XIUicc/DIiQ9iPYV2rcPlzfJT?=
 =?us-ascii?Q?wBx0E1qOq+xo9lNuUiXfkbkExlyhYOPRFnagMeD3XhUa4MxYqWeNsvKlrEiY?=
 =?us-ascii?Q?00lmBK+07MKUOos7TA6bGUvKDhunne/XB35cYuuxSYdLr2u6iSameu9qorQu?=
 =?us-ascii?Q?EzBz59wOdyDrGeLPnniGEtDWt5XQ0kN8za4tsU6iMrHlS21mPK9BZVnDGTTQ?=
 =?us-ascii?Q?H2L9EheYptWdXiotsNXoPSsOuZab5Qwp+Hg1WCldAw1NUULUoh1bkseRLUlS?=
 =?us-ascii?Q?yQ8t0PVnmfarjf2Aaq+1IaJm/CYPDU4mITqZvwauF6XfuUWRSXG4vhebda8H?=
 =?us-ascii?Q?bhAMesqtS8Oiblw8SCkhMduQW6muWDzSnQS6GVV8y6OVponPFAaUa0r+4Qfj?=
 =?us-ascii?Q?j1wfB2PWTWpI/9Eezsy/Hid7Dgc+XQ1mTY5KtagooO8O/+3Ie1vq2EaybPyf?=
 =?us-ascii?Q?hoyKDz3Bmsm6JiRakbIJdKv0M/3cmiQtRIiCYfOFtwi9Xd/M1QIlrWWi6Isj?=
 =?us-ascii?Q?tqrztWwq4bmd1LHy9DXVljh4fmejeId3nFuNM0LLJqdkaonyWzqZavuBL0BA?=
 =?us-ascii?Q?LfaUQ8c1eM5BG+PTR9GTsu6t72a662GFyr/zf9Po8DLHvnfWBXb0a5ccr4oU?=
 =?us-ascii?Q?NP2oysdWSHXZn+PugRxPMsdBQAcf41iO99Ml6IXfDD1GwF1rfiIn2JWRNbSq?=
 =?us-ascii?Q?ViNMKtlMUCXUlRXMtIDfwjQRqIfu67vR5W9E9Rl0Sr1bWcdNeQxYb8BGmMiS?=
 =?us-ascii?Q?fxXzmuHWboq4KKcJdAGJaNkBV4h3adLercvS7Kl3Xyw6HJX58h9bkDEXS8KN?=
 =?us-ascii?Q?mIS/pmsXprW980VkUuCKLHctmRBbAdMko4cZZb/TIjWt8esZucnmXrTnOFkc?=
 =?us-ascii?Q?FsgYBUshaPAWSk/53BN2opffbSkzx950AkCWDXXXNyAciGAeFBAapWmLu8W7?=
 =?us-ascii?Q?PvQrC+FQDHIiLdn+3ihNCb01a13zlflFRvcYJ2xjyxnZ2cyrJHvUCWZW15VL?=
 =?us-ascii?Q?qPALtB+KByfoxhUu79HTarimsYX3/FXKICKTOacSU5tCaizIlRwCrw1E8DXC?=
 =?us-ascii?Q?gW+rRkDEt5XkJllPOPuD2E0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X2j4gdjbWUEEL/bev/DgIkwg07BhPxvrDriBEEl5+IC+2KWQ8ryfwDePqrj9?=
 =?us-ascii?Q?EkHoAEAYT7wjcBZuNnUsTvqK8KIo/O6sTvKFT6Tn84xJokuqx8bxoY7ZMSoI?=
 =?us-ascii?Q?+Es2lPUf5ckojnPn2uOKMrFYMa7djamokinRzOzjS2k9M7lUIIvroPRUnawK?=
 =?us-ascii?Q?8OEO8XrRLGEdmXms9tIgTeUxYcEy3ElwaJHb+cX8q69YG1aeMY3Ibf0uMCas?=
 =?us-ascii?Q?lv5/JzAqwI9q3eMTKKHreaQbu+lGYTZxeBBCGuBgGTg5vlWq+DZ19HNVqm7/?=
 =?us-ascii?Q?KYtTv+X8L7h3vXUELOhXNqZqLugPXLUrtT4PimQ7cCimW2+a1ky47yUeHi29?=
 =?us-ascii?Q?XhVSz4phRCcopPYQJpGuEi/iyXkPDNqku6NQDfYYt0U6ujPGE7+DAE/Pn1l3?=
 =?us-ascii?Q?RNAuQBiNqsmYNggois+VZHF3aLdME0ZpsR4W0p8rimrBD6stnbf7z/DVED1u?=
 =?us-ascii?Q?hdCBwvLFLdroWcszYhyUOt9BSclIeXpeubFczniTHmqXgARko/sTeU68fDY8?=
 =?us-ascii?Q?U83l6neXYdoI4m+GoHYnS6LWsIttDHAFR396ePUxOtNBhK+VPKMLcPPREx84?=
 =?us-ascii?Q?H0UVpk16Bn6GIbcBg9gFWIpxgZzH0DylhSwx4xj6nR16K/VCtGSu9S/p1tV1?=
 =?us-ascii?Q?4lI6oi8c2479Kg9XQHdGqs5+PIC9rAI9siED4OpkbweGK50htkadDmzg8X1u?=
 =?us-ascii?Q?su4mBTkjrXEfy7sSEAiJuXqUdP36d478ewA3HJrFoFqpa4JBCY05RZjQfT6O?=
 =?us-ascii?Q?1NIbA17eM/ooy8qE2m72NnoSrqv5q4ync4WfKVI8J9r4BXJkv7bDgdqIHB5a?=
 =?us-ascii?Q?THgvLwYZLSMoR9o0AHjDdOViNP1jdrAjFHAofYkLewfxhKmp/rTAYmpQEXuS?=
 =?us-ascii?Q?gJ2pMZDiyewuSTdQTedYsjMe2eP0aPIjndGFgaooZbD+dA+czTYNqj4vRqdu?=
 =?us-ascii?Q?hgOhpM2eMrnFHcwJipa44wSddV8NwZkR8xPf8jex4tlLyxFs/isAruendb0L?=
 =?us-ascii?Q?AyB8m6n6ozqX56FhvaozH//9iDh14ypt3hH1+shSRVMYfDCTWs0cjtZdyRRt?=
 =?us-ascii?Q?oWIqplH7nQKPCOSgsY4cRm6IGl029A6aP0ZoCHeAZA8deX+sVquz+eY47ieb?=
 =?us-ascii?Q?cjG4eKUceD6V2P1iSW8jw0jc2l/T6ZSVDxrQyMYQRmmlPKp9+CgNa3bGsybW?=
 =?us-ascii?Q?xqSDoKZQlUVEZ9yQ5GiJXrSqj3gdzVvUDLY7XAOOI9norBKwJ+/DQ7o8KvB1?=
 =?us-ascii?Q?P4pMBrkJpAQ1F7No0LPipwtg0hlQqeFzPCJBPHzLixLfqUM8r3Wo0jEy90GB?=
 =?us-ascii?Q?suiVe8AzEoCr/If8yh8fReAQvHdJ7Su73O4g/db+0YcRKJ2Kb6lPd1hc3soi?=
 =?us-ascii?Q?XorgKyByS6rO0uzd7nxMV2TBEGkUOMGfYKocgjNGKUnlihJz6OYbe2hBnQdA?=
 =?us-ascii?Q?q+bzRMchtQueR4ApSYgiYlYCfi1SzkZ1nDHPtRCEaN/R82nvzzA7VFhp3GMi?=
 =?us-ascii?Q?XJe94xPfHweZgIKUJvPPai/o8U9h+1RjKbJdsugQ+BJ0o5aq0ItDLEIaJuUG?=
 =?us-ascii?Q?g7c2BXGjurxzQExabahXtBp+v5d5J2IQfcdLO8JHsM/izmC+88Zb7IM7DkEc?=
 =?us-ascii?Q?w2/CgGWomsnc8zLl/JxlkIpHnQJC8hfvJ0b9hHy9dPJ+rD9VYpDkaajZIZHy?=
 =?us-ascii?Q?EOvv+qI2bZu/dk9CO7VwYiP4h2p3E9tRcNNTrlzv/smJMI5W7cVQeJ1bGAC1?=
 =?us-ascii?Q?YpIjMpze/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe6801-0593-47cc-48ad-08de64ab2768
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 11:38:59.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xxZb03sRrguhDe1RCCce3p70+LjOlLF8b8lj7SI4hyAod44X8+xs0swb+yZ+P0JtYDsFk8Vdqyd5q9yfO5dnd2L///h1K9+Ta4VcmJM73U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E797CF1F90
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej
> Jagielski
> Sent: Wednesday, December 10, 2025 12:27
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g;
> stable@vger.kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ixgbevf: fix link setup iss=
ue
>=20
> It may happen that VF spawned for E610 adapter has problem with setting l=
ink up.
> This happens when ixgbevf supporting mailbox API 1.6 cooperates with PF d=
river
> which doesn't support this version of API, and hence doesn't support new
> approach for getting PF link data.
>=20
> In that case VF asks PF to provide link data but as PF doesn't support it=
, returns -
> EOPNOTSUPP what leads to early bail from link configuration sequence.
>=20
> Avoid such situation by using legacy VFLINKS approach whenever negotiated=
 API
> version is less than 1.6.
>=20
> To reproduce the issue just create VF and set its link up - adapter must =
be any
> from the E610 family, ixgbevf must support API 1.6 or higher while ixgbev=
f must
> not.
>=20
> Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devic=
es")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend the commit msg (Paul)
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c
> b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index 29c5ce967938..8af88f615776 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -846,7 +846,8 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw
> *hw,
>  	if (!mac->get_link_status)
>  		goto out;
>=20
> -	if (hw->mac.type =3D=3D ixgbe_mac_e610_vf) {
> +	if (hw->mac.type =3D=3D ixgbe_mac_e610_vf &&
> +	    hw->api_version >=3D ixgbe_mbox_api_16) {
>  		ret_val =3D ixgbevf_get_pf_link_state(hw, speed, link_up);
>  		if (ret_val)
>  			goto out;
> --
> 2.31.1

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


