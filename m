Return-Path: <stable+bounces-181540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B319B97284
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920703A8FE1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B122FB61C;
	Tue, 23 Sep 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhDqg9mX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725C2DD5F6;
	Tue, 23 Sep 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650598; cv=fail; b=Idh4X6vRDMMsq6SdOCuRWIcD7VsMza0IXvFnexWJpfCqBH8hhGnU51Y501HHG5W5fvuKEZK0GsEpEA9Icmoclznp7//B01Z13uF+JXH41ZWG/t5eFXIxlIoEqoon16iHL52SDX7pnNeDWJ8h+ryjcIQdqxbFFxF/64ZDFvJopeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650598; c=relaxed/simple;
	bh=BZI0gxCsHSDChiCx0E3JsdiOnt7rrytbJrqkim2lENo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2CUxitd5jFJ+M2zuvAeDOpef6acPwjfpjydvzyuEqAFsTBI3/FshpDQFo4R7LbV7WwNNZNk7I+Gfzpna5W/ubeBy/3KBF01gMuRtHy3OU4FpuJpiJR87uAKNGL0fjhKzK3NlTQSnqEMUBE/VG3QWsE/LcVshNZ6S0EMtZsc4RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhDqg9mX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758650596; x=1790186596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZI0gxCsHSDChiCx0E3JsdiOnt7rrytbJrqkim2lENo=;
  b=NhDqg9mXCcdHxOMzsY8Yzbg4mitqLFff/EfuvALH0AqDdASme1Qi7eC9
   Wjpgq7A85L5mbT6uhu6Y2/cDN5DgFmJsTuvkP8sHRFPbqhFystnbmiHKu
   5No1D40j7yGpAQlpti47LxZA4/hGKwfnXUwUI99Tm8f37rhkRMBxWMI35
   5TB/A7ifNGwmwi1B5JggH4cUOOG6ep77TNSbg+Hr65bJ8GkMOEmBlyHIR
   eppYpndb+L4Q+UgY0qtwJEaUWt9sX4EEIipkhGZ70RPUXFAgqsVi0XtMq
   aojyTFOisLgW4PJPlOYKi7rJQ13uwwBSvEaAhPkz0FRQ2qqQHj7d5wKSa
   A==;
X-CSE-ConnectionGUID: Epj+P0iISQe4DjOeJjbxHQ==
X-CSE-MsgGUID: Jik+weCgRceHyXtJrJ8xng==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71562771"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="71562771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:03:14 -0700
X-CSE-ConnectionGUID: /NaK806/Q6KCgpq4vVzUdg==
X-CSE-MsgGUID: Sj1yySeGS4e8DsQmb0YlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="180827016"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:03:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 11:03:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 11:03:12 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 11:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYTrS3NxwAM587sosHznbiPIObQb2LSJVk35N1AAp1IPjr7NqEkn76KqrslAr73Q7bwZLE039rEGphPoKoE6RMN6npCtR8paQrxJXSP82y6voayIxMepUMaAveyIxv3gxnK6xYKUcaTIlJdGXXki1v2GpAd3ShjAZF37UfWgD1FcHgxbkCQe2xI2o2kSySSeEUClovtQB3TuO5CIDrBmLSnzZuf1EeXdwUuL5lrrrSBkelg8TgMz3Ilt7xkliRwy6D5HvOAA2JjF8PSAFkLt4lz/yWiIiQ3OBY+4FEbdJSCfwn4biC8lkM13lTz6b3Ki1KGm5ftE7UH6v/nA/ZeyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZI0gxCsHSDChiCx0E3JsdiOnt7rrytbJrqkim2lENo=;
 b=jSrnw/aVP0jKof8doLP0s3IZQ2/ZWdwobk4ubzbq+1hD0qSALkGtm2zZuZ8Hs4iSba2nqxV8xv53Geh77+xb6eYGZhThji7fk9YsQEIKWWfUbtqovn93GD7LtHGhZy4o+X8GhjfY72MLw14mKwVKVMSom6xDST/Vmi+U78bHUumDvT3ySLdmuHjSMFS3hFlW2ugWKVSWOsxqXODBf8KJN/ZP7dSOXAAcoa6jHCx8fXPTVKVL5Nc3IkHXYrQZAsaa1OrRXhjXkJMz97tD6c/kKGrTc9/+GkUhVd2c97HqYbltO/q+g/wIx575MK6KlX1ANyqzKe/1oSY7L019Zu0TCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 18:03:09 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 18:03:08 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dakr@kernel.org" <dakr@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Thread-Topic: [PATCH v3] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Thread-Index: AQHcLHDWIFYTl/1hxUWN4SvO7PVnT7ShDpnQ
