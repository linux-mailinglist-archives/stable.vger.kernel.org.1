Return-Path: <stable+bounces-78315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2698B38F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF91281190
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9382498;
	Tue,  1 Oct 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzGSlq1d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA66653
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760154; cv=fail; b=XKerCvOFARU1JOhLmNLOm1ABJgXH5Cs9SQ9mRuKt8YJWentvyjfIQCfwlrY2i5Tqkw6CZ5HRbCKyr7nKMTds1oV8VRePA4G0skDOtC+8vLk1a2/x9pPJzXjSeov/hu2EfI2sNI0rKkyPB+UZjZll7rhbjRTY5G77SO6BQRVc0vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760154; c=relaxed/simple;
	bh=ij0OLaCQKE619bcDTfkBRg2dlRgdukzs9O7e5l/62RI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oupl6lwimoxQTrm8rP2j+aMUOUvYMW8HNmb9ppKSbED++gITllpBvkTvNqiy4L/LSxaF/FmY+f4Sdlq6LubhjZF6HARvPlZTIp3YrsrOxozdVoBTICQZGnFTnqPgm52skngeTEV9vRP8QMsVWFR8K+rdlcVnvHGIasCRxXaHMVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzGSlq1d; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727760152; x=1759296152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ij0OLaCQKE619bcDTfkBRg2dlRgdukzs9O7e5l/62RI=;
  b=kzGSlq1deDSn7J+Xnrb/JOYghUXJfi68rm9fAnF6qH+bAy2JGy8Miq26
   UxY21td7T11GQ5KbpVnUFx49shm4TZdF1cP/9kSALg5Ho7H7PutIucK3S
   uIO2UGYXFgMO/xaFvEsLy/fkp6EGa7cRIZvxvGDzY9nqCzTJA7N9fxjs7
   tE/UTcRQQZrAlCdS/yg1fvaWw3Q/qHRAjgeuzW9fRQiRbrpRifwSoFJy2
   2o5EHydHHIiHUKYxqZEWYmI3Lh/BL7XEfPZTjD7gt2+nd7G6dRPXZFQ6m
   wQ0uBZdhCOb+J+Xyg8gPUGwe0EqLTSrsdfghCuQhHEdrZR5IE4CgpAlbi
   g==;
