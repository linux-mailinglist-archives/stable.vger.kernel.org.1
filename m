Return-Path: <stable+bounces-87786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B301D9ABAA4
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B7228475A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD717BCE;
	Wed, 23 Oct 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1XeOplz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB72D047;
	Wed, 23 Oct 2024 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644401; cv=fail; b=LwC1JsXCfDh1BCcwXAGwqC4JcLGkWHlP4OOPHnaay/QCAhYrrUk1IOl1q17GTMdIeRP11sBkCyQMP36WXyb+4ex4vnICNilk6FyA7znD9fviTvF1sYoBUO26o0yLl9mgn3u0hwy1cTSuzgHNPlyVkBIVjJYna6EHPnklK0oS8XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644401; c=relaxed/simple;
	bh=UVHg1Nwgy5y7NdZMCZWSlvs0W+XAAPvkNol0PG1omA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flU1jiis3QJn7CPylG0zsHDtGBZ8+/WhIhB5YTioTSxVKi3KnBUMQ+nueUOku4vyJ0je288FjIjePwaSKkbA6hFALHXqaZ2m499t/jShJvkKQAhSZR0W3/YPGu82SRFI4yr1x+0HqyKmG/QA4k67M4SG511UmcpYqUWA0nRFRHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1XeOplz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729644400; x=1761180400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UVHg1Nwgy5y7NdZMCZWSlvs0W+XAAPvkNol0PG1omA0=;
  b=a1XeOplzavfGFai5mnDPyJ7KBKc0MwyXHzdjQvw2+wN9/KNjsEeSwsFf
   kWvGHtOvdxIGKkw7CNB2yLXb06un6lsjRIouu4XrC+Q2VMFJ9mO17Nlng
   y2PS5gd+2gabMwttl+OMLEaq4mNAVVEWpUtrlkNIMvB4uk4IYlWnAK0AQ
   mHIlp32BzDGzvwne1NyjYpRjcEG/cuqGGWotP5b55tz+wgxf5d8AqpGQw
   o1IsOWRw6wKRu9r5km/80SOgXQmbVoFyNpSDU8LG/L06eexkGaLJ4RKAu
   QN9antqneVEyq3Wl5b8FndfCZrCdTrgoR35t39zBNBgYXmmY/EMSIL4Xq
   w==;
X-CSE-ConnectionGUID: RBEWKD4jR/qjkFFgN4M1qQ==
X-CSE-MsgGUID: AYmD4wekRYuiRNoGYsk2Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29089218"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29089218"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 17:46:39 -0700
X-CSE-ConnectionGUID: 0dFTtp2gTB+1b09o477LmA==
X-CSE-MsgGUID: 3OlQH2pURvOxy25u6kzrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80109967"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 17:46:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 17:46:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 17:46:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 17:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsAun7lXj6uAVho6M989zfOdPYzI1tz+NMvaqlr5xSx6tglW3OrVWHpCkyzy9wFy3Rly2rFWWeDfCgdFL7tOTDi0VHgRWa66RoF7KKl7fS/MUsaUcMazPPKXwzzLdg1iDMySXTnmEJuywtmUxyojzmqGetQl6Upb3TZLYSzuedxrnl1cmFkp8bmqvx8B4OLMGZZ5jYUTBMjdgQtpO5qc7OAWGt+xSD1zqGdmuzZo910LjDO2oWzYsnkbisT6AEdPTO53KA1XcYxnu9W653UQhNKdcCtMJr5RjmduL7yiCvhsJE0EpIEVx8q+wOoHQGP1dGiBKVxikzpcWekK4JB/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owbatsbKZ+aT5WLsTrDzvchB0fozbJQN02wE4vHbL/g=;
 b=CJDZ1986hAvW91frThmmjP+vp1uxpFt8EUp3nXoSd3JTqYQKiGZqd8AgAj5zg6fn4SAhC+qO1Bt7U+W1daeEFKxr0Mdic7WHvDpDWGJx9MphECWhHnPpmlHX6wWtfYjJPdUdCqLY+wGd41ggIjBbhB3hbBzDinJGj3Gh7JCXHgxDCQdzQab/CHcuNC/0qtJL9HPboWCFATEu0UsoPTJma9uAD2zuNM/OAA9wMTcmxwD57cDeT8FUz7PRn71DEColm9XIWqi8bQealcugXWf4k3xyoUherOu8BhbTZQTdl8Acg5j+FArrO0wNA/777C67fIQny7bNJmb/+IjEIr3dOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 00:46:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 00:46:34 +0000
