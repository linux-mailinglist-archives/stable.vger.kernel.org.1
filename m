Return-Path: <stable+bounces-110336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12062A1ABC3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 22:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39923A8DA7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA35198E9B;
	Thu, 23 Jan 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMrcoI+B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEE3DBB6
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667020; cv=fail; b=ckwuFOT1Z+BvfnzRgjccaWcBGwPaVGVbgBeRrJ9x1Ll9BceoeuzjeqT18xAEAVYDkz/xXU4+RN++vqBT+D4JMAO30/JwT8Y+/QwAwTMtNYDO82BB+YsO3arqFj/z//a8SCVcCbmGsrxedvhXaKDviYHkkRh2jo/bNGeSMvFIF9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667020; c=relaxed/simple;
	bh=aa4jW4HwDtw4iwEKRmT6T+j5wyWms4/khxXNWEGMM8c=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZD5CyZAIy2Y+OIr5R14ZoJnX7LxwR7J1OH6MI75ed4n1CKlBRnOD03DfHE+3LhqA1DhFcl985XZNWlgcZXihlLGBVyJ7jLLhgSt/D3hgiHRzD6n8u/o6JcxQo3nw/2SqXZK5/Qze06CtiErI+vVNtxTC0gULVSS9ZflamnY/us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMrcoI+B; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737667018; x=1769203018;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aa4jW4HwDtw4iwEKRmT6T+j5wyWms4/khxXNWEGMM8c=;
  b=MMrcoI+BBR9TDpDNT6OMBNFksghNuQibgUDmZFDoLBKotkjnkXjBDhWs
   eN0sXXV/p0V/m7eg+iIE/O9OWACqjU0J/lin2QYxX2guJH7hZyHXKszvk
   df34YNGjmNnUgcrSjdH8IMEc1EffndKlFCiX2zVrDeSn2K6mN4eXDwK9I
   aX5PP4tgLtAvuEGhQeTuP/LAEWpPK9ResjvTlBT7lg/aK1I8qGLw1sFEi
   IeZzranR9i0LGaWFnxDTT9tIwyzWefdcknEUJ0WciYrbHOxw+EhXdUmh4
   FeR5JZv9n85EEdFig+psxGyuH3JyG69XGnO0Sq6rGTHj8mOLqvvJO17yA
   Q==;
X-CSE-ConnectionGUID: Lq2CpTWkRc6Xi0KFBDUOpQ==
X-CSE-MsgGUID: ZLSaTqeaQSqwIy7RqHinfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48856563"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="48856563"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:16:56 -0800
X-CSE-ConnectionGUID: i6eriy98RWa+PMgwxr0xsQ==
X-CSE-MsgGUID: 62lj+AJJQfOroMYJe1VTKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="108123417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 13:16:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 13:16:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 13:16:56 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 13:16:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqrNqRVktAsfIZs6byRl0i7fyEJ2nmwpkPBtWIe1ji4eOaMWFGfQ4S0nXizKo/Rw3znFvYk2yuhytgejq1x37V550ps3hcem/QNVXOvrKal4dKRtSJ6M7q299oMjUJGDSHjBg7Mdmplco1KvCTYqogvHtZkSGJQsFMzfJX47ftTf87eEyeqJK1xQRfaRENUBBjc/NwlpjDuljRauIat4rbt64+BFR7uy0FbYx9nG62FICoO87qOLDaLV6WY0ggW4s5NaTEmIPI9rt8InVoR7PJjaWLJvlvjOEQwagXl97XflLiTJIirZtIHJs077fOfJG7nGJ6cPugnTkJnVo2xN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbpI4kcvGNOdLzByE6f9juDhpK1UpU32QtFkcpKhJM4=;
 b=HeEO9n1zztb0Vx8kEEKV45mcahILjZNSODrX6Tlgm5O7pJkkv42pa9CLnnk99SjrtI3r5ZhfF16RjoZqpvx16Uv19ZZENjm3izUYLfDDcDY/KBOoD5DB1ptgj37NeGLi60Xmsmc8jOclrZMdb6TevDgM4IvZrNKCi9WLsEf7VPvjVKelU5FXifZHTY9LM2Mes1J6E6biKHXic2lk2bdrlePaSA8aY/145KIdT1uhMRLdKoYwR/81BZxaJq3E5QXInU9oq3E3mDYszKG+d2BTvlnq7gHhR7wvcf4KNSLikgTp8bqGCK9ZPn4W6DoFsyQ0zjCdVomn+Wro9zHinOoAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 21:16:53 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:16:53 +0000
