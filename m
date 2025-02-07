Return-Path: <stable+bounces-114207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D5A2BC16
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 08:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DC47A29E9
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A919AD5C;
	Fri,  7 Feb 2025 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hqaiemtx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA119995E;
	Fri,  7 Feb 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912426; cv=fail; b=JxYFPlCL0v44zhhZFyZIa9ZejnxS3JFMqYmhnTC0UrBiPdlpqDX+FO22Nhj75gs3dYA2ySt0y85EdjgqSNwLNn7T52Y9eqZHNBrvPNRg7FQ9OhSm1esdG7uZ3sLA618wVqPrI2zBRlmOFHChAh3FliZpP0P1qE5piEVkJu23OYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912426; c=relaxed/simple;
	bh=drrhySd7A/mWQxmTm2fYwmYewFmyvZfmQIxvWmJNGEo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n66X1adPHiEjk/Qzh10jKJRwV+P4KbeA243xukTAeOhLZqoSVmHiffD6imoT6MC40vKaEdVloXLrFF4tHTeXquAAetrJmWzQ4Ob0G+Ng3iCuLaAGawEImEDFE+WSbmZb8pGhz6Mk6geKcOgjt7N5YI+OPvwTyHsovm2hWaoUvuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hqaiemtx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738912425; x=1770448425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=drrhySd7A/mWQxmTm2fYwmYewFmyvZfmQIxvWmJNGEo=;
  b=Hqaiemtx15fcMXac3qn8M5vTKsfxuABUZnSgAc2NqA3soCwAqV5IoU97
   oCuWiBqneGTNhhXOzw+FvkTAnqyhX3VnkZk/V054KD+3CN+C/PtffoYhr
   1pIGE06+DkHdfCOcleHRbQq4Fpi6YV5HNbOUUOOP9Faxy6XzEPLcHVTLE
   VqIS40omucH5jIT/6kGf+qw5RVJeGvGwrznEYPiR6d/DxMrAMGhYeqiFe
   +gSvE0WGpJFUL1Ke1sw7DyAvSTdfpq0ZKtdQ27qpqtvT2qIj9ZPAqAtyC
   mY++PQdWBhbkAzOIZ0cvKDb+x8mj8xMuhVfL5LQvtu3yhndny3+YcvYbC
   Q==;
