Return-Path: <stable+bounces-195127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AAC6B692
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EACF734C60C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF32EBDD3;
	Tue, 18 Nov 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMsD0QYy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212252E1EE0
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493196; cv=fail; b=qQEEYaOEVont01Vz9H9M5pAqTnJManuJkc2uWPaCd+WIYr8r9RCnvM/TeuHzkk34RANyaAhbvmgPWBsAR/8gyVv2VquAGJaEXiM/uaqXMnH17PW5YESBre7Q+Ji1cHQxcFymLmth1ABzr251HFuWL6XvXKGxGmC3HEh3Q5w+QhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493196; c=relaxed/simple;
	bh=aieh4Y2twJ+09kBolE1BF/jj0BqHub9gEiHQd6whFVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmQol01wEqj56xBjorNmxbADFpJZEl+hIDe5rvf8iCgimQw2TRmvZEa4xtL7/v1hUsZjP64RmtMkQpcAX4oP6+i1TNp2QVH2ZIYScqIzCrWlwzndIHfglVJkvA2HaPSTAyHsyfuyVvum+yzhpOVqU/LVc9uKX//bpP1qZAK6nP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMsD0QYy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763493194; x=1795029194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aieh4Y2twJ+09kBolE1BF/jj0BqHub9gEiHQd6whFVI=;
  b=XMsD0QYysKSCFE3USmBUkCDrPWZnrtlULxPmd7gphTJEJ8mQ+82MhmN+
   8Qkght17W8FsdZb6wnCLuJ2bR2CYtivpnDjnl/zRVdB/x/+jmTUu9Jzvq
   Xgtx7xcnM21phxMLjM8BjXZ4EIJNGbPJzMFNqU5LD2JySZPgz9e5NI39S
   cK/2Y1S13YVj1pfQbU/gfNg3WwXtFyr1l0L8nCPYfxrRkgQvBBfcEbUCx
   pd7tAPCjFDCpJGK3/0bJ/BnIRnbljwbA0tVA3HR35TlBUnoW8AGA7i7BF
   5AMbYX1YwIYrwXME4raMcx8VUhRS4jmAt3LBHmOm1/H9Vg1braLlzRo/S
   A==;
X-CSE-ConnectionGUID: o2pcEQNMTh6oiRLWkQGcTg==
X-CSE-MsgGUID: dzRhSNkdREiyU7qw0o4JAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76136233"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76136233"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:13:13 -0800
X-CSE-ConnectionGUID: bidCt49vQlOJpHx/s+6JEg==
X-CSE-MsgGUID: LuGerVkoRTWsDEMHxBwD8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195304776"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:13:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:13:12 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 11:13:12 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:13:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQrbQ3nywxgRotr2SoMlf6pkJb79BoYEreVR+kPsnsWprLvWyHTMMU+T4zX965J2+i03fsEMyM0OwjNMC7q2CuW7ioP1pv5AckzllLX4bhGzvDSHs6x5tH2RwKGvKrpD13MiEgwgMZj3by0qDCEUspxGB/fj1NBWDf16u0rLyAClNGUBby8rBIyGw2KqjXiEb26P/zBZy1OtueU7hDPYNb+RCqQmkJU2dpnhcQJ+xe2u25ZXZ8yGGjw9E9cVmbwbqYToq4RUaHXPywIj/TNFFra483lNny+oHxJG+6I0AOGI/pLdhDUSumsyYpRvxrjj42r13XuSIlNElKU7poqNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aieh4Y2twJ+09kBolE1BF/jj0BqHub9gEiHQd6whFVI=;
 b=uFP1VJsmjVzW3LqHMc+avXRC60U9vQbbf2hd9dv6ZG1i5JMnq7uv7g1TFFihQwHV1HVeNJ+oOCfDw580kHWMRrL3ctxQwolFl8S03rUF1quIlRJJZMxXme6c/PORqBFBW+IrvrVLNh2Lj1NK6W/BJU5/t9bcg8lSFpgyp/DaGjgM8jq/pBAXQm7kb7c6u+4okdxCFtjLLlabWJh6hWLR+T6ZTUAftBsGKedtKOfFe0pdkV9pDGknnrZyQM3RQUviCJcJ7k2ZvyksAEinvEnX+WNML/zQMXBcy6SVNR9Tshsc6MzcMLRHs5q5bUHjoJVpDGlZUbRj7MlVU8DyPbhLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 19:13:10 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:13:09 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "Ghuge, Sagar" <sagar.ghuge@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Ceraolo Spurio, Daniele"
	<daniele.ceraolospurio@intel.com>, "Wajdeczko, Michal"
	<Michal.Wajdeczko@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Thread-Topic: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
