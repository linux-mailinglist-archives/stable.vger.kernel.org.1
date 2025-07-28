Return-Path: <stable+bounces-164942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631EB13BA0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF2117655D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452425CC4B;
	Mon, 28 Jul 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKI3vOaN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579E43147
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710050; cv=fail; b=Xsya7wDjxvho9wtmuOD4DfoNPgiDz7WIFB1aFawdLplfJ4Cs8I+XLm+hjW6N9LVUReXETqrsHtC15aCNuYLqnx2xu0KU3qiKyrZRDB7ftqRqAejYwtaKvV9E6DBv+kPWUNcsu+FKdGLntFVK8Qi9EShnJQwQGHMkvP3ANfAYlxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710050; c=relaxed/simple;
	bh=ysFx9FqB8RTjhadcAZ+JGknETvre9hUg2HVH4a6zfuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MXbl038hpNV6NUawBOOIvKAUYFRa4Jh0xbySWbaXro/z5uo2Vn/yB5Gn57Oc9M/OG8mZRvR/+j78GTDa5J+T+qgA1lwAJvZRSI+GJuwKsghrzQrvdvKouUS7MlKwOMI9DybC/Kd1Abco3w3CiCEwtQ8ulY6JhqmQjctVCVFjkVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKI3vOaN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753710049; x=1785246049;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ysFx9FqB8RTjhadcAZ+JGknETvre9hUg2HVH4a6zfuI=;
  b=iKI3vOaNfwFc/woenuUdgwn7h3Ew/heQxBnaajd68qwFoj8oHrhP4rcv
   XEyYuJzxUFpy2/+T1CajUsVhGzb8aws9CqrYhWOuDf1kUjNRHkQ0EQY6U
   53jAdm7mNZEy4YTI3FVk8E2p/EHpx80zBoWkY2BcDLLGikpZAO+H3IGOZ
   meC9Oemdg/hs023O0wYPU4+P5JaJ2b5j4Uy3Q6IwZDrLwO/XG2JA6x39V
   hkWl2R/NaeCBQLHDdgZCrchbVE1HPy81GJJ2k+oMVZVmSGh8tEAfnK8QW
   4I1U2THg0shDHnqcg8lqt/+aPptSHDNsqx+7geQOaQLNTDSjCBkA2rbRH
   w==;
X-CSE-ConnectionGUID: mZZCD4ObTuO5w2d4xGNFQg==
X-CSE-MsgGUID: XYEb8HYzTuaTaGF5rrz82A==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67394473"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67394473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:40:48 -0700
X-CSE-ConnectionGUID: SESzz5oXR7a3m/FbLDV6Qg==
X-CSE-MsgGUID: sCs1IIEfR4eBKTqPkGm1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167743419"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:40:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:40:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 06:40:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.74) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuYXB7NilVTHRP3L1DY4YMvKrve7cuOX4DebL5T5ZbV9cL5g8FnLUF2AWFdCW2p/wC2IzQOxQSpKws9cTD1T38MA4K3o8x3UHofATY2UlIcy0uMJqeKWN64EfWp2I03OpOBT34WCg78eJ81Qky91imgfgqFXrbRTpTtmisQWX26jBCpeYqH/5kLgnyCMBalpMZvI9lQAuWrUk2oA0gSzJN5m67RdmBJjxtBHZnkIsCIe+dJ7Gla0pIUizLowzjEchlZTl7gQgtg96ES34BrJQWs7kLe8Kjs5h3NqP4bnjk2qXP4dPX1wTIVsLBFG1vdBSD1TpupuMEbu3Vl/yinm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xDQKE6YyHf8guGwgbDZEkwWntvROStqaUHOpD19Odw=;
 b=Mcy1Sj5Y+5Fnl124mvLCH7syalzWD8NqvKLHInp+Zl0rgMu98lae2It1WjTA+fDFFSyDKuN403VCVKrtG05l3GzJn2PCut+SV3z5VGvVyR9vQGFTl9nxitG7Xtk1wPM1aS6C3Y5rYaTlfRHy8+ir5I1YoQ2iIBw8FG6vlNv5TxozPTohRkhAQATFpPwbWaCn5/SWlHcgBy3uzc+HogzFL9FdohCRaZNmaKIvdeDKMC5bgCKF2FoTGhb+r7RKIGuOlNJWiu+ilUKI7UErw0cKrVhna7zTMe6m+2BARpx0gTGtNRUdTXKTalcji+onE/H7m1Wo/Zs+ld063fvJOUjqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CY5PR11MB6164.namprd11.prod.outlook.com (2603:10b6:930:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:40:44 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:40:44 +0000
Date: Mon, 28 Jul 2025 09:40:39 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
CC: <intel-xe@lists.freedesktop.org>, <jeffbai@aosc.io>,
	<stable@vger.kernel.org>, Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang
	<27873200@qq.com>, Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu
	<lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>, Shang Yatsen
	<429839446@qq.com>
Subject: Re: [PATCH v3 3/5] drm/xe/regs: fix RING_CTL_SIZE(size) calculation
Message-ID: <aId913JnePy516b4@intel.com>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
 <20250723074540.2660-4-Simon.Richter@hogyros.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250723074540.2660-4-Simon.Richter@hogyros.de>
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CY5PR11MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 483698b8-63a6-42ca-04c7-08ddcddc59b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CNQmm/NiVA/sSK7+yj4m963WTky58EUmhph8Ss6bOn5upizkLzWWTZLNVri6?=
 =?us-ascii?Q?olfqbGEQWdDUdyk7u3qRBG698R1PI2mlmvpxy8w6XN5dGdy8/ClkYXzM5n/3?=
 =?us-ascii?Q?A/w0/PmQWJIDCPzAbN6m3DVtBEAChSL+0GauS7jjAgxgEdn8LsWVcCd5BYMV?=
 =?us-ascii?Q?h189/a1ZbhFjB8ZaT60RQp28IZ6vraLtz2pX9c2CwyYXl/tW9rzRpnu54YVo?=
 =?us-ascii?Q?b5Mr7sP9GD+IgFOnq6SlwrP+14nFXiyRbTAhXk27odOT555aQJWNHFPbZcyc?=
 =?us-ascii?Q?/sqjF2Rr1u366IRdF6IIoePU2RYiK77UJSmiolpg3Zr9FuIB94YEt0FwXc3d?=
 =?us-ascii?Q?CMxr+Yc7ZkYKdiDd7h8R8+tvtb+rQ7490pVV4ZSJZ+1dptSLRaXR02s5wxIK?=
 =?us-ascii?Q?00Ykx4+fngJnbtt9HXimoMzgV2VdErfRtC97j1SUP+xC4h05B0KPxzDX6iUC?=
 =?us-ascii?Q?4yMyDbfAPVua5H6/l9EuF4SdYLyKdLd6FGYOxCDdjWCBdUakMBDJHfLAb0qW?=
 =?us-ascii?Q?vgz0ZwYJrTs8Bwj18ztwzIiJ6jlOHJTagXLUOOnz/9vR4tH44tgS2jUIYR21?=
 =?us-ascii?Q?6vf+Ij+Goe5QuAiamGuvu41tlAAKK2EwM5+whORznYvO5+v4tREsasEv4sYz?=
 =?us-ascii?Q?+w7u1pqzl+AT+/2xmXM92qMJgkP+cthQpx8Hz9mkcakZQU4TmqFLoMcdrlCz?=
 =?us-ascii?Q?JITLEJHyjpQNIUIAK+WpqhMBBFb4ShoOM4XLjOT2csCbJQFqKLVR1rJm5TOD?=
 =?us-ascii?Q?ZkUIIpLyucJbjPpUsidx6jIBmhS5B8Km+fjaRcSFRm/SpRNdRqBDbkYqR5xJ?=
 =?us-ascii?Q?GsMJcq3xKg/H9FAl4v0M51nfhFBem140ymfwhR8etqp81pX3gMaTZicYNYsH?=
 =?us-ascii?Q?Ch1ZD0ie//HfcKAbZQA8LkS3XL79GNPAS6qhQ8Y/m4xIns9JJqmCyTc1G3Y8?=
 =?us-ascii?Q?HKE307oznGn/gHI3TMG+mFqJWNKejLhGNgmII+/DYSNPbLpVXRF13SLD/jXz?=
 =?us-ascii?Q?W4H0J+GA/XKdlm1hPm2wRnLb20dnXQUsaqJTbL+dRP64XcK1sXnbk2yWqao/?=
 =?us-ascii?Q?ey4nM42Wn/etLQrgMHyim4RLa7QhwXVtatD6RGzuP6fk/8WtZiVzLaQwQz/3?=
 =?us-ascii?Q?hc1BF0b5vpAl7lFm8Wr0k7fAcgHwzL9e9EahfuJOCxXEIbbPNfB5J2ImC46o?=
 =?us-ascii?Q?xLn79HNiAArN+k3eiv/0iDa0G0ya9N2C1NagQY4DnwX/mozvbO7Kd5sN9nzV?=
 =?us-ascii?Q?iWHk7s2cBcMwk8KkY0vvgcVUxqtxUxIK+v6rDIzjGxfJZl9h0wGXkT1sHMp8?=
 =?us-ascii?Q?75BZWRIJ5RFe2vZzETowMERIUW7NPNYicMXBFW+HqRnypHLyVuSaePCosjrg?=
 =?us-ascii?Q?Z/6J6QrtCXYkNYu6OXlXfQpEeq5+2j6ypmJaiU5ouBSkLzt7P9YbNVvcMM2K?=
 =?us-ascii?Q?ExE5+whG33Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2IqR8n4biTa96aivFU9W3Vxyc2QHBKfx1pZpYKYZyGytR9cdDLUFkmT/6ukr?=
 =?us-ascii?Q?ThkDwdwQm3qAfxjWIqpY0KQ++tGLX12niopmLWDEzbevg12NVcYcQDKvz7N3?=
 =?us-ascii?Q?KcITPeqNDhh69PnqvCGLwnyIfp1RWpyUxGx29RDVNUacKRPCVIsSvZeC9NWc?=
 =?us-ascii?Q?KOmsEhbdRlEibj3XUyAA5NDu17DXCiRxT70OLOzT99ijn2nn3+9un/EsBIsh?=
 =?us-ascii?Q?RkP49+FJcuh2SqHRT4+YM/GmS8sxKFcY/8Ou0aCac4NYJ01wiWNK8bqYUViP?=
 =?us-ascii?Q?UZWyJTCMxhutUhlZXP4EH5pa4P5XOwNAacfdwVhGB5f3A0QuUERbPFNk6cIO?=
 =?us-ascii?Q?WquKUvCHxP+ydVIzR3YDgQI6agtTL9vTeLU7dwWabaKJEuyVGv0uJBd1lLOE?=
 =?us-ascii?Q?ftYh3e/0RI2Vr+FZvGPaFkHH8tmwXG/380B/UPcMgMPkHAFVcU0MiA+UiQLF?=
 =?us-ascii?Q?NSAzjIus1bQV+fuVf2Cg6XBBJ9WvilKaJiseZHKibGVa1wDMf/LBZhIn5fp0?=
 =?us-ascii?Q?rRYk3HnoKLRGTmEN2nvfquhT8oAT8hDOByf5GxZlIXsK1WSuQeJbh1xLZfUH?=
 =?us-ascii?Q?gBR4q7u4KwZyOfka4D1kGIWvJi/BceLd01jgBLoHAJxxvgZxC+iZQUJc80BL?=
 =?us-ascii?Q?2FZMskZD1D7jvOVQlcChoMm+1keCNERQZawz3Es5B9AfWt9bWhmO9BC6jJ0v?=
 =?us-ascii?Q?swAApnoVsqvJYiHzDtvlfSuZid8oTqSzuvw86lrlQVw0kArsQGCkTNv9kXos?=
 =?us-ascii?Q?JqgUFjpSZjmCqiYpC6cL8akFN40icszBX7U8O2okTV8Rm37zaBdUGbyNpfCu?=
 =?us-ascii?Q?TIl0jRKQbSFPIjt7v5lai3Sjm7G2zJNqPaZolkC81ZICF9xwCZEhhRu1huP+?=
 =?us-ascii?Q?B8qZTJSUGAuuvDAeCL6QWeK5H8duDXBQkRdPWY6ISfzGZlf6MfaHy9agX8ax?=
 =?us-ascii?Q?waGRCmUL/NK6Jiuy99NmfutWZk7WjjD2fNW2UutvgV6jUsbpj0eHiymzVLL5?=
 =?us-ascii?Q?7nkvRefMdlih5bnJetW6MhFWDAaR63oK0F/6Kj8sNnnnxXD45SpaPZBQEN95?=
 =?us-ascii?Q?CGED1H5y44mrKR8MrsvPF5bthjOVSnNN5aDeVo0M+4BEI6cSi7lNA5GBv6xC?=
 =?us-ascii?Q?0mlPZ7yJbcZ+O4W9n+A0q+SrBk20QEh0umWT4RvaDDPSv1yozBJujb6dNT1m?=
 =?us-ascii?Q?nBCkLYH41eQDCt2PQN3JrY5FRkAbozf/E97slKiAxYSMDhsGHODdWKAW9ZcR?=
 =?us-ascii?Q?vX8PTc9VyjxSdQBYodfKRgXVk5v7r7kd+bGxeQirdrnsyaeU1eUH/3SsPkw7?=
 =?us-ascii?Q?WSiqZDFP3Vd7uMADFi7S4cEUCL/o5aCf6w5cpZRq/4SU/IQrXnPf0BSlKerr?=
 =?us-ascii?Q?l1t4tiblllGTQU1gvpkVfu67ahFxL+1KBs8ie3qa98fuI4WHw8O7cWKt14Ai?=
 =?us-ascii?Q?NYdfZlcy62trdU0KZnFiS+5dlquRsmH1Ctd1KF/NYu8CLEHrVoLFvj4nOdxY?=
 =?us-ascii?Q?XC1qv7JBHgc+WRZf6cA1AsMYLkZ6i6mq1x/yuQFiepg3ORnqY3YduIC4U8Sw?=
 =?us-ascii?Q?ykGkpmT6hcyylXHfiEFotZONrBagN2OGS1z/nuMY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483698b8-63a6-42ca-04c7-08ddcddc59b5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:40:44.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEwIKFbuOBEEPhl2s7NikvadVUcObRXI+tBf+g63pt/MgoPL3XliD8i397wMWXagFuVU/15xEHTHnutdU70uEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6164
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 04:45:15PM +0900, Simon Richter wrote:
> From: Mingcong Bai <jeffbai@aosc.io>
>=20
> Similar to the preceding patch for GuC (and with the same references),
> Intel GPUs expects command buffers to align to 4KiB boundaries.
>=20
> Current code uses `PAGE_SIZE' as an assumed alignment reference but 4KiB
> kernel page sizes is by no means a guarantee. On 16KiB-paged kernels, thi=
s
> causes driver failures during boot up:
>=20
> [   14.018975] ------------[ cut here ]------------
> [   14.023562] xe 0000:09:00.0: [drm] GT0: Kernel-submitted job timed out
> [   14.030084] WARNING: CPU: 3 PID: 564 at drivers/gpu/drm/xe/xe_guc_subm=
it.c:1181 guc_exec_queue_timedout_job+0x1c0/0xacc [xe]
> [   14.041300] Modules linked in: nf_conntrack_netbios_ns(E) nf_conntrack=
_broadcast(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nf=
t_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E=
) nft_chain_nat(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) ip6ta=
ble_security(E) iptable_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) =
nf_defrag_ipv4(E) rfkill(E) iptable_mangle(E) iptable_raw(E) iptable_securi=
ty(E) ip_set(E) nf_tables(E) ip6table_filter(E) ip6_tables(E) iptable_filte=
r(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) snd_hda_codec_hdmi(=
E) nls_iso8859_1(E) snd_hda_intel(E) snd_intel_dspcfg(E) qrtr(E) nls_cp437(=
E) snd_hda_codec(E) spi_loongson_pci(E) rtc_efi(E) snd_hda_core(E) loongson=
3_cpufreq(E) spi_loongson_core(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) snd(=
E) soundcore(E) gpio_loongson_64bit(E) input_leds(E) rtc_loongson(E) i2c_ls=
2x(E) mousedev(E) sch_fq_codel(E) fuse(E) nfnetlink(E) dmi_sysfs(E) ip_tabl=
es(E) x_tables(E) xe(E) d
>  rm_gpuvm(E) drm_buddy(E) gpu_sched(E)
> [   14.041369]  drm_exec(E) drm_suballoc_helper(E) drm_display_helper(E) =
cec(E) rc_core(E) hid_generic(E) tpm_tis_spi(E) r8169(E) realtek(E) led_cla=
ss(E) loongson(E) i2c_algo_bit(E) drm_ttm_helper(E) ttm(E) drm_client_lib(E=
) drm_kms_helper(E) sunrpc(E) i2c_dev(E)
> [   14.153910] CPU: 3 UID: 0 PID: 564 Comm: kworker/u32:2 Tainted: G     =
       E      6.14.0-rc4-aosc-main-gbad70b1cd8b0-dirty #7
> [   14.165325] Tainted: [E]=3DUNSIGNED_MODULE
> [   14.169220] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-=
EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.0575=
6-prestab
> [   14.182970] Workqueue: gt-ordered-wq drm_sched_job_timedout [gpu_sched=
]
> [   14.189549] pc ffff8000024f3760 ra ffff8000024f3760 tp 900000012f15000=
0 sp 900000012f153ca0
> [   14.197853] a0 0000000000000000 a1 0000000000000000 a2 000000000000000=
0 a3 0000000000000000
> [   14.206156] a4 0000000000000000 a5 0000000000000000 a6 000000000000000=
0 a7 0000000000000000
> [   14.214458] t0 0000000000000000 t1 0000000000000000 t2 000000000000000=
0 t3 0000000000000000
> [   14.222761] t4 0000000000000000 t5 0000000000000000 t6 000000000000000=
0 t7 0000000000000000
> [   14.231064] t8 0000000000000000 u0 900000000195c0c8 s9 900000012e4dcf4=
8 s0 90000001285f3640
> [   14.239368] s1 90000001004f8000 s2 ffff8000026ec000 s3 000000000000000=
0 s4 900000012e4dc028
> [   14.247672] s5 90000001009f5e00 s6 000000000000137e s7 000000000000000=
1 s8 900000012f153ce8
> [   14.255975]    ra: ffff8000024f3760 guc_exec_queue_timedout_job+0x1c0/=
0xacc [xe]
> [   14.263379]   ERA: ffff8000024f3760 guc_exec_queue_timedout_job+0x1c0/=
0xacc [xe]
> [   14.270777]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> [   14.276927]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [   14.281258]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [   14.286024]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> [   14.290790] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> [   14.296329]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
> [   14.302299] CPU: 3 UID: 0 PID: 564 Comm: kworker/u32:2 Tainted: G     =
       E      6.14.0-rc4-aosc-main-gbad70b1cd8b0-dirty #7
> [   14.302302] Tainted: [E]=3DUNSIGNED_MODULE
> [   14.302302] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-=
EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.0575=
6-prestab
> [   14.302304] Workqueue: gt-ordered-wq drm_sched_job_timedout [gpu_sched=
]
> [   14.302307] Stack : 900000012f153928 d84a6232d48f1ac7 900000000023eb34=
 900000012f150000
> [   14.302310]         900000012f153900 0000000000000000 900000012f153908=
 9000000001c31c70
> [   14.302313]         0000000000000000 0000000000000000 0000000000000000=
 0000000000000000
> [   14.302315]         0000000000000000 d84a6232d48f1ac7 0000000000000000=
 0000000000000000
> [   14.302318]         0000000000000000 0000000000000000 0000000000000000=
 0000000000000000
> [   14.302320]         0000000000000000 0000000000000000 00000000072b4000=
 900000012e4dcf48
> [   14.302323]         9000000001eb8000 0000000000000000 9000000001c31c70=
 0000000000000004
> [   14.302325]         0000000000000004 0000000000000000 000000000000137e=
 0000000000000001
> [   14.302328]         900000012f153ce8 9000000001c31c70 9000000000244174=
 0000555581840b98
> [   14.302331]         00000000000000b0 0000000000000004 0000000000000000=
 0000000000071c1d
> [   14.302333]         ...
> [   14.302335] Call Trace:
> [   14.302336] [<9000000000244174>] show_stack+0x3c/0x16c
> [   14.302341] [<900000000023eb30>] dump_stack_lvl+0x84/0xe0
> [   14.302346] [<9000000000288208>] __warn+0x8c/0x174
> [   14.302350] [<90000000017c1918>] report_bug+0x1c0/0x22c
> [   14.302354] [<90000000017f66e8>] do_bp+0x280/0x344
> [   14.302359]
> [   14.302360] ---[ end trace 0000000000000000 ]---
>=20
> Revise calculation of `RING_CTL_SIZE(size)' to use `SZ_4K' to fix the
> aforementioned issue.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
> Tested-by: Haien Liang <27873200@qq.com>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Shirong Liu <lsr1024@qq.com>
> Tested-by: Haofeng Wu <s2600cw2@126.com>
> Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c324=
10a077b3ddb6dca3f28223360
> Link: https://t.me/c/1109254909/768552
> Co-developed-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  drivers/gpu/drm/xe/regs/xe_engine_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/x=
e/regs/xe_engine_regs.h
> index 7ade41e2b7b3..a7608c50c907 100644
> --- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
> @@ -56,7 +56,7 @@
>  #define RING_START(base)			XE_REG((base) + 0x38)
> =20
>  #define RING_CTL(base)				XE_REG((base) + 0x3c)
> -#define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> page=
s */
> +#define   RING_CTL_SIZE(size)			((size) - SZ_4K) /* in bytes -> pages */

XE_PAGE_SIZE ?

or perhaps we should kill the xe_page_size in favor of only using
SZ_4K directly?

But also, this makes me think about the previous patch. There we should go
then with XE_PAGE_SIZE or with directly SZ_4K instead of creating yet anoth=
er
define exclusively for GuC.

What I'm trying to say is that we need some consistency...

> =20
>  #define RING_START_UDW(base)			XE_REG((base) + 0x48)
> =20
> --=20
> 2.47.2
>=20

