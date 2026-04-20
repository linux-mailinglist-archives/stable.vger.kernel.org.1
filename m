Return-Path: <stable+bounces-239997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCEuCLqM5mmryAEAu9opvQ
	(envelope-from <stable+bounces-239997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:29:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446E433BE4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7741F3013852
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD93CF677;
	Mon, 20 Apr 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNKgt5AQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCD3B19D7
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716983; cv=fail; b=Gp/zfQ+k2BPead09ERlCmYo7CooxudSb9wW6x5CBEbgLePCtlXWStARekCiSh6xtC0XuzrPoFfXtwhY33GdPoxwgsqH58QOieFzHsm3Gww66m+a3dPxTbubfzYPHyTqRJ+nvfHtPVootd8ZU33mA3KsgeEi9Lp18gH4U/2FexPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716983; c=relaxed/simple;
	bh=WdbjLHZLYi3TzSscJUZuzOWrVJay3b4tI1OYeOGOuu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amG6JC0B1wpLhJHvPx7P3XTAUl+ny6uGOCJUq50h1kAbgKN7576kfPub9dR5+Tb+0psTWIJgIn+bKt1ozqEwn7K28L+FlDoB8a5GpS5H0b2U7Xmbyda2xUcG5yMm4qS0M/nkrI/dFJTUpyzRC3peG464otV+QkRcwXW455owYJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNKgt5AQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776716981; x=1808252981;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WdbjLHZLYi3TzSscJUZuzOWrVJay3b4tI1OYeOGOuu4=;
  b=UNKgt5AQ6nV1Ewx7QtdkMNVf5+t11IPxPEOp1v56WjLTgJv0DciVKPe6
   G+CmCvACg3OfZ22DFdb2VrhEwIZTMOwHQQKmKjH/fyM5zyaub/79U4r4Z
   Nr2ZPgHGfC1kHXWZyfGXJn0Lt9eRoMei0viea3QUrHv1OfeC/ejQ7i51V
   VhcpC6jiWg6tJsBQ90fdqWlIB6Zh9CjU440Gk49BnRoQXnfpz+5iT7rwI
   mfkzQY+XbECba8C8pyvoYk6I4qwHeln2ezLtK/XcSozmp/KQXqKGAncnj
   I6Cy2w9D/jV2nLeOgv/T5D0pYLovVAlZMN4RwMOUPU+/0hYftqUbGW2rb
   w==;
X-CSE-ConnectionGUID: dF4GKo8zRa+/H8DNcVPBRA==
X-CSE-MsgGUID: dfN/OEO5TxqxXdq3/l8esA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77513046"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77513046"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:29:40 -0700
X-CSE-ConnectionGUID: K8JWN+1wQmW6Z83GbSCyuA==
X-CSE-MsgGUID: OAwUhtHKTjOEd+H7ni+vyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="231700497"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:29:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 13:29:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 13:29:40 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 13:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLy9/0lMe+zvQZCyY7fua9m9t0ses095mBv5/V3yt+qQOzeIqcsIdFHSVboijSMSjdp6Xkict+WI5GrI7VEmwfV6GaSTM9arj7yk2KjJd3zC6l9E5SHzAmlKFumIM3Ow9vSq9iDJ775T5Sh6NqoPiCA0GYplYeQm1zlkAGxZK4sQE4ijO1CAIPgklLDC9hQ1AsA9Hh7OhWtjBgBhapK/AVHlHoiwqgOgLGkkUYNLI2yXQnZJSmqQ995UR9lODwAWRMbgE4cInAG6D1KyxYTIQY1CtHJFKtF8Gd2Y9YMcP4k1LXX+KBcHX61SWXXck+0D/Fec47ogmUbYxOwact5RGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB+z9Lk9VfpV/fjnxCy+7vksB+14Sjb/dL1MDN1PGKo=;
 b=TqQ52tToj80nfQeyEsDmZMWXm2HkwcGokSpLTFx1UQzshjl/4i43843vod8HWl+uqLeJ+2MiqMnjYcaagX5phpjC8oE/x2dumpzViWRVE+AilIZI16/LEg/kvX+i9uT1LUT88pPMsuoHWvp411xXCqiJ9GPzENB1iaqcNkAGampQzEbtzNG9OC3AK9QlzRC5EmYHGznQ+TGwFK1EqRffXUNXGOF6y7oDhlqRrfPBg8BuUgAQtJTOahtJYRKBe2LT5bBt1xzQXo4GSnBZj7gVD60h06TB6YtaZWcEcc9pIvjsqL+bQ7mJGdSvwsANc99nJWz+EhRBHD2bZDuy+1jGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by IA1PR11MB9517.namprd11.prod.outlook.com (2603:10b6:208:5b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 20:29:35 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%7]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 20:29:35 +0000
Date: Mon, 20 Apr 2026 13:29:32 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
CC: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	<intel-xe@lists.freedesktop.org>, <kernel-dev@igalia.com>, Matthew Brost
	<matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Message-ID: <20260420202932.GH7476@mdroper-desk1.amr.corp.intel.com>
References: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
 <384adac7-2aa4-4568-b7a5-987e914fbaf2@ursulin.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384adac7-2aa4-4568-b7a5-987e914fbaf2@ursulin.net>
X-ClientProxiedBy: BYAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::27) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|IA1PR11MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: af882584-c2c2-40b0-91ec-08de9f1b8943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rIrApsdHsuufPGtJPxzhbNYXLE8/IGPaGI5fg1JRcI8jnHvXn2YYawFclFUDEr4GgXv4HrZalBWZEXfhV5TwGszj5GdXbHH3Q1dnwbS0CDZJRbPMKcCtIR40IM8S+9itiWb+oDQsxGE9aMpnKpP1o2MrJqWAcnepbXD8v3IvAokZdM0RQyK4Nl8vCCMUoQvaUU/cj3oiOJXT0BKpb3rH9MhTi52UWOvCqrCGJukiebTEyKCWN/UrHutuztdwIIBrdi31DO4xEfVWBpEfzm3+ZGxgUbuqdGTN/94zujc3KUt4GaEKT5RnN7f8IcxoIK8RuPMxbQSv5fyjgJkGkHZOG4sqtLKdPlqYyTjQTEnNTtVkAC6T0e1z1AD8jnkTnISRMp0WBZYZqKKj2oeBD/0EJg2Y+jgueiJT2QMuJXerMpBJRH5kZutAz2eW33S6+1vOkaHOd9+NlfthrkC1vjXyD0upyfBkIGq/Gb4Hx2hyP8x6rbz256i4QQLy6g0bxmb+TG0W73R/zFZHbGNCcPth0iWC5jf2rcW5hy3zlScNXCI17bFWGXCuTq4+e2U4jY6luOB/qEYJPisQbk3PD3GUd5jkf0MUkApPXHOJZhGtWbaTS2f064gVp4WqIHDF1FrgrfeG7Cg/aPFbmfeYcZ3YMugOkSFdV0Wk0fTG4ybKkqMmmwVYXjSCNmhqHd4Az70ZgWuHFUEegN+Ie45+Ia8IbKKpL3o0jO8Z1FjF+2prHtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TLmUwkL88ZrqyO4Pp/RqVr5iHO/zwBgiYQKWLGsWgzsroIBaCngwSm5kuV?=
 =?iso-8859-1?Q?DD69TBIcrG3JpBFxZq6yS3fmihUn28vo5jtk5gKKEsqsVoyc6d0JmuBiY7?=
 =?iso-8859-1?Q?5GE1l45yha9GOr+UdsKEhbZWuV93sU7ry8sheiaWtZm28woW0IxMcwB+Vf?=
 =?iso-8859-1?Q?ZSHa2vXNpPmYNGHv9mGUoMzGCLXUvIB15eEw5ObWpfBEP0dvI6CM7HUOtZ?=
 =?iso-8859-1?Q?ClbTcCozZvV8BA0+xIKOeA7ButPK15rMpllSVRrRaBAEWJl9+Km7h4jUkz?=
 =?iso-8859-1?Q?55NZsnf69tr/NDpQebYuXiTUcAro6gydaK2cmQN5tLk99Sw8kUEjx2sd3s?=
 =?iso-8859-1?Q?k01Ur6M09VPjL5iqHul04SlkkBUxvFT2XW3SVBP26Tj99TX86csdDGxadd?=
 =?iso-8859-1?Q?h5pEU3oc/0/4rXVMvkHbTpDu7chfzrZ+FFRP1WzOB2zx0mg4gtdCeKt3Q0?=
 =?iso-8859-1?Q?3PKJoz2m2gItZoYUQms3J4Odu3prLPNfr/RUNx/hIrANshWzix+xd2VUcb?=
 =?iso-8859-1?Q?VPfzk7x+8bL3+qEyjEbbVzOs986w7bpXIN0BTzteJW8dqsgGizQU5H/z5B?=
 =?iso-8859-1?Q?qY4FAlviBKxZeKXXPdjHUo0GXitIuudJ0hyhoDBwo8FgF+SMVripIsbuMN?=
 =?iso-8859-1?Q?CWwRrvaUYe5WdPcQ6jITlNOoRJD/0DMJEywJtWZ6siXc7jg4OT4BNnnNYS?=
 =?iso-8859-1?Q?5VWEUDR0PXgPlJq+sCH+Wz6mHUFlHvCrKQhMbFHo2jSuow9UvcWRFwzRq2?=
 =?iso-8859-1?Q?ssY0KO6KFbTPP5fhFOCYHq5m/AmRhlQRWv2clQdI6+oZD01B3Pfl+eKGIN?=
 =?iso-8859-1?Q?6QYNnc1tunw5L7YGUJwZCOacIkD08kfSCgsv2FAXeXvkxETPiciE2ctCXk?=
 =?iso-8859-1?Q?oTMvtpym8aIT72VqRrWwojiOUN9CoTCPF1CWB4FHd2AtsIfpZZzdREuboL?=
 =?iso-8859-1?Q?1JCGO4slY4tg7/HUljQP+YHV5vOp3rR35pIKtRtsLJNQrAAeLWaGi9m/R5?=
 =?iso-8859-1?Q?I9Y2noiS4qUIc0mRXkxRGi9e89uEZPDwNgbAII/3495Kuu3m62/CeQgRbM?=
 =?iso-8859-1?Q?JmMU+wyeGwXEqSPLnJUl3GwUuZEucaEILb1y45HTtnckjG4Y/thb/lfayr?=
 =?iso-8859-1?Q?O+u/K15/abNQeltxRtXeu9heBApG2wgDyZi8lW0I7ofxACUuLATb8l/pFD?=
 =?iso-8859-1?Q?By2Rts3RE+3y+6kFyFZGbjt8aRwl0yLAkSrb5MPC96kjzx24t8dN/cvvHZ?=
 =?iso-8859-1?Q?J87RO6J8udSqJynDAajJvXFgrJEKoEe18rgxpLIXE5BpJYTyMO41pX4p00?=
 =?iso-8859-1?Q?lFe/guzXY+Qcx5BzO2R+gZdN4rCsLKzVqy0xba171TK0//e7b9jae7NhAW?=
 =?iso-8859-1?Q?hpXlU7zTMNnmc3o8o/1lTBTvZTxiexnQaberuZjg/mu663Gfjd5HS1zMs6?=
 =?iso-8859-1?Q?555HbMs5x4Umf/IMZdQc056I84cb4L5LzR30KNv+QFWyoJebGcyFquB7dm?=
 =?iso-8859-1?Q?cSgWVAGd4J5Qg8O1HSxbeDHpiajNHwg4HBv4ruqE5oirMB8D05gDXkvnaj?=
 =?iso-8859-1?Q?WPl5O1tYWJ+yM5TDo36So2K+ZK4FIBEi85KiM2KVRfRKNqiAtnhLOpwPXE?=
 =?iso-8859-1?Q?YdfuVrQLpYDfNjDWQ7Ma3Ve30h27PQdPHvOT1dNzgl4oOSL/uSUp45aMDc?=
 =?iso-8859-1?Q?5JUoTITOzLuwi5h+VmInoNtiLxQbw5cMKy2yk0ZwnVPHIw2M4Eb9/WzYlo?=
 =?iso-8859-1?Q?GGJKCcM+zwOMKY8yWdvXorHM+jH7XMZufjt3ofGgMmWKodaiSLG/yAK509?=
 =?iso-8859-1?Q?mg0gG3MrxTkDrncMjA3Zh02D+QQsYoI=3D?=
