Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0797DC3D5
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 02:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjJaBWE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 21:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaBWD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 21:22:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834BD3
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698715321; x=1730251321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NjV3Seb7Ygml6pM+VeyDRSHd4h+Vht1Ioi0tgHnvKOI=;
  b=hOa6eWZ0IXgbP9g8lFM2GIeHp6aleTtRIjYbfnPfRmFfGRs4CJ71lQ0T
   YYKHBcoHCju7W9fzxSqdvg0TogQac0kAsEgZ3ZZ0cBmDTS4erJkO1N9Cp
   gWwsdWWdzSs5ezI1CgduqqnOeT5o7paeZRNTxEawOISUc0KWagxIawD0I
   UVJbUfJsbG/Vfx62m9aCZ06O2zgwoVPkEOEwcIcnPJvTHhaTsc2rKkI0o
   jct40nAzc4XjM6EFnh964QrCaDTu9tYyrdjpWCsvCDiwn6in/3F/1LnO1
   d9FTxwq1cOjfmu1U7RUgpp/qfJ4wd3uSN3nBvXY+u3sPD15Z7dQqHgG+u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387072315"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="387072315"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 18:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933953337"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="933953337"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 18:21:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:21:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 18:21:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 18:21:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3WisWRY0Gbavdp3ScOwlXT8oxpIKNdRykvTwCFefdNGLj35rBCFxEO9B+RU97bOxJXDxFMbYT9ggMDkQakfK8QrKsTWvYuCBsa7/O03rBMcTbf/57JoVtr6FYTTyIUTrN5sRYr/PzKRbEnTX9+qLBHSFbGzvaCp1FexYloMFrMcTOSI7qNw/EZJqVKcjdd4shqhqDXxUv/o8hA3a2wvBitBQ/ufRr72GdFk8TFl3Eur+1LYDxrQL7zYhBumpCrWu0QQZGMfYRLCWDIStE5mtojEYn3mSdfE1ga0Igt2NJ8zJHHcLHnwvFe1fMwQTik1hTHONi8SW5/NwQJLyBkjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjV3Seb7Ygml6pM+VeyDRSHd4h+Vht1Ioi0tgHnvKOI=;
 b=OrXLbvDVhxqvzGhf8jdOFpZ9M81E6hRDD9jwTGV4PGvemdy5TGLQUo/C7ebPrAT0eXmEyoS2oG+UsObYJXhDCWm8olBgdQxT3Bjlh+1M0s6QgGBP55qbYsAPpFNiam5gJPy03qpYuWy7n0A9+qirDZRqGemjFuMzaz+TY/rWmWsBGCVomkkXpYwbqqy00nsQMeHsZBpEZa2UgsI0xH8lysPfBi7vdQR0pywDx+rgr5Dok+4s22Sbago0RqowoCh3bCZvEQpfPHLGmmXleAIGjQPja4DhXhWVBmUK3yRDnYsbEq39bw1si0HVNgKBB9qRjT2n8vmLkLSk1RYyXr7XOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 01:21:45 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fa82:7379:fa25:83e5%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 01:21:44 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: RE: Security Fix Backport: Intel RDMA driver
Thread-Topic: Security Fix Backport: Intel RDMA driver
Thread-Index: AdoLSiwwhqo3aGbnQQ+PQr4IGX5eAgAC+0UAABCdZ7A=
Date:   Tue, 31 Oct 2023 01:21:44 +0000
Message-ID: <MWHPR11MB00293F199FA1DF2D679B0FA0E9A0A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <MWHPR11MB00293EBF6DD3DAA4C836E382E9A1A@MWHPR11MB0029.namprd11.prod.outlook.com>
 <2023103015-footpath-veggie-63fb@gregkh>
