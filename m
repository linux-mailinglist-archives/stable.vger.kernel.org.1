Return-Path: <stable+bounces-132896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DAA9127E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50919444857
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 05:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF618C034;
	Thu, 17 Apr 2025 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDgxgtpG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B779C4
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866084; cv=fail; b=Ofhms+bmIuDhkOpX08F8WOFr1TAl8LWc5uq/m71WP7QUdGWXXkYeIpJnOdoItamNyaqXxfbgQ/0Mxyj5lw0G2p3SJd7JZG0gu8cNmOmpf+Eir8b5H5xWvHfpHKt/F+AQb87m2BeyWtibw/1ABpWzEFesiVJUsVHTm9wSbuTUmlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866084; c=relaxed/simple;
	bh=1eGT9i+ln8fRvxNb2yk4NhRM3IkvaXmkJeiWnxgO6iU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lBAgL8OoPgSJK5lFrTQzEubNxZE/aU8f7nKhGylvCD/mmY/Htn/EtbN6QL5NqUZV4ocpXe53esqMSxkOQUcn3x0Y3rMenEnPeNh0zFRrxvdMF6tbAKC8ySG9YnJuGXog30mzBIiYef9ZP8V3pnRN4dzeNs1ECjc54k0DXDkZXcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDgxgtpG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744866083; x=1776402083;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1eGT9i+ln8fRvxNb2yk4NhRM3IkvaXmkJeiWnxgO6iU=;
  b=oDgxgtpGfUDOt/Crw5b67PHvbmW5Zy+GLGzYqxrC1oG0Ud2dcnNMmDOZ
   MpIac1c/3L0O08tYNy0VHp0XS4SNjauAi0DB02ucHo202092AFotyEa9K
   17TF+jQHjBuMjNyT9tdmFcyzENg5jRL76boffpoqLNCX/IKmyvk0ViVTn
   D53z41pzooutu81ysCem/s1nk2gxPj6TGZcuRg6gb0c/sdHDo+s2GImZ7
   q7xvkuGKy8lE3GoOUl0wjQogLsn0EyGVYRBwxbfRsQ4cJBt53awqqul48
   cwVIgppuFzgJ6aPV/O+7AQVGV+NdDIHeaQLHrgbsMxiMLQvw4EXZd1kTV
   A==;
X-CSE-ConnectionGUID: hjEsrk1uSoKi5P5qynExVg==
X-CSE-MsgGUID: WPODSeDtRMGKmPOGhJwDPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46153949"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="46153949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 22:01:21 -0700
X-CSE-ConnectionGUID: 6PqVxXvjSHKYIR3RwcnPBg==
X-CSE-MsgGUID: evm1fUIeTv2tX54uwHW+fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="130655058"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 22:01:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 22:01:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 22:01:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 22:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITVaVmJioNdB8rs4ftYOFmQxN/x6/4ZDnEuatHQQWKAK1DPjBQdM4EFQBvVHGIpUMqTSpm6tM9angfS1Nm8YoNFvFjNX50DHWh0rHSOUemHLlQtzwlwtxpDaQT6Cv2mfcX2sL3nSAjSw4UVqixqozYIEwIj0/faWEWzcapLI3RZncYk85Zqg69b25q5kUX5Gjual8HM7BVw34nLDIQuOK2flXGJl/suZ8G3Ugo+gGP2yRaVTqPhai861oOfMnMcoH0ynPCRl+qeCUWL5VX0v6M5whudMeLnLoWrPxWRhNCxBmqfls5U91zKDNHMSJ9MCdKevqeCX7D1/t7Z6rF4oAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mtz//gQFNQ+QLudqZo8QOGf7GtnNac9HNxqwVRnxlA=;
 b=eeQFfs0VIdk9g5cDvUwlfjc/vwTFATCh/ABfmD6f+gPxR6xBmM1XZG2cu51awrglzkoHNVA5xDV07BbkuZaoTNz4DYPpZ2pAN0PfM3yllSGnMCF1L9HpmRWTWSuQKxhWt4L0oso7tLAiFNrI+QHU6qh9o/DD2dBZ3PKqEAs5ptpXrFI9skPzR6Glpewk2zOvWp1yN2Lx9EnFjNkYE3hDUaqSdEkizxY7AUKG3Dc6ESv9my+gvbxbVyPyRN+FLpHuKTm1+1h52vm74RucWzdKVOG0DeMxs+Mjqeya8MK0fRdR+3OrmDsF1XWkz9etP90b4UAwADoEB+QeJCUrcVxicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.38; Thu, 17 Apr
 2025 05:00:36 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 05:00:36 +0000
