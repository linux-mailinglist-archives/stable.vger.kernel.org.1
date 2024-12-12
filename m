Return-Path: <stable+bounces-100876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A249EE399
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F9164475
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727220E32D;
	Thu, 12 Dec 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/I300p0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30320E705;
	Thu, 12 Dec 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997710; cv=fail; b=VwSU8ZPS4F4oiybQ49DLp7GcwlKe5n97771DikGLOiwBF+p3r2LJcIWf2tIjx5fyrX2LuZP1cQwa7oeumdKJUYYvR4MIsPHw8UySSbIss2YMhIg2cOuJKinxHtF0XaGtt4mAoJrz/58fx0Oo6rpgdEInliJkUUlWQikO1cmtXrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997710; c=relaxed/simple;
	bh=Wl/NaJQO3tZc8fbipZtP0nzLMZ996M0tmy4b9z8+zJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdiyh7GsJdQtMG8h5inDh5I0FA3xGi9Rk92LqSa8tQLHBdodz/G2TLu5bfJ7abGXYN7qNatC9K/bZF/EIyii8paRqcagOUV84z6g0IVE1A8Nlq0sALLIg3ew5dERN21VO1VjH9yxtl0UUj8dvyzVveME471XZn/MQvwZev7xK0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/I300p0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733997709; x=1765533709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wl/NaJQO3tZc8fbipZtP0nzLMZ996M0tmy4b9z8+zJg=;
  b=S/I300p0ywxpNOHXUMSGqtuYBmGn020W2ETboeTq8e8nVfbNS3BOK6vX
   sNMApmX2chjuTIx/zdnTBaitn8KKAQDXlAA3E/xzG5yhp1P8SovPIQkre
   xUMRQMvbdCuDzxqAN/BziMSOoZN0VJIzW+VALeDsFRto3LZZr6Ej4FGA4
   xEG4dt755uO/CthZ+9U7OESi8/rEYjyOkC4hm02vsUp8FnQdxLh3QqtYL
   kaQzYS2OHT19WpiY2CSlNEcVO7LYxm4wPzyOqwgjLTt2Jd6u39nrrsfqW
   gbRdoYeu/Ue6ijFhPBArIqdc3QUefpHvBHLr1gmExNBn5W6dH+V0cIiV7
   Q==;
X-CSE-ConnectionGUID: YrioZCqpRn2+c2yAo2STFw==
X-CSE-MsgGUID: aI47Zs0QQ2eRl+AYI7kbVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="59806705"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="59806705"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 02:01:48 -0800
X-CSE-ConnectionGUID: lZwgr4qhTeme29Pd/NmYUg==
X-CSE-MsgGUID: TScvKFAXTUGABMGNXsaZUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96057693"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 02:01:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 02:01:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 02:01:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 02:01:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDmigbd0lXoX7PFvTW6caveGQjEJZDAQ6yu7TsjH+ql0GX4roWqVoASiajvK/w9aK7/2tdysyqb40UjsJECoiXXn55y0KheibwR5e1WxAWkXRma3vt73aMPcI0HazJu8jOjBESVep/qLwYU+ZHlqIIAwdj0w695HolaVTB0spDdJiYMQU1UXi/8vkeNeA+oxvyBNoLL3WRpx0+e1LJO8Uf9DKfksLNoiyGZk/pOEv6aerwBJmLxsl+bf1BKMSVm0k5I5/QMkJfgCGEgf7oujbZJKdmAcXpsQKjUSB7Cvw2J3S+WpCX1oqlsBuhx2xcIlxmlBGyjHNnd1A7VAk/JQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl/NaJQO3tZc8fbipZtP0nzLMZ996M0tmy4b9z8+zJg=;
 b=MqE3JcJcBvuOhSyv0X5tMqJRJu98r1sdzxuEz17GS8k/Pm0K9fg5gl1pRX4Aod7kHZHhZmw37VYHpmA9ubjfzHU/poQPAmUe3q+d7TpY8cpyW3u+PqYKyM00DS2Ss6nDHDG3hXgQUEf0BK5J28uKzSeyp80sbsCX6Kt5lTUmzPS/8tLOPudPm0F94C0JlsT8rLAVYNTWluPYAaHnsdKQ78Xq7p1cW0w0fUx/lndqjMjoB2DDbQB98SLT/xcmp9xRhDBRZD6YpcVhSxzJwg6kaYOlfx4zPRXubvUVFFVIVib1ucg7vBHap45zO8BRqILdtWhxPZSDml7D2CdBF/DprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 12 Dec
 2024 10:01:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 10:01:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
