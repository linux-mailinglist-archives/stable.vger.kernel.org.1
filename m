Return-Path: <stable+bounces-230569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP8RDB7nxWlTDQUAu9opvQ
	(envelope-from <stable+bounces-230569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:10:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE133E17A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2333015E25
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120863290C3;
	Fri, 27 Mar 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhcySkdv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3B31A7E2;
	Fri, 27 Mar 2026 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577387; cv=fail; b=UYKA/vF3dxO5aaiYWUti8hSCpvNVcOuFYxJIvRAcVhVMwFdS28FECDMjo91oJdEpORjwAzReyddgLANjUSRVOiKFTmGHpNc9ocztmnuCcnZ/RdOUGHnucJm9xpKOctyVi/I35ukHMYr3vSV3t4cwNUKC0eUnxPiyHZ3FNBtkySI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577387; c=relaxed/simple;
	bh=d2c0WhuWpP0dfIe8gdpkGZL6VwpPFEO5EOItjHmLD3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKTmT0PuMEjEy3x9ruEZcUZ7Gy3+jFBTnR+nBWSQMWGbSNYjAN/aYS8DeIwUx+/fdCIhxTTdFr2MPUikmNKTGw4nTYcUkCPaeuMSWztMRNBgqVm1Ib97J3+m2jtIIravhG5lLZ04H8Tfg15f4VSOPJ/xsGDzQ3Lm3uhOIoFIXSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhcySkdv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774577386; x=1806113386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2c0WhuWpP0dfIe8gdpkGZL6VwpPFEO5EOItjHmLD3Q=;
  b=jhcySkdvYMaEkTz7u3sIFMFndlNPH8S/4IwGMQ77I+AJucS1dY4woyAI
   ex6wePD9VshR0KFoBMcR1NbAkQTlnIcO9HaNda4NsKqP9qNBPuI6DzQbG
   5lT6f3rHeqW+dbTKcw42jzQ/tc6VAV2hocN6thxk4zkEmVglS3z4yO1kb
   yl9HBLcB1qYo0Q5C9W9/Zw6r2QetNN/AeLvjsXN+0StlE+yznD0X3o0b7
   +JV/38rSnGFCxuPzxNkoGcsLBgl8+klSY6SygNyU7MIHi5poAvURy2ltT
   T3F2vdW5epcbVhPT8+k2rDbxKT0xknAQMYrN+F+AOlEuRWYrlrQp4taBa
   g==;
X-CSE-ConnectionGUID: urDikFfIRES7Hvs1LqUSGA==
X-CSE-MsgGUID: 6tiIJTmcRHOe53bmDPgAEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75671094"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75671094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:09:45 -0700
X-CSE-ConnectionGUID: T3pfC81nSjyxAMJ5SoV2Kg==
X-CSE-MsgGUID: l3qok6TIQsWgSbTvfoUhng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255669424"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:09:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:09:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 19:09:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzevyT6S7gKJvvjACGTcAMjw5mcb6AlJyPBNnXdM2O7qYkGKlJI9NID2UEFxRR/4Of4AWh1Fnp7CcIQiEOJ0PEWvM9x3kXwlCk27pA0GEGzdnQrtMU8IpNV4sxMtHHWcMqN+c7PiPA3zHhFz20TwLDi/zyKSjfBm0jeHbcUJ9mC4aFjIOFTKQsKjsBtMC07QyJomkeeFJmmGH1sjsV/nE3kWZAGlNtZS3Po9Z8YbP5pxFdYoBvonETE6sC9JOUVPUVNc8+daVQ3Zmcgd0okkpGJGwldGOYmVHkcKbqYMcAs146OPjYtcJV5r+P4CngEfMmqNKiUrNt2aTyD/dTMxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2c0WhuWpP0dfIe8gdpkGZL6VwpPFEO5EOItjHmLD3Q=;
 b=nDpWZkrX2Lq4o6x7PBMVcC3v4MzmApjUtPbfQZ/a7aBXfHZeq8Mii0FiiVDr7HH49VTtGUFEf+Qzg61veCEDJZ1mIfO/W47TEqKp2xH9wApnUCi5FewTQPXSCgu4CYwnnHTZkV3IVqN4H9YSYAl/gcBx8VKBXZyALSCkQxONXiEKTU0RJDxM31z2qUCxXWIMaI6JDA39fvnYEN+gQCZj8lMReqU3IbIpKlkgv56g9jplL1UdMGeLlPlvMfH3dY8idEVksLL8/VnROjy0tJ/Gag+81KhqexLoLf70/sDDix7BP6jK08KzlIb1+EMg1bb4uuvCe45IUTTf2Vd9BCDZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 02:09:41 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76%5]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 02:09:40 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Paul Olaru <paul.olaru@oss.nxp.com>, "Laurentiu
 Mihalcea" <laurentiu.mihalcea@nxp.com>
