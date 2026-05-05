Return-Path: <stable+bounces-244226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDI2GPcq+mkhKgMAu9opvQ
	(envelope-from <stable+bounces-244226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:37:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D04D2299
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B5D4303FAC0
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5C48B396;
	Tue,  5 May 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXsSOFbl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463D3C1981;
	Tue,  5 May 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002531; cv=fail; b=i3DYFc+smxMySgT2qDnLPzsBuu4QhMzYs35LnR9dfGMSv1wJ9/Gx+hATTfbKDbTjZjahdnOQwDOXu0bvqP3Om3PmdM1ZORLmS3281sJiCf9lgdkotLjhphV2DY1ykGLLvWUaDvtnziI3FFrV4DRWaigw3aAs0I0Dnz9LhNrJXvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002531; c=relaxed/simple;
	bh=kzqldpRTcF6ETWRWvNJ7P5wjxysBhHy3HFYIn6AX+c8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F15RWUPfTh6HuGTRg0cgb1MPytiyA2NTSZcXn4b99F1GAtZf4g8SKjero2oW6yew05zeKhoR1/9/APgYGZoPbbiU/q3am+8j9NzagJandY2XhKYgwNA35ysWSiByf1C+ZL+17lW+lBp+Iv/TgVElb8+D68IT7SB4ogIW6lnweNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXsSOFbl; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778002529; x=1809538529;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kzqldpRTcF6ETWRWvNJ7P5wjxysBhHy3HFYIn6AX+c8=;
  b=dXsSOFblZ4wicEkMzCYdY2KfyarENFsk3zkcqU9xbPL+pbHqRg3vOJqD
   5dL0GO6r/hbVMNGinbeb0N1jkWCilAYY0jITad8XoL0CnTW5dN6qHN/24
   oLQ5ynHsNYDP6RFRAuHtWbiZ2lypdfIET2E3abpaiU5CqzsVr5HrxV/c2
   DFzs7Oir7nz9gBohGW30HS32dPmN8uFjxVK+7/KM17m5kc6mzZYI040KI
   s4RJwdE4zCoOjUBRj55Oa1DjfdQyXZ1+CBpRAjVAikQQOr/YlOWewfEqF
   6f+e2bkbjWDKTosj0G369eOXUfNiPyY06ZQkoGN3JlIhCjmXTtO8gcc15
   Q==;
X-CSE-ConnectionGUID: ISlON+czRDWV2c0gLUPmwQ==
X-CSE-MsgGUID: MC6MwBWdTfaENskDF7TXKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89580843"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="89580843"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:35:28 -0700
X-CSE-ConnectionGUID: W8Q9mbaPSRmyVpoMRfYonw==
X-CSE-MsgGUID: qits1sKvTsiYquR2tVh+GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="240867754"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:35:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:35:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 10:35:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8FX/TELC23vEVGhX1jG2iGf7jfofVw7VL0pqZ9061iBKgqyGTSyALsR5prgpneMg7RlkkpiTrTKDgwAabxDrzTthwQS2UXaim+FdCXlIwtIlEBsoM4qNRXicz/jOtGXT1mc9/TlgtPyeBWlBRJ9zF4oPLf6O/Tuq6B0nQev+p9JZIONNmHzsHO2zpcrQjfz/2pwimBaO4Q3qtgifQqOxUdZRXyDSjDGaXqN8thxqwvWIeF+igDR7BpAH+GInzRSRVl3hv0sryirXBAjZo+7as9DgJu1DWnhXQck/Ds8hw9ejMwR/RP1Ema/5Xim6xnfvjM5MV9N7zUxa3y8iBXk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGYCrw+9RpdlQlmpmcoRGVuUf4sOXEGmtiM4ses4ubQ=;
 b=PbqDiXcGxS7omClyekXCAeHOUxQd+7vNQMryPT6tpd0/8ACK84fcyLmP0HVVa2FoofdVM64MCur8NAlVIQ2qpPYYua3W+vxchpaVw5+lSPsylR2PMOwdLCjC8HzV/Ea6NVuHUI1+noJm4sNsEPLxhRqb0H0xdCTD1XRE8XRt07Gq0/koYe4tYbhVb8sUXHUxTy361V+y/LPl3aLLVvu1sGOG29a+w0q+1WFYNPg95KSC6Kdt/mpG/EGEiVnGjw0mR30YtJf+1dB+4ONOOmJkVhuIBT+DQ87IQDgknabn7J6xy6F0a5ucs4RVU/axOr/G4HKgc+ROiYl1oFzDk0elHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:35:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:35:03 +0000
Date: Tue, 5 May 2026 10:35:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] drm/ttm: Drop tt->restore after successful restore
Message-ID: <afoqREI0F9NhyEHA@gsse-cloud1.jf.intel.com>
References: <20260505033013.3266938-1-matthew.brost@intel.com>
 <20260505033013.3266938-2-matthew.brost@intel.com>
 <c2c5fe4cda479c02e18d658c91e55c9ab1cfc8bd.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2c5fe4cda479c02e18d658c91e55c9ab1cfc8bd.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b3418d-8be6-4e75-2592-08deaacca3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AvzV53q4j4zGnOFFqNBN9MUZNA8VZ4HqWhmDUv9Ds1bYl8P3zoo/x501b7XuUis8CDQG3e2YTmONQfgtAfclBEmuRvVVZ/N2CiWSSLh3vd6DAzCOIXbHKEnZuPwv161T9n75wxyZkKJTZHq2CLR9HJVAOnAfxwtiJcFs4k2PPtJmRbpO79Xp6V23QPGtQl5ImSurfdd45mVaAFI71UzwGMXuFIXSvwx4aRYi2773vE5YUofpQaSvKTqETGvVqEaDEsESDEvAV9Cx/tPrn/2GnSEqAKae4WU4JNNAgxnoNrsww1uWfIoE5i3N/UqNP2pisuir9I3JW/bJra8TXK5kGyOgQuQsSWH0R0INcfOM0swXd5Ug7kwhOOtOkA9g1y4J1Uc8ucdUhpN+RpYgED+Yf9Dfi6juvSngcbhpBLEr+ZFuXneQmNqZ8nXXq8MkT5rD5Tx0y3KKVquoFIVWtR9ycO15JTSN20zSxoveSX4wSRliTlSd0iBuo8V6Tiqh/IRO+DDI5qoY5N0LNiQjRspE2FCTgGDi5qn47zGfUW1auO8hybAzxf0E5yJ0n4FecUgXxc+r9zmVueyZVWYcVS/R2RukOcpoFih+8odKhu3cIszHZBH8Fyr9E8mEu7hfo3zZ7YJ5Ehe+RzQWxBzI/++tEDwmHOQ7iuGEKu1o+qv9NY1E1YyyjJ8IbT+7XhhKd4EZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xrVwPq+v/kJfdFikmsO6JNkHsUQbIiRSCDCtR4LaYAZBcFTPwpTuxP9S9N?=
 =?iso-8859-1?Q?Mwo1/HT+abMGWqJOu3GWTkQLtmzs0lqTL18kLMfWDNaguKNd61EJgiNNyR?=
 =?iso-8859-1?Q?qFEQ4HQ6E0RZktjlceWsuQMJfDMT1VJWF50Fbt+K3T9jl7UVT9jBon1urd?=
 =?iso-8859-1?Q?i1wLSyFYJ1UoSvZsLaO4rBPdQp2RYsFnaLVBR6nmfiSjYYKEr0FVbzmho2?=
 =?iso-8859-1?Q?eVwZfTpiHpebcY2LjzRP1IOpzRaTbSgSiKWnXux33+YLYgKEI6HsymRljw?=
 =?iso-8859-1?Q?FCoDiMTUo1oupORa9e7TIX7HONgvD+MJRoXtQeWJ7RtBpg34Caw82OWf5x?=
 =?iso-8859-1?Q?t9F0LRQefU3uP1V8CuvGVbBYK0zf/LFaS2KJFU3059sECBuHDfsdTEKN+m?=
 =?iso-8859-1?Q?ABGWAouoPvPrgCxhFatMa5k7tM74X6xdAWG6HyTVQZqwUhEYYv2VOlCuXS?=
 =?iso-8859-1?Q?CBkPDQSQyk8dLdgYkwFG5kkMWWGQHp9BQlROunav0uX6NRIhopFRWJGhNS?=
 =?iso-8859-1?Q?yZfvVdINUqfWJWYWTa8DPPbPivAdQX8GMcpwujF2VSJr7s77NbH7GEPrMK?=
 =?iso-8859-1?Q?N5ZZSDzY4FyrfR+eeML/unAYvmv8U3Dc2cPVeXBi09e6w/QSUDi3LmEtm1?=
 =?iso-8859-1?Q?nwYSLtq2mLs1pA1LH0wMFDmgcNod7uXCnt4xN84tXQCKLrCLQmY5P+Vk7S?=
 =?iso-8859-1?Q?5EOIBpjHMHVh/wFZe4FtdPjsuNLhxwB/R8mRsWRnPq6Bxd7eJGbkyX4Ej/?=
 =?iso-8859-1?Q?C5HeOSK8fwKtwVIfGzhwT7drGZF5ZcjgDEbEDCjD1mpSJoLAM/3gwfZ1SK?=
 =?iso-8859-1?Q?Z63bGMgz9iP9BJLBliMA86gXrtcLxUpEX7r1SidSDTDSxglh7OqQajGcdg?=
 =?iso-8859-1?Q?6EX9RRaLh+4vBtXz9VPU+VEOAvCBNc5V41JSyVr4Dd/GEVmdUyc+lqcPPO?=
 =?iso-8859-1?Q?VK8DumNTeW+l20flxperjbm6XELuC8/XOHlc1M5SXTALKBt6tz38NTVzl4?=
 =?iso-8859-1?Q?C0DpJuvflwwU3mwzcIwSVqSmwT1l6GAOGW7iInotuEeSugIxbIoN/7kcjQ?=
 =?iso-8859-1?Q?QNt7MpHVwwo/2okQopR/ufT8Xb/RWKjHrVRZF6CKnzbgDvuzVefTq2KdIW?=
 =?iso-8859-1?Q?xsYQviKxI4XSPa6zaE0U+jUW7rBRpHL/3+f6a6x5T+hqvy/7GOwQKgs5kR?=
 =?iso-8859-1?Q?g/3lDHalIyBVJ+TPVCwR3eJhUZDCA/kDWolL/v5sIKhddXRD/nhxdBZK7Y?=
 =?iso-8859-1?Q?pbLRx9rY8Njj65PhQ9Q3SkUQc0CRTOuopLaXKXBHur529NmaZLZBp2DqPS?=
 =?iso-8859-1?Q?hSdA6IgLy9w/MPrPIg4Qg0psILGMgYMvfs8DuEedCpakwhdH5+daDWOO7W?=
 =?iso-8859-1?Q?bqQYL9UFTytJSErTIXXSVl9iAOKicA3I7/xdqRtc1d2bExvJy7U+V5Wr2h?=
 =?iso-8859-1?Q?Hf+kp3CV5OW6v5i6asKESwK3CQSZ7oX+G1IYNuQfq0F8KWRhEIBxXCDJgw?=
 =?iso-8859-1?Q?CH/jCpMLuBzIJiWV27l/gKsentneT6QIbOsD4ZcVnNHJIciQjJbFZSIpV/?=
 =?iso-8859-1?Q?gARTSPnsrDx8d8SHg1fRi0BcqVhEcBDTaBtueeRpgelSlkbfti+B4jYwRX?=
 =?iso-8859-1?Q?nR1W5/5hwNRZv5lRol1qd0cQvXOGW7eaFgQ8bwPcNce6178u8aVeY73yM0?=
 =?iso-8859-1?Q?Gtae9DumxOpEU/MFTFCiDIkSN5rDZ1A+5VbpC/xnc7jtn2o0h5q9olOAK0?=
 =?iso-8859-1?Q?Q3egkzxFzmhruzl6kM618OWxgNthVIPuM03kw5w4AdJi6NblRNZAlSKMr/?=
 =?iso-8859-1?Q?MDWRDozbwQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: OITKEm70Pj6a/GuTtFuHCp5TjUDDT/SK5mcEWrOFlqmDtB1C5JAA+lw5iNeFpWrzL4TjDZ157w73quKxOi6m0dp012+0M6SuhblXsqhtzLGIhJ2dMg4K1U0NuTSoHP4ul0bROdi0idh7Xm/L/pIBEZGl+ovEU3xIOVmmmqqphlJwQhbCp2dCrOpnB5yGzo3y4g4vSUUf/L2GFqHCp13DP9XKe2iaf9Cv4b/tE1q436gjl0UcGQTKwcWptQbsIVY0eu3nG8wn4EoRCtedl5ieYEr4aXAdaMzmqYhNz3OYze+N6XwGaHjgE6ADjl17I3wX4Liy/1FIj+VOJKwy4Bq4dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b3418d-8be6-4e75-2592-08deaacca3c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:35:03.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pjepMJjcNC3W12W9QTr/qjba+LKdDRtCMwoHG2Cuz7oCN+QcrSejSZXc5em33Y1tPKmHfPy4mAJ3cRjJigDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A68D04D2299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244226-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Tue, May 05, 2026 at 09:04:45AM +0200, Thomas Hellström wrote:
> On Mon, 2026-05-04 at 20:30 -0700, Matthew Brost wrote:
> > ttm_pool_restore_and_alloc() can successfully complete the restore
> > process via ttm_pool_restore_commit(), but tt->restore is not dropped
> > afterward. As a result, subsequent backup/restore flows observe what
> > appears to be a completed restore, while in reality shmem handles are
> > still installed in tt->pages, leading to the stack trace below.
> > 
> > Fix this by freeing and dropping tt->restore in
> > ttm_pool_restore_and_alloc() upon successful completion of the
> > restore.
> > 
> > 20545 [  309.784531] RIP:
> > 0010:sg_alloc_append_table_from_pages+0x38c/0x490
> > 20547 [  309.809570] RSP: 0018:ffffc9000623b838 EFLAGS: 00010206
> > 20548 [  309.814827] RAX: 0000000000001000 RBX: ffff88816e42a160 RCX:
> > 0000000000000000
> > 20549 [  309.821986] RDX: 0000000000002000 RSI: 0000000000000003 RDI:
> > 0000000000001000
> > 20550 [  309.829147] RBP: ffff88816e42a168 R08: 0000000000000002 R09:
> > 000000007ffff000
> > 20551 [  309.836310] R10: ffffc9000623b928 R11: 0000000000000000 R12:
> > 000000007ffff000
> > 20552 [  309.843471] R13: ffff88815ba5a100 R14: 0000000000000000 R15:
> > 0000000000000001
> > 20553 [  309.850634] FS:  00007f9ff305e700(0000)
> > GS:ffff888276c94000(0000) knlGS:0000000000000000
> > 20554 [  309.858749] CS:  0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033
> > 20555 [  309.864519] CR2: 00007f9fca701000 CR3: 00000001565e2005 CR4:
> > 0000000008f70ef0
> > 20556 [  309.871678] PKRU: 55555558
> > 20557 [  309.874403] Call Trace:
> > 20558 [  309.876866]  <TASK>
> > 20559 [  309.878988]  sg_alloc_table_from_pages_segment+0x60/0x100
> > 20560 [  309.884415]  ? ttm_resource_manager_usage+0x36/0x60 [ttm]
> > 20561 [  309.889845]  ? xe_tt_map_sg+0x7d/0xd0 [xe]
> > 20562 [  309.894045]  xe_tt_map_sg+0x7d/0xd0 [xe]
> > 20563 [  309.898037]  xe_bo_move+0x927/0xaa0 [xe]
> > 20564 [  309.902029]  ttm_bo_handle_move_mem+0xba/0x170 [ttm]
> > 20565 [  309.907022]  ttm_bo_validate+0xbe/0x190 [ttm]
> > 20566 [  309.911405]  xe_bo_validate+0x9a/0x120 [xe]
> > 20567 [  309.915663]  xe_gpuvm_validate+0xd9/0x140 [xe]
> > 20568 [  309.920206]  drm_gpuvm_validate+0x2f0/0x5b0 [drm_gpuvm]
> > 20569 [  309.925459]  ? drm_exec_lock_obj+0x63/0x210 [drm_exec]
> > 20570 [  309.930627]  xe_vm_validate_rebind+0x46/0xb0 [xe]
> > 20571 [  309.935428]  xe_exec_fn+0x20/0x40 [xe]
> > 20572 [  309.939249]  drm_gpuvm_exec_lock+0x78/0xc0 [drm_gpuvm]
> > 20573 [  309.944410]  xe_validation_exec_lock+0x5a/0xa0 [xe]
> > 20574 [  309.949385]  xe_exec_ioctl+0x806/0xc30 [xe]
> > 20575 [  309.953639]  ? ttwu_queue_wakelist+0xd9/0xf0
> > 20576 [  309.957935]  ? __pfx_xe_exec_fn+0x10/0x10 [xe]
> > 20577 [  309.962449]  ? __wake_up_common+0x73/0xa0
> > 20578 [  309.966482]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
> > 20579 [  309.971263]  drm_ioctl_kernel+0xa3/0x100
> > 20580 [  309.975209]  drm_ioctl+0x213/0x440
> > 20581 [  309.978637]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
> > 20582 [  309.983415]  xe_drm_ioctl+0x67/0xd0 [xe]
> > 20583 [  309.987408]  __x64_sys_ioctl+0x7f/0xd0
> > 
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > shrink pages")
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > v3:
> >  - Call ttm_pool_apply_caching after freeing local restore (sashiko)
> >  - Save alloc in snapshot on restore failure (sashiko)
> > v4:
> >  - Actual 'Save alloc in snapshot on restore failure (sashiko)'
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 278bbe7a11ad..c7aab60b7f01 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -902,6 +902,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> >  {
> >  	struct ttm_pool_tt_restore *restore = tt->restore;
> >  	struct ttm_pool_alloc_state alloc;
> > +	int ret;
> >  
> >  	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
> >  		return -EINVAL;
> > @@ -925,14 +926,24 @@ int ttm_pool_restore_and_alloc(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> >  	} else {
> >  		alloc = restore->snapshot_alloc;
> >  		if (ttm_pool_restore_valid(restore)) {
> > -			int ret = ttm_pool_restore_commit(restore,
> > tt->backup,
> > -							  ctx,
> > &alloc);
> > +			ret = ttm_pool_restore_commit(restore, tt-
> > >backup,
> > +						      ctx, &alloc);
> >  
> > -			if (ret)
> > +			if (ret) {
> > +				restore->snapshot_alloc = alloc;
> >  				return ret;
> > +			}
> >  		}
> > -		if (!alloc.remaining_pages)
> > +		if (!alloc.remaining_pages) {
> > +			kfree(tt->restore);
> > +			tt->restore = NULL;
> > +
> > +			ret = ttm_pool_apply_caching(&alloc);
> 
> return ttm_pool_apply_caching(&alloc) ?
> 

Yes, will do.

> Otherwise LGTM.
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 

Thanks.

Matt

> 
> > +			if (ret)
> > +				return ret;
> > +
> >  			return 0;
> > +		}
> >  	}
> >  
> >  	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);

