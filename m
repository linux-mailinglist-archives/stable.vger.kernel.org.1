Return-Path: <stable+bounces-59233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0379306B0
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 19:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50832847C9
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EF13C90C;
	Sat, 13 Jul 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGDJMryj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6391757D;
	Sat, 13 Jul 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720891363; cv=fail; b=Ycxz2sDMTs/6GBjGvCOCOX8yio6CS53grx5GAD6jsxutiTiJ0MseerqmTh87hib8NLAL0JsYqv6hK5jut+EdCSIoasPYmwn3xaVMSOMvWxkImd8PMjeg9y5jyb8RfZkmbpsnNtv84bB2CEB5sdYe/Wi2ee/ZCgtJ3dlE0rxfYSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720891363; c=relaxed/simple;
	bh=jxYi675vFklr6F9X9IjvLYTEMr2jaE7RlAF1c20AUsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jG9vTb2QGGsdYY7JUffbIQX27N9kgi7vMJO6rJfL/SgocJC2KHFfRid39aPu3X3tojDLmmdoqUgKQ9XOOyHkptDYrGCXNeOhLeC3XHvXiojdZlsHOR1TLERYFUOqG0nODN0B3TnuUPq59Ft77DLuvhkKPCpATRYre6qM52mswLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGDJMryj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720891361; x=1752427361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jxYi675vFklr6F9X9IjvLYTEMr2jaE7RlAF1c20AUsI=;
  b=fGDJMryj46Q7LQ4REAOMJ0n9w7GrZ4qRoVhHXjWsyXGvyuXKo8B1Id3W
   TTjeFb1CYDwKLSs9PfW1BiPdZ/U2HSXONaf8GRtZ7vevfec9pp5YlLjUm
   8CMcT00hVvqNG474p6NeMHFXu7s428vOhiXzlWGdJORoLQNdwgIcDdtGI
   JRD+NXQ7CZZFnr8i7+7RUm+73STCWK+HyTpADGFo46tZIxxy0joKouO+M
   TPIiLJ/mTO7V5QEw8cQihdHZ1CE7t9yRnkSTsJ5iJdCn6BcvEho3InocX
   q38TukyZ5ka0SNEhrVgiMJ/UahRRzuMCZTmzpa66Cj+3aZAhQ/tnhxrNk
   g==;
X-CSE-ConnectionGUID: 0MpYmntTTeuDNE2SxiuYlA==
X-CSE-MsgGUID: UqdZRtdbT9G+gQRwI5szMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18459171"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="18459171"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 10:22:41 -0700
X-CSE-ConnectionGUID: tNsjENXFRXCo/o5BT+2seQ==
X-CSE-MsgGUID: PlFhZ8vgReWED2XBXlJzkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="54040708"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jul 2024 10:22:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 10:22:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 10:22:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 13 Jul 2024 10:22:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 10:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG0d9cHAYkLTjFPIcTMhT3RWGvjDx/WOekAXvC0ItEfEYfoGGHvlxq54S3rQ5s8omSOQWZyc0jYihYxspA4iSa5HlqMimk8QHiR3XC8BpNmHfYrrtvEMWwkOhEce+vVHNQD73y7lIXuudtIi+gzHth6kWf+vyaO8PBHd2Ve2eGdH5ZjoobjPBL/jAqMvc32dHo3hqT+0qLQPxhGDIlchRWLC8yrlxbtv1n20JwdT8d6vVUWyivdJX3tHJFnnKt6t3+bTOiqBmykdVDwD+u7KJh3Bgf/Vfd2AkbZvAHkMz8bRWkU3BsCniJNXnF0lzI1KA0cqTZIySP3yN8qOuj2upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Yp3aSdChV3ohEQODcq31rTHPgl3JOt3noN/0TVnPVA=;
 b=Cf5B0xmPKYxcioZnUoQSExCZ7fJxGCLs2Ump4VcI/1ytZet8zn3Il7eTibc0+QrMuc2tXP6nmlVQ1vFeRBRPkLMV3VLKw1jc5xK8zRHn0UOotAzoz+0eBMk++1tKB2tbwIjcglppA9SYvwlGqBc3/t/tiJjrWj+YMPgsg5p4PKpgJ1SvvakxDJ+Qji2SkQvy8t/7ZEVMM7xVO+wDSuzCv9d6Rf1zPURES9zTYsr1XMvaUngDsN670xAAn6LZc5bJsuLlOxe7x7RQv//UpGV1gf3G9buwcFDqRw//eAaYRKquX/wD/uFvF4DDiyPCfwmaVkpepoY0OgTog+e42xeQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6997.namprd11.prod.outlook.com (2603:10b6:510:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 17:22:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 17:22:36 +0000
