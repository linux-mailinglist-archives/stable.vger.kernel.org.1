Return-Path: <stable+bounces-134651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC809A93EA5
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488DB1894022
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8FD21B9CA;
	Fri, 18 Apr 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoU9Ba/y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD756DCE1;
	Fri, 18 Apr 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006652; cv=fail; b=I0Kr/4lzcHxSUQMjUvHOHOGq42ytSID2uI0R9wGbfzbMYeS6zrJgSnTxpnOBIpJhKY1btC7L/ok0r85NO92/N+h8iMf8giSdzQk/F88+Vt0vIgz8d9ir0nyc1FFv9PqzFB0JxroJBIhHxL53YDQgki/NnTC1yh0Gca/VGOaY5a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006652; c=relaxed/simple;
	bh=bwz8ICph4ex3cZQvGr2JMbKiaBGDGLrHvEjpZKHBcM0=;
	h=Subject:From:To:CC:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcOzspT3GhPYKFo6Vekoo8q0adVr1jMoCogrGiw4IwAIS+BcCpEyL2+oU75kKxGBdft0ZZCu+AdBCaOS+1h8lwjCNPUmRWSRNFIzeC0wuXvVyV7VspJXVawdTDs23bxxkNhxiJc3Zo5+MM65R+fAoeBeVktjjOX/uXSaZFGQmVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoU9Ba/y; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745006650; x=1776542650;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bwz8ICph4ex3cZQvGr2JMbKiaBGDGLrHvEjpZKHBcM0=;
  b=XoU9Ba/yQbOnPNDY80db9O37/huvzpjZ32Npi0wamOOgoxvZu4VUdnpd
   Wm/hXTGKOr7hN6zHFILtCvSvwltEnvjDYeZoi7kyQmw4z8Q5NU0HnwjjN
   WL3nqHpLak7C8eKB1glCBifrTGNCd6Hk8Hmr60hNaEZFXOfgQErhXlBOf
   6tILuoXDB4bHFP9JadIUa1o2FYoTKHdqqq7J4yBeOtgyM6hbj7clCEX1u
   ak1bkpiVABEtI6wMJQFQYzgQgtZRbygTyKMRggnXnqw0kTY8zSMpns6nv
   VGX4XeHaS2wSvnHf6CQ+BDW9YybZUss4EHHSx4Hf2kzgrLIBeUUomEN+t
   w==;
