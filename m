Return-Path: <stable+bounces-166513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2BB1AA2F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5370016DD6D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE215B135;
	Mon,  4 Aug 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPw3JZ3c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5343ABC;
	Mon,  4 Aug 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339834; cv=fail; b=nkI45krMLPuaHRSVNZa7trUfTLbiYuMReHieH9BywluGF2bdu9RQqpJysRQQyXGD1yCrWEOZhy4qj1aM7T6BpOym/uJf/IHYPtmPrNG6n50wM7NXBjslKhx2KS4yeHu7X/fSmSEfOvS2Olwdx/E5WdEU45Mr8VRUr6N012lgdwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339834; c=relaxed/simple;
	bh=rdZvSfLauH7fvLQNdZGBWQb8W2js43vISXerntrSrno=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EhFxFaf84KlvA7L7K1DkDVniC3g6H3J611plS9GUerEdXYYtPVYtWNqmKSlHKWdzujgs8KYgFRtPKFEO2dWEBhzolJV/RAYn49t/9EnqunI5ra4z+OcNSgutpbPbbwYqOBf/c86EXe8ODv+VPoUmJZraW3itLew4VcvGTvreTCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPw3JZ3c; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754339832; x=1785875832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rdZvSfLauH7fvLQNdZGBWQb8W2js43vISXerntrSrno=;
  b=OPw3JZ3cCXf0d65QOQIbjD4DV3gXlwtEHqXOLNQ2xdeY/kzBaOw9yUAz
   v3DmqFzvCh98NNm5JESKDX2MXGbogFF40DRNXzgsj+05CeYIHFvm/MAzw
   U3U/966vfuIGi21APzeS9zos7TZk1vJSJaJ1kBBd/bqXwRb87JgzHQ5IF
   uNy5ZLifPgWItWguSC4GckqiZgRYgL6gLQpoSog/1QGRgMvaqkDeY26EF
   4HNHrBqfFeCyhoABD4UlLaVA5+ETsGMKWz4K4PM68kIpiVmbVy6J9Y+G1
   4bVFZJFUdeDF8bdGuTYiIy1txVHTex7W+dKEdzpMJapqSaahDatPAdQOh
   w==;
X-CSE-ConnectionGUID: pWZa9Ai4RhKstkNDVihlvA==
X-CSE-MsgGUID: KwPNzp7iQgq0FVy6eCNijQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56695410"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56695410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 13:37:11 -0700
X-CSE-ConnectionGUID: W/vg8StsR2aB4MXRskWwRg==
X-CSE-MsgGUID: hA/QepaHR06kOiOcG5xtew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="168444716"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 13:37:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 13:37:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 13:37:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 13:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gprp6CyIM1EVdXz0vn3E3q9yQEyAxKJypZgfsHlZCh91UuEzGTAmGVzYCjJYjEB6C05SSGlXorDX5+PgAScbcCspvmiO3mdev2YqyUJ6D1Bj/OpxjbEhr4DvfEVPIMLN66itgO/VfcyoNFITSXMezoS6dly7TcvLZeyKMHzEHVDzItfhQDJZRlIO6SHhnjD/rQBkXLHQ9d9QC+jINDrEOvq2tiCY8+otOiaXry2u9cfdvvHw1Je4xf98Qjcnyj02ELk8zrhHSVpXRAw+Sr/DJxBffBZHsfpCVjkMQ7ILJMWLM2ovUY65ygEOgj8qx37cfSohIICHIAf8Bm3lfJeUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksKqmKOhi7p5h9IMqeSh9sg559QAAb2aPizRZqSNw2w=;
 b=Yh2XEK0tsPdU4eLwDYccA69bFzISJg5Epu/z19IZRe9QKYvHBSqWqDL06axtm4hvT9AXDfsLV1Da8v2DsxxTLJabySBjrhfh3QfzuiH0m27LJNjD43LhPDdTqQrCLpnQ9lftvL6ORbOeV9pcZIqYS7aVHpBM69JhaZWc1Kvtp0Ah4/WxUppGQ9QTgyDTIvleTW74slKen00juQqc6/EaowLiQ3hzKoiZHVvlNYBv1uyPGnAv+JWtdnR5OzrMOO23fpQFjB/b3JL3RlXlkUaD6VlCBh2luizkiUi6PKPyhcZME2Jf36JIFZBZnlKCn+An9Uz1aFGDZuawxDHP3skE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 20:37:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 20:37:01 +0000
Message-ID: <e72b9895-c143-4818-901b-7d8ab26b8e91@intel.com>
Date: Mon, 4 Aug 2025 13:37:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <darwi@linutronix.de>,
	<peterz@infradead.org>, <ravi.bangoria@amd.com>
