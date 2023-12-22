Return-Path: <stable+bounces-8340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530481CC72
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4B0B22739
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB5241E1;
	Fri, 22 Dec 2023 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYkpnlnY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194502377E;
	Fri, 22 Dec 2023 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703260653; x=1734796653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WFC5B61/WrG7nHhY8RqeZsye3h5VSf7BCIj3V1Xirm4=;
  b=TYkpnlnY/DbxcPvMo7TOkWckScpzepml1dTnGSGZyDScRdZUHcEMqaR3
   dFSSjq40fIwApTplTUNxy2J0/nLYgeaRmlDNUNbeteEkiCEScsZGJ+OUt
   800M08HX9UZH1L3xCip/7R89qLIydo4r5e0GxBpoz8vnfYaSpWDM1VEkW
   JvGgQJcVRXTLPSsI8YnhiTTv4Z/GWi2Ilb3TaSv0jIfForfwmhTfm0/YF
   tQvxvpahiuTOeFcq5sxQuboQ9kOowMPTTGpyWovM5kVqhWlSj/RxgEQ+S
   Dg26ULIiEBXyTURCvV644+Gl5ofmLeRmrMcxemWwh+aCreBW2HuPJ9OPC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="17698853"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="17698853"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 07:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="11488156"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 07:57:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 07:57:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 07:57:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 07:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loXUVSTQq8xiZgXG8mLlQnk5pgMoBUMrxT3UrVjbDhxUx8QfCdFd5b9mQ1OG+wE1+MswrOEfYRhsw0h295/HRJSL2XSalaMMzyxqzQzhauofU8n5/vwEp5ySqC7JZ5ps5Y3yaU/h5vsoLh1B/kpM+U+QE7CKrq6SK6f/lmdKubLwi1ou6F21fnyoFiDuWAfvJF/9St5hhcLa3K5noexOr8Vab5TvpxsCQhvx86bALgwIJ7ZZ6/blmE27+LNBaWoVMnJi2tpJs0+3DXHKUyThaVZo4UUrO7PWgKXF5WN8oTWgkFv9Wz9VDLxfrutW9fXZ3Ce+Oxr6MeL5lPDgwtg9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxgviTnCMJ7qd3dmSARM4VCkxKkpMWntgYec/fsXUDA=;
 b=CycDoU6njnqJemYglUWS1yuZ1H47kvOyvMGo8AkaeK/Qjva3zoqvKVYs6jmwKQRHidxp1ekOSFdZWHMgK+YIfRnOWNZOaU20daIppbgHYKAeCQEMJ4mTHnCtqFUldlXOBfh6at/uY4iWqhpbgH8xu2Je5tVlaW8j8FVkZqTpc88yyyAimDpGOJW18Q2/G9hB85wepyYLLwJ5nsmNGYWjDbPuxS0RCF0EUko8xUyXqrBpxc7aX8j5WDX6jsQPMSA05qov+CJzq7igUTGWzP43kkyxvDmGPjxg4juVPJVNIDiQ9RtsAT/1dM8G17OK6mKHcib59gyoohyd4b+HQX9qow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:57:22 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 15:57:22 +0000
