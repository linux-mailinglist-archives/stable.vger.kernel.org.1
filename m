Return-Path: <stable+bounces-91969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E027A9C281F
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 00:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F591283A0C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F781D1E89;
	Fri,  8 Nov 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieeYFF1w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C061DC06B
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108582; cv=fail; b=ROVK34buJ6tVDuWojvAa1vpfOjq+96Ddk4Xl9KB4eTjm/Luk/16HtXRJcD3bFmD9vmDOBnFSeiic4OgLSgszol+T5ooIoUUb1iD3pIRyg0BXDt3GzTH44iYJj4BwEsgPbSIdFFuI8ps1R2PQcTB7ui1OKzyQrJGupXHnPtfyn4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108582; c=relaxed/simple;
	bh=z+2lB73y0EOsPq0zEiYkZo1EjYLLZC7hY16XjEZP+s4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gTUkaUD5vcHitmzgyznwAENhs3VWg5vIPlaAG3WJvXJp70NAuySOOilbKn74eRxvNdtG2XaTE3uQM8X1y5074Qof3A/ICAxf2DS3ZcaLev3AjxD5H+6Kidz/EpU9zKxeVUEyTMwXi0WA1MLml0rwlZ0kDHJUlmgLNwXwgDUbyno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieeYFF1w; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731108580; x=1762644580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z+2lB73y0EOsPq0zEiYkZo1EjYLLZC7hY16XjEZP+s4=;
  b=ieeYFF1wA+ivOCDVokSKdGg74tr2q3nIhJwW2nt+YsxQtSDT1I91eywr
   txqcUpKU0vyfF11RioeO7sSBER5Bjb2JTwilypV1jCpfeE/VgliZrptJC
   NOi/bgenOiODQWF0ZbTmMO3PABlgxQZ6XZqsZubQhnZd1r6peBQvD+OH4
   RmrvAX3PknmIp0UA0qlqgKoxEEuC0fdc3/ZDlgKIMUhG695Ya5SBM38os
   3PDmJOTEkIdffmM1wUV1p5dZitGCFM5JYRyn04f+GRwFBuFzQeQwL3YNU
   +jp4m3tWfnYAHG7cOEl6WoDfW3nH8P9kDyrNor49WX9XePAmiVJUd4+xS
   g==;
