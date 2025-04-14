Return-Path: <stable+bounces-132632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E531EA884F3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECBE7A7579
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C02DFA4E;
	Mon, 14 Apr 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMJKZGkt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D82DFA38
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639638; cv=fail; b=VCf/ihUYznh+5HDq3Hyo62Oipl2UmgFfkG+Jvqz5OpOjgd21hTNIoNckGWYpPKncMoDU1GA+4u8AmS2SJbsl6gYhHZQOI8H/g7fY0Sr3B++HmydJyud/vZ2+We2+ZmteGx73u4ECrtkal6te/CSEHRXCQDt4eF7M+qBFEke3S7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639638; c=relaxed/simple;
	bh=OqgWGIcHHFB8xiS6XBzqfThjEq4wAgao8n70Pk84hA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8Mh5b03QzUcQwjmXej7mdnvEO6UzUS3l5T3yBR3DOymu6P8vFQfeOgsFmV2L3t6ZREhCKXjPDWDZVaoSji0GX28pBzMLJEbdkLQmYudziUn0ETzYZuQ3uTfGvW755cXVMLmdUW8BfibLIc157WnLMB2BhNuRutYbOtDntW8/f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMJKZGkt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744639636; x=1776175636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OqgWGIcHHFB8xiS6XBzqfThjEq4wAgao8n70Pk84hA8=;
  b=XMJKZGktCCPEbrpfGw0lAHy5pvjNjMNsQl30tFdA6jHTaDtTBwynTbml
   WP/hS+rWy9UqBWANWqDedNKV2pd1gTaFVyRdJd37AgnYHJKcF2GQRKl3j
   +YD8v1z/pL1Z6QjpHgPkA9FIR/JeUvxhD7hehn5RojIfTVnS/1oO3PivF
   ddCH/0NGp6HyJZsSTnNGPLsIgZTdcHBwG71YhVt8WUYCRSDE+l/bsFqm2
   zbbLFSRdlXc8/JBM4Evrs1VE9l1NuGTGEBA09uGVSSEz3Z5dhXzQn2yiM
   KFWps3d7J8PCivMEejzOZWDvTFe00VtMbNH3sAD9MFb4qUkrHZBQsL08K
   w==;
X-CSE-ConnectionGUID: 5rbCtl2eTFCllFx8kmfmvw==
X-CSE-MsgGUID: BJxAygB4TsWd0LMntdeV8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46277308"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46277308"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 07:07:14 -0700
X-CSE-ConnectionGUID: 0FhASCKcSxOx2Wrzx8WaoQ==
X-CSE-MsgGUID: Z2D8V6vnSD6MWK1KP+zRzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130808311"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 07:07:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 07:07:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 07:07:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 07:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8AKH5eFfvmgh4k9LZhOKTfgrnKRy+yyIciIJvZD19HtvaxZbljYcOsNriJZRHoO1jqAK7EpCcXjHNSKLvKWrbHqflwjiPb5pTQak76rw6uN/yJk4Mc6lze9vOwpoZm8aRE71yrP2nkmMe06v4xDGljot/KnBBhVuaZcMZpf6StikKxqSa+tE7nX2DClvec14Y24Kf7AvYtrAQkrjNICqPlxryAQ6Wogflgo1sNZT5cBWfqeO93Xv69YJfs1bLmtlJFnhnOtqbKXb6oKi13SDQB1gcyV/p9H0BeFjU793QeYTh6AH/LYghJT29OSosL4hpdQ9zGY7BbT4TYYpg1Wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqgWGIcHHFB8xiS6XBzqfThjEq4wAgao8n70Pk84hA8=;
 b=ZXPldxUM17+37THafors6g1Kq3aHk9Ex2rhsIzZvo1cmoByelrhXUQ2bQCevUmqDH6Gyph5ZRjWfRsbDBUUj6B+Z8KKeBYqCqcvX+2jdpzNsfaeWxwTkT/4rz46QrBprGIDgLYqwzophLuZ6AcawoSVcdaDnVd1Yv0zVPvEQ4f1HmXFmhH/LHCyRdb/JXYnzoz50BDVZopQB0zFDmw5AXxL4dZOxRDSlT3iZEbX+5J7C6wuObQivbbGKeCiXHB0SoqMrytl1NuPNXnUxCQAa4AVN43Y8ymWi+ScPftj8fd4lMmzIZNvRpLM/jArCVzFWL1lNQiPgKjJEuuMzSrrMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) by
 DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.31; Mon, 14 Apr 2025 14:07:11 +0000
