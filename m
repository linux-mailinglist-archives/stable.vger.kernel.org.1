Return-Path: <stable+bounces-233485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFnhFVZk1GmUtgcAu9opvQ
	(envelope-from <stable+bounces-233485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB73A8D4D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2233014BF6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978322173D;
	Tue,  7 Apr 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="DBunrhz7"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022122.outbound.protection.outlook.com [40.107.40.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16F175A98;
	Tue,  7 Apr 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526988; cv=fail; b=CEv7hAlU/78s6/h65gY/pFk7VECe+tmuxQgg+lZd2Jb0MWjBCgApS3haPhbQEkN0Ih2fAYqIol00PfgoEKeDHXt72da7NLW0A1TjxoUnwFc1hRf49K8NAz5lVS+tUpcpFpQ+WqE2vP+FGGt/BBdzvYmJXCY5VbCVacJftPM1wGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526988; c=relaxed/simple;
	bh=NSB664GbNODz7+CwNo73z5X7NMUOCtBQcOmCQiWK53s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hT3xCxNPlWIMcbCn24g9x62yM3fRFBvzxuVwsmaVsF8jKafx9B1c6qDBYrP8QE1BRQgzsmU78DQRHSRuiWgIUNuTPYQKgyuquUve5elkrYZaRP4a+gqDiHoFZHZLIhcwqUjdiTp9c5h9qEVZ83llvQEiY2BnI85Cmc+iso/AHaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=DBunrhz7 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY2JkiYJWtlLXtoXB0/iJ01d6TIfNVT6bOzgyyDqw2R1d6/J2EffMMGuR4DPwVSaVxryvHOeNwwjCWwbmVbPh1rxhhKfWBkYdra/E0zml6//D2+5sLgUhkwHzeaxlB3oiPOa8D3nw1z9gxB6+1j+PmhdZxm0xKtSiOCgbn8iJBk+OOPTMzp+HI7tMdvHFeEKfBzEEkZhW+ABSs7q53fUkk2AiHOr1Wim3qAN75hYX5y/1cR3bn77VZYmwUqoZeLT7mGjUFCME0e+eR0uFQF0s5vjx3Z3SOZ4eeV/gTK6TgPKS54bJ07DOV3uNVIhqnhn7xoOSHNOG2sKzr3QYjBJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A+/df5W9Wj5jFGiSCwjfThSCxVt43dipxrxy0FHkDs=;
 b=EoHYZA4i1tqqrp+GncJC4H97UqZp0+lZrzUj1gOmbPCEnufhb/7x8FMVRzk7M7cOKifr3e9D8MXkFo3lnBJBdTB5HXog2sp3Ol0H8VTjf1RYStU0w7xu9194JPnCzipaqx/WDRZTCFKuHAOJk87F322+DCO/sg3XXgPREQxov90ECPC7nHNXz0HL6yMJCdclMf9RwQmMgHmmI3faM5ghxYx1IYWfsVhOWrcNJkUKgZ9rJ21G1Jjpgq3sSv+0IRD5vLNuGADBo4JvzoCjKTy0U8DguaD3SHXs56c2LnPb7oThBRhfMhYbHwMr1vY6cYIph6aZHSHldvEPNGvxChHVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A+/df5W9Wj5jFGiSCwjfThSCxVt43dipxrxy0FHkDs=;
 b=DBunrhz7EEdKS0qHckclPbRjJ9ufX7BXBebyVot+x59YULegrFnnSLxaMLKvQzOfwVjxdVjQA+wBvA92usSjLW05YENScuTw/1ZK9Rq3LdM2cFxcCtNMzJeRfDq1B9MSn4XTZO1H0dsBjFJha6CIpgyZGhMsZKKwFUpZvAM8n6gp8GbmLwIaxV6hmIddqs9bz8exvVDsfi1veMlzUq48GkbwtTHg19fLoAvHiDJw6pijSpQKezpFWps6NasIwKwBfpORRtkDycRBzqyztQuCyqTNhQXgjvRD41f1FoSBmDmdJEA1jJQPiZgrNlvXa3AQMFNPzkxgPwYF66uQNZni/g==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0634.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 01:56:20 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Tue, 7 Apr 2026
 01:56:20 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lawrence Brakmo
	<brakmo@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min
 access
Thread-Topic: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min
 access
Thread-Index: AQHcxhewSrz8KO6SLEeqbn8DvXuOQLXSzsIAgAAFKMA=
Date: Tue, 7 Apr 2026 01:56:20 +0000
Message-ID:
 <ME0P300MB0853571398DA0955E4D1ED04BD5AA@ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM>
References: <20260406224953.2787289-1-werner@verivus.com>
 <2026471147.8A6S.martin.lau@linux.dev>
In-Reply-To: <2026471147.8A6S.martin.lau@linux.dev>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0634:EE_
x-ms-office365-filtering-correlation-id: bb77f0d2-1867-4483-41ee-08de9448dd76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 ppfMigKx3VkBWq3lA4OsWIr8qrrh6leNDUakctJFas+sjpErxuNnCS8/ombrKVux3HGy7UWjq+cxbHicy0DtNgh/NSMcMps2swCEua+vkXplx8gXKyJfTCcJ0EWjv6GXewdehBp9UXwqvdBBx2+vIiQUpQZY2geeTx1sufyPwIkeg3kpD1tcGb3i1KwzLFlngcczxlNLZZcvPYPhbHfNQyCCwrSJDiWa6ildLxCihbTQSqSp4Id1LXpHdeukxR1jKJ2MJinS6+JatbapZdsiUl5+b5r9y/9G2904QJHaKQfbc9ApWGcSNFHf16QvyKKW9zXKZOJ05xAOgao45uuLYl52wddyHrx5slyvxHxJf3Wp9dzFllqemWTXo2UkcY2Nzhe5+lWdK95t9dZmKzV2x6aIJcuEmk4NW3Yy3xdlwF2VDQsues/xtOlQ6gUIy6QdMZ4ng9QRBO/nPTxb7x1pbWANGTsdKcm/zuQMipJpVcEptOFeM2696daV2zBEHK3oSkMRx6JTIGu6vri/4nRWkAYZ8ceJ8J/XDcoZ3HCVKBOnU9/ZbDDRQ7EnmIe2U076fYdWnqpHwBOMLDQwFgzhAyvmrMD1p9cDsQuLnMVnAva92FKGZ5v7gm0Qnsdavh9RjLkSKAUSGvSbaLjUFha5p1rssDqdAfQG7FQwdMiFFTNsUbOPZmoInJKs8yhJcfLm4UtuXif/BsED7WmB9bCChFCqVYmbaqyJhxmnRiWRtk9H348m6hZBTJg15yIaciDB/XunItzpXBO7EUJLicQKu5lYHF7WeZNF1VNl4iUJq2s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KvKpBt81BlJVQ052jxK/+Nzou18GyJaJ3Ge+eHHL4XuzYJCksVnZFC+JLm4l?=
 =?us-ascii?Q?Gj9mF5nPog1SEG9RMXTzXsEnmW6N5k9sv/Ew1OhYzoSJYbts5dkEllL9eFQ4?=
 =?us-ascii?Q?bUhZQjOX/n0luKdZ+3mB0cxlcoQ5CxZ+K0a+zJ4IK755kACfskos4JWh+qjp?=
 =?us-ascii?Q?OwC27bVEKi2Fwn8gcHBMz8cvK1oD/bGm0q5VUXrWxRGDfBOK4c/gdTeBR3lN?=
 =?us-ascii?Q?vUwecVPUQajV2Djl9b9JP1KodiDlDFEZ3Z3jcggoW3EmlF+OzkHn8CEqAKkd?=
 =?us-ascii?Q?xPSynHRr5x21yt+Agle12P4zySh+uiPX/GAy+K+x0yphMsD5MIa2GfAd57T/?=
 =?us-ascii?Q?0mmjA2u+rMdeAAgCETcepPt4wJA9cANOpBxMN9bXzzsEd+X8h4o6NyecdEpw?=
 =?us-ascii?Q?xfhAGftyJ3/mx0crmftrnRQhssMVxvX7/R92kLldBDUojZ52d1fDkf56QsmJ?=
 =?us-ascii?Q?Z87qG1LW3jhROgljKbF6L0UZS/IWFIlkmCj7bJs+z8eOXdOki3OTYuqeKZPq?=
 =?us-ascii?Q?2hbDuCpIee3jQm53R19YDS4UQbgcXOrJ8bYS1cLhq8tu6t8ssQwC0/lLMgu9?=
 =?us-ascii?Q?BuR+FqwmMHyin85fJYdpRrPe2uUo5g9ESiRq5rdYVOdE8pf/r3V2rZOOKHZV?=
 =?us-ascii?Q?0vpY/MlNxZV+Fj0ZrPfdL8quAgqanxz7W0EX3kBPmS2Ktvdyz4KjY+X8I311?=
 =?us-ascii?Q?jxbQtnnFrZsNhBlXynrlc1RgEGXE7pBYPibqAoSDdefQsj8c2bsGWFE/Ylbl?=
 =?us-ascii?Q?FsOF92HGfhhPzb3BHAcKh/KaLE3MF0+DgCftMl/Ibzc9peeEwaQ4ITvD2So1?=
 =?us-ascii?Q?KyYIOQwB8nKwIQnazbFhzdomSx8KGP3smdV8fuJwX0kB6uoZZg+vTzpaMLJR?=
 =?us-ascii?Q?/WncM03l6t8sd50ayeeRnbJ2+ywWa4j7cr+mfTLiG1u33Z+26WCP3VZpXVFr?=
 =?us-ascii?Q?KkenLe5eM4/2+xsNctn3AAtJvS1P3kQIomaf77V3zkw/jq/IwnzIZtwuSk2h?=
 =?us-ascii?Q?848rpsDcKe1YS4fYa4L7LFaXF4X3Q2g1LTuZbt39AKbcvwU99a96sLymTApt?=
 =?us-ascii?Q?3q86pzIzlt5MNKqBDYUyv2bo1Q7cQWtoOujeNt9s/9ymDywu+Lq/5xmHT+b1?=
 =?us-ascii?Q?TxIxWPoY9ms16lCSHBhj1+NTRY/Q1qPQ8+OZLB48bJQNj3qd0kr3T7IAOT5M?=
 =?us-ascii?Q?3nlonG5fIKAy0cYJGJYN2mEC3F+sjueUIPqlsu7zPfLw3ytxAl1VvwLLlqwX?=
 =?us-ascii?Q?4uzNAoWJ9SereoGWQ988T5UUBvCDknOlXtj+JwP3Kz0pwEwfuDwnYtGT0P0U?=
 =?us-ascii?Q?RNik52/re9KSkgDokPMS5BfQZBN0EMRmN0VXQpBqMAE/888boeltjroZXapt?=
 =?us-ascii?Q?NKfL7d40z3BB2wrnluni+bPqSccbDvFpCBhj/wU+FmBw7iB+FIrmHDlkZVIP?=
 =?us-ascii?Q?1K8nMZwFkp9sRJMfSY04tQFntyUARFxNfo1IcPnq3YaEEjfwClBONT1kWApR?=
 =?us-ascii?Q?0IF8C6GvxmUljFP9ddAzd/NZ+pbBszXvDDsgGfYZYFTSyx5gANwC+Jw45YfD?=
 =?us-ascii?Q?lVrHYDNHxG23ymg+Wh8cRuQJfrf1e6n5gd9pwadxbuDS5uZ5hxXlEnzpm5B8?=
 =?us-ascii?Q?dYbHuJokiNus9P0r/Zt4jWbL/JjvoFyfybzIwR1lmLJ7vTI/vx13xKGG0ke/?=
 =?us-ascii?Q?Mcm0/6/3OaQoTSzD6pztpytYoN+fADXLw41taqUmBAZDTSBK?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb77f0d2-1867-4483-41ee-08de9448dd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 01:56:20.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmZaQ4kvo6VlBsomXLNY45C2rBo0XzFAmn5GeaECY/p7Q2+rHoeXzqD8Xm0CYZ+QqMeubRG5II9TJO1+CHlLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0634
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233485-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.363];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3EB73A8D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Thanks for the review.

  You are right that this is not limited to the SYN-ACK header-option paths=
.
  The same unguarded ctx->rtt_min access is reachable from request_sock-bac=
ked
  sock_ops invocations through tcp_call_bpf(), including BPF_SOCK_OPS_RWND_=
INIT,
  BPF_SOCK_OPS_TIMEOUT_INIT, and BPF_SOCK_OPS_NEEDS_ECN. I'll update the
  changelog to describe the affected paths more accurately.

  I also agree that this should not duplicate the existing guarded ctx-acce=
ss
  sequence. I'll rework the change to reuse a common helper/macro instead o=
f
  open-coding another copy, and I'll add a selftest as a subtest of [1] aft=
er
  [1] lands.

  Thanks,
  Werner

-----Original Message-----
From: Martin KaFai Lau <martin.lau@linux.dev>=20
Sent: Tuesday, 7 April 2026 11:26 AM
To: Werner Kasselman <werner@verivus.ai>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>; Alexei Starovoitov <ast@kernel.o=
rg>; Daniel Borkmann <daniel@iogearbox.net>; Andrii Nakryiko <andrii@kernel=
.org>; John Fastabend <john.fastabend@gmail.com>; David S. Miller <davem@da=
vemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kern=
el.org>; Paolo Abeni <pabeni@redhat.com>; Lawrence Brakmo <brakmo@fb.com>; =
bpf@vger.kernel.org; netdev@vger.kernel.org; stable@vger.kernel.org
Subject: Re: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min=
 access

On Mon, Apr 06, 2026 at 10:49:56PM +0000, Werner Kasselman wrote:
> sock_ops_convert_ctx_access() generates BPF instructions to inline=20
> context field accesses for BPF_PROG_TYPE_SOCK_OPS programs. For=20
> tcp_sock-specific fields like snd_cwnd, srtt_us, etc., it uses the
> SOCK_OPS_GET_TCP_SOCK_FIELD() macro which checks is_locked_tcp_sock=20
> and returns 0 when the socket is not a locked full TCP socket.
>=20
> However, the rtt_min field bypasses this guard entirely: it emits a=20
> raw two-instruction load sequence (load sk pointer, then load from=20
> tcp_sock->rtt_min offset) without checking is_locked_tcp_sock first.
>=20
> This is a problem because bpf_skops_hdr_opt_len() and
> bpf_skops_write_hdr_opt() in tcp_output.c set sock_ops.sk to a=20
> tcp_request_sock (cast from request_sock) during SYN-ACK processing,=20
> with is_fullsock=3D0 and is_locked_tcp_sock=3D0. If a SOCK_OPS program=20
> with BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG reads ctx->rtt_min in this=20
> callback, the generated code treats the tcp_request_sock pointer as a=20
> tcp_sock and reads at offsetof(struct tcp_sock, rtt_min) -- which is=20
> well past the end of the tcp_request_sock allocation, causing an=20
> out-of-bounds slab read.

This is not limited to hdr related CB flags.

It also happens to earlier CB flags that have a request_sock, such as BPF_S=
OCK_OPS_RWND_INIT.

>=20
> The rtt_min field was introduced in the same commit as the other=20
> tcp_sock fields but was given hand-rolled access code because it reads=20
> a sub-field (rtt_min.s[0].v, a minmax_sample) rather than a direct=20
> struct member, making it incompatible with the SOCK_OPS_GET_FIELD()=20
> macro. This hand-rolled code omitted the is_fullsock guard that the=20
> macro provides. The guard was later renamed to is_locked_tcp_sock in=20
> commit fd93eaffb3f9 ("bpf: Prevent unsafe access to the sock fields in th=
e BPF timestamping callback").
>=20
> Add the is_locked_tcp_sock guard to the rtt_min case, replicating the=20
> exact instruction pattern used by SOCK_OPS_GET_FIELD() including=20
> proper handling of the dst_reg=3D=3Dsrc_reg case with temp register=20
> save/restore. Use offsetof(struct minmax_sample, v) for the sub-field=20
> offset to match the style in bpf_tcp_sock_convert_ctx_access().
>=20
> Found via AST-based call-graph analysis using sqry.
>=20
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  net/core/filter.c | 47=20
> ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c index=20
> 78b548158fb0..58f0735b18d9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10830,13 +10830,54 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>  		BUILD_BUG_ON(sizeof(struct minmax) <
>  			     sizeof(struct minmax_sample));
> =20
> +		/* Unlike other tcp_sock fields that use
> +		 * SOCK_OPS_GET_TCP_SOCK_FIELD(), rtt_min requires a
> +		 * custom access pattern because it reads a sub-field
> +		 * (rtt_min.s[0].v) rather than a direct struct member.
> +		 * We must still guard the access with is_locked_tcp_sock
> +		 * to prevent an OOB read when sk points to a
> +		 * tcp_request_sock (e.g., during SYN-ACK processing via
> +		 * bpf_skops_hdr_opt_len/bpf_skops_write_hdr_opt).
> +		 */
> +		off =3D offsetof(struct tcp_sock, rtt_min) +
> +		      offsetof(struct minmax_sample, v);
> +	{
> +		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;
> +
> +		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)
> +			reg--;
> +		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)
> +			reg--;
> +		if (si->dst_reg =3D=3D si->src_reg) {
> +			*insn++ =3D BPF_STX_MEM(BPF_DW, si->src_reg, reg,
> +					  offsetof(struct bpf_sock_ops_kern,
> +					  temp));
> +			fullsock_reg =3D reg;
> +			jmp +=3D 2;
> +		}
> +		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +						struct bpf_sock_ops_kern,
> +						is_locked_tcp_sock),
> +				      fullsock_reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +					       is_locked_tcp_sock));
> +		*insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);
> +		if (si->dst_reg =3D=3D si->src_reg)
> +			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +				      temp));
>  		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
>  						struct bpf_sock_ops_kern, sk),
>  				      si->dst_reg, si->src_reg,
>  				      offsetof(struct bpf_sock_ops_kern, sk));
> -		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -				      offsetof(struct tcp_sock, rtt_min) +
> -				      sizeof_field(struct minmax_sample, t));
> +		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg, off);
> +		if (si->dst_reg =3D=3D si->src_reg) {
> +			*insn++ =3D BPF_JMP_A(1);
> +			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +				      temp));

There is an existing bug in this copy-and-paste codes [1] and now is repeat=
ed here, so please find a way to refactor it to be reusable instead of dupl=
icating it.

This also needs a test. It should be a subtest of [1], so [1] need to land =
first.

[1]: https://lore.kernel.org/bpf/20260406031330.187630-1-jiayuan.chen@linux=
.dev/

