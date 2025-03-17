Return-Path: <stable+bounces-124597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B139A64054
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481FC3AB6B7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A4218AA3;
	Mon, 17 Mar 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rfde1r6F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9481DAC97;
	Mon, 17 Mar 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190896; cv=fail; b=a2rZsc0HCN54w3/GgALNxsfB0sFvE8TObblyvkv8aSQ97ZTBnTMgFLU94fsNBtivY3hclcn94R86Z/xFGm17jSWQNswSEZgRkG2xizOprp/pfftRRryQvxxWCGJGPALqgydWQidJ7gFgnWYiIFXwTWPvcW/SYlvCWVXw7p4umFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190896; c=relaxed/simple;
	bh=9NeEgTRP1Ja4l4KZWP9IQfDs0uDOAr+uFO3foNWuDHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qen/fmB0ojlcUd1IG3CPcBxIBn1qSZbUez6L/Y8h7UB1pEk8RSzytLnaDw3CRQbZow5GqbnDiMrffL56lgtelL61T1G5UDWIUCK3x/p953Yx5YP6JG7M17zp38Lhaomj/lYXhhkOPkjLsq7vjyTOGL6jIcGqFx1CbGI2XuFaakE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rfde1r6F; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742190895; x=1773726895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NeEgTRP1Ja4l4KZWP9IQfDs0uDOAr+uFO3foNWuDHI=;
  b=Rfde1r6FfIXevSeFhzS8LcNfxOi2Vac/bARYIMLz+N/PELEEt3OKgQI2
   SSftF0pGTY7nCA0tQHw9E1t3iZEIDnP3Qn5bqsZ4eUpRzpCkKmNnU9xat
   g57YVZ/uQpYQCD5nN0G/6MK+Y0w4wdxC4Sm16v16TXVrwdoHrGdG6Y6iC
   rvt2F1Z5p46hWa5I3EQzTM/w0eCKZVqDLJ4QoMFxoFEpCVKIMbeH+zrGu
   bdB4hiVC0YuB0DE8gXeYMnyXju8NpC5ZQN9WqxOxND75A6/wYAanvdKCs
   bBvP/bJeILhEuS/4thfJw4rUDtZkWsMUb0GAb3V/8whEDCPQ2mbSCoXZN
   A==;