X-CSE-ConnectionGUID: a9MYFoHcREW6BANE+T3YfQ==
X-CSE-MsgGUID: GMufCY/eTXq5QWQAgnjKkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37458896"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37458896"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:22:31 -0700
X-CSE-ConnectionGUID: XFR2fJZtTlyWNpNX3gCavg==
X-CSE-MsgGUID: l7KAM+nlSgytVGV56v/BMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73443080"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 22:22:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 22:22:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 22:22:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 22:22:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 22:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiDJsOibSaiTABFpdmG5VffW944eknrs80JuCmIgS0u3PBHxYwQ+C2NIt1hH3CqZBrT3CNrmreuzWaJzGW8DlbEgnDif5YB/R7PhIFhYrTGJmQTIBPwX9Qd+OJMmjSnUoxlZXmMPVnqGlRoHEDbUJEdr/FeAX8EvCLz9GOMspMsT9aiUKjYsjx/ZDuVlUgNnNkz2DMjyRUOkdEqveRArSkU74nJgG4u/PPniTCmOmMTW0Ayrdywko14mI/ht73/Okn7hlkA0bPj4t+idNQrlAWgWpunXqHs5ZZo8VHCESptQEQHERJmDLHMwS3KEUS4hk0lguTYX0QZj+MzGWwyD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nQqcrV0paeCNfLDEnxj6tC/CY8D8wXCBFM5oM4WelI=;
 b=JWG0Ez0jhTErICNo6u6Dtnpdf8Wgl7UGp64BvsddCDHhSrny58ufvRaqwraV0tDw2e9dMFqjKl6jOdZlBPDvRVz1rODcbiotG7QVThNgt6oblXxACWYSOVFylGcJoNrEhgxPKFed6H/f4zZZnJb1ITHTDiY8ckoRgaEIdYWeZ3URmeSWCLVFTtGNkxaipCYwbbvqmTtPinewmYLOv4R9WB9u8oFDYeH78unaEScibbcUzSdl9dPlkmDNyftbI2LRIzsGvyj/YRJYfBoXA+9RXhaZqn9Bn6O9Mbi3H9oxdfQIyczC4cNF8wW3eyUBtLLd1xThG2LoX8viVOfTMyrKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH0PR11MB5047.namprd11.prod.outlook.com (2603:10b6:510:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:22:27 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 05:22:26 +0000
Message-ID: <7759ab78-f9e3-4781-a1e1-adebaad57192@intel.com>
Date: Tue, 1 Oct 2024 10:52:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe/ct: prevent UAF in send_recv()
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20240930122940.65850-3-matthew.auld@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20240930122940.65850-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH0PR11MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: ca97d9b8-ff04-4839-862a-08dce1d9099d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHBXTnBrbTBUZ2Z6Q0pRMGNwWnhuYS9uTDF6VFBUbVRJQWd5UjlpY3VndWsy?=
 =?utf-8?B?ZSt0clRFVi81TWRCSzFRVlJVWlhOYzd5VndoU2x2ZUc2V1dWRE5pK3dJR3Zh?=
 =?utf-8?B?K0NHYjBjdmUzSkxDUEFmMGM2aGNnV0hzU2xZWWgvNTBFTE5Nc3pMd25ZOVVn?=
 =?utf-8?B?SXU3SW9uNUtmai9iTnFmTVozajF6Z0NLOUVJZ0dheUtzeXB6NGo5dGtoMlhK?=
 =?utf-8?B?NDJkMW5tL0p6V004dUJjSWhJSTlFc3pOcFE1REpYVWY0L0duajI0cEJieGw2?=
 =?utf-8?B?bXBrTkE2QVRjNGk4THFaMENZamNMT2JYWk5GS2ZPU1o5TDhYdlJCaUQ4a2M5?=
 =?utf-8?B?d29CeWJUeGdtcjBwQnBKNi94VHQxVUdOZW9lM1E2dTRqblBsRFhLTzJMemw2?=
 =?utf-8?B?dHkwWkxWNENHVXc5UCtOZWxIY05GY3gzOURzTzJxRzIwWWVTZU83WUxrZTlq?=
 =?utf-8?B?SXNVLy94eUlDMUluRTMyV0hFREk2ZEozaS9KSFVOQmlHYkJ3V1YzaDlHUE9q?=
 =?utf-8?B?QkpRaVRnMmQ4ckRhN3BNM2k0TDN4TnMzN3p5UHliSmdXM2VuY1h0Tm5zakpq?=
 =?utf-8?B?VzZEcTFzY3l3YnBpVno5SHNkaHJGbzlRSTllZkRORWl4dGZZTXprOVBnNGUx?=
 =?utf-8?B?T2RMci9UVXlDeU1PNkFDc2lGU0JSTURBNzBqZmpVb0wvWVdIRythM0xiMXZh?=
 =?utf-8?B?VVdtUnRkdEN4bGFGOWxXek5jdEZIUFp5MUNFK1pvY0pCcXBqUnhzdzk4bXBQ?=
 =?utf-8?B?VHRBaUtnYzlGYndzNVE5UzllSVBTWGlNcG5Kb1JTb3BIVEoxWE1zanZYRVZE?=
 =?utf-8?B?QmdPckpxZ1ZvWWF6WWVYUEFOcmx6OC9pbjdoM3JZaXdGS21meGl4SUZvR0dO?=
 =?utf-8?B?NCtyZlV4UVRISjJvd0JsVm5abkFzbUJPVzA0NlpOTmUxT3VTdGxnL2lOaVBy?=
 =?utf-8?B?TmlZUElSZFZLd2h5dkp0UEVwa3NoUW9hbU9VU2hnWENnbUNTMU9zTVV5RmdU?=
 =?utf-8?B?OTRjQnMySnVTRm5GQ0x1MktiU2FUeE0yNzAvUEpodjJyMnZiU0djWGVRckRs?=
 =?utf-8?B?c3V5SmhZMWNFaVBIWkRBZGRBdnZWNGhkMkJGejQzYlB1dUl5NzFyVnFxZHRL?=
 =?utf-8?B?V2dJVVdGUFJMWlorbmZvRmJaVC8rR0lRWFpyczQxVy96N0tycDRKUU5XS2lQ?=
 =?utf-8?B?ci9tOWJ4TVF3TnU0UEVMVHpEdDZnT0ZCcFJIbzVwdEJEYllDVndiL201amc4?=
 =?utf-8?B?ODhZcU5zSnh6ck9JTDAzbHlpZmN4c2hUaFZzRVk4dG9DZWhsaXkvQW9VY05t?=
 =?utf-8?B?eU5yYmdGcVNMdDRJa2RYZ2NrME1YdUpEbHJnY1lnUWQvTmxpRTlDbmVlNjha?=
 =?utf-8?B?WTFOb2czR0RFUVRkVlQvckMzeFoyRG9oVCtSbjBBY2dYeGpRYkJ1WHBIZm0z?=
 =?utf-8?B?UzVyNnh6ZUNvMVRCV1MzVnUyT3J2WDNERmVWWnNPdXJ4OFlMK3kxZ1ZCRmtD?=
 =?utf-8?B?MWhsTUVWV3ZMRDBBMThzSzRkUHVpbm1SUEVKMzMxZ3cwMTRaa0lKQzdhbmlO?=
 =?utf-8?B?MG9vZ0YzcHoweFlJTVpQbm9IckNvSW9ocEtSYW8yZFFyQitzVk4zdlhVcFA1?=
 =?utf-8?B?ZzJoU1JWUWtIVzNUNUpGNFVtYVBVWXFlY1BRTlFtR1pkZ2ZpWU1aNWpTUTdh?=
 =?utf-8?B?cUpEdVFXMUVTK2E3UnhsekZ3VnVNUk5DQUl0eWxPaWk2VVJ4Q1Y3NGMrRzRr?=
 =?utf-8?B?REN6OEhjNXU1WWZwR2grUGZVWFRBSnFMZ3JGS0RkZnJvbFdkWmljSzZQbm81?=
 =?utf-8?B?YklVS2tSUWFKNUR1Qmg3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtPeWUxcmxmL0xydEdwVEhsWmUvT2NMTXZFYW9aaHFNNnpHK1NqeVQ2WVpH?=
 =?utf-8?B?UDFoN1AveUhNTm1nYVNUWk1YaVBQTkNDUC9xbVpRTHM5clZJNkpHY1A5Y0Jn?=
 =?utf-8?B?Ungwa1hDd0MrN1UzUW50S1A5S0VCTU44SU5vT1EzakpnU3BCTFlrQndOdzYy?=
 =?utf-8?B?MGpucENSdHdNdzNYZEh5L2tTd2NZbEFDZ21vOWlzblJ0WGMzakdXWEUyaGd0?=
 =?utf-8?B?Ungzb0RXcHZzMlhXZzNRMkpoenBtYkcvS2phR1FuTFpiaDNZWVdicGk3bkhC?=
 =?utf-8?B?eCtSKys0THFEV1VCRUVkbXhab2NoVkozMFpoMkpjTHhSc3g5a2h1WGVrYVVZ?=
 =?utf-8?B?emphZmxMUllUQ0UwOElkUThvRFkxODZKZFBYRU9oczFnbFA5QlhsTEhTYlIv?=
 =?utf-8?B?LzF6TnBzL3F0cUJiUVUrME1YemNiVUdiR01kc1E3RXVzRk1mNzlsUHFTVlBq?=
 =?utf-8?B?MUU3aGMzME40c2tIYTAzUWpTZ2pibFJzMjJkTVVMVWh6MytTMVRqbk56WVp0?=
 =?utf-8?B?ZVJiWkk2aFBTVXhiY2RwSlIxWkQvZ3F2TFMwcW5RUUtINEFOcC9ZM3NVM0Jm?=
 =?utf-8?B?cW1UakwrNUQxYTl6eEc4aGtBRnZ3bHNFU0J6Z1VtMmhyWmxuNThtYmRwR1V2?=
 =?utf-8?B?Mm5ndHlQZVY0RjBuWVNJbnpyWm4yMlphSk1uV3JWbkE0emdnSWRtYkFOUnJE?=
 =?utf-8?B?K1JkNVluMHV6VHhtakdKT2g3czl4T0VjNExUWXA4djZhcEV0dFFDZDZWemhk?=
 =?utf-8?B?TXBwcm9DczRGWFkxYzlpc0daUXQ1WW5QWFZCYWVlbEJWRFhXZDlRWHUrbHJ1?=
 =?utf-8?B?eEJucE5ya1REeUU3NkJzTm9jQTkxKy8yMjUzdDhCZEpPSnBTMHNPRFdpT3lx?=
 =?utf-8?B?MHg1amZTbGR4ci9vbzJiNGxnZ3FmcjRPcThRYWpXYytoZnhoM0lneVVRU3Ix?=
 =?utf-8?B?UWdUSkJCOCtOMU5jbVFwbVBZamhPQlkvcVhhTUMwUXFDKy9lUnlBaHZIOVUx?=
 =?utf-8?B?MGN6QWt2bUt4WUpXVTcvZVNSajhQL1ZHSnlmTjNCKzZWMG1ROUlzcXlseVZk?=
 =?utf-8?B?VjZjaG9xQ0tYMk52SkhLWXF6elpkbjZMdXFTV0tYTDJyMzZuSG0xbVVqckhH?=
 =?utf-8?B?OFFFaXpLK1JWbUU3ZGxkR3lKL3lKTmVMekFPVTlCcWFBWnJNTjJtYkYrd05I?=
 =?utf-8?B?aVorZnc1VTdKOXJza0ttOEVlWFZ2Mzd0MzlCeXZPNURCazRTblQ1S2wzaFdr?=
 =?utf-8?B?ZVVWcis5V0U1ZDFzaW1aVFVLdS84L1kwNlphVnA5SWl2K0h2L05nSWV6VWdN?=
 =?utf-8?B?VTZKMTlrcnZyZ2pWWXFFQWJEaGRhK3VVTlNyNlNtU2pPU29VeFRTaURwZjAz?=
 =?utf-8?B?VlIzQS84Ym5xdEYwcTF0YVJ6N2VndHJEZnRPMGE1V3BCRmN4NUlLSm0yR1Rn?=
 =?utf-8?B?YnZVc1VmL2U1Y1pQVG42L3h0NHlzN3RiVXFuNG4wZ3U2VGFvNXRVRlI3TmJx?=
 =?utf-8?B?ZmtTd2lQc0NTNUlXK0pWcnJGS2Fvb0pFNzAzL25acGljWjJqTUM0TFRna1dD?=
 =?utf-8?B?em1iYlZLV0pZZTk5UEdlam5iL1QvRG5iaTFWREtSTFp4WUY2cm9hajRVYTlD?=
 =?utf-8?B?VFpRc09Ic2pwMG5mbHJ3d2Q5QURvczdQMktzY3hOTXN4bHRrY1pFeFk3TUZy?=
 =?utf-8?B?SENzUEVWdi9EZmE0amxXMHpBSEFJS3VkRzVwRkRZbUdYUGcwK3NQdDB4NmZZ?=
 =?utf-8?B?R2dNYTlNUG5CbHRNTUNoQ1lBNWRhdU81eW1XNjFPZ2hPM0tVdEwyT0VSR2d5?=
 =?utf-8?B?ZmpCZnZEVFJ4RFZBdlEva3pBdWVVQ1J1ZEREbHhXbDU1Um1VV1lSbngyWjFQ?=
 =?utf-8?B?RVA3TkRCS1QwdGxrVGcrRHZpQU5HMmkzREs1bDVZajFlTVRrRFh3UGlTTzMr?=
 =?utf-8?B?em56dVhvYzRlQ3pVSytpeFZCOUhiSTJucURlZGhNdEw5czhDMzdZSTl4b3FJ?=
 =?utf-8?B?b2hIOFd5bno4azI5ZGRTR1ZZZ09ob0laeHN3ais1NkJESTRSMzFjbmMyRWh3?=
 =?utf-8?B?SktQdWtQdDg1Y3Q3bU5VUkhwWWNWV2s5UlFXc284ZVFKOXh4V2k2NklkVEtW?=
 =?utf-8?B?SFJBUkxPZnlHMGZkSUh5NTFVVlN4VkJOUEk1YS9KODVOL1czK25aT1JGSDlw?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca97d9b8-ff04-4839-862a-08dce1d9099d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:22:26.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JybZo6JcVxSIR++f7E+nSRiKHdorP00tVFTpuPw65IsI1NII8bBAnXtXZU8QJl8WtiB/TKKEBfa53e6CJYDodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5047
X-OriginatorOrg: intel.com

Hi Matthew,

On 30-09-2024 17:59, Matthew Auld wrote:
> Ensure we serialize with completion side to prevent UAF with fence going
> out of scope on the stack, since we have no clue if it will fire after
> the timeout before we can erase from the xa. Also we have some dependent
> loads and stores for which we need the correct ordering, and we lack the
> needed barriers. Fix this by grabbing the ct->lock after the wait, which
> is also held by the completion side.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/xe/xe_guc_ct.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 4b95f75b1546..232eb69bd8e4 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -903,16 +903,26 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   	}
>   
>   	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
> +
> +	/*
> +	 * Ensure we serialize with completion side to prevent UAF with fence going out of scope on
> +	 * the stack, since we have no clue if it will fire after the timeout before we can erase
> +	 * from the xa. Also we have some dependent loads and stores below for which we need the
> +	 * correct ordering, and we lack the needed barriers.
> +	 */

Before acquiring lock it is still possible that fence will be fired. To 
know it it would be good to print g2h_fence.done in error message below.

Regards,
Badal

> +	mutex_lock(&ct->lock);
>   	if (!ret) {
>   		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x",
>   			  g2h_fence.seqno, action[0]);
>   		xa_erase_irq(&ct->fence_lookup, g2h_fence.seqno);
> +		mutex_unlock(&ct->lock);
>   		return -ETIME;
>   	}
>   
>   	if (g2h_fence.retry) {
>   		xe_gt_dbg(gt, "H2G action %#x retrying: reason %#x\n",
>   			  action[0], g2h_fence.reason);
> +		mutex_unlock(&ct->lock);
>   		goto retry;
>   	}
>   	if (g2h_fence.fail) {
> @@ -921,7 +931,12 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   		ret = -EIO;
>   	}
>   
> -	return ret > 0 ? response_buffer ? g2h_fence.response_len : g2h_fence.response_data : ret;
> +	if (ret > 0)
> +		ret = response_buffer ? g2h_fence.response_len : g2h_fence.response_data;
> +
> +	mutex_unlock(&ct->lock);
> +
> +	return ret;
>   }
>   
>   /**


