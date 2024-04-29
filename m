Return-Path: <stable+bounces-41591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CDF8B4F20
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC8BB21943
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63238F;
	Mon, 29 Apr 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4YQ6ZdI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5647F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353127; cv=fail; b=moHP6HRqGDeInAMK9pZx+Xl8dYEg0K21LnPYmRBV3zOoGwnq6ywm9rKTS+ptDOc9/OeQw1rAavFfgzaiP18V86N4mpH2jHzH3yLeqtkDxxh84IGn7P/W/lxzgYvneT8gZE4/8D3DyNSHEE6NQ77H3yejfKTjXoaWYDC1mn0pd1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353127; c=relaxed/simple;
	bh=vmejNKsANLwlcHy83dZTx6NYxU3s72MTSGfPEST/Dbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cSYk6RAztIBN3guEWmod9kXkKq2oOjQl4a95xSbTjQyJ6m+ywMPoZD9cXyVI0kBQFyTxxIFu9k8Wq3aI9FZ/Tyr5Uw38Iy5k7go6mv8jCnBy+gYWa0QpBf3/xcuPVUxn+cOnfpoe1xWFqX4Tpek0s6Nn39CVkN+ZEfJuggb77OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4YQ6ZdI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714353125; x=1745889125;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vmejNKsANLwlcHy83dZTx6NYxU3s72MTSGfPEST/Dbk=;
  b=B4YQ6ZdI9vhRrwrLvtlDgC5bJFkY7wmzvcgUoxrQC4eCXvwVBdP/0vEr
   9jz6O+xcWkn2dtZ9VlEmxurZRVVjYbgon5wpA6rxgGABtQIR16VZl5Ssw
   jEj0YnBSbulFwhalINpMuWugSZR9DpUBsF6/BJsRb+mJFKHZ6XD8iycIM
   4gZ/3F98GIVG1Ah7UreiV3bpMrXEBrHdJz3bpdyF2tsrZ8lwuWqaTyOC2
   Jv04tYXv/BboOpTuDqCDoMBzzXtqqJwcDKWN17HfPhRNQLdvU0sNiI/xh
   n99QyeSJ2hf6r4wAe/Rd71hJnokwprcF+sx8oLR2VA5MQrkyREau1NDDc
   g==;
X-CSE-ConnectionGUID: noTWUNi+Tj2QIUpLmIXV7w==
X-CSE-MsgGUID: ytklb/ZaRmWRZFlVwOsfEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9833414"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="9833414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 18:12:01 -0700
X-CSE-ConnectionGUID: Aoe1j/i5S+SpOXjev42Wxg==
X-CSE-MsgGUID: YjqwBftTRHGeTvalNQyHGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30611476"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 18:11:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 18:11:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 18:11:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 18:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwRa+OzkA/UejVy5tYba0mon0uOqxdEE8QpVmfrOlGaBXMCRXSmHViflMJz7p9h/vjEAeenkqpNXlztUU8RdwIoyQdfAHQU/rkbZWDU0VbBFG5Vt0l7D79nynQPbxmrwiRwHtmSDFTgtG6OOaT9CJdY6B3F0mudiyJmub6mw91qZFso8Mh8S1lbAA0Cvyj2bdDS/4YttkyZKVHwLirI7jmeFE4EdGn3bAcC/i+LNIAtawTN5iNZ2Np1a/TomptsfhbQmt9OaJ6inkpv6fUd8rPZSJuhxI5s61pP5o1O23uL19WK0qEBer00yUDhYQ8luopjLIS4hvx4a7q8vXxRUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+/nFjWjalehqo60wbw79Omt/LPbgNLEMf/elcLG4P8=;
 b=f/9CegS9A2qK4HiX6FxGMcsKxs7YWZ+GK2eyK7ZmOi/KGJsgK/AKZur7s90rNE9Q7d72qH13hIEWQglArNvof8R+9w9wxfuk8ocKBeEQQdonGjJPOYNZzhalP2K8gMLmb5U1WUspqsQWbd0QL56RBQwXzgZP07IsAtBQqj+NZoRdsVzLpUwAwmSblvdy9IG/v3CkYpZKMojZ9IreF1ko4ChqH6BJ+it1lh7HWXuxB2NzjyABvPb/IocAOSKLvD/GdzVStgGyrR61yHInRq+3m13SO2LZaUpJdHzcroUG44cVDAz3ZVRwwlfr30clSglhzXUOTinWcuhL6aPunRvczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 01:11:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 01:11:55 +0000
