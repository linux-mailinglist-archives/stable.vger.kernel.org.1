Return-Path: <stable+bounces-225245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iZo3LQqXs2kvYgAAu9opvQ
	(envelope-from <stable+bounces-225245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:48:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF9027D4C3
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F943308954A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479807080E;
	Fri, 13 Mar 2026 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUCKJjmW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EE2772D
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773377286; cv=fail; b=p1Wdz4A+ay1PMYDcdYK7BJImulC3m3oU3MBM+x0JQdSzpO1CVVPRkTSLwlF+iEKtAWWZh3UTnYtLtZvPwxg2jHYYidI8l+qlClKotx2x7vEi6DP5m86rYcrbR2SH/YK45YJA2xA/X2a+9Uopd9IoYiA/uPBEXsUgWKhTN8geQco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773377286; c=relaxed/simple;
	bh=9SVzgeXNFtXgqUSqzZf/LNj06XIZDPQsN+vAqp3ZFi4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fexhWfDiNbcH8Lc6Xv9/DlpYh54mncuQgbn7jfGeYawC93ghO7KYbpxDPRDRSsnFlsM2jlW/2QIheWQZ0GomZdAgz98no5OnVPDm2nVahSSiSZ05bgQamSoDuHgrS7dMXhSBa4bAmg7iT6MAaKRhezm/yBGnQXSMt9BkD0XhKnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUCKJjmW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773377283; x=1804913283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9SVzgeXNFtXgqUSqzZf/LNj06XIZDPQsN+vAqp3ZFi4=;
  b=MUCKJjmWzUq4J/jBUhf/srs/CfF8g/zFn10iAkGYpjlAmJo9/kXIYbwK
   mFRJXr76jGfgnjJA1lAvLb36gKhZ8ZVXkZHKhbYYmu8z20IWYcUvM632R
   ncrw4YjRlTruxT+AafMOBw6g6yzw5q647BHRdk8Lb+Gm0rIedDIr+7mtI
   0Bwa76dGEJyQOtil2ovMUBBR+p45aAxFY3uzQGiQWOx3W05xDBXEkA3Mf
   qDr33zKVPWIiOnT6w7wmnNYbDUOYG+d2HeYTZNXsaj2mwFAlDFU6pNW1/
   Nvlt3VyiQi1L6mwsrkFynlPahpfbnU2cIkX9BYyJq82J6uCP+9/MBkdNB
   w==;
X-CSE-ConnectionGUID: 4uJgA70+Q/6H8VOj6Zo+Fg==
X-CSE-MsgGUID: 7JJ5zgfZTwKXW5BHSfaTCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74378105"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74378105"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 21:48:03 -0700
X-CSE-ConnectionGUID: 5q7gekEYTCO50u4SlZckFg==
X-CSE-MsgGUID: 2DtaAdENQc+wkq7Y3ahcZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="220999517"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 21:48:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 21:48:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 21:48:03 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 21:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLB9bbsibQpYilfIcYfxk4bJo8K6d9HxUG6fMrhK+3KRUNl62Cw+A3PiJSxg8UbASDJnoEjctqZlMCnkD6JZutBosoCfZkVEkm45/RB0xXGIzxPOvATeVSe5a3tj+No84e1WU9zIxrsz9DrFSWXuQofY0AQZc4kQl/L5PJ5O6B9lHdqvL/4Sbfyh+vhUM2y635AnsMBBVv6jpdey4NU+et0DxqU14bQ9GOMIxjA+cAsTGMTeZVWuYO+keKnHYfAN6NWRh/OeWt4hawfc/6F8y99z/S3yvbtucZeTq9XhltEfzpKgySkQmLgP1lI8oJW80MnamM1KmzyommA++NR3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzSt2Tp1Hb3FnuaXzDgG5sKVPD2ACCaAaM8mO9j9s6I=;
 b=FXmoY4x+P4yVU5OXWRkJw8MthnUOfw9rSWY62ntvvD8bau4S/BQQOZKYaXrtCXuyAyJlnWd47WODN6si2lIQ0n/zu1D63mG1QXC1nZOsvyxUr7hJcKX5spR5mZC9xaqU7mTGwVgiG5auJ8SKXvOXQ9j5R6pMVlhf8PgPyIl4oYpFRHH2oouE8FejAbDMHiaZSt96ligs79wtDWP6EBnzThw1oOACevrgAnHMGydqMKFnMw8CtIrgdjz2kuDGF4qk+60EzKQQNUZbeSvNSyrYXr69uN2bVTcqhc2LZyt5COxpdOqAeL/yexl+JIlRmlZQdfEHOwdOkF9FvIAlXGliNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 04:47:55 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%5]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 04:47:55 +0000
