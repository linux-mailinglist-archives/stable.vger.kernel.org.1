Return-Path: <stable+bounces-235309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJDSCyVD12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6D3C67B2
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B643303C422
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185033101B8;
	Thu,  9 Apr 2026 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="DVzgxEJa"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022086.outbound.protection.outlook.com [40.107.40.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDB4A3E;
	Thu,  9 Apr 2026 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715041; cv=fail; b=gHL2dvwEmDBtHijxu5HvJbTOF4gtStStGGQennrPfaxTw+Bsjr+yW+bK4swz6YMscvbvcH73RuISaAJWeMnhjLqMK/n6JHmaQhpf1aOMFbZdA8iXuJbeDfR5LtwdXD2CjEYUdYPX03HAA0RkAWmyZuOeQDNoEFnFT9sfUIi8bgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715041; c=relaxed/simple;
	bh=fCKOAEO3P0w1vLmb/lHhQNnyPexeb9/R9CqRLF8SeNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llJYJ9/gGxo+H2x9Zz3Js5gDFy9Tt+fdHwa689c51/Qs73CdSfcSklSttZcVz7cqv1zNHIrITUCmh/V9O4D0AKhpiyrI25BrDJJ4E6qGBtLs5qehQf++qDIwNOPqb1JA/ro/etnbCSRZZBEkui+xJKJUVLw+bTBuJlRepnzgJ78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=DVzgxEJa reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TawbKXMLZ2zl285gKMdKt8gdEVA9Sk0oxGy5UYPJUyxphIrtTmm9ES+JZsD5EJtn7oP99DpuLl9orTMDoPrWWOUVJA2njjvFT4Y2Cl3s77Ba/uXJRKxFrkhCchIAFVKXuS+Rqm+sRhsqiT43vd6u7cx/WJfcN8erpkXVry7z2bCQJtbCQEEVBS/9bfyaZlantN3bTZZ5q4bTL3FyfrFIlCyYDDkx/ZIqDnE+ceLslvZibE8WU+2wGZlEIBURd6CdLCx+eU1O+9+LQ54hL9lk/1l15hMcKbS7xfv9bThSsTyGut2+yow0mR6rGJ3ju9cNkhaahW/hyl8qNtLqwy2zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIJgzL/u4JC7+8sRK0EMCl8ssas/wjNMtwycnQH1bfk=;
 b=jchN+YGlYMYpoR5VwbHz2AJbSnytEeBZnTTwTgOUfp5JY83VowNJzjdCqniAMp48kkTu1+yMK9DUGDqd2sG6mZPtMNsXHFshWPkp+d/pyiOCTb20beq1g+S2BztR2Cn9yxhbdEUIuVVyWXiHpPw7bfvp6FVDkYFqjiEh6/pmfviKa7dxGwFdrjE12ozkoQSNRlrFN8i2dAyzufP8zAmICdrn15oUjd0xy2e4TVk99g1J+7+v/4JE44KOaC8RxQDXedaDtS+nwSaDql88g2/VcUsfor7pPkHSrlaLXzne/RV3sGo/WkJGJPswY/rdPqWwXPa0rYX7gIUWrrxqFO6EzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIJgzL/u4JC7+8sRK0EMCl8ssas/wjNMtwycnQH1bfk=;
 b=DVzgxEJaHZ1LPJ1/kyNBMqbORFNGNI8xZcQnpP7nAqg4HjOOcfq3odeaJT/B4bIn7DOxAs0l34ZvFaDUA73TNeXByrp03HnTmvTifXkPAlQWxxBg8YE6lt3QoGutQjXT/8ri3BMPZDh3nrSV82B6Jiq3BJtqfIeP70vZ9Tn0WJB3jXk/lFOXls/KWY3SWVEJdvxzYzPhl1kVnCqAdD6zaCFcG18BpGpNf6HgYnL71weUpwR0/NCaJhVg/5+R31/00+zd2ncba8xLKFBFAPj/kS/wY+xqPhSofOLyyOjNsimUrXZmYv1IDBOZD0MC3w/4kSPA5S1d1MvU3uK50DsK1w==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY7P300MB0218.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:235::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 06:10:31 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Thu, 9 Apr 2026
 06:10:29 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Werner Kasselman
	<werner@verivus.ai>
Subject: [PATCH v2] bpf: guard sock_ops rtt_min access with is_locked_tcp_sock
Thread-Topic: [PATCH v2] bpf: guard sock_ops rtt_min access with
 is_locked_tcp_sock
Thread-Index: AQHcx+eQDTDmE7ol90u8LpJWPxuBdg==
Date: Thu, 9 Apr 2026 06:10:28 +0000
Message-ID: <20260409061026.3926858-1-werner@verivus.com>
References: <20260406224953.2787289-1-werner@verivus.com>
In-Reply-To: <20260406224953.2787289-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY7P300MB0218:EE_
x-ms-office365-filtering-correlation-id: 73179e39-45d1-42c3-6dd3-08de95feb2e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 2AtUOYXEiQQv7YVBmMaeBmM9foIcDsFaxMT8h05/u1nfp67XJTzr9AXfW8k4tAcbyBg5U913vmcwmbVMqn2F69xel1J2+SX8hEsiZ5oW9u4BODu9/usgnIR39DuAtuKoU7jFWEsptsZsQgmczpEjr1r25iAMNxOSJO6a5td71LF3ZxttbR6py3ZOlP3/tTQ1Bc+2dnGbJfaeRNKFGagImGpVOCFYaU10S0axPwGadiAn/9kD0VRreS7Y7HymQdHkmZc/GdPW51p9dq+6r8x+f5E84FSsWQhOe+JNQBMJdgX6rGwuDHr3TaNYcfqAIDiDo0PNyAyLWoB4ew55G/Ihb+A932uluCumqXSlOSvVsWIzwwLfvZT1IMmsmLyxQ1lh03FUegQFj6fiMZOBAIi3SN9fup6o6fWwkw1kndted3Bcn6JXMLQnpjrui9zPaHeq5sW3yg+AFzbGo3PHR4dVxfYW/tKsgVel36BRZgweGaQOSyhxO+pF+YRoo2XN2EooDwsX/BB6MucOnFXTVJr1NnZ/vZ9uD8cFVzmdAU1CQ3gfkkRP0Imj7JOYGqemCy68Eym2i5B2lc+SUCZ47tSvhfDRO3k/gSH5oIKmlCNVdW2Xz7eWanD5gW4gtvxdrUVyiTRq94jmelh7yk7pfLibGkb2rUUjsiPsYFxM/XA/jNxSMrAbFPrD607m1oEvqmfp2jbNe2tlkNgoIJf651huD6VvhEButTAvRW5tj8x0uA5yXHKXmOLBnqdmamigLYTOv04WyepdArDFGL075jOcpnB6Ak7TOLWwgHnXvYw9tzw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OOxFlQBJuLtsM0w1seOyrayn2Wf9aUY+3CvA0AvX5SVtL5h80/vmMZYnik?=
 =?iso-8859-1?Q?u77u9lASgQRF2b4gMqBu7ieTFu0jYXJ6A2lAoFHzb/73aRgSJ8IMAjQqv/?=
 =?iso-8859-1?Q?V6TlJKc7McL2NGj/wQhZHu5Qek3Zb8OqZIpMYB7ZySggYSreaSnkLoorON?=
 =?iso-8859-1?Q?LPLUJOOhp0+GxoP8TEzxJwThwUND1OY/uKrtztyL3N/4dyDz5MP5heXP56?=
 =?iso-8859-1?Q?3988kq1Y15/n7IHCzWmbb1eYjpJU13jN/9ym94/Y/JCL9dtLEZDRUmtEQx?=
 =?iso-8859-1?Q?Np0XAvNrEJSDW7mkcm7zoXLGWM7Bom8l+AF91CRJ4Y+7EpoJisQwOOHYCF?=
 =?iso-8859-1?Q?4yHMZVPy3robFtuvNqXc+GH2EYT3xtuNwzT6FuOoAal+TD+abpWcakCZhO?=
 =?iso-8859-1?Q?9SrBNka1kKZTFCJr8+bi7pyClvlcL+1QogKh6zU3hZCXYpZFm7utDzLD0I?=
 =?iso-8859-1?Q?TzuiK3yJT7vceYD9eVDhOVqqV/bNOte2h41pWFJc7tcJSES61r6ZRAZeP7?=
 =?iso-8859-1?Q?pw6wm1o3nOqcJlTNYwbsIeF9fbgU6ZhD6xfyh+8BktgXfoLVqwafLAVU67?=
 =?iso-8859-1?Q?2zc3dGco1wbqvqpixa3IRUXM6r0XbgVaVxmlMtmC1rTW/zp08UDHFnCfyQ?=
 =?iso-8859-1?Q?Yw+cN8pRTHq6Zmd1Q6cq9Ug9yKqW72eAs6l1waExZhb+0bIxXBALsNYq/U?=
 =?iso-8859-1?Q?A4URgNMgu0UvAEMJsjV/ZIxQi2TueVoNAnVLm+HMSOrEt+9OAYneKmsUUz?=
 =?iso-8859-1?Q?WWZd1x9rD9i4kER4zIzzE3bmY/0Hlwp5e4bglPN09w310agcHZwmmpY3eZ?=
 =?iso-8859-1?Q?fwUpFCedDzTrtpaE2c8YLa72POUPT7tIhaYYpdE0KnR1uRHcx7s2zrilX3?=
 =?iso-8859-1?Q?2GmIoUrgB+ZPcxmNQPZSBubUHitj+2BbAWpx0BacRaESD37J7qPunevNeJ?=
 =?iso-8859-1?Q?GHq1oJ4n4X7msL4DHw8JXxHeODRO9/vMhvG+i8FtHBQJIU7UxXC/UJ2hDn?=
 =?iso-8859-1?Q?Dizq5nE5Xy3/m/q5hoSQNvn1+dCkzKA5j/IhXEFXHGC40ox8nCPnWyP4bY?=
 =?iso-8859-1?Q?rkk6Eiu90jP3U/ZXef2L61+Zj41CsN4rppSghMOeCEVFixFdZ7rITqnUpK?=
 =?iso-8859-1?Q?52rddhUJx7BMk5nzoAy9xluHFe6jBvS63Ntvu+cOLxuoIvqyUme1s6UX50?=
 =?iso-8859-1?Q?wgr2nZmH9aH4iPeRS1f1+T6VaG66mVQdWNKiqx17Z5GUpYDkr0ZFEPoEJF?=
 =?iso-8859-1?Q?toLtIAzIWxf+xCud77fxlddUwaLBQNJTZIEXIC4YSriaOz5AtVt3B6uP49?=
 =?iso-8859-1?Q?9TyzmtovUQFbNG1bh7s2NH+3wujdv/wh8YRZnnjHyxSBcCEpSRoXxSIszQ?=
 =?iso-8859-1?Q?vxf3mGpSSrchKgvijaOn5LJIunFR7rOKCNm6dzPyXG8hLU6mzn/EFDH8vC?=
 =?iso-8859-1?Q?ew8rvNwGB6czbl5z1Gxt21uFdodA/TF97v+FtVwu75F9daFP7GJM4GGkoI?=
 =?iso-8859-1?Q?wr2OYS9acaiwsVscCKvjgw/2V1BLdbLexz4iMxdvyOaLOiazgecNpomlSx?=
 =?iso-8859-1?Q?IxEDEH/P9uHUMEqOiX+JX6CRxLm+NVCX31Rr9q2Zn7lkrxTBvuZ62PouSs?=
 =?iso-8859-1?Q?6JP+OAJc8PLRkJxtjOGCOH8JqVuiO/XBuntNII6/i4TaMvZoDvi1U7hx1I?=
 =?iso-8859-1?Q?ExVnhe3iCeVWXIeW2E+c6sD+iUqN6AdJ7tSe/YyG/GzEa//3PZUyb9Nzt2?=
 =?iso-8859-1?Q?L+6OB0kJWvcrv7aiaOOlXowoXNvQKodPUN2aCvWPu4yVjfw5W3M2plXyLy?=
 =?iso-8859-1?Q?nyu3kp0aNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 73179e39-45d1-42c3-6dd3-08de95feb2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 06:10:28.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1yBI4VIWIbpQsjUe7RQfFarJgvIVe7R/L6vTg5yWGqiNqKuO0IhMdhDqV5VgbbmRoKFzoOHxxuEL3Knf7Aelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0218
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235309-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.514];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sock_ops.sk:url,verivus.com:email,verivus.com:mid]
X-Rspamd-Queue-Id: 9DB6D3C67B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() emits guarded reads for tcp_sock-backed=0A=
bpf_sock_ops fields such as snd_cwnd, srtt_us, snd_ssthresh, rcv_nxt,=0A=
snd_nxt, snd_una, mss_cache, ecn_flags, rate_delivered, and=0A=
rate_interval_us. Those accesses go through SOCK_OPS_GET_TCP_SOCK_FIELD(),=
=0A=
which checks is_locked_tcp_sock before dereferencing sock_ops.sk.=0A=
=0A=
The rtt_min case is different. Because it reads a subfield of=0A=
struct minmax, it uses a custom open-coded load sequence instead of the=0A=
usual helper macro, and that sequence currently dereferences sock_ops.sk=0A=
without checking is_locked_tcp_sock first.=0A=
=0A=
This is unsafe when sock_ops.sk points to a request_sock-backed object=0A=
instead of a locked full tcp_sock. That is reachable not only from the=0A=
SYNACK header option callbacks, but also from other request_sock-backed=0A=
sock_ops callbacks such as BPF_SOCK_OPS_TIMEOUT_INIT,=0A=
BPF_SOCK_OPS_RWND_INIT, and BPF_SOCK_OPS_NEEDS_ECN. In those cases,=0A=
reading ctx->rtt_min makes the generated code treat a request_sock as a=0A=
tcp_sock and read beyond the end of the request_sock allocation.=0A=
=0A=
Fix the rtt_min conversion by adding the same is_locked_tcp_sock guard=0A=
used for the other tcp_sock field reads. Also make the accessed subfield=0A=
explicit by using offsetof(struct minmax_sample, v).=0A=
=0A=
Add a selftest that verifies request_sock-backed sock_ops callbacks see=0A=
ctx->rtt_min as zero after the fix.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c                             | 53 +++++++++++++++----=0A=
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |  9 ++++=0A=
 .../selftests/bpf/progs/test_tcpbpf_kern.c    | 21 ++++++++=0A=
 tools/testing/selftests/bpf/test_tcpbpf.h     |  6 +++=0A=
 4 files changed, 79 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 78b548158..5040bf7e4 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10827,16 +10827,49 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 	case offsetof(struct bpf_sock_ops, rtt_min):=0A=
 		BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D=0A=
 			     sizeof(struct minmax));=0A=
