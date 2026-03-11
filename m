Return-Path: <stable+bounces-224721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNdyEeOZsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:35:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BDD2676C8
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3DF33046AAF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A13E1230;
	Wed, 11 Mar 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHsimpcw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83431F99A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246883; cv=fail; b=LMLtqLVbtgP3SxGhvxkeN+ZagEfQfLDwfrbtcx1Ud8p31I131tuhLPPp/+RqWSYFq91E+o7+mliIpmxpF1yjhOftEKbl58pp82UHFQjx97DnG2Kg9o/SlLgX8BjZdB7ybIhykV2J0a6/asZKwxd8hLH13cf8BrN48IocYjdXsMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246883; c=relaxed/simple;
	bh=qIO6v2oR7ogw+d9iBboXKyG3kQBwKuehJqYJcyc79Oc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WtuWGehC2jWDYuzk+vcOtbOBH02bUt29G5sGkBxKzSQbUvMlvAu3vfv9DhfoxcJddgosRGVr5zHjXvhovPEJlV7OPPNpOBFCkQvStRu/QpcovkVT81FZ1SP3K4UukNC2ESuLhyknL9EDUPK+6thh/FtWbyVi0GB5AfaNAI84HsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHsimpcw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773246881; x=1804782881;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIO6v2oR7ogw+d9iBboXKyG3kQBwKuehJqYJcyc79Oc=;
  b=SHsimpcw0JPhYU2ruykkei+WtZqw9+B67V1eRBvuPUVvQ1MitZMJHWAo
   p6EmAjKYFGdHp2OcRlXXDHoDrIUg34/h6pZrtK5tvR3ei8gm3QER23EHH
   gQHiuiSJUGsHAWztaPzyd97UCGDcL2MK9NR4R/3IjMYHj/ZmSW+vT7+i2
   6F1BCTgYcLn8B4Xk2DJ7v8GUYEfRkviqDVmtl0v7sxRf5YW+1gDG4toDT
   /dVfvh1QpnPKdtBECpZPvzLd7HprnU17hqvweb4Tu7QEzFD1baFzm8bav
   lPAeaw7acLFq9hNCkOo9E9zdjcpaDEL3mpXebIp4qEpP/+tUWQhLqKWM3
   Q==;
X-CSE-ConnectionGUID: JwJHm3F3TXCi66PKHyPbkA==
X-CSE-MsgGUID: X5ovi7WtSLGAdsi4U/ZQrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74237447"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74237447"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:34:41 -0700
X-CSE-ConnectionGUID: ngoeJ+bDSDWuVJ34SchG/w==
X-CSE-MsgGUID: rvhTt51GShSH+n6wUZFddQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:34:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:34:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 09:34:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR8cZuk1Dc7tRgJMeJvhirTpBx+cC5KVcLjw0pt4I4bmuuQQrmm2AmgFiaXopKRnwcZxzFSvsHamwuFNfw/gVOSMHPH79fY9my01wKg6gO0EWorgisk8hSJb2C9kF44SG7QOSWUpAb1Im7VMaVVD6cx5KkqjkvKKAxmEg7es8DI1kwxglbFyV45dFwKhNm1xmHP5iHd/2wbzD3HhWbF15MfZp8z4WceSqny8zcpmgHSsPS02to5KPv7dtDCGfLSNKOxy6b1YrhN8Yla/lUcHZVWaj8JsOeT5vsDCVqcSdK1cMkUKCBT39bq5ySUBy015I7Ae8fZWKauHwDzWrS0enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDePc0NZ3P7oJEVNedn6p0tgfia2Lpx9sEXPr9pBI28=;
 b=K9zqoxUUOihl/i3eE6Ar14u8yfWj5ijUdgqjmr0/2xKrwg4laNRB5w71ISbTU9h1jDoOI9ZUnCS5+IzaB6Vh2F7hXFQu3HSCtAYSeYTccJW/iwnEd0HM+cdLjJeQ5OKzI2o9eqIWcWxadaHr2W+2iY318DZboWNY/Z3Emz2T9WTz9HoIJOLgEZhqgjnb+PoH8xNlawsEHPWoTGHTmMQh513u7Z+7gRDrqmUFiNITixaKNKkuel/0TK4Xrousw1v5RjOyS27J/aDMxdqI+a7YnMDGzm/Zb8vUvkuIS2Y3j+ec12LhqWbMxoRsyNuOZZouygxHu2tKGJ32OB+xDS2P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 16:34:33 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:34:33 +0000
