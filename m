Return-Path: <stable+bounces-232806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M25IQ4+zWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922837D6BC
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0072030C3923
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3593E0244;
	Wed,  1 Apr 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEk4ontl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973C3E024C;
	Wed,  1 Apr 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058013; cv=fail; b=jf1WxwHFZNip3BkmPTYyZIxX4k+F6KUsuLUp8ZrBJyC4fHEuyYntTrbFBynIyW3Vo7Lr9mIng6DF5nh8/q+iBvk4b1uexIPBDbcgDBtjalEYiZaah597TWDMG+wqE7xCAlKgX4Ey5Ls2Kue34XxzaclUsgBQfCYZ6NpcZEZV0GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058013; c=relaxed/simple;
	bh=lVKSgWMHcBD3zhmSPiCQWF0Y451AwL1UOEfWQkPTad4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxCnCF11HJIQnkKTaoGWEd+59+qgARuvRIygNb0jERfbClofRMGMIKCrCfslKZkrhLZ3FbrkPKR6ZCf5U/2Kq/b/vVIhhUkVeAVftfh1nWBpY0Hc229AJ0DSB5H1UauJ9dJCfyNmWDnyWsc0cGaemiIPavLbaIredy8YOVY0Q3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEk4ontl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775058012; x=1806594012;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lVKSgWMHcBD3zhmSPiCQWF0Y451AwL1UOEfWQkPTad4=;
  b=SEk4ontlXmFWRm+2wn9QXRGF/sjY8ouzZzIYDjRi+SIJ90494UKG0Akl
   YNpL847xyc1plMhWABG420GQ0sZHpOeMwQ4XngB9JhYxn9Pv395mknl7e
   409CQ/J0lkxMCPQtdqAJtC4wmn3pFRZufpZOB25dFMm/G03v+rC6xig4e
   /32YzSHGHgdCAq0vG5QcJn1SNIqkVOH2mKvaH+qhWLBYYHMCVjhN2btiQ
   mUwqrcv0aOLjoq3V4OcTFFirITXx7oX3PLyaNpaXZk8vJSyp7QJZtknXa
   zUw+TXt1C9vvriteA1nAzSW6Oj2oz/JlelJQwTrP3xyC1FN3zNwu7LekA
   A==;
X-CSE-ConnectionGUID: bYM8v+ZERxSHKDzUr99Qag==
X-CSE-MsgGUID: lWjBH0MOT46bEJRCLMK26Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75816530"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75816530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:40:12 -0700
X-CSE-ConnectionGUID: AOP3dp6TTz2oFqyBPeQHqg==
X-CSE-MsgGUID: GeD/tPSrTh6xagfYnMmG6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226699717"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:40:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:40:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 08:40:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 08:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYYLiWmetkp9yeSU6f3HGqcQAhei5ezcdHqhJPK3LECCZKNlSdynw+26nAcnHslz3h9nx+e1cIli+qP6faZkgEKT4Mup5wQleGiGg+2ZV7ADHQ9W7sZ9nIZKY3uoDWB6s9Yk31bu20bR5w+mVUjhtvsA68q3ZCkg4X40xxnF7tzSzL8VHLSXVp59t9On5ZA48h8IXZkXSex7tF2q1PJYMWRsS6SrLdwkBgvQWrjckI20FJV4/XTSw9Wg/kJc0MBXTay8D7jCJSVadVm9I8lWZXYBkyv3iHRcxsueB0gVJLz4bt0ZQvj1QIfBtV6DeqssTiEnUZnxnT+54CcUfydP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gENMpZAPVzk9f9jSlv4akL8btJBIziqHiDBB9jqxI5Y=;
 b=nOfTUg9Wi0yClEdA/zRduMHltdq8tP+O4tb+ZxM8qbefVrWPKuEytNmDVh0K00g7yXxljnIiLxW4JQi/I/3mFT6InBNKoKbFxNect7gDHL7XBGhKW99ZxRvJ3e5qiHJEZtpy6fR67fG3hVy+dtJEsh+zZUw/p8d4fgIhrduB7O8BPYpLEHBRspG3pompKBUHKsMFOQwzHRbHzbcq0tsEeyfUZM0Bbtfv1ltl0uLHXMedCOujN22gdO6Nrd4SVnl4XJvKHP3lYJ+oQkFhDBYY7FrGbBdkCBlASBVeoAsr2ZuP9KF+Qb0sx8ubR56laHvvdQ2Nbef2VFHnYqn1u4Grtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 15:40:05 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:40:05 +0000
