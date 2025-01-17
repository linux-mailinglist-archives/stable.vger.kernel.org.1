Return-Path: <stable+bounces-109333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E3A149AD
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D0616AEB7
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14B1F76D4;
	Fri, 17 Jan 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RF+rm31F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B11F7586;
	Fri, 17 Jan 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094903; cv=fail; b=PqqE3cSDWgjxxtUsf+9Vh5VL8TOEPZypE8dzXhlVCWtxUAJkEX8I4WWd+5+S5WcLJMiTisGuU0nUKP7OziD3yhgiPCReHmZ9NCmoVpbvabgIJ0zsOnmgeMbEF+Z0IPQTdn5XrAXji+3d6MQ10CSSMMNPDBEpohOs9YR5kIrjN4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094903; c=relaxed/simple;
	bh=AKcJAbzUTq0K7oohG81eZdXeKz7TD4c/nYr5Ulb7U8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKa8+BUUFIZPFQBNOCbTYadUXz0Feu1jEe8Si2o0kBOxgBdiWi8f4W5KNYp/N/AojAHJR2qRPrC2bnz82cDV4ZfZuUpgG2gLsh3bU1BAT93EFUxU08mAW29nn52QDzHsLkeBPtsClb92HAO1j7MPsPJfYdy19WySB5G2dwemHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RF+rm31F; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094901; x=1768630901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKcJAbzUTq0K7oohG81eZdXeKz7TD4c/nYr5Ulb7U8Q=;
  b=RF+rm31F2FBOYwLyDrgzeKKU207nm/BHdKjkZlBPAVqJauiQ/D+xS9MR
   R81ggoO9gssUCCiTh5cZCrBedGH957CHu2QwWSqpRevpkm26MB5pVZweA
   /4GqR+U+m02aPsrTFK+STytcUlSb/SK5VyY/JSY5Wlw9XpgMxQWpBFLVV
   jNjjtmHLT47DlS+S38j+LWfUgIseZ4Ph6DoWSPbaRPYILDNt3Ev13wOeb
   nAcU1vV14cf0JL3ck4F2mshLvapIDdXJbey0Vvsm2UUosnJc9zot/sIKg
   avMIdUGvMay6YcQ6bMEnfCUWdbW7MfYOjnU4oEbUzHEfpU9w97sSu9M0i
   w==;
X-CSE-ConnectionGUID: xBaUPlRWTny+2MevdAnTQg==
X-CSE-MsgGUID: DR2ijb3yTD+ScUegofUpMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37676837"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37676837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:21:32 -0800
X-CSE-ConnectionGUID: hCg5Smc5Q2axKrsA0M8Xqg==
X-CSE-MsgGUID: SUcsrtKdTWOdgS9fJL+tCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="106304144"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 22:21:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 22:21:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 22:21:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 22:21:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVudB4Co25+cihl1GRLcULXKKO3fEM75B16QZDJAlFMmM7ORrfOI52WDquD2058ZX1IqrsFLrj3WLSi4mhaOqHfrXmoZsdud7fYKqp+A0tSdWUnx+LJAUmolrwEoh8twLeZOR3sAWyfKeVivhfVhXiH3LPpJTJKIU9X5rIHZfaGw4YHzeoaXLHlFAqvvoyvqylsu9gmcUUN8j5X4BhNMBPyh45sNCIte2C2nrC4EEyzCfTHmyYTXvlir9YrXOanmg8YYpj7z8kswm+gWT3XIc3zXG+0WDYKdTKG3eHCQEYOXMTyXRGhql6xFQ0j0EG1uD9I41wcDojVE9MAu8UH+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKcJAbzUTq0K7oohG81eZdXeKz7TD4c/nYr5Ulb7U8Q=;
 b=Ee60BnAx1JlCQy3x3HYoZD8pGrZ0b5hUivwv+wlhXYOUIGYlypLz7uFQ/XxPscodtQNLVUgadqywV8uCG7sUkG2b4Jk9CQKJWipuumCGHaBivaM80mRy85TR7vRlCsto7Cp9SbkutUX818xrOFwBMM68klFyylWXI6gfjN1wZVCgv1TzC1JCqauROEe4MA3oMyG84RXI95Z/DO74PnY7TxdROmmwvb07ZdU1QbPs9kwffSY7eMVIBi4MlUQl4MCjI+FKXOMyOEMMF6E3m0pC/nk2P7txSRittoDmJ/wnXtVFYUY725SZnM/HKlZ+UNod2g9wa3s1XyYjzIl3Nruj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 06:21:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 06:21:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu: Fix potential memory leak in
 iopf_queue_remove_device()
Thread-Topic: [PATCH 1/1] iommu: Fix potential memory leak in
 iopf_queue_remove_device()
