Return-Path: <stable+bounces-233958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO0YEGGT1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:41:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B363BFBBB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C8D3007891
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F63D6CDB;
	Wed,  8 Apr 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBoe0/bC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF6325483
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669898; cv=fail; b=SnFxdQPpEaeEbcxLzX9omhsDjz7MiNAGUzFQHtQ/638mZDQt7qz0kBl6lr7TTCD8+A3L+WA2LRNHNEhc7W1pcL0we/l8wPjoJ+GoIc4jZaXvtEqDaLudr+rbpIDDcMGhZQF7AtKlavCQMHX8S5ng347gqHtXGNzP8yKV7iBQyiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669898; c=relaxed/simple;
	bh=s/AkbNKPvRinK44Hh20OOBW9luq4ul8KUiZmYX87wlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iIxDOhj/mIpSTzyBPYlIH6tSZjFXClvsQ/vo+d7jEWjHUtIZZb+XPZLxFWrxbi3bkCMsku9xcbwbvdjsYrvPOewdUlR/GYld6GZzj+KCnSqnO1tV4cDZT8W5zXX9LN3t5NBqtz4QIkznSwcpoyq5BDEEXSEN0cStO6l125vVNvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBoe0/bC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775669897; x=1807205897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/AkbNKPvRinK44Hh20OOBW9luq4ul8KUiZmYX87wlc=;
  b=nBoe0/bCYYHQ7FfYEynsR9eLyu/E3a8YF8rkds/qipN+I7jBHyCRHJGd
   2FHUQVOcztc2V+uhkLPRlSFtOYS9NRf+pzQFlSp7huew6uzGRPzL1CJWS
   g6Ph1OLmDms6sQBrakqVysGCF6lXRsAFfZvafsMqdLeqdMS284sNscq2T
   pkYv2O4Si1FZ69F1wAl4FPvhFxNjA/arqtsEworW1DHX837mND88h3vP4
   +gIVvnde98MsBe7Ob0XvoyQd8dkingbhW6DDT5s3j0Dl5ekTuHyPiwd2Z
   9EGwOUzrvCjlA51GULWKRAXoDq9VMqNn3er24FnzO1MWcDWq0DgiTSK3e
   w==;
X-CSE-ConnectionGUID: LInX8cArS0Ogyqz1TzeZMA==
X-CSE-MsgGUID: WYUFASlQRlKGZq7ZoRYZeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87739224"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87739224"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:38:17 -0700
X-CSE-ConnectionGUID: diwPOuUSQaigAnzQ4chSEg==
X-CSE-MsgGUID: rmzktML9Rle3s3BT7jlQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232905830"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 10:38:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:38:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 10:38:16 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbRcGJ0yFx2V5u1KRXC1cnuP2baT4m/7kIGuithXS+gMW97wxnWk+xgBHCpfddenw6JJ0foQGJ31cNCZF7ojG2rv612XT8HqI3fgURqhB1MSNtSr2Clq+bxwhGJ4n61zHdmYnf7mcjRRASltjrGGU03jq7fxbi3bWPEBZMer4Q/gVvaVv3/i39i/z64T9bQaADqodmWQ+uOBrwhVp0yDEVGbZ1Vo6BXBr38k0E1GGqsq0WSM4kXjx0qF/qKRoTPU/EJbs4JAq6zI/qXVQcnQlJaxAEnCUMFUhOAceiYI/y8Svi/EFeKXWuifBSORdaDd0r5HoAs6d2QNbE43omR4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Sbur8zCDQ+3c/vlxU9pXzcH0OSneUC5HKWL6G8+uE=;
 b=L48Sj88dloE4VJAgcEweGuynm02Y8THkTX92F5wMJT6T2QIzlvrBBwBWx4u+/D73/GShmrBw9yXarrDRiF8emZP8qILi7SR4QgE3ZzhSTBdqejEtPkrOuFSSj3OoLjUFyedznQbRGORksbOsBDzUD0CKqGl5sY8fdAUIWICkf3TmdCdecfOsNh7s6MLd3d7j28yfFws8PHTBCFYxBh0uii/aYB1XDZanEWIeWYnVcO2GAB9q+D/BdeTZUlAa7dUAsa9Zf0AGP9qrNfR98ZS5DDhMb8W4TiB2xY1YVFKO8jdsurIvUF86QrKUsqfE07dRt8D1IFhpHC0f0VSqBgTveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 17:38:11 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 17:38:11 +0000
