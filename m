Return-Path: <stable+bounces-227239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIj9C2jDu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:35:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 402AC2C8C50
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F03813076447
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FC3B6C0D;
	Thu, 19 Mar 2026 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRlGsIml"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32A33556E;
	Thu, 19 Mar 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911312; cv=fail; b=u9Rqnda/E/goQDcOoifv4We+Jb+T5x88l0QLEyHKvIyWFucQKGI6/ZjGR5fVHTUc0YoBCVY+/C0YJ6eg68uysnElJOI5su99cJgVBMywJUFecp6kTOTIFbVFQsU6puRJT3T7dYUrj2OdlYaANaLfllA5913I7qccJ78GujYJ5os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911312; c=relaxed/simple;
	bh=9950QLPgybJCCzfN2aH95Afuhq7E6cd/7yH0RroQPPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTkSpuuTZsXHJn5qAYdGnFbdSDO4NeIa6hJ50N26VmWEPxnyLcoj8XjpPTd2MrdqB5mrW2zmWPIJ2EvthmEQExP6+ldnrnoXZoPr9IgNOdXHFi++yn8yKXkaJsSwyRAGssjpGf7bY7YpuKqxhzKe8EvsLnOIfEQ1xh/ml6yUfe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRlGsIml; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911310; x=1805447310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9950QLPgybJCCzfN2aH95Afuhq7E6cd/7yH0RroQPPQ=;
  b=SRlGsImlwr2GHeM6TNsdX0X+EIdSz/dKZvPlPJ1SiKdKkhNlmdrmg23Y
   96AYkt7FGBRqSFE9Ret+Msk22B1/nALImZWU5aZdyOch9D1GdyGHKB2fI
   MPBNcb9zQY1ElezifUoGLYrYLT1tp0wLOlNVrHUOUQRIQSJyzB9/VVhNR
   XHFEHEuodp4mliQEv2qXUoxl54p4oWqRqaQlZIBfdCcm65xUobnGkrNZE
   aZfLDFA1JL0YV0RSaeH3Zie6MkjXzx7giuYEz1FM3gMpf3pCBfR6Pta6T
   1v/VD/+NikPWZ8ogzlBuPnldosrE7EZK1hL/+POajKznlQVXSqvtsCeOS
   g==;
X-CSE-ConnectionGUID: wVw6JUBZQuCTMDSr/D0kEQ==
X-CSE-MsgGUID: 47aRULiNRLeiST4ufTriuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92361067"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="92361067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:08:30 -0700
X-CSE-ConnectionGUID: nWM2/66DQKeP/89gTiyEUQ==
X-CSE-MsgGUID: f0/bPWQbQYKgGvRTEvh6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="222003219"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:08:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:08:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:08:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg42Eyv7kc0zDlDbC5WQfvpXXEayACPyEcOo6bFGzwkxkyJF19oeHK5sgCCRK3fI49Q+Snw2q6pESD9NURnZw58PjhAlbAhpBH+X18MZU02+BLaClbuA8QwChEKXosHaOdVQehZ4jD/+1zgOJZbr6l+qfaUbCZkSttHmFkk6wTj0ffblv53RxJtjSrMnWlLrFDNTSEC+dnU+sBB5AgsT9Lp9nal41QHENJFgASdQVRfA/WklMOpjjx5UwNTHPkwGZq17FTZPK5sIaH6sFO1seMw6QsS79T5NG6VCEDGIfGfVjsxCEsWbftpKttlULUAFnnq+w1zADw2Qox9f5q/mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAmro6TOZNlRNZwBtd4gnLyKb6jDenwUb3/3APo2KDE=;
 b=ef8hwTjq+Vgk0k7DbKV/HYqh1ZB9i+vQwGqngKublCLVVKVrd2CaEpIrBE8UX4PDqWAJmBCNLXPdA/Tz3UebCRyr3UkPhNAYhN/UImerCe3zpIqMIJHMIey+1B1s47Sc4hcTQ+WnXWxxTu5CSnKNTkXyJE6A+rbEG1131eHBVekrZwofl3bVq4eJdPOvEOW4ODnJkANmvnkDsR1DLtccrYbeMpexN+DsD/DJOKDZyQAk3VbZNtFkCL8YjTrKFZnoLCAshO58RUDeE3pV6pgqthLM8Kx8h/6M7Tux8vw9mEcIekIUuSs+4ncNLw+dLlQGQTUKxc+DPPnA//T/Us4spA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:08:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Thu, 19 Mar 2026
 09:08:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] idpf: fix UAF and double free in
 idpf_plug_core_aux_dev() error path
