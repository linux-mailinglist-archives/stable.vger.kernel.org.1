Return-Path: <stable+bounces-133199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FAA91FBC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F77B39A9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBD251786;
	Thu, 17 Apr 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq4tt2RW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E424EAA5
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900163; cv=fail; b=kW3JiHPcDiLoNnRGtY+l/KhATNzT4iH9cHNc7Ut/ZbskZ8FugKa1bcI53sn2HhsbJ75+8pxbo87+mUfBi9bP2HNll/aTQIUVCIUTs9YAeBOyvmPL6PhGcXwJOL+ilGSNF/uhOzPOPTru/tVX2w9negGzbm2MqDS5kCj3xvbwoGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900163; c=relaxed/simple;
	bh=KmY6hkzN+o+JQsc+YDpKAyFp8FryoNn0kGdhPrG1GhY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3KmvIyUDEUDwqTwB1mTiNCU1tpXEV6/2NOMKyyDFCBva5tVn6DVCnyiLDl0ic6Uj8XhX6jTGM7IiBub+eNHN5pHLuMxeiLsNpOh1/8weR9mVK238hVvY4M0hY5+2upOCZdzNSkRCG9AFzwPKz1WuttbuCCJRjKOBNMr8TW3bUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq4tt2RW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744900161; x=1776436161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KmY6hkzN+o+JQsc+YDpKAyFp8FryoNn0kGdhPrG1GhY=;
  b=Uq4tt2RW3geEQdREb9sWkbjlT1yjOU5LpIFMO2Bwu1+QKxj6zXUnPMjN
   kd2CZqGruCqswhjjirocc10yd1XqQlM36te2ph/XcRzDHfxw4TtjbAQB1
   KTRNfLXGLnjVOnqhrYRmp/H+ehSbtMr4oplsf1x3SpasyaoWlvy8/CY9Q
   E1jlRH0VuiSBqA0VMsjNV8SRe9TuegfgsGI89WD2L+/WSblJbzFwW3GZU
   0MWs8NohPJw3P8Y0GvjQ/va1nuSSvr6z9tUjvp7YQ/RHH5AxRU5qmlbOz
   d26xo7L1THPzI2yNLxX8M+RKpcj71hAtzROjxcvRXjBNHVr/WyKk+tXQW
   Q==;
X-CSE-ConnectionGUID: 6unS+BYDSwmKzQds8SXnbg==
X-CSE-MsgGUID: rm+TQ3mSRvilR6ydGUMdoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="71881488"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="71881488"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:29:21 -0700
X-CSE-ConnectionGUID: aejgIk5tT52Ji3RmDLjjCA==
X-CSE-MsgGUID: xoI0H2OARB2jyAxDtJQqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="135936009"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:29:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 07:29:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 07:29:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 07:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef2VjbWXH9XZ/rfFuN/nlH0yiIfxlhiQY5v/ynuUca98ibSvXE4i+abkqgF6O+77ophgCMnaA9vsWBp62LYGa1DMGDHX2WAqm+w4mn3TVrvdzfulFFev0xZ0Bf8NRWvxK5e3U68VyQjM8NFF21qHWBra3e3KoKC83niF8hDmM2b3ewX3Mdbb1+bNki1FbYbZfgFSjMRI+L7kZBUOEqIu53sn/04bzSAAYpABc+inzEvNPUcxCauXL6WMwbpGTkUNJLqfmBxwcki5io94ai/d38dwzzijSwu5cDezvagUl9deTRbhnHiJbbBLEGwEqL8O6eGxhuYsdpSO/Rr8xTmfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dPOdtN0yKwK17MLqiiNJ9Cf/WG6zfLEhzwCRikwWSg=;
 b=em+I1eNPacxs6BVtrzeIQUBpnZQKXgxL4sUj13txHA7oGZxFVmim1V3lXKSPVeD4RvB21jMwwraY1QLI3zeKdQtF+Vtd8Bz8DUNUrXjYkPeUFZpc4NRJnEbuA0jq+wd/rrGCB09PBdMC3DXGboI/KndEfUXHslXRyA5Y4mWoRVJQAccLQH9Pjdr9ZTqSMy0XOrqZ5AbNhGDhGWPOxsoQfepIQ7yiNH8L6bhMEHFrmBIoEg+81wr5qeuB+YficLqkOFTBSaxKNyAFvfuGkavYQzxbmpR1/I5kU/Xb7anpt2cwAam21xubKULY8dkHr4Yp6DIK+PjNvS70zRFubZQzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 14:29:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 14:29:17 +0000
