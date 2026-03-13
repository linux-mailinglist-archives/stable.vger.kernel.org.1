Return-Path: <stable+bounces-225381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONsMNQh0tGmUoQAAu9opvQ
	(envelope-from <stable+bounces-225381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:31:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE888289BC4
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D41B73015EF5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1754413A3ED;
	Fri, 13 Mar 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5uTMbrp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304D18027
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433857; cv=fail; b=ZIJwdR2ojaSd7ZfhOc0Bz6Tn3d/aX3MWgzSlBHJCJer9UJi/TVHV4m8gYRflO8d0VlKJkmUfqGPnlxA6HqEhMsNscazOl3CCIjaLa0j+EipUiFriWLO7LIJBC0wZnQ57ZMAQo/VV0SJB6Plw0miZlmpz9DKy7P8iWp/BBPBfRa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433857; c=relaxed/simple;
	bh=rj+YtA9Qn6nV0DcI0zKy2ohmvGQDL5Kgl2966wD7J/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M6TkPxK2fRH6KYF9wlIe+igWu/cgdqpC3lNq+svNC0Psu78TflvrV29IQyVLjFoXmwkkBs91O/G+cwlwH68zsvWofRboJqZD0fCPxYJAFKwqndUIb+RoxRvOKfupPNLZ4D6hkIESqZyWKnP9z1aIO+gf0CCfx8A4NH+BeAGThMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5uTMbrp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773433856; x=1804969856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rj+YtA9Qn6nV0DcI0zKy2ohmvGQDL5Kgl2966wD7J/A=;
  b=G5uTMbrpVKM1+RP4T25W4Rlrysy9KcU4NhDYnHBXZhPkJlOK6hw1RLCr
   pRdlsvsUJK+WYyhgdFOB3SLQ+oHMBkcdIDe+H8qE+180MIkmRWaP38RcL
   7rqBF1xPdyxVGMONLILWsqaNgZI8YGqQQ4vXiUGPnhnhpuTs8pu5Itlfv
   qgRn71Dj9kWY0+28onXq8rHJi34G6xOtAiYPco1N5LW4ATPiAs2Tv9Zgu
   ZqvF5jOL5tuJBKs0Q2Ze4m++rr3GqQfe8DowPa3BJ9mgYM2wZKR9fIE1y
   KZFKKf9eCtK7EoBKlw5EMxlVEEdLDXaXcv05KSAFf81oPwYRvulfkby+J
   w==;
X-CSE-ConnectionGUID: dB8PJe7eTiaLBhBWU7gavg==
X-CSE-MsgGUID: XiB1tg2bTza5Ik9GudR0YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85251076"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85251076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 13:30:55 -0700
X-CSE-ConnectionGUID: PyiGRI7yQuCiBYbL6kL2tw==
X-CSE-MsgGUID: N+Tv0IIFTmSJj1s8vtub7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="223642641"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 13:30:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 13:30:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 13:30:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 13:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUX4wA+DRn1vIdg4ypP0tsqqbL0/A0ter1wRiuYmVf07IffFzzeqvrKBIKo6RKksgtZiHLdsen6ACwNtdPyv0euW3WlpaRM7N6nx5f5aTsX1cwznB0+50zI3fTsg4AjVN4FdDHrOSbGjwA3JkOrOghsyFaJeYflLMPddGulHazvItH4CDg9nJ5Oiph5tEyaWqmjkVmpEgqqBGIIYGf3qLfPyuS8YpG8Q4fSKzOojkUV2raHvycWx1w8S0UiBXlSmUSJY9MEnD/xGV/Wtm1mKlDlm3HsyIHulGg8nLyARb8g+VUmgWm15f3mn/yQiNxOZWF2kEzWpqhvUV6lP12wvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJpQwT7JSIcweo8bMGE2S/WqfNiuh4S/t7xqiE8osVs=;
 b=bK2cO50ZZHNZ/RTmwgFzh5++1vaZLFPHYSRYfPs+vp1VfUaI3Qu6nkz/Wx7NnpEIPjmMLyxAnjiE6yVRUGzoW6n6UX2BUjvdkeOivOAbr+FQSQfzzEWWR26zOH8KPZBJ97WN+DbbEYD0rqm2/GvpdK3riFAVkW4ZM2+ywrA1FuxqERvKtYETBqWBBI++hpFX8II7Db5UMmmk32wYX5yzkQvJFPaTINLMcWPtKb24PjDUQ7aeVbAhc9RdvAdBCkNfbc3t+U6bZ2gBHjNPTs+BULodw/UYbACaer7GtyDowEjgI2m6EabDrAiMh54BQz4IAOOlBDLHi8gziMdpwVFl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 20:30:49 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 20:30:49 +0000
Message-ID: <31874a01-7028-4db7-af71-b22108bc9e02@intel.com>
Date: Fri, 13 Mar 2026 16:30:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] drm/xe: Forcefully tear down exec queues in GuC
 submit fini
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
 <20260310225039.1320161-3-zhanjun.dong@intel.com>
 <70fc23c8-a926-4767-bb8b-bf134a6eea95@intel.com>
 <abRb842rJCYXF3dK@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <abRb842rJCYXF3dK@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|PH0PR11MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e48708-0c63-4432-5a3d-08de813f69f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QP+cCNwKsVWfkpDYrsZmlF1tQ0uCbU0aTCu4YmiyRqufqxMHeNi2WdNVurnbG62gJ1WaJJ3Ey3wYiVXjulJlEsqXun68sJRGREzlNPyV5UBR2wdg7mhHu2e0S+0FlhFlOb2NEJOG9Gd/Pv38y3lqdyVpqGJGF8x74ipp16oQ95OjSNuxh1fKhFm2RyQgqt9GDSqhpJ+wSnhqKhlx5/rmKysr7mSB0jpP+N3tjJTqJA7HTAnXczRqoIcmtnY8QJZFq2HnkSTPzAe8juAnCmIuOxDu/VpxFM+9di6z6xUS0mRFBuUR2tWzKsZ5KZMYq+6KI0EkzbZ7nTo9XBOM6JJ3qBKRdWfU02vYFoCSSDS+ouzM3Ey/zuzhgkHHDQuxtjT1nnuIkB4rHZAxI3dPurKUJr7AKl/x6Kh2w6snJEYWVtMkL2YNfrBQTV/xXsiXYFaXXPeVzguECJ+kAtBF6JcceFpLOglQSDftExMFlZEVWOMWsgCHNFwr3iOJO9wLqi10BU6CFfT6qpzzYdV8+UKDOHIRnN9O4DjGNKOqt9VWxdsfzTz48O1pMSoh0hWNQ8cLPdyEcMRkHJ8VrfspIHQtQuiHGMC1w4ZGf4hCChkQ/Rqh3gjXP54u2MQW1clb8bJMc1iPMRJhyeFbkdiK3a0VwS+nMPKn8wp1pJe3CGtnI4S+Wglu9lPGuH8KeJUh5ay0gn8JbazAis2KXkoh+8NmlBhICz2bCBhDRrduEKy5gro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FmUUVZdmR3TTVFdlBaZG5MTEYwckRvTVF1cVc3eDIyK05ZWVZaQW4zZzNs?=
 =?utf-8?B?U3NUUUxqWWptalAwaFpZcFUzTldKeFhrWXdLelZ5RHc5bDcyajh5VXBPQUY0?=
 =?utf-8?B?UHRScTJiNHJMSlcyb1VpVjZ5MllVendSR1VFWG9CakpQU1JwOHQ0TmJJcHRk?=
 =?utf-8?B?aGc5ZUdHTkRuR3VkK3hYVW9EcjR6bHlVZmdxK295eVYrMXM3Qjl3T0VxemZh?=
 =?utf-8?B?M1ZZekdvMVo5YjFBcjQrWklDTEkvb1hNSzZBN1JCMnJoK2Z2MnR1QlJMNDJO?=
 =?utf-8?B?YjF5b09CQmYyemxmMk9vRFJGRXIzTXNnZzN3TXdDL09VUnQ1WktSc3A3L2c0?=
 =?utf-8?B?L0RqZnd1S3o4UHVpdmwxUEpLV2VmSC9INWVEQUlRemZsMnJrdTY3WjdST291?=
 =?utf-8?B?TDZKM1RZYXl3cldHdHQyZDczdVdZZjUvSkE1N2ZiR0trV2hCMHc5NC9nTDdC?=
 =?utf-8?B?bXlzc1dzdlhtZExZWllVamRpUHluVk9oZEx3Z0FYTWN5UUEzbUlVc09uN0Rm?=
 =?utf-8?B?YzBCVEthcTZYTnpKamJnbUIrWklIOHhrNk5YVDJSbnkwNldOVng3NVVBWVNN?=
 =?utf-8?B?NHZxZFRlMDJqenh5QlRyRzNHUkgzeksyejJIQmlWZjlya2NMNmcyWU9Pc0xm?=
 =?utf-8?B?bWhXRVJxV2libDBwYTVnZzBsUy9wQ1liOGVKb0ZHV1JRd01oZVJSQVpFek1Y?=
 =?utf-8?B?VXVPdDFrclhBeWpZMlVCVnhpN1dxZ091b3hjSG9HSHd4WFBmVDRsSDFnaEVa?=
 =?utf-8?B?U05uMDc4WXI0MTJjMDdVZXFDVkltQUhISHhJKytNTDJxZDUwWGRqOGsveWZC?=
 =?utf-8?B?K0djK3FTNW84ZkxxMG9DVUZ4Z3krbllQTFpic0hISUpyWmIyS3A5anBLRGxZ?=
 =?utf-8?B?eGlKcWJHdnBHZlBqbVNWU1IvMzZ6VXdMY3JFdlp6U01uZnBPTVlBTzhzNHA2?=
 =?utf-8?B?dlBMMmVVSTdxb2Vwbzd3cS9JcVpHWXFKeGsrY0RPZnJLbGJpRHM1a2RWTGR2?=
 =?utf-8?B?RFJJbDRqREk5NDFGSUVkY1YrVU5YQ3cxR3BVSjhHRnNDcjhFUXRqK1puSzl0?=
 =?utf-8?B?eExEUVprZ1RXZU1vN2ZVWTRPNEdzNWs1YkdCQjNBMTY4T3FwN2gzdjdzYkFI?=
 =?utf-8?B?UVdMUVBBYzAzRzcrQ2ZucVdEQXZnTFRYRTA5elVjUkVuMnR3MXVWK3E4VkRO?=
 =?utf-8?B?YkYwVzUrZXNVUjVtN0JwV1k4dTJ3MXQ2TkpSNHBpMXNZNU9VS21VL1piajFO?=
 =?utf-8?B?SEZOOCtmeGFuZTM1L2w0aEFFb0xvVStJOUFDUHJ5MlJmWFM1Y0xHUHlRQnF5?=
 =?utf-8?B?dFFoei9ncjhPayt2UzMyOU0wb29VVmhDZWdPQ1JmUHZBME5yOFZJckxFajMz?=
 =?utf-8?B?L0RYeWFTa0o0VEFTWGJEZGp0NzhSYW4yRVI1SUVSUjhXYjF0V2RpNnFQTXJP?=
 =?utf-8?B?Q01aanJQVktuNkRkZURQYW5nWHh0VjRYdXMyRjdzWHFEU3ZnWWRNZmpYN250?=
 =?utf-8?B?VUdENTB6dXRmbkFjNWRpRk9MTjNXU25kaE5iMGtaSmFHUTJWVG9GeHFvWkxI?=
 =?utf-8?B?amRDN1lqUWM1ZTVZTm45cjhUakNFV3B0Z21xT2FDN01UclRWMWFXNFl0N2Vi?=
 =?utf-8?B?bldSSlFhOGxvTVN2eVpQOUFMNWhSYjNjRllUSjg1d0dvRzBLSVpoTlgvZlZv?=
 =?utf-8?B?VjV5U3RNOEpEQ2s3VzZzTDFkbGY0dGdha2VDT2JkaUd3MUtMdzFqODQwT2d3?=
 =?utf-8?B?WmhldTRrUUNweEJQRG02V01jNzBhSGdPRElqVVR0MXFUdk5GeVZUQWhnekRR?=
 =?utf-8?B?bkFCWHJSUGpnVGdtTVNLMnppMitUS3dGcXF6dlRKd2o4VnVGME1nQWh6RElw?=
 =?utf-8?B?aTY5UkRPak9ud0k3SGtRTGI5OWZHaUZzWWk2citld1BjdDhaa3VDMEZLTzRT?=
 =?utf-8?B?blhzTjlPU2hkWHNkMUdMUmYzL0Z5Qjc5NTl0ZmdEZXZ1V3MxcUZ1bkNDRjlI?=
 =?utf-8?B?TXQxbVBzYmVwcFR3dXhBbzNnYXltL2UvVEhQN3JvNnJVNkU5S1RHNXFlTzhL?=
 =?utf-8?B?ekNwQUY3VXpra2h5SFVJVUZKNmhsUTlraXY5TjNRQXpOQmU3cGZLY2MwQ0JK?=
 =?utf-8?B?UjlCUEJTb21nM2VaNzhyYklodlRFc0F3MHEwUG9GODUybVkrajdFbDh3dklh?=
 =?utf-8?B?UjVUTWlwTVlmZUZTTHhJemxiV0FyOGlsOEZFUnNzZDFHcnJiNEhLRHVYaWZ4?=
 =?utf-8?B?SnpUbjF2QXU5dnVJY08xekt4REJrQXdXN0RLbUM5Vk81Uy9scXFXakRUa0sy?=
 =?utf-8?B?L1hVV3FmUTErUy9WNUYrdGZUY3dJWVc1Q0QvSTd1TUtXZlhPUDRQQT09?=
