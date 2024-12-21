Return-Path: <stable+bounces-105521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1F9F9D6B
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 01:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E100D16A63A
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B951C32;
	Sat, 21 Dec 2024 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZ8v4PUH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD7195
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734741162; cv=fail; b=lyPC628f4aQNz4+ynQpVv5IKAEFCCbotV0O29YvkoiV69X/FnE6O9IdGHxP1FgI9lBWwIWSSZRDXK+QUdqGd+kcHYUjXus7mRUr3D/SGgLuwi8pL+nhlQJZkxz6EYLbDFyZ7Z6kno+ktZgS5I7eLX5zCqwPlTAiUpsksb+KUz0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734741162; c=relaxed/simple;
	bh=mYWoxoZFDg0Bc8Ml7rw5ZhkPic+Br7Sff2k6DBk9rLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVghc4Vqqz3Eghf/VxFLDpa1Ii3pizI9qx0RkBMAJUcqYJg+BmS6gv1U4i4+Ri4Lf0Xib4FLSWNhzKj/3dqCtRgAolBRNDOTFTLMzh+P11T10btpKLSWOBI6M1/2A4h4f+BznyLsl79XRfUrjQmWaz1U5qwQtn3CS8ZWcv7vsUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZ8v4PUH; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734741161; x=1766277161;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mYWoxoZFDg0Bc8Ml7rw5ZhkPic+Br7Sff2k6DBk9rLA=;
  b=RZ8v4PUH6UB/fbabNJE+Ez431uCdX2TejMztdrlYhj0/vyQSzFrcBm93
   fB9ildauZlZzhsrVF+r3GNXW8YDdq5potJWgHWY1jS2NhwsLfknaxvHeG
   CljGQXC3pooXOd0xxkfbfyunZ/ED+1xVU/FSrcZ41G89H2my6AfSSS/uu
   Kcx7hMr0qLB+UrD6GUr/CxIiNgjj4wZo+f6lq3p0KAFOrQgk3a9dI3RCO
   498NASixAIQFtU8AgEhvLGzlL9Cxo5kKTNeQd2eNUKWdz4GjzMvjkawyX
   Curv7YZDWufXMyEYbQgINNaOlthzNkWvsaaBOvanBAGfSMH2tXx7LN+Ft
   A==;
X-CSE-ConnectionGUID: 9co103QqT/eXU8wJmhhR7w==
X-CSE-MsgGUID: 8uAzsb5BT82jYniEOvPqrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45902743"
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="45902743"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 16:32:40 -0800
X-CSE-ConnectionGUID: iLD/jd0ZSSKDLoN0RIHwqg==
X-CSE-MsgGUID: sXzdhS83Rt2g+SzsMyqN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="98415133"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 16:32:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 16:32:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 16:32:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 16:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1XbBs0PDJAuXH9ZQj/7wYGSyqMX1JCRzPWj737kB3GUvq7k3A8ZGye8ztHuXfoqYTz+B82Qoy89+bDuoeRh//tVevaxzxXi7WWVqEwC5sFniXOxsJ2TciIpz4nNdt1Y/TTlsYdJFeiCO4lyDhGia5chTEV/bunz+kQ/2TbyNlnfyKCvQ+sqI+mwR8z9bsXEiMRJk3dC5ymjpJ88OIoufoviohsvKut3vk5BDQ7rcnsaQ1TtfuTxGvgRMQNMAYhH03A5AuGVBRV36OzrSrgKz6ymGWKCWozwC7m2N++CbJQWtpazMQEHvmvKkzLfM2WQJ3DM+7MWgYF5WrutDC1bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnSx3PevUG64wmV4KFmPYcaIOAl0hoZ/TYvqsNq3mrE=;
 b=BvOKD5/pZ9r/YmtmNXdomp9gBkrboR/aXofRUCPwJs+gTUw4stF5y4A/E1R/0BnUE/AesiMLhIGs9uL6AOSAkh5CMaA2w7lgAMZ6lgExmUa7amTUmeKkdKVUJvCaIxBsT7LTtbpG2uf9mgeJZfTJbU3d7rlsXxPRO8iZ1fvHblMbzX2t8JAh2YtiGwnQDYdpLit6fOi+gDmmeM0XHq6ZD6EQRpg98UndFlqg9HPxIDuLaE+VL8HzBO09gfX4vkjz0R8kqS3ssL37SyJKrmRsEdZJb9JRnFfyqdSiPpT1Pltl3XRvb1Wpycl+PHssfB8h5qh2iHMBAfbxhcqeJAoMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Sat, 21 Dec
 2024 00:32:19 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%3]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 00:32:19 +0000
