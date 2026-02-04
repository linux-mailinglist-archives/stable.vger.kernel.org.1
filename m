Return-Path: <stable+bounces-213946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF29Fvtkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD4E885F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F7F8312E84F
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA042317B;
	Wed,  4 Feb 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdwNnGop"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F7423176
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218041; cv=fail; b=k9ghzKhP7w7ggkDVPxUPYyFVOOp1j+E1Po1JAa+a4F49UJT1xmAzpqiI/lvmOZPtIEkpwKKUf9skgtCAJUqToB6YMKB/fGb/7W4JPJMB63qQqVCmvYJAfe4uZ5xfp3gawE2t6xZanNJAqXHRhJ9Un3gGMZDxnuI5KXQUxhplD7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218041; c=relaxed/simple;
	bh=QZeqnEVrjhSH4f3Ncs4SLZWF5+MkG+cRW8CHzMG6RRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EkH2xQVLtKfgksH1LBIwS97cIzfd7AeveWm9lD8kwxm9bNCA+/M3k0vm0p29Jpa5UVGUQMVf9VTx8/3nHWcn+9cXQ8ltecRYt/RR9s+5m91wVBNWK2QC0np9kE89eelM301LJkiDFH1oSrQS+5UeVx9y2MTuMfPDjGlZU3NDrew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdwNnGop; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770218041; x=1801754041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QZeqnEVrjhSH4f3Ncs4SLZWF5+MkG+cRW8CHzMG6RRA=;
  b=fdwNnGopXhtR2O8hfWc7xTZ6sy0NdgS4esr6cI1SI2GFkDBzjtYdKdnV
   VGPPWcmGjrixNQoI3ZzYHNw3vuoG+R4TdV7dH8TS9SFZ4Woi1hn46Vn4v
   wRfeSLT4jTMunZncxyhsTR3sbvlrWCajPv8TMXXA1trb7Jjkxp9QfTmv4
   h46zzcvsLXBbfWmmK5Wy+bdBh1xYGFGBQMNN3fv01bF4NjDITCyNkfQM1
   syKdrtYhOEXLWhkDRj3LrZSgv9HWQAJVews4ECwPR2QWygnm4e2vAxHbE
   ctR1P40BqyajIGvHatUih9fDff5q2ndg3l6yyB3tRqm5mtA/C1t6J+WVb
   A==;
X-CSE-ConnectionGUID: C12HKPT9Rb6ZtDjjHPudEw==
X-CSE-MsgGUID: EMjkmKiSTyakUYk7mFAUOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82519684"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82519684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:14:01 -0800
X-CSE-ConnectionGUID: GBNZBLjKRla/GKbDI6CRkg==
X-CSE-MsgGUID: b5GZEi+vTeWWhc+AVbR1yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="233114476"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:13:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 07:13:57 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 07:13:57 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 07:13:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIZ6WCOSrCrXXZJ039YSy5gtq9i25dFelz3XATXSkg/UWGj+8Jshd+c2lvBkEsS/LjZdAILdYPhzWO/GOARask9Zusqv2gL/J68gNCTSyG8Yx1mDK9Psalf4aL3Ir+YVTH4iU7mBu02xnEJTEq3RanXpQZspEwofTBuckcyrz6Q8Lx2l6l68Vv1kzzTTq1EY8a2amloHmfA3WCYsJB8rreHmVxjkWpvPJOJMWeBqlVwaARyDb0fmetJ4i2q31XBSKgGMIVbagJ6gpV0Q8kw8md6iT5yYiiqy7K64ecOtV0PDkLr/SCzstW9kgTUJKN8toiuL+Xn9HF+KV4wrAV5z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZeqnEVrjhSH4f3Ncs4SLZWF5+MkG+cRW8CHzMG6RRA=;
 b=MDIzYR0vaPFNqw7lYJ4FRhTDbl/+wqd3SPLzYMJMiicVrufBI1KayfN3kyqK7kAQ1uyMJO9v45TZ8p2TGfjuAnU55udu8e3PyK0POIE+TjuV9b3krpXqMzx6YqAoURafxY38IRAdrqP7795LLe260yVruynHhv3N7HPB9WZBxUdG2Z98Lu4IfbN3nUj+oBrfqyfpcYJgfo3EMQGhFNYCzfmtEPEBnuh24GLaBbINJwsEsViBZZ5YpZ5bYH0LWqnQZKR/e0Add+BLKFqL8VjwQCXpblL59DM0wXImancn+rLiKo6aGiLQPT8A9taXeacSt7tpZp2SoLtu7HZ36L8Wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:13:54 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 15:13:54 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Yao,
 Jia" <jia.yao@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Auld, Matthew" <matthew.auld@intel.com>, "Mathew,
 Alwin" <alwin.mathew@intel.com>, "Mrozek, Michal" <michal.mrozek@intel.com>
