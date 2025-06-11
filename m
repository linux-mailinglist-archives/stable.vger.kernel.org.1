Return-Path: <stable+bounces-152417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54037AD55CD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA3B3A20F9
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4F6283CA0;
	Wed, 11 Jun 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq6jc1l5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5569283142;
	Wed, 11 Jun 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645612; cv=fail; b=Gg6UymIbeXyQ2HNae/d4OdT7wdeLB7GQSp+ZNCFmeHCiDpuFghjrc1nQPTHY6NsiNFgR/qzfSLrfEVRbOkSwzXgW58eiARtctXbuqHQ4mz9RAd2LoVcLmFQaA9b7yRxnv3kkIYDePOQWnjzivV78yxawRzJPYYFogVVN9ocrQNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645612; c=relaxed/simple;
	bh=lKgRNJ1+17HH27Ua9tPdh1J5SBYJlxQXiC/XsMByaGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0ORNGwBw2EvMc0W/97PlTKp0lsc/7w93yP5kmcNhd2yA7XRivNgOymG7jzCWSiSLgfqmkhJDafRSkdW4xidSeTq0D1GP+sxVNP+J+WQrXm+7s41cI8KFGkcgkB0tdJB+Q1P9qA4ObB/XxIsQlIhtEMS1yO+k4GmVJ+8sKVkdDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq6jc1l5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749645611; x=1781181611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lKgRNJ1+17HH27Ua9tPdh1J5SBYJlxQXiC/XsMByaGw=;
  b=Dq6jc1l5qh674SBLw1eT3CPWjFctSk2WebPl9GfihyFqvi//8hLXTlZF
   k9ny+u+ZNzK3E//3zm87/5v2bz6zdCizHNemMlCCkar3q7S/dAbn9vzK9
   ELFFYmpxTjcVgwBcKtOUtWtxKRy5uB9gk/yhHgJoUgtVbhq0ot/5GjJUg
   q6SRqAZquudN2paYnn9jkfRRhpE7PWXqmbNCKbBwvRzE/rLbwscdLTpov
   5SomvSt8txb9UOmw24/5RjijIPdT9K0CQFzmRr5TQb/gEN/ohxxYO3+0g
   l8AvGIv6kMzLGC1KZBFe6ica4+pPDLlT5JcypmDsCmJMkf3TecWTffZ/t
   A==;
X-CSE-ConnectionGUID: 4AyVMYWeQ8COY0DXjOSvYQ==
X-CSE-MsgGUID: fEgldIwwS2iO+ufSJM/tfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69227099"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="69227099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:40:10 -0700
X-CSE-ConnectionGUID: Hb7MmiugTRmAP6sCV03KLQ==
X-CSE-MsgGUID: oYzKD6kMScmxKT9iV+zaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="148098088"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:40:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 05:40:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 05:40:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 05:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMrJiDjymanMAif8c1gmOTUNTCviqt3M+nbzUjX98x2etecKNXfTQZHfutLmk6skGkwlsDBysYFl3cIsyevbXds4Jm0TRP9lYX2yYzAJcQKNvBet7/NZF+H4wcJumlY5i8O3gZTJri0CfiwYlgoKc2kB2WG2+1ywcHBzp078zUK2voomJLS480xBKlT2CxllxsJZ8Ud2t2knvbA9L6qfrodO+wUa2gMKRBYOlW5nUNExumWhKYfD52/UiMFTy1cNBGVbygp7jIFg6DHq2zsiafDNq/OEWMUh3NS9eimnMsIm1NoZYBtvCevCtrqPa+5GRBuhcGOkZU6xbcKtTivORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TItFVKCEo2Utku6Jgx7ZIS1xmg13TiXGMGQxp0R4tY=;
 b=KJgnwAyzWBVeLyTxnrXNAbEnWLkxsiqFsEtfd+UJrv5+2IkHpC3J5U0uvxBhbj0PWsVsAeJXZnuoy5QxinbwtlzqIyH7N2KRzcyh1MEvx19shziU/wAnse7fdjt+AGANrMQVRUpKZvyvxIHoEUOto8Zsum+uEnsbZZY89RqHmtIXmeHXAKXcdy8XspHCbCvf1nBdOIgyzAYUjl9tO0800YI30I78tT0dkGhIdU1z+fEW3azu5SryLxSr/8s6Ao9Em0PQkUCDfP9NQqfw6QdvqDgR9DTwI06idJQA9eRGjJryQKsKgVShxbSpgowAXzFglPdeiuAyzo475uH4DdPCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 12:40:05 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 12:40:04 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
	<thomas.hellstrom@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "david.e.box@linux.intel.com"
	<david.e.box@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
