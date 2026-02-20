Return-Path: <stable+bounces-217558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM5EO2g6mGmFDQMAu9opvQ
	(envelope-from <stable+bounces-217558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:41:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EEF166ECF
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C10308DBB6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74A33DEF9;
	Fri, 20 Feb 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neTlOYwd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B42D5957
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583938; cv=fail; b=Yo66YbAPhew0wiDYuN7RdUPqWeLkh0djdpdvlqIWeBm56bd30n95lrWqJ7VSX4eJdkkLO9As4jSLkw8lp0jiQF+Y6xmUTV0FbUTDNouupBCeasvV/BCCWFoFDABymVArgjX5yckzDmbsFeemqkxRF7BiexTRoUJO0X9zQE1QfSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583938; c=relaxed/simple;
	bh=krnJjFZVOrufjQnHvziE9Bqvsdiq8yWr7Wzpjl0N5E0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8EC1WX8HFc+YzVc4UrF0PDpbjzuSHoa4gcN0yn9njuazxwOQrFshn+comRIj4jVXuhfpu7Iv/xxosMhGkdOXV05vnOd1dgQVcBfdf7ZxwnaZ9+du2GrlCiV9qxPgFVZj2TlU/XLJv5blzgOxb8SUTYNUG0urmesU+Y7NmhreXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neTlOYwd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771583937; x=1803119937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=krnJjFZVOrufjQnHvziE9Bqvsdiq8yWr7Wzpjl0N5E0=;
  b=neTlOYwdiOmWapxPwJr7xkU0R+y5kslukJa0ViAISB+TeKYMODxi0OTK
   5Yq1sPdxdA1ptugMIyCQpbKUKwupOs75ZaByPnYv0/jBJuyB+a3SH6V9x
   mSlRxI0+1L0yE11oq5lLq1CLr9vFJp34YB2L7yDZO+0hu+DoPmfssZd26
   FOSXawRijToEReQmPPa0l056Vu4b2UEk7zLe1pymZtWo8DuESPBLZzn4M
   BWE8g2akzUAUeraKcE5td3bJ9tVPNKniOGNF2X6ZOA5W0ZiQbdwhzs6Hd
   8AzYjFcywYTeQ1qktpZvlkLeYaVJJ2DLIMWe+gI98yllQ2c7EN0Iz00xf
   w==;
X-CSE-ConnectionGUID: 1zUW4bGCSFWoy+CdSmZh0g==
X-CSE-MsgGUID: FBcn3tHPSR+Xgwbi2VXOXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84036364"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="84036364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:38:56 -0800
X-CSE-ConnectionGUID: b0zmLER1T6uVCqvHnYGKYA==
X-CSE-MsgGUID: HGCByjb+R2+QWrXyhNS4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213924220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:38:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:38:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 02:38:55 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfFrlV0OLPBScaLCpzxixxHOyRr3NuAIKjLcUq4Jt4yJYOnOyud0iCfLEXr7kCQ0nwtdoZzAkxok8lsmFdnMufn8S5ls5/v3QV/Xsk+Ber3L2aDegEvdN0+VtLCUUlK3ajddbGHMgYp6LRT+ly/cBctzmUEKTIhP7Uwry1Sk4U48/CODKmWwzOHpq92uKM/dIqVlSqbpREJbdnS+QsbkWRJbtIUVdRXHSXI7317EeHv5oo0u2DRJT0qRw7aBmo29YWwN8wunCOjFUYCGVufmLejF3MwaQEDTxccLT9MQmY+gds8hkG/GTbxHowJueStYAtIOhd0pYTv2WhUat2Ihdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krnJjFZVOrufjQnHvziE9Bqvsdiq8yWr7Wzpjl0N5E0=;
 b=VY0acwtIffBRd4/3pOMvCxzSfPSLqRKiQr+Mh7LgYyuJ4VRJYlbSwwr7Bw+HRFoxEfDzrqr0v2CHd1apEcXP2AsM0FCWsXFLKAUWqsPqPebWiTYv316lu61ewNwbrbZbRivMEK4s/g7NjhkdJsz0+d/ap7lQcV0A1JWa8/xEKCqejIzZzQGFAnYWftSeKIqIrqUbY/nSRcKn4o2DN9W0WmsN+Apl8vTx44/OAObcC5o7GeuFv0wzyARMmWJwyxnBA/EzkhgiXZ/MD4UnqgPPlX2gPo/ASaUzCS/NBjlNt4mudcVuqms3PooqoiEKKWttO5lyfiR+HY9687V7OLt+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 10:38:53 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%2]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 10:38:53 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "Grzelak, Michal" <michal.grzelak@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Manna, Animesh"
	<animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>
