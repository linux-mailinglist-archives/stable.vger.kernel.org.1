Return-Path: <stable+bounces-161623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC4B01163
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 04:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BD1C45514
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6F191F74;
	Fri, 11 Jul 2025 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dit+Hem2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2910E9;
	Fri, 11 Jul 2025 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202222; cv=fail; b=pIPfNmOslvUJocm/EocfknSy+/Nh8Tp6nZ1LC/4MLWtTv0VIPVss8wbHJDoGStSK+GqDMtZZWGxRY1pI6jSXN6NuxleZ2fPoz+CHmgDrqqdbQpW0FciPKua/VpVNdb38IaRy3sRnXh6nrLwEL6dXMCT4iOQwJAl/1IM0k36qDQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202222; c=relaxed/simple;
	bh=mkjanZLohmnxAv8t2LQ3JkXAp1dTn2a1LrK9brSBdNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUM94/gb1MyvuYfCN6ZTznqfifWIhDyBnT8+aE93LT0AsSi6vT1S+pl+wzQaAEY3nosPe3VLmgaCB6aLuIIHhJqD+QjMdb7BaDwh4sR/1XMt2jWQB01ZMxnbft1sI6MbqE72nru6VdvgDRHx2hVz+IZJzCQ9qlnPpc7gpV6GFVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dit+Hem2; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202221; x=1783738221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkjanZLohmnxAv8t2LQ3JkXAp1dTn2a1LrK9brSBdNA=;
  b=Dit+Hem26hS0fB1hEVyN3mGEdDwhodm5l10JmgcV1tceHIBK3LaBwXxb
   kODFHpiMa7eX6R+VThl4vwlKUlyFT8bcVyd4HNfKJ+tCdbOU1BeO/e5OP
   cskF7Wrn1Y9uFcYU1ZWXx1iVbAPQm89OEuZmmkFJmEbkP9H8eNMAb0TFw
   CSGgWagAvPehf+IEQQ8emA9d7QH/oVmTkx0wGe/Sou6ck30lhbAQKt8z2
   v3c4FZ/wtdpNREEtKkSy4/29aXUjVQjpKrqiGuRDqDXHNQXoAUVEcQvEb
   pb9kxwz54J8jn/aTLELTTS9rLidZqgVrWPWKiv3hQZy9Mk1QIqFxW7P1O
   Q==;
X-CSE-ConnectionGUID: 97eBsUWnTZe4Ty8rETB6mQ==
X-CSE-MsgGUID: Ol9W+jDOTviVtsxUZxBZtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65945981"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65945981"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:50:20 -0700
X-CSE-ConnectionGUID: 1tV+em1uQLK0wZ3e5np5vw==
X-CSE-MsgGUID: 3O4kHc7DQrigvt5qLF5cBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156744856"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:50:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:50:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 19:50:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 19:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3gN5KSwh1xhqorO0+8lWTZEtnNfXTJ7AGbC//Lg8F9fQvy9SYP7aohmTn1VeOUTbOcjMM8LS4SWUHgVX6+CdPX78P6yLRdt+rNcVbILcoPGTVWGg5rrfmu3jlSLSqZeX4aw/8D0xVQ39ujIcFyTRc+7g5mpqKZpW8Cp0Qz/TV2pvoG1EUbmT6xVo6di8LULHiBvRCk9h34O9DCH6XBzRZHjt+fE9nroJOt7WvE84p4bDDbvmgZOPu3SJLlt8/La58YUN1axrDmazkeE1kNuYNa2TBcfppVkZftsDN63jYMqOdbLLhN8/YsRD/scD9ZhZIjnTy4m33AUbZdapBJzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiyjlPAaFwB2LYkNVjmYKto/uYzdGoLN6QMzg8nbVKg=;
 b=U/s/jOwmBqAZGfepdrrpGMIOKfULVKsFG/La1ZKD5k0837ATnNlyJhS70y5PbZrS51XeGFpttF3uAj3A7wc6neOJgrfni/pc20mqKz5spp0jO9B+OhIzMzJ1RjDM9n9QE8HUlbWyG5onBFMQEQzp6tjiUxpZcX+l9MIUowrhrHZNCMnStsmz4hEiP6YB0locefdO/WZwts0HPinZkwMjV8kRTBKzuA80ZKVKuxFPJdHgdpGD1gQWNfW7ohOn2fQrlvvMigitBTnRoFBq4SAcL0btaw7lsIjC0IJFZg6dvoSZCmzE/cTzeh1zXbzOLFoTi/VTPOWH+wccUDCLkqE3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 02:49:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 02:49:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Hansen, Dave" <dave.hansen@intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki
	<urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQp63CAgAC0NoCAALJYAIAACDAAgADgpfA=
