Return-Path: <stable+bounces-118383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4EA3D222
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D54B3A7C4F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F61E571F;
	Thu, 20 Feb 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0ikGucM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165351E3793;
	Thu, 20 Feb 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036110; cv=fail; b=Rmgbomml0h9Gt/xGJkrlgTAMNa5lKDKwA8vit8zRmN1HOdr0/aK3Mwy6gLBXPBnamw0M9RWBufhpKfjrwQIyq+tfvy04U23oW6cH4sAYsFHB0eUzUC0Qbm8KcL0e4rRkPWoKeIcXffAgl49UDou817fmqjuuhIZGTrgNMYckFss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036110; c=relaxed/simple;
	bh=9rxEyKE6fbb32fYC/Hd86g/csuVSpLSzAL0NqTyPzVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVQPneEuIPq4bMtyJJrIq/T34eIbBSOMTxvj0DU1oH8ec9Ajz1l14c1QpI0PbWRgujXm/EvMntAakUQmRVLaTgP8W/EYbSffo61JTaQW1TFe+zEuI/0gcfHYYZ9GX10GzibYtB3bYfSTq2l4FvUz5xkPDU2oXl3YSNhUs6mOJyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0ikGucM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740036109; x=1771572109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9rxEyKE6fbb32fYC/Hd86g/csuVSpLSzAL0NqTyPzVs=;
  b=G0ikGucMRCGdBEgu/6jFvgNCd7BlXVhvADVSi9XPLJN1PeMFzd5cAUdm
   sFZ3NA4Ad+HpnyXu+bt5Ey6Jqkieq01HCZkqLOiiM3PcdKyldSgUTQpT5
   uxzvsYs19L5PyoiLEW+OiqygR+QLW1aRREhysj6o6dTbJdzClOFNIuQB4
   AhSLJHKYlewysTGBynRyzO/6eI1oIPYHFXFtYgN8Tczn4xRGoB9V4+UJm
   A++THpZCodkREHDoadpUPLlu36j24Ovc7Uea+ttYzulXO8hJ5/PQoTaRJ
   BLMQ6kbjq0Tyczi4mB35jenNiIaXw5hqjDHt9VJysULGMJtc47gh97RlF
   A==;
X-CSE-ConnectionGUID: PjekMn9YTVG8ggjhDmpu7A==
X-CSE-MsgGUID: s56twQ+7TJu/7pcnmJhjLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51420367"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="51420367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:21:37 -0800
X-CSE-ConnectionGUID: EUmRq61bQWiJOZCuXpmEBA==
X-CSE-MsgGUID: QdxS/owVTX6MdneR3gLTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145848273"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:21:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 23:21:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 23:21:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 23:21:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9kXubojytFBMKydffNlNodXbZINK/qmx3HD8TF+egiHKvyiXUtVd47puWW4LxGZBQdXWjiWngfoi4Jd6cp05+67lv2ZW1T6idVPmmJ2Ua68yLzh58rLsl0eq38DxHcd1YcZwcdO03fDUWb+IK57yiL1+wMCEyMWgsav8M3dfuXVdkUgs74alSMDgn378aS52vZhbPvSNuMX1ox//vpT2taOQGlWwbkk46bZjujb8G3LbpAt4wjRpGPr9PqaL0/bk/uZJYIrWCog9Hzva/aUR2MVH1PAW/ODj4WpfAveL8UFS/p3pagXL8CiMpP8Wo1cuGvw5Owt2hgNIPDtJGmuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FASPqHyxwT0PVHn6yv9HmOCmajUgsOkevNmzKgkXS0=;
 b=OpBqBpamSVcXag60KrdB4uKyPsWtG2NBOE2cTTsVGv6IyxSrQHBCSfATi6yHvLZiWOQSXA076NXD6/yeKMCunEKSa9XUCBfudO2Z2+ZQMmD+nlJxUDqbmWnmAyfvXjFm2CB9e3nr6ozsH6JZD414P0QjTxjFGZvlxaKmeO9/eiMGniYnHh9BWOEu0FH//H4LaJksgfEYcA85f3X89fk5R6sHgUnTzAkq89mCZgTpOuFNamNo37tGECDgSzPx2N3MlCdOh4fQg/I/yFyNDAJ1+kAS8shKEPwJHe7g/6rczPELsqzlt/G4nQR313LcZhVKTCeMLoqlcnoYXBbAJwZNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 07:21:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 07:21:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Ido Schimmel <idosch@idosch.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Thread-Index: AQHbgaw8QEOwhHOax0C7HUdP59MatLNPzFgQ
