Return-Path: <stable+bounces-69432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D7956130
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8946E281D6A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7924B34;
	Mon, 19 Aug 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PJldA/WW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B/LN6IDV"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70643ACB;
	Mon, 19 Aug 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035242; cv=fail; b=J4OWY2V57avDuBojmDgRjB2HFG942c5NNnQyHfuqL9iDBrKn11TcUQfhJF6Td/OdYWPLRszcz0tP0v3ePHkkITekGQFaZwEOMP6So1wJG8a5HT5PUDAYhvoDckI7bJYC9H5j6Ikm+6l06u1Twc+cvIEsygRFQGS0KLE5AF1yiB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035242; c=relaxed/simple;
	bh=QsSk/lr6uOQc6ZqJ+XYsdyH45SuQeLEPS9HGji1Virs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NMNzT6C11Ysn/DqDtzhPCgvji3IvPGdQj+Yhs7hVuS3Ckmktkhe5VHb2PT1Yz3XuhJOWlOnk46cIafaJeQYMT0UYLWcSwcCyOx4Pwkxoyw5YL6rZTMSMNVFivH7j/vHxMAHtNyJ8FG5hUgKM8+zpT7iDYZ0s0Mio4vrajwp9Usg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PJldA/WW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B/LN6IDV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724035239; x=1755571239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QsSk/lr6uOQc6ZqJ+XYsdyH45SuQeLEPS9HGji1Virs=;
  b=PJldA/WWHEQU8D8G1R046ojRR9puedBncT6eSvSOrQoew6CW3uR4ChSE
   vSC7yGv9PD8xye8yaQVVjo5DNxuHMXzuKNxy0bSWmx0RD3nIpcw+ON1Gv
   Y82lggSNpnhi4A/EnVpnGHhbTMK9pVzsNNHuafjicxG+fXdUXWmT5Rb0o
   QqqHXLq6a0ucc41R7oYy+eBqXnAS5PPyec3FoL3onLyA3MTrNMBWDao4B
   zz1tfXZo1IiX2zhuib4vlJXqsS+qnRF/tgyclIluZDzbM+W6ofR/ePWFK
   OE6vI6QCYLBnDolWKMQkqvDwq/cWAfeIVV+7JL7Fi5cZxo9MXpi7js2Og
   A==;
X-CSE-ConnectionGUID: vr3l3EiySRaI2XFo0JavUA==
X-CSE-MsgGUID: YyZq6oXdTZOuu7OCRo86og==
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="30594894"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2024 19:40:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Aug 2024 19:40:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Aug 2024 19:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRL0QtBF2yKj8xTJAFlJuKBcdrUcxd510a1p2fsKYMLTn7DGK7UhoEsftqDmF3v8wtqYNOHCw/oNXoC4VGWUoTQTwQGXyPrDJt7IyYQIrdlKwcAFAX7ZLViwKAqVy4qWdZBgURSls6EoBMavM6TRPvwscZEWY1PZ1DmlRJ9g3xCOgLvR3CzGy79k39wyBlDLdyLXdUyy1vV3L8E0gyM9Cyo+SnEc4UmRvh0K1kCDW6Y44BGbI8lNadLppsarMpPowQW1UqdcHmmNzxTZZFJ+Vq7NY6BFO8L+S+6GmBwncYCYQORzh/yH5sfKjINMRgKiXLoj70gY8s/icASNaWd6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsSk/lr6uOQc6ZqJ+XYsdyH45SuQeLEPS9HGji1Virs=;
 b=KA1zJD7YDMevKKOkMi3ZtLeDEuXuNC/3TQM9KCKXAAJYsE+D0U5k6kLVOdRmG8X7KouX7aSN9OjcWKcr0v+N6b6bbRsuchOWUV4Ao7/YeRGDRO7NhjtkFm+WApx8WyHlp9Gwn4MJgQdhYKB+/dtCh9Mo6SuEIR3Tww5ujfT0lYqUC8fXPZ4GiRsaGatA59ZDZfQraDkyZpIZIt4mEKgTrW0yz1tpg3YKbJ3eXuMbEJNVy3Itohfr/s9QmNSBpnX1QDfem5t8Fsr24iGNGcdCZjpOwfalifWX8HBfybWSp4jHgX2FIu/bX+l7BlnOPlE28cb59alrnBy11Aa1+UpQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsSk/lr6uOQc6ZqJ+XYsdyH45SuQeLEPS9HGji1Virs=;
 b=B/LN6IDVj+roWypH5A1jVYYX34kK4j8VlXyvgdYIqkGTpmrNpW1IgBBKhj4YsWrhy/SOPlKqtL7TwCYqkIzeZ03heaTuBQLACtqAKqSNAWFGB+jxVymbiSI50tdcMtb/Sp3VXmwsuSvX2nBkXcLejZ+AYDBRu/VkOP76HnGhi9LStCpU/jthsu0Ey6vhVrNjcizMOseUm3PJ9HzbR0sHSl0Z/Td6ujdmUORbZzAL1w7dvHmJPyURo2lCICdnQF2ebAQ5d6xXQskEzgblJvOfOd+SVNEKoQkNPglmxxJqNpgyQFLgj2BVZ9AcO57J4SdMoFblzd/SVTBjssDFDi9/HA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:40:06 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 02:40:06 +0000
