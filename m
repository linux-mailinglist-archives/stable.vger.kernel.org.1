Return-Path: <stable+bounces-192549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9DC38323
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 23:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 720EC4EE88D
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4272F1FD5;
	Wed,  5 Nov 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4Kouo+c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EED2DF6EA;
	Wed,  5 Nov 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381771; cv=fail; b=bIUqgE1FioMtVRNvkdG+WvYGL0fN2OM4sUul/uAkgIW/fqophK6SUtKXZoxKXIdlucf2bqZMbalKoQU06hzrEawnBr6ADIU8ODa2NQFo2jwFp47lOA5AkH6QEk2gA+ZqOVhDX/cYtJv+ossBU0R2ZgO3BNvW2TbzQ/atEOSK7w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381771; c=relaxed/simple;
	bh=Z+TiH8lVIDTldb8GDQ2qsGHCYcSuxCOYjovJOc8avK4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmRhqvTvTMJsusXoLR9g8e1sMMIEL/r4ZCgqbiSghfnKYAM+M1Mk8BO3OUGQ3piyJCpzAP0Pahm32PDVvGnvqMQ4xgPzeU6QeHIfuqDJFsOPH28VaGuTV/6dgo7mlyGwN1ElStFU+9ZpgMF1ZodeLyoOK00Fx2Bnp8zB2gjpe5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4Kouo+c; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762381770; x=1793917770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Z+TiH8lVIDTldb8GDQ2qsGHCYcSuxCOYjovJOc8avK4=;
  b=e4Kouo+chRnY7sc0/U25LgRABl1jptIYCAN6TBWCrxbzQ9cg25uWNQqs
   d2zFcB6FMm0E0e2cOda7IUWsHpZ3jpehjSQE0+N3OoOOVq/Ot7++MBqjv
   AFXpexYrDolC6gf+Qhmzk+rT+WaNAanHXS8iToyygQ+yS78z3In5hP5Vo
   Bpca7OpWRabbxlu8xLKJSSUlQX5LRRf0CF9MENCKs2kao/G8B6dC7tlYA
   EuGxZeWsI0BOAoc5dqPukVKvclG5MaI4DAeCjW/FgyhgLmpfJ6AhnI2vG
   2t79QT2unuhk6dDuxdcA2Wq8vu1al6nnd/2QAEUwhOrOz/k9VShlwVGB4
   w==;
X-CSE-ConnectionGUID: iQ0jx1DQRaOrTB2c1Lk2jA==
X-CSE-MsgGUID: EsZm1obISf+mttnOPkLKZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64417065"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="64417065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:29:29 -0800
X-CSE-ConnectionGUID: wsEnNlgzT7+/2lcWmZyCZw==
X-CSE-MsgGUID: mpa/bEO8S4CJdO1TPLDsHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="191866899"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:29:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:29:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 14:29:28 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:29:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi7uJf3ltaModu0Xe0E60cFAMqdwoH7S3mcQKOrCqGMZDZcWnqQxlYb7cAhUWQvuAZVszpUQ2x97xgWMn6Hxci2n+Iy8RaC5/ghTVaO4fdtr6HDiqUCCUJCsXv4y2nRIywnhGpLN6Jr4TmtahdtxVnLWBmpJ+NJPZoPV67rwKPaidfmIVn3pmmVKhY4893CGC/hUcl9hGlXfcNRI12089G0JyiZnYcuBbMvmvx34TG8Gzd0Xdit4+eJEhhVN9D2amtlXLbW7fKgQH48UpUAlvD7F+Aub6VEwMfZ2h/f2Dqnx9tytXF1FaqvzYfhYf08Vmdpo/IGmVw4vonptUbgv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+TiH8lVIDTldb8GDQ2qsGHCYcSuxCOYjovJOc8avK4=;
 b=DBWKytlJ8P0+u2+HRQC3J/sDXnJpa447eFgdM0dpUMiQ7tg6lkcVfyP8AVVm5uus3tGswllLs39Ilj0muLqIM8O3FirVeiVpMVsKxCmDOCFOjzvKgs1Lj1cke/4D4ZOFvEH+MCpzPAG85X2B9D6KxUIYKOHvTnLi1aoUWcg32U63cztZhAJIC3wqfOTETjkT0N+drS1MI+vX2Z3Y/ZjjtdUeGgc/NkpEAhjI4R2WO/szvOgBQCYEk/g3YuW11yrsWbQUXmJnZllfeNbr8ElFYTdToo4Gue35RxVc+svlIqndAabSFCcq+FNLv44yE0hoRQ4202SOXxRa6qoeGerkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 22:29:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 22:29:26 +0000
