Return-Path: <stable+bounces-133194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E411A91F4A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2151898577
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABB24EA8F;
	Thu, 17 Apr 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BB1Q2cSQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FF1624DC
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899397; cv=fail; b=o3DN6kZT6NuqeAghsiEmRLvAm8OQ6l+IiFKtzVwa4Jlfjaghn2OTdoJEaGPLnqCxBkqplyyVkLNMdZXcI9T7o6vHvg3FmSvGMtgO+xYD3ElspVfRrJRc9HoswmDc4wwk3xtXn3VxNqUXVgiXkFN1H5E++4ZGS1MFyLB9jQNmJWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899397; c=relaxed/simple;
	bh=+350ffdM7k9yU1cKinkG1p3Tvzr8rlElaUTknpYgXRg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/q3u4Oalibg/r2chyBDVCmWPqNCkYlmC6gox02xT3b1dlOFaX3tfXMBSdo75O8BdUwqtYMEKpwMgsIgV/lxC/VE2y30va3P1YWwdGuDcF6+8XgYz5TH4znXXD7y86E27Cy3Ut2pH4gmKaiPQwxUGFIxGG3PnIh+hQ/unwNeNjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BB1Q2cSQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744899394; x=1776435394;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+350ffdM7k9yU1cKinkG1p3Tvzr8rlElaUTknpYgXRg=;
  b=BB1Q2cSQJw6/P8B54qsa10WUgHnnktJtL8serDogKRZOKJfrcRaZz3ox
   mj9sw/q3dD/FIGX4BBxIW5we+9h7uj2LjzEI9vIS3IMXtLOqVV0LMm4EB
   duqNkzAf7fGGmgoAlj3V8P14RJkRyw6d5xWPSwdzoEB5VSMoWZ4HALjdS
   qeN9qkOxNyWH3sYJHgfcO16DNuMU/Ak2/+LmAqzznvHxoprtDh31xRmUL
   SBhm73u8WBO4az6L7dUN+RrQxKIbVFCxSs1YxiLgacvHC+9Q3twaUUWq1
   Cwyz0bvxGlncnDkwlDXd0VT/MNKwsF4mFX0MUa4Ng6I1ABNgHRlJTu6io
   g==;
X-CSE-ConnectionGUID: 0WVnzKYsTL2biFbKGkBq7g==
X-CSE-MsgGUID: 3x5ZDmflQkSR6lafk8EQPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57132572"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57132572"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:16:12 -0700
X-CSE-ConnectionGUID: kiEG5jZBQbSeCM+5prTbSA==
X-CSE-MsgGUID: 1CSd1nk/QfGK/90YqE1O4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161868126"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:16:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 07:16:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 07:16:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 07:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2dUEJBHkCQp0eEEqortC0ZsDHkVEAO9A8uk/ZjOyD4WLQhj74sMg6gIxS1RX84tHV9U3knrUp7MxdcF3hVkO2qxcJ21EKqyzNaenQhnS8J4CTkyx0X1NuaSb2h04AuE5dzCY5XHbgrrmThsDibdj+cQoG2X9/hxyImCAAfJwgD6KT0crnFEGTpur7ef18cTPb+ovBFanTJ04qr1UFI+niXMzlviMIwrXiggx3bvcBvWnSipopZzgXIg2ePo8XLM51iwV4AKCmNljZkUnrD9CTZ4DIilrOKXbOVhatRBo7FSMg3R5nKyIqgKnJ1+hb1yGj3YTd9VDXy2pwQ+S6fS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Eyuwbn8iKHjCc/JoraLxeyBlekMKRJwrUbtaZEafuk=;
 b=PpaNvm1x+MrIYbN0SAjnD6SzEM06nYuWlfTewTRdyDKDGk9jU96F0tnjiDKnD835gPKB5hNlUGK0Z4/9xKJ68QtC6Ke4IrcwL5o12MwAAUngjjBhd2ZX3+cQtCJqKsBSBJrmNQj+kSy2zfXHUF6nDz3FWNHHpNIN6yxfdZI9Z/86OEkkrMntxwYChSRf+Uz+erCD7FCLe38hCutJRAt9YLH5utQwbjF8KlkCR90v0xqjru46VXt8w+HTIuLqCax/SGAdgVXpJPhmzUooPYYqE3EVPZ/aTMKVuJD5YXFYDBBU5Wga7dcEbZ9xQDBaNE7ga2/I8tF4STimo8nWb5FECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 14:15:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 14:15:54 +0000