Thread-Index: AQHbaKTN3vsKoqsmg0izKjMmCw/1TLMafqfw
Date: Fri, 17 Jan 2025 06:21:23 +0000
Message-ID: <BN9PR11MB5276B0FF4A7F178106C2EE0C8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250117055800.782462-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250117055800.782462-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: a87db1e9-6c74-46ba-516f-08dd36bf2a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s0Eeh0JZpmuPwXmF9/fSk1Of8+11xL/jX7oxpXQYdeE56jod4aBnM0wfuG3a?=
 =?us-ascii?Q?Qy/0hbqSyKoORFP2OicSH+vvJVBuo62LmfmLe7AZxUR2Mfx/ueSofjjN2QMm?=
 =?us-ascii?Q?s2DZJuUmSGY9R88TN8m68sqhneVmeJnAqUhlGlw/wofsvBRShzgTAtSYH62o?=
 =?us-ascii?Q?a/VVbWS7bCwfeekYLUrGzmB63RatgX/s63aSJfv4ihpUXUD46qLEHz0qgxRW?=
 =?us-ascii?Q?ngEL8CDK6crY8I10oS1cAJKrjdZRI6/Vel7+k//Z9ML7wuYcuKboLOtD6v+k?=
 =?us-ascii?Q?TIK7pfM5KgUrwOp4e8SyZViJldamT8FjN8loUhOEhF4kDxx3Kw+uQOk5U4nW?=
 =?us-ascii?Q?B3KWhGld6YEevZBushz3kTcbVqWjREDvH9jeXY6lL+COthZ25p6ZjE4fS5mJ?=
 =?us-ascii?Q?XrNg52dwN2+ptBADA1mue5zSg5MAeSh2X/CJPwUXameGom7UOljdgvLNlq7o?=
 =?us-ascii?Q?PwRvKyi2RJ/BvXQuF97tC1pfSpi5ezvXgUXiGCFLm1ewJGQmvLLpzJbcPF2R?=
 =?us-ascii?Q?IhNHQrse1AChFcuVxmXk+XGaWDSLdJbPNW0jQvKziQEnW0Yk40Yfw39Cmvyb?=
 =?us-ascii?Q?Un0QPB/UB8fy0vsJI93KNgkuXD0+wn2C67H9EsoFz9xrQqCtaLRa6/PrvqlX?=
 =?us-ascii?Q?qp+QMMQHb9ErO0//yJ/pl91ISnutkyubiyk81ALe9MmTx8mU6ixSzUFgrPL3?=
 =?us-ascii?Q?pYVwZ1Xxpd1JakR9ZboO+VlBUcp8iIyzwpNCiiZjr6qk3Z6XM9KPStjUzV8K?=
 =?us-ascii?Q?ZxDA4fSSlvaPZnleKa2wJX8PocxaQr4a8TD6/XZWBecjWDLZhGGY/suoi8br?=
 =?us-ascii?Q?A+iLZdHN2tfbC5SQebW7ZmdnUXZXA33bnb2RJtKmh5aNFxm+yx8GAWSdXvwT?=
 =?us-ascii?Q?x3QsiLAJuCvwaiY1mDRN2m3J5H8IeTdRe/gLdWTxz/JNGaZp1XjFGLvf4ALc?=
 =?us-ascii?Q?6Sc/3ZZJgztKoobNOkDVfHmV+mAR4EJg81yelDSiO1XSKMnlBnbWhsVs9Jq+?=
 =?us-ascii?Q?43jPXzMHYMKevmCUjmcbOyqfC9lqJFlj50RtbumMTipgtbaUI6C4ZYAO1JfO?=
 =?us-ascii?Q?QoP7wFCxR2DRgh4lHAGwT4pm/QhRuQgUqbD2vv9kdIiraV//jbkhsTDkOyu9?=
 =?us-ascii?Q?RjgtnHwBY9NM6TpRx2dBrdY5NU3MQETcNAF7DSTj9QuQ213YlWTFb8Op6SHO?=
 =?us-ascii?Q?XZkqFyK/OxH/XL7hvl4U0ylfettVrDACKFjclcF2s1pWYCIxd8hb+i4Aauen?=
 =?us-ascii?Q?j2Eoojhy7ZZX/VYGyD4PtOLq3w/XwBH+DGzloOZkPSpAhrMhCWbRBrnkih8k?=
 =?us-ascii?Q?Pa3cxkyMtX6NEGbIUwLVF4ScTFHXpCmrr3kenmkdBeLsU1AMFnqCvSyWQA0y?=
 =?us-ascii?Q?3LuBmcZeprYWuB9u3fZ4KUkTfyZWogtV5Ln/ZLX3LGOUrAUUJB1cOTz/L+m9?=
 =?us-ascii?Q?wEb5eeWaMy6yuNGp9nzSYFes3vNa4laY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mkflZ3PcQtFgITqUNHAy1EsEN6sWFTCFJewZ1nbnP0WS0ZerQPLRrsaewrps?=
 =?us-ascii?Q?SLTmkgV7hOdF7gMrvadH+PtYqtec+ZYzxZ2LlqRE3ucdFXShgwFf/eSxie17?=
 =?us-ascii?Q?lelwc2f5qpWybq5kamB4oGboZqJEKOGqU0b4DaGu1LsLufu3lZIA6+/9ySb/?=
 =?us-ascii?Q?pMdHuMY7ugcScOepg0CSl03pfpyM2eK6ennMBqg2FONV9cu1AkdSWA4ax3qh?=
 =?us-ascii?Q?YCVqzGaOqteP4OxKSyMVSjpKYOnJUOPhLhEv/cwIWHHmoQAU9/zbmkdJ0SUQ?=
 =?us-ascii?Q?U7bVVCdsNB8smwgjBuXanLYKTq9C+IYYQxGxH1r+iX44lfXBeoTUa1SRxos3?=
 =?us-ascii?Q?/h/3QVov8SxF6GHmxMq748kkww8nwt2oIWMrObsOMJpjSJ2f+tdPGQ4hX7/g?=
 =?us-ascii?Q?fvLJAGw/oDTi1rJfg8CTVpxxBqIMkFgBwG+ytw4lCzcCBYJIT0/C1MvQC1bw?=
 =?us-ascii?Q?Si92jev+7CK3R0wodpz3OOmPX7oA2f90jwbCSw2OeOnZ4Ap0W8lyu2Ev9nWX?=
 =?us-ascii?Q?7amVUvp1Sy8ZtE0SkwVR5g/IB+L8Gx6fBlEjSphzG+bRDJb/sm8cUhjznkNx?=
 =?us-ascii?Q?V3xDbRKm24DTIq37jK9Ubm7TjSrZuLUw/taCASF8zbuUH6Ykgh5nru0bVNhi?=
 =?us-ascii?Q?Q5kTnD83WisBBvkagUDJ3Al4R39ecTB0QVn7tJE4y+DzgqqHIm6zaqGty2xw?=
 =?us-ascii?Q?jdUawPetMPwsyjmqZaUNswFd02QBqNO5YoTU75Vs9gLDAW7LD57r5656bjFo?=
 =?us-ascii?Q?yJ5JUwzQv+wRnDcBrkL3kewCP/kLr2DuPkEr+b66VBkctr9gj1O3+gX6n7Ww?=
 =?us-ascii?Q?Jo5kQrocODU2GgKx5+tJv8TqBWyYLUbB5yVwP4J0Z2Cuv9r6tI4ej21Uq5Zy?=
 =?us-ascii?Q?aGA72hzauHALMNJ09JoBP5EkislWY/B/EviSQA5LJfOHp6Gw3JZtaBzbYH0c?=
 =?us-ascii?Q?Z31iPFYIFDqNCIQ3EuOs9Rj1a7Hp2ttMDRIUzlbN9/lzG32xO20I/tAzdoMD?=
 =?us-ascii?Q?EUe2AeOLQfcmERFoTFpp5XvgnSDaw1Oqdl1K8T80ysZVslH/yzOzrEiT6NPE?=
 =?us-ascii?Q?ROcpiq4Rw0w/+iVsM6f+cPcqDyCbt3i0OOAoHTNawTP7FoYlKFDZpQTe4DWi?=
 =?us-ascii?Q?9V/X5C+R731DzPaFPPk78snEhMNrSZ7e259xD6LYEUvwvPMjCIR1SmIxQ8je?=
 =?us-ascii?Q?OpkBczosCqLt6LRHW/0YlfFC23qdY4AjeQHE/pmAS20kLg4tLgEeG6QihOS1?=
 =?us-ascii?Q?1hx6NbIFrx1+p+fq8ANSCO5FLZYodOPf2xSrwFpf2/TzmydNeXp+SwfywlQ0?=
 =?us-ascii?Q?Wt5Tcv9pmLImGsgrWb5P2c5KBv3akh4R7PnKP7T3Kp3mlwapMmvF6pwlpQKI?=
 =?us-ascii?Q?rl5qynvYmdpDSqycBUnOkoG/y51ZGiVb6gUYryINAaLOj+yOiPq/z06hGZLW?=
 =?us-ascii?Q?p+9YGnv45bPh+PuYbqsCdkiEXl+uNYqqsdyvC5FjYS04v56w6qiZU4MIvlLB?=
 =?us-ascii?Q?8hdsDPFL0FILEhDXNUeQHZAaMw8ppqLOEQvkNUSO+MB6BVlgiVWj52/6EwNP?=
 =?us-ascii?Q?r20usqh/ZHHxH9LMy0x7w8ziSMCMtt4xOkatdJ2Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a87db1e9-6c74-46ba-516f-08dd36bf2a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:21:23.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htRjKvreiW2vhv4kW1xz/qJeAg1uFl6O1Vg2mJbfLUaO1/EITrM/1sVsXgXefMgUONxQWxckGsBWsTmeZYDCKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, January 17, 2025 1:58 PM
>=20
> The iopf_queue_remove_device() helper removes a device from the per-
> iommu
> iopf queue when PRI is disabled on the device. It responds to all
> outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches
> the
> device from the queue.
>=20
> However, it fails to release the group structure that represents a group
> of iopf's awaiting for a response after responding to the hardware. This
> can cause a memory leak if iopf_queue_remove_device() is called with
> pending iopf's.
>=20
> Fix it by calling iopf_free_group() after the iopf group is responded.
>=20
> Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

