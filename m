Return-Path: <stable+bounces-108055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7315A06D49
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 05:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3435318898B7
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 04:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316E213E87;
	Thu,  9 Jan 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sk+eKzPg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB071AAC9
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736398204; cv=fail; b=nCENWvTIMtN6a8AXUiraIb1+sNnkjJwxlexngLVxduUpS+olrFqyXPQWM7md1HZwa23YKudWd6oFpoAN3AmxZkHfNm8TO84yYQJnu3gVXWVIswTSepZQ33qpM/ETw0KVYTe1ToeSlHt1EOOosYivCvYeOX2AlYaFxOCoFRlwmOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736398204; c=relaxed/simple;
	bh=l+6bM4pnWpr6siqNxKbnRtvDVj1jOk5GybPrgBQDgog=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SICxOD9/YCwnS0PH00vcXlY6+RcRLUn6h2frg4wkWPGjZ9C5DYZX82MdLz6WsX/JLcAkjSIlV/RRfbJZswpzPWmZ0F3qy9vrPf4EYJyHYVxAGZv6rhueFFlHcB8e7vF2RzwuAWWp2pvzj9CU5+qTMXX35P1bkFJs9YTCN1lwL8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sk+eKzPg; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736398202; x=1767934202;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=l+6bM4pnWpr6siqNxKbnRtvDVj1jOk5GybPrgBQDgog=;
  b=Sk+eKzPgCpvd8gIehyhUQOqpk7XdauKOIYu1rHv0phU9ixsmBBOJ26Lc
   HEclD6N44IjpVAMew3x3SMueGOzpNjFpMelhUxoaaQWnfDFAQfQVgm4a4
   SuUhlZs5SLK8hww7VbUrUsKIRfv+6r4wiY7NM+d/c4TCczuYE6/fxzkCW
   Tqq6mEcbffeDcwMnUEZR8qRiLgh/Y747h62LjA0csXuvmxxpfrzMObWjg
   xSWYpaLUU0kDr1Je8cgd5JX/pEN6zFwZRetDnDvBXQGbBQCMwDb5uYxT4
   J9thCLYiGncsmQEbjDBqmAxnGM2CiTd8m1CFRB/W+Q8ofYzPU754oCjW3
   w==;
X-CSE-ConnectionGUID: vTiiWqX4Timk8pGY+LGeOA==
X-CSE-MsgGUID: g9+mtBLDTwCVAem4o3l5kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36869744"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="36869744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 20:50:01 -0800
X-CSE-ConnectionGUID: zY0JWy+BTsaUBrsjBVNvNw==
X-CSE-MsgGUID: tVaEPj7uTxKn9eIAX4V+5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103110287"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 20:50:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 20:50:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 20:50:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 20:50:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN08z9W5lJ75e7Q7AdQbDpKaBMFeIMCEKNae4U9bEcrovLLtVeTBe89v5xcQbechFzZuMFcVPsJGe2RsGKgCJmRQQvTNTCv1g3fhAab3qTrAjDqikjXNGw13sgMXj/ks4GjxqU3TReSwpTCajYcr6TUCBnSU8KNIspsy8PVur7K2X6lidLA1cKjRcLODLBEw6aRZbVgvPdYZAulnqjXd+J4xyb4LaS48B1E3DnMhLt0Ed3iB5cag6QCKMVaACcHvKPodi/GNyVCJ3IJ3RdHgvAWNqVnVN5IrTsshlUIs+QlURdILzNQ5I/qoPmlf/4yu04JsNtYu5DOtNALNDaupdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19GFPZGkuhX8zyWE75HSjjxqM4OdrxcpX7Xaz555cd0=;
 b=aT1BrbLIX9MVQwH9HhRrg+VVKlcmtqC0mMI/1x/WCtHZILI0JROfIn34jdsHc58blPHtSnAuaPE7nzCZVPXUDPQG9tevDZgh1PRj7YMkxVSXkqu2/tG5aZ/B+iTzujqrSWQoPcZ1a4GADi1AhmAB+ptz4iyv2/44luponJvQOluiWuDDZZ/0Z2hNgd/ySK2VDExVVXSASFEaNN7CcTAh2qpCGKFzoVxsIS1FsQ1VPfB3I5WlXfFSW0SKG2WVDZqrbSFPMOfm3Rn9z/0EgzRX1JlHlge3Yw/I8StoShA3n9Oqf80Ejo2ie/vkWbP6nlTyEpv5PMM/TbXb/mET/4mSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 04:49:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 04:49:53 +0000
