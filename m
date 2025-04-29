Return-Path: <stable+bounces-136981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37133A9FEFC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743F3467E06
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E472D15F330;
	Tue, 29 Apr 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYEOTZ8K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77213D893
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889758; cv=fail; b=JZwKn19MFOIPY+oGLM6vjp3CX0b574adzRRIWPZ55cGtwPY7E7mKhlmRZVDKzXo3Ow38XG5NK7QoYK4GjR876mxZXGFgAmDpUNhvuXiQTOAZcocKqc+7dxmd5JCRC6xpr6vLVdTj6nLJnMPniSAmbxmRQkSgjd7PM6x1XnKIG28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889758; c=relaxed/simple;
	bh=Hvf+T75JqcEfw606eCfVr1G4+ijUfGGJgBVSCyIt1UE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CB9P06GyH7PAdXBAmem+0MUxpz6aJOWSyaKQ/Xz5ZRsg5wM6Hlq2hyr9DE6B26R80xL68bi1oNWITfxRvGckbjtbuo4Zevoetg3CXkgS2vAjqcpqCVt3qBuzKI/8egK8V8BsP79tDs9XZjRCmcIHP+wbKkJhAeYpROnr7MunVlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYEOTZ8K; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745889757; x=1777425757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hvf+T75JqcEfw606eCfVr1G4+ijUfGGJgBVSCyIt1UE=;
  b=aYEOTZ8KhaaQPmL0QkzTOQMONL6djnlJ4FgdSEeKg5qLwjz2+A20enx4
   vJi7Ib8Otp3ART1LIzFkQM/EfOIQevvD+MZcw5TZi4lQHUQJP9l+8tCJ5
   Lo+tZB0OS3ndi1A8ol1PF/7Byra3Ssd1r6R9xbPUbnpQJc3Hh2q5FAnGO
   GgOWLnNW21MSsbwvnEg3tEx9Qa0dpEalMsDiCjQ4Dcx29nhZNRvgRYSIN
   n4uFQXoSCnfqgXierRiLw89c4t7xYE/JO0glWWjbZPmo4NCMlzUwq2GPo
   VB9ayTTxS75BitK2zaVSG52KQmSBfBTbo/MPC1+vg0p06/TCheErzu3CF
   A==;
X-CSE-ConnectionGUID: H7dbTiexQGaJWzfGiOWnow==
X-CSE-MsgGUID: SBMYGCi/SKOsFf6SuDtPkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51313652"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="51313652"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:22:36 -0700
X-CSE-ConnectionGUID: AO2nAsHJTNavyF/EbH4UPA==
X-CSE-MsgGUID: L75L/tktRjKUxebaINtKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="138471130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:22:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 18:22:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 18:22:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 18:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBQ4KtmGMh4W0qe4zWPeWXjHVfcdPTkeloqIKyUcWd0VeHZ+wKprC5vuYEK6+pwBmEb+IiI7YM9uPbO0fefYFYb9L/oK5HHw/YhAIx7c4G3TQo74m3IGRqU1Sm5tCRNy08+yMDmo8lwVqY4LQWFtjdzpRwmNUaxwB369ZZAXAb7C1BnzZuPkBg/apunGGIEfqWrtV00/WnjWUnUBiWgklGbm/DFIvi5QqEzyz8ShlKsPRBjDPuQtIUimsylV0giIfT/Ne51KKcR5hvU06vrLOnpKgW9v+WcB3ICw96tkCfbAYe+fFKs60h8gT68E98c6x6q473TpbHWy2NLJmFc+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW9eRtqnFRoC4FTbyHlGE7FdwZB30zApv+9hWA0FVHA=;
 b=C8PjCFFV5fE0BCfW86fOdKLbUGi90ilNgjli/+QiqjaTmSDyI2thEySZ1OhnyjUQp0hbI2TbJdYrpcBsRgyirDNDPscOpt2GWLHCK3Haxr2F09MCrl9SVtmeY01YsVj3i+KD89AqW4evk17DgO7wJcKxhYs3N7n9GMukq+LVAebhb0zlY7w1w0QWIfxJdNQGTEJ3+H2xzd/eVH27UV+m9vkkvbSSww5ngKSjL4ckweFo+CaYzUI9xNPDszqQTP8Kl8lFxQaTmSbxWlKkOali2nISCcqKvkmvvMb+zkvXHgu2T6wgsnWP/p3gDs9+hkwEwVUQOuGCJnFYz4B9ksQMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 01:22:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 01:22:00 +0000