References: <20250804175901.13561-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250804175901.13561-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: b474d4ea-aff1-4a63-a31c-08ddd396aa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGx4NlJ5MW1Xb0NPTUF3Yys5bVFBWUVQZ0F5U1Z1WUNqQzlSVklYcFExbm13?=
 =?utf-8?B?cUNodWtkbDRsSU9qNXEwbDc3d2NnTnU5YkMxTTREVUhjWlIzeGp2N1dqcmJR?=
 =?utf-8?B?Y2FSVnJYcjMraGNhWkhuckUzTVkwRm5BcFVVWjRtUFR2Y2pHSVc4UDVyRmFs?=
 =?utf-8?B?dFhPUDU4MkFzZlBMSkNBQVFNQ2ZrRndWKzNPRllhUzRkQlVHTEpSdzFabUxz?=
 =?utf-8?B?OUdWSTZBeURVWVpaSGJUa2MvZ1lxcUdtUWJqWHMwNjhvaDREQU54WU14Wmxz?=
 =?utf-8?B?RGc5RnNmeEVBV2dHUEZCcTM2WUVpS1R5UFRkc0prbTcvVU0rQ0NYWG1BbUZo?=
 =?utf-8?B?eTFNSDA2SWhvR0tKTG5TMHFXYmZXOXE5RGpYNlIrSkxZNXhCbHlYeWRmVk01?=
 =?utf-8?B?UkZkZ1p3YWdQT0VJLzZQRTRvb2I2STNRUzZxR0lCZGErV1Rad3c2blVFQU1D?=
 =?utf-8?B?WWJxZFBHZXl4NzV2NUwxTzNJK3YrcHh3QkN0SWdueDg0MFI5VDFhMk1YVzMy?=
 =?utf-8?B?bkZucEY0YmpRTDE5V295NXkzWVk3VEFnaFBpamVjU3poS2l4eUJUMVU2VkVq?=
 =?utf-8?B?RDE4bVcxSXdaL2ZLSlM2dWxZWFV3VTVPQysvdjQ4UnBOdG5yeHkra2NLNjk5?=
 =?utf-8?B?V3FlR0FKcVVROFhUUGFndFh5UGlJNWd2RnRvMEpnczR5djNUaURLMHUzR2dh?=
 =?utf-8?B?WHNKYnp4NjVRRk5aMS9PclRnbU1vSzcwT01uWFczN3dTK1V2WVhkSjFybGJr?=
 =?utf-8?B?MFpuWkw1cjVpUGkvUk13VTNEUE1VL3VHK25UM0IrbzdMYWtjbHY2UVJEWkd1?=
 =?utf-8?B?cUpDZ1pGTWptaU5wUUNEMVB4eHRFa2RIem15QWI3a0xkelJWb1EvTVArNTF5?=
 =?utf-8?B?S0xpS0g4aUZMNXkzWGtsUmQvN3o5TENHUm0zSDNXbEhXZmg0NG9EK1IvUTB6?=
 =?utf-8?B?RFZRclRGempYcXlrcFRMWFJvVmFIak5wZkFXN1ZSdjg0VHRIRC9nNGxKa2I4?=
 =?utf-8?B?a1N6by9FOXduTjVia3RyaTZkQ1JvYzNqN2lhS2JHQ0J4clhCeHZydC9tNjRl?=
 =?utf-8?B?Q3h4dGk3U2xJV2ltdVJwRVFzc2k0VlQ1MjJNM21PbDdkanJHc2dVZlc3REdK?=
 =?utf-8?B?VjM0b2VydFZzMzNVd1l1RlJXY3BvT0JhWlZzOTR4aEc2bDI0eDBIVlZNVDBy?=
 =?utf-8?B?d3VvYzM1bURBaXR6anloRjVYUTRQWk9QWm9hMjZWV2RQTHN6TElHUTVRUXZn?=
 =?utf-8?B?SzNLRFZjbld1RjNvbmtsbjBIZ3o1WXI0d1BqZW5JdENtR01IQW5ZamtCaVNj?=
 =?utf-8?B?a09FZDcxdlR2Z1RLejV1cC8ydHBnOStUcTYyam5nQWwxL2pmTmxzYnZHYnZh?=
 =?utf-8?B?S1Rrd0RRWno3V2F2ZFQ3TVo0Uk0wZDRNa0IyeVZVbXllVCs5M1JmU3IxUnRz?=
 =?utf-8?B?Z2h2NUsyQW5QcXZOQ0FWdFF5YjdJckdBOTkvbTRWL3R3OWlsS3pyMWdrQlN4?=
 =?utf-8?B?SlVUckVzMkIwSFppakhJakVPQjNidUpXaW5NUWludlNleklwVjN5bTdhUXB6?=
 =?utf-8?B?Ny9vUk5HRGhwb0F2RWFuNFFQdnB1UllxUDdkMCswVlhxdDhia2ZOMXdxOUlz?=
 =?utf-8?B?L2ZWVnNyVmVxNFdLaGpGQmVpK1lZNWVpODI0TGVrd2VCL09aMlYwOXNsdTZI?=
 =?utf-8?B?emZRSU5rZE0yT1QrOCs5b3BZNDhZUDZsNHlrdjZ6T1JFUTdxaEtuVUk0Nmpm?=
 =?utf-8?B?SXZUMFNBNklJdEduUkh4Q1FVWUhneHp5aUI5Ymc3eFZ6SG9TNDZxQmJtNmxj?=
 =?utf-8?B?REc2SWZxQ3dOa2FjL3FiM1pjUE9NeUJjUDhBeEhobG9scUN1T2t5bnEzNFpQ?=
 =?utf-8?B?L0YxNi8zbUFoMGVNSk5FNUtFbHppS0dJeG1kbDIreTk1MitRVEQwWm00RFNE?=
 =?utf-8?Q?U7fmLi731AqhDYOFGb/9uHcVPEjyUQGU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Y2YVNpN3hFTDdLWktTdlA4QktkYUVvc0tMZENUNjNWZW1xS3dRUFBLVWtY?=
 =?utf-8?B?NUphY1RVaUhtOHVzbXkwUm1ycXVhWnlxS2M1YkZwUmN5bG1NbFBWbmVTRG1u?=
 =?utf-8?B?QnpEcC84Sm5LT3p1TzVabHRsVExGVWxOSXI4WDdBNnprT3pRZkgyQzE0aVM5?=
 =?utf-8?B?SENvMlhPajRZRDZtV2xHUWlEWmZPemcydkFpbllWMTN3TFp4czZOSE9CVEdl?=
 =?utf-8?B?cHVGRVE3Skt2b1h0YkMwOVc3ZjRmTnJoVEVxZ2J0eUc3V010UEZQSU5wZTR5?=
 =?utf-8?B?R1MrWS9kQ3VEeVJicGZhbTNBTDI2UDl2bmlhQXFTUzhqWVZJV25DYS9YQzJV?=
 =?utf-8?B?a0tYYTFZbHZ6VERPZjdWZnlibDVIQUZTanZESmtMWkY1d1J0Ykg2TGl1RzYr?=
 =?utf-8?B?WXQxa0VtTTFEUHZNQW12QUJlOFlMOUVpY3AzQmh5VEh4bzBvWno0Sk02WjA2?=
 =?utf-8?B?ckJLcHJXRnJuRGdXRzNrUWx6dEVDNWNBVCt2bUNhWkZ0MC82dzBNSmpvQVR1?=
 =?utf-8?B?dlhlUk54b1hqQzh3S3lCQ0U0SXZSRkQyMjh5TU5GTlhIYXJEcmVhTTNCREUz?=
 =?utf-8?B?ZytBVHlzOFFPTG1FMitmZytNbVhGL1Rld0RpQjlVWHg4emtlMEdGbldoVDJ6?=
 =?utf-8?B?WVpvRXdzcERleW9ueDJJaE9iclhQUVc3cnB1UkUwOTg0SlA0d1pHM2lJTkZX?=
 =?utf-8?B?SFhzejlhc1R0VFQ3RG8yYk8ydTBzRWpqQ2FVMmduaHh1TmJSS212OXpXS3pN?=
 =?utf-8?B?VVlaTzNwR1czaFVrTktmaC9xdmpkS1JvbnhDQ0dPRk5WeGM4dDkrS0kvYTRa?=
 =?utf-8?B?RkpSM3N1RTZEQlEzZ1BjK0NZSGJacW5KTk5PbEVDa2pFekxwY1A4bzRYMlIy?=
 =?utf-8?B?alhNQjBYQksyTG8wSGNtSlZuYlpEQ0t6QkFnck03bXZvMHRxamhCT3QrbWZ4?=
 =?utf-8?B?ckJGcExhVDV0WHRzeDJoUVVWSHdldmJ4S2FxcXk0VDZoNnBWYVNRbmIyckxT?=
 =?utf-8?B?dE44Y1laejVENi9Kcmhsa0RBVjdpdVJKd3gvUGR4bENHdHdUWW1WUWo1MHY1?=
 =?utf-8?B?Y3lLRFhYbGxjWFY3cXBzSHM3REVwQnNUWWZ4NmJzOCtlTzBxNElYTnBNbnN6?=
 =?utf-8?B?N09UN3FiSk1YczZtYUkySVNqRkFjRHVSdUxLa1NEOXExbE9wRll3U0duVkR4?=
 =?utf-8?B?R210NHd5ZXdZU2ZZYitzdDVtQlU3STlxNzFkL3NHOE5SVHlRWHFveGowQXEz?=
 =?utf-8?B?dlNhZldQS1p6M25hWGpmUlB5RlF1bUhKU045aUpZLzQrNmxHWVd5TmlOV1BP?=
 =?utf-8?B?T1VRSWRyUGg5dmJKN1N3SDM1WGpSZUhQTWc5OW94YUhSSFNabzRZZnVLRVQ1?=
 =?utf-8?B?UUY2cmUyQXg3RHJpRi92UzJ0NlVkMkdST3hVTlNKT3l0Sm1ka1BXNi85U2NG?=
 =?utf-8?B?SmZtRzUzdlJYTkR0TDBYZG8ydmJMUkQ4bWFIR1NQZnNyc0FXRHdyOUMreUkr?=
 =?utf-8?B?UUdSSXgzcFFBSlEyempHRThncVZySGx5QXVnQkpjQzR1aExIWUJkK0hvQUxo?=
 =?utf-8?B?bkdsL1A4TmE0TDVMa3NPZ0t6UklqMjJQUlBQOFJ1S3E4S3VkUHVEZGFBcjh2?=
 =?utf-8?B?c1VKK003bjZkVDdVdndTOWlyczdXRWUvRmp3dlQ2WHhwY1V4Uy9pVm9MUmdo?=
 =?utf-8?B?T3J2cldtZnFQSCtVaWJZUVN5L0U4SllydjI1MnhiazIyMFNVWUkvL0ZxcXds?=
 =?utf-8?B?Q0pKVTFhNlhaNkM0WjA4c2RCcjBDTW9aZ3piWm9XYSsvVWg2NDFuTjU4aFFy?=
 =?utf-8?B?OHVnTXF5L1N3bVVBN3hKZUplYWFVR1NrK2N1a3hkdmZKaDhBeG1NeTFJb0ky?=
 =?utf-8?B?OUJFUnVkOTZublpPS2NRL2pPV053UlVIdVdrSVZvblp1bHhJMUZ5OE45N0tx?=
 =?utf-8?B?YzV6WjE5S054SGtxWnVBck95aWJqSGh0YVM5Z1ZqT2IwU0FQYnJHeEM0YkNq?=
 =?utf-8?B?TlBHbEZ6R2o2clZFVm9GL0ZFb0t6R2JiZit2VXFPaDRldUh3NXg4Rm83dlJY?=
 =?utf-8?B?VXJ0akJDYytHVmt3WHZTRmZvUVJNRXg0Tk1YSFFmMkZ6Rlg5aDlIV0ZDblZr?=
 =?utf-8?Q?ZiUWZW/0J8iureEGyeNTSqA2N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b474d4ea-aff1-4a63-a31c-08ddd396aa87
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 20:37:01.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDuADOsEdsMBT3i82Y86l2m0asiTjLteqZut36JKSgWU1QOSpM/z67sN9tYthwpL2Z/CS2EES8vBVGsVrHxSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com