CC: "sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
Thread-Topic: [PATCH] ASoC: SOF: Don't allow pointer operations on
 unconfigured streams
Thread-Index: AQHcvTBfv5wVFO9Vh0quufpw8d9N+rXBorvQ
Date: Fri, 27 Mar 2026 02:09:40 +0000
Message-ID: <SJ2PR11MB8424B402A94D8CB8A178BF14FF57A@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
In-Reply-To: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|PH8PR11MB6928:EE_
x-ms-office365-filtering-correlation-id: bf0b96c3-591b-4a4f-b47f-08de8ba5e7e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: EDgoH5qQ4SByhKKAk466hsNTEvyVjtBB+q9MRP6EmMwD0lNOgndPzo8FudLI5nAOEbpND0dL7M3XbKTTe6LxTgLKb/1s6+Fqx8NtVJgqWkru7pavx1HlwfhR42A9ddZQJV9GuHBSZOwGPF0CnGn2LXqAVS1JMwL2zlorOtJWbozS94j54WVU44rPPMi/kNIvx4yqHgxF8jabbjOjtHX93EvcBV5ACdZFV77gE9e+STadY/n3KKDWSb8K4Y3OwHOWHgJjlwyYJBlmOWd60GMWwGmuI9dCI0/Owicf7n+DHk4sjhoD9XNFZ6HIKlFZxla83WOFXGA2AjnPFkq4BUJV7iJnwEfMUf1ms566jDuHQEtEIm0g2LNn44WNzzUDFIUhzMZQB+qjtbXGd/G0x/9ATzrFeLUNNuQk9r7T//r14urcDj9mkIC3NdHtjEXZUiK0HP1yeL5+KibSXfTTRwfr05iwQfuVN9VRG3lBNCHlZB2RlTdEe1w1rMVvwerBfHUlXpX2urInQ94a1x/0HXIc/0aYA+/eVwbETL6IsHnGvnZtYhW4uMeapc5P1e1H+TPtW0lbpFUOxWflTql8Ohu3HLAFiyuzdTQjXRanSvvNBmuO9730W2VEuyRGAm8rj397fvmJVQ1JPAvJH0rK4sE8YOIVsHEV9nH4fkb5oxv8tTJrgGX7CofxmDt33zKYWRDuOidrZKTZK/Ik8F+p9lVPUO/iq3MSXl9oMBnW3fL/7BwIw8Brj57++XdfB6rESgjJUuM1KdPT3AHVZN5lcBkw1n6dD5d91B3uNtneikganU0e39mkTgtSlHaLaQuvxML/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Y3MXZzU0krK21oMGRWYWxudUJLek1aNmNRVUZCcytWanJxK1g5eGxxVUIv?=
 =?utf-8?B?VHRJWDRLWTY1c1JnNEd2ODVVc3NZeHlHakJaRDZYMGlTVlRUeXVSdndVbnQx?=
 =?utf-8?B?LzhFeVZnL09JOWRqcy9HV3JKZVpmR2NjTjhrdE1JN3pCbi9SQ3pYdUYwZkxS?=
 =?utf-8?B?RWhHSEpwWGtBeWgvSDVSY29MNEZ6R3U5Y1pMbnhKK0hXejAyTkszZG4xMFov?=
 =?utf-8?B?bmhBUkdDalk1TVlCcXlHMWhXdWlVU2wxaTlrVXpGdDhBTkVweTVVZ3lmWW0z?=
 =?utf-8?B?ZWpPaXJUWWZMbFN2bE9uNWNPK3hRdFR4TlY0YVlSS0Z3ck41S3RrWUlLT0w2?=
 =?utf-8?B?N2I1VG9GYnFwTGc5bXZZWWJwOWw0UytlUDMzUi9jd0pSMk1uQTl5YXRLSmZ3?=
 =?utf-8?B?V2x4MzRURVJOVzFFUjZyd3diRTlZeWxHSWRSQ1QzSnY0YkpjSkhZUDdzWXU4?=
 =?utf-8?B?YmR0YVRzaEoyeTE5RXZIdWFRVTVibXR6emV1VUY0YUlXS3lUTHNVUnp2SHNY?=
 =?utf-8?B?eG9jcnlxdUV5a09raVNybEh1UjA1SmpTNzhxVWVrTHFUTmdtMDlNNzVkaFJ1?=
 =?utf-8?B?OXd6Q0xzMVc5YVZkYWJzQWxkakdhRGJNeldpeWl3dzJseTNIMHRrWGpHdkor?=
 =?utf-8?B?SXhDeWhzVC8vK1pBN0FVYTVOUy9qblJwOHRteGNGMWQvYXV6bjByakVEamdJ?=
 =?utf-8?B?anBSQmRKRnNwRjdSS2VvalQxVUtUNXFyOWZYMUdhcHBHNjZsd0VadGVxZzRi?=
 =?utf-8?B?Z0JCTlJSUWdIV2pBd0ZUSWVicjFCWXFFRGIwRDBZS2pHQ05VMzlpcW1KUjkx?=
 =?utf-8?B?aHZ5bDllZXRhcjhTaXVnYVZieUcycjE3K2J1NHpHOUYwaU9Zc3c4S0UxcVAx?=
 =?utf-8?B?MHRSZitSVHAyRGJhWEtody9TMU82ZVRKSkpzYnFETkhsb09kQU0xY2Qzd0Yx?=
 =?utf-8?B?UFlTcHROYVdudFNZYjhZWE5yc3M3Q0xQdGhKcWxDSGswNnJidDhNSVIxckVU?=
 =?utf-8?B?bWlVa0JZYUdmRkhydXRFaGpnaWNLeVhSa1c4aWJ1cktPNG9rQWVpRWFoRC9X?=
 =?utf-8?B?VXBnWUpDK3dyc2lNdVdWZ3BmMUV0OWExRmVBVTNhSWdhUFBDdWIvTHdHYzZ0?=
 =?utf-8?B?bUVibHQ1cFB1UGQ0OERGS1pHcysxaWRlbm1sWVJuWHcvUVNGYWZYUXBURUEv?=
 =?utf-8?B?QWY4aWdkMUF5bkQwVExLejV3N25nQmJrbmlkdjdNa1pKNWpaWjlLWEFpSHR4?=
 =?utf-8?B?ajZkVVhmbUY4WWhZN1NYKzFIbzRkMVBIUjZjcWJWcnBWTlJmRXAvVnhyb3Zw?=
 =?utf-8?B?M2pTS3Y3N0Z4K1NwT2xhV05vM053dVJRSjlySU4xb1p3eC9aaWsrUDNPTVZj?=
 =?utf-8?B?N0VzbzhDclViOWtRdzhjSXRwQzhielZHUEx0WU9LZHZsTUl2bWUxbEd6UHFE?=
 =?utf-8?B?dmk0NzNpcXFyQ213RHRyZG1wb1lPOTlaYXZCaksrbVdZTDFhV2p6L0ZvdFZQ?=
 =?utf-8?B?U2ZYdUZ0aVJZWUFJUCtnVU94RDhjelg2L0lEemEwdHFtbFlPZVZEVERlaGx0?=
 =?utf-8?B?UmlSUXo1bC9mVlE1WWpXSklmd21vZnFHQkt2MEx5c2J0eXZpM2pBc21BMXZm?=
 =?utf-8?B?V1JtdWRGaFJPelRhbGc3RnU0b0pNR2huMXVKTEpLcnBGSjRBUmE5YThmWHJs?=
 =?utf-8?B?d1AySmNyeVBKSTVXdTR2NVl5Wk9CbmtUWUE5NzR5M0xhbmdScDByYVlyNk55?=
 =?utf-8?B?dERnTEprMHNDMDk3RzhVOGpmYzNLWTVjMnMrTzlhMHovelB5M2NwZWtmUDZS?=
 =?utf-8?B?YmUraDl5SXdkYk42eWEvMEpTOXRBZjBudUdvUVBLWVVIdnJHWXJmYTVyd0ha?=
 =?utf-8?B?RVFGZzVRTmk0SEFKVHJQMTh0R1lOZTdCamplbjBHUlhDc0RxTndHa2pGUmlS?=
 =?utf-8?B?YkQ0K2tQay9XTUpuR0lHcndrUXVwb2hlV3RLUVR4TUlwMkRLVGQ5WEs5Mmxl?=
 =?utf-8?B?SXJNL1NtZXBrcUVKUWl4WE15cmpxZlVSYURnUHNJWW1HbllBSVJ2b3Nnb3p4?=
 =?utf-8?B?VGFXcW9SemcyOUpBZnI1a1FhbkhOaWtUWk9SeXkvd0tRWlFtTnUvbS94MU9Z?=
 =?utf-8?B?TEdobHRCcE9jTnZuYXd0SE9OOTBrRTRDWGZEWUdObHcwMXgyRC80ai8xSitl?=
 =?utf-8?B?TThmZ0lVeTViTEhwUE84UDVMaHd6WjR0bEhla00zNmJ3SmZqVWdHczBkbHhR?=
 =?utf-8?B?RzdXcXJYQ3VCVVR2c0h4dy81dThqQ3NMMExQNEVTNVovbWs5ZGVaMWd3S2JK?=
 =?utf-8?Q?2rISofQ1nWcLAD8qZa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LDqSG/7bN+Ro7c9bRJ67J3hMmkq+llVdK07ePDnyM7MAz3ZTJ8oVrd1/fZiIzAfPOTzoPn42NfVz++pRq4PolMHhiTTnEgLIOSdYG5sQI98JB44WYEwcQq8KGB6vALb3ge+oj7O0AwjQvena5Zkp5z4Q5gBArbJToiGXMT11OYHSN5zizcYImJH3cPZyNFryhi79mq0UCR1jD2unqpKWh2WTmvY12jTWn3/vz46Gi6vh8vrL1QH6ynIZqxxKqgoQ5F85H9wMDxAmlatdg9zbHRXXsPg834Rldsfxur6KjVTg9tLSeeBpZdZoZg6xlpjJKYx0StgkFSZ29ndtIyn6Aw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0b96c3-591b-4a4f-b47f-08de8ba5e7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 02:09:40.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMcx6YcQXDaGOfxKhzHdbY863WYuDyCCjSCI/Py9hizJrX+7CZb/0ljyZIEI/MW3tfieMltfX2S4uGUHPLX0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230569-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bard.liao@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 84AE133E17A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBCcm93biA8YnJv
