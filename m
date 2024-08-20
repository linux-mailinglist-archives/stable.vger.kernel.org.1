Return-Path: <stable+bounces-69756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CF958FD6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 23:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF17E1C210F6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899A1C6880;
	Tue, 20 Aug 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B76gM6fb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676345008;
	Tue, 20 Aug 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190157; cv=fail; b=Su58cVwoK3d2mhBgtP4f23S0+KUgLAR7/zFY3PKpeUZQ71fql7UtBnorqyHYgk3zX9q2I1aS90O2QT0ErE0+LHL2FxRH4UOITOpqDbjflnx9vMaVtdpIzrQkqQT4EyEWdL0HoNxwrws1H8WuHoTwf7HgdPEomsyA5hnmqjMiJ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190157; c=relaxed/simple;
	bh=7oZDMVUyaGdCKcL7ClD3wko14UPVIhFnFUsKh+RkUZ4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gbs7vfynmnwRWBkM8yT+JUCMxlKSYeHZ/f4JF8A8PXdos9BxWMr4QfpuAAnp+femF/90r7vwmSZi7gTMhghNp9vm23/q0N+jFdEf9LLqQZqXvIyqreJg1zKbLpXsVeyM2QRljGlkOjerLApdnxbS3bjQx0lL2ZNRhMJnDRI/47I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B76gM6fb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190154; x=1755726154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7oZDMVUyaGdCKcL7ClD3wko14UPVIhFnFUsKh+RkUZ4=;
  b=B76gM6fb4iLk5O4fUU9aBjQZNLcoWoc7/hhY74j8egLKjAq/CobXROis
   6U1Wv4xr+YubwpBVMvgeOVruFxx2MYCbA5kknQZcwbSn/Isk4Hfi0VMTN
   Sn46Z3xyr61AFN5XoEAgA9cqhrzu5dw612wHJKq4+149Z6Jm+5Path5Yn
   V3ERToqv5ujVtGoIufVSBNyct+KqRY6bIpM0dNgmJ9otfB6YnTe/JBC1v
   j7LNgnBYBkKNyIM+bLDc04xwr+Z1pZhPI6ADwJcy9kUnP2kmMLivypBHL
   H/w/NqnfVzBg1X3hKc54vJrdwsQ6eXLcEePGYIAeDjWm2+fQ8Tn58oxdB
   w==;
X-CSE-ConnectionGUID: pyKAViSzSl+FWIjo+pRQ5g==
X-CSE-MsgGUID: igNrpIP/R/2LFXn0xlY/Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33086359"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33086359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:41:42 -0700
X-CSE-ConnectionGUID: As9J5OWITcGkf3QDvu/hQw==
X-CSE-MsgGUID: S4glKlPzR7mY8RZUC8r8DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65561710"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:41:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:41:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:41:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:41:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXbe2VgyILceMkpnoE/MpMhk7xWBgPGuVXf6sQBqE27o+Lwcqj2jYg8t/HHoftMhqI+E5FkHL7tDovb76f1NkDPCH/Pd5m/R+W7iBXrl78EoO0ElOQJqHqyiODpbYrokFKOyzuVg8GPK2NclOPRNVpyxuykhuhm/yIctBJ8CdWMBdk2vUO67ErzjUzVZy8zsDr9tX5iVueiA2WLIh+i+MUDtvC4Fe4YrF/dm/oU+ykCsFaAjocFdyyyHHoChM9c2gnP02Cuhx1e5UM1NlW2oRrYWtGKysuS/duvmNPnP4b81GbsD/LYw93SspgNVwIYnMGbzMndHJ1Y0dcjx8v+Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2Y29ohW9eu7Wfja8/VuEOVmukF6DTKt91u4XFvpFiU=;
 b=bUE49t4nbzwYjiLLD/ki9b0l9nJv4Z1cP5HSW/n3K7zSbowNcVO3CWYVu2NA7aT7dveiSYR8BtECqwgjhkrr2Wz5szOxYWnVRwq/Af+A/95QjwSDdJ85z2hXtW+MkWm5YjOao3jYkczUGIRGYwsvcAthfdSJ5s13x501ilzGCbyyVmR/U+EP88Df1YHxkE3L50hzZbjfYfgjcjSSkThzwCrEbMiweCUbowixZe3G33NalBEtzp+rDhbn5rZ1mBH4kiG80dFBB6vNEOXKXN6xBDWBMFuh/VHOIMCXQOmI1nVp2e4FZF2LJH6mqKoEVoUcuy1Aldt2Ay0Cvrba68iwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:41:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:41:38 +0000