Message-ID: <5f76fbc9-fd5f-4a54-9164-28cad83dd284@intel.com>
Date: Fri, 13 Mar 2026 10:17:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Auld, Matthew" <matthew.auld@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, "Brost, Matthew"
	<matthew.brost@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
References: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
 <DM4PR11MB54561F96FB88885F0B7C4CE5EA47A@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <DM4PR11MB54561F96FB88885F0B7C4CE5EA47A@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::9) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|MW3PR11MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: a333a4aa-0057-44b9-3c77-08de80bbb103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: mak07Au+MZj5xMsv5Q8E5kNH8Xepi0oFqDtOtXEMTW3gncxD7BpFUFSQw3MuIRepYdQ4L1/aLuIxHtD4xYvGwxRhC76rJg3L6gpiQQY7+3YzIjXJxWjW9mfoLp2/nv8cEkmE9Z4dHibQSFlRjgodkk1DK+IcBhMAAgCclTJTutRSBLfm4H7AfCj2pW89+72ylvLtp6o0zVE9ciA2QSjcAhpIdlzfrRv9U4MVEVo1Sb2H9hVS2lVls6sScfetijXMxzQq6FOnZYQMpfGu3yGqxR80SaNQ+APU85dg0Yzm/bHPGLlv7LcZu2wnPXLkdCmHxaSSaQr5abSAtWYWmFuhSuuRKtqfamPVQEkS0IxSaKUPuGsS5bwsV4llBeYnk4ZcUihMntB4f5ht99vJ9/ZL+Lr6GvX8iqPEj2rYZDh7BGDIgh9/6VSIq6HW5JQYt9e2ss3VAc4PxrK2B7gJh84XEvFz9aVmqTX11RFKuouypBEc0AJZeROocUUPHr2BQm1TmnXR++XaGdfeDZKhQHtsP/dzsUG6vLim/s07thH55B5Vq7vNl0IYqHVBmux5hEZnGgMfoAoNLXL6qjAsxBm0NYvCpQfiYMmrmdJE00uo/SlHwTJSVHKwWGyOFXVkwdWpyEJS/xlzmnXR8/Wcqk7meEq/Ut/txPyM3EfoYI+GfuVLibo4UzSLRsYp7CXg8JDE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8208.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhnVE8wcDl4Yk5sQ0JUL1hKOXArQ3YycEdiYm4vekdLcC8yTVNJV1Q1aWRW?=
 =?utf-8?B?aXRPTlhqYzFZTVNrWUJQb1ozOWZZdnZKZW5YNkNRT2xTOGkrcXZ2T0lhZkxV?=
 =?utf-8?B?UkUxV1RUVVFoQVJ6dzZ2VTBJbDVnNk9Hd2Y1Z1BoZE9wU2VNV3JsUGxuUE1C?=
 =?utf-8?B?bXcxcGF1N1o2L01yZ2RxV0xxUHk3L1k0dFAxT0JyQi8ySGgwZXJVL2xFdS93?=
 =?utf-8?B?YVQwQ1VkOEFVWTJnWEJQQVcyNDArNXc3emM0c1FaMUJSa296RW42N01Bc04v?=
 =?utf-8?B?WDV4SkR2UGdOQW4rdlFoN1pQWUJxWGdPVnN4Q3U3K2NHS0IxYWQ2RnFzSHBX?=
 =?utf-8?B?aHBlbzdiMGtoQlVCWHRKcklmSWZsUS9TUUh6cGVWTEJVVEJ4QXl2UUthWm1v?=
 =?utf-8?B?QW5ka0VJa3pEQk1xVTk5ZHkrMWhJM2gxc3NsQXRUcWZXZEI3L0lIb1hMQWxK?=
 =?utf-8?B?UFk0L1k0dEJUWmdMdHM4SFNxQllWVURkazdGa0UwOGdNaFUwTi9mOHVndys5?=
 =?utf-8?B?WDVGMG83SU9lb2UwbmUyN2pmSEloUDN6dWZLZlJmQ1lpeXVwZHpFVnZlMnBR?=
 =?utf-8?B?R05QMy9nSklzbmRYNjliV2lzdkpmRGFjWWVnUzhlOFNBSnlaOEJKY0lSdlpW?=
 =?utf-8?B?eTdnM0VMWXRqd2oyYVc0SWhhMlhtNmRBdlhKbXJWY0NpTlNNOE4rWitTZlRO?=
 =?utf-8?B?RUxyOWljM0t4RWgrMHZNdnVFd3lLT21YU05HR2FyeVZNSWlVdkI1aWRSZWRr?=
 =?utf-8?B?SDBBcThaa3ZlUVdjczZnZ3FvUC82dTF0UldPUXdsUythL3BMSUxCWEpKc3g1?=
 =?utf-8?B?MTl6djN6SDMrRytRZ1VaaFpkN0JZVmxoNVRIa05oeDF1ZkMzNUdoU05tamZh?=
 =?utf-8?B?MlcvcHMrcUwzeld1eUpEeWRJSDhnMFg4TkRJTzk5b2QxZ1dyeGd0d1pVWnJD?=
 =?utf-8?B?d0VycFBHSEJYNGo3cVlsZnVTVzdEUHExMXlEWnNxRHR6emNhTkdwbFNlSnFp?=
 =?utf-8?B?UUlxZWtydlNzam51cmlnRlEwUkZjaVZUSmJyWHNnczdtTFBob1Q5clUrdnNI?=
 =?utf-8?B?amxjdmloczNyMnY4WHdWZlUvMDhCd2tTNVkramFaRXpFVTJzd0x4M0d6SFBS?=
 =?utf-8?B?cVN6cytKcitOWmRmYSsrZEF1UmZWbGthZXB5dFNkYkdqNitjeFBIRjQ2cTdo?=
 =?utf-8?B?cGRSUEV1ckczbnh5cVR2anhJN1J2SFhIY240TE1WMXpjaFRRVzVxbkpoTVFB?=
 =?utf-8?B?bnFMU2FKdnZweGM1MGlQNDFIcmpyMm1jb2V4ZGM1YWxxejU1amVxa2ZuMUFP?=
 =?utf-8?B?RWFqZksxa1lrZXNDNnJHVnhzOFV2NGFOc2IyN1ZVU0YrMHM0a2s1dlAvTjNM?=
 =?utf-8?B?TlZRRVVLSkRXMXVZRjlzRGEzYzFTQTlpUEFEYm44SlVBcVRhaThLRmRxbWlK?=
 =?utf-8?B?cXZiWUx4cCtXT0JHcWxNY3p1NWx5dkg0U3VDSnVKdzJtVTBkS3lEMXFNMU5Z?=
 =?utf-8?B?YVlzbDlxMzlNUzEyd0dmRnN3TGgwMXc4Q0FNT2I4bC92QkJFOE1Xckp2WGZ0?=
 =?utf-8?B?cjAyU3R1dE9NOUkycjlpLzFZTTZtb0xTeW9wZXV6ZGFDbGRaTE10Rzl5czVu?=
 =?utf-8?B?aEFpT0RWejFWWDArcnVob2lJa0twRDc5V3NqVzBZQTMyb1lSOWo4ZEF0UGc1?=
 =?utf-8?B?NURnN01MNGp6QmpQTUcwc05PUk9hSE9rMktFQ3FWazJlTSs3OTZ3Q05tc29Z?=
 =?utf-8?B?T01mRmlpeTd6ZzJscC96MHBaOVpxNm82VUY1T2FlNklMM0ZDaUkxa0M4VzV5?=
 =?utf-8?B?b3poWFNLNFI5RVpvOVY2TzUxaWtsSENYTHByVUpCUlF0MU02NVh5M29Oa1Mx?=
 =?utf-8?B?bCtzS09OMVZ6UFFFWTJtLy9lL0Y1T2pEWXFsQk1HNXc2YzZIWXQ4ZUZjZEZJ?=
 =?utf-8?B?a0NHdDMwOFpabVdkSW1CeDdWMHBNMzRVaHFOSkQ5TGxyRURoWnBncVFHdnBv?=
 =?utf-8?B?TlpXYTNSNlBzUm5LWlFaV0dLMFg2THRqaWFwbDBjcU1XZ2NQWjE1Q3hhUGJ0?=
 =?utf-8?B?QndIM1NwVWwzbTRmaXRwNVFJK05tbkVNV0F0YmV6VzJudEp4UHArM0YzTEgr?=
 =?utf-8?B?UGhvMVBqYWIreVYxRTR5TkRaMFl4M1RjdFo1YkM3R0UyWXdUZ21jT2Q0b2Vy?=
 =?utf-8?B?SXh3K2I1ZWFKNGQrb3FuNDlTdVNsNDh3ZnpuSE11RDBEZWlVaVV0eEJjdTVw?=
 =?utf-8?B?NUkvRHNSYkNuTGNFM0FMK205TklqYzFTNFN6STQ1QjNLa2FrVjk1ZEN4NWRq?=
 =?utf-8?B?cVhEVi85NVQ4OUhScEN1bDJnWk9CeDk3cW5BeVIyRGxxdFZUSlpEcFdDV29a?=
 =?utf-8?Q?He/VdOYgirKYK7GM=3D?=
