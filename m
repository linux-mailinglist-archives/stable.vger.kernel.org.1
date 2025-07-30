Return-Path: <stable+bounces-165536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A3B163F1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6BB1AA0836
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43E2DC35B;
	Wed, 30 Jul 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpLEDcIb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22532264CC;
	Wed, 30 Jul 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890866; cv=fail; b=UmztweS3ayJrRWsU4lz7fPnIC/J5FdKKMov8Z8cc+qkkUa3vykdASI88L3OJ52R+GyTX7utBVtY75nHvdKXVXxlCYgB4U1OPFOjMIxzvSPPGlrB0QcHzwKLdNjSQEEAAZyBomosZUw68xKtf/XkW8BM74meUpeefIc69OOtJfDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890866; c=relaxed/simple;
	bh=piC46nSqLrfnPJov3O7mqjQlfGPPdaMMuzQUuAt5jb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e06JYF7igULeAJOu6HsDKqS0YNH9xwtung2Frd6+3r8dGjaIdk7r/Gv5xoGlOMNzH0ekR1UHSQjCTdz1vUtdFxb2pyjFt8DLKTeOJhqthdUuW06Nmvn5BK0mBWy4vuWmf0hbjC+Z0Xad6R0dOucNZeWduefz2B/AWZxICnojtRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpLEDcIb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753890865; x=1785426865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=piC46nSqLrfnPJov3O7mqjQlfGPPdaMMuzQUuAt5jb0=;
  b=lpLEDcIbBA5u/reREDq7e63orPFqhVEsAsChZxXJCJ7RlDTJE2noLPZ8
   dLZ98vhpN0FX/3d9IaXgWDKn0ekQk5YuvizWIW/pb6clokOhIkpabpBPt
   5aY+ii9poQgFP6Rs728YEJG5adYQvWBZX0G2aAuH3zRbNsq6rXEr+gk+U
   FOvuNO9te3H3PBcEONxrgAQeu4eSRLM3KDagnsntSTdSLKV7/YBU1xUk0
   xyTWzc0MUSXWvuFdubq8W1nBK4XF1ZBdFBdsc8kgYgbOj80roYNvIGsnY
   N1ISDTQnfg7aQeBtPD9gk0aRb1yenDwWEcFCSIHDHVrPUd7JyF6rnhQ5P
   w==;
X-CSE-ConnectionGUID: 0KU2Ld2yR0KVMOWuC5vHag==
X-CSE-MsgGUID: GH9m2LaCQSGIiHw3/ikTdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="78748801"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="78748801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:23 -0700
X-CSE-ConnectionGUID: GpBbEiLmRAycRYFW1OgK0Q==
X-CSE-MsgGUID: 6i2/Et5pQkyvAtbH5Dw2Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162608233"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:54:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 08:54:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 08:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7B7svStKhGf/flaJpW7NCfWFH5FhlCZ8eAWGcnk9mLwEEulO3vsrysWKMt6tiltmB30ibrAPzr2QV5S4b/LxySJE+fZMeLjitb52NQmS05DAUkrG/OlLFmLdStw3oy2vbNUj+QxSjgl96YpZsuYXLdt1cOVjug2USTPTR/tN4VWTIcRzJ/ZiHTYOjjVVRn+8/PY21bNhq4kCsW3Z96lI+HrRZ42jJ3yIWD5eUcfiEZ9gFp8uP+N9XcWvcn3ZwwPeWb2CAYKiyonJfygNvaOzZyu/2FZgq9t2khV2mxxeW8OjL7KXIA2T++BjoUNcmzam8P5F6Fjy90FF2hiIqxw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNxLVoAVzABADkCzxWBwdfMxwMIJUVcf2QN4rozhQco=;
 b=bGgIXXqd8EhbdBR1IZK+6epvqDvipf5S4dBMHpmuwEO+6+ZpQjVRtDYp0FgyUIAuOBXsRFK4oBMT+JFGssKNm8WFciLvM4dwGIsuGK92xh95XwdHQg9tClt9Obz3RUUr0YuKc6Dg8vTbLcvckKmTpEtndQwj+sTNjVjVvOP3mn7OJPUHfTH2AnpsFQV0lWtSeJGnGE6OkrjSLe60kQK7iJVlljFz0wiZV4AyE1wRkku/r5ZtoXtUSivfYzdHWf8rkTRw32g7df3t7tbRpu58RSXO6871Hy+Cm3udbKEq31UxN9IcwfCmVSF1V0y6wH8MIlQgkP7dSg6k18fLaITgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 15:54:20 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 15:54:20 +0000
