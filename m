Return-Path: <stable+bounces-164604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A08B10A84
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D171C817C4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E962D3752;
	Thu, 24 Jul 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN1I0B+u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BE2D3759;
	Thu, 24 Jul 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361041; cv=fail; b=dGBePP6QKToFCQ0xm5Ko/ZFu5E1NXhDoqpWpsTYyLmU9FkUIPRYY67r5hd/yR+0Xr5U9XXUGIIkR4oOqwmwhMf2AvB/zYu+8mrjBc0LHwyU78afIwSmJUVGFcWZGgbbpMATy+xM5Z2dOTJ+m5ibKKR71RTPBtZFYKuif/jgE0yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361041; c=relaxed/simple;
	bh=BbhvaT4v6qEEtO6yoUBYMxO4ki626EIJ09FYrckT/sU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZN7WObh7+R/wHgqb81exf95Vm/mEVks0tNIZRMSXU7Chpi4l4jt37FKcnRRyjWvMbybATzwvHEhGf6VxEagHjpUaT01wQ63gLTwW/qntO5DMW29uV8Cu0R4udPqMaid0GN6fJ6PYkZYTJd7EOUz7Pofr1ufjowKCOw8YiTGDIKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN1I0B+u; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753361040; x=1784897040;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BbhvaT4v6qEEtO6yoUBYMxO4ki626EIJ09FYrckT/sU=;
  b=GN1I0B+ui6hmr7a3o6hswlJTOOx6JTWV7bt+Njr0mAB5j+cNiV0zLvbq
   nI539CUXZPQkSyfWuJ5C9Fent324FcOoWgVTYGuO/6HZWPUZxiKtBLTE9
   g/RCbVcwRg0K5olPUYaVZLxusqw3an/YzCgQfc7W2INjTz80xdKZLQ6QA
   GDClPYLpHEu4necRZhKcVfJWBCQtYN7kE7AcKGfm4YcrFocfihxZi8bDe
   wtCLZ1GTptpO55oVLNloCMYKw30gh3JdjEguyLyyBWXuxqdhVoKr9skRe
   2oMUl59hHkbqOec/5wzB9oY0NJcOKOSpxuCahIFF1cXqMiH8pQeQfHLjt
   Q==;
X-CSE-ConnectionGUID: Qec/x0dVQRSgMw7l7DzArQ==
X-CSE-MsgGUID: Hk1CHSRoS9KJThLMFRyyRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67107352"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67107352"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:43:59 -0700
X-CSE-ConnectionGUID: ncfsjaI8T++PSiYVssrzBg==
X-CSE-MsgGUID: vewgQcCoRn6WQcfewKdZxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160314648"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:43:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 05:43:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 05:43:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 05:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHIaMJzWsjv4oUbab+koIv2I99qYbZQBO4fkeISVbHgjmlCLaOCJ3E0lHSmm9dmNfKBBIEN9SdHATFWEvcod7WtWzW+mU5znYWQAHlgcE87j7J9LQTAOgXyLwRUENx2KPEYClc+y51qcqWIxRunGE5ZlMhONuingWssHtQWJxRiH+nM0geDWx/Fwx8KlvStbMR2X7P8NFPdYRGTfYgS76bnxFZm5R4DMF0ESPVmZtvkedVtGHfKOnHwU5+ipNw2UVCX0Av1ujkZhZbYbSQQTs/0oUVIOpBHhl1RvTw8uSGGAFX3WBU/W23WllJcPZJL+DrTZ4ODwVlGb0VMeXLR9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwQGUfr6da989/3MqQKIeXAqk7RLzXBNmi4QRt6gNmQ=;
 b=wzvJGlRmxvS1gCu+kHxUmtBwEzXsy6GgQDvoneoPHoNTR8ecMb56i05JA4+17BoyC9u27UI/+9+ZcsDQF2hf7VDiB0gJC72lseyFMp+Dyb0ccCBIjcAAa7fWBU8X6ZGpS6pzvgt192U+LC1vYfNpR3XPePR712X8eG1T2cLrXLKMz5e69yZlnxf2OBCJWDpdpQYiM7DT6CCQjdir0Fu49zYqVZ705Aci3e2riYdKYs5WQ04Vh2XvSNMvJ6dh3MyCl0cXEMsse6rEOynEJ58ZFwlHmYCLCfOaWK3gc5+KdY3PXRMEzWC96oZ6zpHMtP2OLdaCsjJtW+0zYlPIbwtnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by SJ2PR11MB8321.namprd11.prod.outlook.com (2603:10b6:a03:546::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 12:43:56 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 12:43:56 +0000
Date: Thu, 24 Jul 2025 14:43:49 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Greg KH <greg@kroah.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>, <xin3.li@intel.com>, Farrah Chen
	<farrah.chen@intel.com>, <stable@vger.kernel.org>, Borislav Petkov
	<bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3] x86: Clear feature bits disabled at
 compile-time
