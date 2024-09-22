Return-Path: <stable+bounces-76859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDBF97DFDE
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 04:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647C01F2142E
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2613D893;
	Sun, 22 Sep 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhIUDuZf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68C11712;
	Sun, 22 Sep 2024 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726973252; cv=fail; b=LJP95ged2zaGSQA7RNgB07Yc/nHFm4U2ee+zBDbupmgcpgREqxKk1/zkPS+6DyjktISjaOlBKh8yp/giUu54NnAIVtZLa+XW910/PTHXXWxMYhesakpEccPREhcVX1icZCa7XZTqDPfVBq8+7CToT1U2MFlWD6FFQGO6gR+q6Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726973252; c=relaxed/simple;
	bh=gD/C6mU8TKyXN46DBYE2omlwf0CzMahIe7/iAVSKbFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ulFRMNd4ncqQ7+z1yae9C+aHA7MumTSlFGql9CI3N/2XkgV4tkRrGL87rAhIGqbUOyvhucU2BC/HQIzsSJ+qJtVu5av+MQ3JKtGTFsal2d0Kx8OHM7G0TBpZv1eTTWk7qWTAQQyMKJa67LfZfwgjV1Gz8gpVYUJYoI/5ujKqwTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhIUDuZf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726973251; x=1758509251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gD/C6mU8TKyXN46DBYE2omlwf0CzMahIe7/iAVSKbFg=;
  b=dhIUDuZfAezLb+ZItciHb3DeXkU0TtVExzrb8J4ldixz0ybVUS0GU5F2
   iPw1Ki1wJFLVh8vijYkRS/931lxekMuxP2wEwb4Ee6Mi2qV3HuGyMqHbw
   kQPgDycY4Tgb1cLT3TgDax3GXMlqhbFOlzmo4Z74JiYjaqKZxKwUh776f
   QTE+hm5eREMk+gLYzQ5sGxrYVqrqBa0k4jhyvC+K4lTqF7MohPEMVK2o2
   oXrgHD0LqOVzOsauPNVZWm+MjvpAVA6L1DNt6ae1iG4KnKRsJKV0Benj3
   PgMbSxDPn9RygOgXXgv1hZdMSVM7oXLzGr+PKDxBZXIUHppnYlhOLzkIq
   Q==;
X-CSE-ConnectionGUID: g8Ri1k70T6WcRbbOV7ZcVg==
X-CSE-MsgGUID: 0rDjDAKgSQmOzQRoWaFNlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43414681"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="43414681"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 19:47:31 -0700
X-CSE-ConnectionGUID: dRLEfbkFTzuVBwgAspFAaQ==
X-CSE-MsgGUID: bgVIWIgZQ7i1ukx6KuYHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="71012670"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 19:47:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 19:47:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 19:47:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 19:47:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 19:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snj/nzHPxySXVE163ZtieizYB0lsILXjSIhT4XNbzKwp4U0cp1hVzEJNUkRS0j8CzIG+QPpcCLQRVrsqM5oq62P2/MmjAycFp9hKBfBIURQ4PvD5cILPvvoqd+ayckzuj7cg93Ir7ooTlJgYAOZg1Llas/OdYc/JTTZKSn82w9L1TcHBK+1MTm5svZ52pg3soC4voJq4oZcCsMVcrmQnllFM+lcagcHT9/2V7zwHMH7ziNCc2e7+6oH55pI0bDgJzYOkAFrsMsvVhIPUYOlkgdH2RJWTwwtNaYNzFvKQDiAAeiFBULksyGEIn1zJM8YOS0Cj6Mtwr2RQR4TjR19WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khzaAhk3/ez0/+wtdqlbDoZEpXQMAWJLRmnYbdzcfo4=;
 b=gwo9m6Phe6UK0+Q59cbuavVxINJPFQwzcflbHVtPO5do5QAzAp3Pou88wgmetjqYaYKh1xmhVV0OyM8Yic6H79z1MyhGI/jrByP3Sy6KYmjEfTj2hnf/eDMj3J3iUR8Lo90G3fYuzVZySYYtblIYG9huOwf1yCCe+mq+auVyyukRSf/FfkTC5RcCrSjFwyODImnMT2CCMImKcdtI5EvU7Sf5V7YUZ1u8QRrs0sQ4k0AzSFWF072NLduhkQmuirVDI5sxdCQz1UCClDKdyjdYmvmU8js4c9ulSAIf8LCOquw6HdKntAfhUFDdnGx+Y6nFmVVzp6TqjPIi21MAWJSGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 02:47:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sun, 22 Sep 2024
 02:47:28 +0000
Date: Sun, 22 Sep 2024 04:47:25 +0200
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Linux regressions
 mailing list" <regressions@lists.linux.dev>
