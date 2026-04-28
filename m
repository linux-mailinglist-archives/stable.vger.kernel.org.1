Return-Path: <stable+bounces-241531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEYvN82G8GnuUQEAu9opvQ
	(envelope-from <stable+bounces-241531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:07:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3148238B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 168B3301F3FE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0932BF006;
	Tue, 28 Apr 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VxgtfnRD";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="3UG81LLy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFF3E276B;
	Tue, 28 Apr 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370770; cv=fail; b=PqtAXXC3L9XWBlkXyo+aJj4Y3ksERKJn6rlKSfstDrasnrT5v9Kb5pc7zkMjW2POOKaCJjaqahVYldKi1+PyzBBbtDG8BYBlXHIxRmGpd7PllGAPc2XdhygD7By35yElpqJCrKd9hyB7YkmPit2rq++BYd8fQhaVqAAiswjib/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370770; c=relaxed/simple;
	bh=tkvOZdlFCD68SpjhVGIerQnin8XZ05M4cyibyXJbvfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mE6S3r3TXzEqahSItn+orI1vHQKYYHl6urr0V5uVH+qE+4dCNXaodMiwzogNfU7RGe4iqf0cp70jy+ttWufmNEzHkLbAqYBJQqTCJBb+xIeWjjbf8AaC9Jvh8p5xCbIRdc9N7GFIhLAI1kTpxAUVz0E7gnwdurvC3zrN1CFHVfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=VxgtfnRD; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=3UG81LLy; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7PAt6454521;
	Tue, 28 Apr 2026 02:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=tkvOZdlFCD68SpjhVGIerQnin8XZ05M4cyibyXJbvfs=; b=VxgtfnRDrJwu
	nh36S4M0MTlkjYuCpIqjWsYeI/WyL3lsPHAPff5sP+wfjKeB02KWYbKCjITODdzk
	cR2E6/Svke+b3xM7uyYqj23Q66bKTLWFiNdK3SF72OkT/w7BoW8LzTIoEY3jGOiy
	+Hp1jWVcAf+cMbFWWXYx6ER3hf7d54wK/qesfGVRxDVfbCHs1KanbKT7KaUfMx+2
	eBbx0EO/aJOSCpTiJPORTDCpwqYvrLsalbJibrOnKR9UShI5PeBoORKrAL7wTIJN
	pv/SiNs2soATB6qusHF+AortCOp35+lYyfEw6BoswDuhk1eFcDhkRXaTkSlUdg2U
	CKx4MMnn/Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4drt5rk94f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 02:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpCCq/Ggj6IIc6BDY1Kv2Np41eDgbNJBXju02CU1qKAJondtP/TUpPilh9dl7l+TegOfNBsrMcZTD6xwi4u7v3BF5WjoXDSiHWfqhXd3/PvXDc2yvUzWPwvG5PokK7y0IllAvqHDFAKBuzniS5pUeHraUc6ZzT6OvZqUvR6H73nnhNO9R8Ye2x0O8ff1qY3bCYWA2LNILuUFtEf67QpIFEHd1VY/FV5Vj2s6OkeFD1z4wGFImkCMUPaAn7n0+5lEZCjsxpVMKjEdCH101DI6X5DnNFkBtz+5RfR4RxAbDyqmA/ECfdK+tV9oTjG7PTSGU4BM76b5sBxTAMbZ1zLvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkvOZdlFCD68SpjhVGIerQnin8XZ05M4cyibyXJbvfs=;
 b=LltycHIVok8O8y9WnoNU04ry1w/EjQ+oyWDefYn9EAPHDDKuVK50BuM0AJl3UzRNJj3257tqRYgRrLSXwaD82IxRHEe1CJd2/u5Ytfd3CinkjKV6hvy3BPTk5vUIl9RK/Q8qbmklgJ4ScJKmItBfyB9HHZFRCx+QxW8PLQgToD4u3r17UNz7xJKZrqlHkUm4b9oUgbrAQjydm0xz7/8Av772W5ML87KRIGc2KvrBdHOudQdDYjmD9yOFDNHwCIhhaiwSr5MbX6hZWXKojRhFWM09NQ9rVnE9opGFN6p4SrbCN/8Swf5tRHZ6b6y3aqtzn6JFiWDB7ZzuAWZi1wFK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkvOZdlFCD68SpjhVGIerQnin8XZ05M4cyibyXJbvfs=;
 b=3UG81LLy/ou5cOnbno7MiCA6w8lBC+YY2nz9MuXuqA2bOUWAp7Xa9qaJENqj9p/RTeMIWmhhfoAyw7Ne0ybL0hEvHkQDs+EYS0PSC2Vy/iKcJVvSsIK4GnJJ+6fPMLv36V9CxImuOob0yqX0jXO40nAYknVHmqJc9NVGeqjWARiSeeD9o8svHejax1Lgo7/6dnraHsmRMj/bRkVd00tzvyIG+mVYbFGp8NR1SjTmyiEkYE5YapCet6PgLQphm6N2B/j8RuHL8t52CuaeZIyYHhZJaiIMjRzhxmDYU2f1k1IHkOWQTDZMG5motiLUj2jbwKc3+KB2EsL+O18Jrwt9Xg==
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by PH5PR07MB11891.namprd07.prod.outlook.com (2603:10b6:510:39e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 09:58:46 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe%7]) with mapi id 15.20.9846.026; Tue, 28 Apr 2026
 09:58:46 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Yongchao Wu <yongchao.wu@autochips.com>,
        "Peter Chen (CIX)"
	<peter.chen@kernel.org>