Message-ID: <sjyqxudrd7scajhdq3u6kj2r5z2de4e6taju7e5fnas4lb7tad@uava65acipk2>
References: <20250724104539.2416468-1-maciej.wieczor-retman@intel.com>
 <2025072440-prepaid-resilient-9603@gregkh>
 <3byjofiuvo65bpw6rahw2ncn5qu7gskip5cysvil7yksigaqtp@ukknbspddcsg>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3byjofiuvo65bpw6rahw2ncn5qu7gskip5cysvil7yksigaqtp@ukknbspddcsg>
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|SJ2PR11MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ac3044-a6c2-4cea-453a-08ddcaafc0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+PZCKf01AEW2s8S8uQRaM0od3eH7VoKu+B9kXoPSrWKLkTNNzmg/uJ+2ux?=
 =?iso-8859-1?Q?zFacejI1KQfm3QlVcjEwiYn0A+Wjn4eCiBcJCWefrYsikzQchz6+81joQI?=
 =?iso-8859-1?Q?hbA0pm8fANx4m5hYoLNYzrseqok5ZirjeNUR1FeOO7BcyAnHJQrG3p5CbQ?=
 =?iso-8859-1?Q?GswmKHvB7yjG5SlnXRQzvj7scF9PBTl5J+QoIsklzr5lzmeil+iIN+0oZs?=
 =?iso-8859-1?Q?4hKEf5+X9X43NzzYVuHNaWuT8uvVR2FekQlWfn4dOMb3iDFznPTuJo/Wa/?=
 =?iso-8859-1?Q?Yantruq/Wf7bQrCStmF9sST7Uug7DjLLtWASxWfbOWq3VscwapU/36zQ3O?=
 =?iso-8859-1?Q?uQLiaq/w4nIQ17oEAq8e9tr6KD2J6/u0iS3DuxqBmnJ0g4x/+3NBQZSpSj?=
 =?iso-8859-1?Q?D58uNXoEAb3MRwFrQKOenNjok7Vo8je8snMcKxw8Zlwka/h1eNOq4QZpzk?=
 =?iso-8859-1?Q?1Qrq8UTEqBIr8sr0XjFxwubj2HTXCUkEBJpVyBwUx3fNwhknrX8AmrwD6c?=
 =?iso-8859-1?Q?VrpuaYXu4i7LUWsA/JLuKm/00rXqGSl4JignopzePBODpWp5URoxsrU4Ol?=
 =?iso-8859-1?Q?OBgWMtv1rCJFSSs6dboGmsblRaUdau+vXrAncw92BT99EMfbtkVpSqqHVx?=
 =?iso-8859-1?Q?ZIxUufJ/eIIEUydcFpOXlmX7/Cya9a6rlD5DxyibKURA8QAK9Q3QheQQPU?=
 =?iso-8859-1?Q?jMVziLuaMWErijoRojV29DXGY2BlePVMBsH+Ezf9czrKE0jGKAUT3rZrr7?=
 =?iso-8859-1?Q?JNgDK+7fwJyOIlWX+hUBabkOMQKnij8Zu6tSGHPS1whKARtItTBJG4uIb5?=
 =?iso-8859-1?Q?zC1rl2kiNHmODVBpf5WDsU8iZm9ofEnEBYgNoKDR9KO7vnP3Iu6Fy11tLt?=
 =?iso-8859-1?Q?KH+9O8c18eh+Cxya2GdDwu0wtJZMyOITgIZ4TxOnTLfyYzPjNgGMAQt1Qd?=
 =?iso-8859-1?Q?iPP3DhWN8vyvHdMrdXbEYz7p/dfwqfdJw7GxxYSJKp0m/8wnkPSUuj/ebw?=
 =?iso-8859-1?Q?vCTRZO94USmWxIhh74Q2iBpSk1pkgK8Rp78cKQAeOG8weDj7T7gUMK2LXD?=
 =?iso-8859-1?Q?V9oWEgfYclLjvUO/nbE935ZiwcWRPA8sz8iMfzbChpkJ6jkpaahi02UO0z?=
 =?iso-8859-1?Q?k1y4p3Kr6P7BzF7s9AZYyvYRlfUfnfOn5qLsyJjDHBHsOkNi1m6Px/+zcu?=
 =?iso-8859-1?Q?NJsqdtYzeaRNxQ82tu6w9Q2jHIXX9js3U7T6m5DoWXomfjOtQ8tWk/sJFW?=
 =?iso-8859-1?Q?NhYV/r7dMwTdYddZfcwND3DiC/fNMkXc2rR8CW1nYOge7AOqUNH65572OU?=
 =?iso-8859-1?Q?QSlXITcv9xigW34Lv7ML5bqVj3zoed55AV67QAbLu6FC+rD77na2eu8BTH?=
 =?iso-8859-1?Q?Deq59YD7Dvl76sHgjZbXIWAky0rRA75feOVGaLm9CsQ1jKVr6nVGyMJOft?=
 =?iso-8859-1?Q?lmvSmO78T+mzSRh5UpjhxyV+JUTliPVLfl5Hxshjxzwr13NbnD+2Jl/ed4?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6grd5qlzeArkpsUNfJNpY/gvi8E8l9UgLKFs2QwAl4DJCcQ2M/E2r5vIj+?=
 =?iso-8859-1?Q?Ex5MIfxo+uYUsv+pxfTwvbTfZpn0lASW311DVkpYl0ixTDoBSJ6hffZHIu?=
 =?iso-8859-1?Q?3dPGG/ZeTNdZBQWG8ruHgnResettkbFy50aSulNjI6VysIo1+hm1QrRAzw?=
 =?iso-8859-1?Q?9FbalJtF+LhTV7Br2fqm+JRKRvAB402Ear6KhfR6W7S4e8K3OYi7FGxptC?=
 =?iso-8859-1?Q?Y+6KBdtJ28wvhCnWZ2GJLJLzPHPTss5FECXK9QD3v9LPgIYMDWfquiUzVv?=
 =?iso-8859-1?Q?KZ4/8S9VyfOB72boaPI9OtFMnKvfYx0E4Zs+W+X1oqan9sTdj3vXkq92SD?=
 =?iso-8859-1?Q?eM/52rl6dDUr3BJgpU3zURS5n8aYyHeUcfGJRt//PvytbGcBbVDqBKtGkM?=
 =?iso-8859-1?Q?WDzKtGkcp0MumU/nz6N7dAPnUgWu3utDcwpQmrVs6mDAFnSManGkvd06al?=
 =?iso-8859-1?Q?+xoz6+rckiTqVIwkPBsDtshK9MWLwyBOd+v/3cMKxeoEWqh3vGfaQq/q3D?=
 =?iso-8859-1?Q?19xujk/NJsUwH9NQoOLnhaTxOwECjaw2BCCZAieTFJ6Syp+lHm0+RLVjXP?=
 =?iso-8859-1?Q?Ejp/fcH/Gvlg5LPtaIWbYUaTT88a5SJ6mgJIKf4M9B0SomdtJoTSIMBDhS?=
 =?iso-8859-1?Q?AzrRXshQNoPXIAGBYNXFnCJTq0d7x6O3+CWCIKSwZLdwut9FHAkvkF2L/t?=
 =?iso-8859-1?Q?d2FGkF4WEvjDlG3+KvUhbmfNkz6inV1L2Eq1yI4uv9x+pZ7IhN1s0BjsBS?=
 =?iso-8859-1?Q?YEmCAjlpY+Q0IgHZBiEOr2g/DqlBc6PrbpXHRUv6kUZd6n/CQpiaB666xV?=
 =?iso-8859-1?Q?3yBFCnUlbWEWgUsJG/MJr6z3shBgapyBKRpMuwaIRefFZ1RKOzeo3HSUCA?=
 =?iso-8859-1?Q?LXBPpwSUpZdAEOcBcttaOnGWeLLY3FDlB7dmREBvpjT+22CR7aPifAHIwy?=
 =?iso-8859-1?Q?KoroOWLJmJGZwOFRTSBOqnca4miTDCMUXf1ZuqC5VcRzSTYCWyz3ebWoMk?=
 =?iso-8859-1?Q?QD9V4VIMDhB1bAQ9H1TDf+dhkwIBDMcY8CSA8JJ1h7Tu4Zobm7HlHsTzQv?=
 =?iso-8859-1?Q?Q5oI4ncdqNVc3dGblsqEndyMMV+GywvUu6R+d54BJZ9xOEhawUXL6VsiRo?=
 =?iso-8859-1?Q?9gU0VzovyEM9li4sohnQmqdWB6J6p5ulTNL0zyL3ghrqmkJdCkQxQ04vLa?=
 =?iso-8859-1?Q?mZLnm3VEHmxIktNqRwrlME18etLzAOjDtynENpEr+7hSve+RVq/6ij8wTF?=
 =?iso-8859-1?Q?x/enfcuR0EGbwoM4S6KC4DIub+A19jCD9pcAeA9/VcR9A/P1ltwFcsbm2w?=
 =?iso-8859-1?Q?oAYveHdEZLM+oJ3giPFsr3uPDnHctkt0GZpw7I67W5weC51wM4W8WtQhHl?=
 =?iso-8859-1?Q?ob6F5+kAOsac9aDQ4ALQ9hu+qKGiWhyQAqh0NgoV/d8YTn/kkfk9+jwhAE?=
 =?iso-8859-1?Q?FS1V+cvDIDe+hRnWsmlJL+ajIvhoEJU/pW6xNzSFj+1DNZH+5QAHiLxOnQ?=
 =?iso-8859-1?Q?Fov7uNRB895vgk2SGmuhjv0YlYsFGZ5r9XNLGYL/s1gg1VnSkh3F4vWFDx?=
 =?iso-8859-1?Q?EUc4J+xqf/Y97/ivk+v8X7pnfoMsvdBlLgJB7JaoWA7pGZNibj8cA20+DR?=
 =?iso-8859-1?Q?iFg3xEpJYbOsaZoGtq7BudjdjNqYU87UzwFMjvUExEwMwbg2eJxK0Ns5Cs?=
 =?iso-8859-1?Q?qM8XFku8kfScgHKUais=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ac3044-a6c2-4cea-453a-08ddcaafc0d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 12:43:56.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnRr0hRD6abof7fUp7rECwX00Uxw752Zpw5tbBcg9mjJ/SZY4FXmNhjhIkgr3K1OgPLHbulaTLb7fYNNx1gNpBf/B12bOuy3MZUL/23O5gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8321
