Return-Path: <stable+bounces-240247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOErL3bt52mhCwIAu9opvQ
	(envelope-from <stable+bounces-240247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD043FC5F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7664306DEB5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC839EF39;
	Tue, 21 Apr 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRt8KlSb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409823DD512;
	Tue, 21 Apr 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807261; cv=fail; b=GnWYrFg/mWMz17RC1Bf1surdQ+/7r3QG2Ts5KFftdx3/ss+SloIbOxbtPehxpwnYr7X9uuDPwlxeRSF6heaekPZAr8CiR/FY1B4gV7Sdzdy5/pRqloCmIKG1YhhY+g0ZY18AboKJpNlPwXQjMdAG8wtahpmS3Qf5BH5ENuKa5l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807261; c=relaxed/simple;
	bh=4FhBSYmP5VAERkO/DboIW2dv+0aLNSMWZeJxWhNRXMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/o/tPLoVgg+pOtCI7lREJJ4Leve1O0QxCgPaa3Njur2amXAPy6W9z+Y83A0gnnuMuIjK1fdCyHCOLQcfEQzwfN4MV85tBOpgA3Jxxsll/VF/asdaMUvM8ylIyUgEmjFzxiB8msBA3rZn6R3eGe6vMguPMsjG43TUvXlQJD5hj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRt8KlSb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776807259; x=1808343259;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4FhBSYmP5VAERkO/DboIW2dv+0aLNSMWZeJxWhNRXMA=;
  b=PRt8KlSbc3hAHVJiCKpSV3r9eiD356ZwqRmf47f8+VeSHGvfLod9o+/W
   Ni5wS6v9VEVCki8teEq39AnLqH0SHkOxeqk4B0OCNqPK0bCYJLxmeba1U
   Jq0aAhG1IQX1azp3mnFga7nPKENRMzvmNgUrRCrCel3tqr2s6AWzhdxEt
   QTk0VD3tYPmiXG3GGj/GgviMwUGDmko18R45sFYYOwpMDYHJAtha3N63a
   527/6W1xDucutTaNJqoljM233eyzIyn9uqVQefoPi5/2J6tbXe7bOU5NT
   OCKdy2uMPoh1FONZaNnvci0VyE+WRWJqj54cD1V+37q5EzLzAZdgwkFQ5
   Q==;
X-CSE-ConnectionGUID: p9YjnYSdT0m15cF17uY8EQ==
X-CSE-MsgGUID: YHdqATi4Tk6hOP9Q0PODQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88053977"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88053977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:34:19 -0700
X-CSE-ConnectionGUID: SUNz6rHaQ1aG+533mh0GIA==
X-CSE-MsgGUID: YJU6gloYQQ+5FeVTyEr4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236161622"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 14:34:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 14:34:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 14:34:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 14:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdz+ZX5MfjwrjtccUtOcuB5ncbr8KXj1LpPV16MaYqrrAbo6qpNg3WciVXbuZDu/IN5E5G6nlaYXI+hucf8Sqen//WG0UVepwFAwzGGb6nsAs5FbBMF0fqz8yZSIj+g2u0gyHtFOJl9E9Tz5+paLpthbvgtw6zZ0RvX5Zcg2b1vdwu1pMkD5DQpcKHw3IZQ3B2WZENVZ7w57bryEVmLKI5RaV+dtVhXSDf0GOfrmBlvJASMEw3k/ad70fX+ojbWk6C/1GXumCpK3O438/+WOUIiQqjYAFDdELK1eYbFajOy+szDjTZrmJTBrPBVzQryyKIva44u0cfGLaPzZobxMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIGNJjobwdL9d+ELCEr+frqpjnWjg6blL5AnSbhlt1o=;
 b=AVs18WAHnSTgKOsvmNCX1BBu04QbTalVMiOr8gy3C6Wrad0DBBxkoAOaVg92EnBtpKPr/3R0vhM7vznESGY/1khJrDyZVb2pKCCI7Yj4UhN+lVcGD9SGk4pHg15XDWVBvsOjWwoW4V7lTeGZKNdBaH1FlY+9l0jurNdIjnE8FusSTv3IWKd08Pmpkb0pguPh9q4tcHe4CQHDMFJfIQlFkLHDGLjdagggNigC8eh36gEEooeAd3Wo+az2JDmOkmFZfrfEUFCu9rHM8DnVvkKxzPm3Y844Pfv4qyL35gyArrZe7XtzJhFEGXsjNPKt4wXudy+dJea7kfNnHvtabEN2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:34:14 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 21:34:14 +0000
Date: Tue, 21 Apr 2026 23:34:07 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Gayatri Kammela <Gayatri.Kammela@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <stable@vger.kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86/cpu: Disable FRED when PTI is forced on
Message-ID: <aefsYucEBzwPAjYB@wieczorr-mobl1.localdomain>
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 2761dcf8-bae3-4530-7181-08de9fedbbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: u/CVsZBnCTk4MfWdhHEwXbkOrdIqrtEJLqmUqUPjO+2h5wcwj0m0RkWlc9c3D6lQ58IdWRUgzpXwdDbPS5gQGqrRaBEgc84hW1cjoGOdbvMTgH+I/zfYk2pqd8DUFSJRXjyp2YE9Dqg6eA8EbtRkq69L+mBSNmd74j2YUAteEoSGhjRmjaGc2sWC6Nb7vjbtyWIh9jibMWiaONI1txQJ1pB1RDT3B+8B6ol89RcLOEzFPIJRRbssnNJexiJHQgXgVc49a2TpoaMz5+/qmE0wJHbXSdO9UXWc4nmHs2eNXFIcWQKwSx1IRR1PR4IujKPi/5AJS2uKtDcdhjpu3KmsVdsycXbIWVhxMAsTp5p09x1Ivh8szIAO7c8V3bRi3Cu6URxsqkbwqpz0WTrVgCFrGzKoH0tBfMp6cgwFvdtxksbkJParxCiRtvIFyZGNLkCxDBu3fnLz0fzrbiJRhQObu0GlQT3p75W2U9Im0YLimrESEmRsORJvRNI/q+JSZZQ+6nr20eQDA/em9y8JB7yucG18LhRzcZ/SnoE3OYEPgj603OEq1+RcjPhuQ489CuylhYi/dM8iY3GDYDdBX3zSAgv6mE0RnlJOCFh5UYJZUF5P6wjoTJtLh3Xqv47YWV4P5FcfzJ+QKGZNT/GAl4lWwuecAxo4cremj9S+KWC1xgivbXoMHvlQUv30edIWq7kEM5714G7xbxzLh4f7AaOgwvDEYLe+bdzdA6F4eawQPko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DWG7ZaGUOGA3FYVGiDzKIwyCtuitFajMk/rP/SCMehcS0svBhvZq9J0+J7?=
 =?iso-8859-1?Q?/T/kCD3gU7au7jDuxMqfh5RN6nnvsWc6WbqQ9dfTLGTOVs9RW+8k3TdXzf?=
 =?iso-8859-1?Q?6slbScTGHen0mkz2tDcuAOZZSIHDwGeR0v/xSvdc3TeoD7NQKFoKWBQX/w?=
 =?iso-8859-1?Q?mV09iXKUEIKfnS9rutVXG+E91Lmue76eLHUyAFnbwY30SnjcQZuyiYW8vf?=
 =?iso-8859-1?Q?6BuxekA0fwYMll4lfjyCDHL7Q+3S2HErNjx8o7wAbWP6U3fAd+ai/bBzum?=
 =?iso-8859-1?Q?3WmZ1H3ZvsKpbr5omM63C+XkTatdwaanG2vO4Brx/ffhMmoYKZviQ5aeN7?=
 =?iso-8859-1?Q?lWIpeV6DdFEjazXOqkE25RbMtKdqykP5AzGVst/5oa+ki9wtfR2eA6xEZO?=
 =?iso-8859-1?Q?edjV7bVBYOt07Q5PGdP+JLMX9ntAxNhw1440VvFAXYpzdVtZZ6Td33qt0/?=
 =?iso-8859-1?Q?f+3MwlkRll1JajqOvyyUuoYCO8szuf4ZrgM1430TIVA3QRsLebqYYPIvmF?=
 =?iso-8859-1?Q?B6tSk64cyWSsm85fwIuQrMYyh+ilcj8zZ0RKQwiuqKO6vGCWLBG6ZHmDsv?=
 =?iso-8859-1?Q?ReKXw2HeYJztuG97Wy/MkYUXkklREg2e6rYoqmJOUqFSmq+yFeUH0gucGy?=
 =?iso-8859-1?Q?1fYzFnon6GxhalE7FAGpznppOwPRIwNcBcE69Vby+QnVqB2IHr1Dq4EiXx?=
 =?iso-8859-1?Q?/M79GKbLXg2G2wTU8qYHDQE7rcdsapWg0a2d94zOsHFCl5zNJALw/X/66M?=
 =?iso-8859-1?Q?QQnXJM7lwm6XyUwivoNkAScr2GRm+SCzo6E+WxoPfyhouNGhWvq8IQeTvd?=
 =?iso-8859-1?Q?/8iiKViKMICUbrnDjIV7iVHRGl9jfs0ZDHsyQicAor906SpvVo7fuJfrMd?=
 =?iso-8859-1?Q?rrN+4n/WMfZujzEs9XBYbKxteA/cw3K6gpgKN6lKcdWOo3g6Oa/xEDDDOS?=
 =?iso-8859-1?Q?LQhC2RXrAs3ZqLY0G4k6dN8WACgKF065XIJ3T4/lY4w9or7CSbR0h1ig+I?=
 =?iso-8859-1?Q?pgb+8Ez8Gbd3KKuvyGmFEa073N5bJ4aqty1t+0ux9IK/+roBtsAn5M7Xjn?=
 =?iso-8859-1?Q?hR/IAq1yzoD6TuaXVxkGBV7J9VNCgfFaTLMTOdDOJvlIO6sDDdq/gdeOQu?=
 =?iso-8859-1?Q?aR7r4kmW42XOLIU+BL/5tnq+Ft9E9uqRmIlm9j7FHWa/zqPUjLXs+0DwU2?=
 =?iso-8859-1?Q?aJzk2bcYup3C3Oulrti2KgtlQWvCf65u4MaR7O332tnVDwt72JjNjTL1P9?=
 =?iso-8859-1?Q?MJH3ig7R2ku0Lv2THl0l7zWUT0Z3BBFRIHtRWGJKfwIcSvBODpdsLOPYGo?=
 =?iso-8859-1?Q?+8/G+K0J62swgw8+eZpQkH1UnMA8lj+OTT9WSxA+uRsv/dFVuTidcq1mAA?=
 =?iso-8859-1?Q?hXnIQYJFaP9c4DwjBFAh8QHN2zZIqjmE3NYehlc9m+wvAAME3KeqrRZEs2?=
 =?iso-8859-1?Q?cmAEtNCX5+sQXQb4B+Az991gU431viJ4QpBntHWK8gP85b/9yZacd89F5F?=
 =?iso-8859-1?Q?mDAvWed5ZotLx5PPenrDvlDmy03NtiBa3Vz4UTshDf3RHV9FZ0DysbBFRr?=
 =?iso-8859-1?Q?6HU23EXGK8F8NqyU3MvPSc+vJI0n6BZRPoSOJUcKxV/vvDt3lP03XnnVD7?=
 =?iso-8859-1?Q?9PXUNvEmwruvQKEDHFJz5oOwJwSIa+9HRSljlYCUFF7iPZ/Zhpk8fGPsd9?=
 =?iso-8859-1?Q?GTPRKVE2/cPSOe4zp9bsUYmOsyitk3IaFkqLd0IpdhKiMIhGDoEXtnE7jf?=
 =?iso-8859-1?Q?DxggboC0CDUnQWfyH+I9ARx6M+wKgcN0yo6FuqggLt8Wg9MwM9CtMZpm7B?=
 =?iso-8859-1?Q?2QRZqHUMi0ZX8qb3cxfgJyFBpn1QFkBIZNe84VnvlMtq3/q1Jt0N?=
X-Exchange-RoutingPolicyChecked: pfB+9CsByb7xMrV+hwOUY5cO3WFPm9LNUza3MpZLs+lQ30DrVEQNbpPhT5RY0hijALJbVwK+GnCjF8cWtYhkG7RQ6iVd0Wlk4PdjEuC+8XNTP6KVqHBtY3AYWhz8Gt3bUGQIXknZIxDbGGaJIX2r+2grfX523FJo5Rt+CIRpYa84RatCGVkAHPxmplz4xOUQ+G8lB1I9dP8oL2NB6miSyrjVLjz/wfekVPyqL4YjEipLbT9vCt1eoF+LFhYrHUZS32Dzog6k33dsKQU5BSZZSSF5qjWT0fYrstIRGnmWF3PeaYu+pOQ/mIBHgGiyO+SPSixYo+SpOOdSPwKkUVmY4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2761dcf8-bae3-4530-7181-08de9fedbbec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:34:14.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+1v73IOLvCr204zaLv986YX8qLTX/UTSh+pBkLgbXlNOfk3NGeiQ7uvXJrVcaAGruAFc9kN1lF6H1i+QOu4s5vW6iFgddLLcKqKacuP6xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240247-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,wieczorr-mobl1.localdomain:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.wieczor-retman@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 41DD043FC5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested on a Panther Lake system. After applying the patch, FRED gets disabled
when 'pti=on' is used. No other issues were observed.

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman

