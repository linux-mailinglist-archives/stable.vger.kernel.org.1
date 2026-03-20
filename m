Return-Path: <stable+bounces-227629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPdwFci9vWnyAwMAu9opvQ
	(envelope-from <stable+bounces-227629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:36:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD042E170B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25F930607B2
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF83E6DF5;
	Fri, 20 Mar 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYj4xdkR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04103DB633;
	Fri, 20 Mar 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042560; cv=fail; b=W5VVdch6xHWbQsAKeEKBJ2ALAfWRzewCkf4D9yVreYGon2nt1FJbZLEvnTuwfzY4DC4IhvLcXXALTMNAol/jZyOcpuUiLDabv77KdZ3cfwFzUZmCO/lmG457uv2fIfcy1Gomd2KeJC30J68HElOW19b9r33hwr6pB4QcZgiBmZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042560; c=relaxed/simple;
	bh=AUkJkQ5T+mPJALjddFGc3i4h385UtRDvOwZ0KEveIws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wctx37qwvnQS1NyjYxoTDiuXHhKvQ2+8Qnz+q2WWbSJSdJ67RSnVPAJ6zuCqmVztF5RhFTPoDNQsb9SQrn2JKOGtH5flUzSe9736RXNiGf2aBO31WoFLlJ0zcFi7oe6f03QC+IFlxTgkMDrtAumopB+2tjOf45r9+v6E0WnJmXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYj4xdkR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774042552; x=1805578552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUkJkQ5T+mPJALjddFGc3i4h385UtRDvOwZ0KEveIws=;
  b=KYj4xdkRlCwEyxvyQ9U4jPe1EsV3kWrsmLEurb8J7d6B9c1gI0D9/tQv
   5GnKvscIr0NOxnc9DhjXt4PCrBznZP0TBGV9DJlecfliBRlaut0oix4bG
   nxJ6g5KfouglBKzukcnqI9n6ItBJUN/jrnzvTBEBE2gBdAMTschF8eJOh
   iI/DTRHPZXW6VziCzfXz3h7ngIAVrpkXB57xVIj/Og7EdLldoMEtlvhfU
   1L9Rrmhggbw4gMiyCNhGokbefcIgRYnUIcTKK5GRJWiA2D4IRR6/CQnuz
   HPErSvOj2oKhW0Gau9IrQzqXDHnfO1gIxSvV+qxvPQCPVU3Z18AYbdlDI
   g==;
X-CSE-ConnectionGUID: qZqYu7B9RZWZyuH3pTix4w==
X-CSE-MsgGUID: u4z8OpE5S1CISl4Q6CxRNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75023062"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="75023062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:35:51 -0700
X-CSE-ConnectionGUID: i46r9TMUTL+3DiIRn4YA+A==
X-CSE-MsgGUID: uiJeIjQWSFupUS/4+DBUNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="219160322"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:35:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 14:35:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 14:35:50 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 14:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiUuM7qEmB+1zFiznqtYt6Ae4cRQBRWpu3ppzwqvEmSFf1qIQNXuT7xzT1nCqFxp0XFbpwS+evFJMSKM4WGrXppQnInTkXdPOfLo3AblwaO66QpqdtYGr0VoFgyhtOAZ48m/0cRS+mGsCyRDdupHnSKNvYuqBgki1krFpXdfF/n6/GyuJ/mqMDBJW0ZDW7lOOjojmhZqHHZJ0nD62b/y38dg2LJLmooXNCnkdF7yP5amNZVUVTHboapQ8H853mAjx3jKPtFjeACQdBv5feeHF6PH3FpDGI4iu7oEq2BD46LILm9luDv4swGrOHURgOUg/LZLP3JU/7AmHDMtw9EMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbBz/RwdGvLm5U5TcHpA33iDWlBZ7CQj6jvZycPYyRE=;
 b=ZlbALQ0QKaZkdDn/+aYp0icca2pj9pLbJMIENOZ1SC9ZwrLC5haxniKPV9f0dB3Qax6vMfMif2W3P9RZeOTlCap51JPOE0NpPnbdN+Zc+180UmCYQ10v2UTnDsxrXJs31mpOTINP00Z+Vbk0yLGYjVQM7ZrCvAh2EPXX4wy1lmxMFfTEvSuEKcw+Epy8pGpJB1jPwtY8e5JyXRrSCK8zhAWJadKyJFc51/BQgK20oUbF2v/IqKCFcM4ezYZfR8dNsFs6H4tKU5OelAUMzo4gAHlZ4XMD7Opi62C0I7XsqmRZpuEP7y1FBxknFvSu2U2yG3TGsqwlkDW2tbMiYFW4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 21:35:47 +0000
Received: from CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee]) by CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 21:35:47 +0000
Message-ID: <0275cffc-7a61-46fb-9d1e-c309ac680b80@intel.com>
Date: Fri, 20 Mar 2026 14:35:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] idpf: fix xdp crash in soft reset error path
To: Simon Horman <horms@kernel.org>
CC: <daniel@iogearbox.net>, <ast@kernel.org>, <willemb@google.com>,
	<stable@vger.kernel.org>, <decot@google.com>, <bpf@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<kuba@kernel.org>, <davem@davemloft.net>, <sdf@fomichev.me>,
	<aleksandr.loktionov@intel.com>, <aleksander.lobakin@intel.com>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>
