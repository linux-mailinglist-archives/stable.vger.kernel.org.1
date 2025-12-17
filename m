Return-Path: <stable+bounces-202896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 433BCCC977C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854673026AB9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC0263F52;
	Wed, 17 Dec 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm97slvB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02953A1E83
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766002721; cv=fail; b=Kopk5+w3jfMUQIfx8zRy0eVJOFonR8iJiX4KtMeNMVoWrQRDepRFhwQEvNxx3d7mue6MK7Uq43jAzcH2Eg2ryW7ELv5PpdIGnMaHHn/58JGcNV6PvrHudUTRX6WOum2f1W9/a5RamU1Wlp8WRoRnKvbal3j/S23gkPUxH2ikPDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766002721; c=relaxed/simple;
	bh=y2XspXxGXhWtE42LV4z/cM4R2eDkZ4WetYJJW+4MJak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LQ8Uq+6uyWY0wv7UcfP7CR7NfAXDOm/zDx3MPvnNyjjHvbH8osPb8PlOxheCvipy5IYtES7qe3DbOCMFl9rBKPulDP3vhBnVHADK/3LnnLHPl6geZjboEEytwnfQbkxiUlZFd9GyL83ptLhWIwBnNDnEZtGSfqVB27iUJv4mAHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jm97slvB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766002719; x=1797538719;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=y2XspXxGXhWtE42LV4z/cM4R2eDkZ4WetYJJW+4MJak=;
  b=jm97slvBTBXg/LtV7vVmtUHUQPahMm1r8aMYhzJcSN+2/23WDK0QM/RT
   9A+Pv40jN2cXhelhfmcgPxTgT3c/g8gR+FaJHtLbAHfvmi0TY+N2MkwOl
   UvfyQcOt2DXQMHobG0hmVqAVaEFoljPYuwI72arpJQY5DM/02us5erjWZ
   /67bMSHCr0p454jqD6LdD4aE+xyGhL1Jsobgx5Qel0JzZOylOH/8Xa8jg
   hldkxs+Bqe333/3crsn1VLat+nks8WJGXhGR+ZxI2ooSkKmr6U3Pyz85V
   6Q+d4BUj4fAmVwEgUv+7xCrPAKkpSFooXjcyNEyB7Y/fffNWlCb6/6cld
   w==;
X-CSE-ConnectionGUID: M7Wp95v8RUeG9/1kMNaytw==
X-CSE-MsgGUID: e0NohpzNS9uzqa8hWZSm/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85374150"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="85374150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 12:18:38 -0800
X-CSE-ConnectionGUID: BdbqQH9HTFCqSRtvRFk5DQ==
X-CSE-MsgGUID: eHM9swgwSR2+NDeLl/9vmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198003744"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 12:18:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 12:18:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 12:18:37 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 12:18:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXokBwORKVSjVBMO0KyJ12uQnKpLU4dAErmMmkMbmgC4ZUD/SYIGYqY7YSEqyRaFOpWELYaDSczt71/AuodpzEr0lR+97pIFj9Ziph85OzlJ9ZFjAHccG9JN8MrfgWHE42tfoGpfuidINqdNwiDOTTtuEPrOufyDn50hY6DpFEXD/uO7hAijrm+vs+WAB4cT136oIcofn7H7RPvbXp9wlmfqXB2+Tevh+UTC8sm+qB49se8BZwRE55CHIOkRwZFKevEA5udobt9JxKnThax9empfI23LEelj9cVB29r+R9kQCEbHlwZaX/inf153j4vNnGK8s5fuwjp1jbPVvbhEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF4B03LoClluZKMBtlDDaPgeZ0iec3UFix1xbS0qHmQ=;
 b=KSdoBZ7/7M4Ri9t4vf6b/ovtRciW+7URkosGQjgP8nXVzQD1DixTv77cwrMgx9AX5BaJaJXXyG4pLppwQ6REfCzOASALHywcXgtY2JfKQJqJNc9PTFbzKk/kCPnnGf9A7vdVP1/4B4ytKRhguyW0njJXIY/rYo52vi/y9NxYWvwCM1rQUks3Ovaz+F5rvPbLZ8N46inHIgQb64bGxSoGcTn09BxxPsO25d+e4fB4jV3/LEfz+rqkoPTZ+BIKonfFKVtN69Rxb1S93piqn4SjfkSS8af9Rjcivo9tZW5M7oefNUgQMvngRZvjLURnNiVaqWvQlF/zL5ivbN9Fu7PxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:18:35 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:18:29 +0000
