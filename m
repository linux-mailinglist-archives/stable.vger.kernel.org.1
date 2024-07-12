Return-Path: <stable+bounces-59222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39657930278
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 01:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0EE1C21213
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E853131732;
	Fri, 12 Jul 2024 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZKHM33/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF610E0;
	Fri, 12 Jul 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828168; cv=fail; b=SrztY5+5g84Qkz4yhNhiO9xFAZEX39RVZxLMiQxSAPHbA2AzCzw5X97b/JGQnfpOjKT1+O+XmDkVW9s81/ckK8iho8AlkQNm/hhZoGivZbP4JirsVegTRXpxmibs5QFTa2fn7veYfsyKkfS6lb9C7jsWb0en3oIVLIyU3XfVwKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828168; c=relaxed/simple;
	bh=Myy/HjGYar29/pQHXwPrL64gg1u+2/sedYXFvCZKt1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e8+OarnLD7moomZTL5u370WZXDWTm2mnFtX38gMblRnJADuzNwZwHISMfVUxST0faPujUC9o04BIYRhDgA8m/imGDJ+/Go/nI3PDb7PnVx5P9AII4sSy73vqQbI9Qdu7xOuB5jHD8sGlv3dQR7X4tFImvn3atkCUtc+8E7ooZ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZKHM33/; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720828167; x=1752364167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Myy/HjGYar29/pQHXwPrL64gg1u+2/sedYXFvCZKt1g=;
  b=FZKHM33/dYHX/kfYuqbltkbt/CefmFKnsGo/Vt33jxpkvBEkQJwpn3Ec
   VXWN4ef+GwJwnze+cr0CKEbIar3GW+6x5ZuXkX0FueH+oIsfZwvYuzo4N
   Z7+lLyQ6k+qkNVlEgMZ89OZdTAlLXrdhoawu0kzO0fP8/GE2YbKUegOMO
   MXZ5IwRWUMHKX/RxqOHjmQx2utWCpvSMUYI/aioUjVA2tdmqJMn6eMNwR
   IfEKe+G7ax2HRv9kCQ7IK8DfmYh6yypW020RINknPezSq/A24LZoAucQ9
   FiBz/qxeLnL57aQFrycglXkrcIsEyH7A4Z22DFjbnNtXUQhtSbdFdCp9/
   A==;
X-CSE-ConnectionGUID: wVtXIAzqSTOS7gDjzzFz2A==
X-CSE-MsgGUID: Tiz9BzQVTXSrekaE01dApw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29435859"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="29435859"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 16:49:25 -0700
X-CSE-ConnectionGUID: AYXkbx9eSc6XjEpdicQN7g==
X-CSE-MsgGUID: JVXxrKSBSBCtLDday6NjHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49005227"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 16:49:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 16:49:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 16:49:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 16:49:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 16:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh7GF6VR57LaYeOMMW4jNdsHnOKiUeVztba+Hhb63jQw8FRWslBlBY5hhVWMXwONX9FNJyIQTwdqheKyQfH9/RKG8xAfUtJ3EVKVamjlb0fO++x1A6C9ACLfiowgzmmbmDjkaR3r4WRiJ/FwC8PAX55g33Vt2jdBF9R091Wi8CdSi4eBYAcCgRDeYPW5kGvpLsPsgcwYyWXfZjisbSMwOUME/dTPg0uRDVqwBTXkXXgJ8k25DWSwf2k0FxYtwMY3bcsSVDML39BTGqn12UK1/ACD/s11AT0RePtavwxAn49KGNSsg+A5u9NudJB7xJDoDgNtctNnwatdI2dvXsnEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrwMTJ7AyX+x+xhNbgM0WBO6AUtkeZjtpeD96bJ4Zzg=;
 b=oizN4BnfZA8APY9dHvShn5G1yZnX6muO2u/DcbS8By1jEaOocULs4LloeRGXqPPP7RN+4WHGoGi9QiKqJX+IApoDaiLMh8f7iHqjAvE2Ao5+yGekTNUqvHq24TXn1g3R16/Kdn/lKP1Mfte2Sv2YJeW11aUmiCHnlIZBD+hZWWKl1NtS1E3l7wnnxUDXasmJydqXZ1TCZOzjVWFQuyWWmlurF2WepUrJUmvqXBuj/JwnAvmq/xXduVscJvUalzsJxYYNbNgWk3FjnLvXdqf232YN3oDAUA20eerkfzq2toO/vuxblWeGLDmUJvW9p8Ou2Fz0hBGa7HVbbPTOEfGiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 23:49:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 23:49:15 +0000
