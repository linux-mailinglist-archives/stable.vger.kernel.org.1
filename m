Return-Path: <stable+bounces-110327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF0A1AA5C
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256C2169DB4
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E75156228;
	Thu, 23 Jan 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFTmO30t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC417741
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660909; cv=fail; b=krT3yJiOl9j+OgH9mE91AGlRVpxs7jUu57o6w0PsMgOna1AXtR2VT0yN4W6HcwWDBeDR4TMCkVf5d5mKxDThSPiUA0gnTY4Z5eW5NtAh08EErQDu2WKsri18i5OnLn3MlwcZHgU3FEfjPERszpOCPhByxyppz9O1z2GRT2EI+Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660909; c=relaxed/simple;
	bh=UZuoYZNrAasZOkQKUfUPQsmiTbvILaJ6zVveuPCUqRQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2xPJpXZu9xJ1f+3nUUg3p6e9CsdYSjTmCfmH2pNv8SgtclHU6aoCxKXEJF6TBVvU+rgJo5uIZB37oIybGQXLUSl6HLVhHSB4u29i+bohzVMMeFjR1vow3HkG2x45FKffzd1y40t1QEuppxKQfVXJ3Q6Q9YVe7P3MU5OiL6wuPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFTmO30t; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737660906; x=1769196906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZuoYZNrAasZOkQKUfUPQsmiTbvILaJ6zVveuPCUqRQ=;
  b=LFTmO30t2jojaUfxS4TG7QBosynxmdYow5Py1ekcDR/RzlA+GBQyaOSp
   iBt3ZddNereOMHAyL9aiT3SvK/HyAR6Ox28seOLco5oBcM0q6XZbqgV9o
   p0GrkhApQJsw7DERNCawVwlagm+OEYDqkJQzTeeI0A/+k4w9KrspbX30J
   ekP1ZRFnUWZX+RRdKLBAwd8GlI9dI6OC1Wblgu5RKoGnNfer4GprBdlfA
   v2wNCo4/Dj4jK25fTe6DRTxXnKBA4nDdvJIRkorQr1NbNd3H/YaNuUg7I
   0256BNsUf0OokWhfcDSM6kdCELYV11udtA1Twc81tF/S5PuYTQTKvvvX/
   g==;
X-CSE-ConnectionGUID: S9AQ9XfjRzyw9ppFQWpcLg==
X-CSE-MsgGUID: hYKY4T4rR3OCuKcwTWMaqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38349184"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38349184"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 11:32:19 -0800
X-CSE-ConnectionGUID: NQFANg89Rzq1BDmxWggjwA==
X-CSE-MsgGUID: qS9Mp+yaTXi1BI1N/6/Bqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="112580236"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 11:32:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 11:32:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 11:32:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 11:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4L43HBaecaan0yqQoz9D/qWhHk7bZhXcpUKwb8SbpSgfH/6U0LyONdQzgyrTRBjsCduqBahXRYk+kajCKT6qPQR8pGon1Fe4MdZO6QO+PQ57nAuA3UmzXKzyA81dd7YHSC0imKDrnbKXZmq/1aI/D5cT7YiU7R2ISJe4vIhprmfBeGoGZ4iQjjzloPH915PsQweNsfYlv+txIXcQ0kSxx9Vtm+FRHUM+R9uRb9bfzFzsf8aqFx5CFB4yhatg5sxGGDvXAbeS8fB0jkHY7v9afYgmjCphOJ1N3YfFRpRX6GO8QJKOxMAp0berAkUNs097xg7v5zqPWKcZK6aHVP6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc1YmWb6L8ZSUtIn/NhixlOBY++NDwbRu18CAemGEQY=;
 b=EM5kFPcSl1PVvsWyK7KUb/LzT4KgX/QB18eBd061xGAUWZNAq7vjajeSGKCDS8sEE9tQ3MClzWKjLop3sGNdVgvsVPtyGqRSitoaom5qFh7T2atk2ha5L37KFlhlkTVdBJ0Wgv7olVZrDTc64LcXVaElE7iuV4/TFrc2URD4nFs6WRFnkHEdZl9lKnp8YUju2lgu9jlRYP672Ox5iwHSjZ+kXS554dG7y2GgnIUkT+DFleqRPs3D0jsYr97sGsgVmQXkzn9iJc+Dy2e6DP8BjaVki0PPEequXz3Vja19KH1XT7TVR5zBt+rZAXN2NFqdo9id2sXbKZ0MrEe0u0RGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 19:31:48 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:31:48 +0000
