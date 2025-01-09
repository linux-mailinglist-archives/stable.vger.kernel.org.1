Return-Path: <stable+bounces-108152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD29A08153
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 21:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF6A168C1C
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655541F75B3;
	Thu,  9 Jan 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etxOsUWw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CB1FE475
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736454071; cv=fail; b=h3XqB1VOefxaa2eVV5gNQHWwUWdS2SWtactyfAVadfkk5NBed+Uxoq/KYdhrLSbR7WjiVfPTOh4BCZvKQun2heUfGP8iVM6fOOFAh1vtgCwDGr8JxQEY3LNIcJMjTNaBNTbn3FDfQ8XAMEZcWcaQKIwZeqg6Rj+fy2Bty2Uv6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736454071; c=relaxed/simple;
	bh=NUqAXOYbDgVnIpC0jrSq6mdCUEIcygaruxEff6ZrdEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J2PDDkSWa07x3Po7tNILrpCBUib8L+aOHTVC8yMOfwwxVKxAQ1jBSqWwZAhncjmU2P+bISD6bSs3VFHq1jR0RuwaY7our4Bwr44KO0Rg+/cUW/eNjQ4+1CpV1WMvLatkhG2IONZoj7wONJUZszQZaJU4jVdDmt80LMgAv23TAKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etxOsUWw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736454069; x=1767990069;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NUqAXOYbDgVnIpC0jrSq6mdCUEIcygaruxEff6ZrdEo=;
  b=etxOsUWw6C8a81kYI+KTdXjUNNBYXdWN7vNXlBi/z8k7maYMIORAiWrb
   oTR/y4kv9L1dqywlWFUiRYm085ZpskWJKB0Jvv9bbP3ZnZ0sfLBPqxDck
   npq6sQPnwz5vHYl7O9UHkbuy/7/axiPJbIGdualhGfW/ID8vBdM/svfS1
   OeKpSNql17MBpWQSP2Gd1G88aLaPrM8AehZ6zgwZ9CmSKpOHPc27hgy3i
   SUZyhJknkQhO6pWZzBKgsAA7IyLDtbCLZWmaIPpyXkFqeLuyOxirv9DTb
   ZSOCSiFe+3OH9DeoE1A9zm9EAiejXQoC7VknBNjhgvhXs61z7zKy9FFJ1
   g==;
X-CSE-ConnectionGUID: vHfTEmY7Q/GuudJbI7gneA==
X-CSE-MsgGUID: kHO0nlyyQB+N8dPQa1wx/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54152508"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="54152508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 12:21:09 -0800
X-CSE-ConnectionGUID: TIo0ehIfTOiASSZI0T+tVQ==
X-CSE-MsgGUID: TCHtPPKAQua7NSfPRbwwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103708246"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 12:21:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 12:21:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 12:21:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 12:21:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldy5XPQOzZClRQL0b72lRLI0n+g+p2TDEJe42pW+BTuoX3vnCuLouqk2Uz7s3nrgSosVTw59ObN4LwP/au4szs+W9jblw55qbE2RCdSpcoJWKFSz/VDXxGQXHjO+7LMYB8YKDGj4EenhYAm+MKKzk07pr4yBBoF+4MIdx9bDONg5d5w0hoHAq/JC+eA1oHtGUGDGcdOLEmJN4lGTnwzhCVMSbp7GMuHe+MvZb8dlydU6PGtxaFvglvc+QiwdUL64WJL5fYd2YlqxW1jZQblt/49EStE4soHoFXNAYAc07Et7+5yPnwOcIQDQbnk/P4ES16EFkonERIgMGvMc6WrOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXw5V0qecDeXHeYI6zwQXFoZyidEE+mifQD9JVc1gw8=;
 b=V34XmBKlJ2jp4iMCocFGCXzXXoedeHH55bNXJ5Cvq5JB3KMnYKf58j0oCuVY445OMVszkDXjoy1npnR2yXb2duH1soRflVg/WWO8cGjNFONl+BixklAyyb20t5ACU5QfcS3MTur+ElvWDFyMqK/rOo+5gtRiqX6Vf47eLaZJxzumZjB0i/8tT+gbzynHLD8mnnZg7OnhnrUYBbL6aAQy9z4vm+ZFIouw7v7LkIDZga86u+Hw1hmB435qzmA1YKIrOwfpGJhPVUmVjavOqg/srXb/pyYFJIhaQ1Kx0EKUpvjVIz/zgBkkM/EB3kv31py0hqIrJmP9aSBX0g8YRW8h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 20:21:04 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 20:21:04 +0000
