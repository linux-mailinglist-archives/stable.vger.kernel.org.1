Return-Path: <stable+bounces-210357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20FD3AB6E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED063045393
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AEE36829F;
	Mon, 19 Jan 2026 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPKBg/du"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510233AD90
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832061; cv=fail; b=hYdyvtBeI/e41wAdwGYYCILGM9euQoAE94kLEuFCCenAgqOCIIYq++XzaE+z7R3Df2YScKEQwhV2WHAYRnVCA1sg/fHJyU2SksWY/BAz89c9wOgKUZFUMqkcrxYgp8JcYEiIL0Kaf+xEObmqgljjIkiInBQ2ottFtEi/SkjuOV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832061; c=relaxed/simple;
	bh=QRTmk6mQp9kPep1Qr4oLwbfXKrV7soOQAQ2pTznzKgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ve9Ua8SRL9t/M2/4B6dJT5izNXbDHvtOw+wy3B9MizdKNQvz64D5jP4RJvVgqK5sFrKymluOyJMbDea+slTfmigLytZgBG+vnFCYfUny1OpcSxxoA02rcrGsjH5svl0HP28wqb8kZBKJ9830IyzUiVjcR5x3ivqhv4+rLsP4xPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPKBg/du; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768832061; x=1800368061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QRTmk6mQp9kPep1Qr4oLwbfXKrV7soOQAQ2pTznzKgE=;
  b=ZPKBg/duFZl6W8XruWf64X/UOLmEXDOFg2NslmnL7QJL8aKwEfanTzBZ
   8aYcAEA9r6mwOtDTql855MdwRJc7sSAbwRK4cqY0IvEgOYNBcGkU0oJxM
   DXdbEyXcJzPD4TfxJMJNyW/Vrq4feSga251p3Rz0prLgmSFlZOVhdUHD5
   85r3Z9aEA9xYKR4KUWA+HuhakhLEjhlKk26e51hNzVfpPkg8vLOArDmji
   KZC5Vss7nQvfbipwXHqs8nY1ZI8X1Ne2lhtlkuo4eguoN6mZ53ycZ8X5B
   MI6HS0tXc5Iio4d0PMGVjnNHkDzLxdXOIJ8XHiBVVBst7Rg0cOqz6Y2f3
   A==;
X-CSE-ConnectionGUID: HiyqiHZJRAaTGQTJgrc7qQ==
X-CSE-MsgGUID: 5CfDSCvITE6N0+sR6Myl+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81483365"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="81483365"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 06:14:21 -0800
X-CSE-ConnectionGUID: uNi2Ue+hQEeUIoXlP3VtIA==
X-CSE-MsgGUID: YVrNcVk9SRSgugymCSVrtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205782045"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 06:14:20 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 06:14:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 06:14:19 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 06:14:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVgwAII+NFMTwoBLk6NgyIyWSYL41zT2KqAMGdbw1vqShOWfgh6htBN3XGzGGrXdigXGnRlZkDX0Fb+pawBRwo56Bk4iBxwYmFybUcTH9OSX5qGN+o3Zp16pna5IIdS4kp6ikbnniUfMQ34zD4afYnbjWzunJuPBeZr/YNxy3AJMLxi9g05RAMkLP8YG+WmT07aCZboXvYUfuWvFGJPj1/1JQSUCwLZ+fKEx5YooYgdBAdZ6gqfzliGZ8EgqHpBlK9zU7DKb78PLyfxrggK0A95Qstud2DOb9no6YJlJVDGQflZ4dzqm01oXNyrX+O+ypT30ga8m68TH9DvOElsR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRTmk6mQp9kPep1Qr4oLwbfXKrV7soOQAQ2pTznzKgE=;
 b=cV4T+HUUf7KsV+w49/rh2VvO7cO7jO9qHNgPVf4v2KyQ1wjr0Mfc3j9tN9zvQ9xse45c0LohWN8whf1tpkZxUz6tbuxetbuQtTDLyRQOLKVmLJ39g0FGwqvZuXe8sMAEbXC/BQXfl8qzTjSVaeJKsVZJQse9CVoKLbZtVnO/Qrzl4786P7j4yP36BouZ6m3FStghDfUO99PYgFlDKY72Smr2Tb3VKtMbeyZEA39iW6H08c/kaHs9QHw6faWpm69BSND9tW5VHzkpOrKd1dfzDBf+TAVgQtRc61c9blTyVfWUxq8zKREUVYndb8WwccNISlERUmROxqbYQLXFur2IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) by
 SJ5PPF2F2B659FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:14:17 +0000
