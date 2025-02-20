Return-Path: <stable+bounces-118532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50594A3E8ED
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0284119C5FA0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D81F1934;
	Thu, 20 Feb 2025 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgVCbHld"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A11DED6F
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095487; cv=fail; b=tugxnzY9Qs8DsjHEY9Qs+NCSL5cfSXsSlGlxFRHzyusWTT6NfsPa02ZBxQyua+DDp57cCnAbxz1gV2EGi5ipG2mxe/de/hZicw2Ij5Qupyr9Vhh9GH+S7xthSMbzkoNxXHY0yI1neSaGDrzxrX7Mr5PoWOE7K3V+ZkgfkK4VeU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095487; c=relaxed/simple;
	bh=EJzwzWG7p2Axku7VOE3NhAWjY/Sf7B2M23sztmz80Nc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2ItsjZP3tpJEkBV9mqiE2HFwWsdr7qEGbBisqyzXiJL3bZiJWR3obvbo7PsnC3SyPH/bb3Pmiwej5QNE0sNN7AAw1TZgB1ErGD0/iqwANNGZhUBA8Omymo6XXi5WhiLs7Ryh4SXRlVCiRvr+aT7DnGTo1UILq4VY72qS+t0fn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgVCbHld; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740095485; x=1771631485;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EJzwzWG7p2Axku7VOE3NhAWjY/Sf7B2M23sztmz80Nc=;
  b=NgVCbHld1wC9luFyMYnlJoJHwmQ19MPiOIAHIdLMqwnm6btKVacoaBf/
   jCldkVdmsvglwpNB+wMfN+Ftjc1EfQWHMFn83jpdzt5uOgfCjY9vtsbNN
   XDkcGCXCyIJnYc0efyyiUO+pXZ5TcZiCaeqd19dzzkqyZ8wZdQCteewwc
   OjF7sk/3J+fDcNiVNOE8WPmOF9ZP09tjbj6z1hV8sdkkAdoOnVa2gAlIS
   9o4V6V9Y0DXQTH6IawGEdsJisjjUKCI8cz2rSKJfaBQDT1YNuEulOvvhx
   uF87fegJbN8aomxQmmVhEvnLPWl5JrTTTQAD1efKSSuzuOuoUNxxBZFDn
   w==;
X-CSE-ConnectionGUID: kWH39jzmR9eqsyTcK2p19g==
X-CSE-MsgGUID: RZJNwZUDRKa5DcYpaqe6VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41163139"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="41163139"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:51:21 -0800
X-CSE-ConnectionGUID: qIsSwP6FQFejjwp6WmsLKg==
X-CSE-MsgGUID: X/L3PnvjRlKezHD8IbB0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152390387"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 15:51:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 15:51:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 15:51:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 15:51:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOIlAp2n5y7I/0IT4gkkxD/r9Di1TZXp3UjCBEST9coe9mB8pTTdjys+ZMWgnwXfCJTzhsKELj4wcnoz47guizKVi22JyRczPup1K/frQQTKMvIWiwH+XihlvRhZ8DvkppR9f/IAbeu2Cb7hEuIy6Fhl8Cx+djChbbp9TV6soWI7YP6lz35oDwleDiYCckjcasahr4cwv1yBYJ8NAbWKRl3m3tR5Yye47tcAkEgnH9JR5U9g0IMK8Q6zOXG2yNa7/KR9ccxLlre75lr2fleDWQPnah+mrvMKThIRMQjCvA3qNaPkcnLyk2DZ6VmX6X5yraraM8Qjy1BanH3kXxHihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abATYancZHOaDC2XQLyUccqBVE0g9iNXn/F57bNeImY=;
 b=HxhZ/RQbHfikw5zghMFE60j6kzQOqRcvZRKKVMLEr/lutyqTaobSewXJ0DXgO5BjKjg4lK4EB6FYA3jXOAN6kfNcBlt/lvtP4juN7d4Qslit2KcPEmRr7BPGvLmVOKd3hTDjTVGZFOozDpLGcPnt1vhrhfhRWrCxHn8t7TKYHQBU7A+yJAjgWgwSi6cRM6r83Zf1cRC9V4MHUVNgMLh54QYNyWUJU8Noh22+sGwqti934oPjAgB5vHVVR/MndPLG7nGzVdC/hWRVix6EiPgBeu1GeXHaPynjSKd1aYBMNs7yEoCo01UwCNi58H7OstfLlGzBVyOuVgPuffZJTXlWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 23:50:59 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 23:50:59 +0000