Date: Wed, 17 Dec 2025 12:18:27 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Drop preempt-fences when destroying imported
 dma-bufs.
Message-ID: <aUMQE1wZd4k7j2Kw@lstrano-desk.jf.intel.com>
References: <20251217093441.5073-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217093441.5073-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 473da06f-580a-4b85-e916-08de3da97126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2hiSEFLWGJORDJkWUxyRzZhZlQzbjZDSTVBa3JsMU5SWGZNc29VK2FHMHlE?=
 =?utf-8?B?RVpMUFpTT2R4NS82RjRML3RPV2VROU5BS1U4TElUWS9GRkVlV0hIUFNjOFp2?=
 =?utf-8?B?UUlsVWVqOFk0WjRvYTdPOGJrcC8zMTNORDNwb1ViYk9Yb3ExSmhKOXhDMEJ1?=
 =?utf-8?B?MVdZRW5yR0t5eTZQU25MWDlBd2E2dU1hQVRha2hobzR5RmlWZ1lRVnFscEdY?=
 =?utf-8?B?UGgwYnBmSDFGYmhidlh1WXhhS3BNWnA3cElVSUh5RnJKNGNhbUM1U1dyblV4?=
 =?utf-8?B?MkoyVGUzOXBqNFNnb09CNGxPZVhndlozV3ZGekZ0Wm9iZnJSRTJ2WktCY3o4?=
 =?utf-8?B?a1FMWW1nd2NISUtLTzMvVDNlbE12QXNMNFRQYUFVUGJJang1eC9QWU1nNGFw?=
 =?utf-8?B?d2FwREdIMklHZ2ptOW15MnNucmFwbUdINWlrbm1Yb2R1UXFZQUlNYkdkb25r?=
 =?utf-8?B?QXl0MmhHU3ZIcEN0ZEUvdmtnQmN5Q083UXhhaUo0b3l5RURCZm5XMTZXM3F1?=
 =?utf-8?B?WlEyRlNDTHNFZ2lzWVl6emFXNWhEdDI1RU5NR3FZemVyZUdaa1ZmdnRiQSsv?=
 =?utf-8?B?MnZ1MU5iOXhla1JKZituSHAxWTVLaUZzVTAwb3pkZFhvQ3FVRXp1c2hUcjlM?=
 =?utf-8?B?MmFTa3pscnYxUm1LcHByUm05K0FCYU5tWlVzWFVXMmVONUwvUzhUVFNPTzNi?=
 =?utf-8?B?THpiSVp4a0kzL0ZONXhvV0Y1ZnNzTkM2SmdmTnJnU3A5WC8wcVhHV3VRSnZv?=
 =?utf-8?B?cWhBR1J1ZSttWVJvZ3pGVlpwWFVwa2pValF5L0p0NUJneUNuYWdLQ2lLVlor?=
 =?utf-8?B?alBMOFIrRWVCdWlWcnB1V0pxSVhuTWF3V281cjB0cnlid3o3bXpEbzhYdDAv?=
 =?utf-8?B?YkFHZDh6eVFjVmxHSUIrTkovMW1JTWVlY1B4VWdqYkJZbHBCTmxkNUF3WXpZ?=
 =?utf-8?B?eXlwdm9vdVZkL3Bwd1BHR0ZqK3dVV0d6UVJKdUgvdm1IeTM5Ym1PR0RmYk0w?=
 =?utf-8?B?Ym11T00welVVV1VDNFRvRzZDeDBCSWU4RHpxOWVuZFdaWi9rSkVHbElmMUo4?=
 =?utf-8?B?VVAzd0hONUVrZmNVdFV3Yko0a1BGOEgyK3FMSWxOSzNpK2xLRVlFT01pRjRk?=
 =?utf-8?B?ZmNVTGhIOE1XcFM3VWNqdVdDN28xb1ZYd2ZGa1pxNlp0NXlEa0Yxdm1WMFNI?=
 =?utf-8?B?UnZyaUhibU5sWitZcURIOUxHTytCcmpsSS95QmNHbTN4ZWRVMkdDcnRyRmZR?=
 =?utf-8?B?WW5IakxjeXRRN20zdEk4SDdzNC9KNnZEcGZXZHF6K3gyMG9PdGJtRjVlU2pJ?=
 =?utf-8?B?ZjdqQ3FGaVl2aytBUnJoMzhOVXBtQlNRd0lKK2tDaFdIdmF4TnFBVmNGUGs0?=
 =?utf-8?B?UEhIVjJHdXMzbnFFbWljdnVlNHJJalBLZkdGM3ZWV0V6N1ZnS1ViT3JqTGVR?=
 =?utf-8?B?cFd1NkJPejZqSXlya0JROTNqWUprenhnaTF0RnQxdlhiUkdkZDUzQW1mRlg3?=
 =?utf-8?B?MlNQNHczWW5iWjE0S1FoTTNKMlpSN20rM01zQkZDV0VuVVZKcTU3YU56ZlN0?=
 =?utf-8?B?YTl3dlhENUYvRGpnWVFlNStMTVBISU5wTWhVNUpzUVFNK2gvK3F5NXkyV3M5?=
 =?utf-8?B?Nm02aStFaTRKQ1FZR2kzUGNyY0lZV2lMdHd4bjBBc055T3ZWRkQ1c2VwbmE3?=
 =?utf-8?B?YVRkWEtrK21BWWtWU1cybjBvcVY1ZTB4VVQzZVREWWtpaGphMC9QaHJwYS84?=
 =?utf-8?B?Z3h0WE0zdXBXRHdqa045Z2JaaFdaTHk4RkR0UUg5amo0YjdVbDRXUDNvK0d4?=
 =?utf-8?B?YmoyWmFCY0xXQzJhMWsrSVpyTEhEVFZTY1NnblZBOHArNitmbzJmVFg2SVRr?=
 =?utf-8?B?eFl4ZG1QZjh4LzVLbHQvUzNYM1lwc3NvM0ZsaTVLTWg4YnZ4ZlhrUFBmMElT?=
 =?utf-8?Q?7FB0FVv7xGoYD8Fpb7NqoMJ0i6beejsX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVKMkRobUh4WGd6NmxZejhsZmdRZ1VjWmsyN1JQSjArVFFWM3hrQkxua09y?=
 =?utf-8?B?N0FRT2pVNzFiRTRRUHJKdFVKellqQ0FDdWhQZDVLLy9pS2R3OUhWNUZmUmx1?=
 =?utf-8?B?a242eUNScFBCNlhLWUdueUIrYW1RWTc1eVFoM1dYM2FoMjRGc2Fib2dRak1V?=
 =?utf-8?B?TkgrZEdWU1JrcjRGSEY2UFFtR204STBiQTZqR21RQStWN1hONFFoWVFmRlpB?=
 =?utf-8?B?MXRYc0QyTnJKaGhXbTIwRkFHWUdPTUFIRkVoY0hINlhocVYwZVU0bWdZbDlR?=
 =?utf-8?B?dGRlREE5UDgyclUxTCtEVzZNcm1SZkZ0N3dRQVZqcEpJYm85OTFaT3dzYm1r?=
 =?utf-8?B?UzNBQVlsUUgwczJBSzV3b2VPdDZCUTc4S2Y3YndyMHVLQ2drZlMrQlc5Yms3?=
 =?utf-8?B?c3N5dmw0MFdWR3MvQkNDSkc5QlZReXlmQ04xazJ3Y2RzUllycTJiTFJJd2F3?=
 =?utf-8?B?ckxXTnFoMjFFSy96d1VBbEtUbndlNFVMcTBHVDJUSXBBcFpQR3ZVdFZXRkgv?=
 =?utf-8?B?Rjc3YWZ6a3lrNU9wMkpQYnFHNVpaZEQ0ZjRRUnJ3dGg4RXo4ZGRwc0VTeGw0?=
 =?utf-8?B?TG8zL1FUM0ZyU2RuaktJWHBKTW1SRENnL24wajlJMVBoTzhjL29rZUZHdHNE?=
 =?utf-8?B?Vlh0Y082TnpyaTFreWFqZmRaaHpVbHlKZStEOStZdFE5dGI0UzRiQjhPRlE5?=
 =?utf-8?B?U2grNEluVXY5c0tLZzIzSkl6Zjg1TForcUJIb2dpTjk3VmpsUTlCbHJnaEhv?=
 =?utf-8?B?eldvL1E5Y01JQWRua0xUZ2NWcW1xZ1kwMkVzVFVMeDBVMUNSdWI3aWRkSkov?=
 =?utf-8?B?a2dkYUVzOTVBODF0cldmR0xvNmliVU1rcmV6QzdIWXVlaDNXZUZSdjkwdFcw?=
 =?utf-8?B?VHByVnlmVUxuS1dIZUFONTFmQkZJMm5JNmowZlRIc2M1OGZMaVlDeUs0QklO?=
 =?utf-8?B?UkpQT2o5eWx2OTF6Z2lpN1ZmYlhUZVhBTmFXdTNmZS9pN0VWcFczaThUcTcv?=
 =?utf-8?B?VS9iSm56WlpqaDU3V3FRZGsxUHdsRzM5YmptNUErdmtONm5nMWNkY1BSeFht?=
 =?utf-8?B?bmpUMEplVStsbGJFcENndlJBdTlRQ0ZLUFQxaG9DRG9yVWRFZjZCc2E5VVZx?=
 =?utf-8?B?RGhZOG9IMnNGQ2dreXBWM0s0TzlQdzdFTlQ0THhXTkljNUxxTjA5VlBRZEtT?=
 =?utf-8?B?OURKOWowREdUbFNPYWpXRW1HM29zdWdsdjBZTmhXcGxITUhsVDRrWWpJWU9m?=
 =?utf-8?B?NWNEUmNhcmhUWE5qckxpRUhJTlM5NzE3cHhSMDA0MTNDVHg0T3RPYVVWclJD?=
 =?utf-8?B?OTE5UWZjQU5zVXIvM3lGUm5kUERtMUtLY2xZQkJPMk5FU1Y4MUZ6TkU2dFNE?=
 =?utf-8?B?MTYySlRjQWhDVFZLbC9VeEZnaVJhS0hheEQxVjF1b1ZwUFN2S3pIbCtVeE1D?=
 =?utf-8?B?YmVQQzcwZUE5VEVpeUo0OVZaNFNzY2lXTGVKY2Z3TlNFeDVzSDNCK0YzS3Uw?=
 =?utf-8?B?cU1WL2J6REZXVDJSdTRiY3VlTExmdTdlRkJhRndjQ3hxNWd1ZmlJY0czd1pL?=
 =?utf-8?B?enpaMDhJdnlBeVBUSWZYMi9jdHRnKzVhQmdzN1dieXQxQUtTRU9RYXFUZ2Ns?=
 =?utf-8?B?MEJxL2VJNjV1S3RyTmkzTGoySWRhaFlxcFhpWEFwKy9VcmgxZFFETmIwTUdM?=
 =?utf-8?B?QTI0enVuZkh0cDEwU0l1cUxkSjBFeVBRVXZiQmJRRzNWcUVVbEVlZDJaaGdI?=
 =?utf-8?B?cEl3U0dITDdIai9WaFR0RDROYVlhRXl1SE5XbTljRHNRQTdOMzhBa2NTWGFt?=
 =?utf-8?B?L2dhb284dkdicmx3dTRiT2xGVGVhaDhsSVN0cWVUc1lvTDNNNEtPNkpDaHAv?=
 =?utf-8?B?NzZ1eWk3dXRUdHdvOElyWG9RckIvbFJXZnBOUEpLRzBKdTJaaHBrVVRTSXNx?=
 =?utf-8?B?WkVTRnkydWxIMlhyRUlXYWpiMC80UEY5citLNlNaVXNic0FieW5VMUpCNExQ?=
 =?utf-8?B?NG1OZTMrcnh4N0JEdkFUR1ozT1lYbHNvWmlabWp6UmFQeUpacXk1SFI1cVN5?=
 =?utf-8?B?aDlsRDYwQjhTNkliQ0YzcVBXOXhOZG9pTjYyb1JCSkF1V3ozTWUwYjhwQXRz?=
 =?utf-8?B?UGhMRVVXTW9CTnBQN1E0Z3k2Y0gxNnpTcTN1cGo0bitkbElLTXN5am5za2wr?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 473da06f-580a-4b85-e916-08de3da97126
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:18:29.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJLQkVqB1qJGg7i/XcJ14nw9quWqzN/Czy/DoAG1eVcfi15+LnlAAOWGlDd2UXjYnph9dojrs+f5nRVjXFK+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-OriginatorOrg: intel.com

