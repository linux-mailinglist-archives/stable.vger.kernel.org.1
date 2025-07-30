Return-Path: <stable+bounces-165535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB9B163BF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D338189036E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECB149C4D;
	Wed, 30 Jul 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xsej/pW3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FD39FD9;
	Wed, 30 Jul 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889595; cv=fail; b=i0aYW0z5Ev1FB+A93t6TlWzd5GE3ZmdUNQHzpPSRl1+HWBWi438N+wBlpLRufzEc0tSu5p9OCTterm06bXZ5dXQIRBXtl8SBK1W0cQPQazYzdlcxXhFM88iIb6War//5RmEfWF2ws8tSCzq627G59bdxklejWEd29yC0ZU8DE6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889595; c=relaxed/simple;
	bh=NMrR9a3aMcZYYrSbGjRRY3LZInlfEUV6hvTRogu8hfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/6fz3DEoIiMpU9c/8YIIuMOzyS5I0iMA/9c11hOnwShTDaMcBQ9LvPDMPqdOQReMpVihEb/QJ1gN/2KN/N9GMQj+bW7SO/i++C6ydmHYCdBMG3tSO/etT2vzYlksI9IS1Z/O2KL3IVM4dnm7p6KDCAaZlQ4YIbYWr36vKCPM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xsej/pW3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753889595; x=1785425595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NMrR9a3aMcZYYrSbGjRRY3LZInlfEUV6hvTRogu8hfc=;
  b=Xsej/pW3BjuUzlSclVImn2oiAcqSlY+B0A4YHFBAm/5RIEqJp+zDvodL
   BszXBLvl2kqzNmnMcPzJJ00yyiT+fU4tqokqHKnoez25JJ7FVO2GnZpMV
   CBtuSXwrzo3lBZpxzKLdnds46bg3ZLWsvaM8Nz7Tn6OTL6P5Y+svaogEQ
   HUhUuPOQsytJdjf+1a3bA/0OdS/BKbg3WvMI7hSUtpEje6sAtOoGzLIqG
   qCT6COPDHm4QnTi7r68mdklxih38LoFeqMPTGltuFeHDlIhkwfhVf4Xqd
   eJHnzE8az7bafk1pBntp928BG3VXTo7tP85GBMeeXjCuNYojlzXrDh9FT
   w==;
X-CSE-ConnectionGUID: xaBc+tf9Rae6T6hrfYh0pw==
X-CSE-MsgGUID: x7R/wFqYRr6Wm/OcJT0pqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56273968"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56273968"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:33:14 -0700
X-CSE-ConnectionGUID: K0gv/SAwRR2rusSEJwnAZw==
X-CSE-MsgGUID: cnel6LOiQVK+Jrvwt2Rahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162600902"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:33:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:33:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 08:33:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoymbGeXH7sE2/NMRlLqPBmGK5d+4bAZvt2GWqTWgV/BZwPW4jH2KVc1uBPafAqCTVl3gwon9bTQBgf9Wisw7xvTy48pcW9l/Rn705TWD6s1Jw/sXC54CyB3EhAkjEJD2tE15Iv/KRaV+dtNKMtgap7pESw5Cf36emGL5z3H/sn7pio+S8F7E8E3IKp9pSNXyooggagl7qA2pGUnmmiHUN6EjCA9FDyYJHkSUkjt2v+D+rQbXRjJsf6HZC2ByNX9TPBUM0VcVUukWenjGJi9TXS/nVfJNtZBLkSHFoU+BEAenNPum2/eYXXGQi0OmuoWTjwtR2KC7BQfJRyYCbeWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMrR9a3aMcZYYrSbGjRRY3LZInlfEUV6hvTRogu8hfc=;
 b=N/puY+oSb1ZmgNMgFwX14ojKpWEEMF/xrOgoJJX5CLjFxDaQQHEJG3qXmZDAbaxltzKbwKx/RbatDUqcScJh0bz6zlcFP91ZU/BcwMSu9g5351ovda9gnHkm/9gcTFMkHVh8RiYibQhfotLSSnwzwN02YRtxn9H/+lHaeK0kMtOgHPx5zcmq+3yGbaLw5XTLiodgn3XMPLaLwCKBR0sdaEAA0IJbuUjkRRXHIWdLbvuaK3xGfVXMQXoJhRpoqZ+xZLV6JjXL2nffPQ2ueKL3mssn+KU01nu02YdC+DrMgbI0+M0dhETMq1t8xZz6pPs096b0Bwxdr80ycRmc9eeUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 15:33:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 15:33:04 +0000