Message-ID: <938a3a03-a465-4d8f-9972-885ff73f262f@intel.com>
Date: Fri, 22 Dec 2023 08:57:20 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/port: Fix decoder initialization when nr_targets >
 interleave_ways
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <stable@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	<alison.schofield@intel.com>
References: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: c17ea328-1b21-4cbc-8c21-08dc0306af1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjmLGL4QOSkUuZMH+IY++UbfV9p1hWfYi+jC2AWh+hWoDzPQtNnlvbb6KDoiAP8DsjyTpB0P514XxkeyRZVqU/+9PoygtqNOVeaUldDhJQa6/3gpMd4Hawa+1P6PW/2v/O9ep6muLlc8X0bUQ5NeLLJDeIJpN5tVj1QWvg/M/I6HZnX5i9w+WkAWvnTHguMcPirojP31OqNkByMYqH/pNGXriHtqhTKzDt2O36dK7nL2a+91RV4H/gnFXbVgT8aWDydry8vZACoQhzcZ4lIym2GKEDyxqJjppQDQO2EdQ03PdhgfQGHnyd1tfolpAZQ8HxkG+UlhLGcttz7SbB6R/8DLc/OkaUSyWcc8kdYU9maEQrg7zo6/32miCd3lCLeKnhqmb2QivF9DBsXm0+X3ZXigPcRJfrN1tQlCaMKU1vyGI7GgiLsKMHqu043XvOaVrbxE8F0NF1gzkxwVJDaGGwkdl0T1sXxO57P9a5EV4/RC5cAyRfG5IuSKC/UgfyhS992qxNGjnN5TNSWG33PZF9JZQrMuaLHWOF0HKbEJpq49FFSJb2zlvwDRnNuX9E9bjf7CumqBCtfh4tet7j/KvZsvBM+cuWTeoAoiSw4sFdQGWTAZDwlT46AKayOaEJNG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(26005)(53546011)(6512007)(478600001)(6506007)(450100002)(2616005)(8676002)(66556008)(4326008)(66476007)(316002)(66946007)(2906002)(107886003)(38100700002)(41300700001)(5660300002)(8936002)(6486002)(44832011)(82960400001)(31696002)(36756003)(83380400001)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpYK0xvNTVSUkxKeTljNHk4cFFuWE9oLytxdHdvRkVKV2xNU3YyR3R3TG50?=
 =?utf-8?B?RnVCeEhBYVhVdEY2RU54Z0dFUHJUcGVtb1RYWHo2TmtKVmMzdE55YUI1UGFC?=
 =?utf-8?B?c2daSHhnTWkxUG5xTTBlQ3VCTjg5M2d3T2diWTRwK3dZeUZVYk85QStRZGxq?=
 =?utf-8?B?dzNGZkx1YmhkZHBJVmtUSnlKZnduM3owQk0vN0JBVXhXazd4NThITnJjbEtq?=
 =?utf-8?B?bStlVGZBVS9ROVhWdWlISWVXMllnWUNGaml4VUhTTTBwdytzOWhJeXFScFJB?=
 =?utf-8?B?RXJZK0RhRENFbnBaZlc2STJnRDNNUGNMTkZGMDhzQ3FmNUVxeU1PbVpNQXlS?=
 =?utf-8?B?d2NySmM1Zkh4cEFFRkMwcmxxS2ZPTXUrdDkzamE0NzhqUFA5c2pDYUhUaTFO?=
 =?utf-8?B?Zm5MSUJIUmFaMndubTBXMG1Va3B6WGhNNXJxZ0Q3bTBUaUVNaUNyaC9LRjBT?=
 =?utf-8?B?blNnOFBqU012elgrcWJjUUQxN3ZIa1NwdWJOVDBFZEVEUGhxbVUvSDdVZlk2?=
 =?utf-8?B?VFlJbkpLMWpoNXVpV0IwdG91cksvWm9ZK0VwUENLallLclRIdjdpaEVBNTRv?=
 =?utf-8?B?d29xTFV4VFhrRm83OXU2Tk0yRDZocGZwbVJFMERNMnBwU1JCcCtxVGd4TXht?=
 =?utf-8?B?VURoTi9aQmt0SXFsRFY5MU9Ec0lPVlV3cTVKQ0wwQ1NsSWEycGVZNXl2WUxH?=
 =?utf-8?B?ck1aOTFYNTQ5MTRySjBEU2pPOC92MlFPYk5iWE16WkJ6WjI3REhmbGgxd0Zj?=
 =?utf-8?B?QlBjMWJNKzNNdDA3TU1iUWJLS3BmR00rOVErMlEyaFNYaENqZUJIbUluYzkz?=
 =?utf-8?B?UGY4elVRNUdGS1RrNjFkOEgxaFkrdzc1bW5KWlRPVU1VMkdpaHM4c3RNMlAy?=
 =?utf-8?B?eG5FZnpZUWRkdEUyRWh6eERxQ0lOUFFoNDgxMS96STRMNHk4UlR2a2JNOWhr?=
 =?utf-8?B?anMyVGJQTTFxdG9XdTk5Qy8xNTQxUUpHc2RlbzlwRXF1bHIyYkJDU2tTbjQ5?=
 =?utf-8?B?Rk9qdHRuMDU3N20rVDUwT3V2cHd2SWppMDQ3RHBPVUF4a3RwYjg0eTZ2NFZX?=
 =?utf-8?B?RFl5bGxNMCtRNDVWckNJV2F3cy9QY1FvazNsTEg0aVdQejREMmhodTlGME4w?=
 =?utf-8?B?K0ZPa0xjY25jUFlZM2xDYzhYbUFNUVNjTmNNd0xLYlYycFh0ZkJxZjd5K1lS?=
 =?utf-8?B?TEtseEd3aHBOTlA1cE5YOURwNnRrR29sRGVvN1hxZGFXOHJsbGYrcTdXZWZE?=
 =?utf-8?B?WVYzbXBrbE9KOEM2VGRUZzY3MmRocDNnM2dvY2YrOWZEN00xNXNTREpYY1Yx?=
 =?utf-8?B?aE92R0t5QnF3N2trQnJtQXM2NkF2NEtmSytON2N2eDkvTTdqSnNUKytTbmVL?=
 =?utf-8?B?RS9LYi83VENoQmtiOHdJK0IwU1Axanh4R2tlUzl4Tk1oQ1J6MkR4MTlyVmlH?=
 =?utf-8?B?Z2sydmxkd1RjKzROamRVUGpXV0RGdmQrYzYwN25vdnBrMWNydnBLc3ExY096?=
 =?utf-8?B?VXRZTzE5bktRUi9HZG5kTkE4NzcyQUhvTjBFTVJ2T1BtU3dPYzNDSng3dExR?=
 =?utf-8?B?VCtaM2g1bVpXNzJlb05qZ2ZIcEpaOEV4OUczQi9YYzJvcVFZaXVFRmxvRkdq?=
 =?utf-8?B?cEsrams4QUJ3aXlnSStETFJveDBzUzA0L2NDbnNSS1YrcWdFMVBWWmlmWFpr?=
 =?utf-8?B?L3VlNlpMSDIrVHlWOEVLTEhaYUtWcXJ3R3ArbjAycHVwRzQyeHpjcm1idlN4?=
 =?utf-8?B?eEVVS0dnUFg1YWxwcWJTdHdGTitzd0d1T0xYK1BNeW1lZ1Z4ZWd3c2Z1bURI?=
 =?utf-8?B?dm8wT2xOL1ZvUzRkV1c3N1kzWG1BSituM3oxRm9jcnlLTkprNWFIMXBXcER5?=
 =?utf-8?B?MkRmYnY2a1JndGxkc2J6WGZpUm5pWUg3WGhILzJxZ1FaVEI0cnJGN1ZmZHcw?=
 =?utf-8?B?M1BQTE5uMDk3cjdQTXlwWE5qTmNyVGNvUGYxZHdwQzY0dzB1VHpuT3RJQ2tt?=
 =?utf-8?B?dVNuOG9BU2YxdFRyZ3NFb1pwK1JKcEU4Z0VTRmpIeHNtL1A4UGpDdlJtUTNK?=
 =?utf-8?B?WTVQbjE1Tkp4SWhhZXphajhVamFoTUtMSEpXa0VZdUgyVVIyeHlnNU02aHlF?=
 =?utf-8?Q?KIwDA3woLJ18+rOgc3cZ59XAf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c17ea328-1b21-4cbc-8c21-08dc0306af1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:57:22.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OICsJx5+ZZ4zoiI89tQvt3tE/xnVPbdVml0hX1lu7L2qjopzwORgzuTor8Xf7lEbDNu5h8lf5LU2eDOSQoVFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com



