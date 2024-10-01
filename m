Return-Path: <stable+bounces-78490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBD98BD65
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BF92840B8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D91C330B;
	Tue,  1 Oct 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhoGo8sc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41806C2E3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788968; cv=fail; b=mRk8rPA/Au90rXTJDsfIiGAfHwgDNXDw4WMy3lP8GY2Ff2573N4cQ8GagczinNVqQpWDI2Z72Z7iLuSqnIV2Zl0syX+bQZpbKanqnfysVjg6+5Sy7z7TKcXBolrerFePmg19o7p31OCSqcMHQFdp79I3Dwvgrxb6fIEjfCKcryM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788968; c=relaxed/simple;
	bh=0y7C8S9dc3W3x3Ww7hDnt1UEA98+rpzN1X01VxWhD8Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GxVANgeZg3+9BT2tAtz8pNACPuyHBZn9w/Xb4yOdvNRmZ5Cp6wSE6fhNjGRHMLgqR84zuwukM4EESgYTlHIbBZVXOaE14qjXXskf4eOWySRrv3BIbaUcuPyBIlHd1cnocdR3Bq76KD9CXKJJNKmrphNjJYRrvoNZTdsMlTCw2i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhoGo8sc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727788967; x=1759324967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0y7C8S9dc3W3x3Ww7hDnt1UEA98+rpzN1X01VxWhD8Q=;
  b=FhoGo8scrN2m9E9aayLONk4bjAYLM/o9s9qlqyjwT2Fe52fL8VLLgsOm
   RELaf+BowKHV0XszJUH7LZztdj1UaOSkvPuaTtDSh6KJGg/+tqWZiaSyg
   +o3W0hNb/qJ/oSsjk+g8cXSzdwQz2NtKicVKw4jWrkfDGxZatwl2rHQce
   fPAZGX04J2t1mq57wr4jQcxezIvBtglLxWj333vTcwvMHRwSvy3Yg2lpV
   Q/eciIbAbXiUwTVvsU9xp+QfIUfDnOvNNgiu4GY953EEUz/hf4bkaYj7W
   FYI5B/I2H1jwjS22hHUptdObOXJ7D2DwjuyIUVKahHJggqDn0fE9KvCDg
   Q==;
X-CSE-ConnectionGUID: /m5HHDjmR12XF635P5X1ow==
X-CSE-MsgGUID: Uh8+XQxkTgeAqXVrZvnM5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37516647"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37516647"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 06:22:45 -0700
X-CSE-ConnectionGUID: eiXD0Og0TSyHn8j8EKWUGQ==
X-CSE-MsgGUID: 6u1JinWsQ1uTqvxbxg/cCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78081932"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 06:22:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:22:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:22:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:22:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 06:22:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 06:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi46X7YAy6YHDMmts2NO8Qsc+BsBvBX91KSQKSqn1I71qz0aVYPZH913ElkfeXbs0l5K8xaOpAGcMUqJ02OsKfmYg+6yTz0Qc4tJ/oVE+SM6mO7IpJGljMWebbmtH77aFzSK0ItCc+IuJs+qlaFxzN2DDLAI7K2+vsESHkMnHgIrknXkGUuNF28yRq60Z7T9IG7yo9W8hwJWZhNdb0twgQkNeLCiDXMhU+cRJhIfQSv08VNQfvQBAgxAdyNRv0k0rM6JbSAX7ufY5u46z+3nmnIk2gxv78gggKqvgu4KnVG1UpXZTliCO1bKuEgs8btIehAvsFgiLwVI9mWGdkeUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZD6FLQRiju8Q/UrKcJK0X9+XCGy5punMGOZQhb8Z7c=;
 b=ZuxbEwpdxUkL4yfesf3jE7ZquAiGbTX98o9HVofaw0qOLOr+ppDtv7yLbd4fclLMpB986swQ+3aYGwdeLVsxC0NkRk4oPc2hcZPKz87G2dLv1BfQLCDihbFb6wh5VeNTdrwfnCuvVqsh0z6DECY8WpdnLPoOAHaM+CRLSm047cTF5xH4VT2R9QuP5zJB9XxXa/B0zcBEpV20QlRotpQDwawEs/rA2K0wwR5ljM5mFxva2fJc7QbF+iBoTXLPd0O+6/e4rL50jveodhI2JrdA6L2wINCiyjlKU52ZG+D91tzgA7fKaNbelJdBIzs5cWMRQxGcXMdhmCEO+Ej9+9b+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 13:22:26 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:22:26 +0000
