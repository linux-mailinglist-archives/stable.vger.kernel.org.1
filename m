Return-Path: <stable+bounces-214887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDMSHcmMiWnP+gQAu9opvQ
	(envelope-from <stable+bounces-214887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:29:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A496C10C6EC
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9406F3003BCB
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2CD322537;
	Mon,  9 Feb 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i++9oh6T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEED31B810;
	Mon,  9 Feb 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622134; cv=fail; b=eS9vOvCNlHegCUe1kO3noyAtfihIKGexolS9qw/rrQ87LvmFeHVR6wpNXYt67rWJ+qgyPl7rDgg4xNQTl6nJW4TFrYenpCMEo4HB3BpHDyq2cFU2KEE63A4SwwnMPW95s0UWAVnOsMUo3MDLUEhwoQeopcQcu7d9Aloo5P/Qg5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622134; c=relaxed/simple;
	bh=aBeEN3bYPR4KmKAgQBjnk1kIhlwPXhmTMjailXmzFE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wyd1TnVrGmZ75cMbY80QGLNfzkvVEfyhra1C6l0/rVnag2sYszYidITV8RVeqolrity/NxA3mOlvmICeP8bijamh5WXT+Mpj34RpiTHMhS6SfHBC7B1FcfMjwX/NWJvlAywkA06XHR5NTmfiF8kth11ty78ep9fv98cVP0FUHBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i++9oh6T; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770622134; x=1802158134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aBeEN3bYPR4KmKAgQBjnk1kIhlwPXhmTMjailXmzFE0=;
  b=i++9oh6TwIL+7Hj67uFgX3uU+Q+e7Yy1eWCtk6shQkbmtVfMaZN7DVhp
   rdWFXHibj3kLTLVSArrSRA/7qKhzS88YANsPGuoOVy28yZaxnAvZycdZR
   +aDSbHEjBEKv4+1xTD/OkUBmCByghKX8i6VLjmQicUzBtH4EzNBqURHfr
   Kk5RukKCN3rEspCXY2jYEfmgmB/aYEaqcfanhrLERDGY97ZKw3AE47OEv
   5iOaVBQEY5enYyVg+egeH7nRfPQ37L9oYVf4nLbrxQ61+MgHgDkUCpFjT
   QgzB2pcGJe0mirW/p2T3nyZ4bJy3far1YSY0rcj0HAiSGUZQk9gyFQAbV
   w==;
X-CSE-ConnectionGUID: GyjtUxF/QcKcdymKwOM8ow==
X-CSE-MsgGUID: 0qauLu3IRCOuu45jcmMuAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098749"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:28:53 -0800
X-CSE-ConnectionGUID: nu0vvUrDQH6GEilSEv/1YA==
X-CSE-MsgGUID: LMlv9246T+230oXBMomA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241695011"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:28:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:28:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:28:52 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4awWq2PIb2rtnTE+ivctqjQIIcLaa9S51+D2N3JEqFxTrshe1C26jkBz4zzvBR/lu+U1js2VlRSJ8WXGeCEAhNj7kLNaRdTHx0wwM736/wJ4D1PoWYv7knhJB7W76YxDWerrPvTP/UFpqH/jIxMzh2z67OJq8xOEPqwipA+St3grXrjkOdEZdMigNsJcyDrwALPKHGyxEgiIj70++SdfKvUJlI0Y35k1oh1HOhySbVxSMX4IRVDB5KapHM563C3ZteCDvy/nZDDQo3IBLpx3+eWCmyLCI1J3cx/T/cA8+Eyif32o69EZ8SECFc+HQNUh45SfXEv+ORH9VhVMZ6UGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpFpg6VSNtHpNu/0jYEoxBchSlQpbkq42JydRa9T9dw=;
 b=YqS4qXgT6YmjANXFunFvXDte63lPFKV/h+0QBpr7/MBpVxquW/YNPhWn72ju8tdock+8UkX3ThB6ETBvmZ0SiiUizIMuR4etJVbP8FrNjUuDByrnL8MHGq9AS/qiH+V/Ptv86eRWmtGDRuiQcRMVdL69l39YBTNqI3dzm2WHvm8o+iEpAaNk+T6YsYyxWiKnTD3LIccT4X05z9MRPfgv8bIA3qML28nzfpRMP7yzevnzHC/gFvZUnTBITjmSLmsFAct/OH8OEEcW6nrxaGAJshG02U8u4W2n2WwJAy6r83f7CgWBNmKqrWYedMA9sT9jkNnG0XpLHsp6z+53Ctrwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:28:44 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 07:28:44 +0000
Message-ID: <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
Date: Sun, 8 Feb 2026 23:28:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/smp: Set up exception handling before cr4_init()
Content-Language: en-US
To: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <peterz@infradead.org>, <andrew.cooper3@citrix.com>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<stable@vger.kernel.org>
References: <20260206185035.1250577-1-xin@zytor.com>
 <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
 <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3736c045-8a47-477a-0087-08de67acdb33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEd2VTRTamFEVG1JbnJwUVNhVUNmM3BuazZWY0taZVAzNmRGUGRjejV6L3Nn?=
 =?utf-8?B?SjVUWm9TWSthM2NJdEkvZUVYcE44UHJ6akhmbkNVVlVEWmhoamhvdGlYcGRT?=
 =?utf-8?B?R2hCRmRaeU4zellxK1YrUUVxcnZUMkl3OVlENEtSWlZmT3NLMWVza053TFRs?=
 =?utf-8?B?OFRMS0sySTVNdjZOeWRXYnZQQmZPdVlGS3pQWC9tLzlLNzQ3eEJaejFHcXJr?=
 =?utf-8?B?ZWw1YXRhYWU5RG1XUWd5cFhMQzRLUHZkZ0NkNzdkdXZaQ1NZSDVzNVV5RXc0?=
 =?utf-8?B?UEJjVzRleEx0a0F6OWFadzNOVmczQjduUUNLWWNmb1d0N3BJcmdQSDVhVmkw?=
 =?utf-8?B?NVFITVBJd1pkbzliQyttNm9YSlorcWlQcUJXekRER1duTm1LL3Eyblo0d3po?=
 =?utf-8?B?V0dwaDBLQmJvOUhTQUdsZnNaaGZycjRTTUdTWGJYU2ZSc0Ewcks3ZDBLTk5m?=
 =?utf-8?B?NXhCWjFpKzFhRGFXMEdZVEhYSUM4bm5ReUEvbnhlZFJqVjBEVjhBejVpczhM?=
 =?utf-8?B?bzlpcTVLWnFTL1d5ME5RZ21FejNOazVtMUFWWVBsM0MwTzlKT2NHY0dNUno4?=
 =?utf-8?B?WHg5TnowNVJIVzBMZ0dpbWxtT1YwcjVoRTk5QVlXem1Xc0RCc0p5WXFWY1ZY?=
 =?utf-8?B?dXV5ck5SOGJsWHF6bXpzU3ZoUDJyNVhFQlA1RkhJUXFIV0xrc1ZXK2k5TW1s?=
 =?utf-8?B?dXVqbnBVTzJJbVhjcnNtSHFyYVQrT3Rvd2VtTW8zZFZycndPNGV5d3d4bURK?=
 =?utf-8?B?clZjczVTNHI4cUQwSXZ1TExTc2hBUERGTHArL3VqcU9DK1loTDFFRXZLK2pz?=
 =?utf-8?B?YUxHUkVQS04zck9BM0QvenB0a3JKTFp5Q1J4RzJ0S1N3RzcxTFBjNmsxZVJs?=
 =?utf-8?B?RklOVEkwT1U0Y09zWWxBNFNSbFNmaHBpQTFOTkUzOVEwTHhSUTN5VGpZN0p2?=
 =?utf-8?B?bmZYQTBJQVJXS1FTRnFDVDNld2hYejBEak5tbTJDa2VpZ2VVa2w5YWlMcmxs?=
 =?utf-8?B?VDhkRGV2Sng2emczakN4cjVEZ1pJNGcrOHpWc1h3OVVLOG1ZM20yVVdGOE5E?=
 =?utf-8?B?WENnbFRFZWlLNjJaUWlLbE4rOWhlRTQybUJKUEVjQWI2UTREUEhBOVJJdFNN?=
 =?utf-8?B?blJmV0hvd0M2Rm53V2hKM0VTdEVYaHFhczNKT0gzVDlnVDJER1NrZUV0VzBF?=
 =?utf-8?B?aFdDVmZ5TEtCYzlTdHFqNE1sdEx0b3Q4c2xkdmtubEVYa2NCTTFidVducVVZ?=
 =?utf-8?B?L2Y1UXM0TWtpS0t0U1pOOFJ4S0lpUktFSjRvNVhBeHBuRnpwRUY1eXE1VjlW?=
 =?utf-8?B?Nzk2ZXZ5SVNIU3ZnNjZ5VGlad0V0NXFBbWRlNDAvU3JpcnRqdmF1OWEwREtY?=
 =?utf-8?B?bkYvZkJmcDliWkUvUDlsNVhCUWtQZld6K1l1R1ZrYlJuWVY3dmdTbDRreHZQ?=
 =?utf-8?B?eUsxek5LR04xT3l4K1pxYzlTYU1Rd1JmTkNGbVp5eU1OTDd6WFVNakVQQ2pk?=
 =?utf-8?B?ZWt2N2R0RXJYOWJ2Nk5LeEpqUEtoZHhKbVBxRWdXRUk1Q21uYnNOb3NLQjEr?=
 =?utf-8?B?ZWRJUU5HZGcxeTJJdTF5dldjcHpLMzVENUpZUXpoMVp2Q1B5REJQYjNUZk1C?=
 =?utf-8?B?d2VkU2RIQTVaRTcxa0ZlTEFhL3VkQXFJb2FPZVExekUvOUxFSkVLMzdFbkNx?=
 =?utf-8?B?NFgzL0dDcHlHZTlUamYwbGI5Sy9rc245YTJHclZyTjZ4M3JuTmp4SnlmV1Vk?=
 =?utf-8?B?S28yZzZ6NWtxbXl3d1lwRzFWVkxwRlJrYktLQlpsQ2YzZm9FVm5za2QrbkZT?=
 =?utf-8?B?WFliQk54RUZSSHZ5cis3MGJPZkVJekY5QjdNazNBVUQxOTZzcUJ6SWNyVW5Z?=
 =?utf-8?B?NzdLMnRrbjhYY1RxYlJSaFZ0WGJ5NFBBbkZ6ZDRsemdLVGNhRmZiTU5henN3?=
 =?utf-8?B?MkNOVXp5elZWR3M3bWlickJtOHd1M1FjRGNjNXVPOUQ4YTB0WGhVWGhmU3hQ?=
 =?utf-8?B?SXArcEEzUkhEZnhHNitoeU5JMWxEOFlMMFN6SEpFUnRvTzBSa0JMdUdPV1Fm?=
 =?utf-8?B?WWRlbldtRE9wdWEzdVMrbjV5b0d2bmpJcmlZZ2RTUlB5OE1wNGdxdk94a3hV?=
 =?utf-8?Q?s5XIx3y2C160ju1EbOEx+ddma?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdzV0tjcXNORHBIUGNUMW02WVV1bjhSNkxwSVdOb2hLYWZuR1VnaGt1N05m?=
 =?utf-8?B?R0tKN0t0WDV3SDR6Y2xDQTdQUGdScHBSTnVHd1pSZFdCNDZkZXIyWjhlRDh2?=
 =?utf-8?B?RUVFbEJrWDRtajhiNjFlN3Q2eXJmbithWFJGRFJvSTMyM1c3Q1ducEhDQ1Nz?=
 =?utf-8?B?WU1STVBKVm1PMDBLMXU4SHduajBzbVd1b2dmQ3htV0tFSmttbGU3ZmF4Mkly?=
 =?utf-8?B?emR6aHVJbFZOdFgrQmUvRW41eG9WWVRHT0p0Z0NaSXgzdFNCc1d0dWd5RDRw?=
 =?utf-8?B?bzd6YWNPc0U2VEdmSVFJSmw1WjBIZndtTUNUN24yVXFQbXFoaHBWLzZJWFdG?=
 =?utf-8?B?S2lrbXVpZmFFUGg5TTRhVCtJWUpGMVU0ZVBnQm1Vb09HWFhYVmNCUjU1WEtN?=
 =?utf-8?B?cjBRQ3REY0FhdDQ4YTRjZ1VYM1pUY2NvOXEzUmIrRkNIRjloWDlnWXZOMkV1?=
 =?utf-8?B?WVZPV3BDVUdNZFA4ZDdJNkZxdE9CSzYrTWtCV2I3RkhXeE4xTDA1dWIydkpl?=
 =?utf-8?B?SFZVNzZvWEF5UUZCd3JRTVdpL2pJWmJkMnRUOXFiK2J6L29udk1PTWQvMVgr?=
 =?utf-8?B?Ym9ZSDVFbzhGZWZvKzlSYXhRa0dST1o2NHdLRG91NDNWVWJBMWRweVZBcTds?=
 =?utf-8?B?clFKQy9lUDc3dHdNSFpiS0FJUGJ5ODF5SllrY0doYStaWjJoNEV3dk9xbUxu?=
 =?utf-8?B?d0ZBbjYwMnlrWnFqYzM3clkyKzJyRU5NZUVIcHVaa2hEQ3ZVU3IwaGovc281?=
 =?utf-8?B?N2pheC9POExpN21KazBvcmRxcEZjcU4xM1dJeTArUXJkejIyYzJqd3RKRDZG?=
 =?utf-8?B?Qyt2SlcvLzVmcnN5ckZuSFh3eXNKQTJVbWlYQ1hUNzNjWHQvZFhpUnhEd1pL?=
 =?utf-8?B?MGpjNHhhTjRxbEJLOUdxWWFBKzJ0U3VKZU5YUnNaNlc4a3FXL1BjN2RkQXZk?=
 =?utf-8?B?Nmphak1wYTZFOEZzMnFKOWtFQTJMZHNWaStRWE1sUFVhL0RXbVI4d0ZkaWQw?=
 =?utf-8?B?YlU2a2VyblJDaWt0UnhTdXRWbjJ0QkplTU11SVlCUmtKczRJTjEyb1BNbnFQ?=
 =?utf-8?B?amJBcTVqbU5YYWoycVhwcXJQem4xRTZmaHd0M0doN3RZbUx6RXRnUTloanRU?=
 =?utf-8?B?ck5xUDFsOENWWUlQK2sxRDJMWkRiR1lYb05UaDhSOC9kcHhTc005ODNybnFH?=
 =?utf-8?B?bXgreTJHNnRFL3luc3VMTmhkN3FvbVdHZHNzOW5BdVkzZ0dRbFdjZlVsN3lw?=
 =?utf-8?B?bFljQS9EZ1FwSnlDYWlQL1g3RU5uQWQrS2Rkekc4OUNTVXJjb0YxdStYZnFt?=
 =?utf-8?B?ODdwc05pY2JQaUQra0hCa2dpQ0dxZkoydlFWcHlrdUxjQ0VTZkMyY3pyNko0?=
 =?utf-8?B?NGFwTnRQTmErNE5kQTV3bW1tQTBBamMvaXdQNThUOUVEZmN4M3RmZGtWSmdi?=
 =?utf-8?B?cktERWkvUFN4OHBSMnJZY3hPeFdpeC9MYTBwbndJNE5hbFJQckF0Tm1YRm5j?=
 =?utf-8?B?NDNqSlpVYlJUelZWbkh3aEtsdEV5TEtjTGMzUDFpYSsxZXE1NklvU3dPa3N3?=
 =?utf-8?B?NzlxVmJobGM5UStiWmVMZzlFTnhVVE51WmdjdkhaR2NtWlUxTFR4Wi9xUjM5?=
 =?utf-8?B?WHpaT1FLR3BvWEJ6TUZKNVgxdlpnaU9lRGE4THVkNkNkbkxpK0MrMUNRSU53?=
 =?utf-8?B?ODJwTXBDSitqSzBSdUx2K29uY3hETlYxSThNbWxHOEtqdkRUaElDaDRkcWJ6?=
 =?utf-8?B?Tm5Wd29WNS9PYWpvYkdyYkV6djJTMHR6ZjBkemFlYk1SL1dHNHRPaXptcXdT?=
 =?utf-8?B?dmI5T0hEZzd3RE1jd1prM0V2dmowVThNZW1NK0xITzQ5d09nYVpKOTMxQzcw?=
 =?utf-8?B?TlNvNHl5SHRtNXBqaktCTXB5V0I2WkREZCtOYVdLNUhvc0dudTdNL2RjbDhJ?=
 =?utf-8?B?MGpUdjUrK3pwRU9KaTJpeGpjL2NESWJua01HcVRwSFRxaCtQZTl6aFVCUUdJ?=
 =?utf-8?B?aTF2a3pHV2VEN3E4RUhuV1lpTk5mWnJWVm9velF2QWExaVBUNFY5cHBKdk1t?=
 =?utf-8?B?ajY5cUFQMWhhWUVPUVVtUmxmS3RxK0VKaGxPQUF6MGVQM05vby9VcGdtUllq?=
 =?utf-8?B?YnN1eC9XNWVrSlArSHIvOXVXY3BQNXRQNTVoclZmNlovUDdBc2RqUFRrTjFO?=
 =?utf-8?B?OXRFRDZvUllsUUcya2FKRktKbGNHVTJXMTF5M2d6QVY4dU45MDdqYXdNK1FB?=
 =?utf-8?B?dXVkN09ib0EvRjVjM0dmUlV4NEszdmQxSWJ3ZjQ1cExVZzcycTIzang2dUdv?=
 =?utf-8?B?eExzdG9ObGdSYVBDeUFKMkFXc1FaeDhkeEZlUkF2SEFzZlVVZHJlQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3736c045-8a47-477a-0087-08de67acdb33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:28:44.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0lcvwVD++xoFhbTqNb5F5Il7f5ZaQYP1WhAjHD0WdIw/QLY+xgae+W4PBjLoxEw2TOglAmPoXTE1bOpzEDJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A496C10C6EC
X-Rspamd-Action: no action

On 2/8/2026 11:02 AM, Xin Li wrote:

> 
> I’m curious why cr4_init() is not part of the following cpu_init()? IOW,
> why does it need to be called so early in the existing code?
> 

The name cpu_init() is misleading. Most of the pinned features don't get
initialized in cpu_init(). They are set up slightly later:

start_secondary()
  ap_starting()
    identify_secondary_cpu()
      identify_cpu()

The original reason for writing CR4 early on APs probably originates in
commit c7ad5ad297e6 ("x86/mm/64: Initialize CR4.PCIDE early"). Then,
when CR pinning was introduced, it was a global system-wide concept. So,
the pinned bits had to be programmed when the first write to CR4 happened.

> 
>>
>> I _really_ think we need a defined per-cpu point where pinning comes
>> into effect. Marking the CPU online is one idea.
>>
>> Thoughts?
> 

I think this approach could work. It should cover APs as well as hotplug
CPUs that come online later.

> It seems a good fit.  Just that {on,off}line() are not called on BSP (not
> a real problem).
> 

The BSP is marked online in boot_cpu_init()->set_cpu_online(). So, it
should be covered as well.

> Question is that who would work on it ;) ?

I think Dave already posted the patch for it here.
https://lore.kernel.org/lkml/02df7890-83c2-4047-8c88-46fbc6e0a892@intel.com/

I will test that out to confirm that it doesn't mess up some implicit
behavior.