X-Exchange-RoutingPolicyChecked: KVjZX1jhPEdVf3kjzulXHkdYJ0penYCzQjschYOLAzxVrP3PIkWLc2g4RsBGUqiKKW1msMRwKR7OyERdgUhR+tEFsGVm3tUYKl/8P3mQlzal0HWQJ8zu0A/PqUNM8/Jg+DPEm3INEVEgU/1a9fvdSEdXKkUOeUrsJpPCfZjBUf98C5MyNvyEdNJnB14jNolwBL5AaZw7CR5W2VHD+Q0a9SGfSKmuCm5K1jw/o3nXprmdRH7ev1JP9aUIlVii/SEhr1XuCWFl+tqoFV6W67+wK9TbJKvgtC8j8MXtTfc/n/z3T3R5D6+7OaW125lUUMgtROxcImIKJ4icHwONTMRx5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: af882584-c2c2-40b0-91ec-08de9f1b8943
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 20:29:35.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTjEj7+GRhLlZHk1MjVVmATaBp7l3rNnU2vq0UR9C2M0CcpT6lvbOXeS/qJRamYphoUE+gKoGtcAgQOK/6ChdvXbvuhktShC0WGVIaRsbaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9517
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239997-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.d.roper@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8446E433BE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:24:05PM +0100, Tvrtko Ursulin wrote:
> 
> On 20/04/2026 14:16, Tvrtko Ursulin wrote:
> > Command parser relative MMIO addressing needs to be enabled when writing
> > to the register.
> > 
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.18+

