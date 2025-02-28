Return-Path: <stable+bounces-119965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505AA49F24
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888407A40DB
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D827424C;
	Fri, 28 Feb 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUfeBdLA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756B272934;
	Fri, 28 Feb 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760955; cv=fail; b=NmXKkNgJacp0p7CHq/NiK9Qe3IP4vp+gQAc4pA2vadBWgZzCOPyHnCoVOofP9s86arprmUnrbsnx9LTI+hxgfUhCz6N4Yc9i/Bk1g7DKpc9ucBCxt3TaGa0/4nPcWnESdVqNWmt+yoCL2lyskePcUUqFApYwAOXTWtrirH5WYL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760955; c=relaxed/simple;
	bh=WjrqHc+KWmBt5Mhx0+6f53u00OXCNaCG1dfMgZJGDZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOqdFHyHhcBKqVb3UXn6QU/2lWXOgic8+kXeJSj4fwt+IckzceKyBjPfFhoKClE6kxbNgP//xGgSjCpE21j1J9YXeAVWrLSMj8syP7N10kVFfDQ4hAaDrChTCjD6HEpZaCy/zXNYbkRXBHNTeTFqM6zsT/SrQHqKIi+MAQ678w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUfeBdLA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740760954; x=1772296954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WjrqHc+KWmBt5Mhx0+6f53u00OXCNaCG1dfMgZJGDZU=;
  b=JUfeBdLALLRbKwcy7DZQ79YWLbhBx3rSsVlmcQUxYU5FWJm0K0UrOxTD
   lujog/Rc+UNP95AEfCmwoXTXwwXliO5Fet77F5B6pMYLOp1Zxn28ufUuL
   KRBTUrOlt1QMi1bgaz75ZRN1zcK41oua7to4dJwGE5/lqGWBFEsPTbcHC
   6Ccu2VSiUgE9Kkh0ZwSHZQ0OLUVS6v0I81CGwrn4m/P8cVMOw7GcTfXvO
   CVvJuWbTwLqSsIhc25VlZIbR9shVGTjgWGj+HsvbujTH+2TY6ggbhBh3F
   tL6v3+i22NlyNin0FE7zLK8ZAtItaC2l0ydkesr1QuV5AIkCelVhqV7Pt
   A==;
X-CSE-ConnectionGUID: s48YUr0sSwmKymHuJ5O98w==
X-CSE-MsgGUID: dO5Wm12OSwS35WqAov9nqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45347175"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45347175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:42:33 -0800
X-CSE-ConnectionGUID: HZkj5iyHSqa6MatnawSyvg==
X-CSE-MsgGUID: hXqDGoQSTMe426utlzFnPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122521403"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 08:42:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 08:42:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 08:42:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 08:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYP/nwHQyhWhz/lmzK6LnlfnjgPpPBxQHoiy4O+yOR/++LsbTaHvTB+w5ys1LQK5oybInjtYveirNB1c/5sE0HnybhGE3W+u3JZB8jf6MzaBBbRs7RP+NQC6uLjcUPyW+EySo2K7DDROjdQTAlic/kb8eccXLVPOeVJSdPhChdwXyZwHbDKTL47VZy/bCnBrzv53AwRTWrW37oo1oh4tx9HIdbKdFJ4gUiPTN3uOigOB6TVLCtRl38qsif3ePKONKwDCe0WA5Be2Cvqm9OY55LGtUqzhScBUDQcyzohgm6g9d6gmc8ClEf54ILxkYo5tYFxa/pToWrSVLxwFI7MmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjrqHc+KWmBt5Mhx0+6f53u00OXCNaCG1dfMgZJGDZU=;
 b=q0KBV5+pAKNBnnlDmFE35Cyu0dxNxQt7yuobYRziAklMX0C02RwJkYdtQ2IYDuhRdFKHS9t6s2CPR8K59V1xEfjVwBA63Xj+tTZyjgi6F90q2n5gPELKPlpEhLzLQ/uFsAObwOloeeL/dwrTj+8WCLse2Ia6tfZGAw1TzGPKCJ8XHKlpwM+nEb6WCnmeXJkxLxij9bzOLTtgAsfd2a3UdUkQ8wrfv6OUgWeVOfNZos9TuJ/l9hBDX+0F4vMo2LuqsooCWDoEEpBfutM6hpxhZBumfzdXXNszxGzebSYNOEtIoLHLtGlwh89HA4ejZsJVhi9rxTrD/RiAJw6LoJiQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:42:27 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%6]) with mapi id 15.20.8489.023; Fri, 28 Feb 2025
 16:42:27 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "Glaza, Jan"
	<jan.glaza@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>
