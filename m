Return-Path: <stable+bounces-238365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G64F8hK4WmDrQAAu9opvQ
	(envelope-from <stable+bounces-238365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:47:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD9414B05
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C810307CD07
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480363314B7;
	Thu, 16 Apr 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM/IQHsX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CEA2DECCB;
	Thu, 16 Apr 2026 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372419; cv=fail; b=U4H9WakEXOfPS9m71jsMvnFiflgk4V6F4iOCu2vZFWT1kvnkztoN3TYpYpuklIzkuaxmvAVtkblEEKUGWdmod+txEVgZh9YDENnhnnrECzhqmk/NRy3i4lZ+/aDTtjqkvIF6RtAPHGz0IkGJSAlaHd2W2ImskPuBQBnH8Yrgqxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372419; c=relaxed/simple;
	bh=dEhTlqf50/RFqUeDewhiExtx19AUbR8YsakFsx+qPYY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rxaUEey1frvN8z0l597lWqmT7u92jclJO0qtMk4tu6QHopJvLgYjQSaazBUUisFgM8Rp8cs64vCcaakhPyifh2a6jsm1pb4GES/FZrz+s8bciL2PiKnJXWE5XmzSJQ/x6eYpI7O0UmNgbP3E0ObXg4bEIR7BqsbeUJbuew/FZXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM/IQHsX; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776372418; x=1807908418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dEhTlqf50/RFqUeDewhiExtx19AUbR8YsakFsx+qPYY=;
  b=ZM/IQHsXUebwCCpz9nwyFJg6GvpYYd4V4k34cptd1kp5mfJtlvbmJ7JO
   CBLo0RseVw2T5/I1vmU9eCA4yqCRpd/xfd0uitrEqByiYHzGRAEbkuB7k
   lfxUuX26s4aBunh+tiwq4EdvzT+WbNxLZbmdAJD1reciZh15qUlBlQ+A1
   cmPx5QEPMyV7TdXeM0v32HYUMYlgXX645MaRXJs4BO+J3Zu1yQJHFmcDm
   rxrKcFs72h3Q1HJaA0a/4xrCa7E9+GXtdZP2G3pwDte3x7dfHng+Hm8IG
   kU3AWsfGm7OgXbn0Nzc6BhxI0vAlIP6nzoG8wDiEf1EEj+jl8lCgtAv3T
   w==;
X-CSE-ConnectionGUID: 40SFe3yUTmK47Ae5I6Cpgw==
X-CSE-MsgGUID: UNbXnzueRKaeA3QJ+QcAvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100033584"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="100033584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:46:58 -0700
X-CSE-ConnectionGUID: zfA1oJ0ITPGzUJZuR0n7tw==
X-CSE-MsgGUID: PJ50c5diRfiiZl+iFgKTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="254071236"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:46:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:46:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 13:46:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghSsXfvpK2NEpCyEpWoO70KBi3LR7u5enMAK7NTYujC/haTHcPyaXeQmr1V1Hf0P7nxYgyXVhNgwptljvO0g4mecwE9DwoQDhdLaOtO3MiO42xoSxog5KwbThMF2C1TA3HHmFy83K3sUpDjzMXGU9O5zU+5gOWtkRb4SurQTtzbG3btZKw1aobBq+dyY0elU7XotMlmIGdAQPDyahVaVBJJgBWP1+1GUZGW1HW2iGrEFaRM+lyyAX3SpG/k7+cxDk4nZqYuym2+VYDaB2+OYNf1hdHK7Gy6h86F/RbyeSIcs/3TE9EHCmf5WKD7J4/LabRYpKnKraDO3F+3oESIXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoyqqjWz3g4nYRjzbVSMFeXZjudNnLvge8uqEdu3h34=;
 b=QZjocFUYQep4Is0bU/9bEsw1MP2SdMmnlBZ/LsKmI3TWGWdxj+s8nnBNFAjQAeDk/m6y0tqMzO0Vu7wGspQVw2dprYt4dE8vOk3v9FnW0P+VBAnsFBIjE/M/jJzfkY04dZI50SMUOfmLvoo2gOwTWORZs2s9/6/R0IJ5X23Zyf2xEJb9mAnFwjyzE2VQctx1RPN73DSxTUG4eYLE0tBO/QE0iEy5lLMWMQn20drvgB4x0MRTwhCXhZN5RUsPR5GnQPzYmTk++heaBcS4htjFZs3Tz9cCR88KWrPjmTAqLENKbpaDFJGeYBOYqBAXhcwPP/Ppa0kkXjqneNAXE+NzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 20:46:54 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 20:46:54 +0000
Message-ID: <70776680-1b60-4898-b9cd-bcc48abaac76@intel.com>
Date: Thu, 16 Apr 2026 13:46:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/13] i40e: fix napi_enable/disable skipping ringless
 q_vectors
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <stable@vger.kernel.org>, Sunitha Mekala
	<sunithax.d.mekala@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
 <20260414-iwl-net-submission-2026-04-14-v1-10-852f38e7da39@intel.com>
 <6cc3c5b2-fb71-42a4-8d5b-57cd85de2f02@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6cc3c5b2-fb71-42a4-8d5b-57cd85de2f02@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|DS0PR11MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf6b71a-c83e-49c5-e309-08de9bf94aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 73jvJulFfgQepfV4KyehIm/OjAoBrW9iLWZoJbSQQWSQIe5LsJV+AguUulsfqugJQ7OxkZgyhXYuhi3t9LpQTjPlqnf6yDWCZ97i5lawXodoNoNxhH3z90HQf99mxf96NhAqkuRIMQywJkLjDxrn1DvOlaaY+rTce3rYO//85WhZOor8Jt4+Uqfx8r+bN64HrLBVAn9Pm6POwVZi97vm/wvVkgahRVtKGVnnog1ZWVCQksFSC4AqdXhp4zLKxkGqhb8D64VHwepHsVjDmgBIYB6/OGPI0HmV3qb+C06FJWfPTqTGf6tj1zoYFvq1KJ45VnZgSX2DZUHYF7w+SX/VdMQUEFBxxtsRU7/0eq7KLcVPaeaXqBeP7V3aCGTnUcsQI9KDhcqtUpmwenVqlhQ1YffpSYDuicf4Q6Bj4aAWnN5STrej60aOsnG2XkX+hRcr58m9UMfp16nTuHOZoN/z1kYwCOdv7Z0Lb/Gz0o40pq4dX6D8zSDCZIpAtxIvL+omaClMoUDuNFLdQq7oHVDIedGkV7oTWz12uFZ/JW75yP8zRxICzZIwSO5zF9BAiV+S8GHuqCJd69RqMQNHQY9hvhe2zDfXSXkH7Bntbbu4R83poOtRenHykJl0DVs6ks0F7xkXifQmrWMsi/p7FO61kCXOfsP33h1rqrLPDMjYDmqNpwTzbMiPnx4Y36qK4mCd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNESDMyaW1QQXdlaklwc0RFNUh4bUdCTEdBQm1vU2ZTcW9IYVpRbFhKTHBP?=
 =?utf-8?B?QUhubTZrSFF1aWVJdHJBUUV6UmhOYnBzVDZjT0Vxa21INzlVTXFLLy90dkMr?=
 =?utf-8?B?RGZRbFlsSFVtUWxpUW9pSXRFY0tMNFdVOHd3dE1LazNKR0ZvR0x3dGx6UzJE?=
 =?utf-8?B?c0xOdDFVYjNJc3VZS0xEdEw1R0d0WllhRC9OL3lKa0RyRlE5V3plQlR2cnZB?=
 =?utf-8?B?cy9mVnVBWkVxK1NTUWszWDVFRjhuaC9uZHpzYUdKR2ZnZlVMTWVvbGUzOFQz?=
 =?utf-8?B?OXlVRWNIczdaWG83c3kzVktwV3k3OS9wVkNVZWc0WjZEMmdhL3FldFZvekp4?=
 =?utf-8?B?WDBDK1RVejMzWTNoOEtQSm9jL3VscmtzMkxYMkNUNFFBbGRscnZaYzZReVFC?=
 =?utf-8?B?ZjF3bmdnckpURncrNW1YZEdOdjdsNU1iaTF6Tk43bHFkU0tSMXdhLzRCckth?=
 =?utf-8?B?cnU1N0VHYW8wL3lRVm1hbEVuMWVFdmJPMXVteS80KzIvakFJUklqQkpxV1lu?=
 =?utf-8?B?NHBPOXhiTU9LYk94U1dQQUI3NEUvSGp2c1N4bE5Xc1cvUTZndzhVc21sVVNF?=
 =?utf-8?B?UVNWS3ppbEZsdy9oejVnWk45TUdTQlV6SzFBOENUZlNBTExnQ0dlR1ptUWd3?=
 =?utf-8?B?djQreVY1Q3VHdUFsWjdCYWZSWGpMTlNLZExtTGtZbXdzc3RHbndIZjRFVmoy?=
 =?utf-8?B?S3k3TkZKRlNocU9hTTVESUk1elF3OTNkZzY0eklib1dxTjNCd2pUclVqenpy?=
 =?utf-8?B?QmxFMkIwbnhZeEJiZ2ZORzlYbWpSM1lycFdsZUV3OGtBTzc4UVdNZjRlU0hh?=
 =?utf-8?B?aTBIbnN5QmRjTTFtSU9vMW1ETmRPd3NqdVIwNGJDeDBMUUE2Q3RoSEhJR0N3?=
 =?utf-8?B?VXFQVVJGeVNYTm5kOWtvdHRVKzMwdzhia2MwTGVjdEpDc0ptOE90bDFSVFJT?=
 =?utf-8?B?VVltdDRZaGdhSm9jc1VEd2VBUjRxVlA2UVJKbkNVaDRSa2xlQ3NpZUg5cGtZ?=
 =?utf-8?B?bVVPRmx3ZkQvU01ZdnFzc3pXRVgzTDRaNTVJQ3RMek5ENGEveGVNSDVab1Zl?=
 =?utf-8?B?RHlkQTNmaXFJSmpMbVUrSml3a0RGdENpdlJlalJiUGJ5TU84Y0t6Q1lTRHZC?=
 =?utf-8?B?U04vZGZYMXUzOVM5am51Y1J2dnkvd1BUYzBrY2dJRkkxdHNsUy9xQXFSUktX?=
 =?utf-8?B?RTRSelVPR2RNeU5tcVBTMlo3Rkp3bk5xZE0vNFhyZkhseTRhRUZsVUh3MG1J?=
 =?utf-8?B?QnIwQUhvNTQ5cjA5UzBTNUxQcEM5WmhrMGIwR2tJeERHMy8yZXJ3NGcvSUFO?=
 =?utf-8?B?d25vSm5oMjVVWFFiSEVJQVUxbGwzUXFNWDVNK2lqTGhXMi8xMWpjOU9PbHRj?=
 =?utf-8?B?OWtTdm9ZUnZOeFRiK09DS1k3WUZpRXNZUnBKOHJtNGJXc3lpcXordEVkN0k5?=
 =?utf-8?B?ZHVpZ3lGellNNkcxMHdlSzROYW5XNk9FaFQ2M2UxR2lvRUtrL3JzVDB6UU4x?=
 =?utf-8?B?UktuMEw3M0huVlF3U1AyU0VRTEh5U0FsYllUeGRYVkdIRzkwaXF6NjlJVFlN?=
 =?utf-8?B?ZWtSb3JMejJVWTM3OG5odkdjbFR5ZzA5NU9sdWJjb282YlZ5NFIybWxtNy84?=
 =?utf-8?B?MmpDKzNNSkFSczlOYXZ5dzRYT2xwL3MvVTN1TTBIUEs4SklKbjVuOWIweXps?=
 =?utf-8?B?YmJQU2FrOWxjSzhSMzg0bVAyMnd6SXBnc003WFNoa0Z2NnovOVhDYytrbEJ0?=
 =?utf-8?B?dXdqSTc5U21GVWVtQzNFN21RejNoS1hnK3pLbXFKTnVuWHBNTDdWeEw2T0Rx?=
 =?utf-8?B?WDludGI3V2lOK1BGaWc4TXpxd0lRQ0szbFE1dk1HUVlzWDZkR2d5ZTArbjZI?=
 =?utf-8?B?QnVINUV3M2NOazhRbWhOdHhDbi93MUZqWW45ZEJOKzUzV0dkZ1RpcVRhZjl2?=
 =?utf-8?B?YW1CYWdUMld1SnhrR2JrT1B5R0J0dWdZVWFDVXlka1oyVlZzNU1rdVJRWnMr?=
 =?utf-8?B?RjRNYnZvSGdJa3FEVFVQQWtmOUxNM2J0SnRsRTI0dTNjWGU0Rnp1TFFOeDVG?=
 =?utf-8?B?Vnh5TjFIQ244RGN3NTJXc2lsYnVPU1UyWU1yMmVXdmxlTUhoT2lzWVYyZ3B0?=
 =?utf-8?B?YkUxT1IvRnFoYTU4N3RKb1NHMlUxUEVITmtrTlBwcGU0MTZTMDArSUtJbk9v?=
 =?utf-8?B?RDhacVJrUTVnSXJRcGpQcFJNd3czdCtJMjFVRHdLQy9rU1ovTlYzaHN0a0gw?=
 =?utf-8?B?cjJLd0hKeS8rdVJNSkRxV3BIOXRNRytvcWhIWGhnT2h6Z2tpMmxjRUFWOEUx?=
 =?utf-8?B?YnpjbmJPQytMV1REYVNQWHNGU3crblY2MlJ0VmlhMjAza3FoYVk2Zz09?=
