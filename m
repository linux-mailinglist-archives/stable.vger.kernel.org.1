Return-Path: <stable+bounces-164470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836CCB0F6D1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94FB1889CB0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238862E54D9;
	Wed, 23 Jul 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcJgnYk6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764182951D5;
	Wed, 23 Jul 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283646; cv=fail; b=CgYcZ2PHVWchDx/ZlI4KX18geT7mHUZuTpG+r6yB+h3LhXmKFGwefajA8dYDikG+h2dsiQP0vfFkaevnrcUcfZoYhhQeoaHekX1edT2m/oHsG/3cDg8jiYMPMSIXrT/KBkPi3UwNc3nTBJuQMNarN4CSVRFQg+zHeP81a1c/8kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283646; c=relaxed/simple;
	bh=kPISuOmRiA2dL5KhertDdUTZYSCTAXJHslj0JR3wCtE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBtH/52pQzYGhwchmdHt7KMI0jrhsZZeALsODSUfGNWT7Ck3yX4N98U9FGSYPxePyFjjmL+pkV9RUd+n6m54G1ChaIp0uidPXQVD1vZzo78ewsG50N22eq2Ol1un5TBEeVpp+hax7gHfudKutvPZA9L9Fu8oEoLI95gyv/qv3rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcJgnYk6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283645; x=1784819645;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kPISuOmRiA2dL5KhertDdUTZYSCTAXJHslj0JR3wCtE=;
  b=mcJgnYk60vuIxUnGVhCryZxeRTiAY77jE9prMKbUi2sKWcPqSs5IXi8r
   y0K41BjokbflfwNw9OUDBnvGfGAjowtFzBYfrEb1dh1FSbonD+q0tnSFl
   3G9ro59VJhzp0TpOlIq6uRbajrwkUuqnBLKqPIcMr4YxiPEE+ELHKxQOa
   RO/pg4W9xlSGGP/rvgN/UevRH6/2f//q5vFNAh/Z6zLwUnFTjVIrkdFhB
   Z5GT2MQQdG3V49lDDMeP5V7+PJyo4AEs0oT3Hm656b7ZCI1ULmsI2ELT7
   lpcNXMkX5A6dxOjgVxFlelBiBX4LYYgQK0WEIHTJgQNZeJ+HNsOoP/EYq
   A==;
