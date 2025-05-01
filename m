Return-Path: <stable+bounces-139266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D1AA5934
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 02:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E053A985670
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 00:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B321E5B8B;
	Thu,  1 May 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLCiecbD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A233C9
	for <stable@vger.kernel.org>; Thu,  1 May 2025 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746061028; cv=fail; b=gzuSHrIx9Zan4y8dBGXeRJBsU0tBKdULxBCsERQI11R8IcCQ3cEPK1O4k73Em1zIesaxoTJcO+g59VY0UsiANBcqV4lVk5qnU/I3rnwVwP2BvnJS4zzp8UEYSxHPQYdJLE3gOEaAG994wdm+SprchmZ3nnUtInmcIPFMMXF+7tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746061028; c=relaxed/simple;
	bh=3ZRN3Mi1CbRq99q7NiS7zEqJIlDxxVBXnJtF1gh/wuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBJ/DuFNzQ24m7dUUDu0pPYrbFjaZfmhfHnth6eMyKCuWJtb4Uo17YDx52eEgDhoiPL7CC+NunuevyzPtvmUmVTquxNv9jRa10/2ZuoModE3Ad3VJ9L0W/baSS5DKbGrPhpnsQ+QYwCmFb1jh8NyEtQzvnZKgSs4V1rHyQWCyj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLCiecbD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746061026; x=1777597026;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3ZRN3Mi1CbRq99q7NiS7zEqJIlDxxVBXnJtF1gh/wuA=;
  b=PLCiecbDrOyO9ET+vJlaAhnw6TcUJRcYOILaEVQpVACaLsyXxcoHYKiY
   SOzHW07XJb22cjeOSp+zHXcVuMEvyRqD/hAmeQ8VZYJmHepOrBIQxf5B1
   Rt7lQyIS9C0VtuX5tXlQUEn4NCTEAEBRi4bGYcVhTkpZB8iUY9ni/4D+w
   oracSxdoPpBjZmgmOssI2zjxCivRvVfYTl6SvQcy0IDtDvRg/A9jFqq3O
   GAN7YNbQFPEDqF5nQzQ+mEw25zybWWZ5Ao1d7uB9iR4UppsWsb4WED6UD
   ACsHq1SR9bkoT3cl6tJ/x9Fc4QsF8a1DRVu760saKh40QtBNY48bOd1Cq
   w==;
X-CSE-ConnectionGUID: 5lRM2gvSRP+fwl3J4xPtEA==
X-CSE-MsgGUID: TzuWEPpXQpSjc05nMMpC6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="65156389"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="65156389"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:57:00 -0700
X-CSE-ConnectionGUID: zlbmcxeZT16K11R3gZdqqw==
X-CSE-MsgGUID: HSGVEdmcSa68S23AQWT4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="139256868"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:56:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 17:56:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 17:56:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 17:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhmCT5gYoeCGZnND0mqgW9ypk5BHT4JLVJ1KVlEPidiD7nS0CANAB0cPgZb5Sd60PzvUNT4vjQBxLxJQAL8VBX8R9sTOrd+3f3KyhfsLCoUTUn2/Dsfla1GAfBVaAnwVbDPNy0T2sXxHPPbc7AtmpJ5oY4daQH4MTX8lNxY5pzK2bu2L+wAPVHIu3nHCm7q7KF4SHNJxl4HTxLfB9zsfaB3qn1jOQ1qC27vaW/0Q9hFVWRZ4aej6nJGL8LtVP5cS2nA2CjV9Y6somd+um1hqNJ9osBxy6pO2bej9PELs6J84nSHowKGqh21fQQucWaq83VM8aHWFzBjYNKxBb3Go0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ePZcjQA/reubU0ppmaxzqAnSJ7aCYbJO+TXpAfO92Q=;
 b=BfgKGeSX39tlwVbtproIl3ukLkm2LDN01MuBsTwM3VALywCl4E4zeSHvQAVVyalLLMrjPJMxW4M90f7Q2js/wNDS7xHQrM436qIpDacCAejCB/ucwwOVg8NzmO8OGpnbNcrXmsASU4/UV/aG8mfqUXoozJSWfSs9WlSmfuygxLJ5MP94zN4PkJYSW6wmwX8K52aAJk/yAofUW4M6ACOb5PC6jGvqa79oKLk/joHChFOB8Rd+iRbmcxgl+l02akn/k0r9JbBiJf2yA4eEcEWLelvK/+7ctxdwl/IwNgdAn+mfLn6tsTqY7Ib2tGBvdTnJ81UfScZquPWnIZcGZz7Tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 00:56:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 00:56:49 +0000
