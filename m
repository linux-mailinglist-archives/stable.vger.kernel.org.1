Return-Path: <stable+bounces-127437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDCA796F0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C511A1722E3
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830051F37BC;
	Wed,  2 Apr 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP+gmD6v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF21F2B8D
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627420; cv=fail; b=eDjsxx5Sm7utAExyZvxI9QMP8ab7SDC1oOkUPbGiOU7y5vDhwO2M6x7U7EhGEIfaAHIAavgamhMgjIRrKCySu+nDZYpwpetSAtilcmAn8yR68pBrBD1MjDq0WwgLSHHRza9fxT17GWpQVw1DW5BQgEXGAcsredsM4lezfdT2HH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627420; c=relaxed/simple;
	bh=aOWZzUWmemVA81ccPbvAywuNKCXQD2jgp4nZpncL2W4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQkdMyW5oTMnvgMvfVMHq0co/NRnMl1yfVemI+DNJyPlkcejC6i64mZ92qa9IxYB4Ar3wmoygHeALIytD6pAv5BdHP0xSGKhVkVL0LV4B8UwcJk5EN8MYDE9s58XUeJuK4ZoMWJgoqSU5VUv/kyT5WijTSL0nLwxVuOFgrDoskI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP+gmD6v; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743627418; x=1775163418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aOWZzUWmemVA81ccPbvAywuNKCXQD2jgp4nZpncL2W4=;
  b=eP+gmD6vN1KZnfIjdiDEZWIChnHYm8TjKq/pmJoogUkXwYF/BfCJ7IZH
   D6QCkINxN5iCzwtby0D+RpaZIRF2De4Khi/6fFg6ibhkkvUJgQHu65Eqo
   AV0ujMfFLpJSMhplDBYXK/0yzZD4p+BlQ85dsMRFYpmMvx45Unz3h4Ixg
   9oZndO8LNncInHNdE0VVvmXErZAPWXenRCcAx8Yc4nfoxz7kCzXjAKz7L
   +JUvoeJ1KvLk5PSaIp8vNSuV/VPODeJ3fD709s2KPXLPyJHJzx/PeshhL
   KTSQAbuiwdn/0apjrlI0bCxX09Uv0coMFNGhUrov08jybqjGl3boh+yrH
   A==;
X-CSE-ConnectionGUID: NsWQ3M0XT/CoPXZg1fZhMA==
X-CSE-MsgGUID: hVtACgAXQ3CeSy0E3IKz8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70380569"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="70380569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:56:57 -0700
X-CSE-ConnectionGUID: I3uXa9q5TyCG8uJ1xnnl9A==
X-CSE-MsgGUID: Lsv7MKCpTYiRPx86Bh1exw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="132012703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:56:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 13:56:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 13:56:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 13:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEIN7REj/9x1w7o9yi7lSbpv8lmgUJzLTTM8ouCAz5gwAlktwZ8qH+VtmIcNUdKhN+YhQHJbWxvjY9LQ0l41xVvUl3S/BpdZlKRjabbvg7oYWLbOiSl1Ca9IMgrSCGsARPZFuqu8LNG9+AFJ5pGxOY6lNBOhp237and1EdcnWlWhPHZndPlUOm3zMD71y5qOfH+wTAQyk8CsVSH5usqC2pxcA6CAmOWzzPZNKJUs5xlUP6lmAp77pdmz2+atImr2caTvoKakz2MFejdBIgK3tv9u5IfdRNaUjVxa/7XEL3QpngsfQH3/dgnhIKThNLh+G8xIB1KnK3Bpf6K6YmKGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjlu1c8px7hc6sh99FMtHhFeJVwGNIT5qxPgTb0rgxI=;
 b=OJfsQ3Why6J89cEsldUl7X+V1sFt2blw9aSRWbI8yoAzLj+5I1T28jq0cZCsIenQP/Gwt4Tb0GivTN7gyyUI1QhKcBRtTgykfKmAqyRcB707QyJEt+U+2EueKazUk6U6WDL9IyW31t0nPBH2drUwGFBO9BDTk5HgB93bgINaBpbRtPJYZuavzc8COOciwobZ5E8xF1dkIkUk0YFecqaHKpBtMd0iofra0HpIQNz09B2qfLBHEXf/BbLOCvD9Qshw1EbxjK6pq1IL3gT7/Oh90lN2d5k2Zxq0KkwQDFnzVyE66YgQuR1yzH7GW8ChYA+fyI32TCPjXEeGDPkYV3XZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 20:56:52 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 20:56:52 +0000