From: <Arun.Ramadoss@microchip.com>
To: <netdev@vger.kernel.org>, <foss@martin-whitaker.me.uk>
CC: <stable@vger.kernel.org>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <ceggers@arri.de>, <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Thread-Topic: [PATCH net v2] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Thread-Index: AQHa8InKO01LH0uaQEyDrEwWKbyLxLIt4dAA
Date: Mon, 19 Aug 2024 02:40:05 +0000
Message-ID: <fb2f5335d2046bfd420699f3f94e22f66090b808.camel@microchip.com>
References: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
In-Reply-To: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH3PR11MB7915:EE_
x-ms-office365-filtering-correlation-id: 57b6928b-c156-4ea0-1fe6-08dcbff83c09
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cG9ZYS8xNURpc2VwUjBNR0toa1FRUVN3ZHJMTWtOdThPeW9Ha0E4L1NQYzhX?=
 =?utf-8?B?U0dJdkZwS2J6UFBYSFNuc2ZvT3g1Mlk4WjhqUmlyWVdVcUlOcjViWG5Uc1lP?=
 =?utf-8?B?dkVoT0U1M2h4ME93cVV0enVMNlJHVlh2RE55MGZJbnV3cWhkbVFMSzhySE5h?=
 =?utf-8?B?ekttZXljQXJWU3Z2MDNPQzVrYWZIY2p4eFlkRTh0dEZiN2hUWmVKd3dPUGxQ?=
 =?utf-8?B?TW1qazJzV0FCb1lwUU4wazJ4T1JOaTlRYnViV0J4OFUyUjVQdVkwd00xd25o?=
 =?utf-8?B?b0phSTNGNEw4WWluZG5aV2l6RWlRTkE4bWZqRk5veldiQUh5OFRLSEE5Q0V2?=
 =?utf-8?B?N2EzR0NDSENPdG1wcVpqa2lDamRYTmI1NFFTbnRFdnhqNUJvVDl4MUtpRm9m?=
 =?utf-8?B?ay9LVC9idmkyWGhUeEwvUFpkeVNXUFczUU1lNVg1OVVNRERDN3ZYTGRrRHV2?=
 =?utf-8?B?eVlZbzJ0dTVmZHFXb1JvcFJFZVdqL1Z6NGk0djl6N3pNN29wUE42cUYxSlV3?=
 =?utf-8?B?NkFleEZqQTFnbUdVWFRCamtXY0NSMHo0M2E3Z0pILzhUZEtFQ0JFUVJKMjlu?=
 =?utf-8?B?TVQ0RG1CcnJjZytBajNjTXZQamdYY1JJcjRtdmdjRmJ6a3dTNWlsclgwQW9D?=
 =?utf-8?B?VHFWM1ZyVTZwQ3FGNUxhTWg5Mm9vOEIrOTc2WUNIYnpMWnlCV1Nyc0xPdCtp?=
 =?utf-8?B?Wm5FNjA2QnAyZFNpWDF0ditGUXliemRNWWZyTnI3UHo5djVndURuSzB4d0c3?=
 =?utf-8?B?QmRGdjlsb3hmc3VtUFcyNGVUSHlXOGVqWk1FOG5HN0lrTTBvUmc4RStDb2JM?=
 =?utf-8?B?SGlPakNrNk5QYkFoV21uWDM1WkdxdkZqZ3F5Zk1oWTMvSW54cVdUcUk5SHB4?=
 =?utf-8?B?QVcyVGVmeUVJa01RV0ZMc0xqYzd6cy8rV0RoOGlsdCtPdHA5dExFUDVVb1hh?=
 =?utf-8?B?V2F3K3E1VmpsMW9zdDlRSzlSNGcxekwwT2FmWXdSNTNGOUNpdmUwbEpydHhu?=
 =?utf-8?B?NnlibFBxd1lrU0F5bytzcWtrbFkzajR0aFdZV2JYemZFZHgvb0JlR1VjME84?=
 =?utf-8?B?bmtBdVlKWFZIRWZGSTBJdEVzR3lpL3VUd2RLeUpIdGROa2RBZ05KU3lBbHZE?=
 =?utf-8?B?VU83WnJnWXVMUUkzVFNrd285RFJ4dDVzbE9HRzlyS2ZLM3ZOWk45M3I1ZGQy?=
 =?utf-8?B?dm05bmFQMlVtU3kwd3h2eVl2d3RDTDRjV1NJNEIyZVA1UE5XbU9taVQ0OGlj?=
 =?utf-8?B?TmxQVHVuUlVCRHlGQTRDRzZEUkU5dFlqdzEremxJZmhLU043UUtqRjVRQ1Bu?=
 =?utf-8?B?N0RqNUpRRnNOUGtnNjBnRlRuL3hWS2lZQ2hWYituVnlWM0sxUXYwbGc4UnR2?=
 =?utf-8?B?MzZxVDJQNlJjbDhKU1VsV0R1RWxEU1hyUE5ieXNpZEVYblJnWDE1bDFQU2xI?=
 =?utf-8?B?MUFaMEVtd0ljTVRucER0eDdiQ1AwQTdyTm5oNVRHRWNNTi9kMEg4bldXK1lk?=
 =?utf-8?B?a2c5K29QZFZEcmJRYnJRcFJGejd2aWo2cDBjUTd5bHowWFBUaVhURUx0N0xQ?=
 =?utf-8?B?U3JnejBtVGlIcCswRUZVb1lhcmZlL2pmcXY1dnJFbEk0a2RiM21SOHZVaXVY?=
 =?utf-8?B?aHR0alZwYzJ5eUZENjBjMjg3T3FkREtsYmpZL0xVY3hkclJxTjRrVzJKdDRO?=
 =?utf-8?B?cW5zOUZrWFZqcythdi9SZnRTbGpMY2ZxL1FGNnU0VFFUMFY4RWRoRWV1K2Nw?=
 =?utf-8?B?dFVzUVZBMjl1bU9DbGt4KzVndkdWdjFIQWFzOUhoenNocXh5ZzRWc3ZVejBZ?=
 =?utf-8?Q?R7AjL10lvKD4qfE5bPhYxB59LoY0UQSvqLYXs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFJXTURERmJnN0V4MHNaVjFGN0N3M05FeWpTeGp2bXh5K1ZzMVloK21JVjFx?=
 =?utf-8?B?QW1SNUtLVUxyMDhTVVJJUHU4Y1JlRnVneWJJKzdBY1hxRFIySUhqVWgxL2Js?=
 =?utf-8?B?OVYwd0V3Q1B5NEFMRDRlRUhMdUZCSVdvT0tMemJBclhtQnRIY2JJM2RJTmFX?=
 =?utf-8?B?djQ2Q1ZGQWtPcytZajZEUkJvRmZYeldha2F0R0pnOHQvUDFZRjZCNTR4V2p4?=
 =?utf-8?B?aGxXV0FKc0F0Y05ROEVwa3pnZ1RCQ0dnek5sbENMMWR3WSttbHF3UDNEemFx?=
 =?utf-8?B?UUgycXJNUUhiV3pTRjE0SGNhNXd0eWVhM0p3TjNmdGpBK2NadkJ5V0NUcDBK?=
 =?utf-8?B?SDNUaVppcDZYT21XZUlOa0ZwaGhXZTA3K0FaYXhkL05BdXp1RGFtaUNJNUh1?=
 =?utf-8?B?OTNYYWRFSEgwR2JleUl5czdLK0FmTGFxMWR4UGdyQjhqZ3JvN0pEVzB1d1Fi?=
 =?utf-8?B?R3V5eXlhSTkzQlFtbzJRREY2MnFOdFZWWk5QUGdDUTFXU3JQUEdRdDUySlBV?=
 =?utf-8?B?cnlORkdKTnB3bGpwckRlRG1sQVJoYlhJU2NnRVF3b3BQK09qQitBVDB6R1Ir?=
 =?utf-8?B?NTIvTGsvV2s1bGlvV3ZFVTRqTnBmUDBiRSs2amk3ZS9zUW8zNitGVVFKMDRm?=
 =?utf-8?B?Zjd5Ty9OcmV2T1hCK2w2T09SZjhkNHNDdDBBc3RqT0d3c1VWNzRzOWdOeEI5?=
 =?utf-8?B?UVYvWmMrY1hITzIvQXZVTUg0ZzcvaVZheE5ESmtOMTJjQmtLMENDZTJxb1Ru?=
 =?utf-8?B?Q2V6ZVNQTUNDNTd2Yi91bWlvME9ycFB6L1RQNXlYVVFOdllrWFVTRXlGbjcw?=
 =?utf-8?B?NVhQNE0rZGZOY3d0eVRyZjZLSk9ZZ3pWakxvRDdXdk9zNTBRTGFPWERoU0xM?=
 =?utf-8?B?bnhWa29FMnl0bUdLVGpKcjY2OGhYbDdQUTJwSjhMZXBjRzR3UEZabTdHQlQ0?=
 =?utf-8?B?Vm5xOXNjci9XLzR1cS9SZ0ZpQVRoSkJLRkVvU2MydkQyUnJxeTBlRUdnaUxD?=
 =?utf-8?B?YUk3azQ1dTZISSs0OXdXejhZRTBtUmhjZ3BqUm9YNUVoeTllZCtwN3AvVEdp?=
 =?utf-8?B?bzFKLyt1ODV5N1JnMXYzck1leisrYkdBWHREdE02RmYyWS9YNGNINCtJOUpM?=
 =?utf-8?B?TWdJQWVqN3lUcCsxNFE4L1IxWmVhMUlEZ0o2Z3l5bjNDR25DVUxXZ3RtV0Jt?=
 =?utf-8?B?SGc0MXNNYnpiVHZKVzJaVkFTeWpjSXg5YUpMektWcnB0MXJpQjVSSDErekEx?=
 =?utf-8?B?aDYzak1jc1A5WU9uTTlhQmNLbkJWYVhHQWdSYTN2d0lGeFRvT0p2b1hNVjJa?=
 =?utf-8?B?cU00VmQrNmF0aHUvd3FFQkd6K2UxQXUxNUZZdmtDMFZqeU0xdkJVaWIxTDhY?=
 =?utf-8?B?VWdIbkQrNnFXZ29ENHFsbVVyNDVaYlFXQnNwRGlXaklZRnZQcmNyelFjNkN6?=
 =?utf-8?B?VFdpMVFHTXdqS29ZekJJanVBK0ZkOVdIRWloTWdzYXBaRHRQYXdtanNseW1l?=
 =?utf-8?B?b2xFZjYzTmVSeUs3L2hoMitRdFoyKzBoYXhLVDVoNHI4Nnk4VEN5d1loVlow?=
 =?utf-8?B?WDQybStZVmMvcFZiYmR3RkR2cldqdjVSOTB4SG1XeXNYZGQvQmM3aHlZOHps?=
 =?utf-8?B?R3I5L0FNNmgzZWoxZ3B2VExTREJ6T3NHai9SNnB3YSt0YnRGNnl2OHQvcTFy?=
 =?utf-8?B?bEljb1dVRHNIUEpuc0ltWkRsMkpsYlR5TzZhNTMxcG1yQyt3ekhRakpidjlh?=
 =?utf-8?B?V3Q3K3lVSm50Y2Z1d2VvTldXWjA5RUFnMWhWeFo2ZFM0ZWYxcndneWg4YnJQ?=
 =?utf-8?B?MDVLcGtsc2EvV28yTTRLQlpyZGJ5L05KaFBFNDRqLzF1dU44azBGVmY2M0gr?=
 =?utf-8?B?c3FXWGxxVitjQWJ4ZFIyaFJDSG96YmE4QUlwS0tVT1NTZTEydm9zenAvNUhh?=
 =?utf-8?B?SVM4eVlMeVhQMVhSZ1dRUGpSYmdsdUh0UURaZmFxQUZ6RXdhTTlXWHZRRFZn?=
 =?utf-8?B?VTNxVXBIZUt6SnlvTzkySEp0VnhUY2RBWG03T2dFYkptRzFkNFBsbDc2WXU0?=
 =?utf-8?B?TFRCSGxYdTEyR0VCODZYSEVIdkJrajFMaU4welF6RUJSSVFQQ1hSMHp2ellm?=
 =?utf-8?B?d3FLeXF2MVJjMUMvNnNYU2xMSFYyVTJkS1g4YThZQzJ2cUNNNHlYa1MwMDVy?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F30C0A4DE3E6C40A8DD27B1BD041704@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b6928b-c156-4ea0-1fe6-08dcbff83c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 02:40:05.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdgAyfGntCPKLV2sVmM6XNeZTMvsbO0DfdDMGeyaZGlAXFR3/huyU8XQnSBDvRv5K1H7wboiCiRHhfG+ClLKmbIHF4F7G3RJh/6pQ0IXGG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915

