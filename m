Return-Path: <stable+bounces-147875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E57AC59FF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96832189EDAB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F551276051;
	Tue, 27 May 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYkOysPW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E40189B80
	for <stable@vger.kernel.org>; Tue, 27 May 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369979; cv=fail; b=QeDptN4NdcnOPB7gTS5ovH+7o1k44dYHgitVkHO/ITBAXvEH0Lcgdbqhnb4x9OkHDTVBlLxUSWxowb6KaQ52J2qfHfUsjS73WO/UoSJUOn1GcrDW7Zj/gtJQHLcfOu1f1FH1qRX19Ky6VYugcZS0jOzz/AJflfsQ5KCRsL+MLCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369979; c=relaxed/simple;
	bh=2FsV2HqBWKGwcooCQN8yLE5VNCLSNgDYJ5K9NlmBbkQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O442ayoJqZRVbPMZtkPEiSzi4nIt4XpJuxwja/GcwTQIZeBLi+VIWqXZXiFTi0z3qF6VKUzRWIbAkJbBOrVo11Zizpw4zjFTfN7TD8//ZPix7InIj5yQWE7G35PQfsqFbINCNf6xM/pRDxk/xvyPwZxkRv4Gs0vAF+LpRLuEVvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYkOysPW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748369977; x=1779905977;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2FsV2HqBWKGwcooCQN8yLE5VNCLSNgDYJ5K9NlmBbkQ=;
  b=hYkOysPWoygWFxM7t7jdJM0HEdYRIU/JD2lMYxPYd4SESDTew7XwfIGO
   +HcL5PXuPtGYVyViCuKnf++T78oWsc33e4yNPfahH4xPlm5uFMwJTqu8J
   6LAyM2HmhT5s/6XBxdR2bpYF0P1CeE+i3+0iu8juMY4j9Ka/vWLHXXRo1
   +2IkfuXbsVri/yBXHIgkz9Q7W3k03MXg8JfQKfV5OGc0xzAF6RNonEz0E
   OlD1hGZVtlHH9p6wH2miPdQCnCDReqDfdkq/ED3iDQ9a3fndUuHXo/e0x
   biTtfLjmIWG+cnO2cUbuycCzmgMIh5dqVVggU1L1KOjbGhfp3nHZrnS5a
   Q==;
