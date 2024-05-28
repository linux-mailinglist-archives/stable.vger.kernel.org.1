Return-Path: <stable+bounces-47522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD68D1138
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A341C20B63
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260D8F49;
	Tue, 28 May 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjcU4fRq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1092944F;
	Tue, 28 May 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857870; cv=fail; b=ivUin1Q8/Xetw1Qe3d89/yoZpsZyCjTR6weK5O9zdCz8QuG3LQOm8W2etSVEuxx5aKtzKhssWVCj5KxHiKVJWWTfih4o9YvvqtItN8WAWwr7arVZTh2Xgm5AJ5EEpkaGzM0s8OFgwoguL07VajEur/AQS5KblXiVh40hR2WYwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857870; c=relaxed/simple;
	bh=uYjBwmO61CHWnfusBY6VR9NMnxCFHJuF69jQNbItHls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ok9ET9t9qbSCaSLyCE/xvd2b25ARgjdo/Y5RB63cZTcMkvipLUoIYh05VnexT25DduQR/Re+vhhTZcUOofNsRzTcEOYIWZYSY9cEy81NPuNUR3gwVt1shaCoxDO6XOOArpr5fXYDBXwhYPzx0NAX9+YkwgtnzucWDNK4oPgHMfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjcU4fRq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716857868; x=1748393868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uYjBwmO61CHWnfusBY6VR9NMnxCFHJuF69jQNbItHls=;
  b=OjcU4fRq4bhPpsbqMph82gV1YlP8VpvdqKXIx559JWgFhiSA8On6AQfR
   INUEJJk+rcFNlLaAtY1fvbSIfCszh5P55iSFesmy6FFPTnc3fRUhF/SOS
   s9Meh2DSlmtwJMuy2HhxcUPDTyEmNvaw7P9BN1mKltpAQheWVENDsHacZ
   VSKWkwsna5L/OkOJmPzJGxqddvFmrh7bdXE4evT+VEwu37e5bDJQPFAKs
   DNdqxsK2qL6X+jonvRgtbErs4iMEDPhlH+Yj45tRIhHROwSoFUhJ8b99e
   x23L+7cykP+EGsGwN+bE2b2/f7OMUTP1q5FHWm3IJdMOTI2rd7PCmHixs
   g==;
X-CSE-ConnectionGUID: qNgCoZXOQE2CnZAcmhs1ug==
X-CSE-MsgGUID: iqUjl0ggTgiiD8MOesS92Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23740106"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="23740106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 17:57:47 -0700
X-CSE-ConnectionGUID: 2slxYD4VRS6xUGVWXyA62g==
X-CSE-MsgGUID: DsNN/V1kR6KeETZ9st6uaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34915536"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 17:57:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 17:57:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 17:57:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 17:57:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 17:57:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffQ4Cvcr5woa3Ik2alLx+OXZtySmerYAXAJTnjbfRQZKel5RCRkgWX1VKFJWuZi6F9OgAndRZjKIIPw6IAJXsWNrOMgETbkIzuY368mmjqiHgrzlspxQNCjtSLYCUArErTDHlxSfWk7OEXrCe9gGpzeMXsxrCa3JMMTY2cxhRG1U3WbDnct8vCOidC48MBtFSMRQJUwQyFjlIrWZ6xUqTHOtoqZRbzo6viBPpDekrqZiMfgCtj0oxQFEofMM5adHGGe9vwg1FgUTbhH88d9vC+92NyISStQJwFvlOoP6bZnJHSrezaH5XWqqJ0KjYLU+Xj8ZZuc7ilKipY/1WFGcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjvcNLITlvTWH/Sf1A3IenDRW4BY5/0t1RR1CnhlefQ=;
 b=LxNUE2fa4NYFeOW9ImIRO6FgWx+Sc1MoQC3Ldhwf+0Bp7eqGuN/q17XxByhb1KFDSkuRvjy6Fb2qC73qgYptB31N0aBwIT55lu0upmH4HaS6FmTyO9f/gbDl0B+MfuzVh1kMJx/cIlQObcpChx2a/z7Hpen2FJdorzmjuzsRxjdnQWi1L65yKwhmoPpDFAxm/2ecZOgzHyK7ZTV5t41eBe5k0svytzhttkIA0VDvtZ2fmbpyeAE8WkBHnaHTPlkjfhukHmm2/41MjyBLspohBiwvfG5QulhE+w1dN7uigI/g+r2yYRKA79/YQ/KtiH/iL7H12kd4dz/N/3LHC4eSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 00:57:43 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 00:57:43 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Yao, Hao"
	<hao.yao@intel.com>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH v3] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Topic: [PATCH v3] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Index: AQHasC/Q78OsVQzYU0uj61RhUE6AtrGrhy0AgABMHjA=
