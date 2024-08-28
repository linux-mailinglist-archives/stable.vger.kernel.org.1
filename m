Return-Path: <stable+bounces-71352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F900961B27
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 02:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E391C22A1B
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 00:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05817991;
	Wed, 28 Aug 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BATBkOCq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A914287;
	Wed, 28 Aug 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805893; cv=fail; b=QbU/VXaOlEUJLVSN/6LPGlrWZ5sLMBJ0VoNPLTQ3ZkS4BGkF1pstAS8hvcGRlgDmY5DN7U2mvu7uy3z9dofoQ1Bk7r3Vqxty1HSv0YEpb3/x9FGMXeB8qyhe6R1TS8unkTqqMsvW90I+D4ytNogffGj7TwBi9g8QMM6X4LmUd/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805893; c=relaxed/simple;
	bh=WW0X/c+SOvIvtOwP0V9+UyhA3LeSn8Anb1xsy6Ljq0Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hT/l9eJ9ZCuq4y9TyNxe6NTpGVA9ahGoISpi3MGBekNxsDfx/zCeSt7Ic7bW10jBjvxJVZbwu+0/WHjBhqFiiA/HWG6HGh/d9dywImrRTZMOUnSOMmM5g4c/JsgRSoNC4W2LclH0P8ufcsrLtXZlrB0Lrzd3ClftdM3xvXiAL6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BATBkOCq; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724805891; x=1756341891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WW0X/c+SOvIvtOwP0V9+UyhA3LeSn8Anb1xsy6Ljq0Q=;
  b=BATBkOCqlcEY/0JWhrRATx5r7dAlo/mNKTWW5uxOTdAUZQ/OpgnqEx63
   Sr8SwHc3/5i5wQvSUNOyllFkj8QEPr3ZWvC4ES1kvNhgj1/XjdFgnKygR
   xVGfYSNtzwIp2gBk7HYK3QrwryvhFDQmwAiQoP/wH8wFBSLeAKjjb2Zj/
   RjcYc664IO+X8TqeNitMbLlJ2PXzva91Q8Kpb1zqdBgMM+qVkH3E5qEN1
   HVgFUbM186nM7ibjLtQr5PQ12wvnELf6coBI9AfT1XXJ3+2KOxPlUKUEZ
   rnSPlrd+BEigYQPL3FPkgbirSbTqgLyV7G5gkt1BfaApjboWXh57K6Vhi
   Q==;
X-CSE-ConnectionGUID: q5UMpx+ARIW+YsprpM0+zQ==
X-CSE-MsgGUID: S6b0E9qaRdOcfGK4wG37Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23189698"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23189698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 17:44:50 -0700
X-CSE-ConnectionGUID: CgfEYm2oQqu4+BqB87IgUA==
X-CSE-MsgGUID: /GUA/V0iT+aJtq0EGzME8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63756548"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 17:44:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 17:44:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 17:44:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 17:44:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 17:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVbrj7n+HDMwBduwamZgw7IRpYwwuNy1EkOgA+S1ez8QlpKr1YzlYG+b0chGM+RS+l27ofcyT5nZAXNhQZOzgb0JJcw3Pdjdocwn51z1HkjYnPxKiLnZo8XEJAZ3yndxZa2jP4+kgvqqnLt9sYR6d+bQe7uwlpcSf56DMLK6nFE/V7RNAdb0V7eK9g9K98HlDgHYBwN/6hkiPum7+5vn5C5CnWwhbsxdDe9oLHs5BLDaTflFVoqgckodcY5hu2vsHbLoClunFbHJRMl/6p17vJ00AoF4RYuEypkCKHhVbkfAUbG654Z/ZTPJcE4NECx1JqRW6Ut6y1bl8YzqawsqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ms8lX6y7sDxVtVG8Alv771f/ft7a1MKf/ord2jkNZo=;
 b=iUyG9AQ6MCUKpJ2XLpqRSoQfC6XgCAhlTZ6JcqrvoPZGeP7F/72mSmJfPfJssPE/vrzTgFOq48OHq5dBc8cHHXT2nrzY7zZzYWC2rtkgPOgRcJkXZZTrX9LeTHB/0D+KZk5PuUflgikNM9nWTUt8sv0XiX0pRJnfFMBI14341chWfzLE79HKNZylfGRxglS2jRYs+BQZsY1iEBeM6ocov8iYvFnQdONi+fMwzrtYPTHCYf6gKQUOyJEpiEUFdigZXlz/Aw+LscNEVJ9zVZlSlG1Wr1iTMh71HhbxjljVbcHY3FjS0qhr9RrIblOfYYV77lJ14JmSo+hgluBLfqgPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 00:44:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 00:44:42 +0000
