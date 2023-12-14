Return-Path: <stable+bounces-6720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC7812A3D
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BBCB20DE7
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D1171BE;
	Thu, 14 Dec 2023 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfWyrqfU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D1BD
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702542282; x=1734078282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=y0l644gXUQeK1rt2tfZliuKLYKschtn8IbkfLJwCjsU=;
  b=PfWyrqfUKpdvbn9r1x7Q+Pmi/wppOzlRazDAWY9uVVNhHXhESDCwqypr
   VWQmkwdhEuirnJwqVZvQTIGbXjnX+M3Fg0qkMSpz3XtIInqwaQbDCRTzy
   FdXoZp3W/l2Gm4Sw2DZUT5LSK9QEfM98LlwKyKTSNvEO849wEdGmAk3qh
   WuZ6ZjSMWLq2pQTGB1Hp14JHV3at5CNdBVtiHwp6bAxS9VARmwf5CYpz/
   jCiCG341me7eEUBgu42Neh9AsvFcJZVPXkBWN+WyMXzUP/7JxP+gstiQD
   h6Vfqv81TNR00I1Sarqs1R/YqK3YlZFeBmbQAT+vlPIO5Cgt/JMZ/2m0R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397871693"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="397871693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="15757801"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 00:24:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 00:24:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 00:24:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 00:24:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 00:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgCqo7OXV5j31x4g77ceP/2fR9U2YP3ifP4m9EwZExaax/h9EwCvaIEzEVt4LuUf8KL3RyO9goMIZHoEqJ6v8BxP0psy/KyNMJBZ7Pq2zOO08YNiXY0czrWwJrTfle6RVw6jkTE8OpUkWm/NpSX9w/GESh+kB45o8clA5bFQRgqRZLChcnhfcizncEoCZFaCVVM7ZbL5kY+f8R00ZBe5ztWF6THwxCksYKY+Epy5RYT+KDqJyQfV5DHJ/fJ+tbhP3bNZoowSMez/xj6yWNJEuQouyMRbRUVGFZzdwe4zhJpGtJtXpC757gXTjm9iWEq0gJY7iLFiqmg3+GpSlHGdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIxM7Xc/vHoGjWMV9RxaTAk8f4wLrSV67nw6+B0gl34=;
 b=jWKfWLME0jeiOIb68VY7QCSKSQDFYkGcq1t8RtX/d+f2Ql/3Sg8F8eM5CiKEkiWS3ie2aV4YUseVARgIv55vXmZ5KKAjCgXF9sf09/+jVHySrMzUoSd72E3sdAu8rlfxofk4zqgfhgYA/htyTPOxmD7Sb0TkbSCO0yTfs1UrA/elBex1npb93LFCqpLnG7VictaVM242sgbqpnXFMwvehT+31jDk0cPww8VZZGDWcvQOEsD2uYahDTdHrbRRguxMZNZyu7tQhqWBQNUBDiFqvN5I0nN/XHAiqfBE2uwpoOS7xCUXWGe+xIaj/8+aKuhjSA0Eq2L23gjW/ZFJ066pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:24:36 +0000
Received: from DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e]) by DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:24:36 +0000
From: "Berg, Johannes" <johannes.berg@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: =?iso-8859-1?Q?Philip_M=FCller?= <philm@manjaro.org>,
	=?iso-8859-1?Q?L=E9o_Lam?= <leo@leolam.fr>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Topic: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Index: AQHaLBDPGcUd6QwgaUOjifUHynaWLbCjz9MAgAAARQCAAAOiAIAAAW8wgADU6oCAAzjYgIAAjRnwgAAENwCAAAEtQA==
