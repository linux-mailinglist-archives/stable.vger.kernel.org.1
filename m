Return-Path: <stable+bounces-195036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA282C668B8
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0D8835640C
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A432E041A;
	Mon, 17 Nov 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjMPvfhZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7112989BF;
	Mon, 17 Nov 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421856; cv=fail; b=r6wbDqRAQq8q8ozU2v82yLIPjgYL/9/kiSic51PNPEg3rwMSqUQj3CDhMSALrKq1uzSYYbhJ3EPxoiv+tba3JuqxBHAq4QlKHaRIdIn1ejkcXXMrurvXtwp6TMaeNxkxJN0CyNPqwpeO3CSGIPQb1lF/zgtNmGtdr4RM3gS1Jpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421856; c=relaxed/simple;
	bh=VmKA3ROZFi6NFnc7AJvBV8VImoAIyQ8uBk8aQ6rzfLQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b8cj8G1XHKTjbDxosV9NBYiRyotKBDuqW1w0qA8LNpumC55nTeojB+f7i4DUNq9BqI4+aFx/F2SzOssaNmClc1mwOuToZWfAoPvOeTcOdzZQTgukiW8/AeQOzesW3rQzfYzDXUmj7EsRbfg3aGlU/Pt3zdlRz+V9iSiL4MdDWSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjMPvfhZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763421854; x=1794957854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmKA3ROZFi6NFnc7AJvBV8VImoAIyQ8uBk8aQ6rzfLQ=;
  b=SjMPvfhZ7vKFCwEWzssPzfi3q18io0cshqbCPjlW4g8UhXx4JMxBiXGT
   4t/86tA3eL4ljgIrNWLvByGSPav5qW0W5lCLS03AqJMv0EIwU2V7nL7gk
   RF0QADBGAgCkWfLXsdzd8J+Hcs1KPL3nttN+umLJeV740PUR+qFzEMt0o
   63wUcRe1848dw9c/7fMTjo+y0Eiaggi7kZz+EprgzGeU2EYlnmF7WeOUs
   H6WZGEvyN25iMI19HrvxA7M7l/OEef6+VQWgU/eJz/A4CrdoQWHRNDg2A
   atDtlN76VLx7bzAkDUyJTwq4NJoztnxu+8YRC20JLDhnl2hYkuq6Mri/T
   w==;
X-CSE-ConnectionGUID: zglfnc59TuOq6x8uxhyRtQ==
X-CSE-MsgGUID: BihPIrWaSK+BEW2kdmuFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76786183"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="76786183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 15:24:13 -0800
X-CSE-ConnectionGUID: hfmqJElQQtaOiocZzYoSpw==
X-CSE-MsgGUID: 1rQcqUlGT1yRcFh2cgp/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="213972629"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 15:24:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 15:24:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 15:24:13 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 15:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVhDfKhDAu10k1mKI/tuJ5CjK6gMZJJL1xVAXevVWZ0Rkj4sip6YavR7Jcgc0fV/2DYvJUNFeE0cd/bgDXZGrfNHrciMn7HnFqtxB6ejWFxou+TCASI95VZrY1GhGzsMyao9IksuSfCLTnkHRH5aw//tA+nbDhpdkmgtngk6LsBiznj1zXdYQEKZKzmncJ+9xtJkuGjsT5v6pN1PW1msECeme3gfO8LuMsatFbwyxlo4KY0dY+gfHIa3zNXBJ49a/EjaKoekSUGl5BP4qsLKaIdwCH6oNB1Q6DC8Iz60ZSD7q854F9y/hPTQEssPqPAIj8c+c5/BNfMGs7Bdw0RxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGtSwpFIifuaEVyKpZjAD5pIvhyJHTfv8mGGE7iCJLE=;
 b=NkIl3B+/QQyS2Au5UdPAsckku+BAM1dq01A0dsxv73+V0D7RHxOPLSW3Nbi7+rDpiX8jycskEj4V+cBr/kHtNOCIDt6UTwOiki1lkoG0yN/tQUNJ0TDecdgT9u1Mf7iuuzyPRZ7CLLMtraHbw9SVTDkAfgn5bakG8/ycjsvLyz9T7M53gvRrGbYmla2hLRA7XJju658TPy1/M45UReqZBz1FSzl2v4Fi2WHSS5ZSyFSpVx54TnVlC2onqHitg4a5UWr6GgchJGj4Y5/fWcOez6ux7ozLZt1BRZzbANzzuO5/XWiv/mKLV9XhB+6D+oiLgaqKfBUfzG+Q6sQb2J3EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 23:24:10 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 23:24:08 +0000
