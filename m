Return-Path: <stable+bounces-45470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A388CA637
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49071F221D4
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9411CA9;
	Tue, 21 May 2024 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fex930ZK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2991757E
	for <stable@vger.kernel.org>; Tue, 21 May 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258864; cv=fail; b=pl7cq6vPegNSb3p3HKp8f7VCOjbAdOENG+GF1eEWAx1psI9KEbSDYvUde43yAkldS03T+xhwWDwEWPh4GMwbFnlqPzsf87hbJIUhys8KKprjEi6kuAOGaWKA7u3qntYR4ECdXtlTMOjROMIh9PmHuo0avGIEAhREVfrS3SyGcZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258864; c=relaxed/simple;
	bh=vbE59o0nSaJzaTLmV/WpRfXuKfqVe/ONKltecHIdO50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qs6F/+umukv2mt66B92bEhx8hHktutoqdALmnvx2fWYefzjwXd/5zLGrfz55wV1m62DiKL7wLjzx6lxK2O2zJQmqzcS63ScvjU1OCfjMXk7qMutG4JcDNPyy0Ui9AOvAWkVRDFjks7pQc/WDqOix5iGXfxNKftjCx7vI7DwbRFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fex930ZK; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716258862; x=1747794862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vbE59o0nSaJzaTLmV/WpRfXuKfqVe/ONKltecHIdO50=;
  b=Fex930ZKJOvF2EniVzyQ0D540CmFQweZHVhRMjEjEW1SAas8XqaJZIFE
   9CxZbB/vLGy3959XiXGljWSH7G3Gi1LBohmweU9anjnaKf890pTTVFhyP
   8/s2YQtx9h+mu3FpyCBEHcrc8wT7WfSVKXAD/eR2Um62rQF3cP55HAv2a
   Q6EWnYT65JEyusMzZQppGfH1zqtB7ARcagsigaOgmwFXS5lEjua/0h1ts
   NxRALBnygS/mldVwg/fLn/YsWQtXLVuBWPaI/pMHzkjiOWlcpO64HfRcy
   oGbm+Xjw6++PdUUhJuCOe8GufhxzGh7Q4diMKHK50OCKYACmRk4oVVnuj
   Q==;
X-CSE-ConnectionGUID: dmN51ko1Q4CJDDMM/6kUmQ==
X-CSE-MsgGUID: YlXfFvMcSYG1pGU9kde8Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29933543"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="29933543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 19:34:21 -0700
X-CSE-ConnectionGUID: 7nSdcswbTyC0rgi8Bo0EMQ==
X-CSE-MsgGUID: GiXuD+0sT/yy/uuykY0X+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="63587386"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 19:34:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 19:34:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 19:34:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 19:34:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 19:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMaZfqtmqBSiWYjZ9fUpo0kohNJmUyyglDO/qFtlTB/0832/7dUTubW/h1VKrPx01oCVU2A7i/OwR7fylgZ6L3YmUHi433T8GTVXXphGk+kOWcCBFzP5nk7Ox/2IoD2stM8I2BgiSiUGMYacc9A+XN+vCMabVH0CZl0dUa1S0LmWVGxzrrszqoCUwPm6h/9kJ75/sd/IV3P6UL4tku9PCOpuDZGnpO/9Ic6oTEJa5UzyNwxo+ONiej/ky+KOdVbAz1du5uLrmGn+e00J9uJEvQcqLsOHw0/u1r9ACdi0OUuM0GxCGlinCIVDGPa42eQNKMpWRbnw7KvSgRBpy0+SEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM1bz/g8vsuxTi4pglCAVkqZucq8v+1dne8VGI+lzfo=;
 b=nAdEkUbG25oclZ8ta6tf38wiHY3zVmY6sQy7aonU14AdqhpNaovyOdzZ1GTWcQOcFmEVZ4BBiunxwyAwymi1tyrurr6HtXzJGOqFvP1ISwYtgFeT0axw/ApshRq1psZy6ctSh8dW7Yu6Z5UCKZ4xLA831aQoeDn66Sed0aKGFxCHzkslcOgZqK7fdns28zg7grEulJs7+wmxUN3p5AAK2/JCAcQOgyS+ttixMtgmYg5FKVunzECeDj8L5LeJ80ucX6g9AWZqX0vN5YN42lbWp3TYC4hWKv1AT6l3Rjm5TyIvFfNzZS8XdgBr/6iyGMK4uDp8p0bM5EPSeDxaLnIOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 02:34:13 +0000
