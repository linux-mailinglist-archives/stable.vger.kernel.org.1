Return-Path: <stable+bounces-164432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD07B0F33C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9705C544C5A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A12E765C;
	Wed, 23 Jul 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX8mh4f1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772982E7BA3;
	Wed, 23 Jul 2025 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275893; cv=fail; b=kBJWM1rX9BW15IPWtiBxh8EhBI7Ii9UCn/dLRdv81Hu3sUwDmdlRoe1KKWbGtt7mdyTqfcslpaZFHcqpN/ekiTtb+lyj55YTePEhjyVRE9euDYtComumE+9U8BpIhC82OAzLRiupYFQ8UWCBpRRbXiWZfYzqi72YL36P+0dQfZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275893; c=relaxed/simple;
	bh=v2WnkeXcwvXFd8uYSJ6JdhzwW9Pmw4xXWlS0ylH5te4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d83L9ZIankBfe64I9rNKH3gTDIfRzJjfqafU7pDQqcep9+O1aFnk0osB2GaxmyBFpddKoGssNcIp4irlUFUDsX1e+mySnlpB0hLZdS60AAS1wkYepfua661d8cv3skWrQ19Wkjz+Qbj0P0h4jkQJZf/Z6RVYKxW76Dm1nGDi9T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX8mh4f1; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753275892; x=1784811892;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=v2WnkeXcwvXFd8uYSJ6JdhzwW9Pmw4xXWlS0ylH5te4=;
  b=fX8mh4f1FvSt6SEjg+0TscVV+E2D66nxG4Ghiv5p4WtZhMwxFW+q/nlt
   Dkp7g+Ae4wGOm0LnMpWsU66xWatPQy/bJWgZ3qYHyvVh7xx74mCWN4n9U
   iKxSbZYh+E9gvpVr6qlZ3FuBr7C2gp9KBKIZs8chCDD7jFLCBt+UrQx/i
   xVff6N0M6BMB235lB5y+Xhn+yNqp/2fvy+xqjoJmd2UEGsQ2VWch1ca/9
   cq27x/uiPTCWRmzzfYfY0wGJhIZCFpy0i7cNXp2d1rgVgjno0G2E+medi
   A3GQtRkRdOTSGZLAA72s7CErwB3az65Nimg1ycbzhfeUfZLopkA1dcrwo
   Q==;
X-CSE-ConnectionGUID: 4Gynkz7tRn6UG+zNMh27Aw==
X-CSE-MsgGUID: AuaTEp/vTVC/9+m/6nQQkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73013657"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="73013657"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:04:52 -0700
X-CSE-ConnectionGUID: 4SFA2YOXRl2L8QqlcmpNgQ==
X-CSE-MsgGUID: rHHTQwZERg2G1Ln4xRXcdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="183180257"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:04:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 06:04:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 06:04:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 06:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW1HX+Lii5oV+TwyLSMHRLzgHercF/bLJ7IT2HnNEhTjIF70jmarcOaG2PEpBuL2kNXSh88Be7Un3O6jPOSaibgS83PLVA8u2asaRDaNMi1XZT/y6+zf2Vb65/RmsBvo8Qzg04lct1lQ4Xtj8S08f4BGzqwn+bmpjVVmpRZ8pIQlMZlS9O67bFmLXZkDtB2pqmNPDxbf0k/uj0Sstw9PfH6davM1P5XkyPF481OgfFw8F+K8FSqKW4hzr/pLvsQBUNgc7ROeUq4iFoM3rVmkxdb+FmEmHzS+wUVw9EBHazX9yBZyotm9+Ru1SylWuZPUxa8P2X5YadwCZUbrHrp6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeRJbYme3xesNINpxVotDPT/QmC+C2YXaemDIL5mt6c=;
 b=m7AxPp6bTg573jFz3n77D9Eo6+R/0Qeu/7oQIi1IOSq1ABcMVI+7fU+3f2u7xXKgpvtfA/euQJTk+l2B31mZqpY+TwQVJNe35DqcslNnoox/vWgWNB+CrdzOa4EVAt06KEF6rC2ig+U/8hL2gVP/N+0jqujXffSCRqrShjXoWQfsHDHURnEN3Hfvo82BO/UFVYU2+DYXrOvTYZJ8Jk7jCK+N3vEDULINLsWPv6D/JOQO5I5DWWTWiw4Sc5MJ4Gu2bgRtd95W9dFG126f3jWRSdHoxob7LA7NkwFbLAAXrnXU0Ry3z84+X9piQj3GJDy88f7Qcn1zq+poD03gHC2ccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 13:04:35 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 13:04:34 +0000
