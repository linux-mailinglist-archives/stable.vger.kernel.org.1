Return-Path: <stable+bounces-125655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0EA6A72D
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB03B239B
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA820AF6D;
	Thu, 20 Mar 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcTgOATI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013422AE99
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477393; cv=fail; b=Sz6Z/c45o4QvoCQ7XT8Zx8mpg96jHBWelUYW43BuS9oa97SNQTaYCd9VJPl8P/YVXCQF4FfsC18A3beHD2Q7HiAuiXVlfHhhKTKXziXm5Iny2zA/GY5o+4HQBRq1fSZ+Sq7QB05PaL8L7qR23o1GUzH5zksgJrUjaQBoRsJN16k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477393; c=relaxed/simple;
	bh=qC+L/C5MfGvszFGUqfjIfusXo6suRyxoqYJW4ev3HVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b6/Sca0Xct00P2LW8Kr2NmFaiKaPqqRH0Tnyr9s8wj6Gj3jUlNj+DvemUo+CCW3FeB9pl1YqPBiISE0RIkzdRqLsJGUqj/Q5jWksIfp5Gj7GsauR83Z0IeuZ62fjiS9LmMkOPzvo+jVZhgspYpRoYydDyX05RUSQSX0b1/Zre20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcTgOATI; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742477392; x=1774013392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qC+L/C5MfGvszFGUqfjIfusXo6suRyxoqYJW4ev3HVw=;
  b=lcTgOATIk+9Qrzk8VyClJPjgjup6K/17C5xucRxgsQyyWS3nCKqTDTMO
   hqcYqTBZTQWc1nCSiDTjFGyTjvBS+GANPfjoQCB1aT0Mw0rXDrRcBKaf7
   BGnbb214d0gDcYcgdCrEjvlXmmqwF1oKO904LdEIRTBPN6d3Q/K8I0LrQ
   MClNXN84oPvviVuxAFkRlEVdvXtYcQnIAyJWVhntgeY1XFciIwimdtOqp
   HkvoAzk7uv2tMNHgI3S/zhCqS47UiLe+pebvAZXGjhwqG1IRERSJA2Wf7
   Bl9JFNOdBoHqi7hJZC+5Pkzat6aYRs1sz41akyG0vcG8E+YFHZRB+FtHZ
   w==;