Received: from PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::625b:17f6:495f:7ad]) by PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::625b:17f6:495f:7ad%5]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 02:34:13 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Thread-Topic: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Thread-Index: AQHaqth6KVpQMbQuK0+8fo6tRB1jiLGgbt+AgACJtLA=
Date: Tue, 21 May 2024 02:34:13 +0000
Message-ID: <PH7PR11MB8252EB9FCBB5FC662E1571F689EA2@PH7PR11MB8252.namprd11.prod.outlook.com>
References: <20240520165005.1162448-1-vidya.srinivas@intel.com>
 <2024052054-zebra-throat-0da6@gregkh>
In-Reply-To: <2024052054-zebra-throat-0da6@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8252:EE_|SJ2PR11MB7519:EE_
x-ms-office365-filtering-correlation-id: 2f52b9cc-7ef8-4c21-a42d-08dc793e80b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?yicFg2o4co8amHHR/7Q4abN08mYhE1cD8J80qXija7i6hoT2HlUtGKyPBvCq?=
 =?us-ascii?Q?tyGgf3xqZ7bfk2RVY7c/NXibBPazBOqWYn2qN2KYk730BBK0i0d1ZVL74u5/?=
 =?us-ascii?Q?CSAUTP9s9MNSkTV+0YNQpbPlQYBGaHHRnm2hcWceRxIE3HjSscZR0tOuoV17?=
 =?us-ascii?Q?k4QRoBWloX1JU0uFF4m8U2x9jDfYK3J+MmVVroxtFW1vclDvKPE59awqat9V?=
 =?us-ascii?Q?EeaG0zTFmBta/2FQEpcW8lqVZQFVom9rnM2Hxdbk77eWX+FGVqchR73OtAcD?=
 =?us-ascii?Q?FE1a68I83RymtB0CyTD5123KmybAjByRN/MMcv7PkZK5JPji0D4r8CCuSj8a?=
 =?us-ascii?Q?LBl3XstZ7wvbcXwHSZ0nNGW+tWw2aZBUDYaH8beP5msvu9cFS0kGquMnAeDJ?=
 =?us-ascii?Q?gmCNidTqbr4TF8AnzStlqULMEMEAybWUBfxI7754gNzm5C0fjeR4n8Iky8B+?=
 =?us-ascii?Q?eBPp6AwUzjWcPV9wq79eieEgVkaVLKPWtZv0te144jYnqmkv4i6QskDchd/j?=
 =?us-ascii?Q?cRghDuaq2eLqkCx6Ou1DNAcEZfPkxifL4nmuglfrrDvDaCIg5iTmDULcRlJo?=
 =?us-ascii?Q?DqcvHSgffflRfumGqstkQljgUip7zuoNQzWIz0MnxSDZoRB/EX1KT/4QKJ7w?=
 =?us-ascii?Q?F/04DSlfyVniSTfycf1ah9ky3kha9mCUKw+738SP1wditFQK9A9H9U452DlA?=
 =?us-ascii?Q?7iGH0D2UfnDKaG/F2RHwKBYT5dqj2+FwHKnoTX5Q+zvaGBO0lc7k3FcS8pVF?=
 =?us-ascii?Q?PvLdPUPPi0jNLfAnB2NBIMqV0bI5lQozzNzcx1611tIFcZ27IaZVVs4UKlXG?=
 =?us-ascii?Q?Eha6kcgXVAPPNscMMKkEx83QgWAdH7VxvKQnXyrtrOvnpl2bosUT36mxgcf+?=
 =?us-ascii?Q?8hp/x0uxUwNVOjdLYL0+cyJtpfwWqgMqidD4QRlkiI64rJLAHSxhUN7IlBRG?=
 =?us-ascii?Q?VGh9dpO5LY++rcjLZ/UyS84TIuy+JGGp2PUbSAaMPETH8iWuKTOA73NFhM94?=
 =?us-ascii?Q?tBedfbs1wb0bsD7yJ1w6TeXR5MIX+zqR0inVoE0Jb/5XL4xAcKC/QcOJl+v3?=
 =?us-ascii?Q?D8S438uxsv20/mX9lKLQsF+ADGdiFFg36fSgsSqpsXsEJJ8GNmm+mXbNutJJ?=
 =?us-ascii?Q?EESpSRLCQTuW68XuMnhizop/mJQiKM+cV0tcdMk8Tjy2gLagyG5rJr0+oANQ?=
 =?us-ascii?Q?AiUbvCmTuesKesliQIYrVxiQYnWLhNoDEOb/jtKx8esKYrj6bxAVpzxPa/ah?=
 =?us-ascii?Q?/zVt8JG7Mk/nQACIwESHXyaqiqHDWOmB2G5F6gSkdA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sgo0ELA/Cf7rY/VyyGO0xNV2S1NAn5q0o+sk5DMA93OgV0/gIcxaQ7nkXAI2?=
 =?us-ascii?Q?2JS+ZI7IE82xAY2imwAPYp7CmYveFxG+5O2RlNtDzim25Il1Yvwo6LH2D9N8?=
 =?us-ascii?Q?ybGM0rFP73b81siJCpnOnv9hmMaXQqOnmWvWuGQktSXlKjyB0MnEhlqblXn6?=
 =?us-ascii?Q?pafdYwvBQTcfcbK3JOYFoHqbADlPB1bvtDRNQdY7EDlnU+Ppd4I6lSvcJ063?=
 =?us-ascii?Q?P//BKRgo7PUCywKeBRX/BvsQA0gex7Ts5TtM099UhzSPnudCP0N/iPrBh5Zb?=
 =?us-ascii?Q?n2Ix6ygR6kDQRPO1n6gX7EFNfvzP4LuZv+1otCqGYLmfTV4HMAmxQUYcYXy4?=
 =?us-ascii?Q?e6neJIhfzMYX9rUJNqFP+3AA8vhFtgmtWssSy+1P6oLT9Aj7GgyaIZnefRIW?=
 =?us-ascii?Q?L2ZqFb1eyVbh+day30gLlGTynffsXTl8cNNJ+4NAbluCmfUY91Mq9lN9LQrV?=
 =?us-ascii?Q?csy7zJaMapnRLKOGFpn8iSxKNzMel9zWeQl/BLP4MxXFjudeEnxIbHpn4mFO?=
 =?us-ascii?Q?xYQ8YLdJ17wHsUIGfvh61z1C8ffQ8MGDekzbWKNnNxyAvXU6ZP1bywr1wwAt?=
 =?us-ascii?Q?+cUyuxPoIChO7528A5NWtPv9/np7QDIRg6rC0X28pFAJ5PsGXf6g1dF6SeXY?=
 =?us-ascii?Q?nUdBlDxK4Q8WTlpsaNchSBaD2ufO29LGn2MAvKYHoa6i+smx9ALMOUpSYUZT?=
 =?us-ascii?Q?qeeV1DAREiRyiK2hIxT3ZivuVPXZV9jDaTNt6jfoSKznG0+lu/mnHxlBX4lX?=
 =?us-ascii?Q?FlBsGxyxlMPMsAEemA1GvZHjKFEOpEwM6Szo9c9m2A47IqghtVm6pEGN0HzL?=
 =?us-ascii?Q?YzjOfOAlBexT8qJ1LSRZkt8isJs/ZV9VXm6TtER/zI4AMmJUDjLgiVqAKTG5?=
 =?us-ascii?Q?ZV2qHRDpntpGyraJkaUDNLlMrOLFyqeFm16jyOyHcMUoMEP/uippr6pdRFhM?=
 =?us-ascii?Q?0RPoRer03zBxqtT9avFxM12LT2vjaM9gzJq4CsTiLJ6zHMD/xPLbL9UpLgJC?=
 =?us-ascii?Q?b3YqkyMw6MvL7+76ck+0GcMuJWy0+Xav0sc5HEdnuWHSNt+X3FUvHwOQRDbD?=
 =?us-ascii?Q?hStCYvQxOyUqFp5hhLwcD7bZl606VtvQuuIjMADAV8zNYJG7tqIvaPQ+b2ky?=
 =?us-ascii?Q?p987nj7i6rRMGWo+hDNBH/2vsmccfyIx2ZzN1vc6+baPgAhJ4cUKZJ3v8Xco?=
 =?us-ascii?Q?/k763um4Wp4KH0NUBpdPOf0tCVw2SVKiKZJFMqKXDdjeeU0o/kZKW2Tt249k?=
 =?us-ascii?Q?pUsGLVuNl3ZxYJoIA95hKW56ytxkfV1aFkn3nYtGaDO81kaou+o1SOUvQ4rb?=
 =?us-ascii?Q?9uBsbwaaoPiHeEXwIm8ZvVuNgV9YwlFNIy502znjGYzS1b9GAEywUtKG4ChI?=
 =?us-ascii?Q?UcF4kKXyWEZ3GRU3nwX5VURGin3pn7HYewrl1ioZqtFHHifUfB9Jn357/1tC?=
 =?us-ascii?Q?UrS1IZEjDYWcvZ7HrTDc2Xjoq6EG9mgCdNWqQeGXXrd6dh4rcRj+7XgsYd/2?=
 =?us-ascii?Q?3yZqJKrdi3t/tmgIh3So01kXwrEBWGCfykcjcJGSboQmEWF9DTARF5X41UCc?=
 =?us-ascii?Q?NHpOOrUeREjVf7ijBXGj7r8wdhQVpVfdCXfonsg6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f52b9cc-7ef8-4c21-a42d-08dc793e80b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 02:34:13.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+pH3FLcGs6lVyTfO8N8g5cG3XRZbTOpKFj7++Lzk3qdOrt2JPnw+KdtjguNGlBA6GNNoR1mhcug31hAjOehY5wnPohV3C/JC+rYaJf8zc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, May 20, 2024 11:50 PM
> To: Srinivas, Vidya <vidya.srinivas@intel.com>
> Cc: stable@vger.kernel.org
> Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
>=20
> On Mon, May 20, 2024 at 10:20:05PM +0530, Vidya Srinivas wrote:
> > In some scenarios, the DPT object gets shrunk but the actual
> > framebuffer did not and thus its still there on the DPT's
> > vm->bound_list. Then it tries to rewrite the PTEs via a stale CPU
> > mapping. This causes panic.
> >
> > Credits-to: Ville Syrjala <ville.syrjala@linux.intel.com>
> > 	    Shawn Lee <shawn.c.lee@intel.com>
>=20
> Isn't that what "Co-developed-by:" is for, or "Suggested-by:"?
>=20
> I haven't seen "Credits-to:" before, where is that documented?

Hello Greg, thank you. Sorry, I had seen in some of the patches
Example https://patchwork.freedesktop.org/patch/404900/
I will change it to Suggested-by.

Regards
Vidya
>=20
> thanks,
>=20
> greg k-h

