Return-Path: <stable+bounces-223303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 25KAJ6xDqmlxOQEAu9opvQ
	(envelope-from <stable+bounces-223303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415721AD20
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80276300E2A5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C936AB43;
	Fri,  6 Mar 2026 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="PsWO+ket"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B61D47B4;
	Fri,  6 Mar 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766119; cv=fail; b=gTLi7VZBWwtnpzzAx0jXdK+ztf2LvtIsim7xaArcUC775jNOsrJtF4t9RdY1JqWY0YLExMhytZVLN9KKNXm3A2zk2IjNGRmAT/G3gmsDUswRtba/cYRBbAf3U9boqFWS4P5h9l2uHE3YHY6pjkmD56yp1tlvI0VHBZRyuylRmEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766119; c=relaxed/simple;
	bh=Aa3TZEq3LOyqY3EzBl1pmcD0VU+xV2u+0S5zFFA0T0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l59Xv9riQbUe7B8wOdd1JeZJ6/BNh6N7dnqUo1C7hmqwrXHNSshMBFGZiXM6f9f9PQyeXj9Uq7l08vU9eQCmHq/cHZa0UsV53gsfUpqJoN+Z+5LWzQmRcDHRfKsEKpxr/JimTWQE9mklllE6AFCfoQxC764pLrv0YXZe2ab3hts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=PsWO+ket; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UppbvxV2t9ShS7UWVUJsEPEOFX2YEXJq7tnb9o/mblQszmd2dKvQ3ayvMgj1peXNKwpBsBFr46QlKpxY8BRfwDmaYpCXvzRhxjR1xWI/t9HxSWHW6/BYV7C4PXhGLMCesuHurrvwsokYR2RDTy3e/bT11FnxRNrYQ75/hUTqWj9abbW2iT1RdorQWXhSJf9NOEtuaWD1JNlp+encZZ+KHok/IcMww205zj0u4TWLimmbVutUstZbES3ecbncHda5EWt3Oe/volR6lpzHNUbUgd3lnYMzD5/9vavkseA3wUGdFmkt8jwieKcdiEO0JdPLsworYrxNLh04i4eYikk8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZsydhO97wA+qLOeg7psJXuAw32qAde4g/9NvHMsiwk=;
 b=iKAwHOvbxL7B8xewWcfo+oyfdfKif3t+I1b2B4X/5llfAOauI27kSFC+xhwozThDOTHkbcQPhPjWp0FhYLPhdFyWanBwtImS1bV5AyBasq06J5Kn7hkvlHxBV8GaZ6Em7i2mg2y4M4HjEXW9MJyDxlFMt31TLG7nGF+Ix7OXyzka64kP/pb+iEo1dm0uRaJ4MqwNK3NcAAzpKLsj7GfwUMoAMuIifPuP+QKYxxZ2kFa6iv9g1A7H95G8QhTjLFbS0VYzpG9vwKUkSddtfz7IPD9m+OPzqcOkGsWUTl9l0rMV3kAQToeRC3r4zpmkdxoWURTD2jKma0Bq55nagkDiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZsydhO97wA+qLOeg7psJXuAw32qAde4g/9NvHMsiwk=;
 b=PsWO+ketW65Pch/7xNU8Js84d+MZycdlGTxvBnwhCQ4oqWWvQC5yv8tfyT7Q6scjT+BLmu0AQv3KH/DdyqVAHakpFRTZwzHxEXH2GMvhOt2R/9UiYVzCmxAoeQP79512YvO7SbHkO4mtJb1Ee/qdAcTELeFzF3ao9PAQH46BbTGt4i/EXwE8ORcJ/E8AJLQw4uZo0VplvJPSjz2fzt0I+sBejVX1d6BDXkEk/r7K7cxqVu+kjln/DWLr/5ufB6dSRPGuaA+Rbcc/IhkdeLY91gdbltzNtHSujhgSHIarShnQuHE7PHCJ4oE20A0GF8AgD9p3bC1bqNjE7i5gf6QHIw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB1144.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:167::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Fri, 6 Mar 2026 03:01:54 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:01:54 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Mehul Rao <mehulrao@gmail.com>
CC: "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] tipc: validate conn_timeout to prevent divide-by-zero
Thread-Topic: [PATCH] tipc: validate conn_timeout to prevent divide-by-zero
Thread-Index: AQHcrOscMSDc6ywML0COz929lsn6CrWgxG8A
Date: Fri, 6 Mar 2026 03:01:54 +0000
Message-ID:
 <GV1P189MB1988EE7CC7EB83137335F197C67AA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260305215336.645186-1-mehulrao@gmail.com>
In-Reply-To: <20260305215336.645186-1-mehulrao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB8P189MB1144:EE_
x-ms-office365-filtering-correlation-id: c511ee60-3439-47b2-1d88-08de7b2cb8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 okzHVA6jZKO8wn8Fvu9SwXXuIRAGf1QTdsXmlWfc85brLD7nys03ikaTQ1+ZQdK0cuRPnKchvzhKg04MWyJKUWm71AOLkq/uNdwut9ikR/ITZKZLiAeo+HoUwRu360tylRCpoF3cMSqpIVOS77YPGqFBzpvB5s7fqnaSRioqmHAQmGNXSc0VCBJLw6DAoS2riVqw1POw/5ByoTPCyNHyGIE557gOzpeC7Jaxy1l/SYOV3gQTfHXgbZ1bZZrgCmjFFcHFPyL0DjbwyX2ZYkHiAoZgnir9Gd13YN1adWtQjvnAvdwgaKvn4V0eT66AMnfMJ/hY9RE9O5YhQszzMRCKlCI5TBjtQFB20LwcYuz0vSWDd0WFRVfOMqjbtMGVE0t2lIYbe3Zt4chcqq6W8+yP57Mdo9aU4CejfEKfGFBk2hFYZdYCiX1/bqL1yeMEqfvclJao5GLnul1M+HJpGs5znJl/riLdJ3lNcxw1xuml4p3UCCcQRodslnrZsmuITXzi9HFJ5BGaxzjJN/Ro5Fg/1SheTIhtP0D01yQtIKs/9m5BLWhaGmwDNiNqncEKsUwWK6npVabsOrml8eDUJEPd/zLZFAKOoRKRQnkKHz6QZ21UXqrXTvRWQsip6yIWfJ5iVF/Tbk7DQZOqCOKUYSYKodDLw1lmxoBOGq9v8vLa4Mc34ne1n8bHbyw9iyNkknewmCHhBOrM7yTeEfyOB7BstiC+n+bf/GDHcVzf4crctN51zXfOBLgrfzmpsv+8cPC9nZ2iXmQUHb+5tva780rrfbiZiQZc9FZJgk2zJTHYfZo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xGru4F/G36SsCheT1nUNbDkDk5bHvoz14oLwygPzrJXTmBn8GLdJYvctEbi9?=
 =?us-ascii?Q?tR+aQ2EUBeo99d5KXxJQIqcvn7hdLBbKUo9pdiMu2M/Ko74gct8c3eQu3wC9?=
 =?us-ascii?Q?afYkU4i9Xh8n2r9L/I2l04PbZQxKOt4ZgMp5INFiWNN3JnGgQ+OUcm4MN/Bu?=
 =?us-ascii?Q?fApkgqm2oH7/is7seqNKtCz1JONrcFnATySQ8BDCmzmNrsxWdCymIXnJwh04?=
 =?us-ascii?Q?qv9uV8epChq72LLJePhlCdcqwlVKaPoIyifd/QasZNm3IiihRZ6WeLwt/S/H?=
 =?us-ascii?Q?gQOmMJb4cv/rxi9IqrG0Htor2GW9NUyLiUqHm50/3QFsNzn7GjeDpCImFJ/g?=
 =?us-ascii?Q?SIESIKXXdQF4tpEtWOkW4Yjp1CRGof9RI1Z//qD61kd95RPXan8g8ZJFARWE?=
 =?us-ascii?Q?mRfpQP2J5vLXMvB/WeuFejiDz6zm+27jKE52ckighNN+tDcw51hCRAbg9w1T?=
 =?us-ascii?Q?Uuynv5ZNevB9VDC4oHIwbzFM+O3EmFoB57BpT+AtEEF2t72qJ6yB5hPrq+RE?=
 =?us-ascii?Q?ZC+2Uw/Gc8Jlu2v2lkEq90qvq5J0xaqXSJtdIzGQAH/jbC10y0qIK+LHA1KQ?=
 =?us-ascii?Q?MRVCFi5NpsJwNXVO8ojOY1BBxr/dRCO4bbzecX6NIM6GOP8mocU2NfOj9RN3?=
 =?us-ascii?Q?UaR9AtCjs2Kyo2x9aa2CQsI7+e0w9ata0sMq1eMvbqOhJHhu64daxFaSWNjW?=
 =?us-ascii?Q?wUgHp7SGgkLrI3u3FNxgF4b6LYQpyu63MQPOy6wE57ztewIFJ8kXwWxCxl2y?=
 =?us-ascii?Q?4VnSYG669NR8rO9f6C9ECSwF0cJjoRg22fItpSB32Akp+rqZUUkeLd2HSiUs?=
 =?us-ascii?Q?LltIus9H7LwrBWmyVQxk/JeN9Mwp9DLXC5EuDOgXV7a47049qsduxB2prHxD?=
 =?us-ascii?Q?WToZdHK3sNt7w8wN3roJwwujYbgZ1ebJGInchyAgfqQdeDyLjhwF9ZBGv9I3?=
 =?us-ascii?Q?SeFeV34dbUNfA/dGhG8PJ36ylEPjNGwier16Bkf5fEdce68uJq/oIeJqKimN?=
 =?us-ascii?Q?zvLNNFBwiKGphB+jHRZfI0BMUmBJa0Eh0P7ek3pRCdymjgBainAYtcf9+D4d?=
 =?us-ascii?Q?7AP3gTi78RWB5o8CPj6bKi7G5Kux8MnYrfLsd+sRFenzJw38Vekqc2vftwL5?=
 =?us-ascii?Q?516cBWFph8tFxgPK0x/+U57x6IuOmKw+kD99xXsYz4+I+tXH85s8R6r7nfh8?=
 =?us-ascii?Q?PovI8lWXpfVR2zPrZKbY/pyQGWBD3+qaU7c/bAZjnE3s/JK9zHl6YUM1R+ID?=
 =?us-ascii?Q?3ruoO9+D9P/QcDuTptbifcofBQq7EiCJqNK8fY5r88s9drF0tXIwOZDKCsup?=
 =?us-ascii?Q?kZb0Yoj5U/JRgnVQH/DUQS7vHmvE3/p40fq7KmH1kKE61GfWOIB0qA91+zB3?=
 =?us-ascii?Q?sVvL/tBzHoJh3JcnNRGfuUjuTjP37w2FMqsgC9lBtjmopkAZ4DUa2xQibhiD?=
 =?us-ascii?Q?KKzgkisKiPcW9D9/haRIRlgTxWVLKCr7J6OyB/3X3sjKOigyiZA6NM/mFVcc?=
 =?us-ascii?Q?hVW+/Ld7URSBd5LK0cYLTymvoENCJ/zH+tI3yFh2OrLHiKk6c+yGaVDDmEx2?=
 =?us-ascii?Q?o2NrZt+mXgjAXTitLRvC7STHMCg2gmMzfczioUVwcGMZrK7+GMbT+E64bOOd?=
 =?us-ascii?Q?eDSjjwXe2KsXuC3uaAYRi+nj9tZt6qvFu9iK32uq9IsguGWjHZyTyUNigi8/?=
 =?us-ascii?Q?/XR96vc/980e1jI/a1FSDjFuRXrZnjOQF/OPJXkeL9eQQB78qOwb78qlbAPR?=
 =?us-ascii?Q?V+oxOf+Qsg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c511ee60-3439-47b2-1d88-08de7b2cb8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 03:01:54.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWChJW01ekIwiD/bRexjQ+Nz4KEfRJtVqAmWmepcXut8P30Xggg8jb4bTgwKK2ippE6DmxQMhs+BHIJdtKT67H9Fn+g+1kP6cKkEPBz05bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1144
X-Rspamd-Queue-Id: 3415721AD20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223303-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Action: no action

>Subject: [PATCH] tipc: validate conn_timeout to prevent divide-by-zero
Add net branch to the subject: [PATCH net]

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
>Fix this by rejecting conn_timeout values less than 4 in
>tipc_setsockopt() with -EINVAL.  Values below 4ms are not meaningful as a
>connection timeout anyway.
>
>Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
>RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
>Call Trace:
> tipc_sk_backlog_rcv+0xe4/0x1d0
> __release_sock+0x1ef/0x2a0
> release_sock+0x55/0x190
> tipc_connect+0x140/0x510
> __sys_connect+0x1bb/0x2e0
>
>Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
>Signed-off-by: Mehul Rao <mehulrao@gmail.com>
>---
> net/tipc/socket.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>4c618c2b871d..85c07b0ba0ec 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -3184,6 +3184,10 @@ static int tipc_setsockopt(struct socket *sock, int=
 lvl,
>int opt,
> 		tsk_set_unreturnable(tsk, value);
> 		break;
> 	case TIPC_CONN_TIMEOUT:
>+		if (value < 4) {
>+			res =3D -EINVAL;
>+			break;
>+		}
This needs to be fixed in function tipc_sk_filter_connect() like this:
tipc_sk_filter_connect()
{
...
get_random_bytes(&delay, 2);
if (tsk->conn_timeout < 4)
	tsk->conn_timeout  =3D  4;
delay %=3D (tsk->conn_timeout / 4);
...
}
> 		tipc_sk(sk)->conn_timeout =3D value;
> 		break;
> 	case TIPC_MCAST_BROADCAST:
>--
>2.48.1


