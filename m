Return-Path: <stable+bounces-172361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D9B315CB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9966E68255B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE942FB628;
	Fri, 22 Aug 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqqrOXJT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346D2FABE5
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859780; cv=fail; b=GsLdIDS0JXGSLVyKqK8O3GMiAU4jizq/+VWqj+O7kACD5WudR9SWqrsFkbaxNTVDcEyqBT/wQH6kxR7sY9vxlN7yzjPwgtDP8GX2WoCKyIhcccQ2srQSVR0iFn51xT6+C4t3LqE3RIQJJfr4lpYPY4w9A3oAS6BQ+0tBbrZBLvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859780; c=relaxed/simple;
	bh=eL5yDGxAZ/AYG7UL49CX3goGkc8rDaIneUTnM5vpiFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdqflb1baiJ/NWykhwKD4KkKOYqZgwJFXBASh7Gu49Dg3jTH5WDiAREYbAu/F+pXY0qrmLyihxQ182dyox+b0W+yDNCJnrw/eVumzOo8UHCoGs+eBa22G+SDCyJVOPxlVdHqpHClWhCI6FnPFf/szdLzxH3K0wGLVngAFcaFY08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqqrOXJT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755859778; x=1787395778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eL5yDGxAZ/AYG7UL49CX3goGkc8rDaIneUTnM5vpiFc=;
  b=OqqrOXJT/4JUk2kxQBLGwe+beiVsMtBr99kRgJqE0aDLRKkCsEv3wOvb
   IaKt1rChYoK6WT3Wk6ksKJxU67hX6Dm+N9RnQSxYfVRISg32wOhCORcuJ
   T47e1IyiTcq99hPl9mwo14XuXE451Jrq7BpEEUpX7yae7UuRdAk409eC7
   POTsRll0X1jg/U4CBb12ccn4mN8aFpMS28LVPi16g4VGPnEAArmHcEZQm
   GCXnSFZhTfCh+TWXzo7NaK4uHkW7CMY1lxj4Mn14agMtIyEUswINPuzcD
   +daPEfGXW2ZwNXOGCFXXnk+4CdiuTPuaYdf0gwCgWimUtnKcWWoyffqJD
   g==;
X-CSE-ConnectionGUID: J2YHkYGJQ8aG1tLAEFRlOQ==
X-CSE-MsgGUID: PPRs8MSfRxaO+dWH/lUsfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69266193"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69266193"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 03:49:38 -0700
X-CSE-ConnectionGUID: zq36I2oIRXGtrOkt3RTL0Q==
X-CSE-MsgGUID: R+aws11BR02mf4XYG0Fb5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168879259"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 03:49:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 03:49:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 03:49:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 03:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/xuSMe0bNeMKQMUKjjcf3DG5pwKITILu8BBgUFNIo1vyuXAN7IeN1XLHbNB6rLto2g/ece0PCQlK+hTHhCDEIMBqciVYQAJ56Q/B9xj5XvZCPr3lD8BCmN8JZhWK6F4WolHam7Vgy2DirQgc3V57MN4AHjLE/IBMqP8DebV7vLC/xt0ujqqTkPP09Phe/mnVWh7Y0uWYz6KRhI8J+XM+AB3hR35VDKQZkh/n9YcWwScFaQmQI7VAapiwgC+B4Wa9db7zn1hO6ENvrfscWKqIagnz6fHFIgmzZdHNTtcvkerEfM+rHwTk07LXcY50Zka5BVpML27ASOhLsrAwGLb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH8TjrSZrjTDy2zYnapURGppsCPeD2+za0eSoK8zc6Y=;
 b=dAad9T1eN/U+ALTmqvn+Wge2rBM1rXKdK4EXtRKjNaSGCUShzW7hCKVAatJndQ3CRrwOPiVt5LrQmCV6r7K2va/56d+Nb5+YUGGzji4UjpsD8prA/EEbD6JT8h2l3Xbxch/8V2URy4nDwqwgOORa7Q03drJysQpb8No144nx/lVL5lZ+p8k2eh8q/0kG5VwwD14d2jAriRnz9wxDO13J5oOd2dvl4JwA1b2640Ezyp0XY3/98k7/12LAwunKhL6ZTiOfooxlJy1yqrSVeH2hErd/9/kNAeit8Lx9eREQ0rd3wHtVdRWXwFZAdKJrF47doDbKdducgd/V/ne9ncDjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 10:49:34 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:49:34 +0000
