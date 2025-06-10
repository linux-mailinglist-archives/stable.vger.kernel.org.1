Return-Path: <stable+bounces-152249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B7AD2AFC
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 02:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2AF16143E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8E166F0C;
	Tue, 10 Jun 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1E6fZxk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C732BB15;
	Tue, 10 Jun 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516460; cv=fail; b=oKUf8sDT/hMm1WbllBq80UP9eRPO8APN5k+Vsqt185eYb9tZzTSIk0GWdppbeSPMr18j+3NRwBkc+NyzuP0kbrRQrsJ2Wc5phUjolk/ddekd7ax2CVwrGb63SA40p3iBjXYh4VQllkzpg6a+PdkCVb3KjSzo4fvwQLHqrlN0UDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516460; c=relaxed/simple;
	bh=WoFZcUqouzk6KvwMKgEIurXsAc9/7upASetRjWeozF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXhIPMpNwl4OQYV7IIQfBgeJ97c5RuSJimEE7NUHkiHoaBaJQubjLbuIe7Ys/pI72GjH/XoDjT5l7jzgdDNXMBcWRo1aTus2xheRKjQ8XSwojM5S6iiAx2JfyT8MsfPhx2IP7vjH7kriQss4kH7Kkps/qec5PmpjFVo7IjcuSKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1E6fZxk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749516458; x=1781052458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WoFZcUqouzk6KvwMKgEIurXsAc9/7upASetRjWeozF4=;
  b=g1E6fZxkUk1rpXivUTn6Asi0284ByOb/HGCj4k0+I88bBdqEyHq+0dHX
   gIBwQIfOp6R4tyBbpd/fQ12aOoH63V9PLDdDRKnqDhRgAowEOFIh2okvk
   te/cPNeI/Xoto3fp8Vxj3f4vANyzc6wnRZsOiO0CS1HVjVwZDnvP8fDi2
   XAIaYI2YRNCeLQSykS6ZXoMzT/4V++lWthpeRaUecTScZO1DzOIH8ujDc
   tZpJwfRDemVsqi0fYJ8ISSWVSt0OnIvksSGTZ4ffpC/6ufpGKSKHaK1RI
   dqHJK+nHcxh4+bHNV27IDJWHyhSah5wI66JVAB5DxEmyAJv9+9Qp5lZtg
   g==;
X-CSE-ConnectionGUID: PPyIXeFFT+S33NSiexUsXw==
X-CSE-MsgGUID: Akog2RqkRf+g/k7UFd2w3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="63014725"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="63014725"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 17:47:37 -0700
X-CSE-ConnectionGUID: 8xuL6UI5SNWj+WbI/KHQ/Q==
X-CSE-MsgGUID: LqHHv6dxQsC9qort9iIx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147028165"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 17:47:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 17:47:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 17:47:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 17:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMkQgd9BYTJwtRGpkk8nu5+4gSjDh6sjT4wey6+hnsFu9hKIC40uI2TeDBnIh/aC3Q4mvOaTm4YgVCf2mhqUTYYAuGql76WDYC3oqfExZ5tqLjAzBDzWFd/DctzT6BpYP7DyOpEOqjmM2vMGqrEVVV/+N0Guw9BtXCCf9XKCq9Ec/VN/lfER7yJodX4HqJ2jW11ll6igeeQdcWL19QhOHRZ5j0GbmA5LRi9UUITdnIb/upbOpoyVxlGIdnvchUnUbTxW0TrC6XxbpBa2JQLyd0+oemd1/7PqzcjcxvO3rtwS7YxTKffWS0/j8jucoI6BcATEr5dOLPHqbQSF74HrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrUUqMo/YxGhPJczu/Q1Z2oOUcKjQpWC5pkg4UFdexk=;
 b=D3wooEuFCrTLto/vQ3PalFGYivnjm0xYKQ47H40ELNlHMXb7yf7qXlg8S2fNY3wCm2FwFTa+vIGnhqTskPLpLk7YknneuMT1p3SXmY55FOHPUdPPxmpw1Ntka+IZmzWtPs5/EXFGfpXzsIgBiTEi+RSm8JsaxTsf1hrM8gLH6YS7K+6KxllxsUmcDKlPBy0yjv1GbvaE3gh5lQz7ziybCwf+dzE+T1jAbAJikzaBd6IyOPr6LBwwuQVovzzdNT89MXjz3t+g267DFvFL7vdZ/a2OCze1PpvxnRzagkfIq39arr9WcVTlNIadNh9EiDm4q4NZCp/ShrwGvOWwdgfYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 00:47:28 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.8813.020; Tue, 10 Jun 2025
 00:47:28 +0000
