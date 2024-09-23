Return-Path: <stable+bounces-76923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE097EEED
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACC3280F5B
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702319CC3D;
	Mon, 23 Sep 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cka23t39"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCB46B5
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107869; cv=fail; b=JzaUaoXHSe35ot61k5ytxyiAUmqN4JBEvSdP7ivzA0YpWxwu1zoIqL9RqcnaLi5guswG75pjmbdcAseVwNcDK0lHXlkIX86CLsZSdC5ccZ/QxWmBaS3JwnpibNHf87dWtSie7uYtvhfvFBw0ikvSF2v67j9tMXA99+WiI9tciLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107869; c=relaxed/simple;
	bh=Qa17BPlz5XjiSfuus7AzMqt/hrrPs5oWI4iDqYQF158=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WdDUu+cJomcuKbq2l05T8YffsaLludRhV4NPHKxp9qqksVH+w4cNTtk2YuQ4Zq9qdp2jFmRcUQdQNqxPfoINycqCr9AnT0NUckpgXmnyn+cCY/FTQ8aWZEhf+tV5yetSBJ1kbc8uKaF0GB9EXwYvu9LQBIdEBV44nEMZaJE1NHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cka23t39; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107867; x=1758643867;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qa17BPlz5XjiSfuus7AzMqt/hrrPs5oWI4iDqYQF158=;
  b=Cka23t3955GEwVUrIeZYzNbmj0FD61JgxTf9Y6BKIn3jHKS5GvCjTu/v
   scbeuv+thXFfB+O6RqMLcwJM4YnbdCNSWKCT6Pm128nhdqnfGiX2Z2A0x
   Pu7W34IiJFEYsfWtFO8k5qbMsDOWrroL3W8A2Eb9DnT5nGYN7IitwokaH
   4mB3DeVOT4Q/BfktwpbEatEh1ny6ml9EKiZOmOYn8nZ015JvObe3/e2cs
   qzGDPjXfk7lOTxsliahih+UENq1SGxJijwjGhDajWnMgBfFWVwPu3Fkfl
   X1TXexnGLGtg9mYn2gbWxcl7ODxVkwwfMPBzHNFRKY18SUZfCR+fSeDxy
   w==;
X-CSE-ConnectionGUID: uK/07aaTTXybpY4m6DqfJA==
X-CSE-MsgGUID: rhLjL+TuRzaeryKKrb5G+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26219691"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26219691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 09:10:10 -0700
X-CSE-ConnectionGUID: EwApHFCuQfChTmNM3XU54g==
X-CSE-MsgGUID: T6oGX6ayRBqIoKrKyvMn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71257070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 09:10:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:10:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:10:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 09:10:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 09:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK8LWJLjEBDPAdONf9xRgrHHfSRHNaGCyOE/b4T/QUBpUDd8Eu2NwmoX7lkky5jSoPLTMq0IffepMC1Ov6YHS3W1ZgTY7pFmBHslO6/aG/sgj2KNaV+gIv3tiN1dzV5UE5e/VSC/H7merwrXmAxhC/ADpwpIXwJsWjVD0LIPR5vvSP9nlEIYAhUMpiLLvbjkZNFsuddHhMbXHcQRyv+kxUMtVSBPiDrRwTlsbo35w3rvc8idM48cL36AdAX4TTxQfE2tryvU5FTnk/4Dx7dcbmxFLdrNQVHWQnnMvYtqzHZsJwK6T/K7yf0pCQnZ5Wap/AKDEwKVd8n18rPx83VhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SblH5zgS30U9RD8fxwQDhxin6/RfgkMGHZ0ewxmOqHA=;
 b=UBuSm2A/j49+ZZIYP/XPOIRxw6iNtnn92A/syRz+iO3iBCZ89FdQXSfG4w0On9UF/I5wjIUQDxmQoWAOJww3yMmhzBrh61SzwgxVCsNn8Vq+Ok74QIAhqOHkwg/+ZAxwn6q0hQksNFk6TAo2IrjEqwhPrSeIzjO4B6Wmur6tth4JwrF70yL0/qPUGPWifBwPsu9PRntHroBbGQiLUVRLz2EY6G7b25S1VZCbBGGx2OgfsFCVQ73vtEPO9TsoYBhQkQ3rcn9R179b0IewR06/GM/PHgrmFTItA01N+PmcFvgCJoxIpuDdIgC4l7mWxg7kinWAqgk960uMRc0tAVE2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:10:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:10:05 +0000
