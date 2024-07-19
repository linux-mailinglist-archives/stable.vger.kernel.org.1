Return-Path: <stable+bounces-60622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE7937BBA
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8398CB21A6B
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E2146A85;
	Fri, 19 Jul 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaGVYuwN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C77146A73
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410831; cv=fail; b=AC4AoiH0slGXlVfJRiIFGUm573G7LieO/37YsYzks4cpEFCiR17f71hbwV4ZIwqg6cZMMcG+OICVCZcfOhgRnYoiTQz6hLAkW5u2tmLA5Ha0fq8BvUMs0IaRSfJUnxHKRsELQoZKVtKLR600akalwysfV0ES3mDzrxuO2gKoEdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410831; c=relaxed/simple;
	bh=/5hUY9SZkGke1I/FtIcaiLHnwqM9CgfVuxcCfz6kjVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0vLT/IALosM5FLMBxTEMYPc9q1SMPOdEf51RTj+wNVivBtdrcbX+I1Q8FxwlHVT8bV2GQCTO5VX8GIUHD2ji2/3D47ReLN1mL3Ymwzup5GyveRQ2b6zsLnbMeQ6eobc/mnI406IaxWHXqPYOugUYUCd3IomnmzvGo7b8OGhASA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaGVYuwN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721410828; x=1752946828;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/5hUY9SZkGke1I/FtIcaiLHnwqM9CgfVuxcCfz6kjVk=;
  b=NaGVYuwNeUB2U+XYkwW6MNVRGziqYMWLDzllq1y4BrSxGpjn8okd4HmO
   XhjVIYknTr5RoeJymV+NAKpo4kmjAPpku75hWb5VnBRJPi0PiV7illgxk
   8mDSlCY/tuKMxWMEmOzu9gnF2egF1Yrdgv6fyNoil7eXfnb2UtF9dTpRv
   DQQFgSWe2BIM12SbRkYKc07LHrtzdwNOwaJVf8nlmh5xUN7eR9ltyPYmB
   AlGzrf6ZqB+jAUyT+gOuOjOwFPKTJnrSGadQ22mHH6CPFu/mcIq66pZ1w
   ZjkslVLR2aD97wvUr1NOgo7FMbUl9LZo5gHBOLysKPyNhFu/cbyJ2y0Sn
   A==;
X-CSE-ConnectionGUID: zbi3yPPmRCm2NLrmZlxRVA==
X-CSE-MsgGUID: tIG5oxitS1OQeigj35Ykqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="44464130"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="44464130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 10:40:26 -0700
X-CSE-ConnectionGUID: Dx8MnvMQQ0Ois2OQDvtTww==
X-CSE-MsgGUID: 1oBdjmRPTrCQIttQlwLntA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="51216966"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 10:40:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 10:40:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 10:40:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 10:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=busAJm/m7LQoi5pikVfJLxOkI/O3yzFLtGAU/g33GLdj523Cs1kM1KkF8Hjs2gDUA6NctTroVhIUz+SYM6lOkIwA7geY6MMAJ9vc53TjLEeJxz6h82MSP4mk3zfeQWP6obU7pdSIFYP4+AIFjp5TzTS+0fcDnFFt6bNfW5BSqqAuJ/cGhzpgm/zx/M2c1MknQ5Satr0mPaEtGpTT0TY5kMGd67sQVw+V55XOw62YQk88wePOT52zIKEPXR4CkrDlQngCzOKPTr+GCGxvadDum7O9fVBVEOs5r/9XPF6WKgo6mKwojta039dnwdJ93/ziL/BNIlPXuq6AeKWl8YehYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaW8Y211baSW/8sRd/UBwvh1S2xHbeBqCEsWeFIVfUk=;
 b=j/0psTGk+163Vvm815oViRJ5Bd0MANGuE5uXe9BIV/srVw2Hfj6IePnrUBSqXGezy9DU3ZWjGq4fNPMnjnNXNVgPQbjSJY0zqdApnxEOH4BrZjkZha/hcggnX1N5gzqmBUv7xVyP/ZbamIMknsJhZY5oEbRTn45LeFhVitoKbA7nN4+090QCnvaijK4nGRpHkBYZYoQpkbEXUNX3f7e/w9UOOmQlQqo6KZQGATgVHfJwyzk/Wz6OAGBWvydZJZv1PXaT2pdHjBzHcbdfmEiciIzl/7I08pyjjiwooYOrBBclSjRg0rfmboXBSteI7jugJxTy+xFKfHW/7e/emGi5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 17:40:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.7762.032; Fri, 19 Jul 2024
 17:40:16 +0000