Message-ID: <cfe46bba-0767-4c01-8fa3-fc5cec3624ca@intel.com>
Date: Thu, 23 Jan 2025 11:31:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Julia Filipchuk
	<julia.filipchuk@intel.com>, =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?=
	<jose.souza@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
 <20250123051112.1938193-3-lucas.demarchi@intel.com>
 <1dd0e42d-0163-469e-8fd2-9c3b941c23bc@intel.com>
 <jvwkscbbf7wlipsu7bura35aasbi6ter3avr7tv4ocwf3nsizp@gd6vuo4nutpz>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <jvwkscbbf7wlipsu7bura35aasbi6ter3avr7tv4ocwf3nsizp@gd6vuo4nutpz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ed2d7b-920e-4976-60ce-08dd3be49413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCs3bmFBajR4T0N6TEtWZlRqWWZRMkhYQlB4MHdQS1NCMnJPejdwQmRndTBr?=
 =?utf-8?B?RGVkcUhIcXlTaGs1akVlR0VCQVJubkxpYzRpMVNaMVNQaXltS1diaVNNdXdF?=
 =?utf-8?B?MEdxa0Q1bkdTbWFVbEZpVVdVS0F1WVg3bVJReHFxSThia2pzSlFUL05LSFJR?=
 =?utf-8?B?U3NBWWZUN2pyZGFkS0VveDlTeWd6VGgzY3EvbnFxY214c3prcW91QUFDZnFJ?=
 =?utf-8?B?YWpyK2wvTkFqTkd3RzZUcjRUSDdDbTVqcGRhUnh0NUppd1JGYlNtZ082eUNW?=
 =?utf-8?B?eWlxeVVyZEdpbVR4Tzd5WW51MzUxdXBPbVE2cVhPMFVDR0xUU3NwcVh0cXlm?=
 =?utf-8?B?SzNLRFhLZFJpUmV1ZzY3SVVPVVRTNDBUbWZ4Sk5HZld1bkV2a1dqQURZeDVE?=
 =?utf-8?B?NGpJTlpzVEs1K0NXNWZkVEwyMzJEcWJ1QUM5SjVNMURUUHFyV3lvOE1SMFVM?=
 =?utf-8?B?UEU2YTVPNzFMWm4yOVlLWWFnR3J1ci84elNWYXVudEJnRzRGYUZxT1V6QXFi?=
 =?utf-8?B?WWlKZHpiVkllWmdXOGkzZ3BGY0FpSnhRbzJEYzlZYnhDQVZ6Q0J4UUFBWDI2?=
 =?utf-8?B?ODNZeTJ4V0NIenErcm44aVMzQVJyUG1tU1VWNjhKMWhrVm8veXI2U0hKU01T?=
 =?utf-8?B?d1QxV3YycVdvdlNMRkgxOE95aFdiYjhHL1Y3c2o3Yy94VkdJYmhoSTVpb01U?=
 =?utf-8?B?R1E5d0t5MEVJTWxKL2FYTFBrQVpnTEJ2WnpCSVRocnExL0dYVHFQYnJOMkMy?=
 =?utf-8?B?SzFWU1JaM2JoeEk4OHo5VzhYZk1ZQVRzRmpqWUR2STZJcVY4Uk5KNmRJbDZx?=
 =?utf-8?B?Z1NDd2NlY0FxTStqTGtCNWRkUU8rMzNadVB0WUdBUndTVGI0QzAyaytGdlpT?=
 =?utf-8?B?cGsyV1QyUGZzQjJEcHhEZkprdjJJVGVEN3ZkZFlXTHF1ZVVIRVk5empPVzdT?=
 =?utf-8?B?bUJnUjJzbFd5V29kMlZkOWpyd2pPZDJmU1ZJQVNWNzlXaVhKY2xWNTFjcjNa?=
 =?utf-8?B?a096emFZTHFKYnNUeERKZjlzeWVWY1cyOUF5QW94QkxxMHU5ZEpTbGRmY0dD?=
 =?utf-8?B?RFZ2WHBEcjVPcXRvL1A3bXErVjJab1hWYlBFZHdBd0tnYVFJc3hmUEE2ZnVV?=
 =?utf-8?B?Yzd3T3dpaDVFRVRETElPTkxCajNBTVAzUTY4K1Y5VnRUQjM0dGowUnhDMFpP?=
 =?utf-8?B?Y2V6YmluYnFwZlhEeWJIck54N0I4MVZmdTNyZkxZVG5KZm1WSmczRldqU2o1?=
 =?utf-8?B?cTNVU1lnNTVnQ1BON2JldlRIMXBuVjRVNWNWeDdhclJrRnNUdlRxMmllMzBs?=
 =?utf-8?B?K3ZXOXAvQ2g3Y09EbE8yOHVQdGg3dUF2N2kyS2lNWnpZWjczcWxVVFgyYkJ6?=
 =?utf-8?B?OFg4NG1ZMjdQMWQ3UVdjWTA1MUg4aDRwZ21ycWN5K042bVluUVpOZVcxY0lW?=
 =?utf-8?B?RngrMjN5Y1hCc2FhR21JZmJDbXFrVWFQUWdoamp2eXFuV0dKWitIaVVyL3E2?=
 =?utf-8?B?NWVpUWtCbG9wT1NhQTRBb2RqQjJxSDFhd29DS3J6VmpHaTVOQ1ZqdDVJa25o?=
 =?utf-8?B?Z3JWK011eHFSZnlBRzRMd2l1d0d6Zy9ucGsyMUxLRTVPNzVKM0FWUG1XY3hK?=
 =?utf-8?B?aTR0ckZjOVJBWkhLd1R5cEFFcVVtMW9DQ3NMZHRlcUtkd1BrVEF6d3gwVk42?=
 =?utf-8?B?Y3BzWVdBbFRnK25tN2hLSjc4a3o3akFIcTBTNjdyWjN2UXY5dWVNMnREWCtl?=
 =?utf-8?B?d2trU3pseERDSy84K1ZETWtCM3FETXN3akk3WmlHMHBmWjVRdElINHI1bVRh?=
 =?utf-8?B?TVF5cGRTWkVSa3RPMDNWUUtBMGprdjVxbC8zTWErTDhrUGRiZkhNWkd2b0lT?=
 =?utf-8?Q?0/8XDZPN/n16c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRuTXlFbGFHamptVlVVUmovbnJLSGYvQlBMZFl2VzIvR1ZsNGlBSHFBTWNy?=
 =?utf-8?B?L05rVDgzRkZUWFNtNXdZdmlaVUxJclNlTDBDMFFGb2xUckE4bzQvMnUxbDFh?=
 =?utf-8?B?b2cvTFQrdmo1OG9FdnFoWEU4d20rUkxmY280OURSTmttUFc1eEZCbnV0VHUz?=
 =?utf-8?B?bmkyN1hUM2JBWjhXM1c0ZlFsalFGREprbXlncGpKNGRvc0hTenlEUnBoNHdS?=
 =?utf-8?B?bytvd2JHVjcyRjhMeXZZemNXZUV1MmcwMi9QbExZd2tZUzgveldRL0lBRk54?=
 =?utf-8?B?U2twcnN4WlMrdHdabDQvUFVWUlJaNG5EVUxZdzZtU2RhcXRhWVNrUXhDQy9o?=
 =?utf-8?B?emZXNmJZQjYxNE1IYWw2R2NRY2FkeXY3RzMrenVpYjUzYytma25yWW5GVnEy?=
 =?utf-8?B?TmV3Q0RPT2o3YzUwOHE2VlJ3MGdQRWhhY1pRSklhOHZacmY4VmVKblprcnR6?=
 =?utf-8?B?bEFCTHlLM29iUm1tbWMrakVGSzRuV09vYm12ZmpNbnAwZFJIN0FPTXlydGlM?=
 =?utf-8?B?TzZFcEFVSm5iOGVQSUJLWFUrVTBmeEtrR1czSzVqU21NOXpkanBRN3lha1Vr?=
 =?utf-8?B?VlA0Q01CT0JzbHcyY1NLV1hBNFRuSGVYMG5lNTdtVit5MXMzY0VJV0NwalBQ?=
 =?utf-8?B?NjRhZE12b3RaZ0wva0hLcXRhOXg5dEF3dXpkaVpEcW5zQWRTZnVkVkc3SzNk?=
 =?utf-8?B?YWVQTTVTUHNsWmdmTTVKVVJkQ2k2YXNnb0NRajZUYkp2bzlVRnhUVzgwdXhF?=
 =?utf-8?B?enQ2MGFmekxKd2ZGMjc3RmtNTTd3cy9OZm9kcHRzelRVQzM3eUtlN3NpUU5W?=
 =?utf-8?B?ZDg0aUE1T2QrT0VZWTZ2blp2bkZsYTNyU0dra3hxazh2a0pWVWpUUHpRS0Jx?=
 =?utf-8?B?enc3R20wQUFiYUlqTmR3WnZKa1BNTXRTYk5uZVEzeStaSFAzbVZmU2F6SGQy?=
 =?utf-8?B?ajRkQkprV1Q2UnNSei8vMXNqa0t4TkNnbFZkT0FJQWFvQ21SZGNOUitBbnRy?=
 =?utf-8?B?dWo1WFZBbkg1WkdOTlpacVNvN2R2REFoTHE1ME51eTJlRktncTFZL05CSzdC?=
 =?utf-8?B?VzRCV1dhRC92OW44YlJqL3V3WlNpZU92WEp0WExvVEZlWXRHdVlUMCtRaVRk?=
 =?utf-8?B?S1RleHBTVFMwTmlmMG1jK2E0S1ZCZ0dLcnpJOUJWWXV4Mm5UYzQ2enFaTjFo?=
 =?utf-8?B?aWRXNFNScGgvR1llbFQ1bUM3U0NQdW9Kb2ZjbkdqUkxCakxFL3BVbzhKeXdU?=
 =?utf-8?B?RXNEblRrdWlFQzVOazgwMm1VTkRuZnIwL3g0aitvUEtzeFRlODF4bXRxc3N0?=
 =?utf-8?B?T0JzV2s3VDkzLytkM3hCaXJxRThVZDNoV3FKTmtzaEUxNzhKU0RSaDEvMDFV?=
 =?utf-8?B?L2d4NW1jR1RTTlpheisyWlNTYy85YkZHTkludFJBVTNQdmMwTGl3UVR5MzFF?=
 =?utf-8?B?ajBRZitFQWxpaFBsS3VIdURxS3JlaEVjbmRHL0tUQzFid3BvRUhOSHcwazh0?=
 =?utf-8?B?aWRIekFRMmVLNmZyM2NoYkNHQThwdDhBa1dmY2djdjVvLzdLSkU2KzR4bDZt?=
 =?utf-8?B?dUpjV1kzZVA5S2s2YXV4OGtUS1E5VVVpb0hkODd5anF3UXpjVnQrTEljWXZa?=
 =?utf-8?B?S0l4b3BmQy9tdnV4Z2dvdEVSUVVkdzNaZVJ0a1IvV0x6U2k0WkxwLysrTDhK?=
 =?utf-8?B?akhSSEtaaGVSeXFrWUZvaUR3bVhXd0d3cDFWOW1CbWF0MEZNc1BCOGI1TzVQ?=
 =?utf-8?B?cHFRN3l6Mm5NdnJvMUQ4ekE1ajV2eXE3UUQ4LzlMTFZCQlU3N1ZxY3Bwenoz?=
 =?utf-8?B?akNoeWd3Y0xZSmQ4MXd3ZWpRWGxRMjk5Yk1xaHhNSUJ2TUEzZWJmSVdranpY?=
 =?utf-8?B?aHd1cUF1MFV1Y2NtWnNKKzRjL28xUmtsNTRoVFl3SXpoVHdIMjBzUC9nc3Q4?=
 =?utf-8?B?MitaVithV0MxRnJ4NSt2WTE0eFRmbWxJcXhnV3Y2aUtHUWFpdGdVVTNHMThl?=
 =?utf-8?B?OGlDQjU4aEVENks3aXN6QTcrUCt1Nnl6VUZNU2p6M1NnUWpDM3RjeDBnamZs?=
 =?utf-8?B?NmZnWkZZM0FZaWMwVUJZZVdzbkx3ZTdUV2h3alUwbmFGZzNUVUtuYXJJT3pL?=
 =?utf-8?B?RWh5eG96ejNaTk9tSG04TDcvd2QwMTZxZzJ2ajBXakh3TElnTWRqeTd5dCs1?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ed2d7b-920e-4976-60ce-08dd3be49413
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:31:48.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nD9XBxHac1+ccK9vEN1IQ8YkBJ0t/1Os/CRDnUQkw03fQZm3zp0Kb2Az+JsoartZHkA+h793Vn5WUdfhPytdLgFRK9f4P4iPkiCN4YvxMzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com

