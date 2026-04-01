Return-Path: <stable+bounces-232801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNcOIvg7zWn5awYAu9opvQ
	(envelope-from <stable+bounces-232801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37037D447
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FC63254F48
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16035F5EC;
	Wed,  1 Apr 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+dGbbBU"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3A2D0606;
	Wed,  1 Apr 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055801; cv=fail; b=CjAgVj6cZXjv573aYn0a0zBu+XVNtfmpon2ywC91hSQCGerTPyH5ViZHmxVIJlWLtf8SrmdasCCacldQ+M5xM1hTIaohwJY7ht1an2M9MUR8DITPPYoCBohMIy06QXVkwEbRbOEnGNA0uUk0MjP8ET4MP6oegx7G5I7e/3LZHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055801; c=relaxed/simple;
	bh=me7z5ebwp0Hv7LswhaLp9nzUzr6cinH+1u7k8YpQkIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfTl5UJqoyzxusomoK4pkrsI6otqC2bg0wyKkJIDdDarOjYCo90n/2/euX4nWqApJsUYzB+0J7FXBPprWSZ90vbcGIUnosWJKFlGdL2DnsIaNfd3vg2z+OaA05gWJ8ShRlV5E0HJmqte6TUvpX9mesbhbYSBbj9lMYaFK+AdJeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+dGbbBU; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6RQ9xPHUFuMYuu/fCpsyxJacRRmBGHa9ycLjNB4Tne+pDutn5WsKd299vVMPpEIV6Ej7U+SnWsgoWc7Wi6MIgOe2qu3c5l8ZZuUvHvdnz00TO5wfQzjFtyayvzc4Prj/y/4VVxrJzlvcCAw19Fxm8nA7oDy2RnxYmJ/mvGMy+XVsOrsIeFDsfDxXtO4j3/rKFV9wuGBVCuePavh+km6yKYY8rE+2qHPj0TKVB5mSDcrRyP8A4QK1a/rd/+2owCtXQmPksfaJi+z+UNEyJXoZhXMz2MLj8Z29ajdNMrtrnrXh5D6PKDrqgPRj6Sbqzs53idxH9tJg1a8b13z/izgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me7z5ebwp0Hv7LswhaLp9nzUzr6cinH+1u7k8YpQkIM=;
 b=GE4Z0uX5jyCFF9UzrB2ZXEwAFPXHA617ZghNAP5vjh4q80krYrGosxiwbYxwFOYhWRy2ruEih/p4UBCeSHXh5YyuqpXk84DoYWUaVceE1+nvnmmA8RXfO7tuW08XwrCWLx82O+yJun6V1LZj6UbtL2JuB2BmOy6qZCSvEHo+uglRdmFBbJddsqQFtsV7A0ZsMzdtjvNN7j+yQgRBK/xXfObIrEcYVP5ycNZN7qDwCp67+n83mzihLEKUAHaKenZ9pChsjMcEWrMTdcK3zHfQ5AmbdQP9hng/cyvYu5lVc1aL4xlHKxRJRWH230ylbqnJjIT3eJ9pZ9ZlCMav/No/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me7z5ebwp0Hv7LswhaLp9nzUzr6cinH+1u7k8YpQkIM=;
 b=r+dGbbBU2TVXul7gD2iBMJ372sSduOM2DtUBbweUlwNCF541wIpqoZu+zacWtFqKt7IZFYILKOg21fgICVzpcx/aZYCLcoPRi8be6OcT5IpB/VIV8OCjYXcdV9EeOIV5o2ynAZcpd47pUO+j+4qFqrd9aA9Y/WxwF9O7YD7C4eg=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Wed, 1 Apr
 2026 15:03:12 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 15:03:11 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, Christofer Jonason <christofer.jonason@guidelinegeo.com>,
	"O'Griofa, Conall" <conall.ogriofa@amd.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
	<andy@kernel.org>, "victor.jonsson@guidelinegeo.com"
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index:
 AQHcq7dnEu4MVLVXG06oIZXnf3P2bbWjB/QAgARjkoCAIuly8IAABfbwgAALDKCAAAkRAIAAB5nA
Date: Wed, 1 Apr 2026 15:03:11 +0000
Message-ID:
 <IA1PR12MB7736E0E653BFE5D33DC1E2799F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <CAHp75Vcg1u86z_TWwz+1Gk9QQ9RB63QmNcqpkGa5HQHZhSE=5Q@mail.gmail.com>
In-Reply-To:
 <CAHp75Vcg1u86z_TWwz+1Gk9QQ9RB63QmNcqpkGa5HQHZhSE=5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|CY8PR12MB7099:EE_
x-ms-office365-filtering-correlation-id: 86f70200-ec30-4c26-f75d-08de8fffcb0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 8c/smZyuWrkTGrv9zKxqGthQTDUE0gYoSnjfFOqmHECLle+ioWBw59T7biZTAu4cXS0nTurzn5EDGpnpdLKQYpOqQQve0Hfj0OEkudT12XdBnzsPDS4KhdO9YEWHimsIdnBQMDgu6ZdhpUJq2QgrVZcnQXb609DY8Helog7n54quk34WiPPqisg8MLhzzQjlSEeo0xpyg9INwhhNWDPZ8e7T6xumk7V1WNPqlkv0qF1Yuy6FddbBmdB5+8ZIBobs/3oBmDpdm9H2UvUR2m3/lG/UWSewkQnuPuEMx3IwehmzU+0wPrdHInW+GuqZCbMApLYJ1f00tnObq9m44DbcY8/g3jly1bqzAvdmXG24IQ6H4N5jyWZWC38SvLmUX5HzFOsF0beDBorym3mUqOHPwtOHs8i6gVDuIJuZIXTGtm0HKUx1Y37J8ho45qz/AvmtWzqBg+O/KhFzRBKi4Go/mYfzkViYkS7boLxjSp1qF424FGQnBqL6mhU/ae5ou99BnNO0e/iRyVJrLGqPwXKnB9nHa0NqyM7GXbg/7fcEKMWSWkqpYGnB+ZLaJzCmelIpCuF3k4IN2bTaeXje4VXEUij9zF4ygBlzqW86PnMDDO/M5ACjxyqw/9MmuBNpsRH1gCvfQFdz04Uw72kPhBcyknKh0DY95Um4X6cQBiP4xdw5e1+hkw/J8ICJLR8zTtLeH4QRCv3VQql/RF8WIdVvKYNc03SaVDPctJrXTix2HuM63T7taZPBjgKDHZ6I+7GD5OdwojNLkjqYXB04M+hTa1bbqrsD5YbvdkZQ01MJZL4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZC9pblp1Z25SNldkdy9rNC9MUHVlU2ZkbkJhQnpyRXFJK0FUUVFaRk5HeU9Y?=
 =?utf-8?B?Qjl2Y21LNXNMeFk1ZDNHK1BpaWd5NUVZSkhjWDhKNVZma2tibHU2dUJlMUhi?=
 =?utf-8?B?Z0pmTk1mQ3FVSlc4c3NRZyt2TzdlNWFJL3BPYjAyZ1FHSkZhSWlHdnBzTmZi?=
 =?utf-8?B?NytXVVdxTzVuY0pCczJ5YlJsN0wxYW1wYjZCS21WRklST3hOcXk4Z3BwTUw0?=
 =?utf-8?B?UjBSdWdFY2ZxckFlSVNiZ0Nxb05iWDZzd2ZHbmtSa1lxMjFwczlEUFh6Y3pi?=
 =?utf-8?B?NC9WR3V5cVlmVUpRZTlhMldkWHEzZW9WUDI5UHFicWJ1ZVVLSEJRUkx4REJM?=
 =?utf-8?B?QkhhaWFUZVNlNzIvQXJVUERGRFg2ei80eEpQOUdDcGJmQ0tkZEFPZGxtb0I3?=
 =?utf-8?B?N3lpR0Y5V2Vic1VDdnFPQlZobGpNc0c1Zkk0Sk5VRXpCWVRlekdGSExLVDV6?=
 =?utf-8?B?TzBxTUVzWXdLQnEyZkdXUUJnQkNCa3VCTzN5QVN6a3B6L0dReTE1aFN0NlhX?=
 =?utf-8?B?aFBPVThub1dHa1pETm5GeFV4Q3h3d2RZZE5hMjRENENKN1VSZ1ErVUNtT0xC?=
 =?utf-8?B?T21ndndFcGk0VHpiZE1aZXpVSzltUUNFT21jeGNoaW1ZNzJsMWFQcW9vK3Ex?=
 =?utf-8?B?eTFMeUFrSWErR3RQL0Zkd3NGSlRLWVNOMytYaVpSSW45anJQUDFtWUhQNldI?=
 =?utf-8?B?dWlTQjlyV0hVODZvektkazlzV014ajZ1RzJ0Y2dmQ0pMYis1RzRhSS90MHEy?=
 =?utf-8?B?d05OdnhJUXQ4RkNDZW91QWJuNHV5TytlU3NaRHRkSCt3T3JwOVV6TzFmK1hj?=
 =?utf-8?B?bmxyZEpwVUl6cmMyRTFrQmRPN1A5Unl2Nk1ZTE9WNVhGc2R2M3FJcG82K01t?=
 =?utf-8?B?ZG9YNmhpSjJtWEJORS9lNGluRC9HRGUrRkRvR2pPNC92ZEZYUmoya0d0K1dx?=
 =?utf-8?B?d0dXbXpQOU55VUdOeUtTT2ZKTm1ZZ1hCQkIxZkM4MjhOTzI5TzNQT3pRZi9W?=
 =?utf-8?B?NEt5a2JmdE9qWkhYNkZ0ZXJDaDhGTzRnVmlielR3dHRoWkpqSjUvT3FGZGZl?=
 =?utf-8?B?RmxWZWJ3Z0dheGRraFpNUGRscFRWeDhXcnE4TnF3SGF2MHlSMjlickpNQUxC?=
 =?utf-8?B?b3FrdjRBZHZxNkE0c1BENjZhT2FxcElOWkxhbEJXTEc1Q2cyUjlCZXJqcCtK?=
 =?utf-8?B?ZzdFazlpMkp0YTVIUm9kRjRZZGJqVVRQcTNCY3lXdFRCcE5PUkYvdmlzRE11?=
 =?utf-8?B?eVBodWk5MllGcEN5Wjd1eTkrWnlsSTFsa1VHOHlPNFdQVk95TXFiVGtFcTZQ?=
 =?utf-8?B?QnU5aVd0NnlmVTVxVFp5N3BDMFpjdjVzakU0dnNlc0pRdC85cjlLM01uZE5v?=
 =?utf-8?B?cll2THRlUjUxVVhkSUl3OXRaTU03Zms4YU1MYW5jYlJJU3dxWng4dGpkeHpu?=
 =?utf-8?B?UjBKemloTlRVZ2pkUkhNY1BGRSthK21kQkpOQlVNV1cyTkozdFN3N2ZIcGhm?=
 =?utf-8?B?dmFnK2NTa0ZWVzFnL2hOWEpxY0pxcWExczY4QUxiTTNCc0Y3TzJySTVvQ0hw?=
 =?utf-8?B?b0RoTnJlblgxc25qNUhiTjRSeVUwaTFuOEdIVUNLYnpjVUVzbVREUHNlQ0pS?=
 =?utf-8?B?dDRtZzZ4UXhtK1VCc2EvNno5QW1vQ3dob2dJVVRyRWRaUHU1Si9KTS9lYy9j?=
 =?utf-8?B?b0daS0ZUTllaUFQ3UHV0cEpveVJSZ0JhaklZV0ptQ1UrbktYb2JpdUNLZ2hk?=
 =?utf-8?B?UXFRZGFsTzJlYm50aUpWYy82eDgxY2dLd1ZWMytkL0FPdUZSbHZWeUI0a09k?=
 =?utf-8?B?MVNXTm1ReFIzL1AxeDhuZmVkUHJLMkZGZHRoTmFtVXBRVnprakV3UHFhNTdt?=
 =?utf-8?B?cUo5ejJYSDB6RTAyR1V2eFFqT01SN3BtWmZYRVR1NnQ0bmRmZkdKS012NndM?=
 =?utf-8?B?eXU4SVR0b3VpcElvUGJCanNDYURBQ0pIaHI5QVFXaVA4ekVRVnIvSzFxL050?=
 =?utf-8?B?OXJWczNaa0ZpMmNkbGtKaEVzQTNHdkJvbWNhVzdLdmdCRXYyK2Vlb1hKc01i?=
 =?utf-8?B?OUN3Z0FBbG8xMDJJUkNjSXgzSFpPMjBpdmxFTUtTMnlzdGl1c1VvTjFubm8v?=
 =?utf-8?B?S3VZdS9mZUlSTzI2WC9xSGE3MmZjK2FySDZRYWhha2RQSjVndUU2TFJpOVVP?=
 =?utf-8?B?YU90RmRwZVlQekp1SisrRE5yNk02dXRDMWNkczJZU1RRajZQejBWNzZ6b0J0?=
 =?utf-8?B?YVFPeG5xc2ZCOFA3WXN5MXE4V2RYUnFHWkdjQjZ0Qmxqd21ON3NYVEFzdmVG?=
 =?utf-8?Q?b1BMW6hxr9MyFr/U9l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f70200-ec30-4c26-f75d-08de8fffcb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:03:11.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YccuynGX3zi7VCSmL/QRmaOA9lH53/RvEhiHSRT670rppAKlmOpfDoG1Xp/BFsTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-232801-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Salih.Erim@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,IA1PR12MB7736.namprd12.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE37037D447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQW5keSwgDQoNCi4uLiANCj4gT24gV2VkLCBBcHIgMSwgMjAyNiBhdCA0OjU44oCvUE0gRXJp
bSwgU2FsaWggPFNhbGloLkVyaW1AYW1kLmNvbT4gd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRXJpbSwgU2FsaWggPFNhbGloLkVyaW1AYW1kLmNv
bT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMSwgMjAyNiAyOjEzIFBNDQo+IA0KPiAN
Cj4gPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyDQo+ID4gPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50
cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4gPg0KPiA+ID4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+
IEkgYW0gZGVlcGx5IHNvcnJ5IGFib3V0IHRoZXNlIG1hcmtpbmdzLiBQbGVhc2UgdHJ5IHRvIGln
bm9yZSB0aGVtLCBhbmQgSSB3aWxsIGRvDQo+IG15IGJlc3QgdG8gZXNjYXBlIGZyb20gdGhlbS4N
Cj4gDQo+IE1heWJlLCBidXQgaWdub3JpbmcgdGhlbSBtaWdodCBiZSBzdWJqZWN0IHRvIGxhdyBl
bmZvcmNlbWVudCBvciBvdGhlciBsZWdhbCBhY3Rpb25zLg0KPiBZb3UgbXVzdCBnZXQgcmlkIG9m
IHRoZW0gZm9yIHlvdXIgT1NTIGNvbnRyaWJ1dGlvbnMuDQoNCllvdSBhcmUgcmlnaHQsIE15IG1p
c3Rha2UgaXMgcmVwbHlpbmcgT1NTIGVtYWlscyB3aXRoIE91dGxvb2ssIGl0IGRvZXMgbWFya2lu
ZyBhdXRvbWF0aWNhbGx5Lg0KSSBuZWVkIHRvIHN0YXJ0IHVzaW5nIGFub3RoZXIgZW1haWwgLSBt
dXR0LCB0aHVuZGVyYmlyZCBldGMuIFRoYW5rcyBmb3IgdGhlIHdhcm5pbmcuDQoNCj4gDQo+IC0t
DQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KVGhhbmtzLA0KU2Fs
aWguDQo=