Message-ID: <7c20e0ff-8592-4f54-8cf3-a44bd88173bf@intel.com>
Date: Wed, 30 Jul 2025 18:54:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<stable@vger.kernel.org>
References: <20250729065806.423902-1-victorshihgli@gmail.com>
 <20250729065806.423902-4-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250729065806.423902-4-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: df962709-0dcf-4ea8-60e8-08ddcf815852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzVPWWRqTVJpSlpiT2JKcEJTUE1mTHFHMEhGSjB6T2E4YVRWbjdXWWRDb05M?=
 =?utf-8?B?SXJCUlF1MjBhT2xZdjFzVGRDOW1IMWJDTlNmbTVsNGJsMEp0R1ZhN2I2Q1VQ?=
 =?utf-8?B?cEFqTkFVYXIzRFQybGVSdGlyYm94ODhhRy92WGMyZUh5aURtUmQwa1c2aGsw?=
 =?utf-8?B?TUhMNFBPamNEUzdZSmlZTis4TjZSZGJmZ0lIS1g4a1ZBbkNHYzBkZUp2cVI0?=
 =?utf-8?B?dmNBSVBiT01FWklBZEpqUUw1QlAxcmNQa0pNWFptdGh5dWRmY0Q3VU1QV1J3?=
 =?utf-8?B?eWkrSnZvMTlwUE8wWWxZaUZpM21LNzNzNjBXcXZBZXJPYnl0eHRXVkFQbnRJ?=
 =?utf-8?B?K0F5Y3FmN3lyQmUwYm5nMWo1WjJPVys4K3JNekJ2M0xLZUw5dVhkeVZmMWwz?=
 =?utf-8?B?Z0lYVVRYeWQwYjVpVVRkUzY2bUNzSk9pVnl3eGlOODVldEdYRWpRTk1uZk1V?=
 =?utf-8?B?WjU2VEdNd0lpNUx4enl3QkFTYXpweVJ2d2x1TDJWWjJtSHVvVmY3eEdqK3pU?=
 =?utf-8?B?cDhYYTBOcDZzVnVuZnp5V1hWaGJPcmx3QW1jWU0wR3Qwcy9FdVZaQWd1RFVy?=
 =?utf-8?B?NlV1Wjk2c1hVSnNuWFJndmJodzhPUkRCQkpHMDl2U0RKZE9lZkx1OHc3czdX?=
 =?utf-8?B?Qzc2UHZqZVZZL0RIRUZ1VjJlNU55RUF5VzJiY1NvaW5KWlVlS042eGhOLzF3?=
 =?utf-8?B?clpDd0JJeHNIb0VCMUdwaHJjbVhBdWtOVE51eldPcFpnK3RSTXZuMWYwcTBQ?=
 =?utf-8?B?WjZEWWJZVFNyMnhjSVUyTkJ4OWdDWG1CS000KzlMS3J2a0FhNHhLWDBYZk83?=
 =?utf-8?B?WGFQOGhBa2NUVEdUbWg3eVVlSnVlcnlFOEFpZC9MVUZPSVNkcndlTFkyc2ZQ?=
 =?utf-8?B?UStkL3ZZRHVIK2xzck9hbS84eXMwei9WMHhEYi9OVXJzNFZDTW1yUEJJTzVw?=
 =?utf-8?B?WUR1R0J5S1Y3NzZ0eG0veXVTUkhpM0hkUlp1Ukh6Q2UxMmpVRVV1RWxGTEs3?=
 =?utf-8?B?S1Z3RWV1Q3VDMkhtZFJHKytaWW4zS013aWhUL0oxWGQ1M3B0SVgrL3luTU11?=
 =?utf-8?B?ZXhCUWUxRnRQa3oxMFJlQ2V4T0x1THZRbkhLVE5QMmN1T1VIRlc4QlNTbWdJ?=
 =?utf-8?B?UFZWWWlGNC96ejMvYW9pU3d6WFQwbE0wODJ5VVh3YXpGTy9uVFdaMEljTVpk?=
 =?utf-8?B?ai9yck5ya3VST1BzKzdYU1ovbjk0aHNFTzBtcnU5Y2RlOUpYWHdTdUNpSU5o?=
 =?utf-8?B?SGRaN3J2eUZLN3QyWVNBaHMyRXVadWdpUGtIZFgzT3lGSHZnUWNkK1VWNktk?=
 =?utf-8?B?K29UMEZlNjdrV2V6RjYvbHRNRndQLzF1MXNHYUc3c09ZZTBsL3cwVm80aGVF?=
 =?utf-8?B?U0NseUN3VVdlSGZocW5qNnJ5Yk05S2dENDdZNEFoTmo3ZEo1Q3IxL0pON1ZG?=
 =?utf-8?B?TVNQbVRHS2xWdTVVd001VU93eS92bzM3TzdFc29GZWVqRDdEMWIrcmlsY3cy?=
 =?utf-8?B?ZThCNXZRTEtLK0QzaDlqdE1Od2E3WFczelhpM3V4ZGlQSmgyWFh5STlzZDNQ?=
 =?utf-8?B?blB2bEVUQjV5VEZ0R3VTN25DK2tHVGx0dkpWVFFxTDY3V2JYa25jK1ljVzA3?=
 =?utf-8?B?ci90K0cvQ2xEbDRJQVZQRGxqc05TNXR3T3ZDbDVzT0I5bXRLVDdESE5DRjha?=
 =?utf-8?B?M1VYekg1L0FFYWh0eFphUlVnd2Q1ajhYcVJNZmp0SUJhYlFjZkxzWTl1eFBy?=
 =?utf-8?B?OHNwa3JuMFc4VWhUMGNPUzZuTWg3VGp0dUNqYW02dGlnalRjZDQ5TnNYL09k?=
 =?utf-8?B?eWpBSU1UaFdsRDFrejI3TWlrN3B0SXYxbHNsTHE0ZmFWcWFZV0cveHdQa3dm?=
 =?utf-8?B?TzN6ODFhZkFrZkE1VU5zMWVuWVFwSTZQQnVxQ3hrVUgwcDI3QzB6UjArZVQ1?=
 =?utf-8?Q?G3QqJVNcm7A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVjTXJhRVRFRDJWeXFsYTBQTnN0NnZDL25jSnJjZU9EcStTUm9BT0ZyT3Zq?=
 =?utf-8?B?MUFwczI2SW9vcE4xdG90OFRuQmZUY2dmaDlyTDk0NC82Q2w3MnhOR0ZsYW9S?=
 =?utf-8?B?cFBQWVliUEJEWS9kUTAwQlJJSjE4bUk0bUZkSVJ3RzNvemlQZERLby9vSUcv?=
 =?utf-8?B?K3ZxNExSbTArV2tSQlA1OFhkaXljVGlDTHRWaGlXU2g1L01Lb2ZxSnE3STNu?=
 =?utf-8?B?VDVXQUNCQkFBdWZaKzhhcVp5aWlCTUh6cDllMDBFTHc0RTF3emIrelBreWJB?=
 =?utf-8?B?RzBsemQ2b2VBUHhtdW5aVEtJSTdqeFo5SmgvcUZrQlgvTHlOWVlpYVNVQTYx?=
 =?utf-8?B?aEJlTkVXUkhMWEt6a1JzdHlHMGorWUpVdzhVMU94NFVLL3c1RDE0alg3R3J0?=
 =?utf-8?B?aFhNUVdMcnhXNFRqaTVEQW1CTXBITVREdzQ0SVBWVFpPWWgxem1CMzljb3V4?=
 =?utf-8?B?ZUFzdDJNSFJDY2Y1QTVBcTBUck1Hak5DNGRZR2VySnVibTc5clVBaGtJRlBP?=
 =?utf-8?B?SXpxbTR2czI2dnVid3BKOXY5Rk5rTWdrMHhySDJYMTdUVEQzZ0hBOXJPWFBv?=
 =?utf-8?B?RlVMTWozMDFNbUpNUlRmT1NHNkxyL09RQ1ZNK2NYbE1DVDJUdnJHYkJScGNw?=
 =?utf-8?B?MVBldDlmeXM2ZmZEUGFhOEoybXo0UlBNR2RibnB1OTQ5Skl3eW84czhkNlFS?=
 =?utf-8?B?QWhDWlFkRmJacUpHd256Z2xzTHEwNkk1S1h0SXExUzkxTlNaQUxqSENIczRk?=
 =?utf-8?B?VSsvUk4yai9wcWQzd2FKczZUTU95UEtNRXlKRUNqUzBjVEhRUXQ2cENoeWQr?=
 =?utf-8?B?YWQxZVk2SGY0czN4M1hLeDBqc1czK3kyM0NLV3NjaGxJWDFSb24vVXBhM0FT?=
 =?utf-8?B?ek1sKzNmdWwxR2svRzEwelZWTTU2dnZybU5nK1grM0FqaFRQNll1NmtISEtr?=
 =?utf-8?B?cjhEZlppUUFXcEorSTVORmJzZ2l3dEx4NnBkMU93UWJTMmZLVlNpTm1MZkhP?=
 =?utf-8?B?MXNacndCTTBmTVkyeXJDUHBxaXZQS0wzNXp6Y0pkakVvejNhUnUzUUpmWXJj?=
 =?utf-8?B?YTZCbkhpbHUvVmMvTXY2VGdlYXluMExrRytsczk3OEgvVTNXU2R1SlZZbDls?=
 =?utf-8?B?b3FWbWJackZ4ckNPU0ErQmdGMFdqV0NKZENhZ2hZVVo2NGkydk4wandDY2Jw?=
 =?utf-8?B?YlpiWXAxZlBrOEl4Wk9IRTlHcnVmazRzR2MxVXJYMS9QK3ZUMHVpV2FzdUlX?=
 =?utf-8?B?ajN5Uk5BRG40NXcvK29xZ2FsMzJUTDFObXVwOEc0cG5uQktEY3NXTWRsWmlr?=
 =?utf-8?B?V3B5MXQ5dEpkcWpYVWZOUUJwMC9KN3J1ZWM2YU82YTZoNDZYVi9hM2xxVDFK?=
 =?utf-8?B?MkQyZi9uR1NtZk9UNUVXTmRsR1hxdDNFaVp1aHZzNG5UYjFnMXRmN1E1T0d4?=
 =?utf-8?B?ZGZtaVo0VjRQZ05mZCtjK0tJendpYUdTcWVMbG9zZ0FnUzRiN0pxYkd4ZVA0?=
 =?utf-8?B?b1FmT2RWZkEyR0JOL1JTUVpRQ1pVQW14clMxMklSaVpsN1lockhqc2hlMSth?=
 =?utf-8?B?Y3IybktKRkpTNDhYbjJSTjBBbm9TUDFNL2JscGtLY3JoRVBucVdRQzZmdGVL?=
 =?utf-8?B?REU4ajBFUXNtYXQ3aEg2eTJxcmsvZ2xmMWlCdkRicTJIbGVQNmwwNmlSY1BK?=
 =?utf-8?B?dWcvZDMvUEdrQVFKaFNTWjdQeTZTUkRsVWdFT00zRmxFNWliY0xPdW5jNkI0?=
 =?utf-8?B?VmI5K0ZleThuVDhqT2JnKzhRLzMrN1lOVDk0dkxFZnZkSkthdFA4R2ZNY09r?=
 =?utf-8?B?NHhmajRiU1JJcGN5SEVmc0RkdHQrTHh4S3hSMWpYa2s5bDcxYkpLNDR4K2JW?=
 =?utf-8?B?WC96NDRvN1F1SkpNWXQwclNVWDlHNm1QVFp0VlRXaTB4eHVqTy80QXVEdVJ4?=
 =?utf-8?B?ZXdscGx6cFdERG5lNFhGRXc5TDMvRVVWZUEreUp2SWw4WndGV3hQeUVlMUtV?=
 =?utf-8?B?eXcwSytobUdkNUlKOG02bEk2dlNPUjBDcHRlWFdsUS9xOXozYXFXbng4cUVP?=
 =?utf-8?B?c204ZEU2eDFkN3hodmF3RDl0R0RRK2ZSZ1hzVzZvWEd0eEJveE9LbnlQZEIy?=
 =?utf-8?B?WXhMRk1GZzN6dEdtVW0ySVA0NDk4bWVHaUVvRnZPOUJOWDQ4cVpSL1RYeGZN?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df962709-0dcf-4ea8-60e8-08ddcf815852
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:54:20.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlC9eauNwRxENGXiox2yDga/5pT4R1xA48DSTJdQ3g5Ty/qo49YEJoORxm2Cq38K4yD+MFD/JWRXAFfzbnVj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com

On 29/07/2025 09:58, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Due to a flaw in the hardware design, the GL9763e replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9763e
> PCI config. Therefore, the replay timer timeout must be masked.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
> Cc: stable@vger.kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 436f0460222f..3a1de477e9af 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1782,6 +1782,9 @@ static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
>  	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
>  
> +	/* mask the replay timer timeout of AER */
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
> +
>  	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>  	value &= ~GLI_9763E_VHS_REV;
>  	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);


