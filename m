Return-Path: <stable+bounces-111054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A75A21220
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 20:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C061886E46
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA751DED64;
	Tue, 28 Jan 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRGbgt40"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC31DE4FA
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091979; cv=fail; b=LKZaupYyY0Eq5pcu7zaowQNnUczxBML6huFcNLfFz47VoOC2ChdAPgOWeaATVakUyKWL1JYzZ9TH/virGQZgIC9N/zEc/IZ+HX4l1v3/kEgMjE0Nu6WsXenAr8LLft5+SLclvaYpvcHYJ6ZzoC0GdoNGQH+u+sEbKksyEfezcVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091979; c=relaxed/simple;
	bh=nc8gAkqJhv4vQAE4b/Tdr7UfhySMjifLM1cB2DWpkwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MDBvX4bRAVb4CQo6qa3DBrh4vbzMUNnxHUSpex2CUY4yEbhNdnHNusnTuU1dGHhfvRTvLFMlejlT7l0uJHzm4QOhxpb9BqO6xE14fK77RW+Plpqua3t8WdRb71TZhr7GoHwPaCP3ybgoq1ItCvIwJHmfWmyHB/HfaiiuUmwmyGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRGbgt40; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738091978; x=1769627978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nc8gAkqJhv4vQAE4b/Tdr7UfhySMjifLM1cB2DWpkwg=;
  b=SRGbgt409kKWXNNwNF6/3HFRDEkqX7R4gMN7/M7qa5NQbBr7vpZuNswt
   Gq7JzpiA9//xHjTR9X+Qp2iHz9CPPmkO8ZzKYheKN4glxKbT7JSXzZ8hg
   Lt/UXlekWJAF5ImmvMzxjzcU1vNWN0RxGEkTbcB7+drX6IeTJyYNtlx/s
   a0b1aq67bTMR66IMGZnT4ZnPUB3iDhH/SnP69neNZ9bdAOV3m4H6UcEoc
   aYxm9kAQWqPz/MGnXq8P+Yaulsj8FCmaEHE1aqU517a9uIc+sqK6AM6Ls
   DgzMCUiERgQC6gTyFWvPoxpo/3NQzUIr0pzOlGuiRpKr+8iC8535WZVeO
   A==;
X-CSE-ConnectionGUID: entxbRyxRByyJFydSzybZA==
X-CSE-MsgGUID: eTC7w944SkaH4/1fFQHa6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38847139"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="38847139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 11:19:37 -0800
X-CSE-ConnectionGUID: FEP1UEfYS0SWKyDQ5Y4cSA==
X-CSE-MsgGUID: uck5zszdRHmT0XF3uA8Nzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139696812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 11:19:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 11:19:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 11:19:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 11:19:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBadCcXTx1RUSvxGkoj2maaCkqH9L7mlIfBGcF0sD+vsXc2vJlSGe6izak+t3P8ARE6FUm82bh4hGOguAf3ZX0SHL+QkvIt7/ZG72kDsefFzZ2zykL5r28GObJvIpgtC0NFHkOy0bwoO7XqAI+oA8qt2kzP4slieYo2y98VgN+k45R3+i/lcQ5R43chgr68HRBS1niJY0iBGMuXyi7HTTVi3E64zdGqdsy41BsklodWUNQxb8sdqeMTJdZohJVIJzPQKQ0CpQQ7SVvHEam2UcKyPUSePG8rgbgtLtCDvViikPK7rix2/4ksXvyR5dv5ccq9UOwwhL4kG78Esgjx1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyL8NPUX8n8Lirw+mputW/GFKSReYQKRBTZvnKJyxvU=;
 b=WqBNzTopOP6lVMbElmRbF63vOe20FUXb5HbPEW+g5Lyhy3IiBbGR0cYC+J0MYI5wFsD2V880FkjdhCIzX1+sfSwKyFbrOA0NxFM0AyslCrDwVEJQQ2yJ+rc11tdpCi3MCH4MM/KAkeCmfZ1vjD0eib9u0zEzFdX0mikHpXfPnSdHYwCjE7y3wfPZLFvyYQ0N3V5iKEWtSRKrpWdzq9ofgJO1KO6xLkVfeEMFI/2Wn7bxN9WPzmMyGtR9CpgMtz/WEGDfmg4rw1+v2FBfD6XYu3DAQS65IFry3XWLJREaGELf6QYTQztbYw1uOuk5bkfac2SCdfeILwAtQnPh5nWshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 19:19:34 +0000
