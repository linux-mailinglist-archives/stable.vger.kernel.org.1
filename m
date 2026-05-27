Return-Path: <stable+bounces-254617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEXLLDATF2pf3QcAu9opvQ
	(envelope-from <stable+bounces-254617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86D5E7354
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E0330BC295
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82E31A567;
	Wed, 27 May 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVrqI8xU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D33033DF;
	Wed, 27 May 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896331; cv=fail; b=suKTPIWjR4mGlA+rXek4iQ3cP2ErCeDYZMZ7N2PLe8zylfqr6u5Sv/DF2+R8zOUtWf8DcY0bedc0FKE0TkTZsTjvBRgg4c5/iX0mLoYnDNLyH3IxmksdXGiYkYVCgCwe0lDQe0WRhgLlIQzy9RDYR2/Lu0ZRJmlaXbg8FEv4aFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896331; c=relaxed/simple;
	bh=PgjtzFUvWYZr5GKvUnek24dW3XhMdzpX7h4IA4oISPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bz9DpP5N8gTllf8WvXAg7Qxfpu9Q8BbKfVjdA9uke2ii3UQ2F7W4inyOU19HstAjYlhs67xMiFRnjZnl/LOd2vrfuYLaGyriDsaEI/zRPJ95UguMz04zMiTnJb4rX5dE5At03ybHICDb7WRkA6WOgGhjz/AjzdSAvZqhi8mAwy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVrqI8xU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779896329; x=1811432329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PgjtzFUvWYZr5GKvUnek24dW3XhMdzpX7h4IA4oISPc=;
  b=EVrqI8xUGyDxAk+nKL5M0/LsGbNl/DBrW/NDsAYXXjAsrBVoU4mNuwF6
   XBQR0bDUXdzUuvY2lE/t+4qXk99KtIa9Lyp1bYLbUptcertYeWkDO6yqh
   3z42TkFzokub6TLFmeIIUcj1dAUFGUbklWo8OE5S/wnpYulO81AiBYB99
   i0FiQtx2boAoCjRyF8zN9yQy2ZsIuk/LG/af0/q3rRI+gd+OgZA0PYg8a
   NmD2hziEmCFyNky31wX5TeVRZ120E4FHwy5ZX+O75YC2antMnaQENt6dw
   cWAhxeZ631ALMiLu+laAhnPYlwYLZI52y4Fjz+lCnCDFFXwan7sBRyJP0
   g==;
X-CSE-ConnectionGUID: AwXKqo07SAuDGcbxBRWfqQ==
X-CSE-MsgGUID: MC6eWAMcSl+0VfeyGChW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92204646"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92204646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:38:46 -0700
X-CSE-ConnectionGUID: Jp4TU2VkSByHpYHVr6x1Kw==
X-CSE-MsgGUID: ttk24RDuSWO7zGH9FpYeJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246552523"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:38:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:38:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 08:38:43 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unox+OIWMW/lZB5DA1T5ErB5jyJHjLM2DUfmQ8fUkrTtKaJFaNvHrnLsO2wwCZ269TE8btoqYC0hBe4wHlHBAF47MIF3J+IiHDc6+/aw8jXo8jNTYk1k+O+hI6bySSy97vAZ3R6Gi69lqVy4fEb8E+3TIzfXgJgemDU0/pNRKFpbtgi92J95es2Ke/OUF/nzjk81J55roOerIhifzPJ0zRzqOQKKbd/6tSXEfXFcHdqL+JAN8OyUEQJpr92ApI7JXuvKa8QCQnOONJ2+zeD2oqqb4PK2+blXHfldFG7ozhFtPME3s1Y2cb29qTsAeDXtAO1IcIKBIypmu5SBimz1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgjtzFUvWYZr5GKvUnek24dW3XhMdzpX7h4IA4oISPc=;
 b=FatAqToWjCpY++Z6i88uMvPD4XQ9Un9x4ur/mGXVvOI3MucuhGI6WVGhrZThaeFBGqM0T+HkroW1UkABLiVsrEAuD8tZ8teheo1Bt1tmXB2IS/DLbL+f6ITrPq3Sn/9tqLDNYLys2bGhvw/ZM6+G7UbRfuJMakXAVffVYP9k1kvtZ3ltMT0OkKmrznYiTaOAuGeFkAxlQC86YYQCOFGOQuTmf+0vJuTXqWNXHXe09cLDa7A1n9knNTAX6HJEEWj5grErIN52jtYrRegDFLDwqP3vInL7vcMP9w2cmpi0Q43fb6sOSsZz1j+80Yh/BQvBLtO6svpXzcx6n3IpenIlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 15:38:39 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:38:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai"
	<kai.huang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] x86/tdx: Fix off-by-one in port I/O handling