Date: Fri, 12 Jul 2024 16:49:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dan Williams
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>
CC: <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>, Ashish Sangwan <a.sangwan@samsung.com>, Namjae Jeon
	<namjae.jeon@samsung.com>, Dirk Behme <dirk.behme@de.bosch.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
Message-ID: <6691c0f8da1dd_8e85329468@dwillia2-xfh.jf.intel.com.notmuch>
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
 <dfcb0456-dd75-4b9f-9cc8-f0658cd9ce29@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dfcb0456-dd75-4b9f-9cc8-f0658cd9ce29@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c1738f-d8b2-4276-3840-08dca2cd3d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OLz5RZHmLz9KHK5fDUL+oIdEbRIRUkv8+d/lZkAjXg95WXUTls/EEQg2QYJZ?=
 =?us-ascii?Q?YU6gJ7phf9WetEvb5SRtIkkpBmQFuDPfExl67o3rhwUjYlW2HpIPM10Ob4Wc?=
 =?us-ascii?Q?XGdVR6hazAwR0cCVGkRl018+79Qrpi6RHfmJtAPYuCa2DL+7zoUa9I1tO13N?=
 =?us-ascii?Q?Qh7Ridexe3Gn3p5fls/GFSuLF6yRYCw8q/0gK874gScoDjMmFRVLw2/wziXr?=
 =?us-ascii?Q?8wF4SMUJU/YOSmQQsNHk3ONUa0JJ4QyAcawktSm0HwLUXBVav/OtSRPrQ/K3?=
 =?us-ascii?Q?jnK0+WHEjsoV0L6/UkJL2vV7tXEHbvGpKAKnt5aUUu9SIxtipAMAnRX8z/it?=
 =?us-ascii?Q?bHnKuQ15PGlMlMQ3x6yuHMtLr4S9TaZYLtEdxaHdN8cV7iAneqsEDmtO69QU?=
 =?us-ascii?Q?8xgdCjYfbdVi8XUPKlgaejfZTv7fniznAny5eOXKp08lsMBp+ai6SWqb8z/W?=
 =?us-ascii?Q?tPlcR28pZXS1W9Un4MNyd8PZcU/zbCox4y5hUHI6larCRQKOOTituXhpS1JR?=
 =?us-ascii?Q?wOlaEmVkmpGzBCrr8kPIQIn3IoFyvX3hG0veI3pcPtT6La5neVh7JF8kOlmQ?=
 =?us-ascii?Q?nRjoTEoVYzskPto8Fof9XG4D4g+JnpOjtpIg/lveVbEdFYPX03EapItkgr1n?=
 =?us-ascii?Q?oU81rvCvAZ9956Us5UpC1mgMbejfUcbYBIgPJg6OT5cMVFiAAQSk9XdGD77N?=
 =?us-ascii?Q?ykXuyjmoS/XBH0fD7OzupwLTZrgQAw/AwF2wtBPmMsuA0HhRjD6bSojwkAJI?=
 =?us-ascii?Q?DDUKv/0xrqdtQVe5ed6ZMGamsUDQwkVKATN7iuQ0J5G5TsZzd9gM6XTy/IGU?=
 =?us-ascii?Q?hIcSbFlgB+x/MXboI2avjvDfiLItTwWm47iF26MwJOlPNRvXLVPMroubDFL9?=
 =?us-ascii?Q?cl15uGQY3+5w6lZAMmGpTu/zDerVt57hYDE8DH2OJ0boDIb/J3WezKFwdBSm?=
 =?us-ascii?Q?5v18DEDtRTcv6UJ7yLzhFJ1RzN4E00DOiuNB3FmKhV3TduSumjcYKMTSNOD0?=
 =?us-ascii?Q?WeabXI6hetU6H5nKo3VpnOV374tRBmVrf8icyD9JV/rFRvmDBWrr1wBxZbAU?=
 =?us-ascii?Q?QK1eD6PaYtXLwwYn0gXECr5NrE7f6WLWvrf6fzlhwAySbaVnxx+Kjz1rmplG?=
 =?us-ascii?Q?4tv30Qgw/BS261rIrrFn5uV/gPH3K5trQYmvaObs1ps9DCiwRnk1H9WA441K?=
 =?us-ascii?Q?0ZnVwe+6H51ETHQfF7sHOtZ4FoUTLigHEZewpTjs2+DEmrbCnv5Jll1h8wpd?=
 =?us-ascii?Q?otnUHiEgl8WHXGpubhoi+JkzVTh87H08/xCW5UlLNvfeD26vKPE/rnsvJ5OR?=
 =?us-ascii?Q?XNTolAG4XLisZkzd07Q83pMyoRWo2d66a+YPJ0n53S4B/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpWUFr3eWo3QfBYdJG4gsjFmuFDgPM2jHJEWuMYPvCOoml0vi8VVugACmESQ?=
 =?us-ascii?Q?pP71KHiFTi2BthpKj3j8LjrxOjDr5snqHEd1TmQmnOgD7tuMbokmWFBUvWdF?=
 =?us-ascii?Q?/aYCcd2u9//CPmVp6olxWEa81VokNSQ9uN1kdaloT2OJ8s3dBN0e5aCgKGzV?=
 =?us-ascii?Q?pJJhlycsENrPZ/J3Y0jfrvhA9CpbXOkGHWYz4rQqZoVj5nt5z6H7oe31y/OZ?=
 =?us-ascii?Q?vw9EEiGrOq+3dUNP1Xfny+fJRpYPjBZLdepwcw3zjm5bQIv82cqr9ikJy6JJ?=
 =?us-ascii?Q?lGZY82sa94lP5AlrcNl7dXD3bzaLhlgttHJf/Jd6xeSeIxv9OWmGPABaYcX8?=
 =?us-ascii?Q?wMsqepfLLAAfbx8RCH3Ro16YDihVB5wz5dVYssN2ND7gWWrk47yOid5BelGb?=
 =?us-ascii?Q?SETRdqBvnpokvuP++TKtgMBtO2AdaGRMNU0fZz9wcbE7DVlEQA25fMrZGHhk?=
 =?us-ascii?Q?cBT4l6FgP4NbXitNzS2aIRY0MaAYBJ6Dv0UicXK6Ru5ahzk1E/HLBZZZ8CZN?=
 =?us-ascii?Q?LAVMYW93ry5pFbJUi0sHFtyMJ9h1xj+vkUbMh6CObvPp0+9XC2jPWyrF+ouC?=
 =?us-ascii?Q?PLjdE+cHfNmIiLVu/MbXybJxFq9soofWPdw2shTwl762cHWU1OXTRBJE6SDG?=
 =?us-ascii?Q?6XP/vjFM3bCH4MqVQcL2uVae1o6lYm8EuASuRcmbo/YOJGUerf18YFNZxw2+?=
 =?us-ascii?Q?TMwMOjndCaR1mNZjhzZhjWflEIY0snsNu1G/0+LAVFWFkTQaChnAP0h0o6pH?=
 =?us-ascii?Q?M6PCzV5O3E4kLPAefTuZ4+Ay0eATCdD5ZvHzCaBWVdeXd+1/VXLVMdZUwwYT?=
 =?us-ascii?Q?R+1pSngkkxKPIudKU5VCIWFnmY1w7HVe3DYBMfYpsnreyiHwh06c2ZLBN1qR?=
 =?us-ascii?Q?wvvetpbMmZP3Qin5rtFxH3sjs4qmMlNGdhvi5Wn3+wOOSvUcwdTWEffcRSuD?=
 =?us-ascii?Q?8taNtb5fYP5h9W1zG1d+dSxYA/3YUetDYuaett135UZDwyTHEfV0GDBEDH0b?=
 =?us-ascii?Q?Z5skzMpiKwsdy3kQPMrRBOPUcYgVPlvXfQHxEuGO5Y5VvYvYaMzqU3Mg2GJX?=
 =?us-ascii?Q?PUmbd8BQfDAoYUiOjNJXAeXr474aQzT9ZCAmIKtWFa5sjOHhogwrzSJujzeM?=
 =?us-ascii?Q?aR8eWcwfQumOj0to+lOiOulEv8FMZyOpl3tYa6EEYvZjxg4CPypdoVSdl6OV?=
 =?us-ascii?Q?kqHQRX8mpC/xL9bfaLw6XEMticv0ppubmHU8vl1WTfBF44cHdWc/ifeEVOx3?=
 =?us-ascii?Q?YOXheYRPiEN5A9p0s/wugBVqzhdiqpi4Gom79LAl5DtK7Ri2C6ZuiyXdieJl?=
 =?us-ascii?Q?1rz+FND1NxibeQb+QPr+CwbfDJC5vi9/KB+bgHu2EDkFlrrGzEbobhCDZ6Sc?=
 =?us-ascii?Q?qRamjwb10gOW3UcMjGZVORidRba3pveSGjQMVSjvhb9ETpCSy4eCkEFjkI4E?=
 =?us-ascii?Q?zWTMs+enxoqo2UbCBmQv3ymK1lD3AYouqtNlkZtsGir13O2F/keLPJ71RJp7?=
 =?us-ascii?Q?kaqw/nghLRugwNFHtpGrfOZ1ZV7r14ehgWWKDx/32WgLZxNVVUrfj++XL7Ip?=
 =?us-ascii?Q?528DiuN/VYwhT6S0RSCydLkLF3YD/Zh51g0e8pvtqQvaEie2vcBVkdAUWmxX?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c1738f-d8b2-4276-3840-08dca2cd3d1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 23:49:15.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxjT+ct5U9CT+lvwIvce1M3IvlfAWmzUCyv20xrOXdutAlHrvjL1YNgFALhirWjGglRhyFNgZf82M3XPgxAUSHY+bmxL1aZwE6edSAe1Fck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