Date: Fri, 11 Jul 2025 02:49:35 +0000
Message-ID: <BN9PR11MB5276185135D3917DD04E72C68C4BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
In-Reply-To: <20250710132234.GL1599700@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: 3678599b-2b8a-4cb1-4b66-08ddc0259214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4JxF6SFUSVYEMJo4tPt0OCI3V2d/auVKlsikxHVZlyY94iKuWx5mwlOl8Mtn?=
 =?us-ascii?Q?9rNMyBvZtXey23j6E8hX8CnjoVKEJ7GOm6x4KwJ2wdV2o0zIyKKjjiCPuzfN?=
 =?us-ascii?Q?WtAYNmqfww33r7w0doSvbQqIdSKcRD2YjutSHp+iqdsM3FQRg31NU3cOndmV?=
 =?us-ascii?Q?Aihu/nI4t+9qogSZYbzPx3dwWS+bhngskuspkfIEpawR4PT1Z3UtKZ3u0ZuA?=
 =?us-ascii?Q?mt8vtTaH5qu137qF7gOspS+PosbjJKQeBoq+xEq8ROkoHWGMjlwiaO/YMTJe?=
 =?us-ascii?Q?mW9oP9hCJtqt8Qi1jhYGlBlkfsxG8dBzBzdnjzYBj0AVB7je1QeXX2xRi+OT?=
 =?us-ascii?Q?8oLGVmbYLB4t1FzrocZMGXqqMrQ6Eio62THdFCBXiGNIRlle3bujnjGWOHhK?=
 =?us-ascii?Q?RZMShkf8rubdEV/f8JEQwwjqkfYG32q6m5GD22J3JAjg5ddOPAFXXtA0JecJ?=
 =?us-ascii?Q?iRrN84yog+ZzbFJyd9qwcuCGJCNYDnqmw7GQ5QmvkE+IrT80Y3QTlacybjiN?=
 =?us-ascii?Q?IqFYxeVnVyB8kaG2h10lNn6hSp12akXQfAtCTKwWptXxM7XjwVW13f50xJsz?=
 =?us-ascii?Q?wMqJtUl+TtlqOAOT8LhRmhd7vBG3kG8eVlHWXzBvW9euFF86VbkQs0/YCyr/?=
 =?us-ascii?Q?yDRVPEinHzT1kZruTKY1GfcBnbMpqz/7Vzvwh31UjzJkzkrrhb1KAAYYkXoI?=
 =?us-ascii?Q?IQwcJz0/aPx2iSkeC4JX2Z0DChKDfKzmRB2B08pDB58jiR8ECRKNVRhYvDmp?=
 =?us-ascii?Q?o5BBNrdxZ9iLva9sCDP3VtiAXk4IpXXFPCZH7h9MtSsKoVkTAPsUr5UxgRqx?=
 =?us-ascii?Q?yts0xhtNEf1Z2OZ3EqKAIXyqxQWiEhuLaqLuSmXoY/CCCe6GbOUNdejZxS5h?=
 =?us-ascii?Q?HFIN/osNLnn64qVYqLnRxQ5hHl9to36IIHPZ9a3Sl7CvTDY0afq3vJh4wMFu?=
 =?us-ascii?Q?PCT+02OTsUStVO8dKUmOrJKtwGCbA6Fydk5yWwMQnxbWaIjnI/9hKaq/hG2i?=
 =?us-ascii?Q?4Ut36G6xcJaJJH9w6dPJoShZzzACTV0d+KlVpOWSU4jWai4Wfk1r/UAS4dCD?=
 =?us-ascii?Q?ZWH5L8SL/Bn2i2r0bcC8xe7uTqXc3LiQtjbRCVWMTFdJ95koB0s0L1s7RM6w?=
 =?us-ascii?Q?yqDQk5UJIQQ1fH3nQ9rRhHVk6Mkjn3UhnsfbADuOxkXZhTtxF58YUytNSGAr?=
 =?us-ascii?Q?uXAG+i8HLd8Nu7n7iuLEYlc0oK4KRaP7KU5j/zyJ73xK/8aUPulkLiSguFZp?=
 =?us-ascii?Q?so1VmiMFttIac7RaG2Nbo177bV6GL5HysKuMe/CsWM6sfQe5r0TadXcSzPNA?=
 =?us-ascii?Q?YxtRJJJ2lnxmUmIzjVuqnb6Ri/dSxPZdVr/tzLgAGdQ6085RJ3NtQDj64HpY?=
 =?us-ascii?Q?RL0s2zvbrNqIMrh28IG9opvDMDzsOjhAh4CoPjrSPkcwuhWaUsqzibmCmOcf?=
 =?us-ascii?Q?I1pBfyG7IyDDcrkWQj66+LvZ0CMEoGAyA/u19WFORg851RFZRIMyvz+nx6bs?=
 =?us-ascii?Q?7sviL4VrblJceLo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q3TRQA8USli8ASdsg1ZmbThBchHqghISFhZiDmuGdODR2sJz5xzqC1/Kj4Jv?=
 =?us-ascii?Q?JkG4D01ByikKHe9aRDVUr0U/M9yj809PkQmWCwmTik0uuEcGTCnDmuRO9y08?=
 =?us-ascii?Q?DU9untdRIqrtLqXN0Q+Ws9L/D+zfWzdDAhssmlRRQ/aPLtc8KFUg2MX9UiAf?=
 =?us-ascii?Q?5NN0zrGlS/jkLPD7ydF8qwAveY8nUbCvQZk3xUEPCo4oX0ECU00qcSZ0QvmW?=
 =?us-ascii?Q?+71VOhvAG16G5JeOeBSxLEH1VCnryuO91KlAZVS2fYDq2P9XxhLm11CUhQ0h?=
 =?us-ascii?Q?5y7O0m6PSrHl13YgVeAdFdDVjpawLhq1US/z7gL1QOia7Tez+yr2vits4xIx?=
 =?us-ascii?Q?SYKEwYckHsgJAgOmu58rNvlN7VyFCnPIbbU6e5VfipZQYR2HJj7z8urcZHfq?=
 =?us-ascii?Q?l0nGihXwMbPPiv05VUuUWdFYrurM9eHxhEqsTLh+sXYHcdNwGX+9pm+8a5WX?=
 =?us-ascii?Q?WYPB0s1t24u0h9pQzE0JSlDYvKnQTosK9V6a+/JOsMfhkXLFlkp1qi8psfTV?=
 =?us-ascii?Q?Q8DHYUTmk70OmgmdUNGMU9fgGzWWWugnDhGGqLsMFHrhJvKNDpI9XhKxUu+l?=
 =?us-ascii?Q?ooQlEk9WskhZfYhWHipBmG11DLruNBt+ug0lIeX8DMfinqDok9aGDvF/4Ne0?=
 =?us-ascii?Q?iFg1XVCcND/9MpFWdkxSNIAy7NJPDo7z5OpakwKjlmj+lnnLN01mdk3HBgUG?=
 =?us-ascii?Q?UFY4r4rtGn400Yn/i5JzsoHDsFETLLjHzIo4HYIiEVjAOEduZ/VStcEMT5Jd?=
 =?us-ascii?Q?rMrv2+Vd/wdroqQLE5If/BkIui2qZFNBDzsjqYy1u42W7IkdBQYkgUUI7/Uz?=
 =?us-ascii?Q?cSV/+HFCNKaITU/lKHvmrh2CyIATbKSTR2+am9KdccXPXlH6biTY8YP4SyjY?=
 =?us-ascii?Q?fpGkqnsOBBlto1DWNUhNTZi+NVVxMHePHFdFqm9UTz1y9dvoJoKbgoIU7OGa?=
 =?us-ascii?Q?R8WlGowocAiLObbMJt3aciWeldhycc6TPRA1vL2rYlbo43BqrsHLROfGwwG+?=
 =?us-ascii?Q?rm2FvTIqRHByLSgyYQLq3JG4CzoRf/zuoCEr58jz8X+WY/lwcfz4CEq85PFP?=
 =?us-ascii?Q?IUoFXzLeF+MTsNdbOKO9NR0afBuaJqy7Wb6t1EMjrJ92ctENo4gQys4bfw9/?=
 =?us-ascii?Q?HdcCG7MPfQfBoOUwzvgKUySn1kwF/RocJX/Izs5A9OtmcNw3TSWpPjPkzOl3?=
 =?us-ascii?Q?jkq6tHk3hwilGySrTxK8g1EEc2SjeL0dAgW1EBM5tPUt43KD+L2k/gpnzZyK?=
 =?us-ascii?Q?Qy5N7ej8LP3Jyq8EsqD5DbdjkYVLE7ZzpCuOxWg9Xv7SbiccV6AtzFpP/FyA?=
 =?us-ascii?Q?FwWjjn6BLNjw6Dndz57zuFrF9aJYDmm1rLeFenFmks3v0KoEXZF/POSdcMmM?=
 =?us-ascii?Q?+QAkj5UcZtq1dLcErUWQF1BSXnYEh6wa5UPh76o5mozkayQJ5/Az9crsvYuS?=
 =?us-ascii?Q?oftfme2ZjgJV4j1nENrqvdSgGTm5N2807nxOYLgCNzEezr7qfu/Fro6D6Otx?=
 =?us-ascii?Q?en3CzM7qT68or+500GKN3zftNYDPWsAIEW1sWEGt5ouqPM24iNMy4428hndy?=
 =?us-ascii?Q?s2GL3TM2rMYF0z9oxz+BauepdI8ZsJ+MB93IHqFj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3678599b-2b8a-4cb1-4b66-08ddc0259214
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 02:49:35.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeQpuMDA082vfB0Fb5400yxFPllHTy8WOAsoU9CXxfyXwb8t7rBGR/io+D6hkPxWo+w2EOWxuZcZa+nruD1tQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, July 10, 2025 9:23 PM
>=20
> On Thu, Jul 10, 2025 at 05:53:16AM -0700, Dave Hansen wrote:
>=20
> >  * I'm not sure if the IOMMU will even create an IOTLB entry for
> >    a supervisor-permission mapping while doing a user-permission walk.

Early VT-d platforms may cache faulted translation. But they are
pretty old and way before SVA was introduced in spec.

>=20
> It doesn't matter if it does or doesn't, it doesn't change the
> argument that we don't have to invalidate on PTEs being changed.
>=20

but yes, that fact doesn't matter.