On Wed, Dec 17, 2025 at 10:34:41AM +0100, Thomas Hellström wrote:
> When imported dma-bufs are destroyed, TTM is not fully
> individualizing the dma-resv, but it *is* copying the fences that
> need to be waited for before declaring idle. So in the case where
> the bo->resv != bo->_resv we can still drop the preempt-fences, but
> make sure we do that on bo->_resv which contains the fence-pointer
> copy.
> 
> In the case where the copying fails, bo->_resv will typically not
> contain any fences pointers at all, so there will be nothing to
> drop. In that case, TTM would have ensured all fences that would
> have been copied are signaled, including any remaining preempt
> fences.
> 

Is this enough, though? There seems to be some incongruence in TTM
regarding resv vs. _resv handling, which still looks problematic.

For example:

- ttm_bo_flush_all_fences operates on '_resv', which seems correct.

- ttm_bo_delayed_delete waits on 'resv', which doesn’t seem right or at 
  least I’m reasoning that preempt fences will get triggered there too.

- the test in ttm_bo_release for dma-resv being idle uses 'resv', which
  also doesn't look right.

I suppose I can test this out since I have a solid test case and report
back.

Matt

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6280e6a013ff..8b6474cd3eaf 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1526,7 +1526,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
>  	 * always succeed here, as long as we hold the lru lock.
>  	 */
>  	spin_lock(&ttm_bo->bdev->lru_lock);
> -	locked = dma_resv_trylock(ttm_bo->base.resv);
> +	locked = dma_resv_trylock(&ttm_bo->base._resv);
>  	spin_unlock(&ttm_bo->bdev->lru_lock);
>  	xe_assert(xe, locked);
>  
> @@ -1546,13 +1546,6 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>  	bo = ttm_to_xe_bo(ttm_bo);
>  	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
>  
> -	/*
> -	 * Corner case where TTM fails to allocate memory and this BOs resv
> -	 * still points the VMs resv
> -	 */
> -	if (ttm_bo->base.resv != &ttm_bo->base._resv)
> -		return;
> -
>  	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
>  		return;
>  
> @@ -1562,14 +1555,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>  	 * TODO: Don't do this for external bos once we scrub them after
>  	 * unbind.
>  	 */
> -	dma_resv_for_each_fence(&cursor, ttm_bo->base.resv,
> +	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
>  				DMA_RESV_USAGE_BOOKKEEP, fence) {
>  		if (xe_fence_is_xe_preempt(fence) &&
>  		    !dma_fence_is_signaled(fence)) {
>  			if (!replacement)
>  				replacement = dma_fence_get_stub();
>  
> -			dma_resv_replace_fences(ttm_bo->base.resv,
> +			dma_resv_replace_fences(&ttm_bo->base._resv,
>  						fence->context,
>  						replacement,
>  						DMA_RESV_USAGE_BOOKKEEP);
> @@ -1577,7 +1570,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>  	}
>  	dma_fence_put(replacement);
>  
> -	dma_resv_unlock(ttm_bo->base.resv);
> +	dma_resv_unlock(&ttm_bo->base._resv);
>  }
>  
>  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
> -- 
> 2.51.1
> 