Date: Fri, 20 Dec 2024 16:32:09 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z2YMiTq5P81dmjVH@orsosgc001>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
 <Z2SGzHYsJ+CRoF9p@orsosgc001>
 <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <wdcrw3du2ssykmsrda3mvwjhreengeovwasikmixdiowqsfnwj@lsputsgtmha4>
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|PH7PR11MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 452347e4-1457-4fac-e44b-08dd2156ed99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1dVRkxzS1Z5NmYyMTVaN2pDVm9wYUQyaEtqek80aHJLS2ppOGw1OVNUMWg4?=
 =?utf-8?B?VVU1TG9GWU5YRlVRUDFCVWZ1Q0Z3aGhkWTQ2Q2RIM1NYS3FiZlBaVndEUnor?=
 =?utf-8?B?YXQ0bUdwNURiMm5lZDhqUHZCR1RRb1BFRnJXVmlQQ1BlQzdJbDVnOU5tTkM0?=
 =?utf-8?B?Nm9NbDlIYllwcEdTQnBNNXJYdkkyanBLRUxyYzkzMlVJV2ljZ3gyd1hRUXRQ?=
 =?utf-8?B?T21BSEVsTjhTbG1tV3FtSzRaT1ljcFJ4YzZYSHFrQkxiYituZTY4MG1xOFRP?=
 =?utf-8?B?Mjk5ZjhRcmU0Q041Q0tnbWVCb1RIakM1ZnBObXdtRXZRS0RsMnd0M3BFV2Zo?=
 =?utf-8?B?LzlRdFl4ZWNTN0VJQURMM3BTNDR3RDNqcFdQc1JFa3I1cjUyR3JsWE5pcnpH?=
 =?utf-8?B?R3dORHJ4dzZYTnBmRzdsSnRuV3F5MVRkSUdyQmlrUG8zZGxTZ08wVHFocFVI?=
 =?utf-8?B?YmVKVDV0dEZ6TXhIV05laDh2SUF0NnBldmU5emZaV3pvYlNxbDdnWDN4eDFX?=
 =?utf-8?B?QzZFOFU2MXVIdmZtTmNtUm1NUkdqQ1NkOXZ1dFJmOW40T0FkQVlCWkRXZ1lo?=
 =?utf-8?B?bDRoNWlNMkNuK2JNK1gzWFFOMHNWem1IczVEQVk4UUhmODMra3lSanRvWnZl?=
 =?utf-8?B?UnZMbVptRlZwdW9lcU9uSDlka0xIQUtvdEc0WUU5V2pUM2FlTUFEWW5ycHlj?=
 =?utf-8?B?UjRlakVlL1RwVnpqeDllNjJHZGdIeWwzR3dDcjVmRU9OenZHZXh1eTRMZVgz?=
 =?utf-8?B?MFpBaVNHTUtGbWdjVmUxQ0JqeUR2Q2szKzdDU2pTallKTDVabW5wU0IvaDkz?=
 =?utf-8?B?QXFWV045S0lzeXExaWVpcXdMY0ErbmwvSW5acHlBSjN6YlAyUFhaMUZLZEJm?=
 =?utf-8?B?K25nRWdTWkR4WUgrWDlJaks2U3ZWN0hNMVFxQ3h0N2JneTJuaXdnVkt1NHFQ?=
 =?utf-8?B?VW45R2VheWx6eGR4bWZLVzdqempRTkc5OEtnKzlxeVNsNk1nYzJYSlpVQVVN?=
 =?utf-8?B?cVV1em5HZTR0UlQ5cE9iUkJPbWlySzh5UmZsaFRrSkR3QmVkUS94TEl5UVdI?=
 =?utf-8?B?cUFwLzc4dUtuZ0NvTTljZ0xVOTlIY1VERVl5cEF4SzREbXRmV2RpOW1MVHlO?=
 =?utf-8?B?QmtCR2NCT1dvTFIvalNIVjhCcGdYZ2I4ZW5nZnZVY2dzVUpqR25uR3JuVEdz?=
 =?utf-8?B?VkNSUFhCYW1KUlFRRm4rM3BFNWtRcWsvekpyOGtUT05WYjVKdEJXb080Sll1?=
 =?utf-8?B?cExyYzZlM1RET1E4NGw2MlZnY2RoQWlCZ0ZMSHVCTTJhQkFlbDJUc29TVzho?=
 =?utf-8?B?VUxTejBnTEtYY1dpY0syeEJVenBhdWRiTFlYRExwL1VQM2VqU0lBT1lGQWcx?=
 =?utf-8?B?eWU1bHNDOTZ1aGxrTm1IeDFsZGFoZU4xWkxFNlQzK0RwZ2Z0OEZ6YWVvcGtV?=
 =?utf-8?B?ckpCMHd4Tjl0ZGpaVkhra3l2ZkJUVG9EK1VreGhKQ3ZoZjdmdE1WNEJkZzRa?=
 =?utf-8?B?OFp1Ym9mdHJnWE5WbjJOMVhUa0xNTVhtQVJXWjdRWStWTmcxbEk2M0x6YzdQ?=
 =?utf-8?B?cURxZTlVeU15MU96S0loKzBRN3JoWkRKNEtXQ1dlOVpkZFlPYVE1LzlNZkgy?=
 =?utf-8?B?Zy9mYTlYTTgxYzBoM1FiU3FjV0V4dWxVOUMvVk1TeHBkN1RuUjNqeVZxWURi?=
 =?utf-8?B?YjdPRkNLdEdURjF2U2hlMEE0NU1mVUIrNUx4VU1kd2RqL0N2ODdVUXZsZDJj?=
 =?utf-8?B?enVqSjhzZDJFWk85cVhHVjJmdG5oc25sbS9CQWJacjRYVlM1UnNMRnB3VlBs?=
 =?utf-8?B?SDdZaE1rRXRZdnNGWkVSdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3pEOE1acjZITCtma2hXR3F0QXk5dTZKOHZNWVVQWTdyOHNUYVlpOExVYmNH?=
 =?utf-8?B?SXh5NVJyWkVCSGRHQXRwUmNKN2NXV1NySW5UWjgyanVyMzBPZUY2Q1M1YkFs?=
 =?utf-8?B?WVBMZFN1d203NkxMVFlFODFGanVDYXRjaitBSnhmNmFxRUgzQ21jWDhyNkpv?=
 =?utf-8?B?VzZ0amRSVk5KTkw3SjNXWEtQdlNDbnpzamxEM0lsbU51WnJmczF1MmxzU05Q?=
 =?utf-8?B?am9SRE1LdWgvajkzOUhVYUFqUURGVi9STGtiTVRZVUNXRVhvTnh4OVRYb1dk?=
 =?utf-8?B?aHlmYU0rR0lxVGY3QVA3VEk0dVg4UktVVDU1eG0wWDhrUlA5YzVIbFVidFZZ?=
 =?utf-8?B?aXJ2N0gyZ0VTRHQrY2U1M1g5TE02UE9veTZ5VFNLb2M0UnRIVGZGZm84NS8y?=
 =?utf-8?B?a3h1SE02cndvS2hOSzVUTnUwREV2ckxZaEl1ME9xRlBRbWpWbG5iMW16UzFY?=
 =?utf-8?B?UmhhUkpJK0t3ZEVRZzU4OU9vdjFmaDdQclZLUCtYekRQaUxNMnlvYWZ5ZFhQ?=
 =?utf-8?B?enRsbUhhTnpuUFkrdzI5Qjl5K1hrT21UT2pkZzJTbHJJaGh6Tit1MXYyT2pN?=
 =?utf-8?B?dmk3K280VWpDMTQrZXg1SjloMVZYbTFyMHBJQUNSQUFsRHAreFNrY0tuOHdh?=
 =?utf-8?B?QXpvczBncS9zVkFod1lHaFlGNkdYN0FUNnZ5NlVDNTBTYUgxT2xRWUdiWFZR?=
 =?utf-8?B?QzljdytNMzRrdVl5QTR0UlVocWFJdDhhckM5dnpkQVpaT0tvdi9Pbm5xREFi?=
 =?utf-8?B?MzZSa1ZYazg2YXFabVZabGpVTmVYMmpWMFZkQXpkYnFFN0FJTTd5TFVjYklV?=
 =?utf-8?B?M0c1YkNkRWFOdUVzeHlvblNrVllEY2dLVHlvdGZIRTNVVjBERE5wTjVQVzly?=
 =?utf-8?B?MWJaMi9JdlRKYUl1RFVKQVF6WThobDRlaU9xQ3BVdDN6S2tkeU9ETnNaeHps?=
 =?utf-8?B?ZTNDZ25aSVA4TEo3c2huVmtlRk5CZGxROHA3UFBaSEJOYm1oa2xLaEx0THEw?=
 =?utf-8?B?Z2RERDNObmZNaE05eVFyVGtZYWgrdnV5d0lVcHFIUXNUVWxNMzNLK2FHa25y?=
 =?utf-8?B?K1RSNjR3cWRpaE9VdWlCOXJMbi80ZDVJMlQzN0V6dXovbmwzWG1LVTJkN1pC?=
 =?utf-8?B?aVBrZTEyVWppK0hENHpYWVdKOWFWSUdNNUlHK0xIK3diR1A2cUlta2tma1NC?=
 =?utf-8?B?QWh6ckZvaXZaTy9KNXQxcjg1c29pdWJqbnJNem16blBOZHRvNDlydGl5Tng4?=
 =?utf-8?B?bFNkMVIzNWU3ZzRHdlVqU3VBcTVQanM4R3JwRTNRV3pnRGo1SlFveDl4U2Zw?=
 =?utf-8?B?V2RIQWN4SlpSaVNITWdYVU1STVBwU2FBMDVCTlo3aW1MNmZhNnJwNzJwbUxM?=
 =?utf-8?B?TnlQZGVQU3VqbnRCMFVIWEVSRThuMjhKbjZLL2JmYjBUVytaVEllVEplOEJm?=
 =?utf-8?B?cGVjZTFCMzZOMEFCaVhqMERDWkJwL00zOFlVaERlMXBDeEhROEtkZU9TZ2I0?=
 =?utf-8?B?TS9Tc0RFa00zci9QK3dVdllXcUMxT241bWUveUlHM0x0VVFsaktTU1pRZ1hR?=
 =?utf-8?B?dzRSenBhaVpyenkyUXh4Ri9hUTVsNXR5TktTM25MTWtid1NPaGFyc2VLd0ky?=
 =?utf-8?B?dXVNdGpkbWM4ZUNuMlhJb1ZzRUswQkVKOFY5NCtUZXBZVjRrdnFjb25ZbFB6?=
 =?utf-8?B?VW1lUU11bkF3ZUt1cEp1cm5jdFcrSFNTaENlczIra29peTYvRHE1c1RudFJU?=
 =?utf-8?B?NGg1Y0Evb25uVnJNd1pXQlBLOTA0YmlGT2dLeGp1OTdZYU5CSEJHVzUxYk9Y?=
 =?utf-8?B?UUF5WGV4VDUwR0ZuNHVIOFo5K05Fc1IvUGpNOGlmTDA1eURzbHhzY25rUC93?=
 =?utf-8?B?bG1xRXEvczhIRlNISVBuZXhoTGJmTUNiWmc4dkdCRndjSlVNcTlaczQxak9H?=
 =?utf-8?B?by95WmFjTit0WTNRNFFtT3gzc1JINDdFUTFtU1c2M2hsazZhdm1wQSsvMWdh?=
 =?utf-8?B?WC9IOTNVcnk3K21wVnhoMmNWQlFJVytzWm9UVFJxa3N0cnNrbk5FbzZzN0F5?=
 =?utf-8?B?TlhpbWpYV2dldXpvQU5URUpZb1RwNXFYbDJybERnV2J6VnpES3h0anY4UTNZ?=
 =?utf-8?B?ekJ4endzZWFEa0hvQWYydkVQS2Y4QWhCVS9vZ2FyWGV4RFRtMWtPTEpoVGpF?=
 =?utf-8?Q?e3EtDfAfWNAWPp1FesDps18=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 452347e4-1457-4fac-e44b-08dd2156ed99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2024 00:32:19.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHwnE+O+8KcdGyzqymMUI9GLYAZuUKAUidrSOqcryZdr66h4qmx9XogbuVnIm0yUB8aaBDSgT4L57TveOOBIgR9iaXIYmL/cA37upX/h1x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-OriginatorOrg: intel.com

