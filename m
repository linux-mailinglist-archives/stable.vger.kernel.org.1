Return-Path: <stable+bounces-54892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C9913998
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 12:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E977D281206
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C112C559;
	Sun, 23 Jun 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq8xknEk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E763D;
	Sun, 23 Jun 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719139341; cv=fail; b=d9RZR9JksD6VnwB1JSzwRaT0la1s1ZGGMutTQkWQe0TzZNtG/e4MaFM3XWkfbApEPHGkOQD5439L5vrviu/sLlW/WHKWAlPPC2rroBpbg10zgbpextHmorPj/KRhIPnusz/vNqrbXqfbPnqEXDHkmN0VDEoXvpySK6breOdpA8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719139341; c=relaxed/simple;
	bh=fAU2NPzii0DdIt9GWUInTqMQmHLXVjdystzer6PF1p0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sj4LGdqymVft6b//PIyPirGQFzz1xA1ymoJ2OBJOkanjAW1nqwr8R0B9iqDZ/zByb2la2fSw9kkck+2zJN3ZVBdhR5xeZQpV3PDW3Uwvflc3chGJXTdL5OiKt6YhWgPFaY/2dS6q8+H4cIkZwF7XeqJJ8zrsQqM509pGXpzFs+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq8xknEk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719139340; x=1750675340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fAU2NPzii0DdIt9GWUInTqMQmHLXVjdystzer6PF1p0=;
  b=Bq8xknEkhrOOr9hUU2BHrkt3PWUYtvGWa4qQdd7dyxSOIXCxFEu4KV/y
   qHFpgX0E1Wh/xZlUCBn34ewBe9wKWon4th2Uf1rbaM8izq6k8fg4xnCYw
   QoPtlXLazAS0XJufoYiN12JQrfcsxlK3TrQ6fKfsmM0dUYU00NzVsdE2O
   sX8z2rOkY+EB7HDtVdE5Km0yUmdumL8GKUo9xJRQlRnQy8gNEcpz/2EOF
   SrX27VjeVdYTMSTmnE9fjRSk5SRhdzO8VEwQJKARdBiuOOmneK+r9WzVi
   /x8w5L1sQZKFyoynAzSNeyMGtQxNaQuCTfEc6ScpVdcaDSPI/DET8jk/a
   A==;
X-CSE-ConnectionGUID: LyEUEbj5RiaKdPrfZjtT4w==
X-CSE-MsgGUID: 3q5NC3IvSa++vxabx2yTbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="19024666"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="19024666"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:42:19 -0700
X-CSE-ConnectionGUID: opLOh8fNSD2voGY9BDFTZg==
X-CSE-MsgGUID: i9KeLngnSSWrkLFaX56vPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="47480990"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jun 2024 03:42:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 03:42:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 03:42:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 23 Jun 2024 03:42:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 23 Jun 2024 03:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw5iUJfHTwVl7WLbjMhqIyVh/8TZ76tvTnQCdmhE0Br8JITePc0b1Us8Du8FbIpKvijI6di3eBmySmPwE3VEf7KIkdnOs/yKCm3f099mxer77NAw17K+BXd/CKEej1O1oggfY+kEaFauNdPDP4BGRMZkQUD16vSKS2MQ5xGMe9ocbyt8Bwrio5WKJsvA4E3lftz1+sbTjVn/r3UpNMGNHitTUnbj87Hll+nPryDiA6XW27qj5/QxOPwnNW34SiztlKcB/VAstpLHcBYB4USsnlGTOcxAQPChTRub4ojh5lsRs3nZ6/La02nZZRv06eBBN/pGWXd6N65LBCjG/H74lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFtdjkD5aa3sAuLIL3tzTi2J0nvbOemk0VL7lgvxIpI=;
 b=M+XXe2BA5fmyxEaUS0oSsDm4rpR6QCnopzGmxau1WWeNZsEdG+QIXLKJaKdkg6QPojJwOAwGIoyMEh6+exQOoJaF1X0vtAqSOV4qMeYUTB6+cEgzl5mV9tVE3E0NvcRj8q68xPsTZEy0emOGrIEffDSXCcEsEPNRC/FvsFhc0D1RfuiYIX4+nQZ08XeB0ANJyVjWz5AXwNvpJyMve6R+s3b2U5YnIUCaUqo19VxA0TFYrkfbdrVFqW/xjItWAeQbidb0gmrXk07xDXc9kvs8qyVzt5zSTVO2uwIm7NCamORe/JNeOCt+qPGuq3nc1mWIhbece+kS4SgC/R9+nvLhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Sun, 23 Jun
 2024 10:42:15 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 10:42:15 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Chen, Jason Z" <jason.z.chen@intel.com>
