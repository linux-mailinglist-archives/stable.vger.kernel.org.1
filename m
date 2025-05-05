Return-Path: <stable+bounces-139742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE400AA9D14
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8CE17AF92
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C41DB546;
	Mon,  5 May 2025 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUkLbuzq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB233E7
	for <stable@vger.kernel.org>; Mon,  5 May 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476253; cv=fail; b=muwz81qOIcxDC1ZGJPodqg+XMZPRoW7V9AnrFUuTTygwPF9y9C2Eu325DbMgP5/aDAs9V1H7C0I5yfUeQZc8pkDfGF4ad+/f81Xauw4i24iFbwGJsExJIyWv2bpomliE20qrmMOgNZvkj+v/AI4YF/vpM6fJlb5pGlIARVg+5iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476253; c=relaxed/simple;
	bh=HC5IBwpKES18PlmQCzYW+feypUn9QGZ1FR1VZVova9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ijuhs7Jc9lA4Wo17Ed0mSLHzLhjjHMsI54ijwuE4dcmOQVZpWyocq8IVg3cargCJrPYp/nRYiDbX2C1zTbwnExyMYa55+KEk4nywX63ZOskIKqlipF+9xiYCuJCIBjWWZBvyMge1KoERk1FOBDBMDjeXtyFiGC+uQ48mxG2+/NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUkLbuzq; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746476251; x=1778012251;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HC5IBwpKES18PlmQCzYW+feypUn9QGZ1FR1VZVova9s=;
  b=NUkLbuzqCbAIbqcueEUH1bNux/vmk87Yj5IWyh5cAaQXuKVBw3BUVv3C
   x8JMNVqmgaT5R33Z7MNeSELuURvh11yAVqmZbPh1egE1qRlu0gG8M+ekZ
   kOVVng22ItHXWtt2Y1k80iwWNr3z3r/8ayGBQXkNBg+1o3n2R7k+s34QP
   RraxVRNVxmvOOQ0gDnx29bIPRAkjOqMlv5cxgIhU4IapBv43yhGu3NHB6
   Jtsp6E1mBQI0ai+5YkMfsxtQlzOh782l1epF/oyQznsIwWTMorrNzqeIp
   x1d4dGbQ1OyTL7N0ju0bIIcriuCNMK88F5Lhw9x6h6hMDmzjxIFcV1zBV
   w==;
X-CSE-ConnectionGUID: mqqpmGNqS3CXtK8hwvbXeA==
X-CSE-MsgGUID: bPsJ3XuBT8eoCBSB+37fGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48005890"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="48005890"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:17:30 -0700
X-CSE-ConnectionGUID: h9TGS8M8RBugTOP7t4To9w==
X-CSE-MsgGUID: 64nkiyFfSXSxGjNjODqe+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135868838"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:17:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 13:17:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 13:17:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 13:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2ePT9JESeSllNL1tUZwH63Dwbb1L+cp+Yo/SiQ43LFlc+rOdzUBVZa0POYwZRxM1y3jJtFHpU+VCBh1kJamQ4oFHm5RJONdu3kknHKjBHEbPDMU/vDoRAjvl9WP/GUDD6w/gcrjjZnNh3Lv/ZSUSNF5pbHhz90BAC1mMntYPzTCye36DSFnyC2FMP3ZuKbu4G+iwkdgcr60+GtDSG1mhP7nhFgMcts0sjCNV9Fq3yW3KSx3zumTDE0twDyG1HzOcZ2YezH8dQt4ahMYGEnLzMVu0ONuyOp9+Qrx+JvWPX7rBWzkmcGeSe11rKxXeFWa/LNUF+4mpyJRabMTnGiPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZZojd+NYw6sS/LEUxs155kKy+ryF4m5/MkktXsGSH4=;
 b=oTsAnEuvH6uQF2h+mbeiM3Hdx9dGWm8ThC5q+1aQfrhEbTvlWYuDrskEKZfbiaJVlVm2IKC4lsC8VhWXxj/4HoENu/Yh6D0o9M2nDWLPzUbTI+zNb0fcRalmZTmgxKUG4ndUr6BMeB0vjRno05ts9mOfQwlEqO3ShC2I8lCr1IQdtSZSV3T/uFO7LR9RAFR9+qayYvQr4Fj/638FPrnd+qtE+4oGbzE8GTrCmGvgRe11foMoJBIKHwpPspPBp2Wmp6FOJY8mgBGV03soceCRgoOPmRfr71XbotW9Yr92wxbmZDJFfJi1KW7NiUhvNoaTvzVfnyxXYiSz2le+/Ckllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7578.namprd11.prod.outlook.com (2603:10b6:8:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 20:17:26 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 20:17:26 +0000
Date: Mon, 5 May 2025 13:18:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v6 02/20] drm/xe: Strict migration policy for atomic SVM
 faults
