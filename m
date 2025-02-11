Return-Path: <stable+bounces-114865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E4A30686
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8C7A1F07
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD61F12EF;
	Tue, 11 Feb 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyMPg78K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B781F12EE;
	Tue, 11 Feb 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264321; cv=fail; b=FXCce9KfdTd6E7qroIu6mZImuAP776/zCCyZX90C5SEU+WqYO8fAmTOFA81+7hflZIslZ08WNGIzqPr4iUhK2WF0zCxvflZNQCvo6tQl0tLi+7OITSgeRLAOc++wB5VY/UVLDoTGARXA9tG0mBnA1UDPWeXNS9GidmoZGjrWeOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264321; c=relaxed/simple;
	bh=Gyo9o2zhbZtev+solEYqg60hHdBcfKD2GNE/wn+N/OQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZBuxUuVQaQ7KOZqq5N5slir2/FCXDf5tfffyrLoexz9d5C5RJ/o/lm86F2xgom1wObjgCj6wgKFZU+n2fwqR1xbJQOtb0zipVQNsoN2u6E0jeGcC8tnMPFMzEVujCo653Ow05GHbnQHEMSimV+WwZysvioYKDILtUu5BFdBz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyMPg78K; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739264319; x=1770800319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gyo9o2zhbZtev+solEYqg60hHdBcfKD2GNE/wn+N/OQ=;
  b=UyMPg78Kgz4fc7XlRGpSPFxbaV3xmDHqXAv76V73Q9KPFCet3A7fzK7C
   IUlKi2CocIzJp8XktYW4azm7hJ3VL5y9iitC6CnlBi08e2wN5znVbti0C
   Ei+xSf7opbOqL/CzrkfEbjafLmqaQaJSEa05oL4sMyltprBsvPX+TlM8h
   2M+OLfFrJClI/F4myYVOamje/bBhm8vLAFFsQC6b9aMYAAppFWysiWVwh
   +pI7gZSr8GmX4NSoVd3t1l5j4FpGqhqgju0SdbhtBD5L4gs7GoDUhqW69
   Z2PkH1ZT1RL4ixhRrxqx0JDjVLiwwnvOQ+nJN5FhB61ljwv/gMHZweJ4n
   A==;
X-CSE-ConnectionGUID: jWIHzmTRS5K7h0//3IaJig==
X-CSE-MsgGUID: X9i5f/jeQtWXL31mncUW4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39892874"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39892874"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 00:57:43 -0800
X-CSE-ConnectionGUID: oUCRIuoVTl+Osj1jxR8BWA==
X-CSE-MsgGUID: hX5aBvM3QNibIQbkgA0EAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="117531310"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 00:57:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 00:57:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 00:57:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 00:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbSH3UDjvgETtoWNw1Puzx6E+8AH0PW0kqHEM7Zm6NvH9pJjdtzUUag43o1Dd5UO2s4LWwLUX+q3omRGs543hAfsrrQFV+oAitSS03hntVy4yU3TbFL3ToQ6D8eeAQKD9QND0KD7jbgbY83Arg9QreuiTzzCbZVCdIyH1GgX6XGsMJZuomGiQrBup7jhWXnPqxwLvsIAVR4QoVdWN+F3O8pyyhGADGaGZpGBDjjOXFTJ0cX3BJRtunvQcapq59418yVbs2C/8IWurNIX/wm+mqfqonT2Bok789p2xV5Vd0x33Rf9j3l7amEBFEAWqu6w7S4y3gHjioLzU8icAH1RFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwIZgg+Rcda48+ypgcqV9M/FOESdwLtnu/339jU5xxE=;
 b=SBXWA65/Nfhtqyv8cQoa3N4iavYGD1ea5nQLoEuBZkzLU2MbwTJ5DpYgHvOQaa131Xa3RTancF8e+szPHy0lGeD6NR8N9eDXQYo/OP1FC5G3wHHRS+xzqswe6pA68Ijq7wH7fX6kHbteaXjSaQxFZErN9XxwXSo9ax3NGJuLsDnVkv+VFGGVDaGtAx/DnX/2teovEMi8bsPhDghNWXKxqfscf7X5FwQo/+L5gbGeMIoHODDlFE8/8kT0Y1zE7xYdDm0BhBDnwp0QPAhnKP8MZjgVpUI5rpJYK+6O5KwJfntW72JZ2To2OT+zTK2sgg40z5QXUoiknUQZZLTgMy9/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 08:57:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:57:38 +0000
