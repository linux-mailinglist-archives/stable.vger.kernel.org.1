Return-Path: <stable+bounces-203048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CACCEA86
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 07:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 054BE30257F8
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A929BD8E;
	Fri, 19 Dec 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUVi2Lsu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8422F772
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766126217; cv=fail; b=Y6OEADxccMKesFi3vqfjam2BIT1TuD1O3azwdAKFAHD3fSiwP11efAmEX1N6W72K5LPsyTj/PcVNWqenw14wcrYyUf8dkYDl5qTjX39RzGWYGottUemyvVBBGey+U29Bxv/wYEAt+TqT6TINdcImBxbP2VG1N6DPG/KOYjIlv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766126217; c=relaxed/simple;
	bh=Q1WIEcxXPZtRJILX3OVYy0oGMgQCHUlzFUOZvtYlzlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvTMn5mpNI4oz/FW8ujKdXtMbSpwHdNXB0hVoRSmOLW1HI5T4zm71UI1Sb8o+n6KUVE5Eo48pmov4WUvcxKGvoXVI8NLkGiIHlaMUQ1hpEDZQ7K39epj7/A4nh+A+WO5liLKDZBsCTQ90kubQbFf8l2BLzg5dvUKyaSVEYOsmVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUVi2Lsu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766126215; x=1797662215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q1WIEcxXPZtRJILX3OVYy0oGMgQCHUlzFUOZvtYlzlk=;
  b=GUVi2Lsus7XVVwEhqWddBPpnV+nSh+MsOBrDaOG2w6m/5ln6itcqfoeT
   hJCq3kXpTlC613/k3U8ZFvMSDWh5CzHLGmcwkFbdEl4zwLU8CWN7ZCBNF
   yTmVr5PSHBPix9sirxNN9zziYFnME341nt981He1RZE3lEIboGeP58pIO
   OgbYQLEXOpj1/y0M/bqnqbpjkhNYvexK+iMZrqZlCCkmQSdmpwrfIATtX
   eRUB3rsfBhZnuVTu7f1uz0x5TXvwyfkrTt1x54+z0+rapAKa3o7cUeYTa
   QcJsMGEfmY4+Vu/qKyE5koYpc6Gq1rxU5ko9c0US6pLAqk0PqE2jbLzzN
   w==;
