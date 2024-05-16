Return-Path: <stable+bounces-45243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA78C714C
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 07:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D531C22496
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39D12B83;
	Thu, 16 May 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klbdN5+E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1211721
	for <stable@vger.kernel.org>; Thu, 16 May 2024 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715836366; cv=fail; b=d5S4Qzj1xr+YmnypfbLZfPXdRcxch8ihYe4KjQ0h7X6hmCn4ofpcvkKW/T7box+ooM7z5KfMyrvvnY7YNiXxyinFSZK1JbOR4i8syqT2Et2SHCVB+WJYV7SGDSuDK+w72wJCFcFpZR2BtB+8AHtD3dTcKcjIkJlu09jIUaxyL9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715836366; c=relaxed/simple;
	bh=eoD7LBkVQrx2iHaEnI8QXUwW72V/SWvnyOPCkFpnnSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJU3w06pOIEu/ErCC4p64AuwFY+s8Szsb3lM2FclALpzb4N4dHSBnDg3ndmDnB80IGsun6TwVphTxh6zVe30RGXYqvMUd7EjpYDD4T6LzG8XIsONqnHanN2rrZjL1KKxPuapPnIGtEY47uRpCCt7t3PsiZd118oBc0ZIIZmE6q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klbdN5+E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715836365; x=1747372365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eoD7LBkVQrx2iHaEnI8QXUwW72V/SWvnyOPCkFpnnSk=;
  b=klbdN5+EOPoU7o6zjwynyczSo+0gOqvnW1Mr4n0TPAMwS9+ITjLCraST
   eloMT9eLfhkLQKCBokAfdTD7aROnlswVLw/cZPpGPfFWb25fCVrrW5GrX
   yB/O4qdKDsu+C9c8c0CZJVvQjnLxhnwN5MNYmHbN15r6GTIMDM1vEjzIT
   c+kmdwkUWPdUM9pdLSnsZbhNPWZRGfgHKdvQg9C0x+PiP5Hfi4SIrI8rB
   nL6/I69oAnWHwZ1eYAH+/VvOUpS+BYiuz5rWGDl4ANQyIgfZ68gCOsXdB
   Xn6QeYphXphP2s9MKtfsHRRLwF61xTbdS4Eh4+njbqfjr0vbjUqUF4EQW
   A==;
