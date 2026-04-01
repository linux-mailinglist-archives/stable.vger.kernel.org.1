Return-Path: <stable+bounces-232699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHeZAmS6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A237375269
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF106301C3E2
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D584B32C924;
	Wed,  1 Apr 2026 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="nN70aiWB"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB493290D0;
	Wed,  1 Apr 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024591; cv=fail; b=U2haLaTLFarQnFmxoDhWTb3BDlJzhNpx6QWtH1JMsIW0G5ZQ5AKzNrIkYDQwel9mU0ISq2G8Ot6aSs/HHk8SxrdPsN+MTJBVcxXg1vwnNv01xqAB0fxBmvXreUB8llYnV7SdCUNSoftEj8vImLXaAaQc7rSBlJhU9mG45SRwkww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024591; c=relaxed/simple;
	bh=g0c3gj57jLjz9i4YRp9HL0ATukswTG/0JxUS6RvvL9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyBF8Sb6+rBORLMknWHwpOLwtrwJ04TNfd1AnqY07wLSXpim2etAfdigpEbIxtchQOefE1jVqwe04cBjvttP2h/Lsh1lwk3Uk34CqWak50ctEyQOSNgkH3tQXRWo980Cr1Gz33TQ3csYNzYBSakSiVCUHuO7a+pCbUxvziF653Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=nN70aiWB; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHn/zXmHnKrs7KhQVJuFezv5Eo1G+7gZ2GbJhEK6XyrNmbWG9qHFhHF6ZjQ80nf1+j9muQy+JmP4YV7y99LQKlRe8GukRfbvxc1k8laXnlYW85iI01WQrUVgNwGoPeOCxRk1M7+ojY/xiwyOQHOV0DcK5hFxJOhEOboUgyis63nOKap6GnDIqXAdQe9QLVx4x6lsiobTiKssRTOtr7vKhYLMTDCwWe0NctOkXwr9Q1s4hC2AS+iEG/BBJqKLnv2Xr0pFDXc4n7P1cFrjtPND3/AGxOsMmy8OYydoKAelOovY8hae1oFX9IbHi0UCCHcG/O7K6TrsOUGJZdEZf0huJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0c3gj57jLjz9i4YRp9HL0ATukswTG/0JxUS6RvvL9g=;
 b=U+8sS2lU+koiqJaA9Ht2OTffN0D4fWuWhUuRpFo+TCZr8LmNZQUjrTUcVHJClQuhhSWKXTdfNQeE9ODYITA2jAHJlY3llT6xAX6Qr8tO3ElJO5bxenVCZhqgnLT/lrbcdbqt0XkAIfdl8ZF3nHJXZ7oBTI5T7a444X9SBsLSxjsS3BniKnjEsfFj6zGtocttBPej1bH3kK5jeBdMPR2j+HCPQyMa4kgU5MQKMjcP4bVbgMMxxL1C0QOH6l1uYCPvuI+1XuuEAzkwG9sNM8yzUp5XdH8Ln0rKVuvKviIkVLuxBHRLxmUVClFhw4aqZYqlz44NC54ZUvyFLMpVPLTa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0c3gj57jLjz9i4YRp9HL0ATukswTG/0JxUS6RvvL9g=;
 b=nN70aiWBRdb047L0G5ZzhkTBr6bXqJ2mwIkWy4RaSjNGgrYg8OdGHzHYdd/TIvTylRQxxQwWIGutmZEVpIigT5454Xu9GyiEeW481QNIAprlE8LyeXcsJTRwcTxZG/qZWl4QFbPJNRfbe0ywHhtOFvDQlVgeaW0RSy8IjR8yFXYdegRfVSACBjir7OIq+i2eFgQmrhhuqhRywMG+yXz55T7/CROYSVRlDgW8N+d+FNtTKwfNnGaevU5B4g3dB7szYdp7gKgba/62krSLSZlv175RvGbf8ibOXnRgoZzIqtwI5/FJbMyiaKNjeQ1hxFHIwS2nrcGUnm/gMp6rusc89A==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0741.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:113::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 06:23:06 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 06:23:06 +0000
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
Subject: RE: [PATCH net] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Topic: [PATCH net] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwFaZgpnD0jkjNUO+2TpEMAczLrXJvMKw
Date: Wed, 1 Apr 2026 06:23:05 +0000
Message-ID:
 <GV1P189MB19883FBFDFE70FD44104B66CC650A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <043673b8636b4f60a52589330cb55e83.security@1seal.org>