Date: Thu, 9 Jan 2025 12:21:54 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z4Av4n2wHAoOHMk0@lstrano-desk.jf.intel.com>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
 <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
 <Z2YMiTq5P81dmjVH@orsosgc001>
 <7bvt3larl4sobadx57a255cvu7i5lkjpt2tdxa4baa324v6va6@ijl7gzqjh7qo>
 <jamrxboal2ppniepfxpq5uzksd2v35ypymo7irt56oewcan5vh@zxmofyra5ruz>
 <Z39Vo5FEZsapkQaA@lstrano-desk.jf.intel.com>
 <ngkbkvqre4d4hvaiwtqcm7oz76b3wcbuzq3ueoazjd7ff3luym@lrjlwmac2mf7>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ngkbkvqre4d4hvaiwtqcm7oz76b3wcbuzq3ueoazjd7ff3luym@lrjlwmac2mf7>
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 91451834-2007-4678-3673-08dd30eb245d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3pQYzhidm9sNCtBMHdRcU1NSDBneWRqOUNiVlVlV0NQdkl6RGxkdmNBajEr?=
 =?utf-8?B?U2p4aHV6bE5BNEN6WUNWaVpsUEZOcndIQnExc3pXbnpCY1VGYUF0TWtsMTZm?=
 =?utf-8?B?eGdVVDNML0NKQTQwRG9jTy9oRTVWdWp5V1JVNC9DdThPZEl5WGlxRmxFRjM2?=
 =?utf-8?B?NWhSTE12bFBpdld5cnNrTWlLd3BHZ2pJbU9FV3RMUVYvVnhyVStFZThyZXR2?=
 =?utf-8?B?ZGtObmdPTHJrSXhZZ0RjUHpqZWNmZmJLWVBkQzFvbDhncTZ5R2lCTUlOeG9l?=
 =?utf-8?B?eGdDMEFONzZUY3pzUFFmKzNZa29EOEdheEYxL0VDeCttWmovQUtXUHBxZHZV?=
 =?utf-8?B?dTZEZDdoU2lDWjBxZkZ6elFqMHNEVFVqb1dRK2RBbEJjSmZjd3lEZVJzSGJz?=
 =?utf-8?B?R21hcEFhV2NXcGNSUnE4c1JlM3BSUUF5emsxdUxLcUNrbUl1aWhVMEovdkJx?=
 =?utf-8?B?dEFqOENhNEhVaThXNmlWN2tYSzgwbHdZUnlTRmRPSkZVdnBvYmIvcE50Wlg1?=
 =?utf-8?B?bm5PQVRKNWcyQUQrQjYzQUphV1RQbW1NT3hxRXpIMVhEQk9XU1JzUXVOU3lP?=
 =?utf-8?B?cWE0RURvLy9kU0x3MUZuT05XTkIyMXN0bmtDVXVXc1gwbWF6RGZIMGpKbUlM?=
 =?utf-8?B?Rk4xc3drZlUvSnEybkpqRjI0NGNCYXNrUlpvdWptWmpLOU9YZTJ0blUwMmda?=
 =?utf-8?B?L2tDam5QOEpoYllyS25iSUNZMTJrZGs4akdFRlluNWI2REh6eU1QTDhiQVh1?=
 =?utf-8?B?bE9CWVQrcWF1TjZZLzUxR3RlQXJpeTJXWVZ0M040V2FZRXd4eDNEclBxTXBG?=
 =?utf-8?B?Y3lFdnhValI5UHoyMGdVZG5rYnZST1VqbUpyR0xmUit4V1dtNnppcDJOaEox?=
 =?utf-8?B?VlBnazJMc0x0MFJWWXZnVENLQ0twVlgzWGhnRzJ5MlNPb3I0d2FsV1FDVHE2?=
 =?utf-8?B?eXBLeVJkVU41RVd6WndkMXRvdWM1NGpJVkN5K0g0Uk5RK1pyQk9wM3M3cWdj?=
 =?utf-8?B?VHNHWE8yQ0ZNQjFhcnhEd0VKQTkrY09VUytEZFZXUEZjaTdJaVdhajA2dWZH?=
 =?utf-8?B?TWpkOXdPUjE1bzJURkRyV1pBUTh3MEhyMkZFWGU0YXB3UGh0U1hadlI4alNm?=
 =?utf-8?B?bUJPRGtISzBHOVQ1UURoYmNnem5sUW9Sei96VG8wSUNicko5N1ErMDh3RHNC?=
 =?utf-8?B?MGZGZ1IyZlJ2UmpmbmRkcEZPc1krcXpjNjQ1Q0JpOEJydm1oNFVzbjFiZ0FF?=
 =?utf-8?B?elIyNnhzcVNXUnl3VnoxNG51WDRiRW9JdzMxVHdleG5adHY1S25KWUgyUlg4?=
 =?utf-8?B?NFhJOHBBWlh4Vjk1d3NrZGxKd1FRSDNzQmNTM2JHODJzZ3RFcVZqM1gwNHFD?=
 =?utf-8?B?emlqOTRsZnRqSXM0VjNQc0N0VGRkdFNxSVpBZUh6RHcyWkZ1YTFnVVpYRXNm?=
 =?utf-8?B?Q3VpNGxjUzBPbDZ6aXN6THpRVzRXOU44QWhCbU51ZjhmOEVKdGd5ZkNSSGxH?=
 =?utf-8?B?ZjRVVlY1d3FGR0gwZEFrK0FwNHp5OFZMWnhMT3FxNXU1NDVCd3Y4M1BoTDl1?=
 =?utf-8?B?QlNtMkJlN0ZZeXVrcEpyT01vWDhIbmJKclI2VWl5K1lJTThZbWp5d2toaytt?=
 =?utf-8?B?aVdpbDYrTGkya0o4b3ZrK3BKRnppY1Y5Q3B2ZHVjOGw1VXNEZXhUQnIva1gw?=
 =?utf-8?B?SkZKL3llWUZNWUlSbWhWM2U5a2tKOEJSOGRra25TSDNMaVg5TEJmellET0ZH?=
 =?utf-8?B?Z2p6REVMemFOMTJKTFhHalR5cndCMklBck1rODhOZDQ5bDMwaVFkd1BUV08r?=
 =?utf-8?B?SEFPRUpZY1NhdGFJUkZGUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhqZnFZWHdRcmFIaERmUUo0bzBPd2JUejRJY2RkVnh2QU50QzFOSGdBQ29s?=
 =?utf-8?B?ZWZKWW1BbVdaVDR1TERIS0RxMktMN0tpeVhoU09wTTVycXdvNjRTbkZwNkNZ?=
 =?utf-8?B?bngva2xkQVR1MUp1cDIrcFZuR3U3MGlNcHBsNWRPbHp1NlRzS1RyWDhaeklk?=
 =?utf-8?B?WVRPdkx5QXJLbzJRZ3Q2cVFVaWZDMDkyQkVETmhwaWRqYWE2SWFnNW5qV3Mv?=
 =?utf-8?B?YTFicjErOHlpZVNXSzJoYk5EZGtCS04xTTd3TDdlNmcyeTRWcEV1YmdBcGlE?=
 =?utf-8?B?VmlVQi8vSEdneDU1UXZlR0FmbzRaUEk5bnNMdk45b2VMNjVpQlQ4R3QzR0p6?=
 =?utf-8?B?bktub3pyaUswbDhJTmJKRG5aTUFtMlorWHVGYWF2K0FIQmZvNDlpSk12TFZk?=
 =?utf-8?B?MzlSNnlOaTNXZkpjL1I2TmRvTGlwNjEyblpQVDFxSFVsNk9wUTFpWU5CZHlu?=
 =?utf-8?B?MElXYTFjM3dPdWljMktueVduVlpDaU10OTZubm1DZ1FkV0F5Ky96dTVSRG81?=
 =?utf-8?B?TzRSSmZ1TkRMWlZhVzlDRkEzT0FqYmdQeEVML2VlUk9hS2I4M0xldlpmL0RL?=
 =?utf-8?B?aUJBK2x6eVgxNlh6c1NxZVczK0VkTEN0ZEIvb3pMN3phY0Y4bit6ajFZRko1?=
 =?utf-8?B?UVh1ZFVsMGxSTzg1ZERHamY1UTExNy9TaUNjakUvTE83QXFyQnFTa0FTNmJk?=
 =?utf-8?B?L2VkRWtyelVObXhNQ0NZYVRxNXpUZ21rMHNCaUkzeDRjekxJYnN5ZEV4eUVH?=
 =?utf-8?B?MC95WlJGUXZnbjhTaDgyeURGd0FZU3dIRzdGUS9xNmdGOVFMTmZ0T0p3VzNU?=
 =?utf-8?B?K0VvVTFZS1ZpK2RDRXNrekY3NlppdEZtU0JGa1VjNWJsT01IZ3dJa2ZUMitp?=
 =?utf-8?B?b1gzSHZwVGU0MUtXRTFsVnQ3RUVzZyswVm1KUFVOaGs4T1VsaWxjTHR4LzRM?=
 =?utf-8?B?MGFtSkNVY1hHYkZxUE15R3hES1NhM01Lc3NNUjNWc1hCMDBXbDA4Vi9wcVZh?=
 =?utf-8?B?ZWl6SWQyOFF3STBKbDVLbHFZNGtQdmQ3dk5OUHNOZmc2TnJPVGptcysycHpC?=
 =?utf-8?B?WVB6TzdyOVVrZWQ5UXVubklFQW9nSHkrTTVjaHpCM3ZMVHJ5OUdtNDREc3Fv?=
 =?utf-8?B?T1RJTVQ0S3hlZTJsVkFnUWZKRTA5VWtHTnNnYi84ejhiTGxBNFl0OWlXczFt?=
 =?utf-8?B?clNhUUZyaXBMVlNadTd2TlhiQ003WG5BYnB4dlRwVHFNRFl6cWIxL2o4bWsy?=
 =?utf-8?B?VFZITE9TWWtINUIycjlOeW1nZk5BUlUxUlVrbUpBS0NHbDhwRFhSUE9CV0sy?=
 =?utf-8?B?MFZCOVBwdm9UUS9TOE5NOUZvTkVhMDdUKzZqZ09mU0M4YlE3MHBnR1ZiQVdC?=
 =?utf-8?B?VzlMekxVTXBGTGtid2pEbE56Zjg1dnp0ZEFGTlZ1dUlnRHpqWXFVTEI3bCtV?=
 =?utf-8?B?M0Njb0VQVHVITUtFeUJucXFvVGlVVlQ4QzlDa2RjRFBIWmdMRkVDOGFndDZS?=
 =?utf-8?B?d0p2ZkFMWjBnNnBvc1RDY2RPTzRUdXUwUXRwUGNUd1NyeUlkQzUrQmRmdExM?=
 =?utf-8?B?cnpRb1llQWNyMVF5T3NBS2xCTWZLN0FmWkpvOE8wVTQxQTlXKzhEVXM2Rllx?=
 =?utf-8?B?VFYwVEY1c01aclk4ZEZrSStMcmpWTVp2VkMzVURQamJaSlA0cENmV2R6eGM3?=
 =?utf-8?B?TEEwZi84Qy9PTHo3TDZPT2FlSTF3c3dESVVHdDNhN3FsM1kxUTFaM3daOElI?=
 =?utf-8?B?KzhTVUFXSFN3REh4K3Nqanh1eTNMbnFyZnJZcmhCOEtFbXkveklCTFFYME1w?=
 =?utf-8?B?N3h2SEFoajFOazA2eWxUMStjMTFveGdMVEtIMDVqWHo5SWZDOVY2RVZ1aUR1?=
 =?utf-8?B?em5DaTJCN3dCTUdNalFlQjZ0c092aFlLT0ZIQ1dleTlaVEtZOHFPc3d1MFlG?=
 =?utf-8?B?RVBuNFNsSFQ4SnhNYW5jbmRXTkVjMWNEUkFBZ2hXUUt3Y0IrUlRBOUEvdkV4?=
 =?utf-8?B?bVVaenlod3cyeFVDb3JnbFdXYVNLNEtQQlNGTUl3WGwvYkRoK3hjL0RNK1dk?=
 =?utf-8?B?NDB2SjdOcFVZK2ZPRURWQmhFT1RxK0Jab0E3clJGSmsxWVQ1VFFkQ2tpZ3RF?=
 =?utf-8?B?eStSODNQZk41NitmUFVaeTVGdHAyVTRRUUZxQ1MxZEhzaEg3OGlVYkJSTkpw?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91451834-2007-4678-3673-08dd30eb245d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:21:04.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZhByj/NUGnud7jM3CKxzuYJso234MIGPUYoazD/1BiIzCvEAsYI7YkVJKfjAMxPPFBjE1TXu/qdsL2eh0SlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com