CC: "rogerq@kernel.org" <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
Thread-Topic: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
Thread-Index: AQHc0zshyXnKL+kJ40WvjjGf2ih8TbXyIjAAgAB5XSCAAPELAIAAEJYAgACnXnA=
Date: Tue, 28 Apr 2026 09:58:45 +0000
Message-ID:
 <PH7PR07MB95388984DB7A5265770CEE58DD372@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
 <ae66WphA+lO6t3rE@nchen-desktop>
 <PH7PR07MB9538E83DB108635EAE7B21E3DD362@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ae/qXIT19Z2zWsDs@nchen-desktop>
 <e963d293-63cd-4124-9a53-8fc16e44ec72@autochips.com>
In-Reply-To: <e963d293-63cd-4124-9a53-8fc16e44ec72@autochips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|PH5PR07MB11891:EE_
x-ms-office365-filtering-correlation-id: 054dff2b-95ab-494c-13b0-08dea50cbcd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 lVWwmn3oKoaDkEpb6m7BBdB+mqXIEOP3MeghLDPgBwMl6IDKjDQiUxKJz1ATBOEEvt4IncfpRFAaHjNz1X3IG6HQaqUBOHCPlx0Ay4/DjuPHT5E2sxbchjGPpJwJzA27GiQw76qJwl1DSo4sFfyCMpErJkUzA1Aj29wMWVR8ZoRlZz9NexUjFyIvCZ6UIfJrDy9oCdFdZpG8lT4Sr6E+wWfhm0gFn2jEdUOGyQT/Baro0MtJfDcrx1OROZ7ObEx2r/5U9yfOJxVjMXv5kUwvHQeWgBF8lu3bWVIBLhdyoQwS3bUOPTFq3+XHTVIG6wHpB0IIRduLToUkWyy98v8dQoyBx2oX67xnJsYejbem471WcjvPrOqG7jupv/B9v93yE9wxReGmpeazCuU9PnI0OH8wNO9VQ+PMSkjFURE0DoG/3+kTyHJ5ROcxiCxN9/BJNdnMxJPiZjXQ/lwr3J7aT5wGqDOipdx2MF28GAyKbgYEpCNtIcdERpsMSlE2EDQF2gvsDDDWKdTxBPIVixxad6cRHDkYfW+Fe2c/esbh1ueH31/PEUD7Fx+4jsM1Nov0ZOIUK43XC4da85VgNHA++rIVGFtNrVArGvLbbPdz/xiJaTBEc0H9kGvNmlmIjVw+S+qP4B02ZtLM9Hx9N9g0d8qs8zm1eL6NrIIuz/ox3p+6tFyueIUD/B6BD5yMqHt3Wug6AgLpn5TpjlbmekXs3+4DTMW4j1NoY37vDt52+NVKgbU+HGLNaFSXjtFNUOZ0ABdYdhq1TFy5Of6pBnRGUSrXVdui7WTxpW9QZ5AdnvI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFhyUm53M1pSRzhNRXZVbm1nY3ByT3d1RTlWTmFWTzdjZEJyRG02OWFHeGZj?=
 =?utf-8?B?cDZpK0dJdlZHZEN5Q1dhMmwwUW5pWURReXBsZG9aUloyZFlDL29JUSthMHdw?=
 =?utf-8?B?VWNNdnJZQ0EraUc5MW9hS3pzRzF2am91Q1o4SFkrREJ3dU5RSCtLSndBUlo0?=
 =?utf-8?B?aE1LRHlWMUZxVW9LQzFSalRaajJCMlB5b0ZBUkJGNVZBR1dwbXVvblV0Tlgw?=
 =?utf-8?B?MHAyQVhCM2Irb3Y2RWkvQ1B4U1E0RWE1SmpXUDIxN0cvM0FJUFhWV2xzWElq?=
 =?utf-8?B?VlJPU0VqVjJvM2hEUzJlaXBYd2NuWFI5MVo1SW1kM2RpNFFJOUVlMHVzUWpa?=
 =?utf-8?B?OEIwU2QrMHZOdkFraElkZ0VpS1RETE9ZY0JkcW9hbDJQUVBrc0xwNjB1WFZY?=
 =?utf-8?B?bVJnWTFjSDczM29wQmFjY29lUTRBRDVVSHg2TzlrbGE1VTMrMkhSK3NYVHNs?=
 =?utf-8?B?d0VjbUJhRzRBVzkvNVl1MlFLQ3c1aDhxQnBVRW9hR0ZWalF5bTRyOFpXQTNz?=
 =?utf-8?B?aFI1VXIxRHRTZkYxdFJHem54MloyRHhLUDE2K0o4QzFoYStGL05BK3IxalBU?=
 =?utf-8?B?M2NKZjBHcFhLeWErODRENGNrSndSYlpTNHMwbGRWdGRsN2s3TlhBeDhIeUhC?=
 =?utf-8?B?eEZPaHllL25UUWRBZlRWUHVDWGI1Ymh4bWh6em16NnhxUmhEWWQ5Ly90eWpX?=
 =?utf-8?B?WHIyeFIyOEhpMC9yWWNJeThyRjRXU3dKWjQva2h4V0wrWVlxdXRTMytGT1Ro?=
 =?utf-8?B?MU56elBoOUFqdFY5VlM4ZWVENjBhL2FzVEgxanhKU3ZEeVcweXlJK3BNWE0w?=
 =?utf-8?B?VjhCbzU1NVhjTktxOFAxWURQaWQvNGkybTA1ODJiekIwdTc0TTNDNS9nWE5p?=
 =?utf-8?B?dE5BM3dvaWR2azA2OFc3R2taY0wyUDNPS2dNd0w1RWNjMENtVUtjNWVZZHBa?=
 =?utf-8?B?L3hTQmlNTHhYQTVpTWl0Tlp2SVlJa0p1VjhHWmQrMkpsTmJMK0phbzN4Ukkv?=
 =?utf-8?B?RWpFWGluSHZpcTZZOXRvMk9TTXY1VlR6djM5WlRjRjgvWXJnRFdkdFgxTGc1?=
 =?utf-8?B?RTZMTkhjRHN5azg3Um13R3paWGtmN1I5WmEzUW1CM253NHQwMngvR0F4R0E4?=
 =?utf-8?B?ZTk0a3JseTJnaGRRL0FRSGkyT2trbm9lMlBhTlFHWDV4SlRwNmFGcnF1WVlu?=
 =?utf-8?B?ZzJYdnlabmFpcHBqc0FJQVJnY281V3Zrb0hvOGN0NEZiUWcwQ1NIMGR5cUxQ?=
 =?utf-8?B?YTJLR1VlV0w3Sm5QOXFsb2NodG5PTFZ1QXdyNVBtOE5CWUtQYkRVeEFJQ1FF?=
 =?utf-8?B?VWlNMStaZEVUQmdqR1I0NnV1UERuZUJFSkJEZkVwQlNvYVBId1lLZ2JIcUxi?=
 =?utf-8?B?MmdRcEJ3QmlPN3lWaDFTd2NCSVVsa3dTbEVETGlyT085M2ttSUdJVmxRcG84?=
 =?utf-8?B?MjRxRXJieG8xVVEzWGZQSVRiWHE5cDVLSjRSODBteVF5L016TGtublhWYTBk?=
 =?utf-8?B?YzJZWXRSay9DMkU2VzFidEcwaFJ3QTJ1ejVwcTBUNTEveWJIb1dWaUdYWnFs?=
 =?utf-8?B?VUtvUnB4Ym03QXNzRjRFSFlRL21Uc0ZYbnBwdVdFaWJKWlRVZHNVNHZoS0I0?=
 =?utf-8?B?a3NVTjZFYkJFbXVhenhYR1VkR3JFRHFMSTZQcVBnV1lHRjRaOGU2WXV3dlRS?=
 =?utf-8?B?UE9mNzU4L2FDaE1Ra1lJNmRsQXlqYnNwUGI3SXlKMjFBWlZaVWlBYytMSzgr?=
 =?utf-8?B?MENhMXRYREtBZkpuUllEOHdDT1VRSEN1ZGNzMzNPTk4rZjc0aStEUmh0ZWFs?=
 =?utf-8?B?WkxlSXgrTkNqMnp5c21qTzZqWkJhbUJrcC85NFp1YTd6WVd6VGhmd2EvYWVI?=
 =?utf-8?B?QmVZc2J0RkVwRmQwcFJjK0xsSEpaMVdRaHREUkR0VG1vU25hVjFSUytXellQ?=
 =?utf-8?B?TDRqUm5JRStENkp4SGp1eXVYSE8rM0ZlbVhkUjQrK1pwaGQ4NU5kWlV4VUZH?=
 =?utf-8?B?eWt6aEljRE83NStNMnpqN1BqU01xbUpPK1NSZ0NDdkcwQmZpcitLeUk4Zlkx?=
 =?utf-8?B?ZHRHc2huaWt6MlNNaEE5SnM2dkxISEkzVUFxWnQyckNubkpNeHkySndWblMv?=
 =?utf-8?B?Qy9VaURrQmJ1RW1CVUwrS2N3Q1F0UlNsUFVhd1EvNS8yN3Uyd0o3anl4b0RV?=
 =?utf-8?B?QkJLMitLR2dXK2szeUtjczh5bkUzRHE3VGFTRWY1dVZYNmdqTGNYMEVHY2lz?=
 =?utf-8?B?OCtQRmk2ZzFYalg5RUtSaTd0dEp2L3k1THMyNEladTBZRVd4ZiszUzFVZzY3?=
 =?utf-8?B?d01NNEEyME5BcmJFK3FNSkl1NGJpemgzenpITlBwbnV2TnMweVVidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	M3iBqqjrt5DX31ADxAX1CTTH1ux3ulEPoL4kAOwxTeP8efiTpC93lCtfh13Htwqy30D4O2C/Tge5T899Mpw/m904cuamuQyTJRM6JFaZZhwWsyLFwrne5rxwtQ9bPMjYsDT0Lx7vgd3B3FM1MMVF6psILfMSdlIHmoJtL3ZlsnGxDmZ4dy7LvvWiduXXxnmhgJ5/nDUewiwtTvncN0uDMAS+R4cDHlcnu4jbOelOkYVCZVeN6bnqyBMyvetpucxpo8zqSmHFRbmfw7XjBogY1HClPcIbZYZEtktK6R0RendssqxY9ye6/Fp7AH9sgGWagNjgPjsc3v3IUXIKOpB1qQ==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054dff2b-95ab-494c-13b0-08dea50cbcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 09:58:45.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wSBaeEFg5yRQmXC3lyzMitFf0lRbk9QmFs1XO+g1U3OftwCh/hR6QEVNWyASYoPq/OyQmbNnmQ4iyeTKDUAs3/w1jxHJ5Sct2FUdvkxdAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR07MB11891
