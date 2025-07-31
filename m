Return-Path: <stable+bounces-165688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8107B1764C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 20:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1647AE9CA
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6EE2550D0;
	Thu, 31 Jul 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAf+ojzw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8B20CCE3;
	Thu, 31 Jul 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988187; cv=fail; b=uAkjAag6Jri5ILZIvHm8omBSsbPbI8kEDuvTdHD+yd+3/J++XHMjIopocz/q6hisO4rwklVnDa2/AtHAxDpPAWEfwFDTyZuEh6FX3T6p1/V8pYk+T8nHUemvGaOSBSPPp3dcYeMYWss5Ym05Jk3NilOBseghqf/2+kKUwA98lno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988187; c=relaxed/simple;
	bh=5tax0iMtv0H41T6t8UCm1Fq6gR8WPSie//DWpQ78z0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rC0JBZMJqMRe1j4DqxdyQklSw7QN2/eYk43T4eCfx6v9sroXUuBfyr4t4q9h7czsuaRiXrSUb/MVzwa851sToFDv0SiT3IpG+mT0cTwRWCM8CNWZ30HFZcotVN0eY989esumcZwQilMw+hvFXa4vf5YIQ55oszzzXM/vc2jsiJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAf+ojzw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753988186; x=1785524186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5tax0iMtv0H41T6t8UCm1Fq6gR8WPSie//DWpQ78z0w=;
  b=WAf+ojzwZ4yhXuMxovp4aJuhL3qKRAOB3ZQu8laBnwAlFVL7LzhuxeKY
   CxPFHtlMVwVXNC48kmX/1/Hl2GbFu6OI9EQ1ciIViKCsDcwE33x6zwUrB
   L3kzIgTX0Heu+YMuwRRylnaohIHihmpqBpQb6YjnUP+0ebOgw0/siqSW/
   e5wvzJqki1RBppUY6u74AvV3LUmHKmHg4iWT7/aMvzzOCvc7gSMThc3RP
   CfRp9oKXUk/1UkYodsmjOxab/x65Jp6fVGx086r9Xkg47h2G5eY6p0Rbt
   4GFO96x0xkJTubu48X5+R5x2qAIczpx5coBvzAHdwj2Xb76icv9CGGe7T
   g==;
X-CSE-ConnectionGUID: z8Hyel0gTqegSdTLeErU0A==
X-CSE-MsgGUID: H3dwbk12SUeKE70SYievng==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="81776195"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="81776195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 11:56:26 -0700
X-CSE-ConnectionGUID: ZDRfW0YgTRCQn6m0RBDk+A==
X-CSE-MsgGUID: h+9HvqvBRW6WpYJUNhG5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="194325449"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 11:56:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 11:56:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 11:56:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.81)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 31 Jul 2025 11:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erfyj+e4jJREbUDPjv8cvC10ZQDoADTTGJwajeQLJFgKjCvjXBMcidp6sh73C0GLXgRapztMLogxY/jzoi4Df5zUvGr1VNeY/vEyGjqmvwJ4QSnvHuIiwrjJUHKrKj/jnSO6833YmLLO8sqd0vhFqWGWwIHj+wKE4363rKxhd5icrnnE02M0PUI3iWH4mymEqt0yLgfA4IabHB4Yv43RhuWwmXwGB01qUUJzrww0xOu0N0fr55h/XMgLaRCTz2VoYnOQEvWlGtm0T8LlFG0y211xkqa6kq6BqSeyj5MapEfLd1iCYJnbNdy+8Rtv2Utavzt2F3Ds8BcJBjkWaV/woA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bNdfYG2aEgeVIwfvuUsDQobMqnQo6vTDCv3hjMieW8=;
 b=D3gvhEaTce8dvwsXXuq9Yl0DsPKtCI9oEodTTgnLRoNwCDiNZ+TNaj8k+/Ft2ECCY9z4cT6fnT2Pt/6cA+Gxh86bD1aJYSPG+5M9CPDr+JLIiUWDc0zHCB79bXXYX679r1srQZpEpBSOPlQBCmTo8XDgH9EyvHLgrMWnI0BnMbt65mRiNIEJhiGAjEqHHfxDy20a5AoxRjJaKEekcW0rkGDPnKhXyTLXGU6bhmwB7mLn+LdH8vrb/KG+p5ZG2E4A+pjfMdEHSBHq6u5wRd2f2YJzf0bV83WUbkN+8wjD0c5aY1zNytYnpfU3ESCBRj5MByYooXRgz2MYz4DStLSQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 18:56:23 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Thu, 31 Jul 2025
 18:56:23 +0000