-		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
-			     sizeof(struct minmax_sample));=0A=
-=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
-						struct bpf_sock_ops_kern, sk),=0A=
-				      si->dst_reg, si->src_reg,=0A=
-				      offsetof(struct bpf_sock_ops_kern, sk));=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
-				      offsetof(struct tcp_sock, rtt_min) +=0A=
-				      sizeof_field(struct minmax_sample, t));=0A=
+		BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, rtt_min) !=3D=0A=
+			     sizeof_field(struct minmax_sample, v));=0A=
+		off =3D offsetof(struct tcp_sock, rtt_min) +=0A=
+		      offsetof(struct minmax_sample, v);=0A=
+=0A=
+		{=0A=
+			int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;=0A=
+=0A=
+			if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)=0A=
+				reg--;=0A=
+			if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)=0A=
+				reg--;=0A=
+			if (si->dst_reg =3D=3D si->src_reg) {=0A=
+				*insn++ =3D BPF_STX_MEM(BPF_DW, si->src_reg, reg,=0A=
+						      offsetof(struct bpf_sock_ops_kern,=0A=
+							       temp));=0A=
+				fullsock_reg =3D reg;=0A=
+				jmp +=3D 2;=0A=
+			}=0A=
+			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
+							struct bpf_sock_ops_kern,=0A=
+							is_locked_tcp_sock),=0A=
+					      fullsock_reg, si->src_reg,=0A=
+					      offsetof(struct bpf_sock_ops_kern,=0A=
+						       is_locked_tcp_sock));=0A=
+			*insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);=0A=
+			if (si->dst_reg =3D=3D si->src_reg)=0A=
+				*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=0A=
+						      offsetof(struct bpf_sock_ops_kern,=0A=
+							       temp));=0A=
+			*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
+							struct bpf_sock_ops_kern, sk),=0A=
+					      si->dst_reg, si->src_reg,=0A=
+					      offsetof(struct bpf_sock_ops_kern, sk));=0A=
+			*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
+					      off);=0A=
+			if (si->dst_reg =3D=3D si->src_reg) {=0A=
+				*insn++ =3D BPF_JMP_A(1);=0A=
+				*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=0A=
+						      offsetof(struct bpf_sock_ops_kern,=0A=
+							       temp));=0A=
+			}=0A=
+		}=0A=
 		break;=0A=
 =0A=
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):=0A=
diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/t=
esting/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
index 7e8fe1bad..d243d6713 100644=0A=
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
@@ -42,6 +42,15 @@ static void verify_result(struct tcpbpf_globals *result)=
=0A=
 	/* check getsockopt for window_clamp */=0A=
 	ASSERT_EQ(result->window_clamp_client, 9216, "window_clamp_client");=0A=
 	ASSERT_EQ(result->window_clamp_server, 9216, "window_clamp_server");=0A=