X-CSE-ConnectionGUID: Aw2nXkylS6+gGjuIu9Aw+Q==
X-CSE-MsgGUID: /6PdlNq2R7KfeCMDGAjynQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50935516"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="50935516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 23:13:43 -0800
X-CSE-ConnectionGUID: 7aaeVXn9QRC/7YJ4pgDB0Q==
X-CSE-MsgGUID: /2WVn+dISC2EI0WJf/n7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="111418860"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 23:13:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 23:13:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 23:13:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 23:13:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4HmvxntYGXSgqP1YZLBiMI7l4sch678o6IDlDS/mCuJ4ZkySL0C3CgUz/B08rWAtRez3aFLO+XZ1B73dDVNjzxC6l4/vyotRFSDGd/0EPVfDYYUht0+GOplHsCRi3HrcuELfohf7Zk6yHrlBJpeNkD12SDucc7G2sNvD8ouFHWReN/U1D0fdYpBLd89DK6XapWe4w+Jx9agEEDRFYR4cr7G7OYhP5G/RmH1YWRUrH5pDQC9mWamUl5dxVL0IpLHJ1eLI7NkOxqD7ekFV+xInMZhJzguBrVTtwe92izt0sw/lrpmEbsXVAzGxPU1O5Xz5sPxyKVzlhCg9lZge8MRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2epVEidhfMZraePLPZ1HqXGYcRMdSLRcnGUW7Rei8v4=;
 b=aKkh+i0sXyDzHAGtnbIeUscxCP96GSdTetv19fh7vrpYG5okXKs8P4/N8odxX0xooU8HTrOF2do9/txpyMHvT67fLqTSlSJ3c24ulQEZNaF/2f5TpcoFvmrs0ux0Rfk0e5qlIwmrnIq/S3E1JCb7OIXyuizBF0F0Bgjz/SZFhM5MY16NSCFXZLOV7EB6L3uKXNiqjyBmZ9JOisrSz0xvqsTNNYAXvOauxjyMdGFuIK85WAZSbTNCezPlLft8smnivk93cDrzx97f3UdOwAhKXq+vjD7FLxagToGnkLLrD+KkWNmYtQ+AHo6PK6MN6qQ56uS8JX0Q6hURgZ4LxwRrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20)
 by SN7PR11MB7139.namprd11.prod.outlook.com (2603:10b6:806:2a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 7 Feb
 2025 07:13:41 +0000
Received: from SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::e7f4:5855:88a5:496c]) by SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::e7f4:5855:88a5:496c%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 07:13:41 +0000
Message-ID: <e16551dd-3a84-49ba-b875-c11f77239984@intel.com>
Date: Fri, 7 Feb 2025 08:13:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] ptp: vmclock: bugfixes and cleanups for
 error handling
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"David Woodhouse" <dwmw2@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
CC: David Woodhouse <dwmw@amazon.co.uk>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To SN7PR11MB6678.namprd11.prod.outlook.com
 (2603:10b6:806:26a::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB6678:EE_|SN7PR11MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: a6505708-f72d-4334-a3fa-08dd4746f2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WURHL2h1UUFoVk1IUEoxQWpYZkZyMExSZ0twdVk3NVQyS1ZBa3JXRDBQaUFD?=
 =?utf-8?B?aDg0b1dST3ovMDdWMW5YdU0yUEhuVjIrL29PUG1lbzduRTZ5eWxseWR6dTVo?=
 =?utf-8?B?bVhvS1lrVUlwRms1WmtIOUhJbVRQQlAyVzhmdXdOMjBtQ2xiNm5BeHFtekVQ?=
 =?utf-8?B?NW9WLytPTHJNU2hVS0o0OFJhNDNkR3FKdTNBMDBPTU5JL0UvaXUyc2R4aFFE?=
 =?utf-8?B?MmZ3czlXSVVsYUQ1SHAwbzRpSnF6R3Zub2t0MzUvenI4cFBrZWtpMjU4MGJV?=
 =?utf-8?B?UEdLSTAzVGNabTc0QnJwSzNGVTBkUlVqbEF3UlRsYmE0MUdPYUNnR1Bsd1c1?=
 =?utf-8?B?QXA3UXZENThmbXVzQU9GWTNzSW9tYmxraUxQN1duZ29VcGNEeTJzSkY0K0Q3?=
 =?utf-8?B?amZUTGp5OFpnR3dFTlR1d203amNjOVdRejNIbGFoYW1SRXZya1NhdnRwMzdj?=
 =?utf-8?B?eUU0QUZhK3FXYk85WUpMSzQzM0FwMElaQytRc2p4OW5adWsxUWZJK2pXcXpI?=
 =?utf-8?B?Y2tuYkdqdGtRT0FLT2psWmZpekExU09EaEZtQkp5aWRIRzZ3SEhSUERVMVcx?=
 =?utf-8?B?dXh3NVBZbnNXMHFER1Z3YVo2d3FXbk55YTdYbTZPRXNTeDVKcVlPYXEwamxX?=
 =?utf-8?B?T0NZQzVycEl3TVVua3lUWWhLRDRTRjYvRGttWUFpbktCRGhpa0RGeXJFeUVz?=
 =?utf-8?B?VDZqYmFpSG4zTUp0aExoblZudmkrUTB4VW11WXU2MllyaHJPR0w3dk1ZMUQw?=
 =?utf-8?B?YmwybWx3andEd3VZSTk0dEdqSzJxdG9sSFJEMDhJR1ZacGFBY01ZYVF1VU1K?=
 =?utf-8?B?Z2c4bi9VbFZhbXJTbEFRNWIycitDWldJTm5LV2JmeTFZVUMvcHdvV1d4dDRL?=
 =?utf-8?B?YkN4Rjk5WkgwY0lOWHhkQkVXQjhldzYvekhMZFlRRUZGcklDWTBJeVhNbCt5?=
 =?utf-8?B?K0k1YlMwbVR2TytXeDFVcFJTb2srMUpYdlBqWHJtYVJ2OXBzWWdWbXdQNXli?=
 =?utf-8?B?UDgwZ0FXM3NkSWJBcThseXhpV0FiT0JQWG9iZldVOWZHTVVBb0g1QWtRSjV5?=
 =?utf-8?B?cDF5ODBqMnRELzlkOEltNW85NGxTY3VEbTR1SVRWRG4xZWFzY0M5UU1BZUx6?=
 =?utf-8?B?Z3dkYzZENWxGZFlkc1RPMXNEVEJvS24vaE9ObTBTbmlmTzlsSFZnMy9lSUhn?=
 =?utf-8?B?N1lzYTNWVjl3TTNzZkswUWQ5dlA1Z1dYRHlJbnZpWUdjT2FPbVhhQ1NmNEtw?=
 =?utf-8?B?Y0l1dVRXWWliVmU3SHZNY1RYR3FpNEpOZlBkd0JtSXM5Wm0zbElnZlhEQTVx?=
 =?utf-8?B?Z3NpQlZwYmdiL3VIOEhpUUtZRVh5ejhWdG9oNEF4RjJCdHhCWGJ0dWtnSTJm?=
 =?utf-8?B?Vk9KcTd4U0xXMy8wd2M2bnc0RXNWWnJhOVFjc2k2Skk0MUMvUjZmdGZkVFhT?=
 =?utf-8?B?WkR4b01XcUhpVGxBVnNCall5aE0rZFVZcExhQy9WWEtRVmVlRXYrR1dRUE5W?=
 =?utf-8?B?ckdZK0YxWUE4WS9US0lsNm5iRTJIVFNSMU1BRG5Fa0VwdGJvL1Q3WHNLT3F3?=
 =?utf-8?B?SjNNdzdTSFNvQnpmcUNBVVFhSnQ2bkFxRUNSOC9IVEZqSjlmdjBVb2V0Ry8y?=
 =?utf-8?B?WWFNUTFPbWd6R0lMaVNVaU5xZWhLRFZpU29JdENaT1lLUEFDZ1NyQ2lLUVkx?=
 =?utf-8?B?S3JBZVhMY2tSUTZWK0t4QVAxeDh3eVBpYmFaZ0FFT3pOWTJaVGxTL2JTVlE3?=
 =?utf-8?B?QVBoQ2ZHNU9sNXlNVGI0a2RqY3RweHZkZGd2bHExdHNtbjdiVk1admN0V01o?=
 =?utf-8?B?cnh2dnRkb0ZWTWZnVWV4TCtCWWw0REk0N2I4UTliUmk0UnovQ1U2bWhHVzVV?=
 =?utf-8?Q?YoNbXzEBm99dw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlSNU02NTFMK1BPcjBENWVsazA5N3FBVnZFK1FnbnZjNS9qY0J5eVp6UHZw?=
 =?utf-8?B?cWlnOWtWMGJyaGxBZVpoaVV5dGNrZlJ1bDhFd1g2cFVCSVQ4MGhMSWJWSFpG?=
 =?utf-8?B?V1UrdmF1UUhzVHgwcXljNTFvNnBocm9ZNzJab0wvZVpyUWZTNnR6WGowVEk0?=
 =?utf-8?B?MXFYT0hoc3l5WVFYZTNqTFZENFVXemo0TlFpTlFpYU81bWNsUllLSk5Md28x?=
 =?utf-8?B?YmZVL1FCOUdyMzVrM05YQ1kvc0RTcWRlYnFUWXFQTkFhaEVQWmFVRVg1MzZR?=
 =?utf-8?B?VnZOaHpONWNQSkxFb01XZjFLV3dQbzQzR0VrRnNjbi80UnV4ME80ZXk5dFFX?=
 =?utf-8?B?YTBVa2NBSUZLN0poRkYxRFNlQ0IySE5xQllGUGh6eHNRNFVORXc5QlM3bVZv?=
 =?utf-8?B?T0hTakhCcndYYTNrK1gzSTBvUlZNSFdqRlQ2ODMyQWhKSGo3UkMvclYwMlNt?=
 =?utf-8?B?NU1BZUU4cW9zakdCellIbERlZnpNLyt1UVVEdXd5dnZTSG8vWVkvRHJyZVFs?=
 =?utf-8?B?dERUa3BtaFZ3M3h6aTQ4NnVMY3hxNjMvZGZKZC9sZDlPVGM4bDA1eUVuRGJv?=
 =?utf-8?B?aDBQbyswY2tTMSs5Sm10MVJ4TGdCd2UrTWo0N0sxV3BYVEEvVUZPa3dFc05X?=
 =?utf-8?B?TEkraUI5WVI2UTdIdWNkVHNTRGFYZHhwL3lST1gyK3lDVnNCazQrR3dhUmY2?=
 =?utf-8?B?NFhXbzhuczg5Ni9JOVQ1bVcwUWh4WFpHUjBIaDE2b29zQUNjOGgvVHdKUi9V?=
 =?utf-8?B?Tnl2T3pMR0FqYy83blR1NmhLQlJlVWpwUW5obVdXYlVqU0J5TllMOGJhMFlq?=
 =?utf-8?B?eUVobWtuTHlwVXk5cnh5aVlqU1lDZW9DVUJ2MlUzL3kzaE1kUSt5enAvd0JN?=
 =?utf-8?B?bVNNWjBTKzlieHRwK3IxZlBIbGQyOU9FN2RkNmR0WHp6YzJ0UEppUXRqT3Jz?=
 =?utf-8?B?QWIzc1cyTjZRZVBKUmdKNDJEeGhMOTZGcjA1TUwxaXIyc1ZHVktQK0RIMjdE?=
 =?utf-8?B?Zko4RlZzbVNkdURaWE5rN3Qrek5SWDk5MERwM1BNSUxNRFRXWGlhWnp0NTBJ?=
 =?utf-8?B?RkJOOCt1dk5aMXI0eE9jMmdUeDZvSFpzQkliUXcwbU1qR3V3dVpMMHJRVFhN?=
 =?utf-8?B?RmcyWXMwTTR6ZVZtVDFNSHZYU3RmQ1RTcUk1L3VZNmk0ZXJPcGZFZkZONjU2?=
 =?utf-8?B?U2lQZ2lZSFBhRmMzdlo2aFlpdCs4SHhwZTJVRElrSlZQNDlycC9Ud2hWTHNz?=
 =?utf-8?B?MHFpbVRUUXNRNXcwUCs5TzFkQktOTGdZRklITHFGS0d1QnJtd3VuSzFVTGMr?=
 =?utf-8?B?WkJMUXlvREpnK0lWZU5aa1ZSSFIyZFViMUhHRFJFb0txSUZiUWphTVk0RFRi?=
 =?utf-8?B?NXk3a0lXa2t3VHFVMXZSak5nOTJiUDd5TjJaQ3kvNnVLd0ZrYXlzZTJWWjNG?=
 =?utf-8?B?WVY2U1ppTXNTdDBiODJ1SmJBOTUxd1M5TEllZG4wQ1o3ZFBralVET1U5dHJC?=
 =?utf-8?B?K0pMZ0t0dlZ4TkU5eXVQaFpXbGt2WGhKd1lqeDZUN2NFamVvdFZwQlF3clRH?=
 =?utf-8?B?MjluN29BUmRYZ0NFTk5BeG4zbFRwYXRvTnhRU2xIa24vSmZzMVFCajllNVdj?=
 =?utf-8?B?N29WSTdPK2tHY1ZUUzlPNC9YWWlkMVQxY1NZSUhVM0RPSnlRUHB0UmRIbDV4?=
 =?utf-8?B?c1lISEdsQ1kyQzUvd3N4cTVTV1VDSndIa0JTM2hERzk2Wk04VTg4N29PZmV0?=
 =?utf-8?B?QlI0c0tXZy9LU3hUTTZVRml0TU8xV0RiLzgxSjN4OGdac0ZDZng5QWhzVWRM?=
 =?utf-8?B?V1ZrYmFBUVl5L1U2TFE5cEMzcmpRZkVZTHBLOFhCbEsvb1FWUVZweGV0eGFu?=
 =?utf-8?B?ZUhzeVJlSmlCYzFnOElCQ05nNEhTUXZKNjhVbzVxQU5RYkVjQ093Z0lQN1JI?=
 =?utf-8?B?ZzdZa1hmZzg1OGJLbGlBU0VhQVNIb1BvK0JYL3EyeU9vUXBsdGhLNUNwanhk?=
 =?utf-8?B?bmN3eEVnMGxSYTBYSjIzVk5DRkVYMWNrQWdrSmwzS0ljYXRrTStKK1NEdDZP?=
 =?utf-8?B?OFBCTFhoWG40RVl0S1ZUK2JNRG9GNTNuajlSMkVEV2lVekZvWDZnbWdEcmor?=
 =?utf-8?B?OS8wOUN2UlRyNjduWXhnczNIb2czMEc3ZW5oQUhUMjdBSVhWbUJqRVVNbjNl?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6505708-f72d-4334-a3fa-08dd4746f2e4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 07:13:40.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZUDnSGyeqOJj9N2KrQ5FISDR1EN/FMsbZdkX4iVx3CkuJXJk1VwppyQwpZ9dQMDbk06DqQio/BZOGNouwJK3nb8gsK6+BBjVYKHpzxBAsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7139
X-OriginatorOrg: intel.com



On 2/6/2025 6:45 PM, Thomas Weißschuh wrote:
> Some error handling issues I noticed while looking at the code.
> 
> Only compile-tested.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weißschuh (4):
>        ptp: vmclock: Set driver data before its usage
>        ptp: vmclock: Don't unregister misc device if it was not registered
>        ptp: vmclock: Clean up miscdev and ptp clock through devres
>        ptp: vmclock: Remove goto-based cleanup logic
> 
>   drivers/ptp/ptp_vmclock.c | 46 ++++++++++++++++++++--------------------------
>   1 file changed, 20 insertions(+), 26 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250206-vmclock-probe-57cbcb770925
> 
> Best regards,

As those all are fixes and cleanups then I think it should be tagged to
net not net-next.

thanks


