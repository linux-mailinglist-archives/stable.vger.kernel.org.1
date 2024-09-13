Return-Path: <stable+bounces-76078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53748978051
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF02841CC
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586DD1DA303;
	Fri, 13 Sep 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZla+smd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68131DA2F8
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231494; cv=fail; b=dSy1puW312afJq4CObIKnXqvJYGs6vN/EauHmKFwzWSC5N5rODl3qj5dPU+90iZ82ZdCosLQqLCYQdQP7Tps6YOPheO+vGlGEdsiNlPoSBVXhqpHwoAKsiaa5cLlykYhxeWwJhrOpbtwWtMutpdWJerR/1LBrsUfl0BXz93ifU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231494; c=relaxed/simple;
	bh=p4WE3YMNCcPvUtKDB97iDuyFivDZPUWp0krr5ybDkGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RG2eM1uPB/BDh+83VNs9HfhxokvfaTf2akjD2aKOlwmgN9q06VtNvQ7lJ9B/I31QCHGIz1DWUy3VjDbQ4l3qw9A6izWxyO87rTp4/AMsRyv6xgkwujWf1kBfnrJrtPC92c1pCQfnfEl1e05G89krE2jNCXfDv0fYmMXrCL8ZdVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZla+smd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726231493; x=1757767493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p4WE3YMNCcPvUtKDB97iDuyFivDZPUWp0krr5ybDkGk=;
  b=fZla+smdrlEZP5WDxgyUyaBR7Loy1aXd4ggs2hSgBFVa/IEWQBUEGkGZ
   ku7RbqNVD2cgwl5fkM1Cvuo52X99o784124dmY7skk+7zHxd1P6siWMdz
   5wP4EL6zx+uUJsxjR3kXJql+VA0qrxHTOFiDiKCD3qJ/dJvy6GRCcn2VS
   Za12t9aFZ//w6ztY8vsPRrl+AZg2GeM/w9/3OazZRkH4NuU9oqjy55+hf
   ytPvTGM7pTo6gmrP450MeOBsSWDRhAj0w+266WPk6T08lrHF/0iSSkpUj
   KZUKmoExH8cLWC4BtNmUZpahVTpl/CD5N8eSTgAyzDztN3xYDbHEDGvNe
   Q==;
X-CSE-ConnectionGUID: rc331rNiT/CIW/1PMJMS6g==
X-CSE-MsgGUID: LlryXj0LReaq+ZXg5szm+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25281466"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25281466"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:44:51 -0700
X-CSE-ConnectionGUID: 8DFZXEMjRC20C/kvJOJMjQ==
X-CSE-MsgGUID: U+pF0woZQyexB9IVTZOeag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68133969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:44:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:44:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvTgIDObUuLxS418OHCr5CtlB+kA9tFp4p6YE/cK2muJpfQvCzB4lXVc+V9TcXPFlNaLNTgEuJ6Xf6bajbNAaJOWYNcAuWn1GIZ1z4wOPv3BQtk+zvzQWoyOYOAF71vGPeOGVQD7p52HOJKYnHKIE4/prmVb92XH7ybcDPeUWsWNxVawavwjUMivS6DfVy8tjdaxIFl5fyvBjbOmz/jkGb3Y9WQj6Uwz+n6HpOv3I6QVYPa482mdtTrihhThs71RxGbYxVj1io4SAVglMMJzm9uHT29WyA9UYRuklkXTnjvtPIV7TjMg3kqbumrMSyy4ia4FQVcf7BJCvs4piBlVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoBbEaTQEuxrVF3CzfFlmHwlUd4w9Eqd60ZfUMrFQ20=;
 b=l94HMx13jgq4UIAxcyGypy+J3SPxvjldRSIiGI9EUalTRyIXZ7pp3aoxB1OP6i52p3pwvqR1HxKI+/fMkjhSKO64LtYT45R+UjslaKmhPF3IM5xyWq2VnslHEkfjUQQV2GL1nxc3L7Qtok4P/euVuQYxhLNR5W/EmKjKbFE9dVK9ybx6vAz4XL8R9NsMRpzqprwOd1se9oQF3klfgKXbncIMQP6DJzmMQD8ETpIKfKq2DO6VQgqPIGPR07hJR5e7EXcDrPT1TNb6L3GXO+/0TpWb79NKWvYjry3YxI5Qj7OdKKRTrT30f80McpHZ0nZTDk4QC3PBo8GxrlQUeFAE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 12:44:46 +0000