Date: Wed, 8 Jan 2025 20:50:43 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z39Vo5FEZsapkQaA@lstrano-desk.jf.intel.com>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
 <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
 <Z2YMiTq5P81dmjVH@orsosgc001>
 <7bvt3larl4sobadx57a255cvu7i5lkjpt2tdxa4baa324v6va6@ijl7gzqjh7qo>
 <jamrxboal2ppniepfxpq5uzksd2v35ypymo7irt56oewcan5vh@zxmofyra5ruz>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jamrxboal2ppniepfxpq5uzksd2v35ypymo7irt56oewcan5vh@zxmofyra5ruz>
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: a6203fad-6442-439c-8cf9-08dd30690ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0xQUVJBc29hdURzdSs5dFJTdkZtQ1B2bm5jVGhZYVpZQjFjTjB1K2huUWw0?=
 =?utf-8?B?Rmc5VERuNk9UZUhBV05IZy84dlBDQmVuaXZsNDN3Vk45bzZqWXJrbGpzV2w5?=
 =?utf-8?B?SjdvRWhmS3gybUV0LzdjcEljOUVTQnpyNnZzVHN6RWRSNmQyWjJKaVlxOHpl?=
 =?utf-8?B?TkRiNkRRT003NnVuSkpqMEdaNEF5cW5SUXovWE1lVVliSFpGemtrNjFSL1Qw?=
 =?utf-8?B?RENHNlIxaEN4ZTc3TjZ3eUZzK3JPVGNNTzdmVUdFSDJPRmc0OURCU0t2VjhK?=
 =?utf-8?B?ekVIVUlxSTBIS3NILzBHMFMyUWMrSDQvOFc0NzlSTVRuRVZVMFFYUVEzai9Q?=
 =?utf-8?B?QUVNNTVzQ1diaUxOZjBqT3dMcW5Tb0hkaFlRRDU5cldQK096WXk5R2l1KzdJ?=
 =?utf-8?B?VGdyc21iVklBTm8xQStBbjFMR3RsMzY0QlE1TjBhTlZiRjdvQUNnWlF1R0FW?=
 =?utf-8?B?OTloVXl2VkJYdnZYN0JPdUsrUWhVak5malN4SmFqZUJST29YdXlraW8vQ2xV?=
 =?utf-8?B?YnY3L0g3aDhNcHNPaC84WEhMUXYwQUtqNmpjSzVkbm5GZk5Lalc5blR6UU92?=
 =?utf-8?B?ZzJrRDAxVUsyNWdLclRpd0Era3hyc2pMWElYNGZiYmo4VkRqOHM2TGluNnZB?=
 =?utf-8?B?TFdrdmRiRlVGalRwMEZaa3o2UnY3QXB4aVR3YVJSQThKVGEzZ3gzaFFXVkZT?=
 =?utf-8?B?WW5tWE5JN1JUbjdRVzMrT2dYWEsyOFpCU0pLUmk2Qk4vRXV4V1NRekk0RXBE?=
 =?utf-8?B?SjN5ODJSc0N2Y0hyRy93OXpVa2QvQVFpdWtRR0tSYXpmVE5NdHpybXhHVHpB?=
 =?utf-8?B?SU52Z0RMbllZWTloamtqVWkwOFlTTXRZS3F2WGlyYWdvKzBMblhGR3lOUHZl?=
 =?utf-8?B?dnpEMmtyMzJnZGZhd2E2bDQ0UC94YkdUT0J2MFBmRlJDSXp0WTVWaXZuR3c1?=
 =?utf-8?B?dVU0dUFCcDhFUCt5a3FwODhRRUZmS215L0RZV0ZEc01wTGNpNS9TU2pEalBS?=
 =?utf-8?B?aXJzTEM3S1RkdFgxWG83MHhSbHdka3lMdEhZeDl0VWpRU2F6YitOdkcyd0ly?=
 =?utf-8?B?QmFVWkJ4R0o0WXRkRkdpS0tGUlFPem9LckN1YjdKRzlybmpPNGNWK0JuSFFO?=
 =?utf-8?B?aTE5TXVHY1ZiWkxRTU1VV2RIZ3ZscG9kOFVwdjJTSzNIVTMyQVN2L3ZrajdB?=
 =?utf-8?B?MmR4RHV4bmozWEZ4WmF0dEIvd1hYK1IvSGFOVGhIK09zRkZZNXd6eEFjWnNS?=
 =?utf-8?B?dW9iUThYU3JzV2ozUkFqQXoxeThsYWhaQXl2OGl5Tk54TzVjV1MyM2MvMjVS?=
 =?utf-8?B?ajhoRlJaVURUTEduRnpzbWkvN2YrWWJ1bGFBK3NyNGo4aXpBenM3ZXhlaVR1?=
 =?utf-8?B?a0JWb3ZMS3UzWEI4cE1GWk9KWnk4MTc3NXp0L1pCeld3bU9WUkk1ZXpqUUhI?=
 =?utf-8?B?NXNsNDlKZUgwVjNjRDdyMW9VdC9wang1RGtncXY1MzEraTF4aVJsWTN0NDUw?=
 =?utf-8?B?ZUF4bGJnZDhhM2YyeFh0T0VLQi9adlNvMU9QZlJOcGkvV05KMFRVbllyZzJS?=
 =?utf-8?B?RTMvWkFQTUFhZGV6QXFVaXpZT0VnNGdGVjl6SEdUaGdLVlVDTnhhckFjL2px?=
 =?utf-8?B?T2pwYlhxNWtCTk53WnM2SnBsd0dqdHhreWtpb2VDZ2RpY2tYUE1OMHFRdjA1?=
 =?utf-8?B?bFdTQmkyVjBRQ0tKQjdJNVZjbml3V2toTXVYOVZpV0FUOHZPTitZdy9LbHhV?=
 =?utf-8?B?elNwZUl3NzFrVlVrRGNPR1FIN1JZdmRIb0RMdGJES2ZOdE42aHZpaVRwU3Fy?=
 =?utf-8?B?TFdlOTR0dC95NjJmUG4zdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxwUlMxS3cyajNZcjlCbVBvTUdiOG82V1E2VUxVZDBHZzd0VkhwR21HZlN3?=
 =?utf-8?B?VHRMUWZ5SUNqV1pWeDRYOHRQZkQxRU9aZ05XSndNaHlmZVAvOFRSekozYWMv?=
 =?utf-8?B?Q1plRkdSMWFMa3NBUGJnZ0w3eklBMGJxaXQ3WXpvTnlrRWJvRjUyN3d2SWo2?=
 =?utf-8?B?YmNKK1JQSFhPdXpySnIyVzJONW1VR1lQdUdyODVpUlUyYXZuemgrcEs3UVh5?=
 =?utf-8?B?UllVa053anphOXprNTJLL3VaY0VORy9hbzZmQmRsSFNLUDlpNmNaajRBeWpj?=
 =?utf-8?B?RHdOVXR5NldWRlZ6SnZaNld3U3FDajJqbVFBWUlDSnphZ0Y5aHY4QmtLK1Y0?=
 =?utf-8?B?OFRNMWh4bzVNYm1WdkVLUjFFR2tWNlJBMzdXd0dPRzYxeUFwTGtoNUZDVERN?=
 =?utf-8?B?bG1LOTlFa2N3MjBOK0kwOThzOUlKdFRLQUo2aFRiNFVEeUlRR2R2RjIrSGRU?=
 =?utf-8?B?OG9URTVvUWZMZmxHK3NxL1JzeHFXSkYxTnJGSFlTMmxCOHl1L05YK014WWlm?=
 =?utf-8?B?U3dSdXBBVGdMSTQ0QUNDajdCY0FoOElEd1hSNXdlZEk5RlFBOGljTXk1cUUv?=
 =?utf-8?B?dXRlUXQyZVFiTit4dCtIQnlYd0VHN2dNMDM0VllRTXpzQ0JSckFhd2VScGtE?=
 =?utf-8?B?blloUldGeElacFdad1VReG9YL05hOTB2RTJaMENFaklrbU5qY3dsUTB5Zlhn?=
 =?utf-8?B?eXgrVE14VTNLRUFjS2RKaElTNHVBNWt6bWZpNCtJZ2krSnVnTWtUMmRsK2Nz?=
 =?utf-8?B?dVFBcVJhWmdibUQrQmMvRStpU0p3SlU5VFJsZFJieG54UG1nTUpWdExCY2o0?=
 =?utf-8?B?eC9uVks0V0dLTzFxVW0wSWVIdzdJNjZsb2ZidmVaWVgrazhUd0pjZlIyMFpo?=
 =?utf-8?B?RGhsUzY0RDlaM3ZXbnJ4MEt0TTFETDJvNmkxajZ1R3RWNnVIVU1FcUJCMVdW?=
 =?utf-8?B?ZWlNSDN0SEhRNU40TkFOeXBpWUszL3JVLy8rYVJWSkQ0bFkzV1BVVS9DSmhG?=
 =?utf-8?B?N2ZXS1pvV1VmR0ZiREpEelVWTUh3YUtTN0M4eWJySS9QVXhqaDQ5dVVQSmov?=
 =?utf-8?B?aER6UnNjQWVpY0NseUUxNlQwQWszNG1iclhaL3Zhb2h1d2M3azZ2RGVTbzVx?=
 =?utf-8?B?eWF5SFl5bUd0ZEdCSEVzSjR2ZHRyVXBzeHdzSUczTGQvUW5PVTI2QWw2ZG9K?=
 =?utf-8?B?Z2pKeEYrSjBjZWRrWEYwcnF3YWt3SkY0YllWcE5OSVpodldZRm1XNDJmOXli?=
 =?utf-8?B?UXdpQTdJSFgyR1ZwTkhuMGorNXNtQzJOQlpQQXdSUG1IMVhUK0lzekdOQTBL?=
 =?utf-8?B?cFNya0pET3N6Q1FOYTJYYnRlOGRnTFZlK2xiM2VFRjZZV055Q1I2bUQ2RGdv?=
 =?utf-8?B?VHJ6blJDaVdUdDdGZDFlSlZ2SklSMCtTWThlYWo0SmptNTlKSElScFYyeGcv?=
 =?utf-8?B?R29DNXhKOTdacHR6QkEwbDV5ZmVYdkR5ejBCMDM0Rm8veUZnRk5pb0JiUGhI?=
 =?utf-8?B?RGNVWk9qdDhzRmtRR0dYYWxEc1h2TjJMeWNidE5VTWQwNlE1djRsZHJpWFVN?=
 =?utf-8?B?L2RMUUdqUE1aQ2QyOGw0czZJcHNvamRjc3lScjBzVGZQSmkrelZKRk4wUS8r?=
 =?utf-8?B?UThDdkY5OFNjZ05YK0dwZGZhd0lsczZRL1FuZW44ZzU3c0hqQ2ZaeE5RaURo?=
 =?utf-8?B?MTV6aXFsUG5NNk5ON2RlZElpQnRLNkpFelZUVnpBQW1mU2tIQkFwVUk5VzAy?=
 =?utf-8?B?WGw1Y2FmS0JFdTRMWHBYVlViWXBwRGxMNUprbWdtWUVDRkV2OEVkR0taYmta?=
 =?utf-8?B?L2RKSTdhaWFHOUNFK1dtSVpkTEJPQWlYdStISXlGRm1pSUNabkZ2SHF5ZCtl?=
 =?utf-8?B?S0lCN1BMTGMzWGRLd2hOSmhhaUJiWVllL2J6cUE4TklCdlMxK28wTENzRjVi?=
 =?utf-8?B?U3FlUVFqNnE5M0JQZFR0QjZHUXh2cmEzM3R5VHdoUUhhb1NZZmVjQ1JUQlFo?=
 =?utf-8?B?SC9aSEdDYVhZZjdvRzZqNnlwR25xamNmZGIwZ1Y0cXFPUmdMMFVXdDd5cVFo?=
 =?utf-8?B?c0ViR1o5OUV1bTJoWDI4M2RHa282Z2ZFWDE0UjVBU3NTdjBiUU5lYW9LUGx2?=
 =?utf-8?B?clBNUnFoSlV6VjNWdlF6SzJQMUQ4ZXBrKzQzYTZYOC9QNzY0SGxaVzJ1U3Fu?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6203fad-6442-439c-8cf9-08dd30690ea0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 04:49:53.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUykTpxlmtFIEylYRMfzRbG+KB/Ammh+nUwESHMwo3zGF7xjYuUDGYTs6jBKtMrg9IsKD1T6wpVsLmRXzlUasg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com

