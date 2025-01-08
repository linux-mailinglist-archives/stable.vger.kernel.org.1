Return-Path: <stable+bounces-107932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462DFA04E8E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B013A086B
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AF20B20;
	Wed,  8 Jan 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGAsDZdv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9879FE;
	Wed,  8 Jan 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736298646; cv=fail; b=W+kKu/cyYFlAGsQdv/GIXWJpxh1v8AeP+M7qYrpn9zIXgKn1CeuS7YdttWRise3xgtIvnBD4aAbTpAuTbOhAruJrReKTEk8mw0Oa67Kl6hXpy1Rr7/4t6IeXZoT8e08gUYqRFGX17KBD8Tr1GK5CsFwBzX3mGv4Bw9NxUJErFzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736298646; c=relaxed/simple;
	bh=Hgn2wqHzNushB3rVKg4njI5TOrGJ1A8MbDzL3w9TAm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYefPFm+w0NePCsCiE6EZQGr4e3JxU4Lxpw7EGFEnBZzTNYD38O6UCcBdooaLCnNprEYB3XcTD8BzBk7zRHCrxVC/1Aj5DvO8IQtjY8ptFi0jlr2Wje4p7U8+d/IN9xFRZRIaX9oQYJXa8IAinCpe+dmt2ny+5kZOsAJ5rRy/m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGAsDZdv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736298645; x=1767834645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hgn2wqHzNushB3rVKg4njI5TOrGJ1A8MbDzL3w9TAm4=;
  b=TGAsDZdv9na/fOLxK91t0EdrnY8lXzPFcLEjSQ9td98ZxdwDJSoyLfAA
   rjeNC+/2rqHATsrHo+PbbuG9724kMDwSgajJDCcpwWRexQKuW5cP+oRzf
   YJSl3RM7klq1dExn/3i+xYDKzJPcI9CP8c6mcvePqN8B+mVLFRatGj9q4
   jcSfDEQEVAvoiLG50Cj8C/1eM8UH8wi3ic0KTtLNIQNM9bT9ziKPpP4S0
   /2jEB3ptl8bg+VVV4jeb0JIai4H2FO5fuM0ksFVKtpAmtP/y8bWXHu5/O
   JM03W+wPaR7Li+2RKozacfCnRatta24ToCBTmSqsyE2r4ugCgnEz9LHcT
   A==;
X-CSE-ConnectionGUID: dnjqkiW/SbuRyw4Y+WqHIg==
X-CSE-MsgGUID: NN+SRuvaQ56i2IeTvSYT9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36388938"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="36388938"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 17:10:44 -0800
X-CSE-ConnectionGUID: G2jemD4xTZix1qKFWvUUiQ==
X-CSE-MsgGUID: j0wHnK5ST72eAtY1utXQPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="107804004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 17:10:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 17:10:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 17:10:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 17:10:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW2HWfnFCxkLlW+oQrw1M9cGMM5/qt4IqoUlsnuwD64AdU+AvSP3mVz7NM9qQ9QvGrrwO6DtLacj7va/b2IC7wLJEtVtvtHI9HVanUoSDIZCJa8/YhyaSSb0hE1zRozkNdN+vKhnO7a9/2ED+VttonwkXh0mKwr4zYpCWjj6pptt5JCSJ53s0GW54Ioi1g/oja5+cX9Z/IFx+QHh6H9btbsdvYTgglrIp5LHqVvAAzJvoGqLnTIzimU2W/q9mDFrJusoov6WtCt6Gssui4xONgg07/U87dQRnOxlx3AgQQ5iX46217B0Y4om594wyM2d5FNoJe2YojqQwE487ghuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgn2wqHzNushB3rVKg4njI5TOrGJ1A8MbDzL3w9TAm4=;
 b=o+e8QuPgoX5hnD7FHRiwlxbQVsWSKoPsG+WlIK4aEr0YfPL3EQe9cdl3NTLkrSBDcPqoNt+AzrryFJBmVTw6kNEovVyW9PjY155qcMaJGYr9Am4krPXLG2wknitla8hAmUUGUG7e2Dj084gn2dxzwInutriMNZCGTGKPvTi/zOWKbZeIiBjwaWIldDGg8wes3VTmE9Lb90SC4wT3M7wHavDHDAy7pRrbN1QzOM3AgHgFjWCcTKsaE7fKHLc3qF4A2ACVI2uOxH9+YMZ4VT88mB9mWzPOkuM5eUSDy1dV1ZLoJ87HihU2tHeInqNn+As1GRmr8m//F7y53mXvvTVzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Wed, 8 Jan
 2025 01:10:34 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 01:10:34 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Chengming Zhou
	<chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, Barry Song
	<baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
Thread-Topic: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
Thread-Index: AQHbYVK3SB8LCS0pNE600ZzlkbZ21LML97zggAAJiICAAAmnkA==
Date: Wed, 8 Jan 2025 01:10:34 +0000
Message-ID: <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com>
 <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
