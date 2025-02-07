Return-Path: <stable+bounces-114344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC2A2D109
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE0D3A3037
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76F1BD03F;
	Fri,  7 Feb 2025 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoIjDlHo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048131B040E
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968960; cv=fail; b=mxnb/FNauA0yQzmZ2Q8oVmFTxNvUyUdKP7PdCh0ce3KOsUzrdwp7rUvhRVjeZnzrPoZnXGi0OfSX/+5q1/911h9oIznrTUXAmnGGjFGvqZWK5ILLjr7MtfwX015UGTmmCYD6BJD29wDHfLAjX4X+KRCKmnx0C5SfmkXCgPQ9oQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968960; c=relaxed/simple;
	bh=jgnOaTlQ8uH06MReRO0+cQ3Njpa0GxSdvoIxjA/YVuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJyLjM939lhecT50fkGAoz54mEKq81vH+a+fQfnqin/5ZxsuIbzWwyZPs8IpGhSPGJvNicGTkHOhkAQKShaSH7T2BymOhJw6bliB846KO2ic9u59zVIGISWGklwBpaM4eJ9RshtCiEzvyDuXKG/XhgkhTpJyrNnsz3JqPgBfSBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoIjDlHo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968959; x=1770504959;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jgnOaTlQ8uH06MReRO0+cQ3Njpa0GxSdvoIxjA/YVuQ=;
  b=RoIjDlHoRYcG2mEbexf4YS/c7YuswzOicbOUqMG1XKmnG5Bup56fDN6D
   75UqOIK/Pcc4UWlehAgkfZKdglLNAPyLY5EaG7XLkTKm6Tj4YSlPF3r1n
   U4XUZBDiFdPym8yyIegD4emd6JzJADy3sGyySYYy/y5K0nNYwPJygjOa5
   7W76MGpd3NM7tPcMWp9o5uTZSslhBS6Jzz2BeSWeTFNn2Kxhzkkej8tao
   QXz5E56LS9MTnni3f1yeTFBObJtL8aCj4A1tJODm9GMrVuwXSGrewyrTv
   uDmMlOhxgZPUhiWITe4Z4Wnm+X+ULOi/ZXXIABlpKgzMUpWo/GdZbAHiF
   A==;
X-CSE-ConnectionGUID: mBEH8vBrRkStUgKPdTeriQ==
X-CSE-MsgGUID: lMWR9FGnQi+rSBD2jl8eQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43385026"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="43385026"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:55:58 -0800
X-CSE-ConnectionGUID: K9hOH1K4R0m9QPy21ixAXg==
X-CSE-MsgGUID: 2ePuyY90QgKSPx3RBlO+Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112281830"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 14:55:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 14:55:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 14:55:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 14:55:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slZsv/fmol9BLWO376WPNpjYo5BDhyGJlPebHVYebHu2w28Zdh2XBu6jtxinvwphc9JLd2dIs0cztMd5MwROTVvOSpci6SNgCf7/uj6Y495bKLVZ3FzNWYvT5OWK7pykjMbbbGLlXB8LO7oc/oTdIvxuSWCiA0yu4Al3n8524PZiurQ85JXsS5+8+MtbLJBpMzw9VH/rcgHDHZYGpz6303Mwt28Yi9j5+R0OzOkxOILkKbNwqiHvy1eHuxf6rnWIDT9R5hsQFAtuXHt8mY36tRPnalWnQN/0WxqgOyUWGQabsDyxCdfm/Mgd4miVwov8SLK1lQoeiT8W5Po0Uu92Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHpGV7lIcOJqWAUObNlz9kKHGywtMh3y1ze9i0IPJBA=;
 b=g0GjI2e7lsS3S2KkmxGzDak4S8HicEZnCCyZNLxN9Y7QZcSraExjv5Rmz+T++MG1uEvWDQ2K67E06/D8UQ9mptPSKlCpRkWik+mDRu4+xW3pB1O95b7ZtFEXwdizqDeG/O8vkxeJaSoKvKpNoaFnzIUnhUP6MUOJV1SVN4d5suCD108WLBoEoscDXBPw2UxPCXCtnXCKzRVwOjLmNjr3GJKwpnddqqR/v6ZS0c81Jnkii8/hd7iDbpwbZsBXH0s0gVyQsBK8OG3CiAa5SJFMhZgI/1/Z5ccf59jJgMQLBor3VOGTJ3aUfP2NGuqzqustInDjf3zNPtEcuL7is77fSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 22:55:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 22:55:25 +0000
