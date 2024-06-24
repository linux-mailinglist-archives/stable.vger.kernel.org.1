Return-Path: <stable+bounces-54995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C291485F
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E55B2241B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1A1384B1;
	Mon, 24 Jun 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEKwp1Ys"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C5130A79;
	Mon, 24 Jun 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227967; cv=fail; b=j3hxuDUz5rPN5esKqP1O+yD0/o6v8JqbEp7kpf2fSZrikgQzS25CGjUXOX7dFJs2aE8JxqX7RaPp1qdQWmyd+dnre+f+V1RxHveLrAYFPMaItyNxWV5IMf8IWeYY8PJ5kBWxq+NEN5IlpanJq5DoGaE4Xc9/6B7rdbwLERGwJzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227967; c=relaxed/simple;
	bh=0I4VJgU/rNx9/1fVAQr8X5uDNHkBZ6oOdKTp1UGw7hY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4Lquzaq16tS7/zoLdsJ3B8NtZtTMTAdW8vYSzKWLxfprtVGTCd4B1OkdpndLRx//TRxxjrtlJsG8C9PIQHXbdT557+JHbPmft9BjBu4ugX9gSbs41kbnImxftaF3lVXYXC92vrnEuTH+wY/4W09gbqAH9edpAr58nnk2Vjl20Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEKwp1Ys; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719227966; x=1750763966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0I4VJgU/rNx9/1fVAQr8X5uDNHkBZ6oOdKTp1UGw7hY=;
  b=mEKwp1Ys/1+2Ei6Fe5f2p3XtIPZdOh6//vZ6aM93useVEVrDQZWOsfUS
   d0KG7DwNHb/EIBuwb1XtuP543/sbRDbFdPphKxURNhvhAIdCo7QGY9wb7
   PQndsvXgCdD+Dsw4pWuMdYV0UzHUXqwh3wKKTWrUAt2pMr0fwcvgAtbOJ
   VVwpy2MkeP+iMP0DZvXQ1lal1YYhZKxfy0jMtGCJB4GxDQKZbe8q/Fu0r
   4AbgqfLhHYfSW4QG9jTlMmXtl86nxo0mqBOPOG4kD5hI9vf7RtVzIsuCJ
   0Faw4mAhv/xHxnMQYuo4HscTOlEkCgIKW1aD4aCS0R0z09FxEKGGX2dms
   w==;
