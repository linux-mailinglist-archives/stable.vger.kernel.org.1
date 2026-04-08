Return-Path: <stable+bounces-233945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOx3OzaF1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:41:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444E3BEFBB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7E303002D0E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B013AD519;
	Wed,  8 Apr 2026 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9O91mC/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42924B28
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666481; cv=fail; b=NNC6euI18GG87ChR/K8beiJgnnepo9aXVuZIAB/xJpaxDzWq+Tp8f/H5QdkZD4bZQc+TS9sb1eEMvjcKzA1rlbU9OkUOivGEN7rxZMEA4/4dwZUgw25e6Xk7VVSXvT7/4lB6k5N7dwP7wB9d/JH0TusNff+uzHMEpET8kG6/qww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666481; c=relaxed/simple;
	bh=8gVSdjndUUtQORPPyXSdOIZZHPkq2+DHMOnMCl6CnG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgoN6cgws/xgqfnMnA5xKq1EwidsH3akLul3lcpiFJjefIpy7/KzBaGCYiKFB4YqX8k7wIAh0XscDb+sD2v3ZmyYRY7l3SYNEA/2wXBBJCb1jZK8GiFoCbbXR8X9261ml/tukY5DEL5DMyYZ6Cs38WmZAq8TtetysyKsGAsQumM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9O91mC/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775666480; x=1807202480;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8gVSdjndUUtQORPPyXSdOIZZHPkq2+DHMOnMCl6CnG4=;
  b=P9O91mC/Da4o9Qq2GEgPy99tfq17UjopNSkP+zv/hVNQJmfxBaOcQ/2R
   25JKaKKjRC3UFOkWpGI5fxmUhkgL50RSMKsSiJO2ympWSQYf7KpAN4VzY
   wsOvdyq9Sh4RrFXUilUBjnRKeKsCE9SI4yN9mjHNSIPkALiUA8X6+rIIi
   mboAsGpCLvQdFzyts4ZzKWBoPf/Y5a501JSU2DoW+qMZFS686iHXcb931
   AavNPBoElzU+LdoNb75U77gyYCHrTlTphwJNyC/QeB8SSc0kyCLOOllWB
   uM80F1alia8mGXn+IQCTz6w/hyTPdXWNrrrHPOTzB4lPNaxst2vVNRzAt
   g==;
X-CSE-ConnectionGUID: 3WGK2PitTrSN4E2ssOOE6Q==
X-CSE-MsgGUID: O5gl35oQR3ubnJVpE1JiFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76547183"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76547183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:41:19 -0700
X-CSE-ConnectionGUID: O4uB3sXHQMuFlxuoCd4SCw==
X-CSE-MsgGUID: jA7rJkwuSiuYTg021IAvtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="223757535"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:41:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:41:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:41:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNN/WBylbTfPpqV5E+HtJdbQtlk/r2Q73OijukoAxu2oKTSCj0uuZGT1lWBcInBhcKTBeHxixR6zWhUNwJ4tYx9Euysm6mSZnwp6qWO1heYl9CfPIOw1yU0hnak/Hk8b1RnGd1U9gWoNhmDvh1mviqEg7Uu/M1FhNDsIydVXLZmydL4kqbMe7YjE5BnNVrQ9oXP5+l9qU3G1uz6xgeKySskrKQsGhmDEQWJD66okMaYpHZQzJyC+ZgUETr1jDGJwPnoIF0c2N0Yrh+u5QmFZmfnKkGFBPh3CoCtRrt5p2ZAc5bDaTFYA2XaRprkLOysEp2tquowdF5Iy+KI0DqwWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaW73NM2d9yYd5J9Qi9TW+kxNViQIB3KHcOwMBSrjsM=;
 b=QLlQ2ZmzND8HlN/zciuAx3uo9Srm3MEh4TYIqv+r78BjRmGaqZFwYLfioNReT/SR8D68sOcGgHT0pR45DN6iwGxJDaU7TEmgDDPlIsibUwRsf8+9CFQ8DuDN6+vaZOF8lJqpq+r5HBoBay0GD9898Z44CFt1/xD3+k6A++CVqjG64QmDv4EqokhZDGf4rQfOmiL/xWOnBWGXwJsWqAhf4s5UnU3kUbqgSRsHr7S8pLrjdb4GBPL6e2qBfSGFUENrcUt8wsRA5WhQnnS4/XyT0r/4wd+HBb32BYGZzRjsneADdjzOdcc05vOBtdRZYX2/b+KqmYhyOpyPCo6AgJ5x4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 16:41:16 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 16:41:16 +0000
