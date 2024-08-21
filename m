Return-Path: <stable+bounces-69770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66695925E
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6C7284F7F
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14A56440;
	Wed, 21 Aug 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxKLC6U/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DA26281;
	Wed, 21 Aug 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205190; cv=fail; b=neTfq439m5XBb7qsgTzdnNU75gk4PIfhV9VVP6VGx73bMU4XvCFDaNi1F7VAZsjqsJLz9c8NySTIgEuibgIOijFtjDo0Geymln2PJeZxGJ3nx+RN4OskpYisfOgxX/vF5SLALpdn4S2ZLPmetvfMCng/sJ3C0P+env4ILdJ8I2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205190; c=relaxed/simple;
	bh=irsw6mbJFaz5ZsRAwoJsyyKc13z7Kq1ll+gMqwk58Vo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxa1ZzNdflX8xQVMg8uM7j/cOL1T28RB3njTZEEdHV+8Czf8uYWrY3vDH0YTUnRlj3kHwQUP7ntVayQGLalj0HeLCgiRGmqfqVZLMFNi5m35rBw1telgWEXodA06/rx6Ss5M0J0ISNbEvaqyhV6fyzdwh24OohkEKCO+mfRA6Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxKLC6U/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205187; x=1755741187;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irsw6mbJFaz5ZsRAwoJsyyKc13z7Kq1ll+gMqwk58Vo=;
  b=RxKLC6U/BguiDuvw+4yC+DXfrvynoM6hFuGV650l71qEZBjub3X4Ut+j
   dBnrAii5A34iobNWhDkxwtQAwbzh9+WUxuLGdqEo/3j8zAa0DmAhblxT3
   4xSpp7zzuoHbcF9JQq+/k4bWMBFcdB3P6B25Dkhbua1x5YRJTDjN1heiu
   O4IGXh9V3X1nRhXxURroNkuU2rnQm9BBLCs4y6+BBxWyGHfTkvDE9EQO2
   VbALRDKJhz4ODCAxnN/b/6Tdectyot39xwaKvnVzVmuEIJOKhhGMWJyfz
   lJEgsDfEeSg2tIhGp5NbPQIgsX5gqBCOyJD8S8k8Yw5Q5bzE+nfKsau4e
   w==;
X-CSE-ConnectionGUID: 4qa9L92pSDeFJz1Fknlh+g==
X-CSE-MsgGUID: /zvdE70KTImpU1E+if0/Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="45068146"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="45068146"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:53:07 -0700
X-CSE-ConnectionGUID: yQkdkT4fSAytrN90k56oOA==
X-CSE-MsgGUID: xlZT4K/rR6iq2KrD4DM4Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60787618"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 18:53:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:53:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:53:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 18:53:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 18:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9VsAbOIFn3U6MkEYrvTD6j/awkYWzA6l734834jB44ZybNcPH9nrymSSNTOFtB9yG+OOtqRjv8PBbIBnrMAtmp2ehsT83uJm05DN771acu0J1/6Rv0rJezDQacXawS1dE9JjXWhWCTlXLLHslA5peIiF8rAPj7B5/MP2nCtt/sIY775/IUIFMqXIskeZg9hlkAH10r4O3J++OTsV+N4xAxjti2kqP8Xx8JiBz7CG8vGZjFaLZfe9cXPnBG0BnP+HjjNjp69K5NEUgouvINu66zgUYjzOo//9t3VeOYJs6RtjYTHEuukLfVW80Ktd7DOT46HQ092qygxu2GHHq8UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAGVEmawhd5qR1NibzB0ewQaBoW9tKJb2TQ8xC+UG9Q=;
 b=W5AQUA/xX8yEh0NcnqKmhnGRi00/xs3aM9tjPqa1OvuNnGYwFpmu0HgOKJhiLZafKS+ZdgftwAnUxqRMdscKyD+BNhr/3eoBK3B2Xr1wfe/ddBulon7oPOKZe006+47SUMMowoCdh++2p0NeJ0Esk/IPdR1lbr3gOIKz4aBjQ9fb3UnagcyKMThuM2m9yNDL2+fiwA1s9tKg2rTKK50doKWSJ3WlG3suHA2NwbNTvLSdSYOi2tKJ/yzjtYIEBKIkCam1p7rjR3MG5JEqUwl64UD253psvTzkG2aX6xS3V1uwfFAPUmlXkDMWkcIugnMVmGRQb/uH7IFHIINGJAYzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 01:52:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 01:52:57 +0000