On Wed, Jan 08, 2025 at 11:19:52PM -0600, Lucas De Marchi wrote:
> On Wed, Jan 08, 2025 at 08:50:43PM -0800, Matthew Brost wrote:
> > On Sat, Jan 04, 2025 at 01:19:59AM -0600, Lucas De Marchi wrote:
> > > On Fri, Dec 20, 2024 at 06:42:09PM -0600, Lucas De Marchi wrote:
> > > > On Fri, Dec 20, 2024 at 04:32:09PM -0800, Umesh Nerlige Ramappa wrote:
> > > > > On Fri, Dec 20, 2024 at 12:32:16PM -0600, Lucas De Marchi wrote:
> > > > > > On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
> > > > > > > On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
> > > > > > > > This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
> > > > > > > > queue file lock usage."). While it's desired to have the mutex to
> > > > > > > > protect only the reference to the exec queue, getting and dropping each
> > > > > > > > mutex and then later getting the GPU timestamp, doesn't produce a
> > > > > > > > correct result: it introduces multiple opportunities for the task to be
> > > > > > > > scheduled out and thus wrecking havoc the deltas reported to userspace.
> > > > > > > >
> > > > > > > > Also, to better correlate the timestamp from the exec queues with the
> > > > > > > > GPU, disable preemption so they can be updated without allowing the task
> > > > > > > > to be scheduled out. We leave interrupts enabled as that shouldn't be
> > > > > > > > enough disturbance for the deltas to matter to userspace.
> > > > > > >
> > > > > > > Like I said in the past, this is not trivial to solve and I
> > > > > > > would hate to add anything in the KMD to do so.
> > > > > >
> > > > > > I think the best we can do in the kernel side is to try to guarantee the
> > > > > > correlated counters are sampled together... And that is already very
> > > > > > good per my tests. Also, it'd not only be good from a testing
> > > > > > perspective, but for any userspace trying to make sense of the 2
> > > > > > counters.
> > > > > >
> > > > > > Note that this is not much different from how e.g. perf samples group
> > > > > > events:
> > > > > >
> > > > > > 	The unit of scheduling in perf is not an individual event, but rather an
> > > > > > 	event group, which may contain one or more events (potentially on
> > > > > > 	different PMUs). The notion of an event group is useful for ensuring
> > > > > > 	that a set of mathematically related events are all simultaneously
> > > > > > 	measured for the same period of time. For example, the number of L1
> > > > > > 	cache misses should not be larger than the number of L2 cache accesses.
> > > > > > 	Otherwise, it may happen that the events get multiplexed and their
> > > > > > 	measurements would no longer be comparable, making the analysis more
> > > > > > 	difficult.
> > > > > >
> > > > > > See __perf_event_read() that will call pmu->read() on all sibling events
> > > > > > while disabling preemption:
> > > > > >
> > > > > > 	perf_event_read()
> > > > > > 	{
> > > > > > 		...
> > > > > > 		preempt_disable();
> > > > > > 		event_cpu = __perf_event_read_cpu(event, event_cpu);
> > > > > > 		...
> > > > > > 		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
> > > > > > 		preempt_enable();
> > > > > > 		...
> > > > > > 	}
> > > > > >
> > > > > > so... at least there's prior art for that... for the same reason that
> > > > > > userspace should see the values sampled together.
> > > > >
> > > > > Well, I have used the preempt_disable/enable when fixing some
> > > > > selftest (i915), but was not happy that there were still some rare
> > > > > failures. If reducing error rates is the intention, then it's fine.
> > > > > In my mind, the issue still exists and once in a while we would end
> > > > > up assessing such a failure. Maybe, in addition, fixing up the IGTs
> > > > > like you suggest below is a worthwhile option.
> > 
> > IMO, we should strive to avoid using low-level calls like
> > preempt_disable and preempt_enable, as they lead to unmaintainable
> > nonsense, as seen in the i915.
> > 
> > Sure, in Umesh's example, this is pretty clear and not an unreasonable
> > usage. However, I’m more concerned that this sets a precedent in Xe that
> > doing this is acceptable.
> 
> each such usage needs to be carefully reviewed, but there are cases