Subject: Re: [PATCH v3] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Topic: [PATCH v3] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Index: AQHckjTxZJLlu9nJPU2MiYXMDen5tLVyrWWA
Date: Wed, 4 Feb 2026 15:13:54 +0000
Message-ID: <22a004c2455f8d5ab3995ed55605475a6a0acf3a.camel@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
	 <20260130220750.573838-1-jia.yao@intel.com>
In-Reply-To: <20260130220750.573838-1-jia.yao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|PH7PR11MB6908:EE_
x-ms-office365-filtering-correlation-id: 78b47f22-81e5-4493-e0ea-08de640002c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RFRkbmk3ZVZsVVVHY3FxcS9BSXh5NW1tSGluQS9Cb2tIVndGNUVKZVRQTkk4?=
 =?utf-8?B?ZlQvK3hVZ0dHN0lvQlhkVGRvZnJEYjE2QllSelg3VHExdWhWYlduNzJuakdU?=
 =?utf-8?B?cmRQZi9hSkt3RGNxR3M2UlhzUXFXOXhuZ3dwRkNRTGJneG1DM3JxMHl0ci9q?=
 =?utf-8?B?ZXlLOFZqTnpBRXd3Z2tFQjBBSmlJdFhwWjJvTUN2Tk1ERXRxRWNJVE84S0Jp?=
 =?utf-8?B?ZFBQNUlUSVd1VUNGRnY0THBxdVp6cEhQVDZnU2FETnNZS0g3Q0tYWWZ2WWcw?=
 =?utf-8?B?emxMeXdlOEk3eDBCcVZNTzZPWFJIazMwNkxaUFJ5SEU3aTVmWG1WczZXc2Ew?=
 =?utf-8?B?Z2NIQWFqSTIxY09jM0NoOHNqQkRtakxPdzlSSkY0YmxoeUYvVmtUK0ZjSHVw?=
 =?utf-8?B?MW1PUFF2MTFyaVNmZE51VmZpM0h0bEpxbEFMUWphVHJCSm1KR2Z4Y243MHhO?=
 =?utf-8?B?ZEdGRE1DeEVVVTZlNEZzUkRyekxkSENYSVZicUU5aUdGQjBhM29JR0JaLzZO?=
 =?utf-8?B?TG9aaFNXc1U1b2VTYVBmbDV2c3FwMWVac1N3MS8vSGQwTFdUS0hNbHF2aG1K?=
 =?utf-8?B?TUZ3MTFPQnhKbWkrU3ZsSUFBREJldUtHZy93emxsTzJFK3NDQ0NiYUl1b2Jr?=
 =?utf-8?B?dHBibXAyQjJrdHRKQTlCSVlFbVFESmhFWElEM2xmNGlYU3dLOU1jSVBpUHd3?=
 =?utf-8?B?QkVmR1BtYmk3MTNFMTZpbmpMVkJWL3dxZ2UwVDVoK3lEWjAyVnZmN202Tk5M?=
 =?utf-8?B?em1jTzhjTWd6RzVHaUF3ZTArNEJKRkc5bXMvZmNSa3haVGp0Z2QyNGtGd0FN?=
 =?utf-8?B?OGFKamJFWlVPclpKakFsQi85V0EwSEt0eTJ5NGlJYWw4OVNDZFRKMUs5dTlq?=
 =?utf-8?B?T3AyTFYzdVpJWDJxOHBWajA5MGxyZVlLUjFoSVo4Mmh6Sm9OaXRnU09Pclcx?=
 =?utf-8?B?NkNxQm1NcWpSeVpTWmlpei9TMlJwUmZwRTAzcTJtVVpLeWI5RUc4RlZYZVVK?=
 =?utf-8?B?SXpxVXl5cExhZ3pGWFBnU01KdUEwZWVWVTNJK05lUlViQjQwODJobTcrQlNG?=
 =?utf-8?B?NkRWQ0VWUHUyR2V0bjRsaU5HRHYxWVEvZWtHVFJPaEN4SDBiaVBCTkxNZER3?=
 =?utf-8?B?Q3ZUTWhON3J4L2U3TCs2anVIYjY3eGVMNHZqaldYN0lxdk9KVHVzdFNWSW9F?=
 =?utf-8?B?OWJBTnhIS1NaeXJjRHpkUEtGN3cyc2lEZTNmQmxTZStZUFYyUWRsWUt0eUh5?=
 =?utf-8?B?K3BDVkRTS3JOR0hjZTg2dDBkVVBhSW1EQ1Z2aHhadVFmV202YyswMmxEZ1hh?=
 =?utf-8?B?Z01HWG9oVzJOT25Ua2ZLKzhWNkhNdXRFRXYyeGpLZFV1Rm5iaGV2OTY0c0pP?=
 =?utf-8?B?b0VwM2plcTBIWmJoV1dVYTZCcFBTQ0E3YTNKZHdzWVE4enNxbEVkc1c1VUVX?=
 =?utf-8?B?eTZGY1lqdW42L1B2Ri9NeXUvREc0TzQ1TUdaU01mTFdnaUVtazlRWDBOVmI5?=
 =?utf-8?B?ZnpPTjZmWUZKckpyamxXZ2tQcHZlN1U4eWJyNnVjU1djQWVsa3V6VEdOVGJi?=
 =?utf-8?B?eHRxa1ZMcHM2ZXFockh3Z09VcUhCVFFvNDRvdzg5RG5jTTRRZHUwNkI4RkM4?=
 =?utf-8?B?V3NaeW15RVlpakdJN1cvN1QrQTFmeGlmMXRHVmNQb1V6QTd5WE92b3JETy9B?=
 =?utf-8?B?TlBpN1J6c3IvdXAxS0VGTGZuOVo1aEhPdmRKYjBiM2J1YlNVNEpibHhQbHl6?=
 =?utf-8?B?YVhucFpvT0FnQnFSeksxNmNmM2FpS21KSUx3cUVOZUZDZWtjcHZ2b3g3b1JX?=
 =?utf-8?B?TThYSDc3M1BnUS9Fb0dMaTgrb2dVUmNWQ0RLZjVyaFZKTGZXRWkwSmFvL2sr?=
 =?utf-8?B?RlhtN2pweWl0NEJ3VFZFNW9RRDczM21wTmtPMVF2czZJcWREUXRraHVIbUFy?=
 =?utf-8?B?cVpWWW4zZ2RrYytXK3ZJSVNFTFYrQTVuSW8zT29DQXdtTWFUSWplU3VINkhJ?=
 =?utf-8?B?cS9IN1ByTkZEcGxvTGdaLzVZTVRwU2lEcS8wNWlpVW5iUTJZa0xBNXYxcmVL?=
 =?utf-8?B?N2hnQ2lWa1hvTCtqWWkzdmV2eFFMdU5mY3hOWmNQYStHZkhmT0EvOVhiZkpZ?=
 =?utf-8?B?dnhtTlJiTGlVVytYTWt2eVY0MjJzS01Wd1BuT3dGS0ZpR0JITWlZNmVsLzgw?=
 =?utf-8?Q?3g7lm/IJ0CvVSkHV+FsIRk8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OS9lS29ERGFQUFNHT3g5OXZ5VDZVS1psRGo1Wno2cysrZUJXTkIvL0F4ekZy?=
 =?utf-8?B?dEJSSGdEZjRmYnJrVFZXeVB1ZHlxN3dDZTF2YXUzOEJXT3AxUTNDQzEvcDkr?=
 =?utf-8?B?dXNtYjVuTDhLOG0ydGNMSUlPZHZjd2g0NDJ5WkFCZzZSMk9taEkraFBSR1Vk?=
 =?utf-8?B?VVlyOE9qbDZYenF0aE9rTVhRKysySElMYVRPZVZpZHZ1bWxGby93Y1ZjNENF?=
 =?utf-8?B?d2RhRWZrc3RRWjg3N0lsYTRYZFZITmVmQkZ0dlNhS1BTRHdsSjJtVmsxdnJy?=
 =?utf-8?B?c2FuNU1LNTJNeGJFREZGTldwZHlWYUNvSWdsT1lQRmpxSXladFpSSXlsRVFC?=
 =?utf-8?B?WGtyUE5aRzFNdjV4b3JFbmhjc2FUVGJsM0xlVkp0bU5hU01OUzJhb0RhMWtw?=
 =?utf-8?B?SS9RUFBUV0hneko0RitKQ01WOWdGRUtwWklWQmRvSEJLZkhhdXVmRFFVSktn?=
 =?utf-8?B?RnRYVjl6MVhXT1RVdzA3YmpxVEw4TmVrd0hhNUlBWlAzR2NNVFVWQ0EvQ1Fl?=
 =?utf-8?B?cEFFemM3aTY2RDg1TGdWYmFUYmJiQnBvUHBHSjA2WVdqTkR0a2JZNlg4TWJh?=
 =?utf-8?B?M0YrdlJHcmdnS05pelRlYlZBUjNMMUpHVWlJMTMwdkJLbEN0U1YrMjNEVWVX?=
 =?utf-8?B?Z3NMSWNFRlJybUZsczNBKzN6VmtjNlhzTzhjaHFqbE5tYkZjenJqYXJ0ZWZK?=
 =?utf-8?B?U3IrN3M2a3FGeC9OSVNMU1hIQUJONWNvdkt1RFlmQTgyRUFOcG9BamRST3pF?=
 =?utf-8?B?dGRwd1J0a0ZmYXd0YlNPeFM5VmNYNkJqSWlOci93WWs0b3J4bTJHWHp5WlNH?=
 =?utf-8?B?cVBoMVBwRlFSVU9hM0xCTzRKZlFmV0ZhU21lWmFmMTE1NG56WFdUeTZVWEl3?=
 =?utf-8?B?eTNTakM2bThxMk5OWjVUR3prUmlNRUYrQm1HTGU3cGpGWS9vYTA2bE5mZFhy?=
 =?utf-8?B?N3RlT3JGS01obDlKVXJEVGlHbTROM1UwOUxrdVJ5U0IwcWhuNE9jb3Z2THU5?=
 =?utf-8?B?azgySklzWm5HcllpUzR0VkJtZjhDYkljeUhBWTk5QWI0TGc1eE12WHNZOGMz?=
 =?utf-8?B?OG1lakpVR3pUalAyV2JGNFhHOVJVQzIxT3lRSTEwcEJIeVZxQmcvdHVwTzQ3?=
 =?utf-8?B?ZEg5OUxmK3U2eTBTR3JIejJrY0p6MmtRNVlQeDNyOTZWcG9ieUdDWXBqakxt?=
 =?utf-8?B?WCtVVjYxQWYrbGhJR3VJN3RTRzZ6V0M4a2R2dEh2eEMvS1ZIVlkvTC9wSFZ1?=
 =?utf-8?B?Y0U4OEUzREswRkVhaThlWmtPRm9LZHR0ZWVzWW1XOFFGaVBZcHNFRlFTSXh1?=
 =?utf-8?B?TjJLRFRsRWdZazhQeDJ3NjNhVmVNejhvMHVhZTRRdi91S3B4YXYzdDlURndD?=
 =?utf-8?B?RllYRWh2cXJWeDc0T1FoYzF6K0c3QUk1MU1NdHNqOHExd0ZRUld6dkJLK0h5?=
 =?utf-8?B?ZWljT3F3QnZ3TjdwRDN2cjVNVTVlTEJLUk5YY2hIQklMZHFEZ3UrWldGRExZ?=
 =?utf-8?B?OXpDaGNoYVlGdk9uSEx0RkdVTmJzazh5SDJZT1NGMVNYaEdlVDJPdzJ5UXpn?=
 =?utf-8?B?Nm8zMnF2TGF5d2QwZms5Zm9RalNSMnVLdDE1d0RZU2RSbkxuWmlKTCtZYnA3?=
 =?utf-8?B?ZVFmdjU0MTFIeU1ZcmEvcTdUTHZxd05CVXVVSStRbmV2UGQ0aGcyVWRaazB1?=
 =?utf-8?B?emIxZUtPd3hMWG80RWNBcVc4VHRFVWh3YVZla05nK3VKbHRLenBTOGtZZzNt?=
 =?utf-8?B?RUVLb2R3RFZtMVd2S3hhK2h1czN5bTlzTkx3NVNRZ3B4S2hCUGJ5QjR3WHhs?=
 =?utf-8?B?TThaOWlhSE9VN2RHMzNuSE9qbDRKRzRmeUJmS0tKS0VvWkYwQU5QSER2NXZQ?=
 =?utf-8?B?V3pSTmJZWDVPdEpGWkpxT25sbEw2cWIxWmlZRlZUdUxNNHpJdTh5cnd2WHRn?=
 =?utf-8?B?QmIySlU1bkQzUFlvN0FQUXVsS094L3lTODNqOGVyY1JBMDJmOGxjV2h2cEhw?=
 =?utf-8?B?bUZkRFNnVEF1MW5mZnJHRHJkeEQ0ekx4SEN4d0RucEZnMFA2ZmhIK3NGMkFT?=
 =?utf-8?B?TGpWTSsrRjI0NFIzYUVkZER3MzFXYkJIaUprUDA0TUJWM093OFpQN3R3anZK?=
 =?utf-8?B?MDBCMWRBSVZXMEFXTmFrNks0T3pKTEhabDNyQlZoZzZ1enppUmtlUXV4UEhx?=
 =?utf-8?B?WmQwOFY1OS91MlpxMlljdkZqVERmUDFHR21ybGZJMG8yMytIazNMNC85RitX?=
 =?utf-8?B?eUI2MUFwZmxLVURsZW1kM2p0MzNrNGszdEZHeHBsZ3FiZEN2Ym5GOHRpaUZQ?=
 =?utf-8?B?YlJCN3lMcmpHdDRCQ3ppR3NxbSsxeTJ5TDR2VmZvdkttQkZTSkRtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E162CADDDC42D34899310F84C2B8FF48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b47f22-81e5-4493-e0ea-08de640002c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 15:13:54.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UIh+EUW/t1iQulaLq5aIGlbL7vu3uGlGwWdDmH5sLOCdI12EpvNB5LixcH8thXs8TL0IzWp2GDyhvqSKO2g4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jose.souza@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B0AD4E885F
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTMwIGF0IDIyOjA3ICswMDAwLCBKaWEgWWFvIHdyb3RlOg0KPiBBZGQg
dmFsaWRhdGlvbiBpbiB4ZV92bV9tYWR2aXNlX2lvY3RsKCkgdG8gcmVqZWN0IFBBVCBpbmRpY2Vz
IHdpdGgNCj4gWEVfQ09IX05PTkUgY29oZXJlbmN5IG1vZGUgd2hlbiBhcHBsaWVkIHRvIENQVSBj
YWNoZWQgbWVtb3J5Lg0KPiANCj4gVXNpbmcgY29oX25vbmUgd2l0aCBDUFUgY2FjaGVkIGJ1ZmZl
cnMgaXMgYSBzZWN1cml0eSBpc3N1ZS4gV2hlbiB0aGUNCj4ga2VybmVsIGNsZWFycyBwYWdlcyBi
ZWZvcmUgcmVhbGxvY2F0aW9uLCB0aGUgY2xlYXIgb3BlcmF0aW9uIHN0YXlzIGluDQo+IENQVSBj
YWNoZSAoZGlydHkpLiBHUFUgd2l0aCBjb2hfbm9uZSBjYW4gYnlwYXNzIENQVSBjYWNoZXMgYW5k
IHJlYWQNCj4gc3RhbGUgc2Vuc2l0aXZlIGRhdGEgZGlyZWN0bHkgZnJvbSBEUkFNLCBwb3RlbnRp
YWxseSBsZWFraW5nIGRhdGENCj4gZnJvbQ0KPiBwcmV2aW91c2x5IGZyZWVkIHBhZ2VzIG9mIG90
aGVyIHByb2Nlc3Nlcy4NCj4gDQo+IFRoaXMgYWxpZ25zIHdpdGggdGhlIGV4aXN0aW5nIHZhbGlk
YXRpb24gaW4gdm1fYmluZCBwYXRoDQo+ICh4ZV92bV9iaW5kX2lvY3RsX3ZhbGlkYXRlX2JvKS4N
Cj4gDQo+IHYyKE1hdHRoZXcgYnJvc3QpDQo+IC0gQWRkIGZpeGVzDQo+IC0gTW92ZSBvbmUgZGVi
dWcgcHJpbnQgdG8gYmV0dGVyIHBsYWNlDQo+IA0KPiB2MyhNYXR0aGV3IEF1bGQpDQo+IC0gU2hv
dWxkIGJlIGRybS94ZS91YXBpDQo+IC0gTW9yZSBDYw0KPiANCj4gRml4ZXM6IGFkYTc0ODZjNTY2
OCAoImRybS94ZTogSW1wbGVtZW50IG1hZHZpc2UgaW9jdGwgZm9yIHhlIikNCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmfCoCMgdjYuMTgNCj4gQ2M6IE1hdGhldyBBbHdpbiA8YWx3aW4ubWF0
aGV3QGludGVsLmNvbT4NCj4gQ2M6IE1pY2hhbCBNcm96ZWsgPG1pY2hhbC5tcm96ZWtAaW50ZWwu
Y29tPg0KPiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+IENj
OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQoNCk1lc2EgZG9uJ3QgdXNl
IG1hZHZpc2UgYnV0IEFQSSBidXQgdGhlIHJlc3RyaWN0aW9uIG1ha2VzIHNlbnNlLCB0aGUgQVBJ
DQpjaGFuZ2VzIGlzDQoNCkFja2VkLWJ5OiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNv
dXphQGludGVsLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWEgWWFvIDxqaWEueWFvQGludGVs
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtX21hZHZpc2UuYyB8IDQ3
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0
NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtX21hZHZpc2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bV9tYWR2aXNlLmMNCj4g
aW5kZXggYWRkOWE2Y2EyMzkwLi41MGI4MmU4MjFkYTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS94ZS94ZV92bV9tYWR2aXNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtX21hZHZpc2UuYw0KPiBAQCAtMzUyLDYgKzM1Miw0NCBAQCBzdGF0aWMgdm9pZCB4ZV9tYWR2
aXNlX2RldGFpbHNfZmluaShzdHJ1Y3QNCj4geGVfbWFkdmlzZV9kZXRhaWxzICpkZXRhaWxzKQ0K
PiDCoAlkcm1fcGFnZW1hcF9wdXQoZGV0YWlscy0+ZHBhZ2VtYXApOw0KPiDCoH0NCj4gwqANCj4g
K3N0YXRpYyBib29sIGNoZWNrX3BhdF9hcmdzX2FyZV9zYW5lKHN0cnVjdCB4ZV9kZXZpY2UgKnhl
LA0KPiArCQkJCcKgwqDCoCBzdHJ1Y3QgeGVfdm1hc19pbl9tYWR2aXNlX3JhbmdlDQo+ICptYWR2
aXNlX3JhbmdlLA0KPiArCQkJCcKgwqDCoCB1MTYgcGF0X2luZGV4KQ0KPiArew0KPiArCXUxNiBj
b2hfbW9kZSA9IHhlX3BhdF9pbmRleF9nZXRfY29oX21vZGUoeGUsIHBhdF9pbmRleCk7DQo+ICsJ
aW50IGk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFVzaW5nIGNvaF9ub25lIHdpdGggQ1BVIGNhY2hl
ZCBidWZmZXJzIGlzIG5vdCBhbGxvd2VkLg0KPiArCSAqIE90aGVyd2lzZSBDUFUgcGFnZSBjbGVh
cmluZyBjYW4gYmUgYnlwYXNzZWQsIHdoaWNoIGlzIGENCj4gKwkgKiBzZWN1cml0eSBpc3N1ZS4g
R1BVIGNhbiBkaXJlY3RseSBhY2Nlc3Mgc3lzdGVtIG1lbW9yeSBhbmQNCj4gKwkgKiBieXBhc3Mg
Q1BVIGNhY2hlcywgcG90ZW50aWFsbHkgcmVhZGluZyBzdGFsZSBzZW5zaXRpdmUNCj4gZGF0YQ0K
PiArCSAqIGZyb20gcHJldmlvdXNseSBmcmVlZCBwYWdlcy4NCj4gKwkgKi8NCj4gKwlpZiAoY29o
X21vZGUgIT0gWEVfQ09IX05PTkUpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJZm9yIChp
ID0gMDsgaSA8IG1hZHZpc2VfcmFuZ2UtPm51bV92bWFzOyBpKyspIHsNCj4gKwkJc3RydWN0IHhl
X3ZtYSAqdm1hID0gbWFkdmlzZV9yYW5nZS0+dm1hc1tpXTsNCj4gKwkJc3RydWN0IHhlX2JvICpi
byA9IHhlX3ZtYV9ibyh2bWEpOw0KPiArDQo+ICsJCWlmIChibykgew0KPiArCQkJLyogQk8gd2l0
aCBXQiBjYWNoaW5nICsgQ09IX05PTkUgaXMgbm90DQo+IGFsbG93ZWQgKi8NCj4gKwkJCWlmIChY
RV9JT0NUTF9EQkcoeGUsIGJvLT5jcHVfY2FjaGluZyA9PQ0KPiBEUk1fWEVfR0VNX0NQVV9DQUNI
SU5HX1dCKSkNCj4gKwkJCQlyZXR1cm4gZmFsc2U7DQo+ICsJCQkvKiBJbXBvcnRlZCBkbWEtYnVm
IHdpdGhvdXQgY2FjaGluZyBpbmZvLA0KPiBhc3N1bWUgY2FjaGVkICovDQo+ICsJCQlpZiAoWEVf
SU9DVExfREJHKHhlLCAhYm8tPmNwdV9jYWNoaW5nKSkNCj4gKwkJCQlyZXR1cm4gZmFsc2U7DQo+
ICsJCX0gZWxzZSBpZiAoWEVfSU9DVExfREJHKHhlLA0KPiB4ZV92bWFfaXNfY3B1X2FkZHJfbWly
cm9yKHZtYSkpIHx8DQo+ICsJCQnCoMKgIHhlX3ZtYV9pc191c2VycHRyKHZtYSkpIHsNCj4gKwkJ
CS8qIFN5c3RlbSBtZW1vcnkgKHVzZXJwdHIvU1ZNKSBpcyBhbHdheXMgQ1BVDQo+IGNhY2hlZCAq
Lw0KPiArCQkJcmV0dXJuIGZhbHNlOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHRy
dWU7DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgYm9vbCBjaGVja19ib19hcmdzX2FyZV9zYW5lKHN0
cnVjdCB4ZV92bSAqdm0sIHN0cnVjdCB4ZV92bWENCj4gKip2bWFzLA0KPiDCoAkJCQnCoMKgIGlu
dCBudW1fdm1hcywgdTMyIGF0b21pY192YWwpDQo+IMKgew0KPiBAQCAtNDQyLDYgKzQ4MCwxNCBA
QCBpbnQgeGVfdm1fbWFkdmlzZV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiB2b2lk
ICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbA0KPiDCoAlpZiAoZXJyIHx8ICFtYWR2aXNlX3Jh
bmdlLm51bV92bWFzKQ0KPiDCoAkJZ290byBtYWR2X2Zpbmk7DQo+IMKgDQo+ICsJaWYgKGFyZ3Mt
PnR5cGUgPT0gRFJNX1hFX01FTV9SQU5HRV9BVFRSX1BBVCkgew0KPiArCQlpZiAoIWNoZWNrX3Bh
dF9hcmdzX2FyZV9zYW5lKHhlLCAmbWFkdmlzZV9yYW5nZSwNCj4gKwkJCQkJwqDCoMKgwqAgYXJn
cy0+cGF0X2luZGV4LnZhbCkpIHsNCj4gKwkJCWVyciA9IC1FSU5WQUw7DQo+ICsJCQlnb3RvIGZy
ZWVfdm1hczsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiDCoAlpZiAobWFkdmlzZV9yYW5nZS5oYXNf
Ym9fdm1hcykgew0KPiDCoAkJaWYgKGFyZ3MtPnR5cGUgPT0gRFJNX1hFX01FTV9SQU5HRV9BVFRS
X0FUT01JQykgew0KPiDCoAkJCWlmICghY2hlY2tfYm9fYXJnc19hcmVfc2FuZSh2bSwNCj4gbWFk
dmlzZV9yYW5nZS52bWFzLA0KPiBAQCAtNDg1LDYgKzUzMSw3IEBAIGludCB4ZV92bV9tYWR2aXNl
X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+IHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1f
ZmlsZSAqZmlsDQo+IMKgZXJyX2Zpbmk6DQo+IMKgCWlmIChtYWR2aXNlX3JhbmdlLmhhc19ib192
bWFzKQ0KPiDCoAkJZHJtX2V4ZWNfZmluaSgmZXhlYyk7DQo+ICtmcmVlX3ZtYXM6DQo+IMKgCWtm
cmVlKG1hZHZpc2VfcmFuZ2Uudm1hcyk7DQo+IMKgCW1hZHZpc2VfcmFuZ2Uudm1hcyA9IE5VTEw7
DQo+IMKgbWFkdl9maW5pOg0K

