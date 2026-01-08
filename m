Return-Path: <stable+bounces-206341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCDD03D06
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EC42307F216
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83C4F6C26;
	Thu,  8 Jan 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM5l9PLq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17E4F6C2A;
	Thu,  8 Jan 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875756; cv=fail; b=cXWLfhcCkjJaJ85ogMUau0nCY5NgP7S3GJsSpVDTO/2yuhw3cKoprygvJEFivnRGmXg5mwCYXK/5Zw/BDV6ZYrL+r2ldZ5N+0c04dLIuW78u4p4L+uTOQ0IBLEOUGBIzva0Zesu5mDjSx2GmYSRTl50jyYAxw5hZPUQZAtesWWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875756; c=relaxed/simple;
	bh=wktj75g/o+wSw9PLlBMMKoylQA89APBGpvZM1okWKCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1IicJLXFd7bNmbVJxqlQ3pR/Mn+dbivpmbMXA6sII0XModbM+Vts97HUueJVk3v2xJBdWlowgjpAR5v03xj8wF4Oy5bFzCOdsPtBhyMz0ML2HlIR0Y33t9IoVAelexpvW4QrCD6aWVnJ/gDdHDoq3FVp9ymLy4KLW1oIXXm1WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM5l9PLq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767875755; x=1799411755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wktj75g/o+wSw9PLlBMMKoylQA89APBGpvZM1okWKCY=;
  b=hM5l9PLqN3QnqVuB65wT/IonOnnZZUqyeT5Xqb6tI1YkygQ+y13BLz2d
   zmMUVg1nmd9O9G5Ma6X5qbEaw/0mRuPkh4zwSCTDgxA0UR7+XB4CB9K/N
   1ltgYRFUCmhVdaKhhPAZwg2YbVTWJJe8zQ+1lVrDXCpRO/l7QFSyzYuDK
   GPVKAKWSsN340dIjeMMgNRKO/s7/ngotGK2dtf2eEa3HRfYnBTJBYEiwg
   7BYJXCE1PrifEuOKGWnUB1Cs3pYsaz74Q8D0xU3rXtBFALPclb+FFGejo
   xJrjYtcBY6F08pwv0EEiWLTrjR8hUl6liPuH6UuUhiTkr3exg+fBUOS1j
   A==;
X-CSE-ConnectionGUID: qSvvubVIRWqY70lKsLoWig==
X-CSE-MsgGUID: RxJmP+qCT6eUalVVaoKunw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="68985394"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="68985394"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 04:35:54 -0800
X-CSE-ConnectionGUID: JI+0oD/6QSKnJLqoNj+NBA==
X-CSE-MsgGUID: 25w0wZDUQfCfK6z2XJq9Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="208260001"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 04:35:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 04:35:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 04:35:53 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 04:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2glkuEon8H6OwNlHHR0RGAQDU3XV/ZKUVtHTlZr2afutEcIf+g5jItyYpsQyx0hlwc6WYQF1W+70GZ/Sgv3skrtbvtgW/ycHVRcj2seDKmDfJI/MDSjTE1vOJm27URDToAeXhJRNeC9VXYey7j0UkkJ3c9/qIQcpxO1jAvZM5FwvTSDUDJ+yVpo8pKtSKKYqTCSB2ALumtOvhmMjBFwVxBQj9m0tVU//ePktY9ZYXmATnz4ArBfE/JTd0FCp7LKxF41jTOwwo9EzKxDQwyiG8nzpVBH6zgvxhUv9eubRPqaVzpjwrC/0pEnk1P6JdFmPr2bb+xGXYt7R1Xka4PnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wktj75g/o+wSw9PLlBMMKoylQA89APBGpvZM1okWKCY=;
 b=DRDwhZezVvS4U1+dgm7mbx/RfJKd7vYC+22+Ll3vfsd2pQIja/WGhAQ5sN/h1s9S+D3Pv/0XZYeNVOW2VYhi/lU8yE10Ocl3SgXQ9QhnEV/UE3RfIYyxqEMiYWW8ri0FNgSQi9Ml+V7CJl8XUJlBL+mP2kMrDfbF/+ViMugi9i3HqcUawU/8nUMhtTL9VawT0SDrSObORv6R8BgXnNJQTBDfAqMNijsC2HgnVYyz5BP6P6iQmncNG5ojM1Q06QipDM//5/JkfZ/P3Odpdv8G0fw+pdYfDcsautk7AwDZs+t/k9IZPWKzpEOR+ma0TQow76+BjyRWEz8pAsMOefNyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 12:35:51 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 12:35:51 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Topic: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Index: AQHcgG56oF4dZ48YGkGw3t9tMdQ0EbVH4y0AgAAARmCAAAQXgIAAADqAgAAFwACAAABKAIAARoDg
