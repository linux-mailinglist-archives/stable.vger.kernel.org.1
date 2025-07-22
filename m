Return-Path: <stable+bounces-163715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A354B0DAD9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F10A17F8B3
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D2288CA7;
	Tue, 22 Jul 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqSgYoUX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627022094
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191045; cv=fail; b=j0Ccfs9++hbtzU4zHCqgFe9GnU7Zm7rUrUEKuwKXTsXfrc4iTXUYzyd1pLIEf1Y3xB9i/THdBv4zjL/nkUJPrkQ10kjZLuRZ+tZJGpZNT6AWqAKQT4V927f2FU8vDB77eWsiYg75dMcH7cub3oFLG8umvYdFEhiKmqVMY06n6UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191045; c=relaxed/simple;
	bh=8Te5FrQbomwH/LMY19nPFuvEneHkp1Wz9aXbVnF6Hso=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WEjPI4bJbAp+uZioGmGfsEb4J2F0/N19YwnD3X6WO/X+2dU+cOa3y2Fl9Z5AhVm8F6YTzcdkuEeozF+SeYB7wv0Dr/CBGGX1MUGQrqo/qyNpL3Q+AlpkC9UugOTuyHuXKCcxJXVcPNeLJNphydEC8gzLPKYrFiVg+xzji1Br3hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqSgYoUX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753191043; x=1784727043;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8Te5FrQbomwH/LMY19nPFuvEneHkp1Wz9aXbVnF6Hso=;
  b=iqSgYoUXdFZjrf68vD0xHGLAnlnYZu/WHDVHEVu/NYGtNrmWL7gVLXhM
   4AlX/4cELgQoL0yrxoAhTZUyGw9usDnpAEvsN7gMc8+LnXbzz9KvscKp+
   eza1trS5RoAkBlFjYnniDiJMk4kiLELp135xmtfY/KNBtyU2z2GJ4VEvH
   7OmDMMmRDiL36rmqIQ7YMeFfF4phDoQZCckoJxASEdvASB7TF1Q0HNgYn
   RWW9X/bkz9ernQxaNz694IEPInAQBv6ddMMKoKiTkDpWjw+v1vjabMn/O
   yAGIjcpZgFvcvJH+WMFQL52KIoh1XdSC2BXGgLBU21XN1Twr30e7Y+AJS
   A==;
X-CSE-ConnectionGUID: QlpnV5kYQveNpFxSGCcegQ==
X-CSE-MsgGUID: OLZ3ECWMT5WX7goD/j18Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73010718"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="73010718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:30:41 -0700
X-CSE-ConnectionGUID: Qg2y7vF8TJacVLchWvmhcA==
X-CSE-MsgGUID: 7bWO6T5iTRaiXBKvxyGSXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164609947"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:30:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 06:30:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 06:30:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 06:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo5f1gdYksBLxFjfpWRvXZgSdivjtYUJD1YLPS8zvtCNIvUJpwAp6DMCKzozG+BETSopVOd3VFy2dzuwE+JdFxU+r5FUwyY7CpENsjUE8sexUKCYzimRgvyOnwXTmomPdGPdfGAfOFhWcURFtK/geaB8vkfJSgf/WxX0wzX57+6XJLnJp/8hufqhm7zZidTcLYG4/Oofx7DzSUCdBdLEPn+hfKnPusoEIoqo/Irr48zDx+eK19zptEkiEs5ojMAGdnq8djvzcQUuhGiGT7RmHaIfmdb5B2NyvmiJpqx7AkVhwib+sBu+d0Gal4bXNpB6eEchsjjDul/rmus+Aprd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH1gcwXjFNhr7SjjxBAlzZPrvDnRZQt7uvOErG8ZvE8=;
 b=a7w9i05zPCAELC4zh2Gk+staNMMGvhSYJcwIqxhLzPNUuxsvYOqmFxEVPUZJ6j2Sjq5ZgnHwVvLgle/wZbvVRjRo1GfDpXOuVc4Rf4pyMsnc+P1AGAV7lpYsSVrdAyvv80VtWpjumiQ368YsQTmuBF1EVoe7RcHAYdkd8/tn2LVmETr3YbcTuYEjr9sPtSXxJOnHDjGeigPHMEtwUcKz2ySU1RL67xfm7WOmhkEC16FFPG92E6Ul6/StCQ+l8vqtxED6asdNXhZpOYCokJLPXrJT8U/HmJ8eu8QxuF5XEjjAKRdDrPe68DUPm3y5KyHDWuEYYjVPDAcNS+d7MjXFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) by
 PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 13:29:43 +0000
