Return-Path: <stable+bounces-89106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96739B3825
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9952D282DE9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892A1E0B7A;
	Mon, 28 Oct 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="groU2FVw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A71E0DCA
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137480; cv=fail; b=q1UX/GNL6fov6MLe+tU2BBfFmFwfrjrzVH5k14mdbwcTxv7J1xh4WF2drOb+7vyEuXjdLcPtRkLHC2MxyVyeUR1LCEB0SdTuzSwtTVSySu23emmw35i3hiw3RBbrdXl+I35uHKyPgSC/Nd7e/BvFFnoYK1P7sVD8SvZjYb8Sgho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137480; c=relaxed/simple;
	bh=NkuNtYi7ITBCBBGg7iOZtNM+j4uAoQQ4Y+iaqfOZcmg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4pSYHLv3f2XBEHnPL81EpYeElepLMYxCN5aqalTWIF7+2YlUyueSQfNF9BEaoZaRQ1CZL91rI5F9JqxDJHVUaah48GmZQLJJB/OUAthkfw53dm2vzYJ3W4MPUPmSowf5XIqZGsXJ+phH9niGibV5s4r3B5yy78Zd1LZ3z5XbRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=groU2FVw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137478; x=1761673478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NkuNtYi7ITBCBBGg7iOZtNM+j4uAoQQ4Y+iaqfOZcmg=;
  b=groU2FVw5GeK2mI8qXEru3U6J6XUOFb9bzEVhA552kyqx2wdxGG3rMpc
   Y2OO9oONU+wXNey1IyaR30wKEDy93Ffr+uh1stdlIN4IU1iCK1WRIJNqI
   tVEanDHiI34yUpeAg0AZtWRWza3GNUxP/yw6bqGw0PRvieFyCk1OoPXH2
   2hVo+ArjuBvVaBq381ldoKq344e7ra4X0UywsQrkhcVxocPLfc9R4ll08
   2DGoohcMk+x9+VjgDBhW4X8XH/WGWC3G1SYvxQiUe5H6Ryw/IZht2ZChe
   GDEzBSLFzRfu2gql1+z52VxQ+cdvYiZtyZwnmi0jwjw6LKTdRWB0qyDIk
   w==;
X-CSE-ConnectionGUID: JBrtiwlTTF+sCGJ/RzyGBQ==
X-CSE-MsgGUID: Xuo36CO0TS6JHuB4tJbasQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29855059"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29855059"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:44:38 -0700
X-CSE-ConnectionGUID: yzQXT5x9SvaZ9R3tcrI2UA==
X-CSE-MsgGUID: wxXGVC5QSxujjuB7tMERjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81745293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 10:44:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 10:44:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 10:44:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 10:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOlAbdnmEpBElyAC+XQ1MG7R59khQGrDlcGZ64XIIFvoC8vZVrsFp70Z1Bu2DJByusB4gWk69UuJQoh+VbxKKm8zlv4LDAt8BROr865ABl27EGugtBC6+iCLTr8tCb7Yf1+M34Z5KpM3owzH3eh0Dmt7EF9eavHPdhbHA8/9lz82hRyg3PYf+d+pSebz7ex6V386f8qgAzYjfXZX7pidg73xJQvCVcj6g66BkeC+UGD+dOfWsaXXB17kUseg5N7dU6Q3sj5H/G7TOqGQj8AmTsKabyYB72rx3Ki4fz8awNzDcY5XEgcPcd+y6EtrN/Uwmf4DPPDYk+QXpHpeguq57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkuNtYi7ITBCBBGg7iOZtNM+j4uAoQQ4Y+iaqfOZcmg=;
 b=hBhX5HqMOnRqiGJkn+E3AmXgybAy/pSDUjE9Ug/94c1Z51zfZr4G82unCh1p4DZTTImMDPOwVGeXv2qlTPTPQjwnZvv9EgBpxby4g2vPTFSDSB5WhiiZn9nLkSmsiyfG/uxOwJCJEG4HMiz7XWAdqVBy2iQ0J3zSvX6h64BZOo1ZQPup4Dei5qBlSPFF/9VKDmpsFlkCLZyG6KLQPxCVqPKuDTsf5Q7H0O1d3tovDfsAQz45UspCtpwCxGArUWPl5w+F1xjJ5wbc4rPeT3GlAv1JHSb0Db58ZzcyEYwYH9WI+Ndit2mBMiigXLhBp2WYhgCrE3eRKrNjU5owJzNU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 17:44:33 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 17:44:33 +0000