Message-ID: <70fc23c8-a926-4767-bb8b-bf134a6eea95@intel.com>
Date: Wed, 11 Mar 2026 12:34:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] drm/xe: Forcefully tear down exec queues in GuC
 submit fini
To: <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
 <20260310225039.1320161-3-zhanjun.dong@intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <20260310225039.1320161-3-zhanjun.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e64aa9-87ed-45ed-2378-08de7f8c1359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BMjTRv7cPyHBsMYnfImobCeyYkq1jG6vZDuGtrHWYsgM8eBn63MJ2WYrN6Ea3PLbOVP/0K4UQkoVdgnUUwfFdOiNEG/qx6FFa18/o83RXCbwtOoB+amEiSH9rmJ9kcBUiVOCRBHGuSInxfoaqFbwILLV9pkNBDBWy7Pl0TN/iRkCIib5n1x9/OL8qbNshl3TmKuQV/0ECnVTyTXmfrVgrlEbob6L2xKI437w8RPTkap9Eab0523BVKvIN5oL42ZEkLvUvPrdZwI8MWVFyxDhWmlS2/T6wNdCeU1vwT6cch2IaeUbqE3ExW1ZD8fnFHZGsdN3zxS04dlhJYF0Cb+2K936NUanlIOI/Bo4w/8FhRbOFng2iLEdwtMgl4GhpDEsplmxWaIXv1SJHLsrexRFIPapiq8VNlEgZUCTUZD5yUIeybzG3NRzm613In6HV3bWNjE02iOK717qGpXCp10nxAtuKcMu9cXAdGWceyDA/HZEMfz1ZbxfRWOvUi2iQRJ4D0sNq/KjCVqK8VnBnoxWWvCQS46CbSh8VosZ/JQ2+iflCqWwhLkiK7zsEWV5araHAWHYLkPpwH9kTdVJrzfmYtw+4znh86dMyzd9CKV4VqSjHSZndsq9RI4j4RDbSj3lijwH3krL6afP46LmVJE3Z4ZbDLbPF0eWkmh6OKI8YNekOiDWrRjt4W+IVETs4jKFleka0rJyftr9+OZn+tgpF5Hg2TfwjZGryo+Rx0cdOVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZMK2xtYnNQRXc3KzRrQ2RVNGpXRzVBWkZJdC83Sm5PZUptUk1PNWFuSlpz?=
 =?utf-8?B?TFlZeTNNNUdvb2pxWlBTWnlidHRGWkgrZko4SW1WbzdXMmZ3ajN2R1Q0OWcw?=
 =?utf-8?B?QzhPT1JpZlBaUkNOKzNsVXlFbHA3c0JOd1F6S0N0UTJnbHhUK1NKSjJYM0h0?=
 =?utf-8?B?T1l6YWhkSUlYOVI0MzNsK1pEMmIvUlJ5ZGxoTlp3Mjk2K252Vm5aWUUyTUVL?=
 =?utf-8?B?MEplRHlmNVpiM2c2b2xXT3lsUzNaSzhEQWowM3Y2Y3NMdkRkRTVlb3A2VEFP?=
 =?utf-8?B?OWw4ZEVtVnNmc1pUbW56ZnB0ei9PSUhKQWNZVFVVKzBOQktaVWtIR2luMEQ3?=
 =?utf-8?B?bW9lWXN5TVpOUnRNdHlsQ3BuZUdudVh5dTNtZGh4VlJaT0FKZlFUMUhuV1Bx?=
 =?utf-8?B?WGMwK0ZvcUM0UUJHVnY5aUM3a3hXUmF4U3ZFclp0MFE1ZmdnUVZ4Q2dqSC9s?=
 =?utf-8?B?bHZrQzBYYURTZzc5ZkZpbmZuWGlYdFJoK2dySDdjdFlYWCtabWcxMGlXd3pp?=
 =?utf-8?B?SlBid1V5d29OYTduVjVuUi8yVm82MXZGdkcvRm9lR3FTTWVMdlNCYjNJdXcv?=
 =?utf-8?B?cDhNUlpYMUI0NkhDSjBMS2lEVXpKUm1UU2hwd0dKMzNKbGlYblRMRDk1cHp2?=
 =?utf-8?B?TytwMjlibHV6L05uRVNOSkJrUmNqVU9zejFqakJ4YS95ZWt3ejM5SHlzVlFG?=
 =?utf-8?B?WjNRd0UzNUlSY3laSFdiTWJKcittK1B1U1FqaHg2czJhb3p4Vk9mSzV6Tm1S?=
 =?utf-8?B?TytLdEFZb0Z1d3R3bnlrcWNpUTZRQXlDZHpBa2pzeHNDQzhwU1FJOGEyZTZ5?=
 =?utf-8?B?cG1STXp1Y0hoLzhEV2tiYTlROGZMUUc1b3gyczZoU2VyWWxuYU1yemhKQzZF?=
 =?utf-8?B?Q1JCSHpiUmxCNWdGbHAwbnlCZEVMV0lvL25pR2ttTkJHeHY1SzR0YkpHMHYv?=
 =?utf-8?B?TWhrVjR2dnRMWE1aUVNkUWRxSTVwQUc2OFF6YjRWTWhpalQwYkFLM0tCM2k1?=
 =?utf-8?B?R3AyYklueE9HY1NxM2JHVWU4ZDA0NmdqbndyZEFLTWFFSVF6dklIM2Foak5V?=
 =?utf-8?B?MXl0UzFjZ04yVDROdEV5dE45eHdJVmk0S084VC9ac3ZJa2V0R2pCZXpxUjlO?=
 =?utf-8?B?bnV3MjRxZEdWbndSUG5qbm1RRTF1YVRGemIzemJGR0NYMHdhWEJNSHc4L1FD?=
 =?utf-8?B?L1BPRWhhbnhCNWtGWldyR2N3dGk2MmJoNTBsbW5Xbno5OW95YjJueXU5UCs0?=
 =?utf-8?B?M1NSODdSdlIwNkw3dGFhRWFsWndGTTZFK1U5Z1ovK0NwRzF2UHFmM0I5TmNJ?=
 =?utf-8?B?aEV5eHBHd3hIaVhDb1FzYVRaaXFiSGhFVDdvQmdBUFphM2F2YU1ZbnF0U2dC?=
 =?utf-8?B?UURuZmVWeWNlbHIrQ0NGL3BpNU8zYk5qU2JIMmF0Sy9nZDZuaDJtTTZIendr?=
 =?utf-8?B?WEdYam9mMzY5UXk4WFFxS2RRUVJMZ1VFRlZvZmpMMnhxckh0ckRvdjI5TDI0?=
 =?utf-8?B?OGN6dW1mTWdxMlNQTVVBd3F6UncxTDNBcjRGWGgwSmwwWUdzVkdhUWRLZi90?=
 =?utf-8?B?OTl4Zmc4eHZKOVVnc1FtWlNyMU9xWDR3WmJQcWV4Z3AveG5iMU5mVlN1eXBr?=
 =?utf-8?B?YjdpT1ZWSXNReHAzSDJod3BOUUJ2QmM4VnJrczYrQU1GMDBhMlBpNzhLNGds?=
 =?utf-8?B?U1Z0MDY3a3ZWOTFIS2hNUVNJbFNFbi9hektPQkY2TkQvYXp3SjBjbkgxc29V?=
 =?utf-8?B?ZW92L1dpcXBLVzNpdUxUN2kxaVNFT0xTZlBuby8vNjRaQkdrTVhsQWtjanVz?=
 =?utf-8?B?OHVZRDhHNVZFKzlQRVRwVDVkMnFvNUVxcnYyMm1vVTNVZDMvN0VVcVQybStY?=
 =?utf-8?B?TVk0WW1PUzkraWp0Wmd1dGtqREVjekY3VlZIQmhiVE5RMDBTWW1ONG51K01O?=
 =?utf-8?B?OHRtdlpIMTBTMEdha2FiWUl4OXkwZjcvdFdCM2xYNjFRek5LK3hyb200OHVU?=
 =?utf-8?B?VTMybWJlRDhwQXRKRnpsMENvb2FtaTl2cjJiYmR4ZFdUbURPUzBlQkFPVzkz?=
 =?utf-8?B?RzFOSnRidXk3R2dEaXY5Q2xpakdHY2V1ejREV3kxdGY5cWlPTzlUV3E3ck1i?=
 =?utf-8?B?dk1uWnU5NnlobkhEbkh4NzZad1BJUDNKUEFwTHh5Q3hoZjk4amQ1NkF5YzYx?=
 =?utf-8?B?eW1PbGxOc3lTeG9ZYUF5MEpGOFREbXovMFdEdWoyME4vdm1XeXpMcURqR0kz?=
 =?utf-8?B?WGNvZ2xueUJRZ2c0eHc2OFYrN2VMbkQ5akdHSFAyUkJMcFVXUXRpd3Eyc2ZU?=
 =?utf-8?B?d09RU2V3ZFJaN1NSTnVoYXZsakJicnF0WHJ6d25mSHhXd2s5aGFNRWJ2WUVK?=
 =?utf-8?Q?8GtX/isaT5ilDrKI=3D?=
