Return-Path: <stable+bounces-213281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIAoFhYqgmnFPwMAu9opvQ
	(envelope-from <stable+bounces-213281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:02:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66107DC6D1
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26C5F303D8D2
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100B3D34AA;
	Tue,  3 Feb 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQhHHHk5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCE3D3491
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137995; cv=fail; b=GJgGob7J+hGxS2uyEhmQrc6FDI7Vk5id7AcscPYGLJaUGXfSe5DAnpsA7VmYtqY1394VbKBEEW0ifHYKd29CXJwJTIIzibGXLK+Lw0xl5iX+qeTpcdLBDuu3EYMlVTA683iNNDvDAyv5gG1ele1upZ56XcAVm/4UmhNh7bWR6ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137995; c=relaxed/simple;
	bh=8s5BaRPDnyWug1PAliwqZ7omn1pu5jXCqNCmC+16B2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nz5B17GEQQPc2XDMzhq7RnwblgtdqQD5mT3TT7GxXnwc8dMuAww6Lwpv9FU86KDztcMjr+66iWaFMcjo7DSABuywPt6S33Bs4jV/SxeuBUx6BTfICBdReRn0yBWH8S2klyWJwMLIkMrvHBqhPF4/Ue92gVnoNPdwFX4ddPoiG4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQhHHHk5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770137994; x=1801673994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8s5BaRPDnyWug1PAliwqZ7omn1pu5jXCqNCmC+16B2I=;
  b=iQhHHHk5igPAWHpM5k5QGWptRARePVH5clPDRBCXsL/y9WFl8chjHtex
   N473wz/TYc3AXwf2qeg9PPuYUBO6iDiwkVLVx0Au5xQOknnvqQIh1c82M
   wT9yCnCPUYC+ROKBX1k8lmxM3NLArTh14SJI0JFBRy5VXQ4IKfGVz1VtU
   PmxtCpk1QSIGSJIS24Om1ddscPyml514n3Wl1iN5VLjrIM0XqbMJeRIdj
   +GQB99HPHvfRX5iSio3+NZKK9GJ5L78lwKmGtn3h2n8UhdlPUqR4HMYZe
   x+q5qqMYn3bTq60EoYLpuAoryqkgJcjECIaYcPz3VAFKDcaXz69Qel4cR
   w==;
X-CSE-ConnectionGUID: ZT2cj+T+SiC+ZNuAEe4V6g==
X-CSE-MsgGUID: ccF/hNKHTs22hUY6h+pZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71034187"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71034187"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:59:54 -0800
X-CSE-ConnectionGUID: PnLx2fOlSsOZcyOuIDrMBQ==
X-CSE-MsgGUID: 4Ha1gU3uSlyHfAYR114beQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209321206"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:59:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:59:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 08:59:52 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:59:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxBMptzOeLewJUcwE+T+Km8ARlAHct3tC+kJlnW9qnYPO8v5iqOkfQ8QyjD4yqdncjmE0seg4l0sgu6N7I3DFPjvaUsbMoBrKO55cQmNdB+cLs2Z5YmjgG0LkkA7byYFOGEWe46k6hNknKvD5D0JHU1VeTfMTW2EKakx9PINbv39BYXVg1D9U57ix2OaWJbYvYL362F3bYEhyRZ/THHBx9ecIHgPLXECaLfEWGX+2UsB+W0At5H8ouG4fui7Uc+Gxmqs1+zigFuc2FV64ZmZTOLfAspm571wMIYc+uhArWhpxpztRChgUk8rRdoz84DnNJ+P1v3XpZs4qnF822rOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s5BaRPDnyWug1PAliwqZ7omn1pu5jXCqNCmC+16B2I=;
 b=MRsjvMbBqDvk7tvkURfUcxrx2mcdM0m5c69zspMbO+WjjrxmkE2Q/5kAColB4fwag7HFOGGEp10/8jNdgX2H05rrXaE+kmBf/SYYJ4VYcXFvsFe2usGEZD0tIsd5vfKhRUW9arihInT2vdc+HT2y966wDrj+fcUcQu1SQySYSjbWCOYgI0pCl7RC4MRSmKhY8Nz8li4BCd6cP64bj0OCAWxO0+O22sipUK327LlVq6yP8mMo6RNdqmwK/34IfXuDuOAG+KqcQ3QFwwtgJOrwNwpkOE6WCjOesfk34JheJdL1I0WClTNGEoVJquZyjzLN3wAokc108rmP7rfvndlpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:59:47 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%7]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:59:46 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Lin, Shuicheng"
	<shuicheng.lin@intel.com>, "Mathew, Alwin" <alwin.mathew@intel.com>, "Mrozek,
 Michal" <michal.mrozek@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>