Date: Tue, 28 May 2024 00:57:42 +0000
Message-ID: <MW5PR11MB57876C1C77CBF5D1B5D9F0168DF12@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240527123835.522384-1-wentong.wu@intel.com>
 <PH7PR11MB7605CC4C866718D28B5393CEE5F02@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7605CC4C866718D28B5393CEE5F02@PH7PR11MB7605.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|DS0PR11MB8686:EE_
x-ms-office365-filtering-correlation-id: c4aeb456-572e-4b7b-c87e-08dc7eb12e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HdtPglTFWTYQUx8ZIfvg/KQ+js+BaR9alVtInakJBdpH3ELrX1J4wG5JvgKW?=
 =?us-ascii?Q?14cZm4yLum0IBxdGknNT6fVu8TVc133RZETM8+5YIq75KwJqd5T+Tp8K2hVJ?=
 =?us-ascii?Q?jeBP27XyPoze9bK5Ea803JYBN4zCXxQ9ToN0kH4jnrBWsP1K5MaWbZ3rx+Oa?=
 =?us-ascii?Q?/nbolm6b0V/4MQGUqHCDejNDsOgr70O3/wXBJjTB2Gj/TVjd1JHffXU1tuzH?=
 =?us-ascii?Q?NeKnDzN2wx2WpW+AlxWhmyyd/j71ZGiSk/8Y/0DNef6cCUuBDnTG/hUDbSw0?=
 =?us-ascii?Q?aWbQmoZx/AcAnaC8+jPuaH3APsSXutx7SFprjeVFLScjy4KVOhyxEf62cpUm?=
 =?us-ascii?Q?0DrtjMauOkCawrYxxv/L2tf9S6mo1OW2ZvOXHim0fsyJGToWKQJaVZVsVoSU?=
 =?us-ascii?Q?fejq6URBIkVvdhu/2LZ3hXRD2fPOrpyNMf41Ed5RbeJNG3A2vhZtE8i8436w?=
 =?us-ascii?Q?hNuBv8il3NqcDI/oj4R6ZesOWmPoX0sUFl0Xx0AtYyMbjy8oTwsGY5YTqMkz?=
 =?us-ascii?Q?Qdhxul+jsxtWCPLTgqJwocZ/FWoVP4sO+89Yvt+/oueZY71uK34zPgiGvkXV?=
 =?us-ascii?Q?cHQqNzi+gkNL/CHN1z/YtZOAU1feRHscGPwiN+XRWbM+vGKNgQPRx8vaGnVp?=
 =?us-ascii?Q?qM16njZoba3eSS6PRHddU0QNT7GUeh0CtzpBBNEL7XP8cXAZf1WdnHle6IqI?=
 =?us-ascii?Q?qxJkmKVoPxPEz+2zOPuviFTUvRBkIW2YOJfIVagRv8m8+AKpLa7qVDM/ML16?=
 =?us-ascii?Q?/CH7jZFX/evqS5JxE1Yoo1o6W6SePEcZJtKmaJCqzeITFj7MpeoEFymSIDOM?=
 =?us-ascii?Q?Xxch2I9MrapsAdK9HO1Bus7P+7eQFcv7O6xOefeCUlfK5BXJS70CmKiaaUoZ?=
 =?us-ascii?Q?5C3EmwAxZ2VKIUiZmB2MonRfO0sjD+qoNVE7kbj22s+ADLajCiFi3dUqDEk7?=
 =?us-ascii?Q?0PM1joRbs8n46Tjh5/rDGhJ69o2MhFbnLWtPpmvLLpD6rtCi9MF54ssOeizo?=
 =?us-ascii?Q?y92+RVil2f/wJIVcG3AqVz5cqp4owR/wJ9F1MtrlxTxkSxlcExYGR8kOLCZP?=
 =?us-ascii?Q?abZXawseF6/G1CrYs7Pzm/KxaJJ708eazVfZndTIdGAcIeApOAWs2DykM/9+?=
 =?us-ascii?Q?U0Nz2WxVru/WqQzK1UGH13EVR2Y8oKeccqkOoLwDM7EGCPBAKwaOgEPFNxc0?=
 =?us-ascii?Q?0hm/v8RLbJVO/1MhKCzCwTqexeUtdwhPdfZSQEdNE4Wy1nj1OEjsP1VLeZsI?=
 =?us-ascii?Q?e+jgV4H8+YtJECghv3NaUDY0rSuIwkN4KoSWcC9D5Ygy7fsnle8JBgDzMxEU?=
 =?us-ascii?Q?4yWw+5sD6HvPqU5fQcFLxZ74+cjGCKUbFMzfc36tqu9ZDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHAA7DctRK3ElYI409VvCSmWKwfTXhHRJtMHYNKYiWmBG6zLyrRdR9uRGRGV?=
 =?us-ascii?Q?uXis7or7vnXU6IHWqKWwAhVL0iFbqYDNB3iE2zWSTqceer6HansXDkG2iSiJ?=
 =?us-ascii?Q?4Ok+omdzAsiu/r+Gupekd+bRkhgKuWy2ursH3jlaCXzdyTsuKm04uJ/iWlBX?=
 =?us-ascii?Q?MsMcwt4gs3dUV9AaC4Kp8Gj/244EreRI2690ABan6gSxNtfXWqJVkE7gwU+d?=
 =?us-ascii?Q?qDjw3+873f6ol6SOmSDiZ2rUrqg34UOEvEcLU3qePqpigmMT8qkM+xe7KOzD?=
 =?us-ascii?Q?Rb53og3TRf9tcezx6o4CSgwFK9HVSexRa3w5fahyo+6Gz4mR+wkofL4PJu7A?=
 =?us-ascii?Q?DjqvVQ8qAISOZVQvpliB10o2MJwDCg0rMxn9taa3DA0QWq1nN1DOjuMSMwZh?=
 =?us-ascii?Q?+XiXFtnaJkqjkrzzRd6vb98khtwX+ibz18JOgndfAOgJQqNJmwkoWVFbZ0yc?=
 =?us-ascii?Q?jPLNqhkqJFzoXaYjFNxMAESN4y7MNhOdy20BZXNRHeaYpHZ6n+6mc9AJVEWW?=
 =?us-ascii?Q?DiQ8s8CtXTW0gEf35BX2yv+XE74ycMe5Kuo+Ivk1XiPiZnljOHRXNrkiE+aP?=
 =?us-ascii?Q?EeoQknV03niwIZxY27BVr/MybtmT4WCS7y9N4U2c/natgejjihnBF6JqY22/?=
 =?us-ascii?Q?FrkBH1R3O2uy4LMkKCpo4dGVn+zgfpyJhL+dVMl8IA1Jz/9pbsY4WeDEBvGu?=
 =?us-ascii?Q?pPIyxx7G+q9EfuqBTS8d2iIMRKcJC/ILUH0ofZ7MrlXPm2eBg7LdPOquBrfo?=
 =?us-ascii?Q?+UeMlYC2VEdDoZIsI7bokvMlM3rdx1MktXtAln7HccvUYSi5qcAHtMyukT1s?=
 =?us-ascii?Q?14s3mN2CnmyjIHyZyR8LIb8SbEPGQXAT7e/h4Ayjj8bflR+TzFc/Rkt4nE3z?=
 =?us-ascii?Q?s+wumRoTHZXKDmnFOMxpmkAaMbTy8d6D4y7Sn5GamTtZWCH2QLJuSn58WIXG?=
 =?us-ascii?Q?aKKuI6y9uX1JqiA3nEuGG11ZJe4IILRhy/xnW/SS66rDTRX880+odCnusHB4?=
 =?us-ascii?Q?CLbtRJy1r98MkySXjnzqLbxaA03bej49LlWeH2dFeYCBXHCYM27GLpNaIMVS?=
 =?us-ascii?Q?CdqD7tmKpX4YOBGqbR0htwaoenY3PdgwdMQOkWsKFcxnDZFLkqCCkZG/DfH9?=
 =?us-ascii?Q?LCDFA/7qtVxB9/m7PZGoCsVXWwVRM2cF35ZTPdDjOcuOv1GEtdQ9r0xEPgg7?=
 =?us-ascii?Q?fg93kRI/BP33IeulHJdOnA3cSdYNENvmnSEO05LkYGn2ONJj3XZ4rRNu3ecd?=
 =?us-ascii?Q?yqFPZNXAFqNf1OnYrUp0rpuE8ipYLQ/CdodaHZ7p6a1BO3rQhE8sQeENuw62?=
 =?us-ascii?Q?EL/fzrvZi3nSsc1XYvWaQZII3U7TYk4+nK09Ienm/O1wvHa1Bd5B+qa4Mf32?=
 =?us-ascii?Q?e3bclq5y23Oo25oHZ2aO1MO3jSQqWu9KdzgctyGszQCI7sruvHfX6H7KwjRx?=
 =?us-ascii?Q?taYf0ATe4H5XN6AbBBB7Z0yuUop1qk53pvKQ2oB6fUM8bModyU7z1gBJZBPk?=
 =?us-ascii?Q?mtoLSvxlkT3X1pBf0R8UOffRSLXNHQhI1kXAFfbSFOChmm4ZLeK7WxrxAr65?=
 =?us-ascii?Q?xKYIz4lzaCaKoz0ObCu/qdhiP9YFXQOTqlLPYrDf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aeb456-572e-4b7b-c87e-08dc7eb12e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 00:57:42.6496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9uw95Ay4MrtIZBrd7Ru44aaYkTnkVf48rh6JD45lBiiQumBModg78W8mfPPIhnAPF/PSUwsCn8tldr6ZreNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com

