Return-Path: <stable+bounces-45682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744528CD31C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B27A285580
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093114830E;
	Thu, 23 May 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xaz1MHZW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701C14A4DC;
	Thu, 23 May 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469349; cv=fail; b=JBvXR4N09UCn/L2mpWffj/KcV3ANHERRXzlaSrfkJsEXYMjeSVcGcCiHZgg+T6/YPWU/InMSuwX/zo92kIXYnke+IK7cD3UqxN48z1PbxcLlWmfKHSAjzLEFGCh72CZjx24Wz1d+dVWOfB3+9wLfsw3aw24iZcM7u6hha6fcTGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469349; c=relaxed/simple;
	bh=0HZCQvez7125gQb7FmvYdAqNIFiimBWLGjYWGExpAqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vp/mLJXolxanAk5cEOhI9hiAAB+19KgOxXle8+Yo0sO58pyLmqc2nSIM2UkTbOd1x+4bfF8tqvVtq7pR/bnYeHR1ec/Jb6IApChe9e032ezKNRryPWIxiLS3b3N+JnxIhifgpaPxdmVdoNY+5xQgq3LOQXi+6ejZWH+d94yRDsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xaz1MHZW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716469348; x=1748005348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0HZCQvez7125gQb7FmvYdAqNIFiimBWLGjYWGExpAqE=;
  b=Xaz1MHZWejdzqoad/TBsBzoFmP7lRYQH9q3xGI1Zygk3Pu2UhKjZ+BA7
   GYC7E2L6XBSyCEpCLqh17FTvHHU0lcBNfrnm83MMGg4ABM4Yeyu96zDSQ
   w2fmK5UjMdxgMNEGlXFx5iNlTPgfQBQ+CCB7i6LstQApyM/Sur+UrsTeD
   0imLRsI2LJRwrWTlUQs1zBCz+JUir2GLHUoc4vzLTWHt8lvKKWlGh5N26
   tu4mH2dWzrVgtZ4Nokqdhpu64Orzl7UY/RuUv9ocgsWosbLWvTErDkj3D
   wgVKYEzajiEJFn7OZmMqSIqTTWVwd8RUQ2XlsBbtdNcxO/o0EKYYCkiGZ
   g==;
X-CSE-ConnectionGUID: PPN/jmXESii+GHnfDPXijg==
X-CSE-MsgGUID: pUYNSpBERZCLTBiBrb6K+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23394118"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23394118"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:02:17 -0700
X-CSE-ConnectionGUID: bOitIyVsQCOUy8h/D9RTpg==
X-CSE-MsgGUID: DGNk4j9iS5OV60Z7ZalOcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="56891066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 06:02:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 06:02:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 06:02:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 06:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfS07Pi5yaLJTF1rAvvcdrA//gRLfTZwk9knCkWmrsMJf1+rsiBXBPC2lAfbCkGEyfEAoaW3nOWJr+UM7mkz5fOY4kD9I4Leyse/bDVBSeEWYJSC19tksnfZ1vxrhLnA529FsdTeq+Wr7Lt9Og4hmgwiOqJMajLVCZxpiD/e2f2A7TBXhhBImz2LR1LmsI3PQF+m3ebZEyJkCYr6OVNpcVpZ0UvHTIfL9CATMrTuQH/HVV4c1PAO1UtRn++IYoqKjnp4WHyfqw/6nJjF6vVi1EvfnGhTs8GpzgxYIOJB7GYhvkOI89xBZ3PxYaJOsaZOuTLV0Bq/cUXoKDkXBgnDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkE0w06VmvlbsaUtFdIPojQiXBYQYwOSff0f9DJQxHg=;
 b=hI47IfBGrHBLi8F+ZHva7vay86Gu3TTNgrh05LCTj4EEdrPZD4k5wgzKJ+pY340JKpZgMArrVfZX9jJv7DpzxFC1MhIqIssHKlBU0Gq7kT1jKwdlU864U9XeYUuMw/ofwmNl9E4k9ZdBZCCBdMHPpH6TwMyxipbjYTNpk1T3XAlXz51/XN2ByZTshKrm0ZFy8d0y1MpbK+c4X3vuhG9pw881N+9FLRI+01C1QUloZVDdljCSS2+tfjGiHAZajKe05JejmAHB3YYfwNGe8wFS8lb0EAYFzx2ULHO7jW/aV+a7KcSindV9jwvv/0unqgUNXtgolD8PmPcwZnaksDeQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 13:02:13 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 13:02:13 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yao, Hao" <hao.yao@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chen, Jason Z"
	<jason.z.chen@intel.com>