Date: Wed, 23 Jul 2025 15:03:27 +0200
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
Message-ID: <wx2sgywegtnbjckalxgkbuqib7s26jkwznazqfq3frrllf2ybn@sskadn2tutmh>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <2025072310-eldest-paddle-99b3@gregkh>
 <5pzffj2kde67oqgwpvw4j3lxd3fstuhgnosmhiyf5wcdr3je6i@juy3hfn4fiw7>
 <2025072347-legible-running-efbb@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072347-legible-running-efbb@gregkh>
X-ClientProxiedBy: DU2PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::30) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e7005f-9bcd-430e-4c8e-08ddc9e9788d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7Csbyn9E4ktWUF4b0USZBFt9QiSco+lhCOPLT/Dx+JfG1aXqMUosIJpbq5?=
 =?iso-8859-1?Q?tuP0pvzVmo4Uylg8t+FqguNR/QD55qMGqj5IvUBHl60I1KUknEwpta5YFy?=
 =?iso-8859-1?Q?2vRp7QcNxrvYUnwYjTMF328mYUBdMWa88Zwgr4y4vPQJdUBndLxuNXgdL6?=
 =?iso-8859-1?Q?ZcjZgw5hsl8xR3tb1Aew90w77d+Slbq7Xcxyz3uNHoR3IgVy7mDKIYVx3/?=
 =?iso-8859-1?Q?8evzgx6tDZ9IWSVd4QOHfmVYFierAadcmjuk4ututm0zKR9uGdjvv5Db3I?=
 =?iso-8859-1?Q?i28+RVFR7JuybCW2ZVhjMv1XpmWDZ502963UHj68jSNhLkvyioS30tBnE2?=
 =?iso-8859-1?Q?hlJNMNOaDxMi4Ew9xt8B1YIYVLwv8DPUctPMxMg+sAdxlAiDOsWzh4C6Wv?=
 =?iso-8859-1?Q?orHmQx0n/m/ZVthxboz+zDSjzmpCqxC6d2OYyMdT45z4fLBKIlaUEvEe/K?=
 =?iso-8859-1?Q?9vgtVvAH2U7MpvqXPACmTGFp/XExZ752u8PT3IoJYg2bBPTdCdA3Ym2fP7?=
 =?iso-8859-1?Q?q2V8pV13+5WAwumEt29TTL+z/TsbhJtyNiIkmcJBCCPSHsZBM3l63KzhTN?=
 =?iso-8859-1?Q?YXQaNZxnpXJw9yINBl5enoek4hlixUIHjEQLlb3Vo30/vWCq2OH0A/yEXr?=
 =?iso-8859-1?Q?pDr9S39XaRYET2hVYqUdYUQaO0DEpDiy+Ca3nbeBsSAd/dO7zu11PzMawt?=
 =?iso-8859-1?Q?BSwNTO4PSly6fbM3Wq/OX4jeSw+VgM2MSGh9WnnfKCoHIHczwQAz2YMuCO?=
 =?iso-8859-1?Q?vEMWPWbLBlcG2wwF5lqtmwa+22KrbjvCCY5qd62nSjwtJHLe/qVB2Acz5D?=
 =?iso-8859-1?Q?DX+M+FlHU7sxl78wKOqy+Jg6/McVXszps784m/B3I4fDBrNzujcsPWYPyc?=
 =?iso-8859-1?Q?WJCCVgdzJXrSWzu9NM3KxeO1J/1JV4BMBl12zwcNACWd5uHPL7A+TzsSTL?=
 =?iso-8859-1?Q?JMDEyc7QlPgHS0flT1awR3uYs9nni6tH/YDUc09abKBB4qO+xt4j08m8mH?=
 =?iso-8859-1?Q?ezP5tiCldod8TwFxzvkXJvdQxg+UAXvCXp66i8fbFpaq0ePFluKK6p5xoA?=
 =?iso-8859-1?Q?wWMFhl5pbDP7ZPU5fHvyC3JFlP/0P7mUmQyEkqgK8H7hQd6JpqYvqwhPTX?=
 =?iso-8859-1?Q?5/nGgfTcy+ChIkFfH8Z6+L+gGKz58OP0ntpQtb3f2+8bXdRaZC69BVGDU7?=
 =?iso-8859-1?Q?Gl7ht3jTAAe/bEULW12PcNvqURzvRxFjZ/a3pD+KDKIBJeGuKh08eDV7sD?=
 =?iso-8859-1?Q?/n57att/BZMjivKnz36sulU/pENn2xsRfaROEkb2p3I1ja9KRxasIBJQ5l?=
 =?iso-8859-1?Q?dLgadpHgVQVlT/G+1C0TzUHnPlGU0ah7PYc/BVXJWSiTsDSobosfhQqX1s?=
 =?iso-8859-1?Q?MOQa7wM9uE5cThINTE8z6Wc2clLlcVjnqrHAxzFfXLb6qD/Oa/FDIdnAUk?=
 =?iso-8859-1?Q?fR6o3Ba/POh8ZD6nOrMQJ/2WRqEZzMO421leVDf2cQTbikrk1GIu7G/2OZ?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nLXjIl5/yd5NoxB7XXiNkLvdcf+KOYNgN1Lp3KKeZAjQz2pKWOcf2zSJY7?=
 =?iso-8859-1?Q?fWp3WuQqJOyW/DJN31NA0+MRcizAMwkPa85OBMUbJabGWo80F5u3dzYO5B?=
 =?iso-8859-1?Q?S0jDi3fHM2E6lr3XoihUiMBCc/p2JoT4Ie6ZYN6TEU/UZITX4OCpRFyTrv?=
 =?iso-8859-1?Q?zdGjAJIxAONkApdIEpxV3/AR672pJAvnDmC82pynJO20FPZw+CL/Tyt5Jp?=
 =?iso-8859-1?Q?vDVZnT1XFDWIeMZ/VpE5GSIeupYEU1aDTzIX5YHdFpJseLryX69scxjhCg?=
 =?iso-8859-1?Q?i85i1mVw2uJcgrhxXq7MbS9JFRf6I8VmQslx5Wp9IqmeUdOZ3QNL27iU6R?=
 =?iso-8859-1?Q?L81wI+I5m+HN7SyOV+MKXA1/LdV3h53YMhl9BjTasM6QI4GN11N8/2OetI?=
 =?iso-8859-1?Q?NbaAgz0EvZoMdrwd6/O7zkYnQNVLnf/7VdgmqxgF+FWmOlNRgKNoHap19L?=
 =?iso-8859-1?Q?bliUd87zpbxSqRsv2W6HAwRGFXhgo/0mn271bn+m8bhKEXBQeQrvzbGGw1?=
 =?iso-8859-1?Q?1Ct0uYuceA/7E79MbxLE9FGkGj6NgOfgQFtIMAQQkcSKhb2Zocwwiyejvw?=
 =?iso-8859-1?Q?8i+WgW8HaXLBg4L/xom7+tamDN5U6JakC+f9YeEK0nqks1qgSE/1jgpSTc?=
 =?iso-8859-1?Q?9EDkyvp0n0Lywg8K6CBXVPWuGsRcZCntcj5zFIHit8EgSZrnPyWz7/WaSs?=
 =?iso-8859-1?Q?HgKvzb9VreNreSIy2a72AdOSRfAoCldz8Hwr481xl2oMc8BYLEdICLmHOT?=
 =?iso-8859-1?Q?wwRGD3nk5lm4nqhI1Hy4adZ1tVHY01YP4zzL/vhrfOX3ZRCLKcJ4eJvyPJ?=
 =?iso-8859-1?Q?ZyoMRK/AIo4neOVvv5OULvzwO1Zx6XdNpgWooUF+PAdc6NxP7332alW7Kq?=
 =?iso-8859-1?Q?Ybqufd3f4riYDe76s8k84WlolZuSZxW4lDtVV3aFFt5SgBq+s8SRjlTowI?=
 =?iso-8859-1?Q?Y/gzHbDqB4BmKVssGd3A7SpIHznHnZVG9wsU8fz+DGRQqnYGjw7At4tbeU?=
 =?iso-8859-1?Q?TCXX/7Ku2pxBL4QDipDyI8PUWf5FJ/xpoktYoG4ssY4FU6owUjP/KepEXh?=
 =?iso-8859-1?Q?dPBkWfBY+XW8yQj9OyvVcWbIHv0bUvQIX10Z0PRXdDpiDQz1VpAXqQep+U?=
 =?iso-8859-1?Q?k0+QbyN7MYM3lDpB8VNIrBn6j8UUnDMfZeR4MWbyycrYIumLnajlx5xrsb?=
 =?iso-8859-1?Q?ZRWXq1Lvw3DxeBocC9tiFh+amZ+WUCBBmDUAFfKmEK54yMKBpPHgdHBkfz?=
 =?iso-8859-1?Q?K/k4nyDdIKclo+eVNxQZRseyW9R5ijdKYF3keWH1MysUQrJupKABUlH/+O?=
 =?iso-8859-1?Q?HlK1osjrn/vb3q+vU+YH3WAemnEA6n8xsdNIKW0Rf66L2fdrrxhOOY+lg/?=
 =?iso-8859-1?Q?MfGCuDCaaevkknQ/KPgYCeX8r9BOZhCDvbSU3RGzJ6TubkkI9fxYDMbTFC?=
 =?iso-8859-1?Q?jdo/dxGBuGAj10BkJDoYXoDi/BATYilQjfcCiUtEbzhAxfjVlCU5Fk7q4p?=
 =?iso-8859-1?Q?tCalWJntNGeEdy/Uc7F7kgbYY/S8LH0t3AYeByEZGZtyjSm+UrKBRpNNTG?=
 =?iso-8859-1?Q?wsdpadvD9zikwplWjvKLPLXD9biOIQBru9SnlfLeXH7m3SmfculnhPUfD7?=
 =?iso-8859-1?Q?3Hkt2nZ7NAYCFRkPzBqVNNtxF0QWSeGBodhfFSfnXL6l4kuHJJe/7C5Bt4?=
 =?iso-8859-1?Q?gMnl+OyCdIc6JsFi4xA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7005f-9bcd-430e-4c8e-08ddc9e9788d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:04:34.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaL51xpfWloE86vQT2eLiOph3f64aU51/VUVs+AvyPxa6dNFTum4O8voVFp508csYRlNOIuQuRjiijQsxkOb7yeolaY0qOlZxehYsLTMKy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com