X-CSE-ConnectionGUID: z4uMnwzBREig6PY8aXImBQ==
X-CSE-MsgGUID: WuZDbvJ0R46VtQcPUurQnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="54648657"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="54648657"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 22:54:54 -0700
X-CSE-ConnectionGUID: Ho9jM6/yQCuf7EEoHWW5HQ==
X-CSE-MsgGUID: 7R+HhAPZR5iB7yTyotPJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122793888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 22:54:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Sun, 16 Mar 2025 22:54:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 16 Mar 2025 22:54:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Mar 2025 22:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWkZLo4TVGquEGSiW6u3W+FCocGsoeUSgNUPRYodDaZrnmhLtY+PD1x2lnwvwvW/zi7UwkRfN2jcRay2aMSkt/YcriA2qrU3I1LrcOVnmvjSReWmcNaayeGx4QFC8HVpTnuqFS9e6GHDpOXxQQQpfO+5fuMCqeaT08OOvEgLPDj+Igtvgq5tLuGiDYzQzzLNqa2T4RQB8DlbAMb/+kKFXvQq6iGFo4VPBxSYNy9wZbn0e9A0ZTryU9ZvQHw1T92paTQLgUAV2JcTSGwpjSFzqdT/S0wFgtpWYf93waiJmwxrz5JhCrxbQhadEcF3IprokCwmB9GEcLgYhdNMv6kGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NR9xhIBCEqzD5dpF72vwM/sUzLDwQNishiPUfKRsdk=;
 b=szb2eG1fEFahAozeE/+5Q8/cUrE5oDxEmmFPuETJks868NNcwSDc8Ms6YI2ukBlsIEVCW6+FPrNN0Z1+wBsDFajeVgdnST/Io637r+LtBrorJRAymrgKbo2kTuPk3Fdm4YyEkrTvYt1viPLZ/EfjmjIAwLQ+l1v8xYOAnj6JJSCwOUUWEJTbqqnyCzkaZFOhrAYr6fBtmjFLygEj0cw3AKqzcErqsLy2huAludSVC+DbuQXcq5d4yEFfxUrtcfLj4eiTdQaFTXXBx5An6FCSe6/N5WXZvk8oR1BB+S3kKUpDUYflg6iWs3te4uTpK6rHdOmNRM5VUYEcBklC1HcCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 05:54:49 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 05:54:49 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix possible circular locking dependency
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix possible circular locking dependency
Thread-Index: AQHblvCjOwTxqJ6IjkKuEmeifjevhbN21Agg
Date: Mon, 17 Mar 2025 05:54:49 +0000
Message-ID: <SJ1PR11MB612990255BD8D39C5F856C30B9DF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <20250317035714.1041549-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250317035714.1041549-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH7PR11MB6746:EE_
x-ms-office365-filtering-correlation-id: 81dc51a1-3654-450c-5c0f-08dd65183ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jk4FOYDa4SsLiJu/innogb6PPAmqmH18ffaXnMqzam08NQIsVAGR8LTjP2ug?=
 =?us-ascii?Q?RMAsX6m0y3DiufLxZvJ+TDi9FOduXcAP/2kewFSHpaQikCZrihsRoJ4H3Wy4?=
 =?us-ascii?Q?EfhyagQeFKgFV3VHUNuBNAybDWhb1Yu5lhxKVqLJPPo47KObf+JUGhkrFdZ5?=
 =?us-ascii?Q?E5zhZylun9lxf5MzOWrU+MYtcX9uHQwSh6wZj/M3VatHVSjtFAySkcN2FEn/?=
 =?us-ascii?Q?+eDD4GuPtht4lsKU68iW1F/OD2wwIIGLRH3ukOesMjEZl9B+cXJl1YZinBEM?=
 =?us-ascii?Q?BY3XqlyT8ZdUgbaqcN5slj3QU4EmeDaLj2i+81dpRWrLMa4fQV9akbOddrRP?=
 =?us-ascii?Q?SU1eKZvH2qdepaSswWaNFVRiuPORYNSwfk9jtqzCUUbDhjUnmjnjoRihUx1M?=
 =?us-ascii?Q?xj6uH6szTecU82FWxhXEGNVC2B3Ps5YESReuOnKeb2cjv9AxpXlDovbKqe1v?=
 =?us-ascii?Q?5XUpmLOcK4vuB8M/Pm+Xxksmga9cUngvskMPXypVyCPfxwQezeNHYgYjHBaI?=
 =?us-ascii?Q?ztdq6xoN7MZSBiSgjZz06oJW9j6/JNGdo46eTk8td1xjR5mJHuRcgBJqdtbH?=
 =?us-ascii?Q?aDpW6DPG5gnC7WOauWOAOGBQrLTVUWWtkh8NuLN1bWwAwkZHfuY7Lbs0/D/1?=
 =?us-ascii?Q?tC7CaCEGjOSFar3ehwbqNLYZIevNpaaOJHeLOAXxTgAaelT2BMW6g7fyrPP+?=
 =?us-ascii?Q?niZLHKijREl5V6Ob5i0PEuDIVMsuzO8qqTD2RSMZHjF3LeEae1IV0zqcufAD?=
 =?us-ascii?Q?FMybWLB8mrpQow+9fib0GYHMWTiKVp/80NZDdRqwzORI+0az023lXFIEdy5s?=
 =?us-ascii?Q?D/gJgiOjZ+0dkHTNc0H1xKrhPHtWrJA6ywXQvLQPPvSF6Kz6k8gHQYPhaKZ6?=
 =?us-ascii?Q?eODgbV0omkWB3lYr5kIQp3BJ4kXKDAbmBMZOvfWbr6dU9uZPZbJxwJcVz25L?=
 =?us-ascii?Q?wJjhmKdq3iaDrpj2DfqwwCAsiueRxtSDXWL9T5ty9IplQJMpP4TlVwnLS1WI?=
 =?us-ascii?Q?u17bshSnk6zLqR/vrqmIyc35C91R+F6nnjO/zGnEJNExfNgNQxhRV06bZU55?=
 =?us-ascii?Q?SXYhGPWx4xdjR1vcf7LMXn57RQ623ZRDK+ON8eYz/CYxc9ynNyC+UHsgh+KY?=
 =?us-ascii?Q?GB1d0zjJdVcb607bS4OkH1ymA0+9kZ1dT+FpuVDhxXLPhiRDgpmlwnfjo8oA?=
 =?us-ascii?Q?Y3R1Ym/RKRylJsjQ7llfT2t4SmvpV540S+MhQPau/uVE+LURv/h1j55AyYlB?=
 =?us-ascii?Q?1rEGk/Yq0/oTTD87i4NPs6oDf/XFcycAmnLygpZ/bZt4Tv0SpltMqcAcDdh8?=
 =?us-ascii?Q?g/2CioiNKbRr8IiGi0jsYfC9Qg48WhysEop6PgnbLYXxV2k+tywAq5sT3J1i?=
 =?us-ascii?Q?GsawfJKmfWTntHA3p54ala4lz3lJ0RRmi60/VPxueD84va0dXkl7eE4dp/yI?=
 =?us-ascii?Q?TJiquyxZVAX02TMdcjhs4t7vJg30suMm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KhRg9Lpy5PRHzAi0Pi00Kl+olhyxYUNDw/qBiRrQijNlyehGxrJoXl3ic+Fd?=
 =?us-ascii?Q?HFlnQv1FiB8I3m3FSjWqOfU6WgU7Pytn+RQKLGhBGYpmMkNwF+sK1xtWHiw3?=
 =?us-ascii?Q?qMUJexnKlmvnYOFZvaoNF9BhU8ccox/1/IQ9XCbvyJ14bdrNdiY8UZGs5sCS?=
 =?us-ascii?Q?6jhTmnzq+JtuJ+1B9nfFtKFdriI3DZwLj/FWUL4qNN8aOgXDA9WI8PEIXaNI?=
 =?us-ascii?Q?2kzCi8d8EVeBwoSnhb2+pgPT9KAgAyg/w3SYLK9ZEKDG1NaW4T2LFv6LVJD9?=
 =?us-ascii?Q?sieckq3ws+3W59FbyXjvvvx6aHEjBKemXOGn+WkPwytua3m7gLznwUNcT8/w?=
 =?us-ascii?Q?8wNwz4OERIzmmQJNuVfJCv1QMcXjWVfNe6inuUFAsUKR0n/y4kCdHs44TY5V?=
 =?us-ascii?Q?fv2a0gmjsCsSR0zbe5S+5byqQwC7DBQeUvEJLBuXAZi2gBzvwySNMqN1m2Iq?=
 =?us-ascii?Q?piO3cfS6U6qQPfFHGxkQl5T/BMJDJlWTaEjboR90gsFxu4hlfjmjzThuCQn6?=
 =?us-ascii?Q?ft9z5HDz6C1BRJkw3bvhepnpZWvqFeiMqkqUvxjiRvK2Tusgz8ojSypXFTRq?=
 =?us-ascii?Q?BmLqUDdBEnAmmN2aDExDmuFk8HGpeA+UHxu3fksC4sBc8kzS9ymcoCGY4SiD?=
 =?us-ascii?Q?z38pQoTfBdNfd8hgnOJ8oIzbYipq/o8T++7aI0DIeCBduv5r/WpVNwSONCIr?=
 =?us-ascii?Q?ggQ90AljZPDewhdutziZ4vyFZpze98IYLeJFG6RQR8qMeGi/qv3TXeumd0uP?=
 =?us-ascii?Q?0zUelH06WLMi203R+nz6otvB4PH1Is+UpshB7Mt7RQKpWyWVM47Rf8kZmyC3?=
 =?us-ascii?Q?MJABWTyuuieUs6PG0jaJStMrA46w7IbPv4FJH+JCut7LLocgfEm0GxrOsGeN?=
 =?us-ascii?Q?s0PCMIeOdBmcgykfgZkct3S/i+2OWYsPZ8Lydstkw8Bl4fTipiSQ2DFS+W3Y?=
 =?us-ascii?Q?Gh7v1G8IiQO1uHT55FKke20kU3slCNNtyhPZyofVtaulRUMt+ASg/HsQ5MhQ?=
 =?us-ascii?Q?9wGwHGawKChedQJubL9/E7B8PB+N+qZ1D4G0nQYfYKTwUCMUojl/q/tSulbS?=
 =?us-ascii?Q?07Y9Q7FIupvgpFDuksgMHEHPjmG+kXtWU6T8O9JXIEerlIF91LWxa9zU0x/e?=
 =?us-ascii?Q?Foz9Z9BO0mgp+7eL8nn7zWDNnYD2NnBQEKs6xfzjt+QF3ALWifEubQJz/vr/?=
 =?us-ascii?Q?rRjgMv2TNJmFPSw+udtVtBCvIboC7eqZgT87+j/iPykpDE79jz1/crwWeKYG?=
 =?us-ascii?Q?ApdKU6HsA53Xn3QIgf6Oilbz/gygjZZgl4rpFA2VsOsydSgd1fQS/bDHvOpq?=
 =?us-ascii?Q?HzHdfdpRGnCyS0at1sxzLOTpwQeYhUmpmbEyxm2mupZ6wyD/cppbI4BWJ5W7?=
 =?us-ascii?Q?A69sauHXMOTwdLwuKuau3KzNbBrpL9kcu9Sz8gB09NO8O6XfkYU0ogJfYP9s?=
 =?us-ascii?Q?f1mog4vm4ww8fLYKG6XX8knVhipTeUYNmvnAO6Zi8RvnYD+AAVicARHmZSZA?=
 =?us-ascii?Q?fX/4Ir8oKZho5smEpwYG8OVcsRK9ET1HFj9T5FwmW9tFCG0DYul7k73xudIe?=
 =?us-ascii?Q?JmIavR+5jY2rrDnJbhrnsyU7H19/v7SYYQPLYqANg2dcDNkIV/j0kKy8G+ys?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc51a1-3654-450c-5c0f-08dd65183ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 05:54:49.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvaFyGB8+J0lepA0N/BMtvCkq9ZGZ9RhWtPvjNO4kfHo31KgkQH/mCa8Q/SZwn2JW+CFuyd/fvuZK1qQ/EF8REfyOSJopAyLMTyEnaHOEJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 17, 2025 9:27 AM
