Return-Path: <stable+bounces-195048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968EC67378
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 05:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECB16360617
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 04:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A0262815;
	Tue, 18 Nov 2025 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSdfqhOD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A691E86E
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 04:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438818; cv=fail; b=qSOSPDmhsD0TSOhoFbsKRw2NfPAfM0aQNxEKswK73rnQQBCCLVasdMqXGcdE6uuh8TQ2ybPWRBjq1wcODBEKqfW61SkKH8JQ0fz5pw7a3dE6NSrjjEwGUhE3Df9N9D03WKhBLvb4pM5lsOSkYQEaqtMiUwC8jgdoZIpMIIP3qpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438818; c=relaxed/simple;
	bh=oa2z0Ak34aK0ZQ68yd9U/KXhRh+B3+P1F9tubYeRxkk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neH04hKJNyACrZVFe2wtmsXvwPfp3Oe4ifF0L3a9V5lNf5mxK+rOP20ElOh+AKx47fd2gwdlIlcs0WSOJA+CN5Om6DCaoJC+NNPGrRQ/aLjUH8BoDgWFc/An1S6rsMsxUlgI0bWrxKD509GoKK4ltpUTuUHkYWNtmU49hcUYNtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSdfqhOD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763438816; x=1794974816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oa2z0Ak34aK0ZQ68yd9U/KXhRh+B3+P1F9tubYeRxkk=;
  b=XSdfqhODzzx3nZcYwjyMCPyhqdE31afaXhfChUOoFynQr5AYj6O+w3G9
   hYKT/rogcbQx3hv7rQgYLFd152aLCLqpVWs1QMe6dshyvoOrV8t8wVlyn
   I8ALdmbTtTJEqaSQYtV3Hp94wBZYEH6Nrw1PSelt7ri8vJsxZTX+78mC5
   jcLTc12nexgfs8FydXQOoK11ORuj+PczKjHQh+JvN+95cVVIrDc9CQOlK
   0ceYH4alRjVZOkC7GMFS3GiBNvMeFtlWtSnAU0OzHklqL+8KD3Sriapog
   XnI6WahjjWV9ZjeLU9LIEx6StPIVe9866NkxhwBXZ0c5ZHwRUWe2ayaUa
   w==;
X-CSE-ConnectionGUID: MHPAvJZyQQiio7I/NuhZvg==
X-CSE-MsgGUID: kBae2VHBSgu6U9t97wQLpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82842792"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="82842792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 20:06:56 -0800
X-CSE-ConnectionGUID: Z5w4lig2QBeN9ahCbEKZVg==
X-CSE-MsgGUID: 1PeiYMJ6RCKGCn9TFFwbWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="195564801"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 20:06:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 20:06:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 20:06:55 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 20:06:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxkPax6fpEFsNo809PHLGKOzoC+HJUWUUT3kTQsI//UyD67dOo1RWHG2P3/+S3bZihAGbJXwpbhZo+bRKGWSAM1QKHqUy7kScJNmkJvhy5hVZR4zjJT8UvRsPfPowLtK4C+YD21WtOVDDWzPVhwHAgNqjujc/8gOvGVx6o7Z3I/ZqQe0TiqNpeEmusv860lP6H9+ylDRxkka4InqDwQdDCsAPoOLgEx9iwvZrSY53EEF/iD0MuuyJ/eyxJmo2Vbhti+2pbuVhjqId0DPyCrTEeu/IXcmH7b/ow4V6g7gKheMWSsZNRDCMwrlqicUkaD0HfZVvfD0Fs8WtbhcwQgbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sVeCzPtE5t/p3uXlMB3FGlTuEDryyPR4jzPJn8cUXM=;
 b=gC0orZsD5f72k+wYyafjgOkSA7W3nDY3KxOcX1MPVyyEyhOuPcOCNUtz9PwF6Y2dMERRs/gSGUaz6XrZrfjjsJxTI8TGDWJS2gM9+STbpOq0po1F8zHOJXXhHJACvFK4kBZWKHolZxcwtwIdu8N0NFKpO2e243H+B4zq4vmBOyNHA/xxx60kS7fVhdB6bTxxZA527XBj2LMP1WD9dtloyhg9npvAd5qx82Upv+nEC8I+KROONDcnx5KGOJyKbtolmn2W9MJARHMVHrYNa9sq1us6UDHSea8jGv/MFwCtXOkC52L9uuL/JN32JFjdcohdJR3+hK5syY8k6HhABO5teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 04:06:53 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::81d3:8eb1:c91b:61c3]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::81d3:8eb1:c91b:61c3%2]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 04:06:52 +0000