Subject: RE: [PATCH] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Topic: [PATCH] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Index: AQHapzEUtjJdNJsaK0i6Uv4C/F0UKbGkrjmAgAAljEA=
Date: Thu, 23 May 2024 13:02:13 +0000
Message-ID: <MW5PR11MB5787B1488ECC68EB6A5F44F08DF42@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240516015400.3281634-1-wentong.wu@intel.com>
 <Zk8eP2-UEPSxv42v@kekkonen.localdomain>
In-Reply-To: <Zk8eP2-UEPSxv42v@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 34a33dd7-f9b3-4b29-6c26-08dc7b2890ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1IA+28b8PYBEjOsm+XvCyhsykTKwkwgoaWoGAJXRQ/KW2n5ssQWYQ6VecMbx?=
 =?us-ascii?Q?XOVIsEpASeutN1pc7J+lEZgFr+pvjzAH30tI18YLFXuZjNMraGqBkb7G+/CK?=
 =?us-ascii?Q?kpfypRXnSj2cdi6Z197DlUD19fuUXWCg+hHRHmbyAPCkojod2lsj1fs+wJeO?=
 =?us-ascii?Q?8awVqBS85+PueWQszpAd4o6rpqw4f8uICRfvbm5Y+51j6bp+gmqzwrQGvz9g?=
 =?us-ascii?Q?l+wAaJmtOFdfk1CZ+qWzYsvOuUuGDJjcifF3QZiqZhm7Hqx8HU1lAWAwnU+M?=
 =?us-ascii?Q?G+XFJR1XUfQ9qrRXXxjUTBUri7fO0jxyVk9bTkE3SyMKXZtYsAnqp7K6wn3E?=
 =?us-ascii?Q?HO+/O4/gO/g0o3MuNX/GdrHqc7ILuwYJjKYsVTEMPWFWQUI7Jwtog/rlJIE8?=
 =?us-ascii?Q?KQeNGthnkvygfibvxADCuwxPwIGwXudH3+SCHnKI6D4plp+MW4/yGpY8CUsF?=
 =?us-ascii?Q?jU2242BI7jPkZPvB1jFcpWORAHpjnyEh2O3iYT3PMROAmpNBRJ0/P529yqq5?=
 =?us-ascii?Q?NZVtKfapPb+tmyDrcuEHHh6CAVG5XVZIwoHmOSGSNUI/2UynR2U1uEAzLVrJ?=
 =?us-ascii?Q?2tMz0UZG6nu2W9JjAXApjeY3T+NSPKCKUe8c9GBXHBJqRbGZfwsA9I5YaEqg?=
 =?us-ascii?Q?nTRpGmwqQ3+V5OAKIGljy3wSXlcUE/LmbfltaLf7uI9iMOUWz22IVbj+XnHA?=
 =?us-ascii?Q?R5C1QB1gIJ9rTeeqsaKMYXCgoIOoK5WP145WkpPmCrFKc9Mq5RLyDCxqhkgB?=
 =?us-ascii?Q?hL7iwZvfsDUgJJMS3EfdX4xJjOrrZ0Am/TVEOmrzR1DU/LoXLny7Vpv0MqkI?=
 =?us-ascii?Q?XMtcAQ5E2kcphALNdViL9zKnQiRxjadCXS1D+37x5+dsByE4Pxi+po7J8MST?=
 =?us-ascii?Q?9Tfh6/poGGXSsrlxYkfHnMWXFwN227SYjEv9PILBjeL+iQb2nq2nz7UUE2lx?=
 =?us-ascii?Q?4Tim15ACzF9IzUkv0h4Xo4J3I1vzhYDivtefKXjIy5LVW7lzaGxR2TmTNzwJ?=
 =?us-ascii?Q?+P0ZItPIfhYdcKbIyfEYNOtR835uY5cYlAFDFTSO/4IZEU6kNmsPZv2OLnFt?=
 =?us-ascii?Q?MfXUwj5oOfNttRVDJ8/z1Qgh2gvIAm5MV/84D18jz2pjz2nqoItT3N5XwYaE?=
 =?us-ascii?Q?BKpPkLCRxQrvgErGPM0VXdhfpQnOFPaZeOslD1gtcNdcNTX0xavK+Nt9LI2k?=
 =?us-ascii?Q?qSCa/9putNnFiLynMIMKSEf6XFurSCwPhD4FgjrmOxCPrXASgLUNrX/eqbMh?=
 =?us-ascii?Q?Mh4uoJuKmPIxqm2RL3mhdOAJPNlKUo9sbFA8mcit6RwLdTU2YUeB3rny5ZUa?=
 =?us-ascii?Q?qSm7h9ppoaX/xu/XuPTTyh74EtTDWLvb3eBzQOJ3s1KOXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WbzB80usrPO+Ms4NBDmHlie0L6DijJ3la6Z2e6tsFRof0nku8OPsckK5IwG?=
 =?us-ascii?Q?NL3PIibH/+cNw00VexQnJ43+mA53VrugVsWGgB6WNagFVU3rpb2DSBdsB6ta?=
 =?us-ascii?Q?l3OgyrCYRpLtiFs+0/zHUd5wwAnt8Q6Vh7Xi2vgzmufKRpiYCuEla9MYDpff?=
 =?us-ascii?Q?RcfY0r1HWoYe95cClJojWrZjZaxu/NX28K4m4IGkENBtokswXNhJsLzQl3HQ?=
 =?us-ascii?Q?sp4LVXjIW6yqtWvvxdcqxali7vkitBQ4qDQYMqnbbwZiL7D1tPa6dWT7ZKTn?=
 =?us-ascii?Q?yYLXVUbCyEV3kdgWSzRHHvihXlZDjmYShRIg7MTCGe1gK8JHJdyfIIK+sIuB?=
 =?us-ascii?Q?1Uzj61i8Qz4ZrXbsMfKUDzsrayijxGEJe8BEknerZ3FJg2QEGpbRdMtsf2ZI?=
 =?us-ascii?Q?wCsqRPG9af04IE7znYlxkMMLA43jc+BLiajI1qZn5ys9fjOAyedJWh1rlbor?=
 =?us-ascii?Q?AGLbvAQGVP7VJMwBZ5J/uzAKbmEErl1T+CLSIYWWAIm6d5QVeDh/5ZwPPKik?=
 =?us-ascii?Q?hvzonkw0xFL+RSN6BH4QnALGzgxnt4kTeqZ8RgYOP1iALXhkg4+qtPm4pEV3?=
 =?us-ascii?Q?Yl22H58Co+N+xtFDonSelFjfXi0cQvqpowWlhcxMyv+kjBSxIfKC1/SD7jB9?=
 =?us-ascii?Q?nLMegHLswNKgN9ztPuWaH/x65us4+uDUe9DubUkKM6JnIYLHR4j1ASaQaRjM?=
 =?us-ascii?Q?lmLhJkZGTpeSgFa21SAaxBh2TqtdB65CoFgoz1HasLj6+fqlb36z+hnl5gV2?=
 =?us-ascii?Q?qtyinVrZJwd5msf/womcInlCTZrVrpi/uHIoIrNYOvfQJt33gVoVcKKLdmaB?=
 =?us-ascii?Q?PeavGTOCz8X7UHcqFYSy/+OX+ECHE31Gvpa49qoGkKhz7W0XXphPfI1kq58Z?=
 =?us-ascii?Q?DYE9aLpxUN6kNnzAjx3eUJbFlmKnuhHPHzwADVd0t+LrTn+DTT3UI1gjQ2DU?=
 =?us-ascii?Q?nI2DusRWfXJtIzNjB2mPuNRAdDvuzLH/F5JqDQZ+OO6ykAeq1UvkPQDPkaHD?=
 =?us-ascii?Q?JnHlpDpUocWYhfWqIu4IblLKeg3AZde2HarsNPFt2ZBSOornntOeoZaR3GpT?=
 =?us-ascii?Q?Y+uA1FO2rg9bgl2CSkARXHIL7aFeySnif29m5N1xHuwCIMQowe0UjUb6goLU?=
 =?us-ascii?Q?ykMe2T2VxMqqrl0xd23RIr/CiHHDJsdIPWlhotkPrrtk6vYeB6TnNh9G56uI?=
 =?us-ascii?Q?Ozz1tpgk4XQLkL2ZLg0FbGya2pFsTFx2tPFW3OLtjnS7XThL8IcO4cfZAGX0?=
 =?us-ascii?Q?plVyIB/Ql8ErWwPUu3Br31pBWgBvzPuozmdBeY6wein+RT+VGkBlHWhAVll+?=
 =?us-ascii?Q?LoOHEYIJv49i42sX17Nn4aFOzpP/0DPsmEExS7QPu3VHIiVHpxRresrJCUXA?=
 =?us-ascii?Q?elEuuLAmx8Mhi8Lh8KOcad353QFlAl4NB4Ea0MTBstn0PKcULHlSUJHnSrMx?=
 =?us-ascii?Q?aopyMguNzfVaWrRFCRDjNAbz5XqinlqlT/yKkOux7G60E+BlJT/+yTuGWdiP?=
 =?us-ascii?Q?q9rcYjjlLrAASVwoKibNSVmmNNgDwEl3lJ1qPuNLstG9KKB0gktT8I7Yowh5?=
 =?us-ascii?Q?KptjzWmlBJk5rwoaLQS360UQnnMhXLIfzdYLZi6z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a33dd7-f9b3-4b29-6c26-08dc7b2890ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:02:13.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlgYhsL3ZvSTTwmfdQtgviBo9Y+hdKcrF4GN9NgOMm7q4RXYzE2P/HCH/N3Gi+/D/crSipw4j3ad7IUJX87NxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Hi Wentong,