Thread-Topic: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
Thread-Index: AQHb2kxqDi72Lx/HN0G3KtJ7+whYzbP9xlwAgAAgpzA=
Date: Wed, 11 Jun 2025 12:40:04 +0000
Message-ID: <IA1PR11MB6418026EFDD6B6EAD882CA95C175A@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20250610211225.1085901-1-michael.j.ruhl@intel.com>
 <20250610211225.1085901-2-michael.j.ruhl@intel.com>
 <e4f3a1e0-5332-212d-6ad0-8a72dcaf554a@linux.intel.com>
In-Reply-To: <e4f3a1e0-5332-212d-6ad0-8a72dcaf554a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|PH3PPF801A91A7D:EE_
x-ms-office365-filtering-correlation-id: cfbf3b88-3cfd-4982-cc60-08dda8e5174e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TYuRUD+Ia2c6I4feCV1lhytt4QYQmGpwx7VXikunjujFkU6NAXaykjaRFC?=
 =?iso-8859-1?Q?rBvdzit7iP61EZ8zM5dYdPle1secKajrlNOaR7x9RZZdrsmczEqFuX3DjD?=
 =?iso-8859-1?Q?KvxpQnUaSL/+bWbOCJE39ziPEgBT+2x01UPFJdqekPg8Z2fq7LzfFfDOa4?=
 =?iso-8859-1?Q?/8DpO1WF9DolhC1s2j7bnCe5pCSqltPp1yq0WQjp4Tvn2JEKnjf/PBWhCU?=
 =?iso-8859-1?Q?UCaiyHUhYHDOTCHZICT+sdWeF1Zb7YvhvUIPbdu/pYm5tGUWP9gAzaed0B?=
 =?iso-8859-1?Q?i8DlN8xswqBGAH85DKR4ruOSoR53DYVsXpLeZe7PFSXSvRoDnSQrHGsT1W?=
 =?iso-8859-1?Q?zE0PArq4DF02q/OfOCguJ5daH/CoVc5GEk2kBKI4FRzvxTATooy0vn6hyt?=
 =?iso-8859-1?Q?8iGRXiEfuA0lurRwdHg9PZH9Mmbn6hcdju2sw7uxCCNazWp4L5hpuAfmJa?=
 =?iso-8859-1?Q?RRCZytq/Sv//pva/EAdz0gLTR80c59lOzMVjcjTXSgUmQDYV11OHgi4TAv?=
 =?iso-8859-1?Q?9kxbM1Kub/3BP8FRsfKckmztGtkeGKN4j4LqQGYUnzgyVOypzvhaT0q6hR?=
 =?iso-8859-1?Q?iT9NEqcwqvwb8omfzHZD/U3fQ+nCejO2IVu37bGXWUoGMfjCWA85jSJibQ?=
 =?iso-8859-1?Q?Og3ctZqrgxeNGmRUmQGgrgqs0ZKR3Bg+ItYE+FsjTN9f4E/lNI+NSzXTlV?=
 =?iso-8859-1?Q?W7fPOKYQMWU9bpHvGNqlONLdISgN4xNax9eVl2emz3P7mxwdJFJKqnFTN0?=
 =?iso-8859-1?Q?eKlCnbNE2kcPgA/BSqfGJUbfzO5kf/Mlm79Cb/uLUDdAeYUpQjjsxACtvg?=
 =?iso-8859-1?Q?4JIH+u8RLSkiL4lzUN8X+RlFsTbp/CI8/1EAUd/Gf12Ss0EXY3bqgT9FaN?=
 =?iso-8859-1?Q?V+c2kaFhFfHYV1zLeFaSglOh9hiNS7gksv3BFgwkFb00RzVy6PzAfeJZra?=
 =?iso-8859-1?Q?p3R7PDUzcWzJOhwwSpfwTDQKcd2xJuxNBWycAMx82QMAQt0hEyR68BXc0p?=
 =?iso-8859-1?Q?9FWyYApab+qGa/9/17y4DztS/QE6fzQbHNHHUBrJNDRFh+kRipvDsqs6xY?=
 =?iso-8859-1?Q?67OEkPFco76XBzQBz5aBA64r4bXA/Iw9GMEwIllr7NbHwiebDFDQ1cCUoG?=
 =?iso-8859-1?Q?5wVoKezAyGxRtrMbEOgiWAywyORfZWkzcKapj1EuFBnFlzNFi9Uhivo6c5?=
 =?iso-8859-1?Q?etLbpik9c4bspm3fXhHKZ2NvCAWq081VS3PJpxmmbCXmIDdYiIlDMVMPCT?=
 =?iso-8859-1?Q?lfrMojhH1MeBRJZ/i2zuYmwcsVZyZSGOsabjXHcfYHmxCC1ctNp7vPle1y?=
 =?iso-8859-1?Q?pM/FU5+Qh9AwlFBbXtulu6aWxrl/pqkh7quLkNJnUSu9PsoC2LIEx2MhEd?=
 =?iso-8859-1?Q?UzFS9w4cnLllCBRIPrWExyJwkki/4KB2p5JkRhvgOFSEuoc1PIMefHYrQP?=
 =?iso-8859-1?Q?eh7CB2VwUhCZ3TehctFnb6M7MP3O865WDpZQ+KNrXC3IVCGRcqY3ZLr6sG?=
 =?iso-8859-1?Q?RD+PK4L/tLbm71HKPQBv47XpqLSXL3chfOPr1USAgJ0EKW9eNRod5r8tij?=
 =?iso-8859-1?Q?lc+48H8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6418.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kW+FZRK717NER21n0Qhm45bz3D1UE+0NttQFC4cbax/Tfk16icOjYqcWf6?=
 =?iso-8859-1?Q?zaNlHoaPZxIRB/SaT7eh/+dI5/POiEShaJ2UZpW/V1miqovvIbNJ9UL19d?=
 =?iso-8859-1?Q?HpmjBXBqpkuCwcF1LUiVHhxba+6ftQqNYhTnvK4YiNaRD2i2OzCIGaav2+?=
 =?iso-8859-1?Q?ozMv7sN+m7+KJGfC1n0C5kLMz+zPRO0K/w/f4pCN2uvZOQTr/9E6h1SX5Y?=
 =?iso-8859-1?Q?ltHbnOTVzh2yCFZW3GQxBsiVrQCeHOuBLouN628Zy9nGP6OmbW30z9PNNP?=
 =?iso-8859-1?Q?xk1v6EDtmKkVVDOcf9S1GUxs9ywfKJjy24ZPAyfkG4nGBdQuMcMDqJ9vsH?=
 =?iso-8859-1?Q?kscVOLcjm6pF4poqNo4H9vMJBae3/KYYF92HnL/ajzaN8CnukDalF8gla3?=
 =?iso-8859-1?Q?kYWG6zWQCrFufU5In4BKzfv2NjcaGLrM7jbuEGSWPbR2FZQ7jZp5mM9Vir?=
 =?iso-8859-1?Q?5mPY4bYZ4737HF85WijVMW5HCnTXh/IedwM6EMUz9cr6r9Fq6KcaCtep5/?=
 =?iso-8859-1?Q?Pm1vbDjWY8chZx1ZIS/0yZdWzE6o9yrHAXGQzQcNT62untl/Y55OMYvcQ0?=
 =?iso-8859-1?Q?5AxIcmwKBussvJMgCbyHfJQ0q9iF57Y28QPN9qUSyhIrvrRyjsU4+bRjJb?=
 =?iso-8859-1?Q?o8BYJrJjesYczroB3Y/ESYCQnYTPYhrLSIzxeLgwZrHSweGf38IVYKzTOJ?=
 =?iso-8859-1?Q?cEhpIYXEfIcjFHJLxqwIitV7WbNTecXBR4eFhACQoM69CzK9m3kG06CJrh?=
 =?iso-8859-1?Q?QXJcojTt+lk26WVOo/9OIFTuvoo6c/ZjMBGu7NsZ7Dv6w4ogHBnYRy4lBz?=
 =?iso-8859-1?Q?38rONggirmgzGMNBfkQZ25aZpJMDHgJbNugYHwRDOvjcSMU+NeBkWhopp2?=
 =?iso-8859-1?Q?YvZTiH8oiKbV6dZRrTASrYPaLgAj41D+EAN7BViq5ne6ixCEulV3oC1zR1?=
 =?iso-8859-1?Q?/aEpJkkFyk5S2Gn5obzuV4P/L6bb7JMqv0uLH/mmCN5NGainU1ItuhewYK?=
 =?iso-8859-1?Q?aRe746eqn0vRv8A52qT9igP2S4KhCJyp+lUaxMcRaPhKhWczSIEIoUewK9?=
 =?iso-8859-1?Q?8h7weC5XNYQolYEiu7VlF0kp2+CFG8nYyzKIPunkQysXYNnmu5KcNdt7Q+?=
 =?iso-8859-1?Q?f86+jixefJdV2KIwrKwOxCt4oMG6uTPoyK237xrCWqbLF5FBaQ/cMB974o?=
 =?iso-8859-1?Q?PI4AsVBTWcC3e/g3LgVEZUZoIhFVea9UHaJxv/C2D/t3wCNWypdZCEY8K6?=
 =?iso-8859-1?Q?cfGTnnj7X73i27Rmo6bXaV/TqJsBfJMInEO7bkBUcjFSd9jwaknJ9nvXKd?=
 =?iso-8859-1?Q?LpK3fr8KiG1QUXi+xokVWMi/X4/7L99eYBSQLsfEq8kJGdGcf3zKkEko4V?=
 =?iso-8859-1?Q?JNoQUI52bdB1CR7D5TGcrwH2XqCEjLxRqo0q3+nZEsGxwAmEuJZ70XAabz?=
 =?iso-8859-1?Q?BRs4tYM/YxpgUqlydWJjIB5zjNc1Z2+avYnEvaw0A5dD/yn1AFUP4Rlwv9?=
 =?iso-8859-1?Q?AxjMv8BOFp9nYjEdk6/TmtG1sRg8jo6zFkhDYHKkF65nYPnbB6xJYgm2pj?=
 =?iso-8859-1?Q?/YbbrUyGtRJWx6xfp7mrZu80SVm1KjtdwmHJehz6MHL1EGgjLPOhNi/R+G?=
 =?iso-8859-1?Q?R5pMcILd073ZhyV8FRu4wsg0oQRU0ONRWL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbf3b88-3cfd-4982-cc60-08dda8e5174e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 12:40:04.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nE3cJA6lgjmXqTX3AHASGdNenVJ8sxOTldxFaxz8rf2eV+Hyq64ZXf/5goRDit9Sg6DYXlhXqcUFypNQeQfMGfBF1LrBAuD2qWy1oWKnUrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>Sent: Wednesday, June 11, 2025 6:42 AM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Cc: platform-driver-x86@vger.kernel.org; intel-xe@lists.freedesktop.org; H=