Received: from SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c]) by SA3PR11MB8120.namprd11.prod.outlook.com
 ([fe80::3597:77d7:f969:142c%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 19:19:33 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Topic: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Thread-Index: AQHbcWrWrMuYujkV70ixrrCNNvf9Y7Msi+2AgAADkVA=
Date: Tue, 28 Jan 2025 19:19:33 +0000
Message-ID: <SA3PR11MB8120F45E44A7E6641D551EEAC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
References: <20250128185507.2176-1-42.hyeyoo@gmail.com>
 <Z5kqHT1x-_0qtduA@google.com>
In-Reply-To: <Z5kqHT1x-_0qtduA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8120:EE_|PH7PR11MB7514:EE_
x-ms-office365-filtering-correlation-id: 78e3a663-e314-4e59-a9f5-08dd3fd0b29e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oP+lWnj9pUtaDhRDAgEPvtTTeyf1wV+wldxlFGsPX31t4hoF6zoeWC9l84pB?=
 =?us-ascii?Q?yG1/DHMU+iD3E37MKEoxvdTudW+30ZXEmYm9f0/6DH6in7iOF6t31aiNMdON?=
 =?us-ascii?Q?ltc5bUzBKTAf+Kqbp5lFwxvDBaxALn4iyFgXEXrpo6H0CtgwSrcVWk1MDe5q?=
 =?us-ascii?Q?ZjxE148+Jq+JXWvC+KEVf3+t62vUKt64qs0CZyOyL2GUhxYiyd/GM2BH//Zx?=
 =?us-ascii?Q?iU1bWp6Rx5imwZ0SeCQ55bN5xBMduQIWVPkGIcXMRk0GcAkcJC+czuBv32uZ?=
 =?us-ascii?Q?m4ElLOR0apetA5ydxG8tZhyna2qdcr7Vxtg9bDWwCwBytT5Um+nRn1HdjNKf?=
 =?us-ascii?Q?24ctuwlsiRe6w4CUC5P3mvs6AMkwa9q8bCajUIoU33Ned5x2kGEwIcH0xwiu?=
 =?us-ascii?Q?rA8VgwjwzV7drixgoWI+gPiNspvjpsOhtB5zjg3whUwucSL4mQ91kfgsJ553?=
 =?us-ascii?Q?BPkBtZHS6JOF8XFtHpYx1j5cwRuBTVlkSZ4rPm0XdNlol47zCYQz+bCizFsT?=
 =?us-ascii?Q?rh9CWh9AVob+LJQ7RvmY0V3M45BxFHxoAbae7FtpDOnUhZCyB5hHyE9n0ooD?=
 =?us-ascii?Q?u55f3ghA/OTOlFgdTqodqri4Ub8YUVekT0/amnLYFxs3UEolSELD4+ZgopOz?=
 =?us-ascii?Q?PfYJDWVp6aASG4H7ZIUvNTwtkAx3bvj67pz/VowM0xOXwU1L0BWe6Fi8Hguj?=
 =?us-ascii?Q?OHiibBU0sirPF2S+Fkn8NnjfYLraLvCmTjxHNBA+639V9CknxUwuRH2IZP28?=
 =?us-ascii?Q?bkjUj46sSF0ei2Rb4Gzz2gGJ0l+/h7uxvNVcr8ZPLaU+xAfmS3+bxmYYHsjP?=
 =?us-ascii?Q?vzJsbODYPUZp/K/VTY47CxniV50P2u0JG37V9J9OG2wn0Z1p7xP06WvmBz5G?=
 =?us-ascii?Q?kMOcpyDz9BhcUzZXmDUhzQRg130EA+GdE+GOzqeSe2BSA2byR+4TYSzhR9ik?=
 =?us-ascii?Q?DOu5l6AZrlEuwwWve6jKZfZHMB3F3lvR5MREFOlU+34eGXgT2H1FgWSGgQKQ?=
 =?us-ascii?Q?mWRcG4NrMAv8oq6w9Pj/F+XuNslconWbbTw2VAN7VvYdi+k1VS8pcpc4iP0+?=
 =?us-ascii?Q?/A89el3aixLsJMUAe3SGdMbC1Jvf9FufM19TPyJyn1jq8a2IbSRhJIZCERzB?=
 =?us-ascii?Q?OlOAg4s+3h7MCjO95u7YnFEtMr/f5I4zOdxrBKimxjfnlXRnVh0KTcA7K3bE?=
 =?us-ascii?Q?IJ8YutHRep88CfrBRdWhCAo768/cNYrtNKPlypJ93xC8mzLrXmxQ0jxtSHKy?=
 =?us-ascii?Q?T+47Qmoz5+/7/R7Aka7IXGVbJb5/aoz9nmIRgrSW99MBuKMiLxHHIApiqvUQ?=
 =?us-ascii?Q?P8pYECTD6ip1nUH/fjAa6eFqkDyAjodr1twReWc8ruulJ5hbgel0gSYMKywQ?=
 =?us-ascii?Q?0q8adxzuNV/37s+4LBb6MeKItGBcw4wP3fRD2X5lf0YlNILXLMFMd8Q+CMkU?=
 =?us-ascii?Q?eqs7m1U3/Rmuk1/KtN+PDkHBeEG/Wo88?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v54sh4oqY1DgHQIpjnJR5iEGbrAqmaH8WlLC+OhCsiSHpB2vZiEVA9j2Ge+Z?=
 =?us-ascii?Q?eBdhRWV7RQRhErEEEu6zgkDIG2zNfNhygbwZ1oX9zvCrS7DMSmkoRLZHcS5L?=
 =?us-ascii?Q?fWgmmHXfLrqZAKmNoVjUTW9PRcRqmk6nl7Lw1evLXYsgC/WMFmwjDeYvZ8Dh?=
 =?us-ascii?Q?DowTlhrm36e6TCr/lTrh+BaxNT+RU/L4LmNwA64RA28lnfwidrfyxo+SIJ8w?=
 =?us-ascii?Q?Na+Si3Tfihy9sB4kYwCOyGxGB5otzwJsPfqyqiGvzcGwyuvUmKvVEWcpgQjY?=
 =?us-ascii?Q?pUH5x10IGiVx5VuXPyJbRTD5lMDwoHPid3woPzo14F00/Vh6ImlZVDJpgU2l?=
 =?us-ascii?Q?OT6PyvZDHeqg05g8+UCMqqaUHQcY2oy5D/unQKtRT6L99zv/N6F1bhCvma9i?=
 =?us-ascii?Q?OWHzv+AeJwTbho1W8FdaU8gQptZtkj6x6UevAJsFvkZdmCXwou0I1lCwM9qF?=
 =?us-ascii?Q?Xx8AFraVHN4PHzE9CeLJcJkP4OZTNLs1ttY4yvo6BFo5fJKSXbbJhDry+yoV?=
 =?us-ascii?Q?DbTIY5qVF+1FcFYiE9D6nk09WYOoSxvsuCAidexWxXnPrTy7Hulgv8/v/o95?=
 =?us-ascii?Q?4TArcJ3MoH0t/pmUD7HQI8VC/a9OM1r6nol1eptjqDwC6mt5rk66VqujZp84?=
 =?us-ascii?Q?1Z01PKwc4/PCjvNLLHODH+XEP2+uq5C8WYJfFVaXD3VFDWIRntyacXd7fHET?=
 =?us-ascii?Q?lCbwYNQ08cdVzbUOgsyYU66dYmZPnYFG8WQ+yNdT99zcZqQ3v2Fn7yAnIJak?=
 =?us-ascii?Q?D2tczUpJzTls/VrvJkE6GJRLoWRk2T+H9LPk0/ERCgyQdQG9Bd+oSYUOo1xD?=
 =?us-ascii?Q?KVr7RmVDtyDgGd+SRhthlcct25Tyge9BECWH5Axiu5Wx1d2IXYwl6OEh8Xu/?=
 =?us-ascii?Q?h8i5Royx9A7qWbw8ibb1VWC3r71DioUrIlGzwIkn1WXwzSIfpp6o0zrWjJHN?=
 =?us-ascii?Q?onj/ICc5HMNAF/rde/DnYiSUDyRE0vp7uAzLMdHyGVXQ9w2A44GQH6rlKmWZ?=
 =?us-ascii?Q?BgiTo5Pm7szfdPc2sNEmZnvU+FJqVjS2ZyPlKHk8Zj7DxnKuid7WmAoc9Px9?=
 =?us-ascii?Q?NbVopRfTxZnM5b6PLNVYyx7PLNAepFIijA74TaNpsL9Wo3PT1Oxnh5J0NT6F?=
 =?us-ascii?Q?weGD8eCy5WM08wU8JpDVnPc27V3z+N3tMH3FqH0ORTIBQbiAlp/sbYiu+NbO?=
 =?us-ascii?Q?MY5Y0VRCjqkU8ItDeCOtec187bO9uiGJv0Nmp4c4SBiSVW0Ig35tn7gl12AT?=
 =?us-ascii?Q?KNqGrfR/cKcF+9/bArZhmzbubc3/uZm280K3832Gz2fUpdjDlbW0e8eJs24h?=
 =?us-ascii?Q?bSOA8w0wh97iGisZC2Ut4uaBLNL+DIOKwzeNVKTjuJAjOb6k2IFwUBTfUEiR?=
 =?us-ascii?Q?2atV+zcGYmshM3esp8qcj64ugoVyFNAPZm28uTRz6DM9sItUA6B+c0Zd3icp?=
 =?us-ascii?Q?5fPPsXmGCHXPGCb+7LzZGmlnZeNozwwVzYAyrJq1VeWWPOYzNGlcRznx4gZt?=
 =?us-ascii?Q?UyIRHV4ZsbC6NXQ6ctyos5JkFTazkBkSB8hZytZv/v2xVI3G5Ez9eTk1+d0x?=
 =?us-ascii?Q?hIoWatJdBEGjfP9ITBp0KCy4MJte/VlqGSt2JkCcxpngQawyeyrUz2YwFfOy?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e3a663-e314-4e59-a9f5-08dd3fd0b29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 19:19:33.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7H8KB/SizKxsVW9eRIp5GvcM/UdRQDr0g+TTbIB9orsdZcCscGeJRJkVvJkIJRL7R9o9OLGxVL0MnxsqRig4xoFqIM67UoY5Bmo4sKyXkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Yosry Ahmed <yosry.ahmed@linux.dev>
> Sent: Tuesday, January 28, 2025 11:04 AM
> To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Weiner
> <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; Chengming
> Zhou <chengming.zhou@linux.dev>; Andrew Morton <akpm@linux-
> foundation.org>; linux-mm@kvack.org; stable@vger.kernel.org
> Subject: Re: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging
> when zswap_store_page() fails
>=20
> On Wed, Jan 29, 2025 at 03:55:07AM +0900, Hyeonggon Yoo wrote:
> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
> > skips charging any zswapped base pages when it failed to zswap the enti=
re
> > folio.
> >
> > However, when some base pages are zswapped but it failed to zswap
> > the entire folio, the zswap operation is rolled back.
> > When freeing zswap entries for those pages, zswap_entry_free() uncharge=
s
> > the pages that were not previously charged, causing zswap charging to
> > become inconsistent.
> >
> > This inconsistency triggers two warnings with following steps:
> >   # On a machine with 64GiB of RAM and 36GiB of zswap
> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
> >   $ sudo reboot
> >
> >   Two warnings are:
> >     in mm/memcontrol.c:163, function obj_cgroup_release():
> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> >
> >     in mm/page_counter.c:60, function page_counter_cancel():
> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld
> nr_pages=3D%lu\n",
> > 	  new, nr_pages))
> >
> > While objcg events should only be accounted for when the entire folio i=
s
> > zswapped, objcg charging should be performed regardlessly.
> > Fix accordingly.
> >
> > After resolving the inconsistency, these warnings disappear.
> >
> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >
> > v1->v2:
> >
> >  Fixed objcg events being accounted for on zswap failure.
> >
> >  Fixed the incorrect description. I misunderstood that the base pages a=
re
> >  going to be stored in zswap, but their zswap entries are freed immedia=
tely.
> >
> >  Added a comment on why it charges pages that are going to be removed
> >  from zswap.
> >
> >  mm/zswap.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6504174fbc6a..10b30ac46deb 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
> >
> >  		bytes =3D zswap_store_page(page, objcg, pool);
> >  		if (bytes < 0)
> > -			goto put_pool;
> > +			goto charge_zswap;
> >  		compressed_bytes +=3D bytes;
> >  	}
> >
> > -	if (objcg) {
> > -		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> > +	if (objcg)
> >  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> > -	}
> >
> >  	atomic_long_add(nr_pages, &zswap_stored_pages);
> >  	count_vm_events(ZSWPOUT, nr_pages);
> >
> >  	ret =3D true;
> >
> > +charge_zswap:
> > +	/*
> > +	 * Charge zswapped pages even when it failed to zswap the entire
> folio,
> > +	 * because zswap_entry_free() will uncharge them anyway.
> > +	 * Otherwise zswap charging will become inconsistent.
> > +	 */
> > +	if (objcg)
> > +		obj_cgroup_charge_zswap(objcg, compressed_bytes);
>=20
> Thanks for fixing this!
>=20
> Having to charge just to uncharge right after is annoying. Ideally we'd
> just clear entry->objcg if we fail before charging, but we don't have a
> direct reference to the entries here and another tree lookup is not
> ideal either.
>=20
> I guess we may be able to improve this handling once [1] lands, as we
> can move the charging logic into zswap_store_folio() where we'd have
> access to the entries.

Thanks Yosry. I agree, we can improve this handling in [1]. I will add this
to my list.

>=20
> For now, would the control flow be easier if we move the charge ahead of
> the zswap_store_page() loop instead? There is an existing if (objcg)
> block there as well.

I just replied with a suggestion to move the objcg charging and incrementin=
g
zswap_stored_pages to be per successful xarray store, within zswap_store_pa=
ge()
itself. Please let me know if this would be a good solution for the hotfix.

Thanks,
Kanchana

>=20
> [1]https://lore.kernel.org/linux-mm/20241221063119.29140-12-
> kanchana.p.sridhar@intel.com/
>=20
> >  put_pool:
> >  	zswap_pool_put(pool);
> >  put_objcg:
> > --
> > 2.47.1
> >
> >