Date: Mon, 28 Apr 2025 18:21:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "steven.price@arm.com" <steven.price@arm.com>, "bp@alien8.de"
	<bp@alien8.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"sami.mujawar@arm.com" <sami.mujawar@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xing, Cedric" <cedric.xing@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
Message-ID: <681029b4e9f05_1d52294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
 <2872223857deef45c432d4b11f0a94b98fe21a80.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2872223857deef45c432d4b11f0a94b98fe21a80.camel@intel.com>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d62e6e-46e8-484f-8381-08dd86bc3dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2n17JWDPDniYUS3tx1L5vJFTR+c8MaOU/fK/hpx9OGVBuY+0Cq/9svK8b5SE?=
 =?us-ascii?Q?zS4ChHVWHgAoNHgr8ivS4yBumMSe8tY1MpclS3GVMgx1GbwQssOZjFQAeuW+?=
 =?us-ascii?Q?VVMovxrFKQnrzeAZzblg2XOFYSen750agCvGCh+In5YTQEOXBXM0Cx3ZEx7X?=
 =?us-ascii?Q?1snf8fO0SCmJewsgOwHj3qOKhqvSXVe8L39Cc2LACV03I+DSQclv/SkQ6I4B?=
 =?us-ascii?Q?lBnsntzpgbJFNLuAYWFl3PdyIjItG787/C8GfNN9K9s6iSJsW+sjmnBWY5kb?=
 =?us-ascii?Q?D5jj65W8GMEDX4//ZA/WKPd87vIsfZgwd/ddG+AUXqIox5A6M8WtDDYWKsgo?=
 =?us-ascii?Q?unFmCn9aZTyvghIW3a5eU7KXngP2Wdt0UNPJzQd5U1GnE7V/c+c+p/yz89V9?=
 =?us-ascii?Q?0y2LYPaXnQnF1Zh6i9DDYhZexO9rSyRIji3OY60KUbsr5OmaPq2Hl7BiV5fr?=
 =?us-ascii?Q?QRsq3F0/EAxYZV5jkIFGhB0a7FaZGi0LWGlX7LK3WkdDcWW5YskpZN91WOvv?=
 =?us-ascii?Q?wRJctbKh7GdAp7awsOnQqXqs3yU38zXJXzN+YTpYlu8BT8K9TGaoN7kbPvuN?=
 =?us-ascii?Q?Cu7qRmbYnVL3yCANcpRLQqoIwOvDvu2i660JuJvIeV6ut9o7Yt8Jxm6+j292?=
 =?us-ascii?Q?gW2PIPEp+QGzAd52z0MQd9rd0I1xHBkMc5g2Zd70ZBWXXFBUidn1UChaF++3?=
 =?us-ascii?Q?0oZtjIrjxIMWgXUSFCKKhDPQkT66fRDVmu+bOUPbnFGLOuBhfl8U+o4kyrGo?=
 =?us-ascii?Q?8B62Gd0L8wbgCT4BtaoJvmq14ZobBBx5E/yndUvL3Esxi5zSNToWDWj67s7v?=
 =?us-ascii?Q?9NUwSuOBj988yPoMlcp07QGkvkfuSpevdr3QFROZWOyTahqL2VnR4S+KdHAP?=
 =?us-ascii?Q?cG5Co1jNjjCcRLfBKEAMgpdUQswOwzhhnoUzLotn+zvRyPaH6i99YFXL5Q+i?=
 =?us-ascii?Q?xSMsQPMKrlcqZRtl792LMbiNJ+mcmgkrLytTFAdPU2iaeQAJxKm017tUF4Gi?=
 =?us-ascii?Q?NQXvq7GQRBK1iBh8mwUeKz6tlZZglqPjptZFt+YDc6TmgfnJiWRHVOdGOxDx?=
 =?us-ascii?Q?dJLVz/FcsQOCHMXD5DLFbowY3bbbCOySwzRCGknnyihL6aPVHXQSyozfdLIS?=
 =?us-ascii?Q?SEMWR7Fx3WBg/Mj2qjVKzI7KtHsgV0BDGx6sRc7wchGOKR9CnEoFxhvCxf5o?=
 =?us-ascii?Q?i3R+MATnhFXdPW9xwKM9YluVD3MF+AeDUOxQgdTwzVNlfegq7pFMJ4J5v4zJ?=
 =?us-ascii?Q?fEvD3e7HECVb6IM+rDChe6zAIWzA+fkBFDy5ZBfXiUGgezye5rBxPcIHVu5V?=
 =?us-ascii?Q?KY3SiI3Rjm1rDK5Yt8aBp5aaPHSoiiohVP+FrdFZmFnqpywPyNvrk+yWIk6J?=
 =?us-ascii?Q?YPwh9AKC6epr6stFiBdsaiERgObfScvItbAPf/uPnVmY5TJWyNnSu1a8AIgJ?=
 =?us-ascii?Q?TPCl9RjJvFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJZtmMNqVl8htHEakjLcJ9Vo7pqcVFHOe1fZxmTMC1Dmfo9l7VpiorOzITgQ?=
 =?us-ascii?Q?RwWt67Ise8wQ4TOqVJfF8K7cFVlwFUZkLQ0q7clia7TZQ/FePcHq4DtvhLMe?=
 =?us-ascii?Q?RG33emRDtEKFv5IggCNBHPN5J5RBIjVnn3kwdz5m7sr0IQDuxx4FtsD+N6SR?=
 =?us-ascii?Q?iF7Z5C6k2asp1DeNDTtNFXQ6oBP6ZTLHLzaaezmgEEmIff80kqcGs8UlWNsu?=
 =?us-ascii?Q?a12hOkJhU1FIte+rvm3EZcXbmj7KS4lzjQnhGXvRb1sr+1wooW9hvFgHkCN+?=
 =?us-ascii?Q?Hfwxdt4xnzFpQ8B14ZCPRh13xUl5hMfGu0sq6pq1BpJ3SSPX3SmB2j4eLyty?=
 =?us-ascii?Q?SlPSgjHE+SQYHKErtFvjvPCljJNx4gjw+rHTZobGKTQ/HWowddU/MDRiUYrm?=
 =?us-ascii?Q?JLZhtsvBzm9uY2uL3Y4mPsfiDS9ScbbfdyY0p1ZcYBdzDvHg+dVnSBGMVdP1?=
 =?us-ascii?Q?WKz64sKPQ/Xf71mHDJISFRvNUszj+kxy0FrckF6lBlJ/Q96zadtPfszP+lhu?=
 =?us-ascii?Q?8dD2PSXDFJgrmd+sRl+CJ59h1f8ycMIj08o2C36keDJEfUCM/Y+ZjSkqkAaR?=
 =?us-ascii?Q?vU0EhQPMvYEB19Vh9WOjwj7XzQDg4mr+BEiIK7PyZypBXwCZZOKK/2S80dQA?=
 =?us-ascii?Q?z3Jb6DrkafbrxTin7yqNq1BTy5v5cnJBVOI3pS7TZjWC7vpMwrMSX48QMx5P?=
 =?us-ascii?Q?+C7YATNTq3YVZe55tbj7IgAKSKsQpLTF5V8QZpjKYkwS9WQEwhdXiJd+m7Re?=
 =?us-ascii?Q?QGMBGQvu3SR8LMLAyeNVbkw1scoRiPFrN+4nzjccCiwtNBIN/NivbxAoBa6q?=
 =?us-ascii?Q?SSagqKDmS06KSJ0BTMU8KrioGvLs6ym+wQCiwz1a7uLP8YCDkvx+R5oLlsgk?=
 =?us-ascii?Q?jTvya5KtABOX9kiiEKFUX9tfPyEKKpiePoN7X0qkBaPeRVoQ3zwFZieBKvCT?=
 =?us-ascii?Q?sjgXIrVd48u8IerYgOf71zWp/b54GIIpONfmFjM7DXkgjCuSUWt+6Fw8MRlk?=
 =?us-ascii?Q?0IHf1WK0FBcQIdC35gMGtC0Dop1RcmC9YjKu/+4YGg+X0O+Xc/ugw8BSgh8a?=
 =?us-ascii?Q?0k53TzsVcQYdnS98TsJEQbdCC2NcJ/UE2fElz5qVSFvJW8GwckeXgq5ngAQe?=
 =?us-ascii?Q?SneQ16RZX+Zz/5grgGuVddrc7aUOLD8r0EB+6XhL/If783Uckv+Pcs9sTuCK?=
 =?us-ascii?Q?h9rDWTauaoku4vHyZGRMrtIgSUtKEWbCLx5aWpiKNZA6BjIzk71MG+sWlcZm?=
 =?us-ascii?Q?qYODInH1r+q3hHjwkpc+zwT+135TkHjySYPEx0hT5+URC2TbbEM0eTmMi7Vu?=
 =?us-ascii?Q?JfDkdgVIfSLRoTeaFx4qzp0qwLpKKC1x9CntYDHD4cG81lW+0/+dFCZEjLSo?=
 =?us-ascii?Q?HLtgXP2/KjcD83HZwcgK5k+xu60BfWb+HxR04RFhQqtIgOklDgkXdBBHPzi2?=
 =?us-ascii?Q?SSXCH3PO+Q7BSjkIJGAWO+kK8ROC4NfilEM1IRwN7UKkz5dJuaa72002fdEi?=
 =?us-ascii?Q?F9iUzK1uGqVs3+3J6gIYWs6c3hX3j840Tfzh0lvume60IDa+GfuXzPaFa0AE?=
 =?us-ascii?Q?Ufy454suEBkp8YhLXL2642sNK0zTEyuMnUvSO7+5NGh4rYfGd0Sc3dOjK91w?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d62e6e-46e8-484f-8381-08dd86bc3dbd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 01:22:00.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwmgkCAZ/AS2sB/LPI8S/bxZE2ZoC7em2+xFOLrb0bc52nKskmlWzQylyiWLQR54uRt/fa1AWQt3vXHPETQPpwnb/GTqik6x66EI/IqeT0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com

