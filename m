Return-Path: <stable+bounces-227444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mICTKwr2vGkt5AIAu9opvQ
	(envelope-from <stable+bounces-227444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:23:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBD2D68E3
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB84730338A0
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07E35BDCE;
	Fri, 20 Mar 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCyXVJBj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DA35B63A;
	Fri, 20 Mar 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991429; cv=fail; b=hqXvcfpyoHrYNPL+PV1Tog4oRJiBRU2+IQ0gsVjRc/n3+rO5RbGsIwIpKdgC8Sj1fB+qsea1lZ5iL+2nzvc4QLTYMHDuBrZy0IitT6NfsMHVpnmd6Vz7sfwYQuxKXzfEwa4uYeBKEBtTp92W5+vgaCAO1yu+CBPknoxAdk/8AT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991429; c=relaxed/simple;
	bh=83wL1tmydkiu+S4R5OxljOPaW4hHVbf9EdRv26Niil0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzuGNdt3SQGH4Es7N/Hqr71o7S1XIEwR12G+Hxc61sEnmQqKBMOlWY9/IX4UThuUI9Iln0wwRZe2/mmUo0DnUM6dBTJ2avWV8DjlYR0JDY+0lAwy8X/e9sT0f74maK7nt0yUy15TarzGeLHmsVseNAOfoyd3pimvZ3KSEm7fYQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCyXVJBj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773991427; x=1805527427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83wL1tmydkiu+S4R5OxljOPaW4hHVbf9EdRv26Niil0=;
  b=JCyXVJBjgZRsRy9COoCvflb10ZWU0NezQa1GUiT7tmpCr8mV59VUqEr2
   WE2YRedJrCteO47+60hR6smxTIRvJV6WvMg6OxadYW/YD0uwxvOiyPZ4r
   f1MOcr8lSYUYd5Wq9G6dtQZdD0b1OKtHtyzeC32LyTVX6Rx/1fDUIKQEZ
   lY3QNp7HLPlHga7DPU+PNNglYCQFJyeWlVk53eIohrGubK38DqeoDxBb6
   xm3b3JoiHExhD4BKPfuTIjvsohriWKBO4ZqLOp/TZc54bIYG0BlWZhpVG
   uXDU8Nu+ySg2A6JzRQNQM3Gy2Lzd0gnPszh+1lLhSu7hxSP9/IG5ZqdQK
   Q==;
X-CSE-ConnectionGUID: oMM6DGNjRfmnOnYr1oHW/Q==
X-CSE-MsgGUID: 8i3wqCX4SMKtKhbxghfEsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77680354"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77680354"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:23:46 -0700
X-CSE-ConnectionGUID: 40F/bX5TRti2Em+rz5YI1g==
X-CSE-MsgGUID: WZRn/Co1QwSTsxxmcfpDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223233122"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:23:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:23:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:23:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQN2lCa8tcH8iMzr+vKTEZBHlwKbLVG+v9qLD8myoOESqCPo7cZjqLGj7paVs/VphATcQ5W8y6C+DJI01Qp9Sdt+FB7yZbXujOKWNvfOdyWCm9CsknWpzcoVJenDuZXmaH6ue4PiUc43BwkGLoZWmZsC/HJmKU5t8NEDgGnHSEZ9Q5U9g5bAFj+5CRoUW1pyWD+FQL8qKKKhbKnQnCDQmbBgc33mjaDPPhyK2N/zadWGCmSVyWmlJMBGUC3nlpuO+T6YVDI0KSIgRDwtxPNraxfTyBB/xD3vlgOJ7/CfM1EHRMj9qoBD/VBiNZZbw0xjiwSCrThoG9LxXxE/Y5wuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D8m+pfZLffX9URcDiB7gJVFUxX8rCCGxnaIr3WiW24=;
 b=JtKyVXGaV6RNPkkbNVEcWO+PaqFw9zD2RGyMpN2cic3C5x8XaoioblcX1LDPNRhWnh1qWbjYxJ7ujhEe51gYDyisdVgNmTR2QaImjYQbLKpJZxc0768iBrHwJoIEfSvfvnzVwVa8bfX1CxzW0V4MNERR+DlUhIpKhcX5ntiHbS2pHuSHIEnZomzdTwhGticlj7RoLA6G6WzZOJ/VCMDETGqhI32wQlQ0zih4fJRKspzou4CnnhrtKYJzCRgXBdYpm57IYXltLqMmj6O8CQgMBlMpVzJfBeLSxCIK+jwUUPK6Ncau9qTIWxiBel4VuO//a8CcAexfcVJAU3MH0Gcv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:23:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 07:23:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"sgzhang@google.com" <sgzhang@google.com>, "boolli@google.com"
	<boolli@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2 2/3] idpf: improve locking around
 idpf_vc_xn_push_free()
Thread-Topic: [PATCH iwl-net v2 2/3] idpf: improve locking around
 idpf_vc_xn_push_free()