Date: Tue, 10 Jun 2025 08:47:19 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, "Sean
 Christopherson" <seanjc@google.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Ensure XFD state on signal delivery
Message-ID: <aEeAl9Hp7sSizrl8@intel.com>
References: <20250610001700.4097-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610001700.4097-1-chang.seok.bae@intel.com>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: c3192203-0d9f-4512-b6dc-08dda7b85fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UW5x0mhiuLCG5BTRjret0/Zk/4hpzQnzPmD0J3RDYFK5HaSHQl3nTkFHNALe?=
 =?us-ascii?Q?jfmDKgyXB68HgsFestcNnnuz0sWG5oS7gdJkuusF8OeyyZGXhREqG/IpyBEJ?=
 =?us-ascii?Q?ObAN8rMg3MAvehY4cEKVK3oVP3nwYC59hGF4dULCAXlQHiPcOOmtezpyfpwz?=
 =?us-ascii?Q?072qMhbWEvhIfW1pHskoIuuP+6R4aBXXx2/7JvJFX2yMRkQocR/JJWRgH5Xk?=
 =?us-ascii?Q?RgUSUrXbTDNi+zH9zXHiAI0UmqpeajG4ZAdl96gGMZq4+uyCtT6fkAyOJK16?=
 =?us-ascii?Q?iI/TxppujLzDYxVYTPJ5qHND1yZDqH/fyv6rMYHufooxl2wgcU2no2ldnZDz?=
 =?us-ascii?Q?istUmr/S4sv+ug6QeqkF7s4oGATv2+98z9cg1n7j+aHpfZ7WaTLO3TYtz890?=
 =?us-ascii?Q?Zg7KnbmZrpRG1kMbgBZpPXX/OSGJVXCmbgy6R+CWVV6+wNJFEm6oipAncjoT?=
 =?us-ascii?Q?mDf+UDicVdqYxEDIqxTKthZ39QIB0CMhHKGpzga/mk8uWTsfMQpgFlFxvC9x?=
 =?us-ascii?Q?bqqUpULPY16mwF+Sd2HEW6wWxyXBQ69SCKZBY69dMd7JFU89YnUjqWdqJWXE?=
 =?us-ascii?Q?MRbjsL75mArsJsJO+qu/6IUPSsXC9WYRMjVQO9sSre8vhtq3l5K3xegO0Niq?=
 =?us-ascii?Q?rGMf0cHFkyz2XwN6XCZpOJSae7rij2zmw2ZgLar13bk8DXRWhk50td1AfexK?=
 =?us-ascii?Q?ikvbviH6bAYkfQhnULmrIdfDSbhHGD8ZtNxROhtANMkDX3Bo6KBPOMVJ1FG1?=
 =?us-ascii?Q?ChM6jDVsk6pShmUf8wc2/1pYuzxWYDY+ErQSHfXRMIIoXZRYmkQzXwKfrrZ1?=
 =?us-ascii?Q?9Wc8WMM0X+KyuTq2dnvBkSG2TuivnmJ0Wa6s+fi2jqGKwc+vRUqYzDSwrncM?=
 =?us-ascii?Q?z7bvRYUPpy3mrDNBdFUyMbcHjiIG5P6G7iddEA9tOya9zsbNVT/2OGD0Hqoj?=
 =?us-ascii?Q?O/C02FXWwVlhNlc0p4XDEuwZVuoDEPQK2MJMGoD6OMBAAuhRFoBAm55ArNNe?=
 =?us-ascii?Q?Vox5X5eWEMIjVoRzcub0wFLuSAKIgd/ZOIU1BaX9MzfMHkNKk3Dsiytd4INt?=
 =?us-ascii?Q?7PKuVX7ypLVU2Y1fDAnhmbLjnz9nuiA7JZQOMdM94A7ElRV+Y1DRB8tA4bGh?=
 =?us-ascii?Q?XDkBH7HLO8YRN4/wCDPdk7StRNAgL2Gc+uO7/wNl5fE8iRNP6xwPKPQeoPto?=
 =?us-ascii?Q?iJ/s1QUtwVcaHZoxMQUkCHtY747p2AdBPT1jVdFSs8Dea1/6EeWWhFLlXowR?=
 =?us-ascii?Q?ga00avby0ebOglHvB8N3yz0Wq860JT+NEhbow/VjfQIAR2wWhJtibYo+53NM?=
 =?us-ascii?Q?C6h6crSy3mmWbndp2Sge3l7Z+bv4JOKuaMeg79PO8MQpc0T+CfeTPbIhMA44?=
 =?us-ascii?Q?nnsTh+p4e6WvHlTERknxqRTZmlOc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCZ8FHdlorhlVxGsJcY1r5fY8tjdxjet5wEDk9ymMLpFRdk+EGZ792GjLFy8?=
 =?us-ascii?Q?lXSEaySWvmFXVycQoqpkhteSQAZjriybFujKWL+ZfshV578yAN/isul2Zyh1?=
 =?us-ascii?Q?f5fQBEjziwVUrGnxj8WyabmulH70rgDIsrekq0WYSaEsZlf8dm6a+inOTviN?=
 =?us-ascii?Q?y+eAxXCDzGlZxLXdm300mkzBKn7Qm7jANWR4S5CwO2IN4B1We+sAL8T9OzxL?=
 =?us-ascii?Q?4gA4YG986768gAqkQ6nnSDeOzJ+JqSEuabYVSD1khVysagC6VmgZopQOI5Ld?=
 =?us-ascii?Q?glbI24qrqGMARAe0V+b8i8WVj0jIK1eNfsh1+Cvib1H3nuQeMqvKKfxZFby5?=
 =?us-ascii?Q?E0RcX8jlSC0ImH/2/UdFr5hXb89nwGc/Ywr4GetqLw14a+iDPWmbIC49RN6J?=
 =?us-ascii?Q?lDKO+tcyfm0uGZyGDGGHTaHaaRP95IGX9Z91lnqxmcPE1JRmhYSpOa0/0BVM?=
 =?us-ascii?Q?TNpnhaFufaijON6WtiupqEvvmsladE1QhRRjqnKs67ty2qvNla7XOiXJu47K?=
 =?us-ascii?Q?yjqe3JryO47eAO/2F1rb3yKdAdLoaLG0jcEdjSaN+YCf7ulAGeCET28FcyTD?=
 =?us-ascii?Q?v5vAv4jnqER4AqEi4WxCItZM2dfDHENaKFmHvvGj9vna1uKrND7+6wfYcvAO?=
 =?us-ascii?Q?3tjCtmiqY1SeyHlK11kZLTRpen3h6AiODOLmehS+v3aANE+4IQBhdIXHcunM?=
 =?us-ascii?Q?1I13PpE1rx9kVZxXLuz4sE3puCODfPK+Xq3sDRuc6p25sR4K6xuQHF7zfXSq?=
 =?us-ascii?Q?O2bHMZPsZ4KxIm4U7+WWWilJctx0asH4K25xHuM/tbgsK9fha7Xj3ZjuB0nG?=
 =?us-ascii?Q?XK2F/HJDcUGmjyWwnmwT0Yy7pJTIY9GXnVXH2DRtmWL/5UNtcwQ8cdBDQc8A?=
 =?us-ascii?Q?JNH6rlHxXm2AWTIONEjkrukRIRfvtCn0zG69PY8jNzdxhF93DQeveg8umoe3?=
 =?us-ascii?Q?SoT25ONMtN0rIq1/0qjKRsKTuf3JB/Kat4BVwp3dmSQXiFMsCkIsKaSpNmFC?=
 =?us-ascii?Q?w5roiOomH/EUUyOUc2hEPYfAZW/OeEbfhYbYzHNqcbX03D3ffOqzIsdWyJ6r?=
 =?us-ascii?Q?gy0Gu6uMel8kow6AEABChCjoQjaqvKHj8wbTexR8eUsFQOLoB1T0viIiYTep?=
 =?us-ascii?Q?9uYjPe6MGRNNMZV58yZECL190qNtexh0rtQpfJ4ofKHiHVvxw9aXFVZ8EeiE?=
 =?us-ascii?Q?6zPU47cqi9QdA87RZwDs+E57Yb7a5DJj7e03C116BQ/4zZjz7gYnuQo6968z?=
 =?us-ascii?Q?85HCKTps5E2HB04eoDbPToYM7CSPJ2nGRSpcmbOMsDQGdxJwXFOL9NCdjhpP?=
 =?us-ascii?Q?QtnUi4sI89ccp2GyCryIvA5CPm1kAGf9GN4rtC78Zgr19QWnbbulnpAwykRt?=
 =?us-ascii?Q?Kf3Q7AThV/yiZIhgkH8/alYlpWa5Ht+tHa9TjVm/oT8NC0LAloWpxSDBrxdU?=
 =?us-ascii?Q?k1kxolYxJeeNEMTYNKsgcONeCIPi6X8tCAitjKIGqCjD9fJ7754wQq9ThctE?=
 =?us-ascii?Q?5e+HLdysCVRmaW5JYbNNwdEFMhJE83FHpOPwHOwZg8Rn8oOHsex5B1/fQB5h?=
 =?us-ascii?Q?btURhIJm+8olvgIHLEeFVJ5BAHDddbVGu1Vkbe1p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3192203-0d9f-4512-b6dc-08dda7b85fcc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 00:47:28.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEQr03r1l9/swL2EZ0+p7KvkNm24b4ifQq5ixh3u/ZPKYkimWwlJupIv0Eh59nSMVIQuWYCs1bR6hfU5lIc6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com

On Mon, Jun 09, 2025 at 05:16:59PM -0700, Chang S. Bae wrote:
>Sean reported [1] the following splat when running KVM tests:
>
>   WARNING: CPU: 232 PID: 15391 at xfd_validate_state+0x65/0x70
>   Call Trace:
>    <TASK>
>    fpu__clear_user_states+0x9c/0x100
>    arch_do_signal_or_restart+0x142/0x210
>    exit_to_user_mode_loop+0x55/0x100
>    do_syscall_64+0x205/0x2c0
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Chao further identified [2] a reproducible scenarios involving signal
>delivery: a non-AMX task is preempted by an AMX-enabled task which
>modifies the XFD MSR.
>
>When the non-AMX task resumes and reloads XSTATE with init values,
>a warning is triggered due to a mismatch between fpstate::xfd and the
>CPU's current XFD state. fpu__clear_user_states() does not currently
>re-synchronize the XFD state after such preemption.
>
>Invoke xfd_update_state() which detects and corrects the mismatch if the
>dynamic feature is enabled.
>
>This also benefits the sigreturn path, as fpu__restore_sig() may call
>fpu__clear_user_states() when the sigframe is inaccessible.
>
>Fixes: 672365477ae8a ("x86/fpu: Update XFD state where required")
>Reported-by: Sean Christopherson <seanjc@google.com>
>Closes: https://lore.kernel.org/lkml/aDCo_SczQOUaB2rS@google.com [1]
>Tested-by: Chao Gao <chao.gao@intel.com>
>Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/aDWbctO%2FRfTGiCg3@intel.com [2]

Reviewed-by: Chao Gao <chao.gao@intel.com>

Thanks for looking into this issue.