Thread-Index: AQHcWL7NkYmkeZfCakm2feQqaxPhvLT4zUEA
Date: Tue, 18 Nov 2025 19:13:09 +0000
Message-ID: <603e1a4080dc0fcc126ed91c9f4e87c81e63a803.camel@intel.com>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
	 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
In-Reply-To: <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|DS0PR11MB7384:EE_
x-ms-office365-filtering-correlation-id: 7425113f-641b-48ac-8f3e-08de26d6832d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d2VaTmplaUU2alFEN2x5SHREVHJuaW9wRVZRY2xZWEY0T0ttZXp4Z3ZqQzA1?=
 =?utf-8?B?N0ozYVJHZ1BQd0cvODlRdFA2bjQrME94clJENkQrOUd2UEZVNUlHQjFQQWVn?=
 =?utf-8?B?OVBoR1lVVDNSczArMVJ3bWNsS0ZFd3B1eHM1K1dEY3pyNDQwZ09LQ0xhWkNI?=
 =?utf-8?B?aHRxN3h2SzFvTnh6bGZWTlVIN01keXlYU2NYTjIranJhQW5FcjdnRSt4OFB2?=
 =?utf-8?B?VHJtak4zS0oraklwTTVxMy9xSTV2SkhoRE13WDMyTGtJMVZ4S1lsazBxRmZW?=
 =?utf-8?B?Vm1sNDBodVF1SEZacGZYQU1vVWlLREJFaUMrb1NNRWlwaHdCcFdiOEptOHdZ?=
 =?utf-8?B?TmpMbUdrUi9ITXlwazUvUHNpOHF6UWRGL1lkSmJrM0RMTnc4OHpCQ1pmYWZa?=
 =?utf-8?B?YTBnMDNIYXpvSWZUKzRqZHJDZ3FkU09YeGhHTWdpRTR4RERpZDFrSFNxM2s4?=
 =?utf-8?B?RGxJSFNmU2F6N0M5V0twK1QyNkNDRFRVZTk4UUNCdkdUVTkrN3pwVFhZVG0v?=
 =?utf-8?B?aG9UWUdrVEhKdkwwZ0F1cEV0WlZxdk14dENPSmFtdFZsQ0l6OEJTS3hhZUhi?=
 =?utf-8?B?TStkZmlFc1RhT1hGa0pkUFplR1drRG52T2QxbUF2UE94Ly9UbjBEbDQzMThT?=
 =?utf-8?B?RXVobnpLSWZsSVpmdlB1cklGaExyVzBNSkhzREFCaEFsRVRpWjRNc244K1pZ?=
 =?utf-8?B?SEFVekNZVVNIY0RUQ3FCM0kzcjFoL3FrOUtRQVliNThsT3VrMS9DdlBKb3dr?=
 =?utf-8?B?MEtieDNaQWV4dFhWK1c2WENtd2JFSTNzSFVpQnVodjFwR2doZTMzMEhCVkdU?=
 =?utf-8?B?bkJvQ0FGRVkzQTZGVkhkWURKOUU3SkJQbm9BRWZxU1RYMVJBTnNQVE41ajQy?=
 =?utf-8?B?a2k2dlJGb0wzME16Q1g2TkdCZHpmUGJ3WGtnYlYvd2E3MkFKSlI4eDNsSlpG?=
 =?utf-8?B?b2ROdjFBRXNsQVMwTEVPSzFvODgreHV6ZTZqQnAwM1JYR0V3R2xxemIwOUdj?=
 =?utf-8?B?WGZBY2FvMUduMWtoVlhhdHc3c1dtSzY3ZjQvd3g4V3Fvdjg3aWpnei9kNVR1?=
 =?utf-8?B?RHlFalhsYnJNc2wrVnVleTIxQjRVZXc1d3ZOYlZ1RkRGWFR5bGN4UnV6WmxW?=
 =?utf-8?B?ZzBUVWZicFVRKzdxVndjWFBNV1A0UVp3R3J5bEs2ajV1SWR4aFdSM3ZyUTgz?=
 =?utf-8?B?Z0JFQ1lwK2FiWFVWdGZzdXBJbm44NmJJZmEwNk5lVjBxN3d4ODRzMW9LVC9Q?=
 =?utf-8?B?OGlZdlJ3MXJreVlLTzhuU2Z0Y2FoL2NzUm5TMXNSV2o0c2tLWE9LelNQZlVG?=
 =?utf-8?B?alNXVTRZaEtYY1YxbzYrYVFaYmJLSTNZRDhBQlhCYlcydzlYT3hrNEo0R0pk?=
 =?utf-8?B?NjZKMENTTzVIdm9oTU1hc2NkOEdYbXdYakY5RFJVZmQrdXBxOUdVUlRkRHVL?=
 =?utf-8?B?eHphSS81YTh0RktDN1Y0ZHdMa050YnAzaGsxN2VXU2xpQ24zS0l3ZGVqMjdL?=
 =?utf-8?B?SjE2K1lBbUtEYyt1RitaaEhUYkhuemkwanZRWEZsUmphNnpIN3JYdUlxQWlo?=
 =?utf-8?B?dEU1dlhlRHdrTU1NOUN5V0NqeldleUNaWWlmQ3U2Z3VlY3NRaVdpNTlMTjE0?=
 =?utf-8?B?R1VUcmlvL2h2WFVxc2dTQ1BTWjgvTG00Q2NjbDJqdVNJSTU3R0FNZUVNUVds?=
 =?utf-8?B?cG5pQlBPWG0zRjdHT2gvdytrV2gwQUZrbmZaVGdyRzRDSk1rdkRpMTJ5Y0NB?=
 =?utf-8?B?anRlN3VCdFJXa3BZOWRXRnJhREQ0V1BFa0puSGtjeHlrRjFNUG93NWUrKy9x?=
 =?utf-8?B?UjUyNDNlNWw3T1BJeEk4SnQvWUhOWG9EWUVGWGg1UDQ1T2ZrcVI5VDlsTWZ0?=
 =?utf-8?B?cnZ0YnFwZXptWjJJQkZJWTBpNXVkWXB5cWxjZlVIQnYydkJXUHdGQVY1S0l3?=
 =?utf-8?B?OThCaEZWRk9mRlJjTmxOM2o2dkhVWUMzMnZtTkx1L2JOb1B2aTZ1Y09jNXZR?=
 =?utf-8?B?OVVGd05OMXlWVHUwQzc2ZnJwY0p0eUJwNWxBNXlXeFVJSUhoZndqYURZZmgv?=
 =?utf-8?Q?koi3FJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0ZEcUhta1RhQkR4TzRHVWJTOCszalZpZkVUYkFuYXRwcDR1djM1c0x6aXdY?=
 =?utf-8?B?RkNKRlR0bGVNMWdmWkhmNy9GT1hhMTRUNjlkY0IzRVBTTWlZOW1vd0E1L1ZI?=
 =?utf-8?B?eE5UeEZhQ0M2RkRkU2NiMGtmR0hKdHVHbTRhN3BNVjZXK0F4Vk1IMUVaVmRq?=
 =?utf-8?B?cmRIbUNyOTFXMk5HYnpPa1Fyb1hMTVozRmlEZGp4Qmw1WTVVak9hSDdlazlI?=
 =?utf-8?B?SCtJM1lqNExrVVlUR3hXaHkzN21nOTFhekN6dGhySG9jY2pEcnB3dmVQeWox?=
 =?utf-8?B?QkppQXBGVEIvdm5SWk5TTnQrc2JrV0h6U0dhS3hLZkZUS3p0RlQrNGFxWmJQ?=
 =?utf-8?B?Z3dxMEtHUGY3SUU4SVVCQmZscG5uVElINERhNzc1SUlXRGE3aVYvNGlOQUcr?=
 =?utf-8?B?NDhkY1VqTklCZjF6YWtOdDRBcEs2WjZGODhUSytWV0Y0ZEJEeUZqRWQ3L1F3?=
 =?utf-8?B?SHBiTGNwWE5YdkYrVzVCbVZXd2c0UzQxTWtlbXFuN0wxbXIyNjZsQk1aOTJF?=
 =?utf-8?B?RUJZZXEzYUFVU3JzVk5JMm9BTlVXQ2wzeFVvT3A4QldVeE4zWVNvZHNlV3Yv?=
 =?utf-8?B?SkJ4SXEzS2YreHdVT0lLckZWbjRERnBoUDBURVFqcm43eWQwQTNzRGxwdkVl?=
 =?utf-8?B?eTZOWEtSRWpoRUFvNk1GSXkxTitTeFMwL0trdDNVWHhXckNvMWdETFJ4ajk3?=
 =?utf-8?B?eDlaVC85RjFTOVp0elIrb2ZRNHVlVThNU3kvYWhVczNWN3I1dngrVnlJU2s4?=
 =?utf-8?B?ZlRRZXRBa0IxazZ6STNzd1A3bTJVT2QxTGtoSmlwM2doUm5nUVg3eTNnTDk3?=
 =?utf-8?B?K1A1dFFKdXNnRkNoS28rRUFUdjVLUjJ3WjhES0RZNGpNdXZxeEdQVS9aUTFw?=
 =?utf-8?B?UEVtUEVpa2JwbGFjUGNiRkgwazl5RXJKWmdFa1NCTEtZcEZjMS9HemNZcXhK?=
 =?utf-8?B?YlFYR3R6Q2tMQ3RNNUtuTVM1ZlJSckpqdjZFODlZa2x6NkdsVTRyOHNqVkhT?=
 =?utf-8?B?dktlZ2JvUlA1RDBiVElZd3ZaK05vM0tHTk5XdDhZQSs3WnhNQ05wTlI5WG5w?=
 =?utf-8?B?ZGFnZlFzKzZzZjc2QTNuMGljazBzMHk4ZnVSSmRXNmh4OG05SmN6S3QxQURN?=
 =?utf-8?B?UUhXVmJWMTN5L0E1QWlWVmM0aGduRUFrS21oQndJQXZVWENUMkhsS3RzdW9G?=
 =?utf-8?B?UVJoSjVTQzRqVDRrMVBMNjloTjY5MTJOVEV3SnErSjZTUU9RdkVsQzlURTZT?=
 =?utf-8?B?MzRlU2pEa25yaGpNeXliU0NVdXkrYUhOalpaNEROZkw5VmYvZWQ2cGFqalJ0?=
 =?utf-8?B?R1h6V2l3cDZTZnJ5Wm1pUFpnNVIvOW9DcGtpUnUzUmkrN2tqTHlMQUxEMTNM?=
 =?utf-8?B?aWdJQVhzeG1sWHpHems5ZVRCU0RCbElSMldpWStpdDVnWEZ5bjY2Tm5EQ25o?=
 =?utf-8?B?Mkk1eWJEOFVqQ3lzT2QvVGF5QVJzbTR2b3ArQ0hBaHhBUlNrN2ZNZThxaUlY?=
 =?utf-8?B?cE56WWUvbTJFQmd4UWMrc0M5UWpkU1FPZWlHNFZ2QVRlcm1BbXdoUXlJK0RD?=
 =?utf-8?B?aDJVZVZSS2kvYXVCRFUyTTdKdEkxTGJuY1Z4YitsKzJYRDFmUllNWnFnZUE2?=
 =?utf-8?B?dnBsZVNLSjQreVVubEF6aFNJNTdKTkVIRlZkV0dsbm5vNnNzWjZjUmg0b2ly?=
 =?utf-8?B?RCt5QVkySlEyTk9QcUxQdFNiZWxrM2tEcjVLb29la1dhTFpzYU9KZHl1Qk50?=
 =?utf-8?B?aEJhYmNVU2Z5cmRhRXFRZ1RuY3BocnJHMTJMTWFBb3BsNWtFdWx4OVJFOEpk?=
 =?utf-8?B?NmswRkRabThYTGU1S2hzdHkxcWlkNjZVRnRoeCs0eVNwcmp6L2x4UDBnMUU5?=
 =?utf-8?B?TWNZZEtFdk5kdFBnL3gwWCtYWFZsY01Tb2xLZU0vZmpWMFlSR0dnOWdaTXBG?=
 =?utf-8?B?ZG9PRkZsRVlRNXd6ek4vLzB2cTM2ZUF6TE8zK3k3SUZqWFVQam4zZGtINktO?=
 =?utf-8?B?aWtvYVVIUHU2ZEt4cGY1M3FHSG5sSSsxZ01uT1h0NmZiZ3BoWVB1MGFuNC8w?=
 =?utf-8?B?YXcrV1pqWC9LQUU1dzNRc3EzaURMWFNhRS9MY2pudCtYOHYvYVhJTnFNTEJI?=
 =?utf-8?B?RnJhcExwTldFSHByVXBZcTJyWmpwKzVXTERzOWxmalFzZXdXUVNUTFdrTFVu?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FB1FAD5692D2A47945A61C1FA687957@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7425113f-641b-48ac-8f3e-08de26d6832d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 19:13:09.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ro3oMaBGj6HVD7avyP8R+Pm2Y/4K+ika0Rt+iR9fzjnBR4xVb9zWgO7iNOfJCotwKVg+MHC41UrDMEtkDW9WP3S/GJBU6IrtQc0kmrPEJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTExLTE4IGF0IDExOjA4IC0wODAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IEFkZCBtaXNzaW5nIHN0YWNrX2RlcG90X2luaXQoKSBjYWxsIHdoZW4gQ09ORklHX0RSTV9Y
