Return-Path: <stable+bounces-116330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553CA34EE6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF7E16D262
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471524BBF7;
	Thu, 13 Feb 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxTOoVx+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E58200100
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476820; cv=fail; b=lwnw2bxc2I3BGSS61OaucOOXXZYBvXGjCQbH+dQ21k/5q2D3e3g8I1ellOxMsBj1guLbp/A6jDUcA7HfEf4S/w9ycsRX2a+jEL1mATqgPTbX2lg117UHzh35BKnzF8sd2HpOWWf1BZD6qej1M1GEOF7iW3E2ESU79odi1UBi34E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476820; c=relaxed/simple;
	bh=fbB09ucxmhIfcFJRTwkw0F8dRXxqxptYvKERWUrcfzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=psRvIftmjBYrW3ByySfj+PIHrylaS8bg9Zcv9cUye55M72TkGMQfnSjpZruJ+pE6QZBSl4qFaExrdcBlm6L09Hck9w7y8brxPmIigLqIRrdyV5CCBfF4Y8UFE7HN9XhKqcgOMIyeafOaRPcsxQ4kCHVqlY8D2aZUsV53sXSjHkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxTOoVx+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739476819; x=1771012819;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fbB09ucxmhIfcFJRTwkw0F8dRXxqxptYvKERWUrcfzY=;
  b=VxTOoVx+ZWgof7fRUliF9f/kAho9Roq64AGgN6sO2zBWBNvLJXE5IaI7
   kljgkvOGbv6zh781zIlWkHJmjO0y6XJWui4xXhP6Iolfqz1F50+USo3nw
   7cXqa05QSotAZDyS/0DQBsrEN5i2DdhcAputLd6yrBhmcvrOaVXRQjP8f
   t7xrfZ73c4AAcQIzKZzOFSfB1rnLUfVI8M/de3smWouKHGbfKF0FIxtCT
   AxwpbboPVvRWg/1vGlWRvToiTArcxGGQIXqL0LnqeRMkXdu7EiCpPt6gM
   ctbkk36ofzkckGqpArj5p3bm4aMe8LYNEFlQxjSdV+DhInuFJpEKRSMqF
   g==;