On 12/21/23 23:12, Dan Williams wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> The decoder_populate_targets() helper walks all of the targets in a port
> and makes sure they can be looked up in @target_map. Where @target_map
> is a lookup table from target position to target id (corresponding to a
> cxl_dport instance). However @target_map is only responsible for
> conveying the active dport instances as conveyed by interleave_ways.
> 
> When nr_targets > interleave_ways it results in
> decoder_populate_targets() walking off the end of the valid entries in
> @target_map. Given target_map is initialized to 0 it results in the
> dport lookup failing if position 0 is not mapped to a dport with an id
> of 0:
> 
>   cxl_port port3: Failed to populate active decoder targets
>   cxl_port port3: Failed to add decoder
>   cxl_port port3: Failed to add decoder3.0
>   cxl_bus_probe: cxl_port port3: probe: -6
> 
> This bug also highlights that when the decoder's ->targets[] array is
> written in cxl_port_setup_targets() it is missing a hold of the
> targets_lock to synchronize against sysfs readers of the target list. A
> fix for that is saved for a later patch.
> 
> Fixes: a5c258021689 ("cxl/bus: Populate the target list at decoder create")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> [djbw: rewrite the changelog, find the Fixes: tag]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b7c93bb18f6e..57495cdc181f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1644,7 +1644,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  		return -EINVAL;
>  
>  	write_seqlock(&cxlsd->target_lock);
> -	for (i = 0; i < cxlsd->nr_targets; i++) {
> +	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
>  		if (!dport) {
> 
> 

