Return-Path: <stable+bounces-126867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA37A73472
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EE73AA822
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C720E6FA;
	Thu, 27 Mar 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+IEH9iI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384D1D52B
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085850; cv=fail; b=naWPj4h6TcfNRetDz+8H69KmCT0Ald7V7CK7Lt7XfIlzB5l1BGJEI53AzzWUAkEP/f37lVzbzgnAx22W47v5/Y8bEHIxOwE6iT08Xv3t0p39NqNIhGe/TZx9zAnM77F6g+uH8EESGwRLY4K5Dg3w67ze3Cnuf/MYXKIt/hLvJAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085850; c=relaxed/simple;
	bh=wDj7XK+oFdp9Dx2iTXZCvXgtCqRO6n1D0Gi/5XAFDqQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GurGnoqxVaQMkrFXDLYl93ThANVXgJ0VLa/EgqxrKTKC0USDHmXYadMch8V8EBbQGM8HtZB2B5WSQstlvZ3ngXO9R4rNKqKRcdcuctMSBKr5zFiUOBro4c32pj+A0456jaUYqXNAh64fzDLtlJUgnUEERXyT/YJCiYrWpH1uaY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+IEH9iI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743085849; x=1774621849;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wDj7XK+oFdp9Dx2iTXZCvXgtCqRO6n1D0Gi/5XAFDqQ=;
  b=J+IEH9iI3QePHAlhSErVh0BMLK8UVHL/kLm2NTYSkgiMYj0FMAtNIVDU
   gFJZaQaH+iYtwbtRpkoxiTS5N2O1L4YtyLy36DvpfpmjaGRieZyvH+6aE
   QrGABid9zqs6xLxL8tc09kOsrw2qx+F/IxQvjvw1Fzherl9ozLojcrAQz
   +ddCCcpOe0s4F8OfrMIZiskDHkm3UyiSjQlNjfC2GeV2fblAPyiRn7LJf
   zHtNpO2Di34voJYn/EZfV8SeuGXhsKba3dY9GgnQrWdlxrVFK4f77sGND
   klElWLKbGuiCeb6oN1Siu1S9cms2gumhAOqibBDmHjxi4w7UBCaD5JyhL
   w==;
X-CSE-ConnectionGUID: 6+xNVpSTTw+Sfm0PZbl8XQ==
X-CSE-MsgGUID: BqTxYk22SOmzZXoNjdKpJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48080985"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="48080985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 07:30:48 -0700
X-CSE-ConnectionGUID: Y4Kx02SETzSaCPeMrnlwLw==
X-CSE-MsgGUID: 2+Fx8TQSQOePNoUqE/6Hrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="130261291"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 07:30:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 07:30:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 07:30:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 07:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8TA14ifkOE30osV37o970Bp8wAy68ZHY8pO4pnh33syRqvZMVTipbI4/Ag5LjGBPiqdVn1NCZ13TjU3B+1jIi8W/V1N4UcjMBNlcYluLc7ptn5wbGmhqgmrU6dsoo0EZ2tFHqVqi+8uWCE331CX7eEholzxGOleuHtRlpDj5UZYiqqUofm7lqqiMKlPKNAShxXNHtX2y0hN+lKT43FbR+DRgys2u8R9nJeiRqJp1Ek7RfvNTEDP/gFalIz36vJImUpz4T43XC8wWACR9foBfsudGxIOdvdNmUtTUhTTdCUSaO3CVq0Pcegq0ncG+ic7cwWAkVxpBeCq2mds2n4MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT1eyF0fsnuKaNtamlUV2+wb8g4SIisCHTxNEIZdzZc=;
 b=HHPhG9Hwg/d0dfT2YK3IaIa5EerPUlXY0r+nzIvbtZ+ChuVNAEQqt8hSwR/atBSvNikQmFxrr5b6tkRTangNxzey1MsUwYB5waqTIDmfkuD4xfyseYYLgwXNi8l9WZd4q0dnVazZSyG7tBt6RJ91C54YpEAyjT5PtXwiSibzltJFmfLtioFpwizn0E2cpFGx6gaRS+1u/djgQJ3iZgnSoXtK/+BZ2fCHG16uqrBRt1fJ/S+LHA6oHEkcOI0UK1Yx6894KuABQGU1hPLozKNaGive7P7tg60RdLxXbOy76wiRyyZdKYEhUeCj3K666QHyZ/BJDGBCA4Khfugp+gPH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:30:44 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:30:44 +0000
