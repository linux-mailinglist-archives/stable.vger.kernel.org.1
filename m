Return-Path: <stable+bounces-75807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2D974EDD
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A44EB2A16B
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89214B960;
	Wed, 11 Sep 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezw5PQdr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C113C67E
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047662; cv=fail; b=obSKAIAU4WlhqXmVmiNkYfn77cBCEyjsOqZWTCvo2oR9danlFcY8r7vuHIlhRzCeIZVgYAlGF1NCn+2G0yUQR8QxxM+n7AhHHtO+HTDA0pIgE2VE6vHei8ZbDrWjVHRcNkyZ41VLgGwITRCRRMVUdQijws4w537ZKTfOukdmUQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047662; c=relaxed/simple;
	bh=DLzv7KWkpyGsShWbtCfI02bGaVmmuCN32u7ypI2/pj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hEb3ifS5QVsMGSlUXGw/zuULZ+7Be+JrTJTp4YWUU6zOD2VA3BklSNnTA16p4UcvKb2KTHU6FV0b9i8eX86nArOU+ZBfk1ZLyf6AMRLDb+0zZeaQhQPqprL6WTSRVWF9icdEnm/hOh3GPeRTNF4Ngb39wUv3aEUjVMwrgcKJc9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezw5PQdr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726047661; x=1757583661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DLzv7KWkpyGsShWbtCfI02bGaVmmuCN32u7ypI2/pj8=;
  b=ezw5PQdrk3Iqkoxqqac3+/LATMdbfky9ufr6Bu+J+IkcYHPuQcfB4Ocp
   +wtunKYS1C5TK/EN8Snl1h86xM0ON13Vf/bluPF8VxwzNTqdOOpQjDQkA
   kZouuVjYKpxMkCMjWA0+6HE3s5zXvi+74/ff8cwN8OAl/HA1Xk/5cc34m
   e4aT7flTCVvVB0odnrEz0dkHvxGM2z1aSljGKEOD9r5Qho+SPUR/gb4jV
   osFbqofCvfaytc0sqxx6F+GYSbzBzpJc3kIaCHyRTjt/yFBDBnAugBTRE
   uW9B60x1c3av7bK3TdCq4vLHIVwJybUcORMOPUawP2RCwN+yu1D4GYsfu
   A==;
X-CSE-ConnectionGUID: KgZ/wSN2Sr2/VBaXXeQdHA==
X-CSE-MsgGUID: b6sXHrdgQfeZVT6OloqH2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24377062"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24377062"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 02:41:00 -0700
X-CSE-ConnectionGUID: yrzg2qwdSXS5QfdCtgaRGg==
X-CSE-MsgGUID: rwoAnxK2Rh+OPW/LBvJSwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67153209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 02:41:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 02:40:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 02:40:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 02:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfwMFQnGknAjtzVeJ7eNH6CBAHoTzomOXJcdiXzHyeyLqBXdxiR0RwjBe7FNppopwPrG7VMdBJapxeOUHGDpJ3p4BdKMpUreb0uE4QzkhkD8Bx0ORy7lCcfExya2yU5nNoMG8xOHzoETsyjun23QCk6HIPShp6iVpI/xlfbS4tnXSFPVvYxZDGIgZD1JJSLqp1i7HAt/Y1hBbzyCrK3sSGIIE/jm8PMR2YcXBW7/QAp1B36mNl6JcH2Kjox8m4psj7pzbNon94nCMMhaZ4q6hKolz5xtpaOA+iWUSjcwXZS9IidMi1N0PSFt0C4X4qX+Xtis9J2Bsj4rZUBR5t+zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLzv7KWkpyGsShWbtCfI02bGaVmmuCN32u7ypI2/pj8=;
 b=Vna6Iw9VXFrrEtIV8jVCwsNj4f5QG17Kv7oMSUiIg9sifPz6EiFZEJphMIBqfj2coTaKXf6jPAZuumJkviLWrvgiBQtyWIN4w8Kv5lu5YjL8/pIOOv+EnQnPFOP7BFqXs3UKwDp0TmZMoOOGjRJHpej4ey+rxtxXD4s9SJLSfGP88KEUY7sJ434egYJJJeQIVVNHgzo99eOAcmPmNYLd9GNsji/GYmnSyKUpyw9fuWLKDLdUdbRS33fj7ajdBYRtCWRQhYIaw9NAJ0zERfkJcRZ5Eh8pE1MTMcCTLqA4eBQtKsSK7fPJo28w2xKRO/4rDXfsGzGoHaIqqwOo55uxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com (2603:10b6:a03:459::19)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 09:40:57 +0000
