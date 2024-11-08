Return-Path: <stable+bounces-91965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398B9C25B4
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 20:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E21281E52
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5F1AA1E4;
	Fri,  8 Nov 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZir36Bj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71281AA1E0
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094953; cv=fail; b=F83X6NjE1zSbLzloFkSzicLLw3KaMR9wC9fKdqvckys//Y9gkd3t+Pp9OrXSdAM/lL7kqdJcnCgsIn1hY6BmXOVGkSs1y9uxLKNsbStx5lXtCAzx+4pzFLmThsu7Hjw8XFg4lMxiMYdGttkBYTIQ4PPjjzLTq6k7zaIHJ7HELpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094953; c=relaxed/simple;
	bh=dta8AeFAtrrnKC9uY6+1lMtEgIBCBDlpZMrz7YgaR5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GqLRtwo4MDUYRzcCT87nB2SJsvBaJQzmwPgP9m3gt6hHMfML2wh+AlZegQnYkLh1jzoZzFnMriFDMeyEJ45zpc4EmvpWhk3TBkFclQ2UoMdn0An+Kn2965/pLNt8AlpiZhArxcJPTXV49lW79G7TGb+NMQdfXWyKYOzjzBMtVdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZir36Bj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731094951; x=1762630951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dta8AeFAtrrnKC9uY6+1lMtEgIBCBDlpZMrz7YgaR5U=;
  b=FZir36Bj0ZdC8XnQzvGQla5IbPCD0siCl87zhKbzIZX4AjBs4xf9CkOM
   cwrf6EyW+Bp3GNQTYh2rdec2JU+Kp9cRAvg/TA8APtuq3vLcpMWGtjm10
   cEZJaWWEjQWR+cqg3T9/g8SOGxIFKiz510hMtIAz38GkNLsNFWBQplxN0
   m5tSTWxBqIZqd3wyRYqMwjGzQ83DvGjeMFcrK+7bXg0qUVJhmAaBEF5yj
   NyAfwldnwbL6JeNw8cuScrwF4kAOIrfyJ7qtNTAN8Xmw0kWvJfM5WNXNu
   yQ1uAddFoMoLFv9Su3V+xYXY5TL67u3WYJ8/bzg7zTH2/0ypgD/ePd46l
   g==;
X-CSE-ConnectionGUID: Ymjc9K3sR+uSXo4usIlEuQ==
X-CSE-MsgGUID: 3WrBkXz/S2SMT+ScKxobvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="33850225"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="33850225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 11:42:30 -0800
X-CSE-ConnectionGUID: Biw6cbnpSLyzNkCLGL4f8w==
X-CSE-MsgGUID: 7mgPkIN6QYCxRbZEiCE0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85314343"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 11:42:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 11:42:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 11:42:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 11:42:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddEcajUhWkZMn/b7/kBKsKPQXaxyu8/h6or3wX+oyL/VKkaeP3chRB+emuXmzzdx2jJSLmxxvkjaDRM6nicK8HX/hQg934u0pfncghkChv62CXeiOIXsGUeGDNo5LIKVCRKJAAbDuIpx7SFqIvtPh4CIuQitnzoeBqe7T8EitFfs5Jq+oWIfqkj1CKdO1RY+uHsT85kOTh2OmED1JGOmX3ho6HcVNDBk3C2a/7LYRYy5HwbsOvt2Y+V/2RZFJN3EMqy2wWGmfz7sK/38sRrDVLgQVBK6Kd4JlXH3ueVACffa2zhJH3d2d1cR7Z/1RCSBh/TntIUplbMpaJ472nj1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNrLM+0hG4YxpR0odaRV+vE6dh5HVldCMtK7bawkpkc=;
 b=jT/iDvDA8rJu2S9XDATAnhkGvBloOZJXRmZ9cghD9XVGBLN5h/We8eSt2rqAwf/1P4QSEt2bnOT5c1wgO2MiNVOhXskehKgtlsYUnMJUfLvAks9c1F/3VellBEMM05zekWu4GevMxB+RyvZhbZRtBBL/+HjZiudKSY4GZ9ufr7FIGdnwUCikAHXI810eNqH3/qi8hzXcfaTQyOy9ICfaa9qxPFPDyMPY5AGWknnGFhn0cqOLhCvG5RpSWYqQfXrYjVzVUUJWIGPLdAN+TR/OVJq96zk6OensgzmDly2afjMsPBnDrTIfprWMqQHeB31AlCJ95utB3FgkqY+4GCSTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:42:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 19:42:22 +0000
