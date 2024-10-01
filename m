Return-Path: <stable+bounces-78483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324998BCE3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577C61C23500
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C559C1C231D;
	Tue,  1 Oct 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2zPe3Lh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E431A0733
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787338; cv=fail; b=QDNr9my7a/y72jML1t/Cu+BdNW9e2kStogV6pfyeLf9yeN3Tzu8bMlR9eP9lrU2htayqVhUVA08FSBqv6cWpQBlQ2nVR+iHTIXwC/YimLG4nrG7QTByBFcZDR/Gj1YiZnCU1iEUgcyS2YPO1Li7Mu18bbV6SVOwy8BoO5ePu1Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787338; c=relaxed/simple;
	bh=EOaTSVo0t7/1OxwwXUfzqUUvj2ODbmoi5MXyMGuHHAo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pH2rMaBlEUdlmPJwHYxTMviYnkGa/SOzNblO1XCIWmqr+/11uzpH+ioYB78lWQXWPQ9AFq0pEut8INfGOhra9WnnUsRMiTrNhueS7o3frgl6xuXaMHXKTs8XK/R1UwyAHo2N38MC281i3eI4GYw1cTZahC+wVlfsElMGiIy3tG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2zPe3Lh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727787337; x=1759323337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EOaTSVo0t7/1OxwwXUfzqUUvj2ODbmoi5MXyMGuHHAo=;
  b=b2zPe3Lh/HTQZsQZlcFdTOehS6u8siOe+o0tnkVkHNkyjZGEye6rIrm9
   57FQ0yhoU5IuSby+k984rIuvhtNmAYrzpLRn5EaVePPuEPFTYr3MTzyuG
   9ARSx6lbWP1qiGHP+hoVer2hnUv3+r7nBdFZxhsLjwU74XxKi6UsH30wm
   96bS+iqgqCYDBRlAMm+YLY3b/OliMeoLimYnfg9Lk7lWJ8hjBGVaj8XQA
   g9HGhuFS/vfLv0xNp/xpn7BFSs3fwj3kcl4prfZpBWKgzS0cOqxSb0vnk
   xXnvYfKBZCB5WggFV01jKHvRw6OpH1/2x/kQPPg/hh/CibHUi2gZYWXKF
   w==;
X-CSE-ConnectionGUID: O9sDEdItS5WHzTUQF7T3bQ==
X-CSE-MsgGUID: tqYnhFdQRRu+hGQfivZ8kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38308717"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="38308717"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 05:55:35 -0700
X-CSE-ConnectionGUID: zr8TqyxET9WcUFgkvrkGSA==
X-CSE-MsgGUID: 4Dq/BzI0R16+xy/3ESzCSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73906209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 05:55:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 05:55:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 05:55:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 05:55:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 05:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDz7nFGROAQ3Gc2D7IleG4r1hc6rPxoPL1veVVH54QjhwM+uH3Imw9NFDj7v1RA92srjvsjgDT4YaACO7R1KKCmMqc1p9IBa0IQcNJ3dgmjPTpalnH0kxVXOUiU38Jr5j4Q07JqMl4sRhQbUXBp2J9N27aS0p03ltb4/ckkoKFo2dAsV1OaupxIkG93j8ZcizGF2hcXwvUpggja+aDgsRodJYEBbInHpFjqIMY66kevCJFXmBQ0+E8WW+wqloJUZ+5Oko/uDnJD1Rx9iOo36r38x0kOh3iv3X4r+kxEBGS5gwt1eYVvXFVRBoIgtvjpoKdDMkaD+1e5B6zsY6Xcr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZFapnY6A0f+c+/5u6VtNpSPK9Y6KPppyGnHsDU5dgc=;
 b=VxM6TjJylKuBjJOjJA1BznUh3Wv87yPZHAxHFk720m+zP6V86s0pAsuwqlUJcj6X69bnyHQudZmlgIPuZohLm6R0XufYjs8jTOLZbMXWbMLDzTC7S/bJEr3t6AWQ+WilJoPmhDh9VOVFbAiiv3gx9MRRjjx/m0P78XN1xDsd+cHTyXW+6T3axcPDLMfW3gjdEa1s5kGuOBKnHSDoZmq458Shs574AbfmiubrpHrb/KvwYYA5YdzYuO6leXRfOCUG0/EQD9sMX/MKk6xWDl++NlPguO1tc5LLqeNpQHoTGRPmYv31df2wLIugYIbzNWyLUSrZu56HioaBYri5SEnAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 12:55:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 12:55:32 +0000
