Return-Path: <stable+bounces-88189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B99B0D40
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9751F221BC
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E432200B9E;
	Fri, 25 Oct 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcBI1qIE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D981DFD8
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880887; cv=fail; b=WeyKvXpYHiXwQ3GLDg/To7myfUkOn8PtSICJPsc5wjrQtF5sgGWfhtdnx0FX8pYwUrtrXtmPCmpDoZtceew8WoqWrAWH8i8j2f7xDcQIqFPZdKYgiGADyjzR7yMoEsRKL4uEpj0IHeuNW13pbw98CtZLTuQaMLaHjngw2L4UrMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880887; c=relaxed/simple;
	bh=7MmRMliw0fNf5oErTfNydu11VF+pVBmXurF2R9ClYEE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/E33dPXum4hCm8JBnhwLnQt/YCDfHYSyoQqhW0CsXvjBxD1yR5tL9E/04s5t5MmtYITwM5+FaKgFFFuvxij/TLP/0NitarUX0+3rghdhnQTXCuHOzln/huuyuvxKedIY60h/EMatX4QtI+zXdJs50Wqgv60TMWFyQU8PRrmUC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcBI1qIE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729880885; x=1761416885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7MmRMliw0fNf5oErTfNydu11VF+pVBmXurF2R9ClYEE=;
  b=KcBI1qIErfNVCXikxyBZkgXXnbE+92mkkduieer7GhkCiFdFiF24oxfC
   CoGFcjgwIrTG2ZlFPXuddvQLNaWyI9RxWgY0aLGRYsq41L94JATfHdLlR
   Z+ohiqEV7kyj1DtjjyBEltUAC6WYuWtgqi8CMDOyDnQh+D5hWJxtzm6nQ
   ab5UkL0PviZtFqOss3k3m1MmWxyR0pjrSJWQfqBAOyLmWBP7kIJuvK2aG
   TbeWaqSUUqKBr/8shfOheDQOU4OPNVg/cPc5r3dhc2HjNqMSuLOw9p+r1
   LItpnkGFPbcR+ebSAXcZNQymYF+yoIxhujmBzgGC+duBSSK3+pyj1lxI3
   w==;
X-CSE-ConnectionGUID: 0ARAtyycRXW9IzCET0z3Tw==
X-CSE-MsgGUID: BSa5rB/NQfq3o7TCpV9Qkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29690841"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29690841"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 11:28:04 -0700
X-CSE-ConnectionGUID: icMEcei6S5+Ro3lMxvlbcw==
X-CSE-MsgGUID: CmIVJb71Qu2LOburTphm3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="86113227"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 11:28:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 11:28:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 11:28:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 11:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyCrPzR19jUGJuhvZ0w58BmVqeNVFE/bYX6Xrev8AyfY1MiIpwK6fBHaBHcoIlntgcgZqwWboJ54zQEPjC5w9uW2KisLNesy4fcdDz+jK3aVMbfQty5LQIMGO2r/SBmqnuH0xLRBz4xAbORDES8ax1lfSJ4wxxWOO/PScPziD+hj05RcXmR6vusSstQy3O86jiBF8cpNlWW3T1nMjhFDzEXvmsr7cx0E4tbVV9kBOMERCCPqnb7H+i9Vl06qVIR4tD5huRw8cBfrtL1cX51iQIVyZqxgU8sdBM92df0QmhmIT56N6Ly6Cp2vfG97XkNteN/JHEXOlD7coWcOKxU/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4aFr0WbQwzaw2X4A6FWeov6zUmugsOLN+qaxPme0GM=;
 b=Rmc3P9SlxA0ItxP7Oqd7YAF/48UXfpyzBkLGxxuaTCFQPgqq85Vy7DxEaA6eJwmOUy/laz+Ejm8Yl1tgsbbK47QsMAglqb97Z6wyb1Eb3FdOAT+LDRudXRwClJxwxOAwxAuGsXSnbG9Q8IwTFgFzKzkPfGMC7Z9bHhOexmLJnpAARezrdk1FMn0zNx9VJEY1crO9cfyIkfp3pR6Wd0gtVfJZeBVt7wEbRbszQP2c1GMni+N74yXXpahdCCcGkzSIfac5AoOKjNeENRmIcyXALY5BKGlEKJzNrJqqFh7N3fO3DdyJsE4qcRBu1hjBIbrG8+V1dxoLKuLJ+igFQEnFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 18:28:00 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%7]) with mapi id 15.20.8048.017; Fri, 25 Oct 2024
 18:28:00 +0000
