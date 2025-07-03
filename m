Return-Path: <stable+bounces-159283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDBAF6B3D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887FF4A7F9E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3C298264;
	Thu,  3 Jul 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iof0lL9V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268771E492D;
	Thu,  3 Jul 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527053; cv=fail; b=Ij98bgQUFItThNz3V4gjOk48NcAzvchxYR2s7RzgMzj8D4XxvIG+qlLstvrl3PiqXFm187rTWRuSD/3Q3wZ2HI/CFvzaR1AAQ2x4x483VpyKJgywg4XC5YbVaNAvcHz5NkQqGHNkg+ioa/4qyeclxxq7S24SgBukPWa4DBpL7AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527053; c=relaxed/simple;
	bh=aom7KM9kCvRv/RfLTb7yEuK7C7zwAg9p1MDUtwaVY/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cry03KMYU+BFzc89dUw16aBqtfcPA9KtS/Pg31jPrjKzRo0nLffhRN5pnwNBLPcDYb90zOleL9dRLGudoreT5Nm2sL32y0txYrrswmAj7veRRy9AEbYCkWsh1sUW/1JkyZhUjN92HdKa255SPukTs0bGw0WDkiVcoDLrTCxkaoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iof0lL9V; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751527052; x=1783063052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aom7KM9kCvRv/RfLTb7yEuK7C7zwAg9p1MDUtwaVY/c=;
  b=Iof0lL9VzP3xIpm7U7tVgvC3X2AM78tG/pZYNtlPRvSigygxlh4Y/1Bw
   +FcEUr6rM12mtkF0a3IbE4grAbzUMIP9aKycFr34j49vmHB8AydWFHwIh
   5mSNhbhSUPdrNHISzLsfz8FjHD586v5+Agw+U+g7g2zbt9HrRT8eJMY5z
   t+7j+P2qQ/O3CG1oAE6wvBKw1EQ02oIlok2mooh/kOu7/9zFV58EsteWu
   djJGyxxck7LTD3seF10bBGi+7L4a9ZFXe0J/WqbEvu46HKYwgfD8Puicg
   XuJcVa9C5nBJ47swRc74jMManmLTaBVWCJdLwnPm8xO5RRV9NZSh2q82V
   g==;
X-CSE-ConnectionGUID: d7SeFIKcRMSV1+/4KStgYQ==
X-CSE-MsgGUID: Hm+No9tSStq+NdvRtRFPzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52959398"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="52959398"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 00:17:31 -0700
X-CSE-ConnectionGUID: TUAGp1hRRh6kHcN+CI1qOw==
X-CSE-MsgGUID: gtvcv1fjRKaHpnNGQnLqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="158567554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 00:17:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 00:17:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 00:17:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 00:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx3gCAxIoYdnwyvqvFF6qeXPDUAvuIOlTbzKpKqFpxfSrtyxun4GbFI/n1gh8cE1aIV3A2Zki4e96ncPfPZR8uubwpEZoiNxqISlV+aUd5UkbYDRmBL0AsQH60p4bYdTZYbHNpon29mpC4UZLqfL1eZsjmFCsfFyVMFfYM1lbdpr7i5gmOiwoBrzzwXk2WiycS2QzrzXmzZw7S4a/FclSwefB7uhg4EFuXIAtTPBpl0ds4W3dDnA/HpSTUIjhC7lM+cV61Q6otKSjAXlI1aYbUX5SG5tjH7W0phsj0x1IaRl1eq1hR4Vx1zPP9/uGxsbZ9q7TjLmLeNSELD4e+q0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8zSYIc8JPrLKh+8NzghcqoFp/tzxlO5/DUEWNrVNg0=;
 b=dzysgsd6L6iaQIjNwUAlA55jYCkIs2y5sYB8w7Tqg7QhVV9Pg4IYiLV5pjDzMhfZgcL78uFYPFCFfoKm+aUKlnc2/3KVBXkU4WojsHQbKh53r6gZTpUm25LYOGQ+TLYLVBC3fZYOdvx3lW6alOL1LddNHQyU14qBZtbP5nYSw1dX/uG+IkRZxNaEci8Ar35zzgK1Q42Q8WbLnYC4dGPp6H0AWl3d8ZsbFDjyyrOCmzWQ8Owrc3ktQ4eZ4Ma7VqTDAsdKl7vmHSaAcxJMjk8SDkxbWHcE+afCr3WmvoPjjCIkKiMxUMPw1sFiEbWKf6eEpa3C1a6r4ZHfxDL5gKF9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Thu, 3 Jul
 2025 07:16:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 07:16:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Ioanna
 Alifieraki" <ioanna-maria.alifieraki@canonical.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
