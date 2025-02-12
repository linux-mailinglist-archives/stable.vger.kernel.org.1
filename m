Return-Path: <stable+bounces-115068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037ACA32B8D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5858C1884DA9
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA5214A8F;
	Wed, 12 Feb 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSe2yReZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416071E766F;
	Wed, 12 Feb 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377558; cv=fail; b=a+wIK72nM3at9intYmAPgrmFN7N5oNatfMjdVHGF3/r5AHt3AgGySVARzBiXwbvKLTcZ+mj0Xp4Of+YX1NfhejEHUBUwQZvMhY/ncmWuoUSHMQd/LVMfOyUP+cOJVKTWxALWDwXXuJRUEgm/2MQ69qrEON73W6xBxFR+tP037OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377558; c=relaxed/simple;
	bh=TSTgjtDXKgr2Ze43cekYbrEOXluj8nzKs+MmGWjGg+s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bXash+/aj6HAAlyB8S6m6LMSEuKjj0puolBWddcJu8JmizxXs/gUeYMkxhg1jepBHXZDElbH+hizXQlmvRzi8CQfdffvJaFCWZimI9xU/Xz8r0anNgc8gLTj8sHwTZsxj9odLQ+n/WAiQlicTTjFdxQjIdAdD1yl5OgfH6oAyZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSe2yReZ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739377556; x=1770913556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TSTgjtDXKgr2Ze43cekYbrEOXluj8nzKs+MmGWjGg+s=;
  b=VSe2yReZWHXNQZjCSTdAzunVpPWubNZjwZgwmoBhPUn3a7od9gjKWIGd
   QT6GVkMCYXh1Ek+w4rBAMdduW1L4Hjivo5HOtOHSd7j7ShrESIkpcLQiJ
   RK/q6lqjgJjHz0NqGF/5//rUEjdv4+kPC5ARF6CRTkEjNLzoJJukYomyP
   w4nsiNLe1vfRwduvtY+Volo05Y+MJ2PnPzNAKXarBd1XsaWyFCCetVrT1
   ZWGeDk8Ac13GwYLYLiCAhjKSWjEl+4/LXtYTYF9ns9ZBLVcn2AHcamqtx
   Y0ONqhXoCoT+Dku6pv3oeeGNBbzEMjKKalWb3iBGY7SXfjOxOoFGlw0tS
   A==;
X-CSE-ConnectionGUID: fmY55a51RLCBBQUIsh6ZHA==
X-CSE-MsgGUID: C0bQTJ2JTE+s+grrohJFnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="65402841"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="65402841"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:25:56 -0800
X-CSE-ConnectionGUID: SEwEQGBrS/KTlmG4Rg5ORA==
X-CSE-MsgGUID: 1U8EREF4R3W/4S+Up8Vbuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112723176"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 08:25:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 08:25:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 08:25:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 08:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfJuqDP8zfJbMlxXWNtVlofg60fYBf5SZRFVJIwnftcFRuRVQwWOxf6+Sc1Skym6fr6TtWp/MQ2ITHbKSITk4oOXnf89OLWWUvHS72RHaQ4EH51wQGkfrcOQu0587Xk2MTiH36L6VgNY5JeDYb2T5lwq4qhrHhLpRTtFpZk+Mp1eiEAL4Clkxhbuju3G3yfzz7z47NkBdr4y3ln4alYtTg81lSi/XvmSl6uk6WA+UrCmgeFnBWa5upKsy45nUEKfiNrAZ+9KxQW+JXeOGuIUo5IR2IDGE3Pf0fwSxGlEbVn2yx7x5qqJ8YK0zH49YAmGoa4MGoRMjRsb8cleRD9u5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI66j5WbC+XTDug3H3S/LfpKXFbF4kauZ3vif3evR80=;
 b=v531AnfkLkilGczQRbEYnROZVoxOqVWszJkMbvrIMeE2PPrqgnUnKYugesecWnkI3Hbo1b3kZI2nSHQUZChIqgBirn2QIDoBqH/TU6RK095g1EhiKIcqiEunF1NbPkDsYh7cZnBUTJWnOLNpJBvNPX+NDJcMn+cPBuCzQMAQg4MPb2guhpGJkJ16coZxLi2JMBc+DwARQrC3cczkScmkjjVDOm9dLArP1aFP6k67rqSka/Jpdqi5ZO97DjhvR81Hutof/tBxwEl5GXQ60+lyZqFLIhApvhNw2/UPOV77ldFLY/x9U5AmXVbAS5YgEqbBrSF42cckujK9RdAzMGyhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:25:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:25:24 +0000
Message-ID: <9b9f3b87-60a3-4ba6-aced-6a24ddfd0741@intel.com>
Date: Wed, 12 Feb 2025 17:21:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: microchip: sparx5: Fix potential NULL pointer
 dereference
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250212141829.1214-1-vulab@iscas.ac.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250212141829.1214-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c59706-4310-4504-a2d6-08dd4b81da5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmMwTUtlODUzYk4weXlBeWFPY09WQlhtcGNVeXZSZ21pVVBIMDU0a05ZK1dx?=
 =?utf-8?B?WVJKUmErcUVjOXlYSVJMQnJ6MzYxdFd4K2hwRVhEUmRBcUZSSFBzcXN2SWlm?=
 =?utf-8?B?bFhENG1UOFZRczlHZUhwVkpGVWwwcEFLelU4UXZoUXIxVkRJbks2dHhmQVV1?=
 =?utf-8?B?SnJ0d3E4MVdaalptQUhBOVRibDZnSDY0akhIVGdjaEE5K0xWVjlpVW9hTW1j?=
 =?utf-8?B?V0JhdHBDbCsyNDhkY2lkWFBsa1E1ZnZqVzRreVdQN09ZbTl6Z3pzQUEyNmJz?=
 =?utf-8?B?bHp4U212TFZSTmZjWnZHaXBnTVZXWDEvNEswZ2hiQVpMZlJOVUpGemM3dHlr?=
 =?utf-8?B?clRKaThUbWtmN0dwMTd5M1U4VTVuYTI5RzFrVzNRSjNYSEhTZDgyOWViTDQr?=
 =?utf-8?B?UDVRMWpEOXNnMGU4ci9vcmJpbmVOVHc4RGd3ZnZRWlVacllxRlpISXduSWgv?=
 =?utf-8?B?R0hSdXQ3ejUrdi9zMkFldExvUS9KU0hVYms1MzhTNFZDelBNUVJuQ3NlY0N1?=
 =?utf-8?B?ZGlkNGZDRXVWR1M0WU9WOHhFb3Y5Mmo3VTA5NjJlNURBREpSL2I2Qk9TQXNC?=
 =?utf-8?B?RDkzMnVyalRHK3VXenp5bnhaUS9Qc21Hc3M5U0ZxSzNoN0tveDNxQ3JWUFk4?=
 =?utf-8?B?YStjdlZzTjNZbnBpaVkxcWZtbGVVOEJyOUNEcGxKU003U3dBQlBFcUtEcWV4?=
 =?utf-8?B?a2w4OG41dGp2VlA4UVJtdytEU1Z0c1ZYYlIrU1E4ZkZla3VUU1Bta0pOZkxn?=
 =?utf-8?B?VU1QMFZBNzBoNnFSYW0zWVgxNm5VYWlEbFo5dmxQK21vYjQ4dlFCQnZsTFlN?=
 =?utf-8?B?dnpJSFFQaklFYUE1QlRnd0cyejVSNTR3UXc4dUtOZHN3M2t6RVRRQmtvMG84?=
 =?utf-8?B?eldDZ3RmMzNMT2VpRjJqZEtaQ1pJNms5OExVZXp5OFlxNGZxOFp0QnM0Nm4z?=
 =?utf-8?B?d1ZCbWdSQUw0YW1KVzNFM3dFOVpQSGE2aGluYkxqcCtwTHJEZEU3WUFDYitl?=
 =?utf-8?B?S0RzVnNJVXVjbTB6NE9rT3Z1UHJseGltbFk2N21SL0RQQWMyQi9CQUY2MDZS?=
 =?utf-8?B?K0NGTnAxTis4c2ZBM3ZKUkdtV2hMMlNuWmViZktLYmhMaFIyUC9QVUN1UUQ0?=
 =?utf-8?B?TVVVSWFub1MyTnNvSXhpaklSUUZVc05lWkFJMExzQ3JRU1A2ZVV1ZE1xdXJX?=
 =?utf-8?B?aDhWVlBPbnNaMmlyRDZCS2ZxY212OUp2eFBETGd5cHF0MGpJUTYyZkpiVFpC?=
 =?utf-8?B?SDhlYTlzdHB2MDY2emZ2a1hueWFqcHA1bW5leStBeFBHR1RVUklKeHo4VFJq?=
 =?utf-8?B?ZzhHUVdwT3UyUG9LaW01MkJZR1hYa1FWMFVLWDZFcXU3YWEyVDE2MTQ1V1ZE?=
 =?utf-8?B?STV6MmQycDdKY3ZtL2hmZzF0TVRpT1haRjhaS2dvN2FPekEzZ3pLaUt2WlRL?=
 =?utf-8?B?YktwaTg0V0oyNS92YUlLUEIvd1pqeUZBNkpRZGM3ckRIN09mZDlHcFVqMWFP?=
 =?utf-8?B?U1NNZnRBMTlGcFMzTHpZQmlOaG1UOWlyS201QmhieE5PVE81bkhHM09OMmZq?=
 =?utf-8?B?dFhSem9rdlFuc3JSTUpMNjlScGlHN05YQ05ralFvZWdydit1em5IRlhHQ0Vw?=
 =?utf-8?B?ZEVqTnA1dms1Z1NVOUhKVHYrcndhOUVOT2JZT2cvbTVUTWdDYXAzS2tGM0Iw?=
 =?utf-8?B?TXMxOTUxNElORmRPK0xka280aVkxQ1Nnbisvc2kzbnlRL1d4cHpkYzlYUlRj?=
 =?utf-8?B?YWhRSlZjK0J6bnUyNEc4ZkdoRjEyWDhDczhzWWVxUkRmTFRYODlicjA3ajVE?=
 =?utf-8?B?VWpDS2JLOXJUekdVYmtsWmV5akQ4ZFd0dC9SWDNpK0YvM1NWWlBLTlphSm1t?=
 =?utf-8?Q?DQAgt97+fvX55?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtWYy9saXJneTdGbUcxOCtWdlAyUHJoRGNNQ0hkUVlXODZLQk5YT3R5WitO?=
 =?utf-8?B?WVFSMG1FNmlldnBiS1VzVjIzRU1lY3dsdzNRZ1NkbDkvdW9FS2U3ajRMVmFU?=
 =?utf-8?B?a0g2d25tVXNaYmtrbGRHQ2RLOWtMMVJlVlNBNHptS3Ftdm1IUjYwQUk4MmdC?=
 =?utf-8?B?Nk92VCsrRjRrUWlGb09XYXVWV1JsV2hDd2w1ZlVrQ1UyeE5FaGQ5YjZZeGV2?=
 =?utf-8?B?Ym5WbFM0Q0U4Q3h2d3RvTkkwdmtiVnIrSndtUENkQXZnOG91WU9ndTVnTTFB?=
 =?utf-8?B?VTVMRkpsakdiaU1qSXZCWkFZdXFYYXpqM0c4M3QwdlZ5czk0TVdvekZkbE1H?=
 =?utf-8?B?K0x6ajdKNFRUQUxScG9jYkhvSjk2MVVuODJRc3B3clo1OW44WUgzRjNoeDBl?=
 =?utf-8?B?RFJiSzU5UGs3dk52ak51cFZSazU1TjN6MWQ0MkY2MFU4WXdOOUV4TzdQWG8z?=
 =?utf-8?B?MWNLYTZUcjFpTTd4TzNhbEt3L1ZtTDdTYi9XMjJBWHNRcWxCcjZpcUxtb280?=
 =?utf-8?B?OWlkRHpyWXkxSzYxaTFZUjgrQy82WjFObUtUUGlBYlR4bTJiejdWZlNyMUR4?=
 =?utf-8?B?bWlqakdvam5Gb21lRk80a0l1eDllMGgyZ2I1YU1OclZTMEs2UlBGMzB0akNE?=
 =?utf-8?B?Y2tWUXZZR2pndlZwRlByTHNLRUpCSWw3N0ovTXZEU3R5cnhGekkza29ISG9F?=
 =?utf-8?B?VEtzdGxLeGxYRXFqSWh0UTJMcVhHN1gxeFpxVFlRM2lnREZmNDVaRjhNOVJz?=
 =?utf-8?B?ODZHV21aeG9FVElyT1U4L1E2N2YyS0daR2VmSURyMjUxRnRRbGFVRGlubkh1?=
 =?utf-8?B?T1NLejNueDZ6c3VveUJkRHRockdhS2xlV3c4MlN4SUJrNHRXaHVlTlZpMytC?=
 =?utf-8?B?b3R3ZllUay9WanBOcUxGOS9OSWJKczExRmN0Q1kxTmN4WGhrUC9SdzlJNDJi?=
 =?utf-8?B?b1UvdGR3dktTMnNUU3ZUUEY0VEJmVUc0NHRxSXQwNW0vcXAycGhXd3dnSk9a?=
 =?utf-8?B?RmJaVEV2OEw0b25HRExxK1NVS0g1SUVpZ3pjMUkvaGhDK0EyMnl4VWU0MEFa?=
 =?utf-8?B?T2VqOUF3c1BMdjUvOXJwbUJpKzlhLzVTNlNvVS9PdFo3cnJuV2cyQU5yWTJ5?=
 =?utf-8?B?WnJGb09xTlZTcUNzOHpHVzcvU3dpb2VPV0RVTTdRUW0zRFEzemhSMnh3SFdU?=
 =?utf-8?B?Y3dqNWVZSTlPT0RJeTg0Q0FQRzQzb2F5dm1RSVpMVDl6RXZJVHVzc0c1ZXFm?=
 =?utf-8?B?blFDOTdFRm1yUzlPMytNVjd0eGJYZi9TT3NqM2tPMWttZU51YlEvMExqeGM0?=
 =?utf-8?B?WHRXbXNDY3pSQjFkZjhCdWJYTVFXZ2FMMXY2WFh6ZmdXdytDSG1UNUpvMGw2?=
 =?utf-8?B?aWUvR1RkT2dlYnhJeHVjUzBuZE5ta3psbEpaMzk5QzA0bGdhNENqN0plRzhV?=
 =?utf-8?B?d3JMTmVCZEsyc0Q1V1MvV09DM3RFSitGVitieitTWStISGZoS1hGWjhXMmtB?=
 =?utf-8?B?TktzRnVLT3hQREF3S29SL1NEZUtrYzhBcHZXaGFJZVY3Y1hmSW1NQjRKY05a?=
 =?utf-8?B?Y1ZXT3JzUEUveTB4NUN1ZVJEcjNrTytNeDBNRkFsOUJSZU9DQzlWRW5WM1Fj?=
 =?utf-8?B?M1ZZNkxNbXlub3hxcVFXY3dHYnpFYWJFYy80RGROcHhHQmc0dkhuOERwY1VZ?=
 =?utf-8?B?UEJyOWpGVG9waFU0MDdDMmdrYWFEZGlvVjczM0NTYVdxb2x4Z3FJNnlTNk1V?=
 =?utf-8?B?SFZRZUxENEtWSW5ITS9SRFUzZHphOHR2cUdraW9LTGlEMzdMRmsrZ1hCUGR3?=
 =?utf-8?B?TWViek5GY2RvdGxROFBBSEVhSm5jQS8vNVE2czlURzZkenk2QkRNQWtrQ2I3?=
 =?utf-8?B?bWtQRFBTeHB4REd2V1NhbGV4K0pOQTFOR0IzMW40SVJEU1NOY09rS1FIeFUx?=
 =?utf-8?B?RnhBREx2bDFRTkNNZ0dhTzZFaWZEQWhpZFZoRW1QTHlyNnBFbERXYzBqY1Zn?=
 =?utf-8?B?Rll0SUN0dnE2K3pvVUNVNTJvRGZpQnBkMTZOZnhsUkxzeTFCbDRXL2NhN3RK?=
 =?utf-8?B?VWNMYW5NRG55OVRVcStaRXNpa05YaGRPbDR6N2h3SFhuSW16SkI1WEdCTnd1?=
 =?utf-8?B?Qi9EMklNTVNHV0tnYmFQZnhNSVF6QlY2bkVpSHE0eVE5UkY5OVMwSVpHbElp?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c59706-4310-4504-a2d6-08dd4b81da5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:25:24.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aQPriOc0SMSwAyQV2jM7QQxv3Zx9SXsuUoIvyqTKOj8N6Q87zASJWMBiXvjRL3Tl4jnrHPzdWTBgOPbSsPJ24R2heOkV4qytihhv2a5SKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com

From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 12 Feb 2025 22:18:28 +0800

> Check the return value of vcap_keyfields() in
> vcap_debugfs_show_rule_keyset(). If vcap_keyfields()
> returns NULL, skip the keyfield to prevent a NULL pointer
> dereference when calling vcap_debugfs_show_rule_keyfield().

Do you have a repro for this? Is this possible to trigger a real nullptr
deref here or it's just "let it be"?

> 
> Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
> Cc: stable@vger.kernel.org # 6.2+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
> index 59bfbda29bb3..e9e2f7af9be3 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
> @@ -202,6 +202,8 @@ static int vcap_debugfs_show_rule_keyset(struct vcap_rule_internal *ri,
>  
>  	list_for_each_entry(ckf, &ri->data.keyfields, ctrl.list) {
>  		keyfield = vcap_keyfields(vctrl, admin->vtype, ri->data.keyset);
> +		if (!keyfield)
> +			continue;
>  		vcap_debugfs_show_rule_keyfield(vctrl, out, ckf->ctrl.key,
>  						keyfield, &ckf->data);
>  	}

Thanks,
Olek

