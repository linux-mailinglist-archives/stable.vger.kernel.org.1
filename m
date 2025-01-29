Return-Path: <stable+bounces-111094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BCA219AB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05C51640EB
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B27919F10A;
	Wed, 29 Jan 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtcN3Yrq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B5194147;
	Wed, 29 Jan 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141655; cv=fail; b=debKIuuEkNtAau8zTLnSNXNkRaQVkUU4yuDjDFVDjiHDhucXFopV66cc9dftXyhnrp0gvEKSwpQFdMBKOmSNNIvrj2BJbiqLdsZvUleRAYWKlG/vw1/NlNUA0DyVhNHxlisA2VlCd9UotIwbfnnqtW9+cEO0CWB4H5L/Fzp8rvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141655; c=relaxed/simple;
	bh=UhPS4tO9tLqvzxUScFwmtVmRFiq2xhUHo0X+iu02bwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gv0ubhC6bv2FFL8D1rRrLz+MwCw18xJeUCT/+xbecOZ+pBh6GGmIUrKDVn0nEKiJH/f31vudks38ErpT6ZnSBW/aZDiA8PzUjZYPjOiTWJP2k0crwOraw2s/TY7hp4PRK0JsoFmHBc5LaIMExDLVu+d9J4znihlhmZXTRosm8SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtcN3Yrq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738141653; x=1769677653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UhPS4tO9tLqvzxUScFwmtVmRFiq2xhUHo0X+iu02bwo=;
  b=AtcN3YrquVYVf3mUWY7TmWG297i6cJR5MLUKEMDTWMUgcHuZECBLjHHG
   BWaPboFYn7ZymqhgCoC7xb9FahgaldduOVQxw1sdwOEImh2zRPzM1VfEu
   TDuuPvkM+SxhM4IIMbkjXCXNIauMowSJpSb5yauOg9Rhy4fs5psb48P6P
   OxvOcujWYy6Kl85RBvnuE9w/2Z935ZobB/6OtlAf3d5/xmozhusU2g/4K
   zLLS1n5wA2xObS15Mr089rlzJBS3rYa9mTq2TZb0JIoJr4G270vRfyjMH
   zf63edaEnl5kqffHVCT1OR3mW4r1DwM+WerSjU85IzVYPH4bassfiUXjy
   A==;
X-CSE-ConnectionGUID: BHHSsbTxQ+es3r5W+ZuhRQ==
X-CSE-MsgGUID: dnVr3UAsQN+miRS2m739fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="42303184"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="42303184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 01:03:37 -0800
X-CSE-ConnectionGUID: uMIP0aoITW6zozkOY8CK0A==
X-CSE-MsgGUID: mQCm4JDpQiyIj4ZtWAhjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="108780615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 01:03:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 01:03:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 01:03:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 01:03:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igc/ak2R4hNy/KD4luzDtw0C5Ga/nR6aT6cpI2nhbqDfNMEWbywqd6izRzbyhFC03Hto3LU71EbMu6YvUEd7Xs78ZuiZoO6BsnJda99YvsqetdZX9lMJZIsna+Pm4iXMkCq3GMxLnlZB5XseRB8sOvR++DWz+C2crwvTzB4W9/avebKUpqVibfpHislgC7HFPMrHq27Svkmjxjv5MPr3PThDVwkUEpYeakEpN2plfRqtYMNtcrSpLnFjady1e9kuiZBjqbkQkZPLZzS0YkOXxY+juKEL9odUotd3V1uFHSgblhVcsUqGcu3CWgF506Y1S5xgCVK72YOfdXUwvWh9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhPS4tO9tLqvzxUScFwmtVmRFiq2xhUHo0X+iu02bwo=;
 b=klpd1ELv9t+tnhrsCYbGofv25NGEn3QarQs7dLnI02kaCAJ418DVc1ewg805ZQZnvWFtDUf6KKLtk4PkalM2fYOnkTfAfwMiYdGnIMOvpEZqJcSKu5r4sRHrpRUM799NB2kLV4MTI/SbNA/8oMWsjvM65FXVZnjvLWt6Jf/ZSwO8aPnKeu2/ofIqchtNpY8jgoypEt+g114Ztc5ZGnAYfYbfxCr7w0UWA5Zm4r3qoDsxIL5fgQHm2YCsiWDunwzzu14Q+bpuI7I0i/JGCeMIzEm2ejcTA0/PnXc3OJh0pPki4OMnjjeGlKlGLOhPMOkAemgAc2HuP/cKxPVS+0S72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 09:02:58 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 09:02:58 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux@treblig.org" <linux@treblig.org>, Shen Lichuan
	<shenlichuan@vivo.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] mtd: rawnand: cadence: use dma_map_resource for
 sdma address
