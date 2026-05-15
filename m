Return-Path: <stable+bounces-247710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOfDNGMNB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:11:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD654F34A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E12318669C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6A48A2AB;
	Fri, 15 May 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0UAVYH8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8948095E;
	Fri, 15 May 2026 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846072; cv=fail; b=ZlvWkifAHpcmeRT0YOpbCF4/XjHfhj4VweP8CbIhMWTfrJbQMQ2PmniiKwiVyilhI1yocQ5gsGm5jQqjSacda4JUxOGDjT/ZOuX9SKVlxz2270aUULjzNIFSoiedmY3n0iI+dDmS8atsufhvbqsXCm8xSkR5chUxZ6tB2Q7Yumk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846072; c=relaxed/simple;
	bh=LqogQZwMYex6A6w2ILYKl+f2YfAGO4bkQo8Kuxs9x3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/rbB8DvmzdmqphsgEU6cGzi8nxH03CoH5UqL9R8t+wOsVQXpjf1YM26ZuD6zC0oshomv8YB9gA7VHJxbrYdCb7h1F1rF51r9d6L7r1Ze9WpeYxC654TH6ez8xRbaQoB4W7W69udFqp7EG4Kd441Pahn7GJ235ohVSDJ1c7NFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0UAVYH8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778846071; x=1810382071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LqogQZwMYex6A6w2ILYKl+f2YfAGO4bkQo8Kuxs9x3s=;
  b=W0UAVYH8i8G7xxCC3Mm7LCJevOzUYcZAXCAg+8aCq7so7M1x+Bon0bh2
   4cJx6kRYyN8g1oZ3r1MGgexyr4kcdfbDCYOyKr5U3Nq9zUfayjTofu1qq
   ahgFP2d5IfB3dIlfgsnxuGB3UcmBcZfK+fEkNxzsrPqok2yVWJuSE5aAj
   Np407+2GsM6t2kw1YaVD5F0rz/mr/dGX4NDxYpQnU78lJ1RTqPWVxqwXF
   K5v0n++cMNjUoU4D2zfG/9arEEfcWoaDfJEFkeZq9I/rnd5w/hxhJqSWQ
   P90V0MO4VJMzx3h/+0kCwNVCpcEkS4SHjGe6hwj8FZywANfS+uSM9PHH+
   A==;