Date: Wed, 1 Apr 2026 08:40:01 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Waiman Long <longman@redhat.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Carlos Santa <carlos.santa@intel.com>, "Ryan
 Neph" <ryanneph@google.com>, <stable@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
Message-ID: <ac08UdszEeEI2iJj@gsse-cloud1.jf.intel.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
 <8eaf9c5e-70fc-4d68-a919-df371bb38283@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eaf9c5e-70fc-4d68-a919-df371bb38283@redhat.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 27999659-bfbe-41d6-5952-08de9004f268
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tBwHAtbsmH2v8ltk/9uxsiVwyw17U8O5oyRPnAsJ+4tG1IaoBJKs1zVWzLmJBzT2qiJlZeL2GlT83lp7OdHc7dT6uln6WDOnen5CxbiuTMKBKsG917n8YahMD45VFpmWXlqLJW/8r6o16RKK6henb0XFbl9R6Xv8CW+SASqHbFPCIBan6KfDQJv+Nw0x1jWcrmIPf0WziZSxUm5poZAJonZj5gVGInixOPAUvPNXERmmcuUh9WCXbktusGQ67CboiOQzMzQmBi26qjB4utBfRqgZckuysA4qGY7faQv2kS+5lWxGmnaMCHp8QkGeEM3UmW5pCUON2jhHuQe84vKnVttE+FhTDkZ3QAYAsqO1Urq/eEcNuXNTLxMaVamxi3TLdGPaIcDvxa+5dxlcunTtctDUVzgY+JgVHEA+JHVgktU8RiId3vRBWlot7YeNF/mNa+H3TAZYGEPgyvYYc/+N2NzEf2bgYHEnExuTFb5SmHkj634ys4gBu8ZJKZKFwWmGaYW3YdEvDTMk3owK7ukOGVVo4RI0s9kfwoRXLxRt8fHn2/HTAZSRSUZNNChPAaj1C1zdYIkqxCn9renvFd/tiBeGBH6Me9xFjfUo4V+xs/UvlzBYpFlK+pakUtVTiW4LJy9VajVUuKavCXCiyyAuW0lQy3FAyfYtOJRN+/71fiEbruxng4U8qSDP1Gz8T91YVzBp1HH3fd7Q9nuMjt1ySzJo9C6SbXtTizETs+wqjBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFyT0JlajI0eEFJK21ReTBHbXhrNTRVRFk2K0M1R0oxZUp5dkM2b2NjaTdo?=
 =?utf-8?B?bktiSDNqbGlGWitFL2pvbXlzSzNCVWh5NWppL3hjemhxVGc4RTNlL0dvRHVH?=
 =?utf-8?B?K0kvWkJDbWhGNmkreEJhMVhNS3ZNeDFscjlkWEd2QXA0b3FpZFJXMkd5UzZq?=
 =?utf-8?B?VjFYalg2cXRWMjdKS1piQ0NndzhwQzBrR2JnQjR1QmU4dlZxL3lORGdGdjE4?=
 =?utf-8?B?YlRSQUlNNkdHUnNaQWZDeW51THAvS3lDdEg1RG9DTEllSW5taE9ENlBVUTF6?=
 =?utf-8?B?K3QzcVlSVEt1RXJQTDZPcUdZb0xzQ0l3NEJhVTdERmhMZTVUV3hoejFBb2RZ?=
 =?utf-8?B?a01MV0x1d25VRlpJVFlIcFRnUXNZc3J4bG1YV21SZlJ5NmU2cXlHUHlQcUZC?=
 =?utf-8?B?SnV6aUNRQmlXbGZleVJxY0o0cWk3ZiswT1lCejhXb1pkSGZwRVMxRjFzRkNE?=
 =?utf-8?B?NTVYR3dZR2FqTWI2ODlSdGVFaVZZZXBablVxZGNwb0w4UjhRdW8xaW00Ukh5?=
 =?utf-8?B?d3pYeHlUdzBIelZ2S3FaSzNLNU9PZldDZ2hEWUpZOFZBQVF2WE5YNEMvT0FP?=
 =?utf-8?B?RG1sdjRyM0tZSkRNdTJrbTdOYkV4VnN5NXNlR3YrR0pETEZoTmZFVU9sVlJF?=
 =?utf-8?B?bEhOUWczdjlUOVRudG1scWdEUUpxcUFtWnNjQk52a1pRaHIweTFaZFBZK2gv?=
 =?utf-8?B?Nm5Za2NNNDdVSVpQSWo3MGI2VGZHQk9Gbzd5c0thRXdvTUt5S1BGT3JtcVJs?=
 =?utf-8?B?eHhBSHdTZ0x0ZENFalpJKzlLMkxxeXVZQ2lXUk9kY1E2WTFjQU4yaVcrdndo?=
 =?utf-8?B?Y0dpWEk5clpIUjc4L1ZFcWJPd093RXpaRkFPeEIzUjltN1gzQTlzNzVoODNw?=
 =?utf-8?B?b21wWHpXd0kxWlBmSHJ0S2RqeGxGcC8wSmJFWndtSUN4ZFl3eStPdWYvOFE2?=
 =?utf-8?B?cVpLNXVpanh3RkRjN25aZFZNOTZ4WHAzMWdaeDhKQUFmY0pEcW4zdmk2UXZH?=
 =?utf-8?B?cHZMQ2ozajZEa2FaTHlIZnJBM1ZkZW81eWNRUG5tZDN6eGVkWVdRVXQvTG8r?=
 =?utf-8?B?UW9Ta1hqUHNpRDNrSDhpSDl0Sm1yamFrMnFMU0hjR040eGNEaDloWU5CbXEr?=
 =?utf-8?B?UkF5c3JMTHlOMU91MXZNMlVITjF4bE5iSEJndEI4eVRMQXNIZUFPMFlHSkx3?=
 =?utf-8?B?THI4aW1IakpEZVdlRVI4RXpac3BWaWhCTzdzQWlmSGt5Z29CSE1kalkrTlc4?=
 =?utf-8?B?UTVZSm14Nngxa1ZyOGlVWHUzMlcvbWNmMCs3cVM4b2JucHVGOS9jcHYvWnNK?=
 =?utf-8?B?QXZWeDZ6eFFWUE9TWDloa1FhYjErYzVmbUl6WWN6eGQrcjRBdmdnOXJML0ZO?=
 =?utf-8?B?N05vajI1Y2thWlUramY2Vzd2czZBd1Jsc0V0em95MzUxcklOR0MxR2diMGVH?=
 =?utf-8?B?V1VmMmpObE44T1JvWFNQdXdvN3R5UU11dFRjcks2QklwQ2xXeTVTaittb1RT?=
 =?utf-8?B?dDJ4elBkb0QxV2pPRDNVdlZqTWRUK2JrNnBDb2tzbExOWi9XL3FNZXdBWUUz?=
 =?utf-8?B?OFQ5RkpWUTVMdzByYVJGZHhIbXVJR2RsYkVlSkRSbzZ0d3BCa08wRUZPNjM1?=
 =?utf-8?B?Ykk3dktacHNEY3ZQKzZaSEIwaFkvMCt5ZjZmZkp2YTZ0a29sUVBQMjdzZWJK?=
 =?utf-8?B?Vnd1cDFMMEd4VUFNY2I2MnUwck8zMkxjTmtLeitBQ3pxMHUxOUtFOUJxZGdS?=
 =?utf-8?B?NlU1Qi8vNjBzQ3p2eWF1Rkd0Sko5aXJSbjlUUFpSb09jOWYxRmVFRXJBMkUw?=
 =?utf-8?B?TEJwcFJOamgzN0xaK0szTWxmOTVxOE1CRUNndDBaK2Q4V3ZnUzg4UENTL2s3?=
 =?utf-8?B?dmdCeDEwWld5OERrUkIwYkVSY0JNMEtOTVcvQkhnKzZZcHM3RjFCOXNLOGVS?=
 =?utf-8?B?VXRhdUFiYXFkN0RIKzZvMkpad2ExKzJFNGQ2WDg4cUtPbnlMc2duN1k5TzdL?=
 =?utf-8?B?ZWVtZ3R0QlZyN3F4TXNTeG9zY2ZZRStmMHdFZituV0JubTlPY2Z6VGZJT1BP?=
 =?utf-8?B?amRVeGVGQW5RWXE3Ykhpbm12M0d1SGNrbi9Iazl6azlqR3hUazZ5UGdFSFdO?=
 =?utf-8?B?Si9Ta25xYXh1Zy9xSFdVazh6SlRiOFUwaDMwMUpuU29rOUdEUjlBQjYzWDRk?=
 =?utf-8?B?Z0ZidjdXMmo1eDVQQTE5dUo1RGFYK25QL21FR3BLdERHR1h4V3o3ZzlJZDA4?=
 =?utf-8?B?YXZmeDYxTUF2RlU0Q2ZOWWJENE5jamtXeTFqeUdGSG03Rjd3b3kyK3FMc2Vp?=
 =?utf-8?B?dWM5Z0dQSXZ2bGVLbUY4Vy9INW42SitRUFJ1R2ZBWGo0UmloNi9jSnpHNTVF?=
 =?utf-8?Q?yruOkv0rQyYhk9T8=3D?=
