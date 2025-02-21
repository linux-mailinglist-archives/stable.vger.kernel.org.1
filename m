Return-Path: <stable+bounces-118624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4549AA3FDB7
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19134703615
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BA2512D6;
	Fri, 21 Feb 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpHolZk2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B300250C17
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159658; cv=fail; b=C0+8wtPBEE1aVVH+06NLYshj3KcHPgTtYpD4p58WGxF2clCE4IfGlQXK05iR4iCcB5uRQzSEGWBMkB70PuJyT7fYYiFkoV32QT6OTfnq3BE5asx6m3tFOD7PsnVcqVN7SQZpvKof7LkLjBHAd4ivarcFqnNxLzfsWmmmOX1DcvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159658; c=relaxed/simple;
	bh=MOcQ9CmMKDe5jVk8PXXYP0yXZBJS52ht0VDCocdpV+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rXwbh3d4dDARFDi9fPTU0MMcH5y4qlmYoX7gjvoGu/v7C7CRZAucp5r2/V609p5mxOyM2GjTzFg4y9u/k5e0MtxfueRK9nQv4I+qE3pRnd1JGmUvXd/NmHcDG80dJw0ZU6vsI3OdW0qmPf8/Owlsp5VBBivOWUQicXGzVcDNScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpHolZk2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740159657; x=1771695657;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MOcQ9CmMKDe5jVk8PXXYP0yXZBJS52ht0VDCocdpV+4=;
  b=QpHolZk2bM8YCg9UiIZapx8F/E+QEFU+qCgpFPTVcu2UmYhSUNMWdh9D
   QcBzzNeFbshOLQBUBQmyRIQfTTjCvujP7GW6JXKRh9GdEvK0V4P0bDJ4v
   yY3AjXBa/kXzl0HUYySqRSHbwrDfK/wPlKBjUeSStAzpMD7DQOQGgoxKt
   nmFNu/C6vWkArnGNlNNKKG24CQ870E2cvz58YR3cqxgky21Svy6MOHVqh
   /q+Wrs4z1lWujsorir/j1cz/THpPtjnQocK2Hx0RP+szHMm9TjqYsA2CP
   QVQheEb+0wfGFiFoRTPQwV58Wli/t6KyERG6KZDIKL/qxdgvZ0TVKQgrI
   Q==;
X-CSE-ConnectionGUID: gWMY2QAHRo2O6xm4CvpOpQ==
X-CSE-MsgGUID: hESJj/QARgGS64fUcvrwPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40907218"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40907218"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:40:56 -0800
X-CSE-ConnectionGUID: h4h+JjIJRqWcE5Rlg8DYtg==
X-CSE-MsgGUID: KtRuzOStTR2XcR8IQjITQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115146872"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:40:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 09:40:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 09:40:55 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 09:40:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyVHgmmvgwTGklK1fMxAykZyLgFEWWSfAiGPqv85Pkt2qXZgOhNS9m9RkzX8bMCLVm/j+lmoQWTPAUHdY9iZs1eXnF9NFeblAKTOuZRiBXFF0x72ID1cz5xrPasqiHbOcOvnyzr423scpf//BvMuVYztkQZf7LRLsvZTHUD+8iwUmRBzHLaC8fu5rPeWowk2b/sL4vhXsE8ATryypFpXL2WswZDTNnZinMS0618vxctsMWDGlVgiyf+ro5c0fD9yW7CXivZI5k73HwcLEl3skZR51T9t5X5Hq9WFqFUhNXGd5ctrbjUL/2Adf0GXzzvlrkL/YQJCReRxHR6MPcrBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3jLNZi0kln5Tta577cRjivENaX+XnOOmJHBOGCGuV0=;
 b=Cnzp/wr/a/w17E4/RyqF3FFBhvzFl6ZBNaCzQkR8H+h6OxxL2qtxLWIMpUYzBOb6Oe/0k9/JXEkjcJN9vvkMnmEKRPdqDHYBqBSYv7FuPMSYx7Qz2knsaEY1KPnSExRcqV+2ZjwMMZ9LZX3dJnoXg3wD1wiLLmIOEVCUGVsvwEU7c8C3EPjAy9APy9kSgsTa1pExK3Hnw/t7j5wcqzAR++VBNoWwFmqWx1EzKM2nqwtDw9yEiiuWw65liXwcuOZo+C5BNbgcjElt3C2iXtMX2Wy36FZQ2M0yBG/NVGUmXgpywracO9JtDARWqXkEQW6FzUVmk7MIqBUXffxlKJ8rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 17:40:24 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:40:24 +0000
