Return-Path: <stable+bounces-241882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APlnHOsC8mlYmgEAu9opvQ
	(envelope-from <stable+bounces-241882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A108494802
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE61302DE29
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB53FB7E7;
	Wed, 29 Apr 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1U/RzBv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87713B7AE;
	Wed, 29 Apr 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467879; cv=fail; b=lTzcQn0pQkfJlp0hmchSYhpz9CkwcUG5H58XPBRVIxdb0DyZf9jcbP06cBLqTBHu4uDNcX4RfIwKtXEoHH3xuxsxh9QVhAGvDvWdKTwHcKU2211Y0yjgv5212hG4dh0fiCcceGplvoOnpO+63KzmWTAkvOGpwRQgrj4avF5ZylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467879; c=relaxed/simple;
	bh=/N2Fkka2gBzyXR6gZKKvrabrlBpM+yi7fl2Bb5B2Ang=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cABM0QoMER3xSYqnp4hiLTb5hY6LG+vDk4Slg7SxJ9RAKEICP/p2Gx9JCOWW6NYBlXp+ro3xs4/m6LmWNfsPYtU9NGHnHVSq+hsPlzmb2/vf5SrFrmVvQNuL8yxAjd4r4JLcl2xCobGoFX7xlYPONIYEfcQiAHPhlDcVIbFQJ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1U/RzBv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777467878; x=1809003878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/N2Fkka2gBzyXR6gZKKvrabrlBpM+yi7fl2Bb5B2Ang=;
  b=Q1U/RzBvCgTxMbXCmJh9G8FUrh//nMwBNfqLIfruVdpurq30B/BCGuEw
   mbVrp3Yz4oj1BZ0LIBNZXvMwTa4DKAR2bIvUmqTBM4HGD6jg2gHr8TblB
   ntaId357D5lqSVgtWdstugIKZIeB5RMS6zsZ6hkySqPD0AdR6LjkT1Wvs
   lj7ZD/yApw1aRLpdqI8ISh4s3WWBF0+wlD6FfSXm8Qz6vdgOwI0SVd5QS
   lMxfZLfA1xSWksVHGepsVk6zPzAJtlrPlxwv+YC0BWLiKsCt0ABV8cbmh
   KagWgXZhRF8CtC5OBieGXQa2wQT3yMRnYUHGaZypFJ42gafAQJpZClD/p
   Q==;
X-CSE-ConnectionGUID: GhdcghmYRL+LtPPVMY4O6Q==
X-CSE-MsgGUID: wsTEJKR/SQaZAANw/2DDnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78269401"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78269401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 06:04:37 -0700
X-CSE-ConnectionGUID: i94BZ5QcSEaCDhWgYB6fqg==
X-CSE-MsgGUID: oSIjvYolTDCaAr55pFtS1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264646467"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 06:04:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 06:04:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 06:04:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 06:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvHPXqEHcLe07Be8PC1P0tBQddbQl4elR3PTKPOqY4GJelZ9fC8cj7P8JBptnio7NIcJ3c92QOmJe066WO92JcEazAT9SLR8yPQ6s7NeECPGFDdDKy8adGRi+3ET0n/lWbax48MgMTklkMhq+/BzAw62Heac0uMKd8D8PgITEHj6yKCtff5771qWTxqg3S3QkbYZNRNVRTgZ1Ub12faFwTS8lXsdUt9EkmJy15D1GsOb/NIbIlW6ybn5NvunBvjKJ+6zzFbeDGjvChjsl/30hbkZd0Tf+uhCEujQ2Bcmrg3Dx4Krp0+JDJ+Oo06KPYJjPHxqJ53tnL7ttuUeaEkh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eOxe4X8vhN2T3NKX/hvFlq7f7nQM5TURqJ5xWFmgbM=;
 b=A8uWT3ogFboohgXFhGF3a3IF2L4vTpy9PiE/atgza1ybWrIdpEvmp42xRiX0ijaOCj1ZyZtku8XKDW6IvaAyYmjQM43NkEqsgGASN4+IGTPRFDeTEAxG93+ZI28U69jjJCj/vP72/q0BpvkA6k6/KYn2c8wSvzn5OTlh6w2Vp3jSfMkC1RrQf5+42XDUStEdWB84UJQPI/U5BiOQCaGr/6TnnY16DjObH7GqVr03Qas9HFH/3Q12Abyj3w76/BhO7VoD46QBq/K0cb+AU/I/PKdqd7TNm77ojFZ9BRV77OHzgBF8ya4xxKjlTKhwOj1fi1cFY/fBVGedsvDBbv+2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 13:04:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 13:04:30 +0000
Message-ID: <755876a2-92ed-42bd-b93c-10faa5b6f249@intel.com>
Date: Wed, 29 Apr 2026 15:04:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/4] iavf: send MAC change request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<aleksandr.loktionov@intel.com>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <jacob.e.keller@intel.com>,
	<jesse.brandeburg@intel.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>
