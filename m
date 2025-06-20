Return-Path: <stable+bounces-154872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A53AE12F1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1433BED6D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B751D86D6;
	Fri, 20 Jun 2025 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo1qdRvu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB94A923;
	Fri, 20 Jun 2025 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397436; cv=fail; b=FcHt1+VA9aLn5TCuC0o0LXPzAoN5035v3XMxFXOOyhe+57v6h0LESUjsi+nQeidPRxS8gNohbu9l2Tl94Dg6+wHIGxKa/WzZ8K6jznabs/yFNYZXzXtuNGFHqM88RKvxBR4mFOZg1woXqUi5o5Ou5+1FfGoGQsdtnUC8FOL71a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397436; c=relaxed/simple;
	bh=6RhCg1rxUzNocTjqCSsU859Xz7yWyPiTvLZKmA8YuT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHx4VQ4R0irreaEJLK9iKXsooiq81t0OVxDrOW4ywVaBSPSb9GFP9faM1AYGSMDoaBNUzRdGcfo1BirsWM166egLWv020Dek1eag2HtmF32AUxt4CDiBokW1H86QWua1xsOFlUJPeDA3zRTxh1UyIDqa9Q6mx34y7D6ZVFfyvKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo1qdRvu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750397436; x=1781933436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6RhCg1rxUzNocTjqCSsU859Xz7yWyPiTvLZKmA8YuT4=;
  b=jo1qdRvuEVSK3EwtD7qAL9FbegfD3uXJ4CjYJuv+UrfYqRJy4W8+ASKM
   zLgv/QTFhM815+SjbiKPbdYskJHBGZh76wZkMeJ63n8LxreM2ZX2c8fDy
   m5gn/zmtrUdT8TxINrN0nEjHSqHtNFjlz8UhJcV8QSaQMvS/sPXFKAvBH
   JbqX2w9+YJzkWB6NlVhtLtYTS1bWukJ8RyfLrAh28Bi6Ti5pe3QyYltFL
   Z01kOmjFapqzjDbJWllDzGt64r3oq7JOVxbBnzwVvGhT+lNQbdH88wHSm
   rwBnhqkhOi7/OqS9mX3HcRKNQeZch0cWwJZ2Ms4bEmYXdqDzwgDlqhud0
   w==;
X-CSE-ConnectionGUID: E8H13PGzT7eJRytGPeGJXA==
X-CSE-MsgGUID: WZsauoBET/OHX4SeRooRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52616958"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="52616958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 22:30:35 -0700
X-CSE-ConnectionGUID: Sl/Mc4F8SIal7E5gIvKBug==
X-CSE-MsgGUID: q9rRGV2ZTtehXcLG+MC79g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="151123608"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 22:30:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 22:30:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 22:30:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 22:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiQNL7miIdOzDbmBuqSCK+CfVCQKMML34+TOL6LeZ3iKm2P3Q7UDwUepbKqEH/8XQ42yaLAK/qlADdUwyaCTKvgxnZ14aDqrnHNbZ1PBK5jeWjELIa1gcUz1+hvmWgVz6Es6LlRpcXNi7gOkUYJRp6Pfv25KArwcbI/h4nF5R2FwFRJRBT5q0QnbPJ9kITtwZq2niJ//KyyXU7BaA8GhKiEpN3qN/pvNmkjKw+WFI+JPTjZO/TrPBVYGKHlXN7NlB1OwvRV1ZXMrIt9LS+z+zVQh6ps3x28557PN38tZLOGxL1Si8d9lvnGcFS5tABhAykU2sE7T7gGAwj+2CsLqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RhCg1rxUzNocTjqCSsU859Xz7yWyPiTvLZKmA8YuT4=;
 b=nSRL7SOxeFzrf568dJdO3zCJCOEQzQGzD8qPv78EgqfMxVD5F1Lug8E+SOfK2POeUK6tjPwZoBOdb4qKxcJa6+3Jb7NU8YAfiYjXUdIJ/xoWkk9pZG30XJyDQYhy6RiXrR8l3BIwmSUcaLvzBF6WsShNDrVRRefgW/yn4AViIIJ8yes9RdhUZnUpbI5LPcS+44DZcm5mfKjChYrLAm0Qyu1H7x9XM943xlSDj3fozM3kOwk5dA2Kc03P7e+EMu4dcvkiBU7Cg244vCDwNO1Ki/pCkYBdIPmVGlUzo8Ns1+eK3URy5cIKeSSiG+a/4gOsoQyQFxSHUAoM7Si85D/DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 05:30:26 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Fri, 20 Jun 2025
 05:30:26 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: RE: Patch "EDAC/igen6: Skip absent memory controllers" has been added
 to the 6.15-stable tree
