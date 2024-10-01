Return-Path: <stable+bounces-78501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B119998BE6C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE21F24466
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D441C6F51;
	Tue,  1 Oct 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mF7Rxjod"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7A1C68A8
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790653; cv=fail; b=qw/rNPCjALEbHwA+3UH7D1V3atg2MjZ+a51OrcxyOe45QqJfwuYQ+iIrBH/qoMcu2nj5HJlFzH1jhiAarHf9/DVDk2vio0WVz3zGFP8iJGT3otz3fpxJP2PA+E3lCpvjYpM2lk7LYV5z4EVNE56IMbD5XfJ3H3hwajKH2Ys7Ggs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790653; c=relaxed/simple;
	bh=gyP5e3Uc3p5yoOSjQHPSInw01VD4ENXzAnDPfbrU7gI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwZZsCALaLoj7hdzhZjd7CysVIX0cEbyoHUkHzoDBlFhoNhMDdaBQ3BfZQnt4Y1M/Ib0L6TDT+qitt6n7mbnX4M5/Or4SpaMtG2R48RikuG1zRNJ0Wtcwl911T3c+nZlzyrkKG8pCfElm+A9eqFrel+KbR8D4y578TpikyHiPlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF7Rxjod; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727790652; x=1759326652;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyP5e3Uc3p5yoOSjQHPSInw01VD4ENXzAnDPfbrU7gI=;
  b=mF7Rxjod9pIMJvJMof085fwhDJaFavrmrWGQdVZumn20EyM7j+k9+Nn5
   uLQBObbtP6zqgvZ7nGnsubbjOuue0cMBQsGBEJIQfVJrVHyWL8MN1ySEU
   KQayYwVm1f+cPu4weeroseoSnf/7QqYj94m/ksIVnO1d89v0pyY9juapp
   ulchHDiInrYQwZVGuyqna2nP7+utxY/q5soXg41g7sY3xxarSo7I6lKD3
   DXaic3Ujg4eIcU+pTqynQQ64AcDluJ0l0iodKwLhIm3b5AV9rSb4XI82m
   TpUcrGbmCG4TBAZ0HZqzgbi7zEmIc5Ctc52YvMZhz0YiN0kH3wWMD3yrq
   Q==;
X-CSE-ConnectionGUID: d6XKba13RNKtuYBZotel2A==
X-CSE-MsgGUID: KMyTgzQQSFWw3RDBbD08Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27057113"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27057113"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 06:50:51 -0700
X-CSE-ConnectionGUID: jbj/8d3OQO2HEc5kkW7gYw==
X-CSE-MsgGUID: lp5fieWeTmetsRgsuQTlUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73644086"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 06:50:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:50:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 06:50:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 06:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byfyH3uymeHYdu4Bwcs7VKn75yTFgzpTgEoBhnpEO28AQY85/QXw70ZJtY+K4z62H5oQcg+oDPFGM2+AVYI4qGhcRlsRnl6UPOWbO5VsvFoOxrilKW3H9DHhVNXyW5Yxao4k75BOaEpgX22laFbIx4w/BwKV9gmgnBviT+nn6jcBvhhdLYuhIsGXCnNIh/dFMAOjCiYP7mLD5aVCyERC8Zi0UBJbbv3ppfOcR7Z0DOi+M2HQuwd1OMPbqffci8Ci/2E4CZbp2B2nRWxAlZ8VGXKE2w5i0XnCMwXHIXFD/EdA+hzeYKsfidtq9P6qO8IsouQCqSrQENRkXnk0htwtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7nD2ehCeEPP8FGtiDkB1LX4sB0rfv7vLjZoxJYBpSI=;
 b=zWxyu1lHumAQqyRtT72QtUaJvyC+Yo+kCaf2xpGyJJhIH68OGmpOzMb6uHW9F4IrKHjsm/Uo8jwgd9I+b4b1YFI0NeeYHZIR18U8w5GQGefpWNtiZbhHuKD40Ke9P8BbEThG4XQWM04BpK40apJqicDniHgCOli7AYHMNflvVoxuwmJg2ULVzDMz87E2ajxzmGO3Dzx8LyEf2DUoYeNBL2Yck2vWGZPJH50rUV9BVHrm+XbgvUL7hZqGY9rQmwQJJXIbcVE7lTKACreWJi34BjuQ2vI9tTJYeDnrEpZNhnWBOgWefxuMp9EiCY92g5D6kQP1uzo5D4lM3QMGUUQO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 13:50:46 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:50:46 +0000
