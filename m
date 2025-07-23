Return-Path: <stable+bounces-164495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C0B0F8BD
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72B33B1106
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA221171B;
	Wed, 23 Jul 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx9m6kIF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32520E717;
	Wed, 23 Jul 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290861; cv=fail; b=QePIcwvDBAfSpZmRcr8lBX3s+KdLHbXe+Sl2ldN5RaXtGbSr8MkDvOrzgxCwF3c/bsOHlK++OqYEdFgieyJBQyuXD/5a3QrzOEstJKbCdZ7NgtkJWLVqqnVlyHWHg3IU1ydkhIq4x3BesIlUquC3cfSBFaWL+XeUz4Tyznu4/Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290861; c=relaxed/simple;
	bh=OVNM1O7dyFVagHNr/ax2LY6ije5d9D+dNyxZ0uedr+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aCSILVBWPemV1RvaFtFvxHbaJ7dtxBtmxGWTiYwqCVq9Arwchjd1dXh4Ie3XMx3utqD+9xhMWrMAukAz8LT9vKmWxdFv/I0dCOkR4EJMJh+22T2qSQTYEX5vMG2QkIH2UZuJY0cmCTs9b2Un7kjOUUw+OVy6o9mqouJ2UsnroGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx9m6kIF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753290860; x=1784826860;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OVNM1O7dyFVagHNr/ax2LY6ije5d9D+dNyxZ0uedr+M=;
  b=hx9m6kIF09Aik0gmMKtWjaZftydbxfx9I1LruWYeRAyYQ3ootxRl4lUY
   uFuMVYZ+kaGHTahcybfeu8iAGPok2KMbQrsDHksJEJpTFVskiD7UXAAhr
   ng7AozgEPTNBouvLbe4lD4VkYdITTFzgwZXHNXCSSl7DNEYATXAQ2RQY7
   0rJ1vjt7zRuOC6gaupC02wRqNFuUHGMQfM1ykztHN8knta8yKYaDWpT1f
   j1WFL3By6vDsGubqYeidY/zCQWynn7W+q+ib8HOGO+WPBlATIpKHXX5xw
   SUILUvKrjcRDuVcPJPXr2t9EnqiZ8MA2sbBi8ppdS3CHXeagP8FCEsDeE
   w==;
X-CSE-ConnectionGUID: D/3F7N2QSMaPRjKJppyRYg==
X-CSE-MsgGUID: jtiAfJPUSB2iHQH0nJvEgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59398170"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59398170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:14:19 -0700
X-CSE-ConnectionGUID: 3czoFQJSTRuNoYBWL6uXfA==
X-CSE-MsgGUID: U35DgfGhTpa6QOZVf+AyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163880281"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:14:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 10:14:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 10:14:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 10:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i25KFeD+xYhkgIeA156n9BLcblPffp7ZCjZ3U+09uNacaumQJ7T4wgSHBXPWhgf/TG/aHWmoplKcAWKekqSpsWmJF+6cNJ1UuEJc3uJaEsGOj8KHsWTCXZnJYxyoSmsqhKH53OIsPnV9GmU6R8RfuCKtR/Q44XZZZPotAWPJ7it6ClUgsFBKJ0HkJkGbW/MWljz8Z3w3OdK1II+pAAsLFcx1xIn+N+NxsoBqfCQ0ymNdJICLs6HUtc+3dVtWJ8QS4ZVHPpVez2PKhzCnmr8Sl/BPcFcBmGze9+7xOIFJ0tXoZo8uzQN+76vTuP3tuTReDb7h97+pYHHgfLasx3eSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgQNoK4lC4nuHvn2+tudLLAiQC3ssZ6pUOEoZxrejG0=;
 b=USJ7ObV2HkXvR/O7zymzmzvs8Mv3lUMuEtqPmzSYj1Eu679gRwEPXJWAOPW8Eqc3aNY5qKd4NV5CeyJJt8hoY4ZhhYegpZOAnZ62YW2CiwzonFtyo5FgFOJUtfZaur8PEJ1+xzd8vDaCe4/9EKQAFAmCmC9R8UyrCaJz2fV1fHsIYQc1wBmArxAXT4IMeA12mEggKtDT8nUAXT4nKrvVT6Y1ZYKnUmDMTUWdkf47W0z1Wd4LAArwGrAuVgHtvit708+ytGLYZoWw8c34wA+yKIF28c/fuXwu2/PUZRvwJEz2SEt9Ttb3rEz3sYCSmSUT1KLjHwEFYChYCWNc8gX0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:14:00 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 17:14:00 +0000
