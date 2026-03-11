Return-Path: <stable+bounces-224626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH2SA2nNsGkKnQIAu9opvQ
	(envelope-from <stable+bounces-224626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:03:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46125A95C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D614305B36F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687862DECBF;
	Wed, 11 Mar 2026 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="bBGLQIsh"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7FEEBB;
	Wed, 11 Mar 2026 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194595; cv=fail; b=BltteZwY4vIOscmxRTLb6fpSEseU8mRD+SMrYo+q24HTmKUznVzf8hfHDlltRXSpKU1NzDr6fLmshVyzd8RcURqTW7s3dKs2jjy6hMNJL1LMf1XEEIdgDVyPRmmNX/2/LT2dt5eoH5QtapIzin8ou7B6dnrzeW01+Q52/taBMNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194595; c=relaxed/simple;
	bh=zCkQnqjEdTnThZp5iUm352CnfMSkFN7zqIDao+55ico=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I7ng5VSKVWLMTUwvjP//PLJ7xW6dcUVjRh3PKFoZj6E/OPcX4v1s+BpJsIFChq1Ez7T4F6KZfarNDXloUzTqJuTbu1AD5tFoM/tkM2rWLSNyo5q61nyYFPHxhJ5MmnwB2YdIWISHrL641ZkQePE975PXxVo/ASJiGSlC95njhFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=bBGLQIsh; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNtQNHagdu2e6t5hphfZzBXKlxP32oi0Mt1M69JILzkw6xZc3yJ/CQIT47Q8vJOPvvIKs/cggAsNkFKS93hBBsZzMR8b4ras+yrXkVHZYuftbYst8JHs5TKaqi4Mbx9/jO8TFf+YFzveCEZ3C7RhC2NwW9WBb9+n0dDkF8aD5vxwOQ3TzpxycQ4s6MEaxbmujkPNTRSYtyreHl0LgTyuRjUiDQukCq6FzwM8jwsP8jmy850wZbv6EAbIEw7uyxMvme+Orvf8m8Z/PTiCYxROYd2SW8XlI/qUNBni8YLKh76IykQ6fFGqKsUmeaAbtorPcZFnBamtdH8lBz8NUEaWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE33YEvs628SX2fmLFN0onA0UK5FzzsTfp8GzGCVh2g=;
 b=rqf42WLV86mDc1HK6zVMs9nFPgJ8/we1PhAlgOCCjnsTojbtCo7wuyowkYYL1I5JC+D8Z+TU0W7nvNxFP8qXu0oc5UVT3NllGextIgl44AaEms6H8EUOzB982dy1GulPeJCCWjXv20AFJrL8wGJq/czHv6/LOhn4bW2bU7T+TY6dnDrlxOTNThW3voinNDYuXMcnZAsXZHcYc7WjShx/frjQagnWsY6F5noFowyUNjHALuR6xaz3qc0YjwKpFrGoYSJf/IkCrV70OU0frJxYamn3SH4t1O6rcvvausdkA6wHgPfCZBGV5mVLLHpXZJOO2MY5thwvQvYuFatd4ipGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE33YEvs628SX2fmLFN0onA0UK5FzzsTfp8GzGCVh2g=;
 b=bBGLQIshCvhTHIZxntH8KgYevIgmypb5VNSCjlx8WfyFoSU5B4rX+DXjgRYcBqvUc/mobBHx/d+6uTSS+i/mTW6tTURLF42T4sZCwKFsqmQELlBYpYqmzSx5zOfd8msJz0oO1uPavPCdxn5cQ0lOMjXTyoZJUIZyt5ESn4sQZc2YWShNP1e8RKTEJdGMfx2oslhtIJ2+OJ4q1bnxvQMchAtqFXmnyCAc8HTlMZpp63a3ypWFX0d4UZHnMlt4Hvvfgfd7VgoaJh8vPT3f34iohRz/1Vqk6zWzMo8NeZu/svBg/LYj6fPlNxJApMlkAWV2Hlt68aEX9qiPIN3pf5bgQQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV4P189MB3630.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2b8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 02:03:08 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9678.020; Wed, 11 Mar 2026
 02:03:08 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Mehul Rao <mehulrao@gmail.com>
CC: "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH net v3] tipc: fix divide-by-zero in
 tipc_sk_filter_connect()
Thread-Topic: [PATCH net v3] tipc: fix divide-by-zero in
 tipc_sk_filter_connect()
Thread-Index: AQHcsLCodQ3q/iHTiEWzp6xsU7/WIrWolHEw
Date: Wed, 11 Mar 2026 02:03:08 +0000
Message-ID:
 <GV1P189MB198885BF0A6FB7973CED2D86C647A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260310170730.28841-1-mehulrao@gmail.com>
In-Reply-To: <20260310170730.28841-1-mehulrao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV4P189MB3630:EE_
x-ms-office365-filtering-correlation-id: 9a4cf091-c4f5-4181-750d-08de7f125747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|7053199007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 EjARUujN4d5XyadzGvqF4slSD25RWZoiTN3tfQX4MjaXGhmm2B9s7bjt1h+HB4LUNUOs7tHqvtmTzj15nqDm7I6Qk/Bx4Wp2JtJDescvzYNJnTpavJrwISMsv3ijcwBVgoDyZT2KZHGVOzrw+LI2URHtxTvJty0fg9i7M3pwVvyAU3Z7j0cr/rNlY7mPHtFO+VNoOzBRSHlECJfU/rzRgD0TIgDXIGOT1ifJUHMca555aYGj1BWgzzLRNcAydcw1d7lTyv/txIDblY+4HZ7tmF1UcxslGTFnBNRMKFV7Dwcfkj0/LqSyI+SZeyoEF4fIRVVbgVaSfPZTha/GWyHpub52+ifX0msgAJTeShbCHuHyBL6PJoHU/9g7Loh4vF/uDo8+BoHrB4atIor94Si58vkj8WIUrYUOBcM1I69fFwxKHgPNUKOogHahGUeYuB5Y7HhLgRSG1ZiXPl7W5JU7eYK9O3QpwyMSBbaR/A8ke7WZc1RBbF3LRhVtlreH0fTLtMk2KttOCcpYuEQOyFP6sTxUOF5l7fXEy5AFwbOlICGghCpkF2EE0tayDm2IdJsM0L/foAr1Qd+1FHIIRs6J7R7g8aVyjTYqK6tUYmgdSXhL3sGMiW2zNDgbAPcqwUNfSejVDe7OTwX4lHvfqA7wWKSPkTL/YdHggzE3K5k94XJw2wHHj7yALXXUPh4xpcJoj8NdBtI3Q4euk+w4zv43vQV/HlM0/xOCKDcckbyh9kaK9NMnWBplbwPitBnN9rUSN+hKv9KAZyidJuZCNR97sv72V4URkUvEER4fUHHHuFM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BZR99O8oeOyviXzKNNjJYWU2g4xhy0nEQha42tzNncnrpQ3DOFc6bKVnv8Uk?=
 =?us-ascii?Q?3Tr9wR0bx6Z/gHaWnz6Lina+nYq8xzIbYl2niD6ptMXDL6sx+RCGRWrhqUs5?=
 =?us-ascii?Q?nSDgJvE9lByQrd+hYvj5W4wRsMGMQaeZvGF2LGz51qcJ+wgS9/3dl1gk8L5W?=
 =?us-ascii?Q?b2mENXXgaIv3jn9oCCo/L4KbkoAiiYsE51X+sO9kitHjGnSYM1gsJWMmry5T?=
 =?us-ascii?Q?3Tn7urlnzgsmhfgri5txXAeFgdChc1Sd2/p/XauwpXUF9VF/k8D/usxB8uoa?=
 =?us-ascii?Q?Dy6Ismx9PKbPxclolnqabGdpkxt7S6FeJp1JufkKypzTz2GQz0WL1e2lzjZ8?=
 =?us-ascii?Q?FxMhvdUI5zyrXuCUu7UZx2Y9dGg72Rxp6jrokuHuktuAPcTUDK2YTuEnA/sP?=
 =?us-ascii?Q?Lg2r7FmjjYHH1utnYt+r90ePuJREzJY1z7LepuR7Jig7kgkYzec8/S2OetXn?=
 =?us-ascii?Q?9w+gk1lSpeRNhTuoYJqvNInlHnDjr3feLk3HHFd3ntrpV4ci014QKXQ7hM9Z?=
 =?us-ascii?Q?BC5vUAb2h2FkwQuEn8cusvdBpzMBlqpkmueDY3HdV3aGPdG+OS2FeaIQk3XR?=
 =?us-ascii?Q?rDE29Bt3GSv1bK+ruIYfVV6LMlCGAr1j52eN5VBXDBRxOA6iAAcDvHfhdTZO?=
 =?us-ascii?Q?lyZ7eStUNnzmJKRxAqY1D/7nFR8ZEP1FugeRmQTVn1MbcRvOTNWx1be7Syy6?=
 =?us-ascii?Q?d0coPuyj2pkp6LMCZyP8lQLHiZOT8JQuGumXYBN4C0RgqTwv2/K3LqW9oNT8?=
 =?us-ascii?Q?pi0UsBjrFkTOKIEwzuMKlWhNcypagQIT1A/6Se8yQRUMY0sE2IJGAZzKEfFZ?=
 =?us-ascii?Q?/jh4SoqNtkrtCa8TvjGrUiyaxbQTB5/SUAiG3xurqv3UUMbA1AR/gphvmnFk?=
 =?us-ascii?Q?Z9GNszMuqhMjIMluW9ixo541TdrQPKYykGll11auxc1ga/nFNTmzfXwBMmIF?=
 =?us-ascii?Q?mq6IKRugltkcuci7pjwCGFqRB5evKXWy0u9w39o/ylME/DIE52qgLncd3UXI?=
 =?us-ascii?Q?PZKhbrr4Nf7PhiIXDiMGbG/NqF8KoXvZHnjoXU3x+CdDgCkjnHh200kUpxgQ?=
 =?us-ascii?Q?9VsDTZZWyKYFwAO6JDoEkSeQSTdLfQ9gX329SmU6GTEK6Zz04m+bkJj44jun?=
 =?us-ascii?Q?nI9LeGX6Ovxg8JprDe6tZOj8cIa7/yB8Kdp2AcloI1ZgjJMLWh+vQyUF7mO0?=
 =?us-ascii?Q?2q8i4GRrraKN+w2ly0H0ieOZuUf9bAb09VWY26Z8v06vQWnpin2eUfkFM1kA?=
 =?us-ascii?Q?c+b6QJMk2pXO7+CrmzjbrUAh4k1JBxHBSIpyU4A6qJMHq0jdDt1D4+90QIiT?=
 =?us-ascii?Q?VSJjWv79yANQSgQBFAKEMLm8KFrLABlPGijBAs95g+mdNJXo5+S2Yo5OSCO1?=
 =?us-ascii?Q?fcqaDws0PMs2nxLiDHdHU0ZwHLvn7AIjZaPn92gi5V2jkPN91+f8Pafn0x3I?=
 =?us-ascii?Q?aMMy8AP1i1v8MnvQT6Zinsf6xQxzkptU+HMmMxevoLbQrs5oE0fhB7lgtLlk?=
 =?us-ascii?Q?w6TOfhQqBkcKnbMiBkbfaB92uKQD9xtApGLnOY6ETvQ5NOIufQWswQNg5uiP?=
 =?us-ascii?Q?RGbO5aP93h92wVl/TuepYZesxKt6q6R0+oYfT/vkge1mdmzl1jpuKLhg3ubq?=
 =?us-ascii?Q?1+Tn3stmi4Ascf3DNBeoWjzGcCHaglfXt6rqVQ97q752LxXyzneFuPjAuHD5?=
 =?us-ascii?Q?tl/6OIhsYjJJWTUZvBS4DJFvEb64R5PKt8XRnlE50uJ9nxqfH9c8M8XhI0Ht?=
 =?us-ascii?Q?DSelelsOJw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4cf091-c4f5-4181-750d-08de7f125747
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 02:03:08.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ3N49gd/Ibowil3tZ7wDKmx3mAChOICgM+EfTH2cKlk82+G+jR2xQt4xrNBfPxrXYtcsk4B//jpsXcI1POPz3w7tlAKm7K8fpYET+P/x5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P189MB3630
X-Rspamd-Queue-Id: 8A46125A95C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224626-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Action: no action

>Subject: [PATCH net v3] tipc: fix divide-by-zero in tipc_sk_filter_connect=
()
>
>A user can set conn_timeout to any value via
>setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a SYN
>is rejected with TIPC_ERR_OVERLOAD and the retry path in
>tipc_sk_filter_connect() executes:
>
>    delay %=3D (tsk->conn_timeout / 4);
>
>If conn_timeout is in the range [0, 3], the integer division yields 0, and=
 the
>modulo operation triggers a divide-by-zero exception, causing a kernel
>oops/panic.
>
>Fix this by clamping conn_timeout to a minimum of 4 at the point of use in
>tipc_sk_filter_connect().
>
>Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
>RIP: 0010:tipc_sk_filter_rcv (net/tipc/socket.c:2236 net/tipc/socket.c:236=
2) Call
>Trace:
> tipc_sk_backlog_rcv (include/linux/instrumented.h:82
>include/linux/atomic/atomic-instrumented.h:32 include/net/sock.h:2357
>net/tipc/socket.c:2406)  __release_sock (include/net/sock.h:1185
>net/core/sock.c:3213)  release_sock (net/core/sock.c:3797)  tipc_connect
>(net/tipc/socket.c:2570)  __sys_connect (include/linux/file.h:62
>include/linux/file.h:83 net/socket.c:2098)
>
>Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
>Cc: stable@vger.kernel.org
>Signed-off-by: Mehul Rao <mehulrao@gmail.com>
>---
>Changes in v3:
>- Decode stack trace symbols (Eric Dumazet)
>- Link to v2: https://lore.kernel.org/netdev/20260306185005.22120-1-
>mehulrao@gmail.com/
>
>Changes in v2:
>- Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
>  instead of rejecting small values in tipc_setsockopt()
>- Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-
>mehulrao@gmail.com/
>---
> net/tipc/socket.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>4c618c2b871d..9329919fb07f 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock
>*tsk, struct sk_buff *skb,
> 		if (skb_queue_empty(&sk->sk_write_queue))
> 			break;
> 		get_random_bytes(&delay, 2);
>+		if (tsk->conn_timeout < 4)
>+			tsk->conn_timeout =3D 4;
> 		delay %=3D (tsk->conn_timeout / 4);
> 		delay =3D msecs_to_jiffies(delay + 100);
> 		sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
>--
>2.53.0
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

