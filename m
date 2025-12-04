Return-Path: <stable+bounces-199993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE7CA33D4
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 973D93026FBE
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687532C21C6;
	Thu,  4 Dec 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwFLOWsE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63E1D6AA
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844455; cv=fail; b=Dlj+oE+3JZQhad3CoM0dVYRp8EI/64kgSL5ad4cE8kbetThqxoMPg0fkfzsXQYWPKL1L48gXakRSFTXxB9c7diYjmM//zqYIRqoijO9/CcVq8MCGp/fW8KU4me0sun9BgsLdn9B15/CXrgjRiVkxUIQfEaN+O2CwF0/04/SnLpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844455; c=relaxed/simple;
	bh=1UUU5yQsqzlv7LjFZItepCm8l2KhkDxRcc4jywdZb0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlOPa0j1skd/cI9qHCaDpirVqDTGZwXj4kpLyZaYMU7Z0LwD1tdKefNf4JHdnJeOmQLhYMhF8CykWHHxJ2gEGGEXAoQx0MsZb0XavCXxIrAwDvecWsR9xC6Fb/hntS/PyhklJ+JAIUXq2QlsFvUkJoVhxMX3tElPuWK8N5N5gk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwFLOWsE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764844453; x=1796380453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1UUU5yQsqzlv7LjFZItepCm8l2KhkDxRcc4jywdZb0o=;
  b=MwFLOWsE0CG+BmCcelHyShmJ69eTYxXETLfH5LlhQDLa69aWgQ8NEIXj
   dWJHaGNx9WZYRO4+Fv44oLopeqn8mDfVJwJ1JqCIh8NCsgURy1IMB/OQj
   1T0bDlRlSA6i/WUigRcw3WfHBs1EAtP8/cWNYs5PmsmS/fT1YTxEAu6uU
   iWyMfnxhPdvmBkkqYtR38zgjIyKE5gkXvCThAlzgQPqXG1FvmnPNxDQxX
   9thyWL340/FBLJFgNgJWkEIiQ/Mx2tlz+9CMKqQzcmIjuqfSfZ4D3sxjh
   M1f8rEqmUDk2zW/qOaxUcfngbEebT61iW7Iu9162DE63scOJwohrTkoqJ
   Q==;
X-CSE-ConnectionGUID: Mv1pJ1ABRtG1auCo2ij+7A==
X-CSE-MsgGUID: G4yqqwgDSECduDSgIIQQhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84461627"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="84461627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 02:34:13 -0800
X-CSE-ConnectionGUID: iCHD0zYQTlmj+W7LwTQX0Q==
X-CSE-MsgGUID: nD+FKvgcSxOy0eurV8iRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="218302785"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 02:34:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 02:34:12 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 02:34:12 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 02:34:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLJct/eoi8EN2QagCjBUatTAp0D60SB2rifbm9fT/p5JyJxuVrq1LKhPo2Jau5DtN6H7Fu4VL9u7KGt5o0MR2k2AmONTTD1gsrwdVmNvkftm4kq4VGCSSe02JbYcJxxL43wZsSC06WL/+8hW+Vqw/1/GxrVe4rizYiKuKBsTR8gi3i3O5E6FFm7r315zjWpwRS+Rw7sqMGWcoiyAr/sjluWqI2xjYVm356SQIRY5OxIOXhcbeJzRgwVCuLZUkGEyQ8p61Rba++HAs3gEqox85/ZVY1x4j/b1rgFu8MridwyKyAeqg3w+hWKBGHgF25hBMyI3jsKqXTrIpO97AOoUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfhA6koELXINNHypozcUnPgO6OcEWkvcw31xPLoUEGc=;
 b=Q3i47ajJH0oyqCQ3aDSGuBlipqIBnO8XOwD6UUw9I6dAfsKahdkBXw86bifxYQ/G0AGXV0hHqCJOROd2rabugFKFzP1UwN+Iq4sOLlsIAcPGxUSwAkLyADVTSYrukdNhIIiuNMEogQ4k2643fUp4K351R4/06zhdYbIKbXnAn4KWEar4LfBupZhwZTdEIXQ7PGkY3ClPExfDEPaycuapPcyZHl7sMrMhsDIeBmdKxw/mgrN28bLgkO2fiJ0O0IIjegSIJpsIvvPhe/ITw4cmqE+DuhDQqKS7LUFrCN9lS7UxmRwDSQFTio5rbaNMKhg7MGKWxvAEUn+Atsouo7lprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 10:34:07 +0000
