Return-Path: <stable+bounces-16428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C92840B36
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC93281F31
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A282155A5B;
	Mon, 29 Jan 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T42mkHA4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D7155315
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545305; cv=fail; b=jaHSYoFqUb6ZvtopxdRz8QkcJuizgn1UdKnhJtSaiQqAQiQH9DIDN0XEPtkFoekJE/A/tlDAQ5gwvwXb5buTL4rRHItmVXAvQqmQ9vz57AYS8a5xriqJ1FwQvXe7dVq5o+eMSnyxuWOEJAPv/ljmAY4Lb4+Z5qQaFYPRZBLhWrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545305; c=relaxed/simple;
	bh=BDuOOBchwyxcXhIfoKX7a1MynVpTbupV0COkwy5NHd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jIBQDxiULChLKyl1KGWBODagLixFEogoilTvEKHDkmKdTYvmcCVeH/EujWrOhFFdGwFCcTFMjaag0DpuYyRPc0OXut0E6AHJkEfjuySwpn6PnwkDCysSU8f7P0/wAsjBKYz1bNeC1LVAhrlhL7pag/tbbJSVsYyr16WduAmFWFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T42mkHA4; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706545303; x=1738081303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BDuOOBchwyxcXhIfoKX7a1MynVpTbupV0COkwy5NHd4=;
  b=T42mkHA4/UmG75cUKvPN8LcUb3knYGpj2G5t/hoCaY4JwEQ6aoKe6Mva
   /10i7Y3X8wDzA/693ZwEuWOGuWpq40fRUsXRilifam4HndcH5y8ozkyic
   NympAA1C0nZ0sQjM50qcF5JV48ctFf0fq+S9fTlqR0I5x9+lmZoAaNT8O
   YpeB0JuoB0vLOJd63ew9oSmvMaeDjHkdHkWKJDxNTly9iK/6vKFOkIK0r
   FWlTZxxTCOu08EvjOOTDPcoULpJgoonjwNVhH4OrFKXiNXRFTKYcWkyYg
   euswCRzGCsS3oJCm5O85mc9N7vqlt42phGBd3zgxZsyO+zNYJaZTXgGtx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="401863834"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="401863834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="960937370"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960937370"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 08:21:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 08:21:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 08:21:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 08:21:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPV9DIn+FZZFikglDD3AqK9VNMMmH9FeUu8LDeqNYDw9G1+ZWS7Jt8A4qisfC16ZTRnJ3OXcpba84im1gqzZ5SKgVanzEB9HYy3d0KlQjDqO5gur3Es3G9ZVnzzoOdR/fsLMWLmWbbUIV6/s5ysBEe3NJaDL6QLKv0hWkC5xS3hgrFAR3BqXGsC8YHHtgOzhGYdBPMRp7165gTXIhZlCL2AcX3SN0JncMORGxMh2RK64eSznlSJbQvysLBOr/+HxHENcL9PK+LRdycYt6x8MeiFKZBbgX+Ip6LG42oiL3dCHUuJanrvi+9PNSWwA3X+lXwpX95KVH6rViGwRR5LhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJFAMnPBvUe2xeKRVuuJdINAmjKPS9Jo58pQQK3SayE=;
 b=fwuKioDGEVq0P4arR5EZdxxWEXFDOd5tdh9OYp1O+eZmJqKWPLaZ+A5TNVbS7Xzz1PEsun7YQhIw9FmJCmE27H8ZB6bsWXyD4Oz1uyFtg8ULDsBv4qSZ67jUNvU88O5PKgzn1AH2lCMotDilAAQafsA9yWPZFlQrtwww2eIqoYRujd3v517WI8TsYfECIr+vVo4qQ2D9L5C8VtkELE8uB1hi78S3qWxsmHFeHIUkkfTif8laDL/2L8/KG0Xgp6X4POixQQPCjyqmlrgYtAQfuH2DvVvB3lvqj6Pv/F/nYT9Tk37CmMIN6rFhFzjjoj06DSriatjcgJWjo2orF2sFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:21:35 +0000
Received: from IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::21e3:7c71:f67a:683f]) by IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::21e3:7c71:f67a:683f%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:21:35 +0000
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Marciniszyn, Mike"
	<mike.marciniszyn@intel.com>
Subject: RE: [PATCH 5.15.x] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Topic: [PATCH 5.15.x] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Index: AQHaUJVQVBWP58jhi06U9+93ptAnvLDs3wsAgAQdK5A=
Date: Mon, 29 Jan 2024 16:21:35 +0000
Message-ID: <IA1PR11MB73173AFC2413EC7E2A80B553E97E2@IA1PR11MB7317.namprd11.prod.outlook.com>
References: <20240126202144.323-1-shiraz.saleem@intel.com>
 <2024012630-animating-patriarch-6f6d@gregkh>
