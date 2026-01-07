Return-Path: <stable+bounces-206223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768BD001D7
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 060FF3016B95
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329929DB8F;
	Wed,  7 Jan 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKMYU/ke"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C71A76DE
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820487; cv=fail; b=hGGIFm5VY62A7CpbP49CAO5VQFar5fjpqx0Z0mWZuEwK0IG2udiNAe69ORTo2H4oyOjaSykpyPWcVaOBQJ5MSGyttDFYvrxrM4Sv2gJKmAdFXVwNT1wHwmH/2gUr0CSoCjE28AE32dSFy2dmmQqmQA2BFcBhI8ccpm4DZ2vfZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820487; c=relaxed/simple;
	bh=qmoN8Uaj/COsjr6/LCScBGLDv31E20vVrZaboRhOxw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k3atT3BH78z5xcBkz/XJflmv8gLATi+MnSyqE4et0SKTB4/INCOPGtzOG3ejSigTvyMz55fnLLm5zbDpNEGJoUfAuDAhA8fCHbI1iqAwL28EmZBfYIAQd3UjHO5E2p4fX2b8NdGoys0bIS08vvpdaGnUnSN8IxvTq6tLizeYKPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKMYU/ke; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767820485; x=1799356485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qmoN8Uaj/COsjr6/LCScBGLDv31E20vVrZaboRhOxw4=;
  b=LKMYU/keYa8YfdQVuGinf26uDAmOiauYVHVQ6xURYDiEDcUIx/6qXWcj
   CNXsRcCy/DTLbVWC+ubUtR2yOy++UGfgVBgBDF+cLl4rl1oICeFkwtfcN
   qlvucwHwAep/v3/ljGQkjJWZJ8VcYAsypipVIoSOYYGivwjnvstJRYVqD
   PGoqdx8298WMQrkZYoR2+JJW7f7UuDh1g4bLuml7uCVjAC5eqvQMva+ou
   Msc+VNJo0vOHMEsoTnIPNqrs0jK10WtSs+ARxNfZmx8a6esAxSJPr3u2E
   6tFQjZgt2qpzZkQIGfMiQZmYV0FgIVQF7ey5BBiMlOixi7Szl1XCB7VuQ
   w==;
X-CSE-ConnectionGUID: A8bZGxVASZ6cDbaTwlk/Iw==
X-CSE-MsgGUID: Y6qCpAMmQnuvTTJsh6EVMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80650699"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="80650699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:14:45 -0800
X-CSE-ConnectionGUID: pbh3wodATkGa1F7KXndaWg==
X-CSE-MsgGUID: zws0kOK/TMq6o5EOIJvlEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="202228334"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:14:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 13:14:44 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 13:14:44 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 13:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbvmFFe6eB/ktpPYFR+xGm1sFc3rZUApZapgZW+cXpMECpSsFFZuT+/F6r+X2buF0XkvYS2peDE3lP4BxE/XVa0ZLimfoTE+syQPEzzBSLReRxkWsCnob3m2k+rVptgJPtIYypYjANwgRNFQb943HKN+XBYAE+L9XTqMWTBBPYDMe6/CCuQWN6Hmb1WVlthzKKRDG5AIoIGsjQmH1tPdgGfTj9c+YAyscjduVMPpCRv3u0In0mya+AttVJdwIOiLDbNWrKgNv2Vf3mhZzzJt/+P2uSHjpRwByabuAyxh3n9KMmbvObh+tJxldgbtHYALUNMkNhRyecqnNe8nuNxsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmoN8Uaj/COsjr6/LCScBGLDv31E20vVrZaboRhOxw4=;
 b=RKJdpr9g04U2jHVvj80xFXvX02kWG05EB/GxlQV2IJ45VZkUJZCpem4k0sdZxdpRn8CAhovC2GJN3bXFRiK+/qTbC2CP7rA1daqHo1zG4RYt+kM0xZ7/vrsY9Q6dm1r2dR3LZxcc++AKnT/LMbURkLgjNJvuW90V2lre8FUog3b4traUy/2dc0dMlGx6+65TJU3Ic6tqdA5j70XqbsOPSgLX79sqIhNPampy4n50B/qnXmcnfh59OQHCEFbu/M4pRdkYHr+6/MmO7l02oVxrdTjmv7t2Wmw4FlOQeQ5GE+HIj4NVF7DRQewJLxoi3zMB8CM+X9OU2/MvvaKrUCfLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Wed, 7 Jan 2026 21:14:39 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::6a14:6aa3:4339:4415%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 21:14:39 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Brost,
 Matthew" <matthew.brost@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Alvi, Arselan"
	<arselan.alvi@intel.com>
