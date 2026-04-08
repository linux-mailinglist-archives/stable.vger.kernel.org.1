Return-Path: <stable+bounces-233755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6iXzKxvh1Wm2+wcAu9opvQ
	(envelope-from <stable+bounces-233755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:01:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C63B7069
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9726300C022
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7522DCF7D;
	Wed,  8 Apr 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsfhSPjx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B32AD2C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624471; cv=fail; b=mTY8Cnc0I+tTPlivgVU3xIwZg18VUp4xsg7IL1P7OYOLTeOrSQmJZVDbzsvG9b2pazGGCBcwuWi8wZShSbkc3xF55ulYTKef3HpDUgTeMnR4uzE1aY7sdyKFItty15TD70Tlt4A0Zl0MQPp+iQ4qOhcOjp3lXJnm1PzZU20dAXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624471; c=relaxed/simple;
	bh=LXa/x2zk/A+7hwaz180JeE9JcDtZvoUEmiztwvyYhNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYxQ8/cyoIRY0X6GEwVZN7iJbA2nlrgPY73FohUYrlV+zURAC5Dsu6DIKD/+O/tHIb/PRhUZu0vc8NgKBi/Z6VfVnrtEJVm0DV87qQmviODBC4GJOKTdnGX9NxFLLPmvRm2j2sK+OxMQb+8LjC7zJbWUl8k+BmHqrp6hjl9W7ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsfhSPjx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775624470; x=1807160470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LXa/x2zk/A+7hwaz180JeE9JcDtZvoUEmiztwvyYhNw=;
  b=EsfhSPjxQrII0F7HrrIWMYohHktiQ7vsakFjhOPlWdcooY2ZQnv9McO5
   N/4Xw1TmmXGnb7KX5fI0twY9I1J6vadlruTJbfYCDJexxFNfXFpKt9YVA
   k+WM8UUO5mnNY8NZoGL1cU7Z/2vZymVCrPtBl5Wu+h6jjeXWswC7lt368
   uA46cC7SpzsvNh/auo5MqgVWYmI6112N31BZOvclU43XsjoheK4ka+xeH
   hveL4NoFQt3SLzO46HkYxHvCHWUb3vSNg0hYhMVPpaIhQqTxY2TGv2uL8
   zlKcvpFzX6P2hrFqhz2sapMjxmsUY3Wxjd2WllxSHkFWVQCA6t615kYas
   Q==;
X-CSE-ConnectionGUID: cfGmVGqYRFCebkyTXkzjrg==
X-CSE-MsgGUID: UwNGkxDBRO6krbUrOjaz0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76497207"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76497207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:01:10 -0700
X-CSE-ConnectionGUID: rbAXr0/rQtygLXG4Pzzxzg==
X-CSE-MsgGUID: ywzdJNm1TwqJV6sG/uPogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232736947"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:01:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 22:01:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 22:01:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 22:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrbTx+9wKogFhD3YauhI/FmmOO6Dz5gYR4tSU3Fg6g5M/hRC/Sv9xUSfn/rxQA8VC7mUqDruJjPBmCOpW49hmrCd3CGjmD3t69wFMWDgRmfc/udHFwI3cUDInMWTnBsQZiOD3+LRE5fKl42LJlVIqk08Z2AsqLPZeP4Tp9taDiCVkRvvm0b7GDFDq/63/hrJ6bCMX4WPq0Ir/4GHJlPWnJdeH3NVMCN8t0RM7Bwiou6su+b+R7ywa/219CAJdlIL3ukzBb77f6px5PoOG/k46ozzY66RyYN7aVzJzkzATnJMmho2KAn5/e4hv1Iozve+zKQgMOj0mQuLbCY25Av0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDY7yHgidw/Nv+nLi8qjxKhCFAwPFYkPMcN5oEP2CVs=;
 b=NowIEnRiyI9luLEiismtEpL5TxGqdRylR5dLO5zXHCjgfd06fS5YXQTe3eJQi65JPnc0OuXkEZqS0D3D+iZv77yaIQQJSfOY5a5jDaHzJBjB3A6YIKgPrdiL1/9lwWOkL99KJTvasmZW9mUc1Jbfjvi72txLip4/eGvgYWWeMnvckdSgp7yifxL7yuGjQfEdlFlziYGpRKAxupKeYhuPhtzHo6cUSh7pD6IbgUMAk9t9DDRuRuc7Q8GnyOzDki4fN6XK9OFXKxF89FLWYXp8PvwjOGHA44dRgbIHwew1Qc+JVKWTfKtKZyRYAz5LdLWVxYfY+rteHjkKERk9dOA4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CH0PR11MB8087.namprd11.prod.outlook.com (2603:10b6:610:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 05:01:04 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 05:01:04 +0000
Date: Tue, 7 Apr 2026 22:01:01 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on
 allocation failure
Message-ID: <adXhDcGmLytjuTUB@gsse-cloud1.jf.intel.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-4-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407201542.3396317-4-shuicheng.lin@intel.com>
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CH0PR11MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: c10b5362-b409-4589-0265-08de952bd605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Dh7i1xVQSxA3ku98g3PIZi5DBjoKYsS5xUX4AIRZ6PqRcvW0NLTb3BucsKx/eCxsgiR5ygY3zmHh0joHnIFzuKeSAxVKr+5VvZMsCK9jiCa3amLI7F+ulwqrFkUcpN7Grq6hY2UkEPCSpwSPAJtJau8IUSOu54KoU6IfoFP39J+mrE/oarB+4PCC7on9UNG/sK+j7vordwgtRg0yQYb5jWhpB/IIR2swEk/DOUrv9JU3eksLJm15+bWstj+ifOVxTwuQsEPpP4rqpQgP2JzsgNN1s/kE8H/ghy6htz6tJ0J90QQhc/U/rRmJduXmrOGvZ+4ECjOB/s4OjBJbCkpcKwGl2xRL3n6h0j0P3itSkYSB8P4WspCLGQMOsQR8+5DlPodYT+2iyixmhy/96RCxjpeJBhfcQzV9c0NeBPwo2mcNLTu8yTrI9PU7/c5PcWP1VX9ocG0BPIHa2UIxJkWsCOFcU/5WLg0qVlYcHqUadqGi0caTyWhvkqe98Lo/AEabVKgHszNeBny6nQ++DBW1x7sbxsDXu674cd/e9lErcQ5rA0UC+K3g452fYsR31KIKTFe1RsyRvQRwlfpp8MdzmwSCChnkv86m+2lvnjE5i/0X1LCheKLztMVmcLKJeQKST5irC3iU6565PtRB5KLvCBwWi0jLEA4CfLzytRzgf4+dcH5+p2HWFvD45k7X4bNgYZj8/gEDtKhEm8JNFRbeaOBERTJdCZo35NXHPwf4BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71aoYcfLFdC7Ha3hmuWi0W+qxrbxdkobEm5sKyd8Vlr0yf50TXF8JFQ3GV4q?=
 =?us-ascii?Q?0qqiI/3DVAmGPSefF40IcsWpmvgtHhFW10IpO5kFEtiPqpSScrRUIof2ald2?=
 =?us-ascii?Q?qzuQNVaG1RJH8aNcP9O+AOXdbxzh7ZRQBQ2pcUPzlP6xytokVBVJV/7qHNcu?=
 =?us-ascii?Q?mFpaHWC5p9SCTfZhjRB9kL1L8mVb8c9bmrUlj8eNKSJSKaqcy+APta0Hw8Z2?=
 =?us-ascii?Q?18JO+dyTdE3mcQXODPdDt3u59rS2uRatJs4pgqY3M/QEzlIkWg4B/A5YtyWQ?=
 =?us-ascii?Q?zT3NlASaCAmu0utghsOcb1YQJLw72zh+biZiL265pZIm2ZgDoMJP7MmaEqLd?=
 =?us-ascii?Q?9bl7MT9gSVPgY49qADPO8SqpY0riE6WYKCBjuptbrqxPBq1+UivIW28I+sUS?=
 =?us-ascii?Q?7VW1edsLLLCcEhMTjreIxQxPSe5gcS6IssSumAGMI7TnglXs9ZXDRpVujhge?=
 =?us-ascii?Q?FOnM3/DIvsTNHQlD98TpeZcxTH97iq7+MpzORiUoF46RBYSzgTXGpGxgJzmJ?=
 =?us-ascii?Q?3NWUZB3MKOErxg4ObB1jN2VD2FiOtu6k6AIGDMsjs4ygM7rTKGSnwSAK+d3d?=
 =?us-ascii?Q?XTT77PeMCJRjYQK/UTBt3kF6pTzKGVM8Ja0QA51EHAi3eGROiI2JRACXi2UL?=
 =?us-ascii?Q?VC52KLZFWlSOdaTvk+SasjRhD8Fv3k3jQs+V4QBGQDa/m1p06jRi+0Mn+EQc?=
 =?us-ascii?Q?ClQQNa49DV7oGwI3on39XWFv6AS71ZoDMvGG9dR52N5X++7WUjvA5hAlzzy5?=
 =?us-ascii?Q?vqvqTx2b11PuBL7XBSkWKdlCsUy2ADwM9fPK5N82AnDDBGBuc/+ySebTfQPk?=
 =?us-ascii?Q?cWKMKuQR4zLJQKFu7syfqUFioTwNkLqSjgw36P36YLQZTVMVRq/kpwPTT4vN?=
 =?us-ascii?Q?vRVe32Ilo3SMPVc0/hYGeL98PvbD2GThisBGFhc+SfLwRJi1bP07Ud0XZO40?=
 =?us-ascii?Q?8AScMoY/OwBrwlcQuMwgHv3BKQdIZ9zC/CxghzFMBh8O8Hzf98F0ITBuUaGy?=
 =?us-ascii?Q?bq/Ayl+WwiMAHIqoE89kza9DyvRcvb3UZzmAGb4eB6w6QQuSkd//dQiNV6pp?=
 =?us-ascii?Q?FrI+7eTD0o3pmrbAqqyUzh5tx99rk5G/z6a0SYtD4Ckiw5Dt579N4OwBG86w?=
 =?us-ascii?Q?KDfxt557DqF2RJip0oVW5yRC/nLayEV0mCc3X14HsTgYiv0Mo5szGvL+x1fS?=
 =?us-ascii?Q?xsIi6TSl5kkz8sQ5vjmKy441wkUeHDfZlvbbwpLKzf77/OEEP+s5BB9e0TUP?=
 =?us-ascii?Q?eywClVCfcwbYISD2P49L7Uw5ScGZxU2R5GK2tUFMXbUOLuV8lvZXJlZnevZE?=
 =?us-ascii?Q?9iDU4zL1BefKUnyjGzNN3x55T5HIJYo7bEEAW3NJPLoNbSZm6+bXDL0v0biI?=
 =?us-ascii?Q?kNUlisXwuycyw5DI/MGKcgXqKwK05E1I5tv/dkV3hp7uuJevvevmP4yMYYbz?=
 =?us-ascii?Q?0BbRD4qWr1UvqLj9LQ0s1SqlSLTRjqyU/g6l0i2Bnc/n56wMNPRIhtR8zoJ6?=
 =?us-ascii?Q?CspxLIIFEDJSk398qIFb3y+LthGr4nJ1ZhkmQ6BadWZKgxQW7BKVv+LVjKZr?=
 =?us-ascii?Q?jR/r4CV77InvEXEGPwrd4hwV8B5vyO58DR0AuxTYKqX/3pU5DHXvOA6ujUT0?=
 =?us-ascii?Q?4WdcMQpboMlkOFEsIiI9d7SUvXJwml1ab4D/phDKaGlVnsq28CdeJhvjqTdP?=
 =?us-ascii?Q?u61bPDDAQr3Df6YOgMMPMPAxXsmVA+x25DbScGVVHFsRajLWFOekfJHRN++l?=
 =?us-ascii?Q?vHqdOZA1pfHNMd/LQb05jredaqBN7TA=3D?=
X-Exchange-RoutingPolicyChecked: PFXesghioVwm0wxnfyWhhZJKD+S1KiKARgZCu6zbqpezzu4hMRwWUJ/0b95Y343QEYLcvt/CApl6bTlq8HzBeYDErbZPdlcx222Tmugr4KxKOdVKpTK3tXjZlSJ6GskrlHEt7UZihJ6y2odc1Vq5h96yr3Z6MGd99dYggpha418qrVfIVNh0GuLIvrVk3eZtmpspJVzDbf+3cdt81lfbU+skvj1C81Y66TdygoIZrHpEUIzOKBuLniMuaOWOLR1bY0beqswDn+7aItPBxtPUDp/EmZYkqYuaw9+2Ds1VPaF5lB9gDtNqV6mVf0JwzqkCM9rL1w8NdFAAuukAbeaBug==
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b5362-b409-4589-0265-08de952bd605
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:01:04.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lz4R2AaO6fxv+Ktn1UQtIj/Bvum3WqCG8Kuecgilwn1TUcC90h4BUP/JAM0iMHqMNYRp+av9nHBG5arWD/nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8087
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233755-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gsse-cloud1.jf.intel.com:mid,intel.com:dkim,intel.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EF4C63B7069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:15:41PM +0000, Shuicheng Lin wrote:
> When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
> is not freed. Add xe_bo_free(storage) before returning the error.
> 
> Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive eviction")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 7f9602b3363d..24d9d82426b9 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -271,8 +271,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
>  	int ret = 0;
>  
>  	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
> -	if (!dummy_obj)
> +	if (!dummy_obj) {

I know the comment at caller says 'Errors here will take care of freeing the bo.'

But I'm not sure that is right sematic as this patch alone won't free
the BO give this line not seen in this diff:

296         return ret ? ERR_PTR(ret) : &bo->ttm.base;

So IMO we make the caller own the freeing of the BO here.

Matt

> +		xe_bo_free(storage);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	dummy_obj->resv = resv;
>  	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
> -- 
> 2.43.0
> 

