Return-Path: <stable+bounces-244451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDfDD6Wr+2myewMAu9opvQ
	(envelope-from <stable+bounces-244451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1F4E0748
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9205530193B5
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FDE3B0AE5;
	Wed,  6 May 2026 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEAUMh09"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81F3090C5;
	Wed,  6 May 2026 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101154; cv=fail; b=Ihh19xNGxzUDimdoI7uy+oupFYUXq54N7Abnv9EmAasudbF+DsclEolYMI7R5KpY+HTbYgAEfyPJTHGfMmT0MNxQBff4Dxw8k1Q6n7jk3FsrNIm7pGPFqdOHb6JyHBVWkGqmUrOW4z09KvPvxNm0QD+L5IzX6stz0GItVo6rmHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101154; c=relaxed/simple;
	bh=gzxPmTb+EW2XeNzhFRYQw1A4ygRE6t/WVBYZ53YWt2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c23U42NBnvo8oIL2uEucXdhsiMYwaXHaxOWGA6r9ctBvWjLqy7hgJeTrJv74ElZcABHo3scphuimZ1jayWNCLW7SAbsUqHcgWUxWJN1rLLH4zhGT1ZDcueRK2M1iogBppUd5SezgR1X9HKzlmBoNMDaIrjFQ31r+TS0NybnHhHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEAUMh09; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778101153; x=1809637153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gzxPmTb+EW2XeNzhFRYQw1A4ygRE6t/WVBYZ53YWt2s=;
  b=CEAUMh09c4aEwxLtP7zV1NHMFbNW5EFWZo5DyU0E9OGmyTl7N/hSvotF
   FE+dzGO1Ez1PD6Mm+V9RBTpRH3a2PEINc59VxUmi0bUmlUXnMcedOYQ0J
   Qc2AW8Fiy3D7GEaZl3f7K7Ye3NrGG6EEmZ0fN5gE3vp//lM3GQ2+kNLEq
   3TCRGPAHWa7vNtseypC+dytaSUU4NjHFG9aFgKr7g3qRajQJN7pPcv3PS
   KdOCaPhfbH6Fg38uzr2KixF3MzWUIGbzY40YdyxHRvmCvykFqVky2FwZ1
   m/299L34muCuEWi/3l0gRnvRLaTHAjsBavxH/EYcdiPxFt7PsGHI3HY5z
   A==;
X-CSE-ConnectionGUID: xrg7eJaGQviRjS7e7yvwLg==
X-CSE-MsgGUID: Q130z3gKQTm1x+sqsWgL3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="104505202"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="104505202"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:59:12 -0700
X-CSE-ConnectionGUID: G+RHZC/9TcKfpym0PB6ooQ==
X-CSE-MsgGUID: TSDfeY9mRyalq9N75yMW6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="235400730"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:59:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:59:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 13:59:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmhg5cMcE61/xiUq/sM5czRXqjw2BPRTVEv3benT9jQA3fHa1F6Kt5dP2o4mJZIFQd71xAc5+UOFFsaEK78HGIORe/LcnE4VKw7uCxy3TRux9rltqPoQyLQYtqbV0RswNwZnF+8JPXjobK1mqQQDhtCR1eILlXkf876a1seDcg4aJYtjBlVepJw37BAXeXq2i6bJJ3wm3PnXlO7sMSxtjAJOqkbGYso4wTuPg9Yhcsakfzjuv0BdHWpSZtTUKmVbK84pVNbqsniSeTaSpK1wTrfjNGNkFTYIh0DkXkMeamjA3ehYXcT5emSojdVndYNTxHIQRWlukd9B8aitTsqyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+Tsyz3pikgdBQz/feg06eHNQDrDr7+HgiL9LGIiHHE=;
 b=N93GhWEUvMwtVsYbgBQJiMpjYzf7g75b4vnxvOthyG9DOiuvCiBIFKsoGjjl6Wu3lJqa/fHEP1HcCwBiHuE1NRD+hccTslx+Rp97okw6C0xvEJ1UL5rcaiARkog37O8QICeQaZyU7Em5ESOu/VoXl9n6wAwdmi6ftDctXzAeXsADrgU4DoeBKXKXtCGM2uJgkJmPI5Kichx1n17OuOnU3s63gKYx3vrH38czpbLmn4DC/SwXqqpoHh+ECkN03+uVzb510KeHjHe1iUBMafID5z4zMNiBPbY4+Iac6mtuE7Hzrw/Q6BV87FIwgC9Wn0OhpOpCMsJwAa2eqweys/XFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 20:59:08 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:59:07 +0000
Message-ID: <2ed08e7b-fcb1-4e4b-a142-2a9168210c55@intel.com>
Date: Wed, 6 May 2026 13:59:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/13] idpf: do not enable XDP if queue based
 scheduling is not supported
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
	Willem de Bruijn <willemb@google.com>, Dave Ertman
	<david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Patryk Holda
	<patryk.holda@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-5-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-5-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c18070-3f2d-4572-e4d8-08deabb25063
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: hydgKca4spvgieri23/n99PEZ5Ixnqz1V/Eu8APbXV0x2FK526PMvT61RuEKF5aBQPsXXpozevPn6+kM+jmTYTDsWwdT4jnL4swZbiMhZJz8HPWmR393Sm1TnmLLN9BI3AwmoKfqyc+xGBY45rWQThdMHOLiC8+4TZH2/KcEWNWg/7DTDqbB7/i2T2vjz9QHSd+5+HIvbXyPx7/5/xuoe2NEZRqNzoQtBEbMGJnq5IR/MNXskQvvmZY5JKptX9VK91vasj68RggBf4YcLbl49vhUisJuU9mDmtJiSBRl+3bT+Mma/ZZPYzznA8IngVrwfqt9DOn07ohofUa8F75cAucPJ9N4zcmzmAdRrMJHurouhsO2+5ErmJ5IBXDPYw360Ixu0xIyI9d+VQF59Rasyqp8wWB9v5LFIdlKoTpGJ09Gjuew/ZLvSkvCfo9APvxt+AiFBVAJpl4/h7f21ZcGqDk6VaYQpz6rQeLpxSaBfcspaJ0dyOZgzIqW6Renv+EyyLMgvYwjXBpA2NL8ZUFbZrSMFgPZgkN26m/xiRLEgYY7jKMSe/hGxmc9lRH/udOsXiUqyk4pdWKX8RwqsNb3fv4q76Y5bz+2IQmDGg3uX2Q7Rrc5EaDOYOtpblaMkidnFfptchvT/23MRwY6oKqrBShBYzN0uyQUvGK9SZLNj/IKWWp1xy/6B40Vdo8wOo6rKhsS8kEffLHuvfWSKy0p1e+W6nTJ0wWHjzE9OJJ7t38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhDTGQ3SkUyY2Rua3E4ZDdnaE5YZTNIbmlKUk11WFU0QzFWa1hQWmlYcEpv?=
 =?utf-8?B?TVc1Wi9hSEt3empJSWozMkFzbE05aFZremFIaW1Ld2svcXh1b1V0TFkwa1dD?=
 =?utf-8?B?c040TGVidTlQM2UyaXFTM0g0YzVkYWxsV2ZPVEtZNGFMby9tVzRsL3pUUWtI?=
 =?utf-8?B?OVZLRUl2Z0tKN25lOGdaa1c3M2thZUdOM0h6UjNUNyt0NWlKeGRCYVg2ZXhR?=
 =?utf-8?B?RHA2eG0xTUZVamZnb3UxY2l4dHJlSVpnS1BmYWJjTDNUOUdNK3pPMGRUUzRV?=
 =?utf-8?B?c1VjZWlTd0o3UWgxbVJDTURkaFIwMFhpMW9GOVlBYy9WSE1vSFF2RWtTelRW?=
 =?utf-8?B?ZHBId2FPcXZVcEV3dUVuRGVZSG1iRnp4bWdVWUpoZFViWWhYMnNNb1B0ai83?=
 =?utf-8?B?RVFZQy9IcElIZWJVdVJXajEvZVRTWmdobEY5amMrNHR1SVZvZmJ6a2wweHZt?=
 =?utf-8?B?cllwaXJRelVTdHRqUGUvTWZsQ2k2MC9qU1JpcU9QQU55djBBZ002bUI0b09I?=
 =?utf-8?B?RXRkU2NqdUlPOHVrZnpjcGMxUmg5Ykt3bTRrS2xvYVRZREh4bjh0Nk5SaFJS?=
 =?utf-8?B?MHphblg2cnJodHBtMjNPL3dJMUhWWlVhTEhtSk1yWjBuaGgrd0JmWmdpNkRW?=
 =?utf-8?B?cmkwRzdlM2VvVGhrMGMweWNsZVZGY2EvNWFLQzh1WHhnWm52enpBa245NjVi?=
 =?utf-8?B?czkva2NNckZQKzAyc2tLeWYvR3RiMjcwN1pDVkNCUVZlUFAvWVczaGpSTTc5?=
 =?utf-8?B?ZEhiUUhjcVJRVlVhc0dSbkJWZUpoOE5kK3BRRlRJMDBWVysrYzJid0UrQXJ2?=
 =?utf-8?B?RmxHUG1LRExEWHg0ZzhTUjF0Wk5RcGJSdDJ1azM4SEh2RFhDU3ZkRDVtRVla?=
 =?utf-8?B?TWhwbXVjNmVvV2ZTV05pcHd1RlU5cG1HZGpmYVpnSEI0ZDNCZHZCcC9XaTJE?=
 =?utf-8?B?a2orQVVKSlJuZjlhd0o1NG10MGh1VEtwd1F2dUtFNTNrTk03Q09xZFVENDVJ?=
 =?utf-8?B?Mm52SzA0eXBrUmZwSlBCMHVvYVNTY0M1aHgxM3B3a2g3U2V2cS9JT09FNDU4?=
 =?utf-8?B?Sy9jenRzVkppeVg3TXBkZjUxZ0NtZjB6Y0dCakxsdTRncEFWY2tWc2pvV0lm?=
 =?utf-8?B?aFJwaWF1UHhmZTlsVkhBL2RvQitXN0dlVXhuSGtoREl2dHBoTklDRUJ0TFFG?=
 =?utf-8?B?Wjg5dm5vVitVRDhSV2lqYmtWSHNIVHBjdkZlZ1ZKVUVlTXRYL2pDaVZLdGww?=
 =?utf-8?B?bkNNdlJRdkRQMnI1aXNMRllCbVVFWEV3Ui96MGhwYnJOOEUzQ1pnSWd4YVh1?=
 =?utf-8?B?Vzh2VnBrNlBoNHYycW9OTFlhMk1aYk5ncU5BaGdsaEd0c3k4ZHZWVHEwNzcx?=
 =?utf-8?B?S3Y5N21oZWhWSDM5SER3RXFnMk1Ed1BiWjJkS0I3YkNBUDZjSHdBN2g0RGlV?=
 =?utf-8?B?OGVYNnJNdG1JbnBkL1lERi9INkhrZENlUzFUQjY0M3crL2xtbDNVNGVENFlp?=
 =?utf-8?B?OHRORXpiU0w5RjlsQkdGZXhTNGxNenNoektPVVBLUlBSYktoUjJQY3hTNGY1?=
 =?utf-8?B?SVg1MXFyRUNBZWhjN0FsSWxtUjZOZ0EvTWQ2VE8yT1V0emMrcG9NSXE1SXZE?=
 =?utf-8?B?eWNIbDY3cmtRVi9wM0NaZjd2c0VqV0U4N3duZEMyRVpUVjVXQ0xJZFhOaGFh?=
 =?utf-8?B?Zkw1UC9FUWxmRC91bDAwMGRzM2lybVhQbERKY3FBOFJRN3o1OU5LQkxzeEtj?=
 =?utf-8?B?UWFPRDM0TmV0VTY2NHVTaisvYUR1K0ppc1lKZFJFN1ZyNWo3VWRTMkJ3Q2hM?=
 =?utf-8?B?dlJmMEQ1Njl1LzIyMVk3SENkQWFKeFVoWWJUVWhCVGxoRFdEQW01THVXTmd5?=
 =?utf-8?B?SGt1cU9BMjU5NVFLak93L1paTFlwMXVqQUlGWmFaaElhSy8vSnJaUWloSWVF?=
 =?utf-8?B?ZklURnJGTDFMMTBsTkxrS2EvRnoyTWxEZ1JWdlVJNkR4NDJnZHp2eUJvcDVn?=
 =?utf-8?B?OHd4S2tPM1ByNU5RaEVVK2JwSEJYVm9DYW9kak9USkcvcnpGalR3YVlpc01x?=
 =?utf-8?B?OGxMbnIzTUtOcUhFRjFWbm5jd3ZCU21ZZkZPSndGREgxVkdLYVd6Z1JEMnpq?=
 =?utf-8?B?bXFjTXF2RWk5UGZFZ1M4REJoaGN4WlZDeDFSWmIySGJtbGFyNk5TbEtldmd6?=
 =?utf-8?B?ZW5vU3VGYTFrdVEwYmZjODNSdUcyTnJJNFZMdmwwTERxdThacVlpNDBiV3VK?=
 =?utf-8?B?ZVBha1FJdDV4VUVOanJoSkcwTTZQcjM5Y2NnSmE3cGFVT0pPYkd2MFptOThw?=
 =?utf-8?B?VStncmZsVGpieWgvOEJZSzdqUzJ3OGxLdkxLMUFrREt6N2x2Q0tFekZJNi9G?=
 =?utf-8?Q?GNL3eJi72oykKx30=3D?=
