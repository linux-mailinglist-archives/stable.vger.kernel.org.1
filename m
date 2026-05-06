Return-Path: <stable+bounces-244322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJGAKsni+mmGTgMAu9opvQ
	(envelope-from <stable+bounces-244322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130944D6B42
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89EB03021714
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8530F95F;
	Wed,  6 May 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="KqMEkpAO"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896602F1FD7;
	Wed,  6 May 2026 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049724; cv=fail; b=rNJJTjOza068UlJCRWQ517vQSEDp6P3B+5eEHXTlecY1XR4Nj0wxDkk4fQyfpbG47p6uED+RA9GEwUEYiffYZ7Gt6oF+FDxL6z1UN+OsYCUD7gk+qWG1m/rd+5Rn64ayI17k7uH4MwBD56di4GsIvLvabY9jUBcu7o9cY9IF0jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049724; c=relaxed/simple;
	bh=VpO9/kHgt5lQqvEZN6z0C5uXeNCD/YBHHoLkobmvq7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VWOTmr31pmTUBcMGhAR9+/4GflatbYw+jAO0zMKYx2Ps8s1otzfmR+2aYteyDxgR36R00d1xfRZVZ8Z/VoCMDOuUZjUphXb0rs5YoAGQ2LtpC4HAfb4zpz+Xu/TVnHKExUo2oi9TIfF9DO3h95OGRdHv6XCzd7G0mjhJpg8MYdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=KqMEkpAO; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT5mJb7vYwj1eFSQC4NZGmAPE9wR6BpHGlUr4qO2F5jSQgaU+xeqLEmpQ/HJR1l+lLQp7kCSOEGX9qmqFQyBDZ3qYs/In/ma4TSEeD8jiO906YNCp4JD5C6NOVow6FtgZDItxMJLH8iQS4wh4JMpwExFkfqoKKVmbDmw4qVkbatWilTuGYR2rvJz1yOhHyuJ+3K3uhbdsm08rKif1LU0rhO5nE7ZJrJ2h0TGG1jMvB24oXti4Z/HpfY39mfu8bXVcf/ihVqhnV5J1f3UTSBZIt41M3NLiDR2jRcmc9jO4KMwKBqbkRRYSn710JDT/0Mm5X7gMOzg7/JUGv2qPaXBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpO9/kHgt5lQqvEZN6z0C5uXeNCD/YBHHoLkobmvq7w=;
 b=NZnqdiyrkdkfOecuu3HSIIl4XKNJC9lCkyNJlFMjpvDUSAiT5ecwrltzRvKPcMbMt5v916wNsJq7P3Kd7baKYN6dqXqd99t7b3B0wDMdafMepV2T3dPlYNc04Bq1cdjUzpHvyIt2XW5PDCeUkokW307lzz/y71+aha6nyxT0O94EWjeDtNo3eb7Rd46phNy59CRHepoMuAcWobZtRDe9j0vozYTr0sx14IKnvnq6WRYy4M7g+To5cCKOP6zHnJAsopj2rFoSpN27rFrPzAuGOL0e975WRhXHqg5kopDKcvd0y3n/FvjzYim4Z8zLL93nZa27f8EfSdyKf6z6SlHNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpO9/kHgt5lQqvEZN6z0C5uXeNCD/YBHHoLkobmvq7w=;
 b=KqMEkpAOpjI363Vk8Ysgwsz5Lm+aPG6nD+2bB6jteHLnZsssyFOIlrp6qC03PyT+0+UsmUdZscNUbKl2Ce7IsEBH1WpktKj4OW/KWS9SMS12sjl8DMB06XfUHmNNuXwuWoNmzPcAjjA5q5RmxHv/hM98SzYJofPXnGRIIKJP1lFRrAU2TcYpK6Lhm2fTslF60TXQSw/fYXiwvra85hgGiFaQZxeFpwbRXxjtgYy7hmTkwueNYGjshA7pOLw10NkognC/iFleXllyUBNbBxxhOVx/8xJeloP7BaxKa8H7ru6ba+F//YwHVBGjVLFbXr2CKL7IPmBvgpuazrXx+EnlkQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB4P189MB2167.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:379::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 06:41:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.20.9846.031; Wed, 6 May 2026
 06:41:58 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?Q8Ohc3NpbyBHYWJyaWVs?= <cassiogabrielcontato@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com"
	<syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com>, Jon Maloy
	<jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net] tipc: avoid sending zero-length stream messages
