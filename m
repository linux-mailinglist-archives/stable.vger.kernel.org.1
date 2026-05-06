Return-Path: <stable+bounces-244452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAfbFues+2lkfAMAu9opvQ
	(envelope-from <stable+bounces-244452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:04:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16154E0774
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA2B30151DF
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C83B19AC;
	Wed,  6 May 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grJS4e7v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54E31715C;
	Wed,  6 May 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101473; cv=fail; b=nLqJ2KJOnH5gv18L2TOhzdsz2nt+tyb6FT/Jx+wx2WNZjRIMhxTMYpnzLiwxXXTYH7AOp3wvWYiW5+TGvnBPHQxG3NDCFFQ4IUQBe5CmQcq5zH3nZ0k1sw9qTjzt2CVuNfOFkh8kuaG38Gf6brI2/ZNB7dnsvWrm9YWY4Xyj9Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101473; c=relaxed/simple;
	bh=s9Nr5Ok0Z5d5BiE7Nr98ie11gFo7GScxHtVe+gq3Xvs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bi/jmcB0voQ9w5TyWm045vsL9YvYWZQWzT/5yvwMiv4IGptEvRUlbzfz87pyLZLDOV7Rv9nIWHXbJdMBecBBos+ByocjXPKV5OuDZxzy2irORbRFA6JpmQM82n7hgskPF/Te498/wU995IZVOSKk51ItS0xK9K8nzBdhDfBPa54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grJS4e7v; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778101472; x=1809637472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s9Nr5Ok0Z5d5BiE7Nr98ie11gFo7GScxHtVe+gq3Xvs=;
  b=grJS4e7vf62M3Z+NdOW7lKLa+OqbXlV2aqIERLMQFNYmOE8C2ZrpqQVI
   65DNca9wEfqYvnRJwVzeR5S1QyuL2xpOSpB4UNK0v7w6NNjGiw8RzjfX8
   aqGKUVIbXZOkcX4qw9cwSojCwMDptol+6Xc0Q1M/6Ti9RUZx23Q0SpJ2b
   VugJQUwq7KCcWGEO0E3ovgV04fq/eEUnQNfRkbFtCdr1VWM95ItJm3PP3
   L7GD1AiIuRH7GRqYhZQez1LYWE6T023JzMwtpDB01Q5buCUeNPnD6KOQb
   vFL8AQFfoIAeyF9YgoKvSNgcF7raBtz6uh/I8GBNh62idUvZZ8j+w079V
   Q==;
X-CSE-ConnectionGUID: WeGrHOSyRtCt5u0VWMY/YA==
X-CSE-MsgGUID: AiMUxln7QxiyWsJKqFEQTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79092749"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79092749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:04:31 -0700
X-CSE-ConnectionGUID: sg9v3I2JQpuC6jzAPuz6qg==
X-CSE-MsgGUID: 61lqjoHJQJ2G3W/xc7gaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="241252213"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:04:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:04:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 14:04:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvHdwFryPCovgMWqFODjJswi6Tq7Br8IZpGpeDaAGgYjqM/7FZS6mHigShxNtMld932QJXNwr+ge6Lh79dtbKWm0GtOJUFxfoPulq3TI4Sd9k0gz8+epZOguYx4liNS27V01TKmrq9PPQzGxIzllS6EHVQ+I+7/84ybG5PbBir105DqM9AWcmKwdLsrwqUs7JU0wwONVIO6DgESNxCi6wqoC6R42TufTKRDjxxCMzW7n5RDMPa+9O2Xn2z9hxh9AKQajakmQoSJ9kr3t0oh0NLY2hVJMwnbPmvhsQ7Yk+tofmPLhMzqcuuePGvo6PAR2o5nW7x5NNukSTf1VrDQIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK8xPaSsQokNwnfhMjIu/NZrPWJPFcJlZPyRex5wUaA=;
 b=EdFDflUCwO0kEQFLF7CS3Ip80TIIzfN4j6Eho8i2JxAD/QkVy1Vk9Wp1L0iw/17rqj56nqa7k+X7ruOD7zsEBb5zI6bqJhEGh9nVjImk8K+7AYuWvoHs90uTrkjfmJ+ejfT7+PlQ5TBlUEASva0xna5+edZQ3jBgKt1yhgfqI5GDMFE9aLLaJXTLhhduSUv3lNzlYLchfPeyhBQiDK4d02cFkXQOwlWkdB16SbRIb9EkmUG1dEDUwbrBlvkhkTK1jaTt4L821oL/QmYINeKmOFombudn05xo//BAgJR1N7zJ87m5Xi4bpOGvcyCW7BRZ8F9NYHipHYhK10ggQZ6byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 21:04:27 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:04:27 +0000
Message-ID: <b21512ea-756f-43db-96af-23f4c45b72a7@intel.com>
Date: Wed, 6 May 2026 14:04:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/13] idpf: fix double free and use-after-free in aux
 device error paths
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
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<stable@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-8-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-8-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 21406196-f260-48c9-27a0-08deabb30eef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: inmIpMo9seeAwroBb9OOfZ+5NLY95Z3FJXBt5cZPWZdmhzrTl7YOvZ+ezrfCpJAjMtNuTP6kGlyU2qY5jmzxIjmN/hUw4s2Gd412cQQK9GrMbnU1VMJwY9GZDkcRuU13wAi49/BdNpnHZuZGdSbyim1waxQb8QUV5mAfP+rOYMOB7KAVxxGSusfIlLWbZsj1loOv+Lh+OvcEgmOXyyZp52b5Rhp3Z7A5913YICIi+CzkZNjWriEVfiZ+NS0QVUpqfLis5Rm6FnbQ1+ruP4ewSrIxtiuVc/wK1kVlNgqAU1pE0wAfcolPonIQ+z7BX3EcuiecwJbfVANlYM8JY2b6YzgRYeYXxxSp4CkEWXUycZwfyGZRgN99hmodVdaxiHAuXzPI98mHIi9T+d7RHmYRoKipe4A4c4WTJ4J5rS+xzRjdXzEykqdK+5gd+5layELDgD+t8bTmyVMtt0Oq3X4Oiq6ayT2MEZWJ4gd2AvMz8P5L4ssBKhtwCi3IYMBTZd1H7HXsmrdjdPgbPxcHgUjs3rk3B9615JACf1J94AShzr07TZLALhmvmC7ZeZMtvAPbpYPphi9QAFX7y8CeQswUHD1oEvj0TBcJoDrP9gw30QhQJS3KJDEpDJe02M7BkzLvX/5qoMZsLWX5dE9PgXa8wSrjzREwXGIo/kJrJmv3ylazlMHYD80nqfXMWx8Q34KpaPhxGa3l/s7TKgydM81nzQECgZ7WIRqj1115Co7BttM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzNvRlFtclVPOU5EeTdwNVBsUGpFaXJnM242alR3N2RHcDNtMHhJVzRqM1pW?=
 =?utf-8?B?MTlLQnVDSEVjR2RjSmE0YmJ1d0RIWVJsUStrVDZzWnRnT015QTFkUmUwUjlk?=
 =?utf-8?B?TC9hUFR4MnpEU0IxOXFsMFR5a2Y5eGI4S2l6NHBaMVp3VHhLbytzZGc2NUFa?=
 =?utf-8?B?YUpUWDF3NXhSN2Fsci9VeHIrVnN3UUYvb3pvNEFRMVVDSVZkQlJDT1Z5N3NL?=
 =?utf-8?B?MW94N0ZUUUVTbkF4dm12aC9HWUYrejRRVm9pc2Q1OUVJMm0xS0tFbXMxSEcv?=
 =?utf-8?B?S25QdDRDQkRrUHcwd0xhU1h0aG90cGVSakRWYk5heHlUTDRQSUtZTGRvZjUz?=
 =?utf-8?B?RnpxMUd0TlRXbU0rSEhHOGJDSEN4RFJ1aXBxYWhkaFJVVHgwVVQzWkkxRnd6?=
 =?utf-8?B?cUFDQ3lRTHFTWnV3MEswTDgyaDZEdENsekN3MTZrWXpPbHhxL0hreVJ6dEMv?=
 =?utf-8?B?Nmg3MXloM1c5USsyY3IxbXJhVm13VEJpM1dqL0hha1lwWlhUV0FMeHY4ZWIv?=
 =?utf-8?B?NnAxNnNhN0E0QXNiaTFKMFRReG80MDNwQU9uSW9GbWRGVm1xN3R1WloxOGkv?=
 =?utf-8?B?OFN4RFVxT3c0UXJMNFBtRUovYzVJNkpVMG4rZ01tMjRkeWxkbExyK1U0cTBq?=
 =?utf-8?B?VEtBY0FxejF3YUZ3OFI1SktiZEZlM2lwbE8yRU9jM1gvbmY4Uk5uWk8zYjVs?=
 =?utf-8?B?blhxMWQrWUN6M1Jzazl5eDRhUXFEdFU3YXZqdnAwaGVjRTRPRHpKc3BnTnlC?=
 =?utf-8?B?THQrNVFueUlrT0x4VG16U2tJMkNwUnQ5RXhsdkYxbVg1WlJXbHJsNGtaWXBW?=
 =?utf-8?B?YkQ4RjlHdFlIcEtMamRRQVY2d2RqYTBCdUh0Vyt6V20yQ2NVNVNwYTc5dDl4?=
 =?utf-8?B?UUdnMTV2dW5RQVV6bGEvT3JCNXRUandkSXFLSnlHcWJUMUVhSXZnbUxFdi9L?=
 =?utf-8?B?RExtdWdqTzNiemJLQmh0UWJlZkxhSFZhRE43WGhtbnlCSlBVZG5LaEoyWTJK?=
 =?utf-8?B?RHM2WTIrZ2s2RjhjSEgzdjJFWGl2STNvSHBCek1BQjBnMitQUUZlWVNwZnJx?=
 =?utf-8?B?ditCTUpPMFpjd3B4S2QrRis5TWVJUlhDbGFBZ0JPYjlwSGdiWDV4c1NuQTIw?=
 =?utf-8?B?d3NRcVpGMWFnYy9RS1BlQ08waDBNQ2R5NnVxQ1VkcjVGZmlKNitRMlR6VVhO?=
 =?utf-8?B?OGRkcEJQVW5oMTJJZVMzdGxHVmxCWGFXMDBNUnA5NWR4dkpGQ2g2SHo4aUUr?=
 =?utf-8?B?LzNGZHJlZGJ3N003a3hNWDEzZGZ5QnBKcEcrTmdHRnU5T0VYMzNVdVFtbytI?=
 =?utf-8?B?akJ5RzFKUmk0T1Q3eGc2UUJGeW0zaHc4RVVqdjZCNVp1cEs0a0F4d0FRZlNL?=
 =?utf-8?B?Q1p2bmd5TnF6N1FROURaNVJGUkhISGRGbXQ5cFhCNlZkL0dlL1NvM1htRitW?=
 =?utf-8?B?S05KL0h1Z2lPZzNBanNFdjlXZ1l0aUZTOHlRSFRING54bkV5Qm9PaVUyZVRK?=
 =?utf-8?B?WmR2SDBkWVo3c2huUUFQMTZleDlnTUw0Y0x6MGFKRDUyOWFuQTNPNndOSjVK?=
 =?utf-8?B?WTFLdlpWS0NxR3dNZmNZNWtTVnNPOUNHWk83aWtLVFpJZGF0OE1USzBjTThI?=
 =?utf-8?B?ZGUvWFNKMXVEZGh5dnhERWdmandmVWt3UklaQzRLMXJtS2F2cE5XVnpFTDBn?=
 =?utf-8?B?V3E4SkpXeGg3UzVndW1rbUZSTllFZFZ0NzJob3FaVFhwOE4xU1BqS09abE83?=
 =?utf-8?B?MGRoR0V4VjltN2xFdkhsWndWM1RVYXo4TFJJVUtpN2J3N3ExRXI3Z2V5NEdP?=
 =?utf-8?B?ZEpaK3Azc3VhY08wMHE2ZTdncVpBV25MRklzbzJnUlcxbWsyb2FFSGE2UVpi?=
 =?utf-8?B?MEU3MmgzU00yYncxK2NTS0pTL0h6ZmdCRnU4RWVCN091aXZxWU9iRmg5cEtm?=
 =?utf-8?B?REpLbjBpSlhsdWlhQXdVOWNCeFdpK1BQZzU5Snd0czI2MmUvbGVIbVkrUW1V?=
 =?utf-8?B?QlQ0VFVsejY4Q2pwUzdkV044OHdOQUdxQ1RtSkxhZC9VcVVIZjA2Tk9kWGpC?=
 =?utf-8?B?cnFYQUQ1WERmNzZaK3o2a21OemxuSVAwY1VLeUlrWk1tS1F6K2xTUk8rVGNB?=
 =?utf-8?B?dWdEOFdJZ2dyTFE2ZWMzSHh0UHFQQW9NNEc4emc1QWVsOWhKblZOVXd2S2dL?=
 =?utf-8?B?cVBpclg1bU80OHdIMVY5enFNanZGRWZkdUlUczVadXVpSnIvVWpOM2NiYmRr?=
 =?utf-8?B?UzN1Uk0vb3VSSjZFdGpONlBlQ20zbHBUaUpXbSt3dm5NUlRtVHYwZ0FxOFJ6?=
 =?utf-8?B?NkUzTnl1bTNkVEE3a3M5QWNLY2syM0NwR2ZETElWV2RLcis3VEQ0MzBObnZv?=
 =?utf-8?Q?AWw6k2H0ScpueOLs=3D?=
