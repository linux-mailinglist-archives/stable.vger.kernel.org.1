Return-Path: <stable+bounces-119802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54AA47638
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35C3188FC36
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0721B1B5;
	Thu, 27 Feb 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRS/L98s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94AD19D8A2
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639735; cv=fail; b=N0ivf7RZubwNqfYIwMIbggt5UEbZn4AdPJ8BDyEDt39x256Fj5suBxwvZpweRFPzUroyjJHvHjXQpMTXKiN8J1YQNItNI4lD7pxPV5FWopvQ0/KXddLxlFiNyUQdk+L/5wLoLdxfgDLf3XxHgoOpajQZj9jdRNMLlEcXIRdf7dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639735; c=relaxed/simple;
	bh=c6f4WvBhpertBU+HKiNpYQp2BzRqFtoznk/YIeSq9HU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m7L00NdT81I4ITPoW/UpeeO954OPTxJK02huP7bX74/v/oxdOlqpmsVg9utqtpNMFqJ5hpDw/qAP6mxwHJZY353Q+vT1s1P/C7Tloewm4wGsPeNKKij9ttAT2IaFU8ryG+aC1/ah4atfSPBaXE03N75Loyggk5KLI4THfEPyOzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRS/L98s; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740639733; x=1772175733;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=c6f4WvBhpertBU+HKiNpYQp2BzRqFtoznk/YIeSq9HU=;
  b=WRS/L98smjD/5J0SmqDJv3eStTkIULsGH+vKBKzxbtcHi2S16h+DO3Rx
   iIit1pKPrHk5pMMYe3b3HU4jyR2MQAgdORS6TWi12ULfSeQsTEcqUCU7q
   nv0igkruJ8UMn+68SEl2wWSvZx4SOHz2V9heGp1OUhnEtApIhtHrZYoQn
   4zVeDNzbw4zNk/0XDvA+mvbPEDocavzMshJmKu8ZxiKu4VB51U2IrVuIV
   bqvqsT69D5kraiZrzPH3m4w7GaEN9x7JSG3CvGrWKEYwGMpoQ3JMdukVx
   BXwwfaRbB43ctU3IJiJEe3bBbqojLg7L3njJFzL+7fXLMHmyKCTTr3rHp
   Q==;
X-CSE-ConnectionGUID: e5k0X3sARqqwnEAyJDpU2A==
X-CSE-MsgGUID: 5MdV2AV8TkqZ0P6PLBuOqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41647375"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41647375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:02:13 -0800
X-CSE-ConnectionGUID: ZwscXqzSSxulhcPPRpfAFQ==
X-CSE-MsgGUID: jllG+xgRT5mAsTG1Ra0uuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116811959"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:02:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 23:02:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 23:02:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 23:02:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tur/mXRKJqjwD9GVVrip9bY4dBlXz3y3MyqUWTQRuG3OD/ctler3w4QNE9W6e3gk/mx8MEQYnuUbmVDGG1O0ZYmXGehdJZUwKSzCZdsLRHua1DpgKpzocbigHGumgRoX4irMruwujhy4YQngEiZw0dLC6wafu3I3haWANM0ZbJBX1D7PRKmzwT3VO5Ah1c2WalLn1eLsBRHkhMLdDfZTkrNqFvsC2szFLRh+8pw4bajzLAlQPbvCHQN9qrUs/jg5FOxDhfWM4nV6GcA2teujEUWTeKWTRg6O9oBkN2sg57TqCahLZBZ7DNRj4vNcB5t6FpFyuHp2VfwXA0/+ZPaYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bokliexZNz1NxxIszaRm3c3XKB0LLsUvwNK5QHzHK/Q=;
 b=PLeSD8utHFHMAhspWzyQ1R2YLgEdxlVSPu/bnYI2I6V6Rm8F808cZRXWBgenVYs+Ba9DVQfCHS3Vk1XRgFh3lgE8HmmIh94nZGMiyV/G8eQL3MrDyJiHi9fGjIkfBuChY7Q2ecSmXAbK+CHVmH9chZNtVTe4oH+QqRO72oRCRHkCfvxHyWdU2RfdzBSOJNKHHo0zHXv0Qdm75GK5oIhM+pXTkRoigT3ZaEdCdKLAAh2KHl1yEaBpZ6+rXKIsjj+Y2glQsC1OEWcEs23Ap11uuSlfrROUAbf5sph80G9dL8HZ82aifNTd6f4YO9bTDgOSHrfeTId1kHe3hGQGbCmZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 07:02:09 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 07:02:09 +0000
