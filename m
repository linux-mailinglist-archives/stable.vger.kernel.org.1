Return-Path: <stable+bounces-164940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20506B13B99
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AC63AE038
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACB266571;
	Mon, 28 Jul 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw6nmZ1E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060F1E379B
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709863; cv=fail; b=ftKzKIBO6bXAP8KS2e6+tgnb+E35BHtDmgSuGInk6kibWMR7ZnpAoPMDRAa/s/oVJSYKaqgXM4s1b2jgE8HcDj+Kt1ipvtriA5FmWYLwVF8mmIFcFf7qoJ/9RJ18+5VbuSE7V+tvXwzjnQK6my8F17ougiLUiwAjsWZ0AZz14rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709863; c=relaxed/simple;
	bh=Ir45XLFQO+9yYIToIksYioz3Dj5DhAqCkVotqg+Oj7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUxDvWw1xi0yw81wPUglnJTm6ctwSwfUlZPUB6G8SQXDBUJx9/J1t+unyb5R3kIaUKN7WXFouIZeT6a7pGQW7Exts3Cm8Sia97uGss1uye101A/RQXUnjIyHYsOms2N5sd0i78YsF9aWW11s4JMI84Dm2oprruqFcSUOVae1HVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aw6nmZ1E; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753709861; x=1785245861;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ir45XLFQO+9yYIToIksYioz3Dj5DhAqCkVotqg+Oj7U=;
  b=Aw6nmZ1E39sAj80niSueUEbLzMwmH5+1yzxyipKazO8PXAptQgszl6W5
   vnHgXn+z896WJFiMv1L6mNhdN6g5G+21hGBtyYECfBAEisJ5lUgiqYJk7
   bbi48Cy886HgYoBkGPwe2qfwq0GcbbamIKKC/RkZIuWpbqUDD3e1bKPAc
   xN00HWMM/0+sEbPgXmOLwtHsgl7RVN1kOQMk51yNA7uBYlXFOiBv9o8yp
   S0pMjUjCRL9a3zWuYGmYfmDuPyTkTXuSVNRhoDZUIeFZpC6lW9VXIchsN
   ierfyz1J1Rbc5PDlSkWbLutRPgKKwVnzFRPYg1B0QapTZvtPa0nYQgCN0
   Q==;
X-CSE-ConnectionGUID: I2TsHNRZSh+goHy8PcOEsg==
X-CSE-MsgGUID: VsyPgUqZQKuc6RKdQ3BZig==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55657680"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55657680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:37:35 -0700
X-CSE-ConnectionGUID: snkeEq7bSmSDCzjDp72Tyw==
X-CSE-MsgGUID: KnOFX3AcTz+Oza3AGrgVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="199559913"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:37:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:37:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 06:37:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMqjmQSBVTOdh32oxQDxDk6y2qJNOVYj4Y7Q/hlNckmPU0H2avJz/l/ADCV13J5QI+Py1mB5Pjc+jgkeK2e7BO4NQQdYzh7dPHkhKqHjl1A6M+TH5RRAZ/L6AC2wz2JSaJfOw/4BejwaYKy3DuVdgwW4scn4L1OKyoarfFCpnZ/qJwYNwcHBMaGh3Dl1EM4D2khSY0XYPLs/TUjpiktmcpPsf0dgfwj2njjKxg7yJNvhypiZRiYGUdoUKwaLTNzyz3unXDgklXeawYR8ai26uWiweEna1Ja9Gz+5MLvSeikYh+WYLQCr8r+LpXfWUWUhmpRFvhB9TH/REDlJeRA3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84eVK64A+hlvEhE2yLmc2imnrkarAET9aJ0RiVuCGqo=;
 b=SUSXbOebPmjUkEIFLfSJmqFv/+noLQV9MrgqLKOspyuJOMtm5QABvDFvI9Q3qtPxWl7r9zPVq8vdW6lg0ssRZOxInHjWw3vcYukRCiX8znRsGnF7LCNxyPG6ei6z6PWorhpbzcQ2T3cXNK7/lnH0jAe9XFhLo9ih3d9llq1TklEDDJRony35g9erqMOWvEzyuIAOU10qRLmqwq3Ezcyvmu8iI1Ew3J9T8i/gwhHLahPAj3+8gmMlWIvIkIv0Ry2R9aZA7lZM30kTgOls78djoYQLUkwkZEoM+ahYTFWqMI/V5wxMqWO1k39BWQKxQc7+2xR0Q2zVS/7Jc2xNOIVV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 13:37:02 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:37:02 +0000
