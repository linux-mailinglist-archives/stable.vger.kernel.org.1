Return-Path: <stable+bounces-148161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D55AAC8D7E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D9E1BA6243
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A522B597;
	Fri, 30 May 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJCJLP2K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6410F1;
	Fri, 30 May 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748607999; cv=fail; b=ayZZpnX5C7jMxk6xljEhvU5LRzaA6QFf/aARrSMHCaSUS/mL4PvjnfkJ3QK35eRUsknbeYMHe4IONJztO7Q+DwVq+KneUj65EMbd6bdhu6AfaEjbAoX4LIUl9QMZ0M7DT7Su/n0DKHnQT9+jhXpF09NdFETW7h5FIKbOmHUYzFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748607999; c=relaxed/simple;
	bh=kWDMNC6gz1RQ5m+Cp7ihyfYoDc7Njv8tPJPmKzJu2u4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WpILVpcIUm9UlyCTtuKM2qMQZG9GsGAwARCHKcNB0d85rUS6YR+w3UMc9Egyg8zwBA5HU4VV997yXj611YSPc3J31FwsJ8ocJjisWTZw2KQ/VeqOJ2r0zn106n2SWo/9jRXSjldOQ1A92nUuIzxb4/zlUrpG5wGgHsK6fWC/52w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJCJLP2K; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748607998; x=1780143998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kWDMNC6gz1RQ5m+Cp7ihyfYoDc7Njv8tPJPmKzJu2u4=;
  b=gJCJLP2KIKG2YfUdBemDC8cPP7vyAzgzTMoo6BG+qXifVz46C3rErsth
   EwYB4zCgubexz+aOva9QkDx3WMms5osXCqHXwB26uXnBpqL+K6qAqUegL
   UecEiVJREWImAawviNu5L4xPP3NEcFW0024mtEEwUSH3CcwLGpG/Z5vDo
   vszrupFsg12X+N9FLmA+bfCm3TskVbtCvYbKVUAYCmriKwdL+GOqq5OTK
   GRc1DKukW5gQmdwAyH/4N9qsDC9CZlgoGEpMvLqLUbo5a0t0/nUNqmjRk
   U84zc50I/SWTTHVncFoVGaFQi5roB1peWkeBAn/yYM6DLHU2FFqTlVLlT
   Q==;
X-CSE-ConnectionGUID: FUrqqYfmSpKVT3oZbDtvPQ==
X-CSE-MsgGUID: xO22aCWNT3SkYMS6vvnKHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="38325326"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="38325326"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 05:26:38 -0700
X-CSE-ConnectionGUID: NzAG6lkRToaKefeumJ6ULg==
X-CSE-MsgGUID: /WgGqZr7R8OjhYN6DSOoaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="144197640"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 05:26:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 05:26:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 05:26:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.43)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 05:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao0MqtfuftYbJZwyOmiDCrdUZNsDdtmO6HVztoCRW3RK6EilxMA0kSLoPDi5vc5RR1RpwmyLKwI45fC4FNT/eYu8k54ljkxBLTa4kBGH+22iDyVBKZ5mT2J3x4DsyRQbPt6390nkDLDV/ulkth+nEgcpaP3ImNDc/uJmFQ6DgHvPlyewhkxrvHJ8sicXp9AM8a4NMt+nIJl76Gu2tT2LwOwz6Ljb4zR/14cf+3Gtg5ZdPwzEqI1mj0wpfBikPr9bYdvzmgUP3xqIYKb27dZfLRknHfp5oEu851uGxmnYpReaPdZKxFE3S9S1qPEHEdZLVNCDdXqZh+fFUnJi0+VrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHPwBlGmMqe0hZ4rR+ek9Jfjj65MHRxZWBEN3AJImzY=;
 b=FTNs5gZpQJz2XtyyYLnrAhNlfOqE+4XTMWii3O434NOSwqHh1IvR1IBA7PJYtxmaz6UB14PrhEUbm352y6MzP1HNChLlA2cQKUlD5BUaLehSiRXF/YDbMccFZZQxpXuN3e5LPEFhz69dPPiLWrkSRUiaVR8DiVztJp9FYMSfiLIxTfV09XPSsIZqB6Cpl+tceQrUehZU2+pRtrshpoK12uLBnOq6E4pn9EryDsWD7H1Dm4V27X1FGdLWs6IaracWQxpv0s12IrMRoRsD6VKZHeAejr3hrA2BOp6gQgYYHrT3BZozGnWrZK93CfGylHxifcCvqGTUCtyPzl6FRjINtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 12:26:33 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 12:26:33 +0000
