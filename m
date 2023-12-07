Return-Path: <stable+bounces-4936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3B808C21
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5931B20BCE
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666045957;
	Thu,  7 Dec 2023 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUo/OrpF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E810CA;
	Thu,  7 Dec 2023 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701964008; x=1733500008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=djIwtb0VNt7elO0hybBHrOcq/jVT8BKtc8zcmh3DdKI=;
  b=MUo/OrpF/cvJLWbnKrIkobw69cphQh3nZ4JVWpN4NNTi0KOtMaRg6UDF
   nkqOLFRmrdAPJdgPnR5AD2IcWFaUrOkoAzLhjJuG6qyRKfW40OeIfvWdM
   jgaMy/qTD/kvGNnPinNI+JqFkD9ODCDE9VEePLSuCMXiHfcX48mQirrr5
   xpQLLz7dkn20rO2weGh+MzQMgsALHenDUEALnPuB+iO+54HJ+x4yUIdEn
   H2OB2hl49xvpre+BAFLw/HokosAm8X8FJrXXyeM0hYNSXJPpTHZLpbpWx
   Pg0KBaD8RotQdPdN5TPBEi4jVn0Cq1fBxLs3QKvEvJSd7Qe4qdnllYssb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="379263118"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="379263118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842236545"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="842236545"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 07:46:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:46:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 07:46:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 07:46:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 07:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRjczLM0vhwZ7HnPQWx/SfwV8kasOnMjYTb8i22wZ3E3KSKnpADqen1qFoKyMGPQi29h7q+mvRTmZ4AUGo+n+dPZHL8ofO9Q1Wc7dpmgRv+lg6pnhp22ia+atINtvHalnibsnulwua+kSiNuqGK7hH+nYFCI0M7saYtFAE0mfCLjpg2AaGPpSMplOYqQLovGqDjI9jzzMyQ/vdYaneYEDAK96Vsu9GwvUVHwZemUnFm2iDs8iGDflUQlLHGpe2yUF1ciI0zh5ZoYIkDAJIYIdpn2tMZvBo9u+We0bjRYy4ceY7YzAEBOW9VKyQa7k18IaKnhrlcL1AYUbG1OH7mmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1Z44h6GRyBRe6eLf4G7RKcAxoVK0b9z3Sv1T6RkWd0=;
 b=ZwkWlcWf8wfLuM2vtSZybtXa4x7coIRsyzKoKUKARfeAuZQiP6mkf7rSxA80ltLQMWkH6lEJjVGKsqthFf8FG8BYNT7WIaoxef8U4gVDriGRtnZleAy33QFMJQJD82KvEnLOB+wjB6FzMMFkdI4YhzyRyXUnSpUHv28HMkowTtZqwQ3Hc2cosEqkRPLCcH27Xzj87tJPlBP/uo2VaMWyp1ecmtJjOx0SCthfLS5uUziBqSC7XSfBE5smAdHty1iTHV4Zq+lnXoGBoAxAXJesNgFck+E+8gv4sddicWG14Ln7+LYUOw84j3q1/t78mvevXRW/SfkS2a05IyLHvPUkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 15:46:35 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 15:46:35 +0000
