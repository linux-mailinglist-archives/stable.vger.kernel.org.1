Return-Path: <stable+bounces-244733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMFHInW9/WntiQAAu9opvQ
	(envelope-from <stable+bounces-244733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:39:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3E4F51D6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CFE30459FC
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E83CFF70;
	Fri,  8 May 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="rl/kKWO9"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF463CF696;
	Fri,  8 May 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236731; cv=fail; b=BBJrIAGwP3cni6o6sShcPE/XpWgID+m/GaNzCrf30Sctm2T30LHJpZvk23sLPI67EAMlSf/6y7PrtKSJaNQXMZ/tph4/Dm20CJ5Te4UhNm3j5CYlv13T/hCIIGKMT6EMAGlFtsatCCpX+EmF/X5dAKbLVNiss/ykmLv9zjJ5Gpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236731; c=relaxed/simple;
	bh=xo8GMZ2ZB7REvW9Dp32DNOEPH/r3n2AscUje+3N0r+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSfRK5jeT9Nx/HT38fj3ghnNppaEuixBHSUulcAcyoHeCJME59/2vILO0JTjJ6QTsu/G2X6vghNSSgmjSjemxYpakINmG9mzpLwX5cIRbTiIPkd231uFyxKgw3tZL1KSNTuUmqfWhW/mLKvFTcp3zVVtskmiJFUmKez0/asIHe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=rl/kKWO9; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMbmBQsYRaZCy55GtL+2b314wJsg41LX1lU9W4dx+yjVHxXCmJ964AyY5eyt/UYcd2ElC62RRTHTit9LuiCr1bHzdVY7EIXbzlKBQX0AIDWPRVEH9SR0FIfOx7XBEiSMHPRcg/cRWxpMx8yRAgwE2JWM28kkuZUyejoIoUyEMm7SVRA4daohy1DgFalObFar7IJ3ts6uvLmYWA3cPrViCkgE9TAbM/CcIOxLVhbSmIVLMEOmiUWtjiWMyFwkUtDbS0N0xvQOWCV2RO06oD8Z8rgmAy0P7brc6HNmdVDCOH/4SwFqJ22lJBc3FI11/5kqr69s3Rmqbn673GBZL6wPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ieot99JBe+fqWMs+g4w7Jef8DaeO0NaFwBuUTgw1HEk=;
 b=Vjp4sn+NHIDRYFIml5P+MDeh33oQZQ3JB5pO957GKLyMqohl+DPziqqGTmbxQfMOo0pY3xq6F/DvZP2H5h9joR3F4NqnWpAF9Doy1V0dfOiU/OxAbFhHsO6aBBSKT7IzCvUG4yPfOpbFKf8giV9FFEQyd1k6fEf7Ws4gYbw5Fb/dpF1v6NvddYbbdaId1irFHN4+BbjGDuI5w3mz4fitxOE4c04v07nSz/bDpmf1vPlyHL31Aaz5QoByhZ5n1ZWVPaSJG/5ZA7A2kmCxWe+rw457g59Ted4LWT+U52FDV4jWlF1vYG6WoLZUE+zmIaNf8exhNqrI9iUCRgYdUZ2EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ieot99JBe+fqWMs+g4w7Jef8DaeO0NaFwBuUTgw1HEk=;
 b=rl/kKWO9qBwa3/FS173Sz1H8OlEIjB1EERrVLBg8Q80Y1OyTWVzUjJ3VvLoOpUjp0oebUNE53H6fYjVOHygpQaFy0UBZNr51uNg/aFW4u87FQMzV7H3ZNJ5Y4hkOhIN8/CFgo/gp5HvWQnu8CHYSjfGH/pZWkTqPR8OeEDd9o6qwyJgG0dc1Qc+eWlarL8YO4SmwDjDVm7h4uY2Xalnl+EISzY6XcMLGvlhu15WCgWTtaCVefr7H2pTXuPISH7143X6bOjUi3QKgtIXMfPzl/YxIfB5S9iLCS1juMpInLvTuHyrkcVDT9sACkYAivYm504AEh2iC3DAVfKFKlbuKdA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA1P189MB3389.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4fc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Fri, 8 May 2026 10:38:42 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 10:38:42 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "cassiogabrielcontato@gmail.com" <cassiogabrielcontato@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net] tipc: avoid sending zero-length stream messages
Thread-Topic: [PATCH net] tipc: avoid sending zero-length stream messages
Thread-Index: AQHc3Rc1c/sP2rnzUEqXCsEyfUxhbrYAidAggAFERwCAAiM9kA==
Date: Fri, 8 May 2026 10:38:42 +0000
Message-ID:
 <GV1P189MB1988525D7BFF6A00283ADFE0C63D2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
 <GV1P189MB1988FEBC4D7BA3F00E210774C63F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <dfd8fb00-29de-4151-86a7-307a7c721f7d@gmail.com>