Thread-Topic: [Intel-wired-lan] [PATCH] idpf: fix UAF and double free in
 idpf_plug_core_aux_dev() error path
Thread-Index: AQHctu9MLqImmdGh40imxNLgIME8LLW1kfCw
Date: Thu, 19 Mar 2026 09:08:23 +0000
Message-ID: <IA3PR11MB8986172B2F9161F1CA402D7BE54FA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318155220.642160-1-lgs201920130244@gmail.com>
In-Reply-To: <20260318155220.642160-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PR11MB8682:EE_
x-ms-office365-filtering-correlation-id: 099e9058-4729-46d6-c745-08de859712c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 4RsFxsq2JfU/AB+iS5ZgUo24ZDPvH2BIMYO7zGD0a8V4rn3GskgI/3Z7XELozcWrpueUiFPXObTU+vaj1ZCIsfx0nsfdlP0p0jti4oDsrRV+iJSFdW28bdmzkzz0NebOnGRIXy/XecM+f3N8F7VFs6ZYWHYFHxNVl6XOCid2hykoRq7r2Fgvz6eHxaAOgPEneqUMgruU9q80YMulhxoJufpvqCcW3ncgeUiyjqJ4uz0+c9mEoF2xf/7tsNGznsdMLF5+LCXvoM5kuBeU16PDOmuvM4Ob5Gm4zmsskj/3dBJRFGHGMuGIrycTN3XNeyZc294bvmu0cHitZSmmu/wdCmLGbQPifx1wxQwEj/KHVhZRMu/peBhoYuNlRtoBcyqu6xfpn3qSAm9+TtOAgroaZHN+t8ZamCa9UghR49Pascaa3K7fKwp2WlANKsNHkRwEG+5/Y6cYpv/Ptw+nHT7LEiZhKbl2if3FuEBYIx9CEfZiHl28wJeAibBpgJR30zzYscEg8f0SjcWbzkU7wKA58fRU9KQxVGf5Bop18QJZoxqd4oMS8SxEpUiawBTEnE7LJLcf6hQu7B+E4BfdQcBft7p+go3r4Nt4uc8sdLygekufIc1i+BAoYVGAMasozOYcTztixwUGK1nkHvgg4XrwzcShfrt1J38eMSBQVXqxkFS/9CstIVu2NpFdDrXnu3Ghos9AW7WB4yLRCSCN/aODS1pOOlfhT1cpXlo3WwHGlVT0BuolVlSWrKknUrF7lwbXFUuPFdom/uFyqxAnSZx/o3tMs5/pkhLnx3i2ZYogdRWUkS1HvfdEv32JegxpP4J+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U11YV0WjnGOFhegtpNaHlHUt4f1rjnEPngOjWmzwvBSZAzUfZo2TpFjWCyu4?=
 =?us-ascii?Q?QJ0mBCAbxlstXyQab9HRXwhk8wTKgMrIe+tp+4KpjpYwBxT6/OBc13uqHVYm?=
 =?us-ascii?Q?RUofvjON/uc40khzteSwqv1J3y67uF0zq9HgQUpnRP309owUmhhsA//2mc0j?=
 =?us-ascii?Q?qM+CWJx+XhqWyxIS162cv5kEwGXMpEg7pDpsiyTuZVHyCd2BSOC9nDTZF0KD?=
 =?us-ascii?Q?67ws+eAQMVNuno3Tv4kg/9so1N5mNSG91cIh+bTB18usQUX85nHKs0PBlOqI?=
 =?us-ascii?Q?5SgvSvLneKeE7gVgjUI+xy2Ba6zLOjl/ci0CLoDY2Xges1q+NcTNr1RjU51A?=
 =?us-ascii?Q?37+85qQxxlmfMBJBlxxfnl//VeklQahYMJ+5X9cDoTteUIoknGToiUKKJmtE?=
 =?us-ascii?Q?OToagPwhQ+ROFg5wo2cItcXMR4dul3AM4gDKzHiwn4u8zguCHc0gayTKRV/O?=
 =?us-ascii?Q?q1z7tTQMIHVxQBZ3wmYlG0GlnDN6E+1NDfAayOHaZ1lb2fj3c2A4y/QwqH+B?=
 =?us-ascii?Q?Br2DAdtVou7MQ0qMIWKLDioMGOaJT5iwSJS6Q3w/LZV+uBKogUiqUVZCtCCq?=
 =?us-ascii?Q?ddki888OYh65P3p9LerCJBBK70QsyBHtwk/8lRqmu6caX7uQGuDMAmZzRW+Q?=
 =?us-ascii?Q?xgtrSHVqhikMlynoIC514pE3g+NFFJue3cwL56ECEycrAGEdaJULmIXp1i9G?=
 =?us-ascii?Q?psz2bvye8a6IX9A0vhrFyV9ulsD2rCRMsMyVvCk95MaCaqNchcu9rQgrZCK4?=
 =?us-ascii?Q?t1cEgLGeFmm68/Lx9unBP66SxzdIlYjnJR0PPd1crLzV7h9NbGYRxKGrNLUN?=
 =?us-ascii?Q?NlszplVza4uGJRNfmP0TaDngs7SIONhUbHSIxXfn56tUP1ZsmvANmV3WFa60?=
 =?us-ascii?Q?YiKgFItSGYUFoapgkoOd7RWBZNDlwjoTa4i6JF3JSq8Y/4DKVT7UCg+cfy24?=
 =?us-ascii?Q?esc3nuyjWGSSC+ZPae0v1OcHxtmYR5FkYrimUcMQhqKzkFwepKcdhsI5Cg+Y?=
 =?us-ascii?Q?wN4A+KrDYkya90ILrncP3fhG39iMaLoLuT51Va6vrOI5Dfk1ZYHApHoH/X2N?=
 =?us-ascii?Q?X+dQYsfLEJXFBgshcUmkc1l8/AhPT6qELvDJpvsUaQTQ6qgjSd7YiSxdM/p5?=
 =?us-ascii?Q?pKJmkzPEhIueTzP0uQ7wWn8OUVGZT0WFi1TefJ2CBncXPbGdHX4uvI6Ob++S?=
 =?us-ascii?Q?R7gEHSTtObiOmVelpVegY4dCANpaZK/8mVF6wYEfiAapnBRiQYheMgsyl55P?=
 =?us-ascii?Q?rLzrVkkSB+8+L9wDNTD6Cl8bjd0jIZyCk2mIWr47WZn9DmwiNWGfcmKMWmfi?=
 =?us-ascii?Q?4ietIiDQYWxKjHbAg+RbYu/InBIxvwVRhAkcjtvYNq/ZfrejpDUR2U88Vk8B?=
 =?us-ascii?Q?i7Q9ZAdBpE0mVEemg4Dxg4SW9QV+yf56CRwsRGZumkRheeGU5UrN9D9spXtd?=
 =?us-ascii?Q?nBRHi9BvsqRVaZfjFOPLDAbeT7FfvdF34Ga8i8tAVAC6qPrBk/4EaXBUAH/Q?=
 =?us-ascii?Q?kkI5DcupD+I+VR2p6ruRsM4f1uVqiyjYSkHxlLzF2wscLVDLbd7DoazU9wmO?=
 =?us-ascii?Q?X+Wb4CVLw8NgoBqkVEj+DRks9U0GCFFPSLsWsf75JLJxH8+j50Bcwzm4+4/d?=
 =?us-ascii?Q?ByoBo9UmniWji8C7eKNKZOmOE2yo+8FwOvaDog2nDvwFNPLJNxFOfBY182kM?=
 =?us-ascii?Q?cTDCsQemBbsPoHHF3Ba1300ev7ZEmE/EiyWGp3+aO7l/Dd26pC1Igck3uwx1?=
 =?us-ascii?Q?nJ9Vc/CAqQnSuybm00g+eaNqutl480U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KKy72xWp6g43xQu746ikw4nVk5AFsTN+dJdQ34/So5UdZt0ygrJaynqF6IKNxT6YglbcD2ynVEIsx9n/MuOiXcKkXG25maXOqfT2eHn/sBjCOj+bcBPn3L+85tk+FX0Vh2gm2ScfVIrXYyQg/4N+Ot6ZHw5+EfysaXdHDp1dn8ToKbO4cNEtguqY5ugyMqVkg27tWLx+/kAwrUr7WcxL//j9al8LVYwmjO/3pC7mrJDq7GGSqjIzOxnzBTzP01l5sLkc2qJtUob1f92cKD9OBdOLFifdU6XLQ7/ww75m6ic8CvSDu/JK++ACIUi3+crp4suIoLHVA2LkVY8CykWpYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099e9058-4729-46d6-c745-08de859712c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:08:23.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS/9NdOw6/eX4IggVZ3lx2Wd1Rsw2ZCg10ZOYsl5x69xYsQ5cSvLNv4ZfxDYETgz+CgVMhGzyGwA3syNO+JEHjKo4QMUvgKOU3bbMDtyT+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227239-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.980];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 402AC2C8C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Guangshuo Li
