Return-Path: <stable+bounces-76921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0A97EEDC
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C039F282BBF
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8221990C5;
	Mon, 23 Sep 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhSdhzzo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8F197A8A
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107500; cv=fail; b=WkE2+xDPK8lQXMTrF83Lg7vSIWkpV8QF5/vf+BTR28czAf0WK+fRP6zD7yVvu10RaMXvdC2x5lC75gsPV9Y34C9orbaKoPN6AALkRsukflGfaKfhudqhbsP+hsYk/c6RQKhoLN9S9rnjaaSRATV7xmUJGeiV0G3vxNwoHAJ6jx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107500; c=relaxed/simple;
	bh=sqsc3FY90vXfkiPoIsiKhVtlKo3hSw2rwXorAzv5ELo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7KlWOyt+LfKoUZ/Dd79yH3NmjHt9Vy5mNPv/LxHoZ32aAX07kawoO6rStpfl7NwcRJ8EcEPWHzrqSMOdaWqq3OxCp8UrTHD7/foWF7tSkcUlxtq8HU9NVTRNkD2x5abNKnlFDEhJP1frbjmmNuDMwR6PN69mK32rEmIQ6F76ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhSdhzzo; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107500; x=1758643500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sqsc3FY90vXfkiPoIsiKhVtlKo3hSw2rwXorAzv5ELo=;
  b=AhSdhzzoIyZKbCX2xLPFOLxMS1ZFpopZwQ/3No0aDkrutH7TbeYVmxnh
   ZBJ6lKKbodmQJ2vYYYIJYQzh6SfM+jt4YOpm+Xm+cxr06SEbX4cJj+ctl
   ZALtO20IoErDpk9QHd4xsAwWy7Da8DfrwbgM7A+OIZm5mNpJHfrItJYFQ
   jjmYccYTZaRMdbwMAW5mfW5LwPIQYlZAEaTLO3gbRtNS7GIVwX01+PNFI
   NGRTZdByASLH4GYjofAvHYQLAo3cxcJ+uHiWo6YmKpW0k2v5DDoHMb8FZ
   zS86dXqA7UQyLY2BIkYFnxsKbvR8p4KHF/LkPCWXa1ans8m+J0MvzGv+s
   Q==;
X-CSE-ConnectionGUID: TWZEKsztRNKuCcfCj0tusg==
X-CSE-MsgGUID: QUhAoUWTRMqZ92XlQnArTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26218014"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26218014"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 09:04:53 -0700
X-CSE-ConnectionGUID: uselj2GbRIeZV0r5s96JIg==
X-CSE-MsgGUID: WDQIAyfGQ722NjeQc6Bfxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71253910"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 09:04:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 09:04:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 09:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efmYul2TXq8A/QPz0oFX0B6yyQrAckDkn4UGODp0yEQjOocfmm+HbZhY/GAq8CWXHKXlwq8Yv0WECEFf7tc/d0DNnQv4GC8/E+for/8MOGPJcQp6izwQmDnV82fAUrDzM8QwZZBo23SkIdbykyzgsTYD0RfcR9E4wogjDMp0mCbAGyTFWhE6iuFl2sRboT5ddc7O3s0eLQ9RfSQb8Xki8FbsOn2CbOnj6yykUHCg8wYT4cpQh4H5KA27d4Wc4CT5+pA+ullKoU/UX55R1/jEGl8jbYS0hMQ4CiJNuxnTOIcoZqmQCtMKoQ6YjDx6CISROgmJUwG4qBGn14Go8UY8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngy9YE4L9TJPi0xGHep4lR3ld4a0WxT+wueWG0SHgM8=;
 b=nOB2sTdc0HpIAF5uznSpxSM25qHlQlD0vkd3A/r6UY0pNPy9YnjF6IUM7tcCGazFYvZsnvoBH/+Fs/6I+N4cHSHMfKTN0YiEd1fPrt90iUIa+9dhDhSNwrgRmnA7gKRh58ISC8B1O+FFneR/FTGOFSEckcHi0khYAChAvZygxiYq3EZ5BRlIFCokqGJUuA+I3fmExHp5MQAsmxOXGjkhBG9qZVO4uGQuNkTvoBAUcjUBeokpMt/7yFaFRdINSts0j7uNW0Hs3h8IuLBMEPa+F9xnd83BUrlBW5aIfwn3K+Ztc6QhW4Cdfh/u7gtnzKteWw2WazcsXB9fBErQEIYkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:04:48 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:04:47 +0000
