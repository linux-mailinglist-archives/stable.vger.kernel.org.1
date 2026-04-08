Return-Path: <stable+bounces-233771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNYXO3/41Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:41:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B33B7AAB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30661302FE8B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF9366062;
	Wed,  8 Apr 2026 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nr9hTbzi"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5E3644DC;
	Wed,  8 Apr 2026 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630389; cv=fail; b=PlMF3ywYxb1m+vLV91FPcF3e5jRr4k2GXQt+jWPfDaFuHrvaFq18FFOjuEbURfB0pA/ZtouB0XmfmRNcMvZlGSeplWOJfZScOb6wIFlEl8rHB0tkDtbMcFFHKUJwaEuOg7U3HHW2hiYkGtnitzVsQ0hvgIp9wNDGj5ZbCVZxhTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630389; c=relaxed/simple;
	bh=jKbi+8W6hC/9uR5poAqXQTZbrog+HCrkPT70FyuqNAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=faWdNsbfXDWZnY3o1sKPCwGCw2bElJKCKhE0j61oA4AMNIt4A5Z8ZD+FDt2SjQ9jDnVXAtT8HE7/1tbFMRz9tRce0pW4HbMCMYFHQLdroBLKXZAImUDL0J0fX88AUmVohRja0j6vpkcJ0WvbJmtyehF2Ot99rVutO3F87yflHFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nr9hTbzi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775630389; x=1807166389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKbi+8W6hC/9uR5poAqXQTZbrog+HCrkPT70FyuqNAk=;
  b=Nr9hTbziqVWJQFxODxXd0RYk3staNP1vEaKJOkZVTxtWLB2AqIhdqLL9
   sg0kQZXa9zROfrUquWafEM8H79BqhZjWcMAQE2tBR2GeTj31CAndrD6cW
   Ijx7H4KuzXZwz0MfNt79XXUvNr5lgy6VToOINyTqpkD2ixDpOSNu8eB4X
   +kQIRsiM3P4wGmGfwrkzoRYvO95AoxmHgkl6mBT8KAQNYAdOBaTQVMeVE
   Law/zdgAZSrtVU6ZaNS3pASEwgOY9fFT2JgfZv+WWFhApMBxcw3BxJP20
   FQqFBJ/pz2h7z8Du278dSVy2BYdaWIN8w6ubg4Ywa4ydcuguU+iWaOBLH
   Q==;
X-CSE-ConnectionGUID: LAC9z2IuTgyaUUh82cpgSA==
X-CSE-MsgGUID: PT1lOlzWRsCoKX++KAnt6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87989015"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87989015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 23:39:48 -0700
X-CSE-ConnectionGUID: RnjWLKZKQNGEKzI/F/LJ+A==
X-CSE-MsgGUID: q1K8nY8bTw+/Lf4puHbhYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="258815516"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 23:39:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 23:39:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 23:39:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 23:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMOVqvRPSNcTum0TH0tGHnYfRoCeqLjQH60Da/oAmlvZeGeQyYSG2YDbTXsozpmGM84AB/pm5xuDtu/N7PtxX0Lq4JzNxU5PdKHwQFExu8MGxyhqSv0+jK1vQrZ0c9Cd0WwDvUJWJfayW8p1xVDqvzlWtyxonI4rQ+w4MXFBVwXosi/LkS6iqJyD4cDQDdWRSsEODszn98EMezC1Ox0xkx/RbGois7kV5vnWWb4ndrYH0fAJB5MjMfmhh44dqnxthe4fyguxFeZx/jZ0D396RVCpJ18147NE6/zmmllGe+b8nSYHz0Lahl1MrDKtt6qlUpWTvVFAE8avJEkZJcDb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k7Aq6xuXdHMy2cZpQbznLYMNdDgVxvrwfZNKqBptR4=;
 b=AXNMTEVH4uXSdRdEf0QBcKBW06b7JUYNRFWWzwQ1eJjKUMXJvWljAjyeV5wv80mRK31ejv9FIZX+xR0CGQqct/oO6vtnB3hqzVdV7MGrulGEz4mhpMU/WzbpJ4Dq/8eBtwC16pZ+BhMN9MMjrqKcArxGu/YHqg617goaTboOBmlCL7/iGUEPEbczlI9d97AHVDjA1pIfxbYqtA00zcjZZEvHJpIUCp96x79mVeeDn9xE/w73938EPPWr5ZxMFft99/mFhQQeTZg45IXkYtyLLhuT/aI6WRdGjjv4wBoGPDMjbgiEbDKbOLtdgkVv4W0QyLW7NSJ115VJpKN90sFL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Wed, 8 Apr
 2026 06:39:37 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 06:39:37 +0000
