Return-Path: <stable+bounces-165537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5BB163F4
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD0565F33
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DC2DC35B;
	Wed, 30 Jul 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aby5UEro"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D0276058;
	Wed, 30 Jul 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890877; cv=fail; b=QE/4ylRQDo3rYZwKJBlCW7aFvEzqnbUej5bEeJ1I36U3E64CpccB+C3ZOPEq17MVzjlFBWYE6O6YUSPCGImpCRHjZfQFuHoAaRcMDSI+8pn9fIOFPM9TzkdY1mDi0KTQCb8QbaZQky2Qm3P3485CWUoWoTa2rRl2vbKonVmJDAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890877; c=relaxed/simple;
	bh=7MZIG0LejSdn4aYMYOEMTYFDuD39ArWxMk9h6TIsd8E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pl+EtvATpWqUh4V4sqE8992ZlDprIyzVQM6GbxzavrzWSDx0C5GMV54rMkMD2OkBTBpx+TucLnr75tdN7n4UDvSozkGhzl+D/b5jFiJkhO5buvswwxvHu54W62sDoYcINh48Lw5ME6+EHdruhSN5gi2XuEWAjaSyRtXISewoY7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aby5UEro; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753890876; x=1785426876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7MZIG0LejSdn4aYMYOEMTYFDuD39ArWxMk9h6TIsd8E=;
  b=aby5UEroNa1B/r93FMR3pMcrPY/mK5/VTMKpDARqb8052zyfMr4PP2E7
   RH1gxCMkCFqIhqLKelPKik/MwcyCKXjxawp8mzjDd0WB27k7/t43UW9rD
   P2EwoQYldGqFRxt7NeFWOO+jymYcm7hQzSv0e58jIWYxPJUhzw2KK09lo
   HaKCwXDaw7idzcxaDW20LLloe5PMDDcgzrD6OjB75v2xGwV0Ni8tfJPyp
   1o56xh6npzhHkgI2IL2fnQU2jpoAm/EHuSoIO6vVhigrzWUjjehm2PtXV
   ajabEpeOQLOEp7BChrs0ZJnHGDwOYWHWxc2w2uiILkYzmkiu1SEA+kO4J
   w==;
X-CSE-ConnectionGUID: b0bmt8UWRD6QYUsatEypEw==
X-CSE-MsgGUID: MtA8K/aOSwaO90F4hVKZ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="78748839"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="78748839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:34 -0700
X-CSE-ConnectionGUID: XDDcLo2nQp6Ga8dZNME7Aw==
X-CSE-MsgGUID: aVgwlq41TOmlYlmycwseeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162608292"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:54:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:54:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 08:54:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 08:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnClS7WSDPiOLJ++HCzjGwYnSLEXT09hiaHGlDNIogV08IGnq/n9Z/sW9fGe8srrvTHSkRTTT50dcuaf1VDgjx4ZpCIwXuo3oITlwFiawfWi+OhVLcQLy5W++38k2cZuDv5s1Hr8uKtPleNzMoNU/nYpY0TK8UVHnf9e+ZGcYgXyYE96TWluQfw/EdobVNzVAzbsKrWxHAaEQiom4QzbB1PT6jC1kIHDgOe5Lrd3Fvdl6E4L0JsU3K1WlpFql7N81mME0A6OAKLJHZ+anv3o+fXaBFnyU4aS2W5+wsPb0HwGgv5G4DEgi0vAWbb5yL6m+Z7BG1slT2apk/A5AABXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKdzFXqYA/Y+LVitUeH+zMORJGELBszRxNz+4wrS/6A=;
 b=of0t3GTSSrJh9mYJ7SPuh1hXSAK5V7n8FcFLWCdpsMUKerYxmwlL+C+hDkvLkNyM102CSyrZvJ7RI0vNajzbxO/wx/ARgZskD59FyaliOAlvCHytZJLlg3hup4x3CONjJefCKlMZYbC8nFNSsctG58VuwUdISr2Y8aGJ9UHeK7h4803TXlhQU7sl9eEp2ee500sw4+y5tMLZKUaH/41VgzD3MsauxB/afxEGNunAnsr4cCTTlVkisLkshx4kGD328C1shjdZFYNmQBUSWomBUkqeVsfmYkmEEdN1fpoyzH9+vlU+XF0usPtNx1OYf+bPs6yAzvC6v0sj53VtctSxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 15:53:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 15:53:58 +0000