Date: Mon, 29 Apr 2024 01:11:44 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Message-ID: <Zi7z0MU9gV9+o8c8@DUT025-TGLU.fm.intel.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426233236.2077378-1-matthew.brost@intel.com>
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df7c97a-2694-4e87-e478-08dc67e95c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?UpIw5ENuJ51FSlQwH6UhlxmNCnbMLCAkEXXxjfnaeaXTL6tgXaxD0k9bfP?=
 =?iso-8859-1?Q?6nS/hI7J5QQhtLXBDfMmfBXa+VQkPAF+makbbHGk8vFHXCO9Gtc540Xf9K?=
 =?iso-8859-1?Q?k5nrbzKHrnLJio7Lu1Hj56e9VwU+T6ggCB9JBqiF6AUKgA+cVj2c0KtZzF?=
 =?iso-8859-1?Q?2pfKMluhqpPrlVCF9Po55tMnEMmYkOdsLL9cqvH5wJsVIu4maXV70neGZO?=
 =?iso-8859-1?Q?vIgI+oaIh49j3gIg/jdIt5e+8DObOBYw7ZFwWWqaaXdH7+KFsV1i6AhoNn?=
 =?iso-8859-1?Q?Bu2pgpr7nbuxpIBmQNX3kQ0SopyN7GwOBDHLzR3K4Z9r4eIjdpEgIiSCz3?=
 =?iso-8859-1?Q?MWhrtJygQwxLsPfuMfbSCt9MXWZvI/vYYPgDvaMZiiwqBuq4GXp661vBNC?=
 =?iso-8859-1?Q?G+ibgpK4USa6JaYetSxZOfB0bQiyT0fRaEhCuiHYS8tX0YlTVqDsfcsY1V?=
 =?iso-8859-1?Q?hqF4HSCqpojSeXba3Ntl1WKQXvvzErUrOBE+B+9ZKCJHKsRT7BY5pGIn+I?=
 =?iso-8859-1?Q?z3t10bwADlwV5mmamCN8O9rgKzM/+MQzpB3yTaILdttytQ3CI+Kq7mkosd?=
 =?iso-8859-1?Q?9CXXgS8FYQGk0kBxaAzMSjkZmTPf4mC1yYTaw2Hpa0Y5+8o9WGzkeYU/C5?=
 =?iso-8859-1?Q?zeFFcmE5ed3YXIQlysW57CTXF0JGdl09a3mSBgHPa/UWunb5OHda/cmDDt?=
 =?iso-8859-1?Q?A9apyA0uTGUVBjQpMT7voXwpD5J0tdhAbkDwHQ4Rk1NVsT43n+SL6dXfiV?=
 =?iso-8859-1?Q?3AYJ/WAoU+BgBfgikGa/xR2Xbt3uooRsFXANl6ZoQV/pUXnXInnI6CjthN?=
 =?iso-8859-1?Q?xWd1/+oiSjWc8QhiT40+6G6HPWRK9+9EUlQXnLcjinMf20kmum7awSxSnG?=
 =?iso-8859-1?Q?EWd7A57kKbq5aFgO/p4FnM4NzbBHxN7QhYhOdk2bEkgQJjyf7rSfIcLgUC?=
 =?iso-8859-1?Q?6YARLkFNJm6L0GjXstglejyXEumyx0+Tucc2mufrmbTqV07NHhUvPmk0hh?=
 =?iso-8859-1?Q?Xk+7j2lRfo/QsEYIl/Cr1Eh49KMJ12uqRr6Fndnaipf5J8IUt+sK50dSBO?=
 =?iso-8859-1?Q?1DlvHzQ176N4ES1rv7WnP+B1zhXAMW84tEjGHJRfWjb5+dqd+LtCYsfqiZ?=
 =?iso-8859-1?Q?k7mZyXV1fuz9qj/PWYpD6c60aMKwM/9RkqpZTALZP3Q/aNQliYcfJ4e6Ud?=
 =?iso-8859-1?Q?Sh+H4jczUl97R3PtkUFBEdURu7nR8KYidyJDLzW9xH33l6cJvmt8u19bt2?=
 =?iso-8859-1?Q?7HX2GaKzGdIVlejgO4/SyF3JeKHxL6ZGq8PvGo8rN0lBeRNynT4cHVQxc1?=
 =?iso-8859-1?Q?TG2NxQf1cSwX1/XXWFsH2fQsJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sSe+rb9WGK5gdL6xB19Z9lMSMS8Vc1/klSElVnTJprpKYqHDfearTGusG0?=
 =?iso-8859-1?Q?fL3wyOMvjt/sDyOA8aPoGlXxl5bIqNEsMZBQatFmZLmWIyWyo1xDe24YmT?=
 =?iso-8859-1?Q?gDQYaxQ1s60gYWRY3pTnYvJXTjJFQCYZzBicOfkBdYflpxybMDMz2vAYZ1?=
 =?iso-8859-1?Q?Vacmk2QYgDFqxHipRbTWeX+urw2rvxNEUwIYWDPBpmJEv0U2ZUyXjzHcA8?=
 =?iso-8859-1?Q?v4YSOV63Vv+h/Szyvd6oSl26HRDMknKl7Z7A1P2vhebmW3XdestDHgz8nj?=
 =?iso-8859-1?Q?gM5V7cQtu/OnCHqaN2TOT0xgIWokl8HtePGf179XH92qBv/2vBZVYBKdfX?=
 =?iso-8859-1?Q?TM+DHBFzqaz27QocT2Uu2foPcFwXpvL3p5MWYExEb8lAYt55QEIs2LX5oV?=
 =?iso-8859-1?Q?vEgEEZj8ueNfpEgWoBHVEklxAo3w43fFHjrHUpaDwUqKfxK7YG3mW5GKgQ?=
 =?iso-8859-1?Q?i5ON0DZoHRQjTGuuNhmKFeBk6n/WBQls635Sic8fBnHHB1KltGu+BJzG7G?=
 =?iso-8859-1?Q?k/acnJLAzdndp8mSVTvNlGc/ATlwapHln+QuChpuoF0FzZLG2mGn1MchfA?=
 =?iso-8859-1?Q?UB4QxGVeUBqMrV34NZITgt4CvlTg7zEhwUnpNriFE0nlWXI0sLAPMoxgQi?=
 =?iso-8859-1?Q?zuQI8gNQvISZRBfmStXGpawHKJuKTSkwUESG3goCsK+7AvfYZKyXr82kXY?=
 =?iso-8859-1?Q?cuOKQMi3MquTvkGWHD/jMXGeb0/W12ltA8LloySSCqE3HGs+L+uBt5Ybvf?=
 =?iso-8859-1?Q?qb6yHRmKYeGvogM1RZ9GDW1GGXjY/XYgP1QkzGmD9X7/0ZAZt996ZF5woV?=
 =?iso-8859-1?Q?ogW7vZVwdb2FgKY5+2QmQwp378WxnrM6/cLGZ/NcVCgdfB7Dsq6oY1Scwq?=
 =?iso-8859-1?Q?yDBiEjLzcouixuzy3OA3Bb9iqSNX5gHJYPlNYSLhiX8hAppzKvFX+gmzu4?=
 =?iso-8859-1?Q?nrd9Vps0usPtoslPKvEDoxqR3R36Pm0ZBKzV7J4oJ1sORn9O8nuEJRwU7k?=
 =?iso-8859-1?Q?jONf1IgtYxCSyL4kKSAjdqXhqI/Bw/T+8K8qo6SwTtXLbdHOZhmwdibbPv?=
 =?iso-8859-1?Q?Ix3nyhMziszAQe5UiiE8L30IL2bWud+G28+Kz5z52mwLaSyqum+EK4ZX8v?=
 =?iso-8859-1?Q?VLJ9wUr5/QfEMZ3SqvhvGCo/bvzlJXqU2O7m8bKOtK1aj++3wHcoYeuZgX?=
 =?iso-8859-1?Q?YxfwO6VA1KbwQl2zhPp4ZCWngKwfr4/fziN7iD2WV0w+dtrJ2RBOxp11mr?=
 =?iso-8859-1?Q?oTA9EiIPNJaQPTQzzLYKSJNVwIs8UJgj7X1aGwO9H0tW8DxxHPvx3uQrUJ?=
 =?iso-8859-1?Q?tgAhj6RFDc+NU75ukO4+KMV6P1g9mINGPmAdYJADLLnO3MVIJ+wSoDKyHZ?=
 =?iso-8859-1?Q?9jYAvhShA/eUPuOyDAc4qTE9YpXjEPBQUyUfnGhvhqRVq0Ezgyj1/PzExc?=
 =?iso-8859-1?Q?hfIugI46tZThnrJB5wSXcJPeuVZQF84U/bEDhNthyCsxn6BdYQhsWvIyo6?=
 =?iso-8859-1?Q?pxxcKPo9zqBWfBxRwNrBPvXXJJMO6U0tTNSg38SzbB1zZclONy2ocIv67n?=
 =?iso-8859-1?Q?n/kunkBUEvDgWiWADTDHdo5LLkso2slE2j1WO3wA1tWNhI5HPolZhnW7gH?=
 =?iso-8859-1?Q?x8LVszxFnv2MhmPW2OYtWSvIrLce8gIAnX+KQxdgmGrhpuHMHsMzF/FQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df7c97a-2694-4e87-e478-08dc67e95c47
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 01:11:55.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfz0Nrq72iVjRN76GqYGfJx3/9UF+1SBIv8svIZO0DAjBh7iytOl4PcpfRKqfViPZ7sh+oN02/28F9ZcACL3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

On Fri, Apr 26, 2024 at 04:32:36PM -0700, Matthew Brost wrote:
> To be secure, when a userptr is invalidated the pages should be dma
> unmapped ensuring the device can no longer touch the invalidated pages.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user pages")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: stable@vger.kernel.org # 6.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index dfd31b346021..964a5b4d47d8 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
>  		XE_WARN_ON(err);
>  	}
>  
> +	if (userptr->sg)
> +		xe_hmm_userptr_free_sg(uvma);
> +

I thought about this a bit, I think here we only dma unmap the SG, not
free it. Freeing it could cause a current bind walk to access corrupt
memory. Freeing can be deferred to the next attempt to bind the userptr
or userptr destroy.

Matt

>  	trace_xe_vma_userptr_invalidate_complete(vma);
>  
>  	return true;
> -- 
> 2.34.1
> 