Message-ID: <18eff18b-ce9e-45c4-b073-31b4f2c30d58@intel.com>
Date: Tue, 18 Nov 2025 09:36:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20251117144420.2873155-2-sanjay.kumar.yadav@intel.com>
 <5fd48726-af72-4bba-9c57-9c9a198d2fa9@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <5fd48726-af72-4bba-9c57-9c9a198d2fa9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0215.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::8) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|SA2PR11MB4779:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f40729-0659-4301-accc-08de2657e797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c21mdGFnTitpYk5uVDhQOEQxR2hKUEVqOGcxNWV1am81TXRWNU5kbzEwQjU5?=
 =?utf-8?B?SlMzOXBCZ1dONjdML1l0SWJveEx3Um1vS3BHUUhXM3IwVlp4ZisyMjIrSkZi?=
 =?utf-8?B?MmpLd0hqNG9BMi82MGZWTjBGbVU1NCtveWxYV1RjRktjamNZLzVkaFNRSnd6?=
 =?utf-8?B?Qm5IY0lleHg4alB6UGIxWmNXVksyRWYxUXBkbjh1YnZVempkVmRtOEZCb3pX?=
 =?utf-8?B?TnN3cklDb1NZYlovZWZvQjJLQnVkMExDcy82ZFNxL0l1UDd5UXlnc1NGcXNs?=
 =?utf-8?B?cjVKQkJMS3VkQmVkc2M0Tk9MbCt3bWdiNFZkZy9ZK21scWJxTjRQUjJwSmRO?=
 =?utf-8?B?NG8zZGVFMDVJQkJzWTN2bnBjUnB6WE1IbVNvYUpmczdjbXZnVXlJY0FxTkR0?=
 =?utf-8?B?SHd4cUtBVDAvWWxaQlMzRHJMc0x6UjczUGZJTUtDY25zYlJLSmtmdVRpQUI2?=
 =?utf-8?B?ZGtvOGwrWmNCbmJLaWhYS1YwS1poWEV6TU5pY1ExYU42Vmloc1VvYzZrNXJG?=
 =?utf-8?B?dEROYUQzbDlFTnh5a0VicUh4RDRudk1vcFdCTGJyOHdCcnE5ckdyUjlmT0xo?=
 =?utf-8?B?K1g4cjZmZ2d2VkhtN1ZVeFlYVmFVV1gvT0ZZSUUrcC9tYjZGMVdBYzc4NVhH?=
 =?utf-8?B?OUV3MXE4NGR6VExlbmE5d3ptREhyRlh0R09RY0w3TzREejQxYTBsd3ZaNXF0?=
 =?utf-8?B?YjhtelByVncra09sOGRETFFXTnVERThhLysxUFM0MVQwSTJFUWdNSXpMSTJQ?=
 =?utf-8?B?RDRhaUJrbHVFZ1JlRldQbmZEMkZZMEFZYVp6NjVGb3NrSUFYS0lqWmE3NkQr?=
 =?utf-8?B?Nkp2YlZMandyN25Qa3pycldqZm1aQTZKM3BjbFdxMnc0bjNPYUNieVdXVUs3?=
 =?utf-8?B?K2RzOHNPaWJtTmx6aDZlemdvYU40SkNBTktlckR1RDNaa0pZQlNmMjBVSTQ4?=
 =?utf-8?B?aHdEUm5mSVpXeE5JRW12ZkwzWkRxZlBLVUV2R291S3lNL1loNjF5S2JTbmQy?=
 =?utf-8?B?dENra29qdzlEc1JJci9zR1BpUjQ2clM5STRDckZOVTN2RXJoSW1pSVRRb3dV?=
 =?utf-8?B?RER6MzN2bWNmdDdIOVNjUkxLbmE1RHdBTHdHWmhVNEZLUFNhRnlkTHlaK3dB?=
 =?utf-8?B?WEpuNDFDVVczY0l1UGNxMWg2ZVU3cVhNLzdaaGppOC9tSmFmbm5DcDhDdVhG?=
 =?utf-8?B?Z2ZMRmhKZjNvUU5RQzZVRzYwT1dEUkk1aHZ5UVdQYXhWZDd6Tk9jZXRhSEVH?=
 =?utf-8?B?alYvMTJKcW9xUjJaaysvdE1WOThSQStiaVVqek56MG1HU0Vvb0g3UVJMTzVH?=
 =?utf-8?B?Rkd3VmpOUmsyRUhsSnVPcEZ2TUxzN3ZpSHZ5eVMwL3lpZzJUUXEwd2E3N2lu?=
 =?utf-8?B?eG5ra0RJNDVNSWZ6TGpPTDRhOUxKcmdSTXlxWDhDVFlWR2EvcE5tdGFOMWNY?=
 =?utf-8?B?YmxmSEdKSytaRUpKNUZEKzJyV3dhMzRGZWR2bU8zTE0xeGxlc2hPWVY3N3c3?=
 =?utf-8?B?cTg2TXByQ1IvSFJYMFBtYitzaCtXS1FhOUhXVGVDVTJ1NDVSb0wzaHVvYUhz?=
 =?utf-8?B?SUF0dmRJWmpCakRsajhUTVdnNjJZUkNLTk1UaDBuN3NVZmZLUXo2T1JiaFAx?=
 =?utf-8?B?dlNqOUlWL2tOMVRVaHN3SlhCMXBJTkhKekJGZTM3RVBocVBYbkdMVkFWK1Z6?=
 =?utf-8?B?YTVMYTZ0RjlLVXRCREt4YmFZeU1hbGpzK29IUG5rcXZaMkFieXFYbGlPTTFr?=
 =?utf-8?B?RzlkVGRVSDNqck5GejlCcWpKbFV1VTFjY1JhaW9qWFdOa21oV2lrU2kycmRv?=
 =?utf-8?B?OXUvUU5vSXdPeEk2T1NYNlN2clJ5azFGTUZKZnlhMVRhN2pISFFneVJPdnlK?=
 =?utf-8?B?UitLSzBDVU9OL1VEVnltMVcwZ1QyRTlaQVdnUzZCaHVrY1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8208.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2o4VXc5K0pXbnIreVBCc3FRTWxvU3REOElpcy9salo5Rmp4b1ZXN1lGZGZ5?=
 =?utf-8?B?MWpPdSs3REowaFZMSGpER2VRMnJJelZ4M21pQUhKZDA2M0pNK29OejgxNlZF?=
 =?utf-8?B?L0lLUWUwcjU0TVN5QzFaUStQYUVBNTB5KzJ6UlpiMnVMcnBpblM2RDVkTWpM?=
 =?utf-8?B?bkwwOVIzLzNneS91TUZpdERaNFU2cUcvSmpCYWl3S3d0ZWx6bGRFNzk3NkM4?=
 =?utf-8?B?bStwK0F5OFFKY3VkaVlrTnRaTTJvWkdiZi9ZdEhka0NEZ3VvUmt0UjZndTdm?=
 =?utf-8?B?djdDZFFheHA5a1lQNXFITEx6bnFZS2hLVno1YmMyNVlyZ2FSZStweDIzNCsx?=
 =?utf-8?B?UlUwanVxdmNkZjk4K0FOSzNDRE5YT3dvMW9SMVlSZm00Ym5PbFE2N1o1S3M5?=
 =?utf-8?B?M0xnZTJreXl3ZE9OQUdLZTRiTDgzclFPbHVwZy9XOFNIUnp6K3p4cUp3czhI?=
 =?utf-8?B?RDZxUHZib1pGbTVMcmk3Y21WdG8zMWtyb0I4cy8rNTlVRFhDdkt6YVJjVTgr?=
 =?utf-8?B?RGhRYlZCbDVuSWJpT2xycFNCOWpVYmFlNFBMZDJ2b2FYQTN3QzdpTUV4TjFi?=
 =?utf-8?B?TkM0bzUxN1h6SnIwVm52T2RaZjBzQ2hhK1RpeFd4U2V0aHAxQXptY3dSdWFY?=
 =?utf-8?B?RXRKd3BIeUozSjFzSncySGdWVU9FUkpXc1I5bFNLbWxPb1N6dDJsc1ZSYy91?=
 =?utf-8?B?bXhRb3VxSmNGb1lXM3czRC9WUWVIVC9MNE03N1AwVDFpQlhEc1R0blBHL1JW?=
 =?utf-8?B?Y25iR21jZnpiaVR6NFl4UXdKSjRXaGNva3dvL053dHRwaEdUTS9YcHBJODRD?=
 =?utf-8?B?dWtrSU0vUlorc2pDa2xRdzN5ZDdUSjlMYlpEVHhxZDVGTUhKR29ML2ZxM3JW?=
 =?utf-8?B?VmpJNlpJWVF5RVRSNUpqRTdRSStyamxaQnJqRENKWFkxOE90WFYwazlleFhR?=
 =?utf-8?B?dG5DZ1RDMnZGOGVyYWhEQTBWU0FlWE9CRkM5azQ2TzlDY3lVOS9kYUNXb3Vo?=
 =?utf-8?B?VU9Za2dZRm5maHpwYUxyYi9VTWhQcllSZFExQkZsNUYzZDZGeS9QNXJ4NnlQ?=
 =?utf-8?B?czU2RjJpSjRQeTg0VWZpaFE5MmpJRUN5MWtBZ1RmRm5LazJac21rdWgwam5k?=
 =?utf-8?B?SVVNQTQwam9OcC9kSjBGNTlBSDlCWmxXYnBkZUJZa2p4UjRRdldUdjMwY1A4?=
 =?utf-8?B?Q1NZY1cwTHJCeWJKVGJoOVVKazFFMDJ6VWxmOSt4TUNjblRsVXdsUE9FUXYv?=
 =?utf-8?B?V0xGNXFUcWpoM0Vrb1ZFY1JLZ0NBdTZnWEM0MGZ6YlNpbGZKM0hVOHBkd2U4?=
 =?utf-8?B?N0FQWTdPazBNMlhGeEVmSWVNRDNBbUxhWVBydm5tWkdqSVFDNUZ6Sm9SZmpR?=
 =?utf-8?B?dGlYK0dmRWJmNzBBVE9aeGFpZHU2ZE16d1JZVTUzUXc3eFEvZGNEQnB4VE1l?=
 =?utf-8?B?eCt1bDdad2hZbzY2aWIwODkwd3J5ak1henB4RitjRjAwdHVxSGNuMGF3Umx2?=
 =?utf-8?B?N1lPVHptSHBNY2FqUFNNV2dsTXJwZFdOdTlzRE5ja2J5bVIwdjd0UTFCSlQv?=
 =?utf-8?B?RFphcFdUM2hnMkVpdEhhdnNJaGE0bVJwanpxMUg5L2ZGalpadGpoK2xXRHBo?=
 =?utf-8?B?RjJYcXVTWmFHTG5IMkNuOFRIWHlIU1hIaGovcjhYcXRuUkVDTE9YbEgwYXhr?=
 =?utf-8?B?d2RRa3lITGgyem41b0NwRWhIU3JMMHFhQmhWdUZ3MU9JbFlCV1BLbzdITkt1?=
 =?utf-8?B?elZVL1VRbkxlM0ZNSE1BTUh6TTY3TFRVdE8wak1JM2lyOWdUdWRabnRiQnFS?=
 =?utf-8?B?MDdjNHR6aGNvN3BVS2NRcmRpZFdvdXFiMWltZ3l3TTE1YzRGVWhzRTI3bkZ3?=
 =?utf-8?B?aVZmeEhpMkFwZE42OG96aUxTU0poNUUvcWQrSXVWMGdGME9iRWVXS0wza2kr?=
 =?utf-8?B?M05oWW9kUlBtYVNhQjFUcSsyNCtQM3V0YXBhTFJSbWNmQjNiMitRcGVwOWFM?=
 =?utf-8?B?TjE3UkNBMmRXSE1oTkloTm02ZFlMZVpYNGVtaHc0V1ZZeUVYUndNNG1pam9K?=
 =?utf-8?B?ai9XQ3lGRHlNRjFsbU94Szg2bWViNTZ4dkw4M292KzVCYlAyMEpqdUx6c3B0?=
 =?utf-8?B?ZGdOQjZ0NFNOZFVBZmRKUW1rNWV3dGh3emVVZ2oyMldUTHRQdEZ2M3pLUjlP?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f40729-0659-4301-accc-08de2657e797
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 04:06:52.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1f7J9vLaQVkpBErXi7QVMa+WQqQ0CQB2mtdoGhKdSSlWx70GrRmZzMcdIbBSMevtqJ/XWtuHwCpGNLi9ZWL8zJ5cGXZihAumwhLXT0yI3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-OriginatorOrg: intel.com


