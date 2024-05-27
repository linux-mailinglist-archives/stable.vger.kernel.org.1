Return-Path: <stable+bounces-47505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0D8D0E8E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F11C213C4
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF22EAF7;
	Mon, 27 May 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aucU+Hx8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF791F93E;
	Mon, 27 May 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841436; cv=fail; b=mR3rDQPoEZAl7EUZJ2CFicPCnUGtbWLXBc6ZjOJyMXWDGCX39bQYBQ/Nv0IBTaw76RrcnQ0IFmhOz3zkbU5rC13IYcRRd+UrN19wm9aBDseq3q7A472RFSUBy8hqsqSeiFB/bXpq2/j3SzDgvOwu4h+FwWQMuWU1sduMu48F7Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841436; c=relaxed/simple;
	bh=V8JsKjbrsw/gVaqhU+/T800gmOSnWLk7YUlycdIw+pA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Em3HIMgpLNSV/JZkK8oNxm53AAf0Lso57LAgGeKIBPnMcoSEQi/g3TpNqXxXef4B/E6uO0TTgxJMzM1fK9g6veOviEObfnTEA2CAx0gi9//7jYJ0oMuOlQy8VeIaYgRyPJtY81Ux4wzlAhsBGbzLSgDaNx9fEXC89F2/90d73nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aucU+Hx8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716841435; x=1748377435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8JsKjbrsw/gVaqhU+/T800gmOSnWLk7YUlycdIw+pA=;
  b=aucU+Hx8jfBogc/d8CaXOSybce6YpQcabzeaT074qpetkf1/Hxd81x0l
   Catz7YoGGtFIbn4Qf3/2BSOWt/rqnqIX+w4Q0zVDTWk4aP+lXUV+Mcrxx
   R+pwqbR3sA5DqOB43aq8YrBPEB86mkioR4Ci2LslEAdqHP+gvlGX4A6Cs
   XYvakDB9q0gfxRcnsRSXRdVVd2+c7DCSWqy60aUWaXb/KV7EnQf7spNs5
   Q3ilsa74TQwuvPLHYeYkRCjJIXc7sIkeDi6E51QI5erWT/HhyktKxPqHu
   +h50PQBhhSHp2p3qFb17nKoqjvRXVVqI1imZho7YclNVSH4jZkxmGZP0S
   w==;
X-CSE-ConnectionGUID: 9biSTLisSOWuqrWQDN7dlQ==
X-CSE-MsgGUID: Qv15EuXPRHC9rmp0MwErxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13357279"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13357279"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 13:23:54 -0700
X-CSE-ConnectionGUID: O8dXMp88QRiVxywQmHEhhg==
X-CSE-MsgGUID: wz+7vxkaSIqR0h+cREHwQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="39393029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 13:23:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 13:23:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 13:23:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 13:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDyHT0GsEwfz9zFyC+2wwbz2WkOveWv0h/QObDlCAMLuNQC0L6X6XFV5c8YKWpRpJlsueuuzh+QtDaXcqJn+78yht3XY60k59yeZ9iuovCBdKEN6q4ZlQr0bwwnVnrTQrJGuP7VJXBpVtixeI0qxWTSsUEZaUeHnNxxZH89yAKkWnWZEtAnIR7LNeO3C0Xenu3zFk83i/7DNfIuq5yL4YBPiJeHVvQYMbBQH4NC+1oD076SAhpOUSbMqPnajcy5Kdj85s0hwcxAdFzN7V7DGn9vQJbXfQyk4Dj6K2tkJ3Q7tjjJ1/49Gik5kQyrRQqur7moxCbvEEz0N7Ne4A6o+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3DGJtfP6REZDVNtBHnvKTPlYfnYTHOK9iLsqmkCSHw=;
 b=eS/s6K1HHbD+fMaVdtetJe1EguqKzSvgCOfZ8jRF5O5fWmyhnPm9r4g24DRawJz9vJ5kwMYdx6cRzSZTP37TC9NNqC7jqoMoWQ3RRlJABnD/59xB0QNS+ls2XP0hhR0etZzreLREBiU8liBGA64/xqGcDahUxHnd8vDK+oU8biLdGsxCm4mB+gkcfex1LALyi24TWkQIPZz1cEsyBNOr/v98n8hi/EHgsBzg3fhoxLmQH3WFVcWCblPkVGYp7Z67EEagUhH4wM03vYk+LqLVe5StyY9XnhtDPqvXWU31B1CPjTNDeejv8hsUAhq10pCogKZ1ESvmNh+cZT8CIy88ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Mon, 27 May
 2024 20:23:46 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 20:23:46 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Yao, Hao"
	<hao.yao@intel.com>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH v3] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Topic: [PATCH v3] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Thread-Index: AQHasC/Q36BTTG7vREyPCcbfxlnlZbGrhpSg