Date: Fri, 8 Nov 2024 13:42:18 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <u6gqllfd7gq5cg5o2pwljzmg54qbyow33vdzymxzclf4hgaxrr@uu3rr5wstwqq>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
 <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
 <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
 <ZypxenMNvxL17mau@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZypxenMNvxL17mau@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: fa39d198-12e9-46fb-36ba-08dd002d76ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MC5YLSxiH6p35rI1Y34VMeVlBhcf7S0Hml4E4VRCEBBuqJ3OuRmGXj+wMgOw?=
 =?us-ascii?Q?MX9/nXFacFAMZXk4w9InkYXgOqqlC9CTi0mc1UNinLx1I68HAcNSCw4SHKrB?=
 =?us-ascii?Q?nHDKnOVikxyciiC5Nn+X7StxJ0Tr10tnuMW8k+ePt3gx5W5JfZPqZN3NPGjR?=
 =?us-ascii?Q?szYH+hti24PaxfoCMV3CKZX7yEJdklMo4A/mmdhWQeJREVvDXmX7n4pmmDRr?=
 =?us-ascii?Q?rdi+Qlc1gObBndmB4gRxQCKz0KZ79A7y620td0dmP1TPqgetxHa7MACdXOF7?=
 =?us-ascii?Q?Oj+fA1DdoFlUtUlJbTNePFYhqX49rdPUSZbr/Y/XPj2vnyAoIVfVtKzivHBP?=
 =?us-ascii?Q?gB5c27Jimyqh9WtkQuKnXwfNWweRoqCydm067xukqNPBaQfxsW2nvWl7BzK9?=
 =?us-ascii?Q?876003B3nTe8cf/eS4GXJGb+a+6gYb8WhGb8Lr4WnuVlZDE2pP5A4MRrd4Y2?=
 =?us-ascii?Q?Oyr+2+NRNImE/RHw8mbGXvFbIwGBhZ5Azh29xxqcHPxNg4dgs8/EjZo4kStu?=
 =?us-ascii?Q?f/vgndJ57Vz74ez11CehNTJgr5Ub3M093m2SFiz2t/RZXmHEK44DkViyL3/h?=
 =?us-ascii?Q?EimuoBuzpkUVSFees69LNP4A5gWijzljQ8SQQ0kUi/+kzob4L699qp9Qi2lg?=
 =?us-ascii?Q?tkXTHuep1emeZfKmYj5hoBlzdpbKOkFK1dsR/gYml0hviXwRzPqUHBlx9d3/?=
 =?us-ascii?Q?2AUb0pj6wVNL0UhBG917eUcWn9pt0Fb0ylEvrxXnvaYRfmIrDO0ArnwXv/Gh?=
 =?us-ascii?Q?JJI0soOBf174/rNdre35ZZEKhnUOQ27beCzkXlvMM7Wys6PnnhQXCTNPsKUi?=
 =?us-ascii?Q?i91av3DHwFxZ2EdAtLA4FVg+GovKECdx+NLRSaBoF3avBZOOY1R4TcKRyrPz?=
 =?us-ascii?Q?ogWiAYGHF59Br+DejL369JhqAPDoqA2YwZtHQ8NiV0b7Dn8e1qP3lA7JldYc?=
 =?us-ascii?Q?DcBUs8WWtghflzSueJYRRGI7BElA3ec97BNBP006Fed5cunYddNZjTasRGL4?=
 =?us-ascii?Q?9WncJ4LFSF3MAnI+PQv31+gnKFcohHOhWGCWS1NuMGFbJ79KAfS0TMt7/ETM?=
 =?us-ascii?Q?rYJETWzmn9DHjk25EiClA+bczPl9HmRvGKkFWwwfzZbW0MdZO9T0nR5duvuE?=
 =?us-ascii?Q?hVMXPiOPdLs/CqIGwsdxR2MOL5Gq2gKtWSgnXy9CTkW0zLeQxQncrJiilJpn?=
 =?us-ascii?Q?P7cXNut+fyG41IXo8K7j74Ig9BK4Fd6L0813mc8l4Hra2wsjsKiGnJwKv0+4?=
 =?us-ascii?Q?Y9aNPCBFEAO6zcHFx1wX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kp56fmjhRpApSZQUllXknbnIBBDYyF5qQ7keFFnk7XII7JTuIvvAbdSBedQH?=
 =?us-ascii?Q?fLuMtXkaqMKS74d0Sn/aM56J+Wap3KGtGajFw7C17fMdxvRWGMLW6/8pnJUb?=
 =?us-ascii?Q?No6iYwuNXDxliIwvOF80bjNG6asxiW5UnSuFquFr+hz7X4KlnyA2rRPuOPiX?=
 =?us-ascii?Q?IhdfrKFPfDbIe35fAIiT6aavp8kZqwhdZawfuId0yq40TMmKz6/2EfbAGW4r?=
 =?us-ascii?Q?NJZ4Tjou5WpnOyhHwNzdboAfzLGPEwa2YLQozCnK9kKNh1cqDLnQbFbRwdY2?=
 =?us-ascii?Q?IOJl5GrZY61O9bnb2f9WCiMp59xgoN+pnrFydoGoTVMno3PMc4tfRibL/Je0?=
 =?us-ascii?Q?MDSnfFjRsO+qic9IA0ncw09IoI8ag9V05O4HE87Bfa237oTrehBEmmRnQJDu?=
 =?us-ascii?Q?8m7nYuKTsdrhHk5aT3kmUCTsi6LMVmpKo4RXz9tqRvMMsQFIsV8wgLRIEc7k?=
 =?us-ascii?Q?yw4X99kmJ9vdKfp95ZtF6gpObU444vDylcSsMZWF+cf4v3omtPWdy+4N/M+K?=
 =?us-ascii?Q?eLn7aQlFzld+6YeJMR2uhLflgHXmTuyBW8PT9TzlIt2LVhC85Z/Oh3A2JF6U?=
 =?us-ascii?Q?xuAHCw5v5028JlsTiQxUeG2EluQpmSsyQHthgB8/CuI3L6wibZCPPLDTq//N?=
 =?us-ascii?Q?BwuQ4hnf0vI82NcUdE0+jiIRTL9zM1GOo+vD1hUpPACKhC+wRYNhWN3VeEZE?=
 =?us-ascii?Q?2lxDYHVU+7YNPJ2yPx+IxQc9KggEbqU8bCL1+FobY+YkYdOpXdkLWSIgGNmm?=
 =?us-ascii?Q?4wQcl1QX3ifRfBSM33v5hTZAw+YusF3WU3IPbEQlm1gMmdUglFKkYOBrVWz0?=
 =?us-ascii?Q?vZTiGbjtZ+17Im3gxFgC3W4fqmQ5n990u3eXBCAr9lGkFF08/dwJ7fodAuNm?=
 =?us-ascii?Q?boj8IjPMy8L4dGygVsASZb/V7fzp15Z/mY7nEfetovhTZ9Oqib/YQSMJNmHw?=
 =?us-ascii?Q?PuUiLW+UhmT6+jvo52uuBdmPJt3Oqh+LQmQCODo/fW5D8QCUZr8ARaPEM+Cb?=
 =?us-ascii?Q?kVJ3OHZ6cRR8pJkW8i0V3dnf8F7A3slYoW2A+OslvbD9Ph3NGBYfSbYcMRjD?=
 =?us-ascii?Q?eteU47VXoRPE9QuUJkISFm/htFFfHAphBYGIWYUvcq5F4050k0er3HKXEEcD?=
 =?us-ascii?Q?18NmxI5alATXAqCPmSJVoVMAHGmm4tM05UVWCVwEvgG6aW6OgyzNW19GpVCi?=
 =?us-ascii?Q?zp1zc5qPGSj9frIby+Wio/ydelcADHmnB47NqOnUaVoaFRP3RLEqLdrLh+wj?=
 =?us-ascii?Q?UV9Bddm/p2BQITIBUV/FiZkkI/B/Gvy8OD1wsrkmaPUU9f2oeU3FDVZN/auV?=
 =?us-ascii?Q?OXMC+ktzeiGhvH2sogrlp85z6kLisSsL3kTy11S7flWZdExLgimTQOHSjAvw?=
 =?us-ascii?Q?VBKtRK4c7c7lsUgCsxX6n4SMT8jyp6N+dWhwiut2Llk6NZH2lZ2bLcf9fL1j?=
 =?us-ascii?Q?exumzsqq+4WBdPzFskE6nNcxchv8jwfTxU6TTEIEmoM4DowY71LwAs7hu71o?=
 =?us-ascii?Q?8gA2xLgCfycQAUcA8XXK/5GCfjgryMIDlHVG/MaZBI/eMrojP1YuHQE5QGBX?=
 =?us-ascii?Q?CbHwxzXNboVexgc2nibvAst4x1pU4z9DUeHakQuh1pUpQDkz+y5vtzI7fhI2?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa39d198-12e9-46fb-36ba-08dd002d76ed
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:42:22.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JulgzbcOQT5k2W0PlSXIFtPpZ+pAcFGKFl4iw8w0gj0HjT9qug/NIjRa1ByGW/O3CoXxa2/rjp61R4796T9lWYQ5tRL1s+lXOHfyKbKHHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com