X-Proofpoint-ORIG-GUID: REN38mZYH4685w4QXirn4D9iYHlm99gO
X-Authority-Analysis: v=2.4 cv=Kr59H2WN c=1 sm=1 tr=0 ts=69f084d7 cx=c_pps
 a=x36oJTDjInEio3y4qvlK/w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=eiHxKcPtOXV7QR4ysIcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: REN38mZYH4685w4QXirn4D9iYHlm99gO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4OCBTYWx0ZWRfX6vYAO+Y/kd0N
 m/VVcEvgYQlAullfSyft9JDKZjU+OzeOXqcVz7JnvY3vBtpP/DnNO6KQJgf4HsAu4nDZdSq4+j+
 O/nCG9IDKFg+3bKwgHtewVQiJEZFCQw3MCKUSA7domtk7uU1ArysRVlSjNLGclFWj1449e/qRnU
 qLlK1kmqa2TWf+rXymj8Bbi97c793ymoUNGnoZqW2ZbjkVvb7r9Ha4cSqFmivD+RrASrhgcP9NQ
 v0enX8rM4AUZ9mXhWRTQX8/wjQu5yuQk62sYiYBo9ZmhVgzN/Lu0uqx8wR44TchdwxwvAHGPqVj
 +Xtp3rCiUxGQTC958tUn5nADs8Z2y3Q5QHuRNvpf0Ebg2FK6PdxZzBCIcRRfSQdnOooKtQLD9pR
 9mqkaRN3UqG6YYv6Glfqv1BK1OZU5MVmywqahC4nxyn4zrUzS17NPFDxmrp/XcLZZtHeoHVS4rG
 hpKW9tV8HHeL5odw+cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280088