Subject: RE: [PATCH v4] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Topic: [PATCH v4] drm/xe/uapi: Reject coh_none PAT index for CPU cached
 memory in madvise
Thread-Index: AQHclSScCMu1KRBd0EWtPvONyqG56rVxLNoAgAABQjA=
Date: Tue, 3 Feb 2026 16:59:46 +0000
Message-ID: <PH8PR11MB8040AF50CC76C6D4C8A019EFF49BA@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260203154846.1113521-1-jia.yao@intel.com>
 <582ecdea-b2a9-4ece-8cb0-854e9a2fa540@intel.com>
In-Reply-To: <582ecdea-b2a9-4ece-8cb0-854e9a2fa540@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|DS7PR11MB6016:EE_
x-ms-office365-filtering-correlation-id: e540f6df-1405-4853-89cc-08de6345a2c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|42112799006|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?OTFqMVM4QUNlU2ErWjUwbzlUVnRuS0FOc094a0ZRRkRPZVVIT2tHejEza3VH?=
 =?utf-8?B?S1hPbTJ3U3FTOWx4V2JUeFg1bjdtN2t2dnMrdkRtcWF2Qmo0MEVDdEQvaHVt?=
 =?utf-8?B?SzZPRWRyYXhYQ2dqdERIYTU2K0ZBUDNkQU9yakpNczhxc20yMEVpMUtaQlMv?=
 =?utf-8?B?YmNjOWV2RG9uODlWYTVvY3VXT1Fib3dwSnFxYmlIS2JpbnBBaGtqMHIxeVZ2?=
 =?utf-8?B?bVJGb2lSMmVNYjFGUUw4TVpGK2lISktRL0FpV3R2ZUVCaHU3akJiek1zUXBS?=
 =?utf-8?B?OXdaWEtxS01jR3NMVlI0V3RsTXZNLy9LODNaWjRSQkZYRzVZQ0hoSFBTTWhU?=
 =?utf-8?B?dDBkMkRRODY5amRVcEJJMTg3ODljOXE3SUs0MjkwK0VIZ3FrYzhuUjh1VTd5?=
 =?utf-8?B?TEx1TWc3VGRsd0xDdWJkdHNqVzJMUHhGcWxvNDdxOWFvcGkyamc5T0lVUWZt?=
 =?utf-8?B?cVRkNG5JQ3dGTHVoSHBveVJUbVVOWUFrRCs2MGdrZklmRHZ3ZENWSlF5OWN2?=
 =?utf-8?B?QmFnWHBtRld1QUhSeWM0c1RwR3BVc3ErMTFUVldTR3ZyamN4d3ZKeENxZ0Mw?=
 =?utf-8?B?MW9NbDZZOUdtQWsyVGY3bytEdVpnS2dOUHBza21UZHlHdlpZTEc4T2N0bnJQ?=
 =?utf-8?B?c3B6cFN1MjJlNXhaem54ZkJML0JpRzFRLzFmUWJQNW1jMWY4YW41bnFOWXQ5?=
 =?utf-8?B?VVM2cmJ2RFVqNEROVldlSEtFK1RCaFJsbCttQmRvdkZ2dDBDNERYbVJURHFV?=
 =?utf-8?B?YUVWMTRzRDRNNkxUYk4wSXFtWHRqZDkranV3Wmp2MEo3eWZnWHFRbUZ0NldN?=
 =?utf-8?B?b2NNOXo2VjZOdGkwVm5BL1oyRFlnL3dzV21uSHdmNXh2dnJ6R2FwWmtxeVhy?=
 =?utf-8?B?eUQ3SU1iNnRtbzVrWGVNZnRFTEtINGhyNEFDM0VpeUFpQmRDNEQ4SExnUnky?=
 =?utf-8?B?b0ZNNWptVW9waFUwVUsxOS9MaEdsd0VwaWxURzl3UzZ3d2kwWDlQazlPdU1p?=
 =?utf-8?B?T0tKMmhiS3ZqajhhWkIzZndvdm9NLzZhQjRUMjczT2JoVUI4OE1wWHM3RU1C?=
 =?utf-8?B?M0FERTVvREppVXRvMXUwRnU1OHYxQVNtUUx3VGRDcWd1N2djbkkwM3NyYnZE?=
 =?utf-8?B?NHBDMXhRZFZiVWYvamVQQXlHUTM0MFE5aitsbUNMaDRQWGJFUVp4MDNRT1ZQ?=
 =?utf-8?B?cW9tMTVyU1Fxd2oyMUcvK29XK01wM2QxbW1pVUlxZ0xiR2sreWlMY0VmbU1h?=
 =?utf-8?B?STkwYzlQc0FIZG1qNUJhMEE5aVNLOFpkdFdEOThod2QwL2JNUGpBL2JlSUtr?=
 =?utf-8?B?VytPVDRCR1hCOHViU0dnWDhUTC9rY3NqbmtoNzhFOXIzcnN6eFROOWErOWtT?=
 =?utf-8?B?eUVLNlhDMWhaQU5ZeEx4VG5NS1BaM01aeEZUY3g4eFkxblhtd0E2ODVIQmdm?=
 =?utf-8?B?SEdjdW5vUVJHbnpLT0FGWEZOMXZlanZOZDB1T3ZNVGNmSXBQY05QSXdENU9F?=
 =?utf-8?B?ekEwaFZpNlV4YTJ6ZjkyUjBFeU5rVGRCY0RMMDVPNVNReXNyWksveW1wOUE0?=
 =?utf-8?B?STFuSGczYVdWeXZvRVZCNnRRV2xrTW5kVW1WZ1krNE1kaEE1cEhSaTlWeDB5?=
 =?utf-8?B?VjI1ejlKWGN6NFNuUzNWUHZvaitwWnMzendNN0Z0ZGZMV3lkbWdrSUpYbTlT?=
 =?utf-8?B?Y0hmbjJ6czJucjNHcDR3TURUbk4zYzZlNklLVVhhOWdYN2t4eWxVQlErUmRN?=
 =?utf-8?B?RVBCQWErL0xyQkUrOTRJNENXZEtHcmN3dWVVekRNVlBjaFRrdDAzSTBWL2tW?=
 =?utf-8?B?Mk10QVNSZzUzYVJveEhqYUhGL1JPRUNPaG4xTHlMV1FHdTJVSDFxMmQyR0cx?=
 =?utf-8?B?WWF6N3lDdU5lRlVXZXJleThuM3F1aWR5Q3BWQ3Vudy94SlF6WjhCY21CT0h0?=
 =?utf-8?B?Rkl1SGVsVDFqVGJwM2hxcU8wcERCVXJZek9QaW5Kb0ZLRU1XUlFWZW8rREwv?=
 =?utf-8?B?aXBqSTEyaGFkRFgwMm9VbHNxRXU3Ykg1TDdZMFZvcGJwUXZDYTNTRjNvZ1Q2?=
 =?utf-8?B?aUp1V1JHU3g1Z1JMZW9FcGtkY3U3cHdMMXN4L2trcjNneTBRZmRNMVVNQStR?=
 =?utf-8?B?aG92a1FGQnNrY3d3V3hnU3NkbTV5aDNCdmFTUFRObjQ3T2ROclBhUkMzNVN4?=
 =?utf-8?Q?hA1fJm7rolQznPgJ3Z+LkS4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEMxb2IzVC9WMmFuOG1CQkVrRm83bmJPWHNackRGSGVoTjh5NXVBR1lVd2ha?=
 =?utf-8?B?a0FldXhub001Nkw4SkJ2aE1CK3BLZVVYS0JFcXlwRWcyeUtnUVNHa1lvMGlw?=
 =?utf-8?B?RFc4RlhDeFNHN25sQ2V5dDFGSGFLdXNrcHF2czNjRzVKODJlYk9qYjhiRGRR?=
 =?utf-8?B?c01sZE1uaUhBZlQ5WHA5QjI0eG50V3daNUJGdUJEanRsTG8wbld5MFdyb3Vx?=
 =?utf-8?B?OHdFOTRYU3NTYm81OEJMcHoxRFEybm54c2djUGZualFxNFpTVVNNV1hJTy81?=
 =?utf-8?B?c1dLbXVNZWREOENiUG96d0lQQXBUaW11RjhwMFlmc1I5dFVNaGF3MHpVYkV6?=
 =?utf-8?B?TVBIcHUxYloxYWZNYlRUeStscXl1eHEvbzg3UDlTbW50UExjUW5rbS9jWHFJ?=
 =?utf-8?B?U3A5ODF1dUZoZS9Pbk1KYkRiZXMyZUcyTmpkbnhVZVpzdFF1ZzVrWUYrb29k?=
 =?utf-8?B?ZGZaelJkTStRWTVIbTRQakZRY3Rjekd5Y2RvYUJNNTU1aWZITnE1enQ4RWlr?=
 =?utf-8?B?UEdXdmptQUg4VHlQaWNqdVJCck9ZdGxxem5kR25uY29BNk54RzFESm9qZytY?=
 =?utf-8?B?cHhUSWVaalp2RU9MbVkrMDhwcU9ocWVqTGJPT0o3RXZXYXBoZkpCUzgrK2Zq?=
 =?utf-8?B?Y2VseUFqRUxNUG0weXVZcGVIYitzU016M0lnSVlXOXpDYmswQ2ExS1V3RFVL?=
 =?utf-8?B?cVdxVDFueVZHQ1NJYXpETDh5QTk1T0VTZG1xejZJRGU5alVjeEpLeVJzV1dx?=
 =?utf-8?B?UHJldXhadEJDWXJVRXd2Qzl0bkR0VnV2bG85MnBzNUE3Z01ITmJobVYyYjgw?=
 =?utf-8?B?VVpJTGlOTEU0K3dKTDhHVy9hNlVzVjljREFzVVVZY215d3VjSWVYRTJsbzVN?=
 =?utf-8?B?YUJNTHJrTWlrZ1czY0NNL3RXc2owOGlUb1ZCelFwWllYYVljQVhrNXhtZEpi?=
 =?utf-8?B?Nk5sajFIc1d1dkZSSEg3bEFmck1scklMdmptS0gzaVZ6emR4WkV4cnhtSnZF?=
 =?utf-8?B?cCtXWXM2bmVISGN4WjRtWE53MUkzZkxGY1RickN3L0M1YjlyM054b2dCOTdu?=
 =?utf-8?B?a1lxajArUEp4SE9ieVFmaElGUlJOb2loVG9uTStQTEZIZkp6WXNPaVpGVGEx?=
 =?utf-8?B?ZkJYZ1RZd1MxenU2bjNqRFJHY3I1TDlOSTRBSHZVWC96Y3NtZ01ZVnF1UW1u?=
 =?utf-8?B?VTc5cHRqYzdDYzh2ZFNGTlR3WUxjWHc2Y09qTmNOeGtoNTJKWm1WUlRrY1g2?=
 =?utf-8?B?TDdGYXpJd2VGd2RSTjNEVi9iNzJHUkVVZy8zb2lJeDlkVVB5aGxGc2NJL3VG?=
 =?utf-8?B?MXZLZzdCMGVkcWkwdjNyN3E0Z2lzQk4zT3AyVkZyRGZsS0lUVmdDMFFjalM2?=
 =?utf-8?B?c3MrWnVSZ0dOR2xkMWg0L0g1RTJtYzMreHlIcDFtYU5RSVJCVkJ4d1pWRDJw?=
 =?utf-8?B?QkoyYU5JMEViQkNxTENCVkhIbTBCb3hTcDJKd0RWUzBTMlBUZVQvRmlSNnB3?=
 =?utf-8?B?cWkxdnl5M1NIcnVXb1ozSFVadHpNdlBPanFPWkxWNWcvMjZ3L2xrckd6OXpv?=
 =?utf-8?B?RTFXNVM4UVJnbTJYSmZBK0tOWVV3VFY3bHJkSVA1SHM0aEZFVHJJaFc2QXpo?=
 =?utf-8?B?ejJjV0NCSkdvTlhCU2dXUWJKalZLUkhhdHBZZ3BXWm56dndoVnNxVnArS2pH?=
 =?utf-8?B?ZXFHWGd3TXRMenJlZEFaNE9kR1ZPQXB4QnpvY2NKanA5N2RUL0hkQ3BhaVFW?=
 =?utf-8?B?MFpOTTVscXlpUml6dGoyS1FnbHFLaE4xaTVVN0VUaEExUm1qRjRNWUhsY1lQ?=
 =?utf-8?B?cjZYT2VYNHUwUWNRWWxPb0JaV2tJaStHOVp1S1YwL2RvMFZSdXloVFM1Ny9J?=
 =?utf-8?B?WDdycW1zOGdFYnZsNDZEWm9qV0lyRHZqZlRGUlRxd3IyZWRZMVFQRERYOVBS?=
 =?utf-8?B?OE5PaXAyL2JPWWhIQy90NllNUzk0Q004bnVMV0ZqRzc3UkhkNnY2YkJJVWh4?=
 =?utf-8?B?amdEWEllMFp2blJMMXZKVFpSZWl1bXhvTEZFS2ZKSjRIbHZjcjl4TndoUEd5?=
 =?utf-8?B?TGNjMys3NmlxNk5hOUNrRE9ZMDhxU0ZsWmRIS3ZLR1VKN0w3MlVZL2RVT2pJ?=
 =?utf-8?B?TWs0RVYrSWdSY0xDakFTZHFrWkFDNUdldTlyUGVrSGNmZ3RRRVE1TVRQL3Ur?=
 =?utf-8?B?RjVBZkR0MWw3WC9oRG9QcGxSampZUmZETkFaOVlCdzdJQ2lYWnBqVXgwbm5B?=
 =?utf-8?B?cUNZZndtSkhQN2NsWHNVM3F2TVF4Z2RobHF5TTdmVy9pcnpZS3hNUDd4NVRW?=
 =?utf-8?Q?c3rvGCCyL+Q0XAc1lP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e540f6df-1405-4853-89cc-08de6345a2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 16:59:46.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8cgCt4MvzWvPP8Ycnm6Ha1Pb+2z1RCW16qI3PefbjlrmDoXSvsjPqd6+nAgolgnWv2YUyQOrm7YNmAkGW8bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213281-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 66107DC6D1
