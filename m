Return-Path: <stable+bounces-110335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681CA1ABBF
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5D63A292A
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D51C5D4F;
	Thu, 23 Jan 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4J1EZ6q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1281C4A13
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666908; cv=fail; b=XG3cp5PmmsSat/VALwOkmFEgg52BTWDrIorq3aTHNZGMYcTyWb/qWzCKBIAD6S9Qb4+s7jJDJ4u0cF1XIQgsxRxan1ql1QdPpzPof4fJ3OumH3XHAGewx3OBs1ZpA1IAirAENctCHsf02f+/l9whfUfCajifdUPUB11Rgez/eY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666908; c=relaxed/simple;
	bh=A4HzXZPjPFqkUMiKTCl63hrQOtM7XEc81RQQl9SGNmI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkrmsCqlZQFgNjgFsx+SwwcVzkmsbV0d5IdY0IBmemHf+ResR1qLS/EhgrZ+K1U5KEXUl9woSV57KFYSIjSPPm2P7vv4eEsSs5QcY2WpVmyiHWb3qk4F5+dEO3vQeQO/jVeq03o9Gy8aTwT1m5JXOxXMSqZX9LkklJ5AP3kni3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4J1EZ6q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737666907; x=1769202907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A4HzXZPjPFqkUMiKTCl63hrQOtM7XEc81RQQl9SGNmI=;
  b=U4J1EZ6q1UW06WldyRuit33TRvRHQKzAoVB28t+EPG+UCDzaRrJkFl0L
   9I2qizhoOt71CUdKq/Sa6iMeR5It4R9ESp8HassCC+P8cFpfyGI0gbIHe
   opejNkkti64EUphpS6gemoekpnCbbdGm7gdmof83GeCyXK6PCTzUsVsIt
   DIBMAj8FZoIKH09FdRM0bhW8EGGTSNjsLo7VqXymQ9KM7VJm5c2BP8SPy
   30gy+gQmevOPkMi+ADkKylFQniCFvEAQETdK1heVjBQof61CbSoU1PNdS
   WiElle0+HiZfyb0tA0SEqSiTnhAlo7TaBGVuhEHR36j8NZRWFVyzS1Tz3
   g==;
X-CSE-ConnectionGUID: 9BndEA7ZRDaiAW257VttxA==
X-CSE-MsgGUID: IhUs/PlaTTyr5NlIxNihqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="42118605"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="42118605"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:15:05 -0800
X-CSE-ConnectionGUID: wmWjdkwfThOXmoLpXjrv5w==
X-CSE-MsgGUID: Hwz72CcOSDqyIhBldIHp3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107393565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 13:15:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 13:15:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 13:15:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 13:15:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZFq7cUjAxuDgpNRn822OLBQFa8MIFv2H+4ZWkXwnDydIDoWHZrUMQjHL81YACLlPMmN/Ul1gUhQjmAAAxIdYF2iQTVm5jT9xCuAbm2hgXL9csk4Eww5Tl/nRqvjPwpqZtOz/59ogThWzVXLMBjQbI9vhK+24yyAB0u27Foxi+5UkKmnj2z/ND8cpsYwjz/rMNEZpAPl0k+keLLv1s2OnC38QzTOyvUr2u+YD5Y+xul3JECEiW8HRnhq9xvbqKZDpx+Jc2aQe749NqJVsfh1Mada9GuNJiIPz6mmgA5f5ZTkdWWCJKsCJWqkOlu5Hz6aNFzxaxO1kl0PDnrCALrCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcatjaxbWJiZe9IBj6jr8ir1AdXgvSQPrNlVLUu5iZU=;
 b=o+sEvWPziUe9PvqpJ5y5FXo0y2lqjPexLY+o0yzD9hDhzRAm3JFrLwWI+G0fhaMhJvAI+j6QEv5S5ZTSQCkQ+uNl/OvTC/9rnwFJmJQ2Bp/JSs4FGf8BGyyu5fgdFWuImNGjeRy9SpVwg1K5C5y+llk461/ZcXuxMi6FIVvC5PnAXGAH6YotbmYtDtVTe0X78dgac3hM61qhjCGgw3uXQ1Q5/nxYc7H+Ix4RC4paI27N+O0j3DxwYAsrZGggSguAU8pe+45USClBdo8AcLaZqD+Xy1hPwMPfBue+7VJAMt/DZRjOmNVn4r7MP3SGvZ/R0Qc72GT11DBh6aXzrwTsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 21:14:47 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:14:47 +0000