Message-ID: <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
Date: Fri, 25 Oct 2024 11:27:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Nirmoy Das <nirmoy.das@linux.intel.com>, Jani Nikula
	<jani.nikula@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
 <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3b6baf-dd70-4521-66cc-08dcf522c1a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmludkltWVZsMmtwd2hEdWpZTjdpaFQ5YURKaDJhQmNUQUpSVjJTQ1lvT1RN?=
 =?utf-8?B?cGkzL1BjaDdVUEVUWmdjdVV5b1BIZjBxOU9jTWtXaHVKUDNBUXVkVDl4Zmt2?=
 =?utf-8?B?QTlVSnlBRk9nS3dad0ppVzJPdGhMdnR4Y2N2Z2QrNDlJR2FscVB3dGRkSnpv?=
 =?utf-8?B?MFcybzlzT3ROVldKYXF6a0VyZzI2N2xaK21KNExmdWc3Q3g1Nk9nOURKTmdr?=
 =?utf-8?B?YTVUK2E5U1lva0dhMDVCajJDQ0hQYkFObUg0UVcrazI0V2ZXSGxockNEY05F?=
 =?utf-8?B?WWJRWWR5ZHFZMjZQamZHZkdFV20yc1Nsd2pQTjgyNkNsYWp3aTBtSmR4K3RX?=
 =?utf-8?B?c2VuMFhITitsRWZCOEtsSDR6WmlVbTVvREdnTWdCYThsUDFqMEhBTUFhbDJK?=
 =?utf-8?B?ZlB6K2I3SWJOa1UwQmQ2TlpZQ0R5dFlLMVhhWDZ3M1kxYVZyN2NwUC9kQzZn?=
 =?utf-8?B?S2ZYd1llK1FQbGZOb0xSN1k4Rk9ORDRWeGNIa24wVFAvWmZNZ2djN2NZb1BW?=
 =?utf-8?B?VkFzc3RObWUvWFV0YUdVWElWS1MzeEJObzl3ZTBMblVKSlEzMG9qWGxITjFm?=
 =?utf-8?B?SGVVY0dYWndNbVJFY2R2SzhHUndzMlRWdlk3TXlOMXQvaWY5L3BJTFdoUGRw?=
 =?utf-8?B?Zmw1OTVNc2svN0VFUDl6WFdGZHVWakNOUW9HYzduZGpFV1RpRUFJLzZ1TXha?=
 =?utf-8?B?NmZQZ0M4NEZ5NUNGeEdHT2lGYzhBc0hiamd3MGU3TWp6RmNaOHJ6VEp5WExm?=
 =?utf-8?B?QWFyaEM1QnBvS3B2cGdkanAzYWFEb1AyVytMenozUVdyMXpWdWw3YXExNGYr?=
 =?utf-8?B?Nkd0VXhHWlIwMjJKM3Joc2taNUdNT1JTQndVU0UxTFNIQmFHVXJxbjhPUkxQ?=
 =?utf-8?B?NlJVQlBtWWZxbFhKQkN0S29VTFIrV1kveDlSTGUyNHZIbG5Gdm82bHdOVkhL?=
 =?utf-8?B?bGhKN1Y5WG5jcytrZEJRam9oR1BmTnFBdjBhb3dZaC91YkgxLzFYWUFBWndZ?=
 =?utf-8?B?ak8wd1lYQWhsb1FOaUdPN0RKa1NoYTl2QkN2eE5EamVIbDdOZzlSamdwSEhX?=
 =?utf-8?B?bW91N0lpTTJtQlNIRiswRVU0dEo0NmVra0w3L3VBamdqc0hjdnFTSXZVUXRL?=
 =?utf-8?B?dE5PUVU5cHNtd3hKRmdKZE5CcFhqVTJNQVVOY2tvSENubnhLejZJYkhuTDNq?=
 =?utf-8?B?dU5YbzV4Q0J0RFBjOTA2aDdqam9jYzhwY0dJL0dWZ1ppb0t1SS9QTFEzdWdr?=
 =?utf-8?B?ZGJRZFUyT0p0RS95WER1NmJyY0QrazBzdnlTalRjVkxZM0JMckx5UmozMFVU?=
 =?utf-8?B?R2drWGlLWjgwMDJJSE9USHd0RlV5WkdJSisrclVMQW5zNVExaGdPcEhha2ho?=
 =?utf-8?B?MitPUXNZSUlWRFNmem4zckQvcW9FT0lKZlNETWZFeE15T1NYTTNNSjdtaVA1?=
 =?utf-8?B?d1I3TWJhYjM2L2o5eTY3YmV6SUNqTXV5cW1FdEk2QTF5MUN5NGtzbkNiam4w?=
 =?utf-8?B?RklnZHNWOVFvY0JES292aUtKUURBSS9yWCtkZkVrYjRQSmFrQitBazNHK3ZE?=
 =?utf-8?B?UUFJalU5OXBRNjh5NUFVdENLYnUxd3JiUkovaDhuOVVZZFNjTXZWaXpqWW9R?=
 =?utf-8?B?WFNpQU5MYnJOTWZLSzRsZ0Q1ekxRMWJQMmpJYnpEbVcwak1ub0dqZTVYSEVk?=
 =?utf-8?Q?9dfJFs0/YINU/Hd4fycK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkttOXJNTnlNT2hza3dncDZLcW1lTG5FKzRUZzJCTXJyK05VZCsxTFJLZVJI?=
 =?utf-8?B?eHplQkYxTjQzWnB6OFNIWEZMalBBdFlCQ0xwVWZrcm1zejdOa25HZUFNUHVs?=
 =?utf-8?B?Znl0eEZWZTFIUitCMHRNOGwvcElmdEhTUXltMHRXWEJGVlJPV2xEV1FoTUs4?=
 =?utf-8?B?WU4walVXRERuS1pXUnMrSU8rdzR0REg3N1VUQXZ6RlBVOVZ4ZlJHTENGSlpZ?=
 =?utf-8?B?NCtjWlY4VjZSREc2dG0xb3p6V0hTVmRWdHJGVUFtdGRqeUFUUXNpWjZrMUVy?=
 =?utf-8?B?RElhcFJMQ0lGalVaWmx1YUpyejZKOElEOHVZY1c3ZUFXN09XUVVUcmNERTlE?=
 =?utf-8?B?R3lKSTlLNWVqcnBMR09jUitGNGRKUHp4RURGc2UzdUtrcWh4UnJxcTNiWVRj?=
 =?utf-8?B?ZDE4UnlhRWFBQXhOeEhxRzRPdTA2MHBybS9YZDZ3ZTJGa244WWZsQXVxY2VV?=
 =?utf-8?B?STBmMWNJd3BiVVo1WEVmR3h5TklpbGpGelpMSUdqM0ljUk1IMjlJbEpVOElN?=
 =?utf-8?B?eXBaTVVHODI0eHpyTjZLNjlLUTIyNzZaVmtmYjAzUnFOQmZLSGRoMms2Vi8z?=
 =?utf-8?B?SnZiUk84SFNROEFXOURYS0xkOGRwVGpIeW5OQ253Z1BTcUtETDJXcjlUSjdC?=
 =?utf-8?B?KzNnbVpOeGdGRkY0V1pkR3RiRFhCVytrVGw4K1BobzkyRGFISk5jVUNEVTlT?=
 =?utf-8?B?aERCYlhsQVBzek5QSk5yZFZIZzFkWndkQVltWjNHRlJKMk1CNVMvQ2Y5alZj?=
 =?utf-8?B?UVpSdVdpN0loL1pCQmd6OGs1VWI0L21acW55OFVFTzRIVk5VcjdmSEhPVGFK?=
 =?utf-8?B?Z3JoZnVnTnJLcmRjbHlEcERIRGM5eWhHSExtbzZuNFJ3TlAzczNXaktWZEtt?=
 =?utf-8?B?R1pKN096WmtFWGZCQmNzVFZiYWp6WU9NV2FyQkJkWE5LaVJjR2FrNEZua2hs?=
 =?utf-8?B?ZFI0bS9HNTA3R0pGZnVPOVpScDJodk0wQ0owOHJqTkNxSnROUENEekUrMEda?=
 =?utf-8?B?emphcms2cDNTU0VoMUVZb2loem9BTjNZZE9yVlV1ZVladmszdnBFd3FCeGRq?=
 =?utf-8?B?c2ZOSXZWYWcxRXNEMUg0L1FCQWFQOUE5TlFSK0g2U3c0c1c5aU9MdzQvWnJJ?=
 =?utf-8?B?ZUpQdW1qR1ArMXRsQXlPZ3lwWlRwM0VqNVhpakl5NVdTUDZGYlp3UkE0RFFW?=
 =?utf-8?B?VjM2SHhHemVheEgwSkNHVmdndU1xSk5CVXE0TFB1Q3JtSGl1SDNqckQwOFZX?=
 =?utf-8?B?TU9ZaGZ5Vm8yVHRhZm5tbjRRT1k0YlFRaVJDeERsb0hocnRDclhLYVNwMmdi?=
 =?utf-8?B?TnpJOU9VcjdBSHdXQWs4dzI2dUgrTTRlMkpjL3duSjB3TjBUS3hGODZlSGk4?=
 =?utf-8?B?ZTUzbml4YjVvanRlVWNwcExJWmVVZkZUcVFDL3BlcWtCU3k2TGxBcEJ2cXhi?=
 =?utf-8?B?ZFVjQk5PcTBpYW9LaDM3R2FEMFdLM0llbEdoOVpGSHE4dGRHRGl5V3NDOVQr?=
 =?utf-8?B?amc4SHZoVlc4bElMc2FQclBvTjl6SnFNSmR0aXVDY200blcvMm5QaGp0UmpY?=
 =?utf-8?B?NWFLSVRKcldCbTI5OWNpRVlvTGNQc2h0UUR2RUpsNjhNWTk3WUdGS2RZMVo1?=
 =?utf-8?B?TWZWM2Y3eThrRStDRWpVRlFuT2I2SFF4L2NPdXdYTjEzZXlpVmxVYmRIVmYw?=
 =?utf-8?B?TWhxODBWSjg0dFRGL2o5bzZoVlRKOEdRVW92S0xnRGVGU05vdUZlOGJydG5y?=
 =?utf-8?B?eW9LS0lXQ291UE91N1lxZmhPT0ZpUXlXbHowNSs4S1NmS0FWeTRkNEsxZWhq?=
 =?utf-8?B?V3pKcHJoSE1ncEcrR1V6SzRkUUdnYndWbDFhdjZTa215bTlyWU9ZcUFxSVpn?=
 =?utf-8?B?bW5zTjJUL0NKT0RZRkI2OTlCb3E2Kyt5Nk41dFJsSFhidkZrVWdCWWJXSEV0?=
 =?utf-8?B?TmxUMUFoWkVjMWhrVzc0UlpEUDdaSDZzZUVTUStkbTgzVG9ZMTVkeXIwdnVi?=
 =?utf-8?B?NUpPVzNTbGQrdCtDOFpxZ0xKOWU5bnEza0pCRC9DRkJuT0NYL1liTFpVZUNC?=
 =?utf-8?B?dkZXKzNRVDBtczVndlZuaEYyWlFLdk5zVVNaQ1poVjRkenh5RTJ4WWVDbGYw?=
 =?utf-8?B?blVLdTdhbjVkZDRib1Y0ZDFxNTE3M0NFblNBY3BqbDFJc1NIeGhyU2FBK2ZN?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3b6baf-dd70-4521-66cc-08dcf522c1a0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:28:00.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs+oWhxtH5EKzI4MPKrRClYpHeCGY5ELRNY/BPu9GoLO98HkroCztjdlV9USYi/Xq4z/H/+XEbxIN/VC0PsHh9mYJevNHu7k6FF0UNAE17E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com