In-Reply-To: <2023103015-footpath-veggie-63fb@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|IA1PR11MB6217:EE_
x-ms-office365-filtering-correlation-id: 12ba5259-fbbe-4f3d-f257-08dbd9afbec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXRkiroLx+BlkHVG7/PW+xPlX3b6lSDE1x5yWQqNt1l87+ZZx+cqxHsoXNKSOTftxk71n+uqIFbqBXEqJbCu07q3nBXyhaTUveb7Er6x63luK30BQuHka9f37m3ufUF375RilrA/TfoXJko0Ts3iSIH3sSBVNx7Fnip2cUCwEE+1xcli00jhpQSYpAAmFycmWW6j5jQgk0TOoQrDTyN9YDKtpgjKvGay6Ws7lps0rhyZZrDimKgH3VCcsEfcpxG0sPl5NIRrCf5/ijd49+NtEzBzNOtNWrYXYWqfJYV3m4zp5Juj4jgrA9CZeGjBMyCTiPK7EDuVoUHHDYkjvChfjqjvgAzAijYGf77RS4QLLhuGG/QYvMuf/Yr5+0pdrV1UPR7naneXsCWZc1arXepCzeboAfEUjtoOzDZo1YQanAHY7LAT4NmorF61PY44DGWX7kPbrHZYUFlmQ6l4/+8ONzPx+6G5nphasTQHxfwj/1HuShmIQwxJF80n+kw0axKPQZ/lmTXww2HX7FtrbdNAG6YUPMoXgVWJJDjazGdiWqqLyIZuKzhEcYCFprD1CGFs6S2Eo2ho6XZFtTcBCXZ+FTY/oRZtNYrNDgfImG/Whac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(9686003)(26005)(107886003)(7696005)(478600001)(6506007)(71200400001)(83380400001)(15650500001)(5660300002)(2906002)(4744005)(41300700001)(966005)(66946007)(66476007)(66556008)(76116006)(64756008)(66446008)(8676002)(8936002)(4326008)(52536014)(6916009)(54906003)(316002)(82960400001)(38070700009)(38100700002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v2xU3KvNWwilGvNmmUnL5rkpdybllCBJFa2RzYCr6d58szlXkNdY4tWd3icm?=
 =?us-ascii?Q?p29TFsqJCOl8kaGi1ycjZ7Chda6TfolDFa3PRaKIT2ecF6y6vIC6Jnuiwjfq?=
 =?us-ascii?Q?heYeb+4dhSVUQdpO6yyzVIgd65GvLMK1vCJWrpOOFUgKpc2OleUUepSkIQTa?=
 =?us-ascii?Q?SsqBE20m0vvbJy96jMeh6CYnbR+0s+k2uDdg/bVwfFvC7uY00mULFNA4jHvP?=
 =?us-ascii?Q?hdW097I8er9WI9eGRij1u2fFxnm0mxaAkDbwO6PJop4FPIxm0xgSyGQOCNfZ?=
 =?us-ascii?Q?gEd4+zN/Fw2t1MYMuRLM2ZTOXgP5Z8SXz6secTZ3dxNMLGXwhx8slZyLBbjj?=
 =?us-ascii?Q?q9amd/34TKLXBt0ZrGw2d2LPRzyemfqz6OMLX+XNSXE/G9kf8rhs1ay5Kenf?=
 =?us-ascii?Q?M4vfjMFgVhdhGBcRzbCFqyerkbnBgu8NboC0yb8fV+XSfpHrC09xDCVX7rWf?=
 =?us-ascii?Q?EnIVyv+gexSPM/5jef4VFBFaS5RCsaerZAeSgQJkvyDae1VwgPx+n2ZhKnw4?=
 =?us-ascii?Q?MMIXKQRM01RC6TBLhfbb0sk4AGkOpFme56xNa9iLZ8EQX2Y61ybyxB0qxa0S?=
 =?us-ascii?Q?FKuOZvcbioTHzSz29VCky/N2Nt7q2Qu6LUOdRduj0dLMhdTKWuMd8RFnhEWt?=
 =?us-ascii?Q?tY0cRCyDknsWg7zopBGkTnO2LATjY0UFTMWPlicxmjnlDrsaznDKk9BabGOi?=
 =?us-ascii?Q?NnjBRN6sgEzUB7dNdhBC1TFjKKBNkmhtxYb2YLUmwKLR9C8JmqZuOAprhY9C?=
 =?us-ascii?Q?9xSmAEo74ezvnP5kuDbG4leFiJkPQethXqADVj2SlbKONo5B4d5rKP4zul/T?=
 =?us-ascii?Q?Ayrkn417NWEvOuANshdIQDJiUKSZRYSx/qtmvMd2CuNpv/jTNrHDeAtLsskv?=
 =?us-ascii?Q?g7Pm7LOiKdscfUJovU6mwX1uxjnEA+BVjhzVeIAaUDk9BQC+s/yv1BVzr2ty?=
 =?us-ascii?Q?xiAGbCUnSfe/eWtwbIdGG4dhXa42YXQOVprAyAjmJMLJN7cdy8eJEHHBI4Zy?=
 =?us-ascii?Q?foiOioLbdkyA40T9F9QqlP4WU+Z7b3dyjcWzMjZHJmk8ekLe3U156czHXo4W?=
 =?us-ascii?Q?orViRcIpk1rx1t3BCIVw8vApjxYjf/ZdUprgi/M9URf0QL7lDzDH6ClBZv3v?=
 =?us-ascii?Q?mduMbFSBpY2f2KwgahI0YvPwWG1BtgBMRSIBpWxsuJHl/hdeC+GHgWD7P/fv?=
 =?us-ascii?Q?8FzCg1aypiqPfEq8VQwUk7Cz8Zelkbb43sSzrf2ELBoOpSVTE2pRY8tfXpp1?=
 =?us-ascii?Q?bKv4aRIEmM5gWevJYXxBmnccxjYaw7w0TPnjx6fDqc9/l74aHC3u3rV32TpA?=
 =?us-ascii?Q?HUia3h8yniqSNPdRWuMQtszD5tGwKkZxPnaCTPWJS6gDSRF2eG2z7C0WrPT/?=
 =?us-ascii?Q?f2FIr1DXdfuDGCbHcDsgLgx27dUU7faL3redV9fbbr5GBdrgliprFw1pPjiL?=
 =?us-ascii?Q?Ki9xV9Q/vNkk0aoSWMZxIaBaAsUJhzZ/+bf4wjEs7RbvjZiEC42ZwBI+YtsN?=
 =?us-ascii?Q?lB9pM+i5iy7gJB2dmGfOuaoHAJAHlYnnnMzYWrI6/BpSMqMtBhSwTlnlEcYF?=
 =?us-ascii?Q?k8My4WfzATqs9NzgT+wEeqm5VbslcJraY01lA9gz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ba5259-fbbe-4f3d-f257-08dbd9afbec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 01:21:44.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7u/hYxdtc5ThIFsWLZasfo+dGuQD5aFDK/XU3mYJbIZSeaWD95WBFwc4X/baSdCZREsPenkDYDcMd9VAy/zRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


> Subject: Re: Security Fix Backport: Intel RDMA driver
>=20
> On Mon, Oct 30, 2023 at 04:47:01PM +0000, Saleem, Shiraz wrote:
> > Hi,
> >
> > There was a security bug fix recently made to the Intel RDMA driver (ir=
dma) that
> has made to mainline.
> >
> > https://github.com/torvalds/linux/commit/bb6d73d9add68ad270888db327514
> > 384dfa44958
> > subject: RDMA/irdma: Prevent zero-length STAG registration
> > commit-id: bb6d73d9add68ad270888db327514384dfa44958
> >
> > This problem in theory is possible in i40iw as well. i40iw is replaced =
with irdma
> upstream since 5.14.
> >
> > However, i40iw is still part of LTS 4.14.x, 4.19.x, 5.4.x, and 5.10. Si=
nce it is a
> security fix, I am thinking its reasonable we backport it to i40iw too fo=
r these
> kernels. The patch would need some adjustments and I can do this if requi=
red.
>=20
> If you feel it is needed, yes, please do the needed backport and submit i=
t here.
>=20

OK. Thanks!

