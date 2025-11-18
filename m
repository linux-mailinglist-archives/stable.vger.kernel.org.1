Return-Path: <stable+bounces-195131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3206C6B87E
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6340B359F93
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDAB2D248D;
	Tue, 18 Nov 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4GnNdi6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910B27AC45
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496613; cv=fail; b=bctrQXFQzenu+ECy/nM5ov2bW8Om52AUmfKbLlg0xPoCzZTAizU28wY+6ajpBY2xhI0bzcg2eJB0TeXlWZxF0PoyJNSCdnoIiv1f+UYFENx33XI9W14HoI2pKuOxqIXgPU3h4yNF0gvAFsWKHW+6SPldpb7nuFB+lcenOQMBrm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496613; c=relaxed/simple;
	bh=3Vfi2omAP05foIoJperUI4v/78iatB9iGBry/M24AnY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXNR5Yk40/0SjuBc7ID9isc5LbnjAJMAmvJsNemOLZLw02w3FMzb2c6+WEsXowEMDFBDKHmjmexge0P5CBVwl0ACzEIZaDRrDog9nE3Pa+PYqkeqUi7kOxCPO7czisZV5s6WAsu1MeKhk/BKSsUhQieMz9ZkxsEkGjotQli6VlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4GnNdi6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763496611; x=1795032611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Vfi2omAP05foIoJperUI4v/78iatB9iGBry/M24AnY=;
  b=E4GnNdi6jCgJZEaKRzc5X+kmLymZdxs3NWAS31RfQ3N34v8vnyXSC82y
   8lKWgT1DciF3A7joNloB8gD252fHNIGcbApNPCQ5kBD/eQ5lu7YkT3yxA
   0X7kW6HJMtT0NBLlJBL0OXC4Yw0O+ZJmLDXpt71+5+OzJPs6VeZcXtCit
   ifQmxTsdTz3WsZFG8YwwekopCDNjMkixx+PUeJ8SDXPMWsxKGIk1iTohm
   aN1ZZCou3WfKY+d/Txmee/llL8ZaYCrEgTesTPqPtGFNKJJ3yJt2eyUk3
   GHBEh4pHPWsAAw6seXVtfFn74B1N5x4X1DO8szxC0HrXsgL90DxKxurRT
   Q==;
