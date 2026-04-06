Return-Path: <stable+bounces-233455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJGDI6E41GkksQcAu9opvQ
	(envelope-from <stable+bounces-233455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A4D3A7F12
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1A743023E29
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2939F16E;
	Mon,  6 Apr 2026 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="uJa8iOtm"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020075.outbound.protection.outlook.com [52.101.152.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B893372B48;
	Mon,  6 Apr 2026 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515803; cv=fail; b=lfNCxbpymSoQPoID9byRUqy1VJ5m75trJfnR919nZ5+uSL7Y6RbMLIm5+uyNjSjdtUbFQMOtdqU/Ha20ZgrkzMPFXEoAHywW3Y6BAm1FYZNpIsmyBeoe8ji0ZO6Eh9r6KIjTEnopQx2IJCOw3+6Cyyh/HlnQafjxzQTXmrmQRUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515803; c=relaxed/simple;
	bh=ZcVGtj6tGFR9D4FgfFdmYAEWbQk9d750/VMkmoOlOjo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JW8EJHzQozL+6luD2Bk3Lf+0QPbCuMg6PQypfiZQ7NFYIehk80FPx85X9hoVszVlG7TeeccC4Qh2c/MXeAUWMBZR3Es5Av84E+RH6ZFPPykRcEQvoFUtAk4encG9i+yZMYHK5mssqZe9YWbp5lcr8H7+ckqaLzHmFR1hga4lXn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=uJa8iOtm reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CshDoJYu+t/oc3UiEqL533gwSgAMdVdLCQhBevWml1IPPjAyEqDLGGlUcJZnFurSRofSohdoMu8UxMba5HS77cxrFxp2AnURCdXdApUGWw96Ffzp/5+IS8iMDod0u1LB/hP2oLgYrc7H5oUWgGyghYR5svJqT9b0MZ9xPq8Ww9ZQE9Ct/vhBM1KhdPiE5i896pBdlFB6wHM17IXH0FrGroK5L6wXsRN/2c3sLPwXbYA9w2Lh32dMvIu46/UC33jjTztNHQ24+2P4rT4p3OFqtgd+h6YDoop6BP2GDR5/NgldMnLIWudzsC9Nt/3O03QCQc80ojVCf7iRjNEPhM6VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99LY4AAsRETsefPJkeghVVztiBjmp4mVOlAlsSab5RU=;
 b=PfR7VHzluKJ9bqkyHf6N62Qz9Uo3opyQYWZ7wNMKEOMv+lvbUReYVZVn1QP4seZOYzPox74CgpfYUifQjS4W2plhNHx09k8UeJfLTRZ+s0jVpfYT9vqjSjot7UGDjPCuHsuuzClU1XGu5ZZsMytoVEgzz2Z948aJ3WRJfVlcBNSnWBmStvgvIoQiIXivz7M2EDH3Zjq3Jli/IDCdlpyrz80equ5SfA8IFTJe12TMTzVszwpS1F0+xlXcDY6axsNazJcJvYRghpplCi3tPmWXTvmmqG4GItf1Z4W/LhLKm262NgncsPjQcdjR+LhxgYwXFx0wAXLvK+BBQ8lbNSRNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99LY4AAsRETsefPJkeghVVztiBjmp4mVOlAlsSab5RU=;
 b=uJa8iOtm1fTPK+HRCfcuXQp5pu5ydYhbH4E+ph9xJt2Qdbs+x6p3V8f5C9cDYGE+kqxekVFOtPlW/Nk3oMn5hYi2NKb/xOCaddJw8+5zslJ1Dc3Ez3xO48NUaTTiU7Gqiz2C6zfzTKTpK9LMk+x3KXxkslwmQpR5bnTLsRJSW+Thr+3dDWnGt+U6/reKgZ1h7ieKVuGFPfZuaM4L0wdONDBsTXzWpFBzJ4gBs1sSj+Uk3yu3ISwevo0pwGW3UEahgzS4GWRuecYn5Jo0gnaVJj7kPw8RaVNTr4SpyoXHCjZRePuxMRduwdquDmV6sKV8fotjY0Wg9BOMPRd1jfh3BA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 22:49:56 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Mon, 6 Apr 2026
 22:49:56 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lawrence Brakmo <brakmo@fb.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min access
Thread-Topic: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min
 access
Thread-Index: AQHcxhewSrz8KO6SLEeqbn8DvXuOQA==
Date: Mon, 6 Apr 2026 22:49:56 +0000
Message-ID: <20260406224953.2787289-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: ef1c6304-f9d0-4052-bcd3-08de942ed301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 BGaGeuXK5LcGg4jRutPQ+Whb13pJ0Pff94c1vUOxBsg1gR1teN5DdokNxh0hLu00tJCIr9hkD+EbWbSrFSNXIa4AzLFsw38crVEKhwuF6+OTOqmyo8gOftVkFsUV/fAZ8glRCiuSN0fDc1Ay59UlGij0e+zk1yyiLdY8EcXqEMkQc4XrlGIX+GcAFqQxbsLx/tY4k6Prr4eh//q0ohhjwTM0H8X+FrgC98GXpdbZ4GeTjSM/BMgVFqTmxZmod44HFtYIqQBm/YUw5CSBvgsFTXy1uRzVkd9HIc9hAHAOlZDZaXyIAeqHWND+3AXlhQ0RmHJ2/KJIq2MDl+awj06kIiYgOSkyavpEcXemNUAsbYROYoKEWE4tFJ7nnLahXQlDacf7AVfX1T2Z/WcSqkkgV4F7PHxudSc8h1ZkXKDDgmIYaJoopNlo2BnRpb+UWzCS4mrWYKjyqvJcmgnqzRik/8DH7KgBjtsVPUAz8W9/uBVhHHmsqW3Ta7B/DLFqKDQOywt6fqsN8U33t+lsISJeY/xhEIaiYxD9uTm+YeZHEI0/NxH0fbkKNP7XskL/thjoYzzRLimGZXcxgfEtB9ptctwG3rOD+UcXH1M2R++2wdxUTSpIbRR7hUhepCchzanRzpSAs3v5NAWlukSSg6DFZ/orMg2zmC+lSHVuw1RxrxafWqBw8lQGd9NeMj1DqhZjDvN6KCkxQJKISTPz/ebxzRGq1+DFSuJEbIONtijEfHPfLZq4gVC6CtVHgtWY1lmLFU0TqZmeN9VKmgpaXuBi47zVRMXYVdGeNxEmVur++ZQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GPQgtexuVMxq+vUWxU85taAq2AtrF+69kL1p6Yup30k2siQUUyXHosSxJI?=
 =?iso-8859-1?Q?ufrA4BF7l1DIkmow15FQnEpotadYQ2kqNL/dwJpapj1D1uGwoSAcZoo2wE?=
 =?iso-8859-1?Q?3O/DbVsNg6jWIf6x3dNVbYwaUX6pFK6IOLassq6lufDarTxPQwMfNK4wyS?=
 =?iso-8859-1?Q?xwuGm65pBcSiGmrOy/gFvCm9iI3fSaSNns2Hl+NVFTJVPgZkcDk0iSgE4Q?=
 =?iso-8859-1?Q?IPUmiIlx/Z8DB0/pFLAoGjk5jRlVIWvh/Ztai73gfTdlfSzBwppYxFaNXd?=
 =?iso-8859-1?Q?Gjbbo6RHrLgTyejmkHTtNKforSfBpsaXHUSK83f7Ua1aqP2bWT9PGzoTsh?=
 =?iso-8859-1?Q?bCtU/xuYh8RcVwvPyj91nPOKW2Vz5tMbUwWiCqtQwYrshmg5qpdkxH3V3f?=
 =?iso-8859-1?Q?cnt/te1gfg/syL9nFScdSe3SnA0eEM7eAZZRgnfwvnk85LI/mQDjAEXDj3?=
 =?iso-8859-1?Q?8RDQyDXCEOwYqJ++73g8EM85Z3CAZ4VYGvLaHM5/hdoWs8ul5QE9VEeUeq?=
 =?iso-8859-1?Q?DfsOdPNE9K8DTrD7A3EdKT/YKV4TlMorX1kJp/LFuYwM3gHm81YJzXeWoY?=
 =?iso-8859-1?Q?YIGz5k/8NQo5mIfR/YRMZKaoYdCT+j2pLjH/eYT3IzdI1WgBK7W3YmKuJs?=
 =?iso-8859-1?Q?nJ+nM/Sg1CYH7xzQC7ZUzM9oH+DaCbCJNijvOvpXZQElufFtclxasLnJXh?=
 =?iso-8859-1?Q?a9wz3cGZjuMdH4iCT8usF6piGFjuunuDs2WTzyhgnE6SzW1ZYsB9IThobS?=
 =?iso-8859-1?Q?DSdKdcStUYKTGyFw1eOLU+12JvjmXb7pwdPcunaOBaMeEPIxgVwukkklEG?=
 =?iso-8859-1?Q?UxXeSV3+Xn6N4OF6mty8FMQ6TjOssodnNEGTAJq1Jioy/sLP5anSF8DZUu?=
 =?iso-8859-1?Q?pXYx+fdvbj7vs34pYnXn4MCQikfumMPT59OEJd5EJTmegtANDb7AjGZun8?=
 =?iso-8859-1?Q?h1fisXVJH5Yk0LMzoGdUq79lmSGSmHK+AXQS5+YNC96HZ65MKDgMXz8Y7v?=
 =?iso-8859-1?Q?WSCe7OAoJWFyTzfi/JmKJj0wP7ZBUqrISPtS/14omJYGhfMBGTGZnRXD8F?=
 =?iso-8859-1?Q?CymAvuxv3FodQ/QQsAcp/tIyh/R/rH9mfjK5FRLa7a/S0S1YieYQ9b9zBj?=
 =?iso-8859-1?Q?/O3vm1oXH4jyceeTu3La3UNxjVwMkWH4yPWC5ql7mu1cBKl7SUztjaNxGN?=
 =?iso-8859-1?Q?1VCJya70xnhJ5MRHKlDoZxC0owZCa5gGY1gfVkICyoNxByujG/rfzL07Rq?=
 =?iso-8859-1?Q?byc8Lmen521QJgPvjXUczGlyulOK2O66478jA/WimczuoJO12f/sD7nocy?=
 =?iso-8859-1?Q?EXH8O3gaahcqMY/KtvzSu4aRR3keDa7wG5SiZuM/cSoYXKMabDzVe+F/+W?=
 =?iso-8859-1?Q?YGvBnEyGBdNKa+apNhNuVQYguZfoaGu+S50cvoXptLJoUerrzfb9r5WOPt?=
 =?iso-8859-1?Q?42P3VPKG2HiBwfu0lu33SfbPsOWMWdDLeaW79SIRwT2HOsjkHYKPexARXn?=
 =?iso-8859-1?Q?vTAffv5B9ntCoajCCvr55QXYAJ0LwAZr/4MW7mlpYtAk2Ypie+YeDx+050?=
 =?iso-8859-1?Q?8nLG5W9RSJnrobSn8uP9dLdqBLAj0AuBNmeGRn4VacZ79u9GHctZOvOufW?=
 =?iso-8859-1?Q?xW8GWT3oGFwsZg9QAU8VHKHlbh1vERaWly54X5H0QhXaEyCCuuT8Y5W5jG?=
 =?iso-8859-1?Q?X+ufkZYQuBDsNcATP9n9eT8ZzIW4yjKxNHJnSGwIS/lK5mR58uI1BdTXtx?=
 =?iso-8859-1?Q?grsJ7q+XSDa9icN1uTt1jgZ5eVPtqPpOrnxAxirJBqOVRDrt+C5nKYpifU?=
 =?iso-8859-1?Q?CA/rs9cMrQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1c6304-f9d0-4052-bcd3-08de942ed301
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 22:49:56.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyujarsQbhA2fEcgcTa8rEMFdLS5oXnPTeJzcmcXTxmQBCRzD+R6oKUuIPGNSHPfNuLuxNA+rqQp+xXx03Ipfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233455-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fb.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.474];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,verivus.com:email,verivus.com:mid]
X-Rspamd-Queue-Id: C3A4D3A7F12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() generates BPF instructions to inline=0A=
context field accesses for BPF_PROG_TYPE_SOCK_OPS programs. For=0A=
tcp_sock-specific fields like snd_cwnd, srtt_us, etc., it uses the=0A=
SOCK_OPS_GET_TCP_SOCK_FIELD() macro which checks is_locked_tcp_sock=0A=
and returns 0 when the socket is not a locked full TCP socket.=0A=
=0A=
However, the rtt_min field bypasses this guard entirely: it emits a raw=0A=
two-instruction load sequence (load sk pointer, then load from=0A=
tcp_sock->rtt_min offset) without checking is_locked_tcp_sock first.=0A=
=0A=
This is a problem because bpf_skops_hdr_opt_len() and=0A=
bpf_skops_write_hdr_opt() in tcp_output.c set sock_ops.sk to a=0A=
tcp_request_sock (cast from request_sock) during SYN-ACK processing,=0A=
with is_fullsock=3D0 and is_locked_tcp_sock=3D0. If a SOCK_OPS program=0A=
with BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG reads ctx->rtt_min in this=0A=
callback, the generated code treats the tcp_request_sock pointer as a=0A=
tcp_sock and reads at offsetof(struct tcp_sock, rtt_min) -- which is=0A=
well past the end of the tcp_request_sock allocation, causing an=0A=
out-of-bounds slab read.=0A=
=0A=
The rtt_min field was introduced in the same commit as the other=0A=
tcp_sock fields but was given hand-rolled access code because it reads=0A=
a sub-field (rtt_min.s[0].v, a minmax_sample) rather than a direct=0A=
struct member, making it incompatible with the SOCK_OPS_GET_FIELD()=0A=
macro. This hand-rolled code omitted the is_fullsock guard that the=0A=
macro provides. The guard was later renamed to is_locked_tcp_sock in=0A=
commit fd93eaffb3f9 ("bpf: Prevent unsafe access to the sock fields in the =
BPF timestamping callback").=0A=
=0A=
Add the is_locked_tcp_sock guard to the rtt_min case, replicating the=0A=
exact instruction pattern used by SOCK_OPS_GET_FIELD() including=0A=
proper handling of the dst_reg=3D=3Dsrc_reg case with temp register=0A=
save/restore. Use offsetof(struct minmax_sample, v) for the sub-field=0A=
offset to match the style in bpf_tcp_sock_convert_ctx_access().=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 44 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 78b548158fb0..58f0735b18d9 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10830,13 +10830,54 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
 			     sizeof(struct minmax_sample));=0A=
 =0A=