Date: Thu, 27 Mar 2025 09:30:39 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Fix an out-of-bounds shift when invalidating
 TLB
Message-ID: <fjbtky5outguskp6fs764xgiqmxjjm2bzcwkj6y43k52obn35i@2txudp4rxloz>
References: <20250326151634.36916-1-thomas.hellstrom@linux.intel.com>
 <0634c06e557f29fadca38883654720aeb1b989ed.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0634c06e557f29fadca38883654720aeb1b989ed.camel@linux.intel.com>
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA3PR11MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf14aff-08c8-45ef-62cc-08dd6d3bf558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7WrM2nZ5HtmTWBTSu/+Y/sLmBexoFTtisW8tBekU5a/N8m4W9s7SvPAd+D?=
 =?iso-8859-1?Q?NMsZBqoVwHks04/vToSW72WvPF7l81k8GYsg1xc73QNns2QDIakJVmi+nI?=
 =?iso-8859-1?Q?wxVkUcjjfDwaRTv0ivzfiph6iXjoKmSyn1/wb7g9tCn6r372SpWIgWBOxb?=
 =?iso-8859-1?Q?MWO97MUnk9HKMrQxW1JuR4gcVEH9M/nJ4GE9vJgF0580pIQxsQ3kRG5hxy?=
 =?iso-8859-1?Q?jl94BTpziJUEeUeKqddUy5Y3KXFUVXhDcmvf2HBUwO3v6BijmKdMUqPV8O?=
 =?iso-8859-1?Q?YE6z6W48Axyzs9xmLYLjL9nLh6mWQg0KwIoeOVr0ZzNBQ1lALzpLVP9vxl?=
 =?iso-8859-1?Q?Ixuc35ew25EtpMgYCZXIWcHvCUt7xMuemrRkNciUy4YHFxsjDoWAmvOfzV?=
 =?iso-8859-1?Q?T0N0tvNzaLYMaVNqoxTcnZ1eDrSb1ZzuFKLGghU4qygChLcflDsJ82ksNb?=
 =?iso-8859-1?Q?saEtRbt0a4fIJJj/urTNaCNW5aeonaEiFTS9MgcBmlGTqDx5UCocRi/qcY?=
 =?iso-8859-1?Q?wA3U75an0DflniQ7jKX9zn1VQLMPhKjeNzJs91nkucXWUFMHBPdvxXnjOT?=
 =?iso-8859-1?Q?j976goa/J0+azFQn4IyOu+rPhThIS2N5WJvenhkAaiJGBGPrCfOxseZuZb?=
 =?iso-8859-1?Q?0rsF40rW6Pm+4askGvNi0s2+7FEkn7lRGB7i3u5w83mE9bY14ScSs+/kDx?=
 =?iso-8859-1?Q?0hl1nyLVesHwrpEE3XlDpXx/CdEjqj4+Ul4zLKbHLvXtTWylDLPjQ5xXSD?=
 =?iso-8859-1?Q?xQnY3rwbpIO2pyJnqySyjELRW5K5DacboIoa2gVQX/LuiR8ENSF0Wkl2LA?=
 =?iso-8859-1?Q?oTrRWaRNmTtzdDalpBcAtakwvwT+N6RL6IG6DZdZdRVGFC9+X0abVb1lb7?=
 =?iso-8859-1?Q?xWlQGPx7ZhVQLLMYziHTGBWLqLRqduQ2I0TSWYRMu68JRySOvG6JF/Rf96?=
 =?iso-8859-1?Q?vw7zcB1I0FphT2GJN74wx0Tf3zZsXuRKcJ1GgH7p45+TpVP3iB7um9vncB?=
 =?iso-8859-1?Q?EiH6PFnLBNq8p9KXD8ks2qIdCSkZmuXLP76IDlo0KA5c5ASlJXsjzHj+1a?=
 =?iso-8859-1?Q?/sHN5vJYvQaPUI73DAW4ZVTzgnk3QtUEmWl/4gdqB8ISa76TbD1YTFY8Z7?=
 =?iso-8859-1?Q?CDq237otMwte+pCyPqaguTjcbDvN4BvxtyXGMyyM467DtR6lKx9mqVhCyS?=
 =?iso-8859-1?Q?k3nFIlerCC3IbzO5C9X/d+VazTIyDpo1jQxSanNxA4QCN0d0d5GTcAu54H?=
 =?iso-8859-1?Q?X/uXNO645gBN22PHQ4XGdwVuQFK+dIoU26lCWbBqn3FPiFh9LYeCFte9Ln?=
 =?iso-8859-1?Q?JKKHbqVgHIss+v0S4/CZtW2v09ijdZ3god8iBbesQF+8wvC0OfVijXIvPu?=
 =?iso-8859-1?Q?F6TyxVs9AmAUSQTfVpZJWjdb36orQUOLzf04ywKt0TXZofgfblkg6NYkyK?=
 =?iso-8859-1?Q?J6AwAcR3WkN8Bp6D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W7GAyiCs360LyMs7omEMNGTHV327evLnCmtMDDrsGggfrwE9CUisB0iU7q?=
 =?iso-8859-1?Q?uhyyiuDUhjTdrtTfHaE7Plee0kre6HINYlpk9RwQbf9ARBVl5OMr+V7/eB?=
 =?iso-8859-1?Q?phgZ0kgVuiARG4f8JHVEBR8Pxj9P71zSdOdAsXokOrEtqERKaxdj4ndZAB?=
 =?iso-8859-1?Q?4mR21JIAsQ20L0qpgLu7vbWvitf6iSCHclmt6vgWL+ULLzW1UIUbGwLS9U?=
 =?iso-8859-1?Q?k364paPDO/6R9wgZOJEC+2HswV5qmHNydk0RKbW2vm2DrYWetCn86KRwLu?=
 =?iso-8859-1?Q?yxSUs0kXiRhTtCGwVmZlzDhW5LsF1lNaqOMxnZolPxismoR2hEpACIulSU?=
 =?iso-8859-1?Q?EHZgn/RMi394ed9os2xVWuo8e3cfZ37lnn92znEfWZvgnoxAFVOfwd8+3Y?=
 =?iso-8859-1?Q?Kurhh16wuMoxcD0bI0J/QwO2R1zQU8V2lsVBpJBWdDpnecjHhMwTEbtSpq?=
 =?iso-8859-1?Q?ioZWGJK3gijqmsIyrlPxEICjXq9arC5fB/+RI+LYm9/2cZUku7fCE14lQL?=
 =?iso-8859-1?Q?kcB3i7s46+jF+G5gcEEBskJ+mFAN9H41sASa5jB633L95tHnAOGRn5m+nX?=
 =?iso-8859-1?Q?TA8S7lPzM0eG8EJz3CP5oPbvBwVr+jAvb9MZxbBibGbwTgN0DSM5ebUA+R?=
 =?iso-8859-1?Q?AbFL2/JA2mRjFEEYA0GBvpobxSmn64W3n6LE1CJG7aPuVQTHRc3IqOOD9A?=
 =?iso-8859-1?Q?uWzAsLF1ZrDcbMGppKq38EGCDv3ERXqcan7NG9qcMdlmF4FfmvMIS4bv3J?=
 =?iso-8859-1?Q?CWm9wPFesVir7LE7JYjXdu1/D8xh8UpGy499rSwXfdYgJD9aeamdB1Ud/a?=
 =?iso-8859-1?Q?UBRfNswVopzON/AwmpzwGl0ETtzvLzygcYHhHm+BkrnizSqNEse/2OZzeg?=
 =?iso-8859-1?Q?Pq8SEYpMCz/8KHpTHwfR7bANITsvcgKG74GVQV83ByRUdZqir44KqIhmtG?=
 =?iso-8859-1?Q?3kRVhQmOTtHo79XbQsd++ovZjAnPhPh2IY4VTvTeBQkBoJuBGclO6QO59O?=
 =?iso-8859-1?Q?lobDjduD59eVjsnBjsVvBrO41xUXW1L42qsS5VKckpRL7YARyCv4098678?=
 =?iso-8859-1?Q?8djHUq0ry3ZR4VgHau10QCE7gLVtdPUp1Vf/pe4ghYui0fe3HYhN/jHh6e?=
 =?iso-8859-1?Q?H2xj6//QYATfsmPaaHIJXkG1TZ4qbreROEORLn56bQpRU90X5yXoo7DIPJ?=
 =?iso-8859-1?Q?aEWN9csWrtKo4a+u95XoSvuD29EfqL122zkMQqXVPAFQ+S33JlXpxGz2iE?=
 =?iso-8859-1?Q?47CP0weohtwgsmzTwVBnF8vmJZx3Z38kavKQAggN7zy3puX3IOf7Sp9nq6?=
 =?iso-8859-1?Q?YK51bALGJewyfPZsvP80jBHICFx+di74jVfGxbbve9cruODueBJHr00iVH?=
 =?iso-8859-1?Q?9qntf4CevfABbTlX6R4DrfuLbofBcx8E+cHCndoT3qqxcSRpEjYr+fRVGQ?=
 =?iso-8859-1?Q?yryJ3JCOvLXWU3IhjpL4k872Rpel+uV8OiI9BzNT+yaJxzPj7DNZYPH1N0?=
 =?iso-8859-1?Q?usOCC92rBXuO+FWj6C0tdkxZ2ekg1K+ZS6dPsS6+B+VyZ11wB3rZgiMzEi?=
 =?iso-8859-1?Q?D5B3mqeVsM3QI/3vJOG/iU7Ik548jUb7faL9365PBFYZmrKJgpLujvmTG0?=
 =?iso-8859-1?Q?mT/6aDd6FvNbZn1vZED5wkMFbgyxX6Pj9VjdoCTVjb+rtBkKmjR6m/QA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf14aff-08c8-45ef-62cc-08dd6d3bf558
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:30:44.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XW7rI3buGeYRSBLxnJ9AjTPBngnvGcFRHNKhbTh6lkDNAvf9zgx945u5zpsCo2+kd5IIOGPTSxOQ9bs7oha1BqA1mSvqtn+LZW8q2En3n/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8021
X-OriginatorOrg: intel.com