Message-ID: <696a1d25-bb79-4ddc-942e-196ff2e5a93c@intel.com>
Date: Wed, 8 Apr 2026 09:39:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Disable clock before DLL
 configuration
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<Stable@vger.kernel.org>
References: <1775629564-11267-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1775629564-11267-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c1b403-516b-40de-486f-08de95399a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: k5RRH1Rb2/AkSrEtHbCUxR61oYWQP9YjywaO1HNJLADI3npeYsco/RKeHCOgPD+SjFLg81MD9E4D5r5/P2tW9uVoQXNvpnn0TqBu8FXF9K9SzhQiUCsMym89RCd3P8aFNQdHg98qLMBtvqFd1wKTNTyrsp55n3QuFQNw18DYkxuC6uoINlnvYEFiMQzhuVZ3Vf8C3CnrbkuLXxn/st+PpCNGnAowFU3bu0hS6B7+GBs0rCIAueXzP5NlUXMnNiegoCIolAlkGyvnuELKZ5hMX1O5AC/8Mbf31HI60xF4hMd7AxNjvEufe2B6EfNy3+gsfXTF6/4eHT1T1Z51vVtMeEl/A/Co8J98T5gwd+O3ab+En9SEpSX4bOow2qaF4QBIbzMxoQT4iQ5T5llhUEuYxrRSY7//TNdHy0DTGwJ/gsJDe6vWb+K0J6nh4XBT5LQvwEMDDdwhO2gZyGPQR2ZSxrDTLc4ToWcxECclZYU/TET09FLQYaODCHQzlA9y0grk9y1OdKKgk+KTZnNbeKMWEOVy8zegic3HzsK6sMs04dbFPKShPrkDM4UjUvGTpgmR5pIYkQeWSOF+x12A9kCihdpD6posCHil754fJr53fop7zLTjvNGF9d4shY0BoSukxK0p4sgHONtrw7t1EHFZyEk4Vt07Ur8NQ84GgoABphb6nrRxxxgLdvcIiXbcgRhblGFZ4tnLjkjOA8/M2yqZt4cYS110Gm/mfiMa7jWbcm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRrWHlpRytKWmNmbVNtc1ZUMUl4Zkg2cEYvVWJMZC9pYzh1TUJyRVc0bGlR?=
 =?utf-8?B?aVpxclBpZ0hpR0s0Z3M2bU9nclNUemhkbWs0N1NwT2tNNDJCL0UvNVNveUs1?=
 =?utf-8?B?QmIrV0c3elhxWi9vZmJPYWR4dlBsdW5JKzhCYlFmZmpWQXlSVTQ5c0o2Ym9T?=
 =?utf-8?B?QU9xV2JleTBscHRvRVpJUmt0SUpVSnhTbzBlTzRMZkRDd0VkZGk3NzN4Z1VC?=
 =?utf-8?B?MHBTVzRkZm5BTG1ZQm9OOVZUTUhuc0YxaHg1ckxRSXcwM0NldjNKWkNHSFVN?=
 =?utf-8?B?RnBIVlFTNEdrU0o4cGx0cEtXWUVwTHhCb1RvTVRMME8zeVY5L0xEUmV3eDIz?=
 =?utf-8?B?bDVjU212blk4VEdZaElnWmJnWkNaM0NUY3JmQWNGWW90Znpiam1aZ0lxT2x2?=
 =?utf-8?B?aEEzVTBiZTY3cDVJR3prSmRmSDF2ajJVNVEreG41cTZaUFBMSExacEhOQ081?=
 =?utf-8?B?NTFjZ2xEdU5uUFpDSnNTYlNlY1o0bDQzUXA4UXYzOXRMbWJmcGd6c3RzRjI1?=
 =?utf-8?B?WTZiRDlyRlNpZ0JDOXlmaGl6TkNmQXV6aUxYY3AzVHo0WVVYOXRkUW5TLzNr?=
 =?utf-8?B?cFFvK25abWN5dDJoZ2RibnAyNXR0ZWZYT2tGaGZ0UzBBbmdCbzU0QzZsVDBy?=
 =?utf-8?B?b3BSVmlMZ05XTTlhUENwL3JNelljelZOQldLZmJPLy9iemtyd0pFTTNEZWV0?=
 =?utf-8?B?WFpwaktyWnVVTVRKZCtnSlpRTUY1VHR3M3lxeVpWakRxaEl0WFlBT0pVS1R6?=
 =?utf-8?B?SHAyVzJLRkV6aS9yeXhBSFVOVHlwaXhCbmFLWmQzNTcrd1BxZ3VNdStGaUZM?=
 =?utf-8?B?OE9Ra3A2bWtENGNGNU9MSEE0bkp2akRhc2dRRTRteWI1QnNTbUlpSTFDNlND?=
 =?utf-8?B?c25yb0F1bE52clNWcU11MkF6UGhxdjdGdmtJU0FYS0dmbVpldkZjSGZoSEds?=
 =?utf-8?B?RWtwOUlQTE5IOVVGengwQWJjbTR4b2lLb0NjdzU0ZFRQbzJpczBwZE8yRVBh?=
 =?utf-8?B?TnNaczR6UXdRYnY4U1ZEdVM2OHoybjdlby82MGFoVGJXZjZBb040RzZQaWlY?=
 =?utf-8?B?Tkp0dGFjVFdDazY0cEFtUlZoWis1VmZqblJkVmhka0FBRngxTktOZ01hUkVo?=
 =?utf-8?B?UDdBVHJGaUMxQ1daeGNUNkk1eityTG16QTBmZFJSK0dlWVlYMTJxemdDZjhh?=
 =?utf-8?B?YnJPUEZkWXlSNDlKODZ5VG9FN1A0YTU5d0tidlBKbG5IWVVNQ01xTU14a0RN?=
 =?utf-8?B?WGFpT1BsWHFZaERuWVIyOWZITC84YmpQdHpSMmJkK2gwWWkwR3Vkb0dCSFh5?=
 =?utf-8?B?cjUyaWtKQ1BLQ25KOGZhOWRjM1NNazZ1MUFxZzh0b0lkTHM1N0pUQ3NIRGNZ?=
 =?utf-8?B?TTdMSWxEbmtqQ1I0VU5Bb2prWUVBQmpqUzBZN29LQ0psOGxTS0Z3ZG8zWkpG?=
 =?utf-8?B?N0t0ZUhVdUIrWEJZN3YzZUlvWGxjZ2lPRlU5Tnd2cGdCSS9CeTI0MityVVlZ?=
 =?utf-8?B?RUFvZFRjQUlpL3R4dlRUUzZubmRYdjhBOXZISWRTMXJhaE9aakxjanlsSXdH?=
 =?utf-8?B?eGtvK3kvaGhXVXRPdStLL0ViNTcxZlNZS3NqckNhY3d1ZW5WU0dRaHYrMkxi?=
 =?utf-8?B?WTNGdlpUS1N1cXFlMXY0Rldmd2FLejFXT1hLQVhyM3lsbDBBb1FIRDF3bGxv?=
 =?utf-8?B?QTlmbnRqeWJMaVFtRXh3MU53Q01kMENGMlJweDdRdzZ4eGJCTzFJV2VGU3VM?=
 =?utf-8?B?dGxYTGYydzVnM2lUbUY0QVplQ1ovb3Z1Y1dPZE9tSTREcHphWGlWRi82NC84?=
 =?utf-8?B?RlRrN2hURHM1RmUvNk9BQmczNy9ibjRhcER2b1hhbkVkT2tmV0hLTE1KOUNY?=
 =?utf-8?B?QzVNMFB4MmpCUWQ3RXQxNDlMcmJPYllxb0N3R01HR2cyY3hZbk8zanZ6Smpy?=
 =?utf-8?B?bXBnZTZVLzUzbFlGcURZa3BKT0VJS2w0cjBNM3RIbHFZNzdSTWdzcHJ2emVM?=
 =?utf-8?B?VElYSHQ4STNDV0NaWHpyd2NLRW1vNjBtc3QzNkdLTUZ3VFQxK0tOaTJOcDgz?=
 =?utf-8?B?K1h4Y3BlcFMvZ1NsVVl4U0Rqakpzejh5SE1MbktCTmhWZGFSamswT1JaNVBJ?=
 =?utf-8?B?YWgzRis5Mmk3Vy9zNTNTaEpvWkNoM3Q1MmFtbVQ1eXZzVU9UZTVoSFYwR3h1?=
 =?utf-8?B?QjB0eTZmQkxIVFora2xQYlBYaGJva1JySU5UdzJGV1ZQbW1nN25XS0s4NzJy?=
 =?utf-8?B?eWxyMTNCN2x4QW8xQWxEMVQxbWUzbXlGLzkrQUswN0hmcWlPSEdKdDdJK1lK?=
 =?utf-8?B?R1M3Zi9TQ01kaEpaZlhwTjdxbjBQT2hWblE4amtRUXp1T1pTZjhISU1UOVRY?=
 =?utf-8?Q?QWNydU8tln1bRRFM=3D?=