X-Exchange-RoutingPolicyChecked: uJETK7O9xzqsAKJeBMYmjZg0hGZaBoX8U+0oXM+dnR6PaSGUCXLk/I6Gww73UtbJdU3pw1o0I60WS83CdPZZdLQq+8FqLfdWRmncTwly1A8kPsEUeASeMbXWAHEFrkV4ifnhvE2pPbjIvA+X7XE3avbb1z3WOckh1qB+icn5yD+EwUFs1GWUhtIosOwye+tR/eibYJdEhZi4ro+ViUpDTH/urUo8LeAmB39HXKWTrXTv4xu1FLtyARm2vLIP6+5bF4AIdcUUyTX1K7APXMlo57EeSM/6OW8JAt06I96nRz8mxJ/SlpHbwtB7Z1YXdCYAhlqk2XFFjImg73+BDulzzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27999659-bfbe-41d6-5952-08de9004f268
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:40:05.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaKpP1zfr/PIJTFYYGBsCaectijbaE+2cNJTbys6vEzqFH2TKXvKK245VdnWWEKZTn2cMWKjV5PpkDH4hEuMtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,google.com,kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,gsse-cloud1.jf.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-232806-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2922837D6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:44:55AM -0400, Waiman Long wrote:
> On 3/31/26 9:07 PM, Matthew Brost wrote:
> > In unplug_oldest_pwq(), the first inactive work item on the
> > pool_workqueue is activated correctly. However, if multiple inactive
> > works exist on the same pool_workqueue, subsequent works fail to
> > activate because wq_node_nr_active.pending_pwqs is empty — the list
> > insertion is skipped when the pool_workqueue is plugged.
> > 
> > Fix this by checking for additional inactive works in
> > unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
> > accordingly.
> > 
> > v2:
> >   - Use pwq_activate_first_inactive(pwq, false) rather than open coding
> >     list operations (Tejun)
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: stable@vger.kernel.org
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > This bug was first reported by Google, where the Xe driver appeared to
> > hang due to a fencing signal not completing. We traced the issue to work
> > items not being scheduled, and it can be trivially reproduced on drm-tip
> > with the following commands:
> > 
> > shell0:
> > for i in {1..100}; do echo "Run $i"; xe_exec_threads --r \
> > threads-rebind-bindexecqueue; done
> > 
> > shell1:
> > for i in {1..1000}; do echo "toggle $i"; echo f > \
> > /sys/devices/virtual/workqueue/cpumask; echo ff > \
> > /sys/devices/virtual/workqueue/cpumask; echo fff > \
> > /sys/devices/virtual/workqueue/cpumask ; echo ffff > \
> > /sys/devices/virtual/workqueue/cpumask; sleep .1; done
> > ---
> >   kernel/workqueue.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index b77119d71641..bee3f37fffde 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1849,8 +1849,17 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
> >   	raw_spin_lock_irq(&pwq->pool->lock);
> >   	if (pwq->plugged) {
> >   		pwq->plugged = false;
> > -		if (pwq_activate_first_inactive(pwq, true))
> > +		if (pwq_activate_first_inactive(pwq, true)) {
> > +			/*
> > +			 * pwq is unbound. Additional inactive work_items need
> > +			 * to reinsert the pwq into nna->pending_pwqs, which
> > +			 * was skipped while pwq->plugged was true. See
> > +			 * pwq_tryinc_nr_active() for additional details.
> > +			 */
> > +			pwq_activate_first_inactive(pwq, false);
> > +
> >   			kick_pool(pwq->pool);
> > +		}
> >   	}
> >   	raw_spin_unlock_irq(&pwq->pool->lock);
> >   }
> 
> Thanks for fixing this bug. However, calling pwq_activate_first_inactive