Date: Fri, 19 Jul 2024 17:39:29 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Tvrtko Ursulin <tursulin@igalia.com>, <dri-devel@lists.freedesktop.org>,
	<kernel-dev@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/scheduler: Fix drm_sched_entity_set_priority()
Message-ID: <Zpqk0c9Z0uMj9YOa@DUT025-TGLU.fm.intel.com>
References: <20240719094730.55301-1-tursulin@igalia.com>
 <61bd1b84-a7f3-46fd-8511-27e306806c8d@gmail.com>
 <bd1f203f-d8c4-4c93-8074-79c3df4fe159@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1f203f-d8c4-4c93-8074-79c3df4fe159@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5cc52f-b6e5-49ca-d995-08dca819da33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eJzY9X8FKanP+AHIc0mH/ShKlKMsI4CrkMcIEWRA/YCj0vnQiik2lMZTpl?=
 =?iso-8859-1?Q?soLT4CH0KUrYOuQ9+eS0Z6clxgL50e750FOr2jiM9U9T0rptVXHx6lzWQi?=
 =?iso-8859-1?Q?wI2Or0I01bUNe+MfRQ5Hk6u7auRiXudG7bOlSOdEfq8oSPUeI55YLzZhB9?=
 =?iso-8859-1?Q?nYGOzGLxp4hrhQvUNyhDa1ZnbyanoQKx/9A9+V7zypfDtMfGrPuhDtPzfV?=
 =?iso-8859-1?Q?KquVbDoXmHcTW/02gt8JniBdh0vFEXXBxpgoV02m0H8kIO5qCfZTH7soU2?=
 =?iso-8859-1?Q?tpy1Qut/1XKndwQQbNi9RSHKaCpz+hqFRd+S5R3/3DRlF6pIf9QTxJObsy?=
 =?iso-8859-1?Q?Ry6y9AXuxMgCBMf27eT1Ky55v2lYpPd2wbx9QSbaj+6kc78nbU58rOEJyr?=
 =?iso-8859-1?Q?vOVyDZ05+ah6spVMke8heOTwZxxBinUXEswx1BuA4/ro+caD8yKMMPXOqg?=
 =?iso-8859-1?Q?LGupKRw7ije5Oqjr3AenabcNv//cz0fDu4LnPWIwfU69pCzxorisLP9YL0?=
 =?iso-8859-1?Q?mI8l5Ge5TIwteSXgQjnW9CvM31FV4ZfKe3neMTK6nhhjpDOIE3lQyVAjgC?=
 =?iso-8859-1?Q?NwD/TTpO9xxnJjbZtzWwIO/E6OtrK/9iRkYfYFDH7bsHobKpTGBYKX5gn/?=
 =?iso-8859-1?Q?C5JSgvu+/BiCKPPlOBsdhBBgzXOR77tOWViNlbVIFJAprOpYb65PU5gLhi?=
 =?iso-8859-1?Q?IDVbOKny1rPbAsi4ssLR/6vCsDL0qo3P/b9Vs2l00pD0XFVt51aR97Tays?=
 =?iso-8859-1?Q?MgZmoPABeTxEb20NlmB2ksxb4OsTaeOCPem69Hqk7XF6OHAoVTJzkVZMfD?=
 =?iso-8859-1?Q?D1xbdzVIxC1NeeyoWJeDGJ7CMxD6CHNDtLmdravt3LRjvbVZNy24yy2+E7?=
 =?iso-8859-1?Q?WHBxONeYC9qnh6WRhpSfDvv1/Dc2SwLYlF9jic/zZW2BJ3UVDAtOXkqO62?=
 =?iso-8859-1?Q?x9yI48Sdo1o29ZkzdOifON+F+OKmd9lgrsWzrBp5pD6ef9jR3tiM4McPgx?=
 =?iso-8859-1?Q?UMqk0KC1RY1+Ktaxg+olRot5luCD/HjMIyrm4+gJ9cIdQxEtg0fpAIu/qg?=
 =?iso-8859-1?Q?02O7YbfjPoRYnKVpai/mh8ZRm+09xWkXPDgs3RataiSZzVFjcgjM8vtCkq?=
 =?iso-8859-1?Q?ssathhbsU5hY4BMgjczygs2N8zhuUd9Q2SC8/CfgAmNGq2EJYBP6DvZ+4m?=
 =?iso-8859-1?Q?hqZajFsSIGa50Lic2mqXJcih1JWWiYo4o9mDY8UsBHahlAv5ouvWyjyGih?=
 =?iso-8859-1?Q?1TncVQFBDDY8pY9y6HHRAs8aEaUHACOSWQ8alynv60fTeOyy3RKeBAQgP6?=
 =?iso-8859-1?Q?5tnylZfhGrceVy2MPNrrNJ8jrtkXBMDvDh2FUVNXZ1gmu+EpfzdyynjSL3?=
 =?iso-8859-1?Q?NRBazEnteYo1bWKDTXuuLTC7FeiHy7zQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bwukHVSLNfvu/Pfa4ViTC/EDhdlDfwmXD7baq+quwWylyBEoHYh/snDRrJ?=
 =?iso-8859-1?Q?W8azaUU37WOWFNkdW7CIya0OVtvyV8nPfyR1lYY03S20mTIQHgL3IgRdo6?=
 =?iso-8859-1?Q?35ckKZFDrjh11oBExbYLC/QBdJyUVTsqnfwG4PIykxhYmRWuJlhFvVM8Ss?=
 =?iso-8859-1?Q?vhj0dDRNI9Q0GFNdecqvNy9cmrzjwx8b5nns9/7pkfTvUhWtoPyBeUxwV5?=
 =?iso-8859-1?Q?T47gygU0SpEF/rxP11ztj/LptGg3BV441amBIPc44wyDcDa8+/8xCGtklA?=
 =?iso-8859-1?Q?tEbw6/Rx6DRAIXAfOiaGKcARlVlK9QZcL2/1GP18JQ2DiAKkrIo7Z+fPCK?=
 =?iso-8859-1?Q?3nEH8TwNysvFZRn/FMBL/vxMnMk34J0xQC02yROzaecVfK0tHc8P5Fa/tJ?=
 =?iso-8859-1?Q?XYYAUDhw69uNQNF7JdwckFKcV+oip/fR8aFZkXx7u/5ayeNuww6mduNI1b?=
 =?iso-8859-1?Q?2X05vq2FR9xnY2Zooss8Y0KGjVedVEe+WSsV5zUTy+E1pyB7SRIQmdZWsr?=
 =?iso-8859-1?Q?ry2Con/dxJwbeYtKUpZnXYpzOU124TAznZnYDMPQvV9hSFnO4cpMcxIqHh?=
 =?iso-8859-1?Q?YhFv7+3XM/MS3tB/xRcAaAneNJRlz0NHezBdLU0Mb0+2Z6PxEL9FqX3UQi?=
 =?iso-8859-1?Q?NPKWQ+Ypw3HzHpTo5GZWiUhyU3z9smMnFUKeYRZaMmEb/spJYCtG0ozveE?=
 =?iso-8859-1?Q?W8NKc7E1Whar/zBSu75fsuXOgXMvvIllG83sk3SDkrZRragP3Dm612KkLZ?=
 =?iso-8859-1?Q?3/i8/2lPkzGuZCFUHzEwYjzVS9QBz3B3+Ak8sMP3A84Ha9hubgRFm0vpPx?=
 =?iso-8859-1?Q?1WK2VK8ZBS7KL5axlOv8pSr4yj7Zxva4koQTKBgqkLciQWGgp11YkkIfVh?=
 =?iso-8859-1?Q?Hhn/qjFZJKghz0NZNNST/PLQDTSZUQhjNvbg/ZAPwjvOS3UyfJFuzGJ+vY?=
 =?iso-8859-1?Q?SOGAUZRprEIPKIaiGjIU1/aq4k7r+1XLKfiyWLu25wU4Dn0L7zPMZvT2fY?=
 =?iso-8859-1?Q?YzDT9C9EI0dOrx9Y040jAIkry8HP59IUdVw58oo9SRACe6KDln4560RrZN?=
 =?iso-8859-1?Q?DolWuBAceyNgzdimo+b6cpcBkBrFtr798qZ6KuXA2xUtwV4v7X5a8/ss8j?=
 =?iso-8859-1?Q?OcNiRwW4orYqtwhlG4EGMoDRMUwCMl5yHFXuqjCDFaUlH9j94puczfbDE3?=
 =?iso-8859-1?Q?7sNs2yrqsbUjD5uL31PsJUh3HIUhzRl40DVcO0LWaOEmH1qNf5vGkHM3Hl?=
 =?iso-8859-1?Q?zq7YKjDtkDfHKybbV12nDLgBcZMvjD2ahmj+UfrYCUjJtxtStfM/8Lcy2c?=
 =?iso-8859-1?Q?gyZ8UFjB9UYInRb54K3qwnzpN7l2aP5/x3vILIBExmbjli8MspezA27vuA?=
 =?iso-8859-1?Q?eFsA+eoPDE97yv6uN+FXISAl1bcofRxuWzznr7KSaSX/gDa9mHIyw7fAqW?=
 =?iso-8859-1?Q?wPYRpl9+I8nne8XYnSkuZwUTjeYkpldZc83AizcC+njMDMysl/sh/mkdi7?=
 =?iso-8859-1?Q?uUE+gx153xOS7bYpj64K7vMCQ8tbqXCdIEvBYRjiZtERktvcsu0tKO4HOs?=
 =?iso-8859-1?Q?FJglxx29rZnX6GycgkT66cg/Lk5aCgdLVts6N7Ts9yHqYld9UJAC+LyX56?=
 =?iso-8859-1?Q?nXiuEUg2P9my9347Vw4P3idNYKWUbqKWhN6FJtGWBhZYjAN4IvEGwHeQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5cc52f-b6e5-49ca-d995-08dca819da33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 17:40:16.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjlgMuHYPbHFkztTqNDtNIQElShSUkn79Wv2HC1fC6j8OVar69q5sMZkEtVJZErAqNgglncx2xq5nEeP0WBSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 05:18:05PM +0200, Christian König wrote:
> Am 19.07.24 um 15:02 schrieb Christian König:
> > Am 19.07.24 um 11:47 schrieb Tvrtko Ursulin:
> > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > 
> > > Long time ago in commit b3ac17667f11 ("drm/scheduler: rework entity
> > > creation") a change was made which prevented priority changes for
> > > entities
> > > with only one assigned scheduler.
> > > 
> > > The commit reduced drm_sched_entity_set_priority() to simply update the
> > > entities priority, but the run queue selection logic in
> > > drm_sched_entity_select_rq() was never able to actually change the
> > > originally assigned run queue.
> > > 
> > > In practice that only affected amdgpu, being the only driver which
> > > can do
> > > dynamic priority changes. And that appears was attempted to be rectified
> > > there in 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx priority
> > > override").
> > > 
> > > A few unresolved problems however were that this only fixed
> > > drm_sched_entity_set_priority() *if* drm_sched_entity_modify_sched() was
> > > called first. That was not documented anywhere.
> > > 
> > > Secondly, this only works if drm_sched_entity_modify_sched() is actually
> > > called, which in amdgpu's case today is true only for gfx and compute.
> > > Priority changes for other engines with only one scheduler assigned,
> > > such
> > > as jpeg and video decode will still not work.
> > > 
> > > Note that this was also noticed in 981b04d96856 ("drm/sched: improve
> > > docs
> > > around drm_sched_entity").
> > > 
> > > Completely different set of non-obvious confusion was that whereas
> > > drm_sched_entity_init() was not keeping the passed in list of schedulers
> > > (courtesy of 8c23056bdc7a ("drm/scheduler: do not keep a copy of sched
> > > list")), drm_sched_entity_modify_sched() was disagreeing with that and
> > > would simply assign the single item list.
> > > 
> > > That incosistency appears to be semi-silently fixed in ac4eb83ab255
> > > ("drm/sched: select new rq even if there is only one v3").
> > > 
> > > What was also not documented is why it was important to not keep the
> > > list of schedulers when there is only one. I suspect it could have
> > > something to do with the fact the passed in array is on stack for many
> > > callers with just one scheduler. With more than one scheduler amdgpu is
> > > the only caller, and there the container is not on the stack. Keeping a
> > > stack backed list in the entity would obviously be undefined behaviour
> > > *if* the list was kept.
> > > 
> > > Amdgpu however did only stop passing in stack backed container for
> > > the more
> > > than one scheduler case in 977f7e1068be ("drm/amdgpu: allocate
> > > entities on
> > > demand"). Until then I suspect dereferencing freed stack from
> > > drm_sched_entity_select_rq() was still present.
> > > 
> > > In order to untangle all that and fix priority changes this patch is
> > > bringing back the entity owned container for storing the passed in
> > > scheduler list.
> > 
> > Please don't. That makes the mess just more horrible.
> > 
> > The background of not keeping the array is to intentionally prevent the
> > priority override from working.
> > 
> > The bug is rather that adding drm_sched_entity_modify_sched() messed
> > this up.
>
> To give more background: Amdgpu has two different ways of handling priority:
> 1. The priority in the DRM scheduler.
> 2. Different HW rings with different priorities.
> 
> Your analysis is correct that drm_sched_entity_init() initially dropped the
> scheduler list to avoid using a stack allocated list, and that functionality
> is still used in amdgpu_ctx_init_entity() for example.
> 
> Setting the scheduler priority was basically just a workaround because we
> didn't had the hw priorities at that time. Since that is no longer the case
> I suggest to just completely drop the drm_sched_entity_set_priority()
> function instead.
> 

+1 on this idea of dropping drm_sched_entity_set_priority if it doesn't
really work and unused.

It certainly unused in Xe and Xe has HW rings with different priorities
via the GuC interface. I belive this is also true for all new drivers
based on my interactions.

We should not be adding complexity the scheduler without a use case.

Matt

> In general scheduler priorities were meant to be used for things like kernel
> queues which would always have higher priority than user space submissions
> and using them for userspace turned out to be not such a good idea.
> 
> Regards,
> Christian.
> 
> > 
> > Regards,
> > Christian.
> > 
> > 
> > > Container is now owned by the entity and the pointers are
> > > owned by the drivers. List of schedulers is always kept including
> > > for the
> > > one scheduler case.
> > > 
> > > The patch can therefore also removes the single scheduler special case,
> > > which means that priority changes should now work (be able to change the
> > > selected run-queue) for all drivers and engines. In other words
> > > drm_sched_entity_set_priority() should now just work for all cases.
> > > 
> > > To enable maintaining its own container some API calls needed to grow a
> > > capability for returning success/failure, which is a change which
> > > percolates mostly through amdgpu source.
> > > 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Fixes: b3ac17667f11 ("drm/scheduler: rework entity creation")
> > > References: 8c23056bdc7a ("drm/scheduler: do not keep a copy of
> > > sched list")
> > > References: 977f7e1068be ("drm/amdgpu: allocate entities on demand")
> > > References: 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx
> > > priority override")
> > > References: ac4eb83ab255 ("drm/sched: select new rq even if there is
> > > only one v3")
> > > References: 981b04d96856 ("drm/sched: improve docs around
> > > drm_sched_entity")
> > > Cc: Christian König <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v5.6+
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 31 +++++---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |  2 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 13 +--
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |  3 +-
> > >   drivers/gpu/drm/scheduler/sched_entity.c  | 96 ++++++++++++++++-------
> > >   include/drm/gpu_scheduler.h               | 16 ++--
> > >   6 files changed, 100 insertions(+), 61 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > > index 5cb33ac99f70..387247f8307e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > > @@ -802,15 +802,15 @@ struct dma_fence *amdgpu_ctx_get_fence(struct
> > > amdgpu_ctx *ctx,
> > >       return fence;
> > >   }
> > >   -static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> > > -                       struct amdgpu_ctx_entity *aentity,
> > > -                       int hw_ip,
> > > -                       int32_t priority)
> > > +static int amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> > > +                      struct amdgpu_ctx_entity *aentity,
> > > +                      int hw_ip,
> > > +                      int32_t priority)
> > >   {
> > >       struct amdgpu_device *adev = ctx->mgr->adev;
> > > -    unsigned int hw_prio;
> > >       struct drm_gpu_scheduler **scheds = NULL;
> > > -    unsigned num_scheds;
> > > +    unsigned int hw_prio, num_scheds;
> > > +    int ret = 0;
> > >         /* set sw priority */
> > >       drm_sched_entity_set_priority(&aentity->entity,
> > > @@ -822,16 +822,18 @@ static void
> > > amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> > >           hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
> > >           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> > >           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> > > -        drm_sched_entity_modify_sched(&aentity->entity, scheds,
> > > -                          num_scheds);
> > > +        ret = drm_sched_entity_modify_sched(&aentity->entity, scheds,
> > > +                            num_scheds);
> > >       }
> > > +
> > > +    return ret;
> > >   }
> > >   -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> > > -                  int32_t priority)
> > > +int amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t
> > > priority)
> > >   {
> > >       int32_t ctx_prio;
> > >       unsigned i, j;
> > > +    int ret;
> > >         ctx->override_priority = priority;
> > >   @@ -842,10 +844,15 @@ void amdgpu_ctx_priority_override(struct
> > > amdgpu_ctx *ctx,
> > >               if (!ctx->entities[i][j])
> > >                   continue;
> > >   -            amdgpu_ctx_set_entity_priority(ctx, ctx->entities[i][j],
> > > -                               i, ctx_prio);
> > > +            ret = amdgpu_ctx_set_entity_priority(ctx,
> > > +                                 ctx->entities[i][j],
> > > +                                 i, ctx_prio);
> > > +            if (ret)
> > > +                return ret;
> > >           }
> > >       }
> > > +
> > > +    return 0;
> > >   }
> > >     int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > > index 85376baaa92f..835661515e33 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > > @@ -82,7 +82,7 @@ struct dma_fence *amdgpu_ctx_get_fence(struct
> > > amdgpu_ctx *ctx,
> > >                          struct drm_sched_entity *entity,
> > >                          uint64_t seq);
> > >   bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
> > > -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t
> > > ctx_prio);
> > > +int amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t
> > > ctx_prio);
> > >     int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
> > >                struct drm_file *filp);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > > index 863b2a34b2d6..944edb7f00a2 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> > > @@ -54,12 +54,15 @@ static int
> > > amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
> > >         mgr = &fpriv->ctx_mgr;
> > >       mutex_lock(&mgr->lock);
> > > -    idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> > > -        amdgpu_ctx_priority_override(ctx, priority);
> > > +    idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> > > +        r = amdgpu_ctx_priority_override(ctx, priority);
> > > +        if (r)
> > > +            break;
> > > +    }
> > >       mutex_unlock(&mgr->lock);
> > >         fdput(f);
> > > -    return 0;
> > > +    return r;
> > >   }
> > >     static int amdgpu_sched_context_priority_override(struct
> > > amdgpu_device *adev,
> > > @@ -88,11 +91,11 @@ static int
> > > amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
> > >           return -EINVAL;
> > >       }
> > >   -    amdgpu_ctx_priority_override(ctx, priority);
> > > +    r = amdgpu_ctx_priority_override(ctx, priority);
> > >       amdgpu_ctx_put(ctx);
> > >       fdput(f);
> > >   -    return 0;
> > > +    return r;
> > >   }
> > >     int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > index 81fb99729f37..2453decc73c7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > > @@ -1362,8 +1362,7 @@ static int vcn_v4_0_5_limit_sched(struct
> > > amdgpu_cs_parser *p,
> > >         scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
> > >           [AMDGPU_RING_PRIO_0].sched;
> > > -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> > > -    return 0;
> > > +    return drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> > >   }
> > >     static int vcn_v4_0_5_dec_msg(struct amdgpu_cs_parser *p, struct
> > > amdgpu_job *job,
> > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > index 58c8161289fe..cb5cc65f461d 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > @@ -45,7 +45,12 @@
> > >    * @guilty: atomic_t set to 1 when a job on this queue
> > >    *          is found to be guilty causing a timeout
> > >    *
> > > - * Note that the &sched_list must have at least one element to
> > > schedule the entity.
> > > + * Note that the &sched_list must have at least one element to
> > > schedule the
> > > + * entity.
> > > + *
> > > + * The individual drm_gpu_scheduler pointers have borrow semantics, ie.
> > > + * they must remain valid during entities lifetime, while the
> > > containing
> > > + * array can be freed after this call returns.
> > >    *
> > >    * For changing @priority later on at runtime see
> > >    * drm_sched_entity_set_priority(). For changing the set of schedulers
> > > @@ -69,27 +74,24 @@ int drm_sched_entity_init(struct
> > > drm_sched_entity *entity,
> > >       INIT_LIST_HEAD(&entity->list);
> > >       entity->rq = NULL;
> > >       entity->guilty = guilty;
> > > -    entity->num_sched_list = num_sched_list;
> > >       entity->priority = priority;
> > > -    /*
> > > -     * It's perfectly valid to initialize an entity without having
> > > a valid
> > > -     * scheduler attached. It's just not valid to use the scheduler
> > > before it
> > > -     * is initialized itself.
> > > -     */
> > > -    entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
> > >       RCU_INIT_POINTER(entity->last_scheduled, NULL);
> > >       RB_CLEAR_NODE(&entity->rb_tree_node);
> > >   -    if (num_sched_list && !sched_list[0]->sched_rq) {
> > > -        /* Since every entry covered by num_sched_list
> > > -         * should be non-NULL and therefore we warn drivers
> > > -         * not to do this and to fix their DRM calling order.
> > > -         */
> > > -        pr_warn("%s: called with uninitialized scheduler\n", __func__);
> > > -    } else if (num_sched_list) {
> > > -        /* The "priority" of an entity cannot exceed the number of
> > > run-queues of a
> > > -         * scheduler. Protect against num_rqs being 0, by
> > > converting to signed. Choose
> > > -         * the lowest priority available.
> > > +    if (num_sched_list) {
> > > +        int ret;
> > > +
> > > +        ret = drm_sched_entity_modify_sched(entity,
> > > +                            sched_list,
> > > +                            num_sched_list);
> > > +        if (ret)
> > > +            return ret;
> > > +
> > > +        /*
> > > +         * The "priority" of an entity cannot exceed the number of
> > > +         * run-queues of a scheduler. Protect against num_rqs being 0,
> > > +         * by converting to signed. Choose the lowest priority
> > > +         * available.
> > >            */
> > >           if (entity->priority >= sched_list[0]->num_rqs) {
> > >               drm_err(sched_list[0], "entity with out-of-bounds
> > > priority:%u num_rqs:%u\n",
> > > @@ -122,19 +124,58 @@ EXPORT_SYMBOL(drm_sched_entity_init);
> > >    *         existing entity->sched_list
> > >    * @num_sched_list: number of drm sched in sched_list
> > >    *
> > > + * The individual drm_gpu_scheduler pointers have borrow semantics, ie.
> > > + * they must remain valid during entities lifetime, while the
> > > containing
> > > + * array can be freed after this call returns.
> > > + *
> > >    * Note that this must be called under the same common lock for
> > > @entity as
> > >    * drm_sched_job_arm() and drm_sched_entity_push_job(), or the
> > > driver needs to
> > >    * guarantee through some other means that this is never called
> > > while new jobs
> > >    * can be pushed to @entity.
> > > + *
> > > + * Returns zero on success and a negative error code on failure.
> > >    */
> > > -void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> > > -                    struct drm_gpu_scheduler **sched_list,
> > > -                    unsigned int num_sched_list)
> > > +int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> > > +                  struct drm_gpu_scheduler **sched_list,
> > > +                  unsigned int num_sched_list)
> > >   {
> > > -    WARN_ON(!num_sched_list || !sched_list);
> > > +    struct drm_gpu_scheduler **new, **old;
> > > +    unsigned int i;
> > >   -    entity->sched_list = sched_list;
> > > +    if (!(entity && sched_list && (num_sched_list == 0 ||
> > > sched_list[0])))
> > > +        return -EINVAL;
> > > +
> > > +    /*
> > > +     * It's perfectly valid to initialize an entity without having
> > > a valid
> > > +     * scheduler attached. It's just not valid to use the scheduler
> > > before
> > > +     * it is initialized itself.
> > > +     *
> > > +     * Since every entry covered by num_sched_list should be
> > > non-NULL and
> > > +     * therefore we warn drivers not to do this and to fix their
> > > DRM calling
> > > +     * order.
> > > +     */
> > > +    for (i = 0; i < num_sched_list; i++) {
> > > +        if (!sched_list[i]) {
> > > +            pr_warn("%s: called with uninitialized scheduler %u!\n",
> > > +                __func__, i);
> > > +            return -EINVAL;
> > > +        }
> > > +    }
> > > +
> > > +    new = kmemdup_array(sched_list,
> > > +                num_sched_list,
> > > +                sizeof(*sched_list),
> > > +                GFP_KERNEL);
> > > +    if (!new)
> > > +        return -ENOMEM;
> > > +
> > > +    old = entity->sched_list;
> > > +    entity->sched_list = new;
> > >       entity->num_sched_list = num_sched_list;
> > > +
> > > +    kfree(old);
> > > +
> > > +    return 0;
> > >   }
> > >   EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> > >   @@ -341,6 +382,8 @@ void drm_sched_entity_fini(struct
> > > drm_sched_entity *entity)
> > > dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> > >       RCU_INIT_POINTER(entity->last_scheduled, NULL);
> > > +
> > > +    kfree(entity->sched_list);
> > >   }
> > >   EXPORT_SYMBOL(drm_sched_entity_fini);
> > >   @@ -531,10 +574,6 @@ void drm_sched_entity_select_rq(struct
> > > drm_sched_entity *entity)
> > >       struct drm_gpu_scheduler *sched;
> > >       struct drm_sched_rq *rq;
> > >   -    /* single possible engine and already selected */
> > > -    if (!entity->sched_list)
> > > -        return;
> > > -
> > >       /* queue non-empty, stay on the same engine */
> > >       if (spsc_queue_count(&entity->job_queue))
> > >           return;
> > > @@ -561,9 +600,6 @@ void drm_sched_entity_select_rq(struct
> > > drm_sched_entity *entity)
> > >           entity->rq = rq;
> > >       }
> > >       spin_unlock(&entity->rq_lock);
> > > -
> > > -    if (entity->num_sched_list == 1)
> > > -        entity->sched_list = NULL;
> > >   }
> > >     /**
> > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > > index 5acc64954a88..09e1d063a5c0 100644
> > > --- a/include/drm/gpu_scheduler.h
> > > +++ b/include/drm/gpu_scheduler.h
> > > @@ -110,18 +110,12 @@ struct drm_sched_entity {
> > >       /**
> > >        * @sched_list:
> > >        *
> > > -     * A list of schedulers (struct drm_gpu_scheduler).  Jobs from
> > > this entity can
> > > -     * be scheduled on any scheduler on this list.
> > > +     * A list of schedulers (struct drm_gpu_scheduler).  Jobs from this
> > > +     * entity can be scheduled on any scheduler on this list.
> > >        *
> > >        * This can be modified by calling
> > > drm_sched_entity_modify_sched().
> > >        * Locking is entirely up to the driver, see the above
> > > function for more
> > >        * details.
> > > -     *
> > > -     * This will be set to NULL if &num_sched_list equals 1 and @rq
> > > has been
> > > -     * set already.
> > > -     *
> > > -     * FIXME: This means priority changes through
> > > -     * drm_sched_entity_set_priority() will be lost henceforth in
> > > this case.
> > >        */
> > >       struct drm_gpu_scheduler        **sched_list;
> > >   @@ -568,9 +562,9 @@ int
> > > drm_sched_job_add_implicit_dependencies(struct drm_sched_job *job,
> > >                           bool write);
> > >     -void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> > > -                    struct drm_gpu_scheduler **sched_list,
> > > -                                   unsigned int num_sched_list);
> > > +int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> > > +                  struct drm_gpu_scheduler **sched_list,
> > > +                  unsigned int num_sched_list);
> > >     void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched);
> > >   void drm_sched_job_cleanup(struct drm_sched_job *job);
> > 
> 

