Return-Path: <stable+bounces-89123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C99B3C02
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 21:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9522866C0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A51DFE31;
	Mon, 28 Oct 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xg0Vzr8+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F11DFE38
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147942; cv=fail; b=RpkMEKqoJfIc2/aOPl52Ia65QmF0zG06VZVvUDVd+4kNmy/PY5NNZF3wX9Ggc6USH/BK099nKNnK9/J8tYnVjywd6LNX1jCdL31pO471HxQzx400bFSmzMcw+Avby8Fz3R64ttVvPipefe/BJhkOxFxjplHaolnRjK+REqSIgTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147942; c=relaxed/simple;
	bh=5n0lgQz7mQYlkckpsrdVr7V4NWHIWNUrMmQy15WjgfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sL/XNQRxSGfeWlCXVkp6MKoWGDzUzAlXpYOQg2McR/qNVoNqAlY3f+Ty71/YZjWX/ilp5QaRNJbDbJfvdowLCtRGDQTyr5bKb88z/9TZYc6g6XYYP4I1jAvCAIgOp4qOiYiHdSz7dxD5k+Cg3sU3f4lG3y0gwW/rOAcDSDG6KpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xg0Vzr8+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730147940; x=1761683940;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5n0lgQz7mQYlkckpsrdVr7V4NWHIWNUrMmQy15WjgfQ=;
  b=Xg0Vzr8+PfjucSPBPtvSF2ww/rJeLG7MOy1X+JXR7Z3hmn+R7vESI5EH
   mZIreg1OoyRJwag/poypV0h/9GnhgihFOy6w31+9tqlRVeI9Y6/La9CVU
   1E23Xu8DVtDmmGWNZU8ryG7B1foOvDBfthho+Ji5D0ZMdMuPMi9sL2yOh
   4BEHp5McG6bwjqnL9ARtzbnRsN7FomQl1ouC5I4uMC/aUMtHVPQewtY9f
   Dd41pYbtkLoEVC7Y48GHDJZpfYTRQlhJply6E9pvkaXWrWVM8nP5blxLN
   aT6nXTs/lFC3lFCM/HXO0y/DG9ZmbJVo3AGXcmYL5LDlsdMP1Zh6cwrK3
   A==;
X-CSE-ConnectionGUID: +B3Z/lzWSsuLWsByK9awDg==
X-CSE-MsgGUID: Ki5xcRdNStuCyG1g+5vaCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33684520"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="33684520"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:38:59 -0700
X-CSE-ConnectionGUID: wq2yTlxpTbqngZ87LGEIrA==
X-CSE-MsgGUID: rsrVEKFQTaakFrGWpz1wtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86528196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 13:38:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 13:38:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 13:38:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 13:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjbzmVzvGMAeJZFJ4BoJuTr43kd1jLUCM+TKYHelgX2jcIT2iuGwybpZedk90vXfz8y0cWD2vPmnGq4fxbgpO0DcH7Yqe7DXYELJC0J0sq4LWEghA5ZjtXhIxDF8w2A+f7YrTdaG9Rf6UH8A/vl4U7e6B3Cazt/76oE2ZcJgYmo7Z1UTesXzvy2t+PykItxWwhvsd8Hr+0J107bMRdX5hPwuzqfj2Z3SZ2uqyNLCi02t+V0qzp19TpwlWNYGA45KLf2d2FXWwvMV1ahbf/hK/vfBrHI307e3/KucS7u6g/769GRXfpwKTRTi20ehjWp0anEQ1RJd0yKEUhnmhFXzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/QHb/8vL1or0EeGYX9DconRLJgDk+nJmIiH24vuHlY=;
 b=IEBEo9nOo4UeoVvAxGah95sM8Vn4Besf2gK7X5qs9U+ppVxjzDuuDsJnck1Li+EcsV/dQqnv3qFmxWd0KSdtLX7azWYGevUgpz4UStB7XYg7xCpAcm/gpYTgzlmiF7NuOBpludC7xv4Kk/aj2cAwWKjPF+vO6JvjjTySCIeZ+193kj0SsmhYqSziV8F58JKFBKJnuUSRMX17Z14gLevT03C0vZRDtcT+divju90icUim0U1xRNfIxgMwXV1Jhz/A34bdqKaaP6BPZ/Sd5oLA/IYzCvZQ1Lwe5NNGBgdwLrlupXbVEAJJ5C9dkzYg5rQ3dFG4wcULYyJ41/qc2HhsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 20:38:32 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 20:38:31 +0000
