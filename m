Return-Path: <stable+bounces-28532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70088581E
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 12:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B4F2831CF
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A91F58226;
	Thu, 21 Mar 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/VDEDrz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291657867
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020048; cv=fail; b=d9rHuALI3K3+qQNY/INIFfq1CZGCa02gbOeXZTaLt1lm/xPe0e2w5lN/NU7J9fwQHCGLSEZGAtrCrIZbDXqvj2VxcME/iLXce9UzBou+i50FDEj1GY9239IPtER+B0576JJ+6EzA9t6+wEm9J6Rc6a4FOH1y9y2Ub+R50OXrheE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020048; c=relaxed/simple;
	bh=vKk/JzJZ6y00aSPuu8QTcsCcqCBw1IorIaCDokh5iqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UH9WNjIsN6USqXpPaY0Sm+1KYQqCm33sHwkO3fI/0znlrldE5Q27YpxJUV4pOLnHmCFWXfSpxh4OHr2WblageehIQkFiS/fvl9Q3krdhodNYMw9xdoTDrQpWX6kHRsLE9CZseKqWp82HLGO1l5bV2e0nTkByeYWKt2zUpqbp1hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/VDEDrz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711020047; x=1742556047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vKk/JzJZ6y00aSPuu8QTcsCcqCBw1IorIaCDokh5iqo=;
  b=B/VDEDrzKYf1hw8iCpDD29krZG1O7KHKy5sSpVRW2lGOQGG/8+zIbI67
   /fdRFB9jP5P5XyKYYCbzZcDmaN89GFBUjozGvZu7AMescTbtA2QdCSc10
   uOMBXEwRecwckhjwUkeckxpDNuKnGvr32I+1sYlqqoti6Z7Rf6/KUH6Bn
   O7WygA7E1tCHhvkLb2F2ne/zvnC2EM7nk9OhvNKFdwLPnke6OzkH6pv6E
   5jTI2IKh7uFdwQUJ9htfOJfelExzNwyoIYobjXCJjy13rer1qck/F34qe
   /2MkbghVVwdXWB0nIgwT4/CBc6InmKso2gIm9buI8o2j2DJ4h0j4GVvQS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16733952"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="16733952"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="14477460"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 04:20:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 04:20:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 04:20:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 04:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEI6flYUzllcO4mVRK+bacFOo34vwjt9h879UWsxa/A4m0+9XSj9EEeZkxLOolLvpiC5bdKW6D1LjD/3jB86J4BYd8ZIRdlU90VmnuxStveSvB+tStxd/eHsO69UtJQt01cW9+RDBONHRYflVnTm8dnEDO/nhsl3HntcGDq7mLkTVzOdHGisqhdFBn7OaL9QcGLOx8X4y1PqVAxeacHt7h69QF+9iw3R7LyXg7wEfqo+A/JyHbfhgILU1a6d6sVb6Ky0Mk/TAmnWitS1AdQ8sMkXrkCqpeh8NbOXidqCzh6SOtsWoRczd0wpdMm1WXRwvvSIpTCN9oKLjG1SuugyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwYJkq2sF1Rdv9N+xtDbfTTIA7qJvURennkQ4SopqT8=;
 b=AWQDz+HdQvvvK4AnDIULpzVfy98epJGwLwzvC5xKmoWk3PL1yv+DlOaaS/bSgbcGpPlMFyKHGv/oCGS4IhytG6WauAKIxz+B72q9YyGafituIf4VDV3cvRfwdUiiMR5wNGbWWhOkh2qwTCw/Ez/dpJ/Q2suz1oxftT3uvB986NI8XMPj7KAfaktZZjmW+as/EFYIhFSirZbah5nKoQ/zbZwECCk9R3Hh03GSLHs38cEI5BCd5g50It3FYuw8kuB099AawL8NVzJfKuIe0f6nzNEWBBCfyNboy5WSTyZ2374PHKc3PXkW7AgGAos++fwmMF2Thyn7C6HYBMWeryDsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Thu, 21 Mar
 2024 11:20:42 +0000
