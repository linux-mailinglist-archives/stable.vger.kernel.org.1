Return-Path: <stable+bounces-105634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059909FB0DA
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F268F1883ED2
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93051AC435;
	Mon, 23 Dec 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfdL/TOK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A519D074
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968691; cv=fail; b=WFNAicBFT7GvB98gwglzcUdiosrF2a8rWI6n6ZFugJS828YyX16Agtgq9NSha5f1t32e1xiMEFM8oNM8ENLF0CQW1y2C+d1zuq7etbYaWImn/hRzfR8aflCj8QyaMJqf5gqhO8yi/VKLMo4J1pVBRSWGcvOE7TFE8JJI/yxNGiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968691; c=relaxed/simple;
	bh=TpZHRwO5OJ0T/eFLAxSXRvPyiXSKRq72H69y05vzpME=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GENpAGXxUhIGSVCOCSHAa1WbiCYM7SAqK3DsitQT2AE78WYuLomQTX51l2UnGiIJSp46vcsEonNhOviryl3hm1zJBv/ZqmQB9ELYndpjfnlDiR5sWo2wxRATT8ZUsVN2kzIoxczs+qdNgmQ8lGFaDbmQZFRhWyPWxEfgISbxTe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfdL/TOK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734968689; x=1766504689;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TpZHRwO5OJ0T/eFLAxSXRvPyiXSKRq72H69y05vzpME=;
  b=XfdL/TOKPw89Xy/7bjM8FfznQ/nQ/zJSZvG4s1DJ9qlm4mUY2y21eBsP
   nR8agSNbhIGU/9p1GZk07S7p0QgDlbKuuVp03sBJHI4S3rWC8wGPKRe5z
   RPTkJ+9O18ZS+OBhIqslVAs0A3+iEzZGEIGVpfs5T1Tm48GJ3QFrtMil+
   Ly9zdV0sAOQ97XerNPpkWaIbHZGWLyJZdxPJJ+iCjYxAaDoNTKw+vendN
   qzgWULSEJRgFdwCXM/RxrShby1KiNvUaR62JK9+narlrO+jr0ve2UBVaA
   mi6ld1uK4GsH7YfUZs9LNajE9gAoMroJq2W6kpWBgrrKYFe+UstiOWkE3
   w==;
X-CSE-ConnectionGUID: BLHfLwVFSAKjwY31j5FSyA==
X-CSE-MsgGUID: E1+G8XeOTCybK0mMGrtefQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="34746413"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="34746413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 07:44:34 -0800
X-CSE-ConnectionGUID: VzIyPo3YRaSLYWnTw29tPg==
X-CSE-MsgGUID: qBubfFTYT/iVtlhrpSFqWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122506308"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 07:44:34 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 07:44:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 07:44:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 07:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6gYoiLbD/7k+sBzwcaGyQHD8UeDZ9vgW/9xnmf91Vq81ruq1P+oGYo9cNZGBGV0CK6012t0LDVHzBHtcAxJrLW7kHDJ2jpTp47rdE+RzSCnMRIlbOhg90KSsYMw2rX+wxnr8ZmS6Cry7sg0zJmxi8ofiN3olsgDEfv2VD1gBQRc3GF1FSIcow60/KQvmx85RbuAPVTmot3amzy8XouMzzQMyvFX4xXjo2GWnGTYYXL4v+0MfaVk9gcYfAZhQ3O1ctSxXg0nHI9sjXyMp98rQDKhZh+rEIB9duJE/3R/W4pHIFV6X/iz1MrbdzilR4/VtDCu0vi9MA66iTLr1bqwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfhb+7vO1GR7VnqTX7v0SAU6L3m8m0LSvMBj25q2evo=;
 b=rXp86bj44d/mP64CoRS2E5+HLcEVfAjQYHvkDaC9cwSRxSeVgZTnITD7GMie4GKvHfw2bh8wQ28zmtANCJMMOGyEtF1k/avnFz01P/Rqvs4MZDz7y4IJwO/h1l9CV/fitRGhWgHk+2kJg1o4elv7RIxNvWyEXtdWaf1Ogq47P5MEgNdg8/2NgMx0TDSYKzvWBLNNqruijwf1wuBrWPskAMYwBwdLFjcX2NdoHLDkxA68u8ekQMO8S1sj7TnbywGLb9ICvBFgC0NvSA8NcvHKX+Gkz90jwdhy/235tJTeX1TiSOBFVBMwK1hXwQD6B5gtKHEOgQ8/zMIhqSc54k9uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 15:44:12 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 15:44:11 +0000