X-Exchange-RoutingPolicyChecked: hcwHWePHr4e9u+N/4HWFRxMXoMv4nDMoiELqe0bYVuG1VY9DWiW2DthmtIYjZtBnFXxTK2HijztmCJJBIYSMUkoCidg4bUutcMpt3T1AaCFJyZ5+YK/PMjGlyPMUy6A2li+7WDSBozR9JH7BeJ/TcpCw0kc4IPXm2L3Us/YEov5TRaYwn9YcIzrpOLkL4OwOXylQigOPAUqftCwt4XW/KRcI72np7CzQfbMwG7qI8g39YYvSYuFl2P5Fl5HoXDwYS0G3ZaQ7S4Kjt2/s2LpSntysC7Z/+77feZ7LN8jW1sQ9Z+GboBMFEJ4Fu1WY474t5aV5d/gdmGmaOpftbum5PQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf6b71a-c83e-49c5-e309-08de9bf94aee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:46:54.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AF03pZBp0UxZdq1JHlIXdvqzcZsfk5lFBF+GiZlEJ4Jr8RpLpGTcFVUZdEeIZXgkBS5fY6ewbWAMqhEBHzpUeVRjoAkwxuxetyPDzreW98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7408
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238365-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0ADD9414B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 9:20 PM, Przemek Kitszel wrote:
> On 4/15/26 07:48, Jacob Keller wrote:
>> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>
>> After ethtool -L reduces the queue count, i40e_napi_disable_all() sets
>> NAPI_STATE_SCHED on all q_vectors, then i40e_vsi_map_rings_to_vectors()
>> clears ring pointers on the excess ones.  i40e_napi_enable_all() skips
>> those with:
>>
>>     if (q_vector->rx.ring || q_vector->tx.ring)
>>         napi_enable(&q_vector->napi);
>>
>> leaving them on dev->napi_list with NAPI_STATE_SCHED permanently set.
>>
>> Writing to /sys/class/net/<iface>/threaded calls napi_stop_kthread()
>> on every entry in dev->napi_list.  The function loops on msleep(20)
>> waiting for NAPI_STATE_SCHED to clear -- which never happens for the
>> stale q_vectors.  The task hangs in D state forever; a concurrent write
>> deadlocks on dev->lock held by the first.
>>
>> Commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no
>> rings") added the guard to prevent a divide-by-zero in i40e_napi_poll()
>> when epoll busy-poll iterated all device NAPIs (4.x era). Since
>> 7adc3d57fe2b ("net: Introduce preferred busy-polling"), from v5.11,
>> napi_busy_loop() polls by napi_id keyed to the socket, so ringless
>> q_vectors are never selected.  i40e_msix_clean_rings() also independently
>> avoids scheduling NAPI for them.  The guard is safe to remove.
>>
>> Add an early return in i40e_napi_poll() for num_ringpairs == 0 so the
>> function is self-defending against a NULL tx.ring dereference at the
>> WB_ON_ITR check, should the NAPI ever fire through an unexpected path.
>>
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Closes: https://lore.kernel.org/intel-wired-
>> lan/20260316133100.6054a11f@kernel.org/
> 
> Maciej developed a better fix for the problem, and he explicitly asked
> to not include this patch. Please drop it from this series.
> 
> Maciej's fix:
> https://lore.kernel.org/intel-wired-lan/20260414121405.631092-1-
> maciej.fijalkowski@intel.com/T/#u
> 
> ask for reject:
> https://lore.kernel.org/intel-wired-lan/
> PH0PR11MB75223C8A00C3183C5082A096A0252@PH0PR11MB7522.namprd11.prod.outlook.com/T/#mbac55f7219d7855a2e5d1527904b2da43ad080cb
> 

Ugh, sorry for failing to notice this when batching this series up :(

Thanks,
Jake

