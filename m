Return-Path: <stable+bounces-223451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJEXLIhLrWld1AEAu9opvQ
	(envelope-from <stable+bounces-223451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 11:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9122F4B7
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 11:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498A93011BEC
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4331D5CFB;
	Sun,  8 Mar 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHslFMlD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE862C3252;
	Sun,  8 Mar 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772964739; cv=fail; b=BqRnafom1Nagq5biLPnpY6hiP0xbv5QGAlVQRvMkfNbi2RSCon7WxIVxtOF+QVCw5lSgByqkIA+7Ii98ESNIhG4NNSaRZrLcRPmm07u7gjRVv7DhTjlsUbloBY3nVVFAfLf2ZeqLbs3FY4GSxCMdnnErcT/rMiAkHvBKyDMtJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772964739; c=relaxed/simple;
	bh=vYQJjUTFGyvCsE5VXfZQOYHjofVl4XFe0Yizrs31UBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/95KtMICMlUJhGxPtS0q+avpbERhrfm7Buh8wbNWbG7FgOoLi1gy7aIhLAc/56PiKP0+zN7Zmz+77ZLQLhUJsrp5NNeSxeeuhEQwN+HRQ56lEsJCFba2g5tY6jsQSvQAjN5SoYSdi0BnIUf7vWw/ADOcGq4fk2b3vhs0H0NIKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHslFMlD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772964738; x=1804500738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vYQJjUTFGyvCsE5VXfZQOYHjofVl4XFe0Yizrs31UBQ=;
  b=DHslFMlDnm92r5wv5vdAfLC6OxVyYDWGa/sFU2c9J7Po9dEFWEZZvwhi
   drCiCrIOG+vL8Gnh0GYsCNaU3YNTE29NYFEr9Kv17BPkzUd3CsZvl/3ON
   WpWOV7zcoTHovZU25ATzdVY2f4uiSMGlW97/hMrGNGuNH+7DNjdNzLECf
   157FCkTqnR7otBcmBvjHNj6ezziRUHXRzWNq+EJPRcwIDNfC4gBa2xmwZ
   RapkpodhxGMTpk/AXnfVTUTUutJ6k4pG44oOW5iW+IYIg3jJfslIxHOhD
   Wyw5QHe1LF1Iu5Iwqvz71oTgIY8o9n4946ZVD1Fq33keTrOW6VPzcqduY
   g==;
X-CSE-ConnectionGUID: 1pmO2kKAT+W7zhfm/F/Y0w==
X-CSE-MsgGUID: 29l+znaCSWOM+4W6ejTV5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73981693"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="73981693"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 03:12:18 -0700
X-CSE-ConnectionGUID: fRGBkq8nRAm4z3x2mUUWSQ==
X-CSE-MsgGUID: yYeFYbehTd64AW1mrx6szQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="219406993"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 03:12:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 03:12:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 8 Mar 2026 03:12:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 03:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9zl/5leadMFXrB79GZo7quW6D8JE4EXTnxPBvKMesCF3LSX2jWLw79gHWkueR58N/vhyvWPH1Uq+VUht37kVPF7EoplFD7sX00oDMywHq209Sjrgx41B8BbFg2q+/ii4GGLZlt+zroOm49F+FeR360Vxt2RxtCB+wAon5K6IiwFwwoBYnW/DmMwypCQhU4cwEyiB3QjMxDNeY87sZdbU8opX7IJWvi/3rCpisg9AEIV+NKBbRjY6e2I98ql1wewjSmzdkUpSqEjOcP9bR5pTtXd19VRvBSy02sYdNjLsUoaJDIEC6OqjFYw4rgSEtaodp2SlsanUe4wRm9tckDUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYQJjUTFGyvCsE5VXfZQOYHjofVl4XFe0Yizrs31UBQ=;
 b=cfUR/SofoE5ToiEhX5RH3OdcgL8PdDsTQnYzDsEQZD9+CiUJjUkRFxF5yb//UIFIwDb+LujsHlqHsbcpFnP12CAMQBzrbUf0WnYI8TIq4A9tyrVI/Pj/J+mCofOTt1TezNE3uO2G2fvEay4GuLh21FAdKFw0Q2jzeZorfiW5knEASj7JBjiUtGmSqwTa4LK6iiLsuG0iIHpjCxqgFyro/G+UJuMVwOASKvxjnQ4xFj8CD09AUtdJniXsEnFQsUYVhJ6gsJB+sbE2xmqPvtP/9uBDZKvZZWmmrlIqpY70AM8JZYTuoPsOs41f2958fvL5f/YdbdGE80AaNBEwm2KFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.8; Sun, 8 Mar 2026 10:12:14 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9700.003; Sun, 8 Mar 2026
 10:12:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6XsnrexK/sl0+dSWKh02Fmb7WgSOOAgAAy04CAAM+OgIADKG2A
Date: Sun, 8 Mar 2026 10:12:13 +0000
Message-ID: <5de759b3bfba98c26c4fdd413bdfc2b196cb2b87.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <20260302102226.7459-2-kai.huang@intel.com>
	 <4a15470a-5a10-4742-9faf-f66a88105d58@suse.com>
	 <51e221b9bcdeddffb95f2c39dcc285fb0e9f5951.camel@intel.com>
	 <2db61bc6-813d-468a-8ded-018dc9dfb0cf@suse.com>
In-Reply-To: <2db61bc6-813d-468a-8ded-018dc9dfb0cf@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7310:EE_
x-ms-office365-filtering-correlation-id: 7ff91a5f-2ed8-491a-f4e3-08de7cfb2b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: /+UK6W3uS6orX7RQoWA55zb+i7R8QIz00zgrc/nEGLTV8eI0ritQOMA1Q/HIC+Pp5nOBVzcMmaXnQza6+lWf4iQhkcrLvH75xz52JIPhc1QSwqYnD9a7fvZUeTrdMepjEFcICfDncH9Tyo+JdEpAQlMs8SUzRKbb8gDKpmsird8e/cIOvZqgOtX2tzhJ8PeiY1b2USqtld0HmDTqXTu62dB6vfxIcsmP6N3ppLZ2HNlqGdkVmZvYXtTKsEP/FtrDO6tnSltz0p8+yEfqIq3DPOw+1fzQJ9MT1UkHI3+skI9ZRAP4t/5UzB4R32Ju11wATUOMZUFImveRb56YQwSgfjWOj9DHTTcRnq+zA0g1bTsoOxjn+aJGx5BpfNXs7gParbhgmdmz2D/QErfWAMhWU0x986Ps60OvB8+K0dp02VvIb8EFRqrc3uOpGPCSdK0fGCdKZv/GiVoZDyBNZPjw1jHuZLvqRXiB0TDstDPgW349L5ebVKeC1SL4IgXHxK+Coq2C3y3Y8m98Vt0UEBMOWz0FvkoN1EvKNlSjFz8IReeBaSrTY/UbqTX/iB76GWYTp5pRufLpxIyfm0psUD6izuElWqr+r5A5WnuUDT/BXgpe39rbaC2hxUnicKCOvlYQD08DQ2tDhvvDVOI+x53eLPm7Hc/YrybYey8VXFzg3WVNZ5fmXCBiYe7CpJCUq7wnxz7Aev0D1vhH1pYdv/8a6mexrgnDlOBRQi6V74TjJGx6oUirt/I9YvtlHTFTy/UyRl4fr+auXBwDci/BOwUFlsufMeYy2m1xUiHotqZkv3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am04WnBjdHNSblpuY3dYZHd0SFNJVzNtbFVSL3cvVWhFYnpKOFBCTVhNZmpZ?=
 =?utf-8?B?TWtaS1NNOG90dmVzZFZiMk9ETm4ycGFsV3AwMVRlQmh5SzhoVWYyKzl1dmU2?=
 =?utf-8?B?YmNvd04wRzlnK2pYVnE4blFPdXoxSytEdHFZL0VhT0pzU2xFZjBaTDRwUFdi?=
 =?utf-8?B?YmxXZU9PRzloaXVEdU5EUnlpSTh1TDhqbnMyaWFOSm5aZkNDQ2NiNm1PQ3h6?=
 =?utf-8?B?RzB5OVFuU1RoTTdLTWRrR1BOZi8wYlRWQTlJRzFKSDBnSzN2c1B1ZGxWekNE?=
 =?utf-8?B?RHJhQk5Vc092R1JaT2Y2dmJweHBYVlFKUUNWZ1k3MWgxRndIY0xUdnE2VlRQ?=
 =?utf-8?B?Zytwb3IwNXk2R1haQmFWNDVLUTRMOThOOHpmbTJ2OUV4bmRiOER0TnQweEEr?=
 =?utf-8?B?ajJINVV5UFN6eTV3bjRjbnRURGkzTnkvM0VOR2JaQWpxYTdPOUZnTVpaM1Rt?=
 =?utf-8?B?RWw1bHQ0dEwzTWk3aENUWnJpZnUwZ2paSkFWZ2pYL1kwQmlVSUdVQXB1WlBn?=
 =?utf-8?B?WjkyQjVQaU9WRk1Sa25PamlWVno1ZjFlY3d1MEhsOHdSdUE5amsyS0o3dnVj?=
 =?utf-8?B?NXJKbUJpMVJuQ1M5MXV1V3dNd2Y0aFdRRHdDSlJueVNHdXBtUzI3bjREMnBl?=
 =?utf-8?B?QTN6dHYxM1hXTkxDNEdDWVc4MlFXZmpWYVhTZE9keHRQYWg0QjBkaEpSbU9k?=
 =?utf-8?B?VFlUUnNMcEg3L1NneDllQ3RtT0dXZkM0YWt6ZUE4bTY4TmhON21uRGVybXZF?=
 =?utf-8?B?TGRtMDlwTFhsV0E4cnhrQlhGTElNUW9vQThtcTlJZFpPNGQvNUExemNPWU9h?=
 =?utf-8?B?MnkvZStPRWxpOUlxV3Bsa0M1SW1uMFJNb01yV3UxLzF2VUJVUE5DQzlRNGZF?=
 =?utf-8?B?ZVF2aTc0SVJpZjFyRjVDaGgvNGd6YmlVUSt3WkRTMnNwUG51NTYrM0RxTkN4?=
 =?utf-8?B?Y1ppZHBlUlRxY0NDczF0eEF3STFzL2w5bTU0ek9UcnJ3REtzc1FlWDJGSmRK?=
 =?utf-8?B?WW1ZV2VHaEg3RmYzRlkvNUFaWjMzYjEvSzlJTHZMc3BvdkZpRm51UkxSbnpm?=
 =?utf-8?B?Z2V1UDdXQ1Qzd1Q3QjJoN1NkcFdUUlpiOUVzNWZrN3dQbXhTTm1VVFcrSDcy?=
 =?utf-8?B?aXFjYmpyVGlRRGFtVmpka1JNYUM1U0dGb2l4NE80cG5UVXNMU0YxaFNPMUMz?=
 =?utf-8?B?OWlkVDlZNWhocTdzRVpIY2NraEpEVHZJa1F3UHZpcTl4cWFRWnFTT2RmaGZQ?=
 =?utf-8?B?cTVWNnE1U0c3ZGpPMlNvOGlqOXZVQ0RlbEJ1Z1o0MitDOWhFWWR3a0lETndO?=
 =?utf-8?B?RitieUhyQ2ZJV3ZhSVJobWdwL3cxdmN0OTdYNDJKbEFUYnJxbjZqRXFTNU4z?=
 =?utf-8?B?S0tQeUxzeG1iaCtwWFdMSUxkOU0ybG84d0ZLZlh0aG1LYnBEOVM1MTJGMnUz?=
 =?utf-8?B?dWNLUlQ1U0ZzUERyczg4UExKMW55bHNVakFKUmZvWk5jMkJ4Y2hMc3VESUdB?=
 =?utf-8?B?dGc5UTUrcmY5T2xXYXB5NlQ3T3pBR1ZyekIxMmJwMEdYRlZMMzRyOWN6aVFZ?=
 =?utf-8?B?RTh2bWpteTZKSStQSTRpZzRneUN4blV2R1lYWEp2M3hUNDJnTGdVYklwK3VB?=
 =?utf-8?B?TmZxRDdtZGREQU1Cd2QzUGRtYnpWamVycEFKZHRIc3pCU2ZGNkpaRlNscXNn?=
 =?utf-8?B?ZGFoOE9ZWkVLNkgxYW16TGRQc2hwTXdkVjdyZ3ZaWUdkZ3RPbzQ0WmxrbUg0?=
 =?utf-8?B?eGpUeE42V3FCT2UzTnhmRHhWYlg3ZysyZGdYUGJOK0NFKzFwSmRXSE02NGZQ?=
 =?utf-8?B?ODU2bnVDTVhhMlN3MHRZWTNUbGpGY1EwaDJXR3ZLR243K096VGxTY1g0Q1E0?=
 =?utf-8?B?NXA2b1FHTEdSVENYNVc1S21zUGMrYjcwcXRBQ2JRYWJOTVY0WUVJeUZHdERE?=
 =?utf-8?B?aHNEREI3UmtCL1ZNUi9hd1EreTF1N2JWT1hmMEpxa3VYM04wWFZLbzFHME1W?=
 =?utf-8?B?dFRwOFcxNWVWa1hIWnhrMXI3YmJJRk5nMlB6eHArbEc5di93ZVZJQzdTQ3V4?=
 =?utf-8?B?MktYcUFyVkxrSTRTK2QybmNKbkxrMGdZVmxKVXU1SWlNSm1FbDFTUlhxbVlG?=
 =?utf-8?B?K29LU0RVdVFTWUlNOHg1cmJ2RnArS3dPZEVObkg0cWppOUxYVmwzNEhJZXB0?=
 =?utf-8?B?WVoyckFZSld3TFNUWXI4U0l2RmRkQXgxem5BUlpvYU9mQXFIZXE1NUNEMTlV?=
 =?utf-8?B?bFp0REJFSzQ0Z29jNURkTkVYQVlzaGFVeVlBS05HUWNaZzJPWWNBSlM2UCtU?=
 =?utf-8?B?ZTA1UE9xS2NGbDFDMDRUSmdGU0NqOVNTaXhKMHlGeVpoSldMQzlHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD6483E249BA546AF46400A9BAE6E4B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uqFpNDEEZknfmB6v4QkfI6NgoDl0BTJFpBvMQRrmwwxW9Cpnk/ClSHKotCm2dTJV9YnCpujEVR1ZogjOQYTZEE8jf8ZrMLsnPJEFIvQNOr2UCNANSzSxnb4akea/n0I3UT9bdLzB0jvpKBxeAMvwJXiLf2KZh20V+X11blEeIRxnMqyZfC7xvzoth9AYVxfnAiZVqRSJ6G/OOG20Y+5IE1LVVkRoSwz7k+E26GliC6L7i4revzSKEqPOhYp3Cv+O3z5OtGkVj16SOOZwzbyhaNprglJqBtRJYzCwTBF6IdD7Hoca/xIdKuuRuQErNXVgvfmpmgUJgFlfJFFSuZ0Alw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff91a5f-2ed8-491a-f4e3-08de7cfb2b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2026 10:12:13.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYv8vHMjTfRcX0j4eBGB9KWh3VoaSkGaual+sfbvyykCVqCv6gQMjkFat9PK5PCfcSAq/8L15R6c2i9UdoLn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0FC9122F4B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-223451-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiA+ID4gDQo+ID4gPiBTbyBob3cgZXhhY3RseSBkb2VzIHRoaXMgcGF0Y2ggcHJldmVudCB0aGUg
QlVHOiBwcmludGsgaW4NCj4gPiA+IGNoZWNrX3ByZWVtcHRpb25fZGlzYWJsZWQgZnJvbSB0cmln
Z2VyaW5nLCBpZiB0aGUgbG9ja2RlcCBhc3NlcnQgd2FzDQo+ID4gPiB0cmlnZ2VyaW5nPw0KPiA+
IA0KPiA+IFRoZXJlJ3Mgbm8gcmVhbCBCVUcgaGVyZS4gIEl0J3MganVzdCB0aGUNCj4gPiBsb2Nr
ZGVwX2Fzc2VydF9wcmVlbXB0aW9uX2Rpc2FibGVkKCkgaXMgbWlzdXNlZC4NCj4gDQo+IEVzc2Vu
dGlhbGx5IGluIGNoZWNrX3ByZWVtcHRpb25fZGlzYWJsZWQoKSB0aGUgY2hlY2sgaXMgY29uc2lk
ZXJlZCANCj4gcGFzc2VkIElGIEFOWSBvZiB0aGUgcHJlZW1wdCBkaXNhYmxlIGNvbmRpdGlvbnMg
aXMgbWV0LCBpLmUgaXQncyBtb3JlIA0KPiBsYXhlZC4gU28geWVhaCwgbWFrZXMgc2Vuc2UhDQo+
IA0KPiBSZXZpZXdlZC1ieTogTmlrb2xheSBCb3Jpc292IDxuaWsuYm9yaXNvdkBzdXNlLmNvbT4N
Cg0KVGhhbmtzIQ0K