Date: Wed, 2 Apr 2025 13:56:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>
CC: <dave.hansen@linux.intel.com>, <x86@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <67eda491a62ac_1a6d9294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: bb79648f-265f-49ec-01f9-08dd7228e52b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v5r1ka6cs4M/WjXByOo0V+jjYSkGL53PkvQeLCI0HBRgxy6ZZCTYp0LccUfK?=
 =?us-ascii?Q?/W9A7oEpfFm46eQTWsGrzQjO8AWBHnwBBPrHUpDLBZbrH/SiIzgkqZbEgR6P?=
 =?us-ascii?Q?NllJejTqK25nTdGw2uI4QGZKkwwaSYolVKV8jllCw9xJnNO1d3l1bVsM9guH?=
 =?us-ascii?Q?G43K57eUg8hYN4HZC+m4nIUr3bQCsjIvA7bwVKhGctUjxmiYvFxX/VvecLmA?=
 =?us-ascii?Q?bfJktrR+2LaFSuyEBsm4LNSRnyRCJAZ5Qt9IkZmIb5VxciJ9s+0YL5FFpNCL?=
 =?us-ascii?Q?mLyQjZqrdx1+ctbjmmLr5IMD8yzxiSUyGnUo4kkB71fl0DUmgmbIkldXyVX1?=
 =?us-ascii?Q?TksKA3tW+JKC7uwSQXtsUVd5Xt3J+skoTftjHBIhYnrrXtr9QRqQM4RzR3jf?=
 =?us-ascii?Q?cdkRRCw69o5RKU0Np7QjIYQ1eaDkvczVGI3iHWVnRCRQObK7K5VgSrcp0km2?=
 =?us-ascii?Q?VMJN6E0MRTlhRlhvo6jhHtDNIoVgHo9AgDzr5No5BrDUpkNEOymD/qeWQ8Jo?=
 =?us-ascii?Q?/9eqSyj6BNdh25KhrmPfyjKjjOEyiYMEdJRJeo1Z4P0tvkA42NNbJcDB5Mym?=
 =?us-ascii?Q?L9bgUctW5RyMH/nPpY+KJC4kZvWKgJm40nTNAcmawl1tH+jqk1mIvhsQPmqZ?=
 =?us-ascii?Q?pHP0PhxgM1E8XWJ106oglcAi+lW+NYcrUU+4OAWT4inZ8SLxy8TrelK9uAtj?=
 =?us-ascii?Q?8MpPnhP8IDd4YqyJJgk5zCEzj9gXVdur1XR87QZCmibwdjJlOW3BJUCn/SCe?=
 =?us-ascii?Q?fsREqAgrFEKG4UiixLEnlunzc+d6EIH//VaeWAlH5TXFVVkfv8VZimYkuEE+?=
 =?us-ascii?Q?giFxUK43SucMu4vO3AxfvE22y2rZmmhI8iAwXxR8oSiiJ/o/U+B7vIVyzO/J?=
 =?us-ascii?Q?rvO70b+K4be4iKXGYO/PQT23NP62/tt4ZsHMkMkWF/dI42iB6cbVtYLnjdwe?=
 =?us-ascii?Q?Y6EI3fTCxMesmIzeQD3SWoznWap0yNmVM+yjodP5MyB5TSLXseaJNpo+25Zy?=
 =?us-ascii?Q?urKWv5TO7SfnAI4OTh+RYfWaQcEGnmOR8nMO4bCks3IuZJTj7L19cjEgCiCn?=
 =?us-ascii?Q?jJrv9vIMVhcKG/T+D9nGjaaSRPMowzcXegSu6i+WETCzCrD6Pju4iEF1Cki4?=
 =?us-ascii?Q?3xIWCFNFf0xxSMrQIO2ByvN9/D9ZGsAKwzBg7BAQqMSgqgf96twhx5Wxz0Yg?=
 =?us-ascii?Q?YFFq3VG+rb1d9XV1gY/38m/rXmUC+58k/DH3ikdm6SnIoe+MFOXLbEJzEkMs?=
 =?us-ascii?Q?Mps4UaIsM9UC/2uEavFLHMWgLxu8qZBvIkV29/hkTk3TnY2n1agJF74x5qtq?=
 =?us-ascii?Q?txK3Vwo0SgRtzlQLB/QDwcm/cFaQfEX5JGoRsycfr/clyF/Jo6+GOG5DMGj6?=
 =?us-ascii?Q?IiSB/ARQa2eaUOkF0NzbBliu7s1U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5L/HJi0BD2do9Ll+KdoB/1D+jpIv+AkbxbcZAxLMlrV7fa+OPy1Y062RxIXs?=
 =?us-ascii?Q?zgSykf+Vcghu8FfKmZ3Y5ERk7iDLLsJLGhd0b1/b5PMgCxGY/6P/OOBIyYgL?=
 =?us-ascii?Q?e02U5zZjj/x1C8ly/rdFW2aUlMi+FT/GEWlVEQJv0AlJSBngWJeYPQ2+q+zk?=
 =?us-ascii?Q?QF7xeyrNiHy5pwu9F8eYC5qULs1ySPe/rEfpOoYKG/jFGqFxT3bg+giHF09P?=
 =?us-ascii?Q?+uEZriqJKjqW2IKSZB3Y5TvEjyKyhe0kbHA0dm89lTv70QAXtP1BecS6CW/A?=
 =?us-ascii?Q?gJ/3QH2q5/N48dGHIhYHSDCsiuh4qMMl9wP58qe/6ogfSQtA0J5cXxUDqzII?=
 =?us-ascii?Q?AnsYPucwyiH3f4jpuQ/YzgzpNmkrxC4yOkBFpVSKm9c0+e+eIZDUBYeqDEVG?=
 =?us-ascii?Q?fzeFbXi3GNnDSD+D0/ofHypRx6iHq3opEPMtrcKH6Ab/JrZa8jaC/SXefA5/?=
 =?us-ascii?Q?7CGyY6h1y+Q2ZilNwfueChA1A4dRIvgYUTY+fZND6sYNCygGOUJeE2HOaD/t?=
 =?us-ascii?Q?FhNCEd6kUOsWgDz30R3+3dD8w5J3IRvbbNoks5LssSMnMeiCqj+m/3QFoM8k?=
 =?us-ascii?Q?LrorDcvCk8Tw9AORoiopNppl4fA7fALQgaSsvf8KcIlYibmzI0Mrqa73IkCm?=
 =?us-ascii?Q?Qzp/t13CLNCFbF3OmkAyu7ZwIVfzmYh6Ea3aoyXp+4S/AhsM0hT3vklrdjZB?=
 =?us-ascii?Q?ZhJQYV4OfaXrUp62aRoemNH5R5svJSgfqKAokxHokQe8dbT/7FaEv6iilnCF?=
 =?us-ascii?Q?z2c4RbEf5Xax6rlbtUbO2/o6AaI9GFRmLTJc8i1H4ZdgIXtEQP3LKVuk0FJ5?=
 =?us-ascii?Q?02XhLxMA+ICxypU9wD+ut+PQuutKEFOWQeIUf6BQlOkkYAPVQFwt8l0m7mTD?=
 =?us-ascii?Q?bdj9egw6jTaETmOOSHrRJHgZCgs12vc4WelmFlqzft1NEPqlqcOwJe1agyZv?=
 =?us-ascii?Q?j4/C36iVjv09id1eeVo2Zp9Z8W6uOm9b8G5AFY9AVLzC4P5NNSv9AQJ09bCj?=
 =?us-ascii?Q?svaxkueMFAkk4na0tcM+kiC1fbHxR/IufrotE12Oy9yCYWQ4s5pEx30z+7tJ?=
 =?us-ascii?Q?cwh9pG0IdVSd/57lBrDmwsX1QcbZveab8iRBx0V3soAUCJj2iq2GxjuqbTgD?=
 =?us-ascii?Q?uk9z9YqsueNSR3GjuKo5Vt/oIYD7sSqB+Pf8eOXLuyeHrjonyLNHtC1NRUy7?=
 =?us-ascii?Q?2XjmLrfeROfDGKdNkZlRy0TPxs479zbiGWN00Re8PuNV5T5w4afhS/FTcglO?=
 =?us-ascii?Q?os0ZpPee5+xu4VBz3WJiK/+TpC3dctj1MnMv9rbxrudYc8y0pzmX1jLGdtE3?=
 =?us-ascii?Q?+mDjcSf3LPuy+KjfJ15JjKuJ4m6dc+7sVCF6dILd593C9YwuDXrAX3kKHIyt?=
 =?us-ascii?Q?gqTTrpc+4II2sx8zSp66ng/jZaxTr9p6qkjEJqvzfpyDXJgfsieJgScqhv+7?=
 =?us-ascii?Q?aaZkkiCEWNWLESbHPYmqxwTTcVz4+/ynv6vX3Y+FQeGKasml/u4/fTR9FvLG?=
 =?us-ascii?Q?BsnFvfubIaa8iwr2S1dMjOjxoKP8FB/1uLKGspkABib/VzIiKlvsMndgS7/c?=
 =?us-ascii?Q?zmCU2w79jKCqe3JF6gZktwxVh/JhhapmcmvmrVD/IE//+Yc22q3HYPMwKwd8?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79648f-265f-49ec-01f9-08dd7228e52b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 20:56:52.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgzPkyr7g+MH7XvuYl04evcWDXnxIGwL+c7dvS2gB4swSrrK3BNfbl/+FIFRkUkOI81RI9Rd6Bz+rmZDcH+Mg6PoXc8m3PQGhXSvuuYtpkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com

Kirill Shutemov wrote:
[..]
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index 42c90b420773..9e81286a631e 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
> >  		return;
> >  	}
> >  
> > +	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
> > +	if (PHYS_PFN(addr) < 256)
> 
> Maybe
> 	if (addr < BIOS_END)
> 
> ?

Looks good to me.