Message-ID: <aBkdKgkLcvRt6grB@lstrano-desk.jf.intel.com>
References: <20250430121912.337601-1-himal.prasad.ghimiray@intel.com>
 <20250430121912.337601-3-himal.prasad.ghimiray@intel.com>
 <0e60fc015731a15c9cc9b3eac2959c693a52f2d3.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e60fc015731a15c9cc9b3eac2959c693a52f2d3.camel@linux.intel.com>
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: a50f272e-c5a2-4bef-ddf0-08dd8c11da18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JUqN/cRs2+RlPfWZmmvpOvkr/2CpXc+mUSI70450zwP/BYncmt8RKHWS6u?=
 =?iso-8859-1?Q?x6tcH3/fvvyGNGkeD55+KWioPUUzHE/zwk394IxFo17wOni/7Iau9norcG?=
 =?iso-8859-1?Q?23sNIZQCcb/Y5uI7YMTuO5IdCD/aGiM0+ku/3qCVpSLcc0ae6AuA1GQ5LQ?=
 =?iso-8859-1?Q?fDAlnaDeDKi9VZlHrLBWtFueNxgEqOHYtrwXwp8wHTzLAFlN0RxHMP+JY/?=
 =?iso-8859-1?Q?20e7QixkUaY36OWTnRXnM9W6GeowHzTahmL2c/SVBdRKvDfaEUqH6efaHD?=
 =?iso-8859-1?Q?8LojMmJIGJSWUqp7e1ZwjFbU1To6TbgI20MIJgCH05CT7eFwfJsQtKRSlF?=
 =?iso-8859-1?Q?BAoBIgU/5STgHByfsmfeac9ul8TMl+sAqybOaxbwGQhQ1K4/9/SIk4YeyF?=
 =?iso-8859-1?Q?d+IwtUo2RC5L2qAvXDb+SincLGxW8ldWBoZPgertXZMWBtLiUatIzt6cIO?=
 =?iso-8859-1?Q?sGhBJK2O2DP5y6SLQ6Rwz/zSAjnPz2B7XMJ6gRkoc3pr14wUqdI4jS16QB?=
 =?iso-8859-1?Q?h4r+HHfzf9Y1LlY8dUgBtfuQsKStqgJnUmqz0L4HMEo+Zf+qFQE9rgtt6H?=
 =?iso-8859-1?Q?CHa8AFK2uzKo9v/0COEgOcIpOTpQZv6ZxzdHQLPrqyLC9PE7x4ZOGerUQY?=
 =?iso-8859-1?Q?Pt3SZIcAkMxyKtXcWD2eNwjV0UhR9W8UTUmz/oli8GABV82qTD+lIBScZ0?=
 =?iso-8859-1?Q?DRzNMpN3iwaL6g3VhD4u82VMN+nee2Qy98sZc2nw+bBL3Qt49GdJUAkOeL?=
 =?iso-8859-1?Q?vFCS/Rn8Fej6hbdoYMMK8RvDURQtmC/TX/XZ8ZTXVMykQIUzWAM2uHPMK5?=
 =?iso-8859-1?Q?hdKFlR+SI9c2OvTOPYRrjO+6NdNCEiG3yQsmdVEzzEYUTvijg0V/DMSiTZ?=
 =?iso-8859-1?Q?D8L9PrPQQBrdvslGqDTMP2RGyGHNlOkHI+I3Q8ZyKXO+HuRtcie1I+MES8?=
 =?iso-8859-1?Q?tXXaSuSQ5ghVq/UVMDxnr7wW2WcZEWPP3xXmLjo0cbU9VmKgYopfnFcVxw?=
 =?iso-8859-1?Q?tWxx+IuP27XohHK4pZuL0oJnCcY045ej7X+BHbUjn+YLWY6Yaywo/8TjcG?=
 =?iso-8859-1?Q?iyM1E26Am+gAaymaG6Tzzfs0aSpHhx/cXIFywDwqfWlcAdWqGAdNJtCnzL?=
 =?iso-8859-1?Q?rtBvkS5pzfGoeY3lSAQ1IXYbNAzdsxegKi6tzU3hl834gsYPyvOGxP3gw4?=
 =?iso-8859-1?Q?cg2YlrL9K+D9+OA4y6oSzIXDzfis+YV2k+KSx2XNwdf+T3iPuvFXvVAyI6?=
 =?iso-8859-1?Q?ggmzcRNxVUYWip3cnvvX5wRppxveQNk7pneq9olXal0gohj5uuhDyF38WM?=
 =?iso-8859-1?Q?DqSxZIKPSQpXVGLNTrbhh7gsDThclRGBDydxh0Yol057sKV0I04m/xSqQV?=
 =?iso-8859-1?Q?HRjXIsZz4dLA8KSUy0Z5AcDrueiH5oFryXcWfIplK50ULJVfhteCSVpaRe?=
 =?iso-8859-1?Q?2I6ENU2PoNxF5yD+yFwvDDR2Dnsvj/K3VM/jGjKXfrJG+SQoz5KJpkW8Th?=
 =?iso-8859-1?Q?8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M2AYxu9tD1sjPbapDEj4mwvNDeV5VTw2gey6mMILtRDO9L6a+hEpuFBSx/?=
 =?iso-8859-1?Q?cAvtXCp/uS3xBg4Za26FE6F6KOI/eCxY1bxCUfY5mMT0wqXkVOlO2jle3F?=
 =?iso-8859-1?Q?mitVsxdI4/0rJYxfrNW4li2WKbOfhoeSBVpx8/PBInhZL1SdR5hpOIYLhr?=
 =?iso-8859-1?Q?ZV8yPbaEDXeTVV92e+mCPvjMU3DylKZkFC95rX/wRf93d6n3tVOr5cjN6g?=
 =?iso-8859-1?Q?CaMq5mVjglJ8jSgDsrcm8pmfEscok2mfi4XLD75WbNz1RRp4YZC9Bzo5La?=
 =?iso-8859-1?Q?N6yCY7klA5+LjqZi0arb2UdCs+EYH1pQb7JcXH9C0xLnCa1t3/YJfS6uNt?=
 =?iso-8859-1?Q?dFEAk2q9pJeW+V62JHu5kTlH6/pvwrW7F0c2Lv/zHR3P+wjIxYNJQO+Kt6?=
 =?iso-8859-1?Q?QmYvfnzzop2LeuTFmb8Nzj38wnkz4DaQ1zGuGwRBbi8dl/YwZnWrZ7I1f9?=
 =?iso-8859-1?Q?biDAA7OgcWs8cb4LLy6hLpKouLbl+wZIyzj7sAGOr1/SMlW4W1Y03M7kzR?=
 =?iso-8859-1?Q?GKSA3ZNlfFN81deXDModlh9ydjhTJrFxV0+FA6WsJIWiX9OCaYqTuIp/bd?=
 =?iso-8859-1?Q?Pbyj8eg4Y9Uu4u8Y06bwkOuFJ13LU5AI3tapTC3Hd8KxjWTdVMqJt3WmCc?=
 =?iso-8859-1?Q?CcEGb5dyu+rI85QsJwrDB/WMzzyGwHWVhU8PP3Zjn/g0AEKxw3qZ5YyftR?=
 =?iso-8859-1?Q?8qWYPRMWb0agBMVRRYK+1KudcNA4eLVJjK1ro2CKikZOxApvNtX//ctg9m?=
 =?iso-8859-1?Q?HymhsxeY94JEkek3BQ2buErCMOa8OeEEkBxubxp8m5hDgwTASM+WxHyX0N?=
 =?iso-8859-1?Q?IH1ag4qXzCb6DH8D4fc+0KusL27ERQ0W1Mr0MDeONHXh5AQS1WE0g1m7DM?=
 =?iso-8859-1?Q?MJ7mXJk39rR3U8XBYJavXZA2PFbvRSW4Pe5swZpmsgEaFjeE3Ls7uJt2MZ?=
 =?iso-8859-1?Q?1IaDdFgvwrIJt4safXfYJq58L98aWVqGEDjPW+oNUzyarmpXOTlXLt9o7f?=
 =?iso-8859-1?Q?Xc1yp+59TO0dH7QA2rSE5zexlyv5YmRXzQSEbERQ4ELVsLp2HL/zDdWbBq?=
 =?iso-8859-1?Q?YfV351UlBC8zoOWQhwvPeWsFTqugGzXbac6v9Gr0Ne9/BFFF2KDR7iFYaQ?=
 =?iso-8859-1?Q?G9zBtboZrBHESLR11GeU0T8SfaxdcF7ZLSJuOQKcuE7vvjONnERObkfHzK?=
 =?iso-8859-1?Q?tQcgB/tySwDHAOZZTjF1Pymmt2w/B/P0l9IbVt987MS5SwgeWZPJuYbuF+?=
 =?iso-8859-1?Q?WYunz1mrCrkL7jl22tiePm+qPuJ1+iuiblAix97ijrxRGexfX8N2/NkuPv?=
 =?iso-8859-1?Q?fRoyZf8BUCYDOSobW/RQfQ+KXRSDjO7M8J+x2c8NisVYeIhPoensJnRuJo?=
 =?iso-8859-1?Q?5Xc6ZnEalzxWh6N2NeKWKuCuFs23O7Nm9VAFT7ycpJo/WAc8oq7sWxHZfh?=
 =?iso-8859-1?Q?e4SA7nsRSjkW2lUHY4PrjEUdm8l2thNe1pIbApckxght1HIuIDXn4pMaGc?=
 =?iso-8859-1?Q?xO8dUuGH1OzoIK5FOcyF+RT7pOp06fNdC3RI5RrrJ9L/QSNZUJhi4hu4eh?=
 =?iso-8859-1?Q?qVC8QNQZhrizNSVNUcKWEqV7KVqgKoAYuAIRQg3SlfR41+WYwTrj5b6goi?=
 =?iso-8859-1?Q?Cx5kQar5fHjgH+NlXxKdhFcY+Ni9QfBmNwkXbkLzb0gkdXA/zZH2UHpw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a50f272e-c5a2-4bef-ddf0-08dd8c11da18
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 20:17:25.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8L/xzmPdHDKhDnBlo0Cz8xlGILLSP3h2yvcjT6L77bWqwnuDB7eSqZdNsrmvgH/rf+MfpCwXySXjBbpVsZtFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7578
X-OriginatorOrg: intel.com