X-Exchange-RoutingPolicyChecked: GMwXlUrVjYCKq5v5f/nRoBOa+T6w84lr7bIFAMhKndp8+gPGtx5fFNDwvv0EurTUifx5nDZr6BEuziS4z9EFCf/xLTkL0BSmqUpEdlfuSxbNpgp5VWT2xNQ1UrNrSwiZzOQn3SDKiSg3nY3fZEqpNw6eXUnx4pHS1m9weMUv3WfRCwVQtz7z90fMNPGgMRH0Ts99hcRWkd+uCaojhQk7SLAFizVCfcpDOLyhc6xEnRmyhI/qgkEpiTV2RkPQ0wKj6mbatlztCN2tRnN/mEzGtLaYwplMFNMpBhH+IJHc8berjO+DlBUDifgQt3WEWFResrciNYFbuelUTMVM0+JlHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21406196-f260-48c9-27a0-08deabb30eef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:04:27.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO4na4QaNJe+pqN6zDSafpclfZ3YJSQ3+2IwxRTlai6XGdPA/OYQOx7d7YgcwmXKci738wvurPq+4x+LIn5YR32+5NAV8XA9etq568IXyBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A16154E0774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-244452-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> uninit call will trigger put_device(), which invokes the release
> callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> iadev.  The fall-through then reads adev->id from the freed iadev for
> ida_free() and double-frees iadev with kfree().
> 
> Free the IDA slot and clear the back-pointer before uninit, while adev
> is still valid, then return immediately.
> 
> Commit 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev deinitialization")
> fixed the same use-after-free in the matching unplug path in this file but
> missed both probe error paths.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable@kernel.org
> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 7e4f4ac92653..b7d6b08fc89e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
>  	return 0;
>  

