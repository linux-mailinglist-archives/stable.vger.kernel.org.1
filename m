Return-Path: <stable+bounces-223767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMSpAQTGr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:19:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753124634D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C027C3013D68
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315E3D7D8B;
	Tue, 10 Mar 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7kabM1k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377930E84A;
	Tue, 10 Mar 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127167; cv=fail; b=d1xEAgsO8By34c4KNTJsHtGbdM8wpnNJF7dsAOki2qs7xRb7My/8iqm3TL3B/nBh+cjUCXgjwooORBwb62bZEe7iOlrqLyuZmGtmHaHbdaE6f1NIf49thAifu6TB7oisOhLaChsj61WTGuBIFef8MSSaaz/+HilHM0Ae9f+Cl4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127167; c=relaxed/simple;
	bh=XzxPd0neyx4tbh93v/l3aSC3VaFgiaveEMK5NIezQUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahdmUHiSm8ErD/Mr/eL7qwc8Vctrenw0zMv/sQhIF1j520qxrkS31rlCyaJpySP05xxnzoHG1+ArKAY50G6Ov2YA7Y+Z6reepsXkGW4XOlZbeCUpBaYaEZgi5LJ8BUpgo06fjfXyyTr1nwBACErWXTb4aCqFE0Myd/JCCWSGuCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7kabM1k; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773127163; x=1804663163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XzxPd0neyx4tbh93v/l3aSC3VaFgiaveEMK5NIezQUs=;
  b=J7kabM1k/pNISd9UUyvmFcb7eIdfLT1rlXMmiiR8rHcuY8NCUpg2q5sa
   acOG6AZEoLlQrqkn7xJSI2yaAGr8Cv8ZTw1GxvYqBZdJ3Euc8wXOznxva
   joGyCfk8N4F6RCBVyaKeHs5dLbbcsuP6r4AMav5UBEM13SZQ4m76+bAAm
   fLALUcsXaw0UZ6pMtnTW4/90YTN1vJ4hGuF2gXrPbhSFwklHo8XjQvscf
   CZ7o/1t4tNYEwIycedEi/Ogm8u+nOZQuijgNhzjaAuL1L5BfqT97wW927
   Yaa7AczNdTjSoudO9cCuotbK6KdBUTGhCaoOppS/xPtc24hAGaipfHUZ1
   A==;