Received: from DS7PR11MB6271.namprd11.prod.outlook.com
 ([fe80::3d4e:a313:cb21:144b]) by DS7PR11MB6271.namprd11.prod.outlook.com
 ([fe80::3d4e:a313:cb21:144b%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 14:14:16 +0000
From: "Mrozek, Michal" <michal.mrozek@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "Zhang, Carl"
	<carl.zhang@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"Souza, Jose" <jose.souza@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Topic: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Index: AQHcWiF5b+lD/JUYFkaOkc6R9pc5jrT7sh2AgAYp0YCAJi0CAIAApn4AgDEdFgCAABq/MA==
Date: Mon, 19 Jan 2026 14:14:16 +0000
Message-ID: <DS7PR11MB6271DDAE76295D9280AB5CD7E788A@DS7PR11MB6271.namprd11.prod.outlook.com>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
 <fh6dgogrt3ibrod7qkguejy4bj3cmvlbnxksmedhvfx3ejglk2@nu3h6doh7sdx>
 <cc27ae58-b579-4332-9653-c62b38f32add@intel.com>
 <aURm1LgtNPYNxRCP@lstrano-desk.jf.intel.com>
 <PH0PR11MB55798387B824D4101E19545E87A9A@PH0PR11MB5579.namprd11.prod.outlook.com>
 <598d3899-5942-485b-8e76-61bcbdfa5cbe@intel.com>
In-Reply-To: <598d3899-5942-485b-8e76-61bcbdfa5cbe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6271:EE_|SJ5PPF2F2B659FE:EE_
x-ms-office365-filtering-correlation-id: 30f845ea-7ace-441e-15e2-08de57650797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z3JVZkFYNk5xS2VjQlo3MElsbUxRNy9FRHVETHIyQUhrQWxhMUM2RzFtd2Z3?=
 =?utf-8?B?Q0F3K0YvMVZhbkloTnp1VXhhRlQ5ZERhWUYyZEJYa2IxNzhZZmFmbXBPK0Qr?=
 =?utf-8?B?WFMxRGVnUXZoMXVYb1laRC9Qd2dqM3RIb3doSUhQdFRndHNuTXhCaDNScGEr?=
 =?utf-8?B?NURQSXdJU09mVHRxRjlPUXlNT3J1L0hWa011WmpOczB1Z1JHbnRZb0dPdXkz?=
 =?utf-8?B?YnhJY3BkY29yTHJCMi9EaGFOeE8veEVJRFBHR2hsWnhmeXdVSUQzRy9JaHdF?=
 =?utf-8?B?VjVjeDhMNm5FdlBGTFJXY1hQbE9RVDFKWWdvRjkxM1FNckxzSklMZ0U0MmhR?=
 =?utf-8?B?OVNqK0VDZnYrbjZUL0d5dHVzZDd5bmY3Zzd2RHhDMk9HanVtT29ZMzRxaGVR?=
 =?utf-8?B?ckhGaGszMWVvR1FxNzV1QmlKR2FCeGdoZ3BBSUJ0UkFFNzYxOGlMSk9mZ0dK?=
 =?utf-8?B?MStuNkcrMElka25OMnE0ZE9sNUNNcFBTV0hvamVKVFJCdWtKUTcydlhHN1B4?=
 =?utf-8?B?MC8rdGd5aG1IbUpaSy96cm1FaUt0TmhITTllT0RhK3BwL2IvM0hrZnVOMndm?=
 =?utf-8?B?cXd3bXZjZVg1UHRXd01zeGpnTU55aXZLVXAzOXRyTi9aYUJrajBhbHd6MUZU?=
 =?utf-8?B?K1U2WGpFRVh0dG43QWx2dXdvc1NabWROdFI2OUM4QUM4ZEdaVlFiOGEzd2xR?=
 =?utf-8?B?RitnUE9GYlJtamN2OHZCbndBVkYwb3NObTdPbzE4azFTcnNFcjc4WHdteG5I?=
 =?utf-8?B?ZjJHTzZpZDJmcjFEeldRQUJWUDdMVlgrY283UTJsSllJVDZGcTFxNFpzQUpz?=
 =?utf-8?B?aW5aRnp4Qlp6T1lZY3R5cmE1R2NFaG50WjdBRE1TWlVPV2IwSHE1eThDejlN?=
 =?utf-8?B?ai96ZTNlWWVMVFlwWDZLZHliS3Q3V3YxclNuWUM4dmpEa3FmL0QybWJYWldn?=
 =?utf-8?B?MldoRWxXQ0daZjdRS0lKaWlkVWtLNlBCMDZrcFhiOFpSZmRsenNHMGRVdEZl?=
 =?utf-8?B?Rk42UDFmRDNOa1grVTIxQ0ZBdXhLMTd3bU02d0RvZTRIOEdCUzQ1ZWpFajF4?=
 =?utf-8?B?KzNaK2pFZ0hLTVk1Um9WVFZicFdHMkovOWtqSlZ2ZWllL1VYa3FjVCt6NXhv?=
 =?utf-8?B?WUxSTkJaSysyVXlNODB3TGplSGV5a21USnFwS1k2NTYwdjNpdzhNdDBZaVlT?=
 =?utf-8?B?Q0pEbnRoa2RKUHdOS3RGWlNoYUpUM2FkdjVFSnVualJ3OENiZTVnQ2NFekJz?=
 =?utf-8?B?Zm1LbE9IME4yVmN5c1R0NGxUbWFVM0JNWDlyZEM1RFFTVDFCSzVYQVFmTDFk?=
 =?utf-8?B?TTFoaUI5eHhwKzdhQnlLQzBQckkwak5BM0tObjlkWFY1QkM3ZEJ5YWl3akli?=
 =?utf-8?B?Mk1DeWlBMG9NbUEwK2g0Z0RET1k4S0IwbTRncnNseHpKV1FPMUNOZGs0Q2ZX?=
 =?utf-8?B?OWdzK2hBYU92em5YbmdYc1h3VHMybWNHQWt1OEJhU1RhZmZRTHEwRnhGTnJa?=
 =?utf-8?B?bGJyTml1SzB6b2YrQlBJM3J5akZlM3RIczVIWmlUaVdQVVVIK3dFbFFsVGJx?=
 =?utf-8?B?VDBPZHR6UU1jRTZFVGJWbWRzeTBFbktwSGZoeTViSXpwR0tCN0pIdXo5c0Zi?=
 =?utf-8?B?Uk5na2FML2F3anE2QTV1SlVGLzlJWGFBYU5HbTBIVk13RFNjSU1OYUFYZW9r?=
 =?utf-8?B?TmpUNXRaMVRrb2Q2VVNCaVJ5bEswRkIzWXVudXk1K3dyRGVKWlhMUHUzSG0z?=
 =?utf-8?B?Si9iS2YvZk9NZVFxU1VndmlZY0lsMFFxd1JRRkxiT2V5NzB2ZWxRZEt4VHpY?=
 =?utf-8?B?OURlZWVYbGxMWFZJc0RIa0wvWThFUjExOElsWU1UUllrNmx0RTE5UDlGdXFC?=
 =?utf-8?B?ZlhadWpNanhIN3hNbWtYSEIyZEMyaU5tQklSZUtoS0g4VVZvRnFCNk8rUkFp?=
 =?utf-8?B?Y1ArZW5MeDhRaWptVFY1Y05aYzJjR3lDRXE5UXJseGtVOGhiMjIrZHNpSGFX?=
 =?utf-8?B?YmJLaVRnTzVENGMzZyt3eEhod2RMRGw1QlptcWcxMzBJZ0JvT3hmNXpPQVo1?=
 =?utf-8?B?bVYweWFwYmNxbldETWJHZHhjU202MVhuenRpcHEwTHlFUVNxdmordkN5Q05H?=
 =?utf-8?B?bDZONjRpWDhUczNZY3graDlkQ0NCSlR1R3NnWFBQRFhYdHFHdzJxUzBLWmNs?=
 =?utf-8?Q?LYCfLEtEwj6TRK9azvhCGdo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjBZV3RBdXhVekJPVWxneWIwbXZlQlpsZERZaHB6RllXUEh0N1Rud21odUFr?=
 =?utf-8?B?b1M3UG5PNVRkR2JiSU84S3lsMEdET3NwbTYxRytBajBGdkh6ZS9NV3prYkE4?=
 =?utf-8?B?VXVBODU2bk05ME1KVUdueU5MQmJPUGpyRStkSlU5cjZ4NStLRkJyR29WWUhx?=
 =?utf-8?B?cDZ0Z2FTR2VBenZ5NjVOVGd1NlMyb005bFcveGlURjlVUVJrRkhHd1gxc2NV?=
 =?utf-8?B?RTAybWxLclRxc1h1cmpWd25KdWNTZ1ZYdHE0Z0hramlTMllxaU5QT3VhY3lY?=
 =?utf-8?B?dXJCU0dXREtnb2JuS0M0cWh6L202OFIrOFBGOW4rQ1JucmpMVUtZTHhScUNP?=
 =?utf-8?B?TW95dHRVTERqUGRFZDMwYUZ5dWlZUzBUdGw3RDVaZG9XUytDUWFkMFRYVlcz?=
 =?utf-8?B?NGFCNkZsL21tamthUnF3WU9zenllNzU3TTJNQldyc2haYWZuUkNUcUdaSkZs?=
 =?utf-8?B?Q25jQlIwZnhDV1NmSXByVnlrZjgxYWQwVFoyTU9zTmZKdUVIN0t6dVF5Ykxq?=
 =?utf-8?B?OWVSTExMT3RnL2E2ellsQTBxYWhNbExORWtjS3BLejgra3JJMURYdG1KSTlw?=
 =?utf-8?B?ZmRUUWdrWmxYVHZaVWpKVmdSSXozdFFBOFV2UHhKVXByRFlJSktJaXprRHpa?=
 =?utf-8?B?RUlCbUVGYm1mLzJUWE1tUVhFN0RRcXowVnExeVNWL2toMnZ1djBpL1M0YVlG?=
 =?utf-8?B?RWRzWlFsR1hnWkxBZ3BrSldwTmNoVFFNQ2plb0FJMnF2R2NZRUFlelg0UUcv?=
 =?utf-8?B?c05URHlaVXgzUFNPOEk5cWsrbk92NjJ1VmxNZ1ZlQ29iWm5CZkpKa25kVmRs?=
 =?utf-8?B?REQ5djB3K2VWbDVteEhGZGRzaEpBRTQ5cGxyNlZRVVZtYnZPRVprR3JTV2FK?=
 =?utf-8?B?SVF2eXBub2UxQ004L2JNTUQvV3IxTlIrY3QxKzdEbXJFTkRoQUd0SHlUUmRH?=
 =?utf-8?B?NS91RFJpSFprZ1NXWFpPajhNdUl0VitURElNVVBVRHpBZDQvVDcyLzdUN3Nx?=
 =?utf-8?B?N2x3VjdZUHk4Zis1c3VLTWJQZGlhcmV3TDNTOVhiYUpZdkl3N0Y0cXo0eHFl?=
 =?utf-8?B?Sk5BZytPbTZ1d3AweHAxUGhGSkZQRXFEQ3gwcERPWnlMMVVheS9rMXJGOWha?=
 =?utf-8?B?bFAxM0hqVXdOZ1Q1cEt0UXBDS2V2R2dLeXhqZG1yVXNDWldtNkJQTVNNRC9I?=
 =?utf-8?B?Snd2V1RONXJnY0h4NDVWZHN1cktvcnIyYkRaUzczendUSWp1Tk5sV002MkNU?=
 =?utf-8?B?S3hJRDY0NVRlZE81THR0b0lLdXAyamY0T1JKUUxNY0EyeXJwUVdWYzRneWhn?=
 =?utf-8?B?cWpnYlBYcG1mL2Y3djR5dDIyTWFYZEZhUXlOUzNOc21raVR6MTZOWHJEa2Ur?=
 =?utf-8?B?OW5wUFZtcjE5eTRpSHJVLzRGc0JSUXUwalVvaEYxb1V4RitlTkprNVlKd1Zh?=
 =?utf-8?B?WHlXRzg5d3JIcThBUDdQcHRjQW4rMGZoekxucmQzUlptWnh4QW1GcUZrZUNP?=
 =?utf-8?B?dzZVYTJMa0daQnJLTHc1dm5IbXFGUTJzeVl0TlNVb0NNMkgzRklabk1QWEF4?=
 =?utf-8?B?c0kvQlZUTXB1YzRQY2F4NitCZnd2Q0dGOGlRMExQTSs3dzl1dDg5djA2dzA1?=
 =?utf-8?B?cDBFOUpYUzc3OHBNcjBHMmliZ2NsMFpacVJsUFNFU3JZOHhPdDNDK250NmlL?=
 =?utf-8?B?WUVqUkN0ZG1pa1lmUnlaQjFJcWowczFJcFVmV1ZwRTBWTG9tbkwwQ1AyM3lk?=
 =?utf-8?B?alZzV0Q1RFgzYTFaQnkrRlgxL2oxRGpzRFJvT1NualpOQ1NMa2NodWZYYjlI?=
 =?utf-8?B?SVlxT2xFWFZtdDhjT0w5blVlUUZCbnpMNUNmMnRXMjV1a2lUVHU5dTVGb1FR?=
 =?utf-8?B?WTFxOVdlTTE5Z1F4YWNXYWc0ajc1ZFZ6bCsreWZqb0loak1ITTgrb3BKeThJ?=
 =?utf-8?B?QWdzRUp4Snp4Mk1MRUc4elZxc0NKRTFOUU43STZCYUU2Qk51eVRsRDhIc2dp?=
 =?utf-8?B?QUl2MEZ2d2c1V256dmtpbS9kM1ZtdXhqOCtKd1h5TEZISUJpdXYrd3pVNEhN?=
 =?utf-8?B?OXhkcit1Vzdpdnd1Smd0YTdXanM1aUxiS1VYT3FEZlUwdDl4YnViNE4rZkFy?=
 =?utf-8?B?NEZ6dk13RXRLenoyc0VDYlRhZ1FTRlhuYlkvcFU4bFlvV2ZZdG5Ya1N1YnBQ?=
 =?utf-8?B?SFNFUThXdzNNY2ppQmltclpBOWlBd0hKbEVqckttZDRZUjJGWS9BOEQ0Y21M?=
 =?utf-8?B?cjEwd0g2aVNaQ2xUaTUxV2V6N3oza0FpWWl3UHF0b3FKZm9oTWhaYmU2WEdo?=
 =?utf-8?B?cCtjellNRGNBVEFWdG5pcmh4Q3crWXJRdExZaGNFaTFJOUlhSk1KUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f845ea-7ace-441e-15e2-08de57650797
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 14:14:16.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwM/tptilP9tZ8wLIdDF08PleJebGfa5SSljCkPNotoeanhERJKx1mAyJ+a45VIyBXbF3dM4HkZO605TdrY6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F2B659FE
X-OriginatorOrg: intel.com

PiA+IE1pY2hhbCwgcGluZyBvbiB0aGlzIGZyb20gY29tcHV0ZSBQT1Y/DQoNCkNvbXB1dGUgaXMg
bm90IHVzaW5nIGJpbmQgcXVldWVzLg0KUFIgaXMgb2sgZnJvbSBjb21wdXRlIHBlcnNwZWN0aXZl
LCBldmVuIGlmIHdlIHN0YXJ0ZWQgdG8gdXNlIHRob3NlIHF1ZXVlcyB3ZSB3b3VsZCBjcmVhdGUg
YSBzaW5nbGUgcXVldWUgcGVyIFZNLg0KDQpBY2tlZC1ieTogTWljaGFsIE1yb3playA8bWljaGFs
Lm1yb3pla0BpbnRlbC5jb20+DQo=

