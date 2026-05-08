Return-Path: <stable+bounces-244690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P5qIOqU/WmigAAAu9opvQ
	(envelope-from <stable+bounces-244690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:46:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D84F33E1
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85DDC3008531
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49803603D5;
	Fri,  8 May 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTqDQF42"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDF35E94F;
	Fri,  8 May 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226091; cv=fail; b=uddzbts/Afg8cghmaiB76h4YkhFBggQDzrJqF+gpnqeI6FObP+CjoSxzw06aIvb/MvFM+Xxr0LQ1KuOVT1lO1eZnvdJRrUy2wM75ZzhxiKXM6JyBGF+g+nHOIvSC4Dq4fGiVd8YTp1OHwBP8s8/d+cOS6VxYDSYV8tdmMn3cSIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226091; c=relaxed/simple;
	bh=SSGpR/9wuJ5CUjZb/Nup9VpHqFespT8E1vVVKyrg1ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qiR9A5j2Z/4mrYIKPqLU6aatDu37cAGo4eleVT1ATmMPBaEL2h1TdGAUtZL4xqWgyvL8dqTUnygT3J0zyKdv7EypzdRvBDKlBnLSrj0lUx8RUg3qBTCsWojWIH10abmlpAE+0rjYyIRE95f6TIuuSkbjrgTdxXN0Jn00gf+rXoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTqDQF42; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778226090; x=1809762090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SSGpR/9wuJ5CUjZb/Nup9VpHqFespT8E1vVVKyrg1ok=;
  b=YTqDQF42R3kFgpStrIpvbWyuU+FnHR3nQvbFxAUto/U8+hCeWWMMOX9l
   gFEly8QvQOJGRJ92JrSKP8k7wpVuq8+4f0+hPo5z3JDecoV8Y4a3AlVaJ
   qhpoolJmrz6seSn9E49c/9IBx5ceqUJunBkGXvGz9Ytj7Uz6Rfs9qfod0
   U/1wuxhWh+O0zkCdN+g0EAuq/qAsKF6xvDKT9mmZH1LrPkgPpicwF4mCg
   t8Hm+Bu7VoN1UUPCvht4iLrpNilK2osxpiUL9b5d4ehjgZV3pxIMjO48A
   p0MmM7OtwtAEk4RsVedUwYfzxnUgOFNRD6rDDfiKd02wBrIYg/lwb3iq6
   g==;
X-CSE-ConnectionGUID: xgGiGHx8QLKg5quBTpb2RA==
X-CSE-MsgGUID: ubx2D8/dTv2w/cqsFE9Odg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90568550"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90568550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:41:29 -0700
X-CSE-ConnectionGUID: Mv1akmiVStOgDr+3J7nBGQ==
X-CSE-MsgGUID: H0EfxWksTH+W0oi2ByTkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241045181"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:41:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:41:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 00:41:28 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMoNbJCbOarWIfcReIGEu7H66WszIbdRRxptzClLhGM95s4GqsDv/ev82mDRMoLkKX/9Z0Ikjzwz7d3N4J6VnNXFOOKGFwHSncrPNyO8NyR9/78jnPC6wbBgaV4yR3MQi3sL1cUZjRZnhcUgodKK9s5EbKD3is5HBl/t9dbYB10ZwS9b4K+jhg9FzO+gOgH1y6hWQ0/A+hsdhcg0mZNgzRegYWo4breg7rb610XQ6O0Yqc6yHmogtWRvlmI7/T2y8zfGwi6veFaeoHeoC4VgLwe2XNpj19jI46+BHd4riIvIvTOZd/8oN/GqPoqCUm+pH7AZqKvOQ/vRatI4IjN+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSGpR/9wuJ5CUjZb/Nup9VpHqFespT8E1vVVKyrg1ok=;
 b=UfhM5mDesFpCNhjAjS1yYYpFTgdoBEDsTMDIdMdGB2NSJPY5lh4PKkDxxaFJ2ZpgOfAly7/R/voVKle/fPGxRP/mrKnnphKFj2eNgM7hFH8AUA/+L1V4DVNugrq9ebYiaAzam8m8YGNPftQ+n8wxzR9PiThrK4so3V6TbQ90yz88LzX82Wv3Iwp220Ku2NY7OWItt65cJ7NW1vsPxpxQrVjQN2nVcN/HCb/o6oohOr9QnupaHtzyM7uaQ+UGv1rFFiwEmzVvuifHGLUJTEKed2cIJvdHIcfZUDQ5EGMOCCXbP+2OYWMGCAOMA938hMOtZq+/KrBcMYlMVydm2Q1fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 07:41:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:41:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "kees@kernel.org" <kees@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: RE: [PATCH rc v4 3/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Thread-Topic: [PATCH rc v4 3/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Thread-Index: AQHc16jr54t4CNDVs0eOWcdM+P8UoLYDzFoA
Date: Fri, 8 May 2026 07:41:20 +0000
Message-ID: <BN9PR11MB52764380FD823D9D33B302E98C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <25398d02373e7592d0555e7da9dbf33b3e83983a.1777446969.git.nicolinc@nvidia.com>
In-Reply-To: <25398d02373e7592d0555e7da9dbf33b3e83983a.1777446969.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6803:EE_
x-ms-office365-filtering-correlation-id: 08ed0c2c-6d45-413b-b760-08deacd53290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: r2/YAIITBdAHV59yZ/Gq5Kip7tQBAdW1oJx8YQZ7YBfKNpDJ82yKpQ7TvnM5D0/lHL4JP2VUb9NjEhLevnlGOtFwOGIzBvCPYqCp/F+CW9OPbZ9CSJdccQEwDvESodHBBxe8k/dgngZxQNOhKofJG+b0U5AjEzAc6mUH7f4T/rc2piQ7D0Rkh8qNoRG1l9uqCWmxBQt81wX2TIbqBv1eoicoFjQE/rle4k0+tWINKWBnGcKO1yguZex/uAuBVm0ooL7c8bI+v70rVOcPvcVBKXJH08lBhkyLJXLmpflFpRp7ke8uChOI1ck5T5qGg+VVr0lfHF76TQzRhrxS2ldI52CqumHYT7vt0KwfldyB1uliGRnCkNLWDg68B/Ca7CaHbm7tkljRkOz4vPluZQxZL6U5EbxamY63h7KrE6LObD0dVYCj+odliws2Tzdto+92FkfFF4huaJ9Ka2rwR1Uivb1SwUNShGP3xgCtNHO6o9e9XXi5bieUTAvJy6C9dmEIRszmM6VKhnvNlhocgcJcEmodv+nW+6SWkZlgQ6idSptRlDtmU4x21n9z4+8a3DJ1/N9iIwklUBBEQ8ngAC7gS616OZUCULh0nKJYtDAF3Dx72Dl8wOvhv0y4hK5mrREvebRfIpAzPbj3gWk2pvq+wYlr4rFwqH03toy2oz1Q1JWGa1tuCXznlYYbtnRme74Q/euaRkbnjqY++58BR9opc3gunu08/zrJCAWdOi9zaAit69AX1yNSmV5YC5pIyucK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ela7c5cNuZCPRZsrxCf1VXrFraMucIPv+bz6EkXJEQ3QqC8VDzldtGqnNowm?=
 =?us-ascii?Q?dQO5LsRK2MyCcTIGoBAkZWnST+j1Yd4DIjw57jh6tLLFOt98XIZ+Q1I5jozT?=
 =?us-ascii?Q?ezBiTnWvuYuFGu0/thQ2SsmI6GM2ICRmxv2NJWAXi63wBtEjinB+8VXusw6/?=
 =?us-ascii?Q?+HXBnyfMmys6hzOVmG+k00Qr9UmHsJqqP3TltHLR2Ll1bhCkTpO4HiTh1LyZ?=
 =?us-ascii?Q?zjl4n40gO6DMMFAtXd+Lm2UheQ6jOF3kCIQ9ZzW1mPg/XFgdfHkcH212s1As?=
 =?us-ascii?Q?291HJzY+IhrkF9+3SUod+dGxFTJAVt9QRsTlphOcDwwu2IL0Mr28tY9ZHjnp?=
 =?us-ascii?Q?x0Nvx/YV2m+6jDMRpKXjxcy9mZzK+ZSpOA2F0nQYaDhcgFivOkTKngym4oy2?=
 =?us-ascii?Q?MpN8DzQT8Fk2w5bYyXEPwbTm6u2HQ3wymHajGRZ7URi/FsPvSa7IzsQ5djVF?=
 =?us-ascii?Q?k6CRbMi6HrfyFt1s/XX+E6QXidNMJuE8zWlKpwX2bnrrH1+1fPRYub+80Nhp?=
 =?us-ascii?Q?wfh50evzrE8ILmPeDj9QONpw/LuetP+YYsoJonpklKKbh/RfQuE2d+5bpR+r?=
 =?us-ascii?Q?EUDApz4iyngagv+TyctS5V2zXApwBy2AfK81BBSgPC0vQHgBvL59g2kc+in2?=
 =?us-ascii?Q?6XMUvgRwh8M5XaL3tZx5C2QQKHcf/CW7By1C/IpFihF7wzNX+NRo8UFIC+zY?=
 =?us-ascii?Q?6K2KdGDAxDTqEa1OK873kOeWuJfunjnBYUwx61QTpJNrKt8FGMIXGqld6Qet?=
 =?us-ascii?Q?LWhcH3zI9fTy6pofgCHDu83QbWu0ewGaW8F/a5n8FpSEp4ZgTu591epAANdA?=
 =?us-ascii?Q?TLzlpiAD/EgGp9Zwdy8Vwt9Ehs5JcXOVvqFf2tENr7T8W2/WoNhoLWUpw4k2?=
 =?us-ascii?Q?2MlxiKCO11ZqKN2hJIzxx6B4EEsIKk3fIauxNhG+pY38vyEUdBwN9XHMCJah?=
 =?us-ascii?Q?cP0almQwgilh3JsG3qG+cbG1zYh9NChMFL4xRS/A3npoA1UE07UFLosuiMdb?=
 =?us-ascii?Q?+OZdb8xqxD2uQmRg/x07QYepWVcq8ujSl78kwpWtvN+ZNgCZ3Gqr2D3UAaBo?=
 =?us-ascii?Q?ImOlWBC6zgK5G9iId6wBbnMGxIfBGULrlUd82OOFWMlfRNLt8Z/nAq+Xwg+D?=
 =?us-ascii?Q?5hJo2ESuPy/3uYM+shQoBw+/xphwSsNouqSsl+5zkGiwNY8QpgIQ0RrnM5Zk?=
 =?us-ascii?Q?bW97OPx1+6IKIZ1tIZI06nhhlpf7JboLxEklLyKm/BTNgDlfl+LoJhbRXXhC?=
 =?us-ascii?Q?wP6PteBgnxONkJeoGudi/UQVeyMKc7voPbgL1Ixl0zB3V6cWJ+0UqjkXtcXO?=
 =?us-ascii?Q?57U9cyIXXr9YGNZZLOv3wUgfSmc2lDI9XXQ0ps0nLKtHYcY+Kwq/+xou8vvs?=
 =?us-ascii?Q?RoMgQZsmZ0If+aHqoGHehcYQgM6mMfO6fCmqDH6OrCB0TcbCb10YSTHXivs4?=
 =?us-ascii?Q?rdsWxjAH0xXHyzd/zfDcOoPaydPFlsqvEOynE9urvAD8PsPht5wj/OmKwGu4?=
 =?us-ascii?Q?4p4y70f+TJG30J9bemeskeFX/MwPykXKzmc5iz5AWiObSW2QIvNRTKfS4l3A?=
 =?us-ascii?Q?PRnbluQTEK4xM4YdrZpJipkh7QB2L41I0l62Ms/sKPAfv4v0QPjn3IKYGaXG?=
 =?us-ascii?Q?D7v7zNG8jqtI67/1H9odApRtNmhWd2TzMnaJU9H0DcdNPHmEjIfiuLZU3iwq?=
 =?us-ascii?Q?feLjKrdcYvuhCq1U0Hj6ysGutDo6qMPEBsAzIm3gYxeCrf7nXHJywF8abDEk?=
 =?us-ascii?Q?x1FFSZy2sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t73t/rKTBUyMnpEvrzpVx6oI5K3pvGaksepHnvC6bPB/mmNWSqGJFAA6TnclIg7tKXo+GbuXZlpl8Pd8CZN0uSMjph6mNUU45mSPGiEsBulqeFI8nVaSNDd8Q1mqb8Mc7T+SAV6OC5VtLfdFUzPL4VhyUwQ+muXX1y3ZmrSMUpGacVKVticqolVGnH0sxuGjkQTBWvkuKi+2l4C8LIf+wmiZec1wQDvZpWmeiV40yyIngXtBQrPyvi29aBQGtKgAS9szkbcMcVMYl1BidNtGNtFLQTAIi3gRIn1MTz9aG1mWsStWh1l/MrRi/7QZKIP4TVdhdckcllKO6oClXBT07A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed0c2c-6d45-413b-b760-08deacd53290
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:41:20.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc8RtagztZhhvmIWza579pfqFc+M0P/kyNPx+cZmPIXGidg9eF3TwkkSSKrx+fvkkypMKJ5uTcn+txRSbId2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1E7D84F33E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BN9PR11MB5276.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 29, 2026 3:21 PM
>=20
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted=
,
> which could trigger event spamming. Also, we cannot serve page requests.
>=20
> Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling the=
m.

this is a refactoring to achieve the same goal as before...

>=20
> Skip the IRQ setup and guard their thread functions as well.

... while this sounds a new enforcement (then better in a separate patch?)

>=20
> Also add some inline comments explaining that.
>=20
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU
> is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Overall it looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

