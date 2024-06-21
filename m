Return-Path: <stable+bounces-54841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F5912D86
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366F61F23302
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A717B4E8;
	Fri, 21 Jun 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv+dPhKE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1E16A95E;
	Fri, 21 Jun 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995763; cv=fail; b=FN3fEPGdgqzfdZufDev71pT226vmh7ARsqLx4wz02Qrssnm0hXDkzRESWRtzNkHh7YhG5TQl7qRyExRd2cCnQvj41j+T/Y53QV+SD5QeRh72uktxMgxG5Zhu5frIF9x1qnZHX+GfmePcPPSiDQI1Kz+EbfMwzM2ON70CePdFIBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995763; c=relaxed/simple;
	bh=WvahpupzCcHnqugMyKAzH1EREsf+yRbv2bdxo+g15Bo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7EBT1zw5NVzqjOxjMlCITNX51Wv3m8U9OUq4kLf43SVd+UaBmXA49RILSpAethIycwNinjqfQoMQeyDwfg1XG2FDjW59PMS66E7T4amngIAPzeVikHeExmwD1cvrIrVyskjRih+AuL+BaiWXST+5UNDSqgfCIVIOfjUM5S/iog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv+dPhKE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718995762; x=1750531762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WvahpupzCcHnqugMyKAzH1EREsf+yRbv2bdxo+g15Bo=;
  b=Lv+dPhKEab4fHoCsSUqmRufH3ViIDYzytNgiCkhizdNLWkPHwt76RddI
   Mm6Iwo1ftTmJzYLdMriLRu1OqrkIz4r6SOQNM+tzzucQLf4ToYGMzAOjO
   pOqU9Z6/ktP1av9cDUDB2VdoAouNe4ZAsqJvZ24c2ei9nj3yYOiGTDLQ1
   E/mbN8pPdGMhY8d5S8gigFP5wKUODwKI3sUeZbtAI4Fi0nu0uawrbBu8e
   aCql4o+oW4hbaJy9eg5vXL9cEaTi55dZ9wiSJMdCDjwAltCiFMOmPAGtQ
   9xR9j09/K1FaGYrndoeSBJhuEn9AQFqcj2g8nkjVuMzlY4WkNGG0b0SmF
   g==;
X-CSE-ConnectionGUID: eIGLTFGBSVKDmrYDAyS3aQ==
X-CSE-MsgGUID: VDBmtny1TqanHuo645rrhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="38563729"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="38563729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 11:49:21 -0700
X-CSE-ConnectionGUID: 1Fui6dwPRVWml26d+cUfbA==
X-CSE-MsgGUID: bRWGGOdxSwehKPf0rwTDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42580315"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 11:49:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:49:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 11:49:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 11:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVEZ3QwcYYOv/71+b59aAurHvnUOxFIRtXbb/m7BihavNA0JqDSPOyi7w+V+mQRGgCPs0YzAvLeCsxAWvAaZy3s6R4QySfTtVTHriGewc2HuSwf+2WBtcicOOiq5YyOuDtjs5R5b++M+NQ06ZlZOe3IAd1EaO6ZxHxD/YWpiALRO3XPoYx7ntsKX3yDbAIsneJ5nZz6HVEeQsX5P2Q4Jmii4xeh16Qd/Zh9aAVCgkax0uyXqgTIos0H63NS6bzJ3/cQxb5QFwuFL7PpZJXvgd933bnHgkXxSxwhZ+wW38KYwzC9jnwdwWZ3JelWS/Uthix6X5A3cuDMsxyikEtwG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1MhGblQfFnkNG9uVGoQgcXKI+bmAbbKEHM0vgo0RpM=;
 b=LOUzOmkHuq3ogJeZqeyMGi853ZbZyJL+XIf5Y8p1osjhMqcEyE2XKNKk5YJg0QhiPTaH5Vrw7RM2zu1J+JdWgOkN6ckvj3SwlHVJlfJbMwEmDJfm4j2tZ2UEMvIiDSjnriCqAQJ6x5NkxZssWo3cxdgcQTYoWsvmkUafypC9RZuFhn3aQkLfZjd/0YxKlNbGWq9Y7y6n7Iglc68q0E3ehYu/M826uG95hdlGdVgRc8L5nfhDmepsAdNqLIPotGALObj/4Cvme5vRY+WbVov53Q/tLjblpfBelqY7fP3O171Nsf3zYUzR3FaSg5Od+tEsZjNuNvwsIxNgiKjlz9mfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 18:49:11 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 18:49:11 +0000
