Return-Path: <stable+bounces-19467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDF85140B
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CFE1C23763
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2E3A1A2;
	Mon, 12 Feb 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCJxTjYf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AA3C087
	for <stable@vger.kernel.org>; Mon, 12 Feb 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742984; cv=fail; b=D869+fHRHA0sCLtj/9TNuKN2i7OC+9GV+y2jtCUee+mYQp9mOeh7WvFLH/t0eE+nZ7h90IS/kG4LGOsH3VNkqSsxPkFmzO0/GHveFFP49pBYoSuKKecgJUfV5yxUunLG948jSJMHqXA1X2PUy6Yi1SPICx4lw53uJ3AJ6dQxth4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742984; c=relaxed/simple;
	bh=RTtyvoyBuaUGyXsULlpyBNWym+IxrICHOL5xv/Wfzpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAkWXz2GFqPLl3TxaTJnuzaYqp05UESAnyDPw38AaSpy5s7pEyjiPdM4/LfAB5WhV18uozUwjbQWGTm6L48JgM9lKL7cEy+82fHw+3WE9l+YI4esc0tJKcNSGbXsb/B89NvukYKdhnNPhXVNV1uhXggFfXhg2v994nHwbSrT/1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCJxTjYf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742983; x=1739278983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTtyvoyBuaUGyXsULlpyBNWym+IxrICHOL5xv/Wfzpc=;
  b=fCJxTjYfg/wwgFM4ijQWNcX/aD47dHZ+V/LRRMMl40QjNvwzw9aWY2k9
   rezDcv2eX8kOr8pQ8OEhneodBfMXB5M79KhDbgnPLJ7bqsQeNZvPLguD2
   4N8vprOwpJpaGJuDaCgtmFjoWDl3+8/UHSUTLTAzvJ77zNWY4r/3TTRYJ
   qGKHKpwnfkjOz7ZsXx0+taIeM2ZK4ljFulQhTAU2lEbGwSu8ku49QRnKj
   jchjQTZVnDLGJNIWF9jA7Idm9mlG7/P/R+zwLjHAfcp9f4K6vZTMHE1mu
   0lz68TibId1tnJqqXJUwgfmrpY5pGoy1Nl1CYzamkCnCZTsUp5ijiCvgF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13099704"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13099704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911475468"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911475468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 05:03:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 05:03:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 05:03:01 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 05:03:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzruXRqawab7YuXz10hlApJkV4JmQt08NiGv8CUBoCMB8ASH7mtMZ/rOIEaz76qGxpiRz1vBDzgs3p6gnS6HJqDY73dbDWichNrD5WwQzmuo1ontDbQXICzWpOAGoOpmxY50jRLaS1aHXk717nZTWhmCGdQahzP9/gY2xI7zA+dCUFJfQS+foALh7SVq3xvYJKlcg183+heuzlGsJwvH8t8kArVUsR/tsWBkuRqhmVOqO706ZOOH+HYnMiXGIxDRgGW/LK+JIrbuBqUk750dKmn5bUw2fIu4SOUpHGe79BaU7zNy9ET17fEvKrHE4alArpiMNtB+2LcgqkVTGGju+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0KOjMsttwIW0EGrXSrYVsMUKor7vvxxe9XKYxDc9BY=;
 b=Mc3Nw+kDLYwCEOVzzVtZyO5ZaX0s+oe3QTXrqTssliBhvRw9F+dMxwNn3KXkO4HtR8m78uTqzdvcwraxqY3gUpsavwY0w9489s45CEY/6r7Do3791bexcjjk/uz0VO3UzcIRXFWKontkSv0hrmwZjoeGuEvEOfIzQxSHRRQ2c1KUNid+QtqU+Um7X1KsjSiWpWaG83MSErvJRaCyUDMNMGEFoRE7qsT7txd8gcalciFZ0jz38S/OY54YYFp/FvY19XAxKvCwRVzhV6Od4i7NJquh5btQVnDwFFXFF4q8O6mv94qf+tpNW6ncfYB4gtzYhm1utUvmC3wTwHuPrO52Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 13:02:52 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::e3ef:602f:a51f:1b38]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::e3ef:602f:a51f:1b38%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 13:02:52 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Saleem, Shiraz"
	<shiraz.saleem@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Topic: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Thread-Index: AQHaWeNSxGKqsp2klkaONnvqAVC88rEFWkqAgAFZInA=