Date: Thu, 20 Feb 2025 15:52:02 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on error
Message-ID: <Z7fAIjU/3wW8eMQL@lstrano-desk.jf.intel.com>
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
 <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
 <Z7QFUy9ZyBRhPwuY@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7QFUy9ZyBRhPwuY@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 088d82b4-b265-47b2-feac-08dd52096cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nhXbL69mlrgf7e/WDh6XqLEy05wfuBoYYxGH9NRHeeo/BSg92l0fcvmQlU?=
 =?iso-8859-1?Q?JRp4F15+JQ05HiLI12WUWqWM9fVPEXJSTk9OROFkZQ1enxBGiW1Y9Ng+rc?=
 =?iso-8859-1?Q?8jTDoPdcMRMfMhEuyo28hzAn0jXz9o+E7YmNhJpiyFiBQang3yX0CB2TiJ?=
 =?iso-8859-1?Q?JeRE7fKVRyQI+8aLJBLGDVs6D37O+2RweZXvKTkcLTqx65RVIt0OcIx+g0?=
 =?iso-8859-1?Q?l1qOiXKrKim2ra0Uu1LzVnsIJTBlwhbHrj3drz89TZ3S+HdnAxnsnBtOs0?=
 =?iso-8859-1?Q?uTnqTYdas9zKTQERMDJ6enSOpLa0Hhx+IHDqTdjNfKRPLj3AO+Stt32nGe?=
 =?iso-8859-1?Q?pZrcQJJkeQ6q81ye1xUYO2xLyDWdYIxbLnTpPdhzQTlyhXur6ggZZmD4yV?=
 =?iso-8859-1?Q?7A5WN8y9twYcBRZQct7blZ30RC0p/s3EU7PKV2fsGyGIYicYYIOL3Kmx+y?=
 =?iso-8859-1?Q?L+PH7AVNFanhLZ9Up9OMo1o/zmiy2hB0uPsJqKM4EEBYxk5Kj4tQoexNxU?=
 =?iso-8859-1?Q?k6gBsAGa+fkTfk7AwhWyHGKjW0N9xmt690abVNTU/OcPDbuPWU4v9WdKK/?=
 =?iso-8859-1?Q?+WnVzwx8kQMPwKJDJBzH9WPpoB4WrJUzmHAKe2Fvg3BxzvJ9zwZNUO/DPD?=
 =?iso-8859-1?Q?tNE7uK1YMpTzDKIvp5gufL6/vZsN8SC9EvSYSeJEUccRhUGlJvSgrmMOgu?=
 =?iso-8859-1?Q?Pnm/dBQ0F/a8zJVTch5Rm/2/lIZWbCHBSXdLmxx8TaFlCpby1KyTcGlW88?=
 =?iso-8859-1?Q?LUBcXcViLcg8NnanzgILBJEC4xGT9jPpW+uzUD5x5xl4JiE+Exsj4UscIs?=
 =?iso-8859-1?Q?q080Cet37cEZKYEK6U6o0PS7EwWYAuxB2QBODDodKmbaEvQzSyPDAaUC9i?=
 =?iso-8859-1?Q?Nudo8781Ev4jb6jPJD7ipmwIjsjX8gjQENkZpz5b28di+JOzVNdvrYt/zw?=
 =?iso-8859-1?Q?p5ELdomM/V2lgugwQRTE1XBMTsjJ8d6EMIcDqpX7QFnXix32sTN3ghjeJr?=
 =?iso-8859-1?Q?QUHlDyN8wP/q+Mcwf5vCqT0ydZrc3OFMr9h5kT6144qgkHiXgmZAmyBzxF?=
 =?iso-8859-1?Q?Zm6GXNHfWRhm4wehX0wxXTRMuURAPtk45uhTQ0+oE6WUjixevH3KwcLO+G?=
 =?iso-8859-1?Q?PCEtDi4Zl8mUzMawLldtrU1tC3bNDXM0vHuh/yx6WL6iN1RJd9NdElMYE7?=
 =?iso-8859-1?Q?DY3HvzXj+5UnctxBapJz3fNnbdVUZxLOAEfPt0SgqgBBe/jqffEK9wkYXK?=
 =?iso-8859-1?Q?wk2gddGwF8YwJu8ZnpFOky0G2WHAvh4USMN45zuhvysPwqABOCk0OaFu8t?=
 =?iso-8859-1?Q?JLEJYhhlRw6Y4J8A5/L52j2BJCULxcEol2E+n9N09j4hBYtKmlbKNxLETE?=
 =?iso-8859-1?Q?iWT2xf4t57EhKdue3bD+Zb+rHhvBapDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CsguNohdMvrtzdWAGoqaOtV6O6c4rvfREgOMh1JDErukNtI6EUJNG577ra?=
 =?iso-8859-1?Q?MURa4DXbi1DsqQH74Yiuhi9rpI55iyVilu16wNkkeI36E+F/UFxu+foHqh?=
 =?iso-8859-1?Q?kNPthUfE00lvHqM2Y9vtH4IJlTZ8WzLMrsGOSg9sqhT0QbMBaeF/a9WPCV?=
 =?iso-8859-1?Q?PoQZt0O/YsfubNW8WTnfiMeggcPbBA0JC0S2ryVcd1VDsneHDYCL3oEkXD?=
 =?iso-8859-1?Q?ejT54BO+byAwvHOi1nKBKmu2shEbO6gOocLlbtIdD6gzPjj8+6vm8CobF/?=
 =?iso-8859-1?Q?ZuotLrJC5X2MeiTM6Vm/uZH7Wb50luohH95OzVAcdHCDzOO4hER4G9MB1c?=
 =?iso-8859-1?Q?ljp6r3ZwRonSGhqEg3kY0di6Am0tXi/1HmjazTJee/D/mOhmFOeO5+Zy4z?=
 =?iso-8859-1?Q?sJxj+gjtadKUvakj/3zJuIWqB9NrsHk6QPTEC9sViU1YZdSfyq2FFzNd/u?=
 =?iso-8859-1?Q?u52rji7DAjo0xSvVLAkp7iLERN9c5jwU2ReFH9zGfr7kWt+4MXx9aUlmhG?=
 =?iso-8859-1?Q?YkjOX/LlYLZB4eV/C0cVMiRTcfj98lIvFrjlGLzvGfwZiQjwCRN/B7fhqV?=
 =?iso-8859-1?Q?T4jh3QRlxbwtFpVjhogmYhwBajjruPuCtvSO1l/sdGeZMpR2dAGI8s2M5w?=
 =?iso-8859-1?Q?hnhewBdeuXXQpd+IwV/lO/2BlhsZnRgzccuBM9AFnE2qJs/thfyV0r0R9K?=
 =?iso-8859-1?Q?lT3GeJffV2WC/MOI9SzltY0mlWuqeYFCHQu3OYWc+lAyLwYF/j04jauWLS?=
 =?iso-8859-1?Q?2ENzrY3FyPWRdLlrSJ4JuZEcsQHiPas9YeyIXNsbTav5UX9PeI/xu0j0RL?=
 =?iso-8859-1?Q?K+FsPYgoF/YEifJqg5rUUSUEwWYq2Nn/uZeu0DFDeXjNvY4iTaZL7XfBpQ?=
 =?iso-8859-1?Q?tiN6SUwOYPy9MPg8IZ91jS0yLjI5iuw/uk7WnmsJqecBeOkR20Zw1fY2Ih?=
 =?iso-8859-1?Q?xulGd3fgQ38WAKMPBciTaol692e8Q3BCy/fku3Y7SM+zfbK7JWxk6Ri/1F?=
 =?iso-8859-1?Q?wGfukb1Nl2sP9FXjrzBkct2k3DJKZi5onuXzB8p85496cfzUsh2TbhSFk9?=
 =?iso-8859-1?Q?a/z/3yuCL0lT+22NPCKtxai196cGj18PV68FH3ekt1y3lC1CUumbRHWWaD?=
 =?iso-8859-1?Q?DvZnP6mW1mFpb7KvY00dD6V5Eldgg0tClQikRgKqgHfmPJ6BgFINa85Xzf?=
 =?iso-8859-1?Q?IIvx3JBEn75ZvhKarj4Ttuatj87MGBJLhg9gFnXnGqlvDlo+NDqp/mHl0O?=
 =?iso-8859-1?Q?NUQVFnVYf3kzrakZCEaOOdWCeClMfPxhh7uwhTRTOJoEjuSpaY2E9ukkoT?=
 =?iso-8859-1?Q?Kw6aWMmLI/EL/MR5GCcreWTttE8+CmhFUYoEdkVAcCQQpGcHrBYZENraYT?=
 =?iso-8859-1?Q?o8v2WdLQv00xm2xLeLN1DSwylp9XM5iAk8b2eDtA+M6r4Uy0km0yA9PSFz?=
 =?iso-8859-1?Q?PL/I2Ez9mTG3rSpZPPXL/H56ES9h7YHEkXahk9h2DacYTTEHVRTj9oaQsU?=
 =?iso-8859-1?Q?ge90D//wVEsO59gZYGdD+K3ud63/AGPk/pV3PmsrN4GL/onq4iGxyM0s/d?=
 =?iso-8859-1?Q?8jAeAI/I/WRp5J57WNrBhs1pBbc5AGVZVTxVVIeOZO+WOAJ3Plo3sUm6I7?=
 =?iso-8859-1?Q?lH0DC2BSNbZ5YnNzpZVf2cpUg+FLoNUaJ5mF/uZhsaj5yJrGRMNHLfcQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 088d82b4-b265-47b2-feac-08dd52096cfe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:50:59.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFJAF6NgdcVhBXyniSr+E0DXRjpanHcRvKpptTaPTM0Ob23Yc2PxQhz9R6hhsfk1ns8EO4Cm1BdoQiW9zobT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-OriginatorOrg: intel.com