Thread-Topic: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
Thread-Index: AQHbTGdWH2+KP9v0M0K5lC4EFs8zwrLiOrCAgAAF3dCAABclAIAABd2A
Date: Thu, 12 Dec 2024 10:01:41 +0000
Message-ID: <SJ0PR11MB6744EF3EB81780C1EA07FB1F923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241212072419.480967-1-zhenzhong.duan@intel.com>
 <760e2a44-299a-4369-a416-ead01d109514@intel.com>
 <SJ0PR11MB6744E3960431FEB30C36DE7A923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c97bdf1b-2f18-4168-8d75-052f6bff4c53@intel.com>
In-Reply-To: <c97bdf1b-2f18-4168-8d75-052f6bff4c53@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7298:EE_
x-ms-office365-filtering-correlation-id: 85968c39-060b-4643-0aeb-08dd1a93fa2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qks0V3U0dVJ1a2t2YUwrNDNmTXR3MHBndEtFUVYvRVRMWUpRU2hHZjFjR1Ey?=
 =?utf-8?B?VG9xZE82ek1lN2hpdjVMeVRWV0JmMld4bVJGMjgyeUZpSVhkYmFHdHU4Wmdl?=
 =?utf-8?B?Szg0cEptVm5RaVJxUTFTaEM1a1Z1blcrQy9oUmYyckUwelQrYkJtcUVvT1VN?=
 =?utf-8?B?QS9lVWMrVEtiYlJ4SHR0eVFCVm5VeFRXRW04S0txdE56QnlIdjVxNEJpVC9K?=
 =?utf-8?B?Tk5rNUVyZ054MURqM0pGUVZsRTRYVlB3U3pxMWZSWUZlellTK1pyWEU3VDRS?=
 =?utf-8?B?MGpPNHRPaHlrOEZqMjBxUE1GMm9QZlNGK2R6R1NWSG5HRU5ISlByTFJLMVRP?=
 =?utf-8?B?VzNrVVplZzBsUG5OL2hJNnFhNzB1bXk1YUhDcmFYWmt5MmpFTjE0WHhKV1I5?=
 =?utf-8?B?ZFNlK3hBelN4V2V4bkNLZ0VVVDlsN01pVEUrUy9VVTdabVhMVGVwcUkxSGN1?=
 =?utf-8?B?WW1PL1gyOHlGUG5jTFVtYlE5MFhBWnFpOG1tMXo0WGQ0SmpJYmhsYzhiQk5r?=
 =?utf-8?B?YVZlTjByNndLcTZXeWk4VU5OekQ2cmtGaHJmaUQ5aWJYUXplQVBUMGwxak1a?=
 =?utf-8?B?d21CdlR2TDFJUVlKYjB3cVdhVXVaNUZ5dC8wTGZoUzVLUEJST3kyL0ZmNy9o?=
 =?utf-8?B?TnpvL2tKNng5bUlBc042aGE5UHNtTW9aR3RrNGJSRWExOUhuSDhkdzBvRmVM?=
 =?utf-8?B?MmdKNnhTYVQybWg2MkNOM1hyci9sZ3RHSWtHa0piazRXTXlZSUZDWkJsa3lB?=
 =?utf-8?B?TmZLaWR3UUpVNlEveWRvZWl6ZXNPbWxQencyZVVVOEtudTRsR2M0a3pybTBE?=
 =?utf-8?B?Q2g4MlloNk5jVFVvR0UxZE1hVTRQb0dWSS95RW1TMkk0OVNtSzl1Um44NVhH?=
 =?utf-8?B?TGlpSS84Y0lPLzJGYTlibDRMbzBDNVBka1pHTEErc0ZaOXpiR2FSZE1ML1hG?=
 =?utf-8?B?NkR0cFdIczJxcXdJeUtvNW1xTzk1aCs1ay82SUlYYTFHcFN4bStuTEFjUG9C?=
 =?utf-8?B?SitNbWkvcy9qMHJRMVN3eENDblVUV0RleHpjMnJkRnk5Z0RuYVhKVWhhZFJt?=
 =?utf-8?B?ZFkwV1BZTldvRFU4ZjhpTTFtQUNKc2hSb2FpQkhVUFM4SnRpYk9XSS9DOTNC?=
 =?utf-8?B?d2ZJTWpHZkpIbG1pWUN5bTI2alkyNGR2ZXhCbVp4cHVNZS9OOVYrQVZmbkZq?=
 =?utf-8?B?ZngxaHZMeVRGSklabmY0V0FhRklJc2EzR0FwNGlhTDRZWHJJS0xnQy9YM1FV?=
 =?utf-8?B?aVdzbnNZazBOR3VrcEhIbFhGaDhrSXdYWE83anZxTkdIYU5iUDJmbUwySk5t?=
 =?utf-8?B?M2NJTEhSaElXS3AxOFRVOVdlSGEyUTcrT3Y2VUorRnF4WU04TWRDdWRPZFVt?=
 =?utf-8?B?aWxnVTB1TXJXbUMwOC90S2Rhd3ErVnR2bEs2Tk5VREdYQU1yQXRZTkNQRUxi?=
 =?utf-8?B?OHJheU5aMEZGeFkwQnVBdThpSFRIa2VCQUhqR1JvRGR2a1g3eG96Mi9IS3N3?=
 =?utf-8?B?dWI3bDRVRWt2K0cyVGNLMU03SFhsSTdGT0M3NndNMG9jMWdxSmNTelJSbnl4?=
 =?utf-8?B?RmprQnhObFNucCtoQW1nRnZmTGNOV3V5aURLbHJnK3FqcmNSa016c3BzbFNL?=
 =?utf-8?B?clpIYSt6VVp1ZDEwSHNuTTRxWWVnd2Jwem54UXpwSXFYMWZxQmdUeGc3Unhn?=
 =?utf-8?B?UXovV0JaZXprK3NIbTJPNVdIRnNlNGh0UEJVdmh6SlVQbmRpdnFHZ295dUhP?=
 =?utf-8?B?N2xMazlkQjRmSHBzUkp3SEMvdWJFOFY1R1dja0FQd1FRK25NbHJZdi9xL0dX?=
 =?utf-8?B?eU1SZEx3WUF4N1lwbUxYaXlhS2l5V08xOFpzYWVmcDJFbVMxdWk5RmtrOEZJ?=
 =?utf-8?B?KzM3YzlaajRDVlE3amNLUXR0Vkp0L00wWWVla3h6OGdpRGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWQybDlaaFh3RHUxU3FRZGtGUHRKcGtyR21ycVk5NmtIbzhvNXV3cVg4NzNl?=
 =?utf-8?B?V1RFMVZjZjYvM05CK3lleDdDaVFmbStBZ0haSmp2akU3Y3BvSXBXTHV4YTd0?=
 =?utf-8?B?WmlZY0dkWmFOVUNWbzcrMXhiT05ueXBDYU8zdTQrSnFORVJvY0VsbDRJVG5C?=
 =?utf-8?B?b2o2dFZBTTI3T0VpalJqVDR0TEtROXRGeFoxQXZuQ0tqcW81TktFRXg2bGJ0?=
 =?utf-8?B?dnAwNEVScTlNWXRiQ1F2Y2lUMlZKNnc5UFJBa0ZkSGg2WHdycisvUGkvOTAv?=
 =?utf-8?B?SVBNMUJnRlFDREVSalhEb2h1YmVScW9Fd2JLeUljdkM3OFVlMGtyQjA4TXpT?=
 =?utf-8?B?RFI0dVJyK2xXcFZDTW1oNmFIQTZIRjl4eDk1T3BTMUJqR1BEUXpQSVIrYnAw?=
 =?utf-8?B?MW1HWCtZSTJueGlEZ2tFajRtaHJPelAxTEVHOHVqbUdoUmltYUJzZVYzQWhl?=
 =?utf-8?B?NUQ1Y1ZJOWR1MklYbTNNY2c0cjhLTU9jdEtWTnRUQlhldmZKRzFac3ZVR25Q?=
 =?utf-8?B?RklESEVDWENUaGlvVkpZczZtcUlJMFdERkUvTlVSeEpNQmVma25qQjFDVy9J?=
 =?utf-8?B?b1BSZGF4bmNRT3FCa2ZVNlA3VXIxTVVMNGQ2VHBZbUw5ZlhMWlhLNkQwWG9t?=
 =?utf-8?B?YzI2bjRsTDV2OGtHU0cwNFd1ZGpRQTlsQjZObEZBSUUreVRQb09WczhUSlZ0?=
 =?utf-8?B?RU1IUW5NeUJBaGJwZmZIaTFYbnVmK0JmWWZldDN5Mk5tZERoalFESGVDcTBW?=
 =?utf-8?B?QVJFMkJNaSt2U1FMTjFhVDJoUDFLRWNXUVRpUXZVY1NXb253NU5CS2Ntd1dH?=
 =?utf-8?B?Q0FxeUxFcVVzTnQ4TFdNa1lYSXNOWWExbzF0L1NpY0EwME9XZXhROUhJZmQ3?=
 =?utf-8?B?QmVWZ1FOWnpZeEJqWUNyaElLTlFtSW1HWVVIdngyT0crSDFHeDZzUGMrL2dP?=
 =?utf-8?B?dHlvMTh0amRWSWFBdVhzRU1kTzFWZEdveWxmZlhLbHpTOGNaZkdMczljWWJI?=
 =?utf-8?B?bEVreDVYMmpDWnE0VEhmVzBEczZWYzJxT0R0WjZVYVJYeDJ5Q2w2S3JYUUxh?=
 =?utf-8?B?azFzRWxJNWZrMnpPaS9SOW5Sc0pGV09mTUNOVklQbEZROVFIQU4rSlBXcnNP?=
 =?utf-8?B?WHN0Qmx4Qm8wK2lvOWg5NVFvcVloV2RJTVArMFVScUtxdlhMb1k0cHlYT0o2?=
 =?utf-8?B?aER1V1ZVd242NmFOUm9OUFUyaE5ENXdlS2tpOFNOOTZDM0JwOFg5aFJ2YVV2?=
 =?utf-8?B?cVB6NWVWbG1vRkwwYkR1cTlWRWZ1ZnRZU1h0VjB5NkxsRzJpRmVSZU9QL2w5?=
 =?utf-8?B?UWljd21yUjFvUThqbVJKMi84aHlFSnMvK1J2L0JUaWcwem5kVWhXRkJvdTZr?=
 =?utf-8?B?LzBuUnZ1cEZoZnROLzE3NEM0WDlkRTBndXhxZ3VLdG8zL28rbU0yUjhRb1A2?=
 =?utf-8?B?TStDZFViTFVwSTBua09tLzdIYXNsWlZKK2pkS1FYVzRTZUZzaXBxR2hFdVN6?=
 =?utf-8?B?b0JaVFFVVisvRWRKWWFBREJyYjAzd003M09YMzRSSFFHbXBYYU16MGFHNHFW?=
 =?utf-8?B?VThvbUpYeWFVWTljUUpSV3ZHdHE1cVRhSmRxMFNwaTBpcHIxRmM4SlJobmQ4?=
 =?utf-8?B?ZFZXUGVyUGJhemhsU0dWMWNuN0cvTmNHbXJtcDBsQU40UUtlQXlLR2s5aU5W?=
 =?utf-8?B?RkFTUFk1OGFxM21uSjl4dkFFSkNMWi9hMy9TcGE4K2wrWnpoR3locGdVb2xE?=
 =?utf-8?B?S3JVbXAzeFpsODVlOHhEQUlieUR0ZXpZTTF3eWtMR0o3ZlIwSlBNV3h2MFhN?=
 =?utf-8?B?ZDNNNk5ZSzFTN21TU053S3RxT21uT3Y1bGhuVGNXdGNqeEdBVVI3VGVxQkxv?=
 =?utf-8?B?czBlSUVRSGtTUGlZSG5OUnFxSjdqcXJaUDdCNlBaMkNLT2xXUjVjcGNIajlY?=
 =?utf-8?B?QkR3alZMOHdSNjJqeWNuRjBPcExFcDZLbVJDdHJ4OGVBMEdZdSs3MWRNNzRC?=
 =?utf-8?B?djE0ZnNWbHZWdzFXcXFST2d6RDBERmtkS3hKZEFYUEY3WXpZZkNQRjV3TkVL?=
 =?utf-8?B?UVA3WlJRYUJaTzZlZGdaQzJZaW11d2RFUXp2SHF6bWJjeUN5NWxmS292L1Rl?=
 =?utf-8?Q?Hvoogs5e79YFlTRBMhK33U9l8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85968c39-060b-4643-0aeb-08dd1a93fa2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 10:01:41.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8GDJgUsH9iKXQSs+JZh9KzzdXKY97VXZrZffe5nDQQegcIiQ0IYiqO8PYLsJcE64hl5QydxgIML+h3PD99obgdrNY8lt/euhU9nnEWDqHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com

SGkgWWksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMiwgMjAyNCA1
OjI5IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvdnQtZDogRml4IGtlcm5lbCBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4NCj5jYWNoZV90YWdfZmx1c2hfcmFuZ2VfbnAoKQ0KPg0K
Pk9uIDIwMjQvMTIvMTIgMTY6MTksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+Pj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDEyLCAyMDI0IDM6NDUg
UE0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpb21tdS92dC1kOiBGaXgga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBpbg0KPj4+IGNhY2hlX3RhZ19mbHVzaF9yYW5nZV9ucCgpDQo+
Pj4NCj4+PiBPbiAyMDI0LzEyLzEyIDE1OjI0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4g
V2hlbiBzZXR1cCBtYXBwaW5nIG9uIGFuIHBhZ2luZyBkb21haW4gYmVmb3JlIHRoZSBkb21haW4g
aXMgYXR0YWNoZWQgdG8NCj4+PiBhbnkNCj4+Pj4gZGV2aWNlLCBhIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSB0cmlnZ2VycyBhcyBiZWxvdzoNCj4+Pj4NCj4+Pj4gICAgQlVHOiBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMjAwDQo+Pj4+ICAg
ICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPj4+PiAgICAjUEY6
IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4+Pj4gICAgUklQOiAwMDEw
OmNhY2hlX3RhZ19mbHVzaF9yYW5nZV9ucCsweDExNC8weDFmMA0KPj4+PiAgICAuLi4NCj4+Pj4g
ICAgQ2FsbCBUcmFjZToNCj4+Pj4gICAgIDxUQVNLPg0KPj4+PiAgICAgPyBfX2RpZSsweDIwLzB4
NzANCj4+Pj4gICAgID8gcGFnZV9mYXVsdF9vb3BzKzB4ODAvMHgxNTANCj4+Pj4gICAgID8gZG9f
dXNlcl9hZGRyX2ZhdWx0KzB4NWYvMHg2NzANCj4+Pj4gICAgID8gcGZuX3RvX2RtYV9wdGUrMHhj
YS8weDI4MA0KPj4+PiAgICAgPyBleGNfcGFnZV9mYXVsdCsweDc4LzB4MTcwDQo+Pj4+ICAgICA/
IGFzbV9leGNfcGFnZV9mYXVsdCsweDIyLzB4MzANCj4+Pj4gICAgID8gY2FjaGVfdGFnX2ZsdXNo
X3JhbmdlX25wKzB4MTE0LzB4MWYwDQo+Pj4+ICAgICBpbnRlbF9pb21tdV9pb3RsYl9zeW5jX21h
cCsweDE2LzB4MjANCj4+Pj4gICAgIGlvbW11X21hcCsweDU5LzB4ZDANCj4+Pj4gICAgIGJhdGNo
X3RvX2RvbWFpbisweDE1NC8weDFlMA0KPj4+PiAgICAgaW9wdF9hcmVhX2ZpbGxfZG9tYWlucysw
eDEwNi8weDMwMA0KPj4+PiAgICAgaW9wdF9tYXBfcGFnZXMrMHgxYmMvMHgyOTANCj4+Pj4gICAg
IGlvcHRfbWFwX3VzZXJfcGFnZXMrMHhlOC8weDFlMA0KPj4+PiAgICAgPyB4YXNfbG9hZCsweDkv
MHhiMA0KPj4+PiAgICAgaW9tbXVmZF9pb2FzX21hcCsweGM5LzB4MWMwDQo+Pj4+ICAgICBpb21t
dWZkX2ZvcHNfaW9jdGwrMHhmZi8weDFiMA0KPj4+PiAgICAgX194NjRfc3lzX2lvY3RsKzB4ODcv
MHhjMA0KPj4+PiAgICAgZG9fc3lzY2FsbF82NCsweDUwLzB4MTEwDQo+Pj4+ICAgICBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+Pj4+DQo+Pj4+IHFpX2JhdGNoIHN0
cnVjdHVyZSBpcyBhbGxvY2F0ZWQgd2hlbiBkb21haW4gaXMgYXR0YWNoZWQgdG8gYSBkZXZpY2Ug
Zm9yIHRoZQ0KPj4+PiBmaXJzdCB0aW1lLCB3aGVuIGEgbWFwcGluZyBpcyBzZXR1cCBiZWZvcmUg
dGhhdCwgcWlfYmF0Y2ggaXMgcmVmZXJlbmNlZCB0bw0KPj4+PiBkbyBiYXRjaGVkIGZsdXNoIGFu
ZCB0cmlnZ2VyIGFib3ZlIGlzc3VlLg0KPj4+Pg0KPj4+PiBGaXggaXQgYnkgY2hlY2tpbmcgcWlf
YmF0Y2ggcG9pbnRlciBhbmQgYnlwYXNzIGJhdGNoZWQgZmx1c2hpbmcgaWYgbm8NCj4+Pj4gZGV2
aWNlIGlzIGF0dGFjaGVkLg0KPj4+Pg0KPj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
Pj4+PiBGaXhlczogNzA1YzFjZGYxZTczICgiaW9tbXUvdnQtZDogSW50cm9kdWNlIGJhdGNoZWQg
Y2FjaGUgaW52YWxpZGF0aW9uIikNCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvaW9t
bXUvaW50ZWwvY2FjaGUuYyB8IDIgKy0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsL2NhY2hlLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4+Pj4gaW5k
ZXggZTViODlmNzI4YWQzLi5iYjlkYWU5YTdmYmEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwvY2FjaGUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hl
LmMNCj4+Pj4gQEAgLTI2NCw3ICsyNjQsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZw0KPj4+IGNh
bGN1bGF0ZV9wc2lfYWxpZ25lZF9hZGRyZXNzKHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+Pj4+DQo+
Pj4+ICAgIHN0YXRpYyB2b2lkIHFpX2JhdGNoX2ZsdXNoX2Rlc2NzKHN0cnVjdCBpbnRlbF9pb21t
dSAqaW9tbXUsIHN0cnVjdA0KPnFpX2JhdGNoDQo+Pj4gKmJhdGNoKQ0KPj4+PiAgICB7DQo+Pj4+
IC0JaWYgKCFpb21tdSB8fCAhYmF0Y2gtPmluZGV4KQ0KPj4+PiArCWlmICghaW9tbXUgfHwgIWJh
dGNoIHx8ICFiYXRjaC0+aW5kZXgpDQo+Pj4NCj4+PiB0aGlzIGlzIHRoZSBzYW1lIGlzc3VlIGlu
IHRoZSBiZWxvdyBsaW5rLiA6KSBBbmQgd2Ugc2hvdWxkIGZpeCBpdCBieQ0KPj4+IGFsbG9jYXRp
bmcgdGhlIHFpX2JhdGNoIGZvciBwYXJlbnQgZG9tYWlucy4gVGhlIG5lc3RlZCBwYXJlbnQgZG9t
YWlucyBpcw0KPj4+IG5vdCBnb2luZyB0byBiZSBhdHRhY2hlZCB0byBkZXZpY2UgYXQgYWxsLiBJ
dCBhY3RzIG1vcmUgYXMgYSBiYWNrZ3JvdW5kDQo+Pj4gZG9tYWluLCBzbyB0aGlzIGZpeCB3aWxs
IG1pc3MgdGhlIGZ1dHVyZSBjYWNoZSBmbHVzaGVzLiBJdCB3b3VsZCBoYXZlDQo+Pj4gYmlnZ2Vy
IHByb2JsZW1zLiA6KQ0KPj4+DQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9t
bXUvMjAyNDEyMTAxMzAzMjIuMTcxNzUtMS0NCj4+PiB5aS5sLmxpdUBpbnRlbC5jb20vDQo+Pg0K
Pj4gQWgsIGp1c3Qgc2VlIHRoaXPwn5iKDQo+PiBUaGlzIHBhdGNoIHRyaWVzIHRvIGZpeCBhbiBp
c3N1ZSB0aGF0IG1hcHBpbmcgc2V0dXAgb24gYSBwYWdpbmcgZG9tYWluIGJlZm9yZQ0KPj4gaXQn
cyBhdHRhY2hlZCB0byBhIGRldmljZSwgeW91ciBwYXRjaCBmaXhlZCBhbiBpc3N1ZSB0aGF0IG5l
c3RlZCBwYXJlbnQNCj4+IGRvbWFpbidzIHFpX2JhdGNoIGlzIG5vdCBhbGxvY2F0ZWQgZXZlbiBp
ZiBuZXN0ZWQgZG9tYWluIGlzIGF0dGFjaGVkIHRvDQo+PiBhIGRldmljZS4gSSB0aGluayB0aGV5
IGFyZSBkaWZmZXJlbnQgaXNzdWVzPw0KPg0KPk9vcHMuIEkgc2VlLiBJIHRoaW5rIHlvdXIgY2Fz
ZSBpcyBhbGxvY2F0aW5nIGEgaHdwdCBiYXNlZCBvbiBhbiBJT0FTIHRoYXQNCj5hbHJlYWR5IGhh
cyBtYXBwaW5ncy4gV2hlbiB0aGUgaHdwdCBpcyBhZGRlZCB0byBpdCwgYWxsIHRoZSBtYXBwaW5n
cyBvZg0KPnRoaXMgSU9BUyB3b3VsZCBiZSBwdXNoaW5nIHRvIHRoZSBod3B0LiBCdXQgdGhlIGh3
cHQgaGFzIG5vdCBiZWVuIGF0dGFjaGVkDQo+eWV0LCBzbyBoaXQgdGhpcyBpc3N1ZS4gSSByZW1l
bWJlciB0aGVyZSBpcyBhIGltbWVkaWF0ZV9hdHRhY2ggYm9vbCB0byBsZXQNCj5pb21tdWZkX2h3
cHRfcGFnaW5nX2FsbG9jKCkgZG8gYW4gYXR0YWNoIGJlZm9yZSBjYWxsaW5nDQo+aW9wdF90YWJs
ZV9hZGRfZG9tYWluKCkgd2hpY2ggcHVzaGVzIHRoZSBJT0FTIG1hcHBpbmdzIHRvIGRvbWFpbi4N
Cj4NCj5PbmUgcG9zc2libGUgZml4IGlzIHRvIHNldCB0aGUgaW1tZWRpYXRlX2F0dGFjaCB0byBi
ZSB0cnVlLiBCdXQgSSBkb3VidCBpZg0KPml0IHdpbGwgYmUgYWdyZWVkIHNpbmNlIGl0IHdhcyBp
bnRyb2R1Y2VkIGR1ZSB0byBzb21lIGdhcCBvbiBBUk0gc2lkZS4gSWYNCj50aGF0IGdhcCBoYXMg
YmVlbiByZXNvbHZlZCwgdGhpcyBiZWhhdmlvciB3b3VsZCBnbyBhd2F5IGFzIHdlbGwuDQo+DQo+
U28gYmFjayB0byB0aGlzIGlzc3VlLCB3aXRoIHRoaXMgY2hhbmdlLCB0aGUgZmx1c2ggd291bGQg
YmUgc2tpcHBlZC4gSXQNCj5sb29rcyBvayB0byBtZSB0byBza2lwIGNhY2hlIGZsdXNoIGZvciBt
YXAgcGF0aC4gQW5kIHdlIHNob3VsZCBub3QgZXhwZWN0DQo+YW55IHVubWFwIG9uIHRoaXMgZG9t
YWluIHNpbmNlIHRoZXJlIGlzIG5vIGRldmljZSBhdHRhY2hlZCAocGFyZW50IGRvbWFpbg0KPmlz
IGFuIGV4Y2VwdGlvbiksIGhlbmNlIG5vdGhpbmcgdG8gYmUgZmx1c2hlZCBldmVuIHRoZXJlIGlz
IHVubWFwIGluIHRoZQ0KPmRvbWFpbidzIElPQVMuIFNvIGl0IGFwcGVhcnMgdG8gYmUgYSBhY2Nl
cHRhYmxlIGZpeC4gQEJhb2x1LCB5b3VyIG9waW5pb24/DQoNCkhvbGQgb24sIGl0IGxvb2tzIEkn
bSB3cm9uZyBvbiBhbmFseXppbmcgcmVsYXRlZCBjb2RlIHFpX2JhdGNoX2ZsdXNoX2Rlc2NzKCku
DQpUaGUgaW9tbXUgc2hvdWxkIGFsd2F5cyBiZSBOVUxMIGluIG15IHN1c3BlY3RlZCBjYXNlLCBz
byANCnFpX2JhdGNoX2ZsdXNoX2Rlc2NzKCkgd2lsbCByZXR1cm4gZWFybHkgd2l0aG91dCBpc3N1
ZS4NCg0KSSByZXByb2R1Y2VkIHRoZSBiYWNrdHJhY2Ugd2hlbiBwbGF5aW5nIHdpdGggaW9tbXVm
ZCBxZW11IG5lc3RpbmcsIEkgdGhpbmsgeW91cg0KcHJldmlvdXMgY29tbWVudCBpcyBjb3JyZWN0
LCBJIG1pc3VuZGVyc3Rvb2QgdGhlIHJvb3QgY2F1c2Ugb2YgaXQsIGl0J3MgaW5kZWVkDQpkdWUg
dG8gbmVzdGluZyBwYXJlbnQgZG9tYWluIG5vdCBwYWdpbmcgZG9tYWluLiBQbGVhc2UgaWdub3Jl
IHRoaXMgcGF0Y2guDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