Message-ID: <17ee53d0-37ce-48d7-a9e7-ee3ca83ddfb1@intel.com>
Date: Wed, 28 Aug 2024 12:44:33 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5, REBASED 3/4] x86/tdx: Dynamically disable SEPT
 violations from causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
 <20240809130923.3893765-4-kirill.shutemov@linux.intel.com>
 <92fcceab-908f-4bfe-811d-694104d4dfa5@intel.com>
 <fs4n5t3ylzhboxcdrnuhlm6rdsprt7xaeeoae3cbyapw6y4cha@kqm5cwjavs3n>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <fs4n5t3ylzhboxcdrnuhlm6rdsprt7xaeeoae3cbyapw6y4cha@kqm5cwjavs3n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DS7PR11MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e854051-ce6d-47da-8456-08dcc6fa9a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUJMSXBwTkh1NXJmUEc1UTFjTHliR3VIUTdkczhoRjZYUHQyVlNkUWorYS9z?=
 =?utf-8?B?SlBBb1FsWkZkcENwTmJIbTM1dU43VjRrbmJiTlBOekl0dkhRaEZxdTlncnVa?=
 =?utf-8?B?UHdVV2FYdVpMUFNGZk80aGpOd0crdGo5RnBVZXJ5cGhXaVRJTmU5TFluOWlE?=
 =?utf-8?B?SG1vUjJEUFlwb1U5MnJxNWt1azBwa2Ixdk1SWVBGSkt5bE5WeGg2emF6cmVl?=
 =?utf-8?B?NG9sT0xCU3pRSGpldUc1RjhpMWhlYUpJbjEyNnZwbzFsOUJCd1lVZmFSSUhR?=
 =?utf-8?B?ZWIwQzBsYkc4YkwxeUlTUDdFZTJONmtSaHo5dFdVcm9kbDhPb2pjdTNNNnVB?=
 =?utf-8?B?MkdvTkR2VTdqQVpCWkFsSHFmQnFpRWlyeTNJbjRkbmlqNm9IVzBVbUNza3Np?=
 =?utf-8?B?akRob1VsNDNqa21tVUlTckpRQTZ6cnBzb2svZXlrUG1JWms2dUZpTVZ3Wldm?=
 =?utf-8?B?NWJ5Zzk3cnlaZzEyb2tuR1V5OVpwVFZJQVpaZU11THE2Nlh5UTd5VU5tc2dJ?=
 =?utf-8?B?ck5tUHEweEtyUUdkN2w1dTlXR01PbVFEZUZOVWFIcVJ6TEVYNlhKdVZPcUNE?=
 =?utf-8?B?bVpNbGx1YTJxYzMxNXYxZXlqc3BuU0pXZ1lVUzFBOWpEOVYwRjk5cEZpbmNL?=
 =?utf-8?B?dUFqbkwyVDNlNlJQMGl3Z25vVkhLZkFFTy81RlNiMEFudlRWK29ncm5tUnJK?=
 =?utf-8?B?L2xweEtPYTdWRXl1ZE5IUjVCMWNnSTRQK2loekNKamZzZ2ZxOWVhNWNaeVJP?=
 =?utf-8?B?TzdtbGE3R0hFWDAwc2tpYitCbU9tU3FkdzlQR1J4aHhKeVdVRFhmSnhzM2Ux?=
 =?utf-8?B?bVp5d0lQRXZQV1hJWUg1bW1nMHN6dGk3QXNaSVZRNk53NDYwUDFGaWJPNm9Z?=
 =?utf-8?B?cTR2RWdlS3dOUnk3Vjk1UFdDdEEzTktaMFF0bzBwbFQ5NXE1bUNOdmZGdUlo?=
 =?utf-8?B?RHdiQXMxUTBhVktnQ1E5elBHTmJmVUpEdncrZ0dYV2ZlUjZHUjVRR2dMVWJY?=
 =?utf-8?B?RUpldjBLbTRXeDBYNVV1cUZrRC92d09tNDR0eHlkS2UyQ0FQYkZVNDg4VEtW?=
 =?utf-8?B?V05aVU9kRytTTzJSZGJIdVhVMzZZOUhtd0puZFBXTzNRd1R5Mk52ait6Y0d1?=
 =?utf-8?B?cTFxdlB5bkdGOTRUQjFIMFU3MEdycFh6eFV0OU9ucmtsWUIwb2JDRlBCczIv?=
 =?utf-8?B?cHhhTmJLWGtodnEvRWExd05MRW51bDd5TnF0Y2t2aXU0dmNCZnpyTFl0eFg4?=
 =?utf-8?B?ZTJYa1A3d0d6b2duOFlLdXVvZXE3V3cxVEJPaHRhM21DckR0NmV3NzJLQlR0?=
 =?utf-8?B?T0lKdkhxYVVvc3FGREEvd0pPYmZBVnpSMm4wME15Uzg3MjI2UG41ODhWTENl?=
 =?utf-8?B?dXovZHdETWdQVHdCRFVUTGZRZU1MWlBYY0cyUVJBVGhHZW9uNG55a09adjRz?=
 =?utf-8?B?SmV5eTRyODcvazd3OWtZYzd1aExWc1VrN1ptMlJxT1pHWkRsZjd3UXZZODFa?=
 =?utf-8?B?NGROZ2FCc09zTXcxbEhzYmg3eVRBSDFxZWwydXVFRk43c3oyakxjMmNjVncr?=
 =?utf-8?B?NjFMeFhscGZNRkJMaCtLd04rbFMxT0dsc1dJaVdSN0t0TWdiTTZNWDNqNVl4?=
 =?utf-8?B?Rkg2SEs0MDdxc1RWU0RSUmtvZnFDNUdkMUp2dkRubTdYRmdXeGdQTERpUzlX?=
 =?utf-8?B?ZnJzZEROWHFVQyt3Nk4wZnlpS21YWjhaa1N4djZtQ1Z2dDVjYWFsYUQwTzVv?=
 =?utf-8?B?MVFqRWxZTEZaN0ZmdC9CUHk1VzQ5ak1ScHlyZTQycEpGY3BndUZtU0hDZXMv?=
 =?utf-8?B?QVVYMTBMcGFlSndXTUtIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTljaEhHVTNrdnpNbndXejdJVWZJSTdycDZtV29wR3dMQmtWVWVwWmlXWHFB?=
 =?utf-8?B?NlFraEc3cHN5cUgzVXJ0KzlGZ1U4MkZ1QklkY05KOU9ZUTFqaWZLeXppWHNu?=
 =?utf-8?B?QkVnUDRPUEpjUGJoVUE1aDFaMFF6LzN2aFlpbzVLN3htNEdWZnVKN1pjL3FN?=
 =?utf-8?B?SmdkSDVCbytNV2lCeEljbHIxVjZaRXcwN3B1ZjdqWFdPSVMvUit4K3BvSU1q?=
 =?utf-8?B?YzRPcDU2T1FoY1B2R1pENWJkd3RkeS9wY1o5eUJUbUdSeDMrcldxQ25mbHFx?=
 =?utf-8?B?b2pCd1NlYjdOVjc0N3pYTEtMOWh3bFZmb2tETmYwbk1aN084cXdobkRkdTdh?=
 =?utf-8?B?dTdGQ21BT1hJNi9IdUptalB3b2huczFKRkszWTVUMWNEWm4vSWtOWHFKSzlj?=
 =?utf-8?B?T1Y5ZStRWkkrYzRLdlJVdmFiTXcrVHV2MlZzQ3IvZlRiZkQ3U29iNjRrc1c0?=
 =?utf-8?B?Z2ZNcmRsOHRlYytoOWJ1NGpDYWZuOEpMdjFNZ3dnVndaOTU1UWNiSE43bGxD?=
 =?utf-8?B?WDJhRUh5Vkhnd3U2RERSaDYvVmx2ZlQrMWZhZzUzNlc2WTNkR0oyaWR4cnl5?=
 =?utf-8?B?cTBLMnkxL3NGbGwyNHMyc1FoTmdBWEpVSHNlMDFHRUE0YVlmUS9oSlZYdUlV?=
 =?utf-8?B?MUtodFdYVU1uWEYzNDNldnNFYm9RVTFqMEFiUXp3NzlDUnBETXVMTnk3VGM2?=
 =?utf-8?B?b3ptRTVSTmh6VGp4cVhacC9zK3I3eVowUkJBWWZxaEtsUk1ZdHpXamFKa2ND?=
 =?utf-8?B?RTBEOUpGS2dFc01UWithMWE3RnlTVU1ReFJMQ1hkSXBrT1ZZc2VaS1o5Qllz?=
 =?utf-8?B?Q3hUYllSUXFGMWxuZkx1Q3BINGxNV2w1NkdoTHFYaCtwZ0FsOTNGdXdSUDN3?=
 =?utf-8?B?ajhkOUZMeTVrSFhhN3NnYmpRT3p2TjgvTFpWek00Rjc0WHRVcTNRbzh0ekRL?=
 =?utf-8?B?THBZQlBHSGpRczRiVWF0d0MvWFJrT0Voa2dRVlE1UjB6ZEhWU2R1eEVGMGdB?=
 =?utf-8?B?eXQyekhzcTY2OW1DcGN6V0Eza3RjWWtlejVvSDd3R0dvSDR4cm5nVTJ5QUpH?=
 =?utf-8?B?QkhBOUJZWWxndytDWndUSzROTFNFTm9mVXZXak41WnpIZWI3TDBlbmxtb1RU?=
 =?utf-8?B?TVZlU2lkVE1DZTZoSXlNallvNDlUUk1pYVZJQkRQM2t4NC8xUHlidklhNDEx?=
 =?utf-8?B?L3MxYVk3a1RyL1g4b3R3TFV5ODFKa0hXQnRJYjJ1UDZ3TW1YemxGM1QvSVR2?=
 =?utf-8?B?YXFnQXlvTEVlbUgwYjRlVDVhR3VJYnZ0aW1jZlFHaUdXOUcrWHVHMUZEOTFC?=
 =?utf-8?B?czJ4eG11RkRKZU9XRnlMMGY2QXc2SWd1VW13THlENDVROEh5c0F5OTJkWlZv?=
 =?utf-8?B?ZVkwUWxCK0RyNnRVVmFLWVU3QkM5Mmxjd3NjWWNpUUtzaE41eUtudk9Lektn?=
 =?utf-8?B?UlNYb1ZJd0JMd3owTm1sRzc0UWM3dCswWWRoNDFMckVZVnFPY1hUbmQ1cTQv?=
 =?utf-8?B?d3RyV3NoaU1ZRG9GZEU5amlNTnVKeDkrNzdUQSttUzNtTHpRTUtwUDNGdnFN?=
 =?utf-8?B?OVUzbUREYjNVNVlpRkxXc1lMN2FXUGlRV2pWelYrM2xuN2dSQnlpalVLM1dP?=
 =?utf-8?B?cWFMdHc1NG1INmZyeUF3ZkFwSjhoRWpOb3dpTzFkaS9NQldmUlFwN1V4R3Rp?=
 =?utf-8?B?K1YreklBbUVkM3FkeWVsdlp5RzFwZnZUQ2Z2eWFlZGN1cWhTY2pXZFJyQmxz?=
 =?utf-8?B?NXNaeWVMUjN2a3lEeXlZLzdRSHBwSWRvME5DYTNvM245eFU1RXhpZytBMDM4?=
 =?utf-8?B?eHJvTkpyNkkyaUM3SkQzRmlUaHJNU0NOWTQrRUQxbW1uR2VPSmhTV3JtbFhs?=
 =?utf-8?B?N0h6NFJ0YmVOeGNyS1FDQ2FRNWNFVW43MHZTOXN2NEVoTkJEMGVDNEdOT3JV?=
 =?utf-8?B?R2V5NkJHNHpHQmtLUzF3VHNDbVQyaGlLSGN3a0tRYVZJa3FrNDNOL3BUTElv?=
 =?utf-8?B?eHVJa1FjUm9wUTMvY2lOK0RvcHVqbjFvOTZqbzFTV0gyV29wZXh5Q2s5cWZ3?=
 =?utf-8?B?S0lDaUlhaU5qaWtJTlhIRmRwNFRwUHVXVkVDc0tjRUhrUmFWNWdjMjkrK3BZ?=
 =?utf-8?Q?xErlAz61rt/doT7O/lSPcpeLe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e854051-ce6d-47da-8456-08dcc6fa9a9e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 00:44:41.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRakxsCfOfNcDJMTBW3WVdB3wVV/ZVMgqIZb/uxxjgab3oXOf0NUJG7lIlxsnmp0Ddh3BFnXZL4IcqojkXLxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com



