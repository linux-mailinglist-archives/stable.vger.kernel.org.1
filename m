Return-Path: <stable+bounces-233215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKnXNQLrz2lF1wYAu9opvQ
	(envelope-from <stable+bounces-233215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937939665E
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB68030205FD
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE53CCFB2;
	Fri,  3 Apr 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/bA85jB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D793803D3;
	Fri,  3 Apr 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233458; cv=fail; b=giDfua16pdhFj+Fl5ES95fMUULH9pP2LtHrOvZd47YBiqdACJ9iEix3kJiH/qBuPR9Uf5tw30aYh4WE19Ke7S33E0Ff7zyZt+BvK6XUOzkxQV3QBoAEoaZonnXVa404R14t8QqcI6O8h0/6rpEKFsQtIicjjyeulUlMbtWnLcZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233458; c=relaxed/simple;
	bh=nBqcDVJ5Pq8urMbx8xntjnJzVSFVdU+I5ycrJIKuVT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJM3x7y+/tzC2mEzp6zIzL/lPax/KdxrdWVpRqVd9tHjhpHbzdHfbDuLSa1V6xlgiM3ZUKFdPiR/sOnZM+dj+/CtT2/fXn3c+eyQ4r5fdQ+GyOskLtto4FgZUtVBa4FITyIj8kioNVfLWzToEE6qKo/b4BkPyjJlaGV9eHvBd/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/bA85jB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775233457; x=1806769457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBqcDVJ5Pq8urMbx8xntjnJzVSFVdU+I5ycrJIKuVT4=;
  b=O/bA85jB1Tn1R5e+GcvuBlTnEFigxxA/lPzh8LY1hil5SD3F9T7Zen4V
   0bcQP1nJqgo+mFZvkKmEgrQtxBiJyNX2M73CgMiR4MrDVBETd8USrz90t
   p2Q2nfBOX4zM5IybH1COTzwbFUwUIrQo6T4Vv4oBoYRFspG7xW7g0RyYE
   ShfhvODD7w0NF855Y0M27IPzMkOCu6Xx7ni1LN6uC8I2zIBsbo3Ad1OPK
   7EHADBRsoEDKpTAlD8f+tFvPW+lQpmZW0yK2bzBEpr1G27rsNYTcNPOni
   LivQ/vUD/+Sa+lAYcg+UUq+lEj/TbCF4S9JSGPE3e1OWoEvGOP04g77Lg
   A==;
X-CSE-ConnectionGUID: /SbRQzN6RfO0ELIbOKqJog==
X-CSE-MsgGUID: /fCZsVoaQGGlvtLAzX85Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87684738"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87684738"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:16 -0700
X-CSE-ConnectionGUID: 6pLKoYjRQJ+1pFKftSNTZw==
X-CSE-MsgGUID: b2IZ8ppLTeW9WUpm2EgowQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227231894"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:24:14 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4S6d47/dluXQDfXq4alJ1fGlEeRzBkPqVPnu1QsP/auXMSeWNhlyOmG1imf2fD00523i/rP/0InY+VyJ/9aoVGmSIePbB7sLxjrmlsAxDiNLlfqEb+pU3nXryWTjnl1ZFDI5ktJFwO9DoL+m8SYqH5daXxlo3NOc2AnYY+HeN/QQ9QMKU7kE/pOc37mbWHlNLVbihbfavh9ggWXZo1lytYC3BeI+4D5b5vCeJh1cvKpElqb+S+otfHg5gVgNW3VkgdMhXKVq1lAGtwPuVrrooIjnJidBAR3J8aYsp1Aq+GUwjDg+DIi30fWhOL6bbfS5a7RivN898tbGBfroN8ZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CHheavHKBECvItmAa2TuSDB4dpE8+jl38D3KX2/lJw=;
 b=cqpMawUfUni9jv53T/1vkRCMV++yyUpWMq4ntpqPbW8uvfyEWHtrjcNMZXXAuJEWjYidMJoxhejpnrLI8kYm6arlPXOH4fXryFUz/yaP8y7Bhuh5TYoUWLiYxAUMu2hHzGSEbQH1+vrZ5z0ZhFKPlI0+jfCwLRA3f/i3ixBdZQFr9qwVTrouMcYSBU9tYeZeooXZm5i7bQCFy/ydxn1E6oAXn2hpLKhNIwqlBTfLBY0SK05y878qCxLALtzeoYrC7f/wbyIix6ZR2z1Yq+50Q623w1MWhO+Dnctwb8m4w+QHn2YyCBm7z0uZkrsVGvjoUM2VspUyCoTfS3Eve5w9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 16:24:12 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:24:12 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
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
Subject: RE: [PATCH iwl-net v2 1/3] idpf: fix PREEMPT_RT raw/bh spinlock
 nesting for async VC handling
Thread-Topic: [PATCH iwl-net v2 1/3] idpf: fix PREEMPT_RT raw/bh spinlock
 nesting for async VC handling
Thread-Index: AQHcuDpw2pStxnV7KkqaHI9lfE5HHbXNm0/Q
Date: Fri, 3 Apr 2026 16:24:11 +0000
Message-ID: <SJ1PR11MB6297E334735B0897444C35E59B5EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-2-emil.s.tantilov@intel.com>
 <IA3PR11MB8986B4C8A0E0BB5A14BD0400E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986B4C8A0E0BB5A14BD0400E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: 64cff7ad-8ee9-4796-7f68-08de919d70b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: kErNS02BzEnbDKPV1SHbB2vAXs5vce97zxc9wBAGs4haK66RQe6PBznGR+yGhPA7o+UfSeYl+aRiHuprZtd6BLFSnzj1RImxlpwcU8c2rgmq3QOzHeJzTTPg8JqX4qBD7DjfaMf6U7q4hVHXRwgErWSe/PwZE801pLAkj6rLz6UUeUNehawWgppv784M5gpIHCVC4ArGCDbchVHr1CRxEvgkf8MXwUd5CBbNfwcVdU+ctAiOQyX7PS8KuwPyww34YXr/pEt8xgPyJ84Fw0L+DJsFovwI7hIHvza3eVtvVoJ9nT7HfimsA6Cxn84R5K2LMfa6DGVg/7GDS5o4EHMPwR+9lpHJ4vNldf5n/PpQVpnO+wZ6wCkfxWXPmUbnbHaTZ0eFdVbtLH5Dx58tHKrkv2yqkPnAtpPIQCiijCGeu8i6zDplHQKaNworqOnpcwYB3oEp4fdBKW+/r6RNItqvFdl/B6EQcoUAMMGfRwybfIj6NsMAKN5rg/HeVm/2DVNjNwh8JmxkCzUmYoNPhhSBnkarzctAjLSNENsFxGwrzb6gTia2+soFBD6gdye9XlENJQG76s9e5D+B8NU9wKnw+DAWAQAa04bxk/NUqW2VjoaG1LREiiOQaqqcEK8ep16CiiAeA++RXSQitkMPn8+/tjFF2c1obhQxvzwrlZ1wzKB2/jdahHlC4IZFWwq3GfP3PZZKgzqQVYk76hzGR2Sj7ToXU2S2/iDztbRdU+Jc7esAk+ct6MfcFTW6jPAgJNkacS9UMt0N67nwQHR7dEoAU/0ea+l/mQBNePpgkHDvOaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fiUKzplIyHVgMPZTiYS0MMKSTBXNlxZ61q8cimSRy0KV9HfvwW1p/p3lW8n?=
 =?us-ascii?Q?WFUFm8vjVnvZGQij3dFzUgFq3UFJiWqKTaI5g3rC/Fxftw0QXGPJ2+EMN1gq?=
 =?us-ascii?Q?M3dksQ/7Oy078xVWIA8C8Py6GYbGbd/a6tLaQ/48n5e4uqVpURmKD5C0+NPF?=
 =?us-ascii?Q?S5W5j8NC5sA+caPgjawQiPgstFL2UAlzRejnk7nOcpD9mTrYUphWnedVpsx2?=
 =?us-ascii?Q?QI/phwlsCjV6B6Zoa1B6H9j44C/yrb1iJasu3fbNOixJX+JO5dLm/5waAhSf?=
 =?us-ascii?Q?oIZq210+Usz8YlWKaI+65Qp6dRBfVtfbs9fZphjieSipHQVmnUc5a61+VNoL?=
 =?us-ascii?Q?07HkGUBRJ3oDdTAnk4eP8Eryh1ITi6pcg3EAbZTBhHWzg/LDKv9m0F4SD0co?=
 =?us-ascii?Q?6kepTBZXsBNqhL1iQxcn3jJbNLkMRz9NZOfP3qFUm5DcHUwD+Pqpdsuugd+A?=
 =?us-ascii?Q?z5v5v9CALKawmRcQU6QadotZgZiJ+zmDJM7nwsO1MBJNhgby0ZZ1SKRd7j4i?=
 =?us-ascii?Q?jvUzfUG5WIbYRKNirCEMBlyt/t+1tUlFyoVqrQHgXhH5xi0VOlEgCt+iG0Or?=
 =?us-ascii?Q?OCz9Ut4LHWYXAjMxBZRqzPI7rGOi9MHIzkL9tIzKvjIQMciNbiNJ/orjlgjF?=
 =?us-ascii?Q?qQN85rUKmWWd6OZcjYDdGXmRvultqhaFUwObMQprbs3+N3NdChAMg2VHoU5Y?=
 =?us-ascii?Q?1c0Bpxoi3BqCuMwDsZPkOo7c2yJQIMkojIJB3pkPzAPWCSjlHmGFzsNT5SuW?=
 =?us-ascii?Q?+5I+PoUKW4Z1eZQGnQXUTOw5j6iYtLqmwzozSy/uidEQ4LfNQrsWCvfh/B+6?=
 =?us-ascii?Q?8RFzdDxtkkTJig6jwEmrcpoMSZ42YrAmfzspbEJZ8laYyf5rGoDUI9gKNCHt?=
 =?us-ascii?Q?CwrNwiQvFzRx0M2T59+nhspoc5tHv0rgg082rTJB28+bht5lgSiNTtAXKbMp?=
 =?us-ascii?Q?g84qb6ARQ80YKxgOCocqeYTsdEdhyi7XEZ2aYY3xGYBKPcNy4U7lyHlBIDQC?=
 =?us-ascii?Q?iJ3c8Cy+WfveULmjItfkwyowxYmCy1i938wzdDMHnrweTmCtGBQvDoKvqGGV?=
 =?us-ascii?Q?Hfe8/hCdTv+XCEJOeR8Oq9xipqN59lbKVZOMiiTGUTZLZt8nf/meExogTO4/?=
 =?us-ascii?Q?AP7btUP2Q9F47zAdDiSrPPVcifY8zdyjhslVV39ferSXhexB8Csifr5EoWgH?=
 =?us-ascii?Q?Y4VKZzPeTPejkRz7PVa4yMMZf6l18ogLoBpWg6RvIDp+vB/JXXVt/GP+r2gz?=
 =?us-ascii?Q?n6w1dq4JVkBl03xsSMbe6m3aO87lh01WBeR09HzTeq+X+zkaqraIR0K9tbCQ?=
 =?us-ascii?Q?KmVNnb0DNjcnE6vHMQTr5W6u/gNdvgv0TspXN5luaI3WS4pM3NJUZbOJArA3?=
 =?us-ascii?Q?W2iOaTmEE/T5xazGHyXRZHhvrIckwvRsmVmA8sulqyZNHHk6cpNLU7gkHC+2?=
 =?us-ascii?Q?mLi+5hTuxXMIT8QZIXIfTW9VppXig1SBo0gmILc636PiYorlGw3W9bOCNQiP?=
 =?us-ascii?Q?9pnnx0TSZ7vB3U3SEucRwv+eQpMeL9vFeBeh4+ueHHXIjcsYIJ0S3ExqypS0?=
 =?us-ascii?Q?6Is+D6vEPYFpwOHm4G5ov7wxNXw53GwHSS9W4cethBlhpBuBMCn2t8l0yOvj?=
 =?us-ascii?Q?oa35aw18JttUEGy41vtn0AouVI/pS5SW536Xl9RucmoA/jHSZxyvDmOLE2GR?=
 =?us-ascii?Q?LAkG+LRtB+pFOqZ0xvSzgK4IO2DRjgJ662s0+C+loXT9nMtykkhSZzF2dixb?=
 =?us-ascii?Q?0X6okntWtA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Di8StQoBv7Qxt73y+aS1o8soMwGInPuxRAh24xHISkwFThEdw8CzpkTw1UFJSLpQt/p4pfRXYpbeUBmXxcafu1bAivsXKMe6KOmQqq13c2AZA6Lq4/2Ocdx0bQU0bYd8jOqPBZ4nLaZzbfmcxatXavOjTqo0JtqYnZCi6xi1osQQnDjYBAbxNils7tznmhYv4IXuAjj6+4S4gfJWl2rOZiP/xUXA7ihMlRLwmh9OQpVPMG2r5y+LkZMd3DbrlgMznl/6/o9REgy2mRxRoV8lbYPsKxTDQFg62xKhkaQ1Zurp8SE/vG5Q73CwDCr+yDzbipZDyHshZ/z6tb269HF39g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cff7ad-8ee9-4796-7f68-08de919d70b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 16:24:12.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFAvgH0E92dxVi5H1itNai5VZUvbxIsg1SpPs4AcN005YF/2soiLxkgjJRLWtA0/urbCV2Zn5fnmyLo5i9h87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233215-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2937939665E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Friday, March 20, 2026 12:23 AM
> To: Tantilov, Emil S <emil.s.tantilov@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bigeasy@linutronix.de; clrkwllms@kernel.org;
> rostedt@goodmis.org; linux-rt-devel@lists.linux.dev; sgzhang@google.com;
> boolli@google.com; stable@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/3] idpf: fix PREEMPT_R=
T
> raw/bh spinlock nesting for async VC handling
>=20
>=20
>=20
> > -----Original Message-----
> > From: Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Sent: Thursday, March 19, 2026 10:14 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; bigeasy@linutronix.de; clrkwllms@kernel.org;
> > rostedt@goodmis.org; linux-rt-devel@lists.linux.dev;
> > sgzhang@google.com; boolli@google.com; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; stable@vger.kernel.org
> > Subject: [PATCH iwl-net v2 1/3] idpf: fix PREEMPT_RT raw/bh spinlock
> > nesting for async VC handling
> >
> > Switch from using the completion's raw spinlock to a local lock in the
> > idpf_vc_xn struct. The conversion is safe because complete/_all() are
> > called outside the lock and there is no reason to share the completion
> > lock in the current logic. This avoids invalid wait context reported
> > by the kernel due to the async handler taking BH spinlock:
> >
> > [  805.726977] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [  805.726991] [ BUG:
> > Invalid wait context ]
> > [  805.727006] 7.0.0-rc2-net-devq-031026+ #28 Tainted: G S         OE
> > [  805.727026] ----------------------------- [  805.727038]
> > kworker/u261:0/572 is trying to lock:
> > [  805.727051] ff190da6a8dbb6a0 (&vport_config-
> > >mac_filter_list_lock){+...}-{3:3}, at:
> > idpf_mac_filter_async_handler+0xe9/0x260 [idpf] [  805.727099] other
> > info that might help us debug this:
> > [  805.727111] context-{5:5}
> > [  805.727119] 3 locks held by kworker/u261:0/572:
> > [  805.727132]  #0: ff190da6db3e6148 ((wq_completion)idpf-
> > 0000:83:00.0-mbx){+.+.}-{0:0}, at: process_one_work+0x4b5/0x730 [
> > 805.727163]  #1: ff3c6f0a6131fe50 ((work_completion)(&(&adapter-
> > >mbx_task)->work)){+.+.}-{0:0}, at: process_one_work+0x1e5/0x730 [
> > 805.727191]  #2: ff190da765190020 (&x->wait#34){+.+.}-{2:2}, at:
> > idpf_recv_mb_msg+0xc8/0x710 [idpf] [  805.727218] stack backtrace:
> > ...
> > [  805.727238] Workqueue: idpf-0000:83:00.0-mbx idpf_mbx_task [idpf] [
> > 805.727247] Call Trace:
> > [  805.727249]  <TASK>
> > [  805.727251]  dump_stack_lvl+0x77/0xb0 [  805.727259]
> > __lock_acquire+0xb3b/0x2290 [  805.727268]  ?
> > __irq_work_queue_local+0x59/0x130 [  805.727275]
> > lock_acquire+0xc6/0x2f0 [  805.727277]  ?
> > idpf_mac_filter_async_handler+0xe9/0x260 [idpf] [  805.727284]  ?
> > _printk+0x5b/0x80 [  805.727290]  _raw_spin_lock_bh+0x38/0x50 [
> > 805.727298]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf] [
> > 805.727303]  idpf_mac_filter_async_handler+0xe9/0x260 [idpf] [
> > 805.727310]  idpf_recv_mb_msg+0x1c8/0x710 [idpf] [  805.727317]
> > process_one_work+0x226/0x730 [  805.727322]
> worker_thread+0x19e/0x340
> > [  805.727325]  ? __pfx_worker_thread+0x10/0x10 [  805.727328]
> > kthread+0xf4/0x130 [  805.727333]  ? __pfx_kthread+0x10/0x10 [
> > 805.727336]  ret_from_fork+0x32c/0x410 [  805.727345]  ?
> > __pfx_kthread+0x10/0x10 [  805.727347]  ret_from_fork_asm+0x1a/0x30 [
> > 805.727354]  </TASK>
> >
> > Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Ray Zhang <sgzhang@google.com>
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 14 +++++---------
> > drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |  5 +++--
> >  2 files changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index 113ecfc16dd7..582e0c8e9dc0 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -287,26 +287,21 @@ int idpf_send_mb_msg(struct idpf_adapter
> > *adapter, struct idpf_ctlq_info *asq,
> >  	return err;
> >  }
> >
> > -/* API for virtchnl "transaction" support ("xn" for short).
> > - *
> > - * We are reusing the completion lock to serialize the accesses to
> > the
> > - * transaction state for simplicity, but it could be its own separate
> > synchro
> > - * as well. For now, this API is only used from within a workqueue
> > context;
> > - * raw_spin_lock() is enough.
> > - */
> > +/* API for virtchnl "transaction" support ("xn" for short). */
> > +
> >  /**
> >   * idpf_vc_xn_lock - Request exclusive access to vc transaction
> >   * @xn: struct idpf_vc_xn* to access
> >   */
> >  #define idpf_vc_xn_lock(xn)			\
> > -	raw_spin_lock(&(xn)->completed.wait.lock)
> > +	spin_lock(&(xn)->lock)
> >
> >  /**
> >   * idpf_vc_xn_unlock - Release exclusive access to vc transaction
> >   * @xn: struct idpf_vc_xn* to access
> >   */
> >  #define idpf_vc_xn_unlock(xn)		\
> > -	raw_spin_unlock(&(xn)->completed.wait.lock)
> > +	spin_unlock(&(xn)->lock)
> >
> >  /**
> >   * idpf_vc_xn_release_bufs - Release reference to reply buffer(s) and
> > @@ -338,6 +333,7 @@ static void idpf_vc_xn_init(struct
> > idpf_vc_xn_manager *vcxn_mngr)
> >  		xn->state =3D IDPF_VC_XN_IDLE;
> >  		xn->idx =3D i;
> >  		idpf_vc_xn_release_bufs(xn);
> > +		spin_lock_init(&xn->lock);
> >  		init_completion(&xn->completed);
> >  	}
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > index fe065911ad5a..6876e3ed9d1b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > @@ -42,8 +42,8 @@ typedef int (*async_vc_cb) (struct idpf_adapter *,
> > struct idpf_vc_xn *,
> >   * struct idpf_vc_xn - Data structure representing virtchnl
> > transactions
> >   * @completed: virtchnl event loop uses that to signal when a reply
> > is
> >   *	       available, uses kernel completion API
> > - * @state: virtchnl event loop stores the data below, protected by
> > the
> > - *	   completion's lock.
> > + * @lock: protects the transaction state fields below
> > + * @state: virtchnl event loop stores the data below, protected by
> > + @lock
> >   * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it
> > will be
> >   *	      truncated on its way to the receiver thread according to
> >   *	      reply_buf.iov_len.
> > @@ -58,6 +58,7 @@ typedef int (*async_vc_cb) (struct idpf_adapter *,
> > struct idpf_vc_xn *,
> >   */
> >  struct idpf_vc_xn {
> >  	struct completion completed;
> > +	spinlock_t lock;
> >  	enum idpf_vc_xn_state state;
> >  	size_t reply_sz;
> >  	struct kvec reply;
> > --
> > 2.37.3
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>


