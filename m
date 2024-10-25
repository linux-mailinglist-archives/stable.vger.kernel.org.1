Return-Path: <stable+bounces-88186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE39B0BAE
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE1281F8F
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C713A40C;
	Fri, 25 Oct 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLSETugD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD420FF7E
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877410; cv=fail; b=k83elZR+i4s4AAuhwJKHP1+dYNew6tlYadHBByxtFi5fFxS7OetEcXf4i+DFW7OM/jJIKediAkjE2NxyG5PfczlF2nFT9zYShLe7cSSxm7X6Sm9hj3X4KrPtLmTVNN9mm8V8JAq5uNcSgEZjrhxwYfw9GBi52cRGffz3VdrUFiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877410; c=relaxed/simple;
	bh=Kq/SQJJSlCHJjtiQQVjQB1dK3r+AUr9Ewhh7A3k+MH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LimzUk24tktciM5yCIBzp67U7yGy07zDU0+5k02GV6XYHlNJy7m/LT+GdTIAPHEx1TsIQQhTmVtn9R7UHjy8at9+2lNCaQYunjz46MlfWnSmn/XaMg34cCDTAO5hmjvij6QDUciUbL2LB9dAHtfnbH4ml3ZBP1ywOFNfjCSQkUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLSETugD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729877408; x=1761413408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kq/SQJJSlCHJjtiQQVjQB1dK3r+AUr9Ewhh7A3k+MH0=;
  b=KLSETugDhBJsy5Zc9v0tGZEdizbDOcu4TaQOaUfOm/m0YleJSL8aobKQ
   3eZb0f+Po14mFD+NqFVu+XzWCRSOpXgmUrlgB/Hww0UDqU37XQfUYRfDW
   QsLdXzusgbTywhY9Tl5A0Byj3TASMJbelUA+QAmLChDHBq1yiCdER6GV6
   JuALZlkgvtAx1uKaGcKRGCghFKHCIStEO5W4e+IiYwfluhH0RMKwE9nfS
   UP2ldakPI4hwJezrkfFAEvLcWJFqkFaEX9/X55px1cnnc87LNMHbZhw6s
   z9CYmS8YtUheuHVzFivO9tINIFgGUjm0bSLz80oUJd6R40DaSt5s3CpFx
   A==;
