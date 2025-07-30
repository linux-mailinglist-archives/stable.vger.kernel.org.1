Return-Path: <stable+bounces-165592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79BB166EC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859A158570E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809E2E1744;
	Wed, 30 Jul 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do4b+2KT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983341D63EE;
	Wed, 30 Jul 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903773; cv=fail; b=q5le5HeHb1PzjsIlNubsFIunj3JdGkzI2Qd7yHmdcc58+ccwQxioiVDLd1pzPRU2ynfMM6q8DXGHWnTqQ7ChxWc6qxOQYLZz01LcBbXfqptzcIdv0I+plL4PwZee/a5YRzlcdrAKEVf4e/iaFFQ0wzCE6xRpuvpTf2wmKlb8T2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903773; c=relaxed/simple;
	bh=7Yt6+qpwmAjLvY5uc7331eh5jtI6ec6jWvdiKCWrS0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U13KBC9d39jM98IWOZZGgCPAdtQqvKycZTaJSbaMa++vsLTXeCp2xTNwOhJL9HdR38vyLNjyd9Fav9Rrw8a/IMIAAmjuk5orHE4xkErJv35RXHpE5TSNnizWDYq6O0q3p8Fx/fxqTOpfIRcE62EjpLvBfeBNHepDY2UIsPtHfHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do4b+2KT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753903772; x=1785439772;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Yt6+qpwmAjLvY5uc7331eh5jtI6ec6jWvdiKCWrS0A=;
  b=do4b+2KTvVbyjp/Y7Aln1ionoiDXH7i4ROcTvP+zFLhccklhteh83Nz5
   MJcOFUd1ZkI+gpJPoDkMeSqZrX6Fpo6evYOU/1sm/8/EgNAQLUBLYQT90
   ZBmSNav/g/1sRI2TDAEC+fOan+sWwfH8gB4c694s1KYrczW0NheIZhlb4
   HHE+Flr+ukMGF2HGclBj8YTlVDkWEq7KSpGCx1/HftbXKsRg/e9QEit2t
   Iacac7q3Vz7q+0flf0P8w7nmJ5hHHTEfCop+ZVPrfKBkGey7LuqnMEhRH
   UWCj5sIV5p3TVbAVavQFM5APOem4v5o60SpoQtK/Q5JS7dncaCw08elMx
   g==;
X-CSE-ConnectionGUID: P7Nv26QzTKaq2k27lY5hxg==
X-CSE-MsgGUID: zCkHxIQMQgGIC33P2xqycQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56306338"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56306338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:29:31 -0700
X-CSE-ConnectionGUID: aKlMm1f3R4SpfxCnDFYAYA==
X-CSE-MsgGUID: v5Wf1p0QSrabu7CLqdQ/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163516859"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:29:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:29:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:29:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 12:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc6sChKkudHd9LfUEH574vaXNjn8vfBBy5DzP6SLP4OK2oJc2SHOsc3TQP57efr7dZw5DmqdATruthKaGiJhctXYzIaxnl0A1HwWvdsYminlxgsHYKa6qG0ZXEMO+9hAk2WviPWHoO7dUWlrPcrXSjw209vnYC3LhjSULVa7Fm6cX+MWL0oRSd1cElBB51A+0humGPqqm0XMJ1vw9n1ytuJ2aHa12CZ/PyK4/ADiTchj7U2eXsFHJXaDnDasQ+6SrwY342kFsvg4hoqdvFwkpqgV5YzbF9OoH4BRCFPPiOBC67kYYncwv+NJaA+1uqA5PxtKpal1Q5/QDgEt7Sc6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTkbfVzM14ezMjcPrAcYAnL/VZgwfOyjL/vm9sVjkCU=;
 b=Wl/7AahMu+rjM7qEihOlL+FbatXsUl3rNP0lI02Q7nh8H1H157yr1C9NXwNC1mSxDVibo66NeKZr/ec/F36HGPdpD9+rUVOgQwKbLPZRyGN7B9YZ/4fvA+DnkH3G45uWj2umF4d7EnpBS7qcKfVM5obsHC3mj3VLGfyYw2ZMgal/xlCkE3IazPFEMJ74CNXpUhZIRaWz11xJhekKU8mACeRPquOvxinPmoI2uOUxnoi+JK+/9L7+a09SEKNlHV960TE26ew3hVXUqwpYCTffPpCQJ8519gn9JluX6aLaRJaNme0pNkFBpGzvKN32mMoOmOeluZWJ1nNzB//awcFHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:29:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:29:27 +0000
