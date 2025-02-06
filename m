Return-Path: <stable+bounces-114017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5586A29E57
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 02:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E5F1888812
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 01:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5226ACD;
	Thu,  6 Feb 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZW4+iGi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F8151998;
	Thu,  6 Feb 2025 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805514; cv=fail; b=k1035AW4mmTAK2p2AH0grPf9pu5utkJf7K/KNVRhtD1SNvdjHxzIOie//BR8rZgj1/nLs/SfWTf0SrHatxHF/Z3D7X+42qsD58l0tVG9aomCqoy0Aw9j+V8IPXJLC+wO9ABsvB1of5OIVkkWXwLqxRmnMmzuFeK0w2RhdlJ6eAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805514; c=relaxed/simple;
	bh=sbJPz5l9iMSD9AtteYa6lzqxiRX+c6gHGFRanK3n/JI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfwlsyFbQ2zT2oN9y7MB3VW2jhClG0pKvtdPHyA+fXC8+qe6XQH7fB39aUy2vT1H1Bprw1gbIfvfsgThnoTnQURNwKqJbp1zE7Rl6whXLQM664ybozzGbuR2Ub72rPL5DD2W4wR/Q6Y/WQxM57EctIekS6OfDFTfVGO/pWLYarU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZW4+iGi; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738805513; x=1770341513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sbJPz5l9iMSD9AtteYa6lzqxiRX+c6gHGFRanK3n/JI=;
  b=MZW4+iGiVaDu7SxJTLfE1Wz9Jh4etm3AqcYJ6zYNoU6QzdVPFWiy8Vbm
   A3xE8Y3OTdkSdtAuRPhGsJwf3At4Yik7zPE+l8zcQpay/IDbzD1gMwcTc
   re94vvrpprKATlu4Kov7kSINIdEjDi+JeF1eF6LOg9ilyH8hd2iOFmpk5
   cS1QO9zwAygSyRvVvPd+GnTGvFkyRqQ9QpU6Wmnikjujgb1si3Zi+jVWg
   mUesTp0EAZJqdozj6Snf/QoCvMIIKWClCG/zUTeJAosnT2rArGoipwCYa
   DmiLYpKdPaU7fSn7+IhtJdVd5noObDS5c7LcOdU8Kj7KvrFrWXrIa+Xxl
   Q==;
X-CSE-ConnectionGUID: VGR/ns0BSZuYra6eIcup6A==
X-CSE-MsgGUID: og36zRV7QkqIwyWiGUURNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50380886"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="50380886"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 17:31:52 -0800
X-CSE-ConnectionGUID: bSG4dlILRO6JpL3SS3g8gA==
X-CSE-MsgGUID: iHSi/VYKRGWdF2PY/w4b0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="141950870"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 17:31:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 17:31:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 17:31:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 17:31:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP5pJoiaaUTTU9sS0wfzP4Mub3utai58Qxitzi5UJFe5svuJ75r4ytiPV+I4VUnXiJj4vOon52X2Vb3wxuRLaS2yV2cNft331bsPJOrF2uue6XIynDkrgORp7eDsDnazoDxdEMTx1x5coNqY24MtES6/okmigNsi+ZZqY3hj0iNC51XeWYrNdT4+R5ifyK+7wugSWrWllOhQ/D33yc4KX70io3CRAituv/b0hxFgitWv378KNT9ltC/ahaR94pcV2z4dVb9+7lRyQnFEigTlPisDgRc2XTugDUTlGKF8oDcaUp9/vKpyGEk8P8xvZdczVy+FjshOfd1c/wapq4N9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai3kdENfyKxSaOQLpfCmlbL+BnNN6qo29qrcAys31EQ=;
 b=U+bI6Rok3deXpHr3H6nCCaQLU6tFiEzcqHI4Ca0/ulGxil9Eoow0oQq85SujljvQLvE89424vKErcYeJMILadxvqmruNukWzsi+cORj1z78tsGmh/GFSorDl8b+awKO2ScKxHBlu3gpNNiYQxRgNNnwHT/yw6ZmvGHLXulzLNTITMd44fcW+ZMeCZPeCo/qcx0Tw56gys7r2OOHv+7rFsjtPLTQqW8XJxCnKadXfDiLFRoz4fY+BsMEBF17+KKtJT9MYlcoAyKu7NuL7R5TEawY3c4eTMMQF4SYVH6Jm6OY3zzjqUCaR1MM5WyDSkU0gCZ65GTuoZ22UugAeiBHRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 01:31:48 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 01:31:48 +0000
