Return-Path: <stable+bounces-244453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCj0G2it+2lkfAMAu9opvQ
	(envelope-from <stable+bounces-244453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:06:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199AA4E079A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C88C301E593
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842383B2FEA;
	Wed,  6 May 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwXM+9gN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18A3B2FE7;
	Wed,  6 May 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101586; cv=fail; b=k2B3WJUKxVNhyP+j8/L70MmE5eKUJL5E+dk2D6g3zjBzMWJlgRX2oTG6WEeJif4oN7ckz58axF4atw2nfu9PceBqeSIdNrH/h0WXXaByGWslyx5s4N6OJDnk9aSeYorwLg9/JGTpk8/j5nnOsd5Tv7NFK0TMOHr7tD/lAx4njyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101586; c=relaxed/simple;
	bh=CM9ynAhOQE08UoYtoYlwM3JaDKbWuJpPVjuJQx+IMtM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FhlwWyozYFAqMO0L9eHBxaay2Kzg1+gAbmwzhIohjYJwW14pE6cDBrzLU6mLyJcc2Er/L/4ZcDCKfiJdIQH9TRsmN0jOyvKhEdGl7S6tacjKCH++mzg873KsiF9d6K1oOvNS0eS7uItia1TaRtW8sPGjnLG8o5SWUshspDfKuDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwXM+9gN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778101585; x=1809637585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CM9ynAhOQE08UoYtoYlwM3JaDKbWuJpPVjuJQx+IMtM=;
  b=OwXM+9gNdwVHlDc83Kw1LiFoJYt2BYRLSz7nNXGQ0GaJ9hPhHru+QomG
   82yQrZxnhOBiXc1x06/CBGSGD0S2zKaojCt+BN/f8jH/wEZvgES/zfeeB
   LzpzFuM2qTaXUUWZ6NDYQvdPwIc9algIfQb0FSR0MT8P9c8tamYYctgz8
   FNQ4RNTKoLshsGYUO8KOtMxOLVAAXoABEgSWeDEZgc/w0WYHQoFIOLVTN
   hznKmOT+C1w438Q3A8m2+dwecXwSggGWKfNKz4BxfsXe9nKubTYQa0QP0
   IPJUX5lJg/H/4Yy31yiocLW35RRM9QrHpRCGrCdZocxCz64CA204tyHgj
   g==;
X-CSE-ConnectionGUID: l0KIt3A2R2q8lIe00qZuGQ==
X-CSE-MsgGUID: IrSraXhNSta1JYjMoi3gkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79152423"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79152423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:06:24 -0700
X-CSE-ConnectionGUID: OaxXWGvKSImbVxjdGPbvUg==
X-CSE-MsgGUID: PIVR23e2Sa2Bp8vFMkIM4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231728178"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:06:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:06:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 14:06:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHX6Ruhsvqxp/7EKu0uIFSqrBIqgZjA9b0J5KRsUUiJPX6pPNpbVRINpkCIJEFuPFb6wPrd/y08U7InjJuBzr0pzO7CYly+md9UdxOHWCpS1SWpWvaeYaEMRhvBE1Eq85+QVJUSBTNd4ixhQFPRtdhiYD0sU3qcVyj7sTE2NLwzyd7Nh/3M82nr5K4vsb3DipGyP+Ah3wqZmahRF1yJL0pJ+k7Jg5yHrHIIFL137FjnidXKPwaFutRMbse/+Tuzr0YoaN6UrkHMSePoEcb6GCI9s5l+ij3EkQaS6nCPb6xAqeSKBYhlgKveWuw3JVuueFp69Qq7htCD6IvPsD4OqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds1fhixe4o8nYnR0AqWIUklVdhgxdQKgJOmeUhVWolU=;
 b=ng+jHkNlI+G0jNCcbabIMyweLzYGZ63iGHqhUCkbRC8JLYslUS00b17yWwALME/LIXmzp8BcezAgAyW08z7k9qJSkbFDjxSHS65joM19MXi1itR0Ktp/mL7s0BFpZXaYdofJ8C/X2+MTbkA6DPApsKfkklFaQ6bmbKerQzWQG4sTuB6Dv3CtSMzjBN4ZRe6GhUm3lf8giD9EUVYzrpNcxftphgXeE4H0AC7afpadB6QOqJZV/I5n9WPiPrFPRVd1HpOPR4Q6CqnPo/9se9JbS2NLxrtoS3TPC0zI2oATqGfkYi4pdgY+D67ECD3qKj13lwbf9duQgMIAimQgTQg3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 21:06:20 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:06:20 +0000
Message-ID: <068a5266-4721-4496-b027-3b32da3e02ea@intel.com>
Date: Wed, 6 May 2026 14:06:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/13] ice: fix setting RSS VSI hash for E830
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Willem de Bruijn <willemb@google.com>,
	Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-9-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-9-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ad09b5-5ee4-4cb9-c334-08deabb35237
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|921020|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: +Y1Aj7hAThZV1MehPuMMDADmCxu/9j+kHXoRzH/2y2oBofeuTft7LiUT8UP6BWA9sHcRvVGKHdJznJ6IJGjR8PBQ54ZCxdcdJwI0BclJJfrcOEtslXmvhvhrIZ7n3SLQ06st4fH6zuLaAG4o3KeZJrdQ1638chmN6nqPAL3oSL+WBQDt1z/olarSjnylYwaAeZ1P5OrlY4XAQvp+QuBLLNc+nlm1YcW2e+Z0xLgOeruAhJ9bcFAN6DZYlpg24gUNtI5qhzrQ93uIs7XmVePzOyeA6YALaBWURWbD7HnEN40oQs/XoWw41giI5dgTNhjKKZStEUEaF7o/vmZJNZzLo9Bh/YLffAALy8J895mUKaTiGzbED/CnuJwHHETzyYTlqLBZV+o9rQ5izs3Qu8WhRl9NQigoJ7GyjGBnBcQFTsCQ1/iAbxr2KNnJyiOTlDLa5pvOYE7Xw+n0+pawQ8jCA1IB56z7OXzQlpbcmf+RyDf1hyDQ+0XjZIjreAQhMRRKYBMMk7dxCMhraPWUlC/G2y+qF6ysRSSkvQ++i7MwQNW/DVtOgaGIrajmpB1fvGVBtNEujRs/79VgoMHj1MfnUcIpwEvYgChTKlUoEgVUUjy2OKGYommy6IkYa1+jHGcIUFJz0xWTTWiEuxGaOPmIHcmygsqg/3HJvnx5uCu61zljxZAUcuF9IBwFTlEKA+EbIzuEXoVmB0zSoUJJtdcvYX5qzPxgEtL33wSlIRkG7gE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlKTkFvRTVONHRKUjI3MVJ2MGEyU0p2ZDdSd2FWT0lkdFhBVExRQU9UZHEv?=
 =?utf-8?B?d3BXYW4rUnkyTlZSeFdaSml0STFwN3pPb1hzMXFlck5GTXNyMEJpamlCL0pG?=
 =?utf-8?B?blhnN2NQanQ4VWZKK1RyZDQ3cERrbS9sVi9qZ2h2OVdURkR0TVduMzArTHVp?=
 =?utf-8?B?UGtZcnRQM0xlUFFrV1pRZlk5QnZlaC80SVFCVk9CNDZZbmZNZUhZNFRlSVRD?=
 =?utf-8?B?ZlJBMlQrcFJpRFNDMWR2Z0t4YWNOTXc1bWliTHlVSTZ3Rlc2d09JRGEvTHRz?=
 =?utf-8?B?M3VMZE5ZUjhzS3M4YmFOcE9UaFkwNW9FRzRMSVYwV3ZEQVg5ajJ2czF2ZC9y?=
 =?utf-8?B?eWpSVXNodXVJc1JyQWZqbTNtSmlhT2tJTTdxOFg4S1lKKzdtWnRLZ2ViTjVy?=
 =?utf-8?B?ZDNKMDZocUJseldRbDVwVFJDSlo4Z3d0Z0ljRUVUT1V0dnEwRTRxcStBeTcz?=
 =?utf-8?B?bmpXOE5oQjlJQ2xub2p3SmpwMTU3VE5RYmJhVm8zZXZHVk84TC9nSUdEYlcw?=
 =?utf-8?B?T08zNHVWSVZ1TFNZcEV0dkwzUlhCVlQvTXpMQ3Q0UTY4Q2d3dFF0b04xVmxm?=
 =?utf-8?B?L0UyK0kxbGFZUmFDeC9KWDMrdmNlWmg5NCtOVGN1bThpalhqUXhtUUpGZEFn?=
 =?utf-8?B?cm1wcHBLdit6SmVXMTdCdGlsVU9ENWYrVk5kVjdIUTlOOXBxWDdBSGVFOTlw?=
 =?utf-8?B?c2lWcFdhOGQvU3lDR0loRDZTQ1kwTWJyV1F3VFd4Q3hDWEZwUFdnaEwxVDZ2?=
 =?utf-8?B?TitGK2UrWExnakwyV1E1VEQ3ZFdZT1hRUjJBNSs0YVpqY1FXblFlSGhMUHEv?=
 =?utf-8?B?U2duVEJkeG1qcUJRdlN1R3VKN2dhaVFKeEVXU3plaG5EaVJ2TDFqQ2dtWU45?=
 =?utf-8?B?QnozVDZhRm9ucmI1VlY2RTJHYjJ2QXdIYk51bkM2c2YwNDA5Y3RQU0J5a0o2?=
 =?utf-8?B?ZDI5TzlMdHE2bHg3K2lYL0N5RFlWL0MzVTZlK0x3WXhtU2FrNklRbjgwQVhu?=
 =?utf-8?B?NXIrQUxhdFVlc3hRNUE4RkRDOFdtSzdkY0pyMnM5bEhwZW1RTDY0TnA3MklZ?=
 =?utf-8?B?cTNaNENzK2tudkxydmwwQU1yU1R5TGV4ODhGQStzNS8vVWVaNkVUemZ1Nlhj?=
 =?utf-8?B?TEwyZXNDZCsxT29PbTU2NGVDOEoyNDIwZW9KSmhrWDZHT2Y2T1JlL1V6a3FD?=
 =?utf-8?B?Y1k2THBrWC8yanB0KzBhdG14VEoxemVSK3lJOEpPZUYzMERNZjBwcGsrNy9L?=
 =?utf-8?B?elU1MDZRQ0pNbDFjK1BYMXEvSmFXRFBERjIrTkUvTzJpeFVBbUpXSlplaGJV?=
 =?utf-8?B?ZlVNUjJwUExGcFF2cmNHdUJrSXR1UXFKaGlMRnpLakFQQVI0OFBLTmsvVWFj?=
 =?utf-8?B?N1h0VjJUcVZEc0YyWXlVZ1RmY09oZGJYbXJoTjB2c3hFR2tkTjdwUFpITE5L?=
 =?utf-8?B?cHBRYWZXaGlHOFpqY0lTVVVCZFlIRTFTM282ckhDeGIwWWJjK2s2Uk1SdTRs?=
 =?utf-8?B?RVg5b1pSY2xHbGRiSnhxVjVIRDBOWnQ4dFY4R1B4ZVdTb3l2OUVIaDNWUjNE?=
 =?utf-8?B?RHgzeGV0MnVkVGtJOC91bEJNUnBxSk5ORlp6NFA1S2VsVTNKUzZybE02eUdQ?=
 =?utf-8?B?Q3VhNTNzUGRVbXcycmdLTGs5Ryt3c1F4R0JUMjNsT0IvcnMyQTVpSFBXamtI?=
 =?utf-8?B?Q1FpQTlCenVDOENYZ1RxWkxKay9VTUdrWEkwUnNaWFFxY3Juc29mSVpKK29S?=
 =?utf-8?B?RCtHTmthY0U1cGwvL3Axa0FDblM4RHpBa3NObWp1Mk0zTnloS0dBakEvYS9Y?=
 =?utf-8?B?L1AyN1RoWWlHb0pXN3U0WkFnQnNUeHRVVTBEaGlEdnV1WU03ZE1Gd3JPN0w3?=
 =?utf-8?B?R1I0bnJ0VDhDemNTYkxTUnAwaC9pdW9pV1ZrQmhMOFZzM21KZUEvK2NsN1hv?=
 =?utf-8?B?NUNoQmtrK0xCakNUSTVPa3hCUTVZUlQ0TVJ3SzlCK1hMZ0tYNjY3dThiTmZ5?=
 =?utf-8?B?ejZmRmdPY3hsSGczVHJ1OEJtVGY5Vm1kNTYrN1Jwc0RmQmgwWU5KR0g5dXdR?=
 =?utf-8?B?cFhXbytLVHFLVldPRXlibmZkV05GUUNmUmJ6UVpaVE5EeDFoUGRjMWdCVlZM?=
 =?utf-8?B?ZHZhWUU4YXEyNklYR0tDcUtUUzcxQ1pZQnpUR0VsWmcxRWo4bHhXVXYvdDJx?=
 =?utf-8?B?QjRPZmhVMkRCQ0x4QWV3M1dXSDFBMllUSElzNWlYbVFLNTI2ZkR4T3phYzUx?=
 =?utf-8?B?U3dmM1lMcEYrRk5zZ1cwenl2T2tQWFZmQlRpN3pPTFpza1RiR1hjN1Zzdnhl?=
 =?utf-8?B?bDFLbDlSL1ByUU0vMUlOQmQraHlHUTJQVFZyTy9DbFZ1KytSelg4c0FRd0pn?=
 =?utf-8?Q?n2ssBWVTfq0xxSbI=3D?=