X-Exchange-RoutingPolicyChecked: JgE8ciGKUvs1OC0EfqX51JOS+OEN6RUlFE/AS80Q2HiUtAVzkrtYezzevEZEOGhZ4YrrTkTHpbb1QR+RjQlUbB0o/0oqzPeDekoXckmROcc4YQTpPLYP15kSWP1JqkNYbGcGM4PArtjLmIbe9vPsjsRZOOUMRZoS/xhln5ySmb/3u75kFm8OVj/F4Tvs6aOPjL1A9qfapjE2el5D3jzxbrb0xaaMrwfFT3nV3hxRQ55NWK1eTo2lxLbJq7cPXKakJjL+fdI9EXs74KGIn9DB6Nat5y2/1rzOs2aFL92Fpf0+IMWwIOG15spgBRHVhgVBu+F8fry/jYrv9ABFL5x71w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e64aa9-87ed-45ed-2378-08de7f8c1359
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:34:33.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq3n4zx1OuV+X2itVjpkIZfmOmlWO6reqiY2iYePu6b7U8/Cm2c7ggwfg9sBsjrFpsPbHPcsYZJJwp5Q5oDIfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224721-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B0BDD2676C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-03-10 6:50 p.m., Zhanjun Dong wrote:
> In GuC submit fini, forcefully tear down any exec queues by disabling
> CTs, stopping the scheduler (which cleans up lost G2H), killing all
> remaining queues, and resuming scheduling to allow any remaining cleanup
> actions to complete and signal any remaining fences.
> 
> Split guc_submit_fini into device related and software only part. Using
> device-managed and drm-managed action guarantees the correct ordering of
> cleanup.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc.c        | 26 ++++++++++++++--
>   drivers/gpu/drm/xe/xe_guc.h        |  1 +
>   drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
>   3 files changed, 63 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index e75653a5e797..f6964b8f8ede 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -1399,15 +1399,37 @@ int xe_guc_enable_communication(struct xe_guc *guc)
>   	return 0;
>   }
>   
> -int xe_guc_suspend(struct xe_guc *guc)
> +/**
> + * xe_guc_softreset() - Soft reset GuC
> + * @guc: The GuC object
> + *
> + * Send soft reset command to GuC through mmio send.
> + *
> + * Return: 0 if success, otherwise error code
> + */
> +int xe_guc_softreset(struct xe_guc *guc)
>   {
> -	struct xe_gt *gt = guc_to_gt(guc);
>   	u32 action[] = {
>   		XE_GUC_ACTION_CLIENT_SOFT_RESET,
>   	};
>   	int ret;
>   
> +	if (!xe_uc_fw_is_running(&guc->fw))
> +		return 0;
> +
>   	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int xe_guc_suspend(struct xe_guc *guc)
> +{
> +	struct xe_gt *gt = guc_to_gt(guc);
> +	int ret;
> +
> +	ret = xe_guc_softreset(guc);
>   	if (ret) {
>   		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
>   		return ret;
> diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> index 66e7edc70ed9..02514914f404 100644
> --- a/drivers/gpu/drm/xe/xe_guc.h
> +++ b/drivers/gpu/drm/xe/xe_guc.h
> @@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
>   void xe_guc_runtime_suspend(struct xe_guc *guc);
>   void xe_guc_runtime_resume(struct xe_guc *guc);
>   int xe_guc_suspend(struct xe_guc *guc);
> +int xe_guc_softreset(struct xe_guc *guc);
>   void xe_guc_notify(struct xe_guc *guc);
>   int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
>   int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index b31e0e0af5cb..8afd424b27fb 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -47,6 +47,8 @@
>   
>   #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
>   
> +static int guc_submit_reset_prepare(struct xe_guc *guc);
> +
>   static struct xe_guc *
>   exec_queue_to_guc(struct xe_exec_queue *q)
>   {
> @@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
>   		 EXEC_QUEUE_STATE_BANNED));
>   }
>   
> -static void guc_submit_fini(struct drm_device *drm, void *arg)
> +static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
>   {
>   	struct xe_guc *guc = arg;
>   	struct xe_device *xe = guc_to_xe(guc);
> @@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
>   	xa_destroy(&guc->submission_state.exec_queue_lookup);
>   }
>   
> +static void guc_submit_fini(void *arg)
> +{
> +	struct xe_guc *guc = arg;
> +
> +	/* Forcefully kill any remaining exec queues */
Shall we do VF bypass here?

Regards,
Zhanjun Dong
> +	xe_guc_ct_stop(&guc->ct);
> +	guc_submit_reset_prepare(guc);
> +	xe_guc_softreset(guc);
> +	xe_guc_submit_stop(guc);
> +	xe_uc_fw_sanitize(&guc->fw);
> +	xe_guc_submit_pause_abort(guc);
> +}
> +
>   static void guc_submit_wedged_fini(void *arg)
>   {
>   	struct xe_guc *guc = arg;
> @@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
>   
>   	guc->submission_state.initialized = true;
>   
> -	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
> +	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
>   }
>   
>   /*
> @@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
>   static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>   {
>   	struct xe_gpu_scheduler *sched = &q->guc->sched;
> +	bool do_destroy = false;
>   
>   	/* Stop scheduling + flush any DRM scheduler operations */
>   	xe_sched_submission_stop(sched);
> @@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>   	/* Clean up lost G2H + reset engine state */
>   	if (exec_queue_registered(q)) {
>   		if (exec_queue_destroyed(q))
> -			__guc_exec_queue_destroy(guc, q);
> +			do_destroy = true;
>   	}
>   	if (q->guc->suspend_pending) {
>   		set_exec_queue_suspended(q);
> @@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>   			xe_guc_exec_queue_trigger_cleanup(q);
>   		}
>   	}
> +
> +	if (do_destroy)
> +		__guc_exec_queue_destroy(guc, q);
>   }
>   
> -int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> +static int guc_submit_reset_prepare(struct xe_guc *guc)
>   {
>   	int ret;
>   
> -	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> -		return 0;
> -
> -	if (!guc->submission_state.initialized)
> -		return 0;
> -
>   	/*
>   	 * Using an atomic here rather than submission_state.lock as this
>   	 * function can be called while holding the CT lock (engine reset
> @@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
>   	return ret;
>   }
>   
> +int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> +{
> +	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> +		return 0;
> +
> +	if (!guc->submission_state.initialized)
> +		return 0;
> +
> +	return guc_submit_reset_prepare(guc);
> +}
> +
>   void xe_guc_submit_reset_wait(struct xe_guc *guc)
>   {
>   	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||


