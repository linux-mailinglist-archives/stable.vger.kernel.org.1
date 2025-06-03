Return-Path: <stable+bounces-150744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A2ACCCAC
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20903A4D2A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656424A069;
	Tue,  3 Jun 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C35Set6Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885E24A066
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974132; cv=fail; b=pNEXEQgu31BH7TAq8+dGTbsRzd0g0fbm/ppSfRqHmSPJ/jGo92LPkQP3JDkkHkzgauckfFMrpO/Mljq1WRM/3B8t/LoNOQbuu612ACbCMWC4BzL3ydGKRWzhr9ilmdQlNM3rbMonlJlTTjuuxQqRwGtNaDyRw9+awsl6dL7vIVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974132; c=relaxed/simple;
	bh=EffweIgnzM69W6hQQoygh0Dk/dczBbu0G2qM1KedFj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c9X//7Ryx5nt6zfsUkRCqdZzg7+AYRyIj6M+P8I5kNGgLB1k66bPsifv3ceULDJpK/mF7XLaIWcoI2XrvCHdnm3ZHZAMVF4UNUSxtlNhK7wqIdcsSx9qnjctJwMe50Nqtb8soljrZ117/045Qw9dvVVdeylfPajiRF+3ddyfuqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C35Set6Q; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748974130; x=1780510130;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EffweIgnzM69W6hQQoygh0Dk/dczBbu0G2qM1KedFj8=;
  b=C35Set6QbdD1WruHbnuVa9qfE9U31FSpJM/fWwhtURZ9a66AR0SsEoVx
   0vMaJ+JBVz4109Md3ZttLk06poYWnRv/XBoEhVCAQUOfBcU36gmE0GdnU
   oowc0vqdpnr2gfLv2DLs4FEe7F5wiG8XDDUJzvK2o2C0DWRcBJ7LsBG52
   6harLQYZmNqVU/n5WzNtz0/fZtxIlH92m8HocPtmLvEqnO6Ca5OHUinjG
   TienhzY49hAY7NWztpVR/Y3OgL9WCGBXU7tPudSrvv23peDGKor7RJ5gB
   dQYv4u5sHyxBvAf5A56JWvAC5Ta2Wi8XwCofAfEsM4DgI6F/46HLmqRtN
   w==;
X-CSE-ConnectionGUID: ORF1uO+bQ5OlQnQfFhkKWQ==
X-CSE-MsgGUID: XRJ5pMgRSymTTPqh5oucfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50150219"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50150219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:08:49 -0700
X-CSE-ConnectionGUID: +A6k/338SlOS15vqAJw5/Q==
X-CSE-MsgGUID: lY7W22hPQrOwPcpbtd5UiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="148778460"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:08:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 11:08:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 11:08:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 11:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbU77Q406cM6R89WCeG/TA9Or5jYU8/A1YLtdzbbf6AeJMVMD6gAo6UB+dv2A+ykxTyuU7gi7kAdbekceIPyX8FHiWWbQYVuC+S6iNuUUs56l38m9mnaBS3IZuKbTIvZoYXz/7+PSFcJaSIa163xZ94bSZw9dMyrZ5uOyPLUczjgT+gVXoLVV9hI/qsPSCpfO9Y9JUZ6B31uRfMnYPbp/wdnFgwa9DfaGXGA2HSsgnhAgvITzbxsiqpBwaZuW0FEPrK64zc0PGuLLNLQ4oX6YSav0vH3QTJnmqqrp5PjuniScRPnwsdmUfr1ab5LTGRgC6mPL5yuGb9QMMNNx2evbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHh+kem11yfjN/0F6IdV42ZYlt8Qhes3DlXe1OXDxH8=;
 b=B/TxCYayUyTVEMYGGF4si50R47PpFln/Vs8DG50IhyfFK6sgUcBybBxKzWgTqjnGOwG9xFgrhMgwkvqjB7wDflYPg52L8w4SiE8DHu+Y0QpBZfo1RXbOAm9g0xdBMTyFZl5EsiUo2ryB/7fmjlQIS0EJdOf0nK8RPjE0ffiMpZU0t5ilxv5Oa1DYQu23JiovhRoMxaieKP7btKjOEqESW0rNwYQrvvoVZAOUDslgldk7octDMkoChsTmNMywPlspGboDeX+Z96hcd1zvZmSqFqFKg5sfdY2Tfogp1kUQGvTxHHo08a9HoYxKALdLAbL4ljI4vShtOYLzW/UZnbFssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 18:08:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.8769.029; Tue, 3 Jun 2025
 18:08:45 +0000
