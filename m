Return-Path: <stable+bounces-119700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D3A4653E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFFF1896BB6
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2A21D5AF;
	Wed, 26 Feb 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPZVtn7z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765721D58D
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584377; cv=fail; b=MhlrAWCwJYj0qjQ2/zoSTp5BbOnGwSldo1BvUVOGThuLFm5uJ8nK4zs3C3yZGcUNHA8MANmES6kn3JJ7Qf02ZtYWqwxONbz18we4IZ/ORGeFIJalCCwPVbFHeV3EIIeTeAZRSVg8HVCSGP2cw/JFREqUX/02yhvpq/hEAYX8Huw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584377; c=relaxed/simple;
	bh=k2qQ/WY/M/XpePAMzXHT8PzQNA5BKficQ8H33azWJSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTeGe31drBOF2QvV0pJJG7NmE5BuHMd/6PEpI91keErsFCpdPG/uYtHhmYIC7hXTe3qOnz8CjmHs43MbBqTGdJAixRjXZ5NtWE8SR3iA8RIFG32XMHcbcUSpsgeaCG7OEklXLG5hqA8rEXzbPlRzRf9Bj07So28TaGIiQHr+FxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPZVtn7z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584376; x=1772120376;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=k2qQ/WY/M/XpePAMzXHT8PzQNA5BKficQ8H33azWJSk=;
  b=jPZVtn7z4apkuNqyPiBIr4q8MS0Fn8OYQ/6mztC1U/X09mrDzAO71SkN
   nBilo2+j6lcqFGkBQ/JQANK6HOID/hzwkigv1k53bLPB7MtjcieIHDLRC
   UIuUrgl39PThps00fsvqwLNcyzvKPnQGCNc24LYmlJ8vXuyFJ1kB+all9
   Vs14zQaC5PY0A3KGFYsdhL0xDhXI6NNXVHN72TZxyCjLspQ+Nyf6R7adB
   smHdDWeWYJSGsJqUdis6wU3q1UVF5OSh4VFv4Y75dFSPfo9AED1tymQp5
   Nn+DEus93pNwieHHuAeZFX6V9h9T6qhghVJg2lfwFrpucDAdt7mLYPiCk
   g==;
X-CSE-ConnectionGUID: LZvr+WzsQhCD9Nbf0KrLfQ==
X-CSE-MsgGUID: SlB0N8hmRzG32ZJ/fqaqlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40675295"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40675295"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:39:20 -0800
X-CSE-ConnectionGUID: 76bHNK26RJexoAk8P4tMJw==
X-CSE-MsgGUID: rdverZ8XTteOAfGWmc68Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147660287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:39:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 07:39:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 07:39:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 07:39:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU2/UJU9vyE2uN76JUmJ3l9alhUSVoShYnc/tjY2YdJbEYq1bqr7ZrFLbpQ+IyPAB7jlPaXj4nnA06hhz1SuwiZim4aV25gXoCatLbEsOAylW9O+rGb9u3Ymv3BVP9t77u3E2y9vX9VDi1/CHUtXE+xiEM6SlXN6Cn/iIBa2qsI5xIHjTIG+cUm68EpSd8sBhk87IZZ/tCt313RQobJ4g2DZgNKhhaWAOzbZ58EAkwyuM8dIrs4Ph67vZTBOhgJQizR1BhRc3E1FPu+7UWmAN0ZWoTmECkGymoCSu6z6U0FyqsgVYWg/oYed4EeaOg7gGuZW66Qkzmn90fBc4zAfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCyn5RLG8efyuVtxyHHMP35BmvIWAHy50OfhDC3HEIU=;
 b=flSwFieK/CETRnOMV3ktrE3J+KTee77JKsgqClcI9Y9pAGCMuRMQocUl66w9LtkPqTAq4mj5VfwRJCyQFEryX0syLK+BFsNMyzoBkF36zanfh0IDc4WNDuvRMCu0zF6oqBtbGcYjeSxWNOl4kN/DcQz5HPhmwgbYHxKLPkr4UKgyBx/RQf95LHN1PuNM/Nifc+GaJe25YMerUR+K91OVDD80u58FkfqQNpLa4JD0lVUpqr8asDwFbEo/9RcUMmVwYmZvXBB8p7tijDp+DtHc01MchpxzSA9M584/5vVuIolQzuwhvICJ2NKRmbForLelbomVMD7tvWL63iccJMYnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 15:39:01 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:39:01 +0000