X-CSE-ConnectionGUID: JqmfHWbBT8mAkGeEwqV0iQ==
X-CSE-MsgGUID: ekvl+9ElR0efTzyoZka5pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53921888"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="53921888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:29:52 -0700
X-CSE-ConnectionGUID: RPAaeWZRTBSiBfjZbyoqcg==
X-CSE-MsgGUID: J/KpP7uzQeGPTRkAQYPS9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="127782163"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:29:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 06:29:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 06:29:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 06:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McpzrRm4gv7t8SzLGSIt32bIbbjPIGrQyWzsd48ANGoRqlrjfzd1zON5uYGIJYxSjnCBi1YebANAC3Qd33K//FRBPwZZGjbbE/v96vD8LNRl6rMmR8EAwHWFOWh73mweOY3bTqLsqqWCNt2qTf1L1fyl4jHQq0K77JTUo4pp+QWAyIbK1nn7+aHFwkEJKfR5MBowo2BSsOOp1az/ile5MWHkfx2M3aTAm+pB0t+xlFCVRHhzt16lzR3x8/jUJP653gZy2pCOy+0AMPlgVH9KWtuQ3ejsKbf5Z9i2qQPao8Y65low3yoMBRkA02ehfqbDZf/0TMTQwNAryXUK8fy4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC+L/C5MfGvszFGUqfjIfusXo6suRyxoqYJW4ev3HVw=;
 b=r/pNwFqGUsV9Y9ga7WUPLGbC/07EWQvkLRjlFkvBUeijaxPq89UAknD5qwYk87YIuzaNx8CDFa7lHYutUVoTLzNeivj3sSiQsKvnG4AyVAPf9yiT+gSioor2wpXJ8W9XhadJQppf3mYi1Y5Mp05USDy275wypf6yempucTwJ3arbO77t1cgrPRC4w1j4xj/PXtigjNGJiXhhJ1K4nzlI9vIwczM/VGrRtyv4dI/1WMzNnJT6SwhERLYRpm9zJIMIsoWoLJoFBRXtgRlSI1S/wIcrEwaOEVAObGUUE4a0t/BAR0ePq5ep6GTi8FmWRTvhml3yw5E4uSNFaUcu83m9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DS4PPFE12D62847.namprd11.prod.outlook.com (2603:10b6:f:fc02::58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 13:29:45 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 13:29:45 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, "Berg,
 Johannes" <johannes.berg@intel.com>, "Gorgenyi, Frank" <frankgor@google.com>
Subject: Re: [PATCH 6.6] wifi: iwlwifi: support BIOS override for 5G9 in CA
 also in LARI version 8
Thread-Topic: [PATCH 6.6] wifi: iwlwifi: support BIOS override for 5G9 in CA
 also in LARI version 8
Thread-Index: AQHbmZsoqTvquuLBSUasHEFjH7AsrbN8BP8A
Date: Thu, 20 Mar 2025 13:29:45 +0000
Message-ID: <45ccdb188570eb17ae480d2e29aedfc0d284902e.camel@intel.com>
References: <20250320132220.33536-1-emmanuel.grumbach@intel.com>
In-Reply-To: <20250320132220.33536-1-emmanuel.grumbach@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|DS4PPFE12D62847:EE_
x-ms-office365-filtering-correlation-id: d5492122-c836-4ad5-66b8-08dd67b347a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXFBbXFhZEFQK0NSNytIMkRTWE1GMXlQR1QyZTBDTWUyODJsa0RoR1ZObDEy?=
 =?utf-8?B?Qlk0cUZIZ3R4R3ljaXNjb0dzV0x1Vmd1amRHSjhlUEE2ZWo4bWdqbGhkbk5O?=
 =?utf-8?B?emtzRXkyZTY5RGNlUTV1bUJ0bFZRajk2c0puR3ZacXdXMTI3NEZYMTVZYWpN?=
 =?utf-8?B?NnFDRkN2aGJnVlQzZmpUaDZaUXNLSXpoT1lsUUFTdm1QdDUyRjJyYmJJZk81?=
 =?utf-8?B?UitMbjlrTGQ3VlZDOEFSK21NYUJFc3hEcnE5YTAyREhpR1djUUtZMmJSZkdE?=
 =?utf-8?B?NUdrR1NNTTlEREU5WS9PSUt2V0oySVZOeWtEdzN1ZExOcFRua3lUM0ZieUVD?=
 =?utf-8?B?ejFYdlZtcE1yUHRMM2ZxaC95NzFFazZIU29rSUNPNWpCRmtheE43K253M2hV?=
 =?utf-8?B?RlFHYkx3QzRaVkQ4NENlUzVrUjV4UHNpL1RqUXlVb0plRlZBMmdtbHhoWG91?=
 =?utf-8?B?Z0sxVlJkQVJrSkc0bTBEYUpsSCs4azFGYnZ4SVBqR0x6RDVrUG1QdzA0TlRn?=
 =?utf-8?B?Z3lnbWZ3aWJUYkhJMC94Sy84TXFtQWhDZGc0QUE2OEpxblpVdm1HL2g3NE9Z?=
 =?utf-8?B?L0Q2UlpUdU0zVnUrc3BCZ1dUczJOUG1GaWc0ays3YnhSdXJaUy9xS1JGRkkr?=
 =?utf-8?B?ZkwwUUM3QllFQW9VRmdReFJLYzN3ZHozWEd0R2I5NUdrZ2hQVzhjVHRXeDg0?=
 =?utf-8?B?TEtnR3h1cG9SU0tPK2ZGZXAycVNTZUdWVVI4QUovYTJ1L2hTU0dzUEV3VFc5?=
 =?utf-8?B?ZXJNdXJDdmpEN3BGZS9keWw1ZGVMTmN4ZzVWbVRmci8zWU1ZcllkR1ZjWEVU?=
 =?utf-8?B?OUJMM1RCVThNeFpJSFMzQjNwT0pXOEM5aVFCMXc3WHJxZUM2MXZ3L3BFbVpq?=
 =?utf-8?B?d21PY1VDSDRpOWpvQWpvbFk5cnAyV0x2YzZvVlhkWFQraFNwOHpVclppdmYz?=
 =?utf-8?B?VmNYMHFOTGhvNkxOYmlPbXN2dGltVWl5UCtHb0FTdlpTRjRqUEkvajNHS2tv?=
 =?utf-8?B?Z1VJcHBQVXVvdU1iSEp4STZycFlWL3ozcGJzdFJXbHQyeit1RURqT1ZkRUND?=
 =?utf-8?B?djhCbStsb0ZJQTNpYmhwVU1XTWx6ZFViS2YxY0EzOEdMcUlrcENiQXl0WkJ0?=
 =?utf-8?B?UE4xb3hPZU43MWlseW5tck8zRFRqVkpQU3hsM3QrSTVyaTFrNnpvU0FKMERU?=
 =?utf-8?B?S3YxK2hEMFpLWjc3KzdsSUlJNHlKS2IwMVZOS1ZiZkxTTmlFQlNGd0RKSC85?=
 =?utf-8?B?MlFIU2lNc3NhN0lSNDZyK1BJdzZ3V3dnUHU3ZWNwV3lTb2JzSUdFU0xUZGgx?=
 =?utf-8?B?RkRwTC8xeS96Wm53RDl4QXVKZVplalBjdFhwWFhYMlBwYzdyclB3SGtmUlNR?=
 =?utf-8?B?U1paWkdncjB1TG5GU3pvVXpWUDlxcjlBRGhvR2FiOWxoMWE1WGViYkV6QnBk?=
 =?utf-8?B?S0ttb3FqVThBcTlOUTN2NFVxZnNMZDZ4WnQvSUE5U0IzbVNmdnk4dTFPcnVm?=
 =?utf-8?B?V094NHU4NnFyWWxjSXU1OUJlNHluakFxai9DNmJtVEM5azlkYTFBVmZjSVBm?=
 =?utf-8?B?aVdqRVc4Mzh3NEVHZHdwRVE2NXFnTEp5UkFPRFJTdjFGKzJrbDhnL0dSOTRh?=
 =?utf-8?B?bWlldFRlSkdwdWU3T2xXK2ZPU08wRXZUY2ttZE51c2FaYzFYZEI1SXgvcUE4?=
 =?utf-8?B?RE5sVng3NGh3K1hyMlpaZElTRFZ4TFFMR0l1ZVhualp3eXFqYXpmMFhEM2I5?=
 =?utf-8?B?ZU9qTUZwMFAvQ1M5SEwxZWF1V1VVaFlvOXlsVkVOMWVnYlU1cEpTSUlqVmNy?=
 =?utf-8?B?cTRpZ0dOREM0bzJMTWVUN3FEcW5DY1BpcXdmWnAvM2JTbDVCZWVGTDNVbDNu?=
 =?utf-8?B?NGNPUk43T2xSaEFNWDhEQ0Vzb3pPd0JHaEtGTWdhNmRrU3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZlYkxkYzdCOGhYcnkwNVdBTzZUQVZzZGM5azlwQWVJOTNBczdnSVJzQlBF?=
 =?utf-8?B?YzFQZ1JNT1piYTF4MFAyOGRNTmsrUXdIajN6Z0s0UDlBRmdvOGVsUmRHUjdj?=
 =?utf-8?B?Q2lkbjlUT1JWZEZ1YXA0bCs2N3Z6RFpGVksvUERFV3ZGb0xyWXo1NCs5S0s1?=
 =?utf-8?B?WTVVZW1nRHdueTdlUVJPYmNMSVJFTHZ6MTdOZ3hvRitlV21jYUQ0WEEzeDg0?=
 =?utf-8?B?SmpWSVFqSHdPWndhdGduMWp1aUIza0NjNWs5b0c4R3JZbFVSOTA5Tlc2SnVw?=
 =?utf-8?B?R0J5Rmd0VEUwUmtnNzVYaGU1YVFPZktYWDFtQkQyd3NlQWhmVDJ3YXIxbE9D?=
 =?utf-8?B?M29HL2RqWU1LNEd0WjdXVTBERjVCYjFDeVhqeVFJYlJ2Z3kwaXkzSjJvSy9D?=
 =?utf-8?B?VEw4RzI2TW1zRlZBSmJjRkxKWE9idFhINWlmb1U5VVlZbXVIK09Ra1BFeXZn?=
 =?utf-8?B?N1N4UDk1c0FlOHRoYjdVTTZPNXJ4TFRKV2gwaXp0OWpESjY1VFJpc3VXMTZ2?=
 =?utf-8?B?aThnNWNDaEpSY3hlc1FaQXNtdXhwcHhGK1hzdmtBeTM5ZFRTL2Eyb0JFTXR1?=
 =?utf-8?B?aGdlTSt2elgvMUxMWkNlTFQ5dDhINlo2RkM0NVZIbGV4VGVwcUt6TU1JQzFQ?=
 =?utf-8?B?NWRhaDQ1b3hMdlVRL3oxZmgveStEb3hidHhqVEdDT3VQZHkrbDRuMTN6QytG?=
 =?utf-8?B?bGJGbzBGLzBTOXlsYW16QXhaZUNXbVowdk53TGlCVWlYNWx2c0JoL3YwNVJO?=
 =?utf-8?B?U1huMDdGaTBJaHQ5ODh0VmpOYkkvL3NiMFdTcTI4MTcvNFdZejk1YzF1c2Rt?=
 =?utf-8?B?WHhzZk1ka3RxblRid2VDcU42K2RieFdZRUpYTzZSNHFLOGN3MkZreWxtZHpV?=
 =?utf-8?B?cnYrcmFrbW12R0JzUGdzQTRCK3BITGZoZjBycE15Sk9WQWIxUzh4S216elVR?=
 =?utf-8?B?UkIrRktsOVA0WWhKMlhGL0V1d09PMUIxd1RySStpd3l5UWFOSzkvQ2ZaSTE4?=
 =?utf-8?B?alVkZEx2dFVOb28wTDFHSnRnb1dQS1Y5NnN5Mkx6akJGRW9KSGJiVklQM2Ri?=
 =?utf-8?B?SUFEdU55ZERuYWNaeHZTSnlveG1EWENwRlFDdnA1WXQyYUd3bmRqTFJQdy9Y?=
 =?utf-8?B?TEFNU1VuMXJIQW9URk03ejNlU3IyV0RqOGFWRWgyWEpIbWlpcHN1dmZlSjQv?=
 =?utf-8?B?WUMzcXI0RlBXY0FNc1BqUGlJM0ViSzk4YXVObTNrLzdVVlJoVUdXUDNVOW4y?=
 =?utf-8?B?UFJJcUlDR29ZR3prSk96c0lHK3ZyYk5PU0MzM2JwWmNRRE5OWlliTWtTWG1s?=
 =?utf-8?B?S1dTaGtnWVMvK08zNmxRMXA0WnRwRmZZb1FwRVorUFNzcW5ldDJYZlBjU3Fs?=
 =?utf-8?B?SytJOVQxeTJJNEw5MThvL2lwYldrS1hmSXVtd2VXOGdKY0pOTkVZd1pPQXcx?=
 =?utf-8?B?Z3V1LzFUdlRoN3I1L3dKdC9BOXJSSUIvL2V0S2pIODlrN2pKM3pSWUdFb0hu?=
 =?utf-8?B?MDE4R0tvdE9RNC9ZUjV1V3FvMjVuNG1GSUQ2RVhZRklseUEzaXJUdzJaUGNG?=
 =?utf-8?B?YVV6amxUc2lDdms3Y0xSWDh6WkJhMFFtYW41by94Y3JPZXRtNDFLVnZwZUw5?=
 =?utf-8?B?QUFrSmp3dFNyZGVPN1FZODAraC8yNWRBZEZIeGFDbklHQ3RpN0lZU2tGQy9n?=
 =?utf-8?B?Rnh6S2FBY0lLbW1aWW9WSlBHcFhuYTBzZE1VZVpoSEFxSThyWTNNZEQwTGsz?=
 =?utf-8?B?OERpYnVWdU1YZGx6SkJyTjQ1eUtoTkhkU2w2aEQ3SlJabnRJbVFrdjVEcHNI?=
 =?utf-8?B?VmVOS0lpMm9qY2NySkRMeFk4OWIzamYzMWd2c0NNaHFhc1FyZDRNdG5LaDFD?=
 =?utf-8?B?UTJZMk05anpWZkM1Lzgwb2Vyd0t2OHRkZ1ZKeURpVHQ0cHFFMnZWOUpKWjVI?=
 =?utf-8?B?WmdyRUZxMzNnRWFLdmM5UDNXQ3ZEMTFWbk9BZ0VXdDRRRmJYaWpTWXNKSlNx?=
 =?utf-8?B?ZmxrOU9xTThlL29raG1jazQwSEFINlFVdjdyT2djMk9tVTNxZWVGN2RFcnh5?=
 =?utf-8?B?SmpoZ0xJMHU4WjhHNXh2YlRwTURhTk9hOTM1Qkg4NXVMSEZid0k1VnMrbmpG?=
 =?utf-8?B?Vm9KeEdJeXZpZjZyZ2t2UkZpbitUNHdwdGM1QU9HWDBUQjd3a0ZRY0NFSUpw?=
 =?utf-8?Q?RbExFhLTCGi1PcSn8hTJgkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE48042B280654DA4FCDCA618EFFBF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5492122-c836-4ad5-66b8-08dd67b347a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 13:29:45.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3SDo70//9G8AcBye1eanNWxmIgVKvWE+xMFdnLxFUDXjXWhAU+qEWSu2cUz+9kVHX5UXVWnbc8B9ixU8OUatcHic/k7K0eKeL9ThY1en7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE12D62847
X-OriginatorOrg: intel.com

SGVsbG8gc3RhYmxlIGtlcm5lbCBtYWludGFpbmVycywNCg0KT24gVGh1LCAyMDI1LTAzLTIwIGF0
IDE1OjIyICswMjAwLCBFbW1hbnVlbCBHcnVtYmFjaCB3cm90ZToNCj4gRnJvbTogTWlyaSBLb3Jl
bmJsaXQgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCj4gDQo+IGNvbW1pdCBi
MWU4MTAyYTQwNDgwMDMwOTdjNzA1NGNiYzAwYmJkYTkxYTVjZWQ3IHVwc3RyZWFtDQo+IA0KPiBD
b21taXQgNmIzZTg3Y2MwY2E1ICgiaXdsd2lmaTogQWRkIHN1cHBvcnQgZm9yIExBUklfQ09ORklH
X0NIQU5HRV9DTUQNCj4gY21kIHY5IikNCj4gYWRkZWQgYSBmZXcgYml0cyB0bw0KPiBpd2xfbGFy
aV9jb25maWdfY2hhbmdlX2NtZDo6b2VtX3VuaWk0X2FsbG93X2JpdG1hcA0KPiBpZiB0aGUgRlcg
aGFzIExBUkkgdmVyc2lvbiA+PSA5Lg0KPiBCdXQgd2UgYWxzbyBuZWVkIHRvIHNlbmQgdGhvc2Ug
Yml0cyBmb3IgdmVyc2lvbiA4IGlmIHRoZSBGVyBpcw0KPiBjYXBhYmxlDQo+IG9mIHRoaXMgZmVh
dHVyZSAoaW5kaWNhdGVkIHdpdGggY2FwYWJpbGl0eSBiaXRzKQ0KPiBBZGQgdGhlIEZXIGNhcGFi
aWxpdHkgYml0LCBhbmQgc2V0IHRoZSBhZGRpdGlvbmFsIGJpdHMgaW4gdGhlIGNtZA0KPiB3aGVu
DQo+IHRoZSB2ZXJzaW9uIGlzIDggYW5kIHRoZSBGVyBjYXBhYmlsaXR5IGJpdCBpcyBzZXQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVy
Z0BpbnRlbC5jb20+DQo+IExpbms6DQo+IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI0MTIy
NjE3NDI1Ny5kYzU4MzZmODQ1MTQuSTFlMzhmOTQ0NjVhMzY3MzEwMzRjOTRiOTgxMWRlMTBjYjZl
ZTU5MjFAY2hhbmdlaWQNCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMu
YmVyZ0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1h
bnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvZncvZmlsZS5oIHzCoCA0ICsrLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmPCoCB8IDM3DQo+ICsrKysrKysrKysrKysrKysrKy0t
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQpJIGRpZG4ndCB3YW50IHRvIGFsdGVyIHRoZSBjb21taXQgbG9nIG9mIHRoaXMgcGF0Y2gsIGJ1
dCB0aGlzIHBhdGNoIGhhcw0KYSBiaWdnZXIgaW1wYWN0IHRoYXQganVzdCBlbmFibGluZyBhIGZl
YXR1cmUgaW4gdGhlIGZpcm13YXJlLiBJdCBjaGVja3MNCnRoYXQgdGhlIGZpcm13YXJlIGFjdHVh
bGx5IHN1cHBvcnRzIHRoYXQgZmVhdHVyZSBhbmQgdGhpcyBmaXhlcyBjcmFzaGVzDQp0aGF0IHdl
cmUgcmVwb3J0ZWQgb24gY2VydGFpbiBkZXZpY2UgLyBwbGF0Zm9ybSBjb21iaW5hdGlvbnMgdGhh
dCBtYWRlDQp3aWZpIHVudXNhYmxlLg0K

