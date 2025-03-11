Return-Path: <stable+bounces-123157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF515A5B9F2
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BA27A8EF6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214ED225A2D;
	Tue, 11 Mar 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSIIrZs5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8139224257;
	Tue, 11 Mar 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678489; cv=fail; b=cBA3vOL1KV3Zx8pl6olo3q9RcYyjlP5CM8XlAaLzSUH64qypehRLJbE7AZ6WqKZAJ6tOh/K0B2YOEWJEDc75zVULhKnPYwuXdpFaQrALvW10wEfdH6n/ttf06+c5kawRmu7gNcSpn6ZaSO4AzMoYR5ykGodJMT6z2v4MoO2dUhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678489; c=relaxed/simple;
	bh=tPkLqd0pXJJmH0mapQ134cgY7O8i//73kpsarMJWZ1M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+UeIYPhWcP4WoVVXYNpvEILvN00gUThrAFvMLnxP1ak98i9v6oNbQJ76Dxl3XVxJV51t0/EoU/9iOdfia0BqRjs0Iw1aCzCq8HYnI72Bs3UfmLQo2aU3K6lwJrBap8Lyaf1FnL1cgCCoLNz35x8i7Q9WxPTAhwWpuvKhLFudLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSIIrZs5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741678488; x=1773214488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tPkLqd0pXJJmH0mapQ134cgY7O8i//73kpsarMJWZ1M=;
  b=RSIIrZs5ocGrvFT0V/sMb4tBgZ1AFA+DzaphYb3vEphxh++0jEz7dNhb
   aZelTLZOpIUTCFJE+8Mm08TOxBPvKLs9p1iNXoiHv8vZW3p9e/qYu8wLc
   dvVeFLXkq3B1GO3GRFKdDsyP4jhrw2+Q7ZMJWsOd/RrRnnUI9hI9LBXHF
   7+0WNjryRpdHhpwMBZ3McMj9MsuU+JyfRdP1T2B4/jCisDSuBHFCbukED
   GcBBVi8qZ84gt2rhYBjf4kW0D+Dlb97Ha15vZSUDbf5eO2OKxfl9Tyz+4
   c2oXwduusTvcC8Iik2AsKl47KY+pvADGi0FXFZ42jTcvnrGPPEU4/P79e
   A==;
X-CSE-ConnectionGUID: zxnEMzS8R0O/THnb/EwJ2w==
X-CSE-MsgGUID: rSSY7TxZSZ6zuFcGszg7kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="45488427"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="45488427"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:34:47 -0700
X-CSE-ConnectionGUID: kSeNIJV1SaeVtk84LkbNlQ==
X-CSE-MsgGUID: hqOUPUsYTHuixm9CoWbHXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125435858"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 00:34:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 00:34:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 00:34:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 00:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8Tj8PsfAZD+Y2NEayxN6J0rkeLRpfAvynmiQt3SG8LqxsAPUMc00qkXuk0pkZnwa0piVsV7WmwPKNBN8QvBQ4XuH4hnskq3418PnyGDGqiKPxUugzxUMAtFiFwxLXxkwmF6r6y2+uK1uEfaGLNAQ7W8THknyk4IjuO5lhfzoQvvtSHCZss6UO8ZyH9b7Ntc6qxsdAj/+OMYf8+R5YE9k78zT3kjz4WRgIPg0zTghT+W0+KZ+V2tBu10tgpy52NwwlT74HFWbtFRyM6+BegfbDNMzzeZ7etmNZD7YcrgZjck57D+HwapY0l9PiZwV6gBcxQ7flVQEKL0FRmB6Nw16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He0uMAxtGmsPKBn59I+fZu1RP9iutdsZ6lqVcpgQ6m0=;
 b=JQ3+4An3T2j8U2kSDMO0gh3FTmei9aBucm262qWRYl6+MN/CM0v13J4hu0HryCNm0CaonQzcSW7+0bdR4/6iI6mUhoTz2qBM7PmCDGmiN8zOftyRKCtanaA2N9iawEcKRy5Ac0lgNB2v66+Coiku2mo0nhv5pQibTA0g4xmwBYMs/aFji4Hzo5AP6JG9/NeHRQC+fdX3M8ArQJBy4/n8yZkyc+a6JscdlJSbiBkclSBbRYvPJ0m4oCpapUsA/fHqxdNu/sSHZLNI6dra33AbNiCz61I+TyO/ZjfoLugheMkXzIFwcVabID24pLwMvodsONxDFApLc8ui2AC2FJkfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:34:44 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:34:38 +0000
Message-ID: <727c857f-0234-417b-af5d-69b3ae064d0f@intel.com>
Date: Tue, 11 Mar 2025 09:34:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
To: Karel Balej <balejk@matfyz.cz>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <phone-devel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	<stable@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "Haojian
 Zhuang" <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
	Jisheng Zhang <jszhang@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