> Sent: Wednesday, March 18, 2026 4:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Guangshuo Li <lgs201920130244@gmail.com>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] idpf: fix UAF and double free in
> idpf_plug_core_aux_dev() error path
>=20
> If auxiliary_device_add() fails, idpf_plug_core_aux_dev() calls
> auxiliary_device_uninit(adev), whose release callback
> idpf_core_adev_release() frees the containing struct
> iidc_rdma_core_auxiliary_dev.
>=20
> The current error path then accesses adev->id and later frees iadev
> again, which may lead to a use-after-free and double free.
>=20
> Fix it by storing the allocated auxiliary device id in a local
> variable and avoiding direct freeing of iadev after
> auxiliary_device_uninit().
>=20
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create,
> init, and destroy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 6dad0593f7f2..0fcbf9f1ddbb 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct
> iidc_rdma_core_dev_info *cdev_info)
>  	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
>  	struct auxiliary_device *adev;
>  	int ret;
> +	int id;
>=20
>  	iadev =3D kzalloc(sizeof(*iadev), GFP_KERNEL);
>  	if (!iadev)
> @@ -211,12 +212,16 @@ static int idpf_plug_core_aux_dev(struct
> iidc_rdma_core_dev_info *cdev_info)
>  		pr_err("failed to allocate unique device ID for
> Auxiliary driver\n");
>  		goto err_ida_alloc;
>  	}
> -	adev->id =3D ret;
> +	id =3D ret;
> +	adev->id =3D id;
>  	adev->dev.release =3D idpf_core_adev_release;
>  	adev->dev.parent =3D &cdev_info->pdev->dev;
>  	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
>  	adev->name =3D name;
>=20
> +	/* iadev is owned by the auxiliary device */
> +	iadev =3D NULL;
> +
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret)
>  		goto err_aux_dev_init;
> @@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct
> iidc_rdma_core_dev_info *cdev_info)
>  err_aux_dev_add:
>  	auxiliary_device_uninit(adev);
>  err_aux_dev_init:
> -	ida_free(&idpf_idc_ida, adev->id);
> +	ida_free(&idpf_idc_ida, id);
>  err_ida_alloc:
>  	cdev_info->adev =3D NULL;
>  	kfree(iadev);
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

