Return-Path: <stable+bounces-19772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9968535E0
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D8D1C270F0
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFEA5F86E;
	Tue, 13 Feb 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wp4JTMOo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AD5FDBA
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841226; cv=fail; b=QtqQ4hm6hGjDfd+89tD8Bk9Aw92tBE6MHqPLNNeeQkgGX8TaWOtLI8/Jco2OaKA4nkl8iHCbBO5IKdUeSKT71at0UuRbY7EPV1vQRYuCJbLuwRYFGHli7A62VHUgPpq0HREVO2aNka/b4doG86vrffn/l6fQlWPQaQ4Ohlb1/P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841226; c=relaxed/simple;
	bh=8ddyaGdytHVOZLlcsGzSkpe5K04R6ODdrj0OWio21rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGCqnMnPA73P5G1UCbDRum7A7SVSycRUJvVZVUb6bBewW3wHp0p0T5xAFo4L6QxGfnzJShoFtx04SZWyWGV3HVQo4Og2aw8efyl9Dybhc9s1Nyju5sB4Uytw3pqDXCh7w5FBAMesDs2j9sq5n3SoJEHHGx/7aOLkBjdO74Ko2Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wp4JTMOo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841225; x=1739377225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ddyaGdytHVOZLlcsGzSkpe5K04R6ODdrj0OWio21rc=;
  b=Wp4JTMOoIFFnkk+rBKCXgSpAUJWzeYLeNAvPijOxS00hFBj+lUPNBC1N
   x8fLumRz7lu6jn1WNlbbpAoRFwcB8k0bjfWl+qIgkmyEXvmTzWUj61Wyr
   Z0KoI53zH1E4698X7+mQdmu7srFLKEBdGYD7cvq2ixtrioS+IGOxetv0h
   zHLu5llYqdI/Cje5HjX+0SehOywnyf1Yfyzlj0q3o1pu8XbDQ1I0k/Gzr
   xzFTxhkYFQUQRssOQnTvuuZaMtsppjS1BAhXQm7TEHKeNPmyf5hKKUvCp
   xrw0Aq0dbEkSglaEIaNPxOKC5U3cDNr9OM+7RPy2hJkNuN5eQD0JX8k2c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1761423"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1761423"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911823569"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911823569"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 08:20:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 08:20:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 08:20:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 08:20:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 08:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBhy7tCK4NNco4izpVQnXBn60wp3d7aL8zssTeVoBOz6fK9vvVMqB+JvUGfTUxz0sMTt7yzFfXdvdpR7cVeHj/wXryQ2xU48wmhIeN/1eTvUWFua6m47jcMX0TnU7dm4K3WciThCaXXqMifeelQDTPgFTOOGFTh3l1khAcyvTTbkYpQo+/LIPJ+omvIq0Q0dTemn73FCGQyjb3d6DNPK1q3ADmJyL+k2VCwfe2NwNr+IQxJbF+RTrIlo+BzWTmur/9dx9ixxvB2yMh7AcLa4eclWPWn+hCmEfGQ+XYpGymZ7nn1Az+RHh2WK4qL15/LY+flgeY68AwGL7Mw+eLEeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNQpXyeg3mbpS6goHn/l7ulrz1SALnc/tznqBLrzhbA=;
 b=OE+9TYFUcVdZ4n9MvMuh0H+fvUrMOmM7oh8mlsU4II76SVaAeIYC6A/UTe3Pm9jrs8W7swpM6hEbUDT3bD26FI/45ww8G9hjchaJmuMZS2+51PEceppgUz0Icgc3WGXaVUEICyjjBMybajq4K7Ec+p8Fbv4K8MmJhZDkkYbTEvRPcxBSLci8RbUXdr0EWqidlBySaJ/2VaxrRtMg90zu0zZROJvzUlYA37njUNSdagisujEeq0T65SfVivwci6IN9Ue6t9lttesWR2rzvN6u9tBJl6Z5ti5FJP+NcR9pAIr6GwK8yp2D9veGUsYnjjvbYEVSYTcqf1Yza4LhD7tmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 16:20:21 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::e3ef:602f:a51f:1b38]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::e3ef:602f:a51f:1b38%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 16:20:21 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, "Saleem, Shiraz"
	<shiraz.saleem@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Topic: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Index: AQHaWeNSxGKqsp2klkaONnvqAVC88rEFWkqAgAFZInCAAbIxAIAAFhqA