Huang, Kai wrote:
> On Wed, 2025-04-23 at 14:01 -0700, Dan Williams wrote:
> > Unlike sysfs, the lifetime of configfs objects is controlled by
> > userspace. There is no mechanism for the kernel to find and delete all
> > created config-items. Instead, the configfs-tsm-report mechanism has an
> > expectation that tsm_unregister() can happen at any time and cause
> > established config-item access to start failing.
> > 
> > That expectation is not fully satisfied. While tsm_report_read(),
> > tsm_report_{is,is_bin}_visible(), and tsm_report_make_item() safely fail
> > if tsm_ops have been unregistered, tsm_report_privlevel_store()
> > tsm_report_provider_show() fail to check for ops registration. Add the
> > missing checks for tsm_ops having been removed.
> > 
> > Now, in supporting the ability for tsm_unregister() to always succeed,
> > it leaves the problem of what to do with lingering config-items. The
> > expectation is that the admin that arranges for the ->remove() (unbind)
> > of the ${tsm_arch}-guest driver is also responsible for deletion of all
> > open config-items. Until that deletion happens, ->probe() (reload /
> > bind) of the ${tsm_arch}-guest driver fails.
> > 
> > This allows for emergency shutdown / revocation of attestation
> > interfaces, and requires coordinated restart.
> 
> Still, is it better to print some message in tsm_unregister() to tell that some
> items have not been deleted?

