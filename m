Return-Path: <stable+bounces-163113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A45B073ED
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070781880755
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792862F2701;
	Wed, 16 Jul 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+iRa6eE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B922C327E;
	Wed, 16 Jul 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662942; cv=fail; b=s3novIEog+XCqoD+qatXSEvMLCc6Hh3sGJOZAXoHTUaTUXhJsOA7AugLUnMNrzwQ5B+W5VxGcCLRqb0QUtopUc6UVO7pUNRYF9Z+aO+HaDJ9aiRxPHGslhNc2jM9NIGITv45g0o4JrKsJPqN1C+9pQMPpjf6AeB+qQlkS5gy9B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662942; c=relaxed/simple;
	bh=NpBHcthBz6SH/CkFoxL6w7TGttd5WjWfXJ+tLNkSCSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gV8Gh9cQ73YNPIu4val44fRw0QY5u3ZqAe0ORY0I4wIAkbJsPu0Ha8gdhE8cuMGbsrVbh+4rF7gxiM9kPAnythiTPhNaGybCxNqHp2kKjThQX3xl44ek4CPhke1SDyqyTYnvfmoB9KNwJeiqjZyEP8Wl598hot/iEP7B2pLR/jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+iRa6eE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752662940; x=1784198940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpBHcthBz6SH/CkFoxL6w7TGttd5WjWfXJ+tLNkSCSk=;
  b=k+iRa6eEt+++YiQlLGzIJwNUQ6ax0LzOvZj95VULT+PBTrx45fuogCjk
   Umpg3wjRI0qWYWKyKHx5q9nR3XuHHmr/b0SVwwvVrLiphx/umKDjiM5JG
   MMTs4vruIwxxztWuoRNoPpZGmt+NNruXAJ0KCOEExh3YRuXel4VYiAQrS
   aG0g6r8/EKPNa6GlpxCY1ozZ7ikCzSr2t5XA/bPXmN76TBpQpOec9QYmY
   Xpw9bZf1dnatuKH+T1kiwuf1eUsjaoIn6T+sXP/yYz4IbhHiG97MexzsX
   vfPr/6cV550iRf9aCPkpJVv+MX9dau38XFTYGe6aRefs9ADSd0mp5gwL8
   Q==;
X-CSE-ConnectionGUID: fpynhg07RpOSr007eGX6jg==
X-CSE-MsgGUID: kp4STejjR3++sLAhXVm6Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54758232"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54758232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:48:59 -0700
X-CSE-ConnectionGUID: T+bW3HOPTaqHbY7iqEi5rw==
X-CSE-MsgGUID: 5MAuvh3aQ1auwdBBEBGdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="194613761"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:48:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:48:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:48:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVzr+ZpvcI49Gtpt4QVaXmIwlELPFpvh/QbMNVf9TQumhmSaYcNxnAbBAOStqlO0b9HczhsF3zLbsYtg2hVsitVD2Ni0o9uBfyQYpx37ZNqPTQBtqAHEKc4+/+YBjt0DFiymUDrWXeDAkmVm0lLiZKVOUvsVnshNKIc7ngP3zeLrhO/geRH5g8/KBgJU7vAmRz84qhi95KRzRQNw91ltr3vjSJfXCvgBkPgF5KUTawyhRUR2LGYTeQ8ViTuxy7iirL1CSe9Da3ymWqSP17x8m9O39BLoYY/RWvwHQx7JKvGQN53g/QdLhT/HFPZWwl6eh+ITeJJIyuLnJXkU2nAEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMkfRlyXl2DZE5uJsn+wFtWv64e4NR5qsgbWkzT+FHI=;
 b=JKRy/VBS0AU+CsGog5diJL9l8904FdNj7zhBuppWHLvxAtRb0As4r71UUaWYvcDnawlVaxkwDqPNpekqEZljrqF8Uu2s62auYDt0efuWtJ5ftGxR/NKxr8mD1YSpMhh234aQc7wLLukl278Be1OD5Ws+wFxU8LWSK7Z/oUJjCUU5Pr5wcQbqiKQvDhbwtxqV6YkqfedbH9RhmJNgGeuxpVkHSX2pGiuaO+192ytkW9ftp414SaHc4psMbxxULjRz0xzcsVQOmjGn2DEH1SizOuWnq+g+MbvIcMZoz744RIHr0coYhViFv9RQ0jw0TGEN0j7Cfk7La5cYaPtYWLY1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 16 Jul
 2025 10:48:30 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 10:48:30 +0000