Date: Mon, 28 Jul 2025 09:36:57 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
CC: <intel-xe@lists.freedesktop.org>, <jeffbai@aosc.io>,
	<stable@vger.kernel.org>, Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang
	<27873200@qq.com>, Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu
	<lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>, Shang Yatsen
	<429839446@qq.com>
Subject: Re: [PATCH v3 2/5] drm/xe/guc: use GUC_SIZE (SZ_4K) for alignment
Message-ID: <aId8-ZwntjDnyxJA@intel.com>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
 <20250723074540.2660-3-Simon.Richter@hogyros.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723074540.2660-3-Simon.Richter@hogyros.de>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BL1PR11MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e75940-0218-4826-0ef4-08ddcddbd573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzVtaE9aY3hNeG9yQTc3NTdhTVQ0VElPaElyQ2NYL0pDOTFNak5sdXN6M0ZW?=
 =?utf-8?B?d3BjOHJDM25MbnlJeG8wRkJrWVVQWUpKQjU1OHpBOXZzelVEMENKYUovb0Z3?=
 =?utf-8?B?VS9mdU5kM0ZvaTlETlk4MmFVMEMrdk1HekE1c2ROUGpLaHFHRzZzdXlJVzhh?=
 =?utf-8?B?YmlrVjQ1dXBPWjhFZksrMURFUUpneHpXZEgxY01ua1VNUkRZVHllZkFSSUJh?=
 =?utf-8?B?bktIRGlLWG5ZS1RSUDZUVFhmUUtLdkdQM1dzQnBpWTViWm5zdUtpRytiNmta?=
 =?utf-8?B?VmRLUUFIRW5hRjd4WkY2YXk3SS9IL2t5ZXhSVVF4NHV6ZW0vY3RueWsvWnI1?=
 =?utf-8?B?dCtCNGltWUJkeEN2Q05kUHBEeU11TEdTSkVLL1lVRXZoVGdRMlJwTHN0SUlU?=
 =?utf-8?B?eE1zQUFlSkdmS00rWW5Fd3YvcGpRWWlibXlGRUZIK29zQnJDaWZrbDUreE50?=
 =?utf-8?B?WGlrQ0hmQ09lQ3ZIVGlkczdaMnUyU1F6UEdDQktnMW9ZZjgzQVBDQVNGdGxI?=
 =?utf-8?B?MndpbFd5UDBhbEtBZmMwMlhDNSt6UnJrSFpUZnpUdnpKT2JyT05YZ1RnZWtQ?=
 =?utf-8?B?dG12Z1loOXozOXkxTEVoZWthZXRkRVBNbWxQakowTmNnNHpxUjMvQUw5eEtw?=
 =?utf-8?B?Y2ZYakd3VFpEK05UenZwZTdvUjlYWU1lbkd2blo1T29xWUlNY3FHKzNreXpl?=
 =?utf-8?B?OFZPN0N3dGZGbUp3ellUNUJuNXR5bTJuOHIxYnVIWE9iSkJkKzh6R1BYeWli?=
 =?utf-8?B?VmthaThEa2J6VC9RWXNkZ1NHSTVCU0xBa0lHVjlkNWN1SzV6TG5OTnJFTlo2?=
 =?utf-8?B?cENmTi93WlFpVUhLcXdUTnZoY3A4VzZ4d3JZZUNsTCtiWEZWam1tZnovSFBT?=
 =?utf-8?B?bGlwVlNyVG9Va0MvaEV5QXkwY0VwUUR2NThjMXpuUncrUG43SWtkZ0laZGtE?=
 =?utf-8?B?N243Q1NCejVKa1dKTmUxZ2ZwRzFKNFpuQVBqa3JSZFp3dG1WTGZFSzlJTlhq?=
 =?utf-8?B?OUpIeU9wUzlpUDRTOGlWeCtHdHlhanRvNVlGSHVDVGlZMzVselpnK3VtWDcw?=
 =?utf-8?B?NEN4R2I3ZnAxVWpPaEw2dUt4TFVKOWtJMi9oaW92eVRnMlBvb091ek10VWdR?=
 =?utf-8?B?UjJyMG4vVms0OHFIWi9iTWFRTjhleTZEb0ZodThKSWtVejY2R1hNZG9Vd1Bu?=
 =?utf-8?B?cUNOT2cxb29heHJPVXRXSDF6Qmh3TUhNTG9JaDNBbmt4WW1STkpQZDM1OUpQ?=
 =?utf-8?B?TzRCeEhwSyszSC9PcExTbFUwbkJ0ZnJ5MDIrTExRZSt4Rmc3NlRLZjdBbEZ3?=
 =?utf-8?B?WTBpUHh4UWNMclNPcFo0ejhZSG1ZazhPTmMyei9teTdQYVZSMlM3ZFpFSWc0?=
 =?utf-8?B?UjVLK2QwTnVIUEh3MC9yQjM2VjB4S2p4NjF1TzdyeTdWU1hJdTh1Yi92SXZN?=
 =?utf-8?B?RWRyWkhTQ1JQT0M5dmtOTFJ5NTNDazNxY01IOFV4VGFsdm0reTdBelNHbmdH?=
 =?utf-8?B?VlJUTVJmMzNRYkRsUVdib0JmWFJwTXJUcjh1Q2x2dVRNQkxoUkxSMTc3aG1t?=
 =?utf-8?B?Z0VNbE5ka2haRDhBRzJtaW9hMUVxTUZ4Mk8wQWNEWS9qQnVQbHJkcDBMOFpw?=
 =?utf-8?B?aTVsLys5UnVJY1U0UndINlJoYkl6eDRnMXNpdk9Pamx1S2VCMXY2WkFVRkU0?=
 =?utf-8?B?U3pyMklFd1dFelRyWHROcy95M095SmlvVDBPNjNHRGxJcCtYNU1sZWhSR2Uw?=
 =?utf-8?B?UFdxakRJak1rSHRNazhmQ3EzZ1hWK3NqdWJtN3FFTk5Qay9hWWNxOHhnQmVm?=
 =?utf-8?Q?XPfuMP0wm+J8BaGhlsgAoVsPliUIQKkYcgsnA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkU3U3dLdnBXN0JvYS9jSFQ1UmwwNUtQU3ZObjlRUFgwUlpMaGVRSDNiMUhs?=
 =?utf-8?B?RXhSMnVVZkRxOHJoK1F3bjJwQXFUZ0F1Q0lZSm1FVTlWOE9VOVVURzVZbFJv?=
 =?utf-8?B?TVN2aW5jUkJBaFM1TFdUTDZXZm5KTVA3aHBVNkY2Zy9URE1qMzgyYTZJcnZ0?=
 =?utf-8?B?eXhTU2J6U3J6OEt6MlBscUtMdU5TTUFRVHA5M3NwZUp5aTQrOFhVNE5vOUkx?=
 =?utf-8?B?QU9MMUxkRmJRUi85T2g4dTlOZ2NXK3ZOUm9FbDFUZi9naEhWQ0h0UUJwdlhr?=
 =?utf-8?B?bXF0T1VoWUlVUkdTZW9waWRVMG9uUzdrV2VDNFoyNFNVQXkxdkM4R2gzYXhH?=
 =?utf-8?B?RG1wQzNXQ3JlbGp6NzVycVRXek9qNldIeWFCZVhZWHBMVkJHWUd3alh4enZy?=
 =?utf-8?B?NGJidWJOSUZDb2lhaFF0NzZKQmdLelFrZEVTN1cyT3NzbjBCY3lDdmJNeWgw?=
 =?utf-8?B?TEhmRG5QMnpvc3VyQ0xvK1hKMjh4eXlrbkVoaldCN253cXFVR0VFNFVPME80?=
 =?utf-8?B?SU4xMSs5S1Iwc1R4N1NHckNUT3dac3NnTFBkVVloMXlJZDRRU3ljVExMMDdE?=
 =?utf-8?B?bE5xREFZOXBXcGRNdUNPZWs4OUdOWFFybldtYVBBQmVJaEpWTDFNNnNkc1lP?=
 =?utf-8?B?aytJWk5KRHQwaFh6dVIyOUFvQlpxY1cwd1Y3SzNxaU9SYXlMRFpLd0hPQnRF?=
 =?utf-8?B?cXJ1MTVqZnBiakJhS3E5WU1YeGdFbEhZMVFSUEx4Y21hYlM2akcrVUhlQWpz?=
 =?utf-8?B?QUpDWGlPM0xtN0VBVTJ0TjdlUkpFSGJDY3hJWU9GbjJMUzkzUnFUaG54RUdX?=
 =?utf-8?B?dUQxV25aZWNDUTR5V1ZzMGhqSGxlWndYdDhrOXRneVdRMWFhelR4WUtzd3Fq?=
 =?utf-8?B?VUd3VGpFVVJHM3puTVR0cDlHbDFpYmNDTWtqZDduUmdHdE9PZGU5WGRMVTlW?=
 =?utf-8?B?ejB4RjhPZ0VRWjhXZE9DZVlTTmZMVkxmQndKUXVWSjhoZ2M4YjlLYVIvL3c0?=
 =?utf-8?B?Y05tRStJYmt6U211TlVMS0hvUUpjMmNwOUNEMzEvODQzMG5mZWVUVDN6Z1ZE?=
 =?utf-8?B?eVJKN1llekhFTnVOM0hVZVV2Skk2MXFSQUF1ZDhDSmdLWjRpeDZzRmRNbUsv?=
 =?utf-8?B?eUxRZGhNZGJlYUxrL085N3BIdG4yTWI4RmdaTmRpV1VLOXBHQTdLbGIwdnhB?=
 =?utf-8?B?SFlwYmdaaHFnOU9uTnJ5VzZrZStsaGtoekFic2NwVjhYMzd6ZUUwUFVtVDM4?=
 =?utf-8?B?NHh1TkV4aWNsQjBzazFDTW5Ma3dmSitKdUFUd1BxSzFlb2VUM0xMN1FxR1Qy?=
 =?utf-8?B?c2MzaXkwa1pieGYvVGMvVmxPc2o0Vm8wZGpqaVJ6bmE4M3duTHJ6RmpMeVc5?=
 =?utf-8?B?OEhpMmVONi9mUUtvd0dBS3orNDVGT3I5NFcyUDBDa1NiOTBYZE14NDZRNXp1?=
 =?utf-8?B?akdKdEY0YnV1dGU2alExYnNjTURPc0JZTjBOOTFCVU5xc1M2MEc4TjZHWm53?=
 =?utf-8?B?T3lPeElJbUtUeHY4KzhybVRZc1hQN29JRVRmV1U1WlFUZjlKVWhOeVRCWlNK?=
 =?utf-8?B?SzdZR1J5andUcWRrdnBmdUxwTytXdjA0ZjM3aFVvcFZvc2cxZVVXWVJlQzcx?=
 =?utf-8?B?bDN4RlpRV3I2Q2RwanplVjFyVTBUcmlPSlk1OWZvTnZYNnAyVUtxOElyZFNF?=
 =?utf-8?B?aDNDWjFTWEdTR1ZGKzF3Z2lsMi9WdWpoV2pBL21yRVAxTEkvWTdPMmQwWnUz?=
 =?utf-8?B?V0svY251Y2Jick9DYWs1MStGdDgzSmpucFEvRlI2SWtKUjE0d1R4OXMzN2Z3?=
 =?utf-8?B?OW83TWpDcU42UWJ5bjJvdGVzVitId2RhU2dxUDlsVDZBenpobG1mOHA0VUVU?=
 =?utf-8?B?eWhqSkRFa0E3NUdlZzUwYnRBVVhzMHN4QldQNjlFdFNsZWpkeHNrS1cvTmJZ?=
 =?utf-8?B?UHppb3c3V2F6YU1RUWhlSG1qYXh0YWJNL0NJaEljZktGdVhBZ1E3WUhiNS93?=
 =?utf-8?B?eWMrbTJDYUZyYTRKdFAxR0ExaTJHV3hWT2hrUVcrVzN1eFltRm9EVWtlUnFJ?=
 =?utf-8?B?d0FCT3h0bytmdHErTFhlTkFMOFV4ZjF1VStzWHU0Zk1zc1pHUHNyaEJ1ckJK?=
 =?utf-8?Q?3z8GLCEVjBP2IcwSlrTEcag5h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e75940-0218-4826-0ef4-08ddcddbd573
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:37:02.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gt2woDiJSTUZEbbJwNSe4TcUpbFW7xdhE29aqSxmmm9ie37P9/qqy4eFhYaK48SDoF4uM1HoCBnHNB/biHUbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 04:45:14PM +0900, Simon Richter wrote:
> From: Mingcong Bai <jeffbai@aosc.io>
> 
> Per the "Firmware" chapter in "drm/xe Intel GFX Driver", as well as
> "Volume 8: Command Stream Programming" in "Intel® Arc™ A-Series Graphics
> and Intel Data Center GPU Flex Series Open-Source Programmer's Reference
> Manual For the discrete GPUs code named "Alchemist" and "Arctic Sound-M""
> and "Intel® Iris® Xe MAX Graphics Open Source Programmer's Reference
> Manual For the 2020 Discrete GPU formerly named "DG1"":
> 
>   "The RINGBUF register sets (defined in Memory Interface Registers) are
>   used to specify the ring buffer memory areas. The ring buffer must start
>   on a 4KB boundary and be allocated in linear memory. The length of any
>   one ring buffer is limited to 2MB."
> 
> The Graphics micro (μ) Controller (GuC) really expects command buffers
> aligned to 4KiB boundaries.
> 
> Current implementation uses `PAGE_SIZE' as an assumed alignment reference
> but 4KiB kernel page sizes is by no means a guarantee. On 16KiB-paged
> kernels, this causes driver failures after loading the GuC firmware:
> 
> [    7.398317] xe 0000:09:00.0: [drm] Found dg2/g10 (device ID 56a1) display version 13.00 stepping C0
> [    7.410429] xe 0000:09:00.0: [drm] Using GuC firmware from i915/dg2_guc_70.bin version 70.36.0
> [   10.719989] xe 0000:09:00.0: [drm] *ERROR* GT0: load failed: status = 0x800001EC, time = 3297ms, freq = 2400MHz (req 2400MHz), done = 0
> [   10.732106] xe 0000:09:00.0: [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x76, UKernel = 0x01, MIA = 0x00, Auth = 0x02
> [   10.744214] xe 0000:09:00.0: [drm] *ERROR* CRITICAL: Xe has declared device 0000:09:00.0 as wedged.
>                Please file a _new_ bug report at https://gitlab.freedesktop.org/drm/xe/kernel/issues/new
> [   10.828908] xe 0000:09:00.0: [drm] *ERROR* GT0: GuC mmio request 0x4100: no reply 0x4100
> 
> Correct this by defining `GUC_ALIGN' as `SZ_4K' in accordance with the
> references above, and revising all instances of `PAGE_SIZE' as
> `GUC_ALIGN'. Then, revise `PAGE_ALIGN()' calls as `ALIGN()' with
> `GUC_ALIGN' as their second argument (overriding `PAGE_SIZE').
> 
> Cc: stable@vger.kernel.org
> Fixes: 84d15f426110 ("drm/xe/guc: Add capture size check in GuC log buffer")
> Fixes: 9c8c7a7e6f1f ("drm/xe/guc: Prepare GuC register list and update ADS size for error capture")
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
> Tested-by: Haien Liang <27873200@qq.com>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Shirong Liu <lsr1024@qq.com>
> Tested-by: Haofeng Wu <s2600cw2@126.com>
> Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
> Link: https://t.me/c/1109254909/768552
> Co-developed-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  drivers/gpu/drm/xe/xe_guc.c         |  4 ++--
>  drivers/gpu/drm/xe/xe_guc.h         |  3 +++
>  drivers/gpu/drm/xe/xe_guc_ads.c     | 32 ++++++++++++++---------------
>  drivers/gpu/drm/xe/xe_guc_capture.c |  8 ++++----
>  drivers/gpu/drm/xe/xe_guc_ct.c      |  2 +-
>  drivers/gpu/drm/xe/xe_guc_log.c     |  5 +++--
>  drivers/gpu/drm/xe/xe_guc_pc.c      |  4 ++--
>  7 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index b1d1d6da3758..7ff8586f1942 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -91,7 +91,7 @@ static u32 guc_ctl_feature_flags(struct xe_guc *guc)
>  
>  static u32 guc_ctl_log_params_flags(struct xe_guc *guc)
>  {
> -	u32 offset = guc_bo_ggtt_addr(guc, guc->log.bo) >> PAGE_SHIFT;
> +	u32 offset = guc_bo_ggtt_addr(guc, guc->log.bo) >> XE_PTE_SHIFT;
>  	u32 flags;
>  
>  	#if (((CRASH_BUFFER_SIZE) % SZ_1M) == 0)
> @@ -144,7 +144,7 @@ static u32 guc_ctl_log_params_flags(struct xe_guc *guc)
>  
>  static u32 guc_ctl_ads_flags(struct xe_guc *guc)
>  {
> -	u32 ads = guc_bo_ggtt_addr(guc, guc->ads.bo) >> PAGE_SHIFT;
> +	u32 ads = guc_bo_ggtt_addr(guc, guc->ads.bo) >> XE_PTE_SHIFT;
>  	u32 flags = ads << GUC_ADS_ADDR_SHIFT;

these probably deserves a separate patch? or at least an explanation in the
commit message?

>  
>  	return flags;
> diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> index 22cf019a11bf..b3d049bdc047 100644
> --- a/drivers/gpu/drm/xe/xe_guc.h
> +++ b/drivers/gpu/drm/xe/xe_guc.h
> @@ -23,6 +23,9 @@
>  #define GUC_FIRMWARE_VER(guc) \
>  	MAKE_GUC_VER_STRUCT((guc)->fw.versions.found[XE_UC_FW_VER_RELEASE])
>  
> +/* GuC really expects command buffers aligned to 4K boundaries. */
> +#define GUC_ALIGN SZ_4K
> +
>  struct drm_printer;
>  
>  void xe_guc_comm_init_early(struct xe_guc *guc);
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index 131cfc56be00..6b5862615fd7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -144,17 +144,17 @@ static size_t guc_ads_regset_size(struct xe_guc_ads *ads)
>  
>  static size_t guc_ads_golden_lrc_size(struct xe_guc_ads *ads)
>  {
> -	return PAGE_ALIGN(ads->golden_lrc_size);
> +	return ALIGN(ads->golden_lrc_size, GUC_ALIGN);
>  }
>  
>  static u32 guc_ads_waklv_size(struct xe_guc_ads *ads)
>  {
> -	return PAGE_ALIGN(ads->ads_waklv_size);
> +	return ALIGN(ads->ads_waklv_size, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
>  {
> -	return PAGE_ALIGN(ads->capture_size);
> +	return ALIGN(ads->capture_size, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
> @@ -169,7 +169,7 @@ static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
>  
>  static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
>  {
> -	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
> +	return ALIGN(ads_to_guc(ads)->fw.private_data_size, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_regset_offset(struct xe_guc_ads *ads)
> @@ -184,7 +184,7 @@ static size_t guc_ads_golden_lrc_offset(struct xe_guc_ads *ads)
>  	offset = guc_ads_regset_offset(ads) +
>  		guc_ads_regset_size(ads);
>  
> -	return PAGE_ALIGN(offset);
> +	return ALIGN(offset, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_waklv_offset(struct xe_guc_ads *ads)
> @@ -194,7 +194,7 @@ static size_t guc_ads_waklv_offset(struct xe_guc_ads *ads)
>  	offset = guc_ads_golden_lrc_offset(ads) +
>  		 guc_ads_golden_lrc_size(ads);
>  
> -	return PAGE_ALIGN(offset);
> +	return ALIGN(offset, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
> @@ -204,7 +204,7 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
>  	offset = guc_ads_waklv_offset(ads) +
>  		 guc_ads_waklv_size(ads);
>  
> -	return PAGE_ALIGN(offset);
> +	return ALIGN(offset, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
> @@ -214,7 +214,7 @@ static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
>  	offset = guc_ads_capture_offset(ads) +
>  		 guc_ads_capture_size(ads);
>  
> -	return PAGE_ALIGN(offset);
> +	return ALIGN(offset, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
> @@ -224,7 +224,7 @@ static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
>  	offset = guc_ads_um_queues_offset(ads) +
>  		guc_ads_um_queues_size(ads);
>  
> -	return PAGE_ALIGN(offset);
> +	return ALIGN(offset, GUC_ALIGN);
>  }
>  
>  static size_t guc_ads_size(struct xe_guc_ads *ads)
> @@ -277,7 +277,7 @@ static size_t calculate_golden_lrc_size(struct xe_guc_ads *ads)
>  			continue;
>  
>  		real_size = xe_gt_lrc_size(gt, class);
> -		alloc_size = PAGE_ALIGN(real_size);
> +		alloc_size = ALIGN(real_size, GUC_ALIGN);
>  		total_size += alloc_size;
>  	}
>  
> @@ -647,12 +647,12 @@ static int guc_capture_prep_lists(struct xe_guc_ads *ads)
>  					 offsetof(struct __guc_ads_blob, system_info));
>  
>  	/* first, set aside the first page for a capture_list with zero descriptors */
> -	total_size = PAGE_SIZE;
> +	total_size = GUC_ALIGN;
>  	if (!xe_guc_capture_getnullheader(guc, &ptr, &size))
>  		xe_map_memcpy_to(ads_to_xe(ads), ads_to_map(ads), capture_offset, ptr, size);
>  
>  	null_ggtt = ads_ggtt + capture_offset;
> -	capture_offset += PAGE_SIZE;
> +	capture_offset += GUC_ALIGN;
>  
>  	/*
>  	 * Populate capture list : at this point adps is already allocated and
> @@ -716,10 +716,10 @@ static int guc_capture_prep_lists(struct xe_guc_ads *ads)
>  		}
>  	}
>  
> -	if (ads->capture_size != PAGE_ALIGN(total_size))
> +	if (ads->capture_size != ALIGN(total_size, GUC_ALIGN))
>  		xe_gt_dbg(gt, "Updated ADS capture size %d (was %d)\n",
> -			  PAGE_ALIGN(total_size), ads->capture_size);
> -	return PAGE_ALIGN(total_size);
> +			  ALIGN(total_size, GUC_ALIGN), ads->capture_size);
> +	return ALIGN(total_size, GUC_ALIGN);
>  }
>  
>  static void guc_mmio_regset_write_one(struct xe_guc_ads *ads,
> @@ -967,7 +967,7 @@ static void guc_golden_lrc_populate(struct xe_guc_ads *ads)
>  		xe_gt_assert(gt, gt->default_lrc[class]);
>  
>  		real_size = xe_gt_lrc_size(gt, class);
> -		alloc_size = PAGE_ALIGN(real_size);
> +		alloc_size = ALIGN(real_size, GUC_ALIGN);
>  		total_size += alloc_size;
>  
>  		xe_map_memcpy_to(xe, ads_to_map(ads), offset,
> diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
> index 859a3ba91be5..34e9ea9b2935 100644
> --- a/drivers/gpu/drm/xe/xe_guc_capture.c
> +++ b/drivers/gpu/drm/xe/xe_guc_capture.c
> @@ -591,8 +591,8 @@ guc_capture_getlistsize(struct xe_guc *guc, u32 owner, u32 type,
>  		return -ENODATA;
>  
>  	if (size)
> -		*size = PAGE_ALIGN((sizeof(struct guc_debug_capture_list)) +
> -				   (num_regs * sizeof(struct guc_mmio_reg)));
> +		*size = ALIGN((sizeof(struct guc_debug_capture_list)) +
> +			      (num_regs * sizeof(struct guc_mmio_reg)), GUC_ALIGN);
>  
>  	return 0;
>  }
> @@ -739,7 +739,7 @@ size_t xe_guc_capture_ads_input_worst_size(struct xe_guc *guc)
>  	 * sequence, that is, during the pre-hwconfig phase before we have
>  	 * the exact engine fusing info.
>  	 */
> -	total_size = PAGE_SIZE;	/* Pad a page in front for empty lists */
> +	total_size = GUC_ALIGN;	/* Pad a page in front for empty lists */
>  	for (i = 0; i < GUC_CAPTURE_LIST_INDEX_MAX; i++) {
>  		for (j = 0; j < GUC_CAPTURE_LIST_CLASS_MAX; j++) {
>  			if (xe_guc_capture_getlistsize(guc, i,
> @@ -759,7 +759,7 @@ size_t xe_guc_capture_ads_input_worst_size(struct xe_guc *guc)
>  		total_size += global_size;
>  	}
>  
> -	return PAGE_ALIGN(total_size);
> +	return ALIGN(total_size, GUC_ALIGN);
>  }
>  
>  static int guc_capture_output_size_est(struct xe_guc *guc)
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index b6acccfcd351..557c14b386fd 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -223,7 +223,7 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>  	struct xe_gt *gt = ct_to_gt(ct);
>  	int err;
>  
> -	xe_gt_assert(gt, !(guc_ct_size() % PAGE_SIZE));
> +	xe_gt_assert(gt, !(guc_ct_size() % GUC_ALIGN));
>  
>  	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", WQ_MEM_RECLAIM);
>  	if (!ct->g2h_wq)
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index c01ccb35dc75..becf74a28d90 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -15,6 +15,7 @@
>  #include "xe_force_wake.h"
>  #include "xe_gt.h"
>  #include "xe_gt_printk.h"
> +#include "xe_guc.h"
>  #include "xe_map.h"
>  #include "xe_mmio.h"
>  #include "xe_module.h"
> @@ -58,7 +59,7 @@ static size_t guc_log_size(void)
>  	 *  |         Capture logs          |
>  	 *  +===============================+ + CAPTURE_SIZE
>  	 */
> -	return PAGE_SIZE + CRASH_BUFFER_SIZE + DEBUG_BUFFER_SIZE +
> +	return GUC_ALIGN + CRASH_BUFFER_SIZE + DEBUG_BUFFER_SIZE +
>  		CAPTURE_BUFFER_SIZE;
>  }
>  
> @@ -328,7 +329,7 @@ u32 xe_guc_get_log_buffer_size(struct xe_guc_log *log, enum guc_log_buffer_type
>  u32 xe_guc_get_log_buffer_offset(struct xe_guc_log *log, enum guc_log_buffer_type type)
>  {
>  	enum guc_log_buffer_type i;
> -	u32 offset = PAGE_SIZE;/* for the log_buffer_states */
> +	u32 offset = GUC_ALIGN;	/* for the log_buffer_states */
>  
>  	for (i = GUC_LOG_BUFFER_CRASH_DUMP; i < GUC_LOG_BUFFER_TYPE_MAX; ++i) {
>  		if (i == type)
> diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
> index 68b192fe3b32..5a69b5682fc8 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pc.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
> @@ -1190,7 +1190,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
>  {
>  	struct xe_device *xe = pc_to_xe(pc);
>  	struct xe_gt *gt = pc_to_gt(pc);
> -	u32 size = PAGE_ALIGN(sizeof(struct slpc_shared_data));
> +	u32 size = ALIGN(sizeof(struct slpc_shared_data), GUC_ALIGN);
>  	unsigned int fw_ref;
>  	ktime_t earlier;
>  	int ret;
> @@ -1318,7 +1318,7 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
>  	struct xe_tile *tile = gt_to_tile(gt);
>  	struct xe_device *xe = gt_to_xe(gt);
>  	struct xe_bo *bo;
> -	u32 size = PAGE_ALIGN(sizeof(struct slpc_shared_data));
> +	u32 size = ALIGN(sizeof(struct slpc_shared_data), GUC_ALIGN);
>  	int err;
>  
>  	if (xe->info.skip_guc_pc)
> -- 
> 2.47.2
> 

