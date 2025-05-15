Return-Path: <stable+bounces-144458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93132AB7A4C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 02:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF0189D064
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD472609;
	Thu, 15 May 2025 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL6jlkD3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F253595E
	for <stable@vger.kernel.org>; Thu, 15 May 2025 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267265; cv=fail; b=eVxALcWTzcccZYhmH/VflfF6P8JneE/TjPRxZTCbt1r5SO/RMQLpqUDnu5W7DZEUoLazBQbbmPsUyt9VMGQK8pi8XcYbkXGB93kEkH28JZPbcdYCdaKwMKsLXYlRyCFGysxk+YLF0+wDGneOP6X3PelYU3JYPKIcCTHo0bvh7HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267265; c=relaxed/simple;
	bh=PNrD+26JR/wjQhPhjbrunULlQfMk7KONJlVJm+KNsvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=piP1nRIY/7uYmBQpBhl8txCoz4MTO+eltD4SvuGpJkWALbHZbu63BHaeMuYDiB7O/P1Lx1QQ+Qb393RxGs/8pmFmAElIl1zAGnpvF4BFoEgutq+K5wG0V/3acARkzqNmhqDvOn21zuINjJggRcwbRc5EnXeXDBh/2JwgIBVCe/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL6jlkD3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747267263; x=1778803263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PNrD+26JR/wjQhPhjbrunULlQfMk7KONJlVJm+KNsvA=;
  b=fL6jlkD3eDHqwvHdCySnmhgZrHK4AQgyI2xE25NUbXCifSZfQxlmH490
   SqZSvUGYDzjcciuY6hjF4pYqWbUUybu/Qb+49oMa9XI+YabSBbpVyNpgs
   5vrPZ69pW8UNNABQbR10jn3e93coizVd1qsPVYde2pwECE34LpyEDMI7x
   Je9GLTge4NGEf+VF7ghQ54R56mXyk7S4SE6dmoPgJECidG+PX0subPg4j
   9YS1KgzdClVi2hVdw6uIfF4/br4i0PWPOLZJeTaqMpQqKk2VeFbalYJ5z
   G4EIPyUfGo2+owe791V/GFDOdjCGD0u24+7q7z56z9jPPEuw80zCxiwSM
   A==;
X-CSE-ConnectionGUID: t0afYJ8gSo24A18+uG8vaw==
X-CSE-MsgGUID: C0DpF1m+Re+Ikn9EAg6uqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51826222"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="51826222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 17:01:02 -0700
X-CSE-ConnectionGUID: ZR86yLmlTRWnGpKLpE2T9w==
X-CSE-MsgGUID: eeCVQ109Qp2xYmbpd1ByKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="137922054"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 17:01:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 17:01:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 17:01:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 17:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe7w8heA2JiFdfw9YUuw8iid2LZaTHyMNT3yqFSPy9LC3CZij0j5yiV9XiZPPEJNnnWyq5NhlpcEATgBCrYHRczONUtHsgFOwi0qUY37VeAYwIW5H7IHIjfJjkzH9N4uxprSGbbabu4FinKH1trBVmtyH+jR9LEiHVOcWk5whF2Qvl/6HBBDfCPTHm5+Qd3q7prbcvuv6bNbOPTQuGFyf/CBtazCVerPIyIclWZlqx1AdTk01h55k+Wl0gEkRn6TwgHmhZrn0RGeSVMA4/+VH8Rki1J0HybK4bnVvBft4cXSpSl/r7Kx5t4AyNdlAIrVTdUF/Mc4o0ixj8tXew3Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n8o2sO1esjM5F8N3QrSaW2vi7VkXKvVegzUmXm47UM=;
 b=s0ydYw6mfEYga41yCDnxk1PAzLKQX8Lpwv/dEROrvcz4gdPca9GehA0UG0XcpF41D84fjON3IHaF5XLxAdK1XRXhBZMwOShmV5wpN1kJqVgqxTvMFU8cxvS5T8wBEHfcQt9gRnUZuSjPUb5t3809gYXjQH0ctcrGJywD+Mw8jNlzNJNk4rL5KQ2NIKit851TPFoweolzv1i7ztNDWGWZ4QTTn21Hv+Zm2nLCMYcVGmngULhUeTLjDi5zQxJoafiAjNLO4fLKvATQD+UiV/b4Q2PSGA2nksm5pbtdMVJWSTv62RygDXq69H3VcS6ElIM2G/AJB8Wd48PzbyA8eH0vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 00:00:30 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 00:00:30 +0000