On Fri, Dec 20, 2024 at 12:32:16PM -0600, Lucas De Marchi wrote:
>On Thu, Dec 19, 2024 at 12:49:16PM -0800, Umesh Nerlige Ramappa wrote:
>>On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>>>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>>>queue file lock usage."). While it's desired to have the mutex to
>>>protect only the reference to the exec queue, getting and dropping each
>>>mutex and then later getting the GPU timestamp, doesn't produce a
>>>correct result: it introduces multiple opportunities for the task to be
>>>scheduled out and thus wrecking havoc the deltas reported to userspace.
>>>
>>>Also, to better correlate the timestamp from the exec queues with the
>>>GPU, disable preemption so they can be updated without allowing the task
>>>to be scheduled out. We leave interrupts enabled as that shouldn't be
>>>enough disturbance for the deltas to matter to userspace.
>>
>>Like I said in the past, this is not trivial to solve and I would 
>>hate to add anything in the KMD to do so.
>
>I think the best we can do in the kernel side is to try to guarantee the
>correlated counters are sampled together... And that is already very
>good per my tests. Also, it'd not only be good from a testing
>perspective, but for any userspace trying to make sense of the 2
>counters.
>
>Note that this is not much different from how e.g. perf samples group
>events:
>
>	The unit of scheduling in perf is not an individual event, but rather an
>	event group, which may contain one or more events (potentially on
>	different PMUs). The notion of an event group is useful for ensuring
>	that a set of mathematically related events are all simultaneously
>	measured for the same period of time. For example, the number of L1
>	cache misses should not be larger than the number of L2 cache accesses.
>	Otherwise, it may happen that the events get multiplexed and their
>	measurements would no longer be comparable, making the analysis more
>	difficult.
>
>See __perf_event_read() that will call pmu->read() on all sibling events
>while disabling preemption:
>
>	perf_event_read()
>	{
>		...
>		preempt_disable();
>		event_cpu = __perf_event_read_cpu(event, event_cpu);
>		...
>		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
>		preempt_enable();
>		...
>	}
>
>so... at least there's prior art for that... for the same reason that
>userspace should see the values sampled together.