Date: Mon, 27 May 2024 20:23:46 +0000
Message-ID: <PH7PR11MB7605CC4C866718D28B5393CEE5F02@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240527123835.522384-1-wentong.wu@intel.com>
In-Reply-To: <20240527123835.522384-1-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|LV2PR11MB6069:EE_
x-ms-office365-filtering-correlation-id: 9073d326-5d0f-42e6-96f3-08dc7e8ae98b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ueqqotoABW9oPSkef9UsSsK67YsGkAOfs7sPS9IJ/PBuPMckklxaD6IKOltK?=
 =?us-ascii?Q?89K/uTy9PRPkFENeXBJzR7NsVqO0CUWY8nlSbmw7T4G+w27g3raXaTcKOpnw?=
 =?us-ascii?Q?mHsT/MCvinnFqisHQu8q7+0cTt4B1GJ8KQnfV2W7++3btbj1RDW0Yt4P6RDm?=
 =?us-ascii?Q?vhT/de8drkSquDWCz9rcUPzB6sP0Iwkri1XwH0iwIjLRcnuDcLI7RBc/3WEI?=
 =?us-ascii?Q?Xl/kTGt7hJ7OdLVO3/Rfd6acduvcl9GbrkSvH5lWuTfHdG0ZmMZ/AW6LnzU/?=
 =?us-ascii?Q?/NUkJR9rw+ttWgZBkNs9qlvdAsdSTDQ+FjjvX3NxOf7upNtIm68V0MjBV49p?=
 =?us-ascii?Q?5B/2FsXIyzD8EnGQQZgbYEmj6c5iVvPPQHdVEKgBWZ8mVM4KBtPHJI0xwMph?=
 =?us-ascii?Q?fm96jIiPchZLPlSWkdFFba9TFIjoK5YnMjAgGZSUffMURLgJXMtqxx7Ksxyl?=
 =?us-ascii?Q?stZkDC/VbbB08OgZNWtL0fqPwrvleZEEJdHV1GypSnZlLUdmomgDIMHRtCmR?=
 =?us-ascii?Q?syKkf7PBkfy6fSf/VOxc4neaGDKmRocsOMxIYxazf6r+m+0JkcGgR20yEk86?=
 =?us-ascii?Q?hwktwkFA2tDVXq0ux0U0XfLQmAO1MtQ+/BAKZmOfgPPz1G3GNn0iRWMV0q/T?=
 =?us-ascii?Q?JL5JgIYhkbnsarXtP0TL4OtdXttwaIBBsd3JkhHN76eyjlZi+BZDLglp7TzA?=
 =?us-ascii?Q?xnBJJUSfxH2t7T17eIred7TXq7uys7H5RBSQBid7FQ2valSyM1+y/EBBmvAy?=
 =?us-ascii?Q?Xu+vMwwPvtQyp442RVaIPgpyY5UubejQsxXLz5dX2oHT3xtJSqlK47Ao6tRs?=
 =?us-ascii?Q?pCh1qMolCi+iZxnYp6JKTjWSCOexggD/0EnBHkHyDvGqWaFEJyB4cKfWcveH?=
 =?us-ascii?Q?IAaD+nBWi4/AVpqS4VLFQuRPfS9Urz2YJswQ9c8Ac+75VHqv9onN/mSYQTJ0?=
 =?us-ascii?Q?PMhCvTrhvbmjDY8N7DAvkV9PZrekGx1jwhTDE1t88755+8mEKtw67qOVh0aO?=
 =?us-ascii?Q?4fV62DlXAvvc0D0AqmIvKjMrfhne7f/IdKp1/E/HZdxBXJGJgC+B8GFjy8io?=
 =?us-ascii?Q?mQOny0dvCltC4IDffETIGkZbedAAtm9UjJe5TW9KqTFKHTTyhJH875F4871C?=
 =?us-ascii?Q?IDxnnpsmZ35HIa1gsuK9Da1OrdbAOlG5dc2oX7lwr3o8mrv03sqyIsUwLAzk?=
 =?us-ascii?Q?QD1MlFPvtGg2Yi/C4ECAXnVH0V+Li5f3bx+9OisOIvqoxjlhbfKFMzHD3Vl/?=
 =?us-ascii?Q?gFS2DNgB2vA0+L62rYNxcqGW+q+LOeCOqhgaBTC4sKobufeHdXA/E2FpaO8Q?=
 =?us-ascii?Q?IQ2iIzsn/BCuAK2qyvrnWBCQNrIlkky6cYm1jdFTsuUxaQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G/9DWj2RSfQqKzqpFZEmT31gE4cntvgDHuxcFCZUHcU/pnYCdtQA5FnLmG7c?=
 =?us-ascii?Q?/OtNDnqgVmoCF8LwVcZW8tj0A+v/wJxa8D1/ZZkZA8tHZS3nNQhTZqZE/Uzf?=
 =?us-ascii?Q?UvETlAgqlOJ0kj6HFDMfouWi1k2UZwjCZzr40UiJwQticdHQj3KoEPLa7svE?=
 =?us-ascii?Q?NsWGxqXB1xxGGgdNzocmT/+jStbN2r3msWiVYmgg5hwOmQZ7TF3NVUMENgVe?=
 =?us-ascii?Q?q7Q2Zc7ZoqwXG6fwYpuGKSRB7Vcih0t9brwy9aC7N1IGl5iyBuJUqztOR/j7?=
 =?us-ascii?Q?t+BMmQ4d5UHjVMM7Nnw1Y2ej5RhiUFVgdXYPS69zom6xTiE8pAl7nDpYbo5Y?=
 =?us-ascii?Q?FVvmE2roXxHqZM+Rl8lI5uOi8wdg74u4uTzAh6qPnqjRHa5S/V5CpmGPS8WX?=
 =?us-ascii?Q?08uCDQMRuLgZq5jQYHz9EzEWhtUd0Hh8Yk1x8ZnF+4gIrpRxz5y9s/RrGboe?=
 =?us-ascii?Q?h+1CqQ3cfQjvyOSxjldRpxqxLqXQ3kNUr0zuh5vXhSRxyvqRc3C1M/L6p1by?=
 =?us-ascii?Q?uUfEkKOMjAczfwksE0qw9wK+4HA59kNVv/Cvu2sg8H+C94ySqxHadwzpx/5X?=
 =?us-ascii?Q?RLfL5tTHW2zv3XBkIB20D//ede8VfnnjG+WoylWlKSoLHcdEKJ8uN4CtR7g3?=
 =?us-ascii?Q?wo5Zha/rhzBrEJN9C6UL/0V3HY8nVqkZX6ygO7/DK2pxeMfbVLWyzZI9dIPK?=
 =?us-ascii?Q?9qsLXNGsv4eh7T19RarCfOsX06RVTwxGKAeA8F47h7xoCj2NWkJBuaJgQW4z?=
 =?us-ascii?Q?N6wlgzCvUw5Yp9tl6RIsFlMG+cacfcR8xXuAkk/XkWlIyLiTzgUY7OfdYztz?=
 =?us-ascii?Q?u6tVBgpHA17GgVYC6DZ6taIqozKNbNq6I+ih6byjzn6hY1o6adRw7211qdj5?=
 =?us-ascii?Q?XitWC5pMNCtsAQWKLsHm+UtZ0qssV8y50ZfDpBtFFHIPn4sHVuLHWW+9Ma0d?=
 =?us-ascii?Q?BwMb4ejauSqJjQTh7joHjWU2gq8rE5Djbh128AmgQRhuFQVNeBMPVhCFlyIC?=
 =?us-ascii?Q?xXl7E+Z+IrLlXnJeUNp6xngYXO52QzGXO8zyH98s32AfBuoZOjPNKZCoizaT?=
 =?us-ascii?Q?pu19a34ho8BOdFi0EeRTYSghd2/Dij1LUCfRqZfiyYs3cJY5OQfNIQnIap8d?=
 =?us-ascii?Q?o7y6XKHzG98hs1liry9HJsvE0bMa9uPsAUlglLAXMiseXLO5lMx1lPHUejET?=
 =?us-ascii?Q?ZCi2b3Mcukn9B3iZYTB0vEjK/RFN5ZKSgrriSn117DBny0H/PL+pbAJum9dz?=
 =?us-ascii?Q?VxbO1hQW65HkOfkeu4/IZtx4iJw7eueVTOZ4EDAUkKR3ks4Sm5obtc0ig5xq?=
 =?us-ascii?Q?3CYX7wSb+cyzPEbC93nxaCWit6E1OtAru2z/K6e+A8Bo8quYqydYl2aR9oN8?=
 =?us-ascii?Q?EZ/2ESZefxrsOBmarlRPGZI+YPR5kSWz3i3S0N3520vc/pROHkjAE1p3sVI/?=
 =?us-ascii?Q?KLbPDNtnGHGruTBDqam3aHI5+Im5gIioW9t7DF8jU/y6x6itaz1CENOsWVh7?=
 =?us-ascii?Q?+iUXR6VMhQkHRY+RmHptDTSg4xko5YPY42W3SZLggc81L2AM6j5xyE7iKRKK?=
 =?us-ascii?Q?N1Di1hPIGzPlkQab9Mif6U4cerUKGYA4wngZo5X9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9073d326-5d0f-42e6-96f3-08dc7e8ae98b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 20:23:46.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEix04PtDG9OKmHsgz5PSMBc1kCXiaub7goM7GmzhBKTjkdLZxJC3lzRiRs+NZKy3MYmz7gyGDfUtz2TDR09xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Wu, Wentong <wentong.wu@intel.com>