Message-ID: <7590fe81-e771-42b3-b9fd-31ad3b7860bd@intel.com>
Date: Wed, 30 Jul 2025 12:29:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
Content-Language: en-US
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <darwi@linutronix.de>,
	<peterz@infradead.org>, <ravi.bangoria@amd.com>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com>
 <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
 <834f393e-8af9-4fc0-9ff4-23e7803e7eb6@intel.com>
 <CAO9wTFi6QZoZk2+TM--SeJLUsrYZXLeWkrfh1URXvRB=yWtwig@mail.gmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAO9wTFi6QZoZk2+TM--SeJLUsrYZXLeWkrfh1URXvRB=yWtwig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 054f6742-c4d0-472d-eda9-08ddcf9f65de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVk1aXViNHlGY0ZlMWRlRDk4QUsxOU50WGZzMHAvQUVFOU0zK21rZlEwZFJt?=
 =?utf-8?B?UHlxdFNoS1NMZUNPMVZvZmt2WGZqTmZmaU1NMFJBN2ZneVZBdWxEVkNmTFps?=
 =?utf-8?B?QkpSRFpnZEgwaERNUHFWUS9jZzl0VEluUHdXbzJrUENhK0ZyVEVqR3hUOXV2?=
 =?utf-8?B?N293QWtjVTU2Rm9RMC8ybFFNdUl5c0gxczJoeWkwR2ZHS0EraUpTc0dpUTR2?=
 =?utf-8?B?cDRoNEZiUnBKdDNabndvWGYvOXNoRXFqZVN2c25mMjNlclNuMm0rTEZocDNO?=
 =?utf-8?B?RkIwS1Zjd3grVDZVdWt4M25QYVNRTnJjNWZQM2lXMElWNzJhQUhrNEExV2t1?=
 =?utf-8?B?K0VacThQWXg5b1ZyRHM5TEhzb1A3YzlYQlkwek9QNnhLYSsySDFiRjhXMnZC?=
 =?utf-8?B?WUJqMHBkaVpIS0ZsWU11V29TbXRkcDgyZExSL2tqVUZLeFFLN1psTnhVSnNS?=
 =?utf-8?B?OFFMak9VYXAvS2JmTEdacmtaVlRvWnhzb2pkbWdPNFBjM1ZjblgrUzZqY0xz?=
 =?utf-8?B?QmRXY1RTOUo5dDc4dTJrcjdJa3pnRk1US3JFc25yOCtJTkFKTk5BRllsZWpi?=
 =?utf-8?B?WkRwS1IwMSswUVNMLzhybWlVYTZadWlQU0o3Tng1MEE4S01ERUI0M0t2ZTdF?=
 =?utf-8?B?VHN0S3dNK2lramcwRlFXNXRpT0lGTHJyVE55ckJGd1oyeFNSNzJMVDJHK2Nv?=
 =?utf-8?B?N0NXU2tMYWFYWnJleEVIeG9KN3IwTDluMVBNNkRMN0U5OHFVNk82ZlpNWWoz?=
 =?utf-8?B?S20wTC90WG9DanIwUW9Ib2Z4Q1lMOElLK1NtNU9ZNEZPaVMxZ0hQZHc0bVAx?=
 =?utf-8?B?MmFVMEFLcWYrYVlPQ2Y1di93Z3BkOXpzc3VuWnhUVEZBdXN5YTFOUU92am1h?=
 =?utf-8?B?eVoxRnc1VU8xZ0wxQ2FYcUp1UmZpRjNvUDYvMGJmRVdhWTNOeThhb256NVRn?=
 =?utf-8?B?bXk0a3ZmYWlGWFp2Q2NTU2duZVRMenFNaHdiZlh3Zk5uY21sTDc5M3RvL01t?=
 =?utf-8?B?bXhaMDFjdDhRejBydUNnd1NsREdqSHhIckprVHZYS3JoQ0E4ZXI2S2tpdEU0?=
 =?utf-8?B?MU8rMzFUaGdpaXphMVRGTVMyUWRZbGtVdUdiZUVrWWlQMFpQUFJKckVSc2Zv?=
 =?utf-8?B?YU1JMTlnYndVZk9RRVpTd2Y1OWNud0tWY1BxN3dwNjYyS29EbTREc1paVko2?=
 =?utf-8?B?eWxkTks0WUQzVEZOV3pVU3lrT0JHOVRrRyt4cGR4MDQ0OWI4T3k4enE5aEtG?=
 =?utf-8?B?UG1QR1pqclRJRk45SXRNczhjOU9VUHBraThMVGtBc0tOY2hTZVIreUxGekhN?=
 =?utf-8?B?V3JLdUdGMXd3RXVJbFZoMnlIcHJvajRENmltaE8wVmRhSEdMWnFYWUpoUjBs?=
 =?utf-8?B?U0hYM3Q4eGVkM05ZcC9tZnJqczhMWHJQeVpTRmV2aUp0WUFKZHdBSllqNEtR?=
 =?utf-8?B?MTBlNFNidTNDLzE2WHZZRHJwVE9GK1lPZnNlQUk3ak1NZzhWTlViL0lBUUFq?=
 =?utf-8?B?QjhXYWJIdmZSN3d4Snd1clpraVlVZWJPaXQvMUxIT2piKzErQ1pvM3lwTTgx?=
 =?utf-8?B?RVNIVUVEc21DTWdFMjFEdTVxQlp3cmtmZ0hUditzN0dOMThHSkpMdHMxdEFW?=
 =?utf-8?B?RUdIOGtVUVc5dnltQlNzeGQ5RjBObzFHYzRGNDJsNjhZbW90VWRGeFpRTHdn?=
 =?utf-8?B?R2NudmhQTGtpMWdaazc2aFlKZTcwU2tKZUxHbTE0eWthSjAxL20xWVB1bmt3?=
 =?utf-8?B?MFNHMUhzOHNLc3U3QzBaekp6bHVuTWFwQkV4VkVKd0hxNGptaldOOEFWeWd0?=
 =?utf-8?B?ZHRkNTk2cjQvbWRuUldGYUQyY1hVY3lPWStjMi8ycHl2THhmaGRScUhDaVBx?=
 =?utf-8?B?OHZmSkNpOEVpeXhNMXFXdi8zOUFuS3RXYUxIN2ZsTmVJeS9MbjZpbEc0Tytu?=
 =?utf-8?Q?b/S/C0LL2eI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZpaXNXemlBalE4dmpXbzEvTDNBV1ZUQjE3L0orZUtoRy82THd2bjkzUjhl?=
 =?utf-8?B?clNNQndsZ1JCRUQraVQ4aDhVU1I0aFJLYWtGSzBLWmlpNHRQMnF6eENZd3lI?=
 =?utf-8?B?MmJLWFBXMFlZSTBEbEIwdW9UWE45Z0xUTW9lR2tDZm54K01PMHFYd2VFTnBu?=
 =?utf-8?B?Y3hiK3Fic1RVeHFPa0lJcnE1QldnU2ROV2xDb0NZTXNCN1BYUlp4RVFjUEJt?=
 =?utf-8?B?Ry9Sb25lbjJBMVlveEhoWGE3N1J0WjJqS3YyR0NwSXB1akJRMmZ2TDNDMDhG?=
 =?utf-8?B?aVBwMUR1dmNIOVBTL1VlZEhHdmZRMTVYbmQ0MHJIZEdVMnEySXM3L2I4TE9Y?=
 =?utf-8?B?bmppbnh2L3FjbmV0VEpVSVlVY1NZREtNVG1TQXJQM2hjekkyRWlidXlsOGFm?=
 =?utf-8?B?dzhBSFZkK2NmU1E0OGl0QUhOSE5kS1hoOVdHUWpTbVliTHkzbW1KOWR1UTVv?=
 =?utf-8?B?dFNYUmxCYW40M2FmQU5Hc2ZhMXVIRlVTcHBIVGVHNDFEUFVjN2tLenhKRktR?=
 =?utf-8?B?eHBYS09LbFFJQ3NyeUVxVE5IU2xLS2xLdktIR0JWTnlUSERqSTYzNG83YUh2?=
 =?utf-8?B?bWE4ejRFVkhKZXVPR2FPdGpJc2IzN3JjdTRranVhUGlmNWJkVlQyY3BPeENp?=
 =?utf-8?B?LzBSQ3Rmc2I4dFNZeDNid1FLbU1FZEUrUDVUOVVmdEhJVEthTS9NeTlFSzJw?=
 =?utf-8?B?clJvbzZOaWp2MTNvb0I0YmRsYTJHK1dCWmNHWGFUb1Z0S2hWMGFDRWt1NnBm?=
 =?utf-8?B?eWs4bGhhc3BjbmNwM3lNSS9pblUwK09LZ2Qzd1NrNVVTWTFmaVh5d0NDdDNS?=
 =?utf-8?B?SDJoSFdtY2VsY1RPRFJENzRaQU1TMFN5ZmVjb0hLN0hZZnp4TU44NU9IRW9l?=
 =?utf-8?B?emxDeUNRSllVckR6VjZOblF0cUw3SUhGemVpcEt3OUtVUnZhamlIWEFKNXRr?=
 =?utf-8?B?em1YRG1LbTlSN05KYUVoTExNejVhUjRwRThpbVpjNTIwWWY2d21XQjNucXZF?=
 =?utf-8?B?cXRsRlFjcHBGbDIyQUVvSjJYaTVzaVQ5VUNzYW0xS2ZFZEw5TjhvbzNqUkhl?=
 =?utf-8?B?bllMSVVGM0U5MnNhN1BreDRBNW1TVGU4R2pFR1k5Z0d6ZDlKNktWNHZPRU8w?=
 =?utf-8?B?a1ZCNUhoVktHaDVCSnZmeFZ1MjRZUFhRZ2xocWkzd1BzN1M0cUFVdnR5N3J2?=
 =?utf-8?B?U24xZE9GYWJENTN1dkduZTB6OHdTK3FlaHdzeWc0bjBrSzN2aFR4NWlqZmtO?=
 =?utf-8?B?YzQxUHU4ZVZsaktEaVAwR3VSTWJhK1VZMFEzTkg1a0duR2crNlpVb2NUUENl?=
 =?utf-8?B?RGZTWWNxUFU1cUdHUExzY3NwQnB2TUlxcVI3WDZKV21EeWhRWjFWT0h4Uk9G?=
 =?utf-8?B?eFQ5S0RLVjlpMXRCZFZJUDN1ZWF5QkxDbVpaU09VNC93dGsraU5qbXNaUUxH?=
 =?utf-8?B?WUJLSWsxVVhnNTgxajdtUFhHM1BqZVFEUWhFSk5WNTdxZEhnTFFLMW4wQTR5?=
 =?utf-8?B?VHE5NFdjb04zR0dRWGxtSmxPdUM2Y3FLMERqWTFuY2d4RHNsanhLMmJ3dlUy?=
 =?utf-8?B?RmNmajlYMzhMeU5xZWFEYkpONnFqME5sSTZtWGlLS1RUVGNGV2Nvb0trRXgy?=
 =?utf-8?B?YnMyM1Q3NE9LWXA2UWhweGovL0JvNE0yWC9mQjJGSHg4Wnl0bUUrekpmeWFQ?=
 =?utf-8?B?cE9HTjNQUVNuTERpUmdIcVNLY25iNjd2ZjdEMFBoUG5CWEhlaEtiV0tYWVlQ?=
 =?utf-8?B?WE1YSFN0MDVsWE1aRlZhRkVyUGZVQjhrdTF0YjFOU1Y1TjZhakFFQTNXUXpW?=
 =?utf-8?B?N1JLVzJ1NlJENjZPZzBaYWJWRzkwWmo2bTN1NzhXb3UybEx3Uzc1SGo0OGto?=
 =?utf-8?B?NVh1K2xnVmlBVHB2K0FKZ2JuaG5EUzNjSE4zL3JESmRhVkk1UzQ0amE3cHRx?=
 =?utf-8?B?QzN0djdISGFYMFdsYXhUc3R4TVpWaXBsRlFNQ3VLcWdOQ21yMjFvMk14ZTQ2?=
 =?utf-8?B?ZDVDMFBVQTVjWWdwbUhITXMxR2lwMTZnWkxhaTNIdjdUa2pzZlhPNnVTanBh?=
 =?utf-8?B?OXd0aE96V0F3U2J5SnExMzA0YkZvK0hpeEl2MVFudHA4REN0TUhwd1RYYkI2?=
 =?utf-8?Q?9lWeaY3yAL/MMpxnnAnHp75To?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054f6742-c4d0-472d-eda9-08ddcf9f65de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:29:27.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwp0rnGbBXN+rjlmEN88W/ZeEfNOT3DkmZbUgVr5OABJumMmFnnCqL1zK+LQtmQsmJkchSAwKf/SNmGCEzDKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com

On 7/30/2025 9:27 AM, Suchit Karunakaran wrote:
> 
> Alright. I will send v4 after the merge window closes. Thanks!

Sending the patch sooner is fine, if you want. I meant it is likely to
be picked up after the merge window has closed.