Date: Wed, 26 Feb 2025 07:40:06 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/xe/vm: Validate userptr during gpu vma
 prefetching
Message-ID: <Z7811mqgky+kKypb@lstrano-desk.jf.intel.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
 <20250226153344.58175-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226153344.58175-2-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: fd501de7-f146-41c6-ca0e-08dd567bb187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LkMDNXXJL2xe3XQf5TfSwWDeMuA6MyUIXMLnEQlFczlRz5CZ0WhQzfTIWY?=
 =?iso-8859-1?Q?jMwtPgtfI7PBmUmPbmCtcj5LLGQ7lt6Y1JFgNmGfv27OhkU9GlAgNzPt+7?=
 =?iso-8859-1?Q?zmwclv8ik1fnY0SZ2e4uAV38xfGytUzxs1uFyoYgsTKQQR00En0JZxi/2m?=
 =?iso-8859-1?Q?S+DGUrPpBW8iMWbHwdB5OsFtjkEjbBnr0K9rmlIX5gjxNkvv5MQgPKmNvo?=
 =?iso-8859-1?Q?Lg2V69F9wVmkvO2Z/dv20W3cne48SZkZDcpU0sy9CRaJF67Bv7guRwLOzU?=
 =?iso-8859-1?Q?hc9fbLM/YpiUORpI0NFcsMI8Eaqg+rYUUzyZiMR6FKubEB0PUvxJa1fXL3?=
 =?iso-8859-1?Q?qDJTYvHk5UK+C+ACw95t7/hdqIqOWN6me8bYE7CnfJFbZTv5vbo01JepSQ?=
 =?iso-8859-1?Q?/G48NyIqoL6PD+RKDEoIeoua/mN53IBS+8801PRDVuU8/HUJpU5N9STzMe?=
 =?iso-8859-1?Q?1i3aYS1SJdpAvlqIojz4SIhkFeF2VSPrggIwzhjm81LDVpdoTQT/LFUseP?=
 =?iso-8859-1?Q?JoOGsYMrgYbU9kvBRmm7AQAOkVoVNFtBVSg1qwYU4hZWrFT2mlqaR0mB3k?=
 =?iso-8859-1?Q?kZ+8+kerWpX63tcdMPQZdQcuw0maIAmEesUwEs1APpTCdCQyMZCyqPC0Xy?=
 =?iso-8859-1?Q?Bh/s5BwJBAbVEgbM1UiY1t/G5BB+RrhWw9pVjf8zw91AyzXQ4WYAMFZ8iz?=
 =?iso-8859-1?Q?spK0SUVcKZASYpkaVq+LY4ZTJ76uJier2JPIasyxVXBS1JjsWFxUC6exNQ?=
 =?iso-8859-1?Q?+922GmuTyOeyJ4z2nYjfidecP7ab4cU5DUK0EA7Ej2/lQPgzxZaFjudCij?=
 =?iso-8859-1?Q?+7zGpTM1PAtF/P9fmtrdjjBKxGPn1S5seLU/phC3hQrqBXtzMS69WAdjOI?=
 =?iso-8859-1?Q?ESWXwEOSXbSy1410fotqJgFpGRk7Ma8zuhuB4NEJ+UP46IIYcCNCDuWWQe?=
 =?iso-8859-1?Q?NW7sxDruqI+wSz4sQp6TaawITvnxfU7TZP3URI16HTSbDD1y2BXyA0AaJw?=
 =?iso-8859-1?Q?diL3P1wIKLYGHGat/DyM6cPmk4PKJZ0u5SY73Kjcu9j+kyEwKsbBE4NnX9?=
 =?iso-8859-1?Q?2NM1YPI/QiYBpwMBhTas8WFNtFpDR+DCX/Z6RfoQCaisdt+6zUetbktDcP?=
 =?iso-8859-1?Q?LDqOiTvdwRqr8TIbpIBHQ7my+QzG2UvxWOORBU/tvJG48w8AOgJauNro+Z?=
 =?iso-8859-1?Q?yITImI+YqqXsTvQGXTf2NKLrOcsGuiGasambbMlfjTyeV3MCwxAY4F8Dwf?=
 =?iso-8859-1?Q?isxP4B4058VmmHs3NCVrimlC39Edyt4LTFCZ0y0VaiBEG/hmYbo5opE1W/?=
 =?iso-8859-1?Q?UjAvMRJ0ExADZcHBACvUIbF3g1RiNkUBqkqtgH4hU0z3VpxoW0bNapEqCU?=
 =?iso-8859-1?Q?jvPywf4QxzorTWJE409rcIyVTVx6kWXAD9cKvEsO00HP9ZGkUu990eUFiE?=
 =?iso-8859-1?Q?r2fS+Mk3B11T3Xly?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?D6B/dpOFdOLaiZ0UG1S4qixc/LZi0l562OWHkWoDqulhDRtLoW/f7HYpBY?=
 =?iso-8859-1?Q?I5nFFAn81U713bP2zA0W+DKovI7wU1k/I2owDQ44T1SyEYP0Xz6CKQptGP?=
 =?iso-8859-1?Q?D27GHFqcXIXvpCPF53sxUsYcE0lvHcKeOLi1iK3bKFy9InF5Z0DB2B62pK?=
 =?iso-8859-1?Q?bqLvbqEoNJ5Y0sI8KxgeLMUqdAxXAYxJ+BWmIug9DiyE9i42Z6ZyFynY3d?=
 =?iso-8859-1?Q?SdzmPy4nYgPHTKhChcVWPX7MK3MH8l3vCSkMnZta/wtbTHndPdUC4rnw7G?=
 =?iso-8859-1?Q?5sErcArH+kRdBRfFS4NCGLSYlvy1dtpJJR9lb0tELOYKH5I/0A49giphsr?=
 =?iso-8859-1?Q?Hg3RJFkK0i4RyBYJ2EnQ0vhMoUAEOz+6bQAzTIGLue+A/ydRz6TkKbInbU?=
 =?iso-8859-1?Q?5qDnqRVj00MWHks5yMM+Sq38I5d/X3kTsPiYeDrYm88kZIHmSeSRC7ZgFa?=
 =?iso-8859-1?Q?61Wzen6AIl9A4DqIHyViG7dZZpjdGres691oy/SQ//FVh2rqDmxwUdrAqo?=
 =?iso-8859-1?Q?Tro9kpYdcKZ2qIyDTaPEJRnL31sZu9dR0UWSkD0YAZoFoW3aUzJa8oTJWe?=
 =?iso-8859-1?Q?OF4vm6fKlAcH92drNVybnvqhFVmuKABGAkf885HZjciH67LBfyK1uLMabB?=
 =?iso-8859-1?Q?kyTJw9/l4yXGsj67YKax+eZ13qzciJ6nkYatsmwctx4x/YGAxIkqm6oOz0?=
 =?iso-8859-1?Q?lge29WSVO9aqY9nVqOAtnFZFJA0ltnToYQvcncfJFyRuH2Sdd+xNl0PFAK?=
 =?iso-8859-1?Q?s9+TpoV6v2GfDeN21MsCgfot2iVmqOO8Wey2JUIwve4qfcyBB+jBroY8Yx?=
 =?iso-8859-1?Q?OEG6RShecvRtyFG8ho74WKKl+OKRFck6D3BphZ4nMbLFybiF0abbYvAph9?=
 =?iso-8859-1?Q?gRJC4C8uVnr3aTtLUiECui30q7XxEQMNj9UJAYevv+lBtroz3ewpYBhGZI?=
 =?iso-8859-1?Q?qH1HATMzFWe7vlQO1tsR6g6ljbHNNcX6L2V2vMzSy4JdGTgVkbwQM3ZbwV?=
 =?iso-8859-1?Q?36BNgRIvMyfxfdlA8QcG61DJEzuSVVIL0H5FfeQS/q4UJSjChGtM2zkxbL?=
 =?iso-8859-1?Q?wOjp0IKT2/OM0DKD4rBryvmeG+z2mHJ/jvmJ5YQWRA8Ga/StnHEtFglVoB?=
 =?iso-8859-1?Q?3m7PcP9nuv4bTucDuTwLvJ1foy5whNLep2dJqpflwNVV/VLbzXR+RDHNZi?=
 =?iso-8859-1?Q?jpN4tL+KZtczE4QiipesmGOOvMJzRGbJdbGieZTO2WoRZrW7U79Otf73zi?=
 =?iso-8859-1?Q?ACUCWPEkJKypvmbLMw1n7SclI71ht943aXImxBsB6KZU+HP7G4csH5yHgN?=
 =?iso-8859-1?Q?+Jx3sEN8l74/JDGod+ghcBrlFrkS7YODt6uygD3NXJegqe2SoPzZ+kbIpY?=
 =?iso-8859-1?Q?ATXQnNmBEN+TmkjXZMNg3t6uTRHYYBeTU1hIShADJIc3zpIXUSw70dVq0b?=
 =?iso-8859-1?Q?Gg+13Ryh86J0HAvIwQh0jVgVuPUW6IWZDKWJMKvn8dkl3X6S9KD6zxLjQr?=
 =?iso-8859-1?Q?70ADwqtpJ7rz4suQigSwBWPx6JvINt3bLrCyr2vyAIXh4xbZHvLw1sM8GG?=
 =?iso-8859-1?Q?oSc6EGbce59vD3ACTTGsiFm1emNUgtUdY3eQbt21lnACvoT51dsr9wsS90?=
 =?iso-8859-1?Q?MjfUJ2s2gV+RwCpGdjYu/5JFZ3CV4WC9OimVJ2Fh2GDfGUuO2zzWVW0A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd501de7-f146-41c6-ca0e-08dd567bb187
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:39:01.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrvNvVPYRf01vQf/keH3QImVjkQJB99qUMGgC7R6qvxLpheoKmjtwBQhxGFFJ8bXsh6enTU3ZGls4emcG+Ww7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com

