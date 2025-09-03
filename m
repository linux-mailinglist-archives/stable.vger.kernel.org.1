Return-Path: <stable+bounces-177670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23133B42C42
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D871C215C3
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEF2ED845;
	Wed,  3 Sep 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQ0TBjHh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B451917FB
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936534; cv=fail; b=YlWAySNCgoPBYrZah36Un8U+TS5hkjuF2hRT00hRH/33DkHB1NiTMMPJxc6T18iZVjpiPGrLUEHeoZxxlj9yInH1g0MtDLTPz3Ebn5NxuKL6TyGaS7sJ3FLGZsh1rFtNmFBboygmNlSoCDlQZRaXOI3sKCJ3uSzJyFmXsA0LZkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936534; c=relaxed/simple;
	bh=G3YWNY3UiO8I5x66MCq2bqRZ1hzAFBYcH2bV9VcDFtg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SB/lr1QHmQe2SAk4VNSmaWeTaW351sAhy7jqp83JEfC2tX6xzapWc8KB3lH5rXIZ9tT7Yy4SpUXkXPPhD1x10Oo3H34Xat+x5EOuHg7Qza5aBazg4uBJhnNGaICvAGc1riGnN/7/1oxDmcswl4BUocuxOrFxiqdnYDzojsPv0KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQ0TBjHh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756936532; x=1788472532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G3YWNY3UiO8I5x66MCq2bqRZ1hzAFBYcH2bV9VcDFtg=;
  b=DQ0TBjHhRH1xrysofKtrE4RRkVzL3tGjPQohAUR+DqF1oGYOnR+xv63k
   JzRS8DWoJ+lyXimyQQZCNCUA68TOLpe/Knk4ttSM5rQg/B/CJRopkMIyQ
   Kf4s1A2SOHV6hXhCi/DV5fjyseQK33xMaNbAj1iy4SyIrHSyYwb9ETFh0
   btppORxd1g4gUMRubME/+DnHuPysvoE6Mzxoqv9X7G0UGg801dbUhRY08
   XlMAcWC9qyF4vf2mNmBs//zUwqiw6yxhX2GelUOtktX90QCJD+I9ZLTyZ
   H3rntV+ik5dVfYwlbLDdWq59dBTkrSv6SJ2QlKIOiBJns3FvmWC/xw3GV
   g==;
X-CSE-ConnectionGUID: wSncUsaVQD2IXOk9k9Z36g==
X-CSE-MsgGUID: J6A3Sjp4R7SgVhrPK7li0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58963603"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="58963603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:55:32 -0700
X-CSE-ConnectionGUID: amqqQStoS4a09ATNJw8q/Q==
X-CSE-MsgGUID: XUHzGD7VS4mkoz15hGHaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171838298"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:55:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:55:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 14:55:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.45)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 14:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuTE3BrGkidzAwVs09hfaiBjaWIFqp5T9flSXV+lVyNpEq5DWRzPkhknD/ysd9shgdmo343ekUhK+93q9N6DASVsUcSKYaVyjUuleIv34CZ261KERnN/LH23eY1yfzyOr379XK45YTUvwgGpPrXDAgiLSBR7GlBM69suLqt3Y2m+6auIXGKLTFr0Dm8Qd2gSol3ViCUMVhDyqgt7XGM9dpq3D6QTCq6qt7b9SYuesdLfu3PP0/UuJBY44cs0986iIs6mAvUKwXUkiBtlILgPk63t6772te29IuWJyIUogrdhHZ4ZkH68ch4nHNpnmRuqpbg39rz78Fn5dM57j1F1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3YWNY3UiO8I5x66MCq2bqRZ1hzAFBYcH2bV9VcDFtg=;
 b=qbED6Hx+xUb0eqEwycO+fJol4UqKVXz7+jiokLNCDQOd5AFYvpMSET2KAwF+4tPU1/kVBV3z424Sn2bHkLZKrUwWZ0yrrZQettAh8mi++kou92FLgAjnay2RPNz3Wdh+orhe5hwPodIqJ8ja6+li0dsh9v3OXhvXWdANXLmCxMPyRxQD18j3BPQh6tCLVvC+bPyyk0CKS+AzjtyP+pWdMxW+K6/QY+ngm7Zin6MxJ9FAC1T+90GNCmaUhCtDPeNCfXMCe/tAVjPM8Yu7VsySIucIqrP3fF5V1Yw/UAjfEh+cDS0fW23XkgjK/ug1Y8i0v7a+Y+vXw+OdE5fxEe5GNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 21:55:28 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:55:28 +0000
