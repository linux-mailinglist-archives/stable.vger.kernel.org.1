Return-Path: <stable+bounces-142789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202DAAF3AE
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BE61C20C14
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743212153EF;
	Thu,  8 May 2025 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9cecayI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3D1CB31D;
	Thu,  8 May 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685591; cv=fail; b=m0tmGggGa9y8BMPlbM2sq02OgFW9MqWUsS7R+QaYvNqmG2Qm25z0FLWvhjpJUCxvGo1xl6wsJ+AGZ7mnA3nPG0NGcg19kxa2f0SO+FGgxzAWJW1C88NLM9QY5OQMiUOoLl1hkcWgnGLzM5ca5E+S21kOtNaV/QMVsxkFLpcuEew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685591; c=relaxed/simple;
	bh=4ZjBFUdE3fpYxVGCgU2QaFeWz4ramPnZaZdogjop9I0=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=BDqmr13OfV8+myzIDeA6ed4IXVtsGuweEAbPAZoL1xuS7l0EuTqCma7Aez9bP/Pfb9IeT4NcVoBAsaJIzHKGGT5/P2h/h1sbTyFvNfZmJxgoFHV1qxam4cx/2Ui91AOqIbJfooduXzCpxzOps0NDOtEeLA3DLEoj1ho3IUOp28k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9cecayI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746685589; x=1778221589;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ZjBFUdE3fpYxVGCgU2QaFeWz4ramPnZaZdogjop9I0=;
  b=X9cecayIl/fUBFEVWxZnBBtQXPLp+PJ7P4Mnw5aVreN9xkaAB8ozRfWi
   hzELbGQL7J0QzjG11P3bbAHn9cnoXYapSgzha3HsoAvPtS7TcS7IbrY71
   gA2zcaN+mxJID76c9C8w7ZjXVx7knG9uOZ3VjubDalNfkUg+LsvaWAXz1
   0Bzau2xLSQ/UvGgmH+umH4ATATduVCNShIKEPh+QlwMcDNEyLwRn5MzTA
   Au3P9vB71bQ3tKQzwDG27wa71E4dU/O9OdCeaJ3HU1LOaoVGCrW64gsTA
   jpJsGQw/xiePKLHuTi5v7fQF0dJCPJgzeSrhijJZWRI4bKPFUXBU+I+Xi
   A==;
X-CSE-ConnectionGUID: wesDRZssTYydxpSJIuw2gw==
X-CSE-MsgGUID: fdT/jdIbSSOA4nhRphp1oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48532822"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48532822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:26:29 -0700
X-CSE-ConnectionGUID: oOVNtRo8TcqRXXW/Yp5QxA==
X-CSE-MsgGUID: B0vxoQVpRZ2oVq/hxqweHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141153131"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:26:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 23:26:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 23:26:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 23:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh5pk1NW2SZJrRXyA5VwEZYH96FiCrK/L+ZMQ2rnGKV5e4oA/u8VsrVJGTrnW2LfK2iELP/jfYGtHc7W7iIfts7QNsiUgpksgF5pqzLCEiNu9Gw7LL0x6Bn/uS6m/nOa34NB6gtyjLrLLcjVtsQMhqdeyGm50qbHemlXsYVo57HsOJzBFvVqqzrUjBj//LHsR939w0ccrvVIuHLIi7V113pTHaSBDeLlvT24AtsIZjfLeNJa5lczmeBHIWZOY2F7ZrrsSLQ3o7mH/DG/RP/QBm4+UHIDmhD3DdYQ8taLUY/31MtdBdCi4K/nTIsV1cksdD0j4q+fyUHfCqpQaFw95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmJDuv7pRJHKrFZ94xcl9qXb4YQFFU3VvjI7ue+id0U=;
 b=BLeUhhlYT2umjdaLCe1B+p4AN6jUmtqHdk68rD82wfsQdK7iktcqRXzhW3j7dnTK7NvHHA6Kap//h5OFztrVjlRY25qu6eoIz+DyuQwNo5Ssm9sIcTuV8iOlZwXK//aQ7ZV/N1jrzvTsF9CMtlMgJjw39VHrWuj9VRIhInUzBspMfU4+RWUqfbUjMMeR/0O/qOlnkusOmNzuyPGNXu7UPyuiZttD5OaKEXTjiU9oZlOvB0c4uiQq8oFKlIH0AgosP641Xi9aAulkidjOr/yS1Dnqi9UFZf/hk1LbXKEgj/rjlNnhkw5DcHsrcj1kNsmOABED6eud4F6ziq7FkLP2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Thu, 8 May
 2025 06:26:24 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.8699.019; Thu, 8 May 2025
 06:26:24 +0000
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on Meteor
 Lake - 6.14.2
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
	<marmarek@invisiblethingslab.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <regressions@lists.linux.dev>,
	<stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com> <Z_0GYR8jR-5NWZ9K@mail-itl>
 <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>
 <b5d72f51-3cd0-aeca-60af-41a20ad59cd5@intel.com> <Z_-l2q9ZhszFxiqA@mail-itl>
 <d37a7c9e-7b3f-afc2-b010-e9785f39a785@intel.com> <aAZF0JUKCF0UvfF6@mail-itl>
 <aAZH7fpaGf7hvX6T@mail-itl>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <e0034a96-e285-98c8-b526-fb167747aedc@intel.com>