Received: from DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c]) by DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::41a9:1573:32ad:202c%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:07:11 +0000
From: "Hellstrom, Thomas" <thomas.hellstrom@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld,
 Matthew" <matthew.auld@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/userptr: fix notifier vs folio deadlock
Thread-Topic: [PATCH] drm/xe/userptr: fix notifier vs folio deadlock
Thread-Index: AQHbrUDRkFYD/yQnG0mFYy/oopyBdbOjMoOA
Date: Mon, 14 Apr 2025 14:07:10 +0000
Message-ID: <db9f8eb0313eb149da488f66d1b3ab0f161ab419.camel@intel.com>
References: <20250414132539.26654-2-matthew.auld@intel.com>
In-Reply-To: <20250414132539.26654-2-matthew.auld@intel.com>
Accept-Language: en-SE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7733:EE_|DM4PR11MB5970:EE_
x-ms-office365-filtering-correlation-id: 1fd2403b-a903-45bd-5dd0-08dd7b5da67e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bER1Tk1QYVBhVFNrenh1bkZ0cFpmYWFBOExMR0NaME1RVnFmR2RNbFo2Y2R2?=
 =?utf-8?B?RUxZVG9yc3RDeHFPU28wTVh4QXovbTlPb2dYSFgyOWpiT3FjVVpMc2kwZDYv?=
 =?utf-8?B?RjZkVVI4Y1ZIOG1DbUsyQVgydUFnbnNDY3pBczYrTEhyQ2RmZnErOXVkcmxo?=
 =?utf-8?B?ZkNhdDJCcGh4a01kbWQzRlJaZVpFZmFBZDBHeEwxSzBKQmM4YTlhZlFtVDl4?=
 =?utf-8?B?Y0ZiS0NhdVUyT3paNno4RWc5cXcrMFpuS2YveVNGS2xNa2MwOXFkUlhSbFhj?=
 =?utf-8?B?cnFDN00yYUdnejVaUGRWT1I4ZDRlT0U1d0FkbWZISTIySFp4SFFrUmc1ek82?=
 =?utf-8?B?dUNGYnV1TC9vSEtCQVNJT1FvVzNxeXVpaHF2RnZReHdjUmJEdG16dVJaTlpn?=
 =?utf-8?B?d0FHY3NtSkJhSlRkTnVNaGRiRVVKVVdOZkx0NExRMTRGbWJsYW9pVkpSZFZr?=
 =?utf-8?B?MDdpZHBDT1F6TUpnekw2QzRlMEVPRmx3aG5mNk02bUxrSjlhK1UvZnNQc0oz?=
 =?utf-8?B?QXpOSEhWWVE4ZENiMmFWTkk0N1hvNGg5VDY3dDdrNkJuVmNTRENxR2FzL1Ar?=
 =?utf-8?B?YzlQYUVubGJpYjU5WGZsNkZKMEpzWnB5S3poclIwSDhOZmdwQ1l6TlhPdmVX?=
 =?utf-8?B?VUppczFORTVrRkFydHY3MVJZTGJUZUttOHVlYnpLMzlIS0g0c3FFV2dIbXdS?=
 =?utf-8?B?bnYzRXFPT0tMUGJ1emlvN0NxSUNNaDhvRXdXaU5CcWMrMTVaTnhqOEJFL3Qr?=
 =?utf-8?B?bng4ODRHaHNMS3NOL1Zsa0VPYXlZM05qRDFtK0lRNzUrbFRMU0xEeU5BQ21j?=
 =?utf-8?B?cGozSk5OS2NiT2JEejNnVGlYWlRpZnlwcnRMczZHSllEWHR6TGdvUFNKYnND?=
 =?utf-8?B?dXViMnQwN3FLbk03K0sxNVZXOCs0TFF0clN3c2I0Yys3NnQySEJvVUx4TWFy?=
 =?utf-8?B?V0hCRjlNSnlJSzRSeUdVSUFZdTlsV2haYmk0QUJMS0FTcnZKMS9iMGZ6UWF0?=
 =?utf-8?B?aHNxaFNVTWRmZG5XcXhsS3hjcHE0dXI3QWFxMnMzeVYvbTJna3krenZjaVZK?=
 =?utf-8?B?TW15bTRpN3dORGNNZDgxOWljWGgzVS9MS29QZEszVUpuZ21HVDFHTndDeVFI?=
 =?utf-8?B?TGJzU0hvNXlJY0RValJwNHBiVUUwKzJ3SW5GbUZUWGtQdVZZUkRqdDVHZzYv?=
 =?utf-8?B?V20wSDdWYi9zM01leS9hTzdQdHc0TXRLOE9VaWNYdFNwR0xEZGxYR3pURE9s?=
 =?utf-8?B?RC9UL0NKMFNEc1pSUm56eTZZM1ZrZUxaOGppdEdaUTFkU0tLT2liZTdWdjRE?=
 =?utf-8?B?UEpkTldTNzFVeDRDM1pRTVI2M0dySnBCeExHMkZWQUZJQ0ZSZFVwTXE2T25u?=
 =?utf-8?B?YWNNclFVK0hTanZPaVJjUkhKWnVDUXpJL2hTQlpJUTVGTEtETWthYVVVNnd1?=
 =?utf-8?B?SFdEMmk3ZmsrWklwMEIvdXF4QVE2OTBueVZUTDluNmZ1SkFtSUZobGpxdG5n?=
 =?utf-8?B?Vys3a1JsUWFpTWh6Zk5COG5TS1I2MmtDWGdpcEVvWFNiV0d2YTRPSTlIUy9R?=
 =?utf-8?B?Ry82L05nZzVOMGo5cG1pakV6ZDk4elFvb2Z4NFc0MlNzNGhmeGFVTnRoWlo1?=
 =?utf-8?B?SDRONkZVQzRFTzRqZFdVSzZoTjRITVN5NE9qQjJ1TUNuOFVKQ2V6TWRuR25X?=
 =?utf-8?B?K3Y3UjRYQ0RsNW9DRVJWTnpGNFhoSnNzOVlvWG1vRU5NdjRkdlIyeUYzUTB1?=
 =?utf-8?B?RXBOb0xaQ0hJWHdaQWFSeUxvUjlERlY3c2t1Tm9MR1l5UHhKQUdlT05hSlIr?=
 =?utf-8?B?blppM0QyUVp6VXFxMGNUSlZEMWE2WUg4RHhLZjI4N0ZDbXBiMG5qU1d5RXVa?=
 =?utf-8?B?bEliZW5tbFRvQkFmd094aXhYaXdQSUQ0Q2pCTTVPNE9ld1JSN0ZCZVRlTHBs?=
 =?utf-8?Q?0ypokZSFCYo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJOWkhhSmJCakRBSUovTTA5ejl2Y2xxcnc4ZVFFRjRGeEZhN3lDTEMweHFv?=
 =?utf-8?B?QmI1VVRRVWJNNHhzdjNVZmJKOW9rL3dDTTZSK1ZZRDZhbWZENEMyV1JJRDQ2?=
 =?utf-8?B?d1BWb2hweUFwekYxMmh1L1ZRYzhjMFA1M0VubktzVk1sUlR6WTVzV0IzVXhH?=
 =?utf-8?B?K1FWcHVUb0ZnTkowN2MrT3JkVGpWdTh0Z1JhTk5LZDFibEdUTCtLUkt6K1Ri?=
 =?utf-8?B?UGJXb1lVT0Qzdng3MUxaL2w3ZktMYTBmZU9sTkJXZkVQZjBrS3oyOHFhckZT?=
 =?utf-8?B?bFdEQUIzYS8vQVQ0ZDlqQmh5aHM4ekVUUUZ0YkZNVldjeHdZalgrQllOUEpw?=
 =?utf-8?B?WmtIM3RMdnFONDl3VFU4UXB2SjY1UmdSdEUzaFlHWTM1T3ppQmJQREhlSGUy?=
 =?utf-8?B?Q2NDdGdVVzcwUW9EdUF3V2t4Yjd4amUrRHFXOVNucFhHTmFrdXBjSm45bGVt?=
 =?utf-8?B?cjFQNnZqTlQ1ZFF2QjlBYWVaaHdkczVvdlE0alZmVUh4dktNR2JkNHE3QzBN?=
 =?utf-8?B?MS9qdkZLUU9QVXl3OXpYS2FyL3V2YWlNRGVSbWgwbU1zVlAvMnBwUlhnV0RX?=
 =?utf-8?B?Zy8rb3c1clhvMzFGOEZwdENJUXg5WkUyWS9pMHpEZ1d1VEFDb0ZaaUFva01j?=
 =?utf-8?B?KzJDSURLU2s3UHZLTmxwd212VDZtOVdoTThvTG9WTVJOYnpaWnBTSjhSd0hu?=
 =?utf-8?B?K1k4VEQ5NzJOd2kybHRwZWZHSUx3dlU0M0pYcmxFZWdEMjVhcVgyTm1pWm5Y?=
 =?utf-8?B?OUZKNFkrU2JGcndYSnRDRHUvVUNnSi9pcDNYUm1ZMWtLMm1zcGxCa05admFI?=
 =?utf-8?B?WGhQUmJPNkFxaUE4bDJ2dFk0MmhNcjZTUTY0RnJVc01RQjJZUE55YmJLVklD?=
 =?utf-8?B?WVpGUGRSbHhaVThleTliT3FLdHJ3R0NIaUdmT1BycHMvUi96Tlo3L1FHQmsz?=
 =?utf-8?B?c09nNEpRK1BSUlE0Q0ZCcU1tYXVWeFh3ZFoxRS92U203T3NGbUl6Q1puaXB5?=
 =?utf-8?B?emhiT1lPSTlBbUxYeEdxT0V4YURnc00yMnhWOFQybWdtaWxNTnhwNFJsUUI2?=
 =?utf-8?B?M1hxMElvT21mUnpYd1lYbi9VVWFIS0ZDOUI4ZllQbmdGQlV5eDQrYTVQS2U3?=
 =?utf-8?B?Y2dQVGNkQTArQm5tZyt6VWFTMStDWGdGczdDemc1UzZUc2NpclVWMTBBc1c4?=
 =?utf-8?B?Z1lnL0hMdDJZZ0grbm1MK09sWDV5RThCc29kTmROQUVrVXNmYUdlajRYSnY1?=
 =?utf-8?B?K3NUbnBFUG1YdEl0NE1kVGRVeFNPd3VmcGZkU0RDa1ZGZEREaUkyVkJMQVJ1?=
 =?utf-8?B?emdOelBsRFpNNi9lSmhBWU5IVERyeVRCaEh4bmpVQldBcUUydVZSWDRXRHRR?=
 =?utf-8?B?dXF2S0ZXMUNhZWtLUzg4YTlpb3JtTVd0bGNTZlZMSkxNRHNmOTVGTzNlN0tF?=
 =?utf-8?B?Vlo2OFZ1VFlpdEw5Y0l6ckViOUZtUjhxRER6NmVLUWE4dE9hUmdmaHdIV3dh?=
 =?utf-8?B?TDBqTHlvdzlCVDJnU0Y3Y2NIbUZoZGVIRGlydjZDcnZOcWlrdSt2ZTlDZjVv?=
 =?utf-8?B?eHpiRzdnQ3ZsVEFaVzdmQWNoek5BM3Z4T2xZZGMva0txUkxVRDRiV1YvY0VD?=
 =?utf-8?B?Wkg0SjdHeGcrRU5DaHpCWllBVDVjdjB6SGVha0x1dnZJeG5ob3B4OXdubGZQ?=
 =?utf-8?B?Wnhicnh5TlVNSXMzWHQ4YlZJM2pxSnl4SmZKeFVTeUNJSmoyazhQUHYydVZS?=
 =?utf-8?B?bG8wRVhDblpDV2dKenk3YVZ6TW5IakZwSytvRzhtSGhaUU1iMTg5bkppeTM1?=
 =?utf-8?B?NnFSUjFxbmhLMFVxTkoyYzZHNTUrYWdCK1g2by9WVnExaE4yUXlXb29kWHNX?=
 =?utf-8?B?OGRDZDZyRURHcFV6bHNqbTl6VTVUelU0b2Evd1YwWGxYUjhWUDY0bjlyZDRo?=
 =?utf-8?B?eCt1WktEOTJuaXB2c3poakljVG1laW5ZUTdRT0wzSjFvTUpBRnBnZC9yR29o?=
 =?utf-8?B?VGJQaWJrM3hIbWkwcWkzWU9BOTFIU0FqWjZlL09vZDJrNC8xVmhaajBEY0hX?=
 =?utf-8?B?YTVMc05kZTQxclRicUZvQ1M3dFJHNzhkdEtQUFVGSmlUTW03dUpka3dmWEY3?=
 =?utf-8?B?WjRBWE9kZGkrV3k1cDZsaEx1MG40UlMwV3pVcVhTc1dhTUJtVW1oOHZ2amhX?=
 =?utf-8?Q?Y0aND/Q53D8kZ5ajjtRg3yBCcwzhj21S/M2u2eVic7hl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45596716A17EE445BA0EBB2F772A43F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd2403b-a903-45bd-5dd0-08dd7b5da67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 14:07:11.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30otPz44gkYuz6VXcj/P5KqSlwyiR7HIORVZ+VerQYOKCuMUhO+MxHQkm3I9jnWE4CRRGKig6rKWM5YGj2DlBvI1sN3vmupW4R9OIoiGhnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA0LTE0IGF0IDE0OjI1ICswMTAwLCBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+