Date: Fri, 7 Feb 2025 16:55:20 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nirmoy Das <nirmoy.das@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Carve out wopcm portion from the stolen memory
Message-ID: <qx2azqvhrnpyhyag73mhddkje2s5rvb74uhcnx4fcd6sr6na4l@w45ubhrjcidt>
References: <20250207164334.1393054-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207164334.1393054-1-nirmoy.das@intel.com>
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 464a7cb3-9caf-461d-5783-08dd47ca8250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Rc/AOZbG+Ueg5cPBCQBs4F8iGHOPabEQRTq2tRiFJjvKab8mfhxGq1Bi+nx?=
 =?us-ascii?Q?Ra7PUsjGujaDAeZF9YJSnZFiMzxynQJg9ad2RRsCPM7kUpFZGAXuiz5Fq9Os?=
 =?us-ascii?Q?sfpCZ+za9litdqe88BGj88HSCSBXYRMu08VdsgvYivvD37ixbpjOn8GjUfMq?=
 =?us-ascii?Q?rZHQSJfdwu+WQuKcfEoI9lWIXva7ORbKgwoL1pJeAlvFH9pFgQ63lsMh7nEz?=
 =?us-ascii?Q?W4/2QCI6Qamv0cewZfxrrSAL7CZOwZrE5qybdXXqy3sNvIh1D/H8aZd3SZXn?=
 =?us-ascii?Q?Zemsa5pxndzE3L1zuBuudkc+h3iIp7+9dnbfUbyURI3IS5BUgJ9umv9l+rFA?=
 =?us-ascii?Q?PZ/aju4VIuPDUCr9tOAoXR+Z6nhLRuDuNSGm1IvShgDVOM6CCTc8u/GI/oAB?=
 =?us-ascii?Q?IIRnZSj8ScdEvWlNRcaI8ZruR4/2kfhx6Si0/WLljDRiVep8FZTUPy49Nzij?=
 =?us-ascii?Q?GVlVQuoNwB7cznAOFhCgMc8ncY7kWs/h08nAkRyIvHgi5TwThG05k09/LYM5?=
 =?us-ascii?Q?BmkWbmbDkbEWQjZKs/oAtJLfoXl4vXUHs3S9aFBQVPy5xWWdK61Oca5hAhlu?=
 =?us-ascii?Q?8de4GJQQXivzzpmEWZ46kixH2Enjmqal2xPUAvzHE2U2DT7RMbnkHLhkvrLz?=
 =?us-ascii?Q?flJ3jh0j1muvci+bJFUbxcj6Gei6ZFus0Hy6OfTQH6kUD7vMNX4WCCxaYzbP?=
 =?us-ascii?Q?SW8iKcmUk2VflKSK8GhR8ZDVcEF/adXPgn/bciOyiZxXxgfsQWF+vU15EwMd?=
 =?us-ascii?Q?Utue7/VBvGJDDo3zW1fv1+241gDfXSPNoWFwjKDDL7xWysq3X5TVBIQ2Y23Z?=
 =?us-ascii?Q?ikbadr7daGGsLUTltEY5fSgy88+1GtN+IXzu27u5RwM75xZ7Df1k8pnW9EDg?=
 =?us-ascii?Q?xpm7r8nBdshvPp+An5dz9j4c89uUcmsyUq37Dv+6V/m1AepkbPFvlo9LvvoV?=
 =?us-ascii?Q?HDVRV2Kwp+i5hNmemb6KZh85UYMGpTh2wKcjEP/TOaDaRTKfDDo6NMAuFXNX?=
 =?us-ascii?Q?0rsO2c3th1GMf91jEG0UNMtJIWGvP/aRFSpdNTb8OvCl/Bb4qyvJGcbQxXx5?=
 =?us-ascii?Q?5SJ1Xyn2+f4PI/mosgban+hRxTXiFhoMhoXjt8SbLlgV1dQ9FGWfo5Qh9r/i?=
 =?us-ascii?Q?ZnOtzcqYU0CgRwwQfEpfkfmHZkKw4EM/ADNw0ly61ab3zvg+cvyUXZcMjX2M?=
 =?us-ascii?Q?UNRPexVxOK+whHm9b0mIYal2Ot7k9G+2FZeAgDTfASpRhU6Xypt2Bq02JD7P?=
 =?us-ascii?Q?KHh/StUnFkGZw+DtipPZE03Xi0ZSyCahW1TE1BJb3Lemaje1MOiG10YfjQKH?=
 =?us-ascii?Q?awUEOFdOFcMdtyFxpwP88jfor9ILJfFT8NltJKfPiX/3G6zwbyQhwsGjgV/3?=
 =?us-ascii?Q?ND0R6M3pTOrON8ugLpfKnUP2WEz/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkCLqDPMyh3ctWrv6hNzi/XRRqAXAOivtbln+jzD03Xjd4zKswhDldzjrS1Q?=
 =?us-ascii?Q?aFMjlaIg8TLZlY6no+R0z6mOiD37qID4hSxzQtONKv5zaAwtDFvofLsmUP+k?=
 =?us-ascii?Q?i7n4tGqunswOZwyR5COCXTO97qlddBpk+JvHWvRqR32LZ0QzdKtlB3gGwNXk?=
 =?us-ascii?Q?zwH+V72toOvBYxMxQ8NDiKIkdBW9fevh5+c5/sMlfKEew7Isxv1vpjsOjZEq?=
 =?us-ascii?Q?LqrOnBQ16U2mGwt3wwiX1EYOoQ+DiSUmDk8hpSEAU42O0LeBfTuDx4Sa3g9j?=
 =?us-ascii?Q?B7wdgzpKsEaJEH/dDIGFzVw2acAoNdglBMk+pcJ1tw3XWtwC4jdprwDwJxvJ?=
 =?us-ascii?Q?2ZTckDFQF9zIGVDO4VceXHA/liKJZQXOWplkECXgi0F8KJF5CgmK1vrVhcIi?=
 =?us-ascii?Q?rsV6UyT4myNgxPSuOWe/tl/WlmqLdxgf48296Ns1Svjd5EAhNukCKc668x0U?=
 =?us-ascii?Q?BEJBlEBcii8FWlPBJ8mjP0BKe+jlgsAtg6slKDTbEQYFwfrhUm0nFGhMjcpX?=
 =?us-ascii?Q?yXvaB3RRYnyhbjHWVe+fdQeXFgbYd/hAwl4+W7y9H7mCiJP18M0P2gQKEaoT?=
 =?us-ascii?Q?lk6SwBkwLdLhki4tG5V6B4AgWAOTMDKgbw0XBtcXZKMnWh45Y57Tc+v9HaQ+?=
 =?us-ascii?Q?3XNYZTg4+SxHQi64jq9KRSsKouI1Ft2sW7rH+p1fK9Xn91ApG3KJ6oJrIK4K?=
 =?us-ascii?Q?CietGodVcfmJLZ04DHRJsQ9XM6NSd5O8CdbvwN+BF28LpxBTv0BZisQJdLg+?=
 =?us-ascii?Q?SSrOMASzVGXhCFnd1IrGAp1Dr4IN7/IBkR+DhnAV3tI/GDy2EhXPmevOnqJi?=
 =?us-ascii?Q?16qN8HmkPn09MQLFFVVW9j0rJgb9GrnBLdDfTd4Txm/zrsUUeXELSAszNnPl?=
 =?us-ascii?Q?/jRK8+IWHT7vGgSYJ5raA6m3zZX/98uYj9+wmqRJg1yvDgsNvpKRTP1j6Ihc?=
 =?us-ascii?Q?bTdtdG6oC699x/1DYHZQXVLYOkrq19kyLa17kSAMlAqeQTEQwF9g2f3dgswy?=
 =?us-ascii?Q?v8EOEzOu/iqihgoV5tA7UHRXw8ANZqfL9kMafEmINqblgzShKO3vtZzuoojq?=
 =?us-ascii?Q?fC0SPQ4y23sJ+dDsBk5m28K2/fpWeyvXL9oYXf8le5M2GA6jRduWFg7MwZF3?=
 =?us-ascii?Q?sm81PlXUUWwdkHydoFJn0c/Nd3Np+BJuLvFV/8BU4PnQyd47XIzqgcbxxNEd?=
 =?us-ascii?Q?olTvJUdc0fri2+MhXSvcWRt9GcxdzHRXIlDKm5sbHxqQsXCbf3/nkHtiAiul?=
 =?us-ascii?Q?POeQo0EIBe5sxPRwvEhoBsZm2QCidlN4usO9otbOJEUkA8sNEuKyPBRC+53w?=
 =?us-ascii?Q?Eg8Xd+XsvWMo8NdOeVfqerrCoD8fO76f83XR7oxMv5nJ+YWFKv19RtDeIWzS?=
 =?us-ascii?Q?wQ8za/RMEvG6BdPFSrOcpMC4u7J93Bh+0iQeu9WIKAmcRmaJyjvb4W7WNHqQ?=
 =?us-ascii?Q?+TfAcvH5znYEh+UnocBZw/GDdq+PR68e3PDWozcCx9MaZG85H5DrZd67jlFz?=
 =?us-ascii?Q?Ia5kw51b50WtMIzeG+sgIk6agTQP+E4EldRb0s4VJuSnQ7geNEGCaPiABlTI?=
 =?us-ascii?Q?mefWQE0HIcw/UwqhvmqCy99MJN+qH8dVfRNCm8k5vLZAKyRByU/f0DKQb8Q2?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464a7cb3-9caf-461d-5783-08dd47ca8250
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 22:55:25.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUS/gYBN13vnY8yL0/4ufzQIwPYjb0rUHdalHD2Yo5DqeSe0k72coHKN4pfzb96O/zbq2+ZYVuBrz26OHV+T0i+cQw5P8xoyzhvzKFfAmSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com