Subject: Re: [PATCH] drm/i915/alpm: ALPM disable fixes
Thread-Topic: [PATCH] drm/i915/alpm: ALPM disable fixes
Thread-Index: AQHcm+jC/MSfd/PBvUasqg47LwxfJbWLR8oAgAAqlIA=
Date: Fri, 20 Feb 2026 10:38:53 +0000
Message-ID: <af5e845e4a86d9308b65e9a6287d933a5ec8f4fd.camel@intel.com>
References: <20260212062731.397801-1-jouni.hogander@intel.com>
	 <ad4e98ae-3a64-f570-fb1a-77355ecc431a@intel.com>
In-Reply-To: <ad4e98ae-3a64-f570-fb1a-77355ecc431a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|IA0PR11MB7257:EE_
x-ms-office365-filtering-correlation-id: 3cae8e4b-d4c9-4516-2570-08de706c3e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SGEvZHlZNllEcHh1N09ITVprMWFXYVE1alpVbzZtbXpCVVd6UWwwK1g0ZXdX?=
 =?utf-8?B?VkxBbTh1TU9PR29VcWlPbmthT211dHNlWU5yOHdweEpkMnRRTzdLVWU4b0gr?=
 =?utf-8?B?TTBRYVlrK2hPMitSaE9lM0tKbWQyYzFwRElhMDhSN0N5bUtyZmYvSmRrdUw5?=
 =?utf-8?B?T1gvRWlZUDljUU5OUHdzbGVnemVnbS9KZk5HOVVUV3Z2cUVabGhqQStCbmJR?=
 =?utf-8?B?YitnaGZwSnJEdmpRVnRPWWdnbkMwTkpKM0FTZ1Q3Tm5YQ2NNUS91OHJDWHc4?=
 =?utf-8?B?RTE3MjJaaUJSbkI2cXMybGM1a3R1enZ4MGF6NG8waEcwTnVoZnpycGFwcGNM?=
 =?utf-8?B?T3g3V3Y4Tnc2ZENuWWhJTFhXV1EvRlVDUEV1VlRxZE5wdzJ6dTZ6NkZyTEN2?=
 =?utf-8?B?QjFiSzc2dStVVGNPSm1QWHIvTTVxN3JjQ05pOVZSUitqRnh6ZnZTTEphR2px?=
 =?utf-8?B?YkNaMnNYb2NtWHpicmsxMlMyVkNkdDc0RHNJeVRSZEdlUzNBTjJDa2l3dm42?=
 =?utf-8?B?aEZXd1JIMW5JSU9RZUQ2ejZMNmJnMWhuUk8wZ3pCVUFWTGo2MmhjWUc2ZEJi?=
 =?utf-8?B?MzFkTTF5VERrUXpRUHVVVGdPdExrSkswT0ZjNk5EdlhFVW15SFZpdk53bXI2?=
 =?utf-8?B?ZGcrY1JCd3lObkVKdEc2d1c1TzVxOFFWR0FpR3BVbTRmWXFFLzBDNTZvczg5?=
 =?utf-8?B?eFlJb091Tk5DM1lXNkNqQXIrVWIyYklhZ1VuQWN3NTNrNUZ6WFhXRmlPaVdM?=
 =?utf-8?B?V3RQaVFNY2NDL0JEM3lFaDZtU0w1TUtjRGpzVnBHY0NYMFNJVEUzdVBHMFhI?=
 =?utf-8?B?ZTR3ais0S2hCNWFDSzBMa3J2ZVBZZ05ucm51d2hUK01HYVRRR3JFcVU0bHJR?=
 =?utf-8?B?Y3o2NUUxRnY3cE5qTFg5NTBaZXVETjNLRHdjL0NSblIvVWpwQUVlcXUvNU54?=
 =?utf-8?B?SWRweEUrRGhUVjJoZlhFVW85YXROZGI0bEZvMENwbzBHeXMyUjBOVTZiUjhq?=
 =?utf-8?B?VDFiVlNnN3gyRmxxS0Z4UzZ6SGdTRU8zZ2VDOHc1YmdZU2VOSnhudTVqVjVM?=
 =?utf-8?B?WlNSQnBIV012cTFYd3lRbEM2eGJUOUxldGdqQk9IUkZUcXJDYnFLNm94L3ly?=
 =?utf-8?B?aE9kc0NHMWRkZzdGempydXhYdHF3UFlDQkJXdE1zTVpleG5SRWxnS3RGbWdC?=
 =?utf-8?B?SkRsQzIvUE9INlgxZk95K3Q2MkxEeDI4Z0VYRnBNS0hSbjB2VGpLSk5raW9t?=
 =?utf-8?B?U0J3NUtVcUFSbVBWVjFuMWlvRHJ0NTVxOGJoM0FNZVluSXREQWhURnFMQjJ4?=
 =?utf-8?B?YThWZ1Y3QU94MW9xR2RrdzI2RW9PeGQ0ZElqd2FrV3JrdjZHUk1hL3NTVjdn?=
 =?utf-8?B?V2VYRU9YT0JNK01wK3RMeHIzOHVJSmUxQmlTRWdPaS90eVZKLytWWlM4bHo5?=
 =?utf-8?B?S2tZK2VqeThFVUd6aDZtdlVPdXBMSDNnN0RSVmJjbmx3ak9KSk9mTlRTQ3pC?=
 =?utf-8?B?bWx6b2gxa1JwVTg5MXV0a24vNkJFemxPekRXTFd0dGd5RGFFSnl1VUhEUjFv?=
 =?utf-8?B?eGRENkFRT1g4RVVwamZXMFZJL3J5bHJjb010UURLT2VyVnlLY0dNWkp0NUhI?=
 =?utf-8?B?bWZQMHNOY1U0VERTNTZRZmZRNjM0QzlDMlkzUFo5dG9Qa0xCV3VmMmk5cVN0?=
 =?utf-8?B?YlRQbHZpdElEb0MvUE04UXFMYm52ajF1Qnk4clhJaHp6QnAyeTZoSEFOQUUv?=
 =?utf-8?B?SXpma3M1VUh0MlpVY1VSV3RqRVJGYk5uKzRwYzQxMWw4ZzU4b1V0RlRUdHZK?=
 =?utf-8?B?WjE1VkFTRlpWblJiUUlUVFNzMkFSUENnQVM5N0E3Q0h3a1RaWG5KQlJwZVRT?=
 =?utf-8?B?ZFNxTFFJZnRmaE1DbElMQUlMZk03bkNFOGtJWDZ0cEU2RmN1S2M2c1NUM2hC?=
 =?utf-8?B?bWxDdVNaSnpqaWFxd1ZGZWxtVndMME5jWmxyR1V3eG52ZnhnWlI5RzNZTHhV?=
 =?utf-8?B?Q05wSXRjSnlzQ1VVWllldXhCL3JzM0pRUlpadWZ3aGxFMzZzazZnbWEycHhx?=
 =?utf-8?B?UW1RUkVxZS9keXd6NDZJalpHazFzdkgzTWdtV2xrNzBiUUFYRVgrYThtRnNl?=
 =?utf-8?Q?Fio0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnNTUE0yN2RHVmVDUlBYRFk2WjFyOXNoTzU4Q2dVRFdLNjJZUTJhWThkOHY5?=
 =?utf-8?B?dmZnaWlyOUI1ODlicDZOWXZkK1ZaZWZna1hjYTNDWXk1ajQrM2VUY3ZLeEl4?=
 =?utf-8?B?QTBVSGtKc0ZxeFdRT2ZveXMyM3g3bnRnSW4rMUN5bW5KNmViS1dzTnF1TW81?=
 =?utf-8?B?R2RTcCsxTlhDZkd4U3I2YmRwNmxPZC81d2s5MWFMZ013WHJCUVFJczc5eVpQ?=
 =?utf-8?B?VEh3YjZDeEs1aUp5SE80U2lPZndtK3FvdDN3Z3BwNStOcXFvZ2M4V2o4eHBP?=
 =?utf-8?B?UFNNczBXSzNsUThsVndMN1hjak05ZTRoWnFENDQ1MTJidkZZcytJVndpeWlj?=
 =?utf-8?B?d3NpMFQ5cmYvUCtMU0hFUytBUTdSOGpzSGYwOEs3dWtzSjViNUdKVndYbmhN?=
 =?utf-8?B?S3c3N2s3NDNxWHd2THZQaTdyTmVqM3lWNlZFRUpNeUdMd3hjL1JqSkJKNVFZ?=
 =?utf-8?B?ekxhZC84V21mN1lrTFRpQ1pFWWxTYlQwRkZzZlBWS0MrT3pJbS9rY3JmSjJD?=
 =?utf-8?B?VjgzMkVtUzRtVmt2S3Y0SG1zbzR6cmtMTEUzcE9SdVdHdXYwczFsa3ZVdVhm?=
 =?utf-8?B?Zzh2d2w5NEo0UWkvZ3ZKaDlOd0NNaHQwSTFGR0VrQjBXL2ExekwyMWJJMVhu?=
 =?utf-8?B?eEhNQzdhNXo5TUwvU0oyMEN3YmFWc211eVMvc0Q0UGdDd2IzYWhzK29WSlFO?=
 =?utf-8?B?N2VpOGRLZ3huWUdFU0w2bmVFY2hKS2M3ZStyaXVDZllIUGdleWxEWTEvajlw?=
 =?utf-8?B?WWlFSXlBZnF1b1YzSnNiTHRKUzVMT1hEWTl2aTNBYkFad1NzdXNiTURXMy9P?=
 =?utf-8?B?UjFhZDlvLzh0clVpajlieGovalM4ZEFNTVIrdHZ6Y0M4WEVlYmg0dVVSMTB4?=
 =?utf-8?B?Umo0M0dxZU1Vak5ySGtHREpEcCtURk9uVkVFOHQyZEVVV3ozTFcvL29sRzNt?=
 =?utf-8?B?dkFMNXEwbmpuaDFjY2hJSVBSQ0NkU01BcWR1c2oyOFNyUGo0U3JSbDZGZXYv?=
 =?utf-8?B?cjdvWDIyTEVMb1llZ0FHa3gzN1pJVTBvOVZueW1oMTQ1OU4rdTNyM09yQzVD?=
 =?utf-8?B?ajJaZmdPUlJCem1xMndOTEVPei9SR1ZKKy9sbkxWVHdIODlWZE9BTVp5S2or?=
 =?utf-8?B?MVJhUHVlamlqZmRHeGRQY1V1SGwzY01ucEt5VEJRelpwRDhING9zbXNRdk0w?=
 =?utf-8?B?RDRwL2NhSWE2WVdtQ2l1MTNPbVlqVEdwdStPWkFVS3haNmt4TkV3WGtta0ZK?=
 =?utf-8?B?b2FkdXkwQ2lKZVdtMUwvbHJvNWVJaVhWK1pFMjdwY0tPdUR5UGlabFpFbk9W?=
 =?utf-8?B?Z29BVGN6b2R5M003ZDRRMXFUWEw1WGZ2ZURtMFduRU95TFNsYUxjTkVZUTE4?=
 =?utf-8?B?LzY5UzJ6VllndWpFOWRHckc0QUJiOGRzK3N6MTIxRThpR1ZXVWdYOENsT2RQ?=
 =?utf-8?B?aEtKR3VEMzRXdFFObnpMK3dyWU50bTBwVzJGRVJMNjNwbGhsMkxpSXVjZTlx?=
 =?utf-8?B?a2I5ODRJNG5vTnVhRy9FQWlHQklLZS82VmhNdU5sY3hSRVBvNkhoV05HMFhG?=
 =?utf-8?B?aktZdEFxVXZ4VTlLaFdMelRMSS9CUUZpcXJ2d3YvL2svaVlXejFRaU9WQVpE?=
 =?utf-8?B?Q2t3V2prQ2thMzRGc3ppUThWUTFnNWpKbjZMS0dBNFVBNlFXN2tibHFWNkFN?=
 =?utf-8?B?b2NNZzFxdE5MUWxsM2plYVRvZXVFYm5UVVdnMUh0blZxclBHUWhzMjUyZ3Aw?=
 =?utf-8?B?WHJoY2RyTFZCY09MeVBSK05XdmlyK0FsVHRVQitKMk00YzVEa1kxaDNHNVRU?=
 =?utf-8?B?MGRVYkJFc0xSQU5mcis0Sk15K0MzODJJUlZPeGNvNk8xTWFYRlJQemxpelZ6?=
 =?utf-8?B?Zm1qQ2VIRUtMVTFuL3BHSTdWeEVDT0tHQ2JKTWNCTnFWKzAxdHRNbjB0RHha?=
 =?utf-8?B?V0gyeWZnMzVOSFBwTCtveFNjaFJMZmdqM3ZGdi9LSjlESHo2ajNPRlBoUlFM?=
 =?utf-8?B?TzZuOElHaHdFSU9mVzU2N21SSDYxRlpvZ1hTK1pLK2sraUhTaWFQMjNlQitl?=
 =?utf-8?B?OEpiNURlM0Z0MnA4Mm1SbE4xVW9BNnRCVi9Mc3ZISlhFRk82clBWbVRmMHQx?=
 =?utf-8?B?TDBJYi9RbkNtZUQ2WStvbktIUkF4dWFPUXlzWlp6MU1DbnZrZDFRNGNVNnZi?=
 =?utf-8?B?RHNjUzhRTVViR0Vsend3WHV6eGFITUtwcjhnS2RuLzZXMjJlVSt0QUliMlRZ?=
 =?utf-8?B?ZmhCeEJrU3BpL2UxMmNnbVJCUEhHY3lxSXRDOVlQTmp1WkZNenJKZWhZeFR4?=
 =?utf-8?B?c1Q2aHdmSlduM1ExRy81eDJudjdOZzBqMjA1Y3JvcUpEWlNnUzZnZCtjdEw4?=
 =?utf-8?Q?AKQgZQjj0s9Ct54y4nYKcO29rIkmaeZiXqSAYk+VgckQ0?=