In-Reply-To: <dfd8fb00-29de-4151-86a7-307a7c721f7d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA1P189MB3389:EE_
x-ms-office365-filtering-correlation-id: 4f56d4ca-8a08-41b4-1d8c-08deacedf95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 TSaVhhTMruDr5LmjMcutDtgEKTJR1bUL0TckbPjPNyYxACmXGOyF0FP5iQtd82S5bGC/SHDDNCrRVYu28xA17z7VbuVP5kmZ1ECA04GoUiZG5nviYSmyg7TqDN6fJ4/TC8PQaN24XR9nPDUgMbGIyXamdRnLW5+7QLBnyuiGSspRaPsExh4OKXWTH93TZt5sF9Qfzh8pDrJW7yjSjEBIqMnzkZPRXJI1p9tmeYw/rRKMhug/jWUE4pKJck/v9beExcDuJz2hiTl3D0do2Amx/M/2qxKE0ThiYVqTy1hmSCMUE0OuJmYcNknH2yuNWiyerfFlt6CQjUc8PaUShXdOTgenyJGs8Iylz5UquORQsNz3+VrXe/TZoS7HV4L1QjrKLJQKES2BuqZ66qpRGxsIKCUmAzeg+uCIIzaHJR1BrTfQA2NC6khztdP501KeeOQNRdC3gInAVvyWWTkIY6Dssoq8AXayI7XjrcwFTi7fb03oYFWn4ArX4cDDqp7oeyrIIrLfLNq3u1c27rOZNavLJ2VO5VkKP7sD9dYnS2ZIHA0OKbK2vthCD9Vv5eT99Wrz+B5QCX3ncqs3s0cTxj4QbTcVKIEJNAzbNlo+AkIyzNsVJ3OKThF8WTwBsC3/jelzBYB6uZFjXEm0wOk7Bs7rOHzbF+Ogf7jJTzTmrYJ5ZI1htYblc+eHfq/9YbraxuBxdVyvb5eaLULnT/E3Vzls5M5JFp2F0km46FyX2wbtSjmFJcwU2rznfYx95zPCqBO+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hfo3p4EPVPycLUHFubqn5VSuHMasI2NrunEPghJVv2ics8tLTLU9t1wZWx1n?=
 =?us-ascii?Q?YITF3of9Lfy3BSRN3M/emTbdh6yM1kMvc+KaN3jAzh4tKhF5hSW7M6WP16dB?=
 =?us-ascii?Q?vfgHGQlbLpNinme2L1UxiJS8B7mKrVp1PhYOF3Vw3gKk6VbHpYt49JyXc2Kh?=
 =?us-ascii?Q?Mrqz68M27Zq8E/ZowHZB2dHPcWecnNkTuV34LFz0iIZaNDQf1sAz44mrIv1z?=
 =?us-ascii?Q?oUgXVkbHHE9MV5/25R8Du6noq+RO5EtxQh2bmAyxHn6gmg81WwLZDFkze9U0?=
 =?us-ascii?Q?KBy7eyHP0yeG2VgC4aNwBV/S3C31k4HAg+tCaFbpEXxZRowBuOmKgnszVrnP?=
 =?us-ascii?Q?2t4FDOQZSrjrxyPWCfFgcrKWudU/su1PVfSxwpnXZkT3p1iL9NCThlaIoM7V?=
 =?us-ascii?Q?ks5+wyN+9xTEYEw2oljXSHHlh0AJ7ipD8ZisrEABo/psgkKfyh4F2fxxgYuM?=
 =?us-ascii?Q?/W+Ny/T3N8nfzXLps5WWqh8kkTGdhZbVN/DWEXtkndec32ZxXCgLEbZZSG0Z?=
 =?us-ascii?Q?LXZn/tOTJr92qFVjuFP+oO8Y2QnXc8CjK3QOWVCKDBvGi9YleyJw+kOUWV1Z?=
 =?us-ascii?Q?zYUli6YNcAQRywRGBbJOA+awJPIi8iJiqS38oXjcHi1eK+AufPlrva6bv50C?=
 =?us-ascii?Q?QGabTcKAFq2ilimUxCUSYHevZoth1+lzU/FAYPv75QLDwfGxya0WaV9PHO31?=
 =?us-ascii?Q?cJhzgNViMGjwkm/mpAz88HYXI1vsVNlJ+l7T3eMmChHYHqWoH130CgPUB7W8?=
 =?us-ascii?Q?I0dDLKLT+AZE9BYQejqBriirJVOmTIKsvHj6ebSfBfY+yK0VHMFn46700CzS?=
 =?us-ascii?Q?+6sOSiqwo17b08znsrzQhpKPupoE9u/eYI1izD5gCwg59CcLfS+rzFxEkb7A?=
 =?us-ascii?Q?djfkwbmKlsj1Oju8jBhgQgpzjUhfX38+tpDv1Dm/9Ak3B7FCjQO+v0HsTWcA?=
 =?us-ascii?Q?W+NvSKFcGDv+41N9eDKavW8McVV6V3GCuim4zKL/5WuFW7VsVaWHi7Tayl63?=
 =?us-ascii?Q?fuX2iZoan/u5ioUm9LugrTGgDHfTWtfIFf1AonWE7/oDb1jUlxSYIYW6NU4S?=
 =?us-ascii?Q?i5ziO//UD6fdJKF/3gJ0ICeZc4kOsL/61/zyWktffbcRh9LDMEw3MRonNWKa?=
 =?us-ascii?Q?zVxDkC03WZexmF3zH3+AF3M6bWHMmIUHMBk8Eosr1h9p2pYbS+j6vxZwBbch?=
 =?us-ascii?Q?th96DqUTZCSFqRz5XBahejCiy/MgVCnrPJNz1SZZcTEoB6j8OOLg5DcbsrPR?=
 =?us-ascii?Q?jUg2VAclhP1YRy0RUbtYDwXKFPW/91Pmeebr7MPECJMZz9vQI++IfFLZQ8ss?=
 =?us-ascii?Q?8sp/Xb06ghUragp0yRJdR0Y0DdVgQJQ7Q5G355Cw+U9l5OYaaXAIm12utt6O?=
 =?us-ascii?Q?LXwVBYZrNdnzNlYPSDvgoTR55XW3Hy3pWySffmuFuFLUY4/lGubtJ28hLXzJ?=
 =?us-ascii?Q?aoe77fy4SsYUw3y8Ab0OrItwtAyytN8weU7bU/fYw32NGEY5Pp36EYbgIGIq?=
 =?us-ascii?Q?pAkmpbLSHQowqVadEawrpsUiOb3dPZ+WBcZpwMBIA1EIwEGmSm33alm0bk6u?=
 =?us-ascii?Q?2I+kxJr6se7JxCr7Rc1iwJ8jyszaFnfzOvnleYyopCHTZWfGP5uKJrM86eoS?=
 =?us-ascii?Q?YYeiuKEiKByh9oG/SRdqb0C9mJtqL8/Ij0bO5oLpXr38ryzdNOzdh8nGD3iu?=
 =?us-ascii?Q?tyr4Mbkz4w1reCWZH/OvNjkidIYmYMqzKunAl6/fYcNzBtKAEK4ay+Y8Pe1D?=
 =?us-ascii?Q?xB5bbJS0uQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56d4ca-8a08-41b4-1d8c-08deacedf95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 10:38:42.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPw7vxFaAfDRa1GAiInvCdvyDBW5n9TusJPWOjQ1ph/Ix75yh+F+QxodvQDOKqNWTkGd6/O4Afx4VhAy9RpU95bwYJWCt1lQKeY8Dhka2+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3389