X-CSE-ConnectionGUID: MwJSvgPKSlS1SbUHrtDAgg==
X-CSE-MsgGUID: eNR1nuDgTOOjoB/Ro6lczA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29420651"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="29420651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 22:12:44 -0700
X-CSE-ConnectionGUID: Vjvvr4liQfCQnVZAYo3DIg==
X-CSE-MsgGUID: dHcODl/lTlOIiRjHE1TARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="35821033"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 22:12:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 22:12:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 22:12:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 22:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTNNvfKN4zoqk1AqX4SIKf+eoPfkv6+QV2LAmZAzyxglJv0Xt8cHtfE7kjzCF4NwAGUxLKVMMTkzxjBovnZUH8Kf8NVwfm8598n3kRN5zxRD2L1Gg6/NkfNTipUXEsSpPiZCG1dhK8oOgtLnyA+B3YStW1ptt++C4MuAseUGvGe6HHGuLn+zR+4k3fJoW5Qa1PTxwLC56U+Hx1mhpn7p3SBn7ujG8bSpVKCoHQ1/hH11fdjoy0TRByYZNQQD4/k6JdqJpzs/JlECI0kj0e++8ET228JLUMEdyh6L1TzME2TgXAnC1W6hvzhW8RYASabd0H0kg3cd0Q4CrsM9467vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoD7LBkVQrx2iHaEnI8QXUwW72V/SWvnyOPCkFpnnSk=;
 b=TXJY425qW7C7IjTPo4vHWkL2jwAsWX2pIRflnP42KV827FKPjn91L8CPuUu4ijs39hfWS2MrLaHHcc8ghwCy7PcAFVslUk20dTvhJVSo8Zo7aCDqvyN7NupfNGT/Q5Y2rXecG8luCUYRfq7oJEoKt7NYhNfs/Hc12viEExT55IDSMZ36DvcFReyxJgWhZUhjJVG4hYhmMOeTxN5oVdjPTZ+8tuPdUNgHoHvHtIWaspXOEFrwpBX+UZJGq+GNvstvCa9BnxAfYz+o+XQg4HJhfEWVxq3q4G18ZVBDZw3HaG2kVV9lVqgocHAeH29/jD09EgWR3UYlm//kbwYesvaiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 05:12:41 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 05:12:41 +0000
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>
Subject: RE: Fix Intel's ice driver in stable
Thread-Topic: Fix Intel's ice driver in stable
Thread-Index: AQHapw0zNbaY8mgdO0mi/asWuTAD/bGZT/Cg
Date: Thu, 16 May 2024 05:12:40 +0000
Message-ID: <PH0PR11MB4886A5132BDFF44F0BB12577E6ED2@PH0PR11MB4886.namprd11.prod.outlook.com>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
In-Reply-To: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4886:EE_|CH3PR11MB7370:EE_
x-ms-office365-filtering-correlation-id: fe5f5c67-40a1-4ac8-7296-08dc7566cf8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z0lEeUtFVjByUGNES2duTCtkVDF0UkZ3K1F5ZkVpQ21icU9zYWdSOHV4eHlH?=
 =?utf-8?B?aWt2a1dXbHFUVUI0TERncVMwNlpSM0YxYTAwSWZFQW1GMU05T0w3YlN2L3NH?=
 =?utf-8?B?eUUvMGJiaVRvcjhSdEM4NkhGc1NEaDVxVll1Q3AxNFRvVmIyTVNZaVF5cDI1?=
 =?utf-8?B?V3VWVnNlY0lyVFFLVkN4d3pSKzd2czRUMGtkcFlQVFpVYVZYRnFtL1lhUnFY?=
 =?utf-8?B?VlR4TTJpL1N2aVBWUnZwd0NSSW5BMWRXK2g0VDFkYzFuQmk0dlRMVnUyUFF0?=
 =?utf-8?B?YjhLaUJqWXZIbkU0UVcvRjNmQnh6NzkyOEwwMTdHd0UvRysxR2dOTUg2dHF3?=
 =?utf-8?B?WGlUWWZhaSs1ZWdCQWFsSDN0WFdYcC8wUkJoUjgrcmRZaEUvMFpYd3R0alVS?=
 =?utf-8?B?REgrSjYzRDREMkxwZ3ZpdVQ1OEVzSHYxNHFiUzdRWFp0K0hWQjRKOTA5VDdK?=
 =?utf-8?B?T1FEL21DUVpyZ25YZ0VOanRCcmxPN0JzZVNIdjVSRmZtaWxNY0VOY21kcGtx?=
 =?utf-8?B?b3lXcGc1ejRUZUdlTWZLck9FQkZ5UmxuV3k5U0l0UHhteG91ZTlQUm82ZFFw?=
 =?utf-8?B?SHlGb1RwaXlxdnQ2M0RPSlM3WGpYV3cvVVoweUsvdFdmZnZlSWFsRmdkM2JW?=
 =?utf-8?B?RFhERUdCTTcvR0pJSFVJU0NoTFRqMmVHOG1tL3dPSDVhYXU4Y2dHaDR6dlBE?=
 =?utf-8?B?WWpiZkJTRjRqa3pKMlVJenh3M0JaYStMNFE0NzhjWDE3eHlYM1l6czlYbURU?=
 =?utf-8?B?cCs5NWxBa3I3RGV4OTZKV1NORTNhYjhISTI5N3hHSVZWamJheG1rYk5aWTJp?=
 =?utf-8?B?L2pBamZoUmk4c0tOV0Q1TlNsVG1RRGp2QlNUQkEzbFBUbHpueUpabEI1TWdL?=
 =?utf-8?B?elpxZ0RiWFV6UHlVYmVsS0t2NTQyYUxzQTRIQjV2WGphU3NQVWxQOEtqUGNk?=
 =?utf-8?B?SWY3MjlldGJSVXVTUUhjZWRGbVFmeldmUjlJbFFIUXNIdHQyK0dnZ2dnU3Z0?=
 =?utf-8?B?MTRJVWlLU05QVWwvTWNyV0Z6VlFaUCs3MlBFVTFYZGdhemlITkVzc21ZOFQ3?=
 =?utf-8?B?ckp3Vjh1ZFdHbldJUDFxSThocjk1ZUp1RVlCZkE2b2JNUnBrSzlCd0p2Tnlo?=
 =?utf-8?B?TU5RUFdXZDBnell5dm51ZzN3Uzl1T0dncHp1UkgxNURsWkVzVGovdFhIeVVI?=
 =?utf-8?B?OVFNTlBHekprUzRCTmVDVzhvempNRXNCNW1GSDBZWEFmWVFZcFQyN2xZeit3?=
 =?utf-8?B?WllVdkorN1d1KzRXRmxoQjZQVUR0NWk1L0VxYU5pQ2hTM25XMmtweExtTEtK?=
 =?utf-8?B?UE1QOTRrRUxOSEJzcWFOOFVtckhOQjRHWlVVc29hbXg5NjVvbi8wOWZIaTJD?=
 =?utf-8?B?SU1yekdHeWJSeUFnSmZJdktLTGE0bExWTHBkUnJYSlVaZlorMTU4OVZqQU9E?=
 =?utf-8?B?SjY3Yk5rTytNWlpBdTlnRU1WV1dRRDJ2aVVqWStoRDVwSjhUT3B2L3ZDdmor?=
 =?utf-8?B?VDZBNWdPVjVycWdhMDJoS3BRSGRicjFaR05jRjZjRHNDaEJRREtXc0xRbG5r?=
 =?utf-8?B?QWRKMTJzTFl6U3dJNjVseFN3UWJYZWYrT0prQXNQaUtFZWxxYVVPUC9ZK1d1?=
 =?utf-8?B?cVBWaXFHNHFCQlpaZ2dWZGQ0STB0MVo4N1NOUnVLcWtidDE4SFovbkhNbXZV?=
 =?utf-8?B?aVBoK1dCN2lYa2ZIZDYremJmdTRNeWhUZ1d5OSt4d2lFc0hTN2FaVHJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWlocGN6ZHd0dXUvUjBEbHZEa05DYVZ6Y3dPcXZ1dnRheGN0dVo1ZGdqM2RR?=
 =?utf-8?B?Y2JzZjI1ZVo4akNUekZQU3RZOFUyQ0ZOTmViZHdOckx2dVFHYUQyNVUwVW51?=
 =?utf-8?B?U1hOdmExRmNuWHJKQVROZkIwQ0ZyQWtpNmczakVraHI1Z3lWWjc4Y09xR0ZU?=
 =?utf-8?B?dE05VDhSY0k0WW5Wa3RhTUFvVlpidmo3Szg0OGVTemZRU2lGNHZOUlBGOEFB?=
 =?utf-8?B?cXhlL09CNzVwc0M2VisxTEQ3aVpwNk9sUHMzcm0rSnRjWTBxR2VaZzVYdSt0?=
 =?utf-8?B?U1ByekhoSkxjb2pUeGt4V2xHaWdoVFRzektiQmlIcE00aEluVGRLMXhPVkw0?=
 =?utf-8?B?ZWpSa2NWRkVXY0p4clZJbU5oM055NWV2RnhRUTZYSy9zbzlaK2xCclBZalJs?=
 =?utf-8?B?TGRVakdadkpBb0IxU21yZWtkTHp2Z2pJUlJReGgrd1RhVzBUOU9mVnVkQUgw?=
 =?utf-8?B?NUU3Nk1XK3hnMEFhSmhKdmtuMWFCNy9jQ3NyUVp2MnFnaFd1YWhmaWJ1bFMy?=
 =?utf-8?B?UGVRTzZjV0FzVkl5UGpOeWZHbWltbUhTaStmTXZvcllCNHlwUDRFRnFxeGMv?=
 =?utf-8?B?N0Q1MUhRSkpUendVaTZPMzFKSWdCSFpsTWlwYUVxSm9VdmIxOUp3TXlBNDZz?=
 =?utf-8?B?NnRFRnErRWx0RVpuUzJ2U1RCMkJaKzRzU0Z4bCtwTkxRN0Q5VU84Mnk0SW5O?=
 =?utf-8?B?QzZaTmxKMFc1TG5oekxkNU1tV2dEREc5dWsrMWp0NnV2aSs1bWp4WmRKVTNR?=
 =?utf-8?B?Ulluc2tHejdPSElISGtjNE14RHlaYVpLSUU0WFBaR3FsOVdXano0QVNUMUFx?=
 =?utf-8?B?NmhKUmVFRCs4aFdqTXRYM3JXdkcxb0tqVzNIcVlxVUJKSzdVOHZwMjF2c1Nr?=
 =?utf-8?B?Y24wOU9peCtsRTlialVIbFRqRE1paXZGN0NydWhCdEc0STl5QlZPNWt1NXc4?=
 =?utf-8?B?N3lVWjFKbVhwQTMzcUdiWDMyUXR3Qzd3eTJ5MEltYnR5c3RZd0Zjclo2WGZ2?=
 =?utf-8?B?b2RLei80Uzc2NEpHaDRuMDBQNWJVQUFoU0Y2TmlOL2dqY1FLQjdrUlF5emlp?=
 =?utf-8?B?b21NNDFtV1p0cUVnNzgvYmFVUC9IdWN0ckdOYnBLVWhQM0lONi9lOFY3V1BX?=
 =?utf-8?B?UUNEY001L2Z1bnF1QkdGS1ZtTmFqVXJiWDlwL1lQT2RjTlp3NXZnRkJvNlZt?=
 =?utf-8?B?cUkycEg2L1lJM0cwaU9RRjVaaDVkSkJteFVwQlJ6T0tkbWRMY2g0ZlBHdFpp?=
 =?utf-8?B?ODZDNW4zeWVUcFRqaUw0WWhweitGbHBWeENIRWp2TXIwUldrZE1lV1drUkZR?=
 =?utf-8?B?ZStZWjBWbFQvU29tMXQySzhCcUlkUjZncHBFNFN4MzJNYTJlU01BRU9Pbmdz?=
 =?utf-8?B?djhnc2V6SXdNQ3o3anVSM2pjRUdoaEl4Y2tOakxnV3ZaVXpJSWI2clVtSFFt?=
 =?utf-8?B?WVp4QWJFc2JtVWtBQ0lDN25jdUFLWXhYVmUzN1pJak5WcGNKZlYvUUs2R3Ry?=
 =?utf-8?B?NERKVnZnY2lZazlGcUcwd1duaWJ1MlpvWmJEcTRiQ2RtTFpockI1TVRZMDRq?=
 =?utf-8?B?a2ZMdXllQlB2Q2U2WkhwMkllb0FiMVgweW5RWXVUYi9seUdBTlJWdFFSYzlH?=
 =?utf-8?B?QzBBSVpmR1dENlN4b1FSbmw2THRLN25aczVHeWcwVE9WcWs2c0czdkwxZWJ3?=
 =?utf-8?B?Q29aRVFGVmRuZkd2WEw4S0duaTVadXBiQ2dyL3M0Z2dCYjBtUEFobnNYWDNZ?=
 =?utf-8?B?UWxUQkxVeTcyQzd1SHQyLzhMcmRBWDVVQlkyTkNMQmpvcndNaXc5VVowa0pZ?=
 =?utf-8?B?N053Z3JFZFhFamVtNjZIdnFEUHB2akZwTElocFhxcUlKOE02UXRvNVNzLy83?=
 =?utf-8?B?dUpGUkp5UDEyaWs2cnBYZGwveitLNHlpM3J3ZUxiSlBVRmlVcktwUXZjTFYy?=
 =?utf-8?B?S0kxWEM0Z1hjOHdDWnpRNGs0ZG1VNFYxdXpNRk1rRFZoNitTellFTHdwdkpR?=
 =?utf-8?B?VnVLaTMvNjU0aytrOXhieXpwelN6UGRRWEt2ekdwRy9sNXBUK0o0MkhmYVpo?=
 =?utf-8?B?U3plQURUUkV1bUZGc2R6bXovT0NPclAxcFlZYkI0TDFSSlhSeUJHR0dsdnlY?=
 =?utf-8?Q?He5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5f5c67-40a1-4ac8-7296-08dc7566cf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 05:12:40.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9b4E5inBBjEM5fy+951VDKaGx+/i03EcABTK81kJg2FWR7Ya4NbAC6wCGQmWnqViHn/LW7GVSxGmdMSkP8k3OSfMrC5EPHSVji/F+azMbYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com