Date: Mon, 23 Sep 2024 16:02:50 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/vm: move xa_alloc to prevent UAF
Message-ID: <ZvGRKhqS2a3X76lO@DUT025-TGLU.fm.intel.com>
References: <20240923125733.62883-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240923125733.62883-3-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: b477642a-9cf3-4cc3-dd34-08dcdbe9722d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nPtwG2G54lmOxnDwYhkpFCnxXuLdgq4Swk6F5m4Mobk5ZJHmU/yMuGqyPyME?=
 =?us-ascii?Q?m6ZmNh/g1bwFPR91gxYcyvjdIm+SkakCHNxJR8qNTpkZIi036zuzFSENNsk7?=
 =?us-ascii?Q?h3RRQZYazAVsdHRueG0BsLtRvJox3VGE19D19IEFKH/AEGgcpvD3T23UCH/c?=
 =?us-ascii?Q?/tHLZFo4vgYMJ8xagBJWigv8+asxhCithLTp0VYOG/wKEEPYEP95t9PL5iQF?=
 =?us-ascii?Q?XgsqYgDBha+V5b3tP0vb2X0Cp5D64txbumQX2q1QrXEM1jC5AT9+t4CrqXrf?=
 =?us-ascii?Q?qeUV6glVIj7YOHXDz/tgyd4JaUmdbE4LUWresnIoz64gDiwqNTuRngK8DQND?=
 =?us-ascii?Q?PKc3Q9YKJx+QT70jkCcqFWNHCcnrytWW9rEZjXD+ZUgaRfln5T2aL9LCgXyB?=
 =?us-ascii?Q?CdY8Y31tdOKHcl78GGKt/Wy9XhWMke3Hh9+vgkuV+YQn2mXqlWjorktUU4EF?=
 =?us-ascii?Q?Rzhtr5tiFNTKRwV1DIUPSjeW2aSuWx0W4pSix5hZoXKGy8Ho+ANblOTJw7Gg?=
 =?us-ascii?Q?CPKQTqBw2zgEG+6Lnuq04lGtycqc3iWToJ7mVVkQQBUDNfvFl/dvzxoLdHbD?=
 =?us-ascii?Q?8g/P/AhPhBp1Bt3UuhlQn18bL+6Mvbes1OzKRZILUCkGzzxH95FAogpyUsyx?=
 =?us-ascii?Q?8KlsLuQmSksk2e9tGXD1DS1ec3cBr/S7vpU5XCdK3PH2zXUuMXD1RA/4mWOS?=
 =?us-ascii?Q?GgwBoKOR2qfTM2fvXARjXXXsTVpo3BYHqVw8GQ1rFn4VqparNApTFzGGL8He?=
 =?us-ascii?Q?/u9I4WW0E05DnCHFsRdbGLbxkM8I+VYwOlaZauRGnHHOls0thB25GQ4szplL?=
 =?us-ascii?Q?cbmo+ileC/cSM2gHOASdt4HhXaQGOu/HhThKVsNnc0VOLsatNWxQoTAfTk2O?=
 =?us-ascii?Q?ib9/yVQkT3u2tdk3L442n3Gkj3ylbMQz7g7U6hsnM8ly7jQtpRc99bAvaqw0?=
 =?us-ascii?Q?Drj6cGtF7AiKT1hO+rRocmCZA7xliqk2HKsTH2pq6XZyFiQffMcFkZ6LMqPe?=
 =?us-ascii?Q?23IxF2k28oAQx4pRYIy9YhNnuSk5boLdGgCBc9rajdG9GTWbUwrtgrx0y6QS?=
 =?us-ascii?Q?iHbfuGXAq6Gj+PQPELiS/A+NtIgkiGnN+yWnWj/y0IAxNtvmjd1K2btcOTOC?=
 =?us-ascii?Q?j1Q5NTFmoetgsbacZgZNGJghKmC3N3pIVDGBRJYZ6C+RLbQtG0xrschcfTGq?=
 =?us-ascii?Q?DvSS9mXfkaX0zG3Psh0onebEWmsS2HTMvZzYY8X33yFuUqmwl39YT0tmaSwF?=
 =?us-ascii?Q?WpwyoIb0wz2uPSsAWJq+WiSX5Ex7F/wq37pcxC+WEKWGXEI4iXzShZMXLtEk?=
 =?us-ascii?Q?Mj0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JwpwOrJ0y8+lJ/WRRTsuLac37hOvLO3pDGCjAOblfUEBq0Y125Ro+KpRpj7?=
 =?us-ascii?Q?d+GieeL6iImWMW0EqoXYUZPes0rgK88xSfpGcyWL91J0sT4F0t+kIb3ZPxlD?=
 =?us-ascii?Q?qhCfYFMxI9mX7wwdQCja//DksGwt7SAjpn4JqDQVKESMlQY+iXIMCbrEsOFP?=
 =?us-ascii?Q?kespZGw8coyLTxVuF4XqvpE6GXErTpz9S8weY0Lhl1Lx+wr/MHpaDPFH+zQU?=
 =?us-ascii?Q?W78RdINuTgdtDr+XHCS/WQalm5+OQeb0NVNBlUVHBn9ctKK4jBvMPx/2u0AL?=
 =?us-ascii?Q?nsf4LQRVS56rqT8VoQA221UvUUUR+ucPsvqEzP1Llol0QodALROctzfEqEvH?=
 =?us-ascii?Q?0bJjRePz55TbcV1ggVkpX4fLEqdkjzplLeKxp1hS1H4j+7EsSJWjiotM1iu9?=
 =?us-ascii?Q?tv2Kz8L6tQe+Cy2lDh77+jsTpcc1hYNBPmGcW9rgubfCJjag7IJwXu/M8Tgb?=
 =?us-ascii?Q?2boAtF4DVvocksui595HjwqiA8K4L4fqyP4QbkI/+Cs9rQOrWjK7FuPWHawB?=
 =?us-ascii?Q?BHZlhrUA5AsGwdMlj44Ax43oilwjc7aKQELsnvsnLCsawoSwt69RyRDHi/80?=
 =?us-ascii?Q?BBcI/QqDRTQ6d+KNqb0tlQAqVdGZkmSGl03fXCj0xKcblmqTPNBL194a+Y86?=
 =?us-ascii?Q?bS6I640E5BLxk3Akw4c4xMiKVUAx4W7CQMjwRucHzGNLUqGztVwd81AlvtmW?=
 =?us-ascii?Q?ph2fQZQmNrnv91auYQENwAFOf3Xvfns42Foza4k1djMnuIaid5JGCKqCjSyk?=
 =?us-ascii?Q?dCHWvLIIVuZO/ZvAuQhHHfdwHknvPdJWoCvrv/tE/eqGi7UKqNspfzxvPlzv?=
 =?us-ascii?Q?NZLoqXlZrchpVh6Ce0lNthipUgXsBw1oLiugX13YljdKzuGPT9S4nf2YYDoT?=
 =?us-ascii?Q?F7zg556fR+7S4IQBA8tDP2de4rmx9z9UVcBQa6XW9c4OYhcwi9LqeRYPHnK4?=
 =?us-ascii?Q?ZPSNRjSFzGqzoJAtLlGtZiu0s1a1NH4FTLcsfyL/570HyFHXF0yTXx8B9qDI?=
 =?us-ascii?Q?i569U+M+1DM7Eo7Tgj0V3YTVZnbTzqZuLRloT38rnG4chPPcNIQQI/Udz+Yn?=
 =?us-ascii?Q?0vHT3Q10kk71LYri6NDvVHnQvxBYe5UfYCDUfcqNoRntOcMURDGuo44F8Avg?=
 =?us-ascii?Q?HopU7NLP6xneZpQ99/0UbjIBBf/VcB5I/RU/6b1oMIETG4HI8fxglw2pxDos?=
 =?us-ascii?Q?yuJhQQHyCuJ3tmJwnVnDosd+kcGcWXXGU7qxm+04RZvD66TzlV7dl08YUKxG?=
 =?us-ascii?Q?W+UbucNn9w8PGPlVrjCJwms9iK6mybcRziSy38aOOSpz2i9t0WvUo1xY1s/c?=
 =?us-ascii?Q?vGEiV9D8lrrogqQpi1n6nUN/0c89eM2LCR97lLiBUlM7Br59OgczYulHBPIN?=
 =?us-ascii?Q?huZvPoOqPFeeSsGgOOIjuyjZ/2/HrJ2E3JHMkziP/eHFhMsTsnhb+Gxx/hYa?=
 =?us-ascii?Q?aeYbP3lpDIWJ2gdR53ijRd7DDVSPFa6/piMtfdCOiwzWbv+GXSvzxJERDgKr?=
 =?us-ascii?Q?fYnnrciddCnXW17pfe7VngXneqb+NkbSsOCYL+54Nnfw1PB586p/0V6tjfqo?=
 =?us-ascii?Q?/xupGD8I0ud3dL4Fd/fBmxaes0VIkceizbgf6RlFSXpmC2Eyn86lSbVX/YKA?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b477642a-9cf3-4cc3-dd34-08dcdbe9722d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:04:47.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtns1gUl4uiy0UZAgol5ffQqoiYtSxCTv+K9HXL1eclcJSb01WhtJFudRVaW/5oDYZJzbeX5K8LfOBmzuH8T0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com

