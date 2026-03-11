Return-Path: <stable+bounces-224744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGOuAVSzsWnbEgAAu9opvQ
	(envelope-from <stable+bounces-224744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:24:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8F26887E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8A33170666
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B529342530;
	Wed, 11 Mar 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTjNK84E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75953E867A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253375; cv=fail; b=RH28rf5iSRKk4Y8g2FgoNgrqxjJxhmx6dNaFXnvJXPNUArOUFwixiRrAvrQKE4d7NXAL8I9JDzZMYO0cXapTys6Yx9PNEnPLd5GWKYohxYcg7QkB+q4Rgu2uPuXQ7JbrOH1VM/pX724fDcrgzYUSK67ef9HNVF/e84G87jQ5lm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253375; c=relaxed/simple;
	bh=fnvCwdDVew2zAJ0XP2gbSK6Mr19c3srNtIT8H9njeig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sG8EzPkiwcCToq6tB4oVUKu/UNvUPWEhLuga2wWiN69Uu6Wizcr/YKPlVySFsNvJzEursI5iPSgLzEonWGzLIOf+jDfKx2TS5WBxnahLHNdo8ltqd79vVWgH1e8CsxnWWep6EiXiboGH65wCRAXrlEEufFVGqJAc1jFZt8rt+vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTjNK84E; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773253373; x=1804789373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fnvCwdDVew2zAJ0XP2gbSK6Mr19c3srNtIT8H9njeig=;
  b=LTjNK84EsGQE8OKnIZi1Yk51hLnsD5Hl7WXalE0F24ic/Cwe8KkYZ+r/
   slYVz3DP3LeLMmPGfTh/k3Hu2dIqxyKbTdo81Zo5+cQakJlGKMdyhO4Us
   nTU7JOcM2ueXAlgZ1nzc/Wq5ylH/FtcNkGrvlYHGjzxjg/E8hzcecPUVu
   /vS4NS+yQHz+GmD2w1nrVUaRdgYvmywrQhpdJfXL+o6rNGzDhkS7xuon0
   TVK3JQBcXhu7oiulMy9PPO34JPfxIbyTuWUJtHd7nlisiHgkwI0lF6Jwj
   Qndkm2IkAlXH3tfUH1O/40NZY6W5FCPUfMMV8qS39tiZuKDs7YlQsS6JH
   A==;
X-CSE-ConnectionGUID: EzWfowcBR6mp0Ub1pfCdNQ==
X-CSE-MsgGUID: FLj2u/NYSS6Lmz4exwPrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78225479"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78225479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 11:22:52 -0700
X-CSE-ConnectionGUID: soQaHLr/S+SjRSBNGA92tw==
X-CSE-MsgGUID: W+YbSyErTC60zB+G99T+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220727912"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 11:22:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 11:22:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 11:22:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 11:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTHg4VPSH8V4frPJnOP+xHAHZo8z4M2UH584gP+T83my47GLiZrQuYFklXhPJ4SN1w3cc/PEzl4B18Gey6B15usTecZzVNo1MV9JXSxuIbKn8JM1fMtJtVmjA1LPyy6+ut5Ps8oMGLDYs8t2QmsJ5+BZBpV/NkpIdcxThMtkCrYfcLB2mnhhhv2W4WlVqLEwIkqRUkQ3XH/TmZCByy8bRZk8bPZ+rG5AhfPkKtFlzQ78sGWrEXFzB1O6rFSD5FmVan2bUC/57eRspv2wveKEEe6Z7N0FBC26ZPWD46qxiHcGERoV0zlQMkR1pXZbhjSMTkXGIqldj2/up2v9f1LFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnvCwdDVew2zAJ0XP2gbSK6Mr19c3srNtIT8H9njeig=;
 b=GjMAp5nB8lGcGtdqCXpTNmCoRfYynTuSu/F7DmFgtWkz3XSADoHEjM3EyQ2mkIVcl6M/mqvPx2BS45MeHYw66XLgltl2R6qkXH/zhMJ+Khwy/bpOxZLh96kZao4pWYhXYn4iRB9dYMysMSw4uQKmzPiQE5gGj5Tw/d8y65fQCCrYDdVONvCU60kJhb2nFJYQC2fnXHypOkTaLxXFT1cBuUNyWlnJYovjd+XXBh/hiFDbkWy7/UYh8TRIMWQFyyf7bFqVVO3/QojhFymCXmHs3N+111/yrmV2hxDz7tULTwZ89CkqmxoLXfV85bnfnd8j82zhbYwypTUf3LfQhM6zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by IA3PR11MB8917.namprd11.prod.outlook.com (2603:10b6:208:57d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 18:22:49 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 18:22:48 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Auld, Matthew" <matthew.auld@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?=
	<thomas.hellstrom@linux.intel.com>, "Brost, Matthew"
	<matthew.brost@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: RE: [PATCH] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
Thread-Topic: [PATCH] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
Thread-Index: AQHcsXlNvTxggtb0EEOmAH1sDxGhUrWpoHiQ
Date: Wed, 11 Mar 2026 18:22:48 +0000
Message-ID: <DM4PR11MB54561F96FB88885F0B7C4CE5EA47A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
In-Reply-To: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|IA3PR11MB8917:EE_
x-ms-office365-filtering-correlation-id: 662c1aa6-6018-4509-85bb-08de7f9b32fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: gBbTstrheHq5/sEJbqz6Dtm2fG8naHEV5EJuUi4OgGBFzlJHsEoclop+VZzDff63x9Hbb69hFCFDWgOyygb54sqnxnm1pzs3zbhn+EwyxqJBKMpnzCcL/VbraBg1ZQgwxflpISOY9uaUQFyI9LWkDRecAbZI+sy9mKvXVzkAUrFgdrSVOEiDYUrfpfg17fYxztMILn+DCpBz/fSp5VgqeTSKkHTo3TfgCeuOynsphixttTvjk5r40IphZHefGwUFHU47EGYMSs01mT+bdOmHPjVhRmTH7otlL6cP/cwk9og2+m8V0/MnQcPHTggFNojSIFJ7SG4jyQdCrJX+ouCyuqkS+KafoWK1DV/ovXLY82NRjqaNEsYqwe1t9+fcfuYo82u2e4dk/X9zVZAFjDKTIjGC7OjJHqXAbfdvqAckGXGpWRz0McLrdE5fQO+AssfIvtxsONxwlWVZv4kLYYDWeVeivd3BSnKS7fjVx8wyDCH8CFzWjIvmECDyNSJ0zjeXHIDM8WFqa1JqcDVzIERtNkwVtgDbp97uPrdWwVjyElLjdRsJTZpSu0aHksuU/dpfB2w2yo9VrzmA7lMwoV2qurHYapRAj9OI28F8hhX7fvrffuGl+OT3M4QUfwk8LskbxfdZTRGCbmlaw0AAk27XO/Oyr1YXRxEqkQH8tvHhY6x+8YC4WAzr2HjwM7bs5jVim4nNBxGCUVy9Vkd1e994F1rHmKT7KB0KD7e/ADJ+n3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RzK0VuV0dBcWtLWDMwSEdYb25IbHBaWGtRYUdzeXN3c2RqcXgvaElmeVB4?=
 =?utf-8?B?dktPR0QzUDFkaFBBRW83NEphMW9GU3VqRjNSbEZhdDdEV25JOTVjek1pYkxl?=
 =?utf-8?B?WUtZTzBaT1FvS1JMV2tOS24rVURvR0xRNkRyUTFwL3VHc3hONWVORmZiZS9r?=
 =?utf-8?B?NnRrcEZjZzgvRHRjakU1cUpiTmdsYjhQd2t1c1NCVk5UVkVaSnZWVkFES3d6?=
 =?utf-8?B?OWxXbGJjY0JiUW9HQnpFK1lYY3I1OVZWc0JWallCRXVCdTVTSXFOdmxkcmxw?=
 =?utf-8?B?TkFYWTRLbzE4L0NTL3RjQmpKd3BJWGdidi9ZVnVmck5IeDlncVZFRWE1WWt4?=
 =?utf-8?B?VlVTbU9DN3FDM1JmTm41ZmZvNkRkY25SdGZYSGlwZWdOQncxKzZSd1pLTWx2?=
 =?utf-8?B?TmFoWDBhK2ZsUEoxQnpGS1ZiN1ZvNlF0WjMzem9pK0txRXNHbUdtL1VNTVRQ?=
 =?utf-8?B?NmxBWmxwMVhkRC9tU0IzRVYyaWZSOXRWcTBPS1dCaWhJZ2d1b2ZhMzU5NmFJ?=
 =?utf-8?B?M1MzR2tpTFAwcXIwVWFGMUxJZ0g0dkQ4a25nQ0FCU0N2Q0RPc3hVOGc3Z0Nn?=
 =?utf-8?B?Q2lEYnVmSTk2RmgzTXFCQjMrbVpyamJIZ1hTci83a2lCWGdUVnlpdEJDUjg5?=
 =?utf-8?B?ZlVJQmY1UVc3UFBtOVFDQ1hOSEhUdm9TQTFSOVVMRWNIcVRqZGZZaFpDTUdz?=
 =?utf-8?B?TlUyU25ndEcyc0JEajJyRXprSEFTVmQwRjh0Y0F3M1hEOW1NVkpIMGZ4K3Fa?=
 =?utf-8?B?N1FpNG9NOUtzK2pFRGljR2ZUM29xTUtaZmdGcjdxZ0M1bFN3QXByR1gwT2Ra?=
 =?utf-8?B?aEI4aU5GTEpJeEFIZUgvMTJvWGx2cFo0K0V5UWkxQ2RsdTZqa2NSNGxxZXJX?=
 =?utf-8?B?L28zM0RzUG9hL0NWL2JLTllBWjBlbnc2T0tHT1R3QkpTTFpaSjhHWW8rVGVl?=
 =?utf-8?B?U1VCcG1PanhHZnJWVnIrU1NydXJjRmRjR1kyam9lTGVMa3Z3S0V4QWgwTlpX?=
 =?utf-8?B?Mzk4N0QyY1Z1d3UzaG9hZEM4Q2JoM1NublJ5Z2xZSzlBdWJHa1hvbEU5MTNO?=
 =?utf-8?B?TytIMlJ1SU9vb2lQSGdYVkRNZE8wWUE3RFlyRFJabXAyQ29RN1BIL1U3SUpw?=
 =?utf-8?B?M2RlNkUvaWkvMGdoL1BQSUtGY21HOEc2cGZSRFE5SjdESSt6UkZUVzR0ZFJS?=
 =?utf-8?B?RzZ6L0U1ZGEybzFZNExMZEFwcytTc0p4S2lRV2JyVlFON2JzSFA0aFFGRm1q?=
 =?utf-8?B?RTY4K3ByU3R3b2xzTGlNTzc5SnhBa1YvVlVJM21sUXlGMTMrZS94VXJnNlZF?=
 =?utf-8?B?YytvdnZVWjBEWnhOK3JhOURZOXZrMEFLWndvc1kxRW50aG0yR0gxMXcyQjMw?=
 =?utf-8?B?eDVQMHBIejRZQUhzSWs4eDNzMFJEUDB6ZnBXaXRsTVU0cVVnT0RTK2JkV3Jq?=
 =?utf-8?B?OVV0VE5lVHowR1pxUU5WUXFwU3NqTkoyTFJoVVdiRGdRNURxOUVFQ2NRcjVv?=
 =?utf-8?B?NmY2NFBVYlhWSWdNZ3cvcWphdlIyZHFDOElPWlo2OXEwSFprK0RkMVJKOER2?=
 =?utf-8?B?MThzS2ljNEtKODh0TFRwV3NoaE82WGhrMEFMTXN1MGl3Q1MybkJteXYzSHZG?=
 =?utf-8?B?czdNV252NS9zMVQwc1cxVElwcFdJZGY4Qys1R0V5WFd5QzQvZ1B3M3ZlNWU1?=
 =?utf-8?B?cElsTEZmRDA4djdXNEx5UEJHbDdUUnJLM1VMSGtnL1R6MWlwZjhtK3RNcGpP?=
 =?utf-8?B?ZTVwYVkvcXhSL2lPODBwWGtHQjFrTVh3ZkFpM1JLNGFOY2FGdXhSVFl3Rnlo?=
 =?utf-8?B?RDZSZmlNY0FTY2Z4dlhHcHE4bUxKS2N2dlJDamxWelI3T3BmTjZLd1NIU3hz?=
 =?utf-8?B?a2pvRmh3MDdldUxpQXZXdHErQklIR3kvQldUZEZwRDVxU0hyR0ZVSEJCYzZv?=
 =?utf-8?B?dGEwaEgwSkRFQ3RFT28wbDlhTERnUzJwTWYzY09FQ291NGc4c0VrYkxsdHJR?=
 =?utf-8?B?Tm53d1JXazZWejVoalBiOG5Ib0Y1YmxKSHhUNlBSWlpaME4zbjRDbUUxa1Nk?=
 =?utf-8?B?c3ZBMzBNdjdiWk5vTFNPNDRlamFDTGorYkhvSFV0UXVXUlQ1QzFraTN3OG5j?=
 =?utf-8?B?bUtxd1FPQ1FnMFR3dEZKREFrMHNNZitCM1duSXRmc1RDYXZyVmhJeW9VTHB5?=
 =?utf-8?B?RWJMMlVXemVqcDU5MXc0T05rQ0xGcHNYY2c5VFV3U1RDcnpWUEwvdUxVUWJP?=
 =?utf-8?B?eFNSRU8zV0VUK2FKa1FJV0ZJSGVlVWhUVlZqVUV3WDU5dFQvLzRhcTlYY1d1?=
 =?utf-8?B?eGNYNTBwcnVNT3U3VnpQTmdRemtxT0Mrak5PbXorRkYvU3BBVHc5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PEUX1BPrWsAsfuc09lgM63HES8hNzlNdkiV267ykldnj0D9lEz1ZBm6/L3NXLBxmcWEJYsC/YePdy7beGm0I+O4JAylnJ3IB1CM06rsE3vPcgkYmPxiPLGlEAUia+/slncHxOT67u0mRz9kxNHJrsI9Ct5asyYhRSDbZ9i7Q/IHNlW0CjDgUCDVDb6xrDrVtl80FDDGwjffxHopetNEpXTnLYH3SIEC4pRbSUWAhl2gi2w2XaE8IWeM2F69JiI5qdADkj4KqDikF1hF2vMpoev4cpBQ7/BfQCzXendP6+NsRLS/euq0pEXtebpzL0OU3Z17BJ9ugNE6sQaMbOD0vpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662c1aa6-6018-4509-85bb-08de7f9b32fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 18:22:48.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CVfzFAKIhOS6WJTKb+iu0AezILZ3HYYoOIQiflTESvMtTE9JtKicuhmO1yklkzFCKKfh8DQqp+cw12w4EUYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8917
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224744-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 33E8F26887E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBNYXIgMTEsIDIwMjYgOTo1MyBBTSBTYW5qYXkgWWFkYXYgd3JvdGU6DQo+IGNjc19t
b2RlX3N0b3JlKCkgY2FsbHMgeGVfZ3RfcmVzZXQoKSB3aGljaCBpbnRlcm5hbGx5IGludm9rZXMN
Cj4geGVfcG1fcnVudGltZV9nZXRfbm9yZXN1bWUoKS4gVGhhdCBmdW5jdGlvbiByZXF1aXJlcyB0
aGUgY2FsbGVyIHRvIGFscmVhZHkNCj4gaG9sZCBhbiBvdXRlciBydW50aW1lIFBNIHJlZmVyZW5j
ZSBhbmQgd2FybnMgaWYgbm9uZSBpcyBoZWxkOg0KPiANCj4gICBbNDYuODkxMTc3XSB4ZSAwMDAw
OjAzOjAwLjA6IFtkcm1dIE1pc3Npbmcgb3V0ZXIgcnVudGltZSBQTSBwcm90ZWN0aW9uDQo+ICAg
WzQ2Ljg5MTE3OF0gV0FSTklORzogZHJpdmVycy9ncHUvZHJtL3hlL3hlX3BtLmM6ODg1IGF0DQo+
ICAgeGVfcG1fcnVudGltZV9nZXRfbm9yZXN1bWUrMHg4Yi8weGMwDQo+IA0KPiBGaXggdGhpcyBi
eSB3cmFwcGluZyB4ZV9ndF9yZXNldCgpIHdpdGggeGVfcG1fcnVudGltZV9nZXQvcHV0KCkuDQo+
IA0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0veGUva2VybmVs
Ly0vaXNzdWVzLzc1OTMNCj4gRml4ZXM6IDQ4MGIzNThlN2Q4ZSAoImRybS94ZTogRG8gbm90IHdh
a2UgZGV2aWNlIGR1cmluZyBhIEdUIHJlc2V0IikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPiAjIHY2LjE5Kw0KPiBDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21A
bGludXguaW50ZWwuY29tPg0KPiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRl
bC5jb20+DQo+IENjOiBSb2RyaWdvIFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5jb20+DQo+IFN1
Z2dlc3RlZC1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTYW5qYXkgWWFkYXYgPHNhbmpheS5rdW1hci55YWRhdkBpbnRlbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d0X2Njc19tb2RlLmMgfCAzICsrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS94ZS94ZV9ndF9jY3NfbW9kZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X2d0X2Njc19tb2RlLmMNCj4gaW5kZXggYjM1YmUzNmIwZWFhLi5mM2I4MzRhMDlhNmQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndF9jY3NfbW9kZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS94ZS94ZV9ndF9jY3NfbW9kZS5jDQo+IEBAIC0xMiw2ICsxMiw3IEBADQo+
ICAjaW5jbHVkZSAieGVfZ3RfcHJpbnRrLmgiDQo+ICAjaW5jbHVkZSAieGVfZ3Rfc3lzZnMuaCIN
Cj4gICNpbmNsdWRlICJ4ZV9tbWlvLmgiDQo+ICsjaW5jbHVkZSAieGVfcG0uaCINCj4gICNpbmNs
dWRlICJ4ZV9zcmlvdi5oIg0KPiAgI2luY2x1ZGUgInhlX3NyaW92X3BmLmgiDQo+IA0KPiBAQCAt
MTYzLDcgKzE2NCw5IEBAIGNjc19tb2RlX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmtkZXYsIHN0cnVj
dA0KPiBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiAgCXhlX2d0X2luZm8oZ3QsICJTZXR0aW5n
IGNvbXB1dGUgbW9kZSB0byAlZFxuIiwgbnVtX2VuZ2luZXMpOw0KPiAgCWd0LT5jY3NfbW9kZSA9
IG51bV9lbmdpbmVzOw0KPiAgCXhlX2d0X3JlY29yZF91c2VyX2VuZ2luZXMoZ3QpOw0KPiArCXhl
X3BtX3J1bnRpbWVfZ2V0KHhlKTsNCj4gIAl4ZV9ndF9yZXNldChndCk7DQo+ICsJeGVfcG1fcnVu
dGltZV9wdXQoeGUpOw0KDQpIb3cgYWJvdXQgdXNlIHRoZSBzY29wZS1iYXNlZCB2ZXJzaW9uOiAi
Z3VhcmQoeGVfcG1fcnVudGltZSkoeGUpOyAiPw0KDQpTaHVpY2hlbmcNCg0KPiANCj4gIAkvKiBX
ZSBtYXkgZW5kIFBGIGxvY2tkb3duIG9uY2UgQ0NTIG1vZGUgaXMgZGVmYXVsdCBhZ2FpbiAqLw0K
PiAgCWlmIChndF9jY3NfbW9kZV9kZWZhdWx0KGd0KSAmJiBJU19TUklPVl9QRih4ZSkpDQo+IC0t
DQo+IDIuNTIuMA0KDQo=

