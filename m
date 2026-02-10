Return-Path: <stable+bounces-215574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNIBI2N5imlWKwAAu9opvQ
	(envelope-from <stable+bounces-215574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:18:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB4115918
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60382300C0D2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 00:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385201F8AC8;
	Tue, 10 Feb 2026 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrimHctB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9A8C1F;
	Tue, 10 Feb 2026 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770682721; cv=fail; b=RGR1eXSDvauhmRY4i5HklJzTAbDox8XqbWHefoI6fFgOnLHi2+UkJC0/LTU3QGOGXBXqgZujsO1R3b0yLlvEnGVJB4ZGGjRliRaho3tH+UotNycz+tEVv0ruNYg4Z1LNfS5ugwQW8MBnuQP4jbMDr8M+4QLZNVokMigNBiTojNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770682721; c=relaxed/simple;
	bh=4vsVGBBafdXBY5/AK+41SsyTuZPtgP66QNBl7dNrRdg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdkbS37qm1oiFmz9r7/AnW4+Qz0q5Q94ke2pRP5H88BVjQFhh+5iuU4AhSav3Nqj1+MPY9ETS+aMN01MVMpVtH5f73GVPVhPPF6dJn7nooPQv/bexKuHti2OFejxITzjp+V0WksAi4vwkF5ac/kndhw3xb5TChl1OQokuGnnUs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrimHctB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770682720; x=1802218720;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vsVGBBafdXBY5/AK+41SsyTuZPtgP66QNBl7dNrRdg=;
  b=hrimHctBXEeyQQu6wG9N/wHJ2wjCnriLWHVJlQv+uPtPsViPc04Q+QzP
   q91BfVeO5rsItqhNgXblZuL7dXsbU7vphxFqjwBAz7C1adq3AX60/eNQy
   JLT2S+B6G582NDmu0GaGIyrLbAd8uz1T9VtjO50krp1x9rJhOXlB/2JNq
   1Us/x323+ytYNprfYHdEtKbW3I0D+XRIZidUbFlsQ3e5xsQ/3wxUYVLwM
   gC3XRr7vKOPDKB1A136Z4Oll2sTWlMqJKERw3kIPEkWrcRXnraerqMjDO
   QPDnJH3Vdjcpser+WjZS8HyzAXDn7zriwEKRI6uqdZc/tY2y1qek28v7+
   Q==;
X-CSE-ConnectionGUID: ans8kuanTL+ZswAl7hIopg==
X-CSE-MsgGUID: WokcgTAESIWJ21RF+kNpgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71012943"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71012943"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 16:18:39 -0800
X-CSE-ConnectionGUID: fepiMZpVRBqP2oJeaWmO7g==
X-CSE-MsgGUID: 30JEWJ/GSAmh4pLSPLRijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242358415"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 16:18:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 16:18:38 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 16:18:38 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 16:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDRMhgi648uRXAKOPtva8Ruaa33wh+WenVjowPyIlSSl1idt/TYlFIckFg1uedn1JO9ZJqm0c7XoB1mkIUFUS19Gy8d1bKvbUim0wne9vQs/UZ4IvwQNxuApYaZOoQR67V3BiygrG4ufQnM43Kb25zo0ZcQKsJ4Vb5jUoLQ4j0xy+LNdX+6iO3SLknLzWnL5zvQGoclCacNG3wONRhD7phhMrQjjCVsj+ICSUrNOU14c7G/G9MxhuQg0Dcl1YP6uG2ccDytMb5kDqYOlE476db2M9uiQml71AyjXauqKOBwvYPy3688WN5JSAM++9fGhXF1ANichdBxZ/eNuhGCtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE/ofQu0PxadVEmx89CNS3LqwAx+AJV2e42yWmsZMS0=;
 b=aWphwGsFfuioCwi8q7Tjn0Ei7jV+m/SriKPYDEDD2qAPQpI7Vg0Ol8yj5UCxYjG3txWK11C5Nhvm1bVy94J1hyJHFAY95xbnGQYCa5ZgzyO7hRi6pW5QvNuor5BKd2d4oQqquQXIEsOJlTJjyc+J2k1jNAegr0ybWwucds7NA0dy8wip4CXThz+j6XWWE78/ZNC8/hBmoZ6IEBHV9uHfZPSrTEr/tpcPGVwq91kCRd47WX/XtBwHI3X3G2hgguN0LXSDr46+ZFj2L3CcJrVOzATtEcmivmF6QikeiLTrfY6sCl8GvcCdLxgtSoGJ2aBCx2JXX6uz42r+rzWQ1COnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 00:18:35 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 00:18:35 +0000
Message-ID: <52e152b9-c840-4480-9337-0f0aca327543@intel.com>
Date: Mon, 9 Feb 2026 16:18:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/smp: Set up exception handling before cr4_init()
From: Sohil Mehta <sohil.mehta@intel.com>
To: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <peterz@infradead.org>, <andrew.cooper3@citrix.com>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<stable@vger.kernel.org>
References: <20260206185035.1250577-1-xin@zytor.com>
 <a7be319d-381f-469d-9d5b-ddcf43d884e4@intel.com>
 <DAF4D431-5596-4FD1-BF8B-D7D753C0810C@zytor.com>
 <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
Content-Language: en-US
In-Reply-To: <37de06e1-aae4-4ebd-ac93-1846ee4cd91e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CY5PR11MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a82f369-2e3b-4181-38c5-08de6839ee1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnNCTG5sS0FrbTduOUx1MXNVeEN4T0d5aFhDTFVvQWNLUlllaTdBNXM2SjQ2?=
 =?utf-8?B?L3pYek4vekZiNWs4eWNtaTNKb0RYaGQrNnBaS01HMDRoQnRhNktqL2VwSEwx?=
 =?utf-8?B?RHJFOW9XeU5jaXJQSGZpa1poWHJYZFE2bkNranNISkRmdmkvbTNIUFRoZjN3?=
 =?utf-8?B?bWJQQXhrc3g0SHRWU0YvckY3M3FjTHhGZE9Wb2dndi9qWU5adkpVMzRjakJv?=
 =?utf-8?B?MnVkN2VkczdkeFM2NVNpclErd0NjOHNxY1NZMzlxdnZwQnlDZ1JXTXJ6amg5?=
 =?utf-8?B?YmFzRmE4eHlUSTEwVEl6RlpVeC8wSW01b0FBVUIyZDlFaE9GcnFzQUhqU3cz?=
 =?utf-8?B?ZkpCRGxpbTNiV2JiYzdHeTJZVUZ6YVorVWZuaFRMelpvS2dGckd2UlhLSkVD?=
 =?utf-8?B?ZlBxWkwwQUkvTUZPNSs2ekNQZytKNlJhT2pFa1BrRWdsUXBZTVJIQkRNVnkw?=
 =?utf-8?B?Q2w1TzZoTkJHUWhISXRTTzhpd0JSdnQwYWpRK1FCTHNWeVovaTNXR3BHbzMy?=
 =?utf-8?B?L1lMY3Rka05NeWdrS1pxb3VBejl0SU84Z1FGekhvZFE5Tys1ZEZ0Y0hjZnNa?=
 =?utf-8?B?VkpnR1l6VGdNeEVZRGFXK1lDL0swS1lEZENBTXAwakFHZnRlMG9PUENQeXF1?=
 =?utf-8?B?QTNDWi9OUGpqWWRsVk1FenBSci9TQ012RXkrdUhNeTd0dXNhYVNPVkg2cW5L?=
 =?utf-8?B?RkQwZUxvb2NvRFRnd1Y3QlJpYWt2SjVYdWt1eW5XRjdwbGcyTktqaDhjNkli?=
 =?utf-8?B?R1RkWVQ3NHpRZUpzWFR6dWkyV3k2L1BxZVdVNEJ2OG1DclNCdG8yTzJKclgy?=
 =?utf-8?B?WEJPanN6SGFwTklmdTJpeW1DaHVsNmlEVG9Ec0FIVHJEQ2tpY3o3ei9jL255?=
 =?utf-8?B?MGlXaUQwZjRkaTFGZWd0dzJjU3VSbkNiMVJ3UHc2aVIwYjRKdm50empQOUZM?=
 =?utf-8?B?T3VBZFJDUXpHM29FVDdTS0VOMFA4ZTFZbTRkeEFuZVhLN2pON3BTck1qeWto?=
 =?utf-8?B?UXY3amlUTy8yOG5Fb3IyOWRIei9nejFCbHZtUlJsUWNRZ09jOTQ4L2JIQnVn?=
 =?utf-8?B?MVk2ZlpyZDNPekk4aGh4TEJQT1JISmtoKzdBYmx1T2k5d1phNENVbmNvTFlR?=
 =?utf-8?B?YldjRTd1REVBK0V6WTJtVSthcitRakxZMFEzcVk1WUZGcVRHREZlRG9XaXRY?=
 =?utf-8?B?czJTSG9qTGliWmQ0OVN0YzZoR0FLTlNnQXBCUXZMTDFLeTdXT1RoeGNENUpJ?=
 =?utf-8?B?Y244cTArUzlkb2loaU5vKzVmWS9nMW1rcWNvZDBpN1RCcWtUeVZlOElsaCtD?=
 =?utf-8?B?azViYkdxWm9UVUFoVjViYnhTMStneHJBWkFWb1ZscVhkallPRStHc2JscWdF?=
 =?utf-8?B?T0g3a1VyaVVUbE1jd3ZLbCtHR0lHbFpFN05aejB6OXVpSU81MGlMVUFBOW9t?=
 =?utf-8?B?L0tsY3loT0lZWkVOSzV4dWtZNStjbWtWbFpUak0zZkRHVEgweHRybTgrcjVx?=
 =?utf-8?B?ZURCL3NwOThXMDhwTklEWjBFeGFOQ1YxUHVHS21wcENvYTl5aTZSbnpHOWh4?=
 =?utf-8?B?Y3BxMGt3ZklodXR5clN6OUpOTFBNOTFqME9JVm5ObG1RVDBHV0lkMzFSc1NG?=
 =?utf-8?B?SnZ5aENFKy94OHZydU1iTm9aZFZBbHBEbEhtTUhSaG11Tmw1ODUvbVVGbmpt?=
 =?utf-8?B?ZTJyVHkyTUQ1c0JGcFFiT1RPcnpTK1pGcGNwS0R6Y3V2UUNQQ0hyeHFGVG1t?=
 =?utf-8?B?K0ZHVFd6R050TXJtUkhsUkhRQnRBVkxCVVl6UXZ1aU03QTlvU2ZlQU9BSEMz?=
 =?utf-8?B?NnBUWkZEa3picklMUzFZbjRLVWxSNmJ0MGZUODExZE1oZlMvTktOeFFUbHZW?=
 =?utf-8?B?ODZtNWFTT3YvV0RCZDVFMC9BZDFSSkpnSkVBREh2a0FERWM5ck43ZHk3MEJ1?=
 =?utf-8?B?MWRvVlE4NkVrWFdPQVFQbG5RZnRybVdPLzJFaFcvdVRmcjdhMFdaMmFVUnRm?=
 =?utf-8?B?SjI3WldvTDV3UVl4NXp6dE1KR3A2dVNTU2pEa1M0QVpGdlg5MTExM0Nvc004?=
 =?utf-8?B?U0tZVTFvT2VadGdYemlDZTdzdlRxY0RzeW1uZlRaUXBOa3BvVHJudm0yeXp1?=
 =?utf-8?Q?1gPkH08Q8X7aOw7QfWxXVeZpQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUIzVWFQbHNzS1h4bFFuaFdZaVlHQlJTOW1WeUJsQTBYdGVBTHg3UHRIRjJs?=
 =?utf-8?B?TzJjYzNKa1h4QmZiVkpSaGZSaHhHWGhWTm9rUXdWR21pZjdoOGFEUkFyTmli?=
 =?utf-8?B?MmRWZElGOVlZT1pQYmZhVk1sOVZQSjBLWXFabkE0S3ZYVnh1TVZoWFZ3WHpE?=
 =?utf-8?B?MGFnTmxzOHBkSUxMQlBTYzdCYnl6OXlBa3lXWXhBdjY5VlVlWnVLeUZOUC9y?=
 =?utf-8?B?cFFXZ2l3elFXcTExQXhsS2cyRTFLaFYreXlBU25xNUN5cmtObTlGZWlVc2J0?=
 =?utf-8?B?SVBSY0JMRXMxMHcxUW04UDV2WVZDS3hMK09IcmNSSWJhYnFiMDduOVBNVHQ1?=
 =?utf-8?B?OU1EWE04Nm5ERjcxUFFSb3E4WjA3U2x2V0g3RG5lYkFDeVVwaW52bXJPd0FE?=
 =?utf-8?B?a09NUHNycmNjNWdIaXlkMlU5UVNrZ214c2pTRkxyUi9IVUM4N1lMVFBvN1Zy?=
 =?utf-8?B?aFlzbVJhM2J1Z1k5QnZUam51aVlsVGszbEdWRFZlaHJRbnZLY0JvKytmRjho?=
 =?utf-8?B?dnl4b0Y2UTc3d0ZjSU9jSGhBdnFPVFlVU2ZJUExrWFJwOXU2Nzk2cGRLZXY4?=
 =?utf-8?B?Q1RqcVRHcVZucEtzTjMwRkVnLy9yMXJBWkhQTUVmdjN5RFQrRGhPMnJyeEZZ?=
 =?utf-8?B?T1Rrbys2SE5qamw4T09CYmxlOGtYOTZ6clNaeEUwYStvK2xrekM5ZzdWV1hJ?=
 =?utf-8?B?S2VuUWhvejJyWnhZMXNtckN4SHAwVGd5T3lDTDk2bzVtQlVMUFV6cEE3TEdx?=
 =?utf-8?B?KzMxRVBnRHVCdzVMVmY4RVRWMThiak0zb1NNM0tkbXR3TGZWaUd0elIwSE1z?=
 =?utf-8?B?OXdnREI5N3BmRktJaUFWdy9vTWlqaG1DUHJLV21YZzRLMlNiTXZqYzhRNTk0?=
 =?utf-8?B?ODlSeWJqWUxFdllRSlJqREVRMUl2bVhnY0pHS2x2NUVsTHlxbEcrcXd4dXE5?=
 =?utf-8?B?M2xSVVBkbmd3MHVpTXEwVnFxdjU0MUd6T2NYOGFCdEpXOXUzand6Sm5WTm40?=
 =?utf-8?B?VHhFMFBzZXR0N2pkdk1ETjYxWlA5Y3NOUlF1SG1HRDM3OFBjY1BoRVRXVk1s?=
 =?utf-8?B?TStweTdudU5DbGRncmpnL2xyWlBrVHlPR3lMMkUwdkJJdHJqczF1eDN4WEhE?=
 =?utf-8?B?QTFFN2JOM2pRa04rVkVhRWZyem9rQUd0U2J4TGJpaE9kYzRBYkoyOVpCOFl5?=
 =?utf-8?B?Njl5K1VyS0pMRnBLN1c0eWdZUllBV3ZQbjMzREZlNCtGazAzNjE5ZTl0VEUy?=
 =?utf-8?B?OTFoRElZS3lwRzBUVE5kaysvaVdQUnFHQ2NiTzU5OUcwa1VybEpDaVpkZjFh?=
 =?utf-8?B?ZXRmTys5Y0ZZdXd0cUFNN1M0L3h6V2NiSHhKbEhySmdNZEQ2K09mQXROMHVj?=
 =?utf-8?B?Z25Qd3RuTFBrVm1zc2t6N0M5Q2NwVUt4OVBPOVdRT1BpVXFDeE11dkVnSWo3?=
 =?utf-8?B?L3BEa1F1a2VBTXg0bXlqR2dGYVplUG4wY2xseWl2ODJGbGpzWDJ1a0JNeUlK?=
 =?utf-8?B?SGpDb3JSN0hqaHcySlpWRkNDU3R0bnlqcVg0dUtpY05JUERGNVlSb0JaREh3?=
 =?utf-8?B?dVMreXhTdVdZNE4weGNSV0NSVC90di9yVFo2STVJTWtPR2wySG0wd1hvNm1t?=
 =?utf-8?B?UlZia3FvMm9ZNm5CTlNOM1AzRmJkQXl4cXRyU2xWM05mR3BMOC9hQ1pOSlRK?=
 =?utf-8?B?S0dNZkpKRVNxcFpvMVU2V2xsRkRPYStsOFczWWdrdE1Ha0VpMjdMeUpqWS9P?=
 =?utf-8?B?L3E1MkJsWlB1S3VUYlk0UDhUQ204S3ZSb2pDYWJKUTJjRDB3U28veDNlaWov?=
 =?utf-8?B?aVdUd0tmOVlOR1JrdU5vaHFQcjZvMGV1Y0l5dWF1NExWTW44MHpOY0tPQ0l6?=
 =?utf-8?B?NlBwa3lxQ3A0dWo2NXN2WGJHQXRRdThPTytHdUpPanhybjU5VEptTkNsd201?=
 =?utf-8?B?Z0x6NWJFamJKNG5lSm9VNTBVWjdjbVhZbnRtblNzL2FYKzFVWkhYUUJnRFVh?=
 =?utf-8?B?anlUemlhUk9iVTJscEdSZmFYUUllOGVaa3hwaW1IOXVvZUNmNmFpYkJZWmZp?=
 =?utf-8?B?N3RqZWF5TG0raUQwTnZNSDBaVzR3QWpJcTVwUmxrYXlZWVZNVmJPVGRBbEhW?=
 =?utf-8?B?ZzJhR0xJUUJpWGQ2anRUcXNzN2RjZzYzYkRwYXZIK1MvZjNBNGZTeFU5VHM3?=
 =?utf-8?B?R0Nua3k3R0xSVFB3TG43dkFmSk5ITUJqVnZPSEZwSkRQUElkZFl4UlFBVkVx?=
 =?utf-8?B?dXZoS1ZjeGE4MmZOMXRKVE03R0hwbUpER25xMXI1cWVoaWk1Sjk0ZUhOY1lh?=
 =?utf-8?B?d3FUM2RhbGhGQ3h2RUZPWEsvS0E4NitzaUtuK0FXdVdRT2hSMHhMUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a82f369-2e3b-4181-38c5-08de6839ee1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 00:18:35.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HOjXJWb7u2nDf5BfRP4RpH7W5nq/2qBgMutc4CCC6KVzkyOzcsegDQFyqPwSw1sEWpBbvzCErq7I0m6EhKhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215574-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 1BCB4115918
X-Rspamd-Action: no action

On 2/8/2026 11:28 PM, Sohil Mehta wrote:
> I think Dave already posted the patch for it here.
> https://lore.kernel.org/lkml/02df7890-83c2-4047-8c88-46fbc6e0a892@intel.com/
> 
> I will test that out to confirm that it doesn't mess up some implicit
> behavior.
> 

I verified that the above patch works as expected. I added a debug print
in cpu_init_fred_exceptions() to test FRED behavior.

	if (cr4_read_shadow() & X86_CR4_FRED)
		pr_warn("FRED is already enabled on CPU%d\n",
			smp_processor_id());


With Dave's patch, the warning no longer shows up on APs.

However, I found another location where we enable FRED in CR4 before
enabling the MSRs.

__restore_processor_state():

...

  __write_cr4(ctxt->cr4);

...

  if (ctxt->cr4 & X86_CR4_FRED) {
    cpu_init_fred_exceptions();
    cpu_init_fred_rsps();
  }

Due to limitations of my test platform, I couldn't verify the FRED print
in __restore_processor_state()'s path. But, could "restore" run into a
similar issue in the future?