Message-ID: <d48a4b1e-209d-4e16-b9df-4ab73e5055b8@intel.com>
Date: Tue, 1 Oct 2024 18:52:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/xe/ct: prevent UAF in send_recv()
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20241001084346.98516-5-matthew.auld@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20241001084346.98516-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e6be54-994f-4f50-0385-08dce21c1799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3JGNERxc2RMbkFwbmM3Q1pGMDBnY1owdy9hYjl1alhBUGtGd1kxWVNQSTZD?=
 =?utf-8?B?Tkt6QjRvVkZLbVl4WitzTlJ2RVRXN2NuNGtGNmg2Q1IrcUNtWDBjUU5BRTNC?=
 =?utf-8?B?alJqVXE2eU9aMmQrL3JrbGg5ZmFBa1RwUjZHUy9CbkJ6a1dTTzNiOEkwSGVJ?=
 =?utf-8?B?QUU0K2kyY0tNbGJ2a0txYzg1QUw5QkY5T1N4eXp6THNKZVpCZEI2d3A4K2hJ?=
 =?utf-8?B?YUZSVFZyNHkxRUNhdXplUlFyTWtMKzdManFUNGZEUk9haFF2Q1FCNE55dlNE?=
 =?utf-8?B?UDVjbWlRU2Q4T1JqU1p5dzRic0pMU0MzM0M4MGRsWnZDMGNTbkNSV0poYmlK?=
 =?utf-8?B?Ujk1ZXBFNFB3Mmw5WVRMbTZWNDlvaTFzZ2w0UStGYzJOY2FBV0I2Tmg1NTdZ?=
 =?utf-8?B?aHMvTDNxRWpnS2EwNGdhalhNNGx4MWl5QWw1YXF6MHBpRnVvU1FBZ1JmUEhy?=
 =?utf-8?B?MWhWZTFHQy9iMkkvSnBNUEcvYllPUjZqcWVXNFhDdUt3Y2NWWWZiRG1Namho?=
 =?utf-8?B?cXVLK0pZVUVwdldyeDBnKytoclIvYVljODlKakhnVUU3dnpRaEU5Vm9ROCtF?=
 =?utf-8?B?RkdZNnJCRzFtQTNsd2tpRXBia1dYZkl1NW1zc3RvUnMzZm9RZVpIK1ptOEJ6?=
 =?utf-8?B?cnhMcmdEMXd0RTBSVXJjcHhnSTY4WWZnaDlBQU9FeThaY3F3cFA4YkZ0L3JB?=
 =?utf-8?B?REY0TEErK3dwUUg2Y1FRbFAzWTNBNzU2MEdUSWVyTmdsYTZESCtqTnlRQUUy?=
 =?utf-8?B?eU5Qa0tBMDloSFlKdW9XV2NBaWxzTkJ0bDNGR0xLV0Q4dktEc09takNYRVhy?=
 =?utf-8?B?Z3BLb1FST2dZRytkb3pob3lOejlKQ0dlZXhRSlBDdW1DWksxMlNIYW14eDJT?=
 =?utf-8?B?TjNIM05VT2xOOE5RUXlVRDJMZnZHbDZXdFZ5Y3VIekhGeWFreURKNTloOCtX?=
 =?utf-8?B?NVRyNENJMHhEMlBzYitJYVRPeUtvcXFXYVNpT2s4ZUdmd2tLbmN6SytuQTJO?=
 =?utf-8?B?Mm1ZODA3cENiZ0hqR0JHR3duWW9CUFQ4cXNNVW8rbVU4SmdsbHorZjRqb2c1?=
 =?utf-8?B?bTRlWEt1bDZkTVdjUDlFc3lSWU50V0JIT2h4bmpuVUQ2UXdRWUhtVTAzMms2?=
 =?utf-8?B?NGpGaHVZT3czUGNRdGUyUXVuSnVqZ0hjdFZPbWVDS0RPUDVrWmh1NWRqaHFT?=
 =?utf-8?B?cm5FSm12SGNSTkxQdUl1dGt6d2FVNWllOThOWU9hOVN0UlRqV2x3K0V1MG95?=
 =?utf-8?B?ZUQ2UTZ3ODlnUHdCam1rQ3NMRFZxR0FWSU13K1doUHlyQUlGMzB6Sm9IRmlE?=
 =?utf-8?B?a05GZ3lWa0ZSYkxsN09kT2hhMUg5cThHay9hWFhJNmE0UHBMOStPUS8ydDdm?=
 =?utf-8?B?cDlMcTMwUXpjTDhYcXpJcHJZd0pFdXNzS2oyNTZ1WWRGU21NeEhIdlBSV2Z1?=
 =?utf-8?B?YVZBdFBMMFk5K3hMUk12d1QrMjQrOUFodVo5YVYvUVJ1bWZ2djFmVmFYcEFF?=
 =?utf-8?B?NUxHNlJpWXJSRkx2aU9RWG1xcUc4TjhUQS9hdlJ6ZmIrb2dDWmtvaVlvVUR6?=
 =?utf-8?B?TFBoenJKcmxyRTdTVlplVVE5cVR4bUpBSlZ1cndNVmNXR2pQZTVLdkdNUGlq?=
 =?utf-8?B?QW5udjR1Wm1Fby9GMmtjeWhmZEJQcmRiN0F5cnZMRVJ2Qm9Vc3d2N1didkJI?=
 =?utf-8?B?bDFHaGZNaUNQNi9ITnRFb05JaXB4WkZpMGFzcEZZdGJhVXZKbUcyREo2WmVN?=
 =?utf-8?B?MUFQelRPTWhLZ2xzVGpwWmpqcFlaZmx3RXd1S01qNnJCM3lhd2N3WkNSV3c2?=
 =?utf-8?B?V0ZzdStCN3Z0cEJTRTQxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S09jZGtnM2h4ZWE1L3RoZDFoL1ZmWGxnNFM1N3l1MzZJS0t0ZmYrQlF6aUNo?=
 =?utf-8?B?MmMrRDNGb2JNcXErbS9YMTRBNnNNV0pqMHQxcHlpdUJoZ29zMFN3UEFUcnVR?=
 =?utf-8?B?bEdlV1daOWFEK2xnV1l0Z2s0MVE3VHJMbkFKNGlXZFRNSjhkbFNONUFzSy9E?=
 =?utf-8?B?U3NhMXA4QndpcjFjSmp1MTQ3VGhYM1JwRU9xVFNJTG91VW9ORE5Tc3pDTmkw?=
 =?utf-8?B?UEJzeDVrakRRN2Zsa0ovbmhlRXp3UW4wSUVpUnFQTHc1cHk0bWIwM2ZENmlh?=
 =?utf-8?B?NGU3QkZOSjl6aU1hTFRGV1plWmdsa2NpQXl5RE84Z2tKbnFIOVRpbkFyb1hB?=
 =?utf-8?B?MVlNdHlpK05xOVMyQmJwNk9NUk80YzJSbmljVi84Rm9KdXdqWkc5NHpUdnpN?=
 =?utf-8?B?R3NYWXUyalV6dzZna1Q0c0F1d0dSVUpvbVg2a09kZmUyT3lDR1FJZUF6bW1W?=
 =?utf-8?B?N09PVC9WSld0TWpqUnhBYngveU1VWG9mUmlvaVROMFpBM3kwcnFVdmt4QlY5?=
 =?utf-8?B?aFYvcGxNNUswcjhqUi9BTGozTi82ZFVSNFRWZFREc202dnJWc1Yvcld1N3pk?=
 =?utf-8?B?VnFoVi9peVp5b2JacnhZWFd1UENKZEs4YktuWXBUd3A2bnRCNzZTU0dFV05a?=
 =?utf-8?B?ci9Ec2ZxbXZZRDR6RlRYU1lDdUhZTkFPaXZTN1NGL1lUait6WXBMUk9palJ6?=
 =?utf-8?B?N2pJMWk2L0RKWURpeEoyalZxUWhpRldpQkU0U1RlWlg1M1E0eGhSVUtrS0t2?=
 =?utf-8?B?TlQvQjNXbjNkZXNrMXZhckNqWkw0NmhSVmtmRDhUMVlZVGFDVmJHZUl3azN6?=
 =?utf-8?B?T0VKNUxJcWFyVDgweUpzQ0dEWmFSSXkyODdNOVAybkRQN2ozeWJHc203akV0?=
 =?utf-8?B?Um8yQ3p1VFZXOHg5WVZFK1BydnN5YVkvZ0hFNUZaNzI5Uk14a1l2WTlCdzhY?=
 =?utf-8?B?UFNTZU1pdHBoWTlVbUdUTjhiMHJiTjhzdFJadkNpekkwUWJ5dFl3VXNvSzY2?=
 =?utf-8?B?QTNMK0Rsb0NkN1NVV1JvVVlES2V2ajJjUTFkMGJNZnJZQ1RhM20zUE9WckFx?=
 =?utf-8?B?WUJyRVRsUE9hRjNGRFhQSG13M3pJNDgvcEtGZnBSNnMrdTFZdGZtL2ZzYjRN?=
 =?utf-8?B?YkdOT2taYlNlMHAwa3ZBVFE0SEE1WjVOYW1vRmZXdmRuTjArOXg2em5XU21x?=
 =?utf-8?B?TWlEeS9PRmU5dkRnV0psVHVTd0RQRkZzdHdJTklYUTg5b0g1TE5BK1VpQWJD?=
 =?utf-8?B?M1lycXBrTmZyT3dZTm9ZRU53ZWNKVC9Ka0p5ZnEyem5qN0ltYSthMGRlVFRJ?=
 =?utf-8?B?bjFnMFB5cFozUXFJMmhBZHhXL1BEcHZObWlTeWlrRDRBZmY1L3ZuYzZBSkda?=
 =?utf-8?B?RXdBZzUrY3J2REd6cmRwSWFYL1NVTmR5amNKTFFHb0ZjbDVmVlRyb2xscnNi?=
 =?utf-8?B?VWpiNXBHTENFenIzaDU0b2Y0R0V3c29vakViSWpaYjJkclVEWkwzVmtsbVBY?=
 =?utf-8?B?ZjNXMjZLWlVTWXhyZUphazlPM2o4UzJVY2c4eGhudzZmUURwSE1yVHUrRUdH?=
 =?utf-8?B?b2VuZWxjZm5jZDQ3V0VmWW5XU254azBwWGVNc1VxYXBTUVJadlRna3llTDFh?=
 =?utf-8?B?SzFtWWljdlZMVUNpWEplRWYrRDZVWkFjY2x1ZmFaZEtnQWlpV3pJdXRDNmdP?=
 =?utf-8?B?VGpWclZoVkRERzlyU3hTd1FMQ1h1Vm9TTHp5RnZTcG8zQldkbE5Fd1pBSzJy?=
 =?utf-8?B?UlBrVDR4MSsvRGwxM3RORkdWTGlnUUFUQ0JPblQ5d3JsWDVMdTdqNDdZK2s1?=
 =?utf-8?B?cXFaNGpVWEdIVzMxTjZTNmJqZTB5bEt1bEcxc1ZmcWhIcEF0TlBWQ0tXM1JR?=
 =?utf-8?B?VVh5UzZOKzB1YncyUzk4QTdabjFpaW1KOTU2WjhkNHBpdFptaWhheDNNajNz?=
 =?utf-8?B?YVNoK2NwRjRKYlNiZE53Tjhxd3J1SzNiU1gwV2UwdmdZdkhxWnhKQmxTN2JI?=
 =?utf-8?B?S3hLdnRiTEFJWks4Vm9mZjFKaWtxUHoyUDM4TVFxS2tvOWJrUnNMNUZpdUUx?=
 =?utf-8?B?ZHArTE0zZVdVMnRPamROM0x6cUN1SUQ1QU9XNWRFWGxKRTVkcHJ1bDRaeGJk?=
 =?utf-8?B?Zk04aHpkT1o1aHZua1JGbm9QajBPODhkNW03U1BJaUtmZnVrZEZaUVo0M1Z4?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e6be54-994f-4f50-0385-08dce21c1799
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:22:26.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAnvuca1bXstoIrXrlNIp6ahx4oSm6E9YMdAVO6xC1Rvfeysy7Mus48KYOOysbdmXTL7ahdTMMH35/C/XKs8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com