Message-ID: <92fcceab-908f-4bfe-811d-694104d4dfa5@intel.com>
Date: Wed, 21 Aug 2024 13:52:49 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5, REBASED 3/4] x86/tdx: Dynamically disable SEPT
 violations from causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
 <20240809130923.3893765-4-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240809130923.3893765-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 553a72e7-c4d4-457f-47bb-08dcc183fadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzlaYWRyZ3RnS3lENG82dTQ1U1Y0WkIwb2JjVnNhSkVOMEMyNnZvRkpyTGlz?=
 =?utf-8?B?Unc0a2VLWm42dkxYandxNDZOVngxOEUvdldnR2lpRmFEQXV4SU1tVWZCYmU3?=
 =?utf-8?B?N0NGTkgwaVRJdmMxMUVUdFgrNUF3UGVoeVhBQjU3c1N1ZlBkWHJuc01GSks5?=
 =?utf-8?B?WEhwait1UDRWWVJyM2ZLcldRNmZRUFU2MmZGZkNWb3lqYnRKL1VWaEdyM0lG?=
 =?utf-8?B?bEM4d0RTR2htMGUwKy9GMnpCeUwxSGxoRFVwUTlZM3NUb2dQLy9FNGp5MDNZ?=
 =?utf-8?B?VUd6Wjk3RnBoVkR6WURvN3VvMEd0alNZdExqd1VQcFhNZlI2NGtHVkoyL2Fi?=
 =?utf-8?B?NEdSU25rUStxL1V4UHh6V3Jud3dSdWVwQ1dQL0lHZTdYdjlYN05LbzZUamxj?=
 =?utf-8?B?bzN3c2FhWmZ3dWtDNnhYcUg1UWE4ajhUMXVVZGVrYlRWQkxqSVk1eU5zLzAz?=
 =?utf-8?B?bDR1M2dsMUhYVmxheXlXWExLdnk3MGtHc0JaNVJTcXplVGZ6WVhDSlR5WWV5?=
 =?utf-8?B?d0NBNkZMeUMxQlowbkdQbURnWjdyK1RGd1NYSXZWNGVIWk1raXl5TWp4VDR1?=
 =?utf-8?B?eU8yR3lRMHlrSnN5SlVQUEhjdXpoaU5NdEI4ekx2UmNvREN3cG5jVmRmRkkr?=
 =?utf-8?B?NWN1Y25oNWk0WTluRS9iRzVqaHVQakVSNmZrS0tWemxWa1ltOWtNVVhIS3lO?=
 =?utf-8?B?WE5RWnNFU09VdjVxbkV2elN1S0paSWVZN0dGY1VIYy9renI1WGdXQklySXps?=
 =?utf-8?B?NjlWS04rNisvc09GRTNaTUs0TW9CT3o3a1lpREt1S1dmTXcraHdFZTl1cmlQ?=
 =?utf-8?B?ODd5MG1ZZ0ZoeTJncTI1QWhWRXBpcEw2bE82SDZsa3A4VUs1a1BDdDlDeElp?=
 =?utf-8?B?Tkx3bDRvOUtXNTFhZENkWmdiWEdUZGxZdVFVQlRyVUkvWUhudEJyQUtlTitY?=
 =?utf-8?B?QnNRS1FFQkQzM2hVYWM2Z2NzQitobGxCN1RSaUowZ3dOUEdwMzNCU3Q1MDY0?=
 =?utf-8?B?ODAzNnZVSXJDaUZ2L1pmTmJ3eXJSa2tMZTIrTzhSbFA2YlNlZEJab05ieXZC?=
 =?utf-8?B?ZW9ESFdacmVJejFkVEpNVEhuR3krWERSa1poZHZyOGVWeVM5MzhNUFdUOVBC?=
 =?utf-8?B?Y25ET0pFR0dlY1VBOHlnME84YjVpRTRKbUYwa1FMbkdOTHFOeHBzQ0twM3l0?=
 =?utf-8?B?enAvVlRrVEQ1ZzUyRDF3dnJ0L3lXT3gyWnZYblRoVk5zWmwyMHFYbmoxMm5v?=
 =?utf-8?B?N3ZGdUlKT3BOZCtRQU0rZkVDc2szRWJFaEl3bXBCa1dyZDZZWTMyV3Raa3dL?=
 =?utf-8?B?dWM4enBHWENFOCsxaGM5ajY4LzJUcnZZMU0vUlBuaTF4MmwxWjVZTEdUVjBz?=
 =?utf-8?B?S0FWcEJPWXRQWnpBRE9LSEYzbGZTOVNFWHk1aEJCa29SLzNIM0NQMFBpN3lQ?=
 =?utf-8?B?QXBDUFJkU1oyUHpybkdrVGNxR1ZGUUJHaVFyeGUva05QTDQvY1VEWHlWQ2Rz?=
 =?utf-8?B?UjF0bzZadlFzT3lEQ1NsQUtyaTFXd0xiTldrZkhEb0gya1dTUFZMbUpST1J4?=
 =?utf-8?B?WUx4KzF6Nk9BOEI2emdNd2tRSFNWRFd5aXBSUVQxU1RYOUFtd2h4VUZXQXRY?=
 =?utf-8?B?QVN2UGlydUJaMEhoTTNoaUNPU2V3aktCa1hyT0p2ZWFlOVI5b1dDdE1qanlX?=
 =?utf-8?B?UzMzVG5oWFUxUWxwNHBxYnFCNXozaW1LRnJHZDlhaTUxdmNMWnErOGUxb2M2?=
 =?utf-8?B?UEtaVG5vQ3RNRU9ycWZ4dlBGeGJBd0hTaUV6bHBsYVpkU25YVS9JZTl1VDc0?=
 =?utf-8?B?bUpZUWVGUDh1dC9LWXp2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtjVlE5K3d2SGd0Wm04VjdXVlYrdFVEV3drT29lRXpvaUgwVmNoRnErVGVt?=
 =?utf-8?B?M3lBcnVXVno1YlAvQmpaQVdNTWV1Wml1SXlkT0x0MTk1RWxxQVNJZzdqM1Qv?=
 =?utf-8?B?ZFVFNWorZ29uMlB6RU1zQjFNMWtkaEo0UC82M05GZG1SNkxkT1JmaEhsNWk1?=
 =?utf-8?B?QmJrMUJwZVhzdlV0VVRVeVV4ZHcvM0dnb0hHQlBwZ3hHYmNaNEhxbGc0akNu?=
 =?utf-8?B?Y05ybDhHOFBuSUZiVVlRQU8vS0txV3BiSXJURS9TWjM2M29qMjlJU2llVkl0?=
 =?utf-8?B?VGp4WlpwNjBWdzVXV2pieEJOZWM2NmR5d01XWjkvd0RJVkFVZmljYWdXU29i?=
 =?utf-8?B?N2tIR0UvMGxrTEV3aE00cytmdDJ6U1dmQ0tjWHl3T2ptZmU5Ty9zZDIxK3JN?=
 =?utf-8?B?R0hPaDUxVXkvakZ4bGJ1bWRESHlWUEVGQUVLNlBHTXZkb3Z3Ukk3a0Z1KzRx?=
 =?utf-8?B?VGpGVnJOMG8xSXp6T2Fkdy9ITDR2WFk4ZGlEcUNPSVJiVVc1S3RTN2lENkxI?=
 =?utf-8?B?NUQ0dHQ5RG1hQ3o3L3U1TlZGanRFdy9nVDgyd05EODJKU0FLY0oxc09BSmZI?=
 =?utf-8?B?cHN3a2hYUVpjMHJqSkxpMHoyaE9zbWxWODkrY0pSZStJREtQL3l4QUgzWHJw?=
 =?utf-8?B?aDNmMnpQZURXTVgvMTJud1pqMmFvMVRKSFlWaW1YSTM5ZEM1TWNObmc2UTBa?=
 =?utf-8?B?ZHF6WFNxMUF6dzRnVW9Ud2k3QjV5OVFocjNzam5hVkg0eDBwZHZxczJ2LzNt?=
 =?utf-8?B?LytIdnAyYTRCc1owM0dSWkZBcVFPclI5a2lxZ3UwZS9GbjdnMlR6SkhkNC9C?=
 =?utf-8?B?V1JhaXVraGU2eXZ6NXVZZU9rM20zK0wxc1hKekg3SDZzQXdXRTloRC83R0dG?=
 =?utf-8?B?Q1VVTGVKVXVjTkJRT0kvd3lsYVhlc0FXemZrY1kzNjNqakNFYVlMbEZsS2hn?=
 =?utf-8?B?d2ZiaDMrTUt2NnJSOFB0cktZVmVFRnNtOHNCMSt2dktQdlJiZnNTOXZBQ21h?=
 =?utf-8?B?Nk0zZ1I5azhoNHRmdmxYQmRNWU1kUGl0L0tyYXF1M1p1ZTlEeWRlZ2UvWE5J?=
 =?utf-8?B?enU3V1FCd2pqZ0FYMG5xTHRlSU5XTnFCb0JmR3h3UmEzZXp1NkpqUVpMZmNU?=
 =?utf-8?B?WTZ3VzgrMnpmd1hEVmRxWElYcXZQZlh3WHhtb0hTOUxaSnBNZ3Q0d1EyWGxi?=
 =?utf-8?B?dUszQndqNlI2bTlsRFVJaUpyQm5SY09yV2hEZGhIOVF0M0YvdEtUVGlJWW5I?=
 =?utf-8?B?Rm5HaGl3TVY3bjZMd2lHMnE3d0dmT1Q1RXFyZkFsaGZYYkx0dFFwQlN0NFpS?=
 =?utf-8?B?N2wycUxGK08rdGVrTS9wdlJ6Z0VIdnZUOXNuZzhodFRkcEoxWUp0ajBBaWVk?=
 =?utf-8?B?a2dxbGpzVkRWNWJXWXFxTGgrbjZuUzlHUGcvS0NHYzNvVDlZTGxUdWV6QmV4?=
 =?utf-8?B?NHNUZWtCV1RadkhKSkZFamI2KzJ4citXaWdmTXhQNExaelN1YUhrZGNaL3B0?=
 =?utf-8?B?M2xXclJUOWlmanpnNEpvN2t6OFYyNXovazQ1WmdvTEpvTkUzRHVXMmZuWW9G?=
 =?utf-8?B?OHNnTUlDck4vVEFGQ2pNd1dva3pGYUFtOHlDZWE2eGdRNkNIMG9iVFZKQmVE?=
 =?utf-8?B?WVBOd0FRd3F1YnI1SUtpcW9nUkpvenBTNjN2T2RSdWRBajVicFFROG5tbFBZ?=
 =?utf-8?B?c1o2bkNOZEx1WWt0RE9GOGYyYzF5aTAxMVBKUHI0MHNSWXIwQ21NSWduSk9N?=
 =?utf-8?B?bHRob1VjbWlua1g1WkxIOWk3UzhtU3c0Rnh5alRncytuOHVOKzBSMTgwbkhM?=
 =?utf-8?B?MWVjc3daK05Eckk3d1BJR1hKSldXSnQreEs4SVBtaEdubnpuT2E4bE1GT3ly?=
 =?utf-8?B?R3kyV0wxRkptNXJqaUNkOEZqYi9pbWZYNk1aSnN1YkF4R2hyWjVkclR0cUls?=
 =?utf-8?B?MXl0bWJIdnhjellJdENaV1Job0RQdDRGYmUxZjdXUHdkczFha1hVZllDMUF6?=
 =?utf-8?B?Nkc3VkxWenFNc3ZaYS83VXNVREJnZVRFYXBMMi8zUTBIT3hRTC9zb0JieW1j?=
 =?utf-8?B?SVFVS3RzaVlCOW9EVlcvQTdoTFB4dG5neDNkTmdPbFBWQk9jWXROVVJaZ29T?=
 =?utf-8?Q?5/xjlpLnlKNoOMCI4/V4JBpjy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553a72e7-c4d4-457f-47bb-08dcc183fadf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 01:52:57.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kEOJpI72QwBHGTLjzgO0ICw7pNb0L6JMCO9h90syB3LblcTvFB4vSxFoa8N+nL80AVWu5jlaz7srtPCrf47bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com



