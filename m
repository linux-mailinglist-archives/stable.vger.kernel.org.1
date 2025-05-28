Return-Path: <stable+bounces-147974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D1AC6CDC
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4192164868
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904E28C2C1;
	Wed, 28 May 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiudYa4T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBC28C02E;
	Wed, 28 May 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446457; cv=fail; b=Sta495cBmF70wAer7mWZdY6d1VdHvtRNQUIZeUUgpMRgvAFNXCmStJN2DhQ9/EK8vSz27yfgnD0+02rCMGvSmWwb82X3xAwZ+c10Lpr/vVtZf9RKwiKsGqqh8KuCxwO8lxjMQ2cZf80Rr/eawYXhmFSidaq5Vaxs7+42NPxPZgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446457; c=relaxed/simple;
	bh=1hPqwcU9eRqR43f/3ZUS+hkPY9GwdehhsVqFVma0gvk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uruf7XUvGb6HTPWKslETz7L9xISQ85hUI6/fCvt8yxPSKR8m/LAb+N3blyT4TMULPlRx1KWHp3fySKopbC23X/sWUsJ2FzIu93d11g8hU6UcQsi9oU3Xhn25VDtyar312H79s2LGbP7XJtqURurCi+UvPU7cpagZi6CSQmtL2u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiudYa4T; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748446455; x=1779982455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1hPqwcU9eRqR43f/3ZUS+hkPY9GwdehhsVqFVma0gvk=;
  b=QiudYa4TDTiSRqegAXczbcaAu9gCs5HUO0R+jez8sguhrOOb79DhotVF
   wyjeeSTxykqd+EiJW/WrKEsXrLVGVQTPboJ/u1gs7Vk/lHGSCDwPsG0Ql
   /nP3tNAMZ0tyWJTGRyAGX3xvOZZ8R8f3Zb4iXewKuEraeMlkQWlJqx737
   ql+nWAGVtJejj2vi8eSKqPFvCa6gl3+BQ7QwpN9LwWhOUB+arN4l1FjR3
   3SpYFeChDORJuY6s0PCy60ecuAY9GE4tEctIyxBbWwA9ikCc3lEQvhGl7
   nOolAF/luQR9rLaogI2OGSFLIXvXXLZ98+QiaW/PrewPH9YinvPGT0WJq
   w==;
X-CSE-ConnectionGUID: Y+tTCwIJQkOCAuqereXmiw==
X-CSE-MsgGUID: LRPy+DAMREm853OxcfuqZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54285197"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="54285197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:34:12 -0700
X-CSE-ConnectionGUID: 8HpoZSjmR9CBKRK1HMMNXQ==
X-CSE-MsgGUID: YR3O5u4+QAqvq8lr8KXeVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143719628"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:33:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 08:33:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 08:33:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.84) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 08:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8/hCVXrcsS6dRQjW+TdGYqL5VEY7XM2ofoOFVtxK3jOeuEmSuD2jqTlR81/uu9beSiKydJ4wFx8NPAnSPmA7lh0ochG6mVS6CG9tnmLz2V+51lILgJSMPvf5bOugJLocoJempy/1nZBdAeBilx+6ImNygzgjGRFcXDhBmRohwO/gPLAaFEMt7JX45S0jq30EWgKihWiDnG8/LvmdJ1ff6qS/waE72yTkgqDk+QO5Csx2fapd2zA2lpvzZpEaNnSv/aCHlOXiLorrz5MOjWaiR1r9CR9tZNEBrcw2QdGqO92melcpyFOmAvWdwBrtzv42I8uNFKUWJ/NsjDh8gtX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWDLcJkpsmn6Ai17siGGMVuZcoE4DI9Mqo1+Ij3HSWs=;
 b=ygiLYLH4HJ7Oipnyo52mFaw5r+Ha+VpwDR3r/Y3hPqrtFYNc1B/Rpiuwz3PgHMIIp42uX8fHk5/RU0zS0s5wvxyYnxFX111FHsTXc9T0Z5IWP2oJlvIiLeHyOctlu0dCV1m+g3o3Bt+0YBAz+rDnC1askIDO+5Ypkc/OFoNUgWaymcKxlM30lgZOK2zBVPhK2s/8MuejYWlvsQdfimW54/yZb/tWT54OrEdAWFplqoFiZZfY7yNJTj1IFMhykxwkpiJl/IrIPPzOWtZ3Skxbsh95D5LjZoHtyXwLYPL2fL1aupJ9GZnnwIEfRcYFAlFQ5ck9iF3YOkIV3L/9iQDyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 15:33:39 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 15:33:39 +0000
