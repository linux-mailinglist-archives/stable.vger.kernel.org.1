Return-Path: <stable+bounces-145789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D77ABEF2F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342D5178CE4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82911238C10;
	Wed, 21 May 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVh7HV6X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16861235052
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818469; cv=fail; b=JoODDt/DwEdgIEA7ChLOa/CTF0iiBZmCg7gRETOOo82kqdR6Frq1q2iy8gCrmGn6QNZ/soEs1M7Pwo2Pv/X3He4ISLBuJ0EHRs/YgTqYAR9PAdCRWmlwFiSfNd+aE+uCh5CdatGaF79cbDKCLMev54aOWgzfOuaU09R2DM9Y+5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818469; c=relaxed/simple;
	bh=Igo/kahcq9MpqzyQ2MYWaYQ/3pnZbttgqpJ47azkxZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOHjw3iyGQkvEW6McwrE10H6XyHj3HkzISR8ToMhaF4CZLNmAKgYMUIm+3tgt49F6OzGAtjLXqP9P3CR9ERX/BBr6b8Ycy8D7WayTN8/vCMGTG8ALcDM8kJYJAtYyxnyd1q3r9NHFxI9FC8sCmHqRmZXzYDgpOAVQyif/bOF7jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVh7HV6X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747818467; x=1779354467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Igo/kahcq9MpqzyQ2MYWaYQ/3pnZbttgqpJ47azkxZE=;
  b=jVh7HV6XbpzV2/5FvDLMbOgLN80NKRbbqdC4vfDzyZa4rI4W9tYFZxxP
   UPc+uXrJumtV2JqoMzZH1ewJ+g2+sLos89+kXgLdgy8QpCoJ4O9BklAyC
   vlFy0VjzVZKbY90QDFgsfpUxu2rOR2sQSeWX/bSID6JYkPDs37TGZXfku
   IK2xnp2GuUC6KhGVPpEnDIDfUKiOGYTJdTwXN0YRwUmBFVS+c9hX5jfhY
   auFpqBQdR+985n5vUiJ/Aw+3GVkTPi5pS/lMH0T0F9ZHmlItnxyXEYw4j
   PggpZuTkh0jsydQcL5BdMauNWj7n78JsS3k4TEfF3i/cR/mt6TNcZLUnb
   g==;
X-CSE-ConnectionGUID: bjyDQLA6RSWMNLHGTg8EZw==
X-CSE-MsgGUID: RosC1LDISuSmmlzlPwUi9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="53594666"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="53594666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:07:47 -0700
X-CSE-ConnectionGUID: VSQ2sQbLSO+Wvzgz5aIpqQ==
X-CSE-MsgGUID: a61G1kchQcSxU5Ffyduscg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140043177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:07:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 02:07:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 02:07:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 02:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj1bagyKYgi3M0x2qf/ygXYrSU5V9iIMZ+2WSwXL+PcnUBAQE19yK6jtXvM+07tdyydbmcXELAromqAJMwCDlzhruUsvppVLXZFMWazPVMT7VUH1/YU6w7LATM0Y9Pq+kUuNpmm5VkYuUikcekSbnfCfd1RDo50kzViTWMWlAK7xIWXQn74+MOPZvKI0aO+IoIuFl0EhM8NsEosSs4tQB1IG9IwCbx1iW1licv1TcXLOPk18Uej54iVybHYzE/bmuLd0bP2wT8C/sO9CRwFnrQMucYU/uEru6aPwmQmH8cLm0E2GA9qwlESFGaT/kzEPDVfXMAQul155HFbw4voUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB3TEsjk26B5CoHIogXX/I5hJRieRxnx4fYMXMExBFQ=;
 b=ltXnECnsW9wy+J3xNeg3Nbvyh5mJrW9hDtsy3y8LJLrp7V4UApsek/hW5fNoBS7w0U1425VHoz5Kjo1vvmJ4pHmTwI9DWdJ+0kpzj+wyZCkSIq6C/hrtvLJzYT0eTFJqWMbcdyPjT7ItVi3kGeLMar6IZKQJXHxieAothmqFLBgoYG+kXQwnjEZb5Th68c/7GeRjvwD6sCkUaGPhtdJAH87NZKXs/qK+bn9j1tZZ5iuRfKCekRrR56zx4TW3iuPU84+bFir/M+GiKOhqArOOssGMBKL/zpFunJn7EQjPmYjstcB+G4OLK9XsctOdcDb1VuvycUNM+3G8WRvAE0u9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:07:12 +0000
Received: from MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::c4d8:5a0b:cf67:99c5]) by MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::c4d8:5a0b:cf67:99c5%7]) with mapi id 15.20.8699.022; Wed, 21 May 2025
 09:07:12 +0000