On Fri, Feb 07, 2025 at 05:43:34PM +0100, Nirmoy Das wrote:
>Top of stolen memory is wopcm which shouldn't be accessed so remove
>that portion of memory from the stolen memory.

humn... we are already doing this for integrated. The copy & paste is
small here to deserve a refactor, but maybe mention that this is already
done for integrated and it was missed on the discrete side?

>
>Fixes: d8b52a02cb40 ("drm/xe: Implement stolen memory.")
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+

I'd rather do this 6.11+. It's not important before that as we didn't
have any platform out of force probe or close to be out of force probe.

We will most likely not be able to apply this patch on 6.8.

>Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>---
> drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c | 54 ++++++++++++++------------
> 1 file changed, 30 insertions(+), 24 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>index 423856cc18d4..d414421f8c13 100644
>--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
>@@ -57,12 +57,35 @@ bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe)
> 	return GRAPHICS_VERx100(xe) < 1270 && !IS_DGFX(xe);
> }
>
>+static u32 get_wopcm_size(struct xe_device *xe)
>+{
>+	u32 wopcm_size;
>+	u64 val;
>+
>+	val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
>+	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
>+
>+	switch (val) {
>+	case 0x5 ... 0x6:
>+		val--;
>+		fallthrough;
>+	case 0x0 ... 0x3:
>+		wopcm_size = (1U << val) * SZ_1M;
>+		break;
>+	default:
>+		WARN(1, "Missing case wopcm_size=%llx\n", val);
>+		wopcm_size = 0;
>+	}
>+
>+	return wopcm_size;
>+}