b25pZUBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjYsIDIwMjYgMTA6NTMg
UE0NCj4gVG86IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBQZXRlciBVamZh
bHVzaQ0KPiA8cGV0ZXIudWpmYWx1c2lAbGludXguaW50ZWwuY29tPjsgQmFyZCBMaWFvIDx5dW5n
LQ0KPiBjaHVhbi5saWFvQGxpbnV4LmludGVsLmNvbT47IFJhbmphbmkgU3JpZGhhcmFuDQo+IDxy
YW5qYW5pLnNyaWRoYXJhbkBsaW51eC5pbnRlbC5jb20+OyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwu
YmFsdXRhQG54cC5jb20+Ow0KPiBLYWkgVmVobWFuZW4gPGthaS52ZWhtYW5lbkBsaW51eC5pbnRl
bC5jb20+OyBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLQ0KPiBsb3Vpcy5ib3NzYXJ0QGxp
bnV4LmRldj47IEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+OyBUYWthc2hpIEl3YWkN
Cj4gPHRpd2FpQHN1c2UuY29tPjsgUGF1bCBPbGFydSA8cGF1bC5vbGFydUBvc3MubnhwLmNvbT47
IExhdXJlbnRpdSBNaWhhbGNlYQ0KPiA8bGF1cmVudGl1Lm1paGFsY2VhQG54cC5jb20+DQo+IENj
OiBzb3VuZC1vcGVuLWZpcm13YXJlQGFsc2EtcHJvamVjdC5vcmc7IGxpbnV4LXNvdW5kQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0hdIEFTb0M6IFNPRjogRG9uJ3QgYWxsb3cgcG9pbnRlciBvcGVyYXRpb25zIG9uIHVu
Y29uZmlndXJlZA0KPiBzdHJlYW1zDQo+IA0KPiBXaGVuIHJlcG9ydGluZyB0aGUgcG9pbnRlciBm
b3IgYSBjb21wcmVzc2VkIHN0cmVhbSB3ZSByZXBvcnQgdGhlIGN1cnJlbnQNCj4gSS9PIGZyYW1l
IHBvc2l0aW9uIGJ5IGRpdmlkaW5nIHRoZSBwb3NpdGlvbiBieSB0aGUgbnVtYmVyIG9mIGNoYW5u
ZWxzDQo+IG11bHRpcGxpZWQgYnkgdGhlIG51bWJlciBvZiBjb250YWluZXIgYnl0ZXMuIFRoZXNl
IHZhbHVlcyBkZWZhdWx0IHRvIDAgYW5kDQo+IGFyZSBvbmx5IGNvbmZpZ3VyZWQgYXMgcGFydCBv
ZiBzZXR0aW5nIHRoZSBzdHJlYW0gcGFyYW1ldGVycyBzbyB0aGlzIGFsbG93cw0KPiBhIGRpdmlk
ZSBieSB6ZXJvIHRvIGJlIGNvbmZpZ3VyZWQuIFZhbGlkYXRlIHRoYXQgdGhleSBhcmUgbm9uIHpl
cm8sDQo+IHJldHVybmluZyBhbiBlcnJvciBpZiBub3QNCj4gDQo+IEZpeGVzOiBjMWE3MzFjNzEz
NTkgKCJBU29DOiBTT0Y6IGNvbXByZXNzOiBBZGQgc3VwcG9ydCBmb3IgY29tcHV0aW5nDQo+IHRp
bWVzdGFtcHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgc291bmQvc29jL3Nv
Zi9jb21wcmVzcy5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29mL2NvbXByZXNzLmMgYi9zb3VuZC9zb2Mv
c29mL2NvbXByZXNzLmMNCj4gaW5kZXggOTY1NzAxMjFhYWUwLi45MGYwNTZlYWUxYzMgMTAwNjQ0
DQo+IC0tLSBhL3NvdW5kL3NvYy9zb2YvY29tcHJlc3MuYw0KPiArKysgYi9zb3VuZC9zb2Mvc29m
L2NvbXByZXNzLmMNCj4gQEAgLTM3OSw2ICszNzksOSBAQCBzdGF0aWMgaW50IHNvZl9jb21wcl9w
b2ludGVyKHN0cnVjdA0KPiBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50LA0KPiAgCWlmICgh
c3BjbSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArCWlmICghc3N0cmVhbS0+Y2hhbm5l
bHMgfHwgIXNzdHJlYW0tPnNhbXBsZV9jb250YWluZXJfYnl0ZXMpDQo+ICsJCXJldHVybiAtRUJV
U1k7DQoNClNvcnJ5LCBidXQgd2h5IGl0IGlzIEJVU1kgaW4gdGhpcyBjYXNlPw0KDQo+ICsNCj4g
IAl0c3RhbXAtPnNhbXBsaW5nX3JhdGUgPSBzc3RyZWFtLT5zYW1wbGluZ19yYXRlOw0KPiAgCXRz
dGFtcC0+Y29waWVkX3RvdGFsID0gc3N0cmVhbS0+Y29waWVkX3RvdGFsOw0KPiAgCXRzdGFtcC0+
cGNtX2lvX2ZyYW1lcyA9IGRpdl91NjQoc3BjbS0+c3RyZWFtW2NzdHJlYW0tDQo+ID5kaXJlY3Rp
b25dLnBvc24uZGFpX3Bvc24sDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGMzNjkyOTk4OTVh
NTkxZDk2NzQ1ZDY0OTJkNDg4ODI1OWIwMDRhOWUNCj4gY2hhbmdlLWlkOiAyMDI2MDMyNi1hc29j
LWNvbXByZXNzLXRzdGFtcC1wYXJhbXMtMjk2ZjM4ZjE1MjE3DQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IC0tDQo+IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCg0K

