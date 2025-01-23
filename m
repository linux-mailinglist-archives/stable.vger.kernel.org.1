Return-Path: <stable+bounces-110283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D439BA1A58D
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141CD163660
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C121018A;
	Thu, 23 Jan 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOkjA/mE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FC20FAB7
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641698; cv=fail; b=GNcbdEq4M9k/nHVcKV9GOyDKylkohJYHY6MfRZUwRFt5TnDGNAxsg/Avfdif1gGiSzm/NWDTj3W8d0TbqsvsR8VOYu8UQvv2k1GjTUHGZJTPyOHlfJcOwZ7qLCwaLUqc6BhR13/EsbxDG49Wg5d5vD50lXYK6CuSNMFBu3Noy0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641698; c=relaxed/simple;
	bh=3UkpP/Ar7hmrChThBRbQWJkqz7cYU7HHefjlQYauKnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRoUDSRoPrjHLtMOhRQK8VtFRsvjWuMiEFD8sOM2GGRY3dv4taFLi4C36WQGFryPuj85YA+tJ4g6Rk2RyxecHhOplCdz8OFehjN6m3mHsG7GnBmQCdhkecVphgQunBa4eiTg9/CJMM/CIJ9kfB/nzP+BOo5eorQVWQxYGvCwZIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOkjA/mE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737641697; x=1769177697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3UkpP/Ar7hmrChThBRbQWJkqz7cYU7HHefjlQYauKnQ=;
  b=VOkjA/mE98Mlmxg3OSoVpJuuD0taeJ4fyWp1xhR+IQzXjJSLwmxMjH20
   8BXVZIE70QczGJU841g7bYR9XgTbcmphq/RxzvXSa+EoQBqqJ7WyyYwG/
   iNt50rQuaxwe4TTDAEDY7bUnvCAwRAuvKn/fZabCCUSjNeJorpvuz5OdV
   8+X1CHQqnQOd++bxM+NsxVIyAnT44zNMWyXiAOoDo616MdpiKECFeXeai
   48LuYmHMGaQBodmJQt2xL7WqKckr3XWWZD/HbwdMd9EzSAOY5HSQHP+Y4
   +Wpwdu5RUyroad7ynGWZ7V6tCYc/RZjOoympLEnJMa9ARVl3iYSPqFdVo
   A==;
X-CSE-ConnectionGUID: HRYdhC1ETS2qbHWrc4i6Aw==
X-CSE-MsgGUID: cJgropZ5SzyjFJJ47a4wnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="60610136"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="60610136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:14:56 -0800
X-CSE-ConnectionGUID: YIK1yfpUSVCphXeWiny6UQ==
X-CSE-MsgGUID: 4J6SN5tmRNi/zARMuNjlMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111492630"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 06:14:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 06:14:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 06:14:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 06:14:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOMeIVLoUQcTEd6BDJOVvWTTXzSDiqdJCFakHgnN5+H0wHoLqS9fdsjhbKgsBVCQuTeolt6cMTPDwOe+jPfn19rAPTcuF5cWcxdtK82EDCI+O6MikRuF0qNUd0ieRhpgM6io61tAK+L/ki8qd3MS8VSZXOb9G8y4QcrPSihC8CvXe2PwRs/ktmflUzBMESg4wGGnzM6ZsgrPjvijoVX9yFJl/VAt4g230Ki/L7O18//RuTn+EaH2Ah3Qwzyb0XUWqYvF2gpogM3kbUOl4TllCapOn9nEnlXDtSrDBKMc5qUKFguoA+AVxyk/I6o4Jr2DZ6J1SQBdo19KAaM682e1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UkpP/Ar7hmrChThBRbQWJkqz7cYU7HHefjlQYauKnQ=;
 b=wmGJhZE2xduZpK8ZoEzMMGc+o9RxfjYb27LiVhzULTKMOD/+fPRJVMNwYbNrq8NbUij8+4Xkyx9HGAsjhUVMMdH12Bm2DVCEYdiyu17KshhS5VwzuDf3mTaRcgaaELY+SJ/JHzgXE/ANw14YVHAQf5LfPjgv5q+RPsp48PFPjjnml7a1zmB3LcybInKDrM+KIcmWYG4tUVBM7yzj46RRaYk5rIqegz9Kzm01Ze+qvJVd9euhRJxLDhMTQvGRSOY3yxENmNMc51lq92UYrVarMo5EPZe/25yrgsvm+TGNnOlb0tqnvSU6Wog7wf9WN72dZskc2fayHfYoLXOHrNco+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:14:11 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:14:11 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "Harrison, John C" <john.c.harrison@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Topic: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Index: AQHbbVVMFHgSix08VkSGVxA9T7ZR57MkZ3cA
