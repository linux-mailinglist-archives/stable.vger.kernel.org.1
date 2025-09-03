Return-Path: <stable+bounces-177669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03594B42C23
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C921725CF
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EF02D7DFF;
	Wed,  3 Sep 2025 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTUeWkxP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A2287518
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936296; cv=fail; b=edb0wC8/1gdicRLKiuPQe2d/iUKr/LOop4Ez8rS5TUoPbrdh9rJB59CNKnJ1F8rllefMMqUSKq2XdnqLyIeBbCrt31EQQk/8xA8RrDtH/jrvUMXqvEV5HCrbfXESBHUc8tp/r9FCSKW5qToV5IQTeZ9UNJdBojUdQtnm1M19PjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936296; c=relaxed/simple;
	bh=BNhphFR4JT9IgtzC4DzD5I5K2cc2wpX12OijZVW6Twc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SonBscsXJ5TR8qpXJ4GEGSChat3v8pat2NC/tX8dznahiR/p7hkUYkn8srOwaiTq/3/QPJGt+KaQLlZEOJMR9VyzdPcNLi2F7YGMFs3GXIRPuy9ejLO4C4/eqQgnW7TeBx8J1tAyzXjCppUL36lQVSj6Iosn2WHdvGV8qZ7D798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTUeWkxP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756936294; x=1788472294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BNhphFR4JT9IgtzC4DzD5I5K2cc2wpX12OijZVW6Twc=;
  b=DTUeWkxPu0dKwKMIFIionVFCxuuZpESqbOm+0313UNXX37fYNW22Da4d
   LsJVH7iysXdjaQoAlRAlOVwTNAOr0WXX/HSz/+9ITJHOo+TacUyKAoman
   kmwpZDHcrSwVyTosP78skZR4yOlqO3kTW+zhQe5eEG6zjEfd7qL0Ag9em
   AltqWC4fUdhMlsFqa51nMQmx+68dpkfowc475VfS1ElCCz9X6PsN92FKn
   Z2B1Z+JxE9QhkHAWDVkHgLHM1M6pc5b+94MaBQ4au3T1iMJFocZwuSUNi
   K9UrMZiLX7bb5wk4sDIFeW76LBxej8ArrU7pZHsP8sv9hm+mumapNoC/q
   g==;
X-CSE-ConnectionGUID: uASQBAToTlS8T7+gSWeYFA==
X-CSE-MsgGUID: qaNr3HGOSV2Bnf5kbRkqjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59333003"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59333003"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:51:33 -0700
X-CSE-ConnectionGUID: LKjfkgP6TLybi+AhHMw7mQ==
X-CSE-MsgGUID: zFoH4AcGQ4yiq3DVSt1K4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="202650059"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:51:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:51:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 14:51:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ+9yoTOdIbdK2shUmyIBrNTDFMFFYlRaLqlLZqTV4tnqMSlXvyg+J65NqGDkR3nm9JEl28eNTzD4UHeSaAJTKXATSmzZwibIrL52aXGAUQ+8+oJ+nHziOjZgwStLxEHOouUf7NXhn+gxsyMg0eauXePV3H6a0foyc9i2BTgeS1a29Z//jzOR8EbUs1ZcnYQZ6sEPgoNm8cnx55G7+pJ1wH2lLoDjy/rUXzsocVnAdArMqzGnsumbc2YT8auom5iuzLO23fI9LqU+PrIVXRDQxS2XSawLMrBA0iw8EFUJZtaeocBrnQd09Tf5DDjP0oa2hp8RjMq7RDu+80M++bxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNhphFR4JT9IgtzC4DzD5I5K2cc2wpX12OijZVW6Twc=;
 b=yW4brUMRFMSqyzmz1EtBTnli9O2Qyi5XHzlWrjj4Olw0n6dcLdmaEmDZevYntpN9ekT0AXLtTxSi6whsww9faNG2jlvimckqCVrVFCLz3mgl1fK9oAb9zLLNn2QzGIiKaSEO4CK6RlHpPVs5j9JtVznMQyzXkiIj0C4DkueAgCdxk6t5kbFp8D9p4UUG+aK9bk0ygZ+5E7V/XYW4qcdbPlsuOE60lU1WoRO6Ci2ABIBLJRQAYjQtBuM10lrDxEvRIj+0cOhQ3rk6V+ODPlvI3C6mLRkzcV417vu3VVd7PDpeMtGxg6QKEe3api0U5RBmqwK/ogFiJNC3jCBIB5c84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF89507EDE4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83e) by DS4PPF1B1B74C09.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 21:51:31 +0000