Received: from MN6PR11MB8146.namprd11.prod.outlook.com
 ([fe80::3bc7:767d:bb72:a6d0]) by MN6PR11MB8146.namprd11.prod.outlook.com
 ([fe80::3bc7:767d:bb72:a6d0%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 10:34:07 +0000
Message-ID: <6ace6e5b-f988-42a3-8b49-d50175d9af85@intel.com>
Date: Thu, 4 Dec 2025 12:35:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/exec: Validate num_syncs to prevent oversized
 allocations
To: Matthew Brost <matthew.brost@intel.com>, Shuicheng Lin
	<shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>, <stable@vger.kernel.org>
References: <20251119024253.91942-2-shuicheng.lin@intel.com>
 <aR08PJU7lNlwGaij@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
In-Reply-To: <aR08PJU7lNlwGaij@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00007578.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f5) To MN6PR11MB8146.namprd11.prod.outlook.com
 (2603:10b6:208:470::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8146:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 71545ebb-cfc9-4642-e6a1-08de3320a74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlRyYmFpWi8vVFRLTVpmUzhHWGlBdXNoKzNNSTdyRkw4aEtRUm1tWldOYThP?=
 =?utf-8?B?LzYxazgvajdPeVFTUXdkOTdRZjRGL2pkMVh6dFZPYlJnVCtCMW9OSytFcFYy?=
 =?utf-8?B?RUVveHBHb1NTMlpiZUdORWRVNG43VktBNVJ4elhTeHZwdVBxeDNPTjhDV1BD?=
 =?utf-8?B?Q3g2Nk00dGlFelozNmxtVEtDa1FkTVFlV29HK2ZpTXoyeDhEc2tUajdJTTVH?=
 =?utf-8?B?Z3dFQ0xVWTllZmhwSjNsc1FZc0ZMU1JZSmlMT0JMZVg0N21zRGk2SFV0bmVa?=
 =?utf-8?B?cVBNYXZKVWxSVmpSYTFidVBaY2RQNFhKZHBKSEtiUzRsVFVsYnlsWUc3Ry9t?=
 =?utf-8?B?Qi9WQmtZbHUvNjZxekpmUndIWE9kMGowMXhndjAvZXNaSm1sRmhGODNiWmVR?=
 =?utf-8?B?anErei95bkg3Qk9KSlBUcGJlN2l2SnJSUy96dW1yMTR3Rk90dlUzMTJXSVVG?=
 =?utf-8?B?QkNNd0dYcFhoSTVHQThvVk1ucndsOWgrbWpIb3BPSEsyOTgvMUdIVDYrazVW?=
 =?utf-8?B?VHkydDdoaysvY25JNDNHdmYzMlM5VGRPMkJCdU9MaTlJdkh4bXNobWdCYytm?=
 =?utf-8?B?NVhHR1E4bURYMytUbVJWcS9hM1gvMUR4MlBJZkE3UHFlcFcwMzlQRnpLMVpS?=
 =?utf-8?B?QnBaam9IN0p4SlJEMDdyNGV5WGROdFl5b3N5VHNGYi9tMGhPZGRQUzJHcmZl?=
 =?utf-8?B?WFlwRGtZYnRsNkJvWkNjRjZmY2RjMGhpUUlKSzIxY0Y3SUY1WC8rQ1h6d1dC?=
 =?utf-8?B?cy9IOVE2Rm9ObmFLYkVjUi9vZDdYdStVWmFoMXpxZmZqY1hVN3pnMVZucStp?=
 =?utf-8?B?RjRVcm83VTVFTStIb0hDNk1vdGREc1hXTEtaVEpIWmpsUzVLakZFbWt1NGJr?=
 =?utf-8?B?QWtBUzdPRGtXTzRkeTA0R3pVTWJOVTczd3ozQ1ZkVS94THYrZjhHdlU0QjJO?=
 =?utf-8?B?Tzk1REZ1VUN4cmV2dDBiQzJzODdkTGc2Q2JSOFltbXRHNkNWWkxuNWNlczA4?=
 =?utf-8?B?ZWFUZ1VaSDAzMEFRaVZqZ1diODNBdEJEL21sZW5MNnlyOUVQYWhTMTQvVWJL?=
 =?utf-8?B?RzVmQWJZdEhGdmlQVXR0bzJYR2xabytRTDF6MlNWcHluN3BjeTI5UUszUkQx?=
 =?utf-8?B?STdBTzcxeEUvU0hzWXoxVDFPWTFydG9nc291WTdCV0xCMGZFbkV5MUVPVkZI?=
 =?utf-8?B?QzVpY09yMVRnOWxrRDFBT2lnS095NVJuRlZiRnl4aFJMUEJBeTVzYi8vZG9s?=
 =?utf-8?B?eGN3ODlFa1NKRnoyZWhhTm9kTXN5elZ2V2pqM2hJUEtDbUcrRHRPMEVPeVp4?=
 =?utf-8?B?ZlQ5bnVFeW1NdXlUT1p1QTlJdTRIZDA2d0VaOHhTT0RRbFBycUVEdFpvZjBm?=
 =?utf-8?B?bkZZdCtnN1NDWDR2NlBsU3hTblBGcCt1SUxwZ1YyZFZ0RVlCdURlbGZEaWR6?=
 =?utf-8?B?a2c4UXBjWVRKTElVWW1ybUFNWmVJYjlOMkFTNnU3UTlvZmxZcXpCQllNbTg4?=
 =?utf-8?B?bHN0Y3dZdXB1eHpzRzZhQnVDbndFS3VqVmU5SGtEZDZ0T0ZrTmQrQjhuSytw?=
 =?utf-8?B?ZG1KYTcxdTFTbExSY1dPdkF5akdzc1pzaS8vU0NzT21yVGhqbmlncGFGT0di?=
 =?utf-8?B?OXJ2eEd1MTY2elBUckhLQmNBNll2MTBJclZFWjhFcCsxSS9EWHM0dWVmbXhs?=
 =?utf-8?B?ZFdQcFg5d0pxSnh4dmhrY1R4ZVY3SGYxd1ZPWFoxVjBVZnlRd1JuSmhUZUVU?=
 =?utf-8?B?UklhVkFsb3p6aTZuaVdNZnZPMnI0QjhLNUhSbHZLcit0cDNlc3JMTjl3czBr?=
 =?utf-8?B?QzRnaHVEMDdkc3U4R3Y5WHhQSk5tcldtR0laeGRsRmpqVG5vZEV3MkZDRzgv?=
 =?utf-8?B?YklOZE9BNEc1aDE2M2c4NkJMR1NQQmVVSlg4TWJ5QmtkVHVTdUxPcWF4cE9K?=
 =?utf-8?Q?a18YGVY8s7tyv8IOHTtWfX+zokuI667C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8146.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDI4SDlFaWJ1V0I1YnNBeUo1NWRnd21IRVZUbldHL0RhSExmUTJIZmFBMU5O?=
 =?utf-8?B?WnhldlVLdXBPdTVQc3pzUXR2S1FmSU1BdDZ4eFNGRGxyZ2xacGx2aW5wMmwv?=
 =?utf-8?B?elZZeldBaGpMYkY4eEpvRUliV2VvMWNaNzNEUTBJNnR1V2RzWENEQng1QlZG?=
 =?utf-8?B?MEh1T21aQVZScExyVXhDcmkrQWtKd3U4ZloxSkpnRk5GdU5qS0RXU2FlTEE2?=
 =?utf-8?B?MUozRlJZOFJmcFcyTEJCL3ZDb0p6a0dtWC9oQUEzRUJEQS80dVJjcDljYnN4?=
 =?utf-8?B?ZGpaQWhqRW1kUk9mZ0hFbEhVcFVkaHhMa0JlOUNyVHE3cnc1b0p3YmY0YnNq?=
 =?utf-8?B?cU4rTkJIT051YTlIZFRRd1hza0g0b09CY3NsYTJZQ0NQWEIrZlFpRjNXSFcv?=
 =?utf-8?B?MkR5UTVxcEVsOTR6TlQvQ21jWEUrQmJuQlJ0Q0pNSE03SXB0QUJvcGtSeXJk?=
 =?utf-8?B?TGgyd1E3TGpELzhXamQyVlJYQzU2Tk13UTJNZHcrNkhsc21DWFZnQ2VyN3RQ?=
 =?utf-8?B?UU5RdDl2dGVrbHRPV0lpa3IxVnl1bURJcnVYVlhGcU5yZld4aTJDRS9uT3FX?=
 =?utf-8?B?Y1Y4YzBxWmduZW1rS0ZNWmdCZ1NnUUJzUS9BTHZpNlVpb1J4bEJ5UEhUUzYx?=
 =?utf-8?B?aWpLVHRBd054cVkvNXFLRU13VVRURCtzb3BRZncrZE41c09XOXIxazU0dkNM?=
 =?utf-8?B?c2oyZlNoY2JBbmI1N3ZuVUhwaU1VNmNTbjBTRXJ5NWNyQ294M00zb3Z4RFFm?=
 =?utf-8?B?ODZycTFndFZ5bDBlajZWdEI2NGhiNDlUTnZqdHJDeXdLeDZacnR4M1I5OENx?=
 =?utf-8?B?SVMrZWZZdFRVYmR2NGxYV3IrWmpLY3UvQ0MyQlNtdW1VeXFtYUVBb2p0bDNm?=
 =?utf-8?B?MEF2VHArYjJOQ0VRdEVYVTBreC9JUzlvN2xQN2hNNStydHRVcDIwcW9SZFlm?=
 =?utf-8?B?OHFzVmxHY0tRNXZXN252U3R3U0JMUFhRZjJ6dDJCaXRZQ3BuODkvSTNsRWs1?=
 =?utf-8?B?ZmdrZzRNSmovSmt6U0dERW0vUzJibmF4M1AyWm1SNXF6RGt4WlZVOWNLNWdZ?=
 =?utf-8?B?RE5QTHNjNHFCTFVsZlNaVGpHUGpPUFpLQ2o3dzRDeFVOMVR5WUtaSFNWMmgx?=
 =?utf-8?B?SnYxR3RZdW90MWVZZWhlVW9YbzU4Y2JWM1hSVEdSOTRQenUrUjhoS29jV09j?=
 =?utf-8?B?RCs1QXh2eHJ4NExjb092SzRiVHFicjNFbGZXWmQybW5QdThaQitzaUJWL1ds?=
 =?utf-8?B?MEc2YnFXb09LU1M1Vk1qZ0VrV0NDMENaK0NwVFBHeEFyUy8wQkRGNjNIeUFD?=
 =?utf-8?B?WFlySHBLV1NsUGFrdFVmZE1oRURjbEc0U0VYWHhEZGlyYmx6VVNlNjNpSnpm?=
 =?utf-8?B?bGhUWThkZ2xVWHVQQlgwUTdBQ2hCQk9FTWZ1SWlWd3crWXMydjlvVDFiREtC?=
 =?utf-8?B?cnJIbWVXRlBEOTRQU3RMMzUyNU9KanZOcFNpemlGMWNtUGtNNjg1a0d4Yk04?=
 =?utf-8?B?ZzVyMytOK3pGS3h2STJLMWhEVEM5ZVdvQS9nS0ZqZ0lXbjRpbWpvdERSU3Bl?=
 =?utf-8?B?NFZ0ZER0T29HQjFqUGtVVGdLdU9WTnZNZmlBekhuMWJLaW1CQ1YzWTFva0Vv?=
 =?utf-8?B?M0RpTGdrN0lNODFyTTZMaVVNZTV0UUlRWUl2Nm9DckhaRENISlRVaWhVdEF0?=
 =?utf-8?B?WDBuNXhoVXFsMkFOZHZsMlhobVF2Y2RYUVdWUnltWElieENFV3MyTlZUZ1Fy?=
 =?utf-8?B?SnYrc0FFTll1c2ZSNnF3azRSVkNIUFZWeFRUaWxWNFlNbXMvYW4xWTJxeEJG?=
 =?utf-8?B?KzZIcTJoRzZWRWRCMUNNWFVERVpnQWp3RVIrV0d0T1d6NWhNaUlKaGdBTnBx?=
 =?utf-8?B?WUhtd29OWHZQenJGazlwSVVIVmI4YU1lSGZUM3Azb1c4QytKQTkxb1hhZ3RP?=
 =?utf-8?B?VmlKdVk4ZXpWL21TUS9nTExQV1E5N1NnVVNKaWwzRFhDdmNqVjJpYS9uMzhE?=
 =?utf-8?B?YmJCOHFrcCs2U2hSVEZQY3VZamx2YTVBYVRVc3hJQjlNMXdEcEtIbzFPR2g0?=
 =?utf-8?B?MkIzeWxMSVpwaFBVR3JIajRnSzNiZVdTOXJHb3NPMTVpUDhJZXkzRnlkcExS?=
 =?utf-8?B?TFNQcnFGYjY5Nk9GVmozN2g4aUZNcjNlZXp2SWc4WG5UMHVRUWxBSHlsMlha?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71545ebb-cfc9-4642-e6a1-08de3320a74c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8146.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:34:07.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8N7nhaX8hzn2S8bBgWYxQeeEpzBItQTd+n3jye4bZMrIvlKMhlOKaot9bxoPlOPjEW/ycHs7WZbUWbBk17W0CNbmExSMcLjNNZLD+BWeQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

On 19/11/2025 05:40, Matthew Brost wrote:
> On Wed, Nov 19, 2025 at 02:42:54AM +0000, Shuicheng Lin wrote:
>> The exec ioctl allows userspace to specify an arbitrary num_syncs
>> value. Without bounds checking, a very large num_syncs can force
>> an excessively large allocation, leading to kernel warnings from
>> the page allocator as below.
>>
>> Introduce XE_EXEC_MAX_SYNCS (set to 64) and reject any request
>> exceeding this limit.
>>
> This seems reasonable, I don't think any existing UMDs or even IGTs
> likely use more than 64 but I think we check if VK user facing
> interfaces allow more. If so, we might need something higher than 64
> even though it is very unlikely use case.


Yes there is 
dEQP-VK.synchronization.timeline_semaphore.misc.ignore_timeline_semaphore_info 
will use 128 (64 waits + 64 signals).


-Lionel


>
>> "
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
>> ...
>> Call Trace:
>>   <TASK>
>>   alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
>>   ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
>>   __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
>>   __do_kmalloc_node mm/slub.c:4364 [inline]
>>   __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
>>   kmalloc_noprof include/linux/slab.h:909 [inline]
>>   kmalloc_array_noprof include/linux/slab.h:948 [inline]
>>   xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
>>   drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
>>   drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
>>   xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:598 [inline]
>>   __se_sys_ioctl fs/ioctl.c:584 [inline]
>>   __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> ...
>> "
>>
>> v2: Add "Reported-by" and Cc stable kernels.
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Reported-by: Koen Koning <koen.koning@intel.com>
>> Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
>> Cc: <stable@vger.kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_exec.c | 5 +++++
>>   include/uapi/drm/xe_drm.h    | 1 +
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
>> index 4d81210e41f5..01c56fd95d5b 100644
>> --- a/drivers/gpu/drm/xe/xe_exec.c
>> +++ b/drivers/gpu/drm/xe/xe_exec.c
>> @@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>>   	}
>>   
>>   	if (args->num_syncs) {
>> +		if (XE_IOCTL_DBG(xe, args->num_syncs > XE_EXEC_MAX_SYNCS)) {
>> +			err = -EINVAL;
>> +			goto err_exec_queue;
>> +		}
>> +
> I think OA, VM bind, and exec IOCTL should enforce the same limit if we
> need one.
>
>>   		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
> Another option is kvcalloc which allows large memory allocations in the
> kernel. I'd lean towards some reasonable limit though.
>
> Matt
>
>>   		if (!syncs) {
>>   			err = -ENOMEM;
>> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
>> index 47853659a705..1901ca26621a 100644
>> --- a/include/uapi/drm/xe_drm.h
>> +++ b/include/uapi/drm/xe_drm.h
>> @@ -1463,6 +1463,7 @@ struct drm_xe_exec {
>>   	/** @exec_queue_id: Exec queue ID for the batch buffer */
>>   	__u32 exec_queue_id;
>>   
>> +#define XE_EXEC_MAX_SYNCS 64
>>   	/** @num_syncs: Amount of struct drm_xe_sync in array. */
>>   	__u32 num_syncs;
>>   
>> -- 
>> 2.49.0
>>