On Mon, Feb 17, 2025 at 07:58:11PM -0800, Matthew Brost wrote:
> On Mon, Feb 17, 2025 at 09:38:26AM +0000, Matthew Auld wrote:
> > On 15/02/2025 01:28, Matthew Brost wrote:
> > > On Fri, Feb 14, 2025 at 05:05:28PM +0000, Matthew Auld wrote:
> > > > On error restore anything still on the pin_list back to the invalidation
> > > > list on error. For the actual pin, so long as the vma is tracked on
> > > > either list it should get picked up on the next pin, however it looks
> > > > possible for the vma to get nuked but still be present on this per vm
> > > > pin_list leading to corruption. An alternative might be then to instead
> > > > just remove the link when destroying the vma.
> > > > 
> > > > Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
> > > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > ---
> > > >   drivers/gpu/drm/xe/xe_vm.c | 26 +++++++++++++++++++-------
> > > >   1 file changed, 19 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > > index d664f2e418b2..668b0bde7822 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > > >   	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
> > > >   				 userptr.invalidate_link) {
> > > >   		list_del_init(&uvma->userptr.invalidate_link);
> > > > -		list_move_tail(&uvma->userptr.repin_link,
> > > > -			       &vm->userptr.repin_list);
> > > > +		list_add_tail(&uvma->userptr.repin_link,
> > > > +			      &vm->userptr.repin_list);
> > > 
> > > Why this change?
> > 
> > Just that with this patch the repin_link should now always be empty at this
> > point, I think. add should complain if that is not the case.
> > 
> 
> If it is always expected to be empty, then yea maybe add a xe_assert for
> this as the list management is pretty tricky. 
> 
> > > 
> > > >   	}
> > > >   	spin_unlock(&vm->userptr.invalidated_lock);
> > > > -	/* Pin and move to temporary list */
> > > > +	/* Pin and move to bind list */
> > > >   	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
> > > >   				 userptr.repin_link) {
> > > >   		err = xe_vma_userptr_pin_pages(uvma);
> > > > @@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > > >   			err = xe_vm_invalidate_vma(&uvma->vma);
> > > >   			xe_vm_unlock(vm);
> > > >   			if (err)
> > > > -				return err;
> > > > +				break;
> > > >   		} else {
> > > > -			if (err < 0)
> > > > -				return err;
> > > > +			if (err)
> > > > +				break;
> > > >   			list_del_init(&uvma->userptr.repin_link);
> > > >   			list_move_tail(&uvma->vma.combined_links.rebind,
> > > > @@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > > >   		}
> > > >   	}
> > > > -	return 0;
> > > > +	if (err) {
> > > > +		down_write(&vm->userptr.notifier_lock);
> > > 
> > > Can you explain why you take the notifier lock here? I don't think this
> > > required unless I'm missing something.
> > 
> > For the invalidated list, the docs say:
> > 
> > "Removing items from the list additionally requires @lock in write mode, and
> > adding items to the list requires the @userptr.notifer_lock in write mode."
> > 
> > Not sure if the docs needs to be updated here?
> > 
> 
> Oh. I believe the part of comment for 'adding items to the list
> requires the @userptr.notifer_lock in write mode' really means something
> like this:
> 
> 'When adding to @vm->userptr.invalidated in the notifier the
> @userptr.notifer_lock in write mode protects against concurrent VM binds
> from setting up newly invalidated pages.'
> 
> So with above and since this code path is in the VM bind path (i.e. we
> are not racing with other binds) I think the
> vm->userptr.invalidated_lock is sufficient. Maybe ask Thomas if he
> agrees here.
> 

After some discussion with Thomas, removing notifier lock here is safe.

However, for adding is either userptr.notifer_lock || vm->lock to also
avoid races between binds, execs, and rebind worker.

I'd like update the documentation and add a helper like this:

void xe_vma_userptr_add_invalidated(struct xe_userptr_vma *uvma)
{
       struct xe_vm *vm = xe_vma_vm(&uvma->vma);

       lockdep_assert(lock_is_held_type(&vm->lock.dep_map, 1) ||
                      lock_is_held_type(&vm->userptr.notifier_lock.dep_map, 1));

       spin_lock(&vm->userptr.invalidated_lock);
       list_move_tail(&uvma->userptr.invalidate_link,
                      &vm->userptr.invalidated);
       spin_unlock(&vm->userptr.invalidated_lock);
}

However, let's delay the helper until this series and recently post
series of mine [1] merge as both are fixes series and hoping for a clean
backport.

Matt

[1] https://patchwork.freedesktop.org/series/145198/

> Matt
> 
> > > 
> > > Matt
> > > 
> > > > +		spin_lock(&vm->userptr.invalidated_lock);
> > > > +		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
> > > > +					 userptr.repin_link) {
> > > > +			list_del_init(&uvma->userptr.repin_link);
> > > > +			list_move_tail(&uvma->userptr.invalidate_link,
> > > > +				       &vm->userptr.invalidated);
> > > > +		}
> > > > +		spin_unlock(&vm->userptr.invalidated_lock);
> > > > +		up_write(&vm->userptr.notifier_lock);
> > > > +	}
> > > > +	return err;
> > > >   }
> > > >   /**
> > > > -- 
> > > > 2.48.1
> > > > 
> > 