From: "Li, Fei1" <fei1.li@intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>, Shuo Liu <shuo.a.liu@intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, Zhi Wang <zhi.a.wang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chenyuan0y@gmail.com" <chenyuan0y@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drivers: virt: acrn: hsm: Use kzalloc to avoid info leak
 in pmcmd_ioctl
Thread-Topic: [PATCH] drivers: virt: acrn: hsm: Use kzalloc to avoid info leak
 in pmcmd_ioctl
Thread-Index: AQHbcw5Hf0B4pATANEiram18jmoqybM5hvEg
Date: Thu, 6 Feb 2025 01:31:48 +0000
Message-ID: <SJ1PR11MB61538E0E3F5DF58CB528C90BBFF62@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20250130115811.92424-1-lihaoyu499@gmail.com>
In-Reply-To: <20250130115811.92424-1-lihaoyu499@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|SJ0PR11MB4864:EE_
x-ms-office365-filtering-correlation-id: db58900c-7d7e-49b2-6928-08dd464e0687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V0CTYkCpin7lSW7PPaFaVqHwn75mYam0GKzixj416CbpSiA6SiknuILwEelQ?=
 =?us-ascii?Q?m2f3mkc425j1fgoZ6h2RB6ZUZrWubgOdk6+fcY6VuPfYAGdZwptKF+r+Dt40?=
 =?us-ascii?Q?3BNT7UmNQjFBRR1pIDw/Z3GNeHs+clA8avjW7AItd969c728uUQx3wPZt0az?=
 =?us-ascii?Q?Kh8soa9VUb6xDknVkvdfnPqhER3Fkx6xqjim7j0UNZiF3UVF3LuSusWS8kO+?=
 =?us-ascii?Q?Q0Qej4AsibV96XZ7r2Fb5OKVJ/7xJszIZZZSvQxefdXs/mNHIQGMU97hgJPb?=
 =?us-ascii?Q?ixozpaRiZ6C+sLSTzLRemr/42z690zx9jKuruPEj6rsgFeWNLfOC5zp43egJ?=
 =?us-ascii?Q?dhgmDbLQmRRtIKtrbjCDE0oCI7WxRhJqmu2+BD6WhvK+JhkPjZ4TwrYeFeiJ?=
 =?us-ascii?Q?wfuj676QoRh6jE6gID9fuQIIzQ8BLE+zi44sXv8DMPvN3V+JlXiPa7mtbhs9?=
 =?us-ascii?Q?y+Y9ZuT9uMdetGVAXDaL3BQeWKKCOE+FmIVHH6jq8qtDyEoV2Ucwymhg43m/?=
 =?us-ascii?Q?n1CJ0GJGck2O5r0jxoAwzZY3DNKBQtd7iguRDpTCF5WBLWwTjS3CIotfXh3L?=
 =?us-ascii?Q?/RzY25Mn8pJMdxP1qh39VvSYJTbuRQV8C/Qd/I0HUTFf5N+GL0SNYA6N0AXT?=
 =?us-ascii?Q?Tzwq+ULjFUGMeqZl/SOaU+IoNuiV46oxq65X47igjT5fcbSRG09B4ssmk90Z?=
 =?us-ascii?Q?+bZgKq0NOxDKt5gqeLe8XFJW85NvkSv6QYDYAOoTATT1Gnahh71fez7g0LPQ?=
 =?us-ascii?Q?yG9yasJQbhWdk8veaLK1iOLEaqRasN7kW+wEjbnAA2BaQkT6Al988/Su+tqt?=
 =?us-ascii?Q?eSTScAcpXpdXEQIQD02K/Zrv10jpjVODkAaatosPiaUlXWUw5RmXik0gZ2DE?=
 =?us-ascii?Q?WtGvb8GxVLI2aQGjkchvudLP3jZ1GU6dOH42ivvMlw/COagC2HaxkuNfoRl2?=
 =?us-ascii?Q?gcrS82/xtcTqwr32IxYFkh1aO2INN6fpdaajmlA7CxeilvSN3EV+p69+aSWb?=
 =?us-ascii?Q?uTC/InBSeo4nN9Nf+rwd4JcxVYOQnwFz+kXuyuCVrDrrLtuCDk4CyIQy5hii?=
 =?us-ascii?Q?6mm1O7x3y3FqRAOrY6T+zNF/9Tesg92a7bU5sfBUGucvlGNMo4hNSW7AdhZV?=
 =?us-ascii?Q?y7dHCKoct8ia+mGPeqVopLx+oToHgOEKV20hxOdk6ImtdKqISbRcy9gUxZcC?=
 =?us-ascii?Q?NJdp2CCW95NPeJRzN1N5Mbb6AMYIEGyTuS+3tauAmoIqs3TeheNFUzE2N2bk?=
 =?us-ascii?Q?srO+Utlb3GmxbNLymm88Q0HcpFczSTziST3wkjPER5dW2nYC1Oyn4aM7Z9Ok?=
 =?us-ascii?Q?31jxe7dPcFlcifpIB++5nb7cP4Qv+WNm9qJKWV6BlY09fCaapeq/c2yKcYgr?=
 =?us-ascii?Q?BzSNb1eDqel0F1ewnqkngPgr//s7vETUGWsgsrv0aHkFxccmCdxMae7LW4ky?=
 =?us-ascii?Q?IOGmm4rBbzITJITl0hWBn7jBlchNarVL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lh8P+gYl/f9fO4NYLZnxUEU/N2M7HAgDGuToFnigfHTN+zbb8Uyji9+bFEhy?=
 =?us-ascii?Q?wdMZkFAmpGbjjDhJpEGIEkg9nHzI726x9I77kJxASsua4wJ554CRkHwvyBHq?=
 =?us-ascii?Q?C1oZ35U8kwBp+DtDz/R/7S2b98ZLghIMAIeUpsxE1FBRZlhzo4oXiLqad15B?=
 =?us-ascii?Q?FloT6cvEiV5nRb2VGkKR1ecjFF7XXq/t9cD5whzU5G1aFgxgpF5Aw6XFx7L+?=
 =?us-ascii?Q?RTio2jNUeVHFNL+orGF62OFQINpUidpNlIFPgiOAdzBHsglD+WiRvnF+m6mL?=
 =?us-ascii?Q?GRfXBB873kpHRDxHJeBz9trkXLhfI5nY2Q9bxOVV3f0FJAktt4H/4VAedXmk?=
 =?us-ascii?Q?F5zeIaScOfFApEz8PYqCDfFjrt9koiTmafdpq3/kItELkCzJonKesLoHAtJt?=
 =?us-ascii?Q?UkW1ibvdDKJkwR7KS9DmDqcjAcZVbvKViNJBMz+DJKuWmUCJVvXwxkZsIWPo?=
 =?us-ascii?Q?dKbnDMgersIKjP5WCoMiUqVkOxtAIsSUVSRVN2bQ+gA95ayY4rLMnCbtcAMF?=
 =?us-ascii?Q?kjYEyOUOlF/V9CnhinCVhvKsoBI9nz6hLEC58bTzPzTtOpff9B9Ro8wK1JeY?=
 =?us-ascii?Q?EPafdeiy7TXkt+vqp4FN/U137CoTm//xdolaGclUH///c9zW2HqZU0mlmxhb?=
 =?us-ascii?Q?eg420B6dMXBAxQbrjIaRa8P9GlX7OULktC6eZ7XnmyepDGlq4AOSLDDSY3vz?=
 =?us-ascii?Q?E+hpeeikZy0a6tugw19BrmifJIrPNZxfkRiZALACbKFP46OryNEzQpJTzMeo?=
 =?us-ascii?Q?SOo8qIE3/JJEdlxqMWf2QNl3Z6OYaZT+W1apNeDuYeVJE7d3mFGMtRhFscZH?=
 =?us-ascii?Q?jGikZcvLyAN4UflnTe0wAfODCBD469i2yHHw2Z34GlXmx9k88pjpVksXuGeA?=
 =?us-ascii?Q?bFhlmIE07wxhdqx6k26fK/2SC6z8SFLK7j9FBLDhs4uhlSuSceljJjwvdkuC?=
 =?us-ascii?Q?R5Pu18oIgOlv22BC0iq+KxO+s22NvOLR5q/3DK6E729p16vQDPT9+ETe/MzN?=
 =?us-ascii?Q?n5x9oztEaGEwVaNJ4Z1p06eGYDfS9cqdiRUOgLXUub96yl0GnqS7Y6FTcHk4?=
 =?us-ascii?Q?Jv2UAZgO8I3x/pizzcEHiUoWgY4eRuhaKuhVD3CQ+pZyC2KEs7Wk1W5sPuUb?=
 =?us-ascii?Q?YAxXaiO0rQ30LwHA/ifSjA9IlG6j8lK/lCpJWUlLtDV/A6rS0b5bBqtHnIsV?=
 =?us-ascii?Q?liG87TbMHLckiyVGe7Y3HrdaCrtPpschY8UyeTIdnJVw//htbTUxrr3XMJXT?=
 =?us-ascii?Q?xOSY/we+qIBd+IvwM0SDcnIQfJKVeOn0h3X26z30C4HVtCvq5ZEjjvpE5ufb?=
 =?us-ascii?Q?EuRlXp1AkrDihyQcx2aQ7XTAtkx1h1+Ce2YbxhGmOH554e9dbsgWGp4o6iCt?=
 =?us-ascii?Q?t5/BSEvnOwBWxxUvRi4qzlgwmcIrzHbrcZPkAkAA+GIFRBENYgsZtFjS3MF9?=
 =?us-ascii?Q?Bc1b1fmh7uEddQLw11s136d1kI2IX+5mmkCE2H7fl87SbueJplgFdK9VUnAY?=
 =?us-ascii?Q?wZYJLdIXfd/0rSc/jFk+Moy5uFkItOoeIWv9ui1Agr1iWO6I92QHD2zjpWwC?=
 =?us-ascii?Q?Vi5BXwC+u/N7ajGqfE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db58900c-7d7e-49b2-6928-08dd464e0687
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 01:31:48.6879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZAHhM80tEM3eJlLxg+lHNe4XGjqmfVumkqN3lJErEflWL9gqezNSAjaX+nbNxBzx+e+eZIClEUqhK2zPopXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Haoyu Li <lihaoyu499@gmail.com>
> Sent: Thursday, January 30, 2025 7:58 PM
> To: Li, Fei1 <fei1.li@intel.com>; Shuo Liu <shuo.a.liu@intel.com>; Chatre=
,
> Reinette <reinette.chatre@intel.com>; Zhi Wang <zhi.a.wang@intel.com>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; chenyuan0y@gmail.com; Haoyu Li
> <lihaoyu499@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH] drivers: virt: acrn: hsm: Use kzalloc to avoid info leak=
 in