Date: Thu, 8 Jan 2026 12:35:51 +0000
Message-ID: <CY5PR11MB63661D10CC4A2170274AB779ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
 <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010816-unsolved-wipe-bc45@gregkh>
 <CY5PR11MB6366F18F00C57AFB8C1E71CDED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2026010801-lard-maximum-7bc3@gregkh>
 <2026010830-overgrown-bouncing-422a@gregkh>
In-Reply-To: <2026010830-overgrown-bouncing-422a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA1PR11MB8858:EE_
x-ms-office365-filtering-correlation-id: 0299cf86-0a3d-4451-b0d6-08de4eb2756b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UDRWYU42KzBQMDEzcUNQQkVDczNMTnhSSVFJdWI4YUxrU0o4eTZPNVg0RWNW?=
 =?utf-8?B?WEpaV3k1WllzMXVjWlBjN1BEUG5DV0xIYkh0dS9NNm94TjVjMUNXc0RheWlR?=
 =?utf-8?B?NFl2MENZVWZnaVhxRlc4bUNuYWJyWFBkTjA5U2RzUHhQdTRWSURESzlCWEVn?=
 =?utf-8?B?Ylc3aGlCRkdtbnFVc3BONEdCaWZCMXFYZDFzeEZYdmIwb2FkVGNtV3lMNWs3?=
 =?utf-8?B?dGovVlJ1c1Jxa2h0ZmRCRDhRWFNkUlRSMkM1a0c1bzVGQVVKNGdlUFU2RjBL?=
 =?utf-8?B?ZC9EYTE5WCtIeTFTQUFnVzNMQ1RKeS8vbTlySHI2SGVoYXRDNEVSWVlZcHMr?=
 =?utf-8?B?YWtUb2k5VUYyS2VPMUpaeHk5aS9kVDQ3ZUVZQ3JaQjVaOEZTdWovK085a2tJ?=
 =?utf-8?B?aXMrN05Rd0RPemhSZk5acFJmb2JkQk5kOEkrQittc1hqa3UzNEtiNHlGQUtL?=
 =?utf-8?B?V1o3NThqVUorcGxQaHIxL3VjOFlkRzlxRkJYeEtlamJRamFBNG40cVVGY3c2?=
 =?utf-8?B?RVJ3TEllQW9zUEZhRFN2R29hbmo3cXUrekxWb1VHRjVGbnZGUVVnbG9BSFl5?=
 =?utf-8?B?dVgyMEUyc3NYckwxa21RVkR5TlZEWVFZRU1ZTTdNeXlBMmlhdG81c1VlanNB?=
 =?utf-8?B?NEh6UGtKbWRrUDBCNCtOUHQycjNoS0F4SFl2c2tuS1A2TzBRTkEvaEM1cU9p?=
 =?utf-8?B?VkNuR3ppeU1EUmV3U2hlZ2V0dVFtSi9XTmVvaitQU1M0Q1g1bFExK01TdThR?=
 =?utf-8?B?dG45aHNSalhZYkZWbm16RDNmMkpYajBKbjBzSWRiUlJlMjBTWXdYMVZlUGds?=
 =?utf-8?B?YnJ0RCs1eHFaVmRQNmpqWXIyNU9NTVU1NjhLb1RJcldZeDNxSnh3Ulhxb0h1?=
 =?utf-8?B?RWlmYWZwWEVlQ3ZlYUlIWTIzdXZJSDV3cWhvVjlKUzVSUEkrazhoR29YR3VS?=
 =?utf-8?B?MkpIQUJKVkVUOVluaEJIRy9ZZHhVSXVSQ0xhdEdtMmZyWFFJOEM2Zk9nQTNL?=
 =?utf-8?B?UnZjcDhGMUQ1UmZ3TDdFc2ZYN0dYKzdzVVFjSXF6UzlNeFdlZlkrTTlUcE94?=
 =?utf-8?B?ZG5wWXByWGNxeTVHVjdDOFlPSHBLSk5IMktGT2huY0FIVXRQVFNLSGkxSzM4?=
 =?utf-8?B?bGNZRXdLMythWDZqVmRwcG5sK3pVSk9rMEtJMG0ycVNpU1cvYmt1Vk5OVkNu?=
 =?utf-8?B?MUUremxyNm52UmV2MEphM240blplWkdpUTFheUJDZnBJcWhBNGFuNCtOeDdk?=
 =?utf-8?B?eDBjRkM4ZWZwQzBqd25yazVJZzdYTmRTc3V4bFdaV2kvNFk4YjBhMGE0SDlK?=
 =?utf-8?B?eFdjc2tKZWErRUUxTzM5VWhOQnhtZE9JR1pZQ1k0aEVGRWF3OWhES0dINmhL?=
 =?utf-8?B?bm51R1hUODlkVHNnRHdxK01BR1VOeHFaNWE4LzZUeDZvckRvL2o3SklOVWR5?=
 =?utf-8?B?alYzZDNiUG93QWc1OVlXenpjRWppVmVydFE5V3dwbGxEQkVLVGpDRWduSW0v?=
 =?utf-8?B?UmJ5a1ZQcWoyR1FyN2RhWEZXUW5LbWZUeGlwZXhVU2xibWMxdmRpRC9NelQy?=
 =?utf-8?B?a1M3SHlOd0tZRy8wY2p4UzJCSmRMell6Ykd2anJrZ0xKdFd0MmdnUzlkTUhl?=
 =?utf-8?B?L0tqZEpzTXRxNnJOalkzM3pKYUp5djM5SXh3YXY2RXJCS0hreXpaN0E3amNx?=
 =?utf-8?B?YjJoYTdBQkxSRUxJZUtMNEV0aW02VnJ4Zjd0eE0wK0JZZWpvZ0ZYWWlBZis3?=
 =?utf-8?B?NUlWcDF1L3RaTzdadUtDWGV4b2x2RitPbFpnQkVrMzk2bmFGNE5YNUNGVWZt?=
 =?utf-8?B?MW0wbFFhWjFJdXphS3VXN0NBV0dMT1lyTVFha1M0RlZQQUFWblpiS21pQWhZ?=
 =?utf-8?B?dFJVZjJoMWxTZXRkdDYzY0MyMEFkZ3R4TXMrRW5ZcjYvSlJpT0w3WlQ0cW9k?=
 =?utf-8?B?WDFEV1R1OHJYYTEwNk5ld09ja2ZZa2U4WGJJQU9OaHlPU2d0R2xEVFBCbHF5?=
 =?utf-8?B?KytqTnk3OW1pRHc1a1N5OTViZkxrVUdtbFR1RWpQRCtLcVJkdmhEMzVoT1Ev?=
 =?utf-8?Q?hirGZC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhyUkg5c1pPaTltOENnU0dMWWhBRkdIdHovUVVrMXJZcWw1L3lRblArSURq?=
 =?utf-8?B?NUh1bHBFRmE4QlFsSkx5MzFwOHdUbHZjVTNnOSsrSmFmcW1LdlA2ZmdleU5x?=
 =?utf-8?B?bHB2dFdHY3VSZjR6OW0rclRTTjZqT1FySFl4NTVOemVGTmxmL1pWZGVDOVVK?=
 =?utf-8?B?Y0ZmOTBOcjhCMXFIYU1VVjBqS1g2VnhKOEdVWEpGTzJkdFhOVTV0VUlMWVhW?=
 =?utf-8?B?V0ZuWUlFMGZ3TGN0NFZrVE4vYmRCdUY0eWpxZDh1T0NhTEhtSUszZWxNUC9i?=
 =?utf-8?B?aDU3OVZZY3VoOFN1TUZqU1N5RVNjQmZ0TXkxRElvbzloSzZKSXhVOGFYbEg0?=
 =?utf-8?B?YjhTa2NMczVtWWRGSTh0YnI2S1ovVi9TMnhwdlZnWjdydkJoSUM0aCsrQS9Y?=
 =?utf-8?B?bXhJUWgyWlNMMVlLaFQvNG9KbGpqSG92SVpndG1GUzZubTJYeTdiRXV0Ulhs?=
 =?utf-8?B?enY2azBMSkQ5akZxNzM4RS9CTllySFVUUDFPWXQyYnhmTGkycmpNWHBrNFZh?=
 =?utf-8?B?Nkx0UEorT3NxNzJlWUxyMkc5NTRVQ2c4UjRZSzFBMnpmK29GTC8vN09icjM2?=
 =?utf-8?B?SFFQVDZaL1QrQ3lKL2dyZTNHRUVuMU9ZT2ZQMVFXZ0N3aTV2dXNrdWtqVFJY?=
 =?utf-8?B?M2dJZE9PMDJtN21KS2R5RlV2cWdZR3Y4VysrelZMZ1EwQ240ZklPaUtzdHJL?=
 =?utf-8?B?WFYyVldoMHMyVzZabDBkQWg5MS9wMHJXSzYwWm0yVjBHNGdrTHcrRll6Umwv?=
 =?utf-8?B?dkdNZnJyOUlUQ1hqdUNuWEZkV1FPUHltQWNrWXIzV01lWlpmdTQ5MlVSUHFZ?=
 =?utf-8?B?ZTJVZ3o5Q1pXY1k3VFR2d3dobHBYQTUzSGdxeFRFdkt4Q0huV0cxdjdaeDRm?=
 =?utf-8?B?RWR5YzNCbG8zd0tTUXUwTlF2b1BlZDJkRmpFYTJBN2x6SGZGUFBRMkZzcFZn?=
 =?utf-8?B?aEhWa0J6RTdKa1hySnF0Q2Z3bnk5Zld4NXVza0U3RzIxeisrK1JPVFlHTjI5?=
 =?utf-8?B?NVg1a3V0c3FlcDcvK2MwcjV1RTlWaWpFbTgzNFdZTUdUUVl0WlErem5ZU2ZV?=
 =?utf-8?B?REVXQzd0UjcwRjdhQTYwc1JsWEpLQXFETkdFRUxLYm5tWi9hN1V3TW9wWjRi?=
 =?utf-8?B?SnNmVUVXQ083dXBETkJ0QXZPa0pVZlp4ZkorbC9NVDZCejhWd1NOaWc3OStp?=
 =?utf-8?B?REpaeEo0QVNpdVB3L1hTT3FKSzhkelk3VzNvSHJHVVc2ZkxwcUFPUS82OFpo?=
 =?utf-8?B?Uy8wZ05ZVmRwdjlxbkJJSmc2bEExcTd0WEpLZVFSR3YzU0ZDVHR5N0JvbFZ5?=
 =?utf-8?B?ZWo5aGNxTXk0WXd3d2NTeC9ERVlVbW8vcGJ2Uit3b1o1SkNYazAzdnZvU25E?=
 =?utf-8?B?VVkvRHo2K3F3elVLNkkyK0pNdnBoWlJMVFpJOXVsb3VyQWZxM2NBTjVkL2Ew?=
 =?utf-8?B?bUx2VXo3Rm80M01DWFQ3YnZ1dy9rbFc5K2ZDNlJNd2Q2WUhybVpIM1pwZkhM?=
 =?utf-8?B?b1B6cmJkVjB0azR4Slh5Zkt0cnd0VmgzK1dud3VhRzdlWm1NYlRNWndMaDJI?=
 =?utf-8?B?RWlLdEt1cjJWZnJjVTdkV2hlQXFnem9UNnBQdnhyK2VnbXhFRnhEZS9mU3Zw?=
 =?utf-8?B?SW1tNjd4b1VuazIyQVhJZVFFek5SNWRSZzRkcFlONG83KzJ6RzdZazk3SVBr?=
 =?utf-8?B?bnlpZ2toUFN0NWQ3akk3VVIyeWxQVkpOa2FaZG1wZENBaGFSandGMElRSVFM?=
 =?utf-8?B?RXA1TjFjdk9vcjBCeEVIMm5YZXR0MU5ZeHlDelE4Z05PcU84ZDNRZ0gxcjBD?=
 =?utf-8?B?dW9xZHNjYWxVMFUya2JLck91ZDhiaDcrWmZwZXpyOUZqMWpjdGVuelpkZmxD?=
 =?utf-8?B?bk9aeDM4YzZnelFXN3FicFl4aVBub3g3cUExd01kQmkvbyswTnJDMWRCRDJv?=
 =?utf-8?B?WDFZYzdEM0huYVlUOVR4YUM1dllxLy8ybnVkd1lRNTB4T2hJVnlPL0V1VUVs?=
 =?utf-8?B?cE5UbXdIbmFQV0ZGKzM0aldpUlErTlpoYmdTOHNTdnIwL3FvdzFmQ2RYQk1E?=
 =?utf-8?B?aFhyVjN5a29FYm9SejZ4NVl0czBnVi9OVU1YTDlrT3lCV3l1bnZvK1ZuN29s?=
 =?utf-8?B?eGgwWGJpSUNxM2E3em1GU1YvV2huQW82RVdCRi96Zmh4V2FHUzZhMEJTRnl5?=
 =?utf-8?B?K1U4LzVzN1U2dVhaZE9QbVM4U0JKbVBQK2RqcDM1Y1JrQmlyRzZ3RktrSWRi?=
 =?utf-8?B?VTJtam11WEN1Nm0zcEVuNDNGRnFQNW9OZnNIYWp3VGpmcEVnWklDSG80bUhX?=
 =?utf-8?B?MFhvdGtsMlRBOWJ5WFQ3VUNXcmJ6Mlp0ODVtRlc4QU5BU1habmxhUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0299cf86-0a3d-4451-b0d6-08de4eb2756b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 12:35:51.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE97UMnodq8vXMppeDa1tiryoKSiwQxf8HT1K3zppGb4g2IK57vWy5VfXO3VRrzfLtsNE4LgeiczKp25fFOkXgpKzKxKiJ4SgUnN6z4A1QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYyB2Ml0gbWVpOiB0cmFjZTogdHJlYXQgcmVnIHBhcmFt