Date: Thu, 20 Feb 2025 07:21:29 +0000
Message-ID: <BN9PR11MB5276EEC28691FD6C77EC493A8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5024:EE_
x-ms-office365-filtering-correlation-id: cbce2fcf-e370-4184-5554-08dd517f31f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qaZx/wB+AFi0XWl7NWMsWmP0OqmbFP9H+VDNPFbJ5wAze4cDd237sIZSN4SA?=
 =?us-ascii?Q?Zp81DkRut64b9OMR+KS2kbNXadxP8ujgw1xqF3qS2QhMRmHLeAWUNtoRXfem?=
 =?us-ascii?Q?2D3cIpe4B+a5ALQ2IDxpz6+bl0/1hoibV1pYYQrNFtiyJ1jQg24IejqNS4W4?=
 =?us-ascii?Q?Bni6s6pxG6FMett6Aux4+UvVttfEPCc2zDNpqVDJrv+NeQNNFZ9LqyW3HgB5?=
 =?us-ascii?Q?TdZZh553Y+jAVlQ9hJ0aUGcM+WZciGx0n9QVgEHzy6Tjiailm9nZMn6vEEKq?=
 =?us-ascii?Q?vgBXJie7unzYU5oHKQyVwaAA35eIEo81zLRNHs3D9sXkhLxsIa/95U23n+7E?=
 =?us-ascii?Q?qmOErTKvXt7E5KdNjlUvt5C2+yN8N4tdE5srDJLX95d6hVOiu3AqZT4ds9/t?=
 =?us-ascii?Q?O10ZqFGS4TxEYQezbds6TPRR0FxBBAuAuNPNsQyjJCwYWyn4mnVEimDCu94D?=
 =?us-ascii?Q?xPU8S+bJZOKJB9PmicrYcb3kGqqusTJh2MjKuxRQr2b7RudiEN7OWj76Bo3Z?=
 =?us-ascii?Q?a7weGBu3sgdmfm/jRckqo2Bst4M9ARDKAGS9W6rLLW7nYjffk9v7AbWXo/nY?=
 =?us-ascii?Q?ysnqUjucVtQfuH5U9zjQhLHZ4K/AXarDEkIHUw5n6fl8f8v/dpqQh9R3RqhQ?=
 =?us-ascii?Q?rihei9poqEKXR0GRlIUdbAUwCQtKSJPZDHjeGH+luKtlGj2Ulljw3HSnM05q?=
 =?us-ascii?Q?+HN4LbqQh/Ibaj9E146iw0i5FHWFsDh/3SYVktRsV0q1I1rRbG8JQJ4KBrzR?=
 =?us-ascii?Q?f0wrnylsJHJQ5IZQbHvQgtmbaQGRkiPxlNui5DAgiDbe0Apmd3WyM31mnYaF?=
 =?us-ascii?Q?T6S/iVmmgBcNwE58GbjEQuNvZuXFvrNvY2OWQsY+LPNU+3VJI3hFup3HNhol?=
 =?us-ascii?Q?dm/SZgTA4O/HSRQQEKtA/adrGJ5VmI6upnSZr35uDu0xynwG4EAEYAmBYM4/?=
 =?us-ascii?Q?nWClVJWB0z3ZSizDWBgchhuTKzVHmUWdrBCo/11aCmscOlStyqfJNF4JVaU2?=
 =?us-ascii?Q?810VNSndad5IITpsSBku3gdL7brpeWD3rCr54OsdY67AXl3D3IAbliYoYOjC?=
 =?us-ascii?Q?5blbpsktYlXwghCt14VPGwoyxgZTP3YHuINAz/zL8YJ2lxjN6z9/8kEy9icv?=
 =?us-ascii?Q?BwqQElCU/g5eFMu9J9ZUD7MSRW25+cvjnhIfvW5maPlEoCQjip8rUbf3bxzm?=
 =?us-ascii?Q?5cBSVux+wEdTsH38So03x9cPwz3UAePVOOHBzuVhp4dk5Y94evbpCS34yrBw?=
 =?us-ascii?Q?JHfJ2igZMdJlmF3VAMFPr8Vx/GPeXfVMeML8070O25PbxvslSwgkq4xQUWQd?=
 =?us-ascii?Q?bTkaM3YFikpEC/AZKBj11VHwXHaAFfWwFq3lM66qZQejoGQ1AUDpW3nwYun0?=
 =?us-ascii?Q?KXx/DVcrgypG+nLh5oSlQB4Jn4SoAolcXEQcAlpAY/o2Wta3nMAcY5EeCX7s?=
 =?us-ascii?Q?hOGKHh1W/M97PrSZ+fmGvck++Up8NpQa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k2FZGFcuenNEiT8yxlIYHGqhRwrolviA6aqzun1i3oVUoTEwbPm70bnEZliu?=
 =?us-ascii?Q?KE13Vnzip91mewmJa3/+okEzADJQUkmFwPv3/YNdV1TzdROp6uPXQO0dzLQr?=
 =?us-ascii?Q?rK13SSfrNJVSdJwPUmXtgC2kxUooSEua4O/SafXZSJoiHc5sMDxJZdcFqXI6?=
 =?us-ascii?Q?JunZZHjMpBFJkmqvaK8M4gBe9yzlfhwdbzgMh9r1z9VevB1Yi+OoOEwgY7wr?=
 =?us-ascii?Q?xFKJko5dUUPIaqUUX4wVvKnxJgpvsh2I6L99R4rF1eGw3DR2uNmCqC+c+QYK?=
 =?us-ascii?Q?lFSL9L8b8/fcYNHxuuz6sJamAnMAeYyzrS2gFor62HYBPVRFM224a4gJwE0O?=
 =?us-ascii?Q?dueSSGIIGjse/zUrbhKYwptsgprS3Kpk2izRv8YTUxSRg9UtsXWc5FGyPcoU?=
 =?us-ascii?Q?5k2e6+DcWmC6jNYe8YnjCJ5MfFxZZpeUeyq+LQplz/XusOxBCpy97NAp8UcH?=
 =?us-ascii?Q?Quxr+V/0ajDArkHG2MRZvLDZ0AVOV7pRULQ99r8mtDx3xEYEhnSbBjIYWIzG?=
 =?us-ascii?Q?9x9wvR+32Xh9YhZ4UskVK5FPID0Ec59FI9OgdUcWyJXvx/nC1onLzbEBWQkE?=
 =?us-ascii?Q?JkDItzb6KFKgCa/rgJw56Xi9KOQ6FLq6s6wnd0VVU/yJZ2vEMAsi+ENmjTGg?=
 =?us-ascii?Q?sxIcpGqw+vKpzNIsHBj2fnupaIJ2gB/mife3Q7C4slzsm0k9VntQnZWFuNrU?=
 =?us-ascii?Q?sXsQXsUbQMXvMvmjg9QSiGCJQ9ZEH/2Igp5lvqI9wrGT0YSkL9WCz2K8u+1f?=
 =?us-ascii?Q?xANLKq9pMIPp/pZITFrcwcs0Jzt2i0jU5VmGwWlPnaGU4roop5Yqyq8eBB0r?=
 =?us-ascii?Q?MRkgIdxzO6++rBzu+2NrbFdCerYvFb+vUoOVpFXPnXmjVGk/H7HZeIqIXTpx?=
 =?us-ascii?Q?tHtVEnCJ4AVJH05MvB3PfAFSHp9dycNLXbqTOQSkXv29qoNz4DgoWrmFoWD/?=
 =?us-ascii?Q?/47I0fWjYxVxG3wtoQC6Y2xQrg3YqZR5emVXyDPWkePUPr2BoYGGY1j4vWUQ?=
 =?us-ascii?Q?O2VlS5nD/pZYoY0xiLP8Ez6zu3TK/x8k6TxPzlkXkrjjLHnBlwtSL1xlxRQr?=
 =?us-ascii?Q?oJ9ODKwS+WLm7P/FzEJkcvfojowCowfnY5YslgIQVUQIu7lconCPcRJPVfgi?=
 =?us-ascii?Q?NzFJUyO++cg45RKABOxzaFgpUXoYu1fNPkKo94FQA1tzPbZZYJ7EwvvUiP/j?=
 =?us-ascii?Q?j7neoS/5+hTz2EQMu0odbpoxZ1g6wOijmSbGeHSrdaI9GVb8q3Xzl0QHypIM?=
 =?us-ascii?Q?WiY0ECus7t7N/rjMnx4TIg6VFSD6GtKJDl2+No8W9OrZL7bzy+6f2YfAxQzY?=
 =?us-ascii?Q?vKoiY0Qo6dYwMfpKNpigzFkeZE5sDvMWgExXEnYBl7B/BOUxM2GeJR/c1SFG?=
 =?us-ascii?Q?DXbzZbJX0ji+FYwY5FTvmq7Y2J6HPTpHsFDgx2WyxgS8o0nZOhSM+14XISAr?=
 =?us-ascii?Q?SxYb5YQbhihn2X6lBOBbhaRhNNaPCiJPDv50hDxbf7iQYRfCi1ZdZowbsaOL?=
 =?us-ascii?Q?Yd6l+TwBloXZdB4fYBVr7hlckiRgu12bA+2pfh+Iat1aVidBKmmJeuqoXHNg?=
 =?us-ascii?Q?dywBZfb0WiibxBjWVvAvjE7alA+SbP5VT+QogTxo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce2fcf-e370-4184-5554-08dd517f31f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:21:29.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70DozNmFR6L0n7Y4amyAeq7vkhpVLN9xX8eLppHP0BiqcIeg/7FoZNlZHbRXuHQTm3YtQQEfj/znZTMs0WiWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, February 18, 2025 10:24 AM
