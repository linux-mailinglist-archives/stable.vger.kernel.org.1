Return-Path: <stable+bounces-176654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB0B3A8BC
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2194C7AC4C1
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1477133EB0F;
	Thu, 28 Aug 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9OEYHX3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB90338F45
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403405; cv=fail; b=m/lKp85lhjA0BilrOAEROV05Yw+WQURYEXIPg1LQIbgwaoOjAjHcsRW9mM37iKYmbKLfrYR3A9ERXcuMxaH1ogaFfewJDwuAP3ls9oGR6IasDyEbDhscHk8E+w+MgPiNPVM2cpOmZv9XVvRypv4WgG/emF1p3H4E4bH1fsI4bR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403405; c=relaxed/simple;
	bh=iIumUiEHB5n8Rc9a/dlXTvUzePr7kRQbj5pr1iddyMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEwMghR9nXbYPO5kjKCobB94u2koDSgEFqAE5mcGcd/zGfP9d7CJW2owY43CGsgPUp7XMeiL5NLI+WlIT44dTYS9BXYPB26/JGGVPrweQRbKNkPfTJWj4WcSAh95WpwKWVuesS6Zeb5vVzgVBybnbfcOUcB7elW1b/LrwN7KBTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9OEYHX3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756403404; x=1787939404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iIumUiEHB5n8Rc9a/dlXTvUzePr7kRQbj5pr1iddyMU=;
  b=c9OEYHX3EAV+6R4sxdBQWCHftwELQ4gD/0H4BWkIUcTT+iBcyKpb4tHh
   TrZHoHmXxmUuXotv9wsyHjiEAPl//e3GssBHpvPX6dIHsccPOGGIJ/CqE
   283xQsQp0+15Q0jwMJJbxWlgmXA89mOCLoQprn0IFbP4j+/LHseJ2zrvs
   Oi0e3+kz8irroAHv+2e4mw15MNjZOG3IHntT5mfwkDZXDwZTC0o0cox4Z
   GuOxW4ir7CDhIJS4VN6hatqz9caBbDBKgtxTLHVVgjsMjsWo1dJlxZ0vV
   m2LHNi67i9kT08AccgbBZpFr/6hKYiNqXyWKrN3VarWPylbS0sfwLPTWt
   w==;
X-CSE-ConnectionGUID: WindpuJnTRWXDfV18qkk1g==
X-CSE-MsgGUID: 7E8CgOHfRHyycictS9IxjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="61318940"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="61318940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 10:49:58 -0700
X-CSE-ConnectionGUID: Hpxmm5V2T1ORzrqcZKuiKA==
X-CSE-MsgGUID: OmG9fISwQIKJS/PpXn1Ghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="174520134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 10:49:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 10:49:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 10:49:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.84)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 10:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDyOGRb2ZEdEUabFCFts33zUrp24w6H/sg7Z1NGJiYSbnSECUozkAxiGvI+yb3rNb2/khXtlwTcujlbP2w3d/4b1QafeGs6sBM58sxHU/v/srAnuznK611rpHPBiAwKZapghQIlXqiSHs4R6+afvpxRlD8GU0af7DGmIA5QGJPopLqinRY+ybZwVhRmRp1TunVzkQ34EWTrMFnSAjAPTCu3x0+Gr4TsjWLiH9D47SlvmxLTg5I1wOgWpGIeVKZrnirByhH/c1HEiRucCxhBuxqZyVN26dYKSPxoemFcIuTxEdOHqvULV7OscbIwTfbHjUkk3JMnra7fuSfJBKEQr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTlL97Ug6cFzq13XNF91OCJ/coY2U5vVONLl4WHhYiI=;
 b=okXsouEoA0xjGgBAPsJSWkkRRLfTZkC58ZVXGIufeGTZ4Rb4NdYAu3eOuShFPqXraJona/fN6Yr/wHXL+8nYVBMEjmXIfC66oNq6pnn5CBVuUwSypQDGWjqt3xWvHXuBcPMJfg8l6YS6cscZXZM0UZZLwe8fJxOVPqAEQLn8AHqaDRHbxgDK+ZKvx3BSaFqpqw/9xI4Zpx4VLmLWv4MmGEu6aqC2lnYZu8JRm/Ag7NU5gcyXeUNsxIfCTf19kR2DrVfayJes/y6+nNHupFGWSjeTwn/dN5Qgk9dhLwZlipuwzyFZ91vEZ2Iy4DU8SY4Mt9Cfjf97TjzTsdO8DElhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Thu, 28 Aug
 2025 17:49:43 +0000
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f]) by SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f%3]) with mapi id 15.20.9052.023; Thu, 28 Aug 2025
 17:49:43 +0000
