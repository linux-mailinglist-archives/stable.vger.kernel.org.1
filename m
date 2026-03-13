Return-Path: <stable+bounces-225378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SECIA7VctGklmQAAu9opvQ
	(envelope-from <stable+bounces-225378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:51:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE1288F81
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC5573085BA0
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4473CCFC5;
	Fri, 13 Mar 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNzL14dL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F4305962
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427749; cv=fail; b=gqOGC4Iixbc+L3e5+dNIgnXK/1YbQ/q0CacUiRLaS8zHgFv3yXJnwnI53jZIwFqw24l8IS8JjpjQWQsQKc5zzMkUhVKSiY9JC/jzfLuuoXSgemuWBxIHwdcLFG7Xkp0rzt4PU94FhMSIiaFnyhV7RUMjVdansbOBI4MU5g7uChc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427749; c=relaxed/simple;
	bh=CYA5CKgKcgOYE+GYgZPAZ8iMbkP8tG6vaHBEwJgm+WE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slLjlogNuZcPCOFjB6/OQ2FY5ZVMBs3lSqricKvwCNjsGaVHF1I/xSf4FEP7g8OtPNzAITJofxtvJC9vRwAYda+ZmcioD/ME48PxqbGVmp2zCb+n5ttNUBgB2WzP2vRgqdpzPb47wnfzWvKaeiWqQEGhSlBWTfIIci+sGoUbcaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNzL14dL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773427748; x=1804963748;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CYA5CKgKcgOYE+GYgZPAZ8iMbkP8tG6vaHBEwJgm+WE=;
  b=HNzL14dL6w8K77/VlcfjGlfBCAfMn+Wcbqpo039NVtv3c1TkkBJ2SKS/
   E68/y4GzpHNpLwwTKfJFA5eF/geCZ0yUaaYrwW1HAaiAQ3jXAiXtucYGm
   v6AVBJPeQQP2oBU2BP2mYEnKi9yGl1Ktll6jUOLNkRwLKL2APWNcG/GsH
   NJ6bVf/WtkfIMJCJmvka1bTGRrE02VlVRc39I9IVJL5iqk0VTZJNxQJPU
   sB+krAWSdiRtRekT0ETNfPfjQ4zY/OdlREeeEOp4WmvGBlhSGt+YaQohO
   sdca8E622j/pBWLE01T4aIIG10d2fx0VAI8NNXLPWQaXMGC5Gh1FZy67V
   Q==;
X-CSE-ConnectionGUID: +JGei8jsRq+AZkUzUUMYNg==
X-CSE-MsgGUID: G8Gsxg/+QpymSfPO5d6iiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74241978"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74241978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:49:07 -0700
X-CSE-ConnectionGUID: jVysZQP8T+2O2zAs6eVbcw==
X-CSE-MsgGUID: jhNBb7zzQdi1DVf+n5HPHw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:49:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:49:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 11:49:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/ubVEo5o2uXWw0qhQ04WK7Q2AqxnbDEZgX+0ykxQbXJdpRA64ozEQw8Pc0jDqIR8Uo2Z2OeKoAFsYTr6mTujuhvyyw62IN8NhsnDwVUjghg6MToR3GUsbPESiI16NZsMgbAOr1RiA1X5GHNananGCMjD77gJn68o1cJXd7mY38+LHggxDHRo3OG9o3crmRj3OtbBmk+k/y2NttSUlR+S/fyh7/ywyN6eKq59wlKn4LkEe82upcVEiWbgvn6KxRTtcmW1R2OtOe/F+FzZAmEcQ1RC3H+p6KR2oKkNENeGXfDV1Akj78Dj2tOQvXZhwgHrumjsFKXubHUlweVhyYb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lb61FqVuN165v2HPhPd6GNc391LfGZv1BelshOxouQ=;
 b=CIgbBNG1x+MMV4S5sDFivbPNe21QigvMNA7aPx5TVZVONiZr8RGw/7EVyYmil3UBcB1ruXvwExIaXExn1KkFn4fhzrgywJ7vfp9k3kDkqUwM8pTFCmv/Xd2f2AjLtdkC/iLEJGRVa5yioKHVZxowPJvRyCNkfQrjgvYQl6KGP5jQnpue8Ff8ovRaQl3l3aiP9xuBEB22tzesqDvIOVnVMKy1YoG/LVoCIz4WK+6lFJeN6YY4u3qaBHUp4+Sz9KTu3Z2wGTMe1BCK3W/UYXQkxdbFkobJ22f4yiR84DjQ4xGdQ2FzIW7/6d5KUAknMTfTm4hhh9sDOO1TcfvCedLvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 18:49:04 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 18:49:04 +0000
Date: Fri, 13 Mar 2026 11:49:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Dong, Zhanjun" <zhanjun.dong@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] drm/xe: Trigger queue cleanup if not in wedged
 mode 2
Message-ID: <abRcHpXsfB/YVC3e@lstrano-desk.jf.intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
 <20260310225039.1320161-4-zhanjun.dong@intel.com>
 <e9979dfc-eaab-413e-963f-a50985018e18@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9979dfc-eaab-413e-963f-a50985018e18@intel.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c8aa14-fb76-4f3d-abc9-08de8131331c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pADhhbsZUUJMM1yzwFewNLFzxkNH1kixOrQ3/GjYcV3FaDtOAQl/F0iq9jnsJ8eop+36nxLhmftQSZf8GA7AcAnaeTupPNNIPxCYyMMlkU3nQjJ2asX4KPDztQSH9x2RqrM2x2LgSGGdH/RcaqGaMKAunLL0tHqwKH/8ZS1PEA4smiVUFwNdGhGYIKR6N1PJZv5lnMKkD/esF/DvPV71Qu8oVn9tuE3jihu7xOU/55fmjgU+1bOtqsI4CSxz0+zYv8sisR4dDUAhIWFhtT/xb/S6308ojbWsq7QXvMOaoBTSSVFEGMR1wjkKce21x6pvQPdskdKPtjaeXkRkZH86VnjvlhlO8UgyavbIK5gqajqpRDA7RxYIYjueDEzEELwacETseEm+mzgb2Dk8HDCel7xWfx2rno5JDHua6lM01U4d4BinG8J7TyraJrLqSY2x8tVsTHT7uw0W0H026GXrLtz39YaESLM7YHQqKLjZYj853asknjPUM/4Wcx6y8gooW6ml060Kt9rY6hKkLAMy8jzGy7V5BbdsAzUs2kjq14ydUtwdjFkKaWAwil44QmNflDlnJlKCNUQ86ehHvV4fPRcoMNC6V24zXyFVM+b2Uaq26wu5S4f47QP9pwzhhnNmKKdsMFJOa6miZBuUHsJ3qDtUwLhNDgJyQ44tWxeub5RfZ/rQ4x2rVQQS5vYHitb93S7W42lsl8Tk/7l2GUlLZQVyCQdUi4mt+lTQnqvCD3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMZKewjQXw2jLBCHwFD8GzuiO6TDc4VTDHu61SORrRcEIj5wgsqHOlCRZjoK?=
 =?us-ascii?Q?9RsSV49TNVz939hhPcvS3yWUbaGMTPSVlz4dbesThjkyDJoPr+p3RE4R+xA/?=
 =?us-ascii?Q?s11oKDlTdqwXZMj/cKfpwOKlyc93GJzRJ6XUihAMDXdZ2UXdsOuy2M10JOh1?=
 =?us-ascii?Q?CMrM/mel3mF37yQd05BCrAWkbmtY0Fn2NtrzUi7OkIj3BMhkQgg0/RQTO0dR?=
 =?us-ascii?Q?0u1LMfohV8i1POsh7h2Ce6GUFbZvjS4PLJJxIaswiNLKBIkeM01o/ub8/uvy?=
 =?us-ascii?Q?cWcIleDz0bYAYby28d+gtFP1LmkboHTOwKY0o63PmEU2EkjB7nOF7L0Hmgsk?=
 =?us-ascii?Q?Q8P7PnTllIgeuLMP+nFBuzYH9kXl6NQh7zGy2n+3DfW7sZ3N4xc2o0zZUAM/?=
 =?us-ascii?Q?bD7EU7kBf5KB6G8BE2FtR3ubWMUyBzu8aZUsyE8Eb+zydXLrZDsWN1wx2tiz?=
 =?us-ascii?Q?wRE8mECMx88EY92TbeRGAkdJO5CJAmlH8yCBp85UZ6x+TVrlTBMXcz6R09gT?=
 =?us-ascii?Q?qW9lEW+DbNMGwloYr0dpPALCtMrs0ncgzmCFmFGJml72l7qr85W/0yj1dnig?=
 =?us-ascii?Q?Or6nj984Pd8aq95b6dhLi1BH2/9UhtdAC5J646LykU0xjeiUMORhWZy72cA+?=
 =?us-ascii?Q?eZeTqgz65pIrX0+B4xXoH201Z4EPpKkkhw/QF8bAISLIaC3ghS8a12I8MGL9?=
 =?us-ascii?Q?/txbJ4afy5rJa3zncllRxst9MS1QuMMEFQR78vLfa9qVjo41UH9OIO3pvdWy?=
 =?us-ascii?Q?V6Ppl6CcefV5YIePYYtd99aRyu4WUPK9Kk4p0oCeNPC5hNNLaFxbpF01dKIQ?=
 =?us-ascii?Q?JGPRMtj+rTfrNCAieh2UE1XyrAIB0Qn8RkPJwuzeOTCHAdCTeVAjBYu6tD5c?=
 =?us-ascii?Q?P2q3epfQs0hmLzKpyjRm0C3zV/s0AE0r/GkjaHPudfyICyizojl3P6wPFntU?=
 =?us-ascii?Q?iLSQtfUeEgTMPW3d1qBiM67v6V/e0Ry1fILrc5Btci+hvmKGOseVw0qWG6Zp?=
 =?us-ascii?Q?jLCAEf6PCEOD+G3SVMgeG2WvGXBh60VQDN4kj2aLtXVgj4OpOQEuS3lrrt6f?=
 =?us-ascii?Q?9YqYbw2npU89OqSobBkKt3OBrQzh+MUhIOQKxbt9cLBg6SDKni5BgC+p7nv1?=
 =?us-ascii?Q?2H1DzcXApjKuC1mqeI7WuQI8kWtcnhFjZLW9P5jzmzff0hK98L+vUy0f0Mlj?=
 =?us-ascii?Q?2MuA3MPQE6FVuJKzjTkUUerhKYjeBM91VbnxyBmtUFzuJ5qgg0LZ4eGW/KQ5?=
 =?us-ascii?Q?6NaePuo0inNb4j+SEJIL+YdwWvkUYIWZER+18gNMMcUEBsZDT0+4V3u4h8ke?=
 =?us-ascii?Q?XJHUzaP80HYYg3NmtXTkrq2UEbgxSGdoRgdPwm3x9cs9JaCCVLZ0I8gTddfE?=
 =?us-ascii?Q?as6s3UHPg4KIls2KLw2WVn88djkRUnm+Hgo4V4XL4ZtG7upInnyAMqJNO4ZA?=
 =?us-ascii?Q?CVtjqhYfurtrGi/A/g8pxO2QdpoWZUL2FNcZCE8Bdz8cy+6bmR0TO3hP+Hvy?=
 =?us-ascii?Q?1Aqvnu6sRnVKzvX03YFTU6o/EUW3U3ug+c524pEEFzzX3Dcd7JE2BO4jtNOR?=
 =?us-ascii?Q?orXgVyntM+CTTjGnasemli47KTv3sUq7hpp4JkfJzDQU4OkJakw9vIQxvGEs?=
 =?us-ascii?Q?5BRBJqprQmyGt+MM9et1elL3RFgouo0RTVIlmuBTmhJjbK9XVcgGPcer6YGH?=
 =?us-ascii?Q?efQwGQpjfagAUxKc+hLE9w0TpUu0Hm1wUZQ9F+XgIqDAmtpW2dXvEWscKUG+?=
 =?us-ascii?Q?jH9fLxYL2v5UCYmtej+RuT/h8ndzwbE=3D?=
X-Exchange-RoutingPolicyChecked: u82r7/fC/BhSeO2MPOYPfpxDiwSv16NdxQWIlcIjCpq4d58yNOFpTg1prwYCia9qlbH/8Ao+bPYi+WylX3bZFnroWNxWA1PEYwl+aWtWyVvXM4z8Xnpn/URaocPv3g0vnDpGf7D8svmV/DSRQtmG+JIlWcoCJsIxPxLvDnFcq2lYdCxtOlkUFP9g4d26Fc2fBkl/j7sHQKySnRTakYX7iGG2QUBc1x0XcH8B/+iHyOfWG0lhNkfcyXJosmHNHTLpfL64PnoodKH9iB7mpsPtVvnjZcmJOGJJhnLcWbosoKpNL7V+QUmWF2GTpUkwjtujBo4ZBgyk+n9BryvdcffOyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8aa14-fb76-4f3d-abc9-08de8131331c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:49:04.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD+vU9nf0D+0n5UcSr80xEb058nO0Piw4Hrg+8WXqAK6oyuLGXzuwA8MxoiPNeu5C8T4/mXIvCI2a4lGkzrWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225378-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lstrano-desk.jf.intel.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 75AE1288F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:33:54PM -0400, Dong, Zhanjun wrote:
> 
> 
> On 2026-03-10 6:50 p.m., Zhanjun Dong wrote:
> > The intent of wedging a device is to allow queues to continue running
> > only in wedged mode 2. In other modes, queues should initiate cleanup
> > and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
> > clean up queues when wedge mode != 2.
> > 
> > Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_guc_submit.c | 35 +++++++++++++++++++-----------
> >   1 file changed, 22 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index 8afd424b27fb..cb32053d57ec 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -1319,6 +1319,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
> >    */
> >   void xe_guc_submit_wedge(struct xe_guc *guc)
> >   {
> > +	struct xe_device *xe = guc_to_xe(guc);
> >   	struct xe_gt *gt = guc_to_gt(guc);
> >   	struct xe_exec_queue *q;
> >   	unsigned long index;
> > @@ -1333,20 +1334,28 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
> >   	if (!guc->submission_state.initialized)
> >   		return;
> > -	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> > -				       guc_submit_wedged_fini, guc);
> > -	if (err) {
> > -		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
> > -			  "Although device is wedged.\n",
> > -			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
> > -		return;
> > -	}
> > +	if (xe->wedged.mode == 2) {
> > +		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> > +					       guc_submit_wedged_fini, guc);
> > +		if (err) {
> > +			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
> > +				  "Although device is wedged.\n");
> > +			return;
> > +		}
> > -	mutex_lock(&guc->submission_state.lock);
> > -	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> > -		if (xe_exec_queue_get_unless_zero(q))
> > -			set_exec_queue_wedged(q);
> > -	mutex_unlock(&guc->submission_state.lock);
> > +		mutex_lock(&guc->submission_state.lock);
> > +		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> > +			if (xe_exec_queue_get_unless_zero(q))
> > +				set_exec_queue_wedged(q);
> > +		mutex_unlock(&guc->submission_state.lock);
> > +	} else {
> > +		/* Forcefully kill any remaining exec queues, signal fences */
> Q: Shall we do VF bypass here?
> 

Same answer as last patch - no.

Matt

> Regards,
> Zhanjun Dong
> > +		guc_submit_reset_prepare(guc);
> > +		xe_guc_submit_stop(guc);
> > +		xe_guc_softreset(guc);
> > +		xe_uc_fw_sanitize(&guc->fw);
> > +		xe_guc_submit_pause_abort(guc);
> > +	}
> >   }
> >   static bool guc_submit_hint_wedged(struct xe_guc *guc)
> 