Message-ID: <8b2988ff-17d0-421e-8cf4-3eafef1276ca@intel.com>
Date: Tue, 1 Oct 2024 14:55:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "idpf: enable WB_ON_ITR" has been added to the 6.11-stable
 tree
To: <stable@vger.kernel.org>
CC: <joshua.a.hay@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240930230835.2554923-1-sashal@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240930230835.2554923-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1661a5-f3d1-4ce6-35da-08dce21855c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1pzc3I2QmRYNFkxOW1TQUl5OFJwR3Yrb0M3YWtWNGpFbnBPY0dqY040akxv?=
 =?utf-8?B?U0srWGM1T0wzSzc2ajdaSTBiN3RNZitxZ3Yxb21UODg0dUI4aUc5L24yb3do?=
 =?utf-8?B?Y2pzMHV0Zi8xcVBmVnBOOE1LSTRmNEFCejI1bWZlay9EdUpTQW51UzBwallF?=
 =?utf-8?B?bCtQSFNEcll4R3JlSnVkRFRjc3JBdEFDSXhaUTAzSUtwTjJuZGpZMndJbmlU?=
 =?utf-8?B?SHM5amU4YVRKVWRLWkNta1BUT1FCVW5Mb0tEUlcrZTNBODNvdFV3bWlLZGFJ?=
 =?utf-8?B?YVc4TEp0cDhUUkFteFloKzg4dGNYRTR4a1YvQkF4UWlYSkhoOTFUd1pVSGtJ?=
 =?utf-8?B?dlVadUdZNGdrNFMrZWwyQlN1bjQxT1hLRVJkWngwRDJpT1NtcFJyelhBV0ZV?=
 =?utf-8?B?ZGpJdWZEcUdsYUhFMmZ2K3dXQnNwMXJGenlpa0FnSG0wMVdjVzZHSzJIQ3Bk?=
 =?utf-8?B?MS83ajVZZ0F4dmQrWXQ2VjR1MXJ0dk1hM2EzYnowbWF0TVRLNkVPNHZiZXNG?=
 =?utf-8?B?VVJGeE5zZTdSdjJzV25Bc2pkWlljeGdoS2tLejNkYVlsSUpod1BMenJScy9x?=
 =?utf-8?B?Mk1OcU5xNThCWjJDMFl1S3hBYVRHS0oyMTFvVjdxUDNXUWFuUitmMFNEL0tE?=
 =?utf-8?B?UkhycUxTQ2xYdEpVTGFQdUR1NkV4bFJDdHZ5VWdvSW5RVnhyemNzNDhkZ2t2?=
 =?utf-8?B?MmtEUENPQ1VQZFRFeFZFOFcxNTJUWUQ1a2VmakNHU3RMRzdoRDBrdmFPQW9y?=
 =?utf-8?B?S2hQS0RtS2ZvdDRhREwxTFM0OXpoZHpjZ2VtZXpTL0tBZVNNZ3UwcEVzL0R1?=
 =?utf-8?B?ejB2R0hoYlRvdFE1d3N5Y3BpdzQzQmp0MGhhOVF0QmJnL0NHY3h5WG11YU1O?=
 =?utf-8?B?WHZ4dnBoTkRNRXU5andNQkFFS0lrQW8yQ3R5YmRVRmRxZUJTM08wWks4UEZH?=
 =?utf-8?B?VDhCaDVMWVRNcjFwMGUvTkNRTXBkMDlXTkFEZGV5WDVlQk40d2dIZG1wQXVE?=
 =?utf-8?B?Y1p1bVhVNGdZdzJkVStjVWtWby80WUVlSVVWN0R3TllVMlVPTXpLVjR2ZHlC?=
 =?utf-8?B?RHlSUUhoUGpCbmFlWlVsMFRJNm5PbE9rQnUzQ3krSkI4QzU5SDFvVjU4SGgw?=
 =?utf-8?B?VFFBUmRZWE92QUJZcmlPU3lsSDJ5czRzejd4NWJXV2l5Y25mVzVmMWhCK1ZH?=
 =?utf-8?B?dEQzUC95R1FtdHNFNjhVNklvS3JiV1ZSL2VjemlyK3gvZ3l3dFFaK2VwR3JI?=
 =?utf-8?B?Z1c2WmxGZUpRa2c3cnp4eGl6dFByMzJQcldHcmduWi9SeXY3T2k2a1FYVzNV?=
 =?utf-8?B?YWRrZFkzc1N3SkZaSThVSzBYc0xKMzVhUVIrNTBOY1FrOHNPK1FYVEhYM1FW?=
 =?utf-8?B?TnNHVHdoakdQMGhldXRtbjJlemRBNEd0elE2bGZRZFA4ZjhKMEMrcHd1YTdU?=
 =?utf-8?B?MW1xaDQyNG1pRGZjUmZGOXdUdkFDTFJlL3g2RzQyRjhHN2xxNW9Ec2xCdGZS?=
 =?utf-8?B?OEVYNU16ajBXdnh5L2kwU3g5bVRKNjlkKzVJUDk2UzdLT2hxcHlTT1JwNm5N?=
 =?utf-8?B?Sm1LMzRuU0c0bnUwY3VpVjN4RE0rZ2k2UUpoRlpKSG4va1JXQVlUYy9PMW5L?=
 =?utf-8?Q?DTZ7/aYUtf6Q/1Q4d000x5Q6E9E2mlIclGx9AxImeCag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FxQ2tOdVNMcUNsbmxidzhSYVhjUU9NZ0pGM1ZIQzZrK3Fwa1hNRHR4NFhk?=
 =?utf-8?B?Z3RmTkk1dHBRbUV0ZGNMVENMN2p3d1pwTmJJc3FVcGRzNWVlR1BoR3dkZlhn?=
 =?utf-8?B?aE1DZFVnM1dZWmhYM3FKcGM5RFNsbkdLZVc1Mm1VZWo5a24rbjRPOUcxZmZJ?=
 =?utf-8?B?RjQraUlRSFZtdUsyOXVtelZiOURpa3Zia3JuR2F4eDhBanVkK2xFRmRLVVlZ?=
 =?utf-8?B?TzZPbFNKejBQcFRPanhLT2RZU1NmNHJ0bytwczFRYTRiOE1iNXNERVo2MTJq?=
 =?utf-8?B?UXpMTGxJaWQyWFI2WVlKZEh6dEsyWi9HajJwQWd1K2gzeTI5NytvZC9zYmFF?=
 =?utf-8?B?N1pvdC8yOWl4TUc0NlNrYXVhU2J1V3ZDbzlmcTRlWnhJeUhvY0dvNVJ6T2lN?=
 =?utf-8?B?SnpFNXF2QlM4VkJzUjczMjArdGRTa3A1YTFrQWpVNWhxbUllZ296YzRPd0lB?=
 =?utf-8?B?NE9VQWNJR0NmenRWRHVLU28vaERLT2d4aE9ySDhxNThLV1hpQzZaakxERUFM?=
 =?utf-8?B?ZDIyb3E2d01Sbm11MWh1QUZHc1RTYnNkSCttRnQ5RVJvR1VuOHNWaEs2VFN2?=
 =?utf-8?B?ZlFzZ3lYNW01Sno2aFBPRUlKQ2Ixako5ZVI2dXVTSTA4NzJqQVR1M05pVE4x?=
 =?utf-8?B?U3lYNlJqcDdXZmh2NXVqT3JRd3pETm80RndNRGVNMWNzeU5TMlVrS0dFVDZ0?=
 =?utf-8?B?T0lpZXVKc1NTNTgrUE45ZlppOWtiNjcvRkpLZDJRRFY1eFFSb21tTUpLZGdT?=
 =?utf-8?B?RjFzZXAyK0V4TEF5RjI5a0xqUmNybTFVY29RZmdKVTJadE1HdjR0ZzUxbFRm?=
 =?utf-8?B?YVF4Y1RFYjJvZHlyaWNQSkdpc0JiOFI1Q3FhU0h5R2JOVjJHV0p2dXpjUXZh?=
 =?utf-8?B?OEVzSmY0d0tqYjlhKzhDTUkzVFlLanZxL1RBTFpONGNaL1FCejV4NjNEdzNp?=
 =?utf-8?B?TVdxQnljbW9iUmQwdXFLWmVNNUEvOVE0bWlMOEFtc2xSZTZMRUhkaDYycW81?=
 =?utf-8?B?VFFMbVJtSDhWWG45UGVjN2tPdGMydVZYQ2crZVhFekFVczNKWmM5VDFtZ1J6?=
 =?utf-8?B?L0tLaGFwcDYycVYySnBzUForVjNzQ3RrNHEyZ0pKT09HWi8yVHZYZHhFaXlQ?=
 =?utf-8?B?MnlKRCswK1AwalIrNHlrRWFlU2lEekZ5V0hGZjA5WHNJWjd6bG92cm4xajZY?=
 =?utf-8?B?Tkh1bWtnaDRQR3NPZk90WWFyZitEUlpMNUI3LytVa1JUcjFiWkowaHphSTBH?=
 =?utf-8?B?RjBvOXIwOXVBUlFUb0x6L09Ed2o1czRudURYSlBYMGpkYWdTcjRlbXQ4WFNi?=
 =?utf-8?B?czJaeWpOeFcrT2xDb1hXaVJXVXg0ZEovU2NpZW1nSmp5VVVBM0Q5S1hHUjU3?=
 =?utf-8?B?VjdVeTYwMnZOQkVzcFNoNThkQW42djdQRFdsR1ZCc09OY3pMU3FFWGVKaExp?=
 =?utf-8?B?SnhGeGZNeDJQbkpKa3BlOWxCU1p0ci9VUW1MS2dJaEpTSENGV2ZBQVFwMm9I?=
 =?utf-8?B?a296R2tieXJXMGxONlI1YXk3Lzl6cG83a0p4SFJvQWtVSnhzbDJCbTNmVGhq?=
 =?utf-8?B?dEFrc1FEMjRWYnY3TjZ4OTJ2MFFjRTR3a1ZJUjUvUTZvVVdtdGR1RFlZNTMr?=
 =?utf-8?B?a2x0RThNSzhWQlVDNmhXeFJPTUVLa3kwQXc3THVZVmNjWXowbHdnbnFMNWwy?=
 =?utf-8?B?aDFUTGtpUUptNHJkUUp1d3Y1aWNxUmZiZUk2VTFHcDJmN055d0Zlb0s5VWFG?=
 =?utf-8?B?UGtYcjZlMk5ncEtTZU9weTlDaEtkOFVqNGQ5Z2N0K1pESU5iMFoxcjl4bUhX?=
 =?utf-8?B?L3Awcm9jM0lDcXlMQzYxOWZDMFJHNk9MUmN3Wm52c1I5YmxFU0Ryc1R4aG9q?=
 =?utf-8?B?VGo1cUtwdlVnYm9hSGhlTHk5czFuai92Q0tabW9qMCtnY1QwaFE0VDNreitn?=
 =?utf-8?B?c3ZiUDJXZzFpdnJ3WUEwU1ZJWWtnckV2TmpWN0hmUDRhdmtQazg4QlpZVUU1?=
 =?utf-8?B?N3RvMENyMjRrSW1yODNHWC9ZdEF2MU1VZVVlbVJqSzVWajBncE51aHc1TXJT?=
 =?utf-8?B?bWxqRUZxQzc1VmxndG9SVnN6MFpOdzRPYng1MkxkSXZXUW1PTCtJU3JWOC9s?=
 =?utf-8?B?ZFRhN0dLUm4yT3dFZmtSbWJHNWFNM3dhQVBSMisxYllZL0RMQzZSTHdaZS9K?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1661a5-f3d1-4ce6-35da-08dce21855c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:55:32.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87EVMqa1Cf7X9CLpTNo6UcEfe29DtrXe2ZcbAMxttsF+4+9YMfO2Lg76Rl2Fk42R6kLZcJ7OhHYR/Vlvey9FYXe5bhGFBY0/a/jg5qft8d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com

From: Sasha Levin <sashal@kernel.org>
Date: Mon, 30 Sep 2024 19:08:34 -0400

> This is a note to let you know that I've just added the patch titled
> 
>     idpf: enable WB_ON_ITR
> 
> to the 6.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      idpf-enable-wb_on_itr.patch
> and it can be found in the queue-6.11 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi,

This commit should not be applied standalone and requires relatively big
prerequisites from the series it was sent in, so I'd suggest just
dropping it from stable.

> 
> 
> 
> commit 31ffcb4f7329c601cd6e065d80e4485a468e9980
> Author: Joshua Hay <joshua.a.hay@intel.com>
> Date:   Wed Sep 4 17:47:48 2024 +0200
> 
>     idpf: enable WB_ON_ITR
>     
>     [ Upstream commit 9c4a27da0ecc4080dfcd63903dd94f01ba1399dd ]
>     
>     Tell hardware to write back completed descriptors even when interrupts
>     are disabled. Otherwise, descriptors might not be written back until
>     the hardware can flush a full cacheline of descriptors. This can cause
>     unnecessary delays when traffic is light (or even trigger Tx queue
>     timeout).

Thanks,
Olek

