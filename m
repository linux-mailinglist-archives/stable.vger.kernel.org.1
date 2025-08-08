Return-Path: <stable+bounces-166815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4EDB1E0BE
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 04:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E391518A1710
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2419049B;
	Fri,  8 Aug 2025 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOsFqKfy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266C129A78;
	Fri,  8 Aug 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621872; cv=fail; b=HcgHPCyh1E1UxiLbgbQBMaS3KzUclD+dXN8czQXsge9Fp1ilSneOFSOZqwYt/r+36cvcYXoaYkWSylSmPuzNd73dKHWi06gj2ErnVl/to8lTdcGNss1e316O1ykAqywh7vCGRxPPVBY7wXKKjOxhVH/W389pP1qboOwnP0hZ09g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621872; c=relaxed/simple;
	bh=+217jMVcQUv4wSCdXV2CoYt4xs7Rcl2bD/80HS6JhMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUKqQiQJpdcimDC2yiMz2G6f2RvaWS1KULG3FN1eD47eAOtE612T+lxsDfKftDvHi0Hv50K7paacKOFyEX3jY92FlUgU+mjSL8RVVQOKglYNtWgsHDBaPSYQAxvcwU2UFrrNM0ozdnzP2Kgs+mFTaEEmg4XaK5p9W/G9yaP7888=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOsFqKfy; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754621871; x=1786157871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+217jMVcQUv4wSCdXV2CoYt4xs7Rcl2bD/80HS6JhMY=;
  b=lOsFqKfy7VhVjFfbmoDcT/vyzcO1TeyNY68Bd2dsMpbivOD7KxQysrcr
   YG0fD8gKNzPL4W6JeEKJ+nMQS4yP4ks/iAUjZ4RwrZ2xk+ebC9Ia5O9rY
   aAmOuFDqVO6zJRqqMM1LDO4PgMJhGFvruGo+MZt+4ofIuc+XMqnOUBP+a
   n7lEKkIg95GqQO1uJ+/7Hom//M2zAG8fHIN5VlfFvfIlb0y3GMI0xbJHs
   /BffUMzWFUF/1r+myE8Vj2dhI5I3ElkIvSQ/Iw4+pK7ZDuqn/wgu6Cj1Z
   E9oqk2qnfpNvUjx2tyxIFvPbRfBCWOgQlKbDilgMfQIhOOb0nyrzN9dqK
   w==;
X-CSE-ConnectionGUID: WKHmHYxoR6GhdKEh0ff1LA==
X-CSE-MsgGUID: twY6C8R9SfCMA4jLcw26cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56684482"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56684482"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 19:57:50 -0700
X-CSE-ConnectionGUID: 2IOcvw+1St6vK1d4+C0m+w==
X-CSE-MsgGUID: WLFQyVjhSgG9PIAit5UtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165607470"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 19:57:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 19:57:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 19:57:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 19:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfbigzE2lGTL2X5JCUCNcGLhtTxeGXaGBP6N6g1tLx149jvt+AqFv7NBzwq4m7P0JHaOJ3jTel+kJsz4VSS5+Z1XNjVs2/I/nux6IeiBhkAqQWlB0SszKl3aUQ/lWq6+OmQ88Gw78sfx3lvVovkdkqPqRad2xOMfmIp9lgQH1UJJlOpB74o5eiF7t+Sv+U9Sg2QqA2Scyb9UyfB5hbceOVbhQzU8yqt2pDr87Iz5GYLkcrpjUJ+HHfaSz8gs8fI1vJ2D00RvOzlmszw3E75yIChtssrJWfFQ+4nNzCU5+vxXcTNQo1gsH8BTwH/hIhhENyS4PQcC2TefblMzsd4Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBpLBGnJeScH8/0TFLy6v2nZbreQb7bcHRGBDo/0m2Y=;
 b=OsNZWmzU6NlryQx4Yf1+PbgexTVE0c0gB4aiYMetq/N2aHdTR7Ni5oy5sfKxj9vsq5Vc1tohwbJAgTS9jbbHNHspVQ1mPmJsSXpwKv1VhpUPo6FCyh/NK9RUgTHHj3oicEg3WSqVm+ZWEzalk/tlQfagIFt8wCbHtGnNgMlCUhPmze8un6GBnYMuocyuj1ostdcWZHhgqMWEtZHBJM8DO+isRA9olwcGNBhmwKL5qoW/6K04kauHHHYX4Es8ELIV75nj58aNEJBKRC81IPVfCNivCOjcKQfalvRqWts6j1Hfi5QsqtFULQ+D+2maEzB39CWwiavvQr3XpJPL8Lokyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 02:57:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 02:57:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jann Horn
	<jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple
	<apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki
	<urezki@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHcBpLRgrfnVjVEu0GV5qP87jgc6rRVuXIAgAANmoCAAANigIAAAUgAgAAHBQCAAXKbgIAAVvcAgABvkhA=
