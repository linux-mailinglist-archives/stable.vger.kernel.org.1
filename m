Return-Path: <stable+bounces-176890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB92B3ECA8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95B3B2BFE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E292EC08B;
	Mon,  1 Sep 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLqycmJV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321332DF13C;
	Mon,  1 Sep 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745422; cv=fail; b=WRKQywxn3AZUU7iKSsvKBmaGmuUkTsv5WUtwtR7maKaJQVPfK4/ecK6w3HANYr6aKXXVAhZzmPMlJr40Cw/S8Tj73SpnI1aAQKHZ7zCPiaIyoQ5Hrrjaf9zuS39pLErtyemF/fmF3cRJvmN4X9BsSVep9NXKFtBpshXuc7UaI+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745422; c=relaxed/simple;
	bh=638ZW7nk1Vf0OSc5uszWRH90J5taM/ffOOi6qeN1rb0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NaF+se2ajwYO6RzjdhW0fvdaKKgJX8nN/JJ65msRBfNkNotOWzXVie9K5pggYAMJX/pe+V7IcLOqK4a8Nb2rxuwX03gIOfqwppt/4jL+izKL7lFzsCFyvGKlzgOyyHckvlFfCOXq++XXdXQ5+AIhaQ9z75vVmh8TKMl3nby6Rd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLqycmJV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756745420; x=1788281420;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=638ZW7nk1Vf0OSc5uszWRH90J5taM/ffOOi6qeN1rb0=;
  b=kLqycmJVdq3+W0y4XphFiBpBdfbHjPkzovV+NMU1ID5trvbGN0sa2xTL
   b/zylsVng1tlPKczZ/pJbj+hWGPvDF+1QHg3RUXMYOWToeZ31QwXhC0b2
   vlPtmGj4f3J0rFW4gQMTwNS3zCU4nN/IOh/wHq0pVj74j0P8sFR3rq+X3
   VMIeDB4tD0R338lF59RYXmbEsFTucztT2Ykk9h2SmlNstnfAFHNQej/Wg
   RtOaPiTwKZE23XWWi1rY3CtUizyyZdgFtiXW3xkaz5a/EiPMPOf42gOya
   3J1nHudP5R009Ioh1qqBDVP+rr57xgoksDxfhrsd0Wy0qLTglVsbpm4yG
   Q==;
X-CSE-ConnectionGUID: 9oeQIfLaRgC5SrXFnwaeQg==
X-CSE-MsgGUID: dp0ZcRKPSJGQgtZtEyYZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69274026"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69274026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:50:20 -0700
X-CSE-ConnectionGUID: 3W+VeooWRCGye+Tw9stA/w==
X-CSE-MsgGUID: OHpLslPkSrWI/o4iKIBPwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170616251"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 09:50:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 09:50:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 09:50:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 09:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuH16gKfb6vT/JKf2nBftBLpmkqC8/1kosC6lA6ylXZ87FcYeF4PkUNWgvTV373vx3f68XT0BC3XR2JBpUF5FgikSi1PnVNfW4ycAMHNygCevHYZKfkW0nxrjlkDnC/t42GT38F+3PUUu0MiGKZXFi/G2nvZSwZenYktkqPPVMwjjaprBF+he2Por6aF+c0xYt2Vx8e8J3gV1aaiNOEk+WZTDlq5zISblvFJiJv1grUJxx1az4qDImtp0JQxRZ9dtm82BgZCYatkDC76EmEbaICILVIiAoHyzP2O/KuEaqCKbdF4xtt4M0NrWtKBIfmZ1iEle56YNgdSY9j8JD1Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX5ybZBKvsQKBKqjPS5fR5N2SO50yM7WzeWCyn3jIcY=;
 b=ifAvTtuPKmCPaTL39vYbIrWbzV/6dkpkLgnAXIc8LR0Qze4aUPkrO+mDZ7+9kkjC6//UtAcyoo574LCAuYQ3EYRtTUFms8n3r2+FgZoDPcGBdyjnNaJE4SRFCl9M2PHIVkVaEaNCDveG7u9JM6BdwgClEtejNBpLURiUNdNGR0sBwcE1KfFYTir9049K1f+Hf6EznjriiMcwRQhVnfFp7RHV2D4BtXL1Ql7lPjM7vCi8jqJrFH0ziHaaBPOb/Q19CjvggYkYR5B9ZUUVrH5/1+QU+vbeplwA95P2NuS9MT+pcEArvv8V2/z3syyTAHFjT7vTnei4nS0Dpv00YVgKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 16:50:15 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 16:50:15 +0000