Date: Fri, 21 Feb 2025 09:41:27 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drm/xe/userptr: restore invalidation list on error
Message-ID: <Z7i6xwK09A3W7nkD@lstrano-desk.jf.intel.com>
References: <20250221143840.167150-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221143840.167150-4-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 06713558-8155-4d93-3373-08dd529ed249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?88NWmsHPLJwFDQlR8Mu32swzsXl+z8fVJv3EGco7J004eDJu6z26eAJPNg?=
 =?iso-8859-1?Q?dHgEoLzR8ki99+pmDHuy9+wNdD213U99kIBl5VLxSvfmSHjmRLAZY/YOUh?=
 =?iso-8859-1?Q?203X080DSSRSlzY+UH0OGYcnNQLx7W9uNpGroi2BsE1+KxI+Tl4ZUuYQxd?=
 =?iso-8859-1?Q?HXcZS7fF8w0qBzLrDL0SxjDpjpXqLwKGY6+oQydNP2mu4bNM6EOB0u8saM?=
 =?iso-8859-1?Q?jVGSDmiIqRTUDK3VSVyDr1Pq0t1ExPDBZbJ5TMVGJnCK5o7fNhr8DCo1qx?=
 =?iso-8859-1?Q?hEjFslOdAeqtldneEITbdtcmt3/ATRjuvHvydbOIYAoq94oDcMkV9gWOSC?=
 =?iso-8859-1?Q?oAU8rYaQyATfSzZL/8eqiaMazDAQfeTOK4trakT6xUG3gZtfL7LNTZVTH2?=
 =?iso-8859-1?Q?Ij9Gl4cW4xTNWEgDJsgrzo6ROhugxv1wjf4p+kNtIiN4qhgsrg9oAUiKAn?=
 =?iso-8859-1?Q?XkzDNM44WIHFWtRDFJSlblOtRLWoZA8KU2ngddXWdaodZNkn9zABtAb0SN?=
 =?iso-8859-1?Q?RlolKnDHF6ANSdvPzxQ0U7xS2gN8ZXWYwO/5kPAQ3lMox+J8pF/hJtV4dp?=
 =?iso-8859-1?Q?3tqLLyBSEYFOFzvXYN8nhR20AXQugquJ3yFkZX8IHeUuvwY8s3L/jQ5pvN?=
 =?iso-8859-1?Q?0kvY/2YpU60bQNcfpcUB0cxcYhzBjc0RO4bUlm52ekqz0//CVD40AMEs3u?=
 =?iso-8859-1?Q?v6BUsfICv9i7M7JLVVULGOdC5FifnRz2DEispSwuQZuMfHKdSQiKLaJiV3?=
 =?iso-8859-1?Q?zQAKRIS7EZKJOkpkPX8I3nRelFvZBRBvWrHOGcZ4sXLmhfrsYx7VTVhQhP?=
 =?iso-8859-1?Q?IJQkFz7KB9OOtDzUePbaBbR8vup8go+77OO5zabOx+vqu88Iyj/X+jxs4c?=
 =?iso-8859-1?Q?V21GCrAjVxykt1u/1d7LSJMrvDhQxrSgCoWXLsDn35og52pg+d7ScdYHAI?=
 =?iso-8859-1?Q?np3jOQsyynR5pI3Mr76mqwa+TVOy6amj8XjgfpKELMFGsEgPzx5YdlqHHI?=
 =?iso-8859-1?Q?4t3qLNhbtMzHKxmmI6uLEtBL5cp3/Tzu4SVg0vTFcuru8ASPj3LL2P37rD?=
 =?iso-8859-1?Q?DO1wxzoai50vHPkIwBryaY7Xa5Tq8mzhovY6Zd91XCMoICqZVwGg0DVl+R?=
 =?iso-8859-1?Q?lRefAbakWZSMJL8ibksPFFkfGu9SXBH9a6FQMa7mhgYZeWEugd3mTo+FJn?=
 =?iso-8859-1?Q?eYI8wxqv9u3dGR0TirRu72AGPD+xRAM3BHBaUBKPiiDbFw+A0+VfqUSTvx?=
 =?iso-8859-1?Q?PCLlsUahC1yKyHNvUFxPe1jBoxOOpglLB/dSHLwm72HuBBjaUaY+BLM4AO?=
 =?iso-8859-1?Q?dtk4apZtW5+VW21uXcK9CppJhA2WuGI6TnXE3HQbuz/KsEXeDv3g3gqiKw?=
 =?iso-8859-1?Q?5E9d2iYna9lxiGKjuaS8KDDWYEmHDhZMRusMrde+iRS6KKELBUNRvGx+A3?=
 =?iso-8859-1?Q?euOMV9f58eqgv88n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mvGZA7uWjtqkdCNXKgokG1RRpxKmNnUMo3siovUSYHWRd7p+3sS3moMpV7?=
 =?iso-8859-1?Q?otRYo9UZLG5Y6yOETV/eAz/LcD5sTNNJ1cZNrRqozA0th9jvpp4F+A9/jh?=
 =?iso-8859-1?Q?Ejh9te2DxybbKtvCgKE6sbxisdFUW6bNQQyjyx2si8t2k41RzhmcimF38X?=
 =?iso-8859-1?Q?5peAbhrp92h39fpkSECgkvczNZ7Fz07gCfvrt9FvTNO1j7+kqhuBmF4cBB?=
 =?iso-8859-1?Q?SVf7k6kmR9OCTzyV0s1dSrk4zdwyKDNgOMvTMupux4Z+I+SdDjNmZt9Aak?=
 =?iso-8859-1?Q?E0XmUv30Od/78QMh6rdfDl9887RpiQ7GYECwYTT99hasUiPhgrpvjd7w1R?=
 =?iso-8859-1?Q?0ZWeuNfaYbUsPa5he0vu6IzYTxXe6B7pjyRmi1Z/kwHiagSSer3VwxNr9P?=
 =?iso-8859-1?Q?tk4fa2Pz31d1n0op+RhaIWsJHvjbknEYscwHW8SaoKX0qaJT+oz7lZZXW2?=
 =?iso-8859-1?Q?jA6J1IYbZDcC0WhUhZtTbfUZ5qFKHSD14qpvx9CqNMWoJmQiUxuRSJEDbY?=
 =?iso-8859-1?Q?5XdyldjyTW5eIMqgHGVbYe7OPZJZ1scei5BerZp7Y7+X3qCd7pyb+EYKsc?=
 =?iso-8859-1?Q?iaPg7/zO5PtdMpjeP8u3JMh/q2W0+oOwIYu8IXTJYmi3uhzACyX2h+XEye?=
 =?iso-8859-1?Q?C5nIK7gnWYXOthP4XxRg2seh5NsLWdgSQqpLwacGUCGACnt3LaHcRgG3iQ?=
 =?iso-8859-1?Q?fhtAzd72TpQ+wbfY2XHXNNdlUyyszTEUkGDe7tc0WGxHoqhoHvXdAquGlC?=
 =?iso-8859-1?Q?XB5hiWYPL6AVkNKwOnTjXiWU+7QKn/e81/QnQnKL0S7oJ4jC7u/4mxm9qK?=
 =?iso-8859-1?Q?F5HKFDcJbhzYf4Z7uXwIETRDDUopKDLvmziA4rsh+wXMzkQjnOYcV28OIS?=
 =?iso-8859-1?Q?o2xyrKrm+sWb8cQ3UCsSbPxPhojiipj1AwfWXDMTBDKXCq8ImTzdwseA0a?=
 =?iso-8859-1?Q?KThm3Upr8XIRyHwvJOm7/+NSiP49tTamTstcuqn7HtoGUbFARc4TnVZ5gN?=
 =?iso-8859-1?Q?K75bVi3ugFc4e0KMc4zRG2yMS5GBwsUR6Mos1L0YmR1+jHofjudTVvYN96?=
 =?iso-8859-1?Q?RxDEjxahFwjJ+nhKNgUDqNBQ4ukMLkgNjR6qyhi0tcpPD/sRiPVhurEfuB?=
 =?iso-8859-1?Q?hHIljBHPoLBncnzUtE+7cSXBXNE6TO/pnsAlMxvLmw55/na5xFyKPgTwOd?=
 =?iso-8859-1?Q?/7XXHUWAqGdr3DpygiG+Ag9w7HpZtY18mo577kOjVdSET7suSgLZwwXD4O?=
 =?iso-8859-1?Q?eDPzjhfIBJMx0OODERhDr/UtWL17vPNE15XjSO1eeBA66ntvu8j1fzikiw?=
 =?iso-8859-1?Q?AI0tVZpvGbr6NAKn7efMIWNseqO3jvhivR+uo2y9kOxXDh9IS+gF4PeE24?=
 =?iso-8859-1?Q?8JdoGv1lMn0uoHvHP41n7Pu2ZudeENJYXjRKgNod4nNh/Qaq6vtdAIr+Gw?=
 =?iso-8859-1?Q?hJmhdnrPR/GK01qSO6YZDCp9ThC0xjVCG2sFMueNfIQyLuz0xYrfAVO7MO?=
 =?iso-8859-1?Q?cKj2dv5eiWsEB5OsYTJqOQMGRMynOeH4W7YmpjZSeJ4i6ToA9vTRo9Rcnd?=
 =?iso-8859-1?Q?3S1OAug4YFdjNzLCCpXaWIg+Kffad7FeNBO1lFe4XD7HRxlRROz4cztaKT?=
 =?iso-8859-1?Q?Q1mu+6rAi0MoDA5cx+/K74Sg8WFHL2KuSGavJpe3Bjl8rKav70IPJDSQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06713558-8155-4d93-3373-08dd529ed249
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:40:24.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3M46zYgjuty2nYlB8tmjTtiHfkcV3QIhoDWkCZMzjkdEyqaNGt3+f3hTMW5cQ4ofn1QAQKcaOmROVlFASDBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com

On Fri, Feb 21, 2025 at 02:38:41PM +0000, Matthew Auld wrote:
> On error restore anything still on the pin_list back to the invalidation
> list on error. For the actual pin, so long as the vma is tracked on
> either list it should get picked up on the next pin, however it looks
> possible for the vma to get nuked but still be present on this per vm
> pin_list leading to corruption. An alternative might be then to instead
> just remove the link when destroying the vma.
> 
> v2:
>  - Also add some asserts.
>  - Keep the overzealous locking so that we are consistent with the docs;
>    updating the docs and related bits will be done as a follow up.
> 
> Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d664f2e418b2..3dbfb20a7c60 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -667,15 +667,16 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>  
>  	/* Collect invalidated userptrs */
>  	spin_lock(&vm->userptr.invalidated_lock);
> +	xe_assert(vm->xe, list_empty(&vm->userptr.repin_list));
>  	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
>  				 userptr.invalidate_link) {
>  		list_del_init(&uvma->userptr.invalidate_link);
> -		list_move_tail(&uvma->userptr.repin_link,
> -			       &vm->userptr.repin_list);
> +		list_add_tail(&uvma->userptr.repin_link,
> +			      &vm->userptr.repin_list);
>  	}
>  	spin_unlock(&vm->userptr.invalidated_lock);
>  
> -	/* Pin and move to temporary list */
> +	/* Pin and move to bind list */
>  	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
>  				 userptr.repin_link) {
>  		err = xe_vma_userptr_pin_pages(uvma);
> @@ -691,10 +692,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>  			err = xe_vm_invalidate_vma(&uvma->vma);
>  			xe_vm_unlock(vm);
>  			if (err)
> -				return err;
> +				break;
>  		} else {
> -			if (err < 0)
> -				return err;
> +			if (err)
> +				break;
>  
>  			list_del_init(&uvma->userptr.repin_link);
>  			list_move_tail(&uvma->vma.combined_links.rebind,
> @@ -702,7 +703,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>  		}
>  	}
>  
> -	return 0;
> +	if (err) {
> +		down_write(&vm->userptr.notifier_lock);
> +		spin_lock(&vm->userptr.invalidated_lock);
> +		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
> +					 userptr.repin_link) {
> +			list_del_init(&uvma->userptr.repin_link);
> +			list_move_tail(&uvma->userptr.invalidate_link,
> +				       &vm->userptr.invalidated);
> +		}
> +		spin_unlock(&vm->userptr.invalidated_lock);
> +		up_write(&vm->userptr.notifier_lock);
> +	}
> +	return err;
>  }
>  
>  /**
> @@ -1067,6 +1080,7 @@ static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
>  		xe_assert(vm->xe, vma->gpuva.flags & XE_VMA_DESTROYED);
>  
>  		spin_lock(&vm->userptr.invalidated_lock);
> +		xe_assert(vm->xe, list_empty(&to_userptr_vma(vma)->userptr.repin_link));
>  		list_del(&to_userptr_vma(vma)->userptr.invalidate_link);
>  		spin_unlock(&vm->userptr.invalidated_lock);
>  	} else if (!xe_vma_is_null(vma)) {
> -- 
> 2.48.1
> 

