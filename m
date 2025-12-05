Return-Path: <stable+bounces-200210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F758CA995F
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAD6430153AD
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73E433BC;
	Fri,  5 Dec 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h39a9dGO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B525E469
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976330; cv=fail; b=NaKtRHY/PsUME1P6xVJy8ymS7FxTx2HG37BMjHj3EfFaESBcswk/NKioEQR9GFs5IfLQqOFKy+WEfpi7qrZemvsDRnq+nz0NAsRFL3mTI/2iI/poAHiH+fXVxfLAW571KOnBcnADU44jezIixIuh7Bf3w2T6ruNcO9cEFVWnYUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976330; c=relaxed/simple;
	bh=3eqbIVyLbc4/HsTD0S4hvpVv4ghGd9+ftMVSMnvmgD0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HdLCBLPuvz1K7wEQ2U7mSYkH6EAONPqdWYTl5Qif6zc7C/OeNGqnqDl5HuoLQN7q0uPZHotSgsWWAORugekIJMkI60IcSNIfGu8ChgHNQn3hHiRqv/7fBbGecBRlwqfYfKybrgQgT4zCYbdT2OZvsxg2zVPpzlc8cF+Q0NHH+Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h39a9dGO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764976328; x=1796512328;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3eqbIVyLbc4/HsTD0S4hvpVv4ghGd9+ftMVSMnvmgD0=;
  b=h39a9dGOyBQswPMD6+cRP/yciLynCFvbDM7EHEPPZxiRWIFG6JjUOLGs
   6eDsRVSt61+TPvS5W9bNZUJAvgt3PTrqXg+9LzsvyCv4JTQb3amjZcrdD
   pEsFGZF/SPwYwZWpoOdGgT+kDf0qrb1wpNhnCyPtWzt3CXlT5cUbh8NIX
   biM8mAfCPMPFWzojN7uGIiB2ZHc5Df1RB+t1qMWbDH3dFIwmwfj4LNx+y
   M13o8JHdNF1MeF4ivR1ptNJN0X7FFtsx+lQ262w+nCJLf87JLUyvcS4vV
   tNIiOiExvj1L+zAcTqdfMOX2jCednaSaS08rc7NJueNOEkbolkDaRiKEc
   g==;
X-CSE-ConnectionGUID: WX+V3XDoQJGR0Nbb+rJFhQ==
X-CSE-MsgGUID: mG4enw0YTOu2BI9kMD8RZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67054118"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="67054118"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:12:07 -0800
X-CSE-ConnectionGUID: +1ZfStCFSsaNGKvUHp4hSg==
X-CSE-MsgGUID: 7LmrhrY1T7OM7M88uk+S5Q==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:12:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 15:12:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 15:12:06 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 15:12:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+NXj1aB3PMgQioru44M6HuokRvyMwq8mjsMPxPwoYYu+Jh171HsXbGRBoADKW+9ipbhKe9SBoEcE+/Y5loYnxx51FMCbIbXywH54X4oLppsrgjEjzMCcKh8U/X+XnxX+/EYz5z6mRwhmPSSNZ1wHQ6BqlRyL4cgnBuIS8WQipoAysBmpmEpNKWQ/BLINmJ/be5UX8K4G3iT8YECUNhIT2bTrUVMnigkZoaAq0cqc8Cs4mAOIofgIUGvomcz5hrK3djJ47aG8GSVcv4qD8rXv0E3G25Hd+WUIhOdXbzipdhOw8FaTNCBlxjuKar4Pm4Y/4iob1jU0qIdqnRh13HceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UEf9rCoBP8Prg6MlU3WxNDR/JuDF92+vLFZQ8eF91s=;
 b=piCdQZ0QwBDs7D040IL8WzFB7dGCnvOw1q1zp3VyJljs5SdgyL6XcIZ7Oxb3xf6VhhHOT3QlnntffwFr2eWZQVM1iHVOng+Jrhqi8dFnLDBLBj9oCgNGfdcYfvtu5sHfVxNyGW7pPwmztGAX7wNVL9ywmKLySqpubUmcdP6O3HOCXRMWMHHBNS/SrELuDKnsdcgYGRu0ehiM9i8CxTWO+J4TkS5hh0/5OK1Dfusn1cVRvF/z0ZEEP9gzv1b7zBgrX7kfZvTOcFeXJJhWpRQizt0vPMEnaCBHcsa0yE++qS+3E/pkdtvDc11GqU9OVpXPszKCTFmo11He/6ZEnyYwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 23:12:04 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 23:12:04 +0000