Please also mention in the commit message the code movement here, that
is done just for the function to be called by detect_bar2_dgfx()

Other than that, Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>+
> static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
> {
> 	struct xe_tile *tile = xe_device_get_root_tile(xe);
> 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
> 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>-	u64 stolen_size;
>+	u64 stolen_size, wopcm_size;
> 	u64 tile_offset;
> 	u64 tile_size;
>
>@@ -74,7 +97,13 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
> 	if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
> 		return 0;
>
>+	/* Carve out the top of DSM as it contains the reserved WOPCM region */
>+	wopcm_size = get_wopcm_size(xe);
>+	if (drm_WARN_ON(&xe->drm, !wopcm_size))
>+		return 0;
>+
> 	stolen_size = tile_size - mgr->stolen_base;
>+	stolen_size -= wopcm_size;
>
> 	/* Verify usage fits in the actual resource available */
> 	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
>@@ -89,29 +118,6 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
> 	return ALIGN_DOWN(stolen_size, SZ_1M);
> }
>
>-static u32 get_wopcm_size(struct xe_device *xe)
>-{
>-	u32 wopcm_size;
>-	u64 val;
>-
>-	val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
>-	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
>-
>-	switch (val) {
>-	case 0x5 ... 0x6:
>-		val--;
>-		fallthrough;
>-	case 0x0 ... 0x3:
>-		wopcm_size = (1U << val) * SZ_1M;
>-		break;
>-	default:
>-		WARN(1, "Missing case wopcm_size=%llx\n", val);
>-		wopcm_size = 0;
>-	}
>-
>-	return wopcm_size;
>-}
>-
> static u32 detect_bar2_integrated(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
> {
> 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>-- 
>2.46.0
>