References: <20260319224159.23885-1-emil.s.tantilov@intel.com>
 <20260320174843.137651-1-horms@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260320174843.137651-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To CH0PR11MB8168.namprd11.prod.outlook.com
 (2603:10b6:610:186::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8168:EE_|CH3PR11MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 53341f03-6705-42f5-850f-08de86c8a5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: igXV5Hh3PGoXGxg8hz2UBoH0nG1Mwhy4njazgjIjlJFBo2MW4xCL2c5bNPOczUzpQyN+F4BsOuv1thbjDfqSXRX1gXCmAgYuvyWWpKkIG8nfBwQe/OR3mim8/mp7bg4FRGohy4cOw7HEUfrCTi3C+Rq3LzHAxlhvmG+mojhc5zouQYx2WmmaDiFMHS3A2fexO92hcfYvGVvbfBa98KCT7ADlHlUKzH2mYJSUMa5BCFsujF9iYPc7fdVdx05mV1jDlYJz7KDO6fQ9UOB0Fhus+INBPnK6ARoKgwNZM7D4YDkA2KyfHdiDmhIneUVg1T3MB6BBfaBWvPfh7VKtyDAVFaR6+TXvxQ+CHDvpCwef5iTsyAEkRi+3uub/Nfg8TdUStqNQ+YK4i4BSkUeyV2ujUNUdzEQmYiAgJU4QBqULhabyjn9ScPC+eiwlHQ4ex47HLqRVUbjMvRGEGzkIlJ1S/Y8ScL0P2I9+rKU09dWblHiBtH+Oxlkw0iob1q/m1TAzS81W50Reo4p80/vYRXrMrNRMxomU90e197FueA4cRW2ORM46CpOhCu0beJJhGpjK0V6/Zq0eGevdbRT1wALRuI3UMR2bd4Kss0ChBpYkD/nSstr8jRVGNgPhBE4kaRwU2p4DZS4K/QYn+RQr0paupLXQd0l9UvbFD0YVTrdSFKuRPASn5bwVT3/jkRwJpfTo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8168.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUowRk5iTUFUcUFxSW5sS0J3ZEFUSWVjWTJqM3RWTFpSSDAvQXd5YmYwR0xQ?=
 =?utf-8?B?MXhyTEFseXpQSFRrZU1malFXS25QNXUwZHdBZTZsV3M4QWhsV2tlYStERzNI?=
 =?utf-8?B?aVhKakFYYkk3SFdxWCtNZ0R5TlN3bHdISm9zU2tCZjBXQ0xLQStwWVhDaktp?=
 =?utf-8?B?Mk9MWUZJNkpMK0R6VVErOU5vM0JJZHlrNlNyZVA5dWYzSC91bjJqSE9KRlRV?=
 =?utf-8?B?YVBqdXlmdUNoWlZFd1FuVmVDSzExWHJEM1NBZXhRdHF4Q3lQQU1acjFUL2sv?=
 =?utf-8?B?dng4VVZESlk2T00xWUpYL2Q4ak1HaDVTMFRZOFA3TWYrdkx5ditzblhld0Rr?=
 =?utf-8?B?ZFhwNDNZaitoaG5RalB5UTNtQTlIU3ZvZHBDRFB3SGNQa3h5aEwyelVyYitE?=
 =?utf-8?B?YTFmakZ3aWVxeHlsSXpBNW45WWNOdzJZRnladjRxeU5qeG9FbVBwYUtMcGF5?=
 =?utf-8?B?M3RsODZzaEQrb09PQkJ4L0k4UmNCa21rTW5CZUNYbmR5TW03ZjllYmxaSDV6?=
 =?utf-8?B?UlZ0UVAyUkFXVWVuZUgyRTBUSnhFTGVKRDljWEhWd1NVb01SVFdaOFhHR0pO?=
 =?utf-8?B?SUFhbFNhVlZVMW4way80N3R0QytSblhIMGhlL05jOWJweWJWOHQxNVlhTFBG?=
 =?utf-8?B?QXVDSEJ4RVF1QWgwaWhrTnFULzhUeTh5MkdMZGc2ajMzNFRCZENXUlFlMVh4?=
 =?utf-8?B?MzQ3dC84SWM2ZTlZdFdJbzNySDBlbzhWcTgzd1ZYcTdFMEtyZHlOZTlWQUk5?=
 =?utf-8?B?WTRiTG1YMkhXbUYyNkI4MDg0WnRvUHhGSk9FWHBwaXF5TlpXeE1vbm9ZL0Vz?=
 =?utf-8?B?U3MwQ0tHQWd0TGVGY1ptYzJMVXBsemhtU2VRZ0JVNHhrN2l3NzRIeEY5ZFVh?=
 =?utf-8?B?Q2xDTjc1U0VCVURDN29VN1BTS2RtaWRxZVFPZ3Z2NVNIL0NyWlFRL2VidEFB?=
 =?utf-8?B?RUU4U1hBbWI5SmpYeHhBMnVwRk8rK25zWklnY0FONkphcCs2dXZmOU05UGgy?=
 =?utf-8?B?aFloaSt3dm56dDlCK3lGc1V1UTdoMFZvTGpJdTdjeTJmSnVRblRzL0lVSmNo?=
 =?utf-8?B?RWdTNVdoWDV3RkdIaHZmdmpoL1BWSnZzUGFrYTB1NTFhYWtYUGtab1ptT09O?=
 =?utf-8?B?YmtVTkt5OWlVZVNERzg4dWdBdzN3K2M4bE50NzJ2WTRSZ1M2M1Fuand4MHhY?=
 =?utf-8?B?Q0R6cXlOY2F4aDlUaTh2NHdhYmhaNDlBTGliNitiYjVXa2EyODRMbGo4OXdx?=
 =?utf-8?B?ZG91SkZTVVFWNExYcThKNk1NNHJyN2dzNVFmM1ZkOFN3Snczam44U3VlWlR0?=
 =?utf-8?B?cm1sRVVSS2c2RnFTL3RDV1pnSUxxY0xCWG03RUE3bnFXS1R6Y09OL0tGOW9W?=
 =?utf-8?B?c2JqbEhrZ2Zhek1UcG1uSTFvaWVzNEJCTG5xOXEwWUhFbVlaUDM0ZUQ0aXRP?=
 =?utf-8?B?Vi9ud2Y3WHhvQ2pLbVdpTFNGNllSZUs3eXRIc3JjZWo3dXV4d1hDYytNcUxh?=
 =?utf-8?B?TERka3FRSzBwdllzNTJRVk9yUWxZbVpWUzVGaktYNDVQVTFIdGxuMHRyd2tH?=
 =?utf-8?B?RWlxb1p5WXdDZTE2Y2o3UklQWCs1eHg0UlU0djdhaEVmN0xQZzB6SDJka2pF?=
 =?utf-8?B?M0tEUUZVL3ZRUmZ0L3VsOUlpcFFXZnlPQXl3ek5odW1mbm5zV1kwd3p5b3Ba?=
 =?utf-8?B?TG5rRmlTc2REd3VlVEpPTzdmcGE4dFlHeWJTOS9pdXcrV3p2U2pWMFltb2V0?=
 =?utf-8?B?UUE1cjhZYU9jaTJGdmM5UnkrbStVblpnZitWbE5STXJSbXN5ekNlaXh1blFY?=
 =?utf-8?B?UWthSWpCdEZlK2F3ZDc0VHc4bVFKYUgrTDNpU3pXaXNhMUhKaUZOalRQRngr?=
 =?utf-8?B?L2pyRWFidExHTzZ5cExOdTYyaEV1V2VGZWpxYmFnbTFGV1hGaUVnUlhrTXhG?=
 =?utf-8?B?SFpVMjAwdUdnT3YxclR1MGdJZVZiQTEzUGRGclEwbjRnQU9hcUdCRVEvcTFT?=
 =?utf-8?B?Yk5UNmQwUlJBRVgrb2ttR1JBTGVqOUE4czFwb3RIUlgzc1ZxZW9UdTlQeUVt?=
 =?utf-8?B?NzhBTkFtNi9yd3N1ZnZ4Mnl0djMzaTIzSnN5eTkwNDlmYjd0VjBwNXBYckVT?=
 =?utf-8?B?NHdGNTNXd29GSzI3SG12bFRwUUFiRy8wejlUaVFLZFkvV3lGeTluSnV3a0ZR?=
 =?utf-8?B?WmdaZXIwTlY5bjE4SEIzaVhaVE1ISFhjak9WNDd5bGxodmlURHpOcXoxUkN3?=
 =?utf-8?B?ck1NdERNbkZ6MkU4eFFQemg5MWpGQXdnTHhWUStZS2gwZzYrL0FCdEVCTDhq?=
 =?utf-8?B?eC9WZkF6cncwZlcwdC9CK3gxSDEvV0F3aE1aY05ST1pWY2dKeU9HVC9VVTNW?=
 =?utf-8?Q?0nlZDqgKriMmso5Q=3D?=
X-Exchange-RoutingPolicyChecked: waSZTGBK364Y7w5ZNmhI/uyJzDpIfcvS6s2PgE2G/Oog4n+GhATjgnUUqVWQIly8yLRBBBAuB3fAbI13f/e9OH9atHWOvpHtT1LwROqpG3WgIGPsOVFwq8NyDI+GbaP3SNSLKH41mYZA7Rssq2tUNcnSKRLPwFXhjl8uqpfJylCj0/R5QGoNGOVAJs54QN+GB/U6bHEVAVB72i6hz7SAAt9H8tM77Ms6PV/QOs6DGsoKY7wqggCVJn/wrtL8xHD7Nn+I7XwO6JNBg87ZWyTqkl/Opu9B+K/OhGerqg0N2QG0LYH3Ny8zRvxWg72vNnNNrr7Aohctd92ITSUOOK6s+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53341f03-6705-42f5-850f-08de86c8a5fe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8168.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:35:47.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miDNgbzvMM1I/3J4mFYPCpBKBXHlWVceUctJCBwpBGnwz2mF6yDrfjhcPR5oKgjPu9dACev/bEKUTd1lstVdI5ker+SkxnH+Pneam0uC58M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227629-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,google.com,vger.kernel.org,intel.com,lists.osuosl.org,redhat.com,lunn.ch,davemloft.net,fomichev.me,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AFD042E170B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 10:48 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> idpf: fix xdp crash in soft reset error path
> 
> This commit fixes a NULL pointer dereference that occurs when
> idpf_vport_open() fails during soft reset. The fix restores
> vport->xdp_prog in the error path and updates the restart check in
> idpf_xsk_pool_setup() to use IDPF_VPORT_UP instead of netif_running().
> 
>> Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")
> 
> The Fixes: tag may not be targeting the correct commit. The primary bug
> being fixed is the NULL pointer dereference crash in idpf_xdp_setup_prog()
> that occurs when soft reset fails and vport->xdp_prog is not restored.

This is not exactly true, this is just one of the instances that would
cause idpf_qp_switch() to be called. [1]

> 
> Looking at the git history, this missing restoration was introduced in
> commit 705457e7211f ("idpf: implement XDP_SETUP_PROG in ndo_bpf for
> splitq"), where idpf_xdp_setup_prog() was first implemented. While commit
> 3d57b2c00f09 introduced the secondary issue with the netif_running()
> check, the main crash fix addresses code from commit 705457e7211f.
> 
> Should the Fixes: tag point to commit 705457e7211f instead?

The reason I chose commit 3d57b2c00f09 is because it is the commit
introducing the function where the crash is occurring:
[ 3179.284770] RIP: 0010:idpf_find_rxq_vec+0x17/0x30 [idpf]
...
[ 3179.291937] Call Trace:
[ 3179.292392]  <TASK>
[ 3179.292843]  idpf_qp_switch+0x25/0x820 [idpf]

The setting of the restart variable is where the above commits "meet",
in that both conditions - netif_ruinning() and idpf_xdp_enabled() [1]
can be wrong:
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tree/drivers/net/ethernet/intel/idpf/xsk.c#n571

which would end up calling idpf_qp_switch() instead of taking the
alternate path:
	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
	if (!restart)
		goto pool;

Which was introduced by 3d57b2c00f09.

Thanks,
Emil