On 01-10-2024 14:13, Matthew Auld wrote:
> Ensure we serialize with completion side to prevent UAF with fence going
> out of scope on the stack, since we have no clue if it will fire after
> the timeout before we can erase from the xa. Also we have some dependent
> loads and stores for which we need the correct ordering, and we lack the
> needed barriers. Fix this by grabbing the ct->lock after the wait, which
> is also held by the completion side.
> 
> v2 (Badal):
>   - Also print done after acquiring the lock and seeing timeout.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/xe/xe_guc_ct.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 4b95f75b1546..44263b3cd8c7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -903,16 +903,26 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   	}
>   
>   	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
> +
> +	/*
> +	 * Ensure we serialize with completion side to prevent UAF with fence going out of scope on
> +	 * the stack, since we have no clue if it will fire after the timeout before we can erase
> +	 * from the xa. Also we have some dependent loads and stores below for which we need the
> +	 * correct ordering, and we lack the needed barriers.
> +	 */
> +	mutex_lock(&ct->lock);
>   	if (!ret) {
> -		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x",
> -			  g2h_fence.seqno, action[0]);
> +		xe_gt_err(gt, "Timed out wait for G2H, fence %u, action %04x, done %s",
> +			  g2h_fence.seqno, action[0], str_yes_no(g2h_fence.done));
>   		xa_erase_irq(&ct->fence_lookup, g2h_fence.seqno);
> +		mutex_unlock(&ct->lock);
>   		return -ETIME;
>   	}
>   
>   	if (g2h_fence.retry) {
>   		xe_gt_dbg(gt, "H2G action %#x retrying: reason %#x\n",
>   			  action[0], g2h_fence.reason);
> +		mutex_unlock(&ct->lock);
>   		goto retry;
>   	}
>   	if (g2h_fence.fail) {
> @@ -921,7 +931,12 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   		ret = -EIO;
>   	}
>   
> -	return ret > 0 ? response_buffer ? g2h_fence.response_len : g2h_fence.response_data : ret;
> +	if (ret > 0)
> +		ret = response_buffer ? g2h_fence.response_len : g2h_fence.response_data;
> +
> +	mutex_unlock(&ct->lock);
> +
> +	return ret;
>   }

Reviewed-by: Badal Nilawar <badal.nilawar@intel.com>

Regards,
Badal

>   
>   /**