IFVzZXIgaXMgcmVwb3J0aW5nIHdoYXQgc21lbGxzIGxpa2Ugbm90aWZpZXIgdnMgZm9saW8gZGVh
ZGxvY2ssIHdoZXJlDQo+IG1pZ3JhdGVfcGFnZXNfYmF0Y2goKSBvbiBjb3JlIGtlcm5lbCBzaWRl
IGlzIGhvbGRpbmcgZm9saW8gbG9jayhzKQ0KPiBhbmQNCj4gdGhlbiBpbnRlcmFjdGluZyB3aXRo
IHRoZSBtYXBwaW5ncyBvZiBpdCwgaG93ZXZlciB0aG9zZSBtYXBwaW5ncyBhcmUNCj4gdGllZCB0
byBzb21lIHVzZXJwdHIsIHdoaWNoIG1lYW5zIGNhbGxpbmcgaW50byB0aGUgbm90aWZpZXIgY2Fs
bGJhY2sNCj4gYW5kDQo+IGdyYWJiaW5nIHRoZSBub3RpZmllciBsb2NrLiBXaXRoIHBlcmZlY3Qg
dGltaW5nIGl0IGxvb2tzIHBvc3NpYmxlDQo+IHRoYXQNCj4gdGhlIHBhZ2VzIHdlIHB1bGxlZCBm
cm9tIHRoZSBobW0gZmF1bHQgY2FuIGdldCBzbmlwZWQgYnkNCj4gbWlncmF0ZV9wYWdlc19iYXRj
aCgpIGF0IHRoZSBzYW1lIHRpbWUgdGhhdCB3ZSBhcmUgaG9sZGluZyB0aGUNCj4gbm90aWZpZXIN
Cj4gbG9jayB0byBtYXJrIHRoZSBwYWdlcyBhcyBhY2Nlc3NlZC9kaXJ0eSwgYnV0IGF0IHRoaXMg
cG9pbnQgd2UgYWxzbw0KPiB3YW50DQo+IHRvIGdyYWIgdGhlIGZvbGlvIGxvY2tzKHMpIHRvIG1h
cmsgdGhlbSBhcyBkaXJ0eSwgYnV0IGlmIHRoZXkgYXJlDQo+IGNvbnRlbmRlZCBmcm9tIG5vdGlm
aWVyL21pZ3JhdGVfcGFnZXNfYmF0Y2ggc2lkZSB0aGVuIHdlIGRlYWRsb2NrDQo+IHNpbmNlDQo+
IGZvbGlvIGxvY2sgd29uJ3QgYmUgZHJvcHBlZCB1bnRpbCB3ZSBkcm9wIHRoZSBub3RpZmllciBs
b2NrLg0KPiANCj4gRm9ydHVuYXRlbHkgdGhlIG1hcmtfcGFnZV9hY2Nlc3NlZC9kaXJ0eSBpcyBu
b3QgcmVhbGx5IG5lZWRlZCBpbiB0aGUNCj4gZmlyc3QgcGxhY2UgaXQgc2VlbXMgYW5kIHNob3Vs
ZCBoYXZlIGFscmVhZHkgYmVlbiBkb25lIGJ5IGhtbSBmYXVsdCwNCj4gc28NCj4ganVzdCByZW1v
dmUgaXQuDQo+IA0KPiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hl
L2tlcm5lbC8tL2lzc3Vlcy80NzY1DQo+IEZpeGVzOiAwYTk4MjE5YmNjOTYgKCJkcm0veGUvaG1t
OiBEb24ndCBkZXJlZmVyZW5jZSBzdHJ1Y3QgcGFnZQ0KPiBwb2ludGVycyB3aXRob3V0IG5vdGlm
aWVyIGxvY2siKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBp
bnRlbC5jb20+DQo+IENjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBpbnRl
bC5jb20+DQo+IENjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4NCj4g
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjEwKw0KUmV2aWV3ZWQtYnk6IFRob21h
cyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCg0KPiAtLS0N
Cj4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMgfCAyNCAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2htbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX2htbS5jDQo+IGluZGV4IGMzY2MwZmExMDVlOC4uNTdiNzE5NTZkZGY0IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfaG1tLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2htbS5jDQo+IEBAIC0xOSwyOSArMTksNiBAQCBzdGF0aWMgdTY0IHhlX25wYWdlc19p
bl9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiB1bnNpZ25lZCBsb25nIGVuZCkNCj4gwqAJ
cmV0dXJuIChlbmQgLSBzdGFydCkgPj4gUEFHRV9TSElGVDsNCj4gwqB9DQo+IMKgDQo+IC0vKioN
Cj4gLSAqIHhlX21hcmtfcmFuZ2VfYWNjZXNzZWQoKSAtIG1hcmsgYSByYW5nZSBpcyBhY2Nlc3Nl
ZCwgc28gY29yZSBtbQ0KPiAtICogaGF2ZSBzdWNoIGluZm9ybWF0aW9uIGZvciBtZW1vcnkgZXZp
Y3Rpb24gb3Igd3JpdGUgYmFjayB0bw0KPiAtICogaGFyZCBkaXNrDQo+IC0gKiBAcmFuZ2U6IHRo
ZSByYW5nZSB0byBtYXJrDQo+IC0gKiBAd3JpdGU6IGlmIHdyaXRlIHRvIHRoaXMgcmFuZ2UsIHdl
IG1hcmsgcGFnZXMgaW4gdGhpcyByYW5nZQ0KPiAtICogYXMgZGlydHkNCj4gLSAqLw0KPiAtc3Rh
dGljIHZvaWQgeGVfbWFya19yYW5nZV9hY2Nlc3NlZChzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwg
Ym9vbA0KPiB3cml0ZSkNCj4gLXsNCj4gLQlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gLQl1NjQgaSwg
bnBhZ2VzOw0KPiAtDQo+IC0JbnBhZ2VzID0geGVfbnBhZ2VzX2luX3JhbmdlKHJhbmdlLT5zdGFy
dCwgcmFuZ2UtPmVuZCk7DQo+IC0JZm9yIChpID0gMDsgaSA8IG5wYWdlczsgaSsrKSB7DQo+IC0J
CXBhZ2UgPSBobW1fcGZuX3RvX3BhZ2UocmFuZ2UtPmhtbV9wZm5zW2ldKTsNCj4gLQkJaWYgKHdy
aXRlKQ0KPiAtCQkJc2V0X3BhZ2VfZGlydHlfbG9jayhwYWdlKTsNCj4gLQ0KPiAtCQltYXJrX3Bh
Z2VfYWNjZXNzZWQocGFnZSk7DQo+IC0JfQ0KPiAtfQ0KPiAtDQo+IMKgc3RhdGljIGludCB4ZV9h
bGxvY19zZyhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwgc3RydWN0IHNnX3RhYmxlICpzdCwNCj4gwqAJ
CcKgwqDCoMKgwqDCoCBzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwgc3RydWN0IHJ3X3NlbWFwaG9y
ZQ0KPiAqbm90aWZpZXJfc2VtKQ0KPiDCoHsNCj4gQEAgLTMzMSw3ICszMDgsNiBAQCBpbnQgeGVf
aG1tX3VzZXJwdHJfcG9wdWxhdGVfcmFuZ2Uoc3RydWN0DQo+IHhlX3VzZXJwdHJfdm1hICp1dm1h
LA0KPiDCoAlpZiAocmV0KQ0KPiDCoAkJZ290byBvdXRfdW5sb2NrOw0KPiDCoA0KPiAtCXhlX21h
cmtfcmFuZ2VfYWNjZXNzZWQoJmhtbV9yYW5nZSwgd3JpdGUpOw0KPiDCoAl1c2VycHRyLT5zZyA9
ICZ1c2VycHRyLT5zZ3Q7DQo+IMKgCXhlX2htbV91c2VycHRyX3NldF9tYXBwZWQodXZtYSk7DQo+
IMKgCXVzZXJwdHItPm5vdGlmaWVyX3NlcSA9IGhtbV9yYW5nZS5ub3RpZmllcl9zZXE7DQoNCg==

