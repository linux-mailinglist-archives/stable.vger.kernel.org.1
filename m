Return-Path: <stable+bounces-177604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2732B41CDC
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48E7B4E4BF9
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209062F9995;
	Wed,  3 Sep 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSlF9wFw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC855275B12;
	Wed,  3 Sep 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898109; cv=fail; b=oj2UYcXjTkrUPJO6/HEE+x90Bi3JsrhtIxCVfPG7bSben9dt1h2HJSorr1DlTd+qA3Dq/+MubnTmTAyFXxQ+DiGlGB45vJ3QUi3Uu5KpWZjFpnSiMpOWscASwO++m4RYr0/2Pf50OVe/+UHrX51pKn3mwV7TkN2MBQ5mnlHZ9Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898109; c=relaxed/simple;
	bh=kHRJhG7y/PLX5HetFECJ103upCxlvTluO2qeE2NtjoA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHvK7hXWnONiB5ryqWmDqPxPHiR1HVyIPmWcC1j+L1GEqQ9zQp8h3ay83RtnKxrDUnSrvPC2xA/51rjAjzsv8tEnNUIJVipxTt8/r32iySS4XsZ5ltNvfpG2xxuxmBq4GuJwSA3SoviPdTGUNqN707X54ZrNARlVVzkpk+p9JK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSlF9wFw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756898107; x=1788434107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kHRJhG7y/PLX5HetFECJ103upCxlvTluO2qeE2NtjoA=;
  b=BSlF9wFwh839HZidxyv3FKB9Sa8PsITqtZErEkl7zFuljhCLJuSGGWnk
   9cWPmRRRLNSBhgqAt4T9+m+dqdv1wldLzTwaX0sNUmKAOL6++sBm1HC5L
   oVLmyAjdgnkqZ6Cy8NB3rAhjcQuaP0POgzpblkSzE0NIWoUqQIUSJJm5Z
   bLedSqRcCtdi+w2ux/SAs9JY/2zmqpwsvgnnBSWqW4ifY+DmVni7KgYQ9
   NxOwP+yv+ewPChXfywoLdBRdFgOwuRJJp360XFx9fRj6X9Y9LRCPIBIHe
   XA9/h0FiHNEMcOSm2nBJE1Ey0K0IbINa+qPJpqfgy083yxa7SFdcETjVk
   w==;
X-CSE-ConnectionGUID: nfiqH+aUSDe/NRogVAuxtA==
X-CSE-MsgGUID: a1IV5G2GRRCow1WYsOqLxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59121045"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59121045"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:15:05 -0700
X-CSE-ConnectionGUID: G/tfYOPVTDy6pMihDDTEGg==
X-CSE-MsgGUID: 0rZMASSBQkKj75+1idoBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="170819624"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:15:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 04:15:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 04:15:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 04:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thKvCcL9FKP1XJwKuU4xaq7acv9k6W09wpn5xMjSzEZpLis4USV/snOhb/eDwCRv9UQfnsSqBxgBblEj/1/DQwU+PYI8p/FphjB/h6LplfxLcfPeDYhg9H92MDozBhunRd1JWs0reSz9DoGVUFPiZukx2HZb8eYjUrisPFm4mKAShuZMFzkGvcWMW2c0G0o2RqKpzITV0y0fdAUpB7UH+39g/DHdo3wrnzL1IBylbWPzQ/vneBJR4zEC1h66cgpIbNmbeaZw3+zfuNeIIHXcpvAWn6wTAGPXx1I8TyqY3NLBPvZedaSbC+WlZRzJB6wqiYwRbnQkLbxw20MzOTlcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8xSPqn2zQlADujQzY5nZtSLaxsAYF7uEX3OFIdD1Ek=;
 b=obyNZelpnsZ7R1aAfPpRTFQYuwVboUM8G1jjK7W2BRapplkFkNSLOXDdRFFDqzIfr0E2pc1PfXEfe94MYdwrqKF3twO6WNRl9FoKNwyZN2ZEdx0yK68z+hAUgAjwbD08fHPGhRNh+qNVHEuFVwTcaDn6Gu45X9UevboFRMAgzx4E2PcOodC8h0vzu7/X4ufZwfZbNxp/t6OUunFI2JHh4G1fS2cntHOlo23ILea2+S8KbA7cvrAPqecQTXRoPRLf8sf2jErMtiRJs4CEI72O9/7SNR+RG+Z6hulemY7AZEJHP17FgPSK9X0RKlnmBtl3t8FQzwSFqclsvwlUbRQntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 11:15:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 11:15:00 +0000