X-Rspamd-Action: no action

SSBwcmVmZXIgYSBzZXBhcmF0ZSBwYXRjaCB0byBnZXQgaXQgbGFuZGVkIEFTQVAuICBGb3IgdGhp
cyBvbmUsIG5lZWQgY2xhcmlmeSB0aGUgc2l0dWF0aW9uIHdpdGggQ0ksICBmb3IgdGhpcyBwYXRj
aCBhbmQgdGhlIGNoYW5nZXMgaW4gSUdUIGFyZSBpbnRlcmRlcGVuZGVudC4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWxkLCBNYXR0aGV3IDxtYXR0aGV3LmF1bGRA
aW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAzLCAyMDI2IDg6MzkgQU0NCj4g
VG86IFlhbywgSmlhIDxqaWEueWFvQGludGVsLmNvbT47IGludGVsLXhlQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgTGluLCBTaHVpY2hlbmcgPHNo
dWljaGVuZy5saW5AaW50ZWwuY29tPjsNCj4gTWF0aGV3LCBBbHdpbiA8YWx3aW4ubWF0aGV3QGlu
dGVsLmNvbT47IE1yb3playwgTWljaGFsDQo+IDxtaWNoYWwubXJvemVrQGludGVsLmNvbT47IEJy
b3N0LCBNYXR0aGV3IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NF0gZHJtL3hlL3VhcGk6IFJlamVjdCBjb2hfbm9uZSBQQVQgaW5kZXggZm9yIENQVQ0K
PiBjYWNoZWQgbWVtb3J5IGluIG1hZHZpc2UNCj4gDQo+IE9uIDAzLzAyLzIwMjYgMTU6NDgsIEpp
YSBZYW8gd3JvdGU6DQo+ID4gQWRkIHZhbGlkYXRpb24gaW4geGVfdm1fbWFkdmlzZV9pb2N0bCgp
IHRvIHJlamVjdCBQQVQgaW5kaWNlcyB3aXRoDQo+ID4gWEVfQ09IX05PTkUgY29oZXJlbmN5IG1v
ZGUgd2hlbiBhcHBsaWVkIHRvIENQVSBjYWNoZWQgbWVtb3J5Lg0KPiA+DQo+ID4gVXNpbmcgY29o
X25vbmUgd2l0aCBDUFUgY2FjaGVkIGJ1ZmZlcnMgaXMgYSBzZWN1cml0eSBpc3N1ZS4gV2hlbiB0
aGUNCj4gPiBrZXJuZWwgY2xlYXJzIHBhZ2VzIGJlZm9yZSByZWFsbG9jYXRpb24sIHRoZSBjbGVh
ciBvcGVyYXRpb24gc3RheXMgaW4NCj4gPiBDUFUgY2FjaGUgKGRpcnR5KS4gR1BVIHdpdGggY29o
X25vbmUgY2FuIGJ5cGFzcyBDUFUgY2FjaGVzIGFuZCByZWFkDQo+ID4gc3RhbGUgc2Vuc2l0aXZl
IGRhdGEgZGlyZWN0bHkgZnJvbSBEUkFNLCBwb3RlbnRpYWxseSBsZWFraW5nIGRhdGEgZnJvbQ0K
PiA+IHByZXZpb3VzbHkgZnJlZWQgcGFnZXMgb2Ygb3RoZXIgcHJvY2Vzc2VzLg0KPiA+DQo+ID4g
VGhpcyBhbGlnbnMgd2l0aCB0aGUgZXhpc3RpbmcgdmFsaWRhdGlvbiBpbiB2bV9iaW5kIHBhdGgN
Cj4gPiAoeGVfdm1fYmluZF9pb2N0bF92YWxpZGF0ZV9ibykuDQo+ID4NCj4gPiB2MihNYXR0aGV3
IGJyb3N0KQ0KPiA+IC0gQWRkIGZpeGVzDQo+ID4gLSBNb3ZlIG9uZSBkZWJ1ZyBwcmludCB0byBi
ZXR0ZXIgcGxhY2UNCj4gPg0KPiA+IHYzKE1hdHRoZXcgQXVsZCkNCj4gPiAtIFNob3VsZCBiZSBk
cm0veGUvdWFwaQ0KPiA+IC0gTW9yZSBDYw0KPiA+DQo+ID4gdjQoU2h1aWNoZW5nIExpbikNCj4g
PiAtIEZpeCBrbWVtIGxlYWsgaXNzdWVzIGJ5IHRoZSB3YXkNCj4gPg0KPiA+IEZpeGVzOiBhZGE3
NDg2YzU2NjggKCJkcm0veGU6IEltcGxlbWVudCBtYWR2aXNlIGlvY3RsIGZvciB4ZSIpDQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2Ni4xOA0KPiA+IENjOiBTaHVpY2hlbmcgTGlu
IDxzaHVpY2hlbmcubGluQGludGVsLmNvbT4NCj4gPiBDYzogTWF0aGV3IEFsd2luIDxhbHdpbi5t
YXRoZXdAaW50ZWwuY29tPg0KPiA+IENjOiBNaWNoYWwgTXJvemVrIDxtaWNoYWwubXJvemVrQGlu
dGVsLmNvbT4NCj4gPiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+
DQo+ID4gQ2M6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKaWEgWWFvIDxqaWEueWFvQGludGVsLmNvbT4NCj4gDQo+IFVubGVzcyBJJ20g
YmxpbmQsIGl0IGxvb2tzIGxpa2UgdGhlcmUgaXMgc29tZSBtaXNzaW5nIHZhbGlkYXRpb24gb24g
dGhlIHBhdF9pbmRleA0KPiBjb21pbmcgZnJvbSB1c2Vyc3BhY2UgYWxzbywgd2hlcmUgd2UgY2Fu
IHRyaWdnZXIgT09CIGtlcm5lbCByZWFkIHdoZW4NCj4gY2FsbGluZyBnZXRfY29oX21vZGUoKSwg
aWYgbWFsaWNpb3VzIHVzZXIgZ2l2ZXMgeW91IGEgYm9ndXMgdG9vIGxhcmdlIGluZGV4LiBJDQo+
IHRoaW5rIHdlIG5lZWQgdG8gZml4IHRoYXQgYWxzbywgbWF5YmUgYXMgYSBzZXBlcmF0ZSBwYXRj
aCBpbiB0aGlzIHNlcmllcyBvciBqdXN0DQo+IHNlbmQgYXMgc2VwZXJhdGUgZml4IGFuZCBnZXQg
aXQgbGFuZGVkIEFTQVA/DQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtX21hZHZpc2UuYyB8IDU1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtX21hZHZpc2UuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtX21hZHZpc2UuYw0KPiA+IGluZGV4IGFkZDlhNmNh
MjM5MC4uYmY0MWZlNzVhMzM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94
ZV92bV9tYWR2aXNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm1fbWFkdmlz
ZS5jDQo+ID4gQEAgLTc0LDcgKzc0LDcgQEAgc3RhdGljIGludCBnZXRfdm1hcyhzdHJ1Y3QgeGVf
dm0gKnZtLCBzdHJ1Y3QNCj4geGVfdm1hc19pbl9tYWR2aXNlX3JhbmdlICptYWR2aXNlX3INCj4g
PiAgIAkJfQ0KPiA+DQo+ID4gICAJCW1hZHZpc2VfcmFuZ2UtPnZtYXNbbWFkdmlzZV9yYW5nZS0+
bnVtX3ZtYXNdID0gdm1hOw0KPiA+IC0JCShtYWR2aXNlX3JhbmdlLT5udW1fdm1hcykrKzsNCj4g
PiArCQltYWR2aXNlX3JhbmdlLT5udW1fdm1hcysrOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICAgCWlm
ICghbWFkdmlzZV9yYW5nZS0+bnVtX3ZtYXMpDQo+ID4gQEAgLTM1Miw2ICszNTIsNDMgQEAgc3Rh
dGljIHZvaWQgeGVfbWFkdmlzZV9kZXRhaWxzX2Zpbmkoc3RydWN0DQo+IHhlX21hZHZpc2VfZGV0
YWlscyAqZGV0YWlscykNCj4gPiAgIAlkcm1fcGFnZW1hcF9wdXQoZGV0YWlscy0+ZHBhZ2VtYXAp
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIGNoZWNrX3BhdF9hcmdzX2FyZV9zYW5l
KHN0cnVjdCB4ZV9kZXZpY2UgKnhlLA0KPiA+ICsJCQkJICAgIHN0cnVjdCB4ZV92bWFzX2luX21h
ZHZpc2VfcmFuZ2UNCj4gKm1hZHZpc2VfcmFuZ2UsDQo+ID4gKwkJCQkgICAgdTE2IHBhdF9pbmRl
eCkNCj4gPiArew0KPiA+ICsJdTE2IGNvaF9tb2RlID0geGVfcGF0X2luZGV4X2dldF9jb2hfbW9k
ZSh4ZSwgcGF0X2luZGV4KTsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkg
KiBVc2luZyBjb2hfbm9uZSB3aXRoIENQVSBjYWNoZWQgYnVmZmVycyBpcyBub3QgYWxsb3dlZC4N
Cj4gPiArCSAqIE90aGVyd2lzZSBDUFUgcGFnZSBjbGVhcmluZyBjYW4gYmUgYnlwYXNzZWQsIHdo
aWNoIGlzIGENCj4gPiArCSAqIHNlY3VyaXR5IGlzc3VlLiBHUFUgY2FuIGRpcmVjdGx5IGFjY2Vz
cyBzeXN0ZW0gbWVtb3J5IGFuZA0KPiA+ICsJICogYnlwYXNzIENQVSBjYWNoZXMsIHBvdGVudGlh
bGx5IHJlYWRpbmcgc3RhbGUgc2Vuc2l0aXZlIGRhdGENCj4gPiArCSAqIGZyb20gcHJldmlvdXNs
eSBmcmVlZCBwYWdlcy4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGNvaF9tb2RlICE9IFhFX0NPSF9O
T05FKQ0KPiA+ICsJCXJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBt
YWR2aXNlX3JhbmdlLT5udW1fdm1hczsgaSsrKSB7DQo+ID4gKwkJc3RydWN0IHhlX3ZtYSAqdm1h
ID0gbWFkdmlzZV9yYW5nZS0+dm1hc1tpXTsNCj4gPiArCQlzdHJ1Y3QgeGVfYm8gKmJvID0geGVf
dm1hX2JvKHZtYSk7DQo+ID4gKw0KPiA+ICsJCWlmIChibykgew0KPiA+ICsJCQkvKiBCTyB3aXRo
IFdCIGNhY2hpbmcgKyBDT0hfTk9ORSBpcyBub3QgYWxsb3dlZCAqLw0KPiA+ICsJCQlpZiAoWEVf
SU9DVExfREJHKHhlLCBiby0+Y3B1X2NhY2hpbmcgPT0NCj4gRFJNX1hFX0dFTV9DUFVfQ0FDSElO
R19XQikpDQo+ID4gKwkJCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwkJCS8qIEltcG9ydGVkIGRtYS1i
dWYgd2l0aG91dCBjYWNoaW5nIGluZm8sIGFzc3VtZQ0KPiBjYWNoZWQgKi8NCj4gPiArCQkJaWYg
KFhFX0lPQ1RMX0RCRyh4ZSwgIWJvLT5jcHVfY2FjaGluZykpDQo+ID4gKwkJCQlyZXR1cm4gZmFs
c2U7DQo+ID4gKwkJfSBlbHNlIGlmIChYRV9JT0NUTF9EQkcoeGUsIHhlX3ZtYV9pc19jcHVfYWRk
cl9taXJyb3Iodm1hKQ0KPiB8fA0KPiA+ICsJCQkJCSAgICB4ZV92bWFfaXNfdXNlcnB0cih2bWEp
KSkNCj4gPiArCQkJLyogU3lzdGVtIG1lbW9yeSAodXNlcnB0ci9TVk0pIGlzIGFsd2F5cyBDUFUN
Cj4gY2FjaGVkICovDQo+ID4gKwkJCXJldHVybiBmYWxzZTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlyZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBib29sIGNoZWNrX2Jv
X2FyZ3NfYXJlX3NhbmUoc3RydWN0IHhlX3ZtICp2bSwgc3RydWN0IHhlX3ZtYQ0KPiAqKnZtYXMs
DQo+ID4gICAJCQkJICAgaW50IG51bV92bWFzLCB1MzIgYXRvbWljX3ZhbCkNCj4gPiAgIHsNCj4g
PiBAQCAtMzg4LDEyICs0MjUsMTIgQEAgc3RhdGljIGJvb2wgY2hlY2tfYm9fYXJnc19hcmVfc2Fu
ZShzdHJ1Y3QNCj4geGVfdm0gKnZtLCBzdHJ1Y3QgeGVfdm1hICoqdm1hcywNCj4gPiAgIAlyZXR1
cm4gdHJ1ZTsNCj4gPiAgIH0NCj4gPiAgIC8qKg0KPiA+IC0gKiB4ZV92bV9tYWR2aXNlX2lvY3Rs
IC0gSGFuZGxlIE1BRFZpc2UgaW9jdGwgZm9yIGEgVk0NCj4gPiArICogeGVfdm1fbWFkdmlzZV9p
b2N0bCAtIEhhbmRsZSBtYWR2aXNlIGlvY3RsIGZvciBhIFZNDQo+ID4gICAgKiBAZGV2OiBEUk0g
ZGV2aWNlIHBvaW50ZXINCj4gPiAgICAqIEBkYXRhOiBQb2ludGVyIHRvIGlvY3RsIGRhdGEgKGRy
bV94ZV9tYWR2aXNlKikNCj4gPiAgICAqIEBmaWxlOiBEUk0gZmlsZSBwb2ludGVyDQo+ID4gICAg
Kg0KPiA+IC0gKiBIYW5kbGVzIHRoZSBNQURWSVNFIGlvY3RsIHRvIHByb3ZpZGUgbWVtb3J5IGFk
dmljZSBmb3Igdm1hJ3MNCj4gPiB3aXRoaW4NCj4gPiArICogSGFuZGxlcyB0aGUgbWFkdmlzZSBp
b2N0bCB0byBwcm92aWRlIG1lbW9yeSBhZHZpY2UgZm9yIHZtYSdzDQo+ID4gKyB3aXRoaW4NCj4g
PiAgICAqIGlucHV0IHJhbmdlLg0KPiA+ICAgICoNCj4gPiAgICAqIFJldHVybjogMCBvbiBzdWNj
ZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLg0KPiA+IEBAIC00NDIsMTMg
KzQ3OSwyMSBAQCBpbnQgeGVfdm1fbWFkdmlzZV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
LA0KPiB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbA0KPiA+ICAgCWlmIChlcnIgfHwg
IW1hZHZpc2VfcmFuZ2UubnVtX3ZtYXMpDQo+ID4gICAJCWdvdG8gbWFkdl9maW5pOw0KPiA+DQo+
ID4gKwlpZiAoYXJncy0+dHlwZSA9PSBEUk1fWEVfTUVNX1JBTkdFX0FUVFJfUEFUKSB7DQo+ID4g
KwkJaWYgKCFjaGVja19wYXRfYXJnc19hcmVfc2FuZSh4ZSwgJm1hZHZpc2VfcmFuZ2UsDQo+ID4g
KwkJCQkJICAgICBhcmdzLT5wYXRfaW5kZXgudmFsKSkgew0KPiA+ICsJCQllcnIgPSAtRUlOVkFM
Ow0KPiA+ICsJCQlnb3RvIGZyZWVfdm1hczsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICAgCWlmIChtYWR2aXNlX3JhbmdlLmhhc19ib192bWFzKSB7DQo+ID4gICAJCWlmIChhcmdzLT50
eXBlID09IERSTV9YRV9NRU1fUkFOR0VfQVRUUl9BVE9NSUMpIHsNCj4gPiAgIAkJCWlmICghY2hl
Y2tfYm9fYXJnc19hcmVfc2FuZSh2bSwNCj4gbWFkdmlzZV9yYW5nZS52bWFzLA0KPiA+ICAgCQkJ
CQkJICAgIG1hZHZpc2VfcmFuZ2UubnVtX3ZtYXMsDQo+ID4gICAJCQkJCQkgICAgYXJncy0+YXRv
bWljLnZhbCkpIHsNCj4gPiAgIAkJCQllcnIgPSAtRUlOVkFMOw0KPiA+IC0JCQkJZ290byBtYWR2
X2Zpbmk7DQo+ID4gKwkJCQlnb3RvIGZyZWVfdm1hczsNCj4gPiAgIAkJCX0NCj4gPiAgIAkJfQ0K
PiA+DQo+ID4gQEAgLTQ4NSw4ICs1MzAsOCBAQCBpbnQgeGVfdm1fbWFkdmlzZV9pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LA0KPiB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbA0K
PiA+ICAgZXJyX2Zpbmk6DQo+ID4gICAJaWYgKG1hZHZpc2VfcmFuZ2UuaGFzX2JvX3ZtYXMpDQo+
ID4gICAJCWRybV9leGVjX2ZpbmkoJmV4ZWMpOw0KPiA+ICtmcmVlX3ZtYXM6DQo+ID4gICAJa2Zy
ZWUobWFkdmlzZV9yYW5nZS52bWFzKTsNCj4gPiAtCW1hZHZpc2VfcmFuZ2Uudm1hcyA9IE5VTEw7
DQo+ID4gICBtYWR2X2Zpbmk6DQo+ID4gICAJeGVfbWFkdmlzZV9kZXRhaWxzX2ZpbmkoJmRldGFp
bHMpOw0KPiA+ICAgdW5sb2NrX3ZtOg0KDQo=