Message-ID: <bcf606a1-1a06-42bd-89d0-c388a57a94f2@intel.com>
Date: Fri, 30 May 2025 15:26:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-sprd: Add error handling for
 sdhci_runtime_suspend_host()
To: Wentao Liang <vulab@iscas.ac.cn>, <ulf.hansson@linaro.org>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250519123347.2242-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250519123347.2242-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0317.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::16) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: c90d7a58-b71d-4f3a-70e2-08dd9f75362e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzE0a25jTkpkb2E4ZW5ySE14RUNMdXRqeEJSRXZPTGdUYUdQYWg0N2tGS2hs?=
 =?utf-8?B?NndvME1EQmVhRElxQnVvNHdRUXVxTXRPb3ZtQkVWakN5WDVRWStiNlhCMlo2?=
 =?utf-8?B?ZFlBbUFBVVUxUnJESjZQbjVab2hmQW5MQ085WXJJSnVlV0VUZWNWNlNQZDBJ?=
 =?utf-8?B?YzRNUnlYT2dlM20xWFdPamNwQ3NQeFhyZHJzVytIc24rMXpRTVJyMWxiNFNn?=
 =?utf-8?B?Z0ptZkNhS28zRzJUZmxiUmhMYUdqSlNOenJCK0IzaTRsZHJ4WVZxQm1QTXRo?=
 =?utf-8?B?UUNIV2NhNVM5YzhKM0NESHRQdlJFQnVKUVkzKy9sNkVFdFhudElmRGRqaGY0?=
 =?utf-8?B?WFRPRll5RHhzLzZXUFBDZXg1bUQvVitYUzNxaFZQbUxWUng1WERNYTFmWCt3?=
 =?utf-8?B?UmhoT2M4Vmt5Wm14Z0t6ZWpXTWtnTmNrV3kvbFFoMVJDeHFIK2dBUWZEMHZW?=
 =?utf-8?B?RXhOeVcvb1J6UDMzUVliVC8wb1cxTDNsNVhCYlZycTU0dXhZZnVwYVdhcHpR?=
 =?utf-8?B?bzFtblhxQTBYcm1CU3Ryclhnd1ZsY0VPZHQrbzIzanU2NWxHcXNkb0lUR21N?=
 =?utf-8?B?NlV6cGxkSmNRNWs0Qzd6cS93UW5kaTlNVWs3b3cxQzEvTnlXckdod1ZhQnQ5?=
 =?utf-8?B?OW96dXQvSjF4WUJwaVRJN0ZwT2pHNGR6MEZrOUI2cU1CNUt3WE1aZFQ5NmJU?=
 =?utf-8?B?aGpIQ1AyZ2ZvZkdDNWVvWE8rYWhscE5YN1lUT1QxSU5JcktBTUxXbWJ6ZytJ?=
 =?utf-8?B?c014V3l3UWIyTUVNQU5NQlc4eHRRaWExRUZ6RlBNaGs3MDRMVkUvNzhXV2o4?=
 =?utf-8?B?TytyYjhIaklWT25wcllQQ0Eza2FRZDczRzFZeXVrMEJNSGlCZzF4MEI1aGxm?=
 =?utf-8?B?WG1TUGU2NlpGeFRxenNCWVBvdVE2a2lFcE9idmxKTk53bU5LUXVobDhsR1RH?=
 =?utf-8?B?ckxzRkdLSjg0MElRcXFkd1pkNzRnQko0MzdkR0NvWGtaSGNkV1ZZTm5VNzRL?=
 =?utf-8?B?Zlc0RGl0QS9TTlg5eVZzY3BCeU1wS3ZqS2UxcWd5R0VSbEpFVFNLM2UwNzYz?=
 =?utf-8?B?dytsNnhPSmQ0YThjWDlkVk1ZUFZ0dEwyWitJbi9ZdC9tbGRuUVVkaUwyVk9C?=
 =?utf-8?B?NG40cStNNC9QYy93ZnFLRCtpZW1acXBTRzVSKzRWYkgvZDVsYy9RUXpvT1F2?=
 =?utf-8?B?WkJ5dVFVbDJEN1pOZVpVMmlDeGV5NFh4NGd3SUdqc2lqc0VpdFdWSmpadkFV?=
 =?utf-8?B?UXM3em40Ni9McFhZS0NjS0VwSGJISVhZYUU5OFdpMlBOWWRBYnZkV3czMHJQ?=
 =?utf-8?B?alprRVlJeGZZT1gwOXdpbk9aOVY2MC94bWZ4M29JamJOeTJxVlpUTzczTSsv?=
 =?utf-8?B?VTB1ZHF6a2ZNaTdVSC9OVFlmZzV4MDM3STA0Qk16YTFEdmdBMWNWN3pMVjJh?=
 =?utf-8?B?SnlhYkgvUWl6YnA2cjB1WlFMbS9JRnNIMGZ5cy9GSmJpejh5a2lUc1c5emha?=
 =?utf-8?B?WjlHdk04NEZuNGhjbU1vdHk2bmVvdnFkLzFac0l3SEY2SVJPWnV2dC9maHJ4?=
 =?utf-8?B?MlAvUS9UcU83VkF1K1hXenR5d2tGRnVUZi81Z3kwTGcxMkZFUTNJa0FjZXhq?=
 =?utf-8?B?a1dyRzZJenFqTlU5TURmOVJhQVRUVEtTTmtsZnA1bEE0ZzAzcU5jcDRpb1Ax?=
 =?utf-8?B?eHJRUFFWY2VQQ0dRZW1ZQnIyaVlENzZkUU45TVA2V05Vd3Z6V2RUdXlnTk0y?=
 =?utf-8?B?UUZOZ0VVaDRRQkYwcmZwTTNhOUdUbTNSN1dtd2E1ZnduRnY3T1NrY2Z1WHls?=
 =?utf-8?B?VmNnM2djVnJPYzNGQkFXZVlNL21wdVB0empTZzZwdFRCaXpSeGR4d2ZWS1hS?=
 =?utf-8?Q?4vfyAlLwo7U6/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnJ5VjBNN0loYXNvZlBtcUdhZ0lKcGdqQ1h6SEcrYmFSUHRzUE95eHdJSDBi?=
 =?utf-8?B?T3VmVlJDeXhrdUw2aE8vUTUzZHBKVUNuTHFNZHhaaW9yZXBwUHY4NlJKazZK?=
 =?utf-8?B?TzZaMEIyV25nOFk3RFMvUTV2Zi8zd3dyRUtRMWx3WUk1Y1lUaWNnY29heGxZ?=
 =?utf-8?B?MFd4WGdkZldpdDQvRlAvQmpJbU5zc2s5YjlqRzk3clJnd3JtK0NVU0Q1dmNR?=
 =?utf-8?B?WE04UjNUbzkrekdKbUhiUUV1ZnZnNmpHQlA1ZVFFUkh2LzlmYXducFhTYS9V?=
 =?utf-8?B?MU16cUNwbXkyYThjc252S3N5b2puZThOVC9tZ3oxaEZ3R0dNTXNNNkQyL3BD?=
 =?utf-8?B?QlliakpkakhmQ3dKMEc2dkJqY3h1U0tKZ1VsQ0FHaWUxYXlzK0RCeFdmcDhX?=
 =?utf-8?B?UnJkYnZQOEtscWUyOFVhMlZvL0xMcUh0eXVGRlovR0JXUmxzUitMTXQrSGZk?=
 =?utf-8?B?bG5yTW02L29wWXYwcFJkL3oxVGZpQVJKTnQ3SGtHMlVOY01DbUQyK1ZMOHBx?=
 =?utf-8?B?aXFVNnlRcWJNN2NlWHdreDJyK0hFa3RMVlU0d2cxQ0pFRG1yOWFYQlpVYUx5?=
 =?utf-8?B?Y1ZKaUdUVVFPTm9YcnpwZjR3dzRsck9NcHV0Z1hmelpqWDBrVWd1RXRZM0py?=
 =?utf-8?B?TmFsbWU2QjhCem5Cekt4enM2eGxKMVE3T0RaMVJNbkJGaHVzV0ZvczVPRFdn?=
 =?utf-8?B?bEdqbjhBR2JEclVyZUVvUHplQXRnTHJFbXh6M2JHMWVNUGNIMDVkK2I3R09j?=
 =?utf-8?B?MGFFaHNNV1BMOWpFOUJjY1lQMzlJRnhydGZqbVdSMUdaL1RhNmo1Ykd5RnNz?=
 =?utf-8?B?T0Y0V1VtaG5KRHcwRFNrQXNFM1dtNmErQlhmVVVPWFBrdE42VjFGTTcvdzdJ?=
 =?utf-8?B?V0NuTER5VWNmVU9ueGZ5MERXWDVFUjI2b0pnL01LMXdtWWh5dkpYUlE4dW5p?=
 =?utf-8?B?aDMwelpuek02TU55L2N2VGZkZlJ0cENaZkU4RlA3ZWttZTV1UmYzdElYc3Bv?=
 =?utf-8?B?cmp6V2FyM0NpQkcvVXhUa2ZIVGlOd1dmaWdPY2lIYWZlc1htU21BYVB1bEgy?=
 =?utf-8?B?VWRKUGJjbnlEdmdkQjRUWkhjZVNJM0cwRFVwSDROSm9TNG9QR3A4NFlrditY?=
 =?utf-8?B?MDg2YUVoeUpJQXZ4dkhuZ2ZlOXlEL3J1ZnhWVllZNDBUODlKVnFseFhUS0hG?=
 =?utf-8?B?cUZ3RjNtYis5TlhIOW5hR0V1NU1GKzJUMGVwMXdkWnB6VXI5OUNKTlV2WEpM?=
 =?utf-8?B?TTBCa3hjeFpOYlhKaTRvcmMwK2gvSU5tdDJHc1pObk55aWxYYWhwdENoVmlZ?=
 =?utf-8?B?bUtxbU1MZ011cU1wOGc2WFJ0UzBEUjJlTUtPaHhoZ0xzUDNVNTFyak8zaGFT?=
 =?utf-8?B?MDhZTytSK25Ta25MTGcwaGduNUhSdWZIb2xCSEEyUmJQZENCdUczTGEyblJM?=
 =?utf-8?B?WDhFTDMzcU5SSXJNcFRtWVhJMFZQSWRISWhFZWdRazB4NytXc3VJM2R5VmlQ?=
 =?utf-8?B?WXIvUE9PSldMOEhNc015NEhuNEhFOHJVWGIySlpabFRDc1poRk13Mkw3em4y?=
 =?utf-8?B?ZmZnT1JxNWFsWllKQTBIc0cyclVTdlB4MHl3SlBJUGdlYXFFZ05sa2JRWnNN?=
 =?utf-8?B?VEdUOERTbFlKL2VEdngvMnZ2ZnEwQjJnbmZISG4ySlZ3REl3WHY4SGxPdk9G?=
 =?utf-8?B?NlhYTFM3SGtaM1FsRFBiN2QvbnBjQlh5L0xkV3NReUNiMW9kSXlRNlhYY3dk?=
 =?utf-8?B?SjQ5dnk4ZVliRDR6UFlkSm9BNnV1b2lBWmRUV1FEWVltcGhtWVdTb1pUdFpT?=
 =?utf-8?B?NG5CMmpoT2s2R2VXdkVIVVorTXh4NklxaFJlZDVEbnNCdEIzdGRreU1tbVNu?=
 =?utf-8?B?emdzS1NBTGhxeWdUc0lTRkZVQU5uSlRaU29LWmN3WGlRdjlIcWlmbFprcmFj?=
 =?utf-8?B?M1pzOHRRTzVEY1FDbU5USTk2ME1Xa1JMU3JCV3RHby9JLzdpVzJCcmtLNWxB?=
 =?utf-8?B?YlorODVmcDIyYnhBZGtRN2tPRWdVblFkSld3SysvbmYzVGsxNTU0QWdaSHg4?=
 =?utf-8?B?S1VoNjRvWFovL1lVcTFaZ21vam9IbzM2Wm9tcW1RS3RFVFRYVlg4UkNGUnQ4?=
 =?utf-8?B?eWtBQ1E0U0NKZnp2TWNXd3FiTTFjVlk0RTBZMXRyUW9QZEdxWE5KQmhJRy8r?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c90d7a58-b71d-4f3a-70e2-08dd9f75362e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 12:26:32.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hqqLYmFQ0iZJZOhhAVqfDEEaSCQ3lRZ4CId8RDp3JezipaPPrXULhnnrGrEr29zeKKsi2msPPqwd2UNNj6dbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com

On 19/05/2025 15:33, Wentao Liang wrote:
> The dhci_sprd_runtime_suspend() calls sdhci_runtime_suspend_host() but
> does not handle the return value. A proper implementation can be found
> in sdhci_am654_runtime_suspend().
> 
> Add error handling for sdhci_runtime_suspend_host(). Return the error
> code if the suspend fails.

I think it's better to remove the return value instead:

	https://lore.kernel.org/linux-mmc/20250530122018.37250-1-adrian.hunter@intel.com/T/#u

> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Cc: stable@vger.kernel.org # v4.20
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index db5e253b0f79..dd41427e973a 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -922,9 +922,12 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +	int ret;
>  
>  	mmc_hsq_suspend(host->mmc);
> -	sdhci_runtime_suspend_host(host);
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
>  
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);


