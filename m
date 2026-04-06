Return-Path: <stable+bounces-233435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDixH3MF1Gk8pwcAu9opvQ
	(envelope-from <stable+bounces-233435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 21:11:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95163A683B
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181F7301981A
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8039185D;
	Mon,  6 Apr 2026 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkKcEIBT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10884388366;
	Mon,  6 Apr 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502701; cv=fail; b=qvVfqR3DRC9rN3CHkiUZau454EG5yaFa5L+zwArsCLQdIDwrbuG9ykTu383lEVlj7WcQtsJ9ZY5Vwmp6yO5WtedONJG1VLqaFtTM8ZNZddnwYHyobTjlJ3Ua+1UT9jEB5JxwYoGpFLmTnJd24f4z3sHetjaWFGl7Wodun/Y8zLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502701; c=relaxed/simple;
	bh=1pc/LyeuDUMA//nI0GhJIg8LjxleMficc5uEJV007zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8TaLvD4B8Ic4hxzml5/6zZC+fzHQyUN4tEhGS1kZxclajWfd1G9QhdOKlmHo226OJvGVbvt9e6V8D3K5rzk7y8gclfFSeECPqgWcKyaET7SdaZEjFSLLuRLYItlNbftlTxWpA/mretQU46K3Tv3AKsmeqeIud6k0Ve++RktQng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkKcEIBT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775502699; x=1807038699;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1pc/LyeuDUMA//nI0GhJIg8LjxleMficc5uEJV007zg=;
  b=YkKcEIBT7kxZQHiDVg5rX9nuwUr/59yyoxskrfizZzCh4CrgH48RmAAS
   /k24lrY3R0KVgJmhKLJNzdLiIbP+VZvuVmIpwPH+yW05gsqQ5kcaGAvw6
   cJFjNcgkzsT6ylRCtS684uoTthFo9HnWjBuC0HhcR0MserpHLE8EZV/aN
   zB0gchoyXR78MGv83zrdkci0WqwnBYFRZx0H1xOOVSzVdJfxo0FG91gIV
   XZ8qfJgMQb1+yaCHWhkTGFBhsSka8jQ8KNilm03KplS+xSCYT5u41QxOT
   xmAt7FV9UaYGi1xGa7L1bffTkzm/qp2+VC3BiYlH7vQqSL1fjh0C3oova
   Q==;
X-CSE-ConnectionGUID: 8P9QRHRpRBWlxdtwry/mjQ==
X-CSE-MsgGUID: EIwLRkR8R3ykeaC6uvpuEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76526630"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76526630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:11:38 -0700
X-CSE-ConnectionGUID: AIT3iP0sR5qdY02Uw+gp4g==
X-CSE-MsgGUID: FZggQcK9Qpiww8fW6e6R1Q==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:11:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 12:11:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 12:11:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 12:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPAmXgHpIoxiGKcEB43uRi/c0uRpLY2eD573beba2pQCoMnd0KN6Pe1tzdJgyt3wRu2uL90IORIOdwQLCvC0ctWtD71AtoFPCNNGHFZSU7mp4WBO91LuiAr7KHiBRbwRMQVJehIepC7+bSa4IrDKyM4zB22Ta8M7kG93UD9rnbhEvshS1j+Pef4EYMz1D3z0zCUhwQ+y3xIJjFjWFwXUZk0NGapCFpj72aJ+oFPTvVynoyVv1BdhJUUN/WAuPXf3PCrP/aXiFYMXnVfLOtiBe1DTOdXykx1EyWiuEilbytNunU8FkvCT9XG4WixRsACsVbl2ogpxUzDgB1jiBKJPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iniYLQ+AY+oSfaum2VE93E/Oft7BWGHQ/rzsbcKKKs=;
 b=mq0iWGqccbTcF1H9US5Y3yCP/qz4fLIer+HWhK7IMq+7jxNntkV4CScN29i+WVKysMewqs2UcERkjb6FFGrdvHEIpLz9OGh8YhvMUDiwDG7ODgzX4X8l5bZrN9/g7GiO5tRgm/ub4mmIbJXTGHokF+jvMLnLux3BYpwGsZYKeV0+14zGCtRCrR9pJXUDmXk17+H2wWdAKhYmOxG3iW2DnVU70FzYCM/L480XNaOSSz6amjwL3oHVhSIEnTTRFCG8fic6Kyjj4H/7wgOPZPy0HNR3oTKgkrXUiF/2p3yq+zv4Zd/kJrnVJw4yYFTgqVDOP4BdXX6cwL7r5EnqyZAZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 19:11:34 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 19:11:34 +0000
Date: Mon, 6 Apr 2026 12:11:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, Alistair Popple <apopple@nvidia.com>,
	"Ralph Campbell" <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	"Jason Gunthorpe" <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, John
 Hubbard <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
	<dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, David Hildenbrand <david@kernel.org>, Zi Yan
	<ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
	<gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <adQFYAVGLqv6amZK@gsse-cloud1.jf.intel.com>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
 <adOtS_q1MuFOawGM@lucifer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adOtS_q1MuFOawGM@lucifer>
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 38088216-8658-4266-fdc7-08de9410517b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r/q7jeO0Z7VWORa+islw3wbJFw8SHFBvqijFgo+7LeO8+phf8/0/D2OJF3VQNU+LnVsbLnl+ylMaLxlMeEywKYs8c+lsrZvA9ih83GYg2lhD4l7zI1zzKsCABNEx9UFwQZk4zEpJ1TIZmoBH99BYRP0ee4W8/YnSLob3pF7POG3TQVvK32IkXz7CUHELC3ETUP9lKfH3GS3tk58lFv1Kp7DxNI09FrLh49qRM2tZwqMPY7B+ZZDfxDzwhLQbcEJL4gRKujwPiBbO3I8byXk4gfKuv1OdUfyGrddydB5JkJd3Ex13L7SzDcENfLr+0HJk2YwfIRO6GWBPUe/D9EoonFESnhrs+OtPFQeaBUOA4Jtk3qAKG6AI67H8bSnBYb5XZAjJKLCMZFg5Cw8H+pJcjpoMBdcl/7pFf6Pqa6RZPkAAdRBIYDU3DVLp1cfQXOLDrAjYHBStQVFAS4yiyLbZbzeKG3RCjpny+m8gnoMyxRP/hGuqo6NJUiUK6tedDH8jDDZYVxi8td68RZkGhphUyjwuYJQOHwsN3qHt9vM7FsBk0/r4OYl/02BXVtt06uVs28XRsWqCTyLfLdrIW3tH4nDSxxiMh3mpIabdzV4FA/+4vDEEaGeov+INnYCc5jWt9v5sOplbxYpeMThdwsqvZBiOq2C1+N4S2ECc/gxzjaZBu5Ga3EZmhKm6wJhVHEfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZEa0VBN1VLbHFXWmgrblRXNkJnZms3RE5TZU1jdnpjVGd2STdqcHFxVVVm?=
 =?utf-8?B?ODIzeTJEeG5hL0VIc0Q5RkUwQk0vYjZKNkNGa3VWQk9YeGdXZnQwWWkzdmlZ?=
 =?utf-8?B?anhnNVdJazNaQlNZQVd3bXBJR3E1d1FZSHJGZXlmUWVqdTRXZGMzdVdFV0FK?=
 =?utf-8?B?UHFUSXNVWFdNSU1KRjBTM0lFeFpmNHJtNktQd1kzdlhSNXF6OGwrSGNPaHow?=
 =?utf-8?B?MEdwUDFxMnRYQXZoWGlYc2pzczdHZ2JSMGpPWWZWQjg3bmhwVHhzeUZ4QTJo?=
 =?utf-8?B?a3BPUnBubVhEaEhUZ1h4VjQxOE51NjRiUUtrUDUraTVFVWJWSTJXNnF2WkRT?=
 =?utf-8?B?TGNDSE10bWt4M3owN1cxUjNISXdxdXZJcXBUbkh3cU9obmpUMit2SUpRdUVZ?=
 =?utf-8?B?OFBFNkttTHZuUjhDQnJ6SWMwbUsrRWdEaGdKTUxFUDdYUmw5ZTFiY0M3SGl3?=
 =?utf-8?B?OUc5SlUxbWpMVFNkK1ZmK2NOdzBUWk1tdHF2amY1QkE5V1JTcDNNSFRMZjJi?=
 =?utf-8?B?WnUyYlFLVDlWMHN3Wm8zMXY3VlJIbndjdnJIL29SU2ZlMVd4ODkxamovVVda?=
 =?utf-8?B?WHJFazdyMVN6N21FZEdtWVNTL2EzVHVTZnFZemZGRCtwbVZDYmpLL08vTlFv?=
 =?utf-8?B?VjRYc3N1TVVoQWRHYlhDT1U0T1luVjZqeVFGUUxEL0hqR3BEL3cyMkZrNTBw?=
 =?utf-8?B?SE15bzBoekFSVXhGa0pJYUZpSlBna2I5K0RSVjhKeStORmoyaFlxWlBPQ1A1?=
 =?utf-8?B?OENFbG8wQWJrZVRZU2Y0MmUrVlM2NjBtT0pBeW1HWkdIbjBlcFYvblRpYTlL?=
 =?utf-8?B?QTNpYnZOdlV5MjNQYTJJU3loM0hxcHpXR0xhZVY0UlBZK1dHRlNYWUNodTJ6?=
 =?utf-8?B?RkJzRnVDWFEzUVFWUlBuaUtMcVpQeGt5MG4xVVJOY3NjZC9FdnB4V0Z3RnRZ?=
 =?utf-8?B?NG5CdXlHTXhoTlhOZVVFeHVlRFdCUWsxeWJ2Mm9HNisxR3Q0cjFGL1JQZmZ2?=
 =?utf-8?B?RTdkM0tGc0FLTUdaUUozUWd0MmMvdGhWYkxGMnNnNHV2MEt0OWNwL3BsZzlw?=
 =?utf-8?B?Y2lmT3VCVEdPY0dDMVBsQ2Z2QUFoS3hVUFYvV0Y5T1VOSnpiYzNRV1FNbzI1?=
 =?utf-8?B?YVhOeHZBK1l3TDFHRFNqVXZMSFY2WU90TExSMWJJdE85Zks5ZEZLdWdnZnhy?=
 =?utf-8?B?RzVoU29ZWHhzQ0ErMjBxOEl6ZjZ5cFIwUVJ0elVKMVFPbWl6cUw5Mk1KNjlj?=
 =?utf-8?B?QmJHenVUVjAwYStBQmpLU0hScG0vaCtVdkhDckFwTGQ4MjZ3aTc5U2poUXM4?=
 =?utf-8?B?VDlhaXlhVzZHeWEzQXNQUE1BbWhRMVUyS0FGNjZ2U1dxLzNwYjZ0bEg1MkFs?=
 =?utf-8?B?RDZKMi9IaUQzdnNyUzBmMVpZWHUrL1hQMkVxeXNhZUo0Zmw1ZVQ4Qkw3TXdn?=
 =?utf-8?B?eSs4MHpHQlhEelMveTRDV0c2Q3BwN0FvaGJVaWJNbUVSc0pSSXc2Vi9USG9B?=
 =?utf-8?B?ZmdlMFhDOTFGbmtiUnZLRjlwOU9RZVdpR0k1S05jR283N1M3RmROcGhjWGVh?=
 =?utf-8?B?RUZWNXlnYzcxYW1GNU1HTW1qclFTRVhZdTV0WkdWUFdXbm5YbkRiUWRqOHNP?=
 =?utf-8?B?MDJyZ1d3dVloNkthSTVMWFFXQlVyVERTWjlsWWgvTU5SeGhQZVBQUGVkVGpl?=
 =?utf-8?B?eHphTTZEdndEWUplQ0x6cW1yQjlaa1VDQTB6d05kYVg5R2hycEdqWkFhQSt3?=
 =?utf-8?B?dlVmTUtEWHRidy9udEMrWEVFMkhGZU5IL29GSDlYRkJGdWZ1UzRrdEhWMlNJ?=
 =?utf-8?B?d056Uk1wSGV3dmhYMzNUUlYyelJRZWNuZVpobzlDVEdkZ1IvQXJyWUxBaVJx?=
 =?utf-8?B?bUNlbllicGdSc0FTRmFSSklKZGJNa3ZTamlEL0lFRldDM3JEWktmYlRHUGVR?=
 =?utf-8?B?WGpsN0hHMlZBY1U4VlAzMENpMGVHK2FFZC9tTmdMY20rMnM2OFl3Wmh1M1ZQ?=
 =?utf-8?B?QWFpaDU4d0ZiTmJmMldFU2RzeGhpR1lSbWY0clhWb1JhQmJhL3ZOOUdYcTMv?=
 =?utf-8?B?ZDkxdkR6MDNsaFZtb082MFRlT2wvbXlVc1pFZ0wrNjFlVVd1akVOYmgxRVE2?=
 =?utf-8?B?MGFpSXBzYkl1a3pKZ1N4ZHV4bFF6NVFkWC9lZ1lQaXlXWGFkaHpNMWRsWlpL?=
 =?utf-8?B?Vk1IUGIwSTZianpyVmNEOUxIY1VEaDVLVTRzb3dUdENXSTNWdzR1WkhORExS?=
 =?utf-8?B?bC9iek5EalBxOHcxNlNxNzhCaWhDMFNkOU90M2tnNWM5eDdKb3Bna0FSc0hU?=
 =?utf-8?B?TmwvamkycEthZGtGUjNoRFJQK2hraG4xcEJMVXAxam5kQzlweUR4cmFocGZ6?=
 =?utf-8?Q?JIh28MyYhSmu3RUQ=3D?=
X-Exchange-RoutingPolicyChecked: ojGWN2ELAMiKlphVvCH4Yuq7q+yK6GNjiJl6jx3rq7UC1NCqWRjA7FNM9AIcoKPI2ZTFAjQ9WwJc3/vPSvYPzX2SFsl0Q8NsLpSEmJuHGGPjZywEyAY0qGdurB1hcXdzbTk1AaaEnuTZ6gi9/9mOi0h1SrH8iEvzyNafg/NUCn/zOwjNVjHBfNGPfX1ca9jAxzpkOOeMOqQ28u4tiI3sw5x1hsj0WHhMNpC+mAiUcc2Sz7CtFKPCMZ4CU3qsBS8sAgpA7KwhR97j1VBewr7lMp0mH0Wnzgzs2NQ9Uuv9ubg4EQ4xJS9szsIVEPIYA4zr5W930ODn25zybh+17k65qQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38088216-8658-4266-fdc7-08de9410517b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:11:34.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw3Mh7YtmyJJvvmzE1kfei6xjgVHd6Dtzt+nfKzMzPJh1aSx0IasSiuzgumxZTvzmXzLhUIiwIvHKy5m9ahU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233435-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,lists.freedesktop.org,nvidia.com,lst.de,mellanox.com,ziepe.ca,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,sk.com,gourry.net,linux.alibaba.com,infradead.org,oracle.com,google.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gsse-cloud1.jf.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E95163A683B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 01:56:49PM +0100, Lorenzo Stoakes (Oracle) wrote:
> On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> > I see John gave a tag (and he's great so that gives me confidence here),
> > but we should really follow the procedure on this properly.
> 
> Oh and just noticed Alastair also :) so that adds further confidence, so this is
> really a point about cc/M signoff requirement going forwards.

+1.

Andrew did ACK this via DRM here [1].

When we take external subsystem patches through DRM, our merge script
requires ACKs from an external maintainer, as determined by
get_maintainers.pl.

I’m not sure what happened here, but it looks like Andrew’s ACK was lost
on the patch, and somehow our merge tool allowed it to go in regardless.
We will be more diligent going forward.

Matt

[1] https://patchwork.freedesktop.org/patch/703183/?series=161082&rev=3#comment_1294670

> 
> Thanks, Lorenzo