X-CSE-ConnectionGUID: 70Ib1fk8SeymvQFsE5SlAQ==
X-CSE-MsgGUID: 8vsnhs+MQjKVoJmicwMz9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64532951"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64532951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:10:10 -0800
X-CSE-ConnectionGUID: CtKc32XQTJuYSvsQUoQmPg==
X-CSE-MsgGUID: Hxlp9VnqRY2k605JoZ+Xew==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:10:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:10:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 12:10:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:10:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bon8cpmGIZH66PkmoR5p66kzYHe4dn/gSOoSMqGTD4tkJnI6SOvNeHq0o6AEHxQ2k/nLZJTBEwri4KL1Cmt/cgN5zHT/r+mFFejaKBsgtPCoe8C9jFhzKBzhrcRWFMqmbweb96Eb2FBsIjCMEhsD1bQjEmdAvTsbg118I1YhioV5s8s98v2IcLuJrMku29VysB0Jkn2r63E0qMSCmmovLom5utcTSzjYpKbBir05SBLc8yVIT+6Q8IAoF+E7cisGqdnfXH05Y4dZDybdxWy9v2BlHPefNSQLq3ef+r1mWb1S4pRouhCaflvpfEsQgeCFHGMG4jEPZthKtDQQEW39vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMKxTcLicgYdjF5UN/1+ZALl/mJPzhotI6rMhP7lW98=;
 b=Y2vL/o+o34KEiuLl1R+Wxurkipfo85A8KvwM3J0VUDwmqJ96AEDUHSLPmSIAg9JpRXnJZh2HgPy5NlAW7uDyyz4n/XUc2hdwNEYr3zS4yabGTT1WbaeTV3HmQniN4ff1ICWcoql/fojtotkOwLD7Lqo18PNBBvGfckC9Ex/fxsmniQ+oBy5VbHRP31QYBMlJSyEJva3vmkwxrTkFO2PMXmbYPl1b+/m4CmAS9z+S+ZsP14/Lgwt0YRrkwDnP4tze4resIIDPLalK/El56we5yQShZl42sgTBY8IcKGQOwhr/K4lRHKOBj0/ngrSrLoSFBWAey6ZXiVaC6S5LvcE60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by IA3PR11MB9349.namprd11.prod.outlook.com (2603:10b6:208:571::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 20:10:03 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 20:10:02 +0000
Message-ID: <cb23a8cb-937b-43d7-85a8-68a60c98e0a4@intel.com>
Date: Tue, 18 Nov 2025 21:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, Sagar Ghuge <sagar.ghuge@intel.com>,
	Stuart Summers <stuart.summers@intel.com>, <stable@vger.kernel.org>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
 <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
 <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <lc3rxncpictivozzuecf5z2kfprsmkjk35vd2djlofppfa33jq@hdvuteq3wkvc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::18) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|IA3PR11MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be683ca-0260-42f8-471d-08de26de751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU0yMCs0cnVPNDFqaUlVRkxiSTkrTjlyZVRzbFlnZU5qNnQ0N292a0FUeURq?=
 =?utf-8?B?UFp5VTIrOTZjaTh5MTZtbjBobFZpRzBkVWJnK1NKcGduOWdZbU9zR1dSdUQz?=
 =?utf-8?B?dFFkZGd5NjF6QXdhZ212NXBtMUZwVTV6OHI0L09ZZmZTUS9rZjJIUkZjK2hn?=
 =?utf-8?B?MHZ2WlJndk0ySU9kOGw3QTRFTlNJTnNPKzNnYkJhNXkwRmFISVVDSGpTa2xE?=
 =?utf-8?B?Z2pWczdPb1lSckZEemZCczFUakw1UkJHMnRkcDNBb2dtVGxIQzlUNUtIUzRV?=
 =?utf-8?B?Z3lxSk5IVDhmZWJRUDVRU0Q0R0pSUENDb2VFZmlFcENvczg5UlQ3M3hyM3dR?=
 =?utf-8?B?bE5KandJbjdOZEYyZ1UvUU5CNEtYalByV0E2OG5ab3JXVlhUaDdYdGxiOHhq?=
 =?utf-8?B?eCsyQlNvaFY2VHRMMGhjR0ZJYnBKQXN2RDE0bWsrV0JWZGszbko5enVBTHlk?=
 =?utf-8?B?ZVozYjR3VysxTXhvU1NGYjU2dDJPLzh3dUpZWFhPTk1UK0ZpNXZ1T1FnZUxm?=
 =?utf-8?B?anFHN0J6eHpHZXpLZFZPQ0RCdEEveGVpUzR0UXBKbTFMRXVId01hd2tPME1w?=
 =?utf-8?B?UU42NXZ1MTVkd3o4VlBQZUhza0k5M2h0TUNOSGJKTnZ2M0paVnpleGd2QVJj?=
 =?utf-8?B?Tm5WR042WFRPcFdGZVR1ZzcvR1NndmhJMDhnclZzdE9rcFNMMkdaUkpRZml3?=
 =?utf-8?B?UXRuaWc3cDJEcWlyMFBGcUhzTzlFcGJveEdMRUpwY0VuZzJMMjRRdW85SUkz?=
 =?utf-8?B?U21naEhMVTZiVFR1WmkwS25vRmVqdGp3RHNvRmJXU2FzUGRpL0ZxQm1NcEUw?=
 =?utf-8?B?Wm00WVhsbm9qa04vcmVpZTBSV0l3ZW5qdlk3Tk1JSWdRZnQvNlpnR0VxNitr?=
 =?utf-8?B?UThhaE13R1RESHYrb0Z5dlh0dEVnSWFMdDFjMytmcWoxRm10QXRYcFUxZ1p0?=
 =?utf-8?B?MjQvQWkzbVo5OC9WT0MzWE5senhRZ1JNZHM1N1lOV1pNdkJUdkMzQVAvYnpM?=
 =?utf-8?B?a3VGRjNzZlF3aHJ4bFNLdjdVemRCTVp4ZEpVdURoYkxNUGgxK2RmVFJSRTAv?=
 =?utf-8?B?cmdJdnlPYTIyVzFJbWlqQmpabm13dytvM0duWEFvUWdMd0JkdVhoajhvVTJF?=
 =?utf-8?B?L3lranN0UE1kMUk5TDlFWFNlSGRNVUljcklIL1ZVcFAxaTBLTHAyWVNqZEpp?=
 =?utf-8?B?STJTOXV3V1owa0YyUVlubDA2RG95eDdDRy85WXk4WTZ1amI2THJPamVTcDZz?=
 =?utf-8?B?QmlMOGlROS9wMFA2MlhlUVF3VWxQcHNGUUo1ZHdJU2s2bFNkOVBqeGtvQUNG?=
 =?utf-8?B?cXNFTDYyTTZ3VmgyQ0dGYVpEemZVZXlTaEU4ZitndTM4dEQ1U3M4NEV1K09s?=
 =?utf-8?B?RUhFaVpOOWVJSWQ3Z3dUZXQxb2pEOXA5L0dWcDZuaHVlSnA5TTJpaWp2TlRL?=
 =?utf-8?B?T28zZHlUc3JjVjFYL3gyOW9xWElGdWZwSUlqbmYrTmNOWlNsUVcvaHlKWXlK?=
 =?utf-8?B?RFhVR2RmSldVMlFQYmtmSi9TOTdDN0R5S2t2Y0w0UHByZnB3YkZQTThPaVBn?=
 =?utf-8?B?ckR0YWJHYW5HY094V2c2dkYyZkhoMERBWGdhemxuRUJEak8rQkhpSTQrK1Rm?=
 =?utf-8?B?b3ZYNGt6V28rQWhtWmxZRGw2RWg4YW9jbTNEb3o4SGlGdEJXN0w0bkRrdFR5?=
 =?utf-8?B?cXhOdTNSeEJaeXN3SGdvcmxSeThaUW1DM2dsd0FrTFlkaW9iMU41U2Q1QkJH?=
 =?utf-8?B?VzlQT1pJd2Z6SHBac3FtdXEySmI2QmphenA4V0FYL3dWamdmY1E0U3drRW5Y?=
 =?utf-8?B?RjNhdmFabXlvR1MrYTB2MEJPTVNGNURGZnJFWEVtOUNjNElFVHp4THdoL0hj?=
 =?utf-8?B?NEFzMDBOVUdrQmJESEQvZmlnZjBjTy8rZlRUV3VRZmorNkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BjV3E4OGZlSFV0RkN3cTBLYVlWTWNXcThPaGFNSGlhQTBQa2o0ZmRRSmQ1?=
 =?utf-8?B?dENZcFUwZS8vNU8vczFCWXpnejhmaUJKMlFpOGZGVnFiR2JsUFBHM2trNThU?=
 =?utf-8?B?M0YyQWFMbkt1ZWFQZ3ZlWXo4cGduQ0RKT1Zrc1JtaWt2dWMySmpZc2JqQlRW?=
 =?utf-8?B?ZXh6NHVnVlp5ei9zTlBJeiszdkphcElvQUlDRVhIdnpmcTE5bEkrSlppbGVs?=
 =?utf-8?B?dXFhSWcvbkVPZy9meGpDemQzZVBob2RjdTRyTG1KdFoyRldrVndyakdTbXIr?=
 =?utf-8?B?Wk84N3RpdGFPSlFpcjNKUFRNbmRwREJIS01Vd2tpRDdFKzhTVEpvQWEwZ283?=
 =?utf-8?B?WEttbExJVDBQSnNrWXV4VVY5MnIzQkhxL0V3T3dkOThKOXdBNmxsT3BGMFlN?=
 =?utf-8?B?T2plejkvdkE3dkZIeGRSZnV5OVBGckFRVlBVSXJJTENkK2NORkFDT2pta2FT?=
 =?utf-8?B?d0ozbjFHOUdmekhYWVhNWTdtWUtKeHZxQWMwWUhaODFEVFhtQXVLUHB6b1hz?=
 =?utf-8?B?K3dxa0V6N1RxK1B3eTMzSVFkR2d4WjdUVGJKeEtXNTdBYlNkRUlRUGhwZHpN?=
 =?utf-8?B?KzZ0MStxZWlrK0pHVXVxZGhTcXRtQzlNdXl3YUNVNWV6aUZDZjA0dUNJT2lw?=
 =?utf-8?B?c3ZseWhGVHVCTUdJY291cGxDQjdlb3hBdDE3Mi84bitSWkdRL1F3OXlOY0pP?=
 =?utf-8?B?dG9lTTNSRHc2QWRRc2lKTURXMXlyYWJ3d3BnYTNER0FhdGJkQVpDV2k0U3dZ?=
 =?utf-8?B?QU0yenAzeTFwR0JLZ1R4czA1cUk5RmJ2UUdRVVZHQzNzbllOdFFlV29sakU4?=
 =?utf-8?B?cGtNc3oyaHZXWnJHR3pkbmsxYzlTRFpaZ0NBejFqRDhYMktWK0R0R3NjMWVV?=
 =?utf-8?B?YUdmM0ZjdllSZ1NBZm5VS2RPQWNNOVVHS1Q5Q3l2WG1YZGJFV2l5Z0xoQ3RX?=
 =?utf-8?B?eXRKNjZkc1lVZ0Rmb2tzSVQ2d1VBMWJMYTFpSXpjaGsxZndESTRvcW8vRi9H?=
 =?utf-8?B?RkoyKy90TnVYMUVnR3RjL2VvWU13ZFdZdDZoWjJ3QVliMXhhcXNGamNKOTVV?=
 =?utf-8?B?Ums3d2o2N3pUTm1SYjZOaURibEJPZ25EdG9IVnJ3RHhIMjZOVVg1NG1kUkVQ?=
 =?utf-8?B?MHRSVHVLNW5HWFphZXpmRk4rbnBhMkVRYmFXYnU1MG8zeDQ1NE1KVDJEZkk4?=
 =?utf-8?B?YWlET04vRnBxaFUvWXVkYnA2cGp5WkhZTTArUkV0UWpOeWlqUVNGNXdGQjBM?=
 =?utf-8?B?QzFTTTl4NXFYTzhjOTloczJKVEI1Q0hteUUycEFrTy9pUUJlWmtoanBFcXRC?=
 =?utf-8?B?RXlEQ05YWGtJSmtYbzB2QVI3RWZyN2dlUzhPT1dNNFVFaDV2d0RYMU9nVGNo?=
 =?utf-8?B?cC93d0MwbkJwTkZ1dzRrMFZ2OFNmTW82RTZoUWs4SzRpZ0YwVGFOUzQrZ1FJ?=
 =?utf-8?B?QlRFakZ0MHNCUndiQlRBdDYvT1FOeFYvNHE0aTU1TW5Hdmg2Um9FaTY2c3d5?=
 =?utf-8?B?UzB4YUIvNXVqSDl0YnV1NHFXOUZ4R2swZWxsSlllRVA5RGs3U2pIMFNZayt6?=
 =?utf-8?B?czVrVVltT0N1eFhTbSt1enM2cndCLy9oZmJzWnZ4SHk5NkRFeGdNeS91bFNB?=
 =?utf-8?B?ZDFJaFdxVGF0TW9FOWh2aDBkL3ZmZ1phYW1kUlJsV2YwUm92ZUl4RmU0ZkV2?=
 =?utf-8?B?UGVZOW9EcjRpUEl0T0JicWloSjBHUzB5U0loeHora21scExKUjlGcGo4T2FR?=
 =?utf-8?B?cmt2WUdUNURKbnhLd1NvM1ppMWFXQXl4MlZzSnZaZE1JdmJDeUVwa0E3ZWhX?=
 =?utf-8?B?VzJqdkxIWVpRdGJERDlnUC9YNXBMRjZCOHpBN3dHSmh2YXpFeDJRRTZucWlM?=
 =?utf-8?B?QXBxL01Dc205QVNmemlPWFVOM2hmdlR1b21xZmV1dEI5T1ZmS1NiUW54ckpE?=
 =?utf-8?B?ZC82RWVxQVlUOEZqUEVLZDRpOXdaVU1zcCtydXlacUpQeUR5c1VIdDgrQTRm?=
 =?utf-8?B?QnJNcEk0d0hqTVVHVmhXajg1RWNmNUhvUUNjWkJnbFZyNm9YWGxJNzhWekN4?=
 =?utf-8?B?cmhOVkl6K05Sc0M3bmV6ZG9rQ252emhCQ0JieUZjWlJSSmQ2RVg1T3RHcndX?=
 =?utf-8?B?SDU3eGt1cm1EeDdOYkNDU0JTdmoyT3dtQmc3YVNEUnUyRklPYjR0MlprQk1n?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be683ca-0260-42f8-471d-08de26de751e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 20:10:02.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSp5SZCYg2ncYhTdYVcBTuM66VHb13URV7e8Olz5+i1PqLorTDPxPvKj/xarjmnktSbMgxvfDUJTSTwHNnptvGU3rV2Hq29hb7eHNvjMwio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9349