Date: Thu, 14 Dec 2023 08:24:35 +0000
Message-ID: <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <2023121423-factual-credibly-2d46@gregkh>
In-Reply-To: <2023121423-factual-credibly-2d46@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_|LV8PR11MB8748:EE_
x-ms-office365-filtering-correlation-id: 3ef89baa-720f-4128-e912-08dbfc7e1b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twwhtFF1IOawvioWQ2aTD8usYM/BfiD7KHuSHePG9qmbeMr8fIlG7QLVduaPt0/GojBzSwWvJXaYx0GssU7zVkRIXQuRo34LRIGO3o7cfBobplkDJ8HqUtE3c+faBJEvRrASa/bYPPBJ/m2tEX9x/K9ugHAVTY4ClgWvXa9Od2QhNRkIhMtaStIWhvivTqgSd/PbTojikDwZIgHCK517s9wZIYpi+oTBGdKRq3WLP8UGaX1DtDSJsVx/3Bapmzq2PhGOlQhKdL55zMMyn9vGY7MhVDo1rdgUwtQqbEajqmrHNA6pEK7b/O/GX5c1UtXUMsMX1wIecxxm88l7A+mXgFp+HmYjs2/hE505i9RZbYH+WqCYmYFCpbtEPMa2apJVcoODYY73sd/3fzPjQlThuC5Fe+PxH+TxU1MhB2wPzMIk762jwg+V4bLUUhNRnspzVXRt7U1qyKu8SVqx0V0ERNrj0J7o7Q0w0KSR7oqHE6LflZRji06mlvZvzniRTG5MH0F7yI5A2bLnOaTg+fuOYIYXDR8ZCzGL1b9CE51dSBAFV7pyTnPg0z8XgZzSrUD/0FxmerXzo6i4vZ1rW5Z30VFtEkT/V5Jn5mOF/HYDr+otlMq8IZ8IxqBKgG1BaKW6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5359.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(55016003)(122000001)(38100700002)(4744005)(33656002)(71200400001)(2906002)(9686003)(4326008)(86362001)(5660300002)(6506007)(7696005)(52536014)(8676002)(8936002)(26005)(54906003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(41300700001)(38070700009)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YmHaLEpmDyd8f8kPAnAaifChMKpNQ8DVyXUwwvQ6CL2LhrEcxJw4bEAM98?=
 =?iso-8859-1?Q?9p3ihAf7dyv7uf7lWqLEdoUpvbLv0IRZH4El51QP0kof9/X+iOMY1ppQHG?=
 =?iso-8859-1?Q?VRavjVNsGsuTvK/M71tM8PlEXGscSiI2BcxTyJdk0O8AB2xcow9x5RFew8?=
 =?iso-8859-1?Q?L9sUXYioJ4vQNhEbAiO+norXnLhrslw4JbyLN/irFd0CWkdbq484VRd7XI?=
 =?iso-8859-1?Q?rnEBHtAdNMZLT0tVvKyAetvoOThxLHIBmA4diFNhV54Me+w5HNTlxo0SP8?=
 =?iso-8859-1?Q?IL62cWHJ/THeolZqspFW0Ezqp1gs4J9UkhnM4I+FTqmXHr4iOE3RiUAaw2?=
 =?iso-8859-1?Q?a0TDh7TynWhjhsUyn+BUcV3/4pRm5zHpR7IWb5Hc1/wd/cKa3s2PQBofLq?=
 =?iso-8859-1?Q?0bBNivOBrGOOR2GDqJuId1Pd1v+K/sNp9A94eqFdVmRoDblVAy6jeWJXIq?=
 =?iso-8859-1?Q?c2IZcS5fpwZKWPz9KiRfevsYpgI56jHmeonUCSVa7TPz0nHPBupGltTqza?=
 =?iso-8859-1?Q?LCaLurTN02+U4QuQ9YH+sEfay1hARZHG0dupF8sAtP1ATBmaFrnY2rqnxa?=
 =?iso-8859-1?Q?ruDE4srmNGoYPcFj5f4YZAU7WSDjZL8DcnCMPfB9Lkc4K5HcBhTkiy8XEN?=
 =?iso-8859-1?Q?Gm42Gz2wj1s2D+GOkWP+3qmQbSvEF8nhq82QoU2maN1JIAe4VTKyciNeh6?=
 =?iso-8859-1?Q?H+48EWt6UDT7EGI3Uceh1Dd4aXTafaCMAXwSlKeKHHNUx/7nPFEgV/iUeB?=
 =?iso-8859-1?Q?9KfWQVX257XHnQM4J7LZ0lEhR7/lcY84KXK7vNxGJG/Bsq/OqhNoBg4Puv?=
 =?iso-8859-1?Q?/iyodtZPH9VkOooy2Hmpdz/7zP8Kq8Qy5S70hd8+3pxkIY014eiodJ2H6z?=
 =?iso-8859-1?Q?mToAM1AKEeAGZ40R893h6Tf3R/reqwh8GYifYDRkLzJ3GMzV40FVP52jEW?=
 =?iso-8859-1?Q?KwjBIEQFtlNvv3OytPtrYfFcYkDAMVwnm5s77pFwOudTDa3uJima6DWxei?=
 =?iso-8859-1?Q?eOMsy5X9bZeDD+60flHJly677f9RzhXmB5kI29j16mOy8VTuTZ2LeSPtFC?=
 =?iso-8859-1?Q?07ElmCAFIqB3gFAhWyV+Bt40/rxSXiq5cOmkAEBlE1UnxaoGfoFMzS1HFl?=
 =?iso-8859-1?Q?waQUEuwElWdDxfzdoOUzk9YMf3YkvKlwOZU6zeIIvIg0Tgm84e2SL/BGE9?=
 =?iso-8859-1?Q?2zbbQyrO8+o2MytEzWYWeJHzga3aQxi84vQlomyRfE8QCtxwVq7u5RDoas?=
 =?iso-8859-1?Q?JD4glE3oRr8tpkQgoIC5S+G3Lz9BIWZ1poOdq77lVy79p3R+jWU1hWEXZU?=
 =?iso-8859-1?Q?4e8xEW286PictKmr4bB0UwhCclQd4Kq1t2EIm1sjUjjTeb9lMaT9m8hedf?=
 =?iso-8859-1?Q?yuOGbIEyTzt4W7BlJi/5H9jWC73b5g6X+I2LKYrnv+LWiGUEPbdpKod6su?=
 =?iso-8859-1?Q?rkvPdmsbwHaFjtzyDYYaT1CRyL2pNeqo9dd/oXlwRMVrPFy0hgR2QdwzzC?=
 =?iso-8859-1?Q?/HeiEKL1AZ9jEuOqBXinQEOEe5Vj9NxBr9X9bZW6Ao3ne1hbyjgMe9D5Se?=
 =?iso-8859-1?Q?0Pc0O0Wt9aJiSDqzpljoVTEzHhp8iI+j4MVQ4aijtUrHLb1IA/f0nDsl5l?=
 =?iso-8859-1?Q?wBibzokVD7G8sWcgGB0fFo35AV6QSfYaVy?=
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5359.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef89baa-720f-4128-e912-08dbfc7e1b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 08:24:35.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xooAZkGrnLPRwr5HP9acdRMgPd1bW48gC4ZDzKAQHhQkbqrtYSsIW2MAwtbb857J0yx8bL8mXAAquJUq817fiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable

> > > So Greg, how we move forward with this one? Keep the revert or
> > > integrate Leo's work on top of Johannes'?
> >
> > It would be "resend with the fixes rolled in as a new backport".
> =

> No, the new change needs to be a seprate commit.

Oh, I stand corrected. I thought you said earlier you'd prefer a new, fixed=
, backport of the change that was meant to fix CQM but broke the locking, r=
ather than two new commits.

> > > Johannes, how important is your fix for the stable 6.x kernels when
> > > done properly?
> >
> > Well CQM was broken completely for anything but (effectively) brcmfmac =
...
> That means roaming decisions will be less optimal, mostly.
> >
> > Is that annoying? Probably. Super critical? I guess not.
> =

> Is it a regression or was it always like this?

It was a regression.

johannes
-- =


Intel Deutschland GmbH
Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de <http://www.intel.de>
Managing Directors: Christin Eisenschmid, Sharon Heck, Tiffany Doon Silva  =

Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