Received: from SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762]) by SJ1PR11MB6204.namprd11.prod.outlook.com
 ([fe80::fd8d:bca9:3486:7762%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 09:40:56 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
	=?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
Thread-Topic: [PATCH 2/4] drm/xe/client: add missing bo locking in
 show_meminfo()
Thread-Index: AQHbA4Ma5WxJu+ZgYk20Vw3/sruJrLJSEnYggAAxmACAAA7zMA==
Date: Wed, 11 Sep 2024 09:40:56 +0000
Message-ID: <SJ1PR11MB6204475E4C51F6A5A3DC4B29819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
References: <20240910131145.136984-5-matthew.auld@intel.com>
 <20240910131145.136984-6-matthew.auld@intel.com>
 <SJ1PR11MB620426C360C56AE7A55D6DA7819B2@SJ1PR11MB6204.namprd11.prod.outlook.com>
 <fea806cc-ed5e-4fd0-adf5-87d98ea5b99d@intel.com>
In-Reply-To: <fea806cc-ed5e-4fd0-adf5-87d98ea5b99d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6204:EE_|PH8PR11MB7968:EE_
x-ms-office365-filtering-correlation-id: ebecb9b7-da70-4690-19f1-08dcd245d619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEVQbFJRbFVQNHdTaTVhOHlteUsyNXBTcW9KYmhWWTU0MnhBMitxUXQ3ZHNk?=
 =?utf-8?B?N2QyV3NSemVWd21ma3JabVgydEtPMnl2c2F3bXRDV3BYTlk2aFJ6VmxMeVJH?=
 =?utf-8?B?dHMrSkswcXlpbXJSTUxadHNlazU1b1VMVXlubmYxRzhhTDRGWlBrZkJTTjh2?=
 =?utf-8?B?ZEtlZEhKVVJkY1JwSGI1dW5BZnJ5QW9kYmhiTFZIOTJlcHZVbldMYndKdGNi?=
 =?utf-8?B?eVMyVDF3bE1mUzdkWThtelhxb2drbEw5S1JkYi9WTjMvSXBqTk5CNmR5RTB6?=
 =?utf-8?B?SzNUWFQ5VHR6enhFMzF5WVpMZUVseVcyb0duYXd1MDhGUEpicVBzd1VLVFdh?=
 =?utf-8?B?YlF1clE1TW1LaW8vR0dCZ0t5VktrOHFDekZlQUdsNE41YjNCQ1JNNUhKdUp2?=
 =?utf-8?B?Q3M3RFYzcjNFS1o5b3lkd0pTaXpHVUJRa0tpUWtzK2Zaa2dmNVFtQU9kTEtH?=
 =?utf-8?B?a1JDUkNSTHFnVzVpSG42MjJ2ajFnWEZnamNVRkFneUh5My9iYlBmZFdaczVM?=
 =?utf-8?B?ZnM4RXBMOCtkbHp4SXZDZ3lGR05Vai9XVXI4aGFVT2N3T3V0dHMwOUdybjMw?=
 =?utf-8?B?NVo3L25uZzBJUC9SNnJTL3p0V1lTclZJa091Q2VBSnRWWlhGRGZra01BL0g1?=
 =?utf-8?B?V3pWWW5OL2piOWxsalZzb3UxRjhIM0ZFM2QwZHRFb1JYOGVINFlEWWx0ZWk2?=
 =?utf-8?B?ZzlhSXBXalZ1NmF3V0tLYUMxUDByZS9QbmpTSy9OU3JHWGhEYkpkUzFYczhH?=
 =?utf-8?B?dEdPTFc2bVBVY0tvRWpRK3hFdDE1VThWcDF0TWtOR2ovZzZIaFBDazhZUlJw?=
 =?utf-8?B?TmUvOWtiazcvQW9mWmYrbWhNajBlRWg3Zm85eVl0NmVINU9hVUQvSVV3T1Vq?=
 =?utf-8?B?Z25uRzIzVmFkYThLWFcwU1p1UFRCTXJOaFlNVFpUR2x5YmdiWWtoNVZ0ZkY5?=
 =?utf-8?B?WkN0T3k5Sy9sSFl3enpaYStONlF3NHo1N1RoN3ZUL25JVVJpeWk4bmZ3Nm5R?=
 =?utf-8?B?eWZWRy8rcHRqZzIzdk9jYldVZWVXdTgwd3BLT042OGdsYTMvaytvaE9QN1hM?=
 =?utf-8?B?RnlDb1QwbDl0cm1DRTRNODYzWk1MNWZKSGJEc2cyOVVCYnlqMGxsZTR5TnNk?=
 =?utf-8?B?VnozSVZIRTRBRmcweWdkQXZUZmJnMTBSMndDRENncG9hbEkzWlFHMFlhL1o5?=
 =?utf-8?B?ZXFJQ3lJd3dOMG9FRllkSEppajBkcERLbU5LOHdya2hiMDRITlgvVXFDVGRC?=
 =?utf-8?B?c2dyK3k5ZWsrUEdiNXRDT1kwSlhDZ1lMR1hpUnBRbndERitCVE83K2VaN2Vy?=
 =?utf-8?B?TUtxa1dSZUFBaHhNR2l3ZzF5cER5Q3o3dGZoZCtqaW4vQjRVZW1RVDdkZDl4?=
 =?utf-8?B?ejZabEFlZk5GS004UnBUd1NqYWpSWkRESklJMmxjY2g4bVUrNHJsaWY0N1lV?=
 =?utf-8?B?b2VHSUZPNXFEeWFZcnZzekFnOEpDaHVXSGJweUtJajRBWHhaQVFONkpQakkz?=
 =?utf-8?B?UUZBS3BHNTRhMnJ0ZU5JNjRJbGI3eUg3d0VmRlVKWUdCT1ErY2JoR1RPVGlw?=
 =?utf-8?B?RUlPSkxHR01tYmxOd2RiTHF3OXY2eEh0WVk2Z0lFeVFXTUVCVDArR0ZWd1gz?=
 =?utf-8?B?c0FodXc2eDJJNHNzQVQzT1poOFMvbFBuL0tXYUsvOFZRZnhJZFFPd3B4blZK?=
 =?utf-8?B?VVdlWkdHQTNMVTIybkZqdTJ1VUZ3RkxmL25sQVpRTWg1L0RvdnNUVGo2K0FP?=
 =?utf-8?B?alBidEFKaXJSRW92TDVNUlBIRGJNb3JUV3A0N1BYbnZ6N0dsV0JIMnh5YmRl?=
 =?utf-8?B?a2pTaW12c0NXVWkzSVQxTTU0cVNIbG5FZS9pQzN4eGxldmxaNHFKS2x1bEkv?=
 =?utf-8?B?Y0VaRkFCaUpib2xoazhOZnBBUGYxMytsQjFCSlp5aXZveFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6204.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDRNbE5QWXQvVjQ0cEFUTXhyOVI1aSs3aDVMUnJ4dHhGcEQxbjJrWjNidDIx?=
 =?utf-8?B?NkdjVmdod1FYbThXU2RiQUhuTi9WYm1TVmFac3BSZXozbzMzQm1iY1BnQmZ5?=
 =?utf-8?B?VmRxM3dOMW5VUUJ1U1BHM1lMeDVZbE5qQWJmZllucUxqMGd2L1dqWUdtMGtu?=
 =?utf-8?B?bGMxZWdZYU5Xd3pQV2VCTU1hV3ZxUEtBNTRlQmdBTitOaHA1azhZS05tdVVX?=
 =?utf-8?B?WjBJOEVuOUFmNUlKa3htOWYwQTFQOTl4bUV5Njl6ck8veTBjTkRCaUNaaDkr?=
 =?utf-8?B?NmlzVkNKTWpqWFZEUnhORWF5QXAxRTgyN2xZZkxsaUZWdDd4QjRiZVowUzNq?=
 =?utf-8?B?TjJudTN3L0xqd2FTVEFtRE5yNDhVUk4yREVaVFV2Y0lvV1FxYm5YZVovek03?=
 =?utf-8?B?RGlqMzlRb3B0cXJhVU5odXd3QWM1dTloYXJCVVNEcjB3RE1wU1pzVGNNT05i?=
 =?utf-8?B?ZVI4WXoxOTVGRlp1V3g5NXVjWDF4VU4vKzNBZDk5aU9PSCtzRFh6QWhtRUJB?=
 =?utf-8?B?UldlellmSjR6ZjhvNW50TnpHbTV4bnUvZ0h1a0tHRXB6ZEJxWlozK29HK3Uy?=
 =?utf-8?B?bXp5UElJSjhFcXpZbVFUY292bE5mTTlGUENlZ2FIUElaNkhNblY0VytVWGE0?=
 =?utf-8?B?YWIvOTFnbmNZZ0Z4UUlIUE9USDBhYk1GVER3TTNXVjF5bnd1d3hRQUlMeHZB?=
 =?utf-8?B?Tm8vV05JVG1NeS9sU1V6ZkhTMWZQL2hIQmpWL2VFNXBvNGs4TzFpa3diUWVQ?=
 =?utf-8?B?d2hrdXpVa1lPY0xsR3BDcXIxb0U3OVlDS3BhNUhmUzZwenJVak94L0dnYzFu?=
 =?utf-8?B?TDJpK3M2eWZocjBuZ1ZqL1Z2L3JSU1QxeDdIZmkxM2FXZzh1QVh0c0tiTkNa?=
 =?utf-8?B?Y2lRN2lFak4rVWlPbDdzYzlGeVRDSkJZRXRhTUJSSXJUSjZwUnlINThzQ0hi?=
 =?utf-8?B?VnhvWVQydnRRcHRvRnlGQWVaUittcUx6WVJ6LzhpWXFXUkVGZ2xKN09ITmpJ?=
 =?utf-8?B?amlNYzJOTWo0MFdETVZPbWpDK0dVb3hvTloyK0E1OGo2K0I3ejczcFI2Ukt1?=
 =?utf-8?B?QTdMQ3dDc2p6VEtZZHMzNjRYbDA4UFZ6NFpHT044QlZOZytiQzBCMDNjekdX?=
 =?utf-8?B?UExPQW9DT1RMdnpOTjN0MGd0REcwc1FncHhuYTE2aWFyc3ZpNUd3K0xhV3J5?=
 =?utf-8?B?cE9xUFhoaFN0K05HRVhMM0FMcnpTK3hLRy9HV0ZFVUVSdnVCdmZtUUUxZklG?=
 =?utf-8?B?TDNVZTRORThITWE5NW1WNEc4MU1vaHU0RzhwWnpmRVFSRG9CZWF4ZmZ2ZFg3?=
 =?utf-8?B?M1hHNTlpdXFocGFDc0grRlVxZW5JNG1MOGFMelJSRmFEQUZCWDNNTEd1OTdD?=
 =?utf-8?B?WVBPWGJma0xsTXE3NWpVK3JTNlFiZVlqa2NGR2ViK04xV2VldGVKMmZQSzJB?=
 =?utf-8?B?bHl1ZWYrZGQ5TSs1ZzRGbzRKMzBpQ2h0UFpoZ1lwVnVwYUp0OE1PU2p1SEVB?=
 =?utf-8?B?RTJIcGRhRytueXp4bkhJQmVvLzczcVIvZEpZRXdiM210Z3J5Z0dQdENmSi9r?=
 =?utf-8?B?RnE2VEM4QlF4SGtBYTc2TkRQWUZacFJFSnZzZCthR0lrRUhnMEM0WmpwUkF4?=
 =?utf-8?B?OTVRTkpWNTVQejFnd1pZbDk1b3o5R29FV3licEVNUjVYcWF3OW02anZHdExX?=
 =?utf-8?B?SUdabGo5VTdWbXd3bVdsSTJoU1BRL3NTSzd2aVJic1dWSmFNbEJxWVBRM2x2?=
 =?utf-8?B?TjFUdnZvRlBWYm5QUUJLeDh0ckZaZmFkM0FWb3REdzNzbFY2bnFKTzJhS2Jy?=
 =?utf-8?B?V05sZTkxWVR5QzlWanBDSEVYbWdERk5RMFYwRVlSOXZXZEFNSk9Xbjc4aXBm?=
 =?utf-8?B?OWN5TXF5TCtyekRLSTFKQ0dDUGpEV0MzQUtQRHNmQWEvNGgxeXlrektUblJw?=
 =?utf-8?B?TzQzem8yZmR5MWtBeG5hTU9Pamtha2Q5ZzNvWVl3dFNhMGs2VWRtNG0zYnFF?=
 =?utf-8?B?OFpmY2F4bzVJREhQSkNsTnlkc0trL05sSlJTQkY4bWVyVnZBUm9mOVkwRUNG?=
 =?utf-8?B?Y095RFdLbVc4MFE0MEJMSmVZTk1vYjA2Z1BuWlprcHZ0ZE0zN0JjSmRpbzhh?=
 =?utf-8?Q?/HsG2bcNFLveWxtVfs1YQB1zW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebecb9b7-da70-4690-19f1-08dcd245d619
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 09:40:56.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8aJ7uQYkFILYXoSu5p0P0NI2jT67iK7fluzvHeMwJUBk/n5xgPstRLDR5Caf+cwWO7lYp5BKKNaTWk0XaYERPR0G2NYPb7Uzkn9cwkRxm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTEs
IDIwMjQgMjowNSBQTQ0KPiBUbzogVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFkaHlheUBpbnRl
bC5jb20+OyBpbnRlbC0NCj4geGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBHaGltaXJh
eSwgSGltYWwgUHJhc2FkIDxoaW1hbC5wcmFzYWQuZ2hpbWlyYXlAaW50ZWwuY29tPjsgVGhvbWFz
DQo+IEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gZHJtL3hlL2NsaWVu
dDogYWRkIG1pc3NpbmcgYm8gbG9ja2luZyBpbg0KPiBzaG93X21lbWluZm8oKQ0KPiANCj4gSGks
DQo+IA0KPiBPbiAxMS8wOS8yMDI0IDA2OjM5LCBVcGFkaHlheSwgVGVqYXMgd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBdWxkLCBN
YXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0
ZW1iZXIgMTAsIDIwMjQgNjo0MiBQTQ0KPiA+PiBUbzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+ID4+IENjOiBHaGltaXJheSwgSGltYWwgUHJhc2FkIDxoaW1hbC5wcmFzYWQuZ2hp
bWlyYXlAaW50ZWwuY29tPjsNCj4gPj4gVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFkaHlheUBp
bnRlbC5jb20+OyBUaG9tYXMgSGVsbHN0csO2bQ0KPiA+PiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51
eC5pbnRlbC5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtQQVRD
SCAyLzRdIGRybS94ZS9jbGllbnQ6IGFkZCBtaXNzaW5nIGJvIGxvY2tpbmcgaW4NCj4gPj4gc2hv
d19tZW1pbmZvKCkNCj4gPj4NCj4gPj4gYm9fbWVtaW5mbygpIHdhbnRzIHRvIGluc3BlY3QgYm8g
c3RhdGUgbGlrZSB0dCBhbmQgdGhlIHR0bSByZXNvdXJjZSwNCj4gPj4gaG93ZXZlciB0aGlzIHN0
YXRlIGNhbiBjaGFuZ2UgYXQgYW55IHBvaW50IGxlYWRpbmcgdG8gc3R1ZmYgbGlrZSBOUEQNCj4g
Pj4gYW5kIFVBRiwgaWYgdGhlIGJvIGxvY2sgaXMgbm90IGhlbGQuIEdyYWIgdGhlIGJvIGxvY2sg
d2hlbiBjYWxsaW5nDQo+ID4+IGJvX21lbWluZm8oKSwgZW5zdXJpbmcgd2UgZHJvcCBhbnkgc3Bp
bmxvY2tzIGZpcnN0LiBJbiB0aGUgY2FzZSBvZg0KPiA+PiBvYmplY3RfaWRyIHdlIG5vdyBhbHNv
IG5lZWQgdG8gaG9sZCBhIHJlZi4NCj4gPj4NCj4gPj4gRml4ZXM6IDA4NDUyMzMzODhmOCAoImRy
bS94ZTogSW1wbGVtZW50IGZkaW5mbyBtZW1vcnkgc3RhdHMNCj4gPj4gcHJpbnRpbmciKQ0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+
ID4+IENjOiBIaW1hbCBQcmFzYWQgR2hpbWlyYXkgPGhpbWFsLnByYXNhZC5naGltaXJheUBpbnRl
bC5jb20+DQo+ID4+IENjOiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29t
Pg0KPiA+PiBDYzogIlRob21hcyBIZWxsc3Ryw7ZtIiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5p
bnRlbC5jb20+DQo+ID4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni44Kw0KPiA+
PiAtLS0NCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2NsaWVudC5jIHwgMzcNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDM0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2NsaWVudC5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2RybV9jbGllbnQuYw0KPiA+PiBpbmRleCBiYWRmYTA0NWVhZDguLjNjY2E3NDFjNTAw
YyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RybV9jbGllbnQuYw0K
PiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZHJtX2NsaWVudC5jDQo+ID4+IEBAIC0x
MCw2ICsxMCw3IEBADQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPj4gICAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPj4NCj4gPj4gKyNpbmNsdWRlICJ4ZV9hc3NlcnQuaCIN
Cj4gPj4gICAjaW5jbHVkZSAieGVfYm8uaCINCj4gPj4gICAjaW5jbHVkZSAieGVfYm9fdHlwZXMu
aCINCj4gPj4gICAjaW5jbHVkZSAieGVfZGV2aWNlX3R5cGVzLmgiDQo+ID4+IEBAIC0xNTEsMTAg
KzE1MiwxMyBAQCB2b2lkIHhlX2RybV9jbGllbnRfYWRkX2JvKHN0cnVjdA0KPiB4ZV9kcm1fY2xp
ZW50DQo+ID4+ICpjbGllbnQsDQo+ID4+ICAgICovDQo+ID4+ICAgdm9pZCB4ZV9kcm1fY2xpZW50
X3JlbW92ZV9ibyhzdHJ1Y3QgeGVfYm8gKmJvKSAgew0KPiA+PiArCXN0cnVjdCB4ZV9kZXZpY2Ug
KnhlID0gdHRtX3RvX3hlX2RldmljZShiby0+dHRtLmJkZXYpOw0KPiA+PiAgIAlzdHJ1Y3QgeGVf
ZHJtX2NsaWVudCAqY2xpZW50ID0gYm8tPmNsaWVudDsNCj4gPj4NCj4gPj4gKwl4ZV9hc3NlcnQo
eGUsICFrcmVmX3JlYWQoJmJvLT50dG0uYmFzZS5yZWZjb3VudCkpOw0KPiA+PiArDQo+ID4+ICAg
CXNwaW5fbG9jaygmY2xpZW50LT5ib3NfbG9jayk7DQo+ID4+IC0JbGlzdF9kZWwoJmJvLT5jbGll
bnRfbGluayk7DQo+ID4+ICsJbGlzdF9kZWxfaW5pdCgmYm8tPmNsaWVudF9saW5rKTsNCj4gPj4g
ICAJc3Bpbl91bmxvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiA+Pg0KPiA+PiAgIAl4ZV9kcm1f
Y2xpZW50X3B1dChjbGllbnQpOw0KPiA+PiBAQCAtMjA3LDcgKzIxMSwyMCBAQCBzdGF0aWMgdm9p
ZCBzaG93X21lbWluZm8oc3RydWN0IGRybV9wcmludGVyICpwLA0KPiA+PiBzdHJ1Y3QgZHJtX2Zp
bGUgKmZpbGUpDQo+ID4+ICAgCWlkcl9mb3JfZWFjaF9lbnRyeSgmZmlsZS0+b2JqZWN0X2lkciwg
b2JqLCBpZCkgew0KPiA+PiAgIAkJc3RydWN0IHhlX2JvICpibyA9IGdlbV90b194ZV9ibyhvYmop
Ow0KPiA+Pg0KPiA+PiAtCQlib19tZW1pbmZvKGJvLCBzdGF0cyk7DQo+ID4+ICsJCWlmIChkbWFf
cmVzdl90cnlsb2NrKGJvLT50dG0uYmFzZS5yZXN2KSkgew0KPiA+PiArCQkJYm9fbWVtaW5mbyhi
bywgc3RhdHMpOw0KPiA+PiArCQkJeGVfYm9fdW5sb2NrKGJvKTsNCj4gPj4gKwkJfSBlbHNlIHsN
Cj4gPj4gKwkJCXhlX2JvX2dldChibyk7DQo+ID4+ICsJCQlzcGluX3VubG9jaygmZmlsZS0+dGFi
bGVfbG9jayk7DQo+ID4+ICsNCj4gPj4gKwkJCXhlX2JvX2xvY2soYm8sIGZhbHNlKTsNCj4gPj4g
KwkJCWJvX21lbWluZm8oYm8sIHN0YXRzKTsNCj4gPj4gKwkJCXhlX2JvX3VubG9jayhibyk7DQo+
ID4+ICsNCj4gPj4gKwkJCXhlX2JvX3B1dChibyk7DQo+ID4+ICsJCQlzcGluX2xvY2soJmZpbGUt
PnRhYmxlX2xvY2spOw0KPiA+PiArCQl9DQo+ID4+ICAgCX0NCj4gPj4gICAJc3Bpbl91bmxvY2so
JmZpbGUtPnRhYmxlX2xvY2spOw0KPiA+Pg0KPiA+PiBAQCAtMjE3LDcgKzIzNCwyMSBAQCBzdGF0
aWMgdm9pZCBzaG93X21lbWluZm8oc3RydWN0IGRybV9wcmludGVyICpwLA0KPiA+PiBzdHJ1Y3Qg
ZHJtX2ZpbGUgKmZpbGUpDQo+ID4+ICAgCQlpZiAoIWtyZWZfZ2V0X3VubGVzc196ZXJvKCZiby0+
dHRtLmJhc2UucmVmY291bnQpKQ0KPiA+PiAgIAkJCWNvbnRpbnVlOw0KPiA+Pg0KPiA+DQo+ID4g
V2hpbGUgd2UgaGF2ZSByZWYgdG8gQk8sIHdoeSB3b3VsZCBpdCBuZWVkIGxvY2sgaGVyZSwgY2Fu
IHlvdSBwbGVhc2UNCj4gZXhwbGFpbiBpZiBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLiBJIHRob3Vn
aCBCTyBjYW50IGJlIGRlbGV0ZWQgdGlsbCB3aWxsIGhvbGQNCj4gcmVmPw0KPiANCj4gVGhlIHJl
ZiBpcyBqdXN0IGFib3V0IHByb3RlY3RpbmcgdGhlIGxpZmV0aW1lIG9mIHRoZSBibywgaG93ZXZl
ciB0aGUgaW50ZXJuYWwgYm8NCj4gc3RhdGUgaW4gcGFydGljdWxhciB0aGUgdHRtIHN0dWZmLCBp
cyBhbGwgcHJvdGVjdGVkIGJ5IGhvbGRpbmcgdGhlIGRtYS1yZXN2IGJvDQo+IGxvY2suDQo+IA0K
PiBGb3IgZXhhbXBsZSB0aGUgYm8gY2FuIGJlIG1vdmVkL2V2aWN0ZWQgYXJvdW5kIGF0IHdpbGwg
YW5kIHRoZSBvYmplY3Qgc3RhdGUNCj4gY2hhbmdlcyB3aXRoIGl0LCBidXQgdGhhdCBzaG91bGQg
YmUgZG9uZSBvbmx5IHdoZW4gYWxzbyBob2xkaW5nIHRoZSBibyBsb2NrLg0KPiBJZiB3ZSBhcmUg
aG9sZGluZyB0aGUgYm8gbG9jayBoZXJlIHRoZW4gdGhlIG9iamVjdCBzdGF0ZSBzaG91bGQgYmUg
c3RhYmxlLA0KPiBtYWtpbmcgaXQgc2FmZSB0byBpbnNwZWN0IHN0dWZmIGxpa2UgYm8tPnR0bS50
dG0gYW5kDQo+IGJvLT50dG0ucmVzb3VyY2UuIEFzIGFuIGV4YW1wbGUsIGlmIHlvdSBsb29rIGF0
IHR0bV9ib19tb3ZlX251bGwoKSBhbmQNCj4gaW1hZ2luZSB4ZV9ib19oYXNfcGFnZXMoKSByYWNp
bmcgd2l0aCB0aGF0LCB0aGVuIE5QRCBvciBVQUYgaXMgcG9zc2libGUuDQo+IA0KDQpPaywgbWVh
bmluZyByZWYgd2lsbCBwcm90ZWN0IGRlbGV0aW9uIG9mIGJvIHdoaWxlIGluIHVzZWQsIGJ1dCBp
bnRlcm5hbCBzdGF0ZSBvZiBibydzIGZpZWxkcyBjYW4gc3RpbGwgY2hhbmdlIHdpdGggaG9sZGlu
ZyByZWYuIEdvdCBpdCwNClJldmlld2VkLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5
YXlAaW50ZWwuY29tPg0KDQpUaGFua3MsDQpUZWphcw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFRl
amFzDQo+ID4+IC0JCWJvX21lbWluZm8oYm8sIHN0YXRzKTsNCj4gPj4gKwkJaWYgKGRtYV9yZXN2
X3RyeWxvY2soYm8tPnR0bS5iYXNlLnJlc3YpKSB7DQo+ID4+ICsJCQlib19tZW1pbmZvKGJvLCBz
dGF0cyk7DQo+ID4+ICsJCQl4ZV9ib191bmxvY2soYm8pOw0KPiA+PiArCQl9IGVsc2Ugew0KPiA+
PiArCQkJc3Bpbl91bmxvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiA+PiArDQo+ID4+ICsJCQl4
ZV9ib19sb2NrKGJvLCBmYWxzZSk7DQo+ID4+ICsJCQlib19tZW1pbmZvKGJvLCBzdGF0cyk7DQo+
ID4+ICsJCQl4ZV9ib191bmxvY2soYm8pOw0KPiA+PiArDQo+ID4+ICsJCQlzcGluX2xvY2soJmNs
aWVudC0+Ym9zX2xvY2spOw0KPiA+PiArCQkJLyogVGhlIGJvIHJlZiB3aWxsIHByZXZlbnQgdGhp
cyBibyBmcm9tIGJlaW5nIHJlbW92ZWQNCj4gPj4gZnJvbSB0aGUgbGlzdCAqLw0KPiA+PiArCQkJ
eGVfYXNzZXJ0KHhlZi0+eGUsICFsaXN0X2VtcHR5KCZiby0+Y2xpZW50X2xpbmspKTsNCj4gPj4g
KwkJfQ0KPiA+PiArDQo+ID4+ICAgCQl4ZV9ib19wdXRfZGVmZXJyZWQoYm8sICZkZWZlcnJlZCk7
DQo+ID4+ICAgCX0NCj4gPj4gICAJc3Bpbl91bmxvY2soJmNsaWVudC0+Ym9zX2xvY2spOw0KPiA+
PiAtLQ0KPiA+PiAyLjQ2LjANCj4gPg0K