Date: Wed, 16 Apr 2025 22:01:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/xe/dma_buf: stop relying on placement in unmap
Message-ID: <aACLQ/DBwpoeR1+H@lstrano-desk.jf.intel.com>
References: <20250410162716.159403-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410162716.159403-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:303:b7::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a414bb5-4769-4085-daaa-08dd7d6cca7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wIwkqIvpA13cyjukZ1hQNIB1MQfHnOBI2SNyp0vvzw3O4x3aAIQl7bl+pZ?=
 =?iso-8859-1?Q?BglvyW3ETVEPWE5CKfrZP16XcjILA3YFi6Gis3YDA7YB3CFu9FBFhhMg16?=
 =?iso-8859-1?Q?HpLUi0l1EPHs65RPYklyk/7O438zV6pjZaVGiWDCNj8wZk1baT4kLl5Jfp?=
 =?iso-8859-1?Q?dizN1o/k+7ZLdCvGOQRnSXRrMyD++k+jpRcmxWf8QvcMcbX9tvFAB4Kiwb?=
 =?iso-8859-1?Q?iOE0l3Fq6PqcBPw3ag0d6DdjS6T2FZC3SMUwB42HwR4cnTFTvRPdWQzUj5?=
 =?iso-8859-1?Q?e837wnOueT4YKw8sV2RzVK6sEgCwRAv3qD+HwoBIeDVskELz7FQAqtvd5Q?=
 =?iso-8859-1?Q?X6krlMuvODiDQEiwzCWW8jaVelrIpDmoYB+hV6TRiIdYm/L+UIrMmZPWt4?=
 =?iso-8859-1?Q?mdMnoeojgN6bspoWndbpokoUT+Re+n4K+OBimUjQt7k/lB56/uI920Uvvg?=
 =?iso-8859-1?Q?k7NbSmSELnyDbRgpRRN1Ltyo6SYqawjcAqyF2lcrN3yktj+K/sGB312Xxi?=
 =?iso-8859-1?Q?Vk3FhdLm+BxShyotGhnbsepYW3kZ1zoKPKSiRfD7nSDBMGK9p39ZyJH0Fm?=
 =?iso-8859-1?Q?jOfqkbWy+7X1fVJ/eFFYs41AYz+9IKVIg7Gf1r1LCJyY9kRELgWWZtixJJ?=
 =?iso-8859-1?Q?E4f7FQW16pu3yBeEQ1YF5g3QjWGfCKs2P/Y4ZNhgoIbnzGf/Z8K9U9Lxwp?=
 =?iso-8859-1?Q?7ycOnnkFNvnafxjX1el1yXnsUPp8NwMZmQlHEgRGkhp9Q7CLFWr8S/9etC?=
 =?iso-8859-1?Q?Pt5IqhYA3RjgwNYmcHEreiPrP9bm7Ey/aAKPNyN1zUOq4PooWpDqSrSnpr?=
 =?iso-8859-1?Q?W2IE+y3wRDFjjvu6hRRxK1t9fvC6LtRFZEzgouGuOBf2NwMh/ilzkAMdCV?=
 =?iso-8859-1?Q?FnxZFMqrE7C304YIUP9Z64FWrLlBRlaOFtKGDfH2Ghp67gTshSJJLJ1zw1?=
 =?iso-8859-1?Q?dCopoigLi/LRRp7Pwo8UZVA4zC9FuSyGkAMiu2g11rOAvVnaD76jAipb1t?=
 =?iso-8859-1?Q?RPJ1IbhOiZBqL1tgfSxfm593h2llYNXn5RaYwnMBdC65RWsDoJOeFlhBjf?=
 =?iso-8859-1?Q?mcC/eVi2GuHB3C8l2ZtCfeWK4QoMhejPIAaQzCln6C/IX3J+uLI5kM17Or?=
 =?iso-8859-1?Q?jJWhyCObtTVS3peKEbIKWkuhcVD/pPUFJcNfaI9FZvJG2owxQqyGZ81d8x?=
 =?iso-8859-1?Q?aJX+GrK+aGcjnVV7nxRSSoaS1OZaCsg8k03emaJCqkyNNGFjD3iHEjFf43?=
 =?iso-8859-1?Q?EysHvR1xTjJXxXOtufAV4Nmvdn/SLwIy9hmxvaMHlAa4ntUYX0VaQwZzYg?=
 =?iso-8859-1?Q?lfZBvx4TUK/fchB51o9I1tNkjsICxZ6vEO2hmVwjAMIzZpJza26J4pV4wp?=
 =?iso-8859-1?Q?R8TAJy/jJyxx2yzEjYbToHl8EPdeP9i+45eWit5oLbkrW716ueV08=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?P1pE8lSSC82cEa1jTwv5+rPDdSxQsduMYtm3OENM/MiDSMsv7zPamKnVVu?=
 =?iso-8859-1?Q?q0xfD0Cjt6J0RGtwlOlvFdMDDk0O7D/eyxwHSMxPBQFiqs127UvEMaaWyF?=
 =?iso-8859-1?Q?7BoDC9CV9vismeTLbheRRqCJgFESAQ6xmLiEz3bv3SSciX08uKRfBgnGXk?=
 =?iso-8859-1?Q?A2A9NBXoDdtQCoE6v9DLv0qJdBi3dxyMQbKGjT9ZJOTx5WCVjDaEz7Gfcw?=
 =?iso-8859-1?Q?8pa7O0aYhlR+5OykfV6pVLoQ2wKcw8Q1PLifCysuaZSuXI1FspQl+qHRAi?=
 =?iso-8859-1?Q?uQh1ZyVlQB0EkC30SXSijq2G+OIb6DT3xCHisoMn8iDetiyF9+AZEz/BfR?=
 =?iso-8859-1?Q?hfwSSLGk6F1DeQDNfQ8VrLzofoAdmu9WVw4/VxwgYXWyVj1LTjSzl1f/qU?=
 =?iso-8859-1?Q?Y2w3fTgw+Duea/6wsdJ29nLI2Jm7ZHoPbVMbDJBClUal8bxLNymay+sxsW?=
 =?iso-8859-1?Q?Jcr/7JZwcehCPUS5TfhBd/kwPZkzC++cDHJRJZL5AuD847OBPBO73aRMIr?=
 =?iso-8859-1?Q?s5y1nML+tPWPYH76e1UwOr3+lF7hde//YObBDdHfyNG4m3F16zPEiN9yLK?=
 =?iso-8859-1?Q?lB/SaKw8yreGcDtcZk8zoszeK/LN93gDHHlpUYnXa+QDoqjMuaZKLd0lJw?=
 =?iso-8859-1?Q?KAjw7XReYsGieNvDOIIz24DBZd4nCtdHtEhjDJFHfV/iLzJT1GyVmB2oVY?=
 =?iso-8859-1?Q?nS/uWjQYB0zqb6KZxFIAI7wYgUUUfq3klWngDTvBnprRtgB78HKAvJ4Jds?=
 =?iso-8859-1?Q?+ztLGlUwsC9Bn512rI9Ynz4+B4b/PUNQTdpJiX+eerpJK4NRhfccFKqRlE?=
 =?iso-8859-1?Q?L96gJMP/RghAcjOPzrXSzokIaWx08NKeA4KVbXF+XYqbUaiJWihK1Ct/0B?=
 =?iso-8859-1?Q?KAfEYV69RD/oUS2QmZq/kySABGzhWqIN7St7nuWq/67BQKK+hSnEni/S3u?=
 =?iso-8859-1?Q?qmFYgqwRmTMut3LlisPAV9lV2wugsIGX6IUtjG4oJfFSiNGEcxiEcgcqR7?=
 =?iso-8859-1?Q?O44UoEnaR0dILhBjlZbgQqluYx/rudtbwbDDlaOcPPH9D60mio1d3JGsmB?=
 =?iso-8859-1?Q?uPtnd8e8tmEZmArNMfTliCkXUFqq4iKHaSM92VkZAtQXYv5LEic4EJe1dF?=
 =?iso-8859-1?Q?ZTPIcKyFh1CPwTXi1t6UxiZdEUyXASN+myJ9zMFvEGSh40hY0birMV9bY3?=
 =?iso-8859-1?Q?7eozBg4H6CWqzX1B/5ygIjSWvXdnfHhQbPyG2DmswCgXCFxlaxbB/jkZhR?=
 =?iso-8859-1?Q?bsmzmDBsp8miTV/yPw9Mo13JPh/xrys+zxt7P2T8kgt709XFY8p06esGlV?=
 =?iso-8859-1?Q?g4ZAhYkaMpRbm4FUvDqCtlJaXRLKIYx80hvoOoysZWXU98CKBWUgC97N79?=
 =?iso-8859-1?Q?zYeHITO61P7vNwsQxxy7VDUWtCJHURqAV5uQRVbD+Sq0OK0RtfDxF0yHOX?=
 =?iso-8859-1?Q?uEw85QW0Smm4CWwZZ8bw+YFd6pw0i5DfWkXIAwI0gGln73JLTiOwV0RfUV?=
 =?iso-8859-1?Q?eUk2/Mhfj2zVGxP5BFMdsohUUj5nhhO8CEUzkcvIYq6LalGwKgaJVp8uEF?=
 =?iso-8859-1?Q?r4x4V6e5nlleM+z3zyZZEt5cifX7er8GWEhxCk8B46666n1uMPIXweUZeW?=
 =?iso-8859-1?Q?JOdYe/XvULR2xeEG5S5TfSuu2NFLXfYYNBjOkpLCS0vqVKkQ93U7+kAQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a414bb5-4769-4085-daaa-08dd7d6cca7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 05:00:36.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahExwc9c/C19KhmTFfhI/aPg8kyCEQ/RX+m9j+X5CnDch1MgYolKc3wimZ/qldhCvYiell2T+2SvOcNTuyflUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 05:27:17PM +0100, Matthew Auld wrote:
