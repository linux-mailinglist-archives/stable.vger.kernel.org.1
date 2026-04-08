Return-Path: <stable+bounces-233757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNW7KlXj1Wm2+wcAu9opvQ
	(envelope-from <stable+bounces-233757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:10:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568183B7139
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D19F3076A1D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE15355F47;
	Wed,  8 Apr 2026 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvZr+7AH"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14434EF03;
	Wed,  8 Apr 2026 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624797; cv=fail; b=EW5pGwryZLBXXDnOEnD2aaE8DrqEPHi7r80rUwX5uUSQVnjed6kADeXYfCIZWGzp/kIv4HvSRbF0GnBEz0aioPYyJQJE41NY5e6eZ7nRqrJrLGQGo8lI7AgWljVidC8ceKFMflYl/kysZfKXse5/5jKw187DYC/uN0dT0tFNiuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624797; c=relaxed/simple;
	bh=UDF+ZSu3wWOQ/sIS13oW5JePTdYGjxdwNT98lQkDPig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uebC4LkF2jFwVfoUGWc4r58TVi8jYYM2XPQeDAnq8t0nCIKi9keYM8BlH/0dvSe7BxLwge7io4jC3fAub+wgNiItETvBvyrdwMLV+TtYsAGeUGq63+Hxjmp6XA5AYMUoUCVSigC/3YX1dn9gWd+1ny+5YfTVr51a4B/JJBxfypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvZr+7AH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775624796; x=1807160796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UDF+ZSu3wWOQ/sIS13oW5JePTdYGjxdwNT98lQkDPig=;
  b=bvZr+7AHsXzZaFTuSmiywgwBaux1e+BVz/1s4ZUCcOwk0AUJCOKU+0Gg
   lfxfcuxXVGuiHB/eHbnSYATz8GUb95bLILQM3N7h1SKTS0WpibWJ3IH9e
   MWx1PiBGp5h9dP4F/AscwTpph4fjIrVkz0qgYvEL4NWG1FwUCeLjiaMSo
   /dOCr92cSunHhiQAfJprh3ljeayGDfxlS+LQ56rYmqvyNQS9qCxDqPE2m
   2koppzvG58zpdtVDe4zscxM0jruhINtdIoKG32QXPvTICFkyiDC6iJtmp
   qq8j4+4IBAWm53FdOosW+Uj8pbouypDeJmDTGobIDk+3uBZr0cwzYexr7
   g==;
X-CSE-ConnectionGUID: b8PbC019TyqXBlzDnbbscw==
X-CSE-MsgGUID: HHQ0wvHjS4OQeHf6OBYoJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87296648"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87296648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:06:35 -0700
X-CSE-ConnectionGUID: 2JtG/FE3QMmw0oHaydmj5Q==
X-CSE-MsgGUID: 7vAFbn10TOOs5cU+oeGw/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="227529216"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:06:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 22:06:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 22:06:34 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 22:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqminqEF9dvF2KRyml0yBxCM31wSKTnkBN2FnSBCOFyOGiK9XHvKVCk2AavDikNf0pHOzg+PCnY9ewO6clIV/VPZVLr7ulKuEN7adVUBUQWprY2ra/EkazSJ/FvlXB7fEwbIajVD9ZXYJsK3R1gOH2E72Yq1DxhuFnhcDF+zT80x0ehnc1WP888ROIAKZt3EZwX07pwe2oYm1b9Ap3bOZH8EZL8zi2uo7OeuGCPPRI5dPnBO6+0HupfESmmd5P0j8IGt4P7V1HRwC+IyTip4Qf5CstCFrXzzCS8ycM+fv3iiAehb/tuqmShgC964wPj5bj8LH/cgYojoTJYhiPAQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqfMg8nO0ssuhgkf80Vec1maSncTfMskPd6dMhOy2tI=;
 b=KMK9qMh4w8G3S+e/gStYNfL4nOqzUwnNk6xCHBn06oQV+AJ8efgMO6Psr+EOB44klxm2zPn+Q9bSnhuA2g4zfX7sG3M/zeEF/AqDQz5Nr3riuqeB2y2+Hg00xOmWozP5kIrIf3lR1+yYfygcFJZF1MwRH9/AIBaTy9NhqUGYQXYlPL3rZeBBuzLtPsvyis+xNEuEwI7DHMyKjlGlwX0ssTZxYvE7n0Ubb0mBkj+FTY89tIt+jK3Ppa0GbtaQdyrQZjjPfRY3oif198kxWLV7ykOXA1VfyZitfiJY9a3Y0wtBfgMQRHq8Kon/GAYHt21eSRuTNekielzKJVtVt9yqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:06:32 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 05:06:32 +0000
Message-ID: <e443c467-0d10-41e3-9195-793ad8d34662@intel.com>
Date: Wed, 8 Apr 2026 08:06:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL
 configuration
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<Stable@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1775014742-233407-1-git-send-email-shawn.lin@rock-chips.com>
 <da3b1b9c-fb92-4408-bb5a-485c050f7c60@intel.com>
 <a9c5d50f-b09d-2aa6-56e8-788675a7a8d6@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <a9c5d50f-b09d-2aa6-56e8-788675a7a8d6@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc87dfd-1ef6-4631-04c8-08de952c99d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Xkl3e9QuLGje7C7iSxOHgXuuSSmka8U+yrhXveeg2ZqCtBafNUK9p5jsrB8GlHlhSs3uSsSd4D0i+jJKUsxrpuAI9Oh38HrhS9YVtX08HNgGS7qFHE+pNY3aIsjgdBSaZgJ5C+vJlkXenziBOl9aUhq6PHJZr4+Y5I9GFu4K6pPwGWiRNSu5nA8vlPayU/IYonJz74gptsO0wvyH1QdpSYM5ZFdBOH8bGhAdUmGDVbPOuQZk/myfi8xdYkNXxpudlVEfFmfqeCm6JcWN9M63WmweCDfp5lphsZw0QpQgijt6HbNaLIMinwtmaD1Zn+iyNrkO33n7IJqenXz1+zBMLLI3fS0mAEYMm7kjmKwv15NCwqRnjqPWORLUaNuLENM6l0UlgoNRS7vyKJJ0cl+gT2Gj3ViHrzd6VOF6IhsoiQ8X6l863AiEqu6e1V4VBdlKx+77VhWXfdJzyDwD/aZ86kpJ85caSqU1/JjSQUACpFkORwz5nz/XKPWSDnZiF3LgO3ItFMWUg94RENWjvSmJWrMLY8kmD+lRh7WZ4RuOYg4tbH586nICr0EQNSxZjMQxgdeoNTfFWQqBYcd8g2353LfgB7bGpvcTVZpPgkucAc0BmGGRP2sCB6+KsHPCc0yLr+nmLjnSFooYIx5TUh4gWePrlMaiPcycxgsvHBQwsImp8oJV4RSsSHC2xm/d/WWvuAE2Q6wZetpfNq3bYa2OvZgjCSS39XYwGcEgfvQQwws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VPQ29lcTFmUXl1d1dLcWljd0NWMmludFlTMCtTS0VnRkdDaStYekVrQ3h1?=
 =?utf-8?B?L3UvNzVvZ3pHekZIdENGTFcvR2lkdmlYbmhvVFcxNWlyWmJxWUdwRWdtaVpB?=
 =?utf-8?B?RFd1TzhMUXdTRGwyR2tnTGdqWk4veVJrdXZ5VUZZVlhWTkJpNHE1eU9IQ2RN?=
 =?utf-8?B?TkZlSUkrUWJ0dXBQSGpMbVdxMEYvUC9TR1p4TnBSNktpYktPYVM5WERLTUR0?=
 =?utf-8?B?emNGTkwwMklndXlseDZkdVR1TkQ5cnpFY0xZZ1lnSEI3RVJ2Z1hrTDVYVlFj?=
 =?utf-8?B?cHY5TWQ4ZDZmUDM4djJlMy9MVkFZMHNVNmtFYTUrR3lLMFdpeUpPdjE3cWNX?=
 =?utf-8?B?WTRHWW9kbUE1Y2NUcUd3RjR3TGEvd3hzMHAybll0RndZb3E1eVVHRVgzZ2F5?=
 =?utf-8?B?aEZyR1VlOTd3SGVqclRLVklFcjB2dWJ0ZjZxaWZ5RFpraDlLWlhoaDhNQVl3?=
 =?utf-8?B?Z2NJelhvTkk0bE8weU9BN1RUdTRVWEhRMGtpQUZuUS9tbm9YR3hDb3hscnFT?=
 =?utf-8?B?MVQ2QjB4RldhTi9uQUlxbXdsS2htL1UvbVRZQnJodkNwdktDUVRLYjlObGEz?=
 =?utf-8?B?Y3g2YzJaTjQvaHFhQ1MyQzFZQjkvVWVGOXM5MURoTERYRGdOcEY5Q2ViMVVq?=
 =?utf-8?B?MFpzNUVsOTg3RDJSSWV4dHd1eEZERDRTWmhWOEpCNmY4Z3I0RE94Z0dzVm9x?=
 =?utf-8?B?NlZPcktYUWxZVlQ2L1FVbU0rVVVmbkEvQ2VrZUpHTnc4dkloUGNBMGFMWnI1?=
 =?utf-8?B?cCtyQmx2VVF0cG1XWlNmd1lnbE1NN0NnRVFiMElKcmc5b0F5YXN5dkhSWGdn?=
 =?utf-8?B?d1VORDIvUHI5Qk04M2lUL2hMWXdLb2JUZHltU3FPeU1HeDgycXk0N09nVzdK?=
 =?utf-8?B?dzdOdGpBa2RRV0ZiekZTOEcyVkVDU1JpL0FGOEprRW8rWkJwMURUcWMwNlk0?=
 =?utf-8?B?amRkb3FvajQrdTA1Si9vSzdjRmFKSCtWT01tN0JDdHpsZlEvbDYvWk9uVmR0?=
 =?utf-8?B?eFVnb1hGRElUZHVyVVFhUFdRTVlwTFk4eXdNNy9EVUErbWtlKzZKWDIvZXgz?=
 =?utf-8?B?UVp2RzMrbE9Cd1EwQm03RlpoVVZUc2dCRklYQm9GdHNzd3JPcWdmU2hXZ0FW?=
 =?utf-8?B?TFZqeUZ4L2ZZTjNDeC9kZmx3aXhkYmljbFFFcEhHVmlJd0FSMU54M3dpdmhh?=
 =?utf-8?B?VDlqYldQMGtuY21mWTBQZVNNTkJ5WlpUeUN3RjI5UlJPVTc4K2M0Y29NTGxX?=
 =?utf-8?B?Q0JibWx0czhoRzQ1SFdJb2NrSWR6YmNCTUFxbi9tQXI1amhUOTRyZjIyRVJm?=
 =?utf-8?B?dlZ4Sk1paGpoaEhnSmlKdmJEM0dIcHRtVjhDdlpqYUZvU2FNT0d1S3NxaE9v?=
 =?utf-8?B?a0NNNWVEQjcydTM3N0dCb0JWOEw3anNrTFRndEZTVmR0L0tVSGd2UkQ1aTll?=
 =?utf-8?B?QVFKMXlWRVJYb2pPUi9kOVlhakpsUll3VFd1NnNsV2ZQNnNrSHd0UDZQTnA4?=
 =?utf-8?B?enFPRCtCRzJyMUk3MFBOcGcwUHlrNEZ3eFlrWnNZbEFXUURCanVRSlJ6V0ll?=
 =?utf-8?B?aVN0aFh6L1dpWGt3TVFzVFVTMzh2cStZSUpSS0xmeElMSGNmNnU2dHpGQm9y?=
 =?utf-8?B?UmNzVGIwVVF4UHM2ZlJhYlJOTDFUaTZra3FVQml0cWhaRGplV0RTcEt4eUE4?=
 =?utf-8?B?RitTMXpqcjNwOHJNZjRjV3huQVA1Nk1tMjFhZTA3TVFEYkpRWUEyaVVsdU5m?=
 =?utf-8?B?UVMvZFhFZmlCV1pSUXZNdVVKQW9NRG1sSWR5UkRnQ1VSbTRSdmNwWXNFRWxW?=
 =?utf-8?B?SXZiaml6NDZRR2FRdm9NMWgvMWZIWDM0cDRMV240bFNKVkg0K2M3V0luQVlD?=
 =?utf-8?B?TVRreTErVmFUQzkxVUVCL01IODRnMWtjcW9DM1g2KytQbHVDWDlPbjhXckEx?=
 =?utf-8?B?aFdXczNuaURYN0RTbjIybTR3UU9pS25ZcHNBdjZUcVg2Zm80OUREbXQ3VS9v?=
 =?utf-8?B?cEpSU2RtdWJrT0N0TGUxenM2akIrTVQwQ2Ntand0U3FRY3FlU2R5b2RnclJV?=
 =?utf-8?B?OWtyUmRsblZIUDJGUmIrbzZiYnBYM1VPa0ZWZmtRUkNHdmFOTUZmSzYrMUNQ?=
 =?utf-8?B?anQrcnQ4QzYvVU85UlBxeGc1OHMrbmdaOWVycE5nRFBiS1QydnRTaEptWWdH?=
 =?utf-8?B?dUdRRzBQQTRRZFhLUm5qSGZMbUZMWGEwK2tuZzNUS2d4bkFabGU4UmRzSzdw?=
 =?utf-8?B?VUk0Qlk3S2VSWDdDR1M2TkZkY2MzbWZ1WTVGL3lpTzBnR1lCQm5haG92Q3VV?=
 =?utf-8?B?aHZHSUFHSy9rVmE3clF4UjNjWWVrcTFON0IvWkI0MHlHaHd2Q3ZUbFBlYnM5?=
 =?utf-8?Q?j7IlM0iaOoBzlhtI=3D?=
X-Exchange-RoutingPolicyChecked: Z92HDS41sbrKstmrTLP5lP3SvMAiaesHFuTln+AyO2P39LJ+768g+iv9uhFR/ObzIp3h521EYqtEdgG4HPBLcL4oh+uJkgptESo1f2IcZfTkRYKlDFXbnrqPPcV9YBSecPTELSIHJyAaY3qlnLWN1ia4Xuj9AYREQo18S2+UrtbKiUFli0Z4AxBOYYiRGNoAB29+WrXP/3EwhJiAs5fouVKcUlF5AJKcnHDYot/Khz5OnM9hawCZCCVQJPIbnW1MaOPYY6/FsieAZNyMwxizJUXv+p2z4QnaPMRpbTaaII1B/VG+wNj/A/RsaXyEI4sTHOslCKlTl+oQBb/UOpk8Xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc87dfd-1ef6-4631-04c8-08de952c99d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:06:32.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVtYBAvmKfvA9NywBIITM3ze00zlhU5X1flOIwn3GWpBHrnelGc2VUvRKyfk2vBoIW8vyQ72HvVhcyDNtYbHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233757-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 568183B7139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/04/2026 05:18, Shawn Lin wrote:
> 在 2026/04/07 星期二 14:38, Adrian Hunter 写道:
>> On 01/04/2026 06:39, Shawn Lin wrote:
>>> According to the ASIC design recommendations, the clock must be
>>> disabled before operating the DLL to prevent glitches that could
>>> affect the internal digital logic. In extreme cases, failing to
>>> do so may cause the controller to malfunction completely.
>>>
>>> Adds a step to disable the clock before DLL configuration and
>>> re-enables it at the end.
>>>
>>> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
>>> Cc: <Stable@vger.kernel.org>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>> This is bascially a code sync with the downstream vendor kernel which was been
>>> done this way and tested for some years to confirm it could fix the issues in
>>> all corner cases.
>>>
>>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 6139516..e3ae334 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>       extra |= BIT(4);
>>>       sdhci_writel(host, extra, reg);
>>>   +    /* Disable clock while config DLL */
>>> +    sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>>> +
>>>       if (clock <= 52000000) {
>>>           if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>>>               host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>>               dev_err(mmc_dev(host->mmc),
>>>                   "Can't reduce the clock below 52MHz in HS200/HS400 mode");
>>> -            return;
>>> +            goto enable_clk;
>>>           }
>>>             /*
>>> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>               DLL_STRBIN_DELAY_NUM_SEL |
>>>               DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>>>           sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>>> -        return;
>>> +        goto enable_clk;
>>>       }
>>>         /* Reset DLL */
>>> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>                    500 * USEC_PER_MSEC);
>>>       if (err) {
>>>           dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
>>> -        return;
>>> +        goto enable_clk;
>>>       }
>>>         extra = 0x1 << 16 | /* tune clock stop en */
>>> @@ -868,6 +871,9 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>           DLL_STRBIN_TAPNUM_DEFAULT |
>>>           DLL_STRBIN_TAPNUM_FROM_SW;
>>>       sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>>> +
>>> +enable_clk:
>>> +    sdhci_enable_clk(host, 0);
>>
>> Should this be 0?  If so, needs some explanation.
> 
> Yes, passing 0 is intentional for the Rockchip platform.
> This controller on Rockchip has SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
> set, indicating that the base clock capability reporting is unreliable.
> More importantly, the sdclk frequency select bits in the
> SDHCI_CLOCK_CONTROL register are actually non-functional on this hardware. The sdclk frequency is instead set via clk_set_rate()for all
> modes. From this point, all of the sdhci_set_clock() calls and in
> dwcmshc_rk3568_set_clock() are also served as enabling and disabling
> clk only.
> 
> Therefore, sdhci_enable_clk(host, 0) is simply re-enabling the
> clock without modifying the frequency selection bits, which aligns with
> the hardware's actual behavior.
> 
> Technically speaking, we could save the previously calculated sdclk
> value and pass it to sdhci_enable_clk(). However, since the frequency
> select bits are ignored by the hardware, passing 0 is safe and
> functionally equivalent. I could add a comment for just this line change

Yes please

> or would you like me to add a comment for the whole sdclk stuff in
> dwcmshc_rk3568_set_clock()?
> 
> 
>>
>>>   }
>>>     static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>>
>>