Message-ID: <bdda74c0-9279-4b5e-ae5e-e5ce61c2bab8@intel.com>
Date: Wed, 16 Jul 2025 18:54:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen
	<dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, Peter Zijlstra
	<peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>,
	"Tested-by : Yi Lai" <yi1.lai@intel.com>
CC: <iommu@lists.linux.dev>, <security@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250709062800.651521-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d024e1-3ad2-45d0-91db-08ddc4564d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|42112799006|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzA4SmNFRFAydVFta0NSak9hSUt2STBTV3hERDBLM3VtaWtlelp4QmxNd1Ez?=
 =?utf-8?B?VDROZ0xsQStOdnlYWWlIbGFVa2Y0ZnVWME80dEtHcWFpRVB3cldDQWdxVnVZ?=
 =?utf-8?B?eFdieHhYc2lXVWxMV3B5MzM4czU4bnltV0R3MFFuaXUvYUtGUGNqKzNmY3E2?=
 =?utf-8?B?eGEwSzdiTng0bjNMaTMwcnBXU1VLYnFJVFFJY1dmMjF6OXFNZ3ZUWDNQVjlS?=
 =?utf-8?B?OWorWU14NTNPUHREaXo4bWNzU0dBU1FRSjZLenhtaHJnQzZiV2hCSlk4TUJZ?=
 =?utf-8?B?QUlsL2NJT3ROV01hMzV6dTFYMFVmTUtZcjIyRzFTTUhPWEU3aUd1ZkQ0K2Fo?=
 =?utf-8?B?YTB6ZzlHWUdVenhLMkRqU1BQVUZIVUJIWDdnRmgrdVFUbXlZQ0ZEY1Jyam4v?=
 =?utf-8?B?OUE2SkdGd0RYVVA0WTdRK0J2K3dJdEV0b3N0UWtONTJuQWZ4YzdYWmxXSkRH?=
 =?utf-8?B?eHRWd3d3TWhzbi9UVWplV0JTWExsRVZYVisvQk9HTW9BYjdWZjhZcVg0aU1G?=
 =?utf-8?B?WlhrSGswclFuS3NZTkFLTEJ3Z1p5V0t0RERrT3VIYXN2NGtSM2hpZ2YxNG9C?=
 =?utf-8?B?dndWTG5FL2o4dVVmbzBGYkRYanNxN3FhSkh4WXlQdlExcjJCVlNLRm5kNHNp?=
 =?utf-8?B?YVRUVWNIMjhVaFQzL3hqTWtQejlKQ3JTc0R3bUVqY0owR3lyWElvcnBCMmE5?=
 =?utf-8?B?OHVaVkh5eVlYa255TXZpRlN3N3phR0JneFVDUVJjaVFqTDZWbU5OS25sSkFi?=
 =?utf-8?B?MndKZklPL1FPSVNrT2l6SkhHOXFTbWtIVHRKZWlXcnFoaVBwVmtoU0VrdGxi?=
 =?utf-8?B?OFJ4YmVmdTlpT2wvS09IZXRNZ0QzL0c0TFFmYklmUjFCMGxTdWtIQVNzd3FB?=
 =?utf-8?B?cHpwSlNWYTdYd1YxcUF6NE13NVlLS2twdmFLczZtUGZDUzUvOWxxZ05aZThy?=
 =?utf-8?B?RkhlQ3lkKzJUcndPNjJyYWpTTFdXejlGbm45NGlydThJUGRyOEpEQ01GTkNn?=
 =?utf-8?B?MkYreEs5eTNsMDIvTzg5Y2hPRGpQek1ISlNnTDkzQjR0ZnlUemxUMEJyWDFU?=
 =?utf-8?B?SmhMVXJKaWVPMXB2Y1g1eW1XQjBUYTFKZGdWUllDU0tCbFJKbDkzQkZmWUQ3?=
 =?utf-8?B?REp6UjBkK2N4WERET1VyRHE1bUF0NGNiT0Mwa2ZhU0VqN3V4VDJ1aFVsUWNI?=
 =?utf-8?B?NGZ1YW4wU0pKZ0hRWlBWRno2L0xCRVpuMUlxSkN1bnU0bDNRTFhpZXF0NGY2?=
 =?utf-8?B?VXIyQlBFMzlkZlZhUS9sZ0VUaWtZdmhiSnVVYVJUbGUvUTBuS29qY1lGVXhG?=
 =?utf-8?B?Rzh0TFZkYkRQQWE5T2tyOWU0MlZaS3lQWmhmR3I1bVNoZlRza21aRVNubEla?=
 =?utf-8?B?T3dzczBjT290ckk5NFE1WDJIem94VHh1amNUN2V6V3JDTG9xY3Q4bVJPREl0?=
 =?utf-8?B?RDc2NkVuYmhwanZlMit4M2I0dENoZGNXYkZzd0VFRlBqNjVZbmNBeG84ZS9o?=
 =?utf-8?B?Yks0ZTNnMkRxM0dCUm5xRFJOdng1aVlQWGdFSGdZTGtYYi8yc05mWnJ5Tlpu?=
 =?utf-8?B?Y1Fod3U5UmIrWVZkazlNbWpubHpBUWZXRjZaQVdyUWduUmMvcXpOSGhWanRD?=
 =?utf-8?B?RzkrYkt5L1pxV3ppM1hXQTBRQzVjc3FraVlGOFRNenRRSy90Rng4aTJUYTZD?=
 =?utf-8?B?K2g4b0VWakNNUGh2SnhFS1A2ekpSTzU2QUgycStrdmlGUlVIaUVGVEgwV3Jn?=
 =?utf-8?B?bEttdWI3YVd5ZmFWV0w1aUdTSVlJaVVnV0Z2VU5ZTjB2TGdZRElwM3dGWUxT?=
 =?utf-8?B?UmRYeEVPQXdtWWhqQUE4N3BucGUxSExnOVZHQ3V5NGdPZVljSkZoaVFjd240?=
 =?utf-8?B?Ti83WFRHVFplRlFzNzZkUnkzc0xDb0NMemdpMngrWjI5Q1lsby8ycmlqL0lu?=
 =?utf-8?B?bThZdTN2WUxuRGVpYTJ2a0loV0JOQk1IK3BwOXNsT25JaU40Ylg2aVQzYjRW?=
 =?utf-8?B?MVl0c2ovRzBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(42112799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clYrMzlDaEVHeHgvQ2NYdFVHTVVRZHZXQ2xSd1UrUDFaM0ExUE14UEo0N3Bo?=
 =?utf-8?B?ZGVOUHZ5YlhKamluSFR1VEgxSHdwWnF2OGFTb21FUGpCMmpMSzc3NkdLdWtD?=
 =?utf-8?B?aDZ5VGsrM3RIakQ5SCtzVy85cGtWb3p0T2R3ZllQNjg0RVNyU09wa1gzN2lZ?=
 =?utf-8?B?VHRFcUJLSkpsdU5YVmRPc0VMUTlnRS9zczQ1YmRvQm52SFhBMHM5QnhMMTY3?=
 =?utf-8?B?ekx4ZE5BcFVZdlVLNWZqd0p2S0ZqMGRnVWhLd0M4Umh3RUFjbUZOTUtnU1RI?=
 =?utf-8?B?TkdKQXFJYkhCZTA2czZxbDNPc1dRL3kvZjVxdDVQaFVIbEhLakhRek5xeTlX?=
 =?utf-8?B?SUljdUcxQUl4aU5Fcy9zMGk4QUpSYm5CZkIxVzZncnJvRU04U2xYMjlwRkFZ?=
 =?utf-8?B?aFhvNDdBN2NKdHpxVnZlNFBRTGxzbzZ0K2k3U2I3SEk5T2R1VE1pMzBOV292?=
 =?utf-8?B?YVRkZ0UxR1lOZWh6TFFJbWxtcUFuc2RZeUpwUlU5UzRiWWp2QUpOQ3RCWnA1?=
 =?utf-8?B?K3hHOUF3bmNmbCtpSCtyVWp4K2xQSWZRbWM0ZG9GbWtJNjJFdFVONG1aMGhj?=
 =?utf-8?B?VmJ0aDY0NDgrbm05YmVmbTJhS1JCY2lLeWJ3ZUEwQ3BJVTJaWE5OUmp4S0xY?=
 =?utf-8?B?ZE9PYUZXQnJiRXd6UTROUTdmS0Y2Q1F6UEZOL3pncldMUmhMK3lRemUxem1D?=
 =?utf-8?B?a2x4bjA2RDlRQnhxZU54YWU5KzJiMkVjYXV6ZitKcHhNd09iRUVQL3ZvbGVL?=
 =?utf-8?B?aXZsajd2QVRGbHp3dURGdzg5dEhXTTVVdmtQSUpPWlJ6Vk1YbS9nUWEvRVha?=
 =?utf-8?B?ZUlrTDZLRWRhZm1tUC8vdDRDalRJMkZ1Y2hlUGtjRGRibTNIUHRkZ3d4dXU5?=
 =?utf-8?B?MDM3bnhLRUVHcDlQRDVoNTB1VU9IQUY0dnFUTFVZRUsxS2JUWjFtVVpycTJF?=
 =?utf-8?B?NUk4N2J2TkVUVjVmZ3FPVTZkcndsOVVzYU9Kbmx4MElxQU0xRFB5YVNrdncw?=
 =?utf-8?B?VDFUZDd6S3NRU1BYOHF5M3hiaFUrWnpOdFFiL2ZGb1gyNk5ITDF4ejV4d2Y2?=
 =?utf-8?B?QyszeksvcnJERmVkdUhmUStsYWo1Nzdpd2ptc1hEaFpuM21XV2JjWU5EYmpB?=
 =?utf-8?B?ZTEvb01aY0x2SmRvbk9nRXJlbWZnSENFZFd0WGZaT1B6dFFIT3p1dTdRTEdj?=
 =?utf-8?B?cUh1ZU41WHhtaUlLVll5VDJuZTFQMWpWckMwMHBicXU3RGZhK1VuODJJOHZF?=
 =?utf-8?B?MWdHZS9heTZTMFcwWmQza0hkNTdjNjZITXVKcXNBbFR0bGhnNHJra3FKVWNF?=
 =?utf-8?B?QlZScktOOVp2d3BsZWRranV6aDZIMUdKeklacFY4VGxpcThuLzkzeTdqL3cw?=
 =?utf-8?B?eXduSFhXUDZHN1B1ZE5xY3pyOXNwVFpnYWRRanpzSUZZbW40YUZKM2ZlazZJ?=
 =?utf-8?B?dkVtaUdHR2hsaGFoWXUzMTFkSEw2YUJVL3plZjBCdVVGTTRML1EyMm8xQzc2?=
 =?utf-8?B?SnNJVDZaQkNXczZqMHZPNk5ZcW9wN1ZCdkhtQ21nbGlKUEF4b0ZzckdiNzVC?=
 =?utf-8?B?Z2E5MUlIWTNnZlgvdm5qY0I4eHd3MHN1bFlLNHIrLyt3WWxuVUl1amxVYVll?=
 =?utf-8?B?VjRBdjh3YjJMSmJQdzZUdnBLeC84MGYxbGhYQW9aVk1LQkFRMEhrUXN6b3cz?=
 =?utf-8?B?SkwzcHJ2Y2xlM25DUERGaE9XOEl2SkpHVFRndE5vaDRUR2o5TU5HSy9sd1pB?=
 =?utf-8?B?NXZvaFhFQ3dydCsyemFyODBLYkpCUXM0VTQ2QTRDUWdRUW1zM3JXQXZLQW9B?=
 =?utf-8?B?dEo3QUZNTVBIMHBteHdRZ0pTT0ZZMHJFdmlRZDl4SkFNSEZUZU93dXV2Wkkx?=
 =?utf-8?B?TURaT2V1Q3M0Wkwxc0p4S2YvVUl3blc3cUlCMnNJYTVqMWRsNHhaSmpNRGNH?=
 =?utf-8?B?YUFWbnlObWgrRFVUbWtkNjhPM29TWkFwMDl1MXhsc3V3OEpyc1l1WEdHV1hK?=
 =?utf-8?B?VEVxdWQ0WTBvZzYvQ3BPa3gzTUR1WkFxTERlWStSM3J4cW9CYkNTMTdxdVR4?=
 =?utf-8?B?bnlGQmVVOTh1WnZsSWFMc09IYnhsWTFPT1NSRVpuV1VGV3Fvb01mRGtvb3By?=
 =?utf-8?Q?Fb0HKDdwjnP64I1QxB2nAhHi9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d024e1-3ad2-45d0-91db-08ddc4564d47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:48:30.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdKr23JUaHKm6yKtBm8S46Y6g1VGWJBRBxHbgIJNlTZpR9Xpo0LzEJ7GYvuLPT4dgI8HvXuzoRGHaXG0yHlMkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com

On 2025/7/9 14:28, Lu Baolu wrote:
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
> 
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the
> IOMMU to access the kernel portion of these tables.

I remember Jason once clarified that no support for kernel SVA. I don't
think linux has such support so far. If so, may just drop the static
mapping terms. This can be attack surface mainly because the page table
may include both user and kernel mappings.

> Modern IOMMUs often cache page table entries to optimize walk performance,
> even for intermediate page table levels. If kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potentially
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.

Does this fix cover the page compaction and de-compaction as well? It is
valuable to call out the mm subsystem does not notify iommu per page table
modifications except for the modifications related to user VA, hence SVA is
in risk to use stale intermediate caches due to this.

> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.

aha, this is what I'm trying to find. Using page tables with both kernel
and user mappings is the prerequisite for this bug. :)

> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Reported-by: Jann Horn <jannh@google.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>   arch/x86/mm/tlb.c         |  2 ++
>   drivers/iommu/iommu-sva.c | 34 +++++++++++++++++++++++++++++++++-
>   include/linux/iommu.h     |  4 ++++
>   3 files changed, 39 insertions(+), 1 deletion(-)
> 
> Change log:
> v2:
>   - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
>   - Replace the mutex with a spinlock to make the interface usable in the
>     critical regions.
> 
> v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1-baolu.lu@linux.intel.com/
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..a41499dfdc3f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -12,6 +12,7 @@
>   #include <linux/task_work.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/mmu_context.h>
> +#include <linux/iommu.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/mmu_context.h>
> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   		kernel_tlb_flush_range(info);
>   
>   	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>   }
>   
>   /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..fd76aefa5a88 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,9 @@
>   #include "iommu-priv.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> +static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
> +static LIST_HEAD(iommu_sva_mms);
> +static DEFINE_SPINLOCK(iommu_mms_lock);
>   static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   						   struct mm_struct *mm);
>   
> @@ -42,6 +45,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>   		return ERR_PTR(-ENOSPC);
>   	}
>   	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>   	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>   	/*
>   	 * Make sure the write to mm->iommu_mm is not reordered in front of
> @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (ret)
>   		goto out_free_domain;
>   	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>   
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> +			if (list_empty(&iommu_sva_mms))
> +				static_branch_enable(&iommu_sva_present);
> +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +		}
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>   out:
>   	refcount_set(&handle->users, 1);
>   	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		list_del(&domain->next);
>   		iommu_domain_free(domain);
>   	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
> +			list_del(&iommu_mm->mm_list_elm);
> +			if (list_empty(&iommu_sva_mms))
> +				static_branch_disable(&iommu_sva_present);
> +		}
> +	}
> +
>   	mutex_unlock(&iommu_sva_lock);
>   	kfree(handle);
>   }
> @@ -312,3 +332,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   
>   	return domain;
>   }
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(spinlock_irqsave)(&iommu_mms_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);

is it possible the TLB flush side calls this API per mm?

> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 156732807994..31330c12b8ee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1090,7 +1090,9 @@ struct iommu_sva {
>   
>   struct iommu_mm_data {
>   	u32			pasid;
> +	struct mm_struct	*mm;
>   	struct list_head	sva_domains;
> +	struct list_head	mm_list_elm;
>   };
>   
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
> @@ -1571,6 +1573,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>   					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
>   #else
>   static inline struct iommu_sva *
>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1595,6 +1598,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>   }
>   
>   static inline void mm_pasid_drop(struct mm_struct *mm) {}
> +static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
>   #endif /* CONFIG_IOMMU_SVA */
>   
>   #ifdef CONFIG_IOMMU_IOPF

-- 
Regards,
Yi Liu