Message-ID: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
Date: Wed, 5 Nov 2025 14:29:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<john.fastabend@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@treblig.org>, <mrpre@163.com>,
	<nate.karstens@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stable@vger.kernel.org>, <tom@quantonium.net>
References: <20251104174205.984895-1-nate.karstens@garmin.com>
 <20251105173434.1404676-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105173434.1404676-1-nate.karstens@garmin.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------QLykJo7O8f2eE36bgLVjBAnP"
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e8fb05-4d13-48bb-64b5-08de1cbac6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWpFcGFoZnR5QmtpbHZvaFhnL0dJTlNjYURmNUpaRldlNjVIOUx1cDdiQWZt?=
 =?utf-8?B?QVpNenRuZ09jZ1NOcW5Gak9vbUpNUEl1M2h2RG5PMjU0TG9VQXdvd1drMGZp?=
 =?utf-8?B?U0lZMmVGeEk5d1hVRXI2YVBSV3N6eGtienhSd2ZuZGp0aFoyMjJ1amZCOFJq?=
 =?utf-8?B?bjdsTWVNZXR6RFAvNFkycVZEbUpZWkduV0NiTFNLUkZIczRVZjQzcjhwcGpN?=
 =?utf-8?B?YjZodS9QK3Y4UXI2SzVZZUw5Ry9JMUFCRS94SE9jaFFpaWw5a2IxVXdWUENM?=
 =?utf-8?B?bEpkQ0FSM0wzL1V3Qk1DWjVxZkFuZVVpNXRGT25LemR5TTlBdHUxNXR6Yjkz?=
 =?utf-8?B?SzBCREttcjdhL1UvMkQ1WE5DRTRVTGtwbnkyMk1QRUgweUhsdXFWOTdhb3VS?=
 =?utf-8?B?OHRPa1ZyZ2tiMitwM0FYRkRMSkpRZXZsVFpBZ29BZGdzanQrZW9JRWRwMzdF?=
 =?utf-8?B?a0paMnRxcFRRU3VrTmxnbjdFeVV1TGgwR2hOUHk2S2lITStESGxGQzEvZWJm?=
 =?utf-8?B?YzB1enpXc3drbzY5and3WjlmV2ZaWFB0MXBaUEdrVHE4Mm1pOWJ1aXhNTEZM?=
 =?utf-8?B?ckdTM3hpR0NBMGlXVzU1V0VUbFhyTmpyTW9Kek9lUFluNjZYTW1kTE4rT3FJ?=
 =?utf-8?B?cUdiNDJXbW44QXF3ZVFSUHdoczhHbTAwV3NPRE9HNU5xR2phRnZLanNVSThP?=
 =?utf-8?B?Y0x0cmpnU09SOHNxRkx2TVZPYVVoSHZWTlNnM1g1L2l6QklWdXgxVEhrZm5z?=
 =?utf-8?B?eFU4R05laDBzSDdWS3lCVC92cGxLRTUzTlhueEtGY29WTmp6NUF1T0JFM0l0?=
 =?utf-8?B?L3JOeXlkTmlKUW10RHI0NnFacURNcXFNWFRybURPVnJqUWZad1BET29jSEFx?=
 =?utf-8?B?MWhRVWJISTVOdUVOVk95ZENTTjVPeEorRmlCY2VwR2x3Ni9ySDZXLy8vSHdX?=
 =?utf-8?B?S3BmU2M2dmZzVE9vNUtYRE5UajFDdzRML2w0QzBqUnV2SkpwS1hiQm1LWVd2?=
 =?utf-8?B?NUIyQ0V3clIvLzcxcmlSVTlQNlk1YXlvbDhuR1djelduWmZPdTFTMkdueFEw?=
 =?utf-8?B?U291TkI2TkRUZ1dyZjhLeEIvbjc4ZGV1QXdjOGNjeG9Ydnh2Uk9BQ0ZjeW1q?=
 =?utf-8?B?YmFCVlRvWlUxaFlvQmFJWjI3eVU5T2xqdHY3SnBXMll1THJ6OEJwYjZKTHgw?=
 =?utf-8?B?dXAydy8wNUVscmZKaXNCY1gyRlhzb3VsSUVoVlBkWkpBeXpOdktOcXh0dlU4?=
 =?utf-8?B?RFROcXZWaEErVnZIRHNITzVsUnZoNWgyMUwrdlN1RjJVeHpJaFd2QWlXUjZh?=
 =?utf-8?B?bVg3NEpYWjZPNVBtL1BXUVFpaitsM3E5cWRwN2FSRnlPU052aUdneGhHUkFR?=
 =?utf-8?B?UEEvVm9EbzREVzlnYVcwUlRvajFkMFNuVGxKRzJhcjZIeHU1bklYc3pNekZI?=
 =?utf-8?B?eDRLMk9zL1lCRTlEQnBWeG9LTDFFaElxSlJPK3BUYWJPLzNEOE00R29FYUcx?=
 =?utf-8?B?bjBiWXdFQ21Mam9ia2VFUEp3KzRJZkRkR0JVMFY1VFpTY1gwejlFL1lSUkx1?=
 =?utf-8?B?bDlGWm5vS3hKMC9TTmZzNWhYemFzdmFHc0I3Z2RXTFdpN0JZc3gwNkEyV2ly?=
 =?utf-8?B?ZWNkREQyaGZDOC8ySTl5aU1qRXNWdkxQSE9UYW9ZY1g5ekhIaTVNUDAwS3Na?=
 =?utf-8?B?S2I0cSs2T1I4QWZQMmVDZVNFeGZyc2xtazBQaVYwRDBVSXBMR09JeEFjRFVD?=
 =?utf-8?B?OEVtQk5nRGRzUUZPalFwNFRhSm5BZjZWYUVKR0dxc2xLb0Q0Nmo3T3RINWgy?=
 =?utf-8?B?cWtsMk9Fd3haMllZR1ErRDBlOUZUWlBjNE02UHQxeVNLbE4wdjFGVXJwY2Vx?=
 =?utf-8?B?OHg5WXRJLyt6Zm0rUVhzVk1RWHo1Q0czMFpZU1kvN09aczBrTGxnRDBSTlVn?=
 =?utf-8?Q?59nfXuBk2RA0/jfcrfJcyAj2SOXNLjLK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkgwK21uNkJvakowSlRZVmNOUnJpdS95RFVQaEpxNkxmMnROTG04K2hlQ1d5?=
 =?utf-8?B?MjY1TVZZbmN6MzhXZGF4VFJoWUF2U0VNWk81dUhxNVRwVnQ5QWZEUGtIQjJa?=
 =?utf-8?B?UVB5cWU5YlNDeHhVMGpxWkRkcFY1RGQ5UG81S093YXFidUNaeUhWSndZc3Qx?=
 =?utf-8?B?WlpwYVZUNmFyenNONmFEQlVoaU9pNHhyK0N4WXBKRGsxcXJCMmRaSGw3bnB4?=
 =?utf-8?B?QktSSEhOSW9hcFdjc25MRHE4djNvb284WTFlbkJBN05nSkp5OTZnSnJPbnN0?=
 =?utf-8?B?aERGWnludEJ2ZUdJUFovUW1WZ0p0QkNUWVFkVjI3M293MGVTczBsT1Z2SmNR?=
 =?utf-8?B?V0xpajdxN3hkOFE3QnVrMEpQNk96b3ZGdXBZaktHays5ZU1vdnJLSlhrT3hp?=
 =?utf-8?B?YnYrditQa0RUU1drQUsyaE5XWUt6NVI4dlNjbzRNbS9UY1pkZU01M2lObWJw?=
 =?utf-8?B?SENaZjBpTGVIQjdnenNwLzgzdGIwSW43bGZRczhySlNSakRZWXNTOTBiU1BR?=
 =?utf-8?B?WDNuTFhKVzkvcXlMUjV6bnFLMHprTjJvSkdhVnk5dEt4SWptZWE2c3FDbTV1?=
 =?utf-8?B?UWlWWHFpRC9SUDdRV0JhN1dOSmxWTDlCN25HVzdZTmFaWFhUenVLdTNWa3pI?=
 =?utf-8?B?RkN2c1BmNXkrMVVHSEZCNUpjWnpielNqTUUrTlBNVkpWUU1Gc0RLcVFxUVFz?=
 =?utf-8?B?RmlocXQvaHZ0azBqRmp2RzB0YmxCa3FRdENoeCtQa2s5SmVHaEZ6ZHEyRW5N?=
 =?utf-8?B?UTNvSnRkNnNDNDBTbEtpRWRIdW1TNU0vcFpzNzN0a0pPcmpOU245ZkxYZTd2?=
 =?utf-8?B?ZHN1SFdaVTdRcWJTL1R1c2wrL0lZM0RsVHM2bFU1Ukh4R3RIL2p5alB3Z1cv?=
 =?utf-8?B?ZGp1NkhSQTlUdzc2UDZFd1dYNmVpWDU4cUhGbHFyUDFWZ3ZEWjZrc3BISW4v?=
 =?utf-8?B?Sk8rNEUrOXhrazRSVVN5MWc0TlVFajlMamswb1IrM1ZqN2drTlRock1seGN4?=
 =?utf-8?B?dU9ZVk5kQ3VBc00xZGJyRzdmKzhBUlFhMEUrOThrbnRrVFBVdlFHTHpFUU9Y?=
 =?utf-8?B?eEQ5bWJBS0hvaGl3Qk14TTRSYU1OMGx3a1lSNVBWSlh4WVZXV3ZIdjhoYlJE?=
 =?utf-8?B?WmcxQnVtOHlpc2VSU2ZRS0E1MmNLN1pTN1NodlRQOU0zekNtSUpuWW8wUWdN?=
 =?utf-8?B?T2FqNTNVd2NETUw5Tm8xV1gxbENsV3NOWm5weXZnTUs4bDdqNmpSNk1rR1Nh?=
 =?utf-8?B?OGJrb3V4cTl4TEltTzRiL0hkZ2RZaHRGSWtMTGJNV0twMjBZTUdDdSs2K3ZE?=
 =?utf-8?B?NWtMNjNzQVlZaWdoaldVZXdZcnEwSVR3RjNwRldGMDRuTlplOE1za0dBU25W?=
 =?utf-8?B?N21CSVZIdnFVbXZlWG5ENDg2WkN1SjNaMm9TQ0V1ajB0bUtSUWllaEtPczJ1?=
 =?utf-8?B?L2lnbWdSb1FzaXpRaEZwZUF2M1VDMVF0SEtTeUJxOHhPUmtOQm9qNHYzU1dN?=
 =?utf-8?B?d0lHSkZmVVU0Z2tlTE1qeEVJRm5rQ280OEJ1ZWZUODliY2tOYUxMcmVSYTlj?=
 =?utf-8?B?Kzk2RjdYMDdnTzZPUE9SOEpqREpKUjZiNCtoZDQ2c28rWHNmc2lHaHd6YXF3?=
 =?utf-8?B?NWVmVTZQKy81R3pTOFA3V2V5Qkd5SGlqUmVBRVpvdGlQa3hoWU1JNFJiMVhs?=
 =?utf-8?B?dWkveFJ2c010WG83Ymc1Q1pNcGxDdzdjTWFpRVpEVTd2NjBZTEE4c3Nram1M?=
 =?utf-8?B?bk5Tb3I0d0xEUWwzVHRma250aXV1R2xocHFmc1Q0NHkyNCtPaFJhcDJpRG4z?=
 =?utf-8?B?OTRMQmxkL0ZlbksyM3lnTXAwcmdDSEFaYndXeHdFbUl3akZSSzEwejFkVzZQ?=
 =?utf-8?B?SVJSa1dlN09ISVluUFl2bGozemJXQk51a0tEN0sra09SWWpCTjlnZ0hMR2pT?=
 =?utf-8?B?UFI5bnNldmkycWtNdExncm14WUhPUFJEbjVvWmpEcHhDSzlTWjVFb1lFdDhY?=
 =?utf-8?B?Z3NjVzdEVHVOVmdJeFZqWXZHTDl4cEN2ZVpJUVhRVzMvUmFKRisrZ1g0cVZ3?=
 =?utf-8?B?MmhpcWplbUQzbHIvNnhZcUwyK0UxYWJYODQwbnlHdHJMdGFDelM5Qi83NHVE?=
 =?utf-8?B?Mk5BMVNRYjNBaW0ydmtlZ1VhcWs3eVBybnZNUjljSjc3bFRVMjdERjM1ZE1G?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e8fb05-4d13-48bb-64b5-08de1cbac6cd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:29:26.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht9TFdMt2cNRdk3iqcj9WqyM+fcKw/1QPu3qbVJKDE+wMiu3ODODtrnW0ZE63tXR0ZXc6KWAldW4R6mpXeqcn7FNqUTb232Ec2aw8FQ+HWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com

