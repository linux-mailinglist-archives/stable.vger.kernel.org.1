Return-Path: <stable+bounces-158723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F54AEAB8E
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CCD1888B08
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF627461;
	Fri, 27 Jun 2025 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6hOGHM0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A252190477;
	Fri, 27 Jun 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982442; cv=fail; b=Hop30r1fUH55aURLQrHe9d/N4qMnRhxrrHw/Yl342a5XMgHCGYze7wfruzy15BrpEnpQpu3frrJ96sZYs/6neWV0BF99wL11Npm2O4nwAe/2jGAUtB/pULbTTXHaIec8nmj+DcV7XxjPd0tICaqjCThmkn6Lqc+bHO1oP6f3wTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982442; c=relaxed/simple;
	bh=xCOZRX46y2xUTT97VuP+8Gjvt+GI/4MrMFPulphmiSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXaHKFeU9StPNPRgdexLs2R52xKj6luXPZCjngTIul1RsWgmJv13aelXvdZFZuhospLfo7VYpvKZBs/3i+ZecdzgTEbpxuUuZinR0Jz87FBRJsIkyVt00eXck0j9LohV1kfddYCdvmK8Rtln/oYayjF+fToEqe/7rEbDE1jOJQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6hOGHM0; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750982440; x=1782518440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCOZRX46y2xUTT97VuP+8Gjvt+GI/4MrMFPulphmiSw=;
  b=W6hOGHM0iQPNUiytpi8u5sialLuQ8td+lm919JIbzexR95vWup20OCcD
   2J3Sz9cg52AmSXqhbPd+FSwejR9BgcK+XJtoJHVyytmmune5y7Tue1sZY
   JWnEYQz7Kx/OxS+pQHtCeqpLyOImOGB9+eHnZGK1FJE7f6VfJ209DBC9V
   545iJZG71Pp5jLmrY0uf84hHqVlaCByAIZx8c8nIiwHQMV8zZ0V7lE2EV
   0ygjmp7fYA2hYOLX691qtVQNUQ4iTEfGR110Qo0zYeBitkhbl8q8ZHGUD
   aIrlbhqQNwJsfzAcRfIHU9UheBT7NgIynl+blBTrGlD54E5cDeINuu5VD
   A==;
