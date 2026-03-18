Return-Path: <stable+bounces-227124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLHhDrfZummfcgIAu9opvQ
	(envelope-from <stable+bounces-227124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:58:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D552BFC2A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777223113CA5
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D03FF88C;
	Wed, 18 Mar 2026 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ctz3wtZz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275212E1DC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851214; cv=fail; b=LTLF0yJNR6xOYKg69dIqhndbDtoI3z6K+sWMfueeuYSwoZ8CFefrzxekJqcD87h+0H5UH104X+8xsLh2X+Z3mlZOkXAwKcwLh/qc5GSpOWTYl2C3OLTyTcB5qNjaMTwOiG1ojTbMh+O38OXg9jFUX2dnhmAjstI8YJKuNXn75XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851214; c=relaxed/simple;
	bh=ass/A4tJlR7MpnauVRXSDvEiaqnXENFydCuAA3b4q9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W+RHvwiX4E0B0zeluNmVA9+1jF5663R1nfcvIepAfV3PcbETBPZs3n9UPw+WRsXUyzBBmKynJlJD8f1i7E+bmEXJM98d3PnxHzicf4zMU49tJP3Ix1rTIsyctSUYyKpOQZ3j7tLYKfimnqQx/G/7EGb8KYY7jESzxv4C3TIppnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ctz3wtZz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773851210; x=1805387210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ass/A4tJlR7MpnauVRXSDvEiaqnXENFydCuAA3b4q9s=;
  b=Ctz3wtZz859VpYMigXLhOPMEK58FO3hc3ySEHl4+/W80WLlTXGEJeXJc
   nfKaNmUtchhVapA+U+6YaewT6T0MFSw5uN6duKrY+3AOHDKPF1xXL80c6
   bJkVX7t3s2mVSaMLa+jeSs01cT2pa/roY6rYcPHvqpOZ1V9dv3oqosMzI
   VC8w4CGMMf8gsrdubEvpehdupJ5MvvwQAFRUmVmbVCBvFwJmwoTBc0Wox
   8pB1YT9XN9C2VVPyw1WXRVxrAe64CBhGoUfZxcvie8SdZMxPmqyECor61
   OlAh8GECs4MQcTAFn8cksoRFqEmY6fHriCSs785QVklbQ4tVuQUFDgaR4
   Q==;
X-CSE-ConnectionGUID: N3fe25r8SNWZy3zD542t0Q==
X-CSE-MsgGUID: CAJymC57RY+x/SEjECRTig==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85542735"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85542735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:26:49 -0700
X-CSE-ConnectionGUID: gaSLh58VRMKCzOl+pGU7gg==
X-CSE-MsgGUID: Z5LNTaZbSXeAGGuE4Pdt7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="220105082"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:26:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:26:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 09:26:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IETtcvhqKwn8N8vifpHayMU0fXUNGHVQJ8Y2OHKwhjQ2MP5g2VW6tJihT5sWx+wm/bLwD4jIaxclqhOzw/JH1iiU4RqTIkz3QW3J6AkFB02hePU03FUjm+j9cDxK9McSR8tRUv+nbxSkFN/VzF5InC4IBw7iDY6M1OSnPAl6kuy4yDQPaEmzgi4k9CX1XnAH+OxM5c7pnWTlruO7wIMRCKNZcsjeW/eQVCKCXc8dprgpdJP9cTFaBoNwJaehps25YCKdUrzTmaWfmcOZ7MLf+v8tPIHQO4nIb4yPJ4HZW5eo8rSlqIiW5bSUExIFsL0G6jWKWc/LGH8MSGnOnTmRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ass/A4tJlR7MpnauVRXSDvEiaqnXENFydCuAA3b4q9s=;
 b=YVSrxxwip2JOpFHtmABo1G9HpKxBMsHJmK7XJdyl0CdTXxfED/hLNdJzzmkjUgWJfspyfP8/3onQKODTBgSFx1lH/RBwfL81N6TVzIGEMEE3vKiL1sNgyFGh5D33ioiToyku1wjXj1h+vssS1hTuFeYkbWAAcyb+/ELihjAQ1oml/OhB35NBlcpq6H17NxypIg0WUlxNABtno1eJzkqLK6KvyeOcN2NgkdcFscPsPW59igjOPdz6WsXjCfmtiL3AhLUmmVZyHxw0zJOsk/8cIbNtjTTHZRSavR0YVAz780zKFj+3hptW/vpp81QI8aFjZOR7utn/qVQzE9qK0eS8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by IA1PR11MB8222.namprd11.prod.outlook.com (2603:10b6:208:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:26:44 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 16:26:44 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially initialized
 sync on parse" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Thread-Index: AQHctgPgECEJeu0MVEWd50ZolA7oKrWy6OSAgAACNQCAAAjCQIABRJiAgAA/koA=
Date: Wed, 18 Mar 2026 16:26:44 +0000
Message-ID: <DM4PR11MB5456118C166481BEABF3CF33EA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031748-huskiness-autistic-5186@gregkh>
 <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031851-glamour-unusual-8513@gregkh>
In-Reply-To: <2026031851-glamour-unusual-8513@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|IA1PR11MB8222:EE_
x-ms-office365-filtering-correlation-id: b37e0ed2-64ab-41c6-7141-08de850b24e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2gb/aXEF6Cd5SjD/DhzwV1cgOLvlNMj18kG+w3GXVNsWtpvrIz3IMPlTFd5rBWrZ/wyQzOfAV8/cQ5mOxpvRYAwAStQ+rLaFlHbJDR5Ok3RgXKwAdqD/29DOyVGmCwsUGumDaI5w5mc31Xqkg+e+24lh+btE9cJbyFxiW97kZKGVoTgt5N5+liZTr4ceTlqrW+h6f6QgV5E1DoCPS77R68aUx7XhIpIQm+6mj3PYWn5kw1sgCnEEsAr4JsQe73tStV5yW1g6IZkT/e6ujj9sKD6sW1nJPOtV8qtabtGS2Afin2HL63TFx4HCMFbqoKHNfjQeWnFuXGcYqWcMsZXd18uFAOBdFUAKXTkg1Tn7RqcgJk1AipXwVCbaesaTveTa5yc7r6J9fQg0mBY0ZQpy2Mg8ryUunePJzDbZ4iuJeAOSOyk4CW+o9xhig/BYM9eozFrwgwhMLD3CpWlx9WeiU4mwaYLPqGaj7nrxIt6SE8Qm/AT1ujaSZvAQ3I+4ATzo+rjLjaBGs6aL8LoaWZdb1CZp/hMaLUS31fLW2D0iDfYz2Tvq0ShuHFyud+nyIlqFWXzNP70lIqkDMpTV9t/oHHRXoWs14oEj5Ghj5sJweg9sZ0fo48OVmH4tLZwt0vr47eOqQL78xxCDIvYUw7+9QBCBel9GE5DNPsVnI7RnIUBMwmBZhNTn6hB2MUWP/mt2jZ3twSeaaeVaQGtXtYPuS36H1OoQ+sYNCzIvyXW4iTmAtDhWLGq7hAO77uwYbwre/LqrxmQmDQTISpTXZ5HXVgdc6a+lcu7mN2g2PLkAJ+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZStGMlltamdVQTFaS215ck9nNUhiQ3Y1c1NpeFRSTW0rVTZEL0FUNHN2NnNO?=
 =?utf-8?B?WElkTmpyVkdJem5FWWFtWldDR0h4K0pNVlhLMmkxYlZBL3ZEcGgyeHVTaWI1?=
 =?utf-8?B?aWNFVGJpTXBReHpnaWtiN0ZFWm54NWdhYzhITTk4NHloRUgrc25HOG9KRmRi?=
 =?utf-8?B?bEtIUUY1TnlqZDhXZ1Zxd0diR3VDZFhJUGVrcHF0dm83cWYraVNwQmtMTGdz?=
 =?utf-8?B?TmZna0t5UzUrOU4yYndMWG1naHB6Vk1JTXpGdjZOYWFLb0puOW80UisrbmNN?=
 =?utf-8?B?QXhCVDRZa2FUOWhsTngrdWRBRU94ay9qbEFnbmtVUGxBd0RuVE14L2MvejE0?=
 =?utf-8?B?Qjgwa1pJbWdlUHRqWUVpNU90M1JmZmRVWlBBbE5qbUlDVHI4K2J2bmRrSlBy?=
 =?utf-8?B?VXVzWWg0d1FxL3B5S0ZwYzhDUVFEcG4wc3dMMWpFVHFpY3c2ODM5N3NyakxP?=
 =?utf-8?B?QUlMcmtCRW4vNVBtYktwYVdqL3A2QU1PYnF5Z1cxTU1tNFpxc0Fod0t6VGNT?=
 =?utf-8?B?TURqV1pyOW15V2RBSm9yYjFHem5nRWpzZGdDcUQ4ajhyREdLSWpJVHBpNVZi?=
 =?utf-8?B?WnRJVm1LeHVtTTNuZkdoTHN5dDNiSk8rejJUTnpoTjN3MWRlUk50dHBiT2sx?=
 =?utf-8?B?dStST1Z6bzdGZUpNbXc4K3JSUzFlNnl0bnI0TW5HR3QyMFBPWmxLUDcwa2pV?=
 =?utf-8?B?T0w4bHZYcXFLd2JBbmNJL2dNWUc0OU5URElEVmlXR0J3ajFpZEtMb3VRVDJ6?=
 =?utf-8?B?NTM3ajhyd3JUdm9kcU9QVzduVkNiaHRCS0xPVllGSGk2M2tWbGR6T1IzM1d4?=
 =?utf-8?B?cEhVbkhoblNTbEZ2WXk5VUo0SXVNNGt5NU5MTytJd2taOThid1BaVGZBMjdl?=
 =?utf-8?B?Z0hSc2tMUXRUaG1QRGFicHIvVTN3UXFvRFJlbUs0V1NrSkEzVnU1T2VIenZi?=
 =?utf-8?B?RmZqY0JDd1RHeWd1MGFnZDBoQnJLdTc4ZS9Kck5ibzNPOE9ldlRMSlozdzhM?=
 =?utf-8?B?Z0RaMkV2bGM2aDJZbHFQRk4wa2NoOUZvLzBQVnU1RnYwK0s0Q2g2NG04MmFi?=
 =?utf-8?B?TFhaK2JsSUp0bUxzTXdPZUxiYVBJekNOQ1NwTERTZEYyZWF3eDV3cUEvbXd3?=
 =?utf-8?B?TUl2bWs0eEZPOGVjY20zV0hOQzNDMjROSHUzcEIvNGZqcUE4L1B4b3NFTEg5?=
 =?utf-8?B?N0JzUExtRHJhYzIvakFnc2xjNEQyd3FDWGc2b1lJK2NlTHk0M2Y1TjdtQzVq?=
 =?utf-8?B?YWNVNlFZMW9XZUFPK2FJN0R1OWRzYndGa0lZVnpyZ2dqRU9iL0g2dW9BUmoy?=
 =?utf-8?B?TVZZT20ycDZaR2tLY1cyU1Q1Y0NqWDJCbzdsMkFwR2xZVTk0VW00MEFhS0Ir?=
 =?utf-8?B?S056K2drZWVJWFNPaDlKNllnRWVkYi9DQk51MHNVU1VNMWx4UGNZdXlJOG93?=
 =?utf-8?B?Q2ZsSXF4UytoWTlkVDBMdFZ6Z2U0ak5MVTMwK2lDY2p3c2lwem5BMHpQVi9V?=
 =?utf-8?B?YmJVWGpuVHVVT2FKaDViT0JUWHlONkdKcHFYNFpBS0t3Q3lNbGFzcW1YY21i?=
 =?utf-8?B?b0xvNWRMbzlPeGFRc0p2RVJ1VzZQVlNVRlYxbEpsZUoxWGV5L1hXeFlUTWdh?=
 =?utf-8?B?YWVpYXU4YjdEMHhBbjVsYnBVdkQwVmdTUGc5RFpGVGd4aHhRNyt2d2F1bURK?=
 =?utf-8?B?MC82K243VG9NYWIvcUltdUVUako0NXBSb2M4dWlFQVlWRzR0V0Qza3ZjQ2ZL?=
 =?utf-8?B?UGphZlJRQllaSVcvOEUwNDRNc3VZNzlrQ01DYmF0b0owUmFjckJFcUg4b1ZT?=
 =?utf-8?B?bVR2SFN4UG02K3RZNmNROEh3NjRaQ2JqZzZhek03ZzYvUU1zcElwS2YyYXJN?=
 =?utf-8?B?SWhQZk0vZTJZT1N2aTNYbndVRTV1MkpnaFhrem1Gb2VkWHkxMEN3SDdqS21I?=
 =?utf-8?B?aHdhMkNUMWNoN1I5Z3hVWStqYzVDZzcxc05TRlFpcDJtUmovVWpUMXFoTy9B?=
 =?utf-8?B?SytVVlhZbllwWHVBSzU1bmk2SGJzNE9sbEc4bVAwVktNMUZzZEtlamF5Q1FI?=
 =?utf-8?B?ODRvazJFS0F2aDFFL2l3TndTRFBhcTI2QmJaUks1WFVvZUM4eHB0OWE2Rlp4?=
 =?utf-8?B?MHZ3S1VxNjNFTkVuY3hFMGRnUDdJN2w5SDQwSHJweWJmanhwQWNSRzZUSVpu?=
 =?utf-8?B?YjF0MFlmZHNOQ0Z6SmVKUWRxMWh1ZjVHc0EyaEwyalloMXN6cUsrK3JCTFZh?=
 =?utf-8?B?R3M2YTNkMDBEajdjd3Q3Tm1YNW05dnpKcWdlMXliRlZCdFpSSnkvUFVzbGJQ?=
 =?utf-8?B?MnFQeVpGYytVQU5RMzVzVnZxUi9rdElMWGxNZFpvOTZ5VXRKMGtFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m8h6ZkSG7r0vncj9Pk0D6hYQaGZChDQ7PyET47G79TWoBrwF+BJburfZQ4PWcqXCKcaddOVCbJwTA0v+Sk8giqia7W2B/lrIiwffHfNLx4rRik1BRWb1wzmTx3NYbii60uGcsFDHYyQMRiK3Tn587TlDutzSOdueo1rhRir4Yu1jcjn3YxMSmcmjjUvsmeta2/bbZ3k14JI5p7gbK97IDECCtlptXI41jaISpALy2Ik0hr2sLax/3QrAOLQNOJgsDOdZr6c1+JfRUBotatvFVldh3COP4B5udahuWr0GYwBDXLMt7Z0qU9jbivMDm/nwNMwgyoa3qbzjTHffmTmuYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e0ed2-64ab-41c6-7141-08de850b24e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 16:26:44.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cLEj42A60eOkzvWAIrEXDc3kN8xg0CaoLKpzDdBwgYoAda0aevdtAoRDmvCm91O3kZQqUDrcTw60rEzLJOdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8222
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227124-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 91D552BFC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBNYXIgMTgsIDIwMjYgNToyNSBBTSBncmVna2ggd3JvdGU6DQo+IE9uIFR1ZSwgTWFy
IDE3LCAyMDI2IGF0IDA1OjEwOjUzUE0gKzAwMDAsIExpbiwgU2h1aWNoZW5nIHdyb3RlOg0KPiA+
IE9uIFR1ZSwgTWFyIDE3LCAyMDI2IDk6MzIgQU0gZ3JlZyBrLWggd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIE1hciAxNywgMjAyNiBhdCAwNDoyNzo0NlBNICswMDAwLCBMaW4sIFNodWljaGVuZyB3cm90
ZToNCj4gPiA+ID4gT24gVHVlLCBNYXIgMTcsIDIwMjYgNDo0OCBBTSBncmVna2ggd3JvdGU6DQo+
ID4gPiA+ID4gVGhlIHBhdGNoIGJlbG93IGRvZXMgbm90IGFwcGx5IHRvIHRoZSA2LjEyLXN0YWJs
ZSB0cmVlLg0KPiA+ID4gPiA+IElmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3Ig
dG8gYW55IG90aGVyIHN0YWJsZSBvcg0KPiA+ID4gPiA+IGxvbmd0ZXJtIHRyZWUsIHRoZW4gcGxl
YXNlIGVtYWlsIHRoZSBiYWNrcG9ydCwgaW5jbHVkaW5nIHRoZQ0KPiA+ID4gPiA+IG9yaWdpbmFs
IGdpdCBjb21taXQgaWQgdG8gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+Lg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gVG8gcmVwcm9kdWNlIHRoZSBjb25mbGljdCBhbmQgcmVzdWJtaXQsIHlvdSBtYXkg
dXNlIHRoZQ0KPiA+ID4gPiA+IGZvbGxvd2luZw0KPiA+ID4gY29tbWFuZHM6DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBnaXQgZmV0Y2gNCj4gPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0DQo+ID4gPiA+ID4gLyBsaW51
eC02LjEyLnkgZ2l0IGNoZWNrb3V0IEZFVENIX0hFQUQgZ2l0IGNoZXJyeS1waWNrIC14DQo+ID4g
PiA+ID4gMWJmZDc1NzUwOTI0MjBiYTVhMGI5NDQ5NTNjOTViNzRhNTY0NmZmOA0KPiA+ID4gPiA+
ICMgPHJlc29sdmUgY29uZmxpY3RzLCBidWlsZCwgdGVzdCwgZXRjLj4gZ2l0IGNvbW1pdCAtcyBn
aXQNCj4gPiA+ID4gPiBzZW5kLWVtYWlsIC0tdG8gJzxzdGFibGVAdmdlci5rZXJuZWwub3JnPicg
LS1pbi1yZXBseS10bw0KPiA+ID4gPiA+ICcyMDI2MDMxNzMyLXNpemUtdW5mYXN0ZW4tIDJiZjNA
Z3JlZ2toJyAtLXN1YmplY3QtcHJlZml4ICdQQVRDSA0KPiA2LjEyLnknDQo+ID4gPiBIRUFEXi4u
DQo+ID4gPiA+DQo+ID4gPiA+IEkgY2Fubm90IHJlcHJvZHVjZSB0aGUgZmFpbHVyZSB3aXRoIHVw
cGVyIGNtZC4NCj4gPiA+ID4gVGhlIHBhdGNoIGNvdWxkIGJlIGFwcGxpZWQgc3VjY2Vzc2Z1bGx5
IHdpdGhvdXQgY29uZmxpY3QuDQo+ID4gPiA+IEFueXdheSwgSSBmb2xsb3cgdGhlIGluc3RydWN0
aW9ucyByZS1zZW5kIHRoZSBwYXRjaC4NCj4gPiA+ID4gTGV0IG1lIGtub3cgaWYgaXQgc3RpbGwg
aGFzIGlzc3VlLg0KPiA+ID4NCj4gPiA+IFRyeSBidWlsZGluZyBpdCBhZnRlciBpdCBpcyBhcHBs
aWVkIGFuZCBub3RpY2UgaG93IGl0IGJyZWFrcyB0aGUNCj4gPiA+IGJ1aWxkIDooDQo+ID4NCj4g
PiBJIHRyaWVkIHRvIGRvIGl0LCBhbmQgaXQgY291bGQgYnVpbGQgc3VjY2Vzc2Z1bGx5Lg0KPiA+
IEkgY2hlY2tlZCB0aGUgY29kZSBhbmQgY2Fubm90IGZpbmQgd2hhdCB3aWxsIGNhdXNlIHRoZSBi
dWlsZCBmYWlsdXJlLg0KPiA+IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbWUgdGhlIGZhaWx1cmUg
c2lnbmF0dXJlPw0KPiANCj4gICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9zeW5jLm8N
Cj4gZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N5bmMuYzogSW4gZnVuY3Rpb24g4oCYeGVfc3luY19l
bnRyeV9wYXJzZeKAmToNCj4gZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N5bmMuYzoxODI6MzM6IGVy
cm9yOiBsYWJlbCDigJhmcmVlX3N5bmPigJkgdXNlZCBidXQgbm90DQo+IGRlZmluZWQNCj4gICAx
ODIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9zeW5jOw0KPiAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fg0KDQpUaGFua3MgZm9y
IHRoZSBsb2cuIA0KSXQgc2VlbXMgdGhlIHBhdGNoIGlzIG5vdCBhcHBsaWVkIGNvcnJlY3RseSBh
bmQgY2F1c2UgdGhlIGJ1aWxkIGZhaWx1cmUuDQpGb3IgdGhlIG9yaWdpbmFsIHBhdGNoIDFiZmQ3
NTc1MDkyNCAoImRybS94ZS9zeW5jOiBDbGVhbnVwIHBhcnRpYWxseSBpbml0aWFsaXplZCBzeW5j
IG9uIHBhcnNlIGZhaWx1cmUiKSwNCmFsbCB0aGUgY2hhbmdlIGlzIHdpdGhpbiBmdW5jdGlvbiB4
ZV9zeW5jX2VudHJ5X3BhcnNlKCkuIA0KVGhpcyAiZnJlZV9zeW5jIiBsYWJlbCBpcyBhZGRlZCBh
dCB0aGUgZW5kIG9mIHhlX3N5bmNfZW50cnlfcGFyc2UoKSwgYW5kIHNvbWUgZXJyb3IgcGF0aCB1
c2UgZ290byB0byBqdW1wIHRvIHRoaXMgbGFiZWwuDQoNCkZvciB0aGlzIGFuZCBiZWxvdyBlcnIs
IGl0IHNlZW1zIHRoZSBsYXN0IHBhcnQgb2YgdGhpcyBwYXRjaCBpcyBhcHBsaWVkIHRvIGZ1bmN0
aW9uIHhlX3N5bmNfZW50cnlfYWRkX2RlcHMoKSwgd2hpY2ggaXMgdGhlIGZ1bmN0aW9uIGFmdGVy
IHhlX3N5bmNfZW50cnlfcGFyc2UoKS4NClRoZSBlcnIgc2hvdWxkIGJlIGR1ZSB0byAiZnJlZV9z
eW5jIiBsYWJlbCBpcyBhZGRlZCB0byBmdW5jdGlvbiB4ZV9zeW5jX2VudHJ5X2FkZF9kZXBzKCkg
aW5zdGVhZCBvZiB4ZV9zeW5jX2VudHJ5X3BhcnNlKCkuDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAg
bWUgY29uZmlybSBpdD8NClRoYW5rcy4NCg0KU2h1aWNoZW5nDQoNCj4gZHJpdmVycy9ncHUvZHJt
L3hlL3hlX3N5bmMuYzogSW4gZnVuY3Rpb24g4oCYeGVfc3luY19lbnRyeV9hZGRfZGVwc+KAmToN
Cj4gZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N5bmMuYzoyMjg6MTY6IGVycm9yOiDigJhlcnLigJkg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMNCj4gZnVuY3Rpb24pDQo+ICAgMjI4IHwgICAg
ICAgICByZXR1cm4gZXJyOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgIF5+fg0KPiBkcml2ZXJz
L2dwdS9kcm0veGUveGVfc3luYy5jOjIyODoxNjogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50
aWZpZXIgaXMNCj4gcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVh
cnMgaW4NCj4gZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N5bmMuYzoyMjY6MTogZXJyb3I6IGxhYmVs
IOKAmGZyZWVfc3luY+KAmSBkZWZpbmVkIGJ1dCBub3QNCj4gdXNlZCBbLVdlcnJvcj11bnVzZWQt
bGFiZWxdDQo+ICAgMjI2IHwgZnJlZV9zeW5jOg0KPiAgICAgICB8IF5+fn5+fn5+fg0KPiBjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiANCg0K