Subject: RE: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
Thread-Topic: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
Thread-Index: AQHbifHJUbRblPDlnkCbeUg+aitFK7Nc61UQ
Date: Fri, 28 Feb 2025 16:42:27 +0000
Message-ID: <DM6PR11MB4657F455BF687D28893E3E9E9BCC2@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH0PR11MB7543:EE_
x-ms-office365-filtering-correlation-id: 201d9019-bfda-434b-4695-08dd5816e2d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?97qF0YQZ6OD5k4q/WS2mRarFsB5X2OQhpOH9521Ljf6SuH998JE/h1G1F1y4?=
 =?us-ascii?Q?h9ySDonMg3kCzpIKSD4MtgA7vCVxDULe+hbktq2jM5K7RoSn47LGS5AzNnrV?=
 =?us-ascii?Q?VHnWZRNEe8jq+FtlwJ+ElYZkOOWSn+LcDY4d6gy3zq3nn/cdOQWnJKOqeB0/?=
 =?us-ascii?Q?/2oAq7JpK35vSJ8chM+KllbYWZh9CZTeEt8H8CE4W4IEwEwzRkFdeQTnDvR4?=
 =?us-ascii?Q?HFAeEJ3/jkodIE+7EAlD8YCcRx8xxIzwP2/2yQmdfh5DXxpnb/TlXEfhR6Au?=
 =?us-ascii?Q?xZ0x2Fx2I3CrsZnbwB4wqyr8f3xf7jNZKGSLYGPtbBoUgwyfBkZ3sdnyYNm6?=
 =?us-ascii?Q?cKCi24t9OyedgfEeIqTCsV4WooYNXCdxFUlsqH8ovhZ2h/UlYxAwW7WDvCSj?=
 =?us-ascii?Q?ebdy1kdLzBFGQ3SQfL8JKHyzHD5BUR7fsCUiZhX8YMKl6Au/rylWx2VrwlEH?=
 =?us-ascii?Q?KVK3wOYHxNytLntDX1OCzTBPI1al1mR+9TKkx4Wx68zrbekY8X7DHqJ4hj1E?=
 =?us-ascii?Q?Kw5824gj8T5Rj9pPM74wgT2WGCK6wyUkN+nnS3gLPpBYh0Kj8GB/SLIY9lhi?=
 =?us-ascii?Q?ZX8BVPFAExRNnD8J9z14k5lLkc5I/O/Hw83XKogJzNtpkDCncQ5Y0TwJaVj4?=
 =?us-ascii?Q?eQ2aVxx3IFjkDBQ3tcGiW/eWtIjC753GFs0RMsisAC0PEBgo0Jm5eDfZo+T3?=
 =?us-ascii?Q?LFPEgGiPuxW5M9/HV2Y1cUMwuNUSD9+8/gJ/Qyiarg6Vh1idSwxod3tb+Rgp?=
 =?us-ascii?Q?ELNDW+3p0qFuLPvJQaPuWzqTfr83XLse+Xu4Tne7xqjq+YPDg1+8R7D4TJ/4?=
 =?us-ascii?Q?TrlcTTSD6BX3lG5YvKRskZFfHu+3HRvUe/5n23Dnl918agobHTOIMdi4t2S2?=
 =?us-ascii?Q?DcYtkOH+qI4j2xIOBkKU8e4kzS7M0M4xWEbynGrb3oRh+kc+5ISapcLGFmFu?=
 =?us-ascii?Q?zBtRCk9TXD8+J2CjDO1bfQH1V26j92uJhb9JXdNK/iwM38lfPoFA3DRc3J8w?=
 =?us-ascii?Q?Fh4oY+g/ZuoGHGfjtZKrtJZZGcWpArPypM7zjuEdToUh/v2ppyl6PO/Xgjc5?=
 =?us-ascii?Q?3MY5E5gw2jVZQOrHNF3oHZz7GpeFnb1wWqdcudmDeqAV8lT7Z8fw+Tdx0J+T?=
 =?us-ascii?Q?sVhOauBgywPVTA4dVIA3ipeu1zATgIxuOce+3cnmL6V74jKrB4hASWtcutZj?=
 =?us-ascii?Q?xHOjE9F00Ql+GBGBp3iE4snZ3wj9Ul1r0ml7UHwMNR/m3JMRWbREK3MTaKtw?=
 =?us-ascii?Q?3dHllT3M1sSqPYcWaqUAJzmLydL3y7JCNbWH9eWXAZ3eJ9ZvaU5+6CBi2Rpj?=
 =?us-ascii?Q?SKmmDh4SchoUrW+cKEvolC7zL8NawzCkk8IaREXOp48qFuZp+Y1zFtCHd7pG?=
 =?us-ascii?Q?rKFbFe2gt7y04vIKTU1yRB4WSX5/v1FuaWJmYAFr3tNMHZYwXWztK5OkQFN9?=
 =?us-ascii?Q?Vs06TiLQ5m/CEia7SzI3RHQkvIVYZJhL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p5ju0tq23xt7ckcML/sUDMK0nq1zjBIFGrclebniQ2dOpzsY0U8FpVrKKtY2?=
 =?us-ascii?Q?b4GrTA5rL4/K8h00XznA1CPeGP1A49rPVpt4VUOjT3JRuDcy+jVCKzpwWIso?=
 =?us-ascii?Q?KZ/mFuPoxcljwrC/BivmUdnMZyvHnkxwwZoN1aj2FlTcRPuGggFfxiQSH2K/?=
 =?us-ascii?Q?LQvHG6ELvO5x1KwOQcrczAWWEE1jexYlsxSLQJM8I3gdE0Prl1JNBUFHnB+y?=
 =?us-ascii?Q?PuRrHVa4EsQDZwgE+ndZFIoJ1TlPpaJ6DR88+ztwue3YPFLe7CTrxg4C8KTx?=
 =?us-ascii?Q?XK5ADG6MPFeiPcRq0WYiu2ry6d8EXBrpDBgK7eT++xlHk9+H5aC8BnYhqf6J?=
 =?us-ascii?Q?HhJeLkxU7sG6YAbehhyRjaVEb8jb53QQ6Fw8lx9K/xpmG/wmffiVWKb8p0b+?=
 =?us-ascii?Q?SP0feaxU3BaY2O2ZJ3vJ4oOFznjcsz8vLnxH/19xS0Q0kQ+eE5YJpAuhDZuT?=
 =?us-ascii?Q?Hj62IDh1Dox9UHVLapkrLIoq2N37y0cpqiyOP8LhnlQhkQWlqR4iwvDR0miN?=
 =?us-ascii?Q?oABJyBdBY0N35CGiKVB+tSWOiV874ZTf15c/vrq5LpIFVIdmx0Wr3LYR8XLb?=
 =?us-ascii?Q?FJGhAf/36KpEG2NCZKl1S6X66euN0I7MXp/Ru2CfQkBY7pU7ONFcMsiwNrg6?=
 =?us-ascii?Q?3eeGPW+6LCWBpE1DXF7fNfLKCJLZQddd2rHWj8O6oQvgfvaB5tyTDrOWsqYy?=
 =?us-ascii?Q?myyFGNgwsDlOh3JO2nmbAYYFXzRtTlkQS0DcmVSCmvepdikPFHgBXcEA9jxa?=
 =?us-ascii?Q?RuDeD3UCIkCtSMqKrP6FFOnl4g4miT9pNwTDVQQdJL4HQbRit/W9iy/5zP3a?=
 =?us-ascii?Q?jwt5qg7ja0GWgq9hQgUdFsnuYY4SMaIfsooVS/It+9t06yrFiX9s0m6Vf4AK?=
 =?us-ascii?Q?R4EDvpxaNqWfl7j6rL520ywJoUFj0K6BACnu8OZXwsBx2ZBvfbWefAyXXyJd?=
 =?us-ascii?Q?T2BRIXOtm4cIS3T/v1K7mt0vYd7iICjC4hzLVgDi1kclWXGG+ksvpvUoqKxY?=
 =?us-ascii?Q?eGOPMVw76WeCmvxzzD8a1CruDsbw6UGsbV0YnFTGpZZ1nghhngHlGGCfP8Ll?=
 =?us-ascii?Q?r5BIEoHYac3GI0kDhXtZNGSLqJzJ+0C0VNROcl8jrfWIeGDQHG7OKxQcgaAM?=
 =?us-ascii?Q?N0dkQ4hSvv7X7p/ah2uGWPJvpSNLzm3qd8RHs1EKFWFQz/CaLTA9fAGmJL2L?=
 =?us-ascii?Q?ixE8fhz7mETJ1lqTC9LvYV4eh30Heip4RP1UWIfHfzV1HSm5eWNSSS+ZRmdT?=
 =?us-ascii?Q?LqI2T0c457BDfHtaJfjfXFrfNtN0+IZ5GS3Ah4RSYvrTddQ2wSbJH1acDRXu?=
 =?us-ascii?Q?RSZh3X+vAIOZUPv8QA8x+w/PV556dtpOCNWQ/TU1F3vJWv0XUtpZx9MzQ843?=
 =?us-ascii?Q?5d+/JuHlY0Ehy60k8CfP1957+E0yq3rXAgcQcpqNUNuTZVKnZ2h/cODwtNLg?=
 =?us-ascii?Q?zBSFSFchpqZlL98EWCmKxnQkgLtyl02hwdu5mAMOiElqhaY9QHpfRvmBDGtA?=
 =?us-ascii?Q?+hzMTbdhignIlw+FXHv3cCJxHObgzzH6bpxQ9gezWqH9MQBZQt0W/254Blrz?=
 =?us-ascii?Q?h2PUHTM6tjtgXRUdMnrJAioUSqjLwBGEkrALoL4U31bT6vSsFFVzgjAMaTin?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201d9019-bfda-434b-4695-08dd5816e2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 16:42:27.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTxmKnQm+BFkFh8771EieJozVNVFVjrkEUPnBVNnuwoIpl78vVqdNB8aXVLJTbAD6nugPBlciVr40hemBO3Mdsx3OeJ7c/N/IH18H6wylqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
X-OriginatorOrg: intel.com

>From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>Sent: Friday, February 28, 2025 4:02 PM
>
>Since the driver is broken in the case that src->freq_supported is not
>NULL but src->freq_supported_num is 0, add an assertion for it.
>
>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

LGTM, thanks!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[..]