Message-ID: <85164f70-b61c-454e-ad43-c5e66faca601@intel.com>
Date: Thu, 31 Jul 2025 11:56:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Suchit Karunakaran
	<suchitkarunakaran@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<darwi@linutronix.de>, <peterz@infradead.org>, <ravi.bangoria@amd.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <3093fd14-d57a-4fc6-9e15-d9ce8b075b30@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <3093fd14-d57a-4fc6-9e15-d9ce8b075b30@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: c22857d1-ac0e-4400-cb6c-08ddd063f1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3hjd2NySGVOcDRnNnlUUUhzcE0wcGZaZTErdW1yVGc5eXAvU3lYNjBhMlVt?=
 =?utf-8?B?cmVyYXVrb0lra3N1YjUyZTZPdFRMenZwV200aWNQNWtqYjZBQkh1ZGtpbFF1?=
 =?utf-8?B?RUJBOVRQRW1Tc3E5M3Q3bXNybFBvWm4vQ0NFamZWYjNIb3lhcm8rZjFERXAz?=
 =?utf-8?B?VDJiL1pDVndFcDRQZUJyMXphMk1QbmFxUTZDdElFTkpwUXN0bmFiY3JjQVQr?=
 =?utf-8?B?QVk1VXN3emtRYTV6THplSmNTRG52bytlMXRKbXp0cUZha0NsZy9UUVpUSWRn?=
 =?utf-8?B?clZiSGcxZHdrNEZRcjZ5aVREbFpLblg0Y09kd20xQUh2Rk1oaXBRcUEwaThs?=
 =?utf-8?B?T3IraEdVY3ZyWGJwcUxVbEJqUjJ6WUpQTlJUa0lCNnB1VXVNdytBZ2c2VVF0?=
 =?utf-8?B?SHZURC84MzlFcXZGRGR6NGlIRTRnRWV5K1libjRYZXVwaHpYZVdQR1JPMzJV?=
 =?utf-8?B?anFPOEsvbG8wcWEvSnp6c3pNT1pZaHlXNitEWkxjYytXZGtDYjlYM3dTTm9l?=
 =?utf-8?B?LzYycndMdzdoeTZJdmY4SzJuVzlJV0UrREQ1V1g5UjVNd1V0WFkrb25Vb2FG?=
 =?utf-8?B?S0gvT21zejNrdnBwdkJONG50WXJ2QVdlUWlZNkMxTVV3ZTcxTFFmcTFEK29u?=
 =?utf-8?B?M3l4MTdtQk52cVQvZmdtMVlvckRFRXNwVG5lUGx6M1lxbWpHRHJOdmJ1akZN?=
 =?utf-8?B?SEM2OENNYTRWSjhJUGM4U3NjdHh2U2ZuaEdCOXZMM1RJclRieHpFNmpFcENs?=
 =?utf-8?B?U1lVSkR3S0YvdWsxdGR6OGplTzFiZjgwb004RExlYnFqdjlwRUxSZ09NbUNi?=
 =?utf-8?B?RWRDU2pSRTUrVG1HUVhibmtBMkE5R25Vblkwclg2bk9IRGswT3R1MXR3MVNx?=
 =?utf-8?B?c0xWQm56TkhOQ3EyM0ppMndRanBmM21ZdHBjTmxGQ1lkOFlQcjhFSnl3cWJW?=
 =?utf-8?B?dXg1UVFha1JXZWR6S2VkQ1J1Zkw5UnlydkZ4L2lvczhVSjNTQkVmclM3ZmNO?=
 =?utf-8?B?RUJyaE1mRjJBOHJVSlZZRUtqNTMrSVo5QmJtdnpORFNJUWxsaWJKUkJoWnE1?=
 =?utf-8?B?dldhQXIwR1hPWXFyRk9IVktCZDdaTUQ4RnZkSXhYMXp6V3ZmT2NNRWpsYjlD?=
 =?utf-8?B?OXlOQWpFYjI4Q2lqeng0VjhLYmRWWld3d3o0aGM2TlZaeGFnOCtpOUtqd2g0?=
 =?utf-8?B?MFF5WTJ1UXV6NWNrdXV1WHpmZFNjcml3a2MwSzB4OTI3c3hYZDNxTE01cG5L?=
 =?utf-8?B?R0R0YzBtUWZlOVppL1c1RzFrckdSMnd0UjhxVFQrMG9ITS96d241VkFWRm9i?=
 =?utf-8?B?Vk50QXF5SU9FSGJ1Zm5MQi9nRHo5WEJTUFNXZmRzN0NMeW84bjNvZ3hkVnpG?=
 =?utf-8?B?MkNvSDRFMnRSRmRlQ2Q0VVlCWEVZV1FrMEl6UzJ3SUZMWE1IbUVCaWRIK1VF?=
 =?utf-8?B?MVhSNitYVlVKYWZXckxKSEI1M3RQSnBZOHVqRjR3ZC9CdEFKb3Z0Yk9DZ1V2?=
 =?utf-8?B?eWM1SVQ0Zi9yd2dTM2lQb2R5OGQvT2dNcXJQNjFsZ0NEZkR1TytMRk91SDlL?=
 =?utf-8?B?NHFnamhFWFkrR1YyWDZ4Tk9sM3Fkbm0zeVlVZWtQVGQwdzlpZjA1bHc1MWJn?=
 =?utf-8?B?clQ3TmRtUVJGTi9DeTFCUytSMzhESGRXQk9Dd2VaalF5MkFaaWRxU0NyK2sy?=
 =?utf-8?B?ejZFemNNL2xwdVg4Y2dRTWp3UnpKNkpsRXQ3Y0lvemJPMmhEbG8xSXpObFk3?=
 =?utf-8?B?SHZFUVo2TCtJVm5wK3g0TklpV29lODRZdTYyYjZ1RFRiQ3Y2TS9ycmNGSGVh?=
 =?utf-8?B?NUlYWjRlcitzb1o4TjByaDZoTFFpV2I1MzdneHJwa2tDTkRGRkRmWlptTlBz?=
 =?utf-8?B?ZGs4YWhvd1M1TmRKYWd3UG43ak1sbGY0R3BoZUhkaXFOODArbGJtN1RQV2Nt?=
 =?utf-8?B?UzlSZ3BoRU5rRysyWGd5dmJaMUpnNEc2OE05ei9RYkJRZnUrZ0NvUXk2d3Nv?=
 =?utf-8?B?c0JJRVFuOXZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktXWldjdm5zMkRwRkwzZWVBOUcwNm0xZTVlb3E4YnQrT3I4cENTUDVOZnBP?=
 =?utf-8?B?UjQ4K1JKc1lrRkZuQTZkcFpLMGJaeHJ6M1pRS2pkaDlCR1ZOaW4rb0FmRUQz?=
 =?utf-8?B?MHF3bXBjdTFscVNZcGw1OVhEaGJqeVl4YkhMSDg3U2Q4enNreTc5cG9uQXo0?=
 =?utf-8?B?WXVQdk1IZ1ZBMUdrUFJBdkVwRDNEaVN1ZVptcUFRL3Z2ZXViazVmK2JueGRP?=
 =?utf-8?B?clJUY3dJVVZqZitQdW9sdXhxNHAzQ0NkYnBTcXZuNGEveXNPZ3pZY0xxR0xk?=
 =?utf-8?B?YUVHTkhMd2UwYzZ3S2NIRjZtcVNPMWE0bVZOZTBvdFhvS2grc0FzNXA4dVo5?=
 =?utf-8?B?WnA4U05obDNiMSsrNGxPNTVlTEhicWZSMUpjMTQ4c25qa3VGZVlxckhGcCto?=
 =?utf-8?B?Y0RjakpwZmprNHVJWGdTTlpCdjBFaUhGcnpIOXZyOGhSZ09VcVkwNExpYkNI?=
 =?utf-8?B?M0lTcDFDckNNR0UrWjY2RG1RNXBYdllTS0w5b3hHWUo0djFqa0ZUMmYzN2tU?=
 =?utf-8?B?VFBEZzNPbWkvZDBFRXNRc0x3TmtESCtlamh2UnFacmN0RzhrWDRIZzJPbWl5?=
 =?utf-8?B?b1p4U05UTkM4cEdUYlkxa2k2Qm5YMDRuTTQ4S3FFeDNHanRORjJ0ZFgwWUIy?=
 =?utf-8?B?MUhjZmYxVVNVOFl0bVZHWXRYaDhUaWZhcDQrUnYyVE1yWjNQWEtLQ3pIakRK?=
 =?utf-8?B?UkZoM09uelBGbTk0c1lpMlFydVJ2YnpESE02VDl5NC9wV2t0N3ozMXc4TG02?=
 =?utf-8?B?VXh1SXdQRG1uZUJxZWdHVFNjd0RzU3drd0YxVUUvNktrNlBMWXdBV1dnVHR0?=
 =?utf-8?B?SEpHRE1udEdIcHhreXl6SExrSkpHS2FrQ0Qyc2U4UlZjQTFOUnhDYVpxSHor?=
 =?utf-8?B?RXFsaXJqSUYwS0IvditXSWJFZitxb3huVVVldWxyUXNEaEY1K25aZnJjNmVT?=
 =?utf-8?B?U0Q1MHVKcUlKQ0FTZmRwcFlVSC9qMkczNnRpcEhKWHU5V1czNWkrMDN6UTFH?=
 =?utf-8?B?V0JMNEdocnNUdWpvek84THdORmVzWlFKaXJXVG0yajJvd3l5Tm1zM1puT0Jt?=
 =?utf-8?B?NTM5b1cyZFpMOGxranFra2ZLbGlsY1BXNytveVo0ODRGZzJXMjZvWDNQQ0xt?=
 =?utf-8?B?bVlFUjNGTXNSZW1kaGNWT0hGWEVMUFlwc3NBdGphMzhvcGthNEQyTFpyOTh3?=
 =?utf-8?B?T3NlVDlkVkhBVFk4YXkraW1pbzRySWpUWElXQjBXcTZmNlREd3Zxd1RITmZ4?=
 =?utf-8?B?MS8vY3VQZFRYZ1UvSE1LMVZENnh2dWlqaTBxbVlvalhrRU9DdENOSk03SkVG?=
 =?utf-8?B?THVXV0pwNUNLVVRiclFJYXlTRFVyYkd4clZ3cjI1TUdNOWpqc2FYMjEyNUJS?=
 =?utf-8?B?R3UzRGdGQWQ0c0E3Vit6OE8zTnNEUWtQcVFqWWkvd2NBSjUxRzEyWklVTTV0?=
 =?utf-8?B?eFY0VW9LTlNTcWVUWlNGVWo4TmIrMTAxV1NNRjMzekdYQTNqU1kvTFNXUXpP?=
 =?utf-8?B?b2xISXY1eGVLVWQrY2ZUcVdySTlFL2dnMVdoL1pKaU9jYk55dWxLaWtnd1hz?=
 =?utf-8?B?SEl1THhwNHJGbjNCYU1mMEgzYUtGOU1MRkYwZGVPK2pIbjVRVU05d0lsYTdX?=
 =?utf-8?B?UDI2cHp5K25QSTg0YkVuWkp2UEN2MmNSdGszU294OWxKSGUydUhVc0syUTI0?=
 =?utf-8?B?SGlXeC9SSnRVbTZkVi8vdGVHOGVFSTNvbFlpUzZhREdydWdaRk1Pejdvck9V?=
 =?utf-8?B?QytRRTN5N3BjOUVrS1FjZCtBV0lYaDRsSGVEeVJjZFJQckxaNkk2amlGdlpS?=
 =?utf-8?B?NmVSdU1BWHB0L0VqUXhlSG1yU2VVeTJ0VnhqSkk0eTJmbFpTUjJvODVzQkNt?=
 =?utf-8?B?TjhEdldsWDdnRS9IWGMvSGJDUjYvNGg0RmxwVkdOdUM3bXo3MmIzZTZwS0ty?=
 =?utf-8?B?Z0IwTTF0MnBmOXJLakY4RFlGbGVhOGdXNi9EdUlDNHFDdjFmaXJab0hQeVNs?=
 =?utf-8?B?MmRTeTBvZHlKL2pIeFVuZ29ueDVpQUdPQjBKVGFzby9PM1BYRVlteFZWcGlj?=
 =?utf-8?B?ZDVzWG5PNXBZamRJbzlzVlo2R2ZzZnNXYmMxUzEvOFpNY0pTajEvRDVtVzFr?=
 =?utf-8?Q?6fGwUYh3jJChV/xxDlQQkfaEe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c22857d1-ac0e-4400-cb6c-08ddd063f1f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 18:56:23.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd425jC98MMpiCCv2defSoz4NbmnOxXazN3yb8x6kq49qij9LxBxMhc9VVGBeX+s2z8gv+YtQO5x0NcgfMW8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com

