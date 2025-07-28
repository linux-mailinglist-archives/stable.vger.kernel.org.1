Return-Path: <stable+bounces-164884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E171B13525
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 08:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9289316E853
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F60221FBD;
	Mon, 28 Jul 2025 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkiFNIUB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7D2C18A;
	Mon, 28 Jul 2025 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685777; cv=fail; b=dC4xot14R0rS38akbE09Dv6grPqzsc04W5Q2UGh7n/XaHg5xAwwSCJbtGk0vmB0fBDQtJd8jX5R6S01U7sKxc71FZ5s4PNofCk9ssr7KqvoUGIQ/t55oIK6JTWKuWAfqT08nLR258T/C3Qt9015PtQsNpakcrBkKXLKK5IJyn6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685777; c=relaxed/simple;
	bh=o961XQ/TS/x4q7HaGrvetcZxcFzETFzc9/mx4uBP47c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9RMVn32SO24CJDwyoPQAlW18BJxcyOh49eGlpdxSTWvsA68vUaBVWuVSA1amHr2j0xQGrR9JAqEBUnTeMjMtajQP1nf6Sk9TRZ0/GuMG7+7dPBGiPblr6xotykmj3RzxHEB92gYmj68Bqq0pIZ2q+yPms2E0onsoLMjf/sVH2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkiFNIUB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753685775; x=1785221775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o961XQ/TS/x4q7HaGrvetcZxcFzETFzc9/mx4uBP47c=;
  b=JkiFNIUBJGmb1VLu7IOMU49mG7VsCwH2n9g071aFIsjeUjUse1/igRc+
   unTmRDE34cjsqebS9L0N91tagjfrs/dTd5kEz+hsqo1YJcCZ/LMjWZKiU
   cR3Nf0PfTRsAw5eDmg2nzQ+O5KpOE/sA74ZQ7Vuou9lZzDc8h6yehtZmF
   6DGZgLsxKmPOxPDRGecuM3jDjdm3otogGY2W8WhqpaAWWNg90Zoj2vzCP
   vni4syPnPEQbymgE6ktn1BOg5lrSrsb+lmA3A+t7EV2AN7BOBvd/zv7sa
   4Ra4NE9Bl66sYgZBWqX0X53GnKNRcQ2SKGPStVHJiP7gB7rpqDP2bx6Ih
   Q==;
X-CSE-ConnectionGUID: g6JR8zb5QeqPt4HUMPD/Vg==
X-CSE-MsgGUID: RYdADjjgRXOO5CKXfhatyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="81370963"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81370963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 23:56:09 -0700
X-CSE-ConnectionGUID: ZgJJ0/TFTFS0eG1vJVq34A==
X-CSE-MsgGUID: fH7JcCfzRJyj7v1hzoGE/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166816671"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 23:56:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 23:56:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 23:56:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 23:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri0q5OsYOzZ5O4ktBwbeD7hdXcEnZKs8vThj/2+O/UVKqHcTu+0dhxwQnprZVeKaO+hV+dbQRB/SZQX55s0JwT98n3G1wiSgjyniabL0waX1W4WjpVri9sGhkQ0pSFywm4/HiD2886EoJ5aso492Wm9Lj4dwIW1CBfRI9e+OgjgOauIqzxuKRS9N1DjaHbw07OWCJ4WEOEkyy9DsiUEU3AfPHn0v9dIjHhV6ukLuD5bD59AwVJCRcz4yDhBv2fGvjFitq6KjCYl3GRpTGWfwXsKkSYj0GgFU5b/R0HhnzR+X7QPkx3GXnwgt5P6t5Pw4/jwqxut7bm5adfLx+WX+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49JYpEnsXiuExhlyRxj94rb5oUZCG69fMQvdojOcOAM=;
 b=WQGNAqxl+j920HVFh2OcZIsDTU1UEEwkp+KXJ1H/RPxanfjlL/e19X+gtaD4OynAScRityrfTcApzu979Aec5AejihOwHQDzo9BB6WjEw+XnGm33KgYK239bdPJoW/UsE/ot+PQUk/45s66z34w5ZDmp/UAQje4eN7EV+fdpDQ9IJe3LWKVG9IrizYNRaf6lcUAxk2Pa9qDcT1yxZutqPhTBKU7Lay7a7ZPxFNThZwTKISuSHx8SR1OOsx2i7q42MiKcxCzwLr/ly5rmLVsTWUw+O/V+q6SZXB4uZ5eL9HD3szF1LCrSNWiuLTRuttMQQMxyjjZDkGvOoVX3morS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:55:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:55:23 +0000