Date: Tue, 13 Feb 2024 16:20:21 +0000
Message-ID: <SA1PR11MB6895AE19B8C02FAD9A84BE58864F2@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
 <Zcj1JyNJww8njJFv@sashalap>
 <SA1PR11MB6895D85EBD4BEFDCEC57AAD286482@SA1PR11MB6895.namprd11.prod.outlook.com>
 <2024021314-predator-scientist-84cd@gregkh>
In-Reply-To: <2024021314-predator-scientist-84cd@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|SA1PR11MB8473:EE_
x-ms-office365-filtering-correlation-id: 3e28c7fd-243e-4022-b0f3-08dc2caface4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ps/dbD7moUFUFA+C28Ws4QLW+iKuKv7Q4yk9D2SEvA98Hb60fgaAW5/+oncqi6cxHdzNfHLD6bghLkNgMeRVdbUvmGtBu0HGKyZoc1Y57xcVKaPGH7iZ3P7KVBAb2eLVyNcyOb8JQIDw5cGWchpwJJiPdYK+FkEyRO3sc1UItksOBYFcqTf2kASkelOVTPw7ve4n9Y+6XZWCD8AKpwmvVvpDi/DdF+BsjAi9w4tsWOXdFytGDlvPnFV+wdX+gYrvj2Qqcefuy923FqZM4JgMhzWdNeccR24qw2aCnnkHoou9uE8iJEJkXeZOVlX9yfcQUfuEkmaNJHG7v8IG+fw8tdRyCraObPsW3P3wiO/w4qW84gZp5a8RnkFpQRYDHTvdAj9RI+tbiws+Fp8hsFIah8uNiv3z+QHEyS0/q7eOu2keuehPjGMdSCNE0d601hk/57XYFB1TK7Jqk75TlO0iMe1+eBDrd8qgesbAEFERUm9zcwi8xITjn8XBqtiRcilT5AsxjZoKvTNl5ch9jGr6VGRR8tS8ngvHbnOs9EpOQCqwExOYCSaGd3gPeRqZwTkWNyI8mq6p9VSMywloamiqYKjwMDDHx5B4r9fySv9P+K7s3+BJDVBYz5i8yucbCw+N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(8936002)(8676002)(4326008)(4744005)(5660300002)(52536014)(82960400001)(26005)(38100700002)(33656002)(122000001)(86362001)(38070700009)(7696005)(54906003)(64756008)(316002)(66446008)(66556008)(66946007)(76116006)(6916009)(6506007)(66476007)(478600001)(9686003)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W53luUzw1a8mxdJVVd8FyZOY28LjNTbBJ/KQoNiPOuIRkE0Kyyr9hO+9Sd8C?=
 =?us-ascii?Q?zJPJ55XLdFtV37F+HEjAkAeWOnoaLmcFphjPqCm7f1DwQXw0g636hs2BM969?=
 =?us-ascii?Q?Hs2ycYciza9ReQzkmftXsP8q0A+SjoZAlMS4uJegAQj1D8gFml+lmFKbpCeG?=
 =?us-ascii?Q?gswz5cfDZcIeQEdLgiQ7lAaShT7f6psFZyl9VPg5WY/KtVvaGVa6dr3Fsx/5?=
 =?us-ascii?Q?jo30wiuw4m+gB9ia/c/sDFUrJBDNNH12rye9+3GHsINhvAEiL4qgBrYN2ujg?=
 =?us-ascii?Q?YH0JSuZXre+ZvpAApElSoRf+K8RA/Mtzy+gXcFJrx4gI7zDkSvg+dpI+qGOM?=
 =?us-ascii?Q?TSOuQHT8ADD5MwoW/nnZEHioKLArgPtmwGoQhdpHaigel6qSJXmhdDCjnEfT?=
 =?us-ascii?Q?jcQiFcDoMhPwxbMYHVDQFRjZO7C2togNFiaJZYrU15ZCPXSBGtgsmHoFam1J?=
 =?us-ascii?Q?bOfYZY9vquZhth8ZnDbukZanozWkBtpQVxaMfH/i5NxonQ9H8F53ew25BEdO?=
 =?us-ascii?Q?NU14+LCxiOdZfBSLtEn62hkeqGZqm3BcRrP6UKNY5OMqfArRJcf3z2ZxABZm?=
 =?us-ascii?Q?htDe5mUOSWsK4c+59OBETTb3xc+/cTvr+JzxjY0XNNQGy+e+2lGkAcg23ref?=
 =?us-ascii?Q?ABc6I8h2f1RwGWL7SwBQkVPtSnXu42AMdH4WHGVaDS7MYEQCAORSD4X5FfHU?=
 =?us-ascii?Q?q2IiFUcJcAnVzW7tvER3DBKsLVsz3oKjmk7ARu5OhZ9Pumkl7NZL+dvMZDox?=
 =?us-ascii?Q?yQdJyvMAwh/0/yv8eEflcho9xuN3W/k5zBvQrkmC/oEH6L4R0UYcaTOK5SS0?=
 =?us-ascii?Q?GsGTKHCJbeqHnQ75BGEkyHHUA3t/OpJz9YSoA/adYqxVUXQgIEv+Yz3AruSW?=
 =?us-ascii?Q?zEi+4bTeguJzIlGkXuIOgsUfbqak9qDNzT+WcunfKLfe8k2VMFj6hsjdCDLd?=
 =?us-ascii?Q?3OYnjn0YqUda3OfjSNX9+6FLDUBu/7OD2tMIDGgSh98Yuk4Of0oeZIHgEO5z?=
 =?us-ascii?Q?MAvX39GAFrTAYM/dVmztPNBJ+Uh9zmmFY1JHxjuhEEZWHQgl1lKki/U67j4W?=
 =?us-ascii?Q?2XmyYm4WS3cPw2ACVu6EJ48Oy+09m0FlVPCaOBexTK5h9+qGahJ/LbA/u6S6?=
 =?us-ascii?Q?jTaFtCqcLtmfNM7qqBUT+ZIJ1Tj5kpy3rLOqbATe3zO9SpanIhHZIom4wqJj?=
 =?us-ascii?Q?wuh/mwfPji3lehduLYKGXfdyqLLnR+p4Fl0fZyvKjGHRbB9S1O+p7hqqgzpV?=
 =?us-ascii?Q?86hcsTOok+L9YnNNImA9BVnS8J/lPZrabdkEoh6HTsr+WWcHAk7WQ7z3aM+F?=
 =?us-ascii?Q?HiJBY/oNfulzmVD+jCEcKiQSXkIvyHIXgYQ5vTQ2nAzV04+MoUutyNR1fAsU?=
 =?us-ascii?Q?ZW5IE+94GqkN5mMPR2KqQASCAX/+rxIM/cFsqoaFpViNYNJ2Y3wJjyDf43wL?=
 =?us-ascii?Q?icHmhkP54gIBbuv5HeB4ePlYNyqc2d6j9ioCK8dW3T+XKlw0YiVzSCh9gGe2?=
 =?us-ascii?Q?PzOqh5tLEutyG73Z6c1oKGG8FkGedWFLhzpt8F6jOAuTlnek4ox1MRT6OuAv?=
 =?us-ascii?Q?7kByTXKi30QU/jmNzBg75a99b6yFvf/ZuUqjnVrY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28c7fd-243e-4022-b0f3-08dc2caface4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 16:20:21.1293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCGQ3kB2PtUeX7tVQnb/y0ha2WyiWP8k+myk5/egAqHe/R2FG85usRom5BgAj1e7d6lsEjSx8yD1l9NBBhgVTgm+uXTE2ZKCw6nhdgeCL6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com

>=20
> Is it needed for 6.1.y or not?
>=20
> confused,
>=20
It is needed.

Its just the Fixes: tag is incorrect because 6.1.y branch lacks the commit =
indicated in the Fixes: tag.

The upstream version split a large routine up for clarity.   The 6.1.y bran=
ch contains the pre-split code so the patch needed to be ported into the ol=
d larger routine.

Mike





