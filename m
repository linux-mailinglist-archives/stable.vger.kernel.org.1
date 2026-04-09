Return-Path: <stable+bounces-235506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNGkEEUP2Gn3WwgAu9opvQ
	(envelope-from <stable+bounces-235506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 22:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B054C3CF939
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E1D300D620
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E8330B38;
	Thu,  9 Apr 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Chq2UMnp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C9330649
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767362; cv=fail; b=F5s/16XPOSi0wksK97KMluP1ugX9Xd49w7xnuK6Bt1ZzbAXdZH6rut9AGc8Zb86e+SNwFWLHfThDPvhHvpzLrdPSxOLSTMhWd2UUtj7ybtlmVYH318/otH/jlsnDiVgXdVTEUUQW4iAlEXlaEdqt2eO0Fm0/A0PZRYAUx4R2DYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767362; c=relaxed/simple;
	bh=TnFucqFRcAUVzu5/gfjpQwETPvoJ4XntCLZLjWjC2u8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Id/Ilv3KE8hS91IvAPGXmrzoOeARZvNpk7Q+2NsXdUyMEJPUOuHh42m3GgOeP8g0qiSB+qH8Pz3oq8MJtkNsWkz3fCM3lrGQODFNWs7yLa+qZb0pMAnyawDAJJT2FvFeOAdpBQ+8X8Fg0XXNbCuK0I87h7C9WJdJkI2BgmEyD2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Chq2UMnp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775767361; x=1807303361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TnFucqFRcAUVzu5/gfjpQwETPvoJ4XntCLZLjWjC2u8=;
  b=Chq2UMnp+nylOLwjBQS3yD2SpdDscGdzNGbnbRUBMZz5M/n8VOY2Camu
   stVIJJQ9WcILUlqx8saP/jxNulyU44RlkBGZlWb+eKDIMzhmwCh91PPy2
   p0/TVXRBZ8PyziWAMWfokHoHXIBgMSfDTkx0D+prR/L9wdtjhgAnhy9x8
   7WvslrblQ6eYWDfh7draNIhZB7hmdZGDokzATeVlUw2No4JfUCk4ThqYk
   3lueCCfMwZcRMciZIXexgkaQwEJsGHgLClPF+vNmyMNzRxPl++QoUFKWR
   4SzY4CYVGlbPFskKw6ZchQjHHrNOx/Jix2BRckBBAQUkik8xOYg9qI06W
   w==;
X-CSE-ConnectionGUID: qjVSJ8ypQT6kAoGEY024dQ==
X-CSE-MsgGUID: lAxDNDoZQPWFsXT6sB5qxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="64323721"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="64323721"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 13:42:40 -0700
X-CSE-ConnectionGUID: CMLCmLkjTJuJhqFEqFDWNw==
X-CSE-MsgGUID: 9CK7FNadTIuLJGY6llfOSg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 13:42:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 13:42:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 13:42:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 13:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHtO3b6AlYJKJVYR50Qcw1yK5J/CxPVlFfd927hFRAPjjap7FBSQs5Vq755vhCK1L6XVv+YRQgg09HGXpp0ZlliI5ak0PY/qQUtknMS2rAE1wcWd3w653uqDQL2MfTLS5r2UpmdCu2mtoeUg3SjTMo50wrTjEBcnpjgwjfYuF4FSgQIYrxMtaSw9bSIOvY+FqL1ziAqGODcfZDyi0mEn3S/RcfmnwJhnN/eK1J1JNgR1yXGSUnBF72f87Uz+/qh7FMJjvLG0SJMWDwYEdWZJvi8vcuyb8DF3/U39DX/lMJN2t1XB8tdTFWiARuOYZMcDrjMy5c/IZm+YgWMaD1/NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpdoc+xhl3nHTlVIs2D76xPIMj3DomMALHUD658JAfE=;
 b=PitCU/G0my1feV/6WyYEhY9+hmG1g4VKUNOQASx5H4T8/TZmPHZptpYGwYqqu4dD9GSoODGVpHEDfWVIJs3tnOhJXNtPqJxsvOw333UHK5b6H3bhmEuZ8sih9pFb2Zv2kolJDKgAoTueR0nz9OT8uZsc9jpmYl62zkQl3rlfHuHSA2/eXFaj1yTjKwoNIn3hYTbGJuwP4plC9jtv6YHgOYR9IXH39RZXhV6UyZUlmh/9XC5vCp1aDzvfgT1D9622gyT55lNN/jAH4CnpVwNrtdeu5VE3dfdGoTuoBr5J08RHBCFJy95jnJOJtan6U3zirvTUjOEN0UdrtKhDT3KpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12)
 by DS0PR11MB8762.namprd11.prod.outlook.com (2603:10b6:8:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 20:42:34 +0000
Received: from CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4]) by CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 20:42:34 +0000
Date: Thu, 9 Apr 2026 13:42:31 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Jia Yao <jia.yao@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>, Shuicheng Lin
	<shuicheng.lin@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/i915/dg2: Add per-context control for Wa_22013059131
