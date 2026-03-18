Return-Path: <stable+bounces-227012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MKmIf12ummTWwIAu9opvQ
	(envelope-from <stable+bounces-227012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:57:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A62B9892
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CAF03053BA5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659613B7B6F;
	Wed, 18 Mar 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv597mDt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F190368273
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827541; cv=fail; b=XUoTyHMNxJW0pr/6S2h+UX2hXuG/phrr5KXTCu0fb3rRxG/8v8DXOx4u2sTrnH4nAyUdsw2KSbKGTMg5Bv1D+4PwCf4tOyaDsFOzTqD6En8qR79HmW9AyhRufQvwxT/gBz3sU9bBpMii1lokbmt/LqxBPXTM/fh1rH7F85g5XPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827541; c=relaxed/simple;
	bh=zYxBIbfkJBWCFPc0u1pCHUXU+jgr/gY5ECU88DR95u4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4BTIzJioNoJTvL9LMeH61Oi1kmb8MvKJ3hLGPGHxL4kZxv6lLm7M7eWOG+rWGB2/rJXhK3pD6tEs47Zhqnj+ueAmZONbU7gWfLvGsJJBktWsbydN4Zl4b3ZAMmr/ATOuchvEVzcxI6e3fZUauUYX1k7PKsBoX6WMPIToUUepMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv597mDt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773827534; x=1805363534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zYxBIbfkJBWCFPc0u1pCHUXU+jgr/gY5ECU88DR95u4=;
  b=Xv597mDtSs+twwO1cjV7ZhE3VFHYQZQ483TVCENYIIKDrC05mbyRdia7
   2hm9cbStn7W/wwNrFaZpz7WqM6wsb5FNTf4Z4xTxLLq5ubG31H6ouwO28
   CteC9uYqyRuS63QibtsM+zS2NJU+fHB05evDoYJIXJA2jbs4PvF7nzsWo
   +B+1Z6noQ2OGKAc2vYSxOLkozszn3EOS8ZJF7JkF+1pllhMZclJKE3TMf
   vixTBeMTZkySe6N4Xbre55JJwAnLOQwVJMfxHdyUHsr9wc1zLhAB2Onwd
   q7R3mdv1/nddaOBM21zO165BJca8+EbX8RruBFxoKjncnONRUP5FYYVv0
   g==;
X-CSE-ConnectionGUID: DI/bX99nSQ+0ILU8prh9Qg==
X-CSE-MsgGUID: lE5waIf2SVyVegSek6BMjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86234218"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="86234218"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:52:13 -0700
X-CSE-ConnectionGUID: wEm5lW3CSueOvN11jFn+2Q==
X-CSE-MsgGUID: a79lc5GBQvC1nVkc3jWn9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="224669629"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:52:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:52:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 02:52:12 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEO4xl5YIibRwXh4vmb26ia7tgI8GhrlmBsiT0QoPGoplNv06IMl6Y6MS8LBw9XV+d9fyRUr/k8JGrFoc0YWnblofhcmFu463VabCUT3yMcyV3hU5ye33x7D0u5FwXVnrlYx45kjsg2SEzP2tPxStYp5FRiM1ZrKVDGBn1EljH6/4ldTI8XiwAe5xV1ZqCD4QgZnn7RgG5pDkP+2iSwY3Lzfi9uRC66DnD8aJZU6IWinrzCVkBxDimmtg3mh5M/DlSdjs31rnq3G+JylR8s1pIWse2q2epiAsXuYtyAIhow7tn9WpAaFsboLIeGhDTQkHxeecVK0/Z9rkgXxBd01lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYxBIbfkJBWCFPc0u1pCHUXU+jgr/gY5ECU88DR95u4=;
 b=iWZeG6z9OONulsy08tej7dAEbtoi+q68vVBUxDLCRCs3qA6w2oXxqhwyFvopm6lSyMfUtI8JCQg9lCFaS1joEpXgQRrS1tBAOpnFobNZyS0o2S2F/DZ53XdcksQIfF5mObLreJ1XXbABk/YOLg/dB0ZyV2rS3hkQ0sjPvyKQBvi1+wRoVKX7KNU6s9TNLdEuox86x/2APrwXXyFBS+z/bi8Rb7xix11den1KsmQslrX//qX9e53TmxLl90xOiCop+B1UjwZ5AjhmvA3eUIoWxtjCunay/lLp5hNjw8Jch7QKc1JvuyfSpDAChlYrq6KbIltjI6Zp1vh6Z+ED0EQ7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 SJ5PPF33E90C8BE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 09:52:10 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:52:10 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "sashal@kernel.org" <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Manna, Animesh" <animesh.manna@intel.com>
Subject: Re: [PATCH 6.12.y 4/8] drm/i915/lobf: Add lobf enablement in post
 plane update
Thread-Topic: [PATCH 6.12.y 4/8] drm/i915/lobf: Add lobf enablement in post
 plane update
Thread-Index: AQHctiysNRD/syzK5EidMOt0YPw4LbW0DWsA
Date: Wed, 18 Mar 2026 09:52:10 +0000
Message-ID: <a84422a0b1e1541dcb8e8067034e29a562130e87.camel@intel.com>
References: <2026031731-secret-rocket-af05@gregkh>
	 <20260317163924.220634-1-sashal@kernel.org>
	 <20260317163924.220634-4-sashal@kernel.org>
In-Reply-To: <20260317163924.220634-4-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|SJ5PPF33E90C8BE:EE_
x-ms-office365-filtering-correlation-id: f7f5e40c-2be6-48c6-63f5-08de84d4060f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: mmp6NMcvJOrP4vHnNjfYJfLEM9z+SC5kCBDVx4MZ59x1BJnnLMGLrqk7oW329DJowThy/K8198vV4AZKuwJbOh0JJkLTLczLoOnoYRwKLTiDoau7lgbZCN6Y0gyFPaDItH+FBndp0Cjp5fJ6bMSZ5VOeKN+8B9SJYiw1eBw8haJhskICs6N6SVuT8CZPinRFZ6eF1938ygQhfGJUqJBJp7RhQJBYlx0vf9dkBil0387QSDQBi+N7sdMTSjAJfST7WSB0T8McbGfFlxA2t94lAqkuN//EoAnA/SOLr/9QgEuZsyBjsqo9dtwIlONggdFoL8bvrt5HmGm0z7ja2MMZGAdnw04UtyaF+Ftz9BvrHUjKwZ7kMK855R3yp1JNLymOoB5XQNeo96hBvHc8gKid4DH8fBEavlbqQbifQOt1mSJ0ENXP+dkL/imJY911NAgNNfa87ERMjh2nA2wHN7+os5vUwJEwT/xe9UQPTJSp3HYuCVhx+KMfStQIkJjLvCKRd1zfZtW/3d1wJVDIHXBj+OkWqlyJwC9CP5LYCK2VH0sT6CrdY9rr1F3oAlg0DXgUj8pbRu4yMKNUtCESnl//Km6sE6pGL0qUd2qxerghPWJL40z0gJzKM6/18r8L+iM1ZWhrQcWQxYN3e3quM3YFnBUNq1zi76OykddP5pE9QUOzmIljSBSYHh/rKlrMHwFEP3JcjA0hECkk9cUSFF2z5TK6fQvACikMzncP6hFU2djw9ga3QgP1LaCVPYe/+pG98mGXjl6uYTPuuupKm/Z5YeXdiLhRSVSK8FzlJmYePb4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFlwUUl3L2N2QTQ2dkxuRjI2a2tXSDRxRnZ3Vit2NmJhWTRMdkNLelo4NFR4?=
 =?utf-8?B?MDcxY0QxSUJZT0x5NkNHdVk3eDN1Y09tSW5GRGJxUWhvOFl0ei9RKzd4OUJi?=
 =?utf-8?B?d3dIREszTkVWSjBDeFp3VlFjZjVMRkZ5b05qYnpDQm5rdTNsUm1EcEl1WEZw?=
 =?utf-8?B?bnRXYlo3VnpFWVRCTjdOOGQzWEI0N3h1d1M3MU9UZ3o1U3NlajU5eGRudmlC?=
 =?utf-8?B?blZUT20rb2ZMaUFZbVFPaVFkellwQndzcTFtOVpOYjlybUdIUGJmbkU4QmtE?=
 =?utf-8?B?elU4cW1Na0FLdVZFOXlYQnd6Y1lBZzZWTWhSdHBwcHEzb2F2dE0xbE9UVTdv?=
 =?utf-8?B?ZG4rc3IybWkvRE0yWklRUTVEaktQMnJSRVI1N09ENXVvSGNaZWdUWS9oUncy?=
 =?utf-8?B?M1RzUzB5V0l6ZFVRVTI5bll1ZmRRYVVIQTZnYngvYU53RWYrUElUQ2hxK3Zm?=
 =?utf-8?B?RTJlakN3Rm9Vb012RTFLYm5vQk1ZZ2cxelpqdmRoazVaaUF2Y1g5SHBLamsv?=
 =?utf-8?B?RFhYZDVEREFuOU0relpmWDFmQlhqVk1XNGUraURjK2FVUDV5eWk0Zm4ySHEx?=
 =?utf-8?B?bnRwZnVIWGI5a2QybmpLczhuSUI0THVJL0lpTHJnVUF5aXk5eEVld1JwQ2ty?=
 =?utf-8?B?aU1yclg1MlgvaktrYXlPbjYyaklid0s4ekt0WVpHNHlVVXM5UDlhdzhlWGJN?=
 =?utf-8?B?VnhmMUh6a2RvRzRzMTZYd3p1clJ6T3NTOTd6RUowL1hMSzJMc3N4eTQ1YWRq?=
 =?utf-8?B?K0YrQXVaTVVsc1FwaEFUak54TkdCSXRoc2FJOW0wR1Z2cTdoaVRuUU5ZU2Jq?=
 =?utf-8?B?S3A3MHNwd3k1N1hoWWUzbFEyam00aDRNUHRLNW01Z1RXRE5jUTNRRUFGSmVN?=
 =?utf-8?B?Sm9HUTFaTWQ3cTd0Q1JYU1FVNmkzeUJSTVdDUDZqUkpBTXQ4b3RkVklCTnpL?=
 =?utf-8?B?QWJJYy9FYmZWWlo4Z011ZVNpWWlYaGcydHFlYUt5ckh6ZnFqejNGTDczTk90?=
 =?utf-8?B?d21jNmNsOEZvaktQZjBjV3hoOUNwYmg2QXlOQ3lkWUI0V0doT3FRUURmZGk5?=
 =?utf-8?B?MlJ5ZzhWUm9ocG9TQlVJSllmcGpUNS9vN3FuL1JkNzhjZ3BXcjR0ekVHZXJP?=
 =?utf-8?B?dEN5NFcwR2xmSHBtelFBTzZEUzRTMms3VTJhZHlDT1YxZmx2MEtBbGVhaUhp?=
 =?utf-8?B?N20zdUVqeHZCMmFwMnJrNEl6YklhL3Q5V25tZVFFUXU0cFE5N1ZwUTVWRjBZ?=
 =?utf-8?B?TlVMeUE0MUFnYzAva2RqbWJib0pkeUJLRExzMGdNNVVNZG42MzhDRVFsUTRK?=
 =?utf-8?B?dGJ4Z2ZYRzZoTmh5QlM3UWxSRVNOWkZzWWhWOWpiaDFUUklBOThYTDV0V241?=
 =?utf-8?B?RzRrVDNGVit0TXNuRkxBVWtURmZFeE1yTDBYSml4QW1lOEdGYy9BWTU5TTlF?=
 =?utf-8?B?WHFFbSttdW5aQzc2VWk4OXZYWG9kcU1UVll3VzB3S09qSjVuaWhCUWpTeWRm?=
 =?utf-8?B?ajBVNHpxU1A5ZGh4MjJjT28zVTRxT1dPUmhmK01TOFplVUpHbmhSMFJqbVNR?=
 =?utf-8?B?elYrdVhrczBHVXgzUXBWS2plaUE3SGZnTW1YbXc0UTdSMUs4cjgzYzVtRHM0?=
 =?utf-8?B?bEFnVzRiVG11a1VsMkJ2ekNlUmh5QkNncTA4WTRtWFNxWW84bisrYVlHUlZi?=
 =?utf-8?B?bHBaTXdJY2JGTEhMUW42MHhRVjJOMHJWSGV5S0RqVlNEQk52R3lpYzhqSlMv?=
 =?utf-8?B?V0FjR3N3dU5qMHdOMWZiSmE2RTZtWE9DSElHaUlKVXhjWnB4UGIyRE53UVph?=
 =?utf-8?B?N2JuNEkyNU1rQTJHMmVnUWZ6TTN3YlNsK3Z6OWtJdGdNTEFvUFZSRWlOOXdD?=
 =?utf-8?B?VEpnWld4RnBDOENGQzk0SDMwUlpVczBXa1crOHFpcWJzakI3dXJpSFV3NWpv?=
 =?utf-8?B?UlNxbE9aZkJ3bE1scXdObTcxUGdqZ1p2aERYRFplZW9JakxrMkgvMkxKd3p0?=
 =?utf-8?B?V29sY3JjWGwxZkN5U0lWWHRrYlpLMmN1VGFsUnJ3c3p6Sm5uYWtvNlVtYWZC?=
 =?utf-8?B?M3A0bStKYnBPNmFqMFFoYmNWd2tKTzhjVlpEeEZaQ0p4YmFEQmMrWVRUbG9W?=
 =?utf-8?B?Q2xrbEdNaU4vUlFtRGttc1lqYVkrdTFFUVFHaVNWcmZlUElVN2lqYzh0bmRp?=
 =?utf-8?B?eEJuWWRFb1gxVTZrbFFzd2dnMGE5bmZ0NTBSU3NrTjNSVEQ1WUtWcS9kVWp6?=
 =?utf-8?B?RGFlS1RFdXE4K3hnZlEzcnRWTWxhcHR1MFpZaGlxTEdCZ3F4SlJQNkt0MEZM?=
 =?utf-8?B?Z2xyNm9YeXBuVEVScWFFbXdndHpDdlZBVG94U2NsZFJ4MjV6MTJxdmV4ZHNP?=
 =?utf-8?Q?QbAcvPdi0+KgOULTKlFzBW0PqPXcu96TU/NwJ6pxLS+N+?=
x-ms-exchange-antispam-messagedata-1: iCj0Qv0q9/21SuydrGGMHt57+AAQ362fwoc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50C562DE171093438E1540B6ABA5D2A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X4CBpHo2bLrSHS1OiTK/UYTwkokJoYNOvabqjhGL5uTiCnBKFr+cbUHRmTM55YT9scIfi82HcHqptSPqv6IL467PQDOdLLbNVpWJKzW7o8ieBMDvCsmd/u8d5cHdYF56CvrP+6THy040l2mW8oNaw7L2JaTHgOpe7hERKr2cGfOVtx8Wuks52aHsDe1GPtVWUsXj01WnzXNgyBJVIXbnPpXCtW/Nz1MA2Tb0OKtZj5bfRxsjGMbMiDaPKIPh7kU5oOZDACu57JrW/bS7fQlDgKleetpzsH/4vxgO3EGynV1kfl6YGoFPaGs15Tr38WHW4kcRdQ1lx9+bgx8+V+rprg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5e40c-2be6-48c6-63f5-08de84d4060f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 09:52:10.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yov06hsaZTSLgDOKfTbLP0APauZJVBF3G13Wk3fTm+bXsMdX5x4kDM4VdIp+c3cSYSExL98BhIy1abYHSoshMhgLKMzIX81VYUM6apzHdYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF33E90C8BE
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227012-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D62A62B9892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDEyOjM5IC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
RnJvbTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IA0KPiBbIFVw
c3RyZWFtIGNvbW1pdCAxNzI3NTdhY2Q2ZjYwNjI1ZjA5NzYwZWYwZmZkY2FjMDFkOGVkNThhIF0N
Cj4gDQo+IEVuYWJsZW1lbnQgb2YgTE9CRiBpcyBhZGRlZCBpbiBwb3N0IHBsYW5lIHVwZGF0ZSB3
aGVuZXZlcg0KPiBoYXNfbG9iZiBmbGFnIGlzIHNldC4gQXMgTE9CRiBjYW4gYmUgZW5hYmxlZCBp
biBub24tcHNyDQo+IGNhc2UgYXMgd2VsbCBzbyBhZGRpbmcgaW4gcG9zdCBwbGFuZSB1cGRhdGUu
IFRoZXJlIGlzIG5vDQo+IGNoYW5nZSBvZiBjb25maWd1cmluZyBhbHBtIHdpdGggcHNyIHBhdGgu
DQo+IA0KPiB2MTogSW5pdGlhbCB2ZXJzaW9uLg0KPiB2MjogVXNlIGVuY29kZXItbWFzayB0byBm
aW5kIHRoZSBhc3NvY2lhdGVkIGVuY29kZXIgZnJvbQ0KPiBjcnRjLXN0YXRlLiBbSmFuaV0NCj4g
djM6IFJlbW92ZSBhbHBtX2NvbmZpZ3VyZSBmcm9tIGludGVsX3Bzci5jLiBbSm91bmldDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29t
Pg0KPiBMaW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNDIzMDkyMzM0LjIy
OTQ0ODMtMy1hbmltZXNoLm1hbm5hQGludGVsLmNvbQ0KPiBTdGFibGUtZGVwLW9mOiBlYjRhNzEz
OWU5NzMgKCJkcm0vaTkxNS9hbHBtOiBBTFBNIGRpc2FibGUgZml4ZXMiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQoNCkkgdGhpbmsgaXQgaXMgYSBi
aXQgcmlza3kgdG8gYmFja3BvcnQgdGhpcyBtYW55IGRlcGVuZGVuY2llcyBmb3IgdGhpcw0KcGF0
Y2guwqBUaGlzIHNwZWNpZmljIHBhdGNoIGlzIGVuYWJsaW5nIGEgbmV3IGZlYXR1cmUgKExpbmsg
T2ZmIEJldHdlZW4NCkZyYW1lcykuIEknbSBwbGFubmluZyB0byBzZW5kIGJhY2twb3J0IG9mICJk
cm0vaTkxNS9hbHBtOiBBTFBNIGRpc2FibGUNCmZpeGVzIiB3aGljaCBmYWlsZWQgdG8gYXBwbHkg
dG8gNi4xMi1zdGFibGUgdHJlZS4NCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCiANCj4gLS0tDQo+
IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmPCoMKgwqAgfCAyNQ0K
PiArKysrKysrKysrKysrKysrKysrKw0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfYWxwbS5owqDCoMKgIHzCoCA0ICsrKysNCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2Rpc3BsYXkuYyB8wqAgMyArKysNCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX3Bzci5jwqDCoMKgwqAgfMKgIDMgLS0tDQo+IMKgNCBmaWxlcyBjaGFu
Z2VkLCAzMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggNTdhZmIyNTE5MWJkOS4u
ZDI1NmJiODMxYjEzNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9hbHBtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9hbHBtLmMNCj4gQEAgLTM2NSw2ICszNjUsMzEgQEAgdm9pZCBpbnRlbF9hbHBtX2NvbmZpZ3Vy
ZShzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoAlsbmxfYWxwbV9jb25maWd1cmUo
aW50ZWxfZHAsIGNydGNfc3RhdGUpOw0KPiDCoH0NCj4gwqANCj4gK3ZvaWQgaW50ZWxfYWxwbV9w
b3N0X3BsYW5lX3VwZGF0ZShzdHJ1Y3QgaW50ZWxfYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gKwkJ
CQnCoCBzdHJ1Y3QgaW50ZWxfY3J0YyAqY3J0YykNCj4gK3sNCj4gKwlzdHJ1Y3QgaW50ZWxfZGlz
cGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoc3RhdGUpOw0KPiArCWNvbnN0IHN0cnVj
dCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlID0NCj4gKwkJaW50ZWxfYXRvbWljX2dldF9u
ZXdfY3J0Y19zdGF0ZShzdGF0ZSwgY3J0Yyk7DQo+ICsJc3RydWN0IGludGVsX2VuY29kZXIgKmVu
Y29kZXI7DQo+ICsNCj4gKwlpZiAoIWNydGNfc3RhdGUtPmhhc19sb2JmICYmICFjcnRjX3N0YXRl
LT5oYXNfcHNyKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlmb3JfZWFjaF9pbnRlbF9lbmNvZGVy
X21hc2soZGlzcGxheS0+ZHJtLCBlbmNvZGVyLA0KPiArCQkJCcKgwqDCoCBjcnRjX3N0YXRlLT51
YXBpLmVuY29kZXJfbWFzaykgew0KPiArCQlzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwOw0KPiAr
DQo+ICsJCWlmICghaW50ZWxfZW5jb2Rlcl9pc19kcChlbmNvZGVyKSkNCj4gKwkJCWNvbnRpbnVl
Ow0KPiArDQo+ICsJCWludGVsX2RwID0gZW5jX3RvX2ludGVsX2RwKGVuY29kZXIpOw0KPiArDQo+
ICsJCWlmIChpbnRlbF9kcF9pc19lZHAoaW50ZWxfZHApKQ0KPiArCQkJaW50ZWxfYWxwbV9jb25m
aWd1cmUoaW50ZWxfZHAsIGNydGNfc3RhdGUpOw0KPiArCX0NCj4gK30NCj4gKw0KPiDCoHN0YXRp
YyBpbnQgaTkxNV9lZHBfbG9iZl9pbmZvX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpk
YXRhKQ0KPiDCoHsNCj4gwqAJc3RydWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9yID0gbS0+
cHJpdmF0ZTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgN
Cj4gaW5kZXggOGM0MDliMTBkY2U2Yy4uMmY4NjJiMDQ3NmE4YSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gQEAgLTEyLDYgKzEyLDggQEAgc3Ry
dWN0IGludGVsX2RwOw0KPiDCoHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlOw0KPiDCoHN0cnVjdCBk
cm1fY29ubmVjdG9yX3N0YXRlOw0KPiDCoHN0cnVjdCBpbnRlbF9jb25uZWN0b3I7DQo+ICtzdHJ1
Y3QgaW50ZWxfYXRvbWljX3N0YXRlOw0KPiArc3RydWN0IGludGVsX2NydGM7DQo+IMKgDQo+IMKg
dm9pZCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4g
wqBib29sIGludGVsX2FscG1fY29tcHV0ZV9wYXJhbXMoc3RydWN0IGludGVsX2RwICppbnRlbF9k
cCwNCj4gQEAgLTIxLDYgKzIzLDggQEAgdm9pZCBpbnRlbF9hbHBtX2xvYmZfY29tcHV0ZV9jb25m
aWcoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJCQkJwqDCoMKgIHN0cnVjdCBk
cm1fY29ubmVjdG9yX3N0YXRlDQo+ICpjb25uX3N0YXRlKTsNCj4gwqB2b2lkIGludGVsX2FscG1f
Y29uZmlndXJlKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgCQkJwqAgY29uc3Qgc3Ry
dWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUpOw0KPiArdm9pZCBpbnRlbF9hbHBt
X3Bvc3RfcGxhbmVfdXBkYXRlKHN0cnVjdCBpbnRlbF9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiAr
CQkJCcKgIHN0cnVjdCBpbnRlbF9jcnRjICpjcnRjKTsNCj4gwqB2b2lkIGludGVsX2FscG1fbG9i
Zl9kZWJ1Z2ZzX2FkZChzdHJ1Y3QgaW50ZWxfY29ubmVjdG9yICpjb25uZWN0b3IpOw0KPiDCoGJv
b2wgaW50ZWxfYWxwbV9hdXhfd2FrZV9zdXBwb3J0ZWQoc3RydWN0IGludGVsX2RwICppbnRlbF9k
cCk7DQo+IMKgYm9vbCBpbnRlbF9hbHBtX2F1eF9sZXNzX3dha2Vfc3VwcG9ydGVkKHN0cnVjdCBp
bnRlbF9kcCAqaW50ZWxfZHApOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2Rpc3BsYXkuYw0KPiBpbmRleCBlMjczNmY1MGZlZjgzLi5iYjA1YzhmZDVlNWYzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXku
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXkuYw0K
PiBAQCAtNTcsNiArNTcsNyBAQA0KPiDCoCNpbmNsdWRlICJpOXh4X3BsYW5lLmgiDQo+IMKgI2lu
Y2x1ZGUgImk5eHhfcGxhbmVfcmVncy5oIg0KPiDCoCNpbmNsdWRlICJpOXh4X3dtLmgiDQo+ICsj
aW5jbHVkZSAiaW50ZWxfYWxwbS5oIg0KPiDCoCNpbmNsdWRlICJpbnRlbF9hdG9taWMuaCINCj4g
wqAjaW5jbHVkZSAiaW50ZWxfYXRvbWljX3BsYW5lLmgiDQo+IMKgI2luY2x1ZGUgImludGVsX2F1
ZGlvLmgiDQo+IEBAIC0xMTE2LDYgKzExMTcsOCBAQCBzdGF0aWMgdm9pZCBpbnRlbF9wb3N0X3Bs
YW5lX3VwZGF0ZShzdHJ1Y3QNCj4gaW50ZWxfYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gwqAJaWYg
KGF1ZGlvX2VuYWJsaW5nKG9sZF9jcnRjX3N0YXRlLCBuZXdfY3J0Y19zdGF0ZSkpDQo+IMKgCQlp
bnRlbF9lbmNvZGVyc19hdWRpb19lbmFibGUoc3RhdGUsIGNydGMpOw0KPiDCoA0KPiArCWludGVs
X2FscG1fcG9zdF9wbGFuZV91cGRhdGUoc3RhdGUsIGNydGMpOw0KPiArDQo+IMKgCWludGVsX3Bz
cl9wb3N0X3BsYW5lX3VwZGF0ZShzdGF0ZSwgY3J0Yyk7DQo+IMKgfQ0KPiDCoA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gaW5kZXggMTZmZDM5M2RlMDRm
Yy4uODU1ZjIyZjFmODMyOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9wc3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX3Bzci5jDQo+IEBAIC0xODg2LDkgKzE4ODYsNiBAQCBzdGF0aWMgdm9pZCBpbnRlbF9wc3Jf
ZW5hYmxlX3NvdXJjZShzdHJ1Y3QNCj4gaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoAkJCcKgwqDC
oMKgIGludGVsX2RwLT5wc3IucHNyMl9zZWxfZmV0Y2hfZW5hYmxlZCA/DQo+IMKgCQkJwqDCoMKg
wqAgSUdOT1JFX1BTUjJfSFdfVFJBQ0tJTkcgOiAwKTsNCj4gwqANCj4gLQlpZiAoaW50ZWxfZHBf
aXNfZWRwKGludGVsX2RwKSkNCj4gLQkJaW50ZWxfYWxwbV9jb25maWd1cmUoaW50ZWxfZHAsIGNy
dGNfc3RhdGUpOw0KPiAtDQo+IMKgCS8qDQo+IMKgCSAqIFdhXzE2MDEzODM1NDY4DQo+IMKgCSAq
IFdhXzE0MDE1NjQ4MDA2DQoNCg==

