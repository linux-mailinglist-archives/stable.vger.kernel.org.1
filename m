Return-Path: <stable+bounces-110906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BDA1DD5A
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702FE165988
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49931192D86;
	Mon, 27 Jan 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBtQg9Eb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB3191F74
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009673; cv=fail; b=LhsfhwR2ahlnnTWPKvz/visOJVlV5jDrMM2UqXB2M5QJjxSa/udPI68zI6Y+hwqW+fwcHCQttwYYoyguC1Rk5bO63ndHtLrKPDTjIHmj2P8cNYixXKPK8i2aLAxE4EyEExUJguGhNWU/K3a6fdKCKYj5jEJ2IeNLITntUeaSzIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009673; c=relaxed/simple;
	bh=c2dpjGufbUM1n9HxR6nx+LPuFzs4VI1BSo95wGjyH7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU87ShKJUbVS56RWsDoIjz4U0kr1F845OVaPvFlg65TyaEQ0OkLhPS+J9ZdHGmkE9/quElsQjLRcYdYO8neeGy6xv53jX2iV7LOsoA9/TW6Bd3VTNIhz4/1OvFWifvYgAZ0mTOlinSmfZDS6b8KqUssK/g0WO81SxRCZiQN5bvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBtQg9Eb; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738009671; x=1769545671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c2dpjGufbUM1n9HxR6nx+LPuFzs4VI1BSo95wGjyH7w=;
  b=RBtQg9EbDN2VCAP10km7cb9+9bGRGXc+MOSMrfcYIF63U7IRC6PNeGkN
   Gha2Dy5X1HaZzw0cAR9Wo16KxnUAcsiJ/xpRws7Mi5lTE3vy8Ei95aq0D
   BWI9FjUBJTGplBF+sJZ5yjGIb1aFeycJsGbE1tqYOszhMbXuPZ8xAhQf8
   OPyZGkmzPRaTj4DsG6GEoTBz5wd7tj5+SY32g6tpO5R4hredWuRioIM7X
   vUU2asXo7aFbSM3Qez2aNoVdjvqPYkc8cy3HjGaEMakuH0Nvn/fVBVmor
   VCBQtgfgDv+039EtRnaxxTNNtHOFmZLr4wByTiLrkBXRh+Nbe7ARqvWfE
   A==;
X-CSE-ConnectionGUID: a5ZdsWzhQzKV8mDK+9JHjw==
X-CSE-MsgGUID: dolwy/fwQ/GrnVkZ+KAhKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42242497"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="42242497"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:27:51 -0800
X-CSE-ConnectionGUID: z8i6TZ9xShm8hp7Bt1YkyQ==
X-CSE-MsgGUID: Do5XGjyBRiGHqGbeefW74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113675756"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 12:27:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 12:27:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 12:27:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 12:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDcHk+NiOQ5llGhGhHGKjqTmsbdUnR8MSqwWKIUAPF80m46jvKjjytWoTRMSREhlTK4y3WcEdcra17iXoaqH+N/lBKWuv3j6Wd2M6CF2KvnZ20LZX+BgDT/HmMkLnGIzUn1I+QhvZSyKdqGw2MAWndD6TtOcLAl6b9EO0Rf5+HVK1qsDcJzkqA1yFD87MQdcsmuCGRQf4fxbQlm1833GSLxr14gqbO3SDnFNCpFhaOINn32mNmVyPbdD/O2U01/JBWLIZ2lgQ5DAA9p3Mz781g5/SnMIl2E2SESreLSJ/gZ5oUMa/ykbQBF+U9/AgPV0PokjDRLs62m0bc42WJXNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2dpjGufbUM1n9HxR6nx+LPuFzs4VI1BSo95wGjyH7w=;
 b=c+dMBgWPJ2ocBsIzds1ecTmDVH17Wx8EyOK/1wpfD8mh5nl0xPLjKXyEFhqiE2qt5yK71KLmhp6N3dRonxDzCyiZQddVSBNeN36tbe2GdzkNi8u8hZYFB8Ritparh+92mfRK6GSOOrgXEoyaPiny+xz8hg29TKLhoXbMlO93Cg5GClu/cRH4uidzortTvNNblzMMZFH0h4+6h3Zq134HoSQFBdjAbvqDmnQvzMEf+gPI0wA0IZcnwV3ZkPOv243gCf/bYUQCcHzNkBL0kinQSXs6upTlo7P3Yr5FbTTYUOiLNdeib6hsh+ppbMYXq0G8KJ86+tOkgD7CWjsncnoiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 20:27:46 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:27:46 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Harrison, John C" <john.c.harrison@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Topic: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Index: AQHbbVVMFHgSix08VkSGVxA9T7ZR57MkZ3cAgAAEpgCAAAX6AIAAH5oAgAAFWACABoIigA==