Message-ID: <05c05a56-f023-4dc4-a9b1-61f3adfee447@intel.com>
Date: Tue, 1 Oct 2024 19:20:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/xe/guc_submit: fix xa_store() error checking
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20241001084346.98516-5-matthew.auld@intel.com>
 <20241001084346.98516-7-matthew.auld@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20241001084346.98516-7-matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::15) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd19a1d-09ea-4187-44e4-08dce2200cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ditYREJPSzNtQWRBUk43OXhSQ3RPV250cVRKb25ERlFPNnF5MTE5d1pacTBv?=
 =?utf-8?B?R2E3ZEp6ckV3QU1SVmpkdG9wOFg4cGpPanlLNTh4ZGYwR1E0SzF3UlJ0OEFk?=
 =?utf-8?B?b1BDcit5UURqdkQ5OGdsZkZPNzJ6ZzZpREJEZ2RySGxHamt3cXh3Ly9pbnh6?=
 =?utf-8?B?cndDVThTdW8wZyt0QU0wdDNXRnNhejhGbEtKVHcxdCtFN1hKUm1LWWdDYldj?=
 =?utf-8?B?VGk0TGxUeEJJRVBGeEpJdTZISlB1a2xpcGVYdDh3Z2xLT2s1N3BlQkY0dEc3?=
 =?utf-8?B?VFF0cWpsRHRYUzkvZGYxeGhyY1pHZnljYnNOZ0tQbjZJODJzUWFDbVZhanly?=
 =?utf-8?B?R0ZySjY1WXkyaEZvUllzb1UwdEI3aTkrdGRjVUQ3bm02R1A0VHBWTGM0K3Z2?=
 =?utf-8?B?NTF2c093ekdLb0tjVGtYZHY4ejdJa0ljZHZ1V2IxNzNKemMxNjl1UmZraHFB?=
 =?utf-8?B?K1lKYm01ZGhMWGRmUHV6TEJ3VUlteUJLRmFvOXFlTXcwWXRJSHVLN3FzSncr?=
 =?utf-8?B?cXV4bHd2bEI0d3ZPbzVJbmNtK2d5bkxvWXZkYzVIMTBKVVlTOVFJQm5ueU5B?=
 =?utf-8?B?YTdLQjZXR29UbkdKZEFDd1RZQ1V4TnJZcjVuMzhpWnJJRVdkaWxGbDd1T0tG?=
 =?utf-8?B?eWRLaG1kK1p5Sng5b2Y3UWEvQTF4ZVdrTjB2SW9aWC8xc3FIVTFGWisvUFF5?=
 =?utf-8?B?K1doanFMMDd1eFA4T2syRVVGTEtWY2Q0RUY3QzdiZFRncnpoVDBkZituQUlQ?=
 =?utf-8?B?SFd6VmxZMDYrd2JRdGxTWDllUnkzMGJ5RlNIcDF1dmQ5U2kwY2FDbzhoazRS?=
 =?utf-8?B?ZnlZcnAvVC94K0JaVWNYMitQZFJzQU5IYWtSR1IwdkxMeTI2WU8yVlFaQmVZ?=
 =?utf-8?B?Wkcrc0hMT3ZvVitYSTkwT0hjNDErbkJpSlBMbEIrVnJrTVJtZldQSTFXL0hP?=
 =?utf-8?B?SVZKMzBKQjZXQ0pVNW90TFB6Uzd3UkkreERCQXJ0c0NKR0ZIclV4VkJYTGtZ?=
 =?utf-8?B?NVlrRHdLbDBqR3UxTmpTNktNYmdVK3Q0MkFZTXBEeWhxeFdpYW4vSEZaVkcy?=
 =?utf-8?B?ckkzcDNjM1hTNHpqREhFbFVsNndrVHNMYkZvUUR1OEw2VVdoa2RLWmlXdTNy?=
 =?utf-8?B?NXlrLzF5WERYbjBGMzJjYjdZMkUrTHNRekxGUnlkMEc3ejJ6ZkhNeGFBdmdw?=
 =?utf-8?B?cmY1dDhnUDRFeXlPVjQrL2Mya3ZCLy9mN1AzL3krNTBHU0dBZE41d2J3VUxB?=
 =?utf-8?B?bFVBVzZrOWdyMTVLQjY1S0FmODk4V2dENVg0M1BjS0ZFQnpWZzV3VklIN2hI?=
 =?utf-8?B?NGcvc1dWOFNIZDhaMEtkWHU2UGRKWGpTUnBpSmFSODRjREJ4VmYrVG5zaWRI?=
 =?utf-8?B?clRKeVYwZExKZFk2K1I0ZTIraEVrNmplc0dsZzk1NVBVQ0hqR3MzQzQ5bHpy?=
 =?utf-8?B?R2R4QVNVYUxVdWExay9tTHhjNXdaMys5Q0FJU2xZOFZhTlBpRm1lVEV3SXRI?=
 =?utf-8?B?SHk4elpjWU0xZUZsTHd4VHdWT2FOeS9PMWMyUHY5YVpOZFJMVkhUMU80bnBk?=
 =?utf-8?B?NXRvc1VOellkZFJTQ0o0Rld1STNydGFVaytzWmhscmRFZ0RhNll4TDJmOXVM?=
 =?utf-8?B?Ukd2YVBxL0ZwbTBBeWlLRTVDcUwxU0kwWE5XSERJb1VQMUtGbVFhWEpOSEtY?=
 =?utf-8?B?elpRUVorSjdsNEg1cU16OHlTWFQ5U2F4Q0ZqbkpkOWNYSlA3Q3BIVEVQNHYz?=
 =?utf-8?B?dkg0YVpQRDYyaldKcFNIN2MxTDVIT2FDSE1rN2lqR3RyMjM0VXQ1L0lTUm9w?=
 =?utf-8?B?a1FQbXBJbllJQk1VRmhFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VTS2VWN3hhcExwaTk1SVpRWEZOSzRkcHEyOGkxUzhiWnZiWFFLcHdwNjFu?=
 =?utf-8?B?Vzdhc0tRN2ZhSjVLSWtGeGFDMldDK2c1Y2FFY1JZOFZ5SmpOWWJnZXZMUDlJ?=
 =?utf-8?B?anhxaG9yZTB4ajJ5ZnNzR3lEWk0zTnJqSW1UT3JUbk1PQ2tpME5lb0YvMTNU?=
 =?utf-8?B?NlU3ajI5LzFHRkl3bTUwb2lmaUgvUm1GQVQ1TG15QktCUnF0QnhhSHNTUTdL?=
 =?utf-8?B?S1RMUWdmWTYwMkoxaFhxMEVwWDJWYXlaZUsrbHU4ajlSNTNFQUwydDEzL0xp?=
 =?utf-8?B?UGxSa3BTWERqMVJRang1UUw2bEo5elBkUjJ3b1pjdVFoUUd2RUF4WjZ0MThk?=
 =?utf-8?B?VmRrL0UvNURReWVUSFZGV2VlTVRtVnJQMllqTVhtby9sMFNEUkpMbmNxSnBh?=
 =?utf-8?B?MldZSDh6aS9Sa0xlOUhxa1pSVFNyVFpYZGRxNTJrY2kzaU1OK2k1azhlYzBG?=
 =?utf-8?B?Q2FocTZ1OFRTS3RPQlFnRWo5aG1PeXJtNmdUcHFQREJ3M3JyaDdSRFBLYmRD?=
 =?utf-8?B?elpucmxQU04xWFdHMWkrby8zRlF4c2YyVHJIZnhuMWhqUXhQM2FPOW9xT2Jj?=
 =?utf-8?B?RWY5OGhneEFyRCtkUHlhNGpiTWR0aTd2RmtoeXBpSktnOXg3UVlsSDJyaXhG?=
 =?utf-8?B?UTJUbTE0cGdnVUIrWnRSUjBGZjJLR0FIN05WLzVvZTY0WVBBSXZ0MjdhblV6?=
 =?utf-8?B?VlpCT1hKYlQ0M0hNUHdFNGFnbVIzWHpPSXNPbnZaVXV0WGhnUU01Uk9ESTJ4?=
 =?utf-8?B?SDZLNDZIYnhnT1VXWWt1ZG4yZTZRUXVJRmhZNDlPV0Z1b0pjbkxNclFLTHAx?=
 =?utf-8?B?NGQwVUt4cTJMN3J3NHFxWEhtTUNPMVY2WVIyZG1UYXQzcklIL21YYUNqempw?=
 =?utf-8?B?VE9RR0tSRlkwQVV2a3BmMTlZTGl2SVVNV1pEa0M4OStqOHN5ZnNGdjlwMjYy?=
 =?utf-8?B?SjRWTTBIT3NjaWdVK2VoaU44QUVoalIyQnlFMkV4VXZJR0RSU0EvVmlFS1pQ?=
 =?utf-8?B?TVM0Rnlnd0J3VzlBdXNOTVEwWFk1MWR6QnhCZmhQcE1rSXVEZDBDNFUzeE5M?=
 =?utf-8?B?VHhjTENHSGZkMVE3UUxMVzNmLzc1TDQ4ZE1vYVd5N1Y3RkFIVStZSEU5T09t?=
 =?utf-8?B?RjV0TUY2RWlNUDd5R2pzWi9iT3gyMW9iZCtML3FxU2hsbHJ1aUFqM2lZbGMr?=
 =?utf-8?B?RFFtZHpXbGtlNEdOeFRkMEJhMjdRVmdHUVYreTlNaC9Ja0t2SE5jNmExMUVD?=
 =?utf-8?B?ZldpeVh2dTh3dWs4YTduQmpFQ3V4RFh4ZWlxNHNMOGFCYnRwd2VJOVRsZWY5?=
 =?utf-8?B?Qm5ZZlYwRDNJNDJoRWVsTGkwRHdGUi9tM1hGMjg0SUZhbFdMTWNJdUhpRUZL?=
 =?utf-8?B?YzhJenpTc0tsNmdINFpjN2JCVWJSY2tyRVF4NHpuZmw3SE9ESW9SUnJJam1E?=
 =?utf-8?B?ZDVSWFJXWkp6cFB5NFNYV0lJK2VvZDZjWGRvQUZxUVZCeGlIQXZubWtXaXM0?=
 =?utf-8?B?cFJReEo5SGhTaFg1NzhxWXQvdEw2eWwzSDFiTWFqRTNCZGhiQ2JBMzRoWGps?=
 =?utf-8?B?TVJvSWZRSEJuR3c4enFNWmNzQ20yUDdUTUEvamxKNWIyV2tpVDEwZ0RJdHpD?=
 =?utf-8?B?aEJPR3RXL080b3h5eU5JV3FjcHFHL1QrTTZ3VW5mbjBFVkNFc0Y4OUtzaE1Y?=
 =?utf-8?B?VFRON1lVem9NWmRGWXo3cVNsZU9SY2RYcG1ua1N6YlRDb3R2MmJtUm5ub0xG?=
 =?utf-8?B?aGZScXZTeFBaNGlxV2NGUEJZRUd4YS9XL24rbWZjQ0JjUzN5UFFBd2RYSzZ0?=
 =?utf-8?B?WUVIbXNlZ29RdXdwWmR6VW9Mc0F1aFU5VXBmMHI1NzV1Y1JLdUUwS2tMZm5W?=
 =?utf-8?B?anhPRUkrUGwzWWhiTUxzd0xSK0UyTk0wRzU3aGRrNWM2SUY2a3FROTBYNTBz?=
 =?utf-8?B?ZEpUZHZDWllOcFFoSzVPazRWeG1JdER1SDNqdXJWMXp6TlZoRm04VlZQTVhN?=
 =?utf-8?B?Ym1vR0J2S1FpTlhuU2N6dWRVcjIzcGdsNmVEeGZaOXl6eTF0R0hvY3M5SFZq?=
 =?utf-8?B?V2J6TUVDZHlzQzEwOERUTGhLZGpwRWZOUEZRQXNCbWJpeVJGNGJkV1pmTWxE?=
 =?utf-8?B?ZG1icVIyRzJOOHk4cUlEalJOdFhLVVFNTXdrVHlicE1aa1RUbSs3Z29OVUho?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd19a1d-09ea-4187-44e4-08dce2200cff
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:50:46.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TanRLiWsrkF8Rrn6ggEa8TpNkaiMcBohlV4A0eTT0QUPkRzwMmfpCTjUgbaH1dTDjN2Pe2VOr8jspNF8n0OX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com



On 01-10-2024 14:13, Matthew Auld wrote:
> Looks like we are meant to use xa_err() to extract the error encoded in
> the ptr.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/xe/xe_guc_submit.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 80062e1d3f66..8a5c21a87977 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -393,7 +393,6 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
>   static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
>   {
>   	int ret;
> -	void *ptr;
>   	int i;
>   
>   	/*
> @@ -413,12 +412,10 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
>   	q->guc->id = ret;
>   
>   	for (i = 0; i < q->width; ++i) {
> -		ptr = xa_store(&guc->submission_state.exec_queue_lookup,
> -			       q->guc->id + i, q, GFP_NOWAIT);
> -		if (IS_ERR(ptr)) {
> -			ret = PTR_ERR(ptr);
> +		ret = xa_err(xa_store(&guc->submission_state.exec_queue_lookup,
> +				      q->guc->id + i, q, GFP_NOWAIT));
> +		if (ret)
>   			goto err_release;
> -		}
>   	}

Looks good to me.
Reviewed-by: Badal Nilawar <badal.nilawar@intel.com>

Regards,
Badal

>   
>   	return 0;


