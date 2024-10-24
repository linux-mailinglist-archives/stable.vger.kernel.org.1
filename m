Return-Path: <stable+bounces-88107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9089AED7D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 19:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B003285B8A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CA1C4A18;
	Thu, 24 Oct 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXGvEQvB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C51DD0D9
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790079; cv=fail; b=jfZHbiccRhN2BT+GQUbUjnuUgJdvPpoA0luXb4KImb82bTaSnWxa5lCTqJzE6fF82WvuaU7HWdGgv+BG56QNGkjMSD/BBRVcSJM7yS2MEGw1hQQfe05z7qfsaCZk1hejxFLbM0HV4ZI8hlQfjNDhzzQ0yAriYKPsF9Ilk4CaoCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790079; c=relaxed/simple;
	bh=SThEGFqSyLro8vg5M3WXVmmKqZsvj/lRh3rALP0KLAE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLd8TlKSpp/y6ocSiK0IRRwbNIO9iCTWBHJQOoxPUzw/Rc1fAJGuvnBWAZ6E+Olu/GnEnSGKoqlvx0oosuGMT8ta0afBXl37gRDJ97Hi66QdPyac9EM9BcX8myelYzpOP/mbNPrrdqZTGDpDc2QWlZw0A5XYyoY+tsMwRK/7V48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXGvEQvB; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729790077; x=1761326077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SThEGFqSyLro8vg5M3WXVmmKqZsvj/lRh3rALP0KLAE=;
  b=MXGvEQvBLJ+UjILivs2gOiANfKeZmgrt3AfWe8aoxMdJK0uxtxdpI/VY
   0dJyXk2xLvkyVWFbcWp3WBrkPRALIVqWUH5hSWsmqbHd7DqKdoYkma061
   ShdNaAZOks7tB3kmNK1iwg/h9/qNH9rWQoDMoac2JJuRc4qhYYUKKJyxA
   07KqwBNx7hPbTuRF5PIQF45uJpcBCF5pVSRLGQKHhDV1kPgNywjzBacs6
   VuRDtAY/gq+OTerSRPXRu8WSQ8Lxjnfv9nBE3t0md1u1gKoWY13wXH2Iw
   wQJn0BNSrILy64kZZpP63j/igmiLIsg6/AnWe9VVx9K1ycLj962B23Ens
   A==;
X-CSE-ConnectionGUID: ILtRXpniRPiVb6eGSEfJ4w==
X-CSE-MsgGUID: 3YDw2Mh0QmyUZjiycxLUIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29550085"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29550085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:14:36 -0700
X-CSE-ConnectionGUID: WsglwuPiT7eAjrSOT5Ksug==
X-CSE-MsgGUID: kZ3qiUICSdy2F1JviD6AAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80651095"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 10:14:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 10:14:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 10:14:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 10:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/iNIRXMF+sbaiwF1kSK/S7Yjyn2Q7FxYgs3Xh8sxgmRMTx1u1bSUTYaWZq7Mq1rFatERnuOin5Opj2WV4x+RuXCnKKzyEk77yc1ueL+JRlX2gZqK4LJA0J3PIjICXQ83DtU/uI7BpGhZyipUcoudeg5RGtHrFEkODCd9yXp6DUgUkZHhskIDb4rY+/lTMsbYCi1UuyLTh5iwczK+lzqQt30RgctofQlTXdguQX4vcTxcLWAnoF2JyBt0luGkfhnJ1HD6RqFPRSEtiugAVUSCT5LaQRo6VSuLo1ySqY+WTPdilv40pthpMEKKViwdZXTx70kEEocGMfZOS+FdqOEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbRj/eCKV1+uXyWKkK8BmzloGZHbkSgvuqyWtxfySLM=;
 b=xzd5AtK4g2VtQhRgC7M6J3/+dHsHC+vhoB56JSd0E3wX8e97oERo21T8kHrWz91e8rYhTLAzkXO4Xk3W0th0dhLBSApp5PzlQghJMxQnjW13pdDs4pAs8gnNT3aLVcwIN5dlP1tmyzAg2mjTsfGRgSO4ktRHVHoMh77WzfX0eZTp+tL+5DNLtheCejBfAOTQ7n1PsqhNY8OivvZZYgqmy1ogRt4pF77W7Rn3Q7QY1stjM7ybRqr18V1hSitBf7/2FvoQDImm4UsTaYsHGinZQs4NDpa1ZLZKNo/6ANLAo4G6yTrC0SDJIBjp0iNLoZucJ1tnpDuFEA04GI49x1FvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by DS7PR11MB6199.namprd11.prod.outlook.com (2603:10b6:8:99::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Thu, 24 Oct 2024 17:14:26 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%3]) with mapi id 15.20.8048.017; Thu, 24 Oct 2024
 17:14:23 +0000