On Tue, Nov 05, 2024 at 11:26:50AM -0800, Matthew Brost wrote:
>On Tue, Nov 05, 2024 at 01:18:27PM -0600, Lucas De Marchi wrote:
>> On Tue, Nov 05, 2024 at 10:12:24AM -0800, Matthew Brost wrote:
>> > On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
>> > > On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
>> > > > On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
>> > > > > On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
>> > > > > > The GGTT looks to be stored inside stolen memory on igpu which is not
>> > > > > > treated as normal RAM.  The core kernel skips this memory range when
>> > > > > > creating the hibernation image, therefore when coming back from
>> > > > >
>> > > > > can you add the log for e820 mapping to confirm?
>> > > > >
>> > > > > > hibernation the GGTT programming is lost. This seems to cause issues
>> > > > > > with broken resume where GuC FW fails to load:
>> > > > > >
>> > > > > > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
>> > > > > > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> > > > > > [drm] *ERROR* GT0: firmware signature verification failed
>> > > > > > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
>> > > > >
>> > > > > it seems the message above is cut short. Just above these lines don't
>> > > > > you have a log with __xe_guc_upload? Which means: we actually upload the
>> > > > > firmware again to stolen and it doesn't matter that we lost it when
>> > > > > hibernating.
>> > > > >
>> > > >
>> > > > The image is always uploaded. The upload logic uses a GGTT address to
>> > > > find firmware image in SRAM...
>> > > >
>> > > > See snippet from uc_fw_xfer:
>> > > >
>> > > > 821         /* Set the source address for the uCode */
>> > > > 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
>> > > > 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
>> > > > 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
>> > > > 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
>> > > >
>> > > > If the GGTT mappings are in stolen and not restored we will not be
>> > > > uploading the correct data for the image.
>> > > >
>> > > > See the gitlab issue, this has been confirmed to fix a real problem from
>> > > > a customer.
>> > >
>> > > I don't doubt it fixes it, but the justification here is not making much
>> > > sense.  AFAICS it doesn't really correspond to what the patch is doing.
>> > >
>> > > >
>> > > > Matt
>> > > >
>> > > > > It'd be good to know the size of the rsa key in the failing scenarios.
>> > > > >
>> > > > > Also it seems this is also reproduced in DG2 and I wonder if it's the
>> > > > > same issue or something different:
>> > > > >
>> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
>> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
>> > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
>> > > > > 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
>> > > > > 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> > > > > 	[drm] *ERROR* GT0: firmware signature verification failed
>> > > > >
>> > > > > Cc Ulisses.
>> > > > >
>> > > > > >
>> > > > > > Current GGTT users are kernel internal and tracked as pinned, so it
>> > > > > > should be possible to hook into the existing save/restore logic that we
>> > > > > > use for dgpu, where the actual evict is skipped but on restore we
>> > > > > > importantly restore the GGTT programming.  This has been confirmed to
>> > > > > > fix hibernation on at least ADL and MTL, though likely all igpu
>> > > > > > platforms are affected.
>> > > > > >
>> > > > > > This also means we have a hole in our testing, where the existing s4
>> > > > > > tests only really test the driver hooks, and don't go as far as actually
>> > > > > > rebooting and restoring from the hibernation image and in turn powering
>> > > > > > down RAM (and therefore losing the contents of stolen).
>> > > > >
>> > > > > yeah, the problem is that enabling it to go through the entire sequence
>> > > > > we reproduce all kind of issues in other parts of the kernel and userspace
>> > > > > env leading to flaky tests that are usually red in CI. The most annoying
>> > > > > one is the network not coming back so we mark the test as failure
>> > > > > (actually abort. since we stop running everything).
>> > > > >
>> > > > >
>> > > > > >
>> > > > > > v2 (Brost)
>> > > > > > - Remove extra newline and drop unnecessary parentheses.
>> > > > > >
>> > > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> > > > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
>> > > > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
>> > > > > > Cc: <stable@vger.kernel.org> # v6.8+
>> > > > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> > > > > > ---
>> > > > > > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
>> > > > > > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>> > > > > > 2 files changed, 16 insertions(+), 27 deletions(-)
>> > > > > >
>> > > > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> > > > > > index 8286cbc23721..549866da5cd1 100644
>> > > > > > --- a/drivers/gpu/drm/xe/xe_bo.c
>> > > > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
>> > > > > > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>> > > > > > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
>> > > > > > 		return -EINVAL;
>> > > > > >
>> > > > > > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
>> > > > > > +	if (WARN_ON(xe_bo_is_vram(bo)))
>> > > > > > +		return -EINVAL;
>> > > > > > +
>> > > > > > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>> > > > > > 		return -EINVAL;
>> > > > > >
>> > > > > > 	if (!mem_type_is_vram(place->mem_type))
>> > > > > > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>> > > > > >
>> > > > > > int xe_bo_pin(struct xe_bo *bo)
>> > > > > > {
>> > > > > > +	struct ttm_place *place = &bo->placements[0];
>> > > > > > 	struct xe_device *xe = xe_bo_device(bo);
>> > > > > > 	int err;
>> > > > > >
>> > > > > > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
>> > > > > > 	 */
>> > > > > > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>> > > > > > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>> > > > > > -		struct ttm_place *place = &(bo->placements[0]);
>> > > > > > -
>> > > > > > 		if (mem_type_is_vram(place->mem_type)) {
>> > > > > > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>> > > > > >
>> > > > > > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
>> > > > > > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>> > > > > > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>> > > > > > 		}
>> > > > > > +	}
>> > > > > >
>> > > > > > -		if (mem_type_is_vram(place->mem_type) ||
>> > > > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
>> > > > > > -			spin_lock(&xe->pinned.lock);
>> > > > > > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>> > > > > > -			spin_unlock(&xe->pinned.lock);
>> > > > > > -		}
>> > > > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
>> > >
>> > >
>> > > again... why do you say we are restoring the GGTT itself? this seems
>> > > rather to allow pinning and then restoring anything that has
>> > > the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
>> > >
>> >
>> > I think what you are sayings is right - the patch restores every BOs
>> > GGTT mappings rather than restoring the entire contents of the GGTT.
>> >
>> > This might be a larger problem then as I think the scratch GGTT entries
>> > will not be restored - this is problem for both igpu and dgfx devices.
>> >
>> > This patch should help but is not complete.
>> >
>> > I think we need a follow up to either...
>> >
>> > 1. Setup all scratch pages in the GGTT prior to calling
>> > xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.
>>
>> yes, but for BOs already in system memory we don't need this flow - we
>> only need them to be mapped again.
>>
>
>Right. xe_bo_restore_pinned short circuits on a BO not being in VRAM. We could
>move that check out into xe_bo_restore_kernel though to avoid grabbing a system

Ok. Let's get this in then. I was worried we'd copy the BOs elsewhere
and then restore and remap them. Now I see this short-circuit you
talked about.

I still think it would be more desirable to actually save/restore the
page in question rather than go through this route that generates it
back by remapping the BOs.

Anyway, it fixes the bug and uses infra that was already there for
discrete.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>BOs dma-resv lock though. In either VRAM or system case xe_ggtt_map_bo is
>called.
>
>Matt
>
>> >
>> > 2. Drop restoring of individual BOs GGTTs entirely and save / restore
>> > the GGTTs contents.
>>
>> ... if we don't risk adding entries to discarded BOs. As long as the
>> save happens after invalidating the entries, I think it could work.
>>
>> >
>> > Does this make sense?
>>
>> yep, thanks.
>>
>> Lucas De Marchi