Date: Wed, 23 Jul 2025 19:13:52 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "Kirill A. Shutemov" <kas@kernel.org>, Alexander Potapenko
	<glider@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Xin Li
	<xin3.li@intel.com>, Sai Praneeth <sai.praneeth.prakhya@intel.com>, "Jethro
 Beekman" <jethro@fortanix.com>, Jarkko Sakkinen <jarkko@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
	"Fenghua Yu" <fenghua.yu@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, <stable@vger.kernel.org>, Borislav
 Petkov <bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <jee4jnrwcpwukdibgwxts75wyevdj3kuog6qbutnd5jxtnhwqm@4yglpeq3bz3x>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local>
 <xfshxftto4al2syvtrmbqbswlussduvncodyowjwfcvi23v45e@sy4e4hckbf7a>
 <DE4839E9-8874-44A9-B675-AE5FB26C9260@zytor.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE4839E9-8874-44A9-B675-AE5FB26C9260@zytor.com>
X-ClientProxiedBy: DU6P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::12) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: a8284c3a-357e-4282-140d-08ddca0c50d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eHlntJyjhJLsbwPgje5FKilkM/UL4il5/REr0lAUQPUlN0dP8SRk9HWcde?=
 =?iso-8859-1?Q?6ld1QGobgsxpMGpPhBSJm8vYCz/IBgoNEaYIH9KaRWf6tNx+nKFNTdnOiY?=
 =?iso-8859-1?Q?8vUBlay8iAv/DTMV2QdVALzmsK90n7UIgchmWbw3pHgLj/B6f7WSw+nCtr?=
 =?iso-8859-1?Q?FniYmIuEu679Jtwy8bKYYsW9cRVGy8Z6AuTNIrqkrc+HgtiNbOhxR2CGKL?=
 =?iso-8859-1?Q?mby3RxyITgkysZgfQ9RfMjG7rwU+JmzB4YdGUF1pr6YA2I+Lp0R+o+2L3e?=
 =?iso-8859-1?Q?sGaZSK3NX7EdS+OyUICh62VUyGV1/hXYziGj9gnwPEZkdyZ8KlkftM+ki6?=
 =?iso-8859-1?Q?7oXOph883r0jXaaRbUXbIX7/VPW/TlEHGD1paMY55v6GlfxIqmzwRg4U4i?=
 =?iso-8859-1?Q?TIYl9Vijgo4Rd0XaHcQZ4YMuKWfzeDU1RTakA0dADypV///1kQ318SwHdj?=
 =?iso-8859-1?Q?Fp52CdCv42o5jQG7Q2ylD36k1EPiChZXVLEntKxUoZotUxHtRV0neSDDMk?=
 =?iso-8859-1?Q?4FTY/YtsLx0O5rJTXxek+ypIlfQD6bnjKpgCZsEZg0sg6SdeNNZFLNmexP?=
 =?iso-8859-1?Q?qne64pR/RO4oRzQUgPVjpAxMN9xO8VjgEzVKt7kyU5U48ektrMSeXazxso?=
 =?iso-8859-1?Q?hWczL+CLpZeRlYkfl3Pgy/3kieXuz//51miRaPjKxoHrhPoQn4FTGBxJCH?=
 =?iso-8859-1?Q?PBUkssJMMm+TrLFHuawA9rk2lbXKVNN8Kie7Pg62uyl0HXTzaGtQXmxrmv?=
 =?iso-8859-1?Q?uYi7AyjVYj9puMYo1jAPzXHdDCJftbgX/+E+ziLHJAVc5bkEKXjXkiwEsP?=
 =?iso-8859-1?Q?/H/AUwi1xHTlcO8KXZOceD2/yDBbtq97DNFPDcHw5LI04/KhMIRo99YPHM?=
 =?iso-8859-1?Q?4WlVNG8Jo6Abl6ACFgouRbD+GOnwpf4P5l5MCfzoylcoRtFXIpu2RY+4nk?=
 =?iso-8859-1?Q?vYCJFRImuYRRST9iEGiuqTloQHwGt3eh7DAsZcLW/TlubQd1J7BklaxvI1?=
 =?iso-8859-1?Q?SSDCAlQGD4Z14jB64SdTGLvkLG/J/l7ixuRZDoHEbU8nz7mx03Bw4DlyDq?=
 =?iso-8859-1?Q?wlvW//d+/yUBq5sZOo+xMYXlUlCLkN1ae5rkYrWZKFgT7YEwjQzC3IKlOj?=
 =?iso-8859-1?Q?0jJeyYb2SFiQFtCGyOl2l8v4E522suf0bXbL7nxyZ63zMplcb+LrY2WAEQ?=
 =?iso-8859-1?Q?j195G+XmwAfj0Vm42e4Tf530mT8iZEEsanOhZDgdI729GudtlPQ6hBRQm4?=
 =?iso-8859-1?Q?E6h+TO4+j6p4bNr/q8mocOAOn3TyPGsglaRISaItGEcLlwhAfZcgnaK+F8?=
 =?iso-8859-1?Q?YJTjk7fTgcCZB/6+u91eEH2gCM3qFIHydVpUnGOiOTIy0dXouxHgQd37i9?=
 =?iso-8859-1?Q?BDkHS2iOAqDXFUL9UneOdF7S7WPLtIs7Lgel4Un5aSGpcWpYErwvn/JCL4?=
 =?iso-8859-1?Q?iYZeivTSd5s7WJ4RuWKUExU7bGOI5uezdP5LYNp2Lb2jtr7AspvgDBhlYm?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tS22TCqpvnk85ehwsHCCk95h7Kfger7j8QiQkC715wTp8+/9epJc2N4NA1?=
 =?iso-8859-1?Q?zGZE71QiOy/HIFq+oRarcDqxBVVTcuaACgUafh2FOYXGE2sSdXQSR1wdqI?=
 =?iso-8859-1?Q?phR/bsRAmmIsIoEg0uj1eEPAwLu/kzdv50EbimriSVIoH1Lj5n5KHxHqQI?=
 =?iso-8859-1?Q?i9Xlo3OpvkfFtpFFnApNbSj3FAOB1ZsiyiuZFByjjPD4dP+q6wQwDzSJcA?=
 =?iso-8859-1?Q?N4IYjmU6jr9cOZ3efK0pZjCaV/BtlfA8Td4TmQ+lVEmbe5Cr3fhgHD3kZH?=
 =?iso-8859-1?Q?1iU7tC/qyX+qmb5tP/6na1iydj8P8uDUzhPQsHp7k0uVTY0m1foRzVUw8J?=
 =?iso-8859-1?Q?RdriKIrD6jfXUMN6ANwjxwLB+i5Xcf9kG6N2QXWLOXlMNN+Xrx8HSAIpDB?=
 =?iso-8859-1?Q?sSkuLoXi5kEB7LNy43iXUMyDaCMxHmaarOYxFKcRbq4XoosImIwXv1302D?=
 =?iso-8859-1?Q?5oBwZgsiWZc2t2AKw9xEBA8hdz4g5bYUZEJCxYsKEcPqO8Y8CavBGI14KX?=
 =?iso-8859-1?Q?N4wAm/4aBOzZxOFmYA1DsvR3AaBpRG0V85GKvihC59DTP7kqd1WdzjsSk+?=
 =?iso-8859-1?Q?+QmjOrIRyzipz9dq7xKBZLYd1pfwcE5cgzdadGgs1NYnRUyYmwEkDKzQCm?=
 =?iso-8859-1?Q?S8l5R/+VZ+8H1rHtIUV5LEebyMYmXwxtfu3cLxGPiAxU7KjBMRRHlE+BIZ?=
 =?iso-8859-1?Q?mlgTe2Q3oEmE8OaVdDMBhnF++hGwSsiWE2i2mZB8vbGtsiVcrCZj6A/Men?=
 =?iso-8859-1?Q?QqYvsnxJBuDyN2OKfP47tZ0+ajSc2jznXoxqx3keTkJfyMZSiIb8r/pdlT?=
 =?iso-8859-1?Q?tui4p03y5k/S81Vdrp2APE5x4YuVC9efGVWjcoJX2pHLHYjMKs2Vpapmwp?=
 =?iso-8859-1?Q?+yOFARgQHWFh012zCKglyoZxCeJTDY+kfFJt0aAO266s23Sdmqji3RQJXb?=
 =?iso-8859-1?Q?yfCUfmFz8ygR7YHn1cb1Z/4sVrbiHSZNa9YLp76OHBI0TtmUjGzZUyO3rf?=
 =?iso-8859-1?Q?WWeejbum7gzNxEml4lEwugQ3Ofn0Prak30tBWrpYe4gw+lsaGrOFn8lI4i?=
 =?iso-8859-1?Q?fqhpG7PbDoIKe5ne6pqq51ppnRgc72SCBND69zA6BH2sbVpCWChjSKsGT8?=
 =?iso-8859-1?Q?Xlm5gDrW2L2StwUjxUSVE91VBnYnWuk8ZE7iYoioWGEBIV1gnua1BveaJ2?=
 =?iso-8859-1?Q?p9f5AdBwkoDA9F9oSIvYuBwo0fMYu7YxxcdDb2HYmDaBItNjd19o0FHYun?=
 =?iso-8859-1?Q?G+A7JU/9IjUaeIQfYhPjtOO8yX7OVEHqlQYKpAmrfCv2YS4Swat9QqXvi9?=
 =?iso-8859-1?Q?wDkO38DwMsRDf3TQb8Gj4eYFOzlHIizblmOJUOTkYGZI8dTjkaTAPZ5uG/?=
 =?iso-8859-1?Q?Wy/dekf1zE57qzu9T/69iNLlyjiW0hmCAHFZSWnihRJtSS4UaFO4gbjCy8?=
 =?iso-8859-1?Q?rQirPmBWMCeU9SD3vmNMXTgs8U+zN/QmOOfA6sbTJdWJEWdoO0Wrg/oJtx?=
 =?iso-8859-1?Q?cN+1Z9Y+qIsOBwBwNsq/5MQWLT3GTWzmqSIBcI/H5a6BfVtVNopQkOOfTt?=
 =?iso-8859-1?Q?UxDIxMLjmv+UTFCWs70pZPpvAFNelpyTaC8YM29khPR4wrNvEX5+2VNFfd?=
 =?iso-8859-1?Q?BPzZdLCHNeFGkZe7zPyp93vk4Q740Uc39BWB9DKOAexUBtHS7VHl/0KR9v?=
 =?iso-8859-1?Q?gr+QTULVykDnez7hkPs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8284c3a-357e-4282-140d-08ddca0c50d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:14:00.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btnUAbkPXFlp3BMEV+bi5l8MbhAZUv8fJUqQ3iVh2KeJrIahbMRVKudzoJQKM+lZGibnXiBrbxYsd1tXTY1xOWjD2we/o2+dckSOwBOPRco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