X-OriginatorOrg: intel.com

On 2025-07-24 at 14:41:27 +0200, Maciej Wieczor-Retman wrote:
>On 2025-07-24 at 13:34:44 +0200, Greg KH wrote:
>>Your reply-to is messed up :(
>>
>>On Thu, Jul 24, 2025 at 12:45:35PM +0200, Maciej Wieczor-Retman wrote:
>>> If some config options are disabled during compile time, they still are
>>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>>> this_cpu_has().
>>> 
>>> The features are also visible in /proc/cpuinfo even though they are not
>>> enabled - which is contrary to what the documentation states about the
>>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>>> 
>>> Add a DISABLED_MASK_INITIALIZER macro that creates an initializer list
>>> filled with DISABLED_MASKx bitmasks.
>>> 
>>> Initialize the cpu_caps_cleared array with the autogenerated disabled
>>> bitmask.
>>> 
>>> Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> Resend:
>>> - Fix macro name to match with the patch message.
>>
>>That's a v4, not a RESEND.
>>
>>Doesn't Intel have a "Here is how to submit a patch to the kernel"
>>training program you have to go through?
>>
>>confused,
>>
>>greg k-h
>
>The way I did it used to work for me previously, I'm not sure why it didn't this
>time.

I meant the reply-to being messed up used to work, this indeed should have been
v4, I'll submit it properly.

-- 
Kind regards
Maciej Wieczór-Retman