Message-ID: <cc70d2d6-df72-4032-8d9b-fb96f4ef3ed0@intel.com>
Date: Wed, 28 May 2025 08:33:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: fix heap overflow in e1000_set_eeprom()
To: Mikael Wessel <post@mikaelkw.online>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <torvalds@linuxfoundation.org>,
	<przemyslaw.kitszel@intel.com>, <andrew@lunn.ch>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <security@kernel.org>, <stable@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>
References: <20250527211332.50455-1-post@mikaelkw.online>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250527211332.50455-1-post@mikaelkw.online>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0cc765-06d5-41f8-0d32-08dd9dfd051e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bng4bWh2R2tOcmxpSTdMcnhjcndOa0QvTXpERnRYOWVDelA5UmxYakYxSGpI?=
 =?utf-8?B?Z21tU3ZtOXQrYU1McFN2bGtjNVJxcWtUREZrOXAyL1RmcnJ3RUd3NCtKMThN?=
 =?utf-8?B?Mmx4TTExaHhFemptUDYvRnpVRUlaKzR5ZzcvdjZzMW93U1crbkIwdXdGUjRi?=
 =?utf-8?B?bW5DdTQrUi9EZUN3NjlaVVp0cWNsaWN5UThJUjFzZU9qdWYrUld3cG02RStH?=
 =?utf-8?B?amFFNWVpdkRheWZPazVUSlBHSWpDbFdTVm53TlhvdDRGYm96YktjOXErQlIz?=
 =?utf-8?B?eXNHR2M2d3VpS2ViSVZqWVd6eFZ5RnZqT3RoWlJGK0JkZUlYWlpNemdaQ2JH?=
 =?utf-8?B?eCtlYnk3b1I3eXNmY2xUdzEvZ0lXSm5WSjI5cVFDUk5ReFNEQVp6RXdtS1By?=
 =?utf-8?B?MjJuVXVlR3F4dktsWGZUWDl0dkxDQU8zc0o3NVpkVmFmeEg3R2U4NmZZMWdY?=
 =?utf-8?B?RENMak41WFEvRXlxNS9yS2lDQnlTM0JCc2NscTcvbHB6S3E1d25MNER0bkpY?=
 =?utf-8?B?UFhDbDZVMzhYcVVaOHNDUHYrcVNKbGVLMzJGODc3TmdaVThUdzV1TnpaTHg2?=
 =?utf-8?B?NFUzaHdydzRNVThucXl0ckx1MUlrQVVYbTdIZnZZNzh3MWNuS2JzZ3NMNE5w?=
 =?utf-8?B?cWlIemJLc0ljVnZHcWdmbHQ4MHZFOHZScHlEcllMendvYlFGai9nYnhmM2Jh?=
 =?utf-8?B?ZE1PYzZjczM3Y1pCaFVmZ1FDamhxZnJSRTBSc255dGo2TVNzMHJSSm5kaHJz?=
 =?utf-8?B?eGprdGovRHcyQzZ6N0hkMG90R2RkbVVyeXZ2eDdTTFlQSHdLVHYzNEQySnp3?=
 =?utf-8?B?ZzBpMzROcHN6d2djSWR3YThhQVFLZlpEMll5dUhFdXZidmZVVndwWndKZWdI?=
 =?utf-8?B?Z1BjNUtqSW0zZ1VLMVI0WFpQRUtic1dsQXVGQzJFV05UVUQrTGEyUEJWV1Vw?=
 =?utf-8?B?SmhXbUFQTjRaVDU2bFY5ODJLMGpJZjQzTU9zWmVKRDQ1T2ltZ096M2dBN3c5?=
 =?utf-8?B?UGw5QlJPYnR1eFJTM01NUThRQ090ODUrc25KYXdqWUxwS01FY1lzSDM4dEJj?=
 =?utf-8?B?dXRvamxYZUM4Z0RoeXJ4OXU4Z0V0VXgrQjlsK0JzbVYvQm5BR1dOd0JQWUpK?=
 =?utf-8?B?bFZRMVJRNWx0VHExOFJpeGpNelluaXdHa01lVEF2bVZzYkIzOFVVYjFNVEtx?=
 =?utf-8?B?VUp5SXJRQ2orMlhoRDNyNW45SDdYWldDNDI1MGg5WFBCbU1LdExzU2lGaTRR?=
 =?utf-8?B?SWlKQlo1b2hrcFFDcFpFZXZ5TjNlak5jQXVOVGxRZFlMc1BaczdlV2pXQkNa?=
 =?utf-8?B?Y3J3dDA0SXdaalhMcFFGblVtMFE4L1VVYjZUTDc5NkVvb0RPd0FHNmJqUXJt?=
 =?utf-8?B?Z3p1N1NMQzhGdkplNXI2Zk0rZTVsVlhHUEtRb3kvRDE1YlJMVk1LbHZWRlYx?=
 =?utf-8?B?VDhhTE42UHFLbU1HNlNLR2hMK3dxZk1NNVZaaEwvZHptbVA0MW45Myt5N1Rp?=
 =?utf-8?B?c0J3b3F6MGhqRUMvcHFHUlFRTk5DLzFYOHlmV25XWVBwUG00NWVvRDhkUmZr?=
 =?utf-8?B?ZzNCemFMYzVuUUdHdlVPMmRXckpCaUVhelVENDNiK3pIWHhoMFVIQitLa1Fo?=
 =?utf-8?B?cldaV2Qyb2lKZWw3ckx5ajBZMzFBQW93UDFuV2dxMzFERnIwZ2EzTmFoT3pl?=
 =?utf-8?B?bDlFOE84cFpDZ2locXJHbjB0ektHYnlFM2dpQzd5UUtqcWY0UTJnUzYvUjBy?=
 =?utf-8?B?Y3VzS3hTVUN0cE1TcU14OUZyenpvaTYwWTllRFNtSjdHMlFlc0VKSEpMWklL?=
 =?utf-8?B?Q0I1RURjWGVQalRpWHQyUi96T0FPbFVaL2k1ZHZ0M0dCWTlWK3Y0ZEVPSnJw?=
 =?utf-8?B?Wk9BQUw3ZWpjV0JxVHVzLzZBMklZNkd4QUVpcWlOOCs5aUxIUVNublZsb3Ey?=
 =?utf-8?Q?yaLd/fX/5cs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZ2T2tSUUNrdFlnT1I2aE8rMHdid3AwZWdZNkpZQnRsczQwYmRqWFNPK1FR?=
 =?utf-8?B?V25pSnlCcnFSQ1ZYNmJmalFpQTdsVjdUMmsxYWJiR0RGb2lHcFhDdGtBbFpo?=
 =?utf-8?B?azEzZ1hRdU5uTG5EUVBzc2xEQ1VuUlU5R1ZhcDQrUTJlaGtIcHI0d3M5UGpJ?=
 =?utf-8?B?ajlsd3dYam5abGd0WXVqTSs2QjJDWlNXb1BwSlRPK0pkWFZ6RXVwNXVOTUJI?=
 =?utf-8?B?a1RjaFQ0NVlWVmptT2N0QnN2UUJhRFB2eHNSTzRpNDVtTGwzTUFVV0NaUEo2?=
 =?utf-8?B?czAvYmN0eDJpR2ZPWTh5azBJdkx6OVZWV0NxZ1lmeDRyRCt4VU9ydUtJNjQ1?=
 =?utf-8?B?SStiWnpxRHdIalQvWGkwVmV6Tk5ESGdpVFdqamwxYXNnQmJ3RWpuTm9TcTJM?=
 =?utf-8?B?T2VNV2k3WTBUUVIrQUxlRGd2SUtvbGluVFhJZnVjUGVZZjdPeEloSjN4VDM5?=
 =?utf-8?B?QTA2Unk3U1djNWUydE5YZ0pNSnNLRzNURjJtbDFld25ocnF6dGg4RTZuV2tv?=
 =?utf-8?B?ZlVNQTJiamt6WjFGQkUvQmFnYTlBaTlkZDFnMFVZVzloaGYyTG5vZmRjNi9H?=
 =?utf-8?B?dVB6bnBIQzdReUhMMEpEWXc0dGV4TDFFQUxkbVE4cUYzRXl6cWN3Q2NpcExz?=
 =?utf-8?B?R1prdXhYVzBYZVVKaWZteEpnMTlQdkxJVzF1RW9DYndLWDdNenQ4Z2wvdFpx?=
 =?utf-8?B?NFQ4RmxBTytFb0FqbTh4MGpUeFNmYmxRRS8wZ2pxTEIxaWNpUmxHQkwrRmRv?=
 =?utf-8?B?ZmQwVDROa2pnOG51d0h2T1NobkUvaGdlZTROcXFCRWt2Q09vcXhkUHYrNGor?=
 =?utf-8?B?OVVLV3MyMmllQmI1L2NVdzFVMk56bUlhTGNMeEdramlCQmg0NzJUalQ3MnA0?=
 =?utf-8?B?Wk5jWHZ3KzBlYXNMZ1huMHRIaCs2YnpGMVEwMHdwbmhrMk9MWHpUc21lWm1J?=
 =?utf-8?B?dVFTOXRlVTFMVGNjY0J4VU1aemZoWkppQ015V2t5VnZaakFvSjRoYTVncTZU?=
 =?utf-8?B?UzQzeWdkcjNkcVVBejR2MUdPU20xSlpFbkxBUHpXcUZ4K1JHQlBsc3BaWXZ6?=
 =?utf-8?B?M3dUbzFZRy9HZTY4OUxhRXg2Sk5OSFVQcFJZcHdrVzg1bzFXcjRQL1piUXgy?=
 =?utf-8?B?UFdCU1RMYlRxSzRnRkhDSStKMWJqMWVFanVKOTFqdFV0SnlsMVVpWnBkM2VX?=
 =?utf-8?B?T0FnZkoyNWZTZzhoRXBpWlduRC90bUwwU2pRb0NSLzExcW1DTEJxWTQyR0dk?=
 =?utf-8?B?YThJa05QaVF1RmtYdW1mS21OZlVLck0vdGRjQ0xmYmlKV3hjK2VXb0g2RkVi?=
 =?utf-8?B?SnVXbElOcFc2b00zYVJEengyeUh6QWlLTEhZK3RSbWU5OHNmVGlCWEpzVFdU?=
 =?utf-8?B?c2x1NXA3cVdrMjEwT0dvcDlDU2RuU0dxazlPL2Q2RElTQVgybmNlbjNmYmZq?=
 =?utf-8?B?NzRBaCtCK01DVTBrYUt5ZGxlTjNmSTN5bXhEZFJLVmpQSXExVElZby9ncDZn?=
 =?utf-8?B?bGY2NllWbzlTZDAydkx2TkdQYjdpbGVqRk9FQjV5SXFDR0p5d0lhNVlPTnZM?=
 =?utf-8?B?c0ZwR21kVmJhNElYVTBiMHdlN042TGN0dzMzWmZjV1NvdXRBYjhUdE5vaEJE?=
 =?utf-8?B?clNOTjcwWFd4UkxjM3ZFbXpQQ2JOT3M3dWQzNm5KUG8yNDVaWjRmTjdpNURI?=
 =?utf-8?B?RmN4TmI3WkRMSlhFeU5NZEl0ZGQya09JdlNUZDIrSGhqVTBkSFpqVkQ0aUNn?=
 =?utf-8?B?LzM4OXZhVDNvY3VPcGJrWUdNK25LbFVNaTEyRG9vamg2ck9jb0l1azhtYVpt?=
 =?utf-8?B?SHVOMU9ZMVpUMnhpa0w1cTBwVGpjUXhhNWtNMyttOXhJdDhBa2g3TlA0WEt6?=
 =?utf-8?B?LytCSGl0eEJRSGhlUU9id3ZRYzNzUGdreng1RXg1WWlqTkVVeVBGZXc5YW1G?=
 =?utf-8?B?UktueWhUWE1FMktvMTJ3dzdFZHhlRVdFaVJqQ2pUelE1c25DWUZPOC9BQzE1?=
 =?utf-8?B?UHI4c0NZSlNxKzNpeWYxQVk4MVY4NGJZMFR2WTIzZHJHNEpEakUrVEVJWHFz?=
 =?utf-8?B?MGZtOWF0ZUJRV25OTWk0aEhocXJsMjlLVk1zSkFjWm51bkRvamZSR3JycElh?=
 =?utf-8?B?a1BlRnZ2QWZiVGhFZkdabHNRVndVdTM2RVlRdGlNS1ZFS1BoeFlTWUNYcWlV?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0cc765-06d5-41f8-0d32-08dd9dfd051e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:33:39.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKln6LPcyRfRiOF19hVHROyoL/xVOOou1fa/WCl8a2E8bmUOqA5fJpY8lQ48uGW45QI4D1oTHnFooldvfO2psMc5haJ1/S+o26FFft+Aw9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com



