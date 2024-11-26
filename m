Return-Path: <stable+bounces-95575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C29D9FD4
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 00:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19EF2834AE
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4C1DF255;
	Tue, 26 Nov 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJwGDgAB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C41DFE08
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664789; cv=fail; b=gP/CvKdex6qBFKzLiq5SoMyUWVXc3OuSIZwU8pruAJSrYXhuC/onFaDPa/3tH6Nb4ivDIqEoRNH8WBkcbMu4tOePUqZ69thdmkWiM6/4ov+hI5h/Ocldf05ynmfDtDxiVVUNtajjuVtZBl0wmLAeXT9KclCl7S55S2s2Glev5pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664789; c=relaxed/simple;
	bh=BQYK7bPNeiKbKBZFL3YsYzlmss8ra4tvuBZZL5Uzsx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xaz9knGvXD7gFxv6j6lXMaLUIrMTpJf6CLn5S3KdAwzucaVAjsVeN4ivS5pwgLir8q8k4BKdEzVl34xWn17mi+CB+3cbQUHjFbGQekz7Yj7Qw+pKsYO30ZvBtrgnrCwOL2gByB6O5kPQTq73TOaJf/3xVNU41or5fhNxEsrjgBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJwGDgAB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732664787; x=1764200787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BQYK7bPNeiKbKBZFL3YsYzlmss8ra4tvuBZZL5Uzsx8=;
  b=ZJwGDgABls5PDphBFNxOPLYrbDWWMDplIOuD52f3V5SJ0Dp08bidB8Ip
   B3mv7C//QG5gdp1SGljl9CYul+9HZO6iWL+aF5+XDwgMIenwg4k4KVg5R
   sv8l5G1keNLkwk/5dmYXRYoLoTTojZMLCxUMohcO8Q6NzVCmyBLgI5V+c
   FnW1dqQIBHv7xLJui6D60Cy4VjdHAvgvuGAAyEHkq3qhTHZ3byZxuE6DE
   bGSWwBu60iJzp1dJe6oHyzTP1zUfnqTOGcFvIFla20ZvZHNP3Opi11+pW
   YvgSAu0rAMqAMlE37peTKm5uqpnWRQDtjUWROXmH1p2SvMQLfa7b+BoxM
   w==;
X-CSE-ConnectionGUID: vcA+sEwBTbuj/WR5ysSBBA==
X-CSE-MsgGUID: xXNfUd1zRoiTdd5FpUlOmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43344332"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="43344332"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 15:46:27 -0800
X-CSE-ConnectionGUID: cwwNOO96QqGGipVQmkM96w==
X-CSE-MsgGUID: E6SDhZzERqSXo3vndxK2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96819100"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 15:46:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 15:46:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 15:46:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 15:46:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoI0+N/DpgrElv8D7i4wqr0aVN6SwaRgsd+mxD0QvgjHZl/aJs06vBcwTUeJzukMzk5DGkXRTwHZk8U8lRi89RgXi0sze3UGjJODunWRoudITayLJmu1BfACVe2WkNL0qzN1JIBzvTaWfvOsbnETO0FMVwOwQHQ1PpP2+9UHYsiohECkEwsm5Yi/P/uQ5GFr0M7gRRcy2bEU2pHYhbYlC1s5KEiofPGDpmDnkqrAcWRAm4l6oXby1SdAu0w4xxNOC6xnu4Pt9KxfJR3r9aP7FB+cITAgApQqs06SMpxYNPaZXgDxJrI0i5VVuxIhm2T2tyGf8PJdaYsxNdBTF8vYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmHYcL+BJyWD+ablNp46n3Zphim6Bt6Z578axXGnivA=;
 b=zJsSTrLml057T807Ne2Uv/jnWhv94B9jXD/ZyMa7Ust6beipMvxVt3dOTJrQb6Q2OBt991ojBFp8+Povi+mTvzcat3TWJ0g+ABvlM4LjFihun/wS/UGZB3H0xLm8X/v5XXtEZyMrQHWdNpJx3057qZnhsVDmqHHfSS92dOQDGV6HMLbXW3ksaBQEbnOhSFvc0HXQG4krgXU21+ZWA1iNGBhCxnnRCwyRyyUredOQ831f4IxlFRn+lxx5aMI7GqaAk1qaAFlcNYhwpPNlODo1FtOtCbNstKVhALAUXWlVpi9RVyXcOD5kNbDz4gTeOqqzyrnsbTjb2+sV2wySJ2oOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 23:46:24 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 23:46:24 +0000
