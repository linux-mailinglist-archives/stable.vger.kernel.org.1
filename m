Return-Path: <stable+bounces-226125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKGzAy6CuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D92AE094
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4EC301D32F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEB318EFA;
	Tue, 17 Mar 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD0bxAwg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A01313272
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764872; cv=fail; b=a+5/n2oIjVufzN4ZY+Imy6NYI7oCgC7psDB/k+JFn4TML/aMzkyFw31OEPnxi0dtTpOeAIWwYP0GzeqrVm5Xh36ahzurBYpo+FwoAu8Dcvv7t5nIGun6H801p98zL44CtqlKaDUYOUHtYEH1oAZXPyOhlPTeTwvRc1TSyWjECzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764872; c=relaxed/simple;
	bh=5DSa+ygMDHBu1Y268kAot/wHxzC+Q+gBHON0r1DD0T8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0SIrSu+aO+4jjMIjQRqpm0jOxYcO8JoUu9+sRkwMsuoHxiMUrRq/PBbaLiK4NvTSdffhFHyoLjs4PCIgqI5UNuBRRDsGYmoiReFh+N1kZkFV29r0xh3j/ePtr5GNmyzj8R+rapdy5lbz/1qV+UMMY0p1mz2dQcYsk8lsgC/ypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD0bxAwg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773764871; x=1805300871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5DSa+ygMDHBu1Y268kAot/wHxzC+Q+gBHON0r1DD0T8=;
  b=LD0bxAwgyslzTU1VA2XVbIuOGRbWMYE81J6wECn/OVxeLg7BeSuT3AAS
   432giQTtQw5IJquiDlaJM/4uJNgn6TFXxC3s9opT+aTDLVjOoa8iyuo5s
   ihlpHayINm17rozi57fELL8WoTMmHnhzDT75vUiBSk8syWl3spAddSAOQ
   2GXGMsZRAAS133fX2hkJVkYKiD5CH6eYlAQJDUn4YnzegAP+mXxrQiDvP
   eYsIuJ7ZBsGjVDazIGXpbuj7dNDbw/fD7t2W9+oC6Qd2spto8kpiNqFkO
   KTLQJALAWfOjgT4Ezwq4XGthUaYodghUmfaoi0/+o8y84Yvd8eddN7vzX
   g==;