X-Rspamd-Queue-Id: D9F3E4F51D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244733-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim]
X-Rspamd-Action: no action

>Subject: Re: [PATCH net] tipc: avoid sending zero-length stream messages
>
>Hi!
>
>On 5/6/26 03:41, Tung Quang Nguyen wrote:
>>> Subject: [PATCH net] tipc: avoid sending zero-length stream messages
>>>
>>> TIPC stream send currently enters the transmit loop even when the user
>>> payload length is zero. This can build and transmit a header-only
>connection
>>> message.
>>>
>>> For local TIPC sockets, such messages are delivered synchronously throu=
gh
>the
>>> loopback receive path. When this happens while socket backlog processin=
g
>is
>>> being flushed, reply transmission can re-enter TIPC receive processing
>>> repeatedly and trigger an RCU stall.
>>>
>> Can you demonstrate this scenario using code ? It is better to point out=
 what
>current code is faulty.
>
>The minimized user-visible trigger is essentially:
>
>      int fd[2];
>      struct msghdr msg =3D {};
>
>      socketpair(AF_TIPC, SOCK_STREAM, 0, fd);
>
>      /* In parallel, this makes release_sock() flush backlog. */
>      setsockopt(fd[0], SOL_SOCKET, SO_ATTACH_BPF, &bad_fd,
>                 sizeof(bad_fd));
>
>      /* Repeated zero-length MSG_PROBE send on the connected peer. */
>      for (i =3D 0; i < 64; i++)
>              sendmsg(fd[1], &msg, MSG_PROBE | MSG_MORE);
>
>The faulty current-code path is that TIPC stream send does not handle
>MSG_PROBE before entering __tipc_sendstream(). MSG_PROBE is supposed to
>probe without transmitting data, but the call reaches __tipc_sendstream()
>with dlen =3D=3D 0.
>
>__tipc_sendstream() uses a do/while loop, so even when dlen is 0 the body
>runs once:
>
>      send =3D min_t(size_t, dlen - sent, TIPC_MAX_USER_MSG_SIZE);
>
>At that point send is 0, but the code can still call tipc_msg_append() or
>tipc_msg_build(), creating a TIPC connection message with only the header.
>It then calls:
>
>      tipc_node_xmit(net, txq, dnode, tsk->portid);
>
>For a local TIPC socketpair, tipc_node_xmit() takes the in_own_node() path
>and synchronously calls tipc_sk_rcv(). When this happens while
>release_sock() is processing backlog, the receive path can generate
>response traffic through tipc_node_distr_xmit(), which re-enters the same
>local receive path.
>
>I should have made that explicit in the changelog and pointed at the
>missing MSG_PROBE handling as the faulty part.
TIPC does not support MSG_PROBE. So, It makes no sense handling this flag.
Even if user application sends zero length data message using this flag, th=
e message will be dropped at receiving side.
>>>

