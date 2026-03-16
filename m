Return-Path: <stable+bounces-225492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAwDIX1Yt2nQQAEAu9opvQ
	(envelope-from <stable+bounces-225492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 02:10:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3129349E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 02:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A7B301015D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58519A288;
	Mon, 16 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWHLsV6T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCD83A14;
	Mon, 16 Mar 2026 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773623416; cv=fail; b=PWPL3dn4qqjYtXQ1Z5IkN36nobomj0UJt9V77kDPrnikkVR5LWVczcTWGA3+0CsoqQlnMKzsqDmo1tk8uWXihaQTNlTnaPa1EcOAjyY7CEhAfJPlh0dHY3D3wPZlIegVILPshTTpb4tFghStAaGhkThe6QgijRg/J0bzaFuXWfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773623416; c=relaxed/simple;
	bh=oRZcFcfd7ygPPQHSac6XqSqwtkPObxDB0S9E9sL6p24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYnp6oEWX09/Q6mf+zn6IFyx4O1rx4gOd+hL1/Pya5R7C7GLTMh4td0S7LTB8tZI5smytHQObFiP3StOxIVn4VyCrbPwkySZeW6anbT4jg9IDR8X1MZsFclCTAN7iuoeB6feIWRs3/qmR5qHoKbkeYhVR6CRtn8O++VWP+XLZus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWHLsV6T; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773623416; x=1805159416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oRZcFcfd7ygPPQHSac6XqSqwtkPObxDB0S9E9sL6p24=;
  b=BWHLsV6T9utwTuG54KxVW/YOaip2767P6i/gc6ks+slyODTnBMj2ws9X
   XCLQH+MS6+Qe+TilaJNMyGivomFO9s3tYnc98FsFpSbsvR3wqItn2C/H3
   CnaH/yUp6h2y2nPiW/wh9UqyCnNIQ+QYQ/yNpXvvqunrUWPJuXZlvtE9y
   7tpX/AvCY1y8Wj5Bg8la91MxtwbtjxJ9b6I2zt27CvZfPRQri2iW7kWyZ
   Qd3wGj3+7q+JX4fOHYMAufo6OWiAIV57QqzADSJBhtK7n8LC/hF/HJ8Du
   q/mHDepMc/C731RH2UQTUvpt+itzvtNH231aCLjiN79QYx6euDuQnjRRL
   g==;
X-CSE-ConnectionGUID: Zym6qM5/RSaWYa5F8a2wTw==
X-CSE-MsgGUID: N1eTBWu4Sv+WSgaLklszCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74825237"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74825237"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 18:10:15 -0700
X-CSE-ConnectionGUID: c/NRRlQVRHWca6eua9/Utw==
X-CSE-MsgGUID: apDnR2piSxiWqfe8J6/V+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="221706245"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 18:10:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 18:10:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 18:10:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 18:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofLVk13L1He+bU151/xTCHZBKYJsjTOFp3m/sI9KnwKX7QBx8tRbz+SAq5F5TPVBCO8HIIxbmuNkmemZeGdOdi7r2ieivjQOJesX3YIjI4hAVPudzRdGo8iAn5ORvwJ4Y7ZFuhzh9ZT7VtUUShSUGQ2JG2evdYlw9+jqmzDwjtAFzBH3D7nL0RWNocHecdRq4qUkSKpaOz0i+4hKB3Mz5jIREtZ3Q3dE7SjDwAeKGEe0tacBS4ESEKFa5duyu9GVUrYXUvdbedGjfso1pkV18K5n6VmW1HuxwWgC4HaYFwU6Nhv5zYt5TPsJuUyl8loeI+041toGdwsbx5dV3CcpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRZcFcfd7ygPPQHSac6XqSqwtkPObxDB0S9E9sL6p24=;
 b=naSuCWjovrgGKt/Gid6IpQyCN9CuEaQbeXkJTa9rq81rhbe2LMMxV/bz3gJCNVf3Q4u5uypDjSiZS/yBKo3qPhrnDr+18S7g7dZ8qZwXN3FsRjxUaABsm1HGDN7GWQDWyj4ftdez/vG+hslgU2ZgJLvc0QJlt3Kya/h89N3x/SP04dXupHaaFyIvSXGOFYn4bkjG4zza4cSdbkb8hoz6nUaBVJvml8pL0ELe9AYRF0uwO0DtXgD2KNuN5ClJ02bB0PVBFhlCaCQYA9Zq5oEHUO3+lkvGChrG1He7o23/y/ABb8Gh+GG4lqoYFGq8GRbaKt4A0+rj+rSJnmpSveky6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 01:10:06 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 01:10:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is
 supported
Thread-Topic: [PATCH 1/1] iommu/vt-d: Only handle IOPF for SVA when PRI is
 supported
Thread-Index: AQHcsGOtw7s/8TWEo0iS768ZRLcbCrWwYl/w
Date: Mon, 16 Mar 2026 01:10:06 +0000
Message-ID: <BL1PR11MB527196268E156193385D104C8C40A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260310075520.295104-1-baolu.lu@linux.intel.com>
In-Reply-To: <20260310075520.295104-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS0PR11MB7310:EE_
x-ms-office365-filtering-correlation-id: b11eccb7-619a-49d8-38fb-08de82f8c2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: gtE1ZGTyH5eew1HeZ7vKBwS7+1gn4vHWLo0xpi6FY1MC5P9NW9zq32jn79jGg89p+/X0Q6ZEjNC26xqcn1CCCkOaoJDU2t65EWaU7q1gMHZwbiVBGc5h+d7PEOLfA4RZWimbRPT8bY4TOJk6ljKMXMFbC//x39lFdzUUzXdzzUST4EnCqAy1PPVWJi/AyzjuvIZQu2QEvKvyQ5XT4dOPB62RgEhP1Wh+35ocHuAXFSdfUJOZ3NIXCypNoIqoovnEAfiWo6kxNW61HymNMKoUAL5OdpDlYf8E9eNjwZOAcGa7brgJW2CIapUPzcVh5lFH2rNZ5RJfTdJ4iapcsj1a48BVSztkVjb+m96jlwEiSQQpgRki2IAWXmkAXaVL0l8JFbOiupHuQKVYaQllhmxdQ113QnJqI3cIaRqD69ytx0bxRlL+fF4YSWK9bc/IUcfOyRcrhiiCV5hCZewaIGUiNss5vHebddQ2JsWHxeCnuQfkQeSVb9afOobjYnBcZ+o39o0KOjyZOBLx2+P14wAg4okoki7nuUjFa2hg12B5J62Ufi2RF2Wk5Sjrba2NUmFUSmiqadTnnA0EBtqgxMyKlxWkERTmOFcIlp0Z80DZkZqqjYrPfs3YhU4griEYl8v/y+NDdNrxeRwQbr+iHWHT4bcgM38Gjlp9CbWNVfXaCC1D3krU4iFdoli++A3XYbtqRbc6ZhE7GfsfYDaNhTJh5+cFUxsmKBSDKOAyP85varZakqgSSPWsAIO/+q0W/5a0b5fVAdd7p5XLcy4XA40yhIOTRMQbtIpRINGhIrk8jsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TVYd6bGIIqp1OrkXNAiZuuLxhwNJYdNYuiMxYto0p3pDSiV/eyyOzCNoqvgj?=
 =?us-ascii?Q?o0LSH24/vWQ74JMBA8xKeHLlEnbKaIK4BEBW4qdgcgAXWz3i+g+/xz0wZ+ma?=
 =?us-ascii?Q?t6nD3zGECvWuqN4hIATbgHLn62Vgap1J57x1WIQQlA2Oc0KOuS2a2CkB5Qpm?=
 =?us-ascii?Q?/Sc+v1RmsfoHYBYszo3PiqbAwx7ctf/JpiO7PO31gmaz/Uwao9mysABmCCps?=
 =?us-ascii?Q?4AiqXSAG8IlzDDzdlyLBANyHJbHnX9sD7F/hAqiHmZvUpcbfMG+mnh+qXXWI?=
 =?us-ascii?Q?TnN+yltRfs5PfyB5TymxcZhekhMWL7obDJj5esEgytDId3tVvKGS5Iw8ef6q?=
 =?us-ascii?Q?9wqqIuYRTgZGyDEYTaXfcWVJU33DWfLve0cnWY5R6idTspP1arvJxj842wEJ?=
 =?us-ascii?Q?uVWnC1NGSdWnai4CW4RARIiUF+PPlQzHU7V/0M6plyFC9SbQv23hsgrmWEvP?=
 =?us-ascii?Q?sENqKTO7jNzinwHCHYmCQ87BFy1m0DohfP33esmwX2tyU+r5nA8xEB9Xe/Wl?=
 =?us-ascii?Q?ThIPivQdXfG4yapUIHCd9DnrZu5GaHDG7qhZsssfx0E8fys4wZ2blxMM9ugM?=
 =?us-ascii?Q?W6neJAYn0vDG7lag3lD6+6IAH/JTW8r5XNAtvjdGBVtgSNYA9D742CLydue3?=
 =?us-ascii?Q?4keMyMhh7fbZZSu3ZDMkYzRHf9I/RUTyx7JxyuZkpb5xkB8H+F31r2hKmCu7?=
 =?us-ascii?Q?aOpzRU8bjpR/U9Hw6IQEIG0h2Un2/7jOxkwV8kPuz/pu1D9kjdD4egBa6ZiK?=
 =?us-ascii?Q?/adWnX3aj2WpyuwqdqrNBDnMEgU4dWWwLU4YkFckAQL0oogl6koBqwbJNwap?=
 =?us-ascii?Q?kHVQQXJ8vsEupCP2BAwp72oXDmFIjnWXlGKKYZOy4SpFmHthBKkYqmZpY4xA?=
 =?us-ascii?Q?KuOIL9cXSJvqEBAbJ4akU6Q17WEcZBeshMHyO6N7U5iCaxgcUoRMdG3kw2qc?=
 =?us-ascii?Q?roVXbzijw7j3qMRL45PeeRFaj06G+neohXJHCq8EjbdpYO1JjDytgJafgA85?=
 =?us-ascii?Q?Px/s/n4TPuxHP+fKWpWNv6wFfnNmfrIGddRk9Qz1EMsQeLPKASw5HMC3Xcfs?=
 =?us-ascii?Q?PP3tOCSgrMnCWmaeUKzL0U+gjzyQa+1VKzIX2SYDwRqpgYqw1WE9xbppJ/rw?=
 =?us-ascii?Q?qi4DxNgbK/lHYlJb9yffpycKDFo3XE67hxDMQNj8uhGXwadNGbmvdSAKp685?=
 =?us-ascii?Q?Ur18dzkGEyuphkm0o1SVvIH4mTX/lMEwGfePzbeDDF9xzHW1KW2W2r7cPc2p?=
 =?us-ascii?Q?WH50vrqklB3lY8lMNibrn8q+XA7KmTBLOtyt0eOuX+7z4slHYKyxn/vMpQ58?=
 =?us-ascii?Q?q146YVgQoIjCAE3z5VBreJkrTh0kFUjGCO+ZxZA8kVOelLttHOdS2jjTS/7c?=
 =?us-ascii?Q?A66U5vUYUbPuXULLQRr6hwonCUaaYJVWxNSqpMrbDlmgFe98w+JCZcWxVQ/m?=
 =?us-ascii?Q?uRvphM+jjR5N450blmBTdhRHt0mRMIPCmyH2I3nIi+QbZaXabBirb8Cc8ppf?=
 =?us-ascii?Q?ERhMy25ZQ1nLqJkJQutR3dOoZo5o34fazGuh1X4pewYdEfBR2ArDcpoz3Yib?=
 =?us-ascii?Q?il3Ws2MtktonWdbETu1hz2/QUDhbdgNxAFK5RCgAtvKFnAck+DgpB3GIjqbr?=
 =?us-ascii?Q?SHhLbcVdxqQBq45RQLcjhx0VNIR07Airj+XZA+dN3tQCyeHivYkUrQzsJrCB?=
 =?us-ascii?Q?2wtsPMnJ9Y0V10CPzYaqPUSX7sXYnx+xVJAjRrKTKKnkJEMj/mpWASAaD8Ix?=
 =?us-ascii?Q?dfy0yMBxCQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LImN3MlrR8V+BL/49K6nvkmT2/oDaVgPlj4qIxjlONx26m+2JUl1rT/i+SBLWILJDvAq2CtP3WF8EsZNNh/Vz638P2Qjbd/WYb6XBg/gTYPRpiz1k4L/HfQSshru2L90R/gERl26hY/05A8U6Sjm67FAVQuf/b9GhJKwuoYwBjJZ4kfTqqlPk1xD8Tc9hAKaQ+hNQwfdAtsXBaLwA5g9IDYrQ3lJnZkovTaNf0TB56NJHl/WeVZSh3t9ripQo13DPwB8ZmiEVmYzNJNiVYFYxW+CxI5p1Uu2zSOKxTwhv5oqqJwuJg2XHz1vw+qGSpQ/xgmSedHD+rEtW3bEJOV+Kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11eccb7-619a-49d8-38fb-08de82f8c2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 01:10:06.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g++1zN70RMhLV6H1B9/ydDlsxy1N7G+fc3UG+QGj48DZvlQbM+FHLSgDp+rPYhyIAYHVIBLsZT7v6W5otYODlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BL1PR11MB5271.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E1E3129349E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, March 10, 2026 3:55 PM
>=20
> In intel_svm_set_dev_pasid(), the driver unconditionally manages the IOPF
> handling during a domain transition. However, commit a86fb7717320
> ("iommu/vt-d: Allow SVA with device-specific IOPF") introduced support fo=
r
> SVA on devices that handle page faults internally without utilizing the
> PCI PRI. On such devices, the IOMMU-side IOPF infrastructure is not
> required. Calling iopf_for_domain_replace() on these devices is incorrect
> and can lead to unexpected failures during PASID attachment or unwinding.
>=20
> Add a check for info->pri_supported to ensure that the IOPF queue logic
> is only invoked for devices that actually rely on the IOMMU's PRI-based
> fault handling.
>=20
> Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach
> path")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