I don't think we want/need the stable Cc here; this workaround doesn't
apply to any of the Xe2 and later platforms that the Xe driver supports
for users.  While it's possible for developers to manually override the
driver's detection flags and force it to load on Xe1-era platforms that
this workaround does apply to, doing so will taint the kernel and we
already know that a lot of Xe1 era workarounds aren't implemented.

> > ---
> >   drivers/gpu/drm/xe/xe_lrc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> > index 9d12a0d2f0b5..c725cde4508d 100644
> > --- a/drivers/gpu/drm/xe/xe_lrc.c
> > +++ b/drivers/gpu/drm/xe/xe_lrc.c
> > @@ -1214,7 +1214,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
> >   	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
> >   		return -ENOSPC;
> > -	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
> > +	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);
> 
> Or if this register exists only for RCS would it be better to define
> CS_DEBUG_MODE2 as the absolute 0x20d8 (as in i915)? Unfortunately the public
> TGL PRM does not list neither the register or the workaround so I am not
> sure.

CS_DEBUG_MODE2 exists on both the RCS and CCS engines, so I think the
current register definition is fine.

Personally I might have changed the line farther down to
CS_DEBUG_MODE2(hwe->mmio_base) so that we're using an absolute offset
instead of relative, but adding the MI_LRI_LRM_CS_MMIO flag and passing
the relative offset should work fine too.

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>


Matt

> 
> Regards,
> 
> Tvrtko
> 
> >   	*cmd++ = CS_DEBUG_MODE2(0).addr;
> >   	*cmd++ = REG_MASKED_FIELD_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