On 5/27/2025 2:13 PM, Mikael Wessel wrote:
> The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
> without validating eeprom->len and eeprom->offset. A CAP_NET_ADMIN
> user can overflow the heap and crash the kernel or gain code execution.
> 
> Validate length and offset before kmalloc() to avoid leaking eeprom_buff.
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Reported-by: Mikael Wessel <post@mikaelkw.online>
> Signed-off-by: Mikael Wessel <post@mikaelkw.online>
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/ethernet/intel/e1000e/ethtool.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 98e541e39730..d04e59528619 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -561,7 +561,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
>   		return -EOPNOTSUPP;
>   
>   	if (eeprom->magic !=
> -	    (adapter->pdev->vendor | (adapter->pdev->device << 16)))
> +		(adapter->pdev->vendor | (adapter->pdev->device << 16)))

As Andrew already pointed out, please omit.

>   		return -EFAULT;
>   
>   	if (adapter->flags & FLAG_READ_ONLY_NVM)
> @@ -569,6 +569,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
>   
>   	max_len = hw->nvm.word_size * 2;
>   
> +	/* bounds check: offset + len must not exceed EEPROM size */
> +	if (eeprom->offset + eeprom->len > max_len)
> +		return -EINVAL;
> +
>   	first_word = eeprom->offset >> 1;
>   	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
>   	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
> @@ -596,9 +600,6 @@ static int e1000_set_eeprom(struct net_device *netdev,
>   	for (i = 0; i < last_word - first_word + 1; i++)
>   		le16_to_cpus(&eeprom_buff[i]);
>   
> -        if (eeprom->len > max_len ||
> -            eeprom->offset > max_len - eeprom->len)
> -                return -EINVAL;

Seems like this patch is based on top of your previous version?
https://lore.kernel.org/all/20250527085612.11354-2-post@mikaelkw.online/

Please a provide a patch that can apply without need for previous versions.

Thanks,
Tony