Thread-Topic: [PATCH v2 2/3] mtd: rawnand: cadence: use dma_map_resource for
 sdma address
Thread-Index: AQHbZ8ZSebLix6oqu0OjDvIjtrQsjrMhBSf2gAyDY9A=
Date: Wed, 29 Jan 2025 09:02:58 +0000
Message-ID: <BL3PR11MB653280E16A4399DDBB300CA8A2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-3-niravkumar.l.rabara@intel.com>
 <87ed0wpk6h.fsf@bootlin.com>
In-Reply-To: <87ed0wpk6h.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|PH0PR11MB5031:EE_
x-ms-office365-filtering-correlation-id: ef0c5714-831f-4a2d-fa43-08dd4043b9f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cW53WTJGNzJTcmhjZVd5bzc4Y3FNZUJ3cDVTMnhWUFFOcjdsNlpkM1pSUGVv?=
 =?utf-8?B?V0tHT1ZoSnZkMlFRekt5R0R6OWprbGMveStTWkg3cElZL0JDaUM5R2xQamNq?=
 =?utf-8?B?eGoyRm1hUzNBaDhOM1dKS2xSc3R5dzNmMEU5OGYvTkU0cGRlYWFwMEh2aHhN?=
 =?utf-8?B?SVVHWXJ4dStXcU84VklBR28vV3RoQkdHSC9VUVFOaXJmRFdidkxIVW9xWFAr?=
 =?utf-8?B?RUlFMk1jMk9LUDAxOXBKcksySm9tYXN5VFZpdlUxemp0QWI5NzlEcGN6TlNo?=
 =?utf-8?B?WWxyTVlYY0xQMW1BbTNwYTJMUFl1TVpuZ3BiSk5WMnlJejg5ZG51b1RGQS8v?=
 =?utf-8?B?VTZURmkzUkl1TzlVUnJGaG5LZGFDT3F0MTFqY0NEalIrTUF5U1pxRmkyNXJa?=
 =?utf-8?B?blgvQWUwVEYwYjdidHRQNFZqT2lxQm5NOGhZQURrcFEwTFpSMUNmY3lqc3Bx?=
 =?utf-8?B?N1dwcXlGNnNZSWVjY1VhWTFEK3VyTTlYOTRwM2xwZ2ZVMVh5NVJqQ0libzhp?=
 =?utf-8?B?MXExekNMZFFWTlBTWFMrMFpJNmlwQ1ovWkZYaHo0NTdaZ3BaK2UyTW1FRUNG?=
 =?utf-8?B?bXkvRU5KRk9nMnNOdDBNeU1xT3Jma1g3akJyME05ZFRSY25IVkhBVHJiT2Nz?=
 =?utf-8?B?M0VhS1FsaVhKZ3IzY3M3dmVGWmJjcXVQVEhyUHU0RHg1cWRVK2NlL2dkVDh2?=
 =?utf-8?B?Q2pWNzNkMnc0R2FVVG1zdU11SzBtYlNPaXNBU24vV2VuRGNDOFlHVHVsVnBL?=
 =?utf-8?B?d0FQQ0hyTW5VbGRSUHRLeVZtTnFMZkNrQjVxMU4wZElpNlczTVJSKytaQ1BF?=
 =?utf-8?B?UkpMczIvY2xuMldCemRyeFVRN2NZRnRxQVdWNzdvbTFvc3p4eiticENWQUpx?=
 =?utf-8?B?dEhFQnJFV1ZxQmhyQk45NTZWVzM1cHNIUFQyYUlFb0p3aFN6ejhWNjAvLzJl?=
 =?utf-8?B?NnByRFBVVFJYOC8xSnphS1k0T3ZHbnpDNWJKSDdDc3B6K0FFemNmeVNlMERv?=
 =?utf-8?B?RTExSFp4T2Y5YlBUZjRybk85VFRNd090TnlTeGNLUndzd2x2Ujl4d3M3aEp4?=
 =?utf-8?B?ZGh6U01uY0ZQMmNyYW5mZFlnQThVQ3NMZEhmcVlEZVpheDJOaElabzRjaHk0?=
 =?utf-8?B?THI3QktSU1ovR0dkeDhaekVGNHNiWWpwWS90eFM1blpkRDZUcVl2SFJ0amw1?=
 =?utf-8?B?dDV2Z29iOCtvMnN0STZhV1Y2K212QVpxY1pGN3YvQ1FYVm1Pb1YvMjNNdVVL?=
 =?utf-8?B?SDR2K21yaUczTXVSREJpckhraStJeVM3MFhmdFIzVVVuc1JnNTJySkVrbWpL?=
 =?utf-8?B?OUdPQ2lITnJsN1V1Myt0VFRlbUo2Q3dXclR5NjQ3THFsdTNTVjRJWnJoL2FM?=
 =?utf-8?B?enVjaFJzODNKLzNmM0JTcUdjZ2hwK3ZMQTZGQ1h6K2VTaGQrUjNDYk5KZURN?=
 =?utf-8?B?TU9qMnMvYXIrNGhVaTB4NTZlaTRXMWZLUFJCc2M3Q2VRZHR0MFZoMmIyeXhI?=
 =?utf-8?B?WUxvaXRlb3pPbWdxekpNRFNmb3A0RXFzd0hYaGhmT3JOOVFZR0R2SndYNnIz?=
 =?utf-8?B?QnljeUgxWjJYMExodkt3OUVDWXArWFB4SjlEMUZBZUd2alBHRC9NdHZycEc3?=
 =?utf-8?B?bXVpem1vSUw1aStYSTRaNURDdCtNdEJNNGx4ZGFnVFNndTRhYzdWWEtUNzRB?=
 =?utf-8?B?eTFoZ2VqZVRSZXdoZkUybThoa3k0YjNyRzZ4NDd3WFJhdWw2U3U5MVlrc3k4?=
 =?utf-8?B?RDNzb3kya0EwY2NWUHZaMkp4NkFzTzRFbnprY3hTeEg0dWJ4WkpnaElxY0RX?=
 =?utf-8?B?QnViamJwZEhNSUF3ZzlpKyswRjF0RG1BcnpvcnkxUmVkNCtHWFZmdzMrbWNi?=
 =?utf-8?B?QzNBOFlWLy81MWo1ajhMTGgxckoxRGZpNDJBYkRpbXBmODQ4YVFIMVdvQWFJ?=
 =?utf-8?Q?6TPBGZmGwe9GUanpKRmlvqWDD04KkSjS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNUUVhieHpWVGtWbHBZVVdob0RXTExZMks4ZkJ6Zkp2aTZrMXVqcGU3b1RT?=
 =?utf-8?B?YVpsN1Y0QW5qd1Z3aVNVZFJ0VkZwUmRqM3djOG9GM0JWcW1wOVY1aFp3czJC?=
 =?utf-8?B?WHBrYWh5bVpKaG5lUHgyaXJ6Zy9nOXVpZFpzL3JHM090SGsrZG55bktqK1d5?=
 =?utf-8?B?KzJEMTZGdW5rdWp4NGhSQmZ2RVVMQXY3bENuY1FlUTJQNzdhOGkxQUNMcUJ4?=
 =?utf-8?B?UzlvQ2hCTkNiQTVId1J0Mnc3ZlRlc0N3T0hyeUFVaTgyNnFvdVNHeExwWVVj?=
 =?utf-8?B?dlJUN0I2L05saTc4U1IzQ3J1NU96QTRiaG9HNkVPYWJ4cHZwWFFWWllzanZt?=
 =?utf-8?B?bGY3QW5SMmJMRS82WGZLM3RINEdzeEhVTnVHbmZBOUNlcVU2NTA4WFNEYkpT?=
 =?utf-8?B?bnN1UWJaNEdMY3I2K2FUcUtYN2VEQUUveExzaE11Q3NlMzFad1ptOVc2aVdM?=
 =?utf-8?B?Q3ZRT3N6NWE4TWQxSVdzUndQa0plQ3JvY0dWSENVZXZJOXkwWjZlMmV5d05N?=
 =?utf-8?B?eGJHOXpCNHU2dUo0MXRlQkV5RUFTOFJXMndNVGtGVFRlREdtd2xBSU5JV1NY?=
 =?utf-8?B?VVdUd3hYMzY5MUVuZkpLMGJ1NFB6Wnl3d0V2L2t0NERadGtEdWJDY0tNeXFm?=
 =?utf-8?B?Ukt5aytnaFUrTE5vVVdVRUZDaGtNQURoK3NDc2dYVjFRZE5ibzFmK2oxeXZl?=
 =?utf-8?B?WnlXZHZVS0puM1FjKzRmdTkxRVk2NVIwUVJCY2JXZWZYcEtMZkxKZmJWcStY?=
 =?utf-8?B?Wm1oNlU3dUo1a0NvU1BoT0tQdlJOOUY1Yy9lTXFhdVBkYzJqVlRoaEQyczdu?=
 =?utf-8?B?TlNCU2JGb214ckxESXUyZldCcWhPZitYcWZtL1EyamxueWtnMVRXRFlVckVt?=
 =?utf-8?B?dGpESlNueG5TWXNPT3ZmTHM2RnhFeVZ4VzBLbUdON0NqWmtmWXZEcWhOajRY?=
 =?utf-8?B?SS9oejlpQzRTSjZGOTA2NGhlNDNZTUdFbmNXbUUySXM2Z0hZNnJqMzFZUm9s?=
 =?utf-8?B?U2xOdjAzMUI1cEllS1V1c2h4SXdMOGJOanJRWk94MHhWWEt4UEhGNlNsbmxI?=
 =?utf-8?B?d3hadUVSZTlYbXhib2pKbGl3YUQzTHZ2ZGRuRGRMZG9QLzNObmd1elNLRzVY?=
 =?utf-8?B?YmVacEpzSGIrN28yUHJXL0VuRm9VQTNweW9CL05mVnFyMGkwOWgvV0Q4MnJM?=
 =?utf-8?B?QVp5TlNtc1hBOTNLK2tZSzNPUHNJUUlPU3RPd0s2ZVZsVWl1MVkvZkNXaGFI?=
 =?utf-8?B?YWtlRW5QVmlhRUhkcStiOEx6QTNGMitiQTRLSE1PNlhNWGZVdG15MUtoNjIr?=
 =?utf-8?B?MzZ5ZUZvbytPMnZRaysxZVd5TWM3bXRZckZhRzVGYXlJclI4ZmpTRUR4c1lI?=
 =?utf-8?B?a0hWV3RZdTJxcnRScGRrbW05N29qQVZ4SzkzYUtXOElRMmFlZzhJSTkyTHhX?=
 =?utf-8?B?d29YVVRPbzJoU1NEcnhKOWtQQzRUclJTWG55MTk1TUFsa08wSWlzMk44WDhG?=
 =?utf-8?B?cjlkS1o1WEVnZzJnTkxNdG1mUFcyUDBwZTU1K0VtRUh0TlRkdFF0ZHFSbHVU?=
 =?utf-8?B?dTZmbUg1SkNTcVZ2ZDVrOFhTK2VZcWROVlplTDlqRnNsL2ViZTlnb0VtTGhN?=
 =?utf-8?B?R3JaQmhVR1FZbG85V1hZQXF5RlFzb1FQOW1WbEJDc25pazNOTEJMdXV1NVpn?=
 =?utf-8?B?Uk1VQkV4Z1NQZFE3WVdjTkRuNmduTnYzN0pZSjIxWE1XeGtCVWMyMVFNUDVt?=
 =?utf-8?B?Mm1kRW00cHdGZE5tVkxFdjVPL1pvaGdlMW9TcXB5VzgrN2MySkhtRUZlcjdz?=
 =?utf-8?B?SEo5MEVLblliYWwyZEMrOEtIb1pjMUNZaFBuR3d3Lzl2dUY0cTV4SWdNTmdn?=
 =?utf-8?B?bGxVcmh1SWhZN0NkUmtibmh0RVk0WlNuK3gxVG9QUGthZUZYdmNEV011OEEy?=
 =?utf-8?B?MnJ0MU1jMmpaSkVGSzBaWnBpYVhUUkRlNlk2YnZIdVdkbXo1T3VTVkNVZ05l?=
 =?utf-8?B?Z3phU1JkWllFZ0gyTzZvNGxYcUtocmNqOTlCMWM4blEvbkJHVU9hWHBaYXpm?=
 =?utf-8?B?VzAvSzNYcmtLR0NqTC80RnhqQXNaL05WUFpnSTA5RHRxVmNPSlk3TTlmNTZ3?=
 =?utf-8?B?WXgwSlE1dzRZem5JcFZWSmhuSmhRR0Vab2I5RFBUM3BuenJnN1Q3M3VIUzhs?=
 =?utf-8?B?cUtnTER0Z1BESHdvYUtBZEYvWk1zc0Q2SWtTMjVCOEh4aWlSYlJCWndOdVV2?=
 =?utf-8?B?dzc5WEhWbnZrOFpJOGRQT3orc1NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c5714-831f-4a2d-fa43-08dd4043b9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 09:02:58.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEZNEPcG+nOVfYeLAp04xYUD/qM9wxpfjICR/xzUWbk0rcrPmgiDgJS6mvSk4WqR/XOtrd8+5ncRgC2kjrx3C5LS4H6iLG5GQBC4qge3pmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDIx
IEphbnVhcnksIDIwMjUgNTo1MyBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2
a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IGxp
bnV4QHRyZWJsaWcub3JnOyBTaGVuIExpY2h1YW4NCj4gPHNoZW5saWNodWFuQHZpdm8uY29tPjsg
SmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IHUua2xlaW5lLQ0KPiBrb2VuaWdA
YmF5bGlicmUuY29tOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAyLzNdIG10ZDogcmF3bmFuZDogY2FkZW5jZTogdXNlIGRtYV9tYXBfcmVz
b3VyY2UNCj4gZm9yIHNkbWEgYWRkcmVzcw0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAxNi8wMS8y
MDI1IGF0IDExOjIxOjUzICswOCwgbmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20gd3JvdGU6
DQo+IA0KPiA+IEZyb206IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5pcmF2a3VtYXIubC5yYWJhcmFA
aW50ZWwuY29tPg0KPiA+DQo+ID4gTWFwIHRoZSBzbGF2ZSBETUEgSS9PIGFkZHJlc3MgdXNpbmcg
ZG1hX21hcF9yZXNvdXJjZS4NCj4gPiBXaGVuIEFSTSBTTU1VIGlzIGVuYWJsZWQsIHVzaW5nIGEg
ZGlyZWN0IHBoeXNpY2FsIGFkZHJlc3Mgb2YgU0RNQQ0KPiA+IHJlc3VsdHMgaW4gRE1BIHRyYW5z
YWN0aW9uIGZhaWx1cmUuDQo+IA0KPiBJdCBpcyBpbiBnZW5lcmFsIGEgYmV0dGVyIHByYWN0aWNl
IGFueXdheS4gRHJpdmVycyBzaG91bGQgYmUgcG9ydGFibGUgYW5kDQo+IGFsd2F5cyByZW1hcCBy
ZXNvdXJjZXMuDQo+IA0KDQpEbyB5b3UgdGhpbmsgdGhlIGNvbW1pdCBtZXNzYWdlIGJlbG93IHdv
dWxkIGJlIGJldHRlciwgb3IgDQpzdGljayB3aXRoIHRoZSBleGlzdGluZyBvbmU/DQoNClJlbWFw
IHRoZSBzbGF2ZSBETUEgSS9PIHJlc291cmNlcyB0byBlbmhhbmNlIGRyaXZlciBwb3J0YWJpbGl0
eS4NClVzaW5nIGEgcGh5c2ljYWwgYWRkcmVzcyBjYXVzZXMgRE1BIHRyYW5zbGF0aW9uIGZhaWx1
cmUgd2hlbiB0aGUNCkFSTSBTTU1VIGlzIGVuYWJsZWQuDQoNClRoYW5rcywNCk5pcmF2DQo=