Received: from MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::c4d8:5a0b:cf67:99c5]) by MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::c4d8:5a0b:cf67:99c5%4]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 12:44:46 +0000
Message-ID: <f846082f-fa71-4658-aff3-ec0a4ba8be69@intel.com>
Date: Fri, 13 Sep 2024 18:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/vram: fix ccs offset calculation
To: Andi Shyti <andi.shyti@kernel.org>, Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Akshata Jahagirdar
	<akshata.jahagirdar@intel.com>, Shuicheng Lin <shuicheng.lin@intel.com>,
	"Matt Roper" <matthew.d.roper@intel.com>, <stable@vger.kernel.org>
References: <20240913120023.310565-2-matthew.auld@intel.com>
 <bcgfdjrp5jvkckdgsqpr26bnvkduvxnw7eliudh47uli6jerxl@frgpwy66hsdq>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <bcgfdjrp5jvkckdgsqpr26bnvkduvxnw7eliudh47uli6jerxl@frgpwy66hsdq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::31) To MW4PR11MB7056.namprd11.prod.outlook.com
 (2603:10b6:303:21a::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7056:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce8ea55-fa77-4f8c-e477-08dcd3f1d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk1ZZEpqcGY4UWx0NzE3V241dmtteXFXOVVzTSs3b0M3eFZ2N29WMzFkUUh5?=
 =?utf-8?B?UDhuY0c0dkFlbU4zaWJpcU9nRjQ0LzRNNjh2YjNQZzdkcUtoZnhmSUN3WDZW?=
 =?utf-8?B?SDkzemZDSFRIZVB3UU90Vy85b3h1d1lUeldQaEdQcFFoYTB2L3h1RzJCdU1n?=
 =?utf-8?B?MHRtaWR4OSs1TlFoNFl6dUhtQ25rVk9FdUZrQ0FYNWZqMFRWZE1wMmRxNVhF?=
 =?utf-8?B?enQ0ckcyZW9qTDlPeDRaWEhqQWpMOFNnZ2cvWVNrdXFXRTIzL3V5U2cyTWYr?=
 =?utf-8?B?ZTU5SVpKcVlQY3ZvTmVOcEhlN2ZIOHpEWlFKNm1taE1sU0MwNG9SdTRHMmZG?=
 =?utf-8?B?UzJ3UlBaSkhia1FKVXlVN3RvcFV0ZDBlNkhtOGs2UDloMnNhUjM0dWx2WW5x?=
 =?utf-8?B?MVFDb3FZWW8rTXNEL21WemdNZW5CSEh4MjlXNlNNN1hNTXkrSEFnL2lCK0dy?=
 =?utf-8?B?UTc2aWxRVWVrM29CSzcvWWp6MTg1NWdHcGJEVFdWM0JYSHh3MFFCTUlTZFU2?=
 =?utf-8?B?cFBDYm80bFNsTVVON1ZVWlNkZ1NGbko3emJmQytBdzFNMHhESHUxYUNiVVFh?=
 =?utf-8?B?RDhvcmJNay81QVdXanFrczQyM2dNYlRJdWRsVkQ1TGZSaUpFT2NpeWVSdFpJ?=
 =?utf-8?B?aTRoMUJXVVFycUNoMStoNXVWZThZc09QODBPMWdzU1JjNVJwZUdvVVNWRTRq?=
 =?utf-8?B?MGJ6aVRUbWtKZjVpN2VrRGRVdUdleFFlalFvN0I1cDRFbFJkNHlZeHlYSm05?=
 =?utf-8?B?L3NxNkcxMnJZdGFuNWt1dG4reTduRGVaSlpvc1JXL1RWWHY0Y1AvTGhHR1kz?=
 =?utf-8?B?Vm00ak9oS29YT1J1RlhhVHBleUFPb0JlL1JwaHdiVjhGYTZjMDR3VU9QWU5z?=
 =?utf-8?B?YnVFbUdmbjAzNDdBcC9scVFCb3EzMXpydlVhWk5CS3FONmVaZW5IeWNzRGQ1?=
 =?utf-8?B?WTFSMVNWWXpmdmFHK0pYbUcrSTdkMjlVNU9XdEFLcHN4YjFndHRVWVBHdlBo?=
 =?utf-8?B?Ri83SUhxUGlSbG5Dc3JCU2o3NVVJTmpjN0Z0SW1pNU1vZXNvWGJqbTRPU1RD?=
 =?utf-8?B?S0ZXYld4RndCck0xbWsyK2dNMWJMbUx4QjR0TUhsTlhvcG9pWEZ5R3NzaWJi?=
 =?utf-8?B?aWdBOWRBRFlIVlZuZ1EzZFNnQ1YwMTVoZ21TMS8vc3ZBK1VCM0k5b2VJbmpu?=
 =?utf-8?B?NEgyUSs2Q1owQXhWUlhycXdOZGlQdThZdlhDNzdTcVEzbUt3VjVnYTNFWmlL?=
 =?utf-8?B?Njd0M2lpSFBBMytqMzNQWVJGQlFzZGdSVkhMOGkxekxjejBiZGZYN1JJT2FQ?=
 =?utf-8?B?eVRHTkhqc0U0aDlLd3hkMDAxakEzcU9oSktpWklUZ3FIRWJTOCtkanU4Ritx?=
 =?utf-8?B?SHZSUEsyWEU5MjN1TGZFU1dWWWxZanVvZFFIWWNGdE0wbDVKN0lrNFY0YUdO?=
 =?utf-8?B?NitIZTFrbjRQMFpSQ1M3ZmFHRUdKUEFnSTJEcVdWdHpHVFJDV3ljbEJETFRh?=
 =?utf-8?B?L09kR2kveGJ4ZEtIZWhWZlZ1K0hpeWVtMlV1aE9LL0tVZU9aZUZ4K1k3emgr?=
 =?utf-8?B?Y3dVQUFNaDZLV0hTYWJiSWprQm9Dcm9ZdHhIZDQ5OUFlWUpTelpyTjV6TUIv?=
 =?utf-8?B?dE92RFFBU0t0R3BPamVKTEhDZlliK1EyYmo3WU1WRDUyU0lvdUFzdlQzTVFG?=
 =?utf-8?B?QzZEaGJLR1cwZlNVSVArRVI2VEVzTGRuL1p1MFZEb1NoeGtQN0pmTDNNcFdR?=
 =?utf-8?B?YnlsL2NRejI4UHROOUNtaURIY1VaRE02MGhRT0JpMCt1UXpEU1ZNMk5YaDNi?=
 =?utf-8?B?ejk4WkFwSFR5UG53aEhydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZGQlBzZkZLTEhISXlML3J2UWY4ZFYrc0s5TEgxcGJCSkt2dDFjVWxtZXFR?=
 =?utf-8?B?SEJ1OVNOZVoxSm5YbjdNSW5YYk9ua0k5d2I2NWdzdFp1Uy90VFlDdU1FVnlN?=
 =?utf-8?B?Z2IrZEQrMERyL0xhZUFHSVoxVWZJVnVwdWpkL1FyV2g0MlZxdVpIcElNSEo4?=
 =?utf-8?B?YlhINWQvQ21XVmV6TlIwY2tMWUVLZWN5SlN5cVlkRGhsdkdoZVhQSzBodnE4?=
 =?utf-8?B?S001QTZoUGpCRXRRTk1aS0xxOEQxdlI3WSt5RlMwN2V5OEpvWktLOGNac1Jt?=
 =?utf-8?B?bDEzNkF0eVlJUnB4NmxJWDdmUEhWUFEyZUdDamlNSTlHTFd1RU5qUEpjTU1Z?=
 =?utf-8?B?ZThiNlhYMjN4RUhDa1YwQWZlMnl2OVNHV1U2QzNNNW90SXMrZHVUeEVBWGNS?=
 =?utf-8?B?QlcrVzdBOVI4ZldWTFF6WmlIQUo4VVQ4ZVpjZ29oZnErbE1ZY1d3VXpBOGNy?=
 =?utf-8?B?bG9vdCtudVU2bm0veDQzQUFPa1VTOTJaRVREeWhSd1JBVDd3QzkwaGljcmNx?=
 =?utf-8?B?aHJiM3Y1NjZ6cllOUTRpVzhTZUwrSWNGcitJc0REem9SQlB3K3N4RFRxdGN4?=
 =?utf-8?B?QVNKejNMd1VhY0xlUVBFdk5sU0tvaks4cysxak9NUmhkM0liUzd5YnBPanI0?=
 =?utf-8?B?VVBQRzBNWng2NnhtaVpORTE5anJ0ZkdGUW1jYlN5SHJSNDVOQUxldUxUVW9j?=
 =?utf-8?B?bVZUNXJmYXRKdFdQQ2NGQjBjTVkzUVpTa3hZQ2tOYkNQd1BXU0F5cUNocVJ3?=
 =?utf-8?B?MGJZclRlaGNUYWJlcXdLeFAwNXJpZnhDWk14bWtDc1NuT1VwN292WENFWkJV?=
 =?utf-8?B?WXA3WWltWlNMWDJPL1lSNzZTRUxnS04yYVB0d1gvaFg5QWQyYmxpTFBRU1hZ?=
 =?utf-8?B?TXM5SUtuNkpvMmlnaWdTWkZqYUtFMlJ2aDk3aWdHT2VsaXRETVZwdTA5UE8w?=
 =?utf-8?B?N2F4VXJ4OWhpZGZsc3grSDEwZlBqTkRmRFVRM3g5UVlmbEFBVHpLVXJmZDU3?=
 =?utf-8?B?aUdRNEVpVzlYNStRV2FaZk5xT2ZJSGtUMmRWNWp6NUpRdTJLVXo2YVhOT21F?=
 =?utf-8?B?RFdXM21kQXlEcjBvdXR0RE1aRU1wUExVV2ZrZG5SKzFleE90eWtEQllnNTJx?=
 =?utf-8?B?WnhpQURrTEZXUlJrc3R4eU9mZllmenorQUlRRjB4RDFVT041Y3MvSHJhSEJr?=
 =?utf-8?B?c2hSdFBnTjdINk80UEI2WGNJSTRNd0NDMHRyVmhKeGpvT3UyUmpBRW9hWGpx?=
 =?utf-8?B?emRWdlp1azBndExscHJGeW9CK0ZhVmYxOGJIUnY2amR3c3M0aStGTW91bG95?=
 =?utf-8?B?bGF4SlpBMWNzK2d2VXJlNTBFL28vZVh5YkY2eVgyeldpQ2pGaHdmSG9WYVlq?=
 =?utf-8?B?TlRjWnE4T0kxSFM0S2tZU3ZGK29zOHJxYytPRkZuWnIvZktqZDRkYVcrR0pK?=
 =?utf-8?B?R3c5anU0T3NxblkxTTZRT2JUS3hHYXFCRWxFWVV1aVBpVklTdHBEall6UzBB?=
 =?utf-8?B?dkRka1VLdjlaUnRsVVhGS2dDa2NKMk1iN0Y3QjYyMDBvTTNMbUxaWStNRUFT?=
 =?utf-8?B?bUliV2RObDB4VG5IbnJHc0ZSS1FnQ0hJbUgwS0xuSHdzRnFPc29Jd1drczVQ?=
 =?utf-8?B?bmJaeDY3RlVFeXY0WUhRNllzYUs4Ky9POTlZUVJjOGRrV0hrMVowejArVEM1?=
 =?utf-8?B?ZlkxWnc5MVJyYmJMaUVqTWVuRm1VREtGSk01d3ZpT1VybncwN2RhRjhQU1Fu?=
 =?utf-8?B?RlJUS1pkaVhPUnhndzFxZlNBZ0c0OHM3ckFZZ0RCY0ZnYU5NalFLT0x3Y24z?=
 =?utf-8?B?ek1CemE1ek9VY0ZhNUl6MnR3ZzAyVmJUQ0pLWXVGRjFqREJScUxlN1JBejF1?=
 =?utf-8?B?eUJKVjZRbDFnZTR1VFI2V3ZLSGFmQVlzWm5CN1dMbXk4Y29VdW9lSFFSWWRR?=
 =?utf-8?B?ejhsL2NZc3FnOElPVFI4bi9YaWRja2JUWVYrLzIrV2RIc3U5S0ZXOSsvV0o1?=
 =?utf-8?B?TEUzZTU1d2xCUzZ0RStSZXE0bkdQNEcyRE9FdEhTMzVoanorZmZucW1VUkFG?=
 =?utf-8?B?Ujk2ZHMvMkh4WlpCcUwveFNWbmZlRkdpMnlha05UU3h6QU1kSE9LeEZDUWgx?=
 =?utf-8?B?UjEyQUcxSUtaQkRWdFRHWWhXQm01YUR0ZkdiZmx2L1ZUYVlEbVo1dnd0L2VX?=
 =?utf-8?Q?wgVmPONRSmPHpVT6TNBkkD4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce8ea55-fa77-4f8c-e477-08dcd3f1d8c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:44:46.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G90DX6wr2tFDxMhwTbhEGrO+x00ceQ12GodJqdG8NmzfA+jM58Eybz0ugC8IqDMVDU4wvGMVhRADEESgrtzCjEKZ40B3BQINwc7pMRdGgOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com



On 13-09-2024 18:05, Andi Shyti wrote:
> Hi Matt,
> 
> On Fri, Sep 13, 2024 at 01:00:24PM GMT, Matthew Auld wrote:
>> Spec says SW is expected to round up to the nearest 128K, if not already
>> aligned for the CC unit view of CCS. We are seeing the assert sometimes
>> pop on BMG to tell us that there is a hole between GSM and CCS, as well
>> as popping other asserts with having a vram size with strange alignment,
>> which is likely caused by misaligned offset here.
>>
>> BSpec: 68023
>> Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
>> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.10+
>> ---
> 
> and... what is the difference between v1 and v2? :-)
> 
> Andi
> 
>>   drivers/gpu/drm/xe/xe_vram.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
>> index 7e765b1499b1..8e65cb4cc477 100644
>> --- a/drivers/gpu/drm/xe/xe_vram.c
>> +++ b/drivers/gpu/drm/xe/xe_vram.c
>> @@ -181,6 +181,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
>>   
>>   		offset = offset_hi << 32; /* HW view bits 39:32 */
>>   		offset |= offset_lo << 6; /* HW view bits 31:6 */
>> +		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */

LGTM
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

>>   		offset *= num_enabled; /* convert to SW view */
>>   
>>   		/* We don't expect any holes */
>> -- 
>> 2.46.0
>>

