Return-Path: <stable+bounces-87949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BF9AD590
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E064A281EF2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BD1E2309;
	Wed, 23 Oct 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNiOBLj+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7A1E130F;
	Wed, 23 Oct 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715692; cv=fail; b=scOmmJhUZY2j72divW3um5a/PHXTn0pqMhUsU4F4IBFgAvzsdgXyaqAcZa7OynM2XYYqZTyeuCx9kvh38mJRHjpFp3qD79eXYNlgmH7HbtGfuU/LfX5q168NI024Kbs2HainSxJFC5obRJSHh51/iMpHAoREJ4BBBpZxb2O6Ybs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715692; c=relaxed/simple;
	bh=l1UtnGCiJrMM9htk7Gvc4+Khy4aBe8fP15Ho4mn12Jo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9C6/asT0V7zWiLEeS+i/zn+9TbTUVIpSyN+Apc+zev4u5/goYBSnx6m/pmOtffnVQVj/eY8yn94yN3klmh7DHjeVPPaFGbLFGGxEcqZ/SLvq0SZt7JFLdIdsztcfe0c+PDNLiHXmLFFI/k7vO1fneHC9CAt7XW6QiddQV6FjeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNiOBLj+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729715690; x=1761251690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l1UtnGCiJrMM9htk7Gvc4+Khy4aBe8fP15Ho4mn12Jo=;
  b=NNiOBLj+/yj+Jmoczy3k/v3s3yN5vMP2V/njwYlG7ws3VInASUvBSRGU
   OlJTzExP6W5LYHVQWsPVmNN6V9SHbO3RGqfl4Dyz9UeJIUctLqQMKLE/s
   bK7oXVKOrBkjzojnpXrn+unjF/cbmo6u5BbH/cgJ1YM1lSlnQl2YpBlsR
   tzxXaVrJFKig3SsH9FSXBcnl6KUTL2IrQaNPpWiiqsE2X6gIHzzxZ1cyX
   AvCxFbcJ5nib3K0Rit3u5LTjbDFA/FFaNmBKZWcunQUR1lGtmUaIiIO1M
   2VODLwej3slkxp6zSi7y/Cqz18r8EIztUZEKXJstajmav03RvjsNFnyMP
   Q==;