Date: Wed, 8 Apr 2026 09:41:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on
 allocation failure
Message-ID: <adaFKRnqeKcLqYmw@gsse-cloud1.jf.intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-4-shuicheng.lin@intel.com>
 <adXhDcGmLytjuTUB@gsse-cloud1.jf.intel.com>
 <DM4PR11MB545631685E1E7994F737E904EA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB545631685E1E7994F737E904EA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|MW4PR11MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 853b660b-c780-44af-0609-08de958da748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gu0x4w6dhuKi44yOwsmldKR7Z441zVRdJmjnlJhus+6krWG6+FdUgRgjipg4Pp7jMxEuLQJa7PNJoLH9GU0N/hxRY4Kfy7FUZw6/9bIc93xhXcb8rElkOfSBpyWzGORDEIsVwzAw+SDJrjb/68g9j4wRVGq5LaG+45lODkZamy4mcn9yrGGeNb7L4bnmHxRdr0s4/cC9xIdOJK/5+pSBpWXY+PUZ+8f7yzbsTPIZNzfsexwP/BfcZr/KYkXTtL2Dda/p7OuYl+j8o4XKvjNr83jAFTainA1OMyEBVs+uTJ3e2usHchYP6xuceLQqTVmCIKiNGSpN06TbvTRr0KiJnUktVEYFsREdHY1KFBJcFJXR6unlcaiswxSNBOXN3FcA1Fj0KLURanYPhWPOsP7HVWwgxLPplrJvvHyYu+bvRUWjvCac5iuWjo5JIjG1vosXa6oDc87yNCl5cK3pxRvM8LXmS2MJwZqighreMIKEGvi6/be1XGuQ96LMD/BsDGm8ZGMnGINfaMsyWkgRqOy2PC+Ku2XNs0FnBAG+smJ6fgNXFuf33aXLieBnb3gnCOhk5nS3YQTnWD1r6BBq2UdPIHpmb0Ifm8ghCeKL0Y89edfnCbWTXD2ncMnSqXE2eSngEFVIXW2BJBCl87HpPOesjtgRVhFVEVlxWn24JRLTu8H1DnSAVvx+dLzKT1IZcXsn69WSxqJeApOdQaVvwlrYwazPDkhGmK1H1y/V1fPUU2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQOb5r6+l8irwwYAiLxuMZOMeU3KzMhIJ5s71k5tpm0trSq4tMOdXNxPK7ZD?=
 =?us-ascii?Q?V8alvtq+OJV/c3w6f1Q86720sfBgmOvJNwjm60CVOa0f/McNzdD8fMQu8dps?=
 =?us-ascii?Q?njfNlgg2Iuvv8Ll8fDHAksyDKlnUKquXP/Jh/yBNTKz9/ejw1AOAzt3wTDzb?=
 =?us-ascii?Q?FWq2Gnku3Ki1Kcnt8H4oSq5Zu9PhV1wRndL9coIv6PP874nBsREnHBecZK5e?=
 =?us-ascii?Q?8Vco7LoagAaDUAW/8tBk3K7AGiP/G/bi+MGkUZaNv0AC0KUtFyGr2rzg0DV2?=
 =?us-ascii?Q?XF3KEyxc9BgK0UtMMICxOgZTdsh4RSLawpEwOrvgHa74IPaTWwnwq2nwvCY5?=
 =?us-ascii?Q?BpY7z3UDsH9JH3qVlVkiJew4cbPLmnZ6uOoYhalLZBct8GFdK0EOODj8zvaK?=
 =?us-ascii?Q?5XQNO9+5TiR/2QjYNUXIhKz6mN/jA6dydNhaAVckBUor2gLBa/67LOGwj5B5?=
 =?us-ascii?Q?BIO1hGKGWsiyrZlp+N4xacQ6jOwMjcl395zSNNwiSVo8jwre2Eht0o67/Aif?=
 =?us-ascii?Q?V5Vu4pOToPAeIdZ1kt78JYafV38GXSkj3meFpmN8C1YoiSgXaVcARXjpndai?=
 =?us-ascii?Q?Jhg/zqCLRcErfE7tooIQPOqRFFo6SR5yvKJNYmLidcZr9HozlXgDJFX/pJ1W?=
 =?us-ascii?Q?539DHOyAq5XZH93DvoNYSvYrfyFEha2sFw1CzrcawItZsvif3FQECQRlS50v?=
 =?us-ascii?Q?O3yEqMqVtl1AUksU+njh0gY7MKhxqQtOOfMsx0/uDA+6fubfpGrhVG8dAoCH?=
 =?us-ascii?Q?N3E5EDI7IjfTthEX9QyXl0UVjYLj09isAyIxv89h9Yva0+7y0mVUmdXPzol4?=
 =?us-ascii?Q?3U60TC18aFxCb1E0kPW5GdLDgraiQFAvyj+13mIAj/TbXu6IGM/h+TBxHrP1?=
 =?us-ascii?Q?eQ5DvJgGXdHY0g5uirlxYRgU/r13n7tyEPBh0mfI68Z0KxRLC+fIjf2FN+GT?=
 =?us-ascii?Q?rPQky5krXBEjZhh5oFTSiCEocrLMNXmrnOO+iaeKsCELofkFRiSYwq7YKO9h?=
 =?us-ascii?Q?6UYoADFUezMQyokG23lz0ZhrYluvHqIhsLrYNxwVDgIhHzvZR3RRcpAsbDuO?=
 =?us-ascii?Q?eno4PdZNivHePyjoSO/BjgEiuFaZP/nDMpCFZuySduezk5cc39wLnfMYe1Sn?=
 =?us-ascii?Q?k0cgVKrPydd23SSKV7YMcFgaw1QFQI5DyW8EmH74ynRuLgzPw4OevqLkyqJk?=
 =?us-ascii?Q?06I4AdWwCgwqREgsnJ+l3iPRbc9cLWTEVOLcWBco7W3hc8GGxBsAkjVafL0e?=
 =?us-ascii?Q?HQTsWuvVWTPXybOBwtSIzMRln+szv2IbKZhlUkjrbLIXK4ELEEdLzBqyX36Y?=
 =?us-ascii?Q?Ic+AoB79n/FK7EmLi1nJeA0ZRaPIMfL04aDs7eGahdSBHBYDBWAbL8THZ5oH?=
 =?us-ascii?Q?0Ey/2dJbpdDi+z9EAghVc74W62gVNSw6cQom4UshRaWFxHkTM8FzPwLkXa+E?=
 =?us-ascii?Q?/lkfvmU6IfQUa2XDBLsbnUJXa0AfVcA8WQcJRWQLwHginGCGsrCsHBihpFWd?=
 =?us-ascii?Q?37lncZkSXwQT18iyqoHKAiC/+oRidX9tWqoWciLt8ETVOgDk8VPjcoazi9+X?=
 =?us-ascii?Q?LKVY7ZsZUWW/1blNIONOlYoVsaofcNmCp0mDjiPojFwzOYlkIMU7hOfcFQvm?=
 =?us-ascii?Q?31XIRY3iUnFjsLimJklEy9+4/41T5oXoelpSGo9lBazs+V4MLmUyxITrv/8h?=
 =?us-ascii?Q?MDf5kiJ1c86yA76VtxkZOcpPMz/qSjCMuXFjq6O6Np1L43Ym8lqinwelgvO0?=
 =?us-ascii?Q?MVHarXov1A=3D=3D?=