Message-ID: <ffec6f56-bdae-4821-adfc-c6f0323620f3@intel.com>
Date: Mon, 28 Jul 2025 09:55:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<stable@vger.kernel.org>
References: <20250725105257.59145-1-victorshihgli@gmail.com>
 <20250725105257.59145-3-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250725105257.59145-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: e77f0aa5-3082-44d2-2210-08ddcda3b96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTltVVNCRnRmY1lyR29zYUVhNmt1Wk10L3IyWjY3ck5JbjJHalV3dVc5QWdD?=
 =?utf-8?B?Mit5Z2lDb2Y3VGFhbjlDd2k4WDNyVVBBbFphaHVqY2gvMTdmTUZtSUY2bWZ5?=
 =?utf-8?B?VmluTzNmZUMvdm5oeG1iU2hGbnRyTDlnNXhiY2pOd09nSHM4emRpQjNNU3Fs?=
 =?utf-8?B?aCtQTTJ4ZWFtRG90dUc2a01NK0RRd1JHQ0tOK0RGdnBoVG5TcjdiRWlnSzdq?=
 =?utf-8?B?L2oyR0pDamx5T3JvR3VxSVNUcHJ4OXFUWUFTQTRrcVM3a1pnNGNTNTdSNzJ2?=
 =?utf-8?B?aHp0bi9MRDB2UEFsOU5nMVYrT29ocDNxU3A4SVFvRHB1VnYzYU4zNEg4VHds?=
 =?utf-8?B?WldjNUowME1ENEhUTTV0UFhDV2lqSmdPcFRNM1pjOStOekRvd0ErU2pJRkp3?=
 =?utf-8?B?ZmhDb1k0amFDZnFIVGJhZGp0ZXhtb3Z6ZHhnTUZ6dklSSDJudDZXQTEyaTZ3?=
 =?utf-8?B?Q2c1eTlhTnNTbUdnMjN5TS8zNmNFLzVWS0N3UTB4VkRQdEdzMGE3Ym9nZUkr?=
 =?utf-8?B?ZGtScDRRN3h1UmJtMVpZUVZLZGF6K09yWHUvMEhWeXJDL0phK2QxRVFhUTl1?=
 =?utf-8?B?VWMwZW5iL2RoUkFuZmNJZnNJbUtobDNTbnQySEhKcWxsWkRIZEdsVGNZUVYx?=
 =?utf-8?B?RVBabUNCWGZOODJrcndrb3IvNnNyT0VqNHRqTFM4ZnZjd3dLaXE0UnAxdzda?=
 =?utf-8?B?cm9McWhpdmRWeGRQOC8vY1dSQi9Pc0craW5vMU40dm41VnJDdS9yQmRKdTBk?=
 =?utf-8?B?SVhaWjd2YVp5aGI0MFI4dDhNMUFZeCtOOUpvc1NnblNQQkZuTnpTZkNZQU9t?=
 =?utf-8?B?UDNoT1BaRjlock1YKzVtQmJNSjl6N2NrZFhWWGN2bmorMkJzeFZpVkxxVnhT?=
 =?utf-8?B?aVlvbWJCQnUvUmRST2ZvK0p0UmwxUkNZZitWMzFEWEVJMXpEVU02UTZvRTRy?=
 =?utf-8?B?RTJ0OGsvWVB0NHkrbUNkbVdEZm9CVFh5L0xFTW0yMW95b3BULzFoZDE2eXlD?=
 =?utf-8?B?Nkd2QlpLOVRzaXQ1SFRMSzlZYjZIamQwVS9Vd1VaVEk5enpsY1FoVjdneEdu?=
 =?utf-8?B?R1JoY0dkNGtSZURWYUdrZzI5ajlsK1dKQ1JlcHVzeElGMDZ0OXViLyszTVlC?=
 =?utf-8?B?RDNpcWRlRmNUMTJ5RGhKbWd6M1M0UmZ0dGV3QUhoUVZ5b0h1cEFWaG1MREZV?=
 =?utf-8?B?cVc0UFlRNEhIMytnQmZVUGRRVHdqdGVHaGg3dnhrMzRKS0h5RjVmZEphdk9E?=
 =?utf-8?B?eERzc1hsNnVhd20vRk8zaGFwRlFrTlBiZlNKK2NHN2pDaWpZYmdXOGp6QXg3?=
 =?utf-8?B?UmVMQmMvaEVaVTNiMGtJYlJCTytqbU1nbys0cTJETG16Zm1SaXJ3dXhFR0dG?=
 =?utf-8?B?UUJBTzAzK2MvT3k1TzNoK1NJR2NGTmxUTTBFTHB3dFFXVzg0KytXQUlkTUdl?=
 =?utf-8?B?M2lNSTVyVUpMK3dVOVpiRWRWMy93dFh2eXpuTG1JZlYvYWlZVTRobUtqNHpE?=
 =?utf-8?B?Y204THQ3NkRrN2RRYXhRalB6NHRyQnQzOS94aGtON3B2SXBIdVJUSThiTU9P?=
 =?utf-8?B?aVk5VHBhdDd4a0RLKzNYVkFSZlRkQTdsRmlSelVyQzlkdkMxbDlNRHlSaHVy?=
 =?utf-8?B?SU05ekpTR3R4dXVLdFRaRkNDd2hrdW5pYUF2ZTZpelFOcEhvN0IxOE52MkZn?=
 =?utf-8?B?YUJyMldBZFUwN1E0SjJvZ29tNUlhTEJEcnhDWmV6ajcyU25ZYzNMTEVSYW1N?=
 =?utf-8?B?NCtDOHdJUHJYV0ZXcURYUjhnN1BvOGlyZVVCWWlMaC9GWUlhRklwM0dFVXNx?=
 =?utf-8?B?UHJSRG41Z0lkeENMcDRiTWU5elZiUzg2MGlCNDVlekZPOVQxUXByMGJ4ZkVJ?=
 =?utf-8?B?bStGSklvRndLUkFUWUhkVUlPM3dPNnlkVGFVeWxtK2hEeENJU3JGeEVONHBr?=
 =?utf-8?Q?O2LR9tA/2ac=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdMSTZNNXlCOFZXWFh6NU9TY2YydkFGWHBRWHpEWVFWT1dYMldjdXB1ZGtD?=
 =?utf-8?B?dktNcTUwTHdFeDBHWnVONlhvcWQzb3F4dXJCWUxJNGdzM1ZPcDdXOUZCbGpU?=
 =?utf-8?B?Q1g1Rm92KzB2U2VSbmRUNTFDeS82VCtIZXJzUnk2WWx6ZUZCdjAzTUZDK0Nq?=
 =?utf-8?B?RHdPK2tJRzF4dFI5K3pSNHd6MWhUa01JUmljaWUzOG5yNnQweURPNENWRklu?=
 =?utf-8?B?K04zWjhYVXdKMi9yWkxPSHpKYWVDWjRiNTFxcUs0N000bnBKSWw3Rk5JWG1a?=
 =?utf-8?B?eEExR0FZQnY2NlpVMFA5ZWhTY1lzbkZlTVZiU2NxbDVSRFVXeVR5SEtja2JD?=
 =?utf-8?B?dHBDODdsNHpsRE1JZXpqQi9xcTJ0dTRnVUtVMXFadXd6QitrS3pkdFVDZEZ1?=
 =?utf-8?B?cS9UVWsvc1NTc2dIM0lFNzFEZkxBd2dYRDdhYXIyY01XemxpcklpK29rUXRh?=
 =?utf-8?B?L0dhSDVzaUNCZkJFdU5xcDFMVjJIeWlxT0lMVG11OGI4QmRQdkFjRWlUblFY?=
 =?utf-8?B?UXRCWlZGeFpYNlhpakdQVHZibUViZmlIMzZ0cnpIaUp6R0lYckZhdWtPOVlq?=
 =?utf-8?B?alhOdWZBMWttN1ZMRFpCOGhuYkl2RUZ2QlNhaHJBUmFmK1AzcGo1U1FVa0lZ?=
 =?utf-8?B?cHQ5NFpDRXU1MjZsTk5qVWRJUHIwUGxOQmhrbEpRUlpzTVdZSkIyK1lzMTFE?=
 =?utf-8?B?Z0RsZlIxRVQzL01ZZHJIVW8vVWpRUVo1c2ZmWlZFdWIwRmwzM2JlOTRseDdl?=
 =?utf-8?B?SVV0Z1V5dzI1VXBKWXE3SlZWdXVwcHRwMEdGUTJRNnJpQlM1N2s1Ykh0aW1G?=
 =?utf-8?B?M053T1ZTNUlnYnB0bW9hMFJ3SVUzRG05MHpzNWJyZ1YzNGhxZGhQVzM0YWl1?=
 =?utf-8?B?dVdObDBteHNvM3BkVTZiRVR3NURNTUQ5Z0piN1NndFdhREQ3Ti9TbGVLckpq?=
 =?utf-8?B?NlhZTUVBSUtrUVJTM290T2NoKytWYWtZeWFIRGV6cmJRT1p5NUk1OFpzSWhB?=
 =?utf-8?B?MzNJK1lIbXVRbFRBZFJwWVdJWkZNM0FEbm5MTVBWSlV4RnE5RE9LUkFqVmE1?=
 =?utf-8?B?aWo5N0JlMkRWYWVKTEhvUXNXTmdFeWxhSGNLMDk1dHFyTXBiV3V6L1BvVE5t?=
 =?utf-8?B?QjNXSjhPWDVsaWhzejlMN0MwSDBoK3RKNjh3K2l5NS9vTDlFc1krT0FGVmM0?=
 =?utf-8?B?bTMxRVlCL1dpRmtiWVp3L3l0YzhzVStaMUZXcjNsZGh5ZUNBd3RvYWp3L3FM?=
 =?utf-8?B?NVZzWWxzL2IyUGQ5anBHUTBiYW5XZWNqU2tqYWJ3S0s2VXUvMUFIZnFrc05M?=
 =?utf-8?B?MW5ZalZNQWdmNHRnRmh6a3ZvNkpacmRRYlBDQlRzc1ZiOXpQODlZRGlMTWwy?=
 =?utf-8?B?V2hBMW5oQ0F0U1FTWXZLZEtFZEl4ZC9VSDUyQnAvcUJ0K3k3K2FPcmNyY01z?=
 =?utf-8?B?aXl0emQ0c3JBdTRhSDQ0QmU2c0s4SjdKQ1pTdHFMalUwYmRBYnNCQmpZZlRj?=
 =?utf-8?B?UWp6MUlxT1l5OU1hYXRnd1VOVDRWb3E4M0FBL0V1RmdBdmErNEdTRmZ5NkM0?=
 =?utf-8?B?c2l3TlJTMEVoaFlRSE1QUWpGNHRWbVNGSllKNlA1RngyNVYwMlFBUXdjbldw?=
 =?utf-8?B?MlBKVm9SVnhNckZqdUF2MUhvaXpBSFhvT2owNDcwVklrQ3RtWHZJNkVJd291?=
 =?utf-8?B?ZkFBN2RiMExTSlY4ZVRZTjRkajl2YitvMjNUd2tITDlzYkFUVkJ3a1U0V2RI?=
 =?utf-8?B?VWw0MlE2Y3dSZDMwRFI1OFZaTmFjTmRQUUx0Yk1RNkw4bU0rNUZHTTdrQzhU?=
 =?utf-8?B?OSs4d1k1d1JsMUU1c01qdTlud3ZVWWE5VS93dzdra1QweDc5RkhQZnpWamRh?=
 =?utf-8?B?RHhWaWxZWlpnVDdCaFZqV2FXNHN0Vno1ekdBMG5LcW8xRTB3ZGR0VTNJQyt0?=
 =?utf-8?B?UkV2ZXhwVlF4TU13UTlIN1FVdHp0Zlg3ckhJNjhPWUlENkNKSm9SUWE0NFhQ?=
 =?utf-8?B?WWdhRzZFdUpUS0FLTU12OGowSmdzaHA0ait0alhVNGQwYTJ2ZkptbkgyM1Z3?=
 =?utf-8?B?R0FoeXFTZ1lzQWtVOHJJcC85UnNjak5tVFQ3SGp2VkpXazNkTVcrb1cydWZD?=
 =?utf-8?B?MlBDd1lqazgrNDVleTFwc3Y5ZDNHM1pJODRaRUZqTFB1WUIxalN4VG1BL1Jx?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e77f0aa5-3082-44d2-2210-08ddcda3b96a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:55:23.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arFQ2NeWnKh0KPXK7Q99zYuJNEOsiN0nu+/RUQSokyJoJ1jf6h3CNBao01LGkp5wj5F/I50Gj2SItIGj2MPW7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-OriginatorOrg: intel.com

On 25/07/2025 13:52, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Due to a flaw in the hardware design, the GL9763e replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9763e
> PCI config. Therefore, the replay timer timeout must be masked.
> 
> Also rename the gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Should be a separate patch

> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

It is preferred to have a fixes tag as well.  What about

Fixes: 1ae1d2d6e555e ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")

> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 98ee3191b02f..7165dde9b6b8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  	return ret;
>  }
>  
> -static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> +static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
>  	u32 value;
> @@ -1782,6 +1782,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
>  
> +	/* mask the replay timer timeout of AER */
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
> +
>  	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>  	value &= ~GLI_9763E_VHS_REV;
>  	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> @@ -1925,7 +1928,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  	gli_pcie_enable_msi(slot);
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  					gl9763e_hs400_enhanced_strobe;
> -	gli_set_gl9763e(slot);
> +	gl9763e_hw_setting(slot);
>  	sdhci_enable_v4_mode(host);
>  
>  	return 0;


