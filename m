Return-Path: <stable+bounces-225706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEZUN4FxuGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 22:09:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 635682A0892
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 22:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4AF30305C6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CE33F361;
	Mon, 16 Mar 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmpFstqf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3813B7A3;
	Mon, 16 Mar 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695242; cv=fail; b=nZ3ufcVdh+7lckeTGBhcbvc+tqGEGZGwenJm2E0uLt14gWxuCRt0In6N0/eUl6SvvJEtKaCT9+tb+f9h0rxJhhCR3+Dz2K6ye1IYkhuFdXTo4XKEMrwaQ9xRWcEWAlMHFiXA2JoNz5zaoOBG1YKv4fEOsGosU/rRlQA762pjatc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695242; c=relaxed/simple;
	bh=Vy+3VYFJS+13MdVxF5vET3xihlWE5yZk00O347xPSxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQbwWafwcrWxn7bo1WGttvkR9IMdbpriBd5ZoBl3heJcx0vIGhejgUuF69zKHDyTUZ1JNIHnbPUSViLF+BWWoWz1xjCGKEtLnnPAfXEaYASDxLCm6n4Jmckr/vhoBHRlpBTSImFavWTc+syk4eXc73CUpWJR7k/gICfUdrvKxLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmpFstqf; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773695241; x=1805231241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vy+3VYFJS+13MdVxF5vET3xihlWE5yZk00O347xPSxQ=;
  b=LmpFstqfEdC9g6BafeV7NlurroIvixL7CIieHB8RO8eJ4Z6A67wGHMe3
   yE0qGRvGMlUGAL01odwiluCCVzUsTts9wyuHS9At8O5K7BqZGQO14QN/E
   OOEbmPgc95oLuZBqd9tFGzVxWpwJ8evF6BjT0tkZG+k+F5o85ghrubDqb
   uJT4qQhNcfooKWAPWdQctJ8xYqBFWk2KssJCOFDG80x6hOd98lf/GBpoc
   +hBO27YTjWmntT+N62esZrUdMdJFJtDYy/uaKhtZnQeqtwBltmnOWFPyy
   1TpIceHCjMNeR6FSnW6F3LrkJj7OrJkw1fUJ2IF6v23ZGdALRhy4jmbGe
   w==;
X-CSE-ConnectionGUID: mta/FZOeQKCVgy8rAysXOA==
X-CSE-MsgGUID: hqFj9qZxQs2n3IaykL4qsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74694320"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74694320"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:07:20 -0700
X-CSE-ConnectionGUID: X6esbEF5Ts62XoZrpzDrKA==
X-CSE-MsgGUID: FlORkH0oT/uQ2q0CLpNMLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259935299"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:07:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 14:07:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 14:07:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 14:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6uObyuVY3Sy1/2pcCjgPK3wZ+D/LTkutosZCpJa04RqI3u7t2hVmpMYo5um5zKl0MM0Kijb1k/pjR68pLRlOyGQ3WDqC3bm6rS288XrZTdXN+MoDf4jT9+QhX5TKn3AS64qEaZpu5/AJkYwAtH1Nr6NMKmola6fxUQ7GDPRXOpgKGtXCObwSoLMeP+UEeQz84OTxvWOFlzSaPjntz6vbI+KmABcpNMpktJ5YcaRtpRYyBrpngeERqWlmX+kcBZJcyDV4twTOqOV18Uj2WH4JLGd6j/zEgFQ9L69qAoXcuV42dRTrRVJvb/BsIr+MfnKzCEghDXGJrWqUdecM5KykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy+3VYFJS+13MdVxF5vET3xihlWE5yZk00O347xPSxQ=;
 b=PUgs0NJXLYry6lN2aD1pe7kXyrmxd7fhoU/7MVaz3jJDwcTaxT3IwXU+gBxFeNDQfmUP8tQVVdJaXiIT38DCsZKIN5HI99q/ZC8Rf7HZnrCdoy2SyaxCagh7FOuv2oprAeGZzrh/U6D41WgGRhM7exJFjm1phg4iN9l+MocT4oZ+cgOiMJmpdLHE5tkao5a6xl5li9zcgYtd6mtPV5AcfjX0O0V5N4nO2d8/+a2IID/UJOaR5zEmQb8+qqXbY2v4JM3ccelSRNeB3Ofa1gRXaPTNneJbAsaLaLjy0Il+XiaEqR2l5QNuMxcUczJKyPMW/ZbNvvuB7PkoKdR2ZX1MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Mon, 16 Mar
 2026 21:07:16 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 21:07:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcsgchoKXrR5VsN0WJ/4pq3g/bNLWxGLQAgACU9QA=