Message-ID: <eaba2ac8-2396-4779-9147-7066995899b7@intel.com>
Date: Thu, 23 Jan 2025 13:14:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
To: =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Julia Filipchuk <julia.filipchuk@intel.com>, <stable@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250123202307.95103-1-jose.souza@intel.com>
 <20250123202307.95103-2-jose.souza@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20250123202307.95103-2-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc23e78-01c4-4a66-d8fd-08dd3bf2f741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am9qNGlLL252dzlHU1VqZlJtcysyeGJZby9kQW1HTjc1WElib0U5VnVGMUov?=
 =?utf-8?B?cDZQSHBZSmFma2FhZ2lTVlZJTUF6R25iR1JRUlFwaGVjRTdkU1d4THBVSUxF?=
 =?utf-8?B?dm8rbVIxVjY1YUYwNHdmRVFqd21VdzBLVUF3NHBWQzkrNnpDN3pEV2pwMmdQ?=
 =?utf-8?B?UmZXbE5PSHVURVY1Wi9XZmpnNW0xVDMwbHIwZWtpM2FNamlCaStpUDlkVFNh?=
 =?utf-8?B?b2VlWlMzVCt5TFQzOHdIbFA5d2hrTlFDVFNLbFZJbUZ0Z3RNNDlTc3VCUGZD?=
 =?utf-8?B?YlFvMDlsbXYwMHhuMWpOVnlDV1paS3hTRjkyRkF3Vmo2bkpSdGRXU0U4bWVN?=
 =?utf-8?B?NW1tdkZxeno3N0F6SThpWjdWaWs2dkdsSjdhcG9qc203bUVkUTN0ejNVQ2g5?=
 =?utf-8?B?QTlmME9mUExNQzdKQjUzRERwRDVMdVZDejlSaUsrL21uY2VPdDJTSGhPVDZ4?=
 =?utf-8?B?Ulk0elFrSmJKZ1M5cmNzNTJONlFIL29pMnViM1ZxSUpnR25WSm91T2VGalpi?=
 =?utf-8?B?clpnVndYZDFnMUdLV2FhbnJETCs1TjFaSkNHdzF6bXMwOVd3eGNSdU9uZ3RG?=
 =?utf-8?B?Nzh0YzlIdEc5VXRwd2JaNzZVQ0hSNW42Znh2c0hkc3lQOEVUSml1aTFFZFdF?=
 =?utf-8?B?cExJMEFyRkw4dWdBcXZRT3dqZlFiakZueUtMZTc1aU94ZU9EK20zOGRqdmhL?=
 =?utf-8?B?KzA1dmpsN1RkYmJkYlQzcVp1UjRmS1BYTlB0OXlReXIrYW1yMnpadEdncFdZ?=
 =?utf-8?B?T3RxbG1YcmorbjIwYUhHQ0pzWkoyVmxDK0xZNjArdVlzOUoxRGpjMGJvSzRk?=
 =?utf-8?B?dk5QMXMzSGQwaWxzMUdXcldtYUxZNk8xS3pwejNxakFDNE0valFlYnhVeTRT?=
 =?utf-8?B?eWNHOEFERDNwMkw1SlJKQ2hncEUwRnZ2RTlaUzIwcXFtMFZBemxSdTQ4eGZJ?=
 =?utf-8?B?eTBxdzBlOEtRenNSWUtFb1dvMVJUVEZCM2swQlRlSjF1MWwwdVZBNWxvVDJv?=
 =?utf-8?B?MGwrNmxuYUdMc3ZYT0c0eG1qc0loTm55NGl0UVZadFNSSEFzQ1ZOTE05cXlW?=
 =?utf-8?B?NEZVTU1kZzBvT2tWdkY2djRwN0FZd2wybXNnc0VJRWovL2pQVmJlbklhZkZm?=
 =?utf-8?B?RkVGbVBFQnJ3RkdiUEYzL1EwYlU2QnppdFplM0kyYnl3WW5nNWFkcWxtUXJt?=
 =?utf-8?B?TUVBYktmOUNwQU44bG4wUkNyT2Y0MkRjSnRHOUN2ZWpnMVdvMVpteWd0UjVv?=
 =?utf-8?B?dnAvVFRNOHFQYWEvRGtQaGVvVFY1NjNHRjhRamRXTG1zYkt5L3NVTGRLbkVM?=
 =?utf-8?B?UFhXdzFVOGhJandielBweEtLOEdiQllSMU5STVJXWU1uUEJoakZUTWxXVk9P?=
 =?utf-8?B?eGVRMGNva2QvL3RWTEpVaVZpdG9PYjNleDVORGhjWGpROXo2OWFQMU5ZbWtE?=
 =?utf-8?B?RXBmL1V5TjJGZmp6RlRITENHd2dXOURNYjZkRWVHbGRUS1FEbUNBNXFWVWVE?=
 =?utf-8?B?UzZVdnhSTDJLb2hNOE81KzF2TllKMVVnNjJLTTd2eCsydDVIem5EekVicEdp?=
 =?utf-8?B?Ry92MHZlR2hLY1prR0hoUkJkM09iYjFhYWFHbTR5OWFzNXdocnhJVDFHWDB6?=
 =?utf-8?B?MmhITGZMbVZVRkpHeTc4RTFNT3A2Ump3L2tsei9WRWhHTGRlQVJidFQ1djJk?=
 =?utf-8?B?SkdOVnhCNWpyZm9uZ044ZWtjZUxhMXVSR2l3b0dveDVCTC8wVDBXcDJHT0tM?=
 =?utf-8?B?VG5IcFRXNGo1NjU2Y201alROZkNNVEF1NzRPenNDcE03TzZLQmJBRDd2MWFJ?=
 =?utf-8?B?a0VzcVkwdFdqbUdTS2l0Zml1OGNMVDFNcFRVenY4aVFKTHFpOWJhNGpsUUtF?=
 =?utf-8?Q?jvkq6uZCiEman?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckYrQjJhNExmMDBHWXBBWmdxTDh3WVlLeC9zelBPM1ZkYzM4Zm5hVEJsR1Vp?=
 =?utf-8?B?cjYzT0dLMzNnaGlEZ0s4RlRTVmdVMTBPdWdTRlNaUXFaYTdBNEJBSWN3UGdK?=
 =?utf-8?B?cmRjeDF3MlZ3WDVDU0drbXRYcTducDhxaVNlLzFjbEF3WmFjY01qVG9GWFN4?=
 =?utf-8?B?TXFmUzFlN3cxaC9zbWoyZUw4ZWhrSlBmK1h1dFpyNTM3U1ozb2YrVXZSUktP?=
 =?utf-8?B?NkZrUnVnNUozejVROXpzQUJwSit1dGhZYm0vUWN2ZjJUNHB0SFBpRVBIeWFU?=
 =?utf-8?B?a3BDampGc3pPb1BjOGZxY3l1L3J0UkVtZFB2YURCcTNGd1dPT2FId0JMR213?=
 =?utf-8?B?QWdZUXFFNnlMaGRwakdhYmQrNXJDQzhmTDRuN2FrU25FdEFoZWh5WmtYd3c4?=
 =?utf-8?B?REhKbW1keVJXL0xBVDBLSkVMRUlNN2pUaTZWSXZET3R0SnNISnF0OVNhemRL?=
 =?utf-8?B?Q2FCbnAzR28vbFFCdTdKNlFhanczR1JLL2tJcUtycWxuemVvSlB2VXM0Yjd0?=
 =?utf-8?B?bmJERCtoTnhtZ29MNmZxbWVKaFVLQVJPdUhqSXZtcDNmd25FNlJnaWExOWtV?=
 =?utf-8?B?aFpXOUZiR2syYWVQOHpvOWt0V01OZDltSFc0czBlQWM0aE1lZWRWUU5WdmVL?=
 =?utf-8?B?cEpYSGtBRUREV210R2crR2VONm5PbSt3anhITmJKT2Z2dnZyeFRtdDg3dlda?=
 =?utf-8?B?VVhsR2ZlYlNYRTVvQU85QVRUUXdjeWFXNUNGbXRyZmdOZ1kyd2RFTTJWV2ZT?=
 =?utf-8?B?eU53QWRJZVJwMVl2UDE4VkE1Wis0VWk4dkl6bHRwbDc3ZWtXeEZsTUJMNkpj?=
 =?utf-8?B?TmFsNjVWWmMrSDF4ZTNDbkZqU0R1emRuNXdrK2lLN3JlZ1ZYQXRrek1xSVV6?=
 =?utf-8?B?R21kUThRVFdhYm1mbzJaci9sdVFxcFUzUWFKSmx2dUZ3c0FmSGJhZ2tKQkg3?=
 =?utf-8?B?ajFxaDE5UUVuYS9OWXl1N3Y2UHVCWFRyVWVEVGFUMmtxL01WWEpWdlltYTRp?=
 =?utf-8?B?L0p1UWxwUndDejY2U1J5OHhFK1pzb3hJTzJId29hVSt4S29SOWlwNXlEZTdq?=
 =?utf-8?B?N3ptU2lQd25JMW5HdGRLTzRUTzNPaEgwemR2dUxmcVZGS29ES0tkL1p1S3dz?=
 =?utf-8?B?TUgwZDFRY0RtcjI3SFcwN1MrcDlDOUtieFUvZTJ5RFBLU2xYL0RPQ0lzam5w?=
 =?utf-8?B?aWovTDJhaVpKTWlZYUNvMWRacWdRRDNuQm5McStZS2pWN0IzalA0ZXkxQmo2?=
 =?utf-8?B?eUhzVjRXcXUxUDl0bThJNUJOWmV2Y1NVUzRkY1JicEtXNGVLaXNQNnRzTml2?=
 =?utf-8?B?a2JrVThtKzkrK1NrVkRaL1l0cUdscjdWVGhobzNFc0JEMWRRZVRNM1RTTWk5?=
 =?utf-8?B?NWFlWjh3RFFXNlNNblZxVWRKUlcwUzFFcEpkbzB3UWZsN0VZQ2hQTHV3U3Z6?=
 =?utf-8?B?NTNLdlJTOTRuMVVTRXcveW9ITVVvK0JoeW1OQm5jUzJkckptZ0I3ODlYVDdh?=
 =?utf-8?B?WU4xbTZQdE5LTHJTUDhXTWZwdElibk0ybm5TdDV6b0NzVFgveitXN2o4Z3BK?=
 =?utf-8?B?aXY4RzBaVThoWU1nY2pRcEM5c292K3BmR3QvQ3NqVDNHYmM4TGs0NzZhMUls?=
 =?utf-8?B?ZmdUVFpxY1ZtY0QycUhKb3lLazlQZEdwRmJxRDQ0bWgzOWZlT2dEaDE3RlVG?=
 =?utf-8?B?c1ZvNW5Ub3hJSWUzeXRQOWQwRDVZc2dHNS9NbnRxdGh6YVlhVTM4N2o4a0tK?=
 =?utf-8?B?bFplaXBJOHVwTGo0MjdkMU1rT3c4T1lIQ2NxanNvRDRrZXJUMHQya0k5bGxG?=
 =?utf-8?B?SXZFTzhVT0Ewa3c4UkRHbVRGNGNDUW1qS2FpU2Zqd2pGVE1xZGZKcWVtZHVQ?=
 =?utf-8?B?eFIwdzI1SzJGcmpvWDQ2MjBFUkkrMFRUZ0Y0T0t1aVIwMGhZZDRnc2dIYnNk?=
 =?utf-8?B?WFB0VFBLZTQwVUEvcWtWc0I0RGlmQ1pidFRyT2dYUHRIeGFBaXdwYTNTdHpi?=
 =?utf-8?B?SHdRY0twRXdxTXkvNytZWUREbkRyV2gxVzlpRFBKMkpESFhMOFZiVjQ2R1l3?=
 =?utf-8?B?L0duWUpGMlZqRnAvWUQrancycDRHdVFqSis1OWFzT3U2WlBMcHdwVjdoUkkr?=
 =?utf-8?B?L094ME5UelNWV3gyN05iMWNJeHpXL2NPcmt0am5hdzlnenJldE1qWExMZWhs?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc23e78-01c4-4a66-d8fd-08dd3bf2f741
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:14:47.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrP084K1+4tTm1QMieMrNP39/kmDnBm+flguJPUcmoTskBPZZdXyfmhXeu+LKpLg/tdI8cJ7B3kPJS+dLyeBSXpsI4RmVStXc3/foFZGe5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com

