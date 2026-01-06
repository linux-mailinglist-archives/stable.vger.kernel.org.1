Return-Path: <stable+bounces-205034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5DCF6BEB
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 06:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0F52300387B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 05:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885A2EDD57;
	Tue,  6 Jan 2026 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp4+GSNK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA029BDB1
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676322; cv=fail; b=DzuBJLrao6Ep9WH3f36JTotGA4BZ0rKg1RU29ZAds20Xr7yBuAz2FaYVPmo01gZhf2AeDfHclS21wdmqAmdGKJJoKuwzlRCmFkeek6CJIqvtnUItaW5jxm+67tDunntgap4nbia5ABlLnmG0RLtaNp3Kg8BxWxNHLzcWj6QOdZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676322; c=relaxed/simple;
	bh=PnB4c65SN+p9Y+O1YnA73+gukKel84S1VcDhrM+7KwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mYcD7aITvD25dsOFr7XQe5cP6+CNpi//MO9oLFSebZg1wmAy97rKPCJh6ftZ+aCGa5v3+cmc76iP5VedpM56ezYpNuIG1QwgSIP9I3cLw0kKvrbq7XWTKRgYUn0wU8Eqp0c4Y4RF4JXG8iZ+b9b6uGj1G9LGu+idOyvHhbGrrw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp4+GSNK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767676320; x=1799212320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PnB4c65SN+p9Y+O1YnA73+gukKel84S1VcDhrM+7KwY=;
  b=Vp4+GSNKkf/MM3IT7EX1Up42jMJnRVAAV3Hqm5M/EdJxOkZbhhuqewc0
   m3xvysqtFakCwzvjSjb7Ig6O7DJ9RvSFNptWaCYfd69yRsSXpHSUONxch
   7HueRdDRdBG8vr4pNQhXXK5m6ycjNxv5y3C1i80hyoXZIKWCn3y04Uq/T
   in6vupjjsrSRbXI49sxViGNcS+bDyb7xpCduOYXlUuXU/2BtkEItoDwKP
   IlbdkOA48MmdacuOQxvh1GzTOpqMh+nhjeaYR6dUvPpLA0/fjgs39hqWr
   D6QqQAJddgkLXkjB4b3FGqZ6TD22oJJ1Wb45yp/yhWS0WHr6mi7nu3m+0
   w==;
X-CSE-ConnectionGUID: q0xta8OLQ8efXLsvwOvVbQ==
X-CSE-MsgGUID: 0kal8kgwS7WZzqXCJD94ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="80408288"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="80408288"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 21:11:58 -0800
X-CSE-ConnectionGUID: 0RGloJ6FTJa0BYdGxxSlQA==
X-CSE-MsgGUID: URYxfjdMQx6mLXSwJU0h0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="240059318"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 21:11:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 21:11:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 21:11:22 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 21:11:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGhGSfyfdf15R3M6BKzg2ERLRL3vxtMfTmH5IMgwNfLq7N1R0WHruw0dYJxZMkiNLffwqNClAR0U2EZkQsmu90iCwWynnmvWumCJmy4c69SvKDAyy4klUZoG1koJ3jBdnc+MiQxcXKB3uCkpyEmiiYlHKCsH+pGsr5kVWXpVa/szRSrGI6O4KCGIlpupXsqUYk0pbU4UUDmdrTvQzt2sprScgoOEutx+KqkQLqafuld2fsCtXjUiU1YYIn07omF+9UpdVtsTmF9fjQWZSbUGgLdqeuntR073Q/RICzcEOVgY4Fmroz8WrQzBYn8AMOJfls6E4yH7pv+ZaqvmEzfXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnB4c65SN+p9Y+O1YnA73+gukKel84S1VcDhrM+7KwY=;
 b=PR9HPGvCeImB2jHMEqVSFXn//o+lD2V6Er2rOmSv5Mqi5qBySfi/3rF325pZvUL4234m8xlK+TMAqsbqEQ3E6Kqa90wN1XgqnYLI6jwRHydnf/wHBDNkdbgsYW7iMIkeFQU4dM6LW2vpSPEVDqz/8e92Hh5aqO/5ZIZT9orTZZBTOY0WdNKVKpwf5QqUyItgi0qhp/pDtTbBDfh3OF42nC0UO8nwMMuf4IbWyZ/8r/HyK6wPVnPuUZyiP0LtB/FGLlpfTPIUBi+OFvd+jLa7WMRrHPswF60UomgmrhZbp+B0/0z20bqq4FGY+aUhlyBgPCKmxxeBdSIbLJjSlPn2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 05:11:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 05:11:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"alex@shazbot.org" <alex@shazbot.org>, "Chen, Farrah" <farrah.chen@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] vfio/pci: Disable qword access to the PCI
 ROM bar" failed to apply to 6.6-stable tree