On Thu, Mar 27, 2025 at 01:50:43PM +0100, Thomas Hellström wrote:
>Hi, Lucas,
>
>On Wed, 2025-03-26 at 16:16 +0100, Thomas Hellström wrote:
>> When the size of the range invalidated is larger than
>> rounddown_pow_of_two(ULONG_MAX),
>> The function macro roundup_pow_of_two(length) will hit an out-of-
>> bounds
>> shift [1].
>>
>> Use a full TLB invalidation for such cases.
>> v2:
>> - Use a define for the range size limit over which we use a full
>>   TLB invalidation. (Lucas)
>> - Use a better calculation of the limit.
>
>Does your R-B hold also for v2?

yes. I double checked rounddown_pow_of_two() would do the right thing
for a constant value and it lgtm.

thanks
Lucas De Marchi

>
>Thanks,
>Thomas
>
>
>>
>> [1]:
>> [   39.202421] ------------[ cut here ]------------
>> [   39.202657] UBSAN: shift-out-of-bounds in
>> ./include/linux/log2.h:57:13
>> [   39.202673] shift exponent 64 is too large for 64-bit type 'long
>> unsigned int'
>> [   39.202688] CPU: 8 UID: 0 PID: 3129 Comm: xe_exec_system_ Tainted:
>> G     U             6.14.0+ #10
>> [   39.202690] Tainted: [U]=USER
>> [   39.202690] Hardware name: ASUS System Product Name/PRIME B560M-A
>> AC, BIOS 2001 02/01/2023
>> [   39.202691] Call Trace:
>> [   39.202692]  <TASK>
>> [   39.202695]  dump_stack_lvl+0x6e/0xa0
>> [   39.202699]  ubsan_epilogue+0x5/0x30
>> [   39.202701]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe6
>> [   39.202705]  xe_gt_tlb_invalidation_range.cold+0x1d/0x3a [xe]
>> [   39.202800]  ? find_held_lock+0x2b/0x80
>> [   39.202803]  ? mark_held_locks+0x40/0x70
>> [   39.202806]  xe_svm_invalidate+0x459/0x700 [xe]
>> [   39.202897]  drm_gpusvm_notifier_invalidate+0x4d/0x70 [drm_gpusvm]
>> [   39.202900]  __mmu_notifier_release+0x1f5/0x270
>> [   39.202905]  exit_mmap+0x40e/0x450
>> [   39.202912]  __mmput+0x45/0x110
>> [   39.202914]  exit_mm+0xc5/0x130
>> [   39.202916]  do_exit+0x21c/0x500
>> [   39.202918]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
>> [   39.202920]  do_group_exit+0x36/0xa0
>> [   39.202922]  get_signal+0x8f8/0x900
>> [   39.202926]  arch_do_signal_or_restart+0x35/0x100
>> [   39.202930]  syscall_exit_to_user_mode+0x1fc/0x290
>> [   39.202932]  do_syscall_64+0xa1/0x180
>> [   39.202934]  ? do_user_addr_fault+0x59f/0x8a0
>> [   39.202937]  ? lock_release+0xd2/0x2a0
>> [   39.202939]  ? do_user_addr_fault+0x5a9/0x8a0
>> [   39.202942]  ? trace_hardirqs_off+0x4b/0xc0
>> [   39.202944]  ? clear_bhb_loop+0x25/0x80
>> [   39.202946]  ? clear_bhb_loop+0x25/0x80
>> [   39.202947]  ? clear_bhb_loop+0x25/0x80
>> [   39.202950]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   39.202952] RIP: 0033:0x7fa945e543e1
>> [   39.202961] Code: Unable to access opcode bytes at 0x7fa945e543b7.
>> [   39.202962] RSP: 002b:00007ffca8fb4170 EFLAGS: 00000293
>> [   39.202963] RAX: 000000000000003d RBX: 0000000000000000 RCX:
>> 00007fa945e543e3
>> [   39.202964] RDX: 0000000000000000 RSI: 00007ffca8fb41ac RDI:
>> 00000000ffffffff
>> [   39.202964] RBP: 00007ffca8fb4190 R08: 0000000000000000 R09:
>> 00007fa945f600a0
>> [   39.202965] R10: 0000000000000000 R11: 0000000000000293 R12:
>> 0000000000000000
>> [   39.202966] R13: 00007fa9460dd310 R14: 00007ffca8fb41ac R15:
>> 0000000000000000
>> [   39.202970]  </TASK>
>> [   39.202970] ---[ end trace ]---
>>
>> Fixes: 332dd0116c82 ("drm/xe: Add range based TLB invalidations")
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com> #v1
>> ---
>>  drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> index 03072e094991..084cbdeba8ea 100644
>> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> @@ -322,6 +322,13 @@ int xe_gt_tlb_invalidation_ggtt(struct xe_gt
>> *gt)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Ensure that roundup_pow_of_two(length) doesn't overflow.
>> + * Note that roundup_pow_of_two() operates on unsigned long,
>> + * not on u64.
>> + */
>> +#define MAX_RANGE_TLB_INVALIDATION_LENGTH
>> (rounddown_pow_of_two(ULONG_MAX))
>> +
>>  /**
>>   * xe_gt_tlb_invalidation_range - Issue a TLB invalidation on this
>> GT for an
>>   * address range
>> @@ -346,6 +353,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
>> *gt,
>>  	struct xe_device *xe = gt_to_xe(gt);
>>  #define MAX_TLB_INVALIDATION_LEN	7
>>  	u32 action[MAX_TLB_INVALIDATION_LEN];
>> +	u64 length = end - start;
>>  	int len = 0;
>>  
>>  	xe_gt_assert(gt, fence);
>> @@ -358,11 +366,11 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
>> *gt,
>>  
>>  	action[len++] = XE_GUC_ACTION_TLB_INVALIDATION;
>>  	action[len++] = 0; /* seqno, replaced in
>> send_tlb_invalidation */
>> -	if (!xe->info.has_range_tlb_invalidation) {
>> +	if (!xe->info.has_range_tlb_invalidation ||
>> +	    length > MAX_RANGE_TLB_INVALIDATION_LENGTH) {
>>  		action[len++] =
>> MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
>>  	} else {
>>  		u64 orig_start = start;
>> -		u64 length = end - start;
>>  		u64 align;
>>  
>>  		if (length < SZ_4K)
>

