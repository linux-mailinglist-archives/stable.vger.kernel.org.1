Return-Path: <stable+bounces-89513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD09B97E0
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5922F281D00
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4D1A3AA9;
	Fri,  1 Nov 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRbibTrV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CA1990C0
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486894; cv=fail; b=uq2OuTEUQe2huymeOgs8sZF+Uu2W+01MBNkbuKEiZji12bRcU1Krknw8HEOE9y0szF8FpWMFDzcH2TRMZwsH1D7LOG+4Q6loQM5xKgLNSIYFH95w4HBa+8Vg2P5QzBkvZkAHFbZT2m8ZxApmcTh3uxV7FzISIsK1iIaaRD+XoT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486894; c=relaxed/simple;
	bh=Xhmanebzt5ZoWPFWnGbE9XHeu3dXwOpdh33fep4pNgs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+XisLoYcJ3/cykFHpJLIz8L0IO3glD6dFdAFCVjVEiunGypAhar4/68Q8qqrYc4dyG9TAYlNtYuz0FSs5PrZ5IWZoriaR9FNVBHHjMjTk8UQpiMGDWOtYVifb0KZfexdG2McxBzPPW/aXAvolmeFtwwYoJZe+1Nvkxzj4VHZw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRbibTrV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730486893; x=1762022893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xhmanebzt5ZoWPFWnGbE9XHeu3dXwOpdh33fep4pNgs=;
  b=LRbibTrV+EHbGRnOnBmmiAqg1BAxLYnIq04vIWAtKgDjfB7NWtlhyQqw
   pgwMkEpAg01/T/0bEoLnKwogZRZbGOMbVlTBKg/bFo9A7obJq2UGfUvtt
   A6eHjnVP2ca/Xg6t5ZrvwD94il1Ms3bWlqTP9FyKjqHq8f4PN0k9S5JFU
   bdxO8YhdozNjHujp5uKBCezEEbZIsjYZK9OC/wdOVLtzcgsXyolcViR8p
   o0l9JiBBOClNQN7M60Pt2wCs9qZjJZbV1D4jcjKLu93Rf5Igb9BNGJb7X
   6Jp0fxmzIET5HMZav9Vu43kMThyN+NZSpe0XOf0bRgsnTDEac780w+gsY
   w==;
X-CSE-ConnectionGUID: SajoAla7TFGyxYxZX83MVA==
X-CSE-MsgGUID: /81zqluUQSiZ/9wqNyC9ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34054342"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="34054342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:48:13 -0700
X-CSE-ConnectionGUID: B9uGhh0OTNuXIn9IYnmQQw==
X-CSE-MsgGUID: GAmmWzDQR/Wh54dCSgITrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83384971"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 11:48:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 11:48:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 11:48:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 11:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCa7bb5O/U8YJk11PSSVM63BY3WtCziZCOj02+1Ibyp2Cis8Vgd/Uv2HeSu5NuWEyCyVoQPGI+YJ6VZn7y+Cv8UiwE0uSUnW0qBc4KNuXgPLSqD2DzUU3WgGp3HKvO8HQKDCyW2VOswsZ7ka4DaYoJi0aQQnUQ4CX+st/3bp1Vs+7X5/JPNba4P8b3nLC+rk7hVuODzd3C9NiBe91kLd6l0w7eKeSuWj4jml8NMp6LTrGcGLIiNlbGuvkLAAEsxXW+SIOV+vj2yDKK65NxGF3ulwmX9qohvDs7vzqy7Uh6mqAwK/Lr2dFefrUJYks4BHwigWMsfgrI1QpHsJaKaedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFsKPRqYyzKLz5wjf0cIXJjAQkZSh31v88gkrgWGSYQ=;
 b=kLcfO0fuMnLfMQ9vIN6GawNy6c0B2TO32qRRlTF4ctXvt6jU0ZSJWQNi3RAewFF6qC918c370ZukgTWg4PN3bQhJBMZpxFr+gICVbsOOX4cKs/KqnXjaAqHp5P5DCCpI+pfnWOuo7U8YAMcQfeOYGOkQO/Td7SEdew5hVMZzlmKLNlAwP4GzfqZoNftsz+ri/biEKFKRYlV+izoQfYfbqBu3H/duU9DujCbpml5CCqdh5KBNC1fUSaIPO7m+o8Abbi/OYuCu+4b/3Tyn4dfQVKMtUbAoq/H1JBpELHI2bSt6R8W/m6uHVtMZt/C8LSu7LqnswKQUcMCYwZd9TmfY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 1 Nov
 2024 18:48:09 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 18:48:09 +0000
