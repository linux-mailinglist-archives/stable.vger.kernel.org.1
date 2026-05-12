Return-Path: <stable+bounces-246695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHJYFaOtA2oO8wEAu9opvQ
	(envelope-from <stable+bounces-246695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDC52B08E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BCED3002764
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A575A396D1A;
	Tue, 12 May 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzg2LVtl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4434FF74;
	Tue, 12 May 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625844; cv=fail; b=cEF5cKgi0nQBZ1wgaVOG6cP/1bCzYSShysC2Pc/PyNJtoaeJBBgQGL+5fe8NCIW0+IaY788u94kDsun519UUmIuWh0RnPcwhtTJmAe/CeC7PyQKGEDlivpG9V+VZogCysY87Nw+3oeVSn9eUm3pcLenPaavDMQcGt8kAus2lNfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625844; c=relaxed/simple;
	bh=8T8TTa1T1y1hSap3mXN+eDq6GzFeJzjViu2kcimrHDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A31djt/QkPLW5dBwJKK23fHDXzTGA4gEdeWuCk2Ho8y9sjj2K/h4VBge4pRw/Hn6oTzllyKIxe9Uvle9r6qPSHfJSzfETdCJ1eISXPEj6ZJncpuTQMy3rf4+egFK/8IOPQDJwqfel62IbFgFFT1GaA471aFUKmdJFCOFh2w5da8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzg2LVtl; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778625842; x=1810161842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8T8TTa1T1y1hSap3mXN+eDq6GzFeJzjViu2kcimrHDY=;
  b=nzg2LVtlUnCrk9i5VsFJtsADZ/3UT3tcOFnlh+VYjvgTJB4ik1N1IsqI
   RMddFz77r0BPAOkGmxldXAwMI6ZC11Npw21roGw1//XgM10OwV4k3exXK
   z/oKJjE9bL0m0KDr30JVMFBgvHYt3VM06zyogu5YWl2I7hHiW+NUc5wDz
   MRsuCnzRjzLjW0u66pa7o8P4AJhc68sUXPB2tPf3afLZ8kdn62AW5uE0P
   AYC/Apu0b9SfyrwYfnHiQ8XbVNZ7yNf0hI54aeEXDgqNmColAZOm1tmL9
   jlncoSUOzS2Ad/FNqMFUey5jUdi+2GwhRKvm9Allg898W4w6CgyqXtQ1l
   g==;
X-CSE-ConnectionGUID: IlLVAnuuToSR2AoJVf5Dyg==
X-CSE-MsgGUID: rN9prAEyT8GgxnTXq1IhmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79566907"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79566907"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 15:44:01 -0700
X-CSE-ConnectionGUID: HcRb62MUR+SfjnBVrnEZ9Q==
X-CSE-MsgGUID: WYNrvWEcTAyCAQGv6LlQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237828055"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 15:44:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 15:44:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 15:44:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 15:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmTcgx4GCHiuVWn4qotRWUZbhOOxE07C2anyg7LSymycWjEE2OUWY+NXJknnU4wLnr/cvM+0mDI0lh3VfC5ng12CDKHx9l/INl0LbqPelwM94j4OtS/biOf4WMBkADGmoax7fJ1RhXtt7J/NGKuZaCqCPjifdsOJimhZlxUIhcPC5DAZky9whUcVwr+g/Wv9OHroZhRLn6wcPt+/AuiReNWNSgDWKktFChoVpNbxClP9N+G3CAKxutA4IR/BBS28b3n7AnhB6h/tbK6GgQB+1hL1spaK3rBm/1SUCdgLOmbImm+JqiZzMn2PtuKHGl8Eb0hTSIrKZrm9WbbaNgiYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T8TTa1T1y1hSap3mXN+eDq6GzFeJzjViu2kcimrHDY=;
 b=Cd170z2imPqEIbE2fiaIv6Szy8DCSnjeHbBnkkIGwzsV2U9ckpO+nuB8DwQ2PJaRyclw+oRBIJ6QXGKEOz+/Thb1i/yFWh7PWi968fkpcYRVRWn8tuKDb9k5VqgdkeUfUAWr6O4TH1DOs8CbPp7SS41bT6wuHDdTVvpEdSNr4spKQeCUzfSV/rjgHdPz2SY4CgqmzY8bTWLsFo4u74ilZ/vI5Kh2NKSiney5XKuBFXOAAI50LMoXv3LzZYimRhWm7qC+eLBK+yjPM+SIE8L1q2BtF923tKWJuALai6LqfW2SDd+Bh9ed6JUnM3L7gZ6tEu5PerkPqx+9so7pVFgEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 22:43:49 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 22:43:49 +0000
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
Thread-Index: AQHc4leZtVFzGNxN3EuH83/xEfDKtLYK7ZEAgAAHRACAAALHAIAAA2yAgAAB4AA=
Date: Tue, 12 May 2026 22:43:49 +0000
Message-ID: <6e4422c1c6d5d0e6415b02e6cd2633c6e34030ff.camel@intel.com>
References: <20260512213719.20974-1-clopez@suse.de>
	 <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
	 <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
	 <43a913a1b4721c752443416a685631478bee2f10.camel@intel.com>
	 <d76284f1-79e2-4e7b-94e7-252ff3ee9e5e@intel.com>
In-Reply-To: <d76284f1-79e2-4e7b-94e7-252ff3ee9e5e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|IA1PR11MB7387:EE_
x-ms-office365-filtering-correlation-id: a98fc2f8-1c35-48e5-8aa8-08deb077ef5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|11063799003|22082099003|56012099003|18002099003|3023799003;
x-microsoft-antispam-message-info: L873d5RQnckhJsRSQmVXFH/BZc0YKJS8hk+odZOhfYygtLM8lWXgztmrpeoWu9YZs/RQ6/SlyzWMAH/wyF2XdzuSEcKVOrSwMfiYq5mJY8nYy3q8oeLd7JvYrrOzAbwGtXBea+aqA84eOlPIcpi++yUxyC5a6GCxjrYuUM3UFT3y+/9lNULwrp4QGHDYEzjv9bWv7ctMuCro3nNw1a9ClV16uGJ07uDgQCzf2YmtJ9Z4alwskhTc0Of+uXQf8Q1GIZRx0tZJBxdYyyX6wz0t1iJJRL9WD3yHktaNCndjgZdBmpLDD5ifjmS5OkuglFj48Uu0agZEu8NbG6whq4VVgfkBG2V/2LCglrgRAY47vogy8aHyljEPb2GJ4809eeIdv1OHl2HH07WnVuEO6GTBl2LhtNzNHFnF+RaqKKIWyMeDuKaLoMPedsS7AdhBBqK3zyMUmMR1ygLfBsn+iaoQ7VjmpqR3Y2ClpVlmX8CnnKzGg9XU0paw0OL72dGo+Q2A5h2ROM+1Ey9czWNmtPE84f+i1gKA5e3PTQYV6EbAbwIrpVsJkE0RxzTSrS1lnpQIQ3xM68yMB//oAaw3w7+/CLh0pLqf5F2hHo0V1dw3WCZ0htx9uUOMe+xSAAi8/Voz/0q9Qdud+pTfXbpUGWJbyCloihUNiDfR2nxWc+dGf/m3ulLhoiFCa7SgLUwP9tmlvUAgrWeCxeOVqT0IaAO0GvHPInnKo862QBWXjt6WlbR/zlmwmJ59H3Z4BYBJELqr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEtKa2ZGZmFHOUo0MTR5VGczMjdUTUpJelZDN1NWZkdYc3NYUEgzakpHa0xo?=
 =?utf-8?B?dFBYNmc3RXpJMkxhUkRaOUNvVHFhN21DNEl1K21aY01QWXBSY0JlcFA4dVQ1?=
 =?utf-8?B?OFBRM0dxVndPV0FENHFZV21ZMk1IL1NHSExaWGxWc2tOVW5KOCtpVlpjSENJ?=
 =?utf-8?B?QXhhU0ZaaHB2NkJnUXFwUTlMQWtrSE5wN3JnSVJEd0hkc1pyQkNTR2hRUXhE?=
 =?utf-8?B?anBwWVQzMm9UQm9teHA5MWZEaGQ1Wkp5WVJ2dU5FZnJPc2xWMnpyUGdDYmE1?=
 =?utf-8?B?bnIySllKdHJRaENWeENUbjlVN1ZjR2JDNnUvNEdKU2NUTUxPK1QvOW1MT1Bl?=
 =?utf-8?B?Qng2T3YybGNJOXk2S2dJUVdraUZ3Q1hxRVYwWitvNHFGRmZySEpKK010V244?=
 =?utf-8?B?cDZXZU9UWk91UktZS2ZDRjBVV3BLRkR6ZHREeVpuMXE4NUJnencxNVVIV0VV?=
 =?utf-8?B?TERpUG5vRGNSZGtXOXgzUlJ2OUxVUkxBVzZPNjZJcHozcW4rWFpxZWJkMnUr?=
 =?utf-8?B?SWtsc045M0wydG9YNHdEaXF1aXdiL2tDbk1YSUlOejlDU3owamxCczN4Tyt2?=
 =?utf-8?B?a2VJZlB3QlR6TnJCY2hpNWZUdktoWWVaWnAzRTQ3ZE03dWxQUThtVm5aUzRt?=
 =?utf-8?B?aGxIWUxabVZRd05yRHNtRzJTcXBsNHFORFp6dmd6clF0VGt6R0hlVEEwc3BE?=
 =?utf-8?B?cjB3RzFqV0k1Y0p4bytRZG0yMDZ6b1R6WW5OR3JsazA3elh2akh0VEpCMVlr?=
 =?utf-8?B?cjNkeFlQRm1lTUY3SlY1VlZwVUtKNk9PRnQwOThqQUVHRFFoZ1pmZnVYTE42?=
 =?utf-8?B?b2pRNG8rWFZ1QlhjUXpMM3E2L28vczdFMUlXQ0FpZkpjbm1jdU5vNXVEcDVw?=
 =?utf-8?B?NkNKK0VzQk1PV3RKOGJDd1JXaFVCVFZOOUlJZlErOFVaeVo4eE04K3hzNG02?=
 =?utf-8?B?VEJJbGFQbFBCSER5UnoxSWpnMFVEdUpJQVNJd3hyUVdTMm1uWW5XTmFkWG40?=
 =?utf-8?B?dEIvd2x4T2ZPWm41ME1UQVI0ZnpFeTZGd1VjRGVrbXhvNHpFS1NzTFM4emFi?=
 =?utf-8?B?VUREaG0yL0U2L1R4cVRvZ1R4ZThPcG5MbEJTeWU2aVRkMFNJakNjelpRbFIy?=
 =?utf-8?B?eTVZclVjQkxKdW12OU1obWZyQXZ6RXNMeUY4aEZwUEtjZjBPN2dWbG84MnBW?=
 =?utf-8?B?MkFtZ0VLVHh6a0tJR2Y4ajBkbFdheUxHVlZwUy96VHhVamFyeSt5R2hXQ2FB?=
 =?utf-8?B?YlhJM09EbE1HNTRQZkcySHBBTnNJYjloODhKTVlyZ1pPeWtzMEh0b2V5dXpk?=
 =?utf-8?B?a2Ntb3lqKzhlaUVpZHRWdUVoQ3NDSkNXYnhXNGt3a1VzMDI1eXB5NEFmaHFM?=
 =?utf-8?B?N1ZpMU9id29GTWRuOC9FOU9EL09sWjdTdnNoSExES1JSWTdSOERjQU9aVTh6?=
 =?utf-8?B?M0VuYzR0V1BEdkVaWkNYZElBZGJ2ZmxFdVJOYVJrNTkrMkFSL0hjYW9WYzFv?=
 =?utf-8?B?QXpzNndEVTU2UU1kcG9OT1JCTTJLRHhSTXVKaGRDZUwwM3VkNktxaUJiY05y?=
 =?utf-8?B?dlNuR1Y4TXNoNmk2S1hlNXFLUHNPZEQvRHpkTzJCNTBSa1pQOUE0bVdqVnU0?=
 =?utf-8?B?emsvcXhyQ21DU0ZZKzZuenF0aU91ZHJyN3k3enhFUFh6dit0azBYMk1TMUdm?=
 =?utf-8?B?OWJuclpscFR1Q2xVeFBDUS83Rk5ZSVE2K043MWtZY0ZVTW1Wc09XNkg0QU40?=
 =?utf-8?B?Y2RYL2xJTVkyREJjNFBZYmxmbUZ2VHBvSi9VdzBIcUlTQkNtdHg0SDAweUlw?=
 =?utf-8?B?MFVDcTJSUmM5Nm9Denl2bmhzOXZNMm5qajFuTVdCMUpMdFF2Q3F0S1YzRFlx?=
 =?utf-8?B?d3JrUlQwY2NJZlpaOGUxdEF1SmVPQzc4dzZxNEo0NDdjdmRBNDdLQWNaSTJC?=
 =?utf-8?B?VFJTUEZPb1pKRytBN1ZUSDJDQzRhNlpVaktjZTNINVh0Um92amlic21RZ2RG?=
 =?utf-8?B?Z3R4dFVtdlpmSVBBZDR1MUlzS2ZEUmhkb2lmRG0zMVJjVnR3UExMTzI1Y1h0?=
 =?utf-8?B?aVh4Rjk2TUxxNlNBVHRscHFkK1lIUnRhMWx0UmFrV0Z5RWhLOC9GQTZSR1Rp?=
 =?utf-8?B?WVZId0FKK2l1MFFGT2FlQ2VBTUg3MFJIZ3N0anZaWU5XeHFjU1NzbW5VZXdU?=
 =?utf-8?B?ck1EM0FFcDZMV0VPd3RIUVd2emZKb3dQdk1Cam5pSnZUd0wranQyR2xZTU50?=
 =?utf-8?B?S09NTFdvQk9ER0hGUFRrampmZW00S0MrUHlxdFk1UFBmUnlaODVzSjRLN05p?=
 =?utf-8?B?amRsRHg0U3NlMURkVHN6em9MNXRDSXpjM0h5Z05aN1RtYUQvbG4zUy9ZdnVq?=
 =?utf-8?Q?AC4Af4i6fkthvk+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <083AC8398A81CF4E879CA5CABCF25247@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JHS/tN9YcnV9zbjOLsM1AaETmiI5gCuQoDR63YpG+QAC8rKqIWZ2x1ISOr+lOqVGF0qGXql7E56kKfri2s8QAl8A4iNOVFnOdofHTdkVecpDKIFnePLqusIKO8BeJBrKPUUFuGUz4SOOuFnaIVu5Nxz7a5ZLXGrmdgdVyFJqnn7ooLYsFx3sC24dogVxhXFDV03Gp6NmQZQ1yA5XIWIXCQp3wULT1gYJGQeq+LJZGRK3p4TPqb+69oecyeST3foT11yhAkNRLPK/bjkyakGfH1QJ4bKWO2aN4XzUJ8A5DtQIp3CLBlhKHzxcNtL1BvzwJ+ssIN9H1miBDHIqZ6x9CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98fc2f8-1c35-48e5-8aa8-08deb077ef5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 22:43:49.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNXAfqi57wgJB8+9SHifYRCbcgcoPI0imI8MD9yqp+/oEeF+9Yhwu0R2jkDzHmS7ZC92MsL7BHe8+T4AtsBCGk6vUMyIAQvTIzOcvSpNoUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A8CDC52B08E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDE1OjM3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8xMi8yNiAxNToyNCwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gT24gdGhlIG90
aGVyIGhhbmQsIHRoZSAjVkUgaGFuZGxlciBpcyBzdXBwb3NlZCB0byBkbyB0aGUgZW11bGF0aW9u
IG9mIHRoZQ0KPiA+IGluc3RydWN0aW9uLCB3aXRoIHRoZSBoZWxwIG9mIHRoZSBURFZNQ0FMTCwg
c28gbWF5YmUgdGhlIGNvcnJlY3RuZXNzIHNob3VsZCBiZQ0KPiA+IGluIHRoZSBndWVzdC4uLiBI
bW0uLi4NCj4gDQo+IE1heWJlIHdlIHNob3VsZCBqdXN0IGNoYW5nZSB0aGUgR0hDSSBzcGVjLg0K
PiANCj4gV2hhdCBpZiB3ZSBzYWlkOg0KPiANCj4gwqB8IE9wZXJhbmTCoAnCoMKgwqDCoMKgwqAg
fCAuLi4gfA0KPiDCoHwgUjEyIChsb3dlciAzMiBiaXRzKSB8IEVBWCB8DQo+IMKgfCBSMTMgKGxv
d2VyIDMyIGJpdHMpIHwgRUJYIHwNCj4gwqB8IFIxNCAobG93ZXIgMzIgYml0cykgfCBFQ1ggfA0K
PiDCoHwgUjE1IChsb3dlciAzMiBiaXRzKSB8IEVEWCB8DQo+IA0KPiBUaGVuIHNhaWQgdGhlIHVw
cGVyIDMyIGJpdHMgYXJlIHVuZGVmaW5lZC4gVGhlbiB0aGUga2VybmVsICptdXN0KiBtYXNrDQo+
IHRoZW0gdG8gYmUgY29ycmVjdC4gVGhlbiB3ZSBkb24ndCBoYXZlIHRvIGRvIGFueSBjaGVja2lu
ZyBhdCBhbGwgYW5kDQo+IHRoZXJlJ3Mgbm8gYW1iaWd1aXR5IGFib3V0IHdoYXQgdGhlIFZNTSBp
cyBhbGxvd2VkIHRvIGRvIG9yIHdoYXQgY2hhb3MNCj4gaXQgbWlnaHQgY2F1c2UuDQoNCkhtbSwg
bGV0IG1lIGNoZWNrLiBJdCBpbnRlcnNlY3RzIHdpdGggdGhlIG90aGVyIGd1ZXN0cy9ob3N0cywg
YnV0IGhhcmQgdG8gc2VlDQpob3cgdGhlIG90aGVyIG9uZXMgY291bGQgYmUgb3V0IG9mIHNwZWMg
YW5kIG5vdCBiZSBidWdneS4NCg==