>=20
> Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
> locally") moved the call to enable_drhd_fault_handling() to a code
> path that does not hold any lock while traversing the drhd list. Fix
> it by ensuring the dmar_global_lock lock is held when traversing the
> drhd list.
>=20
> Without this fix, the following warning is triggered:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.14.0-rc3 #55 Not tainted
>  -----------------------------
>  drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section=
!!
>                other info that might help us debug this:
>                rcu_scheduler_active =3D 1, debug_locks =3D 1
>  2 locks held by cpuhp/1/23:
>  #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at:
> cpuhp_thread_fun+0x87/0x2c0
>  #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at:
> cpuhp_thread_fun+0x87/0x2c0
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xb7/0xd0
>   lockdep_rcu_suspicious+0x159/0x1f0
>   ? __pfx_enable_drhd_fault_handling+0x10/0x10
>   enable_drhd_fault_handling+0x151/0x180
>   cpuhp_invoke_callback+0x1df/0x990
>   cpuhp_thread_fun+0x1ea/0x2c0
>   smpboot_thread_fn+0x1f5/0x2e0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   kthread+0x12a/0x2d0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x4a/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>=20
> Simply holding the lock in enable_drhd_fault_handling() will trigger a
> lock order splat. Avoid holding the dmar_global_lock when calling
> iommu_device_register(), which starts the device probe process.