X-Exchange-RoutingPolicyChecked: O9Rm/fs55AZN4fWtkv20T7LdHMCjTPP6Q9oYhif3zGL2cSR5gSI9zBTMHCjVbgnI/WL1360jie5SE7FBg3X7F2Pf+yzmaCTM/VK02jayW2ePe5qH36S87sviwOqw4XiMLx+Mz1Hpa6sDvD2lcR7vsOsOYcGIfbMRePWaqWKh1wwsQF84jKYdo9SkFMtiS3j2cxIbcgnH+OQZbunvLoa65/QXch2tk4SFXsOtGoqpMUeOVicG268MejRFMNx1BAt/0oODbdLCNKQESRIKDP3+Hmj18mfq/pxDgnQfh7EWIQ1rhdepQBnOcAmxV/Ac72khR8rZ4lWcyWGcM5qa7MQhTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1b403-516b-40de-486f-08de95399a82
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:39:37.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFrx8BeejmsDKJwyy+hYSV5odwPK4Mymh6xiKsFDvxIvpDg0C078FFFP77CEXzXjt/uiZ5I2cLmYduuqarUKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 974B33B7AAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/04/2026 09:26, Shawn Lin wrote:
> According to the ASIC design recommendations, the clock must be
> disabled before operating the DLL to prevent glitches that could
> affect the internal digital logic. In extreme cases, failing to
> do so may cause the controller to malfunction completely.
> 
> Adds a step to disable the clock before DLL configuration and
> re-enables it at the end.
> 
> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Missing colon below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v2:
> - Add a comment about why passing zero to sdhci_enable_clk()
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 6139516..5af35c9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	extra |= BIT(4);
>  	sdhci_writel(host, extra, reg);
>  
> +	/* Disable clock while config DLL */
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
>  	if (clock <= 52000000) {
>  		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>  		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>  			dev_err(mmc_dev(host->mmc),
>  				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
> -			return;
> +			goto enable_clk;
>  		}
>  
>  		/*
> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  			DLL_STRBIN_DELAY_NUM_SEL |
>  			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>  		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> -		return;
> +		goto enable_clk;
>  	}
>  
>  	/* Reset DLL */
> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  				 500 * USEC_PER_MSEC);
>  	if (err) {
>  		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> -		return;
> +		goto enable_clk;
>  	}
>  
>  	extra = 0x1 << 16 | /* tune clock stop en */
> @@ -868,6 +871,16 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  		DLL_STRBIN_TAPNUM_DEFAULT |
>  		DLL_STRBIN_TAPNUM_FROM_SW;
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +enable_clk

Missing colon

> +	/*
> +	 * The sdclk frequency select bits in SDHCI_CLOCK_CONTROL are not functional
> +	 * on Rockchip's SDHCI implementation. Instead, the clock frequency is fully
> +	 * controlled via external clk provider by calling clk_set_rate(). Consequently,
> +	 * passing 0 to sdhci_enable_clk() only re-enables the already-configured clock,
> +	 * which matches the hardware's actual behavior.
> +	 */
> +	sdhci_enable_clk(host, 0);
>  }
>  
>  static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)