Sashiko points out some possible flaws in the idpf_plug_vport_aux_dev
function that are unrelated to this change:

> This isn't an issue introduced by this patch, but does earlier code prematurely
> publish vdev_info->adev before initialization is complete?
> vdev_info->adev is set near the beginning of idpf_plug_vport_aux_dev():
> 	adev = &iadev->adev;
> 	vdev_info->adev = &iadev->adev;
> 	iadev->vdev_info = vdev_info;
> 	...
> 	ret = auxiliary_device_init(adev);
> If a concurrent MTU event triggers idpf_idc_vdev_mtu_event(), it will read
> the pointer locklessly:
> void idpf_idc_vdev_mtu_event(...)
> {
> 	...
> 	device_lock(&vdev_info->adev->dev);
> 	adev = vdev_info->adev;
> 	if (!adev || !adev->dev.driver)
> 		goto unlock;
> If device_initialize() hasn't executed yet, the device's mutex is uninitialized
> and attempting to lock it could result in a panic.
> Furthermore, if auxiliary_device_add() fails and the error path sets the
> pointer to NULL and frees the device, could a concurrent reader that fetched
> the pointer just before it was cleared suffer a use-after-free when attempting
> to lock the freed device?
> Should the assignment to vdev_info->adev be deferred until after the device has
> been successfully initialized and added?
> Also, in idpf_idc_vdev_mtu_event(), is it possible for vdev_info->adev to be
> NULL when device_lock() is called?
> 	device_lock(&vdev_info->adev->dev);
> 	adev = vdev_info->adev;
> 	if (!adev || !adev->dev.driver)
> 		goto unlock;
> If vdev_info->adev is NULL, evaluating &vdev_info->adev->dev evaluates to
> NULL, which is then passed to mutex_lock() inside device_lock(). The subsequent
> check for (!adev) indicates this NULL state is anticipated. Should the
> NULL check happen before attempting to acquire the lock?

I do not believe these should block this fix, and we'll need to have
someone from the idpf team review this code and determine if this is
valid and find a fix for it.

Thanks,
Jake

