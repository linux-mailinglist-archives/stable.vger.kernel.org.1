Return-Path: <stable+bounces-210791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PjCFD4NcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE7D5A8CD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02E4190FC87
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E3311C3D;
	Wed, 21 Jan 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmuZC9p9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8B30F52D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011676; cv=fail; b=RyBvcZLWK2TTrArPJMCbusIsigxRwgfkC1cMUoDWzP90kgqZNlDvbFaC+w08hUj6mwVNHAi9eIvKqQkSJvuOyS7Usxk6eT5P1OJ8TvpFRT9nPWJQxd66OkJOBZbuoZ5hms/EbUwA/awCJIQFe9xjUhz+NkFe+zZL6FjN3nP9WKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011676; c=relaxed/simple;
	bh=dzXwn5w8xzJze2oZI9Fr79qB1rw6kf13vEpbMMUIkOs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRoBrlPjXVfL5m2+nq9BGi5vIM04L7Y0hNzstqCp6NvknpgzSzazvVEqAoeFSorPM0p0n9jOWD3WmnDnXLKJKv1+y3GIB4ct47Pg5QIcw2cfXOQDKBXNsGO/52U7QdYEOayCjFHazaFBldHAMqDfo1ELPbWeib/nuVgqcdxxObA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmuZC9p9; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769011675; x=1800547675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzXwn5w8xzJze2oZI9Fr79qB1rw6kf13vEpbMMUIkOs=;
  b=DmuZC9p9VrOqtrSIOg+CmjfyagsJdt00azGbqnfLxnC89JS8jgMxhDSj
   BWuqnd1jDr9kjz1ibqX+2IJ0QTl9Ha1BFlFME1+Ef1+mW/dMPRsZbZL5w
   EHsx6BN8pxTX8ltd+bRga7jWesaJtvyZ0un/HUPInDLDd2UX0d0H1FU0d
   EwAzNiCRiBD0LzY+Pe/a5zsGHgX5shtFfjGD072xnnR3RH+MwzYWeT3tq
   m7zP+G6O8hh9jk1ML4Z3IlB3nV8sgSCG+OWphFwbt+aZdlNEE0T6nz7hY
   NNR+AweWNyl91mt72sm5lqww4rN8epA3s2KPZJMJUI6mQ/zq9+pw+EPrG
   Q==;
X-CSE-ConnectionGUID: gvGJIdiGRbCCiwWiP4Kh8A==
X-CSE-MsgGUID: 8UPZgcwKRH2VSVCgXzE4IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="72831421"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="72831421"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:07:54 -0800
X-CSE-ConnectionGUID: 8dFKpFokR9ih1o1M0q7fKA==
X-CSE-MsgGUID: h/XJINGvQeeGAbxtn8CDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210644268"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:07:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:07:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:07:52 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:07:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2wsG8urkGJxliFAJZ0Zbo4gS+30U+hsYwUWyacsAsSVSpVCRXo36kHtAZaL7/uA4SlHmkC/GsZLba8ovJXwC3fU4KdGRVaIdfKZBENlItv7idpxvlJeJ8VrJ55jFTRX7UtR9o/67IuEgbIG2wRDfu55JViDH755JHLyxaBNRfsQyYpypyV/cQsdQrNlOg2/4v0854Srb6lLjtnv2lpeioL3Kso6XcS+E9+zWp9VEXycJcopDQbp7XnIZ40B27X4rR7lZcfsb3+r04XVsowiIHnZVCbyjVOlVYTMUPeOve8ZgrnWAC74OyHx7Vwf/JpN9Tx5m8GDnMdp1sZP61+zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PiI42ydlj9IKkrhkTUD9IIpVS5D0Z6LZwrIUgbh5vY=;
 b=F18qoZ0O0kTCWu/Krup1Wz4lLjO2BhIOTQ5ORCevQAxHJa4r2fP/rJDclNTvXMtQVfLRn/zcZc+qLHRAn/m76rsynqPN87CpfrWhMfWbLHNizvqibU60hmcxbbxK4k46X3utUmcLiz3zI3QwZz5IvtlxcEA/Pm4qXDwtjRX8sbW2+Rc1yUjNRrJu+c1zCl4jz8fh8BW5V6FJyeYsOJ+pEPIcegGtEDSlTRuxSMWcoLby0dhcFVljs6m5NJBlrSKq/dXWHSuvBmZDp/PZT0zZw4JYxvbL6QxDv/LdAagsd1YHuNgKi6VNSLM8bHpruNQVZ7nnnau3oos0Z4+oMAsi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:07:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:07:51 +0000
