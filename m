Return-Path: <stable+bounces-166510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5693B1A9AC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 21:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E541819B1
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA82163BD;
	Mon,  4 Aug 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyeSFUPO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AE1A23A0
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335833; cv=fail; b=pt/oFl1VOx5YFmyHGZU0TaGTRKmqktYCN6X+5oh9+K5fKInKse0rbQWvrW8BOFWwjpt8WRvbSIOqGM4No9xv9rcxPvUI8Qkj4jg/Y5KHm4Db2qC7Kwh2cvVruGZrn9mNQRN7q26VpwRTPhVYvgGtj/tSDhJs0am4sGPnGYNTYWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335833; c=relaxed/simple;
	bh=LuMtNqFrqCeU/ELo7XzwxDlSBtrP/ZHYQuiAI3UaGBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9awH2D9V7LMevglV/9lYtt3rU19iEmBtw/oP59aNL5D8gjSYsEifRGCxssRRUI2jXhiDxa7XrfEnGnh/RUC2+mLViFT8EwYHl4YHJGfIM/GHt0O1bySM0frOTe1D2IVkEOZzWjg+mdPU6aBlXMSr/tA3G+/78mkLGMd/cKqrNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyeSFUPO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754335832; x=1785871832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LuMtNqFrqCeU/ELo7XzwxDlSBtrP/ZHYQuiAI3UaGBc=;
  b=RyeSFUPOt4f+smK3EJM+zCQp6J9uMTnS/g/jYNQFhCy3vb1/LEXNzo54
   A2Ic+4lSl5849U3biHN+gjV690CRSTCuZUvdEVcTT03MRvuGcWM6bdUuH
   /GLlLpt1Bh93ctH1i2RI8Dw2rVxSHBsLPWVpRjpOxaFU85zD7H0PgBtuz
   BDtY+R82qtGuZf4Rc/DUWt+vOEtaUova4+9HqfSf2v4xrV6FC0dq5Wz61
   W8vZnGc7enfNTZSffpq3GQK/a9eBiKav9QGIZyjCMEYhImgOUE2JFYBqm
   UcikczunsSEKoEjYuwHOJ0K8+sbaQF0B5EPzkgPBgQMC+LRZYq3I7fLKb
   A==;
X-CSE-ConnectionGUID: 5JsVBrz3RTasI5ab4mnNPg==
X-CSE-MsgGUID: kad4RaXVRIKsktT09vjbyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="44208465"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44208465"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 12:30:31 -0700
X-CSE-ConnectionGUID: j7l2vsxeTum6wf1To7w/ig==
X-CSE-MsgGUID: X+Qv53VBTAaGZjhG8u+JZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164644944"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 12:30:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 12:30:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 12:30:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 12:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/jPV+wCI0YKEm95kt0cPPObNz44CbHHyP3X29LVmpm839TMmIU0HBXwutN/KId8xxl0qfAw8AXvLqfQxRyCx00pqZ/dRx2z6Xp8mGCUCIEhTjpswpQIJKQOczPfsqlB8NxzQPSWkRCmv731ESYuOGhf5tyxqyMK63bZ8O5Io/1Q5VZnIQHOE9SpefIaZAdl1umtEe1MA4+sZDRcXJIw5HNLvtQ8B2uoZQ5H89RAS10lsXcgiLMDVxzzTki/+OfRiOU6NDho4/9iRYTgPWBLlYrrB1fXg8YkoGRRQD5rqvZQ4DkOAwunNMXYknz3w55SyJxMy+u1lfW8xinNgfNTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuMtNqFrqCeU/ELo7XzwxDlSBtrP/ZHYQuiAI3UaGBc=;
 b=Ai9KmOIUCvYufCcJQ2YMJlfh+9gLYRguH/0q6dWATGc6gDflRaCpz+x064YThEgVV2vutb/n5EhFfalDbJR7zvm7PAljtag9m1zLg2ui3HeqFOlwTtjWmSQZcLJnVxmxTfvhuGZQHqR41yLD/4IBEDKnqrKxUbXnarQvryz9dpsPTyDsfagwNJOgj90KVpUPXg3y/x5jCmEMv9spa7kvzi1gZTnujJQmdmdcmaNDagtahgeuolf+HZZH5LjToIQmm1d4mvS0vtVXxCM9DPb23yFx177F2I8dpFbMGuDM12Mc7NEMJdadJ/X8gYF51Dv81O3/jsHrcxfhPmFBjV7HwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 19:29:46 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::3f64:5280:3eb4:775b]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::3f64:5280:3eb4:775b%3]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 19:29:46 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Defer buffer object shrinker write-backs and GPU
 waits
