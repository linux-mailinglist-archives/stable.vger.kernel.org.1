Return-Path: <stable+bounces-232731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P55Er3gzGm0XAYAu9opvQ
	(envelope-from <stable+bounces-232731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:09:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AE63774B1
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34BCD30F384B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192720B80B;
	Wed,  1 Apr 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zcaaiwif"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EADC3CE4B2;
	Wed,  1 Apr 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034182; cv=fail; b=rGg0ikGj9Pudm6M4yTkhCcyI2W0rT0G8D/iqLC2ArruXmoUF57uB+tsyRcF3la44xsFq9cZ5ia2+ZVl8ksRnF+gqW3xq+4o/8Dv2l3GEq2jkYGa9jTWWuUMAXzs5uklPQk7hcl8ja3aJZOgE6CJk1eYriB6SvKuSr+QWo0dKe5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034182; c=relaxed/simple;
	bh=dSKom2dLB0Jv15z3cmQjNbLWze1geEpuM9y3wqkNEgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gROfY0ezfLAEKCLUzKpdY5x2hJnhT1SKufaX4C64C/a8etF+9gbLiv6h7dgm7HEe/d5JCXVugfbdCwbgJX08RAF/S4Hl+CRUGfUV4rU/EnxDJu1i+maqgJTiAGS6oOXHn3H2iPpL6J9p6yDc+q2h2jmA4sQT7ie7wOqNnGPSq4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zcaaiwif; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775034178; x=1806570178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSKom2dLB0Jv15z3cmQjNbLWze1geEpuM9y3wqkNEgg=;
  b=ZcaaiwifKzjx1k4FhUmGeX+XfQlomGwy8Y5FOK/hK4R/8Espe21bDb+R
   33gfIYtdgJiuxtr2Pj6YwP0XF/tWOYLI4XVTSYwUiSeCQSn1hV+YKBfzG
   kkHbH0fvpQW6iS5cliJeDgG/NpzpBSOZ53B561LPyjNYh8WMzI07yRCD2
   DOwuWtiJ8pvIvL0ku1qexIRK1sKzz2GFq7mp57IMBy7mPYEZZTq9UPxqI
   PAphq/a9rIF3ln4QpPSWdKgo1l1Kty9M9dET5TPFnOME8fa1m2klDk5SH
   zZ2eLytBY1EYj9+auyx6+1qf/xOH9y8ZJyecGiC1+dFqn2gSLiUIY1M9E
   Q==;
X-CSE-ConnectionGUID: lyd5YFMBQYWOdtKTTf0S+Q==
X-CSE-MsgGUID: Gzld7ZwFTzqZUqHEKut3eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75237980"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75237980"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:02:56 -0700
X-CSE-ConnectionGUID: lA/liTR+TPKkEb3Z/ngD3w==
X-CSE-MsgGUID: zfv4B/iSQCujbMm2GtBqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="264548812"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:02:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:02:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 02:02:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQZ+YV9lZbFckfaOyYzUsqCczzFzG3d31SumtM7lBfeqKV28w5AFFqumLrIriSG0vOYVHTJlX43MOExM6NY3g3At40tLbXW6wA/4OsFQe9/aO2axAN0cmoW3PY9ZgL/g3mSogowmmOkhKh1zLFwJFZ1JZB5WhCjZXFn6qG7Myj7940uXocq+zwsFh2TcTUic8UupkHdoorfJNYQ9NcCpKpVAQiWIvPiNbkCyfyNMl3PAaPCiSQHyvFB9aeSuabk9aoWLf41qIu4V9Yk00ZgUNCdgucwN9cWlHoP80AigRkI4syxOCWcbRIu30j1NjuvGNiZWAklBkFVKrS4rjG+B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vlkRb01YPTKzxybumB0nfxBLcZisv4HS81hB0P6p38=;
 b=SE60ojo1GMwx4RUXIIFKjhNV2ylZcade7sDPEGisM2fBKOtqXX31nECHi8yYehLQM/4ffdrteYs6ahcjUYJB0WYBXGk5jXhv94Nc/Ea7qRc8Q4NsqQKbTpQR1PXtYXo/AXXAHj6E9O4J4lFWckrPlBLReCJVKW2q3qFo5a5S0xhYXm8nV43KTu5JU/QvMkYenBmgzb/gjEKjGEQOjy0bYoJxMy1DspDuYTY2/x1gsAMSUEmH48mpeoznCpiYKWycKoyxzYA3I//pLN7Eg1P3skId6LrbYYHreB+0SfL8tQg/UAbPzQZtANiRq6I1ZsD3N+Sx+tTNZXfIFhs6wSwD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 09:02:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Wed, 1 Apr 2026
 09:02:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
 domain with dirty tracking
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
 domain with dirty tracking
Thread-Index: AQHcwC2TWknzYZj1oU+OjBg9H+IVFbXIQbeAgAGcnlA=
Date: Wed, 1 Apr 2026 09:02:45 +0000
Message-ID: <IA3PR11MB91369A30961F34A25A5E1EC69250A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-2-zhenzhong.duan@intel.com>
 <2c664395-72b2-4436-b60a-3ba2e73eaf95@intel.com>
In-Reply-To: <2c664395-72b2-4436-b60a-3ba2e73eaf95@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7778:EE_
x-ms-office365-filtering-correlation-id: c4969a51-60fe-4419-c919-08de8fcd70da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: CCByTp2Hyo7JfNFMUGFBOiKknL6WyYDk4LPtgEAeSwlULuc99fjJhejQLEIxcjijOaGPmZelJ7zFAXINQJMV65hFpBY5mV8ycLqhTc+D8ssk585JgmyioUykyFcwwo0L7kLGC0Pdij4zv4eVRevDVJTLZ3eOd5pDxt38PacTY4GusMS/hxP9dzqaRd/cXmz6KAgK8xqzL922keyADhm9uH9qY/4KCMgEIAAeyb10b5fBaTk9iaxPgJpIO2R4NHZ8zAqCHhJuRHYZjF0h8eDlisK34QhKtqUDM5g6aXElo6/w3FgD58GWCz5x5kKDiEskX2EDES8/XirmNc+yby3K1BKoi+x4TvAmxLSjAW5BgNpHsYZqWOr+j3SU2Kc5AwGUokvbOTToNGlZ8blp4lhwTQUwrQnzrON+//UsNhjQ1Zj8fly9B4zjzJC7SHKFeoHdclaTVwRNq/22clwjXnR+P7WayfwkwjwX2u9UBDizEztyxCpntKJDvuZgVboSjG0lHamhpHUcz/RfrM786UBf2b7O749uU6tjMbFjRFSi66I+Flyla+2XrN0WKo52sv6qooEKXmHuIhQDh+eVdDQ7TWOy9PN6E1IzBQ7WMiw8xdCC9Gk5bER2JfWs1Gl+YEbFw3cGp158xr17PMQU2E2AtUb5ZWRKboBeBgN3ihQnvZAgSEnbYGxLULEETCNiRajNS4n3D8xBAV/8ybKYH/vN1aksD2JQf9wiUxMVwOIzg7D7PUM8wfNSsWSxAYFALZYcrlq7NrqafzfgPZzrrgm7jd1NmYnGrcrawJTlgpGYvEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXMsKRToYA5uUu4Kh2c7SjxyJm2mDUhJP6wBO84X5AM1/Oea9ckwpz1YF2Gt?=
 =?us-ascii?Q?8Jv8ODP3pWkZn+ZIewrj+83gybvIEliGVE490TtebHDPPoK1H1AKKTmxSaYx?=
 =?us-ascii?Q?pOPYRAGJ+8vaHoI3ugj/IqyZivweg38dakDfZI0D5jH9yY+HNPHdaaSTWylh?=
 =?us-ascii?Q?rOhwTzis4JPxC7531UfDF113fNJN/r4PgIuEvinpX1oKeSCtsvbiG87FKLks?=
 =?us-ascii?Q?fIBKj7kpgxq9OfKooit+LxLTXiZhuyNoy3QMEmbSgZng4BYOlFANRGcWUPGv?=
 =?us-ascii?Q?8NwBTq7wZfwpNSv5++EGWbxZwnlk5dG4EQLGaOmAbcekRbCetWNp78BUPIlY?=
 =?us-ascii?Q?TIyXY68GWQLe9abPBBK+jcgBWIXzQLQ7mBplHLvH+FHkhVXyDX0YBD2VvWq9?=
 =?us-ascii?Q?/+0CYinhIDM/jgEybt9+RhpNmuO9mBOSArZEBhUz6/x/pif06vQ/ZEdM+qaa?=
 =?us-ascii?Q?7esEycZSC8fazZugbfAdtQMWisBeDKj8yokAgYh81hVAQqPO9aiGESzWcuEZ?=
 =?us-ascii?Q?1kMSxMaX4RXHfLqEVyLLb75U8giChFEul56MLeb0CYY/qZRtlxJdVb0xVMlO?=
 =?us-ascii?Q?P5UgrTW1QRl0m1b1tQLu1sq8FIpEJq2cvWnbM1DlIVqudZGshuwNnp/ofAsW?=
 =?us-ascii?Q?Z4xC3+IAKkbTlw+zzFf6OCqLP8czVg5D6XupBwfxDaMrw/IBChGhIPT9G7MW?=
 =?us-ascii?Q?FnOY7x2d40aH9RldtJXfF6d/VHoUBD/QY6GsPPimwY1EG9RGPM8cVT14OcVy?=
 =?us-ascii?Q?s8acmk2Tgtam8tNTwl09h+pvk+KL2WiORDGscILhIcWAv17oXcSrFFe6wvpq?=
 =?us-ascii?Q?mZXchOtbeLfkUxulFSPnM0oF37Fo3FJPbsEVmctWm7ABUoasyj4OJQn7hc2l?=
 =?us-ascii?Q?fOM6MNXCNzbjVkXEl7YnUn2YWcdDHyeiekOjnP8kBNMl2WzjN+rTqfAUssgG?=
 =?us-ascii?Q?JsrUBxi1ZfJ2HzIQVVTjroO7wBIlUOaZz39u/bAppKlS1ViRQl5iDAk6F2mZ?=
 =?us-ascii?Q?f3Gky8WpxtNGqCwsymc5gWCIiD60sNTLPYzJ8TOCblhKH1JaQu5+UBcoxYRs?=
 =?us-ascii?Q?KI0jwvzs0ljM+oQmaOCWv7d0N8iPg9wf0QUTZd/izkSn5qOTF6OlZwLq0u73?=
 =?us-ascii?Q?3KrTzuarYYAKLYUxtMFlcxqHr/IrfnkOPwZFF5se/sSvyP3yITUmoAMwS+op?=
 =?us-ascii?Q?uIHi1+O34rsE+DB4Zk5cTMghiIyVqOeYAP3r0xOvVvo/2xsaNuYbDrYrsiaW?=
 =?us-ascii?Q?FeIMJIu/matV4RFsWtzumg1wotO5IsoaFSHsR1sI1WGFjWmpl7deUQ7QyoR/?=
 =?us-ascii?Q?AuUxkwA4P4ziuhVD3TK90OdS9MmdAno9eYFELGZVbu+ONwmIsDXiEwxSrRnx?=
 =?us-ascii?Q?rcRbyZVRJ1Qn15zwVJCWm8sY4QCLzz8utg5Om4Gch2lymHJKfAvvM2lLHzNP?=
 =?us-ascii?Q?cOizy+Sh9FAojCyRiUOPQQGs8Ev/Xv9S0LPTEOhHTCu2IeYe5tHH2xokH7Gh?=
 =?us-ascii?Q?VkW8IhSLI1s7FdBpBxukAMaJexx4B1S25HsrDCOgm0iaOImqw7C2biXQpop7?=
 =?us-ascii?Q?rHDzC/cnmpDKDCMis0Whja8EEvjBagQ1zO7AwpPulP1jiOookcbA6UrG7QNu?=
 =?us-ascii?Q?itUewoh7YSmbEfN1w3bGjbLFgXlg6nGjvULgP4+Gjq7hFCpopMDKZdix2R4P?=
 =?us-ascii?Q?DvR4FdM1HgmXg95rLFyq5PcNLCuiIJ/AvYPu2U5ZDE3Nk21S8V4wwdEjOifp?=
 =?us-ascii?Q?aUp7Vgl9eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cMJQ1vJMyhlxC0HSl9y8steXkvNXEqy1Fvy/41z2BW1ZqPaS8A19SiOcmJIhRxFd+9GWeIbpLkliSbpGAuagEGI4vxK0aiEf0H8oNjWFDhqLYY2CopIShaanR82eok8EnNxBczUd72ykQbRNxzNI6KQBWln0Gqy3gsOYS35KNbmJqgXSgxvz7+RMSal9ykLHB5BwQkukzBsidV3lkv+VNjIRkXnJxtl5NswfVznw39FBriOA1SS/BeARm3GQYs/0Ln7PN05HudaObJ62DsN9r9AKOGDcSUOiu8JncHsEpZCS/yfsokIFi7GTq+3+vGQ/zS2PrgdmPCgBX0i4SRJ3lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4969a51-60fe-4419-c919-08de8fcd70da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:02:45.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1HnquRBnDnW6E10spCVR0nxOIrKq9Ejaxw4NdzmfqGqx2+zGt113IzoDhV4hmRN41NtXUzbLvM994S5/kKDpbqDJanxXPJzJAlBvOb+u4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232731-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenzhong.duan@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B1AE63774B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v2 1/4] iommu/vt-d: Block PASID attachment to nested