Date: Fri, 22 Aug 2025 11:49:29 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Greg KH <greg@kroah.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Sasha Levin <sashal@kernel.org>,
	<stable@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.16.y 2/2] crypto: acomp - Fix CFI failure due to type
 punning
Message-ID: <aKhLOeaAfKUyUvZh@gcabiddu-mobl.ger.corp.intel.com>
References: <2025082113-buddhism-try-6476@gregkh>
 <20250821192131.923831-1-sashal@kernel.org>
 <20250821192131.923831-2-sashal@kernel.org>
 <aKgZVNygjrqd9L6M@gcabiddu-mobl.ger.corp.intel.com>
 <aKgg3vHUz2MM7A-L@gondor.apana.org.au>
 <2025082239-ablaze-sneer-a79b@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025082239-ablaze-sneer-a79b@gregkh>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZP191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::19) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH8PR11MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbda01d-f271-4970-7adb-08dde1699495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lU83ZI1uD4K1wnHttdR85FgfsQgjEIowSuYClA0JGerQGjdbTZTTYFzeVpA8?=
 =?us-ascii?Q?Wq9ZihQMD8j+YFmgQfi18qDD4pzb930URzcz9t4laQnj8sXD11MjbGUjWTV+?=
 =?us-ascii?Q?KlzVGllhhSVG6LW4635C96C8C5GS/55dV/DQZUMptj/8wDJAfyiaAhATvm3S?=
 =?us-ascii?Q?OJEp8Ey3Y/5FOTo2dnXuyrJIpIlmI/qj79sFDr9P6MBdBcUnlW+gH4neQeTL?=
 =?us-ascii?Q?goR2g2pXdS8Py5C6JljhTbW36tQGx13SzGWso4k2Y02/s8nF1hMFoTefWgQQ?=
 =?us-ascii?Q?TEbkquCfAN9LNPucA7xj5AO6XD8GQ/EiauHDhr2dD3BJ3BfaV/YzHn926Pka?=
 =?us-ascii?Q?AbY6xBy5/x+RkFM1RPCbvXYYPiXTdBA3QxJ+6Nawam3zciHgV67KHX03W66O?=
 =?us-ascii?Q?ZB4UAt0nOPyHWIfoqvsBJoWVxXrsyHyH35xuFn9uDVxz1+7yAo/cx8+yWaJX?=
 =?us-ascii?Q?iho/erej1Fo+NMVCcfFSqj4FgUPG+WR44XVpVCdp4hjPrxGwHlRFtp+9xsmx?=
 =?us-ascii?Q?+r4p+olIZqCBbrxEc9ajHfMKA1uhOfjYUItlrcvdLkebMbQ4zlhvGgE64rNQ?=
 =?us-ascii?Q?wMvchhYJwD+HSaHTokCtiwW/PB1cXoWBkl+HLdlPnVRJj4s57PdBFNpJb567?=
 =?us-ascii?Q?w/kN3T8NLyW26qTQUFfKO4KBdmSFUmZnpowg6FJnCLyn+jGPYTaMCsiLk1Bu?=
 =?us-ascii?Q?bKiEEHh0filIzl+ZqUdQnz04rmHTexcKLAVy6XUDXcIG4EUAfdXP/CbFglaU?=
 =?us-ascii?Q?HUBwZ9oxgRo2dwsC4skTGG55Cc5WBTaksOCMk0pJrv3hi9rsE//pSPh4vPlR?=
 =?us-ascii?Q?6dcYjnc7gOR2ZQ3i6b3LVjwrvs+YYMU6YNTwAWHpb0YJB33h3hs7lLz/cdBn?=
 =?us-ascii?Q?DJWEHf04v7e/444X2MsAXyjBnumjEKoKYODeRlY3Ns+VVnXrRcfvVcq6fFi5?=
 =?us-ascii?Q?gHVMss0GXmrBi89qk1Pgsd3Sy1ZyaKYUUDRpQ78ymn03BJCTg62tioSyZCck?=
 =?us-ascii?Q?I4IEUxHSkuyEuB8ys4sjihtaJNaQeCLZUKAD65I+jPVziItznA6nyjV5hwij?=
 =?us-ascii?Q?Erb/p5aGndkUwKOvwwM4CLdduF93vL1qx5mXyOpdfRu8o7rcASaOmfUGstBd?=
 =?us-ascii?Q?O8CjezlBQJXRIQOzPBcjzSvdNN39ZIVlyCX1yixW7c96yaxLyxzd6eD5eatg?=
 =?us-ascii?Q?f+Q1nQQzoyGTBuwKebq6vl1s3ar6EFzAZI38r549/UIu1wjYP1hzpdym3viv?=
 =?us-ascii?Q?xBOMAGP/q4RQTg2E5txFo3GYN+TmftOeY/Q1Xqkibk97hGytmAJ8qvbK32Gf?=
 =?us-ascii?Q?t+M/XjMPc/T4g+mlZZcxJW/CGHQ32nsCdC0ruZDOTgvS6Y0hXEYaHh4CC2aW?=
 =?us-ascii?Q?RwDHz5X0nJe2Ec8dejw4OtmMx7DUcTDT+eRf/nIa2fv0TOHSIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqGOBHyPjEJW856ZoCwCsa64UgaEx4m7hNOTBNYjqTd1rMOguuRLofRV0g86?=
 =?us-ascii?Q?HbFmVKlfRA7eeJNu+HMPx9iiWY+pXqXIkBGQBt5x0qJZoOhByHLVc2EdLft6?=
 =?us-ascii?Q?Gg7hLKhC6g5J2tzGfUDwMufG9HobY841eD1G9mnMTXYbquoNcdgGSSRMEqKL?=
 =?us-ascii?Q?fitMAqYUV47tbKFWTvHL3NIdJxX2qHwHdVueJhTkBWPUaJftt2cVmwAEQjK9?=
 =?us-ascii?Q?eIJxlgv66DQmElOdt3LlpcVnpLmWPg3y9JHDocbkr7nLqHYgiP5bBDv+QcPL?=
 =?us-ascii?Q?Z3vJC2f4YKY85zm0zILcOGKQpoC9agrxNxn0hT/2oVBj8Rhtrjo3Y+KlVaYx?=
 =?us-ascii?Q?tq+FYAK9PptaVRk/ZlSsm4zY6L+POdWkSEGl4ybP8P1sfu6iBSLlKc8g7TU8?=
 =?us-ascii?Q?E4LvmdXH+FTilmSTvCV/38jmqN1R5BmdODJRN9HRJTSZsVyNgbhewIAGswR3?=
 =?us-ascii?Q?8CVHrx7ykvwhVfosaP8fUJKeFz0K8P37r7DfZsz+ckNk+YccetafR2Imf9IY?=
 =?us-ascii?Q?y37eoUasd8cGPyfJY+HjdVoMJhafPnfM34h7v622s7PweYaNh/d6knL6UmJC?=
 =?us-ascii?Q?mFEuME/2oWfAUf/d4mLV97qG4QnKqV9IB+kKgOtH99bUTuO8ngpjr1v2pQMV?=
 =?us-ascii?Q?vEtCbEK40r+QbqwZGXzSOmWETW8FoXxgzuMUOwfWwZjz88fT9GCOnOn8QwwC?=
 =?us-ascii?Q?sKOAU0bdnx6oUM1ZuT7LuUI6JfsD+lyKu+GD58lF1pIlLLyQFcipgp3iZNvp?=
 =?us-ascii?Q?Z/QcESOiVGx6BiQV5HHWqKHjB5JcvskNLspUlaPo7c5vaMFavpo7T+P1xCFK?=
 =?us-ascii?Q?cAFVXBS0mo2cPzr8dAC7W/t4E9VxPUfy6V++xuRqHqZrsCC5twtuvfEgEjW4?=
 =?us-ascii?Q?ekwoDonBpdStZDzGIbS/7dSCd9kzAWPiKU1rhTiBBziAY8H3DR8ZDnyEhJmN?=
 =?us-ascii?Q?G0D7wJUarW1h7o6D38+jnBEq71Zgm/yCavSQzRpukmKAYVcJj+8l/3fgbGsz?=
 =?us-ascii?Q?GxQEEr7K8mGpAfP/ESsvA2vpYFzvWSPwYCVqW1vgS7byMdOZzI9pS/0xBUcQ?=
 =?us-ascii?Q?EspzHhOP1SY9JqBVovI0i/TdhBfhXmC3N3wMv4vc0l1JklUciUw/X8PoBnJa?=
 =?us-ascii?Q?3lbdijKYOBZ+T3y7mgwQcruFRSgao6oc4BI6HYncqACZqBOsmoslWy2LgXvn?=
 =?us-ascii?Q?rjXK6Fv1dcwhnwohWnr6tPY5m3omXgXjYBK6leg2eFihj8UXE25mpaKpJLmQ?=
 =?us-ascii?Q?LEmrZUK81vHcmTWBp5ehSQxeSM2Wz07IHoQ68WrqOeeP0BKJUtrcc64CQy4y?=
 =?us-ascii?Q?dBkuVmabmTLmtuyPQAba7B0l1b/SaqDNKQJ3dcCh/5n9TJ/Urxbb//XpOl37?=
 =?us-ascii?Q?0akVlUlCLkNKZaiwa/8Chlz4t6oE9Wy3rv6F2ek2pMl8VptpwtfUHZAm+O26?=
 =?us-ascii?Q?jHisNYt4voHYGAF2Ix/MnTO+J38PgsOuSOUOJqLx98vbQ+GV62vsTkxW7hGL?=
 =?us-ascii?Q?RuAAg0U7AQpE33qzw55r8YFZoboY7jaQuPlxpuwGo48O+vD2N9hxu0shPJdc?=
 =?us-ascii?Q?u6FRKh39s/iKq391JhobBWRP/E5XmDXJuresxEUX+DMhW/qx52XnfTQ7jIdT?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbda01d-f271-4970-7adb-08dde1699495
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:49:33.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPTR6Y1BQq1prsVa3ZFH7Cdlf8lVO4ibru7pnKDWhDUl266NR6Ss9hWbygLQX4NZ4MGaPrLg10sB6yLv92VOkEB4NuIpUsC+EtyDoDAFPFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-OriginatorOrg: intel.com

On Fri, Aug 22, 2025 at 09:54:46AM +0200, Greg KH wrote:
> On Fri, Aug 22, 2025 at 03:48:46PM +0800, Herbert Xu wrote:
> > On Fri, Aug 22, 2025 at 08:16:36AM +0100, Giovanni Cabiddu wrote:
> > >
> > > Wouldn't it be simpler to drop the below changes to crypto/zstd.c in
> > > this patch and avoid backporting commit f5ad93ffb541 ("crypto: zstd -
> > > convert to acomp") to stable?
> > > 
> > > f5ad93ffb541 appears to be more of a feature than a fix, and there are
> > > related follow-up changes that aren't marked with a Fixes tag:
> > > 
> > >   03ba056e63d3 ("crypto: zstd - fix duplicate check warning")
> > >   25f4e1d7193d ("crypto: zstd - replace zero-length array with flexible array member")
> > > 
> > > Eric, Herbert, what's your take?
> > 
> > Yes there is no reason to backport that patch at all.
> 
> Both now dropped, thanks.

Thanks Greg.

I'm going to send a backport for the second patch, 962ddc5a7a4b
("crypto: acomp - Fix CFI failure due to type punning"), which includes
only the required logic for deflate.

Regards,

-- 
Giovanni