Message-ID: <661d61e2-853e-4580-8ed7-c17c660f1a4b@intel.com>
Date: Thu, 17 Apr 2025 22:35:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iommufd: Fail replace if device has not
 been attached" failed to apply to 6.6-stable tree
To: <gregkh@linuxfoundation.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <stable@vger.kernel.org>
References: <2025041701-immovable-patio-2e75@gregkh>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2025041701-immovable-patio-2e75@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0041.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c05a8d-c235-4667-eaae-08dd7dbc3c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWExdjJqby9yMStnZjltNnNIaURaRzZ4QWcrU3Q5bGZ6UnNKeDU3a0prcytX?=
 =?utf-8?B?MDBYL0l2Z2xwbzRYREFQWWdOVDR2OUN2WlJXU2Y3VEVqUy9GbnIxSEpXQWVB?=
 =?utf-8?B?Y0Z3UzlwVjljN2RiVVJYeGtIcjYyaVhtenVVdHpaa2g1c2hKTDdraEVod1pJ?=
 =?utf-8?B?dmZ3T09oYlFLaG1TeU9lUmdLYURmNisrbjdwQnMrbVlBU0tZVjZOL2hYQVNp?=
 =?utf-8?B?WUR1ZGtJWHJuR2xkV1ZFL3hYanZ3R1R4eFE3czg3VGx4UXNtZWdGWlUyUEl6?=
 =?utf-8?B?K0J0WURBQysvWkZaM05oZ2pkV2x0dWhrdUNXZmFMc2ZZOW1PUXQ0a3Y4VUZ1?=
 =?utf-8?B?b2VJL0FxR0lPdWtRb0FyOTZiaDRNNWxyWVhEZzhUQUViRlJYY2lsYm1aY0Rs?=
 =?utf-8?B?VWdxaFRreHhRYWd2SnVZQnZsZkg1ZktnOUpuZHFVb0ZoN2dGU05mbXdXbHF6?=
 =?utf-8?B?dUFDdmpWYjRHSXo5NkxRbXNvUkxWSjZvMmZxcVRYdmM5N3IzMXJXcGhBWHh4?=
 =?utf-8?B?cXVsRkV2c2tkeGlvWnAwbFRaK24wUFg1L29WZlVxWTNISjJPOUJvem0yWW9D?=
 =?utf-8?B?Q1Z4MkRqQlZ0THpCaCtzcysrSE9CN2NoMzc1U29yLy8zYy90TG43RHNXMVRP?=
 =?utf-8?B?YXdxUXRZL3BNNTRDN0FBYzBGM1kvRnRERXorVVJsK2sxdE1sOGMramxMNzRw?=
 =?utf-8?B?NzdZOGsyUkJtNUFlRmpteHRyRmpSUEoweE5rd0EwN3piZHVySVVSa3hDb2tN?=
 =?utf-8?B?eFdIQS9OcUEwWElOZXVBZEtnZjdRb01CRVVWMnBadDRiaWZhSFRJUmlnQWZo?=
 =?utf-8?B?dEptYmpQUVBWUEJlY1lSQ21VaFlOckZxVzBUMzBONXBudEt3ckJDNVc1aXQ3?=
 =?utf-8?B?aXZNeE9jTE44OWdFTnQ2TUlHa3Q5SVMvbDIxZEhMSlBQRGxUQktTRHlPSENQ?=
 =?utf-8?B?VGdUS3pCSFgrQzVyMDhVdzljcG5ReHExUnlrL2g2NTlGN0tCbkJpSVZtSVhG?=
 =?utf-8?B?dUJaMktsRVhjSnpTVzVpUkdRVEhJanRsSzZzNVZsM1BnYUlrRGQ0OTlUU2lE?=
 =?utf-8?B?eVpBWU1jSlVNemcyNy9kcjhxdGhpTnRuK2lQUGRvV01lRmg2RnEyL3ovMzQr?=
 =?utf-8?B?Q05UYTEvc3dIVVJzcThLSngrU0lTd3g2UWMrRzlGWFJvVG82VDVhS295WmF0?=
 =?utf-8?B?YnBnSzdxeEpVV2xQdmZOOVNjNjhHOExad1hsNFZMUTdPMDk3MjZ4NkQrTGVp?=
 =?utf-8?B?blpUY05JaHNiUVhZbnpweWdlMzhVbVVpcWtkNExUWFcwR040SUF1TXhlcXd3?=
 =?utf-8?B?ems0N2dIZ0tqTkNJdVFlTFI1RnEzZmdUcVNvN2JhTGRRUVZ1RlVUWGVvQkVD?=
 =?utf-8?B?RG1pTkhzSTE2WWVCK1NlUzgzN29pYk14T1c2c2pRWFZqc0J2SUlyWlJKU1Rp?=
 =?utf-8?B?REp5ODBRZGJNRi81SGVHZ2g5aytyZDh0Q2RLRTVodlpVVGUwMkRSOE5ZVXFj?=
 =?utf-8?B?OWxmUk9IWFI1SXBUTUZncUs0aUVzbDQ5elZ6aHo1aEplQTZMZk1BRkFmUXFI?=
 =?utf-8?B?SE9tdlQ0VVAyNWFSRmNNUkVYVG5CalZzYm1VQjZJdEhuemYzRlUxZkdhWWhm?=
 =?utf-8?B?LzZuSkd2cGxMM2Q0QzlIbXhzVk90ZjVVVXUxMjRFNmN2T0REUVRWOThDdHhQ?=
 =?utf-8?B?WWNvYmIxZmN3STR1ajZhVDBzRXArSjVqUUEwQkRVSVlkdUlPcWlvVyt5NnJC?=
 =?utf-8?B?OVZobXhDb1Z2Q0RpcWdoY3kzaUU1SFhjMkJJSkZQRWdUUEhWTWtBU3N1dWlj?=
 =?utf-8?B?bG9qUEQyK0VndGF1NWhPaXUxbFJCdFNOSHBnbFk0MDBVK1pkQTkxbkxEUkNC?=
 =?utf-8?B?WmZKaGMvM1pXSk8vS3EwS3A3eXd3VHBKeVdMczVXWWYzVklPOFdiOGlrMllw?=
 =?utf-8?Q?GLvaAw46bdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQrbU1vb1N5NjdjdWtvYXR4bTR3di82SHp6TU9wSVQzN0drZ2Q2a1VjUHIv?=
 =?utf-8?B?d0lIUldPaHBXeU1YVG9OdFhldGlnNFJiVk5sMmtmcmpydGM0RkhKMi9EYUtP?=
 =?utf-8?B?SXR5VWo5c1BYTVkvUDVyMWVPbVkxUHhxOGR5enBxa3NodSs3ajIzaCt0bUUx?=
 =?utf-8?B?VkxuREx4UGhwa1VNWWt2MG8zSnpvdndNd1BIbUM1TnNTQVBqeDltNlo2RGd0?=
 =?utf-8?B?SE84N3dvTm5QbEFnK3diVDVQSTVIVGYvSDQvUmlyTGdHNHRsb3ZjN01WNmlz?=
 =?utf-8?B?NllZb1p0bzJ2eUo0MjJHZzRUZWVpOFQ4azRqcGxraFNjdmlxTG5KUWE2VHF0?=
 =?utf-8?B?a3BrNzBYWUJSTWs4ZG5qaFJSU1gvZWFVV0pHSTNLbVR3cXBTOXZidE1JaHEy?=
 =?utf-8?B?SitucFhVTFU3VlNLanJmNVJjV2dGOWRicHZiT0t0YUNheHpyUVZZTU5SNUt1?=
 =?utf-8?B?L1NBUGh1ZjhzV3RGSm5oQVRDY0lRM1gyekxwckVzcEx0aUtET05UMWRIZmd3?=
 =?utf-8?B?QXJyQ0tnRjRDM0Q1bUNaeEo4WFgrT2RBa3J2bFJuN2tLdjVNdGMvZjdnNnB1?=
 =?utf-8?B?M20wOGUzaUFUZHoxZkVRdWkyZG1xaXUxUHdoeTY2czJ0SHZNTTRBUEdqWmtN?=
 =?utf-8?B?c2hnZ2lrSVVqTnpDdmNsMEdvU29ReVdlQWZIdUhpVWwzMzJ6TlYwQ0NCczFo?=
 =?utf-8?B?QTZIWHVkS3FoajZ4ZEs0dTJJdExsYit3Y2hDZTJOTlBId3o4dkVON1ZHbGNY?=
 =?utf-8?B?TTBWVkpudmo1L0pvSEEzNjA5SnlpMnZsRnR3cXRvVjdhSDlvZFQ3RHVzeW5q?=
 =?utf-8?B?aS9yMHdNT0UxWFFoV1crbVN4UXR5OHBDZjFmZ0RJc2poWGVSSG03ejhSbnhl?=
 =?utf-8?B?S1dDREhQTVZPbXQ5V0JEeUxWdVNCTS9KYjJGdmJ6Y24wbktTaDZsM3BNaXIz?=
 =?utf-8?B?WVM0by9Ga0E4YlREVERoNDNMQTBjeTFObWdvYWNkaHliMGRNcm44clJkSmNC?=
 =?utf-8?B?V2pCdXZ2Y1lnTUVhOXhTNys3ald0MC9ieWxsS1ptNWdneWxOTDh6ak5YbFE4?=
 =?utf-8?B?V0dsS3AreGNseVBMYW45RTJ4L0MvSVRtYTFYOXF5OHhwN0g5RVFLYnNNNndZ?=
 =?utf-8?B?NjF6c2JCTDZMM05VZ1JEK3VEUjNBVWFUK0ZjNmVmTityN2M5MnNLUzlzdlpR?=
 =?utf-8?B?U01BbnlVTmx4SURZbXNla1ZsbXBYT0lQa0E1bTRBQlRUU2ZqZHNCVFJodStT?=
 =?utf-8?B?ZDFvVFR3WWRIZFp6UVU4U0tFV3g1eEFNS0VaY2I4bk9ocEFmSUM3RU4waTN1?=
 =?utf-8?B?WmJQWEEzOHdnZzgzQ21pajYyZU8vcjJPcE02bm82cHNrZUtKMFZxblFIMFR1?=
 =?utf-8?B?dHNpSzlNcnRNUk8vOHRuMmExbXRoS2llbVU2OEFPRzkxWG1GOGhXZmltUlUz?=
 =?utf-8?B?OS9KSDl1czFvTFBNVSsydnZYVjFhaVl3ZkdFaXBjT3JlNCtSRXFXQ1dQVTkz?=
 =?utf-8?B?Y2ZtMnZnM25KQXQ3VlQzSGJkcnFoUTRob3dtQXlMenBBSFd4eTBxaHZHS1VX?=
 =?utf-8?B?dXEyQ0dDMDVmRGYzeTQxLy9WT0paeVc2SW45d29jQ1ZrZ045NndUVlgyYk96?=
 =?utf-8?B?QVVmQllHZi9ZdUlxODFoRS9pQnZtT3NyVjNsR1Vna2E0SktPMUM4Y0V5aFpt?=
 =?utf-8?B?TUk5TU44ZTFTcDBVOGRuejZFUFhTcHVFWnJLUmxWZ3VoVGZpTFB3MndSQ0sx?=
 =?utf-8?B?UkpYVlhBaUpwWGtHRkUvcDgxd25WUkkvcUV0aTJ6V0Z4T2dseXBvUUJLK3U4?=
 =?utf-8?B?TXFqblhZdyt5bWdyODV4dEt0S1FRWkZROEVzNVNmUDRLVnRINDJtbHVWZzlj?=
 =?utf-8?B?ZUl2dEZiZG53R0ZBKy9vaGtzL1VCZUJxOExsWVdLZ1BwZlVQUHV5dmNaQ0tz?=
 =?utf-8?B?dThtdW5ua1JvOVc3QVpQV3NnR3N4Zmd2azBBMk5SbkZUWGd6dVlyY0xXL0FS?=
 =?utf-8?B?djNhc1RMZ1BIa0dXNXZEU3M2RGpjbFF5NHBEZVUydXh4U2hnVkh3ZGthZEhi?=
 =?utf-8?B?ZThHSGl4T3oxbmRaUmhJLzREOXBUa1pSY09MZmZDWG5Ld0N6TzhQMnlMWkNN?=
 =?utf-8?Q?jMmW/eP6EtUErlizSW/nbMPy8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c05a8d-c235-4667-eaae-08dd7dbc3c0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:29:17.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMH23IVQejjRjCM0AC3Cek5wOQxXpB1nyRqqTNBXHrE5j8KN1Ge06uJeSCI+JQH0cKvoLuUwql0e2CjgfWrrRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

On 2025/4/17 19:43, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041701-immovable-patio-2e75@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:

The most relevant commit is fb21b1568adaa76af7a8c853f37c60fba8b28661.

While fb21b1568adaa76af7a8c853f37c60fba8b28661 itself might depend on
the below series. I doubt if it is simpler just make a separate fix against
6.6.

https://lore.kernel.org/linux-iommu/20240702063444.105814-2-baolu.lu@linux.intel.com/

-- 
Regards,
Yi Liu

