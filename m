Return-Path: <stable+bounces-118367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C71A3CDA8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 00:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1281A189723B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958623FC74;
	Wed, 19 Feb 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/mOG9Mf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB71D79BE;
	Wed, 19 Feb 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007921; cv=fail; b=on5gke7iE4HIV8RCHMpiunc1PsfoFUjE/XEYqR/19mxRAO+TrnCkRtC7kqkuhEETH1Lko3Te2MHpwdYaGwNBSHGVKmN+fWdeSmsXPmkRxATcLtUWEgE2357okZfclNIUdcxYZqdbWa96S6AqaApvdrLD9PvCm9pRoimZwFhMCMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007921; c=relaxed/simple;
	bh=psBDraQMgWeyMuWPBiAms09q7B8l+kNjdyNdsl8icto=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Alg/Swzs1A1vwMwteGk42ry4BySGvhssEIc19Q/Tx1H9n5ap0STSNQU6cKLWZ/qJ9Mx3xY/8pDJ4qIMfRH3BGQS9YgENsUY9kN/YppR97vThYJj5fKN4k71qdMYpowUp9+1CKeoxcs2wWdHbQnMYy9Wls6D/ZpuEbGDZzdxGJQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/mOG9Mf; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740007919; x=1771543919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=psBDraQMgWeyMuWPBiAms09q7B8l+kNjdyNdsl8icto=;
  b=l/mOG9Mfyzjo2T6BJaM6vjBLrwjdL5y5JDyM8pnrHAvFg5g+XK1kuNh1
   LCKvusMIQTtO+ESgZA3MqeEWBGoCgSbTV5eIqSGUHqe4wBn3PnboXvR8r
   X3/21qqXzkp+VK2hs6HEGlw6+AzU+qSgBAmYiUDom8kJMdbTAwgsK7lIo
   qkcsnHQIp/OvROPH8YqPegswvTMToH0ZC6jEy6xCZKunc2kFHRRRQ3tFO
   itgBmh2ajEQ2JP913PdbMeCXYNIE0TsK8a3+i86hBx0Nxvgu7LnWEYDMd
   YRLUosuVIPQTXP3oHXgCwKzJnr4igK8febGPqAfKlIii3n7HpyXEvD+wZ
   Q==;
X-CSE-ConnectionGUID: cBrLxlEJR/ejjMuyV8LjfQ==
X-CSE-MsgGUID: XAQyWTewQQKM4ppxjPEduw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43598338"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="43598338"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:31:58 -0800
X-CSE-ConnectionGUID: kPpapFSaRwKcNmucjBNNSg==
X-CSE-MsgGUID: XH08suZiQOG/P25Cb9kFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114701638"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:31:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:31:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:31:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWZ2AIzVCyUx3YVGOsTfsNgLFvLFHMu6QQYa9gs+gMuKqG0B6i1IrKRT9Lphj72spB3oZgDs4rkJep2koUV7+9csMJTbUSWF3YwnvrN2x1rcUjuCksgLOT2whDEmThYfrC7Pigcb6E7QQU22ySrQ0awozy9c9zy3rZ7jHL5gTPOKxvxrNFtSiv9O7ociNGSxqyCZcL/7sWncjI73d6uuyotlcAPwiympAdmAJOY27j3ScpMef6X31WWiW/qTdxJhBZ4vJ9yESqZtLaLgEOBS5P4s59YFCG5OSq76PnsQGsu2+sFhxHCEWWqLarGNI6LqM23W5ntaQgy9fzIRXlYrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYr5T8lDQZtfXUP5D04V0/NQzqj8xH3TBu5nUvla6JU=;
 b=KOzcOOsa30zAHL9fQ+WtIO/N4qs/LtdgtFQ8cBrlMamLU6YtKPeJOWKPuOkmEHpHh1pepFhFAteLwYisv8lAAMPRu/YsVbxSaGrKG0pcRqct/9E8wX2QTHB5HYVgPu9VJ83tH8WATqOYS7MdXIM5+IWb+0ewbLDNQNPdOTpuMpbXi5JTxXoHeSwNY91oZxadLpbl6xo7MNr5NJUJEZeDtyMYGgKtq5HEPZY+p01Hi6bnNeVgYzi412i4AjJ+NHc/FlJMDaDluPYVp3aGqFpPEyvl4Ioo5kl+4Ut+yh/OvsNlTcJqz8FZGD1UQHb0As+gOWmVwkGamm3civu93o7m2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:31:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:31:54 +0000