Date: Thu, 8 May 2025 09:26:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <aAZH7fpaGf7hvX6T@mail-itl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 4295fcd5-acee-48ed-01a1-08dd8df94137
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzhHWG5oVFVlcmVraUMwY3hqeVdqQjdyY1RzZFp0MWwybVg3SjFlUWFmVnll?=
 =?utf-8?B?K08vRVEzejhDUlNIVCtzU25MMVp5RWhORDU5cnpvUlZmZDlFc0tMa3VsU3ZB?=
 =?utf-8?B?UndiNUh3N0dOeTRNZWtwWHovTTdVZXUxUkVDTGsvTERTUnA1Y0ZIWDVzdmdj?=
 =?utf-8?B?czhRbGtNR0FUcnlBWHBKQVZ4aVU4MElQSXZucmJqdVRoVWhib0l6K01BUFZM?=
 =?utf-8?B?ZWRCMHhZZjE2djVDNHdFWGJHeGNwaWYvR1lTNU5nZnF5U0FtR3pIdWtxVVcw?=
 =?utf-8?B?WkgzSlhEeHMvcndDK01nWVJCSHdPSGk1UmsxdTkycmxiZ3dyL2w3MDVram5l?=
 =?utf-8?B?NzREaDAzREJKazk0Wk45RFEwaGNXaU0vVFRCZGhDZ2xSVzUyeURHUXRuSzE2?=
 =?utf-8?B?L245TkxFbzFJQnRaeDAzbEFjL2xNTjcxVi9DeXhJRmt2cEJGWDlvQmIrQ09U?=
 =?utf-8?B?UTBlbUZDeStoRWUzdHJEU2V6ODNWeTJVQVZFMm9IcVVTd0hPUm42NUZGSjVI?=
 =?utf-8?B?VjdqdmhjT3N4bkttNktNVldtL3orZEpVNi80bjRQMDNUYzE0QXpGMnZnODFo?=
 =?utf-8?B?QjE5VTM3TzczdGtYcGF0b05WNjlUWEZaUEhVUklhdEF4MUtjZ2ZnbllZYnFl?=
 =?utf-8?B?bzUzbWU5OVFvbVJVOEcvemhYQ0pKcTRZTStpN2lpdWZGclhYUHZsWUtsUWND?=
 =?utf-8?B?MVhiL1ZJdzhlYkFkS3RxLysyQUl1QVlKcHpmdnpXdUF4ay9pMW5pRGVLekEv?=
 =?utf-8?B?Yk9NTXRTdTJocHpEMkI4cWY1RGlGME42VndwNEtuT2ZBT1hQSWVGeWpSbmYy?=
 =?utf-8?B?U3NtMFovTFNuM1JnMUMzcm5NejdMNGVHWndCOTYvOUp2Sklra0QvS21OUVFJ?=
 =?utf-8?B?Y0tXUlp1SHMvS3ptVFAxazhwY0NBUDJpSEoxbXBvaUNCcGxkYmxtU3YvWC9L?=
 =?utf-8?B?YkFaYUQ1ekpCRndudTdEdFM1LzA4eEpvVzByelBpbXZuK0Q2SHpPSjBKQStt?=
 =?utf-8?B?eEtLc0l6M2lYM0lWaGFsRFpxWFI0RWNPWFYvSjlYMWdJcXN5MzBFL2dwYTNJ?=
 =?utf-8?B?RWFVWW5HK040VWE0Rzc3blBrUy91dWpodUVUMTl6Z25ZalhEMFlqY1A1SEQy?=
 =?utf-8?B?TTd0NTFxK1BLQ1VsK29CR0RaNUszY2JQbVdxL0FmZ0FjUWVsTWlyZlZrYWpX?=
 =?utf-8?B?WmJyVkFleHVvYVFXaWVlOGJBNEdUZ1RUeFpQRjM5U2VENi9pUExYQ3BCZ2ZM?=
 =?utf-8?B?NVBTdVhldWYvanAvWDNjMmtGbDhlMHphL2s2aFNkTzJpN0N6ZnJtbEpDZldw?=
 =?utf-8?B?eFJ4cDZLd3RSdkxTbHNyR1l0cDZUeU9UQTc3Wlp3emw2VURMQyswcm1kSWhP?=
 =?utf-8?B?SzlKMXFoOXRldEJ3VTZ1bjhBQmg5V3M2SCt1cktqa1B6V2NISU1WOUlNRW9S?=
 =?utf-8?B?c21qVWg4SGRpY1h4c1VQQThVQ3hLS1dlSGc5OTExeWxQcEFDNmlQbjN5SllH?=
 =?utf-8?B?dFA5WkNpUFE1c1pkczliNnBlSGhpb3p6bm5CekdrekQwa0dUOEJkOE5TVnRC?=
 =?utf-8?B?bHl6ci9xQTRrU0lIcWxnN3hXRlZlTCsxSUF3OU8xZVNEK3lSVjVOZlROYkMv?=
 =?utf-8?B?dHRRcHpicVVXc1lVbUFVcm82UHAwejJ6NTRRdVR0czQwcXUwMUdENE5oYmha?=
 =?utf-8?B?TklSMjcwNkxzRUszbG9EeFFYdVpWSkJMVHJYNmxJclFDY2Y0dE9JR3lVTlp0?=
 =?utf-8?B?ZVpKMUJ3T2trbEZ0dnVxcXJhTDI0TkQ0ejMzb1ZaWHRKQWhqTXRueHBPUXhw?=
 =?utf-8?B?Z0U1UnRhWW1vRWFVeW5GTHIxdjlLMWxmWU16bHhRYmZ5MmhIak41WC9HUlBw?=
 =?utf-8?B?d0h0dnQwUWdXL25pdW5pQXZOZkZSY0lRcVd5eHdNcUtndWFxeFZlZkxUWXVH?=
 =?utf-8?Q?dDa4s91sAA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnltZ1hHb3A4RzN2NEtZN3A5NUVyMkNwTHIwZjJPUytqKzBGWkxPbHk3WlRI?=
 =?utf-8?B?ZXo1ZzZJZERjajVzbDdiSGFJd3l6U3dSVXk1alRVWXVEbUQrdUh1VUZVNXJC?=
 =?utf-8?B?T3RSWUQ1UktYTmdDckZUbnNiSHVzK1JPZEVXNExLU1B3MFZGaXNjNHQ3RS81?=
 =?utf-8?B?dHBTQThYMVlrM2ViekpNZVc3c0k2aTVzWmVBUFV0TFhNdkFZUHNrSkR2aGJ2?=
 =?utf-8?B?aDhIY0dOTDdkZ1lXelRRSXFHYWs4VWdEVUtuUTFxRmp0aGE5bVRvOHJ3QmZ1?=
 =?utf-8?B?MHY1QzlDOVJmV2lsK1NpR3M0QzZVcEdNaEh6cUdrM0VLSWhLRmVWVmk2aEhj?=
 =?utf-8?B?eVJzRk1DUC83eml1U1FoOUhUVkNFOUJmUGhUWTZPZ1ZIeStJZmxCUFVYdEhF?=
 =?utf-8?B?T3Z3MDhNUFY2aWJRdGdMblF6aWJ0RG5hYzBtaUZJUmcyNTNSRUZycWR1aDZI?=
 =?utf-8?B?SVNrOERRQkFaT3NsZ2tNemV0Y2twQ1NLTG1NMTQwd0doRXVac05uTVBtL3hw?=
 =?utf-8?B?bS93WURWWVNUVnNncVBpc2l1Q2hpajBXN2I2aFBVOEZKYS8wbnRsNW5DNnY2?=
 =?utf-8?B?K2VnZzc0MC9FR2lReWJnL2hPQ0FRYXJuRFhUcjRrM21vUVJxdVJ6bjloWGdS?=
 =?utf-8?B?VlBSbXN0N3p4SlpENWVqZGNtQTlsVUVuc0R1Tm5BTmNIZVlFUUUwRUhnNGxo?=
 =?utf-8?B?b1N0SVVPd2ZTREc3QURuTkJ2MGpJditPMTV2b2d1VkhYQlFCNTZhODMwbHF4?=
 =?utf-8?B?eklNUkJDdWcyVWNDMVNDVnI0SlFnbDRLK3JReERvNmZ4akM3R1I2VlV2SUFS?=
 =?utf-8?B?RldZRzA5YXU2L1Bvd0VlM1dWQkE1Vzl3VlRQb3BtUGluanF5ZE5rdklKUS91?=
 =?utf-8?B?dzBZKzZEL0RMSElROXFibURBaFFlWlg0Zmgyb3JEZmcyZEp5bFNIZVo4YmNq?=
 =?utf-8?B?Mlo4TTFEQkE3dDRiaS92M3JqUUUyZlV0aWJaNS9tYkpyNkM4ZTJJQ1FOMWhy?=
 =?utf-8?B?YW8wazJxc2MyandKY2tObitRdjZtOFAxdzBIbldhZlJaWXIvUXBsREluNm9l?=
 =?utf-8?B?aG9OUDRjVEo0M3d0ajhZd0picEw0T0c4UlZ0RmtRUG9XTVMwM04yRHJZZUtt?=
 =?utf-8?B?MTFiaFl2YXI1U0c5eGVKTWF2dWhrY3VENk1rQ0F6NkJwRmtFTlhWaFVWZnY3?=
 =?utf-8?B?eE9GaE5sZVpnT0xwRmZVL28ySkRraTBsYnIxZHJGYW0vWk1CYzFtdzhqYW5a?=
 =?utf-8?B?cVZUZUdNOUc4dHVOV1B6Y2JhQnVVM1hJV1hYRFQzand3UFRlbUtRZHJXWEhE?=
 =?utf-8?B?N0hyQlNwa0pLaU5zVE1KK0RBaGh3cGVRWUMyYzk2WkFjcHlXTWhxdVVDbGRR?=
 =?utf-8?B?V3haYVJJT0dIbWVnY2pDSmkzdk1SVzVQQWlJYjFQb3YrdzRVVTNnTnpJYWlP?=
 =?utf-8?B?VnF2VmpmcGdDSGVGSWZubTBZSS9MakNPbC9aR0I5d2hPZDRxWXhvMHRtVzRG?=
 =?utf-8?B?WE5HSDZ4cXBmVmJxVEFQenZaSVhpSkhZakIzV004OXpqZlpFdU9sZ2xtQ0Zi?=
 =?utf-8?B?MzFiaWIyTzJReVRqaVN3K0FKVHIxK2V6SXlsdzlOZUhFNWtiOFM0Vm5WUmYx?=
 =?utf-8?B?YS9JWXJjT0VIc3dNVFQwampqOVNtZFRrTk9LcnMvcm5ranllTTNmMFA3MEJu?=
 =?utf-8?B?MDNFTTVUMFBzMGZlM1BDUUhFcGVYdUVIU0lmL0JONENwRGxPbWdJMHZoQXoz?=
 =?utf-8?B?RlBKUmcrVFpKQ1FWZ0Zsam9VQTRDNWQ0RXlVdWxvR0x4ODFhSXlwTFVHUzR4?=
 =?utf-8?B?enN2dGYrckw2emwvTGtIemNzZVJXbHJLQ3F4b2tmR2djdDhDZkk3d3BVdHBq?=
 =?utf-8?B?TFk1OUxKQzI2c3hZRlpCL1FTZGE5M1hmVTRGWUZldkExVTEzL3hoaVBoeEJ3?=
 =?utf-8?B?M0h6Vk1DZUVyai9qUVkrL1dTME9PSTJaVk1LelU2U3JqZVhFUmNlcDMvMmNR?=
 =?utf-8?B?VEFRQVAxbXB3UTJmWjczZXZ6cDZVWSsvRy9DamVlSFg2NjFvOW9ia24zVFkx?=
 =?utf-8?B?UnRNY0liZTRPN3NrdDBzUjY4b3BINVgwaGtOSnVqM2RKMk1leHRXNFkwRU0z?=
 =?utf-8?B?SDFHUUozU0l6Y0xVcHZPWktBVE5aREdnRXVZYk5tYnI4RWZuUWwzRG5vQU8v?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295fcd5-acee-48ed-01a1-08dd8df94137
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 06:26:24.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSeDH+Zf8SwcEA2BDEeklI4eUYpJQmoP1l9ouqE0+5kSErET6BuRT+ynS2U9ENtaCX13U17gtG4C7ON+tanahLZTo7BgHZUhB6roNXEnmeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com