Well, I have used the preempt_disable/enable when fixing some selftest 
(i915), but was not happy that there were still some rare failures. If 
reducing error rates is the intention, then it's fine. In my mind, the 
issue still exists and once in a while we would end up assessing such a 
failure. Maybe, in addition, fixing up the IGTs like you suggest below 
is a worthwhile option.

>
>>
>>For IGT, why not just take 4 samples for the measurement (separate 
>>out the 2 counters)
>>
>>1. get gt timestamp in the first sample
>>2. get run ticks in the second sample
>>3. get run ticks in the third sample
>>4. get gt timestamp in the fourth sample
>>
>>Rely on 1 and 4 for gt timestamp delta and on 2 and 3 for run ticks 
>>delta.
>
>this won't fix it for the general case: you get rid of the > 100% case,
>you make the < 100% much worse.

yeah, that's quite possible.

>
>For a testing perspective I think the non-flaky solution is to stop
>calculating percentages and rather check that the execution timestamp
>recorded by the GPU very closely matches (minus gpu scheduling delays)
>the one we got via fdinfo once the fence signals and we wait for the job
>completion.

Agree, we should change how we validate the counters in IGT.

Thanks,
Umesh
>
>Lucas De Marchi
>
>>
>>A user can always sample them together, but rather than focus on few 
>>values, they should just normalize the utilization over a longer 
>>period of time to get smoother stats.
>>
>>Thanks,
>>Umesh
>>
>>>
>>>Test scenario:
>>>
>>>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>>>	* Platform: LNL, where CI occasionally reports failures
>>>	* `stress -c $(nproc)` running in parallel to disturb the
>>>	  system
>>>
>>>This brings a first failure from "after ~150 executions" to "never
>>>occurs after 1000 attempts".
>>>
>>>Cc: stable@vger.kernel.org # v6.11+
>>>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>---
>>>drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
>>>1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>>>index 298a587da7f17..e307b4d6bab5a 100644
>>>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>>>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>>>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>>>
>>>	/* Accumulate all the exec queues from this client */
>>>	mutex_lock(&xef->exec_queue.lock);
>>>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>>>-		xe_exec_queue_get(q);
>>>-		mutex_unlock(&xef->exec_queue.lock);
>>>+	preempt_disable();
>>>
>>>+	xa_for_each(&xef->exec_queue.xa, i, q)
>>>		xe_exec_queue_update_run_ticks(q);
>>>
>>>-		mutex_lock(&xef->exec_queue.lock);
>>>-		xe_exec_queue_put(q);
>>>-	}
>>>+	preempt_enable();
>>>	mutex_unlock(&xef->exec_queue.lock);
>>>
>>>	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>>>-- 
>>>2.47.0
>>>