Date: Tue, 22 Oct 2024 17:46:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <stable@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Message-ID: <6718476768c49_4bc2294c8@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
 <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
 <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
 <9a1827e3-1c55-cfbb-566f-508793b47a4a@amd.com>
 <670e9a2db6f4a_3ee229472@dwillia2-xfh.jf.intel.com.notmuch>
 <c54bb2bd-ab12-1178-f18a-6925bf3d4f8a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c54bb2bd-ab12-1178-f18a-6925bf3d4f8a@amd.com>
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: eeaa50ab-e792-4fc5-8db4-08dcf2fc24c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yr67FxFz4749ex39eoojX+l+AYFzW12+UaaaPAIBHnGy7HK6FI5170rYA4t8?=
 =?us-ascii?Q?QxFsDKCcKX+yW+gYDszwUw9kHBhP09sae3HZ2rMKHtLSdaLnBFs+ypU+amg8?=
 =?us-ascii?Q?TDHRPtXejHR8QXmNpL/bypUo+Q5fZLn77yz851c9ZVk9qYJbaVAMe8uuwyub?=
 =?us-ascii?Q?wZ0PPcs+b6u43sHNAc/SjKV27IqHyBuTBKiYq0HU6B2v0u91StxSOGwzuup3?=
 =?us-ascii?Q?F3pet4ywasql2XZH5uVwabkmUsxgcSyFy/OgJv90ivS2EKGxXOpFWf8I6yUj?=
 =?us-ascii?Q?uj5/ZE/8F9eKZzVgWPoHHo9W/zB/jzLA3PAL8Ttvx0pC/OqoSEuqOfbKfkx0?=
 =?us-ascii?Q?O1gmpuFQHtjJo/bTc44Zyrt+DJO/9XZ9Ytw+ecF9JDhwj1Qc6RDOvGkvq0Ws?=
 =?us-ascii?Q?x8H6jhY+FF42o7/aURLkY4qLnuIAh/h2m0gc4NIGuAsBripPrzXLc+5boNxC?=
 =?us-ascii?Q?nEkWKDG727JwseOVfvA4TIcnuyJbjn+RwBFP+Q+6khCCEQqNsbMJP1ig6DYm?=
 =?us-ascii?Q?vUy34CbFSX8ZXTWRdx25Lu8vdby8GpGjiT+jMH5oZFzKclPKYE/QzWLgRShx?=
 =?us-ascii?Q?MU5zogejqYiUtNq7ZEm16bQhErxClHLSPmDlKSA3BnOHWWYvJ8l8vbXIgaRs?=
 =?us-ascii?Q?E359p6VrW4LQk843gV06JJ7M0O6cKoHItTKrUoT5KH+soiw9c6HnVjFq1n5E?=
 =?us-ascii?Q?Bv4NlDM2cWaud0ZHT+f43vrmpd2Y+mZXIDK7GIpBEzrH2vyPxqM+edUcUDBo?=
 =?us-ascii?Q?dIOn+2tBDrP8OhuiAvKoYBGDksNT5sw8rPzmxRkh33jinZeXd3u8Y7Ke1tEg?=
 =?us-ascii?Q?zCSAGuFZ8BffO2MLY1OYFbFxGresfTHceVRSQNXxyJJvu7fctb+rwzcKOJJn?=
 =?us-ascii?Q?SDaoUsYfj5zf7tsHyD1rzSFfQ1cc+4gHenjog+CGC1OajNRF9HIAff0GAk0s?=
 =?us-ascii?Q?BstVJceBZcuj4IHIfP5bsw8ma886k2wbwpMPNbJUe+riGKHB6UsHARSOngqT?=
 =?us-ascii?Q?8lGUuNOFlr6v4sGgITiIMptqx6CbzIX77aboYimwgq8Gjs+oKyu5EEQNlQ4o?=
 =?us-ascii?Q?MroM6VuTj9WnfGUMk3qvUVf38MjXkxKjYt9dJBHMvBdvFuZkV3+8wqTRBiCm?=
 =?us-ascii?Q?T97XBiQdH2iSQO9cxqvbAn6fDd8TISYEn4gHK0vwFm1QZyupBXpsbBRpa7j0?=
 =?us-ascii?Q?mA/SJGf58lesvvx+SE8JTUUdCJwmT2PGpfMeYvoAXac51Q8M+E0SSDkMOl7o?=
 =?us-ascii?Q?adyiiWLhzQzUBhMVuuyG2yQS3bmIhxVbpcSnnRslqTITFXjNcV5YUC7vMAq0?=
 =?us-ascii?Q?sZmTf7s8ouwTfAaqNORUJ+kA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jt2Ic48Qv7dZiyWgSeIySEGmSKrwr0viMpoWelU2Wu8NtT7de+8tdi5HV9DP?=
 =?us-ascii?Q?H23jG1xmkjWXQukCMW13RryJgP4Fp1x4p5gY3gVnIp2zsdO4Cc7VOaWyGhqu?=
 =?us-ascii?Q?Er79qpzI0CDAaKwvpCqIMYOHQbBITIVcTHIBjlXd8X2iPItMj6u3qxnhtQjJ?=
 =?us-ascii?Q?GUm0p7bK9gdTg/1A5lLUbr+t9tQky4zwnSBXtlyeM+UV1PH3g2uVmpVe0wj3?=
 =?us-ascii?Q?JHW6R4yrXGlsLSmpVLo0tyKMvFYZkHx/3eby8Zp01UFxffQZ0XRB8S4DGPX0?=
 =?us-ascii?Q?zUllGiuc9zqaGxKBCGOb4Ud2U6vSOCfzm/tkejEj32ff5KKNIVO8nfd99xzg?=
 =?us-ascii?Q?5YlRJBaSR8hzzzB++Klsf/wUGlymDI1Dizut4RTPegtG6S0uo+qfPykM/FX6?=
 =?us-ascii?Q?zCoSup2rUwUVvnnTBgaIKpAccllzgXP74KLKOGd/7/iKAB5gqVbmnaTzL9Uw?=
 =?us-ascii?Q?ij6OcCoMyLTdpVL72y1IKHvnXEBaj1USrMEg9RGXSGAAII6FhMHm/gcKazjw?=
 =?us-ascii?Q?7KRkboVd0BIhpFkOAlb5lhWNjnGyK4zGqvefzSAL+w6xquubEo+E6BPvJANV?=
 =?us-ascii?Q?tSIKP2At1I9W/4agxjT1jTMn3r+SVznB4lKTEEbjbPKpAA+uDghmdOQkjjbZ?=
 =?us-ascii?Q?BC0SLUHG09nCfgSGOvAw6mCF4RfuMnIVDUHVgqBfdxtvSW0a0w7DuwzIFW6I?=
 =?us-ascii?Q?gXv4dyimEYonyQqApuf/aXzdzVNV3JmmrG6MLTuIJCrNqkvCoaWBTchRcv3l?=
 =?us-ascii?Q?o3lLAo7R5+2yLkpKnnERNl+sGwy52ouscCgMbPxaMjT9yqN9fqDYEW0QfR5+?=
 =?us-ascii?Q?QNt38QOVL7Uy91NXYSLHGnvqfzMXuZeeacPJeij9JtB8O4yQhTtdShhxUiyl?=
 =?us-ascii?Q?nD5BktpxLJwWW19zEM3OnU5j1LIYAKjbOSnurEFxv7a6dfsba55bXrPNCKdG?=
 =?us-ascii?Q?xOT5Kp5CCkbZwVlr+kn9Mg/XTlaiGcT0WVa/aeUm0Z4Kx89bOtB6e0wl39iG?=
 =?us-ascii?Q?tbMjfskcV3yQoWdgSHB6hYFidXKAB4QMw3g7KCdZKu1bF7IhbzuVPCqDryTW?=
 =?us-ascii?Q?79BEmiiDA52DU0Et3w7s+UuJB8obXZ9J2Gq3sVGV/TGQhKp9F1RXmwUpHyok?=
 =?us-ascii?Q?V5jCVRIzsrkEOmykRR770PtFiMUxgxjsfDt+lLgcvfjMxPkgW+n0F1c71PQp?=
 =?us-ascii?Q?EKHXfoeX2L+novD0tfOa42zslCGGHfVtOIEl9UL2Z3o1Csu1tsY8uFwUpHvZ?=
 =?us-ascii?Q?8QICVOpznK2lRgG3Fydr79s8tuzLHVBSqV1j1XTI31A/YXfBcoaSS2gvmLK9?=
 =?us-ascii?Q?pqI3izjnq8lEqVud6lkT/Rzi06A54tcdxoZBTMgJdnU/yUPnggRTw6nmLUpO?=
 =?us-ascii?Q?B0uBYaqfa3kAXGEnJ5HoxfyrLYwaX/KZ6jTbSI2ZuZgCjfzaahKjLr32uPNA?=
 =?us-ascii?Q?CWqlP6zWCoKeWM25wC+BdSDz/JgGUtW1gm1ndrKO2TYnSXxMPeyuWa3W6F40?=
 =?us-ascii?Q?dO7+MwGuyK49AF5tvoWnWz9QAUZSrZEM9/+8lHm2Arqhrsl7pYpr2UzyszEh?=
 =?us-ascii?Q?uO2EkJa21SvOMf0+9YdSCII2TBcQFhlT4iNlDzAMJLsIq8pBce5QUVLwud23?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaa50ab-e792-4fc5-8db4-08dcf2fc24c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 00:46:34.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiZeZaBVKurqr+IoU8zhaX3W6OzBMQa7VFmJsiVZIpCMxIoOkaKWaPWKdj7132K/SQfxOWIjE+LF4+RXaS6pFYvWfL/iOr7HWB56dq/R0DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > Setting @memdev->endpoint to ERR_PTR(-EPROBE_DEFER), as I originally
