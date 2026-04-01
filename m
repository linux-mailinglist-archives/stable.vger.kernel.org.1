Return-Path: <stable+bounces-232618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANXvMERlzGnZSgYAu9opvQ
	(envelope-from <stable+bounces-232618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:22:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7C373175
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF07306A8BA
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9119067C;
	Wed,  1 Apr 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtNiIr7V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D562AE68;
	Wed,  1 Apr 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002943; cv=fail; b=RudxTvRQPwQtKXEtL06Ob6fzwJoqgorrB/Lp3Z9k93QkDeMK3WTxrKQSaqlWC3DsT8HXf8iuVN4S3egPMePM6MPkoXk9TTW5s9+iHzvWwSx/TkCIgi8CVmBfN1HPFNoPHrQIrMGFaecHtTpGS0HVeUQhPbhBI63DjxZaU1pD56s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002943; c=relaxed/simple;
	bh=iqbIujc/80ajGVjK2jC9IbjW/lrA+eeRdYiAZ0IM6f0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FwpXF2McB4Zbrzp57iwJB10oJsxcOK7yIFN2vgJbbusoW//ff5GsYr++GHXsCpokrG9z3n4wu2x3G1Wfqaz2HD4NLOd2y3HbakjJyCBcYDq1c+nuNsC7Ty6tEL+aiiWvYPF0oRChPPRD/gz9yVMHeuupmvL9x7dYC6U7LbbdWJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtNiIr7V; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775002942; x=1806538942;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iqbIujc/80ajGVjK2jC9IbjW/lrA+eeRdYiAZ0IM6f0=;
  b=PtNiIr7VgECIjLra0uHAheVbp7ap4FWBUbWiiUYF6WBau0D8OZ58dgI4
   XkFZ6chvUjCV6t5WLip9yxSZMSqzF648SeXweZXjgyzyW9COEKZl0RQ0s
   DDCtVggB9RGgQ8ZArTVcmu1IqUBwJz0vsHa+N0JG7T1YGqDz1GfV3fe0B
   MkQPnT2d26H6v4T+fv8NT/al2tp8cGrdMhTg9d3IQbE9jyrDtOBJ0rlFL
   r8oojR4oCzSEV8OHHIZw/KISuknEKeh62dMzQJqk2ZrpEOuXC24JKevMb
   Cq4tEu0XZvBWwqom20idwdrUBw/8lbLzQI8mBFZAs9ZNucyaJYy5odLL9
   Q==;
X-CSE-ConnectionGUID: Cg5IjJvXS8yf3bCk0G75Rw==
X-CSE-MsgGUID: Y5AcKeYZSu6e4qpkiL0GZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87492587"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87492587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:22:22 -0700
X-CSE-ConnectionGUID: UohWhkKMTNKqPYuKrN+e0Q==
X-CSE-MsgGUID: gmV4bxj5TCONGtruCRejmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226763957"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 17:22:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:22:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 17:22:20 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 17:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVGiXdHwlxPFI8Xh7935mxy4PV+aXWDZwCfaYR18Pyw39OzKGWSkWMeNMuecJ3Qb4bugm+93kR/O8NXEw7OkiiQl0A9Nyj99X2D4VZSGQ3NI1E9iOkhW8XiNoeA13dJxedxgNefOc+JVchuzhhU3ZoPuXPEXXM32qoLSkhPohjn828USOyNQmsCUqZ8YPxiFu6If+t0h5UxWfDb88cGgRLM2v7+omGjw+bsKBmcR86CTfOhwnHkymY9K43SGTm04QrdjziTnQXrJLP3ilXgmvkRTEAwryi2AJNhQ01W46dY1iQZ0gLpGS38EoNuRGSfSAxm0hDD9+1tWtoSJZk/hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFh7acoIMCDEk/YfPBx2kwPspqZIdXJ7xnne9l7qBfc=;
 b=Kn+LcpaTTPP0bY1OE7Z2i7ntUhq3bGmKqwBx4TEn5Aoe8OKk+Qy2cATQrVbcWg16UpiBtLVo1Jop7Ovc8XdRQ4KBwWzinOKFd2mqawq25v4Y1fBJOk5wY8IiIp82DEpPI9gsyuU3m1DliPvl8WKkPmcSGMSIWyxmJh3wcrUwBdB5oNd8lnRyWhz7e5x429KcpAdeYf+3Ny9lMrzvJ/gwW5Kwgm5uBWwrHsrbEkjX+Wl9Db1FLA5FaOb/vf8qJmoEVrmCvXApjEiKGSpt5riD97P5nGXLs+M6t12ZONaXfXp2d/cRHzLE93qFqGzD4n9Cdm0Y6u6To/X3TvMqqI4Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA1PR11MB7088.namprd11.prod.outlook.com (2603:10b6:806:2b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 00:22:17 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 00:22:17 +0000
Date: Tue, 31 Mar 2026 17:22:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Carlos Santa <carlos.santa@intel.com>, "Ryan
 Neph" <ryanneph@google.com>, <stable@vger.kernel.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Message-ID: <acxlMHWd/Vri7to6@gsse-cloud1.jf.intel.com>
References: <20260331221839.1033423-1-matthew.brost@intel.com>
 <acxhVZK_zlv1orIX@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acxhVZK_zlv1orIX@slm.duckdns.org>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA1PR11MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de6aedf-8c5d-4567-2478-08de8f84baea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7kL59ZjXaw2noPx4ha7fddSVEYuov+s/8rSsBekLwEq9ch7d23aUe/bkcYl9QNVL3PTUKjK3BXXKO3Nj2PsbSi0A+Elk9fjlUmW02qpJCDcrNI7kdNXX9x7DGxlw/d1+AsRtmNkrgdhfJRJMhQ6VVmWi8mayc7grDqe++4iABUz7Cc/dCCRnG1jaBsEUty5V+tVZ/zdKzoJ0ynSc/MN2jaIi6wcExNBqMovW5Fk6WEnguHc4ium2kjLN1Fe6aLB6V6srlpRJ5s/JMl3amrWQeCMyfyAMHDS6vWQpWKPwguvzEIyFB2+smYj+jOmJt13BBKuQaGJEU5k6L7mtuRJIpHjKcK9EYxT1pjB9RDiMJK76uv72JpDTqAVBCBEQhRv8e4rEldc4Nwf6UmZMAvvN4xAGvv57vXZyysFXqIn2/8Ghdsxcf5XzFrzoD1RfWfP15WjYvzAj6YciYBdswUp/Dlnp+EHjw+wjZPthESf1ZaIplJIHl8bT6uu7klVBZCIcIwf3Mxe+EaU62o3VT019emF7qkgN9r+5isPCfC29xY6gukOQqXptBhwwSHKH+8TLMhyXlY3oczdyLd8oQeP4mw4mgirOx8Lx5Dwl3P/cCt7SUXLzH7Qb4ynb8dQIeM7q1BHWqiTkP1eP95227ur8XQbV9S/HbSFQ+QgRRe82EBkyd0CjkdcQyjdsD61GrlucwT0H3C+r3f0TQ4m3Y9S+NYMVHDA+lqRbNF5eWAyCoqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhpcFF4RmNKbUN4aEgxR0RTdS9VZWJ5c0VMM1ZlTjdyM0dCQ09iMDQ0K1FX?=
 =?utf-8?B?WC84d1h6bGZaa3NCSktERlhDNDJ4UnFiaE9HaURjZ2cvTGJLNEtiY3Yra0RX?=
 =?utf-8?B?RXhoMU9lNU5yNnk5bTFEa0c1QlQ5aG1GTTVmbyt3SGVYMUxscnFDdzVxaEFt?=
 =?utf-8?B?NGRQRzRDY29MQi9FUXhIUHZaVmdaZTM2TithWkEzOUdPRFFnSTVGUitkdjh0?=
 =?utf-8?B?ODBQOUtPQUowUzIyWlFIL0daRVRPaGRiRnhBdW9ZY0VvSEVDZi9iWE1nV0pD?=
 =?utf-8?B?d0lpajBWQVpyNkdmMDBmN1o4STRNOVQzYlpOcS90cXkxclFkL2QvRFd4RFFY?=
 =?utf-8?B?V2U2TWJ4QkdZMzNjOFFMS2FDcldKaUdGVUpaTzQ0b2FiOTZMTmwraGRkOEw1?=
 =?utf-8?B?VzlRSElyUm91R3VEVUo4dlh6R3M5WDhtb2MrdWUwS25wSDlhMldtalYvRVox?=
 =?utf-8?B?bkpUL1pUN3psbU9LSXZUVHRsWU1iUTJRT2JhdVhrSkJTNFIvekhkNzZ6UEZp?=
 =?utf-8?B?UG1YdFYvd2hucGVPSEhIMGVuSVNaVkJIOXBYRkFISXdWVlBxeFlJaldQRlNY?=
 =?utf-8?B?b0ZMb2daMlA4c2NJTVFFR3BNM1V0QjZBeFR6NVpxOGNOdlVwTk96WDZTVUVP?=
 =?utf-8?B?VGl1bGMwSWU1L3NlaEg2Z2hUalVib2szLy9Nd0ZVbzNibXdEaXF3ZEVvN05T?=
 =?utf-8?B?OG82K2VwM3NqTlVzL2tITHVGeWFoYXhzZE55Z2t4RE0zQXVOVEtPRC9ZS2FS?=
 =?utf-8?B?ZXFaUnd6aGdSeTYyUTFHakhFWGhva2RNbEREQzBSNm5CektxdmpSYUF5citB?=
 =?utf-8?B?NTAzcmU1Z2loRTFnYnF1M3VaUmNGbEN5ZGZrQU1DSUQyZGRRUVowQWtXS0RY?=
 =?utf-8?B?dWFwelBSSm9IMzlmd0ZsZHpaVHlYUzhBVTdncUFDby9OV0hURmowMnp1SDZ6?=
 =?utf-8?B?N2R4eFQvSXptc0ZKd0dKWlM0MHJOVm1QZ1YybmZPQ1d3YzVTcmFVSjhReXlB?=
 =?utf-8?B?WlRoajB2cUFUZS9MeGhEcks2T2V4bXZTSEtNYUZKcnVxdGY4UXAwdGNlR0VK?=
 =?utf-8?B?dENvQU83MUxDL21tZWRrTmJvU25XVzZDektOQnpXUUcrM0dPSDFhY1BJL3VG?=
 =?utf-8?B?L0NQdEVSMkQvMkJjNmIySktRYzRPSm9VRWZqaTFGd1RGSEthTDh1Y2Z3bnV6?=
 =?utf-8?B?RUVuc3dSNktZUkRPemZYR3dVZEZWZTFRclZXdklzT042dGNTZXdzTysvTWNx?=
 =?utf-8?B?YmNLSU52S1FNdkxva3RYSUNsQjhXdXFnY0RXaW5nUTEvd0psM0R1bUs5eUFz?=
 =?utf-8?B?WVd1b1dzeHVTUk5ZbGdDUTZ6SmFZaEpEVVdCUkZjdUp2cUJqT2NqTkk3Vjg3?=
 =?utf-8?B?eFFqRlVoTWdsU2hDVlhQUU9zdzJ3SUtPMDZWZDMyZ1NuMExuU1lmTjV5TjE2?=
 =?utf-8?B?Qzk0QkdhWCtqNzRaQmJQblcrczFOWnZOWitiM0NScFppQm1KNHJJVzZ4ZUxq?=
 =?utf-8?B?Y3NaTVdoQ0FzVVNicWtybWdSaHRVT0ZsOUJxcnAvbml2d1R2djZVS05TaWZE?=
 =?utf-8?B?b0xVc0YvcjhSMHFzQjk4aFFOQlMyK1AxMmhFYjhINGkwS2lFTHZOYmNROUxB?=
 =?utf-8?B?U2RHTGVhREpBRnBaR3RpcXA4b2RQbFpER1Z1S3NoOTZpaHBveHZuUEZUa1M2?=
 =?utf-8?B?YnBYcmVrbkFrU2tZN0RjdnFIdDEzTWF2UjE4T1NZY3czQ3FMRjI0SXZPZ0RI?=
 =?utf-8?B?MU5SbTlYUWRLTEtUbTY1YnY1anpHcUlxRHVHdmdPOTZTcm1YNkczQ24xK0tV?=
 =?utf-8?B?NEY3b2Z5bGhpcS9TL1pJMENFeUxrYzcxekJxVUlLV3V1dGIybkV3ZGxpNkEz?=
 =?utf-8?B?S0liTEJ2eWk5L3dlQ3lDVWh3bDdMZGZ2YUN3SWQyTDV3RFZEQ0lxVndOakww?=
 =?utf-8?B?WEFNMzNSUzhaN0dBNUNsQ1lIQU1qd3MzT3M2UFBlQW10YXRpdUllY3hXelFm?=
 =?utf-8?B?WnFGc1p3bjUwbXB4a0ZOSFl4VFpCenJTYVhYM09XVmdPZld1Zm1neXFZWTlj?=
 =?utf-8?B?SFdnbmVlODJPUkJDa2tiNzdwVmhpcWU0T2cyU1E1clVVVEFNRHQvMTgrbGVw?=
 =?utf-8?B?ZnR3dm5sQzFnTCtOc1RWU29keElxVjg3Wk55K2srcVRZQ2ltQTN0WWk3cFVy?=
 =?utf-8?B?aVlwQ244S0tPMUFMcVNDMHgvSFQ5OWtuUnludWdwR2k2ZWt6TVFwVkNvbStX?=
 =?utf-8?B?N2k1ZVprWUVZZEs0SVlWaVRTZUl1NEJKdEhVdHFONHY4T0FRd1RscjFPR3Nn?=
 =?utf-8?B?R1U1ZGRFLzQvWXFUMUFiTFJXUitHMVBqdHhnUVI0UnAweHdCODRMQT09?=
X-Exchange-RoutingPolicyChecked: u7Ct+AzGSuPHeFmWyMRWalbC4gshPwX4Id7rb7a57i1aDbguXmTQrYHWK257sEyMS+E5tGTv8Zv3OOETKTsA72SauGMo292t1cDAqtj2u4VA1v+MSL6prCogKVSSY4brlFbqnNwG3ZSoILp2UWpViFcmpmydPe4MLIJuEAIbCVOnLjUOhepQrk8U1mcKlaEvB8uhoQiBy3lkX9qPQfBhPUV1Rwlqn2ByElhsuXRYxzM8PygHNw4B+Zd07F52WRQSIpDInOvUuRiHqSESem6Up/IXkgIevIMcQ8Bv+ypyNGzw0UqkB2qP511m3h0i6va+kv+C60kilVgSEuaYJkEQsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de6aedf-8c5d-4567-2478-08de8f84baea
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 00:22:16.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVR09Kz69/6zsuKS5C7ibXpAPGSDdundolGM78bfzvYLO1457kx7vr+kUa7ztK/36KzZmRCOuGKSUgkOWK5zSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7088
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,google.com,gmail.com,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,gsse-cloud1.jf.intel.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-232618-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3FA7C373175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:05:41PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 31, 2026 at 03:18:39PM -0700, Matthew Brost wrote:
> > @@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
> >  	raw_spin_lock_irq(&pwq->pool->lock);
> >  	if (pwq->plugged) {
> >  		pwq->plugged = false;
> > -		if (pwq_activate_first_inactive(pwq, true))
> > +		if (pwq_activate_first_inactive(pwq, true)) {
> > +			if (!list_empty(&pwq->inactive_works)) {
> > +				struct worker_pool *pool = pwq->pool;
> > +				struct wq_node_nr_active *nna =
> > +					wq_node_nr_active(wq, pool->node);
> > +
> > +				raw_spin_lock(&nna->lock);
> > +				if (list_empty(&pwq->pending_node))
> > +					list_add_tail(&pwq->pending_node,
> > +						      &nna->pending_pwqs);
> > +				raw_spin_unlock(&nna->lock);
> > +			}
> 
> It's a bit gnarly to open code locking and list operation. Would just
> calling pwq_activate_first_inactive(pwq, false) one more time work here?
> That'd trigger tryinc_node_nr_active() failure in pwq_tryinc_nr_active() and
> the addition to the pending list. As this is quite subtle, it'd be nice to
> have some comment - it's compensating for the missed pwq_tryinc_nr_active()
> call due to plugging, right?

Yeah, I think that will work. Let me verify with my reproducer and
adjust the patch accordingly.

+1 on the comment as well—very subtle. Took a few days of
reverse-engineering work queues to track down.

Matt

> 
> Thanks.
> 
> -- 
> tejun