Thread-Topic: [PATCH] drm/xe: Defer buffer object shrinker write-backs and GPU
 waits
Thread-Index: AQHcBRda9Dy0bHypWkmId3w6H4K0F7RS4hQA
Date: Mon, 4 Aug 2025 19:29:46 +0000
Message-ID: <de527a0808c804211c83ee8b16036e1232d87525.camel@intel.com>
References: <20250804081040.2458-1-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20250804081040.2458-1-thomas.hellstrom@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5573:EE_|SJ0PR11MB5069:EE_
x-ms-office365-filtering-correlation-id: b4265069-e9bb-47cc-a8be-08ddd38d4571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VC9PbVR3OXY1bVQyeWxuaWVzMDJyN2NFczR0REtqQjhCRlcwRThvY3JvV3J3?=
 =?utf-8?B?UVl4cmttOGhRVTF0UXRPNW1YMGgraFNaRmNZM1RyTmhwSXQ3cmcwOHJ1OStT?=
 =?utf-8?B?c3FPZVB2aGFvMFZ6bFZvbThvMzFFU0FtamVhTWpiM2M0MFRwWHRGMkx2MVE0?=
 =?utf-8?B?S2Z0YUVyQVYvV21TSTFKa3g2K0tDekM3ZUgxNTRCQWRTelhEdWNDeENRMksr?=
 =?utf-8?B?VjQ4WFpRdkNZZVo1NmdyRE8wQmk4ejMyUEswZTVISzIxaXJGS2FJRDN5R2Ro?=
 =?utf-8?B?QmNoek9YNmV0Tk5ZVlFPSlpyVU9iaE5GMnZEamNjdlovdHBBMFV0dFA1ZTQv?=
 =?utf-8?B?dGFoSjRDNTlUNmdJbm9jcUxwTno0VDAxVnM2em5TMlVlZWRLTTF6RDl6c2p0?=
 =?utf-8?B?K1JsQTdOMWNIbEd3TFRRNFJ4ek8wbk0vRDJRWndKbjl2dUlhTUp0L3h6VHN3?=
 =?utf-8?B?T29OSkNwcnA1ZlVtQ1NMWG8rRTRVa1JEWE5EbG1qYjBteXdKMlcrTmhiM2lD?=
 =?utf-8?B?aHhtakRBU2NMR3J0Z01GcTU0WlFwaG9Ta3psczFxVXdkb0lmV1ZZaVJwZlpL?=
 =?utf-8?B?REUrcHJsemJNcmxncmpUS2QxYWowbGRqaWVMYXlmTlNDSXEyTFlkVlFvblVT?=
 =?utf-8?B?dUJnbTNNUE5TWTdKQ01yYUt5MUN2TVR0ZWhReWxzYll0MEdRek0zWThNQ1Bp?=
 =?utf-8?B?NytXUFgyMDAvNVRmNkVGaStod0trenhLQVZrQWlvYXl5VlpZMDVvdGhhVml2?=
 =?utf-8?B?bFk5THZvRkdkY2h2SldyeVMvMkU0R2JIdWdDMG12b3NUZDJybktzQllXclZl?=
 =?utf-8?B?WmRXM2d2MmhKWHJ6SWU5Q3Q5Z2ROYTI2cWJ1Yk15c0liVjRPUGhRdHNQSm4r?=
 =?utf-8?B?SzFxN3Rhek04QVN6anh6Y05CeE0rYXZkWGVWeXZrRnorT0JsaWtaVktUSEFz?=
 =?utf-8?B?REJrRUhmL05ncVlBS0lHeGZaTkVNWXEraFNkQmRycHlVNXc5MVkzZFR6eUU4?=
 =?utf-8?B?MkFXUnNXRm1LQWNqcWQzWHJCZjYzWThZaW45c2hXZTRaaEtwNzE5QXhWNUtH?=
 =?utf-8?B?cHp5cnFSOWxrQlU0ai9hTkFXcmJXdEdYMDhrU2tCT0xKbERjOEQ0N0JMUzh3?=
 =?utf-8?B?THU4bk8xZWdCYWRpRnY4ZHpkUS9NdDlxMy90ZVpFOTE3T2pkZnZTSVlSSG1L?=
 =?utf-8?B?c25MMFlMT1pSckpyNXhTYVZkSFMybEM3R21mVkNhQ3dRcTNGUk0wTTZZRFNJ?=
 =?utf-8?B?QzNCdjlkb3FhWS85dGx5SVZUcjArU2QzZHFJYVFrWm5uMVd4OStEenJpNjRu?=
 =?utf-8?B?VDhLZGVOTVlOYzJ6U2NOdHE4M3JFUEorMWpZbUN3YUcvRkpZRXpnWjFmSXhR?=
 =?utf-8?B?QjNsLysvQkVqaldvdEU4anNjcWRzU0JiOUJtVUZJUWVLZk91c2I0bTdnOUUx?=
 =?utf-8?B?RFc0a2grUXpYY1BITGlxSWNkcVppRHYyN3BCMWU3WlU2eHAzUE1TYjBiWFJ4?=
 =?utf-8?B?Uk1aOTdFQzZtcndiOENZNzJ5YWFOVlpMZ1A4ZWw2ZC9yb3RMNmZQdVNvZTF5?=
 =?utf-8?B?bXBqLzgwQzUwMEFuZ2ozaHZNQ0dGNnIxK0xWamFId2hTQnpyREFOYlJoQk9i?=
 =?utf-8?B?cGNOdGFNcmlLcHFRZTZXWHJtKzQ2MTZoQXM0b2lWVlhjak02Um85dEZoQ1U5?=
 =?utf-8?B?a2F4UEdjNGxMam13V1NFOHFaVkZYQ3Vwckt6ZkVJdVpaMTk3WUxIeHVnd1ps?=
 =?utf-8?B?Q2p0ckRtM3pjN0ZuSWdrZ0NLNytobmZTZUdTQ1pEODJ3MHpKWkFGNWRUUGRV?=
 =?utf-8?B?MUphdVhYRmpWa3NsT2JPTEFaL1AvQVViaWY4UzhwNTFRM2YwZitDMllsQklB?=
 =?utf-8?B?cXZ2SEEwSFJPTkpDR0FhSytOeGtTYXRITGZCU0FCR3RTUjl2dURmRllRSHl6?=
 =?utf-8?Q?xOrmGVm2VSI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2hNQldZWUZVZHZ1SWM1dlhUeldsSW9aRlo2UjEvcDJJK1FsVnZsTmpneVZW?=
 =?utf-8?B?V2Y3dlBQWjJsVmEzOExrWFl1M3NkdUR2MnYyS1lwUkZYZmRDKy9RVDBTM05h?=
 =?utf-8?B?NGtGSXh3Z1Y0RDF5cWhUOW9mdWwvSng3aExybWtJcXJ2QitGNEM5K3RpSVpX?=
 =?utf-8?B?VmtleVEyS2p6ZjZVZTlxQ3RwOFpMR3BpZDFyMy95amVYQmxRemFzaStNWGRK?=
 =?utf-8?B?OFBEcGYvTHZ6YURRLzZodi9ocFJJYnhINExmY2R2SUFZWFFiczA2L21JU2V2?=
 =?utf-8?B?TjNrT3podzFTc3FzQzExSkp1SXBSMEh3QXhxWVgvOWZaeEhNOWV2MWJ5ZmxJ?=
 =?utf-8?B?Z2JEamRlOXl3QUsxMjJoRzBEaWw2WkhXZ253QjErV1h2bDFuRDdJWGplT2JH?=
 =?utf-8?B?SFZ1U1l1RTluRzVaOTA0S1JmS0JxVExVbVdDR3ZqNGc2dEtWOTNXemFnYzFD?=
 =?utf-8?B?QWpUSUdwWnpaVWpwYnc0L2kzZUloVEdjcVFnZld1emdoTmV2ekNabTNOS2tm?=
 =?utf-8?B?SGlMZmtxeTExd3hSb3JRSVYxK08xTkVweGdYR25DZXZ6cnFwa2gxRzJDNllK?=
 =?utf-8?B?Y1ZXMlA0d3dxQ3E2WUZvcXBWUGhWdkhDY0NaMmdRUUNXTHNSVUJoWWZNYTNn?=
 =?utf-8?B?VXplOUU4UCt0blgycjFyTS85bU1kZnVVNENQYWJ4TmVhcndIazhOWnVXd1hu?=
 =?utf-8?B?elJxYlZDM2U0eVhUd0tYdDB0WElEZXFLOThBZzdqN3RuUThMSFVmUU9LNmg4?=
 =?utf-8?B?dDltZEFoSW1jNVdUYkRKK2I5bnE3OElLeW9ldnJmTitYZ09oQWd0NG9PcHpO?=
 =?utf-8?B?b0FSbHRPYlZMRENpdFVyc0hJdXljdG85bHlqZGJHcTR2WUtCVy94Q0VhSzdS?=
 =?utf-8?B?ckljdUhncWMxL1BjOUw2ajY4QWMzLzc5N0pRNVFDb2lwWEI1U0tuRzNZQW1P?=
 =?utf-8?B?KzZwbWFBYkwraXNRdkV3YzhSU1l2V2ZWVlg5UFNHK3M4VG9FbnV1MDUrOG51?=
 =?utf-8?B?dUN2Q045UVdkY0hrNFhOTWFGd2UwZmkwTk9nQzZXNExPQnRXSUNvbEEwTVdE?=
 =?utf-8?B?NndPQTVadlAweU1vMG1CK2JlU3crR3gxUFI0bDNvTDVzY1pzczBrYzg5NmYz?=
 =?utf-8?B?L0lJamhKVnIrZFNIUDJwNnpRUFo3K3B0SFlibXN5VzlyWFdjTWplZlIxdGRx?=
 =?utf-8?B?eUF3YzRIYVVyWVFaVUU1ZjcycFVqeGkyN05QVWFrWnV2VUx6WEdPZXZuMGda?=
 =?utf-8?B?M0NrV1Z4SVFZWERKbE4vZmYzNmx0QmJqbVA4S3piNzNpM0hsV2MwQVV6MlRr?=
 =?utf-8?B?dGowajhCQWxsdU1sL2hsQUdpTXVGU0k5ZE01SldoVUJvUHJlbzUzbFRPOFB2?=
 =?utf-8?B?aXdnRmM5NHJESlVEdWFiRFhWVWVVbjVNK1NmZktGelpiNjZTOHdEQ2dmZlZk?=
 =?utf-8?B?NDhBRjdreHIxVXMwUXNHbjV0STMrN2dLMGtvSzlnanpmdnVhRkV4VzRPS2Qy?=
 =?utf-8?B?MkwrNVRpWjREVzZhdHdxNVJjdlZzQ1BjWDRSayt3WEQ0MDBoMDkxM2Fkc2Rm?=
 =?utf-8?B?elgwTnlJQ0lqNDh2UFF2UytGV2sxQmVMN0gvenRaSGVyVGpzWU1rUTlQeU1u?=
 =?utf-8?B?WHpKd0dvVjdqMnBxbG8zZjByR3NEUkE1eGpUOTExYmt0QXVsalpWc1RKaFhy?=
 =?utf-8?B?M0xoSTcwd0JpQ0h0Ulo1d052M2pjOU9EZFhvSjdaRnA2Wit5bEZGSjdILzBv?=
 =?utf-8?B?NkJFYll1SHJKVStFUVpPeVNZb0d3bXV3aXpjemdQRHhhUklhdGJJQUtKQWs2?=
 =?utf-8?B?L2t1ZkpyVnhvSnBBNExpV0hRSVZXMDFCdUVBTEdJSDk3UENaNFF2UzFXRldt?=
 =?utf-8?B?ZTZTYkNMejVob01KVTdzMy9FcEkyTEpoQmphT3JPVnczQXJybmlNQ3NYSWdm?=
 =?utf-8?B?M2lPRUt1QXNYWUJkZnpIWGxneGZzRlZuU3Y2aFhqZXVmQUt4THlxeHZUOFVl?=
 =?utf-8?B?alZYYVB6eGlkU3BRa3pXMHZCRUVFN0JNRXk2d0dqV2JPOGpleTRYT283a1Bi?=
 =?utf-8?B?dnJlWjA4Uk1SSkdUOHBtR0t5OVpxM1lVbkdoYisvOHk1TEtVRHZXZ0RsaktT?=
 =?utf-8?B?NnE5cGFGM0pEOXNxbTVIOVNReVV4a01NSEdGeGFWSHFvaVd2V2RMZlEvOVdK?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D708FEC6C5449E4FAFE72BD9CF068132@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4265069-e9bb-47cc-a8be-08ddd38d4571
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 19:29:46.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzPhc3RLW0pnOq6pcv5qcPnwrG0wesF58efRO46GLH65n6f5f/GWEtGHqBRBCLmpVuT7oSKfRr9avDNWmboUPxAdQdzdsdE8KtqvhoiZs3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA4LTA0IGF0IDEwOjEwICswMjAwLCBUaG9tYXMgSGVsbHN0csO2bSB3cm90
ZToKPiBXaGVuIHRoZSB4ZSBidWZmZXItb2JqZWN0IHNocmlua2VyIGFsbG93cyBHUFUgd2FpdHMg
YW5kIHdyaXRlLWJhY2ssCj4gKHR5cGljYWxseSBmcm9tIGtzd2FwZCksIHBlcmZvcm0gbXVsdGls
cGUgcGFzc2VzLCBza2lwcGluZwoKL3MvbXVsdGlscGUvbXVsdGlwbGUvCgo+IHN1YnNlcXVlbnQg
cGFzc2VzIGlmIHRoZSBzaHJpbmtlciBudW1iZXIgb2Ygc2Nhbm5lZCBvYmplY3RzIHRhcmdldAo+
IGlzIHJlYWNoZWQuCj4gCj4gMSkgV2l0aG91dCBHUFUgd2FpdHMgYW5kIHdyaXRlLWJhY2sKPiAy
KSBXaXRob3V0IHdyaXRlLWJhY2sKPiAzKSBXaXRoIGJvdGggR1BVLXdhaXRzIGFuZCB3cml0ZS1i
YWNrCj4gCj4gVGhpcyBpcyB0byBhdm9pZCBzdGFsbHMgYW5kIGNvc3RseSB3cml0ZS0gYW5kIHJl
YWRiYWNrcyB1bmxlc3MgdGhleQo+IGFyZSByZWFsbHkgbmVjZXNzYXJ5Lgo+IAo+IENsb3NlczoK
PiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hlL2tlcm5lbC8tL2lzc3Vlcy81
NTU3I25vdGVfMzAzNTEzNgo+IEZpeGVzOiAwMGM4ZWZjMzE4MGYgKCJkcm0veGU6IEFkZCBhIHNo
cmlua2VyIGZvciB4ZSBib3MiKQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni4x
NSsKPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBs
aW51eC5pbnRlbC5jb20+CgpJIHNlZSB0aGUgcmVwb3J0ZWQgcmVxdWVzdGVkOgpSZXBvcnRlZC1i
eTogbWVsdnluIDxtZWx2eW4yQGRuc2Vuc2UucHViPgoKPiAtLS0KPiDCoGRyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV9zaHJpbmtlci5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4g
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfc2hyaW5rZXIuYwo+IGIvZHJp
dmVycy9ncHUvZHJtL3hlL3hlX3Nocmlua2VyLmMKPiBpbmRleCAxYzNjMDRkNTJmNTUuLmJjMzQz
OWJkNDQ1MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfc2hyaW5rZXIuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9zaHJpbmtlci5jCj4gQEAgLTU0LDEwICs1NCwx
MCBAQCB4ZV9zaHJpbmtlcl9tb2RfcGFnZXMoc3RydWN0IHhlX3Nocmlua2VyCj4gKnNocmlua2Vy
LCBsb25nIHNocmlua2FibGUsIGxvbmcgcHVyZ2VhCj4gwqDCoMKgwqDCoMKgwqDCoHdyaXRlX3Vu
bG9jaygmc2hyaW5rZXItPmxvY2spOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyBzNjQgeGVfc2hyaW5r
ZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0
eCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb25zdCBzdHJ1Y3QgeGVfYm9fc2hyaW5rX2ZsYWdzIGZsYWdzLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9f
c2NhbiwgdW5zaWduZWQgbG9uZwo+ICpzY2FubmVkKQo+ICtzdGF0aWMgczY0IF9feGVfc2hyaW5r
ZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4
ICpjdHgsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB4ZV9ib19zaHJpbmtfZmxhZ3MgZmxhZ3MsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQgbG9uZwo+ICpzY2FubmVkKQo+IMKgewo+IMKgwqDC
oMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgbWVtX3R5cGU7Cj4gwqDCoMKgwqDCoMKgwqDCoHM2NCBm
cmVlZCA9IDAsIGxyZXQ7Cj4gQEAgLTkzLDYgKzkzLDQ4IEBAIHN0YXRpYyBzNjQgeGVfc2hyaW5r
ZXJfd2FsayhzdHJ1Y3QgeGVfZGV2aWNlICp4ZSwKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZy
ZWVkOwo+IMKgfQo+IMKgCj4gKy8qCj4gKyAqIFRyeSBzaHJpbmtpbmcgaWRsZSBvYmplY3RzIHdp
dGhvdXQgd3JpdGViYWNrIGZpcnN0LCB0aGVuIGlmIG5vdAo+IHN1ZmZpY2llbnQsCj4gKyAqIHRy
eSBhbHNvIG5vbi1pZGxlIG9iamVjdHMgYW5kIGZpbmFsbHkgaWYgdGhhdCdzIG5vdCBzdWZmaWNp
ZW50Cj4gZWl0aGVyLAo+ICsgKiBhZGQgd3JpdGViYWNrLiBUaGlzIGF2b2lkcyBzdGFsbHMgYW5k
IGV4cGxpY2l0IHdyaXRlYmFja3Mgd2l0aAo+IGxpZ2h0IG9yCj4gKyAqIG1vZGVyYXRlIG1lbW9y
eSBwcmVzc3VyZS4KPiArICovCj4gK3N0YXRpYyBzNjQgeGVfc2hyaW5rZXJfd2FsayhzdHJ1Y3Qg
eGVfZGV2aWNlICp4ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggKmN0eCwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3Qg
eGVfYm9fc2hyaW5rX2ZsYWdzIGZsYWdzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdG9fc2NhbiwgdW5zaWduZWQg
bG9uZwo+ICpzY2FubmVkKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBub193YWl0X2dwdSA9
IHRydWU7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHhlX2JvX3Nocmlua19mbGFncyBzYXZlX2Zs
YWdzID0gZmxhZ3M7Cj4gK8KgwqDCoMKgwqDCoMKgczY0IGxyZXQsIGZyZWVkOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqBzd2FwKG5vX3dhaXRfZ3B1LCBjdHgtPm5vX3dhaXRfZ3B1KTsKPiArwqDCoMKg
wqDCoMKgwqBzYXZlX2ZsYWdzLndyaXRlYmFjayA9IGZhbHNlOwo+ICvCoMKgwqDCoMKgwqDCoGxy
ZXQgPSBfX3hlX3Nocmlua2VyX3dhbGsoeGUsIGN0eCwgc2F2ZV9mbGFncywgdG9fc2NhbiwKPiBz
Y2FubmVkKTsKPiArwqDCoMKgwqDCoMKgwqBzd2FwKG5vX3dhaXRfZ3B1LCBjdHgtPm5vX3dhaXRf
Z3B1KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAobHJldCA8IDAgfHwgKnNjYW5uZWQgPj0gdG9fc2Nh
bikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGxyZXQ7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoGZyZWVkID0gbHJldDsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIWN0eC0+bm9f
d2FpdF9ncHUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbHJldCA9IF9feGVf
c2hyaW5rZXJfd2Fsayh4ZSwgY3R4LCBzYXZlX2ZsYWdzLAo+IHRvX3NjYW4sIHNjYW5uZWQpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobHJldCA8IDApCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbHJldDsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZWQgKz0gbHJldDsKPiArwqDCoMKgwqDCoMKg
wqB9Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKCpzY2FubmVkID49IHRvX3NjYW4pCgpXaHkgbm90IGlu
Y2x1ZGUgdGhpcyBpbiB0aGUgIWN0eC0+bm9fd2FpdF9ncHUgY29uZGl0aW9uIGFib3ZlPyBJZiBj
dHgtCj5ub193YWl0X2dwdSB3YXMgcGFzc2VkIGluIGFzIHRydWUgaGVyZSwgd2UncmUganVzdCBj
aGVja2luZyBzY2FubmVkID49CnRvX3NjYW4gdHdpY2UgaW4gYSByb3cgd2l0aCB0aGUgc2FtZSB2
YWx1ZXMuCgpPdGhlcndpc2UgdGhlIHBhdGNoIGxndG0uCgpUaGFua3MsClN0dWFydAoKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZyZWVkOwo+ICsKPiArwqDCoMKgwqDC
oMKgwqBpZiAoZmxhZ3Mud3JpdGViYWNrKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGxyZXQgPSBfX3hlX3Nocmlua2VyX3dhbGsoeGUsIGN0eCwgZmxhZ3MsIHRvX3NjYW4sCj4g
c2Nhbm5lZCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChscmV0IDwgMCkK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBs
cmV0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVlZCArPSBscmV0Owo+ICvC
oMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGZyZWVkOwo+ICt9Cj4g
Kwo+IMKgc3RhdGljIHVuc2lnbmVkIGxvbmcKPiDCoHhlX3Nocmlua2VyX2NvdW50KHN0cnVjdCBz
aHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hyaW5rX2NvbnRyb2wKPiAqc2MpCj4gwqB7Cj4gQEAg
LTE5OSw2ICsyNDEsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyB4ZV9zaHJpbmtlcl9zY2FuKHN0
cnVjdAo+IHNocmlua2VyICpzaHJpbmssIHN0cnVjdCBzaHJpbmtfY29uCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBydW50aW1lX3BtID0geGVfc2hyaW5rZXJfcnVudGltZV9wbV9n
ZXQoc2hyaW5rZXIsCj4gdHJ1ZSwgMCwgY2FuX2JhY2t1cCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgc2hyaW5rX2ZsYWdzLnB1cmdlID0gZmFsc2U7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBscmV0
ID0geGVfc2hyaW5rZXJfd2FsayhzaHJpbmtlci0+eGUsICZjdHgsIHNocmlua19mbGFncywKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbnJfdG9fc2NhbiwgJm5yX3NjYW5uZWQpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobHJl
dCA+PSAwKQoK