On 2025-07-23 at 08:28:32 -0700, H. Peter Anvin wrote:
>On July 23, 2025 8:13:07 AM PDT, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com> wrote:
>>On 2025-07-23 at 15:46:40 +0200, Borislav Petkov wrote:
>>>On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>>>> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < NCAPINTS; i++) {
>>>> +		cpu_caps_set[i] = REQUIRED_MASK(i);
>>>> +		cpu_caps_cleared[i] = DISABLED_MASK(i);
>>>> +	}
>>>> +}
>>>
>>>There's already apply_forced_caps(). Not another cap massaging function
>>>please. Add that stuff there.
>>
>>I'll try that, but can't it overwrite some things? apply_forced_caps() is called
>>three times and cpu_caps_set/cleared are modified in between from what I can
>>see. init_cpu_cap() was supposed to only initialize these arrays.
>>
>What are you concerned it would overwrite? I'm confused.

I thought that cpu_caps_set/cleared could change in-between apply_forced_caps()
calls. Therefore if we also applied the DISABLED_MASK() in every
apply_forced_caps() call I thought it might clear some flag that other function
might set.

But I've been looking at these calls for a while now and that doesn't seem
possible. Changes are made only if features are compiled, so it doesn't
interfere with the DISABLED_MASK().

Sorry for the confusion.

-- 
Kind regards
Maciej Wieczór-Retman

