Return-Path: <stable+bounces-179238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB24B528B4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A2C1B24943
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8E259CB3;
	Thu, 11 Sep 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZmjvnGf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A411CBA;
	Thu, 11 Sep 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572070; cv=fail; b=dBJIcQcFVw/et+9paABAFTs9lTc/jexBK2YALnToHUOXpqBS8+pLZVZq/yZUDby9nd1iHmPVTg2wbDJC8Zs1WyLgrDTFDbTYJMG407kD3HL/gw881xF1S3ue/DXRj52MKeWuRHmYXe1MeRC6BTIONCpMgmab9Z4+Iwv0FxeV2Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572070; c=relaxed/simple;
	bh=Vx9l/Ilvs2/oF5DFlS5Upt7BNPyDJWywScbPZ312Cxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0S7hu5fU7TbJ4YuFXfWSUjcNDg8LSrzYfAW6v5o1gJ5dgFB+MscRL/v1R/HSDbhDT71J4tv/nF8NcS6P727A/S9M3ijufeBBGE40JHCfyMG6V0SZ9f5tPxiplF2UAH57qzLYYSPr7Ed6MFKWXAcGookA7cIKau2w9X+JTZP2c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZmjvnGf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757572068; x=1789108068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vx9l/Ilvs2/oF5DFlS5Upt7BNPyDJWywScbPZ312Cxw=;
  b=UZmjvnGf+j1/227hmV6edBV9MS03ySeeevTjH1jD7U++0Mt6UKyDLAAz
   VUAmgkfj09qH4a2aFioxRbszDn/y53HQ2jwm9cIbsa3a5BL5j2HBpGJ3s
   NMS+WUeFpeOMfeP6bZr71+QUlcXSU+CCmAphIZ9dIYjGbpHQjvrDjtx1R
   1INa8og1uIFMksTshcZaYFPJVULtBXRiy2A/KNcJROKzZBNJokYpCUInT
   jpjZDNJp5SXAPRMLjTzOiUHm8zzjCP3m7QmqJVkW0oYUIt8jRHSQ2SLXe
   NdpcAK29rnlnU0pBy55ALkiN0kCi2+NIHhr4iM1Y25FA4AlEgiua5/LAc
   w==;
X-CSE-ConnectionGUID: Zzn0PqscTlCt9581xmTTRg==
X-CSE-MsgGUID: NOuWQV9NQWqhgrNGOWaY5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71317833"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="71317833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:27:48 -0700
X-CSE-ConnectionGUID: 6lpeaUrkTsq/5zUOhXMkqw==
X-CSE-MsgGUID: KNAqoZ2US0qfXh1hby3juA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173164885"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 23:27:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:27:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 23:27:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.89) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 23:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoIAri3SAQf8heC3zzU5vMxptTbBNvKcmaKg9Dee7wV+cC9zAvVPL8dhGuSIeH6eP4/ZJFqzJHTYmIGUvWsT5b+c+r3uAGgr+Qf6icNgIk5CHS9arX6P0Sg7X+Mbhd73QNZPVw6WehsZqx1pwTJ1/Wk3mUH2K9ivbpA/JPn5E/JpGosMFQ8weaG5a+/KweFLjQe7ncOTdbcNh58w+KwRB9cZqkUr2OrASpIlCz5aWpm3p27epT8mLXnwAOehiVlXjIkKEFVCWyn4+HWwzAc6lc8X64+j86U3+IvV1FeLhNPx+XkXzEITmDFlGRYt2A+1uijAA0J5om7V4cn7RBbEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx9l/Ilvs2/oF5DFlS5Upt7BNPyDJWywScbPZ312Cxw=;
 b=weRQfWlKUJ+hspObha5bbbq1h8QmX12B7/lav/MD31cNN6sLl6cDP8Rue7sQ4xr5TL/DffGV+BPRzTRzHjYBh6KkMvv0HDX9UlHAQ5OWXdz00UXqTys1GepMP5nsUmCsYxHH934lJBYLvJuoYkMyfTrFk73T0KSmbNGiAorxtrRImtvXp8RufMbXLKVi8URBgWUtw8nPaMywZ80lkg4i74USZK+8sZI6BgGcy5juzQUNvPoL3t7+nsHekvYL5j1Cl2zgHa9stMjqm8SHfl3lLekBxy8xGbthajtq6w0oJ/RVVTIZ0t7i3pUKu5nRV2N4sLQHqzV8nStZRJ3fPHT8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:27:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:27:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Farber, Eliav" <farbere@amazon.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "Lifshits,
 Vitaly" <vitaly.lifshits@intel.com>, "post@mikaelkw.online"
	<post@mikaelkw.online>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chocron, Jonathan" <jonnyc@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Thread-Topic: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Thread-Index: AQHcIuNFzNDu3xP25kGnitxOrKkyMLSNg8Tw