On 1/23/2025 12:22, José Roberto de Souza wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
> Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
> debug tool") partially reverted some changes to workaround breakage
> caused to mesa tools. However, in doing so it also broke fetching the
> GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>
> The fix is to avoid the extra newlines: the devcoredump interface is
> line-oriented and adding random newlines in the middle breaks it. If a
> tool is able to parse it by looking at the data and checking for chars
> that are out of the ascii85 space, it can still do so. A format change
> that breaks the line-oriented output on devcoredump however needs better
> coordination with existing tools.
>
> v2:
> - added suffix description comment
>
> Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
> Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_devcoredump.c | 33 +++++++++++------------------
>   drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>   drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>   drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>   4 files changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 81dc7795c0651..6f73b1ba0f2aa 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -395,42 +395,33 @@ int xe_devcoredump_init(struct xe_device *xe)
>   /**
>    * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
>    *
> - * The output is split to multiple lines because some print targets, e.g. dmesg
> - * cannot handle arbitrarily long lines. Note also that printing to dmesg in
> - * piece-meal fashion is not possible, each separate call to drm_puts() has a
> - * line-feed automatically added! Therefore, the entire output line must be
> - * constructed in a local buffer first, then printed in one atomic output call.
> + * The output is split to multiple print calls because some print targets, e.g.
> + * dmesg cannot handle arbitrarily long lines. These targets may add newline
> + * between calls.
As per earlier comments, this change implies that dmesg output is now 
supported as long as a newline is added between calls. That is very 
definitely not the case.

>    *
>    * There is also a scheduler yield call to prevent the 'task has been stuck for
>    * 120s' kernel hang check feature from firing when printing to a slow target
>    * such as dmesg over a serial port.
>    *
> - * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
> - *
>    * @p: the printer object to output to
>    * @prefix: optional prefix to add to output string
> + * @suffix: optional suffix to add at the end. 0 disables it and is
> + *          not added to the output, which is useful when using multiple calls
> + *          to dump data to @p
>    * @blob: the Binary Large OBject to dump out
>    * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
>    * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
>    */
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size)
>   {
>   	const u32 *blob32 = (const u32 *)blob;
>   	char buff[ASCII85_BUFSZ], *line_buff;
>   	size_t line_pos = 0;
>   
> -	/*
> -	 * Splitting blobs across multiple lines is not compatible with the mesa
> -	 * debug decoder tool. Note that even dropping the explicit '\n' below
> -	 * doesn't help because the GuC log is so big some underlying implementation
> -	 * still splits the lines at 512K characters. So just bail completely for
> -	 * the moment.
> -	 */
> -	return;
> -
>   #define DMESG_MAX_LINE_LEN	800
> -#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
> +	/* Always leave space for the suffix char and the \0 */
> +#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
>   
>   	if (size & 3)
>   		drm_printf(p, "Size not word aligned: %zu", size);
> @@ -462,7 +453,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		line_pos += strlen(line_buff + line_pos);
>   
>   		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
> -			line_buff[line_pos++] = '\n';
Again, as already commented, do not completely remove this line. It is 
an absolute requirement for dmesg output. And dmesg output is an 
important debug facility.

It should be temporarily commented out with a comment saying "this is 
required for dumping to dmesg but currently breaks a mesa debug tool so 
is disabled by default". That way it is clear what a developer needs to 
do to re-enable dmesg output locally.

>   			line_buff[line_pos++] = 0;
>   
>   			drm_puts(p, line_buff);
> @@ -474,10 +464,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		}
>   	}
>   
> +	if (suffix)
> +		line_buff[line_pos++] = suffix;
> +
>   	if (line_pos) {
> -		line_buff[line_pos++] = '\n';
>   		line_buff[line_pos++] = 0;
> -
>   		drm_puts(p, line_buff);
>   	}
>   
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index 6a17e6d601022..5391a80a4d1ba 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
>   }
>   #endif
>   
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 8b65c5e959cc2..50c8076b51585 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
>   			   snapshot->g2h_outstanding);
>   
>   		if (snapshot->ctb)
> -			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
> +			xe_print_blob_ascii85(p, "CTB data", '\n',
> +					      snapshot->ctb, 0, snapshot->ctb_size);
>   	} else {
>   		drm_puts(p, "CT disabled\n");
>   	}
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index 80151ff6a71f8..44482ea919924 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
>   	remain = snapshot->size;
>   	for (i = 0; i < snapshot->num_chunks; i++) {
>   		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
> +		const char *prefix = i ? NULL : "Log data";
> +		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>   
> -		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
> +		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
I thought you were saying that these need to follow the mesa requirement 
of "[name].length" + "[name].data"?

John.


>   		remain -= size;
>   	}
>   }


