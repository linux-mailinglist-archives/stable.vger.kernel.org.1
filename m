Return-Path: <stable+bounces-233501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMlQHpam1GmkwAcAu9opvQ
	(envelope-from <stable+bounces-233501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:39:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42E3AA5CF
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09B0F3030743
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389E389E06;
	Tue,  7 Apr 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GabG//eD"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D83890ED;
	Tue,  7 Apr 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543936; cv=fail; b=IuYfbI3z21cs2fc8t8tJdkjPMhjuuHLaxWHAfyZiSIt17t5uwAgj3CzAuclJ1vsNcHycGs5Bi79/1lgT8Ax/S2eDv/kEUrNY8mnnygd7u6Q1yqWpQ+hXSEWHqW0+JMu29SYydSPxKLHoTn/u/Btqu3z8Udf1ZE4NGYVOHqmTWoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543936; c=relaxed/simple;
	bh=3mmTtd8f1ukQHERYqhQqpH3sUnzWGNdURYfES/fPQro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmqoEwpzCfcOHaxo+SZdt/d4lBHEh7bXBw9FMJEgTUKowUDhlPUjlPsppoJ1LWHT2KQJsclnMkKW6VWRmso+Xfe+9hwLkC3G/3RpVpRHPtD8oNVrpPabF5VmHsm3W2tPCWwzSAwq0ZOhFkod3QiubTE8rddxRc6N0ktTICYzOAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GabG//eD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775543934; x=1807079934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mmTtd8f1ukQHERYqhQqpH3sUnzWGNdURYfES/fPQro=;
  b=GabG//eDcRW//hUylhA/Qir/w6Ep/VQCgvUfV4/913hyaM5Znw9dPpMt
   eY4b5MNzRXH2zX3DJY0x+k3x6ALXWp5Rht6Oivw5Nc+dKsnxNnSruxaWY
   C+w5Cb5iVnDnkZJLpY1UbKNTLiV0L7mrXr0lj4cutJNZUnC21URMMnZ27
   IPfe1Z0h9f9GEDaSP6ek0bCutM3twBO2Baj6nMn12SwPdPR7mQb0sZL6G
   RZNyC/9L3K4H/PaCv1FwkLlkiGv8TkP69PuQbQERsXkatDMFU1zDuG9hl
   zADBLKDe8VJ0CaubqNDaGb6Uh8ayCXR6PznVNx0Sc9jvG13R87hWZHbUv
   A==;
X-CSE-ConnectionGUID: OU+20J++Qzy0FmdV07S69A==
X-CSE-MsgGUID: Qat8zOQiTmaBaBLpF46VPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="93889183"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="93889183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:38:52 -0700
X-CSE-ConnectionGUID: AbUxNaqDQUSS+I+VJiqxLQ==
X-CSE-MsgGUID: yqU+pP2JSJ6B8/mOmTadrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228024633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:38:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 23:38:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 23:38:50 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 23:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpem8vFvNPvRGqr97mAmsC5e3o0iVTsggSrBcUuU11sb0NkLnYVtPFoo9wOguEHC2yNrVre8Quvhq56YgerDbnitnS+u4Lsl9pW9QRHfVWOVpTSrgvNLuAnRbHsXHq8Cr36N56e2SijU3lOTnfJDDZjri2EtpL0G3FMTlqIng9Xd3/8e0lWq3kk0XI3iD7LOPo0OAZNoN0Lm2yFVnEztCfI8d49lnvzADWWAd3WyCxGs1uwTG6Je0quoiuIBapJjYiR4woT5z3DWXoBgNYu1SWEolyefJrDdTJDXClTHS715siyV9L/4BmeopXNAIITiIXfPirsLjnvdmC6DIfMWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHmwubEImROMkLmeFVfko/Ft7WxDmaU8VoG8u0YBRJY=;
 b=FD0rkNFM1cZMGYwBIlfT3IHj53kI8r9gLtvMN1bwtBTBdWZdKHTxNiDU+wr1YynQ6tgAUB/xf2WCtVpiB+kLSbXLLX9ENiqPPZ240Rkj9WrnvAXcHXh/FU1Gf0nGN3oyHriRVG21fqwzP1VXtJtc6aQW333qKeLh7l1/vW6b3z2kf6gcf45aoWazLIxFagpsShUbITkmwHkQttEPO7OD5OwrWCYjc7ZIcvUw+8YbqlDopf8vsQJQj92itqrxZ/YHr1m5JgrzwjL/6plgQQocx/jbTXIAg4jeMMfgTUuz2auG9+BhqLVYh2aWEGW+OLurGv93BMhxKk6T6S77loZ1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:38:47 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.015; Tue, 7 Apr 2026
 06:38:47 +0000
Message-ID: <da3b1b9c-fb92-4408-bb5a-485c050f7c60@intel.com>
Date: Tue, 7 Apr 2026 09:38:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL
 configuration
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<Stable@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1775014742-233407-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1775014742-233407-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW6PR11MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 930d81aa-731a-4587-2ec8-08de9470524f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bt+4EphiEzObjj2xvSyOHL0CKKF+a2GhBpSwypZRBm9+vU/YNn9GoPL7nKFvza2nuk0jMF+fFPkUdjegyIM/PXf03f92mA23tO0/UOwyQaz3AYxnwoKj9RE2tXavJPkT1Tk1oHtdZogcL4rD2Bv1Y7neg7XGxj3ISoN1fT4Tyne3u2PqKBUKtxPdw4pT9BBuFyOSCtQ8rLDKJalI64dWAGb0s/FleQDAFw2WCIVwF6GhN9HnNHAihtYTGjgUINOULIh4uti+FQnAfK5OeCvaPKMLMGm//iZ10gDkNQI0ZB8TreatUtkEBJcmtOr1JzpUEPH6r1KtEudnE5Grj0x8K6k9HaOI9y3hF+dtVjsQyPMS5lKWcONZi9kMN9wZc++6DopKjn1Aelw3Bhss3WqJrAPlANhrRIISfVrOxq6YnVAL/MVL8z/4QF8X9GvaEHj2inMx0agw0mEU0jMbLKVdc08nM7MmgmlEd8lPN66z8THnbKLEeAtktZq2WaUh4myBN5YRsJD3n1a6LgXB4NSxtEOlTbAP8mruNj/dX5RdWgaeXA7FVapBbPSMxA3VTecf068O69KYEA8/l6X4IByESOwkLHFKqG7AnVjpq3qpVLiwX01JX3BDTqfzKgJ6iLkAptc8hnXdlV18X3MDsJmrG2jpic7yIZ1rdHnrQYN2AbfKUu5za0mUnd3NXFJc4UZimiU2pSGSwkZRZLVjRKGftSoCTls1hj97Lp/s5XTAAo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndGbTVodzBoSU9PQm0vbGx3OVpKTno4WldiYThQL0o4TXVXVkxIcUpzSHhH?=
 =?utf-8?B?RFpaWUIvZ1VzOVRKWUVVQnIyUU4va2JvMDMzSDdxbVVsMVlBeXVZZEg5L2xB?=
 =?utf-8?B?bVR0SE5SR2pVZ2VDd1J2b1hCZ1VUVjJNV0lzNEZ1YnB0eFM3bThIRHU4cndm?=
 =?utf-8?B?OHUvUUNvTFZGSnAyMFNrRmdyS2NhR3dBaHJaajNxOW0vK0g5WVhsTGZpSG50?=
 =?utf-8?B?NDFueXQ2T0tUbDR5cnpmTCs4N2pEZGU3UDBmV0g4ekZ1S21BRXhlRFRJRmhW?=
 =?utf-8?B?ZDRFVmJwY2pleEpTWkpYbk5jczBNRkdqUEMvZk40NGFhanNldUd1Ymo4NWY3?=
 =?utf-8?B?bElvOUlqM3RvSGJLTmY2cTBnM1dTYmoxcTR2bGRlQ0wzYXFhTVBnS0tBQUQr?=
 =?utf-8?B?YlJrQ2dGbHUraE9UVlNtZmdPUzJSSzhiNDhnWWpjdUVhMGp5NWsvM0J5Q3Q1?=
 =?utf-8?B?bjdQTkwvbkowalZrM2s1dlliZDNNNmQ4WkJFTG1aQVdPNTJteXZzZnJGTDdZ?=
 =?utf-8?B?QTBmM0cxYzIrYzdvazA1Wi9DWGR2WEZUN0QySFBpWlhSUkxzMHNrRjR1MEFu?=
 =?utf-8?B?NER4dEp1c1pkcU9SV0licFpHUDQzcGphRmNuSGZiNGN6NVlCY2ZtNW5KQk9K?=
 =?utf-8?B?ekVBazNrcVg3RVFUbUI5L3BYRHFGWnZkZUt3S2Q3WVZVNUd0UFplZUF6MWto?=
 =?utf-8?B?Rk5ibDZaZ25qSS9paUFkM1p2ckhmNCtVN05OT3Z3d1lmVGRqNndJMGFwalBw?=
 =?utf-8?B?U0RiWTE5bytpa1pwT2grT3V2RjczQmoyWjFTTUFUZVJpSldQQjZaU05mSFYz?=
 =?utf-8?B?YkdScEFqZjdjQ0JTMVRjT0d3cUxIb2txZWFiY3ZhQXdQdE9zVjBoc2tVTEhG?=
 =?utf-8?B?eFl5ZEwwSEhWSFgwYVpkVFhEaDZTUzl1bVorSks5dUpvNUFXdzRYbkx2Uzh6?=
 =?utf-8?B?WHRJbGRSWGVNZmFJeXFVQ3B6NElvV2g1NmFNRmtnb3p6TFRWeHJyUkpQZnpq?=
 =?utf-8?B?aENoU2JIaXpzM0J1OTJJYzFEKzJBM3Q3MDZSL3h2UmpFMHJQWThlbXZpTnU4?=
 =?utf-8?B?d0VrTzJOTDQwYTE0Mmg4aGpza0xiZCt1QlloYjRSYzFTd2J3ak1GTzYwYkNi?=
 =?utf-8?B?R1JvemE0bWMrcFRrTlhaMm5aNVBPTCtjaHlKUDQ5ZnZjQzVuaWhQaFovZ3pY?=
 =?utf-8?B?OFM3c2dNTG41U0QySmFxUlBzTmFMZUpQMEQyWGhuM2ZZeURJdUVlQ0F6OTBi?=
 =?utf-8?B?cFc4V3pPa1dEUWhiZm5QOXBaT1hZMEFFM3NOWEFBeWJyQzhqR1hUeXB4ZDhp?=
 =?utf-8?B?WDZ2cEZjWGZOTFdkWHVLOVJnNjhOeVpyYkt4UTBXMyt4cHlMU3czQkFPN2Z4?=
 =?utf-8?B?Rjh3UFNkZEMrcytPdXdKc1FvQlRneXBVMHdKVmE5VlVmdW9ONDgzdzVQZDFh?=
 =?utf-8?B?YmZMYnJyRjhJRFdUWGdOTW5RWXRYZU1mbi9qd0lERVJ4K2ppTHlaQTdWZ1JD?=
 =?utf-8?B?a2JtbDdYc3VoWjRVUWxMK2p2VGFNVVFaTFF1K0hpYUVOQXYxeEJFL25KNE44?=
 =?utf-8?B?R2pCMVNWcmM0TUVXd1d2U0FJQlpUTGRNL2xvbFE3YnpLZDhXdXkvWEhQN1E1?=
 =?utf-8?B?K0hKdm9TbUltQzRKNUw0bEFtMGFGbnUvZUVOSjZTbEFvRE94dVljWnYxeWhT?=
 =?utf-8?B?S2NhYVFmRUVHcE1GQWFhVUlBT2thcC9kNU5KTDFkbDYwSFdNMEtsMUVKbDNu?=
 =?utf-8?B?TVFGalVQMm1UVFlYRWNNcVh0NWtKN1dKazRxTXcxZTNJZVF2MUQyNmFtVkFU?=
 =?utf-8?B?THc5OGtUalgwdGt6NlJ4K0hhc1NPbHovTnRHd0Rvc3krU3RaNXZiMjNTNitX?=
 =?utf-8?B?NmY4UnpIR25Oemp3RzNpUlNMZkFnRnFOMlM4ZGRZT1F1TUhvUnFLU1hJeU5l?=
 =?utf-8?B?TTBnRnpHSE5PZ1MxNXdxL1EwR0dPVktIZ3laa09xK0RIYUFuV0ZaTm1rTkRP?=
 =?utf-8?B?QzlzUWNET1pTNkY2K1p1b0FHS1BTUVJVN2hYb0VkdlVkbSt3ckk2ZDZvd1Fo?=
 =?utf-8?B?Q1JpbkhLN2tMSTlKZDk2cndtS3k4TkRrTmxzSGJSYkFNNnJiTWNhTHd5eEN6?=
 =?utf-8?B?TUVRY2ZOdTRvV1FwcC8xZlV4aGxHRjZWaFF2R3hyTTZickZ2Rmp0V3JGYUwv?=
 =?utf-8?B?WEFsVUlUWWt3bzNJRENPS3JqS1ZBcWxET29aTC9XbThleUFvNGJHNStCZnJK?=
 =?utf-8?B?UXVrRmlyMzhOZzV5RXYwemhKMnNFME9PclZHMWJYanRkaG52eGE0WTZPZmJM?=
 =?utf-8?B?TnlEUHBHQ0VHKzBxRGJLbXROdmc2Nzl3YWw2bjRrR1Ficm9rbEJIT0tCb085?=
 =?utf-8?Q?sZPABPmDmZYZqLP4=3D?=
X-Exchange-RoutingPolicyChecked: BRQJL1Upn+dw49n7ixXdcUIUkDM9LcfTEmnJ8imN2T/K9RMYw6MuS44VLAWtL7PRowCZRmXG/65Jd0CXPPZFN8iPLOWICA9W/jMPtZHcsqbgSe0gox88KxdReEnmFcAZjZuq/4cIQGetDY27hN2Eb/IMp0s8sTF2tUEHfAT18fTaSQAHMUiF8HIjL+GX7cG0achIBWCNQldIO6HGyNW/o3xKhgDf81DnLFdPCjDvtoH0Ld57BYdHYWr/QwRGzxqP++PJuWzdA/b9dJCXcn8WyB0uCKOIHexMbykW54Xo0rkbntFqBUI+44v/yjt/R0WxIpxyEm6cJHJ0L9+9+nBmbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 930d81aa-731a-4587-2ec8-08de9470524f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:38:47.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+xBkapESYvAnpA56Xt6904NIdyjHu6Z2ekntd1zvHNa4i8YPgEimz4DVc2j5luGiuOWFnapNCRoUXo/CLcg/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233501-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rock-chips.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DF42E3AA5CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/04/2026 06:39, Shawn Lin wrote:
> According to the ASIC design recommendations, the clock must be
> disabled before operating the DLL to prevent glitches that could
> affect the internal digital logic. In extreme cases, failing to
> do so may cause the controller to malfunction completely.
> 
> Adds a step to disable the clock before DLL configuration and
> re-enables it at the end.
> 
> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> This is bascially a code sync with the downstream vendor kernel which was been
> done this way and tested for some years to confirm it could fix the issues in
> all corner cases.
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 6139516..e3ae334 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	extra |= BIT(4);
>  	sdhci_writel(host, extra, reg);
>  
> +	/* Disable clock while config DLL */
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
>  	if (clock <= 52000000) {
>  		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>  		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>  			dev_err(mmc_dev(host->mmc),
>  				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
> -			return;
> +			goto enable_clk;
>  		}
>  
>  		/*
> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  			DLL_STRBIN_DELAY_NUM_SEL |
>  			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>  		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> -		return;
> +		goto enable_clk;
>  	}
>  
>  	/* Reset DLL */
> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  				 500 * USEC_PER_MSEC);
>  	if (err) {
>  		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> -		return;
> +		goto enable_clk;
>  	}
>  
>  	extra = 0x1 << 16 | /* tune clock stop en */
> @@ -868,6 +871,9 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  		DLL_STRBIN_TAPNUM_DEFAULT |
>  		DLL_STRBIN_TAPNUM_FROM_SW;
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +enable_clk:
> +	sdhci_enable_clk(host, 0);

Should this be 0?  If so, needs some explanation.

>  }
>  
>  static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)