Date: Mon, 23 Sep 2024 16:08:08 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: fix UAF around queue destruction
Message-ID: <ZvGSaJACPAOFHrF5@DUT025-TGLU.fm.intel.com>
References: <20240923145647.77707-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240923145647.77707-2-matthew.auld@intel.com>
X-ClientProxiedBy: BY5PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:a03:167::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0ebb1c-1126-4dd6-2c39-08dcdbea2fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tobx0p68MCJHNOPmMNoGpHo8pTwvnUUSFhtaG4KImWTCoisuGO7OxOngdXKw?=
 =?us-ascii?Q?kV1pc+soCF+5Dz3UuTub0rqayHxCms+RRJKiYVrRZTmCDjpSrTSHpa5ceLdG?=
 =?us-ascii?Q?cP1EfFborGtOfKfCNui8vglk90xWaF57xtNEgIN3zYCUB6h8zpNn0FPk5CBt?=
 =?us-ascii?Q?xRGuQSzyuFnnlzGUs1tKbe7TvPZrLNTt5whkydFlnykjGUIWqMbnvOMqXKiY?=
 =?us-ascii?Q?7523DcxRiPOXaCfsBkVM6CPLsi1pXVufP0NK5jDTuG+9dsIzx2PD+TCCQYNU?=
 =?us-ascii?Q?xREeB2ubzwCosIDnnhWGab3QwyRBIbfyB9iirGUUgxjxxbKpWwl8HdFlFoty?=
 =?us-ascii?Q?nwln54Bm/Zq0iVrTQOBvErcP7YYkfpFbZe5CWjbCevHxRLYDeOyoly2sRMsQ?=
 =?us-ascii?Q?VxWkIyD4T5TzrIe1cHKz32abUHiaue/ZaezNJ/+z6w8M5Okeco2SA5jkGPbM?=
 =?us-ascii?Q?E1sQChOg/c2QYt0Dd736C+dIDLCuMXa1pbY3p13KUZDZ+vpUVTJPFCNAO4tF?=
 =?us-ascii?Q?GeoYVkNB9kO7zgNC8baf7caJfp4pYIEJu7xGx9IJ7uN8g4LVoP5jEgqAdX1R?=
 =?us-ascii?Q?OOWvn9e7UrQcj9y03wHsb5lkczOigrltSIcMxN72iprHJV0Ns9vF7NPpJOn1?=
 =?us-ascii?Q?CeDaJA5xLBpvwJ1G/ZzmQAWCrmTe5/fcVo5okUHxnIGLVYj7TU8bERfsOLhT?=
 =?us-ascii?Q?CcV/auNMJxpxvTGv0Z5yv/WNZIR5MGxRUFgvoDFlNYrw18YiNGcdD9EI4PWA?=
 =?us-ascii?Q?b5mSEPUVUlYZ9pV61U7tsixKWsStibVJhx/SLrMQ6tDcWD7P9XqoLvyFig8J?=
 =?us-ascii?Q?Yxa109eVwkCOtKM69jZpePo/PhZLi7wfg6AWUkANUmoe1TQevBmkXhyyEAOw?=
 =?us-ascii?Q?ucXD4fVI/beX3lvK6PyHpsbClZPkRuAlSX2oyjFjatFoDNjfaVa/1a9/Vgam?=
 =?us-ascii?Q?mP70lHEBoK58BSLVa8OZGbRyL0xwrYOF6ofolxn30DFvkkhsEFV2s4w0Y3IK?=
 =?us-ascii?Q?AJv2QdPqdr9rncx+GRBBjNa22QIq1JAMLI/VJOK9Cflsu17ciCP47OHHuTm5?=
 =?us-ascii?Q?0GAQWQRHyuSGG9/0e2QsWVh//b5UrF0xX1Q8Hlog0AY+BJ+vdgFZbWu13X9J?=
 =?us-ascii?Q?xUcclTg3PSfRRlArKucKyu6MRf3KQpb5M5tuEv+jrMuXR8nmF/ynLlptmx/b?=
 =?us-ascii?Q?zNeuqNbRkv0Ge9JUpyvOPykvRtFxPe/k9UBTTvhfGCuXyu7I5DBKZ9WqLCs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wNY4r/kqOv4m4IDqT2LXsfCWGA+5tS2q+c4gpA723DimXuCUuvQkVJoTuGy?=
 =?us-ascii?Q?p8vWV6JdayQoC9YwbM0V7ReDOsODNeM8NwwfWC/NDjMJtLcpnjzA96wpgGkd?=
 =?us-ascii?Q?xqVNde+rrQuvW0e4WYlQPEFesZZ7MO0L6/XRwmMXCc0r8CLONbKymJRMscBB?=
 =?us-ascii?Q?0SzYpSSxgbVbd/gY6Dcl/guAx4Q0mTQKugKBReoVZPG5TSfFyhj6vEK9Gk/7?=
 =?us-ascii?Q?Tno5ZCwWOQSWaxIRWlz6HvOApH95nIIlrB+qk8rBBXoPm6Tnkyczx34N1WFA?=
 =?us-ascii?Q?RITC1zRmn2M0wQDOsY3QzXSsaRAQdfOI+5WjyBmQwkvM1NqBkBWSqbMPEpXX?=
 =?us-ascii?Q?xljrWO6xIGB4TyLPckDUJYP2XWkYVSVxJi1OztP3l6v+eu6xssUVu4qPhbgO?=
 =?us-ascii?Q?ys7houy0X5dhQX0+6QrZsNYB6iws5LD/seCglSyvGxY1VuYeQn+u9TqaJiTW?=
 =?us-ascii?Q?MQ6mngjaBPTXWh4cRsBcXksc8rE92yidqXIs1JFa1a7y+JLEUuGtVK+0TwwA?=
 =?us-ascii?Q?iOT4f0G+Ct7smOxb5zQmy8Z7H/g3tP0F8Tsu7L5F6JmHNAEsZXpED12Pr814?=
 =?us-ascii?Q?6Ud5N3vuk1FoWvS+ev56wH55g+m6qWrPHSVlfQJBYKIxL2aPA+Nq2SICGi7E?=
 =?us-ascii?Q?GNyjv1b+bFT6eladm0ck3kLBjdyczaeD6zPpFkMR3d/eCzL4VyjDEVI2hU4n?=
 =?us-ascii?Q?NBK48AWk6QJG0dgI9yRSZQjR1aW8eYAJ09zfZC8SRE2Y5PUWcCvCg3PNVaUc?=
 =?us-ascii?Q?1+68msX5stQEQD6yuuh7arvldXxwE4AE66uYNyI/lrFGHXzLS5ADNGTVLMzF?=
 =?us-ascii?Q?gxkTzT5yhQQQbLV5ZuCvGmXqe8e4GGjExQw62bZnI5kzJaTptGABWJ3KqcdV?=
 =?us-ascii?Q?R+0XMswATiLqaCEbFt/2biGxn75U1YkZnm4QauZ42sFIIMbfA9RSRdjjzR+l?=
 =?us-ascii?Q?6EKDT7k97s6b3L3mO4Ybw6XLqQhgJkKFXDLXFqMBVUpglfGNOaQkvjAaU7uT?=
 =?us-ascii?Q?9Bjf5gWvqhsB2pio7dyINWFByKfdaCiWucXGVpbclEQPAY8+UEkihUeFhmyt?=
 =?us-ascii?Q?laihxJchOy7RayucFNwMGODflIZ0k8R9zBWdNtjaQHRow/SXnH2Joe/5z8uB?=
 =?us-ascii?Q?Yy+9v4pMpis5PotZ91NonTodZSKyoYA0/jFpyts8GrMrkSEa4Jb8NprKTUpB?=
 =?us-ascii?Q?y6JL2yuI+4OxYdEjPJJ0uVOQmiM8sMhIkDXecFl7irVDTbpOE3XBufJgassF?=
 =?us-ascii?Q?0o5ow/KZw/OS6s75d+4VO4C3ezwBvTTG7Of7/imX6/TmTg34NLkFi20J8JBj?=
 =?us-ascii?Q?glfBIgMz37BvpUSk5UqMLxxp+Um0qHGnIKAKTQ9XU4oxkS4Q5L4hDWo+R/82?=
 =?us-ascii?Q?KaAafZAcI1oMEyY6NDHCLPPElmempiEy7/5GDDFYNvpyO1iL7q+BiYnzxnin?=
 =?us-ascii?Q?hsAsuopm2iqcRyQFdPHDQeIRwxkcpnUc5SAg2MJjoV450vCLwmlRasjTg/Ag?=
 =?us-ascii?Q?z9Mdj7lk8kXvpNGz9I5jDWq4pO1y5TPo1aR8fEoDPsuBvEdJxfEamffZWbxL?=
 =?us-ascii?Q?lQm7SKP5mhaqK5yNrqdRLy4pblW4J8+iwjKSfg38GitGP/hf69k5K91nhWb+?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0ebb1c-1126-4dd6-2c39-08dcdbea2fdc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:10:05.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGeLBLuxbmKn0o8SCyKJkarq5CVTfuo6Yum7ieEbIc6SLGS2nIKmAbiEE9FOstTg6opPymgapz4T80i1ZrMWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Mon, Sep 23, 2024 at 03:56:48PM +0100, Matthew Auld wrote:
> We currently do stuff like queuing the final destruction step on a
> random system wq, which will outlive the driver instance. With bad
> timing we can teardown the driver with one or more work workqueue still
> being alive leading to various UAF splats. Add a fini step to ensure
> user queues are properly torn down. At this point GuC should already be
> nuked so queue itself should no longer be referenced from hw pov.
> 
> v2 (Matt B)
>  - Looks much safer to use a waitqueue and then just wait for the
>    xa_array to become empty before triggering the drain.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2317
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_device.c       |  6 +++++-
>  drivers/gpu/drm/xe/xe_device_types.h |  3 +++
>  drivers/gpu/drm/xe/xe_guc_submit.c   | 26 +++++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_guc_types.h    |  2 ++
>  4 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cb5a9fd820cf..90b3478ed7cd 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -297,6 +297,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  	if (xe->unordered_wq)
>  		destroy_workqueue(xe->unordered_wq);
>  
> +	if (xe->destroy_wq)
> +		destroy_workqueue(xe->destroy_wq);
> +
>  	ttm_device_fini(&xe->ttm);
>  }
>  
> @@ -360,8 +363,9 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
>  	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq", 0);
>  	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
>  	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
> +	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
>  	if (!xe->ordered_wq || !xe->unordered_wq ||
> -	    !xe->preempt_fence_wq) {
> +	    !xe->preempt_fence_wq || !xe->destroy_wq) {
>  		/*
>  		 * Cleanup done in xe_device_destroy via
>  		 * drmm_add_action_or_reset register above
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 5ad96d283a71..515385b916cc 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -422,6 +422,9 @@ struct xe_device {
>  	/** @unordered_wq: used to serialize unordered work, mostly display */
>  	struct workqueue_struct *unordered_wq;
>  
> +	/** @destroy_wq: used to serialize user destroy work, like queue */
> +	struct workqueue_struct *destroy_wq;
> +
>  	/** @tiles: device tiles */
>  	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index fbbe6a487bbb..ae2f85cc2d08 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -276,10 +276,26 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
>  }
>  #endif
>  
> +static void xe_guc_submit_fini(struct xe_guc *guc)
> +{
> +	struct xe_device *xe = guc_to_xe(guc);
> +	struct xe_gt *gt = guc_to_gt(guc);
> +	int ret;
> +
> +	ret = wait_event_timeout(
> +		guc->submission_state.fini_wq,
> +		xa_empty(&guc->submission_state.exec_queue_lookup), HZ * 5);
> +
> +	drain_workqueue(xe->destroy_wq);
> +
> +	xe_gt_assert(gt, ret);
> +}
> +
>  static void guc_submit_fini(struct drm_device *drm, void *arg)
>  {
>  	struct xe_guc *guc = arg;
>  
> +	xe_guc_submit_fini(guc);
>  	xa_destroy(&guc->submission_state.exec_queue_lookup);
>  	free_submit_wq(guc);
>  }
> @@ -345,6 +361,8 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
>  
>  	xa_init(&guc->submission_state.exec_queue_lookup);
>  
> +	init_waitqueue_head(&guc->submission_state.fini_wq);
> +
>  	primelockdep(guc);
>  
>  	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
> @@ -361,6 +379,9 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
>  
>  	xe_guc_id_mgr_release_locked(&guc->submission_state.idm,
>  				     q->guc->id, q->width);
> +
> +	if (xa_empty(&guc->submission_state.exec_queue_lookup))
> +		wake_up(&guc->submission_state.fini_wq);
>  }
>  
>  static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
> @@ -1268,13 +1289,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
>  
>  static void guc_exec_queue_fini_async(struct xe_exec_queue *q)
>  {
> +	struct xe_guc *guc = exec_queue_to_guc(q);
> +	struct xe_device *xe = guc_to_xe(guc);
> +
>  	INIT_WORK(&q->guc->fini_async, __guc_exec_queue_fini_async);
>  
>  	/* We must block on kernel engines so slabs are empty on driver unload */
>  	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT || exec_queue_wedged(q))
>  		__guc_exec_queue_fini_async(&q->guc->fini_async);
>  	else
> -		queue_work(system_wq, &q->guc->fini_async);
> +		queue_work(xe->destroy_wq, &q->guc->fini_async);
>  }
>  
>  static void __guc_exec_queue_fini(struct xe_guc *guc, struct xe_exec_queue *q)
> diff --git a/drivers/gpu/drm/xe/xe_guc_types.h b/drivers/gpu/drm/xe/xe_guc_types.h
> index 546ac6350a31..69046f698271 100644
> --- a/drivers/gpu/drm/xe/xe_guc_types.h
> +++ b/drivers/gpu/drm/xe/xe_guc_types.h
> @@ -81,6 +81,8 @@ struct xe_guc {
>  #endif
>  		/** @submission_state.enabled: submission is enabled */
>  		bool enabled;
> +		/** @submission_state.fini_wq: submit fini wait queue */
> +		wait_queue_head_t fini_wq;
>  	} submission_state;
>  	/** @hwconfig: Hardware config state */
>  	struct {
> -- 
> 2.46.1
> 

