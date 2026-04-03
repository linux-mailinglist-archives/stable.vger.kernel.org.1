Return-Path: <stable+bounces-233205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEgwMlnlz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:05:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CD39611B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D92300ECB8
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B93C7E1C;
	Fri,  3 Apr 2026 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwwM2med"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2D1B4244;
	Fri,  3 Apr 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232289; cv=fail; b=smIWGMXEOb9XTVPPMfAtScnAvp6euufdS9/658nuUQqtwnerWi4EsnnevPwWI1M33GyeC8Fi3eoxaESuAYBTlXKov2JlHitmwiZ2b6zMIlv7PgRCx9RwXgFVZ0oom3D2XIsO3tHa8e0h9/Kg9XaPmh+Y/h5EySwN2iPj+JWSVdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232289; c=relaxed/simple;
	bh=u3FFa7Gg9sNrV/EYdLsCtzij1fGvTrHfdADhII5VB7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqj1Z6sOI3tfWKtzCjdtJQ+/P6Fp1YMRNJTue07mhSMkYK/kxkAVX3LntgKqMhfvaYZzHKjxN9gG4itLttWRZLMurA881sD5ImfrbsSUYSNibqdFRkj5qP/CTV5w9VOgICt7eaBR1CcJtfFAuQ/eFUQeslwbePGw8cANHaott3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwwM2med; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775232288; x=1806768288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u3FFa7Gg9sNrV/EYdLsCtzij1fGvTrHfdADhII5VB7o=;
  b=dwwM2med/758xsmb4SoFSv56/VhLVfdJylqkbUN7nYxNJ7CgaUeqghaM
   kaUYnDwhKFla0L5CLELUtEYtq8nP9O25lJl2gXIkFSspqUg/xBpvGRVqa
   Mmf4NQlMgAaAEl2NN7PfXugLqO4kdgvzCV9oUw+mmjV2VFIXP5R0U2MpD
   V1RoC6HrF987aLKrqUiyV+TKF4e/eW/rh7NjL+PXeAq0/F57BxegVB0Tx
   MWoGkqicpLvVyjo2TjIDBZjcZC76yD9on53rXGhkyPn1LgrIM6mafNEg2
   evSp72gdQfLHXSz5iSp/auAsqaJPrpi77uKGQo+kDJESYBonP93tpmiOe
   w==;
X-CSE-ConnectionGUID: 8BgWzayMSYK359GO/UqJmQ==
X-CSE-MsgGUID: PO7ve23TRwSElC7Sn67rQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76178553"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76178553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:04:45 -0700
X-CSE-ConnectionGUID: OAoYG2LvTSqDnALyKt0vgA==
X-CSE-MsgGUID: g4MxzOGIQMW0kqpoeWr7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="220655122"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:04:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:04:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:04:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDsLrMw8QDreVRjWtK+WOoEGDbxkFG3vSXmhsUqZUYBTt5oQG/4/uPbnATSwJtzMLjQ6EGPJIfamgZ/ZnEt03EPHT8LGGllrK4eayUzvjPRhWDAnpL//72EAbHFfQBtIgZb5/ZyKgN2/ic6bEm3Vxevqi0fdWtjV7dGCquWNDSGCEUrW05SIUoE0f3GVFsTVrIfScpYogpBXc07yRpvMiXMitmi6ON+hAg2S3mMW5RKnyL8vqe76iWgXU5BeQkUqp/bcBCeXafZgJWZe3ZLicAQbnwtJ1AbhNWFAikyRO86BQ1NlHQxuT7uCWO6GEnEKH20gue0RHPJil2Rb9CXk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9tgYECGFGG7iw2wSet8Kkd123jXIuuF1WwS+qtl4SM=;
 b=W30X0J6ky/txHSEUEnHTcsc6Fn+Le8Ct6yCAZST1A7llo2b0BK4St1A+qpPWufRxaLtGh0oz0El7X6wBd75xc/Fw+nw6pGpTmmBMWNNWEsgc4RXJUuuHL/2w3LzOx0XMn+XNYyZDv41TxdAQ2b4oVuksyQvopqMjlvk2dBg/WSzCtGAauuxSbo2BJooMRgPgW2qxAn9puzs+jHH1goCmbUb9sk0XNGbuGjsow1fj7Rrl1cUnCaJ4QotdGbtcNIxnO8QV7oNm9+gXFdzQ1TlXXTgxQaybJV8eHCjA8EJfX2gul6umA3D+0FGNLPiEpUr0kO/yQG8KYIX7Eaor5T+vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 16:04:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Fri, 3 Apr 2026
 16:04:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: fix netdev allocation with max queues
 instead of default
Thread-Topic: [PATCH iwl-net] ice: fix netdev allocation with max queues
 instead of default