Date: Wed, 30 Apr 2025 17:56:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Vishal
 Annapurve" <vannapurve@google.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <6812c6cda0575_1d6a294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
 <0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com>
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5d5300-7b08-49bb-1b92-08dd884b0e02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WC2o7GujWSIY04KaH1p+7SmgWvHqNAJWpWJLEWVB6FLnP5H2L9SWuRRYBEWq?=
 =?us-ascii?Q?q7KIq5Qt6RYH3UlwO61+Tl8q8Dquto4YztsW478T4FcenG6ir1R6VBiO8ztT?=
 =?us-ascii?Q?/Keel3lUEXeu0U/EIKNN7dUp8Upj2HdSZCMXCsSxG8vhW34Qkq2goYJScVwj?=
 =?us-ascii?Q?sE0/4vB914ESSiorINgj9WUMpeSrTAkKy56WUsTsVbpp/+k6WwWUjPB9lutG?=
 =?us-ascii?Q?aer7DHMoDVIzOOiRr4p/xwP/iR47IYnH9AieVQExpi96spIEDgIpGtwFa5q+?=
 =?us-ascii?Q?6VTkfVzd7q3nCT7EPb3h6PITrpUQUiA1uOCOU/Pz0BhZT+7zlSO3hY6cW2Qb?=
 =?us-ascii?Q?4J2viFSPtJL48jowf+RaFoHvmFJPmlfH4bToeW7/kpmHwYVj3sqXnkGc/ugM?=
 =?us-ascii?Q?4XtDqtR3Pd0aaeP6YrZqQbzf5A5fCeeN4+keTYotaK7QxEz11nlcepie2oV1?=
 =?us-ascii?Q?Cil6xk/2UYNZHW/Py4b8NWZ/TgG2noQH27dn/q/09vIdfp9emlsDDrOKJUFs?=
 =?us-ascii?Q?ffuoB6DDcAUpck064AGJhryR/54/7IOfCntDXHbaITOmm4NowM+SOUDDg/4P?=
 =?us-ascii?Q?bKw0YT92bMyquq4JNgs7+PunkYA3PnjTn2hLQTLEMIUSCG5EVjHIoCE8G6qe?=
 =?us-ascii?Q?hWOPdB8NHlVPNv62l9f0x13N+jah1qJmlD7waw2vGbU0lTdjLL9SPxltcEal?=
 =?us-ascii?Q?PkJ73Nd2awnCvrDcJUG8Ar8hHxB9SIBW8JMXMRH6H3ghaIsyENUY1LqWLKrA?=
 =?us-ascii?Q?2w6I8BtxiSl3noTkPPlXxMDcAG4aHdjOQ0/iKvtecCPGuAg5CHDm3RnGNEjy?=
 =?us-ascii?Q?ZIl27alzyAds7NP3X6g1+L0ceJXQsFKdwLOKHD8djK/FeIAv1cJn4/6RuCo/?=
 =?us-ascii?Q?oToC2DbAlOqnfC7gzpVb/biL+uPmgpK55HB690M6xrP362P9sSfj8bT2SQJ5?=
 =?us-ascii?Q?Y2zEgMYbrgzEB+7gPpTkJUwuQbm4gS9vmfqHK5QVBcFJmzZfE9xU/Kp4PHj4?=
 =?us-ascii?Q?rSjXH9ZxK1njHHW5Or3/66iYBSBAFnb520dQw/pxupMs/DzJunDN9LCYqLVY?=
 =?us-ascii?Q?RjtJaEBEPbH7acb5AIzj09b6IkgFDwIJk4422zsO4klXky7u6hxE3idVXdUG?=
 =?us-ascii?Q?XYSJZiFzRQCq2thRHzIkCnIM6jpV/XgCoJq3rWaQFezO3Xqa2T8aOESWVvKT?=
 =?us-ascii?Q?qiMNby51pInSakaBRzOdmTEEi6GVktIvrFix9nNksreq5PIe06V9pmuiarnQ?=
 =?us-ascii?Q?ixSgCmR1m2+1GJsYoelGz9Aku5vuvRn/U+smNGovC8SSBnv4L4w4woMrLpwQ?=
 =?us-ascii?Q?FmkY/qTAzSml2OFTtlMkZxbPMuN/Z97nVCj2YjnoeU8t80xJ+XRoXmStyuGg?=
 =?us-ascii?Q?jrAtOf8A4LQmwjZoq1zJPUFy8L1NmCmTqUDqFoUJEwhrGZDhW8tP/IYosMH9?=
 =?us-ascii?Q?4mFJc2bj0I4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoBwRcCU4U/mPb1a9V+0fegGkGuZbCXDNK8MYXh0exA4BPKsX5aDlJpNR7uo?=
 =?us-ascii?Q?k/ko72QQav7HiqCjtluRLT202eNL2JuzqdRWsrdFYNLPXbyhkZcFPVCp8doP?=
 =?us-ascii?Q?lAdD68mb653H/Nv4A7nUzHKHq90UEaNuc+eBheLbKAmwskNC6OQk7ORBt5RK?=
 =?us-ascii?Q?6Zyd6vfiXqheIQIdwiEHwFPHVhCp/iOnDNQfvatrHheyCN6KnhkM5yMm6R7P?=
 =?us-ascii?Q?gWeq+SQ8CtUXv5VTg5FEMt2CAlnIpT36ZvpXfnVJmO0/SxRRTvpNNdWcPcD5?=
 =?us-ascii?Q?7vWvqbE5AVzbgiSpC8pcDrZ7xcO20ebjpz/F/C8+MJE/87nnDbqEApfPp+C7?=
 =?us-ascii?Q?tcuvzOAPwK9awgVnnJqpfPQABQ3ED7rHqeJFEYJTdmx23a02Zvio3nmx1Oho?=
 =?us-ascii?Q?iWi+sOIL1kgESe4S3hpovgIsbx+1A+BF4X7rNQW8Z3sOVNcPKEh5rSkOgfzL?=
 =?us-ascii?Q?OYbPVAUszmbNj3FmMNN3BByJmqj78LfhJNYJGVvAuJFnDGwj+M7HyJGtfE+O?=
 =?us-ascii?Q?Af46PaNmMrMUgMXI0f7qVTHgUrM62B4B4m/A3c5dxQlnMq9T2El0zTw0Vhnk?=
 =?us-ascii?Q?fPJazpTyLVNEvVjhh4PiuHFcOTKAC/3kn3Zp6bqBk6R22NlmpWSgiQokqcl2?=
 =?us-ascii?Q?24XFtKEBGfidRnH2xJ5Rn57DQUSuv4OrBvDVn82H8z0xyohkEHIV1NW7buLi?=
 =?us-ascii?Q?ACqB0+rhHivACxSvTQENX68RrRfcmjshXqg8MBmQZWcPzaB3w6mQmixkgzpK?=
 =?us-ascii?Q?j2VlrTISV/B1X4s5mKxYbTLntJhbuzg1Wc4LZXM13qa0O9mmdNOUMn5Sg9ZP?=
 =?us-ascii?Q?+sCT4vZvuJmFvrOctEI7aG15ah9SQPf/yq+8Ef93jpWsQlDV0P4nCs69ZfQg?=
 =?us-ascii?Q?A0amedyh3WyPbJl9H/NQtu3Saz0mpo6jcrz9AWjc+qAS86J+7NEZSrqQPjeo?=
 =?us-ascii?Q?yeTknShNa4JEE5KjRU4aOCHglXkeom+3gcOdwHiZauCaXkjy34gUcFFQmhLb?=
 =?us-ascii?Q?YhMRufBg05OJJqrdBBBjPGZz1aR7+/E2qwI3OHiqhaWN2iMEsigt67g09qMB?=
 =?us-ascii?Q?YjrUnDlLmwQQQuoP6bkzchv0jcEDwNCH0OwcJPGeZFZ+mwGLVU97cvNHQ8F4?=
 =?us-ascii?Q?KAWLH6pmZOqJpRU8l2jp3kKbG7gCc4m52+kBjmkNZ/0/QgOjF7sqZqXTlyXD?=
 =?us-ascii?Q?U/28uqJGZ01ou6cDQ9LIYN0BlAWNrBcN1Ck9D5nd5iJIGYI33zx4MDmR760M?=
 =?us-ascii?Q?OZyf2YhitUKZajjFp736wBgD76Pe9BN0GLCulDvGiUzYcTcMyf6xv20OZi8t?=
 =?us-ascii?Q?WXZU559Q4G39NN1yZgdbNLzsBrcLs0Di9fhRqAVC06FAKuvbVorZVp4eOcf2?=
 =?us-ascii?Q?bKG+L9aR6s45521Z93oYTuEpHmsGdev6CD51Dq5CcJKVWsrNSO5Tz1hliHpq?=
 =?us-ascii?Q?BfNNbZe7b5Jo/JjnN0HAm9RCbCm8fH5GgvTisybR1z4BbPaxKw/49jkpKc53?=
 =?us-ascii?Q?vBEHW954vHpKow1aGwfNIqcxDw+MX0UTvSCaosfxHgY3wmIy/nDcIwv++bOK?=
 =?us-ascii?Q?cjp4X2jN7oY+ENszkOTiOQAyQwPiRr0VPqQa/VhzdbqSrCjmOtZhYE2WCHuc?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5d5300-7b08-49bb-1b92-08dd884b0e02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 00:56:49.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKYZmjFzTTL8WX+5gWML71JJsYstqnKGsZyWMKFzHndjX5+UrOH0QOcz5IAdojpfQZEMhwT7/X82h2LgjsfjtiurYIHs9PQipzcjGkb/b1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