>domain with dirty tracking
>
>On 3/30/26 18:11, Zhenzhong Duan wrote:
>> Kernel lacks dirty tracking support on nested domain attached to PASID,
>> fails the attachment early if nesting parent domain is dirty tracking
>> configured, otherwise dirty pages would be lost.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domain=
s")
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   drivers/iommu/intel/nested.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>
>Good catch. Just one nit. I think the below fix tag is more accurate. SS
>dirty was merged before PASID attachment. So this fix should be
>backported since the first PASID nested domain attachment.

Oh, I see, thanks for sharing the history.

>
>Fixes: 67f6f56b5912 ("iommu/vt-d: Add set_dev_pasid callback for nested
>domain")

I'll leave it to Baolu to decide if he want a respin or will pick this dire=
ctly.

BRs,
Zhenzhong

>
>Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index 2b979bec56ce..16c82ba47d30 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -148,6 +148,7 @@ static int intel_nested_set_dev_pasid(struct
>iommu_domain *domain,
>>   {
>>   	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>>   	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
>> +	struct iommu_domain *s2_domain =3D &dmar_domain->s2_domain-
>>domain;
>>   	struct intel_iommu *iommu =3D info->iommu;
>>   	struct dev_pasid_info *dev_pasid;
>>   	int ret;
>> @@ -155,10 +156,13 @@ static int intel_nested_set_dev_pasid(struct
>iommu_domain *domain,
>>   	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>>   		return -EOPNOTSUPP;
>>
>> +	if (s2_domain->dirty_ops)
>> +		return -EINVAL;
>> +
>>   	if (context_copied(iommu, info->bus, info->devfn))
>>   		return -EBUSY;
>>
>> -	ret =3D paging_domain_compatible(&dmar_domain->s2_domain->domain,
>dev);
>> +	ret =3D paging_domain_compatible(s2_domain, dev);
>>   	if (ret)
>>   		return ret;
>>