Thread-Topic: [PATCH 1/1] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
Thread-Index: AQHb68kelluFJoZ32ky0n7TlCxI8/LQf+53A
Date: Thu, 3 Jul 2025 07:16:46 +0000
Message-ID: <BN9PR11MB5276F7B7E0F6091334A7A3128C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7023:EE_
x-ms-office365-filtering-correlation-id: de36deb2-e344-4c31-670d-08ddba019241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cm4LQ8sYWV55pBZgW2PyYHCRsplBYZzEdHPd/E31meF4xiPhIsdw4w5bM8jZ?=
 =?us-ascii?Q?ZvpN3+clRF1hu/uxZV7Y7owk1sgOzWMy2sXqot9pkTHdBOTaJjZO/s4L+8ON?=
 =?us-ascii?Q?L980uHYOJw4LRMrFAdJQsvlUK6KucWnJ/xKqqsjsV5g3IR3F5FiRMqoMG5gT?=
 =?us-ascii?Q?s7pXOTUyG1dNQO3TFFxoPUSCrpkkr89odkZru0vtbjttU+2KYgqsRIfs/z+n?=
 =?us-ascii?Q?NoAZC5/KPZPMI5tbhuEGb/eZ/BY1IAqOW+no3rg0ELGL+YAS3ND6ZJIAW9ns?=
 =?us-ascii?Q?J/zs4C5xAfEBofjgst9nsSNc2a4xPytesgLd0OKqr/f1GQPueU9ZV0+cksE7?=
 =?us-ascii?Q?u+G6zBD47hIuwvsQdUVAXvNJy4KO1H6AxjacsMNl1Dhv1ZXoPdiHFLFMwrl6?=
 =?us-ascii?Q?0XR56XTAGXpK9sUZsYcd5qVnpZ/xaI7oBokYkNeQmmmybUkFGXa5XJjWk9GG?=
 =?us-ascii?Q?jQHGNjw7aDlyp2c7EMfUkG6dPrDAHmohRRV9uFR/C/UkGfQA92eKuLe2bXo1?=
 =?us-ascii?Q?pA2PIl0+z/4w3g48JljxyLQ/KzAnw4hzijIJnlFVgtMIgVF0EsYVDt/rAf99?=
 =?us-ascii?Q?vWK4imVF86av2jcUHi/3h1/GEYXL68DZaGQd6G29GXwnN25AKq5mS6tw4cHS?=
 =?us-ascii?Q?x3min00WLteUJNAdhOsSzEdlONXYvyUggF+v7ZoyNv0dubq5k2XAHN8PXXe2?=
 =?us-ascii?Q?7DNwVjCXm2dF/axuByQsb6AFKzMkwv4m8tajvxjVcYkpXdTTryoGgdOTaSd/?=
 =?us-ascii?Q?y0Spgt+9AcF1ODx4jImNK0YmxnuAl2YiIq8XX6Erj/PLbmJlxtLd1tpa6Wf2?=
 =?us-ascii?Q?Wgnl0mSFQYDatdA7OaldIvKOUWunYWezagDbnlDltMS+ZfPL3xBClmPHlD8R?=
 =?us-ascii?Q?W8cQ4bz9iDyoyZPI4FRrg+AQIJKQ1/FgxiNS60uzZbsN0y59XgKw3AIQ3QqK?=
 =?us-ascii?Q?pFoPbOtEtuI9ZHvwX0tmK1YFIw6hmmML6BEbQGS0ofS3LROGbdlbezl9DIbu?=
 =?us-ascii?Q?RcJ5qnzBfgFwmA/P1JUVk8nTTjoJR0v6MqAqnAi+NJYlVYyaOoziz1KnGiEr?=
 =?us-ascii?Q?TPLiDLN3IP3xmSySHSv6mtfQhd/EBThyVdSEAS2k97sdRfJrNNGPayVNNdd9?=
 =?us-ascii?Q?3PBtHXCziLAU5pxCbEuLhnK77qMD39k8yZZd8dpc3939nKxzFcGVrhP+KAAe?=
 =?us-ascii?Q?nUteYt3xkvE3MeV6tr3pudvyfqQRi/16bFTVhdoO2J/tKxp2XLEY0u+FKt5L?=
 =?us-ascii?Q?5xgSBLaBgpYZQF79qgRHKnxMN4l9ylgtsScymiXWEGKPnH/eFAwFnSt5MxMa?=
 =?us-ascii?Q?4zkCisdtb4PnpgyICHorGT78HIqHgL+hyVYt1k5vPSSFKJuq96+7/C8AMLyQ?=
 =?us-ascii?Q?qIDVlHbnEqQSBSyc0HFajY+Dr2WCeNkc1pYQtFZQbQttTCiDtsVegddIzkyY?=
 =?us-ascii?Q?+B3oWXUMJ2bEiV1yP9S79UFhKx0Oe05x4DLcCuNDrTqTlntZRF4q+4Mo/L1H?=
 =?us-ascii?Q?DSKvIkD4Vlv9y8Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eCjdC9kY/IJ+LEPD7Jzn300a8eAKELDPCzUaA5opu9Q6aMhPsbAabX0kmnVW?=
 =?us-ascii?Q?nFJywlk84MuY7EfR9rlCakZnu3MatCUkz5vYoaPnQ9t9qNWZ446mdcShGUxf?=
 =?us-ascii?Q?JPr6MFE91tRPf3rBn4Z+yQ96k97dW50KADhu8GSstFsvZcTKHZb51OuR1qKy?=
 =?us-ascii?Q?jgLs9eaJ9nCY304wWf4H64mABGjLY41cM6TNlAOp8niwi9VWYaCT3Bd9fT/F?=
 =?us-ascii?Q?bJg2tBU97u21HmX8pkFiOA30o/UXZjVVyNJ6hOS668iodwXHpG6lcDWTrI0q?=
 =?us-ascii?Q?6xOWT2u9rm6TAgCgGD2bDSGaTTh36y/I6yD7Z64rKw5j+s+thrxTYUgrFSKW?=
 =?us-ascii?Q?/ExIQgPNOc+mc6ZmaRtt7HLZ2jS/rvX/w+XboKlKABIrAQUnZatSGcZGUEEj?=
 =?us-ascii?Q?VcyvY0Ap4iwtaEOKL/mv4ZjwqObw2vGi43FXjJNapDAj8JV2Lc/LK8IXACJo?=
 =?us-ascii?Q?OOfWguFjNBzlOaFY44mKnwIBucACtUnaIA082kqiJP7hJr9qD46DzLdTAjXQ?=
 =?us-ascii?Q?lo57yVXMJpheLRS/fpCFt+73QxfoVi4stqrH3Qv48GvjC496Ry4Q8dZ/xzTU?=
 =?us-ascii?Q?jtU08djr+fl32b6v3BQpWlPaBPNEqsPJJsybefVnt6SbMBFmyOABqqHY0qj7?=
 =?us-ascii?Q?ktW4miOOFiBDrUPLeEf3GWwTfPgm5psa0WPqVdILB8lC20H41rCKhvLi2cQ/?=
 =?us-ascii?Q?k8+jgiccsIPu0HmdVbmqFpeyEkg3jikkxiH7tMse4mm6LXEd5V0BSWMNi48H?=
 =?us-ascii?Q?GZyg2L1SmlOgtr8ujJBEoGaOBXi+wOS3uHCvfB/YopUD/6yy0WIP4RL8jm2v?=
 =?us-ascii?Q?x94TElXTNbn7glmoKqEZnD4LjEEN3o1avc0ARrmONjgiVEI25RJMyWeje/Ck?=
 =?us-ascii?Q?yWa0ug+27lwcrCLLtCo+DrGOjrnBvgWa/chQ9meFY3ZW7MmgSQe8zUQ8hC0R?=
 =?us-ascii?Q?bvhZB5Cr4KbhyMBLOP4DAbgchgofk0jHGgxSFcKKRI+5bPmBsYdAbc1tE2SX?=
 =?us-ascii?Q?pAUa3ONfPOl1Vo0hs0fuCVib2FRx8mPkR4bTs6+q27BKmWuOrvC2zKsRIyT6?=
 =?us-ascii?Q?HZfMLU9VCB1GDzCLyeqoQHljKxQANEs5/7/FBykaFcFGsqQzSOp4KVmg7p/E?=
 =?us-ascii?Q?Xp4/9puJUJJLpNI+74vClkqvNKrgHYLhM8qvVwZZMLHvbZ71HBhb2APTwc39?=
 =?us-ascii?Q?c9OwKcpmxEbkrJQP26SsLAkSyVavQpJi/aTo4njWw7T4m2UmjgUKf7DGYAka?=
 =?us-ascii?Q?6baIh8/q+7tJvzUzsC3HllgHVLJHMQOE+gVS6IRpPwOwtb9MgqYQN+28qbGp?=
 =?us-ascii?Q?QDncHhS0xn1CzDyZcku7y4Va83YtUc7hzf3GlK8L/LwZoNMc5QItbU5bMUv1?=
 =?us-ascii?Q?kG74RMHb/4ct0v+Wp5fTwgtGvEtnAFVqm5r/M5g6F7aR5R2V6lGWMRhxX6Rr?=
 =?us-ascii?Q?o+d46PR0h71n01ofvkWj1KL32sLf2/VbWj7ow9xMpLlWeATgFTfpIplg1f1a?=
 =?us-ascii?Q?kXZqq8YY0YaO26IJCGKuCAxy+QYpBdabx1VP+6crkec1Avl1FXVRnAoWHgdg?=
 =?us-ascii?Q?HpwVtUZfRDBhy3FiE+35/QoBvPkQuiszoV+duE+Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de36deb2-e344-4c31-670d-08ddba019241
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 07:16:46.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zO2NsQtc33trKOYm0PyG+ADKW3xfI5nqe8FqIU8rC1SHd3buuzJS0iZcoQsMPKgaonaUOrEaoiBpIhE28K+2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, July 3, 2025 11:16 AM
>=20
> The iotlb_sync_map iommu ops allows drivers to perform necessary cache
> flushes when new mappings are established. For the Intel iommu driver,
> this callback specifically serves two purposes:
>=20
> - To flush caches when a second-stage page table is attached to a device
>   whose iommu is operating in caching mode (CAP_REG.CM=3D=3D1).
> - To explicitly flush internal write buffers to ensure updates to memory-
>   resident remapping structures are visible to hardware (CAP_REG.RWBF=3D=
=3D1).
>=20
> However, in scenarios where neither caching mode nor the RWBF flag is
> active, the cache_tag_flush_range_np() helper, which is called in the
> iotlb_sync_map path, effectively becomes a no-op.
>=20
> Despite being a no-op, cache_tag_flush_range_np() involves iterating
> through all cache tags of the iommu's attached to the domain, protected
> by a spinlock. This unnecessary execution path introduces overhead,
> leading to a measurable I/O performance regression. On systems with
> NVMes
> under the same bridge, performance was observed to drop from
> approximately
> ~6150 MiB/s down to ~4985 MiB/s.

so for the same bridge case two NVMe disks likely are in the same=20
iommu group sharing a domain. Then there is contention on the
spinlock from two parallel threads on two disks. when disks come
from different bridges they are attached to different domains hence
no contention.

is it a correct description for the difference between same vs.
different bridge?

> @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct
> dmar_domain *domain,
>  	if (ret)
>  		goto out_block_translation;
>=20
> +	domain->iotlb_sync_map |=3D domain_need_iotlb_sync_map(domain,
> iommu);
> +
>  	return 0;
>=20

also need to update the flag upon detach.

with it:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