Received: from DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8]) by DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 13:29:43 +0000
Date: Tue, 22 Jul 2025 14:29:32 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <qat-linux@intel.com>, Damian Muszynski
	<damian.muszynski@intel.com>, Tero Kristo <tero.kristo@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <aH+SPEqs+qf8jiDT@gcabiddu-mobl.ger.corp.intel.com>
References: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
 <2025072202-partridge-utilize-9db7@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025072202-partridge-utilize-9db7@gregkh>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB8PR06CA0027.eurprd06.prod.outlook.com
 (2603:10a6:10:100::40) To DS0PR11MB6374.namprd11.prod.outlook.com
 (2603:10b6:8:ca::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6374:EE_|PH0PR11MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d7681d-af1c-4cf8-9b3a-08ddc923d19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/2fgSuxGc8PamNPcxAzkAYSb8EYYncZpjxaOdpSIrlKmQAwmZmCUceW/tIoZ?=
 =?us-ascii?Q?3MTLGKRVSETQ/atO1fjBGVBiU2hFnQIo9XhuGFxg5hPCcVG61hOQakyU5vcx?=
 =?us-ascii?Q?59i2b1WLjAa5EtFCQAXJgr9sbcH425CfME8rQAACCMi68r4PsHjY2d9DEDvP?=
 =?us-ascii?Q?QubenGFZ+sQF5N7x3NaEk9uVfkEkRUwwCjMqHLbb1i2lYlig3vm/UwxXB7Rw?=
 =?us-ascii?Q?jF9nTWfpY7P02/gxoqZElT3fnGgrR63feaXEm2jlJU1gD34FOWLF48NfRmFB?=
 =?us-ascii?Q?nQLtVFreJ5sxK/+xDv3ULGCNFjXbVoOJWM5hZwQfDIHReW5G8xdMUfE8sXVV?=
 =?us-ascii?Q?TDtBPrDXNka05PEe8/q9ZOeTcNbOz5eLk+m7jcmAR5kOlZnzirWdPlx8qza3?=
 =?us-ascii?Q?FJzzX0f3NR94AlqXUZA08ejHawzYU8DqFoxXAefU/eMlASV1pIV3sb/Ss5hB?=
 =?us-ascii?Q?oOEYopb2SdIgdCZbBZLf6fYXpjPCpI+BnlbioTAUGN8Qz8EvvdlsUYS82Y1x?=
 =?us-ascii?Q?EyZWW6FsJszb9uAMDgQXlSbZyt4OncYgx+kTwUMnVkvT8Jji1FvqDOEkTJR7?=
 =?us-ascii?Q?RBFnFqinctgKXfSCQcg2VbuU3mMlXEXK9Nx7uv17df4ILCKou/xXr+njGjus?=
 =?us-ascii?Q?rrF3n7Bu0tsWdrWJa8vV4Ov/YLXYiF5CmD/B6SNE/O1LhjHaHsGDIRG+SHNa?=
 =?us-ascii?Q?DWfkGQl5n1MIEPh/IHmm/FU/YrXi6RZ0DiVpSQfVGY3gxTrtcGogBDy9XqXe?=
 =?us-ascii?Q?DmMXbN5bSHmcI1FRsYBU1Bi5l68AZaLtdUse63qz8sAXEc9MXnhTOsFT2+LT?=
 =?us-ascii?Q?3P3C5DPqnUdiDQ5nyypi5kOL/zR6+hBxCS+iyLFsAaOMPKYgs4DMiYdJn6LL?=
 =?us-ascii?Q?dfJ7Wd+Cvf3nGYNFKXyNFrXX+wKMxoUq5nfqQ8UStdQFYZMQpN9pI462HEbJ?=
 =?us-ascii?Q?fZZcbXASxViUSlUqiiZlx54pgVwPZi2PCKDI6yJC+oiNJubND5+m3yZ5pUVt?=
 =?us-ascii?Q?Q2PZvU6/tpuqgQt/MgGzB1Xiqa4UAQmY2eIFZDZUnwh6nEwGG3lt+F4Kj9CH?=
 =?us-ascii?Q?WcNEY1IHXi8chxbvlNFeh8sldcYZ/33c5wX4OHbCj875IjNTi/IABd+SeTJ1?=
 =?us-ascii?Q?U89aW17UWNllVa3VpK5FSvxEDzZtM+KWAogaaj7KOj8PUO7V8viTrFQ3lVFh?=
 =?us-ascii?Q?UeidHWfCeASZjzvtvo8pG9rWwz49VQKcFoZFWP/t+pqJ8hGmrz9GyQwPo/yj?=
 =?us-ascii?Q?/U7ejEf/GBcek04WSbnjqFeD/UedhQ+Ue2fowz3PUNS0/RS3cn6f6bxb13iJ?=
 =?us-ascii?Q?gkEeXUjBRbF4H3LJEXENiZdcjdxptohvd55YZs2IKwP85gMIk+B3YKl29rH9?=
 =?us-ascii?Q?5kPmHIXOam+JxxLuX+ch0+dqoUV0ErPm0N0chWkdkNDASih676TUSchALev0?=
 =?us-ascii?Q?AfjAra32Gco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6374.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfyt1wCU5kbWUkSWkb5wpwRsutb3l9+rQiudXf5k1DqVEF8OFa52ykmMM6+l?=
 =?us-ascii?Q?Gm0zwYgieBVH7A5DBe1YXI0My2d/1K6aJYyKTqKERZxNjxAHE6EBH2A/Cg6O?=
 =?us-ascii?Q?58XitPkJcvu2TxyvXQ/+L8rPdE0g0AzEGRgwc/OCkA95r4BBuYM1izMwG6YO?=
 =?us-ascii?Q?V4plwgKkehFG0wQwej8RB2uhGKvNvUz9qQvOsCGVK5wb909JkHSUrjizYZdt?=
 =?us-ascii?Q?jUTzyp7m96DjVB3s/QwusPrn6wa1zSKiSGb+xAbXOa8AaodYHbD2rSfcZgLc?=
 =?us-ascii?Q?t4whpBAeBvGq0jXWVrUxSd2viwtO2QtVStIjrHOGOLJAaaAnUymJkPxOARRb?=
 =?us-ascii?Q?mEmC/w/uXWuR1oOQqrGCUWIhIY0m5n0TT05+uqDkihfi2LCDfROzHhVXOVgP?=
 =?us-ascii?Q?uEB7wFJYP9Dp/0OJGeHn92ggv3jXRsH5czcuN+/n+Ha0uUeVcL3h7vwY3eNW?=
 =?us-ascii?Q?DyWkfZpYKMFAZEENTfC0+rNF6SiqQj2gOKHSu2Cy0zKb2/t4wqgj5HPSzfq4?=
 =?us-ascii?Q?0kRn2Nt9Wx8fGFiRBDHKzftEslZlg7SkwuFl1CSvzOtXrEjcYIEZC0IJSRcp?=
 =?us-ascii?Q?x+YmVuTwSCMj0pi1bCx3T9Ms5WioLCzqyRRrKXhUHXiAXpyf6yQ+oH01mJSN?=
 =?us-ascii?Q?pQ4I5V5xKQjoFqT4/j5nWB2mxhBLvOmUI3rGe1zUa07t5pnQYRRAUQ/qiY/E?=
 =?us-ascii?Q?JpGPkYUKHyDPYSrj8XOKOxJG7CxhZIN090sjjzmQKPZ9dBGHttlb8XEx5rSW?=
 =?us-ascii?Q?DKzk2Qxa6BSxpAmNG09ALv2nBRcf2i0xhkR+2UzVbBmJKmS6g/E0vPP2BPEl?=
 =?us-ascii?Q?6h8CQ7W/CzqGuduHKY3Nm3JrmyW70fwiskdF+AuIWejcC5cVd8hRtmJ/Y1tP?=
 =?us-ascii?Q?sgCI2isNk2sX+JqlscuJaRs92iVxhoDEa47siuQqzsIE5jcgiBs9x2nPxUpp?=
 =?us-ascii?Q?k60HxY28WCeo18l439a2013MTTJ6/G63lTeEFzyQ+9k7nVLE9yY1opCv233G?=
 =?us-ascii?Q?XrdzzE1E+B5IufK4LxXy2/IXsMrnKlbL8PVeD92ISmZVs+Pjy3/9W2yPQvta?=
 =?us-ascii?Q?m6T7IJi9lah3k/GrLf3j9Vc9xSwiCuMW2xfWdJsbalZ7bLpFfI46Df2JqBfZ?=
 =?us-ascii?Q?Cv5CVtn8ZfJVZwdarXy5GFNjqeob9WIu28VwwYKls6KE3Hmkng1ZpI2n4Y/j?=
 =?us-ascii?Q?aQIWPaHsomgnCvpU4xLpFXgC7aXQuNgV646oru6+X0NflVLdSbaYZqox6QFs?=
 =?us-ascii?Q?HALUL0l67dYlLDekGP4pmq6ECWJbUo6PW+0XbzFlm37xfwO5z5qw45GnaBs8?=
 =?us-ascii?Q?lZLOI3wfz2seLTAlM1cL7OEFYxg/bm/Siq7QObfNNao5v+OwcHAa1Y+VAFNw?=
 =?us-ascii?Q?38BEwzjFm96HP2z5UXMemfaHFQubY78xbaGBjov6Rh8szxqQKsZwVCBug3kY?=
 =?us-ascii?Q?CfU3gSoztW6BFv3+uNkamZIEgyWL23u2fIS5KGqeaNXpN5/5lexdgRbmwl+n?=
 =?us-ascii?Q?i2Y7szKFGYJC24wTs02Nt6tXPUI6ykiOuM6KxCwPodwruZPXxCQ4UCHOBn2/?=
 =?us-ascii?Q?dTo/L+LWlFINE00HwPNiCgAQL0IelVyI8R3q+gLJnPMWrL/bE2zqNcZP26S6?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d7681d-af1c-4cf8-9b3a-08ddc923d19d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6374.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:29:43.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooEIzQdOXHiPUwAVeLWJMam7CnxsaLgujI4ppdDcRx81i0J83n/vsI86+Ph3kRK/9vqa9i1N1YedKvUGTVjSVhyR/TvvoCpQn9X0e1TnINM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
X-OriginatorOrg: intel.com

On Tue, Jul 22, 2025 at 11:42:37AM +0200, Greg KH wrote:
> On Thu, Jul 17, 2025 at 06:06:38PM +0100, Giovanni Cabiddu wrote:
> > [ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]
> > 
> > The 4xxx drivers hardcode the ring to service mapping. However, when
> > additional configurations where added to the driver, the mappings were
> > not updated. This implies that an incorrect mapping might be reported
> > through pfvf for certain configurations.
> > 
> > This is a backport of the upstream commit with modifications, as the
> > original patch does not apply cleanly to kernel v6.1.x. The logic has
> > been simplified to reflect the limited configurations of the QAT driver
> > in this version: crypto-only and compression.
> > 
> > Instead of dynamically computing the ring to service mappings, these are
> > now hardcoded to simplify the backport.
> > 
> > Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> > Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> > Tested-by: Ahsan Atta <ahsan.atta@intel.com>
> 
> You did not mention anywhere what changed from the original commit (and
> it changed a lot...)  So this looks to me like an incorrect backport, so
> I have to just delete it :(
It is mentioned in the commit message:

  This is a backport of the upstream commit with modifications, as the
  original patch does not apply cleanly to kernel v6.1.x. The logic has
  been simplified to reflect the limited configurations of the QAT driver
  in this version: crypto-only and compression.

  Instead of dynamically computing the ring to service mappings, these are
  now hardcoded to simplify the backport.

I didn't port the original algorithm that builds the ring to service
mapping as the QAT driver in v6.1 only supports two configurations
(crypto and compression), therefore I simplified the logic in the
function get_ring_to_svc_map() to just returns the mask associated to
each configuration.

BTW, I'm also the author of the original patch.

> 
> Please fix up and send it again.
Is this sufficient or shall I resend?

Thanks,

-- 
Giovanni