Date: Mon, 27 Jan 2025 20:27:46 +0000
Message-ID: <7edb31ae5efc9d146feb446dc95e13e573f74dea.camel@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
		 <20250123051112.1938193-2-lucas.demarchi@intel.com>
		 <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>
		 <kw4rrdedc3ye5elnis6bjz2xg34ttrul2d6qye5lm3ixeee36l@ncfk65fdvb4s>
		 <82a330f4d0c43036e088939cd6ba59790173447f.camel@intel.com>
		 <eucwwgbk6fctubofysjtkvibcci2p4c76bzl2kdsar2c22xjug@zhvnmqvf7zw3>
	 <7c63b8da8dbf20b630f8dfb33858d7269441f4d8.camel@intel.com>
In-Reply-To: <7c63b8da8dbf20b630f8dfb33858d7269441f4d8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 24065cda-55a6-40b8-519b-08dd3f110f6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEZ6WmxFbnJRVWp6cmtibTQvWVlNMTlZSFQyMFIyT1pQMGttME9rSEFLaVBj?=
 =?utf-8?B?cHF1SFhFbHZOTHU0NExteS92Mm05NU5ES3B5ZXdnQVVLZDRVUzF2c3Y2b2kr?=
 =?utf-8?B?eDZ2ZXFsbm80VjJqQjBzbXFQYUJMdUlMQVB2bVVlMTJwLzlNRFFjQjZJKzZG?=
 =?utf-8?B?dWdhQzBnc2J2Q0ZQNUV1Uzh6aVZkVkYwMWNSK0RqdkVrcWE4c3RTTGlwT0V0?=
 =?utf-8?B?WDkrdWVIbldtOWZMZko0WlluSENxcE1KcEJ4a3gzRFU5Y0MveHVVcFJmNUhY?=
 =?utf-8?B?WjFLc01vNFpwWnFkTlBtbElkeC9tTWNsbFd4dlZPMjhSb0ZSTkpsQ2tzQyto?=
 =?utf-8?B?STRvZ2p0M3NoUUFKU3pXd1lUd0tyZStwTHVFSW91cHlpVlphbDgxbVVVcC9j?=
 =?utf-8?B?djdkWHVacXBMSEdvbmthTC9CSUpudWZQUkhlTmFhVmhua2NtL2FBU3k5UmpI?=
 =?utf-8?B?Y2o0dlNFZXVKWmVzdm9Tc2h1dDkxTzJ6Y0Zrc0dpVEg3dzRkRGx1MStQems0?=
 =?utf-8?B?U3Vpdkd3eFl3V0IvZkhKRGVUSnBTOGwzbXdNaXNWZjV4cDRMQUJqK3crYVN2?=
 =?utf-8?B?NFNKL0pxL2lFdGNuS1FXb0dIL0FHbVF3Yml0akRESDBGNGdpKzIweGNVV0Jo?=
 =?utf-8?B?bGNNb3FXSkgrNGJlWTlTcE91enFMR3Y1YWg2WlNoK0c0VDl5T3YxWFBUTnVk?=
 =?utf-8?B?eVZQaXNvbGxySVU0ZnVnL1NZWjVrZjdLTFV0dlZKZmNVU1JqMjZnNTcwbkJ3?=
 =?utf-8?B?VFBIaEtjeVdodTRwUHFMUlJjOWpXYmQ2VTcrRS93dGIwcTdzT08ydVFjNytu?=
 =?utf-8?B?T05rVmxXZnJLUDhXdkZMVEw3MEMrTCthd3prczlwOXJJQ2tYRWJRVVlLOXly?=
 =?utf-8?B?eEZvN0hXaVl2VktOL1FUMXVRR256VC9VSUR3SXFJMFFwZTB5Mk9zWjBkOUFz?=
 =?utf-8?B?MitHaXFZR1VxRk9OdGNjekp5djFmWHhjVEQrYXRVK0ZJMnFrbGlZaEJjc3Fx?=
 =?utf-8?B?YmkvVEtHSDFpVmpwdXJUMXlWekxCYVY3cUk3OEc1Z1FUejRCTklUdlVOVjli?=
 =?utf-8?B?c3hQWkszQlBFaTB3b2FtNjJsVHV3MHZKRjBhSlcyb1lCbnJ0TnNiSVRaL042?=
 =?utf-8?B?YmFzeHZ2RGxMVE1CaUM2SVlsNE5UbVFNVlZCcmFxWWR6czZleWh1U1dDZGpM?=
 =?utf-8?B?QkRPOUFhcThNZmF5LzZhUzdGOUZSZHRTY2h6a0JTbzVkeGVTYUp1UGV3RnRl?=
 =?utf-8?B?bUQ4Z2VoV3Z5SXQ4L09kMjdTeVd3eldwZytuV0txNG5BWDBTVWNtRENuV3Vq?=
 =?utf-8?B?dy9RdWdETC91S2JlZWs4Zmt3S3pvdmJnWkZPL2JCWndPY0U1dVVlZ1ZpR0VN?=
 =?utf-8?B?Q2JsVWxQNjUwLzVkcmhUcURPTWV6TitqeUx1d3ZWVnZUaWFYUE9wNUFNcnpi?=
 =?utf-8?B?QTgwZGZSTnA2OHd4YlJFdFJTN3hUbjVvL1EwQ0V2d1VUeW1QTmlQK21oSFRn?=
 =?utf-8?B?K1VteUliZW1qMmxJL2hJZEFaQ0pxUlNMTHBCczJncGMvZit6UWhVK3dmbDJI?=
 =?utf-8?B?M1RLb0NBSWhLQmdXMC9sN2thckw5WC9mZkdZUFZQMFQydnpiMzRXQlhITmUz?=
 =?utf-8?B?YVRvWnQ4Z29LN2FzWnoybzhtTEFLVVl1Nko0TmsrTnZTYmNDK2dqQ2RFU0hH?=
 =?utf-8?B?d3k2YVVwcUVxaVR4ZHNxUUR4UU9Bd2NodC81YXEwQ2VGRkc4amxzamJvazYy?=
 =?utf-8?B?MmJWeVA4TTRpNkVUbkdLaTdkSTlMbmtYelZmMkRTSUQ0L3pRanR2LzRHeHJ4?=
 =?utf-8?B?MFllUS8zVUgxclJ3bitwT1hRTTFtVUFLRWZETDNhN1k0NkdoSy8zai9FZTdG?=
 =?utf-8?Q?5ZF5d08q21FWo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVuQy9uN2o2SXBwekdQSEhRN3RrRFA1R1cwNU9aNC8rTnJ6elZDRm9uMVJx?=
 =?utf-8?B?bXhLL0loUTZld3pwbXRnUjh5OEN4bmFWVkZHQ1Q5L055KzgwaE1SaUU5ckhz?=
 =?utf-8?B?ZGlEQ1lrRDBFdTJGSk5BcTBqcUp0clJBcWYrQ01GYU9Wbi9MYkIyeGhWcmhy?=
 =?utf-8?B?a1dWcFp1bW44TXkxVkNVSWtvMWc5VGxWS2V5Y3hIczRPeC9oZmZIWHZkc09a?=
 =?utf-8?B?SWhVNE43REVJM3ZCd290Q1MvSkVydGJEczNOYXArVUM2MDAyNVlncTBrZkZM?=
 =?utf-8?B?Z0wyTms4NXdNaDVaYzBPVjdUeGZsenFFT21vY0puUG9tenVRdFF5YjBIZ0Fy?=
 =?utf-8?B?RVVlYXQ5aUFybmxyQXYvRCtxbWEwajA4SDdneDVJUitXV2tuTHltc0lXWGcx?=
 =?utf-8?B?amFFeEg2a0Q2M2ZSQmZTZkJUbkNmT0JabUd6Z2dISFd6dWhVcFNtQlR4bWdM?=
 =?utf-8?B?TEM0YkVLbTQyV1Zib0x3UW1lZEJEZ0ZNUFpnL2NCdDIwSDV4NTh0SXA1Z0FU?=
 =?utf-8?B?NForWGh0aXdzSXI3dXhteVZoU2dnUzdrSktFRWU3OVRDcVYrZDhWc2hDU0Rj?=
 =?utf-8?B?WkM0RmdRbktWNkNyUGVqRGRDcHZJZWNzRWZUZk9MZUNpM09NT29WTXY5RkJD?=
 =?utf-8?B?SDNCL2dRNTYxMWc3TGt0elBPZDA0ZnIrQzJZV2kxZ281MEJ0SlhYazdUQnRV?=
 =?utf-8?B?dDV1WnIxUk1VTkNDdjJGaS9IS3ZCOGpZWFE5Ny9sOUo5UzVJS2VvdS8xdHlT?=
 =?utf-8?B?Ly9WK1NPcGNRV0dicXZISHU2RnJWTUNvZGk0ZGJJNThvQ0FvWE10cGkwV01y?=
 =?utf-8?B?bXBuTXR3cXc1eFVRWExlT1Fid0lPOU5kV3g2clJuVzREQXhtZHdtNWxsckxU?=
 =?utf-8?B?S2FlbUdWY2pvRVFObTlKSDYwZzVlb3lnNnYvYTJxckFOTXIzb1I3M2kzc3Vt?=
 =?utf-8?B?c0VNeERPQnlBZ2FzU2dyTGhBQmR2OWtlaHJQMkppYkptSktFTFduYjk5UzlQ?=
 =?utf-8?B?a0tSRDNSSGRkWDVxZHJxMXRDTkZjRXE1eEMxTFZjek10TzhIdnQvalZuWlkz?=
 =?utf-8?B?ZXdyamhkVk1pVWFwRHYvSEk5UUlGVHVjRWhlMzBCQjl3a1BEK2k5dzVYTmNN?=
 =?utf-8?B?N3JUY1NrVExRUWRKS2tCS1FwVGcyNGttVEE1MzhUUzVSZE10RzI0RjNGZk45?=
 =?utf-8?B?VFJNOE5qa3FwSDMycC9QMXMvakpQRkxwOTZJemhsaDRoQStLK0ZaTXF3K3FT?=
 =?utf-8?B?aW9kdktQaG5nc0l3Mkk1M0U3ZWpDVXJCandqVFl6aTEyanE0TWJ2S0ZQTFJx?=
 =?utf-8?B?WnV6UHhVamI3bE9Dek9ja2xva2hjSThUR0pYMGlJek5hdEpkcUZiNkhVZVdU?=
 =?utf-8?B?UldHRlNmSVhVN3dJSTh2Qk1GUkg3SnJNYVRmc0Q2T3M5WTc3WHpJdWwyYUdy?=
 =?utf-8?B?c2ltUmc1djVyM2pySXZleXcwNkhGdkNWVUxBTDE0cWx5SExmdXg2RWQ1cnpO?=
 =?utf-8?B?Rzc5emNyUjY2M1cwYklyVUpxWE1DS3BRNGZQNkgyWU4wTmZmaHVMdFgvdmUr?=
 =?utf-8?B?K1diSGkzRlZ6L1JTbFpuZG9zSHRRdE55WHVGNlJZYTJBQU5LZjZIZEpKSVA5?=
 =?utf-8?B?aFdyblAyMS9WNjJXcWZkU2Mxamo3MG5aVFo4ckM1TVU3czUwUWExdCtYamk1?=
 =?utf-8?B?YmRLZlYwNTArS0hManBxK1RySDNnK3pNcWNMTjhSdDg3dUpXNUJTa0gxczZa?=
 =?utf-8?B?WG9PQnZ3SjlLemZWb1FobWl2UllMRUUxNzhRZkoxNGhoUDB0RUFOM3J3YzAy?=
 =?utf-8?B?ajdoMlMxUWgrU0NoNUVJOVdCQnNKeFF1YVV6NWZnT1J1RnFFUk1YVDdKZXpJ?=
 =?utf-8?B?YnJFVlFHNXUybUJQWmtoY0h5N2s3UzVyZmtVM3A3VVFHN1lJdlliclJjM2xH?=
 =?utf-8?B?RDlPTTNxZGVsUGEwb0V0N3RGWHBzSDVia3U4ejVhQUdmK1Y5ZHpCVEhlREJZ?=
 =?utf-8?B?cGl0NGpCTDJBYTJmYW9nYVNDK3FrNGJ5SXpzMXlySmJzaXgremgvOVZHZHBh?=
 =?utf-8?B?SC91UFk2RCtkMWZFT0pXdGxSL1RyNCtUemdCaGVGVzRNcWs0bGd6dSt1YmdM?=
 =?utf-8?B?U3RadmcxTUsrTjFUUDNXZkQzd24vbE52cGhvWERPNURTL01qWk1LdXI2bkFk?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF4AD78EF5A144DB4B7ECF04E65D0CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24065cda-55a6-40b8-519b-08dd3f110f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 20:27:46.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzxQnwdfUP326vnQutWVGvhWdmHoWfDlqkXQaMnqTuiKQAt8PbwhqRz2AM7/qZGvCPglX5gxlXeEXBhS9hR4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDA5OjA0IC0wODAwLCBKb3PDqSBSb2JlcnRvIGRlIFNvdXph
IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjUtMDEtMjMgYXQgMTA6NDUgLTA2MDAsIEx1Y2FzIERlIE1h
cmNoaSB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAyMywgMjAyNSBhdCAwODo1MjoxM0FNIC0wNjAw
LCBKb3NlIFNvdXphIHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDI1LTAxLTIzIGF0IDA4OjMwIC0w
NjAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgSmFuIDIzLCAyMDI1
IGF0IDA4OjE0OjExQU0gLTA2MDAsIEpvc2UgU291emEgd3JvdGU6DQo+ID4gPiA+ID4gT24gV2Vk
LCAyMDI1LTAxLTIyIGF0IDIxOjExIC0wODAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6DQo+ID4g
PiA+ID4gPiBIYXZpbmcgdGhlIGV4ZWMgcXVldWUgc25hcHNob3QgaW5zaWRlIGEgIkd1QyBDVCIg
c2VjdGlvbiB3YXMgYWx3YXlzDQo+ID4gPiA+ID4gPiB3cm9uZy4gIENvbW1pdCBjMjhmZDZjMzU4
ZGIgKCJkcm0veGUvZGV2Y29yZWR1bXA6IEltcHJvdmUgc2VjdGlvbg0KPiA+ID4gPiA+ID4gaGVh
ZGluZ3MgYW5kIGFkZCB0aWxlIGluZm8iKSB0cmllZCB0byBmaXggdGhhdCBidWcsIGJ1dCB3aXRo
IHRoYXQgYWxzbw0KPiA+ID4gPiA+ID4gYnJva2UgdGhlIG1lc2EgdG9vbCB0aGF0IHBhcnNlcyB0
aGUgZGV2Y29yZWR1bXAsIGhlbmNlIGl0IHdhcyByZXZlcnRlZA0KPiA+ID4gPiA+ID4gaW4gY29t
bWl0IDcwZmI4NmE4NWRjOSAoImRybS94ZTogUmV2ZXJ0IHNvbWUgY2hhbmdlcyB0aGF0IGJyZWFr
IGEgbWVzYQ0KPiA+ID4gPiA+ID4gZGVidWcgdG9vbCIpLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBXaXRoIHRoZSBtZXNhIHRvb2wgYWxzbyBmaXhlZCwgdGhpcyBjYW4gcHJvcGFnYXRlIGFz
IGEgZml4IG9uIGJvdGgNCj4gPiA+ID4gPiA+IGtlcm5lbCBhbmQgdXNlcnNwYWNlIHNpZGUgdG8g
YXZvaWQgdW5uZWNlc3NhcnkgaGVhZGFjaGUgZm9yIGEgZGVidWcNCj4gPiA+ID4gPiA+IGZlYXR1
cmUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyB3aWxsIGJyZWFrIG9sZGVyIHZlcnNpb25z
IG9mIHRoZSBNZXNhIHBhcnNlci4gSXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5Pw0KPiA+ID4gPiAN
Cj4gPiA+ID4gU2VlIGNvdmVyIGxldHRlciB3aXRoIHRoZSBtZXNhIE1SIHRoYXQgd291bGQgZml4
IHRoZSB0b29sIHRvIGZvbGxvdyB0aGUNCj4gPiA+ID4ga2VybmVsIGZpeCBhbmQgd29yayB3aXRo
IGJvdGggbmV3ZXIgYW5kIG9sZGVyIGZvcm1hdC4gTGlua2luZyBpdCBoZXJlDQo+ID4gPiA+IGFu
eXdheTogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2EvbWVzYS8tL21lcmdlX3Jl
cXVlc3RzLzMzMTc3DQo+ID4gPiANCj4gPiA+IFN0aWxsIHNvbWVvbmUgcnVubmluZyB0aGUgb2xk
ZXIgdmVyc2lvbiBvZiB0aGUgcGFyc2VyIHdpdGggYSBuZXcgWGUgS01EIHdvdWxkIG5vdCBiZSBh
YmxlIHRvIHBhcnNlIGl0Lg0KPiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQgd2UgY2FuIGJyZWFrIGl0
IGJ1dCBpcyB0aGlzIHJlYWxseSB3b3J0aHk/IG5vdCBpbiBteSBvcGluaW9uLg0KPiA+IA0KPiA+
IGJlY2F1c2UgZm9yIHRoZSBkZWJ1ZyBuYXR1cmUgb2YgdGhpcyBmaWxlLCBpdCdzIGhhcmQgaWYg
d2UgYWx3YXlzIGtlZXANCj4gPiB0aGUgY3J1ZnQgYXJvdW5kLiBJbiA1IHllYXJzIGRldmVsb3Bl
cnMgaW1wbGVtZW50aW5nIG5ldyBkZWNvZGVycyB3aWxsDQo+ID4gaGF2ZSB0byBnZXQgZGF0YSBm
cm9tIHJhbmRvbSBwbGFjZXMgYmVjYXVzZSB3ZSB3aWxsIG5vdGljZSB0aGluZ3MgYXJlDQo+ID4g
d3JvbmdseSBwbGFjZWQuDQo+ID4gDQo+ID4gaXNuJ3QgaXQgZWFzaWVyIHRvIGRvIGRvIGl0IGVh
cmx5IHNvIHdlIGRvbid0IGluY3JlYXNlIHRoZSBleHBvc3VyZQ0KPiA+IGFuZCBqdXN0IHNheSAi
a2VybmVsIHNjcmV3ZWQgdGhhdCB1cCBhbmQgZml4ZWQgaXQiLCB0aGVuIHByb3BhZ2F0ZSB0aGUN
Cj4gPiBjaGFuZ2UgaW4gbWVzYSBpbiBhIHN0YWJsZSByZWxlYXNlLCBqdXN0IGxpa2Ugd2UgYXJl
IGRvaW5nIGluIHRoZQ0KPiA+IGtlcm5lbD8NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gSXQncyBhIGZpeCBzbyBzaW1wbGUgdGhhdCBJTU8gaXQncyBiZXR0ZXIgdGhhbiBjYXJyeWlu
ZyB0aGUgY3J1ZnQgYWQNCj4gPiA+ID4gaW5maW5pdHVtIG9uIGFsbCB0aGUgdG9vbHMgdGhhdCBt
YXkgcG9zc2libHkgcGFyc2UgdGhlIGRldmNvcmVkdW1wLg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+ID4gSXMgaXQgd29ydGggYnJlYWtpbmcgdGhlIHRvb2w/IEluIG15IG9waW5pb24sIGl0
IGlzIG5vdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbHNvLCBkbyB3ZSBuZWVkIHRvIGRpc2N1
c3MgdGhpcyBub3c/IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBmb2N1cyBvbiBicmluZ2luZyB0
aGUgR3VDIGxvZyBpbiBmaXJzdD8NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQncyB3aGF0IHRoZSBz
ZWNvbmQgcGF0Y2ggZG9lcy4gV2UgbmVlZCB0byBkaXNjdXNzIGJvdGggbm93IGFuZA0KPiA+ID4g
PiBkZWNpZGUsIG90aGVyd2lzZSB3ZSBjYW4ndCByZS1lbmFibGUgaXQgYW5kIGhhdmUgZWl0aGVy
IHRoZSBndWMgbG9nDQo+ID4gPiA+IHBhcnNlciBvciBtZXNhJ3MgYXViaW5hdG9yX2Vycm9yX2Rl
Y29kZV94ZSBicm9rZW4uDQo+ID4gPiANCj4gPiA+IEkgY2FuJ3QgdW5kZXJzdGFuZCB3aHkgaXQg
bmVlZHMgYm90aCwgY291bGQgeW91IGV4cGxhaW4gZnVydGhlcj8NCj4gPiANCj4gPiB3ZSBhcmUg
YWxyZWFkeSBkaXNjdXNzaW5nIGl0LCB3aHkgbm90PyAgQWxzbyBhcyBJIHNhaWQgdGhlcmUncyB0
aGUgZ3VjDQo+ID4gbG9nIHBhcnNlciwgYW5vdGhlciB0b29sLCB0aGF0IGlzIGFscmVhZHkgZXhw
ZWN0aW5nIGl0IGluIHRoZSBvdGhlcg0KPiA+IHBsYWNlLiBTbyBpZiB3ZSBhcmUgZ29pbmcgdG8g
cmUtZW5hYmxlIHRoZSBndWMgbG9nLCBpdCdzIHRoZSBiZXN0DQo+ID4gb3Bwb3J0dW5pdHkgdG8g
Zml4IHRoaXMsIG90aGVyd2lzZSB3ZSB3aWxsIHByb2JhYmx5IG5ldmVyIGRvIGl0IGFuZCBrZWVw
DQo+ID4gYWNjdW11bGF0aW5nLg0KPiANCj4gTXVjaCBlYXNpZXIgY2hhbmdlIGEgaW50ZXJuYWwg
dG9vbCwgbm8/DQo+IA0KPiBUaGUgR3VDIGxvZyBpcyBpbiBvdGhlciBzZWN0aW9uKCIqKioqIEd1
QyBMb2cgKioqKiIpLCB0byBtZSB0aGlzIGNoYW5nZSBpcyBtb3JlIGNvc21ldGljIHRoYW4gZnVu
Y3Rpb24gYW5kIG5vdCB3b3J0aHkgdG8gYnJlYWsgb2xkZXIgdmVyc2lvbnMgb2YgdGhlDQo+IHBh
cnNlci4NCj4gDQo+IEkgY2FuIGxpdmUgd2l0aCB0aGF0IGJ1dCB5b3Ugd2lsbCBuZWVkIHRvIGNv
bnZpbmNlIG90aGVyIEludGVsIE1lc2EgZW5naW5lZXJzLCB3aGVuIEkgbWVudGlvbmVkIHRoYXQg
TWVzYSBwYXJzZXIgd2FzIGJyb2tlbiBpbiBhIE1lc2Egc3RhZmYgbWVldGluZywgSQ0KPiB3YXMg
YXNrZWQgdG8gcHVzaCBoYXJkIHRvIGdldCB0aGUgWGUgS01EIHBhdGNoIHJldmVydGVkLg0KPiBU
aGF0IGlzIHdoeSBJIHRoaW5rIGl0IHNob3VsZCBiZSB0YWtlbiBjYXJlIGluIGFub3RoZXIgcGF0
Y2ggc2VyaWVzIGFzIGl0IGNvdWxkIHRha2UgbW9yZSB0aW1lLi4uDQoNCkFmdGVyIG1vcmUgZGlz
Y3Vzc2lvbiBvZmZsaW5lIGFuZCBvbiBNZXNhIE1SIHRoaXMgaXM6DQoNClJldmlld2VkLWJ5OiBK
b3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGludGVsLmNvbT4NCg0KPiANCj4gPiAN
Cj4gPiBMdWNhcyBEZSBNYXJjaGkNCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gTHVj
YXMgRGUgTWFyY2hpDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBDYzogSm9obiBIYXJyaXNvbiA8Sm9obi5DLkhhcnJpc29uQEludGVsLmNvbT4NCj4gPiA+
ID4gPiA+IENjOiBKdWxpYSBGaWxpcGNodWsgPGp1bGlhLmZpbGlwY2h1a0BpbnRlbC5jb20+DQo+
ID4gPiA+ID4gPiBDYzogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5j
b20+DQo+ID4gPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4g
Rml4ZXM6IDcwZmI4NmE4NWRjOSAoImRybS94ZTogUmV2ZXJ0IHNvbWUgY2hhbmdlcyB0aGF0IGJy
ZWFrIGEgbWVzYSBkZWJ1ZyB0b29sIikNCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1Y2Fz
IERlIE1hcmNoaSA8bHVjYXMuZGVtYXJjaGlAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMgfCA2ICstLS0t
LQ0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVk
dW1wLmMNCj4gPiA+ID4gPiA+IGluZGV4IDgxZGM3Nzk1YzA2NTEuLmE3OTQ2YTc2Nzc3ZTcgMTAw
NjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAu
Yw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMN
Cj4gPiA+ID4gPiA+IEBAIC0xMTksMTEgKzExOSw3IEBAIHN0YXRpYyBzc2l6ZV90IF9feGVfZGV2
Y29yZWR1bXBfcmVhZChjaGFyICpidWZmZXIsIHNpemVfdCBjb3VudCwNCj4gPiA+ID4gPiA+ICAJ
ZHJtX3B1dHMoJnAsICJcbioqKiogR3VDIENUICoqKipcbiIpOw0KPiA+ID4gPiA+ID4gIAl4ZV9n
dWNfY3Rfc25hcHNob3RfcHJpbnQoc3MtPmd1Yy5jdCwgJnApOw0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiAtCS8qDQo+ID4gPiA+ID4gPiAtCSAqIERvbid0IGFkZCBhIG5ldyBzZWN0aW9uIGhl
YWRlciBoZXJlIGJlY2F1c2UgdGhlIG1lc2EgZGVidWcgZGVjb2Rlcg0KPiA+ID4gPiA+ID4gLQkg
KiB0b29sIGV4cGVjdHMgdGhlIGNvbnRleHQgaW5mb3JtYXRpb24gdG8gYmUgaW4gdGhlICdHdUMg
Q1QnIHNlY3Rpb24uDQo+ID4gPiA+ID4gPiAtCSAqLw0KPiA+ID4gPiA+ID4gLQkvKiBkcm1fcHV0
cygmcCwgIlxuKioqKiBDb250ZXh0cyAqKioqXG4iKTsgKi8NCj4gPiA+ID4gPiA+ICsJZHJtX3B1
dHMoJnAsICJcbioqKiogQ29udGV4dHMgKioqKlxuIik7DQo+ID4gPiA+ID4gPiAgCXhlX2d1Y19l
eGVjX3F1ZXVlX3NuYXBzaG90X3ByaW50KHNzLT5nZSwgJnApOw0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiAgCWRybV9wdXRzKCZwLCAiXG4qKioqIEpvYiAqKioqXG4iKTsNCj4gPiA+ID4gPiAN
Cj4gPiA+IA0KPiANCg0K