x-ms-exchange-antispam-messagedata-1: shQhGMM9boRvGcHDnCLRlglPJhFkXky9Lmo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794CC46AC51E7B43B896B2326B4B9070@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cae8e4b-d4c9-4516-2570-08de706c3e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 10:38:53.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9Udpksvb739kz0RmgwY1QnfOqPoHcnRHQmd9wpGmqCFv7qqJ2D08a3YBst45ecPkrG6hOQAS7NfnGeA/6hkJkRalCZWAVRM0+ZoJ9ZV2FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217558-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 48EEF166ECF
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTIwIGF0IDA5OjA2ICswMTAwLCBNaWNoYcWCIEdyemVsYWsgd3JvdGU6
DQo+IE9uIFRodSwgMTIgRmViIDIwMjYsIEpvdW5pIEjDtmdhbmRlciB3cm90ZToNCj4gPiBQT1JU
X0FMUE1fQ1RMIGlzIHN1cHBvc2VkIHRvIGJlIHdyaXR0ZW4gb25seSBiZWZvcmUgbGluayB0cmFp
bmluZy4NCj4gPiBSZW1vdmUNCj4gPiB3cml0aW5nIGl0IGZyb20gQUxQTSBkaXNhYmxlLg0KPiA+
IA0KPiA+IEFsc28gY2xlYXJpbmcgQUxQTV9DVExfQUxQTV9BVVhfTEVTU19FTkFCTEUgYW5kIGlz
IG5vdCBhYm91dA0KPiA+IGRpc2FibGluZyBBTFBNDQo+ID4gYnV0IHN3aXRjaGluZyB0byBBVVgt
V2FrZSBBTFBNLiBTdG9wIHRvdWNoaW5nIHRoaXMgYml0IG9uIEFMUE0NCj4gPiBkaXNhYmxlLg0K
PiA+IA0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9r
ZXJuZWwvLS9pc3N1ZXMvNzE1Mw0KPiA+IEZpeGVzOiAxY2NiZjEzNTg2MmIgKCJkcm0vaTkxNS9w
c3I6IEVuYWJsZSBBTFBNIG9uIHNvdXJjZSBzaWRlIGZvcg0KPiA+IGVEUCBQYW5lbCByZXBsYXki
KQ0KPiA+IENjOiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCj4gPiBD
YzogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuMTArDQo+ID4gU2lnbmVkLW9mZi1ieTogSm91bmkg
SMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTog
TWljaGHFgiBHcnplbGFrIDxtaWNoYWwuZ3J6ZWxha0BpbnRlbC5jb20+DQoNClRoYW5rIHlvdSBN
aWNoYWwgZm9yIHlvdXIgcmV2aWV3LiBUaGlzIGlzIG5vdyBwdXNoZWQgdG8gZHJtLWludGVsLW5l
eHQuDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQoNCj4gDQo+IEJSLA0KPiBNaWNoYcWCDQoNCg==