On Wed, Feb 26, 2025 at 04:33:41PM +0100, Thomas Hellström wrote:
> If a userptr vma subject to prefetching was already invalidated
> or invalidated during the prefetch operation, the operation would
> repeatedly return -EAGAIN which would typically cause an infinite
> loop.
> 
> Validate the userptr to ensure this doesn't happen.
> 
> Fixes: 5bd24e78829a ("drm/xe/vm: Subclass userptr vmas")
> Fixes: 617eebb9c480 ("drm/xe: Fix array of binds")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.9+
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 996000f2424e..4c1ca47667ad 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2307,7 +2307,14 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>  		}
>  		case DRM_GPUVA_OP_UNMAP:
>  		case DRM_GPUVA_OP_PREFETCH:
> -			/* FIXME: Need to skip some prefetch ops */

The UNMAP case statement is falling through to pretech case which I
believe is not the intent.

So I think:

case DRM_GPUVA_OP_UNMAP:
	xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
	break;
case DRM_GPUVA_OP_PREFETCH:
	<new code>

Matt

> +			vma = gpuva_to_vma(op->base.prefetch.va);
> +
> +			if (xe_vma_is_userptr(vma)) {
> +				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
> +				if (err)
> +					return err;
> +			}
> +
>  			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
>  			break;
>  		default:
> -- 
> 2.48.1
> 