X-OriginatorOrg: intel.com



On 11/18/2025 8:50 PM, Lucas De Marchi wrote:
> On Tue, Nov 18, 2025 at 08:29:09PM +0100, Michal Wajdeczko wrote:
>>
>>
>> On 11/18/2025 8:08 PM, Lucas De Marchi wrote:
>>> Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
>>> enabled to fix the following call stack:
>>>
>>>     [] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>     [] Workqueue:  drm_sched_run_job_work [gpu_sched]
>>>     [] RIP: 0010:stack_depot_save_flags+0x172/0x870
>>>     [] Call Trace:
>>>     []  <TASK>
>>>     []  fast_req_track+0x58/0xb0 [xe]
>>>
>>> Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
>>> Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.17+
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>  drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>>> index 2697d711adb2b..07ae0d601910e 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>>> @@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>>>  #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
>>>      spin_lock_init(&ct->dead.lock);
>>>      INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
>>> +#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
>>> +    stack_depot_init();
>>> +#endif
>>
>> shouldn't we just update our Kconfig by adding in DRM_XE_DEBUG_GUC
>>
>>     select STACKDEPOT_ALWAYS_INIT
> 
> didn't know about that, thanks.... but that doesn't seem suitable for a
> something that will be a module that may or may not get loaded depending
> on hw configuration.

true in general, but here we need stackdepot for the DEBUG_GUC which likely will
selected only by someone who already has the right platform and plans to load the xe

> 
> Indeed, the option 3 says:
> 
>     3. Calling stack_depot_init(). Possible after boot is complete. This option
>        is recommended for modules initialized later in the boot process, after
>        mm_init() completes.
> 
> So I think it's preferred to do what we are doing here.
> 
> Lucas De Marchi
> 
>>
>> it's the first option listed in [1]
>>
>> [1] https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/stackdepot.h#L94
>>
>>>  #endif
>>>      init_waitqueue_head(&ct->wq);
>>>      init_waitqueue_head(&ct->g2h_fence_wq);
>>>
>>