X-CSE-ConnectionGUID: yDaRdwEATZu3YTlP/nbodw==
X-CSE-MsgGUID: TrruSdzhTQicfxcAAY4WaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53260039"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53260039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 17:00:40 -0700
X-CSE-ConnectionGUID: tDAU/w4LQ3qEDXHyoASQZA==
X-CSE-MsgGUID: xpWDyWlfQ4qmvPH85OrtAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="153370835"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 17:00:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 17:00:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 17:00:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 17:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKGognUS0f5+scHzUauJKQIZsjm+2P9Q5Tvhv6A4EeVGxCQ7dpfSKFZd7QuTrYdZBWHHXn1q2LyELPXxq0mtH/nSAsb3sOv/6ufKj2tNzbZtVXxpDE2FzqrVVQb9348nDgVOVDhaRqSvH4gPWQ0ZpsKDL+/av2IZMH0vCvQjvme+x7G/6NTK4ZYT8sWcj0Oh7raWOLBlvkEmkeF16rmEKnUXbr811+gFw+JHugeRcGqhSrilEQ0hhaswQbY3IVu0675/AV/eQ0WW2eDfiMbrDrvto5BKS+5vfiz+QTZOpN7b/6w48sJu8DdPLkJHJ2KTQctlE6921dp4P8gXeU2Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCOZRX46y2xUTT97VuP+8Gjvt+GI/4MrMFPulphmiSw=;
 b=Iyz2B174zA7pcbZ3/9e3ee5TjgT0+POoQODy/EZbFQArta7cdXvkrylkiP7h478EN2UgXlZ+7RNu99flJmQCaoaa+VMciklqN4tPUAW30+6guqp2mecYIICMjtz/x70HGUicCxqi7mmZwjUgwXJWK5fnIS4dvNZixoFk7YZdNTl8G3kGlLnmpsddhCq2yt7Z+FV7RrRvnzjlADAf5HK96aMlzBpb7i1FqnjqOCffDnxdc/JHT0/jDdVJhCe0ItaogKzaUD5Fpr9IhzLHn94Z1zMFlQjNYSPu3xY2zxAJBJkdQokInH8IhZzBkcG8h9TXJRoRX9EA6ZsvI6svyhPJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV1PR11MB8792.namprd11.prod.outlook.com (2603:10b6:408:2b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 00:00:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 00:00:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Lin,
 Shuicheng" <shuicheng.lin@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Assign devtlb cache tag on ATS
 enablement
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Assign devtlb cache tag on ATS
 enablement
Thread-Index: AQHb5Y6WVDzFNgUxy06TUOHvXavd/LQWIb1Q
Date: Fri, 27 Jun 2025 00:00:35 +0000
Message-ID: <BN9PR11MB5276C8DA11EC1F412757E5F08C45A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250625050135.3129955-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250625050135.3129955-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV1PR11MB8792:EE_
x-ms-office365-filtering-correlation-id: 852ebdf8-d7ed-4ac0-5336-08ddb50da4c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RKOe7fdttdvA583Awt2zsTgruugdtIEk/DjWWf5kb4OOXOgPicLTmo1wDKJ6?=
 =?us-ascii?Q?ac/S96ynSJslqQgxCAk/J204MmKyQ9AmkiDjdp3Kf3h1c84idQKG3oGYHllr?=
 =?us-ascii?Q?ElS0R2pd0pGe3BkTTEPHUwZczSPrWR9ySdUZcsMAYikK5SzKD4dqcCOboYJL?=
 =?us-ascii?Q?qaor+JF3jrWJ5hlYChtXIDrQZ91Ld+GLk6JM9ChIjF1BLMw6lefO3rcVAgNP?=
 =?us-ascii?Q?PtQIbBLzNkWdKqtXdP96h1aeJe/ibu80RaJVJyOGN5TXTlQr2hsvubl9R1SX?=
 =?us-ascii?Q?FSoEOPSBQljwjtiwJFX2B0CKafbRVSjdmcUtOzriQC0vUbDtyaIdcjclSspk?=
 =?us-ascii?Q?8yDj+5EOi5rYdxoaEnQNBioa0SP8N7j6viTOnK1Zc9M8LgRA9kVeZXVVkbbB?=
 =?us-ascii?Q?b57x+XIoNbLZ2ukJJYmAt5OCWQPlANNsly/oHGR9ZeGV4Lu+W+Qw7pWLB7qo?=
 =?us-ascii?Q?frg3Lls1wQNle1db8/XjGURio7R0HqgEfTlyTkka2sPcjchOnhY0AKtkSbPO?=
 =?us-ascii?Q?rncZLArfj8ofihqWMwlRtgEz0c2u5T6xcvgVFDZdIuJo8E9QFZmyQ4EYi/Ak?=
 =?us-ascii?Q?Aj8kmGFx1e31BCLaTdSr2ZV84O+9cIQcgzG54+OAuXnOI45JJLfQTQZoRxAv?=
 =?us-ascii?Q?Knno+0b+gV8hls5iYUE3kazg8qWrDLmC2iR5BsGiPJiktDEw6wkRLitXi3Zy?=
 =?us-ascii?Q?0D0X4Vghpj5TEoFxGJaBd9BtE769YeKjlHh5IB59uDseG5ly0BGab8gxrsCc?=
 =?us-ascii?Q?Tu1acGRfBBL3R1PPcbfzmOuTx+ywxk4LqdBO9he5v9sk1WSxccJHHfOBlphG?=
 =?us-ascii?Q?+ckrahYiDL77Is6DPruKwjvj0Hd4BirBBCWG10fxM14EiH8lMfyMF1GF3MqH?=
 =?us-ascii?Q?VBqcGPv9ZLz3CWoMUHGtZsGXUM9mtjQTfloOVsGD8l+3FnrvpaXDA9MShkTP?=
 =?us-ascii?Q?HUqodQAuSptfcvg2BXXEJU6IKh8AmLx8lm0tFFwSznBO8eitwLxjX58vIBNu?=
 =?us-ascii?Q?JZ1vEDEfr9AS/7Y2jM5KrfRnaqB2m+1jRHFMKBY4SeG6zZ+QvrhMguz04gkR?=
 =?us-ascii?Q?AoDPkLi2xFv6TUGaZS4qy4lz/CO6Fhf+X8r6ITbePHjienqmM5Og8u59EL2A?=
 =?us-ascii?Q?fPfyrETKDk8uPvCY5RPy8U4y5M0A68HhH/UKbMP3ghKvBD9ormtQuhQJYLCL?=
 =?us-ascii?Q?CLszt1Sge3E7dcS9IGaA4kXZBFUAk5knLqJ5l/V7ENsXmAxPESuxCnqPuMqT?=
 =?us-ascii?Q?vjp+reNvIfkKAuTCLL84UkdhXexeVd5IrQNchgE5vLKRR2krXyJH8hfTgSve?=
 =?us-ascii?Q?46KKXgZv8ATV+JbLKd98HfEv/2/eDRAwpMvmrUEzRwjni2CryBc0j+6cUNK9?=
 =?us-ascii?Q?UfLVF0HHmIat/FoDp2WNb3EeiyfFEi368MZQaDauI3GETD6u5v++uqHbU7zE?=
 =?us-ascii?Q?+PVsQIPYiUxM42RpwRdSj2p5u8JxbnjJpY/CmlixHtbXQ3WKwCgShQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Nprn9lChvAvzE4qiOjjOHDA+zz9YZJJriA4PgVZsCUtEBCSogX6JOslH5Tm?=
 =?us-ascii?Q?+TxcHWCGFmcLNF30Hhmua76QEsZdQf6i3/yFQqCXzaoTEWuBP8bVVoiO1hlT?=
 =?us-ascii?Q?adljddrJPibWwS8GiENEEFWh2+yt+e+19O9FyZTmaMrCXgGkShSYmDLtBfdx?=
 =?us-ascii?Q?jc7j77/VVQ0Q5N1dAUkpOTiekBoQaZeM+sjBNPvMCJ2yt5eUJmKiI2T3Q1uk?=
 =?us-ascii?Q?znM+Vw7dDX9Q1Gl2nkSIIrXQADYvKE1MyRQAL4IutVxN9cZC9HhUXwli40Hn?=
 =?us-ascii?Q?/yvVpvR+1TA9v4aTO1hdI1Zs7Wl/fohvkjScKLmM4c4A/uUlUxxOpcCW32bm?=
 =?us-ascii?Q?IVfKy141Oiq17dLxcBTWMaOvYjySAlyVFCG7VXXytcZmg3Zif1kXGMzn50Bd?=
 =?us-ascii?Q?Ngz7LDtzH6uGeA+owTDBzcYa5LKH8bqL4UbHXpmIEk5CzMd1bBn+8RnC/+ru?=
 =?us-ascii?Q?7C2Y+VUZ2kGxie3pjNy+djkJjNQEdCYkc+StfM4qp0P83bQQiVsCeHcF0FWY?=
 =?us-ascii?Q?4aEVNOYiwcASSP0rTKH1XIsh6T8z5Y9VV5GcRbj9oqyqCqMsz1qpespK/Us+?=
 =?us-ascii?Q?J9+LJFSH2wh6NKjUc4GslrDPx+VE/jTrSQftDSJ1WEw7KYuoyIUgaH4q6fC9?=
 =?us-ascii?Q?D98NXEmJNunLlumRLR7uzw8+d5NpUw7Hckw/PqxcFycSKEGkJkdL8eOst52Y?=
 =?us-ascii?Q?EEAtEj58X1OGD8YU1vfPX0xlLDdoFBE7adNBaarXEMwwLb6o8Lf0i+Huz0bm?=
 =?us-ascii?Q?bQgPwavjR9IEVa4Y14lYtbMzccu4ejB84wLxamr8awLrMKzrjSfz6H//Lsru?=
 =?us-ascii?Q?Eh3O/bN7nj9bWe3NXQZuq9syYWIDK6ZguMiECb/CGYQxxcTr5WyuXYQWSLkk?=
 =?us-ascii?Q?4TkMHtTUtYHUd5ItbyuoS5d1zrml43ua6csBvVvoPzTw2/h3RkNGCQD5ttWi?=
 =?us-ascii?Q?qlJk9J9iqNVAnR7wLJlxjqvwdMIFB7PUBXf8yuaAq9U6vRz5rKY9RTSyWFHu?=
 =?us-ascii?Q?bZs9CRr2bhJQPN5+kxNj2zFvOJov1qDPaZrro6tgRaqHUiR6B4soORZ7XZ6q?=
 =?us-ascii?Q?1dYib7gY983RV3+Ldot3aw/sqVwEKDg+P46LDybiVYfixPPSq1N58pxUGjtL?=
 =?us-ascii?Q?wbdjm5iM+Lcj8OGEt6JlD/EUIfCPxbJGGHqri8fZoe5L2QAiVx/0T3YdWV4P?=
 =?us-ascii?Q?7722g7EZpGHpmWxNGnuvbQJFsDV5UIXAvZdanIWdxplNMf6T7LomWXcDhMDJ?=
 =?us-ascii?Q?LmVXNy99XPxujR23ZgT6UOiavwS04ru/h8S4FMp3cEHbHr+tAQNQBYbbk1U6?=
 =?us-ascii?Q?2/H/K+gNVFlvyuya/DWr9glNsA9MaRRfo47wtC0JODtKNTMY9/guZarC0B0u?=
 =?us-ascii?Q?Ie8UH4hkVaQTGjx797WktmhR/sD41SXCKFJJjJonZ3KuQB3/36Jxjabqc9s5?=
 =?us-ascii?Q?1S7Z0EGdfsfB1oXuqW86n55atJCsz/FushgXyaXyJJ6vFRjNveG8qv5yxv2l?=
 =?us-ascii?Q?V858tKMwIGwq/QNzTpO+QjS1Ei5CEtdfTF5y8VkeuOFyAVFgzeXQBgOAK6n2?=
 =?us-ascii?Q?zOOS35pv8nQgWjnT+bULEo8T7LDKrt0BIL0l4fEk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ebdf8-d7ed-4ac0-5336-08ddb50da4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 00:00:35.9702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHjxdxp4Jg33P5/hEPfM7HAwQ7N1+0FN3+qAoy7HdgdSfojkZKDpYKSViYLrCO1PHW5yLSLnxAhVZcxMCAGbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8792
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 25, 2025 1:02 PM
>=20
> Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
> failure") placed the enabling of ATS in the probe_finalize callback. This
> occurs after the default domain attachment, which is when the ATS cache
> tag is assigned. Consequently, the device TLB cache tag is missed when th=
e
> domain is attached, leading to the device TLB not being invalidated in th=
e
> iommu_unmap paths.
>=20
> Fix this by assigning the CACHE_TAG_DEVTLB cache tag when ATS is enabled.
>=20
> Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot
> failure")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