T24gU2F0LCAyMDI0LTA4LTE3IGF0IDEwOjQxICswMTAwLCBNYXJ0aW4gV2hpdGFrZXIgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV2hlbiBwZXJm
b3JtaW5nIHRoZSBwb3J0X2h3dHN0YW1wX3NldCBvcGVyYXRpb24sDQo+IHB0cF9zY2hlZHVsZV93
b3JrZXIoKQ0KPiB3aWxsIGJlIGNhbGxlZCBpZiBoYXJkd2FyZSB0aW1lc3RhbW9pbmcgaXMgZW5h
YmxlZCBvbiBhbnkgb2YgdGhlDQo+IHBvcnRzLg0KPiBXaGVuIHVzaW5nIG11bHRpcGxlIHBvcnRz
IGZvciBQVFAsIHBvcnRfaHd0c3RhbXBfc2V0IGlzIGV4ZWN1dGVkIGZvcg0KPiBlYWNoIHBvcnQu
IFdoZW4gY2FsbGVkIGZvciB0aGUgZmlyc3QgdGltZSBwdHBfc2NoZWR1bGVfd29ya2VyKCkNCj4g
cmV0dXJucw0KPiAwLiBPbiBzdWJzZXF1ZW50IGNhbGxzIGl0IHJldHVybnMgMSwgaW5kaWNhdGlu
ZyB0aGUgd29ya2VyIGlzIGFscmVhZHkNCj4gc2NoZWR1bGVkLiBDdXJyZW50bHkgdGhlIGtzeiBk
cml2ZXIgdHJlYXRzIDEgYXMgYW4gZXJyb3IgYW5kIGZhaWxzIHRvDQo+IGNvbXBsZXRlIHRoZSBw
b3J0X2h3dHN0YW1wX3NldCBvcGVyYXRpb24sIHRodXMgbGVhdmluZyB0aGUNCj4gdGltZXN0YW1w
aW5nDQo+IGNvbmZpZ3VyYXRpb24gZm9yIHRob3NlIHBvcnRzIHVuY2hhbmdlZC4NCj4gDQo+IFRo
aXMgcGF0Y2ggZml4ZXMgdGhpcyBieSBpZ25vcmluZyB0aGUgcHRwX3NjaGVkdWxlX3dvcmtlcigp
IHJldHVybg0KPiB2YWx1ZS4NCj4gDQo+IExpbms6IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvN2FhZTMwN2EtMzVjYS00MjA5LWE4NTAtN2IyNzQ5ZDQwZjkwQG1hcnRpbi13aGl0
YWtlci5tZS51ay8NCj4gRml4ZXM6IGJiMDFhZDMwNTcwYjAgKCJuZXQ6IGRzYTogbWljcm9jaGlw
OiBwdHA6IG1hbmlwdWxhdGluZw0KPiBhYnNvbHV0ZSB0aW1lIHVzaW5nIHB0cCBodyBjbG9jayIp
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBXaGl0YWtlciA8Zm9zc0BtYXJ0aW4td2hpdGFrZXIu
bWUudWs+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hp
cC5jb20+DQo=

