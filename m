Return-Path: <stable+bounces-164426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3BBB0F191
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888063BF524
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510352E541D;
	Wed, 23 Jul 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7hHRmB5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400926A0D5;
	Wed, 23 Jul 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271287; cv=fail; b=p6cIY/3AAMTjggwqgA1VaZKdc3neK2HEeQfPgwVghQ35oEROclyD7AK7DZQPdToU56s/c6K5EJtFysABP5bwLHOJR6KV0eFS2nHcUwTQI6bGUIYKc8dWXjBBHVbSOVvaMfYTpEGIYdgjTqrMzsmLkqEYYseDpKLeIVK9y8jn8J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271287; c=relaxed/simple;
	bh=PyoN73a22cJ9qFnUpbtDgy1ZSgyfY3PwjjnotRhUx+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NTN25RUtHWw9UudvCF2tMGshJVAg/IgmNmRtIZqa32aOaIK6c1G2EN+JhMoI0NpL52RCVhDXbnClSXHgRvZ3SAavpF212XzgJ4FQEnSvojkthI2TtdKd8qvfxv6wr9+1ElU2uWHUoNGQ73NHcUojfkNbEC/CxwucZcCG2+LwjYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7hHRmB5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753271286; x=1784807286;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PyoN73a22cJ9qFnUpbtDgy1ZSgyfY3PwjjnotRhUx+E=;
  b=Y7hHRmB5ia+xB037c9nywq7l/8G178A+Jby7C0hXGbJ/Y1NtTf1ur0yk
   tEcpTkxIse4Ozr14TsDn8I7gL65hdsyjGUnjbwrqj+glVLO2pa93Fis9P
   bO/ruug0aYW+iPG4cUMuSdrb8B58SvPN2LcUbt0iE7UtHg4aYsRt6kIjE
   9Q0A1on5nkDQfgqjkGMI0VKFNXfpPO7jWrkdFJI3ZcM/3PFSvAEnyemuf
   hb4cXnC72l3T9/OSBtoNgZWllhoY00oIDo97rfBGAy5/RRb6I6fY5hfID
   xhWO56eDa3QAjlDDEqBQLDxglVJh2SG3dFd/Dz6CHaL7I+GRv7r5+lRUH
   w==;