Date: Fri, 8 Aug 2025 02:57:46 +0000
Message-ID: <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
In-Reply-To: <20250807195154.GO184255@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8226:EE_
x-ms-office365-filtering-correlation-id: 3298d24b-d6c1-4ae2-e2ca-08ddd6275a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KIkNpDOq/KDJuJxhP3gwCeYyB+KpW2r8bMaYt0BqYYAzuSVjZOgK+uPowK4F?=
 =?us-ascii?Q?cZpQjVeQ9tXvVyGBEaWU9BamW4dBTiz+GoFPpnDm2G6bumYeGaetxkFhMZmG?=
 =?us-ascii?Q?aiXRw6BYJN3Xl0SVWDuK+lRzyZY5JWTDOaeQA0QFIr1hWHLFvtGxuZTEjVm2?=
 =?us-ascii?Q?vatCZwkI5TLdKBi1rJWmfbhbqUdfa5iLOLTz9iiDMKABRq5Ftt30/VN133yi?=
 =?us-ascii?Q?lzydTMVLjIFBVSrqVlAQ5dTmoqixdERc388rioN0GjKUeKtjPYC8qqIddpP+?=
 =?us-ascii?Q?9V048E+6N5MlgEu4Pc26HW9IpQ+ZKudQJ66RkjiOQC/RQj+/dP5BEkgdxCPp?=
 =?us-ascii?Q?RkCI85JmS6o5Fs6ZP3YMAzZX9xr3daU3Qv3a4i3FSyM+O8Ijo6kAgBj1Wy6t?=
 =?us-ascii?Q?1bQ2QZzAMjlzYNcvvhONqDx6d7dXPi6JWwh7atxVI3lEcp9soKsoTaEdaLw2?=
 =?us-ascii?Q?gdUwLRMQP2wuwp+IhMrUQB4anQBs7586oww3BHtmb4ckBEHZdKN++IFpNOV1?=
 =?us-ascii?Q?mH7RLWGeJJx/G6bE1fdJxDtFy/zpDQky1Dyzdv3+/09o92IYcLFKg+zRILRg?=
 =?us-ascii?Q?ss0mEek15eVYCAOx9a/F+uxZFNL/LtFmwOA7pfbdE88TOs/gsukgO9gDdCaM?=
 =?us-ascii?Q?uKoZahM2YCh/px2W54OVCxmCxlFGi4jod42o1IVt7u3g0UYcTeJx8P4vucx+?=
 =?us-ascii?Q?lYjhs8UVxzxWSedvcN8gWGMCmn0ZEyDIqAIcra2dYKnS32j9fexu1OmuSs6V?=
 =?us-ascii?Q?yzkhg7j7+5HtK/Fmr9WyP9d1YMUR1wkaALuYEGOlpS+kBo8stepgb+Et+Ujx?=
 =?us-ascii?Q?JnZI6qmO2g2NTohyUBoIdm4tV70deWAW79oOON39wwbYMv3ENSD1aKpCLpJ6?=
 =?us-ascii?Q?0HiG4jnxrI/NvZ7dNbBtYJPzHlSlOQuUsK+zzcT7TTW+O5wZtINtjnIu4EOi?=
 =?us-ascii?Q?ik/v9h3o4DGwLG9UDvvIQ7QNhr79VpZXC91Nh6/5l5qB+MgAJOAbX2fQLLeK?=
 =?us-ascii?Q?x7oMHTcDe62/8Gb7fU9yeaTWFTPltINnOZdFJeuhhdxdwALtLmXd0QM9FXAr?=
 =?us-ascii?Q?K400hP+ed26POsNVi2s+NIQH1A2CwwzY8NsMCTCpLEf3bjfkQOAzN/FbppBp?=
 =?us-ascii?Q?wmhyKgWElbdjqu0/ArK5tGp9yYgY5OQJMrgX/9iaU0lReumRItCube6BEoP6?=
 =?us-ascii?Q?T14Gn1zqPs4n02uQPpo6c2TCjfdDHR6IMxhjfQbLA3RMUMGLgTi4Gw9HjrU/?=
 =?us-ascii?Q?fs49S/GCeRj5OVMxgFCCpzDLIMJ9u6LCBbP1EXS5f9dqiXOxbeSEx99dg3OE?=
 =?us-ascii?Q?cC1vbyAX/kE21w33tQSx6zwnB000lJzhx9Jrtxc0NBxCrauW3xUsXn/1LT9A?=
 =?us-ascii?Q?qmMi02P+BNIwml3Z9sXKYrBGV0lRwxrVj6DjK/vO//jbMGbOdgghxTzKhlGt?=
 =?us-ascii?Q?gvbygr8Y7YMPMccqMkfjY2i/ZcKO0zSzIEhXG4GsGjxpFxIjYQa6zw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fz41gr2JaZd3LfJJ3CGYNdNXXd55gZf8DzYi9N0Iwehx93jGMgc29UL/SdqT?=
 =?us-ascii?Q?+udYm1LfKmbHia9Zx06MC3m2mrxTCV4VS2J2zGmzu0BdaLS98E91uVhWphLr?=
 =?us-ascii?Q?m5T5UIIn1hfmiP7Z/HqGWSqjCz39CflTWVgJ7Az7rVJz66eaC62XEOfaa/gb?=
 =?us-ascii?Q?Tg4/gQ9fuz1tTcKw3At1XkCMrsi9ezw56Pj2HSdnVtTHcmEsuy+jY86GeNOz?=
 =?us-ascii?Q?shaoYQprlERIN9XjwK9WF6WfF7cBGTFgjYqZa8dORYVQ/KkFzxYFdNi7zZPI?=
 =?us-ascii?Q?lfE/2r1vJsHkJ2oLFdGH9T9fq+8akqiSUSm8GjItNK/GJwDhzj/tbV1hROZr?=
 =?us-ascii?Q?916Wr28WqBbdFEk1BYOi48ON9GeXA3sDleeLVFcNGfSHtyEAac475NLd5/kT?=
 =?us-ascii?Q?utwt7LVdACWeUc5gZZKwIlhDwVlqM9qtg7gmJ8XT7nAHdCnlZ+jE3zZAxsvV?=
 =?us-ascii?Q?EA25vnYRfn4M7xcMV8YX3SLh3u59LZ+MXQ1aoyXxDRMU6SXL1wy4Xk4fGP9Q?=
 =?us-ascii?Q?6gGo6KM5+vZzHrMt4d4VGXJXrF/MPtC0W7RaDoRVZMifluNJflhdn50++TOX?=
 =?us-ascii?Q?9aHtBK8CyEAGnhuK+xG7aZKQUzGn2dFL6shL7yOYTmsMXJ6cszl7+tRWE1FA?=
 =?us-ascii?Q?XE9gO5kT7NUrX8Gzf4moOraIc5Qodl1Daq8LVae01JzNpovp1Nvww0nEg/Fz?=
 =?us-ascii?Q?Sg+67vrL6HHqGZAQfpdo1/Oqm6QbU1+n4DEYIb2plIwVHkzKL6hBcXlUlvxM?=
 =?us-ascii?Q?DcW4Co3tUkUNkXac+z4D4ynFkOtj64ne/ibrjTVbTEjDK9a13Hid4tU1vQhw?=
 =?us-ascii?Q?x6ry2EH7u0GKbBNB1oTl/DmMLkT0xZZo4C7p1FHwIvIJ/bzxE6RzBHkHGJ2p?=
 =?us-ascii?Q?Koyh49MLEBw2tgOvCNE1LMB9etSrvmamY3lFDVez9JWKdGSJuAm0plvK8roz?=
 =?us-ascii?Q?u9oeFSGalLq1/2kD7VHw/oGOd4LoCO6nMlXzHyho4woE2ggyIsYouV/qIgIt?=
 =?us-ascii?Q?aK8QU5jmtEb4TteRfBsbeZY+WVBIBQIt+p1OtKvZgj885SUiCBmB1OI9qGBe?=
 =?us-ascii?Q?zrRj0nR+Ve3iR+iqZst+NxgZxoc16Rq7gU7Rt/DqQ6jxkzKsRNH3lhiuy1VE?=
 =?us-ascii?Q?7LbURGp1ujQZpa90qbpnnfHWfptwzHhwRFZPikTUf5Ulu/YXW1irNjLMfCrH?=
 =?us-ascii?Q?iHccAG9KfNfVxyuw2OCHoLL9o/beEUSvY5BjxGvnG2D/KEFLVEm0+TMS8MeV?=
 =?us-ascii?Q?zxfdq6vSH3bFxzLpXos81bgiZlC3aGa+BK46YY4c0Irr6+SjkrIfySkBc2QV?=
 =?us-ascii?Q?Kz6yYaCh8YTtqkZGn+Bfk5UT3J1ansprVWgTyYxZdMajigH8y4OO/Qw+vb8v?=
 =?us-ascii?Q?ctF8uuP1EqOaMqw/o+U0cwEpgeqxDHZfGyERTw6p2J5DEy3Ep3r+ul7fy+yS?=
 =?us-ascii?Q?nIx5a0k9KiyOCOcReS2h1tRzrYUO6Yav/fp0gE8wBmcAn4C1SDJbV9WV7Gqb?=
 =?us-ascii?Q?Xe9oxo98IqfcQRO95qml3Vdxm5J/nV3YICWyDpqNI5DGeWhDYqW5ivLJIN06?=
 =?us-ascii?Q?eysGpD2FxfpiCe2rSDh98Mmby8WfTME6QFUBNRTq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3298d24b-d6c1-4ae2-e2ca-08ddd6275a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 02:57:46.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7dtr8JTvvRtC8njoP45GQNzfEM41svm1bX45AATWFerxFVqI4CCXhKgZSxfP49eO3x53L7W7tP+UV724pjrqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, August 8, 2025 3:52 AM
>=20
> On Thu, Aug 07, 2025 at 10:40:39PM +0800, Baolu Lu wrote:
> > +static void kernel_pte_work_func(struct work_struct *work)
> > +{
> > +	struct page *page, *next;
> > +
> > +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> > +
> > +	guard(spinlock)(&kernel_pte_work.lock);
> > +	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
> > +		list_del_init(&page->lru);
>=20
> Please don't add new usages of lru, we are trying to get rid of this. :(
>=20
> I think the memory should be struct ptdesc, use that..
>=20

btw with this change we should also defer free of the pmd page:

pud_free_pmd_page()
	...
	for (i =3D 0; i < PTRS_PER_PMD; i++) {
		if (!pmd_none(pmd_sv[i])) {
			pte =3D (pte_t *)pmd_page_vaddr(pmd_sv[i]);
			pte_free_kernel(&init_mm, pte);
		}
	}

	free_page((unsigned long)pmd_sv);

Otherwise the risk still exists if the pmd page is repurposed before the
pte work is scheduled.

another observation - pte_free_kernel is not used in remove_pagetable ()
and __change_page_attr(). Is it straightforward to put it in those paths
or do we need duplicate some deferring logic there?=20