> The is_vram() is checking the current placement, however if we consider
> exported VRAM with dynamic dma-buf, it looks possible for the xe driver
> to async evict the memory, notifying the importer, however importer does
> not have to call unmap_attachment() immediately, but rather just as
> "soon as possible", like when the dma-resv idles. Following from this we
> would then pipeline the move, attaching the fence to the manager, and
> then update the current placement. But when the unmap_attachment() runs
> at some later point we might see that is_vram() is now false, and take
> the complete wrong path when dma-unmapping the sg, leading to
> explosions.
> 
> To fix this check if the sgl was mapping a struct page.
> 
> v2:
>   - The attachment can be mapped multiple times it seems, so we can't
>     really rely on encoding something in the attachment->priv. Instead
>     see if the page_link has an encoded struct page. For vram we expect
>     this to be NULL.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4563
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index f67803e15a0e..f7a20264ea33 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -145,10 +145,7 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
>  			     struct sg_table *sgt,
>  			     enum dma_data_direction dir)
>  {
> -	struct dma_buf *dma_buf = attach->dmabuf;
> -	struct xe_bo *bo = gem_to_xe_bo(dma_buf->priv);
> -
> -	if (!xe_bo_is_vram(bo)) {
> +	if (sg_page(sgt->sgl)) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);
>  		kfree(sgt);
> -- 
> 2.49.0
> 

