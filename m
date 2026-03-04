Return-Path: <stable+bounces-223026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAXaLYIJqGkEngAAu9opvQ
	(envelope-from <stable+bounces-223026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 11:29:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 248141FE592
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4AD6302F7D1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A91382F16;
	Wed,  4 Mar 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izCLjQsh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50D364058
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620113; cv=fail; b=JtFVdTXng3Eqejlab49EaNH3HpiWUtdRKZsnPzjdEV0VmcQBarYm4D1mzaxWHDCy5/4LZaTPNcq8b3j+509PU/tTTj6r7wKLut9zlXTzVkubbzxfMgk+Ly+ULJozNRgOBaNsyDKEVfAvreXeG39Yf8ySdc61CZmMyDY6oNuaLeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620113; c=relaxed/simple;
	bh=FZbDaVM6nUBCBHvA4Ln/tG+GfLcv3EJhfo3gIMkY1+c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mj9MRyb/1FJcie3pxlhz9+eRPP7JeJiSNCcxC4SJoNZWW0bJnLWlnd3Jtz+vwW5NScLeqWVDbQFoqCn/730VDPlR6GlRM1/DroHeT2lhUId0l3gOr1pGNfJeYYgrfPI1B/VSV9UyGQ11P1TrqpxjjV1fIVJ/HVzz7tEnkIQoYHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izCLjQsh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772620113; x=1804156113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FZbDaVM6nUBCBHvA4Ln/tG+GfLcv3EJhfo3gIMkY1+c=;
  b=izCLjQshx1q0ZxirFXmLnedheigaW+Xq/u9HF8KTqBx4kYNSsIN2Efym
   OmM69Qjs1YsRrNQT58p4jfKyOyejeEaCsgCuHA6oosTpV8KU2uAV3QP9r
   iRMqbWAE12z9aXVE+Dt0i34sTXy5l7cbcdmjfTh9wsn+EIafYXRMXAbnA
   /ZZlMYPFXX7UGRgQDcRyOd2c+wSRVHfEbZMXGDZB/ab0JVCHmlzS2nSMG
   ZRFOi4X18VZaUnLqR6dW4aQYliiVgnXDCc4fSEmJpsfforsvTvH1uKjyL
   pgrFz99qP1pJmZLM4HAxIK0zlYylKiMBzBWgSbN1B0JQ1d/sHj7tAKMto
   Q==;
X-CSE-ConnectionGUID: PkwgpYW4RvO27sL03sJWHg==
X-CSE-MsgGUID: VggjRjVzRUe/ZNPSgG76uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="85144321"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="85144321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:28:32 -0800
X-CSE-ConnectionGUID: SgYCR76XRcS2rI+NZKoiPw==
X-CSE-MsgGUID: 257L6wexSAy1idM5meKEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="241313533"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:28:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:28:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 02:28:31 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:28:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyBV/4pOLN0QYs0+Am94f+d9Zpq7MzkHLw1uRvNM/goBcm15FHLiNXnGxgEDPp7fibAHhPSno/K2kQAWtVFNG79p/gFSYvh2t3dFXfYW4dM/a6E7HCYQN5611nhC4svaH2+K4A4Tj1pnyXwKErig7ZqmJ/FmTUXgW3IqF4NQOSu8mtbSTcX+JMgjDh5Ydk9Yx6BsQO2r9zK0rbyR4ezpcWLAY1N3sVTLLSB9Fc/Kf96OVG0ukXIOONx4ecx0jY/UwmwcyGPSo3gSaJqVriKC7LJ6QOVRwuYPE8Ed9k+xdBzkuorrniQzwc2pMKMoPBqlYrKIscvh86fQPT5pEJRzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hip8EeHkwGaL5QwZBEIduWb+qHo5yOBu7PN2OHdvORw=;
 b=GsnUmKtDgUmxcblr90Xn8m2o4jnSDmMy4xYHbaR6rqw3W8sq2FC/fyxLctoUYD3JqYsq/em9Lo5n3Skuqx1p3HCKW2XIUsvOx5+Q0FP2KP/DIeeQ2C/3RZRkFs/VKU2D8ACfHowaltKUKjTWXktqxPleZayWXT/iJiTT6klciP66FVfH+LgJ7y+u87gX+/CQCx/cyGz5HWwgv952t0sr1rOLfo2RpsKFqeCf3PMeknzrLzWgmTJatzGIV90h8vzsFGEwX4FckKbb/2jK19HJOtEhWhde3XABmAOErQSRFAouxpGvY7o9nDX1jMV7bwJajxt1ZMoeF9eAMH55TD+7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22)
 by SJ5PPF37792A6D2.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::820) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 10:28:23 +0000
