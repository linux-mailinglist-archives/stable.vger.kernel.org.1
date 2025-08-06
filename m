Return-Path: <stable+bounces-166748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D76B1CF67
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 01:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD373AC6E7
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CC27702C;
	Wed,  6 Aug 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7Y6pxEy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D34238C19;
	Wed,  6 Aug 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523120; cv=fail; b=jvG9FKMyJhjhwLhi/grkE7Rp9nDx5gtwAhRNx5cvfU0rVEkcyD9ISp65wgAfeExpX/4iae5iAL+w4iwRN/8I7Ql1md3GCSu9ASaLyjRzXgClcsr9x/A+6oGx2TSeBV1xi9ohsDMvLJQqHYlExmsNYgAjmUBzvQ/8mrkz2FYHsIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523120; c=relaxed/simple;
	bh=tb4nYAEWH03lUzTaoTrsKhRwxls6gJhXOtrgVJhh3Tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lt/v7+FREXgOOSEkbKzH++rXQ2wxifjL4Gr3l8YQAWvEEI6kov7QMUQd0wcYEElK4Tac4Oi8mtZ6H4CXkGM8QlJSbevdDV3qqjN4dznXT28vT9/20ARmB7+hjxTcc3NLjYHYZ8jZuV0zM4Dt0qjNmZoKqdGwIoccsBJuEBjwywU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7Y6pxEy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754523119; x=1786059119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tb4nYAEWH03lUzTaoTrsKhRwxls6gJhXOtrgVJhh3Tg=;
  b=m7Y6pxEycGvdoJzQQMT449szBnADtqL4z/pwf97p4MIlbl55AKZqlDhR
   uG/we56468xCqlq8wjYF/Z+qjIz5IWoli6Yy6xNQxLqOnmCua9gF+6LUh
   yp2lZhbng3GoPJd38lPL7+lPfuhk3/h3kC2w3GeZDWZYSWOmTsupbMG9B
   sGZSpJ72u9YEcS5jJCKFr0nQCbPDtQ6jvRRu2rfHyxAy5dT3H2OKqaIBe
   0nyU5Orfbkeu7HbyobqIF4+BCuvmfqg9QcNPpXEYfUHVg2a24tLiSDnAJ
   t7XyXc6XoLTJwt8Z3psKvUmcAmbZis/w3nzs3BZVdtRgOZ0QGOMas7qi3
   Q==;