ans
>de Goede <hdegoede@redhat.com>; De Marchi, Lucas
><lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
>thomas.hellstrom@linux.intel.com; airlied@gmail.com; simona@ffwll.ch;
>david.e.box@linux.intel.com; stable@vger.kernel.org
>Subject: Re: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL
>pointer access
>
>On Tue, 10 Jun 2025, Michael J. Ruhl wrote:
>
>> Usage of the intel_pmt_read() for binary sysfs, requires a pcidev.  The
>> current use of the endpoint value is only valid for telemetry endpoint
>> usage.
>>
>> Without the ep, the crashlog usage causes the following NULL pointer
>> exception:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
>> Code:
>> Call Trace:
>>  <TASK>
>>  ? sysfs_kf_bin_read+0xc0/0xe0
>>  kernfs_fop_read_iter+0xac/0x1a0
>>  vfs_read+0x26d/0x350
>>  ksys_read+0x6b/0xe0
>>  __x64_sys_read+0x1d/0x30
>>  x64_sys_call+0x1bc8/0x1d70
>>  do_syscall_64+0x6d/0x110
>>
>> Augment the inte_pmt_entry to include the pcidev to allow for access to
>
>intel_pmt_entry

I have also been told that should be "intel_pmt_entry()"....  when I redo, =
is that
more correct?