Date: Fri, 5 Dec 2025 15:12:01 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>, <stable@vger.kernel.org>,
	Michal Mrozek <michal.mrozek@intel.com>, Carl Zhang <carl.zhang@intel.com>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, "Lionel
 Landwerlin" <lionel.g.landwerlin@intel.com>, Ivan Briano
	<ivan.briano@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH v2 1/2] drm/xe: Limit num_syncs to prevent oversized
 allocations
Message-ID: <aTNmwat/4RAP0rC1@lstrano-desk.jf.intel.com>
References: <20251205224808.2466416-4-shuicheng.lin@intel.com>
 <20251205224808.2466416-5-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205224808.2466416-5-shuicheng.lin@intel.com>
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c49ae97-465b-4ef6-0b89-08de3453b3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?CHCzPvkBjJggky+LK3j+PU0zo4G/Bqcv3CN+p3pjhe+O5l8+odOtotsmbE?=
 =?iso-8859-1?Q?99qJ2xBKm66I5W+AZ9ADHXaFp5vJBUFVXl+q7PEHKPILwQfh/A9BmyKie0?=
 =?iso-8859-1?Q?U2rk3Y7d6qHMWg/Y37Me4+jkQBx0AW1iqlS2etCEXWoV3BdBjirHPy9iU0?=
 =?iso-8859-1?Q?ZnE/A+UbyvlZHlY4SCtI78LNeh7LYJyGY8k27PANQKSiOnusiZKNr4c2Ne?=
 =?iso-8859-1?Q?ylkA8n2r9kkdQQFpDBYwCMVdfWRsj2Is0aVtNgX2pzPyVhUI1REKjMSAyn?=
 =?iso-8859-1?Q?+OXi1LXOw+de+hGgW07/C97r2kBkH7Sfdhzs/WemLldhLxXwOVvhQjPK+4?=
 =?iso-8859-1?Q?crnZysldUhV/xz8kc6EFYUySU5fMxnB96orlqt9kax5Bk+D8hHcoy+X3cJ?=
 =?iso-8859-1?Q?5/azgEwO0rnsRMGCKfodWPFDe+A7ipQVvwqV7VV4rzLAMSbCY9iPBn6GTw?=
 =?iso-8859-1?Q?gkT09oXd2xKdb2KQEVELtbyktcZIzYfFkq6f+8FyI/0cIAAk0f5ONYnb2N?=
 =?iso-8859-1?Q?bmRQeWOw9CkDs2LzmnVILOd2vf4IfcK0jSJ/twGCRIiYkAVhZLTW47Nzca?=
 =?iso-8859-1?Q?WXsyxFoFayrIvmnxrjHoXSHlz/JQg5GYE7bbAYQ/05e83y1EUJaowu6BlA?=
 =?iso-8859-1?Q?ixRSRovwbnuGMLsVkxuk5trzJvz5rb7pkBCgvYLW1JS080rkusYz2tYDzs?=
 =?iso-8859-1?Q?NdqcaSLh/Y6vzU6l6ONK0PrDOKU/+yCDR7hFF71IMZ2zulgTmrUESnA3w0?=
 =?iso-8859-1?Q?PsXWy8W+a1U7OuzjefTyAAqI5kOb8bxCuRTmW8A63rI/yclyIcHQjtPKuE?=
 =?iso-8859-1?Q?qWuEI4hiKHJ4qGpP32hmqDaCTPw5d44Zkm19Lx1I4TvBKPOtWfMTRr3b3M?=
 =?iso-8859-1?Q?5qVPmpv4lhoao8i8EP+xaHsImmICnDvcTvSTPdWfIGTiqdGKHHfW+gnmya?=
 =?iso-8859-1?Q?gN4VYtMvb+OvX4qE6XCGQ1Rjvg1aDBKSqRAOnDCLoe2PlRPWhRe6vW1tVx?=
 =?iso-8859-1?Q?mk5CFbq8RCh2B4ChTewMeH1ef91YwTIBXRtlMcXx0ie11q7h1t5iEDqZ72?=
 =?iso-8859-1?Q?0C0mznrg9IN3Xm5Eeg3WVwFhBMmj45u1RKUXefnr23DAyTRPN892hhFfw3?=
 =?iso-8859-1?Q?/cfbxwPaHXexokZHaYCmRxov5Rzn3jZh5F18SP+++pePkU2Gws5Rn0/Zb7?=
 =?iso-8859-1?Q?odPTaAM1/FH5RkgdEATgm7+8Pby43cpugUz0vsV+Idub9z8XluaGjQ6+yo?=
 =?iso-8859-1?Q?LZHdnvX+GupJQnoyPNT62oJNdjm36ZvKWJf3WaJuu7ahYv0Yiz8b/ODJpX?=
 =?iso-8859-1?Q?r6KiVXoFjRYYQU+3E10Eck9HKZ+Pe70Bp8XEM9aHXyJjkDQEURoNFnDGoE?=
 =?iso-8859-1?Q?L5JFIddYxmwMAvn9Jnv/6HQlLnbgDQAjVcJvJF5tCkG2vcClF6BOQbnzMj?=
 =?iso-8859-1?Q?wBr8UaGut/FCHi+aXbrtCUlwK+fm6eKreR89brxYCRu9aasEbShCE/FVmT?=
 =?iso-8859-1?Q?hSf/DkGEIXKGgqwV9gg7vm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?viVf7B4aU4KeD9WtJBpGKqR4jQiJgYrFhXMucHgoUDHYVONG+YqElM/DMh?=
 =?iso-8859-1?Q?Gfp/zzRmFB2CLnzZ4D6uRDrmswfQ8M5a7JQkaX24c/fPuS4fALAYzqyF91?=
 =?iso-8859-1?Q?1Uxr+7y4YUYclG90l8my7i7x0uJ0Ov7JAHX34xLGGxrvZnH/vkJIaTSo4i?=
 =?iso-8859-1?Q?1gMl90ti0RSPUwj0Oy9gWpfHtQUoxKZKLiVoK5Yf/Y0aKBnwxORaToR3N+?=
 =?iso-8859-1?Q?BMw3KwWihkITN/G+WjWF4H/3vfRY5dBt6RkINr4XxeIMbmiJGRfvm5Sa8C?=
 =?iso-8859-1?Q?0JWeCt2mDujKhXs4gXwg14/TPtW1pqMvYUcxmDa04Lqw9gO107dtzUnbY7?=
 =?iso-8859-1?Q?i/t9bHIYkt1phoO9iaXIlbB2zTs6H/fmaMIsD22WtrZ/vzqXT+JklJ5F2T?=
 =?iso-8859-1?Q?2QtFRw71XPfUqS+fcgHMjmG5D60xaKYywjrz5rkHLIwCXiwfYEs+0GwrYc?=
 =?iso-8859-1?Q?3L/Dn62IE1FxTKIbPlajHujLQNTNA7U4B2mBH5pYnvZP5BOjVQAzwGaWjZ?=
 =?iso-8859-1?Q?PVLeOWFs6Ksyzli8aS0aUTNUuwxIt+DeAbWz+MjRegM6v2sT1jGfenyWWG?=
 =?iso-8859-1?Q?iKb1lVkXXCkjE8/Pr1EIEYZ5wk35H6npUBEYCarT3aiGSgQKWm/U4Obr+u?=
 =?iso-8859-1?Q?UgxGRoqZzIIaIzdKAKlGreNwDZ9Eo629iytTeJBhu9e0HB7YHNIB0K/a42?=
 =?iso-8859-1?Q?a4umgVaX9guLvhnqxwbwvvuWDlz8tEk1WywUoQB+S/L8AksCV5DJ4RJSdB?=
 =?iso-8859-1?Q?PmZO23ZuEj5XMe+PxtKt7sKiZDwdeZDVSdx5+YXi4mMn6fH8d99VGWksgW?=
 =?iso-8859-1?Q?vlmra1mYjE6x9CPe3NT1qfLbm7sPcs8i4V6i2Ktsqr356WkVHVnak1mFuk?=
 =?iso-8859-1?Q?A/nAME0qd/TwRGG3NhmV4Nll/gV3FMDrkycmq7gxAtlG2sqsnWsYcwM4tM?=
 =?iso-8859-1?Q?PFqmIw2P8dHt/me/HroxL6IrGgtNS3rxaEzUwWWpiUwLjYQCyUTTXq15Uk?=
 =?iso-8859-1?Q?RnTVVUeqb0FXl9OjDS+wbJc/GuY7YED6SPGBG+LiaIR2eBCXpts24uqFN6?=
 =?iso-8859-1?Q?w0Jc2pAoitZjN8Azs5YZAd/89TNIn/c2OWKqEQyVfMNI+/zYF+a7MwlKfj?=
 =?iso-8859-1?Q?WiahCbqvlVUEIdkJRmH5G/YD/r+YbQejJS9fYoLvZdRkA3a2NHb4+/ENFd?=
 =?iso-8859-1?Q?FZ33fygOMzLkn59GidDwAsc72A8mODhAxCsM+2jPRCWqBMu/3Hh1aaEy/z?=
 =?iso-8859-1?Q?NU86uCBvpHCUszfcWMSI9lz4mev3pV6P+rVl72kRw37BEjzSngCk081iNU?=
 =?iso-8859-1?Q?MRevw9dO94Ho1kwxgGFp6+h381IZn9wfkclowQS7H9FRVoivD8MRicA2DQ?=
 =?iso-8859-1?Q?VTHS3JSmPoU66rQesxQ2C+4lenoI/0ZvLgLO6BkmplbUiO5IrqJh12BuE2?=
 =?iso-8859-1?Q?PkHOJINKkzR79SOnZN2Qh4Xh/uEAZrTge9dBZKAom++f7ZYp6Q7qtHdsK8?=
 =?iso-8859-1?Q?z3MA5Tqoa9STK5VUyQuNROFnYYOpg3OUAuzqjOoCipX/PoFYiNxDferlMn?=
 =?iso-8859-1?Q?YCF+Y9oErjGlXnmj7IaeUfKE0hDAsaIh2IYULEAKB7fU0/o9+rC34iHqwx?=
 =?iso-8859-1?Q?jgoXBu9CzbT2i4yQCW7XWM1iXBiXFIclDPs46u9GrjlXRNj77k5J6BZw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c49ae97-465b-4ef6-0b89-08de3453b3fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 23:12:04.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Otq0TAvFSmt+uS5rbNcDFEGKJg8vdRD4OLdHJ8cpnJln6VZQak3SdK6p1wrDsDgXTXSogEAJ80qNcyLx0kr49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