Message-ID: <55146e23-2ecf-494f-9dd9-c81c6f9295d6@intel.com>
Date: Thu, 7 Dec 2023 08:46:33 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/hdm: Fix dpa translation locking
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <stable@vger.kernel.org>, Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
References: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b0e7c-a966-4a12-85fb-08dbf73bb18a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPC7WH+ZsNIYb4p3fdb8jUlLv6ixfF2WzkNutHxbOpHBwswukUMuIVCN7ylLe3Fcyw8hQ6bA55hX+dR47co8XyVYZ9MYx3mduLnfHvEGr+6vuaJ7ijESOCy/LZhtZudf5JzfER7VZmNr58OWEUv6g1nawW/o4lWawuioCMS+AoJAxokx9uLZGCjBlvBPxPljP03d49Oq8NIaZj37Hbxfq8dnwlj80uFLzjxYpFsPbLSm3f1QKDIZKp4Mxm6IZNEjbMuqEUlQTG4kojKQFCICrNVX7bcBeFFFLnWtqi2rmOLCGTWzBQtwhOXfGVb3BsD43CsePGHjgPQfG9vMbT/jrJ/NA5RutmXB0YH8soKtUB8RwyW34JnwQHOqxUXgioRB700erWM22Grfyi4vupTjaf1oG92L/JmEnjdUd8aINTNSGGTmkC9bHGj+tHl+77n9qKc3gl6IATehMJ78bO0s+nbX15j1MKhSMSzSE4VyzWrd/uG2Mb5qNWSlujptBkeeLb/aC8QEs5WYkB9x/x8eEVyldkvgRDnIwzk2B+OG04q7QBwfxlKmEa5zk7a3jCX1WauM7DbcOYgbHeTT1baR+wGohxrjDUH5mQhOJQuz/6fgQjuoIh5IjcLNomFAPlzlqCHqbuo7SZ3o4/NOAe6Bog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(8676002)(82960400001)(83380400001)(41300700001)(36756003)(26005)(316002)(31696002)(4326008)(86362001)(6486002)(966005)(66946007)(66556008)(66476007)(54906003)(6512007)(2616005)(107886003)(2906002)(478600001)(44832011)(53546011)(5660300002)(6506007)(31686004)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZjWk9EY1p3UE0raFlwOFowNlJuT3p3cG1vSzBjcytaYzIyVlF0a3VsV0tJ?=
 =?utf-8?B?ZmlkczBuUDB4VTRSWWxwRDdVc0cvcnRXMytIZzhpRkUzSHFQb2hDNjRUV0tL?=
 =?utf-8?B?VkVVMDVPUk54WVFQRnl2d3lKRHBJdEJlUU5CdFBJU043OVFUTE03QVRIZHZI?=
 =?utf-8?B?WmwrVFlSbnp0VXJXQUt3WGlvWDgwM1A0T3dXaVhmT2pidk9wOXNtUGJJM09S?=
 =?utf-8?B?clJPSmZPL05WcGlqbFlDNk9yaXdSTEl4MFVhaXp1YjFkV1d1WFJzWGtMNXln?=
 =?utf-8?B?VWJud255eURPUmZhWjdRNjdaUkpzcFdteGFOZFJCenllZFVzUXVEOVVOUTB0?=
 =?utf-8?B?dDUrTWtUak56dEVBd0w5TEtXVUg1RmtEWUY3YmlpR3ZNaTVRZXE0N09nM0FX?=
 =?utf-8?B?OXIxZXZLT2lFOSs2cVVtU3RkbjRnMER6NHE4MU42c1FwQWc0VUdXUW01TzVk?=
 =?utf-8?B?bHNsV25mYno4TXhYZWdBY0M4Wis2OUs3aFliUGwzMlN3VVpTSXUveGh5YWlj?=
 =?utf-8?B?N3ZZWCtoMG5aN1VWSXJ2K2FMV3VJMW1nK1c2cCtsbE1wcVFUdU9oanA5dDFs?=
 =?utf-8?B?UWhIOVZmODVGSG1Bb0V1d1QwdkRHbGN1aEEvRWlaZHFMLzhIYUhqdjNlUWxs?=
 =?utf-8?B?T1VESWN4RnZhbjNOclVySXhUa1paVWNOZWhQMmhWL3V3amw3MTNxdTUxVFN3?=
 =?utf-8?B?ZGoyU0lKMGRYczV4VDlwWU42N2tscHBwaENoVVAxZXNsb21wakVFUU00TWRp?=
 =?utf-8?B?cGd3OUs5b3RxbDduaDdqQUx5aW5QN083cDNITTFiQlpqNXozQU9nRS9PM28x?=
 =?utf-8?B?dGF6MlhsVnF5RGpmdnZBT2R0Qis0dmlYSjU4cDBCTWdxQ0U3clpIN2JOdjd6?=
 =?utf-8?B?Z1pqWEpnUVl6OUNoSG05d2t1RXdvV1pXNytzNjlENDM3YkVzY0hEMktPQVBS?=
 =?utf-8?B?M3ppd2FGakJ2UVZyRWxMbG03MitNWkwxcE5pUWlkZ3JMQ053d096Yi9yZGhI?=
 =?utf-8?B?WnNwZk5CNllpa0puRWZGRDJUb2tZdy9FMVBsUC9vbXRodkNvVDEvaWJlNldZ?=
 =?utf-8?B?d3dNYVlpOHNHUzFySTR4WHRxZktkbU5ncW9kNXhyanRKeWxnQkp2OGUrTnBv?=
 =?utf-8?B?UG4vSmo3ZFkvNGNrbzFQb2VMMUUzNzlVU3c0T1Rsb2dXbnU3L2xpM1JieGM4?=
 =?utf-8?B?SHN4d241b2Z6NVRYenZVSWNEZUlmVVVoWkJlT0gxY2hEdzgwZ1hyODgrU21K?=
 =?utf-8?B?blhsUU50OVFjQ2swZlQ4c3FEVkJMVjhmWWg1cVBuL1FWdHhVUFNmWWVGcy9x?=
 =?utf-8?B?UlZPSnZ2MWZLNE1Za0pHOElUQ0FVbFdxNHRsUXY1dDlOMlJ6SG1jSlM1ays4?=
 =?utf-8?B?ZFN4U09kMFpqUGQ1MnJ2UmE1MFJBbVphaUZJVmFKV0tjN3RPYjJaaFVybGc1?=
 =?utf-8?B?eXVpQ0pTKzNrd2JzeHpEMWRQbUwrYmNzZ3FpZ3ZoZ2srbm54NEhFT2dnMjlC?=
 =?utf-8?B?TG5RWVUrTUZDN0l6SDYrNEtZVzFGS0pyVmRKdGIyU2ZUQU9WN1p6TzlpVXBq?=
 =?utf-8?B?WjVvUHJTNndUelMrbzhCU0F5R0FWS1dNOUphcllPM3dMTjgyalNkdGUybUgv?=
 =?utf-8?B?WTlZakI0c0Zwa0o0NXlEZm92RTFXTUpzY1pxU0Q4d3c0MThGS3dWRWdrMkVu?=
 =?utf-8?B?WHpiVXVGNEt3dC9MNkRZN0VoS2o0YTJaOVFnc2thVHB3Nlc2cTZpaUY2RnZP?=
 =?utf-8?B?M005dnloNldLQVJFeXhNVHBWN1pJbTBMc0RQS3JtZjBxdThTVUtDOENacmF0?=
 =?utf-8?B?eUZkTUJmUEV4ZjFKUlpub0duSms4ekkyL3Z1cTBRb0FubHFHMXBrQWwrWTlk?=
 =?utf-8?B?Qmk5NTBhSENIQXFPV2g5NFhkWktNbEVzWXY3VXJpR2pld3o2TE40TGJRcnFn?=
 =?utf-8?B?WUh3ZXk2cjZnTWJCdGhockI5WW1OWjdTRHpsL1dIMm5jdGdMak0wUlp2U1lo?=
 =?utf-8?B?d0FFVGNWMGZPVWtjSks1MlhwRlFYbTY1N2xzcjBHT0dUQVVxNzNBalp3cWVr?=
 =?utf-8?B?eFV1ckdtYnVsVFYvN1d4eUIwV21pYlZHMlAxWlcya2Z5a2MyNi9XdUNPU0Z2?=
 =?utf-8?Q?q5PMopiSSO2tlxj14P5ZTNXXx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b0e7c-a966-4a12-85fb-08dbf73bb18a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:46:35.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av/ZIRCvVUqBOra/liBtoIa0UyNr+VEyz0k4wXMsj7o0h130FSK66h+kSwrTg4ZD1+DcyrenmzZ8Z74SDICfLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com