X-CSE-ConnectionGUID: 2wTZP/QwQUynayqyS+NS4w==
X-CSE-MsgGUID: 4mtcHhGZTtiRmOJ+UU6rjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79693644"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79693644"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:54:30 -0700
X-CSE-ConnectionGUID: Y9P9pLLITriA/xgUCmUWiA==
X-CSE-MsgGUID: TbT3gWa9T1qeN8Rw4xLRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="269023896"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:54:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:54:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 04:54:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOOGEIqzDsDAUTlLYq8oxj3VbDqHNA2OfiyEewX3IcjFTm+kxI0sbY00CLLQ5t0Qc0qSg0JRdolBHNI6Fj1Z1qnUu2FKE/jGeDL2LPH7cHMsFTZgduH9xyuCK4xxXApqfOlfI37b10RnZBUzpA5XZoEvzeRtbwnUL4pBohZbxUqoikL3ma7pGzJc9UREh0nIHmC/hjbYh9ZXTuT5SRe+gzpfgfY7YUiNiNa6C2mML6tIneNV7y38RjN+sGDvyIjGLBvEwrdNR3HTmmiuxq6hw2xbeFDMs48NVT2kLuOpCbgsjc2Nn4o9svTLzKhs/R4PM2AVvtWKklZ4Lqd6hfCOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvPxW87TUqOdO4fPhFm0MF1U/ZSe7eHFRGIi2WFdCtU=;
 b=QKRfxik8I6t2G2xgyDpWjjmSZ9XHtmwfTBi1XaqSnw5fn+dFZQzEigVzvNPUgSdQ+6JWrnoqnzBim3wbTlSJ0HD0AQ2xuJaXmE8ZIU0BdzplsX8GckHrbDAqVGbuY+53Ii2lsLMQXNgYCGoPSEXqxdq0Hwj0kCTbCM1JT3onfdqSSRAjlFheCuXhz3vKve9m9S3VKz4M2ifzOMZeAbebt7ZhkxvK9Z65g8extRFFd858L6OC/hCT2lBHY6i3vqfOkO9MeMtC+bCY6wXvnHnfJP/a8iMDYq42BfIYMqd6K9pDT5DMwokV+H2UvEkGogDhs8GU7Rg5jIn4H1Zdyw2vHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CHXPR11MB9652.namprd11.prod.outlook.com (2603:10b6:610:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 11:54:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 11:54:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: David Carlier <devnexen@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
 idpf_idc_vdev_mtu_event
Thread-Topic: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
 idpf_idc_vdev_mtu_event
Thread-Index: AQHc48/ZWEy4nUXiF0iAxMJP00twDLYO+3GA
Date: Fri, 15 May 2026 11:54:21 +0000
Message-ID: <IA3PR11MB89864423C01C2F03E6621BA5E5042@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514183019.49527-1-devnexen@gmail.com>
In-Reply-To: <20260514183019.49527-1-devnexen@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CHXPR11MB9652:EE_
x-ms-office365-filtering-correlation-id: 7f3a5863-70d7-49e4-d6a3-08deb278b40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|38070700021|56012099003|11063799003|18002099003;
x-microsoft-antispam-message-info: gqJnNvI4iulwC3ZM/COHeIFXBLiiIqYrLtoWRX9fhMlGMAORAt2gCiawfvklS05ssuBjZoCeFf21iy+RrAYANf0xfDS+ZIkaEAXwF5oD+zm69ZTnCDjsclIipHoLmJaS2rpI/VmMrVKMcivlsrWHFkXp2INVcWamzNPrb/c45+7AFM3T7PiCIpoR1JL8iCI2nV4G5nqYqS9hKdzgKaHNX/HhMYdzlr4uS3Xh4ePVqlLDbbxBGmH6XrBwdfB7dk9BlS2fngCclpUt/qTjn8FeTnigPXkpSEJMKoZT9fJ+bESk9HdET8hi7ZoQ/ZSANiLZ3GVDcHM3kLkkr0R6+2zxvvlmSErLqRBfOHeIaZAYww6laYz/u8+9jFmFp0GVoPWKiso3zBpkQ+5M5b+2eS6w9GvF0DfZzxOYgaMuEUk24jMZhyqMzCbbm2YDBuScYQZmSz89YmQ5ij/Un20TxoIs/OJHvlJ+eowhF0wevnLzc2/QqGOVNECjRA928CyhfZEkyHQWiubDeUpzthQroENyuLysaZYm7jEmHIxowUwEEuwwaGxCKbR192rT8qSvP8yD+mGbv9AaraXhQJJmUAchVN1dfa0pHfO7+5lvoo6x+6Ww3mp7z9tFK8YWjcpi1e6SFztsbnOkvQu7IDoiDJmtBVtOBaT++KPNFIYfQp6ua5hGsKPYzRatOQaUhyc/ZZS30EUZNkM+HVYlMlQ9kvZ3RhXw6/9AKachAQzi7Kur1MkQHoht9AZsuFyTqdV/j4qo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(38070700021)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X7noXVzZHmWcdySUUX4+ClUTVvvhAKxLbWNBpSzdwDIHg+MAI0sDCwktHzQL?=
 =?us-ascii?Q?thE3WTAa0tpRcuNESKpcQn5tNYMQFwX2zimJebFKck74LY6l8ej3ouW5A5TV?=
 =?us-ascii?Q?Mq3wugOHn4zQkekYBrKTL/jym8jgzzngTOiFQ7fRr2G0DPhbtRrKKjDORSJL?=
 =?us-ascii?Q?G7UCnQCB2Ssp54P5BCwzuiD761Q2kogTkp6Od8HzXgMaKV1L0pePoUqEsXfj?=
 =?us-ascii?Q?8H5CuugeX943oS9kWqngt1hVhwA42dA33iwMF+4dCwgBVGgZNcwTjg9LlPyv?=
 =?us-ascii?Q?244/Ke1jY37hUlpZISH7QqHLDLflAOOn4Mm1JKmYS91Z0qhTge4awpJR993a?=
 =?us-ascii?Q?VaXNf/8WQIfzz+G6V1GCeGKmBaW8CWIovSDmYQQI19CEuVVl+pcQJkA8qvdh?=
 =?us-ascii?Q?wnkC7Zaq2AqwR0DQuQH7FCHgKkGKdyYgeKHpsPXG+Rf2dqVubeVIBhbeJ6M3?=
 =?us-ascii?Q?Kpa6G7NUi/2OhMI9ZIEb8qtCLx3gHXl+5MDm1xiaYww27E9CHlbFPXWerFCR?=
 =?us-ascii?Q?bWbbau1IND7RlKG/NUTjTDLJQbWYvHxhyrOBO2tP4ATFuAvYrmyIsNSu/IVN?=
 =?us-ascii?Q?9i87rjbbFgvDE117/vHg2QBsF1dbFMIWQWuYDhRBmCv6VZdME1pt9iMbsfAn?=
 =?us-ascii?Q?/QDN43E3husS2+mo2djEjT7EU7KV+I9lKIFePky4LZEgGpHknPgQpf34bXT1?=
 =?us-ascii?Q?DmuMw1SaHlUnXfQhlRzzsE08NnT4yjQj6BmyMMMejJqSosZQS3s9S7zNiTSC?=
 =?us-ascii?Q?9KFSb5bM87s12r6N0mRE1N5ir202uFm8ktXRlqgYhcOg8rA+I7qGvm7c2yRS?=
 =?us-ascii?Q?hlXDfaCLpbIIsMshu9J/t3ZLBtfSmfZBlf5sP2HLbl7BUDdDNhfDHBK/smeg?=
 =?us-ascii?Q?mU6Gpg8d2Kddit6/neNeHt47wMxtSVAXSXVfo5VdY2Vkp4v1pE487qpu2D2Q?=
 =?us-ascii?Q?030y3i3vdvQTVTExsxXLj8WrY0bW5I4d6XNxmPEzkC0SQqjqCFKXlO1LD8HI?=
 =?us-ascii?Q?5vPHrs0/wpgukt5Hiq/wHHU4ti3xDrJWa5L1wuVPQiEkMeTXielt00gRZ4+f?=
 =?us-ascii?Q?LDV4BtRAvonX9IvYbbFsntRBU6BXzEAmTGaZwxK4zrmlcMu8We+JS4V9T58M?=
 =?us-ascii?Q?Mum/pVOgieZU9nWZyT2H3yJxrwwyZ+1rE80Gt8I6bFTH1fDY5zoUyCuWPSM8?=
 =?us-ascii?Q?AiYNo4g+Okxnl1Br5tTmj2Imvke7jkNl6+wzzn70E67Kukuv8vFMhdK53Z3Y?=
 =?us-ascii?Q?Djc8zGtYX6UIhzB2V2F/VxcfbLm3gf7JoFa2S2hcPWUAzPikqsAZvozZ1Gof?=
 =?us-ascii?Q?N3ykVPlijJ+UleBzEgEp2wpRDVmDB9KVpusKn7FFssBI9vUJZrqPsKmUUkrf?=
 =?us-ascii?Q?dgZ2m4z6YmtH0l1cuLiaJk4x1Mr+TMqG7CEQyu3fqR62MliYyWshsDtDSM7E?=
 =?us-ascii?Q?NonSYVpGzC16C/+rKYCzIpoq1GKIvLYnxIfx3pPa50d/Pvd9Cg4b6L5XdOWc?=
 =?us-ascii?Q?XWC404ZeRErDOhwkQvFxh4K1d4Lxuqd67MZhB6ls4r8Qod4W80alK6iVmPry?=
 =?us-ascii?Q?reMKFfCIjuim2NQZUmz42iCghqu4eUHLqRA7WKdOd0KbuHdkBZTFZ1iCwRGZ?=
 =?us-ascii?Q?ECBKYM+jSK6k+aMw7IV6Zw4Ev4ij8zzjvv1iriuQgewbHBI7dzG3Aj3BuHb8?=
 =?us-ascii?Q?hYhBIeve0NOYuTdjP7iqfbmFLnaTbSc8ODTU9W9Wrm3WdN041ZVCloJoAQyN?=
 =?us-ascii?Q?uDKSQf7zDyZTl0YAGvr+M7MU8qf9QhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UPLmnjBA1RFQtgUqcz6ZQc1nKgIpJ7QZt/Lky38LTXxTQofWvIC1zsXy85sA11K2scuqmo0+mQplgADnDli5BPXDNx5WLo2FI5BrdieC2KEJfsbmywmjcBWOtqBf3l3ij9PUmU5tEXA6+WnqkvPOlSbY/ICHuy4wdWgGdIs1TnqVugQXxP7RGV7r/E6beThI0dVqdfm3AOomUg8TptFVMJiv79Goj3BW2fbjB91tN8bN/BS25fBEbN0vNX89A9UBCkpNZbm2NuVVcW/B7dRPIKQrXAR9w1GqT+cVDMk2ojERzgEqhefxvGAgWMBb3GWABbAIZ8NJqWee9JGHGk6x4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a5863-70d7-49e4-d6a3-08deb278b40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 11:54:21.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im8RU2IowUYnFqIFiC8JIznPZ0XpbsabgoU3D/+cxYc+tiiCQc+vz37x10A+qfo48rIqkjV/OvWY/LxuND0XdmcmGoO/j7WyF8ILpH3B/io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9652
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4BFD654F34A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247710-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of David Carlier
> Sent: Thursday, May 14, 2026 8:30 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; David Carlier
> <devnexen@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
> idpf_idc_vdev_mtu_event
>=20
> idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev
> to NULL but keeps vport->vdev_info itself. An MTU change after that
> calls idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev
> for
> device_lock() before reaching the (!adev || ...) check.
>=20
> Cache vdev_info->adev once with READ_ONCE() and bail out if NULL
> before locking. Use the cached pointer on both the lock and unlock
> paths so the unlock matches the device actually acquired and cannot
> re-fetch a NULL slot.
>=20
> Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change
> handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2: cache vdev_info->adev with READ_ONCE() to avoid double-fetch and
>     use the cached pointer on the unlock path (Alok Tiwari)
> ---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index b7d6b08fc89e..9f764135507c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct
> iidc_rdma_vport_dev_info *vdev_info,
>=20
>  	set_bit(event_type, event.type);
>=20
> -	device_lock(&vdev_info->adev->dev);
> -	adev =3D vdev_info->adev;
> -	if (!adev || !adev->dev.driver)
> +	adev =3D READ_ONCE(vdev_info->adev);
> +	if (!adev)
> +		return;
> +
> +	device_lock(&adev->dev);
> +	if (!adev->dev.driver)
>  		goto unlock;
>  	iadrv =3D container_of(adev->dev.driver,
>  			     struct iidc_rdma_vport_auxiliary_drv, @@ -
> 172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct
> iidc_rdma_vport_dev_info *vdev_info,
>  	if (iadrv->event_handler)
>  		iadrv->event_handler(vdev_info, &event);
>  unlock:
> -	device_unlock(&vdev_info->adev->dev);
> +	device_unlock(&adev->dev);
>  }
>=20
>  /**
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