On Mon, Sep 23, 2024 at 01:57:34PM +0100, Matthew Auld wrote:
> Evil user can guess the next id of the vm before the ioctl completes and
> then call vm destroy ioctl to trigger UAF since create ioctl is still
> referencing the same vm. Move the xa_alloc all the way to the end to
> prevent this.
> 

I think this is correct. Shall I merge this series [1] first and then
you can rebase?

Matt

[1] https://patchwork.freedesktop.org/patch/615303/?series=138938&rev=1

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index a3d7cb7cfd22..f7182ef3d8e6 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1765,12 +1765,6 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	if (IS_ERR(vm))
>  		return PTR_ERR(vm);
>  
> -	mutex_lock(&xef->vm.lock);
> -	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
> -	mutex_unlock(&xef->vm.lock);
> -	if (err)
> -		goto err_close_and_put;
> -
>  	if (xe->info.has_asid) {
>  		down_write(&xe->usm.lock);
>  		err = xa_alloc_cyclic(&xe->usm.asid_to_vm, &asid, vm,
> @@ -1778,12 +1772,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  				      &xe->usm.next_asid, GFP_KERNEL);
>  		up_write(&xe->usm.lock);
>  		if (err < 0)
> -			goto err_free_id;
> +			goto err_close_and_put;
>  
>  		vm->usm.asid = asid;
>  	}
>  
> -	args->vm_id = id;
>  	vm->xef = xe_file_get(xef);
>  
>  	/* Record BO memory for VM pagetable created against client */
> @@ -1796,12 +1789,17 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
>  #endif
>  
> -	return 0;
> -
> -err_free_id:
> +	/* user id alloc must always be last in ioctl to prevent UAF */
>  	mutex_lock(&xef->vm.lock);
> -	xa_erase(&xef->vm.xa, id);
> +	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
>  	mutex_unlock(&xef->vm.lock);
> +	if (err)
> +		goto err_close_and_put;
> +
> +	args->vm_id = id;
> +
> +	return 0;
> +
>  err_close_and_put:
>  	xe_vm_close_and_put(vm);
>  
> -- 
> 2.46.1
> 