> pmcmd_ioctl
>=20
> In the "pmcmd_ioctl" function, three memory objects allocated by kmalloc =
are
> initialized by "hcall_get_cpu_state", which are then copied to user space=
. The
> initializer is indeed implemented in "acrn_hypercall2"
> (arch/x86/include/asm/acrn.h). There is a risk of information leakage due=
 to
> uninitialized bytes.
>=20
> Fixes: 3d679d5aec64 ("virt: acrn: Introduce interfaces to query C-states =
and P-
> states allowed by hypervisor")
> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
Acked-by: Fei Li <fei1.li@intel.com>
Thanks.
> Cc: stable@vger.kernel.org
> ---
>  drivers/virt/acrn/hsm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c index
> c24036c4e51e..e4e196abdaac 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -49,7 +49,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
>  	switch (cmd & PMCMD_TYPE_MASK) {
>  	case ACRN_PMCMD_GET_PX_CNT:
>  	case ACRN_PMCMD_GET_CX_CNT:
> -		pm_info =3D kmalloc(sizeof(u64), GFP_KERNEL);
> +		pm_info =3D kzalloc(sizeof(u64), GFP_KERNEL);
>  		if (!pm_info)
>  			return -ENOMEM;
>=20
> @@ -64,7 +64,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
>  		kfree(pm_info);
>  		break;
>  	case ACRN_PMCMD_GET_PX_DATA:
> -		px_data =3D kmalloc(sizeof(*px_data), GFP_KERNEL);
> +		px_data =3D kzalloc(sizeof(*px_data), GFP_KERNEL);
>  		if (!px_data)
>  			return -ENOMEM;
>=20
> @@ -79,7 +79,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
>  		kfree(px_data);
>  		break;
>  	case ACRN_PMCMD_GET_CX_DATA:
> -		cx_data =3D kmalloc(sizeof(*cx_data), GFP_KERNEL);
> +		cx_data =3D kzalloc(sizeof(*cx_data), GFP_KERNEL);
>  		if (!cx_data)
>  			return -ENOMEM;
>=20
> --
> 2.34.1