X-Rspamd-Queue-Id: 12E3148238B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cadence.com,reject];
	R_DKIM_ALLOW(-0.20)[cadence.com:s=proofpoint,cadence.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,PH7PR07MB9538.namprd07.prod.outlook.com:mid,cadence.com:dkim];
	DKIM_TRACE(0.00)[cadence.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawell@cadence.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

DQo+DQo+T24gMjYtMDQtMjcgMDk6MDE6NDcsIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPiA+Pg0K
PiA+Pg0KPiA+PiBPbiAyNi0wNC0yNCAwMDowNjowMSwgWW9uZ2NoYW8gV3Ugd3JvdGU6DQo+ID4+
PiBBY2NvcmRpbmcgdG8gdGhlIGNkbnMzIGRhdGFzaGVldCwgdGhlIEVQUlNUIChFbmRwb2ludCBS
ZXNldCkgY29tbWFuZA0KPj4+PiBjYXVzZXMgdGhlIERNQSBlbmdpbmUgdG8gcmVwb3NpdGlvbiBp
dHMgaW50ZXJuYWwgcG9pbnRlciB0byB0aGUgbmV4dCAgPj4+DQo+VHJhbnNmZXIgRGVzY3JpcHRv
ciAoVEQpIGlmIGl0IHdhcyBhbHJlYWR5IHByb2Nlc3Npbmcgb25lLg0KPiA+Pj4NCj4gPj4+IFRo
aXMgaXNzdWUgaXMgY29uc2lzdGVudGx5IG9ic2VydmVkIGR1cmluZyB0aGUgQURCIGlkZW50aWZp
Y2F0aW9uICA+Pj4NCj5wcm9jZXNzIG9uIG1hY09TIGhvc3RzLCB3aGVyZSB0aGUgaG9zdCBpc3N1
ZXMgYSBDbGVhcl9IYWx0LiBBbHRob3VnaCAgPj4+DQo+Y29tbWl0IDRiZjJkZDY1MTM1YSAoInVz
YjogY2RuczM6IGdhZGdldDogdG9nZ2xlIGN5Y2xlIGJpdCBiZWZvcmUgID4+PiByZXNldA0KPj4+
PiBlbmRwb2ludCIpIGF0dGVtcHRlZCB0byBhdm9pZCBETUEgYWR2YW5jZSBieSB0b2dnbGluZyB0
aGUgY3ljbGUgYml0LA0KPj4+PiB0cmFjZSBsb2dzIHNob3cgdGhhdCBvbiBjZXJ0YWluIGhvc3Rz
IGxpa2UgbWFjT1MsIHRoZSBETUEgcG9pbnRlciAgPj4+DQo+KEVQX1RSQUREUikgc3RpbGwgc2hp
ZnRzIGFmdGVyIEVQUlNUOg0KPiA+Pj4NCj4gPj4+ICAgY2RuczNfY3RybF9yZXE6IENsZWFyIEVu
ZHBvaW50IEZlYXR1cmUoSGFsdCBlcDFvdXQpDQo+ID4+PiAgIGNkbnMzX2Rvb3JiZWxsX2VweDog
ZXAxb3V0LCBlcF90cmJhZGRyIGY5YzA0MDMwICA8LSBTaG91bGQgYmUNCj5mOWMwNDAwMA0KPiA+
Pj4gICBjZG5zM19nYWRnZXRfZ2l2ZWJhY2s6IGVwMW91dDogcmVxOiAuLi4gbGVuZ3RoOiAxNjM4
NC8xNjM4NA0KPiA+Pj4NCj4gPj4+IEFzIHNob3duIGFib3ZlLCB0aGUgRE1BIHBvaW50ZXIganVt
cGVkIHRvIGluZGV4IDMgKG9mZnNldCAweDMwKSwgID4+Pg0KPmNhdXNpbmcgdGhlIGNvbnRyb2xs
ZXIgdG8gc2tpcCB0aGUgaW5pdGlhbCBUUkJzIG9mIHRoZSByZXF1ZXN0LiBUaGlzICA+Pj4gbGVh
ZHMgdG8NCj5kYXRhIG1pc2FsaWdubWVudCBhbmQgQURCIHByb3RvY29sIGhhbmdzIG9uIG1hY09T
Lg0KPiA+Pg0KPiA+PiBQYXdlbCwgSXMgaXQgYSBoYXJkd2FyZSBpc3N1ZT8gVGhlIGN5Y2xlIGJp
dCBoYXMgYWxyZWFkeSBiZWVuIHRvZ2dsZWQgYmVmb3JlDQo+dGhlICA+PiBlbmRwb2ludCBoYXMg
YmVlbiByZXNldCwgd2h5IHRoZSBETUEgcG9pbnRlciBzdGlsbCBhZHZhbmNlcz8NCj4gPg0KPiA+
IFlvbmdjaGFvLCBjb3VsZCB5b3UgY29uZmlybSBpZiB0aGUgVEQgY29uc2lzdHMgb2YgdGhyZWUg
VFJCcz8NCj5JbiBvdXIgY2FzZSwgZWFjaCBURCBjb25zaXN0cyBvZiA0IFRSQnMuDQo+VGhlIERN
QSBwb2ludGVyIGFwcGVhcnMgdG8gYWR2YW5jZSB3aXRoaW4gdGhlIHNhbWUgVEQgYWZ0ZXIgRVBS
U1QuDQo+DQo+RWFjaCAxNktCIHJlcXVlc3QgaXMgc3BsaXQgaW50byA0IFRSQnMgKDRLQiBlYWNo
KToNCj4tIFRSQjAgLSBUUkIyOiBDSEFJTg0KPi0gVFJCMzogSU9DIChsYXN0IFRSQiBvZiB0aGUg
VEQpDQo+DQo+QWZ0ZXIgZW5xdWV1ZSwgdGhlIGluaXRpYWwgRVBfVFJBRERSIHBvaW50cyB0byB0
aGUgZmlyc3QgVFJCOg0KPiAgIEVQX1RSQUREUiA9IDB4ZjljMDQwMDAgKFRSQjApDQo+DQo+QWZ0
ZXIgQ2xlYXJfSGFsdCAoRVBSU1QpLCBpdCBiZWNvbWVzOg0KPiAgIEVQX1RSQUREUiA9IDB4Zjlj
MDQwMzAgKFRSQjMpDQo+DQo+U2luY2UgZWFjaCBUUkIgaXMgMTIgYnl0ZXMsIHRoZSBvZmZzZXQg
MHgzMCBjb3JyZXNwb25kcyB0byA0IFRSQnMuDQo+VGhpcyBpbmRpY2F0ZXMgdGhhdCBhZnRlciBF
UFJTVCwgdGhlIERNQSBwb2ludGVyIHNraXBwZWQgdGhlIGVudGlyZSBjdXJyZW50DQo+UmVxdWVz
dCBhbmQganVtcGVkIGRpcmVjdGx5IHRvIHRoZSBzdGFydCBvZiB0aGUgbmV4dCBSZXF1ZXN0IGF0
IDB4ZjljMDQwMzANCj4NCj5CZWxvdyBpcyB0aGUgcmVsZXZhbnQgdHJhY2UgKHRyaW1tZWQpOg0K
Pg0KPi8vIGVucXVldWUgcmVxdWVzdCAoMTZLQiAtPiA0IFRSQnMpDQo+Y2RuczNfcHJlcGFyZV90
cmI6IGRtYSBidWY6IDB4ZjdhYmMwMDAsIHNpemU6IDQwOTYsIGN0cmw6IDB4MDAyMDA0MTUNCj5j
ZG5zM19wcmVwYXJlX3RyYjogZG1hIGJ1ZjogMHhmN2FiZDAwMCwgc2l6ZTogNDA5NiwgY3RybDog
MHgwMDAwMDQxNQ0KPmNkbnMzX3ByZXBhcmVfdHJiOiBkbWEgYnVmOiAweGY3YWJlMDAwLCBzaXpl
OiA0MDk2LCBjdHJsOiAweDAwMDAwNDE1DQo+Y2RuczNfcHJlcGFyZV90cmI6IGRtYSBidWY6IDB4
ZjdhYmYwMDAsIHNpemU6IDQwOTYsIGN0cmw6IDB4MDAwMDA0MjUNCj4NCj5jZG5zM19kb29yYmVs
bF9lcHg6IGVwMW91dCwgZXBfdHJiYWRkciBmOWMwNDAwMA0KPg0KPi8vIENsZWFyX0hhbHQNCj5j
ZG5zM19jdHJsX3JlcTogQ2xlYXIgRW5kcG9pbnQgRmVhdHVyZShIYWx0IGVwMW91dCkNCj5jZG5z
M19kb29yYmVsbF9lcHg6IGVwMW91dCwgZXBfdHJiYWRkciBmOWMwNDAzMA0KPg0KPlRoaXMgYmVo
YXZpb3IgaXMgY29uc2lzdGVudGx5IG9ic2VydmVkIG9uIG1hY09TIGhvc3RzIGR1cmluZyBBREIN
Cj5lbnVtZXJhdGlvbi4NCj4NCj5TbyBldmVuIHRob3VnaCB0aGUgY3ljbGUgYml0IGlzIHRvZ2ds
ZWQgb24gdGhlIGZpcnN0IFRSQiwgdGhlIGNvbnRyb2xsZXIgc3RpbGwNCj5hcHBlYXJzIHRvIGFk
dmFuY2UgdGhlIERNQSBwb2ludGVyIHdpdGhpbiB0aGUgc2FtZSBURCBhZnRlciBFUFJTVC4NCj4N
Cj5QbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBkZXRhaWxlZCBsb2dzIG9yIGEg
ZnVsbCBUUkIgcmluZyBkdW1wLiBJJ2QNCj5hbHNvIGFwcHJlY2lhdGUgYW55IGluc2lnaHQgaW50
byBob3cgdGhlIGNvbnRyb2xsZXIgZGV0ZXJtaW5lcyB0aGUgbmV4dA0KPnBvc2l0aW9uIGFmdGVy
IEVQUlNUIGluIHRoaXMgY2FzZS4NCj4NCg0KQ2FuIHlvdSBjb25maXJtIHdoZXRoZXIgdGhlIGhv
c3QgaGFkIGFscmVhZHkgc2VudCBzb21lIGRhdGEgZm9yIHRoaXMgVEQgDQpwcmlvciB0byB0aGUg
ZW5kcG9pbnQgcmVzZXQgb3BlcmF0aW9uPw0KDQpQYXdlbA0KDQo+QmVzdCByZWdhcmRzLA0KPllv
bmdjaGFvDQo=