>=20
> Thanks for the patch. I thought something like this would indeed have bee=
n
> possible.

Hi Sakari,

Thanks for your review.

>=20
> On Thu, May 16, 2024 at 09:54:00AM +0800, Wentong Wu wrote:
> > The dynamically created mei client device (mei csi) is used as one
> > V4L2 sub device of the whole video pipeline, and the V4L2 connection
> > graph is built by software node. The mei_stop() and mei_restart() will
> > delete the old mei csi client device and create a new mei client
> > device, which will cause the software node information saved in old
> > mei csi device lost and the whole video pipeline will be broken.
> >
> > Removing mei_stop()/mei_restart() during system suspend/resume can fix
> > the issue above and won't impact hardware actual power saving logic.
> >
> > Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
>=20
> I think this should be instead:
>=20
> Fixes: f6085a96c973 ("mei: vsc: Unregister interrupt handler for system
> suspend")
>=20
> As this fix depends on the previous not-quite-as-good fix.

Agree, v2 patch will address this. Thanks

BR,
Wentong
>=20
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> > Cc: stable@vger.kernel.org # for 6.8+
> > Reported-by: Hao Yao <hao.yao@intel.com>
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Tested-by: Jason Chen <jason.z.chen@intel.com>
> > ---
> >  drivers/misc/mei/platform-vsc.c | 39
> > +++++++++++++--------------------
> >  1 file changed, 15 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/misc/mei/platform-vsc.c
> > b/drivers/misc/mei/platform-vsc.c index b543e6b9f3cf..1ec65d87488a
> > 100644
> > --- a/drivers/misc/mei/platform-vsc.c
> > +++ b/drivers/misc/mei/platform-vsc.c
> > @@ -399,41 +399,32 @@ static void mei_vsc_remove(struct
> > platform_device *pdev)
> >
> >  static int mei_vsc_suspend(struct device *dev)  {
> > -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> > -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> > +	struct mei_device *mei_dev;
> > +	int ret =3D 0;
> >
> > -	mei_stop(mei_dev);
> > +	mei_dev =3D dev_get_drvdata(dev);
> > +	if (!mei_dev)
> > +		return -ENODEV;
> >
> > -	mei_disable_interrupts(mei_dev);
> > +	mutex_lock(&mei_dev->device_lock);
> >
> > -	vsc_tp_free_irq(hw->tp);
> > +	if (!mei_write_is_idle(mei_dev))
> > +		ret =3D -EAGAIN;
> >
> > -	return 0;
> > +	mutex_unlock(&mei_dev->device_lock);
> > +
> > +	return ret;
> >  }
> >
> >  static int mei_vsc_resume(struct device *dev)  {
> > -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> > -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> > -	int ret;
> > -
> > -	ret =3D vsc_tp_request_irq(hw->tp);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret =3D mei_restart(mei_dev);
> > -	if (ret)
> > -		goto err_free;
> > +	struct mei_device *mei_dev;
> >
> > -	/* start timer if stopped in suspend */
> > -	schedule_delayed_work(&mei_dev->timer_work, HZ);
> > +	mei_dev =3D dev_get_drvdata(dev);
> > +	if (!mei_dev)
> > +		return -ENODEV;
> >
> >  	return 0;
> > -
> > -err_free:
> > -	vsc_tp_free_irq(hw->tp);
> > -
> > -	return ret;
> >  }
> >
> >  static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend,
> > mei_vsc_resume);
>=20
> --
> Kind regards,
>=20
> Sakari Ailus