References: <IA3PR11MB89861527E138BBA14FA907DCE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260429120047.218369-1-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260429120047.218369-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1646bf-cb39-4c22-f96c-08dea5efd9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: crVl/HPqNOsEB1uyMyW4vq6uezzS02/ru2YJTvC20g6C+7DOt1K/jsxl9uN2gY5NtETdIv3n14024MXvZpCG9mJ9eyMejNJJ2Yz5wERyPEF0aNT5uQxd93H9MNIXwmW8tHBCx0G24yM1cql+mZ75ak+ItEYnPxq82Y/NkzYiK+mKnME3aMHLWknXCmKYbQ1p4GW9ikjNGvosnC78bbw4G/qxQKuketuKlAJhHUw3rFmE+ioOuB+LrBKknCeQFSdf0dQBcCpm5a9aYhduKtPZplGVsMPlljdbLEA+Gly9ySKTAwhewlFxYc6ZMCjPCB7T5G/hn1fVoUZXOfxWpv03BYlC5J4ftLiZY+z1AkqJpaI0JVM+ta5fbhwdMAthUIULtYMYE7FCSo+M5q3mVcCG+m0I9TiQY0qLmtJRYb8rSffKjpobD1shgNLHJpq+7+UVmOqtwFpSVeKwOBEb8eN+AeLovdthyS+IJ9nexmhhMKESSfM/IZjbe0AZBmcnmyxydWoWcwJHZylrs9bbKGjJFbJUYODq5VfxqqIwx1GkSY1wbKrKS33dkaMyONOVADxC7NljhpP+RCSQtysbFjNyWoptiaVzgeOaedeo2aMHg1MD6kdaGxnDVwmngn0fra7l+JdYJbtBSsnmr+j+4oM5E7p/R21zOvOHL+CQMSe7wPLGcoPIZsrM21gHSulEl+P+cXN9Pen8MQCcuCKXKWdvjuaWQOS2xYmewnAVA371CRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRCZjBTcGZhWmJxNkUrN3N6R1NhNnVONWJLK2VmWGNwWitGWG1jV3RjeVZG?=
 =?utf-8?B?Z0g3MmxtUS9STFhXT291b0VEd2QreHlHTnJKb0FweGZTWUhUVTRodjN2NFNL?=
 =?utf-8?B?WVhUN1VqSDFRdDduUWc5UlRwVS9IL0drN05UcWkwdHZMZldpeVd5WjJpbTJG?=
 =?utf-8?B?bkJCT3hRbUFVaWEwWGhXMFl1eWdnRTZFc3Myc29hVVZtcWUrOGFTZHdOZlBH?=
 =?utf-8?B?bUVmbkpOMWM1UHpvVFFIMk9YZXpaWnNUOUE4TTMrRjNBVU9KQWd3amI1aERG?=
 =?utf-8?B?ZGRhVU1IS0w5eXdGOW0wbGZGV1QwUi9Uajh4cVpRUHBCYkRIWUV2NVMzc1ZE?=
 =?utf-8?B?ZDdUWmMrb3NuZ1F6SWk2amdnS2FMeWtZNGJoVys5STRveHY3bkRQcW51ZFEv?=
 =?utf-8?B?N09VNStFMmM5aExIelRiNmM5WFJ2akM4UlM0bStRUy9PZlRGMXJaMjhRbFp4?=
 =?utf-8?B?bSs5cVR6cWtBRnhTd3VFWFd5R3dLa09HZ2RzUTN6dEdSZFIvM3RoSE1PZmU1?=
 =?utf-8?B?MWtsQ0dNMk5yOUZETzhiYlJhQ29LZFo3SytMTlhjaCtVV0cyVkdpSlRHYnE4?=
 =?utf-8?B?RzQ3NVRNeGVCMFpVQjBUS2U3d3NQc1VNL1QyMmJwd2JTNklOREU5NEN1Ujd0?=
 =?utf-8?B?MUtzekhZWU1HTE11Nk9SbWtjeHRSaEw2SnVzUWhXc3FWZmJ1VE8vSFZQbklR?=
 =?utf-8?B?anVuZzRtYk5tc2QwTkx3ejZVL1BrR3FObERKcERMU0RCdjEyRWUxT2JHNWlB?=
 =?utf-8?B?TnJxdW0vbFZUZ1pvR0ZuVEFCR3I3STBHbmEwTkhVRGhFVzI5WEx1Zng2K3ZE?=
 =?utf-8?B?b09DZUlpamNMSkRGMERYcGlwS1VXenVuYjdEejNPdWU1VGxYeW9jVkN1NXZP?=
 =?utf-8?B?MW1KNjJINGd4MDBid0ZvY2NPb2ZTbXRJYlNHdi9GaTd2RENaaWs4NDRCL2FQ?=
 =?utf-8?B?b3V5dmMxNzNrbFBLejg3WkxiaW5ybWlMY3gyZGhvUHFwMWFoVGFkTlhLVUUy?=
 =?utf-8?B?M3ppaERkNmJzWjBYVldWQVdJVnY2ZzVHY3l1ZVd0WnRvTStzOXRvOTMrR05H?=
 =?utf-8?B?cWt6OVdFVVZBd0FEam1TTjh5Y3RsaHR0cVVJOTJ4T1pLVTVPMDdyTG1lVFVY?=
 =?utf-8?B?TDdhSVYyd1BMaXFvSkNMV0V2RnllcFJoZ3hQRUJnY1ZDNm5FY2haY2loZjNE?=
 =?utf-8?B?cndQUUZLSm1SeHl1M05jRVB1bkdiQVd0QUdxMTA1RzgrbHhIRnc1UTM4OWl1?=
 =?utf-8?B?RUkrdWI0aGRxZGV2TUxMZjlNWlZmMEtHazVXK0NWeFl6SkphLzdxRTF4dkp5?=
 =?utf-8?B?T2c5SFBIQVJ0NnhVU2kyK3BiZnVJTDVucjB6eEY0MENHRzJTc2F6ZTV1R0xK?=
 =?utf-8?B?dTVVYm1sL2toN0VXUHUrZ0syZTBuMWpIaWRjUVlxVGdZaEIyWTRiWTJmUjFu?=
 =?utf-8?B?bHdJTDBYS3NtNFBlVzZRWHp6S3NrNEI4SXYrWWxoaGE4TTBwd3Fmak54alVF?=
 =?utf-8?B?Y1JkMk1ySXFqRHVZVGJLcGN6YnpEQzVncE15Nk8rWTg3elArbVNQQzZ3dHJ0?=
 =?utf-8?B?R0Irc2owK1hvTzJITVdtalVCTTNvNmRNUTd4M0pnbDBFdGtKVGszaC9VK3Z0?=
 =?utf-8?B?WWhCU3dWSlgva1F3QVg1Q0xuZ1ViVFgwazN1UU5XMHJqN3hxY1BjcVpxczdl?=
 =?utf-8?B?RGRYWkxXZHJMdUNMU0lpUVdzcUZSTE9BcjZ1ckVHZ3QrdFZORkY4REMrTklr?=
 =?utf-8?B?RjBOWWtldUJ1RGZTdyszM25RbnBpUGRKNlBJU2l1NzZzTHRjYWNSRXE1Tmlr?=
 =?utf-8?B?RHlnN2tPMjc5SkxZclZTYzA2V1lsSjZlaXp4Z1p6dUROZm10R29wWGhYMVhM?=
 =?utf-8?B?TVVZdTFwRlFoby9XMS9zY2dxNmwrU2lzZThPMHVZU2NUMGlWK2JoblZsczZY?=
 =?utf-8?B?bC9ZUjN1c0lqdEVITnZOQUNiQW9YVW9MbWFxak9tVkhxNm5HVHNMNHA3OUhQ?=
 =?utf-8?B?TlJscGs0NS9BV0NTRG5HZFJyQ05aNVpSQm4rL0ptdFlIbFZZT3A3eXk3Q3JH?=
 =?utf-8?B?UmIvQWVvOGhuT2lLeDZjdU9EUE9kUVRMcGNqa3BGaXdpNDU3Q0NDWks1ck4w?=
 =?utf-8?B?RXBSUWNIV0MzL2NHQzBldmpjTTVWbzZaTURMcFdnM29Sd2xya29EWE90Zkla?=
 =?utf-8?B?dGNqNEk2MmZDWjFTVXU5Qy85MElLbmw3M1Fhc0k4MEppVkhpYkdObEZUZ3lw?=
 =?utf-8?B?cVNZSGlKb2pkRVJKcnhNZjJzLzFZeWNubXZhZk1HcjFVcnFQOHVKeWtIU0pK?=
 =?utf-8?B?VmpOck1TVWdMTk9ucWdRTWNGdC95RWNWM05WRklsMmpjZXNwTzQwYTAybE10?=
 =?utf-8?Q?ATJY4mugMb+z6sSI=3D?=