ZXRlciBhcyBzdHJpbmcNCj4gDQo+IE9uIFRodSwgSmFuIDA4LCAyMDI2IGF0IDA5OjE3OjEyQU0g
KzAxMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAwOCwgMjAy
NiBhdCAwNzo1OTowOEFNICswMDAwLCBVc3lza2luLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gPiA+
IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjIHYyXSBtZWk6IHRyYWNlOiB0cmVhdCByZWcgcGFyYW1l
dGVyIGFzIHN0cmluZw0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIEphbiAwOCwgMjAyNiBhdCAw
Nzo0MjoyMkFNICswMDAwLCBVc3lza2luLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiBT
dWJqZWN0OiBSZTogW2NoYXItbWlzYyB2Ml0gbWVpOiB0cmFjZTogdHJlYXQgcmVnIHBhcmFtZXRl
ciBhcyBzdHJpbmcNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiBUaHUsIEphbiAwOCwgMjAy
NiBhdCAwODo1NzowMkFNICswMjAwLCBBbGV4YW5kZXIgVXN5c2tpbiB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gVXNlIHRoZSBzdHJpbmcgd3JhcHBlciB0byBjaGVjayBzYW5pdHkgb2YgdGhlIHJlZyBw
YXJhbWV0ZXJzLA0KPiA+ID4gPiA+ID4gPiBzdG9yZSBpdCB2YWx1ZSBpbmRlcGVuZGVudGx5IGFu
ZCBwcmV2ZW50IGludGVybmFsIGtlcm5lbCBkYXRhIGxlYWtzLg0KPiA+ID4gPiA+ID4gPiBUcmFj
ZSBzdWJzeXN0ZW0gcmVmdXNlcyB0byBlbWl0IGV2ZW50IHdpdGggcGxhaW4gY2hhciosDQo+ID4g
PiA+ID4gPiA+IHdpdGhvdXQgdGhlIHdyYXBwZXIuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
RG9lcyB0aGlzIHJlYWxseSBmaXggYSBidWc/ICBJZiBub3QsIHRoZXJlJ3Mgbm8gbmVlZCBmb3Ig
Y2M6IHN0YWJsZSBvcjoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEZpeGVzOiBhMGE5Mjdk
MDZkNzkgKCJtZWk6IG1lOiBhZGQgaW8gcmVnaXN0ZXIgdHJhY2luZyIpDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gVGhhdCBsaW5lIGFzIHdlbGwuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
dGhhbmtzLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGdyZWcgay1oDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBXaXRob3V0IHRoaXMgcGF0Y2ggdGhlIGV2ZW50cyBhcmUgbm90IGVtaXR0ZWQgYXQg
YWxsLCB0aGV5IGFyZSBkcm9wcGVkDQo+ID4gPiA+ID4gYnkgdHJhY2Ugc2VjdXJpdHkgY2hlY2tl
ci4NCj4gPiA+ID4NCj4gPiA+ID4gQWgsIGFnYWluLCB0aGF0IHdhcyBub3Qgb2J2aW91cyBhdCBh
bGwgZnJvbSB0aGUgY2hhbmdlbG9nLiAgUGVyaGFwcw0KPiA+ID4gPiByZXdvcmQgaXQgYSBiaXQ/
ICBIb3cgaGFzIHRoaXMgZXZlciB3b3JrZWQ/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhpcyBz
ZWN1cml0eSBoYXJkZW5pbmcgd2FzIGludHJvZHVjZWQgd2F5IGFmdGVyIHRoZSBpbml0aWFsIGNv
bW1pdA0KPiA+ID4gYW5kIHRoZSBicmVha2FnZSB3ZW50IHVubm90aWNlZCBmb3Igc29tZSB0aW1l
LCB1bmZvcnR1bmF0ZWx5Lg0KPiA+DQo+ID4gU28gdGhlbiB0aGUgIkZpeGVzOiIgdGFnIGlzIG5v
dCBjb3JyZWN0IDooDQo+IA0KPiBXYWl0LCBubywgaXQgaXMsIGJ1dCB5b3UgbmVlZCB0byBzYXkg
d2h5IHRoaXMgaXMgbm93IG5lZWRlZCwgYW5kIHdhcyBub3QNCj4gYSBwcm9ibGVtIGJhY2sgdGhl
bi4gIEFuZCBpcyB0aGlzIHJlYWxseSBvayB0byBiYWNrcG9ydCBhbGwgdGhlIHdheSB0bw0KPiB0
aGF0IGNvbW1pdCBpZCwgb3Igc2hvdWxkIGl0IGp1c3QgYmUgcmVsZWdhdGVkIHRvIHRoZSBvbmUg
d2hlcmUgdGhlDQo+ICJoYXJkZW5pbmciIGZlYXR1cmUgd2FzIGFkZGVkPw0KPiANCg0KU3VyZSwg
d2lsbCBhZGQgdGhpcyBpbmZvIHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KVGhlIF9fc3RyaW5n
IGFjY2Vzc29ycyBhbmQgZnJpZW5kcyB3ZXJlIGF2YWlsYWJsZSB3aGVuIG9yaWdpbmFsIGNvbW1p
dCB3YXMgbWVyZ2VkLg0KT3JpZ2luYWwgY29tbWl0IHVzZXMgc3VjaCBmdW5jdGlvbnMgZm9yIGFu
b3RoZXIgZmllbGQuDQpUaHVzLCBJIHN1cHBvc2UsIGl0IGlzIG9rIHRvIGJhY2twb3J0IGFsbCB0
aGUgd2F5IHRvIHRoYXQgY29tbWl0IGlkLg0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCg==