Thread-Topic: [PATCH net] tipc: avoid sending zero-length stream messages
Thread-Index: AQHc3Rc1c/sP2rnzUEqXCsEyfUxhbrYAidAg
Date: Wed, 6 May 2026 06:41:58 +0000
Message-ID:
 <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
In-Reply-To:
 <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB4P189MB2167:EE_
x-ms-office365-filtering-correlation-id: 49487193-9d77-4deb-a49a-08deab3a924a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 YCy5MeJIiNJ1PUAQRoXwZnMvEk87sKFqv9fIxR0pH02pN5lHFDNLjOd/vINqlOMVPFo1NCJek7znspMHL019q0EAM4lx6EvKi+Z/fgOwEenmgJi3JEozY29Ct/RUaLkT53dWvZDnr9uEwQ3p3zS6o98+Ub4UYDLdYTpfPAU0e+G+UNvRP/AliUsrMHNigIw+S3LdAOxXjrmtBGyYtHSdDkZwtFiregNPl5fV2tzHRx3RnJw+Cc+SDrbojUDBE1YhiK1ep8AGfggfzyGRNxqlA65a3tXbkZmYqYJmXvq1OeIvY5bvWJU9GcXe0XTPNiDKJmZfH/z7JPRI0Ib/p/StlImAWs3MJZRPY1lPPWwJqFrvol0LJ2PrTO+Nj+iIqKNBo9vawNaseHsVrq3gn/lLtBSv0jriJBI/8g3wH9FA/l9Yme3bkyV0/2vu+4851eZAAf7Uf72YaZVi9xFNW/4OJ6fQQ47/xNTtJP9DnfPJZYxe3r5z6UHYHeb0g6Kv4Wl2xunkv6e8yTwCcOHlgHWtEu968UwTqTaJeGisBv2FHDujImCUbAhNwdDwiSElWLGRhfRQwrLqm/8p1KNvEYK7ZWpUaknfrvxlB5dfzn+0NXsBRHceg0TdIusUZwLs12gzrmOqLoRRuqsVq+y4U/nAf2fKrDBmN2vZ6yReHIkfdqSaQHl1MOjwaUHcsLTeNeRE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnQxWHlQZmlEeEh6aXBNcWFWeGxmQmFScW1abFl5dFd0QXBwUENsT1k4VEhK?=
 =?utf-8?B?RDZ0T2N6aTlxaUlraXBJWi8vRGIxUjBpT3BqMEZBMHlIMW5PcGdMSlAvN0Nh?=
 =?utf-8?B?dkJjQlJ6eWhXVmNFY1NmbHdSZityQTZpNktxYVlTQjdQNGZrb0RIdVV3OEZ6?=
 =?utf-8?B?MmxoT3pOaWhIUG5QaHIrc3Uwam9Ocyt2Q1NlNThHeGFNb3NwSmg2MEExcWkv?=
 =?utf-8?B?REtHQUcyNGNtMUtBaHFoWTg3VU5EWjJpcjRyVjhmcldrQ1RMMi9xYS9wa05z?=
 =?utf-8?B?YUcwSmc4d0x6U1l2M2orbzhGQTZ4cHRNZEpPb0JMT1lGcGhEYjM1ZHNWNE54?=
 =?utf-8?B?cTlZaUFScG8wUGU3c24zNzQ5R3pRYXpqdk11cmJRL25TZ2g3T2ZmSlFkenJw?=
 =?utf-8?B?WlNGZVhNN1Q3dmttYWs1NUZzNnZDeWMxejZuNFlDWVZIL3VWRFhuQTZYbmR0?=
 =?utf-8?B?aTlicjNrbGxnUlo2TzZpZlBkV2cxMy9XMXI3TDRYQ3RuNDBNZXlhcGpPUEVY?=
 =?utf-8?B?MStWN3VJTytmbjBqU2QyTjRPeG1MYjQ0TlVaZ1M4cmRmK3JrNFRmVG8xUUxP?=
 =?utf-8?B?Q0ZNbzhWYmRXNDBoQ3dvNFJVOCtqWm04L2hVVHIrSVB5d2lPNFljeXE4bkJU?=
 =?utf-8?B?LzJ4R1BKQmMvTm5Ua0dvczBrZWFseUtzNExlRUJ5VDkxaW15T1FJYWg5Y2po?=
 =?utf-8?B?WjcrSGhsdTBWRnEvNU82WDYraWhNZ2NHMkIyZ0dNTzJYcS9mT21Kd3d4U1J3?=
 =?utf-8?B?T0xmcGJ4N1V2SnY0bHBBWnRqdU5OcHB2OGtuNkZnNldUVkJZczZRanFGRVg5?=
 =?utf-8?B?eXkySWtaVXltOXl6T3lncWxlUnlzNjR2NXQ2UjdJRWN4ZFd4TTc2WHRnTFVl?=
 =?utf-8?B?bW15c0RNdHRLc3FVQUprVDltK1E2bTNpQlIxOVpxb200c3lsM0EvTzdnQnpN?=
 =?utf-8?B?dDVxTzU0ckE4QVdKV09mU0V3U2xQcDVPMkRYaHRLcGUyYU1jSmhIVkpLbkRm?=
 =?utf-8?B?Vmg5OGhDWUxaQVJ0UTBCWFgvVkVGK1B1QTkxWElVK1QvYnFMdXMvd0M4dFdB?=
 =?utf-8?B?ZzMwRm9KWTBqbnNsUGNZbGRrR2ZhNjNPUGN2TkMzNjRjRjJFVy9tVktweFVN?=
 =?utf-8?B?NGltNm1PeHJ5UTI5VUN0b2g1QkdnbG1QVG53N1RYdnlHNGdUeUZNUG80QS9T?=
 =?utf-8?B?VjZYOWxaVmhjUXhYaDdDUm9ZeDRKL0Q4RHJZbkFpVUFCY1V0TWtRdEtMM0Rm?=
 =?utf-8?B?NVRvaGlwTkp4UldvY29xeXFiYnFjYUdxMUI3Wm1LSE5mZ1k1MzljS3QvQ2xm?=
 =?utf-8?B?Ly9hSzFYajhxQUtZMWFYVWljRTNnOEdhcnpTUGJtQlA4UmU3cmF1d2tyb2Fa?=
 =?utf-8?B?T1oydWhjbm5lSnRPelVyeWFUVzVtRkl0eDFZZHF5QTBTNEd5UUxRaTY2UGJH?=
 =?utf-8?B?UEdRV3UrVlhtMGkvL1hQZVpCUGZvR3dvZnhGYWdYb0NGeUFJNmQzRXlZbWNx?=
 =?utf-8?B?cUJWbUtHMFd2RGVNNEJrV2swU0RkUUhKZ0JjWGllcktUZDVnYWlMTTRBTFZF?=
 =?utf-8?B?NWxoQWdDMWlLNk1rVHlRNWV6bDRJNXMwODNrYThuS2pvaFdoMCt5UU9CT1M1?=
 =?utf-8?B?NWpUcU9jN1JEMnZRVWluS1hpeCsreTFjcnAvTnppRVNhRVljaVlpUzQ2N1VM?=
 =?utf-8?B?QnpLcVdzWVJPSkRMRjFGMTErbVdHUW9QbmFEaUFwSFBrNWgwWVB4NWFuSlF5?=
 =?utf-8?B?NjFXTUJIUU9tcTU5WTVOT2dFODlIbDdFSXZ1OGlYUk95aE5VWVVNbWxVS2pF?=
 =?utf-8?B?NnhTRy9EaFBUR2RPSzdYaFIvUlBHUXd0TFdLL0JFS2V2S2pEZ3pHSzIwWElw?=
 =?utf-8?B?NmlBY2hETHplMjlPS0pZS1JweGgrSEtJbmt2d1c0RjRTSlFaOWYrRXRCNEdF?=
 =?utf-8?B?VmsyYlUxOGtXNXpGQzJJcW42L2pRYWxCc1lwaFY4U2FsWmFybTR3M21WcXFW?=
 =?utf-8?B?b2Y4UURicVVQZ2VVT0VEN21hbzROTUlrWVR3REplYWRqOG5HazdUMnllTHIx?=
 =?utf-8?B?VVVHdVFUbXZEM1B3Sk9ybmxGYzhvN1JFYlBvRlZCL2tMU0FpV1ByUStWRHlr?=
 =?utf-8?B?U2dVKytUd3FCVEV5eWV0c0FrMG9QV0lIL3JNUXpwWUFvUVRnM0F3c1UrSURQ?=
 =?utf-8?B?cU82bUE5WkJ4bGZUZEpGTGpnaXQzYmZVY3Myd2pRa3g4d1huYWZhbzlxWWRh?=
 =?utf-8?B?RXBOaTVydVNpdlAvV1hTVENQQUVudE9RSHliZkVDR3k1OElOUlNLekdxaVU5?=
 =?utf-8?B?Ukd6ekI5bmoxOUxtUTg1SGtndjhTcWpkUVcvc0tOZXptSW1UclY4Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49487193-9d77-4deb-a49a-08deab3a924a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 06:41:58.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7mJ+lCf1WaNNHIHs3ZL4lDQKuQYI0ppz7LRtXed5RKfZ25vZR8RRl2+wZAo3iT0CeHSt8+Nph30tJB/Go92i/zAjSwkFqeI1mNrBmw0kME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB2167