Message-ID: <1aaeb332-255e-4689-ad82-db6b05a6e32c@intel.com>
Date: Mon, 1 Sep 2025 19:50:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect
 sdhci_set_clock() function
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ben Chuang <benchuanggli@gmail.com>, <ulf.hansson@linaro.org>
CC: <victor.shih@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <SeanHY.Chen@genesyslogic.com.tw>,
	<victorshihgli@gmail.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250901094046.3903-1-benchuanggli@gmail.com>
 <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <86721a4f-1dbd-4ef5-a149-746111170352@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:8:1::30)
 To IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3189955a-5e17-4a61-6bd6-08dde9779fed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThMQytWeXFPQXBMN2tiMXcxejFlcXlGRDdHZnlDSXFyclhOV002VHpPRWRF?=
 =?utf-8?B?ZHI5anBTRDN1ZDJpbU1DSGJTN1VrdXpzTG02Zzg1Q2ovcWxzcG9UdkVVYTZJ?=
 =?utf-8?B?TUpzUlpzL2hWVG5vL1ZMSmNYR1VpNW92Ky9UUVdQbjI3Q0JFQklDcDV2eWp6?=
 =?utf-8?B?bHROVnJ0dVRTVnJyU0xNNy9GWHpKbklBcWJIVC9acWd5bHB4VWJxblJMR203?=
 =?utf-8?B?cXo3RlRYWnIrdHlhQlRrZDlFR3N0TFJPNlBVblBlRE9valF4M0VTdTM3aVlC?=
 =?utf-8?B?WEVMR3o5czBiT09XcGpKcFZlV09DYzlvR3BPRk8yZ0gzOGtsSGd0V0o0NjlV?=
 =?utf-8?B?MC9PNTdoTkJRR3Ruak5aRkNrMTF4VzhHcWdiV1dEYkUrMWN4WEliUHNXdStJ?=
 =?utf-8?B?Uk15MkZnN2hHalRtRjlUMlNLUFFTYW1oS253VGRMVGIxNGM4d2VnM3h5czNQ?=
 =?utf-8?B?eWtXNTlrcENMcFd0ZTcxdG1haCs4cTRmNVUramdFRXJOOU96MEp4dDhEa3Qz?=
 =?utf-8?B?cVFKNHJubmxnL1M5RkhGNFB0M2FvRnhxMWZOTU1pTW8zRDVNaGFadGd2cWRR?=
 =?utf-8?B?NEExZ1hXNGl6M2hCUkVkZi9tREwvSnBpZ3ZGOUFGV3VJNmV4aHRuaFhiOEpm?=
 =?utf-8?B?QURFL1gwdTlYNmRCSEg4WStwaitNcTNrRVRTU052bk1VSW9MZWpsYThBL29U?=
 =?utf-8?B?K2V4eUNnREhWeVVBZUhxUG84czkvQmYxUGRzTVAzbzZUeW85QVYxVWk1TGMr?=
 =?utf-8?B?SzgxQ3N3eEhSVFErYzMwaW4xQnVtM0V0dUJLUWhqNW5rR1VqU3FoZjNXeVVT?=
 =?utf-8?B?dU84K0cxMzlZNTA3ZmhiSnJET25kTSthcVI1eVZDR2RBZ2NkbXphcDFGdWxo?=
 =?utf-8?B?RzE4TzV4UUEyY0FhT0ZnOXpsTjZOT2NIZjhQb2lKZDJWb2Y0NVJldmhVRXF6?=
 =?utf-8?B?SVdyNW5nanA3amV2MzNoeWd1dDNUU2lPQVRSbU1vbXhRdGZqMDJoZ25Jcmwv?=
 =?utf-8?B?czk2TVk5R3N0aDQ5TEFSRitFZWlUR1I1RnEwWmpuT1FIZUlhZjJvN3NtZWZv?=
 =?utf-8?B?c05WR0gydzE5WEQrL081dll6VkR0ZW9KUGw1UktFdzJRTy9lRE5NS1JIZklK?=
 =?utf-8?B?U3pHdFpKYXE4N0NISFN6ZEFkQ2Z5L3hmMmtENGlCQStVM0RuQ3ZBRlpyZHQ1?=
 =?utf-8?B?WStaTmRLSDljcjU3UW9YVUdGOFJQWWZkY21tYjM1VHpsMGhOT01wM1pRWDMz?=
 =?utf-8?B?eUZEQnZ0QTc3dlF0MzZVZ1FQeU8weWNBTVl0bzF2cUxEQ2xRcFB0LzJoUWF0?=
 =?utf-8?B?QitKYlZhMEVOTDZRbzZROElzbVBFWmduV2lYd2FSRElYTXo0QWNCWnBBNTBz?=
 =?utf-8?B?N0tQQkZrczhnaGxPVzhCTmpYbGxuTkcwNU1JRThXUmVnYzRmeW9jcDZaZCs0?=
 =?utf-8?B?aFBNRkUwbFJNRGFhckw1anRoS2RpSHgwUjI4SEZnYWZ1R1hNWXpGdGtsZmYz?=
 =?utf-8?B?N2Y5dXZrVUZ1UVhOTnFMWU9mOEtNK3hzRDk4YmlaWVV6NkVVN0VIVk0vMWRR?=
 =?utf-8?B?dHVkUlovQkg0Z01vV2szMFlUQXp2MTgrQ0xrUVJUUTNwZXBvQSsyOWJjK3V0?=
 =?utf-8?B?b0xkVzU2N0ZaMmlCOHBSdFdVaWFWcDZvU0FnQmJ4bVFBdi9XSTIwOTBkdHNX?=
 =?utf-8?B?UHZZZkl2VjMyMEhPOFRqazkzZXRBM3ZhV0laSTlpREMyMlUzMkIrNk43Qllo?=
 =?utf-8?B?N2JhSTEwUXVUR3lDcTI4ZXFUWDlpVDJmZTVNK3hEOXM4aXVzdm1RYUZUUTM1?=
 =?utf-8?B?UWtrdXR1NHRIcGpRalRQMWlCZ2p6NkduSTBwTW54WExyZDhKS2RZSUs1NVZQ?=
 =?utf-8?B?ZEVxNzhYZ3FwRUxxU094cktjOFdIZkN2Tkx6UlIremdTdTZKM2t5bHp0aHdh?=
 =?utf-8?Q?SRRBwk0bZ0Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5JL0VsOWV3ek00cTZuc08ydklnQlA0NUZvNWxhOHZlNHVGVEU5SnFPcW4x?=
 =?utf-8?B?Sy8ya3hvKzJ4bWZNUVZrRXd2VEVjWFZzS2JzSWM3WCszMldUVGxML3oxcUhP?=
 =?utf-8?B?a2sxSW1QOEV5dTZaaWlQeTZma3lJUWVRaVVGbmNyeG5LSEMzbE5zNXRXalZH?=
 =?utf-8?B?SFloNHhtek56QnRBMEt6dVQvS1k4Q0Y2R1ZMQzBuSTdRZVdEYTQwYTVHTE5D?=
 =?utf-8?B?Sis1REhOOGRoOUwrakp5U2dFRFdNUU5MUGNBdlRYbVM1NHJOSjVPbS8xRU1i?=
 =?utf-8?B?VGFkKzdDd2dhQzhsMFJ6WVR5TWdGaXBIdHdEb0FsejZ6TUpSR05NN3h6bFpn?=
 =?utf-8?B?SzhVUzVjb3Q2YlNoMFYrZUtLSWM2bmhhOS96UitGWGlwTjhzZFlzMFRvbytN?=
 =?utf-8?B?ZHBBS200RG5mcGkxVnIwQit4TFAxWE9zdytjSUJsN1lnMVVneWViWTR1MjY0?=
 =?utf-8?B?UDRhUXdpSENWRVo0cUJvK0NrUU9rNUk4czFMcEdwL1B6Rk5sMGxaNWhTaGFR?=
 =?utf-8?B?b3Y3d093VHZ5N2hjeDhoSVlnTm1WYTc5SE9YUU52OFducitCajNxckZDTGNZ?=
 =?utf-8?B?cVBwVWZPOUd2U2N5MXlWY25VRXFzdTBKbEtPTDArQnpSclkyY2JNT2tZRTZZ?=
 =?utf-8?B?SEhRRzBrcDI3dy90dWtEMGNkSFR3aTV2anBibzV0T3cya2NpSVppbk1seUF2?=
 =?utf-8?B?SEhCb3YwTzd5clA3d29uZ24zaXk3YmZlY1JMc0tXV1RCZ2k1SEdISlczVW5r?=
 =?utf-8?B?OTVVYldITUZuejFSc3R1YWEyakVxdmw2cnVEYzBwSGZ2UkNBcENXY1NscGFV?=
 =?utf-8?B?NWhDOFA5eDBIeXpMY0dTTE9hb0tuU2dLV2xVRXZ6YUw3eUNGWGd2clRTLy9s?=
 =?utf-8?B?Y3ZDdTdQM3N6VDhObGdaaEljUiszdlJKbld3cWRPMDI2bGdpVGlUSmtkbXRD?=
 =?utf-8?B?aGc4ckREdS9wc003c29keE1STjM2cVhyMmxjeENObzJER282aUJRd0ZaaS9z?=
 =?utf-8?B?dVMxdmgzRitBUXdxRDdvaFJ6QmFVbWJaTTdJa3lIYlRQMFJjdnAzSHlKSytt?=
 =?utf-8?B?a3hvZXA0ZkUreGpBTEQxQlZlbFAyMzNmbjZNc2tmT1ZLSno2UDhVeHFJalJD?=
 =?utf-8?B?RFQ5MzBDdVBIK2dCajBvU01wajJIT3ZsY0pLb1hkWld2eW5qOE5XVnN0UGlQ?=
 =?utf-8?B?dDhTb0x3NTdpSktCOGlOcGxnaUxLMk45MkVsVE9lTFB6cjhXTU5lSExNTlRi?=
 =?utf-8?B?eis3aHBKK2dlZGpkQU5yZnJJeTFEY1VVVTM5VjBVN0U2R2ppNWtpeGc4cGli?=
 =?utf-8?B?a0NvWlBHaUh1bTBFODdVb2s3aVFBRVNVTlA5WGxJWmNiaWlnTDFWSnh4UnY1?=
 =?utf-8?B?SElQK0o0TVUvQmJPbmlXc1Z2cW1sR1hsTXN4VncxeE16SXJyay9kQXBON1NZ?=
 =?utf-8?B?QTdWY3RiclcrMzVPTmlYSVRaSUoyYVkwUmZXMlExTUVsTGdUK1dabUhDdjN3?=
 =?utf-8?B?MUZVeDBVc1lKZzZCWXRSbnFLQi9nOWNrNGNodEV2VXZSZlMvRUozR2FBLzdQ?=
 =?utf-8?B?YU1HSWhYUEYvUjJra2s2YXVwL0ljeDAwaEl3N3F3bm1nUmJEcStlS2YxZ2xv?=
 =?utf-8?B?WDAxYXR3dGx2dWlJL3EzQjd4bkJaRmhMOE4wcDFqRFYzVWpyR2JlTHY4MzNR?=
 =?utf-8?B?QzVqTk8veVYwbWUzZGVmZmVJbnYrOHl5dXFIOCtMbnJMSGhkcmRhYVg4WUxN?=
 =?utf-8?B?ZTJUcm5ickg3bXZWRklKMkhJNDErUGlZUG1sM1RKbmlXdm1zeHJ1RzRROVBC?=
 =?utf-8?B?SkxOTEgrNkNtdnhodG80S2RnM2NtQjA4ZFJpZFgrT203c1VZbm1pTkpwN3V5?=
 =?utf-8?B?WHZ1UnVmSkdvTGZXaEpEU1gxUUljUGRjdk5EMWdlU1dPbzJEVGk4aElyOWgv?=
 =?utf-8?B?WWI3ZnBFUUFBVG9lNHRsQUFzNHFTMCtnMzhkYlFlWnVkTUx1VllKZlBYRk5Q?=
 =?utf-8?B?djZNRXBjV3NrWUY4MDZlb0djVW5Fb3ErRHV4blMyOUFraUVkTldQQUtLemVG?=
 =?utf-8?B?VXVNVTJvNjNQcWRqWVZqaTZkV3hkQ3pIdjNHdXd5SnNCVy9mZ3FQanRKa3Rh?=
 =?utf-8?B?MkxFWmpYV1B3eWZRNk1vWjZCc2VCQ3ovaG1KTjVXNkZPNlYraGpUZ29mclJB?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3189955a-5e17-4a61-6bd6-08dde9779fed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:50:15.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX3OznqkmoiuDlVUOzpCllLInZSpcLPTubeioSO54FpLlMtqcy3rTjqaHyE/ITCVqY4XlatXVXQVe1W2Y0n8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com

On 01/09/2025 15:07, Adrian Hunter wrote:
> On 01/09/2025 12:40, Ben Chuang wrote:
>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
>> vendor defines its own sdhci_set_clock().
>>
>> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
>> Cc: stable@vger.kernel.org # v6.13+
>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>> ---
>>  drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>> index 0efeb9d0c376..704fdc946ac3 100644
>> --- a/drivers/mmc/host/sdhci-uhs2.c
>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>> @@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	else
>>  		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>>  
>> -	sdhci_set_clock(host, host->clock);
>> +	if (host->ops->set_clock)
>> +		host->ops->set_clock(host, host->clock);
>> +	else
>> +		sdhci_set_clock(host, host->clock);
> 
> host->ops->set_clock is not optional.  So this should just be:
> 
> 	host->ops->set_clock(host, host->clock);
> 

Although it seems we are setting the clock in 2 places:

	sdhci_uhs2_set_ios()
		sdhci_set_ios_common()
			host->ops->set_clock(host, ios->clock)
	      __sdhci_uhs2_set_ios
			sdhci_set_clock(host, host->clock)
			
Do we really need both?