On 10/08/2024 1:09 am, Kirill A. Shutemov wrote:
> Memory access #VE's are hard for Linux to handle in contexts like the

#VE's -> #VEs

> entry code or NMIs.  But other OSes need them for functionality.
> There's a static (pre-guest-boot) way for a VMM to choose one or the
> other.  But VMMs don't always know which OS they are booting, so they
> choose to deliver those #VE's so the "other" OSes will work.  That,

#VE's -> #VEs

> unfortunately has left us in the lurch and exposed to these
> hard-to-handle #VEs.
> 
> The TDX module has introduced a new feature.  Even if the static > configuration is "send nasty #VE's", the kernel can dynamically request
> that they be disabled.

#VE's -> #VEs.

"request that they be disable" -> "request they to be disabled".


> 
> Check if the feature is available and disable SEPT #VE if possible.

IMHO it would be better to mention "Secure-EPT #VEs" somewhere before here.

> 
> If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE

"allowed" -> "is allowed".

> attribute is no longer reliable. It reflects the initial state of the
> control for the TD, but it will not be updated if someone (e.g. bootloader)
> changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> determine if SEPT #VEs are enabled or disabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/coco/tdx/tdx.c           | 76 ++++++++++++++++++++++++-------
>   arch/x86/include/asm/shared/tdx.h | 10 +++-
>   2 files changed, 69 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 08ce488b54d0..ba3103877b21 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -78,7 +78,7 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>   }
>   
>   /* Read TD-scoped metadata */
> -static inline u64 __maybe_unused tdg_vm_rd(u64 field, u64 *value)
> +static inline u64 tdg_vm_rd(u64 field, u64 *value)
>   {
>   	struct tdx_module_args args = {
>   		.rdx = field,
> @@ -193,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
>   		__tdx_hypercall(&args);
>   }
>   
> +/*
> + * The kernel cannot handle #VEs when accessing normal kernel memory. Ensure
> + * that no #VE will be delivered for accesses to TD-private memory.
> + *
> + * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
> + * controls if the guest will receive such #VE with TD attribute
> + * ATTR_SEPT_VE_DISABLE.
> + *
> + * Newer TDX module allows the guest to control if it wants to receive SEPT
> + * violation #VEs.

Newer TDX modules allow.

"SEPT violation #VEs" -> "SEPT #VEs"?  Since the latter is used in all 
other places.

> + *
> + * Check if the feature is available and disable SEPT #VE if possible.
> + *
> + * If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE

is allowed

> + * attribute is no longer reliable. It reflects the initial state of the
> + * control for the TD, but it will not be updated if someone (e.g. bootloader)
> + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> + * determine if SEPT #VEs are enabled or disabled.
> + */
> +static void disable_sept_ve(u64 td_attr)
> +{
> +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";

The original msg was:

	"TD misconfiguration: SEPT_VE_DISABLE attribute must be set."

Any reason to change?


> +	bool debug = td_attr & ATTR_DEBUG;
> +	u64 config, controls;
> +
> +	/* Is this TD allowed to disable SEPT #VE */
> +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
> +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {

Does this field ID exist in TDX1.0?  I.e., whether it can fail here and 
should we check the return value first?

> +		/* No SEPT #VE controls for the guest: check the attribute */
> +		if (td_attr & ATTR_SEPT_VE_DISABLE)
> +			return;
> +
> +		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
> +		if (debug)
> +			pr_warn("%s\n", msg);
> +		else
> +			tdx_panic(msg);
> +		return;
> +	}
> +
> +	/* Check if SEPT #VE has been disabled before us */
> +	tdg_vm_rd(TDCS_TD_CTLS, &controls);
> +	if (controls & TD_CTLS_PENDING_VE_DISABLE)
> +		return; > +
> +	/* Keep #VEs enabled for splats in debugging environments */
> +	if (debug)
> +		return;
> +
> +	/* Disable SEPT #VEs */
> +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
> +		  TD_CTLS_PENDING_VE_DISABLE);
> +
> +	return;
> +}
> +
>   static void tdx_setup(u64 *cc_mask)
>   {
>   	struct tdx_module_args args = {};
> @@ -218,24 +274,12 @@ static void tdx_setup(u64 *cc_mask)
>   	gpa_width = args.rcx & GENMASK(5, 0);
>   	*cc_mask = BIT_ULL(gpa_width - 1);
>   
> +	td_attr = args.rdx;
> +
>   	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
>   	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>   
> -	/*
> -	 * The kernel can not handle #VE's when accessing normal kernel
> -	 * memory.  Ensure that no #VE will be delivered for accesses to
> -	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> -	 */
> -	td_attr = args.rdx;
> -	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> -		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> -
> -		/* Relax SEPT_VE_DISABLE check for debug TD. */
> -		if (td_attr & ATTR_DEBUG)
> -			pr_warn("%s\n", msg);
> -		else
> -			tdx_panic(msg);
> -	}
> +	disable_sept_ve(td_attr);
>   }
>   
>   /*
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 7e12cfa28bec..fecb2a6e864b 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -19,9 +19,17 @@
>   #define TDG_VM_RD			7
>   #define TDG_VM_WR			8
>   
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */

I am not sure whether this change is necessary.

> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017

The TDX 1.5 spec 'td_scope_metadata.json' says they are 
0x9110000300000016 and 0x9110000300000017.

I know the bit 63 is ignored by the TDX module, but since (IIUC) those 
two fields are introduced in TDX1.5, it's just better to follow what 
TDX1.5 spec says.

>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001
>   #define TDVMCALL_GET_QUOTE		0x10002