--------------QLykJo7O8f2eE36bgLVjBAnP
Content-Type: multipart/mixed; boundary="------------lVvosmnhHcYoDQxR7EF7gDma";
 protected-headers="v1"
Message-ID: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
Date: Wed, 5 Nov 2025 14:29:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
To: Nate Karstens <nate.karstens@garmin.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@treblig.org, mrpre@163.com, nate.karstens@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 tom@quantonium.net
References: <20251104174205.984895-1-nate.karstens@garmin.com>
 <20251105173434.1404676-1-nate.karstens@garmin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105173434.1404676-1-nate.karstens@garmin.com>

--------------lVvosmnhHcYoDQxR7EF7gDma
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/5/2025 9:34 AM, Nate Karstens wrote:
> All right, one more time using `git send-email` (plainly I don't do thi=
s every day)...
>=20
> Sabrina,
>=20
> Thanks for looking at this!
>=20
> I'm seeing this on kernel version 5.10.244. I know that ktls on the mai=
nline kernel has moved away from strparser, but I think the change would =
be useful for anyone still using strparser (both for ktls on old kernels =
and other users as well). It seems that, because head->len was cast to ss=
ize_t, it was an oversight that skb->len wasn't as well (if the intention=
 was to use unsigned arithmetic, then there would be no need to cast head=