Message-ID: <e181b834-025f-4b2d-a13f-cdde2c74e710@intel.com>
Date: Tue, 11 Feb 2025 17:02:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq()
 cover faults for RID
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250121023150.815972-1-baolu.lu@linux.intel.com>
 <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
 <941d401c-c009-4dcf-bb93-00c25490dd38@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <941d401c-c009-4dcf-bb93-00c25490dd38@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0061.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 619a101e-d346-4774-7ecf-08dd4a7a2299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0doQ0NUVTRrdFJEUHVGR2g1WVdsQ2djN2k0ZXg5b3Q2SVdjVFFpOXhVdHhu?=
 =?utf-8?B?UU1qRS9UVjRJMWt0RTNFVlpsUjB0SlFYSG50NVBjWmY3dzFoNEtJK2hNeWJk?=
 =?utf-8?B?eC8relRVT3BheCtHUVBPSjA0V0ZSSWNSWWREMWlDclRxelcvRzl2NHR1K0I0?=
 =?utf-8?B?dGliRTNiQ2FHUGUyTFo4bmhsZXNSdkF1VzBFU21JOUR6SFd3UDczMGk1dkpU?=
 =?utf-8?B?dDVzZEpaVDRvaGVSTlpYdUN3Z2wwckh5d2xoUUNrRTR5WXVSazlGdVh1VEo5?=
 =?utf-8?B?bTVJZzJucnN0SW1nQ1VuR01CTlF4VGdvTW9haUR0b3lBN0svSENMei8wa3ZP?=
 =?utf-8?B?RDkzTmhaTWdiUHY4WFNBUXNGSzZjZUwvWGpFZy9tTGNNRDBWRW5ORHhUM0JI?=
 =?utf-8?B?YTZ4S2R6UXVLM2xGNTByVG4rck9HRFRTUXRhZXFUZkM4V2RYT2JWQmIxdy9j?=
 =?utf-8?B?MVQ3eElESUJTTlQzZ2g5bmpjeSs0MWpXV3RtSXZodlN2TGprT2ZQOU8wbkR0?=
 =?utf-8?B?K2FKcEZYakkxZnp6TmJGUjNZU0pJSDYyNER2ay9GTFpjQjlFZENPRGN6dHJ2?=
 =?utf-8?B?MkZvSkNzNnlaNGJ6UUlFQlVKclg4YTRjZW5ZbWY4Ri9lOU1VN1NPL3F1dHI3?=
 =?utf-8?B?TWxGWnJnY2kwU3dEa1NNamFvbXlwdFFKdnIyZWdIdTBuMWtnU0Q5VUwxZ1U0?=
 =?utf-8?B?OVI1SDhsYVNybXM0YTNlVXNxL1BNbVlvMlg0R1Y3SlpMK3NaSjByU2tIQk1U?=
 =?utf-8?B?M2V4Uml5QkluQUQ4TXFKcFo4bXFmbWRwNkFVZDB4OWQ4UFNZSFd5Sk1oODZC?=
 =?utf-8?B?ZlI0cy9qNlV6NzlLSm05NU94N014MnprdUVzbDU2ekNucHBHY25MdGFKT0NW?=
 =?utf-8?B?eUFmcC92cXRhb3RXaGtER0hFSDZDMlR5OFY4Mjc0YWkxTWRaYXh4TWt1SWxL?=
 =?utf-8?B?dng1WlNxYlppbU9DTVp6c0NHWXZ3dkxJV1JYaERKK0V5YzAzYUhlbVhFdi8w?=
 =?utf-8?B?YmhrTkRJajJJRWVZWm82UUxTV0d6dEhNcGhWTnN3clkrd2pvbWd0UUxaTjRW?=
 =?utf-8?B?Y2UrR0VqOTRDbXlZWTBoK2U1WmtvdzlYVGpVTjZyQm9VdGE4Wkk2WXR2dkc1?=
 =?utf-8?B?T0pJQy9JS2l0OUwvSlBLSkphUi9TMXNnRzUxT2dLNzgxWmJJREE2dUEyUVJ1?=
 =?utf-8?B?ZG9oZDJERElDdlEraXJwNHY1aDJHWGRqMG5lSDhQNENmME5SUERBU1F3VkZt?=
 =?utf-8?B?NEdYMDA5d2JibHpNQ2JOdzBqVkhsMCtIWHFrMUtjUjE3dmQyV1pHWEVJWUJG?=
 =?utf-8?B?M2ZUL0RheWdKdE16WkpIQnExV0pVdjg5V2FSVUFKeGUvc0tHL1N2OFZxL01Y?=
 =?utf-8?B?NEl4cU1vMW5yMjgzQ2pjdlIvTjEvczJXakkxVDRTV01Hem5ObncvRWdsSDBl?=
 =?utf-8?B?UW0rZ0xQOWorUTEzSUpVZVl2bThoais5SHdkcHRhUDlSQ2lteHhoZXFpdHBz?=
 =?utf-8?B?L2Uvb1BjdVF4QXYzdk81b3crdDhON0luMklnK3gwbzdPb2pPWVMvSXZIWTV6?=
 =?utf-8?B?dzgxZUV0REkvVmUvNC9WS05ESUI4WWQzcXdSbU5WS1M0dVh3ZVoyMDJSS28v?=
 =?utf-8?B?OW5SY1JyYXJpQ3NsSktKUG9vWlV3RWFocHp5cmtLanBRaTR0RjhaZVMrakY4?=
 =?utf-8?B?NGJUOTRTVTFRSGZjZS9iUkNJKzZtUEYrbnJtcjcxUDRjbXM4T2UzZGZzcHpi?=
 =?utf-8?B?K0hGMVdxV1l0Y3VUcDBWbHoyTXgzM3F6UVJDZFVXQ0NpSlFyR1U5eXRRRm5s?=
 =?utf-8?B?NFUyR3NDSk5icDl4Skg3WjJMdlBlLzZCUDJ4Q0doL1lBbTUxQ092REx6RUNh?=
 =?utf-8?Q?7r6J+80aiLkAh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXVWcHBucTNlbzNHN1hjak55MktmOG5tdlNIRzdJYmVGQVQyNEhPWndtTllX?=
 =?utf-8?B?ZjNNdGFTbUV4T0VOcjdKUFJtN29kbVdoaHhvYjlma1VCb2NyMjBuNmdMc3dK?=
 =?utf-8?B?alFUMkNGSzJQeE9tajFHZVlVZWRObFJKNm9nSHIxcGk2ejRUNS9la3BrSUNu?=
 =?utf-8?B?NnZ1VzFNR1BXTzQ4U3FTS2xBZGZzeEV1V1hXUFkyKzhEWGhENEtRNXVIZDI0?=
 =?utf-8?B?RTdmcnh5N3RtNXIwVDRHc2w4RHBKcHczNFRxeHlqL21tNmxhR0ptSEpaclQ2?=
 =?utf-8?B?c1MzRDRJMmFRd3RCckNvYlVWU0R0ZzhmU29Oek1jdk5zZkIxWTBXRVc3UVFK?=
 =?utf-8?B?bWhBeGpBOEdIOUFUaWswejlHa3hlVkk5RU1hZ2lsVXJmcUVoTFQ1eGp1N1pl?=
 =?utf-8?B?N2JXeXY4aDBJTWpsL1psVytRc25GUzhuTW9wZEk3RGJXUDNHS0Rtd0crL2p6?=
 =?utf-8?B?MDBnMmw2VFlnS3VjbTc0bnFzQWdidUpuMlB4cVVadWg1NW5BZlRLT29zTllT?=
 =?utf-8?B?MWN5VWFFeXJ1c2luVVpCS2FhUGx0b0trWmZuU3BQZFRwYnRuOUNFQnR4b1dw?=
 =?utf-8?B?WTI0SWdSYzYrV2ZFSGNPamVRVVdCTCtocWZQYUlJdTBqME9CNXFmZE92MkVa?=
 =?utf-8?B?TzNHT3ZkaDNRWUV5QVdMREt4ZkY3b1ZIZXBiU1BlN3JtT3dQRm5JSnJ6N2dM?=
 =?utf-8?B?a0xkeGVxUzdFSDRZWXVQTGgrRHhZeVMxUklCRElDOFh4UVg0S1R2QU5FVWEr?=
 =?utf-8?B?d09WYTlFZ3hlM3k3N2VSZUdnQmdYdnRtay84Q0NCeEsvOGl2VWFyU1J4UjRZ?=
 =?utf-8?B?TUVKRHI1bDY5MnNEcHFTSVBuWnF0ZDdPRjRZSkdRdWlnUFVqOVluZmJtSk9J?=
 =?utf-8?B?bFFlbG5XSXQ3UWc5QnJEcjJ6YjcrUk9TTDg5UUdTK0Q1aTU2a1F2QTRMdUk0?=
 =?utf-8?B?NjVZbHE3cHpvUlJwOVgzMEd0UnIxYnNCVUIvTWVTTU54aU0vN21VelhEMXBV?=
 =?utf-8?B?c2VMVENFak5jQ2tRa3lQenRiV3I2K3d5RlJ6TnBOdlV1bEJia3RrVWh2Q3BB?=
 =?utf-8?B?SGExRkZod3ZNVGsxS3c5NlpkdzBEUm9CaklBaGhHYVVJSzdFVWZybmtnMjlW?=
 =?utf-8?B?T01UOHpJbUhzOGk3TS9xSFV3d3pRQkRnaXpjS29BUUgybmVsUUk0OWl6SFhq?=
 =?utf-8?B?Z0VuMTMwQnpvZ3VTNmRNOEl4T0RXakliV0R6V29Yd3ROVDhXbW9scEhzMDdM?=
 =?utf-8?B?TU1Fc2NUWmkxZVB1dWVlL0c5d0Qyby9zMFlMcWtIeDloSTNZeWFRUTlqWUp6?=
 =?utf-8?B?Y2hzWFV5RzZxcWpHSlRGbnh4YnluOVpJS1RDcmxkSm44YUFqWkJNSGJBbnQy?=
 =?utf-8?B?YU05ckU0TG1IZGExaFp6a1BCZDVXN29UOUpBM3ZFazZLdHFVTjV3RTlsU09w?=
 =?utf-8?B?Z3lydVhYdVI3c1I4SXlBN1llWUdRMnZiNFdGV3ZiNmZubjJXQTQ2OTU1UzRY?=
 =?utf-8?B?Rm1LNTA3czFSQ0pBYTMwdUUySE9yVDU4NmJRYllTa2tVeFlOamtBOGkrd29w?=
 =?utf-8?B?c3djb1U5aS9oZ3lDTzk1K3hmREoyRDlydE1yY1cyamZBaVZVNnJzWkxEbEVC?=
 =?utf-8?B?R1lkWDJ6QStWVTREejByOXlLN3ByQXVLWk1ZUUZIQ0FXWWpsRGM4Vk1RRWgz?=
 =?utf-8?B?dm1vWHFIbWlrNkowMDJ5RHZ1eTkxbWdqNHRlRUJ2Q0NNSFdjMkczbWMrRXF0?=
 =?utf-8?B?OU1qRzJzdHNNUEpUSnF5TTV4RWhMZHNNcFk5clNDanJ6VVVtT0YrSVhja0R1?=
 =?utf-8?B?bjM0OTVGOEFLM1dNTE80blM3bjNBY3hDaU1OYWY4ZzJNZExUVHREcHVWNGhV?=
 =?utf-8?B?YUF2aUVBUlNjcDdLRGh0TFVQYyswbmRFMWU2ZklVSTcxa3d1aGlMZzVxYnkr?=
 =?utf-8?B?cVlaM3U3bDlkd2ZSazIxTE5veUg4QWFLRDBEcnltOWV6amFhczRHVGJXUHk0?=
 =?utf-8?B?dGtJRUtUWW4wUXZPT1JLWGhlOWliTTViRmVuWE14V05TUnNmcDc3YkNKT25U?=
 =?utf-8?B?ZFpHbzlxc3hFY253Qkk3SEQ5QnNKbDdVcVk2eDRkejJMcXp1VEs1ZUFsRG0v?=
 =?utf-8?Q?spzlfPxi0GK/4cd7Zo+IWuZ41?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 619a101e-d346-4774-7ecf-08dd4a7a2299
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:57:38.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDw0ifcMrm61P7s7OVsbd9uDmPhUQ0Zi1E5ZZfWF6m7xeL8vnDtTp98S6sIVM50tIQxVKP/oX6+2NvKKbLMVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com