Message-ID: <04ed3481-cc77-43c7-89f4-159ce52f3e7c@intel.com>
Date: Fri, 1 Nov 2024 11:48:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
To: Nirmoy Das <nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20241029120117.449694-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3e005e-3d7c-41b9-210f-08dcfaa5bab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmRaOGZaczNPc2QwQ0Z2aGtGVUhjcFg4c25KRUlBQTVUZ29Dc2d0V2FTQ1lE?=
 =?utf-8?B?OVF6Mm5aeVppaWFuTDlrUlFmSG9CVkxCY3I2RXc0OXFSQURJZGVjN3h6eGJs?=
 =?utf-8?B?Z1F5aTQzRXhwcHQxYXFYT2F6YmdWd1JKTi9tZjVTV1hjL2tkOStSVXh5S1JS?=
 =?utf-8?B?YkJkQ1JoMHdUTmNFUU9KT2xycGt5c3Iyb1lRL0lSUXZGZGduMitWTUdPcUM5?=
 =?utf-8?B?Mmk3ZzZmTXcvUk9OaklVVzJkamwveUd0bFlvUmM0TTRCRzlrLzdaN0NsSEx0?=
 =?utf-8?B?MlNWanZvaDd1UUQrRWE5RkJUS1BkeUZDUktqMlhWUHVVcVhwMHg2ckNXek84?=
 =?utf-8?B?MHNrQnhoVExVeDhIdUlaZnZmOEoxQjNkZGt2OGcxdVc0Y0txQkhTZitqcEZV?=
 =?utf-8?B?dmpSOWwySHNhK3B6VktoM3VjcU9DUTNwbHcwdmJoRUJSN2dDVUhRbS82UnVM?=
 =?utf-8?B?bHdJUno0NW1ta2ZuQXppMWE0WHlQOGxIVDlxRFIwQXpTbU1GcTNhL25STUY4?=
 =?utf-8?B?L1A5RW5PQzBmeHJ2REl3TXJYS29GeWxtdUtuNEhPRkRJU2w0OWZ5WG1ndFVI?=
 =?utf-8?B?QnlhVzhELzhwcmJoZVBKSDZwbXhiVXhRb3VoYW1Jc3l0b005S2hPN1kwczd0?=
 =?utf-8?B?TWVXMk1ESHBMRE5ycWFDN0Y3czVKbUcrQ09Mekd4MVZ4Q2xvc3haY2U4NjMw?=
 =?utf-8?B?bEg4ODBwaGZSVHFoV1BlY1pGclNYNDFydlBPNXpVOEFnLzJzZ1NnbUJ6MEE0?=
 =?utf-8?B?TmIzVHNxVVJIZzJ5OHZYTngrV3ZhWDVNdHRuTUhVMFJKeWtFNXBXR2F6Wm9O?=
 =?utf-8?B?WExFd29WOWNYNXpHcVdISjl0OXhzYVNzMmJPa2JsMURRYTNGS2h3UFJpTm1w?=
 =?utf-8?B?VEdJSlNnanU3OGMxcDliSm9hVVhIVENwQ3hkTXpSdnNnN0g3UGswUURSdGYz?=
 =?utf-8?B?V2hKc2NTVGZrcXBSMVU4Z0xpZEI0UW1oRUFma0VmNEdjZGF2OFI5NkZaVGpK?=
 =?utf-8?B?bFN4U05JTUFCQTRCYnVyd0FqcGpVSWdnM1dhYXFITHU2MnVlbnh4Q2ZoOTZQ?=
 =?utf-8?B?VW5pbkY5Tkd2TGNoZnpOd0N2OVF2SzRka3hDWGxPOGlHd1NyYThtOFppeGFM?=
 =?utf-8?B?azZVU3hBaFFuWFR4UjhkZHV0VjNBZjNPQ0psbDVHWFJQRER3bTJsdnkzaURT?=
 =?utf-8?B?bSs1U2xCdUd3Y1puN2FGMnE2anQwWlBsSnppVS9rMVhsenlTT2V5ZnBaVU15?=
 =?utf-8?B?dDNFK0NWci9lMXY3RGNiQ1ZXYVEvVEo2bnFSM3pjSjVSNlpzMU1pVWUzUGlC?=
 =?utf-8?B?dHJTNGFwTi9MUmJJM3dWSUtMSVBlK0ZMSzVuMnEvYlpLWGJNRGNNNW1NKytO?=
 =?utf-8?B?cHQ3QUpsRjZHbDBBSWNZV0hCaGw3M3N3ZDBtdC9ZNktwSGV0citmcVc5WE9S?=
 =?utf-8?B?YVhMNmh1NFFOYnovdEkwNlRnYzgyMWdSbFZPekxYQkpPTFNvaC9sdVJya0VR?=
 =?utf-8?B?T2lrQnVoQnd5dG9mU3Q0UlRWMEt1QjYrOVhxdkZXSDQ0azVWMDl4alExUDZy?=
 =?utf-8?B?U1k3bDFZd1dvcGwyWjNUL1oyUlZUL2hGRE1lQTFMbXFYUmFQU0FjWVlma0VX?=
 =?utf-8?B?OGNucnF5cWlITENlczRHNDExUHpoaGVxRVMyL3NFajR2ZEprZ1diUjkwT1FZ?=
 =?utf-8?B?akRtbFB0eHN3WTJ6SmRPa1Z6b1JGSDlsM3RzVGFPdWNpRlZkYkZuaEtGSjd0?=
 =?utf-8?Q?tG/3D/6+AtYnBTd8glNfD/g+lATqfri14QiXKs3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBaRVE2RU13eWRHamp1YU1SNUZTdWtNbmRIeHA1Q291bGd4ZXlpcTROcTdS?=
 =?utf-8?B?KzlHSStxSUYzcExaa1kzMVRpQTEyaHhkUDdkYWUzT1FXbmphVTBaM2ZWcnND?=
 =?utf-8?B?Y0tVWFpDb05xWEVWNTNBWGFaTnFza0Rxb2lLdUtGS3JwR0J2NXZvRkVRQWg1?=
 =?utf-8?B?ODRLQnoxUDRXd3Juam0yalBuRFBzM25id3UvUkdLVmZVb2twTTV3cDZmb2J4?=
 =?utf-8?B?NnFzQmxhUzZCN1pxWkRDaVhZdjBnWlJxRjBoUENCZFNiNGlEYUwzMXc4Wm9q?=
 =?utf-8?B?NHZ3T2R6RWFsbWNCVmZkMW9vc3grSnpMK1VBaGxNMWVoT29HN29oa0NCSHRX?=
 =?utf-8?B?YkJDczBCc3haeGxRdGdTejFHMVcvSkp5MUVZTklsL2NxbURRazVjdElQc1lL?=
 =?utf-8?B?aXY2YlRKLzB4VjNBblllSklBOXlreWtRWCtNd0N4NlgvVDFqelBvdnJTYnUv?=
 =?utf-8?B?RHc4ODNoUm9Mb1orUWh3WDZBOHBOeWhjZ050QUQxelNDRmYxY3grZlZoQjF4?=
 =?utf-8?B?c0NMbGxidllGV1J0WWVnbUFQempzbmsybENhMU00QmRpOXgzUzl1eWZSUUVE?=
 =?utf-8?B?bUJTdUY2WUs0cThIS0RjUU9FUEpMT2hYRHBTZlZTSEpuNk5rZkpvclVGL2c4?=
 =?utf-8?B?RTJDNi82REVrNHNrbmt1aDZRS2RhL1Y2UHpSUHpPNWJRR1IrK09pTHdoSlhP?=
 =?utf-8?B?Z1pVYjUzdVFtbmVHYkgvUnpDMy9BWlh0MUEzL2tJUk81SVkybWQrWXY5bnlD?=
 =?utf-8?B?K1M3d3U0eFVRTW0rSm1nRUMvWEZoZDM1MHZJSzlUdEJicE55Q0RuNURQeUFa?=
 =?utf-8?B?OS9FWFEvcTEva3BXdnBsV21HVXRRaG1vczlkdkdHdWp6NWxRQ292RGJYUnQy?=
 =?utf-8?B?UStvUkdhKyt6R2g4R2dNREc1c2MxMVZZMm9YYytNTGhNRHhIdGd1UHFwcjZZ?=
 =?utf-8?B?UnFodFBRSjNFM294bXNpRDFqVXgrTmlveUY2UDRQRmJGWEtiWFFOUTJsWnlW?=
 =?utf-8?B?NE9idmlhUmI1OXI5ams4eElVZTRHMWtYUytkUEJxTFZGbGVoK1FTTDgrUjlD?=
 =?utf-8?B?NkZnSkhFSEh1MDlES0FUeHhhblc4VkJUSFRWaW9UNUpHRHhXenM5eEh0VjJp?=
 =?utf-8?B?L0h0YjBKV0RTWFMwdFpTSCtKTzY3OCtiUlVEbnNhSFE2QzFnZ2Q1UndaK3Z2?=
 =?utf-8?B?TmFLTVYwODNWM2pXbmRiSXNwelFtMlRiRUUrTGZHbGxzTGw3RS9jZllOdHFP?=
 =?utf-8?B?NWJ4cm82STlhZFBPWGx3RFRuOE5YSkY0ejZWdmNJOFhqSVlGa1hZYkx3bDR6?=
 =?utf-8?B?N1d4K3QvV0xhT0RpRkhjaVZCWUF6d0VqdXRaL2Z5bWFnNVYwQlZMQWZETVN1?=
 =?utf-8?B?ZmZFTm1ic3JXeU51MFY2TWFxWGgzbkdQTFp1SDlzSWdlaHVWejNldzNzbWs5?=
 =?utf-8?B?ZzR2TkRjcFdLVnJ3QTFKUFhtT2ZRZE04a3FNdEgyL0dZNDh0MktkSWpDcnNs?=
 =?utf-8?B?L1ZBMnB4QXdVZllZSDFxNlExTjNwSEpaSWZyVmc2bXBXUkFpNWxhZnVNNHI2?=
 =?utf-8?B?aDN2eVZJVDRJZ2VBYnV5MHVaam0zeGNnK21Na1Q2S2VBWm9YZTRWTktYdDlZ?=
 =?utf-8?B?SjZVZjNyUUJjL3VEWXgrN21JcURhUG9zVEJBR1dZZitqWXA2RkNkb2s2a3Yv?=
 =?utf-8?B?RkZFZVQvR0UyakZxQk50N1VFZENxZXFFVDcvcFZQU0lQN0V0OTlRTEU0VFg5?=
 =?utf-8?B?d2kwTXFvRllDTXpvcmtNalVXL3RiUldjdXRIRENKMlBscmFXVkZ3OU9lUHZ3?=
 =?utf-8?B?aVN3a3ZRek9hSzFReWtiQkU5TFl5d2VlKzlnd293ZDZqbkM4eGJEbUJqUkNE?=
 =?utf-8?B?VVVPN0xKQ2xUNTErYTJFd2FYK29DL25KYjhRYlg2UXRXUGkwWnVFUDlQaVd4?=
 =?utf-8?B?ZXYyU2RGN1EzWWdwaUpYUGNwaldlekFYS0RvdStCZ1Z0eS9acXVuZUw3VTJ0?=
 =?utf-8?B?ZVVVQU4wakxZWlZEZStxY2ZXOUNYODM4YXdrd0V4TmwwaW9wZkNINzJubjFO?=
 =?utf-8?B?cDRiVjFUOFlORy8xNG5GMTEvV01CazkvUDdTaTAyMkpGTi8xTjYrQ2prMXpi?=
 =?utf-8?B?MUdrbStZb0pPZVVYU2hOMmZmZVAxdlZOVjd5N21wbGozcUpncjR3Z3Y2cnVU?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3e005e-3d7c-41b9-210f-08dcfaa5bab6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:48:09.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkDVHQkEQQ6XoJVTs39rBYTkOjcCf/A/yZww88kEd/nsqJEYklkWr6otPXl2uWHkbl1Xb9Kxe5gtk6XvK7nGOevD1en/5+3F+zzZh23rbjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