Date: Sat, 13 Jul 2024 10:22:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dan Williams
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>
CC: <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>, Ashish Sangwan <a.sangwan@samsung.com>, Namjae Jeon
	<namjae.jeon@samsung.com>, Dirk Behme <dirk.behme@de.bosch.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
Message-ID: <6692b7d912e3e_8f74d2945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
 <dfcb0456-dd75-4b9f-9cc8-f0658cd9ce29@I-love.SAKURA.ne.jp>
 <6691c0f8da1dd_8e85329468@dwillia2-xfh.jf.intel.com.notmuch>
 <0b34da9e-c13f-4fab-a67d-244b0ebba394@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b34da9e-c13f-4fab-a67d-244b0ebba394@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: MW4PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:303:8c::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ac8b85-62ad-4d3a-2a94-08dca3606363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lNg6dN1YwQG6dFJWZ9VpuOEoOdUVGVuWHOoIxMx7XZML7f10WZNRhniRfbzQ?=
 =?us-ascii?Q?Ty4Srv36aKhZRhZm0mLeAqa4w74g2/PloDjzdIojZ8XRHNGD22/1uUfxA9yf?=
 =?us-ascii?Q?W5fclGr0CDtFAjw6k1bLZccTpiuwhlap7HC2GkcoLX3/3uCBFQHofjX3R1AT?=
 =?us-ascii?Q?+Ua+e+fFqzqAtKB7KW3w632wZoiuI7Gg0OI59t+Hs1A1kz5ayzAce66rwKja?=
 =?us-ascii?Q?xRrhaBA1aFtsSyp2wE8Fh70S+uRC+elKM8XNDKTVLUdxMeT/lARHFq+E8oLj?=
 =?us-ascii?Q?sWtvQkiQRXX4/gqUIc+0Q4QbENailX7Mm4jDJSlvcV2Sk9UMH1sPneQMp5Sx?=
 =?us-ascii?Q?tYl8t27neePMt3D3eL9dDl5125PGfeuFiSxM449U1p+ZhR6TvomyDINQPjPH?=
 =?us-ascii?Q?U4ECxDmMMPeu/6Bbg9IvBzsmK0pUf6ke7uu/gGvBdHwd5UE1/wE2AY+OncYq?=
 =?us-ascii?Q?vGImaDqKHsVmPk6BS9p/qPpX2SeRGSg41Kq1kjnQEWYUulfoYR8pPt9gngaR?=
 =?us-ascii?Q?qBQVhUAabHdkDI41rauYjfeJHYRpZ0sIiYhv+E1zvpnaanUQHSL7YzfsAFqF?=
 =?us-ascii?Q?0QG/5fFRRCmZ/JLMK8QB98fY4DtDPUnWtyySBSzMT+bajX+7d6LJUi/V8vvY?=
 =?us-ascii?Q?XxPTqCIkfKzOkIYnh/Tz3hIkQpX0MnRiZAyUKDzCB0/SpzVrNiRQaZo4z9t9?=
 =?us-ascii?Q?mhGsBQMiINycSSkUkIKegStWUp4qjcExA6BaqSmSBBczY4mO3c3fW0Kp6aMs?=
 =?us-ascii?Q?yrYd3AdRpTM/jbYjdmk9+bksr8FegUYDtKHxGl/6yd9QToDRtzII1PEcBTpn?=
 =?us-ascii?Q?No7U2mULQd952tftdvikklB28HRuNQR8L2QpNokK9vMyHU2Rb3oM5WzAAJ4A?=
 =?us-ascii?Q?p6fA/5zdXbE4rUOjKzM/yu2HMvlxrzMlGGyO10ffCubNKlo2FxhHkbDLbnF+?=
 =?us-ascii?Q?Rdf1Td+ShUr4sgVnijlilyRwvvica68g2qXCUlAbIhWEUTHsNqEhsy6sQNLT?=
 =?us-ascii?Q?QJlYEsu6X5hBFa0cXe3SqFRulSKmvIYoLFL4mg4fifrersEJ0YCgICjh2h42?=
 =?us-ascii?Q?YF++OBN0EG00HosVWgRALudULUTxbHimQmu7SuobMMfvkqcxuxoaWGHSHl2S?=
 =?us-ascii?Q?McgmnvzB1un9ycCugwfeqDU5CIYG4YLpaGlnLy4ITtV378gvOmdkmS6raICe?=
 =?us-ascii?Q?1fvKnmLRZ1JBCi1aqtUXSpZCJuKQZYnEaowQ8yAmSfEVNLp9629Koa75zL4F?=
 =?us-ascii?Q?z3Q7HZrSSz3nRNqhOFDxpLmA0/c7SnALDRuSpZP43CsXG8RLZ2/p3jkMtn86?=
 =?us-ascii?Q?0Ibz1RC3IJX4bQiKNOPB2D+w67GeTCqg41n26RaCvSaj1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRDLwxgECi5LWxOBZDJ6iLbqQOpygr++QhrlzJJjiatMMFVp1AJ0QEXcKeIl?=
 =?us-ascii?Q?4sFeLe2+C54ZvhhO4nZ4L9ju2eikTcV7Z5uGrBkMMEe2Nun1ZYQitQ/4E61A?=
 =?us-ascii?Q?/PJY3GAAMB6PcFZ7kmrhko/fmxOYuAF7X6psqHr3gSTfqh5GxblF6tO2Y3mW?=
 =?us-ascii?Q?ZT6dTnkd2RAwgDLnlBiBRbVgwEvS9Jjhdl6SUcX6b1s76fBqLlb6lz2IPtjr?=
 =?us-ascii?Q?9EZWiidjXR8zp4n4bUv/Cd6jB1LKDro/ujhCxp/J5keJH1Q5lNYgP+4tTjjW?=
 =?us-ascii?Q?bq19N+m7Xz97bRAJAtLoPhn78jTocd654AJdHoEzQHcdaad2o7eDWCyPZRf2?=
 =?us-ascii?Q?zc2PYzIOVKmjmEeeUTQtMJsOWZ83sgbRUroT0pDYvkyoLjiU0Lk19XhzMBtn?=
 =?us-ascii?Q?D5HZ6DgSUwtFSMC50URRuSPSsR5+gZYUTvQkeUpDedTVnlSCPNX07bq9rW5Z?=
 =?us-ascii?Q?1u8/XAIlQDKEAitrNoFnED034ag5Q/EZN8+Wg1B4HpE1oyBaYf9mlUNBm6GI?=
 =?us-ascii?Q?DD+OVtobjs9ZdaUtBz/pcLPtkNdDv2nY6CDq6LE5FubL309tyMm4hRVNSD4Y?=
 =?us-ascii?Q?Zh8rVS9HAUAmqTtSt8ax2wB3uTUygAq9xB1BnXx5VymFYucvk2BNKlxbocr0?=
 =?us-ascii?Q?9w+na/TTSD/oCPhnHr6nb/ojIz4oUucOGgbqOYjP8XE+uwQfJxc/pNMbO2v1?=
 =?us-ascii?Q?fovbWsrYn+TwtWGynZmZ4ZV02NnuH+IJFGV2mkAS7u2yOxRDEde02crj8FW3?=
 =?us-ascii?Q?ud9jlNh7culsrgxYay5XtJqIELqyj3hKMulmsuta2B4hrQ25L1CV0DKcXEgh?=
 =?us-ascii?Q?x2HJxx9sI3hjdz04w32CvASB6xcLASTPcsTnURhN8snXaQZAvXOp15g1trzb?=
 =?us-ascii?Q?ORG5TwlNWz5IEmmuOF57DXxc1EYDhrYtK3JmpF0sV29B7Zt6RM441ltKD2qC?=
 =?us-ascii?Q?/AqTggubcPfxa2vsw1efBXeb4Tg8amPydBGX5FfhBcI/BzgPrjqlTqH6LSF6?=
 =?us-ascii?Q?kYvXZ1E3tQNSNDeV6PuxpOy4n8ri85WGhBecxa6IUCvLbhkHA1kg5Se+xvzy?=
 =?us-ascii?Q?NH9xOZzA8SLjwGN1L2XlYz/YyUraebqogQLpiA3/N5+4wJk4mqr0Y2L7f1l0?=
 =?us-ascii?Q?8Yaes5hFsVr9uTAlEhsqSX+TbrIy7lpit5SVBDDl1b1EB2vXFp3vDw1oSu/6?=
 =?us-ascii?Q?Gmjf78L5SrmolAidDprwmLXDYkErmc0lX9x8+/w+NzOfzqZN+hlDtnSekJ7/?=
 =?us-ascii?Q?+2jaRZnZA+8X08c0GJsfSCRGKVzzO/JFs319YwFE2FdSeZ2ZtfCw8g7R9lMW?=
 =?us-ascii?Q?b2IrGGHUYGJ4RiRPJITP2e8yKmuEFpHBvgzpcXktJdNRy6U+cgxt+KC4Nxg8?=
 =?us-ascii?Q?Tokvl1/HOdMDVCgNCo2bKZegV7So62hBZdy7E6zjt6WtzQGNMgEeshMH+xUK?=
 =?us-ascii?Q?GxdKYiXV+5cQj6kPNMWq3HuFoduchEqyQzcCCxEk2VsIAzDDl1Jjv1abBbMc?=
 =?us-ascii?Q?7U2wyxHjK8tDQh09UoAEBKs/M7EeKGwZr3osuQn3ZrsF6HiLqFFLIuqEW81k?=
 =?us-ascii?Q?rNEEDaYCYAGSwZZvEEkVd8ARKAavuk5mXqgx08asg/N9OgQeboMTH+mBVX21?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ac8b85-62ad-4d3a-2a94-08dca3606363
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 17:22:36.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAH8bXzUoyVofuGVgHOsmsnIcGbnILasr0+zDBcR2EF2uvgiSx4LYaBauiJXYulCVi+JfcrZl+WjqE7wrZ/R41LxcsbW9aouDAh+mpIpn40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6997
X-OriginatorOrg: intel.com