No problem — I think this one has been lurking around for a while, and
we’ve just papered over it in Xe for a couple of years.

> twice can be a bit hard to understand. Will modifying pwq_tryinc_nr_active()

I actually think it makes quite a bit of sense, as it matches what
__queue_work does if two items are added back-to-back on an ordered
workqueue — the first one updates the nr_active counts and activates,
and the second one updates the pending_pwqs.

> like the following works?
>

My initial thought was that your snippet should work — in fact, it does
for a while (drm-tip hangs almost immediately), but eventually I do get
a hang when running my reproducer, whereas with this patch I don’t. I
can’t reason exactly why — maybe it’s because
node_activate_pending_pwq() can find a plugged pwq, but that’s just a
guess.

Matt
 
> Thanks,
> Longman
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b77119d71641..b35e6e62e474 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1738,9 +1738,6 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>                 goto out;
>         }
> -       if (unlikely(pwq->plugged))
> -               return false;
> -
>         /*
>          * Unbound workqueue uses per-node shared nr_active $nna. If @pwq is
>          * already waiting on $nna, pwq_dec_nr_active() will maintain the
> @@ -1749,13 +1746,19 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>          * We need to ignore the pending test after max_active has increased as
>          * pwq_dec_nr_active() can only maintain the concurrency level but not
>          * increase it. This is indicated by @fill.
> +        *
> +        * If @pwq is plugged, we need to make sure that it is linked to a
> +        * pending_pwqs of a $nna.
> +        *
>          */
> -       if (!list_empty(&pwq->pending_node) && likely(!fill))
> +       if (!list_empty(&pwq->pending_node) && likely(!fill || pwq->plugged))
>                 goto out;
> -       obtained = tryinc_node_nr_active(nna);
> -       if (obtained)
> -               goto out;
> +       if (likely(!pwq->plugged)) {
> +               obtained = tryinc_node_nr_active(nna);
> +               if (obtained)
> +                       goto out;
> +       }
>         /*
>          * Lockless acquisition failed. Lock, add ourself to $nna->pending_pwqs
> @@ -1773,7 +1776,8 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>         smp_mb();
> -       obtained = tryinc_node_nr_active(nna);
> +       if (likely(!pwq->plugged))
> +               obtained = tryinc_node_nr_active(nna);
>         /*
>          * If @fill, @pwq might have already been pending. Being spuriously
> 

