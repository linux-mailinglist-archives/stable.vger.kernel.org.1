Return-Path: <stable+bounces-212676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOBAL7x5emkC7AEAu9opvQ
	(envelope-from <stable+bounces-212676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:03:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE1A8E8D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3113D30166CB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE87376486;
	Wed, 28 Jan 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQuvBTQE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B8304968;
	Wed, 28 Jan 2026 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634234; cv=fail; b=D8Rj7twNWisLF/gEdz0XUPfAqjhqaaRZpP8ObvsxQKOsoe0JNXTMu7of6TPH74mEjbgk07uCqCzygQDrodAxa+C3D6Hp5rluhQ2kKMCJ1g93ygPtqtMg0eT2WBmgXUNXcc5Awi1M1sFjp++pVdQOQZFKqSMYdRFV8Wg0Z4Z5GMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634234; c=relaxed/simple;
	bh=fvPtHThox4hAqsR/JWbRuXFFSOcPESh7qRGO+eDM/Vo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=svmaGjuAfeBI9ggBDz1j6OnQNDR6/h0wwbYfEdsMgp7ucWgOg5zlvB9ZB9+hBxvn5mzrr545zZibhUtOhgOs2L9pMMWJTRD4i4jJfIF5xfYl4zIkkgQMZLqQei52jDvuBPGluZ3dJmviMjM4Fkp0LQnGxGnvaNds/UySABJ+P5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQuvBTQE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769634233; x=1801170233;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=fvPtHThox4hAqsR/JWbRuXFFSOcPESh7qRGO+eDM/Vo=;
  b=PQuvBTQEP0g0S56vyvagmvrEq2hSYmZzPKljeXIXDf5Lwqijx5NKEDsQ
   bFRIQALHTa17DPxCQ7oZMn7e56vhcsz9i27P5gewNspfnMudRck2cm4l2
   Ck+d+HI+ix1epzubjIhiD/D46xqmehD03X4IuH/R3ShL5nv1XO0AsLFU3
   vVbuHu5PMoWqIEN//Zg9E0cbaVfvzx+3lKa9vn79dWP6sLmutOelRJgi3
   nAS+/65y/FXvJ1M1+GHK1QimJp2SMtjeOJNTggYeoi8w1t3jo6F3Iry5E
   RHZSZcn+RR2wECFU+C1O9nhPSC8MeXuOH7M06j17PSmzIJg/CNeRpMSmT
   g==;
X-CSE-ConnectionGUID: MBcjjxURRKeX2+kYZ4DWmA==
X-CSE-MsgGUID: amUKBTYWQv+U3vASOiCe7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82228969"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82228969"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:03:48 -0800
X-CSE-ConnectionGUID: Ajhi6w4CS0O4WOinIif8jg==
X-CSE-MsgGUID: 3iXf9iJaSyaI0nnz+dzSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208395926"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:03:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:03:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:03:47 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAlD8Mifx3FrDx/MsFJh1/PMkpX4CkobxGzFqBwntkFHanVW/iSpdBCCAAVw/PQnP1Gs5mUZvlg5tvnoq5Ifff4xPy9nCM6jUY8gOf2qvZ9INorFkoESzs6eXApy0INCnJd/TSzaWx5xFJVRoGj5BW+5KbZrgi7EWKMrFE9Jo7pfxXJCebaw5h/XgpOV1iXwXKGmadaurFPsmQXVDmqDW1uloSV3xch5GUWXBo47Z/vOg0fDt187SNSUFF9iI563o2ZoY73Zwnbb+pvC6CiYY6uLMHBootVQQ4ndi3HeChI3PfG5sv1O7tOFSEiCWU6zFfLViiL+lctd2uFrRMkmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCR4KyEf1BedE7553ZRX2n4Q48ie8sSQ9fAK+ZgzJAQ=;
 b=ul+wgnOuW7w8vukH3flgMq068TlWFMe7OW+cXMNYizn1BKYWFnFsGKahAh4O78zdaFC2dlVfyi/JRo7VHhp1qlqrQ5A/Oe0hDLip4uUt6UrjBhSC0ChmpDbRsqkwx1yDTwBRV2BIpzq52HgmwDZuA3rPQLlbu72dpGbZvxzcureHizdHpOpK7Uaur4SuWq7Zk1ibNwSuacsBdD+92R8BYXOrwIM8RaBzznZ3m+TLF0wkyWyQuOTElsS874xEPUhSEe8Np6sRNpFZcjYFTwLMZrLgQyN3urVZqzA6FJkAhm7ybaTJBlhTHqf5M1kP1M+cY21neTmu+u4vG+xTRRkBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 21:03:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:03:45 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 13:03:43 -0800
To: Jinhui Guo <guojinhui.liam@bytedance.com>, <bhelgaas@google.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <kbusch@kernel.org>
CC: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
Message-ID: <697a79af45154_3095100b4@dwillia2-mobl4.notmuch>
In-Reply-To: <20251212145528.2555-1-guojinhui.liam@bytedance.com>
References: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
 <20251212145528.2555-1-guojinhui.liam@bytedance.com>
Subject: Re: [RESEND PATCH v2] PCI: Fix incorrect unlocking in
 pci_slot_trylock()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bb07d3-a928-4814-5ac7-08de5eb0b931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SThMRjVuNkRweFk3bzE3N3ZzaFphV0RCUG12MEtmSzVGQ0pYVXRVWkx6MjFB?=
 =?utf-8?B?ZDFyWTAxUkpMakg5eExnOTdxZlpFbWptZGM2TnFkVDROZDFkcElhOVRHKzI2?=
 =?utf-8?B?b3U5UVlXWlV0VFRKbnNZalc0RGFaTUtlUVB1MlZkWk1Sd3Myc0NucVdSeFBM?=
 =?utf-8?B?MTRvcUJSejhxL0pVMlBpSlZzK0prS1ZaMlEzQlYyZnh1c2NPQnczVnJ4b3Zq?=
 =?utf-8?B?dnJZRUJwcXJyVmlleVRySWphMUlBLzh5cHRRNmt2a0ZIN1JoN1c2dFRCN1Ey?=
 =?utf-8?B?Sjk3clgvSmxiaGFyMS8xYWZTelJVWDhpUUlXOGwwcFFKTThCZWN6V2RodWdO?=
 =?utf-8?B?UkNlUENYUUY5eVJ3UnEvaVltTXNVcE4yTHBiSFgrNXBLYjI3dWNjYk5XQUQ2?=
 =?utf-8?B?WjQzTEY0LzI4ZlpOT0RLdlVkaFd1LzFjU1NsSFRVM0FsQ0xxUVlyeEZCWjZu?=
 =?utf-8?B?MlhRMm81cG9PRmV5M3hoNVVyWGZHOWV1MHVNMnBEYzhWTk5KckZ5T1BURm5t?=
 =?utf-8?B?Zk5rQ3hWTWI2dytkMmtYbW5zSUo5UEl6ZlFqT0laM3R0bTdvaVpzSWQyWXVN?=
 =?utf-8?B?czZtWEJaL1NUaEc3bkh4UlMxd2o0S0w5aGpyVGIzbTRsNXNiMjlDcm9VLy8w?=
 =?utf-8?B?bVpsa2I3aEJtaUhpMzN3VXAyc2VTaVJ6L1RzaWEraVpOc1pES3RBdE9HTFdz?=
 =?utf-8?B?Rm9RRjE5b2t4b1BoeDg2YjBhdnNuU1NnaGxCTmJLMGNseWZ5MGkycEMzOExm?=
 =?utf-8?B?eGp6UUIzSzVTdHhtcXMzd0s1MDVvVm5YZVpxYzZ4VUVXcHdsQXh2MEZTL3V0?=
 =?utf-8?B?Q1ljSnA5OWdCMUhCK3I3c2lPdjJJZWd6RUpXeGVEbGhjdEhkT2d0RTVjSlRx?=
 =?utf-8?B?R0Vjd3ozS1NwQi84ZW1DREo0VlJVR3BOOVJkaUxsS0N5V0JhQ1liSkI2VGtn?=
 =?utf-8?B?aXhYTHQxSlJHTWVJck40c3JPaWRqd0p2UnY2RjhyR04xNEhmTUV5SHdUZXhx?=
 =?utf-8?B?bkwwK2ZKVjVLRXRNN3g2MDV5MGg4bnFwTysrOXZZRXVlYSt2RDZnRUMyT0Zu?=
 =?utf-8?B?c2UraWJwM2Yyelc3dkRmL2tjQWJhNU5Cd0lUSG1DaHZXN21BMWg0cnRtdDFa?=
 =?utf-8?B?a21xcm9KenhqTS9DMWVGc09WRlg4YVVpV2s3cDNlOFFmSy9EcDNFTnVLalpH?=
 =?utf-8?B?WTh4ck0rZ0lrTCszdFFhd0FMRFI1VVg4ZEU2VWcwWVdwSi8yZURQRXl0NUtv?=
 =?utf-8?B?MmdyOVpmMEN1YllteXBlQUdsc09oc0syZ2tnQW1ROVQ4ekpIUVJRbjR1YlFw?=
 =?utf-8?B?ZHdLanhWbUNIanFjTm1qMVVwVjNva21PWEhoNmFhc2F5UWlVOTV4a3BqV2pr?=
 =?utf-8?B?VWdoc0hiUWNwRHB0dDY0ZE1VWWJKTVJnUU16Q2FRUjNlZVZDSUJEak53R2kx?=
 =?utf-8?B?UEJPM1FCb1o4d0F4d0lMRE1ZcGdZZENReGJTWTFtRXRScjdkVXVRVXVsRE8z?=
 =?utf-8?B?T2RQNm8rVTZtMUtlQ3FqS0ZiS3k0OXR4d3VSbjVDMGV2U1VacWtWSXJ5czd3?=
 =?utf-8?B?eC9OTVpyNmtEbHpYNmRFb25FSnY5QW5xakc0Q0ZiZk94M0pyQW1FQzh3WTBt?=
 =?utf-8?B?N3hpSzVRRGZrYXR4TEsySnVyeG9LSVpKQkI0ZDBoL3JhUUJ1dkZjUlFSWVpr?=
 =?utf-8?B?OGd5dU9hTGt3Z0U4T0Q1bjU1RnBMN1ppM2FrVDJSNTR5bHc2alg2Z0h2TTgv?=
 =?utf-8?B?MDdPaERhWEpzVERzMEVuMFBQTHRrd29GYStjZnFPSXhjTFJ3NTVia0dPeFlu?=
 =?utf-8?B?S2xtOStpNHMrMzlvSEZiSXBEenRvNTh0Uk9RMTBuam82MVpvUW1hUFFTSllF?=
 =?utf-8?B?ZXlpZXNNajREZDdDTllxMkxxcXNlOWZ2MHU3RlpUcjd2MmpSdy9BaU5TNDYv?=
 =?utf-8?B?TVVWVGdUQkk4YlcwR2dZOEc5eEU3MGVNZURPc0hSV054MjFGUzhMZ3AzVExR?=
 =?utf-8?B?NjVqWU5FcGowM1dRL1Eyd2NlWlhOa09mb0wyTmZkaHNlWmlieTZndVIzRGFF?=
 =?utf-8?B?T2ZrMHNta2IvMXZzY0JjSmFhM3d6d3dTSldBRjBFQmppNVh1dDFDS2xvek5w?=
 =?utf-8?Q?1o5/MFEsaTmnbMKibN16wA9Yi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldlUFJjUUoyd2RKSEVTdXRLQWxXVWMrcUhyVHVkNWVWdWoxK2dtYWlLNDFj?=
 =?utf-8?B?b1h6OVVPU1FSU1NoVFlvc01BQWJqaDQyK3NMalhYaE1ZQVhINlAzcVhKcUFM?=
 =?utf-8?B?VDRndHBoZ29hSHd1eGJOQnVGWU9NcytBM21wcFNFMmQ5MmxBRkp4UVBiQXZm?=
 =?utf-8?B?NDBMalBZeXB0TGNBdjdmZE0zWUM4ZHRWWStJMEwvOUhoTTlLOE0yMUIwQTl4?=
 =?utf-8?B?UGozc3FxSFlKLzF6WVVsQXVYcUZNUGl1dHM3UG1uUWtiTnlKbWk4VXVTVW5F?=
 =?utf-8?B?SUYveDR3SUtGbEN1V1JKalNZdGlOL1ZtVXNFSTBHb3ovdERNUmhPbGdWZmF4?=
 =?utf-8?B?OTlkakdXU1JjcTFIRjRDallEc3FnajR2Qm1wWW0xb1pydHdzaXBMa3JRTGtU?=
 =?utf-8?B?QkZkcmpKUDNZN2NXVU5EMkR6YVBpbHJwL3NFZ3pHaUN4dlY1WUl3M3YvalNB?=
 =?utf-8?B?aGIvRVJLYXdTeC9RMTN5ZU1UTjdQbno1NHUxcnY2YmdPTnZ6QWpUUW4rSndN?=
 =?utf-8?B?eVJrM2JPKzAyRVlKamlUZGRnR1d5NjVuY0xtUlo2bUQrTFIybldyZTZMd2s1?=
 =?utf-8?B?dWNHR0lmaUwvTll5OHJFUmF3b09RNG9ySmdwbDRwWVV5bUVBKy9ad0s1R25q?=
 =?utf-8?B?ZE5Sd1UwSzRzbWNCQ3UzQ1BHQ1NvWUxiNEFYeEE5VXFEMjJyRGswZ3dEZWxk?=
 =?utf-8?B?SlhSMXJCR0V4aTBITzh5WDFWejd0c0s2YlZOczVSdXFXZWFtVmRUWlRHTXUr?=
 =?utf-8?B?Z3AxUjdHaVJnR1hoaUlLQmdrVUtXaDNtZXRReHNUcDhHOEk1M1ZBRGxCRHJ2?=
 =?utf-8?B?eFhibDRiZnNydEdvRm1yU3BWVWpCZ1hZMjFrZGFJcHN1Q1doUHNQVWswYm1G?=
 =?utf-8?B?dllHSWVEQnI1RFZuTXp6b2o4QmgwSHZRTDFIUnNzSVZxUXhyaE5MbkxFcDEr?=
 =?utf-8?B?QzQwQmZlTkhJa09XVDFDb3NUQWJMT042aHFuRkJHOTdIWVFOTGF1SkN0QVBL?=
 =?utf-8?B?NzExS3lBcHZob3kyY3BRV2VqY21HTU40bFdUelBqSERUYlZXSW5ReFdFaVEr?=
 =?utf-8?B?dEpJY1Q0YnJQTUhGZVlWVlhkc0lqSnEyRjdRUjd4c1RsSjJ0NUt3Q2NieU0w?=
 =?utf-8?B?QWF3Wmk5eDg1dGNqampNMXkzVGFwcThkYkVKWVdUbWpJSmZuWFVXczdtVjQ1?=
 =?utf-8?B?UVpZVE1wcXdRdm43eUFRclQzSlVHcFFjSzJBY01XaDdUZ2NsSDBRUU1BOGl5?=
 =?utf-8?B?ZzFQbkYwRVIwQnFrK1ZlUUViclZyekJWMk1rSFlab1pMc2lIeWJrTHlZbjE5?=
 =?utf-8?B?UGR0M2oycmJDS2hUeVZxd1pJWXRYWXRnYU1BeFY1bmh3ZGk5Z0V3Y1BVb2dH?=
 =?utf-8?B?ZjkxRDlZeXNzeU85Tzg5Vms4eTFpZ0R0NS9mOGJ5OWVQdk50SXhtdkRwUXZT?=
 =?utf-8?B?NDU0Yjk2Q1RGdHpTOGhUR0x5ZlRiNFRwV1NiRUU1MVFmV3dXdUtnSnVQSGtO?=
 =?utf-8?B?MWJoSGJXOG1DalZlTXQ0d2lUZXFUT3F0QUZrV0paSVFkaHVHcUFOTUVkR1NW?=
 =?utf-8?B?NG1tTFhXekV3dVpEK3BIRmJFdE5TOUlWRVJpdlAwdWNaZEF3MzZlZ3BqbDVa?=
 =?utf-8?B?YlAxOFdEUWdNN1hYZ1ZTcnplTjNpSGhLQU9UZ1N5TUkwMTBvd3E0eHRybk9M?=
 =?utf-8?B?WTVjR0o3Yy9WM3lZN2F4UCtuNFUxK2JHaWlsdnM2ZC9BcWkrZXVBOUROb0VL?=
 =?utf-8?B?eEZxcVZqOHFOa2o5d0hZUC9kdTZLMjlWNEpQbUFDMDhKOGF2OTNwSW43Wmk0?=
 =?utf-8?B?eVJmb3RNRFFYcHJlcUxMcVRvUmhTZ0tZclhYZnNydUU4RmYzOEU1Tmk4OUF4?=
 =?utf-8?B?aEFyckVzZVE2RzhUM1R2eFZabXRxanJJNDQ3RS9zYUZCZlpVWTdSWFBuYXZo?=
 =?utf-8?B?ZWJxbG1qbytBRlU3MjVmcE16bS9CKzNsMXdYbldHMGF1NmErWFduNWZlSUlB?=
 =?utf-8?B?MlBWVnJyTG5FVUpOOGRvcVh6VmJXZ0IycElMc2hmQ2d5aEZpRnZHaG1XczBs?=
 =?utf-8?B?TzNmbkkxRGdDTjg1U3pJbXN1aEpOSzdEU3VNVm5ueEJZUG9wUHBVTkcvTVZp?=
 =?utf-8?B?cEJDU3ZvakZ1VXZFOXluUlZlbzZnS0lva1hEVTFmVmlGY0dMUzU3bE9Wekp1?=
 =?utf-8?B?OWQzZzM4b1E3UmRjbHBIaTN3dzBxVXNtK0lNUEQ5MjNLOGxBVHFvVmVqdVJB?=
 =?utf-8?B?L1BOL3hPWGxJLzJKRjNpeElicnR5TDhqdElLN3JwdksrZ0RFQjdvbTdpcU5H?=
 =?utf-8?B?Tmxhajhtb215dXd6UlhZUU9pUnMvQ2tsRXBnaVZJTGtpK0tuWlBXSVdMbnFL?=
 =?utf-8?Q?OxjK/S0LUrQQ/mHY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb07d3-a928-4814-5ac7-08de5eb0b931
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:03:44.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ8wuvcopX9UMZcyy7bnZqhTdbCM7cvU5XSzrsq6qSwQgpUVh2pbmclCytuC/+qADWmRW7acJLwrdzm1Jd2iicqwXEkvRJsK7CFjIk27dEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212676-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 39AE1A8E8D
X-Rspamd-Action: no action

Jinhui Guo wrote:
> Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
> pci_slot_trylock(), but it forgets to remove the corresponding
> pci_dev_unlock() when pci_bus_trylock() fails.
>=20
> Before the commit, the code did:
>=20
>   if (!pci_dev_trylock(dev)) /* <- lock bridge device */
>     goto unlock;
>   if (dev->subordinate) {
>     if (!pci_bus_trylock(dev->subordinate)) {
>       pci_dev_unlock(dev);   /* <- unlock bridge device */
>       goto unlock;
>     }
>   }
>=20
> After the commit the bridge-device lock is no longer taken, but the
> pci_dev_unlock(dev) on the failure path was left in place, leading to
> the bug.
>=20
> This yields one of two errors:
> 1. A warning that the lock is being unlocked when no one holds it.
> 2. An incorrect unlock of a lock that belongs to another thread.
>=20
> Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
> path.
>=20
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>=20
> Hi, all
>=20
> Resent v2 to drop the Acked-by tag; no code changes. Sorry for the noise =
again.
>=20
> v1: https://lore.kernel.org/all/20251211123635.2215-1-guojinhui.liam@byte=
dance.com/
>=20
> Changelog in v1 -> v2
>  - The v1 commit message was too brief, so I=E2=80=99ve sent v2 with more=
 detail.
>  - Remove the braces from the if (!pci_bus_trylock(dev->subordinate)) sta=
tement.
>=20
> Best Regards,
> Jinhui

I ended up also reviewing Keith's version of the same [1], but since this
one was posted earlier, go with this one.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[1]: http://lore.kernel.org/20260116184150.3013258-1-kbusch@meta.com=