Thread-Topic: FAILED: patch "[PATCH] vfio/pci: Disable qword access to the PCI
 ROM bar" failed to apply to 6.6-stable tree
Thread-Index: AQHcfjky4ITPvQWiS0muGXS10b8ub7VEltJQ
Date: Tue, 6 Jan 2026 05:11:08 +0000
Message-ID: <BN9PR11MB52760356629F3024E091CD578C87A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <2026010500-herself-pentagon-8cde@gregkh>
In-Reply-To: <2026010500-herself-pentagon-8cde@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6568:EE_
x-ms-office365-filtering-correlation-id: f17a8efb-2c54-4cba-8a54-08de4ce20015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zw/GsLAd93RluhpFI71cXOCWLz1nmsv5mQn9P9WaBpdoQjnbQHGIP7sWgzXZ?=
 =?us-ascii?Q?neheiMsfrr8G7e9ZZsdAqOq9sDd+6VUqaEzS5m6tHmjoPiIh4Rzbgm5dL/WV?=
 =?us-ascii?Q?+QN3al73G8S344iWn+WFHi5iqIjav53xZm/Hr8U6YhqjVMyxQ3eHtLxOtvq7?=
 =?us-ascii?Q?1VMsyAErOL+zr9uZrtm7VLXQQuoBxKQTCnVXvInitGIcGv/9QpEo/p7wPmSb?=
 =?us-ascii?Q?n5iGbdXW94luBuwB+cfT+PW+tbZSHvHIA4NpWdujtCOC9bOlDYn4V6GWbRAg?=
 =?us-ascii?Q?dCwhjK5wkDx+Da1PrV58f9k3TIIZrIOKWjStTlkECxQbOgsJgoB1WIaKmRBK?=
 =?us-ascii?Q?KR384VhhUsEJ1QoKlOCtQ8HqLt1LunsYrND9dvYbOCdQWHuRLSfiUoc0uBYe?=
 =?us-ascii?Q?SY5x/kSfmNtG2b5wes1y+ndqjiM1T1YcYrls8TmarqUxFOfy2YKlm3HkA0VY?=
 =?us-ascii?Q?dFkmY8u0Vvu9ANwcLTekQapMfPzOACYJzy2iI4NuIaxes/Kv71ouQ+gTGK+R?=
 =?us-ascii?Q?ID0Q3vdhNVKEV2chhjQNH/n0Hlz6y+UbeJUuPTdjJ1dFBLjmrTXIUWKzwZQd?=
 =?us-ascii?Q?Eex8TsoR86S6e+LyAlhyAzFgNJWmS8pVhS35Y5hmbdlcnbzM6deCek5Y+zt+?=
 =?us-ascii?Q?UKB0i7H5MwwcbAMKrQW0kj/tb5rECn5/tulbptUCw9FofkOXA1DEa/QMF919?=
 =?us-ascii?Q?DUpcnh2DIuB12BeBPT+DUPS86FS7hUMAO8cSo0NqTPnEq1MWWkBsZChTITga?=
 =?us-ascii?Q?Ty/91s/FECczCenw8gbzaWPaJSIHxpyMulUkk1+jG2bAV8vm1PiDmkHCOa++?=
 =?us-ascii?Q?0rUfa8e2p0nVh4KA7GlI+hCgyR+u5SGeMthW+3w45qbmvMg7ioSDxJpJL66s?=
 =?us-ascii?Q?ncYgtCmu8ABTxKVhQpDhKaZC6wJcfLXxQd5l4E89y8Qeh+QguIu4Sz1KzhKC?=
 =?us-ascii?Q?kLklWib0L8pc/+NUSDGdpNgqCb4shHwNpPTodqzgQLBgQ4F9PaxUXpfbjCLC?=
 =?us-ascii?Q?rKen3VBwHIbrkZ1Eo3H31fCS6glovCLS7HfHtaD3IMxe06wMpurcVzu/ts1B?=
 =?us-ascii?Q?nLVXxC4P5GXasyQP/ZNcK8RLlunjQtjeab8Y1LqM7OOOK0gYn4d9tSnSfP5L?=
 =?us-ascii?Q?4OralcBXGKNrxAC8hV8MOcQST0KrhVlzhZAAzzYLpkUEfyYU2gLn/Gl8hmIe?=
 =?us-ascii?Q?sudCuCY3UThXzF97LJ44vINluBNfOPV3GSbatkJHhFRt06zYB/hSSsDE7Qyq?=
 =?us-ascii?Q?bdM4N9LFH1XwvjAoL3JdBbduTZfR7JvuV3fjmW6bcO493dQ0hpZpRmnbLiqp?=
 =?us-ascii?Q?2HOe2lcO7TElxjhXwhmq+uIwMyiufxJOFkaTr9tqtl0ZQS03sGJyMrMO5Uer?=
 =?us-ascii?Q?m1zt9HHsKHAC914RDBK9uSIT/k43yFh9KINm9yRlcg2AzaEWb73U2QGfua6q?=
 =?us-ascii?Q?Vi7+1RgabGl/+jjHKXqKgfJ9PtVnwZPZJimOp1bpZQWkDShI44HisEx8bE3M?=
 =?us-ascii?Q?8NhonuGUig0gUQ8N/04heBC6L7zNFxeEWjLd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8RoO+W24yOsh3C0m2aOztf8YeQFzjJBh9YWi80fYf0HK0jJNfkI+FHHT+MNJ?=
 =?us-ascii?Q?hv4f0Qt2DRV9nq5/5pHYXT+/fBACBF37z3Eb4Vtj5+ChLU6Dd2Rp221hBjAr?=
 =?us-ascii?Q?gXpeWK2SothJfhliHTV13htSV7Zr2lMERdxq025XTRi3gfaspGn6OOv2sXYR?=
 =?us-ascii?Q?O8BOge+f/yxjG4P1QrloI4S43SKekLjAvn0/KtnMvR4cd+mF2WCayyLNnwDB?=
 =?us-ascii?Q?FZA6Mflic+ykh+ndIMjk70r5md4f3AqggnSZQ3JjFeh80pOk6hLe9QzWc0vk?=
 =?us-ascii?Q?ukaXhktcN7Eg5xq38wgTyOLNZIpF8EBFVsqcJujFYUoWZ9AG37P8UdjY7/QG?=
 =?us-ascii?Q?+8tRZiuYJL18rl0Zf2X8dTwzWfhVcZ+osvjyoFnu55SZqXkMaesAVSJHVhjE?=
 =?us-ascii?Q?CpZZmCr35UAQByDa5KOOAMWz5dvBBBmkaPg4/f8/6Kg70x0QR+bCRhqDFaAa?=
 =?us-ascii?Q?r6MMcQgQv+bu9tTvFEUeMDZmP+8+9sIUWgHeAvChn0VDL3FzZ/cdKetFbPYl?=
 =?us-ascii?Q?4RLKABllRo+5Vifu+CwOvX64xTvRaq1axeRAlHpsr5xH44iqOv1p4svvk7Jz?=
 =?us-ascii?Q?dAJ8nN68Yz1iNY7ou2wX21qD1JHhAJUvraJRqt4+kq+2WbCGHYKoKj5fs72i?=
 =?us-ascii?Q?Y0HwiogcQRnX3gbFhQQYOydS2onOQe+tO9Jkx1c0XHOqR5eTSZcErZg2UX6O?=
 =?us-ascii?Q?KNpGqR2gAki48Jb885JT1PKPAAOZKcsBzSh7beN0qjmujAJK0RJ6tnqsIhl1?=
 =?us-ascii?Q?P4yJ3+49YGIecArNCOwXr3aabXuemVmVTjC/Z2BvQLPKp71ZFwyURrf5X+/I?=
 =?us-ascii?Q?P9Ng3jZMZkodXVrsiRIEdx/MCWUEOqPT/Xc6BLUOoXgxqCWQWvKFv5O6Yuoq?=
 =?us-ascii?Q?1ghaAcVSS3Sz33aT4oIGzyFC4S8vvn8cfDqoSymeq3pnXkgq2iwhXIrCP2EX?=
 =?us-ascii?Q?zYEOdxenNJrjoJzyRvIXYEw3ejGOgkABwBBVI2mL6g5TFDtdSBjUjgBlIQ00?=
 =?us-ascii?Q?gvvQkfe6h8tRllhKZj2d6IeojCommBFVY8LK/MwwD8c0onUJsA/E9amZEh0J?=
 =?us-ascii?Q?aD89EBfU5O5UuI2QDbf6BpczZxhz5p1bI+DQUEt9cdtX9GRDiL6v/xnZC0F/?=
 =?us-ascii?Q?5hba2m61HDo+BZN2BWzJ+Zzi9j++37gkkkmp6id13MSwpQAWIaXafZi3BhrL?=
 =?us-ascii?Q?x6dNa0VWfCjgYaL6SQrxHhG1L/ZJU4D4nNAF1cqJ3j0OPK2zh7kZPKyK+2NJ?=
 =?us-ascii?Q?zquct51ELXWV/55TZZRxr7N6EGuCjsdJDJWWXw2fP29OshQmloZHp73Ses8m?=
 =?us-ascii?Q?9AikhSnVk33atvF6DmKuf/37fyAmvuQ/JzQttR1S1wrsfRB4+5J2Cgkbg99M?=
 =?us-ascii?Q?cPycHmT5LmElXQBJqRbkAW0DPDjkq2za3aft8GWop+bw3jOZqLa51eW00fZD?=
 =?us-ascii?Q?5bcXGbOWDYSv7ZahLRtzB5//4XOtQDVYj0vz1BY1ZEk6bYGHQFTEtmE5EcXK?=
 =?us-ascii?Q?q42eEb8r9uxV23Orf40u80UHIgKwXkq5cbKl8i1rgxP2FF7VCLO8GT8RVisj?=
 =?us-ascii?Q?AFfqBUsxEuBW5Eds25MiDacVJP0lPkcUDWAfkgaHtfZoOnpjpBXUwcA0Noca?=
 =?us-ascii?Q?eCXAzJNaQEWrg59+aI6cVCzhRiWBpafiE4TFs269Lo3hZ1zAjCXSocVYjJO9?=
 =?us-ascii?Q?0hBL4X70lnu1CEoI6QbWJRGp10YwfLMVXHmQVsltoVK4OOTl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a8efb-2c54-4cba-8a54-08de4ce20015
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 05:11:08.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQjNvs4KANwzBDOTl/o/whVuXYVR3CC1roVH0rITH2NkRYFB+OLu6BZUurEtlDZLfWw7boI/vPlRIIOQfqHvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-OriginatorOrg: intel.com

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Monday, January 5, 2026 7:48 PM
>=20
>=20
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following
> commands:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/
> linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x dc85a46928c41423ad89869baf05a589e2975575
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010500-
> herself-pentagon-8cde@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From dc85a46928c41423ad89869baf05a589e2975575 Mon Sep 17 00:00:00
> 2001
> From: Kevin Tian <kevin.tian@intel.com>
> Date: Thu, 18 Dec 2025 08:16:49 +0000
> Subject: [PATCH] vfio/pci: Disable qword access to the PCI ROM bar
>=20
> Commit 2b938e3db335 ("vfio/pci: Enable iowrite64 and ioread64 for vfio
> pci") enables qword access to the PCI bar resources. However certain
> devices (e.g. Intel X710) are observed with problem upon qword accesses
> to the rom bar, e.g. triggering PCI aer errors.
>=20

[...]

Qword access is not actually supported in 6.6-y and older stable trees,
due to missing the commit 4df13a6871d9 ("vfio/pci: Support 8-byte
PCI loads and stores").=20

So we don't need backport this fix.