Message-ID: <7a7bfbf5-b7c5-4613-91a4-161f0bfb3130@intel.com>
Date: Wed, 21 Jan 2026 08:07:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/2] x86/resctrl: Fix kernel-doc in internal.h
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, Borislav Petkov
	<bp@suse.de>
References: <2026012056-existing-collide-49ad@gregkh>
 <20260121025738.1158111-1-sashal@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260121025738.1158111-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 333e8399-ba33-4316-2768-08de59073a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWNhQ1lWYjVReEM4UXJWN29wd0VFZG1SZ3ZoVVNPcjBpVWNST25ib2hsdkI5?=
 =?utf-8?B?R2NsbHJzQ3NFa3hZNjJDb2ZtMjFVWjFrcmdmaFhNODlHQmhoanNQNDBMTng3?=
 =?utf-8?B?SW9XMWYzY05TdjJBY2dFMDF1aXdBUlNGYy9KS1R0L00zVFluUDZSQXlBR29i?=
 =?utf-8?B?dm9haWttQzlOQ3A3VHh1WDU5V21jVFJZaTZEa3haaCtRSGkydFpoMEZqOGl0?=
 =?utf-8?B?VHBsNVJGeGJUS0p1NVVGeUlWcmVrVHpZVU1VVzU2aUtXbUMrUTdjUkFnL0I2?=
 =?utf-8?B?SjNHVGRaNmZKV1ZUSlA5QmxuMTJuNkQ2a1U3ZFd5T1l1U21GNzZTL24rejZj?=
 =?utf-8?B?dnUxMmkrMFBydi9xaG9WbmVuZGJHNkFxZEg5VGlLNnFYR3YrUHJJMmxaWXVI?=
 =?utf-8?B?SDg1cFZRUEp0emhRUnhRY0l6TUdWc3hDekpqREdHZXhJaDFIU1l6RHltR2xE?=
 =?utf-8?B?MnlveS9nTElUOXJsZUFjUENYSFh1bjRid1Z2b1BOSENJOCs5TE5VeU9FdHlM?=
 =?utf-8?B?a1l4bjhSekl5Ynlnci91VG9oVDg5bC82b3djVUcydkxtOU5KV2tHZVcxMkdz?=
 =?utf-8?B?Wm1UdGlBV0UxQXN1Q3E1NkZ1RjJEMjRHeFo0WGxqSTVaQ2kyY2ZUd1hGV1o0?=
 =?utf-8?B?SFRWd1E1RGJiRzRxYzlYTXVOMWpYWjc0L3JVTXRaUUo2TWRQdTRDL0tCT1Nl?=
 =?utf-8?B?SHR2TnNMakFXV2w1SjFvWlNuQTFTWGxkWjdxL3RzRmNXVTdWYUpQY2ladi9p?=
 =?utf-8?B?b3AxSjVoeHZidFlZKy9FSU9sbDQ0Q2Nid2FNMEQ2eHVhM3NLeExxQTZVTXNI?=
 =?utf-8?B?RjdkUVFuWlNjazEvK1YxOXZSZWMzNnZtZVVhRE9pL0lZZVlmdDVVRzZFYlVl?=
 =?utf-8?B?RXMvQklFY0ZBcGhMRzZpVG44aHhYVGZqeU10NHFWVWRpMk5zdlphMkhsQjlI?=
 =?utf-8?B?eTRFUFg0dVk1dXNuRFErbmhjQ3NDbWxWcWZSZmNOMHFFRUk2TFp4M1lUUk8x?=
 =?utf-8?B?V3R6dnBvQ1VUblhMblgrL0xzdUlSV1hKV3RSaW5PUEtSZ3ZTTmZPN1dFRkpO?=
 =?utf-8?B?QmF2RkczcVllM0JMcGQzQmQydFM0MDNleXNsZDBzQitrVnprN3dCTk50MW9k?=
 =?utf-8?B?VEhkNWlCWm5CenU3QUpWcEtOMGIvbDg4Ti8zdnUrRXZLSVMzaWVPT0htaWwx?=
 =?utf-8?B?SFVBbi9qZGZEWE9BbGdVTHVoSFlrM1VseGh3Wis3bWVyYXhOa3k3NW9HaUVF?=
 =?utf-8?B?R1hvWkRyM2ZVcFF3ZnkrcS9vNmFhNmhlMVd1bmx0aEpCcFFucjdNbVNZNlg1?=
 =?utf-8?B?cFQ0MURUbDI2MHZxMUV3WGlMM1pqZHJhNkNZWWtiMTI5UHQ0QVh1RUwvUkhx?=
 =?utf-8?B?QitEM2dVNTJzNEx0V3Yxb2tycHdoVGdNc29PaVFaa3dkY1h4QXJhbXZ2R01T?=
 =?utf-8?B?ckJKamkrdnd6UERJbkNabGpBTndDVmZKWlVpeVlCUDBDWTAxdlRCNkQ0clNM?=
 =?utf-8?B?NUxZbVhPLzQvbksrbmFHRXpVTjFGOHZzaU5VS2dQUC9SUGZKUVNncmlldmV2?=
 =?utf-8?B?S0JWSy9QcktFTnhZR1dlckwyWjFQTWR0OVBDYlRTZGRYK1N0Nnc1UDlMNm5P?=
 =?utf-8?B?VmYrQWxCTkVabmpqNXpueGJzOXJBNWgrUWJTWnYxbUZLY3FOQ2xpSjZnSklS?=
 =?utf-8?B?Vit4blcrT09maVMvdzRoMkRldlFqbG1lcmdTNFBvUlBLRTVsUVhud2VjOEhP?=
 =?utf-8?B?QjFYb2VkR2lyckNJS3didE9ScVhXeWxyR2IvVHoxMkVuU1E5eG1tbnFDemw2?=
 =?utf-8?B?TVZ6c3NFWldnVjNOTTVmeURzWmVsWGFCcWJJYXd6QmY1c0VnbGFlMlV6cnBh?=
 =?utf-8?B?MUJGZTJkVWJqd2tVK2x3RWYyc3JxdE5EenVCNXJZKy8yd1k4QStSZ2hmUjVH?=
 =?utf-8?B?cHMxL3lLNVVUb3FZRXhJK1UyRjJUalZlYnRjMWdmZFNleWY0YUlMclRWaXA1?=
 =?utf-8?B?RGlHYmtSUGNlRlpqb0ZCdkpySGR3dEp3NStHZ1AydG5JNHA3TlM1N0xVdFZ1?=
 =?utf-8?B?MWRNais4MFJjWGNYZHg4TEJwUnFyQ1dMdjJxMGtocmlMT3lGWmtXRFJnanZQ?=
 =?utf-8?Q?S2xI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFhK3lzUFFjdkNja3JxREp6L3dEakRYdHlrRFJoZXBOWW1salRlQkVOQ1Vi?=
 =?utf-8?B?NzRISnU3OFp5WGNzWWJwR2srYnVhQS96RndUZFhWcnJIdURwM3hOdUF0Tkd4?=
 =?utf-8?B?MDl3T2grYkx6S2I4OGU5bi8wWjVIM3cxeHdwdEJZbDVTbkNpbEFCOER0cnNt?=
 =?utf-8?B?ODk3MjFUbzBYYUdOS2VzdnFyVWtTM25jczZuQ0daMEQra0F2MFlhN1RZOVJI?=
 =?utf-8?B?b0xMQ3NMUDNJdjlINVd2VWRiRXFYZmNDQVB2UzVhT2wzM2pScG92ZWxCbk15?=
 =?utf-8?B?V1ZKeVBDWTJ0bW5BV3YrNjI2bXJqS09Ia1hzUVZzalNMamN3dXl5VGtuTjZS?=
 =?utf-8?B?Rm9PV1ljdysxM3Z4TjNIa0hBalNHQ052dTdNVi9mMEw0RkZhS3JNOVcra0JF?=
 =?utf-8?B?QlVQbHBDc2dOQVM0SFJrb3VmZUtqQ0dXQVlBdDdIOWxlQWpjRlRVMHdGSXFq?=
 =?utf-8?B?TW91WlF3Wm1KeGh6YjhweDVYaG9hOG13dUk0Q1V3UDBJQ1NDWFN6am9SYXBH?=
 =?utf-8?B?S0h6NTZBbW1BWlhSaDFDQVgrNldTNE5vVFJnb0xkSzJZSlhBSVBqdC92YWwy?=
 =?utf-8?B?ZEY3dk9RajQ1R085M2l4aW1nNkdhVVdvWlFqVWRkOE80alZUZXUwSllrbmsv?=
 =?utf-8?B?OVQ5VjFVWWFTU1dxeHh2OG9tQ3pSK3dKd2hJUWVST3N5UHhtWGFVRHhwbG5N?=
 =?utf-8?B?VG0xYkNCYXJlS2tkbU9tNWxObU5JNmlkeTMxTjUzZ1NyMDJZWU4xbGQ3alQ3?=
 =?utf-8?B?d0ZTdUI4aUw4Zi9rTi94TkZCY1VmSUpBVEw0M0U0ZHhZd2ZxeEhNUC9UZVQ0?=
 =?utf-8?B?Y2lPajltRUI3L09vcktvQi9KcDZkZjFtVGMxaFIzaUswMmdyRUtNandoVTZ2?=
 =?utf-8?B?cDZISi8zUmZhVURXS0dpSGtKNnUzTHlvbURNaXFjMXpyYkNKakJBbFhvQ0cv?=
 =?utf-8?B?dmVuMGFZOXl0Nms5UUhwTmNPdWJlUFNQU2ZHbFpmV3hiZnJZNXBmVEFGaUR5?=
 =?utf-8?B?TVlVeTd5bWd4bWU4cDBkM1BmcDdQQ0dla1FYWVhsUmxkL3orblFrUEJpU3lk?=
 =?utf-8?B?K1BocW1ySHBPenNma3l1cGtBdFA5VThMdjFSeW55S1VpajBxWEtJVERGWkRF?=
 =?utf-8?B?ZFFYNjhOblBhN0R6ZlMyZWYvTFh6TEsxNENTK2VyeXNUZzBzL3BVZ0t2eS9m?=
 =?utf-8?B?eFhQNGlmdUtlOVNKM2ZxZk5WbW8vUXluUW9zTCtYNG9HQTQySVRuTmprUGV4?=
 =?utf-8?B?OUZPVVhRZlppb2RvY3h1UHkyTkc0UEtNNXY0MHpSdzFMbUxvYTZ5MW9USGpM?=
 =?utf-8?B?amFVaEc3dmluNXdtbmhOVnlQRERHRTRUbEhEcWZaR3A3SHBDWDRRdjcxYUZq?=
 =?utf-8?B?ZHFRYWJBM2J3dmVjcXNqRk9Ia2JCTnRHek12T0R4RlNnZDRsTCtqZ1plaVBD?=
 =?utf-8?B?OUQ0T29BS2krQWUyVmtTcHAxeGtXUG5hUHI3NXBnTDJBL09yRERnMnJucC9L?=
 =?utf-8?B?Y0M0SjhpOHcwUDY3ME9LbXNMaUd6aFAwNFRCZ00xVTlTeFIwZ1JSWDRNUHpG?=
 =?utf-8?B?SjV6VmUvdm5hdTNramRCcjZNU2hvbEdKcTBscUZDdEh5Ly9WditLV3dwWEdP?=
 =?utf-8?B?QWUyVEVaR3hOUURxaVJXbC93UnVzRGthdEM4REM1WHBMY3R2c0ZIWk45MnBJ?=
 =?utf-8?B?VGZnUDEzRm8zZTJKbUlFQjVmUDVXNGFQekJzM2FUbFUvVHcwNi9CTGk1bDcy?=
 =?utf-8?B?ZUl1M1p1eGxsMFVvUG5FM3EvMlVVdEhPVHRaTk1ZOU5uN01rK3Z3YXY2ZUhY?=
 =?utf-8?B?dExOWHZxMVZ4SkZScjBzWVdidjZ1ZHU4bWRuRXptLzg4NTh2NytjYnBxY1NG?=
 =?utf-8?B?R0ZLMUJhcDJ6OGJvT0tDMFJhc1pmWGtuZ2xsWkVaVGVsV2Nhc1VBRlRZQ3gr?=
 =?utf-8?B?bnRoS1ZPWDE5Vmt5Q3ovc0IvUkhTSEtYQVRtZUd1THpBZDZaVmdzZERwWVN2?=
 =?utf-8?B?MmtocFdXQll5TEhnTXRlNGpDQUJ1OUtsbnVZbnNqb2RQa2hoS0cvdW1lN1J3?=
 =?utf-8?B?a0tIU3lzd3FadS91Z0RpSXZIQmMrWHk4R2tVMlUwa3plMTJ0UVYzbFlsYjl4?=
 =?utf-8?B?Mk1xaG1CbTl1TmNxaXBlUC9DZENvZ1lLNFgrTEhZS1BYc1BDeTljT0ZRc2VD?=
 =?utf-8?B?UGdqajdsNVF2TnVkOHFjU1ovclJXZDhSV3hDS0RCQkNqY1BqT1owdTIrK3pk?=
 =?utf-8?B?TkZvbXd3K05JT0xqbVQ4S09mazhlRjEvVkpPYlFEL2Z6S1hXYVM3dU4rOWtk?=
 =?utf-8?B?RGNoTkxZWUI1QWtrdzhJSXByNTlJNTI1VmdVSnpZakF2L0h1WHByeUYzRy95?=
 =?utf-8?Q?cxBfQNV1MkgBbjVo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 333e8399-ba33-4316-2768-08de59073a21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:07:51.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzNmtQ3lqzuF21C9+0I4tzjDHUqW9mrIm3nXfuT7nhNIA7qv7XHf9ZGvxq8kFKfLkpCxqiBSDgjOR7yVwWmV9YWDiWVyxWOTUGowt80bL3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210791-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.de:email,intel.com:email,intel.com:dkim,intel.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AFE7D5A8CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On 1/20/26 6:57 PM, Sasha Levin wrote:
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> 
> [ Upstream commit fd2afa70eff057fab57c9e06708b68677b261a0c ]
> 
> Add description of undocumented parameters. Issues detected by
> scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Link: https://lkml.kernel.org/r/20210618223206.29539-1-fmdefrancesco@gmail.com
> Stable-dep-of: 6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")

I cannot see how this patch is a dependency for above since it only adjusts kernel-doc
in a different file.

Reinette