X-CSE-ConnectionGUID: TR+cTryvSjek2qu0T+ZJaw==
X-CSE-MsgGUID: Z7fONsrkRaWaZsUZ9irn8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78698716"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78698716"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:27:50 -0700
X-CSE-ConnectionGUID: rJ1CqDonTQ2X1APbG2hUGw==
X-CSE-MsgGUID: 4N8po4IRS96PNfpW6V4lzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222372335"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:27:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:27:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 09:27:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksvRUu8Z5+lNVR2G0qdLy+ZUrjYSdgljiNJZl0nvJq2IXsBoQdsQByvRpxNfnoFC9FyZKeBMTeGa8pZQhhkJUKd8xaqHEuiNYbu+hmnNdfTE7mJdPvW9z9W80fHYMPEoGYm+AiCi4qEYQunzSIk2zeRJLFrYu1iavr61JgBXOOyB4aJFALMBdsvrHR5RSOfJdAMm75tOk+0cvGVeqI2VtfCwrmLkNnjmip+kQQzD9ctnigm3hFv0CnKSgR56xUgg7wpyv7fF9jFWiMULZkKrmXvKZyoJ+pVQCd9GVbz3ml3GcAjbyNa58d5qPiSXxq8dT0VU//f7qYY28cV+CJXXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b16n31uWOlUAC7hoHaj59V5drlnXq8e+bPsL1QqC0K8=;
 b=ainM7fxf+Z8RDIC0WH4X+7HECnX2CZUD+rlngOV7Paw5BOVRvZ2MiqH7Q8Plt0haVnWIoFraW9VuTQ/QHoeNBUsfGILIG8Ul2hCL/p4/dk325V2JBVRgxWkbBiQTM+VpBKQYMhNwdZflSL3fnw0XwxaWTcpuBwWEJdRrmmD/77/i29Opm491XUpqVaVgfP2C7ZpOL3oIz9y7J8wrISeCZdnO26pLLszAvhFo+bZwRwRkeT9ZkRlMmuvKIRHT9JJxWSbgrqfeOaVotG1NQhVofZBordWucyzmGKYtkN51MsNhsjC4db1RyPgHkh9V7k/LbyXVoit60FE4lbA6G/n/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by SA1PR11MB9616.namprd11.prod.outlook.com (2603:10b6:806:4c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:27:47 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:27:47 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Brost,
 Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially initialized
 sync on parse" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Thread-Index: AQHctgPgECEJeu0MVEWd50ZolA7oKrWy6OSA
Date: Tue, 17 Mar 2026 16:27:46 +0000
Message-ID: <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <2026031732-size-unfasten-2bf3@gregkh>
In-Reply-To: <2026031732-size-unfasten-2bf3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|SA1PR11MB9616:EE_
x-ms-office365-filtering-correlation-id: fb7a7006-ca71-4a1d-ad55-08de84421fd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 0oHy6bTBnXZDpveKvSKZ97MiXm9JxPFHealIIZr/kCGSoaOKlkyDsV5UZL9qMTACLtPpKrdd3yOcojqd9v05UA8yKgbPtpw5cDs7FgQCVNVjsisiUKKR/ZZjBC/AKNGD682fIsCVYJLbpja9+TqnZD7/czvmcq0loGVkOBN1/wdoDsRrcbbZuYTnQhzsmrM7Fd9iis+ed64cD4MxkFZtwsHkJfhD+h1nvVHZqhJo6MlXIwN9ZxAR+s4ux3In64j65V6YT4yGjovYKH+SBYAjoNqryVWmnC3fFnMl6qs9iRcIDM9JyZsYZj0COKGViwHTxH7GXogiIRfhtg/NIquHHhSqWljo20G0U+UviAZ+tsorTZLSkMrYJ3MYRRxMgnbaY9poxdtWB1WpvAyjDOAj3BPsbW73RdvZ7VfzAWX1VagQ5xgN9P4a8P+pTlODNpJP2GcBzkLGbVXJNR8EXV08p/9TplaoUHERsWb5/ucT8z9pxAmeVmI4M6gQf++S44XSkQHeg0SkII7td3/G+hhlceed2luqFD2gpMKyuqAGw+HQopTR7Bpe5Cb/ExOoI8+0a+FKgHYI+Wo15rsMkcQ1WCgWtko9WkVt0zF5rcfNEN6jw1iaTQMV1ohCNFvGDDAHckWvRAtkx7FD2S+y+wOBIgb2NsqTo7uCj6WmaJfff9qU1UELC3t2szuyZ8TwDv5w42NwRVmFzZl5fj/bX/jmuP2h4Mg0GQbrhUAS3/bX7o9dkfBg4Uq2SucD9pCG40NS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJfWYCyJUjM9Y8T+NCh/LpbGy54ykI8ONspclfsho8JIKDof0c+zSeCh3PIH?=
 =?us-ascii?Q?zAoC5lMrp6MFQ7efLjJMaFCmf8YBMWV3xhEDy2Cb9VkMDXhVwgBYIg0wlTHK?=
 =?us-ascii?Q?3vMaomSWtc9qi2xrXG4iAoJZeS/XlzYfcALjooa4kaTm8MXgbZyhF5XMQmnK?=
 =?us-ascii?Q?eVcIJylQLAmT3SNBIBE/Y2rrKVzK7Jst4Oh4Nbpn7/WCSFPWEnX+QGHMwcRA?=
 =?us-ascii?Q?yKlEIA8f1QoIp+Nb+KlJIl3Kql6WoDwVpLjv8nARGyjNl6kkhKJ+6zwz5+1u?=
 =?us-ascii?Q?APpuhWM83UfUPqOoC7KJIqg7y/Da+V6lMa/pWXjIesXyNFWDNHlTBkZ6IC8A?=
 =?us-ascii?Q?D1Uv4G/6kVXObmYdmEcDegzhwqbc0QxCkjpkmRXAN96fSoAQkaIRnGzRlrWr?=
 =?us-ascii?Q?Stcc6nluZ4G+kAt8lV5GxNicOjJX0dJlo0FEbvRXbSooYIdAOveJ6yi+CWet?=
 =?us-ascii?Q?hOhXk0CeqLLxrkczrUm66RxnaNivt73kDle/uODrfoqN9/VdUF8z7OzKZVhk?=
 =?us-ascii?Q?O2KxvZun6NzJMGeS0211jitcVFPm8ZNo9EkXatbB+j9YuySS2oZSqRuyuLiR?=
 =?us-ascii?Q?ZJGsAxMBQtPbPn6vK3xK0ZptJZqUXNGH2qA6UhC2E69NTR8yIFEptM5P1z9b?=
 =?us-ascii?Q?D70/gl5QH+1V4vMMoiwzcuTBMs6s4W2spA1NqoIzd/IsIWXHxXqRbCx+f7mk?=
 =?us-ascii?Q?0tMS0vecZ15Wx3+qnRUtjjROreixZz05U8RKik7sMY5D5rRwhS2RctvydjIM?=
 =?us-ascii?Q?n/CksJKkcCE1DnJE5SVAWR+DSdJFUkyJ2Rs6Dmb4YwCiyk/KMmphoF1LPv4l?=
 =?us-ascii?Q?dZ3qcg56a47FhRbn1l8PGPoSIgGZSsiL+UcrBBhCnQhXQz+XfmaUgUVAQcC1?=
 =?us-ascii?Q?YEGpRgcIrGwyRHcQk8C4GqnKPQ4Bn8/vDA7xJ1Z8VaHp4Pu3z6wMjVL45NIG?=
 =?us-ascii?Q?V7kWinBShYKtHNa3XyaGVYClcQ1IlB1oT/naRrZZBKVwcztQxVp8jfIIJH+w?=
 =?us-ascii?Q?2Ngu/Bu7sKd4kclY25fDTb5fY3FAnJJEKqqUTVv1vIpjMrTDG/QHf1qCSbCW?=
 =?us-ascii?Q?jMF7qSUOljU753Udy18td5/topqI5RT71f7tERlK57C635q6KPfiqOMi6Q66?=
 =?us-ascii?Q?mn5mHdtqCxu3CVve1j9KnqQAI04Sh8DK8CtXQ4Pj5n7FvGY2/U5+hAlqFc0O?=
 =?us-ascii?Q?i5g1HrAiY95d96gLr7FbL/6gC1JbapsCdgUwyBDjlMCvYetKBQnQ6/KtbGPt?=
 =?us-ascii?Q?IQ7rT6F9nlRiTDCkIivKEB4vhIBUPPz+BFsOYEjcBn/yj6C4EdSF44nPCItk?=
 =?us-ascii?Q?ff6xM+NLvmm7ZUNA5hLOzpvlsQg/keyX/mOaJo5wovmI7yW6zY/+YFsSoNkf?=
 =?us-ascii?Q?NIBZKrm4rvHQYfPf9Lt+n6dNdFFPgyH4jxOiBq9CKrStgDzDd6GZOy1i9e/v?=
 =?us-ascii?Q?b3mFOz9jGODbKXPPGi989hV4HZru1Wj1L4iOg/e+B2moiGa9SO3sdbRW7P3N?=
 =?us-ascii?Q?8FfNHji6jRn6uX3z1f4ija36A9qHeJ7rjRCAdX7lvEa/mapOt2pvGQvY1VVO?=
 =?us-ascii?Q?/GqA7qhjF0Ng9ao8aPdLLg+gXkqbeADsVH5EtTUvMR7eG93qNr3PazyRD4sm?=
 =?us-ascii?Q?hskqS7CRugiN41sC7/nqHEmsxCIXX1KDtfx/StQgkHoSEsJ5R9xQSFMEycKg?=
 =?us-ascii?Q?kToKe09tvo9rVPWvYH4LwMyRzcKuH3Sy03JMC6NNc9pMiNGtzvROmE4X9MWh?=
 =?us-ascii?Q?/gSYJK2nWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tp11Kgo4BKnyNUKzghQV02lfh04qb8arPqYBcRlytZS1TmG9kqBh3ANNzNF0OL7U1wo3a6UuBzJSPnN3PmCqBbVtEE8Z8PxoD4aHYX2KzNS3OGAWBoAjXGlxSFaafPBmp+AAQfanrvsk9RFrk3lenzU4ausCURz5OjcMtfN479WUKr4Ej8LrV7xnhGJw9ELkJVJYG80fGtOwh0xxjzBnXcJYzq7tDT4DQWVnmCls5rImVf85V0/xDOYGdLW2oJn+SxyUd7S4Zrg5pXNQ+M7yaPu+9aJ/Ku7hpa005aV4CsY/vQojSRfbH0819nKixDA05JL7pzc3b8qB2l8JOXt9OQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a7006-ca71-4a1d-ad55-08de84421fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 16:27:46.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIylLDXcuKlqyBk4mOAzkCxM8oRWgKT4RGhMbTjXuKvMAyB33UV1maIIE+1VIb6zdecyFCLzhKp80Z8R9XU02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9616
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226125-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,gregkh:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7B4D92AE094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 4:48 AM gregkh wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm tre=
e,
> then please email the backport, including the original git commit id to
> <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/
> linux-6.12.y git checkout FETCH_HEAD git cherry-pick -x
> 1bfd7575092420ba5a0b944953c95b74a5646ff8
> # <resolve conflicts, build, test, etc.> git commit -s git send-email --t=
o
> '<stable@vger.kernel.org>' --in-reply-to '2026031732-size-unfasten-
> 2bf3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

I cannot reproduce the failure with upper cmd.
The patch could be applied successfully without conflict.
Anyway, I follow the instructions re-send the patch.
Let me know if it still has issue.
Thanks.

Shuicheng

>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 1bfd7575092420ba5a0b944953c95b74a5646ff8 Mon Sep 17
> 00:00:00 2001
> From: Shuicheng Lin <shuicheng.lin@intel.com>
> Date: Thu, 19 Feb 2026 23:35:18 +0000
> Subject: [PATCH] drm/xe/sync: Cleanup partially initialized sync on parse
> failure
>=20
> xe_sync_entry_parse() can allocate references (syncobj, fence, chain fenc=
e, or
> user fence) before hitting a later failure path. Several of those paths r=
eturned
> directly, leaving partially initialized state and leaking refs.
>=20
> Route these error paths through a common free_sync label and call
> xe_sync_entry_cleanup(sync) before returning the error.
>=20
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Link: https://patch.msgid.link/20260219233516.2938172-5-
> shuicheng.lin@intel.com
> (cherry picked from commit
> f939bdd9207a5d1fc55cced5459858480686ce22)
> Cc: stable@vger.kernel.org
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>=20
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index eb136390dafd..ebf6c96d7a41 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -146,8 +146,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct
> xe_file *xef,
>=20
>  		if (!signal) {
>  			sync->fence =3D drm_syncobj_fence_get(sync-
> >syncobj);
> -			if (XE_IOCTL_DBG(xe, !sync->fence))
> -				return -EINVAL;
> +			if (XE_IOCTL_DBG(xe, !sync->fence)) {
> +				err =3D -EINVAL;
> +				goto free_sync;
> +			}
>  		}
>  		break;
>=20
> @@ -167,17 +169,21 @@ int xe_sync_entry_parse(struct xe_device *xe,
> struct xe_file *xef,
>=20
>  		if (signal) {
>  			sync->chain_fence =3D dma_fence_chain_alloc();
> -			if (!sync->chain_fence)
> -				return -ENOMEM;
> +			if (!sync->chain_fence) {
> +				err =3D -ENOMEM;
> +				goto free_sync;
> +			}
>  		} else {
>  			sync->fence =3D drm_syncobj_fence_get(sync-
> >syncobj);
> -			if (XE_IOCTL_DBG(xe, !sync->fence))
> -				return -EINVAL;
> +			if (XE_IOCTL_DBG(xe, !sync->fence)) {
> +				err =3D -EINVAL;
> +				goto free_sync;
> +			}
>=20
>  			err =3D dma_fence_chain_find_seqno(&sync->fence,
>=20
> sync_in.timeline_value);
>  			if (err)
> -				return err;
> +				goto free_sync;
>  		}
>  		break;
>=20
> @@ -216,6 +222,10 @@ int xe_sync_entry_parse(struct xe_device *xe, struct
> xe_file *xef,
>  	sync->timeline_value =3D sync_in.timeline_value;
>=20
>  	return 0;
> +
> +free_sync:
> +	xe_sync_entry_cleanup(sync);
> +	return err;
>  }
>  ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
>=20