On 2025/2/5 10:28, Baolu Lu wrote:
> On 2025/1/21 15:01, Yi Liu wrote:
>> On 2025/1/21 10:31, Lu Baolu wrote:
>>> This driver supports page faults on PCI RID since commit <9f831c16c69e>
>>> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
>>> allowing the reporting of page faults with the pasid_present field cleared
>>> to the upper layer for further handling. The fundamental assumption here
>>> is that the detach or replace operations act as a fence for page faults.
>>> This implies that all pending page faults associated with a specific RID
>>> or PASID are flushed when a domain is detached or replaced from a device
>>> RID or PASID.
>>>
>>> However, the intel_iommu_drain_pasid_prq() helper does not correctly
>>> handle faults for RID. This leads to faults potentially remaining pending
>>> in the iommu hardware queue even after the domain is detached, thereby
>>> violating the aforementioned assumption.
>>>
>>> Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
>>> for RID.
>>>
>>> Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in 
>>> prq_event_thread")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> ---
>>>   drivers/iommu/intel/prq.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Change log:
>>> v2:
>>>   - Add check on page faults targeting RID.
>>>
>>> v1: https://lore.kernel.org/linux-iommu/20250120080144.810455-1- 
>>> baolu.lu@linux.intel.com/
>>>
>>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>>> index c2d792db52c3..064194399b38 100644
>>> --- a/drivers/iommu/intel/prq.c
>>> +++ b/drivers/iommu/intel/prq.c
>>> @@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, 
>>> u32 pasid)
>>>           struct page_req_dsc *req;
>>>           req = &iommu->prq[head / sizeof(*req)];
>>> -        if (!req->pasid_present || req->pasid != pasid) {
>>> +        if (req->rid != sid ||
>>
>> Does intel-iommu driver managed pasid per-bdf? or global? If the prior one,
>> the rid check is needed even in the old time that does not PRIs in the RID
>> path.
> 
> Do you mean that this fix should be back ported farther than the fix tag
> commit?

correct.

> The iommu driver doesn't manage the PASID. IOMMUFD and SVA do actually.
> The SVA uses global PASID. IOMMUFD doesn't yet support PASIDs, pending
> the merging of your patches. Therefore, per-BDF PASID management is not
> currently implemented in the Linux tree. Anything I overlooked?

then, it's fine. No need to backport it I suppose.

-- 
Regards,
Yi Liu

