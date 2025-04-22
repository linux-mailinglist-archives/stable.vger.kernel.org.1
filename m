Return-Path: <stable+bounces-135207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F13A97A53
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B867A7610
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B629CB4F;
	Tue, 22 Apr 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcrT2lFX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C91E2606;
	Tue, 22 Apr 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360429; cv=fail; b=PxdFdLjFJc+S2xKGAueHwRYl4QrerpkPyEKd7EWMPdAQzcOXASyaR5Zko8hfK/BAUA0on/Ygb9kN+lCKQ5z7YaG22Bd4FjPXVrMVVXtCpN5eq1cEfL/jJMqHR3aa/Y+KQDCoY1Ux5pvEj7zRArRVt4PpIcQbu2WMdYEo9mDDuzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360429; c=relaxed/simple;
	bh=Xn9wMGT+Qc8x0Gp3OCuUjrT9VtHutWXcajciZPpmYrg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snXCkx6/TngH1XXGxr5CkZdDkifgkkaVsTbVtooq14Gb/Di++USgYI3mcbYtOmtkfueHcw0U1aSu2LnaoOBZxrvpQbqy0XN0lPut8uXHDQWW2aAGQEsRC0X+YYm6S9/1CIeTPblnZLy8WW6v1PRWJK58RhTak9uXzZ084GrYzQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcrT2lFX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745360427; x=1776896427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xn9wMGT+Qc8x0Gp3OCuUjrT9VtHutWXcajciZPpmYrg=;
  b=TcrT2lFXicZiL/7Hudeygla8lRS6xmpKoEDqhyONrfblVYo3ylzhodha
   Z00fo0f1LMtiU7TI+UKbmkmdSCuJorB30+koqZKaCbOgHhyUhG9SjR35s
   6rJkhXAiUfuEmwUtb0vKH4jYKf7WyLkL0+XtiXYwCyYKuuTsfmOJKQQlK
   hUXEuZqQuvHLGhZjQX2/rEB0aLPRINGLuk61WpSQRTQpVmVTND6r8Bg4v
   hrkgarIFzCfxpqNQf0ULqdm79nxPx1PH2DH7MM0QHFLRCOVdnO2bp0sxh
   qzPHc/pvafCDI2tz2yWktnrVa2TeZvTBEv+ECKgBVFuwpvA4ai48ldSAC
   Q==;
X-CSE-ConnectionGUID: bufUpICcQzeb9YS9pFHULA==
X-CSE-MsgGUID: sHEL6zMXSCuOJ2Un4qkEkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50599016"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="50599016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:20:27 -0700
X-CSE-ConnectionGUID: moY4UJMLQJST+EzK6YEdkA==
X-CSE-MsgGUID: s9zawvajSi2mMR8cvNKQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="136919255"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:20:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 15:20:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 15:20:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 15:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfqE/BpQJO4PsVMM/HHV7Lf5nSuihICRc3MHG/u+XoZYuhiBb8/dB2ZH5bsESOAgjENK1Gn1EoYDpmwJ5+Nsj5e7+86dd2FtRJcOZJXYm5GbMQOitCr1i8bIOqfc7WPyNX/fRbztBq/ysJ5LHw9BcD2utCr6kuWS42ZIeEFMgWq25dDl/rjFrowyRJLFmoDKVfjVqCE4v5AcNO5Z6ybejjVoY33iXUqg9wK7SHPZ6owgTSROo4SG/y8mGlajl/rJczkV/fv0LZXqVEWiQAv9Lh56D3GONDZt+4ciAWNfNXlS2bC1WE6Wb1J8/Xt3VlMB6oIiwZ6L/HRUqWf16pdbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14wuk8bhUzCRTHIA3r2kvXTGF30RgD5PXgqIzDUW9uc=;
 b=ZZR22Zv5XX2M5XPzJ2Ii6CT9kd5LQ1U8bkeFkTLTDgS4Fx8qxTC55heKpTEcnsHNshZKoxqXeFqFIhP8hRAez0zkkk225tHlFjJgS17fGf//1G2Cmd3533jzvoHdTWFSeYhMucuraQMEqWm6Lt4v1WqG6JDMridtmxKyecPzm8PfcBnrwDxjrTFlH5Wo9Q0XmGOy9yy+nYBRMYBUbfP5qFT2mP60PDqHEH+RLztC3vwNCke7ByUatIeLBiZQDWCC0i7O4FkQX/6rAFEC89m49r35HlqDEIfjTlaz5Jhl3GHks+Vqg3Cv5DvHTL+29lR5HdlJXCjRXXfkP3e7jNJjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 22:20:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 22:20:22 +0000