Date: Wed, 14 May 2025 17:01:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/vm: move rebind_work init earlier
Message-ID: <aCUu9RjGGJbRceI4@lstrano-desk.jf.intel.com>
References: <20250514152424.149591-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514152424.149591-3-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 232fdeda-992c-4006-eca2-08dd934381a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pf162SdhRWy1llv41EpxmyaSNdPMbuGVawXeW9nc9wBDDYWOaPlJNNR9DXx/?=
 =?us-ascii?Q?ZetWDVydJpJEXpY5ur9/zZm8P1KN7cPiK0w3P8CaHWIDtqbs7B2EsNfDcATp?=
 =?us-ascii?Q?6L4gS3o888pdxHM850W1g5qrbYgr4o3+ThvPytwlJl0FMr+DQ7saulRL4X23?=
 =?us-ascii?Q?jaPK1IB/IJV8gDxqYRcABHKSP1OhKvhzQV2xDgK/j0J0Q02F/d4Y+TsYLCTA?=
 =?us-ascii?Q?02YNPr3ifHkcx/ZSGnB/yFZ/fk2E8BpCnmjMvoma+xhvAaV8Tw7g52NzxI8L?=
 =?us-ascii?Q?DkwMqJt+VBT8+fS374ah23TxPzySc8OHaBVI9zoMZn0i72i1kknY/47D2SiR?=
 =?us-ascii?Q?QKP6+lyQX7h256YoEVDYAEaLB9gY7LgatQwZrfusjuCSy6qHLHQQAzX3xfqO?=
 =?us-ascii?Q?6Q5zPdt6ckBkxMHPyviQ0QLndCQ2B1nm5lLNVdy1XJUbP6IXUmNnrm/40ScK?=
 =?us-ascii?Q?JwFC5ifZnV715ShxefuhHOZv5skftMMQhdYRNVaoibgIhDgfX4FiH7vakAV2?=
 =?us-ascii?Q?pXufd3tnPoYg/47f4TWcmXUyqxV2avG1JJYjvGPdB40pSD2pRuoDU5gciEqE?=
 =?us-ascii?Q?0Bh5Tm2b7air1Z8ey4RBUw8pdSYEag43FmFAd1VGZdOvUkSDaS77hHF9dO5h?=
 =?us-ascii?Q?9r8yPC8jMmUQf92cT7wpdx/8YiMB6HRL9RFdKmjP2Nl2P1nDgvd6/qSqNo0m?=
 =?us-ascii?Q?B5sdXDL+/mCJWplNpXASxMn/7/578VDSwx40+36Wo1CP9beII6lMmXa6dfTx?=
 =?us-ascii?Q?4cxGmikDXch/5ypMHmuCWtCy32V4YEAzRbamYe0Ob0LqBaBZBiEYOkDxmk28?=
 =?us-ascii?Q?L6IzkrTLz7WIeTLDojJFKC7Jft/Pzemgi6bcixZBYd2axvUEhN5kDB2xfeiv?=
 =?us-ascii?Q?PQqx5+HnW8t5Ag7husfYP1tMMXra//WD8LcW88PMZ9eD+Rdqj9CABQZxANL7?=
 =?us-ascii?Q?6rdM1su87Ym68ZTkjYDQarVdUA0/WWwNfO3/Bqrd9xVqpnHe0p2mF533h1yv?=
 =?us-ascii?Q?0iOwJkO0PcxMBFShH8CZEB2rUiaeOquiwCxY9xDbCYSubSBSA09zMUu2uO2d?=
 =?us-ascii?Q?/86lXorF/FMRmanFba1UARm89ItjIEYePdFZs+wYR/k2IhU4WmUy4rIYyd+f?=
 =?us-ascii?Q?sRCDFvK4LxqhfSWuVzD9RIaOK4yoV9jWqbZzMkJa/O6l4WCakKsKxd4PbwR1?=
 =?us-ascii?Q?DrVvF4rVPmVfzHf9oV+fwG9UTrFpSbxqy/gktXryR6CKR2tgiyIr3Mce0ajC?=
 =?us-ascii?Q?CtHwcECpK36zzSoA4oKz775bRjcDdWvfqk9Vsd4M/RY5l4gNpjDnHVm4gY0h?=
 =?us-ascii?Q?Mlofrml35zXgMD/BgMqKwhxh/sFhjkpvUkecC1si+0WquTdO2JeIkpF50+0E?=
 =?us-ascii?Q?+VCB56tKs1MEu6SQlJhDbVbCbNieTRdmFsJKRIEw6igbAb0piVAydSsQ9Xwk?=
 =?us-ascii?Q?s91i2Wa61RI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffS4cK9GiJn7jju9kBcs2uZ5+XySKFSM70nSbLmtpkvdEYYPsTOKhMQ5aeUL?=
 =?us-ascii?Q?MDlrk66xhiqwD7sYKXD6rkCIUYZu84uvZVmY34t4TpfDfHKcw7AlxyaZ/BQU?=
 =?us-ascii?Q?DPTLMAyttK8xeA+M7XkGvLIVwtN2hn7VbmzWxcivwUxI9x3s/bCo2iQtc6Cu?=
 =?us-ascii?Q?0uSzNTJRt0BBuhLOSFnz0Z9wyXuenBUAVCYzOCnXw960N/HM15w0yHUcUeRO?=
 =?us-ascii?Q?gWZCoC1KOf23IQNWkxNjofsdEsnKdw+BnaKMXERrzAUEnvMUKcYmAW9LEZZa?=
 =?us-ascii?Q?6UsDta3DTWggydbLeXKc/1Mg9DhAex7tqBNnVjmWheGHpmfA/pL8Q/9reBvb?=
 =?us-ascii?Q?gzTrsrJC1s9ktVHOLJh7DoouCgiHfFFd5/eYO2g1cy7hgE6E21HdYzEyg6CG?=
 =?us-ascii?Q?NaTHs1Isi/cdfXIAw2+YrFqjOqjgMdyl37GBKXwOUZloceVRYQqfFKB5Mncg?=
 =?us-ascii?Q?do0PiHHp3EoVYZ5/H1SNyjPGcYqC5+DduiWKw0bnKi0H42Oe676Xl70HO/59?=
 =?us-ascii?Q?+MK0ZnxSrISvysRRDP/YTlukllzXAweKzbJHZIuIM52m0IcW3e078eX9Atln?=
 =?us-ascii?Q?p26TmUNpxk7CicB7TXvbbxThQRc9AOzXuallYRgUHq5BdXl5euQdZkIQcHiD?=
 =?us-ascii?Q?C/vNnnkZVd6LPQLDI2tPOShr6/PdOqf4utKps/N9TcKcL+px+peIGJrXrezv?=
 =?us-ascii?Q?wZAhLnaSOPP1HLM3vzHdonWvOLBFbizjFijvfMTwNcb3RLVoG4xqOtmsErki?=
 =?us-ascii?Q?S0ARfE+wgh4bY1HEZi13qBnbUiz0GLw2WXWifwQNR2way4goLQAcTgOL6j4C?=
 =?us-ascii?Q?2vtVGh6ZXLPpWXRv81brU2SKtsO0f2DkFmkToGTh0dF5g2BLOv6lhmvhbp0P?=
 =?us-ascii?Q?xYuDmnT975Fc1sAB+b4OUjVZse9W0nGtGR+5IQWt7Chd0vHYatW4wvmU87Qq?=
 =?us-ascii?Q?QQ1la4AX1Ghiq3k+UVPbzGbphHMvOsey0Z4q5C3nf6Upo1nPlavNLsPi5ut7?=
 =?us-ascii?Q?0gTo66HKHGdkyaLddKzgmZbqrIKPZF0SDOP2P5DEl/A2oYsTuEfzDTaHow/5?=
 =?us-ascii?Q?sVxT5ud4gFaWPfav8KziBLhI+EhQxSeOzeuffB1O/HROhTeSPAqODeF7QYEP?=
 =?us-ascii?Q?gwJqsGAs892D5CxQupAVLwpzbCCE+2bApLAdV6Iz0P2V28buteefFSGvmVaq?=
 =?us-ascii?Q?7qolerysf5BnJ+Q/abj1LWvj2msl0f/65642HqG61c4gMkIwqa9UO1/i2dHp?=
 =?us-ascii?Q?5dFcqVKZDyB54lbpC1TdQhNX+0ik2RnVaMANzHkK7zrGnnbyD6ZEbBEta/Tt?=
 =?us-ascii?Q?ZlMyG/966xcdwed1ca91bYR6RU98OfBfoasXWNaMzhaJvKHq3Qfj0k0Ar6dC?=
 =?us-ascii?Q?b7ukFdvzdRnJcYvL8GKND0xE7XyotJbHJBfYwV1f0apBMLl2kf397ib4moEF?=
 =?us-ascii?Q?B8KssU5Zh4OJVDjA8rLy0LVZ3HYclCE/P7M8e42BsBw7qWnLcgM+pQ8bLFZH?=
 =?us-ascii?Q?hXNv1vOoI1b2IcfWh2vseTgc62y/O8khYEfFamob6gN5i6aO0uGhpRVPYpof?=
 =?us-ascii?Q?6OR8y+Hz5PZWraCaY71jaxGZ5YvKwrHVJm7WmZYh7mTMjcpOZNwchRWyJZ19?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 232fdeda-992c-4006-eca2-08dd934381a9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 00:00:30.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/U5khBDpWgywztalc7RYqXyC7rjsE2fNa7KiLglKxDhQIspK5RCTyuE/uS8A5NfrICfMZ+AlP0pVUos+X5hNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:24:25PM +0100, Matthew Auld wrote:
> In xe_vm_close_and_put() we need to be able to call
> flush_work(rebind_work), however during vm creation we can call this on
> the error path, before having actually set up the worker, leading to a
> splat from flush_work().
> 
> It looks like we can simply move the worker init step earlier to fix
> this.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 5a978da411b0..168756fb140b 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1704,8 +1704,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
>  	 * scheduler drops all the references of it, hence protecting the VM
>  	 * for this case is necessary.
>  	 */
> -	if (flags & XE_VM_FLAG_LR_MODE)
> +	if (flags & XE_VM_FLAG_LR_MODE) {
> +		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
>  		xe_pm_runtime_get_noresume(xe);
> +	}
>  
>  	vm_resv_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
>  	if (!vm_resv_obj) {
> @@ -1750,10 +1752,8 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
>  		vm->batch_invalidate_tlb = true;
>  	}
>  
> -	if (vm->flags & XE_VM_FLAG_LR_MODE) {
> -		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
> +	if (vm->flags & XE_VM_FLAG_LR_MODE)
>  		vm->batch_invalidate_tlb = false;
> -	}
>  
>  	/* Fill pt_root after allocating scratch tables */
>  	for_each_tile(tile, xe, id) {
> -- 
> 2.49.0
> 

