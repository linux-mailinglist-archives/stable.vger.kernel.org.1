Return-Path: <stable+bounces-231315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG1qGKZDy2l+FAYAu9opvQ
	(envelope-from <stable+bounces-231315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:46:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11C363BE4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89D3303714D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A70285CBA;
	Tue, 31 Mar 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DFWUwEeS"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2ED2741B5;
	Tue, 31 Mar 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928779; cv=fail; b=TD7CaLmbmLrETqmOT8b2tZ/fKKubn6pHEVXcPs/KoCDj6Aii2rX4P3/wndEAv06nEimmWLqA6Bg46b8sVz0URsTU53F5wdkSRfp+Q+x7VsizkHZlBrKuNifDn2a7/VlLJwk14e868UzvqbTBuzj3KMp5A56kg+OloRSMVZgzExE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928779; c=relaxed/simple;
	bh=50UgZkH7ot5Lcy8N41bDx/s4/RtLfTuSJ3r5G9GBv4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qAziayS95ff/kJwFo0kYdqXd1zeHhC7hxV2TW9LM+AvjX/jqHg1cXdBOV1hJFtvFosjwdgYZWK3YSn5QF6J4PHIyVrU063h81YkbcgagaHjUxzHZZ9WV8aIjDzi2e2PvwX6IDNxtnAsEcW5tiO6gKh+4tcBSNBEzMu4ae8aGzoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DFWUwEeS; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbqMFgS+nRx+zgAIMJ55KticZxWyDEdz0pRqRnWvWrMfABoTXHP0ZqWCp9KEeD3r68CRiJyf2I7y6J6iEX+LUEOt8PGn+u/lxFQuVM2Q80ly9B/HFNmU49CsaULa/qqNavG3iS47sWjb134T590p2qlhTfaDuyy3IMopaOsXyGWTpzkDgQiopmH7xMjfiYNfxm4Eu8KcFCMf1ljLFZrl/dT8u7NBGmBU5Jq3zmsqeu3fC38CbEF+ft/bqDhsCJhrXPRxdzGy8+DUk0tonkavefEtwvKc0HdQugc4ryT60OguyqGDjPq9N8MvGWwFdlLtK5q6Y/erhMgiYtIRSXVtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50UgZkH7ot5Lcy8N41bDx/s4/RtLfTuSJ3r5G9GBv4w=;
 b=Gvnf2RiSm5kDzlomacRgFeguV1HSEnhGdcdkkEk4X1ktv+gw1BAMxxVsio1IZVpmwOr1BzgDlC36SB/3K7HiUYtyXgB4TtWLE6qpEyj6yl9Yi7wXZHcRPifvFm8tsHRL9ivOi2YXhZ+L1C/vQzmuFkWyAO9mPw/UhXkQBsj+He+aNkou1s2NoqVkB9myeef/u5lxd41tqIkZoqIwrBKVdQAqZnXtQKpjCaU9aadcv1wNNZTrDW9KsBzbi1yPG5pym4FjjXLJMd4OKCwzR4JoY4tf56HOdsw0dOQgJABINwhrwJZBgYCZX/RmBe6EYUt+jnyn4bj4zwCQbdun/VSwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50UgZkH7ot5Lcy8N41bDx/s4/RtLfTuSJ3r5G9GBv4w=;
 b=DFWUwEeSH3b73rQ2MvxmeI5c/+9tmkS2rk6aajWLJAdU8VetOVn47/Hb8jcL1gyLX8qfnb9OPZKPjWiq7H5/CuBplBs7xflYvW7L1xhK11pnCcSFgwn3Aw8etZWK82kZAGNY8wqD1SiOKf4ONXk0oqEi/pwaN/UScFLJykvwwQ5pjdfm7r1Ss0FrHOEjSPQL665a66kL7Z0Jt8l6q9r7OqDcYGTMtzRXzovwRf2/3hrDYp5YdKe/ALjurouY/NRzJgDRegC9lRwGSArpxlr2rRODV83YX+p+YA8lAh8kZWvMgxcIcXxxeKevXlJPK7eLagmNVFsyuh0Xl3qbzwNGtg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PAWP189MB2373.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:335::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Tue, 31 Mar 2026 03:46:12 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 03:46:12 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kai Zen <kai.aizen.dev@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Thread-Topic: [PATCH net v2] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Thread-Index: AQHcwEYsbfKBHSUOfkC47xN2HcX7LLXIACUQ
Date: Tue, 31 Mar 2026 03:46:11 +0000
Message-ID:
 <GV1P189MB19880AE8D9748C17BC3685FEC653A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
In-Reply-To:
 <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PAWP189MB2373:EE_
x-ms-office365-filtering-correlation-id: 0a6957b1-81cf-4894-a93c-08de8ed80d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 HXiByX/mv5hExWuIZb4bWFZEuR9u2KhwMBAwrHnxhleVi+wOnc2Fcy9qFIaEVWXvA4AUyRgIniMknL9C6uCesVDe7sYc/WE4zxbXoqrOHYdW3i/fFCdpOUIxf3b7n2MwQwRbsi1NhW7bLy1wUuD5Lww6aiXzG/BNo2L2S/bkQlzBsWNBVQ7kdr7Fv4JkNm/o1VI6syijKa9wyuHXd3Wbo2ugfDLSJLXfsyYFJmbI49/lfW5D2ZSLk8WA0MN1J4gb/XU8pQ4fCOpW6jExPW1CaQZLvB2RzuVdhjf8oyeIdiDX4Q1INc3k7w2YTKlEsFaH1gs5LNb4TeU0bplMFfxBYk/1AMmoAwdkPjydUBJCF13H1xtpd/Ca5Wg8mQ0xNmIgrG2kAmpbpiYKkpR5jmkHbLsOd71LVSUoP/ZlTIy/izEN/+toJIEpzBRSKxCBFPeF6AdX1gOLhvs9GlidwZpH9lD03LhNKpQmHT07tFBk+ROd3S3Ka40TwwFUPWYr/4OD6Ov6tLRoaTnTLTIZL9ffsp8lxWyYycWS37WEzcJsB8e08P2nEK61iAkyE3x796PnDoxJocM44qsOQBTb/kFe9oui6/dN7/pL7SAHi5OXuVkURH4emCmckpB61toHdRHw7ejaBCaX5aEpUNzMo5Ooy0wMr9OySNTbb+QvF254rk7bLOga63ueDvyM5LM9dVBE9cbrebKhin/sWLVtiSurCOWYHYLHNHdP7H/Z+joGt+KVfctJKrjMsgtIc291+1LNgcCWZBZYpVfFh5o70GPG5P86tX6m8WXKIebNgPxBhV0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlVHZm9YZGxPSklYUUJIakgxQWtTRU9tdHFQLzd2b3VXZ1l2Q1R3WUltanJn?=
 =?utf-8?B?Qk4yOHpTTjBSbGNEdDlONjEyQU95Zi8rSlF4a08yVElxRytiRkR3Q0NUTzJj?=
 =?utf-8?B?OFRVVGRZUHdMUlpxTHZKTXlPMzQxV3BDZ0x3eUpZK1hxczg4Rmk4TFlnbGl1?=
 =?utf-8?B?Y0sxYzc1NzBoNmJmS1lRdmwxSEhra0ltZTNVclI4eVBpUXZUMEJJZ214NHA3?=
 =?utf-8?B?QWF3eFZXQlJQVi9EUmJ4d25DUVZHek4rNzFkUlZZM0l3aC9TTnRxK1I0eFBO?=
 =?utf-8?B?bC9vMmRLRUpoRDhGaXVPKzlOdm5WZTJPQ2d4MDYrUUZGaVJvaUFtaUtndFVE?=
 =?utf-8?B?NUdUaXgrcldHTjNWUjkvTjNJK2lRQTVsYUJaVG1NZlhEUzN4T1dGL2s5TStj?=
 =?utf-8?B?WnNHYVdwZml1U2FaU2ZUdTBDUERmdUNFWHk1aDdXaVlaRFgwVDFrUXptbEh1?=
 =?utf-8?B?Z2lNbjd5YkhQcmJYVlVzNWFKWWs2WFpOY0w5NXlpQmhIWW45TnVFWUZGMzNp?=
 =?utf-8?B?WVRGOC9YYnpLZ0xiOGhMT1FzcXA1MVNVa3pFWXNSVER6RHV3b0hLdDZLNHVQ?=
 =?utf-8?B?eXdhU2pWU2FRT1U0LzBSQnJ2bmpVRFNlWUFTYW90WUFVTVkwZUY0SElOK21X?=
 =?utf-8?B?TGxjY3J4UG04bGpOR1hDeTZRblAwdWFuTFBQT3RCU0hSNDdkc2tQd3Fid2NF?=
 =?utf-8?B?RnFZTlFjUStzTVl3cjBDa1R2NmFZdWhQL1IwZVNwTGpVcDE5SjVKdjlGOStN?=
 =?utf-8?B?TEllaXZWV2x4ZlBSdVk0M3pTd2N6TDROb2NqZllXTjVHaldQYnVHRTQyU0t0?=
 =?utf-8?B?T2NLQUlZcERlZ0lkWWRzWGs5N3c2OHNuOW1PWFdrcC9yMmRiaGtGMUVkODJt?=
 =?utf-8?B?eG9ZZU5vWi9RY3RiRVBDQmUzYk8vK3ZpRnY4V3lJRHV1QTJsamRtZFUwQWVN?=
 =?utf-8?B?TjlFUzNZNENCQ3NQNGlVYkxhdkZ5MHlId2FDZ0t2Y2dTNUNUN0VoYWZDT0RN?=
 =?utf-8?B?bXArOStQWUZiS3pPMW91bldDTzkwVXI5bXJadXlOdEFadFRQbVRxa3haYitN?=
 =?utf-8?B?MW02RjFkdy9UVWIySEtZSE1Fb2Nvb1lsTjlFRHJyRG1Cd1drN0crK2dTTGhE?=
 =?utf-8?B?N1ZZa1VBdmJ5cFozOUxNbVoxb2VEbVZGblFKUmlNWnc3amNsa0E5VHRmM2hC?=
 =?utf-8?B?S1llWE9qNU5vQXN3b2dlRTZPZkt2VG1IcGRtNzFNdGpuaU11UXJQMGNDbGFT?=
 =?utf-8?B?SGt0aXVPeTRNSnFnWWVvNW1sMDNRV09Lc2hkcWpQZk5JdEZVM1J5Yk1IQ1BY?=
 =?utf-8?B?SENjOHFXTEVCVkxZWHp1ZU1CY1k0VXZTNHEwd2hTcTVXVHNTNFBsV0d2azd6?=
 =?utf-8?B?VDYwNlJJV2pLS1ErUER1ZHZ2UFF2Wnp5S3YvV3NJcDloaytqZmtWeEl3aUc0?=
 =?utf-8?B?NUdyampxek5LUmRBaHJQd1hhSDhuYXYzNTR5WkRpSXBOeHh5SVlDR1Bsdjhr?=
 =?utf-8?B?SDUvdW9ndGU3OUpzYkgzVW5rOGd0MzFxZ1EvVDZOV0VCNk5UbGhkQVN3MTF5?=
 =?utf-8?B?aTM2YWRNdVBNRFJMaXVOODRIbDJNa2x4d3RJYkxGNjkrVnRhYmZFNFkxam5n?=
 =?utf-8?B?N2l5VEhHQXpZK1p1eTJzRlVMc2VsN0ZZY2RrMDlUOTRRNGFReldnMXg4bDEz?=
 =?utf-8?B?N3lCajZKY29oY0E0bHpUeE53aUsvdm5rcDhqWS9wYllrSXBESDRtaGZZREZw?=
 =?utf-8?B?QWVmbGFOeDkzWTVHMHVRWWM2eERkZWlXNnpiVDE1Ym5zRUVKT1h5aVd0bVAw?=
 =?utf-8?B?SDRBZVhwOXZCU0RML3FPSjF1NUpoOWxEbEZaeDBreTF0Ni9kVFFxNWVISC9Z?=
 =?utf-8?B?eVE5UGx1dE5GRnJybk9qNzNCcjd6a3FCK040SEgwVVNQV3VuUWx2Vk4rdGM1?=
 =?utf-8?B?QWVnZVIrU0NWa1dKKzNDWjlGOTFjL0c5S2I0d2M3eGprTVpKRTRFQ2xIdCtS?=
 =?utf-8?B?eE9MT1BEQ0huU1QraDAvT3VLcVNlR3ZOQmcxbmZuN3pCeS8zOHRJSU9JeTBI?=
 =?utf-8?B?NzZKMVFXWEVxOFZpOGlmZG0zMXRzVy9tRWh1STZVcm9hRDYwUW5TU0psU013?=
 =?utf-8?B?TWIzU2o5RjUzV3hvVnpyRC9nTlVQZU5kMXA5bE9OY24vMXMrdTZybEZKQmkz?=
 =?utf-8?B?RHJjWjZ2eU1mdy8xNFV2T3liRHhYWERYamg1aDA1aDIxT05vdkFMSDV2Z2ln?=
 =?utf-8?B?VVNLdUpZNUtjYTVlQXc4bFVuSmlQQTBqUTJqOWZoQjlQbXNCVHhSdXI2b1dE?=
 =?utf-8?B?ZEJJbjRScmVmc2tRVGNRNTFiTWIvL0JtaWNybWE2SlRGdnlVclFxdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6957b1-81cf-4894-a93c-08de8ed80d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 03:46:11.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTS1nv6YVypQR5IuvdWMmIfL5RbOKbYXYiSWoFbXjfS923Ylu3uETfpgtLqwNYmfd9nL+7mIwfUXo2qSAVC9XUv50psP0NR6Zie3nQELTKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP189MB2373
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-231315-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB11C363BE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIHRpcGM6IGZpeCBVQUYgcmFjZSBpbg0KPnRpcGNfbW9u
X3BlZXJfdXAvZG93bi9yZW1vdmVfcGVlciB2cyBiZWFyZXIgdGVhcmRvd24NCj4NCj5DVkUtMjAy
NS00MDI4MCBmaXhlZCB0aXBjX21vbl9yZWluaXRfc2VsZigpIGFjY2Vzc2luZyBtb25pdG9yc1td
IGZyb20gYQ0KPndvcmtxdWV1ZSB3aXRob3V0IFJUTkwuICBUaGF0IHBhdGNoIGNsb3NlZCB0aGUg
d29ya3F1ZXVlIHBhdGggYnkgYWRkaW5nDQo+cnRubF9sb2NrKCkgYXJvdW5kIHRoZSBjYWxsLg0K
Pg0KPkhvd2V2ZXIsIHRocmVlIGFkZGl0aW9uYWwgZnVuY3Rpb25zIGluIHRoZSBzYW1lIHN1YnN5
c3RlbSBhY2Nlc3MgdGlwY19uZXQtDQo+Pm1vbml0b3JzW10gZnJvbSBzb2Z0aXJxIGNvbnRleHQg
d2l0aCBubyBSQ1UgcHJvdGVjdGlvbiBhdCBhbGw6DQo+DQo+ICB0aXBjX21vbl9wZWVyX3VwKCkg
ICAgLSBjYWxsZWQgZnJvbSB0aXBjX25vZGVfd3JpdGVfdW5sb2NrKCkNCj4gIHRpcGNfbW9uX3Bl
ZXJfZG93bigpICAtIGNhbGxlZCBmcm9tIHRpcGNfbm9kZV93cml0ZV91bmxvY2soKQ0KPiAgdGlw
Y19tb25fcmVtb3ZlX3BlZXIoKSAtIGNhbGxlZCBmcm9tIHRpcGNfbm9kZV9saW5rX2Rvd24oKQ0K
Pg0KPlRoZXNlIHRocmVlIGFyZSBpbnZva2VkIGZyb20gdGhlIHBhY2tldCByZWNlaXZlIHBhdGgg
KHRpcGNfcmN2IC0+DQo+dGlwY19ub2RlX3dyaXRlX3VubG9jayAvIHRpcGNfbm9kZV9saW5rX2Rv
d24pIGFuZCBob2xkIG9ubHkgdGhlIHBlci1ub2RlDQo+cndsb2NrLCBub3QgUlROTC4NCj4NCj5D
b25jdXJyZW50bHksIGJlYXJlcl9kaXNhYmxlKCkgLS0gd2hpY2ggYWx3YXlzIGhvbGRzIFJUTkwg
cGVyIGl0cyBvd24gaW5saW5lDQo+ZG9jdW1lbnRhdGlvbiAtLSBjYWxscyB0aXBjX21vbl9kZWxl
dGUoKSwgd2hpY2g6DQo+DQo+ICAxLiBhY3F1aXJlcyBtb24tPmxvY2sNCj4gIDIuIHNldHMgdG4t
Pm1vbml0b3JzW2JlYXJlcl9pZF0gPSBOVUxMDQo+ICAzLiBmcmVlcyBhbGwgcGVlciBlbnRyaWVz
DQo+ICA0LiByZWxlYXNlcyBtb24tPmxvY2sNCj4gIDUuIGNhbGxzIGtmcmVlKG1vbikgIDwtLSBu
byBzeW5jaHJvbml6ZV9yY3UoKQ0KPg0KPlRoZSByYWNlIGlzIHN0cnVjdHVyYWw6IHRoZXJlIGlz
IG5vIHNoYXJlZCBsb2NrIGJldHdlZW4gdGhlIGRhdGEtcGF0aCByZWFkZXINCj4od2hpY2ggcmVh
ZHMgbW9uaXRvcnNbaWRdIHRoZW4gYWNxdWlyZXMgbW9uLT5sb2NrKSBhbmQgdGhlIHRlYXJkb3du
IHBhdGgNCj4od2hpY2ggYWNxdWlyZXMgbW9uLT5sb2NrLCBOVUxMcyB0aGUgc2xvdCwgdGhlbiBm
cmVlcykuDQo+QSBzb2Z0aXJxIHRocmVhZCBjYW4gcmVhZCBhIG5vbi1OVUxMIG1vbiBwb2ludGVy
LCBnZXQgcHJlZW1wdGVkLCBhbmQgcmVzdW1lDQo+YWZ0ZXIga2ZyZWUobW9uKSBoYXMgcnVuIG9u
IGFub3RoZXIgQ1BVLCB0aGVuIGNhbGwNCj53cml0ZV9sb2NrX2JoKCZtb24tPmxvY2spIG9uIGZy
ZWVkIG1lbW9yeToNCj4NCj4gIENQVSAwIChzb2Z0aXJxIC8gdGlwY19yY3YpICAgICAgICAgIENQ
VSAxIChSVE5MIC8gYmVhcmVyX2Rpc2FibGUpDQo+ICB0aXBjX21vbl9wZWVyX3VwKCkNCj4gICAg
bW9uID0gdGlwY19tb25pdG9yKG5ldCwgaWQpDQo+ICAgIFttb24gaXMgbm9uLU5VTExdDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGlwY19tb25fZGVsZXRlKCkNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdyaXRlX2xvY2tfYmgoJm1v
bi0+bG9jaykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRuLT5t
b25pdG9yc1tpZF0gPSBOVUxMDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAuLi4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdyaXRl
X3VubG9ja19iaCgmbW9uLT5sb2NrKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAga2ZyZWUobW9uKQ0KPiAgICB3cml0ZV9sb2NrX2JoKCZtb24tPmxvY2spICA8LS0g
VUFGDQo+DQpDYW4geW91IHJlcHJvZHVjZSBhYm92ZSBzY2VuYXJpbyBhbmQgY2FwdHVyZSB0aGUg
c3RhY2sgdHJhY2Ugd2hlbiBVQUYgaGFwcGVucyA/DQoNCj5UaGUgZml4IG1pcnJvcnMgdGhlIGV4
aXN0aW5nIGJlYXJlcl9saXN0W10gcGF0dGVybiBpbiB0aGUgc2FtZSBtb2R1bGU6DQo+Y29udmVy
dCBtb25pdG9yc1tdIHRvIF9fcmN1LCB1c2UgcmN1X2Fzc2lnbl9wb2ludGVyKCkgb24gY3JlYXRp
b24sDQo+UkNVX0lOSVRfUE9JTlRFUigpICsgc3luY2hyb25pemVfcmN1KCkgb24gZGVsZXRpb24g
KGJlZm9yZSB0aGUga2ZyZWUpLCBhbmQNCj50aGUgYXBwcm9wcmlhdGUgcmN1X2RlcmVmZXJlbmNl
X2JoKCkgdnMgcnRubF9kZXJlZmVyZW5jZSgpIHZhcmlhbnQgYXQgZWFjaA0KPnJlYWQgc2l0ZSBk
ZXBlbmRpbmcgb24gZXhlY3V0aW9uIGNvbnRleHQuDQo+DQo+c3luY2hyb25pemVfcmN1KCkgaW4g
dGlwY19tb25fZGVsZXRlKCkgaXMgcGxhY2VkIGFmdGVyIHRoZQ0KPndyaXRlX3VubG9ja19iaCgp
IGFuZCBiZWZvcmUgdGltZXJfc2h1dGRvd25fc3luYygpICsga2ZyZWUoKSB0byBlbnN1cmUgYWxs
DQo+c29mdGlycS1jb250ZXh0IHJlYWRlcnMgdGhhdCBhbHJlYWR5IG9ic2VydmVkIHRoZSBvbGQg
cG9pbnRlciBoYXZlIGNvbXBsZXRlZA0KPmJlZm9yZSB0aGUgbWVtb3J5IGlzIGZyZWVkLg0KPg0K
Tm90IHN1cmUgd2h5IHlvdXIgcGF0Y2ggZG9lcyBub3QgaW1wbGVtZW50IHlvdXIgYWJvdmUgc29s
dXRpb24uIEkgc2VlIG9ubHkgb25lIGNoYW5nZSBpbiBjb3JlLmguDQo+Rml4ZXM6IDM1YzU1Yzk4
NzdmOCAoInRpcGM6IGFkZCBuZWlnaGJvciBtb25pdG9yaW5nIGZyYW1ld29yayIpDQo+Q2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj5TaWduZWQtb2ZmLWJ5OiBLYWkgQWl6ZW4gPGthaS5haXpl
bi5kZXZAZ21haWwuY29tPg0KPi0tLQ0KPnYyOiBSZXN1Ym1pdCB0YXJnZXRpbmcgbWFpbmxpbmUg
dmlhIG5ldGRldiBwZXIgc3RhYmxlLWtlcm5lbC1ydWxlcyAoT3B0aW9uIDEpLg0KPiAgICBObyBj
b2RlIGNoYW5nZXMgZnJvbSB2MS4NCj4NCj4gbmV0L3RpcGMvY29yZS5oICAgIHwgIDIgKy0NCj4g
bmV0L3RpcGMvbW9uaXRvci5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0NCj4gMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxNiBk
ZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvbmV0L3RpcGMvY29yZS5oIGIvbmV0L3RpcGMv
Y29yZS5oDQo+LS0tIGEvbmV0L3RpcGMvY29yZS5oDQo+KysrIGIvbmV0L3RpcGMvY29yZS5oDQo+
QEAgLTEwOSw3ICsxMDksNyBAQA0KPiAgdTMyIG51bV9saW5rczsNCj4gIC8qIE5laWdoYm9yIG1v
bml0b3JpbmcgbGlzdCAqLw0KPi0gc3RydWN0IHRpcGNfbW9uaXRvciAqbW9uaXRvcnNbTUFYX0JF
QVJFUlNdOw0KPisgc3RydWN0IHRpcGNfbW9uaXRvciBfX3JjdSAqbW9uaXRvW01BWF9CRUFSRVJT
XTsNCj4gcnMNCj4rDQoNCg==