Message-ID: <88140d00-9575-40bb-b600-9bde91f4e854@intel.com>
Date: Tue, 20 Aug 2024 14:41:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxgb4: add forgotten u64 ivlan cast before shift
To: Nikolay Kuratov <kniv@yandex-team.ru>, <linux-kernel@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Kumar Sanghvi <kumaras@chelsio.com>, "Potnuri
 Bharat Teja" <bharat@chelsio.com>, Rahul Lakkireddy
	<rahul.lakkireddy@chelsio.com>, Ganesh Goudar <ganeshgr@chelsio.com>, "David
 S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>
References: <20240819075408.92378-1-kniv@yandex-team.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240819075408.92378-1-kniv@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d1ed3-ad2f-4447-c23e-08dcc160def7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnFvVjY4N3JzdWduL2g0ZjJXUFVFemVucGMzTWYzY0ZISGUzMjdVY0tVT2U3?=
 =?utf-8?B?L001ZExMZDdVaURZcS9JRUwxaml3bnZIdFBQKzRiZFBYN0wxQnd1OTFGRHR6?=
 =?utf-8?B?OUVDekN1V1NyczNEdVdpS09vdlI4ZnJSczFuY2xFV2hYdTA1ZnVOaGt4dmlN?=
 =?utf-8?B?S256VVcweWJ5RjlwZElnMzduV21qSzljMHgyUG1aVkxPZHd2VDY5amVqeC9O?=
 =?utf-8?B?TWVtRjFPY0t0WHp4dnVUT3pFcGFQVDI3TjA3U1FidE95TzdCS0phMFBNaU9U?=
 =?utf-8?B?bVY3V09heExTVnh1WmhTamJvV1dEa0kyWUlMbVVISGl0dFlaeDcrYVB3U1Mz?=
 =?utf-8?B?cnRKNmpiV3h3YlNESGExalFpMmdkbStUbGtKRnBtbDFQR2JhSVZJVXhLMzhL?=
 =?utf-8?B?V0htdWJGTFVyaUpLVW1XejB4SFVyUEk3MG40dGVNRmtObStvTWJBK043dklO?=
 =?utf-8?B?dkZxM0hHam1LYzM0MkJUMXJHYWFYVVp2bjNocGZNZll4NVJaVjF3Qm4rUG0w?=
 =?utf-8?B?M0JSZ0wyRzZMLzMvZUFEZTl2QWs1NVJnU2xwQmpUQyszeVpSSTIxejhhTm55?=
 =?utf-8?B?d2tmK2IxcXlQU3hmeGloMklkVlppNzYyWVM0YVBCNUJwYzh1MUVvMjBYeTcz?=
 =?utf-8?B?NjlqdmFZaURhV3dPSlJac05mR1pTTUlNbmhXaGpvQmhLem9BTlg0alZiVkUv?=
 =?utf-8?B?eTQxZStzb3FwYkJ2NW9hNXYwYUlxWVpnUE1ISGg3SDZMT25vTjBVUU9Eandv?=
 =?utf-8?B?Sjd1SVlzM3YrSFhPQkRITHF2cVBYVUVOYkdnNTU3Ung1dmR3UDhmT0VQQzVG?=
 =?utf-8?B?R0JuNEV4MlVGRkF1WFhNdTA1UC9lZERvVkNkVFNvaVFSSlVLaTZlS0dGUTgx?=
 =?utf-8?B?TnlDTGNOZUV6SVp5eW42NFFYZ1gxRXBTbXF0a2JrRUZYNWFwOHVYaGlCenhk?=
 =?utf-8?B?OTVXL2dzUm5LOU9TTkxKVk9qQWczUzVQTURsYmg5ckhVbXE0TnlUUVc1azNP?=
 =?utf-8?B?UXFCNStVNTRiQ0FCZHBkbUJhMW96RlZVUWlGL0cvTllsdWRFbmZZZDVBbzln?=
 =?utf-8?B?UUUwYmFSaDdVdHZiTUdRK21RTnhndkh4K080NDYxNDFUYU5TeEw1YkxTMjU5?=
 =?utf-8?B?ejVieFBCSmM5c3pOS2oxSVZaNTNFRjZHWituTXpLUU9oMFRlZ3g2akhEaXpG?=
 =?utf-8?B?L3NOK1pHWFQxcTFjOFNLcGV6WHpELzZGZytDN3lrN09CdUhXdFFweWhhT3Zy?=
 =?utf-8?B?OTliL0lKemxmS2tUWTJGM3JITi9IaThwNUZlckk5OGZuTG0xQ3I0bHlQRTZZ?=
 =?utf-8?B?SFg0Ukw5aGNJa0F0OFJPRTVSMjM0RlBmSFUwcHVrdFVrbW45ZzVKMGFWYTZp?=
 =?utf-8?B?ZHNjNFlCUXBnNUNsaEJUVlAyNWhLdTUwS1NKMFVlQlRSR0UyQnVMajNmbEVC?=
 =?utf-8?B?Q3RWNWk1cXF0ZTFKMUJPTm9wRTVnY1Q3RjUvZm5XNzZ4OWxTSld0bW52RFcw?=
 =?utf-8?B?VTAyeGVXVEI0bC9DZXIwVDhuTnVuTUR6bFpGcUl1eGY0b01ERFNva2pnb21O?=
 =?utf-8?B?WkxpeEhUbkNSQzBsWThyTXVDQWRWbk85NWV6M2FpN09jMlIvQlRxdk56bWpB?=
 =?utf-8?B?RTMxYlBMMWg0UjhLd05PRUYyL2Q4SXd1NXdBNldRMXNwQkY3UU5FeXZsOGhu?=
 =?utf-8?B?QlVwWW9VbEtQei9WNXMvT2xEQmp3S0ZEb0NrK2ZiQSt5bWVaODZoSGQyYzll?=
 =?utf-8?B?RDE5dDJBSU5NeWt4YXgrcUtrck5Kb0JTWktLRVpGZFpzQXExV2w2bGZ2U3Uz?=
 =?utf-8?B?eTFKQ3V4QnNham9XVUxVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRjOXZPLzNDZ2crTlN1UGhoVmdXTGdNSFdIRlpnVmZXZGU0bkExaUVEVVo0?=
 =?utf-8?B?VFg3UkZKMGRVcEhFRTNuMjYyUVVyc1k0dXhIejhxcWRCV09xOXVGZlF4cDdN?=
 =?utf-8?B?RSsxaFVrWVdncXhqTjRUMlZUYmNUekNySHdYeEJxa01xSXNPR0RpTmlBYnA3?=
 =?utf-8?B?SCtranNMeUQvWVl5OTNEQTVlbkV6Y0UzemRzTWc1T0ZPRithZ3RoN3crK0ZZ?=
 =?utf-8?B?Um8rclowSytGZk5OQXpucEVJNmFZdVp2c0swdkU2dmQ4Y0hCZTNMOGNUUFVV?=
 =?utf-8?B?NTVuUkRmSjBRSjZybVF3SEYwOWhYZUlwZDlGMXBMQjhMUXY3Y21ZcXJoY0sw?=
 =?utf-8?B?MW9GTE9TdFpVdWRjQk5yeGhmZFFkVDdnTDlZKys0cnlnb1FKeE9DNk96QzF1?=
 =?utf-8?B?ZHFBV3VFdUcwRWxNOFJIeWQ1c3VZMlFNSVNMV0t5bjZPb3pKU25idzF5dW9k?=
 =?utf-8?B?WEg2WHBEb2JwejFES1lIOTd5ZmMzUWFBVjNKeEdZbzhqUXd2dzQ3QTJvSHR2?=
 =?utf-8?B?SGNrajdiZW11T0NqUVlBSU1wbWJvWUk1KzJMb21mU2dOTWVHVGNjeS8wL3NI?=
 =?utf-8?B?VW1BQzJIRXlGNlJxOGNqVWZXdEFmaHk2Q2t6R1h3OHNSYUlVaUFrNk5Ed3FW?=
 =?utf-8?B?M1FMelExU2IrR1VOR3RtVm9TWnZGSS81RlpxK2NZejBSWnpORFdqdUUxZkxV?=
 =?utf-8?B?eElpMzhvcHJCS1BFZVFNWWJHalJRMjZnd0JIRjRLQktObm1Kck52MGt3VVI4?=
 =?utf-8?B?S0pKUUtVcTBVK05LSFVGOTdnUjhSQi96d201RkJDek9mQ3oxakZXbHF3OEl4?=
 =?utf-8?B?aVpVQy9HU0ZldDYyZEttZVdhSG1RZG44VUlxdjNVaWh2SmN6Mmw3bk5hTUJO?=
 =?utf-8?B?eDZwSEdCZ2p2UW9yQWRrYjIvbTJVeXcwVGpMclR3WWV1cEphVkVsdmNQUStq?=
 =?utf-8?B?VTNSTVYveGZWc3NDOFJSWGRDeithaUFjc04zYTU3SmovTkxHMUpEU0RUWHB5?=
 =?utf-8?B?eCtKTVdGQktKZ2hBbDJuR3doUUhRaTlaM3dQcFlHdnV1NktqWElIOURmKzQx?=
 =?utf-8?B?V09NWnFnNTNTc2xUNHBQT0V5K044OTlHME90cUtlTmt2cGZrM3RHN1p4dklO?=
 =?utf-8?B?c1NYaWpXZ2ZCbXFqbXlmMENNZ2dpenYvSDJxZGZPNGxoRE81Q2RVbnRHSDh5?=
 =?utf-8?B?Mk1PR04rUk5pbjhJeTI1TmNpY2JkeWsvNVFtc2RRSzBmSW5SMDJkakpONEY5?=
 =?utf-8?B?S2FXa2RwNzVESG9UK0E3N0pYUkZHQXFqTWxhR2hMdGpVNnljTFdoWTRCaWU0?=
 =?utf-8?B?VmtvcXJWWHNqNEVoSTg1a1l0MklwbEhjZm5XK2oxblBDRktjc1BEaU00VjQx?=
 =?utf-8?B?akx6WTRPVit6Wnc4UXYwaGpRUXhaKzh1NjkvS0Z4elhTeEJzYzBvQ1JmdTVY?=
 =?utf-8?B?UVA5SGNTTGs4cWdZNU9oWURPZEowRmYrU1l1TWQzZHdSMklFVmRJWnNucnc0?=
 =?utf-8?B?T1RPaXJmWDQxdG5zOEVpZG1sKzZ4S1AyZmlXZWQ1Z2tqK3FrdE44NmVETFhO?=
 =?utf-8?B?NE15U20rK0JNaDdIVDNTRlRncTZCaEpvMlBXa1BxakRLKzRwRmlnYWhaSXBq?=
 =?utf-8?B?eFVrVDMyM0tNK21qbXVhK1JHWkhxYmxEU0VOM3d5alJVVDhFMEVwcEZNaThu?=
 =?utf-8?B?Qi85eEN0VVF0MWFwejMveXVjK2NFMHI3K1UyUDNjVUpGRGhQUHhXSjNMemNE?=
 =?utf-8?B?NDRkWEhjTjhWOXVHTlk1a1dFS3F4OG5hSmdBSGEzcTIrV3hvUXRpK0ZwRUZ1?=
 =?utf-8?B?TDJHV3hadHlmMjBJWTR5TkpsdEd1Nm1MVi9ocTV0aDhJZG5IelgxVWR3azJK?=
 =?utf-8?B?amJoZGlHbnYzVjdFZmtEY2RKTElKcHVtK3JKay9DV2dxU2tRSXZtR1loSkcx?=
 =?utf-8?B?UkVyS0VsVGppT3gyQ1dSQ3VkN2xqajBzRVdweXZ6Z3hOcXFtS0Jzay9uNGNP?=
 =?utf-8?B?YTJDOC9SZElzcEQremtqUUlMY0ZrSWVndHFMOEdTb2Q3T2VqVW5VVzdLaVdK?=
 =?utf-8?B?eU9yUW5JdHZYelFRb20vMG45Qi81emZWaGRDRHI3S21hRkxhNDA0NThIWXIr?=
 =?utf-8?B?RWxXNy9nd0xSUVJ2cFd6TE1obTM3SENiVEdqZnF1c2ZDRExnQnlLNU5FNTVK?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d1ed3-ad2f-4447-c23e-08dcc160def7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:41:38.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auaj0CHfLjgnq8M91UJXbvq6LN6uEtgiCFq7NgHUd/QyJJvAiAzoclZWutgifaZ3GvjR+Lw15k+JZtgJE+W7BSaThNIfRxERqJlqFuWPHLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com



On 8/19/2024 12:54 AM, Nikolay Kuratov wrote:
> It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
> There is no reason it should not be done here
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 

Without casting to u64, the value would be smaller and the shift might
not behave as expected?

Slightly annoying that the extra cause causes us to break 80 columns.

I checked and the FT_VLAN_VLD_F doesn't appear to already be a ULL value
either.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Cc: stable@vger.kernel.org
> Fixes: 12b276fbf6e0 ("cxgb4: add support to create hash filters")
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2: Wrap line to 80 characters
> 
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> index 786ceae34488..dd9e68465e69 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> @@ -1244,7 +1244,8 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
>  	 * in the Compressed Filter Tuple.
>  	 */
>  	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
> -		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
> +		ntuple |= (u64)(FT_VLAN_VLD_F |
> +				fs->val.ivlan) << tp->vlan_shift;
>  
>  	if (tp->port_shift >= 0 && fs->mask.iport)
>  		ntuple |= (u64)fs->val.iport << tp->port_shift;

