Return-Path: <stable+bounces-240011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOBpGNil5mlPzQEAu9opvQ
	(envelope-from <stable+bounces-240011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2E4348B7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D183019048
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581B3CFF7D;
	Mon, 20 Apr 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="QEF30UNs"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022143.outbound.protection.outlook.com [40.107.40.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C9388E6E;
	Mon, 20 Apr 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723393; cv=fail; b=tNVmIXo0psRT52gCnSponxdeLAgKdrhjDzcIfTrJhdtcxYYFQbToUfv5R0UQ/hkonaSNGbMFyrRWGENZQ7J4OIw6Cn3FNNXnnkDaz2Kz60IcbjBTNHbh6hmmqNKBwugOLd4SEJaaWShH8nxcbdWLGIt7Fmai+v7xphVndPnFEiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723393; c=relaxed/simple;
	bh=9si/hUQUEIerigheTb0UDY40SiaQFH98KGlN8M4iArE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gFgmMFPVlCusk+GzNM49P4bSKq/1Kbhku4gZ2ykM0biAi2LBvfbqUjM8HzHNWgZbkfYpjN5Lb7iILEdhYU1T1b4XslRVyH/oGOWMkhkji3BjgEKg4q6WPTJc1zjTdy8j0IhXR999uUn7jWjyrF3W5SRs3MIGNGapHN1sVP2NQdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=QEF30UNs reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ7fBcc4H1xuivW8vuwfpKqwmewci8JfQmLS0/v3oeM0XOM16T3e1iB3DIHyq0B3FFbFswtj5fOOjF/XalI1QcE1AOT+gWwXKZ3omJMiphBT7Q9TPhCL9K0MCdkKki58cErDoLB8VdW6fB8t+jmf/bNge2vph5ZztEueKN3ARITQ014CnNEtufuUqQ/ZTutiQcd1daUQvi38zCHEG8E8cKnYJ+FbbO936+3ad28PcupLk72g9rgbo4+DDf6503T148pWcGl2WMy+zazEWtTjPJA786Mxa2xrp/T3gmjXObsvWgNcchr5hdVAPBbRzgjlFQ4UQGjjIRBoNu6JKrVVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM6QZluXYCXekGEAvst0o0fj+Qdmc7rpn2LFFXh62y8=;
 b=C7sHODe4iTP8f4JqcXC6TmhbRrKFxZgrnhoDA2UGLx/T/jmdxoIl9UttbQ/694C+cnWNvWnaDSXBEZVstfxFy7GIZeI0RVHseCET6J3Thvlmreb+UUBNq3pX4bE9eXA4wnfdNeQ30iqJddECBKiOJf6KW7vapyCmPSbYNZt+HHL24vtHhA8Gtgkfad0mTZN33Y1ErcenVr/mljYHhP0pN/bQ9l36I+kEJsbfrLQij5naoLwl0BfEBcXfjvZw2T5snZbj9o43smV7hE87b9bjbmhJlrx1VExNNpmCrPbEwy3gWp46o1Jw/bBOIlCeU1z2LFfZjSdq5gr5syDkTlfwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM6QZluXYCXekGEAvst0o0fj+Qdmc7rpn2LFFXh62y8=;
 b=QEF30UNsg0+HbbuGaLxQAYkKyQ4jtWk18ENXQrZpcwfPKs22D5aecuJWnXGzljTI+1ZLBkErvSx0pkAiGGDosFQDigq7o/a2ANlxBg5ik5LqBHfZyEqr9y6EaqxFroVVJZYZFykFld44DfWVW8gJDyWhiJbiybUHeHm9TFtzuP7MXKm7ahuv9Vf8WMDCNAgOPG2KtUvcaYLugXlD4/CQbRJ2PyTNynTC3shvVJ7EGMMAuNLjjGTX1P68ENJELMe9CyVBrmnz8Wr8w7lurDdl/StcoV0RukeoADG0cjFf/GROvtEhdb1ozyvOIba6XdKXPrtNO0a6TbsQ9D3V1JqXXA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY8P300MB0061.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 22:16:26 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 22:16:26 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Werner Kasselman <werner@verivus.ai>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Lawrence Brakmo
	<brakmo@fb.com>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf v4 1/2] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Topic: [PATCH bpf v4 1/2] bpf: guard sock_ops rtt_min against
 non-locked tcp_sock
Thread-Index: AQHc0RNUqxD+Ko7JfUqcyRkwcJe6Zw==
Date: Mon, 20 Apr 2026 22:16:26 +0000
Message-ID: <20260420221621.1441707-2-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420221621.1441707-1-werner@verivus.com>
In-Reply-To: <20260420221621.1441707-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY8P300MB0061:EE_
x-ms-office365-filtering-correlation-id: 5b10deaa-4c68-4d0a-2f4e-08de9f2a76f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 lYUM32PBvRChW9h+0DTZqMIZg4gCMGgN5MJQMrwhmPq2rxtyVYBpCnojesUsARZ2uplCIH9prHM6/pqNDdzpJ2K/jE70eSSnB9O9hSBC/8EL8ONRddiq67F6RYNTTG40N2mZIV5QL/eNmbPb/yI4uHAWYXGDziac5ivQmcrrSTAfEcELhxxi5Az8ZCq6iUWfgAmlOLxwcwveiheHw/OhlmxZQFMDFivF9L/owxNrSlGPRG8+Qq5JRMmvsVBjp1PAllFql2Y75BOf3RZBGLlnq1mO9vkdfTRwdpyNM2BJwTKyXcaLicFlzEm3PMYszBiAoIlT5SBBJ9q5YRpVMIJ/SjZ7PDqvhSeNNDmWNgqqYnoSf3r5lkgVyMk1yBLNoTNN4+9YOZ1PgaSYjMx+2bCG4PykgLvhKbLmT5+VQa8q3AKf6SAAKJSGKwkDAfJcsD2+M6Y6jHW29JaNKmlt9atYZibS4OGx482x9ooNZUebRaTY2ryMWUzIiBKqzxv8EMsaenJqM2eKI1hOaTL+afSy6bsBdQFAjQthesNn6F9zumljmZv452KtZ46DOptM/6+surwzNCH0tmDNSNIK4gw+qahDRwJVTh3ypOv10T6IkDJqojUEeu7R00bNjn24PSvcFAIes+SxoQwwBqbnF6oBSF/IMRFkbpqAepqrDeclpP7l3jL5L6XJIMv98ECxsTKVqLkBHyxOOOKCiNboUdplm31OF+fxxxnWVjKQpheToQQ+PcGqw5AvMH5MrnjsjBuOdvfVj9TUKdIgyLbWB8vQnxw7pN+lGx9+48aEeoQQ42U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XuxY/+dAK+X0VlDHnyJSL9Q9ZihT5rnJfF+CYl98nhUaJXxLJuIDgSeAzE?=
 =?iso-8859-1?Q?2AXhE1SRtyNLPPxBUJJYacqpIcpDXr+fOSvivP3Nf+vZuUETdvwX5z+Idg?=
 =?iso-8859-1?Q?XTUja7rk2ufZNz/o3Cwmhuz78FUz7SJ5FiMaIogzapk8C0qyjWzRBFeVNZ?=
 =?iso-8859-1?Q?qYPIMbfSa37xp3fbVrUsq8IZsTOlktIzuAce0WnQlosVLFgu3nA2iT78ZH?=
 =?iso-8859-1?Q?jcdpQLsWcROEHAr23BMQdtSotOjNGCnKxyC6tFZNb350J4/hMt8Yve6A6j?=
 =?iso-8859-1?Q?GUsFoWlNwS7JeD+MoFjxbPuXgOHMhLX0UKFD2C+bhR4hTsze57E1Ujj4ib?=
 =?iso-8859-1?Q?vE2Q78MMeau49N5hC2J0JNDDK+ULHDuSdk3bTYE2h602nG4jcAVtocx1If?=
 =?iso-8859-1?Q?81gO7+9GVwUH6ay1VCC/UATVZoqw0JnLD8GYYbqYN+yi6eufN+QHK4El2x?=
 =?iso-8859-1?Q?vj/e4/eYCIjI+rzCQtAmNe5nZp6u3PsG3zPxm4HpStpKvyZqxjqRdUcCeX?=
 =?iso-8859-1?Q?EXwyyUe43U4OWrb6zJIKLdG2vuXMjpnALFcaF644cxJsVfeDEPL7/QRBaG?=
 =?iso-8859-1?Q?01P8kKK9Eb5lzDLLStAqrfQCh4sC9GiS+L4vSWAGNR4VWMcylMGf3ZVFea?=
 =?iso-8859-1?Q?R+toasvGqc1Yxz/2GZxmtAmWD4NnbJ0bcX+mFAsdkN/WW6SUgoQPOnLT18?=
 =?iso-8859-1?Q?+gIxH5ofPeNwjMvg4saLMGXqQSglwtpoIZ8ovJ+CsNvrgETNrQT9LhAVeh?=
 =?iso-8859-1?Q?hCIx+UxPyoekwoaSKjb/ttr+/Chm0HheI+0YHyIX6giVytzJ+QyfYO7Chy?=
 =?iso-8859-1?Q?7xmcTAryinc4GD7VqQSh9r2sNZM9jX6ql5T63pCuIf2PArf6Fp0utUcjNV?=
 =?iso-8859-1?Q?widKYP6zSmh6Gj1sb8HnSTJ644IoQgKgjpzUrTDg91MIkvZy98IC+ai8Qn?=
 =?iso-8859-1?Q?V00o30YVELuyYFzDpk9TMvA4TpVWPnyqxVgkVkLzUA6159UWNeCTs9FMoh?=
 =?iso-8859-1?Q?7M5WttO2gutWwXhSf+cdC/kGLryQ5U1siTgsox3w/hByDxuDj1OIYkJWEt?=
 =?iso-8859-1?Q?MH0jRHIv8nwT2+vjC6eIm9rRN0T/fGkYAfCxH/RbKjq2HE8isVJHBrIvvU?=
 =?iso-8859-1?Q?o10zRHn6wicCotiHbwoLUuSQZ+PBZUrP2hzrsbZerUaJQb8tqiceiGBzqc?=
 =?iso-8859-1?Q?gBC/T9dxdK6T2PNGWe5plKveAvqWJVRV/GRgwZeCAdW7KRXeKorqlQ4cYv?=
 =?iso-8859-1?Q?mKLthL9yCoYQ09dwg6b/S+n/LraGUEPe0ofsMFpgJ5sUSywtdX6Igi6p27?=
 =?iso-8859-1?Q?nMwb2Hfhe39Loi/i7qhDFRmWp90xovZ65YLWZ0cYKbH73hXJi3+VZN/piG?=
 =?iso-8859-1?Q?iDJfRuw3J6ItH4nAtLj6LXW6DLh8+gzIfSWKJnYbYnSwyFKWIIYrCrR8zu?=
 =?iso-8859-1?Q?2ooj9CW6xZ1/gJCP7yBzRzb0SArl/yOJXgvNR7rPSUrSY5eyW/TGrHA+Q5?=
 =?iso-8859-1?Q?C//jwguqxf8b9HZsKzqEHfyv5faa0FgnUCpwcbQVKgnWMxaM9BDTZtkILc?=
 =?iso-8859-1?Q?kf5nvy094GzeHcbtGq42KILJWS1bMYjWyTyWoPCs/L6SwwS6X8zg7rUkcJ?=
 =?iso-8859-1?Q?ZyeACKQi+PfW0h6K3Zk1YoCWFhE/ncys7RJRPCEqJqpSnrTofbjHlTuDd5?=
 =?iso-8859-1?Q?oA3aOrjJoetzoKlF1BOYrnLzebg4olErsX8+C+DeICC7JkpzfgHJKlz3wc?=
 =?iso-8859-1?Q?CvkTJIksmoHmvEY6sKEzP960nWSwoedZ5mgq1DeyvL7ebQkRM7Cdn3vN7O?=
 =?iso-8859-1?Q?a/3mKD1/Zw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b10deaa-4c68-4d0a-2f4e-08de9f2a76f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 22:16:26.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2g9ZiX4V2UDNm7YwrRJNUyD35qJQt2UeLionWK4RTkUbOcU0w/CB81j7mPz5wn0SaTBktrTH8SAKL5uuIP2X5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0061
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-240011-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[verivus.ai,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,verivus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03B2E4348B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() reads rtt_min without the=0A=
is_locked_tcp_sock guard used for every other tcp_sock field. On=0A=
request_sock-backed sock_ops callbacks, sk points at a=0A=
tcp_request_sock and the converted load reads past the end of the=0A=
allocation.=0A=
=0A=
Extract the guarded tcp_sock field load sequence into=0A=
SOCK_OPS_LOAD_TCP_SOCK_FIELD() and use it for the rtt_min access after=0A=
computing the sub-field offset with offsetof(struct minmax_sample, v).=0A=
Reusing the shared helper keeps rtt_min aligned with the other guarded=0A=
tcp_sock field loads and preserves the dst_reg =3D=3D src_reg failure path=
=0A=
that zeros the destination register when the guard fails.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
net/core/filter.c | 39 ++++++++++++++++++++-------------------=0A=
 1 file changed, 20 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 78b548158fb0..b60f279c004a 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10544,12 +10544,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 	struct bpf_insn *insn =3D insn_buf;=0A=
 	int off;=0A=
 =0A=
-/* Helper macro for adding read access to tcp_sock or sock fields. */=0A=
-#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+/* Helper macro for adding guarded read access to tcp_sock fields. */=0A=
+#define SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE, FIELD_OFFSET)		      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;     \=0A=
-		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
-			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
 			reg--;						      \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
@@ -10557,7 +10555,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_acc=
ess_type type,=0A=
 		if (si->dst_reg =3D=3D si->src_reg) {			      \=0A=
 			*insn++ =3D BPF_STX_MEM(BPF_DW, si->src_reg, reg,	      \=0A=
 					  offsetof(struct bpf_sock_ops_kern,  \=0A=
-					  temp));			      \=0A=
+						   temp));		      \=0A=
 			fullsock_reg =3D reg;				      \=0A=
 			jmp +=3D 2;					      \=0A=
 		}							      \=0A=