On 17-11-2025 20:23, Matthew Auld wrote:
> On 17/11/2025 14:44, Sanjay Yadav wrote:
>> In xe_oa_add_config_ioctl(), we accessed oa_config->id after dropping
>> metrics_lock. Since this lock protects the lifetime of oa_config, an
>> attacker could guess the id and call xe_oa_remove_config_ioctl() with
>> perfect timing, freeing oa_config before we dereference it, leading to
>> a potential use-after-free.
>>
>> Fix this by caching the id in a local variable while holding the lock.
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6614
>> Fixes: cdf02fe1a94a7 ("drm/xe/oa/uapi: Add/remove OA config perf ops")
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_oa.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>> index 87a2bf53d661..8f954bc3eed5 100644
>> --- a/drivers/gpu/drm/xe/xe_oa.c
>> +++ b/drivers/gpu/drm/xe/xe_oa.c
>> @@ -2403,11 +2403,13 @@ int xe_oa_add_config_ioctl(struct drm_device 
>> *dev, u64 data, struct drm_file *fi
>>           goto sysfs_err;
>>       }
>>   -    mutex_unlock(&oa->metrics_lock);
>> +    id = oa_config->id;
>> +
>> +    drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", 
>> oa_config->uuid, id);
>>   -    drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", 
>> oa_config->uuid, oa_config->id);
>> +    mutex_unlock(&oa->metrics_lock);
>>   -    return oa_config->id;
>> +    return id;
>>     sysfs_err:
>>       mutex_unlock(&oa->metrics_lock);
>> @@ -2461,10 +2463,10 @@ int xe_oa_remove_config_ioctl(struct 
>> drm_device *dev, u64 data, struct drm_file
>>       sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
>>       idr_remove(&oa->metrics_idr, arg);
>>   -    mutex_unlock(&oa->metrics_lock);
>> -
>>       drm_dbg(&oa->xe->drm, "Removed config %s id=%i\n", 
>> oa_config->uuid, oa_config->id);
>>   +    mutex_unlock(&oa->metrics_lock);
>> +
>
> AFAICT there is not need for this change, since this path is holding a 
> reference to the config which is only dropped below?
Thanks for looking closely.
idr_remove() doesn’t free the object immediately, it just removes it 
from the IDR. The actual free happens when the last reference is dropped.
No case premature free here.
>
>>       xe_oa_config_put(oa_config);
>>         return 0;
>

