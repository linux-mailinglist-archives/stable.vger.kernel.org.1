Return-Path: <stable+bounces-88178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C349B0805
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C9C1F21A06
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8021A4B5;
	Fri, 25 Oct 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTRGqTEV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10C21A4A4;
	Fri, 25 Oct 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869612; cv=fail; b=puzC9eyOhxHYBNZKp8F71TwjXiEZiaUJTIPS9C7aoe/BySHeV2PQAkNJUicIPaEzbl9OK3xOkcHD95xYp0GAOac39Iy0lkSvsPmjozANhzoUGJBnsFbO4/4NbJZeaIFo/ZIDUROCKs3xtltAb6eZ4MnFfzbtPJmlN2fkB8jn8Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869612; c=relaxed/simple;
	bh=sDstI6/yvpH4WtXVklZl+rBpNXW/54FbabSFggapj7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJyaICXYDw/7IrokE7h6A3p79xMaDhxgpjMFZx9bKWhzDAkNchxH4unmm4QyxItmIaVKFnpCXsDaETSEfZdnaVy6VDjQscseWZLNuSwIJFbe0OMO2HiGlYjGDVMi6adWMxgvq3DXJUq1LeepomjPGwYxkrFSR7wXuLRMDy5fNZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTRGqTEV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869611; x=1761405611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sDstI6/yvpH4WtXVklZl+rBpNXW/54FbabSFggapj7g=;
  b=nTRGqTEVWD4RPzBH8BmLdt+X/RfSGKTBRbFd1KEAoF0azH/YCus/FUlr
   G4aSJXkqa5n5kVgQ/geAJ2wDWExdT0BIPgAwfpv82/iSxyTFVsr2WyJl3
   /RShD/OsmI3G+R/5lTO1xc7nTOhiXgwItqn3O1cA2Duzd8DKAQ/eyd9tA
   kFAYlaK8ePrJ+RUWoWWdBmekACtVvpTBVstEvNKEYMemw81X9N1xJhff3
   CXvN+lWszfKIZl3HvUQLHM5djVaDJqX9Z3G4GwNuJrhtC2AVH0iExP3d3
   h/cYVK8aY8Q2IG48LSKGKN1hw3uBUjBBp1kfkDTGQ1bLfX3APHcFGpAFT
   Q==;
X-CSE-ConnectionGUID: 6Vi3wER6QSmSAnOopzjjgw==
X-CSE-MsgGUID: pkP3d9zcSYqkg0k37jj9eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="17175579"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="17175579"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:20:10 -0700
X-CSE-ConnectionGUID: gOsY8iEHQi+a8n47Sb/auw==
X-CSE-MsgGUID: PWY0TSxETxqDZllipT8LBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81242642"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:20:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:20:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:20:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE42zbrtRyNrcWQsOO5/VpcvSojbqzmovuFJKkDER2OztOvOc+Ugg8HOcRbJj64XZaLX9FuPzXvVF8ttO5Jb4qj5H6hy9E9JcXImQaPqOx8O1D5A/NXvR1Sx3/x/70n8Cv+YblR9v5u0RqpkbcxxlhQ839ogfJ2BDQGVHPStkEWtA/Eu0t8slytmSMu7H6BjUenrySg+LC6ffBSjgoKc0U87/zJRY33KOiaKywxM3tp3aQezGSvDsVsBPMwNevDzSSMc+SQ1ZRPJRxHJ5GUBbOqFCBqI0ndOGDMiJgqu9knviJ7fPwms0lb8t8xVRFyweEcnxF9Bd0deqpODk+tzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoEvfCs82/lCcgLIbDV9fqHisp+OV2e/c+U2s79vcwA=;
 b=SCFuLwBmCMIaMLv+VKLSbrMyyCP945aytck1COmoecefga6RzmToXbbnTqGuLnfo6ffkUXYOqfl4ly8HQRNweTrXDTf8fFrQ6zJJhPkB4CHPaOrRRTf5D/i5uYw43e8GvgtYTFiFjNVyqdYug0eh1E5O7Ae9G++dsytgJ3WVzSfm9g737BFvoCaoVWfXB78W3fBuz6kmm1Bdbx/aRqYtVlitTqxqqGqkbna5VHvOrqG3UeRGazwlSw5lemGG33WtsUqhTdfpmGIuvtIjawIlF1ZE6fflpVHKHFwCDF+9UIiYQgipI4jplqp6T1vDQu+gYFM1c5Kk6xrzH+3jysgqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 15:20:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:20:00 +0000
Date: Fri, 25 Oct 2024 08:19:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: Gregory Price <gourry@gourry.net>, <stable@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <671bb71e22532_10e592944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
 <00e03abe-1781-b2e3-62f5-97897093eb5b@amd.com>
 <671a769c8adcf_10e59294c5@dwillia2-xfh.jf.intel.com.notmuch>
 <825d7456-0c84-27fd-c89a-891545290931@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <825d7456-0c84-27fd-c89a-891545290931@amd.com>
X-ClientProxiedBy: MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2510aad4-3697-4ed8-fe61-08dcf5087e4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pyUQljYG6pY5lYyWnkMYgbq4MfQU0Hh54+U82nysnzvMQCUsxSG1wjq1BgF1?=
 =?us-ascii?Q?m1+SySV+pQFF4WoYaF691+6o0KbaHv+AADEjJqJLoh6lHH+tQPVg6ppsb258?=
 =?us-ascii?Q?M95wmsYbXMZgvgAsrglcVWFYa3Npl/IkXwqgGAZ54tqwsJdu6mER83zJLx0y?=
 =?us-ascii?Q?1MNIdxVhwyNvNbJMsu1VHJBoTB5YuHlGOUesuU3Qr1j3tP76LzJDL8SUQQCr?=
 =?us-ascii?Q?XEdMQ720qDsqd+Kdqx6et3aKdpHBuqYDuY+l7n2A4WW8TtQ+QkvUBDI6106s?=
 =?us-ascii?Q?BdJgy7A1MHoQxH7urmIwAmIguihdtyRrZKpVCrsSQj2K8xX3jx00mx3TrzN4?=
 =?us-ascii?Q?75ARj8d89hRLR4tTJEHUC7Fa9QPcr8vncAuGctzQ9+erDMvPCFE/TiwUVqZB?=
 =?us-ascii?Q?5xuxnxW16KNQnbsPkV6Z7jgpRTGd06Wku+8KNVGsCF2fZURv7RObHvZ/MxKB?=
 =?us-ascii?Q?O8yOSsw5kWB/I7i4OGZHZnn2QEG7otIznf4ha5RIp09R1eYZ3zMqUbitUtSE?=
 =?us-ascii?Q?k+ciBCabxuCJ07XdruGnXk1HTCZ9ckqtOauQ8CMneP52+zCZDZj4p/N8Iuqh?=
 =?us-ascii?Q?NyFemJnVQjcKdbOAtW8gyY33DzlYFVY7dLRAXKWGhuTOAdaOVJSyEQQdlor1?=
 =?us-ascii?Q?N+REDUCiWVFhaEK8hdGQOSs023RPQlHi01hwmvVxQUU25nIvTRto939cYaMc?=
 =?us-ascii?Q?/7q5yuALfq2WkbnEINzaEU062jH+KfbBF8SP3pA9wVdWM9C8My0CvQcel0tZ?=
 =?us-ascii?Q?CdkBRWKYCp5Rh5hT7PtczF56bTL1g87+p/kr/pE6cdU2WYsY743ZnBoq5LR+?=
 =?us-ascii?Q?otlxnmwF00EdkafVxZ5TrKjTay2V5vBRPADhlqjqGIU9/w88wvkHyEVRxU0I?=
 =?us-ascii?Q?VdZVWscD1k7LE73UhFqHf3hAaNA0144LbwOJy9izSnt55ciCTRfXYzAT0bJB?=
 =?us-ascii?Q?CmWSJxcUSiI0Bed6mRaS2LMUwXuO5Zze4TATvMW76SEIwHSNxmsNi4r/cTKW?=
 =?us-ascii?Q?8TJX9FpbY8eE0b0hP3VJ3czxrOZ2t/sFACy8QoAA+/uljuudqIqNyCEOV2j4?=
 =?us-ascii?Q?VJpnm0+Twmt2bYi2ZieGkcCa3wULAaybIAhYLxRuIGNxRePKrU3JUV4MU0vQ?=
 =?us-ascii?Q?ACc5tonWjEPpuMv1jwN0a1gBv4er0i0AMhxwIDQHbn1rS3SLm9e88YNZOD7T?=
 =?us-ascii?Q?AO5WzgoF5JTk3dgl4UUe0+cTieoXGNzWMJZ/gzDNk7PLsTMIneTjVlAcCvoY?=
 =?us-ascii?Q?oFATCeHs7g1UhK7NrTTLFAsj/1QcpxeSQoYtLxT6WSUgbol43/1PCo9bwxET?=
 =?us-ascii?Q?j1CPmfgReALMjoPQTJ5jiue9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Otr7RPmCHFfO1ZAEfw+eJZhCoECI6nf1fYMB9KXeG7pgynpz/fOuWhD2Ppqn?=
 =?us-ascii?Q?Ta9jpudCnsDp28ER/Y5DZqfBQr6y6Gyq+rHM0DvCxwqBDj9wMQySyyDX7i7q?=
 =?us-ascii?Q?pt+VEpEeB4d+3swpni7iA5jsuVN87LrSmt3W/oFwBEj3isdU07/k79K46foq?=
 =?us-ascii?Q?mAlpMEXxEfjxRx+7zBHHXT9Zme+ocmJEsr7lrMiL+2eNf3rGYuD1PXrtflLt?=
 =?us-ascii?Q?G7BseFzE01AROHAmLd1tadD8fjU56frtbWde+ISUDSHGq71K2gfA9apeQooQ?=
 =?us-ascii?Q?abD2SA/S6Ufd7XkB3tKhPVI/zBggJc3xKuTzKZDmhlLbPht8YjGBgzkLYw9r?=
 =?us-ascii?Q?hYLJYWxzAYDyErWAnQTAf/NuHKtkWJ1G54q60vIyMWPAWAYU/Aj+TjSNEkYt?=
 =?us-ascii?Q?7U5mB39eJRaJs5UgSf5qYedkMotZen398+wcuHUnr79zEk2NKJ4L+PyiEmv1?=
 =?us-ascii?Q?PxPLzyBb3tsSDtA9iFmeyGmTOsIWrlawQGZrkapfSL8Fr1vTy09RpFNeE5az?=
 =?us-ascii?Q?Fk/wRhpnMaTHGs+fmlOG82O36wf9UBRDPNbA0WuHuvvUlAwQ7+V6KHSaGdNe?=
 =?us-ascii?Q?oJa+IoPuDd0IcD6jfuksMeyd8IiZtt60QyYs7aeoNnv9N5lL0f/bSoZS9nGv?=
 =?us-ascii?Q?2pQV6VRgfw67BvwzHBGqTzX/hQJWfEWk7y8N3BIdNMVgL0xrfgkqQklhNkEo?=
 =?us-ascii?Q?Z5GED2wN50YIYr5QbFW1LXB8ldysHKovtgqEF3uSJ3tjXIuNxG0A7UDjp0tf?=
 =?us-ascii?Q?dFZt1VMbqnyKVJ1HykxdwnHaLq1o0mUPATZk0y0YyPHafxfT5geEvq0MougQ?=
 =?us-ascii?Q?WvXG6n5chRxfpR3EeZq9WhKjxe40f3jOiuGhfd1T86jKiZ1wK8WlmAJGpgA8?=
 =?us-ascii?Q?LMm3YecL9w9swvfL0IVsODMs6StKnFYUiVxpXVcMwtXpRr25Jy9un/MI9PAP?=
 =?us-ascii?Q?nzEGnZoDsjemzXoCIB1l3vSOyLxlHq8x+jC4jRHTJlMYWKAhRE6epXs20nrA?=
 =?us-ascii?Q?6tTwXArkOR2fSAleZkifXg3HDIayFhzu/7O4HEQY9l/t5PxPcEyE8xQOiTpm?=
 =?us-ascii?Q?QovOtEfd11jof7Fjg5UjNvUDi/VcU1rvPYWF5aLZujKsQEkz9qx4Ti4oST7J?=
 =?us-ascii?Q?x3/CyOsHjweYznRB+9mJfBtAdjlpJuTBaYf33FXbOLUbJ5aDX4iH0NTTNMkL?=
 =?us-ascii?Q?oLqhbc4DWcyJSqoW965HZsj+JebCEW4vI9erQMkEEnZ7/jVxvkjk4GD2pM+J?=
 =?us-ascii?Q?MIz+WsSyiFadI+blAwZvj7eBBkg2ig790yyJ0GrFYOErYpig5u6oGqObqW1d?=
 =?us-ascii?Q?MX0atei3pncQbELob8wHrartunBPXWvSnQHhJXaPWxs4gjVssotIMQ9IBT05?=
 =?us-ascii?Q?cYZonsLyoGvJBKrOpZ4+BJE1c9TgDR+l9QqzkDlNrefC6lvEoBA32j8kRSJS?=
 =?us-ascii?Q?H49LIFIYXxZZ5w0q9rNxBcG4EL2Gg+24Na0FKaUNNgK5ITsOY19bxpDkz2Qx?=
 =?us-ascii?Q?IkI3G20U5qDM6Av0ElLuiopigPqbYdC0zdw7OShkrvqIbReNdXuOZ0pUjFp2?=
 =?us-ascii?Q?Qp3zlYZj8E86rMgoLJNmTTf8YM+/QBMMJCWXpYWWCS1R9hcCFlcTln5DwK3T?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2510aad4-3697-4ed8-fe61-08dcf5087e4a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:20:00.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waWUy/VqGTMpafQWJn24rYDpuIQk1jHBrn2+JGmVNb8/qiTy6YtQGlTNfXLnjkP3eZscY0Ox1tN3v/5RNX7CMj4sEIO3R26zD1SmJtXosWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 10/24/24 17:32, Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> >> On 10/23/24 02:43, Dan Williams wrote:
> >>> When the CXL subsystem is built-in the module init order is determined
> >>> by Makefile order. That order violates expectations. The expectation is
> >>> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> >>> the race cxl_mem will find the enabled CXL root ports it needs and if
> >>> cxl_acpi loses the race it will retrigger cxl_mem to attach via
> >>> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> >>> enabled immediately upon cxl_acpi_probe() return. That in turn can only
> >>> happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> >>> before the cxl_acpi object in the Makefile.
> >>
> >> I'm having problems with understanding this. The acpi module is
> >> initialised following the initcall levels, as defined by the code with
> >> the subsys_initcall(cxl_acpi_init), and the cxl_mem module is not, so
> >> AFAIK, there should not be any race there with the acpi module always
> >> being initialised first. It I'm right, the problem should be another one
> >> we do not know yet ...
> > This is a valid point, and I do think that cxl_port should also move to
> > subsys_initcall() for completeness.
> >
> > However, the reason this Makefile change works, even though cxl_acpi
> > finishes init before cxl_port when both are built-in, is due to device
> > discovery order.
> >
> > With the old Makefile order it is possible for cxl_mem to race
> > cxl_acpi_probe() in a way that defeats the cxl_bus_rescan() that is
> > there to resolve device discovery races.
> 
> 
> OK. Then rephrasing the commit would help.

That and moving cxl_port to subsys_initcall(). Will respin this one.

> Apart from that:
> 
> Tested-by: Alejandro Lucero <alucerop@amd.com>
> 
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Thanks!