X-Exchange-RoutingPolicyChecked: qrPmoQS61GcJHg7HZqZj24oGkIVoZKDnS+BgN3ZJSCzurVv1zEFfuUzMw2cQEOfnT8CRX+tXbp0LLbhu+qdWO65bWGJhV9yOwe7AnPzT+5qsvIfnfdj3z7SLJvh1wKtOdKCyGO4IMRuPSGMPQK+h9JRwXvQ8cHScYzuvNs2sE/ARWQva49wSb5N9oIjiJHqImpdwU+Pm9UinDENJa3utvq7ah/A5Vdj2L0DFPGx3NJXEbEfYr/M4bgmCJupjjRZ+jAZ12YFODwUBQZR1ce3WjhI5kxtNQ68SHROj2vN70DdW/QZJmEkyv4LJ8IRZmTpJ2iqO8cMMUTXXnpiyk2GWXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c18070-3f2d-4572-e4d8-08deabb25063
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:59:07.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW5hC19LNk3j+JgD86bBBYyNDBS8K5WO+xzQu0wTpL0qDnjBAcLL7GYG+Xc9QdNTuT3DkEdCtx/ENtigTTth8GRq3BHPtLEmAonEvr7Gvj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B3B1F4E0748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-244451-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> The current XDP implementation uses queue based scheduling for its TxQs.
> If the FW does not advertise support for queue based scheduling, do not
> enable XDP. Add the missing capability check at the start of the XDP
> configuration. This will temporarily break XDP while a flow based
> implementation is worked on, as well as while FWs with queue based by
> default are rolled out.
> 
> Fixes: 705457e7211f ("idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Tested-by: Patryk Holda <patryk.holda@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index cbccd4546768..dcd867517a5f 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -510,6 +510,13 @@ int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  	if (!idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model))
>  		goto notsupp;
>  
> +	if (!idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
> +			     VIRTCHNL2_CAP_SPLITQ_QSCHED)) {
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "Device does not support requested XDP Tx scheduling mode");
> +		goto notsupp;
> +	}
> +