Date: Wed, 8 Apr 2026 10:38:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/xe: Fix dma-buf attachment leak in
 xe_gem_prime_import()
Message-ID: <adaSgCBmcCIx2TWn@gsse-cloud1.jf.intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-5-shuicheng.lin@intel.com>
 <adXh7FdAxseknVxX@gsse-cloud1.jf.intel.com>
 <DM4PR11MB5456628E393BC1D7A9BFA59CEA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5456628E393BC1D7A9BFA59CEA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: ce515b58-fdea-483c-c7cb-08de95959ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bv5onPrzfGmMXgtvgnTQeXwR/1WWBjvCDhTYLt+45xaErbbeyLEf+dLSYZpFqWKCO5LO8LgOoKhbx3fEAoDiyXyPqwBdlmWwojHet7QtLMx05dCxNkhfmLh0YA7mh+TWePamfeZb35iM9pEH51+zhbWpDG7vM0pzBe0sGO86y4RnoVdOlkzcg/fzDK4m0hqPb8S1mxVHLW0/2a+6RcR+MjLnOqzx6nXAuwgaGrnUeGRZn92scTI0/gnKKQmtw+tpDyC7xhP5bjjfp519KyrS6NTU3WSMqCewgPc5uFl32PAKauf2be0Sz2dc9DlIlbFf3Yf8hS3x4zZNh0Hp7fpdq0njP8btw6WMfWyQR8rGgwEjYb3vidPow5V0+K1mHHcADcF8kgr/i8i6ikNQP7a2tKOmH5keXYn+9HEemjlx5HL8MH9gZSNG6qOj2pVZw0HlKaWbRRv7KhQmT7zS4jh9AIIWVhINMjrUyIWP9mUQHsn12VJPYOvXGfbBXzsCkqQpi5k8aCy1yyW8ipqMCg9xTJSO4yvJsaC5oPuu/ZenpoSNU75C87yng93i4VUd+wswjYdMuk/bNtmql6D7DPbXPx09SlNXdX+swtsP4nuvabDqu2IeUtxgEF8MtyUvQLxNfNaQYpS7VG0SUAATQdldGiqykQKuwEgN3442yd+2320foJbTq4mvbVhgoADUboBc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?olGvZS1aSIBHYd5KKDi93ymJufEB5C7yqOHy873yWWO6W7L5UdnCieGZutRj?=
 =?us-ascii?Q?A3NVI6rJXEn+jtbmNUZFIr/sCyAk2M4AB55swElGHJsSASmjgkTdOaQ9S6gy?=
 =?us-ascii?Q?v3zIU3oeWJ/nQ/Pi8B6tTn+RnqYiku7ofU3jbqLAgO+eOets4OfF5fmYH/2J?=
 =?us-ascii?Q?IHqWW2OPmdCyEfhoWfrpYHNJwc0YoXVpQsDg9REWZshzc2ki2pQrYRZYln2M?=
 =?us-ascii?Q?HtdQL7jExHkSMYZLzhf0GgLpWrBDUVVJ+ZodU0YIu3yMgk6OPGzUMaaoFmHr?=
 =?us-ascii?Q?Lw0DBdiJQ4Gpt4r3lRExx+d4e+WQfC43MloR3rs2Tg3v7TQArK9e19nH4fhm?=
 =?us-ascii?Q?3a7sFOw2XG4Yn4QhTgufOO07Vvua+R3DRir240f2pfglbZFlwAvkhwi/sxJF?=
 =?us-ascii?Q?O65tBxEY2nvBU9HoazVcR+CXySA9OQaOVMyl4JeYsnjvRucUnltgJ5WtR0mN?=
 =?us-ascii?Q?bvvvJH/b6/jEtgIUEnPfmhrWEqZ3l4/LtqGQFckBFgieao2sHD9+vWr65DWN?=
 =?us-ascii?Q?xxJCkdSJgKF4f3+liD5xUzjKvAx5O8sfxsYpC9R9OmNTTYKBhojrPdZ3jD70?=
 =?us-ascii?Q?spu12AuPPk2nnHnlOey+1+Yee7uRPO12VtYC3+wZE9u3CNuRvl2wXPcHGpL9?=
 =?us-ascii?Q?NItC3GuQw/NEAN+teq0nHEsbBXD9AYFeu3j2urcd6IpRAwnJPPpB1UJiKkWg?=
 =?us-ascii?Q?M0meI7wK8JS3U2HwC+7Wv0KoBwRf/GNPAT/N2uJkzztLUDqYlz0PT8AvwyUv?=
 =?us-ascii?Q?yfd1S2uVUy+UdTTf35+IJRzXmVTz6tOYGNQRdHBI0apjEIr97GNW5rAkjzCP?=
 =?us-ascii?Q?gOw2s5QuMyutXLkGlvI56UOKeOnYahtgj1fq2DvtiligWWvQeOho6CTL9+Ga?=
 =?us-ascii?Q?wxh929FPzOKMvdefFFy7+EhTWTM5uGgLLdBvqCUab7SSzGWvhpdzXwk7j3uE?=
 =?us-ascii?Q?IfZqep2weGEyQ7pqm+2X5ib/nelRRBnt8MNaBaqhPtQlwVCJKbWflZV2Dfg/?=
 =?us-ascii?Q?ShRiEXwkw9OtpIaaBWebFrh41Hu2dO5V+av2Wkm1XEyw6E7wwQ6W52ihB8Il?=
 =?us-ascii?Q?Cpxfz6HmQE9XTxNeq20GTAeRsBqlTJDGxPUsmEKmqN7RfYPAz8MIRwxmwuCA?=
 =?us-ascii?Q?UDOeU8kXmMrkblM4EZfKoC+FWlUznSbRfUnB2C7tCVzUda0+wBtnSsILQjnz?=
 =?us-ascii?Q?srRxLIKP2Du8pJeqfWpnzeGPbITky4rGlGBC/11rQCDIQqrftxuVD+86zXcI?=
 =?us-ascii?Q?sXZLg7jRL2OIKHSbn2lJEWG8nFPPVCpVmdXH5V+CQe4j4iGjKmfjElYE+ul/?=
 =?us-ascii?Q?OvXE4euQX7TUYQcbxX1TM5hdxblVnzKyBEmAWAo/b7XTpfaRWdgSUPIdYOG/?=
 =?us-ascii?Q?fDKSM7GinzG1YdLY7R4feKzMmwwukIbNl+YNyzfrnXJDh2tcUK6I+bDJQ5zB?=
 =?us-ascii?Q?ksG613U9/UfQlYTmrdb0+h3DW0WdAQFIu7WrZ9+efr0E3UvoFqbijADpdmt3?=
 =?us-ascii?Q?1KKxHw0j3QKOs2LrWfrzY3PGjZ9RmbxRCvJPuVp9w/I0FmxYTqkl8q4fx46c?=
 =?us-ascii?Q?7njzR+ac0zyB5dqu66PvHYwakfDjv0bBZxCCLeuM9QIftWSdnkgDrgOdItrn?=
 =?us-ascii?Q?uZKI8a8MZk0NWFUnGqorunVFKufAXl/chMwwCNy8ArXAvqvzdGJtZ2zefXkE?=
 =?us-ascii?Q?Bt3qZ3NHAzUuXU+y9Sm8tBCE9xeLI3cEqUzjVCp5ihq1Ki6ka0XDZC3AXq2P?=
 =?us-ascii?Q?QX7TTuvuXA4KDfl4UEduXRdZ7Ft388I=3D?=