On 4/21/2025 4:28 PM, Marek Marczykowski-Górecki wrote:
> On Mon, Apr 21, 2025 at 03:19:12PM +0200, Marek Marczykowski-Górecki wrote:
>> On Mon, Apr 21, 2025 at 03:44:02PM +0300, Lifshits, Vitaly wrote:
>>>
>>>
>>> On 4/16/2025 3:43 PM, Marek Marczykowski-Górecki wrote:
>>>> On Wed, Apr 16, 2025 at 03:09:39PM +0300, Lifshits, Vitaly wrote:
>>>>> Can you please also share the output of ethtool -i? I would like to know the
>>>>> NVM version that you have on your device.
>>>>
>>>> driver: e1000e
>>>> version: 6.14.1+
>>>> firmware-version: 1.1-4
>>>> expansion-rom-version:
>>>> bus-info: 0000:00:1f.6
>>>> supports-statistics: yes
>>>> supports-test: yes
>>>> supports-eeprom-access: yes
>>>> supports-register-dump: yes
>>>> supports-priv-flags: yes
>>>>
>>>
>>> Your firmware version is not the latest, can you check with the board
>>> manufacturer if there is a BIOS update to your system?
>>
>> I can check, but still, it's a regression in the Linux driver - old
>> kernel did work perfectly well on this hw. Maybe new driver tries to use
>> some feature that is missing (or broken) in the old firmware?
> 
> A little bit of context: I'm maintaining the kernel package for a Qubes
> OS distribution. While I can try to update firmware on my test system, I
> have no influence on what hardware users will use this kernel, and
> which firmware version they will use (and whether all the vendors
> provide newer firmware at all). I cannot ship a kernel that is known
> to break network on some devices.
> 
>>> Also, you mentioned that on another system this issue doesn't reproduce, do
>>> they have the same firmware version?
>>
>> The other one has also 1.1-4 firmware. And I re-checked, e1000e from
>> 6.14.2 works fine there.
> 

Dear Marek,

Thank you for your detailed feedback and for providing the requested 
information.

We have conducted extensive testing of this patch across multiple 
systems and have not observed any packet loss issues. Upon comparing the 
mentioned setups, we noted that while the LAN controller is similar, the 
CPU differs. We believe that the issue may be related to transitions in 
the CPU's low power states.

Consequently, we kindly request that you disable the CPU low power state 
transitions in the S0 system state and verify if the issue persists. You 
can disable this in the kernel parameters on the command line with 
idle=poll. Please note that this command is intended for debugging 
purposes only, as it may result in higher power consumption.

Please inform us if disabling the CPU low power states resolves the 
issue or if further investigation is required. As previously mentioned, 
this patch is critical for the operation of Meteor Lake LAN devices, and 
therefore, we are unable to revert it.

Thank you for your cooperation.