Subject: RE: [PATCH 3/6] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Topic: [PATCH 3/6] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Index: AQHaxVBOtnYgz4ipI0ahkqeoC4b4YrHVIDuAgAAGJOA=
Date: Sun, 23 Jun 2024 10:42:15 +0000
Message-ID: <MW5PR11MB5787C28D5E99BBEDE4E7F5538DCB2@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
 <20240623093056.4169438-4-wentong.wu@intel.com>
 <Znf0V9roQaUDu7_b@kekkonen.localdomain>
In-Reply-To: <Znf0V9roQaUDu7_b@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|SJ0PR11MB5214:EE_
x-ms-office365-filtering-correlation-id: d00fe599-5a58-4439-427c-08dc937125fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?RpyPiTYdAwoLAN6T9eYzn1Feqh83MUc9iHnOT0aubmaPXTmnKuW6GSuexCOy?=
 =?us-ascii?Q?84BoO/Tn9rQLiD8l/GitzrBQdtGvkSbOvLUZ43Dfafuh/xUtsKHvGPHQ395I?=
 =?us-ascii?Q?gqIlat0wVFO3tRB8fK9SvgG/Hhoe2J8edzFja6JWH0XtLQlY0s8s+fXojUIT?=
 =?us-ascii?Q?kSiop1LlidvZcCOlgOXXm4jXaUoKlJyUxpNFLY3qwWNw3q6CG0BveqvhdtKW?=
 =?us-ascii?Q?Qf4DiYMDh03ot6iV8OCSZu0o061VY5ROwKQSSJrZE9aufV/+twt9gIZv/YnV?=
 =?us-ascii?Q?f8rYXIkimtEjvRLy13/zGnLlbC9Jy7nkyHLXDyQ5VDFBTckbZodnbWpSrCCA?=
 =?us-ascii?Q?LWVDe5mqn7348UkTnrsubWjeL+/hAcfTx3vPHQ0ALhVU0iFBLv24z+pv71XN?=
 =?us-ascii?Q?7Cr2xHITb8V934/9j1M/V4tqjBzptls+eAP0JgimsIDpHX3j88Dnkcm+Q71W?=
 =?us-ascii?Q?vajuTpUElIN6VHZHU371JKIE01SemlSO9IDfIzi+7/MrpEU2bbLHO3xeOUhe?=
 =?us-ascii?Q?CeX3U5jUvB2kDbvaFy848smZ1IE8FOQqgLmG+omdH8HFCzmtfOlf9huWXwNj?=
 =?us-ascii?Q?rM2e2g6/g7WUquEZuIZtliCBunNmd3AkCjvWpAkq3i7ZfFwT8tEW3nWtUncG?=
 =?us-ascii?Q?y1lh5yDPutXgU5fQfuw7V8hdvNp2nI0UGGZ/FGl8uMsNFRHr0Cm3oNlO8Rv+?=
 =?us-ascii?Q?fL3+waCuB8iAtj46IjHM+sUpSfejMyxU799CnPB6twtN8Xqvtndg+Tngf9bz?=
 =?us-ascii?Q?NTO2Gkea7DRiATX/cMwsLgd067+SVgN1zmmd65cA2Zw+KG79d/ij0CgPcyoo?=
 =?us-ascii?Q?mo/t/q18IbfS+OTisiVEK4IW6RVHb/QJLK/kRJUSFSeGG2JtqJVjaeUUdzHm?=
 =?us-ascii?Q?6+htZd4Oj/52cZUYEcu6I6Cm1ZncdejmvVgaLluc4tEU2ST7w4puNaNe1utZ?=
 =?us-ascii?Q?2J8RRFVC4zGxUx3/EniFMH4vRoH7AvjS5bewrAsffmVuO8sc7KkXlKWBzb9W?=
 =?us-ascii?Q?tyBD4eGHJ+pZZsfvKeGbHzXJg+NQNBjOjDsnCB46JyfYN+S2CYArgozNy0JC?=
 =?us-ascii?Q?irmyAGg1B/BdbZSA/aaj2tem/5/VZ2owIJ6/fcU4czsEr7d6wlOOEejAX2SV?=
 =?us-ascii?Q?2W65vwjrZr5q1Gn4tx759wq1vhYhtbHG8+nRGIUIPXjIXCMuH2UIRsp49sFC?=
 =?us-ascii?Q?JEaXeTPiyTVsU6rYb2ne08p4YwmLv6FAE8C2VknGwOuc/q0oIwnBbzqVCs4d?=
 =?us-ascii?Q?kdCWc3XLQyNorxWqPzChT8EuKNKcyyomJVjIMhAHkEtJdHBpVEVR69GjiECV?=
 =?us-ascii?Q?Q4mltEBBg5+4Hrcg/lUvEFJJNoKVqj9gd62X6Dfr6TCTxcR5b0LIaH73jowt?=
 =?us-ascii?Q?1rGw79o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TNjVl5Ufsf4Tsc/GYLm4ICBDJosGJJsjkzD2ymFycnrrfS5sgAyOTgeqgif5?=
 =?us-ascii?Q?7UAQMkl42gjsQN/hZZtIqAp7lPsWyTNucCb1DP2IsTq+taIQnW3erWDLC0+N?=
 =?us-ascii?Q?KZ0EA1H+Rciz7aH8sZVsHPBrIY+9C2+wPBSIa1lLNPUh1GYOasWMylCQXEa6?=
 =?us-ascii?Q?s5M6J18DsM6zEToOqEYLipvpPq5txE9eDGifKbBFQWr40HCUdK75zlO71P30?=
 =?us-ascii?Q?CC5lUTEnaMzMCYKTub742t2NelZNe2FwdQSGES6n7oWf9pQlldOWVb+LiRL6?=
 =?us-ascii?Q?RglkParWkj4RWxEoSo71uQ/IPKB+9VUI7V+eqLXiyrfbnH50MjZk32XoqVAv?=
 =?us-ascii?Q?O26f0fRH1F2JlfVITAlaJ2PjzRtIsamP+hS00qliZEZraBz5XDk4Mz4fYIYn?=
 =?us-ascii?Q?FEQ16OmSd0OX/blQWa532JoKMaMDWEbyTZKEdi35BNCTQiVgymn8qgyZOdLo?=
 =?us-ascii?Q?yf5hxpyxovd1ND522PD3aMAgH/QIuS0ph5wIy2EZ8q72GyC62qIwsrECda2X?=
 =?us-ascii?Q?amiacJaFOk1+jsFTAO4H1bBJzcL1vb8k+TTop7odfZA/djvq13CgoiMgh1xn?=
 =?us-ascii?Q?aT0n5uohCNggQlkoqyjnJTQx0cqSZ644ycHPoX13vlGuxHswQcUVSTSTQL4M?=
 =?us-ascii?Q?2Bwhe8qfZinB9rizhKkkJpiLA4jfRHzBbnjIVSPzQLagegy3F6QLb2+0YIsN?=
 =?us-ascii?Q?NZCv52LjdtsrEZ0HtxR6bKVS7QaOjQdTu5yE+4u4KFPrSL/6t43jJNPBlRf5?=
 =?us-ascii?Q?YU42Iek4pAMWGnmn99x1OUPT3dLTFj6CBTwQMgY5fe81aBpI2v4HrF6pdhw8?=
 =?us-ascii?Q?5y2bjb8KerpOStWv5BoPK8kKT+7g44VZ7KLbjtELZ8wqIaHeRBSmZFGBkbHH?=
 =?us-ascii?Q?jveZE4Q8f1/lDfbl9YTLlIgTsRbPo5mDQf4ehG+NvfvSCOyWSlbBBpqmht+P?=
 =?us-ascii?Q?Nb2KqBwebxqbx/uwZLlH9l6TPz+yxIazHJn+h4a75FULfryzxKPLg48RWuRn?=
 =?us-ascii?Q?eWrybbGjbJ8EaYq1KClHbkENmhFxa7gNlKRXhjcKPADHbClKLhBcFCvD4qAk?=
 =?us-ascii?Q?XwogQ9O+esdwGMIrgmVWpcW9N1MgfwfKSf2oHoihfyvEQEeHV8fhiERzik3V?=
 =?us-ascii?Q?yNkLTJew0C9duOiVXVn/oV0tV8RJlHkoKwapiRI8x0Vr7x4AoFgOTf3B5v17?=
 =?us-ascii?Q?FJXxYsdyOsu/KBniC9BRx+3TwBEmH5iVbtw50HENNp/BrVFA2Wvmbfyo1YaA?=
 =?us-ascii?Q?jL0qUGt0YV8/afDvHDoTMBI+3332fu8fwRPGf1AAxXf0NQLZS0S56Got9ygw?=
 =?us-ascii?Q?PUsagj5ZWc4vsKC5DfiMhMVvKFvUsRv+OzOsOoX1vJnG3MPLBCzbPijM648s?=
 =?us-ascii?Q?hI6vJBdIJTE4A7A63CzbXjWj7rsYbmgCgpHfWJvqWOkfxw/GFR70urKpLK8B?=
 =?us-ascii?Q?Wm+0bH8ALS4eExqui9n8X0p8xOcyzXJTiaks5UR9QdjrrIQHji7RHgTjSpTW?=
 =?us-ascii?Q?9R1vnp7NMW7uvEUqPTqA+lj1SiDuabfxgjuJ5H27UuYBynqEVcZteUohoy6L?=
 =?us-ascii?Q?fxWRJ+vYpJK8ZUMEidPfIXTvudzD7PuvLFnEJNA9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00fe599-5a58-4439-427c-08dc937125fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2024 10:42:15.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8PXc4q4zYtGOLa/iXmxMqVYb3TTgH461ZTyPlKyLiy3yD2NJ8jJKfr+gIP5Hb3kRlpt4fA6b4lW9ocditXCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Hi Wentong,
>=20
> On Sun, Jun 23, 2024 at 05:30:53PM +0800, Wentong Wu wrote:
> > Constructing the SPI transfer command as per the specific request.
> >
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Cc: stable@vger.kernel.org # for 6.8+
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Tested-by: Jason Chen <jason.z.chen@intel.com>
> > ---
> >  drivers/misc/mei/vsc-tp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > index 4595b1a25536..7a89e4e5d553 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void
> *obuf, void *ibuf, size_t len)
> >  		return ret;
> >  	}
> >
> > -	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> > +	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf,
> > +len);
>=20
> Is this correct? I.e. use ibuf when it's NULL, otherwise use tp->rx_buf?

Yes, the SPI framework will adjust this. If ibuf is NULL, but we give tp->r=
x_buf,
the actual transfer will tx more data than needed.

BR,
Wentong
>=20
> >  	if (ret)
> >  		return ret;
> >
>=20
> --
> Kind regards,
>=20
> Sakari Ailus