On 12/6/23 20:57, Dan Williams wrote:
> The helper, cxl_dpa_resource_start(), snapshots the dpa-address of an
> endpoint-decoder after acquiring the cxl_dpa_rwsem. However, it is
> sufficient to assert that cxl_dpa_rwsem is held rather than acquire it
> in the helper. Otherwise, it triggers multiple lockdep reports:
> 
> 1/ Tracing callbacks are in an atomic context that can not acquire sleeping
> locks:
> 
>     BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
>     in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1288, name: bash
>     preempt_count: 2, expected: 0
>     RCU nest depth: 0, expected: 0
>     [..]
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x71/0x90
>      __might_resched+0x1b2/0x2c0
>      down_read+0x1a/0x190
>      cxl_dpa_resource_start+0x15/0x50 [cxl_core]
>      cxl_trace_hpa+0x122/0x300 [cxl_core]
>      trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]
> 
> 2/ The rwsem is already held in the inject poison path:
> 
>     WARNING: possible recursive locking detected
>     6.7.0-rc2+ #12 Tainted: G        W  OE    N
>     --------------------------------------------
>     bash/1288 is trying to acquire lock:
>     ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_dpa_resource_start+0x15/0x50 [cxl_core]
> 
>     but task is already holding lock:
>     ffffffffc05f73d0 (cxl_dpa_rwsem){++++}-{3:3}, at: cxl_inject_poison+0x7d/0x1e0 [cxl_core]
>     [..]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x71/0x90
>      __might_resched+0x1b2/0x2c0
>      down_read+0x1a/0x190
>      cxl_dpa_resource_start+0x15/0x50 [cxl_core]
>      cxl_trace_hpa+0x122/0x300 [cxl_core]
>      trace_event_raw_event_cxl_poison+0x1c9/0x2d0 [cxl_core]
>      __traceiter_cxl_poison+0x5c/0x80 [cxl_core]
>      cxl_inject_poison+0x1bc/0x1e0 [cxl_core]
> 
> This appears to have been an issue since the initial implementation and
> uncovered by the new cxl-poison.sh test [1]. That test is now passing with
> these changes.
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Link: http://lore.kernel.org/r/e4f2716646918135ddbadf4146e92abb659de734.1700615159.git.alison.schofield@intel.com [1]
> Cc: <stable@vger.kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c  |    3 +--
>  drivers/cxl/core/port.c |    4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 529baa8a1759..7d97790b893d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -363,10 +363,9 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
>  	resource_size_t base = -1;
>  
> -	down_read(&cxl_dpa_rwsem);
> +	lockdep_assert_held(&cxl_dpa_rwsem);
>  	if (cxled->dpa_res)
>  		base = cxled->dpa_res->start;
> -	up_read(&cxl_dpa_rwsem);
>  
>  	return base;
>  }
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..f6e9b2986a9a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -226,9 +226,9 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
>  			    char *buf)
>  {
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> -	u64 base = cxl_dpa_resource_start(cxled);
>  
> -	return sysfs_emit(buf, "%#llx\n", base);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
> +	return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
>  }
>  static DEVICE_ATTR_RO(dpa_resource);
>  
> 