X-CSE-ConnectionGUID: SbOX5Xu4TTuh9OydYyNGpw==
X-CSE-MsgGUID: 43vU6j/RS2yZivOKW+5AFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55450071"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55450071"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:14:03 -0700
X-CSE-ConnectionGUID: rVQ1HXzuRLCnvxx+3maEnw==
X-CSE-MsgGUID: +43csPV0QeKzFiXunTo48g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="165039521"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:14:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:14:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:14:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXFBau0cZCCr7iHqb/zjfMZ6F4OiRdW4AwG5bLXuJn4H+kNYBX9TKBK/xyPN0Zyr1ngGBIj/KP2LS8ngioWvCAfyp1Bxw49KtG/Gt0ObnV42C3Ki/86pc4KQTsU92ftaBh9ONeuplWtMS5fe+TbaMbXdNADZHhoyHz0mVwH+PKdMRPgQkiA47KCE8cpic2M/BYCkqAsbae0yhBGxDJb5yhxFSkDNqulR6o5gXS/Kd9NQyhunJG2OliZ3lM7zErz/7A7Li1poNnlRtZRu9stA6qOTVwPfzjC5Nd24wppdvW0VKuu03TmvEJDPEgAEDNogAj5FBv4jnJFaGdealr1iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFakZWawXwau7hqGw2ESnAr8N7LfuVo/VncaFAAHiJ4=;
 b=nb13f+fmAC4T762gxBOCipU3CorfY+FKxLWfyW6WmxclI0AZ11k2sF0jIbhIIo77QDuaMdnX1uAEgRx1YHzF55z/RYkkew1SWLOWoACZ52ujk4tudsyUAtma94VCdUSoAKOXlba5839YsraB9T3qFGGKbyjsA+QBBtj3JfkJYMzKmBpaWRchtSmMZgoZEbrsjaUFzU3WoJMRuJQXXQeZHA7kcTDcl2U6CbxZEt+uV4G4M89/s4yi5l72rdJ/HidW9fl17bivzaPYF4YWu9Azc8Uimh+RKi6Uk5EAMhx89Hoz+CJbQnzyUBy9Q1KEGvYxc097XVhT8viHTnIpP1BM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by PH3PPF2B89F77E0.namprd11.prod.outlook.com (2603:10b6:518:1::d11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 15:13:58 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:13:58 +0000
Date: Wed, 23 Jul 2025 17:13:07 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Kirill A. Shutemov" <kas@kernel.org>, Alexander
 Potapenko <glider@google.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Sai Praneeth
	<sai.praneeth.prakhya@intel.com>, "Jethro Beekman" <jethro@fortanix.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, "Sean Christopherson"
	<seanjc@google.com>, Tony Luck <tony.luck@intel.com>, "Fenghua Yu"
	<fenghua.yu@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook
	<kees@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Yu-cheng Yu
	<yu-cheng.yu@intel.com>, <stable@vger.kernel.org>, Borislav Petkov
	<bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <xfshxftto4al2syvtrmbqbswlussduvncodyowjwfcvi23v45e@sy4e4hckbf7a>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local>
X-ClientProxiedBy: LO4P123CA0172.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::15) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|PH3PPF2B89F77E0:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7fdd5d-950f-4093-9c6c-08ddc9fb8bfc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5okipkmORiMNhfD1hq5LfzN4rLhundZDwmUgHa2Lcqe8hqdBQN+lZnAshI?=
 =?iso-8859-1?Q?WHkPO2GTXLHDVhOmxFvwImOezoMkNIWDj5VTRCWXD7FbXiIvvx1UTvnD38?=
 =?iso-8859-1?Q?x7Kk643uc4ZOd9/r95hLGJCf/6Og9nbKI6FYrSngAObLQ6P7if6pVb+3+f?=
 =?iso-8859-1?Q?lulvvuqGOT2RoJKS14yMqOjYdE6Cz2VAq/9GBxyuOzvS0dzobqHjF3b016?=
 =?iso-8859-1?Q?eQ98mjhDU1JLzYu/gRDmArwnKwyFwQMMtwU71kyyijx8HOONiFNbPb8sZo?=
 =?iso-8859-1?Q?o5FcntMnedz34GGnWZ6aZBpq6JuruoqIvnA8FRVl/ZJ83KPZLOIsJZPVTd?=
 =?iso-8859-1?Q?Tqx5Ii5RzxweVi+/zHQMToJgEQMf52NQ8Af9Y8cuB9F5DNUIjP1yH3fbze?=
 =?iso-8859-1?Q?brLiiDju8ApM+92pMDGG+xRKuphSZIyT/mGIm8IHxrjxTwI0LeU6sBLe0f?=
 =?iso-8859-1?Q?rJ1rLi1+NKAeaNXy2HB8vZvUzy09CFilwr7F/AXbs8ODafss7wAHHd0WdU?=
 =?iso-8859-1?Q?xkOV/9yIPKuA2aeKjL4uvwihH8gTShgubfhXKl8Zu8cn891JepxEv6pvpr?=
 =?iso-8859-1?Q?dgdtqazacxulWF7d5nG7Xri7MyYn5LdLHJSexZgl1kI+pbrN3WvBn+lDC2?=
 =?iso-8859-1?Q?tMBAM5xu0JHkDLN+8F7D7w2yfKlxpT29LUfXXPHJ6LMQqDCzmhF4ZpDuHw?=
 =?iso-8859-1?Q?jBLfP9eySgO5jZjuB+qh6Ug6Ocws6yIOziGuDMnXHzhEpPUWc/rpT44pAC?=
 =?iso-8859-1?Q?ZLHM68D9i5n7d2MldGN22MgEzsu0JaEJohO7Cg3YlvI1n4QTQWrHt1tLyO?=
 =?iso-8859-1?Q?vPvbGEd2sW5ER+7wm6F4nhZBRuRYRo9h8vLTLSxoaZpi1ajpTR85okjGHF?=
 =?iso-8859-1?Q?E56QnbKoiFwecqCRumRGeytQakjBlQ21fZ2s5DcIBZxyquOJfdd1iZDjVG?=
 =?iso-8859-1?Q?8PXWKaKNywnUsTr3htj+u8fbS01nXnkTJ5CtgT0itoaUIeEHkf50Hrf9Gc?=
 =?iso-8859-1?Q?B3PpK2NMo4+YfIVH5jTDa80Gkb/5a5A25UOSPB2o+Qn0y9DtjoIbXhg4Ll?=
 =?iso-8859-1?Q?0sX3kbLXt0rwDwmgP6c6+2NvKhZfUEVtSACSZRlIEYxL4QPXNSlDdRaPdo?=
 =?iso-8859-1?Q?n0kIzxiFp1U5WbIGGYfm6cMh6Z8COuZwvs5I5SMlMCuYTfhmlybmL/8a6x?=
 =?iso-8859-1?Q?0M6Ww0uQMbrev+M37rGiQ+25lmGdE928i6SQ+0iT+hcbAcC4IszNz6quGQ?=
 =?iso-8859-1?Q?RdTaifcmPI+c+GaaMcqLp3pnepw/lpWsMDtwvn+BrOCfNKaiIV2+HNUEZp?=
 =?iso-8859-1?Q?cbbwrT/smORpP+QhXQZ86POc/eB/IHJMXDHM4zBUILO4zv1RWh8reJVoRz?=
 =?iso-8859-1?Q?O4lcmtHqzwdIbrsPeXdMeJskvAvaHTmSXnC7ztCmy84oxdbZx05QPUX2cQ?=
 =?iso-8859-1?Q?wHO62wQIXoaTq6V4AN2XQ1CH4VARmvCtPFXySCZG9Zy3BekZJrEHqnYjdZ?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LAWpOf0TrlO5RAcROV7thq36GqNc4y+WJEUk6FLNTCLIhjjb/xXO3FiGZ/?=
 =?iso-8859-1?Q?BFxz5o4rMhbjCSWo+rEU3mxCz+vJWlnkc5MtD4EZMTi3FNNhHyTgzZxggc?=
 =?iso-8859-1?Q?9XiQMuoeCGWBu8E7vBNMcB+1aBifvHgtWCo3hOBBLvf2HdeLIZ8+GzS73f?=
 =?iso-8859-1?Q?tUxqVj51ZcDH6MfqgthRPQg5nJgqG1l4dAyANDa461oidYhLZGPh0DTKW2?=
 =?iso-8859-1?Q?0UUAmUH5t1DY2KBl7oJZm3rtPirZer48LF5GwxonASxi7hs+/XNslzABFA?=
 =?iso-8859-1?Q?JUBQos6XqeJ/bErFTIYzw5SrechhmZuAKcfhQnPQA1iX1+CsdFpDCVvA2Q?=
 =?iso-8859-1?Q?UMMT43c3VtSJoFkudx8RyrC2AFEtJ9/LBiXAZ8T/GP2NFdoQuiEF91vE6I?=
 =?iso-8859-1?Q?oKJ9FlMw+Woq9+BDkKQZlxeh0I9q+SJyl3AU2fsBokro4+0Ot8Kf49Iq32?=
 =?iso-8859-1?Q?4d7QQjZpg8C9TI2vmCnR7PVXDcZy43X1bU44Wsq5c1mF48LcmOYNYVWG9x?=
 =?iso-8859-1?Q?Fx99AfYIlZ1iKbKzOiwE24yJXsGkQsAcVxUDMXd4yWWsUs00ccBKNYMrJ+?=
 =?iso-8859-1?Q?lH4O2RXVy23uqDVRM1jVSFNANN8p5dVVT0thf1v2aXHGlx8h12fHdONd4w?=
 =?iso-8859-1?Q?uPjppZXZFtVAmJJDcLUGofOXWhfDGxhCF1pL1rKck+AEigBKsgz2107APb?=
 =?iso-8859-1?Q?r9QMNstS110FGA740ZBg30gi1UmS8ih7kdMXy17go6ArIysdXCXdHOtl5c?=
 =?iso-8859-1?Q?C1XvBjtiRn++1rngz7cFwjf6sh93/HxIVKpT2IX9+IgmUgGdKEEU0yB5Vc?=
 =?iso-8859-1?Q?83IfGU/iBG3Kr/GU94noBjiMdCUVI8W19icqsfQ0fWO1+Ecy9MXWfUQ9Ia?=
 =?iso-8859-1?Q?ITchJtBkVWa1g+oo/SlsUvVPH3Djbj8crkQiizD9KplUNVGgIhRUvgJFSz?=
 =?iso-8859-1?Q?1o9LH3dOJT/XLWQIVtoXBBgBbu5WGiNRy+fZxOpZ16FMObvEI6aRPw5Mtp?=
 =?iso-8859-1?Q?XDci2G1KTrCWeboqErm74L0F6vvCSk5HUQ2lzmJJHk36K4kuX9a0m+CJHP?=
 =?iso-8859-1?Q?hdQTRFYzatQAo4p6b6EkT7PP9Lpxs/FlQfFkRLubLBxzuGmwyDNLRtVB8d?=
 =?iso-8859-1?Q?wmVoCGBYkdjLUu6PycK3ymMFZAAp+5KlgNUZrtaJVwIkzUoWgT33UoCXpk?=
 =?iso-8859-1?Q?fqlyy2jGdXhFV60YfjsMVKVzPoxaCaJi6G2AJwkshX/H1uy+naJJKSJ6lq?=
 =?iso-8859-1?Q?E5U7VI3PGUrKf+KJT1VkiWUWHt9Sqe34A2FflcwSejQF5vdjAZIh6JWT4j?=
 =?iso-8859-1?Q?k4X/SRxJV8joK3WID+s6f0pmV4HrU3fmN14F4uZfKahe/cDuVSoezuOwxJ?=
 =?iso-8859-1?Q?zGysERWe1czSRxmuN83p5gIDgnEI75Doy+J3ho9DmKf5s80DTQwaUNsyhV?=
 =?iso-8859-1?Q?71bqPbMDcOjqUseqju8BQyHsWDArlEuDVntJQwQOhRbB+CcUT9Ui+Tbevt?=
 =?iso-8859-1?Q?7qBryoNm3hYFED4MPPfTO+Bbc07ILq5u0xjlM6R3UnsWo5i9VkbBz0FbPv?=
 =?iso-8859-1?Q?2aEQFuEx0pIch1oMM+FS9ZxEQhsjIXhMfnI6BHC3KRwHaTRv8yh6nz/man?=
 =?iso-8859-1?Q?hTdd1CzWA22nRnX1ZP6q/FWMNpORPTh97a8+txrbDKviZ686oKakeFnQoH?=
 =?iso-8859-1?Q?kr4j+516nmRRdz798NI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7fdd5d-950f-4093-9c6c-08ddc9fb8bfc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:13:58.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8P9Ck3va89MXVPdo23BXxMr7gSLKK/ehZB/7K0sK1mKnMvNvo0CQSFs0vfkaGaXjLy+AfT3nP4VAAGxhAtegBbL10ZeKrrFJ7v53GbA5FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2B89F77E0
X-OriginatorOrg: intel.com

On 2025-07-23 at 15:46:40 +0200, Borislav Petkov wrote:
>On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < NCAPINTS; i++) {
>> +		cpu_caps_set[i] = REQUIRED_MASK(i);
>> +		cpu_caps_cleared[i] = DISABLED_MASK(i);
>> +	}
>> +}
>
>There's already apply_forced_caps(). Not another cap massaging function
>please. Add that stuff there.

I'll try that, but can't it overwrite some things? apply_forced_caps() is called
three times and cpu_caps_set/cleared are modified in between from what I can
see. init_cpu_cap() was supposed to only initialize these arrays.

>
>As to what the Fixes: tag should be - it should not have any Fixes: tag
>because AFAICT, this has always been this way. So this fix should be
>backported everywhere.

I found that in 5.9-rc1 the documentation for how /proc/cpuinfo should work was
merged [1]. I understand that from that point on, while one can't rely on a
feature's absence, it's a reliable convention that if a flag is present, then
the feature is working. So from 5.9 on, it seems like a bug when these features
show up as working while they're not due to not being compiled.

[1] ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")

>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

-- 
Kind regards
Maciej Wieczór-Retman