Thanks,

M

>> the pcidev and avoid the NULL pointer exception.
>>
>> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to r=
ead
>telemetry")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> ---
>>  drivers/platform/x86/intel/pmt/class.c | 3 ++-
>>  drivers/platform/x86/intel/pmt/class.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmt/class.c
>b/drivers/platform/x86/intel/pmt/class.c
>> index 7233b654bbad..d046e8752173 100644
>> --- a/drivers/platform/x86/intel/pmt/class.c
>> +++ b/drivers/platform/x86/intel/pmt/class.c
>> @@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj=
,
>>  	if (count > entry->size - off)
>>  		count =3D entry->size - off;
>>
>> -	count =3D pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry-
>>header.guid, buf,
>> +	count =3D pmt_telem_read_mmio(entry->pcidev, entry->cb, entry-
>>header.guid, buf,
>>  				    entry->base, off, count);
>>
>>  	return count;
>> @@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct
>intel_pmt_entry *entry,
>>  		return -EINVAL;
>>  	}
>>
>> +	entry->pcidev =3D pci_dev;
>>  	entry->guid =3D header->guid;
>>  	entry->size =3D header->size;
>>  	entry->cb =3D ivdev->priv_data;
>> diff --git a/drivers/platform/x86/intel/pmt/class.h
>b/drivers/platform/x86/intel/pmt/class.h
>> index b2006d57779d..f6ce80c4e051 100644
>> --- a/drivers/platform/x86/intel/pmt/class.h
>> +++ b/drivers/platform/x86/intel/pmt/class.h
>> @@ -39,6 +39,7 @@ struct intel_pmt_header {
>>
>>  struct intel_pmt_entry {
>>  	struct telem_endpoint	*ep;
>> +	struct pci_dev		*pcidev;
>>  	struct intel_pmt_header	header;
>>  	struct bin_attribute	pmt_bin_attr;
>>  	struct kobject		*kobj;
>>
>
>--
> i.