Thread-Topic: [PATCH v3 1/2] x86/tdx: Fix off-by-one in port I/O handling
Thread-Index: AQHc7dE6qLXAQS1ig0G6l/OiC0TvSrYiAtgA
Date: Wed, 27 May 2026 15:38:38 +0000
Message-ID: <625a6f5730a531ee917902c85e1d8dfed0266569.camel@intel.com>
References: <20260527120544.2903923-1-kas@kernel.org>
	 <20260527120544.2903923-2-kas@kernel.org>
In-Reply-To: <20260527120544.2903923-2-kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7286:EE_
x-ms-office365-filtering-correlation-id: 2cbaf501-7002-4e38-a1ca-08debc060615
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: khQNNBJAaAVKih5UIKmaiqbloBvwQl/YsvJxdLkflozONtFOdJNDl2Zk6uYqrtnm+dXSaiY8wtQdqcNjtf+QYhTCs5FlMxRn0odYj8Zru+FhTdu9zgCqb4axmoAuQzi0/3FvT6NqGkw72tAnfdstTmf74yO7mXK58N1dolljcdaZUhWIeiDztRNQmURz2pmP1jFEnd1UTqvUdrYj6ANE5O1Ff8ZlWz6tYvfuzzuecvMbQl1iUCfjdcLYLBoCZhuFH8pSpDryx3Csnow+f182FjJ9zLO/12vObDzTsxgWF2nqFz6IUDi/nhhPpPbFvwdNNYdw+gaFdUDreznYJuQRvwNzY7KMyTlLXe3RMpudvqyWupeVhj29yY47vgM1vGgagcmPNbMvFp1CXOc/CIoj6D4v9eOVy0lIRlkpJ/M/KcAaT+BLnOEm2mF6VmPzc0mVaKuB+BgGMy3mnkRHJAPBkz4N9Mg0Qb2Rq+64dz94wOXLVySsJBX0/2IWEDudL/hmGeP/ECJ70DgtrX6L0Hzf/FtwgVKerrWQbGvJbzJoT8pmiWQb8fb4RKo07EbmKlbHpP4qsIY0VOqEzwXiMvtz2ex/i2oFpveIceqSI/HOzpSf8cYRj3cg8mqeoPtVV9rkCnII2sPt6v5rbreqmKwZ36/myHcxyC8119eoF6syxSuhq2j40tmIq+EIxzJrnozuuEn+a0I1r7GqpuNSWHYqGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MStDYmRtY1crUU9wTWdSd01GbnE5aGw1SFRCcVJZK0YrNE9rTmt4czZzWFhZ?=
 =?utf-8?B?d1FjRUg1Q1hXSm8zeXc5dVRRYUpXR3VFTDlROHJZbnBNOFFjYlFLRlF0b05t?=
 =?utf-8?B?cDBZQjhBOHZSTDJ4YyswaTRHOWpscndob3VBVGhzYTJjeWVqWXpPTlBid0dl?=
 =?utf-8?B?THF2N085TFRhaXRjcEFqVnpDa0g4bXJxaGd1RjE3bnlRWHRJWnJOY3Z6VzJP?=
 =?utf-8?B?NUwzcldJc1Izek1ld3lkc25CU2dXdW5sZy9GalNzSUNyanlaTmdOOUZlUy9q?=
 =?utf-8?B?QVNzMFhMSm1MWGU2eG42aTV6U2Y2eUUyZmNiZkZxY2tSZU1mRW9KSFpLNFc0?=
 =?utf-8?B?d2haVDkvT21sdjZqaDQ0WHZMS0RJcHN1djZsZHQ1MDhUZUwwQWJFZllTZ2wx?=
 =?utf-8?B?UDNXSHZXMmtlRmNNNG0wVFZnS1dwWUNrdis2dFBNQ1pLYUN3eGpsbTErcW11?=
 =?utf-8?B?ekhuSVd2V1M1dXc4WU1rOWloZDlWSTV5RlhrRGhxNnBOaEkvTGlGVzFGb2wy?=
 =?utf-8?B?UmZuT1Fmbmw5dmloZkIvR3BDSTNaR0JERDVuQ1FWSysveVpGdmNDWGlkOFRr?=
 =?utf-8?B?cDRZVXY4RitBbHY4bGpIZXhBWHA0ZnJaUzB3b2xpSHFUNEdDU2dMclFOV0gy?=
 =?utf-8?B?VEMwSEQ1bjNPazlQUnNPTTRxNFJuK3dSNTU5UFUyaXdmTWsyRW5OL2lEZlpn?=
 =?utf-8?B?RVdFS1dmbms5ZzJuRFZ6ZDlxeG4zbjJhUFYzcnFNVm5mNElUKzRTMVlTTlVE?=
 =?utf-8?B?K1NNb0tLZnl5MEFFb3MvTlRmSDkxVEk2MWpOb0gwYjFWSzlmUXM1RXVrdm1M?=
 =?utf-8?B?VDBTM1Y5UGRxZVk5M29CaE55ejh4bkZvVjJaeWw3MnJZbkxER2RWV2hNNXQ0?=
 =?utf-8?B?MVBIK0tiVVI1RExFdzYvbGdFNDVWWHEyYUxLTm5QdkFVT1BSb293dk84N0sw?=
 =?utf-8?B?QUlUZFpoc0lGeUFrSG1FWFlxRWtHSjJMNE1TSEQxS09NS1d0T2psb1Qwc0g1?=
 =?utf-8?B?TWVBTEV0dEFHU3VTczdaNStleTBaSHp5S3pwTVBtNDlQSitmemkwUzRZOEZM?=
 =?utf-8?B?OWJ6SGxKQlM0eFdBTHBWTDgvU01TanlsTVpKTDgvUER2eFh0Mmo4d3RVUGxY?=
 =?utf-8?B?Q1grZmVheEorYThjNGQ3SUYwdlpRaWZ2VkRWdXEyZ2RyYnROeHA4SUxEM0ZY?=
 =?utf-8?B?TE05WTRhQUJKOW10b2JNdGRpejZLMzd0ZjFseWZKQ2hzb2YyU0RTVCtzZ1N2?=
 =?utf-8?B?MEIwK2ZGSk9SZ2RobEU2OFhxdW4rWUxVTHdsWWF5V3lpSUNxZSttUkF0Z0hC?=
 =?utf-8?B?eFR6aWlrU3FNQWowbVNqVGdSV0sxYys2QkhCaDdXTXB4T2VzYTh4WnRSb0tw?=
 =?utf-8?B?Y3dRV09VZDNkYzhFNFgvUitrTkgySlpoRUcwNnhkc3V3U1l2STYyR3FQbS8v?=
 =?utf-8?B?NmhCc0hSOVlYNUFDTmJQSzhBZEUrMUdsMnk2T2pNWUdYL1Jhc3VtSEZPSFpC?=
 =?utf-8?B?RDZ2NHl1K3ZIVDl5aGMyaVZIYzBIZDJTVDRJcmE5TWpaQnFHNnk5ZEVUb1VN?=
 =?utf-8?B?YkpEQVJMYkdqQ0VSdGFoaGRaQjhxVU5wanZNRUYvMzRsZnNseGpMYWNWdW5q?=
 =?utf-8?B?bFEybkdhQSt5TThCZXBPN254Um80b0lpdXlkbWJPcTNYbmM1OGsyUzRMUXlS?=
 =?utf-8?B?SWZtbFcveFZrUjJRRUFWK0tMVHpGVFB6eXVGb1hpUjZRN2pBSHRsK21rNzJz?=
 =?utf-8?B?Rk5GNGRHT3hqSkZQbnhSb00rekpRdytTM0RjOXlLQXZOZEVFVHE0Q0J0di9F?=
 =?utf-8?B?RmZJdkpuNWZLVFRKVDg1bStyWWFXTnVHUHh1VjR6Q3JTblI3RnFpOUpQRUFS?=
 =?utf-8?B?emVRRTJnd0lvaDBrbDhDUVFMWHRJalgzWWpuTzQ4ZDVTLzBuOHoxQ2FyZU1J?=
 =?utf-8?B?dHVxaU9zMzNyZkpTY2lDeXdLcEtGMmNBWmpNL1dLdlBkNWttamdaZFpTOWtF?=
 =?utf-8?B?NkZmaTR0UU9KeU5rRCtjdVF1ek9iZUpqbVhwSTVjaFV6TUVmck4wTWozVkJv?=
 =?utf-8?B?Lys1NUdvTGNFTlJNbFROa3htdzVYMU9URU01NXB1UCtXdE5QYWd0d08xOExE?=
 =?utf-8?B?dHpNMUVzb0t3NVVTMmhNSzNRZ1VVMXpBcUZmNDVzRnp0YnFPRWJSU0o4QTRq?=
 =?utf-8?B?YUdUZ25Ja25hUTBSbXFWcEZ2M1krRTJsNDFNejBZbVJYcVRFOTdkNm9VSkhn?=
 =?utf-8?B?T1RlVEpWTnQ5NkhIczVVcXE2UmxTQkwrbUtmWGVwYXZEeHZOMlp1N0J2NFNK?=
 =?utf-8?B?UlYrWEdhcnBMMjhOZUhWZk1Bdy9ibGZBSWwzVGdUN0Y5L2Q1bUxSSnMxa3Nl?=
 =?utf-8?Q?31wp0epY3FWLZP0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <717ED015CCCBBE4D8B234019E441D1E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kDWlbNCAuKxxDFiYKZ5CHMCv8Mye8Jdryf9hyFPTqdDjjT2HoXs0J0/nzPyHIq+Vf9iNoB0sIFbELEMZL35l25FievQ4xXxgNssYBOWeQ2GL/DUBQz2h2Kd845lpBYQGqtZn/a2vlpKRqzmtGiIKxnbK6r9a+KrvCWoM88oZlep53Pdm3xQ1n4TYjJ4ytCBAZrazL8vHhDbX9j/V60cjHO6S4lNKphFHhACoTEiawcVfDLEuuCeU4/JS63SeMJuVgrMcRveVHt0spoBtnKdVk+l4swCez+Dd79ojmT1snMCLU8uhrgZyfwUyQOePI306FRlNO9UPC9/L0Qlae+B7Uw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbaf501-7002-4e38-a1ca-08debc060615
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 15:38:39.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceW/UYcLIu+m1senZPZO/J4yNjqQ3eLT0OFUZkw0jM2R8BdgjvwJvSHlqQW7Tu880X4smvPlNZgvvTEBpLmEq7QxvfllOtizZZC+7qhmMYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254617-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,intel.com,zytor.com,linux.intel.com,vger.kernel.org,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3A86D5E7354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA1LTI3IGF0IDEzOjA1ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiBoYW5kbGVfaW4oKSBhbmQgaGFuZGxlX291dCgpIGluIGFyY2gveDg2L2NvY28v
dGR4L3RkeC5jIHVzZToNCj4gDQo+IMKgwqDCoCB1NjQgbWFzayA9IEdFTk1BU0soQklUU19QRVJf
QllURSAqIHNpemUsIDApOw0KPiANCj4gR0VOTUFTSyhoLCBsKSBpbmNsdWRlcyBiaXQgaC4gRm9y
IHNpemU9MSAoSU5CKSwgdGhpcyBwcm9kdWNlcw0KPiBHRU5NQVNLKDgsIDApID0gMHgxRkYgKDkg
Yml0cykgaW5zdGVhZCBvZiBHRU5NQVNLKDcsIDApID0gMHhGRiAoOA0KPiBiaXRzKS4gVGhlIG1h
c2sgaXMgb25lIGJpdCB0b28gd2lkZSBmb3IgYWxsIEkvTyBzaXplcy4NCj4gDQo+IEZpeCB0aGUg
bWFzayBjYWxjdWxhdGlvbi4NCj4gDQo+IEZpeGVzOiAwMzE0OTk0ODgzMmEgKCJ4ODYvdGR4OiBQ
b3J0IEkvTzogQWRkIHJ1bnRpbWUgaHlwZXJjYWxscyIpDQo+IFJlcG9ydGVkLWJ5OiBCb3J5cyBU
c3lydWxuaWtvdiA8dHN5cnVsbmlrb3YuYm9yeXNAZ21haWwuY29tPg0KPiBMaW5rOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FLd19Eejk2cmZTUWM2Um4rOVFCY1VGSGhta0srOXp1
K1A9Ynhvd2Zad3hyQVRDQlJnQG1haWwuZ21haWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJ5
bCBTaHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEthaSBI
dWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEt1cHB1c3dhbXkgU2F0
aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5j
b20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNClJldmlld2VkLWJ5OiBSaWNrIEVk
Z2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=