Message-ID: <3389628d-27ee-45c8-a11f-217ae1743a69@intel.com>
Date: Thu, 17 Apr 2025 22:21:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iommufd: Fail replace if device has not
 been attached" failed to apply to 6.14-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <stable@vger.kernel.org>
References: <2025041759-knee-unearned-530e@gregkh>
 <9160a4eb-fc69-4a0b-8bd9-5b9d5f4f5bc7@intel.com>
 <2025041711-handwash-sleep-09d0@gregkh>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2025041711-handwash-sleep-09d0@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4e13c1-1c1a-4a63-3606-08dd7dba5d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmZ6S21IWUJWbmpJVVN3VktsWXBVWkkrSUltMUtEVVdvMFpxNWRvTThIUWFP?=
 =?utf-8?B?OVhuRkM5MTgwcWdWMVljdGRDckU1RGZ2alZmT3hRSWYvRzAveUNqbWpIT1Ur?=
 =?utf-8?B?VXREeDI0NXdVSHVnb0tVdVpWZ3IvelkwM0hETmZSdERJYjdqRmtybmhxbEFi?=
 =?utf-8?B?eFNDbEFMZGEvelk2RHN5aStvN213aXpRM1NlZzVhR0VmaVFHc3pELzRrTURv?=
 =?utf-8?B?NnRhSnphTnVRWGl0VngzcmdRSm5RdG9GdWNocTRwMmROaFY1a0ZEK0tHMFJa?=
 =?utf-8?B?SlIxUkI4SURVZUM5VklBSDVJenFoVWUzbHBNNmE3SzJxYVhjNDdLbmdlbWF5?=
 =?utf-8?B?Q2JuKzVUWCt4SGhnUTJFeWxtRmsxWmRWTy94UTZ0cTc0QnNlOCtyRzdBK1ZZ?=
 =?utf-8?B?cm1BTmpVUGdvSTU1cTYzanFrZFBhM1dwMS9wRXo2TFVDNlRHbGtyQ1krSGNy?=
 =?utf-8?B?NjdHRGpFYzFoNDVGTW1FOWZsMTc0ejFGN2lnbHpsUGk0TlBscFpqcmkrQmho?=
 =?utf-8?B?bHVDMU1JY01ha2xrNW9qejVPM1ptY05Bckh3MzFwL2N6OGUxcldubXU2NXN5?=
 =?utf-8?B?SUMwQStOeldBRm9zVVZHRncwcWVmMDJ6T2xsSHRXWFlMWlhRZVlVcXJPTkJE?=
 =?utf-8?B?TVEzYWdKR2gzOFpua3Uzd3REQzBhVzJ4VnFwVTh4UlVZdktwUU9jemc1VEVB?=
 =?utf-8?B?QkU2bGt6azVFZmtSL2hTZDhEVHh4YXN5UENGc2Nzd3VwMy9rdlUvcWFOWmo1?=
 =?utf-8?B?Vk0ySXlJMFV6aDVsWXFTZXRjNEV0K0pqMlNLVzc5UEYzWm1KRWFQVHl3L0xu?=
 =?utf-8?B?amorUmxwVDY1U3ZJS2o1WG5adnR4Vk85MmNySnNHWU5ya0tEUHdIbGpMeHRy?=
 =?utf-8?B?a1diNVpDSE1QRUNJcEovS1crZE80YnJZMGxnUUl2STd2cm40QVFOcTZqbFNj?=
 =?utf-8?B?SHVDNGppdlk2SlIwdEVCckNDeUl2dXRFUDg5dmhBZktiQ1djZ1kwbmlKQ2hn?=
 =?utf-8?B?WUVVcDBod01JNlV5dlpkYTJ2TUY1MVlUeG9lalJnYnhrMHpYY0IvR0R4a2Vq?=
 =?utf-8?B?THNEK0NJb2ZKdDBXaTU0YXd0dGF5MXcwMXFCZk1OYVZJNDM5MlVXZHo3QVdt?=
 =?utf-8?B?cXc4dnc5VUVFV1dzVjgyVkdSMExDbGdiajBwTUk1RWdTNEhmUGhjbFNRZWNv?=
 =?utf-8?B?OXllOUpNUU4vTWdhUXorQVp2ZVhKNnZRTU8rQzNvRU9uSHJIR2JkMTl4UjVo?=
 =?utf-8?B?WXhMcW9OOUlzczRSSEV1dEdGYjNDTXNxdFprUXMvYTFvRTVvTlpMQ3R6dzNq?=
 =?utf-8?B?OGwyL2tOZmZyclgrYXZwUTloNU41bk9tK25CVVJudnpkWDhneTZxYmcvbllH?=
 =?utf-8?B?R2NIbjVwd29sUWZnNmE4UXZ5RmJzdE05RjJyQjJuU3A2cnNMNytPR1o1Sjdu?=
 =?utf-8?B?cXNhbVF3Q1lFT1VmcHB2alFxSGRhd2ZBUW5PajM3Z25GTFhma1pZTlp5bU1P?=
 =?utf-8?B?V1V2WTk5ZmI4ZGJPQm5DcTc0U2V6L1RMVldGVjhqaVlrT282dm95WmFuT0J1?=
 =?utf-8?B?ZFhJVUhCcTdWNWxDdE4rb0c0WDR2a29VaUVENW84cTY5czdTR054NnV4Skxw?=
 =?utf-8?B?R28zbTc2UG5KSHlLWllpR0JwYWxYNXhINGhLaUhqbnBzSXNGc3FzQVBPYTFS?=
 =?utf-8?B?N0U0ZThRTEhBbVRNaEdiNUxiM1VwR1NZeDR2RFR6aUNwT3ZKZUJwU20wbEN0?=
 =?utf-8?B?VjBUaTdENDljaUkvZmRIMDFYbzV2QmJQM3cyYzd5ajJ2MTRNdmlZbUtyK2xp?=
 =?utf-8?B?bEJCMzA4L1NIb3IvalRFQlJtR2owT2lXRThqcVlZRWZlaDZKV0kyYlNlbm1S?=
 =?utf-8?Q?7S/qzPDldD1YK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1OZElrVHJqTEdQN0FYdGdSaXFiYmF2dC9Jc2R4V3JLd2NUblhFWmtxTHZK?=
 =?utf-8?B?cjVRMGRnVE8vVUhUeHZFaVB0eHNXbW1XV09vK1BKYWlMcFB1OWNEKzhGeXJO?=
 =?utf-8?B?L0diOVBxSTlKS3JqRGtYYWkvdEdWYStVOXF3VlVESmFJMzZwSWNpVytpZ2hL?=
 =?utf-8?B?MDF0M3dyQkRiSE5URE81WXZxak1EWkdkNzFFV091NExFTGVSM2ZQYTN3REVu?=
 =?utf-8?B?eXJlZ0MrVXNmRWFvUzRhMkZvcGNFdVNUaXovVkRFVWdzcjl0VkRqOFgwT05U?=
 =?utf-8?B?djNLWHdMcWJKbDNybTMyR1lLcFFUSmJHWWJuZHVlc1o1TjY2ZFFJTy92ZnFC?=
 =?utf-8?B?eXBEWUZ5MmlCYksxRVF1OVZza2lqOGRQL3NtZWxhNlUzUEE1UjNVQ2syU1N2?=
 =?utf-8?B?K01iR3YyUEsvR3JKb2JpWk92SEkxTi9RbzdabDFxSHYrVmwrSU1vOE02bTA0?=
 =?utf-8?B?L2MvM0s3MEtZTzV0bFVsaG93YUNWM2RHYnlDY3NLcmQxMjRiWEVoN2YxNVZs?=
 =?utf-8?B?UFJWZlBhOVlHMC8wSVRsUDRsTEUwMlVGSG4zVXNPRWpjMVEwbGlEc2E3U2FG?=
 =?utf-8?B?MGhMVEdIdmU2ZmhoSnFhQTM5N0c0NjhYaXova0dYOE5qblNwNDVyc3FzeU0v?=
 =?utf-8?B?MmhhWW9SME5YWGplOUxra29yTXpLQndwaTlUczJRbytFTk1JWWNsNGd1Wmx0?=
 =?utf-8?B?Q3I5dDFoUVk0enhNdGV3aEplK0pNbHJJbzBnTnZ0TEJ3TnhTNkwxeFNGNGM5?=
 =?utf-8?B?b05mQWNmeFpEK29Ma3VVR29GWjBmbVJDelRHUWppNWs4S2lmbTVwRXpudkNS?=
 =?utf-8?B?U2o4QlQyOXk3WDhQY0dTRVhJdjNjNEo1UTE3YVZIRTFHT2tRa1NPVnJkVXlx?=
 =?utf-8?B?REJ2NGh4dGxLaTQvdWNGYVlpK1RDaUZGOHNlOXl4Qy9UcFBMOERIRnJFdjJO?=
 =?utf-8?B?VTNJeXRJSk8xeDRtN01SMUd5Z2FHNFNEQXJsYkpkMkF3emZsWlIxNVRJSjhH?=
 =?utf-8?B?WnEzell3dEN2T3hvVWc4MDFMWGxJV3Z0RHdCZHQ1L3YvMmY2S0tEYU81dG9X?=
 =?utf-8?B?VVM0U3dlM294dHRnVWFZOHFBZTRjS3hwSDgyT3BNcnJVdzllT2dSTTk3NFJD?=
 =?utf-8?B?b2dXZGgvV0Exb04zUlJGR1p5TXZGTjYzQlRxNERibFgzbitHeUNick52cGIz?=
 =?utf-8?B?RUpxS0QyRjh0U2hleVNoaERRdkpkNlpLSG5FYmxqVWtmdkxrSUEwV0w0QkdN?=
 =?utf-8?B?SjRYMzA0dk9scXl4dXdNVEU0cmQ1ZGVFSC9QeFNxYW03RlhBdW5KbmlsYzUr?=
 =?utf-8?B?RWRDaVIwOUpsQzhpejk0Y0d0T2QzOHp0emRDK2hPN0RTempTQi8wZEZYS0Rk?=
 =?utf-8?B?LzZyWmJ0R1d5Y1p6L3V6ZTR2dnNNbi9Bd0JjQjZ6STh2UzdyQlpOZjFSREhH?=
 =?utf-8?B?NnA0TWp5N0RmVTM5bkpCcTVCUFhZRGJPaFZwWjA2MSs4NGlNb2tsMGhRRHAz?=
 =?utf-8?B?Vlp5TEtVa1hPQjlSMkJYN29sWGsvanlPTDVVTzl3RVdUS0kycFZqSFlrUXZB?=
 =?utf-8?B?akZhc002UVFwSW9XMlo5em9LejBROXdiVUd0Ky9waGRYYjRObFBnS3ZjS1Yy?=
 =?utf-8?B?bVNGMUR2NUxjUExrK2kzQWZ2cDNTOURjMTBzN3NGTDlaUTFmVm5ZQXRpYnMw?=
 =?utf-8?B?V2J6Ty9NZ0R6RTFjWnY5bHJRenZ6OFlWM3l0UWZKYkRBMm1pTTVOS3o4L2Jx?=
 =?utf-8?B?SUIrWTN2ei9naW5RUG5pMzYxYXVBUlB1Uzc1ZEx6a2N0MFdxd1N1RFdaSkJo?=
 =?utf-8?B?MzlITW9qcXZHNnNCbytvcGZ6cjN0L1pNMHVxVXM0QlhsM0g5Qy95REZEVjBt?=
 =?utf-8?B?a3VpRGVhclZRZG9LR1NHU05uWThRUFhPQzg4dkpXd1Y2QkdrZDFwdHBFS1Fi?=
 =?utf-8?B?T2UyeEtkNFVqTXR1aW9PUm5PTTErdGtRakZRL2plNHByTHNpNzIrSDhJRnRa?=
 =?utf-8?B?aHVseWlvMmxtV2FNbDhYUVV3UXplVHlmRXo0eVMyQ1A3MndMNUVnSHhLNkNu?=
 =?utf-8?B?eTg1TmRHd2hKWWIzbElBTTZZZmNFN1d4T0R2V3AybTAxTFp5VStjTEFTZUQ5?=
 =?utf-8?Q?QsvMWXNgax/IZAgHIrCoWypAU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4e13c1-1c1a-4a63-3606-08dd7dba5d30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:15:54.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzQNccXTDpvwSJsg3bYIAiB+lUlDwkeFJec/Q2eDmTP+8IqPxH/BQt+OCi880fs9U13l9903V/outQgXg7Qz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com