Message-ID: <ce7ba88b-0624-40ab-a4e4-c2c5f19b2095@intel.com>
Date: Mon, 28 Oct 2024 18:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
To: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
References: <20241028114956.2184923-1-nirmoy.das@intel.com>
 <d9befc74-b9b5-48c6-851f-8163b356edc7@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <d9befc74-b9b5-48c6-851f-8163b356edc7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|IA1PR11MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: e668877b-01d6-4626-c455-08dcf7782ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkVKdkdwcCtyOElzbnF3ZnBOcEsxeWVQZmJqUXZKR21lemZteE5zQzUvcmo0?=
 =?utf-8?B?QWV2Q1VZWHhpTVA2RlVLb1dVZUp6NDhrR0lvWnhINnJ0ME9zbGhnMU1lT0FF?=
 =?utf-8?B?YnRhbDV5TmlmOXc5ZkJhZHAreXZ4TzV0Tlh4VkxxSXZZSmtwUk9CamVrcGJC?=
 =?utf-8?B?R3lyVjVMUWtBa01zL3JaUVBveVFRRis2cWtoL0d6SEloRXMyVzU2VlFtUk9B?=
 =?utf-8?B?TVB5UXJTYm93R0RNVGF0b2E3eFBWUUY2alZkd0E3RVVGVzQxV25nanE1ZFlj?=
 =?utf-8?B?c1llN1IxcjVpNEhuMy9mZE1vK0k3cTQ2ZktJM0NudVF0bXNPcCtXa3Y0ejBt?=
 =?utf-8?B?QXZmMWR3MGVlQnBscjNOVkl0eEZwWmxqNHZlcW5mWjJDQlE0Q1VXNi9aZ3FD?=
 =?utf-8?B?Nm5GOVRaUU9GK3ZLQmxkSnZkcVI5OUlqbFlpZDEyRzZBa0VvVGFQcDVnWjF6?=
 =?utf-8?B?N1NhM3IzcldwSC9ycFhVR3ptZS9KNGdtdEk3Q09BOFFxWE9YZ3dDdGw5eG5C?=
 =?utf-8?B?UUFwSncwZENVM25tQnh1cFpTYTFUOW9YUzRkaGtyUStYQy96dWY4SDNVNWVK?=
 =?utf-8?B?Qm5TcjI4dFl3eDQ0R2xjcjFvU09xbnRpTU9rMHQyeDZnczFOMjBCeGJWRS9K?=
 =?utf-8?B?NWMrTjJtN0t5WUdGTzRVdTd4RkxXenRldVh0YlI3d3BDQ2F1V0lWTUE0SkJM?=
 =?utf-8?B?KzM0QWFIVGtMUHhDcmJ6dmRBTlQwYnRlNGVodWJwZ0tuUzBtN1hwZXNhWnZN?=
 =?utf-8?B?ZUZrK3RCK1hkSWYvOGFPeHlRa3VEd0VqbzBiMlViTUMydE5KVmM4M0hzbVJv?=
 =?utf-8?B?OWZaMXMyMEp6dHFWeklGSzkrWlRsWmFEK1hEd29ZbVFJb1VFWEFVUmZWQ0xs?=
 =?utf-8?B?dmxjd1ZJZkxIdHRzdVlONFNic2VaM0VHVUNXNVgyN2JwWEQ2RU1TR1pJcFBV?=
 =?utf-8?B?MFdDWDBweG5BZXVrMk8xWlpNSTJ5aEtYSmdJM3drYnlybEg5OGM0QVk3Kzc1?=
 =?utf-8?B?bXA0YVpTM3ArMkpVK1RlTXZ6THlYR0RsNHBIOXZjNWU0YmZrWmZ1cWxhcmN1?=
 =?utf-8?B?alkycy9EVFMrQjY2OHgydkJ3ZWp1TEp5YThsWjJ0YUpQN1pNUktUT2NMeEI0?=
 =?utf-8?B?ZkQ2WmtQZWJPV3BCWUt4c2dkbzdBTE45MHk5NGd3SW9KdjJ3cFVyTml4ckpQ?=
 =?utf-8?B?NnlFSmJ1UEFXaU40T2ZjTVZsdjNFT1FGd0NCSU5oamhaQVBzK3dDWHl4ZkNi?=
 =?utf-8?B?aEZaR1kvQjdNc0pCQitxcTI1Z2ZxSXV2aGZ1SzBlNWpQOGFtcVI5dGV6MFFm?=
 =?utf-8?B?OWpwUUdnNzVoNkwrTFJnSXRyYllybkIwbkNHTCt2c3hHT0JzUHBCZlM2d3py?=
 =?utf-8?B?K1VJd2orcGpOdzdSVTF1eG9lRmZIbk5IaUFJbGVxTXJ0QU16RFFCbkJJaHhj?=
 =?utf-8?B?NXB2TUluMWViSktjY0R3ODVqRFo4L1M0L2Q5Ly9LZWFlMFJzeEZWeVlPMFpW?=
 =?utf-8?B?enZ6bEF4eDBuc25uVjJVUERPaFlDZUZ6OWJxTjJwZnRsckl1NjlyTVh5YTdE?=
 =?utf-8?B?RzRCM0N5OVErMHZ0Q1dwZmlZOU1lamlxb0ZEWGNMNnRmbFRLTG0yNWZldkRR?=
 =?utf-8?B?VkVRQk9nK0hjQmtmdHFBcXVGeTFLS1F0a0NURE1nUHV4eVZiUmxrbkVBN25j?=
 =?utf-8?Q?w4/FQMcm+1s5UglPthbF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZ1OWlwL1JhWEJ5OHpRS2l5MkxTS0FSSUpiK2FCeEEwbW5oZ0pSbFhyNUlu?=
 =?utf-8?B?MXZYSUhsK0ltSHliVUlXdEZ6aDllMnF5ZTVLODhuY0tYQjRwOTR5amVjTVlS?=
 =?utf-8?B?UFRlUUp6SVpJcnBsREZtOTJIaVY3TGtzK1Z1VHQyenVOMFB4MUEvMVhHUGpI?=
 =?utf-8?B?S1g5bEZOdnNWVVRvSEJPeEdvazc2Rlk4cVhDT3pJUGhvcHRXRVRTaGpmcVVZ?=
 =?utf-8?B?dkJRN3h4THhzRlVZaDA0N2ZaQkZGbG1JKzZVUTBxM0FRYUtXdFpIZHphbURP?=
 =?utf-8?B?dGhQL1I2TndwM0E5UnJac2E1bzFZOStjd0dvR28yTGtiNHpZYmdYKzFZVFF3?=
 =?utf-8?B?MVQxYllrTzBHazBVd0JaQ1VaQjMzSjlBU1owYVlrczRNUmhocmFodGI3N3U3?=
 =?utf-8?B?V0ZjTG4vMEtNOWZTUzNhQ2hPTE5YSjRBMjlVTHFzeXdZZ0htMEkxZkNBaWkv?=
 =?utf-8?B?dU9GVzZjNXN1enJJYm1TSW9OR3VCKzNlNEtkelVNRFBITDdYNWJIS2FmelhP?=
 =?utf-8?B?U2FGNG1MdGhEYXhkdHN2S25GZTQzZzJDQ3NZUzJWYlRjMGx2TlMwWVI0TS84?=
 =?utf-8?B?ZGI0T1p2MkEvdS9oWERDSTdVYUFRR09FZE1GeTkwU1daTWdlTWFaVW1PYXZX?=
 =?utf-8?B?UG51TmFadnBoeG93T3dFellqVi84UzhubVVncVBQMVdUZElKTTN3R1pkcktR?=
 =?utf-8?B?YVI5eWVJeTdYNHFQdUZDM3JmbHR1THFNK1lhcGdlcDBYTVRxTXhmRFRFQ0tt?=
 =?utf-8?B?b05EQzhVR0Z6b1BuRHNTVnF0U1gyWkZkbjZhejVjbGJvNk9YR0RsWUVDNEpy?=
 =?utf-8?B?dnJDMUN4bGU4M1kxUVdHZXk5b2U0QjQ1RkgrSU4yL0g5YnM4cXczSUlFNEVy?=
 =?utf-8?B?a3c5YksyMlNJTEIrZzhKYmF4dm54b0pEeDlQc1E4dXhVRy90bGorY2R2MFFG?=
 =?utf-8?B?UFpUZmdhTHRiYmRkcmx0NGFYZ0NTR0lvVUxJb1ZyQmRqYXQxTms3cG9OT3RZ?=
 =?utf-8?B?elpIWFFYV1lYRWk2S1Mrdi9ReHZqQm5YT2FsNXVZRzdoL2pIalhYVXBhQUtk?=
 =?utf-8?B?NFpobWJTTTA4TFd2bGlUMlMweVhFNmFVbEZFRGt2eHgrbU9rSzlMK2wzYUUy?=
 =?utf-8?B?UStOV3ZJZzVkeExmc2tLN21Lanc3dGxLTm5HSmM0cUpQdmNiZ1htVkFpelY2?=
 =?utf-8?B?MFRrNmpTTjkvNWc2WGl3N3IyQVl4bnRJWDhIaXM3SEE3Q05XTUpOWTRZVGhD?=
 =?utf-8?B?U1llSjBLcE9YY3NGY3hzVGVkaUJNNG9CWjhwSFlwaTIwQ3V1clR6eStCbHA4?=
 =?utf-8?B?QURZd29kbnN5bGsrMDYxTDd6Q1N3NjZoYkZqTUcyb0huQWMxYTRaNGxhSnl6?=
 =?utf-8?B?bjRoaHVWb2M5TGZKeWg2dzBZaVF2WXJxenVFUVRzTzNKd0VQbU5XeTZvWXMz?=
 =?utf-8?B?OXdOblZ3Y1g3VDZ6NVZhbm5CNHdRZkI1cWVKZDRVY1l2MUd6ZmRKNDJDSG02?=
 =?utf-8?B?M1VROGwrTFN0NFNKaStseitScGt6TEpkelN6ek9DdFhNbVdnaGM0Um0xSzNh?=
 =?utf-8?B?VkNVWm54YTdsWHZuZ1lrN1NyZHVLZTdKWitkWDJxZTBkaFBNZFJ0enc4SXUz?=
 =?utf-8?B?TDQ4K1RCeWFJb05wajFjVzZHUlNVbXlsYnlpRFBmdUpMaXpFeEFVRk53Z1ZY?=
 =?utf-8?B?K3krTmZYanhFampvN2JCMUlTSDQrYjRJT20vZWVCS0FyZDMrY1dSbkZKamMz?=
 =?utf-8?B?RFpNcmY4dVhkVURZYmNlM3V3TDh6bGg5VU5QZVZBS3U2Z0UzVnZ5M2pZTjZQ?=
 =?utf-8?B?cmpKT3RYaGhnc083SnVmVEE3SU90UWsxYUJ5U0VxSmNqWkk4UjB2NDZvZ2s4?=
 =?utf-8?B?WURqQVpWRXJDZkVXV0hnOVpqYUhvaTJ0NzZyR1NSdE4wQ0lVVW5kZGhjTVRk?=
 =?utf-8?B?MitxRnRWUTl2YzN6MlVzeDc3akQ3cWxJSjBlS3FIZ0VIaTdGaG5oZmlpNVlR?=
 =?utf-8?B?bWR4NFZ1KzhyTTVBd0RON1RINjhmdGs1TVpCK2dtWEM3UXR1dk9uNkJFMnpO?=
 =?utf-8?B?Ym44NFFJVVNrZ0ZKeWRKR2tsMlZBTkxZbnhNSlBVa21UYnVNTlVtSWpMNTdP?=
 =?utf-8?Q?PFx4FjhZYaUuoIt0Xyj5ccT6u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e668877b-01d6-4626-c455-08dcf7782ebc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:44:33.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx56PjhTBG+TT/Njys2uo9OlwC38a8R3phzvMiMozbrXjc3VLLnv3VGjsYVNNeS8HvK3ep95rdhi9d5fAClNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com