Date: Tue, 3 Jun 2025 11:10:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Daniele Ceraolo Spurio
	<daniele.ceraolospurio@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/guc_submit: add back fix
Message-ID: <aD86ioCUU6V8N/X0@lstrano-desk.jf.intel.com>
References: <20250603174213.1543579-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603174213.1543579-2-matthew.auld@intel.com>
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL3PR11MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: a094327c-101b-497a-7d01-08dda2c9ae55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kppABc3Y4hAVk5mfD7tmQ7qAqafWcBsxWLGKp1hpjs8OFkmtMPfurj1vikp+?=
 =?us-ascii?Q?3FhQGZTsDJiGJYicVE9DFZ5QnDscarfG1jgHzv+Em56s4n7WSnnInKlOKPoc?=
 =?us-ascii?Q?dvmLmIXSjuHb0fjfGyornkFsfBEPOoCKSPJITvqLIpcceku4YSKBksupWWDx?=
 =?us-ascii?Q?thYqs/l2lSV8HGiC+dcIoiSwGZDBQRX3zyO8T1A0GrE8Rmuj/W1+gjhWbCZU?=
 =?us-ascii?Q?DmHW0OusY67/0xOXToppn0wPlkIfjsorCJbkC8gczBwORuwkXmLoCneQAD79?=
 =?us-ascii?Q?PZzUho/2ncs7HpTGw7CBiSdn8zbyEuEdZWUhmEXmW8YugGzZXNY4uU3qxnO4?=
 =?us-ascii?Q?RQ+akq4XKxOT15r5NHwemb5Aazg+PuwKzFIZVlxw53JGwsFiclqx4YDVzv8W?=
 =?us-ascii?Q?IZwfLCgBGa7LyUcDcru7MlqDrHIjr5XkzCTmWl/m/Q3xP64oifVQIa+u8JTX?=
 =?us-ascii?Q?auf5y4y2+qjQDtFOiKjePyZf/FCZphtyTy/8GONm22bNai1d6QZUTDoWHbeC?=
 =?us-ascii?Q?+W432lfYGMCbEFjT5GEQ3ZZIQU6Y5487HEbVekUTyhFyIXGVr8y7SgNQtBoX?=
 =?us-ascii?Q?81cCp/pcYzn1GMHfCbkZamGRghXfxkm+KU1k5pTMofDF5Jl69W92etPfTJXQ?=
 =?us-ascii?Q?CV70j0KOnJxjzhBRn1ReJPzL0+wPGuC7HVOdaxV0LfAPiBYqUE6BwExdkkdL?=
 =?us-ascii?Q?dj9Qm2JVxOlpC4084ALsXI1c0NbsblwfV1JPnPTZ1A/Ey2itfSYg4JhLbGKE?=
 =?us-ascii?Q?+Q3ULWZy125b+VRG7va3UrEFE1b2OU6MsSJf00y1ZANBZC/dThBn/nnGHan0?=
 =?us-ascii?Q?hHUmrpp3KFNi+S6baZB0uaxXc7JBk6oPlTDHpKq0SRy7MsfZOPEp0dRMcvzP?=
 =?us-ascii?Q?Rubj3u1QLrpsg0OGQEwDK5IafATHgx1Pbl4L9fkp1JtdDtcH3FenzORUUk98?=
 =?us-ascii?Q?+chk2YxI7/DbjFYI80//Mjt9Xzsx57UYNyhVPx3Mg+kuc9A6NgdN5sjpVfZE?=
 =?us-ascii?Q?9A/QFJq0CErrAmlAR3xiA7bnja7CxsAN2T+WNUhEr4Dx6zW6dTfsIE1fFmUO?=
 =?us-ascii?Q?wrWxkP0eLCN4q+0LDdZPa6b0GNMo5CGRA1z0zVZd9ZnXuPLDJOHmTIgVhgzt?=
 =?us-ascii?Q?Sa/Q8drDvB5bZPx8BxmK8R9hhLny3c1gP+46YBo2UuVJLmWMXa2xhuH1l4P/?=
 =?us-ascii?Q?6mO8zzlu5BrueYJoaBEuuWEmtOPL+Hvhh2dFAZbbOuQo5+ePX1wAV8V6HwQa?=
 =?us-ascii?Q?tldKeZpJ7yqov58HVeC2L9tnKSqLWHHFuKvAmFIolNn22Z/zMEvy1NAhVJ4M?=
 =?us-ascii?Q?tCwfjX7NG0ceJRh/6eY7WZ0YpafJY/JFPDSOiATQgXn29eHuOAEwFRjxMVh/?=
 =?us-ascii?Q?JVdZOu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?943TJ/LPDb+zw2uXeXIz7LPZZxAkGKM8I/qaWjjsXfltVEcQ/LAZiJYdwdQH?=
 =?us-ascii?Q?avOT46PoBDyo5o2LWQJZH9vEUEVONR8b/++hGScWiisvZpG6+rNt8wo0dExi?=
 =?us-ascii?Q?eNk72UjQnbDUizOdE8oUJP710Li6cbbWvIVHEtuln3rkPCfctx52zBYOxBuk?=
 =?us-ascii?Q?2rTr37kFjXuDlhmVwVy3V2SQJS1WF2dfLfvS/MHQkAODjwQGBnhT434eFnGj?=
 =?us-ascii?Q?w+2R74TxSDcrs0Irma73qnEYMO9y0hAwhv2Xq7IphLwsq4Tj944Vcw8PqnO0?=
 =?us-ascii?Q?0b9PhGqRzhRO6mmER/K5la4POuAMbgxO32K05+7ySi5eZNrnm3RE1eD59gvB?=
 =?us-ascii?Q?V3eZzcfBXeGXJRJv+7olN6WWuD1mL4RtNqYUXRSbvq4aBbk+4jvsTXhmddMq?=
 =?us-ascii?Q?VOEnbqnZSEj5IMd4bbhNtJReVIdVB7EOGwW8uUNqECzMfZU1FoVT2lVhbb+h?=
 =?us-ascii?Q?XKTidn1RT3wuyHp5luOy0BTAqhr27bx2nQfpKY5ubic137klPoB7w9lQ7u4w?=
 =?us-ascii?Q?VLQQpGwVYhHJEs31gD07MlpXwZOqYgbD2kfkATGBvZwM/Q2fmQpbllo2GQsO?=
 =?us-ascii?Q?V9Znycr3twmMRQD4cVJLbmUvaaYHfIRYUJX/Z3RcNvYZDi/rpiespHONuVwe?=
 =?us-ascii?Q?NKUpw079Z3Mu+XZtGiFbsyW107Xi11Y+VJz5BGNAk1qY6DxjIuxTMUmpeEej?=
 =?us-ascii?Q?sURn2kHYDh2Vy3r3d00mBKjbuWKROTim81ZMXTwSz7/AP+U8uW/sVgSpqyn4?=
 =?us-ascii?Q?k2V1xKQwMoYwUkMTtswXqqz9YRX9yjFKoQ6j5CxipjhsqwsfWRC2GJjI93ot?=
 =?us-ascii?Q?GmwkosU87hGCjmg2bHnVR1iLF/Mrc5oUfVdK22klm2yxRzC7+DXAbodf2dxm?=
 =?us-ascii?Q?Zk6nfJ/TVDcBUM/+jG6E6zXCk9GWDRm/GNUujcKkttUBvTKquF+6TCggsysj?=
 =?us-ascii?Q?z8EEJavnIVHrUKMyXrbepmmoRVMVa42zpD6K0QRQRDQfeqAxi8vQzJYrLuzm?=
 =?us-ascii?Q?xoIpBl65EW7dGH97moeLwUKiKFTDgy36QDAET7SoYYUh3q79k820SUhU2lvq?=
 =?us-ascii?Q?eY6Ug4CbWjA62P4qjQBU5NOei60znwXSl6q1AMILI4C6jEjA92OuJZZZNq5/?=
 =?us-ascii?Q?8j0Q00twpP83fkC/ne6EFg75dl6maijIXjPno5NhJ/yuWdxOd3yioPmZjzMQ?=
 =?us-ascii?Q?WtrusTyw6CaFJlLhbLWhCukkE4W6CZhZS6lE18jpSg3ek947JklukOHJYnyx?=
 =?us-ascii?Q?435Tsxibb9gyVMJGpjDmy7WTaPJ0B94Cyt3quNLa9cxn6shYaW38r+M+9Itu?=
 =?us-ascii?Q?M3j0NUkRrdbiQJLxEgIcD0yXQ6G+ioVrJPMVVUD6Vslt7yWOda5jrZjXVoEE?=
 =?us-ascii?Q?sTIyEnNqmq7ryfgYlmpWt5MiR3iUqCanCDsx80pH4P9sVEnmQPqfvVxyv3uG?=
 =?us-ascii?Q?5PlVbKizt2V3t0gEGlq/xikB1vtCJXmrsZM2LPYfWGaHtV7peK/AlLQICygw?=
 =?us-ascii?Q?c4jR1JOt0jC8OAYb493dAKNb9cvW4uI+XY3knN6RAApHJqJFQVyiva3SjWvS?=
 =?us-ascii?Q?SOvaHGdDgQfBO72JIwWEk1ybSXqCKizVAtr/L8A3/fHKW7pVUenlJCb4HGFe?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a094327c-101b-497a-7d01-08dda2c9ae55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 18:08:45.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Mo06S8J868AWBbzEuqI7Qxd6lGn1gddqmHhEW8Y++BWF5VDMmgr/TiMg5cuDbzXAeaUaPKC+9mEqdWv9WHVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 06:42:14PM +0100, Matthew Auld wrote:
> Daniele noticed that the fix in commit 2d2be279f1ca ("drm/xe: fix UAF
> around queue destruction") looks to have been unintentionally removed as
> part of handling a conflict in some past merge commit. Add it back.
> 
> Fixes: ac44ff7cec33 ("Merge tag 'drm-xe-fixes-2024-10-10' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes")
> Reported-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 80f748baad3f..2b61d017eeca 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -229,6 +229,17 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
>  static void guc_submit_fini(struct drm_device *drm, void *arg)
>  {
>  	struct xe_guc *guc = arg;
> +	struct xe_device *xe = guc_to_xe(guc);
> +	struct xe_gt *gt = guc_to_gt(guc);
> +	int ret;
> +
> +	ret = wait_event_timeout(guc->submission_state.fini_wq,
> +				 xa_empty(&guc->submission_state.exec_queue_lookup),
> +				 HZ * 5);
> +
> +	drain_workqueue(xe->destroy_wq);
> +
> +	xe_gt_assert(gt, ret);
>  
>  	xa_destroy(&guc->submission_state.exec_queue_lookup);
>  }
> -- 
> 2.49.0
> 

