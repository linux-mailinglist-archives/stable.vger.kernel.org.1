Return-Path: <stable+bounces-126903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF1A7419F
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D9B7A8DEE
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040881E8357;
	Thu, 27 Mar 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0iLQp9c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F451E8356
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743119370; cv=fail; b=MTo2FRc1AD4RAwPM2PmIX08W09FgeR6do+WAtBD0bFr3fmMH0AAPaRI3YnPLWnPc2D8PV1DQUTboe7QXZ6SpQw37ZnM7SNMSr31P9aszEbmrFnuRSZoXFHrUzeuhKFqO7iWrIF9mYPBPQIKpJ2hawSdBAzFbzlpACPKZv6IrOI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743119370; c=relaxed/simple;
	bh=yyrafJwIKYdN3Bnz4WYWP2gVBFS790BwBX5SFT09JiU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5O2GCcb7eynN5XYb+0CubfL0TiQH+IxgDJplz1jfX8lJTReVZEKRBqizj0nXEFedq/sUU9UrvBhRSZhdWdOig/gR/mVII7H6FAMZphs3YOjSivVmoXh7G+s4wTb0KLI1Srm6JdUI7TNZcPwhMl+z0R3PR10fsY1bZzS6prkHVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0iLQp9c; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743119369; x=1774655369;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yyrafJwIKYdN3Bnz4WYWP2gVBFS790BwBX5SFT09JiU=;
  b=O0iLQp9cLwlJP3wV8mrwEtrnkkUofSose0jn7WboZY7nHnKfxXvSb1XP
   LKf909KBmfs2ZqzTaFIJnSBQV3/pG3aUAfl9wZWzTp81iqPOJeII6pecC
   tUxokRiSFJG6tdbsHK0i4YzYXCBDFBsQy5zz6Y3/k4zxvWs29mxL+P0Ab
   TCIWBnf1hXq3AXTnslXkLBNeOyNHBEuoYNjh4lR0ggB5jnKoq6KlBVzrw
   JbWa+9HF2eRMR6QqGIesIFcb5USf9BmLp6/iVs3NQ9jxotJYwLB8n+HeY
   zOmV6LwonhIVc3gZhHYpxdgYFdBic/QjYGtO1znjV2UDvn8Z+0rGMCaNn
   A==;
X-CSE-ConnectionGUID: a7R1NdS3SCCYobBWp6LPLw==
X-CSE-MsgGUID: YVToTyC+RWWEUkgxrz39Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54675635"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="54675635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 16:49:28 -0700
X-CSE-ConnectionGUID: nG35H/FJTeOZZTE+HnKRiA==
X-CSE-MsgGUID: X7BwyIi8QnK7OETJG7F/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="162532977"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 16:49:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 16:49:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 16:49:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 16:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFLtSMrazvQRWA2eG8EL9XOeWHibbjYeRbHkU7XpYkQ9IcjKBSh7cGyuSBPGb9WvT6gGh9X9pfBTXCvkn2TGRoou9I4IYAn4OQ5dI4cjVh14tWDKfwMB3B745hp33XxNzSR92+XYhy67GAWGgBlHZbWhiFplkE8IuafNqkemq8l2nq4meZm2lBcW5a2MhXIuGTLig79s8EljSNNsgn0LcKAQCYvS/lGp84aoz19K53bhEPw03NjQB33TV0uN1hbJv5SBwK6qv/5vU9GsSH14+yx3+QjC6iYOvZTmfMWNzAUGQ/nY2JsxDaLEUUvfcSyjJHxp71m1Nwc0gkDnyp5Mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNochtNZrwpzoFYZL5bs96jBDMveM2FnfF7PqEgPzuM=;
 b=OQAApvSL+CwwoSjNWsXHH7PywgZMpxdidBtheRza/G7MsFTH1gSsta3K4aN3LA6vHaEJIYzjaUSRePVzBdNebzOHQALoIyByGkPwYoFqYlPAjYNzqga3/AtIN6tt48P5BWML6yd2k8YxIZZx231YGrEc2srkwbCQr1nXtdYEjGCRZeYuh9x3cyqQxxIJt1uzexrGHCk9e2ts/2Bm9akAFCDO7vwUTSpHQPNKbOqUiI4pBfXfb7dPFXUCicBTgiW4DX22ePO3beShh4zVeXGZ2dtzwlfW/Cymh28oojSC+vY6k3WMrKItZorF8LG8XO9HbCzAba3jQv51bMSLyqnlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 23:49:25 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 23:49:25 +0000