Message-ID: <20260409204231.GT2729713@mdroper-desk1.amr.corp.intel.com>
References: <20260331201935.2414108-1-jia.yao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331201935.2414108-1-jia.yao@intel.com>
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To CH3PR11MB8185.namprd11.prod.outlook.com
 (2603:10b6:610:159::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8185:EE_|DS0PR11MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bad12c-eb3a-4dc1-66b9-08de967886f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TdyXcPZolTtun60HzyCcx2hykTYaK08gnsZl7Uy1M40wFlXk/ZvxKhceVEGLeUPAYoz9WNa99uqJjg6581860QH2TGIfVYHIABg85jUw7l6d9lkaokiaMepWRQXX8kCIHp49FPSbdcYCLJh1zTUnK+SAuMdJvgk55FKKznoYQr3eBOFAOhj2Bn1abXy5acqyUM1QOGAeqs8LqWdFwDVMkNUbDfMAs8TamGuHHoUOPJ4P3NbZBlqJNDXeDwBV8xOu7Dw+pVs52Jt63dsR7+4/okzzjEAHhALQRvLnESYr8tBzRMiheTesaAlxu/fECmCcuCtf56Qw8bvyaudOYRqNdjv5vnv/oo4KH7zMM+PFD7u7Geu+4O8IuJDiThHsnU8Gnwdhs7xdpoRN8fQvjj4GWSXYNoxrqmO4I0kuPUhW+LYkfb0qyRnB9810dHb/NcLNqKMJxDbeNTN6HBkDRRJMl/QK87PlG9O/U0tj1J/7Uh25a1AavMR9AKne0CDixSNsQ6A8u5SF202PjG/oqCNbU8oquUDLHBO3l9YpRRVDysdiiSMh6HvfX8gLiqT5ZdMBn4kKj9F+bkwAYq9WJNJf+IySa3UHW4JYOYCwjaGs2vnI5PVKuyqbs5gOueahPjR+rJRGOrqkXDi/hGsB+X+UfHYpDfGcRWLx4FK7/fiu73PGDP/TC8HZ1KJYsk76v1nQu1l+bwIJ5UmFr3BXIF1bIxoq5hegD66VNyvrJo5FSek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fa9Z1u+zZ3OvqxZxRSsQ0lJUHYMkf5tUIiwONp/e2+Tt4ZDjyL+IRGM/2RXr?=
 =?us-ascii?Q?OVlP7BOxXJHGDFUOnC4XqFBOVd8ZIEQfbMFumoZcRyz7BoWBSLuNk8cfxWDM?=
 =?us-ascii?Q?20pY6O6pRoDy4C3ihkD3srivLjwW8NK/cVomlfXLPhRJhLUebZQwn9cPq8D5?=
 =?us-ascii?Q?kuv3/Z3+cPmjh52qYPCJYDM66QUMM5WOw+D6iU83tDLLBxjyED5/ktJtpwNU?=
 =?us-ascii?Q?gdiVQjBRJj0PA44bTnRbfNEvKJMdV6m3PKUlRGwBkl1oH+iBW/3oXxA2JCT4?=
 =?us-ascii?Q?bwQNpnavjUlawkD5kiLArHTrpdnXXMNDmdNfjR9G6EHYDyQKFOd6E52x3HaH?=
 =?us-ascii?Q?tiXjySGI9KJy6JOcSDuAuZshTs2inUmPeVgtXO5H3mbddEVBxTJ8fnuf3G+p?=
 =?us-ascii?Q?48zRKxC83H0Vjiaw3PxwElC+cvqb8XBauopC5dbTPykgz9ZKEOYcoJRMQt4I?=
 =?us-ascii?Q?05k3R6LgnBQsgdtxOw/wds+IMj+INiMmp0SQYH52y293Pz/Trn6euwL3I03y?=
 =?us-ascii?Q?qrh5xCi1Q3kXGg9p4OQKk5Jsxp7RlyjVc9AR5wTkbMenXUfvfhVS/sLk6/+P?=
 =?us-ascii?Q?Hy3A1hZEc0CdyacZ+cgIRGzEwOggmBA6u7kUd/HKfkxUZqmtQ0dcVn7l3do9?=
 =?us-ascii?Q?nA81k9eLtamuKAK7YE1iQZtlhhRzVkO04TtsndKA22RjaQAcgaa6mXv/PHhp?=
 =?us-ascii?Q?b0i76fWUoyKqUjN5A045Ldyat64/UuZxqmEmFjrvFayK7tyRA38E6c8NuJgd?=
 =?us-ascii?Q?+LPRQmRMLj8NKlwMgNGlYhX1kEFNurX7dSxts7CFjPj+4y9syFYGyHqnruN/?=
 =?us-ascii?Q?Pl0Jk1Jay/xHeFA8YkI8ThI099NxXdesZUfVsp9EAF4pnFSYoRatH7FzVEzN?=
 =?us-ascii?Q?cv5fA5nOysT17IxNuUlnVgdYuZZmoWuQWKP14Vo/R9ApCOcBtgWEPHt8nE7L?=
 =?us-ascii?Q?l97tlpDFCOMVwNj4DXHDGxf1+1CY8sZGHOLakhrwYznPp4qtiDLliy+HggEc?=
 =?us-ascii?Q?Iyky/rg+2oG2+NgudRquxfvX7zAprB9fxpzDiyIX75vXHoFr3FXvhjbbK/6X?=
 =?us-ascii?Q?s9imODyHvw14zrDLW8VUkV17qaWG6btgypk8JECn9Z0E9Qu6VOosM17fgMV3?=
 =?us-ascii?Q?vx6SB33zcNQk2JEwEFh2CHXPx8EqlGwmZoS6vDfu7Gld9nfMej8ZLgqKZ2gS?=
 =?us-ascii?Q?tkV4gHXZohozV7jm0ioz51P0yBXOKW0Pdy5Pooiu7SN26QPx4RnFtakfA1Tb?=
 =?us-ascii?Q?noae5RdV04f5m76aR20kHurlcujrmJCbnyZqrNJQhkc2pVKth72pvzev25YL?=
 =?us-ascii?Q?AcGFHnTX2kybTcZV7MiQtSih4Ywzp4xkDhRauo/mj+C9D5Ak0HV9YEC+YhJK?=
 =?us-ascii?Q?loJKfhU/23pWxhFAJ670PYwEuXfzc8PVM/AMI088JT7d9EhlQNRcJMu+LVx7?=
 =?us-ascii?Q?I45M1nQPZtP04RfnJ1nxhYHlD4N1tF0imh96XqU19OhiINu/r6ZIdqf47JRM?=
 =?us-ascii?Q?KZH6YcRnRSbe/doEVAX5H4PEwMOwlhA2nbWuffSRtAeFQZefcgQB5Hs7be9k?=
 =?us-ascii?Q?2QNIEGlhXn3q0pfyhEflGzcxr94N9m2XEzZ3vrTIGu0/HV456GCVpnuwBbQg?=
 =?us-ascii?Q?fBtKVlztCvTflM9LTuV8msdaIbkxYA5io36HS8ZV8gd4NE56IuTYCYkvaeAm?=
 =?us-ascii?Q?/H211NsbZoObtU9oQKiiDdNc1VzWHP56WWJdA/nRWH9J3AM4utKoRx5j+0bQ?=
 =?us-ascii?Q?lPqNJLSNNJuQWJPxnXzrTYw071LeMok=3D?=
X-Exchange-RoutingPolicyChecked: mRUwF8s8l22BFMji7btb/khdM5EaDCCzuPod3EnAB849eid4FuPfrPwoixDv2cWGeYy7wxpBsalMH7yNuYmRNbuCpBTi3SpCtA6N5YZUrGinqoxQ4CinHSPUY9kkgc5+nSYcis0/IaDtSIY9uZGZ2uNKZPjJMSAi5vaUCSaD0lj/iqFEtmuIGnkeqOK93VNjjZ5uGdeAj9IWvciyi5gCzeosaGzSFDWHFNEMLbPhHn/cyokiNrWncTELEiFaKtn17iVkq+tkrQDBe06GQNC7w6Fpk2K9uF3iTE+0+nNjvdWJ0boeWAqT4jj35IhK2GltzILD3wuqwOptZhqyj1Yvvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bad12c-eb3a-4dc1-66b9-08de967886f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:42:34.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcZfFjjFezqbgqZlXP3eCEfgNcob/JvD+bOBR01DqmWPCKu8rfCIAShQNEXgrndSqXMaD5I3kiUb4/MCFsJCgXGZkHlV81xWIzeuMqAn3EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8762
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235506-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mdroper-desk1.amr.corp.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.d.roper@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B054C3CF939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:19:34PM +0000, Jia Yao wrote:
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed for that context.
> 
> LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
> the correct value on every context switch via the indirect context
> batchbuffer to avoid leaking state between contexts.
> 
> Bspec: 54833
> Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
> Cc: stable@vger.kernel.org
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c   | 12 +++++++++
>  drivers/gpu/drm/i915/gem/i915_gem_context.h   | 18 +++++++++++++
>  .../gpu/drm/i915/gem/i915_gem_context_types.h |  1 +
>  drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
>  drivers/gpu/drm/i915/gt/intel_lrc.c           | 27 ++++++++++++++++++-
>  include/uapi/drm/i915_drm.h                   | 10 +++++++
>  6 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 6ac0f23570f3..d24e449f1eb3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -911,6 +911,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>  			ret = -EINVAL;
>  		break;
>  
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (args->size)
> +			ret = -EINVAL;
> +		else if (args->value)
> +			pc->user_flags |= BIT(UCONTEXT_WA_22013059131);
> +		else
> +			pc->user_flags &= ~BIT(UCONTEXT_WA_22013059131);
> +		break;
> +
>  	case I915_CONTEXT_PARAM_RECOVERABLE:
>  		if (args->size)
>  			ret = -EINVAL;
> @@ -1003,6 +1012,9 @@ static int intel_context_set_gem(struct intel_context *ce,
>  	if (test_bit(UCONTEXT_LOW_LATENCY, &ctx->user_flags))
>  		__set_bit(CONTEXT_LOW_LATENCY, &ce->flags);
>  
> +	if (test_bit(UCONTEXT_WA_22013059131, &ctx->user_flags))
> +		__set_bit(CONTEXT_WA_22013059131, &ce->flags);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.h b/drivers/gpu/drm/i915/gem/i915_gem_context.h
> index 6e682a6a0574..831574ec6e2b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.h
> @@ -89,6 +89,24 @@ static inline void i915_gem_context_clear_persistence(struct i915_gem_context *c
>  	clear_bit(UCONTEXT_PERSISTENCE, &ctx->user_flags);
>  }
>  
> +static inline bool
> +i915_gem_context_wa_22013059131_optout(const struct i915_gem_context *ctx)
> +{
> +	return test_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
> +}
> +
> +static inline void
> +i915_gem_context_set_wa_22013059131_optout(struct i915_gem_context *ctx)
> +{
> +	set_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
> +}
> +
> +static inline void
> +i915_gem_context_clear_wa_22013059131_optout(struct i915_gem_context *ctx)
> +{
> +	clear_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
> +}

These three functions don't appear to be used anywhere.  Based on what
they're doing it looks like they may have been intended for handling
post-creation context param updates, but I don't think that's something
we need for this flag; this would be an immutable setting that doesn't
change after the context is created.

> +
>  static inline bool
>  i915_gem_context_user_engines(const struct i915_gem_context *ctx)
>  {
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> index 0267c924634b..4efc0e758d3b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> @@ -338,6 +338,7 @@ struct i915_gem_context {
>  #define UCONTEXT_RECOVERABLE		3
>  #define UCONTEXT_PERSISTENCE		4
>  #define UCONTEXT_LOW_LATENCY		5
> +#define UCONTEXT_WA_22013059131		6
>  
>  	/**
>  	 * @flags: small set of booleans
> diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
> index 10070ee4d74c..84011ce7c84d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context_types.h
> +++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
> @@ -133,6 +133,7 @@ struct intel_context {
>  #define CONTEXT_EXITING			13
>  #define CONTEXT_LOW_LATENCY		14
>  #define CONTEXT_OWN_STATE		15
> +#define CONTEXT_WA_22013059131		16
>  
>  	struct {
>  		u64 timeout_us;
> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
> index d36e543e98df..8d17006f10bd 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
> @@ -1348,6 +1348,21 @@ gen12_invalidate_state_cache(u32 *cs)
>  	return cs;
>  }
>  
> +static u32 *
> +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
> +{
> +	u32 val = DISABLE_D8_D16_COASLESCE;	/* Wa_22014226127, always */

I'd leave a more detailed comment here explaining why this other
workaround shows up here.  E.g.,

        /*
         * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
         * other bits of the register will also get overwritten.  The
         * hardware default for all other bits is 0, but any workarounds
         * that adjust the other bits in the lower dword of the register
         * also need to be re-applied here.  At the moment that's just
         * Wa_22014226127, which is always set for DG2-G11 platforms.
         */
         u32 val = DISABLE_D8_D16_COASLESCE;


I think it would also be worth adding a comment to the implementation of
Wa_22014226127 in intel_workarounds.c referencing that it also has to be
re-applied here; in the (unlikely) case we need to remove/disable that
workaround for some reason down the road, we don't want people to
overlook that it's also getting re-applied here.

> +
> +	if (!test_bit(CONTEXT_WA_22013059131, &ce->flags))
> +		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;	/* Wa_22013059131 */

Rather than just putting the workaround number in an end-of-line
comment, I'd put a comment before this test explaining briefly why we're
making a decision here.  E.g., something along the lines of

        /*
         * i915 should only set LSC_CHICKEN_BIT_0 as a solution for
         * Wa_22013059131 on contexts for which the userspace driver is
         * _not_ applying the preferred workaround implementation in
         * userspace.
         */

> +
> +	*cs++ = MI_LOAD_REGISTER_IMM(1);
> +	*cs++ = i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> +	*cs++ = val;
> +
> +	return cs;
> +}
> +
>  static u32 *
>  gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
>  {
> @@ -1371,6 +1386,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
>  	    IS_DG2(ce->engine->i915))
>  		cs = dg2_emit_draw_watermark_setting(cs);
>  
> +	/* Wa_22013059131:dg2 */
> +	if (IS_DG2_G11(ce->engine->i915))
> +		cs = dg2_g11_emit_wa_22013059131(ce, cs);
> +
>  	return cs;
>  }
>  
> @@ -1387,7 +1406,13 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
>  						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
>  						    0);
>  
> -	return gen12_emit_aux_table_inv(ce->engine, cs);
> +	cs = gen12_emit_aux_table_inv(ce->engine, cs);
> +
> +	/* Wa_22013059131:dg2 */
> +	if (IS_DG2_G11(ce->engine->i915))
> +		cs = dg2_g11_emit_wa_22013059131(ce, cs);
> +
> +	return cs;
>  }
>  
>  static u32 *xehp_emit_fastcolor_blt_wabb(const struct intel_context *ce, u32 *cs)
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 535cb68fdb5c..8a1f40ae120c 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -2172,6 +2172,16 @@ struct drm_i915_gem_context_param {
>   * Note that this is a debug API not available on production kernel builds.
>   */
>  #define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
> +
> +/*
> + * I915_CONTEXT_PARAM_WA_22013059131:
> + *
> + * Default value 0 means the kernel programs Wa_22013059131 for this context.
> + * Set to 1 to inform the kernel that userspace is implementing its half of

"its half" makes it sound like something where both halves are expected.
I'd tweak the wording here and say something like "...that userspace is
taking responsibility for applying the preferred workaround
implementation, so the kernel programming..."

> + * the workaround (e.g. by limiting SLM size), so the kernel programming of
> + * LSC_CHICKEN_BIT_0 bit 15 is not needed for this context. DG2-G11 only.
> + */
> +#define I915_CONTEXT_PARAM_WA_22013059131	0x10
>  /* Must be kept compact -- no holes and well documented */
>  
>  	/** @value: Context parameter value to be set or queried */
> -- 
> 2.43.0

One additional thing we might want in this patch is removal of the old
Wa_22013059131 implementation from intel_workarounds.c.  Even though it
doesn't matter too much since the register value will get replaced on
every context switch after that, I feel like leaving the old
implementation there might cause confusion for someone reading the code
who sees what looks like an unconditional application happening.


Matt

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