Arnd Bergmann wrote:
> On Wed, Apr 30, 2025, at 04:46, Dan Williams wrote:
> > While there is an existing mitigation to simulate and redirect access to
> > the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
> > Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
> > area, and returns a zeroed buffer.  However, it turns out the kernel
> > fails to enforce the same via mmap(2), and a direct mapping is
> > established. This is a hole, and unfortunately userspace has learned to
> > exploit it [2].
> 
> As far as I can tell, this was a deliberate design choice in
> commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads"),
> which did not try to forbid it completely but mainly avoids triggering
> the hardened usercopy check.

I would say not a "design choice", but rather a known leftover hole that
nobody has had the initiative to close since 2022.

https://lore.kernel.org/all/202204071526.37364B5E3@keescook/

> > The simplest option for now is arrange for /dev/mem to always behave as
> > if lockdown is enabled for confidential guests. Require confidential
> > guest userspace to jettison legacy dependencies on /dev/mem similar to
> > how other legacy mechanisms are jettisoned for confidential operation.
> > Recall that modern methods for BIOS data access are available like
> > /sys/firmware/dmi/tables.
> 
> Restricting /dev/mem further is a good idea, but it would be nice
> if that could be done without adding yet another special case.
> 
> An even more radical approach would be to just disallow CONFIG_DEVMEM
> for any configuration that includes ARCH_HAS_CC_PLATFORM, but that
> may go a little too far.