Message-ID: <416be416-014c-4efb-9f85-8f7023dcdc3f@intel.com>
Date: Wed, 3 Sep 2025 14:14:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
To: Ben Chuang <benchuanggli@gmail.com>
CC: <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
	<ben.chuang@genesyslogic.com.tw>, <HL.Liu@genesyslogic.com.tw>,
	<SeanHY.Chen@genesyslogic.com.tw>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250901094046.3903-1-benchuanggli@gmail.com>
 <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
 <1aaeb332-255e-4689-ad82-db6b05a6e32c@intel.com>
 <CACT4zj8LxG_UeL22ERaP4XVwopdSjXz7mH95TyxXJ==WKZWHLw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CACT4zj8LxG_UeL22ERaP4XVwopdSjXz7mH95TyxXJ==WKZWHLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e27219d-a969-496a-6c2d-08ddeadb1f9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2FFOHVQMnNnN1U0RndRZXY3WWdROXdNYkQ2cDBSbUxyamx5MTE3VmFoUS80?=
 =?utf-8?B?Y1gwMG1yY2J4NW5GQklkUmt4VG92clpxbVpTc1IyeFZBb3RsSjRRd1ZGQkhY?=
 =?utf-8?B?MFRaNktEc3IrT3BTM2hmVGt1T2NBdnY2Y3A2UjJxeVo3NDl3Y0xEaTl3S0dQ?=
 =?utf-8?B?QW4ya2VmRS9lM2kxZitYVXYrdTFPSzJQKzdCTEFIMWhINDYxc29xVjY5TVQ5?=
 =?utf-8?B?N1ZqRnRNU2YyNDdRaDU5NnZNbTBYV3FJdXEwaXhwYzUvYWZXZDFZOEFyVEhr?=
 =?utf-8?B?b3FDRWJJRmlIL3BZQmJwMVZtK1oxUVJidlhiQTlRakhLTGtYaDZ5ZDE4Yzgv?=
 =?utf-8?B?M1dtMVJsMlhSd0RGcUdIQSs0eDg1bDJXeEFhc3liRFB3disyYXNSTytDOFg2?=
 =?utf-8?B?cHNKRHl2eDB3c2d5UkJOS01YVWUvb2lSNlhGNWxwUFFBQW1PVzlTSU94RXYz?=
 =?utf-8?B?M0FrLytIcVk0cG5iMXJmNjBVK1RBSmFzR1oxS0hWdVE2cXBQU2l6aXpNdWd4?=
 =?utf-8?B?SktRbDNINlF0VDhJMk1sUlBSU0RjcGhuVVRDdy9jR3VkVWdZYUJyakJGS2Fv?=
 =?utf-8?B?cFdmdmI5Q1Y2NWNwdVZaT3FtY1FadThWTSsySG05SWJ3dnZwZmtHNGo1TFhR?=
 =?utf-8?B?dEpZd2FGc2t3bEdrNmQ0WkRwdWhYQnRiT2E5MW1pY3hQcGFnWm5EWmoxQ0Fm?=
 =?utf-8?B?S1plN2d1QTJWS082OWZDbGdMU3JUUTRrTnpRRGlhc1VWMFN0UU5iV2N3SlB4?=
 =?utf-8?B?TkpCNnVISWdUTmJnSWFEQWZzNytqbWowWUZ5U3cxK1FOSVhLVTRaSDZYd0ho?=
 =?utf-8?B?ZUR0ZVRzanNNNVp5RDR1ekFCT2JyZ0I4cURZY1AwSlYya1Fpc0VYbHNRZ0Q2?=
 =?utf-8?B?R2U1QlFnbVNRd1RSb2FGOWhpVlowN0xYbTN0d1Qxd0JvM3dCWS9EdFJmWENY?=
 =?utf-8?B?ZlVMU0wzWG9vc2k5eDZsUGJJMXV5WnV3TXM1NERjVG5neWVSb0pGV3dubFNu?=
 =?utf-8?B?dm5PZzN5ejN5RDArMlZGL3oySmh0b01MSHZudEE0MVBFS0FRaGhqeStwZlZV?=
 =?utf-8?B?amk0WlBBSm0zUk9oUVJ0S1ZmcHg5M1VmVnBQa3QwQXVqWHZ0QWNBajFVU2Ns?=
 =?utf-8?B?NnNwZnFnVVBoNTd1RHdKMjVvTUtoQVl5ZE1hNWpSMm42a01pTFBlZU5Iamxq?=
 =?utf-8?B?b1JqbjM4aDQyWnk3UklVNDJkMnd2S0VSVHMvUGtEU0U2MDY1N1ZUSEhrRVNL?=
 =?utf-8?B?MXNSVU92NzJDNUE5VzNNRkpPSmZmMUs1akd3dUIzcUZUelkxYXlPd1VSZUZE?=
 =?utf-8?B?VDFqU1Rubmt1T3N3N3JYU2FyTXZLeGpnWHp4aWlZYk9ZL3VxeUZTVzFIWUtP?=
 =?utf-8?B?WGJVUXdNYWJmaVdqSFJteWVDbjl5UWQyTHZXYXd3cVZBL3lLeG1vQXVCUFo3?=
 =?utf-8?B?ck80YWFIeFJTQnBxWXFOUEE4blluU3JZUDlrWXBLd2hRRmpVSnhNZXk3OFhr?=
 =?utf-8?B?ZXh1VHpFYy8yZThmTHNwVjVKeWV3MnNNSGRwVHhTRmdBd0NlQ2FyVldSdkhM?=
 =?utf-8?B?L2F1KzlHbUZDN2pKYTFOS0hFTnJ4ZUIycEI1Q2JrdkNQNXh5OVBsQkNqWXRJ?=
 =?utf-8?B?VkgrSXpUY3U3VG1XckxaUFZkaUp0VW1IeGFPRFczNGJkZzVnckZwcVZRMDBI?=
 =?utf-8?B?Ylh4UFdhTERlTXQ2YUxkcU44eXhLVm9ZRlc4ZzlvV3Q4cno4cEhTM0VoOHFF?=
 =?utf-8?B?aG4rYkI4bTN4alUwNUJHNHhRcS9ESnVyMTVnYTBXclJDbFdZSkFOSHVzRldZ?=
 =?utf-8?B?UWREaGtoS2tPMGJpcVd1b1E3d203emhVWWRUVjMwOHp1M1pVNzhOL3d2RUsz?=
 =?utf-8?B?YmtncFNoOEVlckpCbzJDU3lBQVVUdkZldGVwMEVrTGFVYUpmaVZYeUozK3Z1?=
 =?utf-8?Q?zfMjPpeUlHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3I1K1ZhWTdJblVmdFQ3enQ3Rzhrc2NQdXVKaUdHRnN6aTFMenEvcWpVclRX?=
 =?utf-8?B?TWo2TlNlM0V4dHpsS2pIZEoyYmFkNTJRc2RERU5XdkxQY2g5OENJS1NGVVRq?=
 =?utf-8?B?MHR4M3JiM0Q1S3VBWWpqbWNqYUowRnU3dUM2WXVzYzh2OUg1SjVjT0laVzZq?=
 =?utf-8?B?RXQyQzdyclJhN1ArckJiRGtVakc5emxUY3lvNUw2WW5CZmZ1R1N2cEdrQ3Qr?=
 =?utf-8?B?bm4vbkEwcFg2Vm0vVmRaQjQ1SkdOQ2EvWmhpYUdiUnRpaStFZkxKckovUUtI?=
 =?utf-8?B?azN5VHpFRUNpcnVwUFpsVWNCcFFKc1JnTXJ6cWZETnJPR1hzQmNrU3FZaVhD?=
 =?utf-8?B?QkFSZU95TEJnTC9rcURpcnlLY0Q2cklBMmNYSVhZQmZ0d2xueG0zQzNVeXdI?=
 =?utf-8?B?NytscGdPWGwvdG9kU2tQYnAwMHNlL0VLV2picG5YV0x0bDZ3R1JSY0h0Zjk4?=
 =?utf-8?B?Vnk3WFVxTU9SbFl3RXlzcVhDbDRNR21WSWp0OUovd2hLMEtxL2ptZVluZCtS?=
 =?utf-8?B?ckhIUkEwWEJBVTByRG80a3NleTZtWWorOFRjek5icVBTS0pranRRakdLZDhN?=
 =?utf-8?B?ZmR5TDZLR3ZHdEdEY2NETkhiVWpqWVNFN2VZUWlVb3NtdXFYTCtpTUpJcER1?=
 =?utf-8?B?MVpCRmpVMXQ5RndKbmNXYnV6VDd3WWpxaHF3bUlGODQxVHFhckJjK01BdGxi?=
 =?utf-8?B?eDFWR2xhczRyaWd5SlRnWk0wVTZIcU1GZEc2cmk4ZVY4T1VCZG5TVXoydFR0?=
 =?utf-8?B?eFdMT2ZUcGgxOHN6Y1F3WlhVUG50RUNnY1ovVjJtdTZ0WXNIYkgzY2F3L1hy?=
 =?utf-8?B?aVZzbkFscGpKaWFxN3V1VDFjZDJkNzY0eUkwc3VZbWt2MTJDQTlHWkpkd3BV?=
 =?utf-8?B?Y01BNEIzdlBEQm5MT0QrQ2pzd3REb3g4SXo1Mmlmbmp4aDI1Tk5xYWUzVHhU?=
 =?utf-8?B?eUlGdXRTRjIvcHVEbUJVRndnM2JNMW05SUJMdGZSZUhPUTF1SE5uZUphU0NZ?=
 =?utf-8?B?dmhZVzdnam9RMWRkMU8xNU1nRHNDMWtWbmJIcUlhR2QrcHBqYnNIbzRJM2R0?=
 =?utf-8?B?aGNmcnBNd3ZPampFT0NmQ2xuZ1RtQ1BOVTdWUGpFdTJRSlA2TmVKcFJYQUdk?=
 =?utf-8?B?cWl1Ri9vSUQxNnA0b2JIdDVYNS9SY1ZKSDg2WFRCWkVyU0VybmVpMnNtRkh0?=
 =?utf-8?B?UFBVR3BIeDYvbXM1dHluUkJKYzNmTTl5OHNvUHllelEvT2V1aWoxeGxDNWt5?=
 =?utf-8?B?V0lIWjFhcE5ON3dHczllVVBNOHV1NzVDVGx6blZCRVIwK1l3dzFka015VHB6?=
 =?utf-8?B?czhWcWdTdTM3bU9rcmUzbnRHMG5tdUI5VGVES251YkVQbXVQSElhVG95Tmw2?=
 =?utf-8?B?VnpyZWliWnZYNEJWWWhwa25jeFpwbVBTN3ovTUh5VEIxZ0xjdTFYeGpycTNL?=
 =?utf-8?B?NVNqOUFRRm16aFVEMlEvd1hUL1A3SEJGRlIzQU8rNXpGTit4ZEp3amFERmhT?=
 =?utf-8?B?d2QrN3ZVVGNXOHZQNTlSc0VnUDczK25FeXBxREltT1o2TTcxZkhHSEZzc05G?=
 =?utf-8?B?eCtUS1g5bnRHSkNXQWcrK3J3UEJjS01kSDNPY3RjblZCcTArSXJqVnNFSm84?=
 =?utf-8?B?dWM1R0NLeDl5L2xFSW1IOHhhbUJINzBFS2Y4cnYvejJWbUZFN1dXVEtGaTJS?=
 =?utf-8?B?ZG5GQllMa1lhV0x2NkRDRGVVRE9yb05vR1NNMm5jSDJDQ2IwdnRKNkw1aS9t?=
 =?utf-8?B?aG9kRE52bWJqTjdDdEVjcEtTbU5rOXQvNkFkLzJqd0tzSGc0dTc2dUR1T283?=
 =?utf-8?B?enZYY2NnblZoelBKWUpmL1JhWDlCeFhnNERyand3Wm5QVFBaTktaU0hzQkM4?=
 =?utf-8?B?cVFXUVRBV0c0L3hJSXZYaGQvbG9UN3dNWEVUaFRtUXczZ1VrVFc1MDVNM001?=
 =?utf-8?B?eUs0MUUvTStXTXRJV1o5SGYxWkpRR0pnM3RpbFQ4NjB3bDZQSmN5WlpEenJQ?=
 =?utf-8?B?UjZvWnRLcEI2Y1gralltSnRNMndCL2V6aStta0w2aXJRd1dlendwcWdWQ2xs?=
 =?utf-8?B?Y1F5WVRsdmZPamhWSVBPK1doQVByNWhweWpPYUdhNlVEdHgwUW0wSEd2Ri9x?=
 =?utf-8?B?bklMVkM5UGNUVi9CTi92TU53V0dwSm0wV3Q2WWlkc01XNGliNUtxeVVJaTh6?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e27219d-a969-496a-6c2d-08ddeadb1f9c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 11:15:00.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SyYlZeVI2yFEEu6aXce0uRstWC7tz/UpfhClOPpzyx8GW0D6VUv/1GWEssbf5PAz+Dkzrw7KXTPuz0CYxqAMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com