In-Reply-To: <043673b8636b4f60a52589330cb55e83.security@1seal.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0741:EE_
x-ms-office365-filtering-correlation-id: 749130b0-df61-4645-94f9-08de8fb722e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 JAkzo4LOEgiadpoVUkDbGcbI4p/m8UbZlHE6ePH22E7P9cFTNfy1JDeuPBV7vqjwC76U30x/bXLUSf+FgRbR7h43NE9rJPhluJKzLPuCz6YYKwt6UzupZeYX1kvj3qRxWHgnAzjsd1rE1XT5r4LdFdRJ2nVIrLuc4bAECHtwNJrVmXdre2uuuwMumyQTChUd/BlpaAFGIXYTAyJTlah3j5M2Bl/R/Ntdl0Gj8QXJu4WocWJfJlh91AzKtY0oJ5WkE4CeFUTCsD0nidH9p5rhYLKBF6m25MWWg9kJ0MS/ZEN0lw73eGDuxA4yqCdPTwyUtyW71DtOHS2QkZRLIJdeNUlBRb+lBYxjtjUEUlDNKchW1/bPHHuOs+mh8U2hLmbRH3cCICmtCE9i2qWDJ/xpVoNfvoLnvKbTv5T2txBejFNg2tVabJffM6bsn2jcMuL/L+EmnFZGBU34W9A4eIV/+dqm0TOa2k022L/p5d76Qs8lPOoNY6fXubGIuiasqkOuPfk54uq9zdwSNWYNWog/GpYoRQc1bpMrb2Ib7SbV3Mow12w9o0KOAfVmLa+v+ar5AuLZ2q9U8NwNS8MSbbEjpZfBlfd4E5ijp0itB9Ao+pC03Szjl3HljotJ8cduxcBdpCcyESu770sSH1xfy3VBnf2+G2VWT5NMFIX6gkuwwmTvEKyxOBz0AmT52Iy9pcwke9mxE10SqMiUFx0jdtTKn1yBf1qsTUn9tw0zJivC1Jvfze+KJO2i7oX5xCJnoE7Omnxxg3pIJdo4o4ANb/C6/5XW0s7EYtNenxKXx2xGkq8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1VWaGErdytxTUhaQVkvSWNwT0FoRVZTQVF1amErUnJLWTAzcUVVYndBeUxm?=
 =?utf-8?B?NUlBOGxlTS9PK1RkYnpIWDlHUlN4a092RnJoMWx1NW82bHRtTHhORXRCMWd5?=
 =?utf-8?B?Vjk1Tm5yeTJqTmhzT3FxazQ4cXhiWXE2SklUekEwOGlIM0t1aFBRT2N5MjVB?=
 =?utf-8?B?YU1NM2RkZ2xvNDFrRGpPZlFDVmFOUjBINTI2ZVJGc21ZK1FTWXBLeUh0TG1C?=
 =?utf-8?B?S3RGYzBxZkZFR21taEpkRHFZM091SDJnZ0JHRkVlWWRkM3kxdEpPOFR2RFJz?=
 =?utf-8?B?bUw4dXVkQXV4eFcrWmsxaGR2REFEVzJTcEV1R210TU93bXZoVUM1VitMeEJw?=
 =?utf-8?B?M0ZpMHk3b1ZpRFljd0hzNUx1Yjl1WXdoNTVPM2xzV1h0Nm9oQjI4UmE2VlRn?=
 =?utf-8?B?VytYNE9KeHZNL2JyWVlzSjI1ZVdDeUdHdXhicVJ1MVZTQkE0NC9IUUd6UHF2?=
 =?utf-8?B?UDdDN1RmOXpzMGF1eTVtUjc4SEhNdHBacEdvVkZQRDVXN1lROE1aVFRwNlFV?=
 =?utf-8?B?WFhZOUNqUGVseEZlYy9xRDNRemkzQVVFOWZZbFBHZW5ZbWZLYlpFek1XcFJ1?=
 =?utf-8?B?d01WNFkyZ0pjRFpSaFFjTDFEVHVWd0laOWxhQWJNSVJBSlV0UU9XR2sxRzYz?=
 =?utf-8?B?cEJBNGE4dFg1UlBBWU1kS1lubFR5YkhtVlFnRkM1YlZtMU5oUEFRVno4L3o0?=
 =?utf-8?B?Z0c1T09RY0x4Zld3clZ5OWlxb3hxSlprQ3RSRTBXSCt5L2Zmb1dtTXhNR2wv?=
 =?utf-8?B?R3R4NDhyUUdzc3BZVjZOMnphVmlMcGpRYkM5Q2ZTY05EKzhFUmF0elo3Yk1m?=
 =?utf-8?B?bUc5VXF1VTlFRXZMUXd2SUZPa2x4TXZvSGRmdXQ5dUtYT2NkQVo5NFJCOFdR?=
 =?utf-8?B?dUJBMlJsK3RXZDg2SE8zMmJ4c1FnbzFON3hBS3FHblV2MGVWVzRzdTVYM0pT?=
 =?utf-8?B?R1JaRGFSdWVqbmhjWVR4alNtOE16UmJlTTd4MzhIR1lITzJkTEhpTzFBaDFS?=
 =?utf-8?B?aHlnUXRQRFlYRTFLWWNqRk1IZTdCOUN3Z2FBWTAxSnRtcGx6WEp6Q0s5N0sx?=
 =?utf-8?B?d0N0emwxL1NyZXNzWUs0RDlwRVQxUm9oNnoyWjRCeWg3dVB2am51b3Rpc0Vy?=
 =?utf-8?B?WVg1blpVTVFRbXh0TGVEWWcwcDhqcGU3OEtjRGpzeUs4dEhYNUppb3BCdTRO?=
 =?utf-8?B?anFrOVF0REZNUGViNmpwdFlBc3ZHSmFNNnl0c3NRbkZHMVBJeUVDU0ZnejBa?=
 =?utf-8?B?ZzlGMHNtZWR6dmx0Z2RtMEtScjJpYXZyampxRGczK1BCcktIYmhnVGVVUWtn?=
 =?utf-8?B?bWdUdlY1TFNBRnBNbFV0b0JVUXpMS21RVE9yd2Y5VmFJU3EwbXp0aU5ZeEta?=
 =?utf-8?B?cEU5Ull0VGVrR1NuNGdqT0lnZ1lSeTRvWG9UcjFLbTBXYUFMNzk4SHNxVmJ1?=
 =?utf-8?B?WUQ1R3JSR0UxMHIyQlpNRFRicUNJZEZQR1RhMjJJdkRQQXBFc0g0WHlLS1ZM?=
 =?utf-8?B?U0xkRkxrU0N4NXdON242bzZKd3Q0dmIzY0RnUnZXcWdkR00rb0t5N0VZbzNv?=
 =?utf-8?B?TmhyMkwxeEdmSDRFaEJ4NzVDbXFKUDNtSE9BbU0rY0Y5RHNJVEQ3cGV5MUds?=
 =?utf-8?B?YmtBWFdMdDFPMEtmS09FSHNyMHdNdHFwclhkVXUrQWgyci9KOGRwUGpsY21m?=
 =?utf-8?B?YUhXdjg2bzdpMzkyOEZ6RjNqdm1KakRqY0VKZ0FFMVJ0TTVoRUZxV0dvbC9B?=
 =?utf-8?B?OVQ3MU94TzdOUXZ1cDZuWUtrK3VFSitJUkgwY2JQSlJOcVo0MUw0czV5VVc3?=
 =?utf-8?B?SmhCVzFCRWJ2KzIxVnMwMkE3ZWxHanBUVEV6RzNDdVhXcEM0SUV0ejF5YXpC?=
 =?utf-8?B?Qnk5dDVLZ2hnVDY3VTZNZDIvOUI5Rks0K2pmcTNQRGVBVnNKUzlLWUdMNWRy?=
 =?utf-8?B?VTZaNFFnSGJHNm1LUUpoYW9mOVQwWkN1NnNQQzBJNUlnODZPMkpoZXBzQ0NF?=
 =?utf-8?B?Q0wrV2xnK2t3ZWgwa2FXWDdWbzJtdU9mR3JUdGhRd3V4Q1RrNjNHTG11T3Fq?=
 =?utf-8?B?dUZRZlA2Q0RjL2hzWFdoNnRXcXcwK3AzN1p0cnI4cSs0Z3dReTE1VWdGYncv?=
 =?utf-8?B?RjJ3d0loUGlUTERTdGF5Y1ByYjh6YWlHS3ArSVlualJMTEMyZnlaV3IrT3Jt?=
 =?utf-8?B?bDJCZURFY014N0JFNXNJd2pxSnpxaVlQQ2o5ZDJ0RTYzYlpBSHFTd2FydmR5?=
 =?utf-8?B?RldkUzVBT3dpVGNyR1R1ajRaTnVKWkRsNkhhWFBvUUdUaVcxenVpa0wrZkV1?=
 =?utf-8?B?TDZrTHkvcXhQNHVXZ2xMa2d0Zk44QVpLbXhIeDBoMTlLZjVtcnZOQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 749130b0-df61-4645-94f9-08de8fb722e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 06:23:05.9086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg/WgwHcOKISq9+39osWFjYeaE3fBi6fepsw5nSVKIqe7PuHMU+EYVVNQGHpoEAhm5uFjFB7Y5YNjQjjlYwmB5102md9xpGAIlxmIcHeYuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0741
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232699-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,1seal.org:email]
X-Rspamd-Queue-Id: 5A237375269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IGZpeCBiY19hY2tlcnMgdW5kZXJmbG93IG9uIGR1
cGxpY2F0ZSBHUlBfQUNLX01TRw0KPg0KPlRoZSBHUlBfQUNLX01TRyBoYW5kbGVyIGluIHRpcGNf
Z3JvdXBfcHJvdG9fcmN2KCkgdW5jb25kaXRpb25hbGx5DQo+ZGVjcmVtZW50cyBncnAtPmJjX2Fj
a2VycyBvbiBldmVyeSBpbmJvdW5kIGdyb3VwIEFDSywgZXZlbiB3aGVuIHRoZQ0KPnNlbmRpbmcg
bWVtYmVyIGhhcyBhbHJlYWR5IGFja25vd2xlZGdlZCB0aGUgY3VycmVudCBicm9hZGNhc3Qgcm91
bmQuDQo+DQo+QmVjYXVzZSBiY19hY2tlcnMgaXMgYSB1MTYsIGEgc2luZ2xlIGR1cGxpY2F0ZSBB
Q0sgcmVjZWl2ZWQgYWZ0ZXIgdGhlIGxlZ2l0aW1hdGUNCj5zZXQgaGFzIGRyYWluZWQgdGhlIGNv
dW50ZXIgdG8gemVybyB3cmFwcyBpdCB0byA2NTUzNS4NCj5PbmNlIHdyYXBwZWQsIHRpcGNfZ3Jv
dXBfYmNfY29uZygpIHBlcm1hbmVudGx5IHJlcG9ydHMgY29uZ2VzdGlvbiwNCj5ibG9ja2luZyBh
bGwgc3Vic2VxdWVudCBncm91cCBicm9hZGNhc3RzIG9uIHRoZSBhZmZlY3RlZCBzb2NrZXQgdW50
aWwgdGhlIGdyb3VwDQo+aXMgcmVjcmVhdGVkLg0KPg0KPlRoZSBtZW1iZXItcmVtb3ZhbCBwYXRo
ICh0aXBjX2dyb3VwX2RlbGV0ZV9tZW1iZXIpIGFscmVhZHkgaGFuZGxlcyB0aGlzDQo+Y29ycmVj
dGx5OiBpdCBvbmx5IGRlY3JlbWVudHMgYmNfYWNrZXJzIHdoZW4gdGhlIGNvdW50ZXIgaXMgbm9u
LXplcm8gYW5kIHRoZQ0KPm1lbWJlciBzdGlsbCBvd2VzIGFuIEFDSyBmb3IgdGhlIGN1cnJlbnQg
YnJvYWRjYXN0IHJvdW5kLg0KPg0KPkFwcGx5IHRoZSBzYW1lIGZvcndhcmQtcHJvZ3Jlc3MgZ3Vh
cmQgdG8gdGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXI6IG9ubHkNCj51cGRhdGUgbS0+YmNfYWNrZWQg
YW5kIGRlY3JlbWVudCBiY19hY2tlcnMgd2hlbiB0aGUgaW5ib3VuZCBhY2sgdmFsdWUgaXMNCj5z
dHJpY3RseSBhaGVhZCBvZiB3aGF0IGhhcyBhbHJlYWR5IGJlZW4gcmVjb3JkZWQgZm9yIHRoYXQg
bWVtYmVyLCBhbmQgb25seQ0KPmRlY3JlbWVudCB3aGVuIGJjX2Fja2VycyBpcyBub24temVyby4N
Cj4NCj5GaXhlczogNzVkYTIxNjNkYmI2ICgidGlwYzogaW50cm9kdWNlIGNvbW11bmljYXRpb24g
Z3JvdXBzIikNCj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPlNpZ25lZC1vZmYtYnk6IE9s
ZWggS29ua28gPHNlY3VyaXR5QDFzZWFsLm9yZz4NCj4tLS0NCj4gbmV0L3RpcGMvZ3JvdXAuYyB8
IDExICsrKysrKysrLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL25ldC90aXBjL2dyb3VwLmMgYi9uZXQvdGlwYy9n
cm91cC5jIGluZGV4DQo+ZTBlNjIyN2I0MzMuLjQxZmE3YmIzMDkxIDEwMDY0NA0KPi0tLSBhL25l
dC90aXBjL2dyb3VwLmMNCj4rKysgYi9uZXQvdGlwYy9ncm91cC5jDQo+QEAgLTc0NSw3ICs3NDUs
NyBAQCB2b2lkIHRpcGNfZ3JvdXBfcHJvdG9fcmN2KHN0cnVjdCB0aXBjX2dyb3VwICpncnAsIGJv
b2wNCj4qdXNyX3dha2V1cCwNCj4gCXUzMiBub2RlID0gbXNnX29yaWdub2RlKGhkcik7DQo+IAl1
MzIgcG9ydCA9IG1zZ19vcmlncG9ydChoZHIpOw0KPiAJc3RydWN0IHRpcGNfbWVtYmVyICptLCAq
cG07DQo+LQl1MTYgcmVtaXR0ZWQsIGluX2ZsaWdodDsNCj4rCXUxNiByZW1pdHRlZCwgaW5fZmxp
Z2h0LCBhY2tlZDsNClZhcmlhYmxlIGRlY2xhcmF0aW9uIHNob3VsZCBiZSAiUmV2ZXJzZSBYJ21h
cyB0cmVlIiBzdHlsZS4NCj4NCj4gCWlmICghZ3JwKQ0KPiAJCXJldHVybjsNCj5AQCAtNzk4LDgg
Kzc5OCwxMyBAQCB2b2lkIHRpcGNfZ3JvdXBfcHJvdG9fcmN2KHN0cnVjdCB0aXBjX2dyb3VwICpn
cnAsDQo+Ym9vbCAqdXNyX3dha2V1cCwNCj4gCWNhc2UgR1JQX0FDS19NU0c6DQo+IAkJaWYgKCFt
KQ0KPiAJCQlyZXR1cm47DQo+LQkJbS0+YmNfYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2VkKGhkcik7
DQo+LQkJaWYgKC0tZ3JwLT5iY19hY2tlcnMpDQo+KwkJYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2Vk
KGhkcik7DQo+KwkJaWYgKGxlc3MobS0+YmNfYWNrZWQsIGFja2VkKSkgew0KPisJCQltLT5iY19h
Y2tlZCA9IGFja2VkOw0KPisJCQlpZiAoZ3JwLT5iY19hY2tlcnMpDQo+KwkJCQlncnAtPmJjX2Fj
a2Vycy0tOw0KPisJCX0NClRoaXMgc2FuaXR5IGNoZWNrIGlzIG5vdCBjb3JyZWN0IGJlY2F1c2Ug
c3Vic2VxdWVudCBzdGF0ZW1lbnRzIGFyZSBzdGlsbCBleGVjdXRlZCBpbiB0aGUgY2FzZSBvZiBy
ZWNlaXZpbmcgZHVwbGljYXRlIEFDSy4gVGhpcyBwYXRjaCBzaG91bGQgZml4IHRoZSBpc3N1ZToN
CmRpZmYgLS1naXQgYS9uZXQvdGlwYy9ncm91cC5jIGIvbmV0L3RpcGMvZ3JvdXAuYw0KaW5kZXgg
ZTBlNjIyN2I0MzNiLi5lZDgxYmZlMTgzMGUgMTAwNjQ0DQotLS0gYS9uZXQvdGlwYy9ncm91cC5j
DQorKysgYi9uZXQvdGlwYy9ncm91cC5jDQpAQCAtNzQ2LDYgKzc0Niw3IEBAIHZvaWQgdGlwY19n
cm91cF9wcm90b19yY3Yoc3RydWN0IHRpcGNfZ3JvdXAgKmdycCwgYm9vbCAqdXNyX3dha2V1cCwN
CiAgICAgICAgdTMyIHBvcnQgPSBtc2dfb3JpZ3BvcnQoaGRyKTsNCiAgICAgICAgc3RydWN0IHRp
cGNfbWVtYmVyICptLCAqcG07DQogICAgICAgIHUxNiByZW1pdHRlZCwgaW5fZmxpZ2h0Ow0KKyAg
ICAgICB1MTYgYWNrZWQ7DQogDQogICAgICAgIGlmICghZ3JwKQ0KICAgICAgICAgICAgICAgIHJl
dHVybjsNCkBAIC03OTgsNyArNzk5LDEyIEBAIHZvaWQgdGlwY19ncm91cF9wcm90b19yY3Yoc3Ry
dWN0IHRpcGNfZ3JvdXAgKmdycCwgYm9vbCAqdXNyX3dha2V1cCwNCiAgICAgICAgY2FzZSBHUlBf
QUNLX01TRzoNCiAgICAgICAgICAgICAgICBpZiAoIW0pDQogICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm47DQotICAgICAgICAgICAgICAgbS0+YmNfYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2Vk
KGhkcik7DQorDQorICAgICAgICAgICAgICAgYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2VkKGhkcik7
DQorICAgICAgICAgICAgICAgaWYgKGxlc3NfZXEoYWNrZWQsIG0tPmJjX2Fja2VkKSkNCisgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybjsNCisNCisgICAgICAgICAgICAgICBtLT5iY19hY2tl
ZCA9IGFja2VkOw0KICAgICAgICAgICAgICAgIGlmICgtLWdycC0+YmNfYWNrZXJzKQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICAgICAgICAgIGxpc3RfZGVsX2luaXQo
Jm0tPnNtYWxsX3dpbik7DQo+KwkJaWYgKGdycC0+YmNfYWNrZXJzKQ0KPiAJCQlyZXR1cm47DQo+
IAkJbGlzdF9kZWxfaW5pdCgmbS0+c21hbGxfd2luKTsNCj4gCQkqbS0+Z3JvdXAtPm9wZW4gPSB0
cnVlOw0KPi0tDQo+Mi41MC4wDQo+DQoNCg==