X-CSE-ConnectionGUID: 8XMDfkBUTnmIoeY27AVIqw==
X-CSE-MsgGUID: uUN5095zQ5WpVrZVBPZhsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55254940"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55254940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:48:02 -0700
X-CSE-ConnectionGUID: QuJWZDZXSkmeCVbsSJExuw==
X-CSE-MsgGUID: o/cM5vUVSGC8Ol6LyVnc6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159855724"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:48:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:48:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 04:48:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/cQBINRFtLcC8HW/BnirW928JqYoIm4D5e3UaXRUaF0NGmktf+5OSNf4QWHtnfvh2KJZ0vUB0CA0ia6l+ueLlye8CcbGPv8VOxWHblJTaExWEG6My4mlbKLi/WjdsVFpNtSJ9jDCoB1A0Q4ViA07LshYNgCL7vEFn9BA4O9Araj5jGm1+UzhgMnNW2OgftMRpnSya73TAC4mZN+2vnwI/7jiaFshTvpRPsLh8Kzd9uWwDmoQTyU3nfFe7u4+qMfbNkMXHBzuJ/QQY7Z6NXeYQVH5ftDBKnHzJN3lYCZsPl68XEfGilynDyV+2JeUfZWr59WSQ4VQmSoQyvLRyIkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rn/razKc8H3Z1BopZ4iXEO8xO7f+M+0j/FBcktsE/8=;
 b=VKR197DUxJjY2RhVlb1tB4dUPrnKvFpayaK/vWbMKDZSZY6y0nTK9+9rRr7Yvq4zq5KGg17ObvxMebXUbcHzneNQaylMZIX/t7Y1NHty9zNAVWKWgwIzr7dcyYu/YUg6ArMPnMvZRelE8ZxRSF/1/zWlXYQAZPbPbWZjGX7Us9tubwWC00nBGb2KUafDhwoFFMVqRJPjYVuoTSdoV/TQtz2UcI6wvFqi/EZhQGQkDnUhyYEgIpdv8+KvApw5k32kQl3f+jesk+WZA1HPNHHPn+tAYByXTC/Gwpnm8a7lfAJqO/IQ8OrB4HuftB0X3bULZKUXuuicFJTJVHEunPY4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by SJ2PR11MB8516.namprd11.prod.outlook.com (2603:10b6:a03:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 11:47:57 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 11:47:57 +0000
Date: Wed, 23 Jul 2025 13:46:44 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov"
	<kas@kernel.org>, Alexander Potapenko <glider@google.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Sai Praneeth
	<sai.praneeth.prakhya@intel.com>, Jethro Beekman <jethro@fortanix.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Mike
 Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	<stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072310-eldest-paddle-99b3@gregkh>
X-ClientProxiedBy: DB6PR0301CA0092.eurprd03.prod.outlook.com
 (2603:10a6:6:30::39) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|SJ2PR11MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 0099589f-1193-4bec-a2d5-08ddc9dec492
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?743c5ubnWOkSrBlmCLv5rbDsAnCgs/3OAhrBTMN8QFHaEG+nP7FLmu8KG5?=
 =?iso-8859-1?Q?xYzvSLNhF1l8atoo+lH1E982lT2gGSy7cW8Gwfcz1/64R5+cnUBaDY/oBs?=
 =?iso-8859-1?Q?6XhZC0j5nv3QEgliIYMSuSS+vDEclmCE610/Bz1OW88tPPXGbJiO5eKeUN?=
 =?iso-8859-1?Q?NsxHpBU6DkSHGv8RFH2bA9LzJjDWzVSvUNMtk2Dsdu2r2+ZmOmZpc/wfUu?=
 =?iso-8859-1?Q?75gwYweehws41FciutrIMsMfa3IqVjoNIkCaD1Q51G7DtmrcXCas3UXL6p?=
 =?iso-8859-1?Q?hJOdpPAoZ4rr1l4+9/9sGlP++DaMZ38XzuC3tgcu+rgevmijKtMRv+pPiZ?=
 =?iso-8859-1?Q?8XJ2b0WBFgMxvbdZSsZGcpo8FHeZo9PT8BMBmz8w14re+bk2phAC88D5pG?=
 =?iso-8859-1?Q?zRJz1k+WdQrHm1CePi5Jow0F6YgvCBDfDw764ohRIH0slgXdvpkMYALDxI?=
 =?iso-8859-1?Q?T+86EoTZwQLlorm808ry8bsMftvsftDJMCpxM01iIic5DevKcujUYxWtBK?=
 =?iso-8859-1?Q?wat/VpIJhZjCC1er6pN7HcVoOuBPGVwT7m97+SKitV9+KSGJnKESe4i/kp?=
 =?iso-8859-1?Q?yjy3Z4lqGi6pjdjUXvPIAchpku68XDAbWpvD92JhtTfBQla46ATMU7yLBI?=
 =?iso-8859-1?Q?Txl9iwwYwJatNJnev9q8pm48/Uek+UcKmq459SHmkw5j8q6GZyjTThVEV/?=
 =?iso-8859-1?Q?RkYrpYCy1ehHepiXTn2N7hLwiJxYIf1rI8dq5NzkLu9uRMLqmAIRj4WIMc?=
 =?iso-8859-1?Q?eW9m8UKrKf37BEAXqWwAPNKF7b2/9k8o1+L4ice1GyRSqBfvBIRMo895Cv?=
 =?iso-8859-1?Q?SiGfZl2wO31HhPDBr3XrMvzPesMeS302xBfZLfP/cLJrqJItZleUMEzgSj?=
 =?iso-8859-1?Q?I14FP9HSoD2fmraVSQmnQXP8+Dn2Hci2Z9VgOptiIOF7LY4lvUgWFwFG98?=
 =?iso-8859-1?Q?gQ+U3IuAxhlui3EiFcrPPaRjV54TeQVjTREBwosjmDMdez1Ib1w/r7gdQP?=
 =?iso-8859-1?Q?TZ+ZRrflYZ4bLRIpIuG/L2jdrMBzCDxNOn9tjh+DySfenOEMjTjfhgR4WV?=
 =?iso-8859-1?Q?7f6R/SMCJdlZOOmWmmTsPg4v1k1Jc3iTtTrDIX3GNI6KiQd9TmoPkqWU8h?=
 =?iso-8859-1?Q?DIYCaiVa6Bsaq956jPyRsDxADsMLKX8AlIIVePlJwpg6HxFXADa/uJF2HD?=
 =?iso-8859-1?Q?4TzzHpKnl3BQYYtSB+T7vKcG9OZFNsa4mZJD9l+rBvN731kecddse4qXpE?=
 =?iso-8859-1?Q?HLXiquF/yS5ybmesKWhiMwqGok2PSdk2VOCv+6w/ECI17Dm4bEfjjkilET?=
 =?iso-8859-1?Q?Q+6dfAJKGx+Z9SzoOXmzjfDvzPTcjusinhYbKTBeGN0KdVLaV+6TYQza+Z?=
 =?iso-8859-1?Q?3qmZyeofIy1SdjMU/J1B/ZF5vgR2FLDvIeBQeUYIHIt0YAVGdCb16YOXa7?=
 =?iso-8859-1?Q?MroTnTpRqo43yOoNUCxO11QE9gHackyh0nsM30nsCn2Cw/YyZbEma0+yMR?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zcB0l7G+XuXak9TI48nBHEzSufnxc9iS8JBgfnX7L+AQep9wsyeT3F/7vL?=
 =?iso-8859-1?Q?Ot88ol6MKFDJJ4vEc8F8XCweUSahaN1Qe52K2uF47O6eo9h6/SnRJFoS6J?=
 =?iso-8859-1?Q?OoEuN++TFcTaVGSYSQO5K3+ZNl/GcMP55u1kvkk5qtSdmHiGOpFeOIMU1S?=
 =?iso-8859-1?Q?Zgev09ktlKQChZf8i2zJ0jbfOlikUAA4bw147kDU4Yf7FhGT4KfA4SE3l7?=
 =?iso-8859-1?Q?AuU+g4kUcCnnKLMnvm8WT1BZiJA3oz9chN/ZO2NjCgN+4RTOrlJg3dCzWI?=
 =?iso-8859-1?Q?iquJts99tEgIfpwv7u6j4mEP7MrD3NZgmuRYLeUX9sr2EnqXpQDaZxF7bW?=
 =?iso-8859-1?Q?1g/nLuYgCiO8yN9RcJHj2O9YnnNch4neOCX3q9BebytBjxKySPcg7P1v6j?=
 =?iso-8859-1?Q?mMjvAtMd39W9+wUZTsPl4PChOTDyEmLob3heHHzKIa3MMmFjdVeoOSdXGH?=
 =?iso-8859-1?Q?CEignmObBmUZNq8ipNXbyl5ejNKNA67x+QIZN022mcUGA2kJlLpIccvkTU?=
 =?iso-8859-1?Q?wtV6z8A4x2HqmLEHE2HOd7HlyarGUvVB4njL7zb+mrteIdhEPiHKPSSSl6?=
 =?iso-8859-1?Q?+JhUjgNXi6alT1rQsFkYGli9+2TujlC5LIbl0quu5DCaBGE7GP7/iTPPht?=
 =?iso-8859-1?Q?sLZyMc5Ugr1Q4D0f9Rq3Ts8ZsHtlYpzad7d6bDHAmxjHrHD8XNCODqPiOn?=
 =?iso-8859-1?Q?XRB9gkV5qidrocnGAYGPbi4ZdHwd1UUycjiHgS0l4E4QxcC5sgFSxNepu8?=
 =?iso-8859-1?Q?R5g/oqWfVAoDBUc4TudMtbxad9NQgd2AebNpqjyQlR/lmlqMRcYHa9r7qr?=
 =?iso-8859-1?Q?uOlWKahwJHNbbUibvJ46dmq4hpwLLtDvhb7NSkH16weekOZ/3VifT7pdlW?=
 =?iso-8859-1?Q?ygdx/unGbKErBrRL7eKvxoQ5w0He8ZooGL7Zs7+9OqY3gbem1FKvpCwVJ2?=
 =?iso-8859-1?Q?MrZYb/iTl2cFI21a9tRG2taBtfOQUDnhoaoZLDGIC7JFOsnLGKiCgdTjQH?=
 =?iso-8859-1?Q?FM1qtloLDFM4Sq9o05mwx/UkHknG976ZB7cRw/R/qe4Ic4sPrS4oIQIRFg?=
 =?iso-8859-1?Q?yYenkCJllG/6iEmwrVvDSPh+dpHPTIIG+iVke7ayyhRyU/pDogH88zW5xt?=
 =?iso-8859-1?Q?2jI4UrQb+3sjRIxC3uPguPtdXiqESbEePK9TiN1CzZAJhFgSFO58ma0zxE?=
 =?iso-8859-1?Q?wtkbfOp6rOmbwptm/4nQNUtm2HidORO/kmfZmfZdRn2F+DxUgeqVrJwszZ?=
 =?iso-8859-1?Q?ERq6J0yfb490IE8uyUx/vc41W1FdnU8d/OeHGQCuDMFaVEmg+kvtTo/9FB?=
 =?iso-8859-1?Q?NLtQuqVErfXpT8mx/l+Pjvq1pr3KF3vlV7oBBKwYTzF2sIAH59yOZJv8Mk?=
 =?iso-8859-1?Q?vRTIjZaAgYmMuwE9dNGAyWydAhnKYi63+5H2ii0SV6GPshjsrF9PchT7WQ?=
 =?iso-8859-1?Q?5NsSuQuOL/FCJ/VESgH4wYB0RauIPXDC4QiMK5qZNpec0VsvM3v3crkh0V?=
 =?iso-8859-1?Q?vAb90WBb0QlIHBMeVAwp4enkPzpxQbvenfn295I4uC0pFQITvp5CeY0gHN?=
 =?iso-8859-1?Q?uAvrL0HmM1llQC2CpRcrof42Fl3e/mP13KPaPWs1n+qKvJ9ZVkaOKMNQ0i?=
 =?iso-8859-1?Q?ZwhnoJNMIJXUyUTdiDLcSBDlKgv5tMVK58I/OTXHWWpjA6Cw5izM0Kf3D3?=
 =?iso-8859-1?Q?w430csZfGUeYJRarnfQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0099589f-1193-4bec-a2d5-08ddc9dec492
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 11:47:57.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RKZdhEjJS2uIQteyTFaPBpCF4dUmtmbNVbJWutM4Iq/Zwhwdze2QhGX7noZRxy5EcaJm049IkK9cqLZV0baT5szx+VVUO7XjVjCoQvAIM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8516
X-OriginatorOrg: intel.com

On 2025-07-23 at 11:45:22 +0200, Greg KH wrote:
>On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>> If some config options are disabled during compile time, they still are
>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>> this_cpu_has().
>> 
>> The features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>> 
>> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
>> feature bits bitmask.
>> 
>> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
>> contents of the disabled and required bitmasks respectively. Then let
>> apply_forced_caps() clear/set these feature bits in the x86_capability.
>> 
>> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
>> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
>> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
>> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
>> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
>> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
>> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
>
>That is fricken insane.
>
>You are saying to people who backport stuff:
>	This fixes a commit found in the following kernel releases:
>		6.4
>		6.9
>		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
>		5.11
>		5.7
>		6.6
>		5.10
>
>You didn't even sort this in any sane order, how was it generated?
>
>What in the world is anyone supposed to do with this?
>
>If you were sent a patch with this in it, what would you think?  What
>could you do with it?
>
>Please be reasonable and consider us overworked stable maintainers and
>give us a chance to get things right.  As it is, this just makes things
>worse...
>
>greg k-h

Sorry, I certainly didn't want to add you more work.

I noted down which features are present in the x86_capability bitmask while
they're not compiled into the kernel. Then I noted down which commits added
these feature flags. So I suppose the order is from least to most significant
feature bit, which now I realize doesn't help much in backporting, again sorry.

Would a more fitting Fixes: commit be the one that changed how the feature flags
are used? At some point docs started stating to have them set only when features
are COMPILED & HARDWARE-SUPPORTED.

-- 
Kind regards
Maciej Wieczór-Retman

