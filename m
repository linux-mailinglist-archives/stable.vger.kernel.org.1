Return-Path: <stable+bounces-249780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDUXOE5rDWqHxAUAu9opvQ
	(envelope-from <stable+bounces-249780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:05:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 890225895EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBFED3025AF5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C54A35;
	Wed, 20 May 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N51TET1o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D87371CEC;
	Wed, 20 May 2026 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264331; cv=fail; b=m7XFP/E1VBWiALzuLVquChy8rZ30LVfs+oRK1y4pf5V840hqnd58+qVj6PRVzVgdbsiWKPldaBZD6gLJJQrXqHsmcZ9/3OrNOn/0GhGTrfzc+F8192cCKxCLnz/o1v/jY/+3CqQBFgxJQmiZG1TpsGmyOpVU57OsYMM2mFqB39c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264331; c=relaxed/simple;
	bh=n25HF2xHc3agstvw2ov5R0Ij5wHnnetjxApLZ2uOQ3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAh7dMPcspke3sxOwT4CteBX7+MqjM2HsIcdxFbgKh3MaieOUXt8UiKfnf+GJNtFAzxAfdYTO2vopH+A3QNM0DyNjkDJmeGu4EJ+J7ODtsPp15MQy4BO1gqXIhJ9JXOaI6bPuZmfWuqx7cr+9Y/ugl171srQXeJmk8Szt2auJhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N51TET1o; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779264326; x=1810800326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n25HF2xHc3agstvw2ov5R0Ij5wHnnetjxApLZ2uOQ3A=;
  b=N51TET1o2ffQo2jZy7P4XwMpD5JehVy3x95LWREgSrTRMd55AnlH+hyK
   ate1H+0dQJg1BKEM1TS35XVBL51k5gFGpyz28n1nD4mbgpyzBwaevTaQr
   sMlEk0MX1NHsgDiQ/CHTuvBBA9Ma1U/1P8+Pea5HYlNXLMG39FmLCIB2b
   yVG1BdyynpkQLaGqPiKoaETDupAa7ZKyZCdgkp396wth37FVvDS1RD3o/
   hZ2wIBadiaus6HNV6TS9MJ25YgX4KaKoE1ZDC0u2ymr4/ERMzoKhNvvEs
   +/aQyDYcW59bI2mlUqsWxDQ6b4DQMgWJFJ2KlgcylAv5iXAtebbV5OY8r
   A==;
X-CSE-ConnectionGUID: cfyAs0PlTbOmOBfBjEKjFA==
X-CSE-MsgGUID: fPbocY+fQeq8sYNMnnedoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79302261"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79302261"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:05:23 -0700
X-CSE-ConnectionGUID: X7ri12axS7SOMjZ/G8Iwlw==
X-CSE-MsgGUID: vELckDZSQ5eyjXK0U2hAqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="245074445"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:05:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:05:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 01:05:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZY1O68BLWj1jBAiXxDWVGPpcxJJ6RZSGcpunpQ2cbHEHaNPIclfXkoW84ukyjr8ycCTQj8pJgktw9zujav0X1Ebgg/3WlHckTHOxqKeiHFQHNyvTg4Mx78+TTVh3RwQHiG2eybYqBoR9iyFrX6hi79P8FbmzquBVRIBPOUJwPS4mwPoC/JAW/HANaBB4YQYWUIIFgujAoCtgqQx/uiQ4e1atUvvKoFs9QWXEQ1PeGEkcdyMAMHbCdQt6hzeF4TYiZqxUqfhCPNO/OBgQxLtheQCqclLvLpR3UJcF7jtzOKFBrhz9DRdH4kysaYz3weAo31/eovtbWaioMzjOfChMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n25HF2xHc3agstvw2ov5R0Ij5wHnnetjxApLZ2uOQ3A=;
 b=oV8kyKZukTjRzoKET2g2WGwwF6cx+9/ZASvKmPR8YvIJ7T/zVzZ0Xgx7Qzgt7AtR+fPbBh1c4cfWk9zAKlzYw+rG+emkKx4z2Q6tuBwKIDkDvtRaPHKA4UuCgEa2Yd1KvjCd2Cl5K1Twco7mT2g7+3GuVGzTfCF8zD83PxOsItBJzAtjg6vFUt2+Zd5AICTbxrGXpQFg1MgtY0JIiMt/eiFq/SgxEsXmHCYcmH61C+46Avo459pFyVZKubzoJDJCYoEEDSmgutZ7vZLpC7hqMjSoIDTgnw8G3nbETeKuXP/qm85SHq0anN+TgonXzj+sAtl6hzTt57gYVPNCdMdXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:05:13 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:05:13 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Jose Ignacio Tornos
 Martinez" <jtornosm@redhat.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v5 3/4] iavf: send MAC change
 request synchronously
Thread-Topic: [Intel-wired-lan] [PATCH net v5 3/4] iavf: send MAC change
 request synchronously
Thread-Index: AQHc18te1C8zWmZY5k+2ZgR3qQtVG7X18AqAgAARwoCAIK1VQA==
Date: Wed, 20 May 2026 08:05:13 +0000
Message-ID: <IA3PR11MB8985B550A8320A6349C6E5238F012@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <IA3PR11MB89861527E138BBA14FA907DCE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260429120047.218369-1-jtornosm@redhat.com>
 <755876a2-92ed-42bd-b93c-10faa5b6f249@intel.com>
In-Reply-To: <755876a2-92ed-42bd-b93c-10faa5b6f249@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: 6df9363c-1ade-4b82-3537-08deb6468592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: gJiIhQ4GBge5kG2Lchsyupk1z8Wjpyba0LwgZ/6maGqqsEJcfymG+3CI9t8JZGsLwQbTHPbFbm/VUmVfX2leLQrmKxuL5AEUbdXn7JOesVT+jqFi8Z+/mvHisDtKCv9QIu3QH4BcvORLF1nBSAhW1y6c6VpPPMCEbq7b3+oyu7XZ3oy+o8r++pMAlEbFHoyCo02LEfwdxnneZnvmJ93ZR8rWzAQNyxkW1g8eYiHRx/5nr5tairqviNRm96LcVjllTLnkpcU7Y2v6CXZmEDM8e+IJWmi96jYSS3m91lsRhhQpSX2lPPHmO08y8MRVYXSh9rRSh66RKpHLdqcLHG1tGy3B/5cBtG09oi3xxIWn1vRgd/fWWp4Q3t5biqwiHu7CDrFgtzHWXS+3Q/55YcJtt3+IdhXnaezlPvhHueuTefqAxZ/8UT559NDnijcCSMSz/F/nvDnFfcE+s+1DrTuY0wUj9SOCVGEQSZHnlfCc8IhI4XOL8WYjctcEz+/PaPT9NJ5I3YSMxUAajVU/Gg8hOdAUIBXRJiUr6FMYE0V+tq36UCunKhiCwuWcUWcaDD2vroKYjkOaeKh9lM1Yd0ww9ni7TEw5Cr0mdiKDsl0nao2TOYkLeIbHzeGuaEh7GVDvu38f7df5L0tLboIDMTvkK5/61rdwfbBdWwFcnEyxou/9fAJQSVbgL8xtfT1cUB+7axuH/tKb2FuXesVHn9nGFfdJgJvVkwN1LanCZ2mSHXtt53sB51f6MqwwcWhLqcbs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUQ3RDM1ZFM5MUhBRFdpLzdDRHNVNUFOb3Z3dGJBYUZjTGk4V3JQYW9aejRk?=
 =?utf-8?B?Q3d1SFpXUFZueW83RXFBWWVYeXZ4enZrRjA4VnpyVXkxeTBvN2o5SkZJUWdW?=
 =?utf-8?B?eVNYR1hvQkVFRUZSaDhTY1NQYXZQamsxcFFwTG0yWEp6Rnc0ZXljYWpIS2JU?=
 =?utf-8?B?NUpkZ0pMU011ZzRLcDNvQ1VQaUNBaCtvZk5ueFRqd09iY1pCS1I5OEtXWm84?=
 =?utf-8?B?SnJxZHdrVkdXUjY5cVg1SDNRTnc1d1czVXdBeGZQMXduNmN0QjYrcGJBSzdw?=
 =?utf-8?B?Ty9JTDNieFRPWE5NOWdYVEgrbHF5YURnNGhkM01iY3h5dzBkekN6OWI0NlF2?=
 =?utf-8?B?K0JiRkxpTGVjMlkyL29HNVRFK2VOWHZGOW02YUNUNXJXVVpvd1RvYjIvdGQr?=
 =?utf-8?B?SmJMaTBac2l6L0RKWFZkL21wUUJiV0JjQWxVNERoTURhRy95RWZJOFk1MjZY?=
 =?utf-8?B?M0ZoZzVwU3FvWEJQaFQrOUIxejQrcy9aYWtTVzE1eEZoVWxsMGZ4SjY5OGlC?=
 =?utf-8?B?M1ZzVmlrUlB1V1luWGZTOUlwcmdJaVRIb2RrZDhEM1RVN1dIVmVQZlBKVzQz?=
 =?utf-8?B?M2h4TFpZRWlTSnhKNmhLZmVwN29xbFpYVDA1d1F2V0kwVGZSckV6ZnFyWC9B?=
 =?utf-8?B?UTBFemhvQnY1Y1pMem5xQTZEbU82KzY5TE9YZ3FzMlgrc2ZBQnZkUkwyS1Ru?=
 =?utf-8?B?SnEvTUhnOFJyWm1rUm90UitJMEdoSGJlUEpkb2pOTllSK1p4UG1iMnlETjVw?=
 =?utf-8?B?c0hnZ1JDZ3ZUVFE5d21pUU4zTXN4S3EwcGNkbVU1OHE3Q01WZ1dtTTZuTVRZ?=
 =?utf-8?B?YmFZTTFIY0RUS2g4NVRDdEJIUUNMc3hHWk9hNWIrblRyWVR6S2U0dUlMZEJT?=
 =?utf-8?B?ZVk5S3p5aytFVDJkSDlBVkVJc0VqNGhRTlJOZ0d3ZFJia2wzc293aXpRR2tI?=
 =?utf-8?B?bmQ2emhMeEZhY3NHMnhRVUp0SlNtSzI3R1pxRXZvUys3SFdmQ0dhbjBiaFB0?=
 =?utf-8?B?SFdGampqRlgyWDExTVh2VE5TTjJ4TGxub2E0L01yU2d5dE5VT1FQVWUrYjA3?=
 =?utf-8?B?MmRLVm9wOEMxRGt2bW5jWEpKWXEwYXQ0NUlGRUxuME1yWjZScDdxNkxadTJx?=
 =?utf-8?B?WFozcDhNaDA0Z2FLU3FzMU41WkVwVFFEZUJuNlFTYXZ1UVdMR0Z6eC83dkg2?=
 =?utf-8?B?bWN0U0tWc1dJZGxwd1pMbjRTNTlRb2ZqZld1UHJ6OENjNk54UjBvSzZ4R3Bx?=
 =?utf-8?B?OUE0OVZHZjFYcXRBRUw2Qlg1YnR5WmpMc2tUNEpYQ2JUUFlFaVYzWUlHT1Vk?=
 =?utf-8?B?UlErNWpPang5Rmd2bmNuejRPVmEvSGQ4TVlkTnBJYUVPbE4rRVFLWTdDc1k1?=
 =?utf-8?B?bGVBTnhPbldpWFZTWHRLTFROTFVvcGxUbTAxSXdiTGorYm8vc1VWakd5ZHlW?=
 =?utf-8?B?S094dG9Qd3NmMzFNOGp6TEdtUmdtRU1XbTRzdGswa0ZaY01NT20zWTN3ODNz?=
 =?utf-8?B?dHlFQkRUKyt1UlRJN0dUa3hKc1ZETGJSaExsWXdWblJqSXRSc293RzNtaXls?=
 =?utf-8?B?TnlzR1pZOHB1WFJEbVlhdGgzaFR6V2RXQlJXbmw3cFBsTStHaXEydUo3WExT?=
 =?utf-8?B?VFg3SEFJeG5XRXFlNWRmR3V2dXFMdFp2K0dYckVxcCtGUXFYa2d1cVdvbndw?=
 =?utf-8?B?VURCenF1N21lK1pnSEJFS0h2U2kycXhTZ05ZeGxjL1lnTGlLYTcvOEZzSnky?=
 =?utf-8?B?T2M5c3BVdmJNbzVld1A0OGRGakZ3WkNJb3Z3SllUbTNXalF2dUkrdWlLSmZ1?=
 =?utf-8?B?a0x4T0VXbG1lQUFzL3gvbFB5UDVPRU5NY01WU3U1VEhrajJLRGh0TTFLemNW?=
 =?utf-8?B?UzVyWEJ3QlJ6bzh1T04yeTBWTkZwdUgxOU1YWTQ5N3MzU0VYNkRWNHFSQktT?=
 =?utf-8?B?SmU3ZlFBNEROZTEzKyswWUcrd0pqUzlOaUxZeFZrRm9jQWxxczR1YXZ2VlNQ?=
 =?utf-8?B?bjRuTDFUS1FoajM4eEQ2SUVHNi9vS0REUUtmWnQwb2k5SGpNaXVqbDFYekhN?=
 =?utf-8?B?aVU0NnhhaGZqNGRZWkdjSU9CdFlNN3BBL0QyVU1UTUIxcXdTSWR4NVBUSXcz?=
 =?utf-8?B?eVR2aTJjUEhMc3NrcVBDME1iS2hqU1NCTUk5eWxVbm44eHljM1hRZ21UTE1m?=
 =?utf-8?B?WlRkK1BJNnlBNk1RMUJCcE5IMXYwaUV0OUVMbFVCZFg5SWNab2grMzBMWHZI?=
 =?utf-8?B?Y1UxNzFTRDdqekhWS3NEbllncnRlT0dTQVdLQmJlcTJYSEN5Vkg3enV3NVZ6?=
 =?utf-8?B?b0c1bnVreFg0SEE3NjY2U0xha3lKNkRNbFd3U1FzRXYzemRGQ1NmUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KvvGBt4sdUCpm8nsCy1m8jDBG33rYQeLOxLLvec2XD076gbwizM9Cqp+PohXRszymS6imCB4d+p97CjENYaRfEIfGz/XYe+n+q3gk2pC4LZUOMLiCjNh8qMOzEfvn2mxODQhnzDo5zKag+amTq83qq73g9d9dxgnqosxE5Ym6jmSqQfyrgaxLDL2Lhj2WNF/YGbSgNuB/SHX1dFKStrf+bUiXuvJ9mRnbAgUCsgbQSjqhSReg74gR3Heqy+3RV0wh0NLRMFN4inhW7pSlTBEVM/2Q4wuVJOp6mmr/zEMXJzsiHwJzXqg1n1mYbg2G5FPHzmIS439zsn/aZ5dLp4fcA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df9363c-1ade-4b82-3537-08deb6468592
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:05:13.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JwiowcttgtoIb7sXMu6Xq69/dC4TBWqBfZgs1Ty/IjDCy962u8hsWj6AEnNBpSW/OtuHCRcnFjrk977hjH3TZIsy/32XuejB+0ov1lTQgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 890225895EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQcnplbWVr
IEtpdHN6ZWwNCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyOSwgMjAyNiAzOjA0IFBNDQo+IFRv
OiBKb3NlIElnbmFjaW8gVG9ybm9zIE1hcnRpbmV6IDxqdG9ybm9zbUByZWRoYXQuY29tPjsgTG9r
dGlvbm92LCBBbGVrc2FuZHINCj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBD
YzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsg
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7DQo+IEtlbGxlciwgSmFjb2IgRSA8amFj
b2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgamVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb207DQo+IGt1
YmFAa2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207
DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1s
YW5dIFtQQVRDSCBuZXQgdjUgMy80XSBpYXZmOiBzZW5kIE1BQyBjaGFuZ2UgcmVxdWVzdA0KPiBz
eW5jaHJvbm91c2x5DQo+IA0KPiBPbiA0LzI5LzI2IDE0OjAwLCBKb3NlIElnbmFjaW8gVG9ybm9z
IE1hcnRpbmV6IHdyb3RlOg0KPiA+IEhlbGxvIEFsZWtzYW5kciwNCj4gPg0KPiA+PiBJIHRoaW5r
IGNvbnRpbnVlIGF0IHRoZSBlbmQgb2YgdGhlIGN5Y2xlIGlzIHJlZHVuZGFudC4NCj4gPiBUaGF0
IGNvbnRpbnVlIGlzIGludGVudGlvbmFsOyB3aXRob3V0IGl0LCBpZiB0aW1lb3V0IGV4cGlyZXMg
YnV0IHRoZXJlDQo+ID4gYXJlIHN0aWxsIG1lc3NhZ2VzIGluIHRoZSBxdWV1ZSwgd2UgZ2l2ZSB1
cCB3aXRob3V0IHByb2Nlc3NpbmcgdGhlbS4NCj4gPiBUaGUNCj4gDQo+IEFsZXggaXMgcmlnaHQs
DQo+ICJjb250aW51ZSIgY2F1c2VzIHRvIGNoZWNrIHRoZSBjb25kaXRpb24gY2xhdXNlIG9mIHdo
aWxlIGxvb3AsIGFsc28gZm9yIGRvLXdoaWxlDQo+IA0KPiA+IG1lc3NhZ2Ugd2UncmUgd2FpdGlu
ZyBmb3IgbWlnaHQgYmUgaW4gdGhlIHF1ZXVlIGFuZCBub3QgYSBsb3Qgb2YNCj4gPiBtZXNzYWdl
cyBzdG9yZWQgYXJlIGV4cGVjdGVkLg0KPiA+IFRoYXQgY29udGludWUgcmVkdWNlcyBwb3NzaWJs
ZSBmYWxzZSB0aW1lb3V0cyAoYmVjYXVzZSB0aGUgZXhwZWN0ZWQNCj4gPiBtZXNzYWdlIGNvdWxk
IGJlIHN0b3JlZCBpbiB0aGUgcXVldWUpIHdoaWxlIGtlZXBpbmcgdGhlIGRlbGF5IG1pbmltYWwu
DQo+ID4gVGhlIHRpbWVvdXQgaXMgcmVhbGx5IGp1c3QgYW4gZXN0aW1hdGUsIGFuZCBJIGRvbid0
IHRoaW5rIGl0IG5lZWRzIHRvDQo+ID4gYmUgdmVyeSBwcmVjaXNlLg0KPiANCj4gd2l0aCB0aGF0
IHNhaWQsIGN1cnJlbnQgY29kZSBpcyBjb3JyZWN0DQo+IA0KPiByZW1vdmluZyB0aGUgcmVkdW5k
YW50ICJpZiIgY291bGQgYmUgZG9uZSB3aGlsZSBhcHBseWluZyAoaWYgdGhhdCB3aWxsIGJlIHRo
ZSBvbmx5DQo+IG5pdHBpY2sgbGVmdCkNCj4gDQo+IGFmdGVyIG1vcmUgdGhpbmtpbmc6DQo+IGlu
IHRoZW9yeSwgbm90IGNoZWNraW5nIHRoZSB0aW1lIGJ1dCBwcm9jZXNzaW5nIG5leHQgbWVzc2Fn
ZSBpZiB0aGVyZSB3ZXJlIGFueQ0KPiBwZW5kaW5nIG9uIHRoZSBwcmV2aW91cyBtZXNzYWdlIGNv
dWxkIGNhdXNlIGluZmluaXRlIGxvb3AgKHRvIGZpeCB0aGF0IHdlIHNob3VsZA0KPiBzdG9wIHJl
ZnJlc2hpbmcgInBlbmRpbmciIHZhbHVlIGFmdGVyIHRoZSB0aW1lb3V0LCBidXQgb25seSBkZWNy
ZW1lbnRpbmcgaXQgLSBidXQgSQ0KPiB0aGluayB0aGF0IHRoaXMgd291bGQgYmUgbmVlZGxlc3Mg
Y29tcGxpY2F0aW9uKQ0KPiANCj4gTXkgUmV2aWV3ZWQtYnkgc3RpbGwgaG9sZHMNCj4gDQo+ID4N
Cj4gPiBUaGFua3MNCj4gPg0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IEpvc2UgSWduYWNpbw0KPiA+
DQoNCg0KVGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxyYWZhbC5yb21hbm93c2tpQGludGVs
LmNvbT4NCg0K