Subject: Re: [PATCH v2] drm/xe: Adjust page count tracepoints in shrinker
Thread-Topic: [PATCH v2] drm/xe: Adjust page count tracepoints in shrinker
Thread-Index: AQHcgBhGrZAVICkH8kG0HgMrosjS/rVHNRGA
Date: Wed, 7 Jan 2026 21:14:39 +0000
Message-ID: <ee81fdabe081a413b10cce2297ea360c46502db0.camel@intel.com>
References: <20260107205732.2267541-1-matthew.brost@intel.com>
In-Reply-To: <20260107205732.2267541-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|DM4PR11MB6261:EE_
x-ms-office365-filtering-correlation-id: a0a0d764-a113-4194-5ab2-08de4e31c4a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aXp6ZHdDamlvMGY2SExOSW91RUhia2d0aHR5aEdua3NyendtNVBJQm8zMS9Y?=
 =?utf-8?B?a2JMVHlDS0pBMDIrdzFNcXhNQ3JVR3pxVzhGS0JUanZnY3hxblowNk5MK3Bk?=
 =?utf-8?B?Z3dYSDVadi8zaEEvblFRbE5ma2xDMUFWMmNELzVmVjgvVThzY3ZxNmlrOVhh?=
 =?utf-8?B?QmViQXpzRGllaUEySjI3VkN2MVBEV1ZFeSsrVmlnSXFrWGlVR1BtUElhcFh1?=
 =?utf-8?B?Uk5ObCt4bm1sOWVaU2MwVjJjZ2ZrTkJueGVjKzhpeDFqUmlMM1JRUjIxb1U5?=
 =?utf-8?B?UlJveXV3eG84Q2toS1FMZko5SUVvcWFiODA4SXFPRzdHbFFSWWRoM3I3a3JV?=
 =?utf-8?B?aHliS21ZZlE0bGRjM1BEVzBrWlN4OHpuQlhvYmJRU1g0d25ZRkxhWUZUdWFC?=
 =?utf-8?B?K1lPcDBEM0U2MmliaFEvbUhPNUk2cE5sdWpTdjIwV3J1dExETDFuNlZWRk41?=
 =?utf-8?B?dzRPSDVrRHlsbzNyanFSYlJaRi9GdjBqMFQ3K3k4V3FORldDWGN5Yyt3d2Z6?=
 =?utf-8?B?ZmdtWG1TSlFOSU42b2JZT1Yxd3BJSzdrb1NFaXBJczVmNXhjZWVLTVV2bUE0?=
 =?utf-8?B?RHVKSUZmd2VNc0xSZGRjMzcvZWpKVkJ0VW1OdGlEeTJmNUhOSjZLdHdDVXh6?=
 =?utf-8?B?VHZBWEI5MUpLaVlXWGIxL2pqWVVWMXdRZDhzNUFQMDA1d250LzNEWm44K1du?=
 =?utf-8?B?N3I1aGZkV3pERkFiV0o0NUJiTnI3a2pEQ2VUK0d1Q1k3MVZ0OFJ0ai9JRS9v?=
 =?utf-8?B?ZWszcDZWNXJGWEg2V3Y5UjBHMHk2S3hKbFZkVGQ2b3hqOTg4TUVYM1l5dDFF?=
 =?utf-8?B?anpsYVg0OEZManVVcVJXRS9LU2VLS1Q1bmZtR2dCVC84TVozL0RBOUJCd29R?=
 =?utf-8?B?YXZxY1VJVHBnV09obVVKU002L2JXMVNRamQvR0Z1cjd1Szl3WVFDcHdjUkMy?=
 =?utf-8?B?aVI3L2pHOHVCUytjb3hVWWZrdER4RWdEdkIyQW9LQzNiTC9tc21mUlZTUUJm?=
 =?utf-8?B?TkFFUUhjTGYwV1B1dHlxM09HcjAzTjZMa0xZSnVhR29DdUtIMzR4N2ZoWTJC?=
 =?utf-8?B?NGMwVW1zMzU5VXhTM3R3Sk1xZUtDcGorMjRidkZ5K2pIbEJFaU9OOVhTZW1E?=
 =?utf-8?B?R1hJc0JabHUvelJyMEluUzJ1WmdJelhlSEZjZTZHSzA5cE5QMUVNSU9hY0sv?=
 =?utf-8?B?bjF2K1NkNFhHdHZjMDJBSFRnM01yWCt1QWozWWZNZVhwQnpCKzlDNGFRNG1W?=
 =?utf-8?B?MWhLc3RWWHJXN1pMOFY0SStOQ1c3eWg1VDloYkdnQUNzV0NnOCtqYVJQbjdS?=
 =?utf-8?B?blFTVmxtQTBwUnI4d05lb1c2MnNxNENSUEI3RjlLUU5MVlJqR29UVVFudE5P?=
 =?utf-8?B?RDBFTmF6YUNKMzRNVXQvdTdHV2RzRnpDT0M5bDRjbm9UTExaSzdub3JiM2s1?=
 =?utf-8?B?RlhpbjdFRUFZTjgzcTQ2R1JCUm5GY21HZVZrT1Z5SzhFRTRCVDl5T1M2OVpS?=
 =?utf-8?B?Q2FmZS9WRERwYStHWjZheThHQkpzQ2RFL3NVdXB5SGtBU3dKeWs1NWNtU2ds?=
 =?utf-8?B?eEEwMFJCZmJQZHZZSFRzQjRuaWE0aXZ3WEMxSjVGT3hFQzJ3OXpnS09FQU56?=
 =?utf-8?B?dzhaWmgraktzQzhHUklFTGdGL1lya0czdlh1SXV1UEpDT1hhTEJHa2doaVE4?=
 =?utf-8?B?THFFQzYyZ2JmVVZ2cW5rMCs3NjFDQ29KRjI4UnFsTlVRc0xBMDMwWFk5dEpH?=
 =?utf-8?B?SjRYYXRKZGFZS3VMY01NdzlQTXhpd1phSlRkQmllQnVidVNVOUNHRmhjZWp6?=
 =?utf-8?B?NkxuMDUxeDlhQ2UyR2NGNW5NM3crMHlyUHJUY05zYjc1VU16MmRnVzZrVmkw?=
 =?utf-8?B?VEI4Z3RzNExKTmlrQllYWnlSSjJ5Ly9tOWphS1QzeG41a3AwWEo4a3Zta2lH?=
 =?utf-8?B?UVk0czFyWjd3YldFZmcvdWtuVDZrdWdhMXlZUTRmaXpMYVNvbDZWZmM0U1Aw?=
 =?utf-8?B?MEx1VDl3WWluTHgzMUpkYm1MbWJjdTFEa0liS0tGdGx0KzRTNnJWbEw0YkNt?=
 =?utf-8?Q?NJhAHp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0xWb29hRjhCQXRPRWVJZzlqNjRsSkM2V3RmaWt1MjFyWGZvUUhsem5BTjcy?=
 =?utf-8?B?ekN6OW9iVGlpeitsNTJiVk54aHM4a1htV09kZ1p3bHE4cXRFWXdNd1Biemx5?=
 =?utf-8?B?WGJlYTk1Ty9Xc0tMdHdKTi96UXl6RDkzZUVrK0w4THNVSmRzaEZkQ09jVG13?=
 =?utf-8?B?aDZMQit5akVqc1RBQ0pQZkJTRTcrck9HQmVHV3h4dVJNanpsSmdqOXZYUnY4?=
 =?utf-8?B?UUJJcmF5T3ZWR2hYU3BkdUxQQ1ZQbURSZkFzNUVrcXAxZFBwYy9oR0VOeWRR?=
 =?utf-8?B?VEhrSFVXdFBYNU9mVElhZldYbFNXbWtrZ1dLU00xVFV5aTBIR1JFQmcvendx?=
 =?utf-8?B?VW5tbVh3cmFwSkpkVE51ZlRiRUVycGl6eFFJUm5YdDlQL0tlYnBLSUJvcXg3?=
 =?utf-8?B?OWNrblk5TXNVZVBQaVpSR2FMQzZLNmtPRTNlME1ZcUZOQ2FYdk40UjhQa09W?=
 =?utf-8?B?aWJzdXBDV3NCbDBHa0xQVE94K1IveXJEd0paMWxKeThHbjBmY2RKNGc5SjM4?=
 =?utf-8?B?SlhiMmZDbXI0ODBIMkh0TGxzRUdUMTYxUDhQVkdwMFc1V0w5VjdJZUlZWUhn?=
 =?utf-8?B?eTBoU3paeUtHZmRKSDFpL3lkYVcrSEJBc2FiTlFKdHVhbktwd2E2UjQyUFpD?=
 =?utf-8?B?eUlwbjNMSm1BNW0wWG5IeVlHeVFnMHMvRzNFSnd4ZlFNSDZrTWdETXIzNDJ6?=
 =?utf-8?B?eERsNG9aNE9weGVhMTdIOGZGNDFkdmFUWjVYcmtqU2M3NVpseU8vcUwvSUsw?=
 =?utf-8?B?QnNzQ1ZHTVBMTDlTVURpdGV4NkRTaENiUTFLTzkvQWxjeU5jNnZKUkZ3V0tE?=
 =?utf-8?B?ZjhNZTJHZnRLWmU1T0dWK0xUTkFUVlhyZkVldm1aY3Z0ODVWRzhUOGlpRG1w?=
 =?utf-8?B?WUJDYlBoeFBad0dNclpvbnRTS09mRUc4MFhQdVlXYldPMDRsSWxiNktwMUNZ?=
 =?utf-8?B?ay9GNEliQWVPb3htVTd4WHpBb2F0VmRhT25oM29vMkxiYm8rUmViZnhqenU5?=
 =?utf-8?B?RWdlUnhDMEFZYnJLWGVINzFXeVlFVEEvcUYrbU1uWGxMRUEydWpWRm41Wkt0?=
 =?utf-8?B?NWhJbDJLejc5WW1CclgzMHdUWk1IeCs2bW9ZWTZVVk1Dd1YwWkozZTN0SVht?=
 =?utf-8?B?OGZDUzNhSWxQZDZOenpoT3pHcTgvT3NURWZ3WlFoZVNpWDhJUC9UcHB2OFR6?=
 =?utf-8?B?MjVmc1RhNjFFWTVzOEFGK1QwenQvSlBqOWZmSDBlUGNHOXgxckZ5bFQxVmd3?=
 =?utf-8?B?THViSWJkanhqVkhWR2FQSnNiemVER3VRK3VabC8zTzI5anltM1VVUTA0QmZt?=
 =?utf-8?B?TXpWSFYvWHNDVzE5ekxqWTZJQ3pKcmsreG9FczE4V21sQ0xtRFZEdXNndndN?=
 =?utf-8?B?dXVyT3BkTjJBZm1aNlVpd0JRVGN1Wm1ydnpDc1FWSU1BUlNVRTVMK05mVFAv?=
 =?utf-8?B?emFXRHVnSndFdUtuRFlTMWNOeGRQQ0RJSHlxd24zYno5aWF2Rm5Ta3FlWWRW?=
 =?utf-8?B?OFpxa1F2VFJRck5FK1dPZmJGM2ZqTzRNZ3B5b0JBU3AwOTFzQlJ5YWhJWmVr?=
 =?utf-8?B?SjBBZEwxZEhNUXYrdU5MQzhhcmdWSzh2Q09vaTVac1VsTWtSNzdoT0FoOXRs?=
 =?utf-8?B?Umlkbis4ejMwU0p3N1Y0WTB0eFpqWU9jcURNWEdLR2Jwc2Z6VWRiZGkxVXFu?=
 =?utf-8?B?eTlTMXhLRXh6dTBSMXp5U0dVckx1MW1tUFZ3SDJ3R01WWjlZQ295WlYrT0lP?=
 =?utf-8?B?RHVSOFdSZnZGc2ZvUlQva3RxVlJ6NlZ5YkJFMXBpL2dEL2xsQm1JWTNKb2RY?=
 =?utf-8?B?c1pTZXRDd0xtQ0tST2JXQkhnZk5lRGpsY2hkVlY2WWRSczdESDdWSEdLTUpY?=
 =?utf-8?B?aHpid1pYWkc1TjdIUzh3M1VuUEFoczlHdHQ1YWVQb1hTUnFuTTI0VXJKL2VD?=
 =?utf-8?B?WjZObWpPczkxNkpLYWpqamh4OXdFcWJVMlpQYUgrODVmQnpkUVZnREE1QXhs?=
 =?utf-8?B?QU52U2dwRjNoUStSKzdCU0VtUjZqV2ZwbzFVbDRFU3FUaUM2bGtXRlhzckJW?=
 =?utf-8?B?L2p5WFdGcSs1Z29DNnF5bTM2d3lRTHFOYWc0REdpYk0zSCtCVUJGaDNpT3RD?=
 =?utf-8?B?dXdBRXZrUjNBZGdhL2Q5MXcyVUY4eGFuZ2R5VWo2cTI5TkUyTzhlSTM5eWdJ?=
 =?utf-8?B?MGh0bkFqNklWaG45WEpVcHVIajN4aENDQU5YSWJKUnRBREs3Vkc5cGNQWUR1?=
 =?utf-8?B?RmdOSXNtaHUzY2NGeUgwSmhtVHh3N0V1K0FPT1J4d0cwbnhWNWJESE9IQkNX?=
 =?utf-8?B?UTZ0NXpkalhNcVNZSHRrdnBiQzc0bkI5VWkzeHpWbG9LNDFpMDJ5TFZGaExm?=
 =?utf-8?Q?43eMmgI64UUmyvxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3C04AE969DD84FAD77B5598C094275@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a0d764-a113-4194-5ab2-08de4e31c4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 21:14:39.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MedwTBhxJgrV9/E8CieMHdcxsLfkre2e0vUaPzP42p7CYHxie0H7speZYZa21EwLKgswApDf8m61snBuuKqhmAvxz8YOqCn8o73N2J/43UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAxLTA3IGF0IDEyOjU3IC0wODAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOgo+
