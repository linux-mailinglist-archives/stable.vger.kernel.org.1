Return-Path: <stable+bounces-78498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388198BE4E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01170281F2B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44C1C5786;
	Tue,  1 Oct 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaKIA89y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A691C463F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790499; cv=fail; b=pWpHDTQUHyt027lrd1HdhRFr3oq0hBXAhDAHnm5nnTRcJE02xTkgJRj7gvTZSIT3ypaYHRRhWVQnT+K7Odku4B7OTMYpXCrG0Fb1eB1vVw6LBLL74+eyEvVb3hAUBIAyI7uLmhHJtE5PTwje4fFEhNJddWNZmAv4nQId/NhtOkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790499; c=relaxed/simple;
	bh=FDyI1bIkAQ51VP16LqIQloyRMDdiFVaeJbiPibt2cIg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oyA7zG5YPG5Bqqi6WBSi23o1GzDAOOpKT2Uvj9YxMtNqEEkMrL3wd1qgQexs/Xb0p+OsZulIQLxeF3mQMSx6kbAvtsgCglUwpNRIRHHMXR4S1lu8JLtioxO3G3lDhyLZTXx/DTKdo3ms4gcdPfMytExOrs/Ie0JlX/sFJwEkNog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaKIA89y; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727790497; x=1759326497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FDyI1bIkAQ51VP16LqIQloyRMDdiFVaeJbiPibt2cIg=;
  b=YaKIA89ydpW9jRzjA+h7/vThi3IoyYeupjBnuYqeHuAPc1RyMj0bZRiF
   la8ck2Q37BCCzrA6+nCBBkIDXdmnpKFzvnRWoRncJnm+e+RFGwypC7Tlq
   I7mac33dnlv/P4cSHBA05kZM0DlPmGG/QKWnp0BddjwVrbBg8KRimyryO
   4bFttgNUqDBVN0aN49UE3u0lfwTpudkj/1/pi6oJzYrNnPK/paUFzkq7T
   TGHLS/h+CYBr9B3cmJ3VFd0MGKQC1TcB1+sv1S9LHnVXjM27a/VB3xI6o
   jw7QdeNwYT0G4Q1DrkA2SKgkyPRNQT5BqHUEB8QR2CUHxC/T4zioq960K
   w==;