X-Exchange-RoutingPolicyChecked: ZmsX0iI8naA04XE0F1XTRzsyPACSk/SrpDIN6YMdSLmYpE0QtkLAb7zRNn39aldKg5/GzDhC0XFGSE+6o3+YHG9g3EhmnqVhG/i/GShnTLgj01tNQSHiSXLC77QrrxU1p4UKX2IU+ezCdZcvaKjcKTVXXOBxxjM+PilJNZPXkB4j0cX/JKXPCRUw3E2OSkHjBt8ctSvVYpqmbjIXBusCDVYz3TzLTwC+NcuTTB5JUkV0UM9bwb6QCgPsSYX3NwO0I+iD/Co7Scq5xU43jFQrIjrGelZMAur5aHvA8m9F2ZePHdicfjpe3OwMsdj+YUUk9aj11XLScv/O9Ud5ZojAMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a333a4aa-0057-44b9-3c77-08de80bbb103
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 04:47:55.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN/grwhNdBVAm0BeMbcyuenfhllGMmrtdFgFbauiR+MzBH47vC/+HLkFmnlSz8SQ4M4DwhslynHBFZUwmfqJ7QyUcmlzVFiiYJ1dfqGxbGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225245-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjay.kumar.yadav@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9EF9027D4C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 11-03-2026 23:52, Lin, Shuicheng wrote:
> On Wed, Mar 11, 2026 9:53 AM Sanjay Yadav wrote:
>> ccs_mode_store() calls xe_gt_reset() which internally invokes
>> xe_pm_runtime_get_noresume(). That function requires the caller to already
>> hold an outer runtime PM reference and warns if none is held:
>>
>>    [46.891177] xe 0000:03:00.0: [drm] Missing outer runtime PM protection
>>    [46.891178] WARNING: drivers/gpu/drm/xe/xe_pm.c:885 at
>>    xe_pm_runtime_get_noresume+0x8b/0xc0
>>
>> Fix this by wrapping xe_gt_reset() with xe_pm_runtime_get/put().
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7593
>> Fixes: 480b358e7d8e ("drm/xe: Do not wake device during a GT reset")
>> Cc: <stable@vger.kernel.org> # v6.19+
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_gt_ccs_mode.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
>> b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
>> index b35be36b0eaa..f3b834a09a6d 100644
>> --- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
>> +++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
>> @@ -12,6 +12,7 @@
>>   #include "xe_gt_printk.h"
>>   #include "xe_gt_sysfs.h"
>>   #include "xe_mmio.h"
>> +#include "xe_pm.h"
>>   #include "xe_sriov.h"
>>   #include "xe_sriov_pf.h"
>>
>> @@ -163,7 +164,9 @@ ccs_mode_store(struct device *kdev, struct
>> device_attribute *attr,
>>   	xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
>>   	gt->ccs_mode = num_engines;
>>   	xe_gt_record_user_engines(gt);
>> +	xe_pm_runtime_get(xe);
>>   	xe_gt_reset(gt);
>> +	xe_pm_runtime_put(xe);
> How about use the scope-based version: "guard(xe_pm_runtime)(xe); "?
>
> Shuicheng

Thanks, Shuicheng, for the review comments. I will incorporate them in 
the v2 patch.

>
>>   	/* We may end PF lockdown once CCS mode is default again */
>>   	if (gt_ccs_mode_default(gt) && IS_SRIOV_PF(xe))
>> --
>> 2.52.0