+1 to carefully reviewing each usage. That goes for any low-level kernel
calls which typically shouldn't be used by drivers.

> in which it's useful and we shouldn't ban it. In my early reply on
> wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4  I even
> showed how the same construct is used by perf when reading counters
> that should be sampled together.

Yea, this usage looks fine. AMD seems to do something similar to
programming / reading HW registers which are tightly coupled.

Matt

> 
> I will post a new version, but I will delay in a week or so merging it.
> That's because I want to check the result of the other patch series that
> changes the test in igt and afaics should give all green results all the
> time: https://patchwork.freedesktop.org/series/143204/
> 
> Lucas De Marchi
> 
> > 
> > Not a blocker, just expressing concerns.
> > 
> > Matt
> > 
> > > >
> > > > for me this fix is not targeted at tests, even if it improves them a
> > > > lot. It's more for consistent userspace behavior.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > For IGT, why not just take 4 samples for the measurement
> > > > > > > (separate out the 2 counters)
> > > > > > >
> > > > > > > 1. get gt timestamp in the first sample
> > > > > > > 2. get run ticks in the second sample
> > > > > > > 3. get run ticks in the third sample
> > > > > > > 4. get gt timestamp in the fourth sample
> > > > > > >
> > > > > > > Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for
> > > > > > > run ticks delta.
> > > > > >
> > > > > > this won't fix it for the general case: you get rid of the > 100% case,
> > > > > > you make the < 100% much worse.
> > > > >
> > > > > yeah, that's quite possible.
> > > > >
> > > > > >
> > > > > > For a testing perspective I think the non-flaky solution is to stop
> > > > > > calculating percentages and rather check that the execution timestamp
> > > > > > recorded by the GPU very closely matches (minus gpu scheduling delays)
> > > > > > the one we got via fdinfo once the fence signals and we wait for the job
> > > > > > completion.
> > > > >
> > > > > Agree, we should change how we validate the counters in IGT.
> > > >
> > > > I have a wip patch to cleanup and submit to igt. I will submit it soon.
> > > 
> > > Just submitted that as the last patch in the series:
> > > https://lore.kernel.org/igt-dev/20250104071548.737612-8-lucas.demarchi@intel.com/T/#u
> > > 
> > > but I'd also like to apply this one in the kernel and still looking for
> > > a review.
> > > 
> > > thanks
> > > Lucas De Marchi