References: <20250310140707.23459-1-balejk@matfyz.cz>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250310140707.23459-1-balejk@matfyz.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::42) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1b9bbb-2e35-4241-2efc-08dd606f2d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|41080700001;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckNOUkZIcjJYMEtOMk13RTRqWm9UdkV2OEVSWmpoMVNyK0IrRTFBOFZyemNp?=
 =?utf-8?B?YnpzeDZYK1FrZ211QVdhcVplSHN2ZldxNzg5eGo3TEs4ZUhDTkZ1MmVvVUpO?=
 =?utf-8?B?aW0vRkFUN2YyR3BEUWNIeUJLcnhLRmpLZzMrM0ppeEt4emhWZGFUSmV2cDhF?=
 =?utf-8?B?N3hoc1F6WTBFekp1TFZaQ3g1R1ljck14Q0pkMnM2VWdndE9NVjVJekJ3VzAx?=
 =?utf-8?B?emUwQmt3Z2x6cURVdXR3YTFGcy9lTVNpMkxqdEZFT1Mwa1RCaitrTzVkQlF0?=
 =?utf-8?B?T2t4Zlp0NlBpeEhENktPVmNpYzBWMkhXckJQMU50TXQ4U2MwZDF4Zy9WZVQz?=
 =?utf-8?B?Tkx0Y0hSRTAzcnlnZ1hGYU1DVXltM1ovY3BNZzExN1Y2RDNNNjFGVmd5QXRY?=
 =?utf-8?B?czlsTTNUdktMRTdmZUtpWGRoU0w0VGlHU2ZWTVhhSVYxRnJHN082VE9xNFo0?=
 =?utf-8?B?UkFrVnpsYUNwaHFweDFUbVd2cmx5Nzlzby9tenkyV2FMMmlrck5Bc3YySlBk?=
 =?utf-8?B?bE5QS3NlK3ZLdEM4K01NY3UzcUgzMUkyOEw4RDFGd3JvMS9tdGdCQVZreUZU?=
 =?utf-8?B?Y1ZDbkMyeldnWERGQ21NeG5acHBudUl3UUFmRmlIQ3JmYmRIanZyZmR1aGYw?=
 =?utf-8?B?SytnSDkvcTVXd0ZwUzVnQ0FmMUcwQlYvTU1SaG43Zy9TVnZJMEN0MXRoK0d4?=
 =?utf-8?B?WjJHY3dtWEZYRXgvK0dTTGdsdHhJbDdCQ2daeWFyWlhldVlBbjVYcm1ZajRJ?=
 =?utf-8?B?UEQwY2l3TnA2M3V6aFgzVTlMZlVsZGdlUlQ1TnZkcmZlY080dE5WRTYrT3o0?=
 =?utf-8?B?dTdBa0VSR0xoZENlMFdmMklydlNXcnVrekVLLzRubUF3QVV2b0VpazNsQkE1?=
 =?utf-8?B?dmVYbXBxN2tNcjBJbmpHaTFkeXJ0bmQ3eEZnTVVOSXdleUZUWFFEL0t3RTQz?=
 =?utf-8?B?OFlpdkdVYzJnbTRPSG9ldjljT200d05MUWExVGFHM0JlOHNQdjVXSlFBSHRZ?=
 =?utf-8?B?SDNUNDREK1FQVXlYcVZDK1diaHRNTzhqREdKYkg1eTdFUFlldDlZV2paWEo2?=
 =?utf-8?B?R3dmN3FJeWNuQnpIa3Z0T1FUaGRBQ0I5bG01azRPQ3oySGpqN3dNSWsrWnN2?=
 =?utf-8?B?a3FDd3BnZHF1WjRtK3pEKzhxazRvYlNlRGJxU0JqV2FSaytpNkZUVXZJcHR4?=
 =?utf-8?B?ZlIxWXdhaXY4VVQydWZlUlJLMlV3azNvMGRDZmNyMU03SFYrQWN3UThqSzFG?=
 =?utf-8?B?NHU3UlpaTHc4OFpUUHFlbUtSN0g1eFhnelFVZ1Y5V0kyanRPc3k0Mm5PMjhx?=
 =?utf-8?B?ZStyeFBleHVxZ3ZaQWNMalc2bGFQQ3pPRjJ0OEpwdXlxSkI4MU1WcElxWUJu?=
 =?utf-8?B?NGFLTzBsbzFiVjlaVDE4SmYxRWliUW5GSTE1anU2UStsUTBiZy9CR0RGQnor?=
 =?utf-8?B?UkhXVjEvaG9OaU1lU1dLWk9FdU9XREwrZFpSakJMTzcwVzhyVjZoVEFDWUNZ?=
 =?utf-8?B?NW9HUkxQWkdLYW1FenZLV1VlNnJrWkdYbUxaNmlkTGpERFZ0UkQrN1BpS0VD?=
 =?utf-8?B?aWhkNm9BcUpuLzdCaXlERHo2ODZjbUMwYmMrQ21zVjlENDlqQ2o5MTdkRkxv?=
 =?utf-8?B?THZuR05VaDJyQ0s4WWtRSmFHVDBGY1Z5LzJqcTQzRG8xYkcyS1ZvaXY0ZHpj?=
 =?utf-8?B?SUlMK0JVcncvRkYxQXNybGY3V0ZRbzRZMEtuMGFscFB6ZjhOYUtzOTBwR3pw?=
 =?utf-8?B?RjRiNE9iTytOK21INERoaUF1SnlrRzdUeUJ6aHRPU0FSbGYwVEpPeUlTWHpw?=
 =?utf-8?B?VERxeEh5RjhqclBEclVycXdPOExYbmpDcC9VbmY1VHdBK3RYMllObmFOSTRC?=
 =?utf-8?B?RzNYTkpxYW1ualRkVlVwanU3TE9VWWhoT29RcjVjcnU1VDNBL0JISUI2WkYv?=
 =?utf-8?Q?HboaZnADMPgw+hDmUZyTFEc1Cv0iOuvr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFCbkduSnJqYXBudExvSnVwMXVuT1Jwa1Y0SVYzeW9Gd1RCTERVK3FKMkUx?=
 =?utf-8?B?V2dCSVcyQ0wwQ2VBa01NZnRFOU84dE1FRWdQWk9Sc1lKN1RVSEhYa2dBcGxF?=
 =?utf-8?B?Q2hNQ2RQOUJLdkhsNXV4MUtaMUQ4dGJoV3VsY2dIc3VDTDM3OVUrQnB1V0U2?=
 =?utf-8?B?czVydy9QbXNkMjZpZlhBZlN5NnRLWWRycHJSL1E2YVZqMHJmbThiK1FrRDNo?=
 =?utf-8?B?VGljRnRlWUF3V0ZPb2NTbkNicnNjSldvNTBzYWJrRDZVT3ZiOFlub1Y1WVhq?=
 =?utf-8?B?a0NKU2ZLYnpwRXZJMDJWSWNKYjZ0Q2tvQ005ZWxIOFlQbEdCbWdMZ3BHanJ1?=
 =?utf-8?B?OHJ2bGQ5bjZkaXpJeWNzUHZYUGRsN2ZFaTdadkI2VGc2OEZmTWltb1c3VlYr?=
 =?utf-8?B?Sy9lZVk2TGxqM0dPWmx5UFV0VkhhbFY1QlpVV2l4Q0hFTDMxVExXYTBQdEUv?=
 =?utf-8?B?bUdrM1JpMEpBRDBDZTluZFg5bUxiN0NlcFN6M3BBMDg5UWl0VmR6L0xVWElV?=
 =?utf-8?B?Qnl6cExmOFk5Z0ZkZ0R0WWxsOVg2ZWM2Nm82NzdsTFJjTjBNY2lIUnE0aGsz?=
 =?utf-8?B?TkhqV3FpU1pBSjk3UkVrU05kV2xFZEpSMFFvWVNxWlhUaFhyNkoxbjliR1lv?=
 =?utf-8?B?SWJtWDFVRHowdUkvVFJON2hyVFhDSDRvOS9GcVl6U1JGaHhLbzJsR2xVdXVS?=
 =?utf-8?B?ZS9iZnFiSmlKUUlrYjE1T0RTazkweFVVd2g4TTBrTlFGVTR6NU50MG5sYzVM?=
 =?utf-8?B?a1o1cWQvS1REeE1EcnRQcVpSZmhxQnFzdTJXRVNIZk40cGhUT1dEa2p6T1VN?=
 =?utf-8?B?YnBPSGFuZ0lGZjBnM2tNSjI2WXBCOFlkK1BVd2ZoUjZLY3Y2cHZIRTlnZmM0?=
 =?utf-8?B?dDBneXNXUDhRc0NkckZUVGhESlNYWGNEeHVrSWR4VmpYU2tmb1hmV09hYTFX?=
 =?utf-8?B?QXU2am9OWk9RV2pKZXNWaGZDVGVnZlgzKzdQZXVWdThHejRyUVhHSmZRNFMz?=
 =?utf-8?B?L2oyZFRzOFhSbHJrclJmUVlKbzdmZzcwTThlVWNRUFlQNElVTUI4RGdpd1kz?=
 =?utf-8?B?eVR1NC8vM25BSjhNRnlkL3hiZDlIdnAzNWZ5ajQ0bHVhOVNBS1IwRkN6NmFB?=
 =?utf-8?B?SjhCeVc2RXJDc3J1dXM5UnovNDc1Q1JEbXZXTGsrNmx5WGdKWEhyY29LY0lD?=
 =?utf-8?B?SXByUlBDQWJoVzJ3V1NrUFVMdHU4ZEJTWGF3ejNjTFRXa2w3ZHo5RUt5anJH?=
 =?utf-8?B?dmxYUFBOeWV1elRwQ0lnSHQ3OFRsd3dvZEJFdlJ5QWFuVFB6S0w1RkRDQWkw?=
 =?utf-8?B?ZTVSRmgyTytWN3R5TFhYM3lhRGNKbktmd1pQbm5iTUxvb0NBQWdzMkNrZzE3?=
 =?utf-8?B?dGNscUlqMUNHYXpqZ2ZtTWxCb2x4RHhLcEdKUzdhNXZLMzlydnJLNXVaU0NL?=
 =?utf-8?B?UWIxejY5bFdOTW83K01KQ1NRZlk0SlZzOHVjQW5hWGo3OTNQa1FOaFNBbnBh?=
 =?utf-8?B?NkN4eHRUU05ubjVxSlkwR2J4Z2JlbC9rSVljVk9Fay8vK2p6L0t0alRYc2Y4?=
 =?utf-8?B?ODhnWlhqaGowUXVhWU1HRkVGWlYvS2QvVHYrZEg0M0dhTDlPQVZWZnhEalEv?=
 =?utf-8?B?Q0VlWXQ1YUh3c1NPY3NRc2tzYjJLUndBeGZxQ3NPV3pjQm15VzNIZDZsc1Iy?=
 =?utf-8?B?b3VUVDJDKzl3cGpzVGhRb3FCb3pkcUk1ZlFkSGhwaUJ3Tlp6STRYNGdLT20y?=
 =?utf-8?B?ZVZrbVp2MEw4aE8vL1o3aDBlVnp1eHI0Wm01bnVTWklIazhVZFA1QUlSMXZD?=
 =?utf-8?B?UFpkTHgwTXk1YStFNmF1NGdGaVJYUWNabWRaaDVMSkpVOG9YOXFNU3dMVlhZ?=
 =?utf-8?B?cm85NVpNZlJaWUhHdHN2aVQ5end4bGtPQmJDZ0I4RDFSbmtoM3hBV0hmWldt?=
 =?utf-8?B?Y2F4MG00Vm9oU1dZWkZKYjdvRjBYWEdvNitUbUNUWWVONUJhajZwZWphMFNz?=
 =?utf-8?B?cU1lK0p3WUZ5dFQxdk5pa21XU1NUbjM1M1FjZWRJUElQRWJub0lselhyYUxU?=
 =?utf-8?B?S3JFYmxicmoyVHk2Q0o2eThsNVRvS0MzWm5mUVZNeHhxaHFCT0N2MWRRTjdX?=
 =?utf-8?B?dDQ1bER5L1VCWGxJaU1IdkFXT3cySFp3dGRGOHBNZFlCeVppY3cya3ovK09s?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1b9bbb-2e35-4241-2efc-08dd606f2d66
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:34:37.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4tqpVMwYKPEoCkIQwB5M4WjvE2UEU0KLvWEr2xDcqKJ0Y2V/tPIrUCetbYAU4JT4UTfh99Pi94ZZnQ6jRs9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com

On 10/03/25 16:07, Karel Balej wrote:
> Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
> prevent conversion of R1B responses to R1. Without this, the eMMC card
> in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC

So that SoC is from 2015?

Is there anything more recent using this driver?

> with this mmc host doesn't probe with the ETIMEDOUT error originating in
> __mmc_poll_for_busy.
> 
> Note that the other issues reported for this phone and host, namely
> floods of "Tuning failed, falling back to fixed sampling clock" dmesg
> messages for the eMMC and unstable SDIO are not mitigated by this
> change.
> 
> Link: https://lore.kernel.org/r/20200310153340.5593-1-ulf.hansson@linaro.org/
> Link: https://lore.kernel.org/r/D7204PWIGQGI.1FRFQPPIEE2P9@matfyz.cz/
> Link: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr/
> Cc: Duje Mihanović <duje.mihanovic@skole.hr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 990723a008ae..3fb56face3d8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -399,6 +399,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (!IS_ERR(pxa->clk_core))
>  		clk_prepare_enable(pxa->clk_core);
>  
> +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  	/* enable 1/8V DDR capable */
>  	host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  


