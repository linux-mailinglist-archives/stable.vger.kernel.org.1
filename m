Return-Path: <stable+bounces-136979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1230A9FE85
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 02:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC89173BC5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 00:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971FEACE;
	Tue, 29 Apr 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbrsZypi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45742A8C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887379; cv=fail; b=sMT3eEjQKCFZCdWuMRdbfjT+hDHCNFbcSpNEZDTkEwfvuzUkgg+gT52omMnxwjLjZdMudGNJUCw7rg3BPAE84tskByILlRkI8qW3tiJ9bs0/BeUn019sCtzffzHFmbMLUV+8YiJDCqvchPdWDYB5+Izz18sMaOC0FjZqKMhI7bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887379; c=relaxed/simple;
	bh=7GvC/aUEQ4HjTfdF+lt1ERYYB7qQXVoU9rp/cozOBO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNl3D2PnMC9+tNZpARMqO9TdyAzaR9mlc5j1GVXgdKMubvHYRL6JRdBW0WfQ1MPhl5+rIY5OWefO3IzjIwcmv1ThhZwKrQzawDSMb6OCbbNjXit60AT4l97QkzngZZYSYLeb3P+x6XvcCRISYKihuJyKeGkysvpXz+gmt8bbLX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbrsZypi; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745887378; x=1777423378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7GvC/aUEQ4HjTfdF+lt1ERYYB7qQXVoU9rp/cozOBO0=;
  b=AbrsZypirEWQozRnaLY+dJINE6nPcfDsldY83iyRBjYpyHylto/gzK9I
   M7pcTDtCmi92d1j/4AFXOjS3KSEEP3ECE2u7hxSoN/sREZ2Cv5RVHYxmo
   0bPDyKs9un2Z7YaKPJoZbUTL9WJCzCNI4Ek8jykGv+x4X9e+O9Oudwcp+
   L2QMoIg0db0/N/25ACleS1hZS9tu+BT7WEf1x5wAtkDC6+Vw+udw8kORY
   7/VuJpKs626aZHL5Tg1VIeTVyaQDbNMwMlxooHVLk8fmTKWgijrVgsmir
   7I57707jRlkS1kUnGCnfRT7MkbfLuMxzqpGGvT3esD9hSdoJD+o9WSjDc
   w==;
X-CSE-ConnectionGUID: lwUSKojgR12PczgaIR1Rzw==
X-CSE-MsgGUID: kqHIUIs1SDy1RPrT3fb+kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47372685"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="47372685"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:42:57 -0700
X-CSE-ConnectionGUID: 6EPP/gBpSjqSAPJKKOl7pA==
X-CSE-MsgGUID: dccMOIF1RciimyS/sxUHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133574133"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:42:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 17:42:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 17:42:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 17:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN0DF1gCH/n8hglFs+iT1MMOk53WtIqBo5hTrsa/k4sZNVqqiDB6DaxQ6W+dc9s2mB/B5FOjM8yACHrFW4wWYPgz84hxbWWC5Sl2irbcuLJwsuNqQg/oSumAUOAj2V3ds14kzYOKAUUkivmGfsbbW4MOK2iZrd2enMjP6rWyjzzIq74+I/J/fe+6t9noAzlyuKlAxPtCEV/EXeyjOaqm6H3q/Ba28HXIfhZ2WPquuG1jCr3CUBMQfi7f/VAA/AkZP4aZlUlJyJO/U8Pi+iHrbo9yB8KF00nuBkcn4BREn6B7RlQiqGSMFXKFShl0IMiBpp1sUBsK9e71oimAlYDZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GvC/aUEQ4HjTfdF+lt1ERYYB7qQXVoU9rp/cozOBO0=;
 b=TOlHajnlmZdQ2vj5IrjnKfe3v0i71VY+TX83UgegLg3iu9zW1EGLflvewXnG732V4Eridl0CeyE3xJz3KgVHJIY7zB35VasrxFthUSV9+xSggzoqRtxzcJhsfAQ4clVZ/lw4iwFqOIjumU8Bz1d9TjIfvXGAU6xsvYZMTx0kla8JRa8TziD1kCXHzDjI7u/VZIhQbeqs2QMynJ7+PwV83I7c9WmdPyXFo6b2DhuIO3fMskIhTucwbJqsLs5Qr1YF1oI9RN/xgi5YDs5mxsHOZZaVPtjnEBCBBHkgLMwMJZs6RipwPc90rp/5d1+uGlpvP+Q8puQpZf0wM3OxAEc+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 00:42:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 00:42:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "steven.price@arm.com" <steven.price@arm.com>, "bp@alien8.de"
	<bp@alien8.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"sami.mujawar@arm.com" <sami.mujawar@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xing, Cedric" <cedric.xing@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