Sounds reasonable.

> > 
> > Fixes: 70e6f7e2b985 ("configfs-tsm: Introduce a shared ABI for attestation reports")
> > Cc: stable@vger.kernel.org
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Sami Mujawar <sami.mujawar@arm.com>
> > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reported-by: Cedric Xing <cedric.xing@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> 
> > ---
> >  drivers/virt/coco/tsm.c |   26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> > index 9432d4e303f1..096f4f7c0c11 100644
> > --- a/drivers/virt/coco/tsm.c
> > +++ b/drivers/virt/coco/tsm.c
> > @@ -15,6 +15,7 @@
> >  static struct tsm_provider {
> >  	const struct tsm_ops *ops;
> >  	void *data;
> > +	atomic_t count;
> >  } provider;
> >  static DECLARE_RWSEM(tsm_rwsem);
> >  
> > @@ -92,6 +93,10 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
> >  	if (rc)
> >  		return rc;
> >  
> > +	guard(rwsem_write)(&tsm_rwsem);
> > +	if (!provider.ops)
> > +		return -ENXIO;
> 
> A minor thing:
> 
> I see tsm_report_read() returns -ENOTTY in the similar case:
> 
> static ssize_t tsm_report_read(struct tsm_report *report, void *buf,           
>                                size_t count, enum tsm_data_select select)      
> {       
> 	...
>         
>         /* slow path, report may need to be regenerated... */                  
>         guard(rwsem_write)(&tsm_rwsem);                                        
>         ops = provider.ops;                                                    
>         if (!ops)                                                              
>                 return -ENOTTY;
> 
> Should it be changed to -ENXIO for consistency?

Also seems reasonable, will fixup.