Message-ID: <3141b07e-ca50-496c-9edb-bf98a8111cfe@intel.com>
Date: Thu, 27 Mar 2025 19:49:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Invalidate L3 read-only cachelines for geometry
 streams too
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
To: Kenneth Graunke <kenneth@whitecape.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20250320101212.7624-1-kenneth@whitecape.org>
 <ceceb5ec-68ec-4d61-a94e-ffd3d2e869c0@intel.com>
Content-Language: en-US
In-Reply-To: <ceceb5ec-68ec-4d61-a94e-ffd3d2e869c0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0384.namprd04.prod.outlook.com
 (2603:10b6:303:81::29) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: ab192c8d-8be7-41a3-5090-08dd6d8a0161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3pKdnR4VDgzM1NZd01pZk90Sk9HdGRRcjU4QWhINy8wY2ZRVFRUdDFFc2Vk?=
 =?utf-8?B?K2VTNFJ5QUQwMlhZRHZ6WXhEZVYwcVRZS2RyVFBVSmc4cWZ3R2dYRWM1bFhT?=
 =?utf-8?B?Tko4ejN2T0NqOGpONUR6SGJWVnRzVDBLSWRUcFFISVBIUHFSUWhEa1c3aUpK?=
 =?utf-8?B?czVmTEI5T1ZPRS8yT3NnT3VyWDRFMVVqNCt6VzNUb1Qya2FtUWp4Q2o0MktX?=
 =?utf-8?B?Vk1xWnFuM0l6TkhMRng4VytMcnRrYm1CKytFaHgvWWpGQmRkYjIvV0JaeWht?=
 =?utf-8?B?NHppTUNvajJVRU1pMjE3SWtMOTRYN0djOE5wSTFyYnFNRGR2VkFKYkd1TTRa?=
 =?utf-8?B?bkcwcjRlak5ETzlIalBaQ0I0S2thSWRLRzFtei83K1N1QjdNSHpsWU5hQ1No?=
 =?utf-8?B?MGJUZnZTLzZTWGxCR0lUUzd5d0R6UTdGMFpqWFV2ZW5rNlhLTnhkWndmZGhh?=
 =?utf-8?B?U0YzT0tqbDFacU9zaUNSb01oSFBEREVhdTBIbDFFaGk3MEJ1aDVZbnV4R2lX?=
 =?utf-8?B?VDhRQWZ2RzBXSVV6VlJZbnZpWlFDdUtSUE1SREo4NXBsTlhZQVFiRGFkalVP?=
 =?utf-8?B?bzBiQU5USWoyS24rRzZ5djJPblhQZnZiTWlOSTVSMWJaRDFMNHNFZGlwVlFp?=
 =?utf-8?B?QXlYTHdHdDlrNXp5bTdZTitlbmNDYmRDUzJUb0ljK0wxT21Gc3VCS3lUOXFI?=
 =?utf-8?B?aldUUDVjakhNdXhmemdvbzNiTHUySEYzQkJidVZFMXZUOGMyZU5DWHgrM3lx?=
 =?utf-8?B?ZkJoaVRuOHlQMWl2enRhWHZJLzRPZzlzd05YUFFLWTZrWEUzT3d2cFFndmlV?=
 =?utf-8?B?N0xyT1RRR1BSMEZxRjRPd2ZOcjV4S21zT0pWRS9JVnlGQXh0UG1VUW1QMmw4?=
 =?utf-8?B?UUxEQkhaRmo4YXo0N2JpNWRzZDB5REgzL2xXR3NvcERMemZLSnFieGd4L2Uy?=
 =?utf-8?B?bXA3Mi9sTG1pS2J5ckZoK0l4UGJEVzJWL2lKMUQyUjJCWnFqVVY2ajZEU3BE?=
 =?utf-8?B?c2pkN09jU2R3ZGNVQitKRnJkSmZ2VytOT3NKejVoK2lYa1JSWjA1RWZOeXFy?=
 =?utf-8?B?NC8wbDc5MTg2YnQwR2pEdEg2ZG9oVjlCOVZadWlFK2dQeVcwdVVJakVhK1Ns?=
 =?utf-8?B?d2txUGJyeEtIZFhMUS9OS0NPeFd0Ry85dU43M3ZmSE5qWGk0ZkJpOVRrNGpw?=
 =?utf-8?B?U1JIajQ3c2NhSmhIRWFKL2pibFM1Zit0ZzlRbTJ5bUtFN1VwM0ZpdllXdG9K?=
 =?utf-8?B?Rmp0aUVsa2lpWmV6N005TEp1RTVqQjV6cFRWTUZOc0xFVmlaRUVFSzZYbU92?=
 =?utf-8?B?TkRWRDJXTzVPSEZhUG1abWN5ellybnI3SVovNHdpUUQwNU5Qdnk3enVNYmJM?=
 =?utf-8?B?dzYzZ2FyazRLdUpUMElWM2MrQnVLTiswbURzTjNiN2g4YmZiNytGTTE0OXoz?=
 =?utf-8?B?cU9DVHo5VW5DdlpRckhKSGpmT3kxOTAxNDRLbU5KZW9JdWszK2VBbG9qb1hV?=
 =?utf-8?B?Wmh5cnJmNEJ4MHZ2V2hRWHl3eWZSK0pXd1AxQWJrdWNYbDl3anUyZEFsdWMz?=
 =?utf-8?B?Q1BNNHQybDlQNXNteldEa1FYSEFDYVJQcDJ3UTZYVkhBU0plcVI2ZFhZcVJv?=
 =?utf-8?B?S2FwYXA2V0NwOWVIbkd2N2hZWFJza2ljWXVhMnB3QWpaRE1WSW5aZWhKMXM5?=
 =?utf-8?B?Y3ZNeitjc2JQd08vc2t1ZE9KQ3lNRkZ3cExrSlpETGc1bTZmaWcrVGd0UEJQ?=
 =?utf-8?B?RU9yY1RocEhFcHBsZE13bWkyUGN2aGdHanNUbmpTbFliRVRmOThCUkQ2clVj?=
 =?utf-8?Q?EtinhSTXo1z1FKjUGKE4nv/VpHYs4CLQu9Rqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVxVDMxalBIWlFDTndlWHREYXNnclJKVVhwTFAxWC95VjhtMnlMUXBKQnFX?=
 =?utf-8?B?ZXlNSktueFNDUGlycU14WVZEYWZtNTlGbVBERnppSkR0bFJMUTBBQlhyY0RZ?=
 =?utf-8?B?VUlVRmZrbENySE95cWpEK0tFSnVCOGx4bWZGRmw2YkpQWVdtd0lRcFRpQVh4?=
 =?utf-8?B?alNKVVJydkxIQWNhcEdVcWNwdFJ1V3IrN3dIMUgxMWFicUxlM3NPWHczbzc5?=
 =?utf-8?B?RDJwRE9OYnN4ZGVCY0kyZWhhSnFaakQzN1NtT0Z2cnZpdkFqWitjVnhjN2ox?=
 =?utf-8?B?M0w3SzhvMkRpY0VpUW1LYm1sU0JmeUx4WUpReGt1RUNDN0U3WGNEaE1EQlJz?=
 =?utf-8?B?TGVVbDZCU1U5ZFo1UlRyUUJrcDRUcXJFWWlKRHZQcWhocHEycnFvbzBmbHNh?=
 =?utf-8?B?NkUybTl0TVFIRlBUeGRSbGFnZlBmbk9GS2UwOHo0TklvTWsreGNnNGlNejMr?=
 =?utf-8?B?RHlKSTNraS9YV2M0czBPZnVqSnhsRWNCQmRhV0ZoTWpPQXJET0tVN2FSbkdZ?=
 =?utf-8?B?R2xTV291ckRjOFBpUDZHaXhseEpnQ0VpRHdXTkF5aXNFOVQzTFlhclRHOVFu?=
 =?utf-8?B?RGpPNnJGenpRNk9jcjUvK2tBcyt3RkRpa00yTkZKcWlKNWRMUDAxNEQySFk3?=
 =?utf-8?B?OHcrTFBEU0JFMmRPZHdEK29HaGZJZU9XRTFTV3pVSlk2NTFYZ25YVWJLVmxE?=
 =?utf-8?B?SE9QSHN6c29qc2dHSGlaRld4NksvZU1VeUVOVk45WlRhZEdPaFg1dm1qbzds?=
 =?utf-8?B?WG5DSXAvRmJFQS9PU0F4QWZYTHl0Q1ZCT1B1VVJIdTErSm92MVp6SC9ZZXNR?=
 =?utf-8?B?My84c1E1RmNKbitjMzYwTnRIZVUyVk5QOFZVVDl5U09Cd0wrOHA5N09aKzRv?=
 =?utf-8?B?dzNqUEhoVlp2V0V1MENaa0NmaWJZeDNJT2k4Y2VuRFVieUNpS1NxbG5JSnZG?=
 =?utf-8?B?ZmZFRS9OVlRSTGpiTTZUenhMNnM5ZFZqT2t2TmMxZGpkMEhCZ0FDZ0pXdWZG?=
 =?utf-8?B?eTVpM2IzbTdSUU5Ic2N2UDgwYWhNUnV4d0cvR29LRXdaQW1OVGJDSTZHRExQ?=
 =?utf-8?B?aFpqR09CTXJuTmJhOVZZeFJXMVliWFhzZVNCUFBURy9UcUhmWDBEN05jWHdJ?=
 =?utf-8?B?WU1RYm5pNnFnTWwzc2dCeFZCNWIybXc4MnlCQkFTOFhnbEdYbU4xR3JDdzI3?=
 =?utf-8?B?a1NwdThpcU9ybkpVb3AxL3RjWUR3c1BQT29SOEp6RXBuZFZ3c1duRzNHbExV?=
 =?utf-8?B?V0I2SkR6cG5rcG1IbGdpd256N3ZkVE9vTUhjcFZmSHloSDhXejVjVGtZRjZ6?=
 =?utf-8?B?ZDAxSlQyd0JkWC9OV2hhUzRWb1ljc01aOHJValpyd0YyWEFlRzB3OUxGM0hX?=
 =?utf-8?B?RGRMTDZBTTBmTGxQb2QyZm9VS3VwcG5TSjdkZWpSQnNVVk9WUG51aUx2NFpG?=
 =?utf-8?B?S3BRWkV3NmQ2d09JcXlCVVY4SFpXK09yUDVHbThCVzNQUzRpQmhRWWJ5d1hl?=
 =?utf-8?B?UzNmb3dhMHM4bjBaaWZZeVJ6dU1vaHp6eUMzblF4RmQ5ZlJVQXY2T2MrOTFZ?=
 =?utf-8?B?MjFHOGMvTmJTMkJvc1ZOeHBhOVY0TzljN0ttMmpYVG5KSGw0WkJGREN2K28y?=
 =?utf-8?B?QlNwVU5TS2hDM1NyNEtsVHVldC9FSlY5Rko4MkROQk43MjRkZjdZQUdWdjZi?=
 =?utf-8?B?TTdFakVabkpaVmY4Z1RCa1UwczdXajZsU3hhd3hLQTB6bkJhbi9IYXhHMWRG?=
 =?utf-8?B?WEQyMUU3dDFvczhHMTBDaXBlSkwxRHhRZ1A5L2cvd05lV1RZRUdaODN2cDB5?=
 =?utf-8?B?V056YksyNytVQXIzQ3U5aEk0SzFxYlNnRnYycHVuWGhEckxSVVJoM2R0N1hD?=
 =?utf-8?B?RnNDeWwzUVZoaDBIS2k0cEVuUHBkajdSR0xwRGRJL1k4R2lBOGdzZzJqQ2g4?=
 =?utf-8?B?WFpwbVVSNXA0V1VaZDdKNnhVMDdMa1dkYm56YWZNQWFWME5zQnpVR3FaaVBv?=
 =?utf-8?B?QzFQd2E1Tk4wRWhTaGhUM291L0doOXl5SXdHTHdFbXZiMHpkd1EyRDJyQmFJ?=
 =?utf-8?B?Q3Q2Q3FpbFRtaGdwWDFlS3dPOEE1UE1hVVRGMVg1KzZ2a3RWcmZuUUV0ZjZ6?=
 =?utf-8?B?akVueUpQSjZHRjRxTTlnU0VCMnJicm9ERFU4TnM2eDJjbkpheHVTbGZRN2Z4?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab192c8d-8be7-41a3-5090-08dd6d8a0161
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 23:49:25.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FVB/31JI2hM9wfY6VznMix9vWhIBQ5Xpw7cx5vcqn+QIyXKJ032WRVe7hi88E32hVrl349LlVV58UhRvlY4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