X-CSE-ConnectionGUID: Ez+Nn6fvTRSnXtKQmkAXkw==
X-CSE-MsgGUID: yrp5XWPxSHWhNXJvtDquPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31172220"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31172220"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 15:29:40 -0800
X-CSE-ConnectionGUID: EWV2W8X/SYKy08k+L4BY2w==
X-CSE-MsgGUID: eCEAfkPiTQy2w1EalG1bBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90619415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 15:29:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 15:29:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 15:29:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 15:29:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usqRTgVnTUlrWamhWM48Do/IQo2csqqggfBzvbqruGkIFCfZDkDd0COJpzqpEaacZsv07Psvc/OFAjHk4cF5tSu4Jycl7csJu6as7YrlU0V+41o+L87SLBFxzNt/JBTWRnPI6Voe+juNZCuwIjaAnxrfAe1ibwth3pJyBpuP4V/ApWPT205waNAft8jbnz5b0F6Iy9UnwECbQRgUUpkRcMixgF7jyuX2TLztL+F1BZQj4NoVINVqgWodL3QT1vALki5rIIeMEKqmWDxAGLH6vrinu2CtdNf0hIodm/UUJpjJbRgBqcBWhuk72c76ChQH4oydGPdo7zHPMv75Mk8YtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RlmrN54nwpI9UNmtJpjMyatirCRmekdGro3yJ0h8R4=;
 b=kSd8+EJViXjPFqi4QiGNdr25mfgSWMQVI5Tkc0m5flZ+vEnlUEyhVByij0nlTNoLzNi9Ih6QdqwNkrE09LFP0FDFo/KMlP1hEyM7BCz2RNuFf5d7IqMnEg9LVlH8ibLQEI2yKQQvg2qb40vb4LDsGTi2mdLEzBHrxMS4c7knoZaETmtnX8ncCCmqNqJR0iNESQ50EwZX6N/QbSF8c0BYrU4Qa+C0zD1yAQwgLq/6G0C1jzNWBtu+5ubiZ3xRwQcs1CTh2kBemXhUhSzgK7D3PFih4J91K4378lGqJBZW6bD/XjOiv9iBEHl7Lh+mKvl5rQGqSGDHX1MwlO1yKn81DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB8418.namprd11.prod.outlook.com (2603:10b6:208:487::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 23:29:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8114.028; Fri, 8 Nov 2024
 23:29:36 +0000
Date: Fri, 8 Nov 2024 15:30:08 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <Zy6fACI72B1ERMEs@lstrano-desk.jf.intel.com>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
 <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
 <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
 <ZypxenMNvxL17mau@lstrano-desk.jf.intel.com>
 <u6gqllfd7gq5cg5o2pwljzmg54qbyow33vdzymxzclf4hgaxrr@uu3rr5wstwqq>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <u6gqllfd7gq5cg5o2pwljzmg54qbyow33vdzymxzclf4hgaxrr@uu3rr5wstwqq>
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a122420-f2e3-4ac1-c811-08dd004d3571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Bp3UGCJ2bHHhe3npQo4KV0qPkwDnylIe4MFUSGPBt5MVu+NsQMyevptwgCC?=
 =?us-ascii?Q?fuqL94/ddsKkv25oOTulKqKsdVnlDR+8v5+kKwROnzji9t0UKY78U8gndn+t?=
 =?us-ascii?Q?5D1mzlCMWrLQwWvedfI+qHHRavMcJ5/5eVhyI3dm4fTeOrRuJKWgu+1T412h?=
 =?us-ascii?Q?ElD8jutDVGpRUfy9fviYd2q1OrvyE6DLSQsHweu7zXcXwoaOhOoGDn0yM+QG?=
 =?us-ascii?Q?cBgGeKuMmSZqFCLQbHG3N8TFnXRnNBEaui5ffLKkGR0WicxhqS8Zj3nVlf/U?=
 =?us-ascii?Q?t/plcQiSY3FD8N8NmcT8e/Ue24/Swzy6lJtKIyEjJd+mgbwCMuh5puIw9lj6?=
 =?us-ascii?Q?RizfvPEVeYy6qGCQ2IFeSDBE1gKKzKcDk0KQV90ETK9vW4wpODXBAnsv8t4a?=
 =?us-ascii?Q?ybisiOSdk3ArZXMbOKzy0EAkMDIgdb+ZifQ+sNYFoDawYYzoP5/A0ZhKXOnH?=
 =?us-ascii?Q?OcFlTpYReYVFYxHWAfp0XIELdguNY9kDPHQjr+ZN9S9i8FxyZHBWEKQmXwCh?=
 =?us-ascii?Q?XjenF2OXst2PU43PrIoyRMakG+5hrL/7l6yk6mxZVg+mFTbg03WOc80z8NMn?=
 =?us-ascii?Q?ejXXXoat0dY5s6ahrHYsKvZfqpOgIzRHwtyMwguD9bXJsSdOrkoynvoNh7G6?=
 =?us-ascii?Q?8OnOcYZS3fdEVzTyEbqw0kYIs510fpr1aTdSU3M3kqS94gCihCYS6DoPPG//?=
 =?us-ascii?Q?RXEH+MPZMmXRFhBChBbSLuQ3I/3H/daW6cPKTqX3GgFe6iHxbDKmNOTbkFj3?=
 =?us-ascii?Q?gRheIJx/AaEq325EmXxoMqmrYsPakZm81+4MgYqrLT7sXEYiyIHdbfd2r/ct?=
 =?us-ascii?Q?R3HzpydwMaslWk13fuWt5aQd0OlusGjbhq2ZIcA7uDqSTTX/5U90uk0zlXI0?=
 =?us-ascii?Q?gLVdw5KFKuWic79dhPeDVi/wsyX+V+0zcuWunfz5zIksJhn5zOYONjiC/WCy?=
 =?us-ascii?Q?xs6JTDMvXTwiBdDW0VS1rU1hFNXac+c/CIv7KmpskN60qp4hz5ibJbej4Wl2?=
 =?us-ascii?Q?d6tyardUrGB93Hhh94OstsWSlXtz0FIOhlAndbl0JGnLjZ/lS+pqjSRW44/n?=
 =?us-ascii?Q?3aAw5SHFK8us2V84N8/8NNtrPCat0tUAbEALNvvbZTNPC0IluKj2kUUs0B8Q?=
 =?us-ascii?Q?5iZesbrx69BqoqcH14lBukLEdL8rW+RsE+8htwQxG0lne/Uy2US/C5wtd89z?=
 =?us-ascii?Q?GpQ+oWNUCbjrWk+hJTRU7XhYKdHmbCVk3wVb/rUS0PscklfeqcIeNuUn4pLo?=
 =?us-ascii?Q?vXzt493DLIXDm8Y3IHta?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJKQGw9Wz3YXhCLCAv2+OlJCX23tb4lvJfFeTgfMdgEYWFTnNr1R9jaaOZtN?=
 =?us-ascii?Q?sTKv9sbYukrX8qzgQTwv68JPRla9RQ/1Xg1UrWtv3G4SUxqF3G45JX5ACvdT?=
 =?us-ascii?Q?1vlT4dE+o5VZ3DQhdk4qCjLAnFBlRm1NrvWAroVDndCMGSs7fM684aQ5nVGY?=
 =?us-ascii?Q?tZURSjltHaxTLvGf8G9btGU+PGSYE6louPVypqbtp4O+GqFp+4U2opoClzgm?=
 =?us-ascii?Q?6XE349ZEwCft34AjxQ6z1N43HO3CF7YyirglEFd0/tE559cBTXs6AsgEnRJl?=
 =?us-ascii?Q?HSVfTJGkwjaCtBuu98lj3+DnDkdV8QYQMCNf7CwMzdq4iIWGhbe5h13Nsz6o?=
 =?us-ascii?Q?MEU5KH+VRkw824+xgb0Dml/WkphajovH0aAej4nDUQtpWN5XyepP/ZumdXTl?=
 =?us-ascii?Q?MHrsjH7L/xAPHlvZ3QT3xVnlwrv9mOtUgJ5VOOJabpjhdWnwYSokDAVZo+cy?=
 =?us-ascii?Q?rqKAHnStQ9+2X0F5vcWjYjAEnN7bKeMrG9crHl/E3CLr+Pnm1jDsI64/aRhV?=
 =?us-ascii?Q?ZKOpUMJBU4GakICIao/RiADNB0Ub5OpK2k21WFfrGkIvWNsClGCPh/m6LsLa?=
 =?us-ascii?Q?E+H/8z4yOk8unBPVKhcLqtjOg04cBwFvU3NwUrcptKT32OVrnWGsSor2tOFI?=
 =?us-ascii?Q?syKoeQlTerATvSw4PNJLt0neUoZmwhkjpIUxSPJYq9vaW2eSyhE0LHm9T7Jc?=
 =?us-ascii?Q?ZYGw1gw2Q48mAwztfZ4KbMBzQzDiTwGQi8SBn0LXlxaheR9P6N36eWbGPUlh?=
 =?us-ascii?Q?LFGN+4l2Q/5q7iPU2gbPNJgEw+aZ51rWypo06u0TUx3OgzzjlKrKDvRB8DbO?=
 =?us-ascii?Q?MBPyfZ45iUAXR5u6WRHkJZoW47/Ktdr6nIlKzsgxlNvs0yjnkUIDP+A7AReU?=
 =?us-ascii?Q?s20AyVNOii5FTUe+eUXps/RNRQhhMcipiiWPtEQeRTvOI/TDFVreeX/EI2TY?=
 =?us-ascii?Q?tt7VovDBJwvzCNHhbTRjS1SjHGhxYwKA8adByPBDrZz6nKBVXJQ8mZ90AtYh?=
 =?us-ascii?Q?vh5M8Dj3VkuW0h6lLFAKOWqaT05nsANtExzomP+Cd0Nba5INnCKSOk7qpH84?=
 =?us-ascii?Q?FmuD0rL4aNRYyIRzyv9e7llVqmTZtoHa+M/oHZvqFJPyZKQeY6gvWQSDP9Po?=
 =?us-ascii?Q?vvt32+cocvxcFxw42qqQF98oqNTbkm2ZhbYOhO8r2l3dCAZEC38Z8Chg9SB9?=
 =?us-ascii?Q?dJUucxr64E5aU7BFfH5X2HeAo5Gyo5YvzUtqWAczSi/roZPuFdl3ab7iopaG?=
 =?us-ascii?Q?4KnW6Fg9rVDdfxD+dwFMIqcXdWUX9ykdRfnMC8ClzyTWrHgVuueKUGDqfRVV?=
 =?us-ascii?Q?8b3TljFxOADYCFnyOHoZzUZQuU2XSYMnDm50K+gfSxIEnUXeBxsfX7zvPBUq?=
 =?us-ascii?Q?47bxtD6RW4zJOsVOyoIa6e7lIWWQhfASpwmks6N8OpN1kXrr0iwy5r0iy1w2?=
 =?us-ascii?Q?2gkqwakzgNg+9z/WBfpkbhfvdLKSWphpV/J2G5OlWoCboiAEbTzokL0B7rVu?=
 =?us-ascii?Q?97irCQW5u9tyCCNv1HK+IoIqOJUFn5eZaiSXLVo1sonfo8ikUo5KerOweItC?=
 =?us-ascii?Q?zLd2AGKKunvGfqS+1ohznNh1O1nnRZJ//gfLZeyBBtYAMJ8RlWAUSQnM7oQN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a122420-f2e3-4ac1-c811-08dd004d3571
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 23:29:36.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l++m/pRFYbS5Uzgu5Y0+oy3O1JW5yn5G6bB32DaNwfcXe5HA7PwUFJg93j8NxMXXkKIyFKVs0UgFMvnrRQIjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8418
X-OriginatorOrg: intel.com

On Fri, Nov 08, 2024 at 01:42:18PM -0600, Lucas De Marchi wrote:
> On Tue, Nov 05, 2024 at 11:26:50AM -0800, Matthew Brost wrote:
> > On Tue, Nov 05, 2024 at 01:18:27PM -0600, Lucas De Marchi wrote:
> > > On Tue, Nov 05, 2024 at 10:12:24AM -0800, Matthew Brost wrote:
> > > > On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
> > > > > On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
> > > > > > On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
> > > > > > > On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
> > > > > > > > The GGTT looks to be stored inside stolen memory on igpu which is not
> > > > > > > > treated as normal RAM.  The core kernel skips this memory range when
> > > > > > > > creating the hibernation image, therefore when coming back from
> > > > > > >
> > > > > > > can you add the log for e820 mapping to confirm?
> > > > > > >
> > > > > > > > hibernation the GGTT programming is lost. This seems to cause issues
> > > > > > > > with broken resume where GuC FW fails to load:
> > > > > > > >
> > > > > > > > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> > > > > > > > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > > > > > > [drm] *ERROR* GT0: firmware signature verification failed
> > > > > > > > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> > > > > > >
> > > > > > > it seems the message above is cut short. Just above these lines don't
> > > > > > > you have a log with __xe_guc_upload? Which means: we actually upload the
> > > > > > > firmware again to stolen and it doesn't matter that we lost it when
> > > > > > > hibernating.
> > > > > > >
> > > > > >
> > > > > > The image is always uploaded. The upload logic uses a GGTT address to
> > > > > > find firmware image in SRAM...
> > > > > >
> > > > > > See snippet from uc_fw_xfer:
> > > > > >
> > > > > > 821         /* Set the source address for the uCode */
> > > > > > 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
> > > > > > 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
> > > > > > 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
> > > > > > 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
> > > > > >
> > > > > > If the GGTT mappings are in stolen and not restored we will not be
> > > > > > uploading the correct data for the image.
> > > > > >
> > > > > > See the gitlab issue, this has been confirmed to fix a real problem from
> > > > > > a customer.
> > > > >
> > > > > I don't doubt it fixes it, but the justification here is not making much
> > > > > sense.  AFAICS it doesn't really correspond to what the patch is doing.
> > > > >
> > > > > >
> > > > > > Matt
> > > > > >
> > > > > > > It'd be good to know the size of the rsa key in the failing scenarios.
> > > > > > >
> > > > > > > Also it seems this is also reproduced in DG2 and I wonder if it's the
> > > > > > > same issue or something different:
> > > > > > >
> > > > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
> > > > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
> > > > > > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
> > > > > > > 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
> > > > > > > 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > > > > > > 	[drm] *ERROR* GT0: firmware signature verification failed
> > > > > > >
> > > > > > > Cc Ulisses.
> > > > > > >
> > > > > > > >
> > > > > > > > Current GGTT users are kernel internal and tracked as pinned, so it
> > > > > > > > should be possible to hook into the existing save/restore logic that we
> > > > > > > > use for dgpu, where the actual evict is skipped but on restore we
> > > > > > > > importantly restore the GGTT programming.  This has been confirmed to
> > > > > > > > fix hibernation on at least ADL and MTL, though likely all igpu
> > > > > > > > platforms are affected.
> > > > > > > >
> > > > > > > > This also means we have a hole in our testing, where the existing s4
> > > > > > > > tests only really test the driver hooks, and don't go as far as actually
> > > > > > > > rebooting and restoring from the hibernation image and in turn powering
> > > > > > > > down RAM (and therefore losing the contents of stolen).
> > > > > > >
> > > > > > > yeah, the problem is that enabling it to go through the entire sequence
> > > > > > > we reproduce all kind of issues in other parts of the kernel and userspace
> > > > > > > env leading to flaky tests that are usually red in CI. The most annoying
> > > > > > > one is the network not coming back so we mark the test as failure
> > > > > > > (actually abort. since we stop running everything).
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > v2 (Brost)
> > > > > > > > - Remove extra newline and drop unnecessary parentheses.
> > > > > > > >
> > > > > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > > > > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> > > > > > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > > > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > ---
> > > > > > > > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
> > > > > > > > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
> > > > > > > > 2 files changed, 16 insertions(+), 27 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > index 8286cbc23721..549866da5cd1 100644
> > > > > > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > > > > > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
> > > > > > > > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
> > > > > > > > 		return -EINVAL;
> > > > > > > >
> > > > > > > > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> > > > > > > > +	if (WARN_ON(xe_bo_is_vram(bo)))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
> > > > > > > > 		return -EINVAL;
> > > > > > > >
> > > > > > > > 	if (!mem_type_is_vram(place->mem_type))
> > > > > > > > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
> > > > > > > >
> > > > > > > > int xe_bo_pin(struct xe_bo *bo)
> > > > > > > > {
> > > > > > > > +	struct ttm_place *place = &bo->placements[0];
> > > > > > > > 	struct xe_device *xe = xe_bo_device(bo);
> > > > > > > > 	int err;
> > > > > > > >
> > > > > > > > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > > > > > 	 */
> > > > > > > > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > > > > > > > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > > > > > > > -		struct ttm_place *place = &(bo->placements[0]);
> > > > > > > > -
> > > > > > > > 		if (mem_type_is_vram(place->mem_type)) {
> > > > > > > > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
> > > > > > > >
> > > > > > > > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
> > > > > > > > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
> > > > > > > > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
> > > > > > > > 		}
> > > > > > > > +	}
> > > > > > > >
> > > > > > > > -		if (mem_type_is_vram(place->mem_type) ||
> > > > > > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > > > > > > > -			spin_lock(&xe->pinned.lock);
> > > > > > > > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > > > > > > > -			spin_unlock(&xe->pinned.lock);
> > > > > > > > -		}
> > > > > > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> > > > >
> > > > >
> > > > > again... why do you say we are restoring the GGTT itself? this seems
> > > > > rather to allow pinning and then restoring anything that has
> > > > > the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
> > > > >
> > > >
> > > > I think what you are sayings is right - the patch restores every BOs
> > > > GGTT mappings rather than restoring the entire contents of the GGTT.
> > > >
> > > > This might be a larger problem then as I think the scratch GGTT entries
> > > > will not be restored - this is problem for both igpu and dgfx devices.
> > > >
> > > > This patch should help but is not complete.
> > > >
> > > > I think we need a follow up to either...
> > > >
> > > > 1. Setup all scratch pages in the GGTT prior to calling
> > > > xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.
> > > 
> > > yes, but for BOs already in system memory we don't need this flow - we
> > > only need them to be mapped again.
> > > 
> > 
> > Right. xe_bo_restore_pinned short circuits on a BO not being in VRAM. We could
> > move that check out into xe_bo_restore_kernel though to avoid grabbing a system
> 
> Ok. Let's get this in then. I was worried we'd copy the BOs elsewhere
> and then restore and remap them. Now I see this short-circuit you
> talked about.
> 
> I still think it would be more desirable to actually save/restore the
> page in question rather than go through this route that generates it
> back by remapping the BOs.
> 
> Anyway, it fixes the bug and uses infra that was already there for
> discrete.
> 

Agree. May take stab at completely fixing our BO backup / restore to
be not actually BO based at all...

Rather...

Backend entire GGTT in shim.
Backend user VRAM in shim via GPU 
Backend kernel VRAM in shim via GPU.

Restore GGTT via shim + memcpy.
Restore kernel VRAM via shim + memcpy.
Restore user VRAM via shim via GPU.

I think this would be safer and make Thomas happy to not abuse TTM /
take dma-resv locks in our suspend / resume code.

Anyways I pushed this one to drm-xe-next in hopes getting this in 6.12.

Matt

> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> thanks
> Lucas De Marchi
> 
> > BOs dma-resv lock though. In either VRAM or system case xe_ggtt_map_bo is
> > called.
> > 
> > Matt
> > 
> > > >
> > > > 2. Drop restoring of individual BOs GGTTs entirely and save / restore
> > > > the GGTTs contents.
> > > 
> > > ... if we don't risk adding entries to discarded BOs. As long as the
> > > save happens after invalidating the entries, I think it could work.
> > > 
> > > >
> > > > Does this make sense?
> > > 
> > > yep, thanks.
> > > 
> > > Lucas De Marchi