X-CSE-ConnectionGUID: /uURO+hSQNedVpmrRVLtpA==
X-CSE-MsgGUID: OiP/ISyhRdK+wke8KqOuGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="27805703"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="27805703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 12:00:18 -0800
X-CSE-ConnectionGUID: oRGp9vEiQ3qvyX4dgykZ+Q==
X-CSE-MsgGUID: ntyodCAxS9KMZkGD68rvkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113226157"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 12:00:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 12:00:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 12:00:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 12:00:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRrwTZ+9C/Z586b6uKhPn06ceJoUIGtC2s8xPDDtaQ+/hReHHuKxhNDivJ36Mbt3ZUnnsuznZiJVklp1Iy4mKEkrPCbaJIGMGSkrF3/9UI9vlRo9Q1t8moKY5STYDCPIrDXSBNFdx+ejK4e+DatbiaKilgeAD5ZLwGwKHPG+/+m2WgfMnJpvvgmnHdxJWIf1+6hTOPNIuqlesATqsJ0pEgiHiERuHQZ865yeA1SFtYvSqaRu77T+HlyEKqH1kegETMgVeVNGzNCNn7bPERqmHAocxkQvdY6Awa1tNku7hZsp+ajh97Ifpr13xGQ85iH4079sve8A1uZ8P2g0ScPQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeUWbfTwNxG/IX9oZ6rSOsfBBJCufsT0yGt3shYjqoY=;
 b=tIXqRQIDFoO7UmvaqiKodAQIht1nq1CH0ooyFq60696ZAfIPQJuH+paZhd+dfFqJQzV4Se5Z3ckW8hncmulsPsTDnBAH0p90CWsD7LNVvD9oofn+GibG9fdEF+WUrEu4MxlhW5FyQJSg6d7KcnshgfSrKMe8rAvobiStOMxGyIeAijMz5OaAzmToFqczed529B7MpS2Wh04oZXk21S+NkAw3d+OHh+GmxUP2RP0Tj2Ow5unu+ZL30XKingDegtTx8/QGccvq8xGOgTFdT85GNqZwUky+iAnpEx1ME5cZGWVDb8KSyMu8mAmpCxqRc7rlB5YFkGcNuquq9/1IGXYwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PR11MB8671.namprd11.prod.outlook.com (2603:10b6:0:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 20:00:15 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 20:00:14 +0000
Date: Thu, 13 Feb 2025 12:01:13 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/userptr: fix EFAULT handling
Message-ID: <Z65Pibkm/EMPAuMm@lstrano-desk.jf.intel.com>
References: <20250213135434.186967-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213135434.186967-2-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PR11MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dd63b0-2556-4b5b-6110-08dd4c6907e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TSjlJRwfIwHQqo7XjVrTW9XCvFAb3g0sbrhecnNbvWJxZ6DLZBVhmNG5qT?=
 =?iso-8859-1?Q?ycvST/r+H8W2CCJZnQyk2UcVvSWpQFphvbuKvMgERHN7iwIRN8Q1yLXv+o?=
 =?iso-8859-1?Q?K7LqBmLq6zC6ReabmaWWq3vlNxmldhUUdsDXYkmggx3lPYkz23ptwN3Y8n?=
 =?iso-8859-1?Q?eF4IxmnVH0TXucpwrr1Jv40wX6EBEksRGCtpypFjrqHyuqJJGd8zaCIq+6?=
 =?iso-8859-1?Q?tAnyeuBkC9oCRcYWrlAAF8hP2D+Uq9gs7FDcNzF9JHEvCE8VkuwJvw5hDf?=
 =?iso-8859-1?Q?wzIDHlw9SOF9R6DaJEXsTUYZhF2DBwD+QLIBMrpp66clqrAe9K21aH8C2N?=
 =?iso-8859-1?Q?ed+I0xGg36ydTIBJQvT75TVFqoJ7ddb49bQqrDkmw+F560KldbLRZJPmAu?=
 =?iso-8859-1?Q?WPM6WBUi/zIT/PjtfAHs+vxXkPkxKPHWUGVl52aAlbAb9Qt6mTC74FtIdD?=
 =?iso-8859-1?Q?dSSocfeSUlzvcR+s7qKt5gmvocYZt3FvwVujbrjeIqIeNkURV2s2L787cg?=
 =?iso-8859-1?Q?GdoE+EflyD0K/9bgEbVsjZd6K9fI0jyHS61YxnwUqqYNTq3ERwwKrT6bLa?=
 =?iso-8859-1?Q?4s/HVFaZyJOT5vzz717h3UIxzHfY8GS/cAWPcGitUEKrc1jzK4UL+KFIsT?=
 =?iso-8859-1?Q?mVi36Y+ncXhZ+7+/9H4Up5qA6Q2uKsrUp8bmnI4jJdQwOANFIaIzGND7QY?=
 =?iso-8859-1?Q?gptbvSan1lCmtNXZw+zwG0gEuXS0/uTpo1CRkLn08Xs38MIhRX7zroWrzE?=
 =?iso-8859-1?Q?KzjeVY6wi84peIp5c9/P+JU4aNcCzhNM+tW9JJcIXBTNjzU/IxrGimskjI?=
 =?iso-8859-1?Q?CQAIntuzRlROeRNtMB4qunyCXeNJ49r0ib9DX77uEC5IDxLOu2/deSneml?=
 =?iso-8859-1?Q?I7d9tfQ++5/wdpy1v2TFWHwsvygbQ4j2Tqtph8DCzAYfms44jEjJOZx6qJ?=
 =?iso-8859-1?Q?Xg/+G9X7EHWS56YXheihhFfb4bE0Zf1njJ1vkNhhz5WVKD5yR9fL5hXA1G?=
 =?iso-8859-1?Q?9N/0d963cJU9lv6QuXwLLzBWRF50Wpxxk15VhsPkeVgnu1U9IGtjhC70PP?=
 =?iso-8859-1?Q?p1sF05kht1Vb239Jm5pS046Z0mvi+Q7krfG3P5Jg7ZWN+KkfaLC3KbJhFB?=
 =?iso-8859-1?Q?TVQcwVnOqhVAxtynw5bB/uPmi5vC6ayv6CcCpPQWy+StMEBCvQiFQIbhEW?=
 =?iso-8859-1?Q?moczBnYgeF9I/yfjQJPORbD7BfiztoLhiaSBJsqtguq/SeUb5Txbdsc0jx?=
 =?iso-8859-1?Q?/JFJPQKbZUnnyUOR8o0EKtalnUqlBvn8xOb1d88v4bxzoMt6pXe8y/DW5+?=
 =?iso-8859-1?Q?H+EM1yWX2CqIy2CGDBG0KgnDqfDQk9zCloxRfClkJsB4gfWkXpE17upenB?=
 =?iso-8859-1?Q?1l8bAaFkKKHDs+npmuLfJjlXWoTVK3MJ9CvnN20CstluYPCzXOxV5tVE65?=
 =?iso-8859-1?Q?KP9IlayGHnsQ+Bj5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Agv+ZAIqZR4BLqFs/gMTLz6ARm3JQ8pFUkRVYTjkygf5oz4JPYY8pp8ZsI?=
 =?iso-8859-1?Q?B+h4IqBKarfACJmuJqRSAqwkcDEj8rmZg/pwM7ZGkhZzyKgXGRF/E2tO6Y?=
 =?iso-8859-1?Q?waMApKj5q9wv1UMIyAAqqIvpP5lPOrcHgRrw97itBfidkieOHDRDynNx5+?=
 =?iso-8859-1?Q?PQR7mPc5ocRUefzflwxnwrWfiRQ8i2XoJHecn8N+4LN5iPwBMBWTqr2ynN?=
 =?iso-8859-1?Q?CPO/t49PNAw2Q3y6R4RqwA7m4NFcKyv2aD057Ge4s/J90fS2B5C3rk+WY8?=
 =?iso-8859-1?Q?4vcbHIsecl+KrBxxrd0Y9P3f+57hOw1JyewJ9QABjXlSvjVSz4+4JcHBb2?=
 =?iso-8859-1?Q?xX9TAhgEJrFQM+aYrGlwr5aqyh0neTrUSQXg40IaBC39hemNLlkSuW3iyP?=
 =?iso-8859-1?Q?ahlW7OTfjEWGvN8IMaItB/VcvXI2qPq/qa2Rkd9I/7o/LS81KQ7BlCaGv3?=
 =?iso-8859-1?Q?5GodaKuMqNCQErolx3YprrV0FKEkJAnYuOZEc56cflfETLf/1bTQvsxQeL?=
 =?iso-8859-1?Q?RshaG3wHBfwl/PyNnEeJxFEP9IW2cQ6Uhks5AdUNft27m1g8BZ/DWf6jMT?=
 =?iso-8859-1?Q?409S4X4z9DJ/Zs4YwLiV/UaoljmPF0xsFARoanH5BJmNoWC2TyVwNq5X6+?=
 =?iso-8859-1?Q?vSszkx8k6eSMTXFYKTydjzmGyXlebJeTC2EhkH/pEnOxgjTkq92CQCQBJ0?=
 =?iso-8859-1?Q?za0HmpWsnWox6o5SaEh+Zpfre6QNl35w/RKEFXFCinQ15OkqyDSetG0Jpb?=
 =?iso-8859-1?Q?8H9sAVyc1I13TmGpvFopiDKGplBj5ERuDJPv2Uo/x+aiadLlmIl1sm6GU/?=
 =?iso-8859-1?Q?CjPTkBBKgptYxKr/JiLmhy7iRfy/iCTavklM51xxbOAkiY8aEu7KgDaw4T?=
 =?iso-8859-1?Q?3Sr/4DCCwfCkY4deXT93SVJ8x1h92LfZN1DM8+eb0f51B+2vXYPOyDsYL4?=
 =?iso-8859-1?Q?nS/YG0iVTO5l1ZfC3/hXs79i1VhlS0nBmB2Pkq4VzWabK/T6G6mWwjVIAr?=
 =?iso-8859-1?Q?Twn98BY0uzjHpJ8i1ruaijE/pkj2HecgA23mLV2XROhdyBNxA3CvIv+K9I?=
 =?iso-8859-1?Q?AkClLf3xzFeP8CIkW4OX3aV8SY260z4byoUSQUPkbF95O2r8GcKFIj7J96?=
 =?iso-8859-1?Q?OxMDtJEmBM/C3rMYk6b3fS16CZpiiFucvQOobs3dAMSQlBcqXjAASyF277?=
 =?iso-8859-1?Q?lzDfhLiCVc6E1+xsKEc+11ereOgGKOUu2Ydgp9f37xvDbK9PaM6n/3tDME?=
 =?iso-8859-1?Q?L9e07SrzxLBkBeg5HetusrAH26hknu0nmV5bXz/8i/b8DnZLv18V3f9OLm?=
 =?iso-8859-1?Q?mkla4UTsRT9RMt05mca2VfZFVb1OGS1hbSGX9y60ejdH2/lWo9W2ebbGJK?=
 =?iso-8859-1?Q?t5KqQFdDF07t+ghUzTuuQCPzKUbHfcDPo3ofzIo3WG0WuTH0GyaV0cySED?=
 =?iso-8859-1?Q?fCF6NyxNBg0O8xp/Xmrs6o5+a4VyNR9/ER68YlOcYqnMa5Fagmas4OccVd?=
 =?iso-8859-1?Q?8uDBizzvn+wO13gI0pzSqr4PPi/JZvbasHgWDS5pKraktH5Yx5bjLEGOb+?=
 =?iso-8859-1?Q?KvGkqGDf5Yza/Xp/xWD/7o1RFJZQcvv+6sT2VqKcWUSx+QBTDqL4d7n/s8?=
 =?iso-8859-1?Q?VcTt3xamIexE6A9CnCa2LlAb2kYLt50FJGRSif9QbSY4IyFW8fh78FZg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dd63b0-2556-4b5b-6110-08dd4c6907e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 20:00:14.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1vxmSuVjy8BrFMb8NES9/AbHMMTwzdS2OEyRHCVgcRUhb05fiy+WYy9rQwAhNMIrq8YQjksyP+mYnypCCJePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8671
X-OriginatorOrg: intel.com

On Thu, Feb 13, 2025 at 01:54:35PM +0000, Matthew Auld wrote:
> Currently we treat EFAULT from hmm_range_fault() as a non-fatal error
> when called from xe_vm_userptr_pin() with the idea that we want to avoid
> killing the entire vm and chucking an error, under the assumption that
> the user just did an unmap or something, and has no intention of
> actually touching that memory from the GPU.  At this point we have
> already zapped the PTEs so any access should generate a page fault, and
> if the pin fails there also it will then become fatal.
> 
> However it looks like it's possible for the userptr vma to still be on
> the rebind list in preempt_rebind_work_func(), if we had to retry the
> pin again due to something happening in the caller before we did the
> rebind step, but in the meantime needing to re-validate the userptr and
> this time hitting the EFAULT.
> 
> This might explain an internal user report of hitting:
> 
> [  191.738349] WARNING: CPU: 1 PID: 157 at drivers/gpu/drm/xe/xe_res_cursor.h:158 xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738551] Workqueue: xe-ordered-wq preempt_rebind_work_func [xe]
> [  191.738616] RIP: 0010:xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738690] Call Trace:
> [  191.738692]  <TASK>
> [  191.738694]  ? show_regs+0x69/0x80
> [  191.738698]  ? __warn+0x93/0x1a0
> [  191.738703]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738759]  ? report_bug+0x18f/0x1a0
> [  191.738764]  ? handle_bug+0x63/0xa0
> [  191.738767]  ? exc_invalid_op+0x19/0x70
> [  191.738770]  ? asm_exc_invalid_op+0x1b/0x20
> [  191.738777]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738834]  ? ret_from_fork_asm+0x1a/0x30
> [  191.738849]  bind_op_prepare+0x105/0x7b0 [xe]
> [  191.738906]  ? dma_resv_reserve_fences+0x301/0x380
> [  191.738912]  xe_pt_update_ops_prepare+0x28c/0x4b0 [xe]
> [  191.738966]  ? kmemleak_alloc+0x4b/0x80
> [  191.738973]  ops_execute+0x188/0x9d0 [xe]
> [  191.739036]  xe_vm_rebind+0x4ce/0x5a0 [xe]
> [  191.739098]  ? trace_hardirqs_on+0x4d/0x60
> [  191.739112]  preempt_rebind_work_func+0x76f/0xd00 [xe]
> 
> Followed by NPD, when running some workload, since the sg was never
> actually populated but the vma is still marked for rebind when it should
> be skipped for this special EFAULT case. And from the logs it does seem
> like we hit this special EFAULT case before the explosions.
> 
> Fixes: 521db22a1d70 ("drm/xe: Invalidate userptr VMA on page pin fault")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d664f2e418b2..1caee9cbeafb 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -692,6 +692,17 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>  			xe_vm_unlock(vm);
>  			if (err)
>  				return err;
> +
> +			/*
> +			 * We might have already done the pin once already, but then had to retry
> +			 * before the re-bind happended, due some other condition in the caller, but
> +			 * in the meantime the userptr got dinged by the notifier such that we need
> +			 * to revalidate here, but this time we hit the EFAULT. In such a case
> +			 * make sure we remove ourselves from the rebind list to avoid going down in
> +			 * flames.
> +			 */
> +			if (!list_empty(&uvma->vma.combined_links.rebind))
> +				list_del_init(&uvma->vma.combined_links.rebind);

I think this moved before the return above.

Now that I look, the error handling in function wrt to
userptr.repin_list doesn't look right either. I think on error in this
loop we need to move all remaining entries in userptr.repin_list back to
userptr.invalidated list.

Matt

>  		} else {
>  			if (err < 0)
>  				return err;
> -- 
> 2.48.1
> 