Date: Mon, 23 Dec 2024 07:44:56 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Gustavo Sousa <gustavo.sousa@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>, Radhakrishna Sripada
	<radhakrishna.sripada@intel.com>, Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Message-ID: <Z2mFePfn73Fugmrf@lstrano-desk.jf.intel.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2066f79f-cc27-4f67-606a-08dd2368a58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?QG94GkadD0Se0qojw1BG2qz3jinPg94RVQp6ebpOJ3XQ1OkralpjgZVWTm?=
 =?iso-8859-1?Q?OFQswqIqs6gWnM4uqMrkprsTlFOoxjfBz24AN7ajwoOgNxGQ4SZ7DF22Pk?=
 =?iso-8859-1?Q?QtJtWk6kEiCSRnynA8Y4xQHA0cFgTUpdVyR8/fnezSwBTy7JdPQ/h3i6iu?=
 =?iso-8859-1?Q?+tv5x1OoaFohm3FsTh1pvZcQGMb3Iw2wR/MvUf2e4nwOu5iiblsMAZzbyD?=
 =?iso-8859-1?Q?6ETY4kpmxgWSs9Q3kloE6eVZtb4MtZWvNV6wxhGWFL+TRWcDRC4E6enqXr?=
 =?iso-8859-1?Q?hD6MRyKaPW271tLId3JJCywsq9HFpi/ayfC+7fywghLkcjQfKoa6C2Xutn?=
 =?iso-8859-1?Q?3qxrM5yHt5979rIfK3RtV0MXppL+VU3VhKsHYUDpnyqNnTR2jMZegexR8i?=
 =?iso-8859-1?Q?d5FnnGp6s5PuLYqDPkl+ikRaBEzo0G3S2qF/EY/DVjNt9bWosMMxhM9pbi?=
 =?iso-8859-1?Q?6+MFySSophc7bo/pOjZLjPQ2SCYPfvdS9TsZkqdBCSBog8BXULwba5gioi?=
 =?iso-8859-1?Q?kyt31abrZu+2D9oUstBJNk9O9oHMweugVg12iD0REQM+UTnxam4vjg8Voa?=
 =?iso-8859-1?Q?VHPZBVlpDWU9zcPFIINsFNiqLW1pYh9QKztxqK3IKVdZl4AWB/d+uMWKyV?=
 =?iso-8859-1?Q?N0Wcm2/E+ycjPip4FNNxrsGK8ctGODViXEdvqQHGvJao///bZyYVVEvbBW?=
 =?iso-8859-1?Q?nTdBxYaKu7way+0V4pSe+bwso9MTSo1t2Y4KyKoNDiVXdB/rfG+AxLfG5y?=
 =?iso-8859-1?Q?4q6d+eW4oGjW0TjgK4batphtS5FQCTQj5kIaIMfmXvi2Lk2yrBcC11xvNK?=
 =?iso-8859-1?Q?JI1GuArYI0YVWmG2gqj0w7Scd3bmaSj9E7VYBfcSngAZoV5y+yW/gIfNew?=
 =?iso-8859-1?Q?hGRIvAEThTwRCcq7UlPyvJSiQVxwMyAtzFc23RWnmE7bzFzMxeWDLM11tx?=
 =?iso-8859-1?Q?6emZ8dtYFtHfnnNPBAwoI+0xl18OCKl5uAr3tz2ZNzdAPj5Al/Ra3DzlGa?=
 =?iso-8859-1?Q?NE2T2r2RFXAY86+ULn+frIxPmiK9GaVIXyd56d6NyLGBIshX+uhKc6D1zj?=
 =?iso-8859-1?Q?x+wRF5vvum/q2pS9RjiSOX9oLtiCx6wO8kbrZv0wQ0WlU8EC8zmLXzuTQl?=
 =?iso-8859-1?Q?+TWCSWL84Y5O8qsexE0GWRhWcAK+0mwVjs8gad/meuROf8R44FyJ/nC1kB?=
 =?iso-8859-1?Q?U5/dqpQmyPX6gjsqArhWAnehDaRBWu9TBVXnTQ2+5c7GYUj5umG8AixGEZ?=
 =?iso-8859-1?Q?IJdpY14sJay52nQ1ODbASjCOhpRUnOzA6ESuVA3sQvaBtu0Gqx38TuipJE?=
 =?iso-8859-1?Q?8XGMzQbbs2+p9O5PQDultNwxMeNuINo8KwgwqwOzhQ9PTtCxfff8clLRzc?=
 =?iso-8859-1?Q?Zw1G1r20Ipc1BIPkI1F/j6p0/ZHRgMoMZ3oYZIFNnc/mQ60g+Z2vJCUTGn?=
 =?iso-8859-1?Q?AZXK/bfKjq0RMiem?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ahHA7/eZMFs+5dqz34bT7kTF63ZBg8owIcmEnWKFj0jvpXAwTRXDa6dg8y?=
 =?iso-8859-1?Q?p0XZ7j2mJSVA2l/gLx0yCqu4FEC3MfKXYf77sPt7jBsCExp/6Ezgwep1V1?=
 =?iso-8859-1?Q?cf/DnuwQ3MD/gor/rLGjFkuLO/5rgKZGGztbIBErXUzlCUIv6CJIMI+zjg?=
 =?iso-8859-1?Q?wqN089ApatOxKcww3N0nu95qF7frqX7+r2D02rNuWXIFXrW7omIZPFxelO?=
 =?iso-8859-1?Q?/zntYFN6h0fT2tJI0yRpPiNY5/c3inbcyX1VqZEerv20NoDPNNIZ6E+lNe?=
 =?iso-8859-1?Q?ki0K8Aa3uwjPz35IKGft/WIKsH421gk2cbiYgxavi1NoFhyK106Sap51LW?=
 =?iso-8859-1?Q?189SySGnMPRNQfu5HfNLyQ8SkO9lhXpC77hQnQvjhDxxze5+yaB6hXV56w?=
 =?iso-8859-1?Q?ul3t4sJa8DYHNTwg7uROO087cVkmMDw+SfDu2gzcoaYTKSPhE/q4rCD1cc?=
 =?iso-8859-1?Q?9kGT2Ya4UXjQMCeiwdpWXoaNEYcxlGz9m6SjVm2ntrRSXtmN61bTaxn0WB?=
 =?iso-8859-1?Q?ELa8TShXPNFjS/GyfMJRC2QGGWEIawEhefXmKrSTYMj1GzGWuSTQlgKreu?=
 =?iso-8859-1?Q?adH6KBTtvN5xREYg2DrVC1BN8g5L7Rk4u5uoJkUIozRK5tkkZSxwlm1bUr?=
 =?iso-8859-1?Q?CPPPdwSc/h5dzGqTcaVTxxCOAzJ6Eu54kC0Po64S9uKfRyXVSQghUtI/aq?=
 =?iso-8859-1?Q?Agc4Iz82e0iNg8uZskA9sk/A+Oy6p0D8ksdT4XkJW6LBC8XG77uayh2vTY?=
 =?iso-8859-1?Q?Wh/g0CNY/ExKdyfkzteweDgVDnRHeG+vpV+P15TYBd942CbsVt9EkQHqh3?=
 =?iso-8859-1?Q?/mCqeJQCsKbD4uyFn70TBUp1srGlRYKuJzMnMPd67okVcxpyw9CozeoJqx?=
 =?iso-8859-1?Q?WbFa8M2GAmoW6M9AGAhrK2udvQVhwmzGEpuAJUeeBt923IzhIhdT/HhT+9?=
 =?iso-8859-1?Q?fHj/gPT2uzkH6lPzWk5/FZxUjS1wv+y3NTc2fg0aCqzQaqoxh56kMpcQh+?=
 =?iso-8859-1?Q?RXqwMsdNAF5dWKbrQcVCU65uqpN6oPZIXL7GPSjZmKAY5sC+C9sQ0Exoux?=
 =?iso-8859-1?Q?wWF+eivhP+aVd6q9iAUgupnvMAN7mZGPFNktfDxbpltcU3+l0L4kYukOOh?=
 =?iso-8859-1?Q?vRIQ3fWKsbd4rXtRurUsshwYIhUNtIEsICpVItYpGWqGwKuiWPBNN1ierF?=
 =?iso-8859-1?Q?VTOemuq+CcSD73CtW+WLvhzX7haeKARWAQqaadp9nehI+G1+4YnIWUt6EO?=
 =?iso-8859-1?Q?bMfvrjXQ0s6GJLcIwMtVwOsGwryUxLhVZ6vfPvD973ygBY/elASFcOj6fi?=
 =?iso-8859-1?Q?D7oT0gr50FRaSCUaIYMzMfzMqHdKOBo1wpOSHxKSHbEygeexYlw3a+faZp?=
 =?iso-8859-1?Q?NiRjjQgxDoWezh7MO0vYKhoVlxj1yejmcIqsgg5p8hKUbWT1cG+SqSPc1o?=
 =?iso-8859-1?Q?oj3MtISktY6H1z9G/4tLNXh13aheDs44gtLFBVhGvkn2bHezRmOCmpXv7a?=
 =?iso-8859-1?Q?gPlXLlTY5TB7NRJF0uo2Jg/fDPSh8PtUcfFa2pGEv0BI9SAYXMY2OILblv?=
 =?iso-8859-1?Q?Zrl2AE1y5D49HdvsNSKRYgieeeaS2ZV5u7OFkvkfLhK3dkO0vc+bg88xP3?=
 =?iso-8859-1?Q?LQkcUDy16qp+IsozKX4T/TZQ8FetCwDWjYSutQ2/dW4tv3vkCyNffDEA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2066f79f-cc27-4f67-606a-08dd2368a58b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 15:44:11.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eoVtK9i0+9kCMPu4h1DJM38UPpLp630Ledr2dZay5MjxpCm3twdCRyTeBSiK9peVaZDaPdeq/mkvlkR0GdsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

On Mon, Dec 23, 2024 at 02:42:50PM +0100, Thomas Hellström wrote:
> The commit
> afd2627f727b ("tracing: Check "%s" dereference via the field and not the TP_printk format")
> exposes potential UAFs in the xe_bo_move trace event.
> 
> Fix those by avoiding dereferencing the
> xe_mem_type_to_name[] array at TP_printk time.
> 
> Since some code refactoring has taken place, explicit backporting may
> be needed for kernels older than 6.10.
> 
> Fixes: e46d3f813abd ("drm/xe/trace: Extract bo, vm, vma traces")
> Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_trace_bo.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
> index 1762dd30ba6d..ea50fee50c7d 100644
> --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> @@ -60,8 +60,8 @@ TRACE_EVENT(xe_bo_move,
>  	    TP_STRUCT__entry(
>  		     __field(struct xe_bo *, bo)
>  		     __field(size_t, size)
> -		     __field(u32, new_placement)
> -		     __field(u32, old_placement)
> +		     __string(new_placement_name, xe_mem_type_to_name[new_placement])
> +		     __string(old_placement_name, xe_mem_type_to_name[old_placement])
>  		     __string(device_id, __dev_name_bo(bo))
>  		     __field(bool, move_lacks_source)
>  			),
> @@ -69,15 +69,15 @@ TRACE_EVENT(xe_bo_move,
>  	    TP_fast_assign(
>  		   __entry->bo      = bo;
>  		   __entry->size = bo->size;
> -		   __entry->new_placement = new_placement;
> -		   __entry->old_placement = old_placement;
> +		   __assign_str(new_placement_name);
> +		   __assign_str(old_placement_name);
>  		   __assign_str(device_id);
>  		   __entry->move_lacks_source = move_lacks_source;
>  		   ),
>  	    TP_printk("move_lacks_source:%s, migrate object %p [size %zu] from %s to %s device_id:%s",
>  		      __entry->move_lacks_source ? "yes" : "no", __entry->bo, __entry->size,
> -		      xe_mem_type_to_name[__entry->old_placement],
> -		      xe_mem_type_to_name[__entry->new_placement], __get_str(device_id))

So is this the UAF? i.e., The Xe module unloads and xe_mem_type_to_name
is gone?

I noticed that xe_mem_type_to_name is not static, it likely should be.
Would that help here?

Matt

> +		      __get_str(old_placement_name),
> +		      __get_str(new_placement_name), __get_str(device_id))
>  );
>  
>  DECLARE_EVENT_CLASS(xe_vma,
> -- 
> 2.47.1
> 

