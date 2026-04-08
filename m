Return-Path: <stable+bounces-233752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCknLCnf1WkW+wcAu9opvQ
	(envelope-from <stable+bounces-233752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:52:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3643B6FE1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3B993014F71
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 04:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B2351C28;
	Wed,  8 Apr 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAPnFImZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABE3537D8
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623958; cv=fail; b=SDEmzAU6wNrdvd5ga/9/NrPdo1TcXUHU0eyvIb+RQqD+NveDHxwA9CSsxXtfj1utKX8h0z3AtZDv8gjVXecK+hQEqCg0RUXVUFKH2cofZP/AnduhXTRGy5djf6Q6pE3Qm2jLGUGYAlF5tbb8q8LU6uvRckIP9WJW4FORTaw8Srk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623958; c=relaxed/simple;
	bh=h24Dz0tzklM33wHBfk1WA47M9Sr0qtYMTDbaSi85VuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R6DPSmgIbp55KntS+BYkTWuOFRhRazjraGX2WqusdjAwdMh4YHKZ6Pn4CNBhZCtzarR9Qb0Ylj+MvZWQb7aF0l+ESoHZgiY2ajh2uqQxsgltmVcbbQ2+/Ek92BRBPd+CNkKYoIC1HH3WFTT1F2JzefYyxLnLHpTiFyA+ExhvqlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAPnFImZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775623957; x=1807159957;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h24Dz0tzklM33wHBfk1WA47M9Sr0qtYMTDbaSi85VuI=;
  b=WAPnFImZSpJg4gOpLFc/PhbnjNkXI01r0vNYc8+RNoJzE6oA6Z4g4XvB
   maUZvWKmkYdKeDixoX3KrTrp+K8RFbHbZvljFOzmLvGDfZabYRzCcCnFq
   f9VbHDyu6IgQdlGsUex1mCzY46pfP5nOqfQTj8Yzsn1CDF0E+cP23ejIN
   xdhzIv6wN3PFwzJgZYhj6EkKMDFX1lpTELAG6rD9fZp3oPb54vXUSch8H
   QHH5TaU2O8bIBZ+DER8sauYmVvV1jXcR4zlCI7g0aLLRt7Ui5n8J/KgX4
   1N5JjVVQJ7ijG+L5YMpm7OT3bmn3vivHtvguItsQBgP0ixNPuDGNW7S+j
   w==;
X-CSE-ConnectionGUID: xYHZTxvGR1SM7IXiWgtZ/w==
X-CSE-MsgGUID: r6AUJdN8SJWXNrAOGx4g6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76318810"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76318810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:52:36 -0700
X-CSE-ConnectionGUID: hTUSoZebT8ue2shde/DK0g==
X-CSE-MsgGUID: PchFREIBSt6YkAm5NBHHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="221814094"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:52:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:52:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 21:52:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyHAgFxfq1b2WtqTv4FYmT00J7IXApZ2BaBWm1kVmxUnGieUYAEZS5MJvnGxixzchrHAjKvWOieNDBYigIVJJgV/QGB4V0/kkwOQfYdhXxWjzwRTo/w3pioE7YDLqCj4AqdjcsRkDBmuO6dvmHIW1ppg1B9E26FWuLk6bwbExtHeoGBXwvgeydf+svHALlZVNdCTdxHzfX8GvOJysUWl9Rz1m9Fhyod5mBl+JaGcFJD3QJ/5cs2+pMFrl+ZlkF8ktFlGYG+Macs8kAvJxlp5WDc51YuAP6v/cSAysshon77rJl2e3ABqJv41wNxQstjuiGouZZsA5bBjsAOPG0YWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzUltuArFNlUyK8HS8dLPGZ+kZds3u/qCg7mhCKiBx8=;
 b=Mn0CkYqXDlOQAFASmeB0c9gA0NsnG6zQG1YiXp6HFquPpHmxZHNX6KvxCQklh2SBcFblRLBXf0qlsuswGK4s6TdjVSFxFWPmQL8rH80jZzBA/9ipc+DZF/zDKgz1yM2SSt5CTbx31Kz2JU6UV5ImwFuVs3EwkOqbBRLiigONkCA3CuXwN8BJBmCwdQ1km6qsR9FlAlQSsautsjyLvwpOM1gENg8X0K717qJAkdWwLm4UD9A5JXyVmhlB/nRZe1741IugDBdUq1hSpq7E2/o1JU/6oYJwdbPIvnVVJ0a31dhHv9wmXR3euU2OTP5j8YhoDlgFeHmhSNq+fC32AtH/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 04:52:32 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 04:52:32 +0000
Date: Tue, 7 Apr 2026 21:52:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/xe/bo: Fix bo leak on unaligned size validation
 in xe_bo_init_locked()
Message-ID: <adXfDT2dQyluKCwW@gsse-cloud1.jf.intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-2-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407201542.3396317-2-shuicheng.lin@intel.com>
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CH3PR11MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfecc8c-2206-44fd-8cdb-08de952aa4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lczyhJIC8XeGWV2cUGepqBnhJOcj8MAsNBmW7oy4MTA5F97IpOlAX0RsRvYJBryrlbuF9v1RFUZ3sOiyDy/S8jhoei6bSj7NMH3ZlwpZIZPWCCuoUIuvLsitxKcHqwHUqOrscxamx3YvBT3xqPwqjjnhX/Jo+EzoT2KuT1r0AKzbzOd20F+wxs6n+lIOZ0yR+hTSz/ZeFmZIVf9fokMxlvU+ikCzN66xQFwzxU9rSpbFjf0DnBpyWAG8sYzwwrdb5B1qa4YsIkqEt6kG70v//gLozn/MrC71nXVX069V2syHDvzoQMCCqufn0VjVYoxK0fYQf4zto4laPoORSYww6MoaWrlmaw4CF3Wn47QddDfsH2ItjehupORn+ScnG60kbkUCr+ESXRvcXKC6OxZnlc4GBQBf5pOpWVo9JyLExvJiHp9XTzfaokdrh+qmAAsTdhYREVYKYMrflvYT2vdEM4g+Gy9MSmEDjA1emzpp3xR9lvScXTHomY73WVKTHLqCVTOniWgK4SFNcsuICTOSHk1arLkl13p2x7GcReh3CRHPkAQ+KbGbmvjT4u3PMD5H27EMRlk63j/K3JQnxTrhUoiNdFuooMO4kjCd6Ee7UGLWaFnc5fAkKSWJgkF+U9vkMP8oAq7w3ZRU3SWXP15mNdDDL9S/c+z1gpIwDf2Qbn4ZJrWS0gLfpAVWjveuDCSkK+gighkbt8UBXGgMHKV59s0umtJ2dAs0drZeCoi4AV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7Rg6BvyJm2n1TUwB3eQeXrOyhyIRVIJ/rT74W3DZbs11RC1fGyso13NtquD?=
 =?us-ascii?Q?p5cq5erg0j98M7xkJFFSNNgKYbVwV9SJDVHttStQXt5S+P2OInfXTOMQA3Yf?=
 =?us-ascii?Q?T5CLUGfvOfNE+whpdxqxDuoefTnKOSghpGaG19paUFts3k/dDN8DTUq1tkOZ?=
 =?us-ascii?Q?E9CcS9zjvMmI65610l8zTpVG+cNgt6XNiAfgmyQwSpQ/OUiKZlGNHTjGfICa?=
 =?us-ascii?Q?2ZWO24RfXeT6i/bMwQQBPmyoFu+XqgGyyNtb5sgb2cwun0iWNKb3DBP19Ek0?=
 =?us-ascii?Q?Tmodbrbmmo384hG4wgFdS9FpljLC/8c9v9fmbURMVyTHoE4MHDAsJhqTSfSB?=
 =?us-ascii?Q?khfNHG1WTNcQTaHxL5fyBqE7VtvNao3RiFlT0VqqDxAblnSqiqOEPfM9IBDz?=
 =?us-ascii?Q?nwMnvEdmGS8U0cv8zn2rCDdap94FiKLEkmYwHtznZOzf+fEWbrhJst/P6qbR?=
 =?us-ascii?Q?Z904G+AywmCoF3QdShP8GwnZYhiMVUF05s7URmGHzC9tEq17JAct7mJ3i8W9?=
 =?us-ascii?Q?0tTmnQUhhqLcLIpcKCPZdKGx4HnPJafEMPbf/gjL6fxw92+dn1l9xPRmXkes?=
 =?us-ascii?Q?XzEnEiKl8uXAF1zhLY0L7mQdEWvuD1G1bvNEL+cTtrDJhb5R6w+Sf/ttmqkp?=
 =?us-ascii?Q?EFOe7Ldw4FyRFVT1f/Dad7jZXwhDd48o3f0Ewqw7cCbuD2N6KOAykhnicrhw?=
 =?us-ascii?Q?9ckbEC9cNEZStH9JcVPxtceoAnHVRYfUR7y3WFWcgYRgeaM4PMiLwcTQbXtJ?=
 =?us-ascii?Q?l6UiyYtL2ght2JSmpmLPyzOtCN5R+7VC/TjLHzBdCERXgWl8h1aNM8Hkkwq0?=
 =?us-ascii?Q?6GOQCPlFWA/JAQJAKdgubSbmMbVXWCTxc9RBmk7mzFN+yxNqBh1YRjJa/Jdn?=
 =?us-ascii?Q?yBxluqlu0c+SKerd/kD4uiw+FzBTGS/6oLtsDZzVJgT1xF4ec/Sd3Dv8b3RK?=
 =?us-ascii?Q?SKVlLXe7FnBYzgMWl6p30O5o7psEeP7s7pMuNPmf803Umqs8VE2wfOSP98T6?=
 =?us-ascii?Q?7nZX82AD7b8jvcf3m+WI0Yi+AIldwLTYpVO//d8isFoaQ7ped/RRCmTzEnkw?=
 =?us-ascii?Q?8KxjeTXk2k2oUF37dvkKlKEF7CBltD/XKVUdfgYPzbflrP475sQX9Zx8evE6?=
 =?us-ascii?Q?Gr9dderlmW4fQJO633W0Cvqbh9vX61iTyfLz4x1EAbsdV5Q+kP8Q1G54Pttp?=
 =?us-ascii?Q?9383GtZZtTKf/rHeulEFGU8qC4I7fPvo1ZMV+szzkH34E4RtT3OTtLZ51m2+?=
 =?us-ascii?Q?GyFMktxvvbxC5fR6zOmDLQiiYIMbYJnbFBG5hfwP8jNndaeBlGwtwbTqijG4?=
 =?us-ascii?Q?KtfvNBuxdc4rtXOYDrjp+5Eo5fzU4bOyvDUnvZO3zeRYS6P4hPS3yYEbQa4n?=
 =?us-ascii?Q?V/QxZQP1zuBBOorljK4NFKZuWgDx9LfG9h9FZK66b8Ambmq/L6Gdyev5M7Nl?=
 =?us-ascii?Q?3u/heidhxUG4lgK4ClS3FdbZk/MjzYSN3Fa7j5FMZ817/G7ipUlV74W6mjFC?=
 =?us-ascii?Q?loh44Lp+RLmPFd3540o6QVchNY/V1FBAeiX/p1J5GiKc//o1SrnJM5I9JZHN?=
 =?us-ascii?Q?AFbC3kCcHxIHTQotaV8S0Ttn8dU2OIf3GeXd8TQYZAoNFwjw1wjlDTx8vBJe?=
 =?us-ascii?Q?JqMMO3Gv01VKIhCylRXzshwCT4r5LeLwqU98TGsoREb5DcLgadhiZBLxES0r?=
 =?us-ascii?Q?8EvNltgaRH/Xt7YgkHm7AGc2dssKg+g5ybNLPz+TN4pEh+1+K360y+HogeYx?=
 =?us-ascii?Q?qXu0gtKsYbAzol3kD5Krp2PV+7QGNfk=3D?=
X-Exchange-RoutingPolicyChecked: PhWL9sxLAwiXkfiAyKL7lR1ge+7fvPDyeK1/5nIQgtJ8BDY6hGoy4iENA6sF61bOntHbsPTNtZNTRXBpfNLJsctMwCApppabqDNpWiSX4+x3OAID3mGotTnpA7qSqU7bVKKeY3W/XxwA+jjmSQW1JDq6F3bv8lH0YvGj75NWwADXL18IR1HaEbB+szMjTjw9PkvAXKC8jQ2TcP/0ru4RWrBDGByktALLXzLWEBzLQhKYDeE5N+ot7YoRUnyLIkaxuUOPuHPj8twzQuM0lH89GhDvwj4GgHf9DBE75rkRpceDhrgRqwuQdRrt7vNm+cyHbporGHD826Kfsfzi+Th5aA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfecc8c-2206-44fd-8cdb-08de952aa4e2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 04:52:32.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XVEOtT+eYPXgKySBKrob5uH7l1pa85jFB2irhJw8XEMyJtYdJdx8stBjOS75Icfda56UZnoChcY+KlXCk76+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233752-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DE3643B6FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:15:39PM +0000, Shuicheng Lin wrote:
> When type is ttm_bo_type_device and aligned_size != size, the function
> returns an error without freeing a caller-provided bo, violating the
> documented contract that bo is freed on failure.
> 
> Add xe_bo_free(bo) before returning the error.
> 
> Fixes: 4e03b584143e ("drm/xe/uapi: Reject bo creation of unaligned size")
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index b70e8396e56f..6e4ebbe72952 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2342,8 +2342,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
>  		alignment = SZ_4K >> PAGE_SHIFT;
>  	}
>  
> -	if (type == ttm_bo_type_device && aligned_size != size)
> +	if (type == ttm_bo_type_device && aligned_size != size) {
> +		xe_bo_free(bo);
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	if (!bo) {
>  		bo = xe_bo_alloc();
> -- 
> 2.43.0
> 

