Return-Path: <stable+bounces-233137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIVJDQspz2mmtQYAu9opvQ
	(envelope-from <stable+bounces-233137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 04:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB043906CF
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 04:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49EDC3030D48
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297C346A14;
	Fri,  3 Apr 2026 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lz75iT73"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A422C325C
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184133; cv=fail; b=Vvs/B2TVPboZ4XxK7Vf0nwzei+FwLQnb92sPWTIgdX9GJopuiovNJVr1aoLDDXRLEWLZHFxpvS2cyY8nHt4f9673+QXfUEqzOwY6vLs8j/GAlxichYr82p2aSECTEh8lTQP+VjM7v3h9zJXy/y+DHeKzZEtjOXbbSABBHiLlXjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184133; c=relaxed/simple;
	bh=liyXLs8e6l1UTJamzbHDTb3gJ2upTUOpGcFvhYCbves=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s77nGfMtLbBUlp+2X+n8hqNm8LVN1xWBMj/DuNuGHZ6GBeTZOutVwVKuMKblah4KTAm0rU1kK9Wq4Os18+hCyiAa4W9uBouMDKkMhlxogogqOPWxD7/+TP60ud9pGL8wVY0uKP0Q2rdbOTE2FdV77vbMM+Km6zSn0iBdqaDV/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lz75iT73; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775184132; x=1806720132;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=liyXLs8e6l1UTJamzbHDTb3gJ2upTUOpGcFvhYCbves=;
  b=lz75iT73WeruPhHFxWjq9cGFUnwGKYVkjAVuDfNFZ3X4X17r3B5e7aHP
   gp6QHZAg6JJxpkFiSj+KEL6FTbmjya8wxaO1wCaG2HgXroJ955n34HaOv
   Uar5RBlJim2dImevr3dHHoiWCHZyI6EOsh5MKBIt4YYv+i5jC2hIIJKRe
   8Az28v7bvehM0wBuUkBvIBKPxcHEl0zbtMUrbPLUFb/YG0y5SZO867F8g
   KnXWkI4yOgGvgoMgsErOmpftYK9sb02/YMHnqqhYenaZ248FTMUo35c6O
   78K9ClJbE4CKqEwnOJAIJldZdYoue5BoZYxGUNUcUPE+xKkzTvUTjSGWS
   w==;
X-CSE-ConnectionGUID: g8+nBGXzRf6I7xo2C5g/ow==
X-CSE-MsgGUID: TO2Y+NdRTx+KKwitSTAdtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75423487"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75423487"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 19:42:12 -0700
X-CSE-ConnectionGUID: DmPAL6lcRK2fiFm/HEXFLg==
X-CSE-MsgGUID: eEKq3YjETnK1Ax4izTPaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231946429"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 19:42:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 19:42:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 19:42:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 19:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZU7/bMttElUUTMEBQ2KuxGMSuB9EMUU/xHGExUTnKq4csBgnkYnBg0QLbZAo1p4ad06hJMenVbKWzB7h7LZLINjoJHPLhaSWxuNiF8ksBc4fSzoRvfxBYtlb+M6s6TQb164NlgGqK1tUFc0IMePAVtaTpio8riGYKz911lT1IiBsQFcGKqPrLAg7Q1pDTsYF/CE0OxtFbN99+1Y+1J0LSzlTj3b032H5pjjoX0461yNmcKWDtgBwXdjw4Z6YtxTv5/HYR1Snj95rmsXukg2aawcZe6/xcSWSudROXptL4RnfYdPakN8uPkmN4+AAu2x0kTxyAjeaABFK1ptORl/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKbyWBfD5xWP0yT+sZ4StN2hiS39fokdvRHkDNsVGXo=;
 b=d6NEoaGtbCdOemSn0F8Eh1A550k1cg2Fv9hDfor8uybHPJlf55iFqTECDwu7gK3/4mmluQR7FNesgbvzGCbpfJaXNGOjX/BmQ7OWvOV8b/lxl83thb7Mj9V6ZC0GNHCYyBjWwn9/VKdqBm9n3mDwC7hrd75SnSnTNaAG1OxHwyJrG9xg+wAyZlGpyEbPQF7JDBWoPDStWArUW/8r9soPtb10nDfv/DrrcAKWDpurjL1J71MY3r6b5QpjHPfmf7WVKGqrKJiE0AaXG4x6wwEYX9v3dr9Z9c1huhEckKu4HlYWy2SLcI722tYNf5QjsDniIU0VD+cGyDV1k1eB3ZBeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB9749.namprd11.prod.outlook.com (2603:10b6:510:397::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 02:42:09 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 02:42:09 +0000
Date: Thu, 2 Apr 2026 19:42:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix slab-out-of-bounds on PT update ops retry
Message-ID: <ac8o/ubOXlXYTUeV@gsse-cloud1.jf.intel.com>
References: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bb1db0-4270-47ae-6687-08de912a99ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K0lDnkOr3OMM2A8PUBC7u6Yz2clriwCuwRkzWzlcOtuDww6g3qq+5mk5fVHPMhEvlxvo83og0C1AOxdqXRAv+RGVN3FIhBNh9M93oU9XdCNiDNl9LtOK0C7vtKfPRbBkZfvuTojxSCxvzY8WA9ig9SsdmD0uu/n6lXz1f0ISeEHQDgOZ4KHnFqy0fOr8m+6ibc9Fw1KGJcDeQtRr51GbXAqjWClZfouHDdVWZQk0hceq/TID1uuaiIhtWrXK91RtFvmrcisOKFAdsgHGoADeLKmBzT9ELQIukKNbl+8g2YmUtJ4kmFOL/9PpvI+CyWvPBQALUhpekO36porDc7Krzn20Dhpk9Qe5xJ/nlThrCrRxNS8Bv7Rydte9ROrIvystdMi4fNdctELgx3g0P42vWTnIiI/tkqWgrELdplxxmb9aZg2cVHoepkdmKqqH8SX9wjJchIBgsgxijIdfyItrZqHPXFsGUfSB0j2/5ZaPeEMNxW830XauyFVg9ObXXUdxkw0qOwG7JIDV6jrG07+hJK8+cXRvaLBXjndcHk8VsixOAbBM+Pwz1P8Uq4bp10ZTFZyvYOmHqlWijECJG9bH5ACyu+b60HiUqoCp+5VrsIBQgK0PzDocKdwRr6kl2yKvxt3Kncmk18z9LeXyQOUEvFwqLu7SgOhBQrw9PdkiHOnNduapON+m5julCfGlUWLHAqXmrhKj6+ik4yWfcL406H1nULSt67FdaaT8wJ981zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6qMRrQvPOKKkXjKsrQfZ6S8BywJfcbrZtsO3fC13OXsmy+1BKT3bb7f+Iy?=
 =?iso-8859-1?Q?oInncrtVU+jyMaCozY+FHgurK09mptTt73DXs+IDzXLAJ39dXAs8v/xIUf?=
 =?iso-8859-1?Q?a+TjsuXMEgRUwIiz9WlNPxGbulg76NhA/IGeoBSaTYvgCnuadn9nC9kGID?=
 =?iso-8859-1?Q?+33VWYwIsLWH4ZuMe5F2sa9xSOjuCdDwnlORPc7QurI9/UhyOKlezhEDCN?=
 =?iso-8859-1?Q?n6vThosgJqLV3uCY3s8yVrTiTARMQvIywCHm+2mFSPO9CNu0qb6zudHwjC?=
 =?iso-8859-1?Q?CrVoB4Z4c64QkobAZv0Ie/0Ak+rE74pWVQvnjcPIetzgXkV2Hw+pepuXG5?=
 =?iso-8859-1?Q?mLoLRxZN8hwB8POZAspFQwhb16AE5QZgovV0VcTrkbTwBQRypLqRexJZ2d?=
 =?iso-8859-1?Q?811RndIoHULriHbyHTIFf6NyUuCguXViKKDeyQ3Tdhze9fEOnmDHEPNNeV?=
 =?iso-8859-1?Q?LKZEUb4mi9jLq/hb4ekQGOgJ72h9yCDC7/Zedf7ZQHoF5qtfB0DaBSocpr?=
 =?iso-8859-1?Q?ZTJFfbT7e9cdYxiR5GHZ+ImFbqYDiEhalwmBhSt+dWc8T/iV+JMTdlGQ7s?=
 =?iso-8859-1?Q?VxS2NeCTAJWXFNdGwneaLQgG2K1McrHL6qe6SIOZ2MKMB1OtHd1Z1SC7yK?=
 =?iso-8859-1?Q?BXCtMlGD3ntsHXNBpz1VTIuOZ4+8/ttmtO/jwk8A39+kI0LYbLFCSlpQe2?=
 =?iso-8859-1?Q?2dsqlLGZ8/aOhNlFR7eqQE9Sy4Lac4mm0kkrcrD350Hq7tjdb6eHIz8JVz?=
 =?iso-8859-1?Q?8tHgIB9SDMEddMMeWrv0Z4paX9sOblsRQOwvyvuR7JgeDdQAJHpzGm9gq/?=
 =?iso-8859-1?Q?1HbTlHPpm88vG9RiXwduSEuUfNEv8WqGpwNRWc+cMlx00N24huOhLsKABS?=
 =?iso-8859-1?Q?/8JAXJeQ79X3xhYQCdWX7ggDCLg3FLfFJn7m5ebBh7vtmOmuYDdhwkkXKI?=
 =?iso-8859-1?Q?QhwXvcUr1JVMKzC7qmSYUe++RQukKzAdQU+9WpT1Swm095VkJwR9TFBJfx?=
 =?iso-8859-1?Q?mQtDWTMXYB09HbBd6dBVsWR+343BaEb1Q1+AMjtSApZTzN471akoqPPz3s?=
 =?iso-8859-1?Q?cW1OMYedM0EF6ZPbWYt+wLRFWHa/Pigjnr8M61zfrGA3GkY2k7ESe+ZjGd?=
 =?iso-8859-1?Q?m3eDAatgs+uNKds1EAPn1SbTkwwT/y50w4l4Ndonu7XmZmrDFTkkWFMT5+?=
 =?iso-8859-1?Q?5oALQq2qVBb7FRkwRLsyaXntgpg+d8S7pAbCfnCkws1O7dNZ9rDZ6yt83v?=
 =?iso-8859-1?Q?VTqzVzzHl5wpPIvxAl9Ctxq+JGZpx/PAXILYcrg+U2RBkpTk1bGKlMSowK?=
 =?iso-8859-1?Q?eM+jiXY8hi6steg01w38aMonAKWIXmciPf3V19E4ciVhfiUWJwFb/A2k3n?=
 =?iso-8859-1?Q?aIna/at7714StRzk//wBXf3tgSAWGEbmcYInvOxN9Ak1Gp9rCX/AaaA9g9?=
 =?iso-8859-1?Q?5BAqf0gNF7DlI+RG/pxeBOVBfhy6drBB55ggto1AKNhKxkD8Td0zjzdun0?=
 =?iso-8859-1?Q?ZJLwiC7lBY3g1445ArUgzeZkXZ1HDjL7GyHQzndMmkUYMwdskoJpchxMhP?=
 =?iso-8859-1?Q?vD9Ne8KNTQ3HkOKeEnbcY5VV9vPqNgJBiqWSGMjYoNTeo+uUY34sk6e41s?=
 =?iso-8859-1?Q?dBmymKjpBSns/u7tUXOzFNtkTB2NkjDeMrJZs5AMqs/Y0QerZcSlQoNdMI?=
 =?iso-8859-1?Q?Y6hyzUgpDj+GkoXISsh3OdEFnnkZzbLkfZQLWa3h2x3l7SvI5L9Y1hwH2/?=
 =?iso-8859-1?Q?rlSEGj7SIrGR0ock3EpMXRkeFv8abrmt5InAEFAPC/S1C/IUcYU6Q1M/ai?=
 =?iso-8859-1?Q?5g3DwMFxSBSpTtXNJtoeMJkMVWJmQw8=3D?=
X-Exchange-RoutingPolicyChecked: e4geT2k63zFWpk5yhspNElg+TefBrNwE7627kVXZqt69bXCe6R9k0l6OBLKBV8RozWKRY/AxUBomW+2ufJyN1SgSXGgP54yT5qxDGGxTatYVLwPOnsluJgIbILyvINgRagFiVfTBrqh3ue/eBI/nhm/f9FzJkSPd56YAfFRUrIyMLIdb8FEDQr5T22Y4rup6OMwTzOWikd0BvhFXhnbCApj/bpYtvCxkwY1RJ4DPTm2WUcZzLJky4K7Xg/tDcnCgl7E2IicWi3Bi87p6AsT/sDMrgbeufpWu6CcrJQLBT0yx7oYAXIRwsuRNUzJCgShEGnsL2VGy53A+CvNAG1MBZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb1db0-4270-47ae-6687-08de912a99ed
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:42:09.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAAoF8112ZhJUbvuJph5BNvd7DaypWFxt3+ebEaqAcmdOyrKFh0NtrXNJ8amEDBphppPvxGfUPVwlmXgo9lx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9749
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233137-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gsse-cloud1.jf.intel.com:mid,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8AB043906CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:15:39AM +0200, Thomas Hellström wrote:
> xe_pt_update_ops_prepare() calls xe_pt_update_ops_init() at the start of
> each invocation to reset per-attempt state, but current_op was not
> included in that reset. When vm_bind_ioctl_ops_execute() retries due to
> ww-mutex contention (drm_exec_retry_on_contention), ops_execute() calls

I'm falling to see retry path around vm_bind_ioctl_ops_execute related
to drm_exec_retry_on_contention... Also by the time we get to
vm_bind_ioctl_ops_execute we have all dma-resv, right?

I believe the Kasan report but I just can't spot the bug - can you point
out the retry path to me?

Matt

> xe_pt_update_ops_prepare() again. The second call walks the same op list
> and fills ops[] starting from current_op, which still holds the value
> from the first attempt. This indexes past the end of the ops array
> allocated by xe_vma_ops_alloc(), whose size was computed for a single
> pass.
> 
> KASAN reported:
>   BUG: KASAN: slab-out-of-bounds in bind_op_prepare+0x89c/0xae0 [xe]
>   Write of size 8 at addr ffff88812e72bae8 by task xe_evict/2848
>   [...]
>   bind_op_prepare+0x89c/0xae0 [xe]
>   xe_pt_update_ops_prepare+0xbd0/0x1570 [xe]
>   ops_execute+0x3ae/0x2030 [xe]
>   vm_bind_ioctl_ops_execute+0x4d5/0xed0 [xe]
> 
> The write lands at ops[1].vma (offset 360 into the second element of a
> one-element 384-byte allocation) because entries[] is exactly 360 bytes
> and current_op was 1 at the start of the retried prepare pass.
> 
> Fix by resetting current_op to 0 in xe_pt_update_ops_init().
> 
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 8e5f4f0dea3f..3607cd57fc4c 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -2291,6 +2291,7 @@ xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
>  	init_llist_head(&pt_update_ops->deferred);
>  	pt_update_ops->start = ~0x0ull;
>  	pt_update_ops->last = 0x0ull;
> +	pt_update_ops->current_op = 0;
>  	xe_page_reclaim_list_init(&pt_update_ops->prl);
>  }
>  
> -- 
> 2.53.0
> 