Hi Kenneth,

I'm trying to resend your patch from me to trigger the CI run, 
meanwhile, I found your patch missed "Signed-off-by" tag, could you 
resend with this tag? If CI still not run, I will resend your patch and try.

According to:
https://docs.kernel.org/process/5.Posting.html#before-creating-patches

Code without a proper signoff cannot be merged into the mainline.

Regards,
Zhanjun Dong

On 2025-03-27 6:39 p.m., Dong, Zhanjun wrote:
> 
> On 2025-03-20 6:11 a.m., Kenneth Graunke wrote:
>> Historically, the Vertex Fetcher unit has not been an L3 client.  That
>> meant that, when a buffer containing vertex data was written to, it was
>> necessary to issue a PIPE_CONTROL::VF Cache Invalidate to invalidate any
>> VF L2 cachelines associated with that buffer, so the new value would be
>> properly read from memory.
>>
>> Since Tigerlake and later, VERTEX_BUFFER_STATE and 3DSTATE_INDEX_BUFFER
>> have included an "L3 Bypass Enable" bit which userspace drivers can set
>> to request that the vertex fetcher unit snoop L3.  However, unlike most
>> true L3 clients, the "VF Cache Invalidate" bit continues to only
>> invalidate the VF L2 cache - and not any associated L3 lines.
>>
>> To handle that, PIPE_CONTROL has a new "L3 Read Only Cache Invalidation
>> Bit", which according to the docs, "controls the invalidation of the
>> Geometry streams cached in L3 cache at the top of the pipe."  In other
>> words, the vertex and index buffer data that gets cached in L3 when
>> "L3 Bypass Disable" is set.
>>
>> Mesa always sets L3 Bypass Disable so that the VF unit snoops L3, and
>> whenever it issues a VF Cache Invalidate, it also issues a L3 Read Only
>> Cache Invalidate so that both L2 and L3 vertex data is invalidated.
>>
>> xe is issuing VF cache invalidates too (which handles cases like CPU
>> writes to a buffer between GPU batches).  Because userspace may enable
>> L3 snooping, it needs to issue an L3 Read Only Cache Invalidate as well.
>>
>> Fixes significant flickering in Firefox on Meteorlake, which was writing
>> to vertex buffers via the CPU between batches; the missing L3 Read Only
>> invalidates were causing the vertex fetcher to read stale data from L3.
>>
>> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4460
>> Cc: stable@vger.kernel.org # v6.13+
>> ---
>>   drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
>>   drivers/gpu/drm/xe/xe_ring_ops.c                  | 13 +++++++++----
>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/ 
>> drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
>> index a255946b6f77e..8cfcd3360896c 100644
>> --- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
>> +++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
>> @@ -41,6 +41,7 @@
>>   #define GFX_OP_PIPE_CONTROL(len)    ((0x3<<29)|(0x3<<27)|(0x2<<24)| 
>> ((len)-2))
>> +#define      PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE    
>> BIT(10)    /* gen12 */
>>   #define      PIPE_CONTROL0_HDC_PIPELINE_FLUSH        BIT(9)    /* 
>> gen12 */
>>   #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE        (1<<29)
>> diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/ 
>> xe_ring_ops.c
>> index 0c230ee53bba5..9d8901a33205a 100644
>> --- a/drivers/gpu/drm/xe/xe_ring_ops.c
>> +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
>> @@ -141,7 +141,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, 
>> u32 bit_group_1, u32 offset,
>>   static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, 
>> u32 *dw,
>>                   int i)
>>   {
>> -    u32 flags = PIPE_CONTROL_CS_STALL |
>> +    u32 flags0 = 0;
>> +    u32 flags1 = PIPE_CONTROL_CS_STALL |
>>           PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
>>           PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
>>           PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
>> @@ -152,11 +153,15 @@ static int emit_pipe_invalidate(u32 mask_flags, 
>> bool invalidate_tlb, u32 *dw,
>>           PIPE_CONTROL_STORE_DATA_INDEX;
>>       if (invalidate_tlb)
>> -        flags |= PIPE_CONTROL_TLB_INVALIDATE;
>> +        flags1 |= PIPE_CONTROL_TLB_INVALIDATE;
>> -    flags &= ~mask_flags;
>> +    flags1 &= ~mask_flags;
>> -    return emit_pipe_control(dw, i, 0, flags, 
>> LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
>> +    if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
>> +        flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
>> +
>> +    return emit_pipe_control(dw, i, flags0, flags1,
>> +                 LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
> New PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE    defined as spec 
> documented.
> New flags0/1 handling looks good to me.
> 
> For some reason this patch did not triggers automatic CI run:
> 
> Address 'kenneth@whitecape.org' is not on the allowlist!
> Exception occurred during validation, bailing out!
> 
> Let me check what we can do. CI run result is required before moving 
> forward.
> 
>>   }
>>   static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,
> 