From: Imre Deak <imre.deak@intel.com>
To: <stable@vger.kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"
Date: Thu, 28 Aug 2025 20:49:28 +0300
Message-ID: <20250828174932.414566-3-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250828174932.414566-1-imre.deak@intel.com>
References: <20250828174932.414566-1-imre.deak@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) To SJ0PR11MB4845.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4845:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: e94989db-2573-477e-842e-08dde65b44fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k7H2V+VI0ENY37JSWaftjWmFECfTTLr0pDV0XhO6Wd/rn7ymqaHxHUleq0u9?=
 =?us-ascii?Q?DpCUyCjry1p8R2nlAtoGZ4NvCt9E6gs6Wpjanl7zhJif2tzd9szOIMIr37vu?=
 =?us-ascii?Q?bWbMiBTR9N/NQrps5tPvWzpLFaBvS+SWrIWYbTC5F3j7Sm0MWaEX6odiKU7J?=
 =?us-ascii?Q?ewaNR3A0ug1bLNeg7RwLnLeOXhXbSAUn0UZO4B/uHaTV5sY39rjZc4QrUBsy?=
 =?us-ascii?Q?WUxFzMrkwWw+pTEgMrfnYvYpu1GSzr1iyTigHPOv/pdwOcxjvkiO63iMqxI2?=
 =?us-ascii?Q?TTEouJlE4oolHpXl7pTqpxvnnqFW283FfhQ8b5PvyKBL1I7AKHRYNSPVYr8z?=
 =?us-ascii?Q?HHHpCdGW9jDBQYHBU7WA/TSbvAt75YzsMOFW7RYL7GpO220n66OeSPl7JesO?=
 =?us-ascii?Q?SgAllJlT7nNEIFbMoHUWqSsV6cfSBghbHYjIDk6gc7J/tmpch/qD1qVcXePK?=
 =?us-ascii?Q?IB+ZvYdGgPjNXITCmgzbCVI2x86YxNJL0eY1fKEMDLsbz/+QbmkXJFBBkcKS?=
 =?us-ascii?Q?8bW77r25UjYSVd70Day63xEWYwWUwzJ9I7Xc7wTJA1zLR7hL1+n2bvwfzHgX?=
 =?us-ascii?Q?FbbpjAv3SsTxFh8mj5wIJCd99kQBSi9GRsMHO57lMD43qOUzMzDxCtbiH4Op?=
 =?us-ascii?Q?dFtu2ooUOmbOjC/tTMhMSsEqqOyRWTN67zosOArG/D+k7PcDZC076IJT5aNp?=
 =?us-ascii?Q?YaCvIp7F/Npw7lC09HWxrSB+TeP2EwPUWxBH0nOa/eJ3dex/5tqRujNUELlk?=
 =?us-ascii?Q?3aKjqR3hJxyWctIMsOSUsu6anJCNZtkeDeX7scGncIBA18yu/XWz3MB7HNSp?=
 =?us-ascii?Q?w3b4JwwbiD3qZYLBrvOMyKo404ui1EzXzF2jQx77wZgvtC+p9bC/8hpE/IxF?=
 =?us-ascii?Q?OWmJ7AcXdKDqN4g6Xg9WhqZydfmfyMiF6IFuivCKGQdb+lqF1zBAHswXUi9E?=
 =?us-ascii?Q?kAK7N4i6kqLrvUAvhJQE+Uye3eEEgA8LA5vzHyrt4FMI05UnJt3IZUmmZXku?=
 =?us-ascii?Q?mLwVQvnprkxLnbT2Lag4jjtKSUncKDTPmNc4ic/GdAIRGjpOTauRgxxHu6/p?=
 =?us-ascii?Q?D85k+Un8JzQ00vkdS/6VBvX09epJXs7NeLoVgow/HKuxZ4yC0VIWwlb3RhRq?=
 =?us-ascii?Q?yq9VzzHShPvxfm2t03cAlhi2PziQrX6TCzjGllDaM68ZMyGo2xyaEc0L5S49?=
 =?us-ascii?Q?gG9nDbLmyrYECF93oSLJb941QrNKWxNwjfyGv6M9u75maFCXCyBFpofvHF3J?=
 =?us-ascii?Q?RlPDJSpBqj+3yBLj8AY68zL3kZveXfKCojWbl/g/s+r6glnigMFOTbFk3OvR?=
 =?us-ascii?Q?e3GsphaeHzNJf5cQiu+s/+Xpp9I1smBHe0yGfu7+14wESu3shotaZnOZoaXE?=
 =?us-ascii?Q?xw2nR4c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4845.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+wMHLLk49DnTu9GN5/PDT8zXOmNxqnL+vpa4FInseHA73Vomu90Sq3x75NZ?=
 =?us-ascii?Q?xf0tqwVChKGBQVdJUZLktSji3NoCL3HtrI1jBzrdtyzV/nerNDW4t9mCFV3D?=
 =?us-ascii?Q?EqFVuBt0hsUtQINLS9q5wA1n0WjPUTk30jJ6ZDYI8E9GK7ZXbgbt+elaAzGi?=
 =?us-ascii?Q?osoDyR2BUqhX/r/3k7dKA9iZJauR9T8vImyCIYHWN9q+Gb3IeehSSm19MwbZ?=
 =?us-ascii?Q?S8kQy6I3zPq2IKNVEVFyZEzjkfFzRoIzZRmEEN5HksA4e/v0B7qvibpy+RvR?=
 =?us-ascii?Q?EhjroldwWl/oeg+oRVWIx9vZPR76IPvrDLHypvRCbQf+jDhB8BuUS4noSG7G?=
 =?us-ascii?Q?Rzo6E051ahlwlpQmisuwvaAGrs0PCmYbd/mhVMbc5OMrMf+xlgfLN4zeVlP5?=
 =?us-ascii?Q?osxOOMfdFKm1Yumx7RPdsaQtyWcBIFSRzifYXzD9i40aNod4LEUo88nsEmk4?=
 =?us-ascii?Q?jr6wM0C/lHeHCxVn0gd+juEKK+lvJkK98wXcstalbi5d7ExpNQ/GxKD17Krb?=
 =?us-ascii?Q?Sjt8g3pUO3txUtyOblR8339rE1/NjjNrTm0lOrI/w3D+WscD7fQ9yrjj+NO7?=
 =?us-ascii?Q?tCD0V3q3vCF/n1lZBEaKqsfy5Cj6uqAvScv6Te7J6y8rFFzod78LNZevyQi8?=
 =?us-ascii?Q?C3CyULioIO3OasyxZOAlyn2JEzjPMvBJHz68p7ILitYvf00WysSdGrBTqZoE?=
 =?us-ascii?Q?dy6eTqzxVazz0fScYcRpyym0+P5OO1bRGwy2B2fH/Jd89FpDxXqNz419RENY?=
 =?us-ascii?Q?TOMy45x/gu9EjFuAnF0lpcuBr6Uf+bRKFjpju4E96hZe2mT1W7V+CBfcx4Jq?=
 =?us-ascii?Q?mxOw7SyG7rQsO5jABoDl7+ADBOGEUDsZWF4W/HqSYid5mHP3F8ejIPUEMwsS?=
 =?us-ascii?Q?YcaluAC6zamJ1NAh/mm4ux8blKVFwRPFYo4nmBWrALLSuJjD67cnVoh+mk+b?=
 =?us-ascii?Q?wq+jDOLKSij7OaAHjytt8ZSNzWhP5jWpvI1gjt9xns/VlmeiIQ4pjaA6Qs72?=
 =?us-ascii?Q?by5HIASF12+va6n2HskVucCV3FsPo82zRaDbraRvkGtzVrI0Ks+DXaZUA3Z7?=
 =?us-ascii?Q?npoYSlff/PY/6aGSXnXGGhNrbhz+CKl2lXZNQ3PXjOL/TNMHWJLEiTTcQuYX?=
 =?us-ascii?Q?8qlfrLjfHXP+7jcCJVzWqeGffgeBDholc8vqzoJOJav3jo2bbUSk1tlIjn4U?=
 =?us-ascii?Q?cvJuhrgjL0Q4qt5i0Wb4w2J3bWO3ZHjCNbfRZ9PRgtSzmGLr1+QCbhXwVc/D?=
 =?us-ascii?Q?oabxYOQgnFndNmeZxFekfpFA3fdt8J7zDhd0tL0izy8NhYAGv6kWxoSaOcmP?=
 =?us-ascii?Q?wxO4EaySYodEcr72LT0xKmCorl3RwwWjMUKPnu14KsIrQYS8bMozSnRlqYGs?=
 =?us-ascii?Q?kTQkbjHJ8ZE4Pc74iZv4iVdd5X7rVgH55zEb1zEfUSHqOhkqeTPoby4TcU4e?=
 =?us-ascii?Q?Fjfi5cKJSOwddp8M3gJ+euR/KN+uatmHbNnERsmF8NGi4dordUv9YgN+x1MM?=
 =?us-ascii?Q?PH2GD1qP4FgCfSSwWd4OdXwucWR78KchRICHcTCBjLYwFQarmzlUCgD5Rbt8?=
 =?us-ascii?Q?QxTEumjTdI1NRlY52tgT6y+1KowufjiNhhMulJVJryh3CnKoQZfmNITdSUGD?=
 =?us-ascii?Q?/sWYG/6sPM7AuwNvpBfpnZ7Ixs74pcVlqvCyEnh1pGoH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e94989db-2573-477e-842e-08dde65b44fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 17:49:43.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U57GhzYFCHfXlECFEj4koudVvlBhIgQFlU9DDZC9cHKIfcQQIfgrsZcH+FfnAzaI26WRH4zczx0CapCSHvhF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

This reverts commit a19b31f854a8992dfa35255f43efd19be292b15c.

The upstream commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f ("drm/dp:
Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS") the
reverted commit backported causes a regression, on one eDP panel at
least resulting in display flickering, described in detail at the Link:
below. The issue fixed by the upstream commit will need a different
solution, revert the backport for now.

Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: Sasha Levin <sashal@kernel.org>
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14558
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index e830e461edd1..b8815e7f5832 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -336,7 +336,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS,
+		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV,
 					 buffer, 1);
 		if (ret != 1)
 			goto out;
-- 
2.49.1