Message-ID: <3d13d5ad-f121-4920-8d06-feea0f0670a7@intel.com>
Date: Wed, 30 Jul 2025 18:53:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] mmc: sdhci-pci-gli: Add a new function to simplify
 the code
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<stable@vger.kernel.org>
References: <20250729065806.423902-1-victorshihgli@gmail.com>
 <20250729065806.423902-2-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250729065806.423902-2-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c78edb4-8008-42ab-ac21-08ddcf814b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWpSWVcyLzdOQ3RVL3pzRVRMZUF5UllzUFUySmEyU08wQUpmT0lsbFQvdWQ3?=
 =?utf-8?B?RkJleWFMazlUYUMvN3pmeWovNGppdDFrRU9CUGxucnBiZlRGWWVValB6L1NI?=
 =?utf-8?B?TTgvRTl1bkxwQlp1elVKQ05MSWRndGVZbGpIUUs5dFE2Z051a0FFa2N4UGFZ?=
 =?utf-8?B?MkllRVc5NFhLM3VkanE2MXRaYVRtT3NjV1lqejNVNlU3aTZPcEh2VG85MzV1?=
 =?utf-8?B?R2pGQTVERFBDODVOTkE4Sjdvd2ptWVFRUnJVYk4rM1FHSkdaYXVxNndUVzZu?=
 =?utf-8?B?WUV2UFIzalk4R2pWekpFRGFNdzhLY2JKZDFmMFZEYnk5MFZ5eGxOZ0ZNejZV?=
 =?utf-8?B?eXhVUWhjS3VGdUNGYjR2YlhqUFowaU03R2ppc0xWaVdpRmNwdVlNRG5rQjcr?=
 =?utf-8?B?S3pLaFdVR3FwbkxVRWdiR05KWG81WXZVZDUrRTFYTTdBdUdQOG1LTFEwVzlk?=
 =?utf-8?B?RW1jSmNYUjA5OGo3a0NNM2ZISWQzUHdnaElXN3FOdDRseXFKYWFWTXFIQjBO?=
 =?utf-8?B?aXBBSFZGZzlwK2FNOTd6MU9aRVVqci9POTIzSWNlNmhnMGF2cTFLSlp2LzBh?=
 =?utf-8?B?V3A3K0cvdFRaRzdjK3NXV3JtTnQ0M2QxSjErUXcrU29wMCtiQVFvdVBCQ1JN?=
 =?utf-8?B?TWRIVHI5cDdHZS91cUZ2QTJuZnVXaHFaaVNyWXhOODVUbFg5RnNEUFZWbUdE?=
 =?utf-8?B?SXFoSjFiYUFQbE52RDc4MHRLZEFGUDZobUorR0pjL0tzKzRldFJCVFh3M2Fo?=
 =?utf-8?B?TzBTN2FWVkt0cksrbHN1ZTI5WHh4cGs0b1VZWU9YaEpaVFE2eDhGdDM2WWxl?=
 =?utf-8?B?MmVKMDVhNzBEdlFEM1NiREd1SFpJRGJ6eWczT2NOZFdjNnd6Z0tFdUVtSDRi?=
 =?utf-8?B?TzBLeDZIWitJU3pleEYrdElYbGV1YzN2akY3Q0FwTE44MWJDbGFxTW5VclM3?=
 =?utf-8?B?TStJYVRMTktjaXZoQkMveER5alY2eHdiUmlrdzdzL1JPeWkxYXBVV1BQMU5H?=
 =?utf-8?B?akgzTUVzaHUrTkpUTnJaMC8zS0w0cGNzRE02RFcvSlBxUkVGNmJ0NHpyS0FQ?=
 =?utf-8?B?aXY4SVhBY3plVGtGTjFtcHRKNlNwZnE0aHp0dyt3S1d6ZnE0cUVnOXZQZmZ2?=
 =?utf-8?B?NXVIY0JxYVZVeU1iS2JudDlCU0tNVitIT1BzQkVoNGovSVVFemJBeGVxcG4r?=
 =?utf-8?B?MFFVd2R4WVhaSmdLUmZCKzF4T1dtUlhaV2MwRUdWYTk5Mk4yd3o1L0FWNUdU?=
 =?utf-8?B?eTBGMmRMS1NGeTJ1Zk96bGg1Y2lxdjJEbFQzbVJkZzk1bSswZGN0M04waGNP?=
 =?utf-8?B?V09ZQm94Qm9CWWllWmpZaDRhYU1EOGFPejFUd2ZiQzhEbjVoTGFWckU3TEFH?=
 =?utf-8?B?NisrNnpzRDZ0bGxWdGEvT0czNzluNHROM0tZQkQvamhaa2tmTnVBNnJ2Mm9t?=
 =?utf-8?B?TE8vaUFvUFZUVHVoM01IRW9iSVJjR0JpSkhlaUxvWFhpZ0xaMTg5dzBrRjJu?=
 =?utf-8?B?Wm5IKzZOK3Nzd2tsVjN6bU1JNnBld05VMXBqOGJqQXhCNjFkOUlBNElvVFpu?=
 =?utf-8?B?dEpQQTZxSWl3Q2kvdVQrRnZ4VHp5ZkdmNDVRU2lKd3ZhSmltQkFQbmN3ZEJG?=
 =?utf-8?B?cFBTbTJPYnEvMVlSemUycGJoN01xb3RCWTNMZXdnaTYxNXNaU3k0bGZKQVhi?=
 =?utf-8?B?T0oza3puUFNxSkpscWVwMWxhMnEvU3E4NFJ0WmZuTGcrRkNnS3NUQ1RNRHY0?=
 =?utf-8?B?cUF4KzNhSkRrZVoxcStVdXA0UjhmbnJXZ1BwZ1kycmlXMjJSV25GUGNVcGhr?=
 =?utf-8?B?OE9Vd2NYMWFsK2d4WnBTR3N2UmhlcC9rbTJQcmFmTXRlVUVIZHVkTzEwV3Zw?=
 =?utf-8?B?cDFFc2NnMVFTZGdDMkRjVktIYWxrU1c0Y2piRzYybWRrcXBnaFJRQ0RBckc5?=
 =?utf-8?Q?v7LWK/k0SyQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZvanhsYytPYmJtRjJyRlBHcEhJYjhWaE1aVmowSHR4QndIeG5NWUN0L2E4?=
 =?utf-8?B?Y3NCcWNRWEgrZzRHWHprUG8zOXpXU256d0NGVG95RHE3QUx0aCtoZEFkUWc0?=
 =?utf-8?B?N1NxZTltZHNkRk9EQ1hqdEo2VDBOSTVUcE5mS1J0R2k2ZWhPUDJsaG9lYjVo?=
 =?utf-8?B?bm91OWIwcHRUTHhKaXp4U0h6TjJBWkMyallPZUk2OU10U0ljYmUwTVBUcmpj?=
 =?utf-8?B?WERyQUhRRHlwQkFTcmFGZ04zNy9FTnpRVnltdWFBb0xtZjEzd0tHK05ILzdv?=
 =?utf-8?B?Nk9JUzMxNGxDV0Z4TVRHRTlHUkVnamtBTktiQm5LR3daejJ0ekJCb3BHMEFG?=
 =?utf-8?B?V1ZMdENibzNhbWhORzVnU0pPdDhldHB2Syt3VDBaMVcrL1Z5czBuZUx4aDlz?=
 =?utf-8?B?RFIwMTUvem9HaVh5NG4vVXE4akEwWTZuVDZkeTJCdnczck5oRWxFNk1FemYy?=
 =?utf-8?B?ekpwZWM5YVdYMzRqSVlkMHlFeWIrclptU3hOZ29OSStHRllBbjlPbU1jc2hq?=
 =?utf-8?B?aFpaUlB0K0JFb2UrdHFIUmF2ZzdsTVVEUGd5UkNEaDhYTXBUQURIdHVaNHEx?=
 =?utf-8?B?a29rNFdNNWlITEhRZzFPaUdaTUFNWndMVWtuYy9VWjEvREJhc1NzWHA0K216?=
 =?utf-8?B?QVEwTHdyMmdGaytaVU4rSm9uMmpnVGhycmE2aUJpZlZnZngzaHRkSHFNaDRz?=
 =?utf-8?B?dEMrMGtjekM5dC82U2lXR3JSS01raU5LT2NnRmJSQzkrZkZQUmxHSk1JVUFB?=
 =?utf-8?B?NW5ldUxQMjFlUC90NFNCaStxWnpkNFlyVWQwaUJWUWhFY25VbjRFRjU3blVj?=
 =?utf-8?B?a2NTSDVUMXdENnVBNXlyeW1FUFJ2S3U4ZEZxalo4SCtJdlp2NmVRUlZqSHBl?=
 =?utf-8?B?b1drV2JUSWhFSTIyaHEvSTFyUCtKNVNlejN1b3NiOUZwSVNVc2dNbEowZ2hi?=
 =?utf-8?B?eUVZTmh0UWdXM0VYSFVCRTNHdVFqbTdSckRzUVEyYVMvWUJNenlmVzJrbERU?=
 =?utf-8?B?RnVwYmY1V3drUk0xbmd6WUFaV3MrbnNrc3Q1VHpaODg2TDZtaWZoMUV2Y0Fu?=
 =?utf-8?B?MUJZcFRnVzVpQmJyaUxvQmVUZnVibzh0S1YyKzNiVE1oUUI3NklUakY5QUtO?=
 =?utf-8?B?clB3d01NNEJOTDRWRUcvNXpiZTFSVlNkRkF5aVBpZUNtdm9hb2NSNDhrcDdQ?=
 =?utf-8?B?V3N6OGpsL1AvcHNMQlRxNkJBVXhReU1zRnZRenJqNUpKMEV0U3JCMi9HYmNV?=
 =?utf-8?B?Ui9BQWZJMjZic2ZPSklITHcxL3F3Z2tDK1Z3UFpVQ2RCY0ZadE12SDVpM2gr?=
 =?utf-8?B?cnZpcDQwT1E1S3RUWnJkcHJ0TkcxWjFyM3kvRTF0TXh4S2JWNFZlQnorU2Fz?=
 =?utf-8?B?bjAzSHJnZlBFZVpBNlFiT25LaDlyY1NyOWs5TTBRbEp6VlFXTk5tb2F2ZExV?=
 =?utf-8?B?UWw2bDV1THV1ck1sQ2J5Q0lZZ0dqYVQxOFBVVHd1OTJXNGdaY1pUb3JsaEl5?=
 =?utf-8?B?Nnh6L1l1UUVsZW1nRTFZNThxelF3ZlZPVEl0cE85eWRCZ25mM0Z1OFU0OXN2?=
 =?utf-8?B?dXp5eVFGMjI3Q2p2cVQzd3IybzU0WTB3YVZNcVpPSFg1MTVlVlBnek9MWmNo?=
 =?utf-8?B?S2dRY2lsZm9VWW1GdjdvaW15OGlDby94M0lmaG5NZEJsT2pacVNPMnllcG83?=
 =?utf-8?B?VUxvWW9rUVJqZmlqbWZ6UUhLemVjeGR3K1Nkd3lDSzRJNVRjdU1JVkY2akZR?=
 =?utf-8?B?clJWeEtoZURPR0lQRWtCTmVrcUh3d2lHNEJKcFNESkFxWDlvYVBTTEtpSy9i?=
 =?utf-8?B?a0FSajhnVVhVK05UYjdidm41WGhYUk5VNzZ5SWlBUEQraDBmNmxFWitiK0Y0?=
 =?utf-8?B?dERUcDY0Y1JMV0N2Q3FDQUJXWjRiajNLRjV1RnE0VmN5eDlkbzRpS3JyZkV5?=
 =?utf-8?B?d0U3V1VsWmpQVytKUE9nNDNTQUY2bFpISmJMRFovRlQ5OU1waUtFUmpuZUhI?=
 =?utf-8?B?a3NCelBqeEVlUDJMeHBCRG1zZEgwWDFNY1kxUDdocEJmWjBDdTUwUWh1QWdy?=
 =?utf-8?B?QTNaMkFMalF0SkNpV0I1ZlRadWVoU1VzdFBvSWE0S2orWVFOS2I1ekRUNFBz?=
 =?utf-8?B?R3JydkxLNy9oVWYxZklMUWhSbTIwR3Nqc3hIK3Z6QlpsK0w1MmxuNFRJSzdB?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c78edb4-8008-42ab-ac21-08ddcf814b28
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:53:58.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i+iuovFonVMImGW/DY39VA483BuD+CgnVM2ul9pDGdVt2OMThMebBdRMXfu2996lmMwDIlwbxV4LXISzvl7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7489
X-OriginatorOrg: intel.com