Date: Mon, 16 Mar 2026 21:07:15 +0000
Message-ID: <e071778df6b8ff85a93d8ce7da7c2358a5fdc4f6.camel@intel.com>
References: <20260312100009.924136-1-kai.huang@intel.com>
	 <abfzX_OcpVYNrOnE@thinkstation>
In-Reply-To: <abfzX_OcpVYNrOnE@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB8774:EE_
x-ms-office365-filtering-correlation-id: ccdabcd8-68df-4953-9022-08de83a00069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: werfi3jBPvpY/DmHKG6m91eWjUNYhkaBgBMYqDba8uTk47VTTeofx2sBN9xJ8TySPLN4et7JwRE5yFKGyknsKKacAQokLy8qVWp2D/SEkpZ4s25ibO9R23FZvWaNd8PSPGyur7ToiElgDw+gD383PCHu1vb8rTiIPBgh4SMNViiQx1ihDsi28gq6u35jG3yIcKi68XhhFuj2cAE6OUZ+RM1W+wzZgACEtx7e1f2kwMW5WScf44Pn3vrLnBQJbAOE8ed+CyReldhVQ4QycoomXBbzKwKaEAzDB3mgkxOZGB2P1gI5K1jt6mwH5z3igaIN3CyPLLnenJCrEWXy71CIf+TGcR5kJLgh/qpXSvcYFWWYtbEsGXQZRJcceHm6/hfdKGE/0DJosAKJpjElHBdmjU1szViyIorkZYv4NKLlmVll+zh8k+q+hJtIXCw0YUfNwo0g6x3NzPF7YjqSIzLLkSw679PHMltHcnUW3UfNS1rJKPyJp/S4+dM3DzsMa8VS/F/VYJzHOUj4oG64L1Lj1yfwhQtjzpNzcyciWe7G/sgtRC3NMmWKNl7z4+CPaOHrCnVV3tAR0rxBwCuZoav75Pz4U7BXqIr3reyqnuG/WZy+Dm581wv5y4z6qbkSjy/UJVUayXUP37d6tOMijU7oNEsJWbVOq20pZbX2EP+FvPIkOkZzXwVjN0FnLv1WxU6x1K4H98I+bN6rynLBR+kTq9YtPFpH2Hbj+ZLB6rV5eIIuR46yUoiNCc8ptfiavduUWhx5Q9RfY+bVHjhkwZ9UGtM45n6G6y9/fCiC5n5v5pY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9mdHywD+xyV5tP4vu5GSPDDJ40uQ9pWUv+n6Q1L7uiblFAHmuK/gUpbyqc?=
 =?iso-8859-1?Q?WmWHp9d0Y3W8KRJ7AH2TJr7BdH43gZdrqW8II8U4GyAL1SWD4lfdPEQYuJ?=
 =?iso-8859-1?Q?xcNb50vuDCoiugSYICzHjnCoQZ2OGNABk+0byIM1dbDOqpRSHcCb/h0m7C?=
 =?iso-8859-1?Q?/yNEDdW/eEEZqjRGH/SiZAUT455vlo/cLvX/gZSmqgzsyOYYY7cDoBxXZP?=
 =?iso-8859-1?Q?nE2d6sYwbEMbTYadV2qq+WU8VeWXA/wKnPsMacZ3o1nWJy7/IsKfYzEous?=
 =?iso-8859-1?Q?XqB1C7ZfMgkLL4Q+69TQQgI+to8gFggCi8GrsRysJBoMQQgQR4EaqO4347?=
 =?iso-8859-1?Q?Y/rchbNGigWOUNsk8JjijE8jDUJRkkL447VCXX55CnIep3CgWPpCZrcTfG?=
 =?iso-8859-1?Q?/HoJoaa1UzWa+xAKYkVE83U+8BfeCQ/xZWW3k0O+1+URDY0oeAAg5G2vqB?=
 =?iso-8859-1?Q?ZQVnXmfigVncVCFHmermTVDokCGEsPob7c9etWolgr35UlePcB1hSFdpoC?=
 =?iso-8859-1?Q?IyRLjL46k7lriGayx7I7OzzxktPesidQHWGjYIPBrbLKqpp3OG0l3qqAFL?=
 =?iso-8859-1?Q?IeVmuDM6X6l1373Yae+xQJL1A7J8qs5LbNTamghYouOufcQxyJGWitUPK6?=
 =?iso-8859-1?Q?+1HKLQFDXSAVFEQUsR0TU6JKqylxg+XSTm6DTYmcTvRXHIhPbQ77exer51?=
 =?iso-8859-1?Q?uwwpw7aDQQbwj65ohLtVBEkROOzI6RREKkYM7pRwmqjuVCeSdQ75zeLC9p?=
 =?iso-8859-1?Q?6WfMM76wEb4wkGZ/GP7VqQ77cTOrkIstuGht0ISLAqm6S8JRIuuXx2ekj+?=
 =?iso-8859-1?Q?96b1LXeaSEasGxTH9oiDzt78dLEydQZshxajeaXu11kybFsJIi8MiKKzR/?=
 =?iso-8859-1?Q?yA4KmY/iAikVO176r/vTt54I/KAB7pTAJuMO/D/QaA8g73qx+sREVMUFsD?=
 =?iso-8859-1?Q?c+cxuwpC4WjdA90Wsfqhp1MI8MvdZeQcA2ZOqIFbIhTvHTX1ICJbA5tGbh?=
 =?iso-8859-1?Q?4QyS7BfG7pHyHnnT1myhSt1oqLYF27GAU0BID/pwGQiVT65Sbcsm6BKnFL?=
 =?iso-8859-1?Q?KdBAKjN3WOMWsjJNQICApCAGKw91dOzq9lrl9MuJaytUc45Hexn42fcjlL?=
 =?iso-8859-1?Q?nkwQIvp1e8h/28qvG2jv+p0QBGkQoj7c9OuLE9m45gFGn3yMRao9VYQ3jL?=
 =?iso-8859-1?Q?/cJ7PRqZPvdt77PQuw9Ml6bdPkaMerTozvdGuNnli4DgZLAYRoHutl69By?=
 =?iso-8859-1?Q?7m3TG7PGmJZl+hddCp5k4a025kxsMG+1e0pa4QBXhq67syU1exTd14SejL?=
 =?iso-8859-1?Q?XjmMmjUr1jBdeiwNJ4KMSvsWAj4Hle2i3wLumJD4xEEM+LAKWq5Lm/TI2D?=
 =?iso-8859-1?Q?IZRN0859xlaUCMTSfBeaxTN68xJOoagP41zxNIEm17Ho4DfYRDhkchtdAL?=
 =?iso-8859-1?Q?sKh+cm1UgdDjEskEtZueeKx+64D/MaS6XQdpgggvQ2Lgw+u9fqjp4orcpH?=
 =?iso-8859-1?Q?0y7nQpVs4LM/jy3IttCyFnQlwXWE/aa2PzOJ+vT6DOQf4aLIVvMknvPj21?=
 =?iso-8859-1?Q?IBA7FLcDY7F0/aq11Fwd6qRwIwnW/9qBIP05BZzSW9dpws8iN3E93aeRHl?=
 =?iso-8859-1?Q?Or1NEPL3d/Y3BWrtHVKHpdwNx6ezN2pzMiCHh9sW/dsNRgb+KVCFG5/hvU?=
 =?iso-8859-1?Q?qjIRvod5xncVircv+cNceKW1uqnbVockEfTR5aMigaq2tBYa3mYf+O0SvF?=
 =?iso-8859-1?Q?kaNRbykCoQXFDuuusIRmY4ejaPMmX16ie9B1+vuC2gaFhetr65sgSIvi4u?=
 =?iso-8859-1?Q?eq0gkTcC4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nnB9qeNX9zT6N936EuThG3wlszKnz0S//I76WEXcnyc303A3jZmWXiwDauHtlYAJ1HbnH1tplYOsIMuHOp4YOHsIJ1JOps2Rmq5AyUXqQbThh/k5n6r7ftl3wNKyImUdrnKZ+n37fjychhcOqC33Rv3nbd42in9uYs/Q4xgom+i23B8tET6p9w2ka/WsazPVswzIm1uobihM67bAUi8F6RVBL5+/j+55pVncRlRhqldGMxOGhVCQIHNfT6iDBXphMhAAZjBUfDcXXHWPIzNG4TOTUeM/lakaxjspcTwh0TNzD4ByzLJl0uUoofrFa0qHs1TlpIFJIR7G4BHvlJGblA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdabcd8-68df-4953-9022-08de83a00069
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 21:07:15.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvIN4M9MTBAJJBrX8AgzlprSfnQL8KGsYBzEVAOvC46oWgFcSdmeU0xXdTdp2QOFE/hOsy0qQvJ53e9IY1fBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 635682A0892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks!

