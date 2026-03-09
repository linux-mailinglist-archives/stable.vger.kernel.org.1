Return-Path: <stable+bounces-223470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l83NJZsbrmmN/gEAu9opvQ
	(envelope-from <stable+bounces-223470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:00:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C7232F8D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A398B300FC4C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7D175A5;
	Mon,  9 Mar 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9U8bK8k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8C12CD8B;
	Mon,  9 Mar 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018006; cv=fail; b=oXtibpIl1ejn558IOU232F88TTjhF+k9mhqasG+rhmtzy2Nhfkws+J3clJF/C1AS5udmYpweRfGAn/W7oNLX8fhnm7ZwnGxTtCZT9JASR1949gQlsF6i2SY7rSwuT1YjIBozyEWnsgJS5HSS52HQ351VLD3+40bcef6twrld8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018006; c=relaxed/simple;
	bh=6qM1nKIIXUjyMyJdzkWq0eTfzTsuZ8ULJHRF8a3P1Ks=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FOduV3m8qXkjj/mpqtRaZ/tSpfqJhvfQ01dooYocZxj7MjAUEI0NLMGzQg08DreozLeiM11qYWK5FCCtavh5KohuCz19xwfpGJlvYBMZsCSDaFZTpU//go59L8baMNjgrXwTLDeGXnzYGYxa5+yKnszZa3SdGGfmBD/aJgPSn0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9U8bK8k; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773018005; x=1804554005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6qM1nKIIXUjyMyJdzkWq0eTfzTsuZ8ULJHRF8a3P1Ks=;
  b=X9U8bK8kQmIxzhXl8exnnbw8gBnue0/GGQXhS4F6iwFlgGqNjDG8S4zc
   cPXQAz5nb7RhZBgJ0yFgzoTWTvTIzWi5LNMvxwgaq4OxdhqiZCae+rTwp
   /I9WGFj7D5pPj1bzHZsFFYpJ2sYEBCaPOjjPka+ptZ3cTQ/6vWyfTKdnn
   lqEYGq1HKRyXKxV+sSxPedmSDEkDG5PlCuDBalF3Uhm6AB/UZYqLSTCZs
   Cf2DHrfe5mvEBj753XfHHyjklmFqhIBFPWSrAP+lXBhcWMT2zWvb0fdkR
   EdHDRrAj0OBfS9U/wbXbjLM5hxvpZ7g3KGrBfzTvSQf5eXRJAcUVMh1Wi
   Q==;
X-CSE-ConnectionGUID: SWHkH21eRlO74AmBX/i35A==
X-CSE-MsgGUID: nEX9WS70TLS5scDNTgHHmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73911958"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73911958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:00:04 -0700
X-CSE-ConnectionGUID: mnetb0oPRzaQCEzVPjdwaQ==
X-CSE-MsgGUID: Vfb4Yv5HSUGM5kW4VzRR0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="257517583"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:00:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 18:00:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 8 Mar 2026 18:00:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 18:00:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqoGax3JIQONqmD3uaIjRaHmGiuq6u9j4edS+yTyS4Goy62STa1KDME+kXCeztD0VRk3jh2YaJ/dmQXTxlS2bRYFQ3uFz1X352eDFXkTJZICXXGJkMkF9WPBytqYeXnY78s/rpIM1mW8e9iBqrP5TR3Y9C4p3gssE1TT8M2tW7GdS3V0Fd57LsQzoKX9dwE3PHNde7ws5zQgxBdCgclhi2ZjTXWiiRNRttujWbpsGqHIoemhiEjuN91bD2Q3EQ1bhLCQ6pZwJ+An3xlDSAwiTT28ucbKsIeitLwx/T11vjF2cpGuJY4YYVGczJCYR19zm2tDXHTcwrGDqgzZQ/UNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LsLJnGXD19ZDaVBex6oyN5W7v+VZDjU52e4fxsDVzI=;
 b=rJfUBrNof69rXz54h5YQ6eltanwwROKNgNb12M8Pp/71dtZ5k4UfY/1HC7QmaSICsp+uqzyAfN6/7sf03/Lo4lP8uFI0tgo+oXaNpIueoSSkPAZOIzi78eKJFXU4ysFfRy2Q8kDRWCgEkua+XRZw8WM4Lk/kDzgiflr8gVdv+uvld/OOHBtrY3Na6Lqrqq+NCu6mRchmSOKGFUyvUOZWw3DCcqZtZhu+BSUWkSUQhms2++s9u8o7xb2c+5yeSxPPA6lVlhljP29PDCu8BCELYvgRJHFB3RYxV3wZ9gu5EXZDDyAx5BjFafwBaRmvFYXsSJuHBzgShvu/zkyEgsyFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 00:59:57 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 00:59:56 +0000
Message-ID: <22de893b-b8ec-4379-815b-e5c1a650d97d@intel.com>
Date: Sun, 8 Mar 2026 17:59:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/x2apic: Disable x2apic on resume if the kernel
 expects so
Content-Language: en-US
To: Shashank Balaji <shashank.mahadasyam@sony.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Suresh Siddha <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "Rahul
 Bukte" <rahul.bukte@sony.com>, Daniel Palmer <daniel.palmer@sony.com>, "Tim
 Bird" <tim.bird@sony.com>, <stable@vger.kernel.org>
References: <20260306-x2apic-fix-v2-0-bee99c12efa3@sony.com>
 <20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CYYPR11MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 8257d162-688a-41a9-70f6-08de7d772e71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: iNfjun9pm8MEck9JKpiMtC0fU8QuwdDmuR6IE9dKbwTfouYBWVerkbOcUAXgcZ9i+LvoHMpatCSK+q2PaTMOmAhIG3BFE65weLiNCBrEfis+pFbyJK/fKNZHPB90mZN6kP3kNLsVtY+QGeLrE/YucJMAa2mVwiu2RY7Uo8wE0ePoFQL6qUDG2D6+hvNOiMdwWzylxK6/H0iGDDTgTGrX+ARC8dAUUjBjHy5GE+KbRcor5gODBi6nj9dPSPTUyul6uVuJ17jWVb6bYiTfdWqwQ5ol1PIgM1ord3IqP7ufiIJSytWtqiRtCsdDT7QcLnrUTAwLymiflWhal+4L0YoZK/aKAXc6C7Z70u1c4Cl7pwShsoQDlgEjOMnpsxUVcvXBrU+lgkstHlLDDGdkC5AxnmAJaACIq7rlDEYZBFdRQXyEWa8kqULnqMm2Y1BFxMeVmu9BxZNM1JlL0t9TVqnyYCYwwN6lscae/uJMOAOHYlLxixHzwMSvPpiPSQrqqRCf8/ShzaYD7Do2ZE8Kk0W7v8/Vfi+wOUUZszBI5a1otHqK++nAjXAEyDxU6lf1P1ZEUvF62MLXAffLVQCKe5QkE/2G2eijo78O83mzBNMvMF7Dz7NqcNoThF4M07JM+xCGNABo9t4YQyu+BthKB520vMuACnmVkR581u7bZNxyF2Jqxwl+E8BZqd2QNJLU/hEIRVUXwbffOZiBGAov9EMavA9+7bLvg0224aJc1ntibB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hBbCtnOFlUQUtBWGIvYlZLRGMrSjRCS25sY1dPWTlHbTcwNlBhUVN0VlFa?=
 =?utf-8?B?SmxEYWdDMUFhVXY1TEJ3YTlsdXBlK295TUl2MEE0dUVVaHJTeDhzTGtHZGg4?=
 =?utf-8?B?TWFSakVFeFFSMmRLSldLSHgrTytPZzZRMjczN3ByNERHdTNmVWRIZGVMWkJK?=
 =?utf-8?B?VlVZeGNQNmg1TUdSNjdEdGd2aGQyNUdlb1hxWGx0NXZPb2N6U0hiaW9iMFVj?=
 =?utf-8?B?ZjZoTmhoQkNmKzdyWEFaakxGeHVIRVRxd21YaXYxMW1ubnRnbEZzbm1IVFF0?=
 =?utf-8?B?aTRnSU5Xa2d0alV6T3R0aGJGbkdmeUd0THdXei9MVFhnRHNMU1lkR1RPZmxT?=
 =?utf-8?B?a0drVUNXeGVWMkVBVnR3R1JjRlZxcW1Ja2hwMnhhTlZJbG81QWJGdWVtdEhk?=
 =?utf-8?B?eW1ITjZXanpIVDRkcnlEcklrdmhMZGMvankwbHl1bmE0Q05yWjlxMFVpbG1D?=
 =?utf-8?B?eXRwV0IwNHViWVAwMmh5eUx2cXpVbVdHWFdqTVJPMmJrYTZ2YWxYM0IwRUJK?=
 =?utf-8?B?RytzUzg4Rnc3NzdmZlJ2aHB3TVl1LzF4eWRRNTErNXJsT01jSzF2N3pUYitR?=
 =?utf-8?B?TVNOWVdRcHBERTlBUHZLVUlpVlN3dTJNam9EYnk4Qm41UWRvbHNrSklnaVJr?=
 =?utf-8?B?QXFIaTdVVVVkKzFJV0psNDJhUlJBOFFocjB4N3RwTVo1MWkxcmFVdGtvTm5h?=
 =?utf-8?B?bm9FM1l2R3dKOFduZTB4V1lLTFRhVjAvM0dBRDk5T2xjbFBQK3pIalcyd3NF?=
 =?utf-8?B?R3JqVndTdVYyZHVDRS9FcHppZzRnN2RlR2syQ0Fwbm5Ld0pmNjV6NmpxUldk?=
 =?utf-8?B?NC8yT3A2RWFNY1ZqOG5QSkFQSG52N2dLMVgvNkNkZ1RTRjZPajU0SUV0OWNs?=
 =?utf-8?B?Rzd4aG9RU3ZPKzk4emp3R0FGRUtnd0RrbDlCWWhqYXAxVUNtREVaVkZpRENQ?=
 =?utf-8?B?VnlvVVlodXp2YVcvRW9YOGhUZEZWUjBGblJibGljSVI0SnRra1FzN2F2Z0w5?=
 =?utf-8?B?SmpRSW9nK2I1SnV0Z3dScCtMdkovMkhadE9MVkwxNldvY0lSeCtjUUJZY1FM?=
 =?utf-8?B?TWYvQUNGd1JXTmFTaGwzSGU3Tm00RlRwZVpxeWI2N1Q0WHFmQzV3Mk9jR1Jn?=
 =?utf-8?B?ZHhPZWJoYTVkR0dBOVNLaVZhRjA4QmFwV3ZqQXdTc1NOUjI5UERBRUJzWUlv?=
 =?utf-8?B?Z3B1U3FWdWNkbVcvenlyb1g1MmpFS0V0U1RKTEtnYmxRdis2OE1QU2hrMEZU?=
 =?utf-8?B?THF2L1RQZEVibnpCVm1PK2c3Tm5pY2Y2cHFGTzlzOXJBL0ZpZnp0NnJWMjVi?=
 =?utf-8?B?SlhxemlqQWU2aEtvaHFHS1BOVWIvZGF6R2ovaTE1MEZhOCtXRHVFZjdDR2lQ?=
 =?utf-8?B?bCtkZW1qYit1QzlJQkF0NkhyeXI1aHZIUFppYW5TdlFHV3ZYY0orQ3c4a0E4?=
 =?utf-8?B?ZTByMncvdWNuM3FpSnFJT0FuaXc5QTNFckp3SFlidkxHOXlLeUtKc1BKR0pw?=
 =?utf-8?B?WUU1dlhxMHNuT1R2a25SK0ZCZ0NYVDQzd2wxSWRaaGs4WU9nSXI5NUxqekpP?=
 =?utf-8?B?YUljQitydDhXWjlpMHN2aFRBL0cxU1NOaXZzSXE5QlY3NFpxSnRJT2IrK1Z2?=
 =?utf-8?B?U2ZlOUk2VGtlN212c0lWbXdUUm9WRFhCN3dCNVdrdnJOWFlDSEJTWEttRjhX?=
 =?utf-8?B?Z1gzWkR6Z1lBWksvTWF6SHhxRTQvYk9EempVWi9sWkM3Q3RVMGtpVDVVQ1VS?=
 =?utf-8?B?VFA1TkZoUWtuN0ljcEZUVjBSV09IMWwxUm1FMFVidjhGUlZCS2hadDlORUkz?=
 =?utf-8?B?cE5BajRKdU1wTkwyVzBURG53WFVvMjJXdXhMaW1mcDlQdUtBTnl4TGtjVnN6?=
 =?utf-8?B?VVFpK0taLyt3azBXOFBYY3BUcFdNcldTcEtOcmZxNE9KRXU4WkUyMGV0ekF3?=
 =?utf-8?B?MlU0Rk0yemNmVytqRVZqY0FlVis5TnlSVEpNeFlmOVVONEZCcDI0MEN4Z045?=
 =?utf-8?B?MUFubWI3cDFkOGd3c25VWFBDNkhXaEpqeGo3NncvYk9TRkV5VW5oN1R5RjI3?=
 =?utf-8?B?RzJnbDJyWWI0aVlob1dHTmxKOWtLeFp4M0ovUXVqaGVpdnVVZVZRTGxPK0U0?=
 =?utf-8?B?ajlmMGorNnlvaTNPS1BkSE1WSWMzN3JUdlYxS2YrSXU3Zm1ydGlhMXVsZUdC?=
 =?utf-8?B?SUdKRGJJZVZjdGRsTTNWVjRYNU8zSkFqRUYxZWhZbEZoSm9DQlQwaXBTRTRF?=
 =?utf-8?B?UHpiaTdTKzNpVU5EdTh1eU5ZTVBBUjQ5VlM1RG1zM1NSV3ZrMmJDR1U3b3JH?=
 =?utf-8?B?TjQ0RjgzcHFxNkJiNXVVNG1VdzJHdmgvZUdSSjVySGVrMlNsbkxDdz09?=
X-Exchange-RoutingPolicyChecked: RlTzcWaKX1JoQqgYskV4wYTpyzyEmK+RQwgExGbvH4oSW/y4KwvEeAsDF2102HhbGVDzuTV6cAgfHWcqTQEANGRdc535ZbLDoAYO7P3kWsyZrdxva/A/ftkNFf9/FcDns0LV/r7PwC71USsq4T9f4tGYn2864L61twUUB9iWC+1lbDBLQebQJy5xHbjxNdiR4Ixu5AFYBauvm6aLbxpxok5LCxYq+2IjJ87T1G5VaYbWfXPwrWYq/0nvhgNZXxWcl0eztsmDtCkFQ8pS1UzwCYI8cogwAGiqP5NLrjt/WKT22hJkSI1YPJ4lgN7eKJ1yDTmlJyiv6btMbrpL88WJOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8257d162-688a-41a9-70f6-08de7d772e71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 00:59:56.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE0LjZJLN/hefDt3luvRca95bFMSRw6/vQgIVWxCggGBCJQtAgLd36Kuwp5f1SeGrMzP+884u4OhiNlrdUpWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D20C7232F8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223470-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/5/2026 9:46 PM, Shashank Balaji wrote:

> So at least as per the spec, re-enablement of x2apic by the firmware is allowed
> if "x2apic on" is a part of the initial boot configuration.
> 

The code changes look fine to me. I am still a bit uncertain about the
"x2apic on" BIOS option. I hope the firmware provides more description
to the user about what it does.

Anyway,

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


> @@ -2456,6 +2457,15 @@ static void lapic_resume(void *data)
>  	if (x2apic_mode) {
>  		__x2apic_enable();
>  	} else {
> +		/*
> +		 * x2apic may have been re-enabled by the firmware on resuming
> +		 * from s2ram
> +		 */

This comment is mostly unnecessary because the pr_warn conveys the same
message.

> +		if (x2apic_enabled()) {
> +			pr_warn_once("x2apic: re-enabled by firmware during resume. Disabling\n");
> +			__x2apic_disable();
> +		}
> +