CC: Dan Williams <dan.j.williams@intel.com>, LKML
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [regression] frozen usb mouse pointer at boot
Message-ID: <66ef853de5f16_10a0a2946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <3724e8e8-ab71-4f64-8ba1-c5c9a617632f@leemhuis.info>
 <2024091128-imperial-purchase-f5e7@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024091128-imperial-purchase-f5e7@gregkh>
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cc005a-6ab3-4d01-df2f-08dcdab0e57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBJMy9PRpGEVxDJ2wBRvbOyYo1KwM+Z7/XL19lnzdbSD9k6yzSzW54yI8WfP?=
 =?us-ascii?Q?s4sDGoOjhpYGnl7MSt2Kc2OgEnvQg+tRrnUTHFixe06McobXjyb5PKLb/URN?=
 =?us-ascii?Q?0qn6DVRk7Xq7rzlZ4WsaAVus+28PMssIU17W/ZXdesFjWY/G+XS+Qxk6URTx?=
 =?us-ascii?Q?Tksc4oR23IE1c9cbbQynzcexlK23GOA0ieIJdBwoZmeCrxvk7eTR9xB4r7zS?=
 =?us-ascii?Q?J759dPiwrgFJJVG0/WkclqZ5l8wxRRWxtkwwDBd7OeyrjcMkVEpkCYWo13Yw?=
 =?us-ascii?Q?bU69qw+g9TOSEDiD8PJAiAk41Ev0k2G6QVemaCuPn1Lml0L5cvOwjwISSVDX?=
 =?us-ascii?Q?6Ew2C6UKsOq+2ad3H+z4ofEFiHqmaftW8WBIF1gmntaCIAEvl6o2Fr6n5hzQ?=
 =?us-ascii?Q?o3NRi+lVmImVE/1XZNnl0D/CrQGMFDwB6VHb1mn8vkS3Ty0iRQxyQKtH2oS7?=
 =?us-ascii?Q?/6S/8cpyzzE+Wq03/kuObadV/A41h4zq02p+pHX5r1ysTkvyjslv4zHtC0Uq?=
 =?us-ascii?Q?07IqonmWp0BOwS4Ka+W3SWkzXel7cuKjlPrVPRF4jnbA7iw9ftO5OhL420GI?=
 =?us-ascii?Q?aNgD/fC4FwiCd2qlofhALElyCj6wSg8vgrA2ROdZxNNeg9Xolr42ABvxSKbB?=
 =?us-ascii?Q?xvgcjX2NOHrHMJu3IyIWP11gjF8S/BkTt6wvVlcwyOqzbEw/yY4CZUCgyPW/?=
 =?us-ascii?Q?+WaI8PoFbRoBQycMw64MslrdlFBi/Ujw4TaSqXLccazkVpq5pMbp4ReOGU6v?=
 =?us-ascii?Q?vZF1vpOJxXte8VwDFvrgsXcnwkzwCne976SgHZ/g3SZivj4aOgKWqnnaog63?=
 =?us-ascii?Q?JQhnFDuyTMpLkJVsaIjruFSuvx7YKLuzHSyLs8mj28I/D2lfzEL2rgOUFItp?=
 =?us-ascii?Q?0YYRtI2oeXbK6zmbcwsHz4FWVTY0iP3kBCicl4z3ncpEtxR0bo8QZfnfUxQD?=
 =?us-ascii?Q?pbMPEM6VJieWXUBnXINvA3I8QDAHUzZylEmFYNzwiPnVooHWw2PcCvxyizIr?=
 =?us-ascii?Q?VAugJDCkOiWg9Ht/xkI2xWLa+ExWk+k2E5WXhONNGBAErFBqrZXMZH0373Ym?=
 =?us-ascii?Q?TXZ/FxYCMwfN6lm19Eni3zW16cWUo7ZyB8lM8pALJFLwe2EXvImq7E+zSGMT?=
 =?us-ascii?Q?MNvILe7P8jTVPwZsoLejYr/kdISv5Ewu+dUqKczUb5YOHcvuEZJi8XwC3Odi?=
 =?us-ascii?Q?BXA89ww2/apF/wuiWUevQWurTM1N/2w881r6eBpA5GlD6XatZ/cGNY+oWN1t?=
 =?us-ascii?Q?kjdv8+hTMm9y8v65p7azKEvnTZytIfz0uKCjo7A4FQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JkhsSklEl14EXy8Q7BG4ducYsMCW4QhHBg8odgfsH8greMGq/v6J5SwnOKe?=
 =?us-ascii?Q?X2Y6awcE0GIMX2EJRoCOqRKOdqQWEtewwGZhqyw2Yb+g+EQ205CXDyPU+not?=
 =?us-ascii?Q?cLn4kcGstdwDWHVArfmdU3cCNSAcvNfdSPV9zlp1V4hm2sgCf8GceLd19ruJ?=
 =?us-ascii?Q?mmX6wLUTNnjliEENNeZREbxYlKqBZqKvkCL4SijuEfWPZESNvYlQBLo7VKZH?=
 =?us-ascii?Q?iAZgiKawG0JEa629allyk11jvjLj08bgOqSRVY0uQeiL3i5BWbzlKC2vY88i?=
 =?us-ascii?Q?B/0IErmJeDLiX/CEbjmcwnt6jsR0RzcPIseSsXZtK+Oh2eudiDNj2ryLEMmO?=
 =?us-ascii?Q?qMGThhi94qwEjdp0KNHACBjZdu+tpjaN4mP1NkgGdDDq6+10f2LqLSrKHzsj?=
 =?us-ascii?Q?DvNn50EoX7A86voDl7L2zLkGU5eZmIH/obSN4Xqhgq5KyuFoQ65vt4crJ4M0?=
 =?us-ascii?Q?ZLmAWMKXRT7vZiSB+UsednpevB9mO3xFVoqavjoIAj8qJT7NuSnyUBsYl0Tp?=
 =?us-ascii?Q?6j1pgo40ZX2YYzOeFTkrc/WAa0NN62eOr5HqE3ixQiGTkhW27lLegWPzR7/u?=
 =?us-ascii?Q?9pAQiNzziV0i8FRNhZZn8AWQS169WkN7lf8tTj5KFn5kxTpm7kb9vEUy/g/d?=
 =?us-ascii?Q?K/Yp1PbGzV7baMptCtWo0U8pDBPtSHe1jTsNIeGQoB4yJ4xkbxs5pi6GFym3?=
 =?us-ascii?Q?PDAxmligLDb/QD7w/4CGkhTqpfPBexmpBIxZeCbLBZaRPNhkgr4GyL+IBPJY?=
 =?us-ascii?Q?xmIoNbh4nasPtc6STaBoQvYOKEmllTuaw0BARq2yp8qBecfMcfdRZhFChfHo?=
 =?us-ascii?Q?PV5HHSeG52VGFavHyu00hhuP1PjjpYzh9ciDo/mfOyrU1zgNkjCNZ8/TlIal?=
 =?us-ascii?Q?+diS9sNPbVJvAhWebeMUtLdwQ2xOoZVeTXv0dfOR4PBqVBMQuWejeHAnD6WT?=
 =?us-ascii?Q?FxH9Z63ULIEUjXf2vOxSoW43OuIQ+lO11we6mtgOpt1QlHVKRBt1NGM5duw5?=
 =?us-ascii?Q?sdf/uTPILj1DELmS2lVBI6vhNG6PCIcY0QBnfH1j4d0EfNtT9kTCWKb3zCuU?=
 =?us-ascii?Q?0J0nw9HKIOrmEc8UbrtYDmziQg/PT4HOs8lstDTDaZI8Ss4cxtiiMTK+wce5?=
 =?us-ascii?Q?w32Thh2hlF7a3hE5Y15nQsm4LwMy8LdR7VTsLDYUE8zeZvbUrKyUpPIy+IfD?=
 =?us-ascii?Q?ZWYezJGKIFqjwJ55ZYIUwuS01AYFWXXs6MEuO9c6Jd62aDmOumrQFaHzg567?=
 =?us-ascii?Q?akKR8xAdv6lazc4STDDe6Y2TqZBjkas4+bzKscAqeONJ9S6nIwm/5+ZfnNCQ?=
 =?us-ascii?Q?0LRAokcB2zulUxG/4pG0M33HJdDuxAlEyC7w+OQe+xLk5pk2RUvRa0sMdB1V?=
 =?us-ascii?Q?KimheG+w5zJWq12RvaC86SvxDG6xaIDyn/tUiTvS0wPCMS4iQjgp6uBuTmPD?=
 =?us-ascii?Q?mUDKnlYL1ptUav9psqWAV8CWM5saR5C4r2tpUub+77iuq0DVmG7VFF+oREf+?=
 =?us-ascii?Q?jxyr4g/fX7ripAqWXERM+yM4hMZbOaGEk47cWbH3liD3xooOm0nL0M1k51I/?=
 =?us-ascii?Q?rbutb8sSzmuf+7lRWVoThn84NPN9STUCcT9fAzyp7yqjtq/XEHZbFjiZ2XtD?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cc005a-6ab3-4d01-df2f-08dcdab0e57d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 02:47:28.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S98pcl7jZCbI0NBvkhtSKijvjNtWhzL16kf2MirksXIfUFB3CH3bK8C8x1hHVqFY7CmwZMgq0bh1qnMwvJXSEeQvKj0GfBxbKvcRITEp7Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
[..]
> 
> This is odd.
> 
> Does the latest 6.10.y release also show this problem?
> 
> I can't duplicate this here, and it's the first I've heard of it (given
> that USB mice are pretty popular, I would suspect others would have hit
> it as well...)

Sorry for missing this earlier. One thought is that userspace has a
dependency on uevent_show() flushing device probing. In other words the
side effect of taking the device_lock() in uevent_show() is that udev
might enjoy some occasions where the reading the uevent flushes probing
before the udev rule runs. With this change, uevent_show() no longer
waits for any inflight probes to complete.

One idea to fix this problem is to create a special case sysfs attribute
type that takes the device_lock() before kernfs_get_active() to avoid
the deadlock on attribute teardown.

I'll take a look. Thanks for forwarding the report Thorsten!