Right, for example the policy could go as far as to always require
generic LOCKDOWN_KERNEL for confidential guests, but a distro likely
wants to be able to build confidential guests and bare metal host
kernels from the same kernel config. At a minimum it seems difficult to
get away from a runtime "is_confidential_guest()" check.

The other observation is that generic LOCKDOWN_KERNEL is about
protecting against root being able to compromise platform integrity
where confidential computing is full trust within the TEE, including
root to run amok, and no trust outside that.

> The existing rules that I can see are:
> 
> - readl/write is only allowed on actual (lowmem) RAM, not
>   on MMIO registers, enforced by valid_phys_addr_range()
> - with STRICT_DEVMEM, read/write is disallowed on both
>   RAM and MMIO
> - an an exception, x86 additionally allows read/write on the
>   low 1MB MMIO region and 32-bit PCI MMIO BAR space, with
>   a custom xlate_dev_mem_ptr() that calls either memremap()
>   or ioremap() on the physical address.
> - as another exception from that, the low 1MB on x86 behaves
>   like /dev/zero for memory pages when STRICT_DEVMEM
>   is set, and ignores conflicting drivers for MMIO registers
> - The PowerPC sys_rtas syscall has another exception in
>   order to ignore the STRICT_DEVMEM and write to a portion
>   of kernel memory to talk to firmware
> - on the mmap() side, x86 has another special to allow
>   mapping RAM in the first 1MB despite STRICT_DEVMEM
> 
> How about changing x86 to work more like the others and
> removing the special cases for the first 1MB and for the
> 32-bit PCI BAR space? If Xorg, and dmidecode are able to
> do this differently, maybe the hacks can just go away, or
> be guarded by a Kconfig option that is mutually exclusive
> with ARCH_HAS_CC_PLATFORM?