Message-ID: <5c2a2ad5-fa34-40cb-a81f-891405c3a79d@intel.com>
Date: Thu, 23 Jan 2025 13:16:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
From: John Harrison <john.c.harrison@intel.com>
To: =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Julia Filipchuk <julia.filipchuk@intel.com>, <stable@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250123202307.95103-1-jose.souza@intel.com>
 <20250123202307.95103-2-jose.souza@intel.com>
 <eaba2ac8-2396-4779-9147-7066995899b7@intel.com>
Content-Language: en-GB
In-Reply-To: <eaba2ac8-2396-4779-9147-7066995899b7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 208750af-34b2-4865-e86c-08dd3bf3424d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akQ3ejA1RzNncUpUbXRObTNUR040VkRSN3dnNWVBUlRrR0Z4TDlMNktIWWps?=
 =?utf-8?B?Z2lIVjg2Q09zN3Yyb05WQTBFRGorK0VNdTQ2YUY4NWd3WUxpbmd1ai9pQWNp?=
 =?utf-8?B?cVVYSWZlcHk1aWtKTWxCNWgrejRlSm45YTRIcGMzVkozY3Z1Q014bmhUaXRr?=
 =?utf-8?B?bjRZZUo4VUhBY1dBTS9aeGVMVlVtQTdSWWZtQnlrTnJic3AvVEk2UTEvY3cz?=
 =?utf-8?B?bmI2L2xrVkZtL0FQR1RnZGhjS0pPSzBwa0lhV2JoWlVFMEkwQWNVbXo0dVZQ?=
 =?utf-8?B?TFZzOVZpb2JHYnRzbGdkQjJKdXJ5SzR4S1ZiQ2x5dmtCeW1OdVNoc0NxQ00r?=
 =?utf-8?B?MEREYkxGbzFhcGFLVVVjdWJPc1hkeDgwazczdUpTK0JQZ3FwWVVsRWJvWGNj?=
 =?utf-8?B?MWNpblRWWlZWZUFJcVY0Ry9OOHNpSXFUdFZDYWU0bnVrVTNmZDgrdm8rRnhW?=
 =?utf-8?B?Y2YxNGFha09IaVpHb2hlcVdNWGRkNUcrYkh1Umd0U2tLZ2p6VkZrRjZHQTZ6?=
 =?utf-8?B?enVIOW4wQlh6R0NvVkl5bzhRU2ZQTTQ3aDVnTHdnbG9zbzFkcHNYS2t2aTVV?=
 =?utf-8?B?ekxjeXJLRlZuM2lQa0lRU3Y2UlZsRjRvTGRaV0hJWE9NYkp6UVloTEwxelZz?=
 =?utf-8?B?T3JtNlNSOWM1S0x5TFpzL2cwY01wRGtYbERFV2l4eUhLYk94eTRLYk5jdHFa?=
 =?utf-8?B?UWFBQUx2TkpOb0NVSm9PNTN5Ujg2aUVNQzZYMUZYQXZjalBobHJ1NXMxQU9L?=
 =?utf-8?B?ek1IQThwcU8wZ1YxYk80N1FzeVo3SzltVE1YSXk3bFNKZ1l5MW8xK28ydlJX?=
 =?utf-8?B?SFhUY2dwSVIzaFI2NW1lS1BHK0kvQjdLNGlUdW5WcTl2WjFxd1JPdFBQZytK?=
 =?utf-8?B?ZlBXcVNBWXd3SVR1NDdiaDRVMTRCVlZEWU9jMS9sK1A2bE9MZlRla3lzK1Ra?=
 =?utf-8?B?S0gyYUdZcXMwdlhUdG5zck81cDZOUk5uZUNybE1ad3JqemhhUXREZDY5OVR0?=
 =?utf-8?B?dUVwUFRjeEZIS0dtWDVnaExZN2pMWjVMRnZyZStRaklPZ1hQbnZsR3VFMitG?=
 =?utf-8?B?SC84czZqYWJ3ZWNvbFdSK3diaUk2MDZWMjZ3ZzNLNExVdVJzb00wNUt4aHRG?=
 =?utf-8?B?dXhLV2JjQ1FFMDJlb211UmJYaDNMUEtzWDhIZlVjM1Z1dWNJUDIzaUdGbGY3?=
 =?utf-8?B?ZFV6ckg4VzFIR3dpMUkweGpVS3hreXYxMmNqYmE2SysySXB2VWFZSVBuZWJi?=
 =?utf-8?B?NDBFNis1MDBuaHd1TEVvN3Z4Sk5ja2t2elUvZEV0Mk1zVmxSNEdVWmI2OFo3?=
 =?utf-8?B?QitocTNidXpOZndlVEF5cE52NlVTTGVYa0k1WGNkYU1LbUxpSHZkR09SRm4w?=
 =?utf-8?B?RVJsYURDdjdvVmZoZFQ2RitHRmVRZ0hRY3Z5SnFRNGsxL3duTjlJOGxsVGxj?=
 =?utf-8?B?RFFKRUVVS0F4QlorUWNhc3c5V1RmQmUwazRpMURCTXNQWmt3RjlMOW5vNGFD?=
 =?utf-8?B?V1hIai9vRmJSaE1SMWtFRVRVWUtFa1gyS09DbmtKQnVKNTRvQStPYlJ2TGlZ?=
 =?utf-8?B?MWcxeHhDVEpWdEkxaE0wbFIwaDkvL09nZU5LVmdIclRsWmhoRVY3ZFQ5Z1hL?=
 =?utf-8?B?K3RnY3huZE0zMnJjVkZJSzN2Z0RtRUlMTzBVTjYyYWhJVG1qeXplT1VFVGhw?=
 =?utf-8?B?WlVUajRJanNMUGg1Q2VjUDN3VDFjRURSSzBtNjZZVTg1Qkl1OUxjMVN6OHUz?=
 =?utf-8?B?dUFPdWNEd2JZT1M1TzV1eE1iRXlrazA1LytSdGJ4K1R6WEhkOGNUMXFMNFRo?=
 =?utf-8?B?SGU3aHVZWm1RTFdpRGJXRUpOWGg0UE5QeHhQd1FoUitIREdTN3lTZ2pDSUVD?=
 =?utf-8?Q?VprIr9MwhMkos?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdvSHU2QkMvaU5lU2o2TmlGWmpLU0lTSzlEOG8xOGJoREF6UENNZTlnTitv?=
 =?utf-8?B?STJIM0xEY3pVRjhMVWIvazJwWjl3aGlvWDZ2Y3VzbDlZSVdQcUJZZkw1WkR6?=
 =?utf-8?B?ZjZyc20ycUFaK3h5SThUZnI1N1JEamljS0RwZEhFQThnTUxqV25KQ2cxc1lF?=
 =?utf-8?B?dmN1L0lVRDlkRWxPT3ZqY2VYM2Y4dWJmWmpSK0Nad3NQNkdHUENBeVZLMTVn?=
 =?utf-8?B?YlJkckNmY3FqUlZ1SWd0Nzd6NnlqVGRORTNGeG9kOUp1dk5yNFAvRWt5OGZq?=
 =?utf-8?B?TnRwMnBHdWt5bmFqOStScExoUmNaSjJLbjlWVXowQmt2SUFSTUhZcDlsNWly?=
 =?utf-8?B?bDZtTzlVMld0MTdTdHlGSGJNTmdHcVZYcTN4SDdnMjdzMkx0NUI4SlM3ZnF5?=
 =?utf-8?B?bTgremt2V29KdEhlMXAzZ2Ywbmw0Wk9WcUhKalhodldTTXA4WFlXVDZydDFk?=
 =?utf-8?B?VjJ0Q0hSZk5uaU50S1RHNmRWbUx3RGQyTXJxWmFyR0FVdm5rN0FyVnl3Q2xo?=
 =?utf-8?B?amRsYWlkc2RBLzZTK0tCZnNNR2FEeFh3dVlIOFdWNGZwMFJnSjFYcGxxdlNh?=
 =?utf-8?B?SWxCd1c1Y2wzdHVRNXVFY1lkekx4Nk52Wk40ZHdTOUtBNmdCc21zMWR2UkJF?=
 =?utf-8?B?QTdjWEZ3MDBzSUNrM2pYS2l2VVMzWnFIVm5IbklXakNFVjJ1UXBWU0d2U1hu?=
 =?utf-8?B?SVFxOXFxSlhpMlowL0ZDa29Qd1A0S2xLaWhqOWlLM05kOHh6aHdzTUVJRnFN?=
 =?utf-8?B?NHZiUS90enM2NTBOUWE2YXNWby9lL3ZaTUkzaHpwS3ZnbmdZOXg3c3dldTNN?=
 =?utf-8?B?aDdINUk1aFJObjZCZ2JJWmVtRXMydk1PY0dhN1YrL2JkTjAycTducGo3NzRq?=
 =?utf-8?B?TXVMQXc2cHh6MlFBaFhEZmY2aWNVQ0paZUlKZTlvdVNWOWtMRG9jRldkblBN?=
 =?utf-8?B?OFN0Q3VDcjJjRnhUc09ZdnVsTitaTTRJYzFpbHZ4MCtRa1JXTG05cGxQQnFM?=
 =?utf-8?B?TkhCTER0SHZ5aDJ1bEx2bkFLRjdQenQ4Rlk2eGhGcXdZS09jK1g4ZTF0T0Y2?=
 =?utf-8?B?Uk5TbkI4VlZsT1EzZ2VxUVA5a2VuanNVUHRwaFJCdTAvOGw0SGZQelkycXRx?=
 =?utf-8?B?QXFKWjhYMWV4cXJaSTZybmhES0d6Vmt5T1A5VlhpSSs0SE1YOUw4UWhTSlkz?=
 =?utf-8?B?bDBhVkFadmgwY1ZMa2dRR0RrVEFFVm85c0pSSUVrUlY1eFZxQzBsQ3E5ODZB?=
 =?utf-8?B?UUJ1cXY4Q1RRUTlVS09uZ2NWRlM3bWZHcnFQVUtMVUdsaGpKK1p3bkZRSmpB?=
 =?utf-8?B?eWxMaUMrSXB5U055UHpWd2FkSkduTnFKdmlNQm5zbUhiTmZERUIvOWd0Mk03?=
 =?utf-8?B?TG8wbElLYTBzcXJmb2Q3bkVJNm1DelJpMFYwMG1ISkw1WkFWYlRLUXRHQTJI?=
 =?utf-8?B?TFZYRlUvOVVSdzZSQW1WOFU3em9uNkE3elkzNnp2dk5WY3RkQkdiTE1Ga1h2?=
 =?utf-8?B?ZFF5aVMxaUZDWWJwbTh1L3MxZkZOcG1iZW9QT2JjMHVzcVF6UXFESjJBbzRJ?=
 =?utf-8?B?ek83aUwyc3dhSTdpZndMWnJ1Q1RJQ2NLYkFUSjFpSE5melQ4WmI1cXZGSU9k?=
 =?utf-8?B?VGhTN2VnN29JVjJIeG9rRU92SmV6Mk1JV3lrSUhvczlmTjlkMWRJaWtXbXpL?=
 =?utf-8?B?SE9KS0JFaXowYWVFZE1tZVNwc2loL1BwcnZCdGtVaGFkQ2dlSytEQ1RubjVB?=
 =?utf-8?B?ZTByYlFwakdacFRRazMrbEIvOVd3M1F0VUR5OFJ1WVJ5TXpBbjhudVJGWFBx?=
 =?utf-8?B?b3FGdHhpNDBRaHp2b0pEdW0xMi9XTFFUWWhFTkduQXkzZzd0UnJIMmxzUFEw?=
 =?utf-8?B?L2Y3YUMrMlA0aHI3U2ZEUTQwVGZGOVdJS0trWlFnUE43NW9aY0xwTWlPM1A1?=
 =?utf-8?B?NWF6d1ZYSmdHbEFQbnhnTVBuUlFNc0tpZGxDUkwzcnhzcXVTRVRHNGJhdnE3?=
 =?utf-8?B?NHBOa0JGK1crVkVFOS9ES0tmbVFIdWZwZmVVM0gyTnI2eFdQeXUrQ0tmZkQ2?=
 =?utf-8?B?aU0zY1RZbmorNHBoK3IrNjRqcjhhSE1kcVZqU2ppaHpVdXBqNFMxZnlpa2g0?=
 =?utf-8?B?Rlh1YWZvUUtXQWtBNzN2QTJGaGxPNHBHRnJmQklCWkhsUkdkNXRMTkV1WElq?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 208750af-34b2-4865-e86c-08dd3bf3424d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:16:53.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlM4eLKqRnkZnw3EliDvgbZ32+dEBeShS9zIGzjPH1tbxOzA7eMtxm6KE1oYFFTqsaTp3WCSSm3jtOsU/8Z4qEIcOYgrvKaWosXSgp/SeFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com