@@ -10571,23 +10569,31 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 		if (si->dst_reg =3D=3D si->src_reg)				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
-				      temp));				      \=0A=
+					       temp));			      \=0A=
 		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(			      \=0A=
 						struct bpf_sock_ops_kern, sk),\=0A=
 				      si->dst_reg, si->src_reg,		      \=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));\=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(OBJ,		      \=0A=
-						       OBJ_FIELD),	      \=0A=
+		*insn++ =3D BPF_LDX_MEM(FIELD_SIZE,			      \=0A=
 				      si->dst_reg, si->dst_reg,		      \=0A=
-				      offsetof(OBJ, OBJ_FIELD));	      \=0A=
+				      FIELD_OFFSET);			      \=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
-			*insn++ =3D BPF_JMP_A(1);				      \=0A=
+			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
 				      offsetof(struct bpf_sock_ops_kern,      \=0A=
-				      temp));				      \=0A=
+					       temp));			      \=0A=
+			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
+#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+	do {								      \=0A=
+		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
+			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD),\=0A=
+					     offsetof(OBJ, OBJ_FIELD));       \=0A=
+	} while (0)=0A=
+=0A=
 #define SOCK_OPS_GET_SK()							      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 1;     \=0A=
@@ -10829,14 +10835,9 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 			     sizeof(struct minmax));=0A=
 		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
 			     sizeof(struct minmax_sample));=0A=
-=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
-						struct bpf_sock_ops_kern, sk),=0A=
-				      si->dst_reg, si->src_reg,=0A=
-				      offsetof(struct bpf_sock_ops_kern, sk));=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
-				      offsetof(struct tcp_sock, rtt_min) +=0A=
-				      sizeof_field(struct minmax_sample, t));=0A=
+		off =3D offsetof(struct tcp_sock, rtt_min) +=0A=
+		      offsetof(struct minmax_sample, v);=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_W, off);=0A=
 		break;=0A=
 =0A=
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):=0A=
-- =0A=
2.43.0=0A=