X-CSE-ConnectionGUID: aK6ZVuoUTiudoCGxJY+8og==
X-CSE-MsgGUID: JdowqcduQW+wHqBibEb8Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49447302"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="49447302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 06:48:16 -0700
X-CSE-ConnectionGUID: XE/TBQoaSSuNbqRiHO3snQ==
X-CSE-MsgGUID: nZVAyE2NTxuw2YGbFfbvJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73792506"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 06:48:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:48:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:48:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 06:48:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 06:48:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQAMOKo1DS6AzCyqEQnuoM9KRVoXDcKjRNoz8OBjp41DB3ArBa/nvlIEF5xYHTKU3unKUDprtDikJZgMRg1HFuYPn6QJcIAqzhT9bAzZ2THF++SeB9J+o0yvXgC9rb2HMB4k+euG6DWOhK3DIJDfj9wjq41PTBR4T80IZK9A4yAUJeVYi7yqUGz4OrC57+KUa3M75TWq7CbPyllWU5k+lyiSJqwZgIQekq4YKntl9RYC6Uy41D2fyGql58FGwTIDlT3mb6PDqaVXzf0gY6QrG4+AYax4a/bBAhWLrpRU/DD6ZvsjY4q68aSY7iUl55C1moof+JOCiyanGqEBfBMaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/01m6olUXT49zvj2DLvnZprYbfF30oh3W6bGZc9Ms2I=;
 b=lgAdby/AwEmAgO57MfrfkAeUPhO14RFsuP+NQX1YkwQtIBcMZ2mbSaqrs4wA+UsJ/lljKFNlG1tH8GSMGqs4H8Dv+c4yjkNuJeorhi+JnUCbzrDK8X/Z8sd9/jO+PVu4KOZO36+dtMzCck7gUCgzUdkFCLaLSuWh6Z1MNA6JoGlInlsdwJSI8/8zTcmf8hhZE+3vJFxmT/AKPoIeZ26ZV7SRaatmDuuAQ59cJsC0EXZGmbdVqWRDDYFP5Y34mFx6bS23AgSqFd5iVUsH5c92CXKEDHZqb47SAuugLIGYkuJ+bbGPCvQ6aoHXzgIcQqc0S1rviEeJzX9Kdjwao0Z4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by MN0PR11MB6183.namprd11.prod.outlook.com (2603:10b6:208:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 13:48:10 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:48:10 +0000
Message-ID: <f761b5e4-68fe-4620-b55e-e05d7f2dae5b@intel.com>
Date: Tue, 1 Oct 2024 19:18:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/xe/ct: fix xa_store() error checking
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, <stable@vger.kernel.org>
References: <20241001084346.98516-5-matthew.auld@intel.com>
 <20241001084346.98516-6-matthew.auld@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20241001084346.98516-6-matthew.auld@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|MN0PR11MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: a030a8c3-bf7e-46d8-0e02-08dce21fafce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekNzLzh1U0U1cFYwZ3Y2MWxQdGoxRXFnWXgzSkl2Qk4yM1YrTDJzSXRFYzFk?=
 =?utf-8?B?aitEdmVrNmxMY3c5d28rWjNDK2s0MDdOVUhENXM3aXduYS92UVVhVXNmR1gx?=
 =?utf-8?B?RTIwTnF2Q0ttZnliTUY3cWxTeG1GWkl4SnBUbzhsUG00OTc4OUF5dVVacWNZ?=
 =?utf-8?B?c0pzbnZ1Y09QRzY1Qys3N05SL2toQ2tDUVVFQWN4VUp6NmFjNmE4TktyN3Bz?=
 =?utf-8?B?NitSK1BjSmtiaDcvS1BuVktHRks4cVZjZjJjTVNuVkxReWFyUllpUXR5SGpN?=
 =?utf-8?B?SnRvOUhVSGJRdlN5ZUdsaFE3MWt4YVRJbEVOQkdRejF1Lzg0bjlQK3Y2V3o0?=
 =?utf-8?B?dmpiUVZhVzdPbmtCS1BGdHJpTHNoUWlHTXJxaE5tZEtaV2tCVkJBMkhOS3Br?=
 =?utf-8?B?M1M4elgrZ09MZU5ZS3k1cWZYZWFqQWVxUGZFVSt4M0FkTm5neGplNC9XYW1m?=
 =?utf-8?B?RktZS3hzVW9hZzJEeWRRRFFjTkxyODZxQnpoQ1ZxQXpjb3BiWUZydWE0U2N2?=
 =?utf-8?B?MUQ0SW81cVZHSWJRdG4yaWZhOWt0YlJtOGY1NTY0S2lDZ0E2eWxMZldGa3hu?=
 =?utf-8?B?cG10WDFCWm4rMmRvd1BtbVFuT3NXdEZtaW1zTWtoRlMvU3FaN3ROSVlkZTlT?=
 =?utf-8?B?YmN3bUFzcG5aRkRDWElHNTA3Q1YwQnRNTUtyY2lreURRa29YQVN3ajRXOHln?=
 =?utf-8?B?TjVNVkJvYkZtOVQvdXZTV3pnYnJvdHkrc0o4K2oyNzZma3pVWm5VOHIyTUtz?=
 =?utf-8?B?NHQ2bzFteG9ISzNkMlZMaFJyR2o2RUlielV6RFdsNGZ1VWMxVlZuT2ZrYkJB?=
 =?utf-8?B?SUtpWlY4OFB3a3U4aGpFdE9YbHhma1J4WTBNRGdWcS9pWEhYUkpINzNHWWJn?=
 =?utf-8?B?M3ZFRDZ2MFpJR21PT3NHS29aRzBLYkN4UVltZlBpbUZUMVB0SURSaWpjUzBS?=
 =?utf-8?B?NkFhNUxsZHRTU0pNcTFzdDRxSmpQOHBhUENGb2J0c0hGcHd1T3JVSGRvUFBU?=
 =?utf-8?B?Q2MwZ1B5RlZ2ZUxRSnlOYWx4cmRwdFI2SSs1T2pnUVU4NUZGK0JHUk5YWmdp?=
 =?utf-8?B?eG13MitCbGFnQVorT0xjeDBRc1YwNXAwSXFFaC9tUkp2SENVcWplVFFNaDNx?=
 =?utf-8?B?N2Y3Z0t2aUtSKy80anRMb3UvQ3RPV2F0Z2l0dUZCbXoyMjZvU3lBa1dNRHpS?=
 =?utf-8?B?dkt4eEVxakZxUUhETmNBMngxWW83OTU5R0VReFVWZzBDMVRobnFsWlpOdlFK?=
 =?utf-8?B?MWdDb0lGODZzZEJ1U3pTV2lPZ2tGMnJBWmJNZUpENXM5SXRzOVJRbEJ3bTR4?=
 =?utf-8?B?UVdOMVFoZlQ2c2RYeEZ5anBnNi81NGlHOHR0SkNaUy8zVGVCZ2pCTzkvZ1JZ?=
 =?utf-8?B?VURLVUdhV1diWDcxSzdUUnBDT0s1QWpzYXNVVWQ3REVnckk4dEVuM2l2aVZr?=
 =?utf-8?B?UkRXT1RyRlI2NGtQSyszblVMOVJlbllSYjczLzhWNU1meXNwcy9TT2UwVzZQ?=
 =?utf-8?B?OUh4aTgrZkFjZDdXNWJzZVg1TklLYmIwUkthNElJQWxWaitVMm4xUDlSeEZX?=
 =?utf-8?B?SDhObGYzL1YrQ3JReENBa1pHalc2WG1vRUlmTUNwT0NzNnFPVWYvU29ab1Ji?=
 =?utf-8?B?QTAzOFZvaitmVGFCaXgra1pVcnZXZVdpUER2bWFXd0gxWVNkaGhlMGh4bUlI?=
 =?utf-8?B?MjhSYTN4TlVXK3JuL3FRaC9jMnV4eWRidTZlOE5PMEZOU0I2TzhNeWdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBjNC8ydDZCUy80RUlqTXc4VkNDMStRSVZtWG5SZHdwR3VFNFNMVWhPRGg1?=
 =?utf-8?B?Wi9LalM0NHBNM3ZWQlZtWGNJQWRzaWpIeFpyV3lyUFRCV0ZFK2ptMTJwTlhL?=
 =?utf-8?B?aFBmQ2NRTGlieldrcWFWSlB4ejVxUGVoNzFOTFROZzV0VDFNZU5HYzNQT01n?=
 =?utf-8?B?VW1tcWxwei84S2FyWmVEWXBKNEo4bE90VTY3cUlXcjI2djByVFV5K0dPNlls?=
 =?utf-8?B?OG1wMEU3Q0dzcmxTTDM1VHNDTFI4WWdBbFJxcnh4WEJmV2hWbWYvTXJRcTVy?=
 =?utf-8?B?bnA5YnFNbGloYWZPLzRVSWJOQkVyalVIQzVYVVNkTzZzc0J4djRuOHBpTkdq?=
 =?utf-8?B?cnFYOGlmd010SXNWNUEvN3JydEpyUG5lVFpjL1NwQW43bUloM1VOM25RT3Rn?=
 =?utf-8?B?T3pwSGgwZlM5Q1R2L3h0czRQZHlDMXQ4eVhHdGxVNVY5NXZlUTBQdUowNUZx?=
 =?utf-8?B?YTJvWW96STlKa0VZeXZvc2ZWS2Ivclp1amx0ZjU3SjRFVDl0enNKeXJ4UUE5?=
 =?utf-8?B?ZGVwWW1LRm0xU050RGZ5eEgxNWpxdVVhS1NaVHRRcG9tT0JkeENpQ0E3dDE3?=
 =?utf-8?B?b2lEM05POWNEaVlnd3VNWjROYVcvdHNsZXlLZTB3VzV2OVZGUjMyQ0VJUkZw?=
 =?utf-8?B?aklSN0xWb2tZQjZSdnFXbkVsUmRLR0VhUE1CSHpXakx1bjM0V0h0TFJpZ2pL?=
 =?utf-8?B?Uk1vYmcrUndqaFZWYVJnQTVLTmo0TFV0NUlKVGdUUTBMVVRkWjdyd2NISHVS?=
 =?utf-8?B?S1c3M2REU1hicS9VNFBkMkVOMllETFBiQlZwK1V6LzZpdS9EcWRJc2lCWnhv?=
 =?utf-8?B?cDYvNXVrTXpXcmh3STA4MWUybDFoZ1ZmcHdqTnQ2ZTVCUnZwWmFqWUlNeW51?=
 =?utf-8?B?R1ZsMWQ0NGhjYzRJS2Q2UXBHSGlJbklnL05mQTJtc1N5d2xKZkxUR1o3OWk0?=
 =?utf-8?B?V24zcEtCRDkvcGJvcnByRWVWbDlaajQxdnUwU3A0ak0rYVBpZnpmdTViRS9t?=
 =?utf-8?B?a1A2c3FraHE5WTBGNkNlbEswR2xRTnV5REdEOHpoNUc2MjZOZTdGVERCd2lU?=
 =?utf-8?B?K2hVS0owSGxnZkR2SFU5OStoQlBTcFY3a0p3cFVMRUlJbEh6dkRQTlc5MEJr?=
 =?utf-8?B?UGthUHlPNkpaZFpYa0ozT0JHSEthK2Fnd3VxMHFmd1pmZGRsZVA3UDJvdWpW?=
 =?utf-8?B?dDIxTEFSREY3WUNQa1dHVGFhWHF2NVJUeWpNMHEyaHFmUjdRbTkySFdPbkxu?=
 =?utf-8?B?bXlLWGhHZUtDSDN3RWphOE5LNFFzamdQVmxIaWgzZUJnVnU3dHBjWDFIaFky?=
 =?utf-8?B?QTB3NmlPbTVkTDJhZVZvQkxYbWsrMVhYaU56ejArdDAvTExNM3ZLeTRVVTlk?=
 =?utf-8?B?bDRtaXQ4U21oRC9MOVREcUJKSms3ZFd5dFp4Mjl3d0JCYVBLeEtEN0V6cVdJ?=
 =?utf-8?B?M2lPYk8rdWtUU0FKR01zVHFkREdabHdQek1Nekt0SWlNN0FOaExramExd2tz?=
 =?utf-8?B?d1NRb0FWbHN6R2tYc0JqRUZybTZyem1IMEZCU09HQXpDenh6aG0xN0pmVEIy?=
 =?utf-8?B?cGdzcHVpSG1kRitpSUJYczdpaFNTYTV6RDN0SDJTK0JDc253U0Z4SEZvZlVn?=
 =?utf-8?B?VFg5NnBRY2ZnVWplQk92dHJBL3E4WkNCS2lQbkZveUkxVVRUdk9EdWMvQ3lt?=
 =?utf-8?B?SzhUd2luYXIvWWhxd2I2QzBqbmRsME1sMFN5d2tCZmlTbGZlOW04cmpxWVVq?=
 =?utf-8?B?MHErang5ZFpPYW1SUHVaUnVrTUkzQzRSZFNzWkVOcVZzU0VyTEkwVXZ3dDlC?=
 =?utf-8?B?U1B4RGpWc3ZuZ21rVExFTVBsVi96Qm9FSnZ5L1ltaHFtZ1EwVmdsNTRLaDBD?=
 =?utf-8?B?ZnR6VHk5TVNzNGlLcnpBVWJleU82YTZaVTJJY0tycWZkOXFRdXJiVTNLc1g0?=
 =?utf-8?B?ckpQSXpUS1J3TGpQKzhuSWtVanNoemVEblNSMjEza0V2ZFVoSmlweXRIY0hQ?=
 =?utf-8?B?YTdVVThhYnlVVkd0TXRIRFErZEx3YzU5S1pQYkorcEJtTXhUbGJDMytHNXha?=
 =?utf-8?B?bUpuOU0rVHA4aVB1MmJCTndOL3JrcE9aWGFoUFM1MGtqcDc4YmVqbWFuTy9v?=
 =?utf-8?B?YzFXYWR4d2srRmJuclFSdUwveE9FVVZFZmVtZi9hRWMwb1ZnWW9TZEJFYTE2?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a030a8c3-bf7e-46d8-0e02-08dce21fafce
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:48:10.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Is95mxQdLZSPXE5DOa4KFOHYr67hepSWbKK5Eq8LOKExAmyG8TbhYZp54hEhoRMIckmPWchMPtd1xq1kFEJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6183
X-OriginatorOrg: intel.com



On 01-10-2024 14:13, Matthew Auld wrote:
> Looks like we are meant to use xa_err() to extract the error encoded in
> the ptr.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>   drivers/gpu/drm/xe/xe_guc_ct.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 44263b3cd8c7..d3de2e6d690f 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -667,16 +667,12 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
>   		num_g2h = 1;
>   
>   		if (g2h_fence_needs_alloc(g2h_fence)) {
> -			void *ptr;
> -
>   			g2h_fence->seqno = next_ct_seqno(ct, true);
> -			ptr = xa_store(&ct->fence_lookup,
> -				       g2h_fence->seqno,
> -				       g2h_fence, GFP_ATOMIC);
> -			if (IS_ERR(ptr)) {
> -				ret = PTR_ERR(ptr);
> +			ret = xa_err(xa_store(&ct->fence_lookup,
> +					      g2h_fence->seqno, g2h_fence,
> +					      GFP_ATOMIC));
> +			if (ret)
>   				goto out;
> -			}
>   		}
>   
>   		seqno = g2h_fence->seqno;
> @@ -879,14 +875,11 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>   retry_same_fence:
>   	ret = guc_ct_send(ct, action, len, 0, 0, &g2h_fence);
>   	if (unlikely(ret == -ENOMEM)) {
> -		void *ptr;
> -
>   		/* Retry allocation /w GFP_KERNEL */
> -		ptr = xa_store(&ct->fence_lookup,
> -			       g2h_fence.seqno,
> -			       &g2h_fence, GFP_KERNEL);
> -		if (IS_ERR(ptr))
> -			return PTR_ERR(ptr);
> +		ret = xa_err(xa_store(&ct->fence_lookup, g2h_fence.seqno,
> +				      &g2h_fence, GFP_KERNEL));
> +		if (ret)
> +			return ret;

Looks good to me.
Reviewed-by: Badal Nilawar <badal.nilawar@intel.com>

Regards,
Badal

>   
>   		goto retry_same_fence;
>   	} else if (unlikely(ret)) {


