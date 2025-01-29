Return-Path: <stable+bounces-111079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B756A21866
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CF21666FD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBB199EA2;
	Wed, 29 Jan 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcEaHuta"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C078192D63
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137425; cv=fail; b=MSGnzJ0gxPQorQoO95QrNu1CIo/RQQm17Y3YBZjlxuhbHLQhmDE0zpFoD3DCk6frKBVqsgvsbbkg60MgmxUh9GAYBIXcZVZxlULFJTDZi8A9EvyqQaDVEvOIgYr6XRnZZ6qWrCZD8G4YR7SIkupjWYmXGxuQcLSI4d7eG7+phvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137425; c=relaxed/simple;
	bh=KIvs4nSIIJISUBs35bjvdeUPM7+sMTEX5qb/Qmto/AU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iPTpJmq5O2/EoeUdVEF0a5fUJLENWNJkB5mE/XcMZP60W2Bzvjnj1r6MAxR+/+84bpupUILTQjVCqN1SNWc4SOVj7Yx6zBKymfa3jVG2eA3xynC9TfZMGr6lfEAX8I5jTqTF3SY2ZbBAKj9WJ7ZP4ZFu7woRNvXPJ46ffOLnXXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcEaHuta; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738137423; x=1769673423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KIvs4nSIIJISUBs35bjvdeUPM7+sMTEX5qb/Qmto/AU=;
  b=AcEaHutae/r8o9sMX/rpaIt9u4PSmdD5nlvJ9a0XVM8EGPbHoWPJHKt6
   +9U+XRvrXVt71wj/iDXaOe367xm12SWmX1NAdz4Xf7+ZoQr57R/gzIslf
   T8MleMMhF0cj0EwfPvBk+oPh6YQOpoB8AI06K8G9nfR0QDyGsGABHjq1x
   t8IfyNS6jt5Sv1CgFEpeZRBKyDGqDBLQa6uYSiDKoUtg22E1PRFMfDpCW
   Dvmu6CP56rXx/DaDLyRsa+QA2Juhq9osSlle9UtkSU1gjDwlbkcNsk4qa
   qnfMePICjZrjLVhjsfikfDn096sSskCJ54g/W8UDb9cDNoN/WdzuK6U4F
   A==;
X-CSE-ConnectionGUID: SSZ6BFZZTOCSkHcB1SBw0Q==
X-CSE-MsgGUID: qcNTeI2+RnKk7zq/Ru2BdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49294715"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="49294715"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:57:02 -0800
X-CSE-ConnectionGUID: vJNAPkHxQnujmHXFcYWtaA==
X-CSE-MsgGUID: H4gQg0jLTPGNq/F6Nix3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146161542"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 23:57:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 23:57:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 23:57:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 23:57:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuOmXcmTNLcg1LzXh9xYRAdfbnrWAd9W7uDjSe9fDFBRnJ0cAIGcGPKX4uHZu2WYdn4YlStAswMB2x9a/EAtwkLStUQIwNxiUkuMP8PCifw4Qps93DXjB9ytTg1uZ+lModtMTu+zuLatQLeSO4eGRRMc6oDwCaQmgPnyBRN+HNY78lm2Jwx2V/YLgPKi5hztOHp2n4Ru8no+4fDEnuXSJKZ9sTA7l/kQB+wXW2b9tC3csTZquYdsBHRBkqU8HUZs0dDaS76/Bgf1mw94w5GRvPcC00u2Wp3lOuMcqJjvBU/H3HXVygYcgE9OMppqWZxa2HaiWvEdG+ajEItOZhNZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIvs4nSIIJISUBs35bjvdeUPM7+sMTEX5qb/Qmto/AU=;
 b=BUSYKk/OOhnJw8ncsZ87MRUTWLHoGguEroz+mO5xb03zMY/wLOWgrrLEFzVCu8bVzbjMshq05r8Y5qQZOqYBPulG2BOa5y5bBEJPSa5nF2SzWynx0IqtRvoL/ckNXYzcRxY5+NV32nUsDQKc9bCwxhfYK98FxF5xAyzZdBvAKJ35XuGmhsd4rVSxcnMJHQ6P0SAioptbYXfYc2XM9/GhhK8obKqDDGjoysZKJecwCC4IB/PTR3IvRtqZJufa8AnZPOTu3pHiSrCmpQWSWVWegh/jI+IC3LWgbJpY0PrgiOKt1nVR7qan/sqZykHBCADXeFmCa+aggyQgHoTnyHq/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 07:56:13 +0000