Date: Tue, 26 Nov 2024 15:47:02 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/xe/migrate: use XE_BO_FLAG_PAGETABLE
Message-ID: <Z0Zd9sWX71AUrSS8@lstrano-desk.jf.intel.com>
References: <20241126181259.159713-3-matthew.auld@intel.com>
 <20241126181259.159713-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126181259.159713-4-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 93382954-c5a6-4130-726d-08dd0e74899e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pOA94/F7pIh0TdjGCskuHFSN0mM6WHwnD9/++2L5G0S8Ms9+e5rd05Cy0DUZ?=
 =?us-ascii?Q?2tYAW4Cnl+qEXNYlLWJJ3VaUz8T7tZ/9xxBH2GOjaiwVcHQuYEjnspQIQ6IX?=
 =?us-ascii?Q?P676wSIExiZpo5w2sW1X8Wdr68o3vdCkSlWT4jSFPlatOEJL7DOTycwqXOJB?=
 =?us-ascii?Q?BY0v+oulMfq2sTpb75FhP3Il6jMN5tKoFk6j93WN8FeS5Q5PsUtMXNGL8FUG?=
 =?us-ascii?Q?5BYuiwd5XRjhMPteEBO8qfW5SqVdecUh9cjwKHtObfoOB3DR1ymKPjU/aSpm?=
 =?us-ascii?Q?hx3FgiYlqrzspqvm1gTJ5X2hLpcSTk+FV0ogQ93pYUrOIxd5f+WxvuVfj1Y+?=
 =?us-ascii?Q?4zltGFlu0HOfBrFUQZgdeHG+v2CL71JttprwLNkdv0kEw9bMtYssgVaUH+ZX?=
 =?us-ascii?Q?IG8tBp2DFe/UMlQtrZQRg8tUNACOTFbuyjXsHQVf2aHbPhTFaFCKRuj/E+5l?=
 =?us-ascii?Q?bAR1sg65AAR1clMR0FRi78+eAS8Vq/nhVzC+u5lfNFXvbQgWbWQRu8IEu4Vr?=
 =?us-ascii?Q?QOMKVPj2OUnkKxTB3p6eU+8u8H+KJoDqtsIe/AbVw97b/jVktZFPSzULPuYP?=
 =?us-ascii?Q?LmQUmwbtGCmRpfT0YA08wlroqqxiZphs17kF94WZ8Jfmjex8CRzFNls6UZAk?=
 =?us-ascii?Q?t9s+ghq7cBN8hnBihkLvTdCGmTuV7cBnF6VtSKSvUp+Onx23N9RJUo0TVjsB?=
 =?us-ascii?Q?xCWWFUONRxMctvSRj/AuvrO1s9MVOzFZrHhUNtvIqkjGznR71a4snS0sz3uB?=
 =?us-ascii?Q?Yopgie+BdEoYcdkgWNlzDi2YcR1+n9P5WRrJhE75W0ecjlMUbi1vNZn/EMYs?=
 =?us-ascii?Q?EZYHbSG8r/Oz4c2wGQ359+4iCOVeOQClFIUs6uMbrm1oOi7LG156L/3IMjkm?=
 =?us-ascii?Q?Y0l6j5xEWLEJyLpAQFFQuIip/buuiVpeT6zN3aroBEKq+Nim9IggLYSsf1ab?=
 =?us-ascii?Q?UOjefpbRbNBWzXNqWz2ajWkVIu4xlcDEH3bZgcTM1M/F6GLREuTRpN+N/PWi?=
 =?us-ascii?Q?Q6wUhXD7wZqx/bl2eFe2FX/2EVwfGmT8jLfLk3WZb7+IFCEnByzQBnsb6SGm?=
 =?us-ascii?Q?c/Nu0irRDXpc/hbIdXETG6oC9LVoMgjBUHDacFPpXrToXKtZ38DZcHjTCE53?=
 =?us-ascii?Q?SHqTXH1zIG8kGQHNtiBCD53DFZmlo9EOVv3Q/drZcLvIcMcBh/Kyws2C1zEw?=
 =?us-ascii?Q?T4y3sCuk4sljTNkgnesOGav5KWGTycyXMPzRPYYXYSwsjpZAWwMNRYuh/jqu?=
 =?us-ascii?Q?kChLoPeHvBUmeVEJ4aQQWpAtoZDyzKZJ2a0mPNREEY8Jdgq4xemDxzWrY5vv?=
 =?us-ascii?Q?8vaD+04YlbA0sD+qGo6EpyKoM/+TJhZu+glgHlWqu66TvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OP+EcpsqrdaqFqKROqm0dIb8LSLiiLIn9I4fkV4yjF8kpDVVs1cQ584stxJX?=
 =?us-ascii?Q?4BssnOsqummsm6vkj7lhoDmLbPBQGwt1o3pGAYNnr1eH7N5Xj1ui3ii9aPKq?=
 =?us-ascii?Q?DIqiGwhOS56kzM+qIiK5w7ItflEIe1khV1JoVEzBZj9fR65NwGyCyiRbVEiI?=
 =?us-ascii?Q?zbn15UoIH5F5pFM8L3JBKvN2LwOsih4eQMjCozGNYG/iQtHuXKJytc01z99V?=
 =?us-ascii?Q?Uqwvy8Eatedf2TjZ8NuC4usCkGJ90xs1uQ6QcLy+JxZRmtPUZclmzzEkxrhZ?=
 =?us-ascii?Q?z8T6tkf7+jv4do/9T+ubXHKYDiFt6wj+lITN0TT3PgkHiyfI65NM60zhTn81?=
 =?us-ascii?Q?Vt7V9osf+vWJvQ+8uiGslWKy8SD1NYBZMfJuhWH4ydvlrpHQNcEqeKJQOlsz?=
 =?us-ascii?Q?Vn0qJ/lYrBplA0Aiz0KcZBM4ngMS4bHaCq7eisfz29WDd9YKTq6S+TIZmlUF?=
 =?us-ascii?Q?ptF3QQ7iL+OsAyWR7VgpvRyxv6ZZ2yip6qdaveJ5iMnipFdVU9dnWX0zESNM?=
 =?us-ascii?Q?qK73c4+TmdEgBHOBifMz9WZeLedYM8lXXE7K8Ibt4zYD10oCJDJXGrV1m6SY?=
 =?us-ascii?Q?cYv4glxyhLdB8MriJETZauQQQ64hLMDDcgiHYW36W+VGXZtfAIhk1FdQ1gGx?=
 =?us-ascii?Q?1AEmuSORfy+XHl1UvpYKGEV9XWZ74thbJbJ5/uonDxxrZg3H0dLyVZcj8Qdx?=
 =?us-ascii?Q?pnqxJ/6CedbKL3Q8gj4oUbU8oRcwC00r2mVPZCA/P30xjuD8qYLxDN2CPRNp?=
 =?us-ascii?Q?Ej0hujO0i3GTm4mKdyvqBGKcusReaw7Coa9Q9Kc8ok6BxqoixH92aXLocvX/?=
 =?us-ascii?Q?904H2OeBKg1QfmloUpGJobq9hEbWDq7qGhldJ7+/4KxBpTh76pcSrjQLNKn7?=
 =?us-ascii?Q?ggCYyHMBN+DBjlLciXm0e+Qyey4sDBrFcWM0PQGa1D02YUkqHmhe/VBmmqrN?=
 =?us-ascii?Q?q87IurXF6yZchLhwaCXeTTI5pDJeU3RGvm0Xg76g2QcYpKdt4YB08qMzS8Pn?=
 =?us-ascii?Q?CabwGOKl94Hej0CWfhFRM1Jr5kypDj5awkg5Hk12YDHeBedcXdUrg35HkRM7?=
 =?us-ascii?Q?zX6RDbPaVXETBHN0CvgTbEGK8zNljCDukeyhBgvP4yvA3Le3YAn/+dO1Gvaf?=
 =?us-ascii?Q?dQNhJR029d9+c0kazZowVauwg1ZpSxPsWWocmkkNx7ihXcYl7j1rOWgbr7Dd?=
 =?us-ascii?Q?llyWatO7Y+u6l9gSNPweQMYbPej1jAsPjlS2bT962/Lyl83xb2IXS47WiRAO?=
 =?us-ascii?Q?glrHizclppLte1HIuC296s+rWkB185+kf8HtB/pfBYqUmpxsG79fqrKipdph?=
 =?us-ascii?Q?hc2wyg4Bwuy6LgNNhGlBkmQMBgInFPdjRj+2i7ylKqhfG7ZXWyigBpRxErSg?=
 =?us-ascii?Q?6ywlmT1touHsuq5e9ArgIH51kS3kpqZPTPWO1KOPAfAt9QwTANcCAkLwX7wZ?=
 =?us-ascii?Q?1EF0GDh8Nr/qMl9385f5P9oovBUrY72bBjSfk1D5iUAYYwojOH/wznI5Qcg/?=
 =?us-ascii?Q?w2RUpP7DYk620HKi/HcJJPivRGN+ZBmluUp4wMANCiZuoPdjbo9/v8iepWR5?=
 =?us-ascii?Q?WFdI9IMi0fTlwoW+Ew56XJfSFMis8C+n3hFWb0X4wy4K2VOrnggZCevkWf6p?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93382954-c5a6-4130-726d-08dd0e74899e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 23:46:24.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC1EL5iuedCHac+NnxXwVQOLGbyvaz8hA8LyyNfIeVwvQhJi4d86R+TfcqYDJb9Yv/2UnEq8Ac4NoCqOQVY1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com

On Tue, Nov 26, 2024 at 06:13:01PM +0000, Matthew Auld wrote:
> On some HW we want to avoid the host caching PTEs, since access from GPU
> side can be incoherent. However here the special migrate object is
> mapping PTEs which are written from the host and potentially cached. Use
> XE_BO_FLAG_PAGETABLE to ensure that non-cached mapping is used, on
> platforms where this matters.
> 
> Fixes: 7a060d786cc1 ("drm/xe/mtl: Map PPGTT as CPU:WC")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> index 48e205a40fd2..1b97d90aadda 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -209,7 +209,8 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
>  				  num_entries * XE_PAGE_SIZE,
>  				  ttm_bo_type_kernel,
>  				  XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> -				  XE_BO_FLAG_PINNED);
> +				  XE_BO_FLAG_PINNED |
> +				  XE_BO_FLAG_PAGETABLE);
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
>  
> -- 
> 2.47.0
> 