X-CSE-ConnectionGUID: pJbg0+blRj6pbi0nTHRiyw==
X-CSE-MsgGUID: AgXeV0IqRIq2HYLDwIAHqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60690792"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60690792"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 16:31:58 -0700
X-CSE-ConnectionGUID: 60M4Bk3WTFqTSqay8ixtpg==
X-CSE-MsgGUID: 6FHbsb3FQ9SXTRGOT9s4rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165700141"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 16:31:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 16:31:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 16:31:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 16:31:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwy3rFDHUm6fV6N5ubVfqC9fgyar/caq1dfTuW7U6OPvjRHTLIOLvPpRAHQjuFugLxRqatlMWJ8CX2gNBmJT2Qq2CchpDgoaFb2jp9FGO+Ovpr9PlNMCKCD6UIkda8VaPKbYoFHideyR3LCFTDtUcvGO4Y21I9OXAqt46A8cVsvE/R2IXeR5yppXH3yqlAptuWfHbO7VTTAgbwkExnTXYpe88q5G3TWTJzVRjkB5PMuPzANYKRHB0fTJHyZYo+yCPkCGRdDWnPbd4jgEIrwv42OTq/EVPYG9cxgAPOGzcTcvKPfx25Z1PH6ktYTY2cfFWzZzwHXC0qgs420WGDqDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tUgp7PICNKFRL2TbCFm7RHssfJUirqLKaEJvsSAxb4=;
 b=OJuLkVUEV92FbC8mcuNXmAQPlIPQN+zswyUFkO83TUxNxcXofktAzsVMfgO2atcHnPuLYmJ8vWgljBjqtAEkos5xn+Y9tOoPoU6U+2qHZ0sWEKKu1vCXRB+2lqusFUjVyxIY/4TgygJKXSfQkcTU0ZZ2xuBRZDxMS47VcYhjCCbJOK+MWnExLP34vk1MraPuJ1+StzLr77BRLDicGqGu/2tXHmHUN/gfgiFNsByInWQCX8xvS3iknpbG1Zv5Uq0S3kR2iOPRdk63NjJZKcolOrDxYao0FmKH6oJ12EUFbuVyJ2ULk1+JFiqAh3fNrqNram3cEE/FNk3aVOoOn8iWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA4PR11MB9035.namprd11.prod.outlook.com (2603:10b6:208:55e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 23:31:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 23:31:55 +0000
Message-ID: <f8f1faa6-d35d-439f-b5c3-2c20f2e2bb8d@intel.com>
Date: Wed, 6 Aug 2025 16:31:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <darwi@linutronix.de>, <peterz@infradead.org>,
	<ravi.bangoria@amd.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250806153433.9070-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250806153433.9070-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA4PR11MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d40aff-3d52-4af0-7790-08ddd5416e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTBPOURhQ1NaU3BjaG9ieHhkZytNaityVEc1OWNTanJYNkkrY2ZKU3EyTVRM?=
 =?utf-8?B?T0lYNUZGSDV3NHNmQ2pxN3FMNjF4SVpERjJCVjhYejliNHIwRS8rcVhiVEgy?=
 =?utf-8?B?WVYvOG1FT2ZORjJPZC9WVEJqanMxR1BvRlFZTDhGbW9FT3B2RG1PM1lsL0FI?=
 =?utf-8?B?NEJCeSsxM1R3T2dpMUgzMVkwLzc4K25pdUg4a1c4cmNJd1d4V0k3TGNUbUVq?=
 =?utf-8?B?NzIvMVAzeUIrQVM0eUpaZzk0TkdhdFgvTlJJclZJeHNGcE1RTktweFVvSlVL?=
 =?utf-8?B?VmRSWjMyNnVNMzBWSHRhRHhoZ01kd0xkVWZlUzFST0V3cy9WR01OQ0FrcEJ3?=
 =?utf-8?B?NERMZ3ptNC9icy9TL1pFWTBQc3JhQWlmSDl5UGhtT0xyNG0vOXJOMDRVdzBD?=
 =?utf-8?B?bDV1MkQyNlllVEhpY1BWc0J1cmxDUmFpVjRjdkR4UmsrcWsrSWRHWjh6WE93?=
 =?utf-8?B?S0RJYUxzUURxTlp4Q0tnUHF3a1B4NVM4NFNxcmJrcjVQNDlqOGhtSkNJcTNV?=
 =?utf-8?B?S2ZPZ3FSeG9uZEVWakhZZFNFdEhmcXduSzhWWU9CMWRGSUNNejVZd1pkZUJp?=
 =?utf-8?B?VExPYUhXUlpWbGIyV2NFRlB5YWFZRFpOMkhZR3ltTnRySjE3Tnh1b2pmem4v?=
 =?utf-8?B?dlAyUTBSUzJILy9hTWhuYXpHRUdhL0JUUVpzRlRFUVRtZFdxVzJuanhqRk1K?=
 =?utf-8?B?OVhIZXNsWXgvdW9HUThzZFNaRVNINGlybXJYODd0OXh4eEhodStsK1g4YWtz?=
 =?utf-8?B?VklxL21yQWNSc2dLZWpUQ2JGSmhXdEtZalhOdDlRVHN5YWtER2hsekt1MHFl?=
 =?utf-8?B?czIyQjFkMzZNdEc0VWQrTzd2KzVCRVYzM3YwNkRiQ0FPMVUvUVdsZjVWbTI3?=
 =?utf-8?B?cHFwSHNDMUJBN2N1eFdPT0dMTXY4dldDVGZ6MjJDdW9nZXBPcDJPUmtQU3V5?=
 =?utf-8?B?NG80QkJqR2YyVHRwUE9HNE04NExOLzM1ajBaRFg4K3RFNXJtTTdrckpUMDRQ?=
 =?utf-8?B?QWY4bFpPMVRvUlkvKzhLc0JQSVZUNUZmc0pMM29qRnNEN05JSVdxbXBWQkFl?=
 =?utf-8?B?YjdYbEcwcFRETTRyRzBVaFNpY1RQUjBHZU9UN3Nob082YWp5TkV2aS9iWWdx?=
 =?utf-8?B?WUVmS2xwbktTOTlHU3cxSWExb056emw2dWQzMEN3dngreEp6cXJJa0dMVVJ6?=
 =?utf-8?B?UE1RUHQwWHRWYk9LRCtPdHZxZWppN1M0VERHaGU3S0N1L21YQ3VtVjNYS1RM?=
 =?utf-8?B?Sk1KUkdicGxYdG5mUExEenkrQVMvUzh2VkQ3bVR6R1hnb3FGa0FQL3o3dlB2?=
 =?utf-8?B?eWpTYmpjMlRaOSsxVHd2RFRtZjk4d252OGl1WVVMcHQ0OUFpOTZHWlFhODZo?=
 =?utf-8?B?cEYxcEd0TWxCZmlJQjk2anJsVTNubjF3anZRc3ZHSFlEcllDdTBXMytiNVZR?=
 =?utf-8?B?bnY4aXg0Vm5DQVM5TjRPT01kM05iTjZLeVM0clQ1dDBTOHc1cTV4cmN5NzRT?=
 =?utf-8?B?dUcxZlFWTUlVVjlHQzMvWXRWTG81NHEvUTlwdmRZRVBRYjhQWmRoUmZjZmxo?=
 =?utf-8?B?ZitKYTZIR3hlZXdSZVpTaFNHeWQ0TlpnTnVKeTJBN1RhVno1aVYrRjllN3Rn?=
 =?utf-8?B?NlJZWWdveHk1OTdhaVJzd2FJbWxvWStmZWpQc2JrZFBsMkttb0wxWDhnRGVy?=
 =?utf-8?B?OWh1MmtkcStIbm4vTHRIZDA1NldHK2ZYMUI3cjczMmdPOURkdDh2cTB0VnJa?=
 =?utf-8?B?Y3hiSEhLU205VjEyVnJQazVxZ3ZGaEM3V3h1TUNUakkvdlhEYi9LZUZPaGdo?=
 =?utf-8?B?aXo2ejR6NVlOV1NWRVZmbTN3MldVQUpCM2FzK1dHMzV4blpRREQ2aGxBbXBY?=
 =?utf-8?B?eG5nRlVoZGxCLzJ6Z0w4a0VlNEJsWC9GOG9ZVjZKU3BVbjRpamlpSlJYcnZN?=
 =?utf-8?Q?n5TQXx0iO1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tKL2VqUnc3alNHQVZINERNbDRaajZFMkJMalBnTnZITWtxNUJodE9BR2ZT?=
 =?utf-8?B?R3JGOFdGQWFHNHNlTGpsQlE4TjRaTTBIc0NUNWJBZVQrOGU5ZDFUL1VVSENo?=
 =?utf-8?B?YS9JN2hiUFNGYjRtWkJjUXl2RFg1WVJLbHJHRmhJV1dCbmgzT21laTNEa21t?=
 =?utf-8?B?SlhKQ2NQME9tUnBMeWJqTjNFNE50WWFwMTFpOE1jOHNxckFCTFRobVMzaEZo?=
 =?utf-8?B?cTA5V09mUU1QU1daUHhBb1ZlYkp3VmIvdzBqYlgwMkEwYy8rRWh4UkRBNDhr?=
 =?utf-8?B?UVpGRzFXdDNBdjNFVDFIN3hJZVhSaTVQa0ZKY29BUEZhSDFmbmd5eE9xUUQv?=
 =?utf-8?B?eGJZUGFOTERFak1IcTQ1alZaYWlONE05eHZCZE1SZ1FvQ3F5MFFYa0wraEFk?=
 =?utf-8?B?R1FCMGdHeUJIVXR6bG9NVURNM2J3cnREaG5yanBPMHBzNEZYLzlBZjJqL2Jn?=
 =?utf-8?B?YytReEF6d1V0REdQUmdUVTRBUUhZSHpheEswZzZvdzNlRGhvUEY0bnZFeUJp?=
 =?utf-8?B?elQ5T1poYm1UQm52Y2xRUktuUmljZ1dNY0w2aVV4Y3Z1bk1sNzVxUCs3aFhn?=
 =?utf-8?B?aEJxeVFuWCt0ZWY4OXd3NmVoZW5rN1c3aGJ6dWlZQndVbGlTU3ZESllhWDF2?=
 =?utf-8?B?Vkd0WklEN2l6TnVaNGZJcFlIN1pkSTVHeG5sOG5FYTh4MTZJTnRHT3o3THVM?=
 =?utf-8?B?WTc4T3Vyc1RJbmVCMUFxWXFuN0xtZm1lMEpUa0d3VEp2eEFIRTdrL0dPZ096?=
 =?utf-8?B?S28xY3FiNml4WVY2YnU4S1FwK1dNL3J1cDYzMFNTZ3VNYnFvRWhEbDBGN0pE?=
 =?utf-8?B?UlBmTXNPdzJtdUx3OEg2OWsyN2l5VzF2N0tkdmRTaXNVY2c0T3c5bmdLVXZE?=
 =?utf-8?B?MHZua3QvUGFUdm5Xc2xCZGRSOTEvRE1DWlNxRDZmMEl5dTdnSWFrcnVjTnox?=
 =?utf-8?B?eE02RStsWWJDK1RDMGlCNGVRcVNLTDNETU1YOGdFNEg3ZHk3dURyUUQ2UXNS?=
 =?utf-8?B?eTZ5cC9xSWdlRE96Tk1sTWxuVTA4RVRtZDhFYnl4VWRETVNvMVdQT3orYmVI?=
 =?utf-8?B?ZVdscGwvaWdENnpsSXR6Z2FQTWEyaFRmL2p4c2h1VzB0OXFoQlVjWGdLaEs2?=
 =?utf-8?B?UXM2WmYycGJLQ2h5ZWswNjZZcHhEcUl4UW1DQmJCb0U0SVlGNEZhRXNOcG04?=
 =?utf-8?B?UmJtUi9CMS8zUUNHdGtGQmxmVDFLK1VSZnZhUW5pVjJSMHIxNXhYQWk3blFi?=
 =?utf-8?B?eE4zeEltTlg5Y3lrU0QrN1pwdlFtQ2NqNy9pVHBtVERwTmkxS0lUREFpQ3VS?=
 =?utf-8?B?YlVnVGcrSnkyenB2MVpEQ3RzYXhScE1tWjNZK0x6aHlnMzZCSU1pV0QvS3p2?=
 =?utf-8?B?SGVLTlJjVHI2Z2lDeVhKL3MzT1hXRkp2emNMdjlxZ1JSN09JbjVhQ2VUeXc5?=
 =?utf-8?B?R2YyR1RadE1EUEJDR1E0Y05SU2JjOGtUTEdXaUV4a0x0cUJ3dFR1bTBSaXhO?=
 =?utf-8?B?QVJRbFJPZlhFQVJYQWVGTVA2c2JBR3pNN294Nk1kTW1qRGx4cnBBQTYzckJF?=
 =?utf-8?B?Mlh1T3ZicnhOMmo0dkR2R0tvWG44eHR3YmdxeWI2dC80a1Jwckg3cWpIcUs2?=
 =?utf-8?B?QmxUZVNYYktxRkpqeEI3WWdMdytFdGRZU3VhaCt5MkgyTSs5dmNSd01uR0RZ?=
 =?utf-8?B?L1d5ekFkQ25KMW1FdFBHalNpWTFtQzdEamdTZWxFdktMeFVUZFhPcW9hbC9G?=
 =?utf-8?B?Z1E5L0xNd1RiUEt6SXpPZ1V1S3dhYW9DLzdRWWhxblI5TTBjRjA1OWlVaW5B?=
 =?utf-8?B?eG9OdnZrZC9vL2RsU2Z3WTU3dXdOcFMvZWJ5OGZ2L2ZyM1lNZ2FsMHppVGRj?=
 =?utf-8?B?c0hBOUQzN2pvUGprMElaYWdTTDJUUWtib09IRXVDbEZuVnZHRlgxL3JuMHdz?=
 =?utf-8?B?RWtmR0ZvMWRHQXdiS25qN2ZYWGxVVEVqZElzTi9KUWxsb2RDV0FLSDFIMVQr?=
 =?utf-8?B?YTVud3IxNEpEMld6UlJhVHg3RTBDNFBvTzNSNW55aVIweVRLSzNFcmZwQU5D?=
 =?utf-8?B?UDJ3Tlc3N3A3WjFjbE1iQUxybEJnaDgrRjVHYnVvakVSTzkyK2g3d3BaMmxh?=
 =?utf-8?Q?rTvdH4eP92IH0yTCBUogb5CVl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d40aff-3d52-4af0-7790-08ddd5416e29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 23:31:55.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlRwIgvPpPijLbM+K5LKYJem/39fqbuBFvjgVeW3tAcx5ehLgBqJpgaZENghnGhs/MKZa9r6jmAbgrvS/VE9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9035
X-OriginatorOrg: intel.com

On 8/6/2025 8:34 AM, Suchit Karunakaran wrote:
> Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
> a constant TSC. This was correctly captured until commit fadb6f569b10
> ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").
> 
> In that commit, an error was introduced while selecting the last P4
> model (0x06) as the upper bound. Model 0x06 was transposed to
> INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> simple typo, probably just copying and pasting the wrong P4 model.
> 
> Fix the constant TSC logic to cover all later P4 models. End at
> INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.
> 
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> Cc: <stable@vger.kernel.org> # v6.15
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---


Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