Date: Mon, 12 Feb 2024 13:02:52 +0000
Message-ID: <SA1PR11MB6895D85EBD4BEFDCEC57AAD286482@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
 <Zcj1JyNJww8njJFv@sashalap>
In-Reply-To: <Zcj1JyNJww8njJFv@sashalap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|PH8PR11MB6708:EE_
x-ms-office365-filtering-correlation-id: 8d713585-3b90-4c0e-d94d-08dc2bcaec34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VoKeGDu9v4T4bZvwv3m7AlLOB0VKcYud5XmohSZuTWa0AXXXN0IW5dp4Lan5Uy1cFNmZX3yMUkl3eDHlHNxt9VreKAxzli778+uPR1/jUVbWG2m0S+FLyHx42sVEBtPVrv+cofH/O7Cxe5NOZMyy7gNBGTpB+AsoSPrInkE9pR6Mfpc/Jtc6zAlwYWLuWARDxOx5q/BlB5aAXox/QKmCcFE4TnhmxR0h7ehxkEYAaz38oX8oEN/L9uPpoEZxzVS4XekLKsJJ2uH2QKsulxro1+QQ5vlmLq2Go2fchUfkjKoM2lNGCsCtq5ghzJz5i6YI98JCbETmvdEaOC21R0uDERmOrRw7zIZDbEd3n/Zhb5FPH5UWClQylHF7YfrYUEVe2nwcQOMpssUcqL8cAD1Qk6gd/1LlAUtlPXlUuST5uMLcm2JB1xBFSzP5ASorScMEd7sAGH5czBljU0ZFv8b2xH2Wt0Zf4RoE+LcZoreo39cJ/txDRqexRMBrJ8l89uZ19jP+YpxrFfKJR+dc3BPVoPvHlkjvh50Kr4PRyNLiCw5voqJQkb/u4NjRDhq3iqKhBnW3039MKCDNrCgWVxErzUZ4HSQ3H2fSyMUMonU3RIkYoRKCD4fnzGqduBQWkh/N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(55016003)(41300700001)(8676002)(8936002)(5660300002)(2906002)(4326008)(52536014)(4744005)(76116006)(66556008)(66446008)(66476007)(9686003)(66946007)(64756008)(38070700009)(82960400001)(316002)(7696005)(6506007)(71200400001)(6636002)(122000001)(26005)(38100700002)(86362001)(110136005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3eLMeEM5qo70fr8Vw3pLyeNx76WqhxE96K6kCNMaWl0sQybjZlQaxcKFPgD9?=
 =?us-ascii?Q?Gl++SrvMfOQyi9dUbKhDlkaQdlzbM8RfOadgBBjI3Y3UqeQ6DOJmMpmikFkn?=
 =?us-ascii?Q?/2P3bYdTEaVc2jD92QyzjUdUTgXqWiwg6N9fPkPkqsr6KTBjR14QmiDnCH6l?=
 =?us-ascii?Q?SM0rmEoXalC+gZ238PNwthx/k+d9GKW58lYvgknxKaS+vZ14nxs3k8DtAQNY?=
 =?us-ascii?Q?MjqU0zbCuaFQ7vWG7FD75CKMpoF+UgHzTuSa3D23byAAUpunjY/bIoA7NWxN?=
 =?us-ascii?Q?YT4isXrtt+aDzI4wnPYCNu1mGiP9GeQCkINT7TKJON0Iu6B3NamYlUUeZAI6?=
 =?us-ascii?Q?T2JO2VVqYkGTbCHxLZaRkbwg8147Tfx0ebuBdL1mjBj0UcW+RTCN+2DnLc9V?=
 =?us-ascii?Q?2/5zHgTgikYgjC5nhra10F90J4OP8HyBO/1cUtKe88t4aqEfLUD8xWnORE8J?=
 =?us-ascii?Q?WrJcceEuBz4rMMtG4g8M8TYrjwUshjE6rNWeV0uxYCrlbIxrvEhnP0eIp+Un?=
 =?us-ascii?Q?b94Tp83uhMcESYZwqRiVF8haS9fmKvE1JAy+r59bgWmkon92NF1a1USrwb3O?=
 =?us-ascii?Q?025SeoBKozUjk5VvwArbWI9dIf+QCBqdddfwIHNsCz1vsGl0vFMvCkZu1Nix?=
 =?us-ascii?Q?mEbEL4fVLoJ+tMtWRQwhZJvn4beu3Zap9WQwBq1LDyBj4YAZCW38/O/iz8RR?=
 =?us-ascii?Q?sFKW9ORsOma+qjh1+MF+iLxZpd0VomShdhKaVMPVfiUCVYcCqx/owYk+RJ8v?=
 =?us-ascii?Q?tpIRGtuZE0/811u/Wg7WbaPkvUii0im4dscyhpRI8mjbWy1S1dU1md+U5lUj?=
 =?us-ascii?Q?vmmN7ksl0oaOw+kMF9PaLC2/3piE8UfmJH9i2PpkNYl8/0oRKhhMJBRGJdQR?=
 =?us-ascii?Q?bJEamZZzmZYLqN0KE9GNFt+Xz+HFrEzkf0QeIdFDQF2kByh5qKp7xVM1eyZh?=
 =?us-ascii?Q?X0sAOr7D0g0qV8S0y8eiqEgxiiheWj/H4WTfkMqHuxOGa+/WnUQXEveEfaCI?=
 =?us-ascii?Q?PQH3RB7FsD1NEN1WXFaDgelPtGjYEg08s0EgUgU1yeHlNpy2PZmftP5jy5Sg?=
 =?us-ascii?Q?QUDnEcW5SZKMRKKBwD3qMjIj71j87nfUhc3obN6MaWPTZYnJMdpOjjr6oCuA?=
 =?us-ascii?Q?8Rkk3mENp/xJbzIvrJ8NNSZElYSuxoZS4qvuhRfPTV2VdqfhPSNONM/eEkvP?=
 =?us-ascii?Q?MOSmRN+n9JZkxvoCzSuS7oVFgL4WZr0zTKpo2hS582Cv+OFKbOtDxkeoAgyW?=
 =?us-ascii?Q?xqpSC4cHR7cWBdi+qecsVPg623iaETgIFhJPZkv/gApOi71vvk2fRPyXgkJq?=
 =?us-ascii?Q?qI4CfyHa5DLcvAfGqYeNnE9wZtEXsSlCjFQ+2DUnGaCKcwLO0IA2YzYmeGsF?=
 =?us-ascii?Q?EzHRd+cX8H69hCpz5zDTcDo0jKnFxX1ZCbM7vvNNHjc+Xm6LmPghM+31xOMc?=
 =?us-ascii?Q?4GAKr0UCeVCFtvMm+w2l/e9dox9LYyP0e2ZoG2ih9k6EjKuPbTN6HU1wFaNm?=
 =?us-ascii?Q?Xt1pITs2/K7BAnlJ6c8MDS7cOl4klpOf/o8+zhqPjyQ7TH05sWrEAvJH1DWg?=
 =?us-ascii?Q?EKkVJd0f6gVNhH5RqH5lp4K+GFNcX0m3QEIYyKgG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d713585-3b90-4c0e-d94d-08dc2bcaec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 13:02:52.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtvFozWrAPmVz3EJoMoW3x88hNs6Aey2BelWtqBccQnd+Ik3IIF9aLW6DjkypukG7tjCTUAw1ehOijh6o4RCQS+ckZCYa03L7j4FvzlbQ5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com

> >Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into
> >irdma_reg_user_mr_type_qp")
>=20
> Is this fixes tag incorrect? there's no e965ef0e7b2c in 6.1.
>=20

The fixes was correct for upstream.   The context change forced the re-port=
 of patch and the Fixes is not appropriate for the older context.

You can drop if you want.

Mike