X-Exchange-RoutingPolicyChecked: XWOt2qG4L1sZdpdR9uiA0dnpF5A1yArP36qbPb3FLjATVIwhBYdqYi38BV2mutDvXDI/zmKJsfgTNS6EsjT59t9SQcXUMKGUhvGtCcM3mZp2nsTNlQ4JyWg0C1WMwTfS+Lak47K94jxkae8JTWnl2jM+NBSsWzuM6BS+RWSyoh9AGFZ6+QQv63YbT0WX/JKwuCM8lfQiIo1CONDnEEDR3DWVjmQs2jxqytAfE+keAZNT+CNeA6x5H8FG7shKGjWE8c17UFTkLa4Hu4+Urdy/J9bf6gR4s0yYqaq4CmNFhzQzmJacaP/2rZSzrtfHc6sDf6x6bdQ52FVg9/eYJquA2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1646bf-cb39-4c22-f96c-08dea5efd9ce
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:04:30.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQPw9v9fC//qfjswfrbbAzEDTrvk8TUVn4UJNnl/wlsyJmg5pVJecW1tNicfTubP+U4HO79t4kBoWPzIOTAqZq8HzNsJkz7utOy6e+UbJqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0A108494802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241882-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]

On 4/29/26 14:00, Jose Ignacio Tornos Martinez wrote:
> Hello Aleksandr,
> 
>> I think continue at the end of the cycle is redundant.
> That continue is intentional; without it, if timeout expires but there
> are still messages in the queue, we give up without processing them. The

Alex is right,
"continue" causes to check the condition clause of while loop, also for
do-while

> message we're waiting for might be in the queue and not a lot of messages
> stored are expected.
> That continue reduces possible false timeouts (because the expected message
> could be stored in the queue) while keeping the delay minimal.
> The timeout is really just an estimate, and I don't think it needs
> to be very precise.

with that said, current code is correct

removing the redundant "if" could be done while applying
(if that will be the only nitpick left)

after more thinking:
in theory, not checking the time but processing next message if there
were any pending on the previous message could cause infinite loop
(to fix that we should stop refreshing "pending" value after the
timeout, but only decrementing it - but I think that this would be
needless complication)

My Reviewed-by still holds

> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