On 2025/4/17 22:12, Greg KH wrote:
> On Thu, Apr 17, 2025 at 08:52:16PM +0800, Yi Liu wrote:
>> On 2025/4/17 19:42, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.14-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-knee-unearned-530e@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
>>>
>>> Possible dependencies:
>>
>> I think the possible dependency is the below commit. This patch adds a
>> helper before iommufd_hwpt_attach_device() which is added by below commit.
>>
>> commit fb21b1568adaa76af7a8c853f37c60fba8b28661
>> Author: Nicolin Chen <nicolinc@nvidia.com>
>> Date:   Mon Feb 3 21:00:54 2025 -0800
>>
>>      iommufd: Make attach_handle generic than fault specific
>>
>>      "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
>>      used by IOPF/PRI use cases. Now, both the MSI and PASID series require to
>>      reuse the attach_handle for non-fault cases.
>>
>>      Add a set of new attach/detach/replace helpers that does the attach_handle
>>      allocation/releasing/replacement in the common path and also handles those
>>      fault specific routines such as iopf enabling/disabling and auto response.
>>
>>      This covers both non-fault and fault cases in a clean way, replacing those
>>      inline helpers in the header. The following patch will clean up those old
>>      helpers in the fault.c file.
>>
>>      Link: https://patch.msgid.link/r/32687df01c02291d89986a9fca897bbbe2b10987.1738645017.git.nicolinc@nvidia.com
>>      Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>      Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index dfd0898fb6c1..0786290b4056 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct
>> iommufd_device *idev,
>>          return 0;
>>   }
>>
>> +/* The device attach/detach/replace helpers for attach_handle */
>> +
>> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>> +                                     struct iommufd_device *idev)
>> +{
>> +       struct iommufd_attach_handle *handle;
>> +       int rc;
>> +
>> +       lockdep_assert_held(&idev->igroup->lock);
>>
>>
>> @Greg, anything I need to do here?
> 
> That should be it, thanks!
> 


you are welcome. For 6.6, it might be difficult to apply all dependencies.
I've posted a patch based on 6.6. Please let me know if it is not preferred.

-- 
Regards,
Yi Liu