In-Reply-To: <2024012630-animating-patriarch-6f6d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7317:EE_|DM4PR11MB7351:EE_
x-ms-office365-filtering-correlation-id: ef03dcc1-0f75-41c1-1115-08dc20e65cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJRE/mASZinVjqe1mrkcPqp8OoEPw+cyULSH4sVwhMVqoBmFb+86bO5KvDhj4WO6IJYjeFPc+Po/Wylgey2BGORU2VNVWPN+EPn5zCVlrGLvnSbI/xpeBI+aIUf7DWd1SUkgdRyl/nHFyVYn+TrxMegptJpXPRlbgQ88VarSyNqlJaPy4f2oF3bKELbZqoZnH3YRyIAlgtWFsJZmJTXp1YP6rsZAm7IORdBiOwFdxW+ScMFT/ase/2VFNFAnNrtXV+6W5De8+YeSS7O5934aLso1ig/392XEzdQBxa9YqhV9Evw6PRT/kU1JVG80noVwlyK6wDG2KDfM4KvRcM9uh86U+/IswwNowgulPsOZZombMq8FFbyxFbujgM3BjNkiA6qdCSjwOPyHkQRlS6xoxcFqwFrrRRIiNa3ANciOQmXJY9TChPpDX1eJ0j02mdxRSSpPtBZuoYgoRwS/2+tWHG2snCEOgH5wLhWGKGTBNCj0N2ApDfcFt1S6Ot83WClBj8FPdS77otKq9UkWAcXC3hFfwCUVUC24cIMAQD6+R6w9ksI+ZF4cPRBYS4rOnl51IHgr2bsawUPIZsRDiA2mVtygECPOAxBTGp6hx+YzsEQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7317.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(33656002)(86362001)(82960400001)(38070700009)(122000001)(38100700002)(26005)(107886003)(9686003)(7696005)(66446008)(66556008)(6916009)(6506007)(2906002)(966005)(8676002)(478600001)(76116006)(52536014)(316002)(71200400001)(54906003)(64756008)(66946007)(66476007)(41300700001)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+p9ZNUTgjuEYwyl5SL6bFV4iGocTupg33CWrrEaYRM2VrXlp1Yh5zeMNJSB?=
 =?us-ascii?Q?AvNxMkbcq9ecwGyIFqGkkMq4KXlTIom4CAe/8uNh/lb1daxkuM8VIxQWbNUf?=
 =?us-ascii?Q?+GCR3lTI52mo33DfYO6THv3yw0XHGDWr2WqeragFZWLTGcd2+GYIjyMhPKTT?=
 =?us-ascii?Q?W1jI06qPr3Sex/4xd53qFgQMAP9Coc/YTa1Ol9YrCKETzGDRNd4zK6wnp+Re?=
 =?us-ascii?Q?CRc8Hiy5+gDK/4bphbWVXnwLjDyNOKQENM9DlgU3AQjTSS7Mr8/9uWXBqoyZ?=
 =?us-ascii?Q?K+cCwugpr+MC8uI0MUyj5TT9M/HV2x9O1wL3bcMOrr3gFc7dZ2eh41RTzjy9?=
 =?us-ascii?Q?msoWYsba25JYP7F46gzgYBxaNhBxj2uZl0/1AtFeLkOTEhY6wOjbyPk9yPi4?=
 =?us-ascii?Q?BS/3CYfg4bzdZz3QY58euP2loRGmbNg674ci+9ssz+7TJGUAbYjw1X5XXudo?=
 =?us-ascii?Q?D0lrZsoE1cmLvpP0qF4WdncuBybmqZKuRlmSSgGIshYyO5O9yOqafNJNtWyh?=
 =?us-ascii?Q?gypC+xI13GRpJQjlO2gv3epNtRemd2YoavwBYsmWqRjtMM73wnqj57K6r6xZ?=
 =?us-ascii?Q?ti2d7IwlYG3Exl78CpeRA+Zfa7QUW/CzPQhL+b8scW5GiBscQlloUQsZzJxl?=
 =?us-ascii?Q?RmJY1R/LTQpoNxxK49kIlxALzYN1enfZ2ZaxGjntjIkNsnEZvtpW25QDlAUh?=
 =?us-ascii?Q?n0o2E5msipSs0k8qfbZurNaj5Z7ElnmVRzgQdd+aaDWOgBRwX3CXA7j3oDeA?=
 =?us-ascii?Q?1wesX578sSn8t6Qdm3svqSgCqLEqIGy80R5nulrFD1nBMEPKgMVFdVagYhvy?=
 =?us-ascii?Q?TbKjCAFCDC241lfUG5RX7f4yfLmJ95uEbS5KPNgJLSabyfnGL6JRW7TecEZ8?=
 =?us-ascii?Q?aGehkxPGePDGn7OkBDJULy43zUXR+X4oUfdoFs2Jla7pEN9YaBqzs04VYo8n?=
 =?us-ascii?Q?5aNK8Cal5DzZVZTRAtwWSVQi4DnBl8YnVBwh7yjyiPEUYcGmMIAdnGD7anJQ?=
 =?us-ascii?Q?R+MeRE3WgkzFYNg9t4b+p4fErnImqTOxOAyVUW/k0/vbfu9o9VyZptk2hRQW?=
 =?us-ascii?Q?pm1fm5r0W0j7dIxpcx/wBfYA5YmxYgN8IZwRt5rYoyRw7rQruMND/iM+AMlu?=
 =?us-ascii?Q?VE+vX4FGHuI4wrVKFENVD1IkkH56PTxMTbJPuNCYNuYnq2FICc+GznHy205Z?=
 =?us-ascii?Q?8/a3jguuCvBtkgsRQRIj0wilyK6SOJmLicsD2jHFa3YJo+sPlzOWmAVLryW0?=
 =?us-ascii?Q?UESDsRAFrwMgRfImzuT5gRz9RjNbxtQtuwGtQ0/mg/B/SwkQ6Kfujcm4efW4?=
 =?us-ascii?Q?6y3RgCjmZeumpGEvdxT6cX2MFwhlQc6hwQOKKS6qMoPXvciK0WkI4JzFomD2?=
 =?us-ascii?Q?XNcE5YUo3Oowx1yp8D/HTtwSpZ/wmR6V+RExtwpT+wZJkjS4rqVQVlrl2oUq?=
 =?us-ascii?Q?yWrkaf9vPsBvQRuJSycg7V7ild3u6vp1f9RDOB2DjFQJGQKD3t6JwczBMzM6?=
 =?us-ascii?Q?TRRxDPVqEFw33P0+CDCurPOXyCiIP7LR3rrN9YEU6mG6in2qULJPtl9OQfEo?=
 =?us-ascii?Q?mmxcrO4mnH/jGGoe/4QJUWxebSuMPb1/KlrJHC/Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7317.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef03dcc1-0f75-41c1-1115-08dc20e65cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:21:35.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEFNesmg6MOJYiIG9hin68D6NBASUk+m9pbU9SRtbsBijbmh3U4nvZeP+3uLWNjYxiAEtPy/4d2dsWbwe3WRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