> Sent: Monday, May 27, 2024 3:39 PM
> To: sakari.ailus@linux.intel.com; Winkler, Tomas
> <tomas.winkler@intel.com>; gregkh@linuxfoundation.org
> Cc: linux-kernel@vger.kernel.org; Wu, Wentong <wentong.wu@intel.com>;
> stable@vger.kernel.org; Yao, Hao <hao.yao@intel.com>; Chen, Jason Z
> <jason.z.chen@intel.com>
> Subject: [PATCH v3] mei: vsc: Don't stop/restart mei device during system
> suspend/resume
>=20
> The dynamically created mei client device (mei csi) is used as one V4L2 s=
ub
> device of the whole video pipeline, and the V4L2 connection graph is buil=
t by
> software node. The mei_stop() and mei_restart() will delete the old mei c=
si
> client device and create a new mei client device, which will cause the
> software node information saved in old mei csi device lost and the whole
> video pipeline will be broken.
>=20
> Removing mei_stop()/mei_restart() during system suspend/resume can fix
> the issue above and won't impact hardware actual power saving logic.
>=20
> Fixes: f6085a96c973 ("mei: vsc: Unregister interrupt handler for system
> suspend")
> Cc: stable@vger.kernel.org # for 6.8+
> Reported-by: Hao Yao <hao.yao@intel.com>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
>=20
> ---
> Changes since v2:
>  - add change log which is not covered by v2, and no code change
>=20
> Changes since v1:
>  - correct Fixes commit id in commit message, and no code change
>=20
> ---
vX descriptions should go here=20


>  drivers/misc/mei/platform-vsc.c | 39 +++++++++++++--------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-
> vsc.c index b543e6b9f3cf..1ec65d87488a 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -399,41 +399,32 @@ static void mei_vsc_remove(struct platform_device
> *pdev)
>=20
>  static int mei_vsc_suspend(struct device *dev)  {
> -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	struct mei_device *mei_dev;
> +	int ret =3D 0;
>=20
> -	mei_stop(mei_dev);
> +	mei_dev =3D dev_get_drvdata(dev);
> +	if (!mei_dev)
> +		return -ENODEV;
>=20
> -	mei_disable_interrupts(mei_dev);
> +	mutex_lock(&mei_dev->device_lock);
>=20
> -	vsc_tp_free_irq(hw->tp);
> +	if (!mei_write_is_idle(mei_dev))
> +		ret =3D -EAGAIN;
>=20
> -	return 0;
> +	mutex_unlock(&mei_dev->device_lock);
> +
> +	return ret;
>  }
>=20
>  static int mei_vsc_resume(struct device *dev)  {
> -	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> -	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> -	int ret;
> -
> -	ret =3D vsc_tp_request_irq(hw->tp);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D mei_restart(mei_dev);
> -	if (ret)
> -		goto err_free;
> +	struct mei_device *mei_dev;
>=20
> -	/* start timer if stopped in suspend */
> -	schedule_delayed_work(&mei_dev->timer_work, HZ);
> +	mei_dev =3D dev_get_drvdata(dev);
> +	if (!mei_dev)
> +		return -ENODEV;
>=20
>  	return 0;
> -
> -err_free:
> -	vsc_tp_free_irq(hw->tp);
> -
> -	return ret;
>  }
>=20
>  static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend,
> mei_vsc_resume);
> --
> 2.34.1