On 1/23/2025 10:36, Lucas De Marchi wrote:
> On Thu, Jan 23, 2025 at 10:25:13AM -0800, John Harrison wrote:
>> On 1/22/2025 21:11, Lucas De Marchi wrote:
>>> Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
>>> debug tool") partially reverted some changes to workaround breakage
>>> caused to mesa tools. However, in doing so it also broke fetching the
>>> GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>>>
>>> The fix is to avoid the extra newlines: the devcoredump interface is
>>> line-oriented and adding random newlines in the middle breaks it. If a
>>> tool is able to parse it by looking at the data and checking for chars
>>> that are out of the ascii85 space, it can still do so. A format change
>>> that breaks the line-oriented output on devcoredump however needs 
>>> better
>>> coordination with existing tools.
>>>
>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
>>> Cc: José Roberto de Souza <jose.souza@intel.com>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa 
>>> debug tool")
>>> Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper 
>>> function")
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>  drivers/gpu/drm/xe/xe_devcoredump.c | 30 +++++++++--------------------
>>>  drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>>>  drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>>>  drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>>>  4 files changed, 15 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c 
>>> b/drivers/gpu/drm/xe/xe_devcoredump.c
>>> index a7946a76777e7..d9b71bb690860 100644
>>> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
>>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>>> @@ -391,42 +391,30 @@ int xe_devcoredump_init(struct xe_device *xe)
>>>  /**
>>>   * xe_print_blob_ascii85 - print a BLOB to some useful location in 
>>> ASCII85
>>>   *
>>> - * The output is split to multiple lines because some print 
>>> targets, e.g. dmesg
>>> - * cannot handle arbitrarily long lines. Note also that printing to 
>>> dmesg in
>>> - * piece-meal fashion is not possible, each separate call to 
>>> drm_puts() has a
>>> - * line-feed automatically added! Therefore, the entire output line 
>>> must be
>>> - * constructed in a local buffer first, then printed in one atomic 
>>> output call.
>>> + * The output is split to multiple print calls because some print 
>>> targets, e.g.
>>> + * dmesg cannot handle arbitrarily long lines. These targets may 
>>> add newline
>>> + * between calls.
>> Newlines between calls does not help.
>>
>>>   *
>>>   * There is also a scheduler yield call to prevent the 'task has 
>>> been stuck for
>>>   * 120s' kernel hang check feature from firing when printing to a 
>>> slow target
>>>   * such as dmesg over a serial port.
>>>   *
>>> - * TODO: Add compression prior to the ASCII85 encoding to shrink 
>>> huge buffers down.
>>> - *
>>>   * @p: the printer object to output to
>>>   * @prefix: optional prefix to add to output string
>>>   * @blob: the Binary Large OBject to dump out
>>>   * @offset: offset in bytes to skip from the front of the BLOB, 
>>> must be a multiple of sizeof(u32)
>>>   * @size: the size in bytes of the BLOB, must be a multiple of 
>>> sizeof(u32)
>>>   */
>>> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>> +void xe_print_blob_ascii85(struct drm_printer *p, const char 
>>> *prefix, char suffix,
>>>                 const void *blob, size_t offset, size_t size)
>>>  {
>>>      const u32 *blob32 = (const u32 *)blob;
>>>      char buff[ASCII85_BUFSZ], *line_buff;
>>>      size_t line_pos = 0;
>>> -    /*
>>> -     * Splitting blobs across multiple lines is not compatible with 
>>> the mesa
>>> -     * debug decoder tool. Note that even dropping the explicit 
>>> '\n' below
>>> -     * doesn't help because the GuC log is so big some underlying 
>>> implementation
>>> -     * still splits the lines at 512K characters. So just bail 
>>> completely for
>>> -     * the moment.
>>> -     */
>>> -    return;
>>> -
>>>  #define DMESG_MAX_LINE_LEN    800
>>> -#define MIN_SPACE        (ASCII85_BUFSZ + 2)        /* 85 + "\n\0" */
>>> +    /* Always leave space for the suffix char and the \0 */
>>> +#define MIN_SPACE        (ASCII85_BUFSZ + 2)    /* 85 + 
>>> "<suffix>\0" */
>>>      if (size & 3)
>>>          drm_printf(p, "Size not word aligned: %zu", size);
>>> @@ -458,7 +446,6 @@ void xe_print_blob_ascii85(struct drm_printer 
>>> *p, const char *prefix,
>>>          line_pos += strlen(line_buff + line_pos);
>>>          if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
>>> -            line_buff[line_pos++] = '\n';
>> If you remove this then dmesg output is broken. It has to be wrapped 
>> at less than the dmesg buffer size. Otherwise the line is truncated 
>> and data is lost.
>
> we broke everything because of the dump to dmesg. Let's restore
> things in a way that works with guc_log via debugfs and devcoredump
> rather than block it on dmesg.
I'm not saying that you need to leave the line feed in and can't merge 
anything until we make it all work.

But removing it completely is not helpful. It should be left commented 
out with a comment as to what it is needed for. Then when someone wants 
to do a dmesg dump, they just have to follow the instructions and 
re-instate that line.

And the comment above is inaccurate. It at least implying that adding a 
newline after each call fixes dmesg output. That is not the case. We 
should definitely not be adding comments that are misleading.

John.

>
> Lucas De Marchi
>
>>
>> John.
>>
>>>              line_buff[line_pos++] = 0;
>>>              drm_puts(p, line_buff);
>>> @@ -470,10 +457,11 @@ void xe_print_blob_ascii85(struct drm_printer 
>>> *p, const char *prefix,
>>>          }
>>>      }
>>> +    if (suffix)
>>> +        line_buff[line_pos++] = suffix;
>>> +
>>>      if (line_pos) {
>>> -        line_buff[line_pos++] = '\n';
>>>          line_buff[line_pos++] = 0;
>>> -
>>>          drm_puts(p, line_buff);
>>>      }
>>> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h 
>>> b/drivers/gpu/drm/xe/xe_devcoredump.h
>>> index 6a17e6d601022..5391a80a4d1ba 100644
>>> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
>>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
>>> @@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct 
>>> xe_device *xe)
>>>  }
>>>  #endif
>>> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>> +void xe_print_blob_ascii85(struct drm_printer *p, const char 
>>> *prefix, char suffix,
>>>                 const void *blob, size_t offset, size_t size);
>>>  #endif
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c 
>>> b/drivers/gpu/drm/xe/xe_guc_ct.c
>>> index 8b65c5e959cc2..50c8076b51585 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>>> @@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct 
>>> xe_guc_ct_snapshot *snapshot,
>>>                 snapshot->g2h_outstanding);
>>>          if (snapshot->ctb)
>>> -            xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, 
>>> snapshot->ctb_size);
>>> +            xe_print_blob_ascii85(p, "CTB data", '\n',
>>> +                          snapshot->ctb, 0, snapshot->ctb_size);
>>>      } else {
>>>          drm_puts(p, "CT disabled\n");
>>>      }
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c 
>>> b/drivers/gpu/drm/xe/xe_guc_log.c
>>> index 80151ff6a71f8..44482ea919924 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_log.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
>>> @@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct 
>>> xe_guc_log_snapshot *snapshot, struct drm_
>>>      remain = snapshot->size;
>>>      for (i = 0; i < snapshot->num_chunks; i++) {
>>>          size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
>>> +        const char *prefix = i ? NULL : "Log data";
>>> +        char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>>> -        xe_print_blob_ascii85(p, i ? NULL : "Log data", 
>>> snapshot->copy[i], 0, size);
>>> +        xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 
>>> 0, size);
>>>          remain -= size;
>>>      }
>>>  }
>>