On 29/07/2025 09:58, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> In preparation to fix replay timer timeout, add
> sdhci_gli_mask_replay_timer_timeout() function
> to simplify some of the code, allowing it to be re-used.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
> Cc: stable@vger.kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4c2ae71770f7..f678c91f8d3e 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -287,6 +287,20 @@
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> +static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
> +{
> +	int aer;
> +	u32 value;
> +
> +	/* mask the replay timer timeout of AER */
> +	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> +	if (aer) {
> +		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> +		value |= PCI_ERR_COR_REP_TIMER;
> +		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> +	}
> +}
> +
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
>  	u32 wt_value;
> @@ -607,7 +621,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>  	struct pci_dev *pdev;
> -	int aer;
>  	u32 value;
>  
>  	pdev = slot->chip->pdev;
> @@ -626,12 +639,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  	pci_set_power_state(pdev, PCI_D0);
>  
>  	/* mask the replay timer timeout of AER */
> -	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer) {
> -		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> -		value |= PCI_ERR_COR_REP_TIMER;
> -		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> -	}
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
>  
>  	gl9750_wt_off(host);
>  }
> @@ -806,7 +814,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>  static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> -	int aer;
>  	u32 value;
>  
>  	gl9755_wt_on(pdev);
> @@ -841,12 +848,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  	pci_set_power_state(pdev, PCI_D0);
>  
>  	/* mask the replay timer timeout of AER */
> -	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer) {
> -		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> -		value |= PCI_ERR_COR_REP_TIMER;
> -		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> -	}
> +	sdhci_gli_mask_replay_timer_timeout(pdev);
>  
>  	gl9755_wt_off(pdev);
>  }