On Sat, Jan 04, 2025 at 01:19:59AM -0600, Lucas De Marchi wrote:
> On Fri, Dec 20, 2024 at 06:42:09PM -0600, Lucas De Marchi wrote:
> > On Fri, Dec 20, 2024 at 04:32:09PM -0800, Umesh Nerlige Ramappa wrote:
> > > On Fri, Dec 20, 2024 at 12:32:16PM -0600, Lucas De Marchi wrote:
> > > > On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
> > > > > On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
> > > > > > This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
> > > > > > queue file lock usage."). While it's desired to have the mutex to
> > > > > > protect only the reference to the exec queue, getting and dropping each
> > > > > > mutex and then later getting the GPU timestamp, doesn't produce a
> > > > > > correct result: it introduces multiple opportunities for the task to be
> > > > > > scheduled out and thus wrecking havoc the deltas reported to userspace.
> > > > > > 
> > > > > > Also, to better correlate the timestamp from the exec queues with the
> > > > > > GPU, disable preemption so they can be updated without allowing the task
> > > > > > to be scheduled out. We leave interrupts enabled as that shouldn't be
> > > > > > enough disturbance for the deltas to matter to userspace.
> > > > > 
> > > > > Like I said in the past, this is not trivial to solve and I
> > > > > would hate to add anything in the KMD to do so.
> > > > 
> > > > I think the best we can do in the kernel side is to try to guarantee the
> > > > correlated counters are sampled together... And that is already very
> > > > good per my tests. Also, it'd not only be good from a testing
> > > > perspective, but for any userspace trying to make sense of the 2
> > > > counters.
> > > > 
> > > > Note that this is not much different from how e.g. perf samples group
> > > > events:
> > > > 
> > > > 	The unit of scheduling in perf is not an individual event, but rather an
> > > > 	event group, which may contain one or more events (potentially on
> > > > 	different PMUs). The notion of an event group is useful for ensuring
> > > > 	that a set of mathematically related events are all simultaneously
> > > > 	measured for the same period of time. For example, the number of L1
> > > > 	cache misses should not be larger than the number of L2 cache accesses.
> > > > 	Otherwise, it may happen that the events get multiplexed and their
> > > > 	measurements would no longer be comparable, making the analysis more
> > > > 	difficult.
> > > > 
> > > > See __perf_event_read() that will call pmu->read() on all sibling events
> > > > while disabling preemption:
> > > > 
> > > > 	perf_event_read()
> > > > 	{
> > > > 		...
> > > > 		preempt_disable();
> > > > 		event_cpu = __perf_event_read_cpu(event, event_cpu);
> > > > 		...
> > > > 		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
> > > > 		preempt_enable();
> > > > 		...
> > > > 	}
> > > > 
> > > > so... at least there's prior art for that... for the same reason that
> > > > userspace should see the values sampled together.
> > > 
> > > Well, I have used the preempt_disable/enable when fixing some
> > > selftest (i915), but was not happy that there were still some rare
> > > failures. If reducing error rates is the intention, then it's fine.
> > > In my mind, the issue still exists and once in a while we would end
> > > up assessing such a failure. Maybe, in addition, fixing up the IGTs
> > > like you suggest below is a worthwhile option.

