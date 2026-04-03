Return-Path: <stable+bounces-233217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eENfDdPpz2kG1wYAu9opvQ
	(envelope-from <stable+bounces-233217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:24:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B82396547
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09C29302E1E1
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CB3CE48E;
	Fri,  3 Apr 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cckCpCtj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A63CD8B7;
	Fri,  3 Apr 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233461; cv=fail; b=dcNf+33drMbv7YmOA7Qa5gtw6c/fa8OokGf/ar9ytXkFLOPvuZ6hhMFJViB2bd5hdrUsf7CUbTO269qJnk224AcpPjUwqXwoZ1UzsUgqVMni7e/qhLLt8ZNu7cwgqR8UAE9L63IUsh5PSaStWHlwDyRxtc2bq+6ZU9q+StWrLW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233461; c=relaxed/simple;
	bh=u/ST+pnoLMpUoCIPepSYzahHJL3sF0otqSmImJaAfOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ab8J98QFUvJYe2qivd1zeDukNytL+POvNm1Ya1sENZxkN21w4mB/e67yBkxUX+xk23zPAvNXEGxYoVZnJddfZmgl1w6/W0YXNcbAX6DIRCQU6GvcUK2EAcj31HF1VYGXNh1D+iM68aVlNzy5r7X2n2kuna7fcu3PMprcnCnA9r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cckCpCtj; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775233460; x=1806769460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u/ST+pnoLMpUoCIPepSYzahHJL3sF0otqSmImJaAfOc=;
  b=cckCpCtjd6wOlpWJB6JN4iWBFo6soYEW2qxZdLIVvjnSR2uTLylJAbJG
   hLavRSov/yIHAB35td/9kXPZ5oUnRZB+xvFxZ1Nbz8fhquJ4iXnQf5qfb
   TkgvaH+9S5sUh1qJePLtg32owudEwRACrnVC0afbYb4bok9Wln08ROETV
   3WKnZirERRT43Rj3cvm8KENxqd8FrpmbTf3SZ9X3wY6JspdCdGve17n8V
   S1NqYG5pMhNBkIa9b6jTnyiqxlRpg5EuPsoRuw5k8MjJU2y0hFkCyxk/h
   NvycqyrxT4F6R3bqn3rqU/aDPNROOlIGluDoaL6w7sSpc7Xss8Pk4hlI0
   Q==;
X-CSE-ConnectionGUID: vpBhuElmTmyZFxPfoMLF1g==
X-CSE-MsgGUID: 4CKH8jhwQ9qFbcGJytKKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87684764"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87684764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:18 -0700
X-CSE-ConnectionGUID: Xt3KmsOgRP6rPQGwX2BXzw==
X-CSE-MsgGUID: MPd6HV9gSNWltozzqZBuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227231914"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:24:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbd6kUqUhd6nLtrmM+TYCpOPerJ7CxqksDKLCLcfQTduyd6VAuaX9pRYAYZi5Or43beVCcs42SfN85DGgDXadUrxDD8KYzHcgXYYONKCGUvw5Seey1byabqTTg36ZTb9/4iMBXEFDJnGizv5cLWyhxZBoTuZxtVh6LJ1jlLNCZOvyCHzV6Hg5hBtMFkYKaG4OP7FHdrol34CX20bsusaTXg+8fmFZmQrXRyB09wVsNuSGpMikALEvLqIklfLU9TZ9OwO0KwFJa1FktSu5znVGvltXxgzDVnpvTlOSoHqAVSo8pTgLDQin6rOS55KufORu0Qli45tfPfJQEOnJ6gLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/ST+pnoLMpUoCIPepSYzahHJL3sF0otqSmImJaAfOc=;
 b=BplP7hrEZJeGAVQ4lFiClxvP9HHisyhfShJ+CCRselgIwe8MmPEmvVLKPJYhu9/+2AK9QqhHafBMtq2aZmELDmFa37mJFO4vuOItz0zerT+tGnmU2FiVUiRFLUlhbSG7B+91P2FL2WYykdV/iEMf2RmhFq1p2OPjFlHTS/dgP+X/FE/IGE2Hvv6w5w+A5rtdmgHcmUrsqwItm/YowYa5M2qunFk6/nUD+qQE+KxYsTWy8Kv5DTn1M5wMSEwluIvoeJdASSmWkFAxEyKEJZSUsFYx/zzLXUBbGmgk0pRc/H2ccw65QIYOpXscODaGCmxleseizsvLZLib0of0PWeFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 16:24:14 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:24:14 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"sgzhang@google.com" <sgzhang@google.com>, "boolli@google.com"
	<boolli@google.com>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 3/3] idpf: set the payload
 size before calling the async handler
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 3/3] idpf: set the payload
 size before calling the async handler