Date: Mon, 28 Oct 2024 13:38:29 -0700
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: Jonathan Cavitt <jonathan.cavitt@intel.com>,
	<intel-xe@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
	<alex.zuo@intel.com>, <john.c.harrison@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <Zx/2RYp2HD4gDn0a@orsosgc001>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
 <854j4wtca7.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <854j4wtca7.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf7f47-7021-4a62-4ed3-08dcf7907c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajBLSWNxT0ZlaWZPb2ROSnFRRWdPVWYyTVlYRTIxRWNLVWpjV1lKQWZMS09n?=
 =?utf-8?B?YktwK3pzYmxwQmVzbnVvSnYzOGVyaWxpZzV0RnVwUHlnOGhrcHJ4cElJNHNm?=
 =?utf-8?B?a1NpdXdlWGZhdWVyUmtVbi93S0JJLytKekFlbHM3VkpCYlplM2U3TWc4WHZP?=
 =?utf-8?B?bm01b2M3S0pDZVNyRlpFS2hWd25heWZoOFZQNCtqSTBmQ3gwekhzQWNGN0J2?=
 =?utf-8?B?SUhDcWZnTTZzeTZTZTdKaG8rd2ZxT3YycFRoUWtUM25TR1NEaEZ1KzBYemRE?=
 =?utf-8?B?RkpOR01SZE5leWUyZGJVS2lCd292eU1jK0krRUJSMFFHNU5EU2J2cGpJV1py?=
 =?utf-8?B?TWtvRjFQd2VoY3ZLRWYyUURWUHg3U0M1REtLdVFmWFJSYnZiVC9PQjU4c2Rh?=
 =?utf-8?B?SjlOWHViM2FFbDUwRVNxWHhBdW4zLzIyYVQzQXU5NmhsZU9DS1BjSFNVbUtW?=
 =?utf-8?B?NXBuczBQTzN5MEt0UjBNWTRBYmVJU3hhU2lQMmV0ek1BUlU2Z1hXWWJTTzR0?=
 =?utf-8?B?QlFxTVJJYkhESUJkRHhvdUFVR0R3VEFSTFlTZmdDaytDcTE2Qm5QeUxFSlpK?=
 =?utf-8?B?c1NNRklmM21KQVcxWkNkSXhDcFFjU3UyaU1XdUZlSUswb282N0tzYzdsS3cy?=
 =?utf-8?B?VGZ2MitUS2hKRWYxdmNSc3JxcVo0S2ZzeXNjZ3prR0czamRWQlF5OE5Sczkw?=
 =?utf-8?B?TVJVR2ZiR2hycEtaVC8xL2JNUmttZkZ5UXhoREhkVGxwMm4zd2duTWFOTWhy?=
 =?utf-8?B?U1J5Sk9vZEl0TVRvN0hZZFkvajZiM1lIUUZWL0RHcTdJdFUwNmkxR29VeEdh?=
 =?utf-8?B?blU4UDN4Vjd2QmhYYnhJTDBqOGR3Tk5Da2kwTUlJRFZnRG93aVREZmIxVnJD?=
 =?utf-8?B?RDVWTGpzS1YwSmJySUd1Q2xJTTVpdGRsSU5OZFg4V25IdmVpNjc5UHJPRjFG?=
 =?utf-8?B?dTJLM3ZkWmVydjhKSmlXYi9CWnhjejBHT2FEVmJlbzZTdXlMTEJwMkxYYjJT?=
 =?utf-8?B?b2x2b09ydXdpTTFCMjNpQlRRWWpNTmlBdU90dTNTZnM4NEs3T1ozRk03VHZ3?=
 =?utf-8?B?MytJTGJnOFgzbGtLK05tdXVhQitWSTBDNjRqN0xaZjVwWWtWaUVZSFk4ZWcv?=
 =?utf-8?B?WVFmaHd1Q1RhTkZwd0xEL1diaE1BSDFEcDZBWml6aEpZdTgwTWljVDdUL1hx?=
 =?utf-8?B?RUhUYmgvNEo1bVBkaXZIV0tPdy9kM2luNmhqQVVwazJsZFQ1WVRNdFA3bnFk?=
 =?utf-8?B?VGJLZ1pWazZMUCt3SDVJMDJ0SHE1M0pNWWsyYXBSdjhZczBFRURISml2dEt1?=
 =?utf-8?B?S1ZObjB5Mkx6bnc0b1ZNbXFkWXJtUHNFSkRncVRKYmY1dGx6ZjRrVWJ2Sm1z?=
 =?utf-8?B?MFVTTnZiYi9ZbjBXQ2VmVm4vMlQxOTZmUVNIN1VjSEtkcmlPalB6M0V1RUo4?=
 =?utf-8?B?eGlWd1ovRWVRSlljcUFrMVF2dmgycnhBL1gzbzRxWTBjdDN6bU5idm10Uzlk?=
 =?utf-8?B?QjlwYyszQzJqVElnKzVoS2VSTDRHNStmR3lyT3MvQU5RUE94UUMwTVpETUJV?=
 =?utf-8?B?MTMxVCs0SWhsY3Z0eVJQRkxuZ2xiNVJESFZCdUpweHZSS0hEV1NYeldmUkRH?=
 =?utf-8?B?R2NYZFoyVU9WWENQck5hd0g5OHo0Y1NjdjFnVktNaWFuMHFZd29CVzg4eldN?=
 =?utf-8?B?VE9INis0Wmw4RWUyZTNZZnN1UFBydzJDZXc0Ryt3WDFhLzlMdVlBRmpISTZy?=
 =?utf-8?Q?I6hN55ppLLaddFQy28qVsszVf3UddUjq77rTcva?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXA0bFpvQUZrRkRUSk1SdEpCSlFRSHpqNjF6aXJ4MDkwaCtBQStwSmJEV3FV?=
 =?utf-8?B?OGFJdEtuSzFDbWUvNk0xdmY5ZHA2VEVaZGcrNVg2Mmt4R3R5b0RxU0tmbkxx?=
 =?utf-8?B?dEJwS2tlbm1nbWxwOHd1K2k1ajVUVlZoRlVZZ3N0R2dxSHVjNnNiRDl0MUJq?=
 =?utf-8?B?VFRMMHBKa1F5TjZhT28wa0ZNMm9mQ3lxMUpEKzN3OUhZMVMzYmR3UUQvVE1Z?=
 =?utf-8?B?aE5qbGJlMnU0Z1VxQjY2Ri82OVZVd1piY05CdWw4UmEyd0h6Z3U4UVlvallk?=
 =?utf-8?B?b1VtSjl2bmp3QlR0Q1dDN0JQU3BZMm0vbnVzZXMrb3kzYnhqOStjUVNYWW5m?=
 =?utf-8?B?OGFIcng4amc2eEVFeEVGWXc3WDIwUmwwM0ZpcGRwZE9hK2dyMUJMd0lJZWJQ?=
 =?utf-8?B?TXh4anA1M2N3YkJXZEM0ZUpMRFpndWNjT0NRYUplOWFnTzJYOHpFeTM2ekVI?=
 =?utf-8?B?MUVJbnUrNlBQVHNseDlQS2tTOWdsU0hjWkhOalBCQkgxRXdzMHI4bE1BSjNH?=
 =?utf-8?B?bnFpWWZXaGpaQjVXRHE5cFRaaUZ5S0pkVm8xTm4zeURWZWt5S3RSQVlBbWty?=
 =?utf-8?B?SHJFblRKREJMZGRidXJBTVI2aXpEVEZyUE5zYjB5UGFINFFHKy9oc0RHTDly?=
 =?utf-8?B?NzY1bFV4bXdKUjRVZkNpVFFGYUdLbis3ZjF4TVl2bEhqK05NbUNBaXdYdmI4?=
 =?utf-8?B?YTdVTjBhSUZybnI4c2MvZk9JRFY0MHFLR3YyQXNWak03RGMyR3lqaVNIOE1P?=
 =?utf-8?B?TldnNTkyVU9rNHhMY1F1aWZVWlV2UjBzbXBFYVdLQ0xmSExaUEkrcTR4ekh1?=
 =?utf-8?B?Y081VmFUQ2RrWlYxK05zUkVQaytyamJRVmRmNFB1d01RcmVwSEx6TmN6MDRR?=
 =?utf-8?B?Q0JaVUFPZjVrWTVxVkFaZkdyVmZ5bEd6cjI5SWNtZEVyNkFreUFpVkpjY2g4?=
 =?utf-8?B?cmJVRnVQdHZKSllEN2Rib01zS05RSjZsamxISlIvUWRnU0c2VlhnL3pYaEVB?=
 =?utf-8?B?U0c5UXFnWlpDUFFBWUZzZEF3YjhXanV0YUVMT3NOaU5LalpmcnRZdFBra1hJ?=
 =?utf-8?B?eVI3Vm9FM2Z2ZjAwZnk0d0Q1Ri9oZDU0Zjd1a08rVzM1aGZQRFc1Yi9UUnov?=
 =?utf-8?B?UzBQc2JOdWVRa2paYjh1NlBhbGdJN0NSaFVBYXZxb2pFcGdjbWtRUzZ0RGNT?=
 =?utf-8?B?TDhLYlhKTlRody9kWUMrQUVKRXNYVm9sNFhqSUppOFJENXBiS0dVOG00ektX?=
 =?utf-8?B?bHlYNlNIclA4czZqU0hCL3ZrSitscWZFNkJ0eUpuUzcrUXIxcjJkenJOOUNj?=
 =?utf-8?B?N0dzcG1zVU82dVRxU0ZEMlNCcExWRkJzYWl1bTdtZ2NIUWN5dU03Wnl1V1cy?=
 =?utf-8?B?WVN5eGRWUEs2ZExEdENUY3F1Qlp2SkRsb3pBb1NQbXQybVZiUm5YNDhTamtx?=
 =?utf-8?B?cU9la2lLanpDV3ZLOGpxTHhRdys2cWxVdXBUdTFveFdPQUV3YlFBYmdtdm9h?=
 =?utf-8?B?Yzd5QmFsSXB2eDBmM2l6U251TXJYemw5OW9SbUEwM2FYVkw5ZEpJYVpySTlV?=
 =?utf-8?B?M0ZPQXd2MkcrdHplUE1lK0FibTRjQUNIdW5rTkQ0aDd1SW0yTzFmTWthcFFC?=
 =?utf-8?B?SXlpMU5pdjZNUm1vVGZnOGMvckdYZGFiMDE5R1RHKzZ5YTZ5N2lJOFhJbFY3?=
 =?utf-8?B?M2IxbHg2RnN1KzU0NFd0WUZCTXgvN2t3MjRGZC9YNm5qcTJUMmNmdHQ2NFMr?=
 =?utf-8?B?UEdsMUxwZktjS1hlT1BhSzQraFplNFMyZ04vVk1LeEl5MUtCcWZNL0lPNU9y?=
 =?utf-8?B?VHVyenYrSnB3VVI2VWpRS0ZxRThjME1EeHhuWjhjTkVlRXExSGpwemF0ME5L?=
 =?utf-8?B?NHJFZHh1b1hYaVROMEgvekRqSmVGQXFPTU5oc2x2bkVhZWRLTkdrT0hLaldN?=
 =?utf-8?B?cU14bWdCZTBqb1V2aUc4OTNuNjRsYkNSUVlmUXJpTmNYbFk4UHA2MXQrMHdm?=
 =?utf-8?B?eXNQbVhsZnluM0t0VWRhWXRhNFRUM3k4L3piV3pMNmpKdjAzd3lvT2Y3NlBs?=
 =?utf-8?B?Y0F5MUlqVS8ySVNDWkM5OUlWbVBEamlYNjUzZVNTMW1YOUNkUGo0NnE4L2RJ?=
 =?utf-8?B?anpwVnhtb0ZCckVDWnlEYnpqWXV6cXhKUkVGeWZhYktxNTdxK3VzQ0laOXFi?=
 =?utf-8?Q?WYEF11WexIFdNXjdG3D9et4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf7f47-7021-4a62-4ed3-08dcf7907c40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:38:31.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jL+9thLK2MG90MrqDZBMX+sxMV3JNu0TE4OcyfjW+m3BClNuCbnu68Rhh86Mc88+95QHUi2N89yAuCY9xMGjWXf4jAxq7XbF21ukW+djlfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com

On Mon, Oct 28, 2024 at 09:36:32AM -0700, Dixit, Ashutosh wrote:
>On Wed, 23 Oct 2024 13:07:15 -0700, Jonathan Cavitt wrote:
>>
>
>Hi Umesh,
>
>> @@ -748,6 +754,14 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
>>		}
>>	}
>>
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL0, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL1, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL2, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL3, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL4, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL5, count++);
>> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL6, count++);
>
>I am trying to understand how this works. So these registers are
>saved/restored by GuC because they are not part of HW context image

correct.

>and that is why GuC needs to do the save/restore?

yes, only if GuC performs an engine reset

>Bspec 46458/56839 do seem to
>be saying that these registers are context saved/restored? If that is
>indeed true (though not sure), do they need to be here?

For pre-gen12 they were part of the engine context image, but not from 
gen12 onwards. From gen12, they are in the power context image.

These were added because users were seeing the EuStall and EuActive 
counters zeroed out during OA use case. GuC was doing an engine reset 
for some reason and that was resetting these registers. Once we added it 
here (so GuC would save restore these), the counters had correct values.

Regards,
Umesh

>
>Thanks.
>--
>Ashutosh