X-Exchange-RoutingPolicyChecked: uYLBmVdTuw+lQ3NLklLhYx/kyhCSF8RYf6v3VqOxNbXmuPkdbalRtMnX0QJALBtSg4CrrZwBb2ZjG3Rwb/3Wn/pHiwkPEjwiIgWFe9nPuq1gSQ4SZhz4kHC4yQv94vUPTOR0QijI70ftNJHV8aFIUmqrWJOK9h/WJqGzsudFOSs9OrggqGOawQ8RTTS8K3WmGkhRFQfCSzltOBxnek0DdympZa14eOIu+SbtJOxNjg7c4P4ToUj04u40w5XipqCxi5eZvbt8MKNKq3+5ZrLbj3n8yHWsyDyY0TYwvbWvei6HIj3wb7OacAyg8oFS3Z+AHkYeBdpm+B/PRPy9Za+32A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 853b660b-c780-44af-0609-08de958da748
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:41:16.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUOWGjGubgBRO5kikNCoDY0pw5x5z3zKBnj/b8ZDQ5iZxYACmKfq1De77P4XnfJImqCbe0mytEuxUCds1j4Tyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233945-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gsse-cloud1.jf.intel.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0444E3BEFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 09:58:06AM -0600, Lin, Shuicheng wrote:
> On Tue, Apr 7, 2026 10:01 PM Matthew Brost wrote:
> > On Tue, Apr 07, 2026 at 08:15:41PM +0000, Shuicheng Lin wrote:
> > > When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
> > > is not freed. Add xe_bo_free(storage) before returning the error.
> > >
> > > Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive
> > > eviction")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_dma_buf.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > b/drivers/gpu/drm/xe/xe_dma_buf.c index 7f9602b3363d..24d9d82426b9
> > > 100644
> > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > @@ -271,8 +271,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct
> > xe_bo *storage,
> > >  	int ret = 0;
> > >
> > >  	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
> > > -	if (!dummy_obj)
> > > +	if (!dummy_obj) {
> > 
> > I know the comment at caller says 'Errors here will take care of freeing the bo.'
> > 
> > But I'm not sure that is right sematic as this patch alone won't free the BO give
> > this line not seen in this diff:
> > 
> > 296         return ret ? ERR_PTR(ret) : &bo->ttm.base;
> > 
> > So IMO we make the caller own the freeing of the BO here.
> 
> xe_dma_buf_init_obj() calls xe_bo_init_locked(), which frees the BO on error.
> Therefore, xe_dma_buf_init_obj() must also free the BO on its error paths.

Yes, right. It is easy to forget these consuming interfaces on error.

> Otherwise, since xe_gem_prime_import() cannot distinguish whether the failure originated from xe_dma_buf_init_obj() or from xe_bo_init_locked(), it cannot safely decide whether the BO should be freed.
> 
> On success, ownership of the BO is transferred to the drm_gem_object.
> 
> How about add some comments in this function like below?
> 
> +/*
> + * Takes ownership of @storage: on success it is transferred to the returned
> + * drm_gem_object; on failure it is freed before returning the error.
> + * This matches the contract of xe_bo_init_locked() which frees @storage on
> + * its error paths, so callers need not (and must not) free @storage after
> + * this call.
> + */

Yes, that's good to avoid forgetting.

So this patch looks correct:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

>  static struct drm_gem_object *
>  xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
>                     struct dma_buf *dma_buf)
> 
> Shuicheng
> 
> > 
> > Matt
> > 
> > > +		xe_bo_free(storage);
> > >  		return ERR_PTR(-ENOMEM);
> > > +	}
> > >
> > >  	dummy_obj->resv = resv;
> > >  	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {},
> > > ret) {
> > > --
> > > 2.43.0
> > >

