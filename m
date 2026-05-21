Return-Path: <stable+bounces-253627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOgEIltUD2raJAYAu9opvQ
	(envelope-from <stable+bounces-253627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:52:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA15AB448
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E73C5304105F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D537CD34;
	Thu, 21 May 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P92Z6alq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF753905F8
	for <stable@vger.kernel.org>; Thu, 21 May 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387914; cv=fail; b=nTvI2euORk3vErQa/LqgxWsVxeSZ7Q2ocGLwt1JY2Ya/sFDJalhQIh9DpYKD+b05KnAJctRXJizN+ZbhPhvlZX8wXCcyVTrtZ3a75PfItyu0yL8ZGAwdYJDzknlAnSv3u1a672uYQucmMpIN4+d8sDpjDdBwMH4RvPAQ02vApUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387914; c=relaxed/simple;
	bh=BhwHRhmB0+Qx6ADIRUo6vcHks2ynceBd50R1NO1m6NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IACZN/OHN0MVMTB40RFZsVVc6l4b5eCnMe7RMO+NBTRT4UuLocYv88TZdrTIoiwZiDHvvWWAR6kUmx6AKsxYmnQYUCZleeYVOC0qjEpevOu+4WHRAhrpa9RRQ2y9jl+Nwr4U/ib6dkG4x0FDvTBtZelxOZi6XOAijtXuz69vBrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P92Z6alq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779387910; x=1810923910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BhwHRhmB0+Qx6ADIRUo6vcHks2ynceBd50R1NO1m6NA=;
  b=P92Z6alqVRAqHxSD3mzAHNv25jjiZyQ1NF6PEWQEbMkV+FwY8ddEEu4S
   8dLqeg70UHz9GeQ/mbvM7eBvksMOi8IxtTALff+caI+Ro7gzyiubPDAke
   b64SalZ+WoeOPwf+5igaXt+W7AKjp0NNMcvVQGSnaXnpEuwgsVq3oaEFl
   xbyPgJCNI+Rw5ekY6Qm7PocSpygkHNoYmosrClqJJ5SQpfvTYwEh7arYO
   INFyMY35phohAKoB2bBJK/k+Qsy2p5yY3xzwjOHO7ANqtI/k/3JUEr3UB
   8wkUwJMgYciLhcoyTMIcdz8nnuH3+1j1KSGhlNlTTdNipJPVlaXOsjfIW
   A==;
X-CSE-ConnectionGUID: JCwqGd4fR0uVNiZskJGPUg==
X-CSE-MsgGUID: J8VVq9MSRsGOmpsmviMa3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80295534"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="80295534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 11:25:09 -0700
X-CSE-ConnectionGUID: wvUihVTOTn2LXJSwCftuYg==
X-CSE-MsgGUID: tOJbyH+yRi+zN0+0sHk5Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="240832568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 11:25:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:25:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 11:25:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN+N1D6EQmEnYQkGB9nb7dN+QwmxeYBs0m6S2sNGGlZxEJDv9dvQNl+wdmYb7F4ya0fvcvVy83ALJz9nsxBHy3wDWgAneRJzEsQ/rZjHGrArZ1FUmqTAo/1K9oFVIeu3fbjYmFLjwgEF1R0elTjpAimItuVEeW/QTxK4/ctarYNhas2h/6TjOh0+9VM7imhhma5U4RAfOhnWl1cszdouqhFnylW4qsupHt6eg8yqy03/DVaICLZI7qrFrdTyxMkcZ3YYqYpRPWX0KR3z3etWuE/T/Y0cBJl1fZt0tC8Q+OwyBpIfOyNu4lJwUCM/ErAn3gcOO16423ADlmmTERAoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhwHRhmB0+Qx6ADIRUo6vcHks2ynceBd50R1NO1m6NA=;
 b=UmJDI7MsH5CqBHpdRSEK+eADEy7qZOZECd/Cppg9A0cc6XVkuGHcem0lnSG/A+L1UD/XkMZZf6gpzFnHhGnsVUW1/BSka5UHrn1FKRHlHng54HhvQTYOjn35j8Zez8g6K80bTE44fuM4u47LhICEi71EvmOvzOHQbQ8nAQd6DKrMqF9SDzEy5FwiZV0uij1BLV6EvGlWcX+I779xc/S7SN0PlMZib4qsNb2D2Tb6K1PtTJ/1ZSC0Xe0GDeyQ1QRnN4ilublcT+m6EgLu7Qsc30p5WotQyODgBzQgX15xpVHt3LDR/uLxjVdItfe7NawDCbZ9aVPM1wnpZ+/52176BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 18:24:03 +0000
Received: from SA1PR11MB8839.namprd11.prod.outlook.com
 ([fe80::d917:ef8:5e20:14f3]) by SA1PR11MB8839.namprd11.prod.outlook.com
 ([fe80::d917:ef8:5e20:14f3%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 18:24:03 +0000
From: "Nguyen, Brian3" <brian3.nguyen@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Bai, Zongyao"
	<zongyao.bai@intel.com>
Subject: RE: [PATCH] drm/xe: Use PDE mask for 2M page reclaim entries
Thread-Topic: [PATCH] drm/xe: Use PDE mask for 2M page reclaim entries
Thread-Index: AQHc6LNdBvIKrSE5hkGXdUHCgbIherYYtyEAgAAM12A=
Date: Thu, 21 May 2026 18:24:02 +0000
Message-ID: <SA1PR11MB88399A3ADE2048137AF1ED61AA0E2@SA1PR11MB8839.namprd11.prod.outlook.com>
References: <20260520234946.1055572-2-brian3.nguyen@intel.com>
 <2ffc43e3-560e-406a-9bb6-5dde24b1f897@intel.com>
In-Reply-To: <2ffc43e3-560e-406a-9bb6-5dde24b1f897@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8839:EE_|SN7PR11MB6557:EE_
x-ms-office365-filtering-correlation-id: c44edfeb-0078-456a-e60d-08deb76622c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006|4143699003|3023799007|38070700021;
x-microsoft-antispam-message-info: zbU38m05SSfirZGc6MX+Ik8OS35Ie7zIk+NNMIYIOyLqgCmWc8qQ23pZa3XKmTck5YvDUTmlBEX/STipkufYARNLd5JiJMyNq/IozrHM7mDB68XK4JiSH0uyXvmp9ATDpk5NJ42LXyPugYwDIIKsjQEalDKqZFkGCINc6qUxMnLj3M4Z9KnUXfrz5DUUgO+KqF7Qaih8nvSiMvAUOTRqcG92D19pMnKTLwlrLvS3nWaYGBYM31KUtj0xhpP3Lq0Wa1Gm8Hh6avocjE93RP+Sk4kslEsOkOSwW+Wu60+Gtwj0kKFgW+fStwkpUGiyAiT90ihPk+JGJNueAluPmCIBWnoDa3QnHpns0hs+n65nZVTo5Mtbd5p2eesUVofUyR83LnIe2yf3q32kOHBoYyPNJ+I0+Z0OtOZVlDOQIRKLTIliTCguGU0n9vTEp6PJCkTq6EF2S4ur+4T3LpveE+Y5ETxaDz3cXbvybMtRjuvDdG+4H6dd1GCOIjzVVxw51JBT+fOgSN/evRpeKBi8MsfEtBP3b76/wOjGydMgnD1K13uuXb0u7wFF+I7EsMIzzS/lEPEiFrvDDZuVQXBfWu4NP16nRjDgyYQ6ke1IMZ7c8YBrEsAbQifA6OjwQc8qlWmCd1JKwitDeZnjX8ilWOiTSBLpyWr74ufVdgTknwEhI1k/3f6gAvZcdlMdiV81NkRfmSbs1EvonK53LJSzE2tDyFeXwngDl9Xx+/WVebfbF5FyRrUYvmA74e5aQ4bvn8FV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThSdXh1WU13bzc4NVA3SGRqc1JvTWRSZ1h1YlVEeVk2MHIzY09lVEtmWHkx?=
 =?utf-8?B?Um52Q2RPak5uSmUxaEt4bGVSTFFLNnA5dXcrOUlSUXRyRjdxaVljM2R0MjZO?=
 =?utf-8?B?YmpwK2xFTDZ0NmMrWTlTb1FMVlJmaE5GUEorYkVUUmlrOWxjV2pVQ0VIcjRH?=
 =?utf-8?B?bmlWd1JHQlQ1RUtEd2JYb2xuK0dEWXZNQldHTVdkZ1ZUbVZjQXpwQU1ycUlq?=
 =?utf-8?B?anJBdml4bnEyNk1HZXlKYkkvekI4bVEyZVhjMUhscTBIQTk5K2lYZ050V2hQ?=
 =?utf-8?B?NExpMzBkTU55M0ZaZGxwM2NYNno4cHJCL3RvODh2K0xDR2ZsdHFHeEk0czFI?=
 =?utf-8?B?NVVEVFlmLzRoRU90TlFURE94TVNDSUtpYXNTcDN5dkN0dytCQjJBVUduYTlM?=
 =?utf-8?B?ems2SFhnak9aM1BQSzJoMkdrcEF2NFhGaXZ5dlkyaDgzaXJlYkFMRVhxQzVm?=
 =?utf-8?B?RTBTS05oaFNhTmNYTDI4NUFESE84bjRMY1ovRFROeUErL3RmbFROT0F1bXov?=
 =?utf-8?B?dmhlOVFYOWRtY0xOR1I5N3QyQ0VST0lOOVpKRkU1Vk9RQnF1QndpQ3F0MGRQ?=
 =?utf-8?B?TndkTldNeVdIOXY0ZmRZUWRGS21EenhFMnFiY2I2bnlWM2h3cXhWRXFreFJQ?=
 =?utf-8?B?S3dxVDdyUUpERCs1OElOUDN0VE0rTkxmTGo5Zk1wNWViTExzY2VtdGRESk5s?=
 =?utf-8?B?OGo5L3pWZFJndHZmUXRSL3RPb2hwWStja3B1TTVLa093MVBpS1htcWVoRUJn?=
 =?utf-8?B?bDJxT3BJeXFFOTJIZEU3MTltUVBIM29IT24rZnNQaDNadFg4VkdKTGpNamZI?=
 =?utf-8?B?Wm5abHl1YzU5RW1TSFlzbEs5VjFlS1UrckhubE5kcGtlQkZ0VlVyK1J4aDFP?=
 =?utf-8?B?My84dUc1YUFGOXUwU3VER3o0bGk3ZlR6NUsrTHhwSUhhcmZva0VPR21sWC9J?=
 =?utf-8?B?MHZzcGwyNVJ4YzJodnFDL1pLTHdUNkhLZE03SGN5eUVJb0Z1S3NkRmd4Zjda?=
 =?utf-8?B?Vzk3N0RiclFIdmtjczJyejBuYlBmMDduOEMyekNMMytwVjQyOXFKdHRXRFJj?=
 =?utf-8?B?bE52RW5wWkZhR1lweUkzUzFBR0RDcjYvU1YrTUtta2FPYWZhTGY1Y1BZWWNN?=
 =?utf-8?B?bEdialpIV2xZL21JRzZIK3V4bDRtOUpmNHF6em9mZm5SRC8wWFc5RzcydzBQ?=
 =?utf-8?B?RTgrUDJ6WSticjdodHkzVUluZkFtZ096V2dIKzBPTlRnK0x5TGtCelM5elpk?=
 =?utf-8?B?SVczdlErM0YvNXJQZDRhN0llNFZmVkNKOFNBcEk4a0dxdU04eEgxM2VRVDJO?=
 =?utf-8?B?b2UwbVZ1eTN5SVo2MjNKbjV3ZGNiejFSZTBVSzdXTitFQ2Z1YjFkOElCbnBo?=
 =?utf-8?B?VjZLSDl2WWR6TU9rZ2I5SjBNakF4bE1YUm1yOG9EV0VvVytzL0wyeGdCUC95?=
 =?utf-8?B?WU1aWWRIaVpaSmc2WGR3N1hiVEJTd0RqSVM4SG5yMWplSitCUGs2dk84YlEw?=
 =?utf-8?B?WGtlL2luNjM0UFV6a1NyWW0rdDRWQzVGb2NmTUNuNGFpcnFhazdNMVd4ak1p?=
 =?utf-8?B?KzV4c0VuUGs2VU9mZ0t4ZXZGcXBRb05ZaVdoT0p1UFdYYW44YW12bDZRTzNr?=
 =?utf-8?B?RExMTFR5U2FJclJZYjlZU3lab05xaGFnRHBQbHRPUTRTa0FoVFBXMGFRODVM?=
 =?utf-8?B?OXkwRzVYK3ZDR05VU241NzBXVHZMVTdTL09DT1hhWmZrQUZZZ3RaeklwaFBp?=
 =?utf-8?B?dWxZUmRDNkY1Mlo3QWJ1K3Z3ZGV6NDBoNnJEY0dQbDY2Y0hFeHkreVlEZUVZ?=
 =?utf-8?B?MkpGQTIyOU8wdytXMEVpYVZtK0ZVUUNKcWRPS01zWmVkOEJUWkQvWGJoQ0dR?=
 =?utf-8?B?eThwT0hoMHNnRjdZM2xXUDl3bnZhSWE3MCt3UlR2eHc5UlplOG1vM2hyTU1w?=
 =?utf-8?B?c0w1WnZoS2hRRmtGVU1OcVFESWZYTVdRTXowdjFWMnBEMDFjRDhPMTkxanNo?=
 =?utf-8?B?VG9UbmpMSFpNWHVHZWl2UnhybmhvQWIwQm4wQUZiNTJ1VGtTYVBqZ205YUly?=
 =?utf-8?B?L3BlVE1HMElOM0JIbzhKZjY2MEg3ZUdEVWVqQjNDUnc0NjY0VTMzM2s1RE1z?=
 =?utf-8?B?d1BzSzVWd0U1Ym5DTll3ZmNhRmpMQy9YQmhQeHBEK3hlK1hHT3d2eXNtamNN?=
 =?utf-8?B?N0o0SnVEdy92VGNYNzNIWDZ1VHNVWjNDM3JNQXd6OEZYSWJmekhEQUFYOEF4?=
 =?utf-8?B?MkZTRXZ0RzVYQ3Bxd0JkQ1hUWERSb3VpUy9GNDlxc2hPblg1UFgzZDFqay84?=
 =?utf-8?B?Zmdydms2MzE4eUJJbGZXdkRWeEkxT0l1MVFhTnYyZGkyOVRkUnBwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ngidXFy1nM6CQE26GzZgtllICPxSeIkI+0ZNq+jbIHXYdCZj6gTK8kUqGlz4libWWJ7eZ2YEXALY3z391Q4KlmfhPmDvpPnCjAtJOW0uQlKOBjD4srXOaYiLOEBCwaGFXoH4goLeSF1NBBTsXM9cm2cbFab+pLSrgVJswYakzQ3tH7rVuGmBAMTWN1VNYV6xkgHRICRagIKPRz6h4NfcF+bWKjMU6ctnicUsbgaj+n21TuB+2ZgHqbleAumcyDYviuCnJJP+aMFASYzGyQQ7ugQod78CPIhDGdOvrMGqFJ67IK9de8DZf4b8bse7mmMwevQdi6tn/JlTGQdg7/lrng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44edfeb-0078-456a-e60d-08deb76622c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 18:24:03.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRapt1FOKkgkBZyyr86bCKpDWKxnATjdyF1l6FM73FaGWodI9o0cst/VY0euS4yajEnJ24ivtf0qdV5QNwB+1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253627-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brian3.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 45BA15AB448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1cnNkYXksIE1heSAyMSwgMjAyNiwgTWF0dGhldyBBdWxkIHdyb3RlOg0KPiBPbiAyMS8w
NS8yMDI2IDAwOjQ5LCBCcmlhbiBOZ3V5ZW4gd3JvdGU6DQo+ID4gMk0gcGFnZXMgdXNlIFBERSBl
bmNvZGluZyB3aGVyZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBvY2N1cGllcyBiaXRzIFs1MToyMV0s
DQo+ID4gYnV0IGdlbmVyYXRlX3JlY2xhaW1fZW50cnkoKSB1c2VzIFhFX1BURV9BRERSX01BU0sg
KGJpdHMgWzUxOjEyXSkgZm9yIGFsbA0KPiA+IGxlYWYgZW50cmllcy4gQWRkIFhFX1BERV9BRERS
X01BU0sgYW5kIHNlbGVjdCB0aGUgY29ycmVjdCBtYXNrIGJhc2VkIG9uDQo+ID4gd2hldGhlciB0
aGUgZW50cnkgaXMgYSAyTSBQREUuDQo+IA0KPiBBcmUgeW91IG5vdCBhbHNvIG1pc3NpbmcgdGhl
IFBERSA2NEsgaGFuZGxpbmc/IEFGQUNUIHRoZXJlIGlzIG9ubHkgUFM2ND8NCj4gRG9lcyBpdCBu
b3QgaW5jb3JyZWN0bHkgdHJlYXQgaXQgYXMgNEs/IFdpdGggUERFIDY0SyB0aGUgcHQgaXNfY29t
cGFjdCwNCj4gSUlSQyBzbyB5b3UgaGF2ZSBsaWtlIDMyIGVudHJpZXMgZm9yIHRoZSBlbnRpcmUg
dGhpbmcsIHdoaWNoIGVhY2ggZW50cnkNCj4gYmVpbmcgNjRLLiBTbyBJIHRoaW5rIGhlcmUgeW91
IGFyZSBvbmx5IHJlY2xhbWluZyA0SyBmcm9tIGVhY2ggZW50cnk/IEkNCj4gbWlnaHQgaGF2ZSBt
aXNzZWQgc29tZXRoaW5nIHRob3VnaC4NCj4gDQoNCkFyZ2gsIG15IGJhZC4gTGV0IG1lIHRha2Ug
YW5vdGhlciBsb29rIGF0IHRoZSA2NEsgcGFnZXMuDQpJIGRpc3JlZ2FyZGVkIGFsbCB0aGUgaXNf
Y29tcGFjdCBsb2dpYyBvbiBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbi4uLg0KDQpMb29raW5nIGJh
Y2sgYXQgdGhlIDY0SyBwYWdlIGFzIHdlbGwsIHdpbGwgYWxzbyBuZWVkIHRvIGFkZCBhbm90aGVy
DQo2NEsgQUREUl9NQVNLIHdpdGggYml0cyBbNTE6MTZdIHdpdGggYWxsIHRoYXQgY29ycmVzcG9u
ZGluZyBsb2dpYywNCnNpbmNlIHRoZXJlIGFyZSByZXNlcnZlZCBiaXRzIGZvciA2NEsgbGVhZiBo
ZXJlLg0KDQpCcmlhbg0KDQo+ID4NCj4gPiBGaXhlczogODNiOTE0Zjk3MmJiICgiZHJtL3hlOiBG
aXggcGFnZSByZWNsYWltIGVudHJ5IGhhbmRsaW5nIGZvciBsYXJnZSBwYWdlcyIpDQo+ID4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWdnZXN0ZWQtYnk6IFpvbmd5YW8gQmFpIDx6
b25neWFvLmJhaUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gTmd1eWVuIDxi
cmlhbjMubmd1eWVuQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS94
ZS9yZWdzL3hlX2d0dF9kZWZzLmggfCAxICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9w
dC5jICAgICAgICAgICAgfCA4ICsrKysrKy0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0veGUvcmVncy94ZV9ndHRfZGVmcy5oIGIvZHJpdmVycy9ncHUvZHJtL3hlL3JlZ3Mv
eGVfZ3R0X2RlZnMuaA0KPiA+IGluZGV4IDRkODM0NjFlNTM4Yi4uMjJhNmMxOTdlZDk2IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS9yZWdzL3hlX2d0dF9kZWZzLmgNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0veGUvcmVncy94ZV9ndHRfZGVmcy5oDQo+ID4gQEAgLTEwLDYg
KzEwLDcgQEANCj4gPiAgICNkZWZpbmUgWEVMUEdfR0dUVF9QVEVfUEFUMQlCSVRfVUxMKDUzKQ0K
PiA+DQo+ID4gICAjZGVmaW5lIFhFX1BURV9BRERSX01BU0sJR0VOTUFTS19VTEwoNTEsIDEyKQ0K
PiA+ICsjZGVmaW5lIFhFX1BERV9BRERSX01BU0sJR0VOTUFTS19VTEwoNTEsIDIxKQ0KPiA+ICAg
I2RlZmluZSBHR1RUX1BURV9WRklECQlHRU5NQVNLX1VMTCgxMSwgMikNCj4gPg0KPiA+ICAgI2Rl
ZmluZSBHVUNfR0dUVF9UT1AJCTB4RkVFMDAwMDANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX3B0LmMgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfcHQuYw0KPiA+IGluZGV4
IDI2NjlmZjVlZTc0Ny4uYWU1ZWQwMzcwZDcyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS94ZS94ZV9wdC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3B0LmMNCj4g
PiBAQCAtMTYxNSw3ICsxNjE1LDExIEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfcmVjbGFpbV9lbnRy
eShzdHJ1Y3QgeGVfdGlsZSAqdGlsZSwNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgeGVfZ3QgKmd0
ID0gdGlsZS0+cHJpbWFyeV9ndDsNCj4gPiAgIAlzdHJ1Y3QgeGVfZ3VjX3BhZ2VfcmVjbGFpbV9l
bnRyeSAqcmVjbGFpbV9lbnRyaWVzID0gcHJsLT5lbnRyaWVzOw0KPiA+IC0JdTY0IHBoeXNfYWRk
ciA9IHB0ZSAmIFhFX1BURV9BRERSX01BU0s7DQo+ID4gKwlib29sIGlzXzJtID0geGVfY2hpbGQt
PmxldmVsID09IDEgJiYgKHB0ZSAmIFhFX1BERV9QU18yTSk7DQo+ID4gKwkvKiAyTSBwYWdlcyBh
cmUgZW5jb2RlZCBhcyBQREVzLCBvdGhlciByZWNsYWltYWJsZSBwYWdlcyB1c2UgUFRFIGVuY29k
aW5nICovDQo+ID4gKwl1NjQgYWRkcl9tYXNrID0gaXNfMm0gPyBYRV9QREVfQUREUl9NQVNLIDog
WEVfUFRFX0FERFJfTUFTSzsNCj4gPiArCXU2NCBwaHlzX2FkZHIgPSBwdGUgJiBhZGRyX21hc2s7
DQo+ID4gKwkvKiBQYWdlIGFkZHJlc3MgaXMgcmVsYXRpdmUgdG8gNEsgcGFnZSByZWdhcmRsZXNz
IG9mIGVudHJ5IGxldmVsICovDQo+ID4gICAJdTY0IHBoeXNfcGFnZSA9IHBoeXNfYWRkciA+PiBY
RV9QVEVfU0hJRlQ7DQo+ID4gICAJaW50IG51bV9lbnRyaWVzID0gcHJsLT5udW1fZW50cmllczsN
Cj4gPiAgIAl1MzIgcmVjbGFtYXRpb25fc2l6ZTsNCj4gPiBAQCAtMTY0MSw3ICsxNjQ1LDcgQEAg
c3RhdGljIGludCBnZW5lcmF0ZV9yZWNsYWltX2VudHJ5KHN0cnVjdCB4ZV90aWxlICp0aWxlLA0K
PiA+ICAgCQl4ZV9ndF9zdGF0c19pbmNyKGd0LCBYRV9HVF9TVEFUU19JRF9QUkxfNjRLX0VOVFJZ
X0NPVU5ULCAxKTsNCj4gPiAgIAkJcmVjbGFtYXRpb25fc2l6ZSA9IENPTVBVVEVfUkVDTEFJTV9B
RERSRVNTX01BU0soU1pfNjRLKTsgLyogcmVjbGFtYXRpb25fc2l6ZSA9IDQgKi8NCj4gPiAgIAkJ
eGVfdGlsZV9hc3NlcnQodGlsZSwgcGh5c19hZGRyICUgU1pfNjRLID09IDApOw0KPiA+IC0JfSBl
bHNlIGlmICh4ZV9jaGlsZC0+bGV2ZWwgPT0gMSAmJiBwdGUgJiBYRV9QREVfUFNfMk0pIHsNCj4g
PiArCX0gZWxzZSBpZiAoaXNfMm0pIHsNCj4gPiAgIAkJeGVfZ3Rfc3RhdHNfaW5jcihndCwgWEVf
R1RfU1RBVFNfSURfUFJMXzJNX0VOVFJZX0NPVU5ULCAxKTsNCj4gPiAgIAkJcmVjbGFtYXRpb25f
c2l6ZSA9IENPTVBVVEVfUkVDTEFJTV9BRERSRVNTX01BU0soU1pfMk0pOyAgLyogcmVjbGFtYXRp
b25fc2l6ZSA9IDkgKi8NCj4gPiAgIAkJeGVfdGlsZV9hc3NlcnQodGlsZSwgcGh5c19hZGRyICUg
U1pfMk0gPT0gMCk7DQoNCg==