Message-ID: <834f393e-8af9-4fc0-9ff4-23e7803e7eb6@intel.com>
Date: Wed, 30 Jul 2025 08:33:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <darwi@linutronix.de>,
	<peterz@infradead.org>, <ravi.bangoria@amd.com>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com>
 <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bb46bb-d2f6-4409-9bee-08ddcf7e5efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THQvWHgzcHFDdHo4Z3lLT1A2SDBKRnVFVStYUldtb3RjbzBjMkpFN0JvM1ho?=
 =?utf-8?B?dFI3YytsOGVHV3RKTU1zSFNLWHdoME0yQ3dtbk5FdDRZdW5ZWGhhWlpsU0s1?=
 =?utf-8?B?Slhic1NvTSszZ0UzMitkQmQ4L1hOeXo5VlkrU1o5aFcxTy9BdGZHSnlOVnJx?=
 =?utf-8?B?U0RPaGJrYy9jWTdVTmJwTUVKWHkrcklpaERRcVQwaFNQYTF5OUtGT2VNS0lL?=
 =?utf-8?B?blIvTGVWZU93dDhzTUhsQnNQc0Jpck43M25qUmkyK1RUUllyU3BkSXkzOGlo?=
 =?utf-8?B?NkNXdzB2RzJQejlQV0xFbkswYzhTN1BBWWtsdDh3cXJNQU8wVTVBZ0JlSDBP?=
 =?utf-8?B?YXhXTnZMdGNCY3lNVXVuejhheXh2Zml6ZWJrWmo4cjFTRTBpanNtc283UUpB?=
 =?utf-8?B?T2I1WkI1bExxSkFKZTR3WTlkcC9SYmNsVG00SmVoazJONHpUcWJFUTYyMVhU?=
 =?utf-8?B?dFk2UVN3ZUdKMW83eW92aStlQWRQQmdyMktQUkhwYlVhNXQyWHVTZjNLeENn?=
 =?utf-8?B?dFBiN2ZKSzZsNU0rdW9taGthU2o3RlU2SU9TQ0ZHenY3TUExWXJjTEgrVzg2?=
 =?utf-8?B?Z0lGN3poT3h1QzFWR0hMTHJlc0NnZUcxSXZ2RjVaU3Z6cGJEMmZ6aGZUS0k4?=
 =?utf-8?B?ekYyOXlIR2ZYSDVrSWlPSmJTZGN3d3JJVCtHWWh2dnBseE9Fdm1mOXBZTjhM?=
 =?utf-8?B?Y2VwZFA1YmluOE1EVGFWcEpTWmRZMnFzdUZka003YXdLd1YyZFUvYW04OU1O?=
 =?utf-8?B?RWkyZDhVQzQ1d2toelhGQ2hodDV3NGtnejVFdWcra01HOFpiSytQSVR2NDVp?=
 =?utf-8?B?S210eURCS1o3ekE3RjdUV2lFTUZKbU12MU1vT2p4ZldpSWdrTFFKaC8yUVZJ?=
 =?utf-8?B?RnBKc3JLOFZOdmd6b0xxRmJsZjJGQm85a2NrdGNsK3pOWGc5MGE0dGdpQ3VL?=
 =?utf-8?B?ZzdSRGdxeThJbHRUMXBkalRyaVlaT3h1b1FpZy9jM1ArRXBuemRiMS9raGtx?=
 =?utf-8?B?SVhCUmp6MS9LYkxoSGJJZkNVNHorN0hDa0I1TnN5dWoxTHFpRkhZaHZ5VjV2?=
 =?utf-8?B?NG45T1oxZmxEM2o2czEwY2dzQ091aFI2OG1IdE83ZWxYbEpCZFV2U1FKbDhO?=
 =?utf-8?B?MGZMK1A4QnFhcDBtUDZFSWdIWWRLbUJ4a284NEVaUGRTUm4xRlZNWmNSTjBG?=
 =?utf-8?B?aXdCN3Z2UEF5Szk4TzlzcnZaNGpTTzZ5c255ZS8vVzMzTklFbjB0TGVyRDJp?=
 =?utf-8?B?RVMwcE8xSFRrZWY0d05DSXVOMU5wZmhmbmhySHNuRlRsOHphZ2wyNlZYODl5?=
 =?utf-8?B?MGo5Z21saVJMcTNrSnltOFZVSnVXZThSeDdFQkJ2NE0reGx1bDZhQVZ5SHUw?=
 =?utf-8?B?VHpYWDl2S1lIVk1WT2Zqa25DWXVheUJtYlEzQmFhT3pXZHJmMytGRS9ISHZ5?=
 =?utf-8?B?c0ViNDdTVStzSGxVamRoNWc1dCswZ2NYNEpqQk1SY0ZXSVhaa0NOY1VrRmZu?=
 =?utf-8?B?Y2JVN2lUVW9qaDFaL09ta3JQeWw2bVh3UnRBZDI4cGZjR1NjOEd2YWxoQ3Ji?=
 =?utf-8?B?WDd3OEFiV2tNZXBscjhJaHpqK2lkcXdWWUU2bUI1RTI3cktaR2crUGhmU3Nu?=
 =?utf-8?B?Uk1PUS9QY2ZNaWNkb1Y5MDhZNXUrOFJodXlaZVdoU1NwRW5VU0lvN2c1SG9G?=
 =?utf-8?B?Uk5RSkU4TDVlM3daN2l6YXNzV3NIeC9yMEs1bjRKVk5nOE4yVDFOWHNRQms2?=
 =?utf-8?B?Vnh5aWZVNUdIYVh4OEd0WE8zamZDUkdoYkxVMnFOYmZXalFtUTdZODAweno2?=
 =?utf-8?Q?kb3ZMOaRI3ynYLY9oFq+UxFo4e1nGejFmtvVU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEpSSEdOUFJCUzNvQ1hoSS91OWtaYTBiSUdQVGNCZ0haYVBOT1RWZEhTLzBI?=
 =?utf-8?B?UFhCK25CK003Qm5RSVB6bG0zQWlxcktBQXUzSWs4YlVXbmdvRXEvUFFGeE9L?=
 =?utf-8?B?WlZPaW83bzlOTFYrelpUZU1EMDBSdW92NjB1SVZpaXNiTzFYZkUvZ09KT2Fz?=
 =?utf-8?B?eHpRWUt5QnpsK0poMGMvMGJUdzdHaS96Z1A5Q1NIMzJFUlIzTU80WFkyU1Fh?=
 =?utf-8?B?UE40NkVnN3Y1VWV1UkxsdXFNUHU0MUdmV1V0RUpEbkNPWVZrb1VRaU1GWDg2?=
 =?utf-8?B?NVpGUGRSQXVEeGlnbU5WSlNBeFlXUy8ydnd3RVpiWFpKbFV6SVlVUmp6cGht?=
 =?utf-8?B?UDR4T1JqOEx4V3VzSTBsa3ZqcldNTFpjMFoxNHBQNUtDaS9RelFBVnM2bVh0?=
 =?utf-8?B?S21uckovc0E1eEVBdzgzbnViYUVieGhpZWtCb3pHMlNMcUo2ZndxMldmWE1B?=
 =?utf-8?B?eWwwNFpaNCtHWXA0Zy9RRmJGbGhzTDhWL1hBTldZRTNDbjhBN2Jlam8vQlNQ?=
 =?utf-8?B?VHE0R2U3ZzUyR0VyeE1SdVliTVcydjhFaU5MNVJnZFZYRWQxVzRML05QV1da?=
 =?utf-8?B?eGhwTGwwRWczTk9GS0VINitrNm93UTkzaWcrbmd4S2dXM1FpbEN1bm11L3N1?=
 =?utf-8?B?YjZrWmJaZ21DTUFRb0lpYzJoSlAzRmhsMy9XYW5wY0FFT1JYOGRaN0xyRVpN?=
 =?utf-8?B?OHdJb2NVTS85SXdBdGV6VlRoaTJIK3ZLaGFiWmNWMHdoRTIxejFHTmJaRkND?=
 =?utf-8?B?R3VuMVhuNVhWN1pFbzVtT1pyQlJuMDNwS2xueUZxUU1ENmY0U0NRcU5ZeU5Z?=
 =?utf-8?B?R24wRldKMG5lSjhzM3hMclYwdFFlVkhwOWNEbExnTHJ5VndtbU1sUHBYT05v?=
 =?utf-8?B?NTdZbEU1Z1dCb0o3N2RUWkpwSldxSElpNnZFekZzbjJEUlZyVzJSUXIxN0lJ?=
 =?utf-8?B?QURDZkhpMmNqTk50TDVmS1dGdHhOVERhWHlGR2lxTUtTWXovZlJXOWNMVGc4?=
 =?utf-8?B?V0VLZE05NTY4Ulltci9rVHZwOUU5KzM2V1p2aXp1b3R2MlRheWw2dnhMRWdN?=
 =?utf-8?B?QzMwUnkzNkx1MWxnTVVnUzJxMDlxc3gwQ0VaeHRzcDVYSmZSUkNiZldZM0t0?=
 =?utf-8?B?S21vQWh2L2xqSkNHeGRCUmo0L0NVMDZRckFYU1Q3azJJQ3o5R3RONGJzdFpk?=
 =?utf-8?B?QTFnMVVHcEdFckVtUlpuOWJJT3Y4TUt2OERQMmNMVWRHbFN4VVNyN3ZURlY0?=
 =?utf-8?B?am5kU0kzcDhreDZDYTZ6T2dTeGpzYjlaMjVFNGlqZThkM0VKSG82ODRUa1k2?=
 =?utf-8?B?M1gvQlNjVjAxeU9xTzV4UWJac2JpMUdIaW5kbVBrWk5wY3lUaEJ6SG5XdnFQ?=
 =?utf-8?B?THoyR20wdHBFU1V2KzBGNzZnSERwWklURHZFYjZLV1BpUWExbGRUMjlmTmFF?=
 =?utf-8?B?SDh1aUhPMXVaeFljTkFHK2IxM0RwMVBtcUROVlNTQ295eWt4WmsrbHlvMWpF?=
 =?utf-8?B?MFBIMGswajdScHVCb2o0Y1NUcExNRVh1ejNVK2Z5QlRBSE9wcHpnQ0hlN1A2?=
 =?utf-8?B?SzRGNEJLVzdoQXE5b2Fpb3MzTmV2M1NDa29CdkJySmhOKzRqd085Sk5kVTFB?=
 =?utf-8?B?WGNnSWgwUm45ZUt2MHdRRlBtRlMvSkNHQWxmbk5yYjZ0Z1V4N0JtVTRyaDhy?=
 =?utf-8?B?VVVYMS9iMFdqbUFrUUFIRkVSdm1PcmZYYVh3VWs2TGEzT0IxZ0w4TTladnpO?=
 =?utf-8?B?R05oakVxTVpJRmVKcXI5UGtKY0hVOHRyNzJkajRwVjRXSkxOSCtNcUs1NGpG?=
 =?utf-8?B?cmhUWSt5MTVpek9HV0xUalBDNzJyNEluMnJpY0F2TndQcVFRK2pJekdxM21C?=
 =?utf-8?B?ZE5weTBtZG13c2pEMk1Pb21ZbTRlTW9SeWRpQ2Y1VWV4QUpBc0lOYnNqaFZB?=
 =?utf-8?B?dlF4amF1SUFJY1RQeXhhMzZubGtxd1U0VHRlc1FtbVhRcUZ3K1Z3cG9yMXll?=
 =?utf-8?B?UVJONVh5eXV1WjN2ZFlaRFZ0cnRoY3JESGZmQVRaQ1d2STdJd3h4c2lNWFF5?=
 =?utf-8?B?Wm5PNDgvK2p3K3JsLzRNcWZDd1hScG91djFNbmFSVFEwTERsK2Z4WEc0Z3lG?=
 =?utf-8?Q?VlGdsYxey1jMGGhTX3irsJ/2K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bb46bb-d2f6-4409-9bee-08ddcf7e5efa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:33:04.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb42mnBOutRumMWTodAwgjb/SJbcwa3XMU+qfhrdKdg3FXwgPU+qiICJ8iLQHp/mzYislwQd+YW4T4R0NCf0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

On 7/30/2025 7:58 AM, Suchit Karunakaran wrote:

> Hi Sohil. Thanks for reviewing it. Should I send a new version of the
> patch fixing the minor issues with the reviewed by tag?

Yes please, I think one more revision would be helpful and reduce manual
steps for the maintainers. (Likely after the merge window has closed).

Also, please try to trim your responses to only include the essential
context:
https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying.