Thread-Index: AQHcwy8bLdSHVYg14ES5H48aA+8IELXNf1aw
Date: Fri, 3 Apr 2026 16:04:08 +0000
Message-ID: <IA3PR11MB89865686747AE8CAF2570C11E55EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260403055948.3800555-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260403055948.3800555-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8436:EE_
x-ms-office365-filtering-correlation-id: 7f69f7de-bd9e-4b65-5c50-08de919aa391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 16YDJVeHhwvA7HEqD6EANEA9+RUdSMM/lc9O5yzShs3tDUf+JI21yiWFJoOlPXcGma3DKPpnkm7ClqAxP79h2z6oLxdq2HElR8uS5qj/1up7xcWTzQJqXBrWNy/FpeBDs/SCC3sRFsVP6BHzquiyvrz1w1C4tErV21hP88n4vNRjiE+CzVHkwnKT+/Q3eB672GaEGL19RyTAaROKaCrC9mS61HioqhaGMBuKH+HShr3ghvP484K+b+TNkSB+LTgPLrqfkAgA5KTuC6bhH7iHo69Fl947wGtbwP/47N9LsFA2fg6gI8MULul6Vv5iIHjxuLj5JiMjTzPZ0vxXbIfYY9yhFSadbOQLdsHyjI5xKyKCgTZ/AA53bSMQPihGu8Q4rpqVsGURRk3IHVISXi0ovztyewHDIqvCxAEpH/10kfDDMdTDI3D4qgecKfDBSeVgWFgdzEm4hy0U7LHp2XNeUxEM8yarB6LewNtqXCrePuw7cH00HU1wgtpBilbVFVLq/GMb/mnmHmTgwJT9VMSRia13eUMk7Nhn9UEOYpyTOPytfkjIwR2bQxXOwbGV0SPdigB0rNbjlN50pUn+e25Qg1LV7vH63xFiBnPRbN5ZeBKFRmzTmIUIai5MQ1xXpj8u0LPZShQfGYhrLpMANR4gHh3iDhVJe9RXrdEkwLxDETKSco9h2JV6X5caiF0iT5oiWq8mvEBP7oO6aQRkveDi2gTNEiuBxfRyA6DMrJ4+fg1jBfFRc3Fp373YODBtpD29qeywgTp9A2kLxCX1oh8SuEmyd3cuQN15s4m91QyGo5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Ja4fC+ujfTeRgsIG2yqI2FXkHy9IdkOiIIBUEntyzLQeN05INTo0aTKRrxY?=
 =?us-ascii?Q?ZGu75wHEV5AozEZp+vbafZIK18Pj+c+b9jYwHNR3EJw89crAsTXpP45OlLaG?=
 =?us-ascii?Q?jKM3hgFNIWahCja6As7tBUGiJnek7jYa7ufp8ty+NKMiBl5MSgfeTaHZhYzM?=
 =?us-ascii?Q?fhkyBYNhuJx0wblkfIv1tiFa9wyepkUp0VnEuxt+kYXXFvNPvVxOFZIzlI7u?=
 =?us-ascii?Q?S9IdI5xnLjjvX+bzU3+30MwgAatdI/EeV0jcgwY9/dF9DUoeKXIRz7VIxcPL?=
 =?us-ascii?Q?a8rxiOE5CP54i3xdWpS3j/F9fDIo9vmrJ3qte5dRweQBrsK07FuBxYlVSLAh?=
 =?us-ascii?Q?g0asAfZZ72CQwGUrCNREvaqlfXvdBaCKiAOqXETb8rFPfdIXFgGwmvrbwEPd?=
 =?us-ascii?Q?T5e9pCS7zlCXslMIeWsFLQT2qSYN5CqhaDi9B0NL/ydWzKBPfMShxLQojIlI?=
 =?us-ascii?Q?rTVhUW/BGSlGE+BxKGHKHWDA7DSF6he6DxRx2WAjvR9QTcSTP9wNnvVGNN5p?=
 =?us-ascii?Q?AjaHwxL9sEOKHGu+RQbOACSOA/Zsw5wC52a1lvUr4mUgQjFK/bRFbvpiG8GD?=
 =?us-ascii?Q?ZEwQtnbr6OnHR0ty5zWinphlm5PeXyqHS85tvsqXmCkNES7KYHOpbwNLfh7o?=
 =?us-ascii?Q?cefNlvyUOIQQpwpBLYRCmF+lzB/Vp4c+j07ei5SIgsEJKZm8c3fP4uMDJp6E?=
 =?us-ascii?Q?SOaDucng2KDXb9zZHLgiHu5XNHT/8JBQC2gqywvwGv1bvKXHpBjuLL34wkyx?=
 =?us-ascii?Q?qfVWNcI5T2PFvc7FnppqF2lY7rLWa+2iqWTq11GWy0oMafZ/DrEbJUEZ8Pve?=
 =?us-ascii?Q?yAoYSPSZcF/5LCsb8/SQuS/wUs+yBWQECdikZ5yGETSeuJzMSVRv6y4ErkFw?=
 =?us-ascii?Q?Q5QjedGEcBsg8XfaFGC+yckm6nGDfBB6/GxqM5T8IaTwkDaJTSR5+0Gf3b2c?=
 =?us-ascii?Q?dCXcz6YXIWKb4piIr9piBdwQ1zPwBziPcUdeqfT3Ut2w1TZW8sFryDbYkE3O?=
 =?us-ascii?Q?UNF41oau5c1Ha/ar4scBRkN0NYNLOTDBPar8z+2WdLARlLzKznlXVCSsnQlK?=
 =?us-ascii?Q?eyUCQ6+ZtWFKvTndMMdgpr3Idh7/q8UtVWD8D6NX0mZglK0JC3Z+5JP8PKEO?=
 =?us-ascii?Q?rAsh19eePYzFTdkih+FR7s1VJ2HXms9GtQqXvkyfg2eS7zsyJTCareqSoX65?=
 =?us-ascii?Q?SuLfZosDLb8RwvlHiELxMgPZ7B7qrn6QiTYMyPVxIAZQ8p/w8/Lq9KNLJ+Nx?=
 =?us-ascii?Q?HrvapPHKm/ZI2Xth37HZh1VBmt8B39qwTbF6hqkIDzP8H8UXVOkRFyHBdvZZ?=
 =?us-ascii?Q?sCc7P0hnMJfXC9+xOiNRZqxZNQWHZPESUu2W9DbnxXv407MfDsin2k9ohu9X?=
 =?us-ascii?Q?hy9+15pSXJvWRmidZX4wrQYDa+pA3qfju+ad9axBE89G1qDKAj2cYeTVHRy3?=
 =?us-ascii?Q?4VhJbMdYxpRKdIW5jkajwFQYb3Ch5sflGUVkveE3XzhOO5owLcGEvc5rLeem?=
 =?us-ascii?Q?TiIILQvQFiMUD9A3fiboJe9Ihynw/XEHIXC/9uPLvEQMoiSucUNsLKm3jLLl?=
 =?us-ascii?Q?jNi1x0lcNp8Bpv6PUl9VuH36QpMkxL5XCdEIF1P9ziSrzPPdrZGemrEp7SZp?=
 =?us-ascii?Q?BXdYQmxCRC14GKUlAW7eMx+vhOfZxjyGDnWZd0rCdR1SLCLkhxrrJPZWTxYK?=
 =?us-ascii?Q?XfeS/0tGZ707tsxivckJGgeA7YZ+scJPA8VKBLehmJTgUSoWxCOg7GB24Dp1?=
 =?us-ascii?Q?KzrItOSs7azI/JXNdIhW0GONPwrGu+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ISMoF6UkoXKUrjl3jr8JiBxLU5wy3PY/6K+6MX1KVwnJJe9Kce6cHAl1cj0NrvBJoOB2awUV4DCaFhMKmYCqCRa7i8FhdT3GESlC8Wkg5MPJnYf3Rwnft+qbUEeuHlTcwH3WI2tcOQuZVFNhfozBT9d7c0i4UxzOtWhIvX3e8rvL9gABS2teP0jEl4pPJ7DI1lKQDh+8YmhefzFZiLF9umLhZkvNWvdT0POj3W3bMEIjqMjQEK/aaJeje1vDbNrk3qEuir0IWk1yXNrf2qNoFGcJPQbt6vknlqITtx6LJRltUJ7KzVzIrfp4XOhRwM12rJ/Q/eLwtAPT/pDa/TS0ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69f7de-bd9e-4b65-5c50-08de919aa391
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 16:04:08.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74YYjXr9DlrAOy0ReX6JQ8TNsXMWO5zPZgnJJ9MCJNaBT1BV3oWzeei3IK3P5FGZ740HjY8yF59jcQjnL8HdKvKsxlH2sYT+MIn2VN13dn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 897CD39611B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, April 3, 2026 8:00 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-net] ice: fix netdev allocation with max queues
> instead of default
>=20

...


Good day all,

It turns out this issue was already addressed by commit
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?=
id=3Dc7fcd269e1e07b2aa4bb37ffce7543c340796433  ("ice: set max queues in all=
oc_etherdev_mqs()"),
submited about a month ago.

I missed this earlier-sorry for the noise. This patch is
therefore, obsolete and can be ignored.

Thanks,
Aleks