Thread-Topic: Patch "EDAC/igen6: Skip absent memory controllers" has been
 added to the 6.15-stable tree
Thread-Index: AQHb4YrDB4ktiVA54kCIJzftFfs8a7QLgidQ
Date: Fri, 20 Jun 2025 05:30:26 +0000
Message-ID: <CY8PR11MB7134D06F062C1706175E0C13897CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250620022630.2600530-1-sashal@kernel.org>
In-Reply-To: <20250620022630.2600530-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6953:EE_
x-ms-office365-filtering-correlation-id: 53e3e6af-16d7-4c7c-acb1-08ddafbb8feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QgTKEnb/I5Lg7TXPTA/Fulxkjxc3ZaJMv5QRqDuQrd9WMVY1CCkRfFiTY0L4?=
 =?us-ascii?Q?8kxvPQtzlvBMfwYAF5t7226B5EazSNkm2Rd5nhRV65qQhxZ/5hiRjKiraMjX?=
 =?us-ascii?Q?inTn3f/Q2FHSUnGxvz3XnOQtXzYRoPQsVKxdmIPFmv5hua88c2ufy/PC+YZ0?=
 =?us-ascii?Q?85Gz0qmGv8Q2J/YW9mlqsISsPoag/rfxFnKAbDk/bDWJl5YgYgL2vEPw6IIs?=
 =?us-ascii?Q?mPRPzKKIH+y2Qo80ZZ8Sj0H1yIEARsS7BkxTkpe4AHg2zc7XPQrPuDcnq5PR?=
 =?us-ascii?Q?gw297Qu7B1J5/yUX5VthhtSqPGH/05ZjMFyszgiizK1+vSYkrLSSStuXdc79?=
 =?us-ascii?Q?j/JJqfD3iGEQB7Xibdt+clcPh+2nsnmcio/FjvcAuZRA+pk9opDafRz/L1Cw?=
 =?us-ascii?Q?Z2I/v5KzkCHie9dzxowJLmiA+wx1dbhgKM4qwc1kviZZxk2jDbFGeJFWG292?=
 =?us-ascii?Q?ZQjza31/eo914BiOmyscP9qJN2bfMGmJRqinUZfNxzJRXNMmyQjk2b8EgykG?=
 =?us-ascii?Q?vBHJ1UgV57fNX+1LqSrEixQNtX3IuuRRCH65gGBouONNDd3x1b1hixPvFq2b?=
 =?us-ascii?Q?5d92vqn8FublTOs0jsnNZEvE8uJ/+WaRKAj+U4Nm7zTv1F6VQuY60gqiUKpH?=
 =?us-ascii?Q?LihQa2+BQJlqyJS4jm7GJnoKR8dT/w1NQ12IEhSha7h0ddsGaNRMjoEJi0wu?=
 =?us-ascii?Q?PyyYwjTqv1RbyL5Sz96fjQ2XkVDpT5sFdG2pWk8ERq8FYxAA5eCoTHmOzTqy?=
 =?us-ascii?Q?RUoEWTM21nhCvFRwEclSG/cWv6oscNv2iYtQ0dI1LGAQoijwjcuSU8qwsl56?=
 =?us-ascii?Q?aHIa8Z+D4BzbRYvo9kICxCHc7OAPk0HibMBfEe8xsKpSCjyN+Q1+yFiZuSsH?=
 =?us-ascii?Q?KIkPWhIejr5n8lnMKp2kN2qIhSGVc+3oyXsZ/CaZTaB16fD9NolknsA5RsUG?=
 =?us-ascii?Q?yF/GQJt1zfL8jFJDk/A8mHCFTYznLN1WHu0cFfXkDwDvLAtGnqg/zFtrTA5B?=
 =?us-ascii?Q?x0i7+s1Vq44Om/2lDmeXvNd487BjdhXEoX+lRcsj95YQIjEa/Wr27xRYlg45?=
 =?us-ascii?Q?Ppj3Cup/uWJop/OU+wvMRBzyBdQrNN6dtggnpRa/blNHB8YEBln/9cJq24CQ?=
 =?us-ascii?Q?7g3O1UgrEYyhniF1VejOwZEH/laat+JaOm4f9wQlvnvugZNT640XQIZiKUFL?=
 =?us-ascii?Q?91uAIXKOS+1tedNNsBLE6VvwXYd6XCwn3rFvV4CnUbeDPREE3Fu1l9QtaMjQ?=
 =?us-ascii?Q?L9efN2S2f5zhaoUgqSkABy37M4nrnjglgH6x1u2iabdBcp2ITHQRWvPTsQM6?=
 =?us-ascii?Q?nzC1c6oXnjYpke7taAwva9WEAeLA6GGoWHWit30suu4Vw3gBmU8YxotfTpii?=
 =?us-ascii?Q?rN+a98dL7zY6d4gkSNFPEz7MYa4vAAcDJbns1Ckz/gIUJ6XmHZp4Gv6q+yTf?=
 =?us-ascii?Q?/yslKo2BYqLxt+zHgXbjSSmdO/uSb1qFqIPCfbdOfzneYfmaOaeU3Oxz3NRV?=
 =?us-ascii?Q?wSc39/VbsJLeC/0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rKMIjup2AmuahOxWbrEWn/f+K26+sjpsOV7kHmhpSgDQueehC7duDpu+AMhx?=
 =?us-ascii?Q?tiLz1aA3XW/IPYg6/3R+c/4jXMW8qYD+6lE0+DtbjTeNMXmyAGPB4xBd+Azw?=
 =?us-ascii?Q?Kxf5jbnx+gpVdGHD7mqHHkZWvKokHv0OUjYiDDgrCd4ipDBDRdYWqGb52G7Z?=
 =?us-ascii?Q?wP7S6rgk267/P+4TMvFHM+N4jEaH+NDPTHeFuZmbmOqMTADSCrisAvJa5HOw?=
 =?us-ascii?Q?mP20qJb/oh1yNw0OEDK/CZUFUuSpB5eUPwZA5j3xXOWWpnMul0E3cwWQ0K8T?=
 =?us-ascii?Q?C51AaevU4DCrUNnw0dvBXT//hHEvmvaQB/FMV7yZOFeszpC+m2H7AKmD49cD?=
 =?us-ascii?Q?W6E1GNc8sF+nr4GUjOfZb5reZQLxuLtwlJaj5gZmKtrpGYhvCcA1CmOMfWIy?=
 =?us-ascii?Q?T/2SbS23tCiAil+B2a28MtdFiOVZXyaWEWz4H52IWxSilHoEVzxPfsVLhAU7?=
 =?us-ascii?Q?Yl5Wx6p8F9elTnakauvAEfoAHyNA1BZxmPbISels1aGXDiIUPiOd/8w6Vtzt?=
 =?us-ascii?Q?Dz92yGc4etSBFg7/EM/5zgUW79r5dN0aAlUrhW855fR/tPb9pMR9W19+UYhr?=
 =?us-ascii?Q?SWtLlD1KQ+mH6CyupRvRLyCBaK2DzvShmhz5rkWH/5bdNuJeYmsbu/6h98qE?=
 =?us-ascii?Q?Tl3bMu1aqd8/AMS+ozAa8tNJtSyeXJrkYLpc1a2nqv1EEpU8EEYQU0792eKt?=
 =?us-ascii?Q?8zYyfIYLGWg2Yh4IoouFPhwUco9S8vOnGGOcMo3EIHdEKXPZ64XLIir0UcSB?=
 =?us-ascii?Q?Pz7c8x5Xm9TxGMxt4Zgo20mONhUmrRaiyI9SS3+Ns5iAWzVl15lxiSgu9Pdo?=
 =?us-ascii?Q?pkjJKmjDnq22O58MJhuVisAyt8bVACmO2yfOrtOj0FTi4MsmNVpEISfnkalQ?=
 =?us-ascii?Q?VcCR4yC+RjUtMuIsp/OneMMz/NWj91v1GQ892QGuANk7gGIpwxep7hgstX0L?=
 =?us-ascii?Q?Vb3VKiNIYwZIBmkC9DPXsYP9fvDeneJr13wUWQbVU4vKIQGs4IyCpb3sR/hI?=
 =?us-ascii?Q?vXNKfFfSjOfWHuV3DuyrSgti09oWEhbBvUZ2tdRnxF+DTdKnvNAEYqpB78Sm?=
 =?us-ascii?Q?pZdqP9DKhkQtWkfoBPePTVKm/YFV4Te1NVriKioWuVhNOXlFun5k5Hceq/HQ?=
 =?us-ascii?Q?igI//0Ap+OaLUPKYTdsRscQj2JlA0QtgFDAVQGNNhJzhdkjNH/fuMeaze0bh?=
 =?us-ascii?Q?5J/KQgMQeQVD09psySnWlR8gmeV2+Kq8XozGO+9EVJ1q3JawS1vv9DM3aNC3?=
 =?us-ascii?Q?KXnSWqp3v6lzuLgzpf/0vWf7+yghc5I+mF2AlneUoPbwzC63qKLYeRci2Peq?=
 =?us-ascii?Q?5GN5rzzojIP2IkWEfhKav165cowYMFQ6+V+5DGcZrMcsKTFPqDoEjHswJjxz?=
 =?us-ascii?Q?ilVNY23JG4qIKj4EY9YWkX06GASHadI/T+Zaz3yB0wSHuYubJFKDCPfmvwW2?=
 =?us-ascii?Q?LT6kuyA5WKF3LjrN5gjVGKD/hN4ItHwtMgIw55VC8Kkf1rc6wB9IL0UdP2f7?=
 =?us-ascii?Q?dJHRMKCPDWSQTuL9XzlvCArxUHAQ2Y134QI4DBYYzLS54+bB9wkNdEePsjXo?=
 =?us-ascii?Q?MXPRHkUOfPcI/E3z+k1gOC4ht+S3RY2i999tbHkf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e3e6af-16d7-4c7c-acb1-08ddafbb8feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:30:26.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1jPAGyPAffEKicY5UKnULiI0bUtQRQwUwsSPTkYO9PNZyCNEUzOQmMv5z2wQrYdou9V4E9kaVw5xnCQSBsNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com


Hi Sasha,

> From: Sasha Levin <sashal@kernel.org>
> [...]
> Subject: Patch "EDAC/igen6: Skip absent memory controllers" has been adde=
d
> to the 6.15-stable tree
>=20

This patch fixes the issue of the igen6_edac driver mistakenly enumerating =
the=20
absent memory controllers, but it may also trigger a panic.

So, please either do not backport this patch or backport it together with t=
he patch=20
[1], which has been queued in the RAS edac-drivers branch.

[1] https://lore.kernel.org/all/20250618162307.1523736-1-qiuxu.zhuo@intel.c=
om/

Thanks!
-Qiuxu