Tetsuo Handa wrote:
> On 2024/07/13 8:49, Dan Williams wrote:
> >>> +	/* Synchronize with dev_uevent() */
> >>> +	synchronize_rcu();
> >>> +
> >>
> >> this synchronize_rcu(), in order to make sure that
> >> READ_ONCE(dev->driver) in dev_uevent() observes NULL?
> > 
> > No, this synchronize_rcu() is to make sure that if dev_uevent() wins the
> > race and observes that dev->driver is not NULL that it is still safe to
> > dereference that result because the 'struct device_driver' object is
> > still live.
> 
> I can't catch what the pair of rcu_read_lock()/rcu_read_unlock() in dev_uevent()
> and synchronize_rcu() in module_remove_driver() is for.

It is to extend the lifetime of @driver if dev_uevent() observes
non-NULL @dev->driver.

> I think that the below race is possible.
> Please explain how "/* Synchronize with module_remove_driver() */" works.

It is for this race:

Thread1:                                               Thread2:                                              
dev_uevent(...)                                        delete_module()                                       
  driver = dev->driver;                                  mod->exit()                                         
  if (driver)                                              driver_unregister()
                                                              driver_detach() // <-- @dev->driver marked NULL
                                                              module_remove_driver()
                                                         free_module() // <-- @driver object destroyed 
    add_uevent_var(env, "DRIVER=%s", driver->name); // <-- use after free of @driver 

If driver_detach() happens before Thread1 reads dev->driver then there
is no use after free risk.

The previous attempt to fix this held the device_lock() over
dev_uevent() which prevents driver_detach() from even starting, but that
causes lockdep issues and is even more heavy-handed than the
synchronize_rcu() delay. RCU makes sure that @driver stays alive between
reading @dev->driver and reading @driver->name.