On 10/25/2024 09:03, Nirmoy Das wrote:
> On 10/24/2024 6:32 PM, Jani Nikula wrote:
>> On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
>>> Flush xe ordered_wq in case of ufence timeout which is observed
>>> on LNL and that points to the recent scheduling issue with E-cores.
>>>
>>> This is similar to the recent fix:
>>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>>> response timeout") and should be removed once there is E core
>>> scheduling fix.
>>>
>>> v2: Add platform check(Himal)
>>>      s/__flush_workqueue/flush_workqueue(Jani)
>>>
>>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.11+
>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>> index f5deb81eba01..78a0ad3c78fe 100644
>>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>>> @@ -13,6 +13,7 @@
>>>   #include "xe_device.h"
>>>   #include "xe_gt.h"
>>>   #include "xe_macros.h"
>>> +#include "compat-i915-headers/i915_drv.h"
>> Sorry, you just can't use this in xe core. At all. Not even a little
>> bit. It's purely for i915 display compat code.
>>
>> If you need it for the LNL platform check, you need to use:
>>
>> 	xe->info.platform == XE_LUNARLAKE
>
> Will do that. That macro looked odd but I didn't know a better way.
>
>> Although platform checks in xe code are generally discouraged.
>
> This issue unfortunately depending on platform instead of graphics IP.
But isn't this issue dependent upon the CPU platform not the graphics 
platform? As in, a DG2 card plugged in to a LNL host will also have this 
issue. So testing any graphics related value is technically incorrect.

John.

>
>
> Thanks,
>
> Nirmoy
>
>> BR,
>> Jani.
>>
>>
>>
>>>   #include "xe_exec_queue.h"
>>>   
>>>   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
>>> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>>>   		}
>>>   
>>>   		if (!timeout) {
>>> +			if (IS_LUNARLAKE(xe)) {
>>> +				/*
>>> +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
>>> +				 * worker in case of g2h response timeout")
>>> +				 *
>>> +				 * TODO: Drop this change once workqueue scheduling delay issue is
>>> +				 * fixed on LNL Hybrid CPU.
>>> +				 */
>>> +				flush_workqueue(xe->ordered_wq);
>>> +				err = do_compare(addr, args->value, args->mask, args->op);
>>> +				if (err <= 0)
>>> +					break;
>>> +			}
>>>   			err = -ETIME;
>>>   			break;
>>>   		}