Received: from SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c]) by SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 07:56:13 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Topic: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Index: AQHbcWrWrMuYujkV70ixrrCNNvf9Y7MsinzwgADD7wCAABTL8A==
Date: Wed, 29 Jan 2025 07:56:13 +0000
Message-ID: <SA3PR11MB8120C00CEF7B016CCF9AB097C9EE2@SA3PR11MB8120.namprd11.prod.outlook.com>
References: <20250128185507.2176-1-42.hyeyoo@gmail.com>
 <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
 <CAB=+i9SwTtZjM+E346C6moZCbZMsGuT14qwbbL0k26mwTJ-oug@mail.gmail.com>
In-Reply-To: <CAB=+i9SwTtZjM+E346C6moZCbZMsGuT14qwbbL0k26mwTJ-oug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8120:EE_|PH0PR11MB4886:EE_
x-ms-office365-filtering-correlation-id: bd349309-c73e-4d50-a52c-08dd403a66c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?OGxoTXNxMWYzWGNESFh2RmgxdjNDN0lPSnZXWGZwbjQ4SWlzWlJxY211V1VX?=
 =?utf-8?B?UXcvNmlDSk44ZkhsZk40WmZFV081NFdlYTJ1Z0lqMkFuRlFsMmRkY2JqbnFC?=
 =?utf-8?B?UTVzYThFeEFRSTUzKzlGS05kc1QvTm5FMHFWZ28yaWlLRW5IZDkvd29YSE0v?=
 =?utf-8?B?YWNZTURQTlh6ME0xdHpHRTU2c0VNRktoL3R3WkxBZUp0NHBnMFFMdmY4NG9y?=
 =?utf-8?B?SG1MUDhoY3d6VGxvRDNNWGRNQVVMeFlBY3ZmNi81MVh5RnE1YWFnUUorZVJM?=
 =?utf-8?B?Ry9GS1Y4cnB4UWk2cm1pTG03Q0YzUnpDYTlHaFByeFdaQlBDYzlIK1FDckJY?=
 =?utf-8?B?eHlBVjNNUnY4UTd4RGd6SnlKTnB1NVpwNVFDYW5GZHpiQ2JYUmE5Ym9FQ0tP?=
 =?utf-8?B?NU1NdnVqR3pSZ2tGV3ZBdUNqWlF4S0tlKytQc0tTcGlYODQwWVk3dGJoWnlz?=
 =?utf-8?B?VFBLdEZUeTZkeExpMndBZDltOVlEMEVSZ0lkUHlWejNqTHgvaVdaODFKUkR3?=
 =?utf-8?B?SFRUUFRqV05jRG5pWnMxc3E2ZnRWeG1GYzF1a25ycGF3QUduMVhvQUh1Rk5Q?=
 =?utf-8?B?T0lGbG5BL0J2MUt5TTE0UmdBcnlQcmxIdWF0TVk0WVVzOWlGUzFCTDgxUWtl?=
 =?utf-8?B?Ykh0b3pZckJQbzE2aHUxdVpESFVrcUh0VEphVlpkeHZkMm1jWm43U3BXMFE1?=
 =?utf-8?B?RmZDWnhEVVBlRWRXS0I3eXpOaVN2NGs5RUtxeHpxNmoxeUlXRXZ0MXFacDcr?=
 =?utf-8?B?aFlBdGlMSk9aK3BmMzlHZ0tpWkljNGp0QlovTVBiZWM1TjNQOWJ1amlrYVQz?=
 =?utf-8?B?U2s2TFlRV2hQL0dTUVpORmN4MEJwdXpsTTZaQWhjdklVSkZSanI3MTRXbWx5?=
 =?utf-8?B?WldoNVcrMWs0cXdNeXNSUGl6azFGWllabExFUmdDZlBpTEJpTFNLNDk5Uldy?=
 =?utf-8?B?VUUyVStYTjVHbEdvV3piYS9UQmdvR0hieGI4NTQrc1lDQk1RTmsvZnM3dWhy?=
 =?utf-8?B?OFN0Z0FRc2haOStwU2hkZGJFZ0c4MnhFVzhUa1hJQnVWZGxYNUY1SzU3ZlZN?=
 =?utf-8?B?QmQ4ZWQ3MVEveVA0Rmh4S1J0cmw2SDZ2dXo0T05SeXZLL3kvdkt6QnA3NmVy?=
 =?utf-8?B?VllWVVhnMDg0T0hLREtSTVROaHlXS0N2MHFjSzF6RkxEYTE2bmhZdXVKWXlr?=
 =?utf-8?B?b3pKYk9PeEJpMmFmYlFzai9VbmtFTWs5VW9Rb3dqRytteW03bk8yT2JxWmlk?=
 =?utf-8?B?RE9BbTNnQ2FjUmFoUjEzLzZaeVhDb1NUMWpwM2dtMEIzT290dE5Vc2VsMlJL?=
 =?utf-8?B?NEppMVhyak03cUFER3ZSUWZNMGxoMzVzKzZRZjhIWnlOdDFCNzJFbFBGeTM1?=
 =?utf-8?B?Qmd2ZmJSVDVtNS9VQ3RJek9weVZ5R2VtSWV3eEVkRHBVZW9xWktscHNHZ08v?=
 =?utf-8?B?emkyTnVkVWVnU250T2NZQlg0UVZRd2N6RTlvQVlTeXpaUWsyWWFxTWdaaHhE?=
 =?utf-8?B?OEN5aDNtUHRFYTZod1dxTWRSeWJ3Z1R5d0V2Ym45aXNKcDZuVmZpWjlJM09w?=
 =?utf-8?B?ekZrbS9idnNnSFZ3alN0QVRyeDNyRnl4dGJBc1VMR2dBMy9PbXpLQS9pZExj?=
 =?utf-8?B?cGxCbHhGanRMaUNweWoreU9xSTVlcjJqK3NFNXViOUFlWkRHSGlocyt1Y2sw?=
 =?utf-8?B?L0JYakpPVGlCODVoK0VKVzBkTEJNTHR5NTd6aU1rd3JWWVJ5NDRMVGx4b2Ry?=
 =?utf-8?B?Umd1bXN5eVIzbVVGN0xxUmFPalJGa3RVdGppOGpxZ2tsVHZiZU1iQzZpNWUz?=
 =?utf-8?B?TEdrek9DcE1qOFdwdWl4VjJzaW0zZGpTSlVIRnNyZk5Gb3c1Lzd5TWt4N3ls?=
 =?utf-8?B?ZkxEMXpoUHI2bnhuOXA5QlNxMktBOEhISDJxTkZwYTFDLzZEMlEzZTkrMWtE?=
 =?utf-8?Q?sYpxkutl8I1qfbIFL+qHBYmeEDOxnrUp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRZZm9EdE9XV1JadG5jNDJRQU1PSW9sRW9HK3I4b0dlT2d6enZodkFrbGVV?=
 =?utf-8?B?YzlPYXVYTW9ubGtlcFhPcC9ZNndPWkZlVm1sME1sK1NLYWF6WjdQL3dqZ3h2?=
 =?utf-8?B?VVZldlZDME52L2ZmL2V1eG9LalFlbGV1eG82SzZvRXdBaytJc3A5M0RPMUV6?=
 =?utf-8?B?UC9sbFN2YkdCMGhKejRKT0RUSHZ4bmQ1VkFueE1rbldOclVKR2lVbDZjUTBh?=
 =?utf-8?B?emxJYm1NSHlFQ2ZUai9IbERsbWI5TXdIaTRRUGc2VnhNemc2aGw3Y0k5bmxz?=
 =?utf-8?B?YWtEOEtqeFFGYmdSd0pQN3ZQT1ZQYjlDZ1k3THJNbXlUYyt4VHQ4ZDdkNndx?=
 =?utf-8?B?VUFOckJjWlREN3lmTk8wTkYzRFRvV2tQWlhiNVlDV3YxVi9aN3ZKOW5qUEhB?=
 =?utf-8?B?R2VER2RweHRFR1JzenhyOHUrUmlKek1ZbXMrVXhZeG5GOHEzK3NFRXArMENM?=
 =?utf-8?B?UUJQZjZFb052UFZPb1JQVDFuNWY3aEYySXFtWmJuazJwUC9DUjNSajdQZ1ow?=
 =?utf-8?B?RHdFbWZyYlRYekRMVkR5R0M4QURKSXllQ2ZONjE3TmVqcWJ2L0NJbWl0RS9I?=
 =?utf-8?B?YSs4RXBTUUhPMXQ3WjRleUJSNm1CNjFuUFgrSzAvRGwyNkY5bkhWK0orNVAv?=
 =?utf-8?B?NVE4N284S1BXdWdBekx0UEJ2MUlVTzdpbHJOT3lTWTZxT2paQjkyRWF0bVRu?=
 =?utf-8?B?UjFuODVUdXU2ZmtGUkNpMXBlOTJ2blg5d2Z3QnhReFA2bHdBRm9QeVpwbjhN?=
 =?utf-8?B?RCtXaXkya3hHakdqdExNTkpGT3VvZjRMN2VEeXEzZ1FUYklnNmhWNHRZbmEw?=
 =?utf-8?B?S2ozTFlnTjBCVUtEZ1dlOExMTmFKTnhIMyttUXpTTW5yNmM0S0pnN1pSRmtr?=
 =?utf-8?B?cHdWRVdtc1hzamIzZU1CWmVGUG1hNk01YnlqaTBaR0lVTkZYTmlpQzFpeDdF?=
 =?utf-8?B?b0VnVHF6K1d4bThqOUNOeUpwMHBUTHR2dVhjNTR6MUpoZ1BjV3ZOSFhZT0RZ?=
 =?utf-8?B?WWdjRVBhNWQ3REZyWWhUV2V4NG0xSnd5MThGRTNDVGZTaDlKU0hWMVFPM2R5?=
 =?utf-8?B?Vm1KRyttREhTdTk3cUcvU2pSNWZZZndIMzNLUkovdVhFOGVYTlRYeDhzSk5M?=
 =?utf-8?B?UmxWOWJ0VDB1dmgrcTVSRCtxc1p0V295K3owZlZtVnIyYW1zeGYrcVBSc0Rn?=
 =?utf-8?B?U0xoSDlyTDVJcUFSWVdERkVyc1RBakVPNHp4Z2U5TWhKVGowME1Eam5HREtU?=
 =?utf-8?B?ZSsrZHlKNlB3YXpmNFpQWFFRdGtzZlhMM0dBUytISjk4M2o1dFNXcWdkYjhF?=
 =?utf-8?B?Vy9aU21reDR4MnVIMWt2dmhjNDZIOUYwQm1QSXJOU21odnZXdHh2ZW1rTUp1?=
 =?utf-8?B?L3pHUjZpdEhRNzA0QnNhWjIwVndCZ09kTnpoYkxmeFE0ZmxSM2l3SzhFNkts?=
 =?utf-8?B?b1c3NXQzMXAxNDU1OHJ6TGxsbm43RGR0SFdMVGE0VHVGMkJXUDVlbmVqcUVN?=
 =?utf-8?B?dFcrb0lheUJRaEo0THRONm81TTVDdGRja1J2NFJUTi81UHo3WmhYQ0ozcUhY?=
 =?utf-8?B?Q1ZNWklxRmpTMVZHa0FMTDQvUEtkcW43ZEZVODZjUGJhTXBNOWlBTE1KeDh1?=
 =?utf-8?B?ZjkvNHk0eVJkalpTNXMrYWJ3NzBnRWRZT0tBTU1nQVBPUERoNWpuQjVwWFAz?=
 =?utf-8?B?b1o5RmRLOXQ0dVVTZFlYQzI3djM4ci9nUGEyeVBvZWlrV1BhZ1MxM2g1TTJL?=
 =?utf-8?B?R0tGZ2pwTXZ2T2VPVjBYczFERHB0YnhIdnZSVHY0VEJ2aStTMHZ4ZHBoUlkx?=
 =?utf-8?B?MkVSeHNIYkN0VTUrcUhEaWxtakRwWVFpalVMcFpmVldxV3VyNzdSVUNjV2oy?=
 =?utf-8?B?bGJEU25KTTJjQ2tWUEdiVWtGeFltcDhwUnA5Y1g0Ni9ZajJvSm8zejRwZTN4?=
 =?utf-8?B?YnFqNzNMM1QvOUE3RmhsYTQ2djViY0g4VUFXbjdmeWdrdXV3TEsvWUY5L3lk?=
 =?utf-8?B?WHZmZjVtM2FyZzgzMGcvY1VzU0xjWmxoYVFpeWtEN0xKMUlnVzNTTmdzTTZ4?=
 =?utf-8?B?bFpIR3IySjRLRm1oSVlGbTJTS2YyVE1tOVVFZGpTUWpSekd6THFzVEo4RlJy?=
 =?utf-8?B?ck9kSExPb1pvbjlFay9BQW1DeFJSK2tmbVYzeVlwSUgyRmZINmlydDhVVmJa?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd349309-c73e-4d50-a52c-08dd403a66c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 07:56:13.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e24xGb+xXOUicmkU0mUWTrv35Zk1kgI2ZdNIiK0Ysw8MxFFKxrzFsZKoESLAzc70dQYSNIDv3UuBm1hgHjIUbNnc5MraV2mAGs5BfJA4jmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEh5ZW9uZ2dvbiBZb28gPDQy
