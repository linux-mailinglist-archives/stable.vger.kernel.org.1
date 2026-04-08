Return-Path: <stable+bounces-233753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGBxG33f1WkW+wcAu9opvQ
	(envelope-from <stable+bounces-233753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:54:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A263B7015
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 06:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47C3A3009807
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 04:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE671482E8;
	Wed,  8 Apr 2026 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azira2Si"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD01DF27F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624055; cv=fail; b=iQHzF5+FPaWMlPD27Ibyo/PbUqoketCoTqBi0NOVgvelS3Ahfm1uTda/fjl/XWue3veE6iepY8kHQl5PdGH3uvEwS0/aBcUOukhG/mlL4ucPvFzoN4a0ZVeji++D1M8q/h8TKfQsZvjxg2LGsoaLKzJofDBIS0MDhbg4S46oqdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624055; c=relaxed/simple;
	bh=biVd0wOeKjojFoo2EPY1wb7d1yQSW9f0zS44YNZUghU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l9bFwRuwL/+vDUJqkvNTh27Hz8UGhemYqpeiY+VAdUqJhMi4RTbywF1GQsj1up62zqA7fNURv0SaF7c2gCZwtfHCHa6HsMbFnIKeTglzM9GnjQwXeX7wA5AckMTJo3Mu4/ZDC/QcRXUTfmD3ylmiUg5Jf1IonOuprg0CslN8vak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azira2Si; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775624055; x=1807160055;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=biVd0wOeKjojFoo2EPY1wb7d1yQSW9f0zS44YNZUghU=;
  b=azira2SilB0rRaTkMzBG80v7LDV7U010OJ+nqEVFRqERzoQ36r6SOxMD
   OTQkzgDE5mbA+EZx8lcbIEbbKhyst3gudfnO7U6z7SvpMpZ5Ej7y7CSRC
   0CdFkdgZyzxATOyx/+MQjyg2SL3sCSVy23fPrJN81i8Pq81vDquTYwwR4
   kfqYr1YmE4WofGyAqmiAFb6b/nS/xpBznPVb9HhcpybKORj4jjvLZ5HQE
   qhzRvkySF30RGlBdEBFcU+qLc3emshfYLk9ox03v1mo1k525IdO/LRSLA
   jrTzDNaUlpp6LrLU6aMkXjll6iBV5RZo6X2i5WZK4zPC7oiNandIJWiXz
   w==;
X-CSE-ConnectionGUID: D1Em0cxIRseyCTIOAD4r0w==
X-CSE-MsgGUID: wCMJnEPcSBCznFD6ufAFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76318958"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76318958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:54:15 -0700
X-CSE-ConnectionGUID: fCji9JITSNOCgzAVw7u1zQ==
X-CSE-MsgGUID: cdIGGHRhRKewZQw1axPbgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232735760"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:54:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:54:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 21:54:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 21:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyx3rNEu7It7TxYkkfry6GG7QGZHmdRKGiLzVPcL4mLxefH1rNEE93SrXvQiMgzXOUVoqb5A02XzP2sO8eu1aW3WpyE4mIIjwMziSrFwPwoOb6eb3n1Sb4YbugCi3FetLW6XZ440ECvUVOGOZmgCEOAHqwy9IDb1KTEsoIY7VTFEJAtjhE8pZfClUd9J4C7FI4Nwp5XVC/rT5I0hQesF/nxiZpcu1mKPwFF3x/98XXvLM88bbqyM9hcLEpweQ6e2ZxzNf1LBnZ8S413tv0Iqn8jC8xCKlY/52Mxr+ldQLIlM5eY92WO3PHhDfsRK9G2yF51eDiCIbGs0qx3XC7Ftrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBfk3hHZgSgIA4nmtW8Q8pu3obOzuVOPivPwHpavZc8=;
 b=KGUc2Q62QfdJTQvROLiBdXYA+aWa1Lv7IlUwI0tcdU6kZmw0NMEbK2uI5Lg8HolJIkzk8Aflbx3kBCyLWsF0BVQgX01PkObTzJTSi7BBPr18WzLOsPyV3OKy9SHx5JqtLUnNKXbut5yMCxP4L6+1bQojqa3sV8yg+qM37uUw7t7n6+eHRsVrgYLc5P1NJCZnHlYHEykVxoqkujZy+HLWlWAt9HGnl8qm24hOn4nhC3LZUhPWcXp42y0d4RwBouE1PnTc3YcP445edL64S4JKjMh3rJ3KeyJDCLSmfsLFhhaiNp1JG1x3fXRUDZtbiRJZNKx1xQLUxd839xDmzmmvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 04:54:05 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 04:54:05 +0000
Date: Tue, 7 Apr 2026 21:54:01 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/xe/bo: Fix bo leak on GGTT flag validation in
 xe_bo_init_locked()
Message-ID: <adXfaaPkz/sdyz+S@gsse-cloud1.jf.intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-3-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407201542.3396317-3-shuicheng.lin@intel.com>
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CH3PR11MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3f65fd-5f08-4cca-3700-08de952adc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4B7WdIqI+apb79c+3Nq6ZZqt43k59D8Qh8LQa2bKWmk78myXikSv8pHxt8Z3hd5hUvepIjnfrbtULsiyLw/4dpAuUmQh5TQuw0XQjLEwlZ6qAIihJsIyrTV7nywOtfY8ca/0TRdsYQOU3c8oTGRLTzvBxPyfQWRaHkfyDbuWVU5X+2TmGN8Bu4IuZkgHReJItYe0pbTXSIX5CVKg9CEIjSsXy4c0ZM2EeIQEvR6de2cjnGVF1mAqM4mIYzngaaFdbjh+yMnNp3/PUyzPd37eKJb014HnOFQAEWSFbkIO9HP02+jA72r10+YUIGh6h6v7Dj+vj6mtpLkfA8UqkMmexuotWAbkgL10r17E5eXYZONmlXgAX9tC0rtYxJe57tfs3vNHNNKwq5G0uJhT2yhnumlHnvBKJ711hSjTCKMEo/uJ8YKeX1/1lEB0FaiOasgw9A7xsIK3LnO2NKVHRk+4m65RSCvaXa/aNoXA2Bv3RkEqCn2G8gUvjug+QafXlXZIq2VVTMCxlH99RQzfHedMZr+XTxlxOTf6KxPGT2z3YJHB56UyFCrf7t4CtS+l3c/LZlCrd5PtysblX0pHGVS36bozWM1I0GAo0hI94OBjFhg1Pc6sm1cauAe0FmRHD9Xm8qrc8q7cYBfqiP56rQE1xJflzZK25OpP2coQj9BTh2Qt5I1nzRxLK3K2YsDzr6xCpewY7hDTAlVYL6Qv/InjL3YVJJU9nF3n2Yf63Z65Fi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ryKuhIi/sDVsjgrckg/iKVsY3ZPXiwjkvyFxVvotsua5jRs1ieY/sSAPs7L?=
 =?us-ascii?Q?HuCJf9kEYQEJeRIT4dAUB/oUSEDKHLcboWCBhmsgPt21CK8o0atPEbKUCRqX?=
 =?us-ascii?Q?AHerND3ARbymGFXwuuAsNm5QYj4veOB635z0zxlZ+rATrXfRoOECXHwRBHDA?=
 =?us-ascii?Q?9y+f7hQ78XAWji4yU0hD5lkPtsBiNOW+GIk8VKvxPBSv6FVTg7vK5XOXNMLT?=
 =?us-ascii?Q?XtaiAMS8eEz/55Ulrce68qxGDIgPyaB2xtt+RoWCn3JFx0d0QngMSpuKthoa?=
 =?us-ascii?Q?rDW1dfwr54o4TXYhsJPwdb/jOo7oLFB9i5AbI4bH61pgln439HGJd09ocAiZ?=
 =?us-ascii?Q?vyeUxAII+RjiRpB+V2BgBA+uS+28cn1yPtZT6/y3iexfZqA/N975bav24H1y?=
 =?us-ascii?Q?nD6pnv0jvrYUGMUPcLRCp1N1zqF1QN9O12YeTbfVljPHRsgdlOub/8lvUw0u?=
 =?us-ascii?Q?Ms6qifeJdNA1VU+8HN6SjqCumtsaTd8DRGk6DyQ9BZsFf2Xp1rmlsouTvMcM?=
 =?us-ascii?Q?FSmQFbpxiFfdioA0R2bkbGGtMr6A71NHqbVYY+Oo6nEoqvwDd5OtE8ZkhXak?=
 =?us-ascii?Q?KDPo7DVAgqKvT2GEjVXfEXvG/0owAN6aur1QOSjDP83o6LNLBi5bhqYw2IFX?=
 =?us-ascii?Q?BvoP45BkE5/n4UFo0H2iYRYeOTJgzI+25cVzYxKQ7xHD493YdxnUq42iuqMP?=
 =?us-ascii?Q?wD4BSPDXfcDRtj18/V6GZIY75b4vOgXuMrJGYMPNo00fh8lfGKa7Tjo/NZhN?=
 =?us-ascii?Q?FjWpkr8LUXCFyb48qBLoyu/F+E6xQQKHxv9bQnR+B/4eNxLWC7YNz3SFhj2Q?=
 =?us-ascii?Q?h0LnNa7NCiEXSTFUn5suhBFY4Qpg1m4mphJdqW+goZ1N9CmSx3UDIdNSkCSs?=
 =?us-ascii?Q?xC3oviYd4b57B2sv+GbE0KRQmnNlJJRVWrzjQ68iaqhO6lLjUhWaWsPNEqXm?=
 =?us-ascii?Q?5JoOl4maLaB9ELs4eWgB4zP0oNU5HuOeghih4e4NvD3vYLTxmzonStELWhVB?=
 =?us-ascii?Q?PlBBNm8se3vGWJCGoA+vBz8cWRlXQWByCrLB2pm6ra3aKalNyJeCqaULC9Au?=
 =?us-ascii?Q?1P9NmeT7cdjUinlXpXtIZMlTOyDqtwKvqYpQUvqQxHgMqcmJ47WCw4CWxSqR?=
 =?us-ascii?Q?Mz7ctNwXwemrSFl3NeEj+FITcBwSPELOtu+S3PWV8W4o+S74QLqw0AlvgxOF?=
 =?us-ascii?Q?uB/2aQfB/nyFdPTqlT0RJmj6ZchR/iXSL/BCtQUb42ya0bzv6dWPDtXO1vy1?=
 =?us-ascii?Q?VG3vA6u2DobbjBPCUs3T55nyOvcvN3xLiSLYYrw5ex9ozaXa3x8bWNYAmpFS?=
 =?us-ascii?Q?UYgB6mOyokScgtbh/BBPxg725BvJZ8idpRglyQSwAjk97GakJUYd3VWyHck3?=
 =?us-ascii?Q?I6u4WxqUcvzcxxlHnL7u4pq6en8Hg7eGeFolQgjaEMlW+n0wt3a40OxuN+sz?=
 =?us-ascii?Q?nj9tZ7NU5z75aAuCiaI+OeW+lqcd+IMAhA++j5PO9u2O7KJ4wRQkrZwkBf6o?=
 =?us-ascii?Q?oTCvCH0beNt4EEk4PEa1+n62xnKr2lXwGyBYR5KgN4MieHvkJc+BsIXhse/g?=
 =?us-ascii?Q?/TVhH093W5kMtBU0fG7GCOMiwyXqOP/t+82637ZOjUDW35P5vKkR4yQSaucc?=
 =?us-ascii?Q?jgkrzAigyNYYy/l4Kqzd95CKYw7tEunAJNuCOoh6eVtXazupMzg2cmH6tj9D?=
 =?us-ascii?Q?gATI9A7wHqFbZFvh5gwJFgK84o7M/mAQ48XOR3nA843WvGX+btSxUrcUXPht?=
 =?us-ascii?Q?2ZjKQmHz798j8ZCaYaVEbxiEjTLyWi8=3D?=
X-Exchange-RoutingPolicyChecked: uEXAxXis/XjgF/HH0Zym1rwX1556381dfbkuA/0+QV6bPqdxbm9YfKz+do4YZwunUrh1OyLQoYZBO8brS72iXZVcuh8GgSPIOtlQDIqnwp7HB4dsy7WcBNgudmjhkG0XdWNlaK8gdkbRMvap3xTJ/AtiECSeUC5eeWOwGeDdqADoAWFHsuWIYxU/6b5JdWCCQsKfznVRwmGeJ/DSB7AoxS9bsC7d/okVPRIiL5JiALeMrzsRXOA5Vpgmn9phc85gBIIsmm6zrgbgGH0epmRKn3+nCd6Dmh7Zp7Mf8Wv+ISCslHe9Dvcbh/P0XZFTvqRc6QFu/yqsf/Y2UF7F8WKxpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f65fd-5f08-4cca-3700-08de952adc3a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 04:54:05.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYWiLUgHCTF2cNyQ69LbmwkcqxAIEFNTY0Zhg8h0aq3kXK6NqYLUE6ML+ruoN3olxQW9ieeiajUnQ/QfUemFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233753-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,gsse-cloud1.jf.intel.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 71A263B7015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:15:40PM +0000, Shuicheng Lin wrote:
> When XE_BO_FLAG_GGTT_ALL is set without XE_BO_FLAG_GGTT, the function
> returns an error without freeing a caller-provided bo, violating the
> documented contract that bo is freed on failure.
> 
> Add xe_bo_free(bo) before returning the error.
> 
> Fixes: 5a3b0df25d6a ("drm/xe: Allow bo mapping on multiple ggtts")
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6e4ebbe72952..d09e96b996b9 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2322,8 +2322,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
>  	}
>  
>  	/* XE_BO_FLAG_GGTTx requires XE_BO_FLAG_GGTT also be set */
> -	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT))
> +	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT)) {
> +		xe_bo_free(bo);
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	if (flags & (XE_BO_FLAG_VRAM_MASK | XE_BO_FLAG_STOLEN) &&
>  	    !(flags & XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE) &&
> -- 
> 2.43.0
> 