On 2025-07-23 at 13:57:34 +0200, Greg KH wrote:
>On Wed, Jul 23, 2025 at 01:46:44PM +0200, Maciej Wieczor-Retman wrote:
>> On 2025-07-23 at 11:45:22 +0200, Greg KH wrote:
>> >On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
>> >> If some config options are disabled during compile time, they still are
>> >> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>> >> this_cpu_has().
>> >> 
>> >> The features are also visible in /proc/cpuinfo even though they are not
>> >> enabled - which is contrary to what the documentation states about the
>> >> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>> >> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>> >> 
>> >> Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
>> >> feature bits bitmask.
>> >> 
>> >> Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
>> >> contents of the disabled and required bitmasks respectively. Then let
>> >> apply_forced_caps() clear/set these feature bits in the x86_capability.
>> >> 
>> >> Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
>> >> Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
>> >> Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
>> >> Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
>> >> Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
>> >> Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
>> >> Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
>> >
>> >That is fricken insane.
>> >
>> >You are saying to people who backport stuff:
>> >	This fixes a commit found in the following kernel releases:
>> >		6.4
>> >		6.9
>> >		3.16.68 4.4.180 4.9.137 4.14.81 4.18.19 4.19
>> >		5.11
>> >		5.7
>> >		6.6
>> >		5.10
>> >
>> >You didn't even sort this in any sane order, how was it generated?
>> >
>> >What in the world is anyone supposed to do with this?
>> >
>> >If you were sent a patch with this in it, what would you think?  What
>> >could you do with it?
>> >
>> >Please be reasonable and consider us overworked stable maintainers and
>> >give us a chance to get things right.  As it is, this just makes things
>> >worse...
>> >
>> >greg k-h
>> 
>> Sorry, I certainly didn't want to add you more work.
>> 
>> I noted down which features are present in the x86_capability bitmask while
>> they're not compiled into the kernel. Then I noted down which commits added
>> these feature flags. So I suppose the order is from least to most significant
>> feature bit, which now I realize doesn't help much in backporting, again sorry.
>> 
>> Would a more fitting Fixes: commit be the one that changed how the feature flags
>> are used? At some point docs started stating to have them set only when features
>> are COMPILED & HARDWARE-SUPPORTED.
>
>What would you want to see if you had to do something with a "Fixes:"
>line?

I suppose I'd want to see a Fixes:commit in a place that hasn't seen too many
changes. So the backport process doesn't hit too many infrastructure changes
since that makes things more tricky.

And I guess it would be great if the Fixes:commit pointed at some obvious error
that happened - like a place that could dereference a NULL pointer for example.

But I thought Fixes: was supposed to mark the origin point of some error the
patch is fixing?

In this case a documentation patch [1] changed how feature flags are supposed to
behave. But these flags were added in various points in the past. So what should
Fixes: point at then?

But anyway writing this now I get the feeling that [1] would be a better point
to mark for the "Fixes:" line.

[1] ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")

>
>thanks,
>
>greg k-h

-- 
Kind regards
Maciej Wieczór-Retman