Lmh5ZXlvb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjgsIDIwMjUgMTA6
NDAgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz47IFlvc3J5
IEFobWVkDQo+IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+OyBOaGF0IFBoYW0gPG5waGFtY3NAZ21h
aWwuY29tPjsgQ2hlbmdtaW5nDQo+IFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj47IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnPjsgbGludXgtbW1Aa3Zh
Y2sub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
bW0taG90Zml4ZXNdIG1tL3pzd2FwOiBmaXggaW5jb25zaXN0ZW50IGNoYXJnaW5nDQo+IHdoZW4g
enN3YXBfc3RvcmVfcGFnZSgpIGZhaWxzDQo+IA0KPiBPbiBXZWQsIEphbiAyOSwgMjAyNSBhdCA0
OjA54oCvQU0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBIeWVvbmdnb24sDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBIeWVvbmdnb24gWW9vIDw0Mi5oeWV5b29A
Z21haWwuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyOCwgMjAyNSAxMDo1NSBB
TQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+OyBKb2hhbm5lcw0KPiBXZWluZXINCj4gPiA+IDxoYW5uZXNAY21weGNoZy5vcmc+OyBZ
b3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsgTmhhdA0KPiA+ID4gUGhhbSA8bnBo
YW1jc0BnbWFpbC5jb20+OyBDaGVuZ21pbmcgWmhvdQ0KPiA+ID4gPGNoZW5nbWluZy56aG91QGxp
bnV4LmRldj47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtDQo+ID4gPiBmb3VuZGF0aW9uLm9y
Zz4NCj4gPiA+IENjOiBsaW51eC1tbUBrdmFjay5vcmc7IEh5ZW9uZ2dvbiBZb28gPDQyLmh5ZXlv
b0BnbWFpbC5jb20+Ow0KPiA+ID4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogW1BBVENIIHYyIG1tLWhvdGZpeGVzXSBtbS96c3dhcDogZml4IGluY29uc2lzdGVudCBjaGFy
Z2luZw0KPiB3aGVuDQo+ID4gPiB6c3dhcF9zdG9yZV9wYWdlKCkgZmFpbHMNCj4gPiA+DQo+ID4g
PiBDb21taXQgYjdjMGNjZGZiYWZkICgibW06IHpzd2FwOiBzdXBwb3J0IGxhcmdlIGZvbGlvcyBp
bg0KPiB6c3dhcF9zdG9yZSgpIikNCj4gPiA+IHNraXBzIGNoYXJnaW5nIGFueSB6c3dhcHBlZCBi
YXNlIHBhZ2VzIHdoZW4gaXQgZmFpbGVkIHRvIHpzd2FwIHRoZQ0KPiBlbnRpcmUNCj4gPiA+IGZv
bGlvLg0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIsIHdoZW4gc29tZSBiYXNlIHBhZ2VzIGFyZSB6c3dh
cHBlZCBidXQgaXQgZmFpbGVkIHRvIHpzd2FwDQo+ID4gPiB0aGUgZW50aXJlIGZvbGlvLCB0aGUg
enN3YXAgb3BlcmF0aW9uIGlzIHJvbGxlZCBiYWNrLg0KPiA+ID4gV2hlbiBmcmVlaW5nIHpzd2Fw
IGVudHJpZXMgZm9yIHRob3NlIHBhZ2VzLCB6c3dhcF9lbnRyeV9mcmVlKCkNCj4gdW5jaGFyZ2Vz
DQo+ID4gPiB0aGUgcGFnZXMgdGhhdCB3ZXJlIG5vdCBwcmV2aW91c2x5IGNoYXJnZWQsIGNhdXNp
bmcgenN3YXAgY2hhcmdpbmcgdG8NCj4gPiA+IGJlY29tZSBpbmNvbnNpc3RlbnQuDQo+ID4gPg0K
PiA+ID4gVGhpcyBpbmNvbnNpc3RlbmN5IHRyaWdnZXJzIHR3byB3YXJuaW5ncyB3aXRoIGZvbGxv
d2luZyBzdGVwczoNCj4gPiA+ICAgIyBPbiBhIG1hY2hpbmUgd2l0aCA2NEdpQiBvZiBSQU0gYW5k
IDM2R2lCIG9mIHpzd2FwDQo+ID4gPiAgICQgc3RyZXNzLW5nIC0tYmlnaGVhcCAyICMgd2FpdCB1
bnRpbCB0aGUgT09NLWtpbGxlciBraWxscyBzdHJlc3MtbmcNCj4gPiA+ICAgJCBzdWRvIHJlYm9v
dA0KPiA+ID4NCj4gPiA+ICAgVHdvIHdhcm5pbmdzIGFyZToNCj4gPiA+ICAgICBpbiBtbS9tZW1j
b250cm9sLmM6MTYzLCBmdW5jdGlvbiBvYmpfY2dyb3VwX3JlbGVhc2UoKToNCj4gPiA+ICAgICAg
IFdBUk5fT05fT05DRShucl9ieXRlcyAmIChQQUdFX1NJWkUgLSAxKSk7DQo+ID4gPg0KPiA+ID4g
ICAgIGluIG1tL3BhZ2VfY291bnRlci5jOjYwLCBmdW5jdGlvbiBwYWdlX2NvdW50ZXJfY2FuY2Vs
KCk6DQo+ID4gPiAgICAgICBpZiAoV0FSTl9PTkNFKG5ldyA8IDAsICJwYWdlX2NvdW50ZXIgdW5k
ZXJmbG93OiAlbGQNCj4gPiA+IG5yX3BhZ2VzPSVsdVxuIiwNCj4gPiA+ICAgICAgICAgbmV3LCBu
cl9wYWdlcykpDQo+ID4gPg0KPiA+ID4gV2hpbGUgb2JqY2cgZXZlbnRzIHNob3VsZCBvbmx5IGJl
IGFjY291bnRlZCBmb3Igd2hlbiB0aGUgZW50aXJlIGZvbGlvIGlzDQo+ID4gPiB6c3dhcHBlZCwg
b2JqY2cgY2hhcmdpbmcgc2hvdWxkIGJlIHBlcmZvcm1lZCByZWdhcmRsZXNzbHkuDQo+ID4gPiBG
aXggYWNjb3JkaW5nbHkuDQo+ID4gPg0KPiA+ID4gQWZ0ZXIgcmVzb2x2aW5nIHRoZSBpbmNvbnNp
c3RlbmN5LCB0aGVzZSB3YXJuaW5ncyBkaXNhcHBlYXIuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IGI3
YzBjY2RmYmFmZCAoIm1tOiB6c3dhcDogc3VwcG9ydCBsYXJnZSBmb2xpb3MgaW4genN3YXBfc3Rv
cmUoKSIpDQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSHllb25nZ29uIFlvbyA8NDIuaHlleW9vQGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4NCj4gPiA+IHYxLT52MjoNCj4gPiA+DQo+ID4gPiAgRml4ZWQgb2JqY2cgZXZlbnRzIGJlaW5n
IGFjY291bnRlZCBmb3Igb24genN3YXAgZmFpbHVyZS4NCj4gPiA+DQo+ID4gPiAgRml4ZWQgdGhl
IGluY29ycmVjdCBkZXNjcmlwdGlvbi4gSSBtaXN1bmRlcnN0b29kIHRoYXQgdGhlIGJhc2UgcGFn
ZXMgYXJlDQo+ID4gPiAgZ29pbmcgdG8gYmUgc3RvcmVkIGluIHpzd2FwLCBidXQgdGhlaXIgenN3
YXAgZW50cmllcyBhcmUgZnJlZWQNCj4gaW1tZWRpYXRlbHkuDQo+ID4gPg0KPiA+ID4gIEFkZGVk
IGEgY29tbWVudCBvbiB3aHkgaXQgY2hhcmdlcyBwYWdlcyB0aGF0IGFyZSBnb2luZyB0byBiZSBy
ZW1vdmVkDQo+ID4gPiAgZnJvbSB6c3dhcC4NCj4gPiA+DQo+ID4gPiAgbW0venN3YXAuYyB8IDE0
ICsrKysrKysrKystLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9t
bS96c3dhcC5jDQo+ID4gPiBpbmRleCA2NTA0MTc0ZmJjNmEuLjEwYjMwYWM0NmRlYiAxMDA2NDQN
Cj4gPiA+IC0tLSBhL21tL3pzd2FwLmMNCj4gPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiA+IEBA
IC0xNTY4LDIwICsxNTY4LDI2IEBAIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xp
bykNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgIGJ5dGVzID0genN3YXBfc3RvcmVfcGFnZShw
YWdlLCBvYmpjZywgcG9vbCk7DQo+ID4gPiAgICAgICAgICAgICAgIGlmIChieXRlcyA8IDApDQo+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgZ290byBwdXRfcG9vbDsNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGNoYXJnZV96c3dhcDsNCj4gPiA+ICAgICAgICAgICAgICAgY29t
cHJlc3NlZF9ieXRlcyArPSBieXRlczsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtICAg
ICBpZiAob2JqY2cpIHsNCj4gPiA+IC0gICAgICAgICAgICAgb2JqX2Nncm91cF9jaGFyZ2VfenN3
YXAob2JqY2csIGNvbXByZXNzZWRfYnl0ZXMpOw0KPiA+ID4gKyAgICAgaWYgKG9iamNnKQ0KPiA+
ID4gICAgICAgICAgICAgICBjb3VudF9vYmpjZ19ldmVudHMob2JqY2csIFpTV1BPVVQsIG5yX3Bh
Z2VzKTsNCj4gPiA+IC0gICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICBhdG9taWNfbG9uZ19hZGQo
bnJfcGFnZXMsICZ6c3dhcF9zdG9yZWRfcGFnZXMpOw0KPiA+ID4gICAgICAgY291bnRfdm1fZXZl
bnRzKFpTV1BPVVQsIG5yX3BhZ2VzKTsNCj4gPiA+DQo+ID4gPiAgICAgICByZXQgPSB0cnVlOw0K
PiA+ID4NCj4gPiA+ICtjaGFyZ2VfenN3YXA6DQo+ID4gPiArICAgICAvKg0KPiA+ID4gKyAgICAg
ICogQ2hhcmdlIHpzd2FwcGVkIHBhZ2VzIGV2ZW4gd2hlbiBpdCBmYWlsZWQgdG8genN3YXAgdGhl
IGVudGlyZQ0KPiA+ID4gZm9saW8sDQo+ID4gPiArICAgICAgKiBiZWNhdXNlIHpzd2FwX2VudHJ5
X2ZyZWUoKSB3aWxsIHVuY2hhcmdlIHRoZW0gYW55d2F5Lg0KPiA+ID4gKyAgICAgICogT3RoZXJ3
aXNlIHpzd2FwIGNoYXJnaW5nIHdpbGwgYmVjb21lIGluY29uc2lzdGVudC4NCj4gPiA+ICsgICAg
ICAqLw0KPiA+ID4gKyAgICAgaWYgKG9iamNnKQ0KPiA+ID4gKyAgICAgICAgICAgICBvYmpfY2dy
b3VwX2NoYXJnZV96c3dhcChvYmpjZywgY29tcHJlc3NlZF9ieXRlcyk7DQo+ID4NCj4gPiBUaGFu
a3MgZm9yIGZpbmRpbmcgdGhpcyBidWchIEkgYW0gdGhpbmtpbmcgaXQgbWlnaHQgbWFrZSBzZW5z
ZSB0byBjaGFyZ2UNCj4gPiBhbmQgaW5jcmVtZW50IHRoZSB6c3dhcF9zdG9yZWRfcGFnZXMgY291
bnRlciBpbiB6c3dhcF9zdG9yZV9wYWdlKCkuDQo+ID4gU29tZXRoaW5nIGxpa2U6DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvbW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gPiBpbmRleCBiODRjMjBk
ODg5YjEuLmZkMmE3MjU5OGE4YSAxMDA2NDQNCj4gPiAtLS0gYS9tbS96c3dhcC5jDQo+ID4gKysr
IGIvbW0venN3YXAuYw0KPiA+IEBAIC0xNTA0LDExICsxNTA0LDE0IEBAIHN0YXRpYyBzc2l6ZV90
IHpzd2FwX3N0b3JlX3BhZ2Uoc3RydWN0IHBhZ2UNCj4gKnBhZ2UsDQo+ID4gICAgICAgICBlbnRy
eS0+cG9vbCA9IHBvb2w7DQo+ID4gICAgICAgICBlbnRyeS0+c3dwZW50cnkgPSBwYWdlX3N3cGVu
dHJ5Ow0KPiA+ICAgICAgICAgZW50cnktPm9iamNnID0gb2JqY2c7DQo+ID4gKyAgICAgICBpZiAo
b2JqY2cpDQo+ID4gKyAgICAgICAgICAgICAgIG9ial9jZ3JvdXBfY2hhcmdlX3pzd2FwKG9iamNn
LCBlbnRyeS0+bGVuZ3RoKTsNCj4gPiAgICAgICAgIGVudHJ5LT5yZWZlcmVuY2VkID0gdHJ1ZTsN
Cj4gPiAgICAgICAgIGlmIChlbnRyeS0+bGVuZ3RoKSB7DQo+ID4gICAgICAgICAgICAgICAgIElO
SVRfTElTVF9IRUFEKCZlbnRyeS0+bHJ1KTsNCj4gPiAgICAgICAgICAgICAgICAgenN3YXBfbHJ1
X2FkZCgmenN3YXBfbGlzdF9scnUsIGVudHJ5KTsNCj4gPiAgICAgICAgIH0NCj4gPiArICAgICAg
IGF0b21pY19sb25nX2luYygmenN3YXBfc3RvcmVkX3BhZ2VzKTsNCj4gPg0KPiA+ICAgICAgICAg
cmV0dXJuIGVudHJ5LT5sZW5ndGg7DQo+ID4NCj4gPiBAQCAtMTUyNiw3ICsxNTI5LDYgQEAgYm9v
bCB6c3dhcF9zdG9yZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICAgICAgICAgc3RydWN0IG9i
al9jZ3JvdXAgKm9iamNnID0gTlVMTDsNCj4gPiAgICAgICAgIHN0cnVjdCBtZW1fY2dyb3VwICpt
ZW1jZyA9IE5VTEw7DQo+ID4gICAgICAgICBzdHJ1Y3QgenN3YXBfcG9vbCAqcG9vbDsNCj4gPiAt
ICAgICAgIHNpemVfdCBjb21wcmVzc2VkX2J5dGVzID0gMDsNCj4gPiAgICAgICAgIGJvb2wgcmV0
ID0gZmFsc2U7DQo+ID4gICAgICAgICBsb25nIGluZGV4Ow0KPiA+DQo+ID4gQEAgLTE1NjksMTUg
KzE1NzEsMTEgQEAgYm9vbCB6c3dhcF9zdG9yZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICAg
ICAgICAgICAgICAgICBieXRlcyA9IHpzd2FwX3N0b3JlX3BhZ2UocGFnZSwgb2JqY2csIHBvb2wp
Ow0KPiA+ICAgICAgICAgICAgICAgICBpZiAoYnl0ZXMgPCAwKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gcHV0X3Bvb2w7DQo+ID4gLSAgICAgICAgICAgICAgIGNvbXByZXNzZWRf
Ynl0ZXMgKz0gYnl0ZXM7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIGlmIChvYmpj
Zykgew0KPiA+IC0gICAgICAgICAgICAgICBvYmpfY2dyb3VwX2NoYXJnZV96c3dhcChvYmpjZywg
Y29tcHJlc3NlZF9ieXRlcyk7DQo+ID4gKyAgICAgICBpZiAob2JqY2cpDQo+ID4gICAgICAgICAg
ICAgICAgIGNvdW50X29iamNnX2V2ZW50cyhvYmpjZywgWlNXUE9VVCwgbnJfcGFnZXMpOw0KPiA+
IC0gICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBhdG9taWNfbG9uZ19hZGQobnJfcGFnZXMsICZ6
c3dhcF9zdG9yZWRfcGFnZXMpOw0KPiA+ICAgICAgICAgY291bnRfdm1fZXZlbnRzKFpTV1BPVVQs
IG5yX3BhZ2VzKTsNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gdHJ1ZTsNCj4gDQo+IEhpIFNyaWRo
YXIsIEl0IGxvb2tzIG11Y2ggY2xlYXJlciENCj4gQW5kIHdlIGNhbiBvcHRpbWl6ZSBpZiBpdCB0
dXJucyBvdXQgdG8gYmUgd29ydGggdGhlIGNvbXBsZXhpdHkuDQo+IA0KPiBNYXkgSSBhc2sgeW91
ciBwZXJtaXNzaW9uIHRvIGFkZCB5b3VyIFNpZ25lZC1vZmYtYnk6IGFuZCBDby1kZXZlbG9wZWQt
Ynk6ID8NCg0KWWVzLCBwbGVhc2UgZ28gYWhlYWQgSHllb25nZ29uLg0KDQpUaGFua3MhDQpLYW5j
aGFuYQ0KDQo+IEknbSBhZnJhaWQgdG8gdXNlIHRoaXMgd2l0aG91dCB5b3VyIGNvbmZpcm1hdGlv
biBkdWUgdG8gdGhlDQo+IERldmVsb3BlcidzIENlcnRpZmljYXRlIG9mIE9yaWdpbi4NCj4gDQo+
IEJlc3QsDQo+IEh5ZW9uZ2dvbg0KPiANCj4gPiA+ICBwdXRfcG9vbDoNCj4gPiA+ICAgICAgIHpz
d2FwX3Bvb2xfcHV0KHBvb2wpOw0KPiA+ID4gIHB1dF9vYmpjZzoNCj4gPiA+IC0tDQo+ID4gPiAy
LjQ3LjENCj4gPg0K