X-CSE-ConnectionGUID: jPJMX4euRVicyvWj+0IbrA==
X-CSE-MsgGUID: lxDmdhGKQBOGBlH+lpS8GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16017582"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16017582"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 04:19:25 -0700
X-CSE-ConnectionGUID: E6gv8R1pTEyG8iWUYgGRaw==
X-CSE-MsgGUID: F4dWp0cxQXWf7al2EIOrbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47726051"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 04:19:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 04:19:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 04:19:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 04:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl+Xf8ftSdj1iLPMYxsuyC+xWNCxb8g8Cn+yug/tE+jQkG7JmVN3rkRIOsYvKdMR84xeIkwIObS4S3M+AGqbKvwl2v9s0tFkpBUTvm+S0EOZ46BkjQ/WPjo847lYCsBgj2haIqdjtskvqkzvFARc5hNhuX518j6dT2uuQjlHCC2uv4y6bvjxCLgLjNBwueH4SClO+vNakGSLbgNwh6tMMegCya4Nx9HrkNG6YTmrilOW56JdwvsWFO/y7IsmVWSh+JkOs0az5apdhzqdSRrH59oHQy8uMwN0xUadwbU+kmFbSxrNyj91rYQCHbWU3VS//vjgF0vzENlLuCapWd4Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzCMs6BxfIg9ILgM6BK2TZIHO73YxvTsuVl2KPY+LXY=;
 b=DHyVMhMH1oviAjEhELwd4jGbcHRuk3yeO6iSsFJCykPYeraLaBrJYHm26ASwrHdHzB3wsU76NgEpQdK0nBH/mdXt8nbuf0JdJbGjXWyIjSdN8IogwT4CG7XAGhPQHt5CrlD0DhoZdvkBGtAt72OY2BasqQxfz6MOM+SRVb0pw8Hu5IgtUUJe9exZDUSlFnNyOmfPGYi9X0M4386Nh9lXmA/Y54D+AIQRywM1fKXzkBc5hcrrH9y7itqnivdFW4EboPws84e2ll+lph/SX2UJ5qBjV93Ms/QtiZscvV8ub+jJWZlwlT1wTvGpJoJkzw9JakM628SEdlK6xGxkHn/FbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 11:19:21 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 11:19:21 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH v2 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Topic: [PATCH v2 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Index: AQHaxdfutTo4IZ2RMEK7tt+kRabj87HWj3wAgAA09gA=
Date: Mon, 24 Jun 2024 11:19:21 +0000
Message-ID: <MW5PR11MB5787EA881FCE932CCCE0ABCA8DD42@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
 <20240624014223.4171341-3-wentong.wu@intel.com>
 <ZnkpTmeuHI53xrmf@kekkonen.localdomain>
In-Reply-To: <ZnkpTmeuHI53xrmf@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|IA1PR11MB6538:EE_
x-ms-office365-filtering-correlation-id: fe3f39ce-1d37-45c8-dfd1-08dc943f7f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?GlnGz2M6TjC8esS5vFheYrYEolgEsMbUKxEqE7O43MgL2w4LsnXqRZLkWyYG?=
 =?us-ascii?Q?hwvAde1USnn4CTKa4Llo1gXW+J24mTD3sslNAbYTUjt7CwkZV9r1obJGHp64?=
 =?us-ascii?Q?D7Iver/gOCNvDX59TGuCWZ7DZDTsba4OVKR73pUEWHdWO51WV1jw5vSfLYE9?=
 =?us-ascii?Q?/Pcq9gIsIFNnOvb0d49KhqZYXmu/Xymz22NDFU4WuqpFl2PKJJCetBkK0yRb?=
 =?us-ascii?Q?Cscdk/wkj+lXnD8txSk3gZdL5OjZpRcilIdBoupYx5FXhEEARykXtjTGy5C/?=
 =?us-ascii?Q?lp0+5f6yTm9SQ7ut3Sh+mpcd47z723J2QgjwEydz+6qpF+ffGTS0l9QnzQun?=
 =?us-ascii?Q?YJZWosqGcQl4qyrpd0VxugM09LaIaaluzDTV94EbwidvT4EKJjjJAKj21a7v?=
 =?us-ascii?Q?IVhXaA54UeeGYre3agFyDTMk1yXuzWTrEey2xhGjdbN1KtnJCkraznjqm4W5?=
 =?us-ascii?Q?wnJu6Ku/3uhb7i7ede7+bvaQX/MycN5DXVoOoNbOSI+C5G1t2pH+C2GFKAPI?=
 =?us-ascii?Q?Pdaw20p0AH6tKGCWuSPYy+8Gcb6Pwu103Cjv7wrA0R9aIshqvp9tqsl5Wf4R?=
 =?us-ascii?Q?vN/HYfho/Yg+Im3yDK2kiHmf3aDsIBjK2UIMLGcZ4RRnh0ksgsYTA2zY+GGb?=
 =?us-ascii?Q?FftTCLwqFgNlTBqKd8IeC03Wewe1xVFALcgTlo7RB6ivQMpN/7nj+EQvM+XB?=
 =?us-ascii?Q?VVshYM51T/qIUJ9KUH2Zl/eCms8vra31gstNaCxeVuBakvVgxOEOl371TLU+?=
 =?us-ascii?Q?O1rhCnS1zdxzoKs1oWn8V+Zg7dolFMBzztt3rRNqF3ChYREN7l+hG2X8SA+2?=
 =?us-ascii?Q?FXRHI5k/EvbNGGi7lRm1CSq1wuMuR4imoy/wAluoP1/4zfLVobKn5NX6e/Lx?=
 =?us-ascii?Q?vkti545GqJGN1jkvhe91K711uUlOPBvfqNuGxwpbfrIo+FUzbUb3sElVOydm?=
 =?us-ascii?Q?vys5hTXkm0o2JDOjZ1GpgAFm4WKe+i2uOCSC9woiCIXfLguyVgeKYrfUtbI3?=
 =?us-ascii?Q?Tf2D5eJSnLNHcUvH2x/NVrhavzvV3BX0NklYEu8o1kBI01K7NtTLz/SDhrAq?=
 =?us-ascii?Q?3tYndR6ArCW0wPODrToLzOZ9+sHHslWOgaf8mqzFVuAb0yxNI1HN0gx/oREm?=
 =?us-ascii?Q?Vc5uQEfgiPydCvt/tFLiRTJM0KoYEljtOX1CQryMwQx9ZBDfqn6aKoFjvpXk?=
 =?us-ascii?Q?fsZRUYKOCdkAF3W/k4SHE3SjVpErEQVz5aCj7AIycuUreCbkFdSG8UJqVSbO?=
 =?us-ascii?Q?Zmy77s+qhs2aj7J/TYkvv2XYZQYJnBXHBfuN1Yn894pgAGf7sZMQCVaGFxqB?=
 =?us-ascii?Q?bY1lQe2+fIkRY83u1n1oR70b9RQUm9aDMHJyo6/ns2dDygaz0eHTxRKaaa3k?=
 =?us-ascii?Q?zYc+GK4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WZl9TkpR+HZ0piTvwyuQBPUioC6OmAuD8p5YCK4gPMwuS+IO1LTlXyereW+Q?=
 =?us-ascii?Q?htZvNdUg68YaHlGapYeE4CAcg19hmUVyEx3isAoKa/AzZmGGRZ82frTtyPDO?=
 =?us-ascii?Q?ZTqhtu5RcXWcsPTC89DmLNTeAAbc8HcmTJDqOxtARVCtz9m68cuJO19UwlG5?=
 =?us-ascii?Q?vpKES7Ni8/7IMA/CAU9aSdkM+t3yAatx4Gscq4ifEsxrVLN/sBJ373fzsyIj?=
 =?us-ascii?Q?yH65wWGxX/z/8sYrnkKrF3NlA98jwUPdL6ats/ASi+SXT9IOOTn0gEgP/dCl?=
 =?us-ascii?Q?1jUoHOHi7Z/Mc5HpgCqpt6vjfPijexeILyRbB+dK+E5yE5u9pNSha93IufEi?=
 =?us-ascii?Q?/mh2BVvbNs13G7aE2g3Z/ICKI0oIGbFvjwWSEMJDdqcIYC7jocgMfnsZbtKl?=
 =?us-ascii?Q?zPEAziMB9YPOU+6hLtU3VR/5rjpOy2sm3w9m91U7s8tBtTDXPY7/ftTrIQHJ?=
 =?us-ascii?Q?/o5lRWgMgxZ8phDZXrF9EbAM9rMjINxiAEJR6aeye82gSNDpNlzvNq2kxRFt?=
 =?us-ascii?Q?cpJQ8t4bzkD3/IO1tk+CUsPPdmsyf1O5C/3FwgC73Ke/12zHOLlMd861yPsg?=
 =?us-ascii?Q?MphE+CdktVxOvTw00LfU8wHjJ+delA1i5wQjXiThwzwyfOxKOtgH51L5x3KI?=
 =?us-ascii?Q?l8EYLxwjuo2hhPms5X10OaHqZ726JwFuy+z89pl0HBm7896XrlhSWVc1Vkl4?=
 =?us-ascii?Q?ZAlja86PY4khUL0OeaQFFT0OkQsNSxbE5rwFw0kZaviocFMTtKoxl8IPe3xw?=
 =?us-ascii?Q?F09V8hTg5bVw0ruKpqwPAPuG8uoEyQibpeNtV8gNyTz2J0mXAsblkv0+l6fy?=
 =?us-ascii?Q?wxQcSX9f0DUp1bPZdZIaDRcISGeLj3k3Xgn6QKn5/a6HHjq/ryol/9cx/BzK?=
 =?us-ascii?Q?H80enEFwKDLC1v13AZz26nt9Gy+b6WSbrs7J/N1Q5yKw2kwdnGuvV8lPK56a?=
 =?us-ascii?Q?M50QbhLeMPSWOaWxetH9FdFiKlSv6MPrufB/G+AqDY976upMVGLVVH4vBPkK?=
 =?us-ascii?Q?u18brAQADxmPyLS+Wn6OGUGKZA7FK5eWI9fmi7jzyL6Wf12V8z8f/SkKTXc8?=
 =?us-ascii?Q?rXTchFDzKPxv92sYPjdGq0jXAnoeHLw+uDIxCFNlgHPc6WJ9H+54jiVjW5zu?=
 =?us-ascii?Q?RhorpszzuoTFXgPPdnp33fIT6D7KzWgQfuYs6sldDuepocEgpTXFGu02kJ3Z?=
 =?us-ascii?Q?4cX3yhH8h+y8XSTL3BEgNKiLOHYE6c9QgvvAaLXFfxwvglDy6oHJAFb1dBif?=
 =?us-ascii?Q?zg/Z54RkPESFicnzo1+yKgP0EAYcVhZ1BGW9eG70p/wVMkQ83sfCaJbDW5Nd?=
 =?us-ascii?Q?e7PcRl0IPA1kfzWOZGh2O6OG7qnRKyxo48dIlL8iWm7JsF+SKjVI4fi/2Zns?=
 =?us-ascii?Q?b0Kw+scbZgJbuyX0fnIuqh/OLxSQnkIevdqSen9EDP7yYMB3uVGjFw9MPlGs?=
 =?us-ascii?Q?E5peTW2VcIvIwIilWNhsetB2ruZvDbroriF5tTELVyaD4XBXcnUgESK/jHS3?=
 =?us-ascii?Q?L4d876nvS6/k57nupeKlorndQ9YegP1v3rF01syvS3YQoNB56MFcpMtqE/RD?=
 =?us-ascii?Q?9mlNx4KM8QyYTzaKniTFLvMv55cdW0/X0ljxBPRe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3f39ce-1d37-45c8-dfd1-08dc943f7f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 11:19:21.8104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcXKSwwYUOSNddN0V/wC5cBM/e0kq6GgCrSVc6OTJ6sru/C5BxIv4Af5erRcCKZwzcCC5jk9g0NmzG/Em1sXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Hi Wentong,
>=20
> On Mon, Jun 24, 2024 at 09:42:20AM +0800, Wentong Wu wrote:
> > Constructing the SPI transfer command as per the specific request.
> >
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Cc: stable@vger.kernel.org # for 6.8+
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Tested-by: Jason Chen <jason.z.chen@intel.com>
> > ---
> >  drivers/misc/mei/vsc-tp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > index 5f3195636e53..fed156919fda 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void
> *obuf, void *ibuf, size_t len)
> >  		return ret;
> >  	}
> >
> > -	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> > +	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf,
> > +len);
>=20
> The latter ibuf should be NULL explicitly.

Ack, thanks, that will be fixed in v3 patch set.

BR,
Wentong
>=20
> >  	if (ret)
> >  		return ret;
> >
>=20
> --
> Kind regards,
>=20
> Sakari Ailus