> From: Winkler, Tomas <tomas.winkler@intel.com>
> > From: Wu, Wentong <wentong.wu@intel.com>
> >
> > The dynamically created mei client device (mei csi) is used as one
> > V4L2 sub device of the whole video pipeline, and the V4L2 connection
> > graph is built by software node. The mei_stop() and mei_restart() will
> > delete the old mei csi client device and create a new mei client
> > device, which will cause the software node information saved in old
> > mei csi device lost and the whole video pipeline will be broken.
> >
> > Removing mei_stop()/mei_restart() during system suspend/resume can fix
> > the issue above and won't impact hardware actual power saving logic.
> >
> > Fixes: f6085a96c973 ("mei: vsc: Unregister interrupt handler for
> > system
> > suspend")
> > Cc: stable@vger.kernel.org # for 6.8+
> > Reported-by: Hao Yao <hao.yao@intel.com>
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Tested-by: Jason Chen <jason.z.chen@intel.com>
> > Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>

Thanks
> >
> > ---
> > Changes since v2:
> >  - add change log which is not covered by v2, and no code change
> >
> > Changes since v1:
> >  - correct Fixes commit id in commit message, and no code change
> >
> > ---
> vX descriptions should go here

Thanks, I will follow this going forward, thanks

BR,
Wentong
>=20
>=20
> >  drivers/misc/mei/platform-vsc.c | 39
> > +++++++++++++--------------------
> >  1 file changed, 15 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/misc/mei/platform-vsc.c
> > b/drivers/misc/mei/platform- vsc.c index b543e6b9f3cf..1ec65d87488a
> > 100644
> > --- a/drivers/misc/mei/platform-vsc.c
> > +++ b/drivers/misc/mei/platform-vsc.c
> > @@ -399,41 +399,32 @@ static void mei_vsc_remove(struct
> > platform_device
> > *pdev)
> >
> >  static int mei_vsc_suspend(struct device *dev)  {
> > -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> > -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> > +	struct mei_device *mei_dev;
> > +	int ret =3D 0;
> >
> > -	mei_stop(mei_dev);
> > +	mei_dev =3D dev_get_drvdata(dev);
> > +	if (!mei_dev)
> > +		return -ENODEV;
> >
> > -	mei_disable_interrupts(mei_dev);
> > +	mutex_lock(&mei_dev->device_lock);
> >
> > -	vsc_tp_free_irq(hw->tp);
> > +	if (!mei_write_is_idle(mei_dev))
> > +		ret =3D -EAGAIN;
> >
> > -	return 0;
> > +	mutex_unlock(&mei_dev->device_lock);
> > +
> > +	return ret;
> >  }
> >
> >  static int mei_vsc_resume(struct device *dev)  {
> > -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> > -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> > -	int ret;
> > -
> > -	ret =3D vsc_tp_request_irq(hw->tp);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret =3D mei_restart(mei_dev);
> > -	if (ret)
> > -		goto err_free;
> > +	struct mei_device *mei_dev;
> >
> > -	/* start timer if stopped in suspend */
> > -	schedule_delayed_work(&mei_dev->timer_work, HZ);
> > +	mei_dev =3D dev_get_drvdata(dev);
> > +	if (!mei_dev)
> > +		return -ENODEV;
> >
> >  	return 0;
> > -
> > -err_free:
> > -	vsc_tp_free_irq(hw->tp);
> > -
> > -	return ret;
> >  }
> >
> >  static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend,
> > mei_vsc_resume);
> > --
> > 2.34.1