IMO, we should strive to avoid using low-level calls like
preempt_disable and preempt_enable, as they lead to unmaintainable
nonsense, as seen in the i915.

Sure, in Umesh's example, this is pretty clear and not an unreasonable
usage. However, I’m more concerned that this sets a precedent in Xe that
doing this is acceptable.

Not a blocker, just expressing concerns.

Matt 

> > 
> > for me this fix is not targeted at tests, even if it improves them a
> > lot. It's more for consistent userspace behavior.
> > 
> > > 
> > > > 
> > > > > 
> > > > > For IGT, why not just take 4 samples for the measurement
> > > > > (separate out the 2 counters)
> > > > > 
> > > > > 1. get gt timestamp in the first sample
> > > > > 2. get run ticks in the second sample
> > > > > 3. get run ticks in the third sample
> > > > > 4. get gt timestamp in the fourth sample
> > > > > 
> > > > > Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for
> > > > > run ticks delta.
> > > > 
> > > > this won't fix it for the general case: you get rid of the > 100% case,
> > > > you make the < 100% much worse.
> > > 
> > > yeah, that's quite possible.
> > > 
> > > > 
> > > > For a testing perspective I think the non-flaky solution is to stop
> > > > calculating percentages and rather check that the execution timestamp
> > > > recorded by the GPU very closely matches (minus gpu scheduling delays)
> > > > the one we got via fdinfo once the fence signals and we wait for the job
> > > > completion.
> > > 
> > > Agree, we should change how we validate the counters in IGT.
> > 
> > I have a wip patch to cleanup and submit to igt. I will submit it soon.
> 
> Just submitted that as the last patch in the series:
> https://lore.kernel.org/igt-dev/20250104071548.737612-8-lucas.demarchi@intel.com/T/#u
> 
> but I'd also like to apply this one in the kernel and still looking for
> a review.
> 
> thanks
> Lucas De Marchi