Sashiko points out that this is only valid for XDP_SETUP_PROG:

> Could accessing xdp->extack here cause an uninitialized memory dereference?
> idpf_xdp() handles multiple commands like XDP_SETUP_PROG and
> XDP_SETUP_XSK_POOL. In struct netdev_bpf, extack is part of a union and
> is only valid when xdp->command is XDP_SETUP_PROG.
> Since this capability check happens before the switch (xdp->command) block,
> if the command is XDP_SETUP_XSK_POOL, xdp->extack overlaps with the xsk
> sub-struct and might contain uninitialized stack data.
> If that memory is non-NULL, NL_SET_ERR_MSG_MOD could write the error message
> pointer to an arbitrary memory address.
> Should this capability check be moved inside the XDP_SETUP_PROG case,
> or should the command type be verified before accessing xdp->extack?

I checked and the netdev_bpf structure indeed only has extack for the
XDP_SETUP_PROG case.

Because extack is only valid for that command, you can't use extack here.

I don't know if this check either belongs inside idpf_xdp_setup_prog()
or if you should just call NL_SET_ERR_MSG_MOD if it is an XDP_SETUP_PROG.

Josh, could you figure out which solution is better and prepare an
updated version.

>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		ret = idpf_xdp_setup_prog(vport, xdp);
> 