Message-ID: <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
Date: Tue, 22 Apr 2025 15:20:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
To: Vishal Badole <Vishal.Badole@amd.com>, <Shyam-sundar.S-k@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Thomas.Lendacky@amd.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250421140438.2751080-1-Vishal.Badole@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b80b531-9467-4479-40d6-08dd81ebdf90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1F2SkNoeTIrMmhsTk5Tb0JOOVllcC9lcnEzN0hRblRtd2REeFlrcTdTd1lk?=
 =?utf-8?B?SFpQZDJIQ2F5aDFoU09lSkl3TUhReHcyaktZcFBCU2M5dHF2YkczaFRwYW5p?=
 =?utf-8?B?cmRkZTRid0J0YWFOUjFzZ25pRkpBUFRYT3FaUnR0eCtTQlErMmEvczB2RE9L?=
 =?utf-8?B?RTFNS0YwLzdoYUhkTTl4MDdKN09TcGRjTlBYY0lieGhJa0h3RGdzSnlvK05p?=
 =?utf-8?B?VFV1TDZFRlJBTFlDdE5xczhZZUgxcGhTR1VDYXh5UjYwdmF3bDQwN2tYbnRz?=
 =?utf-8?B?VE9CR0ZPdDhrTHFaVHI1OVk1VXduZmNCTk5kYmF5UlQ2endDbkhDTjVhRGVn?=
 =?utf-8?B?S05CKzdQa2h4V0kyRWZSTWFBQVRXRGFxVnU1WnNZdTFsVzhybHhnMzlOSFpm?=
 =?utf-8?B?OXViUWI2c2VDNG1wNFgySFMxZUxkUStpc21pa2FDNFVJdTNncm8vdWhhV3BH?=
 =?utf-8?B?Z21IR3kyaGRpUHY4RjRhbm5BQm1sK0lpbU16bzVqbElHOWVIOTZZV2xlUVBX?=
 =?utf-8?B?ODlTZnZTRjRBSkdUeGdQSFIrVVE5OWk0VXJBM2Vzam9OT1FaeThkdS83Uk5E?=
 =?utf-8?B?dEUvYzVMM2xla2pocUVZcmg5RWFXek5kbGM0Q1ljRHFXcGc0NVY3RnMxVjJU?=
 =?utf-8?B?RTdUSHZLNlE0bS9JZVlPNHI3Y3U4K0t5K0FjQ1FUVTlOajd3dFpLUitIdXpR?=
 =?utf-8?B?cnBIV3ljWXZKdUdlVE95Vlp3ZGE1Zzd1Nm04bGxUUEVhcGxVWFFlMURZT3Er?=
 =?utf-8?B?Y1kzbTRzWVcxMjRHeHgxK3o0aElUSVd3RlJnOU54Qi9NSjN0SllXR256OHpT?=
 =?utf-8?B?cnB2YTBwWlBBNFYrMXUxV1AyNFhEVytadGo0UHVacGo5K0ZEZ1VEVVJNcnlw?=
 =?utf-8?B?YzBDOWFaaWR5U0JySGJoR3JKLy85bVFlM3B4NzlsamVpSjgxYStMd0xZa0R1?=
 =?utf-8?B?SllRZEIrd1ZYVnkzckdGVXhlbi9MOG43c2xiemI5VzNOWkJlc3pZSm9SWGc1?=
 =?utf-8?B?dUJrcEd6c0phRWg1NnY3clc3TGZNdUVhSHUxUjlTRmJSWkJBZDJDWWVLZ1Jy?=
 =?utf-8?B?UDJCY2xXbTJ2ZVN1Z1ZySkdKQ2pGMkk3R1N1cGFpL0ZjaTB5RDZLcG5aQ04x?=
 =?utf-8?B?UWNQQ1RuZFQzK3B5NjBRa2Q3YWV4cHFwY01hRFNUU1laMUZCOURFRlg2QjdQ?=
 =?utf-8?B?SzhBYkdRM0hjaTdQdXIvbTk3cURINlY1NFVhMWQ1L0hIYW1rK0NoZ25zcEhU?=
 =?utf-8?B?L1dwU0tzYWZkZWhkN09aNXNSNWlzcXhPTXUzZS9xTk9NSS82STg5QlpBeUtC?=
 =?utf-8?B?TlFzcGpjRDJILzR5dHJGKzZEWG53ekVIRE9BM1NHU2VrRW5VWmptTUJ2Yjdo?=
 =?utf-8?B?b0VJUkF4dU9wd0FoVmZScjAwc3BFaVBSRlZCVnRuRzcrTUhpM3FaaFpuWkdQ?=
 =?utf-8?B?SUJqSE9OZ01BOVFDZjdhOXBYVUNVOHFmb0ZZWUt2MHU1OWV4WlV1NkxqL28v?=
 =?utf-8?B?TVBzWUUyN2pwV3pvSkVsRGZJV0szTTAzQTFIRUhhWDJYR1hFSUFPVmpGM3BG?=
 =?utf-8?B?RzdkTXdiUGlkRU1TMElhZjd2R01XVExQU0ZtVXBvYnM1Vk5ESDd4R2laZFY3?=
 =?utf-8?B?VllkY2lOaFBkekVtTUl3RG9GL1JibURGa3ZWQVhDMWVaR1hWODBqcEMzRFgr?=
 =?utf-8?B?VXZIVHo1S0UxTXdiWGZ4M2ViTC83KzJWemV3aFhvSHlGOHRFWkR2aW1NVkNS?=
 =?utf-8?B?ZzVZUmVwQmJYM0VWOFpWSkZlOXg3YmdiUzVEaDFNQ0NTMStDTkR6ai9jRWhy?=
 =?utf-8?B?REFKb0RCdWpadVpHbXo4ZFRqcVJpMWpqUzI0UGp3N2RwRmFmNlh0em8wQTA1?=
 =?utf-8?B?OEtiZUtjUWVtNEgvSTRDdDNXbm0xazE3bmlJQThPaEl4SE9YM2F4K1RCMHhY?=
 =?utf-8?B?TEhhd1A5d2xLcGY4Z0FoUXk5ZmpZZUhwUjdraVloU0VUaHQ5N3gwY1FLd1px?=
 =?utf-8?B?UVl4THh0bDdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2luZXRmWmdmOVRVZnM1cTc0aitmYThkWjU1UmVKRy9PWU94RGtvYTV5TXFY?=
 =?utf-8?B?bmxYT25vVi9kT2JJRzg0cjVaQzhacDhCanAzRW0rWmdVOUMvNlhoVW0xSjVM?=
 =?utf-8?B?dVVOandRL0hQVlEybEVvUzJyMUJ2Z2lrTzJFS1FwWEhSckZBUmhqa0RSdzVn?=
 =?utf-8?B?THJPMTU1MzQ5dW16Z1V2QnpwcGo1Z0g2cmtOOFNLT3hnMktWNHpIOEl6WEhV?=
 =?utf-8?B?Q29lMzBvdlJOOVhEVWRiR1NtVUl5cHZxbHdLdkdZNDZSV0Zmbi96cEJZUFUy?=
 =?utf-8?B?RHZlUEtEWEU2TWJNTUpoekVsUWw4bXZJc2lhaklTQzQ4blFhRWRtVDRqOHVi?=
 =?utf-8?B?aFJTc3FnNUZhbCtQZlBnd2tVbE5jMGZQWW5yZUNmNXZ0VWREM1BoY1M3Z3Zo?=
 =?utf-8?B?MXdmUUpWY0ZNMnU5WXR3UTdxcVluT25FWDl2Qld0ejRzaTVBOVlZY0I0NDIx?=
 =?utf-8?B?VkpXSUlIV2ZqZVhhY2xIeWFseWwwVkdETzRXUW9UWnlDbHZtREdsUXRPSURU?=
 =?utf-8?B?ci93VHMwYkE2QlNTdDdoVG5BM05iNVdSdDVIZ01hSTdneXdQRnEwM2pYeXNY?=
 =?utf-8?B?bDN4OXJRZnhnOTU3cnU4TTVTMGJKcU9DSEJ1eVduZXB6ZlNaSHVlUmREQzhU?=
 =?utf-8?B?MmJFaGRxSTZaLzdlZFU4OGZTNm1kK1dwUU5SRitSZjc1amsyNXg0R0JTeEtB?=
 =?utf-8?B?U2hPaWZRZWdicFVCTFFGMkU0anN4eGYzMVFDajQ2ZkVHVW1wbjdieGJXRmJl?=
 =?utf-8?B?RndIK2NYSGdobkp5NjRlTUxVOWRHV3M2enRPa0MwZzhtVGdvOElyU2RqanBs?=
 =?utf-8?B?YTRGNGt5SmNoQUFBN0tuL0NKb1pGVHVkUDh1Z0R6TW55RC92ckVHNGtkUFF5?=
 =?utf-8?B?ekpRSmgxTlh3REVYUTF0K1E2Wk5BRXd3SXFwYnc4Nno2Rmp2aTNzZTJuTzJC?=
 =?utf-8?B?QmtGZ1RqOHBDcmp5amRBdGtmZnJSWVVVREk2WnFkUjdRbnVLbXoxMEZ2TmR0?=
 =?utf-8?B?TkJtckowTkYrRS8wcjJiNHBFdlJIR2NxU2ljT25ONkJaSWlnTElvcEgwWnVa?=
 =?utf-8?B?K0VkbEhLenc1VHVFSnk3YlpOcmwzNWgvaS9vamxQKzlrUHcrRHNwVmJKNE5j?=
 =?utf-8?B?MEFpbnlwZGJZY2tKTFJUYVYyTHJ0OHRsay9zc1c0UTdqSmxMS0dmRFVxWDBu?=
 =?utf-8?B?eTFsNy9tV1c5NyticGwyL0kzRmZlNjg1WmVKQWpmdkxSVUpKOG85RzhuRjlH?=
 =?utf-8?B?TlFyMURtZGYzVmFrcC9ocTZ3MzhmalBLVzluS2RvNmdKNHVlSVJBTkpGSDFt?=
 =?utf-8?B?WEl0KzB1dzJxZGE4NjVVekhnS3h3VDhJbjRXbkVUSGh2RWVpS2NYN0crY0hi?=
 =?utf-8?B?TnlIMCsyZTczUDRjbVpkQjd1NFEvTEtJYnZUYlVhd3FDa3FBT2IzakFnV2dV?=
 =?utf-8?B?TlhsN0xMVmp1Qlk5a3Q4SXFsRlhtV3RMWmRZcFlad3k3MzhRTS9DUU9NZ0t1?=
 =?utf-8?B?QndHQnY5MitvdzRUeUQ1bUZ3VVF4L1JsR0owbXBvVENSamlDZlBLRngzUkZR?=
 =?utf-8?B?QmVDZnB2aWFFK2hnUnV3ZG94NCtEeTkzSzg1RUQwUFFqYldHUHlReEtrOGJ2?=
 =?utf-8?B?VVZFN3NidCtsbEhsMEFjTU1yQUxYZ1pTRG0rMkViZ0lJRldvaXgzU2ZaM3F2?=
 =?utf-8?B?dW1vcWY5YlVGVzZPQzc2ejR5eEFVSVloV0I3ZFRHSFZualVWZlBxM0JoY3Zv?=
 =?utf-8?B?bXR6M2Iyb1pRVkFzR2lPdGZobW9NSFpFS09sT00yV1ZNSG5Ga3pwSUlKZnpK?=
 =?utf-8?B?ZEM1alhiQkNXaHNmR0U3SXZYVWQ2T2dKVVc4QnNxQ2V3TUdEYXdpdHE1OHls?=
 =?utf-8?B?L1d1SEZ3ODZyZmprM1hXSGtIc2VhTlhoemptdDhPSHRpZit3UmFhT1FpR3pN?=
 =?utf-8?B?YktJeXZFSi8xMjBWa2tsQzIwalBlNUkxdEJ5bDJDYUhUcDdwL3VyYlhUUFpz?=
 =?utf-8?B?NG9lS0N6UzdMMWVlVTAxSTgyeGNQUVVqMFhpVk9QQ0RYVlptYVBaSjc0blVQ?=
 =?utf-8?B?bGhFcThrc1VNcWJSYVh0Vjk2RklnT0o5OGtIdVZlMWRFdzFzS3E4bmdnc3hL?=
 =?utf-8?B?TTlnbU0yaHh2ZUphdThiR2FJN0tVSXU5Z1dWZ2RQUlRyZjdLWW1LRUU2Skoz?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b80b531-9467-4479-40d6-08dd81ebdf90
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:20:22.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuXbdO5aRvVojlZF4xvVk4l3rf7xPNCjFeYJmuRAD0D8mRg9W4vBnx2+yc9wMBdVAWEsamgLFs135aHG4U9M3ALJJqA9ycMm+6DV83FEXPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com



On 4/21/2025 7:04 AM, Vishal Badole wrote:
> According to the XGMAC specification, enabling features such as Layer 3
> and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
> and Virtualized Network support automatically selects the IPC Full
> Checksum Offload Engine on the receive side.
> 
> When RX checksum offload is disabled, these dependent features must also
> be disabled to prevent abnormal behavior caused by mismatched feature
> dependencies.
> 
> Ensure that toggling RX checksum offload (disabling or enabling) properly
> disables or enables all dependent features, maintaining consistent and
> expected behavior in the network device.
> 

My understanding based on previous changes I've made to Intel drivers,
the netdev community opinion here is that the driver shouldn't
automatically change user configuration like this. Instead, it should
reject requests to disable a feature if that isn't possible due to the
other requirements.

In this case, that means checking and rejecting disable of Rx checksum
offload whenever the features which depend on it are enabled, and reject
requests to enable the features when Rx checksum is disabled.