I see the 1MB MMIO special-case in x86::devmem_is_allowed(), but where
is the 32-bit PCI BAR space workaround? Just to make sure I am not
missing a detail here.

Note, this devmem exclusion effort previously went through a phase of
always returning "0" (no access) from x86::devmem_is_allowed() [1]. The
rationale for hacking the special case into open_port() was to maintain
ABI consistency with LOCKDOWN_KERNEL. Right now x86 userspace expects
either LOCKDOWN_KERNEL semantics, or read(2) returns zero and mmap(2) is
unrestricted. If devmem_is_allowed() always says "no" then userspace is
introduced to a new failure mode.

I am open to rip the band-aid off and see what happens, but Robustness
Principle suggested mimicking semantics that LOCKDOWN_KERNEL has already
socialized.

[1]: http://lore.kernel.org/67f8a1a15cc29_7205294d7@dwillia2-xfh.jf.intel.com.notmuch

> > @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct 
> > file *filp)
> >  	if (rc)
> >  		return rc;
> > 
> > +	/*
> > +	 * Enforce encrypted mapping consistency and avoid unaccepted
> > +	 * memory conflicts, "lockdown" /dev/mem for confidential
> > +	 * guests.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> > +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +		return -EPERM;
> > +
> 
> The description only talks about /dev/mem, but it looks like this
> blocks /dev/port as well. Blocking /dev/port may also be a good
> idea, but I don't see why that would be conditional on
> CC_ATTR_GUEST_MEM_ENCRYPT.

That is more a side effect of wanting to mimic the
security_locked_down(LOCKDOWN_DEV_MEM) behavior. That hook implies all
of /dev/{mem,kmem,port} follow the same policy.

> When CONFIG_DEVMEM=y and CONFIG_STRICT_DEVMEM=n, doesn't this still
> have the same problem for CC guests?

It does, but that's the point. The CC guests that need the exclusion
have "select STRICT_DEVMEM", and *maybe* some CC guest arch could
tolerate raw devmem access.

However, that is unlikely. The observations here and from Greg point to
security_locked_down() should be providing the answer here. Which
completes the full circle back towards Nikolay's original proposal of
allowing lockdown policy to handle a bitmap of options [2].

Nikolay, part of me is glad to have done the full exploration of the
problem space here. I learned something. At the same time it is humbling
to realize I could have saved everyone's time just supporting your
effort. Please pick up your lockdown bitmap proposal and consider this
thread a long-winded Reviewed-by.

[2]: http://lore.kernel.org/20250321102422.640271-1-nik.borisov@suse.com

BTW, you can avoid the IO_STRICT_DEVMEM complexity by including
LOCKDOWN_PCI_ACCESS in the list of LOCKDOWN bits that CC guests always
enable. If someone wants to enable confidential userspace PCI drivers
they can do the work to switch from LOCKDOWN_PCI_ACCESS to
IO_STRICT_DEVMEM.