-> len).
>

Right.
> Here is an example of the values involved with the test I'm running:
>=20
> len =3D 16406
> head->len =3D 1448
> skb->len =3D 1448
> stm->strp.offset =3D 478
> (ssize_t)head->len - skb->len - stm.strp.offset =3D 4294966818

So, without the ssize_t, I guess everything switches back to unsigned
here when subtracting skb->len..

I don't quite recall the signed vs unsigned rules for this. Is
stm.strp.offset also unsigned? which means that after head->len -
skb->len resolves to unsigned 0 then we underflow?
> (ssize_t)head->len - (ssize_t)skb->len - stm.strp.offset =3D -478

Where as here, it resolves to signed 0, so we go ultimately resolve to a
signed result?

>=20
> I'm happy to update the patch, how much of this information would be us=
eful to include in the commit message?
>=20

If we don't actually use the strparser code anywhere then it could be
dropped? But otherwise I agree with Nate that we shouldn't leave this
mistake in place, even if its not actually used by kTLS anymore.

Thanks,
Jake


--------------lVvosmnhHcYoDQxR7EF7gDma--

--------------QLykJo7O8f2eE36bgLVjBAnP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQvPxAUDAAAAAAAKCRBqll0+bw8o6A2G
AQCuXQt+p8NTC2NofqUmokSxOX43x0uqj8Ykqxbcl2T8+gD/TtvfXHN/4SAGKDVfLMGIz9uj/hRl
/rRUmL7bp5BGLQE=
=Fm/U
-----END PGP SIGNATURE-----

--------------QLykJo7O8f2eE36bgLVjBAnP--