On 1/23/2025 13:14, John Harrison wrote:
> On 1/23/2025 12:22, José Roberto de Souza wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
>> debug tool") partially reverted some changes to workaround breakage
>> caused to mesa tools. However, in doing so it also broke fetching the
>> GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>>
>> The fix is to avoid the extra newlines: the devcoredump interface is
>> line-oriented and adding random newlines in the middle breaks it. If a
>> tool is able to parse it by looking at the data and checking for chars
>> that are out of the ascii85 space, it can still do so. A format change
>> that breaks the line-oriented output on devcoredump however needs better
>> coordination with existing tools.
>>
>> v2:
>> - added suffix description comment
>>
>> Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
>> Cc: José Roberto de Souza <jose.souza@intel.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa 
>> debug tool")
>> Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper 
>> function")
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_devcoredump.c | 33 +++++++++++------------------
>>   drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>>   drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>>   drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>>   4 files changed, 18 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c 
>> b/drivers/gpu/drm/xe/xe_devcoredump.c
>> index 81dc7795c0651..6f73b1ba0f2aa 100644
>> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>> @@ -395,42 +395,33 @@ int xe_devcoredump_init(struct xe_device *xe)
>>   /**
>>    * xe_print_blob_ascii85 - print a BLOB to some useful location in 
>> ASCII85
>>    *
>> - * The output is split to multiple lines because some print targets, 
>> e.g. dmesg
>> - * cannot handle arbitrarily long lines. Note also that printing to 
>> dmesg in
>> - * piece-meal fashion is not possible, each separate call to 
>> drm_puts() has a
>> - * line-feed automatically added! Therefore, the entire output line 
>> must be
>> - * constructed in a local buffer first, then printed in one atomic 
>> output call.
>> + * The output is split to multiple print calls because some print 
>> targets, e.g.
>> + * dmesg cannot handle arbitrarily long lines. These targets may add 
>> newline
>> + * between calls.
> As per earlier comments, this change implies that dmesg output is now 
> supported as long as a newline is added between calls. That is very 
> definitely not the case.
>
>>    *
>>    * There is also a scheduler yield call to prevent the 'task has 
>> been stuck for
>>    * 120s' kernel hang check feature from firing when printing to a 
>> slow target
>>    * such as dmesg over a serial port.
>>    *
>> - * TODO: Add compression prior to the ASCII85 encoding to shrink 
>> huge buffers down.
>> - *
>>    * @p: the printer object to output to
>>    * @prefix: optional prefix to add to output string
>> + * @suffix: optional suffix to add at the end. 0 disables it and is
>> + *          not added to the output, which is useful when using 
>> multiple calls
>> + *          to dump data to @p
>>    * @blob: the Binary Large OBject to dump out
>>    * @offset: offset in bytes to skip from the front of the BLOB, 
>> must be a multiple of sizeof(u32)
>>    * @size: the size in bytes of the BLOB, must be a multiple of 
>> sizeof(u32)
>>    */
>> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>> +void xe_print_blob_ascii85(struct drm_printer *p, const char 
>> *prefix, char suffix,
>>                  const void *blob, size_t offset, size_t size)
>>   {
>>       const u32 *blob32 = (const u32 *)blob;
>>       char buff[ASCII85_BUFSZ], *line_buff;
>>       size_t line_pos = 0;
>>   -    /*
>> -     * Splitting blobs across multiple lines is not compatible with 
>> the mesa
>> -     * debug decoder tool. Note that even dropping the explicit '\n' 
>> below
>> -     * doesn't help because the GuC log is so big some underlying 
>> implementation
>> -     * still splits the lines at 512K characters. So just bail 
>> completely for
>> -     * the moment.
>> -     */
>> -    return;
>> -
>>   #define DMESG_MAX_LINE_LEN    800
>> -#define MIN_SPACE        (ASCII85_BUFSZ + 2)        /* 85 + "\n\0" */
>> +    /* Always leave space for the suffix char and the \0 */
>> +#define MIN_SPACE        (ASCII85_BUFSZ + 2)    /* 85 + "<suffix>\0" */
>>         if (size & 3)
>>           drm_printf(p, "Size not word aligned: %zu", size);
>> @@ -462,7 +453,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, 
>> const char *prefix,
>>           line_pos += strlen(line_buff + line_pos);
>>             if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
>> -            line_buff[line_pos++] = '\n';
> Again, as already commented, do not completely remove this line. It is 
> an absolute requirement for dmesg output. And dmesg output is an 
> important debug facility.
>
> It should be temporarily commented out with a comment saying "this is 
> required for dumping to dmesg but currently breaks a mesa debug tool 
> so is disabled by default". That way it is clear what a developer 
> needs to do to re-enable dmesg output locally.
>
>>               line_buff[line_pos++] = 0;
>>                 drm_puts(p, line_buff);
>> @@ -474,10 +464,11 @@ void xe_print_blob_ascii85(struct drm_printer 
>> *p, const char *prefix,
>>           }
>>       }
>>   +    if (suffix)
>> +        line_buff[line_pos++] = suffix;
>> +
>>       if (line_pos) {
>> -        line_buff[line_pos++] = '\n';
>>           line_buff[line_pos++] = 0;
>> -
>>           drm_puts(p, line_buff);
>>       }
>>   diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h 
>> b/drivers/gpu/drm/xe/xe_devcoredump.h
>> index 6a17e6d601022..5391a80a4d1ba 100644
>> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
>> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
>> @@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct 
>> xe_device *xe)
>>   }
>>   #endif
>>   -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>> +void xe_print_blob_ascii85(struct drm_printer *p, const char 
>> *prefix, char suffix,
>>                  const void *blob, size_t offset, size_t size);
>>     #endif
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c 
>> b/drivers/gpu/drm/xe/xe_guc_ct.c
>> index 8b65c5e959cc2..50c8076b51585 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>> @@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct 
>> xe_guc_ct_snapshot *snapshot,
>>                  snapshot->g2h_outstanding);
>>             if (snapshot->ctb)
>> -            xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, 
>> snapshot->ctb_size);
>> +            xe_print_blob_ascii85(p, "CTB data", '\n',
>> +                          snapshot->ctb, 0, snapshot->ctb_size);
>>       } else {
>>           drm_puts(p, "CT disabled\n");
>>       }
>> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c 
>> b/drivers/gpu/drm/xe/xe_guc_log.c
>> index 80151ff6a71f8..44482ea919924 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_log.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
>> @@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct 
>> xe_guc_log_snapshot *snapshot, struct drm_
>>       remain = snapshot->size;
>>       for (i = 0; i < snapshot->num_chunks; i++) {
>>           size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
>> +        const char *prefix = i ? NULL : "Log data";
>> +        char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>>   -        xe_print_blob_ascii85(p, i ? NULL : "Log data", 
>> snapshot->copy[i], 0, size);
>> +        xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 
>> 0, size);
> I thought you were saying that these need to follow the mesa 
> requirement of "[name].length" + "[name].data"?
>
> John.
Sorry, patch 2 wasn't showing up at first. Just saw it now!

John.

>
>
>>           remain -= size;
>>       }
>>   }
>