+=0A=
+	ASSERT_EQ(result->timeout_init_req_seen, 1, "timeout_init_req_seen");=0A=
+	ASSERT_EQ(result->timeout_init_req_rtt_min, 0, "timeout_init_req_rtt_min"=
);=0A=
+=0A=
+	ASSERT_EQ(result->rwnd_init_req_seen, 1, "rwnd_init_req_seen");=0A=
+	ASSERT_EQ(result->rwnd_init_req_rtt_min, 0, "rwnd_init_req_rtt_min");=0A=
+=0A=
+	ASSERT_EQ(result->needs_ecn_req_seen, 1, "needs_ecn_req_seen");=0A=
+	ASSERT_EQ(result->needs_ecn_req_rtt_min, 0, "needs_ecn_req_rtt_min");=0A=
 }=0A=
 =0A=
 static void run_test(struct tcpbpf_globals *result)=0A=
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/t=
esting/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
index 6935f32ee..79757a19b 100644=0A=
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
@@ -85,6 +85,27 @@ int bpf_testcb(struct bpf_sock_ops *skops)=0A=
 	global.event_map |=3D (1 << op);=0A=
 =0A=
 	switch (op) {=0A=
+	case BPF_SOCK_OPS_TIMEOUT_INIT:=0A=
+		if (!skops->is_fullsock) {=0A=
+			global.timeout_init_req_seen =3D 1;=0A=
+			global.timeout_init_req_rtt_min =3D skops->rtt_min;=0A=
+		}=0A=
+		rv =3D -1;=0A=
+		break;=0A=
+	case BPF_SOCK_OPS_RWND_INIT:=0A=
+		if (!skops->is_fullsock) {=0A=
+			global.rwnd_init_req_seen =3D 1;=0A=
+			global.rwnd_init_req_rtt_min =3D skops->rtt_min;=0A=
+		}=0A=
+		rv =3D 0;=0A=
+		break;=0A=
+	case BPF_SOCK_OPS_NEEDS_ECN:=0A=
+		if (!skops->is_fullsock) {=0A=
+			global.needs_ecn_req_seen =3D 1;=0A=
+			global.needs_ecn_req_rtt_min =3D skops->rtt_min;=0A=
+		}=0A=
+		rv =3D 0;=0A=
+		break;=0A=
 	case BPF_SOCK_OPS_TCP_CONNECT_CB:=0A=
 		rv =3D bpf_setsockopt(skops, SOL_TCP, TCP_WINDOW_CLAMP,=0A=
 				    &window_clamp, sizeof(window_clamp));=0A=
diff --git a/tools/testing/selftests/bpf/test_tcpbpf.h b/tools/testing/self=
tests/bpf/test_tcpbpf.h=0A=
index 9dd9b5590..46500c1d6 100644=0A=
--- a/tools/testing/selftests/bpf/test_tcpbpf.h=0A=
+++ b/tools/testing/selftests/bpf/test_tcpbpf.h=0A=
@@ -18,5 +18,11 @@ struct tcpbpf_globals {=0A=
 	__u32 tcp_saved_syn;=0A=
 	__u32 window_clamp_client;=0A=
 	__u32 window_clamp_server;=0A=
+	__u32 timeout_init_req_seen;=0A=
+	__u32 timeout_init_req_rtt_min;=0A=
+	__u32 rwnd_init_req_seen;=0A=
+	__u32 rwnd_init_req_rtt_min;=0A=
+	__u32 needs_ecn_req_seen;=0A=
+	__u32 needs_ecn_req_rtt_min;=0A=
 };=0A=
 #endif=0A=
-- =0A=
2.43.0=0A=
=0A=