Message-ID: <b53c3a7e-6833-4e87-ae24-c344f2c3c5a1@intel.com>
Date: Mon, 17 Nov 2025 15:24:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000: fix OOB in e1000_tbi_should_accept()
To: Guangshuo Li <lgs201920130244@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20251104082801.994195-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20251104082801.994195-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee348d9-dafc-41e7-05ce-08de26306837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDg0dVlpSGI0SGUzR0tiNTV5dCt4QXhIbEhCZkVvOGNvMzV3RTNhaEMrMUMx?=
 =?utf-8?B?SHBzaVJrQWplZy9Day9tS1dSUDIxMWlPY3g3bnA4V3JHbkR3OWJ0dUt5ZDhC?=
 =?utf-8?B?YmR3SDcyUXlVbFR5UzcyNGdaUlBiNmtpS3hDNzVXMVJuUFhhdzRJcDhrVnl5?=
 =?utf-8?B?aCtScUtwUVo3WFdZanh0c2FRUk0xV0Jrc2VIRTQ1VVQxdEs1R1BBcVFQcDNU?=
 =?utf-8?B?a0w4aXRjL1hmMzFyMXhYSDJiUTVGOFZWbzFycmFIZW9QMnR4SUdwM3B6L0h6?=
 =?utf-8?B?MDZxUFZiT0N4N0lQRHlGQmt4NERVelRTc1lMVlpGcThpcUgxQ2Q1bVBmS0k0?=
 =?utf-8?B?OGpYUmQybHYyM2d0Tm9MK1JUNng0MEsrV0dRaTVQQXRhWUQ3dVZXZFhNclAv?=
 =?utf-8?B?NklWOXdlSEFYNEN1eFgxU0RCSTErWHlqODREVTZkeStrYXRoVlNSNmRsS2NJ?=
 =?utf-8?B?RWFXeXc5ZWpscTVaMW1lQzRacXhOTWx1Q3FJM2dmVEV4OWtnYmtkcm9LZ0F2?=
 =?utf-8?B?WWRsYzFRU2VVY1dRNEFma21KQndqdVlBWStQeFhieWxVM1A2bXhDVy9mK2xB?=
 =?utf-8?B?ektGSkFvY1ZQbnpNeXFmcjFnSTVuREFYcysxRjR4ZTRJL2FUUTVaWWVmWnBi?=
 =?utf-8?B?MjlmNDlEZFRyZ2N0a0JRTy8yM0VFWDdLVnZjdjR0SktoM0RubC9UdkhVSHBo?=
 =?utf-8?B?dmE1RDFJbEo4Njh6bkpmdE8zM0NGT3JnSU9aek5jcDVRTVlvb3NYbjNqTmhJ?=
 =?utf-8?B?Q3pSN0xiMDlDRXgwK3lDd25Mdkx1R3phZHJlTTNQZWczdm1YT3BlZFc3Nm9O?=
 =?utf-8?B?YWNGTWtpUENqbXcrZHJUR1FYcHRlamVmTGhHbHVuSSttZjNIQ3k1dEJudTZN?=
 =?utf-8?B?cHFYZEJoRko1SFVIRXdlSXgzSVFZc0RsaW5rMUpWUEd6RU1uYzJReFl1ZXNu?=
 =?utf-8?B?ZEFyT1M1U1BiRDM2dE5IRERVNTlUbEhmaHRmYXpjSngzTzI2SEp2MTJNeGRZ?=
 =?utf-8?B?b1AyZmZzMkpXdTJkb1d6TDFPN281Qy8wa3VIZTZicDdFMXNCcHlqcFkya2g3?=
 =?utf-8?B?WTJyVzYvQzEyaVlYVUpMZ05SWWQyNE9EaGdlRW1jOXVUYzUrOUt3aGV5TmI5?=
 =?utf-8?B?YjE3eFk4S0wrNVprZGdudG1Gdk5SeEhGamtEc3M1UEZrOSsreE1TYjM1K2lC?=
 =?utf-8?B?ZGVnS25VVjZhRUt3NTFLWlNRUTc4R1pSdTJBZ0xNeTU0aUxyekM5ZzZYTEJi?=
 =?utf-8?B?SUxJWUtyYnlwWjdHaDZKcGhjVTU0RzFSZi9ZTW12TEhSNzJzTE80QU44eExj?=
 =?utf-8?B?Y0hsVnlqSDlnVnUya1A0S3Z2T29BdmVSeitMOXFmQzkzV2Yrc3BXWTFiamJn?=
 =?utf-8?B?dWNTVmlpTmJuanhsMjB6dXU0VnV5MkI5ZEJteVZwWVA0ZDNPZmRiWkwzKzhT?=
 =?utf-8?B?TE01dEhPVUo4cDQwdC9nbGFtV1FHRlFJS0ZOb0d6a3NBaW5rTis5amJ6dGl2?=
 =?utf-8?B?VjZLaVp1cytvR0R5Q3M1WmxXblhwMWx0cDc0Sndpd2JaK3QwUkxNTms3amx6?=
 =?utf-8?B?OGhBcTMzaU9ackRENkVEam9xYUVMbWJhMDJSeElFb0FWSVZwV2JYUUJMZ09z?=
 =?utf-8?B?b1VvYUt5V0lEaHYvQVBvTjJBZlk1YWJmeE1VWmtwZzhyWVM4TGl4dVpGeDVK?=
 =?utf-8?B?T0xGODdUWi9TWHpGMWZrekpOUHZqUkw5R2VheEc3RWpveXMwV1FNZjhRNHlN?=
 =?utf-8?B?WGFUaDVJYjBMNVlSeGhJYzlIZ0JDNzB0VURyMU1zZXlHb3dRcHBOMm9hazAz?=
 =?utf-8?B?cDJDNzhTQWg2Mko2MG1XdlI4N1NuMkViNStrWm9RZEJ2NVYybWtqU01FY0M2?=
 =?utf-8?B?UU5VMUVGRzdDeU91WFd1SGsxYW9YajlRYTRHdDRPOHRGWGRkbGxNMVErcTlv?=
 =?utf-8?Q?YGubFbB7R41FUTc1AEZnZr3iOuK6/eMd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpaVFp2czl1OVAxNkFsdXV6dEdkbEtMVHk1WHhLaGgycFdzb0hzWll4Nnlk?=
 =?utf-8?B?RDUrV1hIMk0xd1RLbDdLK1E5ZzJnaEFET2h5TDh3ZjcyQWhSVnAvNTZVOUZx?=
 =?utf-8?B?MlZzTzBkV2NDNUlFZVZkaFlVMkV6UUtiSUwvdEdBc2ErT1JHU2dKNXZRRVRj?=
 =?utf-8?B?cU1WeVpQT3VpSUdFSWNUR1B3WGVOUlM5QU5zNlQ1UjZqQkxQbERrUXR2enc3?=
 =?utf-8?B?OXNWekJGdkhUMkhrd1ZhWWdCVGNYL0pDZjVnR0NXOUMyVnErLys2R3IrY1Er?=
 =?utf-8?B?ajRVaE1iNytNVDNRY3A1MVJKN2JMU3phS3hKUERBOUZlUkVrUW9nS25DczQ1?=
 =?utf-8?B?STFuWnNrTnBkUjdoNThhb3l5QVFJUERndjBFVjZpMTFFM0JER3FpUnhoTFRo?=
 =?utf-8?B?bEFiOFB5eE1BdzBBTGNCak91bExlNHJ5MGZOOWhIMzhyMHdodi9MUTBxWlI4?=
 =?utf-8?B?Y1p4YlZtTzJIdXZHL01rSzJVczlxNlZTZS9iU0x0aXJJZ0UvWE5SNCttN0RR?=
 =?utf-8?B?WTN6UlhqcTNCUzVFZVFzVUhoTXVOQUs3NEd6dDNaWmZXdzJ5dThCWk05OTRH?=
 =?utf-8?B?ZTJpNFlSdGxwanF5amZTWDA5YXluMVFnUmZZNm1heU1rS0FXUVBrNU5VS2hD?=
 =?utf-8?B?TUVrRGRtVGRiUE9aVkU4TWlKNGNXNFpZdWtKZC91STVPYVdRSHhONXNiZXJz?=
 =?utf-8?B?bm96VmZJaEpHUVRJbE4xY1NvOGo4UkZCdWlwTTQ1Sy9aOXovK3Njbm5jS2I5?=
 =?utf-8?B?NTM3WmFTYk9mN3d4Q3NmZFBhYXEwSVBJVCtBRUJrNC9xUHVKUTk2VG5qSUZE?=
 =?utf-8?B?NEI1b1NKNjNKbWo4RTc0T085Y0hsUEpQU3BCLy9HamhMd0NnOUhxZnJUTGl3?=
 =?utf-8?B?d3lCTlFZamg2djJjRnIyam5ERjN3a0hJSUdYL1F3NHBod0FtRG0vV051TmFK?=
 =?utf-8?B?NWxRWjBrekpqc1hPS0pvSHFzcFdXR3U2ZkxUWVA5OStvcDdXeFQyblNQeHNQ?=
 =?utf-8?B?SmgyUVVXU2ZyZEx5aXBLaWZNQldwWENla3VHbHZWQWtnQ0xXRU9Uc0R5bGR5?=
 =?utf-8?B?bUo4bmJzVWFuZTlMMHhhWXBoQ0NzTk13WHBWQUpjRE1OUG5LQi90Qk44Qi9v?=
 =?utf-8?B?aDJ4YUlXY0VITytSUU8rMXd0dU5SeXJYVGxQNlQ3TVZWVzNod0VLK0R5ZHRl?=
 =?utf-8?B?ekRzQmJlNXNrOTlUQ01JL1liMmJPVlNDZ3pqeEVQRDNXTThLOGJiMDNOaWpk?=
 =?utf-8?B?UE4xaStZQUt0WWtkRlE4Uis4YjAwTW5LU2dwdjZhZlUydk05QklkK0hUMHdP?=
 =?utf-8?B?Qm9ieCtSNjNUNDJGNXRibGVJOWQ2NWFiNjZFLzNDRExTYlE4NnpwVHlUOEx0?=
 =?utf-8?B?SEVzMHI2SlliM205WjUzZGNUNmViVEZqNGo3YndhdnpnSWZrVjdFanliaVBv?=
 =?utf-8?B?S2oyUGtuek00L0xXeVlCUURMNElKTmlCcmFNSVZyb2ROSDhEcHhxQXpON21B?=
 =?utf-8?B?SXdaU0JBWFFNdWQ1Uk0yKzA3Nm1IbDNOa0N3Rng0K01kWlMrMVl1enNPK0xX?=
 =?utf-8?B?Q0NEaWR3ekVBajJLdko4dGxPbFpXTE50SElDR2E5ajNoclZCSXFWSFBkUWpz?=
 =?utf-8?B?NUF5V1FJV2pNRUd2eGN2cUV4QzhFRHFLQ0V5SzVsMXlwbHlZb2dNM1VETUVD?=
 =?utf-8?B?cG9hL2JET0t2YkpDTjIzSTlrSmhsOFFoWEdzMlJFTDF4eUtvc0RPWXZ4U2Fz?=
 =?utf-8?B?V05LZ1RybFJvMDd1cGRhVmJXWmZiMHE5ZFBJYXdWS1QwcWMvMis4QmVFVGVE?=
 =?utf-8?B?OS9Vck16ZnVUYk5pYTV1d1dTZFdWNzd6NEJkdWJDSjB0aXN1M0xtTUhNVzgz?=
 =?utf-8?B?NFI4dEhtamRoZUdZbHpIY05zZGx1Rk94K0JKMEhmSjRvbHBjcE05ZE5sdmhl?=
 =?utf-8?B?amlid2pjOVpPNzJEOXh1YUZsYm55U3h6cU9ta0VOSkhvaHJpT0dHTHB3NGNz?=
 =?utf-8?B?elVlUEJJb1NhOTU2T2NLbjR6V2hKWjFJVFRMcm1PRVN2SXdFR0UvSVErdVAw?=
 =?utf-8?B?UTNjaWViMFIxOXhyTXVLRXhuZ1R6Zm56UUpkNG51Q2VIck9EdFBzd1V3dmJ2?=
 =?utf-8?B?S2JQUFo2L3dzNnpXZ21OQzlReVJIUVJxUDAvZ0pVTTBQYkFPR0pDTUticERh?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee348d9-dafc-41e7-05ce-08de26306837
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:24:08.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO+vjGb6tCQUoBFdJVZkxD3alTMJ3Xmoyb89sQBuWSJz0QoaavOZj5k36cQ4GOScWjcxmGVnk654HcFkN2OPiAFhmn2MT9dePRAfch5TG+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com



On 11/4/2025 12:28 AM, Guangshuo Li wrote:
> In e1000_tbi_should_accept() we read the last byte of the frame via
> 'data[length - 1]' to evaluate the TBI workaround. If the descriptor-
> reported length is zero or larger than the actual RX buffer size, this
> read goes out of bounds and can hit unrelated slab objects. The issue
> is observed from the NAPI receive path (e1000_clean_rx_irq):

...

> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -4090,6 +4090,12 @@ static bool e1000_tbi_should_accept(struct e1000_adapter *adapter,
>   				    u8 status, u8 errors,
>   				    u32 length, const u8 *data)
>   {
> +	/* Guard against OOB on data[length - 1] */
> +	if (unlikely(!length))
> +		return false;
> +	/* Upper bound: length must not exceed rx_buffer_len */
> +	if (unlikely(length > adapter->rx_buffer_len))
> +		return false;

The change itself looks fine, however, the declarations should be at the 
beginning of the function so this should be moved to be after that.

>   	struct e1000_hw *hw = &adapter->hw;
>   	u8 last_byte = *(data + length - 1);

Also, since last_byte uses length, this should be broken up and the 
assignment moved after the added checks.

Thanks,
Tony