Hi Suchit

I would strongly suggest spending more time understanding reviewer
feedback and incorporating it before sending another version. Most of
the comments below are a repeat from previous reviews by multiple folks.


On 8/4/2025 10:59 AM, Suchit Karunakaran wrote:
> Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
> a constant TSC. This was correctly captured until commit fadb6f569b10
> ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").
> In that commit, an error was introduced while selecting the last P4
> model (0x06) as the upper bound. Model 0x06 was transposed to
> INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> simple typo, probably just copying and pasting the wrong P4 model.
> Fix the constant TSC logic to cover all later P4 models. End at
> INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.


Please use proper spacing and line breaks. Posting this as a single
chunk makes it very hard to read.

> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> 
> Cc: <stable@vger.kernel.org> # v6.15
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 

No blank lines between these 3 statements.

Please take all review comments seriously, even if they are nits.

https://lore.kernel.org/lkml/2025073013-stimulus-snowdrift-d28c@gregkh/

> Changes since v3:
> - Refined changelog
> 
> Changes since v2:
> - Improve commit message
> 
> Changes since v1:
> - Fix incorrect logic
> 

Patch-to-patch changes go below the --- line.

You have been provided the same feedback by other folks as well.

https://lore.kernel.org/lkml/61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com/

https://lore.kernel.org/lkml/2d30ee37-8069-4443-8a80-5233b3b23f66@intel.com/

If you are not sure, please look at other submissions to the mailing
list that do this.

> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..6f5bd5dbc249 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	if (c->x86_power & (1 << 8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
>  		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {

Again, this changes the previous alignment. You do not need the extra
space before INTEL_P4_PRESCOTT. Avoiding that would keep both the lines
aligned.

https://lore.kernel.org/lkml/30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com/

It's acceptable to ask clarifying questions, but disregarding review
comments frustrates reviewers and inclined to ignore future submissions.


>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  	}