X-Rspamd-Queue-Id: 130944D6B42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244322-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,aa7d098bd6fa788fae8e];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,est.tech:dkim]

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IGF2b2lkIHNlbmRpbmcgemVyby1sZW5ndGggc3Ry
ZWFtIG1lc3NhZ2VzDQo+DQo+VElQQyBzdHJlYW0gc2VuZCBjdXJyZW50bHkgZW50ZXJzIHRoZSB0
cmFuc21pdCBsb29wIGV2ZW4gd2hlbiB0aGUgdXNlcg0KPnBheWxvYWQgbGVuZ3RoIGlzIHplcm8u
IFRoaXMgY2FuIGJ1aWxkIGFuZCB0cmFuc21pdCBhIGhlYWRlci1vbmx5IGNvbm5lY3Rpb24NCj5t
ZXNzYWdlLg0KPg0KPkZvciBsb2NhbCBUSVBDIHNvY2tldHMsIHN1Y2ggbWVzc2FnZXMgYXJlIGRl
bGl2ZXJlZCBzeW5jaHJvbm91c2x5IHRocm91Z2ggdGhlDQo+bG9vcGJhY2sgcmVjZWl2ZSBwYXRo
LiBXaGVuIHRoaXMgaGFwcGVucyB3aGlsZSBzb2NrZXQgYmFja2xvZyBwcm9jZXNzaW5nIGlzDQo+
YmVpbmcgZmx1c2hlZCwgcmVwbHkgdHJhbnNtaXNzaW9uIGNhbiByZS1lbnRlciBUSVBDIHJlY2Vp
dmUgcHJvY2Vzc2luZw0KPnJlcGVhdGVkbHkgYW5kIHRyaWdnZXIgYW4gUkNVIHN0YWxsLg0KPg0K
Q2FuIHlvdSBkZW1vbnN0cmF0ZSB0aGlzIHNjZW5hcmlvIHVzaW5nIGNvZGUgPyBJdCBpcyBiZXR0
ZXIgdG8gcG9pbnQgb3V0IHdoYXQgY3VycmVudCBjb2RlIGlzIGZhdWx0eS4NCiANCj5NYWtlIHpl
cm8tbGVuZ3RoIHNlbmRzIG9uIGNvbm5lY3RlZCBTT0NLX1NUUkVBTSBUSVBDIHNvY2tldHMgYSBu
by1vcA0KPmFmdGVyIHRoZSBleGlzdGluZyBjb25uZWN0aW9uL2Nvbmdlc3Rpb24gd2FpdCBoYXMg
c3VjY2VlZGVkLiBMZWF2ZSBpbXBsaWNpdA0KPmNvbm5lY3Rpb24gc2V0dXAgYW5kIFNPQ0tfU0VR
UEFDS0VUIGJlaGF2aW9yIHVuY2hhbmdlZC4NCj4NCj5GaXhlczogMzY1YWQzNTNjMjU2ICgidGlw
YzogcmVkdWNlIHJpc2sgb2YgdXNlciBzdGFydmF0aW9uIGR1cmluZyBsaW5rDQo+Y29uZ2VzdGlv
biIpDQo+Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj5SZXBvcnRlZC1ieTogc3l6Ym90K2Fh
N2QwOThiZDZmYTc4OGZhZThlQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj5DbG9zZXM6DQo+
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzAwMDAwMDAwMDAwMGNlZGJjNDA1YWU4MTUzMWZA
Z29vZ2xlLmNvbS8NCj5DbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9l
eHRpZD1hYTdkMDk4YmQ2ZmE3ODhmYWU4ZQ0KPlNpZ25lZC1vZmYtYnk6IEPDoXNzaW8gR2Ficmll
bCA8Y2Fzc2lvZ2FicmllbGNvbnRhdG9AZ21haWwuY29tPg0KPi0tLQ0KPiBuZXQvdGlwYy9zb2Nr
ZXQuYyB8IDIgKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYg
LS1naXQgYS9uZXQvdGlwYy9zb2NrZXQuYyBiL25ldC90aXBjL3NvY2tldC5jIGluZGV4DQo+OTMy
OTkxOWZiMDdmLi4zYzc4Mzg3MTNkNzQgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvc29ja2V0LmMN
Cj4rKysgYi9uZXQvdGlwYy9zb2NrZXQuYw0KPkBAIC0xNTg1LDYgKzE1ODUsOCBAQCBzdGF0aWMg
aW50IF9fdGlwY19zZW5kc3RyZWFtKHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+c3RydWN0IG1zZ2hk
ciAqbSwgc2l6ZV90IGRsZW4pDQo+IAkJCQkJIHRpcGNfc2tfY29ubmVjdGVkKHNrKSkpOw0KPiAJ
CWlmICh1bmxpa2VseShyYykpDQo+IAkJCWJyZWFrOw0KPisJCWlmICh1bmxpa2VseSghZGxlbiAm
JiBzay0+c2tfdHlwZSA9PSBTT0NLX1NUUkVBTSkpDQo+KwkJCWJyZWFrOw0KVGhpcyBjaGFuZ2Ug
aXMgd3JvbmcuIEl0IGltbWVkaWF0ZWx5IGJyZWFrcyBub3JtYWwgY29ubmVjdGlvbiBzZXQgdXAg
YmVjYXVzZSB0aGUgQUNLICAoemVybyBpbiBsZW5ndGgpIGhhcyBubyBjaGFuY2UgdG8gYmUgc2Vu
dCBiYWNrIGZyb20gdGhlIHNlcnZlciB0byB0aGUgY2xpZW50Lg0KUGxlYXNlIHRyeSB0byB0ZXN0
IHlvdXIgcGF0Y2ggYmVmb3JlIHN1Ym1pc3Npb24uIA0KDQo+IAkJc2VuZCA9IG1pbl90KHNpemVf
dCwgZGxlbiAtIHNlbnQsIFRJUENfTUFYX1VTRVJfTVNHX1NJWkUpOw0KPiAJCWJsb2NrcyA9IHRz
ay0+c25kX2JhY2tsb2c7DQo+IAkJaWYgKHRzay0+b25ld2F5KysgPj0gdHNrLT5uYWdsZV9zdGFy
dCAmJiBtYXhuYWdsZSAmJg0KPg0KPi0tLQ0KPmJhc2UtY29tbWl0OiA5NTA4NGYxODgzYTc2MGUw
ZDQyOTA2OTgzNDY3NTlkNThlMmI5NDRhDQo+Y2hhbmdlLWlkOiAyMDI2MDUwNS10aXBjLXplcm8t
bGVuZ3RoLXN0cmVhbS1zdGFsbC0yYzM3NDFkZTJjOTMNCj4NCj5CZXN0IHJlZ2FyZHMsDQo+LS0N
Cj5Dw6Fzc2lvIEdhYnJpZWwgPGNhc3Npb2dhYnJpZWxjb250YXRvQGdtYWlsLmNvbT4NCj4NCg0K