RV9ERUJVR19HVUMgaXMNCj4gZW5hYmxlZCB0byBmaXggdGhlIGZvbGxvd2luZyBjYWxsIHN0YWNr
Og0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoFtdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSwgYWRkcmVzczoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiDCoMKgwqDCoMKgwqDCoMKg
W10gV29ya3F1ZXVlOsKgIGRybV9zY2hlZF9ydW5fam9iX3dvcmsgW2dwdV9zY2hlZF0NCj4gwqDC
oMKgwqDCoMKgwqDCoFtdIFJJUDogMDAxMDpzdGFja19kZXBvdF9zYXZlX2ZsYWdzKzB4MTcyLzB4
ODcwDQo+IMKgwqDCoMKgwqDCoMKgwqBbXSBDYWxsIFRyYWNlOg0KPiDCoMKgwqDCoMKgwqDCoMKg
W13CoCA8VEFTSz4NCj4gwqDCoMKgwqDCoMKgwqDCoFtdwqAgZmFzdF9yZXFfdHJhY2srMHg1OC8w
eGIwIFt4ZV0NCj4gDQo+IEZpeGVzOiAxNmI3ZTY1ZDI5OWQgKCJkcm0veGUvZ3VjOiBUcmFjayBG
QVNUX1JFUSBIMkdzIHRvIHJlcG9ydCB3aGVyZQ0KPiBlcnJvcnMgY2FtZSBmcm9tIikNCj4gVGVz
dGVkLWJ5OiBTYWdhciBHaHVnZSA8c2FnYXIuZ2h1Z2VAaW50ZWwuY29tPg0KPiBDYzogPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTcrDQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIERlIE1h
cmNoaSA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogU3R1YXJ0IFN1
bW1lcnMgPHN0dWFydC5zdW1tZXJzQGludGVsLmNvbT4NCg0KSSBiZWxpZXZlIGluIENJIHdlJ3Jl
IHNldHRpbmcgdGhlIERFQlVHX01NIGNvbmZpZyBvcHRpb24gd2hpY2ggYWxzbw0KZG9lcyB0aGlz
LiBJdCBsb29rcyBsaWtlIHRoYXQgc3RhY2tfZGVwb3RfaW5pdCgpIGNoZWNrcyBpZiBpdCB3YXMN
CmFscmVhZHkgaW5pdGlhbGl6ZWQgKHN0YXRpY2FsbHkpIGJlZm9yZSBkb2luZyB0aGUgaW5pdGlh
bGl6YXRpb24sIHNvDQpzaG91bGQgYmUgaGFybWxlc3MgY2FsbGluZyB0aGlzIHR3aWNlIGlmIHdl
IGRvIGhhdmUgdGhhdCBjb25maWcgc2V0Lg0KDQpUaGFua3MsDQpTdHVhcnQNCg0KPiAtLS0NCj4g
wqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
eGUveGVfZ3VjX2N0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2N0LmMNCj4gaW5k
ZXggMjY5N2Q3MTFhZGIyYi4uMDdhZTBkNjAxOTEwZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX2d1Y19jdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNf
Y3QuYw0KPiBAQCAtMjM2LDYgKzIzNiw5IEBAIGludCB4ZV9ndWNfY3RfaW5pdF9ub2FsbG9jKHN0
cnVjdCB4ZV9ndWNfY3QgKmN0KQ0KPiDCoCNpZiBJU19FTkFCTEVEKENPTkZJR19EUk1fWEVfREVC
VUcpDQo+IMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaW5pdCgmY3QtPmRlYWQubG9jayk7DQo+
IMKgwqDCoMKgwqDCoMKgwqBJTklUX1dPUksoJmN0LT5kZWFkLndvcmtlciwgY3RfZGVhZF93b3Jr
ZXJfZnVuYyk7DQo+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfRFJNX1hFX0RFQlVHX0dVQykNCj4g
K8KgwqDCoMKgwqDCoMKgc3RhY2tfZGVwb3RfaW5pdCgpOw0KPiArI2VuZGlmDQo+IMKgI2VuZGlm
DQo+IMKgwqDCoMKgwqDCoMKgwqBpbml0X3dhaXRxdWV1ZV9oZWFkKCZjdC0+d3EpOw0KPiDCoMKg
wqDCoMKgwqDCoMKgaW5pdF93YWl0cXVldWVfaGVhZCgmY3QtPmcyaF9mZW5jZV93cSk7DQo+IA0K
DQo=