On Fri, Dec 05, 2025 at 10:48:10PM +0000, Shuicheng Lin wrote:
> The exec and vm_bind ioctl allow userspace to specify an arbitrary
> num_syncs value. Without bounds checking, a very large num_syncs
> can force an excessively large allocation, leading to kernel warnings
> from the page allocator as below.
> 
> Introduce DRM_XE_MAX_SYNCS (set to 1024) and reject any request
> exceeding this limit.
> 
> "
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
> ...
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
>  ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
>  drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
>  drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
>  xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl fs/ioctl.c:584 [inline]
>  __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
> "
> 
> v2: Add "Reported-by" and Cc stable kernels.
> v3: Change XE_MAX_SYNCS from 64 to 1024. (Matt & Ashutosh)
> v4: s/XE_MAX_SYNCS/DRM_XE_MAX_SYNCS/ (Matt)
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Koen Koning <koen.koning@intel.com>
> Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Carl Zhang <carl.zhang@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Ivan Briano <ivan.briano@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec.c | 5 +++++
>  drivers/gpu/drm/xe/xe_vm.c   | 3 +++
>  include/uapi/drm/xe_drm.h    | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 4d81210e41f5..0356d40ee8e4 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	}
>  
>  	if (args->num_syncs) {
> +		if (XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS)) {

I'd put this check at the top of function before looking the exec queue.

Matt

> +			err = -EINVAL;
> +			goto err_exec_queue;
> +		}
> +
>  		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
>  		if (!syncs) {
>  			err = -ENOMEM;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index c2012d20faa6..24eced1d970c 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3341,6 +3341,9 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>  	if (XE_IOCTL_DBG(xe, args->extensions))
>  		return -EINVAL;
>  
> +	if (XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS))
> +		return -EINVAL;
> +
>  	if (args->num_binds > 1) {
>  		u64 __user *bind_user =
>  			u64_to_user_ptr(args->vector_of_binds);
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 876a076fa6c0..f7f3573b8d6f 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1484,6 +1484,7 @@ struct drm_xe_exec {
>  	/** @exec_queue_id: Exec queue ID for the batch buffer */
>  	__u32 exec_queue_id;
>  
> +#define DRM_XE_MAX_SYNCS 1024
>  	/** @num_syncs: Amount of struct drm_xe_sync in array. */
>  	__u32 num_syncs;
>  
> -- 
> 2.50.1
> 