On 27/08/2024 10:04 pm, Kirill A. Shutemov wrote:
> On Wed, Aug 21, 2024 at 01:52:49PM +1200, Huang, Kai wrote:
>>> + * attribute is no longer reliable. It reflects the initial state of the
>>> + * control for the TD, but it will not be updated if someone (e.g. bootloader)
>>> + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
>>> + * determine if SEPT #VEs are enabled or disabled.
>>> + */
>>> +static void disable_sept_ve(u64 td_attr)
>>> +{
>>> +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
>>
>> The original msg was:
>>
>> 	"TD misconfiguration: SEPT_VE_DISABLE attribute must be set."
>>
>> Any reason to change?
> 
> Because the attribute is not the only way to control if #VE is going to be
> injected.
> 
>>
>>
>>> +	bool debug = td_attr & ATTR_DEBUG;
>>> +	u64 config, controls;
>>> +
>>> +	/* Is this TD allowed to disable SEPT #VE */
>>> +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
>>> +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
>>
>> Does this field ID exist in TDX1.0?  I.e., whether it can fail here and
>> should we check the return value first?
> 
> See TDG.VM.RD definition:
> 
> R8  Contents of the field
>      In case of no success, as indicated by RAX, R8 returns 0.
> 
> No need in error checking here.

OK. Thanks.

> 
>>> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
>>> index 7e12cfa28bec..fecb2a6e864b 100644
>>> --- a/arch/x86/include/asm/shared/tdx.h
>>> +++ b/arch/x86/include/asm/shared/tdx.h
>>> @@ -19,9 +19,17 @@
>>>    #define TDG_VM_RD			7
>>>    #define TDG_VM_WR			8
>>> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
>>> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
>>
>> I am not sure whether this change is necessary.
> 
> It is more in-line with spec json dump.
> 
>>> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
>>> +#define TDCS_TD_CTLS			0x1110000300000017
>>
>> The TDX 1.5 spec 'td_scope_metadata.json' says they are 0x9110000300000016
>> and 0x9110000300000017.
> 
> The spec is broken. It is going to be fixed. I use correct values.

OK.  I didn't know they are going to change the value in the JSON file.

> 
>> I know the bit 63 is ignored by the TDX module, but since (IIUC) those two
>> fields are introduced in TDX1.5, it's just better to follow what TDX1.5 spec
>> says.
> 
> Newer modules will ignore this bit and both values are going to
> acceptable.

Yeah.

Acked-by: Kai Huang <kai.huang@intel.com>

