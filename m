Return-Path: <stable+bounces-233138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBANBHApz2mmtQYAu9opvQ
	(envelope-from <stable+bounces-233138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 04:44:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C290390703
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 04:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E35A73015ECC
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC658346ADC;
	Fri,  3 Apr 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgmKIBf6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A9282F29
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184234; cv=fail; b=ZN0IQ7ZU2CW36RM7dgBIFJLNBJm7AB4SE+x3IibIUyblL8vVNg6ytEUsM0IQqPn2SfJy85AdTkGiJwXRuPwHHzR2Mbt+y4TBSAkF1gFItDaNAlxYtOhYOpBJkOL5mFG/xsaH0JOVjzl8QTOmMFMlyJMGXNOaKggKOrGjWOhHSNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184234; c=relaxed/simple;
	bh=8+UrrVihSbwgqIAzORzhP9sLJxCeMvaqwlfAS/Yk1+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNW2hfA2BYAtrE1dKJ4z1BbGs5kp2Tvb4Xm6SoK2DnSwlk0tCgru0ZMNs28ai8X+8qFvZEdW5b45yfLqHKuQGuL/uHQJ+rTGBIA7G9S5EXPx9w0EgGV9G70AEhxQK8lQ9ZF8bu4pbhZ/P4eHKRPChCAZqHia6tUUJiwLYARcbyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgmKIBf6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775184232; x=1806720232;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8+UrrVihSbwgqIAzORzhP9sLJxCeMvaqwlfAS/Yk1+g=;
  b=QgmKIBf6OamZ7WY7zFW13MUtQmDLSAKVDnHPt+A+BrS4BYrpdfmyPY9J
   K5u/sQhJBvPlYjZRSyBjsiJur2u9uSyXdVv7GkuG5mXAp6ixY+M4wrHtl
   lBjs8K/dnQpLfmPf7Kzwl9zPXmvLRse5rC0TbWcZLN1Ke1b2FEk1V2OU7
   aq/U0BxSHimwYVGK6xdd8gWZt6bL3NEY4o6GHYx1vS1QkKXA5Joy1tyqY
   qNK1TOIv0i4Qxr4mRAvhI0ziMYHegUPgU/z9JzjgYFyDU0tDgcvkxLuDy
   HAHrlQEs+eWftm9+gVJMKClm17VxwwrPP7L8XOX63QCpct7wk3J8YxkNp
   w==;
X-CSE-ConnectionGUID: r7JZR0u6TAejhwnlAKkSjQ==
X-CSE-MsgGUID: iTQT3Dh0SXiBF6X1WxAZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75423576"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75423576"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 19:43:52 -0700
X-CSE-ConnectionGUID: igRuLWxQQVOiehWhyP4keQ==
X-CSE-MsgGUID: /WU2J1+PRIypirdpuWHUZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231946709"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 19:43:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 19:43:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 19:43:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 19:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNDOj18wydbHDeSU/YYAXhBz8lChgV1qzc602dkJ23FRxrellWr1S7l6HMJTEWnyEF1hrefAGyoHtoJTXW1crvkM9U2Xdg1oyqp2LyAs/cWjDReDvVnUJe/ws8fPKbdJUq3C0w+4mICDmSocR8cdSZ96hSv5faJp57Lk0CDGc4H/rfhXEjc/s/QCWuiTW0mEOYxSwZuqGA1ShC+hBG+48bA29zNXUn+f+DYf0JVeVjy5KzKu64inJoaw8/7AoKSkrF+8wDOXQEXQKKVUVdsFBhKrYuDTq4Sn86YDx9tEa6dImga8ELFVPXc4IJwXxC17bXnClby6cQbZL5VRu9BOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce51S4s3JzJ+C1exeHDbrMkDqhVoSqffREpSH9v53fw=;
 b=mSjnbv+xeMnnoGnGL+MJGpaYI5nKqDTwBThFAKv8MXJTMD1EZWq0nH3BG4sd+g1aA27PljEo0gc49At0YoRodM9JmkvcE0LTd3L/3PpuMgtpX8gARJaLIGEi2oLXWHUa4OeJ5HQw2omaT9GrRLaBZqxny35yjGLWCq8cHtXRHIl0BZOvGxk4+PMD/aVJVswTYMliWX1AHjqYVP6pDWSKmxUcKqVkzjSLLlYAoeGlmTl74Bwv1t2s1Ryc9SLSIHF7nKrSvVvD1VCVoMQLiPGJzU4q9BTA5GUXxP4iYCyilYRZjWd1dtd5q176dK71hWSnk5oBkdlO6hWuWe+lZcjdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 02:43:49 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 02:43:49 +0000
Date: Thu, 2 Apr 2026 19:43:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix slab-out-of-bounds on PT update ops retry
Message-ID: <ac8pYV9MTav7nmZu@gsse-cloud1.jf.intel.com>
References: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
 <ac8o/ubOXlXYTUeV@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac8o/ubOXlXYTUeV@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|BL3PR11MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdabc3a-90b8-448b-b129-08de912ad55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5k7sCbnm1n7KHH9l3lNnJR/5usuUMaHwOh87S6SmXW0m86zO2L+VP66H4jchkSIWi2+TDzg28AXhNmnDNxBeXCkdAIP0HdaY/2TUI7ejAX1zjyF/Ofu4bf/rARU27Heapd1du4kcstzwUmfKZVuFIjaW9Wetc4Wqi1VbGo4svLKib6/YXgw5RqzjgWKCEawRM+YMzXVbyEVez/rq63+3tQsNJgd6OfCUQMZJSZMGA5oziMYDrlZX/yx8Ik+k4jsE9xGpxkHhbmBHPcd5S5IzOvYOS5t2T4+z+oOeoqR9rgUDnaZ07ylbJ7TZUrVczqzpgjXCCttAVZx8LjuOFbs0l/Ck0a0txKdF1x5CU0Jq/JyInEdaRcZNP8VAJ8OeLWJdS8RKkp1NqHJdV/q51NVJPRLn6aWCNbilQCGPscxFLQcTO1ts+agTyWGdmAWimXKAtN56QYj/u2a6n7yjCn9OlwH1P0OCSYpgH6ywMUzJCDYZWkIFiS3MNPitjo+aBnZKZQnQ5Ja4Z0GFB//6jpi3a4XNaPRgxi+F/Ar1gHhF7JSVzyggscCKq4iWjfHmY/eKe/2nAdPDa7QrQQflIHVyPFtISzc7PkeGM+fpDzOaVNseONMXsbzujmANpsHIqM+ZPZSXAH4Kl2QBcosgbR+28wnKtsKrPBB1SKi4L9kgnspGfDLUKrRNHsCUtqW3EJFNgCwT0i9/zZ4LSeodjXlNDO3gEkTf421dETofyzq4u+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BJMOv3biTSZNcnXunggvBLLE3q08BOYedGHNno38Z3BkEttEWbxCUIVlMd?=
 =?iso-8859-1?Q?xg/0YgBCqY0ywg0uGEmNKkKY6DZtW1rIfU8rqEuPUIC1IL+5AcbrYH7HQf?=
 =?iso-8859-1?Q?E8YP6XwCyAYjBFEXJ1G9pBgE6GIGJRBU5GMmSiQFsFUIqsXA4/Ma9aTzPp?=
 =?iso-8859-1?Q?wrEnMExXoK+plcUjR7h0Vqeab12X0EkzgBsmwBYHepCohOIEp/VCJ05iuX?=
 =?iso-8859-1?Q?QLm7JIbOh+orNCRwQCX7LOt94p069Qu4ouDKUGPw8q6wsbfXu/AHu89MgY?=
 =?iso-8859-1?Q?+GhrGyl+R+Uf1OZsnYW0jkbWh5I3e8MVbxgzHsm23T/XOu5T1kd4Z7ph3z?=
 =?iso-8859-1?Q?jA4pjHaCTvsrbX1BhssUdPnYmf1iBOlSGwdrqC3cr4XVIDal/+rhrR+tJn?=
 =?iso-8859-1?Q?bpQfTiQXsTkdQn4suSmhpBzOmn20TQzM2OaPTR7n8GyyH5323wFnmxrLZ4?=
 =?iso-8859-1?Q?Btdksj2c6CqyN+yoJLHnJ8eH7NgJg191bsviBATqJbgjzCFwb4t5D4mvmn?=
 =?iso-8859-1?Q?nv9VtoT91AissACKUwbV+lkaN1S0lgRgRjHyiYk177uw94ZWw62QjmK/ra?=
 =?iso-8859-1?Q?avm+hnGWFjAV71wDOMTmZHvyN07HLy5axswkwnN4bu45hfLIqakqLK1xb/?=
 =?iso-8859-1?Q?/oSyoUhlD5LI6UR3QwBsL9V3Fy7Asie/VXmOKTrFAn8VlMQ8iASW+OSE9w?=
 =?iso-8859-1?Q?TmWcOAB6gUbQ71R+8gGyDhUQ27X5fAAU+mZvslAtra5DI+JFrhf30DGB7q?=
 =?iso-8859-1?Q?HZWNUG9lRnndQxSOx1GS++PSg/AqffUppirWOi8IVWq4hUAhyIanT+yEiF?=
 =?iso-8859-1?Q?A6oZbfVKUmmo/75Nsqlc0K5b84Lu3oDi9pSu5qAf5i3+lnWZcRov4Xtr71?=
 =?iso-8859-1?Q?I+mVZ3dUn9j3IigucLRTXy+0iDENwBp1hWVmT1kINuCQQoC3V4c0kf81Q/?=
 =?iso-8859-1?Q?TXaJodhOzYF6ILf5b6kZXwy9cx+gaLlW8PBHHcG8ivv+MRd7VINM3jDisE?=
 =?iso-8859-1?Q?iPYmBZuRvnNJBwLGE44X9yxVWPXhSZANG9vPHG5hjnI+Vc3wZDE2OTK5Gy?=
 =?iso-8859-1?Q?WkjLzW9pb4s5E/0gnsMOm1kwrdWTqEld5BMjeOn9HJ7/9ay8BBlVgoUog3?=
 =?iso-8859-1?Q?A1kqIQIJ5E5w3yMPduLc/5bIGhUfnVQUrijrDi2ZwdEUkfyjW1PnWsjO6j?=
 =?iso-8859-1?Q?Ja+xHc4Zbt+gyjaQ/7Uh1EkpAiuZTlmYSA5Ccz6MgzdXZVDnnlT1tzJQ/K?=
 =?iso-8859-1?Q?8o4nOTtqmQaFHkwQy2JLDGcSYATUNytVV4YyTwMxXVC8H09BKaeJCXHfTx?=
 =?iso-8859-1?Q?upKmhYhcJyom7WARKjzvl5VFfD9QnMWLQU5uqozLHDbD4aMk8PiiQA+Cj/?=
 =?iso-8859-1?Q?rrsjx+z1bmdu3DsMAPKB9ATq2wnDAZV7E6y0LPDWP9lFZ6FLCfOqir5H8h?=
 =?iso-8859-1?Q?x28kHtu7q8YtI852EPbKuCvIBTEKqk9/bpNrFPFZJEP5c0Bx1NoMYhrmzQ?=
 =?iso-8859-1?Q?UJec1C4nTyDK89Vb0sid27Umn2a6RufLipGWLDeYGuPw15bXkhSseBYBw2?=
 =?iso-8859-1?Q?/dLVYEtQmW/qyEaSu6YFXAeoUMOu9/KbnAy/zqlXyGF2J8drxpM9XBSkum?=
 =?iso-8859-1?Q?RSS+HI01FuR3oEIHtHncNZ5n81mzfqzXJd3ypVcdFD7lsnYMmUH39pwE0+?=
 =?iso-8859-1?Q?XEFq66f5Q5m3CryWr0PgN9PuclyVn1pwmlWDd706hyz2H5obMtoGuSZ8/C?=
 =?iso-8859-1?Q?TLYQm6RNtB23X8qYG6ssQb4IhPkGnKFR1djMqs0LWgZnEH9rSd5O52AWMl?=
 =?iso-8859-1?Q?Lqh7n4EJf/IF+9H/DGQTq2itMCs7JJc=3D?=
X-Exchange-RoutingPolicyChecked: WTn+/hbRnh3G+WWlcpcbRnPS6wFvgVawfA6oObeSPXPFLfoyXEOYhOVO4aLNtgJp8pIbaRDhLyBdiiNcco2gLtfBn9RVJShe4mqjOAlC0NS3ih0iN9PyhlhcW8th7p2OY0DOPWbtmZHf/JtlGPG6ltkyKvFTqok8TFdbwnG1qKuzF1n0xULyuBIhtBmGqxx8tzHA9yWLHsR2ZutcYxFQc8J2ey4sEiN8REwDOP9DB0++vjLkMaou38szsinnY0GbK7yHWCReUE7a+kdtXSXMcXHj7y/lwlR0mEMqkyunUyzqICyC2dHAGuIa13QBR+OuZ59gjY7GueqxZBS1iIad8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdabc3a-90b8-448b-b129-08de912ad55c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:43:48.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgaz/FKNxQHc+dS6oh7f98d4qL/hAlKZwp+5tzr5z+ItlsmzmVkSBUJvUBecesiYOjauFVCA5jYbFpTHeaEUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6482
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233138-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gsse-cloud1.jf.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0C290390703
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:42:06PM -0700, Matthew Brost wrote:
> On Thu, Apr 02, 2026 at 11:15:39AM +0200, Thomas Hellström wrote:
> > xe_pt_update_ops_prepare() calls xe_pt_update_ops_init() at the start of
> > each invocation to reset per-attempt state, but current_op was not
> > included in that reset. When vm_bind_ioctl_ops_execute() retries due to
> > ww-mutex contention (drm_exec_retry_on_contention), ops_execute() calls
> 
> I'm falling to see retry path around vm_bind_ioctl_ops_execute related
> to drm_exec_retry_on_contention... Also by the time we get to
> vm_bind_ioctl_ops_execute we have all dma-resv, right?

s/vm_bind_ioctl_ops_execute/ops_execute here...

Matt

> 
> I believe the Kasan report but I just can't spot the bug - can you point
> out the retry path to me?
> 
> Matt
> 
> > xe_pt_update_ops_prepare() again. The second call walks the same op list
> > and fills ops[] starting from current_op, which still holds the value
> > from the first attempt. This indexes past the end of the ops array
> > allocated by xe_vma_ops_alloc(), whose size was computed for a single
> > pass.
> > 
> > KASAN reported:
> >   BUG: KASAN: slab-out-of-bounds in bind_op_prepare+0x89c/0xae0 [xe]
> >   Write of size 8 at addr ffff88812e72bae8 by task xe_evict/2848
> >   [...]
> >   bind_op_prepare+0x89c/0xae0 [xe]
> >   xe_pt_update_ops_prepare+0xbd0/0x1570 [xe]
> >   ops_execute+0x3ae/0x2030 [xe]
> >   vm_bind_ioctl_ops_execute+0x4d5/0xed0 [xe]
> > 
> > The write lands at ops[1].vma (offset 360 into the second element of a
> > one-element 384-byte allocation) because entries[] is exactly 360 bytes
> > and current_op was 1 at the start of the retried prepare pass.
> > 
> > Fix by resetting current_op to 0 in xe_pt_update_ops_init().
> > 
> > Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_pt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> > index 8e5f4f0dea3f..3607cd57fc4c 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -2291,6 +2291,7 @@ xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
> >  	init_llist_head(&pt_update_ops->deferred);
> >  	pt_update_ops->start = ~0x0ull;
> >  	pt_update_ops->last = 0x0ull;
> > +	pt_update_ops->current_op = 0;
> >  	xe_page_reclaim_list_init(&pt_update_ops->prl);
> >  }
> >  
> > -- 
> > 2.53.0
> > 