Received: from MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::8664:8749:8357:f11a]) by MW4PR11MB7056.namprd11.prod.outlook.com
 ([fe80::8664:8749:8357:f11a%7]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 11:20:42 +0000
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Das, Nirmoy" <nirmoy.das@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe/query: fix gt_id bounds check
Thread-Topic: [PATCH] drm/xe/query: fix gt_id bounds check
Thread-Index: AQHae4Ak6O+wjU7G3UK4PqH69sW3qrFCDFrg
Date: Thu, 21 Mar 2024 11:20:42 +0000
Message-ID: <MW4PR11MB705683ECB262FF96C6B4785DB3322@MW4PR11MB7056.namprd11.prod.outlook.com>
References: <20240321110629.334701-2-matthew.auld@intel.com>
In-Reply-To: <20240321110629.334701-2-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7056:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 9b31a1b9-e57b-46ae-86c5-08dc4998f1ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rszrSKNPVCAeaW+eW8s1sMWgJmSbOLucvwPdwCEGBVD4QKOA8phJYSS2lCa8ncf7s5TklGB+unWBVqHePh8jGeDNUuzGa5m9YjCC0rH62WAddWWD/x/L0l2Id9YYFQf3WTCqracA0Ir5i+tYsg9j17BPOlhAjpM2WXB5+voUBIHl4dQmrxQHD1ALMkZv6Ez9UrLd0VClRpgS8DRFD6KGXvVHMKGqrcPN2MJwTKTNgboOW+BKB98tfJ+r/jhK+evHSNU0rGT4QVCl2sm13LEjqGHhZIRqF+iOLARkuFgMwiLI7VzGa4p5uLYIqBL5Yk4y8Yx0t8knGoGYsEzuwJxMIxT7YT+HyygNBKYISE273gRdrOkb8+uY6WdoU/Y3OZU2GUKD6WQjGRGexqkkl0+rYtpmG6oD2zadWt2OO0o26ctSM7YztLExkVQvkvuhqGZdiUcTxC+vbuboJMt0vBkuqnAq+HA6kvpsuE9OOAYZQw31PasEOEYtAxBMY5UAhgDLw43LTNtV3fN6KZ6MzmCfiih+UikxhOKk17Z1tEk8ZM3t4ZGKSdlKb2hBOO9ucYsVVJPeD7E6gSJGSDknYoI3NbQKTZcR1PW/Dck5MTAa5xHaN72j6lqpmdiRJM1W+KqfLTKkBapHngAecoVv7WYlARNpCVTUfJvX80z7lQuVmIxx+y4qNnIchFRLEvJwMXYJYCZ4tP62vCIwtFol0YXSPOPEXJSgJagrvt1/9mfJIbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mf+6/sjHm62LFIF9sKOQtofczLDFrm+YsWE8qix2GPFgmGYQKmS5prqYbqg0?=
 =?us-ascii?Q?dICFGcSOWTDwnZL7f0zget4cCd9vhls6lLxXm6QocJINAN18lRcKQuDyYSzC?=
 =?us-ascii?Q?HAhwPpQzSsi9MiAbnSn/pwO7wDry0bsvsjbtFgKZKzwKdvShQHxYacyoKG7z?=
 =?us-ascii?Q?c6oY2BNS7PSeJcnodquQ9hLcScGxDyUZ99OqACQBLE+HpDc6tfiPVJBKnC0G?=
 =?us-ascii?Q?tHMlyDjclXN43avrnHPxr2LhsiVc3RcwdHFD4nx70AGDqCyDNkuPZ9q8QyXh?=
 =?us-ascii?Q?+e/fBCEo2bCeCrjD1kViOJL/S1ilpoxXXN5TCnf8uyMU6JnE5/v6SYf6EjyK?=
 =?us-ascii?Q?zKD5ktjgRknmPYce5PTLTrReG2Q1qrq0ccFg+OBasU5jQjgOYXkvP3L3O4TZ?=
 =?us-ascii?Q?RgZDAZjszbGSehosacRfxIJ9YUud6BhHK7h4oeSdKRgS9ozOJafSfCQHNA+v?=
 =?us-ascii?Q?tQSiFwxlzu/3B2we7FaLS8JwizEUpjjvB0y3/BVQiPCi9HzQtv233s/eYm/5?=
 =?us-ascii?Q?Tri77aRq329vP8Qi0SJ5NYdol3QnQvF+/AXTHMkXlB+2g40a0ich2crUhNRY?=
 =?us-ascii?Q?NU1wsgzCU7CMezgY62gqfsN14L+u1MnMyw5wejuASvU6rK3rWhDTydoxqGyc?=
 =?us-ascii?Q?aA3QMrNNk7SSztkzhb3HTRnGfl2BJwmCjQxrUgsMYyo6JboJjTjr+iD0bu3O?=
 =?us-ascii?Q?IgoMgpH7Hr7edolwXd+c1mLCLKbkNycddyUCbd6V9cNDB9ZtPwLZdgvff0Ra?=
 =?us-ascii?Q?172DUxZYfDeaASrcjXfNWXZfpSGzipn2wDstQzU/xVnpt8V+WMpcZf4k/i0F?=
 =?us-ascii?Q?qu3Dcmjdfj7k0N1OlwJfe1GYVCsyDlFLoQOD0L4kGmAz6mLL/f7vpZaKcGYY?=
 =?us-ascii?Q?DLciOubXoT93IdpSsroq4d4eAP+ZxeIx3eH4chqZKfqDr1nBOQ4qDq1OS7GX?=
 =?us-ascii?Q?koJTjW+LuwUI3mSzLliQjc5aFUZBLEx/bOdff+ArEnKA3ms9dSXN3EGKx3be?=
 =?us-ascii?Q?w0b4G7mDLZ/ZdeeVmQPrcUJi8W6DB0W6rlZ+9odZ+kf1HI7SLRCW4CQ0sKXS?=
 =?us-ascii?Q?hF7Xwz+ztiAsUCTv/T7IWvjubhUUzdpjvankb2/b73Aea0kuEd1ZqYCKs0re?=
 =?us-ascii?Q?B9HzyeZs2J1KStMQjRKaNqD82TWDEweb+S/f7O4JoPpO0oX3aivWq2NI68Fx?=
 =?us-ascii?Q?rnw0Xe1h3UkxeBOElTVjQJ5CTYzrHCW554S/GMYRC3hIZ7ajPRgel+OQAFbI?=
 =?us-ascii?Q?s36dGyKYG16mxX9/Pz29L7zHffhITR6jqk6oFivTAuR6/GepcF/aZjPuwpBh?=
 =?us-ascii?Q?o5bURPWC8TzVLqsh3q/nC7DChP23L7sgnPhONDNQHPvNNY1PmMmAAlKpbLUF?=
 =?us-ascii?Q?nfFjsjA3At1YXldD+z+2OUlk/6AGKn8cKZs2JfnW4pHeV/7Xeb+/qrUlR8/b?=
 =?us-ascii?Q?N+GZHIOay9RXkcj3xWN5FnXzF090K7yzVmgHNZYF4gHRMea4oU++Lby6Tygz?=
 =?us-ascii?Q?PyWzOvQWRSgHIDFbczTy0dcvp28qSjpDnqlNHWx3BsHn5uOQ1AUWC8orhsAC?=
 =?us-ascii?Q?2pzgAk0L/J36KkM51EisStaFrJflLzSrOXrLUjS/cxxpSO2rSkrwtHrRPiXo?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b31a1b9-e57b-46ae-86c5-08dc4998f1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 11:20:42.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbeLf9gma95WEuhXYmGTzIvWbXHxVDrzJ0BeBwJ6JmO6PaPmj9KdAYYwo4dVu8q6gtb4XT+TNLjZ14kpzA4evPScwYCKC4PzicLMKpPmAWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> Matthew Auld
> Sent: 21 March 2024 16:37
> To: intel-xe@lists.freedesktop.org
> Cc: Das, Nirmoy <nirmoy.das@intel.com>; stable@vger.kernel.org
> Subject: [PATCH] drm/xe/query: fix gt_id bounds check
>=20
> The user provided gt_id should always be less than the
> XE_MAX_GT_PER_TILE.
>=20
> Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with
> better accuracy")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_query.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_query.c
> b/drivers/gpu/drm/xe/xe_query.c index fcd8680d2ccc..df407d73e5f5 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -133,7 +133,7 @@ query_engine_cycles(struct xe_device *xe,
>  		return -EINVAL;
>=20
>  	eci =3D &resp.eci;
> -	if (eci->gt_id > XE_MAX_GT_PER_TILE)
> +	if (eci->gt_id >=3D XE_MAX_GT_PER_TILE)

Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

>  		return -EINVAL;
>=20
>  	gt =3D xe_device_get_gt(xe, eci->gt_id);
> --
> 2.44.0