On 10/29/2024 05:01, Nirmoy Das wrote:
> Move LNL scheduling WA to xe_device.h so this can be used in other
> places without needing keep the same comment about removal of this WA
> in the future. The WA, which flushes work or workqueues, is now wrapped
> in macros and can be reused wherever needed.
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device.h | 14 ++++++++++++++
>   drivers/gpu/drm/xe/xe_guc_ct.c | 11 +----------
>   2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index 4c3f0ebe78a9..f1fbfe916867 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -191,4 +191,18 @@ void xe_device_declare_wedged(struct xe_device *xe);
>   struct xe_file *xe_file_get(struct xe_file *xef);
>   void xe_file_put(struct xe_file *xef);
>   
> +/*
> + * Occasionally it is seen that the G2H worker starts running after a delay of more than
> + * a second even after being queued and activated by the Linux workqueue subsystem. This
> + * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
> + * Lunarlake Hybrid CPU. Issue disappears if we disable Lunarlake atom cores from BIOS
> + * and this is beyond xe kmd.
> + *
> + * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
> + */
> +#define LNL_FLUSH_WORKQUEUE(wq__) \
> +	flush_workqueue(wq__)
> +#define LNL_FLUSH_WORK(wrk__) \
> +	flush_work(wrk__)
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 1b5d8fb1033a..703b44b257a7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1018,17 +1018,8 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   
>   	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
>   
> -	/*
> -	 * Occasionally it is seen that the G2H worker starts running after a delay of more than
> -	 * a second even after being queued and activated by the Linux workqueue subsystem. This
> -	 * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
> -	 * Lunarlake Hybrid CPU. Issue dissappears if we disable Lunarlake atom cores from BIOS
> -	 * and this is beyond xe kmd.
> -	 *
> -	 * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
> -	 */
>   	if (!ret) {
> -		flush_work(&ct->g2h_worker);
> +		LNL_FLUSH_WORK(&ct->g2h_worker);
>   		if (g2h_fence.done) {
>   			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
>   				   g2h_fence.seqno, action[0]);
This message is still wrong.

We have a warning that says 'job completed successfully'! That is 
misleading. It needs to say "done after flush" or "done but flush was 
required" or something along those lines.

John.



