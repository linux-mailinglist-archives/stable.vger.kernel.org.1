Return-Path: <stable+bounces-161509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D35AFF73D
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 05:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6773AF5A7
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F327FD68;
	Thu, 10 Jul 2025 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOD+JcpR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029823B61D;
	Thu, 10 Jul 2025 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116546; cv=fail; b=WxMmNugtj5PYcY+mbNEHAz1oQ8URCV2zTS4W8C85pGaozCSc/jcqMlr/KYcFE+aM2XCHwfPu0i2YWoXKbBLXeRm4FJb9lnjgo9jFvOA7pLp2GV0Gx74hPVor2Mpa5GtSF8vCAbhYomMtV2X8ODE8QXjLGryxqNMkJJr26219DiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116546; c=relaxed/simple;
	bh=U9V2RvW3W/xWGtZhYcZRlu5TW8ZAnfSB6ubiZB95QTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6D8e/zJxRiih83Dc/jFwIWPRJE6ojNua9sBuuwq8FMsa9u6IPbSZBXUxqeq2ze3OMKsR+B8lvSGgdoNVrkRsciZiyjWa6QIJUwOBMm+kwUViwYvmg2M5cbdBpuAhdpOpescO1uSuRURi1154Vu6ZWw+iMrb6CJaSvm+LzBkTQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOD+JcpR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752116545; x=1783652545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U9V2RvW3W/xWGtZhYcZRlu5TW8ZAnfSB6ubiZB95QTA=;
  b=UOD+JcpRadQykwraxPdH0ZckgcGno2Qf2yzZk144qlXNGM1XYHJUVQO+
   hDeEh8M7QTaCODHpsmmutYlPpT39S4wR/a9VSwnCBAq/SJdx5/liNU1BX
   skxQ2PQVl2WaEYUu45D2ShbBVlkiWpXk8UIxhrkKyaBM7Ar4wzUk581st
   9DI2m08bPv0AIkwpFjqkp0yLZALef6B/Za7hf1KpRr9UBEFt6WMHLnHvn
   aXhydecdW3UmLt4g0oWfA5SshG//yRURTtQpoWSuHjB0ENcxrXUjl8B2C
   rgos16k9iDILXEOTNvHubYwf9e5pwnWrdaBKGHP/BUWWVsZUCdbQDWA7a
   Q==;
X-CSE-ConnectionGUID: YcXgNywjTYK+JzaUKzWniw==
X-CSE-MsgGUID: GpCeWcEKSTuFwS5Y/l7b4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58156431"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="58156431"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:02:14 -0700
X-CSE-ConnectionGUID: PrpZL3NFSyCImXX3zjVb+g==
X-CSE-MsgGUID: M2qAL/oFS/qD9vy2ZmhuLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="160233520"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:02:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:02:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 20:02:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:02:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My1Kj0NoDzuFC0OT9gkhEfgtunkDWdSbFJdBw5gveopuqBndIUX09BtYDy8Bp/cDjeQIeUjINwHYmDiWqlCRuRDJv4rgVOw++KzUBdkOjPEtNC87MT2Injdu2hjfxnuBuzirEBnbkzmLUwip5ArGrraNodRaA9BzERgZJ+5yhNmeEACjCOZtJ1LX50XJKY/2JEwgCfZ4QvX7UgxF8vLZMa/Y5GE2SwgzGBRUjcbBjrjreuLhG9XP1caOKuTWTqSGaGsT1haMTDg1YmiQTTqwU/ghowuOdh4pOb7G5a01oHMW0AZlEwID6V4xeRvm0Yg6M0h9ncCaXaPJI0V992wyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFeTKzoKNjYKwvh/KaP6l2RyIE17nscbJYfVyhpn4Q4=;
 b=m3g3qAkzBfSXifmTffZoZIdfvOf9Lv5N3TVVoTl9JwYr2RbR8g/+jHb7/IvPYja2S3onKC8BhMc988w+MXnHliA6Q7SHmkxWcJ5uN/mAOv2Px2iteX2JTD1XRJ/ORIkoDUFm+2kt3ouAcZAA9wFdipuE5FGuc7kDuCtZ8ayStq8wd5mP0ue7X/HxtO1IgoMxkBNSlUmg/DGE+k8W3XsMlUWui4Avt12kFWuywDwZIE02YME3cbsc4N2UxrCPu3uKvICkkmWImO2D/iCh1Ldxq8DS7qyU1CYkGLkT31Expt0tXf0Hlf/2YsF2HkVoucGwWJEO5ftzob91NiNwZlktng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 03:02:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 03:02:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQqqwhw
Date: Thu, 10 Jul 2025 03:02:07 +0000
Message-ID: <BN9PR11MB52765F651EBE0988E35E15FF8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250709062800.651521-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: e762bfa3-8cf0-481f-149d-08ddbf5e27d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UaJ+7IzoKyPfZUC2GXDvSNsLTkycA3AJ76VGiGB+qqKswfhrood+p/Dry4vB?=
 =?us-ascii?Q?KBgAhvRoblNhIfeDmpk/amDLZuHCTYrS6DIPzNgaYWPTvq0FDzwUbxAeJxQg?=
 =?us-ascii?Q?cev/K5cgs4amheMCnKDhytTK6hK+qs8uwtZFg5+nhZf4n/zTmkbXe9PnzRnl?=
 =?us-ascii?Q?ePaGsYKbUv8JLy+dmfSWj5qBylShwdvdji1TKDpxbq882Ge3rat4cPT4QR8f?=
 =?us-ascii?Q?EcxQo2T4AcZqb9Q8G/7V3gOjv6XltskOQotVYOulDN+Rg61vewbfayQPocnq?=
 =?us-ascii?Q?cyrrusxriPtOUwLlLp35HxeJjS3W/7Ft79s0/DMtZev2l7uiM/RhV4j0UUGz?=
 =?us-ascii?Q?pys7eFZDq7Xx2O2ZEUM8CI0TO8wKRtD5x5Pm9ZveXV7iigp+kkMCITrUSdQ5?=
 =?us-ascii?Q?Ir+0pr9pYbsprjwySDgRMPpzQUQlOIrzY/VN3afDIZAHszl8Nod12CHB/j7V?=
 =?us-ascii?Q?f6VPLv/iPvDCUIhCsvqzqV4PoiG7tVIHXlPz+jMgKbZi0083qjQlqTLpNEK0?=
 =?us-ascii?Q?TeqgeW7orlX8V98GbNniIq2qdKxY5y+9d7bBq1nJ/PgSmcwOP8TvG2lWnpaV?=
 =?us-ascii?Q?fMXZ3GDPq6LuDR//woQK4Vv5EiCw0YludZxTDnB4lXHrewZZCC8Cj8iTaMg1?=
 =?us-ascii?Q?HocjpJ6LW0Z/teetrbSHJcxoI1WDsXGYl5EWy6jKdxSG62bgooxfabefMR9/?=
 =?us-ascii?Q?zrX4fQNQ0o3L8WeKKDmuQssPo/b3OyrZrUU0n0G/lJgnx091/W6cqKqwmtyY?=
 =?us-ascii?Q?siiYgPoJFyM1yh12A0qRHOcayCXw/VQh8eGod2k8nf1qoI9Z2kf03/BtHFXM?=
 =?us-ascii?Q?dpKpL+itodG/4nz19rCXhEYygWUwzMLLsE2T8HAEvEizUMw8ba7nYaNC/DwH?=
 =?us-ascii?Q?XCyERCPppXfXUl01tCPgtCZqzd6K2aOgYmGto54YrUR1SyO4vwkfQVohYm+k?=
 =?us-ascii?Q?Un2/GkGFOIfxLbVw3uTgN71B8Yy8PxUeLfnQunMR6Xj9XFOxVvKLagF9KJQr?=
 =?us-ascii?Q?D0IrDL9K11YOyRcHz8pGI1g1tLCWJKVJe4/iioy7UEGz4tsfA9B4e2dilQjb?=
 =?us-ascii?Q?OHFMNEeD1mI0zm0hEDjX14kdctrPiCGnIzpUjMAsaA+Jflx0oKu6n2fDBGSx?=
 =?us-ascii?Q?5AIVOEv/JN9KKV3Z34gz2InMHTX4wWuXU0WwhXnWA1drmzC0w4eD12oPzJZW?=
 =?us-ascii?Q?hhDMQDmnxhcifnD/bFhOaY7yCpxHmfRE5+d9KQDYFBIntV++gwtd8oD4J5Ih?=
 =?us-ascii?Q?qkK6le+VvtuIqQlp0Z22+QSDp+wRej82Yk8BIl2vp5UFnjT/CcnY4Y6IzRfk?=
 =?us-ascii?Q?rErC17Sh+JvfuwdavjTFwSDPjuhCnJyPrngo9SzFhTdp+ErUXe9MW35hRtaN?=
 =?us-ascii?Q?bVZnxBKDN7VSNq+udnjI15M85zAWI4+foWe/yAr+P9HHsLqFILe7xNgqRqlD?=
 =?us-ascii?Q?Zdp00VejSg1c0SDkkBsl+btRduA+0GzsUOFE7wyNuX9naS2a8ekqwEyfxQ/N?=
 =?us-ascii?Q?lMxct3IFOnK+cb8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ePjo63g7d7cbFEaAepsCPQzDuRpKAqjgXfPScz/uvlMf2kNEhkol5Aiy3HW3?=
 =?us-ascii?Q?j9R5J3n0cUhK/mxVL0/xmiXkTwclbmG5aSxBxRYzcqvjrUnpoazSioUIL5Lq?=
 =?us-ascii?Q?zE3fzkxcyJArn5YyjUGZbB/Zls2onMh0ebdL4eMob11iSmF0PTqIflfrze+6?=
 =?us-ascii?Q?rOyGWuaVbZMq3Fvv4aAa8ndQBc1J75ZnB7cDBakueYNm7KYXkylxAMDiaf6s?=
 =?us-ascii?Q?SZHOJZb20CTSpS0wshRfBTomOYzu9xvPIj/o0bxWiBraSV3S15Jts/OMSkst?=
 =?us-ascii?Q?MufyNJCnf865OsN2JhgpgKigK6Dq+FJkog4pZqRzXOSMaz+MMJfplvrXXSu+?=
 =?us-ascii?Q?zlOFWkBb85UevA9Vhm8rTFHyCoDcCJLUIkPuFraAx7dMQD9ItInekr1eSEC4?=
 =?us-ascii?Q?LNZobBLPfeZtbsKZ1QNix5HE80p0RpV4fw6seLy+OJQjTG2swwpOS/fwYfvL?=
 =?us-ascii?Q?jSAUXRjNIQYToFap5guiAlLrIcq9dE48J+n4JdUupHlpBXkSSqjV59fdmKFs?=
 =?us-ascii?Q?AKyVHCCzE+n939wE4AXXG9hj3XwA17xaOGFaL+zCaeF2JOb7hNiILpLaczKV?=
 =?us-ascii?Q?cpiBgsnAnjMTHL2UWI9UnvuErAJZqDhKTGO/z+W2HOzLU9ShDOHWtrTPYd9u?=
 =?us-ascii?Q?Za+WlZ9lUWvKg7vK7AbSH29520wogrTnlzxWkXcemRabUUw9P+c3pcVBlAt9?=
 =?us-ascii?Q?aORBEFqW3/U4OjzmR4lxbaKr5o9AyBmJcG0Z+1sTkaaDp3ML09Jg5Eba+Z2A?=
 =?us-ascii?Q?Z6xAUxbh+z5NSQlv+1d+AljddA4Z/i+jJ0PdXkep5d8osH1bx6v3eib9M510?=
 =?us-ascii?Q?5yLCpqfyGBksw9ZvnMAQly31PAbYAPAVbtYGDyQ6hSE6jnAYp650Nxsi4x8O?=
 =?us-ascii?Q?FBEcxAqQ9N07ExevkI4SdnESMME0FQnnYNWADdGy/NOO9NM2eoRNDXgP+vq8?=
 =?us-ascii?Q?o9VlBBS+cgymOLKZnny6kbB0xFpseKfkLohKDkfXGj+uPDjRsq/TiiADxYF8?=
 =?us-ascii?Q?INtQL3sIDvrA4HP5mnkJcHtfoiBxY5QtJjXLZa+MBCkSHr/EjArMy3Ej75O5?=
 =?us-ascii?Q?kVO7qREc1py3o+cUS1OOggHgFcttl9D9BA48bcL3ZrWtnsXL5tk35T+aoZl6?=
 =?us-ascii?Q?DMGIycKjIV9LtgZu5ncPBsvwh7Vt8ugPy+GvVYUrUYshIBqOSsddWmIUJWj9?=
 =?us-ascii?Q?mits0dMJef45Kg4okjIDwCPos/Ehs9XABCq8iZzv6JhADEGv+frMMyyPmCei?=
 =?us-ascii?Q?THuTvJJ3OKfcm/fl0Pfuac18o7UMNB5BYszqobYmuGQYZsK56Y3tFYq1P5zs?=
 =?us-ascii?Q?Gc9kl07Rfd6E25cLaIOcNLaRyobJAGxsFMdazkY3qPWyeaWxpAO7F4Lj6f05?=
 =?us-ascii?Q?7WfPgQSkgeVi2m71/jRD2rNUiwDeSVZjeNSLoEeYotXxQ6FglkEgygJfMXi3?=
 =?us-ascii?Q?dMldDgMx6C6aMhJ5XrXHsC6Ite3xfVEY9pTvBVHFRbblAnHt4gSXuNcnAouX?=
 =?us-ascii?Q?yFQyWUWcUeGVgdrXTvU3WRDEzsDR6cGdUcEkXeiJpJoa1hqW4yvJa3DG/ytS?=
 =?us-ascii?Q?Yj3KN6pxxNFTH3zPAIJj89tPiWCXA7JtnOgcz8UJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e762bfa3-8cf0-481f-149d-08ddbf5e27d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 03:02:07.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfL0juED5Q6sr5eunXHC9ism+1PMuOVCD7D4ZoXZa3nS+MQeKc3JXL5GsXHR+1gCeDhR4CQzw1uzgVizjjqAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 2:28 PM
>=20
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
>=20
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the

I'd remove 'static'

> IOMMU to access the kernel portion of these tables.
>=20
> Modern IOMMUs often cache page table entries to optimize walk
> performance,
> even for intermediate page table levels. If kernel page table mappings ar=
e
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potential=
ly
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.

this lacks of a background that currently the iommu driver is notified
only for changes of user VA mappings, so the IOMMU's internal caches
may retain stale entries for kernel VA.

>=20
> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.

this also needs some words about the fact that new flushes are triggered
not just for freeing page tables.

>=20
>  static DEFINE_MUTEX(iommu_sva_lock);
> +static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
> +static LIST_HEAD(iommu_sva_mms);
> +static DEFINE_SPINLOCK(iommu_mms_lock);

s/iommu_mms_lock/iommu_mm_lock/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