Can you elaborate the splat issue? It's not intuitive to me with a quick
read of the code and iommu_device_register() is not occurred in above
calling stack.

>=20
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally"=
)
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-
> a@shredder.mtl.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 1 +
>  drivers/iommu/intel/iommu.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 9f424acf474e..e540092d664d 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2043,6 +2043,7 @@ int enable_drhd_fault_handling(unsigned int cpu)
>  	/*
>  	 * Enable fault control interrupt.
>  	 */
> +	guard(rwsem_read)(&dmar_global_lock);
>  	for_each_iommu(iommu, drhd) {
>  		u32 fault_status;
>  		int ret;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..9a1e61b429ca 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3146,7 +3146,14 @@ int __init intel_iommu_init(void)
>  		iommu_device_sysfs_add(&iommu->iommu, NULL,
>  				       intel_iommu_groups,
>  				       "%s", iommu->name);
> +		/*
> +		 * The iommu device probe is protected by the
> iommu_probe_device_lock.
> +		 * Release the dmar_global_lock before entering the device
> probe path
> +		 * to avoid unnecessary lock order splat.
> +		 */
> +		up_read(&dmar_global_lock);
>  		iommu_device_register(&iommu->iommu,
> &intel_iommu_ops, NULL);
> +		down_read(&dmar_global_lock);
>=20
>  		iommu_pmu_register(iommu);
>  	}
> --
> 2.43.0