>>> diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>>> 9329919fb07f..3c7838713d74 100644
>>> --- a/net/tipc/socket.c
>>> +++ b/net/tipc/socket.c
>>> @@ -1585,6 +1585,8 @@ static int __tipc_sendstream(struct socket *sock,
>>> struct msghdr *m, size_t dlen)
>>> 					 tipc_sk_connected(sk)));
>>> 		if (unlikely(rc))
>>> 			break;
>>> +		if (unlikely(!dlen && sk->sk_type =3D=3D SOCK_STREAM))
>>> +			break;
>> This change is wrong. It immediately breaks normal connection set up
>because the ACK  (zero in length) has no chance to be sent back from the
>server to the client.
>> Please try to test your patch before submission.
>
>I did test the patch with the syzkaller C repro under QEMU for 10 minutes,=
 and
>it did not trigger the reported RCU stall:
>
>      /tmp/repro & pid=3D$!; sleep 600; kill $pid
>      dmesg | grep -Ei 'rcu.*stall|rcu_preempt|soft
>lockup|panic|BUG|WARNING' (attached)
>
>The dmesg check did not show any repro-triggered RCU stall, soft lockup,
>panic, BUG, or WARNING. But that test only covered the syzkaller trigger;
>it did not cover normal active/passive TIPC stream connection setup, which
>your review points out is broken by this version.
>
>I re-checked the TIPC connection setup path as well.
>
>tipc_accept() intentionally sends the server-side ACK as a zero-length
>stream message:
>
>      iov_iter_kvec(&m.msg_iter, ITER_SOURCE, NULL, 0, 0);
>      __tipc_sendstream(new_sock, &m, 0);
>
>So blocking all zero-length sends inside __tipc_sendstream() prevents
>that ACK from being transmitted and can break normal SOCK_STREAM
>connection setup.
>
>After re-checking the syzkaller repro, the real trigger seems to be narrow=
er
I am aware of this syzbot report about this issue. I will try to find some =
time to fix it.

>than zero-length stream send. The repro uses a user sendmsg() with
>MSG_PROBE | MSG_MORE and no payload on an already connected TIPC
>stream
>socket. MSG_PROBE is supposed to probe without sending, but TIPC stream
>send currently lets that path reach __tipc_sendstream(), where the
>do/while body can still run once with dlen =3D=3D 0 and build/transmit a
>header-only message.
>
>I think we should avoid suppressing the internal __tipc_sendstream() ACK p=
ath
>and instead handle the user-originated zero-length MSG_PROBE case before i=
t
>reaches the internal stream send helper.
>
>The v2 fix would look like this:
>
>-- 8< --
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c
>index 9329919fb07f..4783df337971 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -1542,6 +1542,10 @@ static int tipc_sendstream(struct socket *sock, str=
uct
>msghdr *m, size_t dsz)
>        struct sock *sk =3D sock->sk;
>        int ret;
>
>+       /* MSG_PROBE asks only to probe the path, not to transmit data. */
>+       if (unlikely((m->msg_flags & MSG_PROBE) && !dsz))
>+               return 0;
>+
This is wrong. We cannot do this because it just silences syzbot and hides =
the real nested lock issue in current code.
>        lock_sock(sk);
>        ret =3D __tipc_sendstream(sock, m, dsz);
>        release_sock(sk);
>-- >8 --
>
>I tested the reworked patch with the syzkaller C reproducer under QEMU.
>The reproducer was run for 10 minutes:
>
>      /tmp/repro & pid=3D$!; sleep 600; kill $pid
>      dmesg | grep -Ei 'rcu.*stall|rcu_preempt|soft
>lockup|panic|BUG|WARNING' (attached)
>
>The grep only matched boot-time command-line/debug messages; no
>repro-triggered RCU stall, soft lockup, panic, BUG, or WARNING appeared.
>
>What you think?