X-CSE-ConnectionGUID: fibTN798TUaL7bkQW3yY1Q==
X-CSE-MsgGUID: 2RoUu1p3TmKGCNbYquSxkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46518775"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46518775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:04:10 -0700
X-CSE-ConnectionGUID: /Iv99exEReGRMKOKwu3tSQ==
X-CSE-MsgGUID: t1x2YrLnS3K5Vus7A82ZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="168393038"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:04:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 13:04:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 13:04:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 13:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGgYdfVvVia92GgJ+MkqutBaznC9E89aqXYEWYVtEVonDTZdmfWUEwR+Cf6TGziW4BCNeZfAjl3jZ/wUfpJmxhKt/c7PgguevZoEbFc0PqWMypWPSrI2ImaB4lN/utTPiYxlshiJYSELPHP2Yf07b9+00ezu+pOI4D8+HDNGGtsWr6koY6iV1HvrtaQn+KpO8utvt6eHg07g+8nylB0Ih2hLy6igl6Qqu8hLCdwQGZ4Z2bDLfOMAhF9siyks3ZwJcYs29wmi9OXMOoiBMLPJTCCYwsd+0O4hHEdDzlS3afc/m/fsJtUQ9vT11PhlINncxNjvPzFJERG4W53QyijIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ecBC1K8A3XG8UfIAIPLhPh+CMtD+CoXSl5LReGhVJY=;
 b=sU87TwrsdgQT8DH9JcqBe+RTQS2vf33BqbyHfSQPnFtL2s49y/JgVzgy7bIL7cJNZwvBjyTj9oTOork9BapvlCIF9LzV59hmqcjPl9fzUr+MBawIs7tKm9QBhKBLDEBbuNN0lfGc3U944PvpyrfzB3RP+1z7X2JiGfW7JFchDTZkRy7ACFyQ2sLeVYmi0qoAoNe25mObc3sH1BHTK6wXbAYX2xXIsejY13kQ/5wMhJTCUEnxDeI9djg1z6gBrgrS/MIGXj3HO6FTaeIOYCt0SAayuSYASHKlg6eQkQSceu9sH/wOmzXASRmYia/rjcw/3qLUGTxDiGdh7JirJL0y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4582.namprd11.prod.outlook.com (2603:10b6:208:265::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 20:04:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 20:04:05 +0000
Subject: [PATCH v4 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, Kees Cook <kees@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Naveen N Rao <naveen@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Date: Fri, 18 Apr 2025 13:04:02 -0700
Message-ID: <174500659632.1583227.11220240508166521765.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
References: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:907:1::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 08862406-c964-445a-8b1f-08dd7eb42bc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dStYT0JsUTZSM0JXbXRYVkRGTlhzRXY5NmVPOXdjdk5sOEJ3ZWZNM0pVcCt1?=
 =?utf-8?B?U1ZaaFlRQzc1SWh4UjlkRDE4QUZjcVoyLzBXcW1ic0V2NmtUUVJISDFHT2Q0?=
 =?utf-8?B?T2wvYzlhVnBRZFl1aFUzNlg0NGxMWlNmcFVUQXM4NGVoZVRuMUJndWNZZjdX?=
 =?utf-8?B?dU9kMjk2L3FMaGtObVoxWGpOZ0lzR3RhaWZBRWNEczNtVkRxekRzd0tRRnBW?=
 =?utf-8?B?b1hUZXB4NmRhcEhKYm9kcU0rdHN4TmlZa0VLczJmeWpLTUFGM2lHNVJoWjRk?=
 =?utf-8?B?MW1CNjVqV1prU21iczFZYUhEbmVOcGhNaXVabUk0aXdSbEszUTFtaURzNUd5?=
 =?utf-8?B?b0ZyVVpocUhiNzZFRnJCZzJPUzVHMENSYy9DaTg1aFlyTys5VThJM2NOY0I2?=
 =?utf-8?B?ZWw5bmFnS05QazlPRG4zY2p2WXJVOEVmeEFjcDlZTmpRY2dtOURXVGFDd1d1?=
 =?utf-8?B?L09rZlM3bzNIZVh5TmR6V2UrZkplVXZORUNwL0xFZTh0QmtnMGw4NDhuZFNM?=
 =?utf-8?B?cnNDVlRmU1l3eVN3dW1CbDJNYmMzVWtnVVBWQm5jVGdvbmpPN2FuYWFvMUVE?=
 =?utf-8?B?L3RFeHNIK0ZTTFF5MG1vWGFpcXVTMkRxN0NyRU1yK1QrNFdRNGlJY1BhN0d0?=
 =?utf-8?B?TEFUTmRtWldrVzZ3Zkh6SzErbU9tSnl5ZGh3SlcxL2hoSlFuNnVESWQ0aGFG?=
 =?utf-8?B?TUNBbVpxMTRFQktyYXRLRnpueDk2VmxrMUZmcENzYUNHV3B2UDdPNkhEcUhz?=
 =?utf-8?B?cUwxamYvQzh6QXgwTUQ5bUxXK3orbW01RWhuODYycGNDQi9peFNwRWw0MDdh?=
 =?utf-8?B?L2R4KzFFK2xTR0RmbEhuRzNpa1NrSllTdzNsYnFMa2ovNGJQemtBUGVINmI2?=
 =?utf-8?B?KzhHMHN4SEhqL1JlTm9XbHFNWVJIRkRkMUFCa2d4TTlnUXo0VnRodjFvWldL?=
 =?utf-8?B?Z2tZRHpLWWcvcmxCeUVXTWt0eVNJWDlEUm5QVXNXUG1QdlVzYXhOQ29vcm5Q?=
 =?utf-8?B?N0RSUmFUTTZiYkJoWU55RTdNcGErSWU5K2dTWWE3Tk5EL1lXNVMrbE5tZlBB?=
 =?utf-8?B?QkJOWm1lYlRTb0dST2hudWRlQ05oY2xrS05YN1YveE9Hb2pyMTdBaVJHL0Zp?=
 =?utf-8?B?M0YzV3V5cGFTYk4xczQ2WktacGVtZmZhMnc1aHBidG93VlNKZXBHZlRBNUY0?=
 =?utf-8?B?ZytDN2R4MGgwalpxb2Mvb1BSU1FuSmY5Q2xaRXh6R1kzTnNjdEsySkkzSjRJ?=
 =?utf-8?B?TmZucGpkdklxK1FHSktldDl4Z1NvbmJMRHBNM3lsWmtWTVFUdE1NbVEvZFpj?=
 =?utf-8?B?ODhOS0lyZk8wdEVXS0RjWGtIb29qb2FhWG5KeStPQ0ZhQjMwNUFuYUE0TUxH?=
 =?utf-8?B?T0xFYmpGN2ZVdXZFRUNvZjRBU1pxNU40Mis1Y1h4RGw0Y05RRWFZV0JYS3V1?=
 =?utf-8?B?MitVcW9FWjZQVVBnSk1FUW1HM3B3dGFpc281ekNmcG5YeGRuMlM5WWFiVE1n?=
 =?utf-8?B?MTQ1WTRpbTV0aHhNWTA3MHRoTk1DS3NRaHk1OGhsbVdZTXI5enF3Z1NuNzFQ?=
 =?utf-8?B?a0kzeHVMenFCV0ZWWVRFZmZRKzk1dW9oRHBlbEtyS2d0aWpBRCtUR05KQ3Rl?=
 =?utf-8?B?Nk8wcU5SRkxtZXV4aEptY0pBR0JxaTA5eWVsanh3aDVhNlhoVjUrSlhiVnNK?=
 =?utf-8?B?U1JnWkRCZnhkUGNBa25RY2RnNzR1SE1LK3U5dG5STVJQZ1VXTlkyYk9aTmli?=
 =?utf-8?B?allWMHN0SVJwZitZTmJzaGVVMG9xR1kvUzdOd0hVVzBWR1RVdkVJQjZCdEZT?=
 =?utf-8?B?NzAzem1VcFVxOFFybERuOExzTzRLZTZRTDhGZERoYXNOc1d1YnY1ZXhxZjN5?=
 =?utf-8?Q?VOGEueP2+W2kI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhybmVibUNtOG9CNGp2WllRcFJLeXYrTVMrUnRLSVRiZXlpMnJGdFpySFEx?=
 =?utf-8?B?VHpPRi9wMC9XajQ2NjR3ZUFsWHFXNytRa1Y4MEtMRnNVUEgvNFVwUkNSRmVU?=
 =?utf-8?B?TUY0MTU2T2llRUFJN2pSeXJ1TEEvVlpCeS81SjQ1ZVJrVElHNEYzemRzUFFT?=
 =?utf-8?B?Zm80dGJhWW8zNkRKZzRiT1pldEpicVBVL1FETjhsT0l6MVF0ZklRZjJlSTdD?=
 =?utf-8?B?L2xUYi9yQWQyYm9rUWV2SFY3WGFvNWdzdUVHMTFqelV4VU00QnhRMENJWWdJ?=
 =?utf-8?B?RHhFZ1lOMWRlbHpiOTNPQ0JkcWswbTd6VlRMME10eG5obGlHamR6aFhTSkVU?=
 =?utf-8?B?TUNLb3BFVmJtZnpIUDcrVThGcFRnYlU5OHJMQUhRTzBJWWRzT2JTMnppTWtv?=
 =?utf-8?B?QWhQM3hXZWtCQk93UklhNkZNY20rU0xaaGN6MXBTaGE2TWlHdHkvVm9qS2hM?=
 =?utf-8?B?VVIzTXhyZDZ4NEN2cUpCVFFFV1A1MDhrMDBkNDBUM3RaWXFYeFZyZlRoa3JM?=
 =?utf-8?B?bzBhREIyOUJjSUQzUXZyZlJoRFVuMEZpdlhpTWRPNVJnOHQ3OUhDeDhiem5G?=
 =?utf-8?B?NjJxSzhmUkkvVldpZ3VxMmtHODc4aU5BMDJUNWxFQnpmSExXMVVNWVQ0WWRI?=
 =?utf-8?B?NEUzSXpPeENiaU1nU1dSMmMwdmQ4Y3E3V05jWFJ2MHRvVzJWa0cvSllubnh5?=
 =?utf-8?B?SmlLNCtrSUJ1aEk3bXBLMTZUSU9OZzRKMXMvRWJ0WTByclAxdTJKWXc3Y3ps?=
 =?utf-8?B?emUycXhlU0RkZFd4T01YNzFPTm9hcGdCNWZuSlZzOFFJeG9BMU9EWm9NazU1?=
 =?utf-8?B?Tm0remlSSGZQNDVYZEg0ZkdOYXZHcnk3OTdoYmFGUEV4RCs0VWlwSzc4Zi93?=
 =?utf-8?B?YkxtbU9qWm0wenNzRWJRUUtIMVp4RFdYQ2E3amQ4S0FNWFQ1YXZXblZGTnFt?=
 =?utf-8?B?MHRFeFYwdGRTaGZuTmI1UklHZGd5VURpOGkrQ1ZRa1FlcmQxOEZvbWc0MWlX?=
 =?utf-8?B?ZFlibm0vejNQcmNna0lhcXhrUUh4SzBYNi9MaXlKYk4vL24xSXVnWklCbnlV?=
 =?utf-8?B?OGFGcHBVUk9iQ1YwcTRvcTRvSUllMWJOMWRTYXhRMk9RNFF4aVJxdzdqNHBz?=
 =?utf-8?B?QW5RRVBTY21qWWoxOWlKcXFDNHJKVjc0TjB0NUVVMUFCMUdOZU81VU9CN2JW?=
 =?utf-8?B?QmI0bW9PUnV1MEF6MlY4aC9maDBsL0xoNW5rNUNCTjZzT2lZVWRmcldHeVVt?=
 =?utf-8?B?WmUzdXM0SCtaV3pTQ0oxKzcxcmJsN2VNSjdzcVp5V3ZXTTV2R0luemZzVXVo?=
 =?utf-8?B?R1ZwcTdySGtmZmlKczRTcGdyekQ0YjBVRWtvZWZ0SHROYTZmWnpvSzYvKzY5?=
 =?utf-8?B?cExzNExLbHlJTUl4YmJpeTBHNG9yRzYxbDdQTVFqcnVmUnZ5eXE1VU9lQjZi?=
 =?utf-8?B?bm9jT0xEaCt5VitUR3pZU2VLay9odFAySzVjd0MwaWVSeU5ZUW8wVEZHU1pQ?=
 =?utf-8?B?bUFodUdUNzF0NnNEUUxWeDFZMG9XdUUxelRhWktEc0s3VENVTWI1VERjUEUw?=
 =?utf-8?B?SzJMYTljbDFzV25Kb1Y2djBKRlgwTzZ2MmFrV3htVGZWaGt0TGZBcXdtbitr?=
 =?utf-8?B?QmpqZlJDRFJwNUZMUW14SmhhNmYzRGdaNmlnbW1SdW1WWXRxR1piMUpUMXRW?=
 =?utf-8?B?aFFsMnZJbnQ5a3NTWFlEUzIwUlMyWWVDbWt4MkFqdUZiTExWTnpuU011YXFE?=
 =?utf-8?B?L1AzKzFoSVZvU1lRRnYxVS9SR1EzeDBUU3lYN1YyOGlxeURmdnpnWnRSd2Ft?=
 =?utf-8?B?a3lZdXBpWU1UMjgvNEpxTFBMZ0s2YUZhNE1GM1dlalZPa1VicE9qNkNYWEMv?=
 =?utf-8?B?UkRKWjE3T1hydjdXM0pUMUpyTVRlREFPb3lPbFAzSVp4Wk5FZEFlblc1THlK?=
 =?utf-8?B?RUo5anVRRUZQRkhnOEdsMDQxUzZONllNamg4N3dFN3RHZE1WMmlWUXIyUyth?=
 =?utf-8?B?dXdaUGFlVlFJV3dkMklFTWJac2RZMkV2clkrK3pXL0g2TmlTaWQ1NEhiREtI?=
 =?utf-8?B?U1FBV1JkWDNyRXErUFEwWkhLWWRxOGJVb2FiaUlhcWV5d2taemd5cVJ1OWdu?=
 =?utf-8?B?VkNjL0dpd2V3OXMxdUdKSDBLMkpTTDRpcjBWdG4xOE5BR0tyWDBMMEhiM1I0?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08862406-c964-445a-8b1f-08dd7eb42bc3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 20:04:05.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poRe8I5gS9rh8yzM3T7n0ru/PNmn19IlpVatjUu2yIP57flMsSSZR72M25ky371rhSd3Bbkg+lltgavZIEqzgKMxgyW0Mo9iO2P+8P/UFr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com

Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in an SEPT violation.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
unencrypted mapping where the kernel had established an encrypted
mapping previously.

Linux traps read(2) access to the BIOS data area, and returns zero.
However, it turns out the kernel fails to enforce the same via mmap(2).
This is a hole, and unfortunately userspace has learned to exploit it
[2].

This means the kernel either needs a mechanism to ensure consistent
"encrypted" mappings of this /dev/mem mmap() hole, close the hole by
mapping the zero page in the mmap(2) path, block only BIOS data access
and let typical STRICT_DEVMEM protect the rest, or disable /dev/mem
altogether.

The simplest option for now is arrange for /dev/mem to always behave as
if lockdown is enabled for confidential guests. Require confidential
guest userspace to jettison legacy dependencies on /dev/mem similar to
how other legacy mechanisms are jettisoned for confidential operation.
Recall that modern methods for BIOS data access are available like
/sys/firmware/dmi/tables.

Cc: <x86@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Naveen N Rao" <naveen@kernel.org>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: <stable@vger.kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3
* Fix a 0day kbuild robot report about missing cc_platform.h include.

 arch/x86/Kconfig   |    4 ++++
 drivers/char/mem.c |   10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..bf4528d9fd0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	depends on EFI_STUB
 	depends on PARAVIRT
+	depends on STRICT_DEVMEM
+	depends on IO_STRICT_DEVMEM
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
@@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	depends on EFI_STUB
+	depends on STRICT_DEVMEM
+	depends on IO_STRICT_DEVMEM
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..47729606b817 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -30,6 +30,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/cc_platform.h>
 
 #define DEVMEM_MINOR	1
 #define DEVPORT_MINOR	4
@@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
 	if (rc)
 		return rc;
 
+	/*
+	 * Enforce encrypted mapping consistency and avoid unaccepted
+	 * memory conflicts, "lockdown" /dev/mem for confidential
+	 * guests.
+	 */
+	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return -EPERM;
+
 	if (iminor(inode) != DEVMEM_MINOR)
 		return 0;
 