Date: Tue, 23 Sep 2025 18:03:08 +0000
Message-ID: <LV3PR11MB8768C62AFE6332ECDE9366EFF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250923094514.4068326-1-kaushlendra.kumar@intel.com>
 <20250923-lurking-gaur-of-flowers-bb68f6@sudeepholla>
In-Reply-To: <20250923-lurking-gaur-of-flowers-bb68f6@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA1PR11MB6124:EE_
x-ms-office365-filtering-correlation-id: 67d9f9bc-5d63-458d-db88-08ddfacb7416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HqPbwmHfxdCLfuoz/s+VYVlVEIx4QGw8MnLCcAljbfOOwxNXjpoda03+6wrH?=
 =?us-ascii?Q?GtJ3UjoX32Qw52fjG5acF4M5nt6s83rOmMepS6oGm2tbHBDDXrR9B6Z8Jl8S?=
 =?us-ascii?Q?oS8afx+wMBYTzm6uKjIDjWjE7eDXix1CycQcb2HolYruSAq4iNI+F1OjYiKN?=
 =?us-ascii?Q?q4mQ7aq8op+53Gknki0JbPy1xNDBlCZU6B4zdj1MJI+IsXCLKb6Ta5gomxEI?=
 =?us-ascii?Q?D2eTAwzuWky2exUB7IeJW0zGQMovunRT3wz9cghxvu0Iq6vEANXDFHRsaO1C?=
 =?us-ascii?Q?eMWzvV0E5Pi00d6au+PrItoLM8Z44UGDFTWcR7ecJifpqxWs3ucMEj7AEQ+n?=
 =?us-ascii?Q?1HxxoY3JzzckOhP4wudw7Z1fWGnKVN2c5yPWBAauWJQjkxJYTNuf0M74FnQP?=
 =?us-ascii?Q?sXFHt3AeoeXy3/IIzTHEtMcYvGK4y3gGA5Wa+sel9BiW+2GHR5wKYShVlY6R?=
 =?us-ascii?Q?E+ClopnhcE9XAZxv7HsDoGPrRd9z2kxixap1J/pz5hQTKS+9A2g/TUIaqTUn?=
 =?us-ascii?Q?oi9T4uWI/W7UgsSpME/hCJ4kDFKO6XyQdRAg3oMIDtOdqkOmuCPRIFqAbMop?=
 =?us-ascii?Q?6mLIsaUybeRmE5dCFqioBqmv9sVdS5VwBJVruKs2uzoihXXRX+QlwQy/LfAy?=
 =?us-ascii?Q?cC0wEqtqEzz0+PhpVjKXXJSgxMER3JF2E7ea9rZ7McH8Ibpoqxt4I0ERj9Wm?=
 =?us-ascii?Q?b0FJQjSKqI+MaeBBJ0zfI6vG1wF9rIkRFLC13PdgW7rpuBcNGCJeVzwG7vq1?=
 =?us-ascii?Q?Vr62oFbSji6DKAKvoOz2cgvx+9Qo+vH3WrPz68JclkwHXjB0TQgXotuFttE1?=
 =?us-ascii?Q?kY0HJaWqtvlrGilyU0s1SfXBXYPTb4oqWEmqxlTqn66D23TvIRbH7Mb6rPQ7?=
 =?us-ascii?Q?+Ws4rRPmqJuqLfMSlE6fVOMLsItIFTanIgXX/hB1hAigvh8C5QYpW/v5xetS?=
 =?us-ascii?Q?WJiPn88Mkv/4hJGdYKbBvChKUyMYnpFrZmLlmvqnIR3Vqs8JKsh2bi7aU8ny?=
 =?us-ascii?Q?eKJ9klnUINm3X5aeCCM5+uP84ffeDBUbxC60ilM+KiHSIAa4TbW1CAREU1Xb?=
 =?us-ascii?Q?s/UN5B+tnUTm6/g/pZ64a48sl7kMWrjumfNPpXfQhX/p9K2z9rNvqIlJczq0?=
 =?us-ascii?Q?DsaRrufZmoUIAJDHB/qr4rpM1Dc8m5K2eLW2Pg8iy2W+wgvM4syZkCgvjWeW?=
 =?us-ascii?Q?u5AwZN2x2RqhB+J/LpgaSS6Q4ILlQM3NK5/4Q8nWXkFtJKJj/gqZNhwUEiO6?=
 =?us-ascii?Q?vWk7QcHjZZH7UtjENoaMwPX1yDlxSUV5VqYXREUmZ7mPWULLGoqsKsTy2fzu?=
 =?us-ascii?Q?oPoj1J2wF04DxR6Ae3AmOUQvK4QM6sA9vmdtG8BBizTXrFEbtbFpua9taA5I?=
 =?us-ascii?Q?86sWqhurerCzJzgDEZlSLj3OjDypKmkzgzkoZ91B3rVHEEkgVks3TAJq34Ij?=
 =?us-ascii?Q?wsLV75JU4doDx6z8hwCRXeiLrRCxa2jvT3vXhPhkxuMTBHFOhaZ5BpFpwiI1?=
 =?us-ascii?Q?1elegNeO92r/MEk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YLOl7LHTWsNm1uUPb1wCbMo3JKCgbbXIv5kPCyqMa5z99lwwldEqszAaqWSk?=
 =?us-ascii?Q?fDr7NGKHNUMj1nMJzKYugYEcxfySDrNlBZlZ7RTRA9V/sLFjbwO18g/uxOON?=
 =?us-ascii?Q?R54gwaxc1Ys0nqOBz8AnHNg8IF1fwONeOAbtjKYu+N9JgibY/FpbjBb3eX6t?=
 =?us-ascii?Q?OQNloc4ofoYRLYG8E34MsvONCCN1N9YgheWNzrRFuO4VHv0SW/2N9+NHh/RW?=
 =?us-ascii?Q?7deOyFTho3q8e1uO+YuDk4W5lTenQkwD6dbv0H/xEHcYGTv1dDxOBDcpiTq9?=
 =?us-ascii?Q?2vR8RIIqp5xvhk9mN5RQUzz7worSyIzAO37Mx8RhxWmxgtIrle6UT8G5Utkl?=
 =?us-ascii?Q?oVGW1ayIBurpYj8fjcZucZvWJwdyGPYD2RE85cvFmIibfrRUZU6CrLifLPLE?=
 =?us-ascii?Q?r44gappBqbuiVJ8mLXFlPAZ0C1vfVeaRMLG01ix+9bToiv2UmxWFvm5Kl65E?=
 =?us-ascii?Q?yNCK7b6QCNhEFtlwsuYksx6Zk8kvC+tkFbF3Yg+o7gWlTB3NZ+F8pCPvpu2j?=
 =?us-ascii?Q?WYLSXRRAEvCu15ml6zOWoNX77nlK9nsJP4d1wTERwusO99W2txhfX8hAe/CQ?=
 =?us-ascii?Q?6emXsO+AKN9MdJ/0i0YiM0l9bcDl4DdQ7uiARIILRSzLPol+W9nfSZIsUR8h?=
 =?us-ascii?Q?PKpGnXsOQR55WTtdhEaKm8Xr/H3lAW1ts0aZEcjKfqXFPlg33grA0gDiN1sa?=
 =?us-ascii?Q?+bwYuPp3boX/SR9p90iREvGpG6nlqtwS6qcouNii1EZxLjZqPRBKIN6ZvULn?=
 =?us-ascii?Q?pBVBApW+VNibCskiVJfXiRk6sueuM541Yhrfq20JrnHCkohCaYwEn3v8dt9V?=
 =?us-ascii?Q?dbF5NlQzdwQ675V37CNCJ3U+XqeQPCfYwNK86evUcP31HeSKSSU84JbDk/ia?=
 =?us-ascii?Q?4ZcQCXOKAw6zqyP9iSxe91pI0x0h+zDqgB2of77S2KF5Z2wqxfZuebazr4jq?=
 =?us-ascii?Q?ECZ57T5QScoyfs88CtcHvIDJ72v0g+3W1ODBpa+Hmbzw4c16Qit/V+66sRW/?=
 =?us-ascii?Q?Cv7/+txjaV1lSJGISOdSvtQV4DSpOmSlYPhJM1OrTSTmDbp+8ukHAlfrkDdg?=
 =?us-ascii?Q?G1ZcDDKbmvw9tihtg7MO2o2HZXGtsnIggfNmnSFj/UnwbbUiONQb6ipuIj1J?=
 =?us-ascii?Q?DXI2HYMJGw79xhDCT8QtVdLtDPmjBVLN0V7Ok8hnxLXILhrHriIs9LiqZv1Z?=
 =?us-ascii?Q?xgz8iDwTQ318pbtMn1cBLipNBFan/LVE02hzsR3bltLB8PyrUYslWAJNHUke?=
 =?us-ascii?Q?1/eHR0qjIaSa0aAgT9mqUlFl1emt2Km88te7dxpDodmtagAQbag1T1v5JgVU?=
 =?us-ascii?Q?sjEUHip3WcxqAO/zqXisLPh59nloDoaV226zNwo+gs0WfiJdLXwnmFP+eJP7?=
 =?us-ascii?Q?M7Y23HaYQO5cjLnCMDxpUDtU735Mw5qP/MKoJCFWk3vA3NGls+MlYD4axDNw?=
 =?us-ascii?Q?0gO9PEeoKChhG3HqLV75TrpCna2DX6TpZ7ggGLbsn6uLJSPIPMV7k6iEpMzg?=
 =?us-ascii?Q?cuHzD9UQ0a89f143vO1ZMYuIzv5S0N0rQwo+L/hvZs+ehe91CqvDxqtIbscE?=
 =?us-ascii?Q?7dQnCWEVsYhEDSVGOLVNf9dwFMbi8y26e9qv6LJ8C9Nbl7sDOp33T8jOCEop?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9f9bc-5d63-458d-db88-08ddfacb7416
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 18:03:08.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pU3+SrYIR0NR+AsKZXHdEBoyHXpPtnV40hPEnyKwHI7stFQrXD5SxX6zPehERDxX/0I40Qf3L3N1w4pu2afCnCzTBNhBCcaSqTe4mEPxJdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com