Thread-Index: AQHct+VVMZFcw63sfkquPSLA/5lAh7W3BR0Q
Date: Fri, 20 Mar 2026 07:23:43 +0000
Message-ID: <IA3PR11MB8986DFB6D9882564D16C0ABBE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-3-emil.s.tantilov@intel.com>
In-Reply-To: <20260319211335.23236-3-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: cd8ba23c-725a-47f5-aa76-08de86519e04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: hsMq1bAA8cbZBQEwFnEuM6T49T3ZlDii0IvUfpf8H2w0/g7JxTStrhnxAiOZCQQAOLHMk7SnK9M/08l4Q0zToW0heiuPSNqs3puFeKG7vBbHK7pszoFMEOR+szpvsAfAiOtsDQc58++nUJaQu2Q71m7qQKwbBzUzo0xsNUa2P8BrpA6ioJcpT1vCGGwzFjnC56r8yxr80uuQFTzK40ftDV6PUv0zNtALFtLRZVwNBemDq6qucDDLjLMn6cMYETazvbnhf/kJrRHHmJ+fz0rTbG03IAsweV1C8KQ2h5GoJ7JuZLlYykGpTCPPVcph9FaVsE1h77AURWc7+73fV9qax90BLuqPfdxbjOe8/WF1IuI5G+gogUBeoeeW+noujX7V9VAQ7e2v26iQSL61h3evM/WHZrrG9dhKuXRSGOV6OHtABadQq+Q89HolbPXiOcqH7TaWv8AYssEyuzLMph49iY2aRvDzi3N7pceNXTOv86HsypYOlaSr5g6SwDIEFNmdmbXbsHlrNgnffZj40L1EsscWB5p+invM9iw+Iym90sWZAYcrxwXI037FzjyBw3I/34MFRBx9yrFm5z86HYxDXc27kjlRFLSQFPhV/PIolCXxTLbwJNQIYmBJ0Gw6AWtnHLfyRbNmMESR6UoYsCfR1uU+qSiBDsl4He2XawFw53gzmD4V2x8yNC910nOprHA5oLPi9j0V/irPoSb5GKhfRV1O/RiGnDIB6dq73LGwbR/C3+fIbOv7iLzp9Z+6J2zXuKnwN8/rLmP9ResKfNnJppTRlupkOgWBlFMyKpKJy1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wt5PFx6hOyw2qlQmqvlnA1pUlqDBOnoVHWI7k0z0yLVoROnL2sxXHiPgkDF?=
 =?us-ascii?Q?lFzXPK2vjnDOQDJpKiYbo0Nfxhksf6oFsVInQPLx5+sijRtkKhUJ6wFlUGyo?=
 =?us-ascii?Q?U64AlULV4Qk5JTbxDe4thsbS/6TXL1Nx4is9b9UokJuhIZKCzDWHMEDrCP8H?=
 =?us-ascii?Q?XM+moBYgAorcYWoO6EN0JQzOIwvM20aaDVPgDoNA6YjNMQD88U5VjZnrvTCQ?=
 =?us-ascii?Q?RyrSNWAuFa/JRiJNh49cE0n2WYNexjGY9SMHZ8lf95/UnUota7F8z131JKeC?=
 =?us-ascii?Q?E5qm0XJ0wWKjNp5GuDYsnXAfYjxELYPWTg5pt7l4HP1kiINo3zx4dMLOlcCq?=
 =?us-ascii?Q?i6hjbCeG+5c2k2aZaywzmbMStvF/G+C8aV6U7BAkH5a59/ZV9MQy4PWPiY4R?=
 =?us-ascii?Q?w1AbFUb4bpwSheHESpsc8nyAkOAvN+2G2mGEIlGLb4nrhYzFNSosLPtIZY5x?=
 =?us-ascii?Q?CZiTTpkEch8xY2Y+4Kz9ZQYxywN2Wn5HRq9UcsI6bWH0bX5rl7eiwvP7MjFx?=
 =?us-ascii?Q?1IRF8qFB1gcIWl/roOP0D7uWveVS2SeTJmeyAJesHb/LcRznCZCCtAjjfF8u?=
 =?us-ascii?Q?f9YcvldKD4j5NabBOaV7dw1ZayB5LrHeqgrLXsQo/m0QV8nqOQnuWNKJsOAt?=
 =?us-ascii?Q?WAenQk+rXQ6/hYHaZXIhgqJ/7+5vqkXMeFtb7lsx/oxNTjZzuGzForr1PqVg?=
 =?us-ascii?Q?bLa9F6/wOc6nNguZyf4wSzBI5Or9YGnCTyvAh3wGMFwSCWfhL78yq64s5SvV?=
 =?us-ascii?Q?mFA4Kqc+/9YHonqDF9lI2b23o1OGTxovDJIQXsVcd6I9fna7IDTtT93Xlt39?=
 =?us-ascii?Q?L6fnFMpqgWJANwQE7pAPySFAlqIyqJx0gkN6H7+MTQDXWuEHcUPQFUiZEIja?=
 =?us-ascii?Q?51T+AL10eXewKG2uJyTI06HzAsTIzLlg7395i7uSpoyf5+1QCSMWVVI5yk6v?=
 =?us-ascii?Q?f5DVLu0LFrgKnfc3EIabYzKyiL/jAGAStPVUUd8tIT5DJrvi2JWsS2RnoFfk?=
 =?us-ascii?Q?n4JNqFn5zB3VbrDzGNGvrx/fAGRe4v1pglLPCRmoXTuTxv9IU+QQqJQSyMey?=
 =?us-ascii?Q?HKF01M7IAVM7JnTBP5qDdQgJ3or42psI2hvjLLTRti/Zs/IzZ4NwXuKoRV1n?=
 =?us-ascii?Q?+PXWHdAXI/Hebk56QZ6TjDKiy7mbuECQTTyUhwIasD34EzY7cLo8i7IofizA?=
 =?us-ascii?Q?7D0bYPbHZR+q8ldf3u42ZPqCte0Qecim//JjRUWWpeVobCmJUiMF42Yx3dlD?=
 =?us-ascii?Q?0dshXREcdQ+vTRKCRVuShrcjG/Uyy3W4Fd9ukqxQ1UdjX4EPK6QuxmNHaSHO?=
 =?us-ascii?Q?Kv6Losvir8YmkiHlfOalEhrb2zPR7z7oTpsestQzC6BmdZDLjuKMNTsAtknk?=
 =?us-ascii?Q?Al9hWy4Af6+vHOkuBDeJ2wQhEWjrrIDpmZBbcVXpAUeQu1x3qBSEcXgy0RWU?=
 =?us-ascii?Q?wVKIzkBxZEiSnjSSRGJRSGeJo8kCwl9ToQ0CaMNVCuSA/Za7nc5OiP9nTFhy?=
 =?us-ascii?Q?2pPC5MarSxbe1pkuWYinqDJUuASlat3spxMdX5LmiwDgQVApjT3aFUSo50Jt?=
 =?us-ascii?Q?7ySeFXe939YFOp/9lwIak7iBOwECbtvI5T2C27AulgvQAxB/B108vi97IRyQ?=
 =?us-ascii?Q?4ufDQ0+yZ7XhrDRpA6CoOEmLCn4vnuoRlMTot6bqW13Tfae3+gTIKYReDB4v?=
 =?us-ascii?Q?LCfKFN+540jgZxADsnmVRPwBMWCP7v4+rUazLADrDLI+UPWUHJSq6wujSgjx?=
 =?us-ascii?Q?rS7Whyfjo+41XCUAaAAfMSmuTPe9Xrs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cbqTGWpgAQJmAWkMzZPJ4ZDu1od0xx4QKlelTBBDlAJf1P7Dx7T6npuKoPgiaAgN3IeS+wXuyIjCyXkd6k24Cnw0vEA5DheytcAl4C5sR0TD9DAtjPLMlUFcnsp8RFfrbjwYLaPnRGB/DeeS0n4xyjblH9juini9u39m7qENp3POQa4lY3Fvs5Frwy4dIgarEwTlKaj2Wck2GCYM9sdHnKxidi/K0iWopQAhkl4UAA8YNH81rP8g3In9+oh+u5x+N3f64qOHtctqLug4yM0fg4nnyZHvRoELFE9UermKilCGV+8dm9gR8TsfCgzfOcD3MMO+Qbme5ne+EWqBtWeWGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8ba23c-725a-47f5-aa76-08de86519e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 07:23:43.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSY2l10ufYDip9MnucyF3sXFuwlM6vJvFTnpcxsIW3gLv1ru/ROs0NDi9BBrO28BKUtv9eqD2+IDFpVv+Sj5sXwZRMZNVu+d33LR5vz+++Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227444-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2CBBD2D68E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Sent: Thursday, March 19, 2026 10:14 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bigeasy@linutronix.de; clrkwllms@kernel.org;
> rostedt@goodmis.org; linux-rt-devel@lists.linux.dev;
> sgzhang@google.com; boolli@google.com; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; stable@vger.kernel.org
> Subject: [PATCH iwl-net v2 2/3] idpf: improve locking around
> idpf_vc_xn_push_free()
>=20
> Protect the set_bit() operation for the free_xn bitmask in
> idpf_vc_xn_push_free(), to make the locking consistent with rest of
> the code and avoid potential races in that logic.
>=20
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Cc: stable@vger.kernel.org
> Reported-by: Ray Zhang <sgzhang@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 582e0c8e9dc0..fbd5a15b015c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -402,7 +402,9 @@ static void idpf_vc_xn_push_free(struct
> idpf_vc_xn_manager *vcxn_mngr,
>  				 struct idpf_vc_xn *xn)
>  {
>  	idpf_vc_xn_release_bufs(xn);
> +	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
>  	set_bit(xn->idx, vcxn_mngr->free_xn_bm);
> +	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
>  }
>=20
>  /**
> --
> 2.37.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