Received: from SJ5PPF89507EDE4.namprd11.prod.outlook.com
 ([fe80::d66a:6830:d9af:740a]) by SJ5PPF89507EDE4.namprd11.prod.outlook.com
 ([fe80::d66a:6830:d9af:740a%6]) with mapi id 15.20.9052.027; Wed, 3 Sep 2025
 21:51:30 +0000
Date: Wed, 3 Sep 2025 14:51:27 -0700
From: Matt Atwood <matthew.s.atwood@intel.com>
To: Julia Filipchuk <julia.filipchuk@intel.com>, <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>, <vinay.belgaumkar@intel.com>,
	<stuart.summers@intel.com>, <daniele.ceraolospurio@intel.com>,
	<lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
CC: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Stuart Summers <stuart.summers@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
Message-ID: <aLi4X7NsLL1iNsVh@msatwood-mobl>
References: <20250903181552.1021977-2-julia.filipchuk@intel.com>
 <20250903190122.1028373-2-julia.filipchuk@intel.com>
 <2cc4dece-7bdb-4fdf-a126-d9e311ca74e6@intel.com>
 <52d8cd5a-a3bc-4ffe-84c6-4facda290cdf@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <52d8cd5a-a3bc-4ffe-84c6-4facda290cdf@intel.com>
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To SJ5PPF89507EDE4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83e)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF89507EDE4:EE_|DS4PPF1B1B74C09:EE_
X-MS-Office365-Filtering-Correlation-Id: 3169d727-1cdf-4455-878a-08ddeb340a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFY5MmNwZXRGZ2hlWUhvODZZdkp1OENoNitSQ3BzQXlYYld2S3RvSlgySVo4?=
 =?utf-8?B?OHFmTFFXRlduUkhPZjBoUjB6NmpaSDJzZnJMakxpbzZMeGNrMzYrem52Vy9V?=
 =?utf-8?B?M0ptYytvbTJRM1dpV3ZwTXVRNUViZjBqKy9ML0JVWDFmNTVWN1JoZU1ucVR6?=
 =?utf-8?B?L0xqOEdRUXVGK25DSTd1cTBmZjJNTTNib3VzcnptbFV1K3lhWXhFMjNXS1lT?=
 =?utf-8?B?MmxxMGNLN0tNWVhOSWM2VGhmSkZsMkcvZVgyNEdESTlJMXpLVndTRy9oR3RK?=
 =?utf-8?B?ZGE2MjZOZkIzbGZNSFRENlRWVjNDMmVic0VLVU5UdVphSGNGMFhBa3RUZUx2?=
 =?utf-8?B?eUwxY2RyTkNidUY1VkJmMkxBK1F4cCtVMHU0VzhZWExQNjZTSzJWdGxTWmd6?=
 =?utf-8?B?aWI3Z1BONm1GckdmY3dnV2NGSzBiQTlBRWJoK3NaV29jdHk0ZE5McUNLL2RX?=
 =?utf-8?B?SzBQY21ZQVAwckI5Z3NhV3hMSzBsc3lRNWMyYjZHR0VVSFdNcytmc3B1eVFk?=
 =?utf-8?B?d2kyZkpEak1Qa3huS3hxTFlSVWRGN2RKRzl3MEczNmkwQm9CRnNVSjdRdEhV?=
 =?utf-8?B?VzBTOHdsQk1HWDBvZ28yZG55a0RQN2Z0Q1lhQnNSN0plZUk0ZlpHT1Z2cURD?=
 =?utf-8?B?UDBuc05jMlhIdlYxcm5HQm1tNWF2ZlMrTUxZWjY5S3FmUTI2cGtEaEZCSUdJ?=
 =?utf-8?B?QWMyaURQYkd4UWR4N29HQ3FJWHZYZUpwR0NyS3Y2Y0psU0VxRVkrMzJtTjdx?=
 =?utf-8?B?RDZTVlJobCtWYUNMOE5lTEtWcU9qdGRNZnQ3bWpSczd3TjZ5bitSVXJ1dU8y?=
 =?utf-8?B?YnA0OGNWSWtjeWQrakl6ZmtFaEFJMUtwM3hxUDBRL0lvbTZsTWtoMEV3S2Zt?=
 =?utf-8?B?RFRsVUs0TWN6RkJIbGViQWU4ZnJrc0hVWmhjQzRiaTZqR2tzaklNUG9mR3Vu?=
 =?utf-8?B?cHVJVktFZENzbE1jQllUc3V3THBCZWpnc1JuM2U2NklERGlPL3o5Nmg5V2c0?=
 =?utf-8?B?WWwyNDJIL0YxdEVQTDNkUHNlajlIVXFWSTBBMUJESFFyTm50a003cGpkMmxq?=
 =?utf-8?B?RXEyQjhzU2JSQ3dDamJVWisvSGNISXBONHVtQzYwWWgwem9TenVpZ2xOUkdL?=
 =?utf-8?B?UkpDbzdsL3lncFVuSUhCcGNwSWttVld6NkRFMFEwUGVYNDVGUktBSE5zTWdD?=
 =?utf-8?B?MFczb0tZVnRBc0hIeW9yblp4N09UbU9HbjhwSVZxK0ZSemJwZml3ZkRIa2po?=
 =?utf-8?B?UkRud1IzK0hUaVlTUG1yZFU1MnFRNlBoZU00SkxJaW55anBzVC9OUWtQejVB?=
 =?utf-8?B?aUh5TXIzSzNhZVdqcXZSVGJFOGROR2J2Z3pFMm1IcURDOEszNHJvUFM1Zy9l?=
 =?utf-8?B?YWU0bFhUVVh6QkROK0NWaHh6SnZUaVYxbWhOVC8zRTk0aXhMbnp4MExCU1dP?=
 =?utf-8?B?VW9zU1V4RytjTyt3NWVnRDVtMkp4d21YQ2U2QkFlWUpmell6eE85V2ROL3N5?=
 =?utf-8?B?dmE0bzVIRmhCMEtDZlJWS0owMTRvL1hIM2orK0hqcnQrYkJiUnFxbWczSVU0?=
 =?utf-8?B?a1NsdS9adUlXaXVRd2tzZ1FDV09tWkV4dGFsekNxSVFqenpJS0ZWYXV5cGZL?=
 =?utf-8?B?N3lrQkp6bTNEMkh6c1pQUTVvS2hvOE1ISDh1YW1rMnBGRXRqRW1uNlpnMTdl?=
 =?utf-8?B?QXZaM2RYbFVlQVJMV0YvcXhadGlSMzlxK3F5R1pOQzNQRWQ3L09xMDNJZGxh?=
 =?utf-8?B?c0d1L3IzbjJBWi92WUd1bldrbTl2M0xVSVpDTjFzY2tmQWo3MEFaTjFCa1RZ?=
 =?utf-8?B?Rkdpa3ZOdVlTaTZGSWtVWFMzMERFMXNDdnFFd0paYW12ckV0YXM3ZjQ1UkZv?=
 =?utf-8?B?dU9iY2FSTGd5NHdBVFlkSzJRdjBaUWFld1ZYZTlrWmNmMkp0bVBHS3h3U0Mv?=
 =?utf-8?B?Uzk4Njk1MDhiL241NVIxWWZZdzZycTJJWmV4SmhydFFSaEVBbzcyaVZRYUNw?=
 =?utf-8?B?b3JweDdSejdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF89507EDE4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1zUk4xUVQvNjZicyt3WVNraWNkNlZ3QUdSazlSOS9OQ3BMc0hIZnIyN0J0?=
 =?utf-8?B?YzV6S3pud0k1SXA1cWtLWm5EdStWRVc5dHI5VkdJMHYwNVVsOVMxNmd0Q25O?=
 =?utf-8?B?cGh2UWFpOXpwS1VkTEphQUR4Q1RidGhMb21Xa1UzbjVWRk5YeU9kZEZoSDMx?=
 =?utf-8?B?ZXg1blBpSVNZd0didjIzNi9NazFXZnhRbE1ZZnlCY28wZW43aGV2RkRjMW15?=
 =?utf-8?B?am8rQ2M4UVFNRTdxUUxNZHljRDg4aE43OGc0ZEQ4Rzl2dktUelp5K2k5NzNy?=
 =?utf-8?B?S0hucXRCdDhWZ253aWo3eEo5Y2ZwMjlZVVdHMmNtMXZuRDV6NE5mWjFoV1BI?=
 =?utf-8?B?bEs2NHpQNnp3bDBuSzlYRDdtUHp1eGpKK3JzMXB4b1hTWW9BaGIzNVhIVW5B?=
 =?utf-8?B?Sk5CVFlGZXdkbENRTzcyUUQ1K3Z3UmNhaGZHL2d2akRTRlQwTlYrS0JiVW8z?=
 =?utf-8?B?WjNqYmNQSGdqQkowcm43WDQ4TTJZYWpLRUVIRGR5UUgwMFRBNzIxMDlQNGVI?=
 =?utf-8?B?VHNXaXFrbTk5MzRsOW0velQxRjZSZVBDWnBIWU5YeGZNczExWkI4MFNKemov?=
 =?utf-8?B?TGlFTVhhUDVhU0NoM0FqVFB0aHdrbGlyWW82MW8vV2hNTEVQNGdiZEZFRDZk?=
 =?utf-8?B?bWhFWkpYV3ZIZ0R0YnZiWUYwWGZveTk0c2ZZSGlFZUN5bmhrOEV6cFhBekVn?=
 =?utf-8?B?bHc0WHJnbHpPdmtoZjQ3UGlWbDNsc0RpUC9LZTVnV3RVMnQ2aGZxU1ByN2p2?=
 =?utf-8?B?emJCcHVjSkk4MUcvQkpYditTZXpHWmhkRUg3aXl2RHpXSjVrRmFndXpiYmQx?=
 =?utf-8?B?SVlLZDJnc0hxNDVja1UxRGFIWllZYVMwZ0h2Z2lmV0NlVEUxa1NZN2Z3NlZ1?=
 =?utf-8?B?czVHRzZBL0JZWFg3dmxSU1RTUWRtNHkva0lTdldBT0p4SkdEYytjQlorOTM5?=
 =?utf-8?B?MU9wWUI3MVA2N0dQVGdTeUhYTUhKSTI0SkdVemRzR3VBYW0zTzVTTGpNQ1VT?=
 =?utf-8?B?RVRlVUdoWTQ3TDlXQU1BbVlZWEo5S3FpYkZ3dDdnTkpxNHg2cFI1Z3VwYml5?=
 =?utf-8?B?TXQ4clNqZU82ZWYrOXZ6SEQ0c1dTT2ZIaXMvdGhTd0NxSjJFTmU2QncvNmZ5?=
 =?utf-8?B?akx6amdCZUU2MlVTZVZhOE5tRGtiZGwvTjBXTm9GUmZENFNhZ3E0UTlKckZC?=
 =?utf-8?B?Znc0cTdMdnViak56ek5xUURlTDhvSGRMR1JzMU1sSXpzdTNwTWU4N2VkUTlh?=
 =?utf-8?B?SkpEcmpYMzBUK1A3UXEyVG5yZWNGKys1M1NjOS9ZUHlQcTFmMERFejhvUkwy?=
 =?utf-8?B?RmVueW1BbkQrVGJuNGRiWjRiVDhYOGRRb0V3QVFmc3pkZjEwUXlpemd4eDJJ?=
 =?utf-8?B?U2VxYkZpWnUzWFFoN2JQSW5BbFZBR1N6ZG16eEZPQXpjRm50VXcrL1hOREhr?=
 =?utf-8?B?MU9uTWxJMFhEc1RoRE8yNDEyYTZld0pGU0pYNXRlSWZNdUJWSzNTY1lyTU1N?=
 =?utf-8?B?WHdhZmRxaWozQVNtcXlLSXRjaXlSQkFYM29PMCs2QVFDVFlyQ1prbk5RVlNP?=
 =?utf-8?B?SC90WXVoRXNCcDR0VXAweEt0UEJzbUU0VHcvSzlyZUdLSGVxRVRIQ0FucTFO?=
 =?utf-8?B?Y1MrWnNUcWQvazloUTZDQndmZWJhNGNCR0M2NFlPaU1mU1lBY0hIcWlrbC8x?=
 =?utf-8?B?VE1ZT0FLV08rYWJLdEE2R21TT3FEcUx6bnRwYUFxd3dkK09CZjNVUTc5U2Fl?=
 =?utf-8?B?TnFSQjJyUUV6WUtUeWZHalBmOFk5K0ZaRHNhVW80b2JOWUIrRnMxa1R3S2xF?=
 =?utf-8?B?bnliNzNacE1ESk1SNU81SVQ4aDI3UThNRFZoY3BVdkJUWUpUQ3hJUTY1MXdv?=
 =?utf-8?B?UTJ5VHZvUXkzVUhIY1JnMzZRaTdXazdtRjh2NG9Ua2ZEc2picjBIclQ2ZDZF?=
 =?utf-8?B?dzVjK3cwNlZMWG1jQmxCTWk4UkhwYlBVRExkVnhCUWVuZ09jWGg3TVZhOUFE?=
 =?utf-8?B?bWlsTHBsVFdXUG1aeXJjcnU1L0F0NGd5bkVBSlZTZUV5YldQblhxc0E4S2Na?=
 =?utf-8?B?VDVndzRsZHVKYXMvNTFKcmoveGhVRFVxVGVzQzd3dnpob0RKSEJkeFlIQ1Mx?=
 =?utf-8?B?bmFpN3JKSC8xa0tLdm1RSWR2ZklONGxXRExObTRybWxUa0R5M3JHTnY5RzRx?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3169d727-1cdf-4455-878a-08ddeb340a9c
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF89507EDE4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:51:30.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8cQ7HL++iFA3ui54x0n/Mos//zSidAim5GxrE1kJG8RxPp3bnWTfqjm2Ki6Jrya7FBMwnrxphYaDsfWn0w5QpLFvIcnP+1QFJMeqn6UMew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1B1B74C09
X-OriginatorOrg: intel.com

On Wed, Sep 03, 2025 at 02:29:54PM -0700, Julia Filipchuk wrote:
> On 9/3/2025 1:28 PM, John Harrison wrote:
> > Does this count as a fix? If we are just extending a workaround to apply to more
> > platforms, that is not a bug fix of the workaround. It is more of a new platform
> > enabling patch. Indeed, if you send this patch as a backported fix to older
> > kernels, those older trees might not support the new platform. Which is
> > therefore unnecessary backport work and extra confusion because the tree is now
> > claiming to support a platform which it actually does not.
> Possibly not. Just intending to send this to the current mainline 6.17 with
> backport not necessary. The workaround would still apply if ever loaded with
> older kernel.
I would like to see this to get into fixes and brought into 6.17.

MattA