+		/* Unlike other tcp_sock fields that use=0A=
+		 * SOCK_OPS_GET_TCP_SOCK_FIELD(), rtt_min requires a=0A=
+		 * custom access pattern because it reads a sub-field=0A=
+		 * (rtt_min.s[0].v) rather than a direct struct member.=0A=
+		 * We must still guard the access with is_locked_tcp_sock=0A=
+		 * to prevent an OOB read when sk points to a=0A=
+		 * tcp_request_sock (e.g., during SYN-ACK processing via=0A=
+		 * bpf_skops_hdr_opt_len/bpf_skops_write_hdr_opt).=0A=
+		 */=0A=
+		off =3D offsetof(struct tcp_sock, rtt_min) +=0A=
+		      offsetof(struct minmax_sample, v);=0A=
+	{=0A=
+		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;=0A=
+=0A=
+		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)=0A=
+			reg--;=0A=
+		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)=0A=
+			reg--;=0A=
+		if (si->dst_reg =3D=3D si->src_reg) {=0A=
+			*insn++ =3D BPF_STX_MEM(BPF_DW, si->src_reg, reg,=0A=
+					  offsetof(struct bpf_sock_ops_kern,=0A=
+					  temp));=0A=
+			fullsock_reg =3D reg;=0A=
+			jmp +=3D 2;=0A=
+		}=0A=
+		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
+						struct bpf_sock_ops_kern,=0A=
+						is_locked_tcp_sock),=0A=
+				      fullsock_reg, si->src_reg,=0A=
+				      offsetof(struct bpf_sock_ops_kern,=0A=
+					       is_locked_tcp_sock));=0A=
+		*insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);=0A=
+		if (si->dst_reg =3D=3D si->src_reg)=0A=
+			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=0A=
+				      offsetof(struct bpf_sock_ops_kern,=0A=
+				      temp));=0A=
 		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
 						struct bpf_sock_ops_kern, sk),=0A=
 				      si->dst_reg, si->src_reg,=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
-				      offsetof(struct tcp_sock, rtt_min) +=0A=
-				      sizeof_field(struct minmax_sample, t));=0A=
+		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg, off);=0A=
+		if (si->dst_reg =3D=3D si->src_reg) {=0A=
+			*insn++ =3D BPF_JMP_A(1);=0A=
+			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=0A=
+				      offsetof(struct bpf_sock_ops_kern,=0A=
+				      temp));=0A=
+		}=0A=
+	}=0A=
 		break;=0A=
 =0A=
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):=0A=
-- =0A=
2.43.0=0A=
=0A=

