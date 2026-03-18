Return-Path: <stable+bounces-227104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH0AIJzHumlobwIAu9opvQ
	(envelope-from <stable+bounces-227104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:41:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256972BE712
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0083B30117D9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1813C1981;
	Wed, 18 Mar 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKhu9+SX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282F3A3E80;
	Wed, 18 Mar 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848402; cv=fail; b=tNB1JtFvDs+tSo+oWEJK7hszdjNnkk9jioF8dKMysZb8ClkKl9eEL/aQN5FE4tBKRJeA1eOQYd5DY35PblVcLLV3obcTB6OH0F60z/yUMZnUS1rrJGXn0Z5wCcHQZLV3qDDdS1er8ulVdeCr1wLiRhno/txbLBZg1wayQgSXhww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848402; c=relaxed/simple;
	bh=OQ5RS0BI3+mw1lTGnDPd9N2LzMnQiBWLl0/smE+qgdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GnDBYkETb6d4IQBAkCbdnREvkxgqOGrg5aJRQ0Mg3r7GIWPGoECUvqygL1SgvUy/v4PBVyrd7HYSZ3aL0I+tQhSSaf1SQ7ziku0ZZ5uLpt2qtDO94/Zr5kjeV0lGYWKbNUY+ZhnDPLXPMj+WO8hhPOesbZx3IREpO8dE8ofQrC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKhu9+SX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848397; x=1805384397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OQ5RS0BI3+mw1lTGnDPd9N2LzMnQiBWLl0/smE+qgdE=;
  b=DKhu9+SX4+1rH9IcSu/kkJj8LG00oVvfnIBZXGeNye4YJdQtZ5sDkjFS
   /vwJXC4M82F8N8a4p7mlFzw0DHrFB6zRERIKm5HVO16N+T9KhWt0SnGks
   sFXeYsINVQFfontkMjHDapYxLIigkkQkb7OtuIR9iBnNz9Ssc2bd5Ej2H
   6BBXCogVoIxHlK/7dje0+VNaUyAo/aKxVgGJ1PQ31o4qxxtmH4pN9wIlO
   7OtpDfbVUfIMYO3/H/RMz+NENfQgxYE80Bw5Y73zQ2Ax+0jfJ7CttMxMW
   CP7ddLqnBlyVwDpdmx6wGkJIuRbNRxLEgwrW2/cklgs+6cLPs/SYEmWug
   Q==;
X-CSE-ConnectionGUID: Uwhf+LE6QUG5d/SBWKYRug==
X-CSE-MsgGUID: 91djg/NYSJ2CgC+VGKPDMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74982680"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74982680"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:55 -0700
X-CSE-ConnectionGUID: coyraQ8mScq1in01RHsMiw==
X-CSE-MsgGUID: 5G/Em3SoR2q9sp9QHErjMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221742407"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:39:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcj3bH7P9YXnY8UKA/Hs/xpPUZEdqAiw0UFURF/mMMMxH9JLfUYpgZLXxAScpkwgqKjlIy9EFKFdyELIpw0CZUVGAJBoEyybO8a+I0Kmmeqlah+Cg8+W6+YCjwvTem3lDFFGos0ELEs0MhxrBMq7zD3j/4ZQtD9bgWrIdYQb3aYX6A/1QwycZEUbBAdwcIBvtFIKk1sHG37gJXwHwYN4ajtjXmtcCO84HNSaQBSVAAGFJyZq1wPeRuaWCUjIJQcSDOAtJxIiE3CDXItOGd1ICtQLxhZXDjGUsEVdiAD/xFDilk2bR9h+pSR6kvMJOuUpB3u7ky5hAR3jLoxiahtXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfF2DyfbMm4p+nn7aXSOwt3q9lNKiMxR2vqWJi4Bkhw=;
 b=e/0VGL/aNKecGOrSd88sZr2I9IMVGroOz5fwbeb507gQeyhKN0npITBUeGLlccX3zaeN98CmVFgaxLCDdy/zXHrr3Fl+loNbS+wgxvRORc96YUu71AYACHLvL7UgQIl3O6RQ4jUyyNpEM2XWdv/WEr9D/ETdivcsDxnWYYjTngR4uwuRyLoKXJUpireA2zuQlURZGXfcczDZzcAWFYpEx/7wpXUBfnZrycWWXRlFJXugJ4wYuCY2uHotDcQa8/UpVPcLynNuX2D7AWfcbAEOLNUAzRZguTZ1ZN2xJ0nX7VT3E1UNDnzEa4ZQzOctOa/G3mvS3xBqxibyrT8IfnRDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 15:39:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:39:51 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] ice: fix double free in
 ice_sf_eth_activate() error path
Thread-Topic: [Intel-wired-lan] [PATCH] ice: fix double free in
 ice_sf_eth_activate() error path