Date: Wed, 3 Sep 2025 16:55:23 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Julia Filipchuk <julia.filipchuk@intel.com>
CC: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Stuart Summers <stuart.summers@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
Message-ID: <tqvpelahejszg3jruouoo6crcfqr4uz45ni7t2mcn3477gpcvm@bzgvywuo4zzw>
References: <20250903181552.1021977-2-julia.filipchuk@intel.com>
 <20250903190122.1028373-2-julia.filipchuk@intel.com>
 <2cc4dece-7bdb-4fdf-a126-d9e311ca74e6@intel.com>
 <52d8cd5a-a3bc-4ffe-84c6-4facda290cdf@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <52d8cd5a-a3bc-4ffe-84c6-4facda290cdf@intel.com>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ff8246-04e6-4781-6886-08ddeb349836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bWASM6vyVHdrS21k9nRZsuE3ofHwhoDITC6Sgermkq6xAbwsenJ9VJ94UhX1?=
 =?us-ascii?Q?xxQ++Ffe4Qb7YZrWPIy+jljyIPP+vBXwuUjDlGwf33XjuKnZz6eyUiRjxk1u?=
 =?us-ascii?Q?yJ8H+bGH6Lc/bVYYHWGaM/2L4T303tQSWTtMrJGdHZAxdVELHmHLUFKlB6sI?=
 =?us-ascii?Q?Mu8cZlqPuNHdppSf+QmZu7AffqXK0eyuqlK2mxEm4LYt7Y2qemviiAn88VgG?=
 =?us-ascii?Q?h73X43RcBlxirZGMCu80tV8+thdbTSVHhbrQA4cHOIGIgMZ4SJ4HyEzwpNgs?=
 =?us-ascii?Q?XrrujBZsJxRBhSJGmCCZmcCEKcNlM4/+mZ6u1ohA13bkiSJYiuqlKXtNXWji?=
 =?us-ascii?Q?joSTrj0cbGxUkA/P3QZ1qyQdSerLOcRZR+GXkDqveZwcW7ROpJWManYholMs?=
 =?us-ascii?Q?8boggWhOvYAF0Y358ugNozW72DFCucHv8mE1i0LPmb5VO2wJamyXMpgDvuJo?=
 =?us-ascii?Q?BWEP48ern4PRg5uE72+fO6gl9Nzj87yonBxliH6klXD91T2eQbeoOiRnqe6I?=
 =?us-ascii?Q?niz++bURnb1HINvC+6N9sMIroNjv1p8NHRobIQj0lzg6ZvTsPZ38qLR5FB0C?=
 =?us-ascii?Q?ycBzaI6m9OOt0yB5r0lKS8A1i5Fz1OM0v2PaBiGqp1b9fQ6x8ohww/1r2uu5?=
 =?us-ascii?Q?+D+Wh/+Vwwv2mRm5YplXpvAD7cjvd+bxEb6t5xLiU4QwIMPKn/4xinKLerWY?=
 =?us-ascii?Q?taFIvciRFlLWMZq+tn7QSKsqQnPMAIohq8V1M2HpHwlNHLZ28Q8bHbmW4kc3?=
 =?us-ascii?Q?HYR31LUHzCcGqxBbF9VJBlINqCC8PorhEjMfNNdt3j0weyLbrDGorcP3beeD?=
 =?us-ascii?Q?jP+Q9+USxFjxKPoQEpVyOiwkwmr4d4R8xL/M66LYXShsqM4lagrluzfpG8wH?=
 =?us-ascii?Q?MymqIaaxSkNDWXxjPFgPwvAsQ0dYl3CptXBOclMes6ECwObkpzwX+qkortjC?=
 =?us-ascii?Q?x3V7ZNukqtUnks5VnEhUtmNI8QLLUdIVcZ/r/IzlMPby7tJ+YjGvmLOi0os0?=
 =?us-ascii?Q?cX3yyeGtGzBwAcU5+gXIh/3nRReXaFbvK7tbrWQnaFMfdkyOW7jTGzVKfLje?=
 =?us-ascii?Q?6PYkMiH5aNDNGvPzEauIDTie4vvHGLuLbwieZzWlgaUx3AvhRYic9vFnUDpQ?=
 =?us-ascii?Q?TJdq/PxXGQrQZt9iikrZMGYQZDZQ3X/BXXi9Q3+OybpD9dbAYQxZk2XoIvyA?=
 =?us-ascii?Q?F5534uwZ36on6KM7fLTen/X83E16ZryjJALrV0eBpeq6meMY0LNmeBNSx26U?=
 =?us-ascii?Q?nbpbmzZKNxwmp5G7c2oDAmfiRsQrnyO85w3ArsnwJdL/Mn3kXZXA/QbC6K78?=
 =?us-ascii?Q?5I5LOd2pOUG0mXMNPHDL0yynyIT7Xfsxjwc/G3twXLyIq/uHLPUFhjGk4ocj?=
 =?us-ascii?Q?OuTEanG4EEWbx9pUrxF1lQPUNgYfjsZmT+XRBMTbidIcf4xoBplysC6jDXL1?=
 =?us-ascii?Q?Ba7teK5KWuQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXS275v6hkNZpSvwT8rgtjGSgsH/EeFgxfweqNTQYDCm3l4XNa7ZZIz8tFDP?=
 =?us-ascii?Q?EpxaWvM1dGXjUNsaGBhOV+fiaTHPhW6uU7wl0LfpFgYDdqkevTh/BEHwOPTx?=
 =?us-ascii?Q?tLEKMs1IOqwfPGnG84FqxKeD8kKbpMCAGZtKi8ABDWHKRdngi7Kknvzsrzc/?=
 =?us-ascii?Q?aUmT4dStFDcNGw/zl/CEoj/gYtksy3eL2hfN588RCGv/3tQVCOKf9z2iT5vK?=
 =?us-ascii?Q?nz3iE56KRbKxVEq+DecExPymEixAgII32/Js8aN8opfuZW+Ox5XB/HimTc1/?=
 =?us-ascii?Q?2HMAbXFRzf1Xb77/ZW0UURn7bWrJhN47faj7o/mosOF3dfDhOfOFC7gR+cV+?=
 =?us-ascii?Q?llISbNLoT85MOFDyZqJPKTH9lFcWn2GMKXj1NfqCy9jjQKRbyBwX5HuRu7m6?=
 =?us-ascii?Q?5kC9z4HcTwa3CST+GT0r9fY2Ugt4JjuSduKv+Km1+0A+D+HZviozB96Zqana?=
 =?us-ascii?Q?URiiH5m0spS+k+o/6+f8/X9ruMjbnL96A7r3bILm/sTHLRf9S4TSdGxKWLLd?=
 =?us-ascii?Q?S32DTJe+qMsQ7oahwNk4jDtuScM0QRfmwODHc4J0DDcbak/SwLreHIHwvfxf?=
 =?us-ascii?Q?7UvolztcJXuwEwdAEFpo2x1gFBtVbundrF+GUKmZGFCZe9mFs2u7KlB5iTZX?=
 =?us-ascii?Q?9KlFqKGESqTgA8F2R3Iq5yLYnwQ2Yaers91aa1qiVJ9QWI7aAbGM+6Ku4E2l?=
 =?us-ascii?Q?GPhK2sjBRcJ+jx8z4xHD0spjf5WdRZLEMzdR1McIA9eT+ZyXAUbXjhuIUXk3?=
 =?us-ascii?Q?/TF4nA9qegNgLTRZiaORFiI6Ea6+BZD+I/toyI1T2pr/WGExhuqI2kvwljxf?=
 =?us-ascii?Q?J+Ah5GpO/5GTpbQreHexX+mxIZl3UAmEgEBN3BHdYOowBLX5PyMkQKKR1Rl9?=
 =?us-ascii?Q?T127SdBl2yQ6/PatH0jrtxMVX3QJOZNIIZXSaGI4BTftCrfmLjKf27Xp4Grp?=
 =?us-ascii?Q?DGZ4LKhOCEygHimrK8CrZ8UI93CQtytJ+5lgHZedEHS73hvU1v/x1nYa1YdD?=
 =?us-ascii?Q?SVDYpaHuL2o2jR+ZctK4xHM6iDPKucEQ2cEcAjI6JDyG/NO3oj5PULsPzhcM?=
 =?us-ascii?Q?Hurxl0Xo6iWNwE2HQBTYFKTaihbZjIRnr1utInDUzXr0bY0GBRtcc/BrVIPa?=
 =?us-ascii?Q?8gkWX78tijgaZvXlp56nMryECD7gzS3iwgAVuukb6MCrDPk0njxJZUbyM6Qz?=
 =?us-ascii?Q?L8JWjDMeCCA1u+CuwojY5ycwXJInwluCWwjyD13yrgsreAIn6439mF9BMDTO?=
 =?us-ascii?Q?JVhVdPgLcN4T70myxz6y3ksP5k20o9HnE6CT7XczSA5WLw2q9UnCAN/uHEX2?=
 =?us-ascii?Q?dR+ZcbVPBU6yJgTGStQ7Lid0G0vMa0suTFHJ649UOfIiRVQi3uh6x0cHntP5?=
 =?us-ascii?Q?WduQIMd2PSAWzzKwGKQ5yOdpDaFI2pFJstJxiRGE1lzUFjPTcHqO1MdyGyvS?=
 =?us-ascii?Q?GntNyiSPwcZWCB0MpFLxDGIfLZLsMD0qmZ86HbsU3oUuuZer7X75aQLgTLD0?=
 =?us-ascii?Q?A9ke+uONl7ZQc/rD4R7POgTtYdr/WtjZzmgnlwDBgswwVCc71nF7v9g9cWL1?=
 =?us-ascii?Q?sr6+4rumdW+JDvDaLnL5S8a2Oc4D5f9hHnwGdRx5NcPWcOYaSVqC3sNUELyF?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ff8246-04e6-4781-6886-08ddeb349836
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:55:28.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu1bR3lMTfVKlVkLf2VuzYzQxwh79eiiKiBtzC9bY0uNMrkxu3iZrgI9HlJwzbC5qY3cVC1cgxk+Dj/Dm5nmcBQ3w4SGv4bqFAYQcKRAGEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

On Wed, Sep 03, 2025 at 02:29:54PM -0700, Julia Filipchuk wrote:
>On 9/3/2025 1:28 PM, John Harrison wrote:
>> Does this count as a fix? If we are just extending a workaround to apply to more
>> platforms, that is not a bug fix of the workaround. It is more of a new platform
>> enabling patch. Indeed, if you send this patch as a backported fix to older
>> kernels, those older trees might not support the new platform. Which is
>> therefore unnecessary backport work and extra confusion because the tree is now
>> claiming to support a platform which it actually does not.
>Possibly not. Just intending to send this to the current mainline 6.17 with
>backport not necessary. The workaround would still apply if ever loaded with
>older kernel.

Rodrigo, once this applies without the Fixes trailer, can you queue it
up for drm-xe-fixes?

Lucas De Marchi

