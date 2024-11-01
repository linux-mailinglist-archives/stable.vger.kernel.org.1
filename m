Return-Path: <stable+bounces-89503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0FE9B94B6
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393B61C20E26
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF915B0E2;
	Fri,  1 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fyj1IDPl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AA2CAB
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476075; cv=fail; b=o1yzPlDMUWgbf33c3uTY6noY9wPu7RHhpP1WRTXWOYAkJP4Vb8oVGUXmybalUPwGAcHs2CCZuqPiyBI+uSr+65SEtYSMKV80Ip7I3woRB0hqR7qsllmsEmPE6lXJqMn5zffdWr1ucvT9phXjN0PQMMEq/IO7UYL8YlJvZeACoiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476075; c=relaxed/simple;
	bh=AOazqsJhbHZrN6Q+6wXU3I5rUJsHklV7FFQ3ZUld8qc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HEfuHrpQjU9Wx/TyVzGsjzxZIF40+Acq+1QOz3pC6fLNAVVkKcElYaLEjHHOnjkATDA0xYNfTm/e9NCrt/7oLZxCdiuisAAl4ptioLkjV9xK/ibuVZTL1EZL2+m2rp3AqtLqHja/uWRlmxF/DhgjeoLWZyXXiAts9RegD9mbl44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fyj1IDPl; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730476074; x=1762012074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AOazqsJhbHZrN6Q+6wXU3I5rUJsHklV7FFQ3ZUld8qc=;
  b=Fyj1IDPl5baM2UxSWSCEQxI41nlXbJw9nqTh1xRZyc73IYP9yYVz7Tc1
   CMDtYIVcstD0arhuRJ3Qh+qy4O8yOppQxE8+sbYCP+eGhvdxaqWam+rB8
   sAykz8HBRcPDHgGCfDA4KxCd3syxuHzDvyUe/PB7T95E8fWLHRWrbQfEu
   fh0T6ugVkHi83MHpcNwxBm5uLr/cKyP6SYs9M5poMvA049/S/xK5I34bN
   KQH2Fl7BU+/nEL0QVkeGR/gmCHGmpCdlWENDBBbXnEYNOrbKXjNCHmD7p
   RCK7rMZNm1x6TJhY32tEdNWGAsvanIKrlT0k+8pILlAzMYwKAEPj3+BOD
   w==;
X-CSE-ConnectionGUID: Jus05MCRSsKvHGvly2jjsA==
X-CSE-MsgGUID: Z/zuyIp3TMG2tpNFaEJKFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30457476"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30457476"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:47:52 -0700
X-CSE-ConnectionGUID: Xo/1sJcrQtaPTb4sjjuV1Q==
X-CSE-MsgGUID: lgPsXhq7T8eaw/zyAwosjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="113829064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 08:47:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 08:47:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 08:47:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 08:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNxLt06N3wKJHrAlMnwvnBc2xq69lfdQFIA0oHAOdlfvyglg+XxC3gvAxhN4YLuwTsXJOsQO8mTIqfu9s4gQIpKqR123SeUoKmNSa3Ms9bFnm600+Qxw8vzKfKJWMnRSKHrmAsiKsthibuteROWLEgxX39Kml5UyEPds1cXAQmQkCRzRT6a0TSzoc8TzqAeI4kUeIihqlx4LBJZ+HggWnJ40HpoFNpEcBXp/Y6TBdBeW+jnSN9i2WitxV0LLAQk8A+DCUS1ocz1LsmL8GdxW40X+Gb3JQCjCx+1qPJtdxGacCNhyB2nH+ZgHUxh4IYGE5d+iw9yB+POrW6D4jhWdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOazqsJhbHZrN6Q+6wXU3I5rUJsHklV7FFQ3ZUld8qc=;
 b=J91GJMLleBjQQwhpmpBaDfjZ/wE1jZUa8uuGi7dmY8c4DRcS/5YJL2op9xlEDk9isKDLq57UdIxhlvcb7XBUeilblBeUp8vl9+/uEDpbU5B0Ji5imoz2fBVn1tjB5EQIAareaaES3XRtoaD1/r6WicuYzBuqjgDTWQ/bgQllJgw9fczPVLem8S+L+uC2OiH0KwdDtVDfJ3Ddob7k3iK6Lr+h38h631tbJn1akErn9i+ewlIudHD+cGxZVhPV1zDhIUwv73kEuDIumQwWJhq7QzIy5Cv2+uuz/f/l5ego1HkkLPcpzDEyk/qOnbAgz5qS1QdEEvhNlJQafd2BbNqgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 15:47:49 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:47:49 +0000
Date: Fri, 1 Nov 2024 10:47:45 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nirmoy Das <nirmoy.das@linux.intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
	<intel-xe@lists.freedesktop.org>, Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, <stable@vger.kernel.org>, John Harrison
	<John.C.Harrison@intel.com>
Subject: Re: [PATCH v5 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
Message-ID: <lrn2h5h3abeplsmbfv3z52pgtd6gxmc4zgmee6g2yl2gbqakjf@sf5ydtmk5rqr>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <afd4adf1-5220-40ff-816e-da588b74fadc@intel.com>
 <65a8fa25-0c14-4251-ad22-8f4b31be0d4e@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <65a8fa25-0c14-4251-ad22-8f4b31be0d4e@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0361.namprd04.prod.outlook.com
 (2603:10b6:303:81::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: de2b7022-4650-4d0e-6a18-08dcfa8c8979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EJQpQyQQphtY5pp9WXtHu8soQxQrwpHv1i4RsqYdyYLthg55MD6Q0NskaslF?=
 =?us-ascii?Q?fQYVOlp0tvuyASThHOMSxdEMjjYhA7EV/5Op/pnunnNtdoryVrwwIpu58ysu?=
 =?us-ascii?Q?9+6DHu625eTBw3zlKw/Nzxr1/M4QHDZKt3iGtbxZKHWdMgWH1dgaRHEtlrko?=
 =?us-ascii?Q?P8PSxGgnYnqHXjfjvKsg5KRIS9a6okvoeSyDu5kkQB+M6AhUWdfe3XzuRO5D?=
 =?us-ascii?Q?5b5HpgTCxNsS0B+vDVsksuodqAAKBztGWr4WfhEIZrdhlfgIbX8o4io+hNv1?=
 =?us-ascii?Q?YhuIIXP6PmhqD8telznrotdCm+TOex1+ektD7MkKvUl/2cT75qXgFr5zQeBR?=
 =?us-ascii?Q?XuVVMfOtJzNeSkSdNzjnhNRggEdEiL+0v0ULWdcpawNEzUbdWViMQS3Iv3+8?=
 =?us-ascii?Q?9w7iJZBBV+c4ph36RCUJKXS61HEhOGA2egVvyvCYRjO7OA/4FXK3wJFwstKc?=
 =?us-ascii?Q?6RvwXvACkZKRCgnkhocRNsiCYKXP42+s+osoTIjtPxAisE1uvJnWSnLn0bzQ?=
 =?us-ascii?Q?M+w0kbTBnP+y6u+Xl8Ka47sQG5Ri3Enmdgmnbj5dk8/zeAVUHyoy3+pqOQJ/?=
 =?us-ascii?Q?NRa0/9VekS1pYPt5/0O9joHcg7atIRWEYp4uKFCxAoqOpk+RR88p9ikjm0iL?=
 =?us-ascii?Q?1m9LTdvrZQKSUS89SMTqYpqNSK1MW4Pi9lhgJXV+iuKB5BvMhF/N2t4T86Wt?=
 =?us-ascii?Q?CzYHGdtRivFWyW2y5Gr8hOhFN/DDW6npsAXW8ovKYJafn5dosz2mdk3BcNnE?=
 =?us-ascii?Q?cPYJ+9zPb/W9UcMlIs1VL7AneXr5DBYGVSyP42lrbpW36xw8p+1syZQNlA90?=
 =?us-ascii?Q?ii6s+LojIVNzU/MlanYaoxvlqm3kqR2KtaNEAF+FwJoKqNqBPVrAGLpU+oqU?=
 =?us-ascii?Q?TUFDDspaFx/KsvuynVDrwprsqDjrXMjioFD9j71Q8D68D0/hcD4Wfk+Lun08?=
 =?us-ascii?Q?/UGlsU36yRXeTWbBdxbkt0SXvLCL716tN0AEkw1TUtadOfC5nDFDrwPmfThI?=
 =?us-ascii?Q?CXf9EmF0KhVwD1xyFBjcbKoN0gJXsG9Wli7dIVsaXqhlfg8akoWRyImagBQE?=
 =?us-ascii?Q?3I1Cyw0In07DFsqfUOBrN/CY+yRysCj7+ukss2y/mWF8Lhn8bW3eLcKW6HRn?=
 =?us-ascii?Q?ritni6b0CB7cPIeP77ondeBquelwEIZM7ms/rAP+vcfiFGC0YBuv6Xy8uHHK?=
 =?us-ascii?Q?+UA2jeslXGX1qkj1g2QknhOd4B8/6gmdq/E+ZUSqIHxrBohQz4VWMbszIkRZ?=
 =?us-ascii?Q?f9rvdHc/13dPzxMzL/CrbQ6sFfepInY4Kib5IrbYFAlhp4kTUQ41HB03G8rJ?=
 =?us-ascii?Q?A1yqhHKzPdpUsKkuDUS4EnX+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vOc7uzXx3uS9v2cMjxZhOqC0ehWKH6gkavRqTrPJSj+TKRMQmvQ1AkE+tx7N?=
 =?us-ascii?Q?55QLDq+Diws+y/yPRuzxQOZn16bcL2qr9B2/ptOoG6ycq4ZeNQB6JhFjdZLZ?=
 =?us-ascii?Q?CwfJrsayCQk8lUHeM8XsbILqEgHGJcu3KnP6HR+oL1EfpzVPGjQsNw5BnUW2?=
 =?us-ascii?Q?unToCVsMr2j4vw8v9Oeu8RuwiT8xnYYxPxRndPW/jrFZLjSRjhCIGQuIfEmM?=
 =?us-ascii?Q?thvgy8gevq+gmEtfV7HJa6okY0Wkmc4X7AMvoUyIvMaZb9P4bUDLlK94XEcV?=
 =?us-ascii?Q?McrMy3ZLat6R/re/1mO8ajWEAarpORIn/aQUBFHnHQPtaGhHq8OKVOeK37Mp?=
 =?us-ascii?Q?LdSS3QoMwV5JwO59SyLQvQjL0/SxFUzGBJyg9HrFhCaLJe2Bzg3Dt14Qv/25?=
 =?us-ascii?Q?ufmNZ1sJ7disT/eDg+vfcYMIlcrt0rwQYn+gIZ0IwdXwdwxQfVg8CKltCmNR?=
 =?us-ascii?Q?O7V0A7izs5lPQfgkPEGSeBsBD2O4xskGAwDoETEjqEBg1fcUazLhuUPUe5L1?=
 =?us-ascii?Q?/Ex7RYf1EhxMpWdUjUf8Js+kQXnO7AcfMvbsyLOw86j3wxX9moO2UoYLoIn/?=
 =?us-ascii?Q?H6dGY1DgEeT3+dUn0hDWW045lzqHR+T7PI/5ulKpU7KKhYUf9rgCZZSJuR+s?=
 =?us-ascii?Q?dtl61UqUtWjmxDc8D6FeldW/C976i+IVkvxEjrxvmW3aWMnSIJdGEazE7ua/?=
 =?us-ascii?Q?sFWYOFR16IKga2MeVgvZUJ8LGDNdUafVbmLwNyoZgR2fzoQsJaQhlGqx8tXi?=
 =?us-ascii?Q?tMejNZRP5/QrR8kR7VrEWuDfYv+OqE2KVt2SvqUnocvY/W8aaPoEcNZs9pav?=
 =?us-ascii?Q?4qbwSGoMzLowOvY/P2qas6qNtIa+vNJWmFr36kjeOADUN/lGaG25FIcxUSny?=
 =?us-ascii?Q?TtLoFH5G68hQ8Ntdsi/1hfgcmxb1cSsnqc9rMo97rkWc/w+U6yvC6hCYEu3p?=
 =?us-ascii?Q?HNj2E9Gufm/k4ff93kdHuAA1Ds/JT7mD1lG3iVvpGxx1XZb55m84fwdjsQKs?=
 =?us-ascii?Q?BpwXuV92f2r9HGCBtGF72K5xf8xEKJsJ6VH8tmS/bnYIK+c6JR17MK9qrfrO?=
 =?us-ascii?Q?x84oQQRFF3eHg5RjtKKZja0Yo2AhJ7u0A8uOia41FkcByqgQNBrKJkxgJwpP?=
 =?us-ascii?Q?wFmIrdrqJReuOTcRxzxq6yST2AojMJABYjT65VhNZcRwQQCl9S4toeEgPLzl?=
 =?us-ascii?Q?waXZMAkjodkzcldgmkV9L68eI8HqGiiikR49HDxjZOxNAs1exq2F0wqBY+Nn?=
 =?us-ascii?Q?ciQG0EPFXkF6vPdkmaE76PAE1OEhEQniY6c2Yfjm+hqgnGM0kkK95jHhzFP+?=
 =?us-ascii?Q?NfVUrCn/ojbQBXzqBx/ryJLrUTxTRTjhoz83Ri+irjFm+wcO3C2jPQ11+xA6?=
 =?us-ascii?Q?BnyonMKbjqasVAYiB9JzB/LIGCYLHS1j0jvevEx6GljGJaqr4eexBEp52Qpn?=
 =?us-ascii?Q?L+UrwbdWsKBrlqD7YymqXir4IzA8hdI082Z6Zb5aGtEcXtFwpOzifa3pfh/b?=
 =?us-ascii?Q?RfrWcAHH/bp6ENRc2mwDufKvbh1+ALXzf9V9aB5vhZB5PvkNVgtegqrWLxaE?=
 =?us-ascii?Q?p9qpRWWW68ZceZKXm9xN88N0V1GYjXnBCglaVBYkovrdhutxicDR2Rc0UYvM?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b7022-4650-4d0e-6a18-08dcfa8c8979
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:47:49.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R6bK7rCmjzXc+zRpD3QODjiXOyaL77Ch8ETzz0XQ0jMkQLQnEwN7YmzFzKbGR3SH3LbewN94WZ428LOzd1do47qESzuCKeD7JsOo561uhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com

On Fri, Nov 01, 2024 at 02:44:13PM +0100, Nirmoy Das wrote:
>
>On 11/1/2024 2:21 PM, Matthew Auld wrote:
>> On 29/10/2024 12:01, Nirmoy Das wrote:
>>> Move LNL scheduling WA to xe_device.h so this can be used in other
>>> places without needing keep the same comment about removal of this WA
>>> in the future. The WA, which flushes work or workqueues, is now wrapped
>>> in macros and can be reused wherever needed.
>>>
>>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> cc: <stable@vger.kernel.org> # v6.11+
>>> Suggested-by: John Harrison <John.C.Harrison@Intel.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
>
>Thanks for reviewing the series, Matt!


and pushed to drm-xe-next, thanks.

Lucas De Marchi