On Mon, May 05, 2025 at 05:20:00PM +0200, Thomas Hellström wrote:
> Hi, Himal,
> 
> On Wed, 2025-04-30 at 17:48 +0530, Himal Prasad Ghimiray wrote:
> > From: Matthew Brost <matthew.brost@intel.com>
> > 
> > Mixing GPU and CPU atomics does not work unless a strict migration
> > policy of GPU atomics must be device memory. Enforce a policy of must
> > be
> > in VRAM with a retry loop of 3 attempts, if retry loop fails abort
> > fault.
> > 
> > Removing always_migrate_to_vram modparam as we now have real
> > migration
> > policy.
> > 
> > v2:
> >  - Only retry migration on atomics
> >  - Drop alway migrate modparam
> > v3:
> >  - Only set vram_only on DGFX (Himal)
> >  - Bail on get_pages failure if vram_only and retry count exceeded
> > (Himal)
> >  - s/vram_only/devmem_only
> >  - Update xe_svm_range_is_valid to accept devmem_only argument
> > v4:
> >  - Fix logic bug get_pages failure
> > v5:
> >  - Fix commit message (Himal)
> >  - Mention removing always_migrate_to_vram in commit message (Lucas)
> >  - Fix xe_svm_range_is_valid to check for devmem pages
> >  - Bail on devmem_only && !migrate_devmem (Thomas)
> > v6:
> >  - Add READ_ONCE barriers for opportunistic checks (Thomas)
> > 
> > Fixes: 2f118c949160 ("drm/xe: Add SVM VRAM migration")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Himal Prasad Ghimiray
> > <himal.prasad.ghimiray@intel.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_module.c |   3 -
> >  drivers/gpu/drm/xe/xe_module.h |   1 -
> >  drivers/gpu/drm/xe/xe_svm.c    | 103 ++++++++++++++++++++++++-------
> > --
> >  drivers/gpu/drm/xe/xe_svm.h    |   5 --
> >  include/drm/drm_gpusvm.h       |  40 ++++++++-----
> >  5 files changed, 103 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_module.c
> > b/drivers/gpu/drm/xe/xe_module.c
> > index 64bf46646544..e4742e27e2cd 100644
> > --- a/drivers/gpu/drm/xe/xe_module.c
> > +++ b/drivers/gpu/drm/xe/xe_module.c
> > @@ -30,9 +30,6 @@ struct xe_modparam xe_modparam = {
> >  module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size,
> > uint, 0600);
> >  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size(in
> > MiB), must be power of 2");
> >  
> > -module_param_named(always_migrate_to_vram,
> > xe_modparam.always_migrate_to_vram, bool, 0444);
> > -MODULE_PARM_DESC(always_migrate_to_vram, "Always migrate to VRAM on
> > GPU fault");
> > -
> >  module_param_named_unsafe(force_execlist,
> > xe_modparam.force_execlist, bool, 0444);
> >  MODULE_PARM_DESC(force_execlist, "Force Execlist submission");
> >  
> > diff --git a/drivers/gpu/drm/xe/xe_module.h
> > b/drivers/gpu/drm/xe/xe_module.h
> > index 84339e509c80..5a3bfea8b7b4 100644
> > --- a/drivers/gpu/drm/xe/xe_module.h
> > +++ b/drivers/gpu/drm/xe/xe_module.h
> > @@ -12,7 +12,6 @@
> >  struct xe_modparam {
> >  	bool force_execlist;
> >  	bool probe_display;
> > -	bool always_migrate_to_vram;
> >  	u32 force_vram_bar_size;
> >  	int guc_log_level;
> >  	char *guc_firmware_path;
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c
> > b/drivers/gpu/drm/xe/xe_svm.c
> > index 890f6b2f40e9..dcc84e65ca96 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -16,8 +16,12 @@
> >  
> >  static bool xe_svm_range_in_vram(struct xe_svm_range *range)
> >  {
> > -	/* Not reliable without notifier lock */
> > -	return range->base.flags.has_devmem_pages;
> > +	/* Not reliable without notifier lock, opportunistic only */
> > +	struct drm_gpusvm_range_flags flags = {
> > +		.__flags = READ_ONCE(range->base.flags.__flags),
> > +	};
> > +
> > +	return flags.has_devmem_pages;
> >  }
> >  
> >  static bool xe_svm_range_has_vram_binding(struct xe_svm_range
> > *range)
> > @@ -650,9 +654,13 @@ void xe_svm_fini(struct xe_vm *vm)
> >  }
> >  
> >  static bool xe_svm_range_is_valid(struct xe_svm_range *range,
> > -				  struct xe_tile *tile)
> > +				  struct xe_tile *tile,
> > +				  bool devmem_only)
> >  {
> > -	return (range->tile_present & ~range->tile_invalidated) &
> > BIT(tile->id);
> > +	/* Not reliable without notifier lock, opportunistic only */
> > +	return ((READ_ONCE(range->tile_present) &
> > +		 ~READ_ONCE(range->tile_invalidated)) & BIT(tile-
> > >id)) &&
> > +		(!devmem_only || xe_svm_range_in_vram(range));
> >  }
> 
> Hmm, TBH I had something more elaborate in mind:
> 
> https://lore.kernel.org/intel-xe/b5569de8cc036e23b976f21a51c4eb5ca104d4bb.camel@linux.intel.com/
> 
> (Separate function for lockless access and a lockdep assert for locked
> access + similar documentation as the functions I mentioned there + a
> "Pairs with" comment.
> 

But if the locked functions are unused wouldn't the compiler complain?

Matt

> Thanks,
> Thomas
> 
> 
> 
> >  
> >  #if IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR)
> > @@ -726,6 +734,36 @@ static int xe_svm_alloc_vram(struct xe_vm *vm,
> > struct xe_tile *tile,
> >  }
> >  #endif
> >  
> > +static bool supports_4K_migration(struct xe_device *xe)
> > +{
> > +	if (xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range
> > *range,
> > +					       struct xe_vma *vma)
> > +{
> > +	struct xe_vm *vm = range_to_vm(&range->base);
> > +	u64 range_size = xe_svm_range_size(range);
> > +
> > +	if (!range->base.flags.migrate_devmem)
> > +		return false;
> > +
> > +	/* Not reliable without notifier lock, opportunistic only */
> > +	if (xe_svm_range_in_vram(range)) {
> > +		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
> > +		return false;
> > +	}
> > +
> > +	if (range_size <= SZ_64K && !supports_4K_migration(vm->xe))
> > {
> > +		drm_dbg(&vm->xe->drm, "Platform doesn't support
> > SZ_4K range migration\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> >  
> >  /**
> >   * xe_svm_handle_pagefault() - SVM handle page fault
> > @@ -750,12 +788,15 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> > struct xe_vma *vma,
> >  			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> >  		.check_pages_threshold = IS_DGFX(vm->xe) &&
> >  			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR) ?
> > SZ_64K : 0,
> > +		.devmem_only = atomic && IS_DGFX(vm->xe) &&
> > +			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> >  	};
> >  	struct xe_svm_range *range;
> >  	struct drm_gpusvm_range *r;
> >  	struct drm_exec exec;
> >  	struct dma_fence *fence;
> >  	struct xe_tile *tile = gt_to_tile(gt);
> > +	int migrate_try_count = ctx.devmem_only ? 3 : 1;
> >  	ktime_t end = 0;
> >  	int err;
> >  
> > @@ -776,24 +817,30 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> > struct xe_vma *vma,
> >  	if (IS_ERR(r))
> >  		return PTR_ERR(r);
> >  
> > +	if (ctx.devmem_only && !r->flags.migrate_devmem)
> > +		return -EACCES;
> > +
> >  	range = to_xe_range(r);
> > -	if (xe_svm_range_is_valid(range, tile))
> > +	if (xe_svm_range_is_valid(range, tile, ctx.devmem_only))
> >  		return 0;
> >  
> >  	range_debug(range, "PAGE FAULT");
> >  
> > -	/* XXX: Add migration policy, for now migrate range once */
> > -	if (!range->skip_migrate && range->base.flags.migrate_devmem
> > &&
> > -	    xe_svm_range_size(range) >= SZ_64K) {
> > -		range->skip_migrate = true;
> > -
> > +	if (--migrate_try_count >= 0 &&
> > +	    xe_svm_range_needs_migrate_to_vram(range, vma)) {
> >  		err = xe_svm_alloc_vram(vm, tile, range, &ctx);
> >  		if (err) {
> > -			drm_dbg(&vm->xe->drm,
> > -				"VRAM allocation failed, falling
> > back to "
> > -				"retrying fault, asid=%u,
> > errno=%pe\n",
> > -				vm->usm.asid, ERR_PTR(err));
> > -			goto retry;
> > +			if (migrate_try_count || !ctx.devmem_only) {
> > +				drm_dbg(&vm->xe->drm,
> > +					"VRAM allocation failed,
> > falling back to retrying fault, asid=%u, errno=%pe\n",
> > +					vm->usm.asid, ERR_PTR(err));
> > +				goto retry;
> > +			} else {
> > +				drm_err(&vm->xe->drm,
> > +					"VRAM allocation failed,
> > retry count exceeded, asid=%u, errno=%pe\n",
> > +					vm->usm.asid, ERR_PTR(err));
> > +				return err;
> > +			}
> >  		}
> >  	}
> >  
> > @@ -801,15 +848,22 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> > struct xe_vma *vma,
> >  	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, r, &ctx);
> >  	/* Corner where CPU mappings have changed */
> >  	if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {
> > -		if (err == -EOPNOTSUPP) {
> > -			range_debug(range, "PAGE FAULT - EVICT
> > PAGES");
> > -			drm_gpusvm_range_evict(&vm->svm.gpusvm,
> > &range->base);
> > +		if (migrate_try_count > 0 || !ctx.devmem_only) {
> > +			if (err == -EOPNOTSUPP) {
> > +				range_debug(range, "PAGE FAULT -
> > EVICT PAGES");
> > +				drm_gpusvm_range_evict(&vm-
> > >svm.gpusvm,
> > +						       &range-
> > >base);
> > +			}
> > +			drm_dbg(&vm->xe->drm,
> > +				"Get pages failed, falling back to
> > retrying, asid=%u, gpusvm=%p, errno=%pe\n",
> > +				vm->usm.asid, &vm->svm.gpusvm,
> > ERR_PTR(err));
> > +			range_debug(range, "PAGE FAULT - RETRY
> > PAGES");
> > +			goto retry;
> > +		} else {
> > +			drm_err(&vm->xe->drm,
> > +				"Get pages failed, retry count
> > exceeded, asid=%u, gpusvm=%p, errno=%pe\n",
> > +				vm->usm.asid, &vm->svm.gpusvm,
> > ERR_PTR(err));
> >  		}
> > -		drm_dbg(&vm->xe->drm,
> > -			"Get pages failed, falling back to retrying,
> > asid=%u, gpusvm=%p, errno=%pe\n",
> > -			vm->usm.asid, &vm->svm.gpusvm,
> > ERR_PTR(err));
> > -		range_debug(range, "PAGE FAULT - RETRY PAGES");
> > -		goto retry;
> >  	}
> >  	if (err) {
> >  		range_debug(range, "PAGE FAULT - FAIL PAGE
> > COLLECT");
> > @@ -843,9 +897,6 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> > struct xe_vma *vma,
> >  	}
> >  	drm_exec_fini(&exec);
> >  
> > -	if (xe_modparam.always_migrate_to_vram)
> > -		range->skip_migrate = false;
> > -
> >  	dma_fence_wait(fence, false);
> >  	dma_fence_put(fence);
> >  
> > diff --git a/drivers/gpu/drm/xe/xe_svm.h
> > b/drivers/gpu/drm/xe/xe_svm.h
> > index 3d441eb1f7ea..0e1f376a7471 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.h
> > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > @@ -39,11 +39,6 @@ struct xe_svm_range {
> >  	 * range. Protected by GPU SVM notifier lock.
> >  	 */
> >  	u8 tile_invalidated;
> > -	/**
> > -	 * @skip_migrate: Skip migration to VRAM, protected by GPU
> > fault handler
> > -	 * locking.
> > -	 */
> > -	u8 skip_migrate	:1;
> >  };
> >  
> >  /**
> > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> > index 9fd25fc880a4..653d48dbe1c1 100644
> > --- a/include/drm/drm_gpusvm.h
> > +++ b/include/drm/drm_gpusvm.h
> > @@ -185,6 +185,31 @@ struct drm_gpusvm_notifier {
> >  	} flags;
> >  };
> >  
> > +/**
> > + * struct drm_gpusvm_range_flags - Structure representing a GPU SVM
> > range flags
> > + *
> > + * @migrate_devmem: Flag indicating whether the range can be
> > migrated to device memory
> > + * @unmapped: Flag indicating if the range has been unmapped
> > + * @partial_unmap: Flag indicating if the range has been partially
> > unmapped
> > + * @has_devmem_pages: Flag indicating if the range has devmem pages
> > + * @has_dma_mapping: Flag indicating if the range has a DMA mapping
> > + * @__flags: Flags for range in u16 form (used for READ_ONCE)
> > + */
> > +struct drm_gpusvm_range_flags {
> > +	union {
> > +		struct {
> > +			/* All flags below must be set upon creation
> > */
> > +			u16 migrate_devmem : 1;
> > +			/* All flags below must be set / cleared
> > under notifier lock */
> > +			u16 unmapped : 1;
> > +			u16 partial_unmap : 1;
> > +			u16 has_devmem_pages : 1;
> > +			u16 has_dma_mapping : 1;
> > +		};
> > +		u16 __flags;
> > +	};
> > +};
> > +
> >  /**
> >   * struct drm_gpusvm_range - Structure representing a GPU SVM range
> >   *
> > @@ -198,11 +223,6 @@ struct drm_gpusvm_notifier {
> >   * @dpagemap: The struct drm_pagemap of the device pages we're dma-
> > mapping.
> >   *            Note this is assuming only one drm_pagemap per range
> > is allowed.
> >   * @flags: Flags for range
> > - * @flags.migrate_devmem: Flag indicating whether the range can be
> > migrated to device memory
> > - * @flags.unmapped: Flag indicating if the range has been unmapped
> > - * @flags.partial_unmap: Flag indicating if the range has been
> > partially unmapped
> > - * @flags.has_devmem_pages: Flag indicating if the range has devmem
> > pages
> > - * @flags.has_dma_mapping: Flag indicating if the range has a DMA
> > mapping
> >   *
> >   * This structure represents a GPU SVM range used for tracking
> > memory ranges
> >   * mapped in a DRM device.
> > @@ -216,15 +236,7 @@ struct drm_gpusvm_range {
> >  	unsigned long notifier_seq;
> >  	struct drm_pagemap_device_addr *dma_addr;
> >  	struct drm_pagemap *dpagemap;
> > -	struct {
> > -		/* All flags below must be set upon creation */
> > -		u16 migrate_devmem : 1;
> > -		/* All flags below must be set / cleared under
> > notifier lock */
> > -		u16 unmapped : 1;
> > -		u16 partial_unmap : 1;
> > -		u16 has_devmem_pages : 1;
> > -		u16 has_dma_mapping : 1;
> > -	} flags;
> > +	struct drm_gpusvm_range_flags flags;
> >  };
> >  
> >  /**
> 