X-CSE-ConnectionGUID: 5gFvaP8UQji3HxQrCeqkeA==
X-CSE-MsgGUID: skgSagiSRUCLJzkwDlvICA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40440177"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40440177"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:34:49 -0700
X-CSE-ConnectionGUID: gCHBUuZqTUiOx1uAvPITKA==
X-CSE-MsgGUID: fHTuudF4RyWv7K+lBHKPMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80384040"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 13:34:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 13:34:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 13:34:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 13:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIxbsJvlXa4m5xVfSaYZOIyCcK64kBfmXn4uKbByZci84ySivTW3tKYon73jVHRkzQs4bY0J6LbPm6U9+OE4f5Jq4iQ8V36K7ykEET336Usp3MJDrnXwWtxOW+B8ndx/iZN6U5wesmaj3mW0gstv2rOXEm1aGUjIuzcf3tKpyWzXQgvfRXXGRjvZo5Q7vlcHDZVSqWYTvswxJYlWl1Y3XNN3iw4cOsvxHU19Y9GjnpTGFahLAMTgEPGLM+RJVfnJWmfgPaxuo4D2VwoLIfROUyxUk4/Q4tg4l270lGc09Irlqjjtmx2i/nsRh+ZDLHx/mnQoyrkmNwIdq6bzn+higA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGIbNdBckUcZQrC9WAf6/vowU5Od23qi3C+fN9GG+AU=;
 b=xvFSoYAqEYFVdCr1qBQfJCSQcD8UGMnB/8jatoPKUprxEiZbVg0/jOpeNmvxRq5fTaj11fZBKWYW8JRR4Inr4Vi8lIOB/Btacn42yeFuE+/hV1kx0gzAYFHfR2PUYmLrBAbz2RUZziac7k1dEAE+cn8/DglOCZnIWVrlubnJXqMdL+DCHCengomjOkqXi6t1NRRE520wi4Drk+8Ke0XCbHgSsMUcPQB+EdHEf5zCqiiAlJUHNBjgFNNp7lZs9T3C/yymPDPvYjIjwu6tC/Oai5tjKNZczefi2RLh8bvIBxScbykXkw5varMKxIwsp5Rh0JTWtP0oCJtoAmJYYFqPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7760.namprd11.prod.outlook.com (2603:10b6:8:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:34:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 20:34:39 +0000
Date: Wed, 23 Oct 2024 13:34:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Zijun Hu <quic_zijuhu@quicinc.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] cxl: Initialization and shutdown fixes
Message-ID: <67195ddc7888d_4bc22941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <Zxj2J6h8v788Vhxh@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zxj2J6h8v788Vhxh@rric.localdomain>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a954ff3-4c45-4eb1-ec21-08dcf3a21e01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLC501z45N+Cu+0OVE+zrACErpZ0JYJWG8KLypVq2D2tCqkyAgn+bqZXIl59?=
 =?us-ascii?Q?VsDBQ+qzl134U/LVaP86P+datJRgC4hQZ+m0ars2mkkMN6Jjzxlh0IvE15Av?=
 =?us-ascii?Q?Wxp/ZzDym/ia0bRt9Bzv07Sd8GXIucvTRQqPVMd4cg8INEppH6u/t8hZuStL?=
 =?us-ascii?Q?ajvzDcaP/B5UvRgSIKNyF0555Uye8GnkfIB8lpdydS7sMMOFDh2uHt1Www44?=
 =?us-ascii?Q?2Or2IQAHgwqcQbmJO1kWpLaEXRtJh+AbELx6yK0OeY+CRlIP2AUJjDwtCtg0?=
 =?us-ascii?Q?B23/TKsrDKt0vHR5BokfqSUuqKhI8YtHC8Jg02hI5ak2L1h8cmNPlwHDadx6?=
 =?us-ascii?Q?rRYsANeoUqu1rKwtvpj+fX+JNgZC5SPWWWS2ieWGlbbGMx0FTxWU2PGInIeF?=
 =?us-ascii?Q?mihg18c8AYF2/kCKeO1jLgT04L3K2AN/iCAHcXeaU6+h90JQAthNTH6vvC8a?=
 =?us-ascii?Q?WbdgcXGmh4yeBayjcSvycCObUPmj/haW4Sa3YWTzD82UfQQDpsTkdz46+3Cv?=
 =?us-ascii?Q?CjLr3hQzGO+PGbdM3Pq5IPsnyLEJvHz7YNOoC9E77Mwii1qVY4jV5BvmRN9H?=
 =?us-ascii?Q?VNPCBSfDJT9cer8cggxGf270BInqcfD8hvz/SB1rZ7QCnRJ3rGKGwwCAP2IR?=
 =?us-ascii?Q?S24NNXn6I3QhYbOsSlZT+BKTeNdlf8C9giQtBMspH9WUdRY3pGFrmS5evz67?=
 =?us-ascii?Q?R4dqS4YkTauijyC6/yDee0rNq/WyzJ/c3f1lD1eqdsCrFO/s67RVD7pGjG4g?=
 =?us-ascii?Q?DUpLmilYq1w5ZLa9A91ICHy5/Fb9YhyBKC/5J2U8h+Zv3Eqd3qBsWWmUMKmQ?=
 =?us-ascii?Q?Ds4AlBdq5/wzcSEwENgdOstDiW/o8QhGuQJ09KzGiBF86bXaHrGEUgN4NM4D?=
 =?us-ascii?Q?cAYk9fLiO151fh12HeU4IOzG/5wt1UF3zUCOPgGKZptwWSqXxTbSwZRpWXQj?=
 =?us-ascii?Q?RF7qNsKcMLf6POzXqpd/T5KxbbSpmBwobU6t7y8aD7Rf4vg/Gh0ai3VB0zbQ?=
 =?us-ascii?Q?7ZI/3UlmH+HQsqMcrZeTZgDnfYNhq8aya1cUT9eukA0JdJjkOpdcozWVYayY?=
 =?us-ascii?Q?fzpVMg+d6Q244gnEUb7QFYjnki1m1kYI1jZl03r2GjcnEF+GDcCCAF2BjE/i?=
 =?us-ascii?Q?4wtL5CHJbJqtX+/5LqbAATTgfJlBk5MG73/yxefs6LeV72V7NTtHHveGhZGr?=
 =?us-ascii?Q?HS197zrMNEMnfy08IEUFi9yF0fjoJZl1oa/mDTv4csuU7JoPFqmLmBP82vUC?=
 =?us-ascii?Q?6bc590yyDlOs4j9oJ99kdwIn5tFgvEN/I8ctjEhwkJawvybiQmaoMyBkHm1k?=
 =?us-ascii?Q?War158/kl4fAKrzpxLaQcBg+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yp3tSNduTdoP4cpdWvBNtz+zABUqRGd7dVAjG7yDUBEiP6ABrlDCtacz8dz+?=
 =?us-ascii?Q?AV1IrdGe0H1rxxgk9emSAVREAGXuksHcjLlbywqycsRsnOfN0R9b2mdlXByb?=
 =?us-ascii?Q?oCl6yQwJVGNuKC+5eIKHqLGzdWwIOIXWySY+fzRUo/aLk9/eSw5KXUVVZi1B?=
 =?us-ascii?Q?wufAvjL7DlgFoYO5q6tQTec6H4Kx0mCxrbDg8k482whVH+LU51UaXBZNCzMm?=
 =?us-ascii?Q?TE3USxTv7/LtkZD97iP2GvM+oFJZAkPaRS0zdFZ0Y8iAepwS0saA6fE3gDnQ?=
 =?us-ascii?Q?y/EGIhM9NX9AAk6wPHMpa1QEf8D1aK8vnNOTCo9pvn2SDWHZt+k02kpAaY1K?=
 =?us-ascii?Q?0Pg5RKhDmAnEbUfM89WFSaRRgxhY4PYKLnZ8YqfDIAyOk3wmlN0YMlfd+Qmm?=
 =?us-ascii?Q?QqWAGz/Ki9TgJTA36Ud3lxcOS/GU6pcRNcsVsv+pYg1sB9dAh5rfGsMiDxRc?=
 =?us-ascii?Q?h0TURa6Gcm+RsPVeWzXeZsuuI01UrQV3/jNfCjRdEjSF9x68RhG5zHR6FwJb?=
 =?us-ascii?Q?TYoq83/Fb5DVLcyLyoMu9v1brhk8JToKEpcmWWR9K1J7q8th3WGpB8IOBv5T?=
 =?us-ascii?Q?nmWVIhH/5eqr0bz8H2mOVguqABzIcQKEuv+lGsH7t/BLPRwEz6zUMY+TMMqI?=
 =?us-ascii?Q?k+T992MDT7i5Z5A5FgAQ8kWpdsW2SA4W2bCJhb7UBOQMXi062kYr6PXAW4kS?=
 =?us-ascii?Q?q9zqVbcjh9A3BjnlE5HZtJrMsRAjt5IJPSz5ri8z6tgS71zGbUEez2gDdmZ8?=
 =?us-ascii?Q?JmVH4Ikq2XzFB2ugJyzHHqwndthU/sotvU5iEqbnDlLEJjZZddzN9wLvKoPE?=
 =?us-ascii?Q?scE5ws9uqHM7QcdY4ccRXSrAfchZZEB+b6VlPOJ3tedvkSJe4il3bzIN0135?=
 =?us-ascii?Q?AmyGyRNThRWxDqj8uqUpowunTdBLmAUFuYRbsLMWL9eUhIxQMezDcAOB3Ou8?=
 =?us-ascii?Q?Nn9VTgmaZke5SJQMAdO8N1z3sBpkeXxFTwAd+3oVYESy0HbGVPQY0yHix2VQ?=
 =?us-ascii?Q?WibYNddYnhqt/QL5Ai+NgWg1UHY5i1TurZIeV5vwp0CLb7C1UiW4+ZIewuZR?=
 =?us-ascii?Q?GT7Eb0n3xsiUf2veQZVTH7D4p+xqMfHIcTu49skzfbu2Z57UvyGsOK8btbNC?=
 =?us-ascii?Q?QDYmWk0tJVs1n991TtWu+2GB+9/z0NCuNJFEvGSVe3Ywzy/Mbc92P3nNzH8s?=
 =?us-ascii?Q?nKmO+oUCCsNodxlm2cL1IbFduQ2wholVeJ/Mm+aS6MfnB3z0HPTWrId2Z4hc?=
 =?us-ascii?Q?ahXKOEXXBYrICAlEwSqUtx4LZqB+94oPWZxlknAp7fQQUI7BekAeQsqbSMS7?=
 =?us-ascii?Q?QwD0IH9q8NCEHcT37MEiDpgBH8O4eqVHeLyKO0WZwiXENt/Fsa166aRc4gfT?=
 =?us-ascii?Q?DVZYE1vkm2LqmXcFKX/MPCPnKHCv/riJqPEgdxfiqJhG91oocnFOnDDdL2sA?=
 =?us-ascii?Q?rqtfOcWPHRzThsTXDooqdbda3HMdLIZg032fOJ3kXScAKRqwW8thjBb2wYLR?=
 =?us-ascii?Q?SMFfpbxaL4Y2W95X0UIGAPzq/T8ktNbHnpoBFH6uo1FTtKJUQt24RyVIiaBg?=
 =?us-ascii?Q?1yR4ydoRrFdF4oFx7ZwCJpuSNc0WZv5z95IQPNbjqo0IjBCSVzdyhSlIOVII?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a954ff3-4c45-4eb1-ec21-08dcf3a21e01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:34:39.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ahfGI7OyZ9HR2tzpfQeH8SAfdHsowSAzq9S3lrgABv3+1BuziV+RqrjAsv1z/eQkxjr3i0FRC5/Ms2bILCkqEFG6oYz/3rlYyKqVui+T8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7760
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 22.10.24 18:43:15, Dan Williams wrote:
> > Changes since v1 [1]:
> > - Fix some misspellings missed by checkpatch in changelogs (Jonathan)
> > - Add comments explaining the order of objects in drivers/cxl/Makefile
> >   (Jonathan)
> > - Rename attach_device => cxl_rescan_attach (Jonathan)
> > - Fixup Zijun's email (Zijun)
> > 
> > [1]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> > 
> > ---
> > 
> > Original cover:
> > 
> > Gregory's modest proposal to fix CXL cxl_mem_probe() failures due to
> > delayed arrival of the CXL "root" infrastructure [1] prompted questions
> > of how the existing mechanism for retrying cxl_mem_probe() could be
> > failing.
> 
> I found a similar issue with the region creation. 
> 
> A region is created with the first endpoint found and immediately
> added as device which triggers cxl_region_probe(). Now, in
> interleaving setups the region state comes into commit state only
> after the last endpoint was probed. So the probe must be repeated
> until all endpoints were enumerated. I ended up with this change:
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a07b62254596..c78704e435e5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3775,8 +3775,8 @@ static int cxl_region_probe(struct device *dev)
>  	}
>  
>  	if (p->state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
> -		rc = -ENXIO;
> +		rc = dev_err_probe(&cxlr->dev, -EPROBE_DEFER,
> +				"region config state: %d\n", p->state);

I would argue EPROBE_DEFER is not appropriate because there is no
guarantee that the other members of the region show up, and if they do
they will re-trigger probe. So "probe must be repeated until all
endpoints were enumerated" is the case either way. I.e. either more
endpoint arrival triggers re-probe or EPROBE_DEFER triggers extra
redundant probing *and* still results in a probe attempts as endpoints
arrive.

So a dev_dbg() plus -ENXIO return on uncommited region state is
expected.

>  		goto out;
>  	}
>  
> -- 
> 2.39.5
> 
> I don't see an init order issue here as the mem module is always up
> before the regions are probed.

Right, cxl_endpoint_port_probe() triggers region discovery and
cxl_endpoint_port_probe() currently only triggers after cxl_mem has
registered an endpoint port.

The failure this set is address is unwanted cxl_mem_probe() failures.