X-CSE-ConnectionGUID: AYT0JVAwSL+CEEtoGpdO8A==
X-CSE-MsgGUID: w0mrXRnaQCuy0zubTjZCFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="91549321"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="91549321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:19:22 -0700
X-CSE-ConnectionGUID: hpf9epnqSF2GI2JN/mMVIA==
X-CSE-MsgGUID: Wbh6bM03SoCQnTe66CnWSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224945760"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:19:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:19:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 00:19:21 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv3YIueVgMhmYmQ2i6NhS3UfckuCXeQ+KlNYYWrrhkg0MrC7+cRHZqZPZe0JNEMshq8+xN9PEzWPPIoeatWku36yNF8kyi+oreEGHAFKnttl7JlJnB5jRnWkkX3XMAFcS4qjkxwH2HBhoANqa03g0hhNdk5G3GFAgleyI8vWHWB4SU3t1RywTRYG7ZnFt4sEE5WX3JI0DdAopDMSvmcQiLgDfghWwZTbgI43/JCWmVo48QDFxY06Tp9E1v5ndXhHd3+ww+/jPU4eiIWVriY7kreLrVcYlx5uxCYZvU6pBfVsm8tFOD9C6itNywMbx9eO7SwYqnaLwHwnThIaoSO8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzxPd0neyx4tbh93v/l3aSC3VaFgiaveEMK5NIezQUs=;
 b=Sh7sMxqblIyDFcTZj8O0OUIpIj2cA2qjduA4DR/hDRacFbdZNgzqplc2zcwV4MwfnScDPP/m7st/PrxV03mMOBQ74h+XaZ44GPKBQQJIZTv7x8i1JszsFmNF4GrPwGpQF7acPO+83tPXNQhg2JZOnuodU5ZZ1W2S6EHH40GzP6D3BnmhViNrB4tUD+9PpYqy3R2PVE5469EW0rzRcLEY8D9EoRihDMxDxmla4qgAyCa+GJFS/GD4exahiEyBoAmbLR7b3e2AQlWv0jFtkadNV4Li8yoo7rZu/uphO7UKGKbDFIL9XoFgzGUdS9rjXPz4AggjI3hhOwitpVII/2P57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY8PR11MB6841.namprd11.prod.outlook.com (2603:10b6:930:62::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 07:19:17 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:19:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Edgecombe, Rick
 P" <rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6VGDAojXj0j0m1k3BT3zeBY7Wmcd0AgAD2LIA=
Date: Tue, 10 Mar 2026 07:19:17 +0000
Message-ID: <88b3637c84737136da1fe373cde43801845bd062.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
In-Reply-To: <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY8PR11MB6841:EE_
x-ms-office365-filtering-correlation-id: 1086fb21-308b-419e-9bff-08de7e755771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: On6GYoDO2LMTR7Vpvi1IgjQ10MpNFNpBkJykTEMMTEibnYDGUmIwkN3JBZvm5k+6IPxHHbrtP+B0Ha4EsnUCi8jDc0gt+CWcgSc8xVS2ufwEhz9Cb3Z0K11oADYukRBVsdMS+PCbBMwPTgYb9PB5P4XLIzmKQEWJ4Uvup4DBOJ8f6KAGM6FV2XvUmF1vx9q/uMd/4ZozFXvza55lGJC8RnXT9Ogv8p/9EaVC7rrR4YkDdBwNzsWjcBVKJSEriNLjgZ1awj/l0Xx9UnwcNrDzjpagvXNuaTYEPLkuCjBveDXVt9wVTBZUf8iHhRnKylkSFnaaCzGrwBtap4kh/ST8Y1gr5i5kGJ882eyRup4QMu61Hn+OryXKMWpOVyEPedIZvzSIEcLQMOzZkXyM2waeQVXn+vWQ01+tsF+pFxj8VInTpl5LJth+dxvQMuedoaU1QB6OEzYSITXy1ma7UJirRmqhsGKhWsgc06PUtlvz9G0oTx1bjXMm9ChkwlStQoF700N+j2khosHKAvUC98Z1rOsDxKwikNrjApw6M8a7O9I6Grtx4BWMvqQE93f88gJD8n5KF/YnwTreNl4zXMYcNfcvtDrBBEmdabXofAtgNq0RgNQPyZn7DdNg55s54v5SVZpfbVtO1Y8C5YzpAV4gbj7jCXeHbr2tRFeDdZHFH0pBkr+eSDLBJVEBSO6FUVuffmpVgv+zeMY51VsgO/DeGpyxJgWrRMjKO14Ql7kkcnHqSfi6dYtIEFYu3Sl8zYjbOYWs3vVJYFggN5zc2Z5xHQZm2h/qV3AzxUM82C8MsMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJ5VkJRaUdvaEhqQ1RHMUdZVG1NVXFRMUNERGpXWnlTbG9tQWpCZ1RpQ214?=
 =?utf-8?B?em5saml5V0haQ2ROMlRLYk5UUDVsSllwQ2xMSllrWTVkaGtUVEdMOXdmaXJO?=
 =?utf-8?B?RmZya2U4RE5RVnNMZDIzSEZHVVhjcGE2VUdhQWRIOVBoTzlwRDhjQjFYTmgw?=
 =?utf-8?B?VExGWXI1eXhTK0tMU2l3OS9kaHZCMlFnRXdmcXJIWFFrdkxDeEVtYXNNRXhW?=
 =?utf-8?B?YjZiZG8vWEdKYlNwNmE1WTFxYmdpcTNKaEpCMWdWMGFHajg0QVkwU25EK0pN?=
 =?utf-8?B?Z0ZxNmphYjFtYjd5N2lrQ3Q2WWNFVG9VR0hIaDZoSWVrUXFBcVJUcDFhbHcz?=
 =?utf-8?B?QkNSRmxIbUVJV2dsUDlaanVZUE1BTnMzeC9SQ0I1RDRKTXRjckVvQmZ6UXZr?=
 =?utf-8?B?ek1Na3gwU2pKWTJTSGJ2bDk5aTl2bVlSK0t6ZFpIRmNmekxSMmRkSlZ5ODBO?=
 =?utf-8?B?SElHNkhqU1M2Ylp6QUlUTWtQN3Y3TENGUW1NbkxqRlI5LzIvMHpqcjdoQndj?=
 =?utf-8?B?aUdHOFh5RVBkWGIrLzBITkZNOWpYaGpPanhYTWtqaTI1ODdDQ05QZU5rdita?=
 =?utf-8?B?YmVaa0FEOHNHcFJpcU9hamxxSWJObXNZY0VKN1pHRDFXUWFsbEZxL0E4bEU3?=
 =?utf-8?B?UHNpNisrOW1SOTZZL3lqakpkL1dDa2wrOXFUOFh6YzRzTlVuOFNYL1BNTDA0?=
 =?utf-8?B?aEFLeHJtSGg0a05zOGpwQ081SzJ6UWk0RlE4eFNXYVEzUVZaclJPRHE0ajBr?=
 =?utf-8?B?L2hLUndkVHBLSlJ5OVZEejBRdlFpQjBOdGlDRnBrQms0ZWh3dUx0ekF3bjhl?=
 =?utf-8?B?L2oyK1RaaVhPQU5uZ2pVYW1BWkdsZzVYZ3B2OTNNa1FFd0xPQ2Z5RmFvVXZo?=
 =?utf-8?B?dWh6TTdjRW1sdktmN3d5cUpyNS9qUGRTbEZyY1IrdkNYUFJLdnByUXE3a0ZT?=
 =?utf-8?B?MVVHdFd1ZmJQUVhZYnNHQjJHZko4TFFWZ3o2Q1VmTms3ajlwV010QlE2bWRw?=
 =?utf-8?B?bnkvQ1doZ1I1VWFzK3JmOGZUUGF0ZzVySWM3VnpqNmd1dm0xRDlXMFpGdjhn?=
 =?utf-8?B?VzFvMWhObjNWem5TbjhobDZWMEhXSDNCS3hTS1hYcXd3Yit6ckh1cDU0dTMy?=
 =?utf-8?B?NEsyL0VhdlZ1am95Q2tRMUxkOTFpTFpwUHVUL1dCdWJka3drbzdUclh1Qzlt?=
 =?utf-8?B?a0Yxd3BtZThCK3YyY2VNVjRValNnU2IwRzdoU1dhcUVWNVJscnBCcHpaYjJn?=
 =?utf-8?B?WEozeVFKV05ubnlIcjY0WHVEUHVrN0V2S2pmaVZhS053Z1l0SERTQzRrMXZQ?=
 =?utf-8?B?QitmTHNRSURIbjUvUmYxbHVtN2o1UzJlZ2xrN1l3WkdPbEI2QmJYcUgySVVL?=
 =?utf-8?B?UDVaMllJaXVwVlBqTkdvU3VETUppbVhic3N0U2JEbnJxOTlKK04wZ1M1WHdm?=
 =?utf-8?B?S1FkOVVMenJldDVsSFU1dFRsQ2QrWXJ4Q0l0NUZsbnRZeE5RbUdJUiswUVZQ?=
 =?utf-8?B?YWFsb2hvZk5hblZqeXpySCtuOFg3S01vQWtGR0RxbmJ5ZENacUlpRTYyQ1JL?=
 =?utf-8?B?bVZGaEtjK25BTVpZc01XNlg5dkhKZDBoRDh2RTNqQ2c3d3BBMGN6RnVxOEhJ?=
 =?utf-8?B?Tzk2Y05EcnFMTjBLdm5SQUlKdW95LzBaYmhDakVWM0lpNlh4R0VEZmZ5V0U1?=
 =?utf-8?B?d3Bod042WForcExZMVZPMnVvdHd1UVZvMGE1SllnVUFTTFNvbUJPeGs1eThO?=
 =?utf-8?B?bVZnTTBkOFdOSUJEQ0tuaVphUnNSeXE0V2NCTTlvdHFOZ3NWUTZnOTJCVlJQ?=
 =?utf-8?B?Mm1Mbkp6cXg3aVRBY01CMXVqMm1YMHUyNDl2bG4rWHdRQitTcmVhSHZDaVV3?=
 =?utf-8?B?RkxIcCsvYW5xaEllOGt1cGhhK0IvMFo4bk00UVBaZDFNYTRZc2hjbTNGSjJH?=
 =?utf-8?B?OUxjWTRKaFFBMU1YdiszMWxIYkZBeXpNaU5OeVd6TlgxUVJGbnRxckZtaG9q?=
 =?utf-8?B?c2hPeEU2OVd5UzFyZzF2aXU2VVV5SldBMWw3cEN2MnBBakhTQnlwNTVnYzlJ?=
 =?utf-8?B?U240NndtaU50L1VpRU1DT0xYKzVLZWpjTTVCN1VpT2RCVzk1UlNMVGVKK3U4?=
 =?utf-8?B?OXZ5VStVLzhsQzBad2VjaHJTWjYycldFcFVqaVpMTEN4L3pKSlhvVUtlMm9i?=
 =?utf-8?B?VWE5WTE5Z0ZUZmJQTncyVnBKMnBFN09LaW1SRVoxU0tpUjVrc1lmTHh6d1RB?=
 =?utf-8?B?ZEgveUxIVVZjOTRLNEVYRlFKaHcxQkM3ZmNhc1hqT3N6ak9vMTdBRFJiUHJi?=
 =?utf-8?B?RFQ5T3BGR09zQjhKd3QwTVkvVkw5aURaZHFsWlhJam8vbTZyUG84Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CCC1165DE65944DB375440E8FE48853@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jZmjals65DBF7PneeendeUDcXHicT4xqEEFrUmLFzcOR/uGrxuTkird6X2jPfAP7sii+OL37J5cv2YWkK4P9G2lQzl0Rl/9QEPnHCeSkD+/Tnizt35dC6/gFIeNtSdGLeZsZ7EdkU9E3rXpkCKh+9eq7r7b9KtPoRKzsMcN97p9KiOByaReIw9Y8sTxYpYcXDTCjfsO6eqpUMCIdm1AQXFNHprVlDS+ydsiwboxmm3vYe7us/2XVrvhtR3ActmhbP5V0HENEDEkZ690LGCgOAvgIAENaWHK4H44Wv572u2FyO4S+71KbRBtlxkDu27DwBNyOoe6HsoFtOJc5nqlOzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1086fb21-308b-419e-9bff-08de7e755771
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 07:19:17.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnoJFutOQd42Ugpr/MDByJAqAf5L/lKyTXwXjqlMdMtKmm2/bgr+BaO0S7Coxypx9NbUO6c1gwSucRkGcGD+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3753124634D
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
	TAGGED_FROM(0.00)[bounces-223767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDE2OjM4ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gTW9uLCAyMDI2LTAzLTAyIGF0IDIzOjIyICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6
DQo+ID4gVERYIGNhbiBsZWF2ZSB0aGUgY2FjaGUgaW4gYW4gaW5jb2hlcmVudCBzdGF0ZSBmb3Ig
dGhlIG1lbW9yeSBpdA0KPiA+IHVzZXMuIER1cmluZyBrZXhlYyB0aGUga2VybmVsIGRvZXMgYSBX
QklOVkQgZm9yIGVhY2ggQ1BVIGJlZm9yZQ0KPiA+IG1lbW9yeSBnZXRzIHJldXNlZCBpbiB0aGUg
c2Vjb25kIGtlcm5lbC4NCj4gPiANCj4gPiBUaGVyZSB3ZXJlIHR3byBjb25zaWRlcmF0aW9ucyBm
b3Igd2hlcmUgdGhpcyBXQklOVkQgc2hvdWxkIGhhcHBlbi7CoA0KPiA+IEluIG9yZGVyIHRvIGhh
bmRsZSBjYXNlcyB3aGVyZSB0aGUgY2FjaGUgbWlnaHQgZ2V0IGludG8gYW4gaW5jb2hlcmVudA0K
PiA+IHN0YXRlIHdoaWxlIHRoZSBrZXhlYyBpcyBpbiB0aGUgaW5pdGlhbCBzdGFnZXMsIGl0IGlz
IG5lZWRlZCB0byBkbw0KPiA+IHRoaXMgbGF0ZXIgaW4gdGhlIGtleGVjIHBhdGgsIHdoZW4gdGhl
IGtleGVjaW5nIENQVSBzdG9wcyBhbGwgcmVtb3RlDQo+ID4gQ1BVcy7CoCBIb3dldmVyLCB0aGUg
bGF0ZXIga2V4ZWMgcHJvY2VzcyBpcyBzZW5zaXRpdmUgdG8gZXhpc3RpbmcNCj4gPiByYWNlcy7C
oCBTbyB0byBhdm9pZCBwZXJ0dXJiaW5nIHRoYXQgb3BlcmF0aW9uLCBpdCBpcyBiZXR0ZXIgdG8g
ZG8gaXQNCj4gPiBlYXJsaWVyLg0KPiA+IA0KPiA+IFRoZSBleGlzdGluZyBzb2x1dGlvbiBpcyB0
byB0cmFjayB0aGUgbmVlZCBmb3IgdGhlIGtleGVjIHRpbWUgV0JJTlZEDQo+ID4gZ2VuZXJpY2Fs
bHkgKGkuZS4sIG5vdCBqdXN0IGZvciBURFgpIGluIGEgcGVyLWNwdSB2YXIuwqAgVGhlIGxhdGUN
Cj4gPiBpbnZvY2F0aW9uIG9ubHkgaGFwcGVucyBpZiB0aGUgZWFybGllciBURFggc3BlY2lmaWMg
bG9naWMgaW4NCj4gPiB0ZHhfY3B1X2ZsdXNoX2NhY2hlX2Zvcl9rZXhlYygpIGRpZG7igJl0IHRh
a2UgY2FyZSBvZiB0aGUgd29yay7CoCBUaGlzDQo+ID4gZWFybGllciBXQklOVkQgbG9naWMgd2Fz
IGJ1aWx0IGludG8gS1ZN4oCZcyBleGlzdGluZyBzeXNjb3JlIG9wcw0KPiA+IHNodXRkb3duKCkg
aGFuZGxlciwgd2hpY2ggaXMgY2FsbGVkIGVhcmxpZXIgaW4gdGhlIGtleGVjIHBhdGguDQo+ID4g
DQo+ID4gSG93ZXZlciwgdGhpcyBhY2NpZGVudGFsbHkgYWRkZWQgaXQgdG8gS1ZN4oCZcyB1bmxv
YWQgcGF0aCBhcyB3ZWxsDQo+ID4gKGFsc28gdGhlICJlcnJvciBwYXRoIiB3aGVuIGJyaW5naW5n
IHVwIFREWCBkdXJpbmcgS1ZNIG1vZHVsZSBsb2FkKSwNCj4gPiB3aGljaCB1c2VzIHRoZSBzYW1l
IGludGVybmFsIGZ1bmN0aW9ucy7CoCBUaGlzIG1ha2VzIHNvbWUgc2Vuc2UgdG9vLA0KPiA+IHRo
b3VnaCwgYmVjYXVzZSBpZiBLVk0gaXMgZ2V0dGluZyB1bmxvYWRlZCwgVERYIGNhY2hlIGFmZmVj
dGluZw0KPiA+IG9wZXJhdGlvbnMgd2lsbCBsaWtlbHkgY2Vhc2UuwqAgU28gaXQgaXMgYSBnb29k
IHBvaW50IHRvIGRvIHRoZSB3b3JrDQo+ID4gYmVmb3JlIEtWTSBpcyB1bmxvYWRlZCBhbmQgd29u
J3QgaGF2ZSBhIGNoYW5jZSB0byBoYW5kbGUgdGhlIHNodXRkb3duDQo+ID4gb3BlcmF0aW9uIGlu
IHRoZSBmdXR1cmUuDQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSB0aGlzIEtWTSB1bmxvYWQgaW52
b2NhdGlvbiB0cmlnZ2VycyBhIGxvY2tkZXAgd2FybmluZw0KPiA+IGluIHRkeF9jcHVfZmx1c2hf
Y2FjaGVfZm9yX2tleGVjKCkuwqAgU2luY2UNCj4gPiB0ZHhfY3B1X2ZsdXNoX2NhY2hlX2Zvcl9r
ZXhlYygpIGlzIGRvaW5nIFdCSU5WRCBvbiBhIHNwZWNpZmljIENQVSwgaXQNCj4gPiBoYXMgYW4g
YXNzZXJ0IGZvciBwcmVlbXB0aW9uIGJlaW5nIGRpc2FibGVkLsKgIFRoaXMgd29ya3MgZmluZSBm
b3IgdGhlDQo+ID4ga2V4ZWMgdGltZSBpbnZvY2F0aW9uLCBidXQgdGhlIEtWTSB1bmxvYWQgcGF0
aCBjYWxscyB0aGlzIGFzIHBhcnQgb2YNCj4gPiBhIENQVUhQIGNhbGxiYWNrIGZvciB3aGljaCwg
ZGVzcGl0ZSBhbHdheXMgZXhlY3V0aW5nIG9uIHRoZSB0YXJnZXQNCj4gPiBDUFUsIHByZWVtcHRp
b24gaXMgbm90IGRpc2FibGVkLg0KPiA+IA0KPiA+IEl0IG1pZ2h0IGJlIGJldHRlciB0byBhZGQg
dGhlIGVhcmxpZXIgaW52b2NhdGlvbiBsb2dpYyB0byBhIGRlZGljYXRlZA0KPiA+IGFyY2gveDg2
IFREWCBzeXNjb3JlIHNodXRkb3duKCkgaGFuZGxlciwgYnV0IHRvIG1ha2UgdGhlIGZpeCBtb3Jl
DQo+ID4gYmFja3BvcnQgZnJpZW5kbHkganVzdCBhZGp1c3QgdGhlIGxvY2tkZXAgYXNzZXJ0IGlu
IHRoZQ0KPiA+IHRkeF9jcHVfZmx1c2hfY2FjaGVfZm9yX2tleGVjKCkuDQo+ID4gDQo+ID4gVGhl
IHJlYWwgcmVxdWlyZW1lbnQgaXMgdGR4X2NwdV9mbHVzaF9jYWNoZV9mb3Jfa2V4ZWMoKSBtdXN0
IGJlIGRvbmUNCj4gPiBvbiB0aGUgc2FtZSBDUFUuwqAgSXQncyBPSyB0aGF0IGl0IGNhbiBiZSBw
cmVlbXB0ZWQgaW4gdGhlIG1pZGRsZSBhcw0KPiA+IGxvbmcgYXMgaXQgd29uJ3QgYmUgcmVzY2hl
ZHVsZWQgdG8gYW5vdGhlciBDUFUuDQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSB0b28gc3Ryb25nIGxv
Y2tkZXBfYXNzZXJ0X3ByZWVtcHRpb25fZGlzYWJsZWQoKSwgYW5kDQo+ID4gY2hhbmdlIHRoaXNf
Y3B1X3tyZWFkfHdyaXRlfSgpIHRvIF9fdGhpc19jcHVfe3JlYWR8d3JpdGV9KCkgd2hpY2gNCj4g
PiBwcm92aWRlIHRoZSBtb3JlIHByb3BlciBjaGVjayAod2hlbiBDT05GSUdfREVCVUdfUFJFRU1Q
VCBpcyB0cnVlKSwNCj4gPiB3aGljaCBjaGVja3MgYWxsIGNvbmRpdGlvbnMgdGhhdCB0aGUgY29u
dGV4dCBjYW5ub3QgYmUgbW92ZWQgdG8NCj4gPiBhbm90aGVyIENQVSB0byBydW4gaW4gdGhlIG1p
ZGRsZS4NCj4gPiANCj4gPiBGaXhlczogNjEyMjFkMDdlODE1ICgiS1ZNL1REWDogRXhwbGljaXRs
eSBkbyBXQklOVkQgd2hlbiBubyBtb3JlIFREWA0KPiA+IFNFQU1DQUxMcyIpDQo+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBSZXBvcnRlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNo
YWwubC52ZXJtYUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FpIEh1YW5nIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4gQnV0IHRoaXMgaXNzdWUgaXMgYWxzbyBzb2x2
ZWQgYnk6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2MDMwNzAxMDM1OC44MTk2
NDUtMy1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCg0KVGhpcyBkZXBlbmRzIG9uIFNlYW4n
cyBzZXJpZXMgdG8gbW92ZSBWTVhPTiB0byB4ODYgY29yZSwgc28gaXQncyBub3Qgc3RhYmxlDQpm
cmllbmRseS4NCg0KPiANCj4gSSBndWVzcyB0aGF0IHRoZXNlIGNoYW5nZXMgYXJlIGNvcnJlY3Qg
aW4gZWl0aGVyIGNhc2UuIFRoZXJlIGlzIG5vIG5lZWQNCj4gZm9yIHRoZSBzdHJpY3RlciBhc3Nl
cnRzLiBCdXQgZGVwZW5kaW5nIG9uIHRoZSBvcmRlciB0aGUgbG9nIHdvdWxkIGJlDQo+IGNvbmZ1
c2luZyBpbiB0aGUgaGlzdG9yeSB3aGVuIGl0IHRhbGtzIGFib3V0IGxvY2tkZXAgd2FybmluZ3Mu
IFNvIHdlJ2xsDQo+IGhhdmUgdG8ga2VlcCBhbiBleWUgb24gdGhpbmdzLiBJZiB0aGlzIGdvZXMg
Zmlyc3QsIHRoZW4gaXQncyBmaW5lLg0KDQpJIHNlZS4gIFdpbGwga2VlcCB0aGlzIGluIG1pbmQu
DQoNCj4gDQo+IFlvdSBrbm93LCBpdCBtaWdodCBoYXZlIGhlbHBlZCB0byBpbmNsdWRlIHRoZSBz
cGxhdCBpZiB5b3UgZW5kIHVwIHdpdGgNCj4gYSB2Mi4NCg0KSSB0aG91Z2h0IGxvY2tkZXAgd2Fy
biBzaG91bGQgYmUgb2J2aW91cyBldmVuIHcvbyB0aGUgYWN0dWFsIHNwbGF0LCBidXQgZmluZQ0K
SSBjYW4gaW5jbHVkZSB0aGUgc3BsYXQgaWYgdjIgaXMgbmVlZGVkLg0KDQpIaSBTZWFuLCBQYW9s
bywgS2lyaWxsLA0KDQpJdCB3b3VsZCBiZSBnb29kIHRvIG1lcmdlIHRoaXMgdXBzdHJlYW0gYW5k
IGJhY2twb3J0IHRvIHN0YWJsZS4gIEFwcHJlY2lhdGUNCmlmIHlvdSBjYW4gYWNrIGlmIGl0IGxv
b2tzIGdvb2QgdG8geW91PyAgVGhhbmtzLg0KDQogDQo=