X-Exchange-RoutingPolicyChecked: tyqoYD9XWqFEIVz1gOnLk17WX1/K1E5vtrNKhGkTWCWRxII9iJefXgmdyy9sF4PvNsx21vrt5FeKFXyffpvza7hpgEnqPLllR/Zdw1V2eAjQNNnJeD0Qtkzgqmpqcp+vviji0NMPVH7sFwEciycWh1jHXvIBLL4Kzwlpz/virNbl6eo+rV1xXgSmj5CbLErbJP2n2igpWh6hcKPcozHlBl9i69U/bNBl0btYjQq17/U0H1XHvFQ4y/xZSpqwKPYKOX4lff6YTxvpc/QB6gqEMUEnzkgY0BcK2lLhHejJiaGnHVkHY6FwYdn/b7fPOyOzkXHTTiIg6TZBTBEMkF/x7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ad09b5-5ee4-4cb9-c334-08deabb35237
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:06:20.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqqM/0hMD5hoR2nGr/csco87vjHNv4Z8ZGlrPOSB3UeN8LiYScOHfpxXvS3Tv4PIf7GlavDWaqxf2njbGa1oj9JayT7ZuQii96h6RU530Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 199AA4E079A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-244453-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
> function, leaving other VSI options unchanged. However, ::q_opt_flags is
> mistakenly set to the value of another field, instead of its original
> value, probably due to a typo. What happens next is hardware-dependent:
> 
> On E810, only the first bit is meaningful (see
> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
> state than before VSI update.
> 
> On E830, some of the remaining bits are not reserved. Setting them
> to some unrelated values can cause the firmware to reject the update
> because of invalid settings, or worse - succeed.
> 
> Reproducer:
>   sudo ethtool -X $PF1 equal 8
> 
> Output in dmesg:
>   Failed to configure RSS hash for VSI 6, error -5
> 
> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1d1947a7fe11..c52c465280f7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8046,7 +8046,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>  	ctx->info.q_opt_rss |=
>  		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>  	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
> -	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
> +	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>  
>  	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>  	if (err) {
> 

Sashiko complains about ice_set_rss_hfunc() but it is unrelated to this fix:

> While looking at this function, I noticed a pre-existing issue regarding the
> hardware cache. Does calling ice_update_vsi() with a local context leave the
> global hw->vsi_ctx[vsi->idx] out of sync?
> If ice_update_vsi() succeeds, vsi->info.q_opt_rss is updated, but
> hw->vsi_ctx[vsi->idx]->info.q_opt_rss is not.
> When an unrelated feature such as RDMA filtering is subsequently toggled via
> ice_cfg_rdma_fltr(), could it retrieve this stale cached context via
> ice_get_vsi_ctx() and copy the stale q_opt_rss value back into its command
> buffer?
> Could this cause the firmware to silently revert the RSS hash function to its
> previous configuration during the next ice_update_vsi() call?
> There also appears to be a pre-existing issue with state desynchronization
> when handling failures. After ice_update_vsi() succeeds, vsi->rss_hfunc
> is updated, but ice_set_rss_hfunc() then calls ice_set_rss_cfg_symm() at the
> end of the function:
> ice_set_rss_hfunc() {
>         ...
>         err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>         if (err) {
>                 ...
>         } else {
>                 vsi->info.q_opt_rss = ctx->info.q_opt_rss;
>                 vsi->rss_hfunc = hfunc;
>                 ...
>         }
>         ...
>         return ice_set_rss_cfg_symm(hw, vsi, symm);
> }
> If ice_set_rss_cfg_symm() fails, the error is returned but vsi->rss_hfunc
> remains updated. If the user retries the command, the early check:
> if (hfunc == vsi->rss_hfunc)
>         return 0;
> evaluates to true and returns success immediately.
> Could this skip the ice_set_rss_cfg_symm() retry entirely, leaving the
> hardware's flow director rules in a non-symmetric state permanently while
> falsely reporting success?

Someone from the ice team should look into this and determine whether or
not its valid.