Thread-Topic: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
Thread-Index: AQHbtJLtJe7wYytkzEG098e4FMjYJbO51giA
Date: Tue, 29 Apr 2025 00:42:34 +0000
Message-ID: <2872223857deef45c432d4b11f0a94b98fe21a80.camel@intel.com>
References: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8468:EE_
x-ms-office365-filtering-correlation-id: 4929616a-be14-4631-3913-08dd86b6bb99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1hGVDNZeGloMStZSGNLYWsrdEJPL0JrbWdKZXptTkgyeEZ1KzRKVnVjaWRz?=
 =?utf-8?B?V2cydjd6V0huVU5RSGw3aWlvM3Jid3loQ3ExV25QNUwwa3Naam9vblRtakFV?=
 =?utf-8?B?dVNIbzVGOFlyT2NaUFZSblFlZVUrV0tUTDJwZXFzdVltcmlSMFR2ems2Qk9a?=
 =?utf-8?B?ODJxUVJQSnVLS0tYYy9Jd3lTaEtVREFNWTBDR0JOekg3K1pqT3ZoaWtrWHM0?=
 =?utf-8?B?WE44aDNJTG5sdGtuYzJhcWFlWU1sR1g3TzVPR1NEemJXY2dpMUExS3JheXA0?=
 =?utf-8?B?TDh5UXdNNzNkTmNsNitKYWQ5dUJkSVNHQ3dkT1luazJWN1pBei82ZnJKVU9a?=
 =?utf-8?B?YkxoK0x3VE9HakpSR0hEMFJEeGlQMDVxdCtka0NaUmJJWmMyRWNGbUM1M0NP?=
 =?utf-8?B?c1FobDRxbmRwMW9JQlh4TGtqOTRkQUMyK3FpVXBIdFhsajc3c3dXM0U2bHlQ?=
 =?utf-8?B?QWozeENRd1JXZkhvSG93YXdGUlYwSjk3a3VrT1ZueXhqWkRRSjcyb2s1S1ZB?=
 =?utf-8?B?czJDSWszQVV6Ly9wRmRpaS8xcEMyOHFlUHdxVHhDN1puUTR5OGFCSmFJb1pw?=
 =?utf-8?B?OFdvUDdSMWtGZ0RmM3FSSExtZ1ArOTdkTFc4RmhGL1diL1gzNGtEMTRiQTB4?=
 =?utf-8?B?cURiM0pUZG5laXJZb0dBdVVqcVdZU1VudWRyYjhBa0tJd29EeStCYnNhS09V?=
 =?utf-8?B?dE9VbFhwSVRJamVzMkF4UjVaa3g4R3hXWTE5WWZER0lESHBLSDk3N1ZvL042?=
 =?utf-8?B?Q2ZEZEpjd3N5UEZnY2VEcXpjMHdtUTdmS1pKdU4wcnRlbEg1andHWXFNU1o1?=
 =?utf-8?B?MVVkTkxjR2sza2o0N3lQWTNBc0pkeTZMZWVCbHNLbE1JZkVJRDM3NXFGaldw?=
 =?utf-8?B?U3BmZzBOeDFmeHN2VUVVVWtzczNJWWNZd2xRM0pTcEdLU1NqUVJTS2VPWDVS?=
 =?utf-8?B?NVlWeVc4bGdQMEFSN2R6Z1p3ZzVWT20zK2t1YzhjazNKcER2Nm1vR3hCdk1T?=
 =?utf-8?B?RVFNOWhJNWhFVmJpdVM2dE45MGd1QlFIbWNMRS9BWmRpZFM1Z2FHK0U0Ujk0?=
 =?utf-8?B?d3B1WlNJYjM3SDBwWXBGVjVJcWorZjZMQytFbGh5THdLZk0vTHR3MmNPOTdj?=
 =?utf-8?B?UWkvSW5jaS82V3hUVGgyQncrS0RqMjQrSW5KdzJaZ3RMTEVjVG1KVjZOZTZJ?=
 =?utf-8?B?OE43UTE3Y3oyeGtJVVo1c2svaWl2SUx2UW9TblpYSVg4eU1SRWh0TzJFRkdK?=
 =?utf-8?B?K0xQekJxdmc4WUN2WlgrYU1UY2FDSkVabDBFcTFoY0RJalEzRHNIUHR3eExB?=
 =?utf-8?B?N1VBY3hSaUpVYzE1dlpiMlNqMnJZRzZKN0haYkltSkk4aWNtOFpudmNaSS9O?=
 =?utf-8?B?UzYyOU13bEhjQ2VJNnRMMHJEVFdJdXNSOEJkWGRwMmw3Ny9RK1JlMW1pTGd4?=
 =?utf-8?B?NjVtY216MjRiL1pNZVJRWDRha1FiQ2VUKzdiZjVKOFFoa21Ydk4rUUFBTzdp?=
 =?utf-8?B?bHpHOVdpdVBpZVBFcVZ2cE1KS1RZNXRycmV5MDJjUkEvSGhrcG1MT1BBY0pE?=
 =?utf-8?B?OU5BRlRqK2l3S2pvdjBMTEpsV0JINTY2RnpnS3VidENkOUZ0b1FQTHNWRkFU?=
 =?utf-8?B?Y3ZDYnl4ZXpoZTQ4MWZXTDU4MlE0dTJpVGVtN0lld3JFS3Nwb2lWb1hleTJR?=
 =?utf-8?B?YldlZG9oL1ZUMkhycThXY1p2Mk9Hc3VyNTFnQUtwWCt1dkErRkVwZnBkK3ps?=
 =?utf-8?B?M2VvdGM5cmR1ZzFaQXVMczNJcHc5dXI1N2ZiVW1qVFRxTEtoQ1hNRmpJZ1ZO?=
 =?utf-8?B?eWptNGJJNU4zRjRVSVF6WldCTWtJTmNmRHJQaUd4OWJldWNOUy9hRnNGeHla?=
 =?utf-8?B?OXdhVUpPbTg4U3dla2N6Q2pid2JiOFNMelYxWjlZbWZNSFBibkhteEloNlJG?=
 =?utf-8?B?SG9Ueko1ZVlGR2s0UEEyMDF2OWE4cGhoRkVxYTVHaUpsQjhTVGhwUjZqVG5a?=
 =?utf-8?Q?mYctWc9vQ8idCQUMxEDZLkJ6jn7SqI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnRFYmIwOTNBR2VkcW1Ea1NKM2VPUU1ZRlhyTXhEbTJrYisvaVU5bytVbUZm?=
 =?utf-8?B?L0EvOGlYVjF6MmJ6Sm5oT0daNjZYUTFBK2Zjd1hvYnJqNVkyZ2xXZWtqbWZT?=
 =?utf-8?B?S0tTUFNORFJGbjFFcmtIOVRkbVlvUGY3Wm5hRW9TRkJ3dzRzbDIxcTE2enZU?=
 =?utf-8?B?UFY4aUpCLzdIZG9CV1pVZnBZWm5rNis0bUxha2lJYjRUYUg3SG1tNU5CclhD?=
 =?utf-8?B?ZmIzMmppZTNKeUNEMnE5c1hCRkUzdGE2aXluZFJUQzFNVStNR0M5RzBNTEll?=
 =?utf-8?B?RnliWVpuWm8zRHp6YjhpOFNBMzJYVEt1V1I5WkwyczhtSm1hV0svMnU2aXhR?=
 =?utf-8?B?a3R5QlZ3bHNXZ0piVDVIZEtaVEJDVHlhNDhtbHE0S21LWkxhR05sbkxWb1FH?=
 =?utf-8?B?OGM3Y1FDQ3FhYlZHdmc5anIwVVl1VXRJcDBVaU1oMHV6WnNOR3NYTTZ5NlFU?=
 =?utf-8?B?cHdtampZMHNNdnNDa0kyQ1dXN3B6eElhalRhVU5HdkloaGZwV1N5VEpaMDZj?=
 =?utf-8?B?NlIzK0VvVDBGMjRIWmdwci8yNnVWQVZCVC9YWklueFoveWlYYU9xS3VudFlr?=
 =?utf-8?B?dkU4b0I5b1hiZmFHZU5tSFZDTGR0WUZoK01hRFJEOVhSdDRvbWFqRzdzV28v?=
 =?utf-8?B?MGZ1Z3VjV2kvbUlVeVhJNk50WU8yWU5oMm04RUFvODU4Q0ZxUFV5N1U0emNo?=
 =?utf-8?B?U2toSU1QSUtMRGE1QSt0SG51Ujkybk1yWkRvVDd0NDJ3YmxQODZvMWdGNkRp?=
 =?utf-8?B?U3FRWEFZaFlCU1AxaFh3ZVJZbksrRXFWM2ppRjJ1ZkNBUmR2Tko1NmtTbkhM?=
 =?utf-8?B?OFQzU3p0ZXE4OUFLNnpZc3E1bm13V0hGZlNCQ3hlNEVRZytsUHhhdG1vWGlr?=
 =?utf-8?B?WkhJc2FxdkdGaUtvendtMWp0ZnBmd1dUbWxDNWN1c0NFU0hUdEdYUk5Odi9y?=
 =?utf-8?B?Y2FoUm9oOEJqUkdySmlPZTlTamJSTE9IMzN3bHhTZlA0bGdnZjdZeWhRT0xZ?=
 =?utf-8?B?K2x5SlV3VHUwOElqcFJaQkVHNXZRaEN4dGRrRWkxRVJYNlNMdFVURXpjT242?=
 =?utf-8?B?ZTlZOGtZazAvaWRNQnVNYVh6TmRJMHo5U1NrSWl4T1p2M3p4eXZLdlpLaFBo?=
 =?utf-8?B?Y05lSWZCcHRuOHhHRmk4Zy9tc002RlI5ZmhZV1NHbG9kQUp5elBZQjZtZGZ2?=
 =?utf-8?B?ZC9JUXFINFdoWnBpU3g2MU1yVmRyL0tGYjhnUUgxZ2s2OGdTTXc5U0lEK1Fl?=
 =?utf-8?B?KzFJUkRLR2lwc0hqOXJSNjU2RWY1VURQZm1XVjl0dDM3bHNoa0VmQm1wQnRr?=
 =?utf-8?B?NGNGWXIrY3VNQjNSMENVT3J5MmFQUVFsUzRQZnI5RWxER2dPMnpMVDlpcDFp?=
 =?utf-8?B?OFgvNGFlYU1LY2ZmaXN3OFNUWjhQTndTbkNyTmRhaXNZTTlSTVNPN0dNL25H?=
 =?utf-8?B?UGYrODNnUU1qQ3J5ck5kbHhNRUJ6eDlOaFVIUmJzR2o4aUdtbi82UUIzaGhN?=
 =?utf-8?B?THZaN3l5TkJaUjdZVERzcm9WaXU2Vlc4S2JGU0F4bjdsakJDMkhHZFpha3Vw?=
 =?utf-8?B?elV5VlJYTHJOL1o3WnZUS2hMSGVnZGVReHc5T1lMS04rMDBDSXpldVRTblFt?=
 =?utf-8?B?YTB2eGtmWjA4dWM4ZG5nKzVhVUJGTVhYcElMcWVIVGJvMUVxRDA5SnliRUVF?=
 =?utf-8?B?MkZqUFJtNGRTZHBuSVM3MFhXVlUwK3ZNQUxHSHdhYzFXRlBpTE1sL3NUUGJ5?=
 =?utf-8?B?eFpFMmR4OHBFRW5yVWFjc1J4RkxTSUE3UVpiaHNTM0l1cmhvUlFpNGZ0enBY?=
 =?utf-8?B?cWlFOVI5VytQd1I5TVNXblpsSWg5UjZCMnNSQTA3N1ZFV3QyaXFydzN6eGtK?=
 =?utf-8?B?UGxPS3pSditCeUR0bzJqM3YxdnFxcUFXY3VmSUdDc25rOFlCWlk0cWY3MjhZ?=
 =?utf-8?B?blYxVFpmajdRbjlWK0xOckVDQ1cvMFlkM090WG92QSsvTy90TkxRMytFRDY5?=
 =?utf-8?B?b09DekQ3RGgyTHNRajQ0TTFEeGtOazE1KzdkK0tReStrVndWVkhiN1p1YWRq?=
 =?utf-8?B?OFdqdlhmREdScjc4bXl2ekI5b3hLZWhWaFdyRFRYOHloVTlDVkZRWENiMnRU?=
 =?utf-8?Q?M++OYhRudYaqmINzg4auccAjn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <279AA05628D27C4694072EFF4C202217@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4929616a-be14-4631-3913-08dd86b6bb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 00:42:34.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prJj4UeVE7W9vz7qv2kpKNZ8+CKHbVQqluLF//rlbdscKSUlFi/xtJ8qLIKmYHo3m2DRintR6zsQy7kRC1RhTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA0LTIzIGF0IDE0OjAxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFVubGlrZSBzeXNmcywgdGhlIGxpZmV0aW1lIG9mIGNvbmZpZ2ZzIG9iamVjdHMgaXMgY29udHJv
