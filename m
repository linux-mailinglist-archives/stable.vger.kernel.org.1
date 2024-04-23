Return-Path: <stable+bounces-40771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B058AF8B6
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA5B2A66C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139F142E74;
	Tue, 23 Apr 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxdWX3Dk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46DF26288;
	Tue, 23 Apr 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906292; cv=fail; b=qPUy9nTq3d3ZaJSzLSQG7F6zmSmQu2xcaNxgERR+PDIQr9r3xkW3KgCwONFawOAW83Ny//8uRwSo/3DAAP5rEQoKq+v6AKKmW+9YAgjo/6suDJVSTKRFGmiBRZLFrt0cecQH75Q6foYXuxowmr7FZJCrputj6bpCyzxrINblqkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906292; c=relaxed/simple;
	bh=IX+l8IMKclnKQMx7vfuuzye7QauOnd0GwjsMpnck2uo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivtqzjujmXYwxgHUO52vSu6MfzXxIAKVnrf0HCGxu+KNN22g0eY66USIQK6d36M7QGmkXKnufvPnYQB+fLtAZO/B+h9Z1wqZiBay5JpmV3N1vnC7g9kF7wqATRRpMbSVy6ON/DH+A9UmdAMx1PTUDtoLbPMsoRMA23G3QtgNo1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxdWX3Dk; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713906290; x=1745442290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IX+l8IMKclnKQMx7vfuuzye7QauOnd0GwjsMpnck2uo=;
  b=QxdWX3Dka4IpEgmJPp9e81mHJ5XcxSKgZjiCN4AnCUNZBW6rvw0wrqC5
   W+BrFN46PpOSJZ4LRYp7ESYxiKOmwmDMliXA3oTbNncOCPcxrPBby+Bxs
   BBLWl2cIbOh/MxYVB/r5djgr1CdpG9nhqP7nlO2vpCq/wh5e8+sBYDeiV
   yHGChgN0mtzwawZjbeENNhqQDVVJMXm+3JPu5Lg4ZcIbb+BCKmQRWeyqp
   WahACQRqjEe2N/w89b3EFkw02UBkLAmKQchCnRTsoFEiQaEPHTUrFBmjY
   wdf1VGzVdkgAygA1axZ6eklNMs/53QrriqT2+biuRKl8FsMiYZDBvf669
   A==;
X-CSE-ConnectionGUID: 3+f7eb1/SUyoY6R6TTinMw==
X-CSE-MsgGUID: lF4ykYQvS4SXJTeJ89K9pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13347698"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13347698"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:04:50 -0700
X-CSE-ConnectionGUID: yOSr2pwhS5W6njc5OzpJiA==
X-CSE-MsgGUID: 4DBetV4GQkWnSu4zllvTgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61945286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 14:04:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 14:04:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 14:04:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 14:04:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 14:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/oQjj3WlUFmM0zben3Be8KlHnX1JLVUqdxMjldSfd/bO/wkiLmcvZ0WX6+A1Q8az9lPBcSyn8Dgb0CzMda7lhvgyS4bdlFnoh1F0akUSG8ykahZCjkWSfb5A3Xg0OxerFbdZmefuiVyX73iOt13d/hbTjwWUuePC75zQMTsmKgX5pKmaYbGrbO8d52ABZk9m86QCFlMAT1Uq8SDYqCsoNLN30aYNS2CmfENm8lVqyvi58QYj8neHk8bEdeY4RxRBa+jzjbD4xHBS4pV0hJOE5Zjck+pwM5Pstpe54B15iX4t63WrLMWjvwzcxOFy0GQeFrpnn36FFSSI2jQddSxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u3cNWBs8LU8fA8OLpL7YrMWFR5vj/iMQzXhdUIRiq4=;
 b=Ruh6ZYP2KYnGBG2qPKg6KXVT4bT9vz+Jvc7Rhu6z6MIvbZbxY1L1C3kgQCg05rYQBmcmn1hnE+tHigNj5sWieM8kbhm25j4DLC5TYBBOPWIMeSFVjJtA5DNcaIf5x2tAE6pIZq3sp3OLber6V2wsisscZQbCpZ4cnH6a/BWbGswPPztPrvgWyvlsl+ChH6xtei9D8lj5J6BCQp78urn4FxEyl6hNvlEvfJRec+GqSW9zd2evx57Kulr311zyxwTI2nWb8KwRufni76Of6kvzgO4O6b/y3vxQrHqNMop0MMpDhq6g8czA8/I4HbkBYpisPgAIhg2U78F1gk+HXkgLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 21:04:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 21:04:44 +0000