On 02/09/2025 09:32, Ben Chuang wrote:
> On Tue, Sep 2, 2025 at 12:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 01/09/2025 15:07, Adrian Hunter wrote:
>>> On 01/09/2025 12:40, Ben Chuang wrote:
>>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>
>>>> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
>>>> vendor defines its own sdhci_set_clock().
>>>>
>>>> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
>>>> Cc: stable@vger.kernel.org # v6.13+
>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>> ---
>>>>  drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>>> index 0efeb9d0c376..704fdc946ac3 100644
>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>>> @@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>      else
>>>>              sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>>>>
>>>> -    sdhci_set_clock(host, host->clock);
>>>> +    if (host->ops->set_clock)
>>>> +            host->ops->set_clock(host, host->clock);
>>>> +    else
>>>> +            sdhci_set_clock(host, host->clock);
>>>
>>> host->ops->set_clock is not optional.  So this should just be:
>>>
>>>       host->ops->set_clock(host, host->clock);
>>>
> 
> I will update it. Thank you.
> 
>>
>> Although it seems we are setting the clock in 2 places:
>>
>>         sdhci_uhs2_set_ios()
>>                 sdhci_set_ios_common()
>>                         host->ops->set_clock(host, ios->clock)
>>               __sdhci_uhs2_set_ios
>>                         sdhci_set_clock(host, host->clock)
>>
>> Do we really need both?
>>
> 
> We only need one sdhci_set_clock() in __sdhci_uhs2_set_ios() for the
> UHS-II card interface detection sequence.
> Refer to Section 3.13.2, "Card Interface Detection Sequence" of the SD
> Host Controller Standard Spec. Ver. 7.00,
> First set the VDD1 power on and VDD2 power on, then enable the SD clock supply.
> 
> Do I need to add a separate patch or add it in the same patch like this?
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3a17821efa5c..bd498b1bebce 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2369,7 +2369,8 @@ void sdhci_set_ios_common(struct mmc_host *mmc,
> struct mmc_ios *ios)
>                 sdhci_enable_preset_value(host, false);
> 
>         if (!ios->clock || ios->clock != host->clock) {
> -               host->ops->set_clock(host, ios->clock);
> +               if (!mmc_card_uhs2(host->mmc))
> +                       host->ops->set_clock(host, ios->clock);
>                 host->clock = ios->clock;
> 
>                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&

It can be a separate patch, but the whole of

	if (!ios->clock || ios->clock != host->clock) {
		etc
	}

needs to move from sdhci_set_ios_common() into
sdhci_set_ios() like further below.  Note, once that is done, you need
to add "host->clock = ios->clock;" to __sdhci_uhs2_set_ios()
like:
	host->ops->set_clock(host, ios->clock);
	host->clock = ios->clock;


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a17821efa5c..ac7e11f37af7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2367,23 +2367,6 @@ void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 		(ios->power_mode == MMC_POWER_UP) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
-
-	if (!ios->clock || ios->clock != host->clock) {
-		host->ops->set_clock(host, ios->clock);
-		host->clock = ios->clock;
-
-		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
-		    host->clock) {
-			host->timeout_clk = mmc->actual_clock ?
-						mmc->actual_clock / 1000 :
-						host->clock / 1000;
-			mmc->max_busy_timeout =
-				host->ops->get_max_timeout_count ?
-				host->ops->get_max_timeout_count(host) :
-				1 << 27;
-			mmc->max_busy_timeout /= host->timeout_clk;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
 
@@ -2410,6 +2393,23 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sdhci_set_ios_common(mmc, ios);
 
+	if (!ios->clock || ios->clock != host->clock) {
+		host->ops->set_clock(host, ios->clock);
+		host->clock = ios->clock;
+
+		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
+		    host->clock) {
+			host->timeout_clk = mmc->actual_clock ?
+						mmc->actual_clock / 1000 :
+						host->clock / 1000;
+			mmc->max_busy_timeout =
+				host->ops->get_max_timeout_count ?
+				host->ops->get_max_timeout_count(host) :
+				1 << 27;
+			mmc->max_busy_timeout /= host->timeout_clk;
+		}
+	}
+
 	if (host->ops->set_power)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
 	else