Date: Thu, 23 Jan 2025 14:14:11 +0000
Message-ID: <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
	 <20250123051112.1938193-2-lucas.demarchi@intel.com>
In-Reply-To: <20250123051112.1938193-2-lucas.demarchi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|CH3PR11MB7371:EE_
x-ms-office365-filtering-correlation-id: 4e02ea50-3044-4a85-64dc-08dd3bb83578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L29XOCswQ01pN3lrYVJ5eGtDNzgxNWUyU2RXSlM5dldVL2tScHZyeUlldGRD?=
 =?utf-8?B?WGg5ZVpNbk5KRlNVcm1VOEU5amEvZ1ZrNHd4NEpKdUw3R2NGb0VrRlZ6ZWhJ?=
 =?utf-8?B?di8vNjVEbWhkcUswbGhaN2w0SFl6OU1kbGZqTVY5SGg2UzBEaGlaQnZDdmFa?=
 =?utf-8?B?MEZFYXRYWFliMmxTRWpRY2RTWWZ5MU1tQ0xQQVl2cjlXTVJZYnZyMDN2VXVD?=
 =?utf-8?B?c01KQWZVbzgzeGM2TnZMa2pzNXZtY3VEbFlKeW5ZelpIWWd0MEZXZWVnbEFO?=
 =?utf-8?B?K3BJeHk1VXI5ajhDTmFLalJKTEZsc3hQUG5mNjluYzM4UDNNQ08yekdSdzAy?=
 =?utf-8?B?V1J4Yit6NUVWeG1KVTd6cFNaRkRESmhmOEUva0N6bHNjQ2gwQzFBQ2VRbTVB?=
 =?utf-8?B?eXR5d0pPREpXL2JrbjdqOUs4YklFcys4RzRHeko1UDY5Z0FIcG1PZ1RMNXMr?=
 =?utf-8?B?VllyMjJKYVYvMVFmMDJWVnErNGw5QXBxUlFqci82V01lbUJ6Y0NpL21ETlNO?=
 =?utf-8?B?QnRBRUc2d3FmUUFrTTAyUDNiSmVvcUdrcGtmbkZZR2lLc1NYRDJtRGhINmZS?=
 =?utf-8?B?MHdFNzhLODEvYjR4RTRGWGVtbE1JM1BrUFIxWHNGWlFwKzFWL0pYYjNWeFlq?=
 =?utf-8?B?UXFqLzBZR01nUWF0NEVzOVZXc2Y3NVpDSTFheUdXMHM0SGo2bGg5UldrK0cv?=
 =?utf-8?B?WTYvamZtSXhBU1FpZjdhSmxhYVdhbWt6cDFhdlhMNitZVGpuZFp0RHJ1bHVX?=
 =?utf-8?B?WGxhMkxMU3F5SThWNXFTWHQ2dmNIQTVLUVg4TE43VzVGT3oyampVRzRWMU5n?=
 =?utf-8?B?MmhkeDNVZ2pjd1pDNHkrTDVacVhSOE5FeWcvTFEzSi9GTjU2bmlsekFoNTRY?=
 =?utf-8?B?R2g0K1RUclRJcHZUeXptbVlodVBJWklMK2Y0aDNNWFJzL1lLemNIVmlubWlP?=
 =?utf-8?B?M252UkJTMjlHTjJMRXhsM1dObEIyakRqV1pRVWkyU1Q2LzBRbFBOQjh1NlhF?=
 =?utf-8?B?TUxickN1ZEZXUFhMSWRXZWhGVnpleWtncE9OYzBxRE5IUGtPTlNQcUxpeExB?=
 =?utf-8?B?RVVxZlV2MWhzUm9SYTRYbUlhSFAzUTFVV3M0L3EzY1BxRUNSSHRPOXZGS2pM?=
 =?utf-8?B?Y0NiRkhwNTFCemhockVuUUxtZVZuMlFYN2wzT29sbUhHUzdldHBZOWdLSDYv?=
 =?utf-8?B?UzNzNkRvWU5TVnhmb05DTFdlRzlqU1YyOTI4Z2cxUXZSQ0MyOTl2N3hkQWM2?=
 =?utf-8?B?MDk3L0lQclNuR0RYd3diZVc1UjlNNXI3VTI4dTNYL3ZuUER6UWdlZFZJNDAy?=
 =?utf-8?B?NmN3V2NRQlYxRzNlSi9GdisyazVDK2ZUb0lWU29EVXU2WGMwRlhRUjdGb0hh?=
 =?utf-8?B?WTltZnpxRHpxbmlWd1ZxS05yRHZYYWJDeWZwVjhYSDBIQ2R6TjY1N3BRK2FB?=
 =?utf-8?B?QzFhMWlpaUswVklyeTVzNU5DaVhsQWVOcERkZFRPM3VvbzluSjBtbVRCWG51?=
 =?utf-8?B?V3g1U0N0QUFkcFNrclhjdzBrK2k5MkNqaXB4aGNuQXAxM2dXUUVrWTRHY2VV?=
 =?utf-8?B?SHBxSXZkRCswQzVHRW1lK3lNMG0raU5EZG8zdTlpMHkwT3JlQ2k5cGpqS2FG?=
 =?utf-8?B?dTIvSlVYWG1EZEpacDBvUEppbVY4R1Q2NW9xZ0FhMHR0YzYyTTkyOVFwN1dq?=
 =?utf-8?B?cVFSZ3FtTTZJMWluT0prekRac2M3MDlKRmxjeGpQSGRrY0RrcFY0Vk1zVEh5?=
 =?utf-8?B?ZG9kcWdwZDZrZ0dmUlB4Y2pCcTlkcjQzUk5kbWErUUh3ZzhRUjBxVzEwK3kz?=
 =?utf-8?B?ZnBUZWQvNXpoYzVUWDlKWkZkMmV4bFZhN3pYTS9oeGowNitaQWNJWGpGYm1S?=
 =?utf-8?B?eDBaelpiUEZZbnFkSmpNaTJyZllJQlVoak1ja2RTMVlCVlYyVks2M0IvaDhy?=
 =?utf-8?Q?oyqWavmo8lNBy53FO+MZS2MM32ewkUme?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkRWZnJVU1dlWWdRVUlqYUFiZm9ZWnp5eG04QVZSTk85Y2hpblZZSUZrakxX?=
 =?utf-8?B?cHIyM05sWmNTQk5xSjBaNjlnVU1raEkvN01JMlJEcHlwOWRTK1lxd3VZMGFD?=
 =?utf-8?B?TDlzZVAyOEFwR0ZySStyU0FhaEVzWlpTaEw5TlRiajJaMU9lSUE1TE5aMkdD?=
 =?utf-8?B?dldNSWhndGRIT1BaN1VaUHJObWVFQ1I2SGh4T1dGcWw0eGpBQTExaHZzREc1?=
 =?utf-8?B?MzYreW02enJjY25wdHhJbVhCbDFTa2Vld2J0cm1HZXZ1ejFORXQ5c1M3QVpp?=
 =?utf-8?B?eEhkaEFrVUduVk55aGNXSUx0NzVoUlV0bUJrUVljQ0EyQ2s5Tm9tQm1sTXJ2?=
 =?utf-8?B?OFpwK3NIdERKcEdGRDJwYmtWYStMSkV6N2I2M0pOaFcwQjZaZXJJUUl4QWdR?=
 =?utf-8?B?R0pXbGtjT3VJVkswK3pneTl4dzh5Vkt6aFlvU3kyMzNIb2NZdkNEV0pQK1dV?=
 =?utf-8?B?anE5ZWFqQ3k3TllhRzRNQ01wTlRCdDRhZkhUcWlpSEljOEo5cng1bnQ0aGNs?=
 =?utf-8?B?YWxmcVNmR0E0Y014OVZuQ0tUNmtXcnZaVHB0VWZLVitIY0g3YXk4U1NDVzRX?=
 =?utf-8?B?a1hlT2ppZEFmdit3ZFEzSDk0bEdmUXdhMlNXNzduSzlXVFRPSDR3ZUNVYTVC?=
 =?utf-8?B?WmhnWnVudUNuajZ6T1cxUHdTMTlsUm5KN3Exa2dwaUhydVNEcHB2RGxJcWxW?=
 =?utf-8?B?Q2ZCZWF2c0krMzVkUmlOVHlsZ2J5bENxZ0o1VGQwT3NjbCtYWDN2SmUrcTh4?=
 =?utf-8?B?MC8rWXNhTGpkVWxkc1NoWGl1SVB5YkpVR0dmQjVYUzZBK2FMMXhYVFVmdDlI?=
 =?utf-8?B?dlFLbkVNUGVHZCtEVEp3ZWpSYjJ6MjhSSW1SRTVvMlZTZkE3NmlvR1VrbFhj?=
 =?utf-8?B?TExWN3A1enVvdjlKVHBPNzE3MW9Oem1OdDl5My9ybzZxdGJ1eDJNVk9zanpR?=
 =?utf-8?B?L0x4d1ptVzEvb2w3amdHcGRIeTBEWVpISXdkV2dOVGNPczRCVkE1amIzWHpU?=
 =?utf-8?B?YlJMeEt5aERtR2pGd2ZVbHZuaDZYZ20weXg1TUh0V2JjNnVNaDRrUEZLdW5s?=
 =?utf-8?B?aVAxQmE3Q2tVaER2SEZodHlaRGx0Um1OWjJQWGFuS0VEZGVmeG1sbWJwTkxQ?=
 =?utf-8?B?SjJOYzBabmwxa1loUDlNd09xSkE3citER2s2SnB3VWVCa2U5WFVCK1NMNjVD?=
 =?utf-8?B?M3RWYXJ3aFRMejNnR2Y3WFRFK2ZSc3FJVXJ0UHYrSFd6QW5DeFd1TkRETGI3?=
 =?utf-8?B?RVpqeFFmdVlETkxjOCtycGFtek5rVmlBOEZDdWYwK1VQSzEwMk1BOXR3YXN3?=
 =?utf-8?B?UHhKOHpXVGZjeVc2Ulo3ZnVWaEl6OTlYckJqSlMranI4ZE5YWXBMMDk4NG15?=
 =?utf-8?B?WUl0eXBiYU81VFgrcXg0ck1TUVN2Q2RFZ0N6TVkyTFordk10OWI0REJlODFy?=
 =?utf-8?B?dnRZM2tLMy9GdlQ5bFNaM1RNbU5DWlZnUmhkUEJZeUJtbDEvQ3IyUTFFR1Bk?=
 =?utf-8?B?ZFcwUkJlM1RRVUJLaEQyRVQzb0xZeExyYm05WEkzRU9WYm5xbE4vdlpmL0dC?=
 =?utf-8?B?Z1N2R0Y3dG1hRjlyS3lGMDlCNEdvZVdwTTNkdWgwdENKSVh1U2pFQW5mZnhv?=
 =?utf-8?B?R2xKSTRjeWRVWTE4ZWwrVzBoMU8vVkNNVnpla0ZQRGdmUitCNzZXSE9oamx2?=
 =?utf-8?B?YXFaNmlPbkRqQTJudzVMNCtmRlpxaEVxREFuTWtHcDZPVmdWRWhyWkp6VkQ4?=
 =?utf-8?B?NXVRQitsWGpLQ2trdlhiUXF0RjR5ODF1MWpKSDBTMWdMVVR5OGxMSm5BNU50?=
 =?utf-8?B?WDRiVlNtZFRKUkhDRnAyMVdmR3JNVUVRbFBxRWVPYzdGQ0V4VXNHQVRJWUV1?=
 =?utf-8?B?QlFHcnI3clI4MVg3bjFDenFvbkdYTEtsMHhoNTNRL0J1aWVieGtMZy9MTEtr?=
 =?utf-8?B?V2F4ZWM2M3I4Y3RjNUMvTFZjNWx2cHozcGNLMWNUSVdTalB2OHIrU0dBSVZi?=
 =?utf-8?B?bUZaamY0eTZ4UU56TUlOenl3Qm9SQXZaalVOTkhzWHNreko5RWhkWUQ1UXVa?=
 =?utf-8?B?NlVSVjY5eS90RzUrelpzdE5NdTdtb0FTVUcwSUNzYmhOcjg2dTFhUE1kMGxY?=
 =?utf-8?B?bkF5L093UGdMY2hlOW5XM2lFOThnTzdRZHFwUzF0YXJTK0E3WUdLaGJHMS9C?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <174B5F46053D294A9EC8747819F08D3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e02ea50-3044-4a85-64dc-08dd3bb83578
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 14:14:11.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7PNFGsuxIlIthZIvaimVaLq6beSDuujx4NU4P1p2sDWxQhOkmCa2LHdC9jdhqUzBNZfLBlWP2SRAWEfSjXsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAxLTIyIGF0IDIxOjExIC0wODAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IEhhdmluZyB0aGUgZXhlYyBxdWV1ZSBzbmFwc2hvdCBpbnNpZGUgYSAiR3VDIENUIiBzZWN0
aW9uIHdhcyBhbHdheXMNCj4gd3JvbmcuICBDb21taXQgYzI4ZmQ2YzM1OGRiICgiZHJtL3hlL2Rl
dmNvcmVkdW1wOiBJbXByb3ZlIHNlY3Rpb24NCj4gaGVhZGluZ3MgYW5kIGFkZCB0aWxlIGluZm8i
KSB0cmllZCB0byBmaXggdGhhdCBidWcsIGJ1dCB3aXRoIHRoYXQgYWxzbw0KPiBicm9rZSB0aGUg
bWVzYSB0b29sIHRoYXQgcGFyc2VzIHRoZSBkZXZjb3JlZHVtcCwgaGVuY2UgaXQgd2FzIHJldmVy
dGVkDQo+IGluIGNvbW1pdCA3MGZiODZhODVkYzkgKCJkcm0veGU6IFJldmVydCBzb21lIGNoYW5n
ZXMgdGhhdCBicmVhayBhIG1lc2ENCj4gZGVidWcgdG9vbCIpLg0KPiANCj4gV2l0aCB0aGUgbWVz
YSB0b29sIGFsc28gZml4ZWQsIHRoaXMgY2FuIHByb3BhZ2F0ZSBhcyBhIGZpeCBvbiBib3RoDQo+
IGtlcm5lbCBhbmQgdXNlcnNwYWNlIHNpZGUgdG8gYXZvaWQgdW5uZWNlc3NhcnkgaGVhZGFjaGUg
Zm9yIGEgZGVidWcNCj4gZmVhdHVyZS4NCg0KVGhpcyB3aWxsIGJyZWFrIG9sZGVyIHZlcnNpb25z
IG9mIHRoZSBNZXNhIHBhcnNlci4gSXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5Pw0KSXMgaXQgd29y
dGggYnJlYWtpbmcgdGhlIHRvb2w/IEluIG15IG9waW5pb24sIGl0IGlzIG5vdC4NCg0KQWxzbywg
ZG8gd2UgbmVlZCB0byBkaXNjdXNzIHRoaXMgbm93PyBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8g
Zm9jdXMgb24gYnJpbmdpbmcgdGhlIEd1QyBsb2cgaW4gZmlyc3Q/DQoNCj4gDQo+IENjOiBKb2hu
IEhhcnJpc29uIDxKb2huLkMuSGFycmlzb25ASW50ZWwuY29tPg0KPiBDYzogSnVsaWEgRmlsaXBj
aHVrIDxqdWxpYS5maWxpcGNodWtAaW50ZWwuY29tPg0KPiBDYzogSm9zw6kgUm9iZXJ0byBkZSBT
b3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IEZpeGVzOiA3MGZiODZhODVkYzkgKCJkcm0veGU6IFJldmVydCBzb21lIGNoYW5nZXMgdGhh
dCBicmVhayBhIG1lc2EgZGVidWcgdG9vbCIpDQo+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIERlIE1h
cmNoaSA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV9kZXZjb3JlZHVtcC5jIHwgNiArLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0veGUveGVfZGV2Y29yZWR1bXAuYyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3Jl
ZHVtcC5jDQo+IGluZGV4IDgxZGM3Nzk1YzA2NTEuLmE3OTQ2YTc2Nzc3ZTcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jDQo+IEBAIC0xMTksMTEgKzExOSw3IEBAIHN0YXRp
YyBzc2l6ZV90IF9feGVfZGV2Y29yZWR1bXBfcmVhZChjaGFyICpidWZmZXIsIHNpemVfdCBjb3Vu
dCwNCj4gIAlkcm1fcHV0cygmcCwgIlxuKioqKiBHdUMgQ1QgKioqKlxuIik7DQo+ICAJeGVfZ3Vj
X2N0X3NuYXBzaG90X3ByaW50KHNzLT5ndWMuY3QsICZwKTsNCj4gIA0KPiAtCS8qDQo+IC0JICog
RG9uJ3QgYWRkIGEgbmV3IHNlY3Rpb24gaGVhZGVyIGhlcmUgYmVjYXVzZSB0aGUgbWVzYSBkZWJ1
ZyBkZWNvZGVyDQo+IC0JICogdG9vbCBleHBlY3RzIHRoZSBjb250ZXh0IGluZm9ybWF0aW9uIHRv
IGJlIGluIHRoZSAnR3VDIENUJyBzZWN0aW9uLg0KPiAtCSAqLw0KPiAtCS8qIGRybV9wdXRzKCZw
LCAiXG4qKioqIENvbnRleHRzICoqKipcbiIpOyAqLw0KPiArCWRybV9wdXRzKCZwLCAiXG4qKioq
IENvbnRleHRzICoqKipcbiIpOw0KPiAgCXhlX2d1Y19leGVjX3F1ZXVlX3NuYXBzaG90X3ByaW50
KHNzLT5nZSwgJnApOw0KPiAgDQo+ICAJZHJtX3B1dHMoJnAsICJcbioqKiogSm9iICoqKipcbiIp
Ow0KDQo=

