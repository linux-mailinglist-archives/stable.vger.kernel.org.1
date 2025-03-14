Return-Path: <stable+bounces-124441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9EA6130D
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF578814A5
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C31FFC6B;
	Fri, 14 Mar 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNO2STG1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20612FF6F;
	Fri, 14 Mar 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960262; cv=fail; b=qW5jBwGmBkAwqWjVG/MLtv57HrvDYpVaNYgW02znfx/scK4GdBS95z0yf76T2Y281sNZFwSsKDQ4vD4TbNnY6VoNsbbm+NtM65LInmWWYv8Vb54+0tUWe6PBDa+2M5cnVq3rTPfIMM52HlxosiDaDylVLBSL1P7BW/77iRseKqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960262; c=relaxed/simple;
	bh=opaRm8xr1vvbjoMvOwRa6OhkEsxC3HoCzS3RiRDdAuw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sh1q9K/bwuIq0hHi6iadX5AUyvpkX3UvX/+Id05JW2FX2YSZNiSsMNZGuKe6BQFq8RebOoboh6WSdkjWvxzTVZxnQZWhGKwdxxcevvhiHkWQI5F/6TA/QWM9wbAxW1/IdyBGoZ5hbw+7Noe99R1ikNbE/G+X3DAx9I0jkMzVMiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNO2STG1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741960260; x=1773496260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=opaRm8xr1vvbjoMvOwRa6OhkEsxC3HoCzS3RiRDdAuw=;
  b=nNO2STG1br0cQSpS1cOwyGQOTM+C+ei3ELqhRX+ih47l0GGSkWaTNKWm
   ROTXfuVWr97MMjA6ZecNN9rYw8RHgQB2EMQO+UWT9yGxxpFzOMAcAbZ41
   ymTSEu+LSe+9rgrCkDgss0zNy2NWLlMmYkSbE7OH59hLbo8rSQpm3AbZ8
   DwziYg8HFUWpLwl/Q/XvE+q0ha8GGTKyCxMb6Mc/vFJcBWoFMCVVcGlmp
   ZMtP3my5sXgU2cHMGmJEoJSzSRq72nV+B5CVIsDcYKtxhnaXYwAXbWcoJ
   MDRFCSNhbFhfhxeNlUkUf31uiQPEN4jo8EA4/qNXnGkbbqMxw3m92k3Xn
   g==;
X-CSE-ConnectionGUID: 0oTV8CETQ2O+UGmuq73zWg==
X-CSE-MsgGUID: dmbf9GHtRRqGDtNNdULgIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43240848"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43240848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:50:59 -0700
X-CSE-ConnectionGUID: xIDl9/lLSnyLPVNFMGGiww==
X-CSE-MsgGUID: OMGElGiAQsyT5PhiXM2iUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126500581"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:51:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 06:50:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 06:50:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 06:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE4SLdIJaGIcM3jlodTScMjEN6G8EGXYo6s47xltmyr31V6Yn73iU1sBON7I4hINTAHE97yNhq74kHWrYUTOfBnzy+tKxTcJ4ASC+9Gq3CQdnv/8M6+3mkB7E4rp04VxnVbr/Uk5AImtxX4ioSMrdKiitnwwASw4NQ/dbCgge/8H+LhmcmZvnazb8BEkfifMIObpaFxoSG6/ax9wE6Ix7xf/fTFkCCLXA9XwpZYfWz33ri9JtdCghB8aSE+y6YPHdLfpGTLdWEOf+vndMyoFwF/mvzAz6wiRMGRRgzvVTb5OtABPItigprkezjvgsP3+pQS4Nu2MvRgqviV85CIqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMHd0hUCEGj/L0L+LKmQqH7GRx6KJUdgdM/A8G2lA1M=;
 b=yCTh9M+XPc2aHfSl3CxQpEGV7zvpTE7/pXSad5BbG2DuwKFEvm5dxp6u4GXhrYXk6lm1M0YnIDpmxHOLsRBZ+aVxNWwl4l9awrq+1cJP6HTCXjLlbt29d2rMkwmIDjVMgQiJIgvqmIeI0Ctn1ma2Lkufvh1R9My7Oh4V1m9Zjq6PhchZkEZx/p4UQV8DZwuAigdlF05tBnCEkrD0YcqtsFn0bex0AanN0lYujZEJLX8OtL0GE/S9JyJu9VNIOXMRETaZQ//4GhkNDrcrN3ez9JX/kAD8+nJP8GaiZARJGPx8g8era7/7Q0/8zipXFo0/SOkC5nsPo8i04V0kWcJbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Fri, 14 Mar
 2025 13:50:55 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:50:54 +0000
Message-ID: <df48092d-2192-4f80-9951-70e321d28aff@intel.com>
Date: Fri, 14 Mar 2025 15:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
To: Karel Balej <balejk@matfyz.cz>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <phone-devel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	<stable@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "Haojian
 Zhuang" <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
	Jisheng Zhang <jszhang@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
References: <20250310140707.23459-1-balejk@matfyz.cz>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250310140707.23459-1-balejk@matfyz.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9e76a6-19df-46a8-21ae-08dd62ff3d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|41080700001;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckpBdTl3Snlsd281ZURaa0NNakxwKzZMUlMrU1J1ZGNBREwwQlhXbHl3MmxW?=
 =?utf-8?B?R2JvVlFVMGd4Umd1dTd5ZG43bHZoOU92dzdDQkN0N3JiSDE3bitod2huc2U5?=
 =?utf-8?B?Si8ySlpSajg3dUhIeURjbEJWelR6YUs4Ynk1TDBYOEEvTlZ2TlZKRWZMRTJS?=
 =?utf-8?B?SHpJc3JyVVVGM1ZXL0FYRXVYSUhCT0o1Q1hZakxxQ1d5eGtaMmt4bStzRzZp?=
 =?utf-8?B?TzRPaWVLamRGcVFDUHc2MnpNcDBOSDRYd2F2azJVWnFwMDQ1OUlGdjBTMzBE?=
 =?utf-8?B?TWtZTWw4a0NaS3VoUUxxdW80NHM1dGgyLzA4NDN0bWtNM1JLbFR3dFZhMktW?=
 =?utf-8?B?TWJSR0FSZitOSUdrMlZrVEhRWHBqRFVnSjZ4Z2p6M2h2OThKa0QvN09nczA4?=
 =?utf-8?B?T3ppU2lDSVlIa1VCalhSZS9yUjlRTnYzdGQ2VVlSNmEzSGZoNWxyU1NqNFhG?=
 =?utf-8?B?VE5hT3QzVlp0ZWtOcE5KUE9CMVhtbW1sQkVLN2hYMC9jQlRCZVM0bUJnNFJx?=
 =?utf-8?B?dkpnT01NRHNOQUUycUFFSkpNWmZGYk10bHNHMFlaVlBKcTZCUmY5UW4vb1pM?=
 =?utf-8?B?aVJXR0UwZVdaT0tQNytrTjR5cDFFUG1tQ3lIcWU4dllSM3gycjB1WXRHOW9W?=
 =?utf-8?B?SjRKSGZtWTF1SXp4MnJnekswK01kSlNwR0c2VjdIdHpIUHNyUjRSWlVBaWpM?=
 =?utf-8?B?VWtaKzRlMzRDU1Jkb3JJdWt3b3hiUU1vcnhNa1dYRkNNNmlHSlVZZ3pUN2V3?=
 =?utf-8?B?dHNEWkw3M0loUVhISHArQUV2TklBbWNnN2tZalA0WEN3c2kzYWJ5L1NYUnBJ?=
 =?utf-8?B?cmZEUDMxSUFIZCtQYmh1alNxZmRNa3dldXMra2RGMXM0bU92NXJoVmIwR2JS?=
 =?utf-8?B?OHhLWE5henNXa3RRTzNRb0poYXVyS0R1YkVvNFBpNkxDR0lJV1FOalBxYWYx?=
 =?utf-8?B?M3N2dnJCMHpTaWVnQjFUTW1HTUxCajBObDNFSENVZUxYNjFIUVlGcU42S2I5?=
 =?utf-8?B?TTF6MjFkY3dEeXBISXpFM2JOVXZsemVlcitQeDNJT3hLeTZsV082QmR5SlJK?=
 =?utf-8?B?b3huZmdBSlo3U3hJS0Z0OG9tbDVjMHk3OUFFSTRNdlhqZ0Zha1B2T2xBamM4?=
 =?utf-8?B?OUV2Si81cytpaGFXM3B1bG1TYXpnREpKWUNTUUtwZGFHR0ZYUjJVVlRnczBa?=
 =?utf-8?B?UTF4dXEyRHUzS1ducWRTRkNFZ2d1N2xwODFhdC9hcVVDQ2wzTHkxOUE4enZU?=
 =?utf-8?B?NXU3N2dHOStlcFJvQjZMTTNna0E0M2FIRzRhOStTOVZjR1dwVmRDV1grZ1dN?=
 =?utf-8?B?US9heEFONUZiUXd4MlVhMVNiaGxBbnptQ0YxUHNWOSt6MUlNazU2dElWOGJr?=
 =?utf-8?B?ME1jMTlqMUY2UDhMYzMxOXFldnFhc0tQUHFDaFZrcFMxamhncjYzL0gyaCt6?=
 =?utf-8?B?TlJsYXh6dFZTdUN3bk94RXhFWFZWSkZBTS9XRWlqSGkvWnNhMU1nVDVpNDU4?=
 =?utf-8?B?NTl2QzRHNnBRdlJSRmZ5aTdJajVpd2ozZ0xpZTFDcjROalZMUVF0c0s0cWxT?=
 =?utf-8?B?VEpmdnhSaGc5U21WV2VLVjJnb1hnQmJBcERjUDZqcGp2bExsVDB0TVRhUHBs?=
 =?utf-8?B?dmc5NEk1V3FHaHU2MHZobUFIcGlnVU8zK2QzTHlxemR6SW1qWWlDZFhxK1I1?=
 =?utf-8?B?UXNkeHlaODYwb0xQMURwM2tmdDFVYXJqT00vTmk2YUgxSzRqSlBFVFpKdVo3?=
 =?utf-8?B?M09LbGpBZWtoc29yelBCRC9uV25XSWxZRkUreE0yYlRXdUYvT0dOMWR2NXVH?=
 =?utf-8?B?dlRMZDhBSC9YNWFBVVlaaVluT2ZaVXFJN2ZGb1BKWHZZMWdVM2tZU1FWaE45?=
 =?utf-8?B?blM2T0luNzFrbTlHR25nZmp1UnBZMzZST0pOMG9mVXZ2LzJrbSs4UHRsNHlv?=
 =?utf-8?B?OStFS0tBeUpjOUwrRldzZ0U0b3lWRXJDS0N2OFJRNUxXSE0vU0M4ZlpHSnc4?=
 =?utf-8?B?UHpVNFdzRHRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5OaU9IYXZJVFBPU0FYTitZQ1BCUWRRRE1xNlIvM1pWOHdHbUx4ZVBucXZT?=
 =?utf-8?B?Q1ZwcmtadmRtcTZ2ZE4vOUNyS1JscnR1MnltQU1YbVNNSWRQWU9UeFlzNzA3?=
 =?utf-8?B?QmNDN3pYTGxqdHFtMTJvZ3VqZUczUGdqNmdDTkk3bHN0NnFNaStkUUtpVlMv?=
 =?utf-8?B?VVl1bkwySm41YVVPcmloQSs0dENYN010RGNXbUZBT3lUTHhoZk5SOXBxblJp?=
 =?utf-8?B?OVorYVdTbXZzYng2aUxNOVh0c0VTMlYxbDRXNDhnbjBldk9VMXBEd2puWmtL?=
 =?utf-8?B?c2ROODVvNVNKdXJleFlpU1lyS0ZXcUF0TTJMQVlQYlAwZjE1Z1A5bjY2VnFo?=
 =?utf-8?B?UFZkeWtLcUJncmtpOVlGT3hTREZwbVdNYnh6cDFLbkZnaEsxT1pXSWJHUHdN?=
 =?utf-8?B?Q09NV0kzNVI1QzJQRlcwUklCSEFOUnRuVjZZa1lZcG4yRkhxcVhSTU5MeTZv?=
 =?utf-8?B?Vy9GU0JjQURyYjk2RXdVQjdadEoyc1ZVSzNkYlYvVWlhN2t1TW9TZ1JFZHM1?=
 =?utf-8?B?K1JPaTZZOWR4M0ZwckZJVGRhN1d3OXR2MEVKbWpPUkQ4QWlkKzh2ck9YRm9a?=
 =?utf-8?B?cmlMV2VRL3l6eUQvVnRqQWxqUkNYdzhXTHFmeERCOFU0eTdYWmZnUUl4clJk?=
 =?utf-8?B?dVlFeWo5M2xaRE9XaGd0VDRyZDVIL2luUkdndWtJQytBNzJIMVlFdWRpTEMz?=
 =?utf-8?B?Y21CVCtFWTBuQXFDaWdncjQrcTVueVdVSW5HVW0yQUYzWU9WR21jZjNIdVpX?=
 =?utf-8?B?VjBYV09vdWozQjlkTCtSLzlJKzJtaGU3WEl3em81bWlqMS85V21KdmVzdXhE?=
 =?utf-8?B?R00yQ1RnSnE5Q3pjUTM2cjJGSEU1c2xiZGo3aldYbGJjQmo4dzJRZ2tPbjAr?=
 =?utf-8?B?YUdGYjFwdGxpNEM1UThrUmcwczhFQVBYNysyZUFxNGtOSXdTUWFERFdKY25D?=
 =?utf-8?B?Vm4ybS9rMGhZQy80dE5veCt5RjZLNGNnSll6bDRMdTZtZmsvRFc0Q1JYeTNM?=
 =?utf-8?B?cFU3SkRqcUI0K3UxYllGbFJ2ckJ2djRSUkxRaVhqS2tWNHJWUzZ6STRrM1N3?=
 =?utf-8?B?MFhBakd2UVozMmdNQnRTdEZPNG9qMzY2SlZKblNLdWowR09MN0U1UDdQblZt?=
 =?utf-8?B?WWc0STlIQ1JjZmVHQUlrMlVzU3dGRHMxZDYzZGxZajVyOXV4NDVOK3dUYjlD?=
 =?utf-8?B?Y1kyZ2JhbnlYemt6NkRZaCsyUGZFUUNIS0xUN1EzWHN1TmZ6Wjl4YWhUVUQ3?=
 =?utf-8?B?UGVteEloZUllalkwd2g4MkNSM3B4bUdqeEdaNnpQSGpCWDJZSWJVRGNhSFdW?=
 =?utf-8?B?Mmx2NUdzTGs0bTJlOGVrMUc3UEJvMlV1YURPeG5PMWhlNytvQ1BXejVvV3FW?=
 =?utf-8?B?MHYzeXI1bWpXYy9TK2VITU9LYTQzSUxkOGhqaFNOUkRqUUF4SXlXUDE3ZStC?=
 =?utf-8?B?L2VVN2RITEhPWEdySllOc0hmb3cyZmNBcTZRM1ZPR09ERUxSemJEN2w3SW1r?=
 =?utf-8?B?SHBybWREVitDdnE5bjFaVFAvZWQ4bnBWOWp3WkJFaWtYbDRxZFcrdkdyS095?=
 =?utf-8?B?QVk5Y1p3YVVsUHduVE04aGI2R3dwUjk1ekRuL0I5QW42bUVLYWl6STZQMk1M?=
 =?utf-8?B?ZTYvWnM3UWlJSmVsSmFYWFkrOWxHVzZKcnhSK0lTRDQyYTlZNEFVRkF4Zldh?=
 =?utf-8?B?MG4zK1BzWVJ6cHdwUlBkaTFoT1pmN3g4TkdGVW5pM3VoaGoxSnJsSE90VExs?=
 =?utf-8?B?akRVV1QwMXdKbGxYV0pNK00wOXJXWi9mQTN0R0pFWGlnUEQxRkh1WWVVSFk5?=
 =?utf-8?B?TmE3TzJxdkRYUi9tTTU5YWlVSktQZUs0QXQ1dlJOOW5aaWVKYTNGajdEMDk0?=
 =?utf-8?B?cVF0Rnpvc01ybWNtMUFsTXp5VGZkUGRXbmUrbGI2eGN5RmhCR1BJL2ZBVWps?=
 =?utf-8?B?d0xIN05URFF1OWZWdzVXM0ZOcWx0QXdHZVNDME5lRmNvb0xmTkoxcDhFNjY2?=
 =?utf-8?B?bWNJc20zT3RoZGNMWlNBeVlBaTJGOGJKK2VrY0RXMzBJbERieEZndkJZak1t?=
 =?utf-8?B?UkxuUlJIdWE0U1dWRzNDZGZ2ZFVSQmNucThIS1lJaXlhM0xtVUw4ZUxiK2t1?=
 =?utf-8?B?UTVITkZrV3l5OEhYNzlyQ1lNbXo1a21sb3NuQThjUlBIMUh3QzlFbTN3eXA3?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9e76a6-19df-46a8-21ae-08dd62ff3d7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:50:54.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Di7q9LnSQwkaijVU5JwELRc/d1otwMXm506jVBU5YPC/j6/6jzsliceMatON5Cesr2oP9ckM+KmPDVCvck4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com

On 10/03/25 16:07, Karel Balej wrote:
> Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
> prevent conversion of R1B responses to R1. Without this, the eMMC card
> in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC
> with this mmc host doesn't probe with the ETIMEDOUT error originating in
> __mmc_poll_for_busy.
> 
> Note that the other issues reported for this phone and host, namely
> floods of "Tuning failed, falling back to fixed sampling clock" dmesg
> messages for the eMMC and unstable SDIO are not mitigated by this
> change.
> 
> Link: https://lore.kernel.org/r/20200310153340.5593-1-ulf.hansson@linaro.org/
> Link: https://lore.kernel.org/r/D7204PWIGQGI.1FRFQPPIEE2P9@matfyz.cz/
> Link: https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-0-847d24f3665a@skole.hr/
> Cc: Duje Mihanović <duje.mihanovic@skole.hr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

There doesn't seem to be much interest in this driver except from
Karel Balej and it looks OK, so:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 990723a008ae..3fb56face3d8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -399,6 +399,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (!IS_ERR(pxa->clk_core))
>  		clk_prepare_enable(pxa->clk_core);
>  
> +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  	/* enable 1/8V DDR capable */
>  	host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  