Message-ID: <ed863a65-5238-4bb9-9173-d297ed953d1f@intel.com>
Date: Thu, 24 Oct 2024 10:14:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: Nirmoy Das <nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Jani Nikula
	<jani.nikula@intel.com>, Matthew Auld <matthew.auld@intel.com>, "Himal Prasad
 Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20241024151815.929142-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|DS7PR11MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8843a4-7950-4ca9-7b4b-08dcf44f4e70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE16bXlKbVBIeUpKZW81TS9OT2dYS0dxUUFlRVJvOC9tcHFtVjA1Zk5ROWdl?=
 =?utf-8?B?WHAzWFloWndVMHF6Tk5sdUtNMStRVVIvRVdKcExXRldpeER4ME5acmlZYmFs?=
 =?utf-8?B?Yzh1U1BlUjJ3Wm9YY2t3d0ZpRjVGY1ZtUjNHV1lsWVI5UGQ3aXFyVjZtQ3Ez?=
 =?utf-8?B?aDlNNXMyTzBORkdYZkZFRlltc1o0em8rME9JSEVhcUlKMzFPR2hEVGdkRnZQ?=
 =?utf-8?B?UWdkMkpkUzFQWTJ0MklzTnBMOUxLd3ZVR3U4QmhFVCtWbUVZYUNrdEQ3Y3p0?=
 =?utf-8?B?ZTRFSzFLVTFuUTBvS09tbHNzdjZjOUhkbnFlRlhQSVhEc2VhTjB2eXgzMnF3?=
 =?utf-8?B?VWNjdlZJa2VwanVGNXR6QlBPWmUxTkE4SHgrcDRwOXVabG4wSTkraGxNRS82?=
 =?utf-8?B?Vzh3bHlVZ3gxRTY3QlpCMktQK0Jla3BMa2xPZXMrbndQMmt3OGFmd0ZVZ3or?=
 =?utf-8?B?WnJ5N0FNR3BHeE1JYlZDd1JFTDhsNW1TbjU4ZWYwNWlwdU9JZTl3ejlxbncv?=
 =?utf-8?B?dERNdDMwbmRFSEtWT3dWK0JRRFUwQ1A1Mjc1YklJQnBPdmVyUkliMlhNR0xN?=
 =?utf-8?B?d0NaemJ2SXh1TWFvVXFrSnY1T28vdWZaN3FMQ1VLTmtqZEhZak1FVnRZVjhS?=
 =?utf-8?B?Vk9raUxKUnhvcnVnbHo1TEc5M2VnWlU2VmJUQTRmYUthR05OcWhDYXZ2UmdU?=
 =?utf-8?B?L2tFcTN5UGUwRmhpbE9oUEV6c2kramJKbGUvQW5ESG1mRVR1QXZlL0lwa3pw?=
 =?utf-8?B?TUxqS2ljaTA2ZjNndW5rMVlNVDFjWlBJc0tycUtkb254R1czWXEySHBaOFQv?=
 =?utf-8?B?S2MyOG1iZG5oZ3FvK3ViN1pEQ2M5em9ZVWcwMlVucUxQVmUwZ1pQN1NOY1ly?=
 =?utf-8?B?TUtQdStGUG9tN1UvQ0N2eGVFaCsyVWxRenBJQnhhaWsxUWhiQ0pRdFZCVVlq?=
 =?utf-8?B?eEVDOTh1aldmYks3aC9TQitpN1RtUjhoRndGVVV5cEsrNDFiQVNsbkxGMHc5?=
 =?utf-8?B?b0ZacGxrQ0RtUzlJWGxmbjd4NHk0WGdNdFptK3hLUXV2Mk9YN2RwNjJxeGdo?=
 =?utf-8?B?Mnl0a1pJMEpGNHE0dVBaZ0tiNFdmSjhQblFPUU9yMTBKc3lYaUxlN01lZkFB?=
 =?utf-8?B?MjN6QkN1MGJQWEVCaHlqbmFqSTR2Z2I5R2htdlhRWlEzTVB0dmtDUk40WmZI?=
 =?utf-8?B?cDZucnNEdFdlRS9GeDFqT2ltNG1HNkg0aXMwdUlPVm40cDhUOWhENTYrRWls?=
 =?utf-8?B?THIweVJpR3g2bkg5czVLU2IrcGFWdDkvbko5ZlZnVWdkNS9iUjlxLzdYVWV5?=
 =?utf-8?B?SFNHcWVVRW51UWhRcW9VQzZpNVB2d2NybG9PSllHMERLN3VCelo5Sm1sZEpu?=
 =?utf-8?B?d3picTA0MWMyRGFUMTBjRlBvTlpNOXlDdmozWmZhajJsa2Nmdm5aTFRqZ3Z4?=
 =?utf-8?B?eFRIcU4xVHNTYXRSKzlTVTQ0ZGpNWHFsZTBqYmJBVElOOHpKTG5lMmROSUNv?=
 =?utf-8?B?em5Gc0w1VGtwM0ptV1NkU3NTU3BSYjJMTmcyNDVMUFEzYnQ0ZEw1QzM0RHZv?=
 =?utf-8?B?VXVUVzZYWjRxdjFaaDVxK2JTZlVTckczekhMWG16Zk5aZzVObTU5M0U2VnBC?=
 =?utf-8?B?SFdBTUhWT1Q5VERCcENVdDRVdUg4QkN1YzVEOFVGUDhIbDNaL1VwWlU4THlr?=
 =?utf-8?Q?NyPRFww30YLbHCxaJTq9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3VkajRsT21HTVFpbE1XMFgwWGp6NmpiWnhYY0ZDZ0JXOTcwbTJRL3JzeHFp?=
 =?utf-8?B?Rkg4SDRMU1dGbmppanNKT0FSSFFDcWtsRktmdXNOVFN4U01Uay9xRjVUZHpz?=
 =?utf-8?B?NWZMT1dyY1hTejRvQlYwTWo2c2VBcmwvam9RWkgyNnErVDFURDlTUWFSOTBP?=
 =?utf-8?B?WWZab0dGbTd5S1ZSdzRKRGpGRmdiSlRGTFMvaUtkTlMzc0RPSHlqWDhCUk5j?=
 =?utf-8?B?am1NSHYyYXNsNzdiTWcvVUNpVXI3bUdsYXZMVTRPWGUrSXR5aE11ckl6ZDh5?=
 =?utf-8?B?UmFJa01vNjMwQzJTbTNkL2pQNkl2VXVydGpkTDVvd3NhZXlUR2xjY1N2VXVk?=
 =?utf-8?B?aEFTbDBSdnd4TDRCaWdhVDFVN2VoRllHZEwwVjMxWnY2R3Y2cjRSN3c4cnA0?=
 =?utf-8?B?ZURaUkRGNUFKVE5GRGZaYmZFQ3VtRUV4RGdpVDNwUFZ0ZHUwU3ZPN0F1SDIz?=
 =?utf-8?B?NVJmU2t6ODdwSXV4U1gwa3o3aGlYZDl5Z3lGeFNCSlZpTUdBV0NTRU9uakY2?=
 =?utf-8?B?U0RlUXZZdHNzVGhjTDkxcGRNM0xBWDJydkh5RHFNU3c4TmxsdnRja0dBb2Uv?=
 =?utf-8?B?RXR3bjJwWklzeTJnMnZnejlESWhkbGFGSHdPRWIvY1FXT2JWRkk1dWhoT1g4?=
 =?utf-8?B?TURsWWxCL3BTU1JORkRic1RySXpEejZUTGZVY05ybzA3cE1SVjl3N0tyWU1X?=
 =?utf-8?B?ZDRWalVaT1hqOGNjT3N2Vjh1bE9wWjY5eU9lZDRlNks5SWZzd2piMWdYVUk4?=
 =?utf-8?B?ZjlRMHhZdFdKV1lKWXFyZzN5d0pabkU1TFpNeDJFcVJycDRVZVJxd3Q1R05K?=
 =?utf-8?B?MnpySzl6d2V4L0h6ODVYTlBiTldYbWc3cEFRcnVqbGhHRHQ2OThFMmlpU1Vy?=
 =?utf-8?B?UmJteDYyeDcwWW04U09pRXZwdldxSlBOK3BaZmVpSzFQVy9VRDFrVGgyQzRT?=
 =?utf-8?B?V2dDT1BQRm1taHZLL2p0b0w0TkFuYmJTY05IUnV3ZFpTVi9sRWNLWU1JU3o0?=
 =?utf-8?B?K045S1JtTzQ3eEcxQ0RGanhjRW1BWVRqWHVScDE4L3RkMG13SGIwaHhFRFdD?=
 =?utf-8?B?SVpzQmxXMUhERlpIY0JKRTU0TkpDY2dqNWNHeUs0SFlpaHpNT2dMcHlpS0oz?=
 =?utf-8?B?WUFIOXlmNWZPVlJySE11aGhESXQzSDl1SVVtT1A4QmVZd1BUcWVuUWd1U2pr?=
 =?utf-8?B?ZVVIR2VWSVlmQnZ2OXM3Rk14b3BQRit1SjlvM0NFdjNwNitVRVF0WUFUbmla?=
 =?utf-8?B?MmlveVF1amhkbG5iak41anR0Uk5wNU5VbEQrcUNRTG9PMC9zVzlVVnU0K1Ni?=
 =?utf-8?B?MTV3Ky9BMkpxSmc1TGxEaWlSN0tEazRITXJDV1NZbE5xQzJCeStRZ2M4cExQ?=
 =?utf-8?B?bmd4KzVYUExCTlllekdaa0gvcGxZYkpQQm5uRjEzNWRwRmpkVU1pUSt6dEpL?=
 =?utf-8?B?aTA1ellYak4yVWFjTllmYlBBZWFRaTZPVTgvMU5JajdNN0hISWw1bmxJbDZt?=
 =?utf-8?B?Z1ROTVdqbEhKSVZqRnpwczBqUjJ0RjFySG5GMmtXOENqd2Z1YndRWU96MHVx?=
 =?utf-8?B?Rjg2cGJjMXZCNG05TFVKT0xsNXhSYlI4WFdvbnpzbEJZTkZBZ2lFejdZYjA1?=
 =?utf-8?B?Vi9BUFZPWkphRC9yTE9qN1FISm5ZQnRlYnoxVDJkMGswWFIwUnRKcHRDWk1x?=
 =?utf-8?B?c0hUU2szQ0FvSmlvWEpDVXBRQ09TUHgva2RoWkVvOUE1RWRuTzVMZ2ZET3J2?=
 =?utf-8?B?TzVoWVBYNUM1Q3Q2WE1GUUx6a2xJS2NDUXF2NC9ob0M2c25VWUdYWWxhTUIy?=
 =?utf-8?B?WGt3K3VLd3c5cUJZQkJSZXQ1WC82djl1akovZkZORGxValVMUy9OWmpyNnBM?=
 =?utf-8?B?Nkl2cFpLTXZVQ1NHdGZaNE1PRHhXSEZKTEUxKzZTM1R6WTVodkNzKzRybjAv?=
 =?utf-8?B?anNmUkkvOHVOSmdTcXZMSVZXdWhXRWJsdE9RQ0lhNXNwUXhONDVKSTBvUWJo?=
 =?utf-8?B?bkoxVEptSmFzYUdxK21DK1RVN3lDc3ZDNEZOZ1ZocE1CVXpUMnBqRkRrTVFJ?=
 =?utf-8?B?ZGNtcmpZcW5JNXl4L3MrZGZvbjM5aVVKUDJRSzhVaHdTS0NmZzhSNEFtSlNW?=
 =?utf-8?B?TG50SUtIVmpmSGdQL0Jwd0RKalNDTFg5Mm5DNmM0ekVmOXk0cEhHSXJSSkly?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8843a4-7950-4ca9-7b4b-08dcf44f4e70
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:14:23.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQp6ciG1s/ab0bXCegA/vD2akfxVa6AFSh890X+DMhOIG0uDCNxVHr6MuvkizRWFLZo/vcmX0SLJapv6sGV3rxOAL3qfUhqtbW/CtXerL4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6199
X-OriginatorOrg: intel.com