X-Exchange-RoutingPolicyChecked: Qqa3SdAV3kIBIVCyZtMSHIHoQXPlG7uwKl7WTKrwk40h8xBX/qvdHYx2XeCjbDP6YOXo081rnUKO0VuSlqzmLv1MFqSnDPO7OHHP+FcCJvLgZcM+upW6r3tNhJfGQL5G5+7Ui76JsmMi6vmcfyUrs+8n+7d5ofxeSyYHAWHszhts3RgtTdGqtONhfWUrGxyv7jMldD7cZ8AcLJfa9v3bWjJsHUyqcHNkz9KRvgBOt61pTPdsso3bEmntTek9QxOwi7Zv6//nSOjOVGqz96gB+vewroc1Ud3kzJxUv1Mq1xvPcRu0kwaTdkvoFHTMAlRIim/dJBKA900RSdiYz9884Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce515b58-fdea-483c-c7cb-08de95959ab2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:38:11.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt1bdCg2sDjzEIRZa/CQ0HDMVF0KvOSmP0JYeEiAdz5N288VzFH0rminDc4zVDCq6SiQY7r63FtPnf2nwXwylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233958-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,patchwork.freedesktop.org:url,intel.com:dkim,intel.com:email,gsse-cloud1.jf.intel.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B3B363BFBBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:34:28AM -0600, Lin, Shuicheng wrote:
> On Tue, Apr 7, 2026 10:05 PM Matthew Brost wrote:
> > On Tue, Apr 07, 2026 at 08:15:42PM +0000, Shuicheng Lin wrote:
> > > When xe_dma_buf_init_obj() fails, the attachment from
> > > dma_buf_dynamic_attach() is not detached. Add dma_buf_detach() before
> > > returning the error. Note: we cannot use goto out_err here because
> > > xe_dma_buf_init_obj() already frees bo on failure, and out_err would
> > > double-free it.
> > >
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > > GPUs")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_dma_buf.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > b/drivers/gpu/drm/xe/xe_dma_buf.c index 24d9d82426b9..7702a6bdaae5
> > > 100644
> > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > @@ -370,12 +370,15 @@ struct drm_gem_object
> > *xe_gem_prime_import(struct drm_device *dev,
> > >  		goto out_err;
> > >  	}
> > >
> > > -	/* Errors here will take care of freeing the bo. */
> > > +	/*
> > > +	 * xe_dma_buf_init_obj() takes ownership of bo on both success
> > > +	 * and failure, so we must not touch bo after this call.
> > > +	 */
> > >  	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
> > > -	if (IS_ERR(obj))
> > > +	if (IS_ERR(obj)) {
> > > +		dma_buf_detach(dma_buf, attach);
> > 
> > Based on my feedback from the previous patch [1], I think we also want...
> > 
> > 		xe_bo_free(bo);
> > 
> > Also unseen in this diff is this code:
> > 
> > 365         attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops,
> > &bo->ttm.base);
> > 366         if (IS_ERR(attach)) {
> > 367                 obj = ERR_CAST(attach);
> > 368                 goto out_err;
> > 369         }
> > 
> > We also need a xe_bo_free(bo) in this failures if statement.
> > 
> > Matt

^^^ Ignore all of this. Missed out_err calls xe_bo_free too.

So patch LGTM:
Reviewed-by: Mattheq Brost <matthew.brost@intel.com>

> > 
> > [1]
> > https://patchwork.freedesktop.org/patch/716820/?series=164476&rev=1#c
> > omment_1319810
> > 
> 
> As discussed in another email, could you please help me	review this patch again?
> Thanks.
> 
> Shuicheng
> 
> > >  		return obj;
> > > -
> > > -
> > > +	}
> > >  	get_dma_buf(dma_buf);
> > >  	obj->import_attach = attach;
> > >  	return obj;
> > > --
> > > 2.43.0
> > >