V2UgbmVlZCB0byBmaXggdGhpcyBBU0FQLiBGbGlwa2FydCByZXBvcnRlZCB0aGlzIGlzc3VlIHdp
dGggNi4xLnggc3RhYmxlIGtlcm5lbC4NCk5vdCBzdXJlIHdoeSB0aGlzIGNvbW1pdCB3YXMgYmFj
a3BvcnRlZCB0byBMVFMga2VybmVsIGFzIGl0IGlzIG5vdCBhIGJ1ZyBmaXgsIGJ1dCBpbnRyb2R1
Y2VkIGFzIHBhcnQgb2YgZW5hYmxpbmcgbGl2ZSBtaWdyYXRpb24uDQoNClRoYW5rcw0KU3JpZGhh
cg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmFraSwgQWhtZWQgPGFobWVk
Lnpha2lAaW50ZWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgTWF5IDE1LCAyMDI0IDI6MTcgUE0N
ClRvOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpDYzogS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5l
LmtlbGxlckBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwu
Y29tPjsgQ2hpdHRpbSwgTWFkaHUgPG1hZGh1LmNoaXR0aW1AaW50ZWwuY29tPjsgU2FtdWRyYWxh
LCBTcmlkaGFyIDxzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5jb20+DQpTdWJqZWN0OiBGaXggSW50
ZWwncyBpY2UgZHJpdmVyIGluIHN0YWJsZQ0KDQpIZWxsbywNCg0KVXBzdHJlYW0gY29tbWl0IDEx
ZmJiMWJmYjViYzhjOThiMmQ3ZGI5ZGEzMzJiNWU1NjhmNGFhYWIgKCJpY2U6IHVzZSANCnJlbGF0
aXZlIFZTSSBpbmRleCBmb3IgVkZzIFZTSXMiKSB3YXMgYXBwbGllZCB0byBzdGFibGUgNi4xLCA2
LjYgYW5kIDYuODoNCg0KNi4xOiA1NjkzZGQ2ZDNkMDFmMGVlYTI0NDAxZjgxNWM5OGI2NGNiMzE1
YjY3DQo2LjY6IGM5MjYzOTNkYzM0NDJjMzhmZGNhYjE3ZDA0MDgzN2NmNGFjYWQxYzMNCjYuODog
ZDNkYTBkNGQ5ZmI0NzJhZDdkY2NiNzg0ZjNkOWRlNDBkMGMyZjZhOQ0KDQpIb3dldmVyLCBpdCB3
YXMgYSBwYXJ0IG9mIGEgc2VyaWVzIHN1Ym1pdHRlZCB0byBuZXQtbmV4dCBbMV0uIEFwcGx5aW5n
IA0KdGhpcyBvbmUgcGF0Y2ggb24gaXRzIG93biBicm9rZSB0aGUgVkYgZGV2aWNlcyBjcmVhdGVk
IHdpdGggdGhlIGljZSBhcyBhIFBGOg0KDQogICAjIFsgIDMwNy42ODgyMzddIGlhdmY6IEludGVs
KFIpIEV0aGVybmV0IEFkYXB0aXZlIFZpcnR1YWwgRnVuY3Rpb24gDQpOZXR3b3JrIERyaXZlcg0K
ICAgIyBbICAzMDcuNjg4MjQxXSBDb3B5cmlnaHQgKGMpIDIwMTMgLSAyMDE4IEludGVsIENvcnBv
cmF0aW9uLg0KICAgIyBbICAzMDcuNjg4NDI0XSBpYXZmIDAwMDA6YWY6MDEuMDogZW5hYmxpbmcg
ZGV2aWNlICgwMDAwIC0+IDAwMDIpDQogICAjIFsgIDMwNy43NTg4NjBdIGlhdmYgMDAwMDphZjow
MS4wOiBJbnZhbGlkIE1BQyBhZGRyZXNzIA0KMDA6MDA6MDA6MDA6MDA6MDAsIHVzaW5nIHJhbmRv
bQ0KICAgIyBbICAzMDcuNzU5NjI4XSBpYXZmIDAwMDA6YWY6MDEuMDogTXVsdGlxdWV1ZSBFbmFi
bGVkOiBRdWV1ZSBwYWlyIA0KY291bnQgPSAxNg0KICAgIyBbICAzMDcuNzU5NjgzXSBpYXZmIDAw
MDA6YWY6MDEuMDogTUFDIGFkZHJlc3M6IDZhOjQ2OjgzOjg4OmMyOjI2DQogICAjIFsgIDMwNy43
NTk2ODhdIGlhdmYgMDAwMDphZjowMS4wOiBHUk8gaXMgZW5hYmxlZA0KICAgIyBbICAzMDcuNzkw
OTM3XSBpYXZmIDAwMDA6YWY6MDEuMCBlbnM4MDJmMHYwOiByZW5hbWVkIGZyb20gZXRoMA0KICAg
IyBbICAzMDcuODk2MDQxXSBpYXZmIDAwMDA6YWY6MDEuMDogUEYgcmV0dXJuZWQgZXJyb3IgLTUg
DQooSUFWRl9FUlJfUEFSQU0pIHRvIG91ciByZXF1ZXN0IDYNCiAgICMgWyAgMzA3LjkxNjk2N10g
aWF2ZiAwMDAwOmFmOjAxLjA6IFBGIHJldHVybmVkIGVycm9yIC01IA0KKElBVkZfRVJSX1BBUkFN
KSB0byBvdXIgcmVxdWVzdCA4DQoNCg0KVGhlIFZGIGluaXRpYWxpemF0aW9uIGZhaWxzIGFuZCB0
aGUgVkYgZGV2aWNlIGlzIGNvbXBsZXRlbHkgdW51c2FibGUuDQoNClRoaXMgY2FuIGJlIGZpeGVk
IGVpdGhlciBieToNCjEgLSBSZXZlcnRpbmcgdGhlIGFib3ZlIG1lbnRpb25lZCBjb21taXQgKHVw
c3RyZWFtIA0KMTFmYmIxYmZiNWJjOGM5OGIyZDdkYjlkYTMzMmI1ZTU2OGY0YWFhYikNCg0KT3Is
DQoNCjIgLSBhcHBseWluZyB0aGUgZm9sbG93aW5nIHVwc3RyZWFtIGNvbW1pdHMgKHBhcnQgb2Yg
dGhlIHNlcmllcyk6DQogIGEpIGEyMTYwNTk5M2RkNWRmZDE1ZWRmYTdmMDY3MDVlZGUxN2I1MTkw
MjYgKCJpY2U6IHBhc3MgVlNJIHBvaW50ZXIgDQppbnRvIGljZV92Y19pc3ZhbGlkX3FfaWQiKQ0K
ICBiKSAzNjNmNjg5NjAwZGQwMTA3MDNjZTYzOTFiY2ZjNzI5YTk3ZDIxODQwICgiaWNlOiByZW1v
dmUgdW5uZWNlc3NhcnkgDQpkdXBsaWNhdGUgY2hlY2tzIGZvciBWRiBWU0kgSUQiKQ0KDQoNClRo
YW5rcywNCkFobWVkDQoNClsxXTogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2
L21zZzk3OTI4OS5odG1sDQo=