Thread-Index: AQHctumHXwZh//vNKE6uvvoG7VQu3LW0bQXw
Date: Wed, 18 Mar 2026 15:39:51 +0000
Message-ID: <IA3PR11MB89865884A2D07CD9F311077BE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318151028.634828-1-lgs201920130244@gmail.com>
In-Reply-To: <20260318151028.634828-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: ade64800-4bda-4792-57f6-08de85049816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: 6IPDPf8G5dxux0+SXRHaBd82wb3o1rR13wPzs+4lOFOGKnNNZ6Rcey1j4P1K73f4ZnOmoAj4tTjhWv0N3sB8ds30RWFMQqr0BsCsOEit/KGm+nwYDyerXsyy1lebYT1sqBRz3vVcNKUe0zFNfCFmCR9PYmvo4wz9n/5Ixir5oJPJpPa5QSW99E+47ejkaaJgNRMywPMkNeACyc2m5cOkyone3nXo0vPqKjxRA2f120DYVpBbawfNRIT2jlXAZMT8HUzvExtGD0X+e4Bo3A7I9W0RgnghHTdBhqOv0AO3g+RRfrNjhyt4QRzrFJLYhmfWshYvfVAuFlTUdZ2zgQNFNhOYoUUVGXylC1Ca4GlD5pKIExvXLMTdxYYOCOcqgv6RULtIAb/C3Obs16iV+ImlzGuwUyVLrYDxH0wZEbDrz26TyLlhTUshQUu4TM8yzVAczs4mDvXgTzar/9i9eijjGgdy5IMXTLgdUnPlvxOb4ZvVxLKaixSs2z+wHbp6dYMr5ByseQjtliMbfvj6eEKAqQPbBhKIhyhxeZB1spLXvH1NH6cixu+VB/ATd/1QayHmDsaUz1D/XTey+lhoLYAUqZ0tOvJXVIwZklGsOzQWE1bOFRHzENClaWtTMXYynLSp3LfW8FHUPFvM1hxGjvB8zhLXr2f2hKkVGaBlyaQlRMz5EoArDtXNKbu0GeQR/MdMKgeLIwG1RjUGSEDS5yJjO5RG+Zr5FiiGCgBe5t4f2sw+x/jW0W7YGjJ9/+4ySLtVMe4kpoF9k99Te9t/PWmQ5auQ/UXkHMRSw2z4kF6G6ASuYNsvIo/88jc3+w20iHx6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BomweA/wwASJgiDkGS9cGcCOMk/ujAgFLrLWE48ZMad0Hu5i0fH4wACLnnuP?=
 =?us-ascii?Q?BIPLot3V96TqUyQUEV1SdYDK7v85P3+KFM0kN4dbiSM0o5LyEUAe8Sl9nxxK?=
 =?us-ascii?Q?ugf2fmQXF2RkJ5RUDu8u6Ua5SiWBDopfppJm0byiQBp4L08v1pOh7Fw5cjbx?=
 =?us-ascii?Q?NnieOqAQ9fEPzWIgb96E55Y6IWEkYiAAk3ug6u4eUNQtJE2WhtR9lF/G5GX+?=
 =?us-ascii?Q?WjXJYm7L62cT3xuSTxtVWeDzfKft/f5TghHWXiZMsggYE6oiBhS44titIVl0?=
 =?us-ascii?Q?YiOaJGTpJbzDlqTaekdzF2bEILt97kWYN8HV5MT8Cpzv8+Ym/aEMvI59AqLV?=
 =?us-ascii?Q?2KffKz5rGHkokKMJXfLOCj9ENgYulhDfjl341UZL+Qux2wp4HQaQblk9KSz3?=
 =?us-ascii?Q?wlkGtlaIBttjGS3TQamUD1ZIhhObf8m5YKo4Y/SPyae6V5nxA1aUKy/kOHCt?=
 =?us-ascii?Q?V9rMJdamNeTGdoilWznIiBvUNJWTg00xxDqrvCPubHPnD/T+a1KE4kVlATk0?=
 =?us-ascii?Q?7KX0EeH1Q1okNmLWAAjpG8k+QhK84+1LN1+EYUT3YXaKIMwI+Vxo4Dm8+lrP?=
 =?us-ascii?Q?Hlc8KN7vhBmkAA70jFgxpP4+oKGebA1INpWjYbdeXsY0LZckqMp0UFBEZB6N?=
 =?us-ascii?Q?s7BlelJySjn2QsVwkYL+AN2Mtsqol/sTeJs5GE/Y8F7kp4k/yfy4IT9FDa71?=
 =?us-ascii?Q?h7XkZnxJhbEKIA36H9P9J7sS5LfbYSKopcydFr1/O9CLlwFQyNOpP04kS0OV?=
 =?us-ascii?Q?1nAno53p0nkDRpTQXxP1IjBSmI0JzMCKSf2X59ove0/Za7IhQRab5pGqnQxj?=
 =?us-ascii?Q?c92z174ONKc4ljtgkEddZ7nUaBvICNGj57pYuChrW7IRpVBgdW4ge1N6E3ne?=
 =?us-ascii?Q?BD7tw5BZRVLlGXoLnRZHaR48OWQSKtBjTpxckexhAF8PczqZrPPyc7tWZYI1?=
 =?us-ascii?Q?l/T9araQPwcZ6yjicH4mDqgxtvbaH2eSIuKYGJyawmMBdJTxLPNf6HKh9LjP?=
 =?us-ascii?Q?yDzT0VfsS11Nn5o1vIYNbCMVazo59F8zJq+1RVKcRCCu5T6WdVWr36R5MMR+?=
 =?us-ascii?Q?1ApJfP7e7kuBOXJ8flGNDKJfjyig/Gzs3nv/q0smjb/sfoD47wtqZgUKjqSy?=
 =?us-ascii?Q?QYoQ1YvSU5sgFBLI0adrenQB8kN0Mn1iuL2fg7VbsvB47pC5d4ycFOH7Hs0y?=
 =?us-ascii?Q?m0I4MgrD+7CpCTeOtvJ3Lw3QCnMB7w4+dkIuE64twyKzt/1C6bGn3Dv5Mx89?=
 =?us-ascii?Q?nwFCII07hMDshfpL7AHDCs/r31/czF5xjIT8x0g/Cx6Ox6IgF64lobGu9PNg?=
 =?us-ascii?Q?fs9UbMZ3Ifuaed9fR3OwcZqXg6ZZHt+IbScpMvxvEldm7UXmcw/pH5mMHz+M?=
 =?us-ascii?Q?1n3kv9ByZ0187E0mUkSHQbt2wG7M6f5BZ/Wa6u4WzWeFb5SaSvzDtXOofN+Y?=
 =?us-ascii?Q?e/9aPmeCrfZytNiU8Gb5P1yF5zmKoGOg7YnKhtuKbqUqwsQ9SltGFx3xaR6Z?=
 =?us-ascii?Q?y3pgpftULNOWWeh4Dvi0Zm3Eeo28oRmBa4sJK4kJdIQaOCCqehqx58LTQPp9?=
 =?us-ascii?Q?6b7j0OefcgoKxPs9dckrDe8cepGTtNenht3lR9Xy5MbR8FfIFQO/bB2xNM0K?=
 =?us-ascii?Q?ggL5fA4C/1Gn39bL8Nvey+qpB+5adOTONyi5oHM6cbQfdYi+mzO+19pUYbaf?=
 =?us-ascii?Q?csIJx4qE4NqmplFMtFNXiX+vfkWwW52L0BQbLePvYosDrAkwp+VpRd3HgJED?=
 =?us-ascii?Q?8IWwJfNAqPCIHl2hAkAWl8CBvl59sWk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hJW2gBwwGDoIUwOqlUCq35c9Kb/RLwTZEq1v2Pnzhr15RlgG8f0JeRcf98+f8JUxvXvUZKRqhF3LQDkZFyOARUTELYLrUD6tpxDmxF8YLYtH4SEqWn3YLy206465jn8w8qdyWG+hkUQbIUXKv79u2Ykole3HRklVNtMK7ygKvUeleeklTwrJXlzmoTSawRNQWKBRgUzQ2/ebpSTr1pWZbO8b+lFVCI/NGuBWXSoPwdtlj81xLnf2AMxWLNKg9mxDZQGCwn4xiPdgY6Q7RhaFNAbRc2RyfnLSIpbMtc/0Z/vZMMT5MfJ43BBrdBbYcJZlOWLH1rr0OpACoCRvH+EB6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade64800-4bda-4792-57f6-08de85049816
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:39:51.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqHUu1fWffH2B3+ezMMzGvVaG1TfAcGyn6blpVET/FIcekIvpFrSFuN2A+YD38xqYvjqT53NP6hhW0zdEmtyM4FR1w9MSBiKiTc5P2VhqVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227104-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.980];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 256972BE712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Guangshuo Li
> Sent: Wednesday, March 18, 2026 4:10 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Michal
> Swiatkowski <michal.swiatkowski@linux.intel.com>; Piotr Raczynski
> <piotr.raczynski@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Guangshuo Li <lgs201920130244@gmail.com>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: fix double free in
> ice_sf_eth_activate() error path
>=20
> When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
> aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).
>=20
> The device release callback ice_sf_dev_release() frees sf_dev, but the
> current error path falls through to sf_dev_free and calls
> kfree(sf_dev) again, causing a double free.
>=20
> Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
> avoid falling through to sf_dev_free after auxiliary_device_uninit().
>=20
> Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink
> ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> index 1a2c94375ca7..ec6020338b9f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> @@ -305,6 +305,7 @@ ice_sf_eth_activate(struct ice_dynamic_port
> *dyn_port,
>=20
>  aux_dev_uninit:
>  	auxiliary_device_uninit(&sf_dev->adev);
> +	goto xa_erase;
>  sf_dev_free:
>  	kfree(sf_dev);
>  xa_erase:
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