Received: from DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::68b9:ea3c:8166:3cc4]) by DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::68b9:ea3c:8166:3cc4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 10:28:23 +0000
Message-ID: <ca3eb4b5-49e4-4392-b1ce-cb3c63d8cbba@intel.com>
Date: Wed, 4 Mar 2026 15:58:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/i915/psr: Write DSC parameters on Selective
 Update in ET mode
To: =?UTF-8?Q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260303125409.503148-1-jouni.hogander@intel.com>
 <20260303125409.503148-5-jouni.hogander@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260303125409.503148-5-jouni.hogander@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0251.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::12) To DM4PR11MB5341.namprd11.prod.outlook.com
 (2603:10b6:5:390::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5341:EE_|SJ5PPF37792A6D2:EE_
X-MS-Office365-Filtering-Correlation-Id: 47354f9d-5e10-4a17-f227-08de79d8c369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: ebB8YD9ttuO30BYx5ePzC6ebN5MI6U5Ev0PuUJ/2VK4Im0c6SMmS9DXxhZtcoStRaoaa5GM8J1MXAeS/XSKStrNysxcs8UdvExjSBbRMBaYiKtCduVNYyiz+rUWRoW12WsbiNycE0t5woFu+0MSZzXo+FueYkYnvPbA2Q+jPNLbQCdCHrasCWiMCoJKM9ZBTifQe+BAyCJgxCSOcKPOEjPpoCctGypB4Un1zWfc6ehyMIhe1U3qt7q8/yV6FDji78AOjxRJrLZlzz3SZR3XdoQCjkJ3R+Z0sJaOGmQ+Z1SgNslYCQPmy3ddbazzXGb9t44IQtiODbFZ9fBose414c8+PrbOqNZg4JjPjOa2OI3kAEldxjxKzYjDM3vV9jThPL0Ofx8LWAdP5cO0pd7WmMnj0fX/FL65EzwuVM6G7rG62R+p5nWG3AHYWMcMdD3Ve8y5CXkpymx4DdzcWSl91t7oZ9cNR5mSvbgfU1OGmytLoqLTBaCHoLccS7DZSltbBgqAEc29IQotxh/uU0jZJdIIVYJoWM/6DNfRs0He34lor44qG+TA9IW50mgICyGEX9zom4FgG7CDV58C65FDeme+X/+STQKds2c8cLcYw1V4qaVCS3H2PbIvEydm+9k6R1fpm3RzmuBy77Yce5clt334njlGv/1KB7EZ9EwuuVDKC2eySWh2zAE929lltjaD5PjXJo0WSePPaT0iMHk+ZjIsYBpsdftr50fkz/j6w+E8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVwNDVyUms0bllSbFQyTzNadkZmaFdYNUlnMWFNdHAxUXIwTEhEL1RMR3c0?=
 =?utf-8?B?dmllcVZKb3R4NDFWd3NTTFNnNC83Uk9ZNW9qT21leS91SzNEdXRTaGFsMHIz?=
 =?utf-8?B?UTVuQTJ2d0lqNkNFNTBMWXdYYVo0UUUyQlhUSUkwWWM0WTFyNmU3SmZDRngx?=
 =?utf-8?B?dW9UT2gwcnRxeC9qK05TVFVHMTZCeHNTaU83UnRHdm9qTHFQRTF1NXBTenpY?=
 =?utf-8?B?eDNCR0JFaTdKT0tORzRSZXFVM0czVW5zT1lwcHpxdlIwd2NxQUkrSVB5WkRT?=
 =?utf-8?B?SVJmTEVqdjlIaThDaENjazBZbzg3bEFCcEdWWW96Ryt1UURvQjJVQldmWkR4?=
 =?utf-8?B?U3JKZzk1U2MzVW9LZUx1SHlxZGNWUHJtd3hHQkJXOHVuZGdhczVMT0xnVTZW?=
 =?utf-8?B?QlBTblQxeGFPQitaV3RjNXFoZVVOZVQrOTZuQWVvcFVLZWFtQUFtcStFWkZa?=
 =?utf-8?B?cU1TcW1nSk1TRE1lcG14VUFpTkMvYzRmR0hBZ0cxcUpiQngveE51R25XWkU0?=
 =?utf-8?B?blBqMkxyWHZJcmU0ek83VTI4S1lhQUpyZ2tHY2lUVGlQS0tsa3dESFFlZW5v?=
 =?utf-8?B?SFFHdHFWQ2RNVUVlaDBHUVdqMjYxK2pXNDY1TW5aUFk1cXRSVWsrS0tMOUF1?=
 =?utf-8?B?Y1lYd0RSdy9RMWl1RXFndEtTSElUZGRQckp3ZnBWQldDMDBkM1FLSThGTnpW?=
 =?utf-8?B?NHRJeHlobXRVcWVhZFhyR3BGZUtpSExQcnV3L29PaGtVNFJmdzMxQURsem9N?=
 =?utf-8?B?bmllRUtCeThwUUsxVUM3NWZzNEJOSUZ3RFBHSkhGUlZSVjlPVkljTkduZkRj?=
 =?utf-8?B?MHUrTjVBUUJiaS9wcFAwSyt3Y3lGaUlSRkd1Skc5OXhlMm8rVTYxbnRDcjY0?=
 =?utf-8?B?bXRqMGRzNm5pUE5YVXRwdURiQ0tMWlhDanZXakVvWVpTTVYwMnlDWjFSN2xU?=
 =?utf-8?B?Q29sQnFxM3NXN3hsb1l3ZytZNFR4dWU3VUVnRUZLamVLUUJBNVF2VHZ2V21X?=
 =?utf-8?B?aGJXMzdPZWJ6aTJjSFM1NmhrOUV3WFBlOU4reWNaRFVHV2E4YmpZTEV0WTls?=
 =?utf-8?B?NTJ4cFREU2ZHaTVKNlJoNCtDTUVlcFNiUEJ0VThVNUtXVlE5WjMxcysvcllE?=
 =?utf-8?B?Z0NxUTFpeVlPMkRRRU1aUzRaK21URVl1a01lNUJ0RXRFTFR2Vk9kVXJTVlUz?=
 =?utf-8?B?MmRZWmp0MFZmVmVhVUxPYVZhaWs1d2h4c2Z6azFPT3NiOTlZN0xrNnZDUW9V?=
 =?utf-8?B?eFg0blM3NEloNUpwcHVJNmxFSC9Zb1ZDbmlUcXcxVmtFSWVyc3ZHdVltMHpC?=
 =?utf-8?B?ZXdHQ0Vzbm1WWFlDNTNQdlpIWWkxUEVJRCtjbnF4blJhSlpINko1VkY0OFEv?=
 =?utf-8?B?NnpwWW9hT24yKytWSmVSb0ZNeUdONUtzQk5LU1pOZTVzWWh0TjBlTUhDcys0?=
 =?utf-8?B?ZGpTVkticE9XL2UvMjFsdk9ENG80QXhwV1M0S2c0SVZrdmpVYm1vNWxna1Ft?=
 =?utf-8?B?dndEOHJIcTFaZTM2WWVyaXVSdUFIKzhlMkorc1h4ZzZaR3E4VVpZenZ0VTdm?=
 =?utf-8?B?TlZhMUV1b1ZWUkRQcFRaMWVhYlJKL0JvQkU3dElnYnZQWEk1ZzRmZUFQR2Vo?=
 =?utf-8?B?SUI0V25EUy9IOCtIR3dFREQwRnNIdkRKSUVmcDFzRCtqM2Z5Ui82eklGMStJ?=
 =?utf-8?B?bDlEWVNSWkpmWmM0bnVoaUZWQzNjSDhLbkt1SjdvNnpBYkxMS2QxZXVEYlFP?=
 =?utf-8?B?bVVlakVWaGVzcVk1NHRwdG45VTFJQWFKZ245aElrd0ZwYmNlQlpvckdibTEx?=
 =?utf-8?B?cFlydnA4enhTTHNQcVAySGx3NDhYTnA2RldXNjBkR3R1NGswOXRqRXRaaHdv?=
 =?utf-8?B?Yll2dDY2djlCZ1A5S2NhNVJQVzFBYml6a2c2T1NCOHVFNERFY05DRWZYeHJZ?=
 =?utf-8?B?Q1cxSmlPbnFiR1RLTzluOGtQbVhiZXI0d1hDTnFVVDd3ME80dk1kZ01rRkpw?=
 =?utf-8?B?YWM1RStMeVRWeXNvcXBVYmlpVFpJYm9ocWllRUFweHdFUzZaV0xCNCtoZkVS?=
 =?utf-8?B?WlhTaXV3QXBhMmt1MHQ1Wjd6Y2FyZElKejNKWi9XcW9RYWpqdTBvbWNxM1Yv?=
 =?utf-8?B?WjhwTm4vOEJmUjBXL0FsY0w5TncxbVR3NWV0QmQxQ3liOER3aHZCaVlNRUF1?=
 =?utf-8?B?bHpTY016ZDZYTjh2SDVnVEVvemYrMHZCQVY1aTkwc0NMYmtweFZsbkRadGhM?=
 =?utf-8?B?SUs3ZW9mbzBMU3JBRzN2RWpWM2hWVmUzNVp1V2lITzh4YnNSanExaldvNkFK?=
 =?utf-8?B?NUVzc3MyUmVBS3QwdWxCa0VVUW0vaTc0L2IxaHBiVERTeTcrR1hPcnpZcjk2?=
 =?utf-8?Q?tK6lrORmKhVSW4tc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47354f9d-5e10-4a17-f227-08de79d8c369
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:28:23.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYvk0vU6hUYYFQ6ro4VPTiiIZhVvjHIl261b5maT4tW5CJnEEF+xkLBakE9fydWdBs+0W3ZOlYjvxrv8ZQgtDWPH22SLDG/HBj9YyE101pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF37792A6D2
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 248141FE592
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223026-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit.k.nautiyal@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 3/3/2026 6:24 PM, Jouni Högander wrote:
> There are slice row per frame and pic height parameters in DSC that needs
> to be configured on every Selective Update in Early Transport mode. Use
> helper provided by DSC code to configure these on Selective Update when in
> Early Transport mode. Also fill crtc_state->psr2_su_area with full frame
> area on full frame update for DSC calculation.
>
> Bspec: 68927, 71709
> Fixes: 467e4e061c44 ("drm/i915/psr: Enable psr2 early transport as possible")
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>

LGTM.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

> ---
>   drivers/gpu/drm/i915/display/intel_psr.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 7b197e84e77d..adcfd3dd8f20 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -2618,6 +2618,12 @@ void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
>   
>   	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
>   			   crtc_state->pipe_srcsz_early_tpt);
> +
> +	if (!crtc_state->dsc.compression_enable)
> +		return;
> +
> +	intel_dsc_su_et_parameters_configure(dsb, encoder, crtc_state,
> +					     drm_rect_height(&crtc_state->psr2_su_area));
>   }
>   
>   static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
> @@ -2945,8 +2951,11 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
>   		full_update = true;
>   	}
>   
> -	if (full_update)
> +	if (full_update) {
> +		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
> +				 &crtc_state->pipe_src);
>   		goto skip_sel_fetch_set_loop;
> +	}
>   
>   	intel_psr_apply_su_area_workarounds(crtc_state);
>   