X-Exchange-RoutingPolicyChecked: siPRm0fEY7vvQBFUY0Q58cLB/qVRaC2+o0nUIfL1PnoZ7YCXdDDp7tFzA3ukrmQVr4TRchZYuOE4rqLWMSYbE1Go7RO3Y9frNsmNYpzS4iIApd1KFHfDUHGOb03SB2ZpKDblvq0k2WfabtrEjt495YwYXxLqd0ezzJNl8XUUp4WpcErSSyy0Ohr/dceqpdXReRsgGx7H2EoeN3Kk26U9s78U4SmustQPoS1W/2Oyhoi6J9MKROoAoA2LBjb6SUQECxDTYUXVefZngoCtbGfhOiCGLbt1dN4pZuLtOxnNsWCIouTpdmFxbIY8tLJTP8KExKJslycB2hxdzmQHTf0mSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e48708-0c63-4432-5a3d-08de813f69f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 20:30:49.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jat5BkIF9TWk3Jw9HHJpa04wYNmRaYNMiARpbtzJv+Ij//G+yRRXcb2AzcgW9Fsw1TrkaPG8hAb6+JQxL2QwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-225381-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BE888289BC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-13 2:48 p.m., Matthew Brost wrote:
> On Wed, Mar 11, 2026 at 12:34:30PM -0400, Dong, Zhanjun wrote:
>>
>>
>> On 2026-03-10 6:50 p.m., Zhanjun Dong wrote:
>>> In GuC submit fini, forcefully tear down any exec queues by disabling
>>> CTs, stopping the scheduler (which cleans up lost G2H), killing all
>>> remaining queues, and resuming scheduling to allow any remaining cleanup
>>> actions to complete and signal any remaining fences.
>>>
>>> Split guc_submit_fini into device related and software only part. Using
>>> device-managed and drm-managed action guarantees the correct ordering of
>>> cleanup.
>>>
>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>> ---
>>>    drivers/gpu/drm/xe/xe_guc.c        | 26 ++++++++++++++--
>>>    drivers/gpu/drm/xe/xe_guc.h        |  1 +
>>>    drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
>>>    3 files changed, 63 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
>>> index e75653a5e797..f6964b8f8ede 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc.c
>>> @@ -1399,15 +1399,37 @@ int xe_guc_enable_communication(struct xe_guc *guc)
>>>    	return 0;
>>>    }
>>> -int xe_guc_suspend(struct xe_guc *guc)
>>> +/**
>>> + * xe_guc_softreset() - Soft reset GuC
>>> + * @guc: The GuC object
>>> + *
>>> + * Send soft reset command to GuC through mmio send.
>>> + *
>>> + * Return: 0 if success, otherwise error code
>>> + */
>>> +int xe_guc_softreset(struct xe_guc *guc)
>>>    {
>>> -	struct xe_gt *gt = guc_to_gt(guc);
>>>    	u32 action[] = {
>>>    		XE_GUC_ACTION_CLIENT_SOFT_RESET,
>>>    	};
>>>    	int ret;
>>> +	if (!xe_uc_fw_is_running(&guc->fw))
>>> +		return 0;
>>> +
>>>    	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int xe_guc_suspend(struct xe_guc *guc)
>>> +{
>>> +	struct xe_gt *gt = guc_to_gt(guc);
>>> +	int ret;
>>> +
>>> +	ret = xe_guc_softreset(guc);
>>>    	if (ret) {
>>>    		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
>>>    		return ret;
>>> diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
>>> index 66e7edc70ed9..02514914f404 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc.h
>>> +++ b/drivers/gpu/drm/xe/xe_guc.h
>>> @@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
>>>    void xe_guc_runtime_suspend(struct xe_guc *guc);
>>>    void xe_guc_runtime_resume(struct xe_guc *guc);
>>>    int xe_guc_suspend(struct xe_guc *guc);
>>> +int xe_guc_softreset(struct xe_guc *guc);
>>>    void xe_guc_notify(struct xe_guc *guc);
>>>    int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
>>>    int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> index b31e0e0af5cb..8afd424b27fb 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> @@ -47,6 +47,8 @@
>>>    #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
>>> +static int guc_submit_reset_prepare(struct xe_guc *guc);
>>> +
>>>    static struct xe_guc *
>>>    exec_queue_to_guc(struct xe_exec_queue *q)
>>>    {
>>> @@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
>>>    		 EXEC_QUEUE_STATE_BANNED));
>>>    }
>>> -static void guc_submit_fini(struct drm_device *drm, void *arg)
>>> +static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
>>>    {
>>>    	struct xe_guc *guc = arg;
>>>    	struct xe_device *xe = guc_to_xe(guc);
>>> @@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
>>>    	xa_destroy(&guc->submission_state.exec_queue_lookup);
>>>    }
>>> +static void guc_submit_fini(void *arg)
>>> +{
>>> +	struct xe_guc *guc = arg;
>>> +
>>> +	/* Forcefully kill any remaining exec queues */
>> Shall we do VF bypass here?
>>
> 
> Why? These flows work on VFs and are still required. This is initiating
> a software cut off communication with the GuC and cleaning up any lost
> communications with the GuC so all queues are destroyed.
> 
> Matt

Got it. LGTM

Reviewed-by: Zhanjun Dong <zhanjun.dong@intel.com>

> 
>> Regards,
>> Zhanjun Dong
>>> +	xe_guc_ct_stop(&guc->ct);
>>> +	guc_submit_reset_prepare(guc);
>>> +	xe_guc_softreset(guc);
>>> +	xe_guc_submit_stop(guc);
>>> +	xe_uc_fw_sanitize(&guc->fw);
>>> +	xe_guc_submit_pause_abort(guc);
>>> +}
>>> +
>>>    static void guc_submit_wedged_fini(void *arg)
>>>    {
>>>    	struct xe_guc *guc = arg;
>>> @@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
>>>    	guc->submission_state.initialized = true;
>>> -	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
>>> +	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
>>>    }
>>>    /*
>>> @@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
>>>    static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>>>    {
>>>    	struct xe_gpu_scheduler *sched = &q->guc->sched;
>>> +	bool do_destroy = false;
>>>    	/* Stop scheduling + flush any DRM scheduler operations */
>>>    	xe_sched_submission_stop(sched);
>>> @@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>>>    	/* Clean up lost G2H + reset engine state */
>>>    	if (exec_queue_registered(q)) {
>>>    		if (exec_queue_destroyed(q))
>>> -			__guc_exec_queue_destroy(guc, q);
>>> +			do_destroy = true;
>>>    	}
>>>    	if (q->guc->suspend_pending) {
>>>    		set_exec_queue_suspended(q);
>>> @@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
>>>    			xe_guc_exec_queue_trigger_cleanup(q);
>>>    		}
>>>    	}
>>> +
>>> +	if (do_destroy)
>>> +		__guc_exec_queue_destroy(guc, q);
>>>    }
>>> -int xe_guc_submit_reset_prepare(struct xe_guc *guc)
>>> +static int guc_submit_reset_prepare(struct xe_guc *guc)
>>>    {
>>>    	int ret;
>>> -	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
>>> -		return 0;
>>> -
>>> -	if (!guc->submission_state.initialized)
>>> -		return 0;
>>> -
>>>    	/*
>>>    	 * Using an atomic here rather than submission_state.lock as this
>>>    	 * function can be called while holding the CT lock (engine reset
>>> @@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
>>>    	return ret;
>>>    }
>>> +int xe_guc_submit_reset_prepare(struct xe_guc *guc)
>>> +{
>>> +	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
>>> +		return 0;
>>> +
>>> +	if (!guc->submission_state.initialized)
>>> +		return 0;
>>> +
>>> +	return guc_submit_reset_prepare(guc);
>>> +}
>>> +
>>>    void xe_guc_submit_reset_wait(struct xe_guc *guc)
>>>    {
>>>    	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
>>