X-CSE-ConnectionGUID: 66uznC6MRM+ahubp2Pdmvw==
X-CSE-MsgGUID: jeCDIhZGRe+kzZ3kcefSzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50261795"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50261795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 11:19:36 -0700
X-CSE-ConnectionGUID: dPYeRtfCSTCfjdnueWaxRA==
X-CSE-MsgGUID: 5Dkm3lFIQMypo+eu/Dw0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="143893769"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 11:19:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 11:19:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 11:19:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.40)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 11:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K015+tKV0rnYBmzj254Z0oAtPZ0O6yoQAwS2eWAI7HtjpCzbdmfvn8mhVO+j3520jgOntBwXum9HpcjcmawE7MgvdsGCWXqcJ2rVltuRKRVe3089VjbARuCLQX2tDXdFAxSwX/PZkzHcBAEnV7kVOJbp+JnQ5RrnQe4dXYzQJZI3tuhu/ANaGUDUVARj+XbfshLMUXoN3xn7O7h6KW5qRspTKDdR55TChScolu0h7B3+etL1oIkxPAbWNcR6JvhcRg24hAmY02I9XvaawFJl8ikCSYV3/kMkixNCA4P8a6HIUZ8pnDwP9uJYl8j+f2iIhVKv6p6QuA8XokVXgnowgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEvKC14FZW+LUUnTIUQ7jO3//Jz9uGYrajFMCdqtILs=;
 b=IJ+uX34ri9VJhf67XBdMJ8MaGuagli+iGQGrPxs2f4dDCAk2r1cPKOe0KJcG67QXv+LK9/O+VX/qHlxrznP0yJk/Jq+/YXphjCnsihSCO+laZjIe1YhUqAa0UUIWt41rdd0Q7jEWcLnMhVhq1+mHyacBegqZDmoaCZAWl6AFYfLykus9gpdhAkksCrrA5KfCyB1Ih6qNPSfDAvdYE1GI0/O7CUmWxzbcwWKdtQxzSaCWUDnjvb+Y3iI/ma2BzJqXzso6Z42fJNlUwoT2qOUrUavZIEp39rdF9OAursnvg/DwSrap7iyCrN0VOmligqOZ6HrFFFqssOHYTNH/+wdLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPF97652A3E1.namprd11.prod.outlook.com (2603:10b6:518:1::d3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 18:19:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 18:19:19 +0000
Date: Tue, 27 May 2025 11:20:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, William Tseng <william.tseng@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/sched: stop re-submitting signalled jobs
Message-ID: <aDYCglGbDzqPNofk@lstrano-desk.jf.intel.com>
References: <20250527101959.192437-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527101959.192437-2-matthew.auld@intel.com>
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPF97652A3E1:EE_
X-MS-Office365-Filtering-Correlation-Id: cb642a33-cd56-4dde-4b10-08dd9d4aff66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xLfi4viXxoaefBp81pUihkDoKdUmuANYDJFNsWRfbdGlePzS8xEyvb6m+k?=
 =?iso-8859-1?Q?2W5Go0xyLHC74uBFuFAY3wAbBn2qi3EUUT/TG6Dfsi8zdRTDojXbPXHZDv?=
 =?iso-8859-1?Q?s8gIKcHfgkBEzGPjDJhJnDgBoKRXyXUIv6LmG9EkPJfRTAPTNeBk+eQZFO?=
 =?iso-8859-1?Q?aSYudpcHrN/Cn6Ke+4l5Nn0cB9tLYeyQzmFqmnziDoVmX0N3/iwXJHsrYF?=
 =?iso-8859-1?Q?a+iu8jLM16vlSa+SCd/3FGLUShMJTDF6fvh0p5JBBhuRU8f2NNhoYh1hr7?=
 =?iso-8859-1?Q?0rOkOTyYKanYyvChWtQXx3lISaYT1ZT8J/GTMys311dC0+5lyoS6v44iu7?=
 =?iso-8859-1?Q?hRbxRPNg5GBjRFnyHFrxy8KcNwm/AtBzbaXNOu/7mD9ZnAUquBKOC05JoS?=
 =?iso-8859-1?Q?Gnz0mh6/qJ6ZU0tZ5Qj6gJxhu4Wlb/L2qV9gy2YmjxTDS3nT7c9D/1ykmW?=
 =?iso-8859-1?Q?dVoIjJpanykazEi96j0qrQcVHQvouobuarENzVD1TFoItQ4QPfjpmNnv3T?=
 =?iso-8859-1?Q?9aiZRAeaefYIb41oXcN1tByDHtY6SoUvTXBBIUreyljNpaWim3xMIRk32X?=
 =?iso-8859-1?Q?iXuuvD9kgUk+P+LJ2zu3ArPYHm8FASHuDG7TRTT815B0n8X1+/NgeUJiVz?=
 =?iso-8859-1?Q?izfA0UusWCDEvYfqwvXohIzQUOL2RCGRJHfNWAaPOaMqtWSQcimk+KvUJT?=
 =?iso-8859-1?Q?ex6VSUkIrKPq8MzTcWMJpc3aHEz+k5LoxFVlLiVs6utZBx1dK4CI0CQkgJ?=
 =?iso-8859-1?Q?FjiMS2IOlXy8PGKrXKNIKevrulJKZKq/ilaU8kndrW/kjSPr8rVjsF7X+t?=
 =?iso-8859-1?Q?dHk4ZZq7Mh1GI1UaB7VA8atyU1Q0ylfCPZrtiB4Yte1t4ZpywIpDn1F15c?=
 =?iso-8859-1?Q?qufX3xprvuNiemqmFsOPW1Lxk2iyBWprd9W+P8cw+zJEXIUuMcS3eFA6Tc?=
 =?iso-8859-1?Q?MSj0FLqD7mOgq861ySQd3exnaLharUJezvKbF6BTKVN2RIHtce67uQR4/M?=
 =?iso-8859-1?Q?mXJPoBTZQLik3flWVsmDFeE0Cpinby8rOJj1xXuddUpgRYQU1so86ZZAd9?=
 =?iso-8859-1?Q?CheVytvBp8oLhKfGIa7MlrELDprEYMZD99/Ux3i6/NiUtaKpegffm/TIZl?=
 =?iso-8859-1?Q?n9EM/JR+ejS1M7CqljJf3fldfjTCeWhA38vCBB0mrd7aYXbWl0fkOgjTZy?=
 =?iso-8859-1?Q?QJFv8fRWcfA3P+vgApM62agFi+75NR9/vz3aQSBk9OzJxi/FeTFfaa07Ym?=
 =?iso-8859-1?Q?wiEQotEF8z54/zK91nNh/nUAmFDGQAYeAZH+Jc6P87UGY8uACpgZGA76fO?=
 =?iso-8859-1?Q?wlVa8F66XdYVYAqUWhJsVPBoJ95wai8uVedI2Lt5bJsGJbQXpEAlamAlV2?=
 =?iso-8859-1?Q?5kZvDwIQFjZwTMQoP8KvCBxDAaru8yPc66YawZsliUStvjNEeCclw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WcLARRR5DegkfWkWNNh26bU2idQfKBADGBcPku83xCXLZz5L2D/O1782ST?=
 =?iso-8859-1?Q?UzapMr/BfGqX7zvtWQxSa2DdUhSb8nKF4ptG3dapn/cug3oNDowfvjjfyy?=
 =?iso-8859-1?Q?UkMUO43w3Kgn28Si2bCqg/9R+3BjN66JiTt5sK8+z1GxNQQCZFiNY+/Te3?=
 =?iso-8859-1?Q?vwlyOg/MMbGBdHAWz7TdyPga4msjI75FyQMtg7279PAGBbzXHclkzp+fUA?=
 =?iso-8859-1?Q?cOBzfRx+fdnOQIW4KiT5Tgw63RMbUo0FqHCmhTJB4HpQMdUZkbFEDcbQmt?=
 =?iso-8859-1?Q?Tvk/2P9DMy8/Hl5Y0SdbWK0YKRsJWuejhUT3OWhJ6AJTctTTF/rYDqPJ7R?=
 =?iso-8859-1?Q?wONjpJdjVGszlJUbpVqMn2d4DEnRIH5lipAWxWh2rPLRxYbQocFmFNlloW?=
 =?iso-8859-1?Q?+2OdN1CUoBUL6PB3AfnpJ7OWDwyXjyizwsrAzsYf10/VkPKKy0gtP7Kya/?=
 =?iso-8859-1?Q?3uV6yOjZ3JEu5DTOCUww7NJbhvYEX39OFR65ee9N9cPccPxKa1/9vjrcpf?=
 =?iso-8859-1?Q?QZO7O5wccBrf6vgwUa3E+l7OAETALwMotC7p8eG38hz6+T45K0GngPUG3b?=
 =?iso-8859-1?Q?E39rvhwl+zngzt5ckev3XlXMTWTxnuansizzBMzl7mti29kM8YGY+IotAU?=
 =?iso-8859-1?Q?gjxgPaQILBEkXRpgaAvjODhX44crPo/Wkbj5EupYmNieZoZBZatca0Q87D?=
 =?iso-8859-1?Q?7eJD+cc70eR4ILoSPzPGI4V4R9gtZbwGE5AUo2Ea1Zqts8S7xnQVe79j//?=
 =?iso-8859-1?Q?5dbqs2lQOQFLEr/Bke1Uj1P0DHrykdbIUeuxcoA0YZpmqhaLXxsbyTqaej?=
 =?iso-8859-1?Q?4BK92Oahj6kcJi3C+o8HvYOKnopMyxghLdvIge89bsIeXeexCH4t+bSqss?=
 =?iso-8859-1?Q?wELX0GhAdXcg0Opiqpvrc3ejrOwmHJSxp6waa4/1dw+ytC45PyYEj5IMr0?=
 =?iso-8859-1?Q?XOCM4jH/ZGW1p28tRzpMxFyJ77Jd+ZwnO16gz7qUTQCVnupejJXCC2CCYu?=
 =?iso-8859-1?Q?OFkRTKj8yhgJ0KdLJ5NVEjnP2642+bj/O4Zpz1+vQnKeHEmuHYc8UZ8zj1?=
 =?iso-8859-1?Q?2domNkYRmHxao1Z/fx+ulzYbJRqG52N1UpTrNPDeUX8swjkfFhwZuBWGxl?=
 =?iso-8859-1?Q?Dbvf5vOKX4QZm9F8HE9uKZkCrexfcVq+MFx2ozwX00THUeZsHGuRnxF+pC?=
 =?iso-8859-1?Q?xrgx2bkSxxWidO3WVEqohfmBpGYCkFDEd6cGCJO3NulJr4zoXLOK9e9HP3?=
 =?iso-8859-1?Q?+THOhhKkqDNU5XNOSTX2imhrDdtku/BHJgfMic7zXSvgH9o0uB5yeATlzX?=
 =?iso-8859-1?Q?slzvAc6AAnz0vMBEdp4WIZVTFt39KBi2FO1b6Q0jqwVnvNR4BHnjV5VLoZ?=
 =?iso-8859-1?Q?E45sH9z47/r674BSpJ7u+7NQfEGdz7Ag+KMemCFpLBbk80zcYdRyM+5p5Q?=
 =?iso-8859-1?Q?1vx78vFtepn2qU4Z2oRX5K4UY02sP3SBQ2Xh8uD86c1RlT4N9XD5LJZsCz?=
 =?iso-8859-1?Q?1Hq/yHyPhlzVeaqb/6VYdZkL9Z6wuVyukeLzZGczbbX9NZzqiICnhKmrO5?=
 =?iso-8859-1?Q?LsXLXoJQvMoJThObolwtw252+TaR3P1T3cJzonXTv4VR3nbkNRJVwJbq4x?=
 =?iso-8859-1?Q?FzzH0ZzYoaGmXnmSoIGZBiJvbKY1OtCoi9IKn3ecf0RHMaIfgBd53gYw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb642a33-cd56-4dde-4b10-08dd9d4aff66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 18:19:19.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQe5IrkPd9vlVztO8AuPG1qEAky6EtkPQl44HtvZ288S1nGssDDJa/GXu3YxmQaCO4I1fTEuyUmAtfcUhU5XdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF97652A3E1
X-OriginatorOrg: intel.com

On Tue, May 27, 2025 at 11:20:00AM +0100, Matthew Auld wrote:
> Customer is reporting a really subtle issue where we get random DMAR
> faults, hangs and other nasties for kernel migration jobs when stressing
> stuff like s2idle/s3/s4. The explosions seems to happen somewhere
> after resuming the system with splats looking something like:
> 
> PM: suspend exit
> rfkill: input handler disabled
> xe 0000:00:02.0: [drm] GT0: Engine reset: engine_class=bcs, logical_mask: 0x2, guc_id=0
> xe 0000:00:02.0: [drm] GT0: Timedout job: seqno=24496, lrc_seqno=24496, guc_id=0, flags=0x13 in no process [-1]
> xe 0000:00:02.0: [drm] GT0: Kernel-submitted job timed out
> 
> The likely cause appears to be a race between suspend cancelling the
> worker that processes the free_job()'s, such that we still have pending
> jobs to be freed after the cancel. Following from this, on resume the
> pending_list will now contain at least one already complete job, but it
> looks like we call drm_sched_resubmit_jobs(), which will then call
> run_job() on everything still on the pending_list. But if the job was
> already complete, then all the resources tied to the job, like the bb
> itself, any memory that is being accessed, the iommu mappings etc. might
> be long gone since those are usually tied to the fence signalling.
> 
> This scenario can be seen in ftrace when running a slightly modified
> xe_pm (kernel was only modified to inject artificial latency into
> free_job to make the race easier to hit):
> 
> xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0, lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
> xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x0, flags=0x13
> xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=1, guc_state=0x0, flags=0x4
> xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=0, guc_state=0x0, flags=0x3
> xe_exec_queue_stop:   dev=0000:00:02.0, 1:0x1, gt=1, width=1, guc_id=1, guc_state=0x0, flags=0x3
> xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=2, guc_state=0x0, flags=0x3
> xe_exec_queue_resubmit: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x0, flags=0x13
> xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0, lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
> .....
> xe_exec_queue_memory_cat_error: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x3, flags=0x13
> 
> So the job_run() is clearly triggered twice for the same job, even
> though the first must have already signalled to completion during
> suspend. We can also see a CAT error after the re-submit.
> 
> To prevent this try to call xe_sched_stop() to forcefully remove
> anything on the pending_list that has already signalled, before we
> re-submit.
> 
> v2:
>   - Make sure to re-arm the fence callbacks with sched_start().
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4856
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: William Tseng <william.tseng@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_gpu_scheduler.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> index c250ea773491..0c8fe0461df9 100644
> --- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> +++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> @@ -51,7 +51,9 @@ static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
>  
>  static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
>  {
> +	drm_sched_stop(&sched->base, NULL); /* remove completed jobs */
>  	drm_sched_resubmit_jobs(&sched->base);

drm_sched_resubmit_jobs is deprecated. IIRC it was suggested we should
replace drm_sched_resubmit_jobs with a loop which calls run_job on the
driver side. Can we do that and avoid calling run_job on jobs with
their fence signaled? I think that would preferred here.

Matt

> +	drm_sched_start(&sched->base, 0); /* re-add fence callback for pending jobs */
>  }
>  
>  static inline bool
> -- 
> 2.49.0
> 

