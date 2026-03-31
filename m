Return-Path: <stable+bounces-231374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELQnAB2Wy2l0JQYAu9opvQ
	(envelope-from <stable+bounces-231374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:38:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25536731D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 655903037643
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A33E3159;
	Tue, 31 Mar 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mlF3E6+5"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98F3ED5A4;
	Tue, 31 Mar 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949914; cv=fail; b=Z5YKAy0S0IzbW0uUU0MhztInqVqwMjqj3G+XGwO1QRH0bam8ycqFFMqGlk6fBCzS7965KO9eKvPPuGhRZf0WL7rhpk1Znbb6VYxXjg0VD1jVyFdTgXVKqZLqW9TLGYuGxi3Lhw88bCcEKNJYVpeFBxQJUh07kUY/RS7ScOBjMk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949914; c=relaxed/simple;
	bh=9o1sFITUh9GwL3Zv8yPMUCixJVOWk48FbawrJ8J8ZZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JY1pwlhEGHuN1WdfQcjGPflAQsTF1vsRgA8VkgFJ/1qPCYDBHwEfrVFdnbTNCq5rUTuKz9TySGsZdl22Pp3n0jPKH8T+p610w+eTybK9CtqqqTKu5CtSz3GjKnQNqPvqsuj3wHAxJLLjB8ncNPDS+4hf563RuajbXeVl7g87W+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mlF3E6+5; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmmPsLK0FFzLwsUKc+7blkb8RFgMrYOY9Kq9A82HajcHIeuyRmNhsiYmqHAd67awuXKd1mXUtLGbWx2SyB1nOGOtdlGpBdeGV6fRWr1lKu3zCUSxYcFjtuojG+4rzzB3uGisVkWx5+p9YhyFMtN01dCYK1GseneVG8WFa4TPy0oKNP14OFy/gLSpaFhwrq8+YVMRBwOu6d8q2+gCDWafv4wNO8xDPZQcr3dVY84jucKUxsmBbtP0fSQ/xc+NmJnNC+rqZbcUHkTJWroAGHeOxO7TyunTRdtoOLn5MYCQFnKL+peu9ywysk0z0KWumm+wTe461N0hj06REW6r3lGlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmDnQio+Rcc5v0BXhCft6pkEbf3bHofapTl2m3ZIXwc=;
 b=coZdtkNMJii2JJK1toDh1PCIZdE2dCAEVA8irOUmb5uPv8AiYd38DgN3Q9Onk9aWZAmCU37UhRMZ/foaDFEdlD4ymVI0VaZclCbT5hTC26V34XC5ocv2ElZL/sXCdu12EqQ3jpceOs/6FoUCcKaoiYuzhx74iWcUuBOKq8E4WdwgTDj6mZFhXh7GC4QunOVo8HaQwhFGcT0eMhT83OBfanqHLvJ2flwzAddqJpJpPzmEQ1J34Tvr2VuvTSU0KUZahmZzl+rSViEdrEaMtWBboVdQXk1Ne0jk9AlItR+uv7/WcNJa8C/ePg/Rd3rCpp10LQDaq8XDcwbNMQdYxjlR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmDnQio+Rcc5v0BXhCft6pkEbf3bHofapTl2m3ZIXwc=;
 b=mlF3E6+5mUYjo595h5VSF2lnzFhagYjIw9wJF8V5zMLCAreuOSK9hTwwO/njEHI7Zjk0bgLm9DotkSOi/av3+cf8k8xS1/qP6BfwdMiGeOaxo1VfNDAUhApYuFglhZfOYEPwUu3r8zprH39M9zK5othaSLgd5IOZZDlHA2BH5UaKfaAuSAisaaMxHPuKeoJlj81Kgp8uaLWAkE7/eKbyas33XboAoUhMX7VvLLXIgAd/r59doRWX9v3U8NQDzB9SoWebybA9vQJnRSjJCEltCpkgLQRotFVS28l9A1gJD9mQy3J/0pHr+M09nvwpcKK/fZIyDlltfZ4nzBbIiDmfGw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB4P189MB2310.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:389::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Tue, 31 Mar 2026 09:38:26 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 09:38:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "nicholas@carlini.com" <nicholas@carlini.com>
CC: Jon Maloy <jmaloy@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: fix UAF in tipc_buf_append via
 tipc_msg_validate
Thread-Topic: [PATCH net] tipc: fix UAF in tipc_buf_append via
 tipc_msg_validate
Thread-Index: AQHcwIdDCf36w6QDrEut4UYKQi+rLbXIXJ4A
Date: Tue, 31 Mar 2026 09:38:25 +0000
Message-ID:
 <GV1P189MB1988C30D3473CDD1EFC04358C653A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260330205313.2433372-1-nicholas@carlini.com>
In-Reply-To: <20260330205313.2433372-1-nicholas@carlini.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB4P189MB2310:EE_
x-ms-office365-filtering-correlation-id: d16bc9d5-f864-496e-ca04-08de8f094217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 LrJ59ki9tkikeHlgYlhFrjqiWF0QFXdd6o29kQgN3Gx7LmhziJFwsy9pPwrHe2w8ii9RsyjxsIKbhsFLKkgjY4E2dBs4JdtcK5Xza8pm5inR+bW1V9uI03Nv5QzOzzxslf1T071jEyux8hgL/EW+KO2IjnCUeu71UV1jYTKCxCHxJYzA18YnNBBCBYNijDEGB9MMkLhTQ+n7OIYfp+OO0WmjYS+LpKvgN1W711GLt24Xy+cLDleCshUImRmr1+alsl4pkOgHT3+Ph0m2INKfBBjdWkr12u3bCRYmrHWzEYF306EiL3+wqnJI17cchscr4cguzT3aqg58AfC4GzS/a/E9AEG6dN0Pk17bVVItiLOy48hSUbzvV3y2CddWlC3zzTKxu+G9Dwo23muBN/zJzbpJ3jzQJTnSRTZBeCXY+lnwYwbym2t2no3MgOLg89F1yQRsB8vrXAMyZc+JOxDf3NArJ2tapFflLlgZ923TT96RPJUgNqBW1pWXnc9+Z5k2PSHE9bCdoNCTj1sezJvUnJUbDcsrvD1IyjKYnQ9/Y1vHaKQ24AXAChgmhm0wp9VuJO+Mqbhc3dfssDyEoOIYH28OElrqJyA513w3RrqunsPK1YGWQ/V/X4Oe3lRAN/RmOAtDJmt3uNfo7Dq7PjhmqOx92NFpQ5Ya1aWRJ/AhcPhVcJbaI0DHna+tEvZW9FskvLMnxqITmkwtBeBfH3DN4gbo88AuEPrlA4BwphjyULAYhHVLQp2lJg8ZCqWSh5NUAGnAtFPSDkRKAa9XfovpRdyknczuLentUmPzrGiF4fE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IAqATdgkh1DOt//N+eyywwknwkLMOCn06mkwmyzgJsYa6jd86s9c+uFmOW2B?=
 =?us-ascii?Q?HWd18Zwy83ZGVHS3cbVpSb6+78Kb6MAdLSo7e1F2hh8iDr3voVmQFDiGhfFo?=
 =?us-ascii?Q?c4IZXpY+tuhUP3Pv17wYghC8JmNISZbkVAZOD6HzOvP3yuwFaf3EVDiKMzZ+?=
 =?us-ascii?Q?y2y7kixebG5e9RDLYQdQonPHQGpsMV8J56P8U1DdMsAfuHgAbDvywNIbafO1?=
 =?us-ascii?Q?DRcsFgRYOSv8H4ZIeSnvwpV9/3LfhQWVlXo8403Cg/gQWSm9Fo5WadmPRhaB?=
 =?us-ascii?Q?pncTzg+WEjAyJsqf2JOqG9Y5s4DzdqmctsbleY8wfPDCgCBAlLN8MDOHuFtL?=
 =?us-ascii?Q?zN/8KZPSj65uJ/TIVuBj5276TDNT5psA7F+/mFzV5R790jYUMQIId5zEDkCw?=
 =?us-ascii?Q?HNQVeY7QHDJC6n4/LcotfczfUrGAlzsIJvCj1VZKwLLnMWMjaK+/pvXkWK5R?=
 =?us-ascii?Q?x4H96H84F7FvWl/34Wi5BhokjJ8w9sZeA2SHPLUfpw6EeTwZg/ycesiGyJmE?=
 =?us-ascii?Q?Fr7WgyvBFrhdA5i5zDnwXuj6K2aK8aixjqGwSpSBQiVaf9oWfsNv5AdBIb1a?=
 =?us-ascii?Q?tVmUX2GhRR8mW7T9QGSve84SfehZVYFkztyJGip5ZM2n8nQyAzWIM+X+O0IQ?=
 =?us-ascii?Q?V9tvjbeqscpqZ81QP4pd+y/VnwpjBiR33SXZsgmFbeDFgBy06hZlyVaiI7g4?=
 =?us-ascii?Q?/qrBvDpXsYpbQAQYh9gpKjhMPYNcPZKMdNqInnkzG9YYJLWvmGl1qRPV6Non?=
 =?us-ascii?Q?xuqP71dYjQRbsAE0K0GnlL5KEJwl5yDZF9tzXhEeUfNLt8sIrtbgcYRsmDde?=
 =?us-ascii?Q?1uIxgz+oykAYDmN8MndDZHKbzJkJ3SXwve5+k9AYe6xuCCdTmRnFqFP17uAC?=
 =?us-ascii?Q?HIVZD+z5lTJaHhEkOz+Ox8HAORQh5NQM7OZHWTh9MAXuBAjswEKxzl4Q9sgX?=
 =?us-ascii?Q?hbBCqqqABY/T8YIEVGsuoondB9k9j0P6HDW/DDn0eMdqDcCzPx0OW1/t2t+l?=
 =?us-ascii?Q?rHvU/uvFxtvPVrll6W+0UC0BHL4v5V/NYgksiwy1V7uwnCusvms50ScBwYCJ?=
 =?us-ascii?Q?GQiIXwr3DitPKD6M3dqB/eowWoQ7j6FCLEwVTtYRLDLx6bLN0qWCGaoQupiu?=
 =?us-ascii?Q?uMX/wzJToqdXkfvs2nlkabwlnNdceTMMy20vrsiTSwSx2trtSvubffCvwWlB?=
 =?us-ascii?Q?1KqHjMoS0J9JW3xbc+11PG/zWM/lUcL0IX2L1kIuEPNe5jfVbjemiOjuDYQb?=
 =?us-ascii?Q?EPcyH2KHOUOqFo57PQuTrqmwLGP+qvkATv85tbJ5Qid7gNESDXI+FQ9Gla2Q?=
 =?us-ascii?Q?IeV0bRFq1NextmbZfZjCjBRqoR+SKVxZprEq3mur5TvclaQLs4B9z+qC4sAp?=
 =?us-ascii?Q?2qQjUsCHd4ohYT5D48qqPVPYIWdszghvSNpLF1D+2TnXjgCFsK5aAutpcdll?=
 =?us-ascii?Q?10TO4Hm7VDhqyxi1FxHqiJ20WGE4RstSCt92zD4mEoi3N1yoz8X+5e8/6V3B?=
 =?us-ascii?Q?vaar972xvnf+MpbnDUekNB6CEt35qB+0mv5Ahr1I5bTbGIEUaHMZbZGmxjSA?=
 =?us-ascii?Q?73M/gY0jii6W/Iqpu0lOeVot8HcNM1ZZSA839jgA8WfeEySEUNPFQ11nCWT9?=
 =?us-ascii?Q?ThIS3Yol43MWr6vo/NjSNMKhVagYCDYbrqzFtiHo7g5nysaPxatl7PofSePC?=
 =?us-ascii?Q?diRQyqdLjc4wnUeSUBhxRyrvdEhraUMf5ED1aaYoG7jgFjVfpZ9lRV6ojB9d?=
 =?us-ascii?Q?dQQ2REMN0A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d16bc9d5-f864-496e-ca04-08de8f094217
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 09:38:25.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdFBmTCKJh3kd7IjDdXi+gmNc8RvuwdOYJQuvzRqo4/aXQj33XrrcHHtLkXu4Crsu3UpS4DmtOVNSgAlCiRYLpcvKm7WkA/qQSYCu6ImwNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB2310
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231374-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,est.tech:dkim]
X-Rspamd-Queue-Id: 6F25536731D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH net] tipc: fix UAF in tipc_buf_append via tipc_msg_validat=
e
Please remove "via tipc_msg_validate". It gives wrong impression that the f=
ix could be done in tipc_msg_validate().
>
>From: Nicholas Carlini <nicholas@carlini.com>
>
>tipc_buf_append() passes the address of a local variable `head` to
>tipc_msg_validate(). When the flow-control ratio check in
>tipc_msg_validate() fires, it frees the original skb and updates *_skb to =
point to
>a new copy -- but this only updates the local `head`, not *headbuf. If val=
idation
>subsequently fails (e.g. the reassembled message has an invalid TIPC versi=
on),
>the err path calls kfree_skb(*headbuf) on the already-freed skb. The
>replacement skb is also leaked.
>
>A remote attacker with an established TIPC link over a UDP bearer can trig=
ger
>this by sending a sequence of MSG_FRAGMENTER packets crafted to inflate th=
e
>reassembled skb's truesize relative to its length past the ratio threshold=
, with
>an invalid version field in the inner message.
>
>Fix by passing headbuf directly to tipc_msg_validate() so the pointer upda=
te
>propagates correctly.
>
>Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and
>contents")
>Cc: stable@vger.kernel.org
>Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
>---
> net/tipc/msg.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/msg.c b/net/tipc/msg.c index 76284fc53..9f4f612ee 10=
0644
>--- a/net/tipc/msg.c
>+++ b/net/tipc/msg.c
>@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct
>sk_buff **buf)
>
> 	if (fragid =3D=3D LAST_FRAGMENT) {
> 		TIPC_SKB_CB(head)->validated =3D 0;
>-		if (unlikely(!tipc_msg_validate(&head)))
>+		if (unlikely(!tipc_msg_validate(headbuf)))
> 			goto err;
>+		head =3D *headbuf;
This fix is not optimal because it adds overhead to normal path. This patch=
 is better, I think:
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..01a693559589 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,19 @@ int tipc_buf_append(struct sk_buff **headbuf, struct s=
k_buff **buf)
=20
        if (fragid =3D=3D LAST_FRAGMENT) {
                TIPC_SKB_CB(head)->validated =3D 0;
-               if (unlikely(!tipc_msg_validate(&head)))
+               if (unlikely(!tipc_msg_validate(&head))) {
+                       /* reassembled skb has been freed in
+                        * tipc_msg_validate() because of invalid truesize.
+                        * head now points to newly-allocated reassembled s=
kb
+                        * while *headbuf points to freed reassembled skb.
+                        * So, correct *headbuf for freeing newly-allocated
+                        * reassembled skb later.
+                        */
+                       if (head !=3D *headbuf)
+                               *headbuf =3D head;
+
                        goto err;
+               }
                *buf =3D head;
                TIPC_SKB_CB(head)->tail =3D NULL;
                *headbuf =3D NULL;
> 		*buf =3D head;
> 		TIPC_SKB_CB(head)->tail =3D NULL;
> 		*headbuf =3D NULL;
>--
>2.43.0
>


