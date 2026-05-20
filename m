Return-Path: <stable+bounces-249914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL6sOASzDWo62AUAu9opvQ
	(envelope-from <stable+bounces-249914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:11:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F258E8CA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D7C30075DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0A43128B2;
	Wed, 20 May 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpsNIiMJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA52D978A;
	Wed, 20 May 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282253; cv=fail; b=SzFCvFTkrirdon7bxQvNuPNuJ4DTUpOTm7OcceJEDV0VgelPC8OuQSck33SVTkNBTPlqCLGFTsp6KKukLjgwllQhbbKSNkFPMalId8P6eYMavy1Xq3PT344Y5r/tLWgSTeOoP7mNnihLkgfodGaEt2nT9dsd/poSIOMngWWOoyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282253; c=relaxed/simple;
	bh=Y8Lnf1x7dSrC5VGNobecn7t3LGF2SnXTsTjFsXiX+CU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gh8CdUABmvPpcLCcyHYLcAtzU5S7v81ocoNudLk4dpNkhiapWb5vKWX1QPSitTXQVWb+XzVSrE+RYzqaybZnvIEIzEA/MHho/RAjXvJ3GN5ZgMm3nSDHztK3LZkGNc9IRQV6pyKxVIVEv4Thz98p14YG8Q7ebALK/RChF9OK9nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpsNIiMJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779282250; x=1810818250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y8Lnf1x7dSrC5VGNobecn7t3LGF2SnXTsTjFsXiX+CU=;
  b=dpsNIiMJTifcUAJDIbFIauYErqtGwhYFj2YMLVCW5fKbTCeD0z6S59ih
   8XQ48uswrMlTpEu0iez3jZq1ChbQ05UUljGXg64u6y7olROsNsJvgfchO
   5q9fyj+eKe9SO5uVKffvk22m4r2JP7kklpPOsRwC1sJuOepSFxzmXmuFd
   F274qcBve+VAOjVH5gOXDqGGgWRbj0oFZnY/jnGwMlTwFTOvZV/pKPukg
   MkqdcWLYXUbrR1J0PdF/6tAlpKCDcXPKE/xVLcf2PrH31tEMnXqkHxIVb
   p7V0XjFZi5IZF3g7BlGfVtW8Z86ynAe0ivz1NN4ULF8YcNvs4ihFaOSlW
   w==;
X-CSE-ConnectionGUID: fgBZR5LTS1iSRtoZZB0y6Q==
X-CSE-MsgGUID: HwePzgx4R7WTjMj8p6pWRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="82755669"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="82755669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:09 -0700
X-CSE-ConnectionGUID: lVfwq//TTRWICxgW52s6zg==
X-CSE-MsgGUID: 0gXFlpgRSFmVV/D8+0mouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="263967753"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:04:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 06:04:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIYxJxdtyJo59akgdoosk5aRUgyENbpAT9GxKEd7L6NTt8xk1K+uzOwutU90BmlFTzY+r/+JpcNzvGRxZQ9dt45/OpTAom9amaNWj63NZ2lzkg2BfsDjUzyAaa2FAIJoKYPRTZ2L3/DRkNXFxT9RILDwMl+yO+qJcE78BaX8u4tf0LicvAcUcDZETt72HhU+Ds21NB4H25nHAgnRYOSV7jkcWjrIQwfS0VeNJYx0kAgrBXCk/RUvwCJH82aY4GGzHpZuyCmZ58ov7asPUVusWl5TFumfrFAdZ4G8xTff7Iuyq3Bfk0tpIUxHYsGUnQxljpEM7/aDgD2f7ysacTKhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOhEZnNoaqSn3bdv3O1FPlBpho4cQgBcBbd1wlOTMYU=;
 b=GR2K4hV8z0LizWtydl2zDN/vLfnZa+9So6qJtCva/33G8lLXUHRJTbba2if5p3ZhiIat94QDSJ1aiVu1nUjVceGsCKIo5mElNOyNcV9n6ZlJS2fMQ0k3Q8I2hagNjmJSlaX7qFWAYGVQnzmp9Fx9zBYqRhIL8xUer4NJhdmRd7V34devHcl1tv1nEn8ZmY8LOXp3QoHoWWwXtv/iF4VpFh3MTu+4gmQExGuBDoMMPwddQFawpevLE/H6ex8zGECEcGES7kE5E5uPx57o/o1ri7G4h/Ri0T//9RVhTiIZVqb3ZVFPt/zJR9aNTX5XbK96PTqiiGy0EBdWz77pX6ftcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 13:04:04 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 13:04:04 +0000
Message-ID: <c556e432-0e80-463f-a924-83f8f1ab333b@intel.com>
Date: Wed, 20 May 2026 21:12:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
References: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ff6f15-3403-4415-e324-08deb67044ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|376014|366016|11063799006|5023799004|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yvnG68ZrA4R6dT4UHSD0Tuk9TSA7Dia4Huy0GA5qSwFe07Bas8zfbanMQLpBRAWwc1NFIpJ2ik5tcanzWuCmJfp+n24IGCo8PSVJVbhWVXj8/ZXcZ0QeitxBAq8MgtDAndENhX1O46jgUoXjRrXZTXats1BNLfofuR0BHOoUIVNPCjj1soaaMxQ1bFdbizX9whcgebJUUrzM5WpoZCemxp3LtAArKEcdwTvcRzPTEFuKgwCLG9oIoVWOosG4OCpSE5neJj1eg3fv+7R3fKhj5118NmJi/tNdccGD/X+PEK+0NjaJHPRVmUIlpe5KjQ7ceWga/9qn9cBc+AYFkCplp818h5DBIl0+DfaJvQR+dv0Mm5GnuA1Ic2V1JLcAA4JD81Vdt1avHb2RjnlQ0+nrP+hITjTMo2V+qcZV2lg+f9PGPN4GOyrsuqUEuKoSIxbULKtrFTdeVEC//m0BU0ei/EvzQfb9btoon26kZPvzH2EWZCfT8gcbbtSbxpJ42Rq7s4jPJ6GuHhmt/d60zYO8r9s+jqr6LkyZPdDiWPm61L7WflCV+HOvBOlqgTo4w1TYpOKrts8TTdQe/6y96D2xXGcs/uMX9tMKrYgf/y8I9DOxneSeolzlBtHKFRicAyFWy9ZKOsiqF6piBCnXLzcoyWwuoDPW6Ft8FT+fTpL2KAXZDZ3n0cPWm1TKz2AmcB7G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(11063799006)(5023799004)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF3TTFlQnVlcUlSZlQyNHRub1JrY1hhL0xmMUtNWXdvazlod25IL2VVUzIr?=
 =?utf-8?B?T0xrT3BRWEdrUXQzd2xHc1JDUkZHRUE4bHVBMTJGNGJxTjZBZFMxdlZzQ1Q0?=
 =?utf-8?B?bEtLRFlLaW9oUENTWDJDTDZpelNEWTVRLzQzdk1HeTQxVGpJWllnT2xKTmhq?=
 =?utf-8?B?Y0VoQ0lRRlhCME9SYnZ4KzdIeUJhd2ZhNDNINzVCSVFQRG9kWUVIU0NnSWh4?=
 =?utf-8?B?WnBmMWlvMWY0UiswMVhmTjdCUGh0NW1SVFhEQ2s5bU5LOFVacDEyb2xWSHpr?=
 =?utf-8?B?MXl5Rzd2a0FKaEVpWGVObFB0THJtRkxBQkxTRm1DMEN6ZERWNXZmK25sWnpY?=
 =?utf-8?B?Z2JrcjVEWm9Kem1qd216T2FHWmtHaGh5RjI0UkEzSmduVDNmVjFtdVpVdkFB?=
 =?utf-8?B?TlM2Q0ljUVQ4WFJUMXBQNGwrREV1NFdZQi9DcmxJekFvMjBFdHROZUVscTND?=
 =?utf-8?B?NHNkdnFSb3RLV3pkQnJjV3dsMDd2TlBEWFhLTTM5blMyUjhFcjd5Z3FPZGM2?=
 =?utf-8?B?NnoySm5xcVliL1dYM1pUNllTTjExWVRBemUwUjNPWHhaTlBuMnF0dXFpVWZ1?=
 =?utf-8?B?QThOOSt6TXBjY1FacGl6T043cjVYbUpCVlF1SnE4WEFIMWlDN0xXVXgxam1i?=
 =?utf-8?B?cmhjZTFWNnlWZVdqb1JJUSs3Q0NzanJkVytWTG1qMnVWSUcxSjNsRng4eW90?=
 =?utf-8?B?UEVGaXZIQXpxUUlYYUhaSndCWjNhenowTFdpcklsZk8xcktzTkd0UlRPcm5Y?=
 =?utf-8?B?eFYvODAxcmtYTE9UaXlYYjlkQnIreVcza2FicHJ4TXl1eUV0YlU0eFpkUVVw?=
 =?utf-8?B?WUNxSkhKR0VTWHlIZmwzSmdzMFljNmQyajVEQUNJbHMyY2wvakZEZkFuQS8x?=
 =?utf-8?B?ajA5T1I0WUo5clZQT3VIRGNTSVNCYWZHd0k3T0toSUw1RU92MmJjMk11ZGdt?=
 =?utf-8?B?UUh0SjhEckRBb2VtWER0MmNyanhhb1lPL1Y1RlFWaXJJZjVac2Q4b3JOU0lG?=
 =?utf-8?B?dXlFaTFIZ0gxZUJVM1lvZzdoUTZjS1dKbFRob0FuTnRjc2tpV0pwcVFYY3pI?=
 =?utf-8?B?Wm5zb240Y1FqdWd4T1pVS2VVY1E2TzViUlBYTlJzUWRHSXd3QTMzSFZkR0Vu?=
 =?utf-8?B?bko0clhxczZOUDdXcWpmZm5tUFRobTVnMXduWHE2cUhoR29HdGVRaEVDMlpR?=
 =?utf-8?B?QWtaZUhXSElvQmM5d0JlcnYyaEhpOEtJRHZNOXFPMkJPejhDSlkzeEwwOHBx?=
 =?utf-8?B?YmRLMXU5S3prbVRCamdVWjRDTlFLWWFDTVRLMEQ4b29tbDd4WW9sZjBmdC9r?=
 =?utf-8?B?bUVhUkZJc2NsamNFVkM4UE5tZkFHeVB3WjVTSGEwZ0F2bjNKUWlMMHpwWEtJ?=
 =?utf-8?B?OGZjcVBadkFlK05Famk4MFZDczhLY0JqWmpRSGRwL2c2b1R2MnlWZGdyS1ht?=
 =?utf-8?B?NGdIU1NhUlhZSisrTDA1RnJIMkJOeVUrYk12c1VpYmFuMkNkUm1wdFFaa3E3?=
 =?utf-8?B?VkRJZ0NGWFRHM2Rvd2FSMk5XWWFveEkxUklHR2tobzF3Y256RUt1dFJ2RDVV?=
 =?utf-8?B?VXhZeHdoblZWdFM2MTRjRzF1U0ZyRGxWa2l4bzJ2b1BKMHNGMDBhb2d4SURW?=
 =?utf-8?B?N0RZZmxGelJsODVHQmpNbUFFYmw2M29xMisydzFuT2FtRm8vSFl6Qnc4WW5S?=
 =?utf-8?B?U0h1b3pxcUxkZXZuWmlkb3NmcWtoSGdFQ3h1KzZrTHpiTDdJQkJ0cDNjWHVF?=
 =?utf-8?B?bmxpS2VSQVliNlFGZDFUUmdaY3N3QjVVRjltbXo4NU1kUEJZK2lPdUNFWkxU?=
 =?utf-8?B?dVo3OWZDOUNoUEh2TlJYVERYbkdIS2doRlpVOUFld1pEdlVHUS94RUplR3Y4?=
 =?utf-8?B?TTVFSGVxeTVmTmM3M0xRLzlIOG5INjl0V3o0VWYwLyswdis5L1JBK3JPaWVi?=
 =?utf-8?B?RkRRZVdyUTk1Z1RZaHFsaHhBTjYrS0owTW5tOXNtT2U0bHZuNHJtNVlCOS9X?=
 =?utf-8?B?L29jVGJmYWZiQ1JvZXUrcnF1MU5FbEdkeDVHUXI5a3lvTGpTZWp1M090QlR5?=
 =?utf-8?B?a3ZGK0gwOW40aGEzQktGTW9nVmxZSVFXbDFFRFBiaUgrS2ZOL1laUUhYS3Bo?=
 =?utf-8?B?eWlmQ25zRHRNdU9OVHBVVmN5MlAxQ1oxUmhJbDlVUUxxZk9KTi9lMlNiZ1RI?=
 =?utf-8?B?YWlXaDZLbC9PK0YwemUrbWpGZGxkRWttQ2dCdWs1azlicEl6bW11SEdMSlhM?=
 =?utf-8?B?VXBDSmpMVHRvMnVNSkt4d0Y5ejBhdGlpNGM3cUI0K1F0ZmxTcVFiOVB2bmtn?=
 =?utf-8?B?Z2Z1TkZlV0RZbzV6Z2QyMDUvUzFmRm01WEZHZUI3VExFSWNOWFIrdz09?=
X-Exchange-RoutingPolicyChecked: Xrel+y/u+6CdhhUtwyrWWcZRCud3KaGRO8kjbALL7jyJJdAun1zTk3iyhbIPSlZaASSbL4XP89msQh5xYp4B1HRpmr26FJM9LIgfPtl62WLxyKdVCqnso1zYul76mYlfPz5cf83V9Zy8qwtO9QS0LceMAUXezCyHo1V7ohMoItJ3VoGGYCMYKMsp0BrVSj31Ik+ajdPjvbeAKygB+KmtJLs1Ob6tY+P8cT4HcHyKHCajyxZzpgDphmX7FvACGFDhtOCu5eoOyuJPiETLEppkiAlkYRPND8Zcq5kCdk/UoJg8AACbFCabEzfSW/zNzOFy2Emoad3TpOaywW5xV1nLfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ff6f15-3403-4415-e324-08deb67044ab
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:04:04.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJaBnqkSLkIRiVoPmy8Z1HlpxgTJY/7/+Hviq0r5yPeyOTCUIc6NwS/fxakHmN2m3RwdR4OtXiJZ2uHfmuRvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249914-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.l.liu@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 424F258E8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 13:29, Lu Baolu wrote:
> The Intel IOMMU driver allows SVA on devices even if they do not support
> PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when
> PRI is supported") modified the SVA bind path to allow this configuration
> by skipping IOPF enablement when PRI is missing. However, it failed to
> update the unbind path.
> 
> This creates an imbalance: the unbind path attempts to disable IOPF for
> a device that never had it enabled, triggering a WARNING in
> intel_iommu_disable_iopf():
> 
>   WARNING: drivers/iommu/intel/iommu.c:3475 at intel_iommu_disable_iopf+0x4f/0x90d
>   Call Trace:
>    <TASK>
>    blocking_domain_set_dev_pasid+0x50/0x70
>    iommu_detach_device_pasid+0x89/0xc0
>    iommu_sva_unbind_device+0x73/0x150
>    xe_vm_close_and_put+0x4d2/0x1200 [xe]
> 
> Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
> in both the bind and unbind paths.
> 
> Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is supported")
> Cc: stable@vger.kernel.org
> Reported-by: Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h | 11 +++++++++++
>   drivers/iommu/intel/svm.c   | 12 ++++--------
>   2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index ef145560aa98..775f1c4ae346 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1254,18 +1254,29 @@ void intel_iommu_disable_iopf(struct device *dev);
>   static inline int iopf_for_domain_set(struct iommu_domain *domain,
>   				      struct device *dev)
>   {
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +
>   	if (!domain || !domain->iopf_handler)
>   		return 0;
>   
> +	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
> +	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
> +		return 0;
> +

Looked into the history a bit, and this story begins with commit
a86fb7717320 ("iommu/vt-d: Allow SVA with device-specific IOPF"). This
commit enabled devices that support their own IOPF mechanism to use SVA
even when the platform IOMMU doesn't support IOPF.

However, SVA isn't the only fault-capable domain type. Other fault-capable
domain types (e.g., paging domains) should also be able to leverage
device-specific IOPF capabilities.

My question is: can we drop the domain type check to support other types
of fault-capable domains that rely on device-specific IOPF?

Regards,
Yi Liu