Date: Wed, 26 Feb 2025 23:03:13 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/xe: Fix fault mode invalidation with unbind
Message-ID: <Z8AOMdBGv2zhGVm5@lstrano-desk.jf.intel.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
 <20250226153344.58175-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226153344.58175-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: d295aadf-9101-40e5-1400-08dd56fca6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Ckhq/Zd7K2XVPJlS3oPjQ9pWPpV0wc2UqCLAeRPPvrZTdVNCpFFVDLca5N?=
 =?iso-8859-1?Q?g8a9mm2reu4g40hntc5E9N8zPtEH8r3YlSxS5FtSWGtuRcKY0MFwnnIa7+?=
 =?iso-8859-1?Q?I95agR+XvJyOVhirdle1p/R7lCq+p9GlkF7JABeyqeu4o5eY5cg3+XdxCs?=
 =?iso-8859-1?Q?bKT8vSxH+e/dkb92ICRqla/RFfOOqPOSRm502E9DwNL908N7eprYMkywoX?=
 =?iso-8859-1?Q?RkGmH+B1tpGKkGeLCpIfJsIxs70xyq8/C08wulxwpeJnIDQwVYeR0npCfs?=
 =?iso-8859-1?Q?hK3m4gt1g177mF/iy/1Tq7Q5/mwspRuF0r8I3fhy3vUMwX8WCoCgzGVrpa?=
 =?iso-8859-1?Q?u98bH3DrDrfn3mVvmiLKQ7CzjWgiCxwRVZTBb2ic2OjYG4+sJBLgOv0Rul?=
 =?iso-8859-1?Q?jx+mLZzDUUTXvGcFpqq1cATifFwPIoiQO5dPbcKbBWzuaNB9zouzoip0yp?=
 =?iso-8859-1?Q?3yUDsddgFYeKMBixbE8pfZCUBXMcVxDi7sungboOVyxCJl3eRFcmSK76qA?=
 =?iso-8859-1?Q?4nsXbivRbcOVRBtUsZeR1ZVSKRYVw8B94UCJxUwa6LkpWcAL0he83kYO7c?=
 =?iso-8859-1?Q?urxLENNCYV2TRdQ9MUY+FPXQgMQD19LwqIBhO1DXRxkqkAA5yHFN/Cb3I2?=
 =?iso-8859-1?Q?kpSn7ZuVo0ZmXo5KAzg7yeCml5i0DCG4sNH1nPXGcwAxvuGUUnPwFCR/sY?=
 =?iso-8859-1?Q?Nx+wjeqAfXjT2kLgwWYzUvWNjAB2o5NFZkfWplgxqwwegOQRrUllB2gqUU?=
 =?iso-8859-1?Q?IRILL3vRPJnp9Uusx5I7OcyYyOsUZF2k3jpDd/b8G+mb9XU1scN/n/WWca?=
 =?iso-8859-1?Q?TIa5C/Nt4j7Jeg62n+SwV/pq0Z5M1uqRY4HoPJ7oP7oaHM5T+TaLGJYTC2?=
 =?iso-8859-1?Q?x/kvYWc3XN/n+YSM28BaAOamxwGAyvhWNw5J2f946P2oo+E0Hg4TiLBCjZ?=
 =?iso-8859-1?Q?Z76pnq8r0LdGfXU+YR7uKqEtfaI0d/Q1BIlxS/PfuBiQhbJfFcnhYVQLT1?=
 =?iso-8859-1?Q?zb0CzNfHsNkjXtt8SlDmAF6pnJUCvD/zSzeHxP7uWFdXzZH8S9Qud4xsS1?=
 =?iso-8859-1?Q?STBoQkOX6MmoTnCwi6RGu7B2d0DK9SbPpbzS4wUGe52vlvJ1otjQGq9OZ4?=
 =?iso-8859-1?Q?ir1PWDI6h5t9+8zp8EaDghEBUmYNkfJtsRFaeXDzpNfwuh8bwGty8daMsG?=
 =?iso-8859-1?Q?G0Gw5IOutJ0HzANNSgl6SL9kxzShVSDNGHIL95xVkZLdNvdKcR+u1G7fgl?=
 =?iso-8859-1?Q?cvRoywxfJKCfkMsyHSVayXgOYGLTXaU3YeKAfWCUsbLLq4KcMGIHzpiB0l?=
 =?iso-8859-1?Q?uorzEK2d40nbC59zeLlprS/ctn68OXYQU7KS0XO6c/sNV1v4sWRHq5Tj8B?=
 =?iso-8859-1?Q?A6nn1U2cQ9JIgc92F4N/2M0ExX2rKHJBAYL4QdsADmc5wisci+bVbJDO7c?=
 =?iso-8859-1?Q?6gBjGe9IcS5UZxge?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OERoxebN7x20AM2uGmSxmSBBvm7tM9nHhDE/KqUdCMmIgeIpHPgJeKgaVA?=
 =?iso-8859-1?Q?FclsgzT7t/07G6WFbwZ0EFFd9Q5Tt4+76eqsyhYG5JML1OpaGUz/GHi6hI?=
 =?iso-8859-1?Q?7cPV7DtY9ofxdPbWvNWhmwOf2quX6sR6PeGBRQ1SNAOsjpg6aQMCj7cfWt?=
 =?iso-8859-1?Q?9kbb3DerCh+FkpNJw4adRnaGbRSs+z+lV+e2jkcs65+HpTwqa6tQSv7LlN?=
 =?iso-8859-1?Q?Qtk/ezToF2AQNhrrXuF6kc9yofm4bhbhjXvov14ShufUJovZ1b26Xtmc2Z?=
 =?iso-8859-1?Q?lOszJ70jWDa0jsi21dSeZA9rbPpiXo3LC1uNa5L2YgsiOH+2Ipgx9z40NL?=
 =?iso-8859-1?Q?/YP46uOSzccOxIvd5BekSgisJsw7wQ/05g7wbk5Jnk+T6ZBv2faJsM+bJl?=
 =?iso-8859-1?Q?gXEIp8g3wm6013OurQA1A5WCMKApLs0eUox/JF8ncPUyFSrjy6ujtIM+lH?=
 =?iso-8859-1?Q?/m/BDJVUUl8uV1n2SBjh6omxbWuzvJdtr0mHE9fe8z6mnKFL/eqO8Hr7ug?=
 =?iso-8859-1?Q?7ccVRgIGbP4YNWecg7UNxw8uSGAq4o3dCQw1f+sco8kjlRfXnhcSXd2sLp?=
 =?iso-8859-1?Q?s0mpwy+Y4TAD+B3nfcYBPdAiyTPy4R7hDCfg35H4dEIB8+G1yxW6fNlWQp?=
 =?iso-8859-1?Q?ctpo7hKb0gq9w6lGlFGBba5Ny3OnI31u08CIrQ4rC/vxmil8n5/wvpcSVt?=
 =?iso-8859-1?Q?rDREG9mDWIySDV+5k63sEqjNFqr4li1cXAp0UwbEOGUdYy4ndCH0eB+4G4?=
 =?iso-8859-1?Q?j6G/YvB3UOiUC5P8wK9NKJcrKV0Krs1rfxcTnSRqaiUBpdC+AAbNVMOAdQ?=
 =?iso-8859-1?Q?xPii03wJh6G5yVEj+37GhyKGMF1PNvOBEgHV6zgqjGLM/VCkRMBq53iCwV?=
 =?iso-8859-1?Q?f/sovBFxQx2/DcLnNMp6wCWAlUDQBFXxcoZmBsZsOISqUYJ2zCuBn1a/IJ?=
 =?iso-8859-1?Q?epxEziy/ugnGszhSbYa8wFXvV0efTm9hP50eCy38CnTLas503uIE2VWLNN?=
 =?iso-8859-1?Q?taAfR4cQrEGjVjX2YzfbzxW4cgipnliLWm+izkBaJfYCxApa8nGALjNUGO?=
 =?iso-8859-1?Q?JZ65MtwzYKbynPyEd2g3Dk34Qqb7j5fnDX9dREMdTdWDno6PE19qaHPaki?=
 =?iso-8859-1?Q?dJhg/y0h9trrANNDfopUvDiWWsmc7pxr1hMv3H/1Zl5h0KJmBlSZNGjqCZ?=
 =?iso-8859-1?Q?7TlKtAOVlPk8S2+hb+FjR/ZK3RJkTJJ4O6oSRU2goOlQoULMyBvMcFOmlP?=
 =?iso-8859-1?Q?9JgdBWuBP3FQutE6bix7lj7ZFH/+oAT+E/kR3MeG5HTA+K0t1d6WoK4/uk?=
 =?iso-8859-1?Q?Xg+JXm8AZhBhcE3z1+hp4w+Dug6SXbT/L24OC7d8rfKZ/xB6VG/sLIBgQ+?=
 =?iso-8859-1?Q?l6pJHAHU/MCxIbS3LlKdEUYOf7/5PlpffWQoxREPXhvZcWeGxwgigtp5bx?=
 =?iso-8859-1?Q?yS3dbW5mqvnDeO/rUYUgY5O+8vvqLz73MnxERHVOPe9fxgMEJow6zDaS2m?=
 =?iso-8859-1?Q?MRKAU3G+C9FjgNhCtMdRh3C9yx01yo4osSGeNCa6KwMO0X38MX1G+JB1up?=
 =?iso-8859-1?Q?sStbWlWGuqlaS77x2UPTATNxdw9kNRVs5fJwIGG640XJRam9oitiXxnP/X?=
 =?iso-8859-1?Q?4YltxTfxWv8TPRnhV0YAxbHYOblF9HAi0sN+zKPRbkCjUbM/ePuiVFhg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d295aadf-9101-40e5-1400-08dd56fca6e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 07:02:08.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwqx/Jao+o6Y3yuUvyjXpjit7A9vyNjaTLd0rs+GB/5APwT+rL6HIdMHw+ET+c2PqgOKLSMj8VYYDPNnoRuI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com

On Wed, Feb 26, 2025 at 04:33:43PM +0100, Thomas Hellström wrote:
> Fix fault mode invalidation racing with unbind leading to the
> PTE zapping potentially traversing an invalid page-table tree.
> Do this by holding the notifier lock across PTE zapping. This
> might transfer any contention waiting on the notifier seqlock
> read side to the notifier lock read side, but that shouldn't be
> a major problem.
> 
> At the same time get rid of the open-coded invalidation in the bind
> code by relying on the notifier even when the vma bind is not
> yet committed.
> 
> Finally let userptr invalidation call a dedicated xe_vm function
> performing a full invalidation.
> 
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pt.c       | 38 ++++------------
>  drivers/gpu/drm/xe/xe_vm.c       | 78 ++++++++++++++++++++------------
>  drivers/gpu/drm/xe/xe_vm.h       |  8 ++++
>  drivers/gpu/drm/xe/xe_vm_types.h |  4 +-
>  4 files changed, 68 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 1ddcc7e79a93..12a627a23eb4 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1213,42 +1213,22 @@ static int vma_check_userptr(struct xe_vm *vm, struct xe_vma *vma,
>  		return 0;
>  
>  	uvma = to_userptr_vma(vma);
> -	notifier_seq = uvma->userptr.notifier_seq;
> +	if (xe_pt_userptr_inject_eagain(uvma))
> +		xe_vma_userptr_force_invalidate(uvma);
>  
> -	if (uvma->userptr.initial_bind && !xe_vm_in_fault_mode(vm))
> -		return 0;
> +	notifier_seq = uvma->userptr.notifier_seq;
>  
>  	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
> -				     notifier_seq) &&
> -	    !xe_pt_userptr_inject_eagain(uvma))
> +				     notifier_seq))
>  		return 0;
>  
> -	if (xe_vm_in_fault_mode(vm)) {
> +	if (xe_vm_in_fault_mode(vm))
>  		return -EAGAIN;
> -	} else {
> -		spin_lock(&vm->userptr.invalidated_lock);
> -		list_move_tail(&uvma->userptr.invalidate_link,
> -			       &vm->userptr.invalidated);
> -		spin_unlock(&vm->userptr.invalidated_lock);
> -
> -		if (xe_vm_in_preempt_fence_mode(vm)) {
> -			struct dma_resv_iter cursor;
> -			struct dma_fence *fence;
> -			long err;
> -
> -			dma_resv_iter_begin(&cursor, xe_vm_resv(vm),
> -					    DMA_RESV_USAGE_BOOKKEEP);
> -			dma_resv_for_each_fence_unlocked(&cursor, fence)
> -				dma_fence_enable_sw_signaling(fence);
> -			dma_resv_iter_end(&cursor);
> -
> -			err = dma_resv_wait_timeout(xe_vm_resv(vm),
> -						    DMA_RESV_USAGE_BOOKKEEP,
> -						    false, MAX_SCHEDULE_TIMEOUT);
> -			XE_WARN_ON(err <= 0);
> -		}
> -	}
>  
> +	/*
> +	 * Just continue the operation since exec or rebind worker
> +	 * will take care of rebinding.
> +	 */
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 4c1ca47667ad..37d773c0b729 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -580,51 +580,26 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	trace_xe_vm_rebind_worker_exit(vm);
>  }
>  
> -static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
> -				   const struct mmu_notifier_range *range,
> -				   unsigned long cur_seq)
> +static void __vma_userptr_invalidate(struct xe_vm *vm, struct xe_userptr_vma *uvma)
>  {
> -	struct xe_userptr *userptr = container_of(mni, typeof(*userptr), notifier);
> -	struct xe_userptr_vma *uvma = container_of(userptr, typeof(*uvma), userptr);
> +	struct xe_userptr *userptr = &uvma->userptr;
>  	struct xe_vma *vma = &uvma->vma;
> -	struct xe_vm *vm = xe_vma_vm(vma);
>  	struct dma_resv_iter cursor;
>  	struct dma_fence *fence;
>  	long err;
>  
> -	xe_assert(vm->xe, xe_vma_is_userptr(vma));
> -	trace_xe_vma_userptr_invalidate(vma);
> -
> -	if (!mmu_notifier_range_blockable(range))
> -		return false;
> -
> -	vm_dbg(&xe_vma_vm(vma)->xe->drm,
> -	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
> -		xe_vma_start(vma), xe_vma_size(vma));
> -
> -	down_write(&vm->userptr.notifier_lock);
> -	mmu_interval_set_seq(mni, cur_seq);
> -
> -	/* No need to stop gpu access if the userptr is not yet bound. */
> -	if (!userptr->initial_bind) {
> -		up_write(&vm->userptr.notifier_lock);
> -		return true;
> -	}
> -
>  	/*
>  	 * Tell exec and rebind worker they need to repin and rebind this
>  	 * userptr.
>  	 */
>  	if (!xe_vm_in_fault_mode(vm) &&
> -	    !(vma->gpuva.flags & XE_VMA_DESTROYED) && vma->tile_present) {
> +	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
>  		spin_lock(&vm->userptr.invalidated_lock);
>  		list_move_tail(&userptr->invalidate_link,
>  			       &vm->userptr.invalidated);
>  		spin_unlock(&vm->userptr.invalidated_lock);
>  	}
>  
> -	up_write(&vm->userptr.notifier_lock);
> -
>  	/*
>  	 * Preempt fences turn into schedule disables, pipeline these.
>  	 * Note that even in fault mode, we need to wait for binds and
> @@ -642,11 +617,35 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
>  				    false, MAX_SCHEDULE_TIMEOUT);
>  	XE_WARN_ON(err <= 0);
>  
> -	if (xe_vm_in_fault_mode(vm)) {
> +	if (xe_vm_in_fault_mode(vm) && userptr->initial_bind) {
>  		err = xe_vm_invalidate_vma(vma);
>  		XE_WARN_ON(err);
>  	}
> +}
> +
> +static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
> +				   const struct mmu_notifier_range *range,
> +				   unsigned long cur_seq)
> +{
> +	struct xe_userptr_vma *uvma = container_of(mni, typeof(*uvma), userptr.notifier);
> +	struct xe_vma *vma = &uvma->vma;
> +	struct xe_vm *vm = xe_vma_vm(vma);
> +
> +	xe_assert(vm->xe, xe_vma_is_userptr(vma));
> +	trace_xe_vma_userptr_invalidate(vma);
> +
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
>  
> +	vm_dbg(&xe_vma_vm(vma)->xe->drm,
> +	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
> +		xe_vma_start(vma), xe_vma_size(vma));
> +
> +	down_write(&vm->userptr.notifier_lock);
> +	mmu_interval_set_seq(mni, cur_seq);
> +
> +	__vma_userptr_invalidate(vm, uvma);
> +	up_write(&vm->userptr.notifier_lock);
>  	trace_xe_vma_userptr_invalidate_complete(vma);
>  
>  	return true;
> @@ -656,6 +655,27 @@ static const struct mmu_interval_notifier_ops vma_userptr_notifier_ops = {
>  	.invalidate = vma_userptr_invalidate,
>  };
>  
> +#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
> +/**
> + * xe_vma_userptr_force_invalidate() - force invalidate a userptr
> + * @uvma: The userptr vma to invalidate
> + *
> + * Perform a forced userptr invalidation for testing purposes.
> + */
> +void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
> +{
> +	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
> +
> +	lockdep_assert_held_write(&vm->lock);
> +	lockdep_assert_held(&vm->userptr.notifier_lock);
> +
> +	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
> +				     uvma->userptr.notifier_seq))
> +		uvma->userptr.notifier_seq -= 2;
> +	__vma_userptr_invalidate(vm, uvma);
> +}
> +#endif
> +
>  int xe_vm_userptr_pin(struct xe_vm *vm)
>  {
>  	struct xe_userptr_vma *uvma, *next;
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index 7c8e39049223..f5d835271350 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -287,4 +287,12 @@ struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
>  void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
>  void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
>  void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
> +
> +#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
> +void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma);
> +#else
> +static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
> +{
> +}
> +#endif
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 52467b9b5348..1fe79bf23b6b 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -228,8 +228,8 @@ struct xe_vm {
>  		 * up for revalidation. Protected from access with the
>  		 * @invalidated_lock. Removing items from the list
>  		 * additionally requires @lock in write mode, and adding
> -		 * items to the list requires the @userptr.notifer_lock in
> -		 * write mode.
> +		 * items to the list requires either the @userptr.notifer_lock in
> +		 * write mode, OR @lock in write mode.
>  		 */
>  		struct list_head invalidated;
>  	} userptr;
> -- 
> 2.48.1
> 