> > had, is an even more indirect way to convey a similar result and is
> > starting to feel a bit "mid-layer-y".
> >
> 
> I was a bit confused with this answer until I read again the patch 
> commit from your original work.
> 
> The confusion came from my assumption about if the root device is not 
> there, it is due to the hardware root initialization requiring more 
> time. But I realize now you specifically said "the root driver has not 
> attached yet" what turns it into this problem of kernel modules not 
> loaded yet.
> 
> If so, I think I can solve this within the type2 driver code and 
> kconfig. Kconfig will force the driver being compiled as a module...

There should be no requirement that accelerator drivers must be built as
modules. An accelerator driver simply cannot enforce, via module load
order, that CXL root infrastructure is up and ready before the
accelerator 'probe' routine runs. This is because enumeration order still
dominiates and enumeration order is effectively random*.

The accelerator driver only has 2 options, return EPROBE_DEFER until all
resource dependencies are ready, or do what cxl_pci + cxl_mem do. What
cxl_pci + cxl_mem do is, cxl_pci_probe() registers a memdev and then at
some point later cxl_mem notices that the root infrastructure has
arrived via the cxl_bus_rescan() event.

Note that these patches are about fixing the assumptions of
cxl_bus_rescan(), not about ensuring init order.

* ...at least nothing should break if CXL root and CXL endpoint
  enumeration happens out of order.