X-CSE-ConnectionGUID: P5/3MtMdSv6E7f692+032Q==
X-CSE-MsgGUID: t7ngnRcsSEWRji1DeX9MNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68162153"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="68162153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 22:36:55 -0800
X-CSE-ConnectionGUID: 2DRT33D1R8GkgxFee+yJrg==
X-CSE-MsgGUID: 62RcWsyHSMCgSGZxmamoDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="203877252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 22:36:54 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 22:36:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 22:36:53 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 22:36:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlZrK2oESXUu3f5dbm4nobbZ8zgJITPBT/UiZgr5k1Izp+HVA6q2sVtMIVPwT6Nb3Fcakk5iySXVWkBjN8tOaJklWao3YxWUZASaLYgvSr69Xqc4KQuAIJzavNpwkAsYRAkL5fZ4e/S/27OzW6Qy8cnIDf5fIxfTqSWAOapyy9E4o58GgOHsXJ2PWS4HTaUyFi0B9ekv8LZu2cs00ZkNQLzAWH2dJQnxeuFoemTc7on5E2SCM9DxA1pxpGk2NRkUjrBtMkiWpRCFHldixHuE5sEuLyXS+coSWvN2FcTLvUUjSBgVs3LKqS7Zl/Vo5FLl+TbcKXL2o6AvdZwwY8HwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjgoy1KMYfp93J87JTJrPXpDpujSvnT70VeuGQ/SddA=;
 b=Uyf+RRNp66R9n335Ht446wn8FtlIo0NKPDUVY0gYZGbjc0NnkzxbUZeRCSYq+PHIpMMQVyP3X+bEko5W2ZTIdhaQYnbmRbdM3vhLelzhaydJImd3EnvxAtHdME0fUggm1dsMbIDLcrDDfn17k2HF/Ms0hPqg2KJkCB4AdHQv3rAdxSUfNCL46s7QrfwZSVDfRemDp78fJJHJub2ahAcEF7qw2rd8sgwAx6UrCkCeyNfSyIAu9OkF5mBKrdYe5Wj7QJZlxdz2bIpTVr4bPgsqNMBTGgh6lJ1YRhq3yWDWkFQmS+LaHqNDJ861RkjeTgVtm3jmqxNokb03nsklfMBlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10)
 by DM3PPFB0F355549.namprd11.prod.outlook.com (2603:10b6:f:fc00::f45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 06:36:47 +0000
Received: from PH0PR11MB5579.namprd11.prod.outlook.com
 ([fe80::8169:b373:c3c8:e26e]) by PH0PR11MB5579.namprd11.prod.outlook.com
 ([fe80::8169:b373:c3c8:e26e%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 06:36:46 +0000
From: "Zhang, Carl" <carl.zhang@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>, "Auld, Matthew"
	<matthew.auld@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"Souza, Jose" <jose.souza@intel.com>, "Mrozek, Michal"
	<michal.mrozek@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Topic: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Thread-Index: AQHcWiF58QQ47g2Oe0+RShFUhZp/HbT7sh2AgAYp0YCAJi0CAIAApZDA
Date: Fri, 19 Dec 2025 06:36:46 +0000
Message-ID: <PH0PR11MB55798387B824D4101E19545E87A9A@PH0PR11MB5579.namprd11.prod.outlook.com>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
 <fh6dgogrt3ibrod7qkguejy4bj3cmvlbnxksmedhvfx3ejglk2@nu3h6doh7sdx>
 <cc27ae58-b579-4332-9653-c62b38f32add@intel.com>
 <aURm1LgtNPYNxRCP@lstrano-desk.jf.intel.com>
In-Reply-To: <aURm1LgtNPYNxRCP@lstrano-desk.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5579:EE_|DM3PPFB0F355549:EE_
x-ms-office365-filtering-correlation-id: 0b4180d6-e15d-4700-6785-08de3ec8fb8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yjbWFMrtb0AT97wRoMH7nhHYL3SBB4NDb+/WflRrSZl5rINouiRtz30a0a?=
 =?iso-8859-1?Q?EbF6vQvN1E3KnXqXqSxj/lxM9riTSxCp9t5cARyu8FDTs5bcYIXKSzQdjJ?=
 =?iso-8859-1?Q?vZ0cv3+JHU1ofv/SgwXQftEyy3RHWjR/H1cMinaKnVtjZiuSEpBTPVEDh5?=
 =?iso-8859-1?Q?FwNQsbqPTU/Lh8c/dxrztTCuvtrxJwP7YVmclVwvQ1bWe7uUiMI85SrFxL?=
 =?iso-8859-1?Q?SL1TYUzqas2z13XJgobgxGWU3fV7swPiNQu9jek8tGVH9fiZkRTFZrSWl1?=
 =?iso-8859-1?Q?kQGbUXEA4kgRz86U1e7w3bMIjmhU3EgEbmIl9DzMhk8dq2ExMrDLbJBCTT?=
 =?iso-8859-1?Q?UsejWrgK8TzRBbBDfUla3SqzIZp5yp26Xc4CLtzTAhYtG3kgI9prz3iDP4?=
 =?iso-8859-1?Q?EM/QQcEIMJB6FL/8JM/1UWrqLDRXE6JlCR8UEWWIuHg0CDfN0xU9ft6QdV?=
 =?iso-8859-1?Q?HsoQP5nmE+HsKAiTwDi+Nrd3XxkMtVc395NwZ5hLSN24dJHr55rrLvLSp4?=
 =?iso-8859-1?Q?IF/auyCjo9xkKc5tS9Q7cfiZI03LS2obu+dLeja1orxRhCzSMO6NMC+94S?=
 =?iso-8859-1?Q?/eerP46lTaAcosknldqahj0JOQDe6iRJn4ncuLUW26mu4qzt2rqxbUgwFx?=
 =?iso-8859-1?Q?Cdu+yFs2SAFWHTpo+RLEHpn5yXR+XpNVMXDDxfeQgFT0aZzRoaRyjm0POU?=
 =?iso-8859-1?Q?Xms7FRIqTJOsl6qdriKan8vDGMt/eJMHwAm2SLUvGFHG5rFrKgVhqf+Nnf?=
 =?iso-8859-1?Q?1Qj6Yt1HbK6cu235nMxQfW6hteUOspEn1gov/JQqIPujk2Q663S/AzESWr?=
 =?iso-8859-1?Q?PjwpoOLkVhtvmvcU9IyPnAzvvh1jRMgSHr8mLd67Z1hk8vbltd+zVhcJnz?=
 =?iso-8859-1?Q?sGRGX+XlYTRNUzV5Rzy76fv/HMCP3+r3sL1rwm+H8hZhcuPrI5twCDBYtF?=
 =?iso-8859-1?Q?FM6Wq2/FgXU4NgNEYkVNh0lmw9PI0QizG8kNKIX002nL38IZC2JSEK5gCz?=
 =?iso-8859-1?Q?r9ZyIkeZlfH/47FN8SwVtj89rMqqgG3/8aa1w75DUuyUbR5xNXqIDiHgEJ?=
 =?iso-8859-1?Q?8505IWYU9H7oHzpIr8J2X0CTz8doiySGyyH8Seq3TfWXKsJf8hWJ5zzhhK?=
 =?iso-8859-1?Q?5Kpe37C0HjDHDy0i8AoI7KjX2b3mKkaruuTXqD+Yu7LnRXYN3vzkz833Ws?=
 =?iso-8859-1?Q?d3Ek2IdwLhcsSLNHyTiBrIQqcCtws1rejRKvwT9cVIbLKkW7yNuYkHpsga?=
 =?iso-8859-1?Q?hnrmJumjM+R/t3if3lEsCj2Tf4Qpja350wSVLJqSnrzVu6lRxp6R1P9UCO?=
 =?iso-8859-1?Q?qYLXF8eBRvkXIzYnX1/ZbEob1T/IE4TA2hw29xt+lP2ojVAm+11wAaSsLy?=
 =?iso-8859-1?Q?2VQd/4a4iWmQyj8Jw2jm/Z7efhr/qHpGk/MCCGGs4oAoIUx8czQHsOc9L1?=
 =?iso-8859-1?Q?zrlHji86ZhFMS9Oyz9FWMh8zEixPKpcVrHqeKrGYrf4COy61OOqYppzwY/?=
 =?iso-8859-1?Q?s3XCkJvf5Oalt1qSEqWatb47Ng0V7fgNBM03iVhN2fWaYWY+TH0N6KvspQ?=
 =?iso-8859-1?Q?5uUJ/dKQq7Hvxh5BZeMUg5g17YZX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d61e+HjsMOTqJEDqgdCfRy5FB3IjrvMYPIiYmRcVhncWBpkDimOvHMlVbS?=
 =?iso-8859-1?Q?bYFq+Yr9v/IiGrQ7hIIymjD/jFgkBwH1QrxzUY9cJlFA9B6mca0P5b21MK?=
 =?iso-8859-1?Q?w7u+NS5RrI3imc+2BVTA0wC6NTKScPRdSEltT7u16UkCqCU3LDCJ37+fH6?=
 =?iso-8859-1?Q?jJOYhI7SznP1J+8EiMkFKPgSrHy1IgxCy0sunTX3PVUSIcxYxfeuv+9T3m?=
 =?iso-8859-1?Q?YwajZlFxMCWtxeRPCkLY7sOMfoD0Suuf1e2Cy3mgIkE6MdQc/RZrB6mhYj?=
 =?iso-8859-1?Q?MzkVX+OsSxJO0H1YvuOwsH+XwNC5IECbrJavRQ16P9sZf9kzT8VNpBrE+s?=
 =?iso-8859-1?Q?BjOYevDUo10Ply00YisVehfwHeLRkEQOywElZ7usrRC6jH986TyJMl6WOU?=
 =?iso-8859-1?Q?kRe5D/fdZUrfiolrKE0WRHvqK3fMiDiKPHN1pQ8JbE/nQ0JEuA3fem8cgn?=
 =?iso-8859-1?Q?1vIPxrp598UAf1t1MV+vx9wXx+eW1uJmjsHp2pik/zC2Nr9WLcihqVngBw?=
 =?iso-8859-1?Q?nfd3FSjhCo14wpcHJ/5i5r5akZecrcoMEtU86YbitLlgdALBpMH1I9ihS2?=
 =?iso-8859-1?Q?w2HHBDGHmBm7PJUBduW9NoDkp7+5HW0nzr4As6PvKeQ9g1X5r9ojygq5oD?=
 =?iso-8859-1?Q?k/4hiX6/Ct+zuBSttAnrDX5HI2KyuHapO7IJXJtfkL/VLwh7iVyQY/08TW?=
 =?iso-8859-1?Q?BAkMtHWGXOLgej14lQPOS9M6IqMw/IsIGz52wyBVBjHU0r2d+ktqzKdfSI?=
 =?iso-8859-1?Q?d3xwpLa/zmR5OpLEn4zvDg1/i7A/uXpQWmjc7CP7iG/uUXwj8lQEexbTVg?=
 =?iso-8859-1?Q?IeX7A8jRzDNj+qyaczxl6aYYqdA5AFti++xP0weeYEwXz40k5IJlo8iJ3o?=
 =?iso-8859-1?Q?8jO54qRoJZTBKyCIdyrNmZI6TE2OECm0RLciF2uBu3wbYABQT1opEMm/EN?=
 =?iso-8859-1?Q?02qetDP2W9RmdOL1cMrFoDTIPDXBY9qkZ6cw3FajWEuDDeWFmy75o0M/FN?=
 =?iso-8859-1?Q?REehwm2ttk+j+1MI1LT8pBpn39/n9ilItJ3It+BfyDFmk+JCnxJL/YVYqy?=
 =?iso-8859-1?Q?Lwq0btzJhxFTgimccXhDH9pO7TfEu1N7FAtt9LWEfhsz8iByp/hTk3X7Sb?=
 =?iso-8859-1?Q?XlKlYcxvBY23xTO31pxAmBTftxQEq38Njrkq08K//DA8VUGfg29pSCZYj1?=
 =?iso-8859-1?Q?8Avf5ya/juLfNIzM8X8eQUpPzJnrrm9yCoFIyegXSo4B46LwJ/dhfSr9z2?=
 =?iso-8859-1?Q?Kfv0QBv8sFPz5XMpaVts0XL8iy/i42mLKEt/CkLH0TwkjywnJUvI/AkVwe?=
 =?iso-8859-1?Q?UfcX66QR+X+yd6IikxJlJg7G1Hx0u/ASVdCEfdDhoKx3ydHKNmZiPmwsJN?=
 =?iso-8859-1?Q?hyahwulyPW+HNlweWMRfqWibFKOLf4w/1NIAsK18+6LUXNkmnaN4ipiN38?=
 =?iso-8859-1?Q?CZev48hx4+i3IlV0Q5cyzLqwovB8bwyndf6u3YK2lz/2isgYtcwTxWlR8s?=
 =?iso-8859-1?Q?IrHaS7TPQYfV9VYJ2nyj9xHpuNBlRfEqJI+ffl9i8phOGNT/7RNk9owQUn?=
 =?iso-8859-1?Q?PZJYjWQujWLCYWaP5mHzqBYMA/2nbCzyAUsRvFTEEVjadQ3ZQHrG+XH/Ul?=
 =?iso-8859-1?Q?kDTU8WZt64NFrkiI4f288r330OFGQGy8IM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4180d6-e15d-4700-6785-08de3ec8fb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 06:36:46.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XC99F9RoUxA55wHZhIIKsaDIg90mV5XhxWw1+c4+d5SjcfaXBZfuuaM7iUNs1rrjujjTHRenTQqG4IdKu8sdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0F355549
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Brost, Matthew <matthew.brost@intel.com>
> Sent: Friday, December 19, 2025 4:41 AM
> To: Auld, Matthew <matthew.auld@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>; intel-
> xe@lists.freedesktop.org; Thomas Hellstr=F6m
> <thomas.hellstrom@linux.intel.com>; Souza, Jose <jose.souza@intel.com>;
> Mrozek, Michal <michal.mrozek@intel.com>; Zhang, Carl
> <carl.zhang@intel.com>; stable@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
>=20
> On Mon, Nov 24, 2025 at 01:41:55PM +0000, Matthew Auld wrote:
> > On 20/11/2025 15:34, Lucas De Marchi wrote:
> > > On Thu, Nov 20, 2025 at 01:27:29PM +0000, Matthew Auld wrote:
> > > > Currently this is very broken if someone attempts to create a bind
> > > > queue and share it across multiple VMs. For example currently we
> > > > assume it is safe to acquire the user VM lock to protect some of
> > > > the bind queue state, but if allow sharing the bind queue with
> > > > multiple VMs then this quickly breaks down.
> > > >
> > > > To fix this reject using a bind queue with any VM that is not the
> > > > same VM that was originally passed when creating the bind queue.
> > > > This a uAPI change, however this was more of an oversight on
> > > > kernel side that we didn't reject this, and expectation is that
> > > > userspace shouldn't be using bind queues in this way, so in theory =
this
> change should go unnoticed.
> > > >
> > > > Based on a patch from Matt Brost.
> > > >
> > > > v2 (Matt B):
> > > > =A0- Hold the vm lock over queue create, to ensure it can't be
> > > > closed as
> > > > =A0=A0 we attach the user_vm to the queue.
> > > > =A0- Make sure we actually check for NULL user_vm in destruction pa=
th.
> > > > v3:
> > > > =A0- Fix error path handling.
> > > >
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > > > GPUs")
> > > > Reported-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Jos=E9 Roberto de Souza <jose.souza@intel.com>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Michal Mrozek <michal.mrozek@intel.com>
> > > > Cc: Carl Zhang <carl.zhang@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > >
> > > we never had any platform officially supported back in 6.8. Let's
> > > make it 6.12 to avoid useless backporting work.
> > >
> > > > Acked-by: Jos=E9 Roberto de Souza <jose.souza@intel.com>
> > >
> > > Michal / Carl, can you also ack compute/media are ok with this change=
?
> >
I am ok , current media driver only use default 0,  did not create bind exe=
c queue .

> > Ping on this? I did a cursory grep for DRM_XE_ENGINE_CLASS_VM_BIND and
> > found no users in compute-runtime or media-driver in upstream. This
> > change should only be noticeable if you directly use
> > DRM_XE_ENGINE_CLASS_VM_BIND to create a dedicated bind queue, which
> you then pass into vm_bind.
> >
>=20
> Yes, ping? It would be good to get this series in.
>=20
> Matt
>=20
> > >
> > > Lucas De Marchi
> >
Thanks=20
Carl