Message-ID: <8f7fd03d-a231-4319-b83f-def67ef6f58f@intel.com>
Date: Fri, 21 Jun 2024 20:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ACPI: EC: Install address space handler at the namespace
 root" has been added to the 6.6-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240621154703.4152297-1-sashal@kernel.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20240621154703.4152297-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0291.eurprd07.prod.outlook.com
 (2603:10a6:800:130::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|CO1PR11MB4817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbce957-ed5b-45d1-31e4-08dc9222d6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUQ2aE9lUGluZGJiMm16ZTlqcGtzRnUvL0I1QVE5SlM0OVE5NUtuSklIN0Fn?=
 =?utf-8?B?MWtFZHUwcTNaclk3Rm1XVzBvaWJIb3BhTXAwOXo1MFQ2WnVSQ2ZFaFRmSnpi?=
 =?utf-8?B?bTIzanB6ZUYrTFN0TGpCK1hta3cyWlpzei9lSUZlcjJDQSs4STg4OEY5T2pD?=
 =?utf-8?B?djhYaGJncm4wTC9GWEJwOExBRXNKM1h4YnB6QTBlTlplbDR3RERSa3MrWkZh?=
 =?utf-8?B?WDNreEpLbUFrWWF4WjRGa0VoRitpdVRhTmozUEZaTVkxWjBVdFI4VFVCQkMz?=
 =?utf-8?B?ZktwL1hNSEdGRU5tQnE0bkZlZHRKZlZSNnZiQUFvblRxT0xXK05JTVlPcy9y?=
 =?utf-8?B?aHE4Y2RvZXl6d0ZZUC9mY25LZUs1MHN2aE92emNDUGxuSjByYjEzRjZjdDF1?=
 =?utf-8?B?UFFsTlZNNmZmQnI4cnlYNkRqZXgyYUFHdDBVaHNpZEVuY3I0d2NocUR3V3B6?=
 =?utf-8?B?ZkwzVUpnbmtZcnNacnlNTHBiZWo2dWwxK2kwVDkvdjZsNEt6TDhIQTU2NGxs?=
 =?utf-8?B?eUpRME5xbzBBaTRjZXA1TENGbSsvMGdoWFdWcVlTYmxUaGIrZlkxcmNGcGtM?=
 =?utf-8?B?MjZMMGc5OHlLcnpzaXZvVUZ3azlMMWcvZUpHNk9wL1NHNkZ3V0hHcXVaamRs?=
 =?utf-8?B?ZFVla0Jhdnk2TXMwM0R4NVQ4Ujh2T3Q3UUhYMFRqNVVpSjRnTVl1N3FZRloy?=
 =?utf-8?B?YWVaMFF5Wi9hSjBJZi9aRXVqV0JNbHgrYmFuRzZzallNWS81dzRDZ1BHMXl3?=
 =?utf-8?B?ZVBzVU8vVzk0dFpDNkNlT3EvYTl5WCtNTWYwODV6STNzRHcwOEhnVUUvVTBr?=
 =?utf-8?B?TUpPbm1QY2hRNS9wS3FMMVBYQ3BhMy9ocnh3MCtNZHRFTFoxTFhQZ2QrNGtM?=
 =?utf-8?B?WnY3Y05jTXgxNVQ5Vk4yc3pFWFFxSWlYcTdkcm14bmdKSmhlN1dZcW5LdlVi?=
 =?utf-8?B?aVl4Q1RTSDFLVzEyRjhaRVlXaXhJMVlwcitsYnBEN3pMMkFjZTJJVE01RHlt?=
 =?utf-8?B?SVllR3ZwbnhFMlhubmNQaUtJYXZYYVBGeEcya2dIcGpDWUljd04xNWVkb1JK?=
 =?utf-8?B?TVdVSlVzN00vT0M3M0dZKzFUY05BWkRxN2srWHQzamNZYUJWRzNlZVFZOTAy?=
 =?utf-8?B?SVFkSnVxQmswREFNT2lkNWN0ZmZ4ZFlYRkU1dmNuUjFvVytnQzVZYU5Rb3pp?=
 =?utf-8?B?MGxidTdHdVJhR1M0YTFRTmFmcWNFakxOaDJSSDZaNGU4NUhra1kyY2oxb015?=
 =?utf-8?B?Y3E3YVZpb3Yvdm5Jb0x6UjZDajc3emJRWnVtK3pMSUZRU2VTUmhTdm1URW9j?=
 =?utf-8?B?Y1Z6VnhmMEpqYnprK0VYNlpLbXF3UnJZOVF6TlZVMDFyMVFNMlV4WnVDVWZq?=
 =?utf-8?B?UGtpaUZ3RHNtS1V1blBTUXFpUSt5VWdsaUV3M21xSmRPL01Cb2ZqNEgrQTJQ?=
 =?utf-8?B?MHEwOVVJSmpiMHN0TnRNaDZCek5GbkpJaE1UTmhRUjhuckRQei92bEZOQ281?=
 =?utf-8?B?cnZyRFRRZXpDWEEvcXorYWQ4UTl6OFdYb1lYc0pZeWtQTFBkTlNSYXJQUTgx?=
 =?utf-8?B?dnhGM1lPWU05V044QjJqY3lVaWY3LzFWNTFiMml3Witweno4alZXTlBsRUow?=
 =?utf-8?B?T1Y4VUU4WUdUT3NKdFZ3ZzVlZm5rYXYyRjB1SFY5WHJlVTdENGRJR1kxMXBt?=
 =?utf-8?B?V2xobWRSVitGU0tqU3RtOEpxSDNWVFQ4b2FGbWMyVTFXQkFJcnlkZGZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRRdC80VlBTTk9ha3BPSmVaNkRoVlJaQjF0T3dyMEZ6emZwUGZ4amVPcTlR?=
 =?utf-8?B?UVZGdk42VlJsWC9qOUFORENSR09nZDFkd016MExrV3RmR3BETUFCYndmMExp?=
 =?utf-8?B?U0Jsbm9XMkdTSi9MTmpkOVY0RFk0cWYrL1k0bkY5TFFtNnVrNzFySVgzVy9t?=
 =?utf-8?B?MUNWa2FjbS9DYmpIRHBBMDdEN0wrNE5qSmpBa3p5YzZRSjl3OUd6bHZKY0Q0?=
 =?utf-8?B?MXNpRkVzRmtaajdiMGEyeEJ0Y2duNkJiTklKZjNDZ0VMVWtENDJYemNPY0k5?=
 =?utf-8?B?V0lPT0xWMUZyMks5c0VsWmJydjdacGpOdlVNanF3TSt1YXNvTVlJN0FBazlU?=
 =?utf-8?B?WWVIcHB3blJRa3NOV2ZvaTd4ZlRQc1FwZi9iVFdlZWVZZkFqdHRuNThBK0xr?=
 =?utf-8?B?a2VrWDZVSUNDaGZnYWVMaXQ0TXUxN3BXejd6Z21nV01lNzUxY3NsN3ZSblh0?=
 =?utf-8?B?ZzBLeTNrbUE3NGIxNnIxT3NTNXpkTUxKM3hPdURvdmUvQVBZRnpLdlVCNGhX?=
 =?utf-8?B?NVBxZ3lPd1UxSWt0TmYwN1B6MWVmVnVma1kwMXhWOG1FeGo3WUxDcTNLSlZW?=
 =?utf-8?B?U1Q1RlZWcFVGOUhQaHBKQ1paeHJyZFVtaDUrb3k5Q0haVC9sNXlwVzYxRHRG?=
 =?utf-8?B?TUFlTFg3QU9QSFNlWVVvK3IxSTFkQ2EydUJVdzVkQlM1MFpCMDdWc2krdGZB?=
 =?utf-8?B?UndMOUJKZWJHVDlRWTdUaG8xbndCSUhXdUF2d2x1RU5uWEw4VXl1b291QjVU?=
 =?utf-8?B?NlJnMzZEQjNyNlltR2xHTTRaZUJ6R1A3VkhBTGxHOUkzaGkxNThSeVVMNlhk?=
 =?utf-8?B?ckg0N2hrUmNtbUdMaUVKVlZsU0tSQ25PL3lxckxqSTdJZGI0UmN4UFp2ZmtX?=
 =?utf-8?B?cFZMUWtUT0xTOVYyZGlTUFVyZ1czQlFEZld5MjhYV0J5NWE2MWxuSlhQRHFT?=
 =?utf-8?B?SmdUblhiLzl6clp1S08ycU4rVGRIRHZZZUo0MVB0YXhoNjMxdGV4Q1R3cTdZ?=
 =?utf-8?B?MVA3eDg4NHdJRVkvSWJ1emxJZjhsZDZscVc2cWwwTzhYN3hUU3JSWjVtL2xN?=
 =?utf-8?B?NEhRSVJySWlZcXZraWF5SzZYdUxOOTNCK09XMWNjL1pNM2RRSk83NXZycWxX?=
 =?utf-8?B?TDdSNW5SZDZueldUODFHSG9TVC9wZTg5UTRVRUNqKzJRRlQ0MTVSWWpFa2Vt?=
 =?utf-8?B?VTlSUjF5aDljRjE4N2FxQ2o0M3krM2IxbE02Qk1GemxEcHMxWWlWOHUrVnRU?=
 =?utf-8?B?dG5ob3B0bnBIMVBZSU5OOE9oZXRDcnRQTEkva2FYekFxL21keXlVcTkvbkVO?=
 =?utf-8?B?TmlnWjhzeHBhRnZENU1sc2kxZ2w1SGxCbTRSNGd1MitxN2psMW5aY1llNVFk?=
 =?utf-8?B?aGZTUFNlZFpzZzZFV1hDYWM1TXBnZE1xMEh3dllIZW1BdGN1TTZwTjZ4aXNm?=
 =?utf-8?B?R2FRRVhXa2ZubDFlVzR4VUdZR0dXL3B4eXZNdmZtYnByaVAyWnRVeVhYcFNN?=
 =?utf-8?B?N1pHdGh0OElaRXZQanBqdGRKZWZLTzdQZDRNMEQ2QTBIY3RkT3Fpc0p3azls?=
 =?utf-8?B?YVVWRmFGendLWExZVytqZDVFZmN1SGMxS0ZOYlJ2RERRMHB2SGF5NGhFdHlY?=
 =?utf-8?B?TVRjdUxwY1BSdTloWmpoWTl0MHJXMHBLOG95WFdZTWN0UU53WlRrV21Td2Zj?=
 =?utf-8?B?a3UvRkd6QnZJYTcrYXpqUE9EZFRTZTAwWHBFVjRqMVp2b0h4aXk1am9OOVFU?=
 =?utf-8?B?OEpSTjByK2lBMTYwSkhtQzRNWXVSWnUwaDdzYWNqSDFZd1VEUGRYdGplcElI?=
 =?utf-8?B?eFcvT2x2WjdRQVE0dXZXWXplVWlSQnc5ZjRzUFdEQmFMVHNBNGNyOHljRUcr?=
 =?utf-8?B?aWU5cGNBbVlreGhzSitlRFQ3ZkdFRWtVMEhvYXo5VmVTQzZsS0s3UjNUZkhz?=
 =?utf-8?B?emx1dGRYRVZ0bXJLMGFqYnp1MHVTbmhvb1lSVFAxSTBJaGhBQ3pobzFob0dp?=
 =?utf-8?B?b2RQazJ3K2g1ZzZXUFpXeGZCK1hpWU1UbHA1d0I5aEgydjFVN0FsWTZLVlZV?=
 =?utf-8?B?MlNEU1FOOVY0NWkvUDh1MTc2ZW1GU2ljRUVjWXNQS2NkUzhKWmdic2FrRFM1?=
 =?utf-8?B?NW1vYngzZnBXM3lacG13M1hmVSsrZ0NmbzB2Tm1xRFdFeCtmTktEempzcW5s?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbce957-ed5b-45d1-31e4-08dc9222d6b6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 18:49:11.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV2pbABmTTkX/PCm3/y7DLqpaWrfD/kDzfkcL6+ZW4vf4UV1y2x2IeEW5MW57p+r3guqSUiZy225YEIhZtb1PeGfevrZV/NB4/WlhodeJHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com

On 6/21/2024 5:47 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      ACPI: EC: Install address space handler at the namespace root

For this, you need

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi&id=0e6b6dedf16800df0ff73ffe2bb5066514db29c2

too (here and for 6.9).

Thanks!

> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       acpi-ec-install-address-space-handler-at-the-namespa.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit ee44236dfbf5541d5fbcb52db961616292c84c0d
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Wed May 15 21:40:54 2024 +0200
>
>      ACPI: EC: Install address space handler at the namespace root
>      
>      [ Upstream commit 60fa6ae6e6d09e377fce6f8d9b6f6a4d88769f63 ]
>      
>      It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
>      IdeaPad Pro 5 due to a missing address space handler for the EC address
>      space:
>      
>       ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
>      
>      This happens because if there is no ECDT, the EC driver only registers
>      the EC address space handler for operation regions defined in the EC
>      device scope of the ACPI namespace while the operation region being
>      accessed by the _DSM in question is located beyond that scope.
>      
>      To address this, modify the ACPI EC driver to install the EC address
>      space handler at the root of the ACPI namespace for the first EC that
>      can be found regardless of whether or not an ECDT is present.
>      
>      Note that this change is consistent with some examples in the ACPI
>      specification in which EC operation regions located outside the EC
>      device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
>      so the current behavior of the EC driver is arguably questionable.
>      
>      Reported-by: webcaptcha <webcapcha@gmail.com>
>      Link: https://bugzilla.kernel.org/show_bug.cgi?id=218789
>      Link: https://uefi.org/specs/ACPI/6.5/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#example-asl-code
>      Link: https://lore.kernel.org/linux-acpi/Zi+0whTvDbAdveHq@kuha.fi.intel.com
>      Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>      Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>      Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>      Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a59c11df73754..0795f92d8927d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1482,13 +1482,14 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
>   static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>   			       bool call_reg)
>   {
> +	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
>   	acpi_status status;
>   
>   	acpi_ec_start(ec, false);
>   
>   	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		acpi_ec_enter_noirq(ec);
> -		status = acpi_install_address_space_handler_no_reg(ec->handle,
> +		status = acpi_install_address_space_handler_no_reg(scope_handle,
>   								   ACPI_ADR_SPACE_EC,
>   								   &acpi_ec_space_handler,
>   								   NULL, ec);
> @@ -1497,11 +1498,10 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>   			return -ENODEV;
>   		}
>   		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -		ec->address_space_handler_holder = ec->handle;
>   	}
>   
>   	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> -		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> +		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
>   		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>   	}
>   
> @@ -1553,10 +1553,13 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>   
>   static void ec_remove_handlers(struct acpi_ec *ec)
>   {
> +	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
> +
>   	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		if (ACPI_FAILURE(acpi_remove_address_space_handler(
> -					ec->address_space_handler_holder,
> -					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
> +						scope_handle,
> +						ACPI_ADR_SPACE_EC,
> +						&acpi_ec_space_handler)))
>   			pr_err("failed to remove space handler\n");
>   		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>   	}
> @@ -1595,14 +1598,18 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool ca
>   {
>   	int ret;
>   
> -	ret = ec_install_handlers(ec, device, call_reg);
> -	if (ret)
> -		return ret;
> -
>   	/* First EC capable of handling transactions */
>   	if (!first_ec)
>   		first_ec = ec;
>   
> +	ret = ec_install_handlers(ec, device, call_reg);
> +	if (ret) {
> +		if (ec == first_ec)
> +			first_ec = NULL;
> +
> +		return ret;
> +	}
> +
>   	pr_info("EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n", ec->command_addr,
>   		ec->data_addr);
>   
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed2331..6db1a03dd5399 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -167,7 +167,6 @@ enum acpi_ec_event_state {
>   
>   struct acpi_ec {
>   	acpi_handle handle;
> -	acpi_handle address_space_handler_holder;
>   	int gpe;
>   	int irq;
>   	unsigned long command_addr;