On 10/24/2024 08:18, Nirmoy Das wrote:
> Flush xe ordered_wq in case of ufence timeout which is observed
> on LNL and that points to the recent scheduling issue with E-cores.
>
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
>
> v2: Add platform check(Himal)
>      s/__flush_workqueue/flush_workqueue(Jani)
>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> index f5deb81eba01..78a0ad3c78fe 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -13,6 +13,7 @@
>   #include "xe_device.h"
>   #include "xe_gt.h"
>   #include "xe_macros.h"
> +#include "compat-i915-headers/i915_drv.h"
>   #include "xe_exec_queue.h"
>   
>   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>   		}
>   
>   		if (!timeout) {
> +			if (IS_LUNARLAKE(xe)) {
> +				/*
> +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
> +				 * worker in case of g2h response timeout")
> +				 *
> +				 * TODO: Drop this change once workqueue scheduling delay issue is
> +				 * fixed on LNL Hybrid CPU.
> +				 */
> +				flush_workqueue(xe->ordered_wq);
If we are having multiple instances of this workaround, can we wrap them 
up in as 'LNL_FLUSH_WORKQUEUE(q)' or some such? Put the IS_LNL check 
inside the macro and make it pretty obvious exactly where all the 
instances are by having a single macro name to search for.

John.

> +				err = do_compare(addr, args->value, args->mask, args->op);
> +				if (err <= 0)
> +					break;
> +			}
>   			err = -ETIME;
>   			break;
>   		}