Message-ID: <568d5755-6ac4-4834-8362-65c04e6c7cd9@intel.com>
Date: Wed, 19 Feb 2025 15:31:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <chenhuacai@kernel.org>, <si.yanteng@linux.dev>,
	<fancer.lancer@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Huacai Chen
	<chenhuacai@loongson.cn>
References: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cf6fd0-fc15-48da-afaf-08dd513d97f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFBWRitBaUVYYTlPN0RYM2FDYzVVWDZick5Ib3F6S2QvSStiS3c1R2srcTRu?=
 =?utf-8?B?RDNocnloNStBWkU5MnpZUHFaV281enpTMm96SU1PeGpaODBvN0ZkMzdud1M2?=
 =?utf-8?B?d3ltYWpJdEhKUDdraGxsUWJkQWpLNEpiTnlHQ2k4Rk55NVFuaHdKS2J0U0VO?=
 =?utf-8?B?Y2M4RVZMRU5zOGpMUFFCVXVFV29iVkhCUmtYWk9HYzJjd3dWQ3VVcis3a0NE?=
 =?utf-8?B?L3pvTWVTOWhrbFdMTWQzeEtQWWJ5SFZxZ0pqWXUxdnBqdUtZemN0ckRZUDBx?=
 =?utf-8?B?VWZidDRlejBHc3JzamYrSUtDbFpyN0VxQVVsR082L0ZESWVHVkpaN3NSVldL?=
 =?utf-8?B?VGd5Qzh0U0I3bmxsZUpIeloyTUt0NDlIaGtLS3B3dlh6VHhvcEdxSlhXc2tX?=
 =?utf-8?B?NU4vb3lCZTVHcVFFZGpQdklaR3NLQ3ZrODBKRjZ3aXN1VTFYVWtiVi9MVXVY?=
 =?utf-8?B?S0RkU3QydXZyOUVOZHVqMmFpd0lEUU5wdFp6ZlpQcHZFMjhNSEJETzIvSVZ0?=
 =?utf-8?B?NDFVaFAyNy9Lb0tMSk41bzN6NlJIQThOWm9tT2N3TDdBRXpxRTdFR0I1YmlO?=
 =?utf-8?B?a1ZlbWp2NVJGTFdHWENuQ1pzUmhkWGdTZ3Z1ZzNnV2Q1S3Avd1JUUVZjd01R?=
 =?utf-8?B?TXdrNGN6NTNwakJCRjl1MExLbnNuM1Zta3hma0J3ckN0TUtuMWU5d2I5eWty?=
 =?utf-8?B?aGNFUGx0MFNISnlrNHlxMGVpNkpVNCtNaEwvcjBXY1Fid0F1VGc3OUpDdHc4?=
 =?utf-8?B?aUZockZLYkVpMTFCRXplZlNTUEhXWGFLRk9vV2hjQ1FEbjhGSXhvNXRoVi9o?=
 =?utf-8?B?UHNkSlNsNlRXaWY3aVBwYWJrZjYrK1BHR005YlVWU2JYbjdIb0tjSXRJZnVj?=
 =?utf-8?B?ZUthWVg2V0prSGVkU3FMYjZZd3h3RGdEWkVZSW15THZBcEFtRWxHN2kxSWsr?=
 =?utf-8?B?MUlyWXN0UkhlSnhkWVJZbDdaVHpZOEJ1QTQ3N0lBLzd0VzA2WlNlZG92VGtX?=
 =?utf-8?B?aUZPTTVJVXhncTZPQk9zNGU1R1ZRWXcrWDZ4MDFzR0lyTTRic2hYNEQ0eGg3?=
 =?utf-8?B?OU1odE1SSHdPNVU3OVFmRE9IVlA2L0E2ckZIYkROTkF5dmZvTExYK051c2l1?=
 =?utf-8?B?ZEdQU20zcTRGcWtoajRVTDg0Z1E3WU1jWDROMGpuVmdFSEhTTFBkdVV4S2JC?=
 =?utf-8?B?Q0V6dzYwL3hSdnRFc3VobHd3N1ZuaTl6enVoMy9NdVJvTHIraVRUWEhLYjFN?=
 =?utf-8?B?TmRBK2pwZkttYStjbVpTMUdpL2NJeXdhU2svak1DTWw2OWJTL3BFc2pwOW0v?=
 =?utf-8?B?Z0IrZTdPZ3VXUWt2bkRWVU9BUWo2RzBNRmNhcmVlUnUyeGtOZTdmMjZROXUv?=
 =?utf-8?B?eEJCSGt0b3RDNWZ0S1Q5OE50cXpXcTBkdFZXY3VJOVBtQ1JsbnZBTWx3Q29X?=
 =?utf-8?B?SUpJTjcra1owbzBkMDIvblVmZDlHMFdGMjY1MlllZ2lsWUF4WmN3N2hQNmhJ?=
 =?utf-8?B?TGhPQ3hCOWJoYVQ4M0d5cWRMQStUUmE3SVRiVHdwdmxwZGRiaEthdjY5THhF?=
 =?utf-8?B?MXFpajVkWUJaK0JaTTJJNW5Rdmp1N1I2b0ovc29QZmhnWm1laC9sM2RzZGxU?=
 =?utf-8?B?VWFqNVBvTTB4L2o2ZzlIbTJzczJlZTR1UHlFdVYxK0k4TG5ZRVpOZlVXTURW?=
 =?utf-8?B?bnRmOGJGR1oyZVVndEp1bHBKTjBIN0dqSWhSd1NVNmJnY1IzOUlFaFFXRXJl?=
 =?utf-8?B?OEZOb3FpVGp5TGlsY3VLYUpiQWVIa0trc3IwU2RjdnBSd0RpYnhVMWVDMEpT?=
 =?utf-8?B?R1N6eHY1bjhpNlI2aUs1a2h5Q24xd2paWjE0NlRSek5qYm94aXh4MkJJcUFu?=
 =?utf-8?Q?cQwH79PpxdaHD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tNU01xU09iQ2owSGYxZHJWajJ6amdGUmFjWmVHQ0xSTHJ3UjlDbi9waUl4?=
 =?utf-8?B?WnBCRkNhZnlVbEwyMGR2Tkt2R3N6MFlHSFlHMjU1RGtrYk56Qzl2RDFIU1E3?=
 =?utf-8?B?TURJTUVtcDJuSHBLWkRqL2l3SHNsSW5KaGJKVS9XL1pQQ253a1F0UXRSSW1h?=
 =?utf-8?B?VE5vVjhOWDJUeGZiMVBxVDk3ZlJ5djZFOVZJZEN2TCtVVlBuU1lNR0NZZXFo?=
 =?utf-8?B?NWRvZXRQN001WVhuSlAwY0VvWFJIK3E3a2FrRlhGdGRiaGQ0NlYrWEtWMVJ6?=
 =?utf-8?B?QmxKRHZrM29JMGUrbzhqd2xEVnZZd2JQQzRWNDVWdEhZUFRCMDladFlTcXVT?=
 =?utf-8?B?UTd1VTllMkhnU1JmR1VVU2wwV0hScVR6M2NYSi9XMDBocm9rUlcwZnBsT0Nr?=
 =?utf-8?B?RksvKzVlLzhHaG1vZis5QWpUOXhoTVk5SU5WaDVob3poRHdrWUt4b2V3K2s0?=
 =?utf-8?B?WkExbjFjdkY5TjR1a2tKNjMveEt4OUNaUGZiNUt1VDFUZnRLZHlDSTV4VEx2?=
 =?utf-8?B?dEorQnMxbmNseWlRT0Q0amYrMjdCYVc4dWRFUVJJenpIeGNBYXdXdzFKRWNo?=
 =?utf-8?B?c0l0ZHlKMGdFd0hZM0ZQeit5QUJSNUg1SmFWcm9kc3JXZTlHcnNWdThrMzY0?=
 =?utf-8?B?ay8vVTFMWnR0U21ONVlWdUVuQ3o5cEdmWHlYdk0vNDhhWlczSFQ2MkZIYjVv?=
 =?utf-8?B?RkNTVWh5OWtIMkRIWTFXbzBxZW5tNk9CZHZELzBaT215UHdCVXNaMlpPbzds?=
 =?utf-8?B?SDUzVEVMVlh0M3cxZzE0L3lUbHhIZ3c0OXV6czYrRkhDbmdHUDRHMUpZZXd0?=
 =?utf-8?B?RG9IR1Rjd3ZHT3FzWFc4WVJmTkdDN0dOZ2ZCVWlDdTBsa2JJV0VTUEZnOEox?=
 =?utf-8?B?Q3JmblpqTGU1NkJBWi9PWG13UWNpcFhnTTFNbCtPT3JMS2NKdi82U0Q1RU9O?=
 =?utf-8?B?ZFpBQzE0S25wbTJ1dkt1Y2xURStaYnNHRkpEVm1pN3VwM3lJcGZUWWJReEYx?=
 =?utf-8?B?M0xUeCtodDVzanhnbStOM0ZaNWpTL2lvN0hmdmhGeWFtUkt4YXVsUjdtdFBE?=
 =?utf-8?B?U1J1SDNZRmZDWjZBcUtVZjVNazcvYVVWWGRKeFQzTjBMQnN0SW9jNmRPbkRM?=
 =?utf-8?B?OW5GcHQ5d3Y3cEkwa1RzK0ZPdHZPVkpMRG1yS1ppeGVPTElST3VrbDVmalZj?=
 =?utf-8?B?UU93eGdjRmF5Uk1YbFpaTkNaTW15YzFkVVZtdkc2MXMwR1NLVGEwV3NsdUJO?=
 =?utf-8?B?aXNFZlY3WmlVd2FhTlJWUkpBWEd0RFkxc3U4Slo2ejBmem1rSndQMVRSSDJu?=
 =?utf-8?B?bW42WlFtdGJGN25iTk5rT2xlQ0hVVEswQkxBUlk0djBzMW1zZ2hvMXQ3cVF1?=
 =?utf-8?B?OHdmdytGY2xiOXlMMVNTeHF1K3BkdWRtU09nVUF1dDBRZ3lWNlJ2SUdPcENV?=
 =?utf-8?B?L0lxZU5EK2FrbWJ6Q1RCcUMvK3FyRnRSQ29kMGoydW13dFRCWnR4M1RIcnJ2?=
 =?utf-8?B?bkROT3N2WTgzQ05rZmhydEcvUURvUWM2WFErdmNvQnoyOXNCT21Ha0s1ckxi?=
 =?utf-8?B?dC9ncGJNTjJMVnBYekpLZGNhdk1IcG9qMUZmcG95QnhGY0xud05WdCs2YUxk?=
 =?utf-8?B?a1gwcmh4VU1CS0pkTEczdDB0ckkxcmpubDlBUFlMU3c5YnBrcFE0M2lQK3c1?=
 =?utf-8?B?YWY1RVF1NUJkYW5nQWpHTGFtQ0M4RU5ZZGxwNVJzKytDeUpLUGZ6ejJEV2w2?=
 =?utf-8?B?bTQrcU90TGZ5aFQrcTJvTEtLVmZVM3k0TFRxWWl5RWRwMFI5ejRlSGhDa0lo?=
 =?utf-8?B?UVZxQVBjOUdpSG16dzZSTUdIYit1OWYvMUV5ekVKWnczcDIrcGZ2SU9FeW5D?=
 =?utf-8?B?RFZYb2w2dVN3dU81MldOdE9RRW1BUkhvOHNLS0VqcG4wUFdPYTdzay9LbVpB?=
 =?utf-8?B?TXZJQ1F4WWNNR0cxdEwzenVvbTZUaHBtckRQN1pSU0l6K2MrT0R4dUl5dXI1?=
 =?utf-8?B?YlB3emlYUXg0Y3M0V2J5RmdmRXlpcHlsandZL0RhZlREa1Rxa0NDY2piS3hr?=
 =?utf-8?B?MjNrYnd5R1NzQVdIM0E5Um13cVFVVTZCVjBGY00rVS94NkxKZXVaakNqMzQx?=
 =?utf-8?B?SWNCaStWUGNSUEJSb3UxREZGSC9SUmJCYW1KT295L0Nsd09rUmpZRGxnVlI3?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cf6fd0-fc15-48da-afaf-08dd513d97f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:31:54.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0qrLtcpym6RoLRTMGwa77RxtBsBzfmfwuT0svUrhryWzYfo4UGkT4U+UzlxV/9j6YZxQ0zr8Lztm0MN6JGjbrPTU/nes6kunsw4Dt7/1mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com



On 2/18/2025 6:07 PM, Qunqin Zhao wrote:
> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds.
> Therefore, the following error message may appear:
> 
> [14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma
> 
> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