bGxlZCBieQ0KPiB1c2Vyc3BhY2UuIFRoZXJlIGlzIG5vIG1lY2hhbmlzbSBmb3IgdGhlIGtlcm5l
bCB0byBmaW5kIGFuZCBkZWxldGUgYWxsDQo+IGNyZWF0ZWQgY29uZmlnLWl0ZW1zLiBJbnN0ZWFk
LCB0aGUgY29uZmlnZnMtdHNtLXJlcG9ydCBtZWNoYW5pc20gaGFzIGFuDQo+IGV4cGVjdGF0aW9u
IHRoYXQgdHNtX3VucmVnaXN0ZXIoKSBjYW4gaGFwcGVuIGF0IGFueSB0aW1lIGFuZCBjYXVzZQ0K
PiBlc3RhYmxpc2hlZCBjb25maWctaXRlbSBhY2Nlc3MgdG8gc3RhcnQgZmFpbGluZy4NCj4gDQo+
IFRoYXQgZXhwZWN0YXRpb24gaXMgbm90IGZ1bGx5IHNhdGlzZmllZC4gV2hpbGUgdHNtX3JlcG9y
dF9yZWFkKCksDQo+IHRzbV9yZXBvcnRfe2lzLGlzX2Jpbn1fdmlzaWJsZSgpLCBhbmQgdHNtX3Jl
cG9ydF9tYWtlX2l0ZW0oKSBzYWZlbHkgZmFpbA0KPiBpZiB0c21fb3BzIGhhdmUgYmVlbiB1bnJl
Z2lzdGVyZWQsIHRzbV9yZXBvcnRfcHJpdmxldmVsX3N0b3JlKCkNCj4gdHNtX3JlcG9ydF9wcm92
aWRlcl9zaG93KCkgZmFpbCB0byBjaGVjayBmb3Igb3BzIHJlZ2lzdHJhdGlvbi4gQWRkIHRoZQ0K
PiBtaXNzaW5nIGNoZWNrcyBmb3IgdHNtX29wcyBoYXZpbmcgYmVlbiByZW1vdmVkLg0KPiANCj4g
Tm93LCBpbiBzdXBwb3J0aW5nIHRoZSBhYmlsaXR5IGZvciB0c21fdW5yZWdpc3RlcigpIHRvIGFs
d2F5cyBzdWNjZWVkLA0KPiBpdCBsZWF2ZXMgdGhlIHByb2JsZW0gb2Ygd2hhdCB0byBkbyB3aXRo
IGxpbmdlcmluZyBjb25maWctaXRlbXMuIFRoZQ0KPiBleHBlY3RhdGlvbiBpcyB0aGF0IHRoZSBh
ZG1pbiB0aGF0IGFycmFuZ2VzIGZvciB0aGUgLT5yZW1vdmUoKSAodW5iaW5kKQ0KPiBvZiB0aGUg
JHt0c21fYXJjaH0tZ3Vlc3QgZHJpdmVyIGlzIGFsc28gcmVzcG9uc2libGUgZm9yIGRlbGV0aW9u
IG9mIGFsbA0KPiBvcGVuIGNvbmZpZy1pdGVtcy4gVW50aWwgdGhhdCBkZWxldGlvbiBoYXBwZW5z
LCAtPnByb2JlKCkgKHJlbG9hZCAvDQo+IGJpbmQpIG9mIHRoZSAke3RzbV9hcmNofS1ndWVzdCBk
cml2ZXIgZmFpbHMuDQo+IA0KPiBUaGlzIGFsbG93cyBmb3IgZW1lcmdlbmN5IHNodXRkb3duIC8g
cmV2b2NhdGlvbiBvZiBhdHRlc3RhdGlvbg0KPiBpbnRlcmZhY2VzLCBhbmQgcmVxdWlyZXMgY29v
cmRpbmF0ZWQgcmVzdGFydC4NCg0KU3RpbGwsIGlzIGl0IGJldHRlciB0byBwcmludCBzb21lIG1l
c3NhZ2UgaW4gdHNtX3VucmVnaXN0ZXIoKSB0byB0ZWxsIHRoYXQgc29tZQ0KaXRlbXMgaGF2ZSBu
b3QgYmVlbiBkZWxldGVkPw0KDQo+IA0KPiBGaXhlczogNzBlNmY3ZTJiOTg1ICgiY29uZmlnZnMt
dHNtOiBJbnRyb2R1Y2UgYSBzaGFyZWQgQUJJIGZvciBhdHRlc3RhdGlvbiByZXBvcnRzIikNCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFN1enVraSBLIFBvdWxvc2UgPHN1enVr
aS5wb3Vsb3NlQGFybS5jb20+DQo+IENjOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmljZUBhcm0u
Y29tPg0KPiBDYzogU2FtaSBNdWphd2FyIDxzYW1pLm11amF3YXJAYXJtLmNvbT4NCj4gQ2M6IEJv
cmlzbGF2IFBldGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0
aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gQ2M6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFu
IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IFJlcG9ydGVk
LWJ5OiBDZWRyaWMgWGluZyA8Y2VkcmljLnhpbmdAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvdmly
dC9jb2NvL3RzbS5jIHwgICAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnQvY29jby90c20uYyBiL2RyaXZlcnMvdmlydC9jb2NvL3RzbS5jDQo+
IGluZGV4IDk0MzJkNGUzMDNmMS4uMDk2ZjRmN2MwYzExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3ZpcnQvY29jby90c20uYw0KPiArKysgYi9kcml2ZXJzL3ZpcnQvY29jby90c20uYw0KPiBAQCAt
MTUsNiArMTUsNyBAQA0KPiAgc3RhdGljIHN0cnVjdCB0c21fcHJvdmlkZXIgew0KPiAgCWNvbnN0
IHN0cnVjdCB0c21fb3BzICpvcHM7DQo+ICAJdm9pZCAqZGF0YTsNCj4gKwlhdG9taWNfdCBjb3Vu
dDsNCj4gIH0gcHJvdmlkZXI7DQo+ICBzdGF0aWMgREVDTEFSRV9SV1NFTSh0c21fcndzZW0pOw0K
PiAgDQo+IEBAIC05Miw2ICs5MywxMCBAQCBzdGF0aWMgc3NpemVfdCB0c21fcmVwb3J0X3ByaXZs
ZXZlbF9zdG9yZShzdHJ1Y3QgY29uZmlnX2l0ZW0gKmNmZywNCj4gIAlpZiAocmMpDQo+ICAJCXJl
dHVybiByYzsNCj4gIA0KPiArCWd1YXJkKHJ3c2VtX3dyaXRlKSgmdHNtX3J3c2VtKTsNCj4gKwlp
ZiAoIXByb3ZpZGVyLm9wcykNCj4gKwkJcmV0dXJuIC1FTlhJTzsNCg0KQSBtaW5vciB0aGluZzoN
Cg0KSSBzZWUgdHNtX3JlcG9ydF9yZWFkKCkgcmV0dXJucyAtRU5PVFRZIGluIHRoZSBzaW1pbGFy
IGNhc2U6DQoNCnN0YXRpYyBzc2l6ZV90IHRzbV9yZXBvcnRfcmVhZChzdHJ1Y3QgdHNtX3JlcG9y
dCAqcmVwb3J0LCB2b2lkICpidWYsICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplX3QgY291bnQsIGVudW0gdHNtX2RhdGFfc2VsZWN0IHNlbGVjdCkgICAgICAN
CnsgICAgICAgDQoJLi4uDQogICAgICAgIA0KICAgICAgICAvKiBzbG93IHBhdGgsIHJlcG9ydCBt
YXkgbmVlZCB0byBiZSByZWdlbmVyYXRlZC4uLiAqLyAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICBndWFyZChyd3NlbV93cml0ZSkoJnRzbV9yd3NlbSk7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICBvcHMgPSBwcm92aWRlci5vcHM7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBpZiAoIW9w
cykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFRZOw0KDQpTaG91bGQgaXQgYmUg
Y2hhbmdlZCB0byAtRU5YSU8gZm9yIGNvbnNpc3RlbmN5Pw0KDQo=

