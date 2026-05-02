Return-Path: <stable+bounces-242621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aObFJ0hP9mk/TwIAu9opvQ
	(envelope-from <stable+bounces-242621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 21:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5EF4B3518
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 21:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB239300DDF6
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471A388396;
	Sat,  2 May 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UE1e8soT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FC38836F;
	Sat,  2 May 2026 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777749814; cv=fail; b=JJZUsOs8alyg6oZP1wy1Y53grSSjtS4x+1QonDFbQgc99dtkyuBmsVZX7TtQ/5ddggZtU+E2xbTVjlJSkfwmNqAmPoJobx8v95vO5MQLolO+yg7uRX/OgzYlGKkSH6KFM65s9gFOBEaAALK9oHDQs5u0dLCcHaKVTx0IaGnyMF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777749814; c=relaxed/simple;
	bh=FAGsMkv88mX/zx83/taYX3icIej5GsBYQ0nC3mxeJqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEhqoJF+hMVRko4155DMOyS2C3QmlyBabtiHBKwXq7ipzM2FyW1BoZNwslPmz66F5LKLf7Em9J8lB3bz3xayDMCitalK2b8cNFfjPkqKUwqZcdZHoB6ojq4hT+wikELlSznmKFtUAGPtOcWQzkJkhvvgCGWMBmKTjULlpsgwc+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UE1e8soT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777749811; x=1809285811;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAGsMkv88mX/zx83/taYX3icIej5GsBYQ0nC3mxeJqo=;
  b=UE1e8soTZ/BD9qPj5GNjC3PGfAQFQ43VdtjXmXwiQeymqrVVSR0p/XMJ
   9J6MEeAgESDoaUiFYOLstPbDBbh4ge/5/TidZSR2XuJyU+mOFOz8ZoiyR
   DW6RzuyjtwuFIIBTL/LtvhNj1KO4ztAjXHBtvq6x+xfeIswxGEFw65VsR
   FqKewaSd9OgtR3L53LrCTKvbBkD9xD+VEY+EpbVOZyfc0uU4HY+o8Iufq
   tMoHR/8HiN/7E5x6f0bAfY4CxYwOP4GvsP39cOmSxVrv7dkjtmKgH+7iG
   2ReC8BKNbfeTh+mFBP/J8i3UgVeLfjW5I4k9SicJGfVt/z79F0z6vV16f
   A==;
X-CSE-ConnectionGUID: 2GrbtxfNRKyP+69N7IOmiQ==
X-CSE-MsgGUID: YMAEfsaUQTa9XLq1TFcEIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="96238064"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="96238064"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 12:23:30 -0700
X-CSE-ConnectionGUID: nCn6lUOESDW2Fkg2UupQHw==
X-CSE-MsgGUID: z2LhOgRaS1uI1hvDnhm3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="232002119"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 12:23:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 2 May 2026 12:23:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 2 May 2026 12:23:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 2 May 2026 12:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkhIo+o8PxfXfod5iENVbrijkn1OrfK6xv2MurFcREl66zNGXOGNaH0Bac3Vgsq6egl9XMTbwzYuuKvzcuvivIWZbQQ2CSlgqFL/jFGu+nkdMaPG9cteA/CODTlBVEkAW850KHnHVES0NGq+tnggyPPULKSUIXPoHNir/mHjsIanirCxUZSF6y9sdnKO9YJ69brQsX+6DySCXec2CMIrP214eiAjM3beg/35Jfd0tsL2NIGXMnc7ovtSP9zEOMlNMDdbJ44HCRkq7w+9V6uAsa0+2GV0nyBl/L7zPTVaW0gnQLoLePiO9QeH4u+B05msM0SIWh/o3uMyEaWlIbVNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDOIf40RafGshdrVQ/W8QG2WSeYSuoEvYjd/J3mfJaI=;
 b=ai27eSaJaJ0eCrCLEQvFg5AER0w0M10r094uQgBKcXLMsZBlkk81fr+o1hRkgVNaPuhzOXZRkFJsVXLvNSzg4T8mUafEkqtxnrGzbGmAnVFKR0F8dXYnn00Ef/F4o2SV+a2P8C6okxoZv7PRHeHPdZG/9NgtiN1G2Xzl3DDutL5s1sHHuOnsFtosWcw2iMctLNz2AD0G8UHWBE5jrTi8ejFOczLw0IDXZAQ6OJLa6RKK4nKUawB2n7DUWqOzn9v8J/mmqqdlR+dJ2K8pl0TKLd2QERV+W8hWTZkjrRBvBrF95H9PQfqeAG4ywGsDbcKVa6QuEDj0CLmeeaKa1R29Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SJ5PPF8A49C4DF4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Sat, 2 May
 2026 19:23:24 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 19:23:24 +0000
Message-ID: <562f5687-3648-4912-b230-233d0c23bd70@intel.com>
Date: Sat, 2 May 2026 12:23:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@google.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, <x86@kernel.org>,
	<stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
 <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
 <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com>
 <CAEWA0a5=S+C2pdViHPWykvG0Dj4hbuKFVhSnEzpPWoyOh4oAnQ@mail.gmail.com>
 <c4fab3dc-1627-4775-986e-6b3ea52e7c36@intel.com>
 <CAEWA0a6nhZ1nXCLeiCdnKi5SjUHiP9w0jO5wuTwVoPO_JYd9hg@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAEWA0a6nhZ1nXCLeiCdnKi5SjUHiP9w0jO5wuTwVoPO_JYd9hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SJ5PPF8A49C4DF4:EE_
X-MS-Office365-Filtering-Correlation-Id: b1beeea8-e99b-42c3-4c78-08dea8804727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 70/3PVcD15k2EZznoTTWsrDsVBc3EO6y+FyOZ8wWSUEgFPQloQRQGPDu+K/HFUxm0cIRf9oE+BJsc8DYch58ABFllgpsDytnHun6HNctAgoZKdq/bW44OweVUgKnvYgYLaRd8mPxCgGR+diy6FO8l+DpkWFxTwPXGTSwjfgVtsc5w9r3J27uGrN6+rV6kRn4aT21Wt9v4GkL5/dJVkLuX60T89aVVi7nsnyu+GysrjRSiOCMsO993EjONwUpShfW2CGXMwwPraMvn3FPLarxKzo1GO9MvkVUBvuN/a3haFA1A2nAZNrAECBPbSQXzmz15ySp1mQ1eY5Knsyzt2ZV5talnutsZ9dkbHQymXlAslp15Ii+GiC5Ki4jklCLF3E/suNAWNnZWrZ95aWDKSmDAW/Erh9z5OWDwtF+dqm86DBOq0tMciToLzaWa8gy8tooWk05oFO6swnZA5D+hbWiQGIywRuTI9lz3sd7ClGXRy8lYJUAdYsSjWsxlvd0b41qyzso5J9h5Wx6vEA95uXICjcjmxTu/1GuLdDFoFNlWyUMCMJdIMroc6H6Hm7ZYkNWX+jalyXF8Eg1BTE0aKoiKT+ipFMYy6kHPVgbelVa66hybxM+QaiYrgL5Ch9oB5oQ4FAr2ltlhnGYIdlL9FhsIxr+Xx9LOvl/84h5OkmiCK3Bev/yWlQiFbgqpyXH1P1r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T211TzlmejBmRjg4Q0JvcldHWTFOOW8yM2IvMWw5eVJ4LzRvbk1MUFVwUHBC?=
 =?utf-8?B?M004eGxScXFhRWFqUTNnODNoTEQ2algvVE8wWFI3RzFEWHJUUG5WbkE4Zkxa?=
 =?utf-8?B?L3hoZ21YR2FzRkdxZDNzTUo0Q2JEeVdjYVNwMHJSZWFTRmhNeTJjR1RmS3Vy?=
 =?utf-8?B?UVZtUzBJeWlXV0I5TkF0aldxeVJGdSs0bGErTHdsVHpyWndaMlNFcEJRcThO?=
 =?utf-8?B?UDhTbmV5ZFdQcDBFRFNGaW1rU2RDTkxDd1ZUQjFoWWFkK0EwYVpaRlJlcy81?=
 =?utf-8?B?VTMycnh6MTdrU1ZHUm9paGRPSENxUzBjaUd5aTcwWUFndVhnT0M2OHo4VFYv?=
 =?utf-8?B?ZGJwRTh0MW9uUEFpUkxBTmZ6ZDgxL0I2TGEvRHVveFBiNWlNMTFlTUcvZGhU?=
 =?utf-8?B?SU9ETXk0dGwrM1lSbVFHQzNSeEFkNEhWM1p6N281T3FnS2J4NEdkZVduYXJL?=
 =?utf-8?B?ZkRRTXBWdisyNGcrTXhGNjkyQnh2TXEzcnZNZVpObk9GYzdScXVQWCtBM05H?=
 =?utf-8?B?QnZxSm92YnBNNTJIVXdvbGYzQ1JkRyttMGJFS0VPTDJTT1doWlJNdVI5QXE3?=
 =?utf-8?B?K3RWa3llUXl3N1UxZUxIUHk1NFFua1l0L20zeWJoWFF6TFBEdXF2T05KaGFR?=
 =?utf-8?B?R3NTRzZHNlhiREdYQjBtSkQ3K2JiV3hoaWE1bjQ3Q2ZNTWJ3WVBCcnBaRjRQ?=
 =?utf-8?B?dTJCcGZhYlMrNm5hTGFsQWtadWRoZjN0ckhxVEV3Sk56cGVWK1MwQTY5OHJx?=
 =?utf-8?B?RjBLeWQxb2c5eUhiVWIxT0MyV1N3b3p5UFJzVVNYN1g4VXoxL0JQWFlyblQ2?=
 =?utf-8?B?RWU2b0xVRGNXaXNTYU1zUHQ5alFxQThNYmRvemVWVHdjR2wyeU4ydmhMdUIx?=
 =?utf-8?B?VVFOV3ZSTUgwaXBtVWE0ODk0cVlCRFdOTVNlTUtpY1A1TzdKQkRPUnB0SWdr?=
 =?utf-8?B?NndFUjk3MnRKbGU1ZHJxUkpleUVFa0xCUDZESGY3c21lRjljTHVxbEtXOEpE?=
 =?utf-8?B?UHZweUFvcDc2NU5PNnBja28zOW5LcFFNaEszQTl2bDN5cHN5SC9zcGk1d0xD?=
 =?utf-8?B?eHlwWE5NTWFqQnBPOEpJYnVJZXIzZ21hZndlSjlORndoMmlBY0Rxb3pBendq?=
 =?utf-8?B?ZlI5YllNd1U3Q1FseUNvRjdTRHdXQXZoclVVNGtSOGlWVmhzNEU5SjUvZ2RT?=
 =?utf-8?B?Wng1YStIMFNFbXJ5S2JTdGRGZ1J5V2tSM2hDbkJEeHMwdTdIL2grZGFNbXdJ?=
 =?utf-8?B?eERSc3lkaHJnTmZmRytYdFZtOElBM0NJTTdqVVN4Um1aWDZETVVOT3J4b2ZU?=
 =?utf-8?B?VU9pczI2OW9ZREFMSGR1ZXZLZFFRenQ3TXVZZDhqaHluVElNSFg0ZWMyY09h?=
 =?utf-8?B?YVZUZlFsQURNakQvY0JaNmo1OWVPQWN3TDlHQ1JiZ0hBbWp0bGcwVHhFbHpa?=
 =?utf-8?B?aEljNTU4SE90QjFYMldUUndSMllFMVFXUEN5NTFlc3V2TmpmT0ZhTk5aMWFw?=
 =?utf-8?B?ODNOUzM0anpxWGd4TkVXWml6L3JaaG5taE1QWEkxL2czdHNsdkhMZ0ZKQnla?=
 =?utf-8?B?S1VRU2pja01TOGtPNWNJWGNNTVI5MDZkVXJYN3lBaFZNMTJCeEZqK2JsWjN3?=
 =?utf-8?B?a1BDR216NkFoK1Z1eEo3azREV05EenpSVTUraGRoSDd4QU43cFpOR2kxT1pP?=
 =?utf-8?B?d01SQ1N1NmRDaDV1YXJWNVpFTWlyOEJDT0gzZFQrc3pwV1JFdzNyN09XWUFC?=
 =?utf-8?B?VDh1ZHZmaTQvRTRkVmpLSDdTMFdkelRNeXAvMVRwWlJKT2xuUENPSGI5OXlW?=
 =?utf-8?B?aWphcFZjMEhBbjZiTmxtT1lPSG90ZHZlM0ZoUVZNKzBEQTcwVXJXY1hZaC83?=
 =?utf-8?B?K2RjM3BkbUErWnVNTVFldHlWaXBDWktjZmg0ZXRBU3RlcnA2OHlTZ1l1azQw?=
 =?utf-8?B?SlRJdXUyTmxDaTdCa1FId2JvWmZBZ0RObGVKYzJORUJqRHd5OUNXbWQ5UFNS?=
 =?utf-8?B?L0Y3RXdxM1ppUGtYMElObFZkbVVQVWJ6cFAzVVAxa0tMOXZHb1VvbXpjVkpK?=
 =?utf-8?B?aFdsaE5lekJ3SE5WVWUxY2dKREhNaDcvb0xuRTN0T3ViL0RpU2ZNNDdMMi9I?=
 =?utf-8?B?SlNGOVB3OUdtTUdwRDg2azRZUWlpR1RkYnRKN0loNFlZNVVFUjEyZGNDOGtz?=
 =?utf-8?B?Q3pYaTRxZ1dBNERlK3ZsVmpabHJlbVEwSlk5endFTVRZYzR6cElsQ1JETjBx?=
 =?utf-8?B?QklWZjdtQmg2NXJKMUdQbDcrSU84aUhiN3FhQ2NqajRuZHdwdE4rQUNKVGFJ?=
 =?utf-8?B?SExBZWFvdlY4OHpNNnllNnlFcXlrbkJmdlBTa3E0TXBQRC8yRGZxUT09?=
X-Exchange-RoutingPolicyChecked: aQ1JBLZLe46d+TRle3Ca7kJa0Et1ZyODcTFOA/RqQB9pB7fxpprDCv6XifEgKWXd9ihQjdw6NyVxy90IxGbEL41NVmNlkTcesrTLiQv07LNouYd3i/Jk4vcvLwLr9tiHjz3QJ/ATuIGmNm0bEsVIJhHn5gu0LwsmjIv/LPLlM70v6xYrERb3TQ6vdQoUSvHoSFVmUTL30EhZngp1VxXuD+2iZN+NcWBzndAidOjH2eYvc/tjtukjVTowEdvV6RFvLv4x796NcwU092JAb1dUQmEmUSGZNu0UCzNBEChVfHN/529hU9P5gZ9/9U7siaSyMi8IebmLa99lz+BUOXlzcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1beeea8-e99b-42c3-4c78-08dea8804727
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 19:23:24.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZywaZ9wuW5BzNPT6jalvHnJSKWxtsKyJ2OpNpLW2zpeB54qH8MUUWQc1flzequavjbbKzQpxAsZ9uEfp5vnFVXuTIae7GjXVbJ9O+kf+tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A49C4DF4
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: ED5EF4B3518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242621-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/1/2026 2:42 PM, Andrei Vagin wrote:
> 
> My point is that the reverted change broke a significant, real-life use
> case that the hardware was explicitly designed to support.
> 
> It is the responsibility of C/R tooling to ensure the migration target
> is compatible with the source. Enforcing a magic check based on a fixed
> offset does not provide additional security. The kernel must be prepared
> to handle "trash" data in the userspace xsave area and manage any
> exceptions triggered by the xrstor instruction.

It looks like this behavior has been in place since c37b5efea43f ("x86, 
xsave: save/restore the extended state context in sigframe"). With the 
sanity check, userspace can modify the sw_fx->xfeature_size and the 
sw_fx->xfeatures (independently).

But, it seems there is no consistency check between the two. For 
example, the size only could be set to an arbitrary value within the 
valid range, without matching xfeatures.

If userspace sets an inconsistent size vs. xfeatures, maybe zeroing out 
the garbage could be an option which I expect still compatible with the 
portability model.

It's still not entirely clear to me whether your claimed portability was 
considered in the original sigframe design. If so, this should be 
documented more clearly (e.g., in headers and/or Documentation), along 
with relevant selftests. I’d to follow up on that.

That said, yes, this area ultimately falls under the rule of not 
breaking userspace. So,

   Acked-by: Chang S. Bae chang.seok.bae@intel.com

Thanks,
Chang