Date: Thu, 11 Sep 2025 06:27:43 +0000
Message-ID: <IA3PR11MB898660189DDF668D00B1364FE509A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250910173138.8307-1-farbere@amazon.com>
 <2025091131-tractor-almost-6987@gregkh>
 <f524c24888924a999c3bb90de0099b78@amazon.com>
In-Reply-To: <f524c24888924a999c3bb90de0099b78@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7507:EE_
x-ms-office365-filtering-correlation-id: e2d1a438-42ea-4abd-b5b4-08ddf0fc5120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aHBrNFVrZDE2R3J2c28rdXh1R3BRS1Z4QVFRMlpHb2ErYUpXY0JYaWRHdDUx?=
 =?utf-8?B?RTRYUzYyanNYNWlGWHZmY2tidytic1B0RWM1bEFLaEM2WE5mQ0pFRzh2ZU5w?=
 =?utf-8?B?cEMrUHJQblZqTVpITkJtZnNjYTlRWXd2S2pRdkliS2lEY0FsUEx6d1pJelZC?=
 =?utf-8?B?R1E2ZE51TlFGYTJyb1lYRmRKTlJoK2V0T1Ixb3ZnNFMyaFNZSEhlWDdKVzlp?=
 =?utf-8?B?eWkxVHEwN2R1T2ZTWGZSY3g2aXZCTmIySUFYU1M1QTR5bHF3V0Z3NEtYZ3FE?=
 =?utf-8?B?dG9TbkRqVFVDcmxHSHpydGdMbi9ab1ptZ3NCWVF2d2xCVjdVcVJ2TUFpMWxR?=
 =?utf-8?B?bDZDYzVVYWdSWmF5K21VSzVHQk9pUXF5Rk9Fdis5djBxcm91TzVwb1JRd2du?=
 =?utf-8?B?VU1FeTZGYVlsNWJVSnVlZzJkYU0za3NXdGFLTTVONjJ6YnBPamZuTXNlbjkx?=
 =?utf-8?B?Z3JOT1VHQ3JtZ0g1YkpmNEJmRUg2OFUyM1J2UmV5anhPQUJUZ3gzaHl6dXdI?=
 =?utf-8?B?ZmEvSENITkM5cFhQUStYeGlRVndUNXFaZWY2NWRLbzY1Vy9NU0R3Tk5UNUx2?=
 =?utf-8?B?a0JOMU9lTTJ1OHRkNkhDMUxEckQwOG1UakNBWVF0bU5oYVNBd2dXV0duWmNE?=
 =?utf-8?B?U09STEVJcTBCUEdINWsxUy9PTC9qVTEyWHdJQjN2SlRSMEgvcUNEWmdGTTdo?=
 =?utf-8?B?by9veDI0WUVQSXhnVFIzQ1NIVDYxcm9lOHMwalFaOUZBKzJlcVFVZTdUNzVk?=
 =?utf-8?B?cjRJWDMrZndCUDJmdUl5bU5iZ3k4TTdRT0o5ZkJEbE5rbzlJNk9nT010S21G?=
 =?utf-8?B?bUJtanNVaElsdmI0b05NQ05FazJyMitoRE45YjJjeVh5VGdOakh6dEppTG80?=
 =?utf-8?B?TkVsaFh1ZDRZdDNwcEEvc2RWbUVRWVhsM3BrM1hsRGhaZnlkSXg3OEFOQmlz?=
 =?utf-8?B?RFRXWHB0eGhyQWE4eHdpQVBsYnl2bU1QbUxWaTlmMW5GQVBreEsyUDlzWWda?=
 =?utf-8?B?YmNVQldpVzhZUXNGVHBSWjFLOHk1OFhRT0g4cXZPY2NEaTRPcStIT01ndjJt?=
 =?utf-8?B?ZisxR1hydDNqd09RL1FpaWUxcWI1WlJyTS9qbG80aGZKRGpZaldaSlVSRnlX?=
 =?utf-8?B?V0R0NkJtYTdzRkZaVmJHZ0xuRjRGUS9FVmxXbStWVjhrK3oxR0ROUlFRcExw?=
 =?utf-8?B?ZndvUklIaE41MnJZY0YwSnhtdmV4T2FFb2xxYjBRaldKb2tiWURwQmV3TS9X?=
 =?utf-8?B?QWtlWFZYN1VSRkJyU25QMHZzNVR4QkpVWmVINUtMcWJ1a04zVFlsL2Vud09H?=
 =?utf-8?B?UWsxWENLRE5mSzBmd1FxaEZGeTJYZHloOTJrdHpLb3ROWXk2azE3RTVhRVBv?=
 =?utf-8?B?SDdDbzVrcGJWR2k4cjF1U20ycVVvdkxYQ0RDTHF3eERLK3piZEI3L1dpbzRG?=
 =?utf-8?B?TnVHTFhpSXFmS0VDQkRXZ2U2QngzZkU3eTcwQUZLTDBSRTFtRklyMHNCUGZW?=
 =?utf-8?B?dG8rQjVNMmxpZ25yd1dhemFjdE1yZyszdjRmSk1mRFh0QlMvNXZWYmE1cHBC?=
 =?utf-8?B?OGhMeVRYWFRtWTBkbXRBYi9Eek9aZWIzVnhGYldhWUxNeWpLV29QQm9GMkhV?=
 =?utf-8?B?ZEtKaEdMOWVNaWcvZ09jQmpTc1gxcWU3eXZ4OVJpQ2haam4wL2NVUGt6Lzgw?=
 =?utf-8?B?emN4ZGNjVVVSOTU1NUFQR0tYaXlDMU1RVkp6bnRMdzVNSDFvRWhKSzQvS3Qw?=
 =?utf-8?B?bFdNR1oyK0dLSE9TSUdYUDdaazQ0eSt6Q2o2N2pLeUdDTVlWcEtaUE1QMjU5?=
 =?utf-8?B?SzFDZkVFWktpMStqN3F6Q251S1NMSWlyNTFpcDlPUTJ0K0N6MVZFL2o5elQy?=
 =?utf-8?B?K2VIeTZWZUxDQkFZWVdtSkl3OXhYcndlM2NtT2g3V2tIM2ZIZjN5U3VENEdu?=
 =?utf-8?B?Ni9yS09xdFprbEtSdmEzcWJPTG9yT1VjaVdRKzhJVlRlWWpzbmFETUM4cG5U?=
 =?utf-8?B?UWkxTWhkMGxRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlY4Y0ZhT1lTcGlLZStuTnpQZVUyZk1GTGx3UEJNQzQzU3NQa2RuQ3dZeEJS?=
 =?utf-8?B?OHludGNmSjRUVmp4NEZReGNmK3kzWVRzaURsbThHVFZ1SzRNRWZNZG95Q1VD?=
 =?utf-8?B?QUNHejY3alNtajRNbjArSzNadzhQR0hBYkhoNUR4NHgveDhDVHRNTHZua211?=
 =?utf-8?B?bm1lMzJBdWRaeUxzR0FSbXVRMHlkTWExaWttU2JnWmlaWmN0RWpSZy9DcDBT?=
 =?utf-8?B?MkkyenhuSkQ0MHZVVXltWnlCNzA2NVE3RVdNYWZlejRRZi9ueUJXcXkxbVhX?=
 =?utf-8?B?QWc1aVl5Q3RSTkVQdk1NSTdUVFI1d0NXaVdjdDJIMGdKcGtkSTlSbkt6UlhS?=
 =?utf-8?B?ZHVpS2daNUdQWk54Q2VzOERKWEQreUoxOEltL3pFWWdYNGwvdXBVVXpyY00z?=
 =?utf-8?B?SE5ZTTBzYXJ3aHJobElhMHE5V2NCMU1lSlJoQXhuNUdEaXlJOHh4N2JGWVZL?=
 =?utf-8?B?MHNaK2Q3R2NvcFRXYXRnM2txTlRMbmw5UTF6U0E1eG1qS2FKU2swelVqVEV1?=
 =?utf-8?B?d0MwNzk5NEszcXhGVFJjVzlQYUhCaEQ4K1RQdmZKaDlJN0JWcDhSRFo2SFZi?=
 =?utf-8?B?Rk03MWpzOXpQaDhITHBhMlU4M1Y1RXVTUUdBejdubC9QS1pKNDh2VHQ5MS9R?=
 =?utf-8?B?VzEvS25DZmprQVdSY2NGK24yNEVrSFh5NElDRGtaUFdicWI1YzYrTzEyQ2h6?=
 =?utf-8?B?TFU1TW9nUjd3WVJXVnluN1pFZ0FML1VHdW4zbFc1bngrZmp2dUFGTllBMkxD?=
 =?utf-8?B?ZXVxZXNtcFByZ1owN2hXRUU2KzZvZDdueXAwYTV6SUxvYzRCWjR3YnRLdTZQ?=
 =?utf-8?B?NVNla0xKWnNUbWJtd3J0YnBScEQxTEdNYi8xMElqejdRNUx1emlSd3BFUndl?=
 =?utf-8?B?cjVMbk93THdWaFI4Y0daVGdBVXJGVnVqTk53SHNkeHJnelJVTFBTNmJDcWM2?=
 =?utf-8?B?em9qbW42VGNyUUVvVWttaDJSK2M5Z2hyMjNuRXcrQWVPSDhlbGZWVzZtR1lT?=
 =?utf-8?B?V0c1MDRoVHM4OVd2L2ltaStQaWQ3d21PekpNSzRlVm9yME9kRWFEelBPdFpD?=
 =?utf-8?B?cWYzeXByMjk1anZmMzBpcldOaGxod3Z4K1Z4VStDdEYyK1Q3YUtXb2JrS09U?=
 =?utf-8?B?aWwvU3lrdHNyY3VBTzV1dkp1MzFCa20yMFg1WURNblRkOWdDTzI4Y2svOGQy?=
 =?utf-8?B?OFRhTkNtRXd1aUtWUmY3UkM2MUNkcGxSWUpYM1dSTjhTWWRicVdYMFVnNXFK?=
 =?utf-8?B?SWtHWUZmbjJ4c3lTNWJ2THpCOXhnaDllQm93WGJiMHZCd1RiZSsxU3hxaFpj?=
 =?utf-8?B?eEViRjlTdjZjbUpvajJtdjc5NnNzejMwdURjK29ocjRQMy9VekZWK3J3K0g1?=
 =?utf-8?B?dE16cDUxaHQ5NSt1RnB3ZWNHTHFpbXJqZHZmYU1YU25zcEFOcFVpWXZyTmdn?=
 =?utf-8?B?ajBmRWhPejMzbEo0ZkMxL1liQ3Z5UVJtOVdmM2xBOXZ1V0xKbk5Uc2V2THFD?=
 =?utf-8?B?SHdGdDluQ2lkckdIcW5SNGpJNlYxNTVDYTN2SzZQdjJyak9udDlMb2xNVTZB?=
 =?utf-8?B?UE9lZjZJeGRyVytNM0xCQ2hMd1BYOW84cHRBSUtzaE9RZTd6dFJDbHcrOUY2?=
 =?utf-8?B?T0IraThiSmREMzFrZm01akpZNlNLVHFzQ2VSNDdETk0zMEtLeVZaNHR5ZTFP?=
 =?utf-8?B?VGtGMDJZNXoyVjIwTkV0QmV2YmVtdEFlNm40dmhzSkhqdE81aHNOcjBGM1Vl?=
 =?utf-8?B?aTZMTjEwR1lIYzJrRUlIN3AvRTE3WTh5cGM4bEVsMWoycHdaSDFBekpjemtj?=
 =?utf-8?B?N3N1VTRWTkMxTVd4cjdBZGxaK0RPMEdMSm9qdkIwaVNpTHdKSXJzUlRkUTd6?=
 =?utf-8?B?NW00aG1LSmpHM3VDMkpNN2NnWStWSUJnUmFzQ1R0Qmw3Qkx0NzdYQXpxQXVq?=
 =?utf-8?B?K1VoZ081UEJ5TjFybGdMc0M4OVlIOUN6bGt1OEFSc29TS1VISGVMV2xXUmZQ?=
 =?utf-8?B?TnJLYllUSFN6a3A1cWs3ZFRkNWVzNDA4U2YyNGVWZ29DVWVjNzVKZGRRLzRF?=
 =?utf-8?B?L0Q2RDhWQzVYMitoZ3BiQWt1YTRUWEg1WmZSOUh2Y01uT0R5VjFFTVdxbVlQ?=
 =?utf-8?B?aXpRcHIrYW1zNElvRmlRVGdLUGJJejFMbUZsbTRPMFRTQW9lRWF4b0w1Y1kr?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1a438-42ea-4abd-b5b4-08ddf0fc5120
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:27:43.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy4w1FPeeLCzjh+yzm+cdR7mg38y+/DMWu58cOk4aSyKemLvhLdlO3t8kamwttHZs8Oihmg3K8axcE5rEAPB/c3TtaNtcEx9QZLReaXFL7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgRmFy
YmVyLCBFbGlhdg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDExLCAyMDI1IDg6MTQgQU0N
Cj4gVG86IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBDYzogamVzc2Uu
YnJhbmRlYnVyZ0BpbnRlbC5jb207IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1
eWVuQGludGVsLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsNCj4g
TGlmc2hpdHMsIFZpdGFseSA8dml0YWx5LmxpZnNoaXRzQGludGVsLmNvbT47IHBvc3RAbWlrYWVs
a3cub25saW5lOw0KPiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENob2Nyb24s
IEpvbmF0aGFuIDxqb25ueWNAYW1hem9uLmNvbT47DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7
IEZhcmJlciwgRWxpYXYgPGZhcmJlcmVAYW1hem9uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRl
bC13aXJlZC1sYW5dIFtQQVRDSCA1LjEwLnldIGUxMDAwZTogZml4IEVFUFJPTQ0KPiBsZW5ndGgg
dHlwZXMgZm9yIG92ZXJmbG93IGNoZWNrcw0KPiANCg0KLi4uDQoNCj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmMNCj4gPj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvZXRodG9vbC5jDQo+ID4+IGluZGV4IDRhY2E4
NTQ3ODNlMi4uNTg0Mzc4MjkxZjNmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9lMTAwMGUvZXRodG9vbC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2UxMDAwZS9ldGh0b29sLmMNCj4gPj4gQEAgLTU1OSw3ICs1NTksNyBAQCBzdGF0
aWMgaW50IGUxMDAwX3NldF9lZXByb20oc3RydWN0IG5ldF9kZXZpY2UNCj4gPj4gKm5ldGRldiwg
IHsNCj4gPj4gICAgICAgc3RydWN0IGUxMDAwX2FkYXB0ZXIgKmFkYXB0ZXIgPSBuZXRkZXZfcHJp
dihuZXRkZXYpOw0KPiA+PiAgICAgICBzdHJ1Y3QgZTEwMDBfaHcgKmh3ID0gJmFkYXB0ZXItPmh3
Ow0KPiA+PiAtICAgICBzaXplX3QgdG90YWxfbGVuLCBtYXhfbGVuOw0KPiA+PiArICAgICB1MzIg
dG90YWxfbGVuLCBtYXhfbGVuOw0KSSdkIGxpa2UgdG8gcmVjb21tZW5kIGFkZGluZyBhIGNvbW1l
bnQgdG8gcHJldmVudCBmdXR1cmUgcmVncmVzc2lvbnMsIGxpa2U6DQovKiBVc2UgdTMyIHRvIG1h
dGNoIHR5cGVzIGluIGNoZWNrX2FkZF9vdmVyZmxvdygpIHdpdGggZWVwcm9tLT5vZmZzZXQgYW5k
IGVlcHJvbS0+bGVuICovDQpBbnl3YXksIGl0J3MgZ29vZCBjb21taXQuDQpSZXZpZXdlZC1ieTog
QWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQoNCg0K
Li4uDQo+ID4gQWxzbywgd2h5IGlzIGl0IG5vdCBjYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZz8N
Cj4gQWRkZWQgdG8gY2MuDQo+IA0KPiAtLS0NCj4gUmVnYXJkcywgRWxpYXYNCg==