In-Reply-To: <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY8PR11MB7134:EE_
x-ms-office365-filtering-correlation-id: 3fb58ccb-618d-4293-b4cf-08dd2f814129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXplQnp1MisycE02a1RzTlQ4bThEL1FCSTR1dk5yc0JHNnNHc2tIM0RQOUkw?=
 =?utf-8?B?ZUJnZEExaWlZSUtkR3JsUXFFM2NUWWFidWx6UkpTTHYxaUJ3VjhzWmlKM0Y4?=
 =?utf-8?B?bWh5MS9BTm94TU42MEtQWEdJRG1QbFhVSVJWN0ttaVU4OUZBVmVBQXg5cEdZ?=
 =?utf-8?B?Y0xrY1d6TGRXYXpzZlJyazQrWVJaNGw2MXMwNDFTaHF5bDhoL09NZ200M0J3?=
 =?utf-8?B?ZFZCcnFud202VjlKM3M0RDk1Q25nK1ZlL01QK3hDamxxM1ZnRnpBclpiZytX?=
 =?utf-8?B?R3BLSnV2OXBzWTd4RGN5UU55WlJIVUl2STZpMmVBQ1BQeXFWbTFNRmt0d3ow?=
 =?utf-8?B?Y29GYkxvZW96MmVOaVhkWndVRG9DbG10ZHE5ZUh4YjNRd2tMeFBXSWR0Q3dO?=
 =?utf-8?B?cjQvSUp1MGZjNFpaN2VKWFVrbDZLRVV3ZE0veFlCeTJzcVd4SkVOcXdGR3NS?=
 =?utf-8?B?RUV4eDdLZFR3N01Tc1VKT25CZXA3RXAvWmVKMWNUbFZOMnFrR0FvNXJNWnJ0?=
 =?utf-8?B?LzM1dlp3aFl2ZEw1VVZqQlA2UWx3RURkNlZXZ2haUnpoZ3RKSzFmNTNDOVBQ?=
 =?utf-8?B?Q1daKzhzSjhrQ2c0YWFMWTliaVdXWE1Tb1RkMHU1WElpZ3VNNDFZNEIyUHdC?=
 =?utf-8?B?eXZxS1lscTVlaExHWHNNYVdOUmY4akxpSXp1bGVsZkQ2Q0NJeFc1aXBPd2hO?=
 =?utf-8?B?ZXYxYmZOdFc2UFhiTXRwamhsTUhzVW9oTFlUbDQyWmN6blNUeDBKYlE2RjB2?=
 =?utf-8?B?WEhCYjh0aW0xNmtZeUhvR2lDM2xPUzk4K3NBbHZIRmFjdEVoTXpKT2ducWV4?=
 =?utf-8?B?aWZpamFFS1pYSFZvcTl1S2hJWHAyNk9hU3B4RDhLVUFkT0M1SFRTRTVMeTJT?=
 =?utf-8?B?TUhvL1BPQlF5NTF1Y05Ha3hhSVlmM3Awdi9QL2paemhmUU5oYys1a1lVQmc4?=
 =?utf-8?B?ZkpGQUJNbkZqTWt5eVVkNmw3L1N0Y0VyRmxZd2QrSEtqZm5NUVBHQ1lyN3hW?=
 =?utf-8?B?WXpQQ2ZkTGhtVS9uNkxkNSsvZlBPcEtBOU9acmxyWUxsdElqS1loK2tDQU5V?=
 =?utf-8?B?SHpqc1htWDNCV3RBcWpsRVphWHJwc1puYWcwR2paRWVDa1MyMTFQTEUwdkJ1?=
 =?utf-8?B?ZElhV3F6YVdsZ2o3c0YydUtZd0lDdnc5aUF2ditXdVNiaWpWWTJxMHB6MVJq?=
 =?utf-8?B?VlhGZHZjSkU0TVRKRStvTmpuTmpZdnBxREFQOGJmTzRPTExlcDZONi9yaGo5?=
 =?utf-8?B?c0MzRGpGWmJ6VE1PV0dlUElub1haMERjZEVlQ0ZjSHVlN1ZZcDdvcDYwc3ky?=
 =?utf-8?B?SDE2bzVudUhKT0xKNjJuYjlsa2FuMWVvQ25Zc0IrOG9ETW1PVDFTRlBhRU9W?=
 =?utf-8?B?Rnh1QjJOeVkzWmUxekxWby9XZ0xjaUt2aFppTE5xMit1NXFYblk4OVpVYnBI?=
 =?utf-8?B?QXcwd0V0NWJCc3VPN2JyUHU2MVRmdi9TZk5KT2R1eTQxRGZZenhjZzVGM3FW?=
 =?utf-8?B?bWxqVWxmWXpIUG4wbXNiYnlIVytvTkRSWGhpZ1R0V0I2MVp3SEF3RVNjYk5K?=
 =?utf-8?B?alN0bDNqOC9TUGwwVmEzZjFSYXhNRTlQUUV6SFlTSGNGSTV0K0xxSjc1anVv?=
 =?utf-8?B?WGVsTE81WUhVaWgySWlQbGpYNTNLOWcvUG0xZzlJVlNGRWl0SHc4OXd3eFVM?=
 =?utf-8?B?cEpPcVFlbjhlUy9nd2NOUCtJNk5CVG9ja2duUk1EMzJueHFmaHgrQTQ0WUp4?=
 =?utf-8?B?aFlWQzN2SXZqeDVmU3FabnBMSXRZSktIOFRJZC91V0UzcTI2K0V0c2lEWXFl?=
 =?utf-8?B?VUhKR2RlaDNRdjhPclo3VlFjVy9rMnIrNldobmFsTndBdkwreWNSTDhMN1RI?=
 =?utf-8?B?eHkwdHBzaVM5a1BUd29LZHVOYW8zRm43UUtUS3JUS0NNNG5nejM5RDlpSlBq?=
 =?utf-8?B?KyszT2NuOGd6di9ScDJPYlo0YTRCaEZJTStEUEorNEdEWERJTTRqQ3NkeEc4?=
 =?utf-8?B?YXkrTVRXbWxnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L00vc2pGQTNnKzk3Qzg2S2VJSUhJeTR6QVVvVE5hVWRCRVJDY0J1eWxJTkYv?=
 =?utf-8?B?R1FBZUtYQ1BOcWxEZjNhWEtCclFqRTB3N3B2aEJoTzlucU5iMzZQcmhzbTZh?=
 =?utf-8?B?aVY2TGUwdU0xWk9HMW15a0p2ZTBidzdtZkc1aytjWXk3WmFDM2NxOVJkclZI?=
 =?utf-8?B?ZzNWaHZjY0J3TW5jQStsai8yemlJWTN4UldKem5RTmQ0NnZSTWhudEJmYXpU?=
 =?utf-8?B?bFR5K3hZRmpDYmhiRlNhVlg1VVp5VjR6ZHEvOG5uNGhSSzNWenhZTzQxMkdw?=
 =?utf-8?B?Mm9NUmJXbFRDYk90TE82MmN0Z0Y0eHhUWU1vQ1hSVTRQQmpjdENqTUw0RDln?=
 =?utf-8?B?cUNVZU1TWmNyRmdILzZUSU1Fd3lxd3o3NjdiWEIyYmtPZ2lBb3RFdHZhT2xR?=
 =?utf-8?B?dTM3ckg3clRQN1BPeXZmWjJrejFyODlCOFNiOHJEK1FVZXFaUEVwTFMvbUky?=
 =?utf-8?B?SkllOS9kNmZydHR6L20vUkx1bnNOck5ab29uV28wa3AxeDh0QUlIL2hDU0hG?=
 =?utf-8?B?ZHJCWTQ2WHNZdExZenZtR3FBa0dYUFpNdW1udnZaRkFkOGltNXowaDkzcmtS?=
 =?utf-8?B?RDNqR0V5MHlnQzZUOW5vNURYUGVJK1pSUDdpcjlSeHpYTlVyZVNwZkxDaHNh?=
 =?utf-8?B?MFJsNEhXRkJ3WHRobTJidzFDV0JWUFV3UUNhUk11MURxQ1RCM0NuRWxSS0dK?=
 =?utf-8?B?YzByUGlmRURidTZkZ0ZsemxqTTZEV2dLUUdzYU9VcjdrejRRd1BwdlNoWGFZ?=
 =?utf-8?B?SjNMTmd0OW1pMTdUSFh1SHpuQzFaWWpFYnYvdjd4TnI0dDlrVW51Y3hZTzY1?=
 =?utf-8?B?SHVCMjBkSis0TnVSQlNFZVpHUXRENXhqUGJVYXZCYnh1aXVJcHoxcTFsYzQr?=
 =?utf-8?B?UEdZSHoxN0ljUHNiK21keDAzdFBKdlJnY0FhcUNPcUIwNHExQk1Ubm0ybkxV?=
 =?utf-8?B?YU01ak43SUVhTUg5ZTNyZFJkZnBmNXNKWG5WeGM0MkdkM3FCWGxYcDlhSDJM?=
 =?utf-8?B?Z2JQeDc0MUpJWEhPMzEzYlhTWDlPTGNPTUF3ZVd3eXRob1BUdXZaU2NNNmM3?=
 =?utf-8?B?MjFJRVErR0VISk9VSWhTeGlrTXRKbWl5Tlo2NE56RG51c3lSdjdWaXpBaDhR?=
 =?utf-8?B?Nk12dTg2T1g5elZJdUVDVGt2eksyK3RsYUF3OGg4OFUwMzdQWHp6aWp6bzd3?=
 =?utf-8?B?UC84YlJ6L2xIaHNVL2tzZW4xb3Y4bSt2M3RqVHFDRk9UVjZxd3BnMzgwNDht?=
 =?utf-8?B?cnNXc2Zra3lvelpLc3lFdVpVbGZodW5WbWhhQUw4NWd2WkNyd29mV0hmd3Q0?=
 =?utf-8?B?Z0dYTlVlNnU3L21hL1g2czcyaWEzZ0taZHAvK3J6bjEyM1FZQkxRNWx1Uy84?=
 =?utf-8?B?WWNONi9HbGVLbC9na1J1cTAwU0plQWp3Zk8rZTlJZmdSVTZ1UkpvcTFsMXkx?=
 =?utf-8?B?TEU1aXpUWExXSGtGZkJucXd6cEpFdHF6eVNnZC9adVRCQjlTK0tlK0RIYWl6?=
 =?utf-8?B?REZsdnNjTHJTM0E3SUhZN3cxa29qOCtSWjN2QTF1R2t4ZElmeDZoajdMQjFU?=
 =?utf-8?B?Yll0SG1PbENkVXdvd1VnV2o2NmR5aHNMRVZqNjNhZ0F4NGQ4SDNkMTVWTnNI?=
 =?utf-8?B?TzhqQ3dlM3pLZEMvc1BLMDBQVWh2Vko5a0hOWENaMXFidHI5WnJGNUpKM0cw?=
 =?utf-8?B?QzFuQnZwZk9PU01mZ0tWMjRZbkUyYSt3aEx5ckpRSHBNbjNnMC9DdFJZK3lC?=
 =?utf-8?B?bDJFZSs1dk5XaXlyMnlLQjR5L29Vc1FQaTkwT3RLYm5WbkNHOWZYTHA2TEpp?=
 =?utf-8?B?NHgwZTJ0S0hzMUw3bnRTK3lqK1BrQUJxNE1GeDRNcEcxMjhJS3BjbDRlc2Jo?=
 =?utf-8?B?enIrblo3QjdEaHorTkNKa1ZvR09IR2tFMjlQR2swN2xrektudk5TcU5xbXcy?=
 =?utf-8?B?U3BoR2FSV2w4ejc0dkNDdGRueExILzh4anJYTWFVK2dSc3Uwd2xpWmlmb0JX?=
 =?utf-8?B?NGwyOFRlVjdiMnVNOFhwSG1RQkUxMGVSdGhDSkp2WUcxQzRLMnJVZjVDQzF2?=
 =?utf-8?B?MTBnR1hOVDNvamcvTU1kakM4dEc1Z3RIbGVFSVF5NXplSldSVGxFc2xqYjkx?=
 =?utf-8?B?a0cvYXMyWEZXenE3QjJTa0tLRGlkeWZpQmFQMkJjZk1TM0k4N2tnRjlZcTFl?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb58ccb-618d-4293-b4cf-08dd2f814129
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 01:10:34.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCaBQO0nYEgsAb+4zFj04svsUUW9aDnEN1i2yoZGSS+QpxUHauLba7KgtPfpK+3wSWfxm0xOPBAHnAYV2ubjBU4gUpl56jkLKixR4MG680o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7134
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNywgMjAyNSA0OjEy
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IEpv
aGFubmVzIFdlaW5lcg0KPiA8aGFubmVzQGNtcHhjaGcub3JnPjsgTmhhdCBQaGFtIDxucGhhbWNz
QGdtYWlsLmNvbT47IENoZW5nbWluZw0KPiBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+
OyBWaXRhbHkgV29vbCA8dml0YWx5d29vbEBnbWFpbC5jb20+Ow0KPiBCYXJyeSBTb25nIDxiYW9o
dWFAa2VybmVsLm9yZz47IFNhbSBTdW4gPHNhbXN1bjEwMDYyMTlAZ21haWwuY29tPjsNCj4gbGlu
dXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBtbTogenN3YXA6IGRp
c2FibGUgbWlncmF0aW9uIHdoaWxlIHVzaW5nIHBlci0NCj4gQ1BVIGFjb21wX2N0eA0KPiANCj4g
T24gVHVlLCBKYW4gNywgMjAyNSBhdCA0OjAy4oCvUE0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA8
a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBZb3NyeSwN
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFlvc3J5
IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKYW51
YXJ5IDcsIDIwMjUgMjoyMyBQTQ0KPiA+ID4gVG86IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBDYzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNo
Zy5vcmc+OyBOaGF0IFBoYW0NCj4gPiA+IDxucGhhbWNzQGdtYWlsLmNvbT47IENoZW5nbWluZyBa
aG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+Ow0KPiA+ID4gVml0YWx5IFdvb2wgPHZpdGFs
eXdvb2xAZ21haWwuY29tPjsgQmFycnkgU29uZyA8YmFvaHVhQGtlcm5lbC5vcmc+Ow0KPiBTYW0N
Cj4gPiA+IFN1biA8c2Ftc3VuMTAwNjIxOUBnbWFpbC5jb20+OyBTcmlkaGFyLCBLYW5jaGFuYSBQ
DQo+ID4gPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IGxpbnV4LW1tQGt2YWNrLm9y
ZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZb3NyeSBBaG1lZCA8eW9z
cnlhaG1lZEBnb29nbGUuY29tPjsNCj4gPiA+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+
IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzJdIG1tOiB6c3dhcDogZGlzYWJsZSBtaWdyYXRpb24gd2hp
bGUgdXNpbmcgcGVyLQ0KPiBDUFUNCj4gPiA+IGFjb21wX2N0eA0KPiA+ID4NCj4gPiA+IEluIHpz
d2FwX2NvbXByZXNzKCkgYW5kIHpzd2FwX2RlY29tcHJlc3MoKSwgdGhlIHBlci1DUFUgYWNvbXBf
Y3R4IG9mDQo+ID4gPiB0aGUNCj4gPiA+IGN1cnJlbnQgQ1BVIGF0IHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIG9wZXJhdGlvbiBpcyByZXRyaWV2ZWQgYW5kIHVzZWQNCj4gPiA+IHRocm91Z2hvdXQuICBI
b3dldmVyLCBzaW5jZSBuZWl0aGVyIHByZWVtcHRpb24gbm9yIG1pZ3JhdGlvbiBhcmUNCj4gZGlz
YWJsZWQsDQo+ID4gPiBpdCBpcyBwb3NzaWJsZSB0aGF0IHRoZSBvcGVyYXRpb24gY29udGludWVz
IG9uIGEgZGlmZmVyZW50IENQVS4NCj4gPiA+DQo+ID4gPiBJZiB0aGUgb3JpZ2luYWwgQ1BVIGlz
IGhvdHVucGx1Z2dlZCB3aGlsZSB0aGUgYWNvbXBfY3R4IGlzIHN0aWxsIGluIHVzZSwNCj4gPiA+
IHdlIHJ1biBpbnRvIGEgVUFGIGJ1ZyBhcyB0aGUgcmVzb3VyY2VzIGF0dGFjaGVkIHRvIHRoZSBh
Y29tcF9jdHggYXJlDQo+IGZyZWVkDQo+ID4gPiBkdXJpbmcgaG90dW5wbHVnIGluIHpzd2FwX2Nw
dV9jb21wX2RlYWQoKS4NCj4gPiA+DQo+ID4gPiBUaGUgcHJvYmxlbSB3YXMgaW50cm9kdWNlZCBp
biBjb21taXQgMWVjM2I1ZmU2ZWVjICgibW0venN3YXA6IG1vdmUNCj4gdG8NCj4gPiA+IHVzZQ0K
PiA+ID4gY3J5cHRvX2Fjb21wIEFQSSBmb3IgaGFyZHdhcmUgYWNjZWxlcmF0aW9uIikgd2hlbiB0
aGUgc3dpdGNoIHRvIHRoZQ0KPiA+ID4gY3J5cHRvX2Fjb21wIEFQSSB3YXMgbWFkZS4gIFByaW9y
IHRvIHRoYXQsIHRoZSBwZXItQ1BVIGNyeXB0b19jb21wDQo+IHdhcw0KPiA+ID4gcmV0cmlldmVk
IHVzaW5nIGdldF9jcHVfcHRyKCkgd2hpY2ggZGlzYWJsZXMgcHJlZW1wdGlvbiBhbmQgbWFrZXMg
c3VyZQ0KPiB0aGUNCj4gPiA+IENQVSBjYW5ub3QgZ28gYXdheSBmcm9tIHVuZGVyIHVzLiAgUHJl
ZW1wdGlvbiBjYW5ub3QgYmUgZGlzYWJsZWQgd2l0aA0KPiB0aGUNCj4gPiA+IGNyeXB0b19hY29t
cCBBUEkgYXMgYSBzbGVlcGFibGUgY29udGV4dCBpcyBuZWVkZWQuDQo+ID4gPg0KPiA+ID4gQ29t
bWl0IDhiYTJmODQ0ZjA1MCAoIm1tL3pzd2FwOiBjaGFuZ2UgcGVyLWNwdSBtdXRleCBhbmQgYnVm
ZmVyIHRvDQo+ID4gPiBwZXItYWNvbXBfY3R4IikgaW5jcmVhc2VkIHRoZSBVQUYgc3VyZmFjZSBh
cmVhIGJ5IG1ha2luZyB0aGUgcGVyLUNQVQ0KPiA+ID4gYnVmZmVycyBkeW5hbWljLCBhZGRpbmcg
eWV0IGFub3RoZXIgcmVzb3VyY2UgdGhhdCBjYW4gYmUgZnJlZWQgZnJvbQ0KPiB1bmRlcg0KPiA+
ID4genN3YXAgY29tcHJlc3Npb24vZGVjb21wcmVzc2lvbiBieSBDUFUgaG90dW5wbHVnLg0KPiA+
ID4NCj4gPiA+IFRoaXMgY2Fubm90IGJlIGZpeGVkIGJ5IGhvbGRpbmcgY3B1c19yZWFkX2xvY2so
KSwgYXMgaXQgaXMgcG9zc2libGUgZm9yDQo+ID4gPiBjb2RlIGFscmVhZHkgaG9sZGluZyB0aGUg
bG9jayB0byBmYWxsIGludG8gcmVjbGFpbSBhbmQgZW50ZXIgenN3YXANCj4gPiA+IChjYXVzaW5n
IGEgZGVhZGxvY2spLiBJdCBhbHNvIGNhbm5vdCBiZSBmaXhlZCBieSB3cmFwcGluZyB0aGUgdXNh
Z2Ugb2YNCj4gPiA+IGFjb21wX2N0eCBpbiBhbiBTUkNVIGNyaXRpY2FsIHNlY3Rpb24gYW5kIHVz
aW5nIHN5bmNocm9uaXplX3NyY3UoKSBpbg0KPiA+ID4genN3YXBfY3B1X2NvbXBfZGVhZCgpLCBi
ZWNhdXNlIHN5bmNocm9uaXplX3NyY3UoKSBpcyBub3QgYWxsb3dlZCBpbg0KPiA+ID4gQ1BVLWhv
dHBsdWcgbm90aWZpZXJzIChzZWUNCj4gPiA+IERvY3VtZW50YXRpb24vUkNVL0Rlc2lnbi9SZXF1
aXJlbWVudHMvUmVxdWlyZW1lbnRzLnJzdCkuDQo+ID4gPg0KPiA+ID4gVGhpcyBjYW4gYmUgZml4
ZWQgYnkgcmVmY291bnRpbmcgdGhlIGFjb21wX2N0eCwgYnV0IGl0IGludm9sdmVzDQo+ID4gPiBj
b21wbGV4aXR5IGluIGhhbmRsaW5nIHRoZSByYWNlIGJldHdlZW4gdGhlIHJlZmNvdW50IGRyb3Bw
aW5nIHRvIHplcm8gaW4NCj4gPiA+IHpzd2FwX1tkZV1jb21wcmVzcygpIGFuZCB0aGUgcmVmY291
bnQgYmVpbmcgcmUtaW5pdGlhbGl6ZWQgd2hlbiB0aGUgQ1BVDQo+ID4gPiBpcyBvbmxpbmVkLg0K
PiA+ID4NCj4gPiA+IEtlZXAgdGhpbmdzIHNpbXBsZSBmb3Igbm93IGFuZCBqdXN0IGRpc2FibGUg
bWlncmF0aW9uIHdoaWxlIHVzaW5nIHRoZQ0KPiA+ID4gcGVyLUNQVSBhY29tcF9jdHggdG8gYmxv
Y2sgQ1BVIGhvdHVucGx1ZyB1bnRpbCB0aGUgdXNhZ2UgaXMgb3Zlci4NCj4gPiA+DQo+ID4gPiBG
aXhlczogMWVjM2I1ZmU2ZWVjICgibW0venN3YXA6IG1vdmUgdG8gdXNlIGNyeXB0b19hY29tcCBB
UEkgZm9yDQo+ID4gPiBoYXJkd2FyZSBhY2NlbGVyYXRpb24iKQ0KPiA+ID4gQ2M6IDxzdGFibGVA
dmdlci5rZXJuZWwub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9zcnkgQWhtZWQgPHlvc3J5
YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+IFJlcG9ydGVkLWJ5OiBKb2hhbm5lcyBXZWluZXIgPGhh
bm5lc0BjbXB4Y2hnLm9yZz4NCj4gPiA+IENsb3NlczoNCj4gPiA+DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyNDExMTMyMTMwMDcuR0IxNTY0MDQ3QGNtcHhjaGcub3JnLw0KPiA+
ID4gUmVwb3J0ZWQtYnk6IFNhbSBTdW4gPHNhbXN1bjEwMDYyMTlAZ21haWwuY29tPg0KPiA+ID4g
Q2xvc2VzOg0KPiA+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUVrSmZZTXRT
ZE01SGNlTnNYVURmNWhhZ2hENStvMmU3UXY0Tw0KPiA+ID4gY3VydUw0dFBnNk9hUUBtYWlsLmdt
YWlsLmNvbS8NCj4gPiA+IC0tLQ0KPiA+ID4gIG1tL3pzd2FwLmMgfCAxOSArKysrKysrKysrKysr
KysrLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dhcC5j
DQo+ID4gPiBpbmRleCBmNjMxNmI2NmZiMjM2Li5lY2Q4NjE1M2U4YTMyIDEwMDY0NA0KPiA+ID4g
LS0tIGEvbW0venN3YXAuYw0KPiA+ID4gKysrIGIvbW0venN3YXAuYw0KPiA+ID4gQEAgLTg4MCw2
ICs4ODAsMTggQEAgc3RhdGljIGludCB6c3dhcF9jcHVfY29tcF9kZWFkKHVuc2lnbmVkIGludA0K
PiBjcHUsDQo+ID4gPiBzdHJ1Y3QgaGxpc3Rfbm9kZSAqbm9kZSkNCj4gPiA+ICAgICAgIHJldHVy
biAwOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArLyogUmVtYWluIG9uIHRoZSBDUFUgd2hpbGUg
dXNpbmcgaXRzIGFjb21wX2N0eCB0byBzdG9wIGl0IGZyb20gZ29pbmcNCj4gb2ZmbGluZQ0KPiA+
ID4gKi8NCj4gPiA+ICtzdGF0aWMgc3RydWN0IGNyeXB0b19hY29tcF9jdHggKmFjb21wX2N0eF9n
ZXRfY3B1KHN0cnVjdA0KPiA+ID4gY3J5cHRvX2Fjb21wX2N0eCBfX3BlcmNwdSAqYWNvbXBfY3R4
KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIG1pZ3JhdGVfZGlzYWJsZSgpOw0KPiA+ID4gKyAgICAg
cmV0dXJuIHJhd19jcHVfcHRyKGFjb21wX2N0eCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4g
K3N0YXRpYyB2b2lkIGFjb21wX2N0eF9wdXRfY3B1KHZvaWQpDQo+ID4gPiArew0KPiA+ID4gKyAg
ICAgbWlncmF0ZV9lbmFibGUoKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGJv
b2wgenN3YXBfY29tcHJlc3Moc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCB6c3dhcF9lbnRyeQ0K
PiAqZW50cnksDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHpzd2FwX3Bv
b2wgKnBvb2wpDQo+ID4gPiAgew0KPiA+ID4gQEAgLTg5Myw4ICs5MDUsNyBAQCBzdGF0aWMgYm9v
bCB6c3dhcF9jb21wcmVzcyhzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4gc3RydWN0DQo+ID4gPiB6c3dh
cF9lbnRyeSAqZW50cnksDQo+ID4gPiAgICAgICBnZnBfdCBnZnA7DQo+ID4gPiAgICAgICB1OCAq
ZHN0Ow0KPiA+ID4NCj4gPiA+IC0gICAgIGFjb21wX2N0eCA9IHJhd19jcHVfcHRyKHBvb2wtPmFj
b21wX2N0eCk7DQo+ID4gPiAtDQo+ID4gPiArICAgICBhY29tcF9jdHggPSBhY29tcF9jdHhfZ2V0
X2NwdShwb29sLT5hY29tcF9jdHgpOw0KPiA+ID4gICAgICAgbXV0ZXhfbG9jaygmYWNvbXBfY3R4
LT5tdXRleCk7DQo+ID4gPg0KPiA+ID4gICAgICAgZHN0ID0gYWNvbXBfY3R4LT5idWZmZXI7DQo+
ID4gPiBAQCAtOTUwLDYgKzk2MSw3IEBAIHN0YXRpYyBib29sIHpzd2FwX2NvbXByZXNzKHN0cnVj
dCBwYWdlICpwYWdlLA0KPiBzdHJ1Y3QNCj4gPiA+IHpzd2FwX2VudHJ5ICplbnRyeSwNCj4gPiA+
ICAgICAgICAgICAgICAgenN3YXBfcmVqZWN0X2FsbG9jX2ZhaWwrKzsNCj4gPiA+DQo+ID4gPiAg
ICAgICBtdXRleF91bmxvY2soJmFjb21wX2N0eC0+bXV0ZXgpOw0KPiA+ID4gKyAgICAgYWNvbXBf
Y3R4X3B1dF9jcHUoKTsNCj4gPg0KPiA+IEkgaGF2ZSBvYnNlcnZlZCB0aGF0IGRpc2FibGluZy9l
bmFibGluZyBwcmVlbXB0aW9uIGluIHRoaXMgcG9ydGlvbiBvZiB0aGUNCj4gY29kZQ0KPiA+IGNh
biByZXN1bHQgaW4gc2NoZWR1bGluZyB3aGlsZSBhdG9taWMgZXJyb3JzLiBJcyB0aGUgc2FtZSBw
b3NzaWJsZSB3aGlsZQ0KPiA+IGRpc2FibGluZy9lbmFibGluZyBtaWdyYXRpb24/DQo+IA0KPiBJ
SVVDIG5vLCBtaWdyYXRpb24gZGlzYWJsZWQgaXMgbm90IGFuIGF0b21pYyBjb250ZXh0Lg0KDQpP
aywgdGhhbmtzLg0KDQo+IA0KPiA+DQo+ID4gQ291cGxlIG9mIHBvc3NpYmx5IHJlbGF0ZWQgdGhv
dWdodHM6DQo+ID4NCj4gPiAxKSBJIGhhdmUgYmVlbiB0aGlua2luZyBzb21lIG1vcmUgYWJvdXQg
dGhlIHB1cnBvc2Ugb2YgdGhpcyBwZXItY3B1DQo+IGFjb21wX2N0eA0KPiA+ICAgICAgbXV0ZXgu
IEl0IGFwcGVhcnMgdGhhdCB0aGUgbWFpbiBiZW5lZml0IGlzIGl0IGNhdXNlcyB0YXNrIGJsb2Nr
ZWQgZXJyb3JzDQo+ICh3aGljaCBhcmUNCj4gPiAgICAgIHVzZWZ1bCB0byBkZXRlY3QgcHJvYmxl
bXMpIGlmIGFueSBjb21wdXRlcyBpbiB0aGUgY29kZSBzZWN0aW9uIGl0IGNvdmVycw0KPiB0YWtl
IGENCj4gPiAgICAgIGxvbmcgZHVyYXRpb24uIE90aGVyIHRoYW4gdGhhdCwgaXQgZG9lcyBub3Qg
cHJvdGVjdCBhIHJlc291cmNlLCBub3INCj4gcHJldmVudA0KPiA+ICAgICAgY3B1IG9mZmxpbmlu
ZyBmcm9tIGRlbGV0aW5nIGl0cyBjb250YWluaW5nIHN0cnVjdHVyZS4NCj4gDQo+IEl0IGRvZXMg
cHJvdGVjdCByZXNvdXJjZXMuIENvbnNpZGVyIHRoaXMgY2FzZToNCj4gLSBQcm9jZXNzIEEgcnVu
cyBvbiBDUFUgIzEsIGdldHMgdGhlIGFjb21wX2N0eCwgYW5kIGxvY2tzIGl0LCB0aGVuIGlzDQo+
IG1pZ3JhdGVkIHRvIENQVSAjMi4NCj4gLSBQcm9jZXNzIEIgcnVucyBvbiBDUFUgIzEsIGdldHMg
dGhlIHNhbWUgYWNvbXBfY3R4LCBhbmQgdHJpZXMgdG8gbG9jaw0KPiBpdCB0aGVuIHdhaXRzIGZv
ciBwcm9jZXNzIEEuIFdpdGhvdXQgdGhlIGxvY2sgdGhleSB3b3VsZCBiZSB1c2luZyB0aGUNCj4g
c2FtZSBsb2NrLg0KPiANCj4gSXQgaXMgYWxzbyBwb3NzaWJsZSB0aGF0IHByb2Nlc3MgQSBzaW1w
bHkgZ2V0cyBwcmVlbXB0ZWQgd2hpbGUgcnVubmluZw0KPiBvbiBDUFUgIzEgYnkgYW5vdGhlciB0
YXNrIHRoYXQgYWxzbyB0cmllcyB0byB1c2UgdGhlIGFjb21wX2N0eC4gVGhlDQo+IG11dGV4IGFs
c28gcHJvdGVjdHMgYWdhaW5zdCB0aGlzIGNhc2UuDQoNCkdvdCBpdCwgdGhhbmtzIGZvciB0aGUg
ZXhwbGFuYXRpb25zLiBJdCBzZWVtcyB3aXRoIHRoaXMgcGF0Y2gsIHRoZSBtdXRleA0Kd291bGQg
YmUgcmVkdW5kYW50IGluIHRoZSBmaXJzdCBleGFtcGxlLiBXb3VsZCB0aGlzIGFsc28gYmUgdHJ1
ZSBvZiB0aGUNCnNlY29uZCBleGFtcGxlIHdoZXJlIHByb2Nlc3MgQSBnZXRzIHByZWVtcHRlZD8g
IElmIG5vdCwgaXMgaXQgd29ydGgNCmZpZ3VyaW5nIG91dCBhIHNvbHV0aW9uIHRoYXQgd29ya3Mg
Zm9yIGJvdGggbWlncmF0aW9uIGFuZCBwcmVlbXB0aW9uPw0KDQo+IA0KPiA+DQo+ID4gMikgU2Vl
bXMgbGlrZSB0aGUgb3ZlcmFsbCBwcm9ibGVtIGFwcGVhcnMgdG8gYmUgYXBwbGljYWJsZSB0byBh
bnkgcGVyLWNwdQ0KPiBkYXRhDQo+ID4gICAgICB0aGF0IGlzIGJlaW5nIHVzZWQgYnkgYSBwcm9j
ZXNzLCB2aXMtYS12aXMgY3B1IGhvdHVucGx1Zy4gQ291bGQgaXQgYmUgdGhhdCBhDQo+ID4gICAg
ICBzb2x1dGlvbiBpbiBjcHUgaG90dW5wbHVnIGNhbiBzYWZlLWd1YXJkIG1vcmUgZ2VuZXJhbGx5
PyBSZWFsbHkgbm90IHN1cmUNCj4gPiAgICAgIGFib3V0IHRoZSBzcGVjaWZpY3Mgb2YgYW55IHNv
bHV0aW9uLCBidXQgaXQgb2NjdXJyZWQgdG8gbWUgdGhhdCB0aGlzIG1heQ0KPiBub3QNCj4gPiAg
ICAgIGJlIGEgcHJvYmxlbSB1bmlxdWUgdG8genN3YXAuDQo+IA0KPiBOb3QgcmVhbGx5LiBTdGF0
aWMgcGVyLUNQVSBkYXRhIGFuZCBkYXRhIGFsbG9jYXRlZCB3aXRoIGFsbG9jX3BlcmNwdSgpDQo+
IHNob3VsZCBiZSBhdmFpbGFibGUgZm9yIGFsbCBwb3NzaWJsZSBDUFVzLCByZWdhcmRsZXNzIG9m
IHdoZXRoZXIgdGhleQ0KPiBhcmUgb25saW5lIG9yIG5vdCwgc28gQ1BVIGhvdHVucGx1ZyBpcyBu
b3QgcmVsZXZhbnQuIEl0IGlzIHJlbGV2YW50DQo+IGhlcmUgYmVjYXVzZSB3ZSBhbGxvY2F0ZSB0
aGUgbWVtb3J5IGR5bmFtaWNhbGx5IGZvciBvbmxpbmUgQ1BVcyBvbmx5DQo+IHRvIHNhdmUgbWVt
b3J5LiBJIGFtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgdGhpcyBpcyBhcyBJIGFtIG5vdCBhd2Fy
ZQ0KPiB3aGF0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIG51bWJlciBvZiBvbmxpbmUgYW5k
IHBvc3NpYmxlIENQVXMgY2FuDQo+IGJlIGluIHJlYWwgbGlmZSBkZXBsb3ltZW50cy4NCg0KVGhv
dWdodCBJIHdvdWxkIGNsYXJpZnkgd2hhdCBJIG1lYW50OiB0aGUgcHJvYmxlbSBvZiBwZXItY3B1
IGRhdGEgdGhhdA0KZ2V0cyBhbGxvY2F0ZWQgZHluYW1pY2FsbHkgdXNpbmcgY3B1IGhvdHBsdWcg
YW5kIGRlbGV0ZWQgZXZlbiB3aGlsZSBpbiB1c2UNCmJ5IGNwdSBob3R1bnBsdWcgbWF5IG5vdCBi
ZSB1bmlxdWUgdG8genN3YXAuIElmIHNvLCBJIHdhcyB3b25kZXJpbmcgaWYNCmEgbW9yZSBnZW5l
cmljIHNvbHV0aW9uIGluIHRoZSBjcHUgaG90dW5wbHVnIGNvZGUgd291bGQgYmUgZmVhc2libGUv
d29ydGgNCmV4cGxvcmluZy4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gPg0KPiA+IFRo
YW5rcywNCj4gPiBLYW5jaGFuYQ0KPiA+DQo+ID4gPiAgICAgICByZXR1cm4gY29tcF9yZXQgPT0g
MCAmJiBhbGxvY19yZXQgPT0gMDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gQEAgLTk2MCw3ICs5
NzIsNyBAQCBzdGF0aWMgdm9pZCB6c3dhcF9kZWNvbXByZXNzKHN0cnVjdA0KPiB6c3dhcF9lbnRy
eQ0KPiA+ID4gKmVudHJ5LCBzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ID4gICAgICAgc3RydWN0
IGNyeXB0b19hY29tcF9jdHggKmFjb21wX2N0eDsNCj4gPiA+ICAgICAgIHU4ICpzcmM7DQo+ID4g
Pg0KPiA+ID4gLSAgICAgYWNvbXBfY3R4ID0gcmF3X2NwdV9wdHIoZW50cnktPnBvb2wtPmFjb21w
X2N0eCk7DQo+ID4gPiArICAgICBhY29tcF9jdHggPSBhY29tcF9jdHhfZ2V0X2NwdShlbnRyeS0+
cG9vbC0+YWNvbXBfY3R4KTsNCj4gPiA+ICAgICAgIG11dGV4X2xvY2soJmFjb21wX2N0eC0+bXV0
ZXgpOw0KPiA+ID4NCj4gPiA+ICAgICAgIHNyYyA9IHpwb29sX21hcF9oYW5kbGUoenBvb2wsIGVu
dHJ5LT5oYW5kbGUsIFpQT09MX01NX1JPKTsNCj4gPiA+IEBAIC05OTAsNiArMTAwMiw3IEBAIHN0
YXRpYyB2b2lkIHpzd2FwX2RlY29tcHJlc3Moc3RydWN0DQo+IHpzd2FwX2VudHJ5DQo+ID4gPiAq
ZW50cnksIHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+ID4gPg0KPiA+ID4gICAgICAgaWYgKHNyYyAh
PSBhY29tcF9jdHgtPmJ1ZmZlcikNCj4gPiA+ICAgICAgICAgICAgICAgenBvb2xfdW5tYXBfaGFu
ZGxlKHpwb29sLCBlbnRyeS0+aGFuZGxlKTsNCj4gPiA+ICsgICAgIGFjb21wX2N0eF9wdXRfY3B1
KCk7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICAvKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqDQo+ID4gPiAtLQ0KPiA+ID4gMi40Ny4xLjYxMy5nYzI3ZjRiN2E5Zi1nb29nDQo+ID4N
Cg==