> To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Tian, Kevin <kevin.tian@intel.com>;
> Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Lu Baolu
> <baolu.lu@linux.intel.com>; stable@vger.kernel.org
> Subject: [PATCH 1/1] iommu/vt-d: Fix possible circular locking dependency
>=20
> We have recently seen report of lockdep circular lock dependency warnings
> on platforms like skykale and kabylake:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected  6.14.0-rc6-
> CI_DRM_16276-gca2c04fe76e8+ #1 Not tainted
>  ------------------------------------------------------
>  swapper/0/1 is trying to acquire lock:
>  ffffffff8360ee48 (iommu_probe_device_lock){+.+.}-{3:3},
>    at: iommu_probe_device+0x1d/0x70
>=20
>  but task is already holding lock:
>  ffff888102c7efa8 (&device->physical_node_lock){+.+.}-{3:3},
>    at: intel_iommu_init+0xe75/0x11f0
>=20
>  which lock already depends on the new lock.
>=20
>  the existing dependency chain (in reverse order) is:
>=20
>  -> #6 (&device->physical_node_lock){+.+.}-{3:3}:
>         __mutex_lock+0xb4/0xe40
>         mutex_lock_nested+0x1b/0x30
>         intel_iommu_init+0xe75/0x11f0
>         pci_iommu_init+0x13/0x70
>         do_one_initcall+0x62/0x3f0
>         kernel_init_freeable+0x3da/0x6a0
>         kernel_init+0x1b/0x200
>         ret_from_fork+0x44/0x70
>         ret_from_fork_asm+0x1a/0x30
>=20
>  -> #5 (dmar_global_lock){++++}-{3:3}:
>         down_read+0x43/0x1d0
>         enable_drhd_fault_handling+0x21/0x110
>         cpuhp_invoke_callback+0x4c6/0x870
>         cpuhp_issue_call+0xbf/0x1f0
>         __cpuhp_setup_state_cpuslocked+0x111/0x320
>         __cpuhp_setup_state+0xb0/0x220
>         irq_remap_enable_fault_handling+0x3f/0xa0
>         apic_intr_mode_init+0x5c/0x110
>         x86_late_time_init+0x24/0x40
>         start_kernel+0x895/0xbd0
>         x86_64_start_reservations+0x18/0x30
>         x86_64_start_kernel+0xbf/0x110
>         common_startup_64+0x13e/0x141
>=20
>  -> #4 (cpuhp_state_mutex){+.+.}-{3:3}:
>         __mutex_lock+0xb4/0xe40
>         mutex_lock_nested+0x1b/0x30
>         __cpuhp_setup_state_cpuslocked+0x67/0x320
>         __cpuhp_setup_state+0xb0/0x220
>         page_alloc_init_cpuhp+0x2d/0x60
>         mm_core_init+0x18/0x2c0
>         start_kernel+0x576/0xbd0
>         x86_64_start_reservations+0x18/0x30
>         x86_64_start_kernel+0xbf/0x110
>         common_startup_64+0x13e/0x141
>=20
>  -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>         __cpuhp_state_add_instance+0x4f/0x220
>         iova_domain_init_rcaches+0x214/0x280
>         iommu_setup_dma_ops+0x1a4/0x710
>         iommu_device_register+0x17d/0x260
>         intel_iommu_init+0xda4/0x11f0
>         pci_iommu_init+0x13/0x70
>         do_one_initcall+0x62/0x3f0
>         kernel_init_freeable+0x3da/0x6a0
>         kernel_init+0x1b/0x200
>         ret_from_fork+0x44/0x70
>         ret_from_fork_asm+0x1a/0x30
>=20
>  -> #2 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
>         __mutex_lock+0xb4/0xe40
>         mutex_lock_nested+0x1b/0x30
>         iommu_setup_dma_ops+0x16b/0x710
>         iommu_device_register+0x17d/0x260
>         intel_iommu_init+0xda4/0x11f0
>         pci_iommu_init+0x13/0x70
>         do_one_initcall+0x62/0x3f0
>         kernel_init_freeable+0x3da/0x6a0
>         kernel_init+0x1b/0x200
>         ret_from_fork+0x44/0x70
>         ret_from_fork_asm+0x1a/0x30
>=20
>  -> #1 (&group->mutex){+.+.}-{3:3}:
>         __mutex_lock+0xb4/0xe40
>         mutex_lock_nested+0x1b/0x30
>         __iommu_probe_device+0x24c/0x4e0
>         probe_iommu_group+0x2b/0x50
>         bus_for_each_dev+0x7d/0xe0
>         iommu_device_register+0xe1/0x260
>         intel_iommu_init+0xda4/0x11f0
>         pci_iommu_init+0x13/0x70
>         do_one_initcall+0x62/0x3f0
>         kernel_init_freeable+0x3da/0x6a0
>         kernel_init+0x1b/0x200
>         ret_from_fork+0x44/0x70
>         ret_from_fork_asm+0x1a/0x30
>=20
>  -> #0 (iommu_probe_device_lock){+.+.}-{3:3}:
>         __lock_acquire+0x1637/0x2810
>         lock_acquire+0xc9/0x300
>         __mutex_lock+0xb4/0xe40
>         mutex_lock_nested+0x1b/0x30
>         iommu_probe_device+0x1d/0x70
>         intel_iommu_init+0xe90/0x11f0
>         pci_iommu_init+0x13/0x70
>         do_one_initcall+0x62/0x3f0
>         kernel_init_freeable+0x3da/0x6a0
>         kernel_init+0x1b/0x200
>         ret_from_fork+0x44/0x70
>         ret_from_fork_asm+0x1a/0x30
>=20
>  other info that might help us debug this:
>=20
>  Chain exists of:
>    iommu_probe_device_lock --> dmar_global_lock -->
>      &device->physical_node_lock
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock(&device->physical_node_lock);
>                                 lock(dmar_global_lock);
>                                 lock(&device->physical_node_lock);
>    lock(iommu_probe_device_lock);
>=20
>   *** DEADLOCK ***
>=20
> This driver uses a global lock to protect the list of enumerated DMA
> remapping units. It is necessary due to the driver's support for dynamic
> addition and removal of remapping units at runtime.
>=20
> Two distinct code paths require iteration over this remapping unit list:
>=20
> - Device registration and probing: the driver iterates the list to
>   register each remapping unit with the upper layer IOMMU framework
>   and subsequently probe the devices managed by that unit.
> - Global configuration: Upper layer components may also iterate the list
>   to apply configuration changes.
>=20
> The lock acquisition order between these two code paths was reversed. Thi=
s
> caused lockdep warnings, indicating a risk of deadlock. Fix this warning =
by
> releasing the global lock before invoking upper layer interfaces for devi=
ce
> registration.
>=20


Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>


> Fixes: b150654f74bf ("iommu/vt-d: Fix suspicious RCU usage")
> Closes: https://lore.kernel.org/linux-
> iommu/SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.na
> mprd11.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 85aa66ef4d61..ec2f385ae25b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3049,6 +3049,7 @@ static int __init
> probe_acpi_namespace_devices(void)
>  			if (dev->bus !=3D &acpi_bus_type)
>  				continue;
>=20
> +			up_read(&dmar_global_lock);
>  			adev =3D to_acpi_device(dev);
>  			mutex_lock(&adev->physical_node_lock);
>  			list_for_each_entry(pn,
> @@ -3058,6 +3059,7 @@ static int __init
> probe_acpi_namespace_devices(void)
>  					break;
>  			}
>  			mutex_unlock(&adev->physical_node_lock);
> +			down_read(&dmar_global_lock);
>=20
>  			if (ret)
>  				return ret;
> --
> 2.43.0