On Tue, Sep 23, 2025 at 3:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Tue, Sep 23, 2025 at 03:15:14PM +0530, Kaushlendra Kumar wrote:
> > Fix incorrect use of PTR_ERR_OR_ZERO() in=20
> > topology_parse_cpu_capacity() which causes the code to proceed with=20
> > NULL clock pointers. The current logic uses !PTR_ERR_OR_ZERO(cpu_clk)=20
> > which evaluates to true for both valid pointers and NULL, leading to=20
> > potential NULL pointer dereference in clk_get_rate().
> >=20
> > Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
> > "The error code within @ptr if it is an error pointer; 0 otherwise."
> >=20
> > This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND=20
> > NULL pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true=20
> > (proceed) when cpu_clk is either valid or NULL, causing=20
> > clk_get_rate(NULL) to be called when of_clk_get() returns NULL.
> >=20
> > Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid=20
> > pointers, preventing potential NULL pointer dereference in clk_get_rate=
().
> >=20
> > Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities=20
> > with current freq")
> > Cc: stable@vger.kernel.org
> >=20
>=20
> I wonder if you missed my response on v1[1] before you sent v2/v3 so quic=
kly.
> The reviewed by tag still stands, just for sake of tools:
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> --
> Regards,
> Sudeep
>=20
> [1] https://lore.kernel.org/all/20250923-spectral-rich-shellfish-3ab26c@s=
udeepholla/

Hi Sudeep,

Thank you for the clarification and for providing the Reviewed-by tag!

You're absolutely right - I apologize for missing your v1 response before=20
sending v2/v3. I was focused on addressing the feedback from other reviewer=
s=20
(particularly Markus Elfring's suggestions about commit message improvement=
s=20
and documentation compliance) and didn't properly check for your response f=
irst.

I really appreciate you maintaining the Reviewed-by tag through the version=
s,=20
and I'll make sure to check all responses more carefully before sending=20
subsequent versions in the future.

If possible you can ignore the later version of patch.

Thank you for the review and for pointing out this process oversight.

Best regards,
Kaushlendra