Message-ID: <8ec107f7-c6c1-422d-8514-741a78c25882@intel.com>
Date: Wed, 21 May 2025 14:37:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/svm: Fix regression disallowing 64K SVM migration
To: Maarten Lankhorst <dev@lankhorst.se>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20250521090102.2965100-1-dev@lankhorst.se>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20250521090102.2965100-1-dev@lankhorst.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To MW4PR11MB7056.namprd11.prod.outlook.com
 (2603:10b6:303:21a::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7056:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c43a6f5-d9c8-42ec-fbeb-08dd9846dfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjlpdmhKRzNIajI2Ny9VdWc2S2IyTzRUZE5BeWZCN2ttMmlVTEsrYmNLZ0VD?=
 =?utf-8?B?dWVVZVhYVk5SaWVPVXhWOU9QdWJHR1J4VXd4Ny9WT2hCa0ZwaGpDdFFFQXlY?=
 =?utf-8?B?RDltZDNxNmF3SlUwaTdGL2c3UjQ2Kzh2Z3hEbVZ3Q3NIVmFDa2VuQTJmY213?=
 =?utf-8?B?YVErd3k2d3VZemQ0MUx3VG13c3FhZEU3U2JlOTZqd0ZuaFAyR1hPZGd2ZHcr?=
 =?utf-8?B?RHVWRHhPOEg1dFRPK013VXpPaDR4SEJBNWJxVUpTbUZ5YUVSTGg2TlE3Q3dH?=
 =?utf-8?B?S2cvL09LREhzd0s4QVY5TEhFb0xnalBNUWpuL0w2OGFNNXFYTSt6UTFEYTJL?=
 =?utf-8?B?MDNJSEp0Y0xWMmFzOUtUZThaa2l4OFg5T3luSXJobnY0MlV4VFpXbSs5OUJD?=
 =?utf-8?B?Vjl6U0FWc3JQV0tJRXpUV25zblAvcDBjbVc5ZVpQZDhOOWVBU1RIS2ZCcmty?=
 =?utf-8?B?b3oxMk9GbG9PSXQ1WGJTWmNocjZXcjE4VWZrenNUZzNOVkVFZHlISE9oVm9O?=
 =?utf-8?B?UVdDZVp4TVNRNzVPQkI5WERwNDY5QzFoWGJZT05BSThLdlJaditIZTFQMk50?=
 =?utf-8?B?UkZHcXVQcTFkM2N3SGJPRGdQL2JIQXhPZGFFRVNZQXlVUFNqWEU4a2Y3T01t?=
 =?utf-8?B?SmtzUzlRVEFpbUNlK3pPSGNoVFNtNmpMdnZaSUZYUU1rNXZmNU5JdG02VUFi?=
 =?utf-8?B?VWpuTEJad1Uzb2o5Q2dxOGxrSzJ1d2ozOHpJQ3JIeW9KKzVhVit1ano0UEpQ?=
 =?utf-8?B?OXowQWttSlJVY2pzTkFKdEFKajltakNOT3F3K25EU1Q4clRXaTRyaWFVN1Ey?=
 =?utf-8?B?aC9raCsvMEtYZ1FGOHVCcjNBMGlFRUFaQzNWcXh6NTRmNkZvajFaTnZhd0U0?=
 =?utf-8?B?clhkbWlyN2EyanlwQW5VL0I1TVUwS3A4UVZtUHlZMFZCenhrYmVzUm1xekVj?=
 =?utf-8?B?REU4dHBmd3lwS1QxdFJLMlJZN2h6M3NGQ0ZCNm02VlU5NThERStPUHBXSGF3?=
 =?utf-8?B?S1MzdTA4Q1NvaVZ4M1lNb1Q0UW5peFR6KzhMWEFzNG95WXRnWjc4RVhGaHU0?=
 =?utf-8?B?RlczL05pOWgxVWlBTExCMG9CMnVrcjdoTW1vMzZzYy9CQ1pHZlJrZlRkTzJI?=
 =?utf-8?B?RHhGd2F5WGZVWGIvQzJ5RncyUmMxN2w2cS9kV0IvZFlua0tPWlJRTGo0RUZ3?=
 =?utf-8?B?bjdhN0MxZ0RDeG1nYWVra0pRVjNyOW5vOFdMZ0RGQks0NmdaM3lYeE9Za1Q0?=
 =?utf-8?B?eUQ2NHQzcXdtOVgreHNjbHVuc0QrdnVXY2ZYbzNreFZYcEErcUg1b1F5cWpP?=
 =?utf-8?B?WUFqc2ZXcHQ3ekJURlVwSXBmUVRZbzVpcjd6TFp1REVnLzEwTXlTem0xcTdB?=
 =?utf-8?B?RUQ5bUVWMFBGL25odE1Oc24zak1qdkpKTjY3YitYK214TDM4QlMwNFNmWlVk?=
 =?utf-8?B?eG5ieWZINmhpaEp3dUZOL2RmT0lteks3V0NyUWNka2RIcEQxNUk4RytINS9E?=
 =?utf-8?B?d1JPdS9vZEo4RTJNanhJc1k0NjRsaDhwTHJ3ZUlXcW5ISmM0UkEvUlVUODBY?=
 =?utf-8?B?WS9MK3k3WlA3eUR5djhmVWN5dVgzNit2T0FKbGtVZXdRZ2pkT1VrL3FNYVZs?=
 =?utf-8?B?SXJPV0hMRXVFS3J2VllHaVRFdG5od1lRaUM0RHhWS05XVytQNjhibFBpQXdO?=
 =?utf-8?B?OWZxSGpERHBPTCthMzdwUkdwRlpnbjUxcVlzVldHOS8xWkxyTkExYWF4QURD?=
 =?utf-8?B?V1duT2hHNHdJUmFSZ2VJZ1BzVFgzVXN0bm9iMWQ4Y3ZRQWhCZ0lVQ3VUNUFk?=
 =?utf-8?Q?B9bpi9gATaZbFDRd5+EvMBsvwuKGyneNkiIGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZES3lQYjhybHdUSlpLRFRpYlpxOG41eUNuMTYvOWErOXA3dmc1Nmg1OURt?=
 =?utf-8?B?Ynd1R0NRejhRRC8vdy9tdUVNM2UxTWdDRDgyZVBXc3pUREc1b3Mrbld2ZlVG?=
 =?utf-8?B?ZWRkdDltRFZQRXJwaG13TytZNjg1b3Naa0JudGwyaFdrcERPQlpueUJpWXk5?=
 =?utf-8?B?cFhvaWUyQzRFcURweXJwT1VRalRsbmpqRngvUTI2dWw1cUxUYys0L0RSWkdO?=
 =?utf-8?B?Um10TVFPeVJlZ2o3cFZpU0RoRFNBWDZoN3hCQlQ2UjlxcCtNN3lOY2pML28z?=
 =?utf-8?B?dytNT1pua2hBUWpJMlI5MmVlUk14bUp0c0tmRExzaVpTRmcwREFEdnRIUDJ5?=
 =?utf-8?B?SVdhbFhNdUYxM1RnNGhacXBvS1lpY3VIdW4zTndkYlQ1Z2t5czZnRml6VDR1?=
 =?utf-8?B?MDdCR0l5VUNCbVNxcWRLZ05xVUE2Y1FwQnRmUS84OU5hdnBwckNzb0pxK0tQ?=
 =?utf-8?B?ZGRQd2Q1dUoxU0wwRlBaeXQzaVNsN1BCWFJzdGd5SlZOUDNZVUZWTW4rTVBM?=
 =?utf-8?B?WVVZZmY1Yis1eFlTT3BwN3BldDFLeHpwVW9kMm5xZExhdVFGbTgvQjR0SWxD?=
 =?utf-8?B?VUpkMlRGOTg2ekY4dTc0Vi8vRDliZWY2cXlFQThLRi9FdVE5V0gyVjNmZVJw?=
 =?utf-8?B?cW5KY1AxUWJEclF6WC9FQThvNTZzblhlSkpFVktzdG5RZTBqYlduRGNmbFBT?=
 =?utf-8?B?V3kyOWRVQ25lRFF6eUFZWnN3SXJaSUh5a1BiZmJ1Z1dLZnQ2aDlBVXZON3lU?=
 =?utf-8?B?Z1BCbG1nUzJWRVpDNGhvcXIxMU5QUDJrMmUxVFIzbXRLaEhFTU8yaTFZRnB5?=
 =?utf-8?B?Y3gzNzA2RldEeVZPL201QkVSUjdHS1paNDJoMGtmM29Xc29lNFFsd3FsQnc1?=
 =?utf-8?B?UFVYWTR5U3BLSzRacTdvNEwvKzBqMmVDT0lSUWY0QnB0ZUhaeVUySG1oZ2Fz?=
 =?utf-8?B?NFJIV3Y2Z0hKaXBCTEpQOEJ5MVZOTnBuODgwNUZrQ0RDZWhoZXFRbmZLa3dS?=
 =?utf-8?B?V3BKSFZKWGtDdzFHaFh2WGgrbnFuYXpyaVFOZGcwOE9qY2loUjhIUUJNeGhq?=
 =?utf-8?B?K1dMVHBrQXhzSk5MdVVIM0J2SDY2VlV6Tks2VWt5VXFTWG9FQlRXNDBZYXRB?=
 =?utf-8?B?RFFkbDUzQnNBQm9OUi9lb2wyWGZrdDdLMXorV0pXdEk2UkxleUtJWCt3QnZu?=
 =?utf-8?B?dG8rQlZZQVBhZlEvZCtSbHVpeExFbkJqTjQyUWdOQXJoeUNVS2JwaExCU1BW?=
 =?utf-8?B?alJlcVVRbFcvbWkxTUhjWjB1NkVQN3BVN0pENlBrM1JYdWJUY0RBUVgwcUJS?=
 =?utf-8?B?Nlg3dysrN0pxeUYwRjZaLzBWWVhhNGlWK2gyTWEwaWhuNGZSbEI2cjFEV010?=
 =?utf-8?B?S0dWZmdOekRCZjNCWTBZM0txUU9yZDNVYk1oSjhMU0M5amlTKytYR004ZUlH?=
 =?utf-8?B?Nzd1RlJ3YmtYcXVPdkZxT2JXMm52ZEpmZTlqbzhHZEQ4azNOSHRyNER4M2Ju?=
 =?utf-8?B?aDVFajFZZG51RGRQUG5CUDU5dkRNbWJtTCtuaGNGb2Y2RS90S25ZbE5kUXdG?=
 =?utf-8?B?Z1lvalhEZlVjc2dYQ05WRE1IeFN3WnVkajJnK3hGL1l4TTZlTStiSCtjY3Nu?=
 =?utf-8?B?TENzVFNManFiTmJlcldqU0pQSU9EWVlCbjJtMW9xVGRHaC9wS2dVaEZ6ZXBO?=
 =?utf-8?B?TGpuaENYZGVNTUxza0pHQzJhMGZnVGdVRW1LSldmaVJudjVUSlpTR2R4Rklz?=
 =?utf-8?B?Ui81ZHBwZW14aHcyb0wxbTBNUUtYLzhtRDkwUHVFZmhQRjB2OEtNQjZvU0RH?=
 =?utf-8?B?a0xwdUNleUFQR3BTMkxCUFZ2aHpqbmNRT3kwaFNkUHFMRWlIMTNWbEc1TEl3?=
 =?utf-8?B?RndsUlV6OS9Va2U1Q1Z2bzdaOCtNeDQyVjk5YnA0cysvOXN6TGs5NUZDS2Vq?=
 =?utf-8?B?dXNPTU0wcnJjY3Rlb1kxaUZnNTM5LzZKRk53Q2ZWOVZZZGZnaXllZmNBWm94?=
 =?utf-8?B?Y2F1em5jWHFYWWVpMXZhKzBFSDlGcm9jWHlKRVo5elQzK293ODJqNG5vd1Bz?=
 =?utf-8?B?UjFFMHZFakk2OUVYajNCNCtLMGt6cDV6MjF6NEFXMmJkd1ZMUlpzNUpqMGQ5?=
 =?utf-8?B?Sk8vM0V4bzdud3pZWVZWdCttNFphR2J6cmprNUhYNWZvVHlkYXhZdnd0andV?=
 =?utf-8?Q?qFqZcvkcAsHsy2vK+Ca0cN0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43a6f5-d9c8-42ec-fbeb-08dd9846dfa2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:07:12.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26NcYO55FN7AlQ4VmWOOlFFaNDqVk3cQLH/VmhVg4t/+dcNScFJX+oymvNL656CrSm+/hMBtEq2UywhYcTqJVwpm8Kohz6sm89f/Wib5Vi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com



On 21-05-2025 14:31, Maarten Lankhorst wrote:
> When changing the condition from >= SZ_64K, it was changed to <= SZ_64K.
> This disallows migration of 64K, which is the exact minimum allowed.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5057
> Fixes: a9ac0fa455b0 ("drm/xe: Strict migration policy for atomic SVM faults")
> Cc: stable@vger.kernel.org
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 4432685936ed4..a7386334d48c4 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -820,7 +820,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>   		return false;
>   	}
>   
> -	if (preferred_region_is_vram && range_size <= SZ_64K && !supports_4K_migration(vm->xe)) {
> +	if (preferred_region_is_vram && range_size < SZ_64K && !supports_4K_migration(vm->xe)) {
>   		drm_warn(&vm->xe->drm, "Platform doesn't support SZ_4K range migration\n");
>   		return false;
>   	}