IFBhZ2UgYWNjb3VudGluZyBjYW4gY2hhbmdlIHZpYSB0aGUgc2hyaW5rZXIgd2l0aG91dCBjYWxs
aW5nCj4geGVfdHRtX3R0X3VucG9wdWxhdGUoKSwgd2hpY2ggbm9ybWFsbHkgdXBkYXRlcyBwYWdl
IGNvdW50IHRyYWNlcG9pbnRzCj4gdGhyb3VnaCB1cGRhdGVfZ2xvYmFsX3RvdGFsX3BhZ2VzLiBB
ZGQgYSBjYWxsIHRvCj4gdXBkYXRlX2dsb2JhbF90b3RhbF9wYWdlcyB3aGVuIHRoZSBzaHJpbmtl
ciBzdWNjZXNzZnVsbHkgc2hyaW5rcyBhCj4gQk8uCj4gCj4gdjI6Cj4gwqAtIERvbid0IGFkanVz
dCBnbG9iYWwgYWNjb3VudGluZyB3aGVuIHBpbm5pbmcgKFN0dWFydCkKPiAKPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOiBjZTNkMzlmYWUzZDMgKCJkcm0veGUvYm86IGFkZCBH
UFUgbWVtb3J5IHRyYWNlIHBvaW50cyIpCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBCcm9zdCA8
bWF0dGhldy5icm9zdEBpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogU3R1YXJ0IFN1bW1lcnMgPHN0
dWFydC5zdW1tZXJzQGludGVsLmNvbT4KCj4gLS0tCj4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVf
Ym8uYyB8IDkgKysrKysrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfYm8u
YyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9iby5jCj4gaW5kZXggOGI2NDc0Y2QzZWFmLi42YWI1
MmZhMzk3ZTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2JvLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0veGUveGVfYm8uYwo+IEBAIC0xMDU0LDYgKzEwNTQsNyBAQCBzdGF0
aWMgbG9uZyB4ZV9ib19zaHJpbmtfcHVyZ2Uoc3RydWN0Cj4gdHRtX29wZXJhdGlvbl9jdHggKmN0
eCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgbG9uZyAqc2Nhbm5lZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IHhlX2RldmljZSAqeGUgPSB0dG1fdG9feGVfZGV2aWNlKGJvLT5iZGV2KTsKPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgdHRtX3R0ICp0dCA9IGJvLT50dG07Cj4gwqDCoMKgwqDCoMKgwqDC
oGxvbmcgbHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBGYWtlIG1vdmUgdG8gc3lzdGVt
LCB3aXRob3V0IGNvcHlpbmcgZGF0YS4gKi8KPiBAQCAtMTA3OCw4ICsxMDc5LDEwIEBAIHN0YXRp
YyBsb25nIHhlX2JvX3Nocmlua19wdXJnZShzdHJ1Y3QKPiB0dG1fb3BlcmF0aW9uX2N0eCAqY3R4
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLndyaXRlYmFjayA9IGZhbHNlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFsbG93X21vdmUgPSBmYWxzZX0pOwo+IMKg
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKGxyZXQgPiAwKQo+ICvCoMKgwqDCoMKgwqDCoGlmIChscmV0
ID4gMCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGVfdHRtX3R0X2FjY291
bnRfc3VidHJhY3QoeGUsIGJvLT50dG0pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB1cGRhdGVfZ2xvYmFsX3RvdGFsX3BhZ2VzKGJvLT5iZGV2LCAtKGxvbmcpdHQtCj4gPm51bV9w
YWdlcyk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBs
cmV0Owo+IMKgfQo+IEBAIC0xMTY1LDggKzExNjgsMTAgQEAgbG9uZyB4ZV9ib19zaHJpbmsoc3Ry
dWN0IHR0bV9vcGVyYXRpb25fY3R4Cj4gKmN0eCwgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG5lZWRzX3JwbSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHhlX3BtX3J1bnRpbWVfcHV0KHhlKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oGlmIChscmV0ID4gMCkKPiArwqDCoMKgwqDCoMKgwqBpZiAobHJldCA+IDApIHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhlX3R0bV90dF9hY2NvdW50X3N1YnRyYWN0KHhlLCB0
dCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVwZGF0ZV9nbG9iYWxfdG90YWxf
cGFnZXMoYm8tPmJkZXYsIC0obG9uZyl0dC0KPiA+bnVtX3BhZ2VzKTsKPiArwqDCoMKgwqDCoMKg
wqB9Cj4gwqAKPiDCoG91dF91bnJlZjoKPiDCoMKgwqDCoMKgwqDCoMKgeGVfYm9fcHV0KHhlX2Jv
KTsKCg==