Date: Tue, 23 Apr 2024 14:04:41 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Shiyang Ruan
	<ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZifzF8cXObFiDiIK@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZifzF8cXObFiDiIK@aschofie-mobl2>
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dd04d2-0836-42d0-a8c3-08dc63d90070
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4efA2ERDxzpgPiM6RDH1jzE2X8BMIodnsVjHVAIMQe4OfckPmABynXzd0alI?=
 =?us-ascii?Q?886NpnTjUjlxtK6Q/1X8QM5n8XNfTYEmimr7299VZgiO7RnDbU5W8K1wZuBh?=
 =?us-ascii?Q?fuyzM4rlbIzll1o6W44580j+sD9HzzeDDrSYQDA2Juy/fp4/UrdD969UobtK?=
 =?us-ascii?Q?R/M99oRmxh1bxx3cpiz6Qfb5SvqWrQgjZ9RgKM9p8RLvHmIN7nrMQsZbEtdc?=
 =?us-ascii?Q?5PTQEMiuAuHt8usnbIOkECiieERB7jCwuy8xExGNriVs/SpwVWc0qJYtb3XC?=
 =?us-ascii?Q?dOKxzPDLMfwvFzDHOJL5M44+X4fQ+tqsOSKPlyX64XtiIS02W6TiEFveZEMH?=
 =?us-ascii?Q?1llYZrvvOZDe8aKiPKVSSknVnx0kgAVon6lVjFzEqMKq2CAOUh/ftMwrOVgg?=
 =?us-ascii?Q?VzvXcA30b+V67lwkLjff4L+J3B8CrHPtNsFclVejMYy71NJxj6mhVEa+x4JA?=
 =?us-ascii?Q?2Je8vXU+hGT7qI1XO07BnuoaUyeADatlRwVQuzwTFOz8ijw5fpOUdYOQjx8o?=
 =?us-ascii?Q?KmiD6qghDRlf5kgdEI9w2m/xa2OBp02VccS9A3QkrUJvx/wyVm1GR7dOcf0y?=
 =?us-ascii?Q?BSj6IAZSYNR+SK+oFaGtqIq5AgD/fBJ2VkHQGlCX33EOKqeIireIqMh5s68S?=
 =?us-ascii?Q?gMnVJimRW0pijIRq/IqFQ/M5bceuQVZQFhiNxeAC3eO6IVAiMWTdPJvbe5E5?=
 =?us-ascii?Q?HS/2RkRUtTql3VdXLMwUzdy9fqzjoXD6iWLh+o/8N9dW4gD0FdXlY4DsU6bN?=
 =?us-ascii?Q?mBPMZiv7GC9UrlnZQpgiyKnYd3IijbTEN/ChKPKlGFkN1cQacu1FCvR0tZsB?=
 =?us-ascii?Q?xcfIRAwLnFz8wVrhm/6GiuEuD0uGeDq3RQwn+tIdVDYUky3ZjoVqJ6tWxS2I?=
 =?us-ascii?Q?iE5Yr6i0YgOSSD1wkEv+mZjBS0AkQSv0sBfCM2tE9ZLuVHesr18NJyC5qnpM?=
 =?us-ascii?Q?IGX/V1v3C4Bs/DT8p6jUC4kP2KYDDC4fQPGAm/1lsMmqLoYr0JXLfbCCxvay?=
 =?us-ascii?Q?7dwB49uHOwL1BtP9dFkJJoUSYBTsCteedUPsbjt7b8Z2U860GGukYBerVHyb?=
 =?us-ascii?Q?D7Wd6M2zULb//SO9Ej62FSqUJ4xHq3jporiJFVkKKC5i7whbUQ3KVt44kNiI?=
 =?us-ascii?Q?H0OhF/A1sGs3m4a12fxNLrD2mxEOh7325TUsfqjbpo/90qY78Znuwv8i7jl+?=
 =?us-ascii?Q?ffofwz98d3vfMjnsryfmJ1NdoaXYjO7A/aj0E4cegDNALr/OBm94ZduNJ2Mu?=
 =?us-ascii?Q?77VxiY9Tpo7+1OUmwVbjvamUkQOVYSJ+pihrWa68HQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgkysDc0j8BA9LsbRaGj4AbZEHt2/cnjOKshiiNtmtcvz0pEuuiFPD/9wvE/?=
 =?us-ascii?Q?FgWp6LIcAtJQTJLBGDHNVzPMXFDSRZzq6KLRlCK/qQLI7Jasdi/cwWxjdZ3a?=
 =?us-ascii?Q?UOQx1zRDwlhacL2oYAmdvwGEZAiAQr+fh9hQioAhqd6nalzxzB91Yg6S16Eg?=
 =?us-ascii?Q?vbTKae2JtnABbdazYSS9DBJ1GhkQJ4TrOjJSC0AUeh1SGgFYltPN8YIKSo3s?=
 =?us-ascii?Q?xkUjkiMzczdP3euQRCiq7o/7aVeVejavg4qsZ10xRXIyRadJQcM2v+Buo62i?=
 =?us-ascii?Q?nVVTWeNVL10XMUgaZ1SB84ieWepISePjnaeObqPqHaYd+Jwj0PLvEPUcaRo6?=
 =?us-ascii?Q?AN9MDwou9sip9TW6rEJF/PmCoSJ4rpDr+BnOwQ3EKSx76EbT9AcJAqJDzZvj?=
 =?us-ascii?Q?FUrMjrTVsa4M+Fqlr8iB2vvQOdZa06AHyNTCS4lLhNlbpoLDGpq4eEF86bzn?=
 =?us-ascii?Q?ZuHPf4rTSbTi/8Zjg8/1ssfbWlBaFFv4IJLD4Oyawr41SmRtS9qU5N7b58I+?=
 =?us-ascii?Q?6ARbYJadlV1+2DhHJn8CkGiAoJ8vHScz9jNIYWTyUbS72gyuQ1/DiiAKj1Sa?=
 =?us-ascii?Q?KyxaXSstSd3mxJviF3FmUOqK/TVcktsESYCasRuNXyKffgQGCLXEr0OUufpn?=
 =?us-ascii?Q?GjOeBfN0TGdU4MYUcABmAzNNZev7deqCkqv5jqej7tCNLzGef1VcR2amMDaj?=
 =?us-ascii?Q?NbLwKk+J3w9xMjZbsHo7mPn+IrcOlIWZLCf82/KwyNG7Y3xWQ/PudQ+7py3b?=
 =?us-ascii?Q?T0yeeuLfh6V8QC5aCdr61jhK5St5rAg3aCZ3WDZT7TkbQXkkUzhDS5xzdIig?=
 =?us-ascii?Q?tfOn/8e9StOdaVd4n04f7xbJithIYNfftKGpftC3yvAn1wwOBSYECd2tl5Ys?=
 =?us-ascii?Q?x/RkXz/I51FthJ+1QbsbufxhBzzw9gAT2U5u1QwRKp1YO4ZNJFPfcYqlOKYs?=
 =?us-ascii?Q?VuUz7bMMjd/9o/YzCQThPncAIaN+AEI93bX2wim7nfggY3JJzdBxslSxd7Fh?=
 =?us-ascii?Q?NwOaPXusciqjK7Zi0pA7ZAukzsiKlNQynKqTbF+c/WnQ+1DyjTXHwDqh/EhK?=
 =?us-ascii?Q?vA/p5hREBW11SA4I+7nBEYeFD+3sdI1AdH+jwm67zio3sqjol0GYZLFxf5fn?=
 =?us-ascii?Q?RqPMCup/GjTczjAm5iGrMiMMpwnLuSGoNdEwHexHMt7ygJV8++K3XbKeLekb?=
 =?us-ascii?Q?qM1xzGGblmKscFHQb38liCs8rabOVvkw5/cS4HgIt2KZwM2/h3LrGSuHCTrD?=
 =?us-ascii?Q?8H+tzJ5ThYKGjNBD0A5ULfbaDVzGrdTXLUp4kUQVKtTJhIYbR1LdkyhxTz1O?=
 =?us-ascii?Q?VXMzmziYT2jAEexd7TdOFo+Anmh/c0dMXRW4iMjaqBwXgeSDJSlO2OmLDRXl?=
 =?us-ascii?Q?P35X/lh3oOzb6p5fsZPl+My/DFxS1vDAwWsK9Uf3hvhT7xMVyWfguooUxNOp?=
 =?us-ascii?Q?qPj3ETmlPb57vDGuOE2diLcaJub8ZBA9dU/HyWOCAcHal3IczXfXhEMczXBG?=
 =?us-ascii?Q?JLLBr5TJhLaHgbLsmDQ5+UgJKaPzeLM4+dm1qcs5MYBtmpvPIoAr8YGX8swR?=
 =?us-ascii?Q?L1ZiiM0nIHc7dpAlQGxMedc5t53cA2q/iuSNMV0p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dd04d2-0836-42d0-a8c3-08dc63d90070
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 21:04:44.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhBvsqsfesFhpmbLRZFWrQ8wq8VdHXJ+Da0dpCge7AgkLHbHUP7v/FCo6iLawi93eps3wnCm3s/q8SSuWpaTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:

[snip]

> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index e5f13260fc52..cdfce932d5b1 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
> >   * DRAM Event Record
> >   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> >   */
> > -#define CXL_DPA_FLAGS_MASK			0x3F
> > +#define CXL_DPA_FLAGS_MASK			0x3FULL
> >  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> >  
> >  #define CXL_DPA_VOLATILE			BIT(0)
> 
> This works but I'm thinking this is the time to convene on one 
> CXL_EVENT_DPA_MASK for both all CXL events, rather than having
> cxl_poison event be different.
> 
> I prefer how poison defines it:
> 
> cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)
> 
> Can we rename that CXL_EVENT_DPA_MASK and use for all events?

Ah!  Great catch.  I dont' know why I only masked off the 2 used bits.
That was short sighted of me.

Yes we should consolidate these.
Ira