Thread-Index: AQHct+VgTjhac3i79kegkT7/+g/PdLXNnIWw
Date: Fri, 3 Apr 2026 16:24:14 +0000
Message-ID: <SJ1PR11MB62978585C701B03C37F7C6599B5EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-4-emil.s.tantilov@intel.com>
In-Reply-To: <20260319211335.23236-4-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: b279fb7a-3c2a-4759-08bf-08de919d7262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LDBcZuO2omD/1u2M5BXAWHwGvo4ywQU8dz1h3UboprjSwdWPi/U3wCpQZfOHXGkmKWhBUpzojwEq9WyMnwBnLOEEsVPThd+Fs83xmjbAMqs0w0zfH8Kj95TvfgqOhZI4/Aqpibww3QcQQq9uc+UI1DVI8cPcoitf0TwN0O0zp68j7OEuU1DTQV13K8mgQTuddfG0VSEHyrH/mqNz1x5riZFAYPEUCBGsqnpyry1Iq30e3kdqq3FG5uIPAaNLA+aVAEYWjNKpnYTrTKmITVhJAbz+mvlz87OMF2RIA7KN+flLsA/keM1tJ9h0B3rW7+HjQwzGMho3zSjYvuSNWwYZybDtXUsO0TdXV+kIJHkUlvusQ1WBUD5h1XoEgdkctb7Ip8D10L0f89vT8nZlnWZxkQRZM4cF8N5498mJYsf1sIlFlnR7c5pbf1aH4t7sMj+QNTQTWfPGkq8cO6B63Yi9I9YTezaADfdTD9YTygS+Xzuafnq1ALZfu/u2oea/3OjXHuBOdlDHYIA1Ku/PSk/MORotLo1mTaRyqczW++WQPUalXaVZcL3Oi/02t98VEFdF3nf2K82HBx/sshNQ8NIB/YCr8QoBsLddXwc3PNdj3FFEcISOR6IpjsnrtDdihAamkTpvh5ZmrlCID7kg6jraOQGR/Ij5eIRANe7wwRVIDXx+e3B6K507jv+n5C1mYIFnNtsPTMNOIIyNv+Y43pyMlCYQnOuXTQmBcJ3pYhMuXyy/UkWz0Yuceh7EVCqzGKAD/ueMG3t/0/xnSOQHojZRBv4NnXiAO5AzwLgSzKGOYRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P1AKufzZob3NgwX87PB7++zNsOHeL41jYiuFegzUusJihv7958RrQtlh2dyK?=
 =?us-ascii?Q?VGrrhc9vmGkyJefMJ76GOo2WbhGhrDFOOFCx/4YfKHEGYHNZ7cZYkju/QZT7?=
 =?us-ascii?Q?TbsfgXVcHLTXEPhryvSxOQHg5m4O4OIsTENNBCxgtsiPj74sT6Ds/M25Q9we?=
 =?us-ascii?Q?KrFaOu0Xy25s8id0j5E+QeJi7XdiOEQVadZO5wh1K0X3ZenWo9NrpY9jo5Uy?=
 =?us-ascii?Q?d5XNQburlY88DJDdhD+zBSZXoQ2nESADle1khZSat6k5ZJiuJWsvmuVeTNR9?=
 =?us-ascii?Q?d312mB0Cjk/BP98bdAkruuveOwM7MEvyPDQXr8GEQdZyaX/B+sQImRh+Wzzq?=
 =?us-ascii?Q?SttcS6KyWr2xiwGa6SdzsPgEZeJt2B71cI1TLilhQ00hJM6vKKnF6+6SY6we?=
 =?us-ascii?Q?A6kcNSrwM4mVuWm8RgyMSGfqnqgPAndGmefW+G8gzvBzHZ1jnmtr5iPm9TQZ?=
 =?us-ascii?Q?T4rETvadtRoPsrYtGdBMe/ftEtWDIxMX6PK12GBYytrCsmd89jHmv4E95HtG?=
 =?us-ascii?Q?0GzvUhe1rxy8D7GxAInAgdESdqDyM64YE09iPhPr6ZKWg6ZIyjxOc6nXHeLh?=
 =?us-ascii?Q?mK6smBYq6gxWg/x0Waa4QFlIz18TncsTQHWLOEnw3hcVbXEughm71THk7yiK?=
 =?us-ascii?Q?0AN0YTyK6Gz/14Q+3Sf4jjMkc/PE78bTJ0PkMBRZXmVIMsVcjJf/ZeoV8gOR?=
 =?us-ascii?Q?Y+QErt6HuJKAVaoD5JVjm2PXN0VzAAmT2wzcTvWXKsLz69qOKRFD5NpxBB9n?=
 =?us-ascii?Q?e6FQ4Fe9LA/lvjb+M57oDhbbSndh/C5PLfxbID5+u1VOs3EAldHiKHcEF+sV?=
 =?us-ascii?Q?8iKwuDU1HKx1W4XJPJWq8ec6Op7Ix+4NvxLoVdqNirbRNdnzuXymDM2tAOgv?=
 =?us-ascii?Q?GvQFvJOLjvPNnickBk0PbWuBDflSXfCK/o6J4/EqYm3fbevRWnxUM/9+V8F2?=
 =?us-ascii?Q?i1kRZdWTaRYpp5Ql+0gwDHXu947Fx/THaGp+1HiJq4AWpDiZ0V1/rBdo3ExI?=
 =?us-ascii?Q?o/oJVJSB/KlKzGyjEPCFJ8HdKII4QtrHF+HR6IRdSHV1LI4VxzBgCLaeyQHq?=
 =?us-ascii?Q?OVWP1vpR0S/m63qSae6b6FdM71G1rjqyDsD7l7NMllfT5ZNq/Uxl/zMsLb30?=
 =?us-ascii?Q?uzuVu0eeXrcNeti450TJnT7SrANkBhKmPBu1R8OMihjN2BQmkyKwp7ibRouB?=
 =?us-ascii?Q?/wc/JSxXLsDLDleUbmhoRgxLv1/aKrPIoTCIZVRZQOwRjSAOpgVOCHXBbr6F?=
 =?us-ascii?Q?H0GHL46d35cVdLlGS9/2OjUmTZOeKd4z/RUhWAQhQOAM1bGPOqVwpxlT51h+?=
 =?us-ascii?Q?FC9JCJwx+wM7SixykVedN+as9RiNG2iaxL/xplI8VrSLVR5j4eSwrpk+wDd9?=
 =?us-ascii?Q?l59mwwRaEEXQON++mbEfToXYzOyw03H1M0iGPfC+KidTmNgonIwxA2rRPrgX?=
 =?us-ascii?Q?FLgUAlzurRjl9ah3mOiGadzcF4n932eeFDGLtfMcuUFKYrDs5iS1W1BHU/Qc?=
 =?us-ascii?Q?r2J8wgzZTY1KAslXbB76M0dZqjaRwk6mZ7LJL1FcCU27cbvo5km6QmJ61BQb?=
 =?us-ascii?Q?NLSx9uxMAAD4mBcO4OogpwC2nJfOim4oGtKAYk75H/jScBAf6lvaJsHCPKDK?=
 =?us-ascii?Q?O9FJUFNEVtBhIVqtPWXgAY89FoQGv1s+d5zeUG4M0jU4BWOEfPfjFJK6vQM9?=
 =?us-ascii?Q?iUUgfZGXe6Opa+FcJSMf0KePH8eB4FW1+nurysCy7zhNre31pi+dO3/JOy9b?=
 =?us-ascii?Q?vakaP39XzQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EByVWztkrzYxtuxSleEw96tb0NBiTTWCkhi/PHxwtBnDPMYuZLZCtpin3a5ZXoo8I7VEN0jKyXouQ4w0Lp64wm4hl9hvmKMIsnn5oKk8AiCwYUYgFtEB9E6sHN8EXg0o+ML7Of4cVmJcmxEnQEBR8OsN1rrfTjr0yL8436oN3NG/WOw7SEqMAVgq/9bOa7CwNdsXphysoHxI4NUm9cVKDLhJEXC4K6YcqwG4harl/klOBl1+ujXS1Y0y19bQYqB4uoBi8ewBkGGW6ZuhiktwPy+FqVeroYL5khCkBWEOsAvLsXiSv8dPkJaPa9+tXkciY90cj0rFV1NKjT3hrPwrGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b279fb7a-3c2a-4759-08bf-08de919d7262
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 16:24:14.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bfLEQF1M2QtipaLnAkmXKfFHJr4sfAzewGYW32bwr9r5rRjPD0yK86Scs4F/YK2Fj2rWSLciydgSAMsek8q+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233217-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C0B82396547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Thursday, March 19, 2026 2:14 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bigeasy@linutronix.de; clrkwllms@kernel.org;
> rostedt@goodmis.org; linux-rt-devel@lists.linux.dev; sgzhang@google.com;
> boolli@google.com; Tantilov, Emil S <emil.s.tantilov@intel.com>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/3] idpf: set the payload s=
ize
> before calling the async handler
>=20
> Set the payload size before forwarding the reply to the async handler.
> Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler() =
will
> never get past the size check.
>=20
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Li Li <boolli@google.com>
> ---


Tested-by: Samuel Salin <Samuel.salin@intel.com>