> Subject: Re: [PATCH 5.15.x] RDMA/irdma: Ensure iWarp QP queue memory is O=
S
> paged aligned
>=20
> On Fri, Jan 26, 2024 at 02:21:43PM -0600, Shiraz Saleem wrote:
> > From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> >
> > [ Upstream commit 0a5ec366de7e94192669ba08de6ed336607fd282 ]
> >
> > The SQ is shared for between kernel and used by storing the kernel
> > page pointer and passing that to a kmap_atomic().
> >
> > This then requires that the alignment is PAGE_SIZE aligned.
> >
> > Fix by adding an iWarp specific alignment check.
> >
> > The patch needed to be reworked because the separate routines present
> > upstream are not there in older irdma drivers.
> >
> > Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into
> > irdma_reg_user_mr_type_qp")
> > Link:
> > https://lore.kernel.org/r/20231129202143.1434-3-shiraz.saleem@intel.co
> > m
> > Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/infiniband/hw/irdma/verbs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/irdma/verbs.c
> > b/drivers/infiniband/hw/irdma/verbs.c
> > index 745712e1d7de..e02f541430ad 100644
> > --- a/drivers/infiniband/hw/irdma/verbs.c
> > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > @@ -2783,6 +2783,11 @@ static struct ib_mr *irdma_reg_user_mr(struct
> > ib_pd *pd, u64 start, u64 len,
> >
> >  	switch (req.reg_type) {
> >  	case IRDMA_MEMREG_TYPE_QP:
> > +		/* iWarp: Catch page not starting on OS page boundary */
> > +		if (!rdma_protocol_roce(&iwdev->ibdev, 1) &&
> > +		    ib_umem_offset(iwmr->region))
> > +			return -EINVAL;
> > +
> >  		total =3D req.sq_pages + req.rq_pages + shadow_pgcnt;
> >  		if (total > iwmr->page_cnt) {
> >  			err =3D -EINVAL;
> > --
> > 1.8.3.1
> >
> >
>=20
> You obviously did not test this change, as it fails to build, so why ask =
for it to be
> backported?  I've dropped all of these now from both 6.1.y and 5.15.y, pl=
ease be
> more careful in the future.

I apologize for the oversight. we prematurely submitted.

>=20
> thanks,
>=20
> greg k-h

