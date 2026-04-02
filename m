Return-Path: <stable+bounces-232895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FGRFGLgzWlVigYAu9opvQ
	(envelope-from <stable+bounces-232895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:20:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80663830DE
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CCB53051CBA
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155C35A399;
	Thu,  2 Apr 2026 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="yAfma78x"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5179346E6D;
	Thu,  2 Apr 2026 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099814; cv=fail; b=IvwMAAEJ46ofVz4yNpN+cEKTigywwaQ3L0oBYZH2oM+Zh34i4h1PoLRGuNf4TdorEaDpp1DgoZDpZRhg/Dc/pgNNbRuSUMUvp0Wj/cHiO+OHSTLewq/NCUwgkQYLuZyXvFb/7LhmIiSePdyAgc3L1zv8b27kaVZn2i+DLk1s7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099814; c=relaxed/simple;
	bh=Ao6uSYK4DlzWTwDtOI64C+E0ynrCkp/0315WEEiBc6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dawsqk+xONIFV4oYz6BtacGjXzfBS1OG0fDOeohDDQjH6/fOSgtvqo7h+NCMbb0NgejOGUF2p+SGfyjMbbOjJS+iaKAXSUOBCurAs/x9ghmzq2r58IcFNFWjBfWeZbHJhHEKbpyjepyX+by0iZUJdaFs9a8NsNsqx/jEBAvtvo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=yAfma78x; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1U2fBjHYFL+AW0YQ1WMRVqdoIAQhMZW9PIe2aMy6HOKjVu/0vuZWhGSBp7jg0xVAn6BKt4/Ss+2cK4VLIfShMeahoGirZMSzdYaNDeQAnoedu/DNODI5gd6To+K+bG57P2XXxPXzapPU0Mf9hfwfe0VZqOG5Ma32gLcF8oPKJP4YDEDS73AduKPuSVYfqGzBmklqUuzJigZrq2SVtI3jaM18FuCKJKj/2vJrsXrzyInPIv6gSD2nOA/i3hKfHJkxV5Jt229bAQtQEeSMnpJ9IHc6CTPHx8m8D4d7PfNrlu/5XGPO/Byip3s70s7umfI1P6vV/CQtGGMAOf0tTbBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao6uSYK4DlzWTwDtOI64C+E0ynrCkp/0315WEEiBc6o=;
 b=q5BZmkOkHxVXc9ziK9ZTbenYXI/PblhJK/54+cFyN0sZyb8royLqLDpEiQpSMoUIwsP3YStrmJrk83gnuYVY5Y3Nj+cThBqsj3Pq24Zdpzbt2ztU3DjqE4YjAMhaYWwN2yfVYzw+vp1NUY7iXEIab1ZIWH88wAlMIj1STXD6YhQlOV0baVbX8W+BT0br1o7oeq8eYeBGfXYQPOl+mLb29vAQBPRs3juok/f1z1NrT6huN0hZ9oC4NKr7DEnbU66DddTeZtnH2e082NHNvejYxxSeH2bcQ9WLRLKvNjVpOg7xDskrrmKLy3nCZMXMYKT/0YkmHVdLPcU2IsUhsEEclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao6uSYK4DlzWTwDtOI64C+E0ynrCkp/0315WEEiBc6o=;
 b=yAfma78xjZyRErGx7MxjEHu1MyphUiqsYvvve7KX+gmjjbKcMFS5unm9qACDR2Z0ScaTAhFKXCRojR9rKrNRKxujEvbD7EbFEJQIzSfOaaT9x70YI78Plg6pVmfC3VjJapD4tKGWzBRsabjwWb+duo5xvV3WHoEge7VlaSsJytKJliHIcFqui5aMkRLewSryt08YGhgYxYvOdZenIPy7DXotuWqWUNfMNWNpT6cAkWU/dm8qn0nqo9+/Mm6NqtwypOFt8kqdCNQGMAoenO8pZ+KyDHZypOPGe4A1k1gutGiopVSgOdqtsVsr+8kIO+U3ErsHoL9bPojbieoacZsKHw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB1031.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:161::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 03:16:46 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:16:46 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Oleh Konko <security@1seal.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Topic: [PATCH net v2] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwcHCiiIqwNnoGkeCzkPBRQ3jNrXLGXfw
Date: Thu, 2 Apr 2026 03:16:46 +0000
Message-ID:
 <GV1P189MB198867B67DB1B2EEC5275B5DC651A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <d72c0ff783db4c78ad862e6e27f3a807.security@1seal.org>
In-Reply-To: <d72c0ff783db4c78ad862e6e27f3a807.security@1seal.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB8P189MB1031:EE_
x-ms-office365-filtering-correlation-id: a47ca717-c6a5-4897-e5a2-08de906645c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 dznP/gOp5SqXxqUAw9l4zktQ5qpwBsR1iwu3wCfT0JqEw3sv6J6Jo/soA3nT1zqJlHAxqjiySJ6raXnezNPhsdwWhpgP6MVqDcbXhEcvhEFrHTH7eeiAd5vxlkOljYI60eHVopli+oqXaDc+ZsHQOVvfu64lmFnkF2UPbchJ1oH7tF6RBkaBefcB/lj6UkGyhuK1AlTcPiLFButBHhHvOYrIhTlbt+uF2KIpsyBJgEQQFxU/V+fql/lm/s1oyDxQjWlvSuV03MYoqiZM01ZeEKlYt0iHAK+ccDQEDpilzEhZDuISVen+tnAvD68iSnK0/vXZbqIjV6LT7F1k3lXKK8JvGEI49Ur7jlUBKXApVvLMaL+Stt0j280bfJ6SXxY5x5SykyB9g/idjH7RCg0z5FVBeyc6XcOyG4W0ozmm2OXPPwRX0caXteTibL3h5n9mT6SIA2zHehHTHhz9tuhEN07jWoKpe2eWAP66q6c57R+ULWK+gn7JQmtcSmxPI06Lth0PB56RdjeHYwAWqGD3SlDbmx2KAEw8reRSEw0v8ium/JucqjXOaEDAuKKmZkJNrgGI5vDNG4SPlaFx1rmICyokhL0h73toPXmEQJS/MFJJcKTHDk84t6k4O+sldZJoFW+rsKOQHB4Hq0s9NVoE0nOZZKZarWNHh2wj5rG5j0nAJVh3UPGWceOm69oF8cfK1PhHs3d60RT1iv7847gmGZboHigrJSXcmk/3i+Z8cWQQ3GIHifE56xTDSZJsMziZsDg1iHI0taCm5j5ZfKEbWw8LOB3qyc3/tCMvVnpWHdM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjQ2b0hxWnByM2xIL09lcjNOMVplZldVTkh1ZHdoUVNFMjRxdWdXUXNxVU1W?=
 =?utf-8?B?V01GWG1sb2EvZFlmeStlYnNLQmhIZ0FCOWZENVVSYWRIQzBOVVc2WDBMeTJk?=
 =?utf-8?B?STB0VVhjc09QQ2xNdnlmdERnRDJoMndJbG9DRFJ6K0phZWVWNHFxZ3hHVW5L?=
 =?utf-8?B?VzA2UkI3OU03L1dUbWVPc2JSUXYzQ1Rkb1F0dmFBV1p3dnhMZTRaNWpsQ2ZD?=
 =?utf-8?B?YlZ5WDUvV0pDL0RvUHhpVkk3RjdVWllWelRDdlQrNnhyejdoY0V5R0dsNTQy?=
 =?utf-8?B?V0NLbWFodXdnU1lwcWpsRjVnS05PVHNyUkcvYWZUQnNqTVRnWW54eDcyaUE3?=
 =?utf-8?B?WTJjbkRNUzhPUEZ5dWVIZkJrZSttckthYXNRQzJWMWpnU2hkaWcrYWVXcVhO?=
 =?utf-8?B?c1VhU2kwdkp4YlBZS2VQbzlRYVRUcUtlMmpMQ0NkZVZQeWV1VERLM1lwS01p?=
 =?utf-8?B?WS9tNzNnWXJOMWNjN0Q1cGpoSndLWUl3QnoralZZb1J5QzRBS0h0Q3BXNUt1?=
 =?utf-8?B?dHczZFM2TitRdXdGR2p5cTlPUG52VUFlYTdaYlNGT1B1TWNkR25sQWVQd3dJ?=
 =?utf-8?B?T2liOXNCN29JYllaQk9sRHNmTEtOcjEvWVRld0ljcG5SNy9RTVlpWFZnS2V2?=
 =?utf-8?B?TVpQQmF0UHl4TkRGVFFzT0ZscitCSy95c0IxZ3ZETlJBbTMrQ3BXSHp1dkxj?=
 =?utf-8?B?K0hpbk50enRJSmFnUk5yZXp4SEIrczNGeU1Dc3RlVG1EZTl2end1VmkyS1VX?=
 =?utf-8?B?Q0FoYTNwUmJjWEI3S09GaWhvZW1wcGMxaStxdjErTGtwZU9LMzJWdFVlNzEx?=
 =?utf-8?B?d3hWZ2NtbjhYbkoydGJjckdHdVR0WU9rbFBUVVhDV1IzN0FXNkNQazlnV0g1?=
 =?utf-8?B?ZmRuU0dpOUw1TDJrSmd2b1p0YUdwc04yKzllMkd4N0doNVVscWx0M3NSazRQ?=
 =?utf-8?B?Qng0cTd5OTlUQlhWWjM5NHlqWms3M090NGxFWGVoZ3hPTExTNGRYWEs3RGEz?=
 =?utf-8?B?enJHYU5jWDk2RXozS0g5czByWjk2MFUveWxyK3JSNEtXY1VBbjlMa01zRHBi?=
 =?utf-8?B?amRvK2gvU1kxWHFVUFNIQi9OLzAvZHdUbUppVUZ5bFp3WEFwM0ZRaTZkM2Z3?=
 =?utf-8?B?NityZ2xoVWVpczdzb1Z0cWx5bzRPUzZoeUN6OWZzd2N4ZXlFOXBsTHVRQlFy?=
 =?utf-8?B?aDdnbndHOUtVRlUvTHVsQ3VxWHk3bnVHR0V2NWpoVXBJdXNKR01ZcTFkNCtp?=
 =?utf-8?B?cTFZU1RHOEplL0kvT3Rtd2t3NTY4R09sdHJVdnpBbUZ5a3diQU5raXZ0eGNJ?=
 =?utf-8?B?NXZuS1k4OXY0aWlwekZnRlNqNDl1cVR0S2x5SHRhdGNhVlp0V1lCN25jUW42?=
 =?utf-8?B?RlpJSWJ4dHA5eWhoT3RVWUNPT3M5ZW0yTHM0R0tQNVd1WU1IWEYzWXFRQmsv?=
 =?utf-8?B?SDVRb2s3VGtXa1hvampGcjBwR1ZidGhpQURqOEdqNk13TFpGSjFLMkN5RmRq?=
 =?utf-8?B?NGFWYjArbzIxbW9tdHpYQ003VGREWEhzdERGR2Y5QkpRSElReWJBaWlYYWNn?=
 =?utf-8?B?K0lrTzFlUnRlWHlrYlNRV0plSDBicXo4bW1GbXZ1ejA1bW9OMmZReHJEVE9R?=
 =?utf-8?B?Z3FJRnp4Yk9oMFp3QmVndTY5dWs1Qng3QmNhWjdObEgwK2pxVVZITzc5WUYy?=
 =?utf-8?B?M0pZZDBLejFhWGlzWlI2dE0zTUlUSGdEbm5WSGdDYUxHTkJ6VXBCWDhDZU90?=
 =?utf-8?B?eTJvYVZNUVJEZlJLcXUxbzF4UG4yZkVTREtYT0NTcW5nbG5sbDF0Z0UwM1U2?=
 =?utf-8?B?cWVWZTg2cnFkQzk4T2syaEdlQzVqakhZWkRlbFRlVVdmRVdYQ0xYWWVpSitt?=
 =?utf-8?B?cEtyL3lFak13TlFHN3ZlY1Q4OVFqSjRmVUlvcGo2R3VzZ256M2FBenNQa3li?=
 =?utf-8?B?b0gwaFFURVJwS1dCQTYrd3FNQ2hSOFhqNXlmRW1kUDlSMjkyd1p4UHJmMnhB?=
 =?utf-8?B?Q0lxRkZETE8rYzlRaHlGTXhaT3ltRGJ0ZVVMNnlwa3JVWnNmcURHa200cklX?=
 =?utf-8?B?NnVob3Q4Q2E1UUdCMDhjMjUyU3A1TUFNQ0EzSHlMeE16ZngvMFpzQkkxc0ts?=
 =?utf-8?B?MXB2Z2ZiTERkWEhmaGlWd0cvRXgzQVdaaUJXN2pMVlJHVUduRnNGMlZQa1Mv?=
 =?utf-8?B?YUIxZ1dIZnBWRXVZd0VuQVJMUTFrK0FCcUp0Yzd5TkRFR2ZBbnIwZjN6Ym16?=
 =?utf-8?B?Sk12TE1FdnVuSGdWQmU3Q0VTb3hVV093NmkvWUpZcUdCVGQ0a0tjQW5iTmFn?=
 =?utf-8?B?ejBjdzdaYWZBa2U3amtiM0lka1liTUJUNENnRWN3ZTk1ZVJqLzZUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ca717-c6a5-4897-e5a2-08de906645c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 03:16:46.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7e4Tt77Qj5/ZJuNrVocbKSz8dN+0LPYZib2dWWzLWKCnS6ezptmz1AZMlnqJ/3NGRjB8zCpDBHFjoKJ6vePVR8Z14tWKWq7AdXw4BZq3DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1031
X-Spamd-Result: default: False [1.44 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232895-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A80663830DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIHRpcGM6IGZpeCBiY19hY2tlcnMgdW5kZXJmbG93IG9u
IGR1cGxpY2F0ZQ0KPkdSUF9BQ0tfTVNHDQo+DQo+VGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXIgaW4g
dGlwY19ncm91cF9wcm90b19yY3YoKSBjdXJyZW50bHkgZGVjcmVtZW50cw0KPmJjX2Fja2VycyBv
biBldmVyeSBpbmJvdW5kIGdyb3VwIEFDSywgZXZlbiB3aGVuIHRoZSBzYW1lIG1lbWJlciBoYXMN
Cj5hbHJlYWR5IGFja25vd2xlZGdlZCB0aGUgY3VycmVudCBicm9hZGNhc3Qgcm91bmQuDQo+DQo+
QmVjYXVzZSBiY19hY2tlcnMgaXMgYSB1MTYsIGEgZHVwbGljYXRlIEFDSyByZWNlaXZlZCBhZnRl
ciB0aGUgbGFzdCBsZWdpdGltYXRlDQo+QUNLIHdyYXBzIHRoZSBjb3VudGVyIHRvIDY1NTM1LiBP
bmNlIHdyYXBwZWQsDQo+dGlwY19ncm91cF9iY19jb25nKCkga2VlcHMgcmVwb3J0aW5nIGNvbmdl
c3Rpb24gYW5kIGxhdGVyIGdyb3VwIGJyb2FkY2FzdHMNCj5vbiB0aGUgYWZmZWN0ZWQgc29ja2V0
IHN0YXkgYmxvY2tlZCB1bnRpbCB0aGUgZ3JvdXAgaXMgcmVjcmVhdGVkLg0KPg0KPkZpeCB0aGlz
IGJ5IGlnbm9yaW5nIGR1cGxpY2F0ZSBvciBzdGFsZSBBQ0tzIGJlZm9yZSB0b3VjaGluZyBiY19h
Y2tlZCBvcg0KPmJjX2Fja2Vycy4gVGhpcyBtYWtlcyByZXBlYXRlZCBHUlBfQUNLX01TRyBoYW5k
bGluZyBpZGVtcG90ZW50IGFuZA0KPnByZXZlbnRzIHRoZSB1bmRlcmZsb3cgcGF0aC4NCj4NCj5G
aXhlczogNzVkYTIxNjNkYmI2ICgidGlwYzogaW50cm9kdWNlIGNvbW11bmljYXRpb24gZ3JvdXBz
IikNCkFJIGNvbXBsYWlucyB0aGF0IGFib3ZlIEZpeGVzIHRhZyBpcyBub3QgY29ycmVjdDoNCiIg
VGhlIEZpeGVzOiB0YWcgYXBwZWFycyB0byByZWZlcmVuY2UgdGhlIHdyb25nIGNvbW1pdC4gVGhl
IGJ1ZyB3YXMgYWN0dWFsbHkNCmludHJvZHVjZWQgYnkgY29tbWl0IDJmNDg3NzEyYjg5MyAoInRp
cGM6IGd1YXJhbnRlZSB0aGF0IGdyb3VwIGJyb2FkY2FzdA0KZG9lc24ndCBieXBhc3MgZ3JvdXAg
dW5pY2FzdCIpLg0KDQpDb21taXQgNzVkYTIxNjNkYmI2IGludHJvZHVjZWQgdGhlIGJhc2ljIGdy
b3VwIGNvbW11bmljYXRpb24gZmVhdHVyZSBidXQgZGlkDQpub3QgaW5jbHVkZSBiY19hY2tlcnMg
b3IgR1JQX0FDS19NU0cgaGFuZGxpbmcuIENvbW1pdCAyZjQ4NzcxMmI4OTMgYWRkZWQgdGhlDQpH
UlBfQUNLX01TRyBoYW5kbGVyIHdpdGggdGhlIGJ1Z2d5IHVuY29uZGl0aW9uYWwgZGVjcmVtZW50
Og0KDQogICAgaWYgKC0tZ3JwLT5iY19hY2tlcnMpDQoNClNob3VsZCB0aGUgRml4ZXM6IHRhZyBi
ZSB1cGRhdGVkIHRvOg0KDQogICAgRml4ZXM6IDJmNDg3NzEyYjg5MyAoInRpcGM6IGd1YXJhbnRl
ZSB0aGF0IGdyb3VwIGJyb2FkY2FzdCBkb2Vzbid0IGJ5cGFzcyBncm91cCB1bmljYXN0IikNCiIN
CkkgYWdyZWUgd2l0aCBBSSByZXZpZXcgcmVzdWx0LiBDb3VsZCB5b3UgcGxlYXNlIGNvcnJlY3Qg
dGhlIEZpeGVzIHRhZyA/DQoNCj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPlNpZ25lZC1v
ZmYtYnk6IE9sZWggS29ua28gPHNlY3VyaXR5QDFzZWFsLm9yZz4NCj4tLS0NCj52MjoNCj4tIG1h
a2UgZHVwbGljYXRlIG9yIHN0YWxlIEdSUF9BQ0tfTVNHIGEgZnVsbCBuby1vcCB2aWEgZWFybHkg
cmV0dXJuDQo+LSBwbGFjZSBhY2tlZCBpbiByZXZlcnNlIHhtYXMgdHJlZSBzdHlsZQ0KPg0KPiBu
ZXQvdGlwYy9ncm91cC5jIHwgNiArKysrKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1naXQgYS9uZXQvdGlwYy9ncm91cC5jIGIv
bmV0L3RpcGMvZ3JvdXAuYyBpbmRleA0KPmUwZTYyMjdiNDMzLi4xNGU2NzMyNjI0ZSAxMDA2NDQN
Cj4tLS0gYS9uZXQvdGlwYy9ncm91cC5jDQo+KysrIGIvbmV0L3RpcGMvZ3JvdXAuYw0KPkBAIC03
NDYsNiArNzQ2LDcgQEAgdm9pZCB0aXBjX2dyb3VwX3Byb3RvX3JjdihzdHJ1Y3QgdGlwY19ncm91
cCAqZ3JwLCBib29sDQo+KnVzcl93YWtldXAsDQo+IAl1MzIgcG9ydCA9IG1zZ19vcmlncG9ydCho
ZHIpOw0KPiAJc3RydWN0IHRpcGNfbWVtYmVyICptLCAqcG07DQo+IAl1MTYgcmVtaXR0ZWQsIGlu
X2ZsaWdodDsNCj4rCXUxNiBhY2tlZDsNCj4NCj4gCWlmICghZ3JwKQ0KPiAJCXJldHVybjsNCj5A
QCAtNzk4LDcgKzc5OSwxMCBAQCB2b2lkIHRpcGNfZ3JvdXBfcHJvdG9fcmN2KHN0cnVjdCB0aXBj
X2dyb3VwICpncnAsDQo+Ym9vbCAqdXNyX3dha2V1cCwNCj4gCWNhc2UgR1JQX0FDS19NU0c6DQo+
IAkJaWYgKCFtKQ0KPiAJCQlyZXR1cm47DQo+LQkJbS0+YmNfYWNrZWQgPSBtc2dfZ3JwX2JjX2Fj
a2VkKGhkcik7DQo+KwkJYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2VkKGhkcik7DQo+KwkJaWYgKGxl
c3NfZXEoYWNrZWQsIG0tPmJjX2Fja2VkKSkNCj4rCQkJcmV0dXJuOw0KPisJCW0tPmJjX2Fja2Vk
ID0gYWNrZWQ7DQo+IAkJaWYgKC0tZ3JwLT5iY19hY2tlcnMpDQo+IAkJCXJldHVybjsNCj4gCQls
aXN0X2RlbF9pbml0KCZtLT5zbWFsbF93aW4pOw0KPi0tDQo+Mi41MC4wDQoNCg==