X-CSE-ConnectionGUID: oFfj7rhJT1Cte8Q7YKQVng==
X-CSE-MsgGUID: WbGEYF3IS32SPW25l9k7IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29008883"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29008883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:30:07 -0700
X-CSE-ConnectionGUID: 0z/f6/+xT42BkOuJ5GgvyQ==
X-CSE-MsgGUID: RCWzwxTTTzmVfNdAgibzkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81004008"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 10:30:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 10:30:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 10:30:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXLfwt3GkGoFA+f4TE9QwlMFfIGk8QWYJUnBFg5df9kMBFq0iMtiPgDVL5lx4NUdr3WnwLSJevOcL81vtB1LOfoiKEUE2sFShcIG08VxEXX11NoCefyZNVToSg8lg3cl1kEZ8vPQvmB02SG/Ub/PQa0FQDruQJFIzz8pv8Xq+fkNILAl/72hGSnq8tY5SAHzHDsJH7Jc5Zu6OCEls+CQFC4qYQOoQHqKJx939xVdTevxzFM+RwrokEglZEOSC3dFEaBp4iREtJhkL/UcMUQEWhBCUg17OatUgixE3tqL5/B3hlLM1TuZ9Fxlltp5XKziB2US4LPGtJZc/k3K3cxOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIg07EkYiJT+Qqf/XK0VqOeZto2HuqNyFpa8iV2nImI=;
 b=NNu1jNUgj9OljbwdGn76fVeL1OUBblp+ISetm0U0Ken2rVQS0BIM7Uq0ltbEehptMDgku7XbzX2zamkXHEH8aXCI+p3ETdVFLavjIkRuKIA6r+5TDlktmxk3H7PKxnWoUY+rvlZSnWDW9j2TNRETvwqMFzrQRdU7INOx9+P7Djj2AB1c9ytyb0soUtT4g7slgHQprVf++GFMh8kywyPup7VAdB3SW8iXUc+mY69lGuaW4Iq37f2INdRkcbN0ULsEhzQ3qbxMssttxvRBGOaLMUiI3nvLJnRlIeLhS+n66shF7hB54pLcbWoJX88YX8d4HPuCTQadr/mO6As/2LMqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB7644.namprd11.prod.outlook.com (2603:10b6:510:26a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 17:30:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 17:30:03 +0000
Date: Fri, 25 Oct 2024 17:29:37 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Nirmoy Das <nirmoy.das@linux.intel.com>
CC: John Harrison <john.c.harrison@intel.com>, Nirmoy Das
	<nirmoy.das@intel.com>, <intel-xe@lists.freedesktop.org>, Badal Nilawar
	<badal.nilawar@intel.com>, Jani Nikula <jani.nikula@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
Message-ID: <ZxvVgd0UzDVYonlu@DUT025-TGLU.fm.intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <ed863a65-5238-4bb9-9173-d297ed953d1f@intel.com>
 <ZxqCXUp+0EWLVX7u@DUT025-TGLU.fm.intel.com>
 <7ffb544e-059e-49ea-a121-485154496bc1@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ffb544e-059e-49ea-a121-485154496bc1@linux.intel.com>
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccdac43-9ecc-4652-d8e0-08dcf51aa8b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dMcaEBSceblMjyZr3MTyvourYTCGUZ1EyoDC0yIqrC+HPzjtOHSDk0KmjH7k?=
 =?us-ascii?Q?50a00cZzhgE1iufI1sZgF8i1HxrSiFs7wmOr6LaOfBFjTnyLNQTBsDj1ikqD?=
 =?us-ascii?Q?C5Ln5Yx9KvzQ3C9JZe9E1WxDdyl4k8dWC4M5RhIFKzhAF0doXXZdRyyPE2YF?=
 =?us-ascii?Q?SO9CyevHNaUBiCobXi0EV3wH2Em6+OSvf381InPH8j1j45oTONxHZdFTqO2N?=
 =?us-ascii?Q?PUNAqqc4wEuq8BxdQugX0jaPzQyoNf7OBeKuG6WVysAh9h/8FWin3Aoo0fzv?=
 =?us-ascii?Q?VHW1cAyg2uH2f+Po/6N651eiSQs161TmaCWsdt9lJcck1XzQ3x5ePHbDEZ8D?=
 =?us-ascii?Q?xeKvsYYWDNhgYcOX5i5MgxRlrLfzaSSyWzqqnrFm08ZDVItrWbxycC5F2TEF?=
 =?us-ascii?Q?RECZDlu3ogoABq0159txrMnFPWvjFbIyUDx9X9avo5ojy+GmzPm/2tDSUGNe?=
 =?us-ascii?Q?7/3DZeRtZ21kdh7Pb7/h0ZikDn4NkDS0TTUKpGjwn3BotPHZ5Sbga0Hloopu?=
 =?us-ascii?Q?W+EPk3OUrFGTJeGc+CPXMKKjVSnG0VKiALRTkDRqgMO7UQOKnb+5Yp/pk8Ra?=
 =?us-ascii?Q?+/wmbQ4iKEACfILCHAv5BqSEFBVsuw6P/rS6mYMA2P6eUWzgNavQFQwq/Ldo?=
 =?us-ascii?Q?l0XeqYlMjTBJCkd/1xXzpslrMwmhqMAaXGJMWQWOKHNR9z/SteUv622vBT6N?=
 =?us-ascii?Q?uTsbF/t97m7lCVkIRbw9we7RW8+/aqz/5KFKih0sdqsqCTSIWsqfDyV3rKkk?=
 =?us-ascii?Q?pzPtc6QwuEp6dB5QAjn2Vcrxc8ytmyqq/Beqkon9gGOkphmKLnrjYBBGiIH/?=
 =?us-ascii?Q?Q9+KXL6vrrBGH5kuOS+AUcc/PARsMbM0giFf6Bjjtwex3yujuGNsPVRf2bxZ?=
 =?us-ascii?Q?KlQ+4swpketAqvoNrEDFVOwoBvK1rm5XQaBq6otHrIdakOfHMeceITNYgkFx?=
 =?us-ascii?Q?M1+5N2lH5UWpaCkL2VKenv/yjNWOktkoc5k2Tk+IGwET0zeUXyt/gK8B4gyx?=
 =?us-ascii?Q?DQ9ruZq40/A/3pkAoWCXstynX8YUYAqnzYyiU01doVKpBvXnF162trtOsVaf?=
 =?us-ascii?Q?1m0wbEN0F7kphRRz3nUjZ+xkhm7C9zRq3fsXRXjRFp21SZvHOfjIGWLpfLPe?=
 =?us-ascii?Q?snzM6FNHUcAjm05eblAMTgQvOkS0Wkl92JRrIDVqJMXoP5qrkk3NK37Zw9+I?=
 =?us-ascii?Q?69HQhbVgBArv+sPxCyuwWI9vRyrDKphGSb5JnYmByfQ0GSlK5wTyhzJfYgcX?=
 =?us-ascii?Q?X99dcqi528FlboKT3iLD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZXxoZRm0hotIGk3RgfCw7nbSwzpAORFghIWwzCMoQZNxtcIUAGyjMvVRJJh?=
 =?us-ascii?Q?EAH2vO+LQiAXnagAvfttF/BWvrbgorFZBobTELdPNRsQZqX0rMdJCP3i5A+V?=
 =?us-ascii?Q?rvbwsi06Y2l9gyRm5F0Z2j8OcaiOToy9MDR4rspjmqVbpVfpbY9JpqKF6TxF?=
 =?us-ascii?Q?JwMY9OQ5DL80KO5QaiS+1CjLgxAtRrMOKSEmr6oT/lAu4Dvki7oZ5J+V5L50?=
 =?us-ascii?Q?THGGWETJg3VRLTDIMnrcLRt7cVTo0K1BwtkgoP2INs79IeyBs1x0Q0eBec5S?=
 =?us-ascii?Q?NQR84ups6vWssY3LT9h7fgQz44BMUTuSdwQYcUzT9MImAQ923JY670tyQMSX?=
 =?us-ascii?Q?E78mLcDODsLbkYzOGzzqiuQJFnESw19xwqb41cBrCdDOPC3Yff0n9HGF860j?=
 =?us-ascii?Q?+421iRT6mCtW4Lr9z+OX3gbjP9qDh1doPDPGZk/zT4ftG5ITYmz7soQcREzf?=
 =?us-ascii?Q?EO7nAG814vVSGgfZ7m45O4JO0mnCqVL9Pg3k2gesYKBBTEd7WNOsLlEU5Noh?=
 =?us-ascii?Q?wljZ0wq0BgZbY+nJ4YUgu7CWK31X4ht4TGStfe6eLUi/Rw1J7aFoPeYKtF1m?=
 =?us-ascii?Q?Ue4yWtvaNRRZ/BlRGAmKGS2r8P+2JjsQHZnYHy0bGA/nxW9u7r+iJ9yrHTa1?=
 =?us-ascii?Q?JM+eB1MyNL8Ncv1Mr9LY4x2IXIPSm+iQgKfjUnmRkdF+6Y62TLv3dja5nRwQ?=
 =?us-ascii?Q?tClVSgmVXhXmwN4VZdQAVoWMhltVZLncGOVxXXH2WcJP5UNjaom+N5m8k8Zz?=
 =?us-ascii?Q?1N19hH6gzEoxfX3GejjvpaxDZNwwATpJwSxe1Y1Oym8kJ00R6qM+Rp3x1gJn?=
 =?us-ascii?Q?GgjpQIQgt01xhw7xzCGgkUZjmaytRsrx+KA9chjI96p9x1V/IqfKKOIeku4C?=
 =?us-ascii?Q?aH5nMa9f3jDGXIcD6xsSHPHGt7iHArQPerzwl2/ePa6JlD2SsMVSVmxreM5R?=
 =?us-ascii?Q?PKywNvm/AtRwPXjfUPhRxJasmMpTjFHKWFiW7ZiBLXUbF5C7w8njghOhwFer?=
 =?us-ascii?Q?rmgiLIH6CmmkXZFxMmnOxMdLPyV5U1IYfK3u9yAeJv37TnhVTOmLhckaFq1P?=
 =?us-ascii?Q?C8w5D9c6V3bWKqctle3NL2SPdTHmJU058Yd0o7Do3auRPi1XFSd9BTCPUdQD?=
 =?us-ascii?Q?9G3WTEHXLFCfJfPoieybmEvYVUsybZmciTAZz428f2t7Tc6MG0UMRjpckbQw?=
 =?us-ascii?Q?6vq1Ae8yQYzEjBAtnqKmYVhSkinC+q9+FxJwD6HZWABxmXMXXrlas0BX38GD?=
 =?us-ascii?Q?0RCP+6Xi2mKeOm2DQmWq1Khgq6n/DwAPE5YaCVweVu9cC5g7mRZ1OnvBSk3U?=
 =?us-ascii?Q?9wy5p4FUaGagSgAs0EK6+xMRN5cgwFbZhlpwkiecZeX7rw3VwRaU9nrXGQWU?=
 =?us-ascii?Q?J2URukJc5JDbU5bgwap7t7b7kuMKFfl511zU7MDSxatnGdxyK0BUuf9kZ8XN?=
 =?us-ascii?Q?f6n1kGVMEKVG3t8kExGcv4lhX8dz/PaCz92Ifj15gFBP4eZIgpa5E1ffciRf?=
 =?us-ascii?Q?Zp/cOuRrw0kjhJvlZSMwhA/YC0shRCSISUQP9hpG4HWVZ/XKTmMc6IuqXjp/?=
 =?us-ascii?Q?RMi2NQcdZmvgRFYBpUpzB8GrRqOV16iJWu1YEX6N520PWmWS8y85TxA0eFDY?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccdac43-9ecc-4652-d8e0-08dcf51aa8b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:30:02.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3SLVBDrLX3YgC/x7rv1oPSicsHzKA36DYjdfH3ST/bwRqc3XUCUUM13Me8XWOVcJ8GHXATjwjVIHqs3ynId+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7644
X-OriginatorOrg: intel.com

On Fri, Oct 25, 2024 at 06:06:47PM +0200, Nirmoy Das wrote:
>    On 10/24/2024 7:22 PM, Matthew Brost wrote:
> 
> On Thu, Oct 24, 2024 at 10:14:21AM -0700, John Harrison wrote:
> 
> On 10/24/2024 08:18, Nirmoy Das wrote:
> 
> Flush xe ordered_wq in case of ufence timeout which is observed
> on LNL and that points to the recent scheduling issue with E-cores.
> 
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
> 
> v2: Add platform check(Himal)
>      s/__flush_workqueue/flush_workqueue(Jani)
> 
> Cc: Badal Nilawar [1]<badal.nilawar@intel.com>
> Cc: Jani Nikula [2]<jani.nikula@intel.com>
> Cc: Matthew Auld [3]<matthew.auld@intel.com>
> Cc: John Harrison [4]<John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray [5]<himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi [6]<lucas.demarchi@intel.com>
> Cc: [7]<stable@vger.kernel.org> # v6.11+
> Link: [8]https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> Suggested-by: Matthew Brost [9]<matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das [10]<nirmoy.das@intel.com>
> Reviewed-by: Matthew Brost [11]<matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wai
> t_user_fence.c
> index f5deb81eba01..78a0ad3c78fe 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -13,6 +13,7 @@
>   #include "xe_device.h"
>   #include "xe_gt.h"
>   #include "xe_macros.h"
> +#include "compat-i915-headers/i915_drv.h"
>   #include "xe_exec_queue.h"
>   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
> @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *
> data,
>                 }
>                 if (!timeout) {
> +                       if (IS_LUNARLAKE(xe)) {
> +                               /*
> +                                * This is analogous to e51527233804 ("drm/xe/gu
> c/ct: Flush g2h
> +                                * worker in case of g2h response timeout")
> +                                *
> +                                * TODO: Drop this change once workqueue schedul
> ing delay issue is
> +                                * fixed on LNL Hybrid CPU.
> +                                */
> +                               flush_workqueue(xe->ordered_wq);
> 
> If we are having multiple instances of this workaround, can we wrap them up
> in as 'LNL_FLUSH_WORKQUEUE(q)' or some such? Put the IS_LNL check inside the
> macro and make it pretty obvious exactly where all the instances are by
> having a single macro name to search for.
> 
> 
> +1, I think Lucas is suggesting something similar to this on the chat to
> make sure we don't lose track of removing these W/A when this gets
> fixed.
> 
> Matt
> 
>    Sounds good. I will add LNL_FLUSH_WORKQUEUE() and use that for all the
>    places we need this WA.
> 

You will need 2 macros...

- LNL_FLUSH_WORKQUEUE() which accepts xe_device, workqueue_struct
- LNL_FLUSH_WORK() which accepts xe_device, work_struct

Matt

>    Regards,
> 
>    Nirmoy
> 
> 
> 
> John.
> 
> 
> +                               err = do_compare(addr, args->value, args->mask,
> args->op);
> +                               if (err <= 0)
> +                                       break;
> +                       }
>                         err = -ETIME;
>                         break;
>                 }
> 
> References
> 
>    1. mailto:badal.nilawar@intel.com
>    2. mailto:jani.nikula@intel.com
>    3. mailto:matthew.auld@intel.com
>    4. mailto:John.C.Harrison@Intel.com
>    5. mailto:himal.prasad.ghimiray@intel.com
>    6. mailto:lucas.demarchi@intel.com
>    7. mailto:stable@vger.kernel.org
>    8. https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
>    9. mailto:matthew.brost@intel.com
>   10. mailto:nirmoy.das@intel.com
>   11. mailto:matthew.brost@intel.com