X-OriginatorOrg: intel.com

Tetsuo Handa wrote:
> On 2024/07/13 4:42, Dan Williams wrote:
> > @@ -2668,8 +2670,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
> >  	if (dev->type && dev->type->name)
> >  		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
> >  
> > -	if (dev->driver)
> > -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > +	/* Synchronize with module_remove_driver() */
> > +	rcu_read_lock();
> > +	driver = READ_ONCE(dev->driver);
> > +	if (driver)
> > +		add_uevent_var(env, "DRIVER=%s", driver->name);
> > +	rcu_read_unlock();
> >  
> 
> Given that read of dev->driver is protected using RCU,
> 
> > @@ -97,6 +98,9 @@ void module_remove_driver(struct device_driver *drv)
> >  	if (!drv)
> >  		return;
> >  
> 
> where is
> 
> 	dev->driver = NULL;
> 
> performed prior to

It happens in __device_release_driver() and several places in the driver
probe failure path. However, the point of this patch is that the
"dev->driver = NULL" event does not really matter for this sysfs
attribute.

This attribute just wants to opportunistically report the driver name to
userspace, but that result is ephemeral. I.e. as soon as a dev_uevent()
adds a DRIVER environment variable that result could be immediately
invalidated before userspace has a chance to do anything with the
result.

Even with the current device_lock() solution userspace can not depend on
the driver still being attached when it goes to act on the DRIVER
environment variable.

> > +	/* Synchronize with dev_uevent() */
> > +	synchronize_rcu();
> > +
> 
> this synchronize_rcu(), in order to make sure that
> READ_ONCE(dev->driver) in dev_uevent() observes NULL?

No, this synchronize_rcu() is to make sure that if dev_uevent() wins the
race and observes that dev->driver is not NULL that it is still safe to
dereference that result because the 'struct device_driver' object is
still live.

A 'struct device_driver' instance is typically static data in a kernel
module that does not get freed until after driver_unregister(). Calls to
driver_unregister() typically only happen at module removal time. So
this synchronize_rcu() delays module removal until dev_uevent() finishes
reading driver->name.