On 7/31/2025 8:57 AM, Dave Hansen wrote:

> Could we have a slightly different changelog, please? The fact that the
> logic results in the bit never getting set for P4's is IMNHO immaterial.
> This looks like a plain and simple typo, not a logical error on the
> patch author's part.
> 

I can confirm it was a typing error that led to this bogus logic.

> How about this as a changelog?
> 

The changelog is fine, except the error happened while choosing the
upper bound (INTEL_P4_WILLAMETTE instead of INTEL_P4_CEDARMILL) and
*not* the lower bound (INTEL_P4_PRESCOTT) as suggested below.

> --
> 
> Pentium 4's which are INTEL_P4_PRESCOTT (mode 0x03) and later have a
> constant TSC. This was correctly captured until fadb6f569b10
> ("x86/cpu/intel: Limit the non-architectural constant_tsc model
> checks"). In that commit, the model was transposed from 0x03 to
> INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> simple typo, probably just copying and pasting the wrong P4 model.
> 
> Fix the constant TSC logic to cover all later P4 models. End at
> INTEL_P4_CEDARMILL which is the last P4 model.

Tweaked this slightly for accuracy:

Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
a constant TSC. This was correctly captured until commit fadb6f569b10
("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").

In that commit, an error was introduced while selecting the last P4
model (0x06) as the upper bound. Model 0x06 was transposed to
INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
simple typo, probably just copying and pasting the wrong P4 model.

Fix the constant TSC logic to cover all later P4 models. End at
INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.