On 10/28/2024 6:03 PM, John Harrison wrote:
> On 10/28/2024 04:49, Nirmoy Das wrote:
>> Flush xe ordered_wq in case of ufence timeout which is observed
>> on LNL and that points to recent scheduling issue with E-cores.
>>
>> This is similar to the recent fix:
>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>> response timeout") and should be removed once there is a E-core
>> scheduling fix for LNL.
>>
>> v2: Add platform check(Himal)
>>      s/__flush_workqueue/flush_workqueue(Jani)
>> v3: Remove gfx platform check as the issue related to cpu
>>      platform(John)
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> index f5deb81eba01..886c9862d89c 100644
>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> @@ -155,6 +155,17 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>>           }
>>             if (!timeout) {
>> +            /*
>> +             * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h worker
>> +             * in case of g2h response timeout")
>> +             *
>> +             * TODO: Drop this change once workqueue scheduling delay issue is
>> +             * fixed on LNL Hybrid CPU.
>> +             */
>> +            flush_workqueue(xe->ordered_wq);
> I thought the plan was to make this a trackable macro used by all instances of this w/a - LNL_FLUSH_WORK|WORKQUEUE()? With a single, complete description of the problem attached to the macro rather than 'this is similar to' comments scattered through the code.
>
> There was also a request to add a dmesg print if the failing condition was met after doing the flush.
>

I will resend. I misunderstood the last conversation.

> John.
>
>> +            err = do_compare(addr, args->value, args->mask, args->op);
>> +            if (err <= 0)
>> +                break;
>>               err = -ETIME;
>>               break;
>>           }
>

